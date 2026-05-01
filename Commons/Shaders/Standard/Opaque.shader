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
				sampler2D _Sampler82966_g61249;
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				sampler2D _Sampler82967_g61249;
				uniform sampler2D _Lightmap0;
				float4 _Lightmap0_TexelSize;
				uniform sampler2D _Lightmap1;
				float4 _Lightmap1_TexelSize;
				uniform float _UdonLightmapLerp;
				uniform sampler2D _BumpMap;
				sampler2D _Sampler82965_g61249;
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
				sampler2D _Sampler82968_g61249;
				uniform float _EmissionIntensity;
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				sampler2D _Sampler82964_g61249;
				uniform float _IOR;


				float3 IndirectSpecular1_g61300( float3 Color, float Metallic, float Smoothness, float IOR, float3 Fresnel, float3 WorldPos, float3 WorldNormal, float3 ViewDir )
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
				
				float3 DirectSpecular( float3 Color, float3 LightmapColor, float Metallic, float Smoothness, float IOR, float3 Fresnel, float3 WorldPos, float3 WorldNormal, float3 ViewDir )
				{
					// --- CONFIGURATION ---
					static const float lumaStart     = 0.05;
					static const float lumaEnd       = 1.0;
					static const float specBoost     = 0.02;
					static const float specClamp     = 10.0;
					static const float roughnessBias = 0.0;
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
					// --- ROUGHNESS ---
					float roughness = 1.0 - Smoothness;
					float alpha     = roughness * roughness;
					float alpha2    = max(alpha * alpha, 0.0001);
					// AA energy compensation for metals only
					// At distance AA lowers Smoothness — we restore that lost energy for metals
					float aaLoss          = 1.0 - Smoothness;
					float metalEnergyComp = 1.0 + aaLoss * Metallic;
					float  nDotV     = max(dot(N, vDir), 1e-4);
					float3 specAccum = 0;
					int loopCount = (int)_UdonSpecularLightCount;
					for (int i = 0; i < loopCount; i++) {
					    float4 posRange = _UdonSpecularLightPos[i];
					    // 1. Linear camera distance fade [0..maxVisibleDist]
					    float camDist      = distance(_WorldSpaceCameraPos, posRange.xyz);
					    float distanceFade = saturate(1.0 - (camDist * invMaxVisibleDist));
					    if (distanceFade <= 0.0) continue;
					    float3 L_vector = posRange.xyz - WorldPos;
					    float  distSq   = dot(L_vector, L_vector);
					    float4 dirAngle = _UdonSpecularLightDir[i];
					    float3 L_norm   = L_vector * rsqrt(max(distSq, 1e-6));
					    // 2. Spot mask
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
					        // 3. MRP for area lights
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
					        // 4. Rectangle mask
					        float  softness   = max(0.1, roughness * 2.0);
					        float2 distToEdge = abs(localP) - halfSize;
					        rectMask = smoothstep(softness, 0.0, length(max(distToEdge, 0.0)));
					    }
					    if (rectMask <= 0.0) continue;
					    float  dSqDiff = dot(diff, diff);
					    float3 lDir    = diff * rsqrt(max(dSqDiff, 1e-6));
					    float3 H       = normalize(lDir + vDir);
					    float nDotH = saturate(dot(N, H));
					    float nDotL = saturate(dot(N, lDir));
					    // 5. GGX NDF
					    float d_denom = nDotH * nDotH * (alpha2 - 1.0) + 1.0;
					    float D       = alpha2 / (3.14159265 * d_denom * d_denom + 1e-7);
					    // 6. Smith visibility
					    float k  = alpha * 0.5;
					    float Gv = nDotV / (nDotV * (1.0 - k) + k);
					    float Gl = nDotL / (nDotL * (1.0 - k) + k);
					    float G  = Gv * Gl;
					    // 7. Cook-Torrance, no Fresnel — handled externally
					    float3 spec = (D * G) / max(4.0 * nDotV * nDotL, 0.001);
					    // 8. Accumulate
					    float3 finalResult = _UdonSpecularLightCol[i].rgb
					    * _UdonSpecularLightCol[i].w
					    * spec
					    * nDotL
					    * spotMask
					    * distanceFade
					    * rectMask;
					    specAccum += max(0.0, finalResult);
					}
					// --- PERCEPTUAL ROUGHNESS ATTENUATION (log-like curve, no log/pow) ---
					float logCurve      = 1.0 - sqrt(roughness);                        // log-like, smooth=1 rough=0
					float perceptualFade = lerp(logCurve, logCurve * logCurve, roughnessBias); // bias sharpens the curve
					perceptualFade = lerp(perceptualFade, 1.0, Metallic);          // metals bypass
					// --- FINAL ---
					float3 result     = specAccum * lmMask * specBoost * perceptualFade * metalEnergyComp;
					float  resultLuma = dot(result, float3(0.2126, 0.7152, 0.0722));
					result            = result * min(1.0, specClamp / max(resultLuma, 1e-4));
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

					float2 texCoord2357_g61249 = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0A2420_g61249 = texCoord2357_g61249;
					#ifdef _MAINTEX
					float4 staticSwitch1549_g61249 = tex2D( _MainTex, UV0A2420_g61249 );
					#else
					float4 staticSwitch1549_g61249 = _Color;
					#endif
					float2 temp_output_5_0_g61275 = UV0A2420_g61249;
					float2 UV633_g61275 = temp_output_5_0_g61275;
					float2 UV100_g61276 = UV633_g61275;
					float2 temp_output_51_0_g61276 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g61276 * float2( 3.464,3.464 ) ) );
					float2 break55_g61276 = frac( temp_output_51_0_g61276 );
					float temp_output_56_0_g61276 = ( ( 1.0 - break55_g61276.x ) - break55_g61276.y );
					float2 temp_output_52_0_g61276 = floor( temp_output_51_0_g61276 );
					float2 temp_output_125_0_g61276 = ( temp_output_52_0_g61276 + float2( 1,1 ) );
					float2 ifLocalVar87_g61276 = 0;
					if( temp_output_56_0_g61276 > 0.0 )
					ifLocalVar87_g61276 = temp_output_52_0_g61276;
					else if( temp_output_56_0_g61276 == 0.0 )
					ifLocalVar87_g61276 = temp_output_125_0_g61276;
					else if( temp_output_56_0_g61276 < 0.0 )
					ifLocalVar87_g61276 = temp_output_125_0_g61276;
					float3 temp_output_7_0_g61277 = frac( ( (ifLocalVar87_g61276).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61277 = dot( temp_output_7_0_g61277 , ( (temp_output_7_0_g61277).yzx + 33.33 ) );
					float3 temp_output_12_0_g61277 = ( temp_output_7_0_g61277 + dotResult8_g61277 );
					float2 temp_output_597_0_g61275 = ( UV100_g61276 + frac( ( ( (temp_output_12_0_g61277).xx + (temp_output_12_0_g61277).yz ) * (temp_output_12_0_g61277).zy ) ) );
					float2 DDX631_g61275 = ddx( temp_output_5_0_g61275 );
					float2 DDY632_g61275 = ddy( temp_output_5_0_g61275 );
					float temp_output_65_0_g61276 = ( 0.0 - temp_output_56_0_g61276 );
					float ifLocalVar59_g61276 = 0;
					if( temp_output_56_0_g61276 <= 0.0 )
					ifLocalVar59_g61276 = temp_output_65_0_g61276;
					else
					ifLocalVar59_g61276 = temp_output_56_0_g61276;
					float temp_output_597_30_g61275 = ifLocalVar59_g61276;
					float2 temp_output_90_0_g61276 = ( temp_output_52_0_g61276 + float2( 0,1 ) );
					float2 temp_output_123_0_g61276 = ( temp_output_52_0_g61276 + float2( 1,0 ) );
					float2 ifLocalVar88_g61276 = 0;
					if( temp_output_56_0_g61276 > 0.0 )
					ifLocalVar88_g61276 = temp_output_90_0_g61276;
					else if( temp_output_56_0_g61276 == 0.0 )
					ifLocalVar88_g61276 = temp_output_123_0_g61276;
					else if( temp_output_56_0_g61276 < 0.0 )
					ifLocalVar88_g61276 = temp_output_123_0_g61276;
					float3 temp_output_7_0_g61278 = frac( ( (ifLocalVar88_g61276).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61278 = dot( temp_output_7_0_g61278 , ( (temp_output_7_0_g61278).yzx + 33.33 ) );
					float3 temp_output_12_0_g61278 = ( temp_output_7_0_g61278 + dotResult8_g61278 );
					float2 temp_output_597_26_g61275 = ( UV100_g61276 + frac( ( ( (temp_output_12_0_g61278).xx + (temp_output_12_0_g61278).yz ) * (temp_output_12_0_g61278).zy ) ) );
					float temp_output_66_0_g61276 = ( 1.0 - break55_g61276.y );
					float ifLocalVar60_g61276 = 0;
					if( temp_output_56_0_g61276 <= 0.0 )
					ifLocalVar60_g61276 = temp_output_66_0_g61276;
					else
					ifLocalVar60_g61276 = break55_g61276.y;
					float temp_output_597_28_g61275 = ifLocalVar60_g61276;
					float2 ifLocalVar89_g61276 = 0;
					if( temp_output_56_0_g61276 > 0.0 )
					ifLocalVar89_g61276 = temp_output_123_0_g61276;
					else if( temp_output_56_0_g61276 == 0.0 )
					ifLocalVar89_g61276 = temp_output_90_0_g61276;
					else if( temp_output_56_0_g61276 < 0.0 )
					ifLocalVar89_g61276 = temp_output_90_0_g61276;
					float3 temp_output_7_0_g61279 = frac( ( (ifLocalVar89_g61276).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61279 = dot( temp_output_7_0_g61279 , ( (temp_output_7_0_g61279).yzx + 33.33 ) );
					float3 temp_output_12_0_g61279 = ( temp_output_7_0_g61279 + dotResult8_g61279 );
					float2 temp_output_597_27_g61275 = ( UV100_g61276 + frac( ( ( (temp_output_12_0_g61279).xx + (temp_output_12_0_g61279).yz ) * (temp_output_12_0_g61279).zy ) ) );
					float temp_output_67_0_g61276 = ( 1.0 - break55_g61276.x );
					float ifLocalVar61_g61276 = 0;
					if( temp_output_56_0_g61276 <= 0.0 )
					ifLocalVar61_g61276 = temp_output_67_0_g61276;
					else
					ifLocalVar61_g61276 = break55_g61276.x;
					float temp_output_597_29_g61275 = ifLocalVar61_g61276;
					float4 Output_2D293_g61275 = ( ( tex2D( _Sampler82966_g61249, temp_output_597_0_g61275, DDX631_g61275, DDY632_g61275 ) * temp_output_597_30_g61275 ) + ( tex2D( _Sampler82966_g61249, temp_output_597_26_g61275, DDX631_g61275, DDY632_g61275 ) * temp_output_597_28_g61275 ) + ( tex2D( _Sampler82966_g61249, temp_output_597_27_g61275, DDX631_g61275, DDY632_g61275 ) * temp_output_597_29_g61275 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g61249 = Output_2D293_g61275;
					#else
					float4 staticSwitch1001_g61249 = staticSwitch1549_g61249;
					#endif
					float3 temp_output_2532_0_g61249 = (staticSwitch1001_g61249).rgb;
					float3 oAlbedo6_g61249 = temp_output_2532_0_g61249;
					float Black1185_g61249 = 0.0;
					float3 temp_cast_0 = (Black1185_g61249).xxx;
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch1180_g61249 = temp_cast_0;
					#else
					float3 staticSwitch1180_g61249 = oAlbedo6_g61249;
					#endif
					
					#ifdef _METALLICMAP
					float staticSwitch846_g61249 = tex2D( _MetallicMap, UV0A2420_g61249 ).r;
					#else
					float staticSwitch846_g61249 = _Metallic;
					#endif
					float2 temp_output_5_0_g61270 = UV0A2420_g61249;
					float2 UV633_g61270 = temp_output_5_0_g61270;
					float2 UV100_g61271 = UV633_g61270;
					float2 temp_output_51_0_g61271 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g61271 * float2( 3.464,3.464 ) ) );
					float2 break55_g61271 = frac( temp_output_51_0_g61271 );
					float temp_output_56_0_g61271 = ( ( 1.0 - break55_g61271.x ) - break55_g61271.y );
					float2 temp_output_52_0_g61271 = floor( temp_output_51_0_g61271 );
					float2 temp_output_125_0_g61271 = ( temp_output_52_0_g61271 + float2( 1,1 ) );
					float2 ifLocalVar87_g61271 = 0;
					if( temp_output_56_0_g61271 > 0.0 )
					ifLocalVar87_g61271 = temp_output_52_0_g61271;
					else if( temp_output_56_0_g61271 == 0.0 )
					ifLocalVar87_g61271 = temp_output_125_0_g61271;
					else if( temp_output_56_0_g61271 < 0.0 )
					ifLocalVar87_g61271 = temp_output_125_0_g61271;
					float3 temp_output_7_0_g61272 = frac( ( (ifLocalVar87_g61271).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61272 = dot( temp_output_7_0_g61272 , ( (temp_output_7_0_g61272).yzx + 33.33 ) );
					float3 temp_output_12_0_g61272 = ( temp_output_7_0_g61272 + dotResult8_g61272 );
					float2 temp_output_597_0_g61270 = ( UV100_g61271 + frac( ( ( (temp_output_12_0_g61272).xx + (temp_output_12_0_g61272).yz ) * (temp_output_12_0_g61272).zy ) ) );
					float2 DDX631_g61270 = ddx( temp_output_5_0_g61270 );
					float2 DDY632_g61270 = ddy( temp_output_5_0_g61270 );
					float temp_output_65_0_g61271 = ( 0.0 - temp_output_56_0_g61271 );
					float ifLocalVar59_g61271 = 0;
					if( temp_output_56_0_g61271 <= 0.0 )
					ifLocalVar59_g61271 = temp_output_65_0_g61271;
					else
					ifLocalVar59_g61271 = temp_output_56_0_g61271;
					float temp_output_597_30_g61270 = ifLocalVar59_g61271;
					float2 temp_output_90_0_g61271 = ( temp_output_52_0_g61271 + float2( 0,1 ) );
					float2 temp_output_123_0_g61271 = ( temp_output_52_0_g61271 + float2( 1,0 ) );
					float2 ifLocalVar88_g61271 = 0;
					if( temp_output_56_0_g61271 > 0.0 )
					ifLocalVar88_g61271 = temp_output_90_0_g61271;
					else if( temp_output_56_0_g61271 == 0.0 )
					ifLocalVar88_g61271 = temp_output_123_0_g61271;
					else if( temp_output_56_0_g61271 < 0.0 )
					ifLocalVar88_g61271 = temp_output_123_0_g61271;
					float3 temp_output_7_0_g61273 = frac( ( (ifLocalVar88_g61271).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61273 = dot( temp_output_7_0_g61273 , ( (temp_output_7_0_g61273).yzx + 33.33 ) );
					float3 temp_output_12_0_g61273 = ( temp_output_7_0_g61273 + dotResult8_g61273 );
					float2 temp_output_597_26_g61270 = ( UV100_g61271 + frac( ( ( (temp_output_12_0_g61273).xx + (temp_output_12_0_g61273).yz ) * (temp_output_12_0_g61273).zy ) ) );
					float temp_output_66_0_g61271 = ( 1.0 - break55_g61271.y );
					float ifLocalVar60_g61271 = 0;
					if( temp_output_56_0_g61271 <= 0.0 )
					ifLocalVar60_g61271 = temp_output_66_0_g61271;
					else
					ifLocalVar60_g61271 = break55_g61271.y;
					float temp_output_597_28_g61270 = ifLocalVar60_g61271;
					float2 ifLocalVar89_g61271 = 0;
					if( temp_output_56_0_g61271 > 0.0 )
					ifLocalVar89_g61271 = temp_output_123_0_g61271;
					else if( temp_output_56_0_g61271 == 0.0 )
					ifLocalVar89_g61271 = temp_output_90_0_g61271;
					else if( temp_output_56_0_g61271 < 0.0 )
					ifLocalVar89_g61271 = temp_output_90_0_g61271;
					float3 temp_output_7_0_g61274 = frac( ( (ifLocalVar89_g61271).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61274 = dot( temp_output_7_0_g61274 , ( (temp_output_7_0_g61274).yzx + 33.33 ) );
					float3 temp_output_12_0_g61274 = ( temp_output_7_0_g61274 + dotResult8_g61274 );
					float2 temp_output_597_27_g61270 = ( UV100_g61271 + frac( ( ( (temp_output_12_0_g61274).xx + (temp_output_12_0_g61274).yz ) * (temp_output_12_0_g61274).zy ) ) );
					float temp_output_67_0_g61271 = ( 1.0 - break55_g61271.x );
					float ifLocalVar61_g61271 = 0;
					if( temp_output_56_0_g61271 <= 0.0 )
					ifLocalVar61_g61271 = temp_output_67_0_g61271;
					else
					ifLocalVar61_g61271 = break55_g61271.x;
					float temp_output_597_29_g61270 = ifLocalVar61_g61271;
					float4 Output_2D293_g61270 = ( ( tex2D( _Sampler82967_g61249, temp_output_597_0_g61270, DDX631_g61270, DDY632_g61270 ) * temp_output_597_30_g61270 ) + ( tex2D( _Sampler82967_g61249, temp_output_597_26_g61270, DDX631_g61270, DDY632_g61270 ) * temp_output_597_28_g61270 ) + ( tex2D( _Sampler82967_g61249, temp_output_597_27_g61270, DDX631_g61270, DDY632_g61270 ) * temp_output_597_29_g61270 ) );
					float4 break31_g61270 = Output_2D293_g61270;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g61249 = break31_g61270.r;
					#else
					float staticSwitch1005_g61249 = staticSwitch846_g61249;
					#endif
					float Metallic1239_g61249 = staticSwitch1005_g61249;
					float3 aAlbedo1466_g61249 = ( temp_output_2532_0_g61249 * ( 1.0 - Metallic1239_g61249 ) );
					float White38_g61249 = 1.0;
					float4 temp_cast_1 = (White38_g61249).xxxx;
					float4 texCoord2426_g61249 = IN.ase_texcoord6;
					texCoord2426_g61249.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0B2361_g61249 = (texCoord2426_g61249).zw;
					float localBicubicPrepare2_g61258 = ( 0.0 );
					float2 Input_UV100_g61258 = UV0B2361_g61249;
					float2 UV2_g61258 = Input_UV100_g61258;
					float4 TexelSize2_g61258 = _Lightmap0_TexelSize;
					float2 UV02_g61258 = float2( 0,0 );
					float2 UV12_g61258 = float2( 0,0 );
					float2 UV22_g61258 = float2( 0,0 );
					float2 UV32_g61258 = float2( 0,0 );
					float W02_g61258 = 0;
					float W12_g61258 = 0;
					{
					{
					 UV2_g61258 = UV2_g61258 * TexelSize2_g61258.zw - 0.5;
					    float2 f = frac( UV2_g61258 );
					    UV2_g61258 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g61258.x - 0.5, UV2_g61258.x + 1.5, UV2_g61258.y - 0.5, UV2_g61258.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g61258.xyxy;
					    UV02_g61258 = off.xz;
					    UV12_g61258 = off.yz;
					    UV22_g61258 = off.xw;
					    UV32_g61258 = off.yw;
					    W02_g61258 = s.x / ( s.x + s.y );
					 W12_g61258 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g61258 = lerp( tex2D( _Lightmap0, UV32_g61258 ) , tex2D( _Lightmap0, UV22_g61258 ) , W02_g61258);
					float4 lerpResult45_g61258 = lerp( tex2D( _Lightmap0, UV12_g61258 ) , tex2D( _Lightmap0, UV02_g61258 ) , W02_g61258);
					float4 lerpResult44_g61258 = lerp( lerpResult46_g61258 , lerpResult45_g61258 , W12_g61258);
					float4 Output_2D_Auto131_g61258 = lerpResult44_g61258;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g61249 = Output_2D_Auto131_g61258;
					#else
					float4 staticSwitch1092_g61249 = float4( tex2D( _Lightmap0, UV0B2361_g61249 ).rgb , 0.0 );
					#endif
					float4 Lightmap_0925_g61249 = staticSwitch1092_g61249;
					float localBicubicPrepare2_g61256 = ( 0.0 );
					float2 Input_UV100_g61256 = UV0B2361_g61249;
					float2 UV2_g61256 = Input_UV100_g61256;
					float4 TexelSize2_g61256 = _Lightmap1_TexelSize;
					float2 UV02_g61256 = float2( 0,0 );
					float2 UV12_g61256 = float2( 0,0 );
					float2 UV22_g61256 = float2( 0,0 );
					float2 UV32_g61256 = float2( 0,0 );
					float W02_g61256 = 0;
					float W12_g61256 = 0;
					{
					{
					 UV2_g61256 = UV2_g61256 * TexelSize2_g61256.zw - 0.5;
					    float2 f = frac( UV2_g61256 );
					    UV2_g61256 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g61256.x - 0.5, UV2_g61256.x + 1.5, UV2_g61256.y - 0.5, UV2_g61256.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g61256.xyxy;
					    UV02_g61256 = off.xz;
					    UV12_g61256 = off.yz;
					    UV22_g61256 = off.xw;
					    UV32_g61256 = off.yw;
					    W02_g61256 = s.x / ( s.x + s.y );
					 W12_g61256 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g61256 = lerp( tex2D( _Lightmap1, UV32_g61256 ) , tex2D( _Lightmap1, UV22_g61256 ) , W02_g61256);
					float4 lerpResult45_g61256 = lerp( tex2D( _Lightmap1, UV12_g61256 ) , tex2D( _Lightmap1, UV02_g61256 ) , W02_g61256);
					float4 lerpResult44_g61256 = lerp( lerpResult46_g61256 , lerpResult45_g61256 , W12_g61256);
					float4 Output_2D_Auto131_g61256 = lerpResult44_g61256;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g61249 = Output_2D_Auto131_g61256;
					#else
					float4 staticSwitch1088_g61249 = tex2D( _Lightmap1, UV0B2361_g61249 );
					#endif
					float4 Lightmap_1956_g61249 = staticSwitch1088_g61249;
					float Lightmap_Lerp_Value969_g61249 = _UdonLightmapLerp;
					float4 lerpResult442_g61249 = lerp( Lightmap_0925_g61249 , Lightmap_1956_g61249 , Lightmap_Lerp_Value969_g61249);
					float4 Lightmap_Lerp932_g61249 = lerpResult442_g61249;
					float3 appendResult139_g61295 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float2 temp_output_5_0_g61265 = UV0A2420_g61249;
					float2 UV633_g61265 = temp_output_5_0_g61265;
					float2 UV100_g61266 = UV633_g61265;
					float2 temp_output_51_0_g61266 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g61266 * float2( 3.464,3.464 ) ) );
					float2 break55_g61266 = frac( temp_output_51_0_g61266 );
					float temp_output_56_0_g61266 = ( ( 1.0 - break55_g61266.x ) - break55_g61266.y );
					float2 temp_output_52_0_g61266 = floor( temp_output_51_0_g61266 );
					float2 temp_output_125_0_g61266 = ( temp_output_52_0_g61266 + float2( 1,1 ) );
					float2 ifLocalVar87_g61266 = 0;
					if( temp_output_56_0_g61266 > 0.0 )
					ifLocalVar87_g61266 = temp_output_52_0_g61266;
					else if( temp_output_56_0_g61266 == 0.0 )
					ifLocalVar87_g61266 = temp_output_125_0_g61266;
					else if( temp_output_56_0_g61266 < 0.0 )
					ifLocalVar87_g61266 = temp_output_125_0_g61266;
					float3 temp_output_7_0_g61267 = frac( ( (ifLocalVar87_g61266).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61267 = dot( temp_output_7_0_g61267 , ( (temp_output_7_0_g61267).yzx + 33.33 ) );
					float3 temp_output_12_0_g61267 = ( temp_output_7_0_g61267 + dotResult8_g61267 );
					float2 temp_output_597_0_g61265 = ( UV100_g61266 + frac( ( ( (temp_output_12_0_g61267).xx + (temp_output_12_0_g61267).yz ) * (temp_output_12_0_g61267).zy ) ) );
					float2 DDX631_g61265 = ddx( temp_output_5_0_g61265 );
					float2 DDY632_g61265 = ddy( temp_output_5_0_g61265 );
					float Input_Scale617_g61265 = 1.5;
					float temp_output_65_0_g61266 = ( 0.0 - temp_output_56_0_g61266 );
					float ifLocalVar59_g61266 = 0;
					if( temp_output_56_0_g61266 <= 0.0 )
					ifLocalVar59_g61266 = temp_output_65_0_g61266;
					else
					ifLocalVar59_g61266 = temp_output_56_0_g61266;
					float temp_output_597_30_g61265 = ifLocalVar59_g61266;
					float2 temp_output_90_0_g61266 = ( temp_output_52_0_g61266 + float2( 0,1 ) );
					float2 temp_output_123_0_g61266 = ( temp_output_52_0_g61266 + float2( 1,0 ) );
					float2 ifLocalVar88_g61266 = 0;
					if( temp_output_56_0_g61266 > 0.0 )
					ifLocalVar88_g61266 = temp_output_90_0_g61266;
					else if( temp_output_56_0_g61266 == 0.0 )
					ifLocalVar88_g61266 = temp_output_123_0_g61266;
					else if( temp_output_56_0_g61266 < 0.0 )
					ifLocalVar88_g61266 = temp_output_123_0_g61266;
					float3 temp_output_7_0_g61268 = frac( ( (ifLocalVar88_g61266).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61268 = dot( temp_output_7_0_g61268 , ( (temp_output_7_0_g61268).yzx + 33.33 ) );
					float3 temp_output_12_0_g61268 = ( temp_output_7_0_g61268 + dotResult8_g61268 );
					float2 temp_output_597_26_g61265 = ( UV100_g61266 + frac( ( ( (temp_output_12_0_g61268).xx + (temp_output_12_0_g61268).yz ) * (temp_output_12_0_g61268).zy ) ) );
					float temp_output_66_0_g61266 = ( 1.0 - break55_g61266.y );
					float ifLocalVar60_g61266 = 0;
					if( temp_output_56_0_g61266 <= 0.0 )
					ifLocalVar60_g61266 = temp_output_66_0_g61266;
					else
					ifLocalVar60_g61266 = break55_g61266.y;
					float temp_output_597_28_g61265 = ifLocalVar60_g61266;
					float2 ifLocalVar89_g61266 = 0;
					if( temp_output_56_0_g61266 > 0.0 )
					ifLocalVar89_g61266 = temp_output_123_0_g61266;
					else if( temp_output_56_0_g61266 == 0.0 )
					ifLocalVar89_g61266 = temp_output_90_0_g61266;
					else if( temp_output_56_0_g61266 < 0.0 )
					ifLocalVar89_g61266 = temp_output_90_0_g61266;
					float3 temp_output_7_0_g61269 = frac( ( (ifLocalVar89_g61266).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61269 = dot( temp_output_7_0_g61269 , ( (temp_output_7_0_g61269).yzx + 33.33 ) );
					float3 temp_output_12_0_g61269 = ( temp_output_7_0_g61269 + dotResult8_g61269 );
					float2 temp_output_597_27_g61265 = ( UV100_g61266 + frac( ( ( (temp_output_12_0_g61269).xx + (temp_output_12_0_g61269).yz ) * (temp_output_12_0_g61269).zy ) ) );
					float temp_output_67_0_g61266 = ( 1.0 - break55_g61266.x );
					float ifLocalVar61_g61266 = 0;
					if( temp_output_56_0_g61266 <= 0.0 )
					ifLocalVar61_g61266 = temp_output_67_0_g61266;
					else
					ifLocalVar61_g61266 = break55_g61266.x;
					float temp_output_597_29_g61265 = ifLocalVar61_g61266;
					float3 Output_2D_Normal641_g61265 = ( ( UnpackScaleNormal( tex2D( _Sampler82965_g61249, temp_output_597_0_g61265, DDX631_g61265, DDY632_g61265 ), Input_Scale617_g61265 ) * temp_output_597_30_g61265 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g61249, temp_output_597_26_g61265, DDX631_g61265, DDY632_g61265 ), Input_Scale617_g61265 ) * temp_output_597_28_g61265 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g61249, temp_output_597_27_g61265, DDX631_g61265, DDY632_g61265 ), Input_Scale617_g61265 ) * float3( 0,0,0 ) * temp_output_597_29_g61265 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g61249 = Output_2D_Normal641_g61265;
					#else
					float3 staticSwitch1003_g61249 = UnpackScaleNormal( tex2D( _BumpMap, UV0A2420_g61249 ), 1.5 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g61249 = staticSwitch1003_g61249;
					#else
					float3 staticSwitch980_g61249 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g61249 = staticSwitch980_g61249;
					float3 normalizeResult326_g61295 = normalize( Normal_Map700_g61249 );
					float3 Normal_Map318_g61295 = normalizeResult326_g61295;
					float dotResult121_g61295 = dot( appendResult139_g61295 , Normal_Map318_g61295 );
					float temp_output_2_0_g61297 = saturate( dotResult121_g61295 );
					float localStochasticTiling2_g61291 = ( 0.0 );
					float2 UV2_g61291 = UV0B2361_g61249;
					float4 TexelSize2_g61291 = _UdonRNMX0_TexelSize;
					float4 Offsets2_g61291 = float4( 0,0,0,0 );
					float2 Weights2_g61291 = float2( 0,0 );
					{
					UV2_g61291 = UV2_g61291 * TexelSize2_g61291.zw - 0.5;
					float2 f = frac( UV2_g61291 );
					UV2_g61291 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g61291.x - 0.5, UV2_g61291.x + 1.5, UV2_g61291.y - 0.5, UV2_g61291.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g61291 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g61291.xyxy;
					Weights2_g61291 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g61290 = Offsets2_g61291;
					float4 Input_FetchOffsets197_g61292 = temp_output_1_34_g61290;
					float2 temp_output_1_54_g61290 = Weights2_g61291;
					float2 Input_FetchWeights200_g61292 = temp_output_1_54_g61290;
					float2 break187_g61292 = Input_FetchWeights200_g61292;
					float4 lerpResult181_g61292 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g61292).yw ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g61292).xw ) , break187_g61292.x);
					float4 lerpResult182_g61292 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g61292).yz ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g61292).xz ) , break187_g61292.x);
					float4 lerpResult176_g61292 = lerp( lerpResult181_g61292 , lerpResult182_g61292 , break187_g61292.y);
					float4 Output_Fetch2D_Auto202_g61292 = lerpResult176_g61292;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g61249 = Output_Fetch2D_Auto202_g61292;
					#else
					float4 staticSwitch1061_g61249 = tex2D( _UdonRNMX0, UV0B2361_g61249 );
					#endif
					float3 appendResult146_g61295 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g61295 = dot( appendResult146_g61295 , Normal_Map318_g61295 );
					float temp_output_2_0_g61296 = saturate( dotResult122_g61295 );
					float4 Input_FetchOffsets197_g61293 = temp_output_1_34_g61290;
					float2 Input_FetchWeights200_g61293 = temp_output_1_54_g61290;
					float2 break187_g61293 = Input_FetchWeights200_g61293;
					float4 lerpResult181_g61293 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g61293).yw ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g61293).xw ) , break187_g61293.x);
					float4 lerpResult182_g61293 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g61293).yz ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g61293).xz ) , break187_g61293.x);
					float4 lerpResult176_g61293 = lerp( lerpResult181_g61293 , lerpResult182_g61293 , break187_g61293.y);
					float4 Output_Fetch2D_Auto202_g61293 = lerpResult176_g61293;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g61249 = Output_Fetch2D_Auto202_g61293;
					#else
					float4 staticSwitch1062_g61249 = tex2D( _UdonRNMY0, UV0B2361_g61249 );
					#endif
					float3 appendResult149_g61295 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g61295 = dot( appendResult149_g61295 , Normal_Map318_g61295 );
					float temp_output_2_0_g61298 = saturate( dotResult120_g61295 );
					float4 Input_FetchOffsets197_g61294 = temp_output_1_34_g61290;
					float2 Input_FetchWeights200_g61294 = temp_output_1_54_g61290;
					float2 break187_g61294 = Input_FetchWeights200_g61294;
					float4 lerpResult181_g61294 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g61294).yw ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g61294).xw ) , break187_g61294.x);
					float4 lerpResult182_g61294 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g61294).yz ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g61294).xz ) , break187_g61294.x);
					float4 lerpResult176_g61294 = lerp( lerpResult181_g61294 , lerpResult182_g61294 , break187_g61294.y);
					float4 Output_Fetch2D_Auto202_g61294 = lerpResult176_g61294;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g61249 = Output_Fetch2D_Auto202_g61294;
					#else
					float4 staticSwitch1063_g61249 = tex2D( _UdonRNMZ0, UV0B2361_g61249 );
					#endif
					float4 RNM_0926_g61249 = ( ( ( ( ( temp_output_2_0_g61297 * temp_output_2_0_g61297 ) * staticSwitch1061_g61249 ) + ( ( temp_output_2_0_g61296 * temp_output_2_0_g61296 ) * staticSwitch1062_g61249 ) ) + ( ( temp_output_2_0_g61298 * temp_output_2_0_g61298 ) * staticSwitch1063_g61249 ) ) * 1.5 );
					float3 appendResult139_g61261 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g61261 = normalize( Normal_Map700_g61249 );
					float3 Normal_Map318_g61261 = normalizeResult326_g61261;
					float dotResult121_g61261 = dot( appendResult139_g61261 , Normal_Map318_g61261 );
					float temp_output_2_0_g61263 = saturate( dotResult121_g61261 );
					float localStochasticTiling2_g61251 = ( 0.0 );
					float2 UV2_g61251 = UV0B2361_g61249;
					float4 TexelSize2_g61251 = _UdonRNMX1_TexelSize;
					float4 Offsets2_g61251 = float4( 0,0,0,0 );
					float2 Weights2_g61251 = float2( 0,0 );
					{
					UV2_g61251 = UV2_g61251 * TexelSize2_g61251.zw - 0.5;
					float2 f = frac( UV2_g61251 );
					UV2_g61251 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g61251.x - 0.5, UV2_g61251.x + 1.5, UV2_g61251.y - 0.5, UV2_g61251.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g61251 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g61251.xyxy;
					Weights2_g61251 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g61250 = Offsets2_g61251;
					float4 Input_FetchOffsets197_g61252 = temp_output_1_34_g61250;
					float2 temp_output_1_54_g61250 = Weights2_g61251;
					float2 Input_FetchWeights200_g61252 = temp_output_1_54_g61250;
					float2 break187_g61252 = Input_FetchWeights200_g61252;
					float4 lerpResult181_g61252 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g61252).yw ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g61252).xw ) , break187_g61252.x);
					float4 lerpResult182_g61252 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g61252).yz ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g61252).xz ) , break187_g61252.x);
					float4 lerpResult176_g61252 = lerp( lerpResult181_g61252 , lerpResult182_g61252 , break187_g61252.y);
					float4 Output_Fetch2D_Auto202_g61252 = lerpResult176_g61252;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g61249 = Output_Fetch2D_Auto202_g61252;
					#else
					float4 staticSwitch1087_g61249 = tex2D( _UdonRNMX1, UV0B2361_g61249 );
					#endif
					float3 appendResult146_g61261 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g61261 = dot( appendResult146_g61261 , Normal_Map318_g61261 );
					float temp_output_2_0_g61262 = saturate( dotResult122_g61261 );
					float4 Input_FetchOffsets197_g61253 = temp_output_1_34_g61250;
					float2 Input_FetchWeights200_g61253 = temp_output_1_54_g61250;
					float2 break187_g61253 = Input_FetchWeights200_g61253;
					float4 lerpResult181_g61253 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g61253).yw ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g61253).xw ) , break187_g61253.x);
					float4 lerpResult182_g61253 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g61253).yz ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g61253).xz ) , break187_g61253.x);
					float4 lerpResult176_g61253 = lerp( lerpResult181_g61253 , lerpResult182_g61253 , break187_g61253.y);
					float4 Output_Fetch2D_Auto202_g61253 = lerpResult176_g61253;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g61249 = Output_Fetch2D_Auto202_g61253;
					#else
					float4 staticSwitch1083_g61249 = tex2D( _UdonRNMY1, UV0B2361_g61249 );
					#endif
					float3 appendResult149_g61261 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g61261 = dot( appendResult149_g61261 , Normal_Map318_g61261 );
					float temp_output_2_0_g61264 = saturate( dotResult120_g61261 );
					float4 Input_FetchOffsets197_g61254 = temp_output_1_34_g61250;
					float2 Input_FetchWeights200_g61254 = temp_output_1_54_g61250;
					float2 break187_g61254 = Input_FetchWeights200_g61254;
					float4 lerpResult181_g61254 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g61254).yw ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g61254).xw ) , break187_g61254.x);
					float4 lerpResult182_g61254 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g61254).yz ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g61254).xz ) , break187_g61254.x);
					float4 lerpResult176_g61254 = lerp( lerpResult181_g61254 , lerpResult182_g61254 , break187_g61254.y);
					float4 Output_Fetch2D_Auto202_g61254 = lerpResult176_g61254;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g61249 = Output_Fetch2D_Auto202_g61254;
					#else
					float4 staticSwitch1084_g61249 = tex2D( _UdonRNMZ1, UV0B2361_g61249 );
					#endif
					float4 RNM_11081_g61249 = ( ( ( ( ( temp_output_2_0_g61263 * temp_output_2_0_g61263 ) * staticSwitch1087_g61249 ) + ( ( temp_output_2_0_g61262 * temp_output_2_0_g61262 ) * staticSwitch1083_g61249 ) ) + ( ( temp_output_2_0_g61264 * temp_output_2_0_g61264 ) * staticSwitch1084_g61249 ) ) * 1.5 );
					float4 lerpResult953_g61249 = lerp( RNM_0926_g61249 , RNM_11081_g61249 , Lightmap_Lerp_Value969_g61249);
					float4 RNM_Lerp950_g61249 = lerpResult953_g61249;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g61249 = temp_cast_1;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g61249 = Lightmap_0925_g61249;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g61249 = Lightmap_Lerp932_g61249;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g61249 = RNM_0926_g61249;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g61249 = RNM_Lerp950_g61249;
					#else
					float4 staticSwitch1014_g61249 = temp_cast_1;
					#endif
					float3 Lightmap46_g61249 = (staticSwitch1014_g61249).rgb;
					float2 temp_output_5_0_g61285 = UV0A2420_g61249;
					float2 UV633_g61285 = temp_output_5_0_g61285;
					float2 UV100_g61286 = UV633_g61285;
					float2 temp_output_51_0_g61286 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g61286 * float2( 3.464,3.464 ) ) );
					float2 break55_g61286 = frac( temp_output_51_0_g61286 );
					float temp_output_56_0_g61286 = ( ( 1.0 - break55_g61286.x ) - break55_g61286.y );
					float2 temp_output_52_0_g61286 = floor( temp_output_51_0_g61286 );
					float2 temp_output_125_0_g61286 = ( temp_output_52_0_g61286 + float2( 1,1 ) );
					float2 ifLocalVar87_g61286 = 0;
					if( temp_output_56_0_g61286 > 0.0 )
					ifLocalVar87_g61286 = temp_output_52_0_g61286;
					else if( temp_output_56_0_g61286 == 0.0 )
					ifLocalVar87_g61286 = temp_output_125_0_g61286;
					else if( temp_output_56_0_g61286 < 0.0 )
					ifLocalVar87_g61286 = temp_output_125_0_g61286;
					float3 temp_output_7_0_g61287 = frac( ( (ifLocalVar87_g61286).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61287 = dot( temp_output_7_0_g61287 , ( (temp_output_7_0_g61287).yzx + 33.33 ) );
					float3 temp_output_12_0_g61287 = ( temp_output_7_0_g61287 + dotResult8_g61287 );
					float2 temp_output_597_0_g61285 = ( UV100_g61286 + frac( ( ( (temp_output_12_0_g61287).xx + (temp_output_12_0_g61287).yz ) * (temp_output_12_0_g61287).zy ) ) );
					float2 DDX631_g61285 = ddx( temp_output_5_0_g61285 );
					float2 DDY632_g61285 = ddy( temp_output_5_0_g61285 );
					float temp_output_65_0_g61286 = ( 0.0 - temp_output_56_0_g61286 );
					float ifLocalVar59_g61286 = 0;
					if( temp_output_56_0_g61286 <= 0.0 )
					ifLocalVar59_g61286 = temp_output_65_0_g61286;
					else
					ifLocalVar59_g61286 = temp_output_56_0_g61286;
					float temp_output_597_30_g61285 = ifLocalVar59_g61286;
					float2 temp_output_90_0_g61286 = ( temp_output_52_0_g61286 + float2( 0,1 ) );
					float2 temp_output_123_0_g61286 = ( temp_output_52_0_g61286 + float2( 1,0 ) );
					float2 ifLocalVar88_g61286 = 0;
					if( temp_output_56_0_g61286 > 0.0 )
					ifLocalVar88_g61286 = temp_output_90_0_g61286;
					else if( temp_output_56_0_g61286 == 0.0 )
					ifLocalVar88_g61286 = temp_output_123_0_g61286;
					else if( temp_output_56_0_g61286 < 0.0 )
					ifLocalVar88_g61286 = temp_output_123_0_g61286;
					float3 temp_output_7_0_g61288 = frac( ( (ifLocalVar88_g61286).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61288 = dot( temp_output_7_0_g61288 , ( (temp_output_7_0_g61288).yzx + 33.33 ) );
					float3 temp_output_12_0_g61288 = ( temp_output_7_0_g61288 + dotResult8_g61288 );
					float2 temp_output_597_26_g61285 = ( UV100_g61286 + frac( ( ( (temp_output_12_0_g61288).xx + (temp_output_12_0_g61288).yz ) * (temp_output_12_0_g61288).zy ) ) );
					float temp_output_66_0_g61286 = ( 1.0 - break55_g61286.y );
					float ifLocalVar60_g61286 = 0;
					if( temp_output_56_0_g61286 <= 0.0 )
					ifLocalVar60_g61286 = temp_output_66_0_g61286;
					else
					ifLocalVar60_g61286 = break55_g61286.y;
					float temp_output_597_28_g61285 = ifLocalVar60_g61286;
					float2 ifLocalVar89_g61286 = 0;
					if( temp_output_56_0_g61286 > 0.0 )
					ifLocalVar89_g61286 = temp_output_123_0_g61286;
					else if( temp_output_56_0_g61286 == 0.0 )
					ifLocalVar89_g61286 = temp_output_90_0_g61286;
					else if( temp_output_56_0_g61286 < 0.0 )
					ifLocalVar89_g61286 = temp_output_90_0_g61286;
					float3 temp_output_7_0_g61289 = frac( ( (ifLocalVar89_g61286).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61289 = dot( temp_output_7_0_g61289 , ( (temp_output_7_0_g61289).yzx + 33.33 ) );
					float3 temp_output_12_0_g61289 = ( temp_output_7_0_g61289 + dotResult8_g61289 );
					float2 temp_output_597_27_g61285 = ( UV100_g61286 + frac( ( ( (temp_output_12_0_g61289).xx + (temp_output_12_0_g61289).yz ) * (temp_output_12_0_g61289).zy ) ) );
					float temp_output_67_0_g61286 = ( 1.0 - break55_g61286.x );
					float ifLocalVar61_g61286 = 0;
					if( temp_output_56_0_g61286 <= 0.0 )
					ifLocalVar61_g61286 = temp_output_67_0_g61286;
					else
					ifLocalVar61_g61286 = break55_g61286.x;
					float temp_output_597_29_g61285 = ifLocalVar61_g61286;
					float4 Output_2D293_g61285 = ( ( tex2D( _Sampler82968_g61249, temp_output_597_0_g61285, DDX631_g61285, DDY632_g61285 ) * temp_output_597_30_g61285 ) + ( tex2D( _Sampler82968_g61249, temp_output_597_26_g61285, DDX631_g61285, DDY632_g61285 ) * temp_output_597_28_g61285 ) + ( tex2D( _Sampler82968_g61249, temp_output_597_27_g61285, DDX631_g61285, DDY632_g61285 ) * temp_output_597_29_g61285 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g61249 = Output_2D293_g61285;
					#else
					float4 staticSwitch1006_g61249 = tex2D( _EmissionMap, UV0A2420_g61249 );
					#endif
					float3 temp_output_2531_0_g61249 = (( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g61249 * _EmissionIntensity )).rgb;
					float3 Emission86_g61249 = temp_output_2531_0_g61249;
					float3 Color1_g61300 = oAlbedo6_g61249;
					float Metallic1_g61300 = Metallic1239_g61249;
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g61249 = tex2D( _GlossinessMap, UV0A2420_g61249 ).r;
					#else
					float staticSwitch845_g61249 = _Glossiness;
					#endif
					float2 temp_output_5_0_g61280 = UV0A2420_g61249;
					float2 UV633_g61280 = temp_output_5_0_g61280;
					float2 UV100_g61281 = UV633_g61280;
					float2 temp_output_51_0_g61281 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g61281 * float2( 3.464,3.464 ) ) );
					float2 break55_g61281 = frac( temp_output_51_0_g61281 );
					float temp_output_56_0_g61281 = ( ( 1.0 - break55_g61281.x ) - break55_g61281.y );
					float2 temp_output_52_0_g61281 = floor( temp_output_51_0_g61281 );
					float2 temp_output_125_0_g61281 = ( temp_output_52_0_g61281 + float2( 1,1 ) );
					float2 ifLocalVar87_g61281 = 0;
					if( temp_output_56_0_g61281 > 0.0 )
					ifLocalVar87_g61281 = temp_output_52_0_g61281;
					else if( temp_output_56_0_g61281 == 0.0 )
					ifLocalVar87_g61281 = temp_output_125_0_g61281;
					else if( temp_output_56_0_g61281 < 0.0 )
					ifLocalVar87_g61281 = temp_output_125_0_g61281;
					float3 temp_output_7_0_g61282 = frac( ( (ifLocalVar87_g61281).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61282 = dot( temp_output_7_0_g61282 , ( (temp_output_7_0_g61282).yzx + 33.33 ) );
					float3 temp_output_12_0_g61282 = ( temp_output_7_0_g61282 + dotResult8_g61282 );
					float2 temp_output_597_0_g61280 = ( UV100_g61281 + frac( ( ( (temp_output_12_0_g61282).xx + (temp_output_12_0_g61282).yz ) * (temp_output_12_0_g61282).zy ) ) );
					float2 DDX631_g61280 = ddx( temp_output_5_0_g61280 );
					float2 DDY632_g61280 = ddy( temp_output_5_0_g61280 );
					float temp_output_65_0_g61281 = ( 0.0 - temp_output_56_0_g61281 );
					float ifLocalVar59_g61281 = 0;
					if( temp_output_56_0_g61281 <= 0.0 )
					ifLocalVar59_g61281 = temp_output_65_0_g61281;
					else
					ifLocalVar59_g61281 = temp_output_56_0_g61281;
					float temp_output_597_30_g61280 = ifLocalVar59_g61281;
					float2 temp_output_90_0_g61281 = ( temp_output_52_0_g61281 + float2( 0,1 ) );
					float2 temp_output_123_0_g61281 = ( temp_output_52_0_g61281 + float2( 1,0 ) );
					float2 ifLocalVar88_g61281 = 0;
					if( temp_output_56_0_g61281 > 0.0 )
					ifLocalVar88_g61281 = temp_output_90_0_g61281;
					else if( temp_output_56_0_g61281 == 0.0 )
					ifLocalVar88_g61281 = temp_output_123_0_g61281;
					else if( temp_output_56_0_g61281 < 0.0 )
					ifLocalVar88_g61281 = temp_output_123_0_g61281;
					float3 temp_output_7_0_g61283 = frac( ( (ifLocalVar88_g61281).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61283 = dot( temp_output_7_0_g61283 , ( (temp_output_7_0_g61283).yzx + 33.33 ) );
					float3 temp_output_12_0_g61283 = ( temp_output_7_0_g61283 + dotResult8_g61283 );
					float2 temp_output_597_26_g61280 = ( UV100_g61281 + frac( ( ( (temp_output_12_0_g61283).xx + (temp_output_12_0_g61283).yz ) * (temp_output_12_0_g61283).zy ) ) );
					float temp_output_66_0_g61281 = ( 1.0 - break55_g61281.y );
					float ifLocalVar60_g61281 = 0;
					if( temp_output_56_0_g61281 <= 0.0 )
					ifLocalVar60_g61281 = temp_output_66_0_g61281;
					else
					ifLocalVar60_g61281 = break55_g61281.y;
					float temp_output_597_28_g61280 = ifLocalVar60_g61281;
					float2 ifLocalVar89_g61281 = 0;
					if( temp_output_56_0_g61281 > 0.0 )
					ifLocalVar89_g61281 = temp_output_123_0_g61281;
					else if( temp_output_56_0_g61281 == 0.0 )
					ifLocalVar89_g61281 = temp_output_90_0_g61281;
					else if( temp_output_56_0_g61281 < 0.0 )
					ifLocalVar89_g61281 = temp_output_90_0_g61281;
					float3 temp_output_7_0_g61284 = frac( ( (ifLocalVar89_g61281).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61284 = dot( temp_output_7_0_g61284 , ( (temp_output_7_0_g61284).yzx + 33.33 ) );
					float3 temp_output_12_0_g61284 = ( temp_output_7_0_g61284 + dotResult8_g61284 );
					float2 temp_output_597_27_g61280 = ( UV100_g61281 + frac( ( ( (temp_output_12_0_g61284).xx + (temp_output_12_0_g61284).yz ) * (temp_output_12_0_g61284).zy ) ) );
					float temp_output_67_0_g61281 = ( 1.0 - break55_g61281.x );
					float ifLocalVar61_g61281 = 0;
					if( temp_output_56_0_g61281 <= 0.0 )
					ifLocalVar61_g61281 = temp_output_67_0_g61281;
					else
					ifLocalVar61_g61281 = break55_g61281.x;
					float temp_output_597_29_g61280 = ifLocalVar61_g61281;
					float4 Output_2D293_g61280 = ( ( tex2D( _Sampler82964_g61249, temp_output_597_0_g61280, DDX631_g61280, DDY632_g61280 ) * temp_output_597_30_g61280 ) + ( tex2D( _Sampler82964_g61249, temp_output_597_26_g61280, DDX631_g61280, DDY632_g61280 ) * temp_output_597_28_g61280 ) + ( tex2D( _Sampler82964_g61249, temp_output_597_27_g61280, DDX631_g61280, DDY632_g61280 ) * temp_output_597_29_g61280 ) );
					float4 break31_g61280 = Output_2D293_g61280;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g61249 = ( 1.0 - break31_g61280.r );
					#else
					float staticSwitch1004_g61249 = ( 1.0 - staticSwitch845_g61249 );
					#endif
					float temp_output_19_0_g61299 = staticSwitch1004_g61249;
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal2504_g61249 = Normal_Map700_g61249;
					float3 worldNormal2504_g61249 = normalize( float3( dot( tanToWorld0, tanNormal2504_g61249 ), dot( tanToWorld1, tanNormal2504_g61249 ), dot( tanToWorld2, tanNormal2504_g61249 ) ) );
					float3 World_Normal2508_g61249 = worldNormal2504_g61249;
					float3 tanNormal2_g61299 = World_Normal2508_g61249;
					float3 worldNormal2_g61299 = float3( dot( tanToWorld0, tanNormal2_g61299 ), dot( tanToWorld1, tanNormal2_g61299 ), dot( tanToWorld2, tanNormal2_g61299 ) );
					float3 temp_output_3_0_g61299 = ddx( worldNormal2_g61299 );
					float dotResult5_g61299 = dot( temp_output_3_0_g61299 , temp_output_3_0_g61299 );
					float3 temp_output_4_0_g61299 = ddy( worldNormal2_g61299 );
					float dotResult6_g61299 = dot( temp_output_4_0_g61299 , temp_output_4_0_g61299 );
					#ifdef _USEGEOMETRICAA_ON
					float staticSwitch15_g61299 = min( temp_output_19_0_g61299, ( 1.0 - pow( saturate( max( dotResult5_g61299, dotResult6_g61299 ) ) , 0.25 ) ) );
					#else
					float staticSwitch15_g61299 = temp_output_19_0_g61299;
					#endif
					float Smoothness1399_g61249 = staticSwitch15_g61299;
					float Smoothness1_g61300 = Smoothness1399_g61249;
					float IOR2700_g61249 = _IOR;
					float IOR1_g61300 = IOR2700_g61249;
					float3 temp_cast_4 = (0.04).xxx;
					float3 lerpResult1473_g61249 = lerp( temp_cast_4 , oAlbedo6_g61249 , Metallic1239_g61249);
					float3 switchResult1501_g61249 = (((ase_vface>0)?(World_Normal2508_g61249):(-World_Normal2508_g61249)));
					float3 View_Direction2511_g61249 = ViewDirWS;
					float dotResult1476_g61249 = dot( switchResult1501_g61249 , View_Direction2511_g61249 );
					float3 lerpResult1480_g61249 = lerp( lerpResult1473_g61249 , float3( 1,1,1 ) , pow( ( 1.0 - saturate( dotResult1476_g61249 ) ) , 5.0 ));
					float3 Fresnel1560_g61249 = lerpResult1480_g61249;
					float3 Fresnel1_g61300 = Fresnel1560_g61249;
					float3 World_Position2505_g61249 = PositionWS;
					float3 WorldPos1_g61300 = World_Position2505_g61249;
					float3 WorldNormal1_g61300 = World_Normal2508_g61249;
					float3 ViewDir1_g61300 = View_Direction2511_g61249;
					float3 localIndirectSpecular1_g61300 = IndirectSpecular1_g61300( Color1_g61300 , Metallic1_g61300 , Smoothness1_g61300 , IOR1_g61300 , Fresnel1_g61300 , WorldPos1_g61300 , WorldNormal1_g61300 , ViewDir1_g61300 );
					float3 temp_output_2805_0_g61249 = localIndirectSpecular1_g61300;
					float grayscale2713_g61249 = Luminance( Lightmap46_g61249 );
					float smoothstepResult2430_g61249 = smoothstep( 0.0 , 0.05 , grayscale2713_g61249);
					#ifdef _USELIGHTMAPPEDREFLECTIONS_ON
					float3 staticSwitch1469_g61249 = ( temp_output_2805_0_g61249 * smoothstepResult2430_g61249 );
					#else
					float3 staticSwitch1469_g61249 = temp_output_2805_0_g61249;
					#endif
					float3 Reflections1419_g61249 = staticSwitch1469_g61249;
					float3 Color97_g61301 = oAlbedo6_g61249;
					float3 LightmapColor97_g61301 = Lightmap46_g61249;
					float Metallic97_g61301 = Metallic1239_g61249;
					float Smoothness97_g61301 = Smoothness1399_g61249;
					float IOR97_g61301 = IOR2700_g61249;
					float3 Fresnel97_g61301 = Fresnel1560_g61249;
					float3 WorldPos97_g61301 = World_Position2505_g61249;
					float3 WorldNormal97_g61301 = World_Normal2508_g61249;
					float3 ViewDir97_g61301 = View_Direction2511_g61249;
					float3 localDirectSpecular97_g61301 = DirectSpecular( Color97_g61301 , LightmapColor97_g61301 , Metallic97_g61301 , Smoothness97_g61301 , IOR97_g61301 , Fresnel97_g61301 , WorldPos97_g61301 , WorldNormal97_g61301 , ViewDir97_g61301 );
					float3 Speculars2560_g61249 = localDirectSpecular97_g61301;
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch1181_g61249 = Lightmap46_g61249;
					#else
					float3 staticSwitch1181_g61249 = ( ( aAlbedo1466_g61249 * Lightmap46_g61249 ) + Emission86_g61249 + Reflections1419_g61249 + Speculars2560_g61249 );
					#endif
					float3 temp_output_35_0_g61259 = staticSwitch1181_g61249;
					float3 Color353_g61259 = temp_output_35_0_g61259;
					#if defined( _LUTMODE_2D )
					float3 staticSwitch273_g61259 = saturate( temp_output_35_0_g61259 );
					#elif defined( _LUTMODE_3D )
					float3 staticSwitch273_g61259 = temp_output_35_0_g61259;
					#else
					float3 staticSwitch273_g61259 = temp_output_35_0_g61259;
					#endif
					float3 Color_Saturate49_g61259 = staticSwitch273_g61259;
					float Lut_Height213_g61259 = _LUTSize;
					float Lut_Width216_g61259 = ( _LUTSize * Lut_Height213_g61259 );
					float3 appendResult214_g61259 = (float3(( 1.0 / Lut_Width216_g61259 ) , ( 1.0 / Lut_Height213_g61259 ) , ( Lut_Height213_g61259 - 1.0 )));
					float3 Scale_Offset208_g61259 = appendResult214_g61259;
					float2 Scale_Factor292_g61259 = ( (Scale_Offset208_g61259).xy * (Scale_Offset208_g61259).z );
					float2 Offset299_g61259 = ( (Scale_Offset208_g61259).xy * 0.5 );
					float2 Adjusted_UV305_g61259 = ( ( (Color_Saturate49_g61259).xy * Scale_Factor292_g61259 ) + Offset299_g61259 );
					float Scaled_Blue280_g61259 = ( (Color_Saturate49_g61259).z * (Scale_Offset208_g61259).z );
					float Shift288_g61259 = floor( Scaled_Blue280_g61259 );
					float Final_X313_g61259 = ( (Adjusted_UV305_g61259).x + ( Shift288_g61259 * (Scale_Offset208_g61259).y ) );
					float2 appendResult326_g61259 = (float2(Final_X313_g61259 , (Adjusted_UV305_g61259).y));
					float2 Final_UV325_g61259 = appendResult326_g61259;
					float2 appendResult338_g61259 = (float2((Scale_Offset208_g61259).y , 0.0));
					float2 Offset_UV336_g61259 = ( Final_UV325_g61259 + appendResult338_g61259 );
					float3 lerpResult333_g61259 = lerp( tex2D( _2DLut, Final_UV325_g61259 ).rgb , tex2D( _2DLut, Offset_UV336_g61259 ).rgb , ( Scaled_Blue280_g61259 - Shift288_g61259 ));
					#ifdef _2DLUT
					float3 staticSwitch347_g61259 = lerpResult333_g61259;
					#else
					float3 staticSwitch347_g61259 = Color_Saturate49_g61259;
					#endif
					float3 TwoD_LUT346_g61259 = staticSwitch347_g61259;
					float3 RGB16_g61260 = ( ( log10( ( ( Color_Saturate49_g61259 * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 );
					#ifdef _3DLUT
					float3 staticSwitch194_g61259 = tex3D( _3DLut, RGB16_g61260 ).rgb;
					#else
					float3 staticSwitch194_g61259 = Color_Saturate49_g61259;
					#endif
					float3 ThreeD_LUT51_g61259 = staticSwitch194_g61259;
					#if defined( _LUTMODE_2D )
					float3 staticSwitch42_g61259 = TwoD_LUT346_g61259;
					#elif defined( _LUTMODE_3D )
					float3 staticSwitch42_g61259 = ThreeD_LUT51_g61259;
					#else
					float3 staticSwitch42_g61259 = ThreeD_LUT51_g61259;
					#endif
					#ifdef SHADER_API_MOBILE
					float3 staticSwitch41_g61259 = staticSwitch42_g61259;
					#else
					float3 staticSwitch41_g61259 = Color353_g61259;
					#endif
					

					o.Albedo = staticSwitch1180_g61249;
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

					o.Emission = staticSwitch41_g61259;
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
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;6023;0,-1280;Inherit;False;Meenphie;0;;61249;b3ba55a08dd6b49c7be16c6f35cf2033;6,1008,0,2632,0,2635,0,2636,0,2670,0,2619,0;0;5;FLOAT3;625;FLOAT3;624;FLOAT;156;FLOAT;427;FLOAT;1024
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5279;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;10;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5280;256,-1280;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;6;Meenphie/Standard/Opaque;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardBase;0;1;ForwardBase;17;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;True;True;0;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;44;Category;0;0;  Instanced Terrain Normals;1;0;Workflow;3;639079749420714040;Surface;0;0;  Blend;0;0;  Dither Shadows;1;0;Two Sided;1;0;Alpha Clipping;0;0;  Use Shadow Threshold;0;0;Deferred Pass;0;639079951064078170;Normal Space;0;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;0;639108440689538340;Receive Shadows;1;0;Receive Specular;0;639108440701916390;Receive Reflections;0;639108447998214750;GPU Instancing;1;0;LOD CrossFade;1;0;Built-in Fog;1;639105044169342440;Ambient Light;1;639111933610282130;Meta Pass;0;639111933576947160;Add Pass;0;639111933580732010;Override Baked GI;0;0;Write Depth;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;0;Vertex Position;1;0;0;8;False;True;False;False;False;False;True;True;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5281;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;10;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;True;1;LightMode=ForwardAdd;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5282;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;10;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5283;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;10;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5284;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;10;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5285;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;10;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5286;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;10;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ScenePickingPass;0;7;ScenePickingPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=Picking;False;False;0;;0;0;Standard;0;False;0
WireConnection;5280;0;6023;625
WireConnection;5280;2;6023;624
ASEEND*/
//CHKSM=DF6AE592F39AED7998B238157927BDACF0737671