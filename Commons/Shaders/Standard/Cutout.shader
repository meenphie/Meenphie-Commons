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
		[HideInInspector] GenKey__2DLut( "Assign keyword _2DLUT", Float ) = 1.0
		[HideInInspector] GenKey__MainTex( "Assign keyword _MAINTEX", Float ) = 1.0
		[HideInInspector] GenKey__MetallicMap( "Assign keyword _METALLICMAP", Float ) = 1.0
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0
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
				sampler2D _Sampler82966_g60028;
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				sampler2D _Sampler82967_g60028;
				uniform sampler2D _Lightmap0;
				float4 _Lightmap0_TexelSize;
				uniform sampler2D _Lightmap1;
				float4 _Lightmap1_TexelSize;
				uniform float _UdonLightmapLerp;
				uniform sampler2D _BumpMap;
				sampler2D _Sampler82965_g60028;
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
				sampler2D _Sampler82968_g60028;
				uniform float _EmissionIntensity;
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				sampler2D _Sampler82964_g60028;
				uniform float _IOR;
				uniform float _MaskClipValue;


				float3 IndirectSpecular1_g60080( float Color, float Metallic, float Smoothness, float IOR, float3 Fresnel, float3 WorldPos, float3 WorldNormal, float3 ViewDir )
				{
					// --- 1. VECTORS & NORMALS ---
					float3 N = normalize(WorldNormal); 
					float3 V = normalize(ViewDir);
					float3 R = reflect(-V, N);
					float nDotV = saturate(dot(N, V));
					// --- 2. REFLECTION RAY & BOX PROJECTION ---
					float3 ray = R;
					[branch]
					if (unity_SpecCube0_ProbePosition.w > 0.0) {
					    float3 boxBounds = (ray > 0) ? unity_SpecCube0_BoxMax.xyz : unity_SpecCube0_BoxMin.xyz;
					    float3 factors = (boxBounds - WorldPos) / (ray + 1e-5);
					    float scalar = min(min(factors.x, factors.y), factors.z);
					    ray = ray * scalar + (WorldPos - unity_SpecCube0_ProbePosition.xyz);
					}
					// --- 3. PBR F0 & FRESNEL ---
					float perceptualRoughness = 1.0 - Smoothness;
					float f0_base = pow((IOR - 1.0) / (IOR + 1.0), 2.0);
					float3 F0 = lerp(float3(f0_base, f0_base, f0_base), Color, Metallic);
					// Fresnel standard avec compensation de rugosité
					float3 fresnelFactor = F0 + (max(float3(Smoothness, Smoothness, Smoothness), F0) - F0) * pow(1.0 - nDotV, 5.0);
					// --- 4. SAMPLING AVEC "FRESNEL SMOOTHING" ---
					// On réduit la rugosité perçue sur les bords (quand nDotV est faible)
					// Cela rend la réflexion plus nette à l'horizon/sur les bords des objets.
					float roughnessFresnel = perceptualRoughness * nDotV; 
					// On mélange un peu pour ne pas que ce soit trop violent (ajustable)
					float finalPerceptual = lerp(roughnessFresnel, perceptualRoughness, nDotV);
					// Remappage standard pour les Mips
					float mipMapping = finalPerceptual * (1.7 - 0.7 * finalPerceptual);
					float mipLevel = mipMapping * 7.0; // 7.0 est souvent plus précis pour éviter le dernier mip pixelisé
					float4 sampleCube = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, ray, mipLevel);
					float3 indirectSpec = DecodeHDR(sampleCube, unity_SpecCube0_HDR);
					return indirectSpec * fresnelFactor;
				}
				
				float3 DirectSpecular( float3 Color, float3 LightmapColor, float Metallic, float Smoothness, float IOR, float3 Fresnel, float3 WorldPos, float3 WorldNormal, float3 ViewDir )
				{
					// --- CONFIGURATION ---
					float LumaStart = 0.05;
					float LumaEnd = 1.0;
					float RadiusFadeStart = 7.0;
					float specBoost = 2.0;
					#if defined(SHADER_API_MOBILE)
					    #define MAX_RADIUS 10.0
					#else
					    #define MAX_RADIUS 20.0
					#endif
					// --- INITIALISATION ---
					float3 N = normalize(WorldNormal);
					float3 vDir = normalize(ViewDir);
					float3 R = reflect(-vDir, N);
					// Calcul de F0 (Réflectance de base)
					float3 f0_dielectric = float3(0.04, 0.04, 0.04);
					float3 F0 = lerp(f0_dielectric, Color.rgb, Metallic);
					// --- MASQUES ET DISTANCE ---
					float luma = dot(LightmapColor, float3(0.22, 0.70, 0.08));
					float lmMask = saturate((luma - LumaStart) / max(LumaEnd - LumaStart, 0.0001));
					float playerDist = distance(_WorldSpaceCameraPos, WorldPos);
					float fadeT = saturate((playerDist - RadiusFadeStart) / max(MAX_RADIUS - RadiusFadeStart, 0.0001));
					float radiusFade = 1.0 - (fadeT * fadeT * (3.0 - 2.0 * fadeT));
					// Sortie précoce (Vital pour le Quest)
					if (lmMask * Smoothness * radiusFade < 0.001 || _UdonSpecularLightCount == 0) return 0;
					// --- MATHS SPÉCULAIRES (Optimisées) ---
					float shininess = exp2(10.0 * Smoothness + 1.0); 
					float normalization = (shininess * 0.125 + 1.0) * 0.3183; // (s+8)/(8*pi)
					float3 specAccum = 0;
					// --- BOUCLE DE LUMIÈRES ---
					for (int i = 0; i < (int)_UdonSpecularLightCount; i++) {
					    float4 posRange = _UdonSpecularLightPos[i];
					    float3 L_center = posRange.xyz - WorldPos;
					    float distSqCenter = dot(L_center, L_center);
					    float rangeSq = posRange.w * posRange.w;
					    if (distSqCenter > rangeSq) continue;
					    float4 dirAngle = _UdonSpecularLightDir[i];
					    float3 L_center_norm = L_center * rsqrt(distSqCenter + 1e-5);
					    
					    // Spot Mask
					    float spotMask = saturate((dot(-L_center_norm, dirAngle.xyz) - dirAngle.w) / max(0.01, 1.0 - dirAngle.w));
					    if (spotMask <= 0.0) continue;
					    // Area Light Math (Intersection)
					    float denom = dot(dirAngle.xyz, R);
					    float tPlane = (dirAngle.w < -0.9) ? dot(L_center, R) : (dot(L_center, dirAngle.xyz) / (abs(denom) < 0.001 ? 0.001 : denom));
					    
					    float3 localP = (WorldPos + R * max(0.0, tPlane)) - posRange.xyz;
					    float2 halfSize = float2(_UdonSpecularLightRight[i].w, _UdonSpecularLightUp[i].w);
					    
					    float2 clampedPos = clamp(float2(dot(localP, _UdonSpecularLightRight[i].xyz), dot(localP, _UdonSpecularLightUp[i].xyz)), -halfSize, halfSize);
					    float3 closestPoint = posRange.xyz + _UdonSpecularLightRight[i].xyz * clampedPos.x + _UdonSpecularLightUp[i].xyz * clampedPos.y;
					    float3 diff = closestPoint - WorldPos;
					    float distSq = dot(diff, diff);
					    float3 lDir = normalize(diff);
					    float3 H = normalize(lDir + vDir);
					    // Fresnel Schlick optimisé (Pas de pow)
					    float f_inv = 1.0 - saturate(dot(H, vDir));
					    float f5 = f_inv * f_inv; f5 *= f5 * f_inv; 
					    float3 fresnel = F0 + (1.0 - F0) * f5;
					    // Terme Spéculaire
					    float nDotH = saturate(dot(N, H));
					    float spec = pow(nDotH, shininess) * normalization;
					    // Atténuation
					    float falloff = saturate(1.0 - distSqCenter/rangeSq);
					    falloff = (falloff * falloff) / (distSq + 1.0);
					    specAccum += _UdonSpecularLightCol[i].rgb * (spec * fresnel * saturate(dot(N, lDir)) * _UdonSpecularLightCol[i].w * falloff * spotMask);
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

					float2 texCoord2357_g60028 = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0A2420_g60028 = texCoord2357_g60028;
					#ifdef _MAINTEX
					float4 staticSwitch1549_g60028 = tex2D( _MainTex, UV0A2420_g60028 );
					#else
					float4 staticSwitch1549_g60028 = _Color;
					#endif
					float2 temp_output_5_0_g60054 = UV0A2420_g60028;
					float2 UV633_g60054 = temp_output_5_0_g60054;
					float2 UV100_g60055 = UV633_g60054;
					float2 temp_output_51_0_g60055 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60055 * float2( 3.464,3.464 ) ) );
					float2 break55_g60055 = frac( temp_output_51_0_g60055 );
					float temp_output_56_0_g60055 = ( ( 1.0 - break55_g60055.x ) - break55_g60055.y );
					float2 temp_output_52_0_g60055 = floor( temp_output_51_0_g60055 );
					float2 temp_output_125_0_g60055 = ( temp_output_52_0_g60055 + float2( 1,1 ) );
					float2 ifLocalVar87_g60055 = 0;
					if( temp_output_56_0_g60055 > 0.0 )
					ifLocalVar87_g60055 = temp_output_52_0_g60055;
					else if( temp_output_56_0_g60055 == 0.0 )
					ifLocalVar87_g60055 = temp_output_125_0_g60055;
					else if( temp_output_56_0_g60055 < 0.0 )
					ifLocalVar87_g60055 = temp_output_125_0_g60055;
					float3 temp_output_7_0_g60056 = frac( ( (ifLocalVar87_g60055).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60056 = dot( temp_output_7_0_g60056 , ( (temp_output_7_0_g60056).yzx + 33.33 ) );
					float3 temp_output_12_0_g60056 = ( temp_output_7_0_g60056 + dotResult8_g60056 );
					float2 temp_output_597_0_g60054 = ( UV100_g60055 + frac( ( ( (temp_output_12_0_g60056).xx + (temp_output_12_0_g60056).yz ) * (temp_output_12_0_g60056).zy ) ) );
					float2 DDX631_g60054 = ddx( temp_output_5_0_g60054 );
					float2 DDY632_g60054 = ddy( temp_output_5_0_g60054 );
					float temp_output_65_0_g60055 = ( 0.0 - temp_output_56_0_g60055 );
					float ifLocalVar59_g60055 = 0;
					if( temp_output_56_0_g60055 <= 0.0 )
					ifLocalVar59_g60055 = temp_output_65_0_g60055;
					else
					ifLocalVar59_g60055 = temp_output_56_0_g60055;
					float temp_output_597_30_g60054 = ifLocalVar59_g60055;
					float2 temp_output_90_0_g60055 = ( temp_output_52_0_g60055 + float2( 0,1 ) );
					float2 temp_output_123_0_g60055 = ( temp_output_52_0_g60055 + float2( 1,0 ) );
					float2 ifLocalVar88_g60055 = 0;
					if( temp_output_56_0_g60055 > 0.0 )
					ifLocalVar88_g60055 = temp_output_90_0_g60055;
					else if( temp_output_56_0_g60055 == 0.0 )
					ifLocalVar88_g60055 = temp_output_123_0_g60055;
					else if( temp_output_56_0_g60055 < 0.0 )
					ifLocalVar88_g60055 = temp_output_123_0_g60055;
					float3 temp_output_7_0_g60057 = frac( ( (ifLocalVar88_g60055).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60057 = dot( temp_output_7_0_g60057 , ( (temp_output_7_0_g60057).yzx + 33.33 ) );
					float3 temp_output_12_0_g60057 = ( temp_output_7_0_g60057 + dotResult8_g60057 );
					float2 temp_output_597_26_g60054 = ( UV100_g60055 + frac( ( ( (temp_output_12_0_g60057).xx + (temp_output_12_0_g60057).yz ) * (temp_output_12_0_g60057).zy ) ) );
					float temp_output_66_0_g60055 = ( 1.0 - break55_g60055.y );
					float ifLocalVar60_g60055 = 0;
					if( temp_output_56_0_g60055 <= 0.0 )
					ifLocalVar60_g60055 = temp_output_66_0_g60055;
					else
					ifLocalVar60_g60055 = break55_g60055.y;
					float temp_output_597_28_g60054 = ifLocalVar60_g60055;
					float2 ifLocalVar89_g60055 = 0;
					if( temp_output_56_0_g60055 > 0.0 )
					ifLocalVar89_g60055 = temp_output_123_0_g60055;
					else if( temp_output_56_0_g60055 == 0.0 )
					ifLocalVar89_g60055 = temp_output_90_0_g60055;
					else if( temp_output_56_0_g60055 < 0.0 )
					ifLocalVar89_g60055 = temp_output_90_0_g60055;
					float3 temp_output_7_0_g60058 = frac( ( (ifLocalVar89_g60055).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60058 = dot( temp_output_7_0_g60058 , ( (temp_output_7_0_g60058).yzx + 33.33 ) );
					float3 temp_output_12_0_g60058 = ( temp_output_7_0_g60058 + dotResult8_g60058 );
					float2 temp_output_597_27_g60054 = ( UV100_g60055 + frac( ( ( (temp_output_12_0_g60058).xx + (temp_output_12_0_g60058).yz ) * (temp_output_12_0_g60058).zy ) ) );
					float temp_output_67_0_g60055 = ( 1.0 - break55_g60055.x );
					float ifLocalVar61_g60055 = 0;
					if( temp_output_56_0_g60055 <= 0.0 )
					ifLocalVar61_g60055 = temp_output_67_0_g60055;
					else
					ifLocalVar61_g60055 = break55_g60055.x;
					float temp_output_597_29_g60054 = ifLocalVar61_g60055;
					float4 Output_2D293_g60054 = ( ( tex2D( _Sampler82966_g60028, temp_output_597_0_g60054, DDX631_g60054, DDY632_g60054 ) * temp_output_597_30_g60054 ) + ( tex2D( _Sampler82966_g60028, temp_output_597_26_g60054, DDX631_g60054, DDY632_g60054 ) * temp_output_597_28_g60054 ) + ( tex2D( _Sampler82966_g60028, temp_output_597_27_g60054, DDX631_g60054, DDY632_g60054 ) * temp_output_597_29_g60054 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g60028 = Output_2D293_g60054;
					#else
					float4 staticSwitch1001_g60028 = staticSwitch1549_g60028;
					#endif
					float3 temp_output_2532_0_g60028 = (staticSwitch1001_g60028).rgb;
					float3 oAlbedo6_g60028 = temp_output_2532_0_g60028;
					float Black1185_g60028 = 0.0;
					float3 temp_cast_0 = (Black1185_g60028).xxx;
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch1180_g60028 = temp_cast_0;
					#else
					float3 staticSwitch1180_g60028 = oAlbedo6_g60028;
					#endif
					
					#ifdef _METALLICMAP
					float staticSwitch846_g60028 = tex2D( _MetallicMap, UV0A2420_g60028 ).r;
					#else
					float staticSwitch846_g60028 = _Metallic;
					#endif
					float2 temp_output_5_0_g60049 = UV0A2420_g60028;
					float2 UV633_g60049 = temp_output_5_0_g60049;
					float2 UV100_g60050 = UV633_g60049;
					float2 temp_output_51_0_g60050 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60050 * float2( 3.464,3.464 ) ) );
					float2 break55_g60050 = frac( temp_output_51_0_g60050 );
					float temp_output_56_0_g60050 = ( ( 1.0 - break55_g60050.x ) - break55_g60050.y );
					float2 temp_output_52_0_g60050 = floor( temp_output_51_0_g60050 );
					float2 temp_output_125_0_g60050 = ( temp_output_52_0_g60050 + float2( 1,1 ) );
					float2 ifLocalVar87_g60050 = 0;
					if( temp_output_56_0_g60050 > 0.0 )
					ifLocalVar87_g60050 = temp_output_52_0_g60050;
					else if( temp_output_56_0_g60050 == 0.0 )
					ifLocalVar87_g60050 = temp_output_125_0_g60050;
					else if( temp_output_56_0_g60050 < 0.0 )
					ifLocalVar87_g60050 = temp_output_125_0_g60050;
					float3 temp_output_7_0_g60051 = frac( ( (ifLocalVar87_g60050).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60051 = dot( temp_output_7_0_g60051 , ( (temp_output_7_0_g60051).yzx + 33.33 ) );
					float3 temp_output_12_0_g60051 = ( temp_output_7_0_g60051 + dotResult8_g60051 );
					float2 temp_output_597_0_g60049 = ( UV100_g60050 + frac( ( ( (temp_output_12_0_g60051).xx + (temp_output_12_0_g60051).yz ) * (temp_output_12_0_g60051).zy ) ) );
					float2 DDX631_g60049 = ddx( temp_output_5_0_g60049 );
					float2 DDY632_g60049 = ddy( temp_output_5_0_g60049 );
					float temp_output_65_0_g60050 = ( 0.0 - temp_output_56_0_g60050 );
					float ifLocalVar59_g60050 = 0;
					if( temp_output_56_0_g60050 <= 0.0 )
					ifLocalVar59_g60050 = temp_output_65_0_g60050;
					else
					ifLocalVar59_g60050 = temp_output_56_0_g60050;
					float temp_output_597_30_g60049 = ifLocalVar59_g60050;
					float2 temp_output_90_0_g60050 = ( temp_output_52_0_g60050 + float2( 0,1 ) );
					float2 temp_output_123_0_g60050 = ( temp_output_52_0_g60050 + float2( 1,0 ) );
					float2 ifLocalVar88_g60050 = 0;
					if( temp_output_56_0_g60050 > 0.0 )
					ifLocalVar88_g60050 = temp_output_90_0_g60050;
					else if( temp_output_56_0_g60050 == 0.0 )
					ifLocalVar88_g60050 = temp_output_123_0_g60050;
					else if( temp_output_56_0_g60050 < 0.0 )
					ifLocalVar88_g60050 = temp_output_123_0_g60050;
					float3 temp_output_7_0_g60052 = frac( ( (ifLocalVar88_g60050).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60052 = dot( temp_output_7_0_g60052 , ( (temp_output_7_0_g60052).yzx + 33.33 ) );
					float3 temp_output_12_0_g60052 = ( temp_output_7_0_g60052 + dotResult8_g60052 );
					float2 temp_output_597_26_g60049 = ( UV100_g60050 + frac( ( ( (temp_output_12_0_g60052).xx + (temp_output_12_0_g60052).yz ) * (temp_output_12_0_g60052).zy ) ) );
					float temp_output_66_0_g60050 = ( 1.0 - break55_g60050.y );
					float ifLocalVar60_g60050 = 0;
					if( temp_output_56_0_g60050 <= 0.0 )
					ifLocalVar60_g60050 = temp_output_66_0_g60050;
					else
					ifLocalVar60_g60050 = break55_g60050.y;
					float temp_output_597_28_g60049 = ifLocalVar60_g60050;
					float2 ifLocalVar89_g60050 = 0;
					if( temp_output_56_0_g60050 > 0.0 )
					ifLocalVar89_g60050 = temp_output_123_0_g60050;
					else if( temp_output_56_0_g60050 == 0.0 )
					ifLocalVar89_g60050 = temp_output_90_0_g60050;
					else if( temp_output_56_0_g60050 < 0.0 )
					ifLocalVar89_g60050 = temp_output_90_0_g60050;
					float3 temp_output_7_0_g60053 = frac( ( (ifLocalVar89_g60050).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60053 = dot( temp_output_7_0_g60053 , ( (temp_output_7_0_g60053).yzx + 33.33 ) );
					float3 temp_output_12_0_g60053 = ( temp_output_7_0_g60053 + dotResult8_g60053 );
					float2 temp_output_597_27_g60049 = ( UV100_g60050 + frac( ( ( (temp_output_12_0_g60053).xx + (temp_output_12_0_g60053).yz ) * (temp_output_12_0_g60053).zy ) ) );
					float temp_output_67_0_g60050 = ( 1.0 - break55_g60050.x );
					float ifLocalVar61_g60050 = 0;
					if( temp_output_56_0_g60050 <= 0.0 )
					ifLocalVar61_g60050 = temp_output_67_0_g60050;
					else
					ifLocalVar61_g60050 = break55_g60050.x;
					float temp_output_597_29_g60049 = ifLocalVar61_g60050;
					float4 Output_2D293_g60049 = ( ( tex2D( _Sampler82967_g60028, temp_output_597_0_g60049, DDX631_g60049, DDY632_g60049 ) * temp_output_597_30_g60049 ) + ( tex2D( _Sampler82967_g60028, temp_output_597_26_g60049, DDX631_g60049, DDY632_g60049 ) * temp_output_597_28_g60049 ) + ( tex2D( _Sampler82967_g60028, temp_output_597_27_g60049, DDX631_g60049, DDY632_g60049 ) * temp_output_597_29_g60049 ) );
					float4 break31_g60049 = Output_2D293_g60049;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g60028 = break31_g60049.r;
					#else
					float staticSwitch1005_g60028 = staticSwitch846_g60028;
					#endif
					float Metallic1239_g60028 = staticSwitch1005_g60028;
					float3 aAlbedo1466_g60028 = ( temp_output_2532_0_g60028 * ( 1.0 - Metallic1239_g60028 ) );
					float White38_g60028 = 1.0;
					float4 temp_cast_1 = (White38_g60028).xxxx;
					float4 texCoord2426_g60028 = IN.ase_texcoord6;
					texCoord2426_g60028.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0B2361_g60028 = (texCoord2426_g60028).zw;
					float localBicubicPrepare2_g60037 = ( 0.0 );
					float2 Input_UV100_g60037 = UV0B2361_g60028;
					float2 UV2_g60037 = Input_UV100_g60037;
					float4 TexelSize2_g60037 = _Lightmap0_TexelSize;
					float2 UV02_g60037 = float2( 0,0 );
					float2 UV12_g60037 = float2( 0,0 );
					float2 UV22_g60037 = float2( 0,0 );
					float2 UV32_g60037 = float2( 0,0 );
					float W02_g60037 = 0;
					float W12_g60037 = 0;
					{
					{
					 UV2_g60037 = UV2_g60037 * TexelSize2_g60037.zw - 0.5;
					    float2 f = frac( UV2_g60037 );
					    UV2_g60037 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g60037.x - 0.5, UV2_g60037.x + 1.5, UV2_g60037.y - 0.5, UV2_g60037.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60037.xyxy;
					    UV02_g60037 = off.xz;
					    UV12_g60037 = off.yz;
					    UV22_g60037 = off.xw;
					    UV32_g60037 = off.yw;
					    W02_g60037 = s.x / ( s.x + s.y );
					 W12_g60037 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g60037 = lerp( tex2D( _Lightmap0, UV32_g60037 ) , tex2D( _Lightmap0, UV22_g60037 ) , W02_g60037);
					float4 lerpResult45_g60037 = lerp( tex2D( _Lightmap0, UV12_g60037 ) , tex2D( _Lightmap0, UV02_g60037 ) , W02_g60037);
					float4 lerpResult44_g60037 = lerp( lerpResult46_g60037 , lerpResult45_g60037 , W12_g60037);
					float4 Output_2D_Auto131_g60037 = lerpResult44_g60037;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g60028 = Output_2D_Auto131_g60037;
					#else
					float4 staticSwitch1092_g60028 = float4( tex2D( _Lightmap0, UV0B2361_g60028 ).rgb , 0.0 );
					#endif
					float4 Lightmap_0925_g60028 = staticSwitch1092_g60028;
					float localBicubicPrepare2_g60035 = ( 0.0 );
					float2 Input_UV100_g60035 = UV0B2361_g60028;
					float2 UV2_g60035 = Input_UV100_g60035;
					float4 TexelSize2_g60035 = _Lightmap1_TexelSize;
					float2 UV02_g60035 = float2( 0,0 );
					float2 UV12_g60035 = float2( 0,0 );
					float2 UV22_g60035 = float2( 0,0 );
					float2 UV32_g60035 = float2( 0,0 );
					float W02_g60035 = 0;
					float W12_g60035 = 0;
					{
					{
					 UV2_g60035 = UV2_g60035 * TexelSize2_g60035.zw - 0.5;
					    float2 f = frac( UV2_g60035 );
					    UV2_g60035 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g60035.x - 0.5, UV2_g60035.x + 1.5, UV2_g60035.y - 0.5, UV2_g60035.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60035.xyxy;
					    UV02_g60035 = off.xz;
					    UV12_g60035 = off.yz;
					    UV22_g60035 = off.xw;
					    UV32_g60035 = off.yw;
					    W02_g60035 = s.x / ( s.x + s.y );
					 W12_g60035 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g60035 = lerp( tex2D( _Lightmap1, UV32_g60035 ) , tex2D( _Lightmap1, UV22_g60035 ) , W02_g60035);
					float4 lerpResult45_g60035 = lerp( tex2D( _Lightmap1, UV12_g60035 ) , tex2D( _Lightmap1, UV02_g60035 ) , W02_g60035);
					float4 lerpResult44_g60035 = lerp( lerpResult46_g60035 , lerpResult45_g60035 , W12_g60035);
					float4 Output_2D_Auto131_g60035 = lerpResult44_g60035;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g60028 = Output_2D_Auto131_g60035;
					#else
					float4 staticSwitch1088_g60028 = tex2D( _Lightmap1, UV0B2361_g60028 );
					#endif
					float4 Lightmap_1956_g60028 = staticSwitch1088_g60028;
					float Lightmap_Lerp_Value969_g60028 = _UdonLightmapLerp;
					float4 lerpResult442_g60028 = lerp( Lightmap_0925_g60028 , Lightmap_1956_g60028 , Lightmap_Lerp_Value969_g60028);
					float4 Lightmap_Lerp932_g60028 = lerpResult442_g60028;
					float3 appendResult139_g60074 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float2 temp_output_5_0_g60044 = UV0A2420_g60028;
					float2 UV633_g60044 = temp_output_5_0_g60044;
					float2 UV100_g60045 = UV633_g60044;
					float2 temp_output_51_0_g60045 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60045 * float2( 3.464,3.464 ) ) );
					float2 break55_g60045 = frac( temp_output_51_0_g60045 );
					float temp_output_56_0_g60045 = ( ( 1.0 - break55_g60045.x ) - break55_g60045.y );
					float2 temp_output_52_0_g60045 = floor( temp_output_51_0_g60045 );
					float2 temp_output_125_0_g60045 = ( temp_output_52_0_g60045 + float2( 1,1 ) );
					float2 ifLocalVar87_g60045 = 0;
					if( temp_output_56_0_g60045 > 0.0 )
					ifLocalVar87_g60045 = temp_output_52_0_g60045;
					else if( temp_output_56_0_g60045 == 0.0 )
					ifLocalVar87_g60045 = temp_output_125_0_g60045;
					else if( temp_output_56_0_g60045 < 0.0 )
					ifLocalVar87_g60045 = temp_output_125_0_g60045;
					float3 temp_output_7_0_g60046 = frac( ( (ifLocalVar87_g60045).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60046 = dot( temp_output_7_0_g60046 , ( (temp_output_7_0_g60046).yzx + 33.33 ) );
					float3 temp_output_12_0_g60046 = ( temp_output_7_0_g60046 + dotResult8_g60046 );
					float2 temp_output_597_0_g60044 = ( UV100_g60045 + frac( ( ( (temp_output_12_0_g60046).xx + (temp_output_12_0_g60046).yz ) * (temp_output_12_0_g60046).zy ) ) );
					float2 DDX631_g60044 = ddx( temp_output_5_0_g60044 );
					float2 DDY632_g60044 = ddy( temp_output_5_0_g60044 );
					float Input_Scale617_g60044 = 1.5;
					float temp_output_65_0_g60045 = ( 0.0 - temp_output_56_0_g60045 );
					float ifLocalVar59_g60045 = 0;
					if( temp_output_56_0_g60045 <= 0.0 )
					ifLocalVar59_g60045 = temp_output_65_0_g60045;
					else
					ifLocalVar59_g60045 = temp_output_56_0_g60045;
					float temp_output_597_30_g60044 = ifLocalVar59_g60045;
					float2 temp_output_90_0_g60045 = ( temp_output_52_0_g60045 + float2( 0,1 ) );
					float2 temp_output_123_0_g60045 = ( temp_output_52_0_g60045 + float2( 1,0 ) );
					float2 ifLocalVar88_g60045 = 0;
					if( temp_output_56_0_g60045 > 0.0 )
					ifLocalVar88_g60045 = temp_output_90_0_g60045;
					else if( temp_output_56_0_g60045 == 0.0 )
					ifLocalVar88_g60045 = temp_output_123_0_g60045;
					else if( temp_output_56_0_g60045 < 0.0 )
					ifLocalVar88_g60045 = temp_output_123_0_g60045;
					float3 temp_output_7_0_g60047 = frac( ( (ifLocalVar88_g60045).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60047 = dot( temp_output_7_0_g60047 , ( (temp_output_7_0_g60047).yzx + 33.33 ) );
					float3 temp_output_12_0_g60047 = ( temp_output_7_0_g60047 + dotResult8_g60047 );
					float2 temp_output_597_26_g60044 = ( UV100_g60045 + frac( ( ( (temp_output_12_0_g60047).xx + (temp_output_12_0_g60047).yz ) * (temp_output_12_0_g60047).zy ) ) );
					float temp_output_66_0_g60045 = ( 1.0 - break55_g60045.y );
					float ifLocalVar60_g60045 = 0;
					if( temp_output_56_0_g60045 <= 0.0 )
					ifLocalVar60_g60045 = temp_output_66_0_g60045;
					else
					ifLocalVar60_g60045 = break55_g60045.y;
					float temp_output_597_28_g60044 = ifLocalVar60_g60045;
					float2 ifLocalVar89_g60045 = 0;
					if( temp_output_56_0_g60045 > 0.0 )
					ifLocalVar89_g60045 = temp_output_123_0_g60045;
					else if( temp_output_56_0_g60045 == 0.0 )
					ifLocalVar89_g60045 = temp_output_90_0_g60045;
					else if( temp_output_56_0_g60045 < 0.0 )
					ifLocalVar89_g60045 = temp_output_90_0_g60045;
					float3 temp_output_7_0_g60048 = frac( ( (ifLocalVar89_g60045).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60048 = dot( temp_output_7_0_g60048 , ( (temp_output_7_0_g60048).yzx + 33.33 ) );
					float3 temp_output_12_0_g60048 = ( temp_output_7_0_g60048 + dotResult8_g60048 );
					float2 temp_output_597_27_g60044 = ( UV100_g60045 + frac( ( ( (temp_output_12_0_g60048).xx + (temp_output_12_0_g60048).yz ) * (temp_output_12_0_g60048).zy ) ) );
					float temp_output_67_0_g60045 = ( 1.0 - break55_g60045.x );
					float ifLocalVar61_g60045 = 0;
					if( temp_output_56_0_g60045 <= 0.0 )
					ifLocalVar61_g60045 = temp_output_67_0_g60045;
					else
					ifLocalVar61_g60045 = break55_g60045.x;
					float temp_output_597_29_g60044 = ifLocalVar61_g60045;
					float3 Output_2D_Normal641_g60044 = ( ( UnpackScaleNormal( tex2D( _Sampler82965_g60028, temp_output_597_0_g60044, DDX631_g60044, DDY632_g60044 ), Input_Scale617_g60044 ) * temp_output_597_30_g60044 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g60028, temp_output_597_26_g60044, DDX631_g60044, DDY632_g60044 ), Input_Scale617_g60044 ) * temp_output_597_28_g60044 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g60028, temp_output_597_27_g60044, DDX631_g60044, DDY632_g60044 ), Input_Scale617_g60044 ) * float3( 0,0,0 ) * temp_output_597_29_g60044 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g60028 = Output_2D_Normal641_g60044;
					#else
					float3 staticSwitch1003_g60028 = UnpackScaleNormal( tex2D( _BumpMap, UV0A2420_g60028 ), 1.5 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g60028 = staticSwitch1003_g60028;
					#else
					float3 staticSwitch980_g60028 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g60028 = staticSwitch980_g60028;
					float3 normalizeResult326_g60074 = normalize( Normal_Map700_g60028 );
					float3 Normal_Map318_g60074 = normalizeResult326_g60074;
					float dotResult121_g60074 = dot( appendResult139_g60074 , Normal_Map318_g60074 );
					float temp_output_2_0_g60076 = saturate( dotResult121_g60074 );
					float localStochasticTiling2_g60070 = ( 0.0 );
					float2 UV2_g60070 = UV0B2361_g60028;
					float4 TexelSize2_g60070 = _UdonRNMX0_TexelSize;
					float4 Offsets2_g60070 = float4( 0,0,0,0 );
					float2 Weights2_g60070 = float2( 0,0 );
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
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g60070 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60070.xyxy;
					Weights2_g60070 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g60069 = Offsets2_g60070;
					float4 Input_FetchOffsets197_g60071 = temp_output_1_34_g60069;
					float2 temp_output_1_54_g60069 = Weights2_g60070;
					float2 Input_FetchWeights200_g60071 = temp_output_1_54_g60069;
					float2 break187_g60071 = Input_FetchWeights200_g60071;
					float4 lerpResult181_g60071 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60071).yw ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60071).xw ) , break187_g60071.x);
					float4 lerpResult182_g60071 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60071).yz ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60071).xz ) , break187_g60071.x);
					float4 lerpResult176_g60071 = lerp( lerpResult181_g60071 , lerpResult182_g60071 , break187_g60071.y);
					float4 Output_Fetch2D_Auto202_g60071 = lerpResult176_g60071;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g60028 = Output_Fetch2D_Auto202_g60071;
					#else
					float4 staticSwitch1061_g60028 = tex2D( _UdonRNMX0, UV0B2361_g60028 );
					#endif
					float3 appendResult146_g60074 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g60074 = dot( appendResult146_g60074 , Normal_Map318_g60074 );
					float temp_output_2_0_g60075 = saturate( dotResult122_g60074 );
					float4 Input_FetchOffsets197_g60072 = temp_output_1_34_g60069;
					float2 Input_FetchWeights200_g60072 = temp_output_1_54_g60069;
					float2 break187_g60072 = Input_FetchWeights200_g60072;
					float4 lerpResult181_g60072 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60072).yw ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60072).xw ) , break187_g60072.x);
					float4 lerpResult182_g60072 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60072).yz ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60072).xz ) , break187_g60072.x);
					float4 lerpResult176_g60072 = lerp( lerpResult181_g60072 , lerpResult182_g60072 , break187_g60072.y);
					float4 Output_Fetch2D_Auto202_g60072 = lerpResult176_g60072;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g60028 = Output_Fetch2D_Auto202_g60072;
					#else
					float4 staticSwitch1062_g60028 = tex2D( _UdonRNMY0, UV0B2361_g60028 );
					#endif
					float3 appendResult149_g60074 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g60074 = dot( appendResult149_g60074 , Normal_Map318_g60074 );
					float temp_output_2_0_g60077 = saturate( dotResult120_g60074 );
					float4 Input_FetchOffsets197_g60073 = temp_output_1_34_g60069;
					float2 Input_FetchWeights200_g60073 = temp_output_1_54_g60069;
					float2 break187_g60073 = Input_FetchWeights200_g60073;
					float4 lerpResult181_g60073 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60073).yw ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60073).xw ) , break187_g60073.x);
					float4 lerpResult182_g60073 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60073).yz ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60073).xz ) , break187_g60073.x);
					float4 lerpResult176_g60073 = lerp( lerpResult181_g60073 , lerpResult182_g60073 , break187_g60073.y);
					float4 Output_Fetch2D_Auto202_g60073 = lerpResult176_g60073;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g60028 = Output_Fetch2D_Auto202_g60073;
					#else
					float4 staticSwitch1063_g60028 = tex2D( _UdonRNMZ0, UV0B2361_g60028 );
					#endif
					float4 RNM_0926_g60028 = ( ( ( ( ( temp_output_2_0_g60076 * temp_output_2_0_g60076 ) * staticSwitch1061_g60028 ) + ( ( temp_output_2_0_g60075 * temp_output_2_0_g60075 ) * staticSwitch1062_g60028 ) ) + ( ( temp_output_2_0_g60077 * temp_output_2_0_g60077 ) * staticSwitch1063_g60028 ) ) * 1.5 );
					float3 appendResult139_g60040 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g60040 = normalize( Normal_Map700_g60028 );
					float3 Normal_Map318_g60040 = normalizeResult326_g60040;
					float dotResult121_g60040 = dot( appendResult139_g60040 , Normal_Map318_g60040 );
					float temp_output_2_0_g60042 = saturate( dotResult121_g60040 );
					float localStochasticTiling2_g60030 = ( 0.0 );
					float2 UV2_g60030 = UV0B2361_g60028;
					float4 TexelSize2_g60030 = _UdonRNMX1_TexelSize;
					float4 Offsets2_g60030 = float4( 0,0,0,0 );
					float2 Weights2_g60030 = float2( 0,0 );
					{
					UV2_g60030 = UV2_g60030 * TexelSize2_g60030.zw - 0.5;
					float2 f = frac( UV2_g60030 );
					UV2_g60030 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g60030.x - 0.5, UV2_g60030.x + 1.5, UV2_g60030.y - 0.5, UV2_g60030.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g60030 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60030.xyxy;
					Weights2_g60030 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g60029 = Offsets2_g60030;
					float4 Input_FetchOffsets197_g60031 = temp_output_1_34_g60029;
					float2 temp_output_1_54_g60029 = Weights2_g60030;
					float2 Input_FetchWeights200_g60031 = temp_output_1_54_g60029;
					float2 break187_g60031 = Input_FetchWeights200_g60031;
					float4 lerpResult181_g60031 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60031).yw ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60031).xw ) , break187_g60031.x);
					float4 lerpResult182_g60031 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60031).yz ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60031).xz ) , break187_g60031.x);
					float4 lerpResult176_g60031 = lerp( lerpResult181_g60031 , lerpResult182_g60031 , break187_g60031.y);
					float4 Output_Fetch2D_Auto202_g60031 = lerpResult176_g60031;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g60028 = Output_Fetch2D_Auto202_g60031;
					#else
					float4 staticSwitch1087_g60028 = tex2D( _UdonRNMX1, UV0B2361_g60028 );
					#endif
					float3 appendResult146_g60040 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g60040 = dot( appendResult146_g60040 , Normal_Map318_g60040 );
					float temp_output_2_0_g60041 = saturate( dotResult122_g60040 );
					float4 Input_FetchOffsets197_g60032 = temp_output_1_34_g60029;
					float2 Input_FetchWeights200_g60032 = temp_output_1_54_g60029;
					float2 break187_g60032 = Input_FetchWeights200_g60032;
					float4 lerpResult181_g60032 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60032).yw ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60032).xw ) , break187_g60032.x);
					float4 lerpResult182_g60032 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60032).yz ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60032).xz ) , break187_g60032.x);
					float4 lerpResult176_g60032 = lerp( lerpResult181_g60032 , lerpResult182_g60032 , break187_g60032.y);
					float4 Output_Fetch2D_Auto202_g60032 = lerpResult176_g60032;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g60028 = Output_Fetch2D_Auto202_g60032;
					#else
					float4 staticSwitch1083_g60028 = tex2D( _UdonRNMY1, UV0B2361_g60028 );
					#endif
					float3 appendResult149_g60040 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g60040 = dot( appendResult149_g60040 , Normal_Map318_g60040 );
					float temp_output_2_0_g60043 = saturate( dotResult120_g60040 );
					float4 Input_FetchOffsets197_g60033 = temp_output_1_34_g60029;
					float2 Input_FetchWeights200_g60033 = temp_output_1_54_g60029;
					float2 break187_g60033 = Input_FetchWeights200_g60033;
					float4 lerpResult181_g60033 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60033).yw ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60033).xw ) , break187_g60033.x);
					float4 lerpResult182_g60033 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60033).yz ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60033).xz ) , break187_g60033.x);
					float4 lerpResult176_g60033 = lerp( lerpResult181_g60033 , lerpResult182_g60033 , break187_g60033.y);
					float4 Output_Fetch2D_Auto202_g60033 = lerpResult176_g60033;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g60028 = Output_Fetch2D_Auto202_g60033;
					#else
					float4 staticSwitch1084_g60028 = tex2D( _UdonRNMZ1, UV0B2361_g60028 );
					#endif
					float4 RNM_11081_g60028 = ( ( ( ( ( temp_output_2_0_g60042 * temp_output_2_0_g60042 ) * staticSwitch1087_g60028 ) + ( ( temp_output_2_0_g60041 * temp_output_2_0_g60041 ) * staticSwitch1083_g60028 ) ) + ( ( temp_output_2_0_g60043 * temp_output_2_0_g60043 ) * staticSwitch1084_g60028 ) ) * 1.5 );
					float4 lerpResult953_g60028 = lerp( RNM_0926_g60028 , RNM_11081_g60028 , Lightmap_Lerp_Value969_g60028);
					float4 RNM_Lerp950_g60028 = lerpResult953_g60028;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g60028 = temp_cast_1;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g60028 = Lightmap_0925_g60028;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g60028 = Lightmap_Lerp932_g60028;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g60028 = RNM_0926_g60028;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g60028 = RNM_Lerp950_g60028;
					#else
					float4 staticSwitch1014_g60028 = temp_cast_1;
					#endif
					float3 Lightmap46_g60028 = (staticSwitch1014_g60028).rgb;
					float2 temp_output_5_0_g60064 = UV0A2420_g60028;
					float2 UV633_g60064 = temp_output_5_0_g60064;
					float2 UV100_g60065 = UV633_g60064;
					float2 temp_output_51_0_g60065 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60065 * float2( 3.464,3.464 ) ) );
					float2 break55_g60065 = frac( temp_output_51_0_g60065 );
					float temp_output_56_0_g60065 = ( ( 1.0 - break55_g60065.x ) - break55_g60065.y );
					float2 temp_output_52_0_g60065 = floor( temp_output_51_0_g60065 );
					float2 temp_output_125_0_g60065 = ( temp_output_52_0_g60065 + float2( 1,1 ) );
					float2 ifLocalVar87_g60065 = 0;
					if( temp_output_56_0_g60065 > 0.0 )
					ifLocalVar87_g60065 = temp_output_52_0_g60065;
					else if( temp_output_56_0_g60065 == 0.0 )
					ifLocalVar87_g60065 = temp_output_125_0_g60065;
					else if( temp_output_56_0_g60065 < 0.0 )
					ifLocalVar87_g60065 = temp_output_125_0_g60065;
					float3 temp_output_7_0_g60066 = frac( ( (ifLocalVar87_g60065).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60066 = dot( temp_output_7_0_g60066 , ( (temp_output_7_0_g60066).yzx + 33.33 ) );
					float3 temp_output_12_0_g60066 = ( temp_output_7_0_g60066 + dotResult8_g60066 );
					float2 temp_output_597_0_g60064 = ( UV100_g60065 + frac( ( ( (temp_output_12_0_g60066).xx + (temp_output_12_0_g60066).yz ) * (temp_output_12_0_g60066).zy ) ) );
					float2 DDX631_g60064 = ddx( temp_output_5_0_g60064 );
					float2 DDY632_g60064 = ddy( temp_output_5_0_g60064 );
					float temp_output_65_0_g60065 = ( 0.0 - temp_output_56_0_g60065 );
					float ifLocalVar59_g60065 = 0;
					if( temp_output_56_0_g60065 <= 0.0 )
					ifLocalVar59_g60065 = temp_output_65_0_g60065;
					else
					ifLocalVar59_g60065 = temp_output_56_0_g60065;
					float temp_output_597_30_g60064 = ifLocalVar59_g60065;
					float2 temp_output_90_0_g60065 = ( temp_output_52_0_g60065 + float2( 0,1 ) );
					float2 temp_output_123_0_g60065 = ( temp_output_52_0_g60065 + float2( 1,0 ) );
					float2 ifLocalVar88_g60065 = 0;
					if( temp_output_56_0_g60065 > 0.0 )
					ifLocalVar88_g60065 = temp_output_90_0_g60065;
					else if( temp_output_56_0_g60065 == 0.0 )
					ifLocalVar88_g60065 = temp_output_123_0_g60065;
					else if( temp_output_56_0_g60065 < 0.0 )
					ifLocalVar88_g60065 = temp_output_123_0_g60065;
					float3 temp_output_7_0_g60067 = frac( ( (ifLocalVar88_g60065).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60067 = dot( temp_output_7_0_g60067 , ( (temp_output_7_0_g60067).yzx + 33.33 ) );
					float3 temp_output_12_0_g60067 = ( temp_output_7_0_g60067 + dotResult8_g60067 );
					float2 temp_output_597_26_g60064 = ( UV100_g60065 + frac( ( ( (temp_output_12_0_g60067).xx + (temp_output_12_0_g60067).yz ) * (temp_output_12_0_g60067).zy ) ) );
					float temp_output_66_0_g60065 = ( 1.0 - break55_g60065.y );
					float ifLocalVar60_g60065 = 0;
					if( temp_output_56_0_g60065 <= 0.0 )
					ifLocalVar60_g60065 = temp_output_66_0_g60065;
					else
					ifLocalVar60_g60065 = break55_g60065.y;
					float temp_output_597_28_g60064 = ifLocalVar60_g60065;
					float2 ifLocalVar89_g60065 = 0;
					if( temp_output_56_0_g60065 > 0.0 )
					ifLocalVar89_g60065 = temp_output_123_0_g60065;
					else if( temp_output_56_0_g60065 == 0.0 )
					ifLocalVar89_g60065 = temp_output_90_0_g60065;
					else if( temp_output_56_0_g60065 < 0.0 )
					ifLocalVar89_g60065 = temp_output_90_0_g60065;
					float3 temp_output_7_0_g60068 = frac( ( (ifLocalVar89_g60065).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60068 = dot( temp_output_7_0_g60068 , ( (temp_output_7_0_g60068).yzx + 33.33 ) );
					float3 temp_output_12_0_g60068 = ( temp_output_7_0_g60068 + dotResult8_g60068 );
					float2 temp_output_597_27_g60064 = ( UV100_g60065 + frac( ( ( (temp_output_12_0_g60068).xx + (temp_output_12_0_g60068).yz ) * (temp_output_12_0_g60068).zy ) ) );
					float temp_output_67_0_g60065 = ( 1.0 - break55_g60065.x );
					float ifLocalVar61_g60065 = 0;
					if( temp_output_56_0_g60065 <= 0.0 )
					ifLocalVar61_g60065 = temp_output_67_0_g60065;
					else
					ifLocalVar61_g60065 = break55_g60065.x;
					float temp_output_597_29_g60064 = ifLocalVar61_g60065;
					float4 Output_2D293_g60064 = ( ( tex2D( _Sampler82968_g60028, temp_output_597_0_g60064, DDX631_g60064, DDY632_g60064 ) * temp_output_597_30_g60064 ) + ( tex2D( _Sampler82968_g60028, temp_output_597_26_g60064, DDX631_g60064, DDY632_g60064 ) * temp_output_597_28_g60064 ) + ( tex2D( _Sampler82968_g60028, temp_output_597_27_g60064, DDX631_g60064, DDY632_g60064 ) * temp_output_597_29_g60064 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g60028 = Output_2D293_g60064;
					#else
					float4 staticSwitch1006_g60028 = tex2D( _EmissionMap, UV0A2420_g60028 );
					#endif
					float3 temp_output_2531_0_g60028 = (( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g60028 * _EmissionIntensity )).rgb;
					float3 Emission86_g60028 = temp_output_2531_0_g60028;
					float Color1_g60080 = oAlbedo6_g60028.x;
					float Metallic1_g60080 = Metallic1239_g60028;
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g60028 = tex2D( _GlossinessMap, UV0A2420_g60028 ).r;
					#else
					float staticSwitch845_g60028 = _Glossiness;
					#endif
					float2 temp_output_5_0_g60059 = UV0A2420_g60028;
					float2 UV633_g60059 = temp_output_5_0_g60059;
					float2 UV100_g60060 = UV633_g60059;
					float2 temp_output_51_0_g60060 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60060 * float2( 3.464,3.464 ) ) );
					float2 break55_g60060 = frac( temp_output_51_0_g60060 );
					float temp_output_56_0_g60060 = ( ( 1.0 - break55_g60060.x ) - break55_g60060.y );
					float2 temp_output_52_0_g60060 = floor( temp_output_51_0_g60060 );
					float2 temp_output_125_0_g60060 = ( temp_output_52_0_g60060 + float2( 1,1 ) );
					float2 ifLocalVar87_g60060 = 0;
					if( temp_output_56_0_g60060 > 0.0 )
					ifLocalVar87_g60060 = temp_output_52_0_g60060;
					else if( temp_output_56_0_g60060 == 0.0 )
					ifLocalVar87_g60060 = temp_output_125_0_g60060;
					else if( temp_output_56_0_g60060 < 0.0 )
					ifLocalVar87_g60060 = temp_output_125_0_g60060;
					float3 temp_output_7_0_g60061 = frac( ( (ifLocalVar87_g60060).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60061 = dot( temp_output_7_0_g60061 , ( (temp_output_7_0_g60061).yzx + 33.33 ) );
					float3 temp_output_12_0_g60061 = ( temp_output_7_0_g60061 + dotResult8_g60061 );
					float2 temp_output_597_0_g60059 = ( UV100_g60060 + frac( ( ( (temp_output_12_0_g60061).xx + (temp_output_12_0_g60061).yz ) * (temp_output_12_0_g60061).zy ) ) );
					float2 DDX631_g60059 = ddx( temp_output_5_0_g60059 );
					float2 DDY632_g60059 = ddy( temp_output_5_0_g60059 );
					float temp_output_65_0_g60060 = ( 0.0 - temp_output_56_0_g60060 );
					float ifLocalVar59_g60060 = 0;
					if( temp_output_56_0_g60060 <= 0.0 )
					ifLocalVar59_g60060 = temp_output_65_0_g60060;
					else
					ifLocalVar59_g60060 = temp_output_56_0_g60060;
					float temp_output_597_30_g60059 = ifLocalVar59_g60060;
					float2 temp_output_90_0_g60060 = ( temp_output_52_0_g60060 + float2( 0,1 ) );
					float2 temp_output_123_0_g60060 = ( temp_output_52_0_g60060 + float2( 1,0 ) );
					float2 ifLocalVar88_g60060 = 0;
					if( temp_output_56_0_g60060 > 0.0 )
					ifLocalVar88_g60060 = temp_output_90_0_g60060;
					else if( temp_output_56_0_g60060 == 0.0 )
					ifLocalVar88_g60060 = temp_output_123_0_g60060;
					else if( temp_output_56_0_g60060 < 0.0 )
					ifLocalVar88_g60060 = temp_output_123_0_g60060;
					float3 temp_output_7_0_g60062 = frac( ( (ifLocalVar88_g60060).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60062 = dot( temp_output_7_0_g60062 , ( (temp_output_7_0_g60062).yzx + 33.33 ) );
					float3 temp_output_12_0_g60062 = ( temp_output_7_0_g60062 + dotResult8_g60062 );
					float2 temp_output_597_26_g60059 = ( UV100_g60060 + frac( ( ( (temp_output_12_0_g60062).xx + (temp_output_12_0_g60062).yz ) * (temp_output_12_0_g60062).zy ) ) );
					float temp_output_66_0_g60060 = ( 1.0 - break55_g60060.y );
					float ifLocalVar60_g60060 = 0;
					if( temp_output_56_0_g60060 <= 0.0 )
					ifLocalVar60_g60060 = temp_output_66_0_g60060;
					else
					ifLocalVar60_g60060 = break55_g60060.y;
					float temp_output_597_28_g60059 = ifLocalVar60_g60060;
					float2 ifLocalVar89_g60060 = 0;
					if( temp_output_56_0_g60060 > 0.0 )
					ifLocalVar89_g60060 = temp_output_123_0_g60060;
					else if( temp_output_56_0_g60060 == 0.0 )
					ifLocalVar89_g60060 = temp_output_90_0_g60060;
					else if( temp_output_56_0_g60060 < 0.0 )
					ifLocalVar89_g60060 = temp_output_90_0_g60060;
					float3 temp_output_7_0_g60063 = frac( ( (ifLocalVar89_g60060).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60063 = dot( temp_output_7_0_g60063 , ( (temp_output_7_0_g60063).yzx + 33.33 ) );
					float3 temp_output_12_0_g60063 = ( temp_output_7_0_g60063 + dotResult8_g60063 );
					float2 temp_output_597_27_g60059 = ( UV100_g60060 + frac( ( ( (temp_output_12_0_g60063).xx + (temp_output_12_0_g60063).yz ) * (temp_output_12_0_g60063).zy ) ) );
					float temp_output_67_0_g60060 = ( 1.0 - break55_g60060.x );
					float ifLocalVar61_g60060 = 0;
					if( temp_output_56_0_g60060 <= 0.0 )
					ifLocalVar61_g60060 = temp_output_67_0_g60060;
					else
					ifLocalVar61_g60060 = break55_g60060.x;
					float temp_output_597_29_g60059 = ifLocalVar61_g60060;
					float4 Output_2D293_g60059 = ( ( tex2D( _Sampler82964_g60028, temp_output_597_0_g60059, DDX631_g60059, DDY632_g60059 ) * temp_output_597_30_g60059 ) + ( tex2D( _Sampler82964_g60028, temp_output_597_26_g60059, DDX631_g60059, DDY632_g60059 ) * temp_output_597_28_g60059 ) + ( tex2D( _Sampler82964_g60028, temp_output_597_27_g60059, DDX631_g60059, DDY632_g60059 ) * temp_output_597_29_g60059 ) );
					float4 break31_g60059 = Output_2D293_g60059;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g60028 = ( 1.0 - break31_g60059.r );
					#else
					float staticSwitch1004_g60028 = ( 1.0 - staticSwitch845_g60028 );
					#endif
					float temp_output_19_0_g60078 = staticSwitch1004_g60028;
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal2504_g60028 = Normal_Map700_g60028;
					float3 worldNormal2504_g60028 = normalize( float3( dot( tanToWorld0, tanNormal2504_g60028 ), dot( tanToWorld1, tanNormal2504_g60028 ), dot( tanToWorld2, tanNormal2504_g60028 ) ) );
					float3 World_Normal2508_g60028 = worldNormal2504_g60028;
					float3 tanNormal2_g60078 = World_Normal2508_g60028;
					float3 worldNormal2_g60078 = float3( dot( tanToWorld0, tanNormal2_g60078 ), dot( tanToWorld1, tanNormal2_g60078 ), dot( tanToWorld2, tanNormal2_g60078 ) );
					float3 temp_output_3_0_g60078 = ddx( worldNormal2_g60078 );
					float dotResult5_g60078 = dot( temp_output_3_0_g60078 , temp_output_3_0_g60078 );
					float3 temp_output_4_0_g60078 = ddy( worldNormal2_g60078 );
					float dotResult6_g60078 = dot( temp_output_4_0_g60078 , temp_output_4_0_g60078 );
					#ifdef _USEGEOMETRICAA_ON
					float staticSwitch15_g60078 = min( temp_output_19_0_g60078, ( 1.0 - pow( saturate( max( dotResult5_g60078, dotResult6_g60078 ) ) , 0.25 ) ) );
					#else
					float staticSwitch15_g60078 = temp_output_19_0_g60078;
					#endif
					float Smoothness1399_g60028 = staticSwitch15_g60078;
					float Smoothness1_g60080 = Smoothness1399_g60028;
					float IOR2700_g60028 = _IOR;
					float IOR1_g60080 = IOR2700_g60028;
					float3 temp_cast_5 = (0.04).xxx;
					float3 lerpResult1473_g60028 = lerp( temp_cast_5 , oAlbedo6_g60028 , Metallic1239_g60028);
					float3 switchResult1501_g60028 = (((ase_vface>0)?(World_Normal2508_g60028):(-World_Normal2508_g60028)));
					float3 View_Direction2511_g60028 = ViewDirWS;
					float dotResult1476_g60028 = dot( switchResult1501_g60028 , View_Direction2511_g60028 );
					float3 lerpResult1480_g60028 = lerp( lerpResult1473_g60028 , float3( 1,1,1 ) , pow( ( 1.0 - saturate( dotResult1476_g60028 ) ) , 5.0 ));
					float3 Fresnel1560_g60028 = lerpResult1480_g60028;
					float3 Fresnel1_g60080 = Fresnel1560_g60028;
					float3 World_Position2505_g60028 = PositionWS;
					float3 WorldPos1_g60080 = World_Position2505_g60028;
					float3 WorldNormal1_g60080 = World_Normal2508_g60028;
					float3 ViewDir1_g60080 = View_Direction2511_g60028;
					float3 localIndirectSpecular1_g60080 = IndirectSpecular1_g60080( Color1_g60080 , Metallic1_g60080 , Smoothness1_g60080 , IOR1_g60080 , Fresnel1_g60080 , WorldPos1_g60080 , WorldNormal1_g60080 , ViewDir1_g60080 );
					float3 temp_output_2761_0_g60028 = localIndirectSpecular1_g60080;
					float grayscale2713_g60028 = Luminance( Lightmap46_g60028 );
					float smoothstepResult2430_g60028 = smoothstep( 0.0 , 0.1 , grayscale2713_g60028);
					#ifdef _USELIGHTMAPPEDREFLECTIONS_ON
					float3 staticSwitch1469_g60028 = ( temp_output_2761_0_g60028 * smoothstepResult2430_g60028 );
					#else
					float3 staticSwitch1469_g60028 = temp_output_2761_0_g60028;
					#endif
					float3 Reflections1419_g60028 = staticSwitch1469_g60028;
					float3 Color97_g60079 = oAlbedo6_g60028;
					float3 LightmapColor97_g60079 = Lightmap46_g60028;
					float Metallic97_g60079 = Metallic1239_g60028;
					float Smoothness97_g60079 = Smoothness1399_g60028;
					float IOR97_g60079 = IOR2700_g60028;
					float3 Fresnel97_g60079 = Fresnel1560_g60028;
					float3 WorldPos97_g60079 = World_Position2505_g60028;
					float3 WorldNormal97_g60079 = World_Normal2508_g60028;
					float3 ViewDir97_g60079 = View_Direction2511_g60028;
					float3 localDirectSpecular97_g60079 = DirectSpecular( Color97_g60079 , LightmapColor97_g60079 , Metallic97_g60079 , Smoothness97_g60079 , IOR97_g60079 , Fresnel97_g60079 , WorldPos97_g60079 , WorldNormal97_g60079 , ViewDir97_g60079 );
					float3 Speculars2560_g60028 = localDirectSpecular97_g60079;
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch1181_g60028 = Lightmap46_g60028;
					#else
					float3 staticSwitch1181_g60028 = ( ( aAlbedo1466_g60028 * Lightmap46_g60028 ) + Emission86_g60028 + Reflections1419_g60028 + Speculars2560_g60028 );
					#endif
					float3 temp_output_35_0_g60038 = staticSwitch1181_g60028;
					float3 Color353_g60038 = temp_output_35_0_g60038;
					#if defined( _LUTMODE_2D )
					float3 staticSwitch273_g60038 = saturate( temp_output_35_0_g60038 );
					#elif defined( _LUTMODE_3D )
					float3 staticSwitch273_g60038 = temp_output_35_0_g60038;
					#else
					float3 staticSwitch273_g60038 = temp_output_35_0_g60038;
					#endif
					float3 Color_Saturate49_g60038 = staticSwitch273_g60038;
					float Lut_Height213_g60038 = _LUTSize;
					float Lut_Width216_g60038 = ( _LUTSize * Lut_Height213_g60038 );
					float3 appendResult214_g60038 = (float3(( 1.0 / Lut_Width216_g60038 ) , ( 1.0 / Lut_Height213_g60038 ) , ( Lut_Height213_g60038 - 1.0 )));
					float3 Scale_Offset208_g60038 = appendResult214_g60038;
					float2 Scale_Factor292_g60038 = ( (Scale_Offset208_g60038).xy * (Scale_Offset208_g60038).z );
					float2 Offset299_g60038 = ( (Scale_Offset208_g60038).xy * 0.5 );
					float2 Adjusted_UV305_g60038 = ( ( (Color_Saturate49_g60038).xy * Scale_Factor292_g60038 ) + Offset299_g60038 );
					float Scaled_Blue280_g60038 = ( (Color_Saturate49_g60038).z * (Scale_Offset208_g60038).z );
					float Shift288_g60038 = floor( Scaled_Blue280_g60038 );
					float Final_X313_g60038 = ( (Adjusted_UV305_g60038).x + ( Shift288_g60038 * (Scale_Offset208_g60038).y ) );
					float2 appendResult326_g60038 = (float2(Final_X313_g60038 , (Adjusted_UV305_g60038).y));
					float2 Final_UV325_g60038 = appendResult326_g60038;
					float2 appendResult338_g60038 = (float2((Scale_Offset208_g60038).y , 0.0));
					float2 Offset_UV336_g60038 = ( Final_UV325_g60038 + appendResult338_g60038 );
					float3 lerpResult333_g60038 = lerp( tex2D( _2DLut, Final_UV325_g60038 ).rgb , tex2D( _2DLut, Offset_UV336_g60038 ).rgb , ( Scaled_Blue280_g60038 - Shift288_g60038 ));
					#ifdef _2DLUT
					float3 staticSwitch347_g60038 = lerpResult333_g60038;
					#else
					float3 staticSwitch347_g60038 = Color_Saturate49_g60038;
					#endif
					float3 TwoD_LUT346_g60038 = staticSwitch347_g60038;
					float3 RGB16_g60039 = ( ( log10( ( ( Color_Saturate49_g60038 * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 );
					#ifdef _3DLUT
					float3 staticSwitch194_g60038 = tex3D( _3DLut, RGB16_g60039 ).rgb;
					#else
					float3 staticSwitch194_g60038 = Color_Saturate49_g60038;
					#endif
					float3 ThreeD_LUT51_g60038 = staticSwitch194_g60038;
					#if defined( _LUTMODE_2D )
					float3 staticSwitch42_g60038 = TwoD_LUT346_g60038;
					#elif defined( _LUTMODE_3D )
					float3 staticSwitch42_g60038 = ThreeD_LUT51_g60038;
					#else
					float3 staticSwitch42_g60038 = ThreeD_LUT51_g60038;
					#endif
					#ifdef SHADER_API_MOBILE
					float3 staticSwitch41_g60038 = staticSwitch42_g60038;
					#else
					float3 staticSwitch41_g60038 = Color353_g60038;
					#endif
					
					#ifdef _LIGHTMAPDEBUG
					float staticSwitch1191_g60028 = White38_g60028;
					#else
					float staticSwitch1191_g60028 = staticSwitch1001_g60028.a;
					#endif
					

					o.Albedo = staticSwitch1180_g60028;
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

					o.Emission = staticSwitch41_g60038;
					o.Alpha = staticSwitch1191_g60028;
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
				#pragma shader_feature _LIGHTMAPDEBUG
				#pragma shader_feature_local _STOCHASTICENABLED_ON
				#pragma shader_feature_local _MAINTEX


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
				sampler2D _Sampler82966_g60028;
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

					float2 texCoord2357_g60028 = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0A2420_g60028 = texCoord2357_g60028;
					#ifdef _MAINTEX
					float4 staticSwitch1549_g60028 = tex2D( _MainTex, UV0A2420_g60028 );
					#else
					float4 staticSwitch1549_g60028 = _Color;
					#endif
					float2 temp_output_5_0_g60054 = UV0A2420_g60028;
					float2 UV633_g60054 = temp_output_5_0_g60054;
					float2 UV100_g60055 = UV633_g60054;
					float2 temp_output_51_0_g60055 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60055 * float2( 3.464,3.464 ) ) );
					float2 break55_g60055 = frac( temp_output_51_0_g60055 );
					float temp_output_56_0_g60055 = ( ( 1.0 - break55_g60055.x ) - break55_g60055.y );
					float2 temp_output_52_0_g60055 = floor( temp_output_51_0_g60055 );
					float2 temp_output_125_0_g60055 = ( temp_output_52_0_g60055 + float2( 1,1 ) );
					float2 ifLocalVar87_g60055 = 0;
					if( temp_output_56_0_g60055 > 0.0 )
					ifLocalVar87_g60055 = temp_output_52_0_g60055;
					else if( temp_output_56_0_g60055 == 0.0 )
					ifLocalVar87_g60055 = temp_output_125_0_g60055;
					else if( temp_output_56_0_g60055 < 0.0 )
					ifLocalVar87_g60055 = temp_output_125_0_g60055;
					float3 temp_output_7_0_g60056 = frac( ( (ifLocalVar87_g60055).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60056 = dot( temp_output_7_0_g60056 , ( (temp_output_7_0_g60056).yzx + 33.33 ) );
					float3 temp_output_12_0_g60056 = ( temp_output_7_0_g60056 + dotResult8_g60056 );
					float2 temp_output_597_0_g60054 = ( UV100_g60055 + frac( ( ( (temp_output_12_0_g60056).xx + (temp_output_12_0_g60056).yz ) * (temp_output_12_0_g60056).zy ) ) );
					float2 DDX631_g60054 = ddx( temp_output_5_0_g60054 );
					float2 DDY632_g60054 = ddy( temp_output_5_0_g60054 );
					float temp_output_65_0_g60055 = ( 0.0 - temp_output_56_0_g60055 );
					float ifLocalVar59_g60055 = 0;
					if( temp_output_56_0_g60055 <= 0.0 )
					ifLocalVar59_g60055 = temp_output_65_0_g60055;
					else
					ifLocalVar59_g60055 = temp_output_56_0_g60055;
					float temp_output_597_30_g60054 = ifLocalVar59_g60055;
					float2 temp_output_90_0_g60055 = ( temp_output_52_0_g60055 + float2( 0,1 ) );
					float2 temp_output_123_0_g60055 = ( temp_output_52_0_g60055 + float2( 1,0 ) );
					float2 ifLocalVar88_g60055 = 0;
					if( temp_output_56_0_g60055 > 0.0 )
					ifLocalVar88_g60055 = temp_output_90_0_g60055;
					else if( temp_output_56_0_g60055 == 0.0 )
					ifLocalVar88_g60055 = temp_output_123_0_g60055;
					else if( temp_output_56_0_g60055 < 0.0 )
					ifLocalVar88_g60055 = temp_output_123_0_g60055;
					float3 temp_output_7_0_g60057 = frac( ( (ifLocalVar88_g60055).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60057 = dot( temp_output_7_0_g60057 , ( (temp_output_7_0_g60057).yzx + 33.33 ) );
					float3 temp_output_12_0_g60057 = ( temp_output_7_0_g60057 + dotResult8_g60057 );
					float2 temp_output_597_26_g60054 = ( UV100_g60055 + frac( ( ( (temp_output_12_0_g60057).xx + (temp_output_12_0_g60057).yz ) * (temp_output_12_0_g60057).zy ) ) );
					float temp_output_66_0_g60055 = ( 1.0 - break55_g60055.y );
					float ifLocalVar60_g60055 = 0;
					if( temp_output_56_0_g60055 <= 0.0 )
					ifLocalVar60_g60055 = temp_output_66_0_g60055;
					else
					ifLocalVar60_g60055 = break55_g60055.y;
					float temp_output_597_28_g60054 = ifLocalVar60_g60055;
					float2 ifLocalVar89_g60055 = 0;
					if( temp_output_56_0_g60055 > 0.0 )
					ifLocalVar89_g60055 = temp_output_123_0_g60055;
					else if( temp_output_56_0_g60055 == 0.0 )
					ifLocalVar89_g60055 = temp_output_90_0_g60055;
					else if( temp_output_56_0_g60055 < 0.0 )
					ifLocalVar89_g60055 = temp_output_90_0_g60055;
					float3 temp_output_7_0_g60058 = frac( ( (ifLocalVar89_g60055).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60058 = dot( temp_output_7_0_g60058 , ( (temp_output_7_0_g60058).yzx + 33.33 ) );
					float3 temp_output_12_0_g60058 = ( temp_output_7_0_g60058 + dotResult8_g60058 );
					float2 temp_output_597_27_g60054 = ( UV100_g60055 + frac( ( ( (temp_output_12_0_g60058).xx + (temp_output_12_0_g60058).yz ) * (temp_output_12_0_g60058).zy ) ) );
					float temp_output_67_0_g60055 = ( 1.0 - break55_g60055.x );
					float ifLocalVar61_g60055 = 0;
					if( temp_output_56_0_g60055 <= 0.0 )
					ifLocalVar61_g60055 = temp_output_67_0_g60055;
					else
					ifLocalVar61_g60055 = break55_g60055.x;
					float temp_output_597_29_g60054 = ifLocalVar61_g60055;
					float4 Output_2D293_g60054 = ( ( tex2D( _Sampler82966_g60028, temp_output_597_0_g60054, DDX631_g60054, DDY632_g60054 ) * temp_output_597_30_g60054 ) + ( tex2D( _Sampler82966_g60028, temp_output_597_26_g60054, DDX631_g60054, DDY632_g60054 ) * temp_output_597_28_g60054 ) + ( tex2D( _Sampler82966_g60028, temp_output_597_27_g60054, DDX631_g60054, DDY632_g60054 ) * temp_output_597_29_g60054 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g60028 = Output_2D293_g60054;
					#else
					float4 staticSwitch1001_g60028 = staticSwitch1549_g60028;
					#endif
					float White38_g60028 = 1.0;
					#ifdef _LIGHTMAPDEBUG
					float staticSwitch1191_g60028 = White38_g60028;
					#else
					float staticSwitch1191_g60028 = staticSwitch1001_g60028.a;
					#endif
					

					o.Normal = half3( 0, 0, 1 );

					o.Alpha = staticSwitch1191_g60028;
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
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2962;192,-1200;Inherit;False;Meenphie;0;;60028;b3ba55a08dd6b49c7be16c6f35cf2033;6,1008,1,2632,0,2635,0,2636,0,2670,0,2619,0;0;5;FLOAT3;625;FLOAT3;624;FLOAT;156;FLOAT;427;FLOAT;1024
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2889;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;True;1;LightMode=ForwardAdd;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2890;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2891;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2892;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2893;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2894;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ScenePickingPass;0;7;ScenePickingPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=ScenePickingPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2888;512,-1200;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;6;Meenphie/Standard/Cutout;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardBase;0;1;ForwardBase;17;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;1;False;;True;3;False;;False;False;True;3;RenderType=TransparentCutout=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;44;Category;0;0;  Instanced Terrain Normals;1;0;Workflow;3;639057697570214470;Surface;0;638915427204303550;  Blend;2;638915425920684140;  Dither Shadows;1;0;Two Sided;0;639027460080664250;Alpha Clipping;1;638915427324710130;  Use Shadow Threshold;0;638915420933436960;Deferred Pass;0;638915425282396370;Normal Space;0;0;Transmission;0;638915425258747670;  Transmission Shadow;0.5,False,;0;Translucency;0;638915425246861880;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;1;638922399804812020;Receive Shadows;0;638922399717523500;Receive Specular;0;638915388784334560;Receive Reflections;1;638915388803555030;GPU Instancing;1;638915411619689990;LOD CrossFade;1;0;Built-in Fog;1;0;Ambient Light;0;639049545902984550;Meta Pass;0;639048817054746750;Add Pass;0;639048817051401800;Override Baked GI;0;638915390973737640;Write Depth;0;638915421117196140;Extra Pre Pass;0;639048817123696260;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;0;Vertex Position;1;0;0;8;False;True;False;False;False;True;False;False;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2887;512,-1440;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;True;True;0;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;True;True;1;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;0;False;;True;3;False;;True;False;0;False;;0;False;;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;0;False;0
WireConnection;2888;0;2962;625
WireConnection;2888;2;2962;624
WireConnection;2888;7;2962;156
WireConnection;2888;8;2962;427
ASEEND*/
//CHKSM=F6E560466B370D1C2144F4527678BBF098EEA7FF