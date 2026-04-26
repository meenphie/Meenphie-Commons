// Made with Amplify Shader Editor v1.9.9.7
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Standard/Opaque"
{
	Properties
	{
		[Meenphie_DrawerCategory(SURFACE OPTIONS,true,0,0)] _CATEGORY_SURFACEOPTIONS( "CATEGORY_SURFACEOPTIONS", Float ) = 1
		_Color( "DIffuse Color", Color ) = ( 0.9058824, 0.9058824, 0.9058824, 1 )
		[NoScaleOffset][SingleLineTexture] _MainTex( "Base Color", 2D ) = "white" {}
		[NoScaleOffset][SingleLineTexture] _BumpMap( "Normal", 2D ) = "bump" {}
		[NoScaleOffset][SingleLineTexture] _MetallicMap( "Metallic", 2D ) = "black" {}
		[NoScaleOffset][SingleLineTexture] _GlossinessMap( "Roughness", 2D ) = "black" {}
		_Metallic( "Metallic", Range( 0, 1 ) ) = 0
		_Glossiness( "Roughness", Range( 0, 1 ) ) = 0.5
		_IOR( "IOR", Range( 1, 2.5 ) ) = 1.5
		[Toggle( _USEGEOMETRICAA_ON )] _UseGeometricAA( "Use Geometric AA", Float ) = 1
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESURFACEOPTIONS( "CATEGORY SPACE SURFACEOPTIONS", Float ) = 0
		[Meenphie_DrawerCategory(EMISSION,true,0,0)] _CATEGORYEMISSION( "CATEGORY EMISSION", Float ) = 0
		[NoScaleOffset][SingleLineTexture] _EmissionMap( "Emission", 2D ) = "white" {}
		[Gamma] _EmissionColor( "Emission Color", Color ) = ( 1, 1, 1 )
		_EmissionIntensity( "Emission Intensity", Float ) = 0
		[Meenphie_DrawerEmissionFlags] _EmissionFlags( "Global Illumination", Float ) = 2
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACEEMISSION( "CATEGORY SPACE EMISSION", Float ) = 0
		[Meenphie_DrawerCategory(LIGHTMAPPING,true,0,0)] _CATEGORYLIGHTMAPPING( "CATEGORY LIGHTMAPPING", Float ) = 0
		[KeywordEnum( Disabled,Simple,SimpleLerp,RNM,RNMLerp )] _LightmapMode( "Lightmap Mode", Float ) = 0
		[NoScaleOffset][SingleLineTexture] _Lightmap0( "Lightmap 0", 2D ) = "black" {}
		[NoScaleOffset][SingleLineTexture] _Lightmap1( "Lightmap 1", 2D ) = "black" {}
		[NoScaleOffset][SingleLineTexture] _UdonRNMX0( "RNMX 0", 2D ) = "black" {}
		[NoScaleOffset][SingleLineTexture] _UdonRNMY0( "RNMY 0", 2D ) = "black" {}
		[NoScaleOffset][SingleLineTexture] _UdonRNMZ0( "RNMZ 0", 2D ) = "black" {}
		[NoScaleOffset][SingleLineTexture] _UdonRNMX1( "RNMX 1", 2D ) = "black" {}
		[NoScaleOffset][SingleLineTexture] _UdonRNMY1( "RNMY 1", 2D ) = "black" {}
		[NoScaleOffset][SingleLineTexture] _UdonRNMZ1( "RNMZ 1", 2D ) = "black" {}
		_UdonLightmapLerp( "Lightmap Lerp", Range( 0, 1 ) ) = 0
		[Toggle( _USEBICUBICFILTERING_ON )] _UseBicubicFiltering( "Use Bicubic Filtering", Float ) = 1
		[Toggle( _USELIGHTMAPPEDREFLECTIONS_ON )] _UseLightmappedReflections( "Use Lightmapped Reflections", Float ) = 1
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACELIGHTMAPPING( "CATEGORY SPACE LIGHTMAPPING", Float ) = 0
		[Meenphie_DrawerCategory(STOCHASTIC,true,0,0)] _CATEGORYSTOCHASTIC( "CATEGORY STOCHASTIC", Float ) = 0
		[Toggle( _STOCHASTICENABLED_ON )] _StochasticEnabled( "Stochastic Enabled", Float ) = 0
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESTOCHASTIC( "CATEGORY SPACE STOCHASTIC", Float ) = 0
		[Meenphie_DrawerCategory(COLOR GRADING,true,0,0)] _CATEGORYCOLORGRADING( "CATEGORY COLOR GRADING", Float ) = 0
		[KeywordEnum( 2D,3D )] _LUTMode( "LUT Mode", Float ) = 1
		_LUTSize( "LUT Size", Float ) = 32
		[NoScaleOffset][SingleLineTexture] _2DLut( "2D Lut", 2D ) = "black" {}
		[NoScaleOffset][SingleLineTexture] _3DLut( "3D Lut", 3D ) = "black" {}
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACECOLORGRADING( "CATEGORY SPACE COLOR GRADING", Float ) = 0
		[Meenphie_DrawerCategory(SPECIAL EFFECTS,true,0,0)] _CATEGORYSPECIALEFFECTS( "CATEGORY SPECIAL EFFECTS", Float ) = 0
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESPECIALEFFECTS( "CATEGORY SPACE SPECIAL EFFECTS", Float ) = 0
		[HideInInspector] GenKey__GlossinessMap( "Assign keyword _GLOSSINESSMAP", Float ) = 1.0
		[HideInInspector] GenKey__MainTex( "Assign keyword _MAINTEX", Float ) = 1.0
		[HideInInspector] GenKey__2DLut( "Assign keyword _2DLUT", Float ) = 1.0
		[HideInInspector] GenKey__MetallicMap( "Assign keyword _METALLICMAP", Float ) = 1.0
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0
		[HideInInspector] GenKey__3DLut( "Assign keyword _3DLUT", Float ) = 1.0


		//_TransmissionShadow( "Transmission Shadow", Range( 0, 1 ) ) = 0.5
		//_TransStrength( "Trans Strength", Range( 0, 50 ) ) = 1
		//_TransNormal( "Trans Normal Distortion", Range( 0, 1 ) ) = 0.5
		//_TransScattering( "Trans Scattering", Range( 1, 50 ) ) = 2
		//_TransDirect( "Trans Direct", Range( 0, 1 ) ) = 0.9
		//_TransAmbient( "Trans Ambient", Range( 0, 1 ) ) = 0.1
		//_TransShadow( "Trans Shadow", Range( 0, 1 ) ) = 0.5

		//_TessPhongStrength( "Tess Phong Strength", Range( 0, 1 ) ) = 0.5
		//_TessValue( "Tess Max Tessellation", Range( 1, 32 ) ) = 16
		//_TessMin( "Tess Min Distance", Float ) = 10
		//_TessMax( "Tess Max Distance", Float ) = 25
		//_TessEdgeLength ( "Tess Edge length", Range( 2, 50 ) ) = 16
		//_TessMaxDisp( "Tess Max Displacement", Float ) = 25

		//[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		//[ToggleOff] _GlossyReflections("Reflections", Float) = 1.0

		//_InstancedTerrainNormals("Specular Highlights", Float) = 1.0
	}

	SubShader
	{
		

		

		Tags { "RenderType"="Opaque" "Queue"="Geometry" "DisableBatching"="False" }

	LOD 0

		Cull Back
		AlphaToMask Off
		ZWrite On
		ZTest LEqual
		ColorMask RGBA

		

		Blend Off
		

		CGINCLUDE
			#pragma target 3.5
			// ensure rendering platforms toggle list is visible

			float4 FixedTess( float tessValue )
			{
				return tessValue;
			}

			float CalcDistanceTessFactor (float4 vertex, float minDist, float maxDist, float tess, float4x4 o2w, float3 cameraPos )
			{
				float3 wpos = mul(o2w,vertex).xyz;
				float dist = distance (wpos, cameraPos);
				float f = clamp(1.0 - (dist - minDist) / (maxDist - minDist), 0.01, 1.0) * tess;
				return f;
			}

			float4 CalcTriEdgeTessFactors (float3 triVertexFactors)
			{
				float4 tess;
				tess.x = 0.5 * (triVertexFactors.y + triVertexFactors.z);
				tess.y = 0.5 * (triVertexFactors.x + triVertexFactors.z);
				tess.z = 0.5 * (triVertexFactors.x + triVertexFactors.y);
				tess.w = (triVertexFactors.x + triVertexFactors.y + triVertexFactors.z) / 3.0f;
				return tess;
			}

			float CalcEdgeTessFactor (float3 wpos0, float3 wpos1, float edgeLen, float3 cameraPos, float4 scParams )
			{
				float dist = distance (0.5 * (wpos0+wpos1), cameraPos);
				float len = distance(wpos0, wpos1);
				float f = max(len * scParams.y / (edgeLen * dist), 1.0);
				return f;
			}

			float DistanceFromPlane (float3 pos, float4 plane)
			{
				float d = dot (float4(pos,1.0f), plane);
				return d;
			}

			bool WorldViewFrustumCull (float3 wpos0, float3 wpos1, float3 wpos2, float cullEps, float4 planes[6] )
			{
				float4 planeTest;
				planeTest.x = (( DistanceFromPlane(wpos0, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
							  (( DistanceFromPlane(wpos1, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
							  (( DistanceFromPlane(wpos2, planes[0]) > -cullEps) ? 1.0f : 0.0f );
				planeTest.y = (( DistanceFromPlane(wpos0, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
							  (( DistanceFromPlane(wpos1, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
							  (( DistanceFromPlane(wpos2, planes[1]) > -cullEps) ? 1.0f : 0.0f );
				planeTest.z = (( DistanceFromPlane(wpos0, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
							  (( DistanceFromPlane(wpos1, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
							  (( DistanceFromPlane(wpos2, planes[2]) > -cullEps) ? 1.0f : 0.0f );
				planeTest.w = (( DistanceFromPlane(wpos0, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
							  (( DistanceFromPlane(wpos1, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
							  (( DistanceFromPlane(wpos2, planes[3]) > -cullEps) ? 1.0f : 0.0f );
				return !all (planeTest);
			}

			float4 DistanceBasedTess( float4 v0, float4 v1, float4 v2, float tess, float minDist, float maxDist, float4x4 o2w, float3 cameraPos )
			{
				float3 f;
				f.x = CalcDistanceTessFactor (v0,minDist,maxDist,tess,o2w,cameraPos);
				f.y = CalcDistanceTessFactor (v1,minDist,maxDist,tess,o2w,cameraPos);
				f.z = CalcDistanceTessFactor (v2,minDist,maxDist,tess,o2w,cameraPos);

				return CalcTriEdgeTessFactors (f);
			}

			float4 EdgeLengthBasedTess( float4 v0, float4 v1, float4 v2, float edgeLength, float4x4 o2w, float3 cameraPos, float4 scParams )
			{
				float3 pos0 = mul(o2w,v0).xyz;
				float3 pos1 = mul(o2w,v1).xyz;
				float3 pos2 = mul(o2w,v2).xyz;
				float4 tess;
				tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
				tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
				tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
				tess.w = (tess.x + tess.y + tess.z) / 3.0f;
				return tess;
			}

			float4 EdgeLengthBasedTessCull( float4 v0, float4 v1, float4 v2, float edgeLength, float maxDisplacement, float4x4 o2w, float3 cameraPos, float4 scParams, float4 planes[6] )
			{
				float3 pos0 = mul(o2w,v0).xyz;
				float3 pos1 = mul(o2w,v1).xyz;
				float3 pos2 = mul(o2w,v2).xyz;
				float4 tess;

				if (WorldViewFrustumCull(pos0, pos1, pos2, maxDisplacement, planes))
				{
					tess = 0.0f;
				}
				else
				{
					tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
					tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
					tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
					tess.w = (tess.x + tess.y + tess.z) / 3.0f;
				}
				return tess;
			}

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
			
			Name "ForwardBase"
			Tags { "LightMode"="ForwardBase" }

			Blend Off

			CGPROGRAM
				#define ASE_GEOMETRY
				#define ASE_FRAGMENT_NORMAL 0
				#define ASE_RECEIVE_SHADOWS
				#pragma multi_compile_instancing
				#pragma multi_compile _ LOD_FADE_CROSSFADE
				#define ASE_LIGHTING_SIMPLE 1
				#pragma multi_compile_fog
				#define ASE_FOG
				#define _SPECULARHIGHLIGHTS_OFF
				#define _GLOSSYREFLECTIONS_OFF
				#define ASE_VERSION 19907

				#pragma vertex vert
				#pragma fragment frag
				#pragma multi_compile_fwdbase
				#ifndef UNITY_PASS_FORWARDBASE
					#define UNITY_PASS_FORWARDBASE
				#endif
				#include "HLSLSupport.cginc"
				#if defined( ASE_GEOMETRY ) || defined( ASE_IMPOSTOR )
					#ifndef UNITY_INSTANCED_LOD_FADE
						#define UNITY_INSTANCED_LOD_FADE
					#endif
					#ifndef UNITY_INSTANCED_SH
						#define UNITY_INSTANCED_SH
					#endif
					#ifndef UNITY_INSTANCED_LIGHTMAPSTS
						#define UNITY_INSTANCED_LIGHTMAPSTS
					#endif
				#endif
				#include "UnityShaderVariables.cginc"
				#include "UnityCG.cginc"
				#include "Lighting.cginc"
				#include "UnityPBSLighting.cginc"
				#include "AutoLight.cginc"

				#if defined( UNITY_INSTANCING_ENABLED ) && defined( ASE_INSTANCED_TERRAIN ) && ( defined(_TERRAIN_INSTANCED_PERPIXEL_NORMAL) || defined(_INSTANCEDTERRAINNORMALS_PIXEL) )
					#define ENABLE_TERRAIN_PERPIXEL_NORMAL
				#endif

				#include "UnityStandardUtils.cginc"
				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
				#define ASE_NEEDS_WORLD_TANGENT
				#define ASE_NEEDS_FRAG_WORLD_TANGENT
				#define ASE_NEEDS_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_BITANGENT
				#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
				#define ASE_NEEDS_WORLD_POSITION
				#define ASE_NEEDS_FRAG_WORLD_POSITION
				#pragma shader_feature _LIGHTMAPDEBUG
				#pragma shader_feature_local _STOCHASTICENABLED_ON
				#pragma shader_feature_local _MAINTEX
				#pragma shader_feature_local _METALLICMAP
				#pragma shader_feature_local _LIGHTMAPMODE_DISABLED _LIGHTMAPMODE_SIMPLE _LIGHTMAPMODE_SIMPLELERP _LIGHTMAPMODE_RNM _LIGHTMAPMODE_RNMLERP
				#pragma shader_feature_local _USEBICUBICFILTERING_ON
				#pragma shader_feature_local _BUMPMAP
				#pragma shader_feature_local _USELIGHTMAPPEDREFLECTIONS_ON
				#pragma shader_feature_local _USEGEOMETRICAA_ON
				#pragma shader_feature_local _GLOSSINESSMAP
				#pragma shader_feature_local _LUTMODE_2D _LUTMODE_3D
				#pragma shader_feature_local _2DLUT
				#pragma shader_feature_local _3DLUT


				struct appdata
				{
					float4 vertex : POSITION;
					half3 normal : NORMAL;
					half4 tangent : TANGENT;
					float4 texcoord : TEXCOORD0;
					float4 texcoord1 : TEXCOORD1;
					float4 texcoord2 : TEXCOORD2;
					
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct v2f
				{
					float4 pos : SV_POSITION;
					float4 worldPos : TEXCOORD0; // xyz = positionWS, w = fogCoord
					half3 normalWS : TEXCOORD1;
					float4 tangentWS : TEXCOORD2; // holds terrainUV ifdef ENABLE_TERRAIN_PERPIXEL_NORMAL
					half4 ambientOrLightmapUV : TEXCOORD3;
					UNITY_LIGHTING_COORDS( 4, 5 )
					float4 ase_texcoord6 : TEXCOORD6;
					UNITY_VERTEX_INPUT_INSTANCE_ID
					UNITY_VERTEX_OUTPUT_STEREO
				};

				#ifdef ASE_TRANSMISSION
					float _TransmissionShadow;
				#endif
				#ifdef ASE_TRANSLUCENCY
					float _TransStrength;
					float _TransNormal;
					float _TransScattering;
					float _TransDirect;
					float _TransAmbient;
					float _TransShadow;
				#endif
				#ifdef ASE_TESSELLATION
					float _TessPhongStrength;
					float _TessValue;
					float _TessMin;
					float _TessMax;
					float _TessEdgeLength;
					float _TessMaxDisp;
				#endif

				uniform float _CATEGORY_SURFACEOPTIONS;
				uniform float _EmissionFlags;
				uniform float _CATEGORYEMISSION;
				uniform float _CATEGORYSPACEEMISSION;
				uniform float _CATEGORYLIGHTMAPPING;
				uniform float _CATEGORYSPACELIGHTMAPPING;
				uniform float _CATEGORYSTOCHASTIC;
				uniform float _CATEGORYSPACESTOCHASTIC;
				uniform float _CATEGORYSPACECOLORGRADING;
				uniform float _CATEGORYCOLORGRADING;
				uniform float _CATEGORYSPACESPECIALEFFECTS;
				uniform float _CATEGORYSPECIALEFFECTS;
				uniform sampler2D _2DLut;
				uniform float _LUTSize;
				uniform sampler3D _3DLut;
				uniform float _CATEGORYSPACESURFACEOPTIONS;
				uniform float _UdonSpecularLightCount;
				uniform float4 _UdonSpecularLightUp[32];
				uniform float4 _UdonSpecularLightDir[32];
				uniform float4 _UdonSpecularLightCol[32];
				uniform float4 _UdonSpecularLightPos[32];
				uniform float4 _UdonSpecularLightRight[32];
				uniform half4 _Color;
				uniform sampler2D _MainTex;
				sampler2D _Sampler82966_g65320;
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				sampler2D _Sampler82967_g65320;
				uniform sampler2D _Lightmap0;
				float4 _Lightmap0_TexelSize;
				uniform sampler2D _Lightmap1;
				float4 _Lightmap1_TexelSize;
				uniform float _UdonLightmapLerp;
				uniform sampler2D _BumpMap;
				sampler2D _Sampler82965_g65320;
				uniform sampler2D _UdonRNMX0;
				float4 _UdonRNMX0_TexelSize;
				uniform sampler2D _UdonRNMY0;
				uniform sampler2D _UdonRNMZ0;
				uniform sampler2D _UdonRNMX1;
				float4 _UdonRNMX1_TexelSize;
				uniform sampler2D _UdonRNMY1;
				uniform sampler2D _UdonRNMZ1;
				uniform float3 _EmissionColor;
				uniform sampler2D _EmissionMap;
				sampler2D _Sampler82968_g65320;
				uniform float _EmissionIntensity;
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				sampler2D _Sampler82964_g65320;
				uniform float _IOR;


				float3 IndirectSpecularWithBoxProjection1_g65372( float Color, float Metallic, float Smoothness, float IOR, float3 Fresnel, float3 WorldPos, float3 WorldNormal, float3 ViewDir )
				{
					// --- 1. VECTEURS & NORMALES ---
					// On s'assure que N inclut bien la Normal Map (doit être fait avant d'entrer ici)
					float3 N = normalize(WorldNormal); 
					float3 V = normalize(ViewDir);
					float3 R = reflect(-V, N);
					float nDotV = saturate(dot(N, V));
					// --- 2. RÉFLEXION (Rayon) ---
					float3 ray = R;
					// Correction VRChat : On ne fait la Box Projection que si on est sur un objet statique.
					// Si c'est pour un avatar, il vaut mieux commenter cette section "if".
					if (unity_SpecCube0_ProbePosition.w > 0.0) {
					    float3 factors = ((ray > 0.0 ? unity_SpecCube0_BoxMax.xyz : unity_SpecCube0_BoxMin.xyz) - WorldPos) / ray;
					    float scalar = min(min(factors.x, factors.y), factors.z);
					    // On ajoute un petit "bias" pour éviter que la box ne plaque la normale à plat
					    ray = ray * scalar + (WorldPos - unity_SpecCube0_ProbePosition.xyz);
					}
					// --- 3. PBR F0 & FRESNEL (Smoothness-aware) ---
					// Calcul de l'indice de réfraction (IOR) vers F0
					float f0_ior = pow((IOR - 1.0) / (IOR + 1.0), 2.0);
					float3 F_base = lerp(float3(f0_ior, f0_ior, f0_ior), Color, Metallic);
					// Fresnel de Schlick modifié : on utilise le Smoothness pour éviter le "glow" excessif sur les bords
					float3 fresnelFactor = F_base + (max(float3(Smoothness, Smoothness, Smoothness), F_base) - F_base) * pow(1.0 - nDotV, 5.0);
					// --- 4. SAMPLING ---
					// On utilise une courbe plus douce pour les Mips afin de ne pas perdre le relief trop vite
					float mipLevel = pow(1.0 - Smoothness, 1.5) * 7.0; 
					float4 sampleCube = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, ray, mipLevel);
					float3 indirectSpec = DecodeHDR(sampleCube, unity_SpecCube0_HDR);
					return indirectSpec * fresnelFactor;
				}
				
				float3 Specular( float3 AlbedoColor, float3 LightmapColor, float Metallic, float Smoothness, float IOR, float3 Fresnel, float3 WorldPos, float3 WorldNormal, float3 ViewDir )
				{
					// --- CONFIGURATION ---
					float LumaStart = 0.05;
					float LumaEnd = 1.0;
					float RadiusFadeStart = 7.0;
					float specBoost = 2.0;
					#if defined(SHADER_API_MOBILE)
					    #define MAX_RADIUS 10.0
					#else
					    #define MAX_RADIUS 20.0
					#endif
					// --- INITIALISATION ---
					float3 N = normalize(WorldNormal);
					float3 vDir = normalize(ViewDir);
					// Calcul de F0 (Réflectance de base)
					float3 f0_dielectric = float3(0.04, 0.04, 0.04);
					float3 F0 = lerp(f0_dielectric, AlbedoColor.rgb, Metallic);
					// Masques de distance et de Lightmap
					float luma = dot(LightmapColor, float3(0.22, 0.70, 0.08));
					float lmMask = saturate((luma - LumaStart) / max(LumaEnd - LumaStart, 0.0001));
					float playerDist = distance(_WorldSpaceCameraPos, WorldPos);
					float fadeT = saturate((playerDist - RadiusFadeStart) / max(MAX_RADIUS - RadiusFadeStart, 0.0001));
					float radiusFade = 1.0 - (fadeT * fadeT * (3.0 - 2.0 * fadeT));
					// Sortie précoce
					if (lmMask < 0.001 || Smoothness < 0.01 || _UdonSpecularLightCount == 0 || radiusFade < 0.001) return 0;
					// --- MATHS BLINN-PHONG ---
					// On transforme le Smoothness en exposant (Shininess)
					// On utilise une plage large pour un contrôle fin (jusqu'à 2048)
					float shininess = exp2(10.0 * Smoothness + 1.0); 
					// FACTEUR DE NORMALISATION : C'est ici que la magie opère.
					// Cette formule assure que plus 'shininess' est petit (plus c'est rugueux), 
					// plus l'intensité globale baisse.
					float normalization = (shininess + 8.0) / (8.0 * 3.14159);
					float3 R = reflect(-vDir, N);
					float3 specAccum = 0.0;
					// --- BOUCLE DE LUMIÈRES ---
					for (int i = 0; i < (int)_UdonSpecularLightCount; i++) {
					    float4 posRange = _UdonSpecularLightPos[i];
					    float3 L_center = posRange.xyz - WorldPos;
					    float distSqCenter = dot(L_center, L_center);
					    float rangeSq = posRange.w * posRange.w;
					    if (distSqCenter > rangeSq) continue;
					    float4 dirAngle = _UdonSpecularLightDir[i];
					    float3 L_center_norm = L_center * rsqrt(distSqCenter + 0.00001);
					    float spotMask = saturate((dot(-L_center_norm, dirAngle.xyz) - dirAngle.w) / max(0.01, 1.0 - dirAngle.w));
					    if (spotMask <= 0.0) continue;
					    // Calcul de l'intersection pour Area Lights
					    float denom = dot(dirAngle.xyz, R);
					    // On sécurise le dénominateur pour éviter les divisions par zéro
					    float tPlane = (dirAngle.w < -0.9) ? dot(L_center, R) : (dot(L_center, dirAngle.xyz) / (abs(denom) < 0.001 ? 0.001 : denom));
					    
					    float3 intersection = R * max(0.0, tPlane);
					    float3 localP = (WorldPos + intersection) - posRange.xyz;
					    float2 halfSize = float2(_UdonSpecularLightRight[i].w, _UdonSpecularLightUp[i].w);
					    float2 clampedPos = clamp(float2(dot(localP, _UdonSpecularLightRight[i].xyz), dot(localP, _UdonSpecularLightUp[i].xyz)), -halfSize, halfSize);
					    float3 closestPoint = posRange.xyz + _UdonSpecularLightRight[i].xyz * clampedPos.x + _UdonSpecularLightUp[i].xyz * clampedPos.y;
					    float3 diff = closestPoint - WorldPos;
					    float distSq = dot(diff, diff);
					    float3 lDir = normalize(diff);
					    float3 H = normalize(lDir + vDir);
					    // Calculs de base
					    float nDotL = saturate(dot(N, lDir));
					    float nDotH = saturate(dot(N, H));
					    float hDotV = saturate(dot(H, vDir));
					    // Terme Spéculaire Blinn-Phong Normalisé
					    // nDotH^shininess * normalization
					    float spec = pow(nDotH, shininess) * normalization;
					    // Fresnel (Schlick) : Pour que les bords brillent plus que le centre
					    float3 fresnel = F0 + (1.0 - F0) * pow(1.0 - hDotV, 5.0);
					    // Atténuation de la lumière
					    float falloff = saturate(1.0 - distSqCenter/rangeSq);
					    falloff = (falloff * falloff) / (distSq + 1.0);
					    // Accumulation finale pour cette lumière
					    specAccum += _UdonSpecularLightCol[i].rgb * (spec * fresnel * nDotL * _UdonSpecularLightCol[i].w * falloff * spotMask);
					}
					return specAccum * specBoost * radiusFade * lmMask;
				}
				

				v2f VertexFunction( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					o.ase_texcoord6 = v.texcoord.xyzw;

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

					float3 positionWS = mul( unity_ObjectToWorld, v.vertex ).xyz;
					half3 normalWS = UnityObjectToWorldNormal( v.normal );
					half3 tangentWS = UnityObjectToWorldDir( v.tangent.xyz );

					o.pos = UnityObjectToClipPos( v.vertex );
					o.worldPos.xyz = positionWS;
					o.normalWS = normalWS;
					o.tangentWS = half4( tangentWS, v.tangent.w );

					o.ambientOrLightmapUV = 0;
					#ifdef LIGHTMAP_ON
						o.ambientOrLightmapUV.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					#elif UNITY_SHOULD_SAMPLE_SH
						#ifdef VERTEXLIGHT_ON
							o.ambientOrLightmapUV.rgb += Shade4PointLights(
								unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
								unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
								unity_4LightAtten0, positionWS, normalWS );
						#endif
						o.ambientOrLightmapUV.rgb = ShadeSHPerVertex( normalWS, o.ambientOrLightmapUV.rgb );
					#endif
					#ifdef DYNAMICLIGHTMAP_ON
						o.ambientOrLightmapUV.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
					#endif

					#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
						o.tangentWS.zw = v.texcoord.xy;
						o.tangentWS.xy = v.texcoord.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					#endif

					UNITY_TRANSFER_LIGHTING(o, v.texcoord1.xy);
					#if defined( ASE_FOG )
						UNITY_TRANSFER_FOG_COMBINED_WITH_WORLD_POS( o, o.pos );
					#endif
					return o;
				}

				#if defined(ASE_TESSELLATION)
				struct VertexControl
				{
					float4 vertex : INTERNALTESSPOS;
					half4 tangent : TANGENT;
					half3 normal : NORMAL;
					float4 texcoord : TEXCOORD0;
					float4 texcoord1 : TEXCOORD1;
					float4 texcoord2 : TEXCOORD2;
					
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct TessellationFactors
				{
					float edge[3] : SV_TessFactor;
					float inside : SV_InsideTessFactor;
				};

				VertexControl vert ( appdata v )
				{
					VertexControl o;
					UNITY_SETUP_INSTANCE_ID(v);
					UNITY_TRANSFER_INSTANCE_ID(v, o);
					o.vertex = v.vertex;
					o.tangent = v.tangent;
					o.normal = v.normal;
					o.texcoord = v.texcoord;
					o.texcoord1 = v.texcoord1;
					o.texcoord2 = v.texcoord2;
					
					return o;
				}

				TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
				{
					TessellationFactors o;
					float4 tf = 1;
					float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
					float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
					#if defined(ASE_FIXED_TESSELLATION)
					tf = FixedTess( tessValue );
					#elif defined(ASE_DISTANCE_TESSELLATION)
					tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, UNITY_MATRIX_M, _WorldSpaceCameraPos );
					#elif defined(ASE_LENGTH_TESSELLATION)
					tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams );
					#elif defined(ASE_LENGTH_CULL_TESSELLATION)
					tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
					#endif
					o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
					return o;
				}

				[domain("tri")]
				[partitioning("fractional_odd")]
				[outputtopology("triangle_cw")]
				[patchconstantfunc("TessellationFunction")]
				[outputcontrolpoints(3)]
				VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
				{
				   return patch[id];
				}

				[domain("tri")]
				v2f DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
				{
					appdata o = (appdata) 0;
					o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
					o.tangent = patch[0].tangent * bary.x + patch[1].tangent * bary.y + patch[2].tangent * bary.z;
					o.normal = patch[0].normal * bary.x + patch[1].normal * bary.y + patch[2].normal * bary.z;
					o.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
					o.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
					o.texcoord2 = patch[0].texcoord2 * bary.x + patch[1].texcoord2 * bary.y + patch[2].texcoord2 * bary.z;
					
					#if defined(ASE_PHONG_TESSELLATION)
					float3 pp[3];
					for (int i = 0; i < 3; ++i)
						pp[i] = o.vertex.xyz - patch[i].normal * (dot(o.vertex.xyz, patch[i].normal) - dot(patch[i].vertex.xyz, patch[i].normal));
					float phongStrength = _TessPhongStrength;
					o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
					#endif
					UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
					return VertexFunction(o);
				}
				#else
				v2f vert ( appdata v )
				{
					return VertexFunction( v );
				}
				#endif

				half4 frag( v2f IN , uint ase_vface : SV_IsFrontFace
							#if defined( ASE_DEPTH_WRITE_ON )
								, out float outputDepth : SV_Depth
							#endif
							) : SV_Target
				{
					UNITY_SETUP_INSTANCE_ID(IN);

					#ifdef LOD_FADE_CROSSFADE
						UNITY_APPLY_DITHER_CROSSFADE(IN.pos.xy);
					#endif

					#if defined(ASE_LIGHTING_SIMPLE)
						SurfaceOutput o = (SurfaceOutput)0;
					#else
						#if defined(_SPECULAR_SETUP)
							SurfaceOutputStandardSpecular o = (SurfaceOutputStandardSpecular)0;
						#else
							SurfaceOutputStandard o = (SurfaceOutputStandard)0;
						#endif
					#endif

					half atten;
					{
						#if defined( ASE_RECEIVE_SHADOWS )
							UNITY_LIGHT_ATTENUATION( temp, IN, IN.worldPos.xyz )
							atten = temp;
						#else
							atten = 1;
						#endif
					}

					float3 PositionWS = IN.worldPos.xyz;
					half3 ViewDirWS = normalize( UnityWorldSpaceViewDir( PositionWS ) );
					float4 ScreenPosNorm = float4( IN.pos.xy * ( _ScreenParams.zw - 1.0 ), IN.pos.zw );
					float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, IN.pos.z ) * IN.pos.w;
					float4 ScreenPos = ComputeScreenPos( ClipPos );
					half3 NormalWS = IN.normalWS;
					half3 TangentWS = IN.tangentWS.xyz;
					half3 BitangentWS = cross( IN.normalWS, IN.tangentWS.xyz ) * IN.tangentWS.w * unity_WorldTransformParams.w;
					half3 LightAtten = atten;

					#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
						float2 sampleCoords = (IN.tangentWS.zw / _TerrainHeightmapRecipSize.zw + 0.5f) * _TerrainHeightmapRecipSize.xy;
						NormalWS = UnityObjectToWorldNormal(normalize(tex2D(_TerrainNormalmapTexture, sampleCoords).rgb * 2 - 1));
						TangentWS = -cross(unity_ObjectToWorld._13_23_33, NormalWS);
						BitangentWS = cross(NormalWS, -TangentWS);
					#endif

					float2 texCoord2357_g65320 = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0A2420_g65320 = texCoord2357_g65320;
					#ifdef _MAINTEX
					float4 staticSwitch1549_g65320 = tex2D( _MainTex, UV0A2420_g65320 );
					#else
					float4 staticSwitch1549_g65320 = _Color;
					#endif
					float2 temp_output_5_0_g65346 = UV0A2420_g65320;
					float2 UV633_g65346 = temp_output_5_0_g65346;
					float2 UV100_g65347 = UV633_g65346;
					float2 temp_output_51_0_g65347 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g65347 * float2( 3.464,3.464 ) ) );
					float2 break55_g65347 = frac( temp_output_51_0_g65347 );
					float temp_output_56_0_g65347 = ( ( 1.0 - break55_g65347.x ) - break55_g65347.y );
					float2 temp_output_52_0_g65347 = floor( temp_output_51_0_g65347 );
					float2 temp_output_125_0_g65347 = ( temp_output_52_0_g65347 + float2( 1,1 ) );
					float2 ifLocalVar87_g65347 = 0;
					if( temp_output_56_0_g65347 > 0.0 )
					ifLocalVar87_g65347 = temp_output_52_0_g65347;
					else if( temp_output_56_0_g65347 == 0.0 )
					ifLocalVar87_g65347 = temp_output_125_0_g65347;
					else if( temp_output_56_0_g65347 < 0.0 )
					ifLocalVar87_g65347 = temp_output_125_0_g65347;
					float3 temp_output_7_0_g65348 = frac( ( (ifLocalVar87_g65347).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g65348 = dot( temp_output_7_0_g65348 , ( (temp_output_7_0_g65348).yzx + 33.33 ) );
					float3 temp_output_12_0_g65348 = ( temp_output_7_0_g65348 + dotResult8_g65348 );
					float2 temp_output_597_0_g65346 = ( UV100_g65347 + frac( ( ( (temp_output_12_0_g65348).xx + (temp_output_12_0_g65348).yz ) * (temp_output_12_0_g65348).zy ) ) );
					float2 DDX631_g65346 = ddx( temp_output_5_0_g65346 );
					float2 DDY632_g65346 = ddy( temp_output_5_0_g65346 );
					float temp_output_65_0_g65347 = ( 0.0 - temp_output_56_0_g65347 );
					float ifLocalVar59_g65347 = 0;
					if( temp_output_56_0_g65347 <= 0.0 )
					ifLocalVar59_g65347 = temp_output_65_0_g65347;
					else
					ifLocalVar59_g65347 = temp_output_56_0_g65347;
					float temp_output_597_30_g65346 = ifLocalVar59_g65347;
					float2 temp_output_90_0_g65347 = ( temp_output_52_0_g65347 + float2( 0,1 ) );
					float2 temp_output_123_0_g65347 = ( temp_output_52_0_g65347 + float2( 1,0 ) );
					float2 ifLocalVar88_g65347 = 0;
					if( temp_output_56_0_g65347 > 0.0 )
					ifLocalVar88_g65347 = temp_output_90_0_g65347;
					else if( temp_output_56_0_g65347 == 0.0 )
					ifLocalVar88_g65347 = temp_output_123_0_g65347;
					else if( temp_output_56_0_g65347 < 0.0 )
					ifLocalVar88_g65347 = temp_output_123_0_g65347;
					float3 temp_output_7_0_g65349 = frac( ( (ifLocalVar88_g65347).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g65349 = dot( temp_output_7_0_g65349 , ( (temp_output_7_0_g65349).yzx + 33.33 ) );
					float3 temp_output_12_0_g65349 = ( temp_output_7_0_g65349 + dotResult8_g65349 );
					float2 temp_output_597_26_g65346 = ( UV100_g65347 + frac( ( ( (temp_output_12_0_g65349).xx + (temp_output_12_0_g65349).yz ) * (temp_output_12_0_g65349).zy ) ) );
					float temp_output_66_0_g65347 = ( 1.0 - break55_g65347.y );
					float ifLocalVar60_g65347 = 0;
					if( temp_output_56_0_g65347 <= 0.0 )
					ifLocalVar60_g65347 = temp_output_66_0_g65347;
					else
					ifLocalVar60_g65347 = break55_g65347.y;
					float temp_output_597_28_g65346 = ifLocalVar60_g65347;
					float2 ifLocalVar89_g65347 = 0;
					if( temp_output_56_0_g65347 > 0.0 )
					ifLocalVar89_g65347 = temp_output_123_0_g65347;
					else if( temp_output_56_0_g65347 == 0.0 )
					ifLocalVar89_g65347 = temp_output_90_0_g65347;
					else if( temp_output_56_0_g65347 < 0.0 )
					ifLocalVar89_g65347 = temp_output_90_0_g65347;
					float3 temp_output_7_0_g65350 = frac( ( (ifLocalVar89_g65347).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g65350 = dot( temp_output_7_0_g65350 , ( (temp_output_7_0_g65350).yzx + 33.33 ) );
					float3 temp_output_12_0_g65350 = ( temp_output_7_0_g65350 + dotResult8_g65350 );
					float2 temp_output_597_27_g65346 = ( UV100_g65347 + frac( ( ( (temp_output_12_0_g65350).xx + (temp_output_12_0_g65350).yz ) * (temp_output_12_0_g65350).zy ) ) );
					float temp_output_67_0_g65347 = ( 1.0 - break55_g65347.x );
					float ifLocalVar61_g65347 = 0;
					if( temp_output_56_0_g65347 <= 0.0 )
					ifLocalVar61_g65347 = temp_output_67_0_g65347;
					else
					ifLocalVar61_g65347 = break55_g65347.x;
					float temp_output_597_29_g65346 = ifLocalVar61_g65347;
					float4 Output_2D293_g65346 = ( ( tex2D( _Sampler82966_g65320, temp_output_597_0_g65346, DDX631_g65346, DDY632_g65346 ) * temp_output_597_30_g65346 ) + ( tex2D( _Sampler82966_g65320, temp_output_597_26_g65346, DDX631_g65346, DDY632_g65346 ) * temp_output_597_28_g65346 ) + ( tex2D( _Sampler82966_g65320, temp_output_597_27_g65346, DDX631_g65346, DDY632_g65346 ) * temp_output_597_29_g65346 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g65320 = Output_2D293_g65346;
					#else
					float4 staticSwitch1001_g65320 = staticSwitch1549_g65320;
					#endif
					float3 temp_output_2532_0_g65320 = (staticSwitch1001_g65320).rgb;
					float3 oAlbedo6_g65320 = temp_output_2532_0_g65320;
					float Black1185_g65320 = 0.0;
					float3 temp_cast_0 = (Black1185_g65320).xxx;
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch1180_g65320 = temp_cast_0;
					#else
					float3 staticSwitch1180_g65320 = oAlbedo6_g65320;
					#endif
					
					#ifdef _METALLICMAP
					float staticSwitch846_g65320 = tex2D( _MetallicMap, UV0A2420_g65320 ).r;
					#else
					float staticSwitch846_g65320 = _Metallic;
					#endif
					float2 temp_output_5_0_g65341 = UV0A2420_g65320;
					float2 UV633_g65341 = temp_output_5_0_g65341;
					float2 UV100_g65342 = UV633_g65341;
					float2 temp_output_51_0_g65342 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g65342 * float2( 3.464,3.464 ) ) );
					float2 break55_g65342 = frac( temp_output_51_0_g65342 );
					float temp_output_56_0_g65342 = ( ( 1.0 - break55_g65342.x ) - break55_g65342.y );
					float2 temp_output_52_0_g65342 = floor( temp_output_51_0_g65342 );
					float2 temp_output_125_0_g65342 = ( temp_output_52_0_g65342 + float2( 1,1 ) );
					float2 ifLocalVar87_g65342 = 0;
					if( temp_output_56_0_g65342 > 0.0 )
					ifLocalVar87_g65342 = temp_output_52_0_g65342;
					else if( temp_output_56_0_g65342 == 0.0 )
					ifLocalVar87_g65342 = temp_output_125_0_g65342;
					else if( temp_output_56_0_g65342 < 0.0 )
					ifLocalVar87_g65342 = temp_output_125_0_g65342;
					float3 temp_output_7_0_g65343 = frac( ( (ifLocalVar87_g65342).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g65343 = dot( temp_output_7_0_g65343 , ( (temp_output_7_0_g65343).yzx + 33.33 ) );
					float3 temp_output_12_0_g65343 = ( temp_output_7_0_g65343 + dotResult8_g65343 );
					float2 temp_output_597_0_g65341 = ( UV100_g65342 + frac( ( ( (temp_output_12_0_g65343).xx + (temp_output_12_0_g65343).yz ) * (temp_output_12_0_g65343).zy ) ) );
					float2 DDX631_g65341 = ddx( temp_output_5_0_g65341 );
					float2 DDY632_g65341 = ddy( temp_output_5_0_g65341 );
					float temp_output_65_0_g65342 = ( 0.0 - temp_output_56_0_g65342 );
					float ifLocalVar59_g65342 = 0;
					if( temp_output_56_0_g65342 <= 0.0 )
					ifLocalVar59_g65342 = temp_output_65_0_g65342;
					else
					ifLocalVar59_g65342 = temp_output_56_0_g65342;
					float temp_output_597_30_g65341 = ifLocalVar59_g65342;
					float2 temp_output_90_0_g65342 = ( temp_output_52_0_g65342 + float2( 0,1 ) );
					float2 temp_output_123_0_g65342 = ( temp_output_52_0_g65342 + float2( 1,0 ) );
					float2 ifLocalVar88_g65342 = 0;
					if( temp_output_56_0_g65342 > 0.0 )
					ifLocalVar88_g65342 = temp_output_90_0_g65342;
					else if( temp_output_56_0_g65342 == 0.0 )
					ifLocalVar88_g65342 = temp_output_123_0_g65342;
					else if( temp_output_56_0_g65342 < 0.0 )
					ifLocalVar88_g65342 = temp_output_123_0_g65342;
					float3 temp_output_7_0_g65344 = frac( ( (ifLocalVar88_g65342).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g65344 = dot( temp_output_7_0_g65344 , ( (temp_output_7_0_g65344).yzx + 33.33 ) );
					float3 temp_output_12_0_g65344 = ( temp_output_7_0_g65344 + dotResult8_g65344 );
					float2 temp_output_597_26_g65341 = ( UV100_g65342 + frac( ( ( (temp_output_12_0_g65344).xx + (temp_output_12_0_g65344).yz ) * (temp_output_12_0_g65344).zy ) ) );
					float temp_output_66_0_g65342 = ( 1.0 - break55_g65342.y );
					float ifLocalVar60_g65342 = 0;
					if( temp_output_56_0_g65342 <= 0.0 )
					ifLocalVar60_g65342 = temp_output_66_0_g65342;
					else
					ifLocalVar60_g65342 = break55_g65342.y;
					float temp_output_597_28_g65341 = ifLocalVar60_g65342;
					float2 ifLocalVar89_g65342 = 0;
					if( temp_output_56_0_g65342 > 0.0 )
					ifLocalVar89_g65342 = temp_output_123_0_g65342;
					else if( temp_output_56_0_g65342 == 0.0 )
					ifLocalVar89_g65342 = temp_output_90_0_g65342;
					else if( temp_output_56_0_g65342 < 0.0 )
					ifLocalVar89_g65342 = temp_output_90_0_g65342;
					float3 temp_output_7_0_g65345 = frac( ( (ifLocalVar89_g65342).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g65345 = dot( temp_output_7_0_g65345 , ( (temp_output_7_0_g65345).yzx + 33.33 ) );
					float3 temp_output_12_0_g65345 = ( temp_output_7_0_g65345 + dotResult8_g65345 );
					float2 temp_output_597_27_g65341 = ( UV100_g65342 + frac( ( ( (temp_output_12_0_g65345).xx + (temp_output_12_0_g65345).yz ) * (temp_output_12_0_g65345).zy ) ) );
					float temp_output_67_0_g65342 = ( 1.0 - break55_g65342.x );
					float ifLocalVar61_g65342 = 0;
					if( temp_output_56_0_g65342 <= 0.0 )
					ifLocalVar61_g65342 = temp_output_67_0_g65342;
					else
					ifLocalVar61_g65342 = break55_g65342.x;
					float temp_output_597_29_g65341 = ifLocalVar61_g65342;
					float4 Output_2D293_g65341 = ( ( tex2D( _Sampler82967_g65320, temp_output_597_0_g65341, DDX631_g65341, DDY632_g65341 ) * temp_output_597_30_g65341 ) + ( tex2D( _Sampler82967_g65320, temp_output_597_26_g65341, DDX631_g65341, DDY632_g65341 ) * temp_output_597_28_g65341 ) + ( tex2D( _Sampler82967_g65320, temp_output_597_27_g65341, DDX631_g65341, DDY632_g65341 ) * temp_output_597_29_g65341 ) );
					float4 break31_g65341 = Output_2D293_g65341;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g65320 = break31_g65341.r;
					#else
					float staticSwitch1005_g65320 = staticSwitch846_g65320;
					#endif
					float Metallic1239_g65320 = staticSwitch1005_g65320;
					float3 aAlbedo1466_g65320 = ( temp_output_2532_0_g65320 * ( 1.0 - Metallic1239_g65320 ) );
					float White38_g65320 = 1.0;
					float4 temp_cast_1 = (White38_g65320).xxxx;
					float4 texCoord2426_g65320 = IN.ase_texcoord6;
					texCoord2426_g65320.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0B2361_g65320 = (texCoord2426_g65320).zw;
					float localBicubicPrepare2_g65329 = ( 0.0 );
					float2 Input_UV100_g65329 = UV0B2361_g65320;
					float2 UV2_g65329 = Input_UV100_g65329;
					float4 TexelSize2_g65329 = _Lightmap0_TexelSize;
					float2 UV02_g65329 = float2( 0,0 );
					float2 UV12_g65329 = float2( 0,0 );
					float2 UV22_g65329 = float2( 0,0 );
					float2 UV32_g65329 = float2( 0,0 );
					float W02_g65329 = 0;
					float W12_g65329 = 0;
					{
					{
					 UV2_g65329 = UV2_g65329 * TexelSize2_g65329.zw - 0.5;
					    float2 f = frac( UV2_g65329 );
					    UV2_g65329 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g65329.x - 0.5, UV2_g65329.x + 1.5, UV2_g65329.y - 0.5, UV2_g65329.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g65329.xyxy;
					    UV02_g65329 = off.xz;
					    UV12_g65329 = off.yz;
					    UV22_g65329 = off.xw;
					    UV32_g65329 = off.yw;
					    W02_g65329 = s.x / ( s.x + s.y );
					 W12_g65329 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g65329 = lerp( tex2D( _Lightmap0, UV32_g65329 ) , tex2D( _Lightmap0, UV22_g65329 ) , W02_g65329);
					float4 lerpResult45_g65329 = lerp( tex2D( _Lightmap0, UV12_g65329 ) , tex2D( _Lightmap0, UV02_g65329 ) , W02_g65329);
					float4 lerpResult44_g65329 = lerp( lerpResult46_g65329 , lerpResult45_g65329 , W12_g65329);
					float4 Output_2D_Auto131_g65329 = lerpResult44_g65329;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g65320 = Output_2D_Auto131_g65329;
					#else
					float4 staticSwitch1092_g65320 = float4( tex2D( _Lightmap0, UV0B2361_g65320 ).rgb , 0.0 );
					#endif
					float4 Lightmap_0925_g65320 = staticSwitch1092_g65320;
					float localBicubicPrepare2_g65327 = ( 0.0 );
					float2 Input_UV100_g65327 = UV0B2361_g65320;
					float2 UV2_g65327 = Input_UV100_g65327;
					float4 TexelSize2_g65327 = _Lightmap1_TexelSize;
					float2 UV02_g65327 = float2( 0,0 );
					float2 UV12_g65327 = float2( 0,0 );
					float2 UV22_g65327 = float2( 0,0 );
					float2 UV32_g65327 = float2( 0,0 );
					float W02_g65327 = 0;
					float W12_g65327 = 0;
					{
					{
					 UV2_g65327 = UV2_g65327 * TexelSize2_g65327.zw - 0.5;
					    float2 f = frac( UV2_g65327 );
					    UV2_g65327 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g65327.x - 0.5, UV2_g65327.x + 1.5, UV2_g65327.y - 0.5, UV2_g65327.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g65327.xyxy;
					    UV02_g65327 = off.xz;
					    UV12_g65327 = off.yz;
					    UV22_g65327 = off.xw;
					    UV32_g65327 = off.yw;
					    W02_g65327 = s.x / ( s.x + s.y );
					 W12_g65327 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g65327 = lerp( tex2D( _Lightmap1, UV32_g65327 ) , tex2D( _Lightmap1, UV22_g65327 ) , W02_g65327);
					float4 lerpResult45_g65327 = lerp( tex2D( _Lightmap1, UV12_g65327 ) , tex2D( _Lightmap1, UV02_g65327 ) , W02_g65327);
					float4 lerpResult44_g65327 = lerp( lerpResult46_g65327 , lerpResult45_g65327 , W12_g65327);
					float4 Output_2D_Auto131_g65327 = lerpResult44_g65327;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g65320 = Output_2D_Auto131_g65327;
					#else
					float4 staticSwitch1088_g65320 = tex2D( _Lightmap1, UV0B2361_g65320 );
					#endif
					float4 Lightmap_1956_g65320 = staticSwitch1088_g65320;
					float Lightmap_Lerp_Value969_g65320 = _UdonLightmapLerp;
					float4 lerpResult442_g65320 = lerp( Lightmap_0925_g65320 , Lightmap_1956_g65320 , Lightmap_Lerp_Value969_g65320);
					float4 Lightmap_Lerp932_g65320 = lerpResult442_g65320;
					float3 appendResult139_g65366 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float2 temp_output_5_0_g65336 = UV0A2420_g65320;
					float2 UV633_g65336 = temp_output_5_0_g65336;
					float2 UV100_g65337 = UV633_g65336;
					float2 temp_output_51_0_g65337 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g65337 * float2( 3.464,3.464 ) ) );
					float2 break55_g65337 = frac( temp_output_51_0_g65337 );
					float temp_output_56_0_g65337 = ( ( 1.0 - break55_g65337.x ) - break55_g65337.y );
					float2 temp_output_52_0_g65337 = floor( temp_output_51_0_g65337 );
					float2 temp_output_125_0_g65337 = ( temp_output_52_0_g65337 + float2( 1,1 ) );
					float2 ifLocalVar87_g65337 = 0;
					if( temp_output_56_0_g65337 > 0.0 )
					ifLocalVar87_g65337 = temp_output_52_0_g65337;
					else if( temp_output_56_0_g65337 == 0.0 )
					ifLocalVar87_g65337 = temp_output_125_0_g65337;
					else if( temp_output_56_0_g65337 < 0.0 )
					ifLocalVar87_g65337 = temp_output_125_0_g65337;
					float3 temp_output_7_0_g65338 = frac( ( (ifLocalVar87_g65337).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g65338 = dot( temp_output_7_0_g65338 , ( (temp_output_7_0_g65338).yzx + 33.33 ) );
					float3 temp_output_12_0_g65338 = ( temp_output_7_0_g65338 + dotResult8_g65338 );
					float2 temp_output_597_0_g65336 = ( UV100_g65337 + frac( ( ( (temp_output_12_0_g65338).xx + (temp_output_12_0_g65338).yz ) * (temp_output_12_0_g65338).zy ) ) );
					float2 DDX631_g65336 = ddx( temp_output_5_0_g65336 );
					float2 DDY632_g65336 = ddy( temp_output_5_0_g65336 );
					float Input_Scale617_g65336 = 1.5;
					float temp_output_65_0_g65337 = ( 0.0 - temp_output_56_0_g65337 );
					float ifLocalVar59_g65337 = 0;
					if( temp_output_56_0_g65337 <= 0.0 )
					ifLocalVar59_g65337 = temp_output_65_0_g65337;
					else
					ifLocalVar59_g65337 = temp_output_56_0_g65337;
					float temp_output_597_30_g65336 = ifLocalVar59_g65337;
					float2 temp_output_90_0_g65337 = ( temp_output_52_0_g65337 + float2( 0,1 ) );
					float2 temp_output_123_0_g65337 = ( temp_output_52_0_g65337 + float2( 1,0 ) );
					float2 ifLocalVar88_g65337 = 0;
					if( temp_output_56_0_g65337 > 0.0 )
					ifLocalVar88_g65337 = temp_output_90_0_g65337;
					else if( temp_output_56_0_g65337 == 0.0 )
					ifLocalVar88_g65337 = temp_output_123_0_g65337;
					else if( temp_output_56_0_g65337 < 0.0 )
					ifLocalVar88_g65337 = temp_output_123_0_g65337;
					float3 temp_output_7_0_g65339 = frac( ( (ifLocalVar88_g65337).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g65339 = dot( temp_output_7_0_g65339 , ( (temp_output_7_0_g65339).yzx + 33.33 ) );
					float3 temp_output_12_0_g65339 = ( temp_output_7_0_g65339 + dotResult8_g65339 );
					float2 temp_output_597_26_g65336 = ( UV100_g65337 + frac( ( ( (temp_output_12_0_g65339).xx + (temp_output_12_0_g65339).yz ) * (temp_output_12_0_g65339).zy ) ) );
					float temp_output_66_0_g65337 = ( 1.0 - break55_g65337.y );
					float ifLocalVar60_g65337 = 0;
					if( temp_output_56_0_g65337 <= 0.0 )
					ifLocalVar60_g65337 = temp_output_66_0_g65337;
					else
					ifLocalVar60_g65337 = break55_g65337.y;
					float temp_output_597_28_g65336 = ifLocalVar60_g65337;
					float2 ifLocalVar89_g65337 = 0;
					if( temp_output_56_0_g65337 > 0.0 )
					ifLocalVar89_g65337 = temp_output_123_0_g65337;
					else if( temp_output_56_0_g65337 == 0.0 )
					ifLocalVar89_g65337 = temp_output_90_0_g65337;
					else if( temp_output_56_0_g65337 < 0.0 )
					ifLocalVar89_g65337 = temp_output_90_0_g65337;
					float3 temp_output_7_0_g65340 = frac( ( (ifLocalVar89_g65337).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g65340 = dot( temp_output_7_0_g65340 , ( (temp_output_7_0_g65340).yzx + 33.33 ) );
					float3 temp_output_12_0_g65340 = ( temp_output_7_0_g65340 + dotResult8_g65340 );
					float2 temp_output_597_27_g65336 = ( UV100_g65337 + frac( ( ( (temp_output_12_0_g65340).xx + (temp_output_12_0_g65340).yz ) * (temp_output_12_0_g65340).zy ) ) );
					float temp_output_67_0_g65337 = ( 1.0 - break55_g65337.x );
					float ifLocalVar61_g65337 = 0;
					if( temp_output_56_0_g65337 <= 0.0 )
					ifLocalVar61_g65337 = temp_output_67_0_g65337;
					else
					ifLocalVar61_g65337 = break55_g65337.x;
					float temp_output_597_29_g65336 = ifLocalVar61_g65337;
					float3 Output_2D_Normal641_g65336 = ( ( UnpackScaleNormal( tex2D( _Sampler82965_g65320, temp_output_597_0_g65336, DDX631_g65336, DDY632_g65336 ), Input_Scale617_g65336 ) * temp_output_597_30_g65336 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g65320, temp_output_597_26_g65336, DDX631_g65336, DDY632_g65336 ), Input_Scale617_g65336 ) * temp_output_597_28_g65336 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g65320, temp_output_597_27_g65336, DDX631_g65336, DDY632_g65336 ), Input_Scale617_g65336 ) * float3( 0,0,0 ) * temp_output_597_29_g65336 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g65320 = Output_2D_Normal641_g65336;
					#else
					float3 staticSwitch1003_g65320 = UnpackScaleNormal( tex2D( _BumpMap, UV0A2420_g65320 ), 1.5 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g65320 = staticSwitch1003_g65320;
					#else
					float3 staticSwitch980_g65320 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g65320 = staticSwitch980_g65320;
					float3 normalizeResult326_g65366 = normalize( Normal_Map700_g65320 );
					float3 Normal_Map318_g65366 = normalizeResult326_g65366;
					float dotResult121_g65366 = dot( appendResult139_g65366 , Normal_Map318_g65366 );
					float temp_output_2_0_g65368 = saturate( dotResult121_g65366 );
					float localStochasticTiling2_g65362 = ( 0.0 );
					float2 UV2_g65362 = UV0B2361_g65320;
					float4 TexelSize2_g65362 = _UdonRNMX0_TexelSize;
					float4 Offsets2_g65362 = float4( 0,0,0,0 );
					float2 Weights2_g65362 = float2( 0,0 );
					{
					UV2_g65362 = UV2_g65362 * TexelSize2_g65362.zw - 0.5;
					float2 f = frac( UV2_g65362 );
					UV2_g65362 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g65362.x - 0.5, UV2_g65362.x + 1.5, UV2_g65362.y - 0.5, UV2_g65362.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g65362 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g65362.xyxy;
					Weights2_g65362 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g65361 = Offsets2_g65362;
					float4 Input_FetchOffsets197_g65363 = temp_output_1_34_g65361;
					float2 temp_output_1_54_g65361 = Weights2_g65362;
					float2 Input_FetchWeights200_g65363 = temp_output_1_54_g65361;
					float2 break187_g65363 = Input_FetchWeights200_g65363;
					float4 lerpResult181_g65363 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g65363).yw ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g65363).xw ) , break187_g65363.x);
					float4 lerpResult182_g65363 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g65363).yz ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g65363).xz ) , break187_g65363.x);
					float4 lerpResult176_g65363 = lerp( lerpResult181_g65363 , lerpResult182_g65363 , break187_g65363.y);
					float4 Output_Fetch2D_Auto202_g65363 = lerpResult176_g65363;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g65320 = Output_Fetch2D_Auto202_g65363;
					#else
					float4 staticSwitch1061_g65320 = tex2D( _UdonRNMX0, UV0B2361_g65320 );
					#endif
					float3 appendResult146_g65366 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g65366 = dot( appendResult146_g65366 , Normal_Map318_g65366 );
					float temp_output_2_0_g65367 = saturate( dotResult122_g65366 );
					float4 Input_FetchOffsets197_g65364 = temp_output_1_34_g65361;
					float2 Input_FetchWeights200_g65364 = temp_output_1_54_g65361;
					float2 break187_g65364 = Input_FetchWeights200_g65364;
					float4 lerpResult181_g65364 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g65364).yw ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g65364).xw ) , break187_g65364.x);
					float4 lerpResult182_g65364 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g65364).yz ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g65364).xz ) , break187_g65364.x);
					float4 lerpResult176_g65364 = lerp( lerpResult181_g65364 , lerpResult182_g65364 , break187_g65364.y);
					float4 Output_Fetch2D_Auto202_g65364 = lerpResult176_g65364;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g65320 = Output_Fetch2D_Auto202_g65364;
					#else
					float4 staticSwitch1062_g65320 = tex2D( _UdonRNMY0, UV0B2361_g65320 );
					#endif
					float3 appendResult149_g65366 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g65366 = dot( appendResult149_g65366 , Normal_Map318_g65366 );
					float temp_output_2_0_g65369 = saturate( dotResult120_g65366 );
					float4 Input_FetchOffsets197_g65365 = temp_output_1_34_g65361;
					float2 Input_FetchWeights200_g65365 = temp_output_1_54_g65361;
					float2 break187_g65365 = Input_FetchWeights200_g65365;
					float4 lerpResult181_g65365 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g65365).yw ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g65365).xw ) , break187_g65365.x);
					float4 lerpResult182_g65365 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g65365).yz ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g65365).xz ) , break187_g65365.x);
					float4 lerpResult176_g65365 = lerp( lerpResult181_g65365 , lerpResult182_g65365 , break187_g65365.y);
					float4 Output_Fetch2D_Auto202_g65365 = lerpResult176_g65365;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g65320 = Output_Fetch2D_Auto202_g65365;
					#else
					float4 staticSwitch1063_g65320 = tex2D( _UdonRNMZ0, UV0B2361_g65320 );
					#endif
					float4 RNM_0926_g65320 = ( ( ( ( ( temp_output_2_0_g65368 * temp_output_2_0_g65368 ) * staticSwitch1061_g65320 ) + ( ( temp_output_2_0_g65367 * temp_output_2_0_g65367 ) * staticSwitch1062_g65320 ) ) + ( ( temp_output_2_0_g65369 * temp_output_2_0_g65369 ) * staticSwitch1063_g65320 ) ) * 1.5 );
					float3 appendResult139_g65332 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g65332 = normalize( Normal_Map700_g65320 );
					float3 Normal_Map318_g65332 = normalizeResult326_g65332;
					float dotResult121_g65332 = dot( appendResult139_g65332 , Normal_Map318_g65332 );
					float temp_output_2_0_g65334 = saturate( dotResult121_g65332 );
					float localStochasticTiling2_g65322 = ( 0.0 );
					float2 UV2_g65322 = UV0B2361_g65320;
					float4 TexelSize2_g65322 = _UdonRNMX1_TexelSize;
					float4 Offsets2_g65322 = float4( 0,0,0,0 );
					float2 Weights2_g65322 = float2( 0,0 );
					{
					UV2_g65322 = UV2_g65322 * TexelSize2_g65322.zw - 0.5;
					float2 f = frac( UV2_g65322 );
					UV2_g65322 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g65322.x - 0.5, UV2_g65322.x + 1.5, UV2_g65322.y - 0.5, UV2_g65322.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g65322 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g65322.xyxy;
					Weights2_g65322 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g65321 = Offsets2_g65322;
					float4 Input_FetchOffsets197_g65323 = temp_output_1_34_g65321;
					float2 temp_output_1_54_g65321 = Weights2_g65322;
					float2 Input_FetchWeights200_g65323 = temp_output_1_54_g65321;
					float2 break187_g65323 = Input_FetchWeights200_g65323;
					float4 lerpResult181_g65323 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g65323).yw ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g65323).xw ) , break187_g65323.x);
					float4 lerpResult182_g65323 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g65323).yz ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g65323).xz ) , break187_g65323.x);
					float4 lerpResult176_g65323 = lerp( lerpResult181_g65323 , lerpResult182_g65323 , break187_g65323.y);
					float4 Output_Fetch2D_Auto202_g65323 = lerpResult176_g65323;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g65320 = Output_Fetch2D_Auto202_g65323;
					#else
					float4 staticSwitch1087_g65320 = tex2D( _UdonRNMX1, UV0B2361_g65320 );
					#endif
					float3 appendResult146_g65332 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g65332 = dot( appendResult146_g65332 , Normal_Map318_g65332 );
					float temp_output_2_0_g65333 = saturate( dotResult122_g65332 );
					float4 Input_FetchOffsets197_g65324 = temp_output_1_34_g65321;
					float2 Input_FetchWeights200_g65324 = temp_output_1_54_g65321;
					float2 break187_g65324 = Input_FetchWeights200_g65324;
					float4 lerpResult181_g65324 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g65324).yw ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g65324).xw ) , break187_g65324.x);
					float4 lerpResult182_g65324 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g65324).yz ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g65324).xz ) , break187_g65324.x);
					float4 lerpResult176_g65324 = lerp( lerpResult181_g65324 , lerpResult182_g65324 , break187_g65324.y);
					float4 Output_Fetch2D_Auto202_g65324 = lerpResult176_g65324;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g65320 = Output_Fetch2D_Auto202_g65324;
					#else
					float4 staticSwitch1083_g65320 = tex2D( _UdonRNMY1, UV0B2361_g65320 );
					#endif
					float3 appendResult149_g65332 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g65332 = dot( appendResult149_g65332 , Normal_Map318_g65332 );
					float temp_output_2_0_g65335 = saturate( dotResult120_g65332 );
					float4 Input_FetchOffsets197_g65325 = temp_output_1_34_g65321;
					float2 Input_FetchWeights200_g65325 = temp_output_1_54_g65321;
					float2 break187_g65325 = Input_FetchWeights200_g65325;
					float4 lerpResult181_g65325 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g65325).yw ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g65325).xw ) , break187_g65325.x);
					float4 lerpResult182_g65325 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g65325).yz ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g65325).xz ) , break187_g65325.x);
					float4 lerpResult176_g65325 = lerp( lerpResult181_g65325 , lerpResult182_g65325 , break187_g65325.y);
					float4 Output_Fetch2D_Auto202_g65325 = lerpResult176_g65325;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g65320 = Output_Fetch2D_Auto202_g65325;
					#else
					float4 staticSwitch1084_g65320 = tex2D( _UdonRNMZ1, UV0B2361_g65320 );
					#endif
					float4 RNM_11081_g65320 = ( ( ( ( ( temp_output_2_0_g65334 * temp_output_2_0_g65334 ) * staticSwitch1087_g65320 ) + ( ( temp_output_2_0_g65333 * temp_output_2_0_g65333 ) * staticSwitch1083_g65320 ) ) + ( ( temp_output_2_0_g65335 * temp_output_2_0_g65335 ) * staticSwitch1084_g65320 ) ) * 1.5 );
					float4 lerpResult953_g65320 = lerp( RNM_0926_g65320 , RNM_11081_g65320 , Lightmap_Lerp_Value969_g65320);
					float4 RNM_Lerp950_g65320 = lerpResult953_g65320;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g65320 = temp_cast_1;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g65320 = Lightmap_0925_g65320;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g65320 = Lightmap_Lerp932_g65320;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g65320 = RNM_0926_g65320;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g65320 = RNM_Lerp950_g65320;
					#else
					float4 staticSwitch1014_g65320 = temp_cast_1;
					#endif
					float3 Lightmap46_g65320 = (staticSwitch1014_g65320).rgb;
					float2 temp_output_5_0_g65356 = UV0A2420_g65320;
					float2 UV633_g65356 = temp_output_5_0_g65356;
					float2 UV100_g65357 = UV633_g65356;
					float2 temp_output_51_0_g65357 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g65357 * float2( 3.464,3.464 ) ) );
					float2 break55_g65357 = frac( temp_output_51_0_g65357 );
					float temp_output_56_0_g65357 = ( ( 1.0 - break55_g65357.x ) - break55_g65357.y );
					float2 temp_output_52_0_g65357 = floor( temp_output_51_0_g65357 );
					float2 temp_output_125_0_g65357 = ( temp_output_52_0_g65357 + float2( 1,1 ) );
					float2 ifLocalVar87_g65357 = 0;
					if( temp_output_56_0_g65357 > 0.0 )
					ifLocalVar87_g65357 = temp_output_52_0_g65357;
					else if( temp_output_56_0_g65357 == 0.0 )
					ifLocalVar87_g65357 = temp_output_125_0_g65357;
					else if( temp_output_56_0_g65357 < 0.0 )
					ifLocalVar87_g65357 = temp_output_125_0_g65357;
					float3 temp_output_7_0_g65358 = frac( ( (ifLocalVar87_g65357).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g65358 = dot( temp_output_7_0_g65358 , ( (temp_output_7_0_g65358).yzx + 33.33 ) );
					float3 temp_output_12_0_g65358 = ( temp_output_7_0_g65358 + dotResult8_g65358 );
					float2 temp_output_597_0_g65356 = ( UV100_g65357 + frac( ( ( (temp_output_12_0_g65358).xx + (temp_output_12_0_g65358).yz ) * (temp_output_12_0_g65358).zy ) ) );
					float2 DDX631_g65356 = ddx( temp_output_5_0_g65356 );
					float2 DDY632_g65356 = ddy( temp_output_5_0_g65356 );
					float temp_output_65_0_g65357 = ( 0.0 - temp_output_56_0_g65357 );
					float ifLocalVar59_g65357 = 0;
					if( temp_output_56_0_g65357 <= 0.0 )
					ifLocalVar59_g65357 = temp_output_65_0_g65357;
					else
					ifLocalVar59_g65357 = temp_output_56_0_g65357;
					float temp_output_597_30_g65356 = ifLocalVar59_g65357;
					float2 temp_output_90_0_g65357 = ( temp_output_52_0_g65357 + float2( 0,1 ) );
					float2 temp_output_123_0_g65357 = ( temp_output_52_0_g65357 + float2( 1,0 ) );
					float2 ifLocalVar88_g65357 = 0;
					if( temp_output_56_0_g65357 > 0.0 )
					ifLocalVar88_g65357 = temp_output_90_0_g65357;
					else if( temp_output_56_0_g65357 == 0.0 )
					ifLocalVar88_g65357 = temp_output_123_0_g65357;
					else if( temp_output_56_0_g65357 < 0.0 )
					ifLocalVar88_g65357 = temp_output_123_0_g65357;
					float3 temp_output_7_0_g65359 = frac( ( (ifLocalVar88_g65357).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g65359 = dot( temp_output_7_0_g65359 , ( (temp_output_7_0_g65359).yzx + 33.33 ) );
					float3 temp_output_12_0_g65359 = ( temp_output_7_0_g65359 + dotResult8_g65359 );
					float2 temp_output_597_26_g65356 = ( UV100_g65357 + frac( ( ( (temp_output_12_0_g65359).xx + (temp_output_12_0_g65359).yz ) * (temp_output_12_0_g65359).zy ) ) );
					float temp_output_66_0_g65357 = ( 1.0 - break55_g65357.y );
					float ifLocalVar60_g65357 = 0;
					if( temp_output_56_0_g65357 <= 0.0 )
					ifLocalVar60_g65357 = temp_output_66_0_g65357;
					else
					ifLocalVar60_g65357 = break55_g65357.y;
					float temp_output_597_28_g65356 = ifLocalVar60_g65357;
					float2 ifLocalVar89_g65357 = 0;
					if( temp_output_56_0_g65357 > 0.0 )
					ifLocalVar89_g65357 = temp_output_123_0_g65357;
					else if( temp_output_56_0_g65357 == 0.0 )
					ifLocalVar89_g65357 = temp_output_90_0_g65357;
					else if( temp_output_56_0_g65357 < 0.0 )
					ifLocalVar89_g65357 = temp_output_90_0_g65357;
					float3 temp_output_7_0_g65360 = frac( ( (ifLocalVar89_g65357).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g65360 = dot( temp_output_7_0_g65360 , ( (temp_output_7_0_g65360).yzx + 33.33 ) );
					float3 temp_output_12_0_g65360 = ( temp_output_7_0_g65360 + dotResult8_g65360 );
					float2 temp_output_597_27_g65356 = ( UV100_g65357 + frac( ( ( (temp_output_12_0_g65360).xx + (temp_output_12_0_g65360).yz ) * (temp_output_12_0_g65360).zy ) ) );
					float temp_output_67_0_g65357 = ( 1.0 - break55_g65357.x );
					float ifLocalVar61_g65357 = 0;
					if( temp_output_56_0_g65357 <= 0.0 )
					ifLocalVar61_g65357 = temp_output_67_0_g65357;
					else
					ifLocalVar61_g65357 = break55_g65357.x;
					float temp_output_597_29_g65356 = ifLocalVar61_g65357;
					float4 Output_2D293_g65356 = ( ( tex2D( _Sampler82968_g65320, temp_output_597_0_g65356, DDX631_g65356, DDY632_g65356 ) * temp_output_597_30_g65356 ) + ( tex2D( _Sampler82968_g65320, temp_output_597_26_g65356, DDX631_g65356, DDY632_g65356 ) * temp_output_597_28_g65356 ) + ( tex2D( _Sampler82968_g65320, temp_output_597_27_g65356, DDX631_g65356, DDY632_g65356 ) * temp_output_597_29_g65356 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g65320 = Output_2D293_g65356;
					#else
					float4 staticSwitch1006_g65320 = tex2D( _EmissionMap, UV0A2420_g65320 );
					#endif
					float3 temp_output_2531_0_g65320 = (( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g65320 * _EmissionIntensity )).rgb;
					float3 Emission86_g65320 = temp_output_2531_0_g65320;
					float Color1_g65372 = oAlbedo6_g65320.x;
					float Metallic1_g65372 = Metallic1239_g65320;
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g65320 = tex2D( _GlossinessMap, UV0A2420_g65320 ).r;
					#else
					float staticSwitch845_g65320 = _Glossiness;
					#endif
					float2 temp_output_5_0_g65351 = UV0A2420_g65320;
					float2 UV633_g65351 = temp_output_5_0_g65351;
					float2 UV100_g65352 = UV633_g65351;
					float2 temp_output_51_0_g65352 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g65352 * float2( 3.464,3.464 ) ) );
					float2 break55_g65352 = frac( temp_output_51_0_g65352 );
					float temp_output_56_0_g65352 = ( ( 1.0 - break55_g65352.x ) - break55_g65352.y );
					float2 temp_output_52_0_g65352 = floor( temp_output_51_0_g65352 );
					float2 temp_output_125_0_g65352 = ( temp_output_52_0_g65352 + float2( 1,1 ) );
					float2 ifLocalVar87_g65352 = 0;
					if( temp_output_56_0_g65352 > 0.0 )
					ifLocalVar87_g65352 = temp_output_52_0_g65352;
					else if( temp_output_56_0_g65352 == 0.0 )
					ifLocalVar87_g65352 = temp_output_125_0_g65352;
					else if( temp_output_56_0_g65352 < 0.0 )
					ifLocalVar87_g65352 = temp_output_125_0_g65352;
					float3 temp_output_7_0_g65353 = frac( ( (ifLocalVar87_g65352).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g65353 = dot( temp_output_7_0_g65353 , ( (temp_output_7_0_g65353).yzx + 33.33 ) );
					float3 temp_output_12_0_g65353 = ( temp_output_7_0_g65353 + dotResult8_g65353 );
					float2 temp_output_597_0_g65351 = ( UV100_g65352 + frac( ( ( (temp_output_12_0_g65353).xx + (temp_output_12_0_g65353).yz ) * (temp_output_12_0_g65353).zy ) ) );
					float2 DDX631_g65351 = ddx( temp_output_5_0_g65351 );
					float2 DDY632_g65351 = ddy( temp_output_5_0_g65351 );
					float temp_output_65_0_g65352 = ( 0.0 - temp_output_56_0_g65352 );
					float ifLocalVar59_g65352 = 0;
					if( temp_output_56_0_g65352 <= 0.0 )
					ifLocalVar59_g65352 = temp_output_65_0_g65352;
					else
					ifLocalVar59_g65352 = temp_output_56_0_g65352;
					float temp_output_597_30_g65351 = ifLocalVar59_g65352;
					float2 temp_output_90_0_g65352 = ( temp_output_52_0_g65352 + float2( 0,1 ) );
					float2 temp_output_123_0_g65352 = ( temp_output_52_0_g65352 + float2( 1,0 ) );
					float2 ifLocalVar88_g65352 = 0;
					if( temp_output_56_0_g65352 > 0.0 )
					ifLocalVar88_g65352 = temp_output_90_0_g65352;
					else if( temp_output_56_0_g65352 == 0.0 )
					ifLocalVar88_g65352 = temp_output_123_0_g65352;
					else if( temp_output_56_0_g65352 < 0.0 )
					ifLocalVar88_g65352 = temp_output_123_0_g65352;
					float3 temp_output_7_0_g65354 = frac( ( (ifLocalVar88_g65352).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g65354 = dot( temp_output_7_0_g65354 , ( (temp_output_7_0_g65354).yzx + 33.33 ) );
					float3 temp_output_12_0_g65354 = ( temp_output_7_0_g65354 + dotResult8_g65354 );
					float2 temp_output_597_26_g65351 = ( UV100_g65352 + frac( ( ( (temp_output_12_0_g65354).xx + (temp_output_12_0_g65354).yz ) * (temp_output_12_0_g65354).zy ) ) );
					float temp_output_66_0_g65352 = ( 1.0 - break55_g65352.y );
					float ifLocalVar60_g65352 = 0;
					if( temp_output_56_0_g65352 <= 0.0 )
					ifLocalVar60_g65352 = temp_output_66_0_g65352;
					else
					ifLocalVar60_g65352 = break55_g65352.y;
					float temp_output_597_28_g65351 = ifLocalVar60_g65352;
					float2 ifLocalVar89_g65352 = 0;
					if( temp_output_56_0_g65352 > 0.0 )
					ifLocalVar89_g65352 = temp_output_123_0_g65352;
					else if( temp_output_56_0_g65352 == 0.0 )
					ifLocalVar89_g65352 = temp_output_90_0_g65352;
					else if( temp_output_56_0_g65352 < 0.0 )
					ifLocalVar89_g65352 = temp_output_90_0_g65352;
					float3 temp_output_7_0_g65355 = frac( ( (ifLocalVar89_g65352).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g65355 = dot( temp_output_7_0_g65355 , ( (temp_output_7_0_g65355).yzx + 33.33 ) );
					float3 temp_output_12_0_g65355 = ( temp_output_7_0_g65355 + dotResult8_g65355 );
					float2 temp_output_597_27_g65351 = ( UV100_g65352 + frac( ( ( (temp_output_12_0_g65355).xx + (temp_output_12_0_g65355).yz ) * (temp_output_12_0_g65355).zy ) ) );
					float temp_output_67_0_g65352 = ( 1.0 - break55_g65352.x );
					float ifLocalVar61_g65352 = 0;
					if( temp_output_56_0_g65352 <= 0.0 )
					ifLocalVar61_g65352 = temp_output_67_0_g65352;
					else
					ifLocalVar61_g65352 = break55_g65352.x;
					float temp_output_597_29_g65351 = ifLocalVar61_g65352;
					float4 Output_2D293_g65351 = ( ( tex2D( _Sampler82964_g65320, temp_output_597_0_g65351, DDX631_g65351, DDY632_g65351 ) * temp_output_597_30_g65351 ) + ( tex2D( _Sampler82964_g65320, temp_output_597_26_g65351, DDX631_g65351, DDY632_g65351 ) * temp_output_597_28_g65351 ) + ( tex2D( _Sampler82964_g65320, temp_output_597_27_g65351, DDX631_g65351, DDY632_g65351 ) * temp_output_597_29_g65351 ) );
					float4 break31_g65351 = Output_2D293_g65351;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g65320 = ( 1.0 - break31_g65351.r );
					#else
					float staticSwitch1004_g65320 = ( 1.0 - staticSwitch845_g65320 );
					#endif
					float temp_output_19_0_g65370 = staticSwitch1004_g65320;
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal2504_g65320 = Normal_Map700_g65320;
					float3 worldNormal2504_g65320 = normalize( float3( dot( tanToWorld0, tanNormal2504_g65320 ), dot( tanToWorld1, tanNormal2504_g65320 ), dot( tanToWorld2, tanNormal2504_g65320 ) ) );
					float3 World_Normal2508_g65320 = worldNormal2504_g65320;
					float3 tanNormal2_g65370 = World_Normal2508_g65320;
					float3 worldNormal2_g65370 = float3( dot( tanToWorld0, tanNormal2_g65370 ), dot( tanToWorld1, tanNormal2_g65370 ), dot( tanToWorld2, tanNormal2_g65370 ) );
					float3 temp_output_3_0_g65370 = ddx( worldNormal2_g65370 );
					float dotResult5_g65370 = dot( temp_output_3_0_g65370 , temp_output_3_0_g65370 );
					float3 temp_output_4_0_g65370 = ddy( worldNormal2_g65370 );
					float dotResult6_g65370 = dot( temp_output_4_0_g65370 , temp_output_4_0_g65370 );
					#ifdef _USEGEOMETRICAA_ON
					float staticSwitch15_g65370 = min( temp_output_19_0_g65370, ( 1.0 - pow( saturate( max( dotResult5_g65370, dotResult6_g65370 ) ) , 0.25 ) ) );
					#else
					float staticSwitch15_g65370 = temp_output_19_0_g65370;
					#endif
					float Smoothness1399_g65320 = staticSwitch15_g65370;
					float Smoothness1_g65372 = Smoothness1399_g65320;
					float IOR2700_g65320 = _IOR;
					float IOR1_g65372 = IOR2700_g65320;
					float3 temp_cast_5 = (0.04).xxx;
					float3 lerpResult1473_g65320 = lerp( temp_cast_5 , oAlbedo6_g65320 , Metallic1239_g65320);
					float3 switchResult1501_g65320 = (((ase_vface>0)?(World_Normal2508_g65320):(-World_Normal2508_g65320)));
					float3 View_Direction2511_g65320 = ViewDirWS;
					float dotResult1476_g65320 = dot( switchResult1501_g65320 , View_Direction2511_g65320 );
					float3 lerpResult1480_g65320 = lerp( lerpResult1473_g65320 , float3( 1,1,1 ) , pow( ( 1.0 - saturate( dotResult1476_g65320 ) ) , 5.0 ));
					float3 Fresnel1560_g65320 = lerpResult1480_g65320;
					float3 Fresnel1_g65372 = Fresnel1560_g65320;
					float3 World_Position2505_g65320 = PositionWS;
					float3 WorldPos1_g65372 = World_Position2505_g65320;
					float3 WorldNormal1_g65372 = World_Normal2508_g65320;
					float3 ViewDir1_g65372 = View_Direction2511_g65320;
					float3 localIndirectSpecularWithBoxProjection1_g65372 = IndirectSpecularWithBoxProjection1_g65372( Color1_g65372 , Metallic1_g65372 , Smoothness1_g65372 , IOR1_g65372 , Fresnel1_g65372 , WorldPos1_g65372 , WorldNormal1_g65372 , ViewDir1_g65372 );
					float3 temp_output_2745_0_g65320 = localIndirectSpecularWithBoxProjection1_g65372;
					float grayscale2713_g65320 = Luminance( Lightmap46_g65320 );
					float smoothstepResult2430_g65320 = smoothstep( 0.0 , 0.075 , grayscale2713_g65320);
					#ifdef _USELIGHTMAPPEDREFLECTIONS_ON
					float3 staticSwitch1469_g65320 = ( temp_output_2745_0_g65320 * smoothstepResult2430_g65320 );
					#else
					float3 staticSwitch1469_g65320 = temp_output_2745_0_g65320;
					#endif
					float3 Reflections1419_g65320 = staticSwitch1469_g65320;
					float3 AlbedoColor97_g65371 = oAlbedo6_g65320;
					float3 LightmapColor97_g65371 = Lightmap46_g65320;
					float Metallic97_g65371 = Metallic1239_g65320;
					float Smoothness97_g65371 = Smoothness1399_g65320;
					float IOR97_g65371 = IOR2700_g65320;
					float3 Fresnel97_g65371 = Fresnel1560_g65320;
					float3 WorldPos97_g65371 = World_Position2505_g65320;
					float3 WorldNormal97_g65371 = World_Normal2508_g65320;
					float3 ViewDir97_g65371 = View_Direction2511_g65320;
					float3 localSpecular97_g65371 = Specular( AlbedoColor97_g65371 , LightmapColor97_g65371 , Metallic97_g65371 , Smoothness97_g65371 , IOR97_g65371 , Fresnel97_g65371 , WorldPos97_g65371 , WorldNormal97_g65371 , ViewDir97_g65371 );
					float3 Speculars2560_g65320 = localSpecular97_g65371;
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch1181_g65320 = Lightmap46_g65320;
					#else
					float3 staticSwitch1181_g65320 = ( ( aAlbedo1466_g65320 * Lightmap46_g65320 ) + Emission86_g65320 + Reflections1419_g65320 + Speculars2560_g65320 );
					#endif
					float3 temp_output_35_0_g65330 = staticSwitch1181_g65320;
					float3 Color353_g65330 = temp_output_35_0_g65330;
					#if defined( _LUTMODE_2D )
					float3 staticSwitch273_g65330 = saturate( temp_output_35_0_g65330 );
					#elif defined( _LUTMODE_3D )
					float3 staticSwitch273_g65330 = temp_output_35_0_g65330;
					#else
					float3 staticSwitch273_g65330 = temp_output_35_0_g65330;
					#endif
					float3 Color_Saturate49_g65330 = staticSwitch273_g65330;
					float Lut_Height213_g65330 = _LUTSize;
					float Lut_Width216_g65330 = ( _LUTSize * Lut_Height213_g65330 );
					float3 appendResult214_g65330 = (float3(( 1.0 / Lut_Width216_g65330 ) , ( 1.0 / Lut_Height213_g65330 ) , ( Lut_Height213_g65330 - 1.0 )));
					float3 Scale_Offset208_g65330 = appendResult214_g65330;
					float2 Scale_Factor292_g65330 = ( (Scale_Offset208_g65330).xy * (Scale_Offset208_g65330).z );
					float2 Offset299_g65330 = ( (Scale_Offset208_g65330).xy * 0.5 );
					float2 Adjusted_UV305_g65330 = ( ( (Color_Saturate49_g65330).xy * Scale_Factor292_g65330 ) + Offset299_g65330 );
					float Scaled_Blue280_g65330 = ( (Color_Saturate49_g65330).z * (Scale_Offset208_g65330).z );
					float Shift288_g65330 = floor( Scaled_Blue280_g65330 );
					float Final_X313_g65330 = ( (Adjusted_UV305_g65330).x + ( Shift288_g65330 * (Scale_Offset208_g65330).y ) );
					float2 appendResult326_g65330 = (float2(Final_X313_g65330 , (Adjusted_UV305_g65330).y));
					float2 Final_UV325_g65330 = appendResult326_g65330;
					float2 appendResult338_g65330 = (float2((Scale_Offset208_g65330).y , 0.0));
					float2 Offset_UV336_g65330 = ( Final_UV325_g65330 + appendResult338_g65330 );
					float3 lerpResult333_g65330 = lerp( tex2D( _2DLut, Final_UV325_g65330 ).rgb , tex2D( _2DLut, Offset_UV336_g65330 ).rgb , ( Scaled_Blue280_g65330 - Shift288_g65330 ));
					#ifdef _2DLUT
					float3 staticSwitch347_g65330 = lerpResult333_g65330;
					#else
					float3 staticSwitch347_g65330 = Color_Saturate49_g65330;
					#endif
					float3 TwoD_LUT346_g65330 = staticSwitch347_g65330;
					float3 RGB16_g65331 = ( ( log10( ( ( Color_Saturate49_g65330 * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 );
					#ifdef _3DLUT
					float3 staticSwitch194_g65330 = tex3D( _3DLut, RGB16_g65331 ).rgb;
					#else
					float3 staticSwitch194_g65330 = Color_Saturate49_g65330;
					#endif
					float3 ThreeD_LUT51_g65330 = staticSwitch194_g65330;
					#if defined( _LUTMODE_2D )
					float3 staticSwitch42_g65330 = TwoD_LUT346_g65330;
					#elif defined( _LUTMODE_3D )
					float3 staticSwitch42_g65330 = ThreeD_LUT51_g65330;
					#else
					float3 staticSwitch42_g65330 = ThreeD_LUT51_g65330;
					#endif
					#ifdef SHADER_API_MOBILE
					float3 staticSwitch41_g65330 = staticSwitch42_g65330;
					#else
					float3 staticSwitch41_g65330 = Color353_g65330;
					#endif
					

					o.Albedo = staticSwitch1180_g65320;
					o.Normal = half3( 0, 0, 1 );

					half3 Specular = half3( 0, 0, 0 );
					half Metallic = 0;
					half Smoothness = 0;
					half Occlusion = 1;

					#if defined(ASE_LIGHTING_SIMPLE)
						o.Specular = Specular.x;
						o.Gloss = Smoothness;
					#else
						#if defined(_SPECULAR_SETUP)
							o.Specular = Specular;
						#else
							o.Metallic = Metallic;
						#endif
						o.Occlusion = Occlusion;
						o.Smoothness = Smoothness;
					#endif

					o.Emission = staticSwitch41_g65330;
					o.Alpha = 1;
					half AlphaClipThreshold = 0.5;
					half AlphaClipThresholdShadow = 0.5;
					half3 BakedGI = 0;
					half3 Transmission = 1;
					half3 Translucency = 1;

					#if defined( ASE_DEPTH_WRITE_ON )
						float DeviceDepth = IN.pos.z;
					#endif

					#ifdef _ALPHATEST_ON
						clip( o.Alpha - AlphaClipThreshold );
					#endif

					#if defined( ASE_CHANGES_WORLD_POS )
					{
						#if defined( ASE_RECEIVE_SHADOWS )
							UNITY_LIGHT_ATTENUATION( temp, IN, PositionWS )
							LightAtten = temp;
						#else
							LightAtten = 1;
						#endif
					}
					#endif

					#if ( ASE_FRAGMENT_NORMAL == 0 )
						o.Normal = normalize( o.Normal.x * TangentWS + o.Normal.y * BitangentWS + o.Normal.z * NormalWS );
					#elif ( ASE_FRAGMENT_NORMAL == 1 )
						o.Normal = UnityObjectToWorldNormal( o.Normal );
					#elif ( ASE_FRAGMENT_NORMAL == 2 )
						// @diogo: already in world-space; do nothing
					#endif

					#if defined( ASE_DEPTH_WRITE_ON )
						outputDepth = DeviceDepth;
					#endif

					#ifndef USING_DIRECTIONAL_LIGHT
						half3 lightDir = normalize( UnityWorldSpaceLightDir( PositionWS ) );
					#else
						half3 lightDir = _WorldSpaceLightPos0.xyz;
					#endif

					UnityGI gi;
					UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
					gi.indirect.diffuse = 0;
					gi.indirect.specular = 0;
					gi.light.color = _LightColor0.rgb;
					gi.light.dir = lightDir;

					UnityGIInput giInput;
					UNITY_INITIALIZE_OUTPUT(UnityGIInput, giInput);
					giInput.light = gi.light;
					giInput.worldPos = PositionWS;
					giInput.worldViewDir = ViewDirWS;
					giInput.atten = atten;
					#if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
						giInput.lightmapUV = IN.ambientOrLightmapUV;
					#else
						giInput.lightmapUV = 0.0;
					#endif
					#if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
						giInput.ambient = IN.ambientOrLightmapUV.rgb;
					#else
						giInput.ambient.rgb = 0.0;
					#endif
					giInput.probeHDR[0] = unity_SpecCube0_HDR;
					giInput.probeHDR[1] = unity_SpecCube1_HDR;
					#if defined(UNITY_SPECCUBE_BLENDING) || defined(UNITY_SPECCUBE_BOX_PROJECTION)
						giInput.boxMin[0] = unity_SpecCube0_BoxMin;
					#endif
					#ifdef UNITY_SPECCUBE_BOX_PROJECTION
						giInput.boxMax[0] = unity_SpecCube0_BoxMax;
						giInput.probePosition[0] = unity_SpecCube0_ProbePosition;
						giInput.boxMax[1] = unity_SpecCube1_BoxMax;
						giInput.boxMin[1] = unity_SpecCube1_BoxMin;
						giInput.probePosition[1] = unity_SpecCube1_ProbePosition;
					#endif

					#if defined(ASE_LIGHTING_SIMPLE)
						#if defined(_SPECULAR_SETUP)
							LightingBlinnPhong_GI(o, giInput, gi);
						#else
							LightingLambert_GI(o, giInput, gi);
						#endif
					#else
						#if defined(_SPECULAR_SETUP)
							LightingStandardSpecular_GI(o, giInput, gi);
						#else
							LightingStandard_GI(o, giInput, gi);
						#endif
					#endif

					#ifdef ASE_BAKEDGI
						gi.indirect.diffuse = BakedGI;
					#endif

					#if UNITY_SHOULD_SAMPLE_SH && !defined(LIGHTMAP_ON) && defined(ASE_NO_AMBIENT)
						gi.indirect.diffuse = 0;
					#endif

					half4 c = 0;
					#if defined(ASE_LIGHTING_SIMPLE)
						#if defined(_SPECULAR_SETUP)
							c += LightingBlinnPhong (o, ViewDirWS, gi);
						#else
							c += LightingLambert( o, gi );
						#endif
					#else
						#if defined(_SPECULAR_SETUP)
							c += LightingStandardSpecular (o, ViewDirWS, gi);
						#else
							c += LightingStandard(o, ViewDirWS, gi);
						#endif
					#endif

					#ifdef ASE_TRANSMISSION
					{
						half shadow = _TransmissionShadow;
						#ifdef DIRECTIONAL
							half3 lightAtten = lerp( _LightColor0.rgb, gi.light.color, shadow );
						#else
							half3 lightAtten = gi.light.color;
						#endif
						half3 transmission = max(0 , -dot(o.Normal, gi.light.dir)) * lightAtten * Transmission;
						c.rgb += o.Albedo * transmission;
					}
					#endif

					#ifdef ASE_TRANSLUCENCY
					{
						half shadow = _TransShadow;
						half normal = _TransNormal;
						half scattering = _TransScattering;
						half direct = _TransDirect;
						half ambient = _TransAmbient;
						half strength = _TransStrength;

						#ifdef DIRECTIONAL
							half3 lightAtten = lerp( _LightColor0.rgb, gi.light.color, shadow );
						#else
							half3 lightAtten = gi.light.color;
						#endif
						half3 lightDir = gi.light.dir + o.Normal * normal;
						half transVdotL = pow( saturate( dot( ViewDirWS, -lightDir ) ), scattering );
						half3 translucency = lightAtten * (transVdotL * direct + gi.indirect.diffuse * ambient) * Translucency;
						c.rgb += o.Albedo * translucency * strength;
					}
					#endif

					c.rgb += o.Emission;

					#if defined( ASE_FOG )
						UNITY_EXTRACT_FOG_FROM_WORLD_POS( IN );
						UNITY_APPLY_FOG(_unity_fogCoord, c.rgb);
					#endif
					return c;
				}
			ENDCG
		}

		
		Pass
		{
			
			Name "SceneSelectionPass"
			Tags { "LightMode"="SceneSelectionPass" }

			ZWrite On

			CGPROGRAM
				#define ASE_GEOMETRY
				#define ASE_FRAGMENT_NORMAL 0
				#define ASE_RECEIVE_SHADOWS
				#pragma multi_compile_instancing
				#pragma multi_compile _ LOD_FADE_CROSSFADE
				#define ASE_LIGHTING_SIMPLE 1
				#define ASE_FOG
				#define _SPECULARHIGHLIGHTS_OFF
				#define _GLOSSYREFLECTIONS_OFF
				#define ASE_VERSION 19907

				#pragma vertex vert
				#pragma fragment frag
				#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2

				#pragma multi_compile_fwdbase
				#ifndef UNITY_PASS_FORWARDBASE
					#define UNITY_PASS_FORWARDBASE
				#endif
				#include "HLSLSupport.cginc"
				#if defined( ASE_GEOMETRY ) || defined( ASE_IMPOSTOR )
					#ifndef UNITY_INSTANCED_LOD_FADE
						#define UNITY_INSTANCED_LOD_FADE
					#endif
					#ifndef UNITY_INSTANCED_SH
						#define UNITY_INSTANCED_SH
					#endif
					#ifndef UNITY_INSTANCED_LIGHTMAPSTS
						#define UNITY_INSTANCED_LIGHTMAPSTS
					#endif
				#endif
				#include "UnityShaderVariables.cginc"
				#include "UnityCG.cginc"
				#include "Lighting.cginc"
				#include "UnityPBSLighting.cginc"
				#include "AutoLight.cginc"

				

				int _ObjectId;
				int _PassValue;

				struct appdata
				{
					float4 vertex : POSITION;
					half3 normal : NORMAL;
					half4 tangent : TANGENT;
					
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct v2f
				{
					float4 pos : SV_POSITION;
					float4 worldPos : TEXCOORD0; // xyz = positionWS
					half3 normalWS : TEXCOORD1;
					
					UNITY_VERTEX_INPUT_INSTANCE_ID
					UNITY_VERTEX_OUTPUT_STEREO
				};

				#ifdef ASE_TESSELLATION
					float _TessPhongStrength;
					float _TessValue;
					float _TessMin;
					float _TessMax;
					float _TessEdgeLength;
					float _TessMaxDisp;
				#endif

				uniform float _CATEGORY_SURFACEOPTIONS;
				uniform float _EmissionFlags;
				uniform float _CATEGORYEMISSION;
				uniform float _CATEGORYSPACEEMISSION;
				uniform float _CATEGORYLIGHTMAPPING;
				uniform float _CATEGORYSPACELIGHTMAPPING;
				uniform float _CATEGORYSTOCHASTIC;
				uniform float _CATEGORYSPACESTOCHASTIC;
				uniform float _CATEGORYSPACECOLORGRADING;
				uniform float _CATEGORYCOLORGRADING;
				uniform float _CATEGORYSPACESPECIALEFFECTS;
				uniform float _CATEGORYSPECIALEFFECTS;
				uniform sampler2D _2DLut;
				uniform float _LUTSize;
				uniform sampler3D _3DLut;
				uniform float _CATEGORYSPACESURFACEOPTIONS;
				uniform float _UdonSpecularLightCount;
				uniform float4 _UdonSpecularLightUp[32];
				uniform float4 _UdonSpecularLightDir[32];
				uniform float4 _UdonSpecularLightCol[32];
				uniform float4 _UdonSpecularLightPos[32];
				uniform float4 _UdonSpecularLightRight[32];


				
				v2f VertexFunction( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					

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

					float3 positionWS = mul( unity_ObjectToWorld, v.vertex ).xyz;
					half3 normalWS = UnityObjectToWorldNormal( v.normal );

					o.pos = UnityObjectToClipPos( v.vertex );
					o.worldPos.xyz = positionWS;
					o.normalWS = normalWS;
					return o;
				}

				#if defined(ASE_TESSELLATION)
				struct VertexControl
				{
					float4 vertex : INTERNALTESSPOS;
					half3 normal : NORMAL;
					
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct TessellationFactors
				{
					float edge[3] : SV_TessFactor;
					float inside : SV_InsideTessFactor;
				};

				VertexControl vert ( appdata v )
				{
					VertexControl o;
					UNITY_SETUP_INSTANCE_ID(v);
					UNITY_TRANSFER_INSTANCE_ID(v, o);
					o.vertex = v.vertex;
					o.normal = v.normal;
					
					return o;
				}

				TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
				{
					TessellationFactors o;
					float4 tf = 1;
					float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
					float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
					#if defined(ASE_FIXED_TESSELLATION)
					tf = FixedTess( tessValue );
					#elif defined(ASE_DISTANCE_TESSELLATION)
					tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, UNITY_MATRIX_M, _WorldSpaceCameraPos );
					#elif defined(ASE_LENGTH_TESSELLATION)
					tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams );
					#elif defined(ASE_LENGTH_CULL_TESSELLATION)
					tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
					#endif
					o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
					return o;
				}

				[domain("tri")]
				[partitioning("fractional_odd")]
				[outputtopology("triangle_cw")]
				[patchconstantfunc("TessellationFunction")]
				[outputcontrolpoints(3)]
				VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
				{
				   return patch[id];
				}

				[domain("tri")]
				v2f DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
				{
					appdata o = (appdata) 0;
					o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
					o.normal = patch[0].normal * bary.x + patch[1].normal * bary.y + patch[2].normal * bary.z;
					
					#if defined(ASE_PHONG_TESSELLATION)
					float3 pp[3];
					for (int i = 0; i < 3; ++i)
						pp[i] = o.vertex.xyz - patch[i].normal * (dot(o.vertex.xyz, patch[i].normal) - dot(patch[i].vertex.xyz, patch[i].normal));
					float phongStrength = _TessPhongStrength;
					o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
					#endif
					UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
					return VertexFunction(o);
				}
				#else
				v2f vert ( appdata v )
				{
					return VertexFunction( v );
				}
				#endif

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

					

					half Alpha = 1;
					half AlphaClipThreshold = 0.5;

					#if defined( ASE_DEPTH_WRITE_ON )
						float DeviceDepth = IN.pos.z;
					#endif

					#ifdef _ALPHATEST_ON
						clip( Alpha - AlphaClipThreshold );
					#endif

					#if defined( ASE_DEPTH_WRITE_ON )
						outputDepth = DeviceDepth;
					#endif

					return float4( _ObjectId, _PassValue, 1.0, 1.0 );
				}
			ENDCG
		}

		
		Pass
		{
			
			Name "ScenePickingPass"
			Tags { "LightMode"="Picking" }

			ZWrite On

			CGPROGRAM
				#define ASE_GEOMETRY
				#define ASE_FRAGMENT_NORMAL 0
				#define ASE_RECEIVE_SHADOWS
				#pragma multi_compile_instancing
				#pragma multi_compile _ LOD_FADE_CROSSFADE
				#define ASE_LIGHTING_SIMPLE 1
				#define ASE_FOG
				#define _SPECULARHIGHLIGHTS_OFF
				#define _GLOSSYREFLECTIONS_OFF
				#define ASE_VERSION 19907

				#pragma vertex vert
				#pragma fragment frag
				#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2

				#pragma multi_compile_fwdbase
				#ifndef UNITY_PASS_FORWARDBASE
					#define UNITY_PASS_FORWARDBASE
				#endif
				#include "HLSLSupport.cginc"
				#if defined( ASE_GEOMETRY ) || defined( ASE_IMPOSTOR )
					#ifndef UNITY_INSTANCED_LOD_FADE
						#define UNITY_INSTANCED_LOD_FADE
					#endif
					#ifndef UNITY_INSTANCED_SH
						#define UNITY_INSTANCED_SH
					#endif
					#ifndef UNITY_INSTANCED_LIGHTMAPSTS
						#define UNITY_INSTANCED_LIGHTMAPSTS
					#endif
				#endif
				#include "UnityShaderVariables.cginc"
				#include "UnityCG.cginc"
				#include "Lighting.cginc"
				#include "UnityPBSLighting.cginc"
				#include "AutoLight.cginc"

				

				float4 _SelectionID;

				struct appdata
				{
					float4 vertex : POSITION;
					half3 normal : NORMAL;
					half4 tangent : TANGENT;
					
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct v2f
				{
					float4 pos : SV_POSITION;
					float4 worldPos : TEXCOORD0; // xyz = positionWS
					half3 normalWS : TEXCOORD1;
					
					UNITY_VERTEX_INPUT_INSTANCE_ID
					UNITY_VERTEX_OUTPUT_STEREO
				};

				#ifdef ASE_TESSELLATION
					float _TessPhongStrength;
					float _TessValue;
					float _TessMin;
					float _TessMax;
					float _TessEdgeLength;
					float _TessMaxDisp;
				#endif

				uniform float _CATEGORY_SURFACEOPTIONS;
				uniform float _EmissionFlags;
				uniform float _CATEGORYEMISSION;
				uniform float _CATEGORYSPACEEMISSION;
				uniform float _CATEGORYLIGHTMAPPING;
				uniform float _CATEGORYSPACELIGHTMAPPING;
				uniform float _CATEGORYSTOCHASTIC;
				uniform float _CATEGORYSPACESTOCHASTIC;
				uniform float _CATEGORYSPACECOLORGRADING;
				uniform float _CATEGORYCOLORGRADING;
				uniform float _CATEGORYSPACESPECIALEFFECTS;
				uniform float _CATEGORYSPECIALEFFECTS;
				uniform sampler2D _2DLut;
				uniform float _LUTSize;
				uniform sampler3D _3DLut;
				uniform float _CATEGORYSPACESURFACEOPTIONS;
				uniform float _UdonSpecularLightCount;
				uniform float4 _UdonSpecularLightUp[32];
				uniform float4 _UdonSpecularLightDir[32];
				uniform float4 _UdonSpecularLightCol[32];
				uniform float4 _UdonSpecularLightPos[32];
				uniform float4 _UdonSpecularLightRight[32];


				
				v2f VertexFunction( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					

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

					float3 positionWS = mul( unity_ObjectToWorld, v.vertex ).xyz;
					half3 normalWS = UnityObjectToWorldNormal( v.normal );

					o.pos = UnityObjectToClipPos( v.vertex );
					o.worldPos.xyz = positionWS;
					o.normalWS = normalWS;
					return o;
				}

				#if defined(ASE_TESSELLATION)
				struct VertexControl
				{
					float4 vertex : INTERNALTESSPOS;
					half3 normal : NORMAL;
					
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct TessellationFactors
				{
					float edge[3] : SV_TessFactor;
					float inside : SV_InsideTessFactor;
				};

				VertexControl vert ( appdata v )
				{
					VertexControl o;
					UNITY_SETUP_INSTANCE_ID(v);
					UNITY_TRANSFER_INSTANCE_ID(v, o);
					o.vertex = v.vertex;
					o.normal = v.normal;
					
					return o;
				}

				TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
				{
					TessellationFactors o;
					float4 tf = 1;
					float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
					float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
					#if defined(ASE_FIXED_TESSELLATION)
					tf = FixedTess( tessValue );
					#elif defined(ASE_DISTANCE_TESSELLATION)
					tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, UNITY_MATRIX_M, _WorldSpaceCameraPos );
					#elif defined(ASE_LENGTH_TESSELLATION)
					tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams );
					#elif defined(ASE_LENGTH_CULL_TESSELLATION)
					tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
					#endif
					o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
					return o;
				}

				[domain("tri")]
				[partitioning("fractional_odd")]
				[outputtopology("triangle_cw")]
				[patchconstantfunc("TessellationFunction")]
				[outputcontrolpoints(3)]
				VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
				{
				   return patch[id];
				}

				[domain("tri")]
				v2f DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
				{
					appdata o = (appdata) 0;
					o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
					o.normal = patch[0].normal * bary.x + patch[1].normal * bary.y + patch[2].normal * bary.z;
					
					#if defined(ASE_PHONG_TESSELLATION)
					float3 pp[3];
					for (int i = 0; i < 3; ++i)
						pp[i] = o.vertex.xyz - patch[i].normal * (dot(o.vertex.xyz, patch[i].normal) - dot(patch[i].vertex.xyz, patch[i].normal));
					float phongStrength = _TessPhongStrength;
					o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
					#endif
					UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
					return VertexFunction(o);
				}
				#else
				v2f vert ( appdata v )
				{
					return VertexFunction( v );
				}
				#endif

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

					

					half Alpha = 1;
					half AlphaClipThreshold = 0.5;

					#if defined( ASE_DEPTH_WRITE_ON )
						float DeviceDepth = IN.pos.z;
					#endif

					#ifdef _ALPHATEST_ON
						clip( Alpha - AlphaClipThreshold );
					#endif

					#if defined( ASE_DEPTH_WRITE_ON )
						outputDepth = DeviceDepth;
					#endif

					return _SelectionID;
				}
			ENDCG
		}
		
	}
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
	
	Fallback Off
}
/*ASEBEGIN
Version=19907
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5694;0,-1280;Inherit;False;Meenphie;0;;65320;b3ba55a08dd6b49c7be16c6f35cf2033;6,1008,0,2632,0,2635,0,2636,0,2670,0,2619,0;0;6;FLOAT3;625;FLOAT3;624;FLOAT;156;FLOAT;427;FLOAT;1024;FLOAT;2714
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5279;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;5;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5280;256,-1280;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;6;Meenphie/Standard/Opaque;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardBase;0;1;ForwardBase;17;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;True;True;0;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;44;Category;0;0;  Instanced Terrain Normals;1;0;Workflow;3;639079749420714040;Surface;0;0;  Blend;0;0;  Dither Shadows;1;0;Two Sided;1;0;Alpha Clipping;0;0;  Use Shadow Threshold;0;0;Deferred Pass;0;639079951064078170;Normal Space;0;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;0;639108440689538340;Receive Shadows;1;0;Receive Specular;0;639108440701916390;Receive Reflections;0;639108447998214750;GPU Instancing;1;0;LOD CrossFade;1;0;Built-in Fog;1;639105044169342440;Ambient Light;1;639111933610282130;Meta Pass;0;639111933576947160;Add Pass;0;639111933580732010;Override Baked GI;0;0;Write Depth;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;0;Vertex Position;1;0;0;8;False;True;False;False;False;False;True;True;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5281;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;5;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;True;1;LightMode=ForwardAdd;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5282;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;5;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5283;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;5;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5284;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;5;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5285;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;5;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5286;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;5;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ScenePickingPass;0;7;ScenePickingPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=Picking;False;False;0;;0;0;Standard;0;False;0
WireConnection;5280;0;5694;625
WireConnection;5280;2;5694;624
ASEEND*/
//CHKSM=5E20E3DDB02BED9ED5FCE5AF95C15CCD2784E6CD