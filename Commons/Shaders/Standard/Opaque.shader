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
		[Toggle( _USELIGHTMAPPEDREFLECTIONS_ON )] _UseLightmappedReflections( "Use Lightmapped Specular", Float ) = 1
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACELIGHTMAPPING( "CATEGORY SPACE LIGHTMAPPING", Float ) = 0
		[Meenphie_DrawerCategory(STOCHASTIC,true,0,0)] _CATEGORYSTOCHASTIC( "CATEGORY STOCHASTIC", Float ) = 0
		[Toggle( _STOCHASTICENABLED_ON )] _StochasticEnabled( "Stochastic Enabled", Float ) = 0
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESTOCHASTIC( "CATEGORY SPACE STOCHASTIC", Float ) = 0
		[Meenphie_DrawerCategory(COLOR GRADING,true,0,0)] _CATEGORYCOLORGRADING( "CATEGORY COLOR GRADING", Float ) = 0
		[NoScaleOffset][SingleLineTexture] _LUT( "LUT", 3D ) = "black" {}
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACECOLORGRADING( "CATEGORY SPACE COLOR GRADING", Float ) = 0
		[Meenphie_DrawerCategory(SPECIAL EFFECTS,true,0,0)] _CATEGORYSPECIALEFFECTS( "CATEGORY SPECIAL EFFECTS", Float ) = 0
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESPECIALEFFECTS( "CATEGORY SPACE SPECIAL EFFECTS", Float ) = 0
		[HideInInspector] GenKey__MainTex( "Assign keyword _MAINTEX", Float ) = 1.0
		[HideInInspector] GenKey__GlossinessMap( "Assign keyword _GLOSSINESSMAP", Float ) = 1.0
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0
		[HideInInspector] GenKey__MetallicMap( "Assign keyword _METALLICMAP", Float ) = 1.0


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
				uniform sampler3D _LUT;
				uniform float _UdonSpecularLightCount;
				uniform float4 _UdonSpecularLightUp[32];
				uniform float4 _UdonSpecularLightDir[32];
				uniform float4 _UdonSpecularLightCol[32];
				uniform float4 _UdonSpecularLightPos[32];
				uniform float4 _UdonSpecularLightRight[32];
				uniform half4 _Color;
				uniform sampler2D _MainTex;
				sampler2D _Sampler82966_g60061;
				uniform float3 _EmissionColor;
				uniform sampler2D _EmissionMap;
				sampler2D _Sampler82968_g60061;
				uniform float _EmissionIntensity;
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				sampler2D _Sampler82967_g60061;
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				sampler2D _Sampler82964_g60061;
				uniform sampler2D _BumpMap;
				sampler2D _Sampler82965_g60061;
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


				float3 IndirectSpecular1_g60097( float3 Color, float Metallic, float Smoothness, float IOR, float3 Fresnel, float3 WorldPos, float3 WorldNormal, float3 ViewDir )
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
				
				float3 DirectSpecular( float3 Color, float Metallic, float Smoothness, float SmoothnessAA, float IOR, float3 Fresnel, float3 Lightmap, float3 WorldPos, float3 WorldNormal, float3 ViewDir )
				{
					// --- CONFIGURATION ---
					static const float specBoost  = 0.01;
					static const float lumaStart  = 0.02;
					static const float lumaEnd    = 1.0;
					static const float metalBrightness = 10.0;
					static const float metalPeakMax    = 2.0;
					static const float maxVisibleDist = 16.0;
					static const float fadeStart      = 8.0;
					// --- INIT ---
					float3 N    = normalize(WorldNormal);
					float3 vDir = normalize(ViewDir);
					float3 R    = reflect(-vDir, N);
					// --- LIGHTMAP MASK ---
					float  luma   = dot(Lightmap, float3(0.2126, 0.7152, 0.0722));
					float  lmMask = smoothstep(lumaStart, lumaEnd, luma);
					float3 lmTint = lmMask * lerp(1.0, Lightmap / max(luma, 1e-4), Metallic);
					if (Smoothness < 0.0001 || _UdonSpecularLightCount < 0.5 || lmMask <= 0.0001) return 0.0;
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
					float peakRatio          = min(sqrt(alpha2AA / alpha2Orig), metalPeakMax);
					float metalPeakBoost     = lerp(0.0, peakRatio, metalBrightness);
					float energyCompensation = lerp(1.0, metalPeakBoost, Metallic);
					// 4. Perceptual falloff (dielectrics only)
					float logCurve  = 1.0 - sqrt(roughnessOrig);
					float finalFade = lerp(logCurve, 1.0, Metallic);
					// --- SPECULAR LOOP ---
					float  nDotV     = max(dot(N, vDir), 1e-4);
					float3 specAccum = 0;
					int    loopCount = (int)_UdonSpecularLightCount;
					for (int i = 0; i < loopCount; i++) {
					    float4 posRange = _UdonSpecularLightPos[i];
					    // Distance fade — full brightness within fadeStart, then linear falloff to maxVisibleDist
					    float camDist      = distance(_WorldSpaceCameraPos, posRange.xyz);
					    float distanceFade = saturate(1.0 - (camDist - fadeStart) / max(maxVisibleDist - fadeStart, 1e-4));
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
					float3 result = specAccum * colorTint * lmTint * specBoost * finalFade * energyCompensation;
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

					float2 texCoord2357_g60061 = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0A2420_g60061 = texCoord2357_g60061;
					#ifdef _MAINTEX
					float4 staticSwitch1549_g60061 = tex2D( _MainTex, UV0A2420_g60061 );
					#else
					float4 staticSwitch1549_g60061 = _Color;
					#endif
					float2 temp_output_5_0_g60076 = UV0A2420_g60061;
					float2 UV633_g60076 = temp_output_5_0_g60076;
					float2 UV100_g60077 = UV633_g60076;
					float2 temp_output_51_0_g60077 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60077 * float2( 3.464,3.464 ) ) );
					float2 break55_g60077 = frac( temp_output_51_0_g60077 );
					float temp_output_56_0_g60077 = ( ( 1.0 - break55_g60077.x ) - break55_g60077.y );
					float2 temp_output_52_0_g60077 = floor( temp_output_51_0_g60077 );
					float2 temp_output_125_0_g60077 = ( temp_output_52_0_g60077 + float2( 1,1 ) );
					float2 ifLocalVar87_g60077 = 0;
					if( temp_output_56_0_g60077 > 0.0 )
					ifLocalVar87_g60077 = temp_output_52_0_g60077;
					else if( temp_output_56_0_g60077 == 0.0 )
					ifLocalVar87_g60077 = temp_output_125_0_g60077;
					else if( temp_output_56_0_g60077 < 0.0 )
					ifLocalVar87_g60077 = temp_output_125_0_g60077;
					float3 temp_output_7_0_g60078 = frac( ( (ifLocalVar87_g60077).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60078 = dot( temp_output_7_0_g60078 , ( (temp_output_7_0_g60078).yzx + 33.33 ) );
					float3 temp_output_12_0_g60078 = ( temp_output_7_0_g60078 + dotResult8_g60078 );
					float2 temp_output_597_0_g60076 = ( UV100_g60077 + frac( ( ( (temp_output_12_0_g60078).xx + (temp_output_12_0_g60078).yz ) * (temp_output_12_0_g60078).zy ) ) );
					float2 DDX631_g60076 = ddx( temp_output_5_0_g60076 );
					float2 DDY632_g60076 = ddy( temp_output_5_0_g60076 );
					float temp_output_65_0_g60077 = ( 0.0 - temp_output_56_0_g60077 );
					float ifLocalVar59_g60077 = 0;
					if( temp_output_56_0_g60077 <= 0.0 )
					ifLocalVar59_g60077 = temp_output_65_0_g60077;
					else
					ifLocalVar59_g60077 = temp_output_56_0_g60077;
					float temp_output_597_30_g60076 = ifLocalVar59_g60077;
					float2 temp_output_90_0_g60077 = ( temp_output_52_0_g60077 + float2( 0,1 ) );
					float2 temp_output_123_0_g60077 = ( temp_output_52_0_g60077 + float2( 1,0 ) );
					float2 ifLocalVar88_g60077 = 0;
					if( temp_output_56_0_g60077 > 0.0 )
					ifLocalVar88_g60077 = temp_output_90_0_g60077;
					else if( temp_output_56_0_g60077 == 0.0 )
					ifLocalVar88_g60077 = temp_output_123_0_g60077;
					else if( temp_output_56_0_g60077 < 0.0 )
					ifLocalVar88_g60077 = temp_output_123_0_g60077;
					float3 temp_output_7_0_g60079 = frac( ( (ifLocalVar88_g60077).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60079 = dot( temp_output_7_0_g60079 , ( (temp_output_7_0_g60079).yzx + 33.33 ) );
					float3 temp_output_12_0_g60079 = ( temp_output_7_0_g60079 + dotResult8_g60079 );
					float2 temp_output_597_26_g60076 = ( UV100_g60077 + frac( ( ( (temp_output_12_0_g60079).xx + (temp_output_12_0_g60079).yz ) * (temp_output_12_0_g60079).zy ) ) );
					float temp_output_66_0_g60077 = ( 1.0 - break55_g60077.y );
					float ifLocalVar60_g60077 = 0;
					if( temp_output_56_0_g60077 <= 0.0 )
					ifLocalVar60_g60077 = temp_output_66_0_g60077;
					else
					ifLocalVar60_g60077 = break55_g60077.y;
					float temp_output_597_28_g60076 = ifLocalVar60_g60077;
					float2 ifLocalVar89_g60077 = 0;
					if( temp_output_56_0_g60077 > 0.0 )
					ifLocalVar89_g60077 = temp_output_123_0_g60077;
					else if( temp_output_56_0_g60077 == 0.0 )
					ifLocalVar89_g60077 = temp_output_90_0_g60077;
					else if( temp_output_56_0_g60077 < 0.0 )
					ifLocalVar89_g60077 = temp_output_90_0_g60077;
					float3 temp_output_7_0_g60080 = frac( ( (ifLocalVar89_g60077).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60080 = dot( temp_output_7_0_g60080 , ( (temp_output_7_0_g60080).yzx + 33.33 ) );
					float3 temp_output_12_0_g60080 = ( temp_output_7_0_g60080 + dotResult8_g60080 );
					float2 temp_output_597_27_g60076 = ( UV100_g60077 + frac( ( ( (temp_output_12_0_g60080).xx + (temp_output_12_0_g60080).yz ) * (temp_output_12_0_g60080).zy ) ) );
					float temp_output_67_0_g60077 = ( 1.0 - break55_g60077.x );
					float ifLocalVar61_g60077 = 0;
					if( temp_output_56_0_g60077 <= 0.0 )
					ifLocalVar61_g60077 = temp_output_67_0_g60077;
					else
					ifLocalVar61_g60077 = break55_g60077.x;
					float temp_output_597_29_g60076 = ifLocalVar61_g60077;
					float4 Output_2D293_g60076 = ( ( tex2D( _Sampler82966_g60061, temp_output_597_0_g60076, DDX631_g60076, DDY632_g60076 ) * temp_output_597_30_g60076 ) + ( tex2D( _Sampler82966_g60061, temp_output_597_26_g60076, DDX631_g60076, DDY632_g60076 ) * temp_output_597_28_g60076 ) + ( tex2D( _Sampler82966_g60061, temp_output_597_27_g60076, DDX631_g60076, DDY632_g60076 ) * temp_output_597_29_g60076 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g60061 = Output_2D293_g60076;
					#else
					float4 staticSwitch1001_g60061 = staticSwitch1549_g60061;
					#endif
					float3 temp_output_2532_0_g60061 = (staticSwitch1001_g60061).rgb;
					float3 oAlbedo6_g60061 = temp_output_2532_0_g60061;
					float Black1185_g60061 = 0.0;
					float3 temp_cast_0 = (Black1185_g60061).xxx;
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch1180_g60061 = temp_cast_0;
					#else
					float3 staticSwitch1180_g60061 = oAlbedo6_g60061;
					#endif
					
					float2 temp_output_5_0_g60086 = UV0A2420_g60061;
					float2 UV633_g60086 = temp_output_5_0_g60086;
					float2 UV100_g60087 = UV633_g60086;
					float2 temp_output_51_0_g60087 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60087 * float2( 3.464,3.464 ) ) );
					float2 break55_g60087 = frac( temp_output_51_0_g60087 );
					float temp_output_56_0_g60087 = ( ( 1.0 - break55_g60087.x ) - break55_g60087.y );
					float2 temp_output_52_0_g60087 = floor( temp_output_51_0_g60087 );
					float2 temp_output_125_0_g60087 = ( temp_output_52_0_g60087 + float2( 1,1 ) );
					float2 ifLocalVar87_g60087 = 0;
					if( temp_output_56_0_g60087 > 0.0 )
					ifLocalVar87_g60087 = temp_output_52_0_g60087;
					else if( temp_output_56_0_g60087 == 0.0 )
					ifLocalVar87_g60087 = temp_output_125_0_g60087;
					else if( temp_output_56_0_g60087 < 0.0 )
					ifLocalVar87_g60087 = temp_output_125_0_g60087;
					float3 temp_output_7_0_g60088 = frac( ( (ifLocalVar87_g60087).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60088 = dot( temp_output_7_0_g60088 , ( (temp_output_7_0_g60088).yzx + 33.33 ) );
					float3 temp_output_12_0_g60088 = ( temp_output_7_0_g60088 + dotResult8_g60088 );
					float2 temp_output_597_0_g60086 = ( UV100_g60087 + frac( ( ( (temp_output_12_0_g60088).xx + (temp_output_12_0_g60088).yz ) * (temp_output_12_0_g60088).zy ) ) );
					float2 DDX631_g60086 = ddx( temp_output_5_0_g60086 );
					float2 DDY632_g60086 = ddy( temp_output_5_0_g60086 );
					float temp_output_65_0_g60087 = ( 0.0 - temp_output_56_0_g60087 );
					float ifLocalVar59_g60087 = 0;
					if( temp_output_56_0_g60087 <= 0.0 )
					ifLocalVar59_g60087 = temp_output_65_0_g60087;
					else
					ifLocalVar59_g60087 = temp_output_56_0_g60087;
					float temp_output_597_30_g60086 = ifLocalVar59_g60087;
					float2 temp_output_90_0_g60087 = ( temp_output_52_0_g60087 + float2( 0,1 ) );
					float2 temp_output_123_0_g60087 = ( temp_output_52_0_g60087 + float2( 1,0 ) );
					float2 ifLocalVar88_g60087 = 0;
					if( temp_output_56_0_g60087 > 0.0 )
					ifLocalVar88_g60087 = temp_output_90_0_g60087;
					else if( temp_output_56_0_g60087 == 0.0 )
					ifLocalVar88_g60087 = temp_output_123_0_g60087;
					else if( temp_output_56_0_g60087 < 0.0 )
					ifLocalVar88_g60087 = temp_output_123_0_g60087;
					float3 temp_output_7_0_g60089 = frac( ( (ifLocalVar88_g60087).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60089 = dot( temp_output_7_0_g60089 , ( (temp_output_7_0_g60089).yzx + 33.33 ) );
					float3 temp_output_12_0_g60089 = ( temp_output_7_0_g60089 + dotResult8_g60089 );
					float2 temp_output_597_26_g60086 = ( UV100_g60087 + frac( ( ( (temp_output_12_0_g60089).xx + (temp_output_12_0_g60089).yz ) * (temp_output_12_0_g60089).zy ) ) );
					float temp_output_66_0_g60087 = ( 1.0 - break55_g60087.y );
					float ifLocalVar60_g60087 = 0;
					if( temp_output_56_0_g60087 <= 0.0 )
					ifLocalVar60_g60087 = temp_output_66_0_g60087;
					else
					ifLocalVar60_g60087 = break55_g60087.y;
					float temp_output_597_28_g60086 = ifLocalVar60_g60087;
					float2 ifLocalVar89_g60087 = 0;
					if( temp_output_56_0_g60087 > 0.0 )
					ifLocalVar89_g60087 = temp_output_123_0_g60087;
					else if( temp_output_56_0_g60087 == 0.0 )
					ifLocalVar89_g60087 = temp_output_90_0_g60087;
					else if( temp_output_56_0_g60087 < 0.0 )
					ifLocalVar89_g60087 = temp_output_90_0_g60087;
					float3 temp_output_7_0_g60090 = frac( ( (ifLocalVar89_g60087).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60090 = dot( temp_output_7_0_g60090 , ( (temp_output_7_0_g60090).yzx + 33.33 ) );
					float3 temp_output_12_0_g60090 = ( temp_output_7_0_g60090 + dotResult8_g60090 );
					float2 temp_output_597_27_g60086 = ( UV100_g60087 + frac( ( ( (temp_output_12_0_g60090).xx + (temp_output_12_0_g60090).yz ) * (temp_output_12_0_g60090).zy ) ) );
					float temp_output_67_0_g60087 = ( 1.0 - break55_g60087.x );
					float ifLocalVar61_g60087 = 0;
					if( temp_output_56_0_g60087 <= 0.0 )
					ifLocalVar61_g60087 = temp_output_67_0_g60087;
					else
					ifLocalVar61_g60087 = break55_g60087.x;
					float temp_output_597_29_g60086 = ifLocalVar61_g60087;
					float4 Output_2D293_g60086 = ( ( tex2D( _Sampler82968_g60061, temp_output_597_0_g60086, DDX631_g60086, DDY632_g60086 ) * temp_output_597_30_g60086 ) + ( tex2D( _Sampler82968_g60061, temp_output_597_26_g60086, DDX631_g60086, DDY632_g60086 ) * temp_output_597_28_g60086 ) + ( tex2D( _Sampler82968_g60061, temp_output_597_27_g60086, DDX631_g60086, DDY632_g60086 ) * temp_output_597_29_g60086 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g60061 = Output_2D293_g60086;
					#else
					float4 staticSwitch1006_g60061 = tex2D( _EmissionMap, UV0A2420_g60061 );
					#endif
					float3 temp_output_2531_0_g60061 = (( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g60061 * _EmissionIntensity )).rgb;
					float3 Emission86_g60061 = temp_output_2531_0_g60061;
					float3 Color1_g60097 = oAlbedo6_g60061;
					#ifdef _METALLICMAP
					float staticSwitch846_g60061 = tex2D( _MetallicMap, UV0A2420_g60061 ).r;
					#else
					float staticSwitch846_g60061 = _Metallic;
					#endif
					float2 temp_output_5_0_g60098 = UV0A2420_g60061;
					float2 UV633_g60098 = temp_output_5_0_g60098;
					float2 UV100_g60099 = UV633_g60098;
					float2 temp_output_51_0_g60099 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60099 * float2( 3.464,3.464 ) ) );
					float2 break55_g60099 = frac( temp_output_51_0_g60099 );
					float temp_output_56_0_g60099 = ( ( 1.0 - break55_g60099.x ) - break55_g60099.y );
					float2 temp_output_52_0_g60099 = floor( temp_output_51_0_g60099 );
					float2 temp_output_125_0_g60099 = ( temp_output_52_0_g60099 + float2( 1,1 ) );
					float2 ifLocalVar87_g60099 = 0;
					if( temp_output_56_0_g60099 > 0.0 )
					ifLocalVar87_g60099 = temp_output_52_0_g60099;
					else if( temp_output_56_0_g60099 == 0.0 )
					ifLocalVar87_g60099 = temp_output_125_0_g60099;
					else if( temp_output_56_0_g60099 < 0.0 )
					ifLocalVar87_g60099 = temp_output_125_0_g60099;
					float3 temp_output_7_0_g60100 = frac( ( (ifLocalVar87_g60099).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60100 = dot( temp_output_7_0_g60100 , ( (temp_output_7_0_g60100).yzx + 33.33 ) );
					float3 temp_output_12_0_g60100 = ( temp_output_7_0_g60100 + dotResult8_g60100 );
					float2 temp_output_597_0_g60098 = ( UV100_g60099 + frac( ( ( (temp_output_12_0_g60100).xx + (temp_output_12_0_g60100).yz ) * (temp_output_12_0_g60100).zy ) ) );
					float2 DDX631_g60098 = ddx( temp_output_5_0_g60098 );
					float2 DDY632_g60098 = ddy( temp_output_5_0_g60098 );
					float temp_output_65_0_g60099 = ( 0.0 - temp_output_56_0_g60099 );
					float ifLocalVar59_g60099 = 0;
					if( temp_output_56_0_g60099 <= 0.0 )
					ifLocalVar59_g60099 = temp_output_65_0_g60099;
					else
					ifLocalVar59_g60099 = temp_output_56_0_g60099;
					float temp_output_597_30_g60098 = ifLocalVar59_g60099;
					float2 temp_output_90_0_g60099 = ( temp_output_52_0_g60099 + float2( 0,1 ) );
					float2 temp_output_123_0_g60099 = ( temp_output_52_0_g60099 + float2( 1,0 ) );
					float2 ifLocalVar88_g60099 = 0;
					if( temp_output_56_0_g60099 > 0.0 )
					ifLocalVar88_g60099 = temp_output_90_0_g60099;
					else if( temp_output_56_0_g60099 == 0.0 )
					ifLocalVar88_g60099 = temp_output_123_0_g60099;
					else if( temp_output_56_0_g60099 < 0.0 )
					ifLocalVar88_g60099 = temp_output_123_0_g60099;
					float3 temp_output_7_0_g60101 = frac( ( (ifLocalVar88_g60099).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60101 = dot( temp_output_7_0_g60101 , ( (temp_output_7_0_g60101).yzx + 33.33 ) );
					float3 temp_output_12_0_g60101 = ( temp_output_7_0_g60101 + dotResult8_g60101 );
					float2 temp_output_597_26_g60098 = ( UV100_g60099 + frac( ( ( (temp_output_12_0_g60101).xx + (temp_output_12_0_g60101).yz ) * (temp_output_12_0_g60101).zy ) ) );
					float temp_output_66_0_g60099 = ( 1.0 - break55_g60099.y );
					float ifLocalVar60_g60099 = 0;
					if( temp_output_56_0_g60099 <= 0.0 )
					ifLocalVar60_g60099 = temp_output_66_0_g60099;
					else
					ifLocalVar60_g60099 = break55_g60099.y;
					float temp_output_597_28_g60098 = ifLocalVar60_g60099;
					float2 ifLocalVar89_g60099 = 0;
					if( temp_output_56_0_g60099 > 0.0 )
					ifLocalVar89_g60099 = temp_output_123_0_g60099;
					else if( temp_output_56_0_g60099 == 0.0 )
					ifLocalVar89_g60099 = temp_output_90_0_g60099;
					else if( temp_output_56_0_g60099 < 0.0 )
					ifLocalVar89_g60099 = temp_output_90_0_g60099;
					float3 temp_output_7_0_g60102 = frac( ( (ifLocalVar89_g60099).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60102 = dot( temp_output_7_0_g60102 , ( (temp_output_7_0_g60102).yzx + 33.33 ) );
					float3 temp_output_12_0_g60102 = ( temp_output_7_0_g60102 + dotResult8_g60102 );
					float2 temp_output_597_27_g60098 = ( UV100_g60099 + frac( ( ( (temp_output_12_0_g60102).xx + (temp_output_12_0_g60102).yz ) * (temp_output_12_0_g60102).zy ) ) );
					float temp_output_67_0_g60099 = ( 1.0 - break55_g60099.x );
					float ifLocalVar61_g60099 = 0;
					if( temp_output_56_0_g60099 <= 0.0 )
					ifLocalVar61_g60099 = temp_output_67_0_g60099;
					else
					ifLocalVar61_g60099 = break55_g60099.x;
					float temp_output_597_29_g60098 = ifLocalVar61_g60099;
					float4 Output_2D293_g60098 = ( ( tex2D( _Sampler82967_g60061, temp_output_597_0_g60098, DDX631_g60098, DDY632_g60098 ) * temp_output_597_30_g60098 ) + ( tex2D( _Sampler82967_g60061, temp_output_597_26_g60098, DDX631_g60098, DDY632_g60098 ) * temp_output_597_28_g60098 ) + ( tex2D( _Sampler82967_g60061, temp_output_597_27_g60098, DDX631_g60098, DDY632_g60098 ) * temp_output_597_29_g60098 ) );
					float4 break31_g60098 = Output_2D293_g60098;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g60061 = break31_g60098.r;
					#else
					float staticSwitch1005_g60061 = staticSwitch846_g60061;
					#endif
					float Metallic1239_g60061 = staticSwitch1005_g60061;
					float Metallic1_g60097 = Metallic1239_g60061;
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g60061 = tex2D( _GlossinessMap, UV0A2420_g60061 ).r;
					#else
					float staticSwitch845_g60061 = _Glossiness;
					#endif
					float2 temp_output_5_0_g60081 = UV0A2420_g60061;
					float2 UV633_g60081 = temp_output_5_0_g60081;
					float2 UV100_g60082 = UV633_g60081;
					float2 temp_output_51_0_g60082 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60082 * float2( 3.464,3.464 ) ) );
					float2 break55_g60082 = frac( temp_output_51_0_g60082 );
					float temp_output_56_0_g60082 = ( ( 1.0 - break55_g60082.x ) - break55_g60082.y );
					float2 temp_output_52_0_g60082 = floor( temp_output_51_0_g60082 );
					float2 temp_output_125_0_g60082 = ( temp_output_52_0_g60082 + float2( 1,1 ) );
					float2 ifLocalVar87_g60082 = 0;
					if( temp_output_56_0_g60082 > 0.0 )
					ifLocalVar87_g60082 = temp_output_52_0_g60082;
					else if( temp_output_56_0_g60082 == 0.0 )
					ifLocalVar87_g60082 = temp_output_125_0_g60082;
					else if( temp_output_56_0_g60082 < 0.0 )
					ifLocalVar87_g60082 = temp_output_125_0_g60082;
					float3 temp_output_7_0_g60083 = frac( ( (ifLocalVar87_g60082).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60083 = dot( temp_output_7_0_g60083 , ( (temp_output_7_0_g60083).yzx + 33.33 ) );
					float3 temp_output_12_0_g60083 = ( temp_output_7_0_g60083 + dotResult8_g60083 );
					float2 temp_output_597_0_g60081 = ( UV100_g60082 + frac( ( ( (temp_output_12_0_g60083).xx + (temp_output_12_0_g60083).yz ) * (temp_output_12_0_g60083).zy ) ) );
					float2 DDX631_g60081 = ddx( temp_output_5_0_g60081 );
					float2 DDY632_g60081 = ddy( temp_output_5_0_g60081 );
					float temp_output_65_0_g60082 = ( 0.0 - temp_output_56_0_g60082 );
					float ifLocalVar59_g60082 = 0;
					if( temp_output_56_0_g60082 <= 0.0 )
					ifLocalVar59_g60082 = temp_output_65_0_g60082;
					else
					ifLocalVar59_g60082 = temp_output_56_0_g60082;
					float temp_output_597_30_g60081 = ifLocalVar59_g60082;
					float2 temp_output_90_0_g60082 = ( temp_output_52_0_g60082 + float2( 0,1 ) );
					float2 temp_output_123_0_g60082 = ( temp_output_52_0_g60082 + float2( 1,0 ) );
					float2 ifLocalVar88_g60082 = 0;
					if( temp_output_56_0_g60082 > 0.0 )
					ifLocalVar88_g60082 = temp_output_90_0_g60082;
					else if( temp_output_56_0_g60082 == 0.0 )
					ifLocalVar88_g60082 = temp_output_123_0_g60082;
					else if( temp_output_56_0_g60082 < 0.0 )
					ifLocalVar88_g60082 = temp_output_123_0_g60082;
					float3 temp_output_7_0_g60084 = frac( ( (ifLocalVar88_g60082).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60084 = dot( temp_output_7_0_g60084 , ( (temp_output_7_0_g60084).yzx + 33.33 ) );
					float3 temp_output_12_0_g60084 = ( temp_output_7_0_g60084 + dotResult8_g60084 );
					float2 temp_output_597_26_g60081 = ( UV100_g60082 + frac( ( ( (temp_output_12_0_g60084).xx + (temp_output_12_0_g60084).yz ) * (temp_output_12_0_g60084).zy ) ) );
					float temp_output_66_0_g60082 = ( 1.0 - break55_g60082.y );
					float ifLocalVar60_g60082 = 0;
					if( temp_output_56_0_g60082 <= 0.0 )
					ifLocalVar60_g60082 = temp_output_66_0_g60082;
					else
					ifLocalVar60_g60082 = break55_g60082.y;
					float temp_output_597_28_g60081 = ifLocalVar60_g60082;
					float2 ifLocalVar89_g60082 = 0;
					if( temp_output_56_0_g60082 > 0.0 )
					ifLocalVar89_g60082 = temp_output_123_0_g60082;
					else if( temp_output_56_0_g60082 == 0.0 )
					ifLocalVar89_g60082 = temp_output_90_0_g60082;
					else if( temp_output_56_0_g60082 < 0.0 )
					ifLocalVar89_g60082 = temp_output_90_0_g60082;
					float3 temp_output_7_0_g60085 = frac( ( (ifLocalVar89_g60082).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60085 = dot( temp_output_7_0_g60085 , ( (temp_output_7_0_g60085).yzx + 33.33 ) );
					float3 temp_output_12_0_g60085 = ( temp_output_7_0_g60085 + dotResult8_g60085 );
					float2 temp_output_597_27_g60081 = ( UV100_g60082 + frac( ( ( (temp_output_12_0_g60085).xx + (temp_output_12_0_g60085).yz ) * (temp_output_12_0_g60085).zy ) ) );
					float temp_output_67_0_g60082 = ( 1.0 - break55_g60082.x );
					float ifLocalVar61_g60082 = 0;
					if( temp_output_56_0_g60082 <= 0.0 )
					ifLocalVar61_g60082 = temp_output_67_0_g60082;
					else
					ifLocalVar61_g60082 = break55_g60082.x;
					float temp_output_597_29_g60081 = ifLocalVar61_g60082;
					float4 Output_2D293_g60081 = ( ( tex2D( _Sampler82964_g60061, temp_output_597_0_g60081, DDX631_g60081, DDY632_g60081 ) * temp_output_597_30_g60081 ) + ( tex2D( _Sampler82964_g60061, temp_output_597_26_g60081, DDX631_g60081, DDY632_g60081 ) * temp_output_597_28_g60081 ) + ( tex2D( _Sampler82964_g60061, temp_output_597_27_g60081, DDX631_g60081, DDY632_g60081 ) * temp_output_597_29_g60081 ) );
					float4 break31_g60081 = Output_2D293_g60081;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g60061 = ( 1.0 - break31_g60081.r );
					#else
					float staticSwitch1004_g60061 = ( 1.0 - staticSwitch845_g60061 );
					#endif
					float temp_output_19_0_g60096 = staticSwitch1004_g60061;
					float2 temp_output_5_0_g60071 = UV0A2420_g60061;
					float2 UV633_g60071 = temp_output_5_0_g60071;
					float2 UV100_g60072 = UV633_g60071;
					float2 temp_output_51_0_g60072 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60072 * float2( 3.464,3.464 ) ) );
					float2 break55_g60072 = frac( temp_output_51_0_g60072 );
					float temp_output_56_0_g60072 = ( ( 1.0 - break55_g60072.x ) - break55_g60072.y );
					float2 temp_output_52_0_g60072 = floor( temp_output_51_0_g60072 );
					float2 temp_output_125_0_g60072 = ( temp_output_52_0_g60072 + float2( 1,1 ) );
					float2 ifLocalVar87_g60072 = 0;
					if( temp_output_56_0_g60072 > 0.0 )
					ifLocalVar87_g60072 = temp_output_52_0_g60072;
					else if( temp_output_56_0_g60072 == 0.0 )
					ifLocalVar87_g60072 = temp_output_125_0_g60072;
					else if( temp_output_56_0_g60072 < 0.0 )
					ifLocalVar87_g60072 = temp_output_125_0_g60072;
					float3 temp_output_7_0_g60073 = frac( ( (ifLocalVar87_g60072).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60073 = dot( temp_output_7_0_g60073 , ( (temp_output_7_0_g60073).yzx + 33.33 ) );
					float3 temp_output_12_0_g60073 = ( temp_output_7_0_g60073 + dotResult8_g60073 );
					float2 temp_output_597_0_g60071 = ( UV100_g60072 + frac( ( ( (temp_output_12_0_g60073).xx + (temp_output_12_0_g60073).yz ) * (temp_output_12_0_g60073).zy ) ) );
					float2 DDX631_g60071 = ddx( temp_output_5_0_g60071 );
					float2 DDY632_g60071 = ddy( temp_output_5_0_g60071 );
					float Input_Scale617_g60071 = 1.5;
					float temp_output_65_0_g60072 = ( 0.0 - temp_output_56_0_g60072 );
					float ifLocalVar59_g60072 = 0;
					if( temp_output_56_0_g60072 <= 0.0 )
					ifLocalVar59_g60072 = temp_output_65_0_g60072;
					else
					ifLocalVar59_g60072 = temp_output_56_0_g60072;
					float temp_output_597_30_g60071 = ifLocalVar59_g60072;
					float2 temp_output_90_0_g60072 = ( temp_output_52_0_g60072 + float2( 0,1 ) );
					float2 temp_output_123_0_g60072 = ( temp_output_52_0_g60072 + float2( 1,0 ) );
					float2 ifLocalVar88_g60072 = 0;
					if( temp_output_56_0_g60072 > 0.0 )
					ifLocalVar88_g60072 = temp_output_90_0_g60072;
					else if( temp_output_56_0_g60072 == 0.0 )
					ifLocalVar88_g60072 = temp_output_123_0_g60072;
					else if( temp_output_56_0_g60072 < 0.0 )
					ifLocalVar88_g60072 = temp_output_123_0_g60072;
					float3 temp_output_7_0_g60074 = frac( ( (ifLocalVar88_g60072).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60074 = dot( temp_output_7_0_g60074 , ( (temp_output_7_0_g60074).yzx + 33.33 ) );
					float3 temp_output_12_0_g60074 = ( temp_output_7_0_g60074 + dotResult8_g60074 );
					float2 temp_output_597_26_g60071 = ( UV100_g60072 + frac( ( ( (temp_output_12_0_g60074).xx + (temp_output_12_0_g60074).yz ) * (temp_output_12_0_g60074).zy ) ) );
					float temp_output_66_0_g60072 = ( 1.0 - break55_g60072.y );
					float ifLocalVar60_g60072 = 0;
					if( temp_output_56_0_g60072 <= 0.0 )
					ifLocalVar60_g60072 = temp_output_66_0_g60072;
					else
					ifLocalVar60_g60072 = break55_g60072.y;
					float temp_output_597_28_g60071 = ifLocalVar60_g60072;
					float2 ifLocalVar89_g60072 = 0;
					if( temp_output_56_0_g60072 > 0.0 )
					ifLocalVar89_g60072 = temp_output_123_0_g60072;
					else if( temp_output_56_0_g60072 == 0.0 )
					ifLocalVar89_g60072 = temp_output_90_0_g60072;
					else if( temp_output_56_0_g60072 < 0.0 )
					ifLocalVar89_g60072 = temp_output_90_0_g60072;
					float3 temp_output_7_0_g60075 = frac( ( (ifLocalVar89_g60072).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60075 = dot( temp_output_7_0_g60075 , ( (temp_output_7_0_g60075).yzx + 33.33 ) );
					float3 temp_output_12_0_g60075 = ( temp_output_7_0_g60075 + dotResult8_g60075 );
					float2 temp_output_597_27_g60071 = ( UV100_g60072 + frac( ( ( (temp_output_12_0_g60075).xx + (temp_output_12_0_g60075).yz ) * (temp_output_12_0_g60075).zy ) ) );
					float temp_output_67_0_g60072 = ( 1.0 - break55_g60072.x );
					float ifLocalVar61_g60072 = 0;
					if( temp_output_56_0_g60072 <= 0.0 )
					ifLocalVar61_g60072 = temp_output_67_0_g60072;
					else
					ifLocalVar61_g60072 = break55_g60072.x;
					float temp_output_597_29_g60071 = ifLocalVar61_g60072;
					float3 Output_2D_Normal641_g60071 = ( ( UnpackScaleNormal( tex2D( _Sampler82965_g60061, temp_output_597_0_g60071, DDX631_g60071, DDY632_g60071 ), Input_Scale617_g60071 ) * temp_output_597_30_g60071 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g60061, temp_output_597_26_g60071, DDX631_g60071, DDY632_g60071 ), Input_Scale617_g60071 ) * temp_output_597_28_g60071 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g60061, temp_output_597_27_g60071, DDX631_g60071, DDY632_g60071 ), Input_Scale617_g60071 ) * float3( 0,0,0 ) * temp_output_597_29_g60071 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g60061 = Output_2D_Normal641_g60071;
					#else
					float3 staticSwitch1003_g60061 = UnpackScaleNormal( tex2D( _BumpMap, UV0A2420_g60061 ), 1.5 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g60061 = staticSwitch1003_g60061;
					#else
					float3 staticSwitch980_g60061 = float3( 0, 0, 1 );
					#endif
					float3 normalizeResult2878_g60061 = normalize( staticSwitch980_g60061 );
					float3 Normal_Map700_g60061 = normalizeResult2878_g60061;
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal2504_g60061 = Normal_Map700_g60061;
					float3 worldNormal2504_g60061 = normalize( float3( dot( tanToWorld0, tanNormal2504_g60061 ), dot( tanToWorld1, tanNormal2504_g60061 ), dot( tanToWorld2, tanNormal2504_g60061 ) ) );
					float3 World_Normal2508_g60061 = worldNormal2504_g60061;
					float3 tanNormal2_g60096 = World_Normal2508_g60061;
					float3 worldNormal2_g60096 = float3( dot( tanToWorld0, tanNormal2_g60096 ), dot( tanToWorld1, tanNormal2_g60096 ), dot( tanToWorld2, tanNormal2_g60096 ) );
					float3 temp_output_3_0_g60096 = ddx( worldNormal2_g60096 );
					float dotResult5_g60096 = dot( temp_output_3_0_g60096 , temp_output_3_0_g60096 );
					float3 temp_output_4_0_g60096 = ddy( worldNormal2_g60096 );
					float dotResult6_g60096 = dot( temp_output_4_0_g60096 , temp_output_4_0_g60096 );
					#ifdef _USEGEOMETRICAA_ON
					float staticSwitch15_g60096 = min( temp_output_19_0_g60096, ( 1.0 - pow( saturate( max( dotResult5_g60096, dotResult6_g60096 ) ) , 0.25 ) ) );
					#else
					float staticSwitch15_g60096 = temp_output_19_0_g60096;
					#endif
					float SmoothnessAA1399_g60061 = staticSwitch15_g60096;
					float Smoothness1_g60097 = SmoothnessAA1399_g60061;
					float IOR2700_g60061 = _IOR;
					float IOR1_g60097 = IOR2700_g60061;
					float3 temp_cast_2 = (0.04).xxx;
					float3 lerpResult1473_g60061 = lerp( temp_cast_2 , oAlbedo6_g60061 , Metallic1239_g60061);
					float3 switchResult1501_g60061 = (((ase_vface>0)?(World_Normal2508_g60061):(-World_Normal2508_g60061)));
					float3 View_Direction2511_g60061 = ViewDirWS;
					float dotResult1476_g60061 = dot( switchResult1501_g60061 , View_Direction2511_g60061 );
					float3 lerpResult1480_g60061 = lerp( lerpResult1473_g60061 , float3( 1,1,1 ) , pow( ( 1.0 - saturate( dotResult1476_g60061 ) ) , 5.0 ));
					float3 Fresnel1560_g60061 = lerpResult1480_g60061;
					float3 Fresnel1_g60097 = Fresnel1560_g60061;
					float3 World_Position2505_g60061 = PositionWS;
					float3 WorldPos1_g60097 = World_Position2505_g60061;
					float3 WorldNormal1_g60097 = World_Normal2508_g60061;
					float3 ViewDir1_g60097 = View_Direction2511_g60061;
					float3 localIndirectSpecular1_g60097 = IndirectSpecular1_g60097( Color1_g60097 , Metallic1_g60097 , Smoothness1_g60097 , IOR1_g60097 , Fresnel1_g60097 , WorldPos1_g60097 , WorldNormal1_g60097 , ViewDir1_g60097 );
					float3 temp_output_2848_0_g60061 = localIndirectSpecular1_g60097;
					float White38_g60061 = 1.0;
					float4 temp_cast_3 = (White38_g60061).xxxx;
					float4 texCoord2426_g60061 = IN.ase_texcoord6;
					texCoord2426_g60061.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0B2361_g60061 = (texCoord2426_g60061).zw;
					float localBicubicPrepare2_g60070 = ( 0.0 );
					float2 Input_UV100_g60070 = UV0B2361_g60061;
					float2 UV2_g60070 = Input_UV100_g60070;
					float4 TexelSize2_g60070 = _Lightmap0_TexelSize;
					float2 UV02_g60070 = float2( 0,0 );
					float2 UV12_g60070 = float2( 0,0 );
					float2 UV22_g60070 = float2( 0,0 );
					float2 UV32_g60070 = float2( 0,0 );
					float W02_g60070 = 0;
					float W12_g60070 = 0;
					{
					{
					 UV2_g60070 = UV2_g60070 * TexelSize2_g60070.zw - 0.5;
					    float2 f = frac( UV2_g60070 );
					    UV2_g60070 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g60070.x - 0.5, UV2_g60070.x + 1.5, UV2_g60070.y - 0.5, UV2_g60070.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60070.xyxy;
					    UV02_g60070 = off.xz;
					    UV12_g60070 = off.yz;
					    UV22_g60070 = off.xw;
					    UV32_g60070 = off.yw;
					    W02_g60070 = s.x / ( s.x + s.y );
					 W12_g60070 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g60070 = lerp( tex2D( _Lightmap0, UV32_g60070 ) , tex2D( _Lightmap0, UV22_g60070 ) , W02_g60070);
					float4 lerpResult45_g60070 = lerp( tex2D( _Lightmap0, UV12_g60070 ) , tex2D( _Lightmap0, UV02_g60070 ) , W02_g60070);
					float4 lerpResult44_g60070 = lerp( lerpResult46_g60070 , lerpResult45_g60070 , W12_g60070);
					float4 Output_2D_Auto131_g60070 = lerpResult44_g60070;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g60061 = Output_2D_Auto131_g60070;
					#else
					float4 staticSwitch1092_g60061 = float4( tex2D( _Lightmap0, UV0B2361_g60061 ).rgb , 0.0 );
					#endif
					float4 Lightmap_0925_g60061 = staticSwitch1092_g60061;
					float localBicubicPrepare2_g60068 = ( 0.0 );
					float2 Input_UV100_g60068 = UV0B2361_g60061;
					float2 UV2_g60068 = Input_UV100_g60068;
					float4 TexelSize2_g60068 = _Lightmap1_TexelSize;
					float2 UV02_g60068 = float2( 0,0 );
					float2 UV12_g60068 = float2( 0,0 );
					float2 UV22_g60068 = float2( 0,0 );
					float2 UV32_g60068 = float2( 0,0 );
					float W02_g60068 = 0;
					float W12_g60068 = 0;
					{
					{
					 UV2_g60068 = UV2_g60068 * TexelSize2_g60068.zw - 0.5;
					    float2 f = frac( UV2_g60068 );
					    UV2_g60068 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g60068.x - 0.5, UV2_g60068.x + 1.5, UV2_g60068.y - 0.5, UV2_g60068.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60068.xyxy;
					    UV02_g60068 = off.xz;
					    UV12_g60068 = off.yz;
					    UV22_g60068 = off.xw;
					    UV32_g60068 = off.yw;
					    W02_g60068 = s.x / ( s.x + s.y );
					 W12_g60068 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g60068 = lerp( tex2D( _Lightmap1, UV32_g60068 ) , tex2D( _Lightmap1, UV22_g60068 ) , W02_g60068);
					float4 lerpResult45_g60068 = lerp( tex2D( _Lightmap1, UV12_g60068 ) , tex2D( _Lightmap1, UV02_g60068 ) , W02_g60068);
					float4 lerpResult44_g60068 = lerp( lerpResult46_g60068 , lerpResult45_g60068 , W12_g60068);
					float4 Output_2D_Auto131_g60068 = lerpResult44_g60068;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g60061 = Output_2D_Auto131_g60068;
					#else
					float4 staticSwitch1088_g60061 = tex2D( _Lightmap1, UV0B2361_g60061 );
					#endif
					float4 Lightmap_1956_g60061 = staticSwitch1088_g60061;
					float Lightmap_Lerp_Value969_g60061 = _UdonLightmapLerp;
					float4 lerpResult442_g60061 = lerp( Lightmap_0925_g60061 , Lightmap_1956_g60061 , Lightmap_Lerp_Value969_g60061);
					float4 Lightmap_Lerp932_g60061 = lerpResult442_g60061;
					float3 appendResult139_g60110 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 Normal_Map318_g60110 = Normal_Map700_g60061;
					float dotResult121_g60110 = dot( appendResult139_g60110 , Normal_Map318_g60110 );
					float temp_output_2_0_g60112 = saturate( dotResult121_g60110 );
					float localStochasticTiling2_g60092 = ( 0.0 );
					float2 UV2_g60092 = UV0B2361_g60061;
					float4 TexelSize2_g60092 = _UdonRNMX0_TexelSize;
					float4 Offsets2_g60092 = float4( 0,0,0,0 );
					float2 Weights2_g60092 = float2( 0,0 );
					{
					UV2_g60092 = UV2_g60092 * TexelSize2_g60092.zw - 0.5;
					float2 f = frac( UV2_g60092 );
					UV2_g60092 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g60092.x - 0.5, UV2_g60092.x + 1.5, UV2_g60092.y - 0.5, UV2_g60092.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g60092 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60092.xyxy;
					Weights2_g60092 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g60091 = Offsets2_g60092;
					float4 Input_FetchOffsets197_g60093 = temp_output_1_34_g60091;
					float2 temp_output_1_54_g60091 = Weights2_g60092;
					float2 Input_FetchWeights200_g60093 = temp_output_1_54_g60091;
					float2 break187_g60093 = Input_FetchWeights200_g60093;
					float4 lerpResult181_g60093 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60093).yw ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60093).xw ) , break187_g60093.x);
					float4 lerpResult182_g60093 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60093).yz ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60093).xz ) , break187_g60093.x);
					float4 lerpResult176_g60093 = lerp( lerpResult181_g60093 , lerpResult182_g60093 , break187_g60093.y);
					float4 Output_Fetch2D_Auto202_g60093 = lerpResult176_g60093;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g60061 = Output_Fetch2D_Auto202_g60093;
					#else
					float4 staticSwitch1061_g60061 = tex2D( _UdonRNMX0, UV0B2361_g60061 );
					#endif
					float3 appendResult146_g60110 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g60110 = dot( appendResult146_g60110 , Normal_Map318_g60110 );
					float temp_output_2_0_g60111 = saturate( dotResult122_g60110 );
					float4 Input_FetchOffsets197_g60094 = temp_output_1_34_g60091;
					float2 Input_FetchWeights200_g60094 = temp_output_1_54_g60091;
					float2 break187_g60094 = Input_FetchWeights200_g60094;
					float4 lerpResult181_g60094 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60094).yw ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60094).xw ) , break187_g60094.x);
					float4 lerpResult182_g60094 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60094).yz ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60094).xz ) , break187_g60094.x);
					float4 lerpResult176_g60094 = lerp( lerpResult181_g60094 , lerpResult182_g60094 , break187_g60094.y);
					float4 Output_Fetch2D_Auto202_g60094 = lerpResult176_g60094;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g60061 = Output_Fetch2D_Auto202_g60094;
					#else
					float4 staticSwitch1062_g60061 = tex2D( _UdonRNMY0, UV0B2361_g60061 );
					#endif
					float3 appendResult149_g60110 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g60110 = dot( appendResult149_g60110 , Normal_Map318_g60110 );
					float temp_output_2_0_g60113 = saturate( dotResult120_g60110 );
					float4 Input_FetchOffsets197_g60095 = temp_output_1_34_g60091;
					float2 Input_FetchWeights200_g60095 = temp_output_1_54_g60091;
					float2 break187_g60095 = Input_FetchWeights200_g60095;
					float4 lerpResult181_g60095 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60095).yw ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60095).xw ) , break187_g60095.x);
					float4 lerpResult182_g60095 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60095).yz ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60095).xz ) , break187_g60095.x);
					float4 lerpResult176_g60095 = lerp( lerpResult181_g60095 , lerpResult182_g60095 , break187_g60095.y);
					float4 Output_Fetch2D_Auto202_g60095 = lerpResult176_g60095;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g60061 = Output_Fetch2D_Auto202_g60095;
					#else
					float4 staticSwitch1063_g60061 = tex2D( _UdonRNMZ0, UV0B2361_g60061 );
					#endif
					float4 temp_output_24_0_g60110 = ( ( ( ( temp_output_2_0_g60112 * temp_output_2_0_g60112 ) * staticSwitch1061_g60061 ) + ( ( temp_output_2_0_g60111 * temp_output_2_0_g60111 ) * staticSwitch1062_g60061 ) ) + ( ( temp_output_2_0_g60113 * temp_output_2_0_g60113 ) * staticSwitch1063_g60061 ) );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch372_g60110 = ( temp_output_24_0_g60110 * 1.2 );
					#else
					float4 staticSwitch372_g60110 = temp_output_24_0_g60110;
					#endif
					float4 RNM_0926_g60061 = staticSwitch372_g60110;
					float3 appendResult139_g60106 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 Normal_Map318_g60106 = Normal_Map700_g60061;
					float dotResult121_g60106 = dot( appendResult139_g60106 , Normal_Map318_g60106 );
					float temp_output_2_0_g60108 = saturate( dotResult121_g60106 );
					float localStochasticTiling2_g60063 = ( 0.0 );
					float2 UV2_g60063 = UV0B2361_g60061;
					float4 TexelSize2_g60063 = _UdonRNMX1_TexelSize;
					float4 Offsets2_g60063 = float4( 0,0,0,0 );
					float2 Weights2_g60063 = float2( 0,0 );
					{
					UV2_g60063 = UV2_g60063 * TexelSize2_g60063.zw - 0.5;
					float2 f = frac( UV2_g60063 );
					UV2_g60063 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g60063.x - 0.5, UV2_g60063.x + 1.5, UV2_g60063.y - 0.5, UV2_g60063.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g60063 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60063.xyxy;
					Weights2_g60063 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g60062 = Offsets2_g60063;
					float4 Input_FetchOffsets197_g60064 = temp_output_1_34_g60062;
					float2 temp_output_1_54_g60062 = Weights2_g60063;
					float2 Input_FetchWeights200_g60064 = temp_output_1_54_g60062;
					float2 break187_g60064 = Input_FetchWeights200_g60064;
					float4 lerpResult181_g60064 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60064).yw ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60064).xw ) , break187_g60064.x);
					float4 lerpResult182_g60064 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60064).yz ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60064).xz ) , break187_g60064.x);
					float4 lerpResult176_g60064 = lerp( lerpResult181_g60064 , lerpResult182_g60064 , break187_g60064.y);
					float4 Output_Fetch2D_Auto202_g60064 = lerpResult176_g60064;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g60061 = Output_Fetch2D_Auto202_g60064;
					#else
					float4 staticSwitch1087_g60061 = tex2D( _UdonRNMX1, UV0B2361_g60061 );
					#endif
					float3 appendResult146_g60106 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g60106 = dot( appendResult146_g60106 , Normal_Map318_g60106 );
					float temp_output_2_0_g60107 = saturate( dotResult122_g60106 );
					float4 Input_FetchOffsets197_g60065 = temp_output_1_34_g60062;
					float2 Input_FetchWeights200_g60065 = temp_output_1_54_g60062;
					float2 break187_g60065 = Input_FetchWeights200_g60065;
					float4 lerpResult181_g60065 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60065).yw ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60065).xw ) , break187_g60065.x);
					float4 lerpResult182_g60065 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60065).yz ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60065).xz ) , break187_g60065.x);
					float4 lerpResult176_g60065 = lerp( lerpResult181_g60065 , lerpResult182_g60065 , break187_g60065.y);
					float4 Output_Fetch2D_Auto202_g60065 = lerpResult176_g60065;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g60061 = Output_Fetch2D_Auto202_g60065;
					#else
					float4 staticSwitch1083_g60061 = tex2D( _UdonRNMY1, UV0B2361_g60061 );
					#endif
					float3 appendResult149_g60106 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g60106 = dot( appendResult149_g60106 , Normal_Map318_g60106 );
					float temp_output_2_0_g60109 = saturate( dotResult120_g60106 );
					float4 Input_FetchOffsets197_g60066 = temp_output_1_34_g60062;
					float2 Input_FetchWeights200_g60066 = temp_output_1_54_g60062;
					float2 break187_g60066 = Input_FetchWeights200_g60066;
					float4 lerpResult181_g60066 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60066).yw ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60066).xw ) , break187_g60066.x);
					float4 lerpResult182_g60066 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60066).yz ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60066).xz ) , break187_g60066.x);
					float4 lerpResult176_g60066 = lerp( lerpResult181_g60066 , lerpResult182_g60066 , break187_g60066.y);
					float4 Output_Fetch2D_Auto202_g60066 = lerpResult176_g60066;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g60061 = Output_Fetch2D_Auto202_g60066;
					#else
					float4 staticSwitch1084_g60061 = tex2D( _UdonRNMZ1, UV0B2361_g60061 );
					#endif
					float4 temp_output_24_0_g60106 = ( ( ( ( temp_output_2_0_g60108 * temp_output_2_0_g60108 ) * staticSwitch1087_g60061 ) + ( ( temp_output_2_0_g60107 * temp_output_2_0_g60107 ) * staticSwitch1083_g60061 ) ) + ( ( temp_output_2_0_g60109 * temp_output_2_0_g60109 ) * staticSwitch1084_g60061 ) );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch372_g60106 = ( temp_output_24_0_g60106 * 1.2 );
					#else
					float4 staticSwitch372_g60106 = temp_output_24_0_g60106;
					#endif
					float4 RNM_11081_g60061 = staticSwitch372_g60106;
					float4 lerpResult953_g60061 = lerp( RNM_0926_g60061 , RNM_11081_g60061 , Lightmap_Lerp_Value969_g60061);
					float4 RNM_Lerp950_g60061 = lerpResult953_g60061;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g60061 = temp_cast_3;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g60061 = Lightmap_0925_g60061;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g60061 = Lightmap_Lerp932_g60061;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g60061 = RNM_0926_g60061;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g60061 = RNM_Lerp950_g60061;
					#else
					float4 staticSwitch1014_g60061 = temp_cast_3;
					#endif
					float3 Lightmap46_g60061 = (staticSwitch1014_g60061).rgb;
					float3 temp_output_6_0_g60114 = Lightmap46_g60061;
					float grayscale4_g60114 = Luminance( temp_output_6_0_g60114 );
					float smoothstepResult2_g60114 = smoothstep( 0.0 , 0.04 , grayscale4_g60114);
					#ifdef _USELIGHTMAPPEDREFLECTIONS_ON
					float3 staticSwitch1469_g60061 = ( temp_output_2848_0_g60061 * smoothstepResult2_g60114 );
					#else
					float3 staticSwitch1469_g60061 = temp_output_2848_0_g60061;
					#endif
					float3 Indirect_Specular1419_g60061 = staticSwitch1469_g60061;
					float3 Color97_g60115 = oAlbedo6_g60061;
					float Metallic97_g60115 = Metallic1239_g60061;
					float Smoothness2838_g60061 = staticSwitch1004_g60061;
					float Smoothness97_g60115 = Smoothness2838_g60061;
					float SmoothnessAA97_g60115 = SmoothnessAA1399_g60061;
					float IOR97_g60115 = IOR2700_g60061;
					float3 Fresnel97_g60115 = Fresnel1560_g60061;
					float3 Lightmap97_g60115 = Lightmap46_g60061;
					float3 WorldPos97_g60115 = World_Position2505_g60061;
					float3 WorldNormal97_g60115 = World_Normal2508_g60061;
					float3 ViewDir97_g60115 = View_Direction2511_g60061;
					float3 localDirectSpecular97_g60115 = DirectSpecular( Color97_g60115 , Metallic97_g60115 , Smoothness97_g60115 , SmoothnessAA97_g60115 , IOR97_g60115 , Fresnel97_g60115 , Lightmap97_g60115 , WorldPos97_g60115 , WorldNormal97_g60115 , ViewDir97_g60115 );
					float3 Direct_Specular2560_g60061 = localDirectSpecular97_g60115;
					float3 aAlbedo1466_g60061 = ( temp_output_2532_0_g60061 * ( 1.0 - Metallic1239_g60061 ) );
					float3 temp_output_1252_0_g60061 = ( aAlbedo1466_g60061 * Lightmap46_g60061 );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch1_g60103 = float4( ( temp_output_1252_0_g60061 + Emission86_g60061 + Indirect_Specular1419_g60061 ) , 0.0 );
					#else
					float4 staticSwitch1_g60103 = float4( ( Emission86_g60061 + Indirect_Specular1419_g60061 + Direct_Specular2560_g60061 + temp_output_1252_0_g60061 ) , 0.0 );
					#endif
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1181_g60061 = float4( Lightmap46_g60061 , 0.0 );
					#else
					float4 staticSwitch1181_g60061 = staticSwitch1_g60103;
					#endif
					float4 Color357_g60104 = staticSwitch1181_g60061;
					float4 LUT51_g60104 = tex3D( _LUT, ( ( log10( ( ( (Color357_g60104).xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 ) );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch359_g60104 = LUT51_g60104;
					#else
					float4 staticSwitch359_g60104 = Color357_g60104;
					#endif
					

					o.Albedo = staticSwitch1180_g60061;
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

					o.Emission = staticSwitch359_g60104.xyz;
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
				uniform sampler3D _LUT;
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
				uniform float _CATEGORYSPACESURFACEOPTIONS;
				uniform sampler3D _LUT;
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
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;6159;0,-1280;Inherit;False;Meenphie;0;;60061;b3ba55a08dd6b49c7be16c6f35cf2033;6,1008,0,2632,0,2635,0,2619,0,2636,0,2670,0;0;5;FLOAT3;625;FLOAT4;624;FLOAT;156;FLOAT;427;FLOAT;1024
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5279;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5280;256,-1280;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;Meenphie/Standard/Opaque;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardBase;0;1;ForwardBase;17;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;44;Category;0;0;  Instanced Terrain Normals;1;0;Workflow;3;639079749420714040;Surface;0;0;  Blend;0;0;  Dither Shadows;1;0;Two Sided;1;0;Alpha Clipping;0;0;  Use Shadow Threshold;0;0;Deferred Pass;0;639079951064078170;Normal Space;0;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;0;639108440689538340;Receive Shadows;1;0;Receive Specular;0;639108440701916390;Receive Reflections;0;639108447998214750;GPU Instancing;1;0;LOD CrossFade;1;0;Built-in Fog;1;639105044169342440;Ambient Light;1;639111933610282130;Meta Pass;0;639111933576947160;Add Pass;0;639111933580732010;Override Baked GI;0;0;Write Depth;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;0;Vertex Position;1;0;0;8;False;True;False;False;False;False;True;True;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5281;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;True;1;LightMode=ForwardAdd;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5282;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5283;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5284;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5285;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5286;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ScenePickingPass;0;7;ScenePickingPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=Picking;False;False;0;;0;0;Standard;0;False;0
WireConnection;5280;0;6159;625
WireConnection;5280;2;6159;624
ASEEND*/
//CHKSM=5E64AC89C8D04DF33DFA5174FB5131C5FEF9D35B