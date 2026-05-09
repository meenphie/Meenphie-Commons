// Made with Amplify Shader Editor v1.9.9.9
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Standard/Transparent/Additive"
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
		

		

		Tags { "RenderType"="Transparent" "Queue"="Transparent+2" "DisableBatching"="False" }

	LOD 0

		Cull Off
		AlphaToMask Off
		ZWrite Off
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

			Blend One One

			CGPROGRAM
				#define ASE_GEOMETRY
				#define ASE_FRAGMENT_NORMAL 0
				#define ASE_RECEIVE_SHADOWS
				#pragma multi_compile_instancing
				#pragma multi_compile _ LOD_FADE_CROSSFADE
				#pragma multi_compile_fog
				#define ASE_FOG
				#define _SPECULARHIGHLIGHTS_OFF
				#define ASE_LIGHTING_SIMPLE 1
				#define _GLOSSYREFLECTIONS_OFF
				#define ASE_NO_AMBIENT 1
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
				uniform float _UdonSpecularLightCount;
				uniform sampler3D _LUT;
				uniform float4 _UdonSpecularLightUp[32];
				uniform float4 _UdonSpecularLightDir[32];
				uniform float4 _UdonSpecularLightCol[32];
				uniform float4 _UdonSpecularLightPos[32];
				uniform float4 _UdonSpecularLightRight[32];
				uniform half4 _Color;
				uniform sampler2D _MainTex;
				sampler2D _Sampler82966_g60856;
				uniform float3 _EmissionColor;
				uniform sampler2D _EmissionMap;
				sampler2D _Sampler82968_g60856;
				uniform float _EmissionIntensity;
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				sampler2D _Sampler82967_g60856;
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				sampler2D _Sampler82964_g60856;
				uniform sampler2D _BumpMap;
				sampler2D _Sampler82965_g60856;
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


				float3 IndirectSpecular1_g60892( float3 Color, float Metallic, float Smoothness, float IOR, float3 Fresnel, float3 WorldPos, float3 WorldNormal, float3 ViewDir )
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
					static const float lumaEnd    = 0.5;
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

					float2 texCoord2357_g60856 = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0A2420_g60856 = texCoord2357_g60856;
					#ifdef _MAINTEX
					float4 staticSwitch1549_g60856 = tex2D( _MainTex, UV0A2420_g60856 );
					#else
					float4 staticSwitch1549_g60856 = _Color;
					#endif
					float2 temp_output_5_0_g60871 = UV0A2420_g60856;
					float2 UV633_g60871 = temp_output_5_0_g60871;
					float2 UV100_g60872 = UV633_g60871;
					float2 temp_output_51_0_g60872 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60872 * float2( 3.464,3.464 ) ) );
					float2 break55_g60872 = frac( temp_output_51_0_g60872 );
					float temp_output_56_0_g60872 = ( ( 1.0 - break55_g60872.x ) - break55_g60872.y );
					float2 temp_output_52_0_g60872 = floor( temp_output_51_0_g60872 );
					float2 temp_output_125_0_g60872 = ( temp_output_52_0_g60872 + float2( 1,1 ) );
					float2 ifLocalVar87_g60872 = 0;
					if( temp_output_56_0_g60872 > 0.0 )
					ifLocalVar87_g60872 = temp_output_52_0_g60872;
					else if( temp_output_56_0_g60872 == 0.0 )
					ifLocalVar87_g60872 = temp_output_125_0_g60872;
					else if( temp_output_56_0_g60872 < 0.0 )
					ifLocalVar87_g60872 = temp_output_125_0_g60872;
					float3 temp_output_7_0_g60873 = frac( ( (ifLocalVar87_g60872).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60873 = dot( temp_output_7_0_g60873 , ( (temp_output_7_0_g60873).yzx + 33.33 ) );
					float3 temp_output_12_0_g60873 = ( temp_output_7_0_g60873 + dotResult8_g60873 );
					float2 temp_output_597_0_g60871 = ( UV100_g60872 + frac( ( ( (temp_output_12_0_g60873).xx + (temp_output_12_0_g60873).yz ) * (temp_output_12_0_g60873).zy ) ) );
					float2 DDX631_g60871 = ddx( temp_output_5_0_g60871 );
					float2 DDY632_g60871 = ddy( temp_output_5_0_g60871 );
					float temp_output_65_0_g60872 = ( 0.0 - temp_output_56_0_g60872 );
					float ifLocalVar59_g60872 = 0;
					if( temp_output_56_0_g60872 <= 0.0 )
					ifLocalVar59_g60872 = temp_output_65_0_g60872;
					else
					ifLocalVar59_g60872 = temp_output_56_0_g60872;
					float temp_output_597_30_g60871 = ifLocalVar59_g60872;
					float2 temp_output_90_0_g60872 = ( temp_output_52_0_g60872 + float2( 0,1 ) );
					float2 temp_output_123_0_g60872 = ( temp_output_52_0_g60872 + float2( 1,0 ) );
					float2 ifLocalVar88_g60872 = 0;
					if( temp_output_56_0_g60872 > 0.0 )
					ifLocalVar88_g60872 = temp_output_90_0_g60872;
					else if( temp_output_56_0_g60872 == 0.0 )
					ifLocalVar88_g60872 = temp_output_123_0_g60872;
					else if( temp_output_56_0_g60872 < 0.0 )
					ifLocalVar88_g60872 = temp_output_123_0_g60872;
					float3 temp_output_7_0_g60874 = frac( ( (ifLocalVar88_g60872).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60874 = dot( temp_output_7_0_g60874 , ( (temp_output_7_0_g60874).yzx + 33.33 ) );
					float3 temp_output_12_0_g60874 = ( temp_output_7_0_g60874 + dotResult8_g60874 );
					float2 temp_output_597_26_g60871 = ( UV100_g60872 + frac( ( ( (temp_output_12_0_g60874).xx + (temp_output_12_0_g60874).yz ) * (temp_output_12_0_g60874).zy ) ) );
					float temp_output_66_0_g60872 = ( 1.0 - break55_g60872.y );
					float ifLocalVar60_g60872 = 0;
					if( temp_output_56_0_g60872 <= 0.0 )
					ifLocalVar60_g60872 = temp_output_66_0_g60872;
					else
					ifLocalVar60_g60872 = break55_g60872.y;
					float temp_output_597_28_g60871 = ifLocalVar60_g60872;
					float2 ifLocalVar89_g60872 = 0;
					if( temp_output_56_0_g60872 > 0.0 )
					ifLocalVar89_g60872 = temp_output_123_0_g60872;
					else if( temp_output_56_0_g60872 == 0.0 )
					ifLocalVar89_g60872 = temp_output_90_0_g60872;
					else if( temp_output_56_0_g60872 < 0.0 )
					ifLocalVar89_g60872 = temp_output_90_0_g60872;
					float3 temp_output_7_0_g60875 = frac( ( (ifLocalVar89_g60872).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60875 = dot( temp_output_7_0_g60875 , ( (temp_output_7_0_g60875).yzx + 33.33 ) );
					float3 temp_output_12_0_g60875 = ( temp_output_7_0_g60875 + dotResult8_g60875 );
					float2 temp_output_597_27_g60871 = ( UV100_g60872 + frac( ( ( (temp_output_12_0_g60875).xx + (temp_output_12_0_g60875).yz ) * (temp_output_12_0_g60875).zy ) ) );
					float temp_output_67_0_g60872 = ( 1.0 - break55_g60872.x );
					float ifLocalVar61_g60872 = 0;
					if( temp_output_56_0_g60872 <= 0.0 )
					ifLocalVar61_g60872 = temp_output_67_0_g60872;
					else
					ifLocalVar61_g60872 = break55_g60872.x;
					float temp_output_597_29_g60871 = ifLocalVar61_g60872;
					float4 Output_2D293_g60871 = ( ( tex2D( _Sampler82966_g60856, temp_output_597_0_g60871, DDX631_g60871, DDY632_g60871 ) * temp_output_597_30_g60871 ) + ( tex2D( _Sampler82966_g60856, temp_output_597_26_g60871, DDX631_g60871, DDY632_g60871 ) * temp_output_597_28_g60871 ) + ( tex2D( _Sampler82966_g60856, temp_output_597_27_g60871, DDX631_g60871, DDY632_g60871 ) * temp_output_597_29_g60871 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g60856 = Output_2D293_g60871;
					#else
					float4 staticSwitch1001_g60856 = staticSwitch1549_g60856;
					#endif
					float3 temp_output_2532_0_g60856 = (staticSwitch1001_g60856).rgb;
					float3 oAlbedo6_g60856 = temp_output_2532_0_g60856;
					float Black1185_g60856 = 0.0;
					float3 temp_cast_0 = (Black1185_g60856).xxx;
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch1180_g60856 = temp_cast_0;
					#else
					float3 staticSwitch1180_g60856 = oAlbedo6_g60856;
					#endif
					
					float2 temp_output_5_0_g60881 = UV0A2420_g60856;
					float2 UV633_g60881 = temp_output_5_0_g60881;
					float2 UV100_g60882 = UV633_g60881;
					float2 temp_output_51_0_g60882 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60882 * float2( 3.464,3.464 ) ) );
					float2 break55_g60882 = frac( temp_output_51_0_g60882 );
					float temp_output_56_0_g60882 = ( ( 1.0 - break55_g60882.x ) - break55_g60882.y );
					float2 temp_output_52_0_g60882 = floor( temp_output_51_0_g60882 );
					float2 temp_output_125_0_g60882 = ( temp_output_52_0_g60882 + float2( 1,1 ) );
					float2 ifLocalVar87_g60882 = 0;
					if( temp_output_56_0_g60882 > 0.0 )
					ifLocalVar87_g60882 = temp_output_52_0_g60882;
					else if( temp_output_56_0_g60882 == 0.0 )
					ifLocalVar87_g60882 = temp_output_125_0_g60882;
					else if( temp_output_56_0_g60882 < 0.0 )
					ifLocalVar87_g60882 = temp_output_125_0_g60882;
					float3 temp_output_7_0_g60883 = frac( ( (ifLocalVar87_g60882).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60883 = dot( temp_output_7_0_g60883 , ( (temp_output_7_0_g60883).yzx + 33.33 ) );
					float3 temp_output_12_0_g60883 = ( temp_output_7_0_g60883 + dotResult8_g60883 );
					float2 temp_output_597_0_g60881 = ( UV100_g60882 + frac( ( ( (temp_output_12_0_g60883).xx + (temp_output_12_0_g60883).yz ) * (temp_output_12_0_g60883).zy ) ) );
					float2 DDX631_g60881 = ddx( temp_output_5_0_g60881 );
					float2 DDY632_g60881 = ddy( temp_output_5_0_g60881 );
					float temp_output_65_0_g60882 = ( 0.0 - temp_output_56_0_g60882 );
					float ifLocalVar59_g60882 = 0;
					if( temp_output_56_0_g60882 <= 0.0 )
					ifLocalVar59_g60882 = temp_output_65_0_g60882;
					else
					ifLocalVar59_g60882 = temp_output_56_0_g60882;
					float temp_output_597_30_g60881 = ifLocalVar59_g60882;
					float2 temp_output_90_0_g60882 = ( temp_output_52_0_g60882 + float2( 0,1 ) );
					float2 temp_output_123_0_g60882 = ( temp_output_52_0_g60882 + float2( 1,0 ) );
					float2 ifLocalVar88_g60882 = 0;
					if( temp_output_56_0_g60882 > 0.0 )
					ifLocalVar88_g60882 = temp_output_90_0_g60882;
					else if( temp_output_56_0_g60882 == 0.0 )
					ifLocalVar88_g60882 = temp_output_123_0_g60882;
					else if( temp_output_56_0_g60882 < 0.0 )
					ifLocalVar88_g60882 = temp_output_123_0_g60882;
					float3 temp_output_7_0_g60884 = frac( ( (ifLocalVar88_g60882).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60884 = dot( temp_output_7_0_g60884 , ( (temp_output_7_0_g60884).yzx + 33.33 ) );
					float3 temp_output_12_0_g60884 = ( temp_output_7_0_g60884 + dotResult8_g60884 );
					float2 temp_output_597_26_g60881 = ( UV100_g60882 + frac( ( ( (temp_output_12_0_g60884).xx + (temp_output_12_0_g60884).yz ) * (temp_output_12_0_g60884).zy ) ) );
					float temp_output_66_0_g60882 = ( 1.0 - break55_g60882.y );
					float ifLocalVar60_g60882 = 0;
					if( temp_output_56_0_g60882 <= 0.0 )
					ifLocalVar60_g60882 = temp_output_66_0_g60882;
					else
					ifLocalVar60_g60882 = break55_g60882.y;
					float temp_output_597_28_g60881 = ifLocalVar60_g60882;
					float2 ifLocalVar89_g60882 = 0;
					if( temp_output_56_0_g60882 > 0.0 )
					ifLocalVar89_g60882 = temp_output_123_0_g60882;
					else if( temp_output_56_0_g60882 == 0.0 )
					ifLocalVar89_g60882 = temp_output_90_0_g60882;
					else if( temp_output_56_0_g60882 < 0.0 )
					ifLocalVar89_g60882 = temp_output_90_0_g60882;
					float3 temp_output_7_0_g60885 = frac( ( (ifLocalVar89_g60882).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60885 = dot( temp_output_7_0_g60885 , ( (temp_output_7_0_g60885).yzx + 33.33 ) );
					float3 temp_output_12_0_g60885 = ( temp_output_7_0_g60885 + dotResult8_g60885 );
					float2 temp_output_597_27_g60881 = ( UV100_g60882 + frac( ( ( (temp_output_12_0_g60885).xx + (temp_output_12_0_g60885).yz ) * (temp_output_12_0_g60885).zy ) ) );
					float temp_output_67_0_g60882 = ( 1.0 - break55_g60882.x );
					float ifLocalVar61_g60882 = 0;
					if( temp_output_56_0_g60882 <= 0.0 )
					ifLocalVar61_g60882 = temp_output_67_0_g60882;
					else
					ifLocalVar61_g60882 = break55_g60882.x;
					float temp_output_597_29_g60881 = ifLocalVar61_g60882;
					float4 Output_2D293_g60881 = ( ( tex2D( _Sampler82968_g60856, temp_output_597_0_g60881, DDX631_g60881, DDY632_g60881 ) * temp_output_597_30_g60881 ) + ( tex2D( _Sampler82968_g60856, temp_output_597_26_g60881, DDX631_g60881, DDY632_g60881 ) * temp_output_597_28_g60881 ) + ( tex2D( _Sampler82968_g60856, temp_output_597_27_g60881, DDX631_g60881, DDY632_g60881 ) * temp_output_597_29_g60881 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g60856 = Output_2D293_g60881;
					#else
					float4 staticSwitch1006_g60856 = tex2D( _EmissionMap, UV0A2420_g60856 );
					#endif
					float3 temp_output_2531_0_g60856 = (( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g60856 * _EmissionIntensity )).rgb;
					float3 Emission86_g60856 = temp_output_2531_0_g60856;
					float3 Color1_g60892 = oAlbedo6_g60856;
					#ifdef _METALLICMAP
					float staticSwitch846_g60856 = tex2D( _MetallicMap, UV0A2420_g60856 ).r;
					#else
					float staticSwitch846_g60856 = _Metallic;
					#endif
					float2 temp_output_5_0_g60893 = UV0A2420_g60856;
					float2 UV633_g60893 = temp_output_5_0_g60893;
					float2 UV100_g60894 = UV633_g60893;
					float2 temp_output_51_0_g60894 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60894 * float2( 3.464,3.464 ) ) );
					float2 break55_g60894 = frac( temp_output_51_0_g60894 );
					float temp_output_56_0_g60894 = ( ( 1.0 - break55_g60894.x ) - break55_g60894.y );
					float2 temp_output_52_0_g60894 = floor( temp_output_51_0_g60894 );
					float2 temp_output_125_0_g60894 = ( temp_output_52_0_g60894 + float2( 1,1 ) );
					float2 ifLocalVar87_g60894 = 0;
					if( temp_output_56_0_g60894 > 0.0 )
					ifLocalVar87_g60894 = temp_output_52_0_g60894;
					else if( temp_output_56_0_g60894 == 0.0 )
					ifLocalVar87_g60894 = temp_output_125_0_g60894;
					else if( temp_output_56_0_g60894 < 0.0 )
					ifLocalVar87_g60894 = temp_output_125_0_g60894;
					float3 temp_output_7_0_g60895 = frac( ( (ifLocalVar87_g60894).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60895 = dot( temp_output_7_0_g60895 , ( (temp_output_7_0_g60895).yzx + 33.33 ) );
					float3 temp_output_12_0_g60895 = ( temp_output_7_0_g60895 + dotResult8_g60895 );
					float2 temp_output_597_0_g60893 = ( UV100_g60894 + frac( ( ( (temp_output_12_0_g60895).xx + (temp_output_12_0_g60895).yz ) * (temp_output_12_0_g60895).zy ) ) );
					float2 DDX631_g60893 = ddx( temp_output_5_0_g60893 );
					float2 DDY632_g60893 = ddy( temp_output_5_0_g60893 );
					float temp_output_65_0_g60894 = ( 0.0 - temp_output_56_0_g60894 );
					float ifLocalVar59_g60894 = 0;
					if( temp_output_56_0_g60894 <= 0.0 )
					ifLocalVar59_g60894 = temp_output_65_0_g60894;
					else
					ifLocalVar59_g60894 = temp_output_56_0_g60894;
					float temp_output_597_30_g60893 = ifLocalVar59_g60894;
					float2 temp_output_90_0_g60894 = ( temp_output_52_0_g60894 + float2( 0,1 ) );
					float2 temp_output_123_0_g60894 = ( temp_output_52_0_g60894 + float2( 1,0 ) );
					float2 ifLocalVar88_g60894 = 0;
					if( temp_output_56_0_g60894 > 0.0 )
					ifLocalVar88_g60894 = temp_output_90_0_g60894;
					else if( temp_output_56_0_g60894 == 0.0 )
					ifLocalVar88_g60894 = temp_output_123_0_g60894;
					else if( temp_output_56_0_g60894 < 0.0 )
					ifLocalVar88_g60894 = temp_output_123_0_g60894;
					float3 temp_output_7_0_g60896 = frac( ( (ifLocalVar88_g60894).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60896 = dot( temp_output_7_0_g60896 , ( (temp_output_7_0_g60896).yzx + 33.33 ) );
					float3 temp_output_12_0_g60896 = ( temp_output_7_0_g60896 + dotResult8_g60896 );
					float2 temp_output_597_26_g60893 = ( UV100_g60894 + frac( ( ( (temp_output_12_0_g60896).xx + (temp_output_12_0_g60896).yz ) * (temp_output_12_0_g60896).zy ) ) );
					float temp_output_66_0_g60894 = ( 1.0 - break55_g60894.y );
					float ifLocalVar60_g60894 = 0;
					if( temp_output_56_0_g60894 <= 0.0 )
					ifLocalVar60_g60894 = temp_output_66_0_g60894;
					else
					ifLocalVar60_g60894 = break55_g60894.y;
					float temp_output_597_28_g60893 = ifLocalVar60_g60894;
					float2 ifLocalVar89_g60894 = 0;
					if( temp_output_56_0_g60894 > 0.0 )
					ifLocalVar89_g60894 = temp_output_123_0_g60894;
					else if( temp_output_56_0_g60894 == 0.0 )
					ifLocalVar89_g60894 = temp_output_90_0_g60894;
					else if( temp_output_56_0_g60894 < 0.0 )
					ifLocalVar89_g60894 = temp_output_90_0_g60894;
					float3 temp_output_7_0_g60897 = frac( ( (ifLocalVar89_g60894).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60897 = dot( temp_output_7_0_g60897 , ( (temp_output_7_0_g60897).yzx + 33.33 ) );
					float3 temp_output_12_0_g60897 = ( temp_output_7_0_g60897 + dotResult8_g60897 );
					float2 temp_output_597_27_g60893 = ( UV100_g60894 + frac( ( ( (temp_output_12_0_g60897).xx + (temp_output_12_0_g60897).yz ) * (temp_output_12_0_g60897).zy ) ) );
					float temp_output_67_0_g60894 = ( 1.0 - break55_g60894.x );
					float ifLocalVar61_g60894 = 0;
					if( temp_output_56_0_g60894 <= 0.0 )
					ifLocalVar61_g60894 = temp_output_67_0_g60894;
					else
					ifLocalVar61_g60894 = break55_g60894.x;
					float temp_output_597_29_g60893 = ifLocalVar61_g60894;
					float4 Output_2D293_g60893 = ( ( tex2D( _Sampler82967_g60856, temp_output_597_0_g60893, DDX631_g60893, DDY632_g60893 ) * temp_output_597_30_g60893 ) + ( tex2D( _Sampler82967_g60856, temp_output_597_26_g60893, DDX631_g60893, DDY632_g60893 ) * temp_output_597_28_g60893 ) + ( tex2D( _Sampler82967_g60856, temp_output_597_27_g60893, DDX631_g60893, DDY632_g60893 ) * temp_output_597_29_g60893 ) );
					float4 break31_g60893 = Output_2D293_g60893;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g60856 = break31_g60893.r;
					#else
					float staticSwitch1005_g60856 = staticSwitch846_g60856;
					#endif
					float Metallic1239_g60856 = staticSwitch1005_g60856;
					float Metallic1_g60892 = Metallic1239_g60856;
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g60856 = tex2D( _GlossinessMap, UV0A2420_g60856 ).r;
					#else
					float staticSwitch845_g60856 = _Glossiness;
					#endif
					float2 temp_output_5_0_g60876 = UV0A2420_g60856;
					float2 UV633_g60876 = temp_output_5_0_g60876;
					float2 UV100_g60877 = UV633_g60876;
					float2 temp_output_51_0_g60877 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60877 * float2( 3.464,3.464 ) ) );
					float2 break55_g60877 = frac( temp_output_51_0_g60877 );
					float temp_output_56_0_g60877 = ( ( 1.0 - break55_g60877.x ) - break55_g60877.y );
					float2 temp_output_52_0_g60877 = floor( temp_output_51_0_g60877 );
					float2 temp_output_125_0_g60877 = ( temp_output_52_0_g60877 + float2( 1,1 ) );
					float2 ifLocalVar87_g60877 = 0;
					if( temp_output_56_0_g60877 > 0.0 )
					ifLocalVar87_g60877 = temp_output_52_0_g60877;
					else if( temp_output_56_0_g60877 == 0.0 )
					ifLocalVar87_g60877 = temp_output_125_0_g60877;
					else if( temp_output_56_0_g60877 < 0.0 )
					ifLocalVar87_g60877 = temp_output_125_0_g60877;
					float3 temp_output_7_0_g60878 = frac( ( (ifLocalVar87_g60877).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60878 = dot( temp_output_7_0_g60878 , ( (temp_output_7_0_g60878).yzx + 33.33 ) );
					float3 temp_output_12_0_g60878 = ( temp_output_7_0_g60878 + dotResult8_g60878 );
					float2 temp_output_597_0_g60876 = ( UV100_g60877 + frac( ( ( (temp_output_12_0_g60878).xx + (temp_output_12_0_g60878).yz ) * (temp_output_12_0_g60878).zy ) ) );
					float2 DDX631_g60876 = ddx( temp_output_5_0_g60876 );
					float2 DDY632_g60876 = ddy( temp_output_5_0_g60876 );
					float temp_output_65_0_g60877 = ( 0.0 - temp_output_56_0_g60877 );
					float ifLocalVar59_g60877 = 0;
					if( temp_output_56_0_g60877 <= 0.0 )
					ifLocalVar59_g60877 = temp_output_65_0_g60877;
					else
					ifLocalVar59_g60877 = temp_output_56_0_g60877;
					float temp_output_597_30_g60876 = ifLocalVar59_g60877;
					float2 temp_output_90_0_g60877 = ( temp_output_52_0_g60877 + float2( 0,1 ) );
					float2 temp_output_123_0_g60877 = ( temp_output_52_0_g60877 + float2( 1,0 ) );
					float2 ifLocalVar88_g60877 = 0;
					if( temp_output_56_0_g60877 > 0.0 )
					ifLocalVar88_g60877 = temp_output_90_0_g60877;
					else if( temp_output_56_0_g60877 == 0.0 )
					ifLocalVar88_g60877 = temp_output_123_0_g60877;
					else if( temp_output_56_0_g60877 < 0.0 )
					ifLocalVar88_g60877 = temp_output_123_0_g60877;
					float3 temp_output_7_0_g60879 = frac( ( (ifLocalVar88_g60877).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60879 = dot( temp_output_7_0_g60879 , ( (temp_output_7_0_g60879).yzx + 33.33 ) );
					float3 temp_output_12_0_g60879 = ( temp_output_7_0_g60879 + dotResult8_g60879 );
					float2 temp_output_597_26_g60876 = ( UV100_g60877 + frac( ( ( (temp_output_12_0_g60879).xx + (temp_output_12_0_g60879).yz ) * (temp_output_12_0_g60879).zy ) ) );
					float temp_output_66_0_g60877 = ( 1.0 - break55_g60877.y );
					float ifLocalVar60_g60877 = 0;
					if( temp_output_56_0_g60877 <= 0.0 )
					ifLocalVar60_g60877 = temp_output_66_0_g60877;
					else
					ifLocalVar60_g60877 = break55_g60877.y;
					float temp_output_597_28_g60876 = ifLocalVar60_g60877;
					float2 ifLocalVar89_g60877 = 0;
					if( temp_output_56_0_g60877 > 0.0 )
					ifLocalVar89_g60877 = temp_output_123_0_g60877;
					else if( temp_output_56_0_g60877 == 0.0 )
					ifLocalVar89_g60877 = temp_output_90_0_g60877;
					else if( temp_output_56_0_g60877 < 0.0 )
					ifLocalVar89_g60877 = temp_output_90_0_g60877;
					float3 temp_output_7_0_g60880 = frac( ( (ifLocalVar89_g60877).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60880 = dot( temp_output_7_0_g60880 , ( (temp_output_7_0_g60880).yzx + 33.33 ) );
					float3 temp_output_12_0_g60880 = ( temp_output_7_0_g60880 + dotResult8_g60880 );
					float2 temp_output_597_27_g60876 = ( UV100_g60877 + frac( ( ( (temp_output_12_0_g60880).xx + (temp_output_12_0_g60880).yz ) * (temp_output_12_0_g60880).zy ) ) );
					float temp_output_67_0_g60877 = ( 1.0 - break55_g60877.x );
					float ifLocalVar61_g60877 = 0;
					if( temp_output_56_0_g60877 <= 0.0 )
					ifLocalVar61_g60877 = temp_output_67_0_g60877;
					else
					ifLocalVar61_g60877 = break55_g60877.x;
					float temp_output_597_29_g60876 = ifLocalVar61_g60877;
					float4 Output_2D293_g60876 = ( ( tex2D( _Sampler82964_g60856, temp_output_597_0_g60876, DDX631_g60876, DDY632_g60876 ) * temp_output_597_30_g60876 ) + ( tex2D( _Sampler82964_g60856, temp_output_597_26_g60876, DDX631_g60876, DDY632_g60876 ) * temp_output_597_28_g60876 ) + ( tex2D( _Sampler82964_g60856, temp_output_597_27_g60876, DDX631_g60876, DDY632_g60876 ) * temp_output_597_29_g60876 ) );
					float4 break31_g60876 = Output_2D293_g60876;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g60856 = ( 1.0 - break31_g60876.r );
					#else
					float staticSwitch1004_g60856 = ( 1.0 - staticSwitch845_g60856 );
					#endif
					float temp_output_19_0_g60891 = staticSwitch1004_g60856;
					float2 temp_output_5_0_g60866 = UV0A2420_g60856;
					float2 UV633_g60866 = temp_output_5_0_g60866;
					float2 UV100_g60867 = UV633_g60866;
					float2 temp_output_51_0_g60867 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60867 * float2( 3.464,3.464 ) ) );
					float2 break55_g60867 = frac( temp_output_51_0_g60867 );
					float temp_output_56_0_g60867 = ( ( 1.0 - break55_g60867.x ) - break55_g60867.y );
					float2 temp_output_52_0_g60867 = floor( temp_output_51_0_g60867 );
					float2 temp_output_125_0_g60867 = ( temp_output_52_0_g60867 + float2( 1,1 ) );
					float2 ifLocalVar87_g60867 = 0;
					if( temp_output_56_0_g60867 > 0.0 )
					ifLocalVar87_g60867 = temp_output_52_0_g60867;
					else if( temp_output_56_0_g60867 == 0.0 )
					ifLocalVar87_g60867 = temp_output_125_0_g60867;
					else if( temp_output_56_0_g60867 < 0.0 )
					ifLocalVar87_g60867 = temp_output_125_0_g60867;
					float3 temp_output_7_0_g60868 = frac( ( (ifLocalVar87_g60867).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60868 = dot( temp_output_7_0_g60868 , ( (temp_output_7_0_g60868).yzx + 33.33 ) );
					float3 temp_output_12_0_g60868 = ( temp_output_7_0_g60868 + dotResult8_g60868 );
					float2 temp_output_597_0_g60866 = ( UV100_g60867 + frac( ( ( (temp_output_12_0_g60868).xx + (temp_output_12_0_g60868).yz ) * (temp_output_12_0_g60868).zy ) ) );
					float2 DDX631_g60866 = ddx( temp_output_5_0_g60866 );
					float2 DDY632_g60866 = ddy( temp_output_5_0_g60866 );
					float Input_Scale617_g60866 = 1.5;
					float temp_output_65_0_g60867 = ( 0.0 - temp_output_56_0_g60867 );
					float ifLocalVar59_g60867 = 0;
					if( temp_output_56_0_g60867 <= 0.0 )
					ifLocalVar59_g60867 = temp_output_65_0_g60867;
					else
					ifLocalVar59_g60867 = temp_output_56_0_g60867;
					float temp_output_597_30_g60866 = ifLocalVar59_g60867;
					float2 temp_output_90_0_g60867 = ( temp_output_52_0_g60867 + float2( 0,1 ) );
					float2 temp_output_123_0_g60867 = ( temp_output_52_0_g60867 + float2( 1,0 ) );
					float2 ifLocalVar88_g60867 = 0;
					if( temp_output_56_0_g60867 > 0.0 )
					ifLocalVar88_g60867 = temp_output_90_0_g60867;
					else if( temp_output_56_0_g60867 == 0.0 )
					ifLocalVar88_g60867 = temp_output_123_0_g60867;
					else if( temp_output_56_0_g60867 < 0.0 )
					ifLocalVar88_g60867 = temp_output_123_0_g60867;
					float3 temp_output_7_0_g60869 = frac( ( (ifLocalVar88_g60867).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60869 = dot( temp_output_7_0_g60869 , ( (temp_output_7_0_g60869).yzx + 33.33 ) );
					float3 temp_output_12_0_g60869 = ( temp_output_7_0_g60869 + dotResult8_g60869 );
					float2 temp_output_597_26_g60866 = ( UV100_g60867 + frac( ( ( (temp_output_12_0_g60869).xx + (temp_output_12_0_g60869).yz ) * (temp_output_12_0_g60869).zy ) ) );
					float temp_output_66_0_g60867 = ( 1.0 - break55_g60867.y );
					float ifLocalVar60_g60867 = 0;
					if( temp_output_56_0_g60867 <= 0.0 )
					ifLocalVar60_g60867 = temp_output_66_0_g60867;
					else
					ifLocalVar60_g60867 = break55_g60867.y;
					float temp_output_597_28_g60866 = ifLocalVar60_g60867;
					float2 ifLocalVar89_g60867 = 0;
					if( temp_output_56_0_g60867 > 0.0 )
					ifLocalVar89_g60867 = temp_output_123_0_g60867;
					else if( temp_output_56_0_g60867 == 0.0 )
					ifLocalVar89_g60867 = temp_output_90_0_g60867;
					else if( temp_output_56_0_g60867 < 0.0 )
					ifLocalVar89_g60867 = temp_output_90_0_g60867;
					float3 temp_output_7_0_g60870 = frac( ( (ifLocalVar89_g60867).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60870 = dot( temp_output_7_0_g60870 , ( (temp_output_7_0_g60870).yzx + 33.33 ) );
					float3 temp_output_12_0_g60870 = ( temp_output_7_0_g60870 + dotResult8_g60870 );
					float2 temp_output_597_27_g60866 = ( UV100_g60867 + frac( ( ( (temp_output_12_0_g60870).xx + (temp_output_12_0_g60870).yz ) * (temp_output_12_0_g60870).zy ) ) );
					float temp_output_67_0_g60867 = ( 1.0 - break55_g60867.x );
					float ifLocalVar61_g60867 = 0;
					if( temp_output_56_0_g60867 <= 0.0 )
					ifLocalVar61_g60867 = temp_output_67_0_g60867;
					else
					ifLocalVar61_g60867 = break55_g60867.x;
					float temp_output_597_29_g60866 = ifLocalVar61_g60867;
					float3 Output_2D_Normal641_g60866 = ( ( UnpackScaleNormal( tex2D( _Sampler82965_g60856, temp_output_597_0_g60866, DDX631_g60866, DDY632_g60866 ), Input_Scale617_g60866 ) * temp_output_597_30_g60866 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g60856, temp_output_597_26_g60866, DDX631_g60866, DDY632_g60866 ), Input_Scale617_g60866 ) * temp_output_597_28_g60866 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g60856, temp_output_597_27_g60866, DDX631_g60866, DDY632_g60866 ), Input_Scale617_g60866 ) * float3( 0,0,0 ) * temp_output_597_29_g60866 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g60856 = Output_2D_Normal641_g60866;
					#else
					float3 staticSwitch1003_g60856 = UnpackScaleNormal( tex2D( _BumpMap, UV0A2420_g60856 ), 1.5 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g60856 = staticSwitch1003_g60856;
					#else
					float3 staticSwitch980_g60856 = float3( 0, 0, 1 );
					#endif
					float3 normalizeResult2878_g60856 = normalize( staticSwitch980_g60856 );
					float3 Normal_Map700_g60856 = normalizeResult2878_g60856;
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal2504_g60856 = Normal_Map700_g60856;
					float3 worldNormal2504_g60856 = normalize( float3( dot( tanToWorld0, tanNormal2504_g60856 ), dot( tanToWorld1, tanNormal2504_g60856 ), dot( tanToWorld2, tanNormal2504_g60856 ) ) );
					float3 World_Normal2508_g60856 = worldNormal2504_g60856;
					float3 tanNormal2_g60891 = World_Normal2508_g60856;
					float3 worldNormal2_g60891 = float3( dot( tanToWorld0, tanNormal2_g60891 ), dot( tanToWorld1, tanNormal2_g60891 ), dot( tanToWorld2, tanNormal2_g60891 ) );
					float3 temp_output_3_0_g60891 = ddx( worldNormal2_g60891 );
					float dotResult5_g60891 = dot( temp_output_3_0_g60891 , temp_output_3_0_g60891 );
					float3 temp_output_4_0_g60891 = ddy( worldNormal2_g60891 );
					float dotResult6_g60891 = dot( temp_output_4_0_g60891 , temp_output_4_0_g60891 );
					#ifdef _USEGEOMETRICAA_ON
					float staticSwitch15_g60891 = min( temp_output_19_0_g60891, ( 1.0 - pow( saturate( max( dotResult5_g60891, dotResult6_g60891 ) ) , 0.25 ) ) );
					#else
					float staticSwitch15_g60891 = temp_output_19_0_g60891;
					#endif
					float SmoothnessAA1399_g60856 = staticSwitch15_g60891;
					float Smoothness1_g60892 = SmoothnessAA1399_g60856;
					float IOR2700_g60856 = _IOR;
					float IOR1_g60892 = IOR2700_g60856;
					float3 temp_cast_2 = (0.04).xxx;
					float3 lerpResult1473_g60856 = lerp( temp_cast_2 , oAlbedo6_g60856 , Metallic1239_g60856);
					float3 switchResult1501_g60856 = (((ase_vface>0)?(World_Normal2508_g60856):(-World_Normal2508_g60856)));
					float3 View_Direction2511_g60856 = ViewDirWS;
					float dotResult1476_g60856 = dot( switchResult1501_g60856 , View_Direction2511_g60856 );
					float3 lerpResult1480_g60856 = lerp( lerpResult1473_g60856 , float3( 1,1,1 ) , pow( ( 1.0 - saturate( dotResult1476_g60856 ) ) , 5.0 ));
					float3 Fresnel1560_g60856 = lerpResult1480_g60856;
					float3 Fresnel1_g60892 = Fresnel1560_g60856;
					float3 World_Position2505_g60856 = PositionWS;
					float3 WorldPos1_g60892 = World_Position2505_g60856;
					float3 WorldNormal1_g60892 = World_Normal2508_g60856;
					float3 ViewDir1_g60892 = View_Direction2511_g60856;
					float3 localIndirectSpecular1_g60892 = IndirectSpecular1_g60892( Color1_g60892 , Metallic1_g60892 , Smoothness1_g60892 , IOR1_g60892 , Fresnel1_g60892 , WorldPos1_g60892 , WorldNormal1_g60892 , ViewDir1_g60892 );
					float3 temp_output_2848_0_g60856 = localIndirectSpecular1_g60892;
					float White38_g60856 = 1.0;
					float4 temp_cast_3 = (White38_g60856).xxxx;
					float4 texCoord2426_g60856 = IN.ase_texcoord6;
					texCoord2426_g60856.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0B2361_g60856 = (texCoord2426_g60856).zw;
					float localBicubicPrepare2_g60865 = ( 0.0 );
					float2 Input_UV100_g60865 = UV0B2361_g60856;
					float2 UV2_g60865 = Input_UV100_g60865;
					float4 TexelSize2_g60865 = _Lightmap0_TexelSize;
					float2 UV02_g60865 = float2( 0,0 );
					float2 UV12_g60865 = float2( 0,0 );
					float2 UV22_g60865 = float2( 0,0 );
					float2 UV32_g60865 = float2( 0,0 );
					float W02_g60865 = 0;
					float W12_g60865 = 0;
					{
					{
					 UV2_g60865 = UV2_g60865 * TexelSize2_g60865.zw - 0.5;
					    float2 f = frac( UV2_g60865 );
					    UV2_g60865 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g60865.x - 0.5, UV2_g60865.x + 1.5, UV2_g60865.y - 0.5, UV2_g60865.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60865.xyxy;
					    UV02_g60865 = off.xz;
					    UV12_g60865 = off.yz;
					    UV22_g60865 = off.xw;
					    UV32_g60865 = off.yw;
					    W02_g60865 = s.x / ( s.x + s.y );
					 W12_g60865 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g60865 = lerp( tex2D( _Lightmap0, UV32_g60865 ) , tex2D( _Lightmap0, UV22_g60865 ) , W02_g60865);
					float4 lerpResult45_g60865 = lerp( tex2D( _Lightmap0, UV12_g60865 ) , tex2D( _Lightmap0, UV02_g60865 ) , W02_g60865);
					float4 lerpResult44_g60865 = lerp( lerpResult46_g60865 , lerpResult45_g60865 , W12_g60865);
					float4 Output_2D_Auto131_g60865 = lerpResult44_g60865;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g60856 = Output_2D_Auto131_g60865;
					#else
					float4 staticSwitch1092_g60856 = float4( tex2D( _Lightmap0, UV0B2361_g60856 ).rgb , 0.0 );
					#endif
					float4 Lightmap_0925_g60856 = staticSwitch1092_g60856;
					float localBicubicPrepare2_g60863 = ( 0.0 );
					float2 Input_UV100_g60863 = UV0B2361_g60856;
					float2 UV2_g60863 = Input_UV100_g60863;
					float4 TexelSize2_g60863 = _Lightmap1_TexelSize;
					float2 UV02_g60863 = float2( 0,0 );
					float2 UV12_g60863 = float2( 0,0 );
					float2 UV22_g60863 = float2( 0,0 );
					float2 UV32_g60863 = float2( 0,0 );
					float W02_g60863 = 0;
					float W12_g60863 = 0;
					{
					{
					 UV2_g60863 = UV2_g60863 * TexelSize2_g60863.zw - 0.5;
					    float2 f = frac( UV2_g60863 );
					    UV2_g60863 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g60863.x - 0.5, UV2_g60863.x + 1.5, UV2_g60863.y - 0.5, UV2_g60863.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60863.xyxy;
					    UV02_g60863 = off.xz;
					    UV12_g60863 = off.yz;
					    UV22_g60863 = off.xw;
					    UV32_g60863 = off.yw;
					    W02_g60863 = s.x / ( s.x + s.y );
					 W12_g60863 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g60863 = lerp( tex2D( _Lightmap1, UV32_g60863 ) , tex2D( _Lightmap1, UV22_g60863 ) , W02_g60863);
					float4 lerpResult45_g60863 = lerp( tex2D( _Lightmap1, UV12_g60863 ) , tex2D( _Lightmap1, UV02_g60863 ) , W02_g60863);
					float4 lerpResult44_g60863 = lerp( lerpResult46_g60863 , lerpResult45_g60863 , W12_g60863);
					float4 Output_2D_Auto131_g60863 = lerpResult44_g60863;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g60856 = Output_2D_Auto131_g60863;
					#else
					float4 staticSwitch1088_g60856 = tex2D( _Lightmap1, UV0B2361_g60856 );
					#endif
					float4 Lightmap_1956_g60856 = staticSwitch1088_g60856;
					float Lightmap_Lerp_Value969_g60856 = _UdonLightmapLerp;
					float4 lerpResult442_g60856 = lerp( Lightmap_0925_g60856 , Lightmap_1956_g60856 , Lightmap_Lerp_Value969_g60856);
					float4 Lightmap_Lerp932_g60856 = lerpResult442_g60856;
					float3 appendResult139_g60907 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 Normal_Map318_g60907 = Normal_Map700_g60856;
					float dotResult121_g60907 = dot( appendResult139_g60907 , Normal_Map318_g60907 );
					float temp_output_2_0_g60909 = saturate( dotResult121_g60907 );
					float localStochasticTiling2_g60887 = ( 0.0 );
					float2 UV2_g60887 = UV0B2361_g60856;
					float4 TexelSize2_g60887 = _UdonRNMX0_TexelSize;
					float4 Offsets2_g60887 = float4( 0,0,0,0 );
					float2 Weights2_g60887 = float2( 0,0 );
					{
					UV2_g60887 = UV2_g60887 * TexelSize2_g60887.zw - 0.5;
					float2 f = frac( UV2_g60887 );
					UV2_g60887 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g60887.x - 0.5, UV2_g60887.x + 1.5, UV2_g60887.y - 0.5, UV2_g60887.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g60887 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60887.xyxy;
					Weights2_g60887 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g60886 = Offsets2_g60887;
					float4 Input_FetchOffsets197_g60888 = temp_output_1_34_g60886;
					float2 temp_output_1_54_g60886 = Weights2_g60887;
					float2 Input_FetchWeights200_g60888 = temp_output_1_54_g60886;
					float2 break187_g60888 = Input_FetchWeights200_g60888;
					float4 lerpResult181_g60888 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60888).yw ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60888).xw ) , break187_g60888.x);
					float4 lerpResult182_g60888 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60888).yz ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60888).xz ) , break187_g60888.x);
					float4 lerpResult176_g60888 = lerp( lerpResult181_g60888 , lerpResult182_g60888 , break187_g60888.y);
					float4 Output_Fetch2D_Auto202_g60888 = lerpResult176_g60888;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g60856 = Output_Fetch2D_Auto202_g60888;
					#else
					float4 staticSwitch1061_g60856 = tex2D( _UdonRNMX0, UV0B2361_g60856 );
					#endif
					float3 appendResult146_g60907 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g60907 = dot( appendResult146_g60907 , Normal_Map318_g60907 );
					float temp_output_2_0_g60908 = saturate( dotResult122_g60907 );
					float4 Input_FetchOffsets197_g60889 = temp_output_1_34_g60886;
					float2 Input_FetchWeights200_g60889 = temp_output_1_54_g60886;
					float2 break187_g60889 = Input_FetchWeights200_g60889;
					float4 lerpResult181_g60889 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60889).yw ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60889).xw ) , break187_g60889.x);
					float4 lerpResult182_g60889 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60889).yz ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60889).xz ) , break187_g60889.x);
					float4 lerpResult176_g60889 = lerp( lerpResult181_g60889 , lerpResult182_g60889 , break187_g60889.y);
					float4 Output_Fetch2D_Auto202_g60889 = lerpResult176_g60889;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g60856 = Output_Fetch2D_Auto202_g60889;
					#else
					float4 staticSwitch1062_g60856 = tex2D( _UdonRNMY0, UV0B2361_g60856 );
					#endif
					float3 appendResult149_g60907 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g60907 = dot( appendResult149_g60907 , Normal_Map318_g60907 );
					float temp_output_2_0_g60910 = saturate( dotResult120_g60907 );
					float4 Input_FetchOffsets197_g60890 = temp_output_1_34_g60886;
					float2 Input_FetchWeights200_g60890 = temp_output_1_54_g60886;
					float2 break187_g60890 = Input_FetchWeights200_g60890;
					float4 lerpResult181_g60890 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60890).yw ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60890).xw ) , break187_g60890.x);
					float4 lerpResult182_g60890 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60890).yz ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60890).xz ) , break187_g60890.x);
					float4 lerpResult176_g60890 = lerp( lerpResult181_g60890 , lerpResult182_g60890 , break187_g60890.y);
					float4 Output_Fetch2D_Auto202_g60890 = lerpResult176_g60890;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g60856 = Output_Fetch2D_Auto202_g60890;
					#else
					float4 staticSwitch1063_g60856 = tex2D( _UdonRNMZ0, UV0B2361_g60856 );
					#endif
					float4 temp_output_24_0_g60907 = ( ( ( ( temp_output_2_0_g60909 * temp_output_2_0_g60909 ) * staticSwitch1061_g60856 ) + ( ( temp_output_2_0_g60908 * temp_output_2_0_g60908 ) * staticSwitch1062_g60856 ) ) + ( ( temp_output_2_0_g60910 * temp_output_2_0_g60910 ) * staticSwitch1063_g60856 ) );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch372_g60907 = ( temp_output_24_0_g60907 * 1.2 );
					#else
					float4 staticSwitch372_g60907 = temp_output_24_0_g60907;
					#endif
					float4 RNM_0926_g60856 = staticSwitch372_g60907;
					float3 appendResult139_g60903 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 Normal_Map318_g60903 = Normal_Map700_g60856;
					float dotResult121_g60903 = dot( appendResult139_g60903 , Normal_Map318_g60903 );
					float temp_output_2_0_g60905 = saturate( dotResult121_g60903 );
					float localStochasticTiling2_g60858 = ( 0.0 );
					float2 UV2_g60858 = UV0B2361_g60856;
					float4 TexelSize2_g60858 = _UdonRNMX1_TexelSize;
					float4 Offsets2_g60858 = float4( 0,0,0,0 );
					float2 Weights2_g60858 = float2( 0,0 );
					{
					UV2_g60858 = UV2_g60858 * TexelSize2_g60858.zw - 0.5;
					float2 f = frac( UV2_g60858 );
					UV2_g60858 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g60858.x - 0.5, UV2_g60858.x + 1.5, UV2_g60858.y - 0.5, UV2_g60858.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g60858 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60858.xyxy;
					Weights2_g60858 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g60857 = Offsets2_g60858;
					float4 Input_FetchOffsets197_g60859 = temp_output_1_34_g60857;
					float2 temp_output_1_54_g60857 = Weights2_g60858;
					float2 Input_FetchWeights200_g60859 = temp_output_1_54_g60857;
					float2 break187_g60859 = Input_FetchWeights200_g60859;
					float4 lerpResult181_g60859 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60859).yw ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60859).xw ) , break187_g60859.x);
					float4 lerpResult182_g60859 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60859).yz ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60859).xz ) , break187_g60859.x);
					float4 lerpResult176_g60859 = lerp( lerpResult181_g60859 , lerpResult182_g60859 , break187_g60859.y);
					float4 Output_Fetch2D_Auto202_g60859 = lerpResult176_g60859;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g60856 = Output_Fetch2D_Auto202_g60859;
					#else
					float4 staticSwitch1087_g60856 = tex2D( _UdonRNMX1, UV0B2361_g60856 );
					#endif
					float3 appendResult146_g60903 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g60903 = dot( appendResult146_g60903 , Normal_Map318_g60903 );
					float temp_output_2_0_g60904 = saturate( dotResult122_g60903 );
					float4 Input_FetchOffsets197_g60860 = temp_output_1_34_g60857;
					float2 Input_FetchWeights200_g60860 = temp_output_1_54_g60857;
					float2 break187_g60860 = Input_FetchWeights200_g60860;
					float4 lerpResult181_g60860 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60860).yw ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60860).xw ) , break187_g60860.x);
					float4 lerpResult182_g60860 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60860).yz ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60860).xz ) , break187_g60860.x);
					float4 lerpResult176_g60860 = lerp( lerpResult181_g60860 , lerpResult182_g60860 , break187_g60860.y);
					float4 Output_Fetch2D_Auto202_g60860 = lerpResult176_g60860;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g60856 = Output_Fetch2D_Auto202_g60860;
					#else
					float4 staticSwitch1083_g60856 = tex2D( _UdonRNMY1, UV0B2361_g60856 );
					#endif
					float3 appendResult149_g60903 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g60903 = dot( appendResult149_g60903 , Normal_Map318_g60903 );
					float temp_output_2_0_g60906 = saturate( dotResult120_g60903 );
					float4 Input_FetchOffsets197_g60861 = temp_output_1_34_g60857;
					float2 Input_FetchWeights200_g60861 = temp_output_1_54_g60857;
					float2 break187_g60861 = Input_FetchWeights200_g60861;
					float4 lerpResult181_g60861 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60861).yw ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60861).xw ) , break187_g60861.x);
					float4 lerpResult182_g60861 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60861).yz ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60861).xz ) , break187_g60861.x);
					float4 lerpResult176_g60861 = lerp( lerpResult181_g60861 , lerpResult182_g60861 , break187_g60861.y);
					float4 Output_Fetch2D_Auto202_g60861 = lerpResult176_g60861;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g60856 = Output_Fetch2D_Auto202_g60861;
					#else
					float4 staticSwitch1084_g60856 = tex2D( _UdonRNMZ1, UV0B2361_g60856 );
					#endif
					float4 temp_output_24_0_g60903 = ( ( ( ( temp_output_2_0_g60905 * temp_output_2_0_g60905 ) * staticSwitch1087_g60856 ) + ( ( temp_output_2_0_g60904 * temp_output_2_0_g60904 ) * staticSwitch1083_g60856 ) ) + ( ( temp_output_2_0_g60906 * temp_output_2_0_g60906 ) * staticSwitch1084_g60856 ) );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch372_g60903 = ( temp_output_24_0_g60903 * 1.2 );
					#else
					float4 staticSwitch372_g60903 = temp_output_24_0_g60903;
					#endif
					float4 RNM_11081_g60856 = staticSwitch372_g60903;
					float4 lerpResult953_g60856 = lerp( RNM_0926_g60856 , RNM_11081_g60856 , Lightmap_Lerp_Value969_g60856);
					float4 RNM_Lerp950_g60856 = lerpResult953_g60856;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g60856 = temp_cast_3;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g60856 = Lightmap_0925_g60856;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g60856 = Lightmap_Lerp932_g60856;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g60856 = RNM_0926_g60856;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g60856 = RNM_Lerp950_g60856;
					#else
					float4 staticSwitch1014_g60856 = temp_cast_3;
					#endif
					float3 Lightmap46_g60856 = (staticSwitch1014_g60856).rgb;
					float3 temp_output_6_0_g60898 = Lightmap46_g60856;
					float grayscale4_g60898 = Luminance( temp_output_6_0_g60898 );
					float smoothstepResult2_g60898 = smoothstep( 0.0 , 0.02 , grayscale4_g60898);
					#ifdef _USELIGHTMAPPEDREFLECTIONS_ON
					float3 staticSwitch1469_g60856 = ( temp_output_2848_0_g60856 * smoothstepResult2_g60898 );
					#else
					float3 staticSwitch1469_g60856 = temp_output_2848_0_g60856;
					#endif
					float3 Indirect_Specular1419_g60856 = staticSwitch1469_g60856;
					float3 Color97_g60899 = oAlbedo6_g60856;
					float Metallic97_g60899 = Metallic1239_g60856;
					float Smoothness2838_g60856 = staticSwitch1004_g60856;
					float Smoothness97_g60899 = Smoothness2838_g60856;
					float SmoothnessAA97_g60899 = SmoothnessAA1399_g60856;
					float IOR97_g60899 = IOR2700_g60856;
					float3 Fresnel97_g60899 = Fresnel1560_g60856;
					float3 Lightmap97_g60899 = Lightmap46_g60856;
					float3 WorldPos97_g60899 = World_Position2505_g60856;
					float3 WorldNormal97_g60899 = World_Normal2508_g60856;
					float3 ViewDir97_g60899 = View_Direction2511_g60856;
					float3 localDirectSpecular97_g60899 = DirectSpecular( Color97_g60899 , Metallic97_g60899 , Smoothness97_g60899 , SmoothnessAA97_g60899 , IOR97_g60899 , Fresnel97_g60899 , Lightmap97_g60899 , WorldPos97_g60899 , WorldNormal97_g60899 , ViewDir97_g60899 );
					float3 Direct_Specular2560_g60856 = localDirectSpecular97_g60899;
					float3 aAlbedo1466_g60856 = ( temp_output_2532_0_g60856 * ( 1.0 - Metallic1239_g60856 ) );
					float3 temp_output_1252_0_g60856 = ( aAlbedo1466_g60856 * Lightmap46_g60856 );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch1_g60900 = float4( ( temp_output_1252_0_g60856 + Emission86_g60856 + Indirect_Specular1419_g60856 ) , 0.0 );
					#else
					float4 staticSwitch1_g60900 = float4( ( Emission86_g60856 + Indirect_Specular1419_g60856 + Direct_Specular2560_g60856 + temp_output_1252_0_g60856 ) , 0.0 );
					#endif
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1181_g60856 = float4( Lightmap46_g60856 , 0.0 );
					#else
					float4 staticSwitch1181_g60856 = staticSwitch1_g60900;
					#endif
					float4 Color357_g60901 = staticSwitch1181_g60856;
					float4 LUT51_g60901 = tex3D( _LUT, ( ( log10( ( ( (Color357_g60901).xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 ) );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch359_g60901 = LUT51_g60901;
					#else
					float4 staticSwitch359_g60901 = Color357_g60901;
					#endif
					

					o.Albedo = staticSwitch1180_g60856;
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

					o.Emission = staticSwitch359_g60901.xyz;
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
				#define ASE_FOG
				#define _SPECULARHIGHLIGHTS_OFF
				#define ASE_LIGHTING_SIMPLE 1
				#define _GLOSSYREFLECTIONS_OFF
				#define ASE_NO_AMBIENT 1
				#define ASE_VERSION 19909

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
				uniform sampler3D _LUT;
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
						IN.pos.z = IN.pos.z;
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
						outputDepth = IN.pos.z;
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
				#define ASE_FOG
				#define _SPECULARHIGHLIGHTS_OFF
				#define ASE_LIGHTING_SIMPLE 1
				#define _GLOSSYREFLECTIONS_OFF
				#define ASE_NO_AMBIENT 1
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
				uniform sampler3D _LUT;
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
				#define ASE_FOG
				#define _SPECULARHIGHLIGHTS_OFF
				#define ASE_LIGHTING_SIMPLE 1
				#define _GLOSSYREFLECTIONS_OFF
				#define ASE_NO_AMBIENT 1
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
				uniform sampler3D _LUT;
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
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3270;192,-1152;Inherit;False;Meenphie;0;;60856;b3ba55a08dd6b49c7be16c6f35cf2033;6,1008,0,2632,0,2635,0,2619,0,2636,0,2670,0;0;5;FLOAT3;625;FLOAT4;624;FLOAT;156;FLOAT;427;FLOAT;1024
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3152;640,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;12;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;True;False;False;True;False;False;False;False;False;False;False;True;1;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;1;LightMode=ForwardBase;False;False;0;False;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3154;640,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;12;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;True;False;False;True;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;True;1;LightMode=ForwardAdd;False;False;0;False;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3155;640,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;12;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;True;False;False;True;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;True;1;LightMode=Deferred;False;False;0;False;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3156;640,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;12;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;True;False;False;True;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;False;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3157;640,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;12;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;True;False;False;True;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;False;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3158;640,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;12;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;True;False;False;True;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;False;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3159;640,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;12;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ScenePickingPass;0;7;ScenePickingPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;True;False;False;True;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=Picking;False;False;0;False;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3153;512,-1152;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;Meenphie/Standard/Transparent/Additive;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardBase;0;1;ForwardBase;17;True;True;0;1;False;;1;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;2;False;;True;3;False;;False;False;True;3;RenderType=Transparent=RenderType;Queue=Transparent=Queue=2;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;True;False;False;True;False;False;False;False;False;False;True;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;44;Category;0;0;  Instanced Terrain Normals;1;0;Workflow;3;639057697649873840;Surface;1;639116848959649190;  Blend;2;639116848980030270;  Dither Shadows;0;639116848994245360;Two Sided;0;639057698775949650;Alpha Clipping;0;0;  Use Shadow Threshold;0;0;Deferred Pass;0;639057697867054150;Normal Space;0;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;1;0;Receive Shadows;1;0;Receive Specular;0;639048816484624920;Receive Reflections;0;639116847657607100;GPU Instancing;1;0;LOD CrossFade;1;0;Built-in Fog;1;0;Ambient Light;0;639116847860649440;Meta Pass;0;639116847863196800;Add Pass;0;639048816879073320;Override Baked GI;0;0;Write Depth;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;0;Vertex Position;1;0;0;8;False;True;False;False;False;True;True;True;False;;False;0
WireConnection;3153;0;3270;625
WireConnection;3153;2;3270;624
ASEEND*/
//CHKSM=E6D52B9E1346F289E718BCE95CB454423DA7E32F