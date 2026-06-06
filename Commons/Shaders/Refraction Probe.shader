// Made with Amplify Shader Editor v1.9.9.9
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
		

		

		/*ase_tags*/
		Tags { "RenderType"="Transparent" "Queue"="Transparent+1" }

		Cull Back

	LOD 0

		

		Blend SrcAlpha OneMinusSrcAlpha
		AlphaToMask Off
		ColorMask RGBA
		ZWrite Off
		ZClip True
		ZTest LEqual
		Offset 0 , 0
		

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

			CGPROGRAM
			#define ASE_VERSION 19909

			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"

			#include "Packages/com.meenphie.commons/Commons/Shaders/Custom Expressions/BlackHole.cginc"
			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_VERT_NORMAL
			#pragma shader_feature_local_fragment _BUMPMAP


			struct appdata
			{
				float4 vertex : POSITION;
				half3 normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_tangent : TANGENT;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
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
				float3 ase_tangentWS = UnityObjectToWorldDir( v.ase_tangent );
				o.ase_texcoord2.xyz = ase_tangentWS;
				float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
				o.ase_texcoord3.xyz = ase_normalWS;
				float ase_tangentSign = v.ase_tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
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

				o.pos = UnityObjectToClipPos( v.vertex );

				#if defined( ASE_SHADOWS )
					UNITY_TRANSFER_SHADOW( o, v.texcoord );
				#endif
				return o;
			}

			half4 frag( v2f IN 
			#if defined( ASE_DEPTH_WRITE_ON )
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
				float4 temp_cast_0 = (3.0).xxxx;
				float4 temp_output_279_0 = ( pow( saferPower273 , temp_cast_0 ) * 3.0 );
				

				float4 Color = float4( (temp_output_279_0).xyz , 0.0 );
				float Alpha = saturate( (temp_output_279_0).w );
				half AlphaClipThreshold = 0.5;
				half AlphaClipThresholdShadow = 0.5;

				#if defined( ASE_DEPTH_WRITE_ON )
					outputDepth = IN.pos.z;
				#endif

				#ifdef _ALPHATEST_ON
					clip( Alpha - AlphaClipThreshold );
				#endif

				Color.a = Alpha;
				return Color;
			}
			ENDCG
		}

	
	}
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
	
	Fallback Off
}/*ASEBEGIN
Version=19909
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;45;-2432,256;Inherit;True;Property;_BumpMap;Normal;0;2;[NoScaleOffset];[SingleLineTexture];Create;False;0;0;0;False;0;False;-1;None;5cb9eae924c3a9c4a835886067ad65cb;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;True;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.Vector3Node, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;44;-2336,96;Inherit;False;Constant;_Vector0;Vector 0;35;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.StaticSwitch, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;43;-2048,240;Inherit;False;Property;_BUMPMAP;_BUMPMAP;35;0;Create;True;0;0;0;False;0;False;0;0;0;False;_BUMPMAP;Toggle;2;Key0;Key1;Create;True;True;Fragment;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldNormalVector, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;62;-1792,240;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;63;-1552,240;Inherit;False;World Normal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldPosInputsNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;6;-1008,0;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;64;-1040,144;Inherit;False;63;World Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;126;-1104,240;Inherit;False;Property;_SingularityRadius;Singularity Radius;2;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;23;-1104,480;Inherit;False;Property;_Roughness;Roughness;1;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;161;-1104,400;Inherit;False;Property;_HorizonSoftness;Horizon Softness;3;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;162;-1104,320;Inherit;False;Property;_LensStrength;Lens Strength;4;0;Create;True;0;0;0;False;0;False;0.03;0.03;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;280;-288,256;Inherit;False;Constant;_Float1;Float 0;10;0;Create;True;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;263;-560,128;Inherit;False;// 1. Setup Vectors$float3 N = normalize(WorldNormal)@$float3 V = normalize(_WorldSpaceCameraPos - WorldPos)@$float dotNV = dot(N, V)@ // Not saturated yet so we can see the full range$float edgeDist = 1.0 - saturate(dotNV)@$$// 2. The Event Horizon (Singularity)$if (edgeDist < SingularityRadius)$    return float3(0, 0, 0)@$$// 3. Spaghettified Lens Bending$// We use an exponential curve to pull the direction toward the Normal.$// As 'r' gets smaller (closer to center), the pull becomes extreme.$float r = edgeDist@$float stretch = pow(1.0 - r, LensStrength * 5.0)@ $float3 bentDir = normalize(lerp(-V, -N, stretch))@$$// 4. Vortex Swirl$// Stronger at the center, tapering off quickly$float swirlAmount = RotationSpeed / (r + 0.05)@$float cosA = cos(swirlAmount)@$float sinA = sin(swirlAmount)@$float3 finalDir = bentDir * cosA + cross(N, bentDir) * sinA + N * dot(N, bentDir) * (1.0 - cosA)@$finalDir = normalize(finalDir)@$$// 5. Box Projection (Same as before, it's correct)$#if defined(UNITY_SPECCUBE_BOX_PROJECTION)$if (unity_SpecCube0_ProbePosition.w > 0.0)${$    float3 rbMax = unity_SpecCube0_BoxMax.xyz - WorldPos@$    float3 rbMin = unity_SpecCube0_BoxMin.xyz - WorldPos@$    float3 invDir = 1.0 / (finalDir + 1e-6)@$    float3 t1 = rbMax * invDir@$    float3 t2 = rbMin * invDir@$    float3 tmax = max(t1, t2)@$    float d = min(min(tmax.x, tmax.y), tmax.z)@$    finalDir = (finalDir * d) + (WorldPos - unity_SpecCube0_ProbePosition.xyz)@$}$#endif$$// 6. Clean Mip Mapping (Removing the 'muddy' look)$float perceptualRoughness = 1.0 - Smoothness@$// Only blur slightly at the very center to simulate light diffraction$float mip = (perceptualRoughness * 7.0) + (stretch * 1.5)@$mip = clamp(mip, 0.0, 7.0)@$$float4 encodedEnv = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, finalDir, mip)@$float3 env = DecodeHDR(encodedEnv, unity_SpecCube0_HDR)@$$// 7. Accretion Ring & Final Composition$// Accretion disk is usually closer to the hole$float ringPos = saturate(1.0 - abs(r - (SingularityRadius + 0.1)) * 10.0)@$float ring = AccretionStrength * pow(ringPos, 4.0)@$$float horizonFade = saturate((edgeDist - SingularityRadius) / max(0.001, HorizonSoftness))@$$return (env * horizonFade) + (ring * float3(1.4, 0.8, 0.4))@;4;File;6;True;WorldPos;FLOAT3;0,0,0;In;;Inherit;False;True;WorldNormal;FLOAT3;0,0,0;In;;Inherit;False;True;SingularityRadius;FLOAT;0;In;;Inherit;False;True;LensStrength;FLOAT;0;In;;Inherit;False;True;HorizonSoftness;FLOAT;0;In;;Inherit;False;True;Roughness;FLOAT;0;In;;Inherit;False;Blackhole;False;False;0;f2ffa106d6fd32b61807cb07ee4e2998;False;6;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.PowerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;273;-96,128;Inherit;False;True;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;3;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;281;0,256;Inherit;False;Constant;_Float5;Float 0;10;0;Create;True;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;279;192,128;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ComponentMaskNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;284;400,208;Inherit;False;False;False;False;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;283;400,128;Inherit;False;True;True;True;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;285;720,208;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;278;448,128;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;57d65cf91784ef85cbf389359c250935;True;ShadowCaster;0;1;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;False;;True;2;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;277;992,128;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;8;Meenphie/FX/Refraction Probe;57d65cf91784ef85cbf389359c250935;True;Unlit;0;0;Unlit;7;True;True;2;5;False;;10;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;True;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;2;False;;True;3;False;;True;True;0;False;;0;False;;True;1;False;;True;2;RenderType=Transparent=RenderType;Queue=Transparent=Queue=1;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;6;Rendering Mode;1;639164391328947000;Alpha Clipping;0;0;  Use Shadow Threshold;0;0;Cast Shadows;0;639164305293124900;Write Depth;0;0;Vertex Position;1;0;0;2;True;False;False;;False;0
WireConnection;43;1;44;0
WireConnection;43;0;45;0
WireConnection;62;0;43;0
WireConnection;63;0;62;0
WireConnection;263;0;6;0
WireConnection;263;1;64;0
WireConnection;263;2;126;0
WireConnection;263;3;162;0
WireConnection;263;4;161;0
WireConnection;263;5;23;0
WireConnection;273;0;263;0
WireConnection;273;1;280;0
WireConnection;279;0;273;0
WireConnection;279;1;281;0
WireConnection;284;0;279;0
WireConnection;283;0;279;0
WireConnection;285;0;284;0
WireConnection;277;0;283;0
WireConnection;277;7;285;0
ASEEND*/
//CHKSM=E851DD1FBC1816E931580DE2628DF15C0893EFB1