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
		[NoScaleOffset][SingleLineTexture] _3DLut( "3D Lut", 3D ) = "black" {}
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACECOLORGRADING( "CATEGORY SPACE COLOR GRADING", Float ) = 0
		[Meenphie_DrawerCategory(SPECIAL EFFECTS,true,0,0)] _CATEGORYSPECIALEFFECTS( "CATEGORY SPECIAL EFFECTS", Float ) = 0
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESPECIALEFFECTS( "CATEGORY SPACE SPECIAL EFFECTS", Float ) = 0
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0
		[HideInInspector] GenKey__MetallicMap( "Assign keyword _METALLICMAP", Float ) = 1.0
		[HideInInspector] GenKey__MainTex( "Assign keyword _MAINTEX", Float ) = 1.0
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
				#define ASE_NEEDS_WORLD_TANGENT
				#define ASE_NEEDS_FRAG_WORLD_TANGENT
				#define ASE_NEEDS_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_BITANGENT
				#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
				#define ASE_NEEDS_WORLD_POSITION
				#define ASE_NEEDS_FRAG_WORLD_POSITION
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
				#pragma shader_feature _LIGHTMAPDEBUG
				#pragma shader_feature_local _STOCHASTICENABLED_ON
				#pragma shader_feature_local _MAINTEX
				#pragma shader_feature_local _USELIGHTMAPPEDREFLECTIONS_ON
				#pragma shader_feature_local _METALLICMAP
				#pragma shader_feature_local _USEGEOMETRICAA_ON
				#pragma shader_feature_local _GLOSSINESSMAP
				#pragma shader_feature_local _BUMPMAP
				#pragma shader_feature_local _LIGHTMAPMODE_DISABLED _LIGHTMAPMODE_SIMPLE _LIGHTMAPMODE_SIMPLELERP _LIGHTMAPMODE_RNM _LIGHTMAPMODE_RNMLERP
				#pragma shader_feature_local _USEBICUBICFILTERING_ON
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
				uniform float _CATEGORYSPACESURFACEOPTIONS;
				uniform float _UdonSpecularLightCount;
				uniform sampler3D _3DLut;
				uniform float4 _UdonSpecularLightUp[32];
				uniform float4 _UdonSpecularLightDir[32];
				uniform float4 _UdonSpecularLightCol[32];
				uniform float4 _UdonSpecularLightPos[32];
				uniform float4 _UdonSpecularLightRight[32];
				uniform half4 _Color;
				uniform sampler2D _MainTex;
				sampler2D _Sampler82966_g59824;
				uniform float3 _EmissionColor;
				uniform sampler2D _EmissionMap;
				sampler2D _Sampler82968_g59824;
				uniform float _EmissionIntensity;
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				sampler2D _Sampler82967_g59824;
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				sampler2D _Sampler82964_g59824;
				uniform sampler2D _BumpMap;
				sampler2D _Sampler82965_g59824;
				uniform float _IOR;
				uniform sampler2D _Lightmap0;
				float4 _Lightmap0_TexelSize;
				uniform sampler2D _Lightmap1;
				float4 _Lightmap1_TexelSize;
				uniform float _UdonLightmapLerp;
				uniform sampler2D _UdonRNMX0;
				float4 _UdonRNMX0_TexelSize;
				uniform sampler2D _UdonRNMY0;
				uniform sampler2D _UdonRNMZ0;
				uniform sampler2D _UdonRNMX1;
				float4 _UdonRNMX1_TexelSize;
				uniform sampler2D _UdonRNMY1;
				uniform sampler2D _UdonRNMZ1;


				float3 IndirectSpecular1_g59868( float3 Color, float Metallic, float Smoothness, float IOR, float3 Fresnel, float3 WorldPos, float3 WorldNormal, float3 ViewDir )
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
					float roughnessOrig       = 1.0 - Smoothness;
					float perceptualRoughness = saturate(roughnessOrig);
					// --- 5. MIP MAPPING ---
					float angleThreshold = smoothstep(0.0, 0.1, nDotV);
					float mipLevel       = clamp(perceptualRoughness * angleThreshold * maxMip, 0.0, maxMip);
					// --- 6. FRESNEL PBR ---
					float3 F = F0 + (max(float3(Smoothness, Smoothness, Smoothness), F0) - F0) * pow(1.0 - nDotV, 5.0);
					// --- 7. ATTENUATION ---
					float logCurve  = 1.0 - sqrt(roughnessOrig);
					float finalFade = lerp(logCurve, 1.0, Metallic);
					// --- 8. SAMPLING ---
					float4 sampleCube   = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, ray, mipLevel);
					float3 indirectSpec = DecodeHDR(sampleCube, unity_SpecCube0_HDR);
					return indirectSpec * F * finalFade;
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

					float2 texCoord2357_g59824 = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0A2420_g59824 = texCoord2357_g59824;
					#ifdef _MAINTEX
					float4 staticSwitch1549_g59824 = tex2D( _MainTex, UV0A2420_g59824 );
					#else
					float4 staticSwitch1549_g59824 = _Color;
					#endif
					float2 temp_output_5_0_g59843 = UV0A2420_g59824;
					float2 UV633_g59843 = temp_output_5_0_g59843;
					float2 UV100_g59844 = UV633_g59843;
					float2 temp_output_51_0_g59844 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59844 * float2( 3.464,3.464 ) ) );
					float2 break55_g59844 = frac( temp_output_51_0_g59844 );
					float temp_output_56_0_g59844 = ( ( 1.0 - break55_g59844.x ) - break55_g59844.y );
					float2 temp_output_52_0_g59844 = floor( temp_output_51_0_g59844 );
					float2 temp_output_125_0_g59844 = ( temp_output_52_0_g59844 + float2( 1,1 ) );
					float2 ifLocalVar87_g59844 = 0;
					if( temp_output_56_0_g59844 > 0.0 )
					ifLocalVar87_g59844 = temp_output_52_0_g59844;
					else if( temp_output_56_0_g59844 == 0.0 )
					ifLocalVar87_g59844 = temp_output_125_0_g59844;
					else if( temp_output_56_0_g59844 < 0.0 )
					ifLocalVar87_g59844 = temp_output_125_0_g59844;
					float3 temp_output_7_0_g59845 = frac( ( (ifLocalVar87_g59844).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59845 = dot( temp_output_7_0_g59845 , ( (temp_output_7_0_g59845).yzx + 33.33 ) );
					float3 temp_output_12_0_g59845 = ( temp_output_7_0_g59845 + dotResult8_g59845 );
					float2 temp_output_597_0_g59843 = ( UV100_g59844 + frac( ( ( (temp_output_12_0_g59845).xx + (temp_output_12_0_g59845).yz ) * (temp_output_12_0_g59845).zy ) ) );
					float2 DDX631_g59843 = ddx( temp_output_5_0_g59843 );
					float2 DDY632_g59843 = ddy( temp_output_5_0_g59843 );
					float temp_output_65_0_g59844 = ( 0.0 - temp_output_56_0_g59844 );
					float ifLocalVar59_g59844 = 0;
					if( temp_output_56_0_g59844 <= 0.0 )
					ifLocalVar59_g59844 = temp_output_65_0_g59844;
					else
					ifLocalVar59_g59844 = temp_output_56_0_g59844;
					float temp_output_597_30_g59843 = ifLocalVar59_g59844;
					float2 temp_output_90_0_g59844 = ( temp_output_52_0_g59844 + float2( 0,1 ) );
					float2 temp_output_123_0_g59844 = ( temp_output_52_0_g59844 + float2( 1,0 ) );
					float2 ifLocalVar88_g59844 = 0;
					if( temp_output_56_0_g59844 > 0.0 )
					ifLocalVar88_g59844 = temp_output_90_0_g59844;
					else if( temp_output_56_0_g59844 == 0.0 )
					ifLocalVar88_g59844 = temp_output_123_0_g59844;
					else if( temp_output_56_0_g59844 < 0.0 )
					ifLocalVar88_g59844 = temp_output_123_0_g59844;
					float3 temp_output_7_0_g59846 = frac( ( (ifLocalVar88_g59844).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59846 = dot( temp_output_7_0_g59846 , ( (temp_output_7_0_g59846).yzx + 33.33 ) );
					float3 temp_output_12_0_g59846 = ( temp_output_7_0_g59846 + dotResult8_g59846 );
					float2 temp_output_597_26_g59843 = ( UV100_g59844 + frac( ( ( (temp_output_12_0_g59846).xx + (temp_output_12_0_g59846).yz ) * (temp_output_12_0_g59846).zy ) ) );
					float temp_output_66_0_g59844 = ( 1.0 - break55_g59844.y );
					float ifLocalVar60_g59844 = 0;
					if( temp_output_56_0_g59844 <= 0.0 )
					ifLocalVar60_g59844 = temp_output_66_0_g59844;
					else
					ifLocalVar60_g59844 = break55_g59844.y;
					float temp_output_597_28_g59843 = ifLocalVar60_g59844;
					float2 ifLocalVar89_g59844 = 0;
					if( temp_output_56_0_g59844 > 0.0 )
					ifLocalVar89_g59844 = temp_output_123_0_g59844;
					else if( temp_output_56_0_g59844 == 0.0 )
					ifLocalVar89_g59844 = temp_output_90_0_g59844;
					else if( temp_output_56_0_g59844 < 0.0 )
					ifLocalVar89_g59844 = temp_output_90_0_g59844;
					float3 temp_output_7_0_g59847 = frac( ( (ifLocalVar89_g59844).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59847 = dot( temp_output_7_0_g59847 , ( (temp_output_7_0_g59847).yzx + 33.33 ) );
					float3 temp_output_12_0_g59847 = ( temp_output_7_0_g59847 + dotResult8_g59847 );
					float2 temp_output_597_27_g59843 = ( UV100_g59844 + frac( ( ( (temp_output_12_0_g59847).xx + (temp_output_12_0_g59847).yz ) * (temp_output_12_0_g59847).zy ) ) );
					float temp_output_67_0_g59844 = ( 1.0 - break55_g59844.x );
					float ifLocalVar61_g59844 = 0;
					if( temp_output_56_0_g59844 <= 0.0 )
					ifLocalVar61_g59844 = temp_output_67_0_g59844;
					else
					ifLocalVar61_g59844 = break55_g59844.x;
					float temp_output_597_29_g59843 = ifLocalVar61_g59844;
					float4 Output_2D293_g59843 = ( ( tex2D( _Sampler82966_g59824, temp_output_597_0_g59843, DDX631_g59843, DDY632_g59843 ) * temp_output_597_30_g59843 ) + ( tex2D( _Sampler82966_g59824, temp_output_597_26_g59843, DDX631_g59843, DDY632_g59843 ) * temp_output_597_28_g59843 ) + ( tex2D( _Sampler82966_g59824, temp_output_597_27_g59843, DDX631_g59843, DDY632_g59843 ) * temp_output_597_29_g59843 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g59824 = Output_2D293_g59843;
					#else
					float4 staticSwitch1001_g59824 = staticSwitch1549_g59824;
					#endif
					float3 temp_output_2532_0_g59824 = (staticSwitch1001_g59824).rgb;
					float3 oAlbedo6_g59824 = temp_output_2532_0_g59824;
					float Black1185_g59824 = 0.0;
					float3 temp_cast_0 = (Black1185_g59824).xxx;
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch1180_g59824 = temp_cast_0;
					#else
					float3 staticSwitch1180_g59824 = oAlbedo6_g59824;
					#endif
					
					float2 temp_output_5_0_g59853 = UV0A2420_g59824;
					float2 UV633_g59853 = temp_output_5_0_g59853;
					float2 UV100_g59854 = UV633_g59853;
					float2 temp_output_51_0_g59854 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59854 * float2( 3.464,3.464 ) ) );
					float2 break55_g59854 = frac( temp_output_51_0_g59854 );
					float temp_output_56_0_g59854 = ( ( 1.0 - break55_g59854.x ) - break55_g59854.y );
					float2 temp_output_52_0_g59854 = floor( temp_output_51_0_g59854 );
					float2 temp_output_125_0_g59854 = ( temp_output_52_0_g59854 + float2( 1,1 ) );
					float2 ifLocalVar87_g59854 = 0;
					if( temp_output_56_0_g59854 > 0.0 )
					ifLocalVar87_g59854 = temp_output_52_0_g59854;
					else if( temp_output_56_0_g59854 == 0.0 )
					ifLocalVar87_g59854 = temp_output_125_0_g59854;
					else if( temp_output_56_0_g59854 < 0.0 )
					ifLocalVar87_g59854 = temp_output_125_0_g59854;
					float3 temp_output_7_0_g59855 = frac( ( (ifLocalVar87_g59854).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59855 = dot( temp_output_7_0_g59855 , ( (temp_output_7_0_g59855).yzx + 33.33 ) );
					float3 temp_output_12_0_g59855 = ( temp_output_7_0_g59855 + dotResult8_g59855 );
					float2 temp_output_597_0_g59853 = ( UV100_g59854 + frac( ( ( (temp_output_12_0_g59855).xx + (temp_output_12_0_g59855).yz ) * (temp_output_12_0_g59855).zy ) ) );
					float2 DDX631_g59853 = ddx( temp_output_5_0_g59853 );
					float2 DDY632_g59853 = ddy( temp_output_5_0_g59853 );
					float temp_output_65_0_g59854 = ( 0.0 - temp_output_56_0_g59854 );
					float ifLocalVar59_g59854 = 0;
					if( temp_output_56_0_g59854 <= 0.0 )
					ifLocalVar59_g59854 = temp_output_65_0_g59854;
					else
					ifLocalVar59_g59854 = temp_output_56_0_g59854;
					float temp_output_597_30_g59853 = ifLocalVar59_g59854;
					float2 temp_output_90_0_g59854 = ( temp_output_52_0_g59854 + float2( 0,1 ) );
					float2 temp_output_123_0_g59854 = ( temp_output_52_0_g59854 + float2( 1,0 ) );
					float2 ifLocalVar88_g59854 = 0;
					if( temp_output_56_0_g59854 > 0.0 )
					ifLocalVar88_g59854 = temp_output_90_0_g59854;
					else if( temp_output_56_0_g59854 == 0.0 )
					ifLocalVar88_g59854 = temp_output_123_0_g59854;
					else if( temp_output_56_0_g59854 < 0.0 )
					ifLocalVar88_g59854 = temp_output_123_0_g59854;
					float3 temp_output_7_0_g59856 = frac( ( (ifLocalVar88_g59854).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59856 = dot( temp_output_7_0_g59856 , ( (temp_output_7_0_g59856).yzx + 33.33 ) );
					float3 temp_output_12_0_g59856 = ( temp_output_7_0_g59856 + dotResult8_g59856 );
					float2 temp_output_597_26_g59853 = ( UV100_g59854 + frac( ( ( (temp_output_12_0_g59856).xx + (temp_output_12_0_g59856).yz ) * (temp_output_12_0_g59856).zy ) ) );
					float temp_output_66_0_g59854 = ( 1.0 - break55_g59854.y );
					float ifLocalVar60_g59854 = 0;
					if( temp_output_56_0_g59854 <= 0.0 )
					ifLocalVar60_g59854 = temp_output_66_0_g59854;
					else
					ifLocalVar60_g59854 = break55_g59854.y;
					float temp_output_597_28_g59853 = ifLocalVar60_g59854;
					float2 ifLocalVar89_g59854 = 0;
					if( temp_output_56_0_g59854 > 0.0 )
					ifLocalVar89_g59854 = temp_output_123_0_g59854;
					else if( temp_output_56_0_g59854 == 0.0 )
					ifLocalVar89_g59854 = temp_output_90_0_g59854;
					else if( temp_output_56_0_g59854 < 0.0 )
					ifLocalVar89_g59854 = temp_output_90_0_g59854;
					float3 temp_output_7_0_g59857 = frac( ( (ifLocalVar89_g59854).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59857 = dot( temp_output_7_0_g59857 , ( (temp_output_7_0_g59857).yzx + 33.33 ) );
					float3 temp_output_12_0_g59857 = ( temp_output_7_0_g59857 + dotResult8_g59857 );
					float2 temp_output_597_27_g59853 = ( UV100_g59854 + frac( ( ( (temp_output_12_0_g59857).xx + (temp_output_12_0_g59857).yz ) * (temp_output_12_0_g59857).zy ) ) );
					float temp_output_67_0_g59854 = ( 1.0 - break55_g59854.x );
					float ifLocalVar61_g59854 = 0;
					if( temp_output_56_0_g59854 <= 0.0 )
					ifLocalVar61_g59854 = temp_output_67_0_g59854;
					else
					ifLocalVar61_g59854 = break55_g59854.x;
					float temp_output_597_29_g59853 = ifLocalVar61_g59854;
					float4 Output_2D293_g59853 = ( ( tex2D( _Sampler82968_g59824, temp_output_597_0_g59853, DDX631_g59853, DDY632_g59853 ) * temp_output_597_30_g59853 ) + ( tex2D( _Sampler82968_g59824, temp_output_597_26_g59853, DDX631_g59853, DDY632_g59853 ) * temp_output_597_28_g59853 ) + ( tex2D( _Sampler82968_g59824, temp_output_597_27_g59853, DDX631_g59853, DDY632_g59853 ) * temp_output_597_29_g59853 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g59824 = Output_2D293_g59853;
					#else
					float4 staticSwitch1006_g59824 = tex2D( _EmissionMap, UV0A2420_g59824 );
					#endif
					float3 temp_output_2531_0_g59824 = (( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g59824 * _EmissionIntensity )).rgb;
					float3 Emission86_g59824 = temp_output_2531_0_g59824;
					float3 Color1_g59868 = oAlbedo6_g59824;
					#ifdef _METALLICMAP
					float staticSwitch846_g59824 = tex2D( _MetallicMap, UV0A2420_g59824 ).r;
					#else
					float staticSwitch846_g59824 = _Metallic;
					#endif
					float2 temp_output_5_0_g59869 = UV0A2420_g59824;
					float2 UV633_g59869 = temp_output_5_0_g59869;
					float2 UV100_g59870 = UV633_g59869;
					float2 temp_output_51_0_g59870 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59870 * float2( 3.464,3.464 ) ) );
					float2 break55_g59870 = frac( temp_output_51_0_g59870 );
					float temp_output_56_0_g59870 = ( ( 1.0 - break55_g59870.x ) - break55_g59870.y );
					float2 temp_output_52_0_g59870 = floor( temp_output_51_0_g59870 );
					float2 temp_output_125_0_g59870 = ( temp_output_52_0_g59870 + float2( 1,1 ) );
					float2 ifLocalVar87_g59870 = 0;
					if( temp_output_56_0_g59870 > 0.0 )
					ifLocalVar87_g59870 = temp_output_52_0_g59870;
					else if( temp_output_56_0_g59870 == 0.0 )
					ifLocalVar87_g59870 = temp_output_125_0_g59870;
					else if( temp_output_56_0_g59870 < 0.0 )
					ifLocalVar87_g59870 = temp_output_125_0_g59870;
					float3 temp_output_7_0_g59871 = frac( ( (ifLocalVar87_g59870).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59871 = dot( temp_output_7_0_g59871 , ( (temp_output_7_0_g59871).yzx + 33.33 ) );
					float3 temp_output_12_0_g59871 = ( temp_output_7_0_g59871 + dotResult8_g59871 );
					float2 temp_output_597_0_g59869 = ( UV100_g59870 + frac( ( ( (temp_output_12_0_g59871).xx + (temp_output_12_0_g59871).yz ) * (temp_output_12_0_g59871).zy ) ) );
					float2 DDX631_g59869 = ddx( temp_output_5_0_g59869 );
					float2 DDY632_g59869 = ddy( temp_output_5_0_g59869 );
					float temp_output_65_0_g59870 = ( 0.0 - temp_output_56_0_g59870 );
					float ifLocalVar59_g59870 = 0;
					if( temp_output_56_0_g59870 <= 0.0 )
					ifLocalVar59_g59870 = temp_output_65_0_g59870;
					else
					ifLocalVar59_g59870 = temp_output_56_0_g59870;
					float temp_output_597_30_g59869 = ifLocalVar59_g59870;
					float2 temp_output_90_0_g59870 = ( temp_output_52_0_g59870 + float2( 0,1 ) );
					float2 temp_output_123_0_g59870 = ( temp_output_52_0_g59870 + float2( 1,0 ) );
					float2 ifLocalVar88_g59870 = 0;
					if( temp_output_56_0_g59870 > 0.0 )
					ifLocalVar88_g59870 = temp_output_90_0_g59870;
					else if( temp_output_56_0_g59870 == 0.0 )
					ifLocalVar88_g59870 = temp_output_123_0_g59870;
					else if( temp_output_56_0_g59870 < 0.0 )
					ifLocalVar88_g59870 = temp_output_123_0_g59870;
					float3 temp_output_7_0_g59872 = frac( ( (ifLocalVar88_g59870).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59872 = dot( temp_output_7_0_g59872 , ( (temp_output_7_0_g59872).yzx + 33.33 ) );
					float3 temp_output_12_0_g59872 = ( temp_output_7_0_g59872 + dotResult8_g59872 );
					float2 temp_output_597_26_g59869 = ( UV100_g59870 + frac( ( ( (temp_output_12_0_g59872).xx + (temp_output_12_0_g59872).yz ) * (temp_output_12_0_g59872).zy ) ) );
					float temp_output_66_0_g59870 = ( 1.0 - break55_g59870.y );
					float ifLocalVar60_g59870 = 0;
					if( temp_output_56_0_g59870 <= 0.0 )
					ifLocalVar60_g59870 = temp_output_66_0_g59870;
					else
					ifLocalVar60_g59870 = break55_g59870.y;
					float temp_output_597_28_g59869 = ifLocalVar60_g59870;
					float2 ifLocalVar89_g59870 = 0;
					if( temp_output_56_0_g59870 > 0.0 )
					ifLocalVar89_g59870 = temp_output_123_0_g59870;
					else if( temp_output_56_0_g59870 == 0.0 )
					ifLocalVar89_g59870 = temp_output_90_0_g59870;
					else if( temp_output_56_0_g59870 < 0.0 )
					ifLocalVar89_g59870 = temp_output_90_0_g59870;
					float3 temp_output_7_0_g59873 = frac( ( (ifLocalVar89_g59870).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59873 = dot( temp_output_7_0_g59873 , ( (temp_output_7_0_g59873).yzx + 33.33 ) );
					float3 temp_output_12_0_g59873 = ( temp_output_7_0_g59873 + dotResult8_g59873 );
					float2 temp_output_597_27_g59869 = ( UV100_g59870 + frac( ( ( (temp_output_12_0_g59873).xx + (temp_output_12_0_g59873).yz ) * (temp_output_12_0_g59873).zy ) ) );
					float temp_output_67_0_g59870 = ( 1.0 - break55_g59870.x );
					float ifLocalVar61_g59870 = 0;
					if( temp_output_56_0_g59870 <= 0.0 )
					ifLocalVar61_g59870 = temp_output_67_0_g59870;
					else
					ifLocalVar61_g59870 = break55_g59870.x;
					float temp_output_597_29_g59869 = ifLocalVar61_g59870;
					float4 Output_2D293_g59869 = ( ( tex2D( _Sampler82967_g59824, temp_output_597_0_g59869, DDX631_g59869, DDY632_g59869 ) * temp_output_597_30_g59869 ) + ( tex2D( _Sampler82967_g59824, temp_output_597_26_g59869, DDX631_g59869, DDY632_g59869 ) * temp_output_597_28_g59869 ) + ( tex2D( _Sampler82967_g59824, temp_output_597_27_g59869, DDX631_g59869, DDY632_g59869 ) * temp_output_597_29_g59869 ) );
					float4 break31_g59869 = Output_2D293_g59869;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g59824 = break31_g59869.r;
					#else
					float staticSwitch1005_g59824 = staticSwitch846_g59824;
					#endif
					float Metallic1239_g59824 = staticSwitch1005_g59824;
					float Metallic1_g59868 = Metallic1239_g59824;
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g59824 = tex2D( _GlossinessMap, UV0A2420_g59824 ).r;
					#else
					float staticSwitch845_g59824 = _Glossiness;
					#endif
					float2 temp_output_5_0_g59848 = UV0A2420_g59824;
					float2 UV633_g59848 = temp_output_5_0_g59848;
					float2 UV100_g59849 = UV633_g59848;
					float2 temp_output_51_0_g59849 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59849 * float2( 3.464,3.464 ) ) );
					float2 break55_g59849 = frac( temp_output_51_0_g59849 );
					float temp_output_56_0_g59849 = ( ( 1.0 - break55_g59849.x ) - break55_g59849.y );
					float2 temp_output_52_0_g59849 = floor( temp_output_51_0_g59849 );
					float2 temp_output_125_0_g59849 = ( temp_output_52_0_g59849 + float2( 1,1 ) );
					float2 ifLocalVar87_g59849 = 0;
					if( temp_output_56_0_g59849 > 0.0 )
					ifLocalVar87_g59849 = temp_output_52_0_g59849;
					else if( temp_output_56_0_g59849 == 0.0 )
					ifLocalVar87_g59849 = temp_output_125_0_g59849;
					else if( temp_output_56_0_g59849 < 0.0 )
					ifLocalVar87_g59849 = temp_output_125_0_g59849;
					float3 temp_output_7_0_g59850 = frac( ( (ifLocalVar87_g59849).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59850 = dot( temp_output_7_0_g59850 , ( (temp_output_7_0_g59850).yzx + 33.33 ) );
					float3 temp_output_12_0_g59850 = ( temp_output_7_0_g59850 + dotResult8_g59850 );
					float2 temp_output_597_0_g59848 = ( UV100_g59849 + frac( ( ( (temp_output_12_0_g59850).xx + (temp_output_12_0_g59850).yz ) * (temp_output_12_0_g59850).zy ) ) );
					float2 DDX631_g59848 = ddx( temp_output_5_0_g59848 );
					float2 DDY632_g59848 = ddy( temp_output_5_0_g59848 );
					float temp_output_65_0_g59849 = ( 0.0 - temp_output_56_0_g59849 );
					float ifLocalVar59_g59849 = 0;
					if( temp_output_56_0_g59849 <= 0.0 )
					ifLocalVar59_g59849 = temp_output_65_0_g59849;
					else
					ifLocalVar59_g59849 = temp_output_56_0_g59849;
					float temp_output_597_30_g59848 = ifLocalVar59_g59849;
					float2 temp_output_90_0_g59849 = ( temp_output_52_0_g59849 + float2( 0,1 ) );
					float2 temp_output_123_0_g59849 = ( temp_output_52_0_g59849 + float2( 1,0 ) );
					float2 ifLocalVar88_g59849 = 0;
					if( temp_output_56_0_g59849 > 0.0 )
					ifLocalVar88_g59849 = temp_output_90_0_g59849;
					else if( temp_output_56_0_g59849 == 0.0 )
					ifLocalVar88_g59849 = temp_output_123_0_g59849;
					else if( temp_output_56_0_g59849 < 0.0 )
					ifLocalVar88_g59849 = temp_output_123_0_g59849;
					float3 temp_output_7_0_g59851 = frac( ( (ifLocalVar88_g59849).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59851 = dot( temp_output_7_0_g59851 , ( (temp_output_7_0_g59851).yzx + 33.33 ) );
					float3 temp_output_12_0_g59851 = ( temp_output_7_0_g59851 + dotResult8_g59851 );
					float2 temp_output_597_26_g59848 = ( UV100_g59849 + frac( ( ( (temp_output_12_0_g59851).xx + (temp_output_12_0_g59851).yz ) * (temp_output_12_0_g59851).zy ) ) );
					float temp_output_66_0_g59849 = ( 1.0 - break55_g59849.y );
					float ifLocalVar60_g59849 = 0;
					if( temp_output_56_0_g59849 <= 0.0 )
					ifLocalVar60_g59849 = temp_output_66_0_g59849;
					else
					ifLocalVar60_g59849 = break55_g59849.y;
					float temp_output_597_28_g59848 = ifLocalVar60_g59849;
					float2 ifLocalVar89_g59849 = 0;
					if( temp_output_56_0_g59849 > 0.0 )
					ifLocalVar89_g59849 = temp_output_123_0_g59849;
					else if( temp_output_56_0_g59849 == 0.0 )
					ifLocalVar89_g59849 = temp_output_90_0_g59849;
					else if( temp_output_56_0_g59849 < 0.0 )
					ifLocalVar89_g59849 = temp_output_90_0_g59849;
					float3 temp_output_7_0_g59852 = frac( ( (ifLocalVar89_g59849).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59852 = dot( temp_output_7_0_g59852 , ( (temp_output_7_0_g59852).yzx + 33.33 ) );
					float3 temp_output_12_0_g59852 = ( temp_output_7_0_g59852 + dotResult8_g59852 );
					float2 temp_output_597_27_g59848 = ( UV100_g59849 + frac( ( ( (temp_output_12_0_g59852).xx + (temp_output_12_0_g59852).yz ) * (temp_output_12_0_g59852).zy ) ) );
					float temp_output_67_0_g59849 = ( 1.0 - break55_g59849.x );
					float ifLocalVar61_g59849 = 0;
					if( temp_output_56_0_g59849 <= 0.0 )
					ifLocalVar61_g59849 = temp_output_67_0_g59849;
					else
					ifLocalVar61_g59849 = break55_g59849.x;
					float temp_output_597_29_g59848 = ifLocalVar61_g59849;
					float4 Output_2D293_g59848 = ( ( tex2D( _Sampler82964_g59824, temp_output_597_0_g59848, DDX631_g59848, DDY632_g59848 ) * temp_output_597_30_g59848 ) + ( tex2D( _Sampler82964_g59824, temp_output_597_26_g59848, DDX631_g59848, DDY632_g59848 ) * temp_output_597_28_g59848 ) + ( tex2D( _Sampler82964_g59824, temp_output_597_27_g59848, DDX631_g59848, DDY632_g59848 ) * temp_output_597_29_g59848 ) );
					float4 break31_g59848 = Output_2D293_g59848;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g59824 = ( 1.0 - break31_g59848.r );
					#else
					float staticSwitch1004_g59824 = ( 1.0 - staticSwitch845_g59824 );
					#endif
					float temp_output_19_0_g59867 = staticSwitch1004_g59824;
					float2 temp_output_5_0_g59838 = UV0A2420_g59824;
					float2 UV633_g59838 = temp_output_5_0_g59838;
					float2 UV100_g59839 = UV633_g59838;
					float2 temp_output_51_0_g59839 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59839 * float2( 3.464,3.464 ) ) );
					float2 break55_g59839 = frac( temp_output_51_0_g59839 );
					float temp_output_56_0_g59839 = ( ( 1.0 - break55_g59839.x ) - break55_g59839.y );
					float2 temp_output_52_0_g59839 = floor( temp_output_51_0_g59839 );
					float2 temp_output_125_0_g59839 = ( temp_output_52_0_g59839 + float2( 1,1 ) );
					float2 ifLocalVar87_g59839 = 0;
					if( temp_output_56_0_g59839 > 0.0 )
					ifLocalVar87_g59839 = temp_output_52_0_g59839;
					else if( temp_output_56_0_g59839 == 0.0 )
					ifLocalVar87_g59839 = temp_output_125_0_g59839;
					else if( temp_output_56_0_g59839 < 0.0 )
					ifLocalVar87_g59839 = temp_output_125_0_g59839;
					float3 temp_output_7_0_g59840 = frac( ( (ifLocalVar87_g59839).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59840 = dot( temp_output_7_0_g59840 , ( (temp_output_7_0_g59840).yzx + 33.33 ) );
					float3 temp_output_12_0_g59840 = ( temp_output_7_0_g59840 + dotResult8_g59840 );
					float2 temp_output_597_0_g59838 = ( UV100_g59839 + frac( ( ( (temp_output_12_0_g59840).xx + (temp_output_12_0_g59840).yz ) * (temp_output_12_0_g59840).zy ) ) );
					float2 DDX631_g59838 = ddx( temp_output_5_0_g59838 );
					float2 DDY632_g59838 = ddy( temp_output_5_0_g59838 );
					float Input_Scale617_g59838 = 1.5;
					float temp_output_65_0_g59839 = ( 0.0 - temp_output_56_0_g59839 );
					float ifLocalVar59_g59839 = 0;
					if( temp_output_56_0_g59839 <= 0.0 )
					ifLocalVar59_g59839 = temp_output_65_0_g59839;
					else
					ifLocalVar59_g59839 = temp_output_56_0_g59839;
					float temp_output_597_30_g59838 = ifLocalVar59_g59839;
					float2 temp_output_90_0_g59839 = ( temp_output_52_0_g59839 + float2( 0,1 ) );
					float2 temp_output_123_0_g59839 = ( temp_output_52_0_g59839 + float2( 1,0 ) );
					float2 ifLocalVar88_g59839 = 0;
					if( temp_output_56_0_g59839 > 0.0 )
					ifLocalVar88_g59839 = temp_output_90_0_g59839;
					else if( temp_output_56_0_g59839 == 0.0 )
					ifLocalVar88_g59839 = temp_output_123_0_g59839;
					else if( temp_output_56_0_g59839 < 0.0 )
					ifLocalVar88_g59839 = temp_output_123_0_g59839;
					float3 temp_output_7_0_g59841 = frac( ( (ifLocalVar88_g59839).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59841 = dot( temp_output_7_0_g59841 , ( (temp_output_7_0_g59841).yzx + 33.33 ) );
					float3 temp_output_12_0_g59841 = ( temp_output_7_0_g59841 + dotResult8_g59841 );
					float2 temp_output_597_26_g59838 = ( UV100_g59839 + frac( ( ( (temp_output_12_0_g59841).xx + (temp_output_12_0_g59841).yz ) * (temp_output_12_0_g59841).zy ) ) );
					float temp_output_66_0_g59839 = ( 1.0 - break55_g59839.y );
					float ifLocalVar60_g59839 = 0;
					if( temp_output_56_0_g59839 <= 0.0 )
					ifLocalVar60_g59839 = temp_output_66_0_g59839;
					else
					ifLocalVar60_g59839 = break55_g59839.y;
					float temp_output_597_28_g59838 = ifLocalVar60_g59839;
					float2 ifLocalVar89_g59839 = 0;
					if( temp_output_56_0_g59839 > 0.0 )
					ifLocalVar89_g59839 = temp_output_123_0_g59839;
					else if( temp_output_56_0_g59839 == 0.0 )
					ifLocalVar89_g59839 = temp_output_90_0_g59839;
					else if( temp_output_56_0_g59839 < 0.0 )
					ifLocalVar89_g59839 = temp_output_90_0_g59839;
					float3 temp_output_7_0_g59842 = frac( ( (ifLocalVar89_g59839).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59842 = dot( temp_output_7_0_g59842 , ( (temp_output_7_0_g59842).yzx + 33.33 ) );
					float3 temp_output_12_0_g59842 = ( temp_output_7_0_g59842 + dotResult8_g59842 );
					float2 temp_output_597_27_g59838 = ( UV100_g59839 + frac( ( ( (temp_output_12_0_g59842).xx + (temp_output_12_0_g59842).yz ) * (temp_output_12_0_g59842).zy ) ) );
					float temp_output_67_0_g59839 = ( 1.0 - break55_g59839.x );
					float ifLocalVar61_g59839 = 0;
					if( temp_output_56_0_g59839 <= 0.0 )
					ifLocalVar61_g59839 = temp_output_67_0_g59839;
					else
					ifLocalVar61_g59839 = break55_g59839.x;
					float temp_output_597_29_g59838 = ifLocalVar61_g59839;
					float3 Output_2D_Normal641_g59838 = ( ( UnpackScaleNormal( tex2D( _Sampler82965_g59824, temp_output_597_0_g59838, DDX631_g59838, DDY632_g59838 ), Input_Scale617_g59838 ) * temp_output_597_30_g59838 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g59824, temp_output_597_26_g59838, DDX631_g59838, DDY632_g59838 ), Input_Scale617_g59838 ) * temp_output_597_28_g59838 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g59824, temp_output_597_27_g59838, DDX631_g59838, DDY632_g59838 ), Input_Scale617_g59838 ) * float3( 0,0,0 ) * temp_output_597_29_g59838 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g59824 = Output_2D_Normal641_g59838;
					#else
					float3 staticSwitch1003_g59824 = UnpackScaleNormal( tex2D( _BumpMap, UV0A2420_g59824 ), 1.5 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g59824 = staticSwitch1003_g59824;
					#else
					float3 staticSwitch980_g59824 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g59824 = staticSwitch980_g59824;
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal2504_g59824 = Normal_Map700_g59824;
					float3 worldNormal2504_g59824 = normalize( float3( dot( tanToWorld0, tanNormal2504_g59824 ), dot( tanToWorld1, tanNormal2504_g59824 ), dot( tanToWorld2, tanNormal2504_g59824 ) ) );
					float3 World_Normal2508_g59824 = worldNormal2504_g59824;
					float3 tanNormal2_g59867 = World_Normal2508_g59824;
					float3 worldNormal2_g59867 = float3( dot( tanToWorld0, tanNormal2_g59867 ), dot( tanToWorld1, tanNormal2_g59867 ), dot( tanToWorld2, tanNormal2_g59867 ) );
					float3 temp_output_3_0_g59867 = ddx( worldNormal2_g59867 );
					float dotResult5_g59867 = dot( temp_output_3_0_g59867 , temp_output_3_0_g59867 );
					float3 temp_output_4_0_g59867 = ddy( worldNormal2_g59867 );
					float dotResult6_g59867 = dot( temp_output_4_0_g59867 , temp_output_4_0_g59867 );
					#ifdef _USEGEOMETRICAA_ON
					float staticSwitch15_g59867 = min( temp_output_19_0_g59867, ( 1.0 - pow( saturate( max( dotResult5_g59867, dotResult6_g59867 ) ) , 0.25 ) ) );
					#else
					float staticSwitch15_g59867 = temp_output_19_0_g59867;
					#endif
					float SmoothnessAA1399_g59824 = staticSwitch15_g59867;
					float Smoothness1_g59868 = SmoothnessAA1399_g59824;
					float IOR2700_g59824 = _IOR;
					float IOR1_g59868 = IOR2700_g59824;
					float3 temp_cast_2 = (0.04).xxx;
					float3 lerpResult1473_g59824 = lerp( temp_cast_2 , oAlbedo6_g59824 , Metallic1239_g59824);
					float3 switchResult1501_g59824 = (((ase_vface>0)?(World_Normal2508_g59824):(-World_Normal2508_g59824)));
					float3 View_Direction2511_g59824 = ViewDirWS;
					float dotResult1476_g59824 = dot( switchResult1501_g59824 , View_Direction2511_g59824 );
					float3 lerpResult1480_g59824 = lerp( lerpResult1473_g59824 , float3( 1,1,1 ) , pow( ( 1.0 - saturate( dotResult1476_g59824 ) ) , 5.0 ));
					float3 Fresnel1560_g59824 = lerpResult1480_g59824;
					float3 Fresnel1_g59868 = Fresnel1560_g59824;
					float3 World_Position2505_g59824 = PositionWS;
					float3 WorldPos1_g59868 = World_Position2505_g59824;
					float3 WorldNormal1_g59868 = World_Normal2508_g59824;
					float3 ViewDir1_g59868 = View_Direction2511_g59824;
					float3 localIndirectSpecular1_g59868 = IndirectSpecular1_g59868( Color1_g59868 , Metallic1_g59868 , Smoothness1_g59868 , IOR1_g59868 , Fresnel1_g59868 , WorldPos1_g59868 , WorldNormal1_g59868 , ViewDir1_g59868 );
					float3 temp_output_2848_0_g59824 = localIndirectSpecular1_g59868;
					float White38_g59824 = 1.0;
					float4 temp_cast_3 = (White38_g59824).xxxx;
					float4 texCoord2426_g59824 = IN.ase_texcoord6;
					texCoord2426_g59824.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0B2361_g59824 = (texCoord2426_g59824).zw;
					float localBicubicPrepare2_g59833 = ( 0.0 );
					float2 Input_UV100_g59833 = UV0B2361_g59824;
					float2 UV2_g59833 = Input_UV100_g59833;
					float4 TexelSize2_g59833 = _Lightmap0_TexelSize;
					float2 UV02_g59833 = float2( 0,0 );
					float2 UV12_g59833 = float2( 0,0 );
					float2 UV22_g59833 = float2( 0,0 );
					float2 UV32_g59833 = float2( 0,0 );
					float W02_g59833 = 0;
					float W12_g59833 = 0;
					{
					{
					 UV2_g59833 = UV2_g59833 * TexelSize2_g59833.zw - 0.5;
					    float2 f = frac( UV2_g59833 );
					    UV2_g59833 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59833.x - 0.5, UV2_g59833.x + 1.5, UV2_g59833.y - 0.5, UV2_g59833.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59833.xyxy;
					    UV02_g59833 = off.xz;
					    UV12_g59833 = off.yz;
					    UV22_g59833 = off.xw;
					    UV32_g59833 = off.yw;
					    W02_g59833 = s.x / ( s.x + s.y );
					 W12_g59833 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59833 = lerp( tex2D( _Lightmap0, UV32_g59833 ) , tex2D( _Lightmap0, UV22_g59833 ) , W02_g59833);
					float4 lerpResult45_g59833 = lerp( tex2D( _Lightmap0, UV12_g59833 ) , tex2D( _Lightmap0, UV02_g59833 ) , W02_g59833);
					float4 lerpResult44_g59833 = lerp( lerpResult46_g59833 , lerpResult45_g59833 , W12_g59833);
					float4 Output_2D_Auto131_g59833 = lerpResult44_g59833;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g59824 = Output_2D_Auto131_g59833;
					#else
					float4 staticSwitch1092_g59824 = float4( tex2D( _Lightmap0, UV0B2361_g59824 ).rgb , 0.0 );
					#endif
					float4 Lightmap_0925_g59824 = staticSwitch1092_g59824;
					float localBicubicPrepare2_g59831 = ( 0.0 );
					float2 Input_UV100_g59831 = UV0B2361_g59824;
					float2 UV2_g59831 = Input_UV100_g59831;
					float4 TexelSize2_g59831 = _Lightmap1_TexelSize;
					float2 UV02_g59831 = float2( 0,0 );
					float2 UV12_g59831 = float2( 0,0 );
					float2 UV22_g59831 = float2( 0,0 );
					float2 UV32_g59831 = float2( 0,0 );
					float W02_g59831 = 0;
					float W12_g59831 = 0;
					{
					{
					 UV2_g59831 = UV2_g59831 * TexelSize2_g59831.zw - 0.5;
					    float2 f = frac( UV2_g59831 );
					    UV2_g59831 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59831.x - 0.5, UV2_g59831.x + 1.5, UV2_g59831.y - 0.5, UV2_g59831.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59831.xyxy;
					    UV02_g59831 = off.xz;
					    UV12_g59831 = off.yz;
					    UV22_g59831 = off.xw;
					    UV32_g59831 = off.yw;
					    W02_g59831 = s.x / ( s.x + s.y );
					 W12_g59831 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59831 = lerp( tex2D( _Lightmap1, UV32_g59831 ) , tex2D( _Lightmap1, UV22_g59831 ) , W02_g59831);
					float4 lerpResult45_g59831 = lerp( tex2D( _Lightmap1, UV12_g59831 ) , tex2D( _Lightmap1, UV02_g59831 ) , W02_g59831);
					float4 lerpResult44_g59831 = lerp( lerpResult46_g59831 , lerpResult45_g59831 , W12_g59831);
					float4 Output_2D_Auto131_g59831 = lerpResult44_g59831;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g59824 = Output_2D_Auto131_g59831;
					#else
					float4 staticSwitch1088_g59824 = tex2D( _Lightmap1, UV0B2361_g59824 );
					#endif
					float4 Lightmap_1956_g59824 = staticSwitch1088_g59824;
					float Lightmap_Lerp_Value969_g59824 = _UdonLightmapLerp;
					float4 lerpResult442_g59824 = lerp( Lightmap_0925_g59824 , Lightmap_1956_g59824 , Lightmap_Lerp_Value969_g59824);
					float4 Lightmap_Lerp932_g59824 = lerpResult442_g59824;
					float3 appendResult139_g59863 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g59863 = normalize( Normal_Map700_g59824 );
					float3 Normal_Map318_g59863 = normalizeResult326_g59863;
					float dotResult121_g59863 = dot( appendResult139_g59863 , Normal_Map318_g59863 );
					float temp_output_2_0_g59865 = saturate( dotResult121_g59863 );
					float localStochasticTiling2_g59859 = ( 0.0 );
					float2 UV2_g59859 = UV0B2361_g59824;
					float4 TexelSize2_g59859 = _UdonRNMX0_TexelSize;
					float4 Offsets2_g59859 = float4( 0,0,0,0 );
					float2 Weights2_g59859 = float2( 0,0 );
					{
					UV2_g59859 = UV2_g59859 * TexelSize2_g59859.zw - 0.5;
					float2 f = frac( UV2_g59859 );
					UV2_g59859 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g59859.x - 0.5, UV2_g59859.x + 1.5, UV2_g59859.y - 0.5, UV2_g59859.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g59859 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59859.xyxy;
					Weights2_g59859 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g59858 = Offsets2_g59859;
					float4 Input_FetchOffsets197_g59860 = temp_output_1_34_g59858;
					float2 temp_output_1_54_g59858 = Weights2_g59859;
					float2 Input_FetchWeights200_g59860 = temp_output_1_54_g59858;
					float2 break187_g59860 = Input_FetchWeights200_g59860;
					float4 lerpResult181_g59860 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g59860).yw ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g59860).xw ) , break187_g59860.x);
					float4 lerpResult182_g59860 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g59860).yz ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g59860).xz ) , break187_g59860.x);
					float4 lerpResult176_g59860 = lerp( lerpResult181_g59860 , lerpResult182_g59860 , break187_g59860.y);
					float4 Output_Fetch2D_Auto202_g59860 = lerpResult176_g59860;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g59824 = Output_Fetch2D_Auto202_g59860;
					#else
					float4 staticSwitch1061_g59824 = tex2D( _UdonRNMX0, UV0B2361_g59824 );
					#endif
					float3 appendResult146_g59863 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59863 = dot( appendResult146_g59863 , Normal_Map318_g59863 );
					float temp_output_2_0_g59864 = saturate( dotResult122_g59863 );
					float4 Input_FetchOffsets197_g59861 = temp_output_1_34_g59858;
					float2 Input_FetchWeights200_g59861 = temp_output_1_54_g59858;
					float2 break187_g59861 = Input_FetchWeights200_g59861;
					float4 lerpResult181_g59861 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g59861).yw ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g59861).xw ) , break187_g59861.x);
					float4 lerpResult182_g59861 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g59861).yz ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g59861).xz ) , break187_g59861.x);
					float4 lerpResult176_g59861 = lerp( lerpResult181_g59861 , lerpResult182_g59861 , break187_g59861.y);
					float4 Output_Fetch2D_Auto202_g59861 = lerpResult176_g59861;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g59824 = Output_Fetch2D_Auto202_g59861;
					#else
					float4 staticSwitch1062_g59824 = tex2D( _UdonRNMY0, UV0B2361_g59824 );
					#endif
					float3 appendResult149_g59863 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59863 = dot( appendResult149_g59863 , Normal_Map318_g59863 );
					float temp_output_2_0_g59866 = saturate( dotResult120_g59863 );
					float4 Input_FetchOffsets197_g59862 = temp_output_1_34_g59858;
					float2 Input_FetchWeights200_g59862 = temp_output_1_54_g59858;
					float2 break187_g59862 = Input_FetchWeights200_g59862;
					float4 lerpResult181_g59862 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g59862).yw ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g59862).xw ) , break187_g59862.x);
					float4 lerpResult182_g59862 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g59862).yz ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g59862).xz ) , break187_g59862.x);
					float4 lerpResult176_g59862 = lerp( lerpResult181_g59862 , lerpResult182_g59862 , break187_g59862.y);
					float4 Output_Fetch2D_Auto202_g59862 = lerpResult176_g59862;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g59824 = Output_Fetch2D_Auto202_g59862;
					#else
					float4 staticSwitch1063_g59824 = tex2D( _UdonRNMZ0, UV0B2361_g59824 );
					#endif
					float4 RNM_0926_g59824 = ( ( ( ( ( temp_output_2_0_g59865 * temp_output_2_0_g59865 ) * staticSwitch1061_g59824 ) + ( ( temp_output_2_0_g59864 * temp_output_2_0_g59864 ) * staticSwitch1062_g59824 ) ) + ( ( temp_output_2_0_g59866 * temp_output_2_0_g59866 ) * staticSwitch1063_g59824 ) ) * 1.5 );
					float3 appendResult139_g59834 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g59834 = normalize( Normal_Map700_g59824 );
					float3 Normal_Map318_g59834 = normalizeResult326_g59834;
					float dotResult121_g59834 = dot( appendResult139_g59834 , Normal_Map318_g59834 );
					float temp_output_2_0_g59836 = saturate( dotResult121_g59834 );
					float localStochasticTiling2_g59826 = ( 0.0 );
					float2 UV2_g59826 = UV0B2361_g59824;
					float4 TexelSize2_g59826 = _UdonRNMX1_TexelSize;
					float4 Offsets2_g59826 = float4( 0,0,0,0 );
					float2 Weights2_g59826 = float2( 0,0 );
					{
					UV2_g59826 = UV2_g59826 * TexelSize2_g59826.zw - 0.5;
					float2 f = frac( UV2_g59826 );
					UV2_g59826 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g59826.x - 0.5, UV2_g59826.x + 1.5, UV2_g59826.y - 0.5, UV2_g59826.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g59826 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59826.xyxy;
					Weights2_g59826 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g59825 = Offsets2_g59826;
					float4 Input_FetchOffsets197_g59827 = temp_output_1_34_g59825;
					float2 temp_output_1_54_g59825 = Weights2_g59826;
					float2 Input_FetchWeights200_g59827 = temp_output_1_54_g59825;
					float2 break187_g59827 = Input_FetchWeights200_g59827;
					float4 lerpResult181_g59827 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g59827).yw ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g59827).xw ) , break187_g59827.x);
					float4 lerpResult182_g59827 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g59827).yz ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g59827).xz ) , break187_g59827.x);
					float4 lerpResult176_g59827 = lerp( lerpResult181_g59827 , lerpResult182_g59827 , break187_g59827.y);
					float4 Output_Fetch2D_Auto202_g59827 = lerpResult176_g59827;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g59824 = Output_Fetch2D_Auto202_g59827;
					#else
					float4 staticSwitch1087_g59824 = tex2D( _UdonRNMX1, UV0B2361_g59824 );
					#endif
					float3 appendResult146_g59834 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59834 = dot( appendResult146_g59834 , Normal_Map318_g59834 );
					float temp_output_2_0_g59835 = saturate( dotResult122_g59834 );
					float4 Input_FetchOffsets197_g59828 = temp_output_1_34_g59825;
					float2 Input_FetchWeights200_g59828 = temp_output_1_54_g59825;
					float2 break187_g59828 = Input_FetchWeights200_g59828;
					float4 lerpResult181_g59828 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g59828).yw ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g59828).xw ) , break187_g59828.x);
					float4 lerpResult182_g59828 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g59828).yz ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g59828).xz ) , break187_g59828.x);
					float4 lerpResult176_g59828 = lerp( lerpResult181_g59828 , lerpResult182_g59828 , break187_g59828.y);
					float4 Output_Fetch2D_Auto202_g59828 = lerpResult176_g59828;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g59824 = Output_Fetch2D_Auto202_g59828;
					#else
					float4 staticSwitch1083_g59824 = tex2D( _UdonRNMY1, UV0B2361_g59824 );
					#endif
					float3 appendResult149_g59834 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59834 = dot( appendResult149_g59834 , Normal_Map318_g59834 );
					float temp_output_2_0_g59837 = saturate( dotResult120_g59834 );
					float4 Input_FetchOffsets197_g59829 = temp_output_1_34_g59825;
					float2 Input_FetchWeights200_g59829 = temp_output_1_54_g59825;
					float2 break187_g59829 = Input_FetchWeights200_g59829;
					float4 lerpResult181_g59829 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g59829).yw ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g59829).xw ) , break187_g59829.x);
					float4 lerpResult182_g59829 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g59829).yz ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g59829).xz ) , break187_g59829.x);
					float4 lerpResult176_g59829 = lerp( lerpResult181_g59829 , lerpResult182_g59829 , break187_g59829.y);
					float4 Output_Fetch2D_Auto202_g59829 = lerpResult176_g59829;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g59824 = Output_Fetch2D_Auto202_g59829;
					#else
					float4 staticSwitch1084_g59824 = tex2D( _UdonRNMZ1, UV0B2361_g59824 );
					#endif
					float4 RNM_11081_g59824 = ( ( ( ( ( temp_output_2_0_g59836 * temp_output_2_0_g59836 ) * staticSwitch1087_g59824 ) + ( ( temp_output_2_0_g59835 * temp_output_2_0_g59835 ) * staticSwitch1083_g59824 ) ) + ( ( temp_output_2_0_g59837 * temp_output_2_0_g59837 ) * staticSwitch1084_g59824 ) ) * 1.5 );
					float4 lerpResult953_g59824 = lerp( RNM_0926_g59824 , RNM_11081_g59824 , Lightmap_Lerp_Value969_g59824);
					float4 RNM_Lerp950_g59824 = lerpResult953_g59824;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g59824 = temp_cast_3;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g59824 = Lightmap_0925_g59824;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g59824 = Lightmap_Lerp932_g59824;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g59824 = RNM_0926_g59824;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g59824 = RNM_Lerp950_g59824;
					#else
					float4 staticSwitch1014_g59824 = temp_cast_3;
					#endif
					float3 Lightmap46_g59824 = (staticSwitch1014_g59824).rgb;
					float grayscale2713_g59824 = Luminance( Lightmap46_g59824 );
					float smoothstepResult2430_g59824 = smoothstep( 0.0 , 0.05 , grayscale2713_g59824);
					#ifdef _USELIGHTMAPPEDREFLECTIONS_ON
					float3 staticSwitch1469_g59824 = ( temp_output_2848_0_g59824 * smoothstepResult2430_g59824 );
					#else
					float3 staticSwitch1469_g59824 = temp_output_2848_0_g59824;
					#endif
					float3 Indirect_Specular1419_g59824 = staticSwitch1469_g59824;
					float3 Color97_g59874 = oAlbedo6_g59824;
					float3 LightmapColor97_g59874 = Lightmap46_g59824;
					float Metallic97_g59874 = Metallic1239_g59824;
					float Smoothness2838_g59824 = staticSwitch1004_g59824;
					float Smoothness97_g59874 = Smoothness2838_g59824;
					float SmoothnessAA97_g59874 = SmoothnessAA1399_g59824;
					float IOR97_g59874 = IOR2700_g59824;
					float3 Fresnel97_g59874 = Fresnel1560_g59824;
					float3 WorldPos97_g59874 = World_Position2505_g59824;
					float3 WorldNormal97_g59874 = World_Normal2508_g59824;
					float3 ViewDir97_g59874 = View_Direction2511_g59824;
					float3 localDirectSpecular97_g59874 = DirectSpecular( Color97_g59874 , LightmapColor97_g59874 , Metallic97_g59874 , Smoothness97_g59874 , SmoothnessAA97_g59874 , IOR97_g59874 , Fresnel97_g59874 , WorldPos97_g59874 , WorldNormal97_g59874 , ViewDir97_g59874 );
					float3 Direct_Specular2560_g59824 = localDirectSpecular97_g59874;
					float3 aAlbedo1466_g59824 = ( temp_output_2532_0_g59824 * ( 1.0 - Metallic1239_g59824 ) );
					float3 temp_output_1252_0_g59824 = ( aAlbedo1466_g59824 * Lightmap46_g59824 );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch1_g59877 = float4( ( temp_output_1252_0_g59824 + Emission86_g59824 + Indirect_Specular1419_g59824 ) , 0.0 );
					#else
					float4 staticSwitch1_g59877 = float4( ( Emission86_g59824 + Indirect_Specular1419_g59824 + Direct_Specular2560_g59824 + temp_output_1252_0_g59824 ) , 0.0 );
					#endif
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1181_g59824 = float4( Lightmap46_g59824 , 0.0 );
					#else
					float4 staticSwitch1181_g59824 = staticSwitch1_g59877;
					#endif
					float4 Color357_g59875 = staticSwitch1181_g59824;
					#ifdef _3DLUT
					float4 staticSwitch194_g59875 = tex3D( _3DLut, ( ( log10( ( ( (Color357_g59875).xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 ) );
					#else
					float4 staticSwitch194_g59875 = Color357_g59875;
					#endif
					float4 LUT51_g59875 = staticSwitch194_g59875;
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch359_g59875 = LUT51_g59875;
					#else
					float4 staticSwitch359_g59875 = Color357_g59875;
					#endif
					

					o.Albedo = staticSwitch1180_g59824;
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

					o.Emission = staticSwitch359_g59875.xyz;
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
				uniform float _CATEGORYSPACESURFACEOPTIONS;
				uniform float _UdonSpecularLightCount;
				uniform sampler3D _3DLut;
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
				uniform float _CATEGORYSPACESURFACEOPTIONS;
				uniform float _UdonSpecularLightCount;
				uniform sampler3D _3DLut;
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
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;6063;0,-1280;Inherit;False;Meenphie;0;;59824;b3ba55a08dd6b49c7be16c6f35cf2033;6,1008,0,2632,0,2635,0,2619,0,2636,0,2670,0;0;5;FLOAT3;625;FLOAT4;624;FLOAT;156;FLOAT;427;FLOAT;1024
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5279;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5280;256,-1280;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;Meenphie/Standard/Opaque;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardBase;0;1;ForwardBase;17;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;44;Category;0;0;  Instanced Terrain Normals;1;0;Workflow;3;639079749420714040;Surface;0;0;  Blend;0;0;  Dither Shadows;1;0;Two Sided;1;0;Alpha Clipping;0;0;  Use Shadow Threshold;0;0;Deferred Pass;0;639079951064078170;Normal Space;0;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;0;639108440689538340;Receive Shadows;1;0;Receive Specular;0;639108440701916390;Receive Reflections;0;639108447998214750;GPU Instancing;1;0;LOD CrossFade;1;0;Built-in Fog;1;639105044169342440;Ambient Light;1;639111933610282130;Meta Pass;0;639111933576947160;Add Pass;0;639111933580732010;Override Baked GI;0;0;Write Depth;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;0;Vertex Position;1;0;0;8;False;True;False;False;False;False;True;True;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5281;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;True;1;LightMode=ForwardAdd;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5282;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5283;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5284;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5285;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5286;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ScenePickingPass;0;7;ScenePickingPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=Picking;False;False;0;;0;0;Standard;0;False;0
WireConnection;5280;0;6063;625
WireConnection;5280;2;6063;624
ASEEND*/
//CHKSM=63F3F2DAF9A1C8FB0B2D35B2BD3D2686CBCF3879