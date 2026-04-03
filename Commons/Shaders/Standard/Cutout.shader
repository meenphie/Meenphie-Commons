// Made with Amplify Shader Editor v1.9.9.7
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Standard/Cutout"
{
	Properties
	{
		[Meenphie_DrawerCategory(SURFACE OPTIONS,true,0,0)] _CATEGORY_SURFACEOPTIONS( "CATEGORY_SURFACEOPTIONS", Float ) = 1
		_Color( "DIffuse Color", Color ) = ( 0.9058824, 0.9058824, 0.9058824, 1 )
		[NoScaleOffset][SingleLineTexture] _MainTex( "Base Color", 2D ) = "white" {}
		[NoScaleOffset][SingleLineTexture] _BumpMap( "Normal", 2D ) = "bump" {}
		_MaskClipValue( "Mask Clip Value", Range( 0, 1 ) ) = 0.5
		[NoScaleOffset][SingleLineTexture] _MetallicMap( "Metallic", 2D ) = "black" {}
		[NoScaleOffset][SingleLineTexture] _GlossinessMap( "Roughness", 2D ) = "black" {}
		_Metallic( "Metallic", Range( 0, 1 ) ) = 0
		_Glossiness( "Roughness", Range( 0, 1 ) ) = 0.5
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
		[Toggle( _IsMetallic )] _IsMetallic( "IsMetallic", Float ) = 0
		[Meenphie_DrawerCategory(SPECIAL EFFECTS,true,0,0)] _CATEGORYSPECIALEFFECTS( "CATEGORY SPECIAL EFFECTS", Float ) = 0
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESPECIALEFFECTS( "CATEGORY SPACE SPECIAL EFFECTS", Float ) = 0
		[HideInInspector] GenKey__3DLut( "Assign keyword _3DLUT", Float ) = 1.0
		[HideInInspector] GenKey__MainTex( "Assign keyword _MAINTEX", Float ) = 1.0
		[HideInInspector] GenKey__MetallicMap( "Assign keyword _METALLICMAP", Float ) = 1.0
		[HideInInspector] GenKey__GlossinessMap( "Assign keyword _GLOSSINESSMAP", Float ) = 1.0
		[HideInInspector] GenKey__2DLut( "Assign keyword _2DLUT", Float ) = 1.0
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0


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
		

		

		Tags { "RenderType"="TransparentCutout" "Queue"="Geometry" "DisableBatching"="False" }

	LOD 0

		Cull Off
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
				#pragma multi_compile _ LOD_FADE_CROSSFADE
				#pragma multi_compile_fog
				#define ASE_FOG
				#define _SPECULARHIGHLIGHTS_OFF
				#pragma multi_compile_instancing
				#define _ALPHATEST_ON
				#define ASE_NO_AMBIENT 1
				#define ASE_LIGHTING_SIMPLE 1
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
				#define ASE_NEEDS_WORLD_POSITION
				#define ASE_NEEDS_FRAG_WORLD_POSITION
				#define ASE_NEEDS_WORLD_TANGENT
				#define ASE_NEEDS_FRAG_WORLD_TANGENT
				#define ASE_NEEDS_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_BITANGENT
				#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
				#pragma shader_feature_fragment _LIGHTMAPDEBUG
				#pragma shader_feature_local_fragment _STOCHASTICENABLED_ON
				#pragma shader_feature_local_fragment _MAINTEX
				#pragma shader_feature_local_fragment _METALLICMAP
				#pragma shader_feature_local_fragment _LIGHTMAPMODE_DISABLED _LIGHTMAPMODE_SIMPLE _LIGHTMAPMODE_SIMPLELERP _LIGHTMAPMODE_RNM _LIGHTMAPMODE_RNMLERP
				#pragma shader_feature_local_fragment _USEBICUBICFILTERING_ON
				#pragma shader_feature_local_fragment _BUMPMAP
				#pragma shader_feature_local_fragment _USELIGHTMAPPEDREFLECTIONS_ON
				#pragma shader_feature_local_fragment _IsMetallic
				#pragma shader_feature_local _USEGEOMETRICAA_ON
				#pragma shader_feature_local_fragment _GLOSSINESSMAP
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
				sampler2D _Sampler82966_g59975;
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				sampler2D _Sampler82967_g59975;
				uniform sampler2D _Lightmap0;
				float4 _Lightmap0_TexelSize;
				uniform sampler2D _Lightmap1;
				float4 _Lightmap1_TexelSize;
				uniform float _UdonLightmapLerp;
				uniform sampler2D _BumpMap;
				sampler2D _Sampler82965_g59975;
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
				sampler2D _Sampler82968_g59975;
				uniform float _EmissionIntensity;
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				sampler2D _Sampler82964_g59975;
				uniform float _MaskClipValue;


				float3 IndirectSpecularWithBoxProjection1_g60026( float3 WorldPos, float3 WorldNormal, float3 ViewDir, float3 Fresnel, float Smoothness )
				{
					// --- 1. SETUP DES VECTEURS ---
					float3 N = normalize(WorldNormal);
					float3 V = normalize(ViewDir);
					float3 R = reflect(-V, N);
					// --- 2. BOX PROJECTION ---
					float3 ray = R;
					if (unity_SpecCube0_ProbePosition.w > 0.0)
					{
					    float3 factors = ((ray > 0.0 ? unity_SpecCube0_BoxMax.xyz : unity_SpecCube0_BoxMin.xyz) - WorldPos) / ray;
					    float scalar = min(min(factors.x, factors.y), factors.z);
					    ray = ray * scalar + (WorldPos - unity_SpecCube0_ProbePosition.xyz);
					}
					// --- 3. SAMPLING ---
					// CORRECTED: Smoothness 1.0 -> Mip 0 | Smoothness 0.0 -> Mip 7
					float mipLevel = (1.0 - Smoothness) * 7.0;
					float4 envSample = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, ray, mipLevel);
					float3 indirectSpec = DecodeHDR(envSample, unity_SpecCube0_HDR);
					return indirectSpec * Fresnel;
				}
				
				float3 Specular( float3 AlbedoColor, float3 LightmapColor, float Metallic, float Smoothness, float3 Fresnel, float3 WorldPos, float3 WorldNormal, float3 ViewDir )
				{
					// --- CONFIGURATION ---
					float LumaStart = 0.05;
					float LumaEnd = 1.0;
					float RadiusFadeStart = 0.0;
					float specBoost = 0.5;
					#if defined(SHADER_API_MOBILE)
					#define MAX_RADIUS 10.0
					#else
					#define MAX_RADIUS 20.0
					#endif
					// --- INITIALISATION PBR ---
					float3 f0_dielectric = float3(0.04, 0.04, 0.04);
					float3 f0_metal = AlbedoColor.rgb;
					// La base de la réflectance (F0)
					float3 F0 = lerp(f0_dielectric, f0_metal, Metallic);
					float luma = dot(LightmapColor, float3(0.22, 0.70, 0.08));
					float lmMask = saturate((luma - LumaStart) / max(LumaEnd - LumaStart, 0.0001));
					float playerDist = distance(_WorldSpaceCameraPos, WorldPos);
					float fadeT = saturate((playerDist - RadiusFadeStart) / max(MAX_RADIUS - RadiusFadeStart, 0.0001));
					float radiusFade = 1.0 - (fadeT * fadeT * (3.0 - 2.0 * fadeT));
					if (lmMask < 0.001 || Smoothness < 0.01 || _UdonSpecularLightCount == 0 || radiusFade < 0.001) return 0;
					float3 vDir = normalize(ViewDir);
					float3 N = normalize(WorldNormal);
					// Normalisation Blinn-Phong (Energy Conservation)
					float shininess = exp2(10.0 * Smoothness + 1.0);
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
					    float denom = dot(dirAngle.xyz, R);
					    if (dirAngle.w < -0.9 || denom < -0.001) {
					        float tPlane = (dirAngle.w < -0.9) ? dot(L_center, R) : (dot(L_center, dirAngle.xyz) / denom);
					        float3 intersection = R * max(0.0, tPlane);
					        float3 localP = (WorldPos + intersection) - posRange.xyz;
					        float2 halfSize = float2(_UdonSpecularLightRight[i].w, _UdonSpecularLightUp[i].w);
					        float2 clampedPos = clamp(float2(dot(localP, _UdonSpecularLightRight[i].xyz), dot(localP, _UdonSpecularLightUp[i].xyz)), -halfSize, halfSize);
					        float3 closestPoint = posRange.xyz + _UdonSpecularLightRight[i].xyz * clampedPos.x + _UdonSpecularLightUp[i].xyz * clampedPos.y;
					        float3 diff = closestPoint - WorldPos;
					        float distSq = dot(diff, diff);
					        float falloff = saturate(1.0 - distSqCenter/rangeSq);
					        falloff = (falloff * falloff) / (distSq + 1.0);
					        float3 lDir = normalize(diff);
					        float nDotL = saturate(dot(N, lDir)); 
					        float3 H = normalize(lDir + vDir);
					        // Specular Term
					        float nDotH = saturate(dot(N, H));
					        float spec = exp2(log2(max(nDotH, 0.00001)) * shininess) * normalization;
					        float hDotV = saturate(dot(H, vDir));
					        float3 fresnel = F0 + (1.0 - F0) * pow(1.0 - hDotV, 5.0);
					        specAccum += _UdonSpecularLightCol[i].rgb * (spec * fresnel * nDotL * _UdonSpecularLightCol[i].w * falloff * spotMask);
					    }
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

					float2 texCoord2357_g59975 = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0A2420_g59975 = texCoord2357_g59975;
					#ifdef _MAINTEX
					float4 staticSwitch1549_g59975 = tex2D( _MainTex, UV0A2420_g59975 );
					#else
					float4 staticSwitch1549_g59975 = _Color;
					#endif
					float2 temp_output_5_0_g60010 = UV0A2420_g59975;
					float2 UV633_g60010 = temp_output_5_0_g60010;
					float2 UV100_g60011 = UV633_g60010;
					float2 temp_output_51_0_g60011 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60011 * float2( 3.464,3.464 ) ) );
					float2 break55_g60011 = frac( temp_output_51_0_g60011 );
					float temp_output_56_0_g60011 = ( ( 1.0 - break55_g60011.x ) - break55_g60011.y );
					float2 temp_output_52_0_g60011 = floor( temp_output_51_0_g60011 );
					float2 temp_output_125_0_g60011 = ( temp_output_52_0_g60011 + float2( 1,1 ) );
					float2 ifLocalVar87_g60011 = 0;
					if( temp_output_56_0_g60011 > 0.0 )
					ifLocalVar87_g60011 = temp_output_52_0_g60011;
					else if( temp_output_56_0_g60011 == 0.0 )
					ifLocalVar87_g60011 = temp_output_125_0_g60011;
					else if( temp_output_56_0_g60011 < 0.0 )
					ifLocalVar87_g60011 = temp_output_125_0_g60011;
					float3 temp_output_7_0_g60012 = frac( ( (ifLocalVar87_g60011).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60012 = dot( temp_output_7_0_g60012 , ( (temp_output_7_0_g60012).yzx + 33.33 ) );
					float3 temp_output_12_0_g60012 = ( temp_output_7_0_g60012 + dotResult8_g60012 );
					float2 temp_output_597_0_g60010 = ( UV100_g60011 + frac( ( ( (temp_output_12_0_g60012).xx + (temp_output_12_0_g60012).yz ) * (temp_output_12_0_g60012).zy ) ) );
					float2 DDX631_g60010 = ddx( temp_output_5_0_g60010 );
					float2 DDY632_g60010 = ddy( temp_output_5_0_g60010 );
					float temp_output_65_0_g60011 = ( 0.0 - temp_output_56_0_g60011 );
					float ifLocalVar59_g60011 = 0;
					if( temp_output_56_0_g60011 <= 0.0 )
					ifLocalVar59_g60011 = temp_output_65_0_g60011;
					else
					ifLocalVar59_g60011 = temp_output_56_0_g60011;
					float temp_output_597_30_g60010 = ifLocalVar59_g60011;
					float2 temp_output_90_0_g60011 = ( temp_output_52_0_g60011 + float2( 0,1 ) );
					float2 temp_output_123_0_g60011 = ( temp_output_52_0_g60011 + float2( 1,0 ) );
					float2 ifLocalVar88_g60011 = 0;
					if( temp_output_56_0_g60011 > 0.0 )
					ifLocalVar88_g60011 = temp_output_90_0_g60011;
					else if( temp_output_56_0_g60011 == 0.0 )
					ifLocalVar88_g60011 = temp_output_123_0_g60011;
					else if( temp_output_56_0_g60011 < 0.0 )
					ifLocalVar88_g60011 = temp_output_123_0_g60011;
					float3 temp_output_7_0_g60013 = frac( ( (ifLocalVar88_g60011).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60013 = dot( temp_output_7_0_g60013 , ( (temp_output_7_0_g60013).yzx + 33.33 ) );
					float3 temp_output_12_0_g60013 = ( temp_output_7_0_g60013 + dotResult8_g60013 );
					float2 temp_output_597_26_g60010 = ( UV100_g60011 + frac( ( ( (temp_output_12_0_g60013).xx + (temp_output_12_0_g60013).yz ) * (temp_output_12_0_g60013).zy ) ) );
					float temp_output_66_0_g60011 = ( 1.0 - break55_g60011.y );
					float ifLocalVar60_g60011 = 0;
					if( temp_output_56_0_g60011 <= 0.0 )
					ifLocalVar60_g60011 = temp_output_66_0_g60011;
					else
					ifLocalVar60_g60011 = break55_g60011.y;
					float temp_output_597_28_g60010 = ifLocalVar60_g60011;
					float2 ifLocalVar89_g60011 = 0;
					if( temp_output_56_0_g60011 > 0.0 )
					ifLocalVar89_g60011 = temp_output_123_0_g60011;
					else if( temp_output_56_0_g60011 == 0.0 )
					ifLocalVar89_g60011 = temp_output_90_0_g60011;
					else if( temp_output_56_0_g60011 < 0.0 )
					ifLocalVar89_g60011 = temp_output_90_0_g60011;
					float3 temp_output_7_0_g60014 = frac( ( (ifLocalVar89_g60011).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60014 = dot( temp_output_7_0_g60014 , ( (temp_output_7_0_g60014).yzx + 33.33 ) );
					float3 temp_output_12_0_g60014 = ( temp_output_7_0_g60014 + dotResult8_g60014 );
					float2 temp_output_597_27_g60010 = ( UV100_g60011 + frac( ( ( (temp_output_12_0_g60014).xx + (temp_output_12_0_g60014).yz ) * (temp_output_12_0_g60014).zy ) ) );
					float temp_output_67_0_g60011 = ( 1.0 - break55_g60011.x );
					float ifLocalVar61_g60011 = 0;
					if( temp_output_56_0_g60011 <= 0.0 )
					ifLocalVar61_g60011 = temp_output_67_0_g60011;
					else
					ifLocalVar61_g60011 = break55_g60011.x;
					float temp_output_597_29_g60010 = ifLocalVar61_g60011;
					float4 Output_2D293_g60010 = ( ( tex2D( _Sampler82966_g59975, temp_output_597_0_g60010, DDX631_g60010, DDY632_g60010 ) * temp_output_597_30_g60010 ) + ( tex2D( _Sampler82966_g59975, temp_output_597_26_g60010, DDX631_g60010, DDY632_g60010 ) * temp_output_597_28_g60010 ) + ( tex2D( _Sampler82966_g59975, temp_output_597_27_g60010, DDX631_g60010, DDY632_g60010 ) * temp_output_597_29_g60010 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g59975 = Output_2D293_g60010;
					#else
					float4 staticSwitch1001_g59975 = staticSwitch1549_g59975;
					#endif
					float3 temp_output_2532_0_g59975 = (staticSwitch1001_g59975).rgb;
					float3 oAlbedo6_g59975 = temp_output_2532_0_g59975;
					float Black1185_g59975 = 0.0;
					float3 temp_cast_0 = (Black1185_g59975).xxx;
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch1180_g59975 = temp_cast_0;
					#else
					float3 staticSwitch1180_g59975 = oAlbedo6_g59975;
					#endif
					
					#ifdef _METALLICMAP
					float staticSwitch846_g59975 = tex2D( _MetallicMap, UV0A2420_g59975 ).r;
					#else
					float staticSwitch846_g59975 = _Metallic;
					#endif
					float2 temp_output_5_0_g60005 = UV0A2420_g59975;
					float2 UV633_g60005 = temp_output_5_0_g60005;
					float2 UV100_g60006 = UV633_g60005;
					float2 temp_output_51_0_g60006 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60006 * float2( 3.464,3.464 ) ) );
					float2 break55_g60006 = frac( temp_output_51_0_g60006 );
					float temp_output_56_0_g60006 = ( ( 1.0 - break55_g60006.x ) - break55_g60006.y );
					float2 temp_output_52_0_g60006 = floor( temp_output_51_0_g60006 );
					float2 temp_output_125_0_g60006 = ( temp_output_52_0_g60006 + float2( 1,1 ) );
					float2 ifLocalVar87_g60006 = 0;
					if( temp_output_56_0_g60006 > 0.0 )
					ifLocalVar87_g60006 = temp_output_52_0_g60006;
					else if( temp_output_56_0_g60006 == 0.0 )
					ifLocalVar87_g60006 = temp_output_125_0_g60006;
					else if( temp_output_56_0_g60006 < 0.0 )
					ifLocalVar87_g60006 = temp_output_125_0_g60006;
					float3 temp_output_7_0_g60007 = frac( ( (ifLocalVar87_g60006).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60007 = dot( temp_output_7_0_g60007 , ( (temp_output_7_0_g60007).yzx + 33.33 ) );
					float3 temp_output_12_0_g60007 = ( temp_output_7_0_g60007 + dotResult8_g60007 );
					float2 temp_output_597_0_g60005 = ( UV100_g60006 + frac( ( ( (temp_output_12_0_g60007).xx + (temp_output_12_0_g60007).yz ) * (temp_output_12_0_g60007).zy ) ) );
					float2 DDX631_g60005 = ddx( temp_output_5_0_g60005 );
					float2 DDY632_g60005 = ddy( temp_output_5_0_g60005 );
					float temp_output_65_0_g60006 = ( 0.0 - temp_output_56_0_g60006 );
					float ifLocalVar59_g60006 = 0;
					if( temp_output_56_0_g60006 <= 0.0 )
					ifLocalVar59_g60006 = temp_output_65_0_g60006;
					else
					ifLocalVar59_g60006 = temp_output_56_0_g60006;
					float temp_output_597_30_g60005 = ifLocalVar59_g60006;
					float2 temp_output_90_0_g60006 = ( temp_output_52_0_g60006 + float2( 0,1 ) );
					float2 temp_output_123_0_g60006 = ( temp_output_52_0_g60006 + float2( 1,0 ) );
					float2 ifLocalVar88_g60006 = 0;
					if( temp_output_56_0_g60006 > 0.0 )
					ifLocalVar88_g60006 = temp_output_90_0_g60006;
					else if( temp_output_56_0_g60006 == 0.0 )
					ifLocalVar88_g60006 = temp_output_123_0_g60006;
					else if( temp_output_56_0_g60006 < 0.0 )
					ifLocalVar88_g60006 = temp_output_123_0_g60006;
					float3 temp_output_7_0_g60008 = frac( ( (ifLocalVar88_g60006).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60008 = dot( temp_output_7_0_g60008 , ( (temp_output_7_0_g60008).yzx + 33.33 ) );
					float3 temp_output_12_0_g60008 = ( temp_output_7_0_g60008 + dotResult8_g60008 );
					float2 temp_output_597_26_g60005 = ( UV100_g60006 + frac( ( ( (temp_output_12_0_g60008).xx + (temp_output_12_0_g60008).yz ) * (temp_output_12_0_g60008).zy ) ) );
					float temp_output_66_0_g60006 = ( 1.0 - break55_g60006.y );
					float ifLocalVar60_g60006 = 0;
					if( temp_output_56_0_g60006 <= 0.0 )
					ifLocalVar60_g60006 = temp_output_66_0_g60006;
					else
					ifLocalVar60_g60006 = break55_g60006.y;
					float temp_output_597_28_g60005 = ifLocalVar60_g60006;
					float2 ifLocalVar89_g60006 = 0;
					if( temp_output_56_0_g60006 > 0.0 )
					ifLocalVar89_g60006 = temp_output_123_0_g60006;
					else if( temp_output_56_0_g60006 == 0.0 )
					ifLocalVar89_g60006 = temp_output_90_0_g60006;
					else if( temp_output_56_0_g60006 < 0.0 )
					ifLocalVar89_g60006 = temp_output_90_0_g60006;
					float3 temp_output_7_0_g60009 = frac( ( (ifLocalVar89_g60006).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60009 = dot( temp_output_7_0_g60009 , ( (temp_output_7_0_g60009).yzx + 33.33 ) );
					float3 temp_output_12_0_g60009 = ( temp_output_7_0_g60009 + dotResult8_g60009 );
					float2 temp_output_597_27_g60005 = ( UV100_g60006 + frac( ( ( (temp_output_12_0_g60009).xx + (temp_output_12_0_g60009).yz ) * (temp_output_12_0_g60009).zy ) ) );
					float temp_output_67_0_g60006 = ( 1.0 - break55_g60006.x );
					float ifLocalVar61_g60006 = 0;
					if( temp_output_56_0_g60006 <= 0.0 )
					ifLocalVar61_g60006 = temp_output_67_0_g60006;
					else
					ifLocalVar61_g60006 = break55_g60006.x;
					float temp_output_597_29_g60005 = ifLocalVar61_g60006;
					float4 Output_2D293_g60005 = ( ( tex2D( _Sampler82967_g59975, temp_output_597_0_g60005, DDX631_g60005, DDY632_g60005 ) * temp_output_597_30_g60005 ) + ( tex2D( _Sampler82967_g59975, temp_output_597_26_g60005, DDX631_g60005, DDY632_g60005 ) * temp_output_597_28_g60005 ) + ( tex2D( _Sampler82967_g59975, temp_output_597_27_g60005, DDX631_g60005, DDY632_g60005 ) * temp_output_597_29_g60005 ) );
					float4 break31_g60005 = Output_2D293_g60005;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g59975 = break31_g60005.r;
					#else
					float staticSwitch1005_g59975 = staticSwitch846_g59975;
					#endif
					float Metallic1239_g59975 = staticSwitch1005_g59975;
					float3 aAlbedo1466_g59975 = ( temp_output_2532_0_g59975 * ( 1.0 - Metallic1239_g59975 ) );
					float White38_g59975 = 1.0;
					float4 temp_cast_1 = (White38_g59975).xxxx;
					float4 texCoord2426_g59975 = IN.ase_texcoord6;
					texCoord2426_g59975.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0B2361_g59975 = (texCoord2426_g59975).zw;
					float localBicubicPrepare2_g59989 = ( 0.0 );
					float2 Input_UV100_g59989 = UV0B2361_g59975;
					float2 UV2_g59989 = Input_UV100_g59989;
					float4 TexelSize2_g59989 = _Lightmap0_TexelSize;
					float2 UV02_g59989 = float2( 0,0 );
					float2 UV12_g59989 = float2( 0,0 );
					float2 UV22_g59989 = float2( 0,0 );
					float2 UV32_g59989 = float2( 0,0 );
					float W02_g59989 = 0;
					float W12_g59989 = 0;
					{
					{
					 UV2_g59989 = UV2_g59989 * TexelSize2_g59989.zw - 0.5;
					    float2 f = frac( UV2_g59989 );
					    UV2_g59989 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59989.x - 0.5, UV2_g59989.x + 1.5, UV2_g59989.y - 0.5, UV2_g59989.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59989.xyxy;
					    UV02_g59989 = off.xz;
					    UV12_g59989 = off.yz;
					    UV22_g59989 = off.xw;
					    UV32_g59989 = off.yw;
					    W02_g59989 = s.x / ( s.x + s.y );
					 W12_g59989 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59989 = lerp( tex2D( _Lightmap0, UV32_g59989 ) , tex2D( _Lightmap0, UV22_g59989 ) , W02_g59989);
					float4 lerpResult45_g59989 = lerp( tex2D( _Lightmap0, UV12_g59989 ) , tex2D( _Lightmap0, UV02_g59989 ) , W02_g59989);
					float4 lerpResult44_g59989 = lerp( lerpResult46_g59989 , lerpResult45_g59989 , W12_g59989);
					float4 Output_2D_Auto131_g59989 = lerpResult44_g59989;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g59975 = Output_2D_Auto131_g59989;
					#else
					float4 staticSwitch1092_g59975 = float4( tex2D( _Lightmap0, UV0B2361_g59975 ).rgb , 0.0 );
					#endif
					float4 Lightmap_0925_g59975 = staticSwitch1092_g59975;
					float localBicubicPrepare2_g59982 = ( 0.0 );
					float2 Input_UV100_g59982 = UV0B2361_g59975;
					float2 UV2_g59982 = Input_UV100_g59982;
					float4 TexelSize2_g59982 = _Lightmap1_TexelSize;
					float2 UV02_g59982 = float2( 0,0 );
					float2 UV12_g59982 = float2( 0,0 );
					float2 UV22_g59982 = float2( 0,0 );
					float2 UV32_g59982 = float2( 0,0 );
					float W02_g59982 = 0;
					float W12_g59982 = 0;
					{
					{
					 UV2_g59982 = UV2_g59982 * TexelSize2_g59982.zw - 0.5;
					    float2 f = frac( UV2_g59982 );
					    UV2_g59982 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59982.x - 0.5, UV2_g59982.x + 1.5, UV2_g59982.y - 0.5, UV2_g59982.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59982.xyxy;
					    UV02_g59982 = off.xz;
					    UV12_g59982 = off.yz;
					    UV22_g59982 = off.xw;
					    UV32_g59982 = off.yw;
					    W02_g59982 = s.x / ( s.x + s.y );
					 W12_g59982 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59982 = lerp( tex2D( _Lightmap1, UV32_g59982 ) , tex2D( _Lightmap1, UV22_g59982 ) , W02_g59982);
					float4 lerpResult45_g59982 = lerp( tex2D( _Lightmap1, UV12_g59982 ) , tex2D( _Lightmap1, UV02_g59982 ) , W02_g59982);
					float4 lerpResult44_g59982 = lerp( lerpResult46_g59982 , lerpResult45_g59982 , W12_g59982);
					float4 Output_2D_Auto131_g59982 = lerpResult44_g59982;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g59975 = Output_2D_Auto131_g59982;
					#else
					float4 staticSwitch1088_g59975 = tex2D( _Lightmap1, UV0B2361_g59975 );
					#endif
					float4 Lightmap_1956_g59975 = staticSwitch1088_g59975;
					float Lightmap_Lerp_Value969_g59975 = _UdonLightmapLerp;
					float4 lerpResult442_g59975 = lerp( Lightmap_0925_g59975 , Lightmap_1956_g59975 , Lightmap_Lerp_Value969_g59975);
					float4 Lightmap_Lerp932_g59975 = lerpResult442_g59975;
					float3 appendResult139_g59996 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float2 temp_output_5_0_g60000 = UV0A2420_g59975;
					float2 UV633_g60000 = temp_output_5_0_g60000;
					float2 UV100_g60001 = UV633_g60000;
					float2 temp_output_51_0_g60001 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60001 * float2( 3.464,3.464 ) ) );
					float2 break55_g60001 = frac( temp_output_51_0_g60001 );
					float temp_output_56_0_g60001 = ( ( 1.0 - break55_g60001.x ) - break55_g60001.y );
					float2 temp_output_52_0_g60001 = floor( temp_output_51_0_g60001 );
					float2 temp_output_125_0_g60001 = ( temp_output_52_0_g60001 + float2( 1,1 ) );
					float2 ifLocalVar87_g60001 = 0;
					if( temp_output_56_0_g60001 > 0.0 )
					ifLocalVar87_g60001 = temp_output_52_0_g60001;
					else if( temp_output_56_0_g60001 == 0.0 )
					ifLocalVar87_g60001 = temp_output_125_0_g60001;
					else if( temp_output_56_0_g60001 < 0.0 )
					ifLocalVar87_g60001 = temp_output_125_0_g60001;
					float3 temp_output_7_0_g60002 = frac( ( (ifLocalVar87_g60001).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60002 = dot( temp_output_7_0_g60002 , ( (temp_output_7_0_g60002).yzx + 33.33 ) );
					float3 temp_output_12_0_g60002 = ( temp_output_7_0_g60002 + dotResult8_g60002 );
					float2 temp_output_597_0_g60000 = ( UV100_g60001 + frac( ( ( (temp_output_12_0_g60002).xx + (temp_output_12_0_g60002).yz ) * (temp_output_12_0_g60002).zy ) ) );
					float2 DDX631_g60000 = ddx( temp_output_5_0_g60000 );
					float2 DDY632_g60000 = ddy( temp_output_5_0_g60000 );
					float Input_Scale617_g60000 = 1.5;
					float temp_output_65_0_g60001 = ( 0.0 - temp_output_56_0_g60001 );
					float ifLocalVar59_g60001 = 0;
					if( temp_output_56_0_g60001 <= 0.0 )
					ifLocalVar59_g60001 = temp_output_65_0_g60001;
					else
					ifLocalVar59_g60001 = temp_output_56_0_g60001;
					float temp_output_597_30_g60000 = ifLocalVar59_g60001;
					float2 temp_output_90_0_g60001 = ( temp_output_52_0_g60001 + float2( 0,1 ) );
					float2 temp_output_123_0_g60001 = ( temp_output_52_0_g60001 + float2( 1,0 ) );
					float2 ifLocalVar88_g60001 = 0;
					if( temp_output_56_0_g60001 > 0.0 )
					ifLocalVar88_g60001 = temp_output_90_0_g60001;
					else if( temp_output_56_0_g60001 == 0.0 )
					ifLocalVar88_g60001 = temp_output_123_0_g60001;
					else if( temp_output_56_0_g60001 < 0.0 )
					ifLocalVar88_g60001 = temp_output_123_0_g60001;
					float3 temp_output_7_0_g60003 = frac( ( (ifLocalVar88_g60001).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60003 = dot( temp_output_7_0_g60003 , ( (temp_output_7_0_g60003).yzx + 33.33 ) );
					float3 temp_output_12_0_g60003 = ( temp_output_7_0_g60003 + dotResult8_g60003 );
					float2 temp_output_597_26_g60000 = ( UV100_g60001 + frac( ( ( (temp_output_12_0_g60003).xx + (temp_output_12_0_g60003).yz ) * (temp_output_12_0_g60003).zy ) ) );
					float temp_output_66_0_g60001 = ( 1.0 - break55_g60001.y );
					float ifLocalVar60_g60001 = 0;
					if( temp_output_56_0_g60001 <= 0.0 )
					ifLocalVar60_g60001 = temp_output_66_0_g60001;
					else
					ifLocalVar60_g60001 = break55_g60001.y;
					float temp_output_597_28_g60000 = ifLocalVar60_g60001;
					float2 ifLocalVar89_g60001 = 0;
					if( temp_output_56_0_g60001 > 0.0 )
					ifLocalVar89_g60001 = temp_output_123_0_g60001;
					else if( temp_output_56_0_g60001 == 0.0 )
					ifLocalVar89_g60001 = temp_output_90_0_g60001;
					else if( temp_output_56_0_g60001 < 0.0 )
					ifLocalVar89_g60001 = temp_output_90_0_g60001;
					float3 temp_output_7_0_g60004 = frac( ( (ifLocalVar89_g60001).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60004 = dot( temp_output_7_0_g60004 , ( (temp_output_7_0_g60004).yzx + 33.33 ) );
					float3 temp_output_12_0_g60004 = ( temp_output_7_0_g60004 + dotResult8_g60004 );
					float2 temp_output_597_27_g60000 = ( UV100_g60001 + frac( ( ( (temp_output_12_0_g60004).xx + (temp_output_12_0_g60004).yz ) * (temp_output_12_0_g60004).zy ) ) );
					float temp_output_67_0_g60001 = ( 1.0 - break55_g60001.x );
					float ifLocalVar61_g60001 = 0;
					if( temp_output_56_0_g60001 <= 0.0 )
					ifLocalVar61_g60001 = temp_output_67_0_g60001;
					else
					ifLocalVar61_g60001 = break55_g60001.x;
					float temp_output_597_29_g60000 = ifLocalVar61_g60001;
					float3 Output_2D_Normal641_g60000 = ( ( UnpackScaleNormal( tex2D( _Sampler82965_g59975, temp_output_597_0_g60000, DDX631_g60000, DDY632_g60000 ), Input_Scale617_g60000 ) * temp_output_597_30_g60000 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g59975, temp_output_597_26_g60000, DDX631_g60000, DDY632_g60000 ), Input_Scale617_g60000 ) * temp_output_597_28_g60000 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g59975, temp_output_597_27_g60000, DDX631_g60000, DDY632_g60000 ), Input_Scale617_g60000 ) * float3( 0,0,0 ) * temp_output_597_29_g60000 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g59975 = Output_2D_Normal641_g60000;
					#else
					float3 staticSwitch1003_g59975 = UnpackScaleNormal( tex2D( _BumpMap, UV0A2420_g59975 ), 1.5 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g59975 = staticSwitch1003_g59975;
					#else
					float3 staticSwitch980_g59975 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g59975 = staticSwitch980_g59975;
					float3 normalizeResult326_g59996 = normalize( Normal_Map700_g59975 );
					float3 Normal_Map318_g59996 = normalizeResult326_g59996;
					float dotResult121_g59996 = dot( appendResult139_g59996 , Normal_Map318_g59996 );
					float temp_output_2_0_g59998 = saturate( dotResult121_g59996 );
					float localStochasticTiling2_g59984 = ( 0.0 );
					float2 UV2_g59984 = UV0B2361_g59975;
					float4 TexelSize2_g59984 = _UdonRNMX0_TexelSize;
					float4 Offsets2_g59984 = float4( 0,0,0,0 );
					float2 Weights2_g59984 = float2( 0,0 );
					{
					UV2_g59984 = UV2_g59984 * TexelSize2_g59984.zw - 0.5;
					float2 f = frac( UV2_g59984 );
					UV2_g59984 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g59984.x - 0.5, UV2_g59984.x + 1.5, UV2_g59984.y - 0.5, UV2_g59984.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g59984 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59984.xyxy;
					Weights2_g59984 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g59983 = Offsets2_g59984;
					float4 Input_FetchOffsets197_g59985 = temp_output_1_34_g59983;
					float2 temp_output_1_54_g59983 = Weights2_g59984;
					float2 Input_FetchWeights200_g59985 = temp_output_1_54_g59983;
					float2 break187_g59985 = Input_FetchWeights200_g59985;
					float4 lerpResult181_g59985 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g59985).yw ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g59985).xw ) , break187_g59985.x);
					float4 lerpResult182_g59985 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g59985).yz ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g59985).xz ) , break187_g59985.x);
					float4 lerpResult176_g59985 = lerp( lerpResult181_g59985 , lerpResult182_g59985 , break187_g59985.y);
					float4 Output_Fetch2D_Auto202_g59985 = lerpResult176_g59985;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g59975 = Output_Fetch2D_Auto202_g59985;
					#else
					float4 staticSwitch1061_g59975 = tex2D( _UdonRNMX0, UV0B2361_g59975 );
					#endif
					float3 appendResult146_g59996 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59996 = dot( appendResult146_g59996 , Normal_Map318_g59996 );
					float temp_output_2_0_g59997 = saturate( dotResult122_g59996 );
					float4 Input_FetchOffsets197_g59986 = temp_output_1_34_g59983;
					float2 Input_FetchWeights200_g59986 = temp_output_1_54_g59983;
					float2 break187_g59986 = Input_FetchWeights200_g59986;
					float4 lerpResult181_g59986 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g59986).yw ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g59986).xw ) , break187_g59986.x);
					float4 lerpResult182_g59986 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g59986).yz ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g59986).xz ) , break187_g59986.x);
					float4 lerpResult176_g59986 = lerp( lerpResult181_g59986 , lerpResult182_g59986 , break187_g59986.y);
					float4 Output_Fetch2D_Auto202_g59986 = lerpResult176_g59986;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g59975 = Output_Fetch2D_Auto202_g59986;
					#else
					float4 staticSwitch1062_g59975 = tex2D( _UdonRNMY0, UV0B2361_g59975 );
					#endif
					float3 appendResult149_g59996 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59996 = dot( appendResult149_g59996 , Normal_Map318_g59996 );
					float temp_output_2_0_g59999 = saturate( dotResult120_g59996 );
					float4 Input_FetchOffsets197_g59987 = temp_output_1_34_g59983;
					float2 Input_FetchWeights200_g59987 = temp_output_1_54_g59983;
					float2 break187_g59987 = Input_FetchWeights200_g59987;
					float4 lerpResult181_g59987 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g59987).yw ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g59987).xw ) , break187_g59987.x);
					float4 lerpResult182_g59987 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g59987).yz ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g59987).xz ) , break187_g59987.x);
					float4 lerpResult176_g59987 = lerp( lerpResult181_g59987 , lerpResult182_g59987 , break187_g59987.y);
					float4 Output_Fetch2D_Auto202_g59987 = lerpResult176_g59987;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g59975 = Output_Fetch2D_Auto202_g59987;
					#else
					float4 staticSwitch1063_g59975 = tex2D( _UdonRNMZ0, UV0B2361_g59975 );
					#endif
					float4 RNM_0926_g59975 = ( ( ( ( ( temp_output_2_0_g59998 * temp_output_2_0_g59998 ) * staticSwitch1061_g59975 ) + ( ( temp_output_2_0_g59997 * temp_output_2_0_g59997 ) * staticSwitch1062_g59975 ) ) + ( ( temp_output_2_0_g59999 * temp_output_2_0_g59999 ) * staticSwitch1063_g59975 ) ) * 1.5 );
					float3 appendResult139_g59992 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g59992 = normalize( Normal_Map700_g59975 );
					float3 Normal_Map318_g59992 = normalizeResult326_g59992;
					float dotResult121_g59992 = dot( appendResult139_g59992 , Normal_Map318_g59992 );
					float temp_output_2_0_g59994 = saturate( dotResult121_g59992 );
					float localStochasticTiling2_g59977 = ( 0.0 );
					float2 UV2_g59977 = UV0B2361_g59975;
					float4 TexelSize2_g59977 = _UdonRNMX1_TexelSize;
					float4 Offsets2_g59977 = float4( 0,0,0,0 );
					float2 Weights2_g59977 = float2( 0,0 );
					{
					UV2_g59977 = UV2_g59977 * TexelSize2_g59977.zw - 0.5;
					float2 f = frac( UV2_g59977 );
					UV2_g59977 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g59977.x - 0.5, UV2_g59977.x + 1.5, UV2_g59977.y - 0.5, UV2_g59977.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g59977 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59977.xyxy;
					Weights2_g59977 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g59976 = Offsets2_g59977;
					float4 Input_FetchOffsets197_g59978 = temp_output_1_34_g59976;
					float2 temp_output_1_54_g59976 = Weights2_g59977;
					float2 Input_FetchWeights200_g59978 = temp_output_1_54_g59976;
					float2 break187_g59978 = Input_FetchWeights200_g59978;
					float4 lerpResult181_g59978 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g59978).yw ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g59978).xw ) , break187_g59978.x);
					float4 lerpResult182_g59978 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g59978).yz ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g59978).xz ) , break187_g59978.x);
					float4 lerpResult176_g59978 = lerp( lerpResult181_g59978 , lerpResult182_g59978 , break187_g59978.y);
					float4 Output_Fetch2D_Auto202_g59978 = lerpResult176_g59978;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g59975 = Output_Fetch2D_Auto202_g59978;
					#else
					float4 staticSwitch1087_g59975 = tex2D( _UdonRNMX1, UV0B2361_g59975 );
					#endif
					float3 appendResult146_g59992 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59992 = dot( appendResult146_g59992 , Normal_Map318_g59992 );
					float temp_output_2_0_g59993 = saturate( dotResult122_g59992 );
					float4 Input_FetchOffsets197_g59979 = temp_output_1_34_g59976;
					float2 Input_FetchWeights200_g59979 = temp_output_1_54_g59976;
					float2 break187_g59979 = Input_FetchWeights200_g59979;
					float4 lerpResult181_g59979 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g59979).yw ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g59979).xw ) , break187_g59979.x);
					float4 lerpResult182_g59979 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g59979).yz ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g59979).xz ) , break187_g59979.x);
					float4 lerpResult176_g59979 = lerp( lerpResult181_g59979 , lerpResult182_g59979 , break187_g59979.y);
					float4 Output_Fetch2D_Auto202_g59979 = lerpResult176_g59979;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g59975 = Output_Fetch2D_Auto202_g59979;
					#else
					float4 staticSwitch1083_g59975 = tex2D( _UdonRNMY1, UV0B2361_g59975 );
					#endif
					float3 appendResult149_g59992 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59992 = dot( appendResult149_g59992 , Normal_Map318_g59992 );
					float temp_output_2_0_g59995 = saturate( dotResult120_g59992 );
					float4 Input_FetchOffsets197_g59980 = temp_output_1_34_g59976;
					float2 Input_FetchWeights200_g59980 = temp_output_1_54_g59976;
					float2 break187_g59980 = Input_FetchWeights200_g59980;
					float4 lerpResult181_g59980 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g59980).yw ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g59980).xw ) , break187_g59980.x);
					float4 lerpResult182_g59980 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g59980).yz ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g59980).xz ) , break187_g59980.x);
					float4 lerpResult176_g59980 = lerp( lerpResult181_g59980 , lerpResult182_g59980 , break187_g59980.y);
					float4 Output_Fetch2D_Auto202_g59980 = lerpResult176_g59980;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g59975 = Output_Fetch2D_Auto202_g59980;
					#else
					float4 staticSwitch1084_g59975 = tex2D( _UdonRNMZ1, UV0B2361_g59975 );
					#endif
					float4 RNM_11081_g59975 = ( ( ( ( ( temp_output_2_0_g59994 * temp_output_2_0_g59994 ) * staticSwitch1087_g59975 ) + ( ( temp_output_2_0_g59993 * temp_output_2_0_g59993 ) * staticSwitch1083_g59975 ) ) + ( ( temp_output_2_0_g59995 * temp_output_2_0_g59995 ) * staticSwitch1084_g59975 ) ) * 1.5 );
					float4 lerpResult953_g59975 = lerp( RNM_0926_g59975 , RNM_11081_g59975 , Lightmap_Lerp_Value969_g59975);
					float4 RNM_Lerp950_g59975 = lerpResult953_g59975;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g59975 = temp_cast_1;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g59975 = Lightmap_0925_g59975;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g59975 = Lightmap_Lerp932_g59975;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g59975 = RNM_0926_g59975;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g59975 = RNM_Lerp950_g59975;
					#else
					float4 staticSwitch1014_g59975 = temp_cast_1;
					#endif
					float3 Lightmap46_g59975 = (staticSwitch1014_g59975).rgb;
					float2 temp_output_5_0_g60021 = UV0A2420_g59975;
					float2 UV633_g60021 = temp_output_5_0_g60021;
					float2 UV100_g60022 = UV633_g60021;
					float2 temp_output_51_0_g60022 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60022 * float2( 3.464,3.464 ) ) );
					float2 break55_g60022 = frac( temp_output_51_0_g60022 );
					float temp_output_56_0_g60022 = ( ( 1.0 - break55_g60022.x ) - break55_g60022.y );
					float2 temp_output_52_0_g60022 = floor( temp_output_51_0_g60022 );
					float2 temp_output_125_0_g60022 = ( temp_output_52_0_g60022 + float2( 1,1 ) );
					float2 ifLocalVar87_g60022 = 0;
					if( temp_output_56_0_g60022 > 0.0 )
					ifLocalVar87_g60022 = temp_output_52_0_g60022;
					else if( temp_output_56_0_g60022 == 0.0 )
					ifLocalVar87_g60022 = temp_output_125_0_g60022;
					else if( temp_output_56_0_g60022 < 0.0 )
					ifLocalVar87_g60022 = temp_output_125_0_g60022;
					float3 temp_output_7_0_g60023 = frac( ( (ifLocalVar87_g60022).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60023 = dot( temp_output_7_0_g60023 , ( (temp_output_7_0_g60023).yzx + 33.33 ) );
					float3 temp_output_12_0_g60023 = ( temp_output_7_0_g60023 + dotResult8_g60023 );
					float2 temp_output_597_0_g60021 = ( UV100_g60022 + frac( ( ( (temp_output_12_0_g60023).xx + (temp_output_12_0_g60023).yz ) * (temp_output_12_0_g60023).zy ) ) );
					float2 DDX631_g60021 = ddx( temp_output_5_0_g60021 );
					float2 DDY632_g60021 = ddy( temp_output_5_0_g60021 );
					float temp_output_65_0_g60022 = ( 0.0 - temp_output_56_0_g60022 );
					float ifLocalVar59_g60022 = 0;
					if( temp_output_56_0_g60022 <= 0.0 )
					ifLocalVar59_g60022 = temp_output_65_0_g60022;
					else
					ifLocalVar59_g60022 = temp_output_56_0_g60022;
					float temp_output_597_30_g60021 = ifLocalVar59_g60022;
					float2 temp_output_90_0_g60022 = ( temp_output_52_0_g60022 + float2( 0,1 ) );
					float2 temp_output_123_0_g60022 = ( temp_output_52_0_g60022 + float2( 1,0 ) );
					float2 ifLocalVar88_g60022 = 0;
					if( temp_output_56_0_g60022 > 0.0 )
					ifLocalVar88_g60022 = temp_output_90_0_g60022;
					else if( temp_output_56_0_g60022 == 0.0 )
					ifLocalVar88_g60022 = temp_output_123_0_g60022;
					else if( temp_output_56_0_g60022 < 0.0 )
					ifLocalVar88_g60022 = temp_output_123_0_g60022;
					float3 temp_output_7_0_g60024 = frac( ( (ifLocalVar88_g60022).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60024 = dot( temp_output_7_0_g60024 , ( (temp_output_7_0_g60024).yzx + 33.33 ) );
					float3 temp_output_12_0_g60024 = ( temp_output_7_0_g60024 + dotResult8_g60024 );
					float2 temp_output_597_26_g60021 = ( UV100_g60022 + frac( ( ( (temp_output_12_0_g60024).xx + (temp_output_12_0_g60024).yz ) * (temp_output_12_0_g60024).zy ) ) );
					float temp_output_66_0_g60022 = ( 1.0 - break55_g60022.y );
					float ifLocalVar60_g60022 = 0;
					if( temp_output_56_0_g60022 <= 0.0 )
					ifLocalVar60_g60022 = temp_output_66_0_g60022;
					else
					ifLocalVar60_g60022 = break55_g60022.y;
					float temp_output_597_28_g60021 = ifLocalVar60_g60022;
					float2 ifLocalVar89_g60022 = 0;
					if( temp_output_56_0_g60022 > 0.0 )
					ifLocalVar89_g60022 = temp_output_123_0_g60022;
					else if( temp_output_56_0_g60022 == 0.0 )
					ifLocalVar89_g60022 = temp_output_90_0_g60022;
					else if( temp_output_56_0_g60022 < 0.0 )
					ifLocalVar89_g60022 = temp_output_90_0_g60022;
					float3 temp_output_7_0_g60025 = frac( ( (ifLocalVar89_g60022).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60025 = dot( temp_output_7_0_g60025 , ( (temp_output_7_0_g60025).yzx + 33.33 ) );
					float3 temp_output_12_0_g60025 = ( temp_output_7_0_g60025 + dotResult8_g60025 );
					float2 temp_output_597_27_g60021 = ( UV100_g60022 + frac( ( ( (temp_output_12_0_g60025).xx + (temp_output_12_0_g60025).yz ) * (temp_output_12_0_g60025).zy ) ) );
					float temp_output_67_0_g60022 = ( 1.0 - break55_g60022.x );
					float ifLocalVar61_g60022 = 0;
					if( temp_output_56_0_g60022 <= 0.0 )
					ifLocalVar61_g60022 = temp_output_67_0_g60022;
					else
					ifLocalVar61_g60022 = break55_g60022.x;
					float temp_output_597_29_g60021 = ifLocalVar61_g60022;
					float4 Output_2D293_g60021 = ( ( tex2D( _Sampler82968_g59975, temp_output_597_0_g60021, DDX631_g60021, DDY632_g60021 ) * temp_output_597_30_g60021 ) + ( tex2D( _Sampler82968_g59975, temp_output_597_26_g60021, DDX631_g60021, DDY632_g60021 ) * temp_output_597_28_g60021 ) + ( tex2D( _Sampler82968_g59975, temp_output_597_27_g60021, DDX631_g60021, DDY632_g60021 ) * temp_output_597_29_g60021 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g59975 = Output_2D293_g60021;
					#else
					float4 staticSwitch1006_g59975 = tex2D( _EmissionMap, UV0A2420_g59975 );
					#endif
					float3 temp_output_2531_0_g59975 = (( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g59975 * _EmissionIntensity )).rgb;
					float3 Emission86_g59975 = temp_output_2531_0_g59975;
					float3 temp_cast_4 = (Black1185_g59975).xxx;
					float3 temp_cast_5 = (Black1185_g59975).xxx;
					float3 World_Position2505_g59975 = PositionWS;
					float3 WorldPos1_g60026 = World_Position2505_g59975;
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal2504_g59975 = Normal_Map700_g59975;
					float3 worldNormal2504_g59975 = normalize( float3( dot( tanToWorld0, tanNormal2504_g59975 ), dot( tanToWorld1, tanNormal2504_g59975 ), dot( tanToWorld2, tanNormal2504_g59975 ) ) );
					float3 World_Normal2508_g59975 = worldNormal2504_g59975;
					float3 WorldNormal1_g60026 = World_Normal2508_g59975;
					float3 View_Direction2511_g59975 = ViewDirWS;
					float3 ViewDir1_g60026 = View_Direction2511_g59975;
					float3 temp_cast_6 = (0.04).xxx;
					float3 lerpResult1473_g59975 = lerp( temp_cast_6 , oAlbedo6_g59975 , Metallic1239_g59975);
					float3 switchResult1501_g59975 = (((ase_vface>0)?(World_Normal2508_g59975):(-World_Normal2508_g59975)));
					float dotResult1476_g59975 = dot( switchResult1501_g59975 , View_Direction2511_g59975 );
					float3 lerpResult1480_g59975 = lerp( lerpResult1473_g59975 , float3( 1,1,1 ) , pow( ( 1.0 - saturate( dotResult1476_g59975 ) ) , 5.0 ));
					float3 Fresnel1560_g59975 = lerpResult1480_g59975;
					float3 Fresnel1_g60026 = Fresnel1560_g59975;
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g59975 = tex2D( _GlossinessMap, UV0A2420_g59975 ).r;
					#else
					float staticSwitch845_g59975 = _Glossiness;
					#endif
					float2 temp_output_5_0_g60015 = UV0A2420_g59975;
					float2 UV633_g60015 = temp_output_5_0_g60015;
					float2 UV100_g60016 = UV633_g60015;
					float2 temp_output_51_0_g60016 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60016 * float2( 3.464,3.464 ) ) );
					float2 break55_g60016 = frac( temp_output_51_0_g60016 );
					float temp_output_56_0_g60016 = ( ( 1.0 - break55_g60016.x ) - break55_g60016.y );
					float2 temp_output_52_0_g60016 = floor( temp_output_51_0_g60016 );
					float2 temp_output_125_0_g60016 = ( temp_output_52_0_g60016 + float2( 1,1 ) );
					float2 ifLocalVar87_g60016 = 0;
					if( temp_output_56_0_g60016 > 0.0 )
					ifLocalVar87_g60016 = temp_output_52_0_g60016;
					else if( temp_output_56_0_g60016 == 0.0 )
					ifLocalVar87_g60016 = temp_output_125_0_g60016;
					else if( temp_output_56_0_g60016 < 0.0 )
					ifLocalVar87_g60016 = temp_output_125_0_g60016;
					float3 temp_output_7_0_g60017 = frac( ( (ifLocalVar87_g60016).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60017 = dot( temp_output_7_0_g60017 , ( (temp_output_7_0_g60017).yzx + 33.33 ) );
					float3 temp_output_12_0_g60017 = ( temp_output_7_0_g60017 + dotResult8_g60017 );
					float2 temp_output_597_0_g60015 = ( UV100_g60016 + frac( ( ( (temp_output_12_0_g60017).xx + (temp_output_12_0_g60017).yz ) * (temp_output_12_0_g60017).zy ) ) );
					float2 DDX631_g60015 = ddx( temp_output_5_0_g60015 );
					float2 DDY632_g60015 = ddy( temp_output_5_0_g60015 );
					float temp_output_65_0_g60016 = ( 0.0 - temp_output_56_0_g60016 );
					float ifLocalVar59_g60016 = 0;
					if( temp_output_56_0_g60016 <= 0.0 )
					ifLocalVar59_g60016 = temp_output_65_0_g60016;
					else
					ifLocalVar59_g60016 = temp_output_56_0_g60016;
					float temp_output_597_30_g60015 = ifLocalVar59_g60016;
					float2 temp_output_90_0_g60016 = ( temp_output_52_0_g60016 + float2( 0,1 ) );
					float2 temp_output_123_0_g60016 = ( temp_output_52_0_g60016 + float2( 1,0 ) );
					float2 ifLocalVar88_g60016 = 0;
					if( temp_output_56_0_g60016 > 0.0 )
					ifLocalVar88_g60016 = temp_output_90_0_g60016;
					else if( temp_output_56_0_g60016 == 0.0 )
					ifLocalVar88_g60016 = temp_output_123_0_g60016;
					else if( temp_output_56_0_g60016 < 0.0 )
					ifLocalVar88_g60016 = temp_output_123_0_g60016;
					float3 temp_output_7_0_g60018 = frac( ( (ifLocalVar88_g60016).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60018 = dot( temp_output_7_0_g60018 , ( (temp_output_7_0_g60018).yzx + 33.33 ) );
					float3 temp_output_12_0_g60018 = ( temp_output_7_0_g60018 + dotResult8_g60018 );
					float2 temp_output_597_26_g60015 = ( UV100_g60016 + frac( ( ( (temp_output_12_0_g60018).xx + (temp_output_12_0_g60018).yz ) * (temp_output_12_0_g60018).zy ) ) );
					float temp_output_66_0_g60016 = ( 1.0 - break55_g60016.y );
					float ifLocalVar60_g60016 = 0;
					if( temp_output_56_0_g60016 <= 0.0 )
					ifLocalVar60_g60016 = temp_output_66_0_g60016;
					else
					ifLocalVar60_g60016 = break55_g60016.y;
					float temp_output_597_28_g60015 = ifLocalVar60_g60016;
					float2 ifLocalVar89_g60016 = 0;
					if( temp_output_56_0_g60016 > 0.0 )
					ifLocalVar89_g60016 = temp_output_123_0_g60016;
					else if( temp_output_56_0_g60016 == 0.0 )
					ifLocalVar89_g60016 = temp_output_90_0_g60016;
					else if( temp_output_56_0_g60016 < 0.0 )
					ifLocalVar89_g60016 = temp_output_90_0_g60016;
					float3 temp_output_7_0_g60019 = frac( ( (ifLocalVar89_g60016).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60019 = dot( temp_output_7_0_g60019 , ( (temp_output_7_0_g60019).yzx + 33.33 ) );
					float3 temp_output_12_0_g60019 = ( temp_output_7_0_g60019 + dotResult8_g60019 );
					float2 temp_output_597_27_g60015 = ( UV100_g60016 + frac( ( ( (temp_output_12_0_g60019).xx + (temp_output_12_0_g60019).yz ) * (temp_output_12_0_g60019).zy ) ) );
					float temp_output_67_0_g60016 = ( 1.0 - break55_g60016.x );
					float ifLocalVar61_g60016 = 0;
					if( temp_output_56_0_g60016 <= 0.0 )
					ifLocalVar61_g60016 = temp_output_67_0_g60016;
					else
					ifLocalVar61_g60016 = break55_g60016.x;
					float temp_output_597_29_g60015 = ifLocalVar61_g60016;
					float4 Output_2D293_g60015 = ( ( tex2D( _Sampler82964_g59975, temp_output_597_0_g60015, DDX631_g60015, DDY632_g60015 ) * temp_output_597_30_g60015 ) + ( tex2D( _Sampler82964_g59975, temp_output_597_26_g60015, DDX631_g60015, DDY632_g60015 ) * temp_output_597_28_g60015 ) + ( tex2D( _Sampler82964_g59975, temp_output_597_27_g60015, DDX631_g60015, DDY632_g60015 ) * temp_output_597_29_g60015 ) );
					float4 break31_g60015 = Output_2D293_g60015;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g59975 = ( 1.0 - break31_g60015.r );
					#else
					float staticSwitch1004_g59975 = ( 1.0 - staticSwitch845_g59975 );
					#endif
					float temp_output_19_0_g60020 = staticSwitch1004_g59975;
					float3 tanNormal2_g60020 = World_Normal2508_g59975;
					float3 worldNormal2_g60020 = float3( dot( tanToWorld0, tanNormal2_g60020 ), dot( tanToWorld1, tanNormal2_g60020 ), dot( tanToWorld2, tanNormal2_g60020 ) );
					float3 temp_output_3_0_g60020 = ddx( worldNormal2_g60020 );
					float dotResult5_g60020 = dot( temp_output_3_0_g60020 , temp_output_3_0_g60020 );
					float3 temp_output_4_0_g60020 = ddy( worldNormal2_g60020 );
					float dotResult6_g60020 = dot( temp_output_4_0_g60020 , temp_output_4_0_g60020 );
					#ifdef _USEGEOMETRICAA_ON
					float staticSwitch15_g60020 = min( temp_output_19_0_g60020, ( 1.0 - pow( saturate( max( dotResult5_g60020, dotResult6_g60020 ) ) , 0.333 ) ) );
					#else
					float staticSwitch15_g60020 = temp_output_19_0_g60020;
					#endif
					float Smoothness1399_g59975 = staticSwitch15_g60020;
					float Smoothness1_g60026 = Smoothness1399_g59975;
					float3 localIndirectSpecularWithBoxProjection1_g60026 = IndirectSpecularWithBoxProjection1_g60026( WorldPos1_g60026 , WorldNormal1_g60026 , ViewDir1_g60026 , Fresnel1_g60026 , Smoothness1_g60026 );
					float3 lerpResult2658_g59975 = lerp( temp_cast_5 , localIndirectSpecularWithBoxProjection1_g60026 , Metallic1239_g59975);
					#ifdef _IsMetallic
					float3 staticSwitch2657_g59975 = lerpResult2658_g59975;
					#else
					float3 staticSwitch2657_g59975 = temp_cast_4;
					#endif
					float3 temp_cast_7 = (0.0).xxx;
					float3 temp_cast_8 = (0.1).xxx;
					float3 smoothstepResult2430_g59975 = smoothstep( temp_cast_7 , temp_cast_8 , Lightmap46_g59975);
					#ifdef _USELIGHTMAPPEDREFLECTIONS_ON
					float3 staticSwitch1469_g59975 = ( staticSwitch2657_g59975 * smoothstepResult2430_g59975 );
					#else
					float3 staticSwitch1469_g59975 = staticSwitch2657_g59975;
					#endif
					float3 Reflections1419_g59975 = staticSwitch1469_g59975;
					float3 AlbedoColor97_g60027 = oAlbedo6_g59975;
					float3 LightmapColor97_g60027 = Lightmap46_g59975;
					float Metallic97_g60027 = Metallic1239_g59975;
					float Smoothness97_g60027 = Smoothness1399_g59975;
					float3 Fresnel97_g60027 = Fresnel1560_g59975;
					float3 WorldPos97_g60027 = World_Position2505_g59975;
					float3 WorldNormal97_g60027 = World_Normal2508_g59975;
					float3 ViewDir97_g60027 = View_Direction2511_g59975;
					float3 localSpecular97_g60027 = Specular( AlbedoColor97_g60027 , LightmapColor97_g60027 , Metallic97_g60027 , Smoothness97_g60027 , Fresnel97_g60027 , WorldPos97_g60027 , WorldNormal97_g60027 , ViewDir97_g60027 );
					float3 Speculars2560_g59975 = localSpecular97_g60027;
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch1181_g59975 = Lightmap46_g59975;
					#else
					float3 staticSwitch1181_g59975 = ( ( aAlbedo1466_g59975 * Lightmap46_g59975 ) + Emission86_g59975 + Reflections1419_g59975 + Speculars2560_g59975 );
					#endif
					float3 temp_output_35_0_g59990 = staticSwitch1181_g59975;
					float3 Color353_g59990 = temp_output_35_0_g59990;
					#if defined( _LUTMODE_2D )
					float3 staticSwitch273_g59990 = saturate( temp_output_35_0_g59990 );
					#elif defined( _LUTMODE_3D )
					float3 staticSwitch273_g59990 = temp_output_35_0_g59990;
					#else
					float3 staticSwitch273_g59990 = temp_output_35_0_g59990;
					#endif
					float3 Color_Saturate49_g59990 = staticSwitch273_g59990;
					float Lut_Height213_g59990 = _LUTSize;
					float Lut_Width216_g59990 = ( _LUTSize * Lut_Height213_g59990 );
					float3 appendResult214_g59990 = (float3(( 1.0 / Lut_Width216_g59990 ) , ( 1.0 / Lut_Height213_g59990 ) , ( Lut_Height213_g59990 - 1.0 )));
					float3 Scale_Offset208_g59990 = appendResult214_g59990;
					float2 Scale_Factor292_g59990 = ( (Scale_Offset208_g59990).xy * (Scale_Offset208_g59990).z );
					float2 Offset299_g59990 = ( (Scale_Offset208_g59990).xy * 0.5 );
					float2 Adjusted_UV305_g59990 = ( ( (Color_Saturate49_g59990).xy * Scale_Factor292_g59990 ) + Offset299_g59990 );
					float Scaled_Blue280_g59990 = ( (Color_Saturate49_g59990).z * (Scale_Offset208_g59990).z );
					float Shift288_g59990 = floor( Scaled_Blue280_g59990 );
					float Final_X313_g59990 = ( (Adjusted_UV305_g59990).x + ( Shift288_g59990 * (Scale_Offset208_g59990).y ) );
					float2 appendResult326_g59990 = (float2(Final_X313_g59990 , (Adjusted_UV305_g59990).y));
					float2 Final_UV325_g59990 = appendResult326_g59990;
					float2 appendResult338_g59990 = (float2((Scale_Offset208_g59990).y , 0.0));
					float2 Offset_UV336_g59990 = ( Final_UV325_g59990 + appendResult338_g59990 );
					float3 lerpResult333_g59990 = lerp( tex2D( _2DLut, Final_UV325_g59990 ).rgb , tex2D( _2DLut, Offset_UV336_g59990 ).rgb , ( Scaled_Blue280_g59990 - Shift288_g59990 ));
					#ifdef _2DLUT
					float3 staticSwitch347_g59990 = lerpResult333_g59990;
					#else
					float3 staticSwitch347_g59990 = Color_Saturate49_g59990;
					#endif
					float3 TwoD_LUT346_g59990 = staticSwitch347_g59990;
					float3 RGB16_g59991 = ( ( log10( ( ( Color_Saturate49_g59990 * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 );
					#ifdef _3DLUT
					float3 staticSwitch194_g59990 = tex3D( _3DLut, RGB16_g59991 ).rgb;
					#else
					float3 staticSwitch194_g59990 = Color_Saturate49_g59990;
					#endif
					float3 ThreeD_LUT51_g59990 = staticSwitch194_g59990;
					#if defined( _LUTMODE_2D )
					float3 staticSwitch42_g59990 = TwoD_LUT346_g59990;
					#elif defined( _LUTMODE_3D )
					float3 staticSwitch42_g59990 = ThreeD_LUT51_g59990;
					#else
					float3 staticSwitch42_g59990 = ThreeD_LUT51_g59990;
					#endif
					#ifdef SHADER_API_MOBILE
					float3 staticSwitch41_g59990 = staticSwitch42_g59990;
					#else
					float3 staticSwitch41_g59990 = Color353_g59990;
					#endif
					
					#ifdef _LIGHTMAPDEBUG
					float staticSwitch1191_g59975 = White38_g59975;
					#else
					float staticSwitch1191_g59975 = staticSwitch1001_g59975.a;
					#endif
					

					o.Albedo = staticSwitch1180_g59975;
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

					o.Emission = staticSwitch41_g59990;
					o.Alpha = staticSwitch1191_g59975;
					half AlphaClipThreshold = _MaskClipValue;
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
				#define ASE_FRAGMENT_NORMAL 0
				#pragma multi_compile _ LOD_FADE_CROSSFADE
				#define ASE_FOG
				#define _SPECULARHIGHLIGHTS_OFF
				#pragma multi_compile_instancing
				#define _ALPHATEST_ON
				#define ASE_NO_AMBIENT 1
				#define ASE_LIGHTING_SIMPLE 1
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

				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#pragma shader_feature_fragment _LIGHTMAPDEBUG
				#pragma shader_feature_local_fragment _STOCHASTICENABLED_ON
				#pragma shader_feature_local_fragment _MAINTEX


				struct appdata
				{
					float4 vertex : POSITION;
					half3 normal : NORMAL;
					half4 tangent : TANGENT;
					float4 texcoord1 : TEXCOORD1;
					float4 texcoord2 : TEXCOORD2;
					float4 ase_texcoord : TEXCOORD0;
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
				sampler2D _Sampler82966_g59975;
				uniform float _MaskClipValue;


				
				v2f VertexFunction( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					o.ase_texcoord1 = v.ase_texcoord;

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
					float4 ase_texcoord : TEXCOORD0;

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
					o.ase_texcoord = v.ase_texcoord;
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
					o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
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

					float2 texCoord2357_g59975 = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0A2420_g59975 = texCoord2357_g59975;
					#ifdef _MAINTEX
					float4 staticSwitch1549_g59975 = tex2D( _MainTex, UV0A2420_g59975 );
					#else
					float4 staticSwitch1549_g59975 = _Color;
					#endif
					float2 temp_output_5_0_g60010 = UV0A2420_g59975;
					float2 UV633_g60010 = temp_output_5_0_g60010;
					float2 UV100_g60011 = UV633_g60010;
					float2 temp_output_51_0_g60011 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60011 * float2( 3.464,3.464 ) ) );
					float2 break55_g60011 = frac( temp_output_51_0_g60011 );
					float temp_output_56_0_g60011 = ( ( 1.0 - break55_g60011.x ) - break55_g60011.y );
					float2 temp_output_52_0_g60011 = floor( temp_output_51_0_g60011 );
					float2 temp_output_125_0_g60011 = ( temp_output_52_0_g60011 + float2( 1,1 ) );
					float2 ifLocalVar87_g60011 = 0;
					if( temp_output_56_0_g60011 > 0.0 )
					ifLocalVar87_g60011 = temp_output_52_0_g60011;
					else if( temp_output_56_0_g60011 == 0.0 )
					ifLocalVar87_g60011 = temp_output_125_0_g60011;
					else if( temp_output_56_0_g60011 < 0.0 )
					ifLocalVar87_g60011 = temp_output_125_0_g60011;
					float3 temp_output_7_0_g60012 = frac( ( (ifLocalVar87_g60011).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60012 = dot( temp_output_7_0_g60012 , ( (temp_output_7_0_g60012).yzx + 33.33 ) );
					float3 temp_output_12_0_g60012 = ( temp_output_7_0_g60012 + dotResult8_g60012 );
					float2 temp_output_597_0_g60010 = ( UV100_g60011 + frac( ( ( (temp_output_12_0_g60012).xx + (temp_output_12_0_g60012).yz ) * (temp_output_12_0_g60012).zy ) ) );
					float2 DDX631_g60010 = ddx( temp_output_5_0_g60010 );
					float2 DDY632_g60010 = ddy( temp_output_5_0_g60010 );
					float temp_output_65_0_g60011 = ( 0.0 - temp_output_56_0_g60011 );
					float ifLocalVar59_g60011 = 0;
					if( temp_output_56_0_g60011 <= 0.0 )
					ifLocalVar59_g60011 = temp_output_65_0_g60011;
					else
					ifLocalVar59_g60011 = temp_output_56_0_g60011;
					float temp_output_597_30_g60010 = ifLocalVar59_g60011;
					float2 temp_output_90_0_g60011 = ( temp_output_52_0_g60011 + float2( 0,1 ) );
					float2 temp_output_123_0_g60011 = ( temp_output_52_0_g60011 + float2( 1,0 ) );
					float2 ifLocalVar88_g60011 = 0;
					if( temp_output_56_0_g60011 > 0.0 )
					ifLocalVar88_g60011 = temp_output_90_0_g60011;
					else if( temp_output_56_0_g60011 == 0.0 )
					ifLocalVar88_g60011 = temp_output_123_0_g60011;
					else if( temp_output_56_0_g60011 < 0.0 )
					ifLocalVar88_g60011 = temp_output_123_0_g60011;
					float3 temp_output_7_0_g60013 = frac( ( (ifLocalVar88_g60011).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60013 = dot( temp_output_7_0_g60013 , ( (temp_output_7_0_g60013).yzx + 33.33 ) );
					float3 temp_output_12_0_g60013 = ( temp_output_7_0_g60013 + dotResult8_g60013 );
					float2 temp_output_597_26_g60010 = ( UV100_g60011 + frac( ( ( (temp_output_12_0_g60013).xx + (temp_output_12_0_g60013).yz ) * (temp_output_12_0_g60013).zy ) ) );
					float temp_output_66_0_g60011 = ( 1.0 - break55_g60011.y );
					float ifLocalVar60_g60011 = 0;
					if( temp_output_56_0_g60011 <= 0.0 )
					ifLocalVar60_g60011 = temp_output_66_0_g60011;
					else
					ifLocalVar60_g60011 = break55_g60011.y;
					float temp_output_597_28_g60010 = ifLocalVar60_g60011;
					float2 ifLocalVar89_g60011 = 0;
					if( temp_output_56_0_g60011 > 0.0 )
					ifLocalVar89_g60011 = temp_output_123_0_g60011;
					else if( temp_output_56_0_g60011 == 0.0 )
					ifLocalVar89_g60011 = temp_output_90_0_g60011;
					else if( temp_output_56_0_g60011 < 0.0 )
					ifLocalVar89_g60011 = temp_output_90_0_g60011;
					float3 temp_output_7_0_g60014 = frac( ( (ifLocalVar89_g60011).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60014 = dot( temp_output_7_0_g60014 , ( (temp_output_7_0_g60014).yzx + 33.33 ) );
					float3 temp_output_12_0_g60014 = ( temp_output_7_0_g60014 + dotResult8_g60014 );
					float2 temp_output_597_27_g60010 = ( UV100_g60011 + frac( ( ( (temp_output_12_0_g60014).xx + (temp_output_12_0_g60014).yz ) * (temp_output_12_0_g60014).zy ) ) );
					float temp_output_67_0_g60011 = ( 1.0 - break55_g60011.x );
					float ifLocalVar61_g60011 = 0;
					if( temp_output_56_0_g60011 <= 0.0 )
					ifLocalVar61_g60011 = temp_output_67_0_g60011;
					else
					ifLocalVar61_g60011 = break55_g60011.x;
					float temp_output_597_29_g60010 = ifLocalVar61_g60011;
					float4 Output_2D293_g60010 = ( ( tex2D( _Sampler82966_g59975, temp_output_597_0_g60010, DDX631_g60010, DDY632_g60010 ) * temp_output_597_30_g60010 ) + ( tex2D( _Sampler82966_g59975, temp_output_597_26_g60010, DDX631_g60010, DDY632_g60010 ) * temp_output_597_28_g60010 ) + ( tex2D( _Sampler82966_g59975, temp_output_597_27_g60010, DDX631_g60010, DDY632_g60010 ) * temp_output_597_29_g60010 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g59975 = Output_2D293_g60010;
					#else
					float4 staticSwitch1001_g59975 = staticSwitch1549_g59975;
					#endif
					float White38_g59975 = 1.0;
					#ifdef _LIGHTMAPDEBUG
					float staticSwitch1191_g59975 = White38_g59975;
					#else
					float staticSwitch1191_g59975 = staticSwitch1001_g59975.a;
					#endif
					

					o.Normal = half3( 0, 0, 1 );

					o.Alpha = staticSwitch1191_g59975;
					half AlphaClipThreshold = _MaskClipValue;
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
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2961;192,-1200;Inherit;False;Meenphie;0;;59975;b3ba55a08dd6b49c7be16c6f35cf2033;5,1008,1,2632,0,2619,0,2635,0,2636,0;0;5;FLOAT3;625;FLOAT3;624;FLOAT;156;FLOAT;427;FLOAT;1024
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2889;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;True;1;LightMode=ForwardAdd;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2890;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2891;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2892;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2893;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2894;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ScenePickingPass;0;7;ScenePickingPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=ScenePickingPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2888;512,-1200;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;5;Meenphie/Standard/Cutout;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardBase;0;1;ForwardBase;17;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;1;False;;True;3;False;;False;False;True;3;RenderType=TransparentCutout=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;44;Category;0;0;  Instanced Terrain Normals;1;0;Workflow;3;639057697570214470;Surface;0;638915427204303550;  Blend;2;638915425920684140;  Dither Shadows;1;0;Two Sided;0;639027460080664250;Alpha Clipping;1;638915427324710130;  Use Shadow Threshold;0;638915420933436960;Deferred Pass;0;638915425282396370;Normal Space;0;0;Transmission;0;638915425258747670;  Transmission Shadow;0.5,False,;0;Translucency;0;638915425246861880;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;1;638922399804812020;Receive Shadows;0;638922399717523500;Receive Specular;0;638915388784334560;Receive Reflections;1;638915388803555030;GPU Instancing;1;638915411619689990;LOD CrossFade;1;0;Built-in Fog;1;0;Ambient Light;0;639049545902984550;Meta Pass;0;639048817054746750;Add Pass;0;639048817051401800;Override Baked GI;0;638915390973737640;Write Depth;0;638915421117196140;Extra Pre Pass;0;639048817123696260;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;0;Vertex Position;1;0;0;8;False;True;False;False;False;True;False;False;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2887;512,-1440;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;True;True;0;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;True;True;1;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;0;False;;True;3;False;;True;False;0;False;;0;False;;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;0;False;0
WireConnection;2888;0;2961;625
WireConnection;2888;2;2961;624
WireConnection;2888;7;2961;156
WireConnection;2888;8;2961;427
ASEEND*/
//CHKSM=AB53FBEBD688B41CD3C6631858069BABD4D3BD01