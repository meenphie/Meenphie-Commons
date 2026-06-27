// Made with Amplify Shader Editor v1.9.9.10
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/FX/Refraction Probe"
{
	Properties
	{
		[NoScaleOffset][SingleLineTexture] _BumpMap( "Normal", 2D ) = "bump" {}
		_Roughness( "Roughness", Range( 0, 1 ) ) = 0
		_SingularityRadius( "Singularity Radius", Range( 0, 1 ) ) = 0
		_HorizonSoftness( "Horizon Softness", Range( 0, 1 ) ) = 0
		_LensStrength( "Lens Strength", Range( 0, 1 ) ) = 0.03
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0

	}

	SubShader
	{
		

		

		Tags { "RenderType"="Transparent" "Queue"="Transparent" }

	LOD 0

		ZWrite On
		Cull Back
		AlphaToMask Off
		ColorMask RGBA
		Blend One Zero, One Zero
		BlendOp Add, Add

		

		Blend One Zero, One Zero
		BlendOp Add, Add
		

		CGINCLUDE
			#pragma target 3.5
			// ensure rendering platforms toggle list is visible

			float4 ComputeClipSpacePosition( float2 screenPosNorm, float deviceDepth )
			{
				float4 positionCS = float4( screenPosNorm * 2.0 - 1.0, deviceDepth, 1.0 );
			#if UNITY_UV_STARTS_AT_TOP
				positionCS.y = -positionCS.y;
			#endif
				return positionCS;
			}
		ENDCG

		
		Pass
		{
			
			Name "Unlit"
			Tags { "LightMode"="ForwardBase" }

			Cull Off
			ZWrite Off
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA
			Blend SrcAlpha OneMinusSrcAlpha
			BlendOp Add, Add

			

			CGPROGRAM
				#define ASE_SURFACE_TRANSPARENT
				#define ASE_VERSION 19910

				#pragma vertex vert
				#pragma fragment frag
				#pragma multi_compile_instancing
				#include "UnityCG.cginc"

				#include "Packages/com.meenphie.commons/Commons/Shaders/Custom Expressions/BlackHole.cginc"
				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#define ASE_NEEDS_VERT_TANGENT
				#define ASE_NEEDS_VERT_NORMAL
				#pragma shader_feature_local_fragment _BUMPMAP


				#if defined(ASE_WRITE_DEPTH_CONSERVATIVE) && (SHADER_TARGET >= 45)
					#define ASE_SV_DEPTH SV_DepthLessEqual
					#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
				#else
					#define ASE_SV_DEPTH SV_Depth
					#define ASE_SV_POSITION_QUALIFIERS
				#endif

				struct appdata
				{
					float4 vertex : POSITION;
					float3 normal : NORMAL;
					float4 tangent : TANGENT;
					float4 ase_texcoord : TEXCOORD0;
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct v2f
				{
					ASE_SV_POSITION_QUALIFIERS float4 pos : SV_POSITION;
					float4 ase_texcoord : TEXCOORD0;
					float4 ase_texcoord1 : TEXCOORD1;
					float4 ase_texcoord2 : TEXCOORD2;
					float4 ase_texcoord3 : TEXCOORD3;
					float4 ase_texcoord4 : TEXCOORD4;
					UNITY_VERTEX_INPUT_INSTANCE_ID
					UNITY_VERTEX_OUTPUT_STEREO
				};

				uniform sampler2D _BumpMap;
				uniform float _SingularityRadius;
				uniform float _LensStrength;
				uniform float _HorizonSoftness;
				uniform float _Roughness;


				
				v2f vert( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					o.ase_texcoord.xyz = ase_positionWS;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					o.ase_texcoord2.xyz = ase_tangentWS;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					o.ase_texcoord3.xyz = ase_normalWS;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					o.ase_texcoord4.xyz = ase_bitangentWS;
					
					o.ase_texcoord1.xy = v.ase_texcoord.xy;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord.w = 0;
					o.ase_texcoord1.zw = 0;
					o.ase_texcoord2.w = 0;
					o.ase_texcoord3.w = 0;
					o.ase_texcoord4.w = 0;

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = defaultVertexValue;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = v.normal;
					v.tangent = v.tangent;

					o.pos = UnityObjectToClipPos( v.vertex );

					#if defined( ASE_SHADOWS )
						UNITY_TRANSFER_SHADOW( o, v.texcoord );
					#endif
					return o;
				}

				half4 frag( v2f IN 
							#if defined( ASE_WRITE_DEPTH )
								, out float outputDepth : SV_Depth
							#endif
				) : SV_Target
				{
					UNITY_SETUP_INSTANCE_ID( IN );
					UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

					float4 ScreenPosNorm = float4( IN.pos.xy * ( _ScreenParams.zw - 1.0 ), IN.pos.zw );
					float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, IN.pos.z ) * IN.pos.w;
					float4 ScreenPos = ComputeScreenPos( ClipPos );

					float3 ase_positionWS = IN.ase_texcoord.xyz;
					float3 WorldPos263 = ase_positionWS;
					float2 uv_BumpMap45 = IN.ase_texcoord1.xy;
					#ifdef _BUMPMAP
					float3 staticSwitch43 = UnpackNormal( tex2D( _BumpMap, uv_BumpMap45 ) );
					#else
					float3 staticSwitch43 = float3( 0, 0, 1 );
					#endif
					float3 ase_tangentWS = IN.ase_texcoord2.xyz;
					float3 ase_normalWS = IN.ase_texcoord3.xyz;
					float3 ase_bitangentWS = IN.ase_texcoord4.xyz;
					float3 tanToWorld0 = float3( ase_tangentWS.x, ase_bitangentWS.x, ase_normalWS.x );
					float3 tanToWorld1 = float3( ase_tangentWS.y, ase_bitangentWS.y, ase_normalWS.y );
					float3 tanToWorld2 = float3( ase_tangentWS.z, ase_bitangentWS.z, ase_normalWS.z );
					float3 tanNormal62 = staticSwitch43;
					float3 worldNormal62 = normalize( float3( dot( tanToWorld0, tanNormal62 ), dot( tanToWorld1, tanNormal62 ), dot( tanToWorld2, tanNormal62 ) ) );
					float3 World_Normal63 = worldNormal62;
					float3 WorldNormal263 = World_Normal63;
					float SingularityRadius263 = _SingularityRadius;
					float LensStrength263 = _LensStrength;
					float HorizonSoftness263 = _HorizonSoftness;
					float Roughness263 = _Roughness;
					float4 localBlackhole263 = Blackhole( WorldPos263 , WorldNormal263 , SingularityRadius263 , LensStrength263 , HorizonSoftness263 , Roughness263 );
					float4 saferPower273 = abs( localBlackhole263 );
					float4 temp_cast_0 = (1.5).xxxx;
					float4 temp_output_279_0 = ( pow( saferPower273 , temp_cast_0 ) * 3.0 );
					

					float3 Color = (temp_output_279_0).xyz;
					float Alpha = saturate( (temp_output_279_0).w );
					half AlphaClipThreshold = 0.5;
					half AlphaClipThresholdShadow = 0.5;

					#if defined( ASE_WRITE_DEPTH )
						outputDepth = IN.pos.z;
					#endif

					#ifdef _ALPHATEST_ON
						clip( Alpha - AlphaClipThreshold );
					#endif

				#if defined( ASE_SURFACE_TRANSPARENT ) || defined( ASE_OPAQUE_KEEP_ALPHA )
					return half4( Color, Alpha );
				#else
					return half4( Color, 1.0 );
				#endif
				}
			ENDCG
		}

		
		Pass
		{
			
			Name "ShadowCaster"
			Tags { "LightMode"="ShadowCaster" }

			ZWrite On
			ZTest LEqual
			AlphaToMask Off

			CGPROGRAM
				#define ASE_SURFACE_TRANSPARENT
				#define ASE_VERSION 19910

				#pragma vertex vert
				#pragma fragment frag
				#pragma multi_compile_shadowcaster
				#ifndef UNITY_PASS_SHADOWCASTER
					#define UNITY_PASS_SHADOWCASTER
				#endif
				#include "UnityCG.cginc"

				#include "Packages/com.meenphie.commons/Commons/Shaders/Custom Expressions/BlackHole.cginc"
				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#define ASE_NEEDS_VERT_TANGENT
				#define ASE_NEEDS_VERT_NORMAL
				#pragma shader_feature_local_fragment _BUMPMAP


				#if defined(ASE_WRITE_DEPTH_CONSERVATIVE) && (SHADER_TARGET >= 45)
					#define ASE_SV_DEPTH SV_DepthLessEqual
					#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
				#else
					#define ASE_SV_DEPTH SV_Depth
					#define ASE_SV_POSITION_QUALIFIERS
				#endif

				struct appdata
				{
					float4 vertex : POSITION;
					float3 normal : NORMAL;
					float4 tangent : TANGENT;
					float4 ase_texcoord : TEXCOORD0;
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct v2f
				{
					ASE_SV_POSITION_QUALIFIERS UNITY_POSITION( pos );
					V2F_SHADOW_CASTER_NOPOS
					float4 ase_texcoord1 : TEXCOORD1;
					float4 ase_texcoord2 : TEXCOORD2;
					float4 ase_texcoord3 : TEXCOORD3;
					float4 ase_texcoord4 : TEXCOORD4;
					float4 ase_texcoord5 : TEXCOORD5;
					UNITY_VERTEX_INPUT_INSTANCE_ID
					UNITY_VERTEX_OUTPUT_STEREO
				};

				#ifdef UNITY_STANDARD_USE_DITHER_MASK
					sampler3D _DitherMaskLOD;
				#endif

				uniform sampler2D _BumpMap;
				uniform float _SingularityRadius;
				uniform float _LensStrength;
				uniform float _HorizonSoftness;
				uniform float _Roughness;


				
				v2f vert( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID( v );
					v2f o;
					UNITY_INITIALIZE_OUTPUT( v2f, o );
					UNITY_TRANSFER_INSTANCE_ID( v, o );
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );

					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					o.ase_texcoord1.xyz = ase_positionWS;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					o.ase_texcoord3.xyz = ase_tangentWS;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					o.ase_texcoord4.xyz = ase_normalWS;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					o.ase_texcoord5.xyz = ase_bitangentWS;
					
					o.ase_texcoord2.xy = v.ase_texcoord.xy;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord1.w = 0;
					o.ase_texcoord2.zw = 0;
					o.ase_texcoord3.w = 0;
					o.ase_texcoord4.w = 0;
					o.ase_texcoord5.w = 0;

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = defaultVertexValue;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = v.normal;
					v.tangent = v.tangent;

					TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
					return o;
				}

				half4 frag( v2f IN 
							#if defined( ASE_WRITE_DEPTH )
								, out float outputDepth : SV_Depth
							#endif
							) : SV_Target
				{
					UNITY_SETUP_INSTANCE_ID(IN);

					#ifdef LOD_FADE_CROSSFADE
						UNITY_APPLY_DITHER_CROSSFADE(IN.pos.xy);
					#endif

					float3 ase_positionWS = IN.ase_texcoord1.xyz;
					float3 WorldPos263 = ase_positionWS;
					float2 uv_BumpMap45 = IN.ase_texcoord2.xy;
					#ifdef _BUMPMAP
					float3 staticSwitch43 = UnpackNormal( tex2D( _BumpMap, uv_BumpMap45 ) );
					#else
					float3 staticSwitch43 = float3( 0, 0, 1 );
					#endif
					float3 ase_tangentWS = IN.ase_texcoord3.xyz;
					float3 ase_normalWS = IN.ase_texcoord4.xyz;
					float3 ase_bitangentWS = IN.ase_texcoord5.xyz;
					float3 tanToWorld0 = float3( ase_tangentWS.x, ase_bitangentWS.x, ase_normalWS.x );
					float3 tanToWorld1 = float3( ase_tangentWS.y, ase_bitangentWS.y, ase_normalWS.y );
					float3 tanToWorld2 = float3( ase_tangentWS.z, ase_bitangentWS.z, ase_normalWS.z );
					float3 tanNormal62 = staticSwitch43;
					float3 worldNormal62 = normalize( float3( dot( tanToWorld0, tanNormal62 ), dot( tanToWorld1, tanNormal62 ), dot( tanToWorld2, tanNormal62 ) ) );
					float3 World_Normal63 = worldNormal62;
					float3 WorldNormal263 = World_Normal63;
					float SingularityRadius263 = _SingularityRadius;
					float LensStrength263 = _LensStrength;
					float HorizonSoftness263 = _HorizonSoftness;
					float Roughness263 = _Roughness;
					float4 localBlackhole263 = Blackhole( WorldPos263 , WorldNormal263 , SingularityRadius263 , LensStrength263 , HorizonSoftness263 , Roughness263 );
					float4 saferPower273 = abs( localBlackhole263 );
					float4 temp_cast_0 = (1.5).xxxx;
					float4 temp_output_279_0 = ( pow( saferPower273 , temp_cast_0 ) * 3.0 );
					

					float Alpha = saturate( (temp_output_279_0).w );
					half AlphaClipThreshold = 0.5;
					half AlphaClipThresholdShadow = 0.5;

					#if defined( ASE_WRITE_DEPTH )
						outputDepth = IN.pos.z;
					#endif

					#ifdef _ALPHATEST_SHADOW_ON
						if (unity_LightShadowBias.z != 0.0)
							clip(Alpha - AlphaClipThresholdShadow);
						#ifdef _ALPHATEST_ON
						else
							clip(Alpha - AlphaClipThreshold);
						#endif
					#else
						#ifdef _ALPHATEST_ON
							clip(Alpha - AlphaClipThreshold);
						#endif
					#endif

					#ifdef UNITY_STANDARD_USE_DITHER_MASK
						half alphaRef = tex3D(_DitherMaskLOD, float3(IN.pos.xy*0.25,Alpha*0.9375)).a;
						clip(alphaRef - 0.01);
					#endif

					SHADOW_CASTER_FRAGMENT(IN)
				}
			ENDCG
		}
		
	}
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
	
	Fallback Off
}
/*ASEBEGIN
Version=19910
{"type":"AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor","id":45,"pos":[-2432,256],"params":["Inherit","True","Property","_BumpMap","Normal","0","2","[NoScaleOffset]","[SingleLineTexture]","Create","False","0","0","0","False","0","False","","-1","None","None","True","0","True","bump","Auto","True","Object","-1","Auto","Texture2D","True","8","0","SAMPLER2D","","False","1","FLOAT2","0,0","False","2","FLOAT","0","False","3","FLOAT2","0,0","False","4","FLOAT2","0,0","False","5","FLOAT","1","False","6","FLOAT","0","False","7","SAMPLERSTATE","","False","6","FLOAT3","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4","FLOAT3","5"]}
{"type":"AmplifyShaderEditor.Vector3Node, AmplifyShaderEditor","id":44,"pos":[-2336,96],"params":["Inherit","False","Constant","_Vector0","Vector 0","35","0","Create","True","0","0","0","False","0","False","Object","-1","","0,0,1","0,0,0","0","4","FLOAT3","0","FLOAT","1","FLOAT","2","FLOAT","3"]}
{"type":"AmplifyShaderEditor.StaticSwitch, AmplifyShaderEditor","id":43,"pos":[-2048,240],"params":["Inherit","False","Property","_BUMPMAP","_BUMPMAP","35","0","Create","True","0","0","0","False","0","False","","0","0","0","False","_BUMPMAP","Toggle","2","Key0","Key1","Create","True","True","Fragment","9","1","FLOAT3","0,0,0","False","0","FLOAT3","0,0,0","False","2","FLOAT3","0,0,0","False","3","FLOAT3","0,0,0","False","4","FLOAT3","0,0,0","False","5","FLOAT3","0,0,0","False","6","FLOAT3","0,0,0","False","7","FLOAT3","0,0,0","False","8","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.WorldNormalVector, AmplifyShaderEditor","id":62,"pos":[-1792,240],"params":["Inherit","False","True","1","0","FLOAT3","0,0,1","False","4","FLOAT3","0","FLOAT","1","FLOAT","2","FLOAT","3"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":63,"pos":[-1552,240],"params":["Inherit","False","World Normal","-1","True","1","0","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.WorldPosInputsNode, AmplifyShaderEditor","id":6,"pos":[-1008,0],"params":["Inherit","False","0","4","FLOAT3","0","FLOAT","1","FLOAT","2","FLOAT","3"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":64,"pos":[-1040,144],"params":["Inherit","False","63","World Normal","1","0","OBJECT","","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":126,"pos":[-1104,240],"params":["Inherit","False","Property","_SingularityRadius","Singularity Radius","2","0","Create","True","0","0","0","False","0","False","Object","-1","","0","0","0","1","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":23,"pos":[-1104,480],"params":["Inherit","False","Property","_Roughness","Roughness","1","0","Create","True","0","0","0","False","0","False","Object","-1","","0","0","0","1","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":161,"pos":[-1104,400],"params":["Inherit","False","Property","_HorizonSoftness","Horizon Softness","3","0","Create","True","0","0","0","False","0","False","Object","-1","","0","0.062","0","1","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":162,"pos":[-1104,320],"params":["Inherit","False","Property","_LensStrength","Lens Strength","4","0","Create","True","0","0","0","False","0","False","Object","-1","","0.03","0.035","0","1","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":280,"pos":[-288,256],"params":["Inherit","False","Constant","_Float1","Float 0","10","0","Create","True","0","0","0","False","0","False","Object","-1","","1.5","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.CustomExpressionNode, AmplifyShaderEditor","id":263,"pos":[-560,128],"params":["Inherit","False","// 1. Setup Vectors\nfloat3 N = normalize(WorldNormal);\nfloat3 V = normalize(_WorldSpaceCameraPos - WorldPos);\nfloat dotNV = dot(N, V); // Not saturated yet so we can see the full range\nfloat edgeDist = 1.0 - saturate(dotNV);\n\n// 2. The Event Horizon (Singularity)\nif (edgeDist < SingularityRadius)\n    return float3(0, 0, 0);\n\n// 3. Spaghettified Lens Bending\n// We use an exponential curve to pull the direction toward the Normal.\n// As 'r' gets smaller (closer to center), the pull becomes extreme.\nfloat r = edgeDist;\nfloat stretch = pow(1.0 - r, LensStrength * 5.0); \nfloat3 bentDir = normalize(lerp(-V, -N, stretch));\n\n// 4. Vortex Swirl\n// Stronger at the center, tapering off quickly\nfloat swirlAmount = RotationSpeed / (r + 0.05);\nfloat cosA = cos(swirlAmount);\nfloat sinA = sin(swirlAmount);\nfloat3 finalDir = bentDir * cosA + cross(N, bentDir) * sinA + N * dot(N, bentDir) * (1.0 - cosA);\nfinalDir = normalize(finalDir);\n\n// 5. Box Projection (Same as before, it's correct)\n#if defined(UNITY_SPECCUBE_BOX_PROJECTION)\nif (unity_SpecCube0_ProbePosition.w > 0.0)\n{\n    float3 rbMax = unity_SpecCube0_BoxMax.xyz - WorldPos;\n    float3 rbMin = unity_SpecCube0_BoxMin.xyz - WorldPos;\n    float3 invDir = 1.0 / (finalDir + 1e-6);\n    float3 t1 = rbMax * invDir;\n    float3 t2 = rbMin * invDir;\n    float3 tmax = max(t1, t2);\n    float d = min(min(tmax.x, tmax.y), tmax.z);\n    finalDir = (finalDir * d) + (WorldPos - unity_SpecCube0_ProbePosition.xyz);\n}\n#endif\n\n// 6. Clean Mip Mapping (Removing the 'muddy' look)\nfloat perceptualRoughness = 1.0 - Smoothness;\n// Only blur slightly at the very center to simulate light diffraction\nfloat mip = (perceptualRoughness * 7.0) + (stretch * 1.5);\nmip = clamp(mip, 0.0, 7.0);\n\nfloat4 encodedEnv = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, finalDir, mip);\nfloat3 env = DecodeHDR(encodedEnv, unity_SpecCube0_HDR);\n\n// 7. Accretion Ring & Final Composition\n// Accretion disk is usually closer to the hole\nfloat ringPos = saturate(1.0 - abs(r - (SingularityRadius + 0.1)) * 10.0);\nfloat ring = AccretionStrength * pow(ringPos, 4.0);\n\nfloat horizonFade = saturate((edgeDist - SingularityRadius) / max(0.001, HorizonSoftness));\n\nreturn (env * horizonFade) + (ring * float3(1.4, 0.8, 0.4));","4","File","6","True","WorldPos","FLOAT3","0,0,0","In","","Inherit","False","True","WorldNormal","FLOAT3","0,0,0","In","","Inherit","False","True","SingularityRadius","FLOAT","0","In","","Inherit","False","True","LensStrength","FLOAT","0","In","","Inherit","False","True","HorizonSoftness","FLOAT","0","In","","Inherit","False","True","Roughness","FLOAT","0","In","","Inherit","False","Blackhole","False","False","0","f2ffa106d6fd32b61807cb07ee4e2998","False","6","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT","0","False","3","FLOAT","0","False","4","FLOAT","0","False","5","FLOAT","0","False","1","FLOAT4","0"]}
{"type":"AmplifyShaderEditor.PowerNode, AmplifyShaderEditor","id":273,"pos":[-96,128],"params":["Inherit","False","True","2","0","FLOAT4","0,0,0,0","False","1","FLOAT","3","False","1","FLOAT4","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":281,"pos":[0,256],"params":["Inherit","False","Constant","_Float5","Float 0","10","0","Create","True","0","0","0","False","0","False","Object","-1","","3","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":279,"pos":[192,128],"params":["Inherit","False","2","2","0","FLOAT4","0,0,0,0","False","1","FLOAT","0","False","1","FLOAT4","0"]}
{"type":"AmplifyShaderEditor.ComponentMaskNode, AmplifyShaderEditor","id":284,"pos":[400,208],"params":["Inherit","False","False","False","False","True","1","0","FLOAT4","0,0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.ComponentMaskNode, AmplifyShaderEditor","id":283,"pos":[400,128],"params":["Inherit","False","True","True","True","False","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor","id":285,"pos":[720,208],"params":["Inherit","False","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":287,"pos":[992,128],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","1","New Amplify Shader","0770190933193b94aaa3065e307002fa","True","ExtraPrePass","0","0","ExtraPrePass","6","False","True","1","1","False","","0","False","","1","1","False","","0","False","","True","1","False","","1","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","False","False","False","True","1","RenderType=Opaque=RenderType","True","3","True","12","all","0","False","True","1","1","False","","0","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","False","True","1","LightMode=ForwardBase","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":288,"pos":[992,128],"params":["Float","False","True","-1","3","AmplifyShaderEditor.MaterialInspector","0","7","Meenphie/FX/Refraction Probe","0770190933193b94aaa3065e307002fa","True","Unlit","0","1","Unlit","8","False","True","1","1","False","","0","False","","1","1","False","","0","False","","True","1","False","","1","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","True","True","0","False","","False","False","False","True","2","RenderType=Transparent=RenderType","Queue=Transparent=Queue=0","True","3","True","12","all","0","True","True","2","5","False","","10","False","","0","1","False","","10","False","","True","1","False","","1","False","","False","False","False","False","False","False","False","False","False","False","True","True","2","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","2","False","","True","3","False","","True","True","0","False","","0","False","","False","True","1","LightMode=ForwardBase","False","False","0","","0","0","Standard","10","Surface","1","639182290847998430","  Keep Alpha","0","0","  Blend","0","0","Alpha Clipping","0","0","  Use Shadow Threshold","0","0","Cast Shadows","1","0","Write Depth","0","0","  Conservative","0","0","Extra Pre Pass","0","0","Vertex Position","1","0","0","3","False","True","True","False","","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":289,"pos":[992,128],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","1","New Amplify Shader","0770190933193b94aaa3065e307002fa","True","ShadowCaster","0","2","ShadowCaster","0","False","True","1","1","False","","0","False","","1","1","False","","0","False","","True","1","False","","1","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","False","False","False","True","1","RenderType=Opaque=RenderType","True","3","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","False","","True","3","False","","False","False","True","1","LightMode=ShadowCaster","False","False","0","","0","0","Standard","0","False","0"]}
{"wire":[43,1,44,0]}
{"wire":[43,0,45,0]}
{"wire":[62,0,43,0]}
{"wire":[63,0,62,0]}
{"wire":[263,0,6,0]}
{"wire":[263,1,64,0]}
{"wire":[263,2,126,0]}
{"wire":[263,3,162,0]}
{"wire":[263,4,161,0]}
{"wire":[263,5,23,0]}
{"wire":[273,0,263,0]}
{"wire":[273,1,280,0]}
{"wire":[279,0,273,0]}
{"wire":[279,1,281,0]}
{"wire":[284,0,279,0]}
{"wire":[283,0,279,0]}
{"wire":[285,0,284,0]}
{"wire":[288,0,283,0]}
{"wire":[288,7,285,0]}
ASEEND*/
//CHKSM=BA14AC88331C30C6363F9A27ED6975F0EEF57121