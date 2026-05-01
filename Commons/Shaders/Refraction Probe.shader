// Made with Amplify Shader Editor v1.9.9.7
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/FX/Refraction Probe"
{
	Properties
	{
		_Color( "Color", Color ) = ( 0.9058824, 0.9058824, 0.9058824 )
		[NoScaleOffset][SingleLineTexture] _BumpMap( "Normal", 2D ) = "bump" {}
		_Metallic( "Metallic", Range( 0, 1 ) ) = 0.5
		_Roughness( "Roughness", Range( 0, 1 ) ) = 0.5
		_IOR( "IOR", Range( 1, 3 ) ) = 1.5
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

	}

	SubShader
	{
		

		

		Tags { "RenderType"="Opaque" }

	LOD 0

		

		Blend Off
		AlphaToMask Off
		Cull Back
		ColorMask RGBA
		ZWrite On
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
				#define ASE_VERSION 19907

				#pragma vertex vert
				#pragma fragment frag
				#pragma multi_compile_instancing
				#include "UnityCG.cginc"

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

				uniform float _UdonSpecularLightCount;
				uniform float4 _UdonSpecularLightUp[32];
				uniform float4 _UdonSpecularLightDir[32];
				uniform float4 _UdonSpecularLightCol[32];
				uniform float4 _UdonSpecularLightPos[32];
				uniform float4 _UdonSpecularLightRight[32];
				uniform float3 _Color;
				uniform float _Metallic;
				uniform float _Roughness;
				uniform float _IOR;
				uniform sampler2D _BumpMap;


				float3 DirectSpecular( float3 Color, float3 LightmapColor, float Metallic, float Smoothness, float IOR, float3 WorldPos, float3 WorldNormal, float3 ViewDir )
				{
					// --- CONFIGURATION ---
					float lumaStart = 0.05;
					float lumaEnd = 0.5;
					static const float PI_INV_8 = 0.0397887;
					#if defined(SHADER_API_MOBILE)
					static const float distStart = 4.0;
					static const float distEnd = 8.0;
					#else
					static const float distStart = 8.0;
					static const float distEnd = 16.0;
					#endif
					static const float fadeStartSq = distStart * distStart;
					static const float maxRadiusSq = distEnd * distEnd;
					// --- INITIALISATION ---
					float3 N = normalize(WorldNormal);
					float3 vDir = normalize(ViewDir);
					float3 R = reflect(-vDir, N);
					float3 F0 = lerp(float3(0.04, 0.04, 0.04), Color.rgb, Metallic);
					// --- MASQUES ---
					float luma = dot(LightmapColor, float3(0.2126, 0.7152, 0.0722));
					float lmMask = saturate((luma - lumaStart) / max(lumaEnd - lumaStart, 1e-4));
					// --- EARLY EXIT ---
					if (lmMask * Smoothness < 0.001 || _UdonSpecularLightCount == 0) return 0;
					// --- MATHS SPÉCULAIRES ---
					float shininess = exp2(10.0 * Smoothness + 1.0);
					float normalization = (shininess + 8.0) * PI_INV_8;
					float3 specAccum = 0;
					// --- BOUCLE DE LUMIÈRES ---
					for (int i = 0; i < (int)_UdonSpecularLightCount; i++) {
					    float4 posRange = _UdonSpecularLightPos[i];
					    float3 L_center = posRange.xyz - WorldPos;
					    float distSqCenter = dot(L_center, L_center);
					    float rangeSq = posRange.w * posRange.w;
					    if (distSqCenter > rangeSq) continue;
					    // Fade par lumière (distance tête → lumière, cohérent avec le culling C#)
					    float3 toCam = _WorldSpaceCameraPos - posRange.xyz;
					    float dist = sqrt(dot(toCam, toCam));
					    float t = saturate((dist - distStart) / max(distEnd - distStart, 1e-4));
					    float it = 1.0 - t;
					    float radiusFade = it * it * it;
					    if (radiusFade <= 0.0) continue;
					    float4 dirAngle = _UdonSpecularLightDir[i];
					    float3 L_center_norm = L_center * rsqrt(distSqCenter + 1e-5);
					    float spotMask = saturate((dot(-L_center_norm, dirAngle.xyz) - dirAngle.w) / max(0.01, 1.0 - dirAngle.w));
					    if (spotMask <= 0.0) continue;
					    float3 diff;
					    [branch]
					    if (dirAngle.w < -0.9) {
					        diff = L_center;
					    }
					    else {
					        float denom = dot(dirAngle.xyz, R);
					        float tPlane = dot(L_center, dirAngle.xyz) / (abs(denom) < 1e-3 ? 1e-3 : denom);
					        if (tPlane <= 0.0) continue;
					        float3 pReflection = WorldPos + R * tPlane;
					        float3 localP = pReflection - posRange.xyz;
					        float2 halfSize = float2(_UdonSpecularLightRight[i].w, _UdonSpecularLightUp[i].w);
					        float2 clampedPos = clamp(
					            float2(dot(localP, _UdonSpecularLightRight[i].xyz), dot(localP, _UdonSpecularLightUp[i].xyz)),
					            -halfSize, halfSize);
					        diff = (posRange.xyz + _UdonSpecularLightRight[i].xyz * clampedPos.x + _UdonSpecularLightUp[i].xyz * clampedPos.y) - WorldPos;
					    }
					    float dSq = dot(diff, diff);
					    float3 lDir = diff * rsqrt(dSq + 1e-5);
					    float3 H = normalize(lDir + vDir);
					    // Fresnel Schlick
					    float f_inv = 1.0 - saturate(dot(H, vDir));
					    float f2 = f_inv * f_inv;
					    float3 fresnel = F0 + (1.0 - F0) * f2 * f2 * f_inv;
					    float nDotH = saturate(dot(N, H));
					    float nDotL = saturate(dot(N, lDir));
					    float spec = exp2(shininess * nDotH - shininess) * normalization;
					    float falloff = saturate(1.0 - distSqCenter / rangeSq);
					    falloff = (falloff * falloff) / (dSq + 1.0);
					    specAccum += _UdonSpecularLightCol[i].rgb * (spec * fresnel * nDotL * _UdonSpecularLightCol[i].w * falloff * spotMask * radiusFade);
					}
					return specAccum * lmMask;
				}
				
				float3 RefractionProbe1_g41( float3 WorldPos, float3 WorldNormal, float3 ViewDir, float3 Color, float Metallic, float Smoothness, float IOR, float IsFrontFace )
				{
					// Inputs: WorldNormal, ViewDir, WorldPos, IOR (1.0-2.5), Smoothness, Metallic, Color, IsFrontFace
					// --- 1. SETUP ---
					float3 N = normalize(WorldNormal);
					float3 V = normalize(ViewDir);
					bool isFront = IsFrontFace > 0.5;
					if (!isFront) N = -N;
					// --- 2. IOR & F0 ---
					float safeIOR = clamp(IOR, 1.0001, 2.5);
					float eta = isFront ? (1.0 / safeIOR) : safeIOR;
					float f0_ior = pow((1.0 - safeIOR) / (1.0 + safeIOR), 2.0);
					float3 F0 = lerp(float3(f0_ior, f0_ior, f0_ior), Color.rgb, Metallic);
					// --- 3. RAYONS ---
					float3 refRay = refract(-V, N, eta);
					if (dot(refRay, refRay) < 1e-6) refRay = -N;
					float3 reflRay = reflect(-V, N);
					// --- 4. BOX PROJECTION ---
					float3 dirRefract = refRay;
					float3 dirReflect = reflRay;
					if (unity_SpecCube0_ProbePosition.w > 0.0)
					{
					    float3 rbMax = unity_SpecCube0_BoxMax.xyz - WorldPos;
					    float3 rbMin = unity_SpecCube0_BoxMin.xyz - WorldPos;
					    // Refraction
					    float3 dRfr = dirRefract;
					    dRfr.x = (abs(dRfr.x) < 1e-6) ? dRfr.x + 1e-6 : dRfr.x;
					    dRfr.y = (abs(dRfr.y) < 1e-6) ? dRfr.y + 1e-6 : dRfr.y;
					    dRfr.z = (abs(dRfr.z) < 1e-6) ? dRfr.z + 1e-6 : dRfr.z;
					    float3 rbRfr = (dRfr > 0.0) ? rbMax / dRfr : rbMin / dRfr;
					    float faRfr = min(min(rbRfr.x, rbRfr.y), rbRfr.z);
					    dirRefract = (WorldPos + dirRefract * faRfr) - unity_SpecCube0_ProbePosition.xyz;
					    // Reflection
					    float3 dRfl = dirReflect;
					    dRfl.x = (abs(dRfl.x) < 1e-6) ? dRfl.x + 1e-6 : dRfl.x;
					    dRfl.y = (abs(dRfl.y) < 1e-6) ? dRfl.y + 1e-6 : dRfl.y;
					    dRfl.z = (abs(dRfl.z) < 1e-6) ? dRfl.z + 1e-6 : dRfl.z;
					    float3 rbRfl = (dRfl > 0.0) ? rbMax / dRfl : rbMin / dRfl;
					    float faRfl = min(min(rbRfl.x, rbRfl.y), rbRfl.z);
					    dirReflect = (WorldPos + dirReflect * faRfl) - unity_SpecCube0_ProbePosition.xyz;
					}
					// --- 5. SAMPLING ---
					float mip = (1.0 - Smoothness) * 7.0;
					float3 refracColor = DecodeHDR(UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, dirRefract, mip), unity_SpecCube0_HDR);
					float3 refleColor  = DecodeHDR(UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, dirReflect, mip), unity_SpecCube0_HDR);
					// --- 6. FRESNEL SCHLICK ---
					float cosTheta = saturate(dot(N, V));
					float f_inv = 1.0 - cosTheta;
					float f2 = f_inv * f_inv;
					float3 F = F0 + (1.0 - F0) * f2 * f2 * f_inv;
					// --- 7. MIX FINAL (conservation d'énergie) ---
					float3 refraction = refracColor * Color.rgb * (1.0 - Metallic) * (1.0 - F);
					float3 reflection = refleColor * F;
					return refraction + reflection;
				}
				

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

				half4 frag( v2f IN , uint ase_vface : SV_IsFrontFace
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

					float3 Color97_g25 = _Color;
					float3 LightmapColor97_g25 = float3( 1, 1, 1 );
					float Metallic97_g25 = _Metallic;
					float temp_output_24_0 = ( 1.0 - _Roughness );
					float Smoothness97_g25 = temp_output_24_0;
					float IOR97_g25 = _IOR;
					float3 ase_positionWS = IN.ase_texcoord.xyz;
					float3 WorldPos97_g25 = ase_positionWS;
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
					float3 WorldNormal97_g25 = World_Normal63;
					float3 ase_viewVectorWS = ( _WorldSpaceCameraPos.xyz - ase_positionWS );
					float3 ase_viewDirWS = normalize( ase_viewVectorWS );
					float3 View_Direction65 = ase_viewDirWS;
					float3 ViewDir97_g25 = View_Direction65;
					float3 localDirectSpecular97_g25 = DirectSpecular( Color97_g25 , LightmapColor97_g25 , Metallic97_g25 , Smoothness97_g25 , IOR97_g25 , WorldPos97_g25 , WorldNormal97_g25 , ViewDir97_g25 );
					float3 WorldPos1_g41 = ase_positionWS;
					float3 WorldNormal1_g41 = World_Normal63;
					float3 ViewDir1_g41 = View_Direction65;
					float3 Color1_g41 = _Color;
					float Metallic66 = _Metallic;
					float Metallic1_g41 = Metallic66;
					float Smoothness1_g41 = temp_output_24_0;
					float IOR1_g41 = _IOR;
					float IsFrontFace1_g41 = ase_vface;
					float3 localRefractionProbe1_g41 = RefractionProbe1_g41( WorldPos1_g41 , WorldNormal1_g41 , ViewDir1_g41 , Color1_g41 , Metallic1_g41 , Smoothness1_g41 , IOR1_g41 , IsFrontFace1_g41 );
					

					float4 Color = float4( ( localDirectSpecular97_g25 + localRefractionProbe1_g41 ) , 0.0 );
					float Alpha = 1;
					half AlphaClipThreshold = 0.5;
					half AlphaClipThresholdShadow = 0.5;

					#if defined( ASE_DEPTH_WRITE_ON )
						outputDepth = IN.pos.z;
					#endif

					#ifdef _ALPHATEST_ON
						clip( Alpha - AlphaClipThreshold );
					#endif

					return Color;
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
				#define ASE_VERSION 19907

				#pragma vertex vert
				#pragma fragment frag
				#pragma multi_compile_shadowcaster
				#ifndef UNITY_PASS_SHADOWCASTER
					#define UNITY_PASS_SHADOWCASTER
				#endif
				#include "HLSLSupport.cginc"
				#include "UnityShaderVariables.cginc"
				#include "UnityCG.cginc"
				#include "Lighting.cginc"
				#include "UnityPBSLighting.cginc"

				

				struct appdata
				{
					float4 vertex : POSITION;
					half3 normal : NORMAL;
					
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct v2f
				{
					V2F_SHADOW_CASTER;
					
					UNITY_VERTEX_INPUT_INSTANCE_ID
					UNITY_VERTEX_OUTPUT_STEREO
				};

				#ifdef UNITY_STANDARD_USE_DITHER_MASK
					sampler3D _DitherMaskLOD;
				#endif
				#ifdef ASE_TESSELLATION
					float _TessPhongStrength;
					float _TessValue;
					float _TessMin;
					float _TessMax;
					float _TessEdgeLength;
					float _TessMaxDisp;
				#endif

				uniform float _UdonSpecularLightCount;
				uniform float4 _UdonSpecularLightUp[32];
				uniform float4 _UdonSpecularLightDir[32];
				uniform float4 _UdonSpecularLightCol[32];
				uniform float4 _UdonSpecularLightPos[32];
				uniform float4 _UdonSpecularLightRight[32];


				
				v2f vert( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID( v );
					v2f o;
					UNITY_INITIALIZE_OUTPUT( v2f, o );
					UNITY_TRANSFER_INSTANCE_ID( v, o );
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );

					

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

					TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
					return o;
				}

				half4 frag( v2f IN 
							#if defined( ASE_DEPTH_WRITE_ON )
								, out float outputDepth : SV_Depth
							#endif
							) : SV_Target
				{
					UNITY_SETUP_INSTANCE_ID(IN);

					#ifdef LOD_FADE_CROSSFADE
						UNITY_APPLY_DITHER_CROSSFADE(IN.pos.xy);
					#endif

					

					float Alpha = 1;
					half AlphaClipThreshold = 0.5;
					half AlphaClipThresholdShadow = 0.5;

					#if defined( ASE_DEPTH_WRITE_ON )
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
Version=19907
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;47;-2912,784;Inherit;False;1989.779;589.656;Comment;14;61;60;59;58;57;56;55;54;53;52;51;50;49;48;Fresnel;1,1,1,1;0;0
Node;AmplifyShaderEditor.OneMinusNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;24;-768,384;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;51;-2032,848;Inherit;False;Constant;_F0;F0;10;0;Create;True;0;0;0;False;0;False;0.04;0.04;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;52;-2160,1120;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;53;-1456,896;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;54;-2000,1120;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;55;-1824,1120;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;56;-1648,1120;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwitchByFaceNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;57;-2400,1072;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NegateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;58;-2608,1168;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;43;-2048,240;Inherit;False;Property;_BUMPMAP;_BUMPMAP;35;0;Create;True;0;0;0;False;0;False;0;0;0;False;_BUMPMAP;Toggle;2;Key0;Key1;Create;True;True;Fragment;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldNormalVector, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;62;-1792,240;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;45;-2432,256;Inherit;True;Property;_BumpMap;Normal;1;2;[NoScaleOffset];[SingleLineTexture];Create;False;0;0;0;False;0;False;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;True;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.Vector3Node, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;44;-2336,96;Inherit;False;Constant;_Vector0;Vector 0;35;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ViewDirInputsCoordNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;7;-2336,-80;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;65;-2048,-80;Inherit;False;View Direction;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;63;-1552,240;Inherit;False;World Normal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;60;-2880,1072;Inherit;False;63;World Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;59;-2432,1248;Inherit;False;65;View Direction;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;50;-2032,1008;Inherit;False;66;Metallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;49;-2032,928;Inherit;False;66;Metallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;61;-1216,896;Inherit;False;Fresnel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;69;-206.2295,-225.222;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldPosInputsNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;6;-976,-192;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;76;-944,-336;Inherit;False;Constant;_Vector1;Vector 1;5;0;Create;True;0;0;0;False;0;False;1,1,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;40;-1008,-480;Inherit;False;Property;_Color;Color;0;0;Create;True;0;0;0;False;0;False;0.9058824,0.9058824,0.9058824,0;1,1,1,0;True;False;0;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;64;-1008,48;Inherit;False;63;World Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;84;-1008,-32;Inherit;False;66;Metallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;66;-768,304;Inherit;False;Metallic;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;48;-1808,912;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;74;-576,-272;Inherit;False;Direct Specular;-1;;25;479acf9fbe823bd4fb88fabc66bdb3e1;0;8;111;FLOAT3;0,0,0;False;100;FLOAT3;1,1,1;False;110;FLOAT;0;False;99;FLOAT;0;False;112;FLOAT;1.5;False;107;FLOAT3;0,0,0;False;98;FLOAT3;0,0,0;False;106;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FaceVariableNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;90;-912,208;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;67;-1008,128;Inherit;False;65;View Direction;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;46;-1072,304;Inherit;False;Property;_Metallic;Metallic;2;0;Create;True;0;0;0;False;0;False;0.5;0.1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;101;-576,0;Inherit;False;Refraction;-1;;41;eff271628d46cd819ab54f40c8c6bdd3;0;8;10;FLOAT3;1,1,1;False;17;FLOAT;0;False;9;FLOAT;0;False;16;FLOAT;1;False;18;FLOAT;0;False;15;FLOAT3;0,0,0;False;14;FLOAT3;0,0,0;False;13;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;23;-1072,384;Inherit;False;Property;_Roughness;Roughness;3;0;Create;True;0;0;0;False;0;False;0.5;0.15;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;22;-1072,464;Inherit;False;Property;_IOR;IOR;4;0;Create;True;0;0;0;False;0;False;1.5;1.5;1;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;102;-32,-256;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;12;Meenphie/FX/Refraction Probe;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;7;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;False;;True;1;RenderType=Opaque=RenderType;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;5;Alpha Clipping;0;0;  Use Shadow Threshold;0;0;Cast Shadows;1;0;Write Depth;0;0;Vertex Position;1;0;0;2;True;True;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;103;-32,-256;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;0770190933193b94aaa3065e307002fa;True;ShadowCaster;0;1;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;False;;True;1;RenderType=Opaque=RenderType;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
WireConnection;24;0;23;0
WireConnection;52;0;57;0
WireConnection;52;1;59;0
WireConnection;53;0;48;0
WireConnection;53;2;56;0
WireConnection;54;0;52;0
WireConnection;55;0;54;0
WireConnection;56;0;55;0
WireConnection;57;0;60;0
WireConnection;57;1;58;0
WireConnection;58;0;60;0
WireConnection;43;1;44;0
WireConnection;43;0;45;0
WireConnection;62;0;43;0
WireConnection;65;0;7;0
WireConnection;63;0;62;0
WireConnection;61;0;53;0
WireConnection;69;0;74;0
WireConnection;69;1;101;0
WireConnection;66;0;46;0
WireConnection;48;0;51;0
WireConnection;48;2;50;0
WireConnection;74;111;40;0
WireConnection;74;100;76;0
WireConnection;74;110;46;0
WireConnection;74;99;24;0
WireConnection;74;112;22;0
WireConnection;74;107;6;0
WireConnection;74;98;64;0
WireConnection;74;106;67;0
WireConnection;101;10;40;0
WireConnection;101;17;84;0
WireConnection;101;9;24;0
WireConnection;101;16;22;0
WireConnection;101;18;90;0
WireConnection;101;15;6;0
WireConnection;101;14;64;0
WireConnection;101;13;67;0
WireConnection;102;0;69;0
ASEEND*/
//CHKSM=23B903065695BB45D6F7D58C79ECAB9F283E4F3F