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
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0
		[HideInInspector] GenKey__2DLut( "Assign keyword _2DLUT", Float ) = 1.0
		[HideInInspector] GenKey__MetallicMap( "Assign keyword _METALLICMAP", Float ) = 1.0
		[HideInInspector] GenKey__GlossinessMap( "Assign keyword _GLOSSINESSMAP", Float ) = 1.0
		[HideInInspector] GenKey__MainTex( "Assign keyword _MAINTEX", Float ) = 1.0
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
				#define ASE_NO_AMBIENT 1
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
				sampler2D _Sampler82966_g60177;
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				sampler2D _Sampler82967_g60177;
				uniform sampler2D _Lightmap0;
				float4 _Lightmap0_TexelSize;
				uniform sampler2D _Lightmap1;
				float4 _Lightmap1_TexelSize;
				uniform float _UdonLightmapLerp;
				uniform sampler2D _BumpMap;
				sampler2D _Sampler82965_g60177;
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
				sampler2D _Sampler82968_g60177;
				uniform float _EmissionIntensity;
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				sampler2D _Sampler82964_g60177;


				float3 IndirectSpecularWithBoxProjection1_g60228( float3 WorldPos, float3 WorldNormal, float3 ViewDir, float3 Fresnel, float Smoothness )
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

					float2 texCoord2357_g60177 = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0A2420_g60177 = texCoord2357_g60177;
					#ifdef _MAINTEX
					float4 staticSwitch1549_g60177 = tex2D( _MainTex, UV0A2420_g60177 );
					#else
					float4 staticSwitch1549_g60177 = _Color;
					#endif
					float2 temp_output_5_0_g60212 = UV0A2420_g60177;
					float2 UV633_g60212 = temp_output_5_0_g60212;
					float2 UV100_g60213 = UV633_g60212;
					float2 temp_output_51_0_g60213 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60213 * float2( 3.464,3.464 ) ) );
					float2 break55_g60213 = frac( temp_output_51_0_g60213 );
					float temp_output_56_0_g60213 = ( ( 1.0 - break55_g60213.x ) - break55_g60213.y );
					float2 temp_output_52_0_g60213 = floor( temp_output_51_0_g60213 );
					float2 temp_output_125_0_g60213 = ( temp_output_52_0_g60213 + float2( 1,1 ) );
					float2 ifLocalVar87_g60213 = 0;
					if( temp_output_56_0_g60213 > 0.0 )
					ifLocalVar87_g60213 = temp_output_52_0_g60213;
					else if( temp_output_56_0_g60213 == 0.0 )
					ifLocalVar87_g60213 = temp_output_125_0_g60213;
					else if( temp_output_56_0_g60213 < 0.0 )
					ifLocalVar87_g60213 = temp_output_125_0_g60213;
					float3 temp_output_7_0_g60214 = frac( ( (ifLocalVar87_g60213).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60214 = dot( temp_output_7_0_g60214 , ( (temp_output_7_0_g60214).yzx + 33.33 ) );
					float3 temp_output_12_0_g60214 = ( temp_output_7_0_g60214 + dotResult8_g60214 );
					float2 temp_output_597_0_g60212 = ( UV100_g60213 + frac( ( ( (temp_output_12_0_g60214).xx + (temp_output_12_0_g60214).yz ) * (temp_output_12_0_g60214).zy ) ) );
					float2 DDX631_g60212 = ddx( temp_output_5_0_g60212 );
					float2 DDY632_g60212 = ddy( temp_output_5_0_g60212 );
					float temp_output_65_0_g60213 = ( 0.0 - temp_output_56_0_g60213 );
					float ifLocalVar59_g60213 = 0;
					if( temp_output_56_0_g60213 <= 0.0 )
					ifLocalVar59_g60213 = temp_output_65_0_g60213;
					else
					ifLocalVar59_g60213 = temp_output_56_0_g60213;
					float temp_output_597_30_g60212 = ifLocalVar59_g60213;
					float2 temp_output_90_0_g60213 = ( temp_output_52_0_g60213 + float2( 0,1 ) );
					float2 temp_output_123_0_g60213 = ( temp_output_52_0_g60213 + float2( 1,0 ) );
					float2 ifLocalVar88_g60213 = 0;
					if( temp_output_56_0_g60213 > 0.0 )
					ifLocalVar88_g60213 = temp_output_90_0_g60213;
					else if( temp_output_56_0_g60213 == 0.0 )
					ifLocalVar88_g60213 = temp_output_123_0_g60213;
					else if( temp_output_56_0_g60213 < 0.0 )
					ifLocalVar88_g60213 = temp_output_123_0_g60213;
					float3 temp_output_7_0_g60215 = frac( ( (ifLocalVar88_g60213).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60215 = dot( temp_output_7_0_g60215 , ( (temp_output_7_0_g60215).yzx + 33.33 ) );
					float3 temp_output_12_0_g60215 = ( temp_output_7_0_g60215 + dotResult8_g60215 );
					float2 temp_output_597_26_g60212 = ( UV100_g60213 + frac( ( ( (temp_output_12_0_g60215).xx + (temp_output_12_0_g60215).yz ) * (temp_output_12_0_g60215).zy ) ) );
					float temp_output_66_0_g60213 = ( 1.0 - break55_g60213.y );
					float ifLocalVar60_g60213 = 0;
					if( temp_output_56_0_g60213 <= 0.0 )
					ifLocalVar60_g60213 = temp_output_66_0_g60213;
					else
					ifLocalVar60_g60213 = break55_g60213.y;
					float temp_output_597_28_g60212 = ifLocalVar60_g60213;
					float2 ifLocalVar89_g60213 = 0;
					if( temp_output_56_0_g60213 > 0.0 )
					ifLocalVar89_g60213 = temp_output_123_0_g60213;
					else if( temp_output_56_0_g60213 == 0.0 )
					ifLocalVar89_g60213 = temp_output_90_0_g60213;
					else if( temp_output_56_0_g60213 < 0.0 )
					ifLocalVar89_g60213 = temp_output_90_0_g60213;
					float3 temp_output_7_0_g60216 = frac( ( (ifLocalVar89_g60213).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60216 = dot( temp_output_7_0_g60216 , ( (temp_output_7_0_g60216).yzx + 33.33 ) );
					float3 temp_output_12_0_g60216 = ( temp_output_7_0_g60216 + dotResult8_g60216 );
					float2 temp_output_597_27_g60212 = ( UV100_g60213 + frac( ( ( (temp_output_12_0_g60216).xx + (temp_output_12_0_g60216).yz ) * (temp_output_12_0_g60216).zy ) ) );
					float temp_output_67_0_g60213 = ( 1.0 - break55_g60213.x );
					float ifLocalVar61_g60213 = 0;
					if( temp_output_56_0_g60213 <= 0.0 )
					ifLocalVar61_g60213 = temp_output_67_0_g60213;
					else
					ifLocalVar61_g60213 = break55_g60213.x;
					float temp_output_597_29_g60212 = ifLocalVar61_g60213;
					float4 Output_2D293_g60212 = ( ( tex2D( _Sampler82966_g60177, temp_output_597_0_g60212, DDX631_g60212, DDY632_g60212 ) * temp_output_597_30_g60212 ) + ( tex2D( _Sampler82966_g60177, temp_output_597_26_g60212, DDX631_g60212, DDY632_g60212 ) * temp_output_597_28_g60212 ) + ( tex2D( _Sampler82966_g60177, temp_output_597_27_g60212, DDX631_g60212, DDY632_g60212 ) * temp_output_597_29_g60212 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g60177 = Output_2D293_g60212;
					#else
					float4 staticSwitch1001_g60177 = staticSwitch1549_g60177;
					#endif
					float3 temp_output_2532_0_g60177 = (staticSwitch1001_g60177).rgb;
					float3 oAlbedo6_g60177 = temp_output_2532_0_g60177;
					float Black1185_g60177 = 0.0;
					float3 temp_cast_0 = (Black1185_g60177).xxx;
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch1180_g60177 = temp_cast_0;
					#else
					float3 staticSwitch1180_g60177 = oAlbedo6_g60177;
					#endif
					
					#ifdef _METALLICMAP
					float staticSwitch846_g60177 = tex2D( _MetallicMap, UV0A2420_g60177 ).r;
					#else
					float staticSwitch846_g60177 = _Metallic;
					#endif
					float2 temp_output_5_0_g60207 = UV0A2420_g60177;
					float2 UV633_g60207 = temp_output_5_0_g60207;
					float2 UV100_g60208 = UV633_g60207;
					float2 temp_output_51_0_g60208 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60208 * float2( 3.464,3.464 ) ) );
					float2 break55_g60208 = frac( temp_output_51_0_g60208 );
					float temp_output_56_0_g60208 = ( ( 1.0 - break55_g60208.x ) - break55_g60208.y );
					float2 temp_output_52_0_g60208 = floor( temp_output_51_0_g60208 );
					float2 temp_output_125_0_g60208 = ( temp_output_52_0_g60208 + float2( 1,1 ) );
					float2 ifLocalVar87_g60208 = 0;
					if( temp_output_56_0_g60208 > 0.0 )
					ifLocalVar87_g60208 = temp_output_52_0_g60208;
					else if( temp_output_56_0_g60208 == 0.0 )
					ifLocalVar87_g60208 = temp_output_125_0_g60208;
					else if( temp_output_56_0_g60208 < 0.0 )
					ifLocalVar87_g60208 = temp_output_125_0_g60208;
					float3 temp_output_7_0_g60209 = frac( ( (ifLocalVar87_g60208).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60209 = dot( temp_output_7_0_g60209 , ( (temp_output_7_0_g60209).yzx + 33.33 ) );
					float3 temp_output_12_0_g60209 = ( temp_output_7_0_g60209 + dotResult8_g60209 );
					float2 temp_output_597_0_g60207 = ( UV100_g60208 + frac( ( ( (temp_output_12_0_g60209).xx + (temp_output_12_0_g60209).yz ) * (temp_output_12_0_g60209).zy ) ) );
					float2 DDX631_g60207 = ddx( temp_output_5_0_g60207 );
					float2 DDY632_g60207 = ddy( temp_output_5_0_g60207 );
					float temp_output_65_0_g60208 = ( 0.0 - temp_output_56_0_g60208 );
					float ifLocalVar59_g60208 = 0;
					if( temp_output_56_0_g60208 <= 0.0 )
					ifLocalVar59_g60208 = temp_output_65_0_g60208;
					else
					ifLocalVar59_g60208 = temp_output_56_0_g60208;
					float temp_output_597_30_g60207 = ifLocalVar59_g60208;
					float2 temp_output_90_0_g60208 = ( temp_output_52_0_g60208 + float2( 0,1 ) );
					float2 temp_output_123_0_g60208 = ( temp_output_52_0_g60208 + float2( 1,0 ) );
					float2 ifLocalVar88_g60208 = 0;
					if( temp_output_56_0_g60208 > 0.0 )
					ifLocalVar88_g60208 = temp_output_90_0_g60208;
					else if( temp_output_56_0_g60208 == 0.0 )
					ifLocalVar88_g60208 = temp_output_123_0_g60208;
					else if( temp_output_56_0_g60208 < 0.0 )
					ifLocalVar88_g60208 = temp_output_123_0_g60208;
					float3 temp_output_7_0_g60210 = frac( ( (ifLocalVar88_g60208).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60210 = dot( temp_output_7_0_g60210 , ( (temp_output_7_0_g60210).yzx + 33.33 ) );
					float3 temp_output_12_0_g60210 = ( temp_output_7_0_g60210 + dotResult8_g60210 );
					float2 temp_output_597_26_g60207 = ( UV100_g60208 + frac( ( ( (temp_output_12_0_g60210).xx + (temp_output_12_0_g60210).yz ) * (temp_output_12_0_g60210).zy ) ) );
					float temp_output_66_0_g60208 = ( 1.0 - break55_g60208.y );
					float ifLocalVar60_g60208 = 0;
					if( temp_output_56_0_g60208 <= 0.0 )
					ifLocalVar60_g60208 = temp_output_66_0_g60208;
					else
					ifLocalVar60_g60208 = break55_g60208.y;
					float temp_output_597_28_g60207 = ifLocalVar60_g60208;
					float2 ifLocalVar89_g60208 = 0;
					if( temp_output_56_0_g60208 > 0.0 )
					ifLocalVar89_g60208 = temp_output_123_0_g60208;
					else if( temp_output_56_0_g60208 == 0.0 )
					ifLocalVar89_g60208 = temp_output_90_0_g60208;
					else if( temp_output_56_0_g60208 < 0.0 )
					ifLocalVar89_g60208 = temp_output_90_0_g60208;
					float3 temp_output_7_0_g60211 = frac( ( (ifLocalVar89_g60208).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60211 = dot( temp_output_7_0_g60211 , ( (temp_output_7_0_g60211).yzx + 33.33 ) );
					float3 temp_output_12_0_g60211 = ( temp_output_7_0_g60211 + dotResult8_g60211 );
					float2 temp_output_597_27_g60207 = ( UV100_g60208 + frac( ( ( (temp_output_12_0_g60211).xx + (temp_output_12_0_g60211).yz ) * (temp_output_12_0_g60211).zy ) ) );
					float temp_output_67_0_g60208 = ( 1.0 - break55_g60208.x );
					float ifLocalVar61_g60208 = 0;
					if( temp_output_56_0_g60208 <= 0.0 )
					ifLocalVar61_g60208 = temp_output_67_0_g60208;
					else
					ifLocalVar61_g60208 = break55_g60208.x;
					float temp_output_597_29_g60207 = ifLocalVar61_g60208;
					float4 Output_2D293_g60207 = ( ( tex2D( _Sampler82967_g60177, temp_output_597_0_g60207, DDX631_g60207, DDY632_g60207 ) * temp_output_597_30_g60207 ) + ( tex2D( _Sampler82967_g60177, temp_output_597_26_g60207, DDX631_g60207, DDY632_g60207 ) * temp_output_597_28_g60207 ) + ( tex2D( _Sampler82967_g60177, temp_output_597_27_g60207, DDX631_g60207, DDY632_g60207 ) * temp_output_597_29_g60207 ) );
					float4 break31_g60207 = Output_2D293_g60207;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g60177 = break31_g60207.r;
					#else
					float staticSwitch1005_g60177 = staticSwitch846_g60177;
					#endif
					float Metallic1239_g60177 = staticSwitch1005_g60177;
					float3 aAlbedo1466_g60177 = ( temp_output_2532_0_g60177 * ( 1.0 - Metallic1239_g60177 ) );
					float White38_g60177 = 1.0;
					float4 temp_cast_1 = (White38_g60177).xxxx;
					float4 texCoord2426_g60177 = IN.ase_texcoord6;
					texCoord2426_g60177.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0B2361_g60177 = (texCoord2426_g60177).zw;
					float localBicubicPrepare2_g60191 = ( 0.0 );
					float2 Input_UV100_g60191 = UV0B2361_g60177;
					float2 UV2_g60191 = Input_UV100_g60191;
					float4 TexelSize2_g60191 = _Lightmap0_TexelSize;
					float2 UV02_g60191 = float2( 0,0 );
					float2 UV12_g60191 = float2( 0,0 );
					float2 UV22_g60191 = float2( 0,0 );
					float2 UV32_g60191 = float2( 0,0 );
					float W02_g60191 = 0;
					float W12_g60191 = 0;
					{
					{
					 UV2_g60191 = UV2_g60191 * TexelSize2_g60191.zw - 0.5;
					    float2 f = frac( UV2_g60191 );
					    UV2_g60191 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g60191.x - 0.5, UV2_g60191.x + 1.5, UV2_g60191.y - 0.5, UV2_g60191.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60191.xyxy;
					    UV02_g60191 = off.xz;
					    UV12_g60191 = off.yz;
					    UV22_g60191 = off.xw;
					    UV32_g60191 = off.yw;
					    W02_g60191 = s.x / ( s.x + s.y );
					 W12_g60191 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g60191 = lerp( tex2D( _Lightmap0, UV32_g60191 ) , tex2D( _Lightmap0, UV22_g60191 ) , W02_g60191);
					float4 lerpResult45_g60191 = lerp( tex2D( _Lightmap0, UV12_g60191 ) , tex2D( _Lightmap0, UV02_g60191 ) , W02_g60191);
					float4 lerpResult44_g60191 = lerp( lerpResult46_g60191 , lerpResult45_g60191 , W12_g60191);
					float4 Output_2D_Auto131_g60191 = lerpResult44_g60191;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g60177 = Output_2D_Auto131_g60191;
					#else
					float4 staticSwitch1092_g60177 = float4( tex2D( _Lightmap0, UV0B2361_g60177 ).rgb , 0.0 );
					#endif
					float4 Lightmap_0925_g60177 = staticSwitch1092_g60177;
					float localBicubicPrepare2_g60184 = ( 0.0 );
					float2 Input_UV100_g60184 = UV0B2361_g60177;
					float2 UV2_g60184 = Input_UV100_g60184;
					float4 TexelSize2_g60184 = _Lightmap1_TexelSize;
					float2 UV02_g60184 = float2( 0,0 );
					float2 UV12_g60184 = float2( 0,0 );
					float2 UV22_g60184 = float2( 0,0 );
					float2 UV32_g60184 = float2( 0,0 );
					float W02_g60184 = 0;
					float W12_g60184 = 0;
					{
					{
					 UV2_g60184 = UV2_g60184 * TexelSize2_g60184.zw - 0.5;
					    float2 f = frac( UV2_g60184 );
					    UV2_g60184 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g60184.x - 0.5, UV2_g60184.x + 1.5, UV2_g60184.y - 0.5, UV2_g60184.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60184.xyxy;
					    UV02_g60184 = off.xz;
					    UV12_g60184 = off.yz;
					    UV22_g60184 = off.xw;
					    UV32_g60184 = off.yw;
					    W02_g60184 = s.x / ( s.x + s.y );
					 W12_g60184 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g60184 = lerp( tex2D( _Lightmap1, UV32_g60184 ) , tex2D( _Lightmap1, UV22_g60184 ) , W02_g60184);
					float4 lerpResult45_g60184 = lerp( tex2D( _Lightmap1, UV12_g60184 ) , tex2D( _Lightmap1, UV02_g60184 ) , W02_g60184);
					float4 lerpResult44_g60184 = lerp( lerpResult46_g60184 , lerpResult45_g60184 , W12_g60184);
					float4 Output_2D_Auto131_g60184 = lerpResult44_g60184;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g60177 = Output_2D_Auto131_g60184;
					#else
					float4 staticSwitch1088_g60177 = tex2D( _Lightmap1, UV0B2361_g60177 );
					#endif
					float4 Lightmap_1956_g60177 = staticSwitch1088_g60177;
					float Lightmap_Lerp_Value969_g60177 = _UdonLightmapLerp;
					float4 lerpResult442_g60177 = lerp( Lightmap_0925_g60177 , Lightmap_1956_g60177 , Lightmap_Lerp_Value969_g60177);
					float4 Lightmap_Lerp932_g60177 = lerpResult442_g60177;
					float3 appendResult139_g60198 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float2 temp_output_5_0_g60202 = UV0A2420_g60177;
					float2 UV633_g60202 = temp_output_5_0_g60202;
					float2 UV100_g60203 = UV633_g60202;
					float2 temp_output_51_0_g60203 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60203 * float2( 3.464,3.464 ) ) );
					float2 break55_g60203 = frac( temp_output_51_0_g60203 );
					float temp_output_56_0_g60203 = ( ( 1.0 - break55_g60203.x ) - break55_g60203.y );
					float2 temp_output_52_0_g60203 = floor( temp_output_51_0_g60203 );
					float2 temp_output_125_0_g60203 = ( temp_output_52_0_g60203 + float2( 1,1 ) );
					float2 ifLocalVar87_g60203 = 0;
					if( temp_output_56_0_g60203 > 0.0 )
					ifLocalVar87_g60203 = temp_output_52_0_g60203;
					else if( temp_output_56_0_g60203 == 0.0 )
					ifLocalVar87_g60203 = temp_output_125_0_g60203;
					else if( temp_output_56_0_g60203 < 0.0 )
					ifLocalVar87_g60203 = temp_output_125_0_g60203;
					float3 temp_output_7_0_g60204 = frac( ( (ifLocalVar87_g60203).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60204 = dot( temp_output_7_0_g60204 , ( (temp_output_7_0_g60204).yzx + 33.33 ) );
					float3 temp_output_12_0_g60204 = ( temp_output_7_0_g60204 + dotResult8_g60204 );
					float2 temp_output_597_0_g60202 = ( UV100_g60203 + frac( ( ( (temp_output_12_0_g60204).xx + (temp_output_12_0_g60204).yz ) * (temp_output_12_0_g60204).zy ) ) );
					float2 DDX631_g60202 = ddx( temp_output_5_0_g60202 );
					float2 DDY632_g60202 = ddy( temp_output_5_0_g60202 );
					float Input_Scale617_g60202 = 1.5;
					float temp_output_65_0_g60203 = ( 0.0 - temp_output_56_0_g60203 );
					float ifLocalVar59_g60203 = 0;
					if( temp_output_56_0_g60203 <= 0.0 )
					ifLocalVar59_g60203 = temp_output_65_0_g60203;
					else
					ifLocalVar59_g60203 = temp_output_56_0_g60203;
					float temp_output_597_30_g60202 = ifLocalVar59_g60203;
					float2 temp_output_90_0_g60203 = ( temp_output_52_0_g60203 + float2( 0,1 ) );
					float2 temp_output_123_0_g60203 = ( temp_output_52_0_g60203 + float2( 1,0 ) );
					float2 ifLocalVar88_g60203 = 0;
					if( temp_output_56_0_g60203 > 0.0 )
					ifLocalVar88_g60203 = temp_output_90_0_g60203;
					else if( temp_output_56_0_g60203 == 0.0 )
					ifLocalVar88_g60203 = temp_output_123_0_g60203;
					else if( temp_output_56_0_g60203 < 0.0 )
					ifLocalVar88_g60203 = temp_output_123_0_g60203;
					float3 temp_output_7_0_g60205 = frac( ( (ifLocalVar88_g60203).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60205 = dot( temp_output_7_0_g60205 , ( (temp_output_7_0_g60205).yzx + 33.33 ) );
					float3 temp_output_12_0_g60205 = ( temp_output_7_0_g60205 + dotResult8_g60205 );
					float2 temp_output_597_26_g60202 = ( UV100_g60203 + frac( ( ( (temp_output_12_0_g60205).xx + (temp_output_12_0_g60205).yz ) * (temp_output_12_0_g60205).zy ) ) );
					float temp_output_66_0_g60203 = ( 1.0 - break55_g60203.y );
					float ifLocalVar60_g60203 = 0;
					if( temp_output_56_0_g60203 <= 0.0 )
					ifLocalVar60_g60203 = temp_output_66_0_g60203;
					else
					ifLocalVar60_g60203 = break55_g60203.y;
					float temp_output_597_28_g60202 = ifLocalVar60_g60203;
					float2 ifLocalVar89_g60203 = 0;
					if( temp_output_56_0_g60203 > 0.0 )
					ifLocalVar89_g60203 = temp_output_123_0_g60203;
					else if( temp_output_56_0_g60203 == 0.0 )
					ifLocalVar89_g60203 = temp_output_90_0_g60203;
					else if( temp_output_56_0_g60203 < 0.0 )
					ifLocalVar89_g60203 = temp_output_90_0_g60203;
					float3 temp_output_7_0_g60206 = frac( ( (ifLocalVar89_g60203).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60206 = dot( temp_output_7_0_g60206 , ( (temp_output_7_0_g60206).yzx + 33.33 ) );
					float3 temp_output_12_0_g60206 = ( temp_output_7_0_g60206 + dotResult8_g60206 );
					float2 temp_output_597_27_g60202 = ( UV100_g60203 + frac( ( ( (temp_output_12_0_g60206).xx + (temp_output_12_0_g60206).yz ) * (temp_output_12_0_g60206).zy ) ) );
					float temp_output_67_0_g60203 = ( 1.0 - break55_g60203.x );
					float ifLocalVar61_g60203 = 0;
					if( temp_output_56_0_g60203 <= 0.0 )
					ifLocalVar61_g60203 = temp_output_67_0_g60203;
					else
					ifLocalVar61_g60203 = break55_g60203.x;
					float temp_output_597_29_g60202 = ifLocalVar61_g60203;
					float3 Output_2D_Normal641_g60202 = ( ( UnpackScaleNormal( tex2D( _Sampler82965_g60177, temp_output_597_0_g60202, DDX631_g60202, DDY632_g60202 ), Input_Scale617_g60202 ) * temp_output_597_30_g60202 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g60177, temp_output_597_26_g60202, DDX631_g60202, DDY632_g60202 ), Input_Scale617_g60202 ) * temp_output_597_28_g60202 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g60177, temp_output_597_27_g60202, DDX631_g60202, DDY632_g60202 ), Input_Scale617_g60202 ) * float3( 0,0,0 ) * temp_output_597_29_g60202 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g60177 = Output_2D_Normal641_g60202;
					#else
					float3 staticSwitch1003_g60177 = UnpackScaleNormal( tex2D( _BumpMap, UV0A2420_g60177 ), 1.5 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g60177 = staticSwitch1003_g60177;
					#else
					float3 staticSwitch980_g60177 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g60177 = staticSwitch980_g60177;
					float3 normalizeResult326_g60198 = normalize( Normal_Map700_g60177 );
					float3 Normal_Map318_g60198 = normalizeResult326_g60198;
					float dotResult121_g60198 = dot( appendResult139_g60198 , Normal_Map318_g60198 );
					float temp_output_2_0_g60200 = saturate( dotResult121_g60198 );
					float localStochasticTiling2_g60186 = ( 0.0 );
					float2 UV2_g60186 = UV0B2361_g60177;
					float4 TexelSize2_g60186 = _UdonRNMX0_TexelSize;
					float4 Offsets2_g60186 = float4( 0,0,0,0 );
					float2 Weights2_g60186 = float2( 0,0 );
					{
					UV2_g60186 = UV2_g60186 * TexelSize2_g60186.zw - 0.5;
					float2 f = frac( UV2_g60186 );
					UV2_g60186 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g60186.x - 0.5, UV2_g60186.x + 1.5, UV2_g60186.y - 0.5, UV2_g60186.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g60186 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60186.xyxy;
					Weights2_g60186 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g60185 = Offsets2_g60186;
					float4 Input_FetchOffsets197_g60187 = temp_output_1_34_g60185;
					float2 temp_output_1_54_g60185 = Weights2_g60186;
					float2 Input_FetchWeights200_g60187 = temp_output_1_54_g60185;
					float2 break187_g60187 = Input_FetchWeights200_g60187;
					float4 lerpResult181_g60187 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60187).yw ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60187).xw ) , break187_g60187.x);
					float4 lerpResult182_g60187 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60187).yz ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60187).xz ) , break187_g60187.x);
					float4 lerpResult176_g60187 = lerp( lerpResult181_g60187 , lerpResult182_g60187 , break187_g60187.y);
					float4 Output_Fetch2D_Auto202_g60187 = lerpResult176_g60187;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g60177 = Output_Fetch2D_Auto202_g60187;
					#else
					float4 staticSwitch1061_g60177 = tex2D( _UdonRNMX0, UV0B2361_g60177 );
					#endif
					float3 appendResult146_g60198 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g60198 = dot( appendResult146_g60198 , Normal_Map318_g60198 );
					float temp_output_2_0_g60199 = saturate( dotResult122_g60198 );
					float4 Input_FetchOffsets197_g60188 = temp_output_1_34_g60185;
					float2 Input_FetchWeights200_g60188 = temp_output_1_54_g60185;
					float2 break187_g60188 = Input_FetchWeights200_g60188;
					float4 lerpResult181_g60188 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60188).yw ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60188).xw ) , break187_g60188.x);
					float4 lerpResult182_g60188 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60188).yz ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60188).xz ) , break187_g60188.x);
					float4 lerpResult176_g60188 = lerp( lerpResult181_g60188 , lerpResult182_g60188 , break187_g60188.y);
					float4 Output_Fetch2D_Auto202_g60188 = lerpResult176_g60188;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g60177 = Output_Fetch2D_Auto202_g60188;
					#else
					float4 staticSwitch1062_g60177 = tex2D( _UdonRNMY0, UV0B2361_g60177 );
					#endif
					float3 appendResult149_g60198 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g60198 = dot( appendResult149_g60198 , Normal_Map318_g60198 );
					float temp_output_2_0_g60201 = saturate( dotResult120_g60198 );
					float4 Input_FetchOffsets197_g60189 = temp_output_1_34_g60185;
					float2 Input_FetchWeights200_g60189 = temp_output_1_54_g60185;
					float2 break187_g60189 = Input_FetchWeights200_g60189;
					float4 lerpResult181_g60189 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60189).yw ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60189).xw ) , break187_g60189.x);
					float4 lerpResult182_g60189 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60189).yz ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60189).xz ) , break187_g60189.x);
					float4 lerpResult176_g60189 = lerp( lerpResult181_g60189 , lerpResult182_g60189 , break187_g60189.y);
					float4 Output_Fetch2D_Auto202_g60189 = lerpResult176_g60189;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g60177 = Output_Fetch2D_Auto202_g60189;
					#else
					float4 staticSwitch1063_g60177 = tex2D( _UdonRNMZ0, UV0B2361_g60177 );
					#endif
					float4 RNM_0926_g60177 = ( ( ( ( ( temp_output_2_0_g60200 * temp_output_2_0_g60200 ) * staticSwitch1061_g60177 ) + ( ( temp_output_2_0_g60199 * temp_output_2_0_g60199 ) * staticSwitch1062_g60177 ) ) + ( ( temp_output_2_0_g60201 * temp_output_2_0_g60201 ) * staticSwitch1063_g60177 ) ) * 1.5 );
					float3 appendResult139_g60194 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g60194 = normalize( Normal_Map700_g60177 );
					float3 Normal_Map318_g60194 = normalizeResult326_g60194;
					float dotResult121_g60194 = dot( appendResult139_g60194 , Normal_Map318_g60194 );
					float temp_output_2_0_g60196 = saturate( dotResult121_g60194 );
					float localStochasticTiling2_g60179 = ( 0.0 );
					float2 UV2_g60179 = UV0B2361_g60177;
					float4 TexelSize2_g60179 = _UdonRNMX1_TexelSize;
					float4 Offsets2_g60179 = float4( 0,0,0,0 );
					float2 Weights2_g60179 = float2( 0,0 );
					{
					UV2_g60179 = UV2_g60179 * TexelSize2_g60179.zw - 0.5;
					float2 f = frac( UV2_g60179 );
					UV2_g60179 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g60179.x - 0.5, UV2_g60179.x + 1.5, UV2_g60179.y - 0.5, UV2_g60179.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g60179 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60179.xyxy;
					Weights2_g60179 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g60178 = Offsets2_g60179;
					float4 Input_FetchOffsets197_g60180 = temp_output_1_34_g60178;
					float2 temp_output_1_54_g60178 = Weights2_g60179;
					float2 Input_FetchWeights200_g60180 = temp_output_1_54_g60178;
					float2 break187_g60180 = Input_FetchWeights200_g60180;
					float4 lerpResult181_g60180 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60180).yw ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60180).xw ) , break187_g60180.x);
					float4 lerpResult182_g60180 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60180).yz ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60180).xz ) , break187_g60180.x);
					float4 lerpResult176_g60180 = lerp( lerpResult181_g60180 , lerpResult182_g60180 , break187_g60180.y);
					float4 Output_Fetch2D_Auto202_g60180 = lerpResult176_g60180;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g60177 = Output_Fetch2D_Auto202_g60180;
					#else
					float4 staticSwitch1087_g60177 = tex2D( _UdonRNMX1, UV0B2361_g60177 );
					#endif
					float3 appendResult146_g60194 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g60194 = dot( appendResult146_g60194 , Normal_Map318_g60194 );
					float temp_output_2_0_g60195 = saturate( dotResult122_g60194 );
					float4 Input_FetchOffsets197_g60181 = temp_output_1_34_g60178;
					float2 Input_FetchWeights200_g60181 = temp_output_1_54_g60178;
					float2 break187_g60181 = Input_FetchWeights200_g60181;
					float4 lerpResult181_g60181 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60181).yw ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60181).xw ) , break187_g60181.x);
					float4 lerpResult182_g60181 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60181).yz ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60181).xz ) , break187_g60181.x);
					float4 lerpResult176_g60181 = lerp( lerpResult181_g60181 , lerpResult182_g60181 , break187_g60181.y);
					float4 Output_Fetch2D_Auto202_g60181 = lerpResult176_g60181;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g60177 = Output_Fetch2D_Auto202_g60181;
					#else
					float4 staticSwitch1083_g60177 = tex2D( _UdonRNMY1, UV0B2361_g60177 );
					#endif
					float3 appendResult149_g60194 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g60194 = dot( appendResult149_g60194 , Normal_Map318_g60194 );
					float temp_output_2_0_g60197 = saturate( dotResult120_g60194 );
					float4 Input_FetchOffsets197_g60182 = temp_output_1_34_g60178;
					float2 Input_FetchWeights200_g60182 = temp_output_1_54_g60178;
					float2 break187_g60182 = Input_FetchWeights200_g60182;
					float4 lerpResult181_g60182 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60182).yw ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60182).xw ) , break187_g60182.x);
					float4 lerpResult182_g60182 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60182).yz ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60182).xz ) , break187_g60182.x);
					float4 lerpResult176_g60182 = lerp( lerpResult181_g60182 , lerpResult182_g60182 , break187_g60182.y);
					float4 Output_Fetch2D_Auto202_g60182 = lerpResult176_g60182;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g60177 = Output_Fetch2D_Auto202_g60182;
					#else
					float4 staticSwitch1084_g60177 = tex2D( _UdonRNMZ1, UV0B2361_g60177 );
					#endif
					float4 RNM_11081_g60177 = ( ( ( ( ( temp_output_2_0_g60196 * temp_output_2_0_g60196 ) * staticSwitch1087_g60177 ) + ( ( temp_output_2_0_g60195 * temp_output_2_0_g60195 ) * staticSwitch1083_g60177 ) ) + ( ( temp_output_2_0_g60197 * temp_output_2_0_g60197 ) * staticSwitch1084_g60177 ) ) * 1.5 );
					float4 lerpResult953_g60177 = lerp( RNM_0926_g60177 , RNM_11081_g60177 , Lightmap_Lerp_Value969_g60177);
					float4 RNM_Lerp950_g60177 = lerpResult953_g60177;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g60177 = temp_cast_1;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g60177 = Lightmap_0925_g60177;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g60177 = Lightmap_Lerp932_g60177;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g60177 = RNM_0926_g60177;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g60177 = RNM_Lerp950_g60177;
					#else
					float4 staticSwitch1014_g60177 = temp_cast_1;
					#endif
					float3 Lightmap46_g60177 = (staticSwitch1014_g60177).rgb;
					float2 temp_output_5_0_g60223 = UV0A2420_g60177;
					float2 UV633_g60223 = temp_output_5_0_g60223;
					float2 UV100_g60224 = UV633_g60223;
					float2 temp_output_51_0_g60224 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60224 * float2( 3.464,3.464 ) ) );
					float2 break55_g60224 = frac( temp_output_51_0_g60224 );
					float temp_output_56_0_g60224 = ( ( 1.0 - break55_g60224.x ) - break55_g60224.y );
					float2 temp_output_52_0_g60224 = floor( temp_output_51_0_g60224 );
					float2 temp_output_125_0_g60224 = ( temp_output_52_0_g60224 + float2( 1,1 ) );
					float2 ifLocalVar87_g60224 = 0;
					if( temp_output_56_0_g60224 > 0.0 )
					ifLocalVar87_g60224 = temp_output_52_0_g60224;
					else if( temp_output_56_0_g60224 == 0.0 )
					ifLocalVar87_g60224 = temp_output_125_0_g60224;
					else if( temp_output_56_0_g60224 < 0.0 )
					ifLocalVar87_g60224 = temp_output_125_0_g60224;
					float3 temp_output_7_0_g60225 = frac( ( (ifLocalVar87_g60224).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60225 = dot( temp_output_7_0_g60225 , ( (temp_output_7_0_g60225).yzx + 33.33 ) );
					float3 temp_output_12_0_g60225 = ( temp_output_7_0_g60225 + dotResult8_g60225 );
					float2 temp_output_597_0_g60223 = ( UV100_g60224 + frac( ( ( (temp_output_12_0_g60225).xx + (temp_output_12_0_g60225).yz ) * (temp_output_12_0_g60225).zy ) ) );
					float2 DDX631_g60223 = ddx( temp_output_5_0_g60223 );
					float2 DDY632_g60223 = ddy( temp_output_5_0_g60223 );
					float temp_output_65_0_g60224 = ( 0.0 - temp_output_56_0_g60224 );
					float ifLocalVar59_g60224 = 0;
					if( temp_output_56_0_g60224 <= 0.0 )
					ifLocalVar59_g60224 = temp_output_65_0_g60224;
					else
					ifLocalVar59_g60224 = temp_output_56_0_g60224;
					float temp_output_597_30_g60223 = ifLocalVar59_g60224;
					float2 temp_output_90_0_g60224 = ( temp_output_52_0_g60224 + float2( 0,1 ) );
					float2 temp_output_123_0_g60224 = ( temp_output_52_0_g60224 + float2( 1,0 ) );
					float2 ifLocalVar88_g60224 = 0;
					if( temp_output_56_0_g60224 > 0.0 )
					ifLocalVar88_g60224 = temp_output_90_0_g60224;
					else if( temp_output_56_0_g60224 == 0.0 )
					ifLocalVar88_g60224 = temp_output_123_0_g60224;
					else if( temp_output_56_0_g60224 < 0.0 )
					ifLocalVar88_g60224 = temp_output_123_0_g60224;
					float3 temp_output_7_0_g60226 = frac( ( (ifLocalVar88_g60224).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60226 = dot( temp_output_7_0_g60226 , ( (temp_output_7_0_g60226).yzx + 33.33 ) );
					float3 temp_output_12_0_g60226 = ( temp_output_7_0_g60226 + dotResult8_g60226 );
					float2 temp_output_597_26_g60223 = ( UV100_g60224 + frac( ( ( (temp_output_12_0_g60226).xx + (temp_output_12_0_g60226).yz ) * (temp_output_12_0_g60226).zy ) ) );
					float temp_output_66_0_g60224 = ( 1.0 - break55_g60224.y );
					float ifLocalVar60_g60224 = 0;
					if( temp_output_56_0_g60224 <= 0.0 )
					ifLocalVar60_g60224 = temp_output_66_0_g60224;
					else
					ifLocalVar60_g60224 = break55_g60224.y;
					float temp_output_597_28_g60223 = ifLocalVar60_g60224;
					float2 ifLocalVar89_g60224 = 0;
					if( temp_output_56_0_g60224 > 0.0 )
					ifLocalVar89_g60224 = temp_output_123_0_g60224;
					else if( temp_output_56_0_g60224 == 0.0 )
					ifLocalVar89_g60224 = temp_output_90_0_g60224;
					else if( temp_output_56_0_g60224 < 0.0 )
					ifLocalVar89_g60224 = temp_output_90_0_g60224;
					float3 temp_output_7_0_g60227 = frac( ( (ifLocalVar89_g60224).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60227 = dot( temp_output_7_0_g60227 , ( (temp_output_7_0_g60227).yzx + 33.33 ) );
					float3 temp_output_12_0_g60227 = ( temp_output_7_0_g60227 + dotResult8_g60227 );
					float2 temp_output_597_27_g60223 = ( UV100_g60224 + frac( ( ( (temp_output_12_0_g60227).xx + (temp_output_12_0_g60227).yz ) * (temp_output_12_0_g60227).zy ) ) );
					float temp_output_67_0_g60224 = ( 1.0 - break55_g60224.x );
					float ifLocalVar61_g60224 = 0;
					if( temp_output_56_0_g60224 <= 0.0 )
					ifLocalVar61_g60224 = temp_output_67_0_g60224;
					else
					ifLocalVar61_g60224 = break55_g60224.x;
					float temp_output_597_29_g60223 = ifLocalVar61_g60224;
					float4 Output_2D293_g60223 = ( ( tex2D( _Sampler82968_g60177, temp_output_597_0_g60223, DDX631_g60223, DDY632_g60223 ) * temp_output_597_30_g60223 ) + ( tex2D( _Sampler82968_g60177, temp_output_597_26_g60223, DDX631_g60223, DDY632_g60223 ) * temp_output_597_28_g60223 ) + ( tex2D( _Sampler82968_g60177, temp_output_597_27_g60223, DDX631_g60223, DDY632_g60223 ) * temp_output_597_29_g60223 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g60177 = Output_2D293_g60223;
					#else
					float4 staticSwitch1006_g60177 = tex2D( _EmissionMap, UV0A2420_g60177 );
					#endif
					float3 temp_output_2531_0_g60177 = (( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g60177 * _EmissionIntensity )).rgb;
					float3 Emission86_g60177 = temp_output_2531_0_g60177;
					float3 temp_cast_4 = (Black1185_g60177).xxx;
					float3 temp_cast_5 = (Black1185_g60177).xxx;
					float3 World_Position2505_g60177 = PositionWS;
					float3 WorldPos1_g60228 = World_Position2505_g60177;
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal2504_g60177 = Normal_Map700_g60177;
					float3 worldNormal2504_g60177 = normalize( float3( dot( tanToWorld0, tanNormal2504_g60177 ), dot( tanToWorld1, tanNormal2504_g60177 ), dot( tanToWorld2, tanNormal2504_g60177 ) ) );
					float3 World_Normal2508_g60177 = worldNormal2504_g60177;
					float3 WorldNormal1_g60228 = World_Normal2508_g60177;
					float3 View_Direction2511_g60177 = ViewDirWS;
					float3 ViewDir1_g60228 = View_Direction2511_g60177;
					float3 temp_cast_6 = (0.04).xxx;
					float3 lerpResult1473_g60177 = lerp( temp_cast_6 , oAlbedo6_g60177 , Metallic1239_g60177);
					float3 switchResult1501_g60177 = (((ase_vface>0)?(World_Normal2508_g60177):(-World_Normal2508_g60177)));
					float dotResult1476_g60177 = dot( switchResult1501_g60177 , View_Direction2511_g60177 );
					float3 lerpResult1480_g60177 = lerp( lerpResult1473_g60177 , float3( 1,1,1 ) , pow( ( 1.0 - saturate( dotResult1476_g60177 ) ) , 5.0 ));
					float3 Fresnel1560_g60177 = lerpResult1480_g60177;
					float3 Fresnel1_g60228 = Fresnel1560_g60177;
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g60177 = tex2D( _GlossinessMap, UV0A2420_g60177 ).r;
					#else
					float staticSwitch845_g60177 = _Glossiness;
					#endif
					float2 temp_output_5_0_g60217 = UV0A2420_g60177;
					float2 UV633_g60217 = temp_output_5_0_g60217;
					float2 UV100_g60218 = UV633_g60217;
					float2 temp_output_51_0_g60218 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60218 * float2( 3.464,3.464 ) ) );
					float2 break55_g60218 = frac( temp_output_51_0_g60218 );
					float temp_output_56_0_g60218 = ( ( 1.0 - break55_g60218.x ) - break55_g60218.y );
					float2 temp_output_52_0_g60218 = floor( temp_output_51_0_g60218 );
					float2 temp_output_125_0_g60218 = ( temp_output_52_0_g60218 + float2( 1,1 ) );
					float2 ifLocalVar87_g60218 = 0;
					if( temp_output_56_0_g60218 > 0.0 )
					ifLocalVar87_g60218 = temp_output_52_0_g60218;
					else if( temp_output_56_0_g60218 == 0.0 )
					ifLocalVar87_g60218 = temp_output_125_0_g60218;
					else if( temp_output_56_0_g60218 < 0.0 )
					ifLocalVar87_g60218 = temp_output_125_0_g60218;
					float3 temp_output_7_0_g60219 = frac( ( (ifLocalVar87_g60218).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60219 = dot( temp_output_7_0_g60219 , ( (temp_output_7_0_g60219).yzx + 33.33 ) );
					float3 temp_output_12_0_g60219 = ( temp_output_7_0_g60219 + dotResult8_g60219 );
					float2 temp_output_597_0_g60217 = ( UV100_g60218 + frac( ( ( (temp_output_12_0_g60219).xx + (temp_output_12_0_g60219).yz ) * (temp_output_12_0_g60219).zy ) ) );
					float2 DDX631_g60217 = ddx( temp_output_5_0_g60217 );
					float2 DDY632_g60217 = ddy( temp_output_5_0_g60217 );
					float temp_output_65_0_g60218 = ( 0.0 - temp_output_56_0_g60218 );
					float ifLocalVar59_g60218 = 0;
					if( temp_output_56_0_g60218 <= 0.0 )
					ifLocalVar59_g60218 = temp_output_65_0_g60218;
					else
					ifLocalVar59_g60218 = temp_output_56_0_g60218;
					float temp_output_597_30_g60217 = ifLocalVar59_g60218;
					float2 temp_output_90_0_g60218 = ( temp_output_52_0_g60218 + float2( 0,1 ) );
					float2 temp_output_123_0_g60218 = ( temp_output_52_0_g60218 + float2( 1,0 ) );
					float2 ifLocalVar88_g60218 = 0;
					if( temp_output_56_0_g60218 > 0.0 )
					ifLocalVar88_g60218 = temp_output_90_0_g60218;
					else if( temp_output_56_0_g60218 == 0.0 )
					ifLocalVar88_g60218 = temp_output_123_0_g60218;
					else if( temp_output_56_0_g60218 < 0.0 )
					ifLocalVar88_g60218 = temp_output_123_0_g60218;
					float3 temp_output_7_0_g60220 = frac( ( (ifLocalVar88_g60218).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60220 = dot( temp_output_7_0_g60220 , ( (temp_output_7_0_g60220).yzx + 33.33 ) );
					float3 temp_output_12_0_g60220 = ( temp_output_7_0_g60220 + dotResult8_g60220 );
					float2 temp_output_597_26_g60217 = ( UV100_g60218 + frac( ( ( (temp_output_12_0_g60220).xx + (temp_output_12_0_g60220).yz ) * (temp_output_12_0_g60220).zy ) ) );
					float temp_output_66_0_g60218 = ( 1.0 - break55_g60218.y );
					float ifLocalVar60_g60218 = 0;
					if( temp_output_56_0_g60218 <= 0.0 )
					ifLocalVar60_g60218 = temp_output_66_0_g60218;
					else
					ifLocalVar60_g60218 = break55_g60218.y;
					float temp_output_597_28_g60217 = ifLocalVar60_g60218;
					float2 ifLocalVar89_g60218 = 0;
					if( temp_output_56_0_g60218 > 0.0 )
					ifLocalVar89_g60218 = temp_output_123_0_g60218;
					else if( temp_output_56_0_g60218 == 0.0 )
					ifLocalVar89_g60218 = temp_output_90_0_g60218;
					else if( temp_output_56_0_g60218 < 0.0 )
					ifLocalVar89_g60218 = temp_output_90_0_g60218;
					float3 temp_output_7_0_g60221 = frac( ( (ifLocalVar89_g60218).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60221 = dot( temp_output_7_0_g60221 , ( (temp_output_7_0_g60221).yzx + 33.33 ) );
					float3 temp_output_12_0_g60221 = ( temp_output_7_0_g60221 + dotResult8_g60221 );
					float2 temp_output_597_27_g60217 = ( UV100_g60218 + frac( ( ( (temp_output_12_0_g60221).xx + (temp_output_12_0_g60221).yz ) * (temp_output_12_0_g60221).zy ) ) );
					float temp_output_67_0_g60218 = ( 1.0 - break55_g60218.x );
					float ifLocalVar61_g60218 = 0;
					if( temp_output_56_0_g60218 <= 0.0 )
					ifLocalVar61_g60218 = temp_output_67_0_g60218;
					else
					ifLocalVar61_g60218 = break55_g60218.x;
					float temp_output_597_29_g60217 = ifLocalVar61_g60218;
					float4 Output_2D293_g60217 = ( ( tex2D( _Sampler82964_g60177, temp_output_597_0_g60217, DDX631_g60217, DDY632_g60217 ) * temp_output_597_30_g60217 ) + ( tex2D( _Sampler82964_g60177, temp_output_597_26_g60217, DDX631_g60217, DDY632_g60217 ) * temp_output_597_28_g60217 ) + ( tex2D( _Sampler82964_g60177, temp_output_597_27_g60217, DDX631_g60217, DDY632_g60217 ) * temp_output_597_29_g60217 ) );
					float4 break31_g60217 = Output_2D293_g60217;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g60177 = ( 1.0 - break31_g60217.r );
					#else
					float staticSwitch1004_g60177 = ( 1.0 - staticSwitch845_g60177 );
					#endif
					float temp_output_19_0_g60222 = staticSwitch1004_g60177;
					float3 tanNormal2_g60222 = World_Normal2508_g60177;
					float3 worldNormal2_g60222 = float3( dot( tanToWorld0, tanNormal2_g60222 ), dot( tanToWorld1, tanNormal2_g60222 ), dot( tanToWorld2, tanNormal2_g60222 ) );
					float3 temp_output_3_0_g60222 = ddx( worldNormal2_g60222 );
					float dotResult5_g60222 = dot( temp_output_3_0_g60222 , temp_output_3_0_g60222 );
					float3 temp_output_4_0_g60222 = ddy( worldNormal2_g60222 );
					float dotResult6_g60222 = dot( temp_output_4_0_g60222 , temp_output_4_0_g60222 );
					#ifdef _USEGEOMETRICAA_ON
					float staticSwitch15_g60222 = min( temp_output_19_0_g60222, ( 1.0 - pow( saturate( max( dotResult5_g60222, dotResult6_g60222 ) ) , 0.333 ) ) );
					#else
					float staticSwitch15_g60222 = temp_output_19_0_g60222;
					#endif
					float Smoothness1399_g60177 = staticSwitch15_g60222;
					float Smoothness1_g60228 = Smoothness1399_g60177;
					float3 localIndirectSpecularWithBoxProjection1_g60228 = IndirectSpecularWithBoxProjection1_g60228( WorldPos1_g60228 , WorldNormal1_g60228 , ViewDir1_g60228 , Fresnel1_g60228 , Smoothness1_g60228 );
					float3 lerpResult2658_g60177 = lerp( temp_cast_5 , localIndirectSpecularWithBoxProjection1_g60228 , Metallic1239_g60177);
					#ifdef _IsMetallic
					float3 staticSwitch2657_g60177 = lerpResult2658_g60177;
					#else
					float3 staticSwitch2657_g60177 = temp_cast_4;
					#endif
					float3 temp_cast_7 = (0.0).xxx;
					float3 temp_cast_8 = (0.1).xxx;
					float3 smoothstepResult2430_g60177 = smoothstep( temp_cast_7 , temp_cast_8 , Lightmap46_g60177);
					#ifdef _USELIGHTMAPPEDREFLECTIONS_ON
					float3 staticSwitch1469_g60177 = ( staticSwitch2657_g60177 * smoothstepResult2430_g60177 );
					#else
					float3 staticSwitch1469_g60177 = staticSwitch2657_g60177;
					#endif
					float3 Reflections1419_g60177 = staticSwitch1469_g60177;
					float3 AlbedoColor97_g60229 = oAlbedo6_g60177;
					float3 LightmapColor97_g60229 = Lightmap46_g60177;
					float Metallic97_g60229 = Metallic1239_g60177;
					float Smoothness97_g60229 = Smoothness1399_g60177;
					float3 Fresnel97_g60229 = Fresnel1560_g60177;
					float3 WorldPos97_g60229 = World_Position2505_g60177;
					float3 WorldNormal97_g60229 = World_Normal2508_g60177;
					float3 ViewDir97_g60229 = View_Direction2511_g60177;
					float3 localSpecular97_g60229 = Specular( AlbedoColor97_g60229 , LightmapColor97_g60229 , Metallic97_g60229 , Smoothness97_g60229 , Fresnel97_g60229 , WorldPos97_g60229 , WorldNormal97_g60229 , ViewDir97_g60229 );
					float3 Speculars2560_g60177 = localSpecular97_g60229;
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch1181_g60177 = Lightmap46_g60177;
					#else
					float3 staticSwitch1181_g60177 = ( ( aAlbedo1466_g60177 * Lightmap46_g60177 ) + Emission86_g60177 + Reflections1419_g60177 + Speculars2560_g60177 );
					#endif
					float3 temp_output_35_0_g60192 = staticSwitch1181_g60177;
					float3 Color353_g60192 = temp_output_35_0_g60192;
					#if defined( _LUTMODE_2D )
					float3 staticSwitch273_g60192 = saturate( temp_output_35_0_g60192 );
					#elif defined( _LUTMODE_3D )
					float3 staticSwitch273_g60192 = temp_output_35_0_g60192;
					#else
					float3 staticSwitch273_g60192 = temp_output_35_0_g60192;
					#endif
					float3 Color_Saturate49_g60192 = staticSwitch273_g60192;
					float Lut_Height213_g60192 = _LUTSize;
					float Lut_Width216_g60192 = ( _LUTSize * Lut_Height213_g60192 );
					float3 appendResult214_g60192 = (float3(( 1.0 / Lut_Width216_g60192 ) , ( 1.0 / Lut_Height213_g60192 ) , ( Lut_Height213_g60192 - 1.0 )));
					float3 Scale_Offset208_g60192 = appendResult214_g60192;
					float2 Scale_Factor292_g60192 = ( (Scale_Offset208_g60192).xy * (Scale_Offset208_g60192).z );
					float2 Offset299_g60192 = ( (Scale_Offset208_g60192).xy * 0.5 );
					float2 Adjusted_UV305_g60192 = ( ( (Color_Saturate49_g60192).xy * Scale_Factor292_g60192 ) + Offset299_g60192 );
					float Scaled_Blue280_g60192 = ( (Color_Saturate49_g60192).z * (Scale_Offset208_g60192).z );
					float Shift288_g60192 = floor( Scaled_Blue280_g60192 );
					float Final_X313_g60192 = ( (Adjusted_UV305_g60192).x + ( Shift288_g60192 * (Scale_Offset208_g60192).y ) );
					float2 appendResult326_g60192 = (float2(Final_X313_g60192 , (Adjusted_UV305_g60192).y));
					float2 Final_UV325_g60192 = appendResult326_g60192;
					float2 appendResult338_g60192 = (float2((Scale_Offset208_g60192).y , 0.0));
					float2 Offset_UV336_g60192 = ( Final_UV325_g60192 + appendResult338_g60192 );
					float3 lerpResult333_g60192 = lerp( tex2D( _2DLut, Final_UV325_g60192 ).rgb , tex2D( _2DLut, Offset_UV336_g60192 ).rgb , ( Scaled_Blue280_g60192 - Shift288_g60192 ));
					#ifdef _2DLUT
					float3 staticSwitch347_g60192 = lerpResult333_g60192;
					#else
					float3 staticSwitch347_g60192 = Color_Saturate49_g60192;
					#endif
					float3 TwoD_LUT346_g60192 = staticSwitch347_g60192;
					float3 RGB16_g60193 = ( ( log10( ( ( Color_Saturate49_g60192 * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 );
					#ifdef _3DLUT
					float3 staticSwitch194_g60192 = tex3D( _3DLut, RGB16_g60193 ).rgb;
					#else
					float3 staticSwitch194_g60192 = Color_Saturate49_g60192;
					#endif
					float3 ThreeD_LUT51_g60192 = staticSwitch194_g60192;
					#if defined( _LUTMODE_2D )
					float3 staticSwitch42_g60192 = TwoD_LUT346_g60192;
					#elif defined( _LUTMODE_3D )
					float3 staticSwitch42_g60192 = ThreeD_LUT51_g60192;
					#else
					float3 staticSwitch42_g60192 = ThreeD_LUT51_g60192;
					#endif
					#ifdef SHADER_API_MOBILE
					float3 staticSwitch41_g60192 = staticSwitch42_g60192;
					#else
					float3 staticSwitch41_g60192 = Color353_g60192;
					#endif
					

					o.Albedo = staticSwitch1180_g60177;
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

					o.Emission = staticSwitch41_g60192;
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
				#define ASE_NO_AMBIENT 1
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
				#define ASE_NO_AMBIENT 1
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
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5572;-64,-1280;Inherit;False;Meenphie;0;;60177;b3ba55a08dd6b49c7be16c6f35cf2033;5,1008,0,2632,0,2619,0,2635,0,2636,0;0;5;FLOAT3;625;FLOAT3;624;FLOAT;156;FLOAT;427;FLOAT;1024
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5279;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5280;256,-1280;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;5;Meenphie/Standard/Opaque;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardBase;0;1;ForwardBase;17;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;True;True;0;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;44;Category;0;0;  Instanced Terrain Normals;1;0;Workflow;3;639079749420714040;Surface;0;0;  Blend;0;0;  Dither Shadows;1;0;Two Sided;1;0;Alpha Clipping;0;0;  Use Shadow Threshold;0;0;Deferred Pass;0;639079951064078170;Normal Space;0;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;0;639108440689538340;Receive Shadows;1;0;Receive Specular;0;639108440701916390;Receive Reflections;0;639108447998214750;GPU Instancing;1;0;LOD CrossFade;1;0;Built-in Fog;1;639105044169342440;Ambient Light;0;639079749088921010;Meta Pass;0;639079749085366090;Add Pass;0;639079749082074320;Override Baked GI;0;0;Write Depth;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;0;Vertex Position;1;0;0;8;False;True;False;False;False;False;True;True;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5281;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;True;1;LightMode=ForwardAdd;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5282;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5283;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5284;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5285;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5286;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ScenePickingPass;0;7;ScenePickingPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=Picking;False;False;0;;0;0;Standard;0;False;0
WireConnection;5280;0;5572;625
WireConnection;5280;2;5572;624
ASEEND*/
//CHKSM=6468DE2FF6E1313E6C342EB25211036CC9FD6777