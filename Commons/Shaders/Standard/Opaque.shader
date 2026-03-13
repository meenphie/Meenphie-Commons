// Made with Amplify Shader Editor v1.9.9.7
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Standard/Opaque"
{
	Properties
	{
		[Meenphie_DrawerCategory(SURFACE OPTIONS,true,0,0)] _CATEGORY_SURFACEOPTIONS( "CATEGORY_SURFACEOPTIONS", Float ) = 1
		_Color( "DIffuse Color", Color ) = ( 0.9058824, 0.9058824, 0.9058824, 1 )
		[NoScaleOffset][SingleLineTexture] _MainTex( "Diffuse Map", 2D ) = "white" {}
		[NoScaleOffset][Normal][SingleLineTexture] _BumpMap( "Normal Map", 2D ) = "bump" {}
		[NoScaleOffset][SingleLineTexture] _MetallicMap( "Metallic Map", 2D ) = "white" {}
		[NoScaleOffset][SingleLineTexture] _GlossinessMap( "Roughness Map", 2D ) = "white" {}
		_Metallic( "Metallic", Range( 0, 1 ) ) = 0
		_Glossiness( "Smoothness", Range( 0, 1 ) ) = 0.5
		[Toggle] _UseGeometricAA( "Use Geometric AA", Float ) = 1
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESURFACEOPTIONS( "CATEGORY SPACE SURFACEOPTIONS", Float ) = 0
		[Meenphie_DrawerCategory(EMISSION,true,0,0)] _CATEGORYEMISSION( "CATEGORY EMISSION", Float ) = 0
		[Toggle( _EMISSIONENABLED_ON )] _EmissionEnabled( "Emission Enabled", Float ) = 0
		[Gamma] _EmissionColor( "Emission Color", Color ) = ( 1, 1, 1 )
		[NoScaleOffset][SingleLineTexture] _EmissionMap( "Emission Map", 2D ) = "white" {}
		_EmissionIntensity( "Emission Intensity", Float ) = 0
		[Meenphie_DrawerEmissionFlags] _EmissionFlags( "Global Illumination", Float ) = 2
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACEEMISSION( "CATEGORY SPACE EMISSION", Float ) = 0
		[Meenphie_DrawerCategory(LIGHTMAPPING,true,0,0)] _CATEGORYLIGHTMAPPING( "CATEGORY LIGHTMAPPING", Float ) = 0
		[KeywordEnum( Disabled,Simple,SimpleLerp,RNM,RNMLerp )] _LightmapMode( "Lightmap Mode", Float ) = 0
		[NoScaleOffset][SingleLineTexture] _Lightmap0( "Lightmap 0", 2D ) = "black" {}
		[NoScaleOffset][SingleLineTexture] _Lightmap1( "Lightmap 1", 2D ) = "black" {}
		[Meenphie_DrawerTextureSingleLine] _RNMX0( "RNMX 0", 2D ) = "black" {}
		[Meenphie_DrawerTextureSingleLine] _RNMY0( "RNMY 0", 2D ) = "black" {}
		[Meenphie_DrawerTextureSingleLine] _RNMZ0( "RNMZ 0", 2D ) = "black" {}
		[Meenphie_DrawerTextureSingleLine] _RNMX1( "RNMX 1", 2D ) = "black" {}
		[Meenphie_DrawerTextureSingleLine] _RNMY1( "RNMY 1", 2D ) = "black" {}
		[Meenphie_DrawerTextureSingleLine] _RNMZ1( "RNMZ 1", 2D ) = "black" {}
		_LIGHTMAPLERP( "Lightmap Lerp", Range( 0, 1 ) ) = 0
		[Toggle( _USEBICUBICFILTERING_ON )] _UseBicubicFiltering( "Use Bicubic Filtering", Float ) = 1
		[Toggle( _USELIGHTMAPSPECULAR_ON )] _UseLightmapSpecular( "Use Lightmap Specular", Float ) = 1
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
		[KeywordEnum( Disabled,LED )] _SpecialEffects( "Special Effects", Float ) = 0
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESPECIALEFFECTS( "CATEGORY SPACE SPECIAL EFFECTS", Float ) = 0
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0
		[HideInInspector] GenKey__2DLut( "Assign keyword _2DLUT", Float ) = 1.0
		[HideInInspector] GenKey__MainTex( "Assign keyword _MAINTEX", Float ) = 1.0
		[HideInInspector] GenKey__MetallicMap( "Assign keyword _METALLICMAP", Float ) = 1.0
		[HideInInspector] GenKey__GlossinessMap( "Assign keyword _GLOSSINESSMAP", Float ) = 1.0
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
				#define _SPECULARHIGHLIGHTS_OFF
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
				#pragma shader_feature _LIGHTMAPDEBUG
				#pragma shader_feature_local_fragment _MAINTEX
				#pragma shader_feature_local _STOCHASTICENABLED_ON
				#pragma shader_feature_local_fragment _METALLICMAP
				#pragma shader_feature_local _LIGHTMAPMODE_DISABLED _LIGHTMAPMODE_SIMPLE _LIGHTMAPMODE_SIMPLELERP _LIGHTMAPMODE_RNM _LIGHTMAPMODE_RNMLERP
				#pragma shader_feature_local _USEBICUBICFILTERING_ON
				#pragma shader_feature_local_fragment _BUMPMAP
				#pragma shader_feature_local_fragment _USELIGHTMAPSPECULAR_ON
				#pragma shader_feature_local_fragment _GLOSSINESSMAP
				#pragma shader_feature_local _EMISSIONENABLED_ON
				#pragma shader_feature_local _SPECIALEFFECTS_DISABLED _SPECIALEFFECTS_LED
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
				uniform float _CATEGORYSPACESURFACEOPTIONS;
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
				uniform float _UdonSpecularLightCount;
				uniform float4 _UdonSpecularLightUp[32];
				uniform float4 _UdonSpecularLightRight[32];
				uniform float4 _UdonSpecularLightCol[32];
				uniform float4 _UdonSpecularLightPos[32];
				uniform half4 _Color;
				uniform sampler2D _MainTex;
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				uniform sampler2D _Lightmap0;
				float4 _Lightmap0_TexelSize;
				uniform sampler2D _Lightmap1;
				float4 _Lightmap1_TexelSize;
				uniform float _LIGHTMAPLERP;
				uniform sampler2D _BumpMap;
				uniform sampler2D _RNMX0;
				float4 _RNMX0_TexelSize;
				uniform sampler2D _RNMY0;
				uniform sampler2D _RNMZ0;
				uniform sampler2D _RNMX1;
				float4 _RNMX1_TexelSize;
				uniform sampler2D _RNMY1;
				uniform sampler2D _RNMZ1;
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				uniform float _UseGeometricAA;
				uniform float3 _EmissionColor;
				uniform sampler2D _EmissionMap;
				uniform float _EmissionIntensity;


				float3 IndirectGeometricSpecular1_g60743( float3 WorldPos, float3 WorldNormal, float3 ViewDir, float Smoothness, float4 Fresnel, float UseGeometricAA )
				{
					// =============================================
					//  GEOMETRIC SPECULAR AA - MÉTHODE VALVE (GDC 2015)
					//  Version INDIRECT / IBL (cubemap) - Forward ASE
					// =============================================
					// --- 1. SETUP DES VECTEURS ---
					float3 N = normalize(WorldNormal);
					float3 V = normalize(ViewDir);
					float3 R = reflect(-V, N);
					float AA_Roughness = 1.0 - Smoothness;   // ta rugosité de base
					// --- 2. FILTRAGE GÉOMÉTRIQUE - MÉTHODE VALVE ---
					if (UseGeometricAA > 0.5)
					{
					    // Dérivées de la normale monde
					    float3 dNdx = ddx(N);
					    float3 dNdy = ddy(N);
					    // Facteur de rugosité géométrique (formule exacte Valve)
					    float varianceMax = max(dot(dNdx, dNdx), dot(dNdy, dNdy));
					    float geometricFactor = pow(saturate(varianceMax), 0.333);   // ≈ 1/3 power
					    // On ajoute à la rugosité (équivalent à min(smoothness, 1 - factor))
					    AA_Roughness = max(AA_Roughness, geometricFactor);
					}
					// --- 3. BOX PROJECTION (Unity built-in) ---
					float3 ray = R;
					if (unity_SpecCube0_ProbePosition.w > 0.0)
					{
					    float3 factors = ((ray > 0.0 ? unity_SpecCube0_BoxMax.xyz : unity_SpecCube0_BoxMin.xyz) - WorldPos) / ray;
					    float scalar = min(min(factors.x, factors.y), factors.z);
					    ray = ray * scalar + (WorldPos - unity_SpecCube0_ProbePosition.xyz);
					}
					// --- 4. SAMPLING DE LA CUBEMAP ---
					float mipLevel = AA_Roughness * 7.0;                     // 7 mips de unity_SpecCube0
					float4 envSample = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, ray, mipLevel);
					float3 indirectSpec = DecodeHDR(envSample, unity_SpecCube0_HDR);
					return indirectSpec * Fresnel;
				}
				
				float3 Specular( float3 WorldPos, float3 WorldNormal, float Smoothness, float3 LightmapColor, float3 ViewDir )
				{
					// --- CONFIGURATION ---
					float LumaStart = 0.05;
					float LumaEnd = 0.95;
					float MaxRadius = 10.0; 
					float RadiusFadeStart = 3.0;
					float specBoost = 1.0;
					// --- 1. MASK LIGHTMAP & DISTANCE ---
					float luma = dot(LightmapColor, float3(0.22, 0.70, 0.08));
					float lmMask = saturate((luma - LumaStart) / max(LumaEnd - LumaStart, 0.0001));
					float playerDist = distance(_WorldSpaceCameraPos, WorldPos);
					float radiusFade = 1.0 - saturate((playerDist - RadiusFadeStart) / max(MaxRadius - RadiusFadeStart, 0.0001));
					if (lmMask < 0.001 || Smoothness < 0.01 || _UdonSpecularLightCount == 0 || radiusFade < 0.001) return 0;
					// --- 3. SETUP OPTIMISÉ ---
					float3 vDir = normalize(ViewDir);
					float3 N = normalize(WorldNormal);
					// Atteint exactement 2.0 (S=0) et 2048.0 (S=1)
					float shininess = exp2(10.0 * Smoothness + 1.0);
					float normalization = (shininess + 2.0) * 0.125;
					float nv = saturate(dot(N, vDir));
					float fBase = 1.0 - nv;
					float f2 = fBase * fBase;
					float fresnel = 0.04 + 0.96 * (f2 * f2 * fBase); // Pas de pow ici
					float3 R = reflect(-vDir, N);
					float3 specAccum = 0.0;
					// --- 4. BOUCLE ---
					int lightCount = (int)_UdonSpecularLightCount;
					for (int i = 0; i < lightCount; i++)
					{
					    float4 lightPosRange = _UdonSpecularLightPos[i];
					    float3 L = lightPosRange.xyz - WorldPos;
					    float3 proj = R * dot(L, R) - L;
					    float3 closestPoint = lightPosRange.xyz;
					    closestPoint += _UdonSpecularLightRight[i].xyz * clamp(dot(proj, _UdonSpecularLightRight[i].xyz), -_UdonSpecularLightRight[i].w, _UdonSpecularLightRight[i].w);
					    closestPoint += _UdonSpecularLightUp[i].xyz * clamp(dot(proj, _UdonSpecularLightUp[i].xyz), -_UdonSpecularLightUp[i].w, _UdonSpecularLightUp[i].w);
					    float3 diff = closestPoint - WorldPos;
					    float distSq = dot(diff, diff);
					    float range = lightPosRange.w;
					    float atten = saturate(1.0 - (distSq / (range * range)));
					    float falloff = (atten * atten) / (distSq + 0.01);
					    if (falloff > 0.001)
					    {
					        float3 lDir = normalize(diff);
					        float nDotL = saturate(dot(N, lDir));
					        if (nDotL > 0)
					        {
					            float3 H = normalize(lDir + vDir);
					            float nDotH = saturate(dot(N, H));
					            // Spéculaire via exp2/log2 (équivalent performant du pow)
					            float spec = exp2(log2(max(nDotH, 0.00001)) * shininess) * normalization;
					            specAccum += _UdonSpecularLightCol[i].rgb * (spec * nDotL * _UdonSpecularLightCol[i].w * falloff);
					        }
					    }
					}
					return specAccum * specBoost * fresnel * lmMask * radiusFade;
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

					float2 texCoord2357_g60691 = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV02420_g60691 = texCoord2357_g60691;
					float2 temp_output_5_0_g60729 = UV02420_g60691;
					float2 UV633_g60729 = temp_output_5_0_g60729;
					float2 UV100_g60730 = UV633_g60729;
					float2 temp_output_51_0_g60730 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60730 * float2( 3.464,3.464 ) ) );
					float2 break55_g60730 = frac( temp_output_51_0_g60730 );
					float temp_output_56_0_g60730 = ( ( 1.0 - break55_g60730.x ) - break55_g60730.y );
					float2 temp_output_52_0_g60730 = floor( temp_output_51_0_g60730 );
					float2 temp_output_125_0_g60730 = ( temp_output_52_0_g60730 + float2( 1,1 ) );
					float2 ifLocalVar87_g60730 = 0;
					if( temp_output_56_0_g60730 > 0.0 )
					ifLocalVar87_g60730 = temp_output_52_0_g60730;
					else if( temp_output_56_0_g60730 == 0.0 )
					ifLocalVar87_g60730 = temp_output_125_0_g60730;
					else if( temp_output_56_0_g60730 < 0.0 )
					ifLocalVar87_g60730 = temp_output_125_0_g60730;
					float3 temp_output_7_0_g60731 = frac( ( (ifLocalVar87_g60730).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60731 = dot( temp_output_7_0_g60731 , ( (temp_output_7_0_g60731).yzx + 33.33 ) );
					float3 temp_output_12_0_g60731 = ( temp_output_7_0_g60731 + dotResult8_g60731 );
					float2 temp_output_597_0_g60729 = ( UV100_g60730 + frac( ( ( (temp_output_12_0_g60731).xx + (temp_output_12_0_g60731).yz ) * (temp_output_12_0_g60731).zy ) ) );
					float2 DDX631_g60729 = ddx( temp_output_5_0_g60729 );
					float2 DDY632_g60729 = ddy( temp_output_5_0_g60729 );
					float temp_output_65_0_g60730 = ( 0.0 - temp_output_56_0_g60730 );
					float ifLocalVar59_g60730 = 0;
					if( temp_output_56_0_g60730 <= 0.0 )
					ifLocalVar59_g60730 = temp_output_65_0_g60730;
					else
					ifLocalVar59_g60730 = temp_output_56_0_g60730;
					float temp_output_597_30_g60729 = ifLocalVar59_g60730;
					float2 temp_output_90_0_g60730 = ( temp_output_52_0_g60730 + float2( 0,1 ) );
					float2 temp_output_123_0_g60730 = ( temp_output_52_0_g60730 + float2( 1,0 ) );
					float2 ifLocalVar88_g60730 = 0;
					if( temp_output_56_0_g60730 > 0.0 )
					ifLocalVar88_g60730 = temp_output_90_0_g60730;
					else if( temp_output_56_0_g60730 == 0.0 )
					ifLocalVar88_g60730 = temp_output_123_0_g60730;
					else if( temp_output_56_0_g60730 < 0.0 )
					ifLocalVar88_g60730 = temp_output_123_0_g60730;
					float3 temp_output_7_0_g60732 = frac( ( (ifLocalVar88_g60730).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60732 = dot( temp_output_7_0_g60732 , ( (temp_output_7_0_g60732).yzx + 33.33 ) );
					float3 temp_output_12_0_g60732 = ( temp_output_7_0_g60732 + dotResult8_g60732 );
					float2 temp_output_597_26_g60729 = ( UV100_g60730 + frac( ( ( (temp_output_12_0_g60732).xx + (temp_output_12_0_g60732).yz ) * (temp_output_12_0_g60732).zy ) ) );
					float temp_output_66_0_g60730 = ( 1.0 - break55_g60730.y );
					float ifLocalVar60_g60730 = 0;
					if( temp_output_56_0_g60730 <= 0.0 )
					ifLocalVar60_g60730 = temp_output_66_0_g60730;
					else
					ifLocalVar60_g60730 = break55_g60730.y;
					float temp_output_597_28_g60729 = ifLocalVar60_g60730;
					float2 ifLocalVar89_g60730 = 0;
					if( temp_output_56_0_g60730 > 0.0 )
					ifLocalVar89_g60730 = temp_output_123_0_g60730;
					else if( temp_output_56_0_g60730 == 0.0 )
					ifLocalVar89_g60730 = temp_output_90_0_g60730;
					else if( temp_output_56_0_g60730 < 0.0 )
					ifLocalVar89_g60730 = temp_output_90_0_g60730;
					float3 temp_output_7_0_g60733 = frac( ( (ifLocalVar89_g60730).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60733 = dot( temp_output_7_0_g60733 , ( (temp_output_7_0_g60733).yzx + 33.33 ) );
					float3 temp_output_12_0_g60733 = ( temp_output_7_0_g60733 + dotResult8_g60733 );
					float2 temp_output_597_27_g60729 = ( UV100_g60730 + frac( ( ( (temp_output_12_0_g60733).xx + (temp_output_12_0_g60733).yz ) * (temp_output_12_0_g60733).zy ) ) );
					float temp_output_67_0_g60730 = ( 1.0 - break55_g60730.x );
					float ifLocalVar61_g60730 = 0;
					if( temp_output_56_0_g60730 <= 0.0 )
					ifLocalVar61_g60730 = temp_output_67_0_g60730;
					else
					ifLocalVar61_g60730 = break55_g60730.x;
					float temp_output_597_29_g60729 = ifLocalVar61_g60730;
					float4 Output_2D293_g60729 = ( ( tex2D( _MainTex, temp_output_597_0_g60729, DDX631_g60729, DDY632_g60729 ) * temp_output_597_30_g60729 ) + ( tex2D( _MainTex, temp_output_597_26_g60729, DDX631_g60729, DDY632_g60729 ) * temp_output_597_28_g60729 ) + ( tex2D( _MainTex, temp_output_597_27_g60729, DDX631_g60729, DDY632_g60729 ) * temp_output_597_29_g60729 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g60691 = Output_2D293_g60729;
					#else
					float4 staticSwitch1001_g60691 = tex2D( _MainTex, UV02420_g60691 );
					#endif
					#ifdef _MAINTEX
					float4 staticSwitch1549_g60691 = staticSwitch1001_g60691;
					#else
					float4 staticSwitch1549_g60691 = _Color;
					#endif
					float4 oAlbedo6_g60691 = staticSwitch1549_g60691;
					float Black1185_g60691 = 0.0;
					float4 temp_cast_0 = (Black1185_g60691).xxxx;
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1180_g60691 = temp_cast_0;
					#else
					float4 staticSwitch1180_g60691 = oAlbedo6_g60691;
					#endif
					
					float2 temp_output_5_0_g60697 = UV02420_g60691;
					float2 UV633_g60697 = temp_output_5_0_g60697;
					float2 UV100_g60698 = UV633_g60697;
					float2 temp_output_51_0_g60698 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60698 * float2( 3.464,3.464 ) ) );
					float2 break55_g60698 = frac( temp_output_51_0_g60698 );
					float temp_output_56_0_g60698 = ( ( 1.0 - break55_g60698.x ) - break55_g60698.y );
					float2 temp_output_52_0_g60698 = floor( temp_output_51_0_g60698 );
					float2 temp_output_125_0_g60698 = ( temp_output_52_0_g60698 + float2( 1,1 ) );
					float2 ifLocalVar87_g60698 = 0;
					if( temp_output_56_0_g60698 > 0.0 )
					ifLocalVar87_g60698 = temp_output_52_0_g60698;
					else if( temp_output_56_0_g60698 == 0.0 )
					ifLocalVar87_g60698 = temp_output_125_0_g60698;
					else if( temp_output_56_0_g60698 < 0.0 )
					ifLocalVar87_g60698 = temp_output_125_0_g60698;
					float3 temp_output_7_0_g60699 = frac( ( (ifLocalVar87_g60698).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60699 = dot( temp_output_7_0_g60699 , ( (temp_output_7_0_g60699).yzx + 33.33 ) );
					float3 temp_output_12_0_g60699 = ( temp_output_7_0_g60699 + dotResult8_g60699 );
					float2 temp_output_597_0_g60697 = ( UV100_g60698 + frac( ( ( (temp_output_12_0_g60699).xx + (temp_output_12_0_g60699).yz ) * (temp_output_12_0_g60699).zy ) ) );
					float2 DDX631_g60697 = ddx( temp_output_5_0_g60697 );
					float2 DDY632_g60697 = ddy( temp_output_5_0_g60697 );
					float temp_output_65_0_g60698 = ( 0.0 - temp_output_56_0_g60698 );
					float ifLocalVar59_g60698 = 0;
					if( temp_output_56_0_g60698 <= 0.0 )
					ifLocalVar59_g60698 = temp_output_65_0_g60698;
					else
					ifLocalVar59_g60698 = temp_output_56_0_g60698;
					float temp_output_597_30_g60697 = ifLocalVar59_g60698;
					float2 temp_output_90_0_g60698 = ( temp_output_52_0_g60698 + float2( 0,1 ) );
					float2 temp_output_123_0_g60698 = ( temp_output_52_0_g60698 + float2( 1,0 ) );
					float2 ifLocalVar88_g60698 = 0;
					if( temp_output_56_0_g60698 > 0.0 )
					ifLocalVar88_g60698 = temp_output_90_0_g60698;
					else if( temp_output_56_0_g60698 == 0.0 )
					ifLocalVar88_g60698 = temp_output_123_0_g60698;
					else if( temp_output_56_0_g60698 < 0.0 )
					ifLocalVar88_g60698 = temp_output_123_0_g60698;
					float3 temp_output_7_0_g60700 = frac( ( (ifLocalVar88_g60698).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60700 = dot( temp_output_7_0_g60700 , ( (temp_output_7_0_g60700).yzx + 33.33 ) );
					float3 temp_output_12_0_g60700 = ( temp_output_7_0_g60700 + dotResult8_g60700 );
					float2 temp_output_597_26_g60697 = ( UV100_g60698 + frac( ( ( (temp_output_12_0_g60700).xx + (temp_output_12_0_g60700).yz ) * (temp_output_12_0_g60700).zy ) ) );
					float temp_output_66_0_g60698 = ( 1.0 - break55_g60698.y );
					float ifLocalVar60_g60698 = 0;
					if( temp_output_56_0_g60698 <= 0.0 )
					ifLocalVar60_g60698 = temp_output_66_0_g60698;
					else
					ifLocalVar60_g60698 = break55_g60698.y;
					float temp_output_597_28_g60697 = ifLocalVar60_g60698;
					float2 ifLocalVar89_g60698 = 0;
					if( temp_output_56_0_g60698 > 0.0 )
					ifLocalVar89_g60698 = temp_output_123_0_g60698;
					else if( temp_output_56_0_g60698 == 0.0 )
					ifLocalVar89_g60698 = temp_output_90_0_g60698;
					else if( temp_output_56_0_g60698 < 0.0 )
					ifLocalVar89_g60698 = temp_output_90_0_g60698;
					float3 temp_output_7_0_g60701 = frac( ( (ifLocalVar89_g60698).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60701 = dot( temp_output_7_0_g60701 , ( (temp_output_7_0_g60701).yzx + 33.33 ) );
					float3 temp_output_12_0_g60701 = ( temp_output_7_0_g60701 + dotResult8_g60701 );
					float2 temp_output_597_27_g60697 = ( UV100_g60698 + frac( ( ( (temp_output_12_0_g60701).xx + (temp_output_12_0_g60701).yz ) * (temp_output_12_0_g60701).zy ) ) );
					float temp_output_67_0_g60698 = ( 1.0 - break55_g60698.x );
					float ifLocalVar61_g60698 = 0;
					if( temp_output_56_0_g60698 <= 0.0 )
					ifLocalVar61_g60698 = temp_output_67_0_g60698;
					else
					ifLocalVar61_g60698 = break55_g60698.x;
					float temp_output_597_29_g60697 = ifLocalVar61_g60698;
					float4 Output_2D293_g60697 = ( ( tex2D( _MetallicMap, temp_output_597_0_g60697, DDX631_g60697, DDY632_g60697 ) * temp_output_597_30_g60697 ) + ( tex2D( _MetallicMap, temp_output_597_26_g60697, DDX631_g60697, DDY632_g60697 ) * temp_output_597_28_g60697 ) + ( tex2D( _MetallicMap, temp_output_597_27_g60697, DDX631_g60697, DDY632_g60697 ) * temp_output_597_29_g60697 ) );
					float4 break31_g60697 = Output_2D293_g60697;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g60691 = break31_g60697.a;
					#else
					float staticSwitch1005_g60691 = tex2D( _MetallicMap, UV02420_g60691 ).a;
					#endif
					#ifdef _METALLICMAP
					float staticSwitch846_g60691 = staticSwitch1005_g60691;
					#else
					float staticSwitch846_g60691 = _Metallic;
					#endif
					float Metallic1239_g60691 = staticSwitch846_g60691;
					float4 aAlbedo1466_g60691 = ( staticSwitch1549_g60691 * ( 1.0 - Metallic1239_g60691 ) );
					float White38_g60691 = 1.0;
					float4 temp_cast_2 = (White38_g60691).xxxx;
					float4 texCoord2426_g60691 = IN.ase_texcoord6;
					texCoord2426_g60691.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV12361_g60691 = (texCoord2426_g60691).zw;
					float localBicubicPrepare2_g60723 = ( 0.0 );
					float2 Input_UV100_g60723 = UV12361_g60691;
					float2 UV2_g60723 = Input_UV100_g60723;
					float4 TexelSize2_g60723 = _Lightmap0_TexelSize;
					float2 UV02_g60723 = float2( 0,0 );
					float2 UV12_g60723 = float2( 0,0 );
					float2 UV22_g60723 = float2( 0,0 );
					float2 UV32_g60723 = float2( 0,0 );
					float W02_g60723 = 0;
					float W12_g60723 = 0;
					{
					{
					 UV2_g60723 = UV2_g60723 * TexelSize2_g60723.zw - 0.5;
					    float2 f = frac( UV2_g60723 );
					    UV2_g60723 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g60723.x - 0.5, UV2_g60723.x + 1.5, UV2_g60723.y - 0.5, UV2_g60723.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60723.xyxy;
					    UV02_g60723 = off.xz;
					    UV12_g60723 = off.yz;
					    UV22_g60723 = off.xw;
					    UV32_g60723 = off.yw;
					    W02_g60723 = s.x / ( s.x + s.y );
					 W12_g60723 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g60723 = lerp( tex2D( _Lightmap0, UV32_g60723 ) , tex2D( _Lightmap0, UV22_g60723 ) , W02_g60723);
					float4 lerpResult45_g60723 = lerp( tex2D( _Lightmap0, UV12_g60723 ) , tex2D( _Lightmap0, UV02_g60723 ) , W02_g60723);
					float4 lerpResult44_g60723 = lerp( lerpResult46_g60723 , lerpResult45_g60723 , W12_g60723);
					float4 Output_2D_Auto131_g60723 = lerpResult44_g60723;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g60691 = Output_2D_Auto131_g60723;
					#else
					float4 staticSwitch1092_g60691 = tex2D( _Lightmap0, UV12361_g60691 );
					#endif
					float4 Lightmap_0925_g60691 = staticSwitch1092_g60691;
					float localBicubicPrepare2_g60721 = ( 0.0 );
					float2 Input_UV100_g60721 = UV12361_g60691;
					float2 UV2_g60721 = Input_UV100_g60721;
					float4 TexelSize2_g60721 = _Lightmap1_TexelSize;
					float2 UV02_g60721 = float2( 0,0 );
					float2 UV12_g60721 = float2( 0,0 );
					float2 UV22_g60721 = float2( 0,0 );
					float2 UV32_g60721 = float2( 0,0 );
					float W02_g60721 = 0;
					float W12_g60721 = 0;
					{
					{
					 UV2_g60721 = UV2_g60721 * TexelSize2_g60721.zw - 0.5;
					    float2 f = frac( UV2_g60721 );
					    UV2_g60721 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g60721.x - 0.5, UV2_g60721.x + 1.5, UV2_g60721.y - 0.5, UV2_g60721.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60721.xyxy;
					    UV02_g60721 = off.xz;
					    UV12_g60721 = off.yz;
					    UV22_g60721 = off.xw;
					    UV32_g60721 = off.yw;
					    W02_g60721 = s.x / ( s.x + s.y );
					 W12_g60721 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g60721 = lerp( tex2D( _Lightmap1, UV32_g60721 ) , tex2D( _Lightmap1, UV22_g60721 ) , W02_g60721);
					float4 lerpResult45_g60721 = lerp( tex2D( _Lightmap1, UV12_g60721 ) , tex2D( _Lightmap1, UV02_g60721 ) , W02_g60721);
					float4 lerpResult44_g60721 = lerp( lerpResult46_g60721 , lerpResult45_g60721 , W12_g60721);
					float4 Output_2D_Auto131_g60721 = lerpResult44_g60721;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g60691 = Output_2D_Auto131_g60721;
					#else
					float4 staticSwitch1088_g60691 = tex2D( _Lightmap1, UV12361_g60691 );
					#endif
					float4 Lightmap_1956_g60691 = staticSwitch1088_g60691;
					float Lightmap_Lerp_Value969_g60691 = _LIGHTMAPLERP;
					float4 lerpResult442_g60691 = lerp( Lightmap_0925_g60691 , Lightmap_1956_g60691 , Lightmap_Lerp_Value969_g60691);
					float4 Lightmap_Lerp932_g60691 = lerpResult442_g60691;
					float3 appendResult139_g60738 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float2 temp_output_5_0_g60692 = UV02420_g60691;
					float2 UV633_g60692 = temp_output_5_0_g60692;
					float2 UV100_g60693 = UV633_g60692;
					float2 temp_output_51_0_g60693 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60693 * float2( 3.464,3.464 ) ) );
					float2 break55_g60693 = frac( temp_output_51_0_g60693 );
					float temp_output_56_0_g60693 = ( ( 1.0 - break55_g60693.x ) - break55_g60693.y );
					float2 temp_output_52_0_g60693 = floor( temp_output_51_0_g60693 );
					float2 temp_output_125_0_g60693 = ( temp_output_52_0_g60693 + float2( 1,1 ) );
					float2 ifLocalVar87_g60693 = 0;
					if( temp_output_56_0_g60693 > 0.0 )
					ifLocalVar87_g60693 = temp_output_52_0_g60693;
					else if( temp_output_56_0_g60693 == 0.0 )
					ifLocalVar87_g60693 = temp_output_125_0_g60693;
					else if( temp_output_56_0_g60693 < 0.0 )
					ifLocalVar87_g60693 = temp_output_125_0_g60693;
					float3 temp_output_7_0_g60694 = frac( ( (ifLocalVar87_g60693).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60694 = dot( temp_output_7_0_g60694 , ( (temp_output_7_0_g60694).yzx + 33.33 ) );
					float3 temp_output_12_0_g60694 = ( temp_output_7_0_g60694 + dotResult8_g60694 );
					float2 temp_output_597_0_g60692 = ( UV100_g60693 + frac( ( ( (temp_output_12_0_g60694).xx + (temp_output_12_0_g60694).yz ) * (temp_output_12_0_g60694).zy ) ) );
					float2 DDX631_g60692 = ddx( temp_output_5_0_g60692 );
					float2 DDY632_g60692 = ddy( temp_output_5_0_g60692 );
					float Input_Scale617_g60692 = 1.5;
					float temp_output_65_0_g60693 = ( 0.0 - temp_output_56_0_g60693 );
					float ifLocalVar59_g60693 = 0;
					if( temp_output_56_0_g60693 <= 0.0 )
					ifLocalVar59_g60693 = temp_output_65_0_g60693;
					else
					ifLocalVar59_g60693 = temp_output_56_0_g60693;
					float temp_output_597_30_g60692 = ifLocalVar59_g60693;
					float2 temp_output_90_0_g60693 = ( temp_output_52_0_g60693 + float2( 0,1 ) );
					float2 temp_output_123_0_g60693 = ( temp_output_52_0_g60693 + float2( 1,0 ) );
					float2 ifLocalVar88_g60693 = 0;
					if( temp_output_56_0_g60693 > 0.0 )
					ifLocalVar88_g60693 = temp_output_90_0_g60693;
					else if( temp_output_56_0_g60693 == 0.0 )
					ifLocalVar88_g60693 = temp_output_123_0_g60693;
					else if( temp_output_56_0_g60693 < 0.0 )
					ifLocalVar88_g60693 = temp_output_123_0_g60693;
					float3 temp_output_7_0_g60695 = frac( ( (ifLocalVar88_g60693).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60695 = dot( temp_output_7_0_g60695 , ( (temp_output_7_0_g60695).yzx + 33.33 ) );
					float3 temp_output_12_0_g60695 = ( temp_output_7_0_g60695 + dotResult8_g60695 );
					float2 temp_output_597_26_g60692 = ( UV100_g60693 + frac( ( ( (temp_output_12_0_g60695).xx + (temp_output_12_0_g60695).yz ) * (temp_output_12_0_g60695).zy ) ) );
					float temp_output_66_0_g60693 = ( 1.0 - break55_g60693.y );
					float ifLocalVar60_g60693 = 0;
					if( temp_output_56_0_g60693 <= 0.0 )
					ifLocalVar60_g60693 = temp_output_66_0_g60693;
					else
					ifLocalVar60_g60693 = break55_g60693.y;
					float temp_output_597_28_g60692 = ifLocalVar60_g60693;
					float2 ifLocalVar89_g60693 = 0;
					if( temp_output_56_0_g60693 > 0.0 )
					ifLocalVar89_g60693 = temp_output_123_0_g60693;
					else if( temp_output_56_0_g60693 == 0.0 )
					ifLocalVar89_g60693 = temp_output_90_0_g60693;
					else if( temp_output_56_0_g60693 < 0.0 )
					ifLocalVar89_g60693 = temp_output_90_0_g60693;
					float3 temp_output_7_0_g60696 = frac( ( (ifLocalVar89_g60693).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60696 = dot( temp_output_7_0_g60696 , ( (temp_output_7_0_g60696).yzx + 33.33 ) );
					float3 temp_output_12_0_g60696 = ( temp_output_7_0_g60696 + dotResult8_g60696 );
					float2 temp_output_597_27_g60692 = ( UV100_g60693 + frac( ( ( (temp_output_12_0_g60696).xx + (temp_output_12_0_g60696).yz ) * (temp_output_12_0_g60696).zy ) ) );
					float temp_output_67_0_g60693 = ( 1.0 - break55_g60693.x );
					float ifLocalVar61_g60693 = 0;
					if( temp_output_56_0_g60693 <= 0.0 )
					ifLocalVar61_g60693 = temp_output_67_0_g60693;
					else
					ifLocalVar61_g60693 = break55_g60693.x;
					float temp_output_597_29_g60692 = ifLocalVar61_g60693;
					float3 Output_2D_Normal641_g60692 = ( ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_0_g60692, DDX631_g60692, DDY632_g60692 ), Input_Scale617_g60692 ) * temp_output_597_30_g60692 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_26_g60692, DDX631_g60692, DDY632_g60692 ), Input_Scale617_g60692 ) * temp_output_597_28_g60692 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_27_g60692, DDX631_g60692, DDY632_g60692 ), Input_Scale617_g60692 ) * float3( 0,0,0 ) * temp_output_597_29_g60692 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g60691 = Output_2D_Normal641_g60692;
					#else
					float3 staticSwitch1003_g60691 = UnpackScaleNormal( tex2D( _BumpMap, UV02420_g60691 ), 1.5 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g60691 = staticSwitch1003_g60691;
					#else
					float3 staticSwitch980_g60691 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g60691 = staticSwitch980_g60691;
					float3 normalizeResult326_g60738 = normalize( Normal_Map700_g60691 );
					float3 Normal_Map318_g60738 = normalizeResult326_g60738;
					float dotResult121_g60738 = dot( appendResult139_g60738 , Normal_Map318_g60738 );
					float temp_output_2_0_g60740 = dotResult121_g60738;
					float localStochasticTiling2_g60725 = ( 0.0 );
					float2 UV2_g60725 = UV12361_g60691;
					float4 TexelSize2_g60725 = _RNMX0_TexelSize;
					float4 Offsets2_g60725 = float4( 0,0,0,0 );
					float2 Weights2_g60725 = float2( 0,0 );
					{
					UV2_g60725 = UV2_g60725 * TexelSize2_g60725.zw - 0.5;
					float2 f = frac( UV2_g60725 );
					UV2_g60725 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g60725.x - 0.5, UV2_g60725.x + 1.5, UV2_g60725.y - 0.5, UV2_g60725.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g60725 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60725.xyxy;
					Weights2_g60725 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g60724 = Offsets2_g60725;
					float4 Input_FetchOffsets197_g60726 = temp_output_1_34_g60724;
					float2 temp_output_1_54_g60724 = Weights2_g60725;
					float2 Input_FetchWeights200_g60726 = temp_output_1_54_g60724;
					float2 break187_g60726 = Input_FetchWeights200_g60726;
					float4 lerpResult181_g60726 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g60726).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g60726).xw ) , break187_g60726.x);
					float4 lerpResult182_g60726 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g60726).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g60726).xz ) , break187_g60726.x);
					float4 lerpResult176_g60726 = lerp( lerpResult181_g60726 , lerpResult182_g60726 , break187_g60726.y);
					float4 Output_Fetch2D_Auto202_g60726 = lerpResult176_g60726;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g60691 = Output_Fetch2D_Auto202_g60726;
					#else
					float4 staticSwitch1061_g60691 = tex2D( _RNMX0, UV12361_g60691 );
					#endif
					float3 appendResult146_g60738 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g60738 = dot( appendResult146_g60738 , Normal_Map318_g60738 );
					float temp_output_2_0_g60739 = dotResult122_g60738;
					float4 Input_FetchOffsets197_g60727 = temp_output_1_34_g60724;
					float2 Input_FetchWeights200_g60727 = temp_output_1_54_g60724;
					float2 break187_g60727 = Input_FetchWeights200_g60727;
					float4 lerpResult181_g60727 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g60727).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g60727).xw ) , break187_g60727.x);
					float4 lerpResult182_g60727 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g60727).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g60727).xz ) , break187_g60727.x);
					float4 lerpResult176_g60727 = lerp( lerpResult181_g60727 , lerpResult182_g60727 , break187_g60727.y);
					float4 Output_Fetch2D_Auto202_g60727 = lerpResult176_g60727;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g60691 = Output_Fetch2D_Auto202_g60727;
					#else
					float4 staticSwitch1062_g60691 = tex2D( _RNMY0, UV12361_g60691 );
					#endif
					float3 appendResult149_g60738 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g60738 = dot( appendResult149_g60738 , Normal_Map318_g60738 );
					float temp_output_2_0_g60741 = dotResult120_g60738;
					float4 Input_FetchOffsets197_g60728 = temp_output_1_34_g60724;
					float2 Input_FetchWeights200_g60728 = temp_output_1_54_g60724;
					float2 break187_g60728 = Input_FetchWeights200_g60728;
					float4 lerpResult181_g60728 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g60728).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g60728).xw ) , break187_g60728.x);
					float4 lerpResult182_g60728 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g60728).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g60728).xz ) , break187_g60728.x);
					float4 lerpResult176_g60728 = lerp( lerpResult181_g60728 , lerpResult182_g60728 , break187_g60728.y);
					float4 Output_Fetch2D_Auto202_g60728 = lerpResult176_g60728;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g60691 = Output_Fetch2D_Auto202_g60728;
					#else
					float4 staticSwitch1063_g60691 = tex2D( _RNMZ0, UV12361_g60691 );
					#endif
					float4 RNM_0926_g60691 = ( ( ( ( ( temp_output_2_0_g60740 * temp_output_2_0_g60740 ) * staticSwitch1061_g60691 ) + ( ( temp_output_2_0_g60739 * temp_output_2_0_g60739 ) * staticSwitch1062_g60691 ) ) + ( ( temp_output_2_0_g60741 * temp_output_2_0_g60741 ) * staticSwitch1063_g60691 ) ) * 2.2 );
					float3 appendResult139_g60734 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g60734 = normalize( Normal_Map700_g60691 );
					float3 Normal_Map318_g60734 = normalizeResult326_g60734;
					float dotResult121_g60734 = dot( appendResult139_g60734 , Normal_Map318_g60734 );
					float temp_output_2_0_g60736 = dotResult121_g60734;
					float localStochasticTiling2_g60716 = ( 0.0 );
					float2 UV2_g60716 = UV12361_g60691;
					float4 TexelSize2_g60716 = _RNMX1_TexelSize;
					float4 Offsets2_g60716 = float4( 0,0,0,0 );
					float2 Weights2_g60716 = float2( 0,0 );
					{
					UV2_g60716 = UV2_g60716 * TexelSize2_g60716.zw - 0.5;
					float2 f = frac( UV2_g60716 );
					UV2_g60716 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g60716.x - 0.5, UV2_g60716.x + 1.5, UV2_g60716.y - 0.5, UV2_g60716.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g60716 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60716.xyxy;
					Weights2_g60716 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g60715 = Offsets2_g60716;
					float4 Input_FetchOffsets197_g60717 = temp_output_1_34_g60715;
					float2 temp_output_1_54_g60715 = Weights2_g60716;
					float2 Input_FetchWeights200_g60717 = temp_output_1_54_g60715;
					float2 break187_g60717 = Input_FetchWeights200_g60717;
					float4 lerpResult181_g60717 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g60717).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g60717).xw ) , break187_g60717.x);
					float4 lerpResult182_g60717 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g60717).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g60717).xz ) , break187_g60717.x);
					float4 lerpResult176_g60717 = lerp( lerpResult181_g60717 , lerpResult182_g60717 , break187_g60717.y);
					float4 Output_Fetch2D_Auto202_g60717 = lerpResult176_g60717;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g60691 = Output_Fetch2D_Auto202_g60717;
					#else
					float4 staticSwitch1087_g60691 = tex2D( _RNMX1, UV12361_g60691 );
					#endif
					float3 appendResult146_g60734 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g60734 = dot( appendResult146_g60734 , Normal_Map318_g60734 );
					float temp_output_2_0_g60735 = dotResult122_g60734;
					float4 Input_FetchOffsets197_g60718 = temp_output_1_34_g60715;
					float2 Input_FetchWeights200_g60718 = temp_output_1_54_g60715;
					float2 break187_g60718 = Input_FetchWeights200_g60718;
					float4 lerpResult181_g60718 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g60718).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g60718).xw ) , break187_g60718.x);
					float4 lerpResult182_g60718 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g60718).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g60718).xz ) , break187_g60718.x);
					float4 lerpResult176_g60718 = lerp( lerpResult181_g60718 , lerpResult182_g60718 , break187_g60718.y);
					float4 Output_Fetch2D_Auto202_g60718 = lerpResult176_g60718;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g60691 = Output_Fetch2D_Auto202_g60718;
					#else
					float4 staticSwitch1083_g60691 = tex2D( _RNMY1, UV12361_g60691 );
					#endif
					float3 appendResult149_g60734 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g60734 = dot( appendResult149_g60734 , Normal_Map318_g60734 );
					float temp_output_2_0_g60737 = dotResult120_g60734;
					float4 Input_FetchOffsets197_g60719 = temp_output_1_34_g60715;
					float2 Input_FetchWeights200_g60719 = temp_output_1_54_g60715;
					float2 break187_g60719 = Input_FetchWeights200_g60719;
					float4 lerpResult181_g60719 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g60719).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g60719).xw ) , break187_g60719.x);
					float4 lerpResult182_g60719 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g60719).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g60719).xz ) , break187_g60719.x);
					float4 lerpResult176_g60719 = lerp( lerpResult181_g60719 , lerpResult182_g60719 , break187_g60719.y);
					float4 Output_Fetch2D_Auto202_g60719 = lerpResult176_g60719;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g60691 = Output_Fetch2D_Auto202_g60719;
					#else
					float4 staticSwitch1084_g60691 = tex2D( _RNMZ1, UV12361_g60691 );
					#endif
					float4 RNM_11081_g60691 = ( ( ( ( ( temp_output_2_0_g60736 * temp_output_2_0_g60736 ) * staticSwitch1087_g60691 ) + ( ( temp_output_2_0_g60735 * temp_output_2_0_g60735 ) * staticSwitch1083_g60691 ) ) + ( ( temp_output_2_0_g60737 * temp_output_2_0_g60737 ) * staticSwitch1084_g60691 ) ) * 2.2 );
					float4 lerpResult953_g60691 = lerp( RNM_0926_g60691 , RNM_11081_g60691 , Lightmap_Lerp_Value969_g60691);
					float4 RNM_Lerp950_g60691 = lerpResult953_g60691;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g60691 = temp_cast_2;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g60691 = Lightmap_0925_g60691;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g60691 = Lightmap_Lerp932_g60691;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g60691 = RNM_0926_g60691;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g60691 = RNM_Lerp950_g60691;
					#else
					float4 staticSwitch1014_g60691 = temp_cast_2;
					#endif
					float4 Lightmap46_g60691 = staticSwitch1014_g60691;
					float3 WorldPos1_g60743 = PositionWS;
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal2_g60743 = Normal_Map700_g60691;
					float3 worldNormal2_g60743 = float3( dot( tanToWorld0, tanNormal2_g60743 ), dot( tanToWorld1, tanNormal2_g60743 ), dot( tanToWorld2, tanNormal2_g60743 ) );
					float3 WorldNormal1_g60743 = worldNormal2_g60743;
					float3 ViewDir1_g60743 = ViewDirWS;
					float2 temp_output_5_0_g60708 = UV02420_g60691;
					float2 UV633_g60708 = temp_output_5_0_g60708;
					float2 UV100_g60709 = UV633_g60708;
					float2 temp_output_51_0_g60709 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60709 * float2( 3.464,3.464 ) ) );
					float2 break55_g60709 = frac( temp_output_51_0_g60709 );
					float temp_output_56_0_g60709 = ( ( 1.0 - break55_g60709.x ) - break55_g60709.y );
					float2 temp_output_52_0_g60709 = floor( temp_output_51_0_g60709 );
					float2 temp_output_125_0_g60709 = ( temp_output_52_0_g60709 + float2( 1,1 ) );
					float2 ifLocalVar87_g60709 = 0;
					if( temp_output_56_0_g60709 > 0.0 )
					ifLocalVar87_g60709 = temp_output_52_0_g60709;
					else if( temp_output_56_0_g60709 == 0.0 )
					ifLocalVar87_g60709 = temp_output_125_0_g60709;
					else if( temp_output_56_0_g60709 < 0.0 )
					ifLocalVar87_g60709 = temp_output_125_0_g60709;
					float3 temp_output_7_0_g60710 = frac( ( (ifLocalVar87_g60709).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60710 = dot( temp_output_7_0_g60710 , ( (temp_output_7_0_g60710).yzx + 33.33 ) );
					float3 temp_output_12_0_g60710 = ( temp_output_7_0_g60710 + dotResult8_g60710 );
					float2 temp_output_597_0_g60708 = ( UV100_g60709 + frac( ( ( (temp_output_12_0_g60710).xx + (temp_output_12_0_g60710).yz ) * (temp_output_12_0_g60710).zy ) ) );
					float2 DDX631_g60708 = ddx( temp_output_5_0_g60708 );
					float2 DDY632_g60708 = ddy( temp_output_5_0_g60708 );
					float temp_output_65_0_g60709 = ( 0.0 - temp_output_56_0_g60709 );
					float ifLocalVar59_g60709 = 0;
					if( temp_output_56_0_g60709 <= 0.0 )
					ifLocalVar59_g60709 = temp_output_65_0_g60709;
					else
					ifLocalVar59_g60709 = temp_output_56_0_g60709;
					float temp_output_597_30_g60708 = ifLocalVar59_g60709;
					float2 temp_output_90_0_g60709 = ( temp_output_52_0_g60709 + float2( 0,1 ) );
					float2 temp_output_123_0_g60709 = ( temp_output_52_0_g60709 + float2( 1,0 ) );
					float2 ifLocalVar88_g60709 = 0;
					if( temp_output_56_0_g60709 > 0.0 )
					ifLocalVar88_g60709 = temp_output_90_0_g60709;
					else if( temp_output_56_0_g60709 == 0.0 )
					ifLocalVar88_g60709 = temp_output_123_0_g60709;
					else if( temp_output_56_0_g60709 < 0.0 )
					ifLocalVar88_g60709 = temp_output_123_0_g60709;
					float3 temp_output_7_0_g60711 = frac( ( (ifLocalVar88_g60709).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60711 = dot( temp_output_7_0_g60711 , ( (temp_output_7_0_g60711).yzx + 33.33 ) );
					float3 temp_output_12_0_g60711 = ( temp_output_7_0_g60711 + dotResult8_g60711 );
					float2 temp_output_597_26_g60708 = ( UV100_g60709 + frac( ( ( (temp_output_12_0_g60711).xx + (temp_output_12_0_g60711).yz ) * (temp_output_12_0_g60711).zy ) ) );
					float temp_output_66_0_g60709 = ( 1.0 - break55_g60709.y );
					float ifLocalVar60_g60709 = 0;
					if( temp_output_56_0_g60709 <= 0.0 )
					ifLocalVar60_g60709 = temp_output_66_0_g60709;
					else
					ifLocalVar60_g60709 = break55_g60709.y;
					float temp_output_597_28_g60708 = ifLocalVar60_g60709;
					float2 ifLocalVar89_g60709 = 0;
					if( temp_output_56_0_g60709 > 0.0 )
					ifLocalVar89_g60709 = temp_output_123_0_g60709;
					else if( temp_output_56_0_g60709 == 0.0 )
					ifLocalVar89_g60709 = temp_output_90_0_g60709;
					else if( temp_output_56_0_g60709 < 0.0 )
					ifLocalVar89_g60709 = temp_output_90_0_g60709;
					float3 temp_output_7_0_g60712 = frac( ( (ifLocalVar89_g60709).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60712 = dot( temp_output_7_0_g60712 , ( (temp_output_7_0_g60712).yzx + 33.33 ) );
					float3 temp_output_12_0_g60712 = ( temp_output_7_0_g60712 + dotResult8_g60712 );
					float2 temp_output_597_27_g60708 = ( UV100_g60709 + frac( ( ( (temp_output_12_0_g60712).xx + (temp_output_12_0_g60712).yz ) * (temp_output_12_0_g60712).zy ) ) );
					float temp_output_67_0_g60709 = ( 1.0 - break55_g60709.x );
					float ifLocalVar61_g60709 = 0;
					if( temp_output_56_0_g60709 <= 0.0 )
					ifLocalVar61_g60709 = temp_output_67_0_g60709;
					else
					ifLocalVar61_g60709 = break55_g60709.x;
					float temp_output_597_29_g60708 = ifLocalVar61_g60709;
					float4 Output_2D293_g60708 = ( ( tex2D( _GlossinessMap, temp_output_597_0_g60708, DDX631_g60708, DDY632_g60708 ) * temp_output_597_30_g60708 ) + ( tex2D( _GlossinessMap, temp_output_597_26_g60708, DDX631_g60708, DDY632_g60708 ) * temp_output_597_28_g60708 ) + ( tex2D( _GlossinessMap, temp_output_597_27_g60708, DDX631_g60708, DDY632_g60708 ) * temp_output_597_29_g60708 ) );
					float4 break31_g60708 = Output_2D293_g60708;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g60691 = break31_g60708.a;
					#else
					float staticSwitch1004_g60691 = tex2D( _GlossinessMap, UV02420_g60691 ).r;
					#endif
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g60691 = ( 1.0 - staticSwitch1004_g60691 );
					#else
					float staticSwitch845_g60691 = _Glossiness;
					#endif
					float Smoothness1399_g60691 = staticSwitch845_g60691;
					float Smoothness1_g60743 = Smoothness1399_g60691;
					float4 temp_cast_3 = (0.04).xxxx;
					float4 lerpResult1473_g60691 = lerp( temp_cast_3 , oAlbedo6_g60691 , Metallic1239_g60691);
					float3 switchResult1501_g60691 = (((ase_vface>0)?(NormalWS):(-NormalWS)));
					float dotResult1476_g60691 = dot( switchResult1501_g60691 , ViewDirWS );
					float4 lerpResult1480_g60691 = lerp( lerpResult1473_g60691 , float4( 1,1,1,0 ) , pow( ( 1.0 - saturate( dotResult1476_g60691 ) ) , 5.0 ));
					float4 Fresnel1560_g60691 = lerpResult1480_g60691;
					float4 Fresnel1_g60743 = Fresnel1560_g60691;
					float UseGeometricAA1_g60743 = _UseGeometricAA;
					float3 localIndirectGeometricSpecular1_g60743 = IndirectGeometricSpecular1_g60743( WorldPos1_g60743 , WorldNormal1_g60743 , ViewDir1_g60743 , Smoothness1_g60743 , Fresnel1_g60743 , UseGeometricAA1_g60743 );
					float3 temp_output_2493_0_g60691 = localIndirectGeometricSpecular1_g60743;
					float4 temp_cast_7 = (0.02).xxxx;
					float4 temp_cast_8 = (0.1).xxxx;
					float4 smoothstepResult2430_g60691 = smoothstep( temp_cast_7 , temp_cast_8 , Lightmap46_g60691);
					#ifdef _USELIGHTMAPSPECULAR_ON
					float4 staticSwitch1469_g60691 = ( float4( temp_output_2493_0_g60691 , 0.0 ) * smoothstepResult2430_g60691 );
					#else
					float4 staticSwitch1469_g60691 = float4( temp_output_2493_0_g60691 , 0.0 );
					#endif
					float4 Specular1419_g60691 = staticSwitch1469_g60691;
					float4 temp_cast_9 = (Black1185_g60691).xxxx;
					float2 temp_output_5_0_g60702 = UV02420_g60691;
					float2 UV633_g60702 = temp_output_5_0_g60702;
					float2 UV100_g60703 = UV633_g60702;
					float2 temp_output_51_0_g60703 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60703 * float2( 3.464,3.464 ) ) );
					float2 break55_g60703 = frac( temp_output_51_0_g60703 );
					float temp_output_56_0_g60703 = ( ( 1.0 - break55_g60703.x ) - break55_g60703.y );
					float2 temp_output_52_0_g60703 = floor( temp_output_51_0_g60703 );
					float2 temp_output_125_0_g60703 = ( temp_output_52_0_g60703 + float2( 1,1 ) );
					float2 ifLocalVar87_g60703 = 0;
					if( temp_output_56_0_g60703 > 0.0 )
					ifLocalVar87_g60703 = temp_output_52_0_g60703;
					else if( temp_output_56_0_g60703 == 0.0 )
					ifLocalVar87_g60703 = temp_output_125_0_g60703;
					else if( temp_output_56_0_g60703 < 0.0 )
					ifLocalVar87_g60703 = temp_output_125_0_g60703;
					float3 temp_output_7_0_g60704 = frac( ( (ifLocalVar87_g60703).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60704 = dot( temp_output_7_0_g60704 , ( (temp_output_7_0_g60704).yzx + 33.33 ) );
					float3 temp_output_12_0_g60704 = ( temp_output_7_0_g60704 + dotResult8_g60704 );
					float2 temp_output_597_0_g60702 = ( UV100_g60703 + frac( ( ( (temp_output_12_0_g60704).xx + (temp_output_12_0_g60704).yz ) * (temp_output_12_0_g60704).zy ) ) );
					float2 DDX631_g60702 = ddx( temp_output_5_0_g60702 );
					float2 DDY632_g60702 = ddy( temp_output_5_0_g60702 );
					float temp_output_65_0_g60703 = ( 0.0 - temp_output_56_0_g60703 );
					float ifLocalVar59_g60703 = 0;
					if( temp_output_56_0_g60703 <= 0.0 )
					ifLocalVar59_g60703 = temp_output_65_0_g60703;
					else
					ifLocalVar59_g60703 = temp_output_56_0_g60703;
					float temp_output_597_30_g60702 = ifLocalVar59_g60703;
					float2 temp_output_90_0_g60703 = ( temp_output_52_0_g60703 + float2( 0,1 ) );
					float2 temp_output_123_0_g60703 = ( temp_output_52_0_g60703 + float2( 1,0 ) );
					float2 ifLocalVar88_g60703 = 0;
					if( temp_output_56_0_g60703 > 0.0 )
					ifLocalVar88_g60703 = temp_output_90_0_g60703;
					else if( temp_output_56_0_g60703 == 0.0 )
					ifLocalVar88_g60703 = temp_output_123_0_g60703;
					else if( temp_output_56_0_g60703 < 0.0 )
					ifLocalVar88_g60703 = temp_output_123_0_g60703;
					float3 temp_output_7_0_g60705 = frac( ( (ifLocalVar88_g60703).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60705 = dot( temp_output_7_0_g60705 , ( (temp_output_7_0_g60705).yzx + 33.33 ) );
					float3 temp_output_12_0_g60705 = ( temp_output_7_0_g60705 + dotResult8_g60705 );
					float2 temp_output_597_26_g60702 = ( UV100_g60703 + frac( ( ( (temp_output_12_0_g60705).xx + (temp_output_12_0_g60705).yz ) * (temp_output_12_0_g60705).zy ) ) );
					float temp_output_66_0_g60703 = ( 1.0 - break55_g60703.y );
					float ifLocalVar60_g60703 = 0;
					if( temp_output_56_0_g60703 <= 0.0 )
					ifLocalVar60_g60703 = temp_output_66_0_g60703;
					else
					ifLocalVar60_g60703 = break55_g60703.y;
					float temp_output_597_28_g60702 = ifLocalVar60_g60703;
					float2 ifLocalVar89_g60703 = 0;
					if( temp_output_56_0_g60703 > 0.0 )
					ifLocalVar89_g60703 = temp_output_123_0_g60703;
					else if( temp_output_56_0_g60703 == 0.0 )
					ifLocalVar89_g60703 = temp_output_90_0_g60703;
					else if( temp_output_56_0_g60703 < 0.0 )
					ifLocalVar89_g60703 = temp_output_90_0_g60703;
					float3 temp_output_7_0_g60706 = frac( ( (ifLocalVar89_g60703).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60706 = dot( temp_output_7_0_g60706 , ( (temp_output_7_0_g60706).yzx + 33.33 ) );
					float3 temp_output_12_0_g60706 = ( temp_output_7_0_g60706 + dotResult8_g60706 );
					float2 temp_output_597_27_g60702 = ( UV100_g60703 + frac( ( ( (temp_output_12_0_g60706).xx + (temp_output_12_0_g60706).yz ) * (temp_output_12_0_g60706).zy ) ) );
					float temp_output_67_0_g60703 = ( 1.0 - break55_g60703.x );
					float ifLocalVar61_g60703 = 0;
					if( temp_output_56_0_g60703 <= 0.0 )
					ifLocalVar61_g60703 = temp_output_67_0_g60703;
					else
					ifLocalVar61_g60703 = break55_g60703.x;
					float temp_output_597_29_g60702 = ifLocalVar61_g60703;
					float4 Output_2D293_g60702 = ( ( tex2D( _EmissionMap, temp_output_597_0_g60702, DDX631_g60702, DDY632_g60702 ) * temp_output_597_30_g60702 ) + ( tex2D( _EmissionMap, temp_output_597_26_g60702, DDX631_g60702, DDY632_g60702 ) * temp_output_597_28_g60702 ) + ( tex2D( _EmissionMap, temp_output_597_27_g60702, DDX631_g60702, DDY632_g60702 ) * temp_output_597_29_g60702 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g60691 = Output_2D293_g60702;
					#else
					float4 staticSwitch1006_g60691 = tex2D( _EmissionMap, UV02420_g60691 );
					#endif
					#if defined( _SPECIALEFFECTS_DISABLED )
					float4 staticSwitch1578_g60691 = staticSwitch1006_g60691;
					#elif defined( _SPECIALEFFECTS_LED )
					float4 staticSwitch1578_g60691 = float4( 0,0,0,0 );
					#else
					float4 staticSwitch1578_g60691 = staticSwitch1006_g60691;
					#endif
					#ifdef _EMISSIONENABLED_ON
					float4 staticSwitch1017_g60691 = ( float4( _EmissionColor , 0.0 ) * staticSwitch1578_g60691 * _EmissionIntensity );
					#else
					float4 staticSwitch1017_g60691 = temp_cast_9;
					#endif
					float4 Emission86_g60691 = staticSwitch1017_g60691;
					float3 WorldPos97_g60744 = PositionWS;
					float3 tanNormal85_g60744 = Normal_Map700_g60691;
					float3 worldNormal85_g60744 = float3( dot( tanToWorld0, tanNormal85_g60744 ), dot( tanToWorld1, tanNormal85_g60744 ), dot( tanToWorld2, tanNormal85_g60744 ) );
					float3 WorldNormal97_g60744 = worldNormal85_g60744;
					float Smoothness97_g60744 = Smoothness1399_g60691;
					float3 LightmapColor97_g60744 = Lightmap46_g60691.rgb;
					float3 ViewDir97_g60744 = ViewDirWS;
					float3 localSpecular97_g60744 = Specular( WorldPos97_g60744 , WorldNormal97_g60744 , Smoothness97_g60744 , LightmapColor97_g60744 , ViewDir97_g60744 );
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1181_g60691 = Lightmap46_g60691;
					#else
					float4 staticSwitch1181_g60691 = ( ( aAlbedo1466_g60691 * Lightmap46_g60691 ) + Specular1419_g60691 + Emission86_g60691 + float4( localSpecular97_g60744 , 0.0 ) );
					#endif
					float4 temp_output_35_0_g60713 = staticSwitch1181_g60691;
					float4 Color353_g60713 = temp_output_35_0_g60713;
					#if defined( _LUTMODE_2D )
					float4 staticSwitch273_g60713 = saturate( temp_output_35_0_g60713 );
					#elif defined( _LUTMODE_3D )
					float4 staticSwitch273_g60713 = temp_output_35_0_g60713;
					#else
					float4 staticSwitch273_g60713 = temp_output_35_0_g60713;
					#endif
					float4 Color_Saturate49_g60713 = staticSwitch273_g60713;
					float Lut_Height213_g60713 = _LUTSize;
					float Lut_Width216_g60713 = ( _LUTSize * Lut_Height213_g60713 );
					float3 appendResult214_g60713 = (float3(( 1.0 / Lut_Width216_g60713 ) , ( 1.0 / Lut_Height213_g60713 ) , ( Lut_Height213_g60713 - 1.0 )));
					float3 Scale_Offset208_g60713 = appendResult214_g60713;
					float2 Scale_Factor292_g60713 = ( (Scale_Offset208_g60713).xy * (Scale_Offset208_g60713).z );
					float2 Offset299_g60713 = ( (Scale_Offset208_g60713).xy * 0.5 );
					float3 Adjusted_UV305_g60713 = ( ( (Color_Saturate49_g60713).xyw * float3( Scale_Factor292_g60713 ,  0.0 ) ) + float3( Offset299_g60713 ,  0.0 ) );
					float2 Scaled_Blue280_g60713 = ( (Color_Saturate49_g60713).zw * (Scale_Offset208_g60713).z );
					float2 Shift288_g60713 = floor( Scaled_Blue280_g60713 );
					float2 Final_X313_g60713 = ( (Adjusted_UV305_g60713).xz + ( Shift288_g60713 * (Scale_Offset208_g60713).y ) );
					float2 appendResult326_g60713 = (float2(Final_X313_g60713.x , (Adjusted_UV305_g60713).yz.x));
					float2 Final_UV325_g60713 = appendResult326_g60713;
					float2 appendResult338_g60713 = (float2((Scale_Offset208_g60713).y , 0.0));
					float2 Offset_UV336_g60713 = ( Final_UV325_g60713 + appendResult338_g60713 );
					float3 lerpResult333_g60713 = lerp( tex2D( _2DLut, Final_UV325_g60713 ).rgb , tex2D( _2DLut, Offset_UV336_g60713 ).rgb , float3( ( Scaled_Blue280_g60713 - Shift288_g60713 ) ,  0.0 ));
					#ifdef _2DLUT
					float4 staticSwitch347_g60713 = float4( lerpResult333_g60713 , 0.0 );
					#else
					float4 staticSwitch347_g60713 = Color_Saturate49_g60713;
					#endif
					float4 TwoD_LUT346_g60713 = staticSwitch347_g60713;
					float3 RGB16_g60714 = ( ( log10( ( ( Color_Saturate49_g60713.xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 );
					#ifdef _3DLUT
					float4 staticSwitch194_g60713 = tex3D( _3DLut, RGB16_g60714 );
					#else
					float4 staticSwitch194_g60713 = Color_Saturate49_g60713;
					#endif
					float4 ThreeD_LUT51_g60713 = staticSwitch194_g60713;
					#if defined( _LUTMODE_2D )
					float4 staticSwitch42_g60713 = TwoD_LUT346_g60713;
					#elif defined( _LUTMODE_3D )
					float4 staticSwitch42_g60713 = ThreeD_LUT51_g60713;
					#else
					float4 staticSwitch42_g60713 = ThreeD_LUT51_g60713;
					#endif
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch41_g60713 = staticSwitch42_g60713;
					#else
					float4 staticSwitch41_g60713 = Color353_g60713;
					#endif
					

					o.Albedo = staticSwitch1180_g60691.rgb;
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

					o.Emission = staticSwitch41_g60713.xyz;
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
				
				Name "ShadowCaster"
				Tags { "LightMode"="ShadowCaster" }
				ZWrite On
				ZTest LEqual
				AlphaToMask Off

				CGPROGRAM
				#define ASE_GEOMETRY
				#define ASE_FRAGMENT_NORMAL 0
				#define ASE_RECEIVE_SHADOWS
				#pragma multi_compile_instancing
				#pragma multi_compile _ LOD_FADE_CROSSFADE
				#define _SPECULARHIGHLIGHTS_OFF
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
				uniform float _CATEGORYSPACESURFACEOPTIONS;
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
				uniform float _UdonSpecularLightCount;
				uniform float4 _UdonSpecularLightUp[32];
				uniform float4 _UdonSpecularLightRight[32];
				uniform float4 _UdonSpecularLightCol[32];
				uniform float4 _UdonSpecularLightPos[32];


				
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

					

					o.Normal = half3( 0, 0, 1 );

					o.Alpha = 1;
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
				#define _SPECULARHIGHLIGHTS_OFF
				#define ASE_NO_AMBIENT 1
				#define ASE_LIGHTING_SIMPLE 1
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
				uniform float _CATEGORYSPACESURFACEOPTIONS;
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
				uniform float _UdonSpecularLightCount;
				uniform float4 _UdonSpecularLightUp[32];
				uniform float4 _UdonSpecularLightRight[32];
				uniform float4 _UdonSpecularLightCol[32];
				uniform float4 _UdonSpecularLightPos[32];


				
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
				#define _SPECULARHIGHLIGHTS_OFF
				#define ASE_NO_AMBIENT 1
				#define ASE_LIGHTING_SIMPLE 1
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
				uniform float _CATEGORYSPACESURFACEOPTIONS;
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
				uniform float _UdonSpecularLightCount;
				uniform float4 _UdonSpecularLightUp[32];
				uniform float4 _UdonSpecularLightRight[32];
				uniform float4 _UdonSpecularLightCol[32];
				uniform float4 _UdonSpecularLightPos[32];


				
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
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5444;-144,-1280;Inherit;False;Meenphie;0;;60691;b3ba55a08dd6b49c7be16c6f35cf2033;1,1008,0;0;5;COLOR;625;FLOAT4;624;FLOAT;156;FLOAT;427;FLOAT3;1024
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5279;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;11;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5280;256,-1280;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;12;Meenphie/Standard/Opaque;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardBase;0;1;ForwardBase;17;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;True;True;0;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;44;Category;0;0;  Instanced Terrain Normals;1;0;Workflow;3;639079749420714040;Surface;0;0;  Blend;0;0;  Dither Shadows;1;0;Two Sided;1;0;Alpha Clipping;0;0;  Use Shadow Threshold;0;0;Deferred Pass;0;639079951064078170;Normal Space;0;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;1;0;Receive Shadows;1;0;Receive Specular;0;639079748971954060;Receive Reflections;1;639079891103345210;GPU Instancing;1;0;LOD CrossFade;1;0;Built-in Fog;0;639079749092523460;Ambient Light;0;639079749088921010;Meta Pass;0;639079749085366090;Add Pass;0;639079749082074320;Override Baked GI;0;0;Write Depth;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;0;Vertex Position;1;0;0;8;False;True;False;False;False;True;True;True;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5281;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;11;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;True;1;LightMode=ForwardAdd;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5282;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;11;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5283;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;11;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5284;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;11;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5285;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;11;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5286;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;11;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ScenePickingPass;0;7;ScenePickingPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=Picking;False;False;0;;0;0;Standard;0;False;0
WireConnection;5280;0;5444;625
WireConnection;5280;2;5444;624
ASEEND*/
//CHKSM=072FE01F7F8A394930126A4BDA458A1622D059DB