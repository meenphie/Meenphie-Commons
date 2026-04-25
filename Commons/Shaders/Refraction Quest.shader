// Made with Amplify Shader Editor v1.9.9.7
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Refraction Quest"
{
	Properties
	{
		_Color( "Color", Color ) = ( 1, 0.4103774, 0.8249955, 0 )
		[NoScaleOffset][SingleLineTexture] _BumpMap( "Normal", 2D ) = "bump" {}
		_Metallic( "Metallic", Range( 0, 1 ) ) = 0
		_Roughness( "Roughness", Range( 0, 1 ) ) = 1
		_IOR( "IOR", Range( 1, 40 ) ) = 1
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
				uniform float4 _Color;
				uniform float _Metallic;
				uniform float _Roughness;
				uniform float _IOR;
				uniform sampler2D _BumpMap;


				float3 Specular( float3 AlbedoColor, float3 LightmapColor, float Metallic, float Smoothness, float IOR, float3 Fresnel, float3 WorldPos, float3 WorldNormal, float3 ViewDir )
				{
					// --- CONFIGURATION & CONSTANTES ---
					float LumaStart = 0.05;
					float LumaEnd = 1.0;
					float RadiusFadeStart = 7.0;
					float specBoost = 2.0;
					const float PI = 3.14159265;
					#if defined(SHADER_API_MOBILE)
					    #define MAX_RADIUS 10.0
					#else
					    #define MAX_RADIUS 20.0
					#endif
					// --- INITIALISATION PBR & IOR ---
					float3 N = normalize(WorldNormal);
					float3 vDir = normalize(ViewDir);
					float nDotV = max(dot(N, vDir), 0.0001);
					// Calcul du F0 (Réflectance à incidence nulle)
					// On convertit l'IOR en valeur de réflectance pour les diélectriques
					float f0_ior = pow((IOR - 1.0) / (IOR + 1.0), 2.0);
					float3 f0_dielectric = float3(f0_ior, f0_ior, f0_ior);
					float3 f0_metal = AlbedoColor.rgb;
					float3 F0 = lerp(f0_dielectric, f0_metal, Metallic);
					// Gestion de la rugosité avec sécurité anti-NaN (le "fix" pour Smoothness 1.0)
					float roughness = 1.0 - Smoothness;
					float safeRoughness = max(roughness, 0.02); 
					float a = safeRoughness * safeRoughness;
					float a2 = a * a; 
					// --- MASQUES ET ATTÉNUATION ---
					float luma = dot(LightmapColor, float3(0.22, 0.70, 0.08));
					float lmMask = saturate((luma - LumaStart) / max(LumaEnd - LumaStart, 0.0001));
					float playerDist = distance(_WorldSpaceCameraPos, WorldPos);
					float fadeT = saturate((playerDist - RadiusFadeStart) / max(MAX_RADIUS - RadiusFadeStart, 0.0001));
					float radiusFade = 1.0 - (fadeT * fadeT * (3.0 - 2.0 * fadeT));
					// Sortie précoce pour les performances
					if (lmMask < 0.001 || Smoothness < 0.01 || _UdonSpecularLightCount == 0 || radiusFade < 0.001) return 0;
					float3 R = reflect(-vDir, N);
					float3 specAccum = 0.0;
					// --- BOUCLE DE LUMIÈRES ---
					for (int i = 0; i < (int)_UdonSpecularLightCount; i++) {
					    float4 posRange = _UdonSpecularLightPos[i];
					    float3 L_center = posRange.xyz - WorldPos;
					    float distSqCenter = dot(L_center, L_center);
					    float rangeSq = posRange.w * posRange.w;
					    // Check de portée
					    if (distSqCenter > rangeSq) continue;
					    // Masque de Spot
					    float4 dirAngle = _UdonSpecularLightDir[i];
					    float3 L_center_norm = L_center * rsqrt(distSqCenter + 0.00001);
					    float spotMask = saturate((dot(-L_center_norm, dirAngle.xyz) - dirAngle.w) / max(0.01, 1.0 - dirAngle.w));
					    if (spotMask <= 0.0) continue;
					    // --- AREA LIGHT SPECULAR (Approximation par point le plus proche) ---
					    float denom = dot(dirAngle.xyz, R);
					    float tPlane = (dirAngle.w < -0.9) ? dot(L_center, R) : (dot(L_center, dirAngle.xyz) / max(denom, 0.001));
					    float3 intersection = R * max(0.0, tPlane);
					    float3 localP = (WorldPos + intersection) - posRange.xyz;
					    float2 halfSize = float2(_UdonSpecularLightRight[i].w, _UdonSpecularLightUp[i].w);
					    float2 clampedPos = clamp(float2(dot(localP, _UdonSpecularLightRight[i].xyz), dot(localP, _UdonSpecularLightUp[i].xyz)), -halfSize, halfSize);
					    float3 closestPoint = posRange.xyz + _UdonSpecularLightRight[i].xyz * clampedPos.x + _UdonSpecularLightUp[i].xyz * clampedPos.y;
					    float3 L = closestPoint - WorldPos;
					    float distSq = dot(L, L);
					    float3 lDir = normalize(L);
					    float3 H = normalize(lDir + vDir);
					    float nDotL = saturate(dot(N, lDir));
					    float nDotH = saturate(dot(N, H));
					    float vDotH = saturate(dot(vDir, H));
					    if (nDotL > 0.0) {
					        // --- BRDF PHYSIQUE (GGX / COOK-TORRANCE) ---
					        
					        // 1. Distribution (D) : GGX
					        float d_denom = (nDotH * nDotH * (a2 - 1.0) + 1.0);
					        float D = a2 / (PI * d_denom * d_denom);
					        // 2. Géométrie (G) : Smith Joint Schlick-GGX
					        float k = (safeRoughness + 1.0) * (safeRoughness + 1.0) / 8.0;
					        float G = (nDotV / (nDotV * (1.0 - k) + k)) * (nDotL / (nDotL * (1.0 - k) + k));
					        // 3. Fresnel (F) : Schlick avec F0 calculé par l'IOR
					        float3 F = F0 + (1.0 - F0) * pow(1.0 - vDotH, 5.0);
					        // Résultat BRDF
					        float3 specBRDF = (D * G * F) / (4.0 * nDotV * nDotL + 0.001);
					        // Atténuation de la source (Distance et Falloff)
					        float falloff = saturate(1.0 - distSqCenter/rangeSq);
					        falloff = (falloff * falloff) / (distSq + 1.0);
					        // Accumulation
					        specAccum += _UdonSpecularLightCol[i].rgb * (specBRDF * nDotL * _UdonSpecularLightCol[i].w * falloff * spotMask);
					    }
					}
					// Application finale des masques et du boost artistique
					return specAccum * specBoost * radiusFade * lmMask;
				}
				
				float3 IndirectSpecularWithBoxProjection1_g19( float3 WorldPos, float3 WorldNormal, float3 ViewDir, float3 Color, float Smoothness, float IOR )
				{
					// --- 1. SETUP DES VECTEURS ---
					float3 N = normalize(WorldNormal);
					float3 V = normalize(ViewDir);
					// --- 2. CALCUL DE LA RÉFRACTION ---
					// "safeIOR" empêche la division par zéro. 
					// À 1.0, le rayon traverse tout droit.
					float safeIOR = max(IOR, 1.0); 
					float eta = 1.0 / safeIOR; 
					float3 refRay = refract(-V, N, eta);
					// --- 3. BOX PROJECTION ---
					float3 ray = refRay;
					if (unity_SpecCube0_ProbePosition.w > 0.0)
					{
					    float3 factors = ((ray > 0.0 ? unity_SpecCube0_BoxMax.xyz : unity_SpecCube0_BoxMin.xyz) - WorldPos) / ray;
					    float scalar = min(min(factors.x, factors.y), factors.z);
					    ray = ray * scalar + (WorldPos - unity_SpecCube0_ProbePosition.xyz);
					}
					// --- 4. SAMPLING ---
					float mipLevel = (1.0 - Smoothness) * 7.0;
					float4 envSample = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, ray, mipLevel);
					float3 indirectRefract = DecodeHDR(envSample, unity_SpecCube0_HDR);
					// --- 5. RÉSULTAT FINAL ---
					// On multiplie simplement la réfraction par ta couleur (Color).
					// Assure-toi d'avoir un paramètre Color (Color Node) connecté à ton Custom Expression.
					return indirectRefract * Color.rgb;
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

					float3 AlbedoColor97_g25 = _Color.rgb;
					float3 LightmapColor97_g25 = float3( 1,1,1 );
					float Metallic97_g25 = _Metallic;
					float temp_output_24_0 = ( 1.0 - _Roughness );
					float Smoothness97_g25 = temp_output_24_0;
					float IOR97_g25 = _IOR;
					float3 Fresnel97_g25 = float3( 1,1,1 );
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
					float3 localSpecular97_g25 = Specular( AlbedoColor97_g25 , LightmapColor97_g25 , Metallic97_g25 , Smoothness97_g25 , IOR97_g25 , Fresnel97_g25 , WorldPos97_g25 , WorldNormal97_g25 , ViewDir97_g25 );
					float3 WorldPos1_g19 = ase_positionWS;
					float3 WorldNormal1_g19 = World_Normal63;
					float3 ViewDir1_g19 = View_Direction65;
					float3 Color1_g19 = _Color.rgb;
					float Smoothness1_g19 = temp_output_24_0;
					float IOR1_g19 = _IOR;
					float3 localIndirectSpecularWithBoxProjection1_g19 = IndirectSpecularWithBoxProjection1_g19( WorldPos1_g19 , WorldNormal1_g19 , ViewDir1_g19 , Color1_g19 , Smoothness1_g19 , IOR1_g19 );
					

					float4 Color = float4( ( localSpecular97_g25 + localIndirectSpecularWithBoxProjection1_g19 ) , 0.0 );
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
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;23;-1072,384;Inherit;False;Property;_Roughness;Roughness;3;0;Create;True;0;0;0;False;0;False;1;0.305;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;24;-768,384;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;46;-1072,304;Inherit;False;Property;_Metallic;Metallic;2;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
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
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;45;-2432,256;Inherit;True;Property;_BumpMap;Normal;1;2;[NoScaleOffset];[SingleLineTexture];Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;True;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.Vector3Node, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;44;-2336,96;Inherit;False;Constant;_Vector0;Vector 0;35;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ViewDirInputsCoordNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;7;-2336,-80;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;65;-2048,-80;Inherit;False;View Direction;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;63;-1552,240;Inherit;False;World Normal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;60;-2880,1072;Inherit;False;63;World Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;59;-2432,1248;Inherit;False;65;View Direction;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;50;-2032,1008;Inherit;False;66;Metallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;49;-2032,928;Inherit;False;66;Metallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;48;-1808,912;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;61;-1216,896;Inherit;False;Fresnel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;69;-206.2295,-225.222;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;74;-576,-272;Inherit;False;Specular Light;-1;;25;479acf9fbe823bd4fb88fabc66bdb3e1;0;9;111;FLOAT3;0,0,0;False;100;FLOAT3;1,1,1;False;110;FLOAT;0;False;99;FLOAT;0;False;112;FLOAT;1.5;False;108;FLOAT3;1,1,1;False;107;FLOAT3;0,0,0;False;98;FLOAT3;0,0,0;False;106;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;22;-1072,464;Inherit;False;Property;_IOR;IOR;4;0;Create;True;0;0;0;False;0;False;1;1.33;1;40;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;39;-576,0;Inherit;False;Refraction;-1;;19;eff271628d46cd819ab54f40c8c6bdd3;0;6;10;FLOAT3;1,1,1;False;9;FLOAT;0;False;16;FLOAT;1;False;15;FLOAT3;0,0,0;False;14;FLOAT3;0,0,0;False;13;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;66;-768,304;Inherit;False;Metallic;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;64;-1008,-32;Inherit;False;63;World Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;67;-1008,48;Inherit;False;65;View Direction;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldPosInputsNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;6;-976,-192;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;40;-1008,-400;Inherit;False;Property;_Color;Color;0;0;Create;True;0;0;0;False;0;False;1,0.4103774,0.8249955,0;0.9383758,0.05188663,1,0;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;18;0,0;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;0770190933193b94aaa3065e307002fa;True;ShadowCaster;0;1;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;False;;True;1;RenderType=Opaque=RenderType;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;17;-32,-256;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;12;Refraction Quest;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;7;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;False;;True;1;RenderType=Opaque=RenderType;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;5;Alpha Clipping;0;0;  Use Shadow Threshold;0;0;Cast Shadows;1;0;Write Depth;0;0;Vertex Position;1;0;0;2;True;True;False;;False;0
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
WireConnection;48;0;51;0
WireConnection;48;2;50;0
WireConnection;61;0;53;0
WireConnection;69;0;74;0
WireConnection;69;1;39;0
WireConnection;74;111;40;5
WireConnection;74;110;46;0
WireConnection;74;99;24;0
WireConnection;74;112;22;0
WireConnection;74;107;6;0
WireConnection;74;98;64;0
WireConnection;74;106;67;0
WireConnection;39;10;40;5
WireConnection;39;9;24;0
WireConnection;39;16;22;0
WireConnection;39;15;6;0
WireConnection;39;14;64;0
WireConnection;39;13;67;0
WireConnection;66;0;46;0
WireConnection;17;0;69;0
ASEEND*/
//CHKSM=442096C68D4085EAC6C17D33D1C51F4582DF557B