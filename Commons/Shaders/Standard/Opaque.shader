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
				sampler2D _Sampler82966_g63051;
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				sampler2D _Sampler82967_g63051;
				uniform sampler2D _Lightmap0;
				float4 _Lightmap0_TexelSize;
				uniform sampler2D _Lightmap1;
				float4 _Lightmap1_TexelSize;
				uniform float _UdonLightmapLerp;
				uniform sampler2D _BumpMap;
				sampler2D _Sampler82965_g63051;
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
				sampler2D _Sampler82968_g63051;
				uniform float _EmissionIntensity;
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				sampler2D _Sampler82964_g63051;
				uniform float _IOR;


				float3 IndirectSpecular1_g63095( float3 Color, float Metallic, float Smoothness, float IOR, float3 Fresnel, float3 WorldPos, float3 WorldNormal, float3 ViewDir )
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

					float2 texCoord2357_g63051 = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0A2420_g63051 = texCoord2357_g63051;
					#ifdef _MAINTEX
					float4 staticSwitch1549_g63051 = tex2D( _MainTex, UV0A2420_g63051 );
					#else
					float4 staticSwitch1549_g63051 = _Color;
					#endif
					float2 temp_output_5_0_g63070 = UV0A2420_g63051;
					float2 UV633_g63070 = temp_output_5_0_g63070;
					float2 UV100_g63071 = UV633_g63070;
					float2 temp_output_51_0_g63071 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g63071 * float2( 3.464,3.464 ) ) );
					float2 break55_g63071 = frac( temp_output_51_0_g63071 );
					float temp_output_56_0_g63071 = ( ( 1.0 - break55_g63071.x ) - break55_g63071.y );
					float2 temp_output_52_0_g63071 = floor( temp_output_51_0_g63071 );
					float2 temp_output_125_0_g63071 = ( temp_output_52_0_g63071 + float2( 1,1 ) );
					float2 ifLocalVar87_g63071 = 0;
					if( temp_output_56_0_g63071 > 0.0 )
					ifLocalVar87_g63071 = temp_output_52_0_g63071;
					else if( temp_output_56_0_g63071 == 0.0 )
					ifLocalVar87_g63071 = temp_output_125_0_g63071;
					else if( temp_output_56_0_g63071 < 0.0 )
					ifLocalVar87_g63071 = temp_output_125_0_g63071;
					float3 temp_output_7_0_g63072 = frac( ( (ifLocalVar87_g63071).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63072 = dot( temp_output_7_0_g63072 , ( (temp_output_7_0_g63072).yzx + 33.33 ) );
					float3 temp_output_12_0_g63072 = ( temp_output_7_0_g63072 + dotResult8_g63072 );
					float2 temp_output_597_0_g63070 = ( UV100_g63071 + frac( ( ( (temp_output_12_0_g63072).xx + (temp_output_12_0_g63072).yz ) * (temp_output_12_0_g63072).zy ) ) );
					float2 DDX631_g63070 = ddx( temp_output_5_0_g63070 );
					float2 DDY632_g63070 = ddy( temp_output_5_0_g63070 );
					float temp_output_65_0_g63071 = ( 0.0 - temp_output_56_0_g63071 );
					float ifLocalVar59_g63071 = 0;
					if( temp_output_56_0_g63071 <= 0.0 )
					ifLocalVar59_g63071 = temp_output_65_0_g63071;
					else
					ifLocalVar59_g63071 = temp_output_56_0_g63071;
					float temp_output_597_30_g63070 = ifLocalVar59_g63071;
					float2 temp_output_90_0_g63071 = ( temp_output_52_0_g63071 + float2( 0,1 ) );
					float2 temp_output_123_0_g63071 = ( temp_output_52_0_g63071 + float2( 1,0 ) );
					float2 ifLocalVar88_g63071 = 0;
					if( temp_output_56_0_g63071 > 0.0 )
					ifLocalVar88_g63071 = temp_output_90_0_g63071;
					else if( temp_output_56_0_g63071 == 0.0 )
					ifLocalVar88_g63071 = temp_output_123_0_g63071;
					else if( temp_output_56_0_g63071 < 0.0 )
					ifLocalVar88_g63071 = temp_output_123_0_g63071;
					float3 temp_output_7_0_g63073 = frac( ( (ifLocalVar88_g63071).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63073 = dot( temp_output_7_0_g63073 , ( (temp_output_7_0_g63073).yzx + 33.33 ) );
					float3 temp_output_12_0_g63073 = ( temp_output_7_0_g63073 + dotResult8_g63073 );
					float2 temp_output_597_26_g63070 = ( UV100_g63071 + frac( ( ( (temp_output_12_0_g63073).xx + (temp_output_12_0_g63073).yz ) * (temp_output_12_0_g63073).zy ) ) );
					float temp_output_66_0_g63071 = ( 1.0 - break55_g63071.y );
					float ifLocalVar60_g63071 = 0;
					if( temp_output_56_0_g63071 <= 0.0 )
					ifLocalVar60_g63071 = temp_output_66_0_g63071;
					else
					ifLocalVar60_g63071 = break55_g63071.y;
					float temp_output_597_28_g63070 = ifLocalVar60_g63071;
					float2 ifLocalVar89_g63071 = 0;
					if( temp_output_56_0_g63071 > 0.0 )
					ifLocalVar89_g63071 = temp_output_123_0_g63071;
					else if( temp_output_56_0_g63071 == 0.0 )
					ifLocalVar89_g63071 = temp_output_90_0_g63071;
					else if( temp_output_56_0_g63071 < 0.0 )
					ifLocalVar89_g63071 = temp_output_90_0_g63071;
					float3 temp_output_7_0_g63074 = frac( ( (ifLocalVar89_g63071).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63074 = dot( temp_output_7_0_g63074 , ( (temp_output_7_0_g63074).yzx + 33.33 ) );
					float3 temp_output_12_0_g63074 = ( temp_output_7_0_g63074 + dotResult8_g63074 );
					float2 temp_output_597_27_g63070 = ( UV100_g63071 + frac( ( ( (temp_output_12_0_g63074).xx + (temp_output_12_0_g63074).yz ) * (temp_output_12_0_g63074).zy ) ) );
					float temp_output_67_0_g63071 = ( 1.0 - break55_g63071.x );
					float ifLocalVar61_g63071 = 0;
					if( temp_output_56_0_g63071 <= 0.0 )
					ifLocalVar61_g63071 = temp_output_67_0_g63071;
					else
					ifLocalVar61_g63071 = break55_g63071.x;
					float temp_output_597_29_g63070 = ifLocalVar61_g63071;
					float4 Output_2D293_g63070 = ( ( tex2D( _Sampler82966_g63051, temp_output_597_0_g63070, DDX631_g63070, DDY632_g63070 ) * temp_output_597_30_g63070 ) + ( tex2D( _Sampler82966_g63051, temp_output_597_26_g63070, DDX631_g63070, DDY632_g63070 ) * temp_output_597_28_g63070 ) + ( tex2D( _Sampler82966_g63051, temp_output_597_27_g63070, DDX631_g63070, DDY632_g63070 ) * temp_output_597_29_g63070 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g63051 = Output_2D293_g63070;
					#else
					float4 staticSwitch1001_g63051 = staticSwitch1549_g63051;
					#endif
					float3 temp_output_2532_0_g63051 = (staticSwitch1001_g63051).rgb;
					float3 oAlbedo6_g63051 = temp_output_2532_0_g63051;
					float Black1185_g63051 = 0.0;
					float3 temp_cast_0 = (Black1185_g63051).xxx;
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch1180_g63051 = temp_cast_0;
					#else
					float3 staticSwitch1180_g63051 = oAlbedo6_g63051;
					#endif
					
					#ifdef _METALLICMAP
					float staticSwitch846_g63051 = tex2D( _MetallicMap, UV0A2420_g63051 ).r;
					#else
					float staticSwitch846_g63051 = _Metallic;
					#endif
					float2 temp_output_5_0_g63096 = UV0A2420_g63051;
					float2 UV633_g63096 = temp_output_5_0_g63096;
					float2 UV100_g63097 = UV633_g63096;
					float2 temp_output_51_0_g63097 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g63097 * float2( 3.464,3.464 ) ) );
					float2 break55_g63097 = frac( temp_output_51_0_g63097 );
					float temp_output_56_0_g63097 = ( ( 1.0 - break55_g63097.x ) - break55_g63097.y );
					float2 temp_output_52_0_g63097 = floor( temp_output_51_0_g63097 );
					float2 temp_output_125_0_g63097 = ( temp_output_52_0_g63097 + float2( 1,1 ) );
					float2 ifLocalVar87_g63097 = 0;
					if( temp_output_56_0_g63097 > 0.0 )
					ifLocalVar87_g63097 = temp_output_52_0_g63097;
					else if( temp_output_56_0_g63097 == 0.0 )
					ifLocalVar87_g63097 = temp_output_125_0_g63097;
					else if( temp_output_56_0_g63097 < 0.0 )
					ifLocalVar87_g63097 = temp_output_125_0_g63097;
					float3 temp_output_7_0_g63098 = frac( ( (ifLocalVar87_g63097).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63098 = dot( temp_output_7_0_g63098 , ( (temp_output_7_0_g63098).yzx + 33.33 ) );
					float3 temp_output_12_0_g63098 = ( temp_output_7_0_g63098 + dotResult8_g63098 );
					float2 temp_output_597_0_g63096 = ( UV100_g63097 + frac( ( ( (temp_output_12_0_g63098).xx + (temp_output_12_0_g63098).yz ) * (temp_output_12_0_g63098).zy ) ) );
					float2 DDX631_g63096 = ddx( temp_output_5_0_g63096 );
					float2 DDY632_g63096 = ddy( temp_output_5_0_g63096 );
					float temp_output_65_0_g63097 = ( 0.0 - temp_output_56_0_g63097 );
					float ifLocalVar59_g63097 = 0;
					if( temp_output_56_0_g63097 <= 0.0 )
					ifLocalVar59_g63097 = temp_output_65_0_g63097;
					else
					ifLocalVar59_g63097 = temp_output_56_0_g63097;
					float temp_output_597_30_g63096 = ifLocalVar59_g63097;
					float2 temp_output_90_0_g63097 = ( temp_output_52_0_g63097 + float2( 0,1 ) );
					float2 temp_output_123_0_g63097 = ( temp_output_52_0_g63097 + float2( 1,0 ) );
					float2 ifLocalVar88_g63097 = 0;
					if( temp_output_56_0_g63097 > 0.0 )
					ifLocalVar88_g63097 = temp_output_90_0_g63097;
					else if( temp_output_56_0_g63097 == 0.0 )
					ifLocalVar88_g63097 = temp_output_123_0_g63097;
					else if( temp_output_56_0_g63097 < 0.0 )
					ifLocalVar88_g63097 = temp_output_123_0_g63097;
					float3 temp_output_7_0_g63099 = frac( ( (ifLocalVar88_g63097).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63099 = dot( temp_output_7_0_g63099 , ( (temp_output_7_0_g63099).yzx + 33.33 ) );
					float3 temp_output_12_0_g63099 = ( temp_output_7_0_g63099 + dotResult8_g63099 );
					float2 temp_output_597_26_g63096 = ( UV100_g63097 + frac( ( ( (temp_output_12_0_g63099).xx + (temp_output_12_0_g63099).yz ) * (temp_output_12_0_g63099).zy ) ) );
					float temp_output_66_0_g63097 = ( 1.0 - break55_g63097.y );
					float ifLocalVar60_g63097 = 0;
					if( temp_output_56_0_g63097 <= 0.0 )
					ifLocalVar60_g63097 = temp_output_66_0_g63097;
					else
					ifLocalVar60_g63097 = break55_g63097.y;
					float temp_output_597_28_g63096 = ifLocalVar60_g63097;
					float2 ifLocalVar89_g63097 = 0;
					if( temp_output_56_0_g63097 > 0.0 )
					ifLocalVar89_g63097 = temp_output_123_0_g63097;
					else if( temp_output_56_0_g63097 == 0.0 )
					ifLocalVar89_g63097 = temp_output_90_0_g63097;
					else if( temp_output_56_0_g63097 < 0.0 )
					ifLocalVar89_g63097 = temp_output_90_0_g63097;
					float3 temp_output_7_0_g63100 = frac( ( (ifLocalVar89_g63097).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63100 = dot( temp_output_7_0_g63100 , ( (temp_output_7_0_g63100).yzx + 33.33 ) );
					float3 temp_output_12_0_g63100 = ( temp_output_7_0_g63100 + dotResult8_g63100 );
					float2 temp_output_597_27_g63096 = ( UV100_g63097 + frac( ( ( (temp_output_12_0_g63100).xx + (temp_output_12_0_g63100).yz ) * (temp_output_12_0_g63100).zy ) ) );
					float temp_output_67_0_g63097 = ( 1.0 - break55_g63097.x );
					float ifLocalVar61_g63097 = 0;
					if( temp_output_56_0_g63097 <= 0.0 )
					ifLocalVar61_g63097 = temp_output_67_0_g63097;
					else
					ifLocalVar61_g63097 = break55_g63097.x;
					float temp_output_597_29_g63096 = ifLocalVar61_g63097;
					float4 Output_2D293_g63096 = ( ( tex2D( _Sampler82967_g63051, temp_output_597_0_g63096, DDX631_g63096, DDY632_g63096 ) * temp_output_597_30_g63096 ) + ( tex2D( _Sampler82967_g63051, temp_output_597_26_g63096, DDX631_g63096, DDY632_g63096 ) * temp_output_597_28_g63096 ) + ( tex2D( _Sampler82967_g63051, temp_output_597_27_g63096, DDX631_g63096, DDY632_g63096 ) * temp_output_597_29_g63096 ) );
					float4 break31_g63096 = Output_2D293_g63096;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g63051 = break31_g63096.r;
					#else
					float staticSwitch1005_g63051 = staticSwitch846_g63051;
					#endif
					float Metallic1239_g63051 = staticSwitch1005_g63051;
					float3 aAlbedo1466_g63051 = ( temp_output_2532_0_g63051 * ( 1.0 - Metallic1239_g63051 ) );
					float White38_g63051 = 1.0;
					float4 temp_cast_1 = (White38_g63051).xxxx;
					float4 texCoord2426_g63051 = IN.ase_texcoord6;
					texCoord2426_g63051.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0B2361_g63051 = (texCoord2426_g63051).zw;
					float localBicubicPrepare2_g63060 = ( 0.0 );
					float2 Input_UV100_g63060 = UV0B2361_g63051;
					float2 UV2_g63060 = Input_UV100_g63060;
					float4 TexelSize2_g63060 = _Lightmap0_TexelSize;
					float2 UV02_g63060 = float2( 0,0 );
					float2 UV12_g63060 = float2( 0,0 );
					float2 UV22_g63060 = float2( 0,0 );
					float2 UV32_g63060 = float2( 0,0 );
					float W02_g63060 = 0;
					float W12_g63060 = 0;
					{
					{
					 UV2_g63060 = UV2_g63060 * TexelSize2_g63060.zw - 0.5;
					    float2 f = frac( UV2_g63060 );
					    UV2_g63060 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g63060.x - 0.5, UV2_g63060.x + 1.5, UV2_g63060.y - 0.5, UV2_g63060.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g63060.xyxy;
					    UV02_g63060 = off.xz;
					    UV12_g63060 = off.yz;
					    UV22_g63060 = off.xw;
					    UV32_g63060 = off.yw;
					    W02_g63060 = s.x / ( s.x + s.y );
					 W12_g63060 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g63060 = lerp( tex2D( _Lightmap0, UV32_g63060 ) , tex2D( _Lightmap0, UV22_g63060 ) , W02_g63060);
					float4 lerpResult45_g63060 = lerp( tex2D( _Lightmap0, UV12_g63060 ) , tex2D( _Lightmap0, UV02_g63060 ) , W02_g63060);
					float4 lerpResult44_g63060 = lerp( lerpResult46_g63060 , lerpResult45_g63060 , W12_g63060);
					float4 Output_2D_Auto131_g63060 = lerpResult44_g63060;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g63051 = Output_2D_Auto131_g63060;
					#else
					float4 staticSwitch1092_g63051 = float4( tex2D( _Lightmap0, UV0B2361_g63051 ).rgb , 0.0 );
					#endif
					float4 Lightmap_0925_g63051 = staticSwitch1092_g63051;
					float localBicubicPrepare2_g63058 = ( 0.0 );
					float2 Input_UV100_g63058 = UV0B2361_g63051;
					float2 UV2_g63058 = Input_UV100_g63058;
					float4 TexelSize2_g63058 = _Lightmap1_TexelSize;
					float2 UV02_g63058 = float2( 0,0 );
					float2 UV12_g63058 = float2( 0,0 );
					float2 UV22_g63058 = float2( 0,0 );
					float2 UV32_g63058 = float2( 0,0 );
					float W02_g63058 = 0;
					float W12_g63058 = 0;
					{
					{
					 UV2_g63058 = UV2_g63058 * TexelSize2_g63058.zw - 0.5;
					    float2 f = frac( UV2_g63058 );
					    UV2_g63058 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g63058.x - 0.5, UV2_g63058.x + 1.5, UV2_g63058.y - 0.5, UV2_g63058.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g63058.xyxy;
					    UV02_g63058 = off.xz;
					    UV12_g63058 = off.yz;
					    UV22_g63058 = off.xw;
					    UV32_g63058 = off.yw;
					    W02_g63058 = s.x / ( s.x + s.y );
					 W12_g63058 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g63058 = lerp( tex2D( _Lightmap1, UV32_g63058 ) , tex2D( _Lightmap1, UV22_g63058 ) , W02_g63058);
					float4 lerpResult45_g63058 = lerp( tex2D( _Lightmap1, UV12_g63058 ) , tex2D( _Lightmap1, UV02_g63058 ) , W02_g63058);
					float4 lerpResult44_g63058 = lerp( lerpResult46_g63058 , lerpResult45_g63058 , W12_g63058);
					float4 Output_2D_Auto131_g63058 = lerpResult44_g63058;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g63051 = Output_2D_Auto131_g63058;
					#else
					float4 staticSwitch1088_g63051 = tex2D( _Lightmap1, UV0B2361_g63051 );
					#endif
					float4 Lightmap_1956_g63051 = staticSwitch1088_g63051;
					float Lightmap_Lerp_Value969_g63051 = _UdonLightmapLerp;
					float4 lerpResult442_g63051 = lerp( Lightmap_0925_g63051 , Lightmap_1956_g63051 , Lightmap_Lerp_Value969_g63051);
					float4 Lightmap_Lerp932_g63051 = lerpResult442_g63051;
					float3 appendResult139_g63090 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float2 temp_output_5_0_g63065 = UV0A2420_g63051;
					float2 UV633_g63065 = temp_output_5_0_g63065;
					float2 UV100_g63066 = UV633_g63065;
					float2 temp_output_51_0_g63066 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g63066 * float2( 3.464,3.464 ) ) );
					float2 break55_g63066 = frac( temp_output_51_0_g63066 );
					float temp_output_56_0_g63066 = ( ( 1.0 - break55_g63066.x ) - break55_g63066.y );
					float2 temp_output_52_0_g63066 = floor( temp_output_51_0_g63066 );
					float2 temp_output_125_0_g63066 = ( temp_output_52_0_g63066 + float2( 1,1 ) );
					float2 ifLocalVar87_g63066 = 0;
					if( temp_output_56_0_g63066 > 0.0 )
					ifLocalVar87_g63066 = temp_output_52_0_g63066;
					else if( temp_output_56_0_g63066 == 0.0 )
					ifLocalVar87_g63066 = temp_output_125_0_g63066;
					else if( temp_output_56_0_g63066 < 0.0 )
					ifLocalVar87_g63066 = temp_output_125_0_g63066;
					float3 temp_output_7_0_g63067 = frac( ( (ifLocalVar87_g63066).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63067 = dot( temp_output_7_0_g63067 , ( (temp_output_7_0_g63067).yzx + 33.33 ) );
					float3 temp_output_12_0_g63067 = ( temp_output_7_0_g63067 + dotResult8_g63067 );
					float2 temp_output_597_0_g63065 = ( UV100_g63066 + frac( ( ( (temp_output_12_0_g63067).xx + (temp_output_12_0_g63067).yz ) * (temp_output_12_0_g63067).zy ) ) );
					float2 DDX631_g63065 = ddx( temp_output_5_0_g63065 );
					float2 DDY632_g63065 = ddy( temp_output_5_0_g63065 );
					float Input_Scale617_g63065 = 1.5;
					float temp_output_65_0_g63066 = ( 0.0 - temp_output_56_0_g63066 );
					float ifLocalVar59_g63066 = 0;
					if( temp_output_56_0_g63066 <= 0.0 )
					ifLocalVar59_g63066 = temp_output_65_0_g63066;
					else
					ifLocalVar59_g63066 = temp_output_56_0_g63066;
					float temp_output_597_30_g63065 = ifLocalVar59_g63066;
					float2 temp_output_90_0_g63066 = ( temp_output_52_0_g63066 + float2( 0,1 ) );
					float2 temp_output_123_0_g63066 = ( temp_output_52_0_g63066 + float2( 1,0 ) );
					float2 ifLocalVar88_g63066 = 0;
					if( temp_output_56_0_g63066 > 0.0 )
					ifLocalVar88_g63066 = temp_output_90_0_g63066;
					else if( temp_output_56_0_g63066 == 0.0 )
					ifLocalVar88_g63066 = temp_output_123_0_g63066;
					else if( temp_output_56_0_g63066 < 0.0 )
					ifLocalVar88_g63066 = temp_output_123_0_g63066;
					float3 temp_output_7_0_g63068 = frac( ( (ifLocalVar88_g63066).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63068 = dot( temp_output_7_0_g63068 , ( (temp_output_7_0_g63068).yzx + 33.33 ) );
					float3 temp_output_12_0_g63068 = ( temp_output_7_0_g63068 + dotResult8_g63068 );
					float2 temp_output_597_26_g63065 = ( UV100_g63066 + frac( ( ( (temp_output_12_0_g63068).xx + (temp_output_12_0_g63068).yz ) * (temp_output_12_0_g63068).zy ) ) );
					float temp_output_66_0_g63066 = ( 1.0 - break55_g63066.y );
					float ifLocalVar60_g63066 = 0;
					if( temp_output_56_0_g63066 <= 0.0 )
					ifLocalVar60_g63066 = temp_output_66_0_g63066;
					else
					ifLocalVar60_g63066 = break55_g63066.y;
					float temp_output_597_28_g63065 = ifLocalVar60_g63066;
					float2 ifLocalVar89_g63066 = 0;
					if( temp_output_56_0_g63066 > 0.0 )
					ifLocalVar89_g63066 = temp_output_123_0_g63066;
					else if( temp_output_56_0_g63066 == 0.0 )
					ifLocalVar89_g63066 = temp_output_90_0_g63066;
					else if( temp_output_56_0_g63066 < 0.0 )
					ifLocalVar89_g63066 = temp_output_90_0_g63066;
					float3 temp_output_7_0_g63069 = frac( ( (ifLocalVar89_g63066).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63069 = dot( temp_output_7_0_g63069 , ( (temp_output_7_0_g63069).yzx + 33.33 ) );
					float3 temp_output_12_0_g63069 = ( temp_output_7_0_g63069 + dotResult8_g63069 );
					float2 temp_output_597_27_g63065 = ( UV100_g63066 + frac( ( ( (temp_output_12_0_g63069).xx + (temp_output_12_0_g63069).yz ) * (temp_output_12_0_g63069).zy ) ) );
					float temp_output_67_0_g63066 = ( 1.0 - break55_g63066.x );
					float ifLocalVar61_g63066 = 0;
					if( temp_output_56_0_g63066 <= 0.0 )
					ifLocalVar61_g63066 = temp_output_67_0_g63066;
					else
					ifLocalVar61_g63066 = break55_g63066.x;
					float temp_output_597_29_g63065 = ifLocalVar61_g63066;
					float3 Output_2D_Normal641_g63065 = ( ( UnpackScaleNormal( tex2D( _Sampler82965_g63051, temp_output_597_0_g63065, DDX631_g63065, DDY632_g63065 ), Input_Scale617_g63065 ) * temp_output_597_30_g63065 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g63051, temp_output_597_26_g63065, DDX631_g63065, DDY632_g63065 ), Input_Scale617_g63065 ) * temp_output_597_28_g63065 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g63051, temp_output_597_27_g63065, DDX631_g63065, DDY632_g63065 ), Input_Scale617_g63065 ) * float3( 0,0,0 ) * temp_output_597_29_g63065 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g63051 = Output_2D_Normal641_g63065;
					#else
					float3 staticSwitch1003_g63051 = UnpackScaleNormal( tex2D( _BumpMap, UV0A2420_g63051 ), 1.5 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g63051 = staticSwitch1003_g63051;
					#else
					float3 staticSwitch980_g63051 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g63051 = staticSwitch980_g63051;
					float3 normalizeResult326_g63090 = normalize( Normal_Map700_g63051 );
					float3 Normal_Map318_g63090 = normalizeResult326_g63090;
					float dotResult121_g63090 = dot( appendResult139_g63090 , Normal_Map318_g63090 );
					float temp_output_2_0_g63092 = saturate( dotResult121_g63090 );
					float localStochasticTiling2_g63086 = ( 0.0 );
					float2 UV2_g63086 = UV0B2361_g63051;
					float4 TexelSize2_g63086 = _UdonRNMX0_TexelSize;
					float4 Offsets2_g63086 = float4( 0,0,0,0 );
					float2 Weights2_g63086 = float2( 0,0 );
					{
					UV2_g63086 = UV2_g63086 * TexelSize2_g63086.zw - 0.5;
					float2 f = frac( UV2_g63086 );
					UV2_g63086 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g63086.x - 0.5, UV2_g63086.x + 1.5, UV2_g63086.y - 0.5, UV2_g63086.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g63086 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g63086.xyxy;
					Weights2_g63086 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g63085 = Offsets2_g63086;
					float4 Input_FetchOffsets197_g63087 = temp_output_1_34_g63085;
					float2 temp_output_1_54_g63085 = Weights2_g63086;
					float2 Input_FetchWeights200_g63087 = temp_output_1_54_g63085;
					float2 break187_g63087 = Input_FetchWeights200_g63087;
					float4 lerpResult181_g63087 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g63087).yw ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g63087).xw ) , break187_g63087.x);
					float4 lerpResult182_g63087 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g63087).yz ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g63087).xz ) , break187_g63087.x);
					float4 lerpResult176_g63087 = lerp( lerpResult181_g63087 , lerpResult182_g63087 , break187_g63087.y);
					float4 Output_Fetch2D_Auto202_g63087 = lerpResult176_g63087;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g63051 = Output_Fetch2D_Auto202_g63087;
					#else
					float4 staticSwitch1061_g63051 = tex2D( _UdonRNMX0, UV0B2361_g63051 );
					#endif
					float3 appendResult146_g63090 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g63090 = dot( appendResult146_g63090 , Normal_Map318_g63090 );
					float temp_output_2_0_g63091 = saturate( dotResult122_g63090 );
					float4 Input_FetchOffsets197_g63088 = temp_output_1_34_g63085;
					float2 Input_FetchWeights200_g63088 = temp_output_1_54_g63085;
					float2 break187_g63088 = Input_FetchWeights200_g63088;
					float4 lerpResult181_g63088 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g63088).yw ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g63088).xw ) , break187_g63088.x);
					float4 lerpResult182_g63088 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g63088).yz ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g63088).xz ) , break187_g63088.x);
					float4 lerpResult176_g63088 = lerp( lerpResult181_g63088 , lerpResult182_g63088 , break187_g63088.y);
					float4 Output_Fetch2D_Auto202_g63088 = lerpResult176_g63088;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g63051 = Output_Fetch2D_Auto202_g63088;
					#else
					float4 staticSwitch1062_g63051 = tex2D( _UdonRNMY0, UV0B2361_g63051 );
					#endif
					float3 appendResult149_g63090 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g63090 = dot( appendResult149_g63090 , Normal_Map318_g63090 );
					float temp_output_2_0_g63093 = saturate( dotResult120_g63090 );
					float4 Input_FetchOffsets197_g63089 = temp_output_1_34_g63085;
					float2 Input_FetchWeights200_g63089 = temp_output_1_54_g63085;
					float2 break187_g63089 = Input_FetchWeights200_g63089;
					float4 lerpResult181_g63089 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g63089).yw ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g63089).xw ) , break187_g63089.x);
					float4 lerpResult182_g63089 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g63089).yz ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g63089).xz ) , break187_g63089.x);
					float4 lerpResult176_g63089 = lerp( lerpResult181_g63089 , lerpResult182_g63089 , break187_g63089.y);
					float4 Output_Fetch2D_Auto202_g63089 = lerpResult176_g63089;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g63051 = Output_Fetch2D_Auto202_g63089;
					#else
					float4 staticSwitch1063_g63051 = tex2D( _UdonRNMZ0, UV0B2361_g63051 );
					#endif
					float4 RNM_0926_g63051 = ( ( ( ( ( temp_output_2_0_g63092 * temp_output_2_0_g63092 ) * staticSwitch1061_g63051 ) + ( ( temp_output_2_0_g63091 * temp_output_2_0_g63091 ) * staticSwitch1062_g63051 ) ) + ( ( temp_output_2_0_g63093 * temp_output_2_0_g63093 ) * staticSwitch1063_g63051 ) ) * 1.5 );
					float3 appendResult139_g63061 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g63061 = normalize( Normal_Map700_g63051 );
					float3 Normal_Map318_g63061 = normalizeResult326_g63061;
					float dotResult121_g63061 = dot( appendResult139_g63061 , Normal_Map318_g63061 );
					float temp_output_2_0_g63063 = saturate( dotResult121_g63061 );
					float localStochasticTiling2_g63053 = ( 0.0 );
					float2 UV2_g63053 = UV0B2361_g63051;
					float4 TexelSize2_g63053 = _UdonRNMX1_TexelSize;
					float4 Offsets2_g63053 = float4( 0,0,0,0 );
					float2 Weights2_g63053 = float2( 0,0 );
					{
					UV2_g63053 = UV2_g63053 * TexelSize2_g63053.zw - 0.5;
					float2 f = frac( UV2_g63053 );
					UV2_g63053 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g63053.x - 0.5, UV2_g63053.x + 1.5, UV2_g63053.y - 0.5, UV2_g63053.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g63053 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g63053.xyxy;
					Weights2_g63053 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g63052 = Offsets2_g63053;
					float4 Input_FetchOffsets197_g63054 = temp_output_1_34_g63052;
					float2 temp_output_1_54_g63052 = Weights2_g63053;
					float2 Input_FetchWeights200_g63054 = temp_output_1_54_g63052;
					float2 break187_g63054 = Input_FetchWeights200_g63054;
					float4 lerpResult181_g63054 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g63054).yw ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g63054).xw ) , break187_g63054.x);
					float4 lerpResult182_g63054 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g63054).yz ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g63054).xz ) , break187_g63054.x);
					float4 lerpResult176_g63054 = lerp( lerpResult181_g63054 , lerpResult182_g63054 , break187_g63054.y);
					float4 Output_Fetch2D_Auto202_g63054 = lerpResult176_g63054;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g63051 = Output_Fetch2D_Auto202_g63054;
					#else
					float4 staticSwitch1087_g63051 = tex2D( _UdonRNMX1, UV0B2361_g63051 );
					#endif
					float3 appendResult146_g63061 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g63061 = dot( appendResult146_g63061 , Normal_Map318_g63061 );
					float temp_output_2_0_g63062 = saturate( dotResult122_g63061 );
					float4 Input_FetchOffsets197_g63055 = temp_output_1_34_g63052;
					float2 Input_FetchWeights200_g63055 = temp_output_1_54_g63052;
					float2 break187_g63055 = Input_FetchWeights200_g63055;
					float4 lerpResult181_g63055 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g63055).yw ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g63055).xw ) , break187_g63055.x);
					float4 lerpResult182_g63055 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g63055).yz ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g63055).xz ) , break187_g63055.x);
					float4 lerpResult176_g63055 = lerp( lerpResult181_g63055 , lerpResult182_g63055 , break187_g63055.y);
					float4 Output_Fetch2D_Auto202_g63055 = lerpResult176_g63055;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g63051 = Output_Fetch2D_Auto202_g63055;
					#else
					float4 staticSwitch1083_g63051 = tex2D( _UdonRNMY1, UV0B2361_g63051 );
					#endif
					float3 appendResult149_g63061 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g63061 = dot( appendResult149_g63061 , Normal_Map318_g63061 );
					float temp_output_2_0_g63064 = saturate( dotResult120_g63061 );
					float4 Input_FetchOffsets197_g63056 = temp_output_1_34_g63052;
					float2 Input_FetchWeights200_g63056 = temp_output_1_54_g63052;
					float2 break187_g63056 = Input_FetchWeights200_g63056;
					float4 lerpResult181_g63056 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g63056).yw ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g63056).xw ) , break187_g63056.x);
					float4 lerpResult182_g63056 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g63056).yz ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g63056).xz ) , break187_g63056.x);
					float4 lerpResult176_g63056 = lerp( lerpResult181_g63056 , lerpResult182_g63056 , break187_g63056.y);
					float4 Output_Fetch2D_Auto202_g63056 = lerpResult176_g63056;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g63051 = Output_Fetch2D_Auto202_g63056;
					#else
					float4 staticSwitch1084_g63051 = tex2D( _UdonRNMZ1, UV0B2361_g63051 );
					#endif
					float4 RNM_11081_g63051 = ( ( ( ( ( temp_output_2_0_g63063 * temp_output_2_0_g63063 ) * staticSwitch1087_g63051 ) + ( ( temp_output_2_0_g63062 * temp_output_2_0_g63062 ) * staticSwitch1083_g63051 ) ) + ( ( temp_output_2_0_g63064 * temp_output_2_0_g63064 ) * staticSwitch1084_g63051 ) ) * 1.5 );
					float4 lerpResult953_g63051 = lerp( RNM_0926_g63051 , RNM_11081_g63051 , Lightmap_Lerp_Value969_g63051);
					float4 RNM_Lerp950_g63051 = lerpResult953_g63051;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g63051 = temp_cast_1;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g63051 = Lightmap_0925_g63051;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g63051 = Lightmap_Lerp932_g63051;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g63051 = RNM_0926_g63051;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g63051 = RNM_Lerp950_g63051;
					#else
					float4 staticSwitch1014_g63051 = temp_cast_1;
					#endif
					float3 Lightmap46_g63051 = (staticSwitch1014_g63051).rgb;
					float3 temp_output_1252_0_g63051 = ( aAlbedo1466_g63051 * Lightmap46_g63051 );
					float2 temp_output_5_0_g63080 = UV0A2420_g63051;
					float2 UV633_g63080 = temp_output_5_0_g63080;
					float2 UV100_g63081 = UV633_g63080;
					float2 temp_output_51_0_g63081 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g63081 * float2( 3.464,3.464 ) ) );
					float2 break55_g63081 = frac( temp_output_51_0_g63081 );
					float temp_output_56_0_g63081 = ( ( 1.0 - break55_g63081.x ) - break55_g63081.y );
					float2 temp_output_52_0_g63081 = floor( temp_output_51_0_g63081 );
					float2 temp_output_125_0_g63081 = ( temp_output_52_0_g63081 + float2( 1,1 ) );
					float2 ifLocalVar87_g63081 = 0;
					if( temp_output_56_0_g63081 > 0.0 )
					ifLocalVar87_g63081 = temp_output_52_0_g63081;
					else if( temp_output_56_0_g63081 == 0.0 )
					ifLocalVar87_g63081 = temp_output_125_0_g63081;
					else if( temp_output_56_0_g63081 < 0.0 )
					ifLocalVar87_g63081 = temp_output_125_0_g63081;
					float3 temp_output_7_0_g63082 = frac( ( (ifLocalVar87_g63081).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63082 = dot( temp_output_7_0_g63082 , ( (temp_output_7_0_g63082).yzx + 33.33 ) );
					float3 temp_output_12_0_g63082 = ( temp_output_7_0_g63082 + dotResult8_g63082 );
					float2 temp_output_597_0_g63080 = ( UV100_g63081 + frac( ( ( (temp_output_12_0_g63082).xx + (temp_output_12_0_g63082).yz ) * (temp_output_12_0_g63082).zy ) ) );
					float2 DDX631_g63080 = ddx( temp_output_5_0_g63080 );
					float2 DDY632_g63080 = ddy( temp_output_5_0_g63080 );
					float temp_output_65_0_g63081 = ( 0.0 - temp_output_56_0_g63081 );
					float ifLocalVar59_g63081 = 0;
					if( temp_output_56_0_g63081 <= 0.0 )
					ifLocalVar59_g63081 = temp_output_65_0_g63081;
					else
					ifLocalVar59_g63081 = temp_output_56_0_g63081;
					float temp_output_597_30_g63080 = ifLocalVar59_g63081;
					float2 temp_output_90_0_g63081 = ( temp_output_52_0_g63081 + float2( 0,1 ) );
					float2 temp_output_123_0_g63081 = ( temp_output_52_0_g63081 + float2( 1,0 ) );
					float2 ifLocalVar88_g63081 = 0;
					if( temp_output_56_0_g63081 > 0.0 )
					ifLocalVar88_g63081 = temp_output_90_0_g63081;
					else if( temp_output_56_0_g63081 == 0.0 )
					ifLocalVar88_g63081 = temp_output_123_0_g63081;
					else if( temp_output_56_0_g63081 < 0.0 )
					ifLocalVar88_g63081 = temp_output_123_0_g63081;
					float3 temp_output_7_0_g63083 = frac( ( (ifLocalVar88_g63081).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63083 = dot( temp_output_7_0_g63083 , ( (temp_output_7_0_g63083).yzx + 33.33 ) );
					float3 temp_output_12_0_g63083 = ( temp_output_7_0_g63083 + dotResult8_g63083 );
					float2 temp_output_597_26_g63080 = ( UV100_g63081 + frac( ( ( (temp_output_12_0_g63083).xx + (temp_output_12_0_g63083).yz ) * (temp_output_12_0_g63083).zy ) ) );
					float temp_output_66_0_g63081 = ( 1.0 - break55_g63081.y );
					float ifLocalVar60_g63081 = 0;
					if( temp_output_56_0_g63081 <= 0.0 )
					ifLocalVar60_g63081 = temp_output_66_0_g63081;
					else
					ifLocalVar60_g63081 = break55_g63081.y;
					float temp_output_597_28_g63080 = ifLocalVar60_g63081;
					float2 ifLocalVar89_g63081 = 0;
					if( temp_output_56_0_g63081 > 0.0 )
					ifLocalVar89_g63081 = temp_output_123_0_g63081;
					else if( temp_output_56_0_g63081 == 0.0 )
					ifLocalVar89_g63081 = temp_output_90_0_g63081;
					else if( temp_output_56_0_g63081 < 0.0 )
					ifLocalVar89_g63081 = temp_output_90_0_g63081;
					float3 temp_output_7_0_g63084 = frac( ( (ifLocalVar89_g63081).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63084 = dot( temp_output_7_0_g63084 , ( (temp_output_7_0_g63084).yzx + 33.33 ) );
					float3 temp_output_12_0_g63084 = ( temp_output_7_0_g63084 + dotResult8_g63084 );
					float2 temp_output_597_27_g63080 = ( UV100_g63081 + frac( ( ( (temp_output_12_0_g63084).xx + (temp_output_12_0_g63084).yz ) * (temp_output_12_0_g63084).zy ) ) );
					float temp_output_67_0_g63081 = ( 1.0 - break55_g63081.x );
					float ifLocalVar61_g63081 = 0;
					if( temp_output_56_0_g63081 <= 0.0 )
					ifLocalVar61_g63081 = temp_output_67_0_g63081;
					else
					ifLocalVar61_g63081 = break55_g63081.x;
					float temp_output_597_29_g63080 = ifLocalVar61_g63081;
					float4 Output_2D293_g63080 = ( ( tex2D( _Sampler82968_g63051, temp_output_597_0_g63080, DDX631_g63080, DDY632_g63080 ) * temp_output_597_30_g63080 ) + ( tex2D( _Sampler82968_g63051, temp_output_597_26_g63080, DDX631_g63080, DDY632_g63080 ) * temp_output_597_28_g63080 ) + ( tex2D( _Sampler82968_g63051, temp_output_597_27_g63080, DDX631_g63080, DDY632_g63080 ) * temp_output_597_29_g63080 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g63051 = Output_2D293_g63080;
					#else
					float4 staticSwitch1006_g63051 = tex2D( _EmissionMap, UV0A2420_g63051 );
					#endif
					float3 temp_output_2531_0_g63051 = (( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g63051 * _EmissionIntensity )).rgb;
					float3 Emission86_g63051 = temp_output_2531_0_g63051;
					float3 Color1_g63095 = oAlbedo6_g63051;
					float Metallic1_g63095 = Metallic1239_g63051;
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g63051 = tex2D( _GlossinessMap, UV0A2420_g63051 ).r;
					#else
					float staticSwitch845_g63051 = _Glossiness;
					#endif
					float2 temp_output_5_0_g63075 = UV0A2420_g63051;
					float2 UV633_g63075 = temp_output_5_0_g63075;
					float2 UV100_g63076 = UV633_g63075;
					float2 temp_output_51_0_g63076 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g63076 * float2( 3.464,3.464 ) ) );
					float2 break55_g63076 = frac( temp_output_51_0_g63076 );
					float temp_output_56_0_g63076 = ( ( 1.0 - break55_g63076.x ) - break55_g63076.y );
					float2 temp_output_52_0_g63076 = floor( temp_output_51_0_g63076 );
					float2 temp_output_125_0_g63076 = ( temp_output_52_0_g63076 + float2( 1,1 ) );
					float2 ifLocalVar87_g63076 = 0;
					if( temp_output_56_0_g63076 > 0.0 )
					ifLocalVar87_g63076 = temp_output_52_0_g63076;
					else if( temp_output_56_0_g63076 == 0.0 )
					ifLocalVar87_g63076 = temp_output_125_0_g63076;
					else if( temp_output_56_0_g63076 < 0.0 )
					ifLocalVar87_g63076 = temp_output_125_0_g63076;
					float3 temp_output_7_0_g63077 = frac( ( (ifLocalVar87_g63076).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63077 = dot( temp_output_7_0_g63077 , ( (temp_output_7_0_g63077).yzx + 33.33 ) );
					float3 temp_output_12_0_g63077 = ( temp_output_7_0_g63077 + dotResult8_g63077 );
					float2 temp_output_597_0_g63075 = ( UV100_g63076 + frac( ( ( (temp_output_12_0_g63077).xx + (temp_output_12_0_g63077).yz ) * (temp_output_12_0_g63077).zy ) ) );
					float2 DDX631_g63075 = ddx( temp_output_5_0_g63075 );
					float2 DDY632_g63075 = ddy( temp_output_5_0_g63075 );
					float temp_output_65_0_g63076 = ( 0.0 - temp_output_56_0_g63076 );
					float ifLocalVar59_g63076 = 0;
					if( temp_output_56_0_g63076 <= 0.0 )
					ifLocalVar59_g63076 = temp_output_65_0_g63076;
					else
					ifLocalVar59_g63076 = temp_output_56_0_g63076;
					float temp_output_597_30_g63075 = ifLocalVar59_g63076;
					float2 temp_output_90_0_g63076 = ( temp_output_52_0_g63076 + float2( 0,1 ) );
					float2 temp_output_123_0_g63076 = ( temp_output_52_0_g63076 + float2( 1,0 ) );
					float2 ifLocalVar88_g63076 = 0;
					if( temp_output_56_0_g63076 > 0.0 )
					ifLocalVar88_g63076 = temp_output_90_0_g63076;
					else if( temp_output_56_0_g63076 == 0.0 )
					ifLocalVar88_g63076 = temp_output_123_0_g63076;
					else if( temp_output_56_0_g63076 < 0.0 )
					ifLocalVar88_g63076 = temp_output_123_0_g63076;
					float3 temp_output_7_0_g63078 = frac( ( (ifLocalVar88_g63076).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63078 = dot( temp_output_7_0_g63078 , ( (temp_output_7_0_g63078).yzx + 33.33 ) );
					float3 temp_output_12_0_g63078 = ( temp_output_7_0_g63078 + dotResult8_g63078 );
					float2 temp_output_597_26_g63075 = ( UV100_g63076 + frac( ( ( (temp_output_12_0_g63078).xx + (temp_output_12_0_g63078).yz ) * (temp_output_12_0_g63078).zy ) ) );
					float temp_output_66_0_g63076 = ( 1.0 - break55_g63076.y );
					float ifLocalVar60_g63076 = 0;
					if( temp_output_56_0_g63076 <= 0.0 )
					ifLocalVar60_g63076 = temp_output_66_0_g63076;
					else
					ifLocalVar60_g63076 = break55_g63076.y;
					float temp_output_597_28_g63075 = ifLocalVar60_g63076;
					float2 ifLocalVar89_g63076 = 0;
					if( temp_output_56_0_g63076 > 0.0 )
					ifLocalVar89_g63076 = temp_output_123_0_g63076;
					else if( temp_output_56_0_g63076 == 0.0 )
					ifLocalVar89_g63076 = temp_output_90_0_g63076;
					else if( temp_output_56_0_g63076 < 0.0 )
					ifLocalVar89_g63076 = temp_output_90_0_g63076;
					float3 temp_output_7_0_g63079 = frac( ( (ifLocalVar89_g63076).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63079 = dot( temp_output_7_0_g63079 , ( (temp_output_7_0_g63079).yzx + 33.33 ) );
					float3 temp_output_12_0_g63079 = ( temp_output_7_0_g63079 + dotResult8_g63079 );
					float2 temp_output_597_27_g63075 = ( UV100_g63076 + frac( ( ( (temp_output_12_0_g63079).xx + (temp_output_12_0_g63079).yz ) * (temp_output_12_0_g63079).zy ) ) );
					float temp_output_67_0_g63076 = ( 1.0 - break55_g63076.x );
					float ifLocalVar61_g63076 = 0;
					if( temp_output_56_0_g63076 <= 0.0 )
					ifLocalVar61_g63076 = temp_output_67_0_g63076;
					else
					ifLocalVar61_g63076 = break55_g63076.x;
					float temp_output_597_29_g63075 = ifLocalVar61_g63076;
					float4 Output_2D293_g63075 = ( ( tex2D( _Sampler82964_g63051, temp_output_597_0_g63075, DDX631_g63075, DDY632_g63075 ) * temp_output_597_30_g63075 ) + ( tex2D( _Sampler82964_g63051, temp_output_597_26_g63075, DDX631_g63075, DDY632_g63075 ) * temp_output_597_28_g63075 ) + ( tex2D( _Sampler82964_g63051, temp_output_597_27_g63075, DDX631_g63075, DDY632_g63075 ) * temp_output_597_29_g63075 ) );
					float4 break31_g63075 = Output_2D293_g63075;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g63051 = ( 1.0 - break31_g63075.r );
					#else
					float staticSwitch1004_g63051 = ( 1.0 - staticSwitch845_g63051 );
					#endif
					float temp_output_19_0_g63094 = staticSwitch1004_g63051;
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal2504_g63051 = Normal_Map700_g63051;
					float3 worldNormal2504_g63051 = normalize( float3( dot( tanToWorld0, tanNormal2504_g63051 ), dot( tanToWorld1, tanNormal2504_g63051 ), dot( tanToWorld2, tanNormal2504_g63051 ) ) );
					float3 World_Normal2508_g63051 = worldNormal2504_g63051;
					float3 tanNormal2_g63094 = World_Normal2508_g63051;
					float3 worldNormal2_g63094 = float3( dot( tanToWorld0, tanNormal2_g63094 ), dot( tanToWorld1, tanNormal2_g63094 ), dot( tanToWorld2, tanNormal2_g63094 ) );
					float3 temp_output_3_0_g63094 = ddx( worldNormal2_g63094 );
					float dotResult5_g63094 = dot( temp_output_3_0_g63094 , temp_output_3_0_g63094 );
					float3 temp_output_4_0_g63094 = ddy( worldNormal2_g63094 );
					float dotResult6_g63094 = dot( temp_output_4_0_g63094 , temp_output_4_0_g63094 );
					#ifdef _USEGEOMETRICAA_ON
					float staticSwitch15_g63094 = min( temp_output_19_0_g63094, ( 1.0 - pow( saturate( max( dotResult5_g63094, dotResult6_g63094 ) ) , 0.25 ) ) );
					#else
					float staticSwitch15_g63094 = temp_output_19_0_g63094;
					#endif
					float SmoothnessAA1399_g63051 = staticSwitch15_g63094;
					float Smoothness1_g63095 = SmoothnessAA1399_g63051;
					float IOR2700_g63051 = _IOR;
					float IOR1_g63095 = IOR2700_g63051;
					float3 temp_cast_4 = (0.04).xxx;
					float3 lerpResult1473_g63051 = lerp( temp_cast_4 , oAlbedo6_g63051 , Metallic1239_g63051);
					float3 switchResult1501_g63051 = (((ase_vface>0)?(World_Normal2508_g63051):(-World_Normal2508_g63051)));
					float3 View_Direction2511_g63051 = ViewDirWS;
					float dotResult1476_g63051 = dot( switchResult1501_g63051 , View_Direction2511_g63051 );
					float3 lerpResult1480_g63051 = lerp( lerpResult1473_g63051 , float3( 1,1,1 ) , pow( ( 1.0 - saturate( dotResult1476_g63051 ) ) , 5.0 ));
					float3 Fresnel1560_g63051 = lerpResult1480_g63051;
					float3 Fresnel1_g63095 = Fresnel1560_g63051;
					float3 World_Position2505_g63051 = PositionWS;
					float3 WorldPos1_g63095 = World_Position2505_g63051;
					float3 WorldNormal1_g63095 = World_Normal2508_g63051;
					float3 ViewDir1_g63095 = View_Direction2511_g63051;
					float3 localIndirectSpecular1_g63095 = IndirectSpecular1_g63095( Color1_g63095 , Metallic1_g63095 , Smoothness1_g63095 , IOR1_g63095 , Fresnel1_g63095 , WorldPos1_g63095 , WorldNormal1_g63095 , ViewDir1_g63095 );
					float3 temp_output_2848_0_g63051 = localIndirectSpecular1_g63095;
					float grayscale2713_g63051 = Luminance( Lightmap46_g63051 );
					float smoothstepResult2430_g63051 = smoothstep( 0.0 , 0.05 , grayscale2713_g63051);
					#ifdef _USELIGHTMAPPEDREFLECTIONS_ON
					float3 staticSwitch1469_g63051 = ( temp_output_2848_0_g63051 * smoothstepResult2430_g63051 );
					#else
					float3 staticSwitch1469_g63051 = temp_output_2848_0_g63051;
					#endif
					float3 Indirect_Specular1419_g63051 = staticSwitch1469_g63051;
					float3 Color97_g63101 = oAlbedo6_g63051;
					float3 LightmapColor97_g63101 = Lightmap46_g63051;
					float Metallic97_g63101 = Metallic1239_g63051;
					float Smoothness2838_g63051 = staticSwitch1004_g63051;
					float Smoothness97_g63101 = Smoothness2838_g63051;
					float SmoothnessAA97_g63101 = SmoothnessAA1399_g63051;
					float IOR97_g63101 = IOR2700_g63051;
					float3 Fresnel97_g63101 = Fresnel1560_g63051;
					float3 WorldPos97_g63101 = World_Position2505_g63051;
					float3 WorldNormal97_g63101 = World_Normal2508_g63051;
					float3 ViewDir97_g63101 = View_Direction2511_g63051;
					float3 localDirectSpecular97_g63101 = DirectSpecular( Color97_g63101 , LightmapColor97_g63101 , Metallic97_g63101 , Smoothness97_g63101 , SmoothnessAA97_g63101 , IOR97_g63101 , Fresnel97_g63101 , WorldPos97_g63101 , WorldNormal97_g63101 , ViewDir97_g63101 );
					float3 Direct_Specular2560_g63051 = localDirectSpecular97_g63101;
					#ifdef SHADER_API_MOBILE
					float3 staticSwitch2856_g63051 = ( temp_output_1252_0_g63051 + Emission86_g63051 + Indirect_Specular1419_g63051 + Direct_Specular2560_g63051 );
					#else
					float3 staticSwitch2856_g63051 = ( temp_output_1252_0_g63051 + Emission86_g63051 );
					#endif
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch1181_g63051 = Lightmap46_g63051;
					#else
					float3 staticSwitch1181_g63051 = staticSwitch2856_g63051;
					#endif
					float3 Color_Saturate49_g63102 = saturate( staticSwitch1181_g63051 );
					float3 RGB16_g63103 = ( ( log10( ( ( Color_Saturate49_g63102 * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 );
					#ifdef _3DLUT
					float3 staticSwitch194_g63102 = tex3D( _3DLut, RGB16_g63103 ).rgb;
					#else
					float3 staticSwitch194_g63102 = Color_Saturate49_g63102;
					#endif
					float3 ThreeD_LUT51_g63102 = staticSwitch194_g63102;
					#ifdef SHADER_API_MOBILE
					float3 staticSwitch2854_g63051 = ThreeD_LUT51_g63102;
					#else
					float3 staticSwitch2854_g63051 = staticSwitch1181_g63051;
					#endif
					

					o.Albedo = staticSwitch1180_g63051;
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

					o.Emission = staticSwitch2854_g63051;
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
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;6057;0,-1280;Inherit;False;Meenphie;0;;63051;b3ba55a08dd6b49c7be16c6f35cf2033;6,1008,0,2632,0,2635,0,2619,0,2636,0,2670,0;0;5;FLOAT3;625;FLOAT3;624;FLOAT;156;FLOAT;427;FLOAT;1024
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5279;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;10;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5280;256,-1280;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;Meenphie/Standard/Opaque;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardBase;0;1;ForwardBase;17;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;44;Category;0;0;  Instanced Terrain Normals;1;0;Workflow;3;639079749420714040;Surface;0;0;  Blend;0;0;  Dither Shadows;1;0;Two Sided;1;0;Alpha Clipping;0;0;  Use Shadow Threshold;0;0;Deferred Pass;0;639079951064078170;Normal Space;0;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;0;639108440689538340;Receive Shadows;1;0;Receive Specular;0;639108440701916390;Receive Reflections;0;639108447998214750;GPU Instancing;1;0;LOD CrossFade;1;0;Built-in Fog;1;639105044169342440;Ambient Light;1;639111933610282130;Meta Pass;0;639111933576947160;Add Pass;0;639111933580732010;Override Baked GI;0;0;Write Depth;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;0;Vertex Position;1;0;0;8;False;True;False;False;False;False;True;True;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5281;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;10;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;True;1;LightMode=ForwardAdd;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5282;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;10;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5283;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;10;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5284;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;10;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5285;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;10;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5286;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;10;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ScenePickingPass;0;7;ScenePickingPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=Picking;False;False;0;;0;0;Standard;0;False;0
WireConnection;5280;0;6057;625
WireConnection;5280;2;6057;624
ASEEND*/
//CHKSM=BD72F4ACAB661023D30A04E12622FF35E240A507