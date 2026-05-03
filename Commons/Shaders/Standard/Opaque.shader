// Made with Amplify Shader Editor v1.9.9.9
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
				#define ASE_VERSION 19909

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
				sampler2D _Sampler82966_g62256;
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				sampler2D _Sampler82967_g62256;
				uniform sampler2D _Lightmap0;
				float4 _Lightmap0_TexelSize;
				uniform sampler2D _Lightmap1;
				float4 _Lightmap1_TexelSize;
				uniform float _UdonLightmapLerp;
				uniform sampler2D _BumpMap;
				sampler2D _Sampler82965_g62256;
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
				sampler2D _Sampler82968_g62256;
				uniform float _EmissionIntensity;
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				sampler2D _Sampler82964_g62256;
				uniform float _IOR;


				float3 IndirectSpecular1_g62306( float3 Color, float Metallic, float Smoothness, float IOR, float3 Fresnel, float3 WorldPos, float3 WorldNormal, float3 ViewDir )
				{
					// --- 0. PARAMETERS ---
					float maxMip = 6.0;
					// --- 1. VECTORS ---
					float3 N     = normalize(WorldNormal);
					float3 V     = normalize(ViewDir);
					float3 R     = reflect(-V, N);
					float  nDotV = saturate(dot(N, V));
					// --- 2. BOX PROJECTION ---
					float3 ray = R;
					[branch]
					if (unity_SpecCube0_ProbePosition.w > 0.0) {
					    float3 safeRay  = max(abs(ray), 1e-5) * sign(ray);
					    float3 rbMax    = (unity_SpecCube0_BoxMax.xyz - WorldPos) / safeRay;
					    float3 rbMin    = (unity_SpecCube0_BoxMin.xyz - WorldPos) / safeRay;
					    float3 rbMinMax = (ray > 0) ? rbMax : rbMin;
					    float  fa       = min(min(rbMinMax.x, rbMinMax.y), rbMinMax.z);
					    ray = ray * fa + (WorldPos - unity_SpecCube0_ProbePosition.xyz);
					}
					// --- 3. F0 (IOR-BASED) ---
					float  iorTerm = (IOR - 1.0) / (IOR + 1.0);
					float  f0_base = iorTerm * iorTerm;
					float3 F0      = lerp(f0_base.xxx, Color.rgb, Metallic);
					// --- 4. ROUGHNESS (PERCEPTUAL) ---
					// Utilisation directe de la rugosité perçue (1 - Smoothness)
					float perceptualRoughness = saturate(1.0 - Smoothness);
					// --- 5. MIP MAPPING ---
					// Le seuil d'angle réduit le flou excessif sur les angles rasants
					float angleThreshold = smoothstep(0.0, 0.1, nDotV);
					float mipLevel       = clamp(perceptualRoughness * angleThreshold * maxMip, 0.0, maxMip);
					// --- 6. FRESNEL PBR ---
					// Approximation de Schlick pour les réflexions indirectes
					// Utilisation d'un float3 pour la compatibilité maximale
					float3 F = F0 + (max(float3(Smoothness, Smoothness, Smoothness), F0) - F0) * pow(1.0 - nDotV, 5.0);
					// --- 7. SAMPLING ---
					// Échantillonnage du CubeMap avec le niveau de MIP calculé
					float4 sampleCube   = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, ray, mipLevel);
					float3 indirectSpec = DecodeHDR(sampleCube, unity_SpecCube0_HDR);
					// Résultat final modulé par le Fresnel
					return indirectSpec * F;
				}
				
				float3 DirectSpecular( float3 Color, float3 LightmapColor, float Metallic, float Smoothness, float SmoothnessAA, float IOR, float3 Fresnel, float3 WorldPos, float3 WorldNormal, float3 ViewDir )
				{
					// --- CONFIGURATION ---
					static const float lumaStart     = 0.05;
					static const float lumaEnd       = 1.0;
					static const float specBoost     = 0.02;
					static const float specClamp     = 10.0;
					static const float metalBrightness = 10.0;
					static const float metalPeakMax = 2.0;
					#if defined(SHADER_API_MOBILE)
					    static const float maxVisibleDist = 8.0;
					#else
					    static const float maxVisibleDist = 16.0;
					#endif
					static const float invMaxVisibleDist = 1.0 / maxVisibleDist;
					// --- INIT ---
					float3 N    = normalize(WorldNormal);
					float3 vDir = normalize(ViewDir);
					float3 R    = reflect(-vDir, N);
					// --- LIGHTMAP MASK ---
					float luma   = dot(LightmapColor, float3(0.2126, 0.7152, 0.0722));
					float lmMask = saturate((luma - lumaStart) / max(lumaEnd - lumaStart, 1e-4));
					if (lmMask * Smoothness < 0.0001 || _UdonSpecularLightCount < 0.5) return 0.0;
					// --- ROUGHNESS & AA LOGIC ---
					// 1. Original artist intent
					float roughnessOrig = 1.0 - Smoothness;
					float alphaOrig     = roughnessOrig * roughnessOrig;
					float alpha2Orig    = max(alphaOrig * alphaOrig, 0.0001);
					// 2. Geometric AA roughness (prevents flickering, used for lobe shape)
					float roughnessAA = 1.0 - SmoothnessAA;
					float alphaAA     = roughnessAA * roughnessAA;
					float alpha2AA    = max(alphaAA * alphaAA, 0.0001);
					// 3. Metal brightness control
					// Raw ratio grows unboundedly at distance as AA crushes smoothness harder.
					// sqrt() compresses the curve so distant surfaces don't over-brighten,
					// then clamp to metalPeakMax as a hard safety ceiling.
					float peakRatio          = min(sqrt(alpha2AA / alpha2Orig), metalPeakMax);
					float metalPeakBoost     = lerp(0.0, peakRatio, metalBrightness);
					float energyCompensation = lerp(1.0, metalPeakBoost, Metallic);
					// 4. Perceptual falloff (dielectrics only)
					// Metals bypass this — their intensity is owned by energyCompensation above
					float logCurve  = 1.0 - sqrt(roughnessOrig);
					float finalFade = lerp(logCurve, 1.0, Metallic);
					// --- SPECULAR LOOP ---
					float  nDotV     = max(dot(N, vDir), 1e-4);
					float3 specAccum = 0;
					int    loopCount = (int)_UdonSpecularLightCount;
					for (int i = 0; i < loopCount; i++) {
					    float4 posRange = _UdonSpecularLightPos[i];
					    // Distance fade
					    float camDist      = distance(_WorldSpaceCameraPos, posRange.xyz);
					    float distanceFade = saturate(1.0 - (camDist * invMaxVisibleDist));
					    if (distanceFade <= 0.0) continue;
					    float3 L_vector = posRange.xyz - WorldPos;
					    float  distSq   = dot(L_vector, L_vector);
					    float4 dirAngle = _UdonSpecularLightDir[i];
					    float3 L_norm   = L_vector * rsqrt(max(distSq, 1e-6));
					    // Spot mask
					    float spotMask = saturate((dot(-L_norm, dirAngle.xyz) - dirAngle.w) / max(0.01, 1.0 - dirAngle.w));
					    if (spotMask <= 0.0) continue;
					    float3 diff     = 0;
					    float  rectMask = 1.0;
					    float2 halfSize = float2(_UdonSpecularLightRight[i].w, _UdonSpecularLightUp[i].w);
					    [branch]
					    if (dirAngle.w < -0.9) {
					        diff = L_vector;
					    }
					    else {
					        // MRP area light
					        float denom  = dot(dirAngle.xyz, R);
					        float tPlane = dot(L_vector, dirAngle.xyz) / (abs(denom) < 1e-4 ? 1e-4 : denom);
					        if (tPlane <= 0.0) continue;
					        float3 pReflection = WorldPos + R * tPlane;
					        float3 lp          = pReflection - posRange.xyz;
					        float2 localP      = float2(dot(lp, _UdonSpecularLightRight[i].xyz),
					        dot(lp, _UdonSpecularLightUp[i].xyz));
					        float2 clampedPos  = clamp(localP, -halfSize, halfSize);
					        diff = posRange.xyz
					        + _UdonSpecularLightRight[i].xyz * clampedPos.x
					        + _UdonSpecularLightUp[i].xyz    * clampedPos.y
					        - WorldPos;
					        // Rectangle mask — softness follows AA roughness
					        float  softness   = max(0.1, roughnessAA * 2.0);
					        float2 distToEdge = abs(localP) - halfSize;
					        rectMask = smoothstep(softness, 0.0, length(max(distToEdge, 0.0)));
					    }
					    if (rectMask <= 0.0) continue;
					    float  dSqDiff = dot(diff, diff);
					    float3 lDir    = diff * rsqrt(max(dSqDiff, 1e-6));
					    float3 H       = normalize(lDir + vDir);
					    float nDotH = saturate(dot(N, H));
					    float nDotL = saturate(dot(N, lDir));
					    // GGX NDF — AA lobe shape for everyone
					    float d_denom = nDotH * nDotH * (alpha2AA - 1.0) + 1.0;
					    float D       = alpha2AA / (3.14159 * d_denom * d_denom + 1e-7);
					    // Smith visibility — consistent with AA alpha
					    float k  = alphaAA * 0.5;
					    float Gv = nDotV / (nDotV * (1.0 - k) + k);
					    float Gl = nDotL / (nDotL * (1.0 - k) + k);
					    float G  = Gv * Gl;
					    // Cook-Torrance, no Fresnel — handled externally
					    float3 spec = (D * G) / max(4.0 * nDotV * nDotL, 0.001);
					    // Accumulate — max(0) guards against negatives
					    specAccum += max(0.0, _UdonSpecularLightCol[i].rgb
					    * _UdonSpecularLightCol[i].w
					    * spec
					    * nDotL
					    * spotMask
					    * distanceFade
					    * rectMask);
					}
					// --- FINAL ---
					float3 colorTint = lerp(1.0, Color.rgb, Metallic);
					float3 result = specAccum * colorTint * lmMask * specBoost * finalFade * energyCompensation;
					float resLuma = dot(result, float3(0.2126, 0.7152, 0.0722));
					result *= min(1.0, specClamp / max(resLuma, 1e-4));
					return result;
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

					float2 texCoord2357_g62256 = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0A2420_g62256 = texCoord2357_g62256;
					#ifdef _MAINTEX
					float4 staticSwitch1549_g62256 = tex2D( _MainTex, UV0A2420_g62256 );
					#else
					float4 staticSwitch1549_g62256 = _Color;
					#endif
					float2 temp_output_5_0_g62282 = UV0A2420_g62256;
					float2 UV633_g62282 = temp_output_5_0_g62282;
					float2 UV100_g62283 = UV633_g62282;
					float2 temp_output_51_0_g62283 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g62283 * float2( 3.464,3.464 ) ) );
					float2 break55_g62283 = frac( temp_output_51_0_g62283 );
					float temp_output_56_0_g62283 = ( ( 1.0 - break55_g62283.x ) - break55_g62283.y );
					float2 temp_output_52_0_g62283 = floor( temp_output_51_0_g62283 );
					float2 temp_output_125_0_g62283 = ( temp_output_52_0_g62283 + float2( 1,1 ) );
					float2 ifLocalVar87_g62283 = 0;
					if( temp_output_56_0_g62283 > 0.0 )
					ifLocalVar87_g62283 = temp_output_52_0_g62283;
					else if( temp_output_56_0_g62283 == 0.0 )
					ifLocalVar87_g62283 = temp_output_125_0_g62283;
					else if( temp_output_56_0_g62283 < 0.0 )
					ifLocalVar87_g62283 = temp_output_125_0_g62283;
					float3 temp_output_7_0_g62284 = frac( ( (ifLocalVar87_g62283).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g62284 = dot( temp_output_7_0_g62284 , ( (temp_output_7_0_g62284).yzx + 33.33 ) );
					float3 temp_output_12_0_g62284 = ( temp_output_7_0_g62284 + dotResult8_g62284 );
					float2 temp_output_597_0_g62282 = ( UV100_g62283 + frac( ( ( (temp_output_12_0_g62284).xx + (temp_output_12_0_g62284).yz ) * (temp_output_12_0_g62284).zy ) ) );
					float2 DDX631_g62282 = ddx( temp_output_5_0_g62282 );
					float2 DDY632_g62282 = ddy( temp_output_5_0_g62282 );
					float temp_output_65_0_g62283 = ( 0.0 - temp_output_56_0_g62283 );
					float ifLocalVar59_g62283 = 0;
					if( temp_output_56_0_g62283 <= 0.0 )
					ifLocalVar59_g62283 = temp_output_65_0_g62283;
					else
					ifLocalVar59_g62283 = temp_output_56_0_g62283;
					float temp_output_597_30_g62282 = ifLocalVar59_g62283;
					float2 temp_output_90_0_g62283 = ( temp_output_52_0_g62283 + float2( 0,1 ) );
					float2 temp_output_123_0_g62283 = ( temp_output_52_0_g62283 + float2( 1,0 ) );
					float2 ifLocalVar88_g62283 = 0;
					if( temp_output_56_0_g62283 > 0.0 )
					ifLocalVar88_g62283 = temp_output_90_0_g62283;
					else if( temp_output_56_0_g62283 == 0.0 )
					ifLocalVar88_g62283 = temp_output_123_0_g62283;
					else if( temp_output_56_0_g62283 < 0.0 )
					ifLocalVar88_g62283 = temp_output_123_0_g62283;
					float3 temp_output_7_0_g62285 = frac( ( (ifLocalVar88_g62283).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g62285 = dot( temp_output_7_0_g62285 , ( (temp_output_7_0_g62285).yzx + 33.33 ) );
					float3 temp_output_12_0_g62285 = ( temp_output_7_0_g62285 + dotResult8_g62285 );
					float2 temp_output_597_26_g62282 = ( UV100_g62283 + frac( ( ( (temp_output_12_0_g62285).xx + (temp_output_12_0_g62285).yz ) * (temp_output_12_0_g62285).zy ) ) );
					float temp_output_66_0_g62283 = ( 1.0 - break55_g62283.y );
					float ifLocalVar60_g62283 = 0;
					if( temp_output_56_0_g62283 <= 0.0 )
					ifLocalVar60_g62283 = temp_output_66_0_g62283;
					else
					ifLocalVar60_g62283 = break55_g62283.y;
					float temp_output_597_28_g62282 = ifLocalVar60_g62283;
					float2 ifLocalVar89_g62283 = 0;
					if( temp_output_56_0_g62283 > 0.0 )
					ifLocalVar89_g62283 = temp_output_123_0_g62283;
					else if( temp_output_56_0_g62283 == 0.0 )
					ifLocalVar89_g62283 = temp_output_90_0_g62283;
					else if( temp_output_56_0_g62283 < 0.0 )
					ifLocalVar89_g62283 = temp_output_90_0_g62283;
					float3 temp_output_7_0_g62286 = frac( ( (ifLocalVar89_g62283).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g62286 = dot( temp_output_7_0_g62286 , ( (temp_output_7_0_g62286).yzx + 33.33 ) );
					float3 temp_output_12_0_g62286 = ( temp_output_7_0_g62286 + dotResult8_g62286 );
					float2 temp_output_597_27_g62282 = ( UV100_g62283 + frac( ( ( (temp_output_12_0_g62286).xx + (temp_output_12_0_g62286).yz ) * (temp_output_12_0_g62286).zy ) ) );
					float temp_output_67_0_g62283 = ( 1.0 - break55_g62283.x );
					float ifLocalVar61_g62283 = 0;
					if( temp_output_56_0_g62283 <= 0.0 )
					ifLocalVar61_g62283 = temp_output_67_0_g62283;
					else
					ifLocalVar61_g62283 = break55_g62283.x;
					float temp_output_597_29_g62282 = ifLocalVar61_g62283;
					float4 Output_2D293_g62282 = ( ( tex2D( _Sampler82966_g62256, temp_output_597_0_g62282, DDX631_g62282, DDY632_g62282 ) * temp_output_597_30_g62282 ) + ( tex2D( _Sampler82966_g62256, temp_output_597_26_g62282, DDX631_g62282, DDY632_g62282 ) * temp_output_597_28_g62282 ) + ( tex2D( _Sampler82966_g62256, temp_output_597_27_g62282, DDX631_g62282, DDY632_g62282 ) * temp_output_597_29_g62282 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g62256 = Output_2D293_g62282;
					#else
					float4 staticSwitch1001_g62256 = staticSwitch1549_g62256;
					#endif
					float3 temp_output_2532_0_g62256 = (staticSwitch1001_g62256).rgb;
					float3 oAlbedo6_g62256 = temp_output_2532_0_g62256;
					float Black1185_g62256 = 0.0;
					float3 temp_cast_0 = (Black1185_g62256).xxx;
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch1180_g62256 = temp_cast_0;
					#else
					float3 staticSwitch1180_g62256 = oAlbedo6_g62256;
					#endif
					
					#ifdef _METALLICMAP
					float staticSwitch846_g62256 = tex2D( _MetallicMap, UV0A2420_g62256 ).r;
					#else
					float staticSwitch846_g62256 = _Metallic;
					#endif
					float2 temp_output_5_0_g62277 = UV0A2420_g62256;
					float2 UV633_g62277 = temp_output_5_0_g62277;
					float2 UV100_g62278 = UV633_g62277;
					float2 temp_output_51_0_g62278 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g62278 * float2( 3.464,3.464 ) ) );
					float2 break55_g62278 = frac( temp_output_51_0_g62278 );
					float temp_output_56_0_g62278 = ( ( 1.0 - break55_g62278.x ) - break55_g62278.y );
					float2 temp_output_52_0_g62278 = floor( temp_output_51_0_g62278 );
					float2 temp_output_125_0_g62278 = ( temp_output_52_0_g62278 + float2( 1,1 ) );
					float2 ifLocalVar87_g62278 = 0;
					if( temp_output_56_0_g62278 > 0.0 )
					ifLocalVar87_g62278 = temp_output_52_0_g62278;
					else if( temp_output_56_0_g62278 == 0.0 )
					ifLocalVar87_g62278 = temp_output_125_0_g62278;
					else if( temp_output_56_0_g62278 < 0.0 )
					ifLocalVar87_g62278 = temp_output_125_0_g62278;
					float3 temp_output_7_0_g62279 = frac( ( (ifLocalVar87_g62278).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g62279 = dot( temp_output_7_0_g62279 , ( (temp_output_7_0_g62279).yzx + 33.33 ) );
					float3 temp_output_12_0_g62279 = ( temp_output_7_0_g62279 + dotResult8_g62279 );
					float2 temp_output_597_0_g62277 = ( UV100_g62278 + frac( ( ( (temp_output_12_0_g62279).xx + (temp_output_12_0_g62279).yz ) * (temp_output_12_0_g62279).zy ) ) );
					float2 DDX631_g62277 = ddx( temp_output_5_0_g62277 );
					float2 DDY632_g62277 = ddy( temp_output_5_0_g62277 );
					float temp_output_65_0_g62278 = ( 0.0 - temp_output_56_0_g62278 );
					float ifLocalVar59_g62278 = 0;
					if( temp_output_56_0_g62278 <= 0.0 )
					ifLocalVar59_g62278 = temp_output_65_0_g62278;
					else
					ifLocalVar59_g62278 = temp_output_56_0_g62278;
					float temp_output_597_30_g62277 = ifLocalVar59_g62278;
					float2 temp_output_90_0_g62278 = ( temp_output_52_0_g62278 + float2( 0,1 ) );
					float2 temp_output_123_0_g62278 = ( temp_output_52_0_g62278 + float2( 1,0 ) );
					float2 ifLocalVar88_g62278 = 0;
					if( temp_output_56_0_g62278 > 0.0 )
					ifLocalVar88_g62278 = temp_output_90_0_g62278;
					else if( temp_output_56_0_g62278 == 0.0 )
					ifLocalVar88_g62278 = temp_output_123_0_g62278;
					else if( temp_output_56_0_g62278 < 0.0 )
					ifLocalVar88_g62278 = temp_output_123_0_g62278;
					float3 temp_output_7_0_g62280 = frac( ( (ifLocalVar88_g62278).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g62280 = dot( temp_output_7_0_g62280 , ( (temp_output_7_0_g62280).yzx + 33.33 ) );
					float3 temp_output_12_0_g62280 = ( temp_output_7_0_g62280 + dotResult8_g62280 );
					float2 temp_output_597_26_g62277 = ( UV100_g62278 + frac( ( ( (temp_output_12_0_g62280).xx + (temp_output_12_0_g62280).yz ) * (temp_output_12_0_g62280).zy ) ) );
					float temp_output_66_0_g62278 = ( 1.0 - break55_g62278.y );
					float ifLocalVar60_g62278 = 0;
					if( temp_output_56_0_g62278 <= 0.0 )
					ifLocalVar60_g62278 = temp_output_66_0_g62278;
					else
					ifLocalVar60_g62278 = break55_g62278.y;
					float temp_output_597_28_g62277 = ifLocalVar60_g62278;
					float2 ifLocalVar89_g62278 = 0;
					if( temp_output_56_0_g62278 > 0.0 )
					ifLocalVar89_g62278 = temp_output_123_0_g62278;
					else if( temp_output_56_0_g62278 == 0.0 )
					ifLocalVar89_g62278 = temp_output_90_0_g62278;
					else if( temp_output_56_0_g62278 < 0.0 )
					ifLocalVar89_g62278 = temp_output_90_0_g62278;
					float3 temp_output_7_0_g62281 = frac( ( (ifLocalVar89_g62278).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g62281 = dot( temp_output_7_0_g62281 , ( (temp_output_7_0_g62281).yzx + 33.33 ) );
					float3 temp_output_12_0_g62281 = ( temp_output_7_0_g62281 + dotResult8_g62281 );
					float2 temp_output_597_27_g62277 = ( UV100_g62278 + frac( ( ( (temp_output_12_0_g62281).xx + (temp_output_12_0_g62281).yz ) * (temp_output_12_0_g62281).zy ) ) );
					float temp_output_67_0_g62278 = ( 1.0 - break55_g62278.x );
					float ifLocalVar61_g62278 = 0;
					if( temp_output_56_0_g62278 <= 0.0 )
					ifLocalVar61_g62278 = temp_output_67_0_g62278;
					else
					ifLocalVar61_g62278 = break55_g62278.x;
					float temp_output_597_29_g62277 = ifLocalVar61_g62278;
					float4 Output_2D293_g62277 = ( ( tex2D( _Sampler82967_g62256, temp_output_597_0_g62277, DDX631_g62277, DDY632_g62277 ) * temp_output_597_30_g62277 ) + ( tex2D( _Sampler82967_g62256, temp_output_597_26_g62277, DDX631_g62277, DDY632_g62277 ) * temp_output_597_28_g62277 ) + ( tex2D( _Sampler82967_g62256, temp_output_597_27_g62277, DDX631_g62277, DDY632_g62277 ) * temp_output_597_29_g62277 ) );
					float4 break31_g62277 = Output_2D293_g62277;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g62256 = break31_g62277.r;
					#else
					float staticSwitch1005_g62256 = staticSwitch846_g62256;
					#endif
					float Metallic1239_g62256 = staticSwitch1005_g62256;
					float3 aAlbedo1466_g62256 = ( temp_output_2532_0_g62256 * ( 1.0 - Metallic1239_g62256 ) );
					float White38_g62256 = 1.0;
					float4 temp_cast_1 = (White38_g62256).xxxx;
					float4 texCoord2426_g62256 = IN.ase_texcoord6;
					texCoord2426_g62256.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0B2361_g62256 = (texCoord2426_g62256).zw;
					float localBicubicPrepare2_g62265 = ( 0.0 );
					float2 Input_UV100_g62265 = UV0B2361_g62256;
					float2 UV2_g62265 = Input_UV100_g62265;
					float4 TexelSize2_g62265 = _Lightmap0_TexelSize;
					float2 UV02_g62265 = float2( 0,0 );
					float2 UV12_g62265 = float2( 0,0 );
					float2 UV22_g62265 = float2( 0,0 );
					float2 UV32_g62265 = float2( 0,0 );
					float W02_g62265 = 0;
					float W12_g62265 = 0;
					{
					{
					 UV2_g62265 = UV2_g62265 * TexelSize2_g62265.zw - 0.5;
					    float2 f = frac( UV2_g62265 );
					    UV2_g62265 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g62265.x - 0.5, UV2_g62265.x + 1.5, UV2_g62265.y - 0.5, UV2_g62265.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g62265.xyxy;
					    UV02_g62265 = off.xz;
					    UV12_g62265 = off.yz;
					    UV22_g62265 = off.xw;
					    UV32_g62265 = off.yw;
					    W02_g62265 = s.x / ( s.x + s.y );
					 W12_g62265 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g62265 = lerp( tex2D( _Lightmap0, UV32_g62265 ) , tex2D( _Lightmap0, UV22_g62265 ) , W02_g62265);
					float4 lerpResult45_g62265 = lerp( tex2D( _Lightmap0, UV12_g62265 ) , tex2D( _Lightmap0, UV02_g62265 ) , W02_g62265);
					float4 lerpResult44_g62265 = lerp( lerpResult46_g62265 , lerpResult45_g62265 , W12_g62265);
					float4 Output_2D_Auto131_g62265 = lerpResult44_g62265;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g62256 = Output_2D_Auto131_g62265;
					#else
					float4 staticSwitch1092_g62256 = float4( tex2D( _Lightmap0, UV0B2361_g62256 ).rgb , 0.0 );
					#endif
					float4 Lightmap_0925_g62256 = staticSwitch1092_g62256;
					float localBicubicPrepare2_g62263 = ( 0.0 );
					float2 Input_UV100_g62263 = UV0B2361_g62256;
					float2 UV2_g62263 = Input_UV100_g62263;
					float4 TexelSize2_g62263 = _Lightmap1_TexelSize;
					float2 UV02_g62263 = float2( 0,0 );
					float2 UV12_g62263 = float2( 0,0 );
					float2 UV22_g62263 = float2( 0,0 );
					float2 UV32_g62263 = float2( 0,0 );
					float W02_g62263 = 0;
					float W12_g62263 = 0;
					{
					{
					 UV2_g62263 = UV2_g62263 * TexelSize2_g62263.zw - 0.5;
					    float2 f = frac( UV2_g62263 );
					    UV2_g62263 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g62263.x - 0.5, UV2_g62263.x + 1.5, UV2_g62263.y - 0.5, UV2_g62263.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g62263.xyxy;
					    UV02_g62263 = off.xz;
					    UV12_g62263 = off.yz;
					    UV22_g62263 = off.xw;
					    UV32_g62263 = off.yw;
					    W02_g62263 = s.x / ( s.x + s.y );
					 W12_g62263 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g62263 = lerp( tex2D( _Lightmap1, UV32_g62263 ) , tex2D( _Lightmap1, UV22_g62263 ) , W02_g62263);
					float4 lerpResult45_g62263 = lerp( tex2D( _Lightmap1, UV12_g62263 ) , tex2D( _Lightmap1, UV02_g62263 ) , W02_g62263);
					float4 lerpResult44_g62263 = lerp( lerpResult46_g62263 , lerpResult45_g62263 , W12_g62263);
					float4 Output_2D_Auto131_g62263 = lerpResult44_g62263;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g62256 = Output_2D_Auto131_g62263;
					#else
					float4 staticSwitch1088_g62256 = tex2D( _Lightmap1, UV0B2361_g62256 );
					#endif
					float4 Lightmap_1956_g62256 = staticSwitch1088_g62256;
					float Lightmap_Lerp_Value969_g62256 = _UdonLightmapLerp;
					float4 lerpResult442_g62256 = lerp( Lightmap_0925_g62256 , Lightmap_1956_g62256 , Lightmap_Lerp_Value969_g62256);
					float4 Lightmap_Lerp932_g62256 = lerpResult442_g62256;
					float3 appendResult139_g62302 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float2 temp_output_5_0_g62272 = UV0A2420_g62256;
					float2 UV633_g62272 = temp_output_5_0_g62272;
					float2 UV100_g62273 = UV633_g62272;
					float2 temp_output_51_0_g62273 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g62273 * float2( 3.464,3.464 ) ) );
					float2 break55_g62273 = frac( temp_output_51_0_g62273 );
					float temp_output_56_0_g62273 = ( ( 1.0 - break55_g62273.x ) - break55_g62273.y );
					float2 temp_output_52_0_g62273 = floor( temp_output_51_0_g62273 );
					float2 temp_output_125_0_g62273 = ( temp_output_52_0_g62273 + float2( 1,1 ) );
					float2 ifLocalVar87_g62273 = 0;
					if( temp_output_56_0_g62273 > 0.0 )
					ifLocalVar87_g62273 = temp_output_52_0_g62273;
					else if( temp_output_56_0_g62273 == 0.0 )
					ifLocalVar87_g62273 = temp_output_125_0_g62273;
					else if( temp_output_56_0_g62273 < 0.0 )
					ifLocalVar87_g62273 = temp_output_125_0_g62273;
					float3 temp_output_7_0_g62274 = frac( ( (ifLocalVar87_g62273).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g62274 = dot( temp_output_7_0_g62274 , ( (temp_output_7_0_g62274).yzx + 33.33 ) );
					float3 temp_output_12_0_g62274 = ( temp_output_7_0_g62274 + dotResult8_g62274 );
					float2 temp_output_597_0_g62272 = ( UV100_g62273 + frac( ( ( (temp_output_12_0_g62274).xx + (temp_output_12_0_g62274).yz ) * (temp_output_12_0_g62274).zy ) ) );
					float2 DDX631_g62272 = ddx( temp_output_5_0_g62272 );
					float2 DDY632_g62272 = ddy( temp_output_5_0_g62272 );
					float Input_Scale617_g62272 = 1.5;
					float temp_output_65_0_g62273 = ( 0.0 - temp_output_56_0_g62273 );
					float ifLocalVar59_g62273 = 0;
					if( temp_output_56_0_g62273 <= 0.0 )
					ifLocalVar59_g62273 = temp_output_65_0_g62273;
					else
					ifLocalVar59_g62273 = temp_output_56_0_g62273;
					float temp_output_597_30_g62272 = ifLocalVar59_g62273;
					float2 temp_output_90_0_g62273 = ( temp_output_52_0_g62273 + float2( 0,1 ) );
					float2 temp_output_123_0_g62273 = ( temp_output_52_0_g62273 + float2( 1,0 ) );
					float2 ifLocalVar88_g62273 = 0;
					if( temp_output_56_0_g62273 > 0.0 )
					ifLocalVar88_g62273 = temp_output_90_0_g62273;
					else if( temp_output_56_0_g62273 == 0.0 )
					ifLocalVar88_g62273 = temp_output_123_0_g62273;
					else if( temp_output_56_0_g62273 < 0.0 )
					ifLocalVar88_g62273 = temp_output_123_0_g62273;
					float3 temp_output_7_0_g62275 = frac( ( (ifLocalVar88_g62273).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g62275 = dot( temp_output_7_0_g62275 , ( (temp_output_7_0_g62275).yzx + 33.33 ) );
					float3 temp_output_12_0_g62275 = ( temp_output_7_0_g62275 + dotResult8_g62275 );
					float2 temp_output_597_26_g62272 = ( UV100_g62273 + frac( ( ( (temp_output_12_0_g62275).xx + (temp_output_12_0_g62275).yz ) * (temp_output_12_0_g62275).zy ) ) );
					float temp_output_66_0_g62273 = ( 1.0 - break55_g62273.y );
					float ifLocalVar60_g62273 = 0;
					if( temp_output_56_0_g62273 <= 0.0 )
					ifLocalVar60_g62273 = temp_output_66_0_g62273;
					else
					ifLocalVar60_g62273 = break55_g62273.y;
					float temp_output_597_28_g62272 = ifLocalVar60_g62273;
					float2 ifLocalVar89_g62273 = 0;
					if( temp_output_56_0_g62273 > 0.0 )
					ifLocalVar89_g62273 = temp_output_123_0_g62273;
					else if( temp_output_56_0_g62273 == 0.0 )
					ifLocalVar89_g62273 = temp_output_90_0_g62273;
					else if( temp_output_56_0_g62273 < 0.0 )
					ifLocalVar89_g62273 = temp_output_90_0_g62273;
					float3 temp_output_7_0_g62276 = frac( ( (ifLocalVar89_g62273).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g62276 = dot( temp_output_7_0_g62276 , ( (temp_output_7_0_g62276).yzx + 33.33 ) );
					float3 temp_output_12_0_g62276 = ( temp_output_7_0_g62276 + dotResult8_g62276 );
					float2 temp_output_597_27_g62272 = ( UV100_g62273 + frac( ( ( (temp_output_12_0_g62276).xx + (temp_output_12_0_g62276).yz ) * (temp_output_12_0_g62276).zy ) ) );
					float temp_output_67_0_g62273 = ( 1.0 - break55_g62273.x );
					float ifLocalVar61_g62273 = 0;
					if( temp_output_56_0_g62273 <= 0.0 )
					ifLocalVar61_g62273 = temp_output_67_0_g62273;
					else
					ifLocalVar61_g62273 = break55_g62273.x;
					float temp_output_597_29_g62272 = ifLocalVar61_g62273;
					float3 Output_2D_Normal641_g62272 = ( ( UnpackScaleNormal( tex2D( _Sampler82965_g62256, temp_output_597_0_g62272, DDX631_g62272, DDY632_g62272 ), Input_Scale617_g62272 ) * temp_output_597_30_g62272 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g62256, temp_output_597_26_g62272, DDX631_g62272, DDY632_g62272 ), Input_Scale617_g62272 ) * temp_output_597_28_g62272 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g62256, temp_output_597_27_g62272, DDX631_g62272, DDY632_g62272 ), Input_Scale617_g62272 ) * float3( 0,0,0 ) * temp_output_597_29_g62272 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g62256 = Output_2D_Normal641_g62272;
					#else
					float3 staticSwitch1003_g62256 = UnpackScaleNormal( tex2D( _BumpMap, UV0A2420_g62256 ), 1.5 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g62256 = staticSwitch1003_g62256;
					#else
					float3 staticSwitch980_g62256 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g62256 = staticSwitch980_g62256;
					float3 normalizeResult326_g62302 = normalize( Normal_Map700_g62256 );
					float3 Normal_Map318_g62302 = normalizeResult326_g62302;
					float dotResult121_g62302 = dot( appendResult139_g62302 , Normal_Map318_g62302 );
					float temp_output_2_0_g62304 = saturate( dotResult121_g62302 );
					float localStochasticTiling2_g62298 = ( 0.0 );
					float2 UV2_g62298 = UV0B2361_g62256;
					float4 TexelSize2_g62298 = _UdonRNMX0_TexelSize;
					float4 Offsets2_g62298 = float4( 0,0,0,0 );
					float2 Weights2_g62298 = float2( 0,0 );
					{
					UV2_g62298 = UV2_g62298 * TexelSize2_g62298.zw - 0.5;
					float2 f = frac( UV2_g62298 );
					UV2_g62298 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g62298.x - 0.5, UV2_g62298.x + 1.5, UV2_g62298.y - 0.5, UV2_g62298.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g62298 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g62298.xyxy;
					Weights2_g62298 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g62297 = Offsets2_g62298;
					float4 Input_FetchOffsets197_g62299 = temp_output_1_34_g62297;
					float2 temp_output_1_54_g62297 = Weights2_g62298;
					float2 Input_FetchWeights200_g62299 = temp_output_1_54_g62297;
					float2 break187_g62299 = Input_FetchWeights200_g62299;
					float4 lerpResult181_g62299 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g62299).yw ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g62299).xw ) , break187_g62299.x);
					float4 lerpResult182_g62299 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g62299).yz ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g62299).xz ) , break187_g62299.x);
					float4 lerpResult176_g62299 = lerp( lerpResult181_g62299 , lerpResult182_g62299 , break187_g62299.y);
					float4 Output_Fetch2D_Auto202_g62299 = lerpResult176_g62299;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g62256 = Output_Fetch2D_Auto202_g62299;
					#else
					float4 staticSwitch1061_g62256 = tex2D( _UdonRNMX0, UV0B2361_g62256 );
					#endif
					float3 appendResult146_g62302 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g62302 = dot( appendResult146_g62302 , Normal_Map318_g62302 );
					float temp_output_2_0_g62303 = saturate( dotResult122_g62302 );
					float4 Input_FetchOffsets197_g62300 = temp_output_1_34_g62297;
					float2 Input_FetchWeights200_g62300 = temp_output_1_54_g62297;
					float2 break187_g62300 = Input_FetchWeights200_g62300;
					float4 lerpResult181_g62300 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g62300).yw ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g62300).xw ) , break187_g62300.x);
					float4 lerpResult182_g62300 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g62300).yz ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g62300).xz ) , break187_g62300.x);
					float4 lerpResult176_g62300 = lerp( lerpResult181_g62300 , lerpResult182_g62300 , break187_g62300.y);
					float4 Output_Fetch2D_Auto202_g62300 = lerpResult176_g62300;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g62256 = Output_Fetch2D_Auto202_g62300;
					#else
					float4 staticSwitch1062_g62256 = tex2D( _UdonRNMY0, UV0B2361_g62256 );
					#endif
					float3 appendResult149_g62302 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g62302 = dot( appendResult149_g62302 , Normal_Map318_g62302 );
					float temp_output_2_0_g62305 = saturate( dotResult120_g62302 );
					float4 Input_FetchOffsets197_g62301 = temp_output_1_34_g62297;
					float2 Input_FetchWeights200_g62301 = temp_output_1_54_g62297;
					float2 break187_g62301 = Input_FetchWeights200_g62301;
					float4 lerpResult181_g62301 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g62301).yw ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g62301).xw ) , break187_g62301.x);
					float4 lerpResult182_g62301 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g62301).yz ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g62301).xz ) , break187_g62301.x);
					float4 lerpResult176_g62301 = lerp( lerpResult181_g62301 , lerpResult182_g62301 , break187_g62301.y);
					float4 Output_Fetch2D_Auto202_g62301 = lerpResult176_g62301;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g62256 = Output_Fetch2D_Auto202_g62301;
					#else
					float4 staticSwitch1063_g62256 = tex2D( _UdonRNMZ0, UV0B2361_g62256 );
					#endif
					float4 RNM_0926_g62256 = ( ( ( ( ( temp_output_2_0_g62304 * temp_output_2_0_g62304 ) * staticSwitch1061_g62256 ) + ( ( temp_output_2_0_g62303 * temp_output_2_0_g62303 ) * staticSwitch1062_g62256 ) ) + ( ( temp_output_2_0_g62305 * temp_output_2_0_g62305 ) * staticSwitch1063_g62256 ) ) * 1.5 );
					float3 appendResult139_g62268 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g62268 = normalize( Normal_Map700_g62256 );
					float3 Normal_Map318_g62268 = normalizeResult326_g62268;
					float dotResult121_g62268 = dot( appendResult139_g62268 , Normal_Map318_g62268 );
					float temp_output_2_0_g62270 = saturate( dotResult121_g62268 );
					float localStochasticTiling2_g62258 = ( 0.0 );
					float2 UV2_g62258 = UV0B2361_g62256;
					float4 TexelSize2_g62258 = _UdonRNMX1_TexelSize;
					float4 Offsets2_g62258 = float4( 0,0,0,0 );
					float2 Weights2_g62258 = float2( 0,0 );
					{
					UV2_g62258 = UV2_g62258 * TexelSize2_g62258.zw - 0.5;
					float2 f = frac( UV2_g62258 );
					UV2_g62258 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g62258.x - 0.5, UV2_g62258.x + 1.5, UV2_g62258.y - 0.5, UV2_g62258.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g62258 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g62258.xyxy;
					Weights2_g62258 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g62257 = Offsets2_g62258;
					float4 Input_FetchOffsets197_g62259 = temp_output_1_34_g62257;
					float2 temp_output_1_54_g62257 = Weights2_g62258;
					float2 Input_FetchWeights200_g62259 = temp_output_1_54_g62257;
					float2 break187_g62259 = Input_FetchWeights200_g62259;
					float4 lerpResult181_g62259 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g62259).yw ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g62259).xw ) , break187_g62259.x);
					float4 lerpResult182_g62259 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g62259).yz ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g62259).xz ) , break187_g62259.x);
					float4 lerpResult176_g62259 = lerp( lerpResult181_g62259 , lerpResult182_g62259 , break187_g62259.y);
					float4 Output_Fetch2D_Auto202_g62259 = lerpResult176_g62259;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g62256 = Output_Fetch2D_Auto202_g62259;
					#else
					float4 staticSwitch1087_g62256 = tex2D( _UdonRNMX1, UV0B2361_g62256 );
					#endif
					float3 appendResult146_g62268 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g62268 = dot( appendResult146_g62268 , Normal_Map318_g62268 );
					float temp_output_2_0_g62269 = saturate( dotResult122_g62268 );
					float4 Input_FetchOffsets197_g62260 = temp_output_1_34_g62257;
					float2 Input_FetchWeights200_g62260 = temp_output_1_54_g62257;
					float2 break187_g62260 = Input_FetchWeights200_g62260;
					float4 lerpResult181_g62260 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g62260).yw ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g62260).xw ) , break187_g62260.x);
					float4 lerpResult182_g62260 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g62260).yz ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g62260).xz ) , break187_g62260.x);
					float4 lerpResult176_g62260 = lerp( lerpResult181_g62260 , lerpResult182_g62260 , break187_g62260.y);
					float4 Output_Fetch2D_Auto202_g62260 = lerpResult176_g62260;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g62256 = Output_Fetch2D_Auto202_g62260;
					#else
					float4 staticSwitch1083_g62256 = tex2D( _UdonRNMY1, UV0B2361_g62256 );
					#endif
					float3 appendResult149_g62268 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g62268 = dot( appendResult149_g62268 , Normal_Map318_g62268 );
					float temp_output_2_0_g62271 = saturate( dotResult120_g62268 );
					float4 Input_FetchOffsets197_g62261 = temp_output_1_34_g62257;
					float2 Input_FetchWeights200_g62261 = temp_output_1_54_g62257;
					float2 break187_g62261 = Input_FetchWeights200_g62261;
					float4 lerpResult181_g62261 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g62261).yw ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g62261).xw ) , break187_g62261.x);
					float4 lerpResult182_g62261 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g62261).yz ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g62261).xz ) , break187_g62261.x);
					float4 lerpResult176_g62261 = lerp( lerpResult181_g62261 , lerpResult182_g62261 , break187_g62261.y);
					float4 Output_Fetch2D_Auto202_g62261 = lerpResult176_g62261;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g62256 = Output_Fetch2D_Auto202_g62261;
					#else
					float4 staticSwitch1084_g62256 = tex2D( _UdonRNMZ1, UV0B2361_g62256 );
					#endif
					float4 RNM_11081_g62256 = ( ( ( ( ( temp_output_2_0_g62270 * temp_output_2_0_g62270 ) * staticSwitch1087_g62256 ) + ( ( temp_output_2_0_g62269 * temp_output_2_0_g62269 ) * staticSwitch1083_g62256 ) ) + ( ( temp_output_2_0_g62271 * temp_output_2_0_g62271 ) * staticSwitch1084_g62256 ) ) * 1.5 );
					float4 lerpResult953_g62256 = lerp( RNM_0926_g62256 , RNM_11081_g62256 , Lightmap_Lerp_Value969_g62256);
					float4 RNM_Lerp950_g62256 = lerpResult953_g62256;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g62256 = temp_cast_1;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g62256 = Lightmap_0925_g62256;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g62256 = Lightmap_Lerp932_g62256;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g62256 = RNM_0926_g62256;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g62256 = RNM_Lerp950_g62256;
					#else
					float4 staticSwitch1014_g62256 = temp_cast_1;
					#endif
					float3 Lightmap46_g62256 = (staticSwitch1014_g62256).rgb;
					float2 temp_output_5_0_g62292 = UV0A2420_g62256;
					float2 UV633_g62292 = temp_output_5_0_g62292;
					float2 UV100_g62293 = UV633_g62292;
					float2 temp_output_51_0_g62293 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g62293 * float2( 3.464,3.464 ) ) );
					float2 break55_g62293 = frac( temp_output_51_0_g62293 );
					float temp_output_56_0_g62293 = ( ( 1.0 - break55_g62293.x ) - break55_g62293.y );
					float2 temp_output_52_0_g62293 = floor( temp_output_51_0_g62293 );
					float2 temp_output_125_0_g62293 = ( temp_output_52_0_g62293 + float2( 1,1 ) );
					float2 ifLocalVar87_g62293 = 0;
					if( temp_output_56_0_g62293 > 0.0 )
					ifLocalVar87_g62293 = temp_output_52_0_g62293;
					else if( temp_output_56_0_g62293 == 0.0 )
					ifLocalVar87_g62293 = temp_output_125_0_g62293;
					else if( temp_output_56_0_g62293 < 0.0 )
					ifLocalVar87_g62293 = temp_output_125_0_g62293;
					float3 temp_output_7_0_g62294 = frac( ( (ifLocalVar87_g62293).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g62294 = dot( temp_output_7_0_g62294 , ( (temp_output_7_0_g62294).yzx + 33.33 ) );
					float3 temp_output_12_0_g62294 = ( temp_output_7_0_g62294 + dotResult8_g62294 );
					float2 temp_output_597_0_g62292 = ( UV100_g62293 + frac( ( ( (temp_output_12_0_g62294).xx + (temp_output_12_0_g62294).yz ) * (temp_output_12_0_g62294).zy ) ) );
					float2 DDX631_g62292 = ddx( temp_output_5_0_g62292 );
					float2 DDY632_g62292 = ddy( temp_output_5_0_g62292 );
					float temp_output_65_0_g62293 = ( 0.0 - temp_output_56_0_g62293 );
					float ifLocalVar59_g62293 = 0;
					if( temp_output_56_0_g62293 <= 0.0 )
					ifLocalVar59_g62293 = temp_output_65_0_g62293;
					else
					ifLocalVar59_g62293 = temp_output_56_0_g62293;
					float temp_output_597_30_g62292 = ifLocalVar59_g62293;
					float2 temp_output_90_0_g62293 = ( temp_output_52_0_g62293 + float2( 0,1 ) );
					float2 temp_output_123_0_g62293 = ( temp_output_52_0_g62293 + float2( 1,0 ) );
					float2 ifLocalVar88_g62293 = 0;
					if( temp_output_56_0_g62293 > 0.0 )
					ifLocalVar88_g62293 = temp_output_90_0_g62293;
					else if( temp_output_56_0_g62293 == 0.0 )
					ifLocalVar88_g62293 = temp_output_123_0_g62293;
					else if( temp_output_56_0_g62293 < 0.0 )
					ifLocalVar88_g62293 = temp_output_123_0_g62293;
					float3 temp_output_7_0_g62295 = frac( ( (ifLocalVar88_g62293).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g62295 = dot( temp_output_7_0_g62295 , ( (temp_output_7_0_g62295).yzx + 33.33 ) );
					float3 temp_output_12_0_g62295 = ( temp_output_7_0_g62295 + dotResult8_g62295 );
					float2 temp_output_597_26_g62292 = ( UV100_g62293 + frac( ( ( (temp_output_12_0_g62295).xx + (temp_output_12_0_g62295).yz ) * (temp_output_12_0_g62295).zy ) ) );
					float temp_output_66_0_g62293 = ( 1.0 - break55_g62293.y );
					float ifLocalVar60_g62293 = 0;
					if( temp_output_56_0_g62293 <= 0.0 )
					ifLocalVar60_g62293 = temp_output_66_0_g62293;
					else
					ifLocalVar60_g62293 = break55_g62293.y;
					float temp_output_597_28_g62292 = ifLocalVar60_g62293;
					float2 ifLocalVar89_g62293 = 0;
					if( temp_output_56_0_g62293 > 0.0 )
					ifLocalVar89_g62293 = temp_output_123_0_g62293;
					else if( temp_output_56_0_g62293 == 0.0 )
					ifLocalVar89_g62293 = temp_output_90_0_g62293;
					else if( temp_output_56_0_g62293 < 0.0 )
					ifLocalVar89_g62293 = temp_output_90_0_g62293;
					float3 temp_output_7_0_g62296 = frac( ( (ifLocalVar89_g62293).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g62296 = dot( temp_output_7_0_g62296 , ( (temp_output_7_0_g62296).yzx + 33.33 ) );
					float3 temp_output_12_0_g62296 = ( temp_output_7_0_g62296 + dotResult8_g62296 );
					float2 temp_output_597_27_g62292 = ( UV100_g62293 + frac( ( ( (temp_output_12_0_g62296).xx + (temp_output_12_0_g62296).yz ) * (temp_output_12_0_g62296).zy ) ) );
					float temp_output_67_0_g62293 = ( 1.0 - break55_g62293.x );
					float ifLocalVar61_g62293 = 0;
					if( temp_output_56_0_g62293 <= 0.0 )
					ifLocalVar61_g62293 = temp_output_67_0_g62293;
					else
					ifLocalVar61_g62293 = break55_g62293.x;
					float temp_output_597_29_g62292 = ifLocalVar61_g62293;
					float4 Output_2D293_g62292 = ( ( tex2D( _Sampler82968_g62256, temp_output_597_0_g62292, DDX631_g62292, DDY632_g62292 ) * temp_output_597_30_g62292 ) + ( tex2D( _Sampler82968_g62256, temp_output_597_26_g62292, DDX631_g62292, DDY632_g62292 ) * temp_output_597_28_g62292 ) + ( tex2D( _Sampler82968_g62256, temp_output_597_27_g62292, DDX631_g62292, DDY632_g62292 ) * temp_output_597_29_g62292 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g62256 = Output_2D293_g62292;
					#else
					float4 staticSwitch1006_g62256 = tex2D( _EmissionMap, UV0A2420_g62256 );
					#endif
					float3 temp_output_2531_0_g62256 = (( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g62256 * _EmissionIntensity )).rgb;
					float3 Emission86_g62256 = temp_output_2531_0_g62256;
					float3 Color1_g62306 = oAlbedo6_g62256;
					float Metallic1_g62306 = Metallic1239_g62256;
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g62256 = tex2D( _GlossinessMap, UV0A2420_g62256 ).r;
					#else
					float staticSwitch845_g62256 = _Glossiness;
					#endif
					float2 temp_output_5_0_g62287 = UV0A2420_g62256;
					float2 UV633_g62287 = temp_output_5_0_g62287;
					float2 UV100_g62288 = UV633_g62287;
					float2 temp_output_51_0_g62288 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g62288 * float2( 3.464,3.464 ) ) );
					float2 break55_g62288 = frac( temp_output_51_0_g62288 );
					float temp_output_56_0_g62288 = ( ( 1.0 - break55_g62288.x ) - break55_g62288.y );
					float2 temp_output_52_0_g62288 = floor( temp_output_51_0_g62288 );
					float2 temp_output_125_0_g62288 = ( temp_output_52_0_g62288 + float2( 1,1 ) );
					float2 ifLocalVar87_g62288 = 0;
					if( temp_output_56_0_g62288 > 0.0 )
					ifLocalVar87_g62288 = temp_output_52_0_g62288;
					else if( temp_output_56_0_g62288 == 0.0 )
					ifLocalVar87_g62288 = temp_output_125_0_g62288;
					else if( temp_output_56_0_g62288 < 0.0 )
					ifLocalVar87_g62288 = temp_output_125_0_g62288;
					float3 temp_output_7_0_g62289 = frac( ( (ifLocalVar87_g62288).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g62289 = dot( temp_output_7_0_g62289 , ( (temp_output_7_0_g62289).yzx + 33.33 ) );
					float3 temp_output_12_0_g62289 = ( temp_output_7_0_g62289 + dotResult8_g62289 );
					float2 temp_output_597_0_g62287 = ( UV100_g62288 + frac( ( ( (temp_output_12_0_g62289).xx + (temp_output_12_0_g62289).yz ) * (temp_output_12_0_g62289).zy ) ) );
					float2 DDX631_g62287 = ddx( temp_output_5_0_g62287 );
					float2 DDY632_g62287 = ddy( temp_output_5_0_g62287 );
					float temp_output_65_0_g62288 = ( 0.0 - temp_output_56_0_g62288 );
					float ifLocalVar59_g62288 = 0;
					if( temp_output_56_0_g62288 <= 0.0 )
					ifLocalVar59_g62288 = temp_output_65_0_g62288;
					else
					ifLocalVar59_g62288 = temp_output_56_0_g62288;
					float temp_output_597_30_g62287 = ifLocalVar59_g62288;
					float2 temp_output_90_0_g62288 = ( temp_output_52_0_g62288 + float2( 0,1 ) );
					float2 temp_output_123_0_g62288 = ( temp_output_52_0_g62288 + float2( 1,0 ) );
					float2 ifLocalVar88_g62288 = 0;
					if( temp_output_56_0_g62288 > 0.0 )
					ifLocalVar88_g62288 = temp_output_90_0_g62288;
					else if( temp_output_56_0_g62288 == 0.0 )
					ifLocalVar88_g62288 = temp_output_123_0_g62288;
					else if( temp_output_56_0_g62288 < 0.0 )
					ifLocalVar88_g62288 = temp_output_123_0_g62288;
					float3 temp_output_7_0_g62290 = frac( ( (ifLocalVar88_g62288).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g62290 = dot( temp_output_7_0_g62290 , ( (temp_output_7_0_g62290).yzx + 33.33 ) );
					float3 temp_output_12_0_g62290 = ( temp_output_7_0_g62290 + dotResult8_g62290 );
					float2 temp_output_597_26_g62287 = ( UV100_g62288 + frac( ( ( (temp_output_12_0_g62290).xx + (temp_output_12_0_g62290).yz ) * (temp_output_12_0_g62290).zy ) ) );
					float temp_output_66_0_g62288 = ( 1.0 - break55_g62288.y );
					float ifLocalVar60_g62288 = 0;
					if( temp_output_56_0_g62288 <= 0.0 )
					ifLocalVar60_g62288 = temp_output_66_0_g62288;
					else
					ifLocalVar60_g62288 = break55_g62288.y;
					float temp_output_597_28_g62287 = ifLocalVar60_g62288;
					float2 ifLocalVar89_g62288 = 0;
					if( temp_output_56_0_g62288 > 0.0 )
					ifLocalVar89_g62288 = temp_output_123_0_g62288;
					else if( temp_output_56_0_g62288 == 0.0 )
					ifLocalVar89_g62288 = temp_output_90_0_g62288;
					else if( temp_output_56_0_g62288 < 0.0 )
					ifLocalVar89_g62288 = temp_output_90_0_g62288;
					float3 temp_output_7_0_g62291 = frac( ( (ifLocalVar89_g62288).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g62291 = dot( temp_output_7_0_g62291 , ( (temp_output_7_0_g62291).yzx + 33.33 ) );
					float3 temp_output_12_0_g62291 = ( temp_output_7_0_g62291 + dotResult8_g62291 );
					float2 temp_output_597_27_g62287 = ( UV100_g62288 + frac( ( ( (temp_output_12_0_g62291).xx + (temp_output_12_0_g62291).yz ) * (temp_output_12_0_g62291).zy ) ) );
					float temp_output_67_0_g62288 = ( 1.0 - break55_g62288.x );
					float ifLocalVar61_g62288 = 0;
					if( temp_output_56_0_g62288 <= 0.0 )
					ifLocalVar61_g62288 = temp_output_67_0_g62288;
					else
					ifLocalVar61_g62288 = break55_g62288.x;
					float temp_output_597_29_g62287 = ifLocalVar61_g62288;
					float4 Output_2D293_g62287 = ( ( tex2D( _Sampler82964_g62256, temp_output_597_0_g62287, DDX631_g62287, DDY632_g62287 ) * temp_output_597_30_g62287 ) + ( tex2D( _Sampler82964_g62256, temp_output_597_26_g62287, DDX631_g62287, DDY632_g62287 ) * temp_output_597_28_g62287 ) + ( tex2D( _Sampler82964_g62256, temp_output_597_27_g62287, DDX631_g62287, DDY632_g62287 ) * temp_output_597_29_g62287 ) );
					float4 break31_g62287 = Output_2D293_g62287;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g62256 = ( 1.0 - break31_g62287.r );
					#else
					float staticSwitch1004_g62256 = ( 1.0 - staticSwitch845_g62256 );
					#endif
					float temp_output_19_0_g62307 = staticSwitch1004_g62256;
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal2504_g62256 = Normal_Map700_g62256;
					float3 worldNormal2504_g62256 = normalize( float3( dot( tanToWorld0, tanNormal2504_g62256 ), dot( tanToWorld1, tanNormal2504_g62256 ), dot( tanToWorld2, tanNormal2504_g62256 ) ) );
					float3 World_Normal2508_g62256 = worldNormal2504_g62256;
					float3 tanNormal2_g62307 = World_Normal2508_g62256;
					float3 worldNormal2_g62307 = float3( dot( tanToWorld0, tanNormal2_g62307 ), dot( tanToWorld1, tanNormal2_g62307 ), dot( tanToWorld2, tanNormal2_g62307 ) );
					float3 temp_output_3_0_g62307 = ddx( worldNormal2_g62307 );
					float dotResult5_g62307 = dot( temp_output_3_0_g62307 , temp_output_3_0_g62307 );
					float3 temp_output_4_0_g62307 = ddy( worldNormal2_g62307 );
					float dotResult6_g62307 = dot( temp_output_4_0_g62307 , temp_output_4_0_g62307 );
					#ifdef _USEGEOMETRICAA_ON
					float staticSwitch15_g62307 = min( temp_output_19_0_g62307, ( 1.0 - pow( saturate( max( dotResult5_g62307, dotResult6_g62307 ) ) , 0.25 ) ) );
					#else
					float staticSwitch15_g62307 = temp_output_19_0_g62307;
					#endif
					float SmoothnessAA1399_g62256 = staticSwitch15_g62307;
					float Smoothness1_g62306 = SmoothnessAA1399_g62256;
					float IOR2700_g62256 = _IOR;
					float IOR1_g62306 = IOR2700_g62256;
					float3 temp_cast_4 = (0.04).xxx;
					float3 lerpResult1473_g62256 = lerp( temp_cast_4 , oAlbedo6_g62256 , Metallic1239_g62256);
					float3 switchResult1501_g62256 = (((ase_vface>0)?(World_Normal2508_g62256):(-World_Normal2508_g62256)));
					float3 View_Direction2511_g62256 = ViewDirWS;
					float dotResult1476_g62256 = dot( switchResult1501_g62256 , View_Direction2511_g62256 );
					float3 lerpResult1480_g62256 = lerp( lerpResult1473_g62256 , float3( 1,1,1 ) , pow( ( 1.0 - saturate( dotResult1476_g62256 ) ) , 5.0 ));
					float3 Fresnel1560_g62256 = lerpResult1480_g62256;
					float3 Fresnel1_g62306 = Fresnel1560_g62256;
					float3 World_Position2505_g62256 = PositionWS;
					float3 WorldPos1_g62306 = World_Position2505_g62256;
					float3 WorldNormal1_g62306 = World_Normal2508_g62256;
					float3 ViewDir1_g62306 = View_Direction2511_g62256;
					float3 localIndirectSpecular1_g62306 = IndirectSpecular1_g62306( Color1_g62306 , Metallic1_g62306 , Smoothness1_g62306 , IOR1_g62306 , Fresnel1_g62306 , WorldPos1_g62306 , WorldNormal1_g62306 , ViewDir1_g62306 );
					float3 temp_output_2805_0_g62256 = localIndirectSpecular1_g62306;
					float grayscale2713_g62256 = Luminance( Lightmap46_g62256 );
					float smoothstepResult2430_g62256 = smoothstep( 0.0 , 0.05 , grayscale2713_g62256);
					#ifdef _USELIGHTMAPPEDREFLECTIONS_ON
					float3 staticSwitch1469_g62256 = ( temp_output_2805_0_g62256 * smoothstepResult2430_g62256 );
					#else
					float3 staticSwitch1469_g62256 = temp_output_2805_0_g62256;
					#endif
					float3 Reflections1419_g62256 = staticSwitch1469_g62256;
					float3 Color97_g62308 = oAlbedo6_g62256;
					float3 LightmapColor97_g62308 = Lightmap46_g62256;
					float Metallic97_g62308 = Metallic1239_g62256;
					float Smoothness2838_g62256 = staticSwitch1004_g62256;
					float Smoothness97_g62308 = Smoothness2838_g62256;
					float SmoothnessAA97_g62308 = SmoothnessAA1399_g62256;
					float IOR97_g62308 = IOR2700_g62256;
					float3 Fresnel97_g62308 = Fresnel1560_g62256;
					float3 WorldPos97_g62308 = World_Position2505_g62256;
					float3 WorldNormal97_g62308 = World_Normal2508_g62256;
					float3 ViewDir97_g62308 = View_Direction2511_g62256;
					float3 localDirectSpecular97_g62308 = DirectSpecular( Color97_g62308 , LightmapColor97_g62308 , Metallic97_g62308 , Smoothness97_g62308 , SmoothnessAA97_g62308 , IOR97_g62308 , Fresnel97_g62308 , WorldPos97_g62308 , WorldNormal97_g62308 , ViewDir97_g62308 );
					float3 Speculars2560_g62256 = localDirectSpecular97_g62308;
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch1181_g62256 = Lightmap46_g62256;
					#else
					float3 staticSwitch1181_g62256 = ( ( aAlbedo1466_g62256 * Lightmap46_g62256 ) + Emission86_g62256 + Reflections1419_g62256 + Speculars2560_g62256 );
					#endif
					float3 temp_output_35_0_g62266 = staticSwitch1181_g62256;
					float3 Color353_g62266 = temp_output_35_0_g62266;
					#if defined( _LUTMODE_2D )
					float3 staticSwitch273_g62266 = saturate( temp_output_35_0_g62266 );
					#elif defined( _LUTMODE_3D )
					float3 staticSwitch273_g62266 = temp_output_35_0_g62266;
					#else
					float3 staticSwitch273_g62266 = temp_output_35_0_g62266;
					#endif
					float3 Color_Saturate49_g62266 = staticSwitch273_g62266;
					float Lut_Height213_g62266 = _LUTSize;
					float Lut_Width216_g62266 = ( _LUTSize * Lut_Height213_g62266 );
					float3 appendResult214_g62266 = (float3(( 1.0 / Lut_Width216_g62266 ) , ( 1.0 / Lut_Height213_g62266 ) , ( Lut_Height213_g62266 - 1.0 )));
					float3 Scale_Offset208_g62266 = appendResult214_g62266;
					float2 Scale_Factor292_g62266 = ( (Scale_Offset208_g62266).xy * (Scale_Offset208_g62266).z );
					float2 Offset299_g62266 = ( (Scale_Offset208_g62266).xy * 0.5 );
					float2 Adjusted_UV305_g62266 = ( ( (Color_Saturate49_g62266).xy * Scale_Factor292_g62266 ) + Offset299_g62266 );
					float Scaled_Blue280_g62266 = ( (Color_Saturate49_g62266).z * (Scale_Offset208_g62266).z );
					float Shift288_g62266 = floor( Scaled_Blue280_g62266 );
					float Final_X313_g62266 = ( (Adjusted_UV305_g62266).x + ( Shift288_g62266 * (Scale_Offset208_g62266).y ) );
					float2 appendResult326_g62266 = (float2(Final_X313_g62266 , (Adjusted_UV305_g62266).y));
					float2 Final_UV325_g62266 = appendResult326_g62266;
					float2 appendResult338_g62266 = (float2((Scale_Offset208_g62266).y , 0.0));
					float2 Offset_UV336_g62266 = ( Final_UV325_g62266 + appendResult338_g62266 );
					float3 lerpResult333_g62266 = lerp( tex2D( _2DLut, Final_UV325_g62266 ).rgb , tex2D( _2DLut, Offset_UV336_g62266 ).rgb , ( Scaled_Blue280_g62266 - Shift288_g62266 ));
					#ifdef _2DLUT
					float3 staticSwitch347_g62266 = lerpResult333_g62266;
					#else
					float3 staticSwitch347_g62266 = Color_Saturate49_g62266;
					#endif
					float3 TwoD_LUT346_g62266 = staticSwitch347_g62266;
					float3 RGB16_g62267 = ( ( log10( ( ( Color_Saturate49_g62266 * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 );
					#ifdef _3DLUT
					float3 staticSwitch194_g62266 = tex3D( _3DLut, RGB16_g62267 ).rgb;
					#else
					float3 staticSwitch194_g62266 = Color_Saturate49_g62266;
					#endif
					float3 ThreeD_LUT51_g62266 = staticSwitch194_g62266;
					#if defined( _LUTMODE_2D )
					float3 staticSwitch42_g62266 = TwoD_LUT346_g62266;
					#elif defined( _LUTMODE_3D )
					float3 staticSwitch42_g62266 = ThreeD_LUT51_g62266;
					#else
					float3 staticSwitch42_g62266 = ThreeD_LUT51_g62266;
					#endif
					#ifdef SHADER_API_MOBILE
					float3 staticSwitch41_g62266 = staticSwitch42_g62266;
					#else
					float3 staticSwitch41_g62266 = Color353_g62266;
					#endif
					

					o.Albedo = staticSwitch1180_g62256;
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

					o.Emission = staticSwitch41_g62266;
					o.Alpha = 1;
					half AlphaClipThreshold = 0.5;
					half AlphaClipThresholdShadow = 0.5;
					half3 BakedGI = 0;
					half3 Transmission = 1;
					half3 Translucency = 1;

					#if defined( ASE_DEPTH_WRITE_ON )
						IN.pos.z = IN.pos.z;
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
						outputDepth = IN.pos.z;
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
				#define ASE_VERSION 19909

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
						IN.pos.z = IN.pos.z;
					#endif

					#ifdef _ALPHATEST_ON
						clip( Alpha - AlphaClipThreshold );
					#endif

					#if defined( ASE_DEPTH_WRITE_ON )
						outputDepth = IN.pos.z;
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
				#define ASE_VERSION 19909

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
						IN.pos.z = IN.pos.z;
					#endif

					#ifdef _ALPHATEST_ON
						clip( Alpha - AlphaClipThreshold );
					#endif

					#if defined( ASE_DEPTH_WRITE_ON )
						outputDepth = IN.pos.z;
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
Version=19909
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;6042;0,-1280;Inherit;False;Meenphie;0;;62256;b3ba55a08dd6b49c7be16c6f35cf2033;6,1008,0,2632,0,2635,0,2636,0,2670,0,2619,0;0;5;FLOAT3;625;FLOAT3;624;FLOAT;156;FLOAT;427;FLOAT;1024
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5279;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;10;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5280;256,-1280;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;Meenphie/Standard/Opaque;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardBase;0;1;ForwardBase;17;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;44;Category;0;0;  Instanced Terrain Normals;1;0;Workflow;3;639079749420714040;Surface;0;0;  Blend;0;0;  Dither Shadows;1;0;Two Sided;1;0;Alpha Clipping;0;0;  Use Shadow Threshold;0;0;Deferred Pass;0;639079951064078170;Normal Space;0;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;0;639108440689538340;Receive Shadows;1;0;Receive Specular;0;639108440701916390;Receive Reflections;0;639108447998214750;GPU Instancing;1;0;LOD CrossFade;1;0;Built-in Fog;1;639105044169342440;Ambient Light;1;639111933610282130;Meta Pass;0;639111933576947160;Add Pass;0;639111933580732010;Override Baked GI;0;0;Write Depth;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;0;Vertex Position;1;0;0;8;False;True;False;False;False;False;True;True;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5281;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;10;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;True;1;LightMode=ForwardAdd;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5282;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;10;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5283;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;10;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5284;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;10;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5285;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;10;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5286;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;10;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ScenePickingPass;0;7;ScenePickingPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=Picking;False;False;0;;0;0;Standard;0;False;0
WireConnection;5280;0;6042;625
WireConnection;5280;2;6042;624
ASEEND*/
//CHKSM=CF9BF3D1B59222FA09E2D93836EFE1960383FD6A