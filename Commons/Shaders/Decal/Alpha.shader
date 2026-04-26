// Made with Amplify Shader Editor v1.9.9.7
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Decal/Alpha"
{
	Properties
	{
		[Meenphie_DrawerCategory(SURFACE OPTIONS,true,0,0)] _CATEGORY_SURFACEOPTIONS( "CATEGORY_SURFACEOPTIONS", Float ) = 1
		_Color( "DIffuse Color", Color ) = ( 0.9058824, 0.9058824, 0.9058824, 1 )
		[NoScaleOffset][SingleLineTexture] _MainTex( "Base Color", 2D ) = "white" {}
		[NoScaleOffset][SingleLineTexture] _BumpMap( "Normal", 2D ) = "bump" {}
		[NoScaleOffset][SingleLineTexture] _MetallicMap( "Metallic", 2D ) = "black" {}
		[NoScaleOffset][SingleLineTexture] _GlossinessMap( "Roughness", 2D ) = "black" {}
		[KeywordEnum( UV0,UV2 )] _UV( "UV", Float ) = 1
		_Metallic( "Metallic", Range( 0, 1 ) ) = 0
		_Glossiness( "Roughness", Range( 0, 1 ) ) = 0.5
		_IOR( "IOR", Range( 1, 2.5 ) ) = 1.5
		[Toggle( _USEGEOMETRICAA_ON )] _UseGeometricAA( "Use Geometric AA", Float ) = 1
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESURFACEOPTIONS( "CATEGORY SPACE SURFACEOPTIONS", Float ) = 0
		[Meenphie_DrawerCategory(EMISSION,true,0,0)] _CATEGORYEMISSION( "CATEGORY EMISSION", Float ) = 0
		[NoScaleOffset][SingleLineTexture] _EmissionMap( "Emission", 2D ) = "white" {}
		[KeywordEnum( UV0,UV2 )] _EmissionUV( "Emission UV", Float ) = 0
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
		[HideInInspector] GenKey__MainTex( "Assign keyword _MAINTEX", Float ) = 1.0
		[HideInInspector] GenKey__2DLut( "Assign keyword _2DLUT", Float ) = 1.0
		[HideInInspector] GenKey__GlossinessMap( "Assign keyword _GLOSSINESSMAP", Float ) = 1.0
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
		

		

		Tags { "RenderType"="Transparent" "Queue"="Transparent+1" "DisableBatching"="False" }

	LOD 0

		Cull Back
		AlphaToMask Off
		ZWrite Off
		ZTest LEqual
		ColorMask RGBA

		

		Blend One One
		

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

			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
				#define ASE_GEOMETRY
				#define UNITY_STANDARD_USE_DITHER_MASK 1
				#define ASE_FRAGMENT_NORMAL 0
				#pragma multi_compile _ LOD_FADE_CROSSFADE
				#pragma multi_compile_fog
				#define ASE_FOG
				#define _SPECULARHIGHLIGHTS_OFF
				#pragma multi_compile_instancing
				#define ASE_NO_AMBIENT 1
				#define ASE_LIGHTING_SIMPLE 1
				#define _GLOSSYREFLECTIONS_OFF
				#define _ALPHABLEND_ON 1
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
				#define ASE_NEEDS_VERT_NORMAL
				#define ASE_NEEDS_TEXTURE_COORDINATES2
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
				#pragma shader_feature_local _UV_UV0 _UV_UV2
				#pragma shader_feature_local _LIGHTMAPMODE_DISABLED _LIGHTMAPMODE_SIMPLE _LIGHTMAPMODE_SIMPLELERP _LIGHTMAPMODE_RNM _LIGHTMAPMODE_RNMLERP
				#pragma shader_feature_local _USEBICUBICFILTERING_ON
				#pragma shader_feature_local _BUMPMAP
				#pragma shader_feature_local_fragment _EMISSIONUV_UV0 _EMISSIONUV_UV2
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
					float4 ase_texcoord7 : TEXCOORD7;
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
				sampler2D _Sampler82966_g59916;
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				sampler2D _Sampler82967_g59916;
				uniform sampler2D _Lightmap0;
				float4 _Lightmap0_TexelSize;
				uniform sampler2D _Lightmap1;
				float4 _Lightmap1_TexelSize;
				uniform float _UdonLightmapLerp;
				uniform sampler2D _BumpMap;
				sampler2D _Sampler82965_g59916;
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
				sampler2D _Sampler82968_g59916;
				uniform float _EmissionIntensity;
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				sampler2D _Sampler82964_g59916;
				uniform float _IOR;


				float3 IndirectSpecularWithBoxProjection1_g59968( float Color, float Metallic, float Smoothness, float IOR, float3 Fresnel, float3 WorldPos, float3 WorldNormal, float3 ViewDir )
				{
					// --- 1. VECTORS & NORMALS ---
					float3 N = normalize(WorldNormal); 
					float3 V = normalize(ViewDir);
					float3 R = reflect(-V, N);
					float nDotV = saturate(dot(N, V));
					// --- 2. REFLECTION RAY & BOX PROJECTION ---
					float3 ray = R;
					[branch]
					if (unity_SpecCube0_ProbePosition.w > 0.0) {
					    float3 boxBounds = lerp(unity_SpecCube0_BoxMin.xyz, unity_SpecCube0_BoxMax.xyz, step(0.0, ray));
					    float3 factors = (boxBounds - WorldPos) / (ray + 1e-5);
					    float scalar = min(min(factors.x, factors.y), factors.z);
					    ray = ray * scalar + (WorldPos - unity_SpecCube0_ProbePosition.xyz);
					}
					// --- 3. PBR F0 & FRESNEL (Modified Schlick) ---
					float f0_base = pow((IOR - 1.0) / (IOR + 1.0), 2.0);
					float3 F0 = lerp(float3(f0_base, f0_base, f0_base), Color, Metallic);
					// Prevents rough surfaces from "glowing" unnaturally at edges
					float3 fresnelFactor = F0 + (max(float3(Smoothness, Smoothness, Smoothness), F0) - F0) * pow(1.0 - nDotV, 5.0);
					// --- 4. SAMPLING (The "In-Between" Logic) ---
					float perceptualRoughness = 1.0 - Smoothness;
					// We use 9.0 as a safe upper bound. 
					// - If the probe is 512px, it uses all 9 mips.
					// - If the probe is 128px, the GPU hardware automatically clamps this to 6.
					float mipLevel = pow(perceptualRoughness, 1.5) * 9.0; 
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

					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 World_Position2505_g59916 = ase_positionWS;
					
					o.ase_texcoord6.xy = v.texcoord2.xyzw.xy;
					o.ase_texcoord7 = v.texcoord.xyzw;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord6.zw = 0;

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = ( v.normal * ( distance( World_Position2505_g59916 , _WorldSpaceCameraPos ) * 0.0005 ) );
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

					float2 texCoord2594_g59916 = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV22595_g59916 = texCoord2594_g59916;
					#ifdef _MAINTEX
					float4 staticSwitch1549_g59916 = tex2D( _MainTex, UV22595_g59916 );
					#else
					float4 staticSwitch1549_g59916 = _Color;
					#endif
					float2 temp_output_5_0_g59942 = UV22595_g59916;
					float2 UV633_g59942 = temp_output_5_0_g59942;
					float2 UV100_g59943 = UV633_g59942;
					float2 temp_output_51_0_g59943 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59943 * float2( 3.464,3.464 ) ) );
					float2 break55_g59943 = frac( temp_output_51_0_g59943 );
					float temp_output_56_0_g59943 = ( ( 1.0 - break55_g59943.x ) - break55_g59943.y );
					float2 temp_output_52_0_g59943 = floor( temp_output_51_0_g59943 );
					float2 temp_output_125_0_g59943 = ( temp_output_52_0_g59943 + float2( 1,1 ) );
					float2 ifLocalVar87_g59943 = 0;
					if( temp_output_56_0_g59943 > 0.0 )
					ifLocalVar87_g59943 = temp_output_52_0_g59943;
					else if( temp_output_56_0_g59943 == 0.0 )
					ifLocalVar87_g59943 = temp_output_125_0_g59943;
					else if( temp_output_56_0_g59943 < 0.0 )
					ifLocalVar87_g59943 = temp_output_125_0_g59943;
					float3 temp_output_7_0_g59944 = frac( ( (ifLocalVar87_g59943).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59944 = dot( temp_output_7_0_g59944 , ( (temp_output_7_0_g59944).yzx + 33.33 ) );
					float3 temp_output_12_0_g59944 = ( temp_output_7_0_g59944 + dotResult8_g59944 );
					float2 temp_output_597_0_g59942 = ( UV100_g59943 + frac( ( ( (temp_output_12_0_g59944).xx + (temp_output_12_0_g59944).yz ) * (temp_output_12_0_g59944).zy ) ) );
					float2 DDX631_g59942 = ddx( temp_output_5_0_g59942 );
					float2 DDY632_g59942 = ddy( temp_output_5_0_g59942 );
					float temp_output_65_0_g59943 = ( 0.0 - temp_output_56_0_g59943 );
					float ifLocalVar59_g59943 = 0;
					if( temp_output_56_0_g59943 <= 0.0 )
					ifLocalVar59_g59943 = temp_output_65_0_g59943;
					else
					ifLocalVar59_g59943 = temp_output_56_0_g59943;
					float temp_output_597_30_g59942 = ifLocalVar59_g59943;
					float2 temp_output_90_0_g59943 = ( temp_output_52_0_g59943 + float2( 0,1 ) );
					float2 temp_output_123_0_g59943 = ( temp_output_52_0_g59943 + float2( 1,0 ) );
					float2 ifLocalVar88_g59943 = 0;
					if( temp_output_56_0_g59943 > 0.0 )
					ifLocalVar88_g59943 = temp_output_90_0_g59943;
					else if( temp_output_56_0_g59943 == 0.0 )
					ifLocalVar88_g59943 = temp_output_123_0_g59943;
					else if( temp_output_56_0_g59943 < 0.0 )
					ifLocalVar88_g59943 = temp_output_123_0_g59943;
					float3 temp_output_7_0_g59945 = frac( ( (ifLocalVar88_g59943).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59945 = dot( temp_output_7_0_g59945 , ( (temp_output_7_0_g59945).yzx + 33.33 ) );
					float3 temp_output_12_0_g59945 = ( temp_output_7_0_g59945 + dotResult8_g59945 );
					float2 temp_output_597_26_g59942 = ( UV100_g59943 + frac( ( ( (temp_output_12_0_g59945).xx + (temp_output_12_0_g59945).yz ) * (temp_output_12_0_g59945).zy ) ) );
					float temp_output_66_0_g59943 = ( 1.0 - break55_g59943.y );
					float ifLocalVar60_g59943 = 0;
					if( temp_output_56_0_g59943 <= 0.0 )
					ifLocalVar60_g59943 = temp_output_66_0_g59943;
					else
					ifLocalVar60_g59943 = break55_g59943.y;
					float temp_output_597_28_g59942 = ifLocalVar60_g59943;
					float2 ifLocalVar89_g59943 = 0;
					if( temp_output_56_0_g59943 > 0.0 )
					ifLocalVar89_g59943 = temp_output_123_0_g59943;
					else if( temp_output_56_0_g59943 == 0.0 )
					ifLocalVar89_g59943 = temp_output_90_0_g59943;
					else if( temp_output_56_0_g59943 < 0.0 )
					ifLocalVar89_g59943 = temp_output_90_0_g59943;
					float3 temp_output_7_0_g59946 = frac( ( (ifLocalVar89_g59943).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59946 = dot( temp_output_7_0_g59946 , ( (temp_output_7_0_g59946).yzx + 33.33 ) );
					float3 temp_output_12_0_g59946 = ( temp_output_7_0_g59946 + dotResult8_g59946 );
					float2 temp_output_597_27_g59942 = ( UV100_g59943 + frac( ( ( (temp_output_12_0_g59946).xx + (temp_output_12_0_g59946).yz ) * (temp_output_12_0_g59946).zy ) ) );
					float temp_output_67_0_g59943 = ( 1.0 - break55_g59943.x );
					float ifLocalVar61_g59943 = 0;
					if( temp_output_56_0_g59943 <= 0.0 )
					ifLocalVar61_g59943 = temp_output_67_0_g59943;
					else
					ifLocalVar61_g59943 = break55_g59943.x;
					float temp_output_597_29_g59942 = ifLocalVar61_g59943;
					float4 Output_2D293_g59942 = ( ( tex2D( _Sampler82966_g59916, temp_output_597_0_g59942, DDX631_g59942, DDY632_g59942 ) * temp_output_597_30_g59942 ) + ( tex2D( _Sampler82966_g59916, temp_output_597_26_g59942, DDX631_g59942, DDY632_g59942 ) * temp_output_597_28_g59942 ) + ( tex2D( _Sampler82966_g59916, temp_output_597_27_g59942, DDX631_g59942, DDY632_g59942 ) * temp_output_597_29_g59942 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g59916 = Output_2D293_g59942;
					#else
					float4 staticSwitch1001_g59916 = staticSwitch1549_g59916;
					#endif
					float3 temp_output_2532_0_g59916 = (staticSwitch1001_g59916).rgb;
					float3 oAlbedo6_g59916 = temp_output_2532_0_g59916;
					float Black1185_g59916 = 0.0;
					float3 temp_cast_0 = (Black1185_g59916).xxx;
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch1180_g59916 = temp_cast_0;
					#else
					float3 staticSwitch1180_g59916 = oAlbedo6_g59916;
					#endif
					
					float2 texCoord2357_g59916 = IN.ase_texcoord7.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0A2420_g59916 = texCoord2357_g59916;
					#if defined( _UV_UV0 )
					float2 staticSwitch2671_g59916 = UV0A2420_g59916;
					#elif defined( _UV_UV2 )
					float2 staticSwitch2671_g59916 = UV22595_g59916;
					#else
					float2 staticSwitch2671_g59916 = UV22595_g59916;
					#endif
					#ifdef _METALLICMAP
					float staticSwitch846_g59916 = tex2D( _MetallicMap, staticSwitch2671_g59916 ).r;
					#else
					float staticSwitch846_g59916 = _Metallic;
					#endif
					float2 temp_output_5_0_g59937 = staticSwitch2671_g59916;
					float2 UV633_g59937 = temp_output_5_0_g59937;
					float2 UV100_g59938 = UV633_g59937;
					float2 temp_output_51_0_g59938 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59938 * float2( 3.464,3.464 ) ) );
					float2 break55_g59938 = frac( temp_output_51_0_g59938 );
					float temp_output_56_0_g59938 = ( ( 1.0 - break55_g59938.x ) - break55_g59938.y );
					float2 temp_output_52_0_g59938 = floor( temp_output_51_0_g59938 );
					float2 temp_output_125_0_g59938 = ( temp_output_52_0_g59938 + float2( 1,1 ) );
					float2 ifLocalVar87_g59938 = 0;
					if( temp_output_56_0_g59938 > 0.0 )
					ifLocalVar87_g59938 = temp_output_52_0_g59938;
					else if( temp_output_56_0_g59938 == 0.0 )
					ifLocalVar87_g59938 = temp_output_125_0_g59938;
					else if( temp_output_56_0_g59938 < 0.0 )
					ifLocalVar87_g59938 = temp_output_125_0_g59938;
					float3 temp_output_7_0_g59939 = frac( ( (ifLocalVar87_g59938).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59939 = dot( temp_output_7_0_g59939 , ( (temp_output_7_0_g59939).yzx + 33.33 ) );
					float3 temp_output_12_0_g59939 = ( temp_output_7_0_g59939 + dotResult8_g59939 );
					float2 temp_output_597_0_g59937 = ( UV100_g59938 + frac( ( ( (temp_output_12_0_g59939).xx + (temp_output_12_0_g59939).yz ) * (temp_output_12_0_g59939).zy ) ) );
					float2 DDX631_g59937 = ddx( temp_output_5_0_g59937 );
					float2 DDY632_g59937 = ddy( temp_output_5_0_g59937 );
					float temp_output_65_0_g59938 = ( 0.0 - temp_output_56_0_g59938 );
					float ifLocalVar59_g59938 = 0;
					if( temp_output_56_0_g59938 <= 0.0 )
					ifLocalVar59_g59938 = temp_output_65_0_g59938;
					else
					ifLocalVar59_g59938 = temp_output_56_0_g59938;
					float temp_output_597_30_g59937 = ifLocalVar59_g59938;
					float2 temp_output_90_0_g59938 = ( temp_output_52_0_g59938 + float2( 0,1 ) );
					float2 temp_output_123_0_g59938 = ( temp_output_52_0_g59938 + float2( 1,0 ) );
					float2 ifLocalVar88_g59938 = 0;
					if( temp_output_56_0_g59938 > 0.0 )
					ifLocalVar88_g59938 = temp_output_90_0_g59938;
					else if( temp_output_56_0_g59938 == 0.0 )
					ifLocalVar88_g59938 = temp_output_123_0_g59938;
					else if( temp_output_56_0_g59938 < 0.0 )
					ifLocalVar88_g59938 = temp_output_123_0_g59938;
					float3 temp_output_7_0_g59940 = frac( ( (ifLocalVar88_g59938).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59940 = dot( temp_output_7_0_g59940 , ( (temp_output_7_0_g59940).yzx + 33.33 ) );
					float3 temp_output_12_0_g59940 = ( temp_output_7_0_g59940 + dotResult8_g59940 );
					float2 temp_output_597_26_g59937 = ( UV100_g59938 + frac( ( ( (temp_output_12_0_g59940).xx + (temp_output_12_0_g59940).yz ) * (temp_output_12_0_g59940).zy ) ) );
					float temp_output_66_0_g59938 = ( 1.0 - break55_g59938.y );
					float ifLocalVar60_g59938 = 0;
					if( temp_output_56_0_g59938 <= 0.0 )
					ifLocalVar60_g59938 = temp_output_66_0_g59938;
					else
					ifLocalVar60_g59938 = break55_g59938.y;
					float temp_output_597_28_g59937 = ifLocalVar60_g59938;
					float2 ifLocalVar89_g59938 = 0;
					if( temp_output_56_0_g59938 > 0.0 )
					ifLocalVar89_g59938 = temp_output_123_0_g59938;
					else if( temp_output_56_0_g59938 == 0.0 )
					ifLocalVar89_g59938 = temp_output_90_0_g59938;
					else if( temp_output_56_0_g59938 < 0.0 )
					ifLocalVar89_g59938 = temp_output_90_0_g59938;
					float3 temp_output_7_0_g59941 = frac( ( (ifLocalVar89_g59938).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59941 = dot( temp_output_7_0_g59941 , ( (temp_output_7_0_g59941).yzx + 33.33 ) );
					float3 temp_output_12_0_g59941 = ( temp_output_7_0_g59941 + dotResult8_g59941 );
					float2 temp_output_597_27_g59937 = ( UV100_g59938 + frac( ( ( (temp_output_12_0_g59941).xx + (temp_output_12_0_g59941).yz ) * (temp_output_12_0_g59941).zy ) ) );
					float temp_output_67_0_g59938 = ( 1.0 - break55_g59938.x );
					float ifLocalVar61_g59938 = 0;
					if( temp_output_56_0_g59938 <= 0.0 )
					ifLocalVar61_g59938 = temp_output_67_0_g59938;
					else
					ifLocalVar61_g59938 = break55_g59938.x;
					float temp_output_597_29_g59937 = ifLocalVar61_g59938;
					float4 Output_2D293_g59937 = ( ( tex2D( _Sampler82967_g59916, temp_output_597_0_g59937, DDX631_g59937, DDY632_g59937 ) * temp_output_597_30_g59937 ) + ( tex2D( _Sampler82967_g59916, temp_output_597_26_g59937, DDX631_g59937, DDY632_g59937 ) * temp_output_597_28_g59937 ) + ( tex2D( _Sampler82967_g59916, temp_output_597_27_g59937, DDX631_g59937, DDY632_g59937 ) * temp_output_597_29_g59937 ) );
					float4 break31_g59937 = Output_2D293_g59937;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g59916 = break31_g59937.r;
					#else
					float staticSwitch1005_g59916 = staticSwitch846_g59916;
					#endif
					float Metallic1239_g59916 = staticSwitch1005_g59916;
					float3 aAlbedo1466_g59916 = ( temp_output_2532_0_g59916 * ( 1.0 - Metallic1239_g59916 ) );
					float White38_g59916 = 1.0;
					float4 temp_cast_1 = (White38_g59916).xxxx;
					float4 texCoord2426_g59916 = IN.ase_texcoord7;
					texCoord2426_g59916.xy = IN.ase_texcoord7.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0B2361_g59916 = (texCoord2426_g59916).zw;
					float localBicubicPrepare2_g59925 = ( 0.0 );
					float2 Input_UV100_g59925 = UV0B2361_g59916;
					float2 UV2_g59925 = Input_UV100_g59925;
					float4 TexelSize2_g59925 = _Lightmap0_TexelSize;
					float2 UV02_g59925 = float2( 0,0 );
					float2 UV12_g59925 = float2( 0,0 );
					float2 UV22_g59925 = float2( 0,0 );
					float2 UV32_g59925 = float2( 0,0 );
					float W02_g59925 = 0;
					float W12_g59925 = 0;
					{
					{
					 UV2_g59925 = UV2_g59925 * TexelSize2_g59925.zw - 0.5;
					    float2 f = frac( UV2_g59925 );
					    UV2_g59925 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59925.x - 0.5, UV2_g59925.x + 1.5, UV2_g59925.y - 0.5, UV2_g59925.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59925.xyxy;
					    UV02_g59925 = off.xz;
					    UV12_g59925 = off.yz;
					    UV22_g59925 = off.xw;
					    UV32_g59925 = off.yw;
					    W02_g59925 = s.x / ( s.x + s.y );
					 W12_g59925 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59925 = lerp( tex2D( _Lightmap0, UV32_g59925 ) , tex2D( _Lightmap0, UV22_g59925 ) , W02_g59925);
					float4 lerpResult45_g59925 = lerp( tex2D( _Lightmap0, UV12_g59925 ) , tex2D( _Lightmap0, UV02_g59925 ) , W02_g59925);
					float4 lerpResult44_g59925 = lerp( lerpResult46_g59925 , lerpResult45_g59925 , W12_g59925);
					float4 Output_2D_Auto131_g59925 = lerpResult44_g59925;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g59916 = Output_2D_Auto131_g59925;
					#else
					float4 staticSwitch1092_g59916 = float4( tex2D( _Lightmap0, UV0B2361_g59916 ).rgb , 0.0 );
					#endif
					float4 Lightmap_0925_g59916 = staticSwitch1092_g59916;
					float localBicubicPrepare2_g59923 = ( 0.0 );
					float2 Input_UV100_g59923 = UV0B2361_g59916;
					float2 UV2_g59923 = Input_UV100_g59923;
					float4 TexelSize2_g59923 = _Lightmap1_TexelSize;
					float2 UV02_g59923 = float2( 0,0 );
					float2 UV12_g59923 = float2( 0,0 );
					float2 UV22_g59923 = float2( 0,0 );
					float2 UV32_g59923 = float2( 0,0 );
					float W02_g59923 = 0;
					float W12_g59923 = 0;
					{
					{
					 UV2_g59923 = UV2_g59923 * TexelSize2_g59923.zw - 0.5;
					    float2 f = frac( UV2_g59923 );
					    UV2_g59923 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59923.x - 0.5, UV2_g59923.x + 1.5, UV2_g59923.y - 0.5, UV2_g59923.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59923.xyxy;
					    UV02_g59923 = off.xz;
					    UV12_g59923 = off.yz;
					    UV22_g59923 = off.xw;
					    UV32_g59923 = off.yw;
					    W02_g59923 = s.x / ( s.x + s.y );
					 W12_g59923 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59923 = lerp( tex2D( _Lightmap1, UV32_g59923 ) , tex2D( _Lightmap1, UV22_g59923 ) , W02_g59923);
					float4 lerpResult45_g59923 = lerp( tex2D( _Lightmap1, UV12_g59923 ) , tex2D( _Lightmap1, UV02_g59923 ) , W02_g59923);
					float4 lerpResult44_g59923 = lerp( lerpResult46_g59923 , lerpResult45_g59923 , W12_g59923);
					float4 Output_2D_Auto131_g59923 = lerpResult44_g59923;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g59916 = Output_2D_Auto131_g59923;
					#else
					float4 staticSwitch1088_g59916 = tex2D( _Lightmap1, UV0B2361_g59916 );
					#endif
					float4 Lightmap_1956_g59916 = staticSwitch1088_g59916;
					float Lightmap_Lerp_Value969_g59916 = _UdonLightmapLerp;
					float4 lerpResult442_g59916 = lerp( Lightmap_0925_g59916 , Lightmap_1956_g59916 , Lightmap_Lerp_Value969_g59916);
					float4 Lightmap_Lerp932_g59916 = lerpResult442_g59916;
					float3 appendResult139_g59962 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float2 temp_output_5_0_g59932 = UV0A2420_g59916;
					float2 UV633_g59932 = temp_output_5_0_g59932;
					float2 UV100_g59933 = UV633_g59932;
					float2 temp_output_51_0_g59933 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59933 * float2( 3.464,3.464 ) ) );
					float2 break55_g59933 = frac( temp_output_51_0_g59933 );
					float temp_output_56_0_g59933 = ( ( 1.0 - break55_g59933.x ) - break55_g59933.y );
					float2 temp_output_52_0_g59933 = floor( temp_output_51_0_g59933 );
					float2 temp_output_125_0_g59933 = ( temp_output_52_0_g59933 + float2( 1,1 ) );
					float2 ifLocalVar87_g59933 = 0;
					if( temp_output_56_0_g59933 > 0.0 )
					ifLocalVar87_g59933 = temp_output_52_0_g59933;
					else if( temp_output_56_0_g59933 == 0.0 )
					ifLocalVar87_g59933 = temp_output_125_0_g59933;
					else if( temp_output_56_0_g59933 < 0.0 )
					ifLocalVar87_g59933 = temp_output_125_0_g59933;
					float3 temp_output_7_0_g59934 = frac( ( (ifLocalVar87_g59933).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59934 = dot( temp_output_7_0_g59934 , ( (temp_output_7_0_g59934).yzx + 33.33 ) );
					float3 temp_output_12_0_g59934 = ( temp_output_7_0_g59934 + dotResult8_g59934 );
					float2 temp_output_597_0_g59932 = ( UV100_g59933 + frac( ( ( (temp_output_12_0_g59934).xx + (temp_output_12_0_g59934).yz ) * (temp_output_12_0_g59934).zy ) ) );
					float2 DDX631_g59932 = ddx( temp_output_5_0_g59932 );
					float2 DDY632_g59932 = ddy( temp_output_5_0_g59932 );
					float Input_Scale617_g59932 = 1.5;
					float temp_output_65_0_g59933 = ( 0.0 - temp_output_56_0_g59933 );
					float ifLocalVar59_g59933 = 0;
					if( temp_output_56_0_g59933 <= 0.0 )
					ifLocalVar59_g59933 = temp_output_65_0_g59933;
					else
					ifLocalVar59_g59933 = temp_output_56_0_g59933;
					float temp_output_597_30_g59932 = ifLocalVar59_g59933;
					float2 temp_output_90_0_g59933 = ( temp_output_52_0_g59933 + float2( 0,1 ) );
					float2 temp_output_123_0_g59933 = ( temp_output_52_0_g59933 + float2( 1,0 ) );
					float2 ifLocalVar88_g59933 = 0;
					if( temp_output_56_0_g59933 > 0.0 )
					ifLocalVar88_g59933 = temp_output_90_0_g59933;
					else if( temp_output_56_0_g59933 == 0.0 )
					ifLocalVar88_g59933 = temp_output_123_0_g59933;
					else if( temp_output_56_0_g59933 < 0.0 )
					ifLocalVar88_g59933 = temp_output_123_0_g59933;
					float3 temp_output_7_0_g59935 = frac( ( (ifLocalVar88_g59933).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59935 = dot( temp_output_7_0_g59935 , ( (temp_output_7_0_g59935).yzx + 33.33 ) );
					float3 temp_output_12_0_g59935 = ( temp_output_7_0_g59935 + dotResult8_g59935 );
					float2 temp_output_597_26_g59932 = ( UV100_g59933 + frac( ( ( (temp_output_12_0_g59935).xx + (temp_output_12_0_g59935).yz ) * (temp_output_12_0_g59935).zy ) ) );
					float temp_output_66_0_g59933 = ( 1.0 - break55_g59933.y );
					float ifLocalVar60_g59933 = 0;
					if( temp_output_56_0_g59933 <= 0.0 )
					ifLocalVar60_g59933 = temp_output_66_0_g59933;
					else
					ifLocalVar60_g59933 = break55_g59933.y;
					float temp_output_597_28_g59932 = ifLocalVar60_g59933;
					float2 ifLocalVar89_g59933 = 0;
					if( temp_output_56_0_g59933 > 0.0 )
					ifLocalVar89_g59933 = temp_output_123_0_g59933;
					else if( temp_output_56_0_g59933 == 0.0 )
					ifLocalVar89_g59933 = temp_output_90_0_g59933;
					else if( temp_output_56_0_g59933 < 0.0 )
					ifLocalVar89_g59933 = temp_output_90_0_g59933;
					float3 temp_output_7_0_g59936 = frac( ( (ifLocalVar89_g59933).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59936 = dot( temp_output_7_0_g59936 , ( (temp_output_7_0_g59936).yzx + 33.33 ) );
					float3 temp_output_12_0_g59936 = ( temp_output_7_0_g59936 + dotResult8_g59936 );
					float2 temp_output_597_27_g59932 = ( UV100_g59933 + frac( ( ( (temp_output_12_0_g59936).xx + (temp_output_12_0_g59936).yz ) * (temp_output_12_0_g59936).zy ) ) );
					float temp_output_67_0_g59933 = ( 1.0 - break55_g59933.x );
					float ifLocalVar61_g59933 = 0;
					if( temp_output_56_0_g59933 <= 0.0 )
					ifLocalVar61_g59933 = temp_output_67_0_g59933;
					else
					ifLocalVar61_g59933 = break55_g59933.x;
					float temp_output_597_29_g59932 = ifLocalVar61_g59933;
					float3 Output_2D_Normal641_g59932 = ( ( UnpackScaleNormal( tex2D( _Sampler82965_g59916, temp_output_597_0_g59932, DDX631_g59932, DDY632_g59932 ), Input_Scale617_g59932 ) * temp_output_597_30_g59932 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g59916, temp_output_597_26_g59932, DDX631_g59932, DDY632_g59932 ), Input_Scale617_g59932 ) * temp_output_597_28_g59932 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g59916, temp_output_597_27_g59932, DDX631_g59932, DDY632_g59932 ), Input_Scale617_g59932 ) * float3( 0,0,0 ) * temp_output_597_29_g59932 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g59916 = Output_2D_Normal641_g59932;
					#else
					float3 staticSwitch1003_g59916 = UnpackScaleNormal( tex2D( _BumpMap, UV0A2420_g59916 ), 1.5 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g59916 = staticSwitch1003_g59916;
					#else
					float3 staticSwitch980_g59916 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g59916 = staticSwitch980_g59916;
					float3 normalizeResult326_g59962 = normalize( Normal_Map700_g59916 );
					float3 Normal_Map318_g59962 = normalizeResult326_g59962;
					float dotResult121_g59962 = dot( appendResult139_g59962 , Normal_Map318_g59962 );
					float temp_output_2_0_g59964 = saturate( dotResult121_g59962 );
					float localStochasticTiling2_g59958 = ( 0.0 );
					float2 UV2_g59958 = UV0B2361_g59916;
					float4 TexelSize2_g59958 = _UdonRNMX0_TexelSize;
					float4 Offsets2_g59958 = float4( 0,0,0,0 );
					float2 Weights2_g59958 = float2( 0,0 );
					{
					UV2_g59958 = UV2_g59958 * TexelSize2_g59958.zw - 0.5;
					float2 f = frac( UV2_g59958 );
					UV2_g59958 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g59958.x - 0.5, UV2_g59958.x + 1.5, UV2_g59958.y - 0.5, UV2_g59958.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g59958 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59958.xyxy;
					Weights2_g59958 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g59957 = Offsets2_g59958;
					float4 Input_FetchOffsets197_g59959 = temp_output_1_34_g59957;
					float2 temp_output_1_54_g59957 = Weights2_g59958;
					float2 Input_FetchWeights200_g59959 = temp_output_1_54_g59957;
					float2 break187_g59959 = Input_FetchWeights200_g59959;
					float4 lerpResult181_g59959 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g59959).yw ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g59959).xw ) , break187_g59959.x);
					float4 lerpResult182_g59959 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g59959).yz ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g59959).xz ) , break187_g59959.x);
					float4 lerpResult176_g59959 = lerp( lerpResult181_g59959 , lerpResult182_g59959 , break187_g59959.y);
					float4 Output_Fetch2D_Auto202_g59959 = lerpResult176_g59959;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g59916 = Output_Fetch2D_Auto202_g59959;
					#else
					float4 staticSwitch1061_g59916 = tex2D( _UdonRNMX0, UV0B2361_g59916 );
					#endif
					float3 appendResult146_g59962 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59962 = dot( appendResult146_g59962 , Normal_Map318_g59962 );
					float temp_output_2_0_g59963 = saturate( dotResult122_g59962 );
					float4 Input_FetchOffsets197_g59960 = temp_output_1_34_g59957;
					float2 Input_FetchWeights200_g59960 = temp_output_1_54_g59957;
					float2 break187_g59960 = Input_FetchWeights200_g59960;
					float4 lerpResult181_g59960 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g59960).yw ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g59960).xw ) , break187_g59960.x);
					float4 lerpResult182_g59960 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g59960).yz ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g59960).xz ) , break187_g59960.x);
					float4 lerpResult176_g59960 = lerp( lerpResult181_g59960 , lerpResult182_g59960 , break187_g59960.y);
					float4 Output_Fetch2D_Auto202_g59960 = lerpResult176_g59960;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g59916 = Output_Fetch2D_Auto202_g59960;
					#else
					float4 staticSwitch1062_g59916 = tex2D( _UdonRNMY0, UV0B2361_g59916 );
					#endif
					float3 appendResult149_g59962 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59962 = dot( appendResult149_g59962 , Normal_Map318_g59962 );
					float temp_output_2_0_g59965 = saturate( dotResult120_g59962 );
					float4 Input_FetchOffsets197_g59961 = temp_output_1_34_g59957;
					float2 Input_FetchWeights200_g59961 = temp_output_1_54_g59957;
					float2 break187_g59961 = Input_FetchWeights200_g59961;
					float4 lerpResult181_g59961 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g59961).yw ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g59961).xw ) , break187_g59961.x);
					float4 lerpResult182_g59961 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g59961).yz ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g59961).xz ) , break187_g59961.x);
					float4 lerpResult176_g59961 = lerp( lerpResult181_g59961 , lerpResult182_g59961 , break187_g59961.y);
					float4 Output_Fetch2D_Auto202_g59961 = lerpResult176_g59961;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g59916 = Output_Fetch2D_Auto202_g59961;
					#else
					float4 staticSwitch1063_g59916 = tex2D( _UdonRNMZ0, UV0B2361_g59916 );
					#endif
					float4 RNM_0926_g59916 = ( ( ( ( ( temp_output_2_0_g59964 * temp_output_2_0_g59964 ) * staticSwitch1061_g59916 ) + ( ( temp_output_2_0_g59963 * temp_output_2_0_g59963 ) * staticSwitch1062_g59916 ) ) + ( ( temp_output_2_0_g59965 * temp_output_2_0_g59965 ) * staticSwitch1063_g59916 ) ) * 1.5 );
					float3 appendResult139_g59928 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g59928 = normalize( Normal_Map700_g59916 );
					float3 Normal_Map318_g59928 = normalizeResult326_g59928;
					float dotResult121_g59928 = dot( appendResult139_g59928 , Normal_Map318_g59928 );
					float temp_output_2_0_g59930 = saturate( dotResult121_g59928 );
					float localStochasticTiling2_g59918 = ( 0.0 );
					float2 UV2_g59918 = UV0B2361_g59916;
					float4 TexelSize2_g59918 = _UdonRNMX1_TexelSize;
					float4 Offsets2_g59918 = float4( 0,0,0,0 );
					float2 Weights2_g59918 = float2( 0,0 );
					{
					UV2_g59918 = UV2_g59918 * TexelSize2_g59918.zw - 0.5;
					float2 f = frac( UV2_g59918 );
					UV2_g59918 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g59918.x - 0.5, UV2_g59918.x + 1.5, UV2_g59918.y - 0.5, UV2_g59918.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g59918 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59918.xyxy;
					Weights2_g59918 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g59917 = Offsets2_g59918;
					float4 Input_FetchOffsets197_g59919 = temp_output_1_34_g59917;
					float2 temp_output_1_54_g59917 = Weights2_g59918;
					float2 Input_FetchWeights200_g59919 = temp_output_1_54_g59917;
					float2 break187_g59919 = Input_FetchWeights200_g59919;
					float4 lerpResult181_g59919 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g59919).yw ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g59919).xw ) , break187_g59919.x);
					float4 lerpResult182_g59919 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g59919).yz ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g59919).xz ) , break187_g59919.x);
					float4 lerpResult176_g59919 = lerp( lerpResult181_g59919 , lerpResult182_g59919 , break187_g59919.y);
					float4 Output_Fetch2D_Auto202_g59919 = lerpResult176_g59919;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g59916 = Output_Fetch2D_Auto202_g59919;
					#else
					float4 staticSwitch1087_g59916 = tex2D( _UdonRNMX1, UV0B2361_g59916 );
					#endif
					float3 appendResult146_g59928 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59928 = dot( appendResult146_g59928 , Normal_Map318_g59928 );
					float temp_output_2_0_g59929 = saturate( dotResult122_g59928 );
					float4 Input_FetchOffsets197_g59920 = temp_output_1_34_g59917;
					float2 Input_FetchWeights200_g59920 = temp_output_1_54_g59917;
					float2 break187_g59920 = Input_FetchWeights200_g59920;
					float4 lerpResult181_g59920 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g59920).yw ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g59920).xw ) , break187_g59920.x);
					float4 lerpResult182_g59920 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g59920).yz ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g59920).xz ) , break187_g59920.x);
					float4 lerpResult176_g59920 = lerp( lerpResult181_g59920 , lerpResult182_g59920 , break187_g59920.y);
					float4 Output_Fetch2D_Auto202_g59920 = lerpResult176_g59920;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g59916 = Output_Fetch2D_Auto202_g59920;
					#else
					float4 staticSwitch1083_g59916 = tex2D( _UdonRNMY1, UV0B2361_g59916 );
					#endif
					float3 appendResult149_g59928 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59928 = dot( appendResult149_g59928 , Normal_Map318_g59928 );
					float temp_output_2_0_g59931 = saturate( dotResult120_g59928 );
					float4 Input_FetchOffsets197_g59921 = temp_output_1_34_g59917;
					float2 Input_FetchWeights200_g59921 = temp_output_1_54_g59917;
					float2 break187_g59921 = Input_FetchWeights200_g59921;
					float4 lerpResult181_g59921 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g59921).yw ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g59921).xw ) , break187_g59921.x);
					float4 lerpResult182_g59921 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g59921).yz ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g59921).xz ) , break187_g59921.x);
					float4 lerpResult176_g59921 = lerp( lerpResult181_g59921 , lerpResult182_g59921 , break187_g59921.y);
					float4 Output_Fetch2D_Auto202_g59921 = lerpResult176_g59921;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g59916 = Output_Fetch2D_Auto202_g59921;
					#else
					float4 staticSwitch1084_g59916 = tex2D( _UdonRNMZ1, UV0B2361_g59916 );
					#endif
					float4 RNM_11081_g59916 = ( ( ( ( ( temp_output_2_0_g59930 * temp_output_2_0_g59930 ) * staticSwitch1087_g59916 ) + ( ( temp_output_2_0_g59929 * temp_output_2_0_g59929 ) * staticSwitch1083_g59916 ) ) + ( ( temp_output_2_0_g59931 * temp_output_2_0_g59931 ) * staticSwitch1084_g59916 ) ) * 1.5 );
					float4 lerpResult953_g59916 = lerp( RNM_0926_g59916 , RNM_11081_g59916 , Lightmap_Lerp_Value969_g59916);
					float4 RNM_Lerp950_g59916 = lerpResult953_g59916;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g59916 = temp_cast_1;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g59916 = Lightmap_0925_g59916;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g59916 = Lightmap_Lerp932_g59916;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g59916 = RNM_0926_g59916;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g59916 = RNM_Lerp950_g59916;
					#else
					float4 staticSwitch1014_g59916 = temp_cast_1;
					#endif
					float3 Lightmap46_g59916 = (staticSwitch1014_g59916).rgb;
					#if defined( _EMISSIONUV_UV0 )
					float2 staticSwitch2642_g59916 = UV0A2420_g59916;
					#elif defined( _EMISSIONUV_UV2 )
					float2 staticSwitch2642_g59916 = UV22595_g59916;
					#else
					float2 staticSwitch2642_g59916 = UV0A2420_g59916;
					#endif
					float2 temp_output_5_0_g59952 = staticSwitch2642_g59916;
					float2 UV633_g59952 = temp_output_5_0_g59952;
					float2 UV100_g59953 = UV633_g59952;
					float2 temp_output_51_0_g59953 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59953 * float2( 3.464,3.464 ) ) );
					float2 break55_g59953 = frac( temp_output_51_0_g59953 );
					float temp_output_56_0_g59953 = ( ( 1.0 - break55_g59953.x ) - break55_g59953.y );
					float2 temp_output_52_0_g59953 = floor( temp_output_51_0_g59953 );
					float2 temp_output_125_0_g59953 = ( temp_output_52_0_g59953 + float2( 1,1 ) );
					float2 ifLocalVar87_g59953 = 0;
					if( temp_output_56_0_g59953 > 0.0 )
					ifLocalVar87_g59953 = temp_output_52_0_g59953;
					else if( temp_output_56_0_g59953 == 0.0 )
					ifLocalVar87_g59953 = temp_output_125_0_g59953;
					else if( temp_output_56_0_g59953 < 0.0 )
					ifLocalVar87_g59953 = temp_output_125_0_g59953;
					float3 temp_output_7_0_g59954 = frac( ( (ifLocalVar87_g59953).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59954 = dot( temp_output_7_0_g59954 , ( (temp_output_7_0_g59954).yzx + 33.33 ) );
					float3 temp_output_12_0_g59954 = ( temp_output_7_0_g59954 + dotResult8_g59954 );
					float2 temp_output_597_0_g59952 = ( UV100_g59953 + frac( ( ( (temp_output_12_0_g59954).xx + (temp_output_12_0_g59954).yz ) * (temp_output_12_0_g59954).zy ) ) );
					float2 DDX631_g59952 = ddx( temp_output_5_0_g59952 );
					float2 DDY632_g59952 = ddy( temp_output_5_0_g59952 );
					float temp_output_65_0_g59953 = ( 0.0 - temp_output_56_0_g59953 );
					float ifLocalVar59_g59953 = 0;
					if( temp_output_56_0_g59953 <= 0.0 )
					ifLocalVar59_g59953 = temp_output_65_0_g59953;
					else
					ifLocalVar59_g59953 = temp_output_56_0_g59953;
					float temp_output_597_30_g59952 = ifLocalVar59_g59953;
					float2 temp_output_90_0_g59953 = ( temp_output_52_0_g59953 + float2( 0,1 ) );
					float2 temp_output_123_0_g59953 = ( temp_output_52_0_g59953 + float2( 1,0 ) );
					float2 ifLocalVar88_g59953 = 0;
					if( temp_output_56_0_g59953 > 0.0 )
					ifLocalVar88_g59953 = temp_output_90_0_g59953;
					else if( temp_output_56_0_g59953 == 0.0 )
					ifLocalVar88_g59953 = temp_output_123_0_g59953;
					else if( temp_output_56_0_g59953 < 0.0 )
					ifLocalVar88_g59953 = temp_output_123_0_g59953;
					float3 temp_output_7_0_g59955 = frac( ( (ifLocalVar88_g59953).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59955 = dot( temp_output_7_0_g59955 , ( (temp_output_7_0_g59955).yzx + 33.33 ) );
					float3 temp_output_12_0_g59955 = ( temp_output_7_0_g59955 + dotResult8_g59955 );
					float2 temp_output_597_26_g59952 = ( UV100_g59953 + frac( ( ( (temp_output_12_0_g59955).xx + (temp_output_12_0_g59955).yz ) * (temp_output_12_0_g59955).zy ) ) );
					float temp_output_66_0_g59953 = ( 1.0 - break55_g59953.y );
					float ifLocalVar60_g59953 = 0;
					if( temp_output_56_0_g59953 <= 0.0 )
					ifLocalVar60_g59953 = temp_output_66_0_g59953;
					else
					ifLocalVar60_g59953 = break55_g59953.y;
					float temp_output_597_28_g59952 = ifLocalVar60_g59953;
					float2 ifLocalVar89_g59953 = 0;
					if( temp_output_56_0_g59953 > 0.0 )
					ifLocalVar89_g59953 = temp_output_123_0_g59953;
					else if( temp_output_56_0_g59953 == 0.0 )
					ifLocalVar89_g59953 = temp_output_90_0_g59953;
					else if( temp_output_56_0_g59953 < 0.0 )
					ifLocalVar89_g59953 = temp_output_90_0_g59953;
					float3 temp_output_7_0_g59956 = frac( ( (ifLocalVar89_g59953).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59956 = dot( temp_output_7_0_g59956 , ( (temp_output_7_0_g59956).yzx + 33.33 ) );
					float3 temp_output_12_0_g59956 = ( temp_output_7_0_g59956 + dotResult8_g59956 );
					float2 temp_output_597_27_g59952 = ( UV100_g59953 + frac( ( ( (temp_output_12_0_g59956).xx + (temp_output_12_0_g59956).yz ) * (temp_output_12_0_g59956).zy ) ) );
					float temp_output_67_0_g59953 = ( 1.0 - break55_g59953.x );
					float ifLocalVar61_g59953 = 0;
					if( temp_output_56_0_g59953 <= 0.0 )
					ifLocalVar61_g59953 = temp_output_67_0_g59953;
					else
					ifLocalVar61_g59953 = break55_g59953.x;
					float temp_output_597_29_g59952 = ifLocalVar61_g59953;
					float4 Output_2D293_g59952 = ( ( tex2D( _Sampler82968_g59916, temp_output_597_0_g59952, DDX631_g59952, DDY632_g59952 ) * temp_output_597_30_g59952 ) + ( tex2D( _Sampler82968_g59916, temp_output_597_26_g59952, DDX631_g59952, DDY632_g59952 ) * temp_output_597_28_g59952 ) + ( tex2D( _Sampler82968_g59916, temp_output_597_27_g59952, DDX631_g59952, DDY632_g59952 ) * temp_output_597_29_g59952 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g59916 = Output_2D293_g59952;
					#else
					float4 staticSwitch1006_g59916 = tex2D( _EmissionMap, staticSwitch2642_g59916 );
					#endif
					float3 temp_output_2531_0_g59916 = (( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g59916 * _EmissionIntensity )).rgb;
					float3 Emission86_g59916 = temp_output_2531_0_g59916;
					float Color1_g59968 = oAlbedo6_g59916.x;
					float Metallic1_g59968 = Metallic1239_g59916;
					#if defined( _UV_UV0 )
					float2 staticSwitch2644_g59916 = UV0A2420_g59916;
					#elif defined( _UV_UV2 )
					float2 staticSwitch2644_g59916 = UV22595_g59916;
					#else
					float2 staticSwitch2644_g59916 = UV22595_g59916;
					#endif
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g59916 = tex2D( _GlossinessMap, staticSwitch2644_g59916 ).r;
					#else
					float staticSwitch845_g59916 = _Glossiness;
					#endif
					float2 temp_output_5_0_g59947 = staticSwitch2644_g59916;
					float2 UV633_g59947 = temp_output_5_0_g59947;
					float2 UV100_g59948 = UV633_g59947;
					float2 temp_output_51_0_g59948 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59948 * float2( 3.464,3.464 ) ) );
					float2 break55_g59948 = frac( temp_output_51_0_g59948 );
					float temp_output_56_0_g59948 = ( ( 1.0 - break55_g59948.x ) - break55_g59948.y );
					float2 temp_output_52_0_g59948 = floor( temp_output_51_0_g59948 );
					float2 temp_output_125_0_g59948 = ( temp_output_52_0_g59948 + float2( 1,1 ) );
					float2 ifLocalVar87_g59948 = 0;
					if( temp_output_56_0_g59948 > 0.0 )
					ifLocalVar87_g59948 = temp_output_52_0_g59948;
					else if( temp_output_56_0_g59948 == 0.0 )
					ifLocalVar87_g59948 = temp_output_125_0_g59948;
					else if( temp_output_56_0_g59948 < 0.0 )
					ifLocalVar87_g59948 = temp_output_125_0_g59948;
					float3 temp_output_7_0_g59949 = frac( ( (ifLocalVar87_g59948).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59949 = dot( temp_output_7_0_g59949 , ( (temp_output_7_0_g59949).yzx + 33.33 ) );
					float3 temp_output_12_0_g59949 = ( temp_output_7_0_g59949 + dotResult8_g59949 );
					float2 temp_output_597_0_g59947 = ( UV100_g59948 + frac( ( ( (temp_output_12_0_g59949).xx + (temp_output_12_0_g59949).yz ) * (temp_output_12_0_g59949).zy ) ) );
					float2 DDX631_g59947 = ddx( temp_output_5_0_g59947 );
					float2 DDY632_g59947 = ddy( temp_output_5_0_g59947 );
					float temp_output_65_0_g59948 = ( 0.0 - temp_output_56_0_g59948 );
					float ifLocalVar59_g59948 = 0;
					if( temp_output_56_0_g59948 <= 0.0 )
					ifLocalVar59_g59948 = temp_output_65_0_g59948;
					else
					ifLocalVar59_g59948 = temp_output_56_0_g59948;
					float temp_output_597_30_g59947 = ifLocalVar59_g59948;
					float2 temp_output_90_0_g59948 = ( temp_output_52_0_g59948 + float2( 0,1 ) );
					float2 temp_output_123_0_g59948 = ( temp_output_52_0_g59948 + float2( 1,0 ) );
					float2 ifLocalVar88_g59948 = 0;
					if( temp_output_56_0_g59948 > 0.0 )
					ifLocalVar88_g59948 = temp_output_90_0_g59948;
					else if( temp_output_56_0_g59948 == 0.0 )
					ifLocalVar88_g59948 = temp_output_123_0_g59948;
					else if( temp_output_56_0_g59948 < 0.0 )
					ifLocalVar88_g59948 = temp_output_123_0_g59948;
					float3 temp_output_7_0_g59950 = frac( ( (ifLocalVar88_g59948).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59950 = dot( temp_output_7_0_g59950 , ( (temp_output_7_0_g59950).yzx + 33.33 ) );
					float3 temp_output_12_0_g59950 = ( temp_output_7_0_g59950 + dotResult8_g59950 );
					float2 temp_output_597_26_g59947 = ( UV100_g59948 + frac( ( ( (temp_output_12_0_g59950).xx + (temp_output_12_0_g59950).yz ) * (temp_output_12_0_g59950).zy ) ) );
					float temp_output_66_0_g59948 = ( 1.0 - break55_g59948.y );
					float ifLocalVar60_g59948 = 0;
					if( temp_output_56_0_g59948 <= 0.0 )
					ifLocalVar60_g59948 = temp_output_66_0_g59948;
					else
					ifLocalVar60_g59948 = break55_g59948.y;
					float temp_output_597_28_g59947 = ifLocalVar60_g59948;
					float2 ifLocalVar89_g59948 = 0;
					if( temp_output_56_0_g59948 > 0.0 )
					ifLocalVar89_g59948 = temp_output_123_0_g59948;
					else if( temp_output_56_0_g59948 == 0.0 )
					ifLocalVar89_g59948 = temp_output_90_0_g59948;
					else if( temp_output_56_0_g59948 < 0.0 )
					ifLocalVar89_g59948 = temp_output_90_0_g59948;
					float3 temp_output_7_0_g59951 = frac( ( (ifLocalVar89_g59948).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59951 = dot( temp_output_7_0_g59951 , ( (temp_output_7_0_g59951).yzx + 33.33 ) );
					float3 temp_output_12_0_g59951 = ( temp_output_7_0_g59951 + dotResult8_g59951 );
					float2 temp_output_597_27_g59947 = ( UV100_g59948 + frac( ( ( (temp_output_12_0_g59951).xx + (temp_output_12_0_g59951).yz ) * (temp_output_12_0_g59951).zy ) ) );
					float temp_output_67_0_g59948 = ( 1.0 - break55_g59948.x );
					float ifLocalVar61_g59948 = 0;
					if( temp_output_56_0_g59948 <= 0.0 )
					ifLocalVar61_g59948 = temp_output_67_0_g59948;
					else
					ifLocalVar61_g59948 = break55_g59948.x;
					float temp_output_597_29_g59947 = ifLocalVar61_g59948;
					float4 Output_2D293_g59947 = ( ( tex2D( _Sampler82964_g59916, temp_output_597_0_g59947, DDX631_g59947, DDY632_g59947 ) * temp_output_597_30_g59947 ) + ( tex2D( _Sampler82964_g59916, temp_output_597_26_g59947, DDX631_g59947, DDY632_g59947 ) * temp_output_597_28_g59947 ) + ( tex2D( _Sampler82964_g59916, temp_output_597_27_g59947, DDX631_g59947, DDY632_g59947 ) * temp_output_597_29_g59947 ) );
					float4 break31_g59947 = Output_2D293_g59947;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g59916 = ( 1.0 - break31_g59947.r );
					#else
					float staticSwitch1004_g59916 = ( 1.0 - staticSwitch845_g59916 );
					#endif
					float temp_output_19_0_g59966 = staticSwitch1004_g59916;
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal2504_g59916 = Normal_Map700_g59916;
					float3 worldNormal2504_g59916 = normalize( float3( dot( tanToWorld0, tanNormal2504_g59916 ), dot( tanToWorld1, tanNormal2504_g59916 ), dot( tanToWorld2, tanNormal2504_g59916 ) ) );
					float3 World_Normal2508_g59916 = worldNormal2504_g59916;
					float3 tanNormal2_g59966 = World_Normal2508_g59916;
					float3 worldNormal2_g59966 = float3( dot( tanToWorld0, tanNormal2_g59966 ), dot( tanToWorld1, tanNormal2_g59966 ), dot( tanToWorld2, tanNormal2_g59966 ) );
					float3 temp_output_3_0_g59966 = ddx( worldNormal2_g59966 );
					float dotResult5_g59966 = dot( temp_output_3_0_g59966 , temp_output_3_0_g59966 );
					float3 temp_output_4_0_g59966 = ddy( worldNormal2_g59966 );
					float dotResult6_g59966 = dot( temp_output_4_0_g59966 , temp_output_4_0_g59966 );
					#ifdef _USEGEOMETRICAA_ON
					float staticSwitch15_g59966 = min( temp_output_19_0_g59966, ( 1.0 - pow( saturate( max( dotResult5_g59966, dotResult6_g59966 ) ) , 0.25 ) ) );
					#else
					float staticSwitch15_g59966 = temp_output_19_0_g59966;
					#endif
					float Smoothness1399_g59916 = staticSwitch15_g59966;
					float Smoothness1_g59968 = Smoothness1399_g59916;
					float IOR2700_g59916 = _IOR;
					float IOR1_g59968 = IOR2700_g59916;
					float3 temp_cast_5 = (0.04).xxx;
					float3 lerpResult1473_g59916 = lerp( temp_cast_5 , oAlbedo6_g59916 , Metallic1239_g59916);
					float3 switchResult1501_g59916 = (((ase_vface>0)?(World_Normal2508_g59916):(-World_Normal2508_g59916)));
					float3 View_Direction2511_g59916 = ViewDirWS;
					float dotResult1476_g59916 = dot( switchResult1501_g59916 , View_Direction2511_g59916 );
					float3 lerpResult1480_g59916 = lerp( lerpResult1473_g59916 , float3( 1,1,1 ) , pow( ( 1.0 - saturate( dotResult1476_g59916 ) ) , 5.0 ));
					float3 Fresnel1560_g59916 = lerpResult1480_g59916;
					float3 Fresnel1_g59968 = Fresnel1560_g59916;
					float3 World_Position2505_g59916 = PositionWS;
					float3 WorldPos1_g59968 = World_Position2505_g59916;
					float3 WorldNormal1_g59968 = World_Normal2508_g59916;
					float3 ViewDir1_g59968 = View_Direction2511_g59916;
					float3 localIndirectSpecularWithBoxProjection1_g59968 = IndirectSpecularWithBoxProjection1_g59968( Color1_g59968 , Metallic1_g59968 , Smoothness1_g59968 , IOR1_g59968 , Fresnel1_g59968 , WorldPos1_g59968 , WorldNormal1_g59968 , ViewDir1_g59968 );
					float3 temp_output_2745_0_g59916 = localIndirectSpecularWithBoxProjection1_g59968;
					float grayscale2713_g59916 = Luminance( Lightmap46_g59916 );
					float smoothstepResult2430_g59916 = smoothstep( 0.0 , 0.1 , grayscale2713_g59916);
					#ifdef _USELIGHTMAPPEDREFLECTIONS_ON
					float3 staticSwitch1469_g59916 = ( temp_output_2745_0_g59916 * smoothstepResult2430_g59916 );
					#else
					float3 staticSwitch1469_g59916 = temp_output_2745_0_g59916;
					#endif
					float3 Reflections1419_g59916 = staticSwitch1469_g59916;
					float3 AlbedoColor97_g59967 = oAlbedo6_g59916;
					float3 LightmapColor97_g59967 = Lightmap46_g59916;
					float Metallic97_g59967 = Metallic1239_g59916;
					float Smoothness97_g59967 = Smoothness1399_g59916;
					float IOR97_g59967 = IOR2700_g59916;
					float3 Fresnel97_g59967 = Fresnel1560_g59916;
					float3 WorldPos97_g59967 = World_Position2505_g59916;
					float3 WorldNormal97_g59967 = World_Normal2508_g59916;
					float3 ViewDir97_g59967 = View_Direction2511_g59916;
					float3 localSpecular97_g59967 = Specular( AlbedoColor97_g59967 , LightmapColor97_g59967 , Metallic97_g59967 , Smoothness97_g59967 , IOR97_g59967 , Fresnel97_g59967 , WorldPos97_g59967 , WorldNormal97_g59967 , ViewDir97_g59967 );
					float3 Speculars2560_g59916 = localSpecular97_g59967;
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch1181_g59916 = Lightmap46_g59916;
					#else
					float3 staticSwitch1181_g59916 = ( ( aAlbedo1466_g59916 * Lightmap46_g59916 ) + Emission86_g59916 + Reflections1419_g59916 + Speculars2560_g59916 );
					#endif
					float3 temp_output_35_0_g59926 = staticSwitch1181_g59916;
					float3 Color353_g59926 = temp_output_35_0_g59926;
					#if defined( _LUTMODE_2D )
					float3 staticSwitch273_g59926 = saturate( temp_output_35_0_g59926 );
					#elif defined( _LUTMODE_3D )
					float3 staticSwitch273_g59926 = temp_output_35_0_g59926;
					#else
					float3 staticSwitch273_g59926 = temp_output_35_0_g59926;
					#endif
					float3 Color_Saturate49_g59926 = staticSwitch273_g59926;
					float Lut_Height213_g59926 = _LUTSize;
					float Lut_Width216_g59926 = ( _LUTSize * Lut_Height213_g59926 );
					float3 appendResult214_g59926 = (float3(( 1.0 / Lut_Width216_g59926 ) , ( 1.0 / Lut_Height213_g59926 ) , ( Lut_Height213_g59926 - 1.0 )));
					float3 Scale_Offset208_g59926 = appendResult214_g59926;
					float2 Scale_Factor292_g59926 = ( (Scale_Offset208_g59926).xy * (Scale_Offset208_g59926).z );
					float2 Offset299_g59926 = ( (Scale_Offset208_g59926).xy * 0.5 );
					float2 Adjusted_UV305_g59926 = ( ( (Color_Saturate49_g59926).xy * Scale_Factor292_g59926 ) + Offset299_g59926 );
					float Scaled_Blue280_g59926 = ( (Color_Saturate49_g59926).z * (Scale_Offset208_g59926).z );
					float Shift288_g59926 = floor( Scaled_Blue280_g59926 );
					float Final_X313_g59926 = ( (Adjusted_UV305_g59926).x + ( Shift288_g59926 * (Scale_Offset208_g59926).y ) );
					float2 appendResult326_g59926 = (float2(Final_X313_g59926 , (Adjusted_UV305_g59926).y));
					float2 Final_UV325_g59926 = appendResult326_g59926;
					float2 appendResult338_g59926 = (float2((Scale_Offset208_g59926).y , 0.0));
					float2 Offset_UV336_g59926 = ( Final_UV325_g59926 + appendResult338_g59926 );
					float3 lerpResult333_g59926 = lerp( tex2D( _2DLut, Final_UV325_g59926 ).rgb , tex2D( _2DLut, Offset_UV336_g59926 ).rgb , ( Scaled_Blue280_g59926 - Shift288_g59926 ));
					#ifdef _2DLUT
					float3 staticSwitch347_g59926 = lerpResult333_g59926;
					#else
					float3 staticSwitch347_g59926 = Color_Saturate49_g59926;
					#endif
					float3 TwoD_LUT346_g59926 = staticSwitch347_g59926;
					float3 RGB16_g59927 = ( ( log10( ( ( Color_Saturate49_g59926 * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 );
					#ifdef _3DLUT
					float3 staticSwitch194_g59926 = tex3D( _3DLut, RGB16_g59927 ).rgb;
					#else
					float3 staticSwitch194_g59926 = Color_Saturate49_g59926;
					#endif
					float3 ThreeD_LUT51_g59926 = staticSwitch194_g59926;
					#if defined( _LUTMODE_2D )
					float3 staticSwitch42_g59926 = TwoD_LUT346_g59926;
					#elif defined( _LUTMODE_3D )
					float3 staticSwitch42_g59926 = ThreeD_LUT51_g59926;
					#else
					float3 staticSwitch42_g59926 = ThreeD_LUT51_g59926;
					#endif
					#ifdef SHADER_API_MOBILE
					float3 staticSwitch41_g59926 = staticSwitch42_g59926;
					#else
					float3 staticSwitch41_g59926 = Color353_g59926;
					#endif
					
					#ifdef _LIGHTMAPDEBUG
					float staticSwitch1191_g59916 = White38_g59916;
					#else
					float staticSwitch1191_g59916 = staticSwitch1001_g59916.a;
					#endif
					

					o.Albedo = staticSwitch1180_g59916;
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

					o.Emission = staticSwitch41_g59926;
					o.Alpha = staticSwitch1191_g59916;
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
				
				Name "ShadowCaster"
				Tags { "LightMode"="ShadowCaster" }
				ZWrite On
				ZTest LEqual
				AlphaToMask Off

				CGPROGRAM
				#define ASE_GEOMETRY
				#define UNITY_STANDARD_USE_DITHER_MASK 1
				#define ASE_FRAGMENT_NORMAL 0
				#pragma multi_compile _ LOD_FADE_CROSSFADE
				#define ASE_FOG
				#define _SPECULARHIGHLIGHTS_OFF
				#pragma multi_compile_instancing
				#define ASE_NO_AMBIENT 1
				#define ASE_LIGHTING_SIMPLE 1
				#define _GLOSSYREFLECTIONS_OFF
				#define _ALPHABLEND_ON 1
				#define ASE_VERSION 19907

				#pragma vertex vert
				#pragma fragment frag
				#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
				#pragma multi_compile_shadowcaster
				#ifndef UNITY_PASS_SHADOWCASTER
					#define UNITY_PASS_SHADOWCASTER
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

				#define ASE_NEEDS_VERT_NORMAL
				#define ASE_NEEDS_TEXTURE_COORDINATES2
				#pragma shader_feature _LIGHTMAPDEBUG
				#pragma shader_feature_local _STOCHASTICENABLED_ON
				#pragma shader_feature_local _MAINTEX


				struct appdata
				{
					float4 vertex : POSITION;
					half3 normal : NORMAL;
					half4 tangent : TANGENT;
					float4 texcoord1 : TEXCOORD1;
					float4 texcoord2 : TEXCOORD2;
					
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct v2f
				{
					V2F_SHADOW_CASTER;
					float4 ase_texcoord1 : TEXCOORD1;
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
				sampler2D _Sampler82966_g59916;


				
				v2f VertexFunction( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 World_Position2505_g59916 = ase_positionWS;
					
					o.ase_texcoord1.xy = v.texcoord2.xyzw.xy;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord1.zw = 0;

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = ( v.normal * ( distance( World_Position2505_g59916 , _WorldSpaceCameraPos ) * 0.0005 ) );
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = v.normal;
					v.tangent = v.tangent;

				#if defined( ASE_IMPOSTOR )
					// Disable "Normal Bias" because we're rendering billboard impostors and there's no vertex normals.
					unity_LightShadowBias.z = 0;
				#endif

					TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
					return o;
				}

				#if defined(ASE_TESSELLATION)
				struct VertexControl
				{
					float4 vertex : INTERNALTESSPOS;
					half4 tangent : TANGENT;
					half3 normal : NORMAL;
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
				v2f vert( appdata v )
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

					#if defined(ASE_LIGHTING_SIMPLE)
						SurfaceOutput o = (SurfaceOutput)0;
					#else
						#if defined(_SPECULAR_SETUP)
							SurfaceOutputStandardSpecular o = (SurfaceOutputStandardSpecular)0;
						#else
							SurfaceOutputStandard o = (SurfaceOutputStandard)0;
						#endif
						o.Occlusion = 1;
					#endif

					float2 texCoord2594_g59916 = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV22595_g59916 = texCoord2594_g59916;
					#ifdef _MAINTEX
					float4 staticSwitch1549_g59916 = tex2D( _MainTex, UV22595_g59916 );
					#else
					float4 staticSwitch1549_g59916 = _Color;
					#endif
					float2 temp_output_5_0_g59942 = UV22595_g59916;
					float2 UV633_g59942 = temp_output_5_0_g59942;
					float2 UV100_g59943 = UV633_g59942;
					float2 temp_output_51_0_g59943 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59943 * float2( 3.464,3.464 ) ) );
					float2 break55_g59943 = frac( temp_output_51_0_g59943 );
					float temp_output_56_0_g59943 = ( ( 1.0 - break55_g59943.x ) - break55_g59943.y );
					float2 temp_output_52_0_g59943 = floor( temp_output_51_0_g59943 );
					float2 temp_output_125_0_g59943 = ( temp_output_52_0_g59943 + float2( 1,1 ) );
					float2 ifLocalVar87_g59943 = 0;
					if( temp_output_56_0_g59943 > 0.0 )
					ifLocalVar87_g59943 = temp_output_52_0_g59943;
					else if( temp_output_56_0_g59943 == 0.0 )
					ifLocalVar87_g59943 = temp_output_125_0_g59943;
					else if( temp_output_56_0_g59943 < 0.0 )
					ifLocalVar87_g59943 = temp_output_125_0_g59943;
					float3 temp_output_7_0_g59944 = frac( ( (ifLocalVar87_g59943).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59944 = dot( temp_output_7_0_g59944 , ( (temp_output_7_0_g59944).yzx + 33.33 ) );
					float3 temp_output_12_0_g59944 = ( temp_output_7_0_g59944 + dotResult8_g59944 );
					float2 temp_output_597_0_g59942 = ( UV100_g59943 + frac( ( ( (temp_output_12_0_g59944).xx + (temp_output_12_0_g59944).yz ) * (temp_output_12_0_g59944).zy ) ) );
					float2 DDX631_g59942 = ddx( temp_output_5_0_g59942 );
					float2 DDY632_g59942 = ddy( temp_output_5_0_g59942 );
					float temp_output_65_0_g59943 = ( 0.0 - temp_output_56_0_g59943 );
					float ifLocalVar59_g59943 = 0;
					if( temp_output_56_0_g59943 <= 0.0 )
					ifLocalVar59_g59943 = temp_output_65_0_g59943;
					else
					ifLocalVar59_g59943 = temp_output_56_0_g59943;
					float temp_output_597_30_g59942 = ifLocalVar59_g59943;
					float2 temp_output_90_0_g59943 = ( temp_output_52_0_g59943 + float2( 0,1 ) );
					float2 temp_output_123_0_g59943 = ( temp_output_52_0_g59943 + float2( 1,0 ) );
					float2 ifLocalVar88_g59943 = 0;
					if( temp_output_56_0_g59943 > 0.0 )
					ifLocalVar88_g59943 = temp_output_90_0_g59943;
					else if( temp_output_56_0_g59943 == 0.0 )
					ifLocalVar88_g59943 = temp_output_123_0_g59943;
					else if( temp_output_56_0_g59943 < 0.0 )
					ifLocalVar88_g59943 = temp_output_123_0_g59943;
					float3 temp_output_7_0_g59945 = frac( ( (ifLocalVar88_g59943).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59945 = dot( temp_output_7_0_g59945 , ( (temp_output_7_0_g59945).yzx + 33.33 ) );
					float3 temp_output_12_0_g59945 = ( temp_output_7_0_g59945 + dotResult8_g59945 );
					float2 temp_output_597_26_g59942 = ( UV100_g59943 + frac( ( ( (temp_output_12_0_g59945).xx + (temp_output_12_0_g59945).yz ) * (temp_output_12_0_g59945).zy ) ) );
					float temp_output_66_0_g59943 = ( 1.0 - break55_g59943.y );
					float ifLocalVar60_g59943 = 0;
					if( temp_output_56_0_g59943 <= 0.0 )
					ifLocalVar60_g59943 = temp_output_66_0_g59943;
					else
					ifLocalVar60_g59943 = break55_g59943.y;
					float temp_output_597_28_g59942 = ifLocalVar60_g59943;
					float2 ifLocalVar89_g59943 = 0;
					if( temp_output_56_0_g59943 > 0.0 )
					ifLocalVar89_g59943 = temp_output_123_0_g59943;
					else if( temp_output_56_0_g59943 == 0.0 )
					ifLocalVar89_g59943 = temp_output_90_0_g59943;
					else if( temp_output_56_0_g59943 < 0.0 )
					ifLocalVar89_g59943 = temp_output_90_0_g59943;
					float3 temp_output_7_0_g59946 = frac( ( (ifLocalVar89_g59943).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59946 = dot( temp_output_7_0_g59946 , ( (temp_output_7_0_g59946).yzx + 33.33 ) );
					float3 temp_output_12_0_g59946 = ( temp_output_7_0_g59946 + dotResult8_g59946 );
					float2 temp_output_597_27_g59942 = ( UV100_g59943 + frac( ( ( (temp_output_12_0_g59946).xx + (temp_output_12_0_g59946).yz ) * (temp_output_12_0_g59946).zy ) ) );
					float temp_output_67_0_g59943 = ( 1.0 - break55_g59943.x );
					float ifLocalVar61_g59943 = 0;
					if( temp_output_56_0_g59943 <= 0.0 )
					ifLocalVar61_g59943 = temp_output_67_0_g59943;
					else
					ifLocalVar61_g59943 = break55_g59943.x;
					float temp_output_597_29_g59942 = ifLocalVar61_g59943;
					float4 Output_2D293_g59942 = ( ( tex2D( _Sampler82966_g59916, temp_output_597_0_g59942, DDX631_g59942, DDY632_g59942 ) * temp_output_597_30_g59942 ) + ( tex2D( _Sampler82966_g59916, temp_output_597_26_g59942, DDX631_g59942, DDY632_g59942 ) * temp_output_597_28_g59942 ) + ( tex2D( _Sampler82966_g59916, temp_output_597_27_g59942, DDX631_g59942, DDY632_g59942 ) * temp_output_597_29_g59942 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g59916 = Output_2D293_g59942;
					#else
					float4 staticSwitch1001_g59916 = staticSwitch1549_g59916;
					#endif
					float White38_g59916 = 1.0;
					#ifdef _LIGHTMAPDEBUG
					float staticSwitch1191_g59916 = White38_g59916;
					#else
					float staticSwitch1191_g59916 = staticSwitch1001_g59916.a;
					#endif
					

					o.Normal = half3( 0, 0, 1 );

					o.Alpha = staticSwitch1191_g59916;
					half AlphaClipThreshold = 0.5;
					half AlphaClipThresholdShadow = 0.5;

					#if defined( ASE_DEPTH_WRITE_ON )
						float DeviceDepth = IN.pos.z;
					#endif

					#ifdef _ALPHATEST_SHADOW_ON
						if (unity_LightShadowBias.z != 0.0)
							clip(o.Alpha - AlphaClipThresholdShadow);
						#ifdef _ALPHATEST_ON
						else
							clip(o.Alpha - AlphaClipThreshold);
						#endif
					#else
						#ifdef _ALPHATEST_ON
							clip(o.Alpha - AlphaClipThreshold);
						#endif
					#endif

					#ifdef UNITY_STANDARD_USE_DITHER_MASK
						half alphaRef = tex3D(_DitherMaskLOD, float3(IN.pos.xy*0.25,o.Alpha*0.9375)).a;
						clip(alphaRef - 0.01);
					#endif

					#if defined( ASE_DEPTH_WRITE_ON )
						outputDepth = DeviceDepth;
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
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3020;192,-1200;Inherit;False;Meenphie;0;;59916;b3ba55a08dd6b49c7be16c6f35cf2033;6,1008,1,2632,1,2635,1,2636,1,2670,1,2619,1;0;6;FLOAT3;625;FLOAT3;624;FLOAT;156;FLOAT;427;FLOAT3;1024;FLOAT;2714
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2889;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;4;5;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;True;1;LightMode=ForwardAdd;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2890;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2891;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2892;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2893;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2894;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ScenePickingPass;0;7;ScenePickingPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=ScenePickingPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2888;512,-1200;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;6;Meenphie/Decal/Alpha;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardBase;0;1;ForwardBase;17;True;True;4;1;False;;1;False;;0;1;False;;1;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;2;False;;True;3;False;;False;False;True;3;RenderType=Transparent=RenderType;Queue=Transparent=Queue=1;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;4;5;False;;10;False;;0;1;False;;1;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;44;Category;0;0;  Instanced Terrain Normals;1;0;Workflow;3;639057697570214470;Surface;1;639109938126817630;  Blend;0;639116862207420780;  Dither Shadows;1;0;Two Sided;1;639101642247268830;Alpha Clipping;0;639109936712846350;  Use Shadow Threshold;0;638915420933436960;Deferred Pass;0;638915425282396370;Normal Space;0;0;Transmission;0;638915425258747670;  Transmission Shadow;0.5,False,;0;Translucency;0;638915425246861880;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;1;638922399804812020;Receive Shadows;0;638922399717523500;Receive Specular;0;638915388784334560;Receive Reflections;0;639109937163683620;GPU Instancing;1;638915411619689990;LOD CrossFade;1;0;Built-in Fog;1;0;Ambient Light;0;639049545902984550;Meta Pass;0;639048817054746750;Add Pass;0;639048817051401800;Override Baked GI;0;638915390973737640;Write Depth;0;638915421117196140;Extra Pre Pass;0;639048817123696260;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;0;Vertex Position;1;0;0;8;False;True;False;False;False;True;False;False;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2887;512,-1440;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;True;True;0;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;True;True;1;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;0;False;;True;3;False;;True;False;0;False;;0;False;;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;0;False;0
WireConnection;2888;0;3020;625
WireConnection;2888;2;3020;624
WireConnection;2888;7;3020;156
WireConnection;2888;15;3020;1024
ASEEND*/
//CHKSM=ECCED0EF5A31F1E5DC60E4A096EBBFD41222BC6B