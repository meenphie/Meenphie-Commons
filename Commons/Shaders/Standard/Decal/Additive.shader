// Made with Amplify Shader Editor v1.9.9.7
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Standard/Decal/Additive"
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

			Blend One One

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
				sampler2D _Sampler82966_g61082;
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				sampler2D _Sampler82967_g61082;
				uniform sampler2D _Lightmap0;
				float4 _Lightmap0_TexelSize;
				uniform sampler2D _Lightmap1;
				float4 _Lightmap1_TexelSize;
				uniform float _UdonLightmapLerp;
				uniform sampler2D _BumpMap;
				sampler2D _Sampler82965_g61082;
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
				sampler2D _Sampler82968_g61082;
				uniform float _EmissionIntensity;
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				sampler2D _Sampler82964_g61082;
				uniform float _IOR;


				float3 IndirectSpecular1_g61133( float3 Color, float Metallic, float Smoothness, float IOR, float3 Fresnel, float3 WorldPos, float3 WorldNormal, float3 ViewDir )
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

					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 World_Position2505_g61082 = ase_positionWS;
					
					o.ase_texcoord6.xy = v.texcoord2.xyzw.xy;
					o.ase_texcoord7 = v.texcoord.xyzw;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord6.zw = 0;

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = ( v.normal * ( distance( World_Position2505_g61082 , _WorldSpaceCameraPos ) * 0.0005 ) );
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

					float2 texCoord2594_g61082 = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV22595_g61082 = texCoord2594_g61082;
					#ifdef _MAINTEX
					float4 staticSwitch1549_g61082 = tex2D( _MainTex, UV22595_g61082 );
					#else
					float4 staticSwitch1549_g61082 = _Color;
					#endif
					float2 temp_output_5_0_g61108 = UV22595_g61082;
					float2 UV633_g61108 = temp_output_5_0_g61108;
					float2 UV100_g61109 = UV633_g61108;
					float2 temp_output_51_0_g61109 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g61109 * float2( 3.464,3.464 ) ) );
					float2 break55_g61109 = frac( temp_output_51_0_g61109 );
					float temp_output_56_0_g61109 = ( ( 1.0 - break55_g61109.x ) - break55_g61109.y );
					float2 temp_output_52_0_g61109 = floor( temp_output_51_0_g61109 );
					float2 temp_output_125_0_g61109 = ( temp_output_52_0_g61109 + float2( 1,1 ) );
					float2 ifLocalVar87_g61109 = 0;
					if( temp_output_56_0_g61109 > 0.0 )
					ifLocalVar87_g61109 = temp_output_52_0_g61109;
					else if( temp_output_56_0_g61109 == 0.0 )
					ifLocalVar87_g61109 = temp_output_125_0_g61109;
					else if( temp_output_56_0_g61109 < 0.0 )
					ifLocalVar87_g61109 = temp_output_125_0_g61109;
					float3 temp_output_7_0_g61110 = frac( ( (ifLocalVar87_g61109).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61110 = dot( temp_output_7_0_g61110 , ( (temp_output_7_0_g61110).yzx + 33.33 ) );
					float3 temp_output_12_0_g61110 = ( temp_output_7_0_g61110 + dotResult8_g61110 );
					float2 temp_output_597_0_g61108 = ( UV100_g61109 + frac( ( ( (temp_output_12_0_g61110).xx + (temp_output_12_0_g61110).yz ) * (temp_output_12_0_g61110).zy ) ) );
					float2 DDX631_g61108 = ddx( temp_output_5_0_g61108 );
					float2 DDY632_g61108 = ddy( temp_output_5_0_g61108 );
					float temp_output_65_0_g61109 = ( 0.0 - temp_output_56_0_g61109 );
					float ifLocalVar59_g61109 = 0;
					if( temp_output_56_0_g61109 <= 0.0 )
					ifLocalVar59_g61109 = temp_output_65_0_g61109;
					else
					ifLocalVar59_g61109 = temp_output_56_0_g61109;
					float temp_output_597_30_g61108 = ifLocalVar59_g61109;
					float2 temp_output_90_0_g61109 = ( temp_output_52_0_g61109 + float2( 0,1 ) );
					float2 temp_output_123_0_g61109 = ( temp_output_52_0_g61109 + float2( 1,0 ) );
					float2 ifLocalVar88_g61109 = 0;
					if( temp_output_56_0_g61109 > 0.0 )
					ifLocalVar88_g61109 = temp_output_90_0_g61109;
					else if( temp_output_56_0_g61109 == 0.0 )
					ifLocalVar88_g61109 = temp_output_123_0_g61109;
					else if( temp_output_56_0_g61109 < 0.0 )
					ifLocalVar88_g61109 = temp_output_123_0_g61109;
					float3 temp_output_7_0_g61111 = frac( ( (ifLocalVar88_g61109).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61111 = dot( temp_output_7_0_g61111 , ( (temp_output_7_0_g61111).yzx + 33.33 ) );
					float3 temp_output_12_0_g61111 = ( temp_output_7_0_g61111 + dotResult8_g61111 );
					float2 temp_output_597_26_g61108 = ( UV100_g61109 + frac( ( ( (temp_output_12_0_g61111).xx + (temp_output_12_0_g61111).yz ) * (temp_output_12_0_g61111).zy ) ) );
					float temp_output_66_0_g61109 = ( 1.0 - break55_g61109.y );
					float ifLocalVar60_g61109 = 0;
					if( temp_output_56_0_g61109 <= 0.0 )
					ifLocalVar60_g61109 = temp_output_66_0_g61109;
					else
					ifLocalVar60_g61109 = break55_g61109.y;
					float temp_output_597_28_g61108 = ifLocalVar60_g61109;
					float2 ifLocalVar89_g61109 = 0;
					if( temp_output_56_0_g61109 > 0.0 )
					ifLocalVar89_g61109 = temp_output_123_0_g61109;
					else if( temp_output_56_0_g61109 == 0.0 )
					ifLocalVar89_g61109 = temp_output_90_0_g61109;
					else if( temp_output_56_0_g61109 < 0.0 )
					ifLocalVar89_g61109 = temp_output_90_0_g61109;
					float3 temp_output_7_0_g61112 = frac( ( (ifLocalVar89_g61109).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61112 = dot( temp_output_7_0_g61112 , ( (temp_output_7_0_g61112).yzx + 33.33 ) );
					float3 temp_output_12_0_g61112 = ( temp_output_7_0_g61112 + dotResult8_g61112 );
					float2 temp_output_597_27_g61108 = ( UV100_g61109 + frac( ( ( (temp_output_12_0_g61112).xx + (temp_output_12_0_g61112).yz ) * (temp_output_12_0_g61112).zy ) ) );
					float temp_output_67_0_g61109 = ( 1.0 - break55_g61109.x );
					float ifLocalVar61_g61109 = 0;
					if( temp_output_56_0_g61109 <= 0.0 )
					ifLocalVar61_g61109 = temp_output_67_0_g61109;
					else
					ifLocalVar61_g61109 = break55_g61109.x;
					float temp_output_597_29_g61108 = ifLocalVar61_g61109;
					float4 Output_2D293_g61108 = ( ( tex2D( _Sampler82966_g61082, temp_output_597_0_g61108, DDX631_g61108, DDY632_g61108 ) * temp_output_597_30_g61108 ) + ( tex2D( _Sampler82966_g61082, temp_output_597_26_g61108, DDX631_g61108, DDY632_g61108 ) * temp_output_597_28_g61108 ) + ( tex2D( _Sampler82966_g61082, temp_output_597_27_g61108, DDX631_g61108, DDY632_g61108 ) * temp_output_597_29_g61108 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g61082 = Output_2D293_g61108;
					#else
					float4 staticSwitch1001_g61082 = staticSwitch1549_g61082;
					#endif
					float3 temp_output_2532_0_g61082 = (staticSwitch1001_g61082).rgb;
					float3 oAlbedo6_g61082 = temp_output_2532_0_g61082;
					float Black1185_g61082 = 0.0;
					float3 temp_cast_0 = (Black1185_g61082).xxx;
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch1180_g61082 = temp_cast_0;
					#else
					float3 staticSwitch1180_g61082 = oAlbedo6_g61082;
					#endif
					
					float2 texCoord2357_g61082 = IN.ase_texcoord7.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0A2420_g61082 = texCoord2357_g61082;
					#if defined( _UV_UV0 )
					float2 staticSwitch2671_g61082 = UV0A2420_g61082;
					#elif defined( _UV_UV2 )
					float2 staticSwitch2671_g61082 = UV22595_g61082;
					#else
					float2 staticSwitch2671_g61082 = UV22595_g61082;
					#endif
					#ifdef _METALLICMAP
					float staticSwitch846_g61082 = tex2D( _MetallicMap, staticSwitch2671_g61082 ).r;
					#else
					float staticSwitch846_g61082 = _Metallic;
					#endif
					float2 temp_output_5_0_g61103 = staticSwitch2671_g61082;
					float2 UV633_g61103 = temp_output_5_0_g61103;
					float2 UV100_g61104 = UV633_g61103;
					float2 temp_output_51_0_g61104 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g61104 * float2( 3.464,3.464 ) ) );
					float2 break55_g61104 = frac( temp_output_51_0_g61104 );
					float temp_output_56_0_g61104 = ( ( 1.0 - break55_g61104.x ) - break55_g61104.y );
					float2 temp_output_52_0_g61104 = floor( temp_output_51_0_g61104 );
					float2 temp_output_125_0_g61104 = ( temp_output_52_0_g61104 + float2( 1,1 ) );
					float2 ifLocalVar87_g61104 = 0;
					if( temp_output_56_0_g61104 > 0.0 )
					ifLocalVar87_g61104 = temp_output_52_0_g61104;
					else if( temp_output_56_0_g61104 == 0.0 )
					ifLocalVar87_g61104 = temp_output_125_0_g61104;
					else if( temp_output_56_0_g61104 < 0.0 )
					ifLocalVar87_g61104 = temp_output_125_0_g61104;
					float3 temp_output_7_0_g61105 = frac( ( (ifLocalVar87_g61104).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61105 = dot( temp_output_7_0_g61105 , ( (temp_output_7_0_g61105).yzx + 33.33 ) );
					float3 temp_output_12_0_g61105 = ( temp_output_7_0_g61105 + dotResult8_g61105 );
					float2 temp_output_597_0_g61103 = ( UV100_g61104 + frac( ( ( (temp_output_12_0_g61105).xx + (temp_output_12_0_g61105).yz ) * (temp_output_12_0_g61105).zy ) ) );
					float2 DDX631_g61103 = ddx( temp_output_5_0_g61103 );
					float2 DDY632_g61103 = ddy( temp_output_5_0_g61103 );
					float temp_output_65_0_g61104 = ( 0.0 - temp_output_56_0_g61104 );
					float ifLocalVar59_g61104 = 0;
					if( temp_output_56_0_g61104 <= 0.0 )
					ifLocalVar59_g61104 = temp_output_65_0_g61104;
					else
					ifLocalVar59_g61104 = temp_output_56_0_g61104;
					float temp_output_597_30_g61103 = ifLocalVar59_g61104;
					float2 temp_output_90_0_g61104 = ( temp_output_52_0_g61104 + float2( 0,1 ) );
					float2 temp_output_123_0_g61104 = ( temp_output_52_0_g61104 + float2( 1,0 ) );
					float2 ifLocalVar88_g61104 = 0;
					if( temp_output_56_0_g61104 > 0.0 )
					ifLocalVar88_g61104 = temp_output_90_0_g61104;
					else if( temp_output_56_0_g61104 == 0.0 )
					ifLocalVar88_g61104 = temp_output_123_0_g61104;
					else if( temp_output_56_0_g61104 < 0.0 )
					ifLocalVar88_g61104 = temp_output_123_0_g61104;
					float3 temp_output_7_0_g61106 = frac( ( (ifLocalVar88_g61104).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61106 = dot( temp_output_7_0_g61106 , ( (temp_output_7_0_g61106).yzx + 33.33 ) );
					float3 temp_output_12_0_g61106 = ( temp_output_7_0_g61106 + dotResult8_g61106 );
					float2 temp_output_597_26_g61103 = ( UV100_g61104 + frac( ( ( (temp_output_12_0_g61106).xx + (temp_output_12_0_g61106).yz ) * (temp_output_12_0_g61106).zy ) ) );
					float temp_output_66_0_g61104 = ( 1.0 - break55_g61104.y );
					float ifLocalVar60_g61104 = 0;
					if( temp_output_56_0_g61104 <= 0.0 )
					ifLocalVar60_g61104 = temp_output_66_0_g61104;
					else
					ifLocalVar60_g61104 = break55_g61104.y;
					float temp_output_597_28_g61103 = ifLocalVar60_g61104;
					float2 ifLocalVar89_g61104 = 0;
					if( temp_output_56_0_g61104 > 0.0 )
					ifLocalVar89_g61104 = temp_output_123_0_g61104;
					else if( temp_output_56_0_g61104 == 0.0 )
					ifLocalVar89_g61104 = temp_output_90_0_g61104;
					else if( temp_output_56_0_g61104 < 0.0 )
					ifLocalVar89_g61104 = temp_output_90_0_g61104;
					float3 temp_output_7_0_g61107 = frac( ( (ifLocalVar89_g61104).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61107 = dot( temp_output_7_0_g61107 , ( (temp_output_7_0_g61107).yzx + 33.33 ) );
					float3 temp_output_12_0_g61107 = ( temp_output_7_0_g61107 + dotResult8_g61107 );
					float2 temp_output_597_27_g61103 = ( UV100_g61104 + frac( ( ( (temp_output_12_0_g61107).xx + (temp_output_12_0_g61107).yz ) * (temp_output_12_0_g61107).zy ) ) );
					float temp_output_67_0_g61104 = ( 1.0 - break55_g61104.x );
					float ifLocalVar61_g61104 = 0;
					if( temp_output_56_0_g61104 <= 0.0 )
					ifLocalVar61_g61104 = temp_output_67_0_g61104;
					else
					ifLocalVar61_g61104 = break55_g61104.x;
					float temp_output_597_29_g61103 = ifLocalVar61_g61104;
					float4 Output_2D293_g61103 = ( ( tex2D( _Sampler82967_g61082, temp_output_597_0_g61103, DDX631_g61103, DDY632_g61103 ) * temp_output_597_30_g61103 ) + ( tex2D( _Sampler82967_g61082, temp_output_597_26_g61103, DDX631_g61103, DDY632_g61103 ) * temp_output_597_28_g61103 ) + ( tex2D( _Sampler82967_g61082, temp_output_597_27_g61103, DDX631_g61103, DDY632_g61103 ) * temp_output_597_29_g61103 ) );
					float4 break31_g61103 = Output_2D293_g61103;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g61082 = break31_g61103.r;
					#else
					float staticSwitch1005_g61082 = staticSwitch846_g61082;
					#endif
					float Metallic1239_g61082 = staticSwitch1005_g61082;
					float3 aAlbedo1466_g61082 = ( temp_output_2532_0_g61082 * ( 1.0 - Metallic1239_g61082 ) );
					float White38_g61082 = 1.0;
					float4 temp_cast_1 = (White38_g61082).xxxx;
					float4 texCoord2426_g61082 = IN.ase_texcoord7;
					texCoord2426_g61082.xy = IN.ase_texcoord7.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0B2361_g61082 = (texCoord2426_g61082).zw;
					float localBicubicPrepare2_g61091 = ( 0.0 );
					float2 Input_UV100_g61091 = UV0B2361_g61082;
					float2 UV2_g61091 = Input_UV100_g61091;
					float4 TexelSize2_g61091 = _Lightmap0_TexelSize;
					float2 UV02_g61091 = float2( 0,0 );
					float2 UV12_g61091 = float2( 0,0 );
					float2 UV22_g61091 = float2( 0,0 );
					float2 UV32_g61091 = float2( 0,0 );
					float W02_g61091 = 0;
					float W12_g61091 = 0;
					{
					{
					 UV2_g61091 = UV2_g61091 * TexelSize2_g61091.zw - 0.5;
					    float2 f = frac( UV2_g61091 );
					    UV2_g61091 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g61091.x - 0.5, UV2_g61091.x + 1.5, UV2_g61091.y - 0.5, UV2_g61091.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g61091.xyxy;
					    UV02_g61091 = off.xz;
					    UV12_g61091 = off.yz;
					    UV22_g61091 = off.xw;
					    UV32_g61091 = off.yw;
					    W02_g61091 = s.x / ( s.x + s.y );
					 W12_g61091 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g61091 = lerp( tex2D( _Lightmap0, UV32_g61091 ) , tex2D( _Lightmap0, UV22_g61091 ) , W02_g61091);
					float4 lerpResult45_g61091 = lerp( tex2D( _Lightmap0, UV12_g61091 ) , tex2D( _Lightmap0, UV02_g61091 ) , W02_g61091);
					float4 lerpResult44_g61091 = lerp( lerpResult46_g61091 , lerpResult45_g61091 , W12_g61091);
					float4 Output_2D_Auto131_g61091 = lerpResult44_g61091;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g61082 = Output_2D_Auto131_g61091;
					#else
					float4 staticSwitch1092_g61082 = float4( tex2D( _Lightmap0, UV0B2361_g61082 ).rgb , 0.0 );
					#endif
					float4 Lightmap_0925_g61082 = staticSwitch1092_g61082;
					float localBicubicPrepare2_g61089 = ( 0.0 );
					float2 Input_UV100_g61089 = UV0B2361_g61082;
					float2 UV2_g61089 = Input_UV100_g61089;
					float4 TexelSize2_g61089 = _Lightmap1_TexelSize;
					float2 UV02_g61089 = float2( 0,0 );
					float2 UV12_g61089 = float2( 0,0 );
					float2 UV22_g61089 = float2( 0,0 );
					float2 UV32_g61089 = float2( 0,0 );
					float W02_g61089 = 0;
					float W12_g61089 = 0;
					{
					{
					 UV2_g61089 = UV2_g61089 * TexelSize2_g61089.zw - 0.5;
					    float2 f = frac( UV2_g61089 );
					    UV2_g61089 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g61089.x - 0.5, UV2_g61089.x + 1.5, UV2_g61089.y - 0.5, UV2_g61089.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g61089.xyxy;
					    UV02_g61089 = off.xz;
					    UV12_g61089 = off.yz;
					    UV22_g61089 = off.xw;
					    UV32_g61089 = off.yw;
					    W02_g61089 = s.x / ( s.x + s.y );
					 W12_g61089 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g61089 = lerp( tex2D( _Lightmap1, UV32_g61089 ) , tex2D( _Lightmap1, UV22_g61089 ) , W02_g61089);
					float4 lerpResult45_g61089 = lerp( tex2D( _Lightmap1, UV12_g61089 ) , tex2D( _Lightmap1, UV02_g61089 ) , W02_g61089);
					float4 lerpResult44_g61089 = lerp( lerpResult46_g61089 , lerpResult45_g61089 , W12_g61089);
					float4 Output_2D_Auto131_g61089 = lerpResult44_g61089;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g61082 = Output_2D_Auto131_g61089;
					#else
					float4 staticSwitch1088_g61082 = tex2D( _Lightmap1, UV0B2361_g61082 );
					#endif
					float4 Lightmap_1956_g61082 = staticSwitch1088_g61082;
					float Lightmap_Lerp_Value969_g61082 = _UdonLightmapLerp;
					float4 lerpResult442_g61082 = lerp( Lightmap_0925_g61082 , Lightmap_1956_g61082 , Lightmap_Lerp_Value969_g61082);
					float4 Lightmap_Lerp932_g61082 = lerpResult442_g61082;
					float3 appendResult139_g61128 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float2 temp_output_5_0_g61098 = UV0A2420_g61082;
					float2 UV633_g61098 = temp_output_5_0_g61098;
					float2 UV100_g61099 = UV633_g61098;
					float2 temp_output_51_0_g61099 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g61099 * float2( 3.464,3.464 ) ) );
					float2 break55_g61099 = frac( temp_output_51_0_g61099 );
					float temp_output_56_0_g61099 = ( ( 1.0 - break55_g61099.x ) - break55_g61099.y );
					float2 temp_output_52_0_g61099 = floor( temp_output_51_0_g61099 );
					float2 temp_output_125_0_g61099 = ( temp_output_52_0_g61099 + float2( 1,1 ) );
					float2 ifLocalVar87_g61099 = 0;
					if( temp_output_56_0_g61099 > 0.0 )
					ifLocalVar87_g61099 = temp_output_52_0_g61099;
					else if( temp_output_56_0_g61099 == 0.0 )
					ifLocalVar87_g61099 = temp_output_125_0_g61099;
					else if( temp_output_56_0_g61099 < 0.0 )
					ifLocalVar87_g61099 = temp_output_125_0_g61099;
					float3 temp_output_7_0_g61100 = frac( ( (ifLocalVar87_g61099).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61100 = dot( temp_output_7_0_g61100 , ( (temp_output_7_0_g61100).yzx + 33.33 ) );
					float3 temp_output_12_0_g61100 = ( temp_output_7_0_g61100 + dotResult8_g61100 );
					float2 temp_output_597_0_g61098 = ( UV100_g61099 + frac( ( ( (temp_output_12_0_g61100).xx + (temp_output_12_0_g61100).yz ) * (temp_output_12_0_g61100).zy ) ) );
					float2 DDX631_g61098 = ddx( temp_output_5_0_g61098 );
					float2 DDY632_g61098 = ddy( temp_output_5_0_g61098 );
					float Input_Scale617_g61098 = 1.5;
					float temp_output_65_0_g61099 = ( 0.0 - temp_output_56_0_g61099 );
					float ifLocalVar59_g61099 = 0;
					if( temp_output_56_0_g61099 <= 0.0 )
					ifLocalVar59_g61099 = temp_output_65_0_g61099;
					else
					ifLocalVar59_g61099 = temp_output_56_0_g61099;
					float temp_output_597_30_g61098 = ifLocalVar59_g61099;
					float2 temp_output_90_0_g61099 = ( temp_output_52_0_g61099 + float2( 0,1 ) );
					float2 temp_output_123_0_g61099 = ( temp_output_52_0_g61099 + float2( 1,0 ) );
					float2 ifLocalVar88_g61099 = 0;
					if( temp_output_56_0_g61099 > 0.0 )
					ifLocalVar88_g61099 = temp_output_90_0_g61099;
					else if( temp_output_56_0_g61099 == 0.0 )
					ifLocalVar88_g61099 = temp_output_123_0_g61099;
					else if( temp_output_56_0_g61099 < 0.0 )
					ifLocalVar88_g61099 = temp_output_123_0_g61099;
					float3 temp_output_7_0_g61101 = frac( ( (ifLocalVar88_g61099).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61101 = dot( temp_output_7_0_g61101 , ( (temp_output_7_0_g61101).yzx + 33.33 ) );
					float3 temp_output_12_0_g61101 = ( temp_output_7_0_g61101 + dotResult8_g61101 );
					float2 temp_output_597_26_g61098 = ( UV100_g61099 + frac( ( ( (temp_output_12_0_g61101).xx + (temp_output_12_0_g61101).yz ) * (temp_output_12_0_g61101).zy ) ) );
					float temp_output_66_0_g61099 = ( 1.0 - break55_g61099.y );
					float ifLocalVar60_g61099 = 0;
					if( temp_output_56_0_g61099 <= 0.0 )
					ifLocalVar60_g61099 = temp_output_66_0_g61099;
					else
					ifLocalVar60_g61099 = break55_g61099.y;
					float temp_output_597_28_g61098 = ifLocalVar60_g61099;
					float2 ifLocalVar89_g61099 = 0;
					if( temp_output_56_0_g61099 > 0.0 )
					ifLocalVar89_g61099 = temp_output_123_0_g61099;
					else if( temp_output_56_0_g61099 == 0.0 )
					ifLocalVar89_g61099 = temp_output_90_0_g61099;
					else if( temp_output_56_0_g61099 < 0.0 )
					ifLocalVar89_g61099 = temp_output_90_0_g61099;
					float3 temp_output_7_0_g61102 = frac( ( (ifLocalVar89_g61099).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61102 = dot( temp_output_7_0_g61102 , ( (temp_output_7_0_g61102).yzx + 33.33 ) );
					float3 temp_output_12_0_g61102 = ( temp_output_7_0_g61102 + dotResult8_g61102 );
					float2 temp_output_597_27_g61098 = ( UV100_g61099 + frac( ( ( (temp_output_12_0_g61102).xx + (temp_output_12_0_g61102).yz ) * (temp_output_12_0_g61102).zy ) ) );
					float temp_output_67_0_g61099 = ( 1.0 - break55_g61099.x );
					float ifLocalVar61_g61099 = 0;
					if( temp_output_56_0_g61099 <= 0.0 )
					ifLocalVar61_g61099 = temp_output_67_0_g61099;
					else
					ifLocalVar61_g61099 = break55_g61099.x;
					float temp_output_597_29_g61098 = ifLocalVar61_g61099;
					float3 Output_2D_Normal641_g61098 = ( ( UnpackScaleNormal( tex2D( _Sampler82965_g61082, temp_output_597_0_g61098, DDX631_g61098, DDY632_g61098 ), Input_Scale617_g61098 ) * temp_output_597_30_g61098 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g61082, temp_output_597_26_g61098, DDX631_g61098, DDY632_g61098 ), Input_Scale617_g61098 ) * temp_output_597_28_g61098 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g61082, temp_output_597_27_g61098, DDX631_g61098, DDY632_g61098 ), Input_Scale617_g61098 ) * float3( 0,0,0 ) * temp_output_597_29_g61098 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g61082 = Output_2D_Normal641_g61098;
					#else
					float3 staticSwitch1003_g61082 = UnpackScaleNormal( tex2D( _BumpMap, UV0A2420_g61082 ), 1.5 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g61082 = staticSwitch1003_g61082;
					#else
					float3 staticSwitch980_g61082 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g61082 = staticSwitch980_g61082;
					float3 normalizeResult326_g61128 = normalize( Normal_Map700_g61082 );
					float3 Normal_Map318_g61128 = normalizeResult326_g61128;
					float dotResult121_g61128 = dot( appendResult139_g61128 , Normal_Map318_g61128 );
					float temp_output_2_0_g61130 = saturate( dotResult121_g61128 );
					float localStochasticTiling2_g61124 = ( 0.0 );
					float2 UV2_g61124 = UV0B2361_g61082;
					float4 TexelSize2_g61124 = _UdonRNMX0_TexelSize;
					float4 Offsets2_g61124 = float4( 0,0,0,0 );
					float2 Weights2_g61124 = float2( 0,0 );
					{
					UV2_g61124 = UV2_g61124 * TexelSize2_g61124.zw - 0.5;
					float2 f = frac( UV2_g61124 );
					UV2_g61124 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g61124.x - 0.5, UV2_g61124.x + 1.5, UV2_g61124.y - 0.5, UV2_g61124.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g61124 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g61124.xyxy;
					Weights2_g61124 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g61123 = Offsets2_g61124;
					float4 Input_FetchOffsets197_g61125 = temp_output_1_34_g61123;
					float2 temp_output_1_54_g61123 = Weights2_g61124;
					float2 Input_FetchWeights200_g61125 = temp_output_1_54_g61123;
					float2 break187_g61125 = Input_FetchWeights200_g61125;
					float4 lerpResult181_g61125 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g61125).yw ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g61125).xw ) , break187_g61125.x);
					float4 lerpResult182_g61125 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g61125).yz ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g61125).xz ) , break187_g61125.x);
					float4 lerpResult176_g61125 = lerp( lerpResult181_g61125 , lerpResult182_g61125 , break187_g61125.y);
					float4 Output_Fetch2D_Auto202_g61125 = lerpResult176_g61125;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g61082 = Output_Fetch2D_Auto202_g61125;
					#else
					float4 staticSwitch1061_g61082 = tex2D( _UdonRNMX0, UV0B2361_g61082 );
					#endif
					float3 appendResult146_g61128 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g61128 = dot( appendResult146_g61128 , Normal_Map318_g61128 );
					float temp_output_2_0_g61129 = saturate( dotResult122_g61128 );
					float4 Input_FetchOffsets197_g61126 = temp_output_1_34_g61123;
					float2 Input_FetchWeights200_g61126 = temp_output_1_54_g61123;
					float2 break187_g61126 = Input_FetchWeights200_g61126;
					float4 lerpResult181_g61126 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g61126).yw ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g61126).xw ) , break187_g61126.x);
					float4 lerpResult182_g61126 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g61126).yz ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g61126).xz ) , break187_g61126.x);
					float4 lerpResult176_g61126 = lerp( lerpResult181_g61126 , lerpResult182_g61126 , break187_g61126.y);
					float4 Output_Fetch2D_Auto202_g61126 = lerpResult176_g61126;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g61082 = Output_Fetch2D_Auto202_g61126;
					#else
					float4 staticSwitch1062_g61082 = tex2D( _UdonRNMY0, UV0B2361_g61082 );
					#endif
					float3 appendResult149_g61128 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g61128 = dot( appendResult149_g61128 , Normal_Map318_g61128 );
					float temp_output_2_0_g61131 = saturate( dotResult120_g61128 );
					float4 Input_FetchOffsets197_g61127 = temp_output_1_34_g61123;
					float2 Input_FetchWeights200_g61127 = temp_output_1_54_g61123;
					float2 break187_g61127 = Input_FetchWeights200_g61127;
					float4 lerpResult181_g61127 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g61127).yw ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g61127).xw ) , break187_g61127.x);
					float4 lerpResult182_g61127 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g61127).yz ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g61127).xz ) , break187_g61127.x);
					float4 lerpResult176_g61127 = lerp( lerpResult181_g61127 , lerpResult182_g61127 , break187_g61127.y);
					float4 Output_Fetch2D_Auto202_g61127 = lerpResult176_g61127;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g61082 = Output_Fetch2D_Auto202_g61127;
					#else
					float4 staticSwitch1063_g61082 = tex2D( _UdonRNMZ0, UV0B2361_g61082 );
					#endif
					float4 RNM_0926_g61082 = ( ( ( ( ( temp_output_2_0_g61130 * temp_output_2_0_g61130 ) * staticSwitch1061_g61082 ) + ( ( temp_output_2_0_g61129 * temp_output_2_0_g61129 ) * staticSwitch1062_g61082 ) ) + ( ( temp_output_2_0_g61131 * temp_output_2_0_g61131 ) * staticSwitch1063_g61082 ) ) * 1.5 );
					float3 appendResult139_g61094 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g61094 = normalize( Normal_Map700_g61082 );
					float3 Normal_Map318_g61094 = normalizeResult326_g61094;
					float dotResult121_g61094 = dot( appendResult139_g61094 , Normal_Map318_g61094 );
					float temp_output_2_0_g61096 = saturate( dotResult121_g61094 );
					float localStochasticTiling2_g61084 = ( 0.0 );
					float2 UV2_g61084 = UV0B2361_g61082;
					float4 TexelSize2_g61084 = _UdonRNMX1_TexelSize;
					float4 Offsets2_g61084 = float4( 0,0,0,0 );
					float2 Weights2_g61084 = float2( 0,0 );
					{
					UV2_g61084 = UV2_g61084 * TexelSize2_g61084.zw - 0.5;
					float2 f = frac( UV2_g61084 );
					UV2_g61084 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g61084.x - 0.5, UV2_g61084.x + 1.5, UV2_g61084.y - 0.5, UV2_g61084.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g61084 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g61084.xyxy;
					Weights2_g61084 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g61083 = Offsets2_g61084;
					float4 Input_FetchOffsets197_g61085 = temp_output_1_34_g61083;
					float2 temp_output_1_54_g61083 = Weights2_g61084;
					float2 Input_FetchWeights200_g61085 = temp_output_1_54_g61083;
					float2 break187_g61085 = Input_FetchWeights200_g61085;
					float4 lerpResult181_g61085 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g61085).yw ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g61085).xw ) , break187_g61085.x);
					float4 lerpResult182_g61085 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g61085).yz ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g61085).xz ) , break187_g61085.x);
					float4 lerpResult176_g61085 = lerp( lerpResult181_g61085 , lerpResult182_g61085 , break187_g61085.y);
					float4 Output_Fetch2D_Auto202_g61085 = lerpResult176_g61085;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g61082 = Output_Fetch2D_Auto202_g61085;
					#else
					float4 staticSwitch1087_g61082 = tex2D( _UdonRNMX1, UV0B2361_g61082 );
					#endif
					float3 appendResult146_g61094 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g61094 = dot( appendResult146_g61094 , Normal_Map318_g61094 );
					float temp_output_2_0_g61095 = saturate( dotResult122_g61094 );
					float4 Input_FetchOffsets197_g61086 = temp_output_1_34_g61083;
					float2 Input_FetchWeights200_g61086 = temp_output_1_54_g61083;
					float2 break187_g61086 = Input_FetchWeights200_g61086;
					float4 lerpResult181_g61086 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g61086).yw ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g61086).xw ) , break187_g61086.x);
					float4 lerpResult182_g61086 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g61086).yz ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g61086).xz ) , break187_g61086.x);
					float4 lerpResult176_g61086 = lerp( lerpResult181_g61086 , lerpResult182_g61086 , break187_g61086.y);
					float4 Output_Fetch2D_Auto202_g61086 = lerpResult176_g61086;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g61082 = Output_Fetch2D_Auto202_g61086;
					#else
					float4 staticSwitch1083_g61082 = tex2D( _UdonRNMY1, UV0B2361_g61082 );
					#endif
					float3 appendResult149_g61094 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g61094 = dot( appendResult149_g61094 , Normal_Map318_g61094 );
					float temp_output_2_0_g61097 = saturate( dotResult120_g61094 );
					float4 Input_FetchOffsets197_g61087 = temp_output_1_34_g61083;
					float2 Input_FetchWeights200_g61087 = temp_output_1_54_g61083;
					float2 break187_g61087 = Input_FetchWeights200_g61087;
					float4 lerpResult181_g61087 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g61087).yw ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g61087).xw ) , break187_g61087.x);
					float4 lerpResult182_g61087 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g61087).yz ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g61087).xz ) , break187_g61087.x);
					float4 lerpResult176_g61087 = lerp( lerpResult181_g61087 , lerpResult182_g61087 , break187_g61087.y);
					float4 Output_Fetch2D_Auto202_g61087 = lerpResult176_g61087;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g61082 = Output_Fetch2D_Auto202_g61087;
					#else
					float4 staticSwitch1084_g61082 = tex2D( _UdonRNMZ1, UV0B2361_g61082 );
					#endif
					float4 RNM_11081_g61082 = ( ( ( ( ( temp_output_2_0_g61096 * temp_output_2_0_g61096 ) * staticSwitch1087_g61082 ) + ( ( temp_output_2_0_g61095 * temp_output_2_0_g61095 ) * staticSwitch1083_g61082 ) ) + ( ( temp_output_2_0_g61097 * temp_output_2_0_g61097 ) * staticSwitch1084_g61082 ) ) * 1.5 );
					float4 lerpResult953_g61082 = lerp( RNM_0926_g61082 , RNM_11081_g61082 , Lightmap_Lerp_Value969_g61082);
					float4 RNM_Lerp950_g61082 = lerpResult953_g61082;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g61082 = temp_cast_1;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g61082 = Lightmap_0925_g61082;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g61082 = Lightmap_Lerp932_g61082;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g61082 = RNM_0926_g61082;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g61082 = RNM_Lerp950_g61082;
					#else
					float4 staticSwitch1014_g61082 = temp_cast_1;
					#endif
					float3 Lightmap46_g61082 = (staticSwitch1014_g61082).rgb;
					#if defined( _EMISSIONUV_UV0 )
					float2 staticSwitch2642_g61082 = UV0A2420_g61082;
					#elif defined( _EMISSIONUV_UV2 )
					float2 staticSwitch2642_g61082 = UV22595_g61082;
					#else
					float2 staticSwitch2642_g61082 = UV0A2420_g61082;
					#endif
					float2 temp_output_5_0_g61118 = staticSwitch2642_g61082;
					float2 UV633_g61118 = temp_output_5_0_g61118;
					float2 UV100_g61119 = UV633_g61118;
					float2 temp_output_51_0_g61119 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g61119 * float2( 3.464,3.464 ) ) );
					float2 break55_g61119 = frac( temp_output_51_0_g61119 );
					float temp_output_56_0_g61119 = ( ( 1.0 - break55_g61119.x ) - break55_g61119.y );
					float2 temp_output_52_0_g61119 = floor( temp_output_51_0_g61119 );
					float2 temp_output_125_0_g61119 = ( temp_output_52_0_g61119 + float2( 1,1 ) );
					float2 ifLocalVar87_g61119 = 0;
					if( temp_output_56_0_g61119 > 0.0 )
					ifLocalVar87_g61119 = temp_output_52_0_g61119;
					else if( temp_output_56_0_g61119 == 0.0 )
					ifLocalVar87_g61119 = temp_output_125_0_g61119;
					else if( temp_output_56_0_g61119 < 0.0 )
					ifLocalVar87_g61119 = temp_output_125_0_g61119;
					float3 temp_output_7_0_g61120 = frac( ( (ifLocalVar87_g61119).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61120 = dot( temp_output_7_0_g61120 , ( (temp_output_7_0_g61120).yzx + 33.33 ) );
					float3 temp_output_12_0_g61120 = ( temp_output_7_0_g61120 + dotResult8_g61120 );
					float2 temp_output_597_0_g61118 = ( UV100_g61119 + frac( ( ( (temp_output_12_0_g61120).xx + (temp_output_12_0_g61120).yz ) * (temp_output_12_0_g61120).zy ) ) );
					float2 DDX631_g61118 = ddx( temp_output_5_0_g61118 );
					float2 DDY632_g61118 = ddy( temp_output_5_0_g61118 );
					float temp_output_65_0_g61119 = ( 0.0 - temp_output_56_0_g61119 );
					float ifLocalVar59_g61119 = 0;
					if( temp_output_56_0_g61119 <= 0.0 )
					ifLocalVar59_g61119 = temp_output_65_0_g61119;
					else
					ifLocalVar59_g61119 = temp_output_56_0_g61119;
					float temp_output_597_30_g61118 = ifLocalVar59_g61119;
					float2 temp_output_90_0_g61119 = ( temp_output_52_0_g61119 + float2( 0,1 ) );
					float2 temp_output_123_0_g61119 = ( temp_output_52_0_g61119 + float2( 1,0 ) );
					float2 ifLocalVar88_g61119 = 0;
					if( temp_output_56_0_g61119 > 0.0 )
					ifLocalVar88_g61119 = temp_output_90_0_g61119;
					else if( temp_output_56_0_g61119 == 0.0 )
					ifLocalVar88_g61119 = temp_output_123_0_g61119;
					else if( temp_output_56_0_g61119 < 0.0 )
					ifLocalVar88_g61119 = temp_output_123_0_g61119;
					float3 temp_output_7_0_g61121 = frac( ( (ifLocalVar88_g61119).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61121 = dot( temp_output_7_0_g61121 , ( (temp_output_7_0_g61121).yzx + 33.33 ) );
					float3 temp_output_12_0_g61121 = ( temp_output_7_0_g61121 + dotResult8_g61121 );
					float2 temp_output_597_26_g61118 = ( UV100_g61119 + frac( ( ( (temp_output_12_0_g61121).xx + (temp_output_12_0_g61121).yz ) * (temp_output_12_0_g61121).zy ) ) );
					float temp_output_66_0_g61119 = ( 1.0 - break55_g61119.y );
					float ifLocalVar60_g61119 = 0;
					if( temp_output_56_0_g61119 <= 0.0 )
					ifLocalVar60_g61119 = temp_output_66_0_g61119;
					else
					ifLocalVar60_g61119 = break55_g61119.y;
					float temp_output_597_28_g61118 = ifLocalVar60_g61119;
					float2 ifLocalVar89_g61119 = 0;
					if( temp_output_56_0_g61119 > 0.0 )
					ifLocalVar89_g61119 = temp_output_123_0_g61119;
					else if( temp_output_56_0_g61119 == 0.0 )
					ifLocalVar89_g61119 = temp_output_90_0_g61119;
					else if( temp_output_56_0_g61119 < 0.0 )
					ifLocalVar89_g61119 = temp_output_90_0_g61119;
					float3 temp_output_7_0_g61122 = frac( ( (ifLocalVar89_g61119).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61122 = dot( temp_output_7_0_g61122 , ( (temp_output_7_0_g61122).yzx + 33.33 ) );
					float3 temp_output_12_0_g61122 = ( temp_output_7_0_g61122 + dotResult8_g61122 );
					float2 temp_output_597_27_g61118 = ( UV100_g61119 + frac( ( ( (temp_output_12_0_g61122).xx + (temp_output_12_0_g61122).yz ) * (temp_output_12_0_g61122).zy ) ) );
					float temp_output_67_0_g61119 = ( 1.0 - break55_g61119.x );
					float ifLocalVar61_g61119 = 0;
					if( temp_output_56_0_g61119 <= 0.0 )
					ifLocalVar61_g61119 = temp_output_67_0_g61119;
					else
					ifLocalVar61_g61119 = break55_g61119.x;
					float temp_output_597_29_g61118 = ifLocalVar61_g61119;
					float4 Output_2D293_g61118 = ( ( tex2D( _Sampler82968_g61082, temp_output_597_0_g61118, DDX631_g61118, DDY632_g61118 ) * temp_output_597_30_g61118 ) + ( tex2D( _Sampler82968_g61082, temp_output_597_26_g61118, DDX631_g61118, DDY632_g61118 ) * temp_output_597_28_g61118 ) + ( tex2D( _Sampler82968_g61082, temp_output_597_27_g61118, DDX631_g61118, DDY632_g61118 ) * temp_output_597_29_g61118 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g61082 = Output_2D293_g61118;
					#else
					float4 staticSwitch1006_g61082 = tex2D( _EmissionMap, staticSwitch2642_g61082 );
					#endif
					float3 temp_output_2531_0_g61082 = (( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g61082 * _EmissionIntensity )).rgb;
					float3 Emission86_g61082 = temp_output_2531_0_g61082;
					float3 Color1_g61133 = oAlbedo6_g61082;
					float Metallic1_g61133 = Metallic1239_g61082;
					#if defined( _UV_UV0 )
					float2 staticSwitch2644_g61082 = UV0A2420_g61082;
					#elif defined( _UV_UV2 )
					float2 staticSwitch2644_g61082 = UV22595_g61082;
					#else
					float2 staticSwitch2644_g61082 = UV22595_g61082;
					#endif
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g61082 = tex2D( _GlossinessMap, staticSwitch2644_g61082 ).r;
					#else
					float staticSwitch845_g61082 = _Glossiness;
					#endif
					float2 temp_output_5_0_g61113 = staticSwitch2644_g61082;
					float2 UV633_g61113 = temp_output_5_0_g61113;
					float2 UV100_g61114 = UV633_g61113;
					float2 temp_output_51_0_g61114 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g61114 * float2( 3.464,3.464 ) ) );
					float2 break55_g61114 = frac( temp_output_51_0_g61114 );
					float temp_output_56_0_g61114 = ( ( 1.0 - break55_g61114.x ) - break55_g61114.y );
					float2 temp_output_52_0_g61114 = floor( temp_output_51_0_g61114 );
					float2 temp_output_125_0_g61114 = ( temp_output_52_0_g61114 + float2( 1,1 ) );
					float2 ifLocalVar87_g61114 = 0;
					if( temp_output_56_0_g61114 > 0.0 )
					ifLocalVar87_g61114 = temp_output_52_0_g61114;
					else if( temp_output_56_0_g61114 == 0.0 )
					ifLocalVar87_g61114 = temp_output_125_0_g61114;
					else if( temp_output_56_0_g61114 < 0.0 )
					ifLocalVar87_g61114 = temp_output_125_0_g61114;
					float3 temp_output_7_0_g61115 = frac( ( (ifLocalVar87_g61114).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61115 = dot( temp_output_7_0_g61115 , ( (temp_output_7_0_g61115).yzx + 33.33 ) );
					float3 temp_output_12_0_g61115 = ( temp_output_7_0_g61115 + dotResult8_g61115 );
					float2 temp_output_597_0_g61113 = ( UV100_g61114 + frac( ( ( (temp_output_12_0_g61115).xx + (temp_output_12_0_g61115).yz ) * (temp_output_12_0_g61115).zy ) ) );
					float2 DDX631_g61113 = ddx( temp_output_5_0_g61113 );
					float2 DDY632_g61113 = ddy( temp_output_5_0_g61113 );
					float temp_output_65_0_g61114 = ( 0.0 - temp_output_56_0_g61114 );
					float ifLocalVar59_g61114 = 0;
					if( temp_output_56_0_g61114 <= 0.0 )
					ifLocalVar59_g61114 = temp_output_65_0_g61114;
					else
					ifLocalVar59_g61114 = temp_output_56_0_g61114;
					float temp_output_597_30_g61113 = ifLocalVar59_g61114;
					float2 temp_output_90_0_g61114 = ( temp_output_52_0_g61114 + float2( 0,1 ) );
					float2 temp_output_123_0_g61114 = ( temp_output_52_0_g61114 + float2( 1,0 ) );
					float2 ifLocalVar88_g61114 = 0;
					if( temp_output_56_0_g61114 > 0.0 )
					ifLocalVar88_g61114 = temp_output_90_0_g61114;
					else if( temp_output_56_0_g61114 == 0.0 )
					ifLocalVar88_g61114 = temp_output_123_0_g61114;
					else if( temp_output_56_0_g61114 < 0.0 )
					ifLocalVar88_g61114 = temp_output_123_0_g61114;
					float3 temp_output_7_0_g61116 = frac( ( (ifLocalVar88_g61114).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61116 = dot( temp_output_7_0_g61116 , ( (temp_output_7_0_g61116).yzx + 33.33 ) );
					float3 temp_output_12_0_g61116 = ( temp_output_7_0_g61116 + dotResult8_g61116 );
					float2 temp_output_597_26_g61113 = ( UV100_g61114 + frac( ( ( (temp_output_12_0_g61116).xx + (temp_output_12_0_g61116).yz ) * (temp_output_12_0_g61116).zy ) ) );
					float temp_output_66_0_g61114 = ( 1.0 - break55_g61114.y );
					float ifLocalVar60_g61114 = 0;
					if( temp_output_56_0_g61114 <= 0.0 )
					ifLocalVar60_g61114 = temp_output_66_0_g61114;
					else
					ifLocalVar60_g61114 = break55_g61114.y;
					float temp_output_597_28_g61113 = ifLocalVar60_g61114;
					float2 ifLocalVar89_g61114 = 0;
					if( temp_output_56_0_g61114 > 0.0 )
					ifLocalVar89_g61114 = temp_output_123_0_g61114;
					else if( temp_output_56_0_g61114 == 0.0 )
					ifLocalVar89_g61114 = temp_output_90_0_g61114;
					else if( temp_output_56_0_g61114 < 0.0 )
					ifLocalVar89_g61114 = temp_output_90_0_g61114;
					float3 temp_output_7_0_g61117 = frac( ( (ifLocalVar89_g61114).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61117 = dot( temp_output_7_0_g61117 , ( (temp_output_7_0_g61117).yzx + 33.33 ) );
					float3 temp_output_12_0_g61117 = ( temp_output_7_0_g61117 + dotResult8_g61117 );
					float2 temp_output_597_27_g61113 = ( UV100_g61114 + frac( ( ( (temp_output_12_0_g61117).xx + (temp_output_12_0_g61117).yz ) * (temp_output_12_0_g61117).zy ) ) );
					float temp_output_67_0_g61114 = ( 1.0 - break55_g61114.x );
					float ifLocalVar61_g61114 = 0;
					if( temp_output_56_0_g61114 <= 0.0 )
					ifLocalVar61_g61114 = temp_output_67_0_g61114;
					else
					ifLocalVar61_g61114 = break55_g61114.x;
					float temp_output_597_29_g61113 = ifLocalVar61_g61114;
					float4 Output_2D293_g61113 = ( ( tex2D( _Sampler82964_g61082, temp_output_597_0_g61113, DDX631_g61113, DDY632_g61113 ) * temp_output_597_30_g61113 ) + ( tex2D( _Sampler82964_g61082, temp_output_597_26_g61113, DDX631_g61113, DDY632_g61113 ) * temp_output_597_28_g61113 ) + ( tex2D( _Sampler82964_g61082, temp_output_597_27_g61113, DDX631_g61113, DDY632_g61113 ) * temp_output_597_29_g61113 ) );
					float4 break31_g61113 = Output_2D293_g61113;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g61082 = ( 1.0 - break31_g61113.r );
					#else
					float staticSwitch1004_g61082 = ( 1.0 - staticSwitch845_g61082 );
					#endif
					float temp_output_19_0_g61132 = staticSwitch1004_g61082;
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal2504_g61082 = Normal_Map700_g61082;
					float3 worldNormal2504_g61082 = normalize( float3( dot( tanToWorld0, tanNormal2504_g61082 ), dot( tanToWorld1, tanNormal2504_g61082 ), dot( tanToWorld2, tanNormal2504_g61082 ) ) );
					float3 World_Normal2508_g61082 = worldNormal2504_g61082;
					float3 tanNormal2_g61132 = World_Normal2508_g61082;
					float3 worldNormal2_g61132 = float3( dot( tanToWorld0, tanNormal2_g61132 ), dot( tanToWorld1, tanNormal2_g61132 ), dot( tanToWorld2, tanNormal2_g61132 ) );
					float3 temp_output_3_0_g61132 = ddx( worldNormal2_g61132 );
					float dotResult5_g61132 = dot( temp_output_3_0_g61132 , temp_output_3_0_g61132 );
					float3 temp_output_4_0_g61132 = ddy( worldNormal2_g61132 );
					float dotResult6_g61132 = dot( temp_output_4_0_g61132 , temp_output_4_0_g61132 );
					#ifdef _USEGEOMETRICAA_ON
					float staticSwitch15_g61132 = min( temp_output_19_0_g61132, ( 1.0 - pow( saturate( max( dotResult5_g61132, dotResult6_g61132 ) ) , 0.25 ) ) );
					#else
					float staticSwitch15_g61132 = temp_output_19_0_g61132;
					#endif
					float Smoothness1399_g61082 = staticSwitch15_g61132;
					float Smoothness1_g61133 = Smoothness1399_g61082;
					float IOR2700_g61082 = _IOR;
					float IOR1_g61133 = IOR2700_g61082;
					float3 temp_cast_4 = (0.04).xxx;
					float3 lerpResult1473_g61082 = lerp( temp_cast_4 , oAlbedo6_g61082 , Metallic1239_g61082);
					float3 switchResult1501_g61082 = (((ase_vface>0)?(World_Normal2508_g61082):(-World_Normal2508_g61082)));
					float3 View_Direction2511_g61082 = ViewDirWS;
					float dotResult1476_g61082 = dot( switchResult1501_g61082 , View_Direction2511_g61082 );
					float3 lerpResult1480_g61082 = lerp( lerpResult1473_g61082 , float3( 1,1,1 ) , pow( ( 1.0 - saturate( dotResult1476_g61082 ) ) , 5.0 ));
					float3 Fresnel1560_g61082 = lerpResult1480_g61082;
					float3 Fresnel1_g61133 = Fresnel1560_g61082;
					float3 World_Position2505_g61082 = PositionWS;
					float3 WorldPos1_g61133 = World_Position2505_g61082;
					float3 WorldNormal1_g61133 = World_Normal2508_g61082;
					float3 ViewDir1_g61133 = View_Direction2511_g61082;
					float3 localIndirectSpecular1_g61133 = IndirectSpecular1_g61133( Color1_g61133 , Metallic1_g61133 , Smoothness1_g61133 , IOR1_g61133 , Fresnel1_g61133 , WorldPos1_g61133 , WorldNormal1_g61133 , ViewDir1_g61133 );
					float3 temp_output_2805_0_g61082 = localIndirectSpecular1_g61133;
					float grayscale2713_g61082 = Luminance( Lightmap46_g61082 );
					float smoothstepResult2430_g61082 = smoothstep( 0.0 , 0.05 , grayscale2713_g61082);
					#ifdef _USELIGHTMAPPEDREFLECTIONS_ON
					float3 staticSwitch1469_g61082 = ( temp_output_2805_0_g61082 * smoothstepResult2430_g61082 );
					#else
					float3 staticSwitch1469_g61082 = temp_output_2805_0_g61082;
					#endif
					float3 Reflections1419_g61082 = staticSwitch1469_g61082;
					float3 Color97_g61134 = oAlbedo6_g61082;
					float3 LightmapColor97_g61134 = Lightmap46_g61082;
					float Metallic97_g61134 = Metallic1239_g61082;
					float Smoothness97_g61134 = Smoothness1399_g61082;
					float IOR97_g61134 = IOR2700_g61082;
					float3 Fresnel97_g61134 = Fresnel1560_g61082;
					float3 WorldPos97_g61134 = World_Position2505_g61082;
					float3 WorldNormal97_g61134 = World_Normal2508_g61082;
					float3 ViewDir97_g61134 = View_Direction2511_g61082;
					float3 localDirectSpecular97_g61134 = DirectSpecular( Color97_g61134 , LightmapColor97_g61134 , Metallic97_g61134 , Smoothness97_g61134 , IOR97_g61134 , Fresnel97_g61134 , WorldPos97_g61134 , WorldNormal97_g61134 , ViewDir97_g61134 );
					float3 Speculars2560_g61082 = localDirectSpecular97_g61134;
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch1181_g61082 = Lightmap46_g61082;
					#else
					float3 staticSwitch1181_g61082 = ( ( aAlbedo1466_g61082 * Lightmap46_g61082 ) + Emission86_g61082 + Reflections1419_g61082 + Speculars2560_g61082 );
					#endif
					float3 temp_output_35_0_g61092 = staticSwitch1181_g61082;
					float3 Color353_g61092 = temp_output_35_0_g61092;
					#if defined( _LUTMODE_2D )
					float3 staticSwitch273_g61092 = saturate( temp_output_35_0_g61092 );
					#elif defined( _LUTMODE_3D )
					float3 staticSwitch273_g61092 = temp_output_35_0_g61092;
					#else
					float3 staticSwitch273_g61092 = temp_output_35_0_g61092;
					#endif
					float3 Color_Saturate49_g61092 = staticSwitch273_g61092;
					float Lut_Height213_g61092 = _LUTSize;
					float Lut_Width216_g61092 = ( _LUTSize * Lut_Height213_g61092 );
					float3 appendResult214_g61092 = (float3(( 1.0 / Lut_Width216_g61092 ) , ( 1.0 / Lut_Height213_g61092 ) , ( Lut_Height213_g61092 - 1.0 )));
					float3 Scale_Offset208_g61092 = appendResult214_g61092;
					float2 Scale_Factor292_g61092 = ( (Scale_Offset208_g61092).xy * (Scale_Offset208_g61092).z );
					float2 Offset299_g61092 = ( (Scale_Offset208_g61092).xy * 0.5 );
					float2 Adjusted_UV305_g61092 = ( ( (Color_Saturate49_g61092).xy * Scale_Factor292_g61092 ) + Offset299_g61092 );
					float Scaled_Blue280_g61092 = ( (Color_Saturate49_g61092).z * (Scale_Offset208_g61092).z );
					float Shift288_g61092 = floor( Scaled_Blue280_g61092 );
					float Final_X313_g61092 = ( (Adjusted_UV305_g61092).x + ( Shift288_g61092 * (Scale_Offset208_g61092).y ) );
					float2 appendResult326_g61092 = (float2(Final_X313_g61092 , (Adjusted_UV305_g61092).y));
					float2 Final_UV325_g61092 = appendResult326_g61092;
					float2 appendResult338_g61092 = (float2((Scale_Offset208_g61092).y , 0.0));
					float2 Offset_UV336_g61092 = ( Final_UV325_g61092 + appendResult338_g61092 );
					float3 lerpResult333_g61092 = lerp( tex2D( _2DLut, Final_UV325_g61092 ).rgb , tex2D( _2DLut, Offset_UV336_g61092 ).rgb , ( Scaled_Blue280_g61092 - Shift288_g61092 ));
					#ifdef _2DLUT
					float3 staticSwitch347_g61092 = lerpResult333_g61092;
					#else
					float3 staticSwitch347_g61092 = Color_Saturate49_g61092;
					#endif
					float3 TwoD_LUT346_g61092 = staticSwitch347_g61092;
					float3 RGB16_g61093 = ( ( log10( ( ( Color_Saturate49_g61092 * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 );
					#ifdef _3DLUT
					float3 staticSwitch194_g61092 = tex3D( _3DLut, RGB16_g61093 ).rgb;
					#else
					float3 staticSwitch194_g61092 = Color_Saturate49_g61092;
					#endif
					float3 ThreeD_LUT51_g61092 = staticSwitch194_g61092;
					#if defined( _LUTMODE_2D )
					float3 staticSwitch42_g61092 = TwoD_LUT346_g61092;
					#elif defined( _LUTMODE_3D )
					float3 staticSwitch42_g61092 = ThreeD_LUT51_g61092;
					#else
					float3 staticSwitch42_g61092 = ThreeD_LUT51_g61092;
					#endif
					#ifdef SHADER_API_MOBILE
					float3 staticSwitch41_g61092 = staticSwitch42_g61092;
					#else
					float3 staticSwitch41_g61092 = Color353_g61092;
					#endif
					

					o.Albedo = staticSwitch1180_g61082;
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

					o.Emission = staticSwitch41_g61092;
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
				#define UNITY_STANDARD_USE_DITHER_MASK 1
				#define ASE_FRAGMENT_NORMAL 0
				#pragma multi_compile _ LOD_FADE_CROSSFADE
				#define ASE_FOG
				#define _SPECULARHIGHLIGHTS_OFF
				#pragma multi_compile_instancing
				#define ASE_NO_AMBIENT 1
				#define ASE_LIGHTING_SIMPLE 1
				#define _GLOSSYREFLECTIONS_OFF
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

					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 World_Position2505_g61082 = ase_positionWS;
					

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = ( v.normal * ( distance( World_Position2505_g61082 , _WorldSpaceCameraPos ) * 0.0005 ) );
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

	
	}
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
	
	Fallback Off
}
/*ASEBEGIN
Version=19907
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3042;192,-1200;Inherit;False;Meenphie;0;;61082;b3ba55a08dd6b49c7be16c6f35cf2033;6,1008,1,2632,1,2635,1,2636,1,2670,1,2619,1;0;5;FLOAT3;625;FLOAT3;624;FLOAT;156;FLOAT;427;FLOAT3;1024
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2889;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;True;1;LightMode=ForwardAdd;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2890;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2891;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2892;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2893;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2894;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ScenePickingPass;0;7;ScenePickingPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=ScenePickingPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2888;512,-1200;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;6;Meenphie/Standard/Decal/Additive;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardBase;0;1;ForwardBase;17;True;True;4;1;False;;1;False;;0;1;False;;1;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;2;False;;True;3;False;;False;False;True;3;RenderType=Transparent=RenderType;Queue=Transparent=Queue=1;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;4;1;False;;1;False;;0;1;False;;1;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;44;Category;0;0;  Instanced Terrain Normals;1;0;Workflow;3;639057697570214470;Surface;1;639109938126817630;  Blend;2;639101656407308560;  Dither Shadows;1;0;Two Sided;1;639101642247268830;Alpha Clipping;0;639109936712846350;  Use Shadow Threshold;0;638915420933436960;Deferred Pass;0;638915425282396370;Normal Space;0;0;Transmission;0;638915425258747670;  Transmission Shadow;0.5,False,;0;Translucency;0;638915425246861880;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;1;638922399804812020;Receive Shadows;0;638922399717523500;Receive Specular;0;638915388784334560;Receive Reflections;0;639109937163683620;GPU Instancing;1;638915411619689990;LOD CrossFade;1;0;Built-in Fog;1;0;Ambient Light;0;639049545902984550;Meta Pass;0;639048817054746750;Add Pass;0;639048817051401800;Override Baked GI;0;638915390973737640;Write Depth;0;638915421117196140;Extra Pre Pass;0;639048817123696260;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;0;Vertex Position;1;0;0;8;False;True;False;False;False;True;False;False;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2887;512,-1440;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;True;True;0;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;True;True;1;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;0;False;;True;3;False;;True;False;0;False;;0;False;;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;0;False;0
WireConnection;2888;0;3042;625
WireConnection;2888;2;3042;624
WireConnection;2888;15;3042;1024
ASEEND*/
//CHKSM=5386530747BA727BB09FE9BB3C6819377F1EEAB6