// Made with Amplify Shader Editor v1.9.9.7
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Standard/Cutout"
{
	Properties
	{
		[Meenphie_DrawerCategory(SURFACE OPTIONS,true,0,0)] _CATEGORY_SURFACEOPTIONS( "CATEGORY_SURFACEOPTIONS", Float ) = 1
		_Color( "DIffuse Color", Color ) = ( 0.9058824, 0.9058824, 0.9058824, 1 )
		[NoScaleOffset][SingleLineTexture] _MainTex( "Diffuse Map", 2D ) = "white" {}
		_MaskClipValue( "Mask Clip Value", Range( 0, 1 ) ) = 0.5
		[NoScaleOffset][Normal][SingleLineTexture] _BumpMap( "Normal Map", 2D ) = "bump" {}
		[NoScaleOffset][SingleLineTexture] _MetallicMap( "Metallic Map", 2D ) = "white" {}
		[NoScaleOffset][SingleLineTexture] _GlossinessMap( "Roughness Map", 2D ) = "white" {}
		_Metallic( "Metallic", Range( 0, 1 ) ) = 0
		_Glossiness( "Smoothness", Range( 0, 1 ) ) = 0.5
		[Toggle( _USEGEOMETRICAA_ON )] _UseGeometricAA( "Use Geometric AA", Float ) = 1
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
		[HideInInspector] GenKey__GlossinessMap( "Assign keyword _GLOSSINESSMAP", Float ) = 1.0
		[HideInInspector] GenKey__MainTex( "Assign keyword _MAINTEX", Float ) = 1.0
		[HideInInspector] GenKey__3DLut( "Assign keyword _3DLUT", Float ) = 1.0
		[HideInInspector] GenKey__2DLut( "Assign keyword _2DLUT", Float ) = 1.0
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
				#pragma shader_feature_local _USEGEOMETRICAA_ON
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
				uniform float4 _UdonSpecularLightDir[32];
				uniform float4 _UdonSpecularLightCol[32];
				uniform float4 _UdonSpecularLightPos[32];
				uniform float4 _UdonSpecularLightRight[32];
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
				uniform float3 _EmissionColor;
				uniform sampler2D _EmissionMap;
				uniform float _EmissionIntensity;
				uniform float _MaskClipValue;


				float3 IndirectGeometricSpecular1_g59655( float3 WorldPos, float3 WorldNormal, float3 ViewDir, float4 Fresnel, float Smoothness )
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
				
				float3 Specular( float3 WorldPos, float3 WorldNormal, float3 LightmapColor, float3 ViewDir, float4 Fresnel, float Smoothness )
				{
					// --- CONFIGURATION ---
					float LumaStart = 0.02; float LumaEnd = 0.4;
					float MaxRadius = 10.0; float RadiusFadeStart = 3.0;
					float specBoost = 1.0;
					float luma = dot(LightmapColor, float3(0.22, 0.70, 0.08));
					float lmMask = saturate((luma - LumaStart) / max(LumaEnd - LumaStart, 0.0001));
					float playerDist = distance(_WorldSpaceCameraPos, WorldPos);
					float fadeT = saturate((playerDist - RadiusFadeStart) / max(MaxRadius - RadiusFadeStart, 0.0001));
					float radiusFade = 1.0 - (fadeT * fadeT * (3.0 - 2.0 * fadeT)); 
					if (lmMask < 0.001 || Smoothness < 0.01 || _UdonSpecularLightCount == 0 || radiusFade < 0.001) return 0;
					float3 vDir = normalize(ViewDir);
					float3 N = normalize(WorldNormal);
					float shininess = exp2(10.0 * Smoothness + 1.0);
					float normalization = (shininess + 2.0) * 0.125;
					float3 R = reflect(-vDir, N);
					float3 specAccum = 0.0;
					for (int i = 0; i < (int)_UdonSpecularLightCount; i++)
					{
					    float4 posRange = _UdonSpecularLightPos[i];
					    float4 dirAngle = _UdonSpecularLightDir[i];
					    // Vecteur de surface vers centre lumière
					    float3 L_center = posRange.xyz - WorldPos;
					    float distSqCenter = dot(L_center, L_center);
					    float3 L_center_norm = L_center * rsqrt(distSqCenter + 0.0001);
					    // Spot Mask (on utilise le vecteur inversé car dirAngle.xyz est le forward de la lampe)
					    float theta = dot(-L_center_norm, dirAngle.xyz);
					    float spotMask = saturate((theta - dirAngle.w) / max(0.01, 1.0 - dirAngle.w));
					    if (spotMask > 0.001)
					    {
					        float atten = saturate(1.0 - (distSqCenter / (posRange.w * posRange.w)));
					        if (atten > 0.001)
					        {
					            // PROJECTION RECTIFIÉE : L et R doivent être dans le même hémisphère
					            float rDotL = max(0.0001, dot(L_center, R));
					            float3 proj = R * rDotL - L_center;
					            
					            float3 closestPoint = posRange.xyz;
					            closestPoint += _UdonSpecularLightRight[i].xyz * clamp(dot(proj, _UdonSpecularLightRight[i].xyz), -_UdonSpecularLightRight[i].w, _UdonSpecularLightRight[i].w);
					            closestPoint += _UdonSpecularLightUp[i].xyz * clamp(dot(proj, _UdonSpecularLightUp[i].xyz), -_UdonSpecularLightUp[i].w, _UdonSpecularLightUp[i].w);
					            float3 diff = closestPoint - WorldPos;
					            float distSq = dot(diff, diff);
					            float falloff = (atten * atten) / (distSq + 0.01);
					            if (falloff > 0.001)
					            {
					                float3 lDir = normalize(diff);
					                float nDotL = saturate((dot(N, lDir) + 0.15) / 1.15);
					                float3 H = normalize(lDir + vDir);
					                float spec = exp2(log2(max(saturate(dot(N, H)), 0.00001)) * shininess) * normalization;
					                
					                specAccum += _UdonSpecularLightCol[i].rgb * (spec * nDotL * _UdonSpecularLightCol[i].w * falloff * spotMask);
					            }
					        }
					    }
					}
					return specAccum * specBoost * Fresnel * lmMask * radiusFade;
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

					float2 texCoord2357_g59604 = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV02420_g59604 = texCoord2357_g59604;
					float2 temp_output_5_0_g59637 = UV02420_g59604;
					float2 UV633_g59637 = temp_output_5_0_g59637;
					float2 UV100_g59638 = UV633_g59637;
					float2 temp_output_51_0_g59638 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59638 * float2( 3.464,3.464 ) ) );
					float2 break55_g59638 = frac( temp_output_51_0_g59638 );
					float temp_output_56_0_g59638 = ( ( 1.0 - break55_g59638.x ) - break55_g59638.y );
					float2 temp_output_52_0_g59638 = floor( temp_output_51_0_g59638 );
					float2 temp_output_125_0_g59638 = ( temp_output_52_0_g59638 + float2( 1,1 ) );
					float2 ifLocalVar87_g59638 = 0;
					if( temp_output_56_0_g59638 > 0.0 )
					ifLocalVar87_g59638 = temp_output_52_0_g59638;
					else if( temp_output_56_0_g59638 == 0.0 )
					ifLocalVar87_g59638 = temp_output_125_0_g59638;
					else if( temp_output_56_0_g59638 < 0.0 )
					ifLocalVar87_g59638 = temp_output_125_0_g59638;
					float3 temp_output_7_0_g59639 = frac( ( (ifLocalVar87_g59638).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59639 = dot( temp_output_7_0_g59639 , ( (temp_output_7_0_g59639).yzx + 33.33 ) );
					float3 temp_output_12_0_g59639 = ( temp_output_7_0_g59639 + dotResult8_g59639 );
					float2 temp_output_597_0_g59637 = ( UV100_g59638 + frac( ( ( (temp_output_12_0_g59639).xx + (temp_output_12_0_g59639).yz ) * (temp_output_12_0_g59639).zy ) ) );
					float2 DDX631_g59637 = ddx( temp_output_5_0_g59637 );
					float2 DDY632_g59637 = ddy( temp_output_5_0_g59637 );
					float temp_output_65_0_g59638 = ( 0.0 - temp_output_56_0_g59638 );
					float ifLocalVar59_g59638 = 0;
					if( temp_output_56_0_g59638 <= 0.0 )
					ifLocalVar59_g59638 = temp_output_65_0_g59638;
					else
					ifLocalVar59_g59638 = temp_output_56_0_g59638;
					float temp_output_597_30_g59637 = ifLocalVar59_g59638;
					float2 temp_output_90_0_g59638 = ( temp_output_52_0_g59638 + float2( 0,1 ) );
					float2 temp_output_123_0_g59638 = ( temp_output_52_0_g59638 + float2( 1,0 ) );
					float2 ifLocalVar88_g59638 = 0;
					if( temp_output_56_0_g59638 > 0.0 )
					ifLocalVar88_g59638 = temp_output_90_0_g59638;
					else if( temp_output_56_0_g59638 == 0.0 )
					ifLocalVar88_g59638 = temp_output_123_0_g59638;
					else if( temp_output_56_0_g59638 < 0.0 )
					ifLocalVar88_g59638 = temp_output_123_0_g59638;
					float3 temp_output_7_0_g59640 = frac( ( (ifLocalVar88_g59638).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59640 = dot( temp_output_7_0_g59640 , ( (temp_output_7_0_g59640).yzx + 33.33 ) );
					float3 temp_output_12_0_g59640 = ( temp_output_7_0_g59640 + dotResult8_g59640 );
					float2 temp_output_597_26_g59637 = ( UV100_g59638 + frac( ( ( (temp_output_12_0_g59640).xx + (temp_output_12_0_g59640).yz ) * (temp_output_12_0_g59640).zy ) ) );
					float temp_output_66_0_g59638 = ( 1.0 - break55_g59638.y );
					float ifLocalVar60_g59638 = 0;
					if( temp_output_56_0_g59638 <= 0.0 )
					ifLocalVar60_g59638 = temp_output_66_0_g59638;
					else
					ifLocalVar60_g59638 = break55_g59638.y;
					float temp_output_597_28_g59637 = ifLocalVar60_g59638;
					float2 ifLocalVar89_g59638 = 0;
					if( temp_output_56_0_g59638 > 0.0 )
					ifLocalVar89_g59638 = temp_output_123_0_g59638;
					else if( temp_output_56_0_g59638 == 0.0 )
					ifLocalVar89_g59638 = temp_output_90_0_g59638;
					else if( temp_output_56_0_g59638 < 0.0 )
					ifLocalVar89_g59638 = temp_output_90_0_g59638;
					float3 temp_output_7_0_g59641 = frac( ( (ifLocalVar89_g59638).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59641 = dot( temp_output_7_0_g59641 , ( (temp_output_7_0_g59641).yzx + 33.33 ) );
					float3 temp_output_12_0_g59641 = ( temp_output_7_0_g59641 + dotResult8_g59641 );
					float2 temp_output_597_27_g59637 = ( UV100_g59638 + frac( ( ( (temp_output_12_0_g59641).xx + (temp_output_12_0_g59641).yz ) * (temp_output_12_0_g59641).zy ) ) );
					float temp_output_67_0_g59638 = ( 1.0 - break55_g59638.x );
					float ifLocalVar61_g59638 = 0;
					if( temp_output_56_0_g59638 <= 0.0 )
					ifLocalVar61_g59638 = temp_output_67_0_g59638;
					else
					ifLocalVar61_g59638 = break55_g59638.x;
					float temp_output_597_29_g59637 = ifLocalVar61_g59638;
					float4 Output_2D293_g59637 = ( ( tex2D( _MainTex, temp_output_597_0_g59637, DDX631_g59637, DDY632_g59637 ) * temp_output_597_30_g59637 ) + ( tex2D( _MainTex, temp_output_597_26_g59637, DDX631_g59637, DDY632_g59637 ) * temp_output_597_28_g59637 ) + ( tex2D( _MainTex, temp_output_597_27_g59637, DDX631_g59637, DDY632_g59637 ) * temp_output_597_29_g59637 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g59604 = Output_2D293_g59637;
					#else
					float4 staticSwitch1001_g59604 = tex2D( _MainTex, UV02420_g59604 );
					#endif
					#ifdef _MAINTEX
					float4 staticSwitch1549_g59604 = staticSwitch1001_g59604;
					#else
					float4 staticSwitch1549_g59604 = _Color;
					#endif
					float3 temp_output_2532_0_g59604 = (staticSwitch1549_g59604).rgb;
					float3 oAlbedo6_g59604 = temp_output_2532_0_g59604;
					float Black1185_g59604 = 0.0;
					float3 temp_cast_0 = (Black1185_g59604).xxx;
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch1180_g59604 = temp_cast_0;
					#else
					float3 staticSwitch1180_g59604 = oAlbedo6_g59604;
					#endif
					
					float2 temp_output_5_0_g59610 = UV02420_g59604;
					float2 UV633_g59610 = temp_output_5_0_g59610;
					float2 UV100_g59611 = UV633_g59610;
					float2 temp_output_51_0_g59611 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59611 * float2( 3.464,3.464 ) ) );
					float2 break55_g59611 = frac( temp_output_51_0_g59611 );
					float temp_output_56_0_g59611 = ( ( 1.0 - break55_g59611.x ) - break55_g59611.y );
					float2 temp_output_52_0_g59611 = floor( temp_output_51_0_g59611 );
					float2 temp_output_125_0_g59611 = ( temp_output_52_0_g59611 + float2( 1,1 ) );
					float2 ifLocalVar87_g59611 = 0;
					if( temp_output_56_0_g59611 > 0.0 )
					ifLocalVar87_g59611 = temp_output_52_0_g59611;
					else if( temp_output_56_0_g59611 == 0.0 )
					ifLocalVar87_g59611 = temp_output_125_0_g59611;
					else if( temp_output_56_0_g59611 < 0.0 )
					ifLocalVar87_g59611 = temp_output_125_0_g59611;
					float3 temp_output_7_0_g59612 = frac( ( (ifLocalVar87_g59611).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59612 = dot( temp_output_7_0_g59612 , ( (temp_output_7_0_g59612).yzx + 33.33 ) );
					float3 temp_output_12_0_g59612 = ( temp_output_7_0_g59612 + dotResult8_g59612 );
					float2 temp_output_597_0_g59610 = ( UV100_g59611 + frac( ( ( (temp_output_12_0_g59612).xx + (temp_output_12_0_g59612).yz ) * (temp_output_12_0_g59612).zy ) ) );
					float2 DDX631_g59610 = ddx( temp_output_5_0_g59610 );
					float2 DDY632_g59610 = ddy( temp_output_5_0_g59610 );
					float temp_output_65_0_g59611 = ( 0.0 - temp_output_56_0_g59611 );
					float ifLocalVar59_g59611 = 0;
					if( temp_output_56_0_g59611 <= 0.0 )
					ifLocalVar59_g59611 = temp_output_65_0_g59611;
					else
					ifLocalVar59_g59611 = temp_output_56_0_g59611;
					float temp_output_597_30_g59610 = ifLocalVar59_g59611;
					float2 temp_output_90_0_g59611 = ( temp_output_52_0_g59611 + float2( 0,1 ) );
					float2 temp_output_123_0_g59611 = ( temp_output_52_0_g59611 + float2( 1,0 ) );
					float2 ifLocalVar88_g59611 = 0;
					if( temp_output_56_0_g59611 > 0.0 )
					ifLocalVar88_g59611 = temp_output_90_0_g59611;
					else if( temp_output_56_0_g59611 == 0.0 )
					ifLocalVar88_g59611 = temp_output_123_0_g59611;
					else if( temp_output_56_0_g59611 < 0.0 )
					ifLocalVar88_g59611 = temp_output_123_0_g59611;
					float3 temp_output_7_0_g59613 = frac( ( (ifLocalVar88_g59611).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59613 = dot( temp_output_7_0_g59613 , ( (temp_output_7_0_g59613).yzx + 33.33 ) );
					float3 temp_output_12_0_g59613 = ( temp_output_7_0_g59613 + dotResult8_g59613 );
					float2 temp_output_597_26_g59610 = ( UV100_g59611 + frac( ( ( (temp_output_12_0_g59613).xx + (temp_output_12_0_g59613).yz ) * (temp_output_12_0_g59613).zy ) ) );
					float temp_output_66_0_g59611 = ( 1.0 - break55_g59611.y );
					float ifLocalVar60_g59611 = 0;
					if( temp_output_56_0_g59611 <= 0.0 )
					ifLocalVar60_g59611 = temp_output_66_0_g59611;
					else
					ifLocalVar60_g59611 = break55_g59611.y;
					float temp_output_597_28_g59610 = ifLocalVar60_g59611;
					float2 ifLocalVar89_g59611 = 0;
					if( temp_output_56_0_g59611 > 0.0 )
					ifLocalVar89_g59611 = temp_output_123_0_g59611;
					else if( temp_output_56_0_g59611 == 0.0 )
					ifLocalVar89_g59611 = temp_output_90_0_g59611;
					else if( temp_output_56_0_g59611 < 0.0 )
					ifLocalVar89_g59611 = temp_output_90_0_g59611;
					float3 temp_output_7_0_g59614 = frac( ( (ifLocalVar89_g59611).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59614 = dot( temp_output_7_0_g59614 , ( (temp_output_7_0_g59614).yzx + 33.33 ) );
					float3 temp_output_12_0_g59614 = ( temp_output_7_0_g59614 + dotResult8_g59614 );
					float2 temp_output_597_27_g59610 = ( UV100_g59611 + frac( ( ( (temp_output_12_0_g59614).xx + (temp_output_12_0_g59614).yz ) * (temp_output_12_0_g59614).zy ) ) );
					float temp_output_67_0_g59611 = ( 1.0 - break55_g59611.x );
					float ifLocalVar61_g59611 = 0;
					if( temp_output_56_0_g59611 <= 0.0 )
					ifLocalVar61_g59611 = temp_output_67_0_g59611;
					else
					ifLocalVar61_g59611 = break55_g59611.x;
					float temp_output_597_29_g59610 = ifLocalVar61_g59611;
					float4 Output_2D293_g59610 = ( ( tex2D( _MetallicMap, temp_output_597_0_g59610, DDX631_g59610, DDY632_g59610 ) * temp_output_597_30_g59610 ) + ( tex2D( _MetallicMap, temp_output_597_26_g59610, DDX631_g59610, DDY632_g59610 ) * temp_output_597_28_g59610 ) + ( tex2D( _MetallicMap, temp_output_597_27_g59610, DDX631_g59610, DDY632_g59610 ) * temp_output_597_29_g59610 ) );
					float4 break31_g59610 = Output_2D293_g59610;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g59604 = break31_g59610.a;
					#else
					float staticSwitch1005_g59604 = tex2D( _MetallicMap, UV02420_g59604 ).a;
					#endif
					#ifdef _METALLICMAP
					float staticSwitch846_g59604 = staticSwitch1005_g59604;
					#else
					float staticSwitch846_g59604 = _Metallic;
					#endif
					float Metallic1239_g59604 = staticSwitch846_g59604;
					float3 aAlbedo1466_g59604 = ( temp_output_2532_0_g59604 * ( 1.0 - Metallic1239_g59604 ) );
					float White38_g59604 = 1.0;
					float4 temp_cast_1 = (White38_g59604).xxxx;
					float4 texCoord2426_g59604 = IN.ase_texcoord6;
					texCoord2426_g59604.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV12361_g59604 = (texCoord2426_g59604).zw;
					float localBicubicPrepare2_g59643 = ( 0.0 );
					float2 Input_UV100_g59643 = UV12361_g59604;
					float2 UV2_g59643 = Input_UV100_g59643;
					float4 TexelSize2_g59643 = _Lightmap0_TexelSize;
					float2 UV02_g59643 = float2( 0,0 );
					float2 UV12_g59643 = float2( 0,0 );
					float2 UV22_g59643 = float2( 0,0 );
					float2 UV32_g59643 = float2( 0,0 );
					float W02_g59643 = 0;
					float W12_g59643 = 0;
					{
					{
					 UV2_g59643 = UV2_g59643 * TexelSize2_g59643.zw - 0.5;
					    float2 f = frac( UV2_g59643 );
					    UV2_g59643 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59643.x - 0.5, UV2_g59643.x + 1.5, UV2_g59643.y - 0.5, UV2_g59643.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59643.xyxy;
					    UV02_g59643 = off.xz;
					    UV12_g59643 = off.yz;
					    UV22_g59643 = off.xw;
					    UV32_g59643 = off.yw;
					    W02_g59643 = s.x / ( s.x + s.y );
					 W12_g59643 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59643 = lerp( tex2D( _Lightmap0, UV32_g59643 ) , tex2D( _Lightmap0, UV22_g59643 ) , W02_g59643);
					float4 lerpResult45_g59643 = lerp( tex2D( _Lightmap0, UV12_g59643 ) , tex2D( _Lightmap0, UV02_g59643 ) , W02_g59643);
					float4 lerpResult44_g59643 = lerp( lerpResult46_g59643 , lerpResult45_g59643 , W12_g59643);
					float4 Output_2D_Auto131_g59643 = lerpResult44_g59643;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g59604 = Output_2D_Auto131_g59643;
					#else
					float4 staticSwitch1092_g59604 = float4( tex2D( _Lightmap0, UV12361_g59604 ).rgb , 0.0 );
					#endif
					float4 Lightmap_0925_g59604 = staticSwitch1092_g59604;
					float localBicubicPrepare2_g59631 = ( 0.0 );
					float2 Input_UV100_g59631 = UV12361_g59604;
					float2 UV2_g59631 = Input_UV100_g59631;
					float4 TexelSize2_g59631 = _Lightmap1_TexelSize;
					float2 UV02_g59631 = float2( 0,0 );
					float2 UV12_g59631 = float2( 0,0 );
					float2 UV22_g59631 = float2( 0,0 );
					float2 UV32_g59631 = float2( 0,0 );
					float W02_g59631 = 0;
					float W12_g59631 = 0;
					{
					{
					 UV2_g59631 = UV2_g59631 * TexelSize2_g59631.zw - 0.5;
					    float2 f = frac( UV2_g59631 );
					    UV2_g59631 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59631.x - 0.5, UV2_g59631.x + 1.5, UV2_g59631.y - 0.5, UV2_g59631.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59631.xyxy;
					    UV02_g59631 = off.xz;
					    UV12_g59631 = off.yz;
					    UV22_g59631 = off.xw;
					    UV32_g59631 = off.yw;
					    W02_g59631 = s.x / ( s.x + s.y );
					 W12_g59631 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59631 = lerp( tex2D( _Lightmap1, UV32_g59631 ) , tex2D( _Lightmap1, UV22_g59631 ) , W02_g59631);
					float4 lerpResult45_g59631 = lerp( tex2D( _Lightmap1, UV12_g59631 ) , tex2D( _Lightmap1, UV02_g59631 ) , W02_g59631);
					float4 lerpResult44_g59631 = lerp( lerpResult46_g59631 , lerpResult45_g59631 , W12_g59631);
					float4 Output_2D_Auto131_g59631 = lerpResult44_g59631;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g59604 = Output_2D_Auto131_g59631;
					#else
					float4 staticSwitch1088_g59604 = tex2D( _Lightmap1, UV12361_g59604 );
					#endif
					float4 Lightmap_1956_g59604 = staticSwitch1088_g59604;
					float Lightmap_Lerp_Value969_g59604 = _LIGHTMAPLERP;
					float4 lerpResult442_g59604 = lerp( Lightmap_0925_g59604 , Lightmap_1956_g59604 , Lightmap_Lerp_Value969_g59604);
					float4 Lightmap_Lerp932_g59604 = lerpResult442_g59604;
					float3 appendResult139_g59650 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float2 temp_output_5_0_g59605 = UV02420_g59604;
					float2 UV633_g59605 = temp_output_5_0_g59605;
					float2 UV100_g59606 = UV633_g59605;
					float2 temp_output_51_0_g59606 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59606 * float2( 3.464,3.464 ) ) );
					float2 break55_g59606 = frac( temp_output_51_0_g59606 );
					float temp_output_56_0_g59606 = ( ( 1.0 - break55_g59606.x ) - break55_g59606.y );
					float2 temp_output_52_0_g59606 = floor( temp_output_51_0_g59606 );
					float2 temp_output_125_0_g59606 = ( temp_output_52_0_g59606 + float2( 1,1 ) );
					float2 ifLocalVar87_g59606 = 0;
					if( temp_output_56_0_g59606 > 0.0 )
					ifLocalVar87_g59606 = temp_output_52_0_g59606;
					else if( temp_output_56_0_g59606 == 0.0 )
					ifLocalVar87_g59606 = temp_output_125_0_g59606;
					else if( temp_output_56_0_g59606 < 0.0 )
					ifLocalVar87_g59606 = temp_output_125_0_g59606;
					float3 temp_output_7_0_g59607 = frac( ( (ifLocalVar87_g59606).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59607 = dot( temp_output_7_0_g59607 , ( (temp_output_7_0_g59607).yzx + 33.33 ) );
					float3 temp_output_12_0_g59607 = ( temp_output_7_0_g59607 + dotResult8_g59607 );
					float2 temp_output_597_0_g59605 = ( UV100_g59606 + frac( ( ( (temp_output_12_0_g59607).xx + (temp_output_12_0_g59607).yz ) * (temp_output_12_0_g59607).zy ) ) );
					float2 DDX631_g59605 = ddx( temp_output_5_0_g59605 );
					float2 DDY632_g59605 = ddy( temp_output_5_0_g59605 );
					float Input_Scale617_g59605 = 1.5;
					float temp_output_65_0_g59606 = ( 0.0 - temp_output_56_0_g59606 );
					float ifLocalVar59_g59606 = 0;
					if( temp_output_56_0_g59606 <= 0.0 )
					ifLocalVar59_g59606 = temp_output_65_0_g59606;
					else
					ifLocalVar59_g59606 = temp_output_56_0_g59606;
					float temp_output_597_30_g59605 = ifLocalVar59_g59606;
					float2 temp_output_90_0_g59606 = ( temp_output_52_0_g59606 + float2( 0,1 ) );
					float2 temp_output_123_0_g59606 = ( temp_output_52_0_g59606 + float2( 1,0 ) );
					float2 ifLocalVar88_g59606 = 0;
					if( temp_output_56_0_g59606 > 0.0 )
					ifLocalVar88_g59606 = temp_output_90_0_g59606;
					else if( temp_output_56_0_g59606 == 0.0 )
					ifLocalVar88_g59606 = temp_output_123_0_g59606;
					else if( temp_output_56_0_g59606 < 0.0 )
					ifLocalVar88_g59606 = temp_output_123_0_g59606;
					float3 temp_output_7_0_g59608 = frac( ( (ifLocalVar88_g59606).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59608 = dot( temp_output_7_0_g59608 , ( (temp_output_7_0_g59608).yzx + 33.33 ) );
					float3 temp_output_12_0_g59608 = ( temp_output_7_0_g59608 + dotResult8_g59608 );
					float2 temp_output_597_26_g59605 = ( UV100_g59606 + frac( ( ( (temp_output_12_0_g59608).xx + (temp_output_12_0_g59608).yz ) * (temp_output_12_0_g59608).zy ) ) );
					float temp_output_66_0_g59606 = ( 1.0 - break55_g59606.y );
					float ifLocalVar60_g59606 = 0;
					if( temp_output_56_0_g59606 <= 0.0 )
					ifLocalVar60_g59606 = temp_output_66_0_g59606;
					else
					ifLocalVar60_g59606 = break55_g59606.y;
					float temp_output_597_28_g59605 = ifLocalVar60_g59606;
					float2 ifLocalVar89_g59606 = 0;
					if( temp_output_56_0_g59606 > 0.0 )
					ifLocalVar89_g59606 = temp_output_123_0_g59606;
					else if( temp_output_56_0_g59606 == 0.0 )
					ifLocalVar89_g59606 = temp_output_90_0_g59606;
					else if( temp_output_56_0_g59606 < 0.0 )
					ifLocalVar89_g59606 = temp_output_90_0_g59606;
					float3 temp_output_7_0_g59609 = frac( ( (ifLocalVar89_g59606).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59609 = dot( temp_output_7_0_g59609 , ( (temp_output_7_0_g59609).yzx + 33.33 ) );
					float3 temp_output_12_0_g59609 = ( temp_output_7_0_g59609 + dotResult8_g59609 );
					float2 temp_output_597_27_g59605 = ( UV100_g59606 + frac( ( ( (temp_output_12_0_g59609).xx + (temp_output_12_0_g59609).yz ) * (temp_output_12_0_g59609).zy ) ) );
					float temp_output_67_0_g59606 = ( 1.0 - break55_g59606.x );
					float ifLocalVar61_g59606 = 0;
					if( temp_output_56_0_g59606 <= 0.0 )
					ifLocalVar61_g59606 = temp_output_67_0_g59606;
					else
					ifLocalVar61_g59606 = break55_g59606.x;
					float temp_output_597_29_g59605 = ifLocalVar61_g59606;
					float3 Output_2D_Normal641_g59605 = ( ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_0_g59605, DDX631_g59605, DDY632_g59605 ), Input_Scale617_g59605 ) * temp_output_597_30_g59605 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_26_g59605, DDX631_g59605, DDY632_g59605 ), Input_Scale617_g59605 ) * temp_output_597_28_g59605 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_27_g59605, DDX631_g59605, DDY632_g59605 ), Input_Scale617_g59605 ) * float3( 0,0,0 ) * temp_output_597_29_g59605 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g59604 = Output_2D_Normal641_g59605;
					#else
					float3 staticSwitch1003_g59604 = UnpackScaleNormal( tex2D( _BumpMap, UV02420_g59604 ), 1.5 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g59604 = staticSwitch1003_g59604;
					#else
					float3 staticSwitch980_g59604 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g59604 = staticSwitch980_g59604;
					float3 normalizeResult326_g59650 = normalize( Normal_Map700_g59604 );
					float3 Normal_Map318_g59650 = normalizeResult326_g59650;
					float dotResult121_g59650 = dot( appendResult139_g59650 , Normal_Map318_g59650 );
					float temp_output_2_0_g59652 = saturate( dotResult121_g59650 );
					float localStochasticTiling2_g59633 = ( 0.0 );
					float2 UV2_g59633 = UV12361_g59604;
					float4 TexelSize2_g59633 = _RNMX0_TexelSize;
					float4 Offsets2_g59633 = float4( 0,0,0,0 );
					float2 Weights2_g59633 = float2( 0,0 );
					{
					UV2_g59633 = UV2_g59633 * TexelSize2_g59633.zw - 0.5;
					float2 f = frac( UV2_g59633 );
					UV2_g59633 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g59633.x - 0.5, UV2_g59633.x + 1.5, UV2_g59633.y - 0.5, UV2_g59633.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g59633 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59633.xyxy;
					Weights2_g59633 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g59632 = Offsets2_g59633;
					float4 Input_FetchOffsets197_g59634 = temp_output_1_34_g59632;
					float2 temp_output_1_54_g59632 = Weights2_g59633;
					float2 Input_FetchWeights200_g59634 = temp_output_1_54_g59632;
					float2 break187_g59634 = Input_FetchWeights200_g59634;
					float4 lerpResult181_g59634 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g59634).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g59634).xw ) , break187_g59634.x);
					float4 lerpResult182_g59634 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g59634).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g59634).xz ) , break187_g59634.x);
					float4 lerpResult176_g59634 = lerp( lerpResult181_g59634 , lerpResult182_g59634 , break187_g59634.y);
					float4 Output_Fetch2D_Auto202_g59634 = lerpResult176_g59634;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g59604 = Output_Fetch2D_Auto202_g59634;
					#else
					float4 staticSwitch1061_g59604 = tex2D( _RNMX0, UV12361_g59604 );
					#endif
					float3 appendResult146_g59650 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59650 = dot( appendResult146_g59650 , Normal_Map318_g59650 );
					float temp_output_2_0_g59651 = saturate( dotResult122_g59650 );
					float4 Input_FetchOffsets197_g59635 = temp_output_1_34_g59632;
					float2 Input_FetchWeights200_g59635 = temp_output_1_54_g59632;
					float2 break187_g59635 = Input_FetchWeights200_g59635;
					float4 lerpResult181_g59635 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g59635).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g59635).xw ) , break187_g59635.x);
					float4 lerpResult182_g59635 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g59635).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g59635).xz ) , break187_g59635.x);
					float4 lerpResult176_g59635 = lerp( lerpResult181_g59635 , lerpResult182_g59635 , break187_g59635.y);
					float4 Output_Fetch2D_Auto202_g59635 = lerpResult176_g59635;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g59604 = Output_Fetch2D_Auto202_g59635;
					#else
					float4 staticSwitch1062_g59604 = tex2D( _RNMY0, UV12361_g59604 );
					#endif
					float3 appendResult149_g59650 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59650 = dot( appendResult149_g59650 , Normal_Map318_g59650 );
					float temp_output_2_0_g59653 = saturate( dotResult120_g59650 );
					float4 Input_FetchOffsets197_g59636 = temp_output_1_34_g59632;
					float2 Input_FetchWeights200_g59636 = temp_output_1_54_g59632;
					float2 break187_g59636 = Input_FetchWeights200_g59636;
					float4 lerpResult181_g59636 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g59636).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g59636).xw ) , break187_g59636.x);
					float4 lerpResult182_g59636 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g59636).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g59636).xz ) , break187_g59636.x);
					float4 lerpResult176_g59636 = lerp( lerpResult181_g59636 , lerpResult182_g59636 , break187_g59636.y);
					float4 Output_Fetch2D_Auto202_g59636 = lerpResult176_g59636;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g59604 = Output_Fetch2D_Auto202_g59636;
					#else
					float4 staticSwitch1063_g59604 = tex2D( _RNMZ0, UV12361_g59604 );
					#endif
					float4 RNM_0926_g59604 = ( ( ( ( ( temp_output_2_0_g59652 * temp_output_2_0_g59652 ) * staticSwitch1061_g59604 ) + ( ( temp_output_2_0_g59651 * temp_output_2_0_g59651 ) * staticSwitch1062_g59604 ) ) + ( ( temp_output_2_0_g59653 * temp_output_2_0_g59653 ) * staticSwitch1063_g59604 ) ) * 2.2 );
					float3 appendResult139_g59646 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g59646 = normalize( Normal_Map700_g59604 );
					float3 Normal_Map318_g59646 = normalizeResult326_g59646;
					float dotResult121_g59646 = dot( appendResult139_g59646 , Normal_Map318_g59646 );
					float temp_output_2_0_g59648 = saturate( dotResult121_g59646 );
					float localStochasticTiling2_g59626 = ( 0.0 );
					float2 UV2_g59626 = UV12361_g59604;
					float4 TexelSize2_g59626 = _RNMX1_TexelSize;
					float4 Offsets2_g59626 = float4( 0,0,0,0 );
					float2 Weights2_g59626 = float2( 0,0 );
					{
					UV2_g59626 = UV2_g59626 * TexelSize2_g59626.zw - 0.5;
					float2 f = frac( UV2_g59626 );
					UV2_g59626 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g59626.x - 0.5, UV2_g59626.x + 1.5, UV2_g59626.y - 0.5, UV2_g59626.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g59626 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59626.xyxy;
					Weights2_g59626 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g59625 = Offsets2_g59626;
					float4 Input_FetchOffsets197_g59627 = temp_output_1_34_g59625;
					float2 temp_output_1_54_g59625 = Weights2_g59626;
					float2 Input_FetchWeights200_g59627 = temp_output_1_54_g59625;
					float2 break187_g59627 = Input_FetchWeights200_g59627;
					float4 lerpResult181_g59627 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g59627).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g59627).xw ) , break187_g59627.x);
					float4 lerpResult182_g59627 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g59627).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g59627).xz ) , break187_g59627.x);
					float4 lerpResult176_g59627 = lerp( lerpResult181_g59627 , lerpResult182_g59627 , break187_g59627.y);
					float4 Output_Fetch2D_Auto202_g59627 = lerpResult176_g59627;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g59604 = Output_Fetch2D_Auto202_g59627;
					#else
					float4 staticSwitch1087_g59604 = tex2D( _RNMX1, UV12361_g59604 );
					#endif
					float3 appendResult146_g59646 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59646 = dot( appendResult146_g59646 , Normal_Map318_g59646 );
					float temp_output_2_0_g59647 = saturate( dotResult122_g59646 );
					float4 Input_FetchOffsets197_g59628 = temp_output_1_34_g59625;
					float2 Input_FetchWeights200_g59628 = temp_output_1_54_g59625;
					float2 break187_g59628 = Input_FetchWeights200_g59628;
					float4 lerpResult181_g59628 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g59628).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g59628).xw ) , break187_g59628.x);
					float4 lerpResult182_g59628 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g59628).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g59628).xz ) , break187_g59628.x);
					float4 lerpResult176_g59628 = lerp( lerpResult181_g59628 , lerpResult182_g59628 , break187_g59628.y);
					float4 Output_Fetch2D_Auto202_g59628 = lerpResult176_g59628;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g59604 = Output_Fetch2D_Auto202_g59628;
					#else
					float4 staticSwitch1083_g59604 = tex2D( _RNMY1, UV12361_g59604 );
					#endif
					float3 appendResult149_g59646 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59646 = dot( appendResult149_g59646 , Normal_Map318_g59646 );
					float temp_output_2_0_g59649 = saturate( dotResult120_g59646 );
					float4 Input_FetchOffsets197_g59629 = temp_output_1_34_g59625;
					float2 Input_FetchWeights200_g59629 = temp_output_1_54_g59625;
					float2 break187_g59629 = Input_FetchWeights200_g59629;
					float4 lerpResult181_g59629 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g59629).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g59629).xw ) , break187_g59629.x);
					float4 lerpResult182_g59629 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g59629).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g59629).xz ) , break187_g59629.x);
					float4 lerpResult176_g59629 = lerp( lerpResult181_g59629 , lerpResult182_g59629 , break187_g59629.y);
					float4 Output_Fetch2D_Auto202_g59629 = lerpResult176_g59629;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g59604 = Output_Fetch2D_Auto202_g59629;
					#else
					float4 staticSwitch1084_g59604 = tex2D( _RNMZ1, UV12361_g59604 );
					#endif
					float4 RNM_11081_g59604 = ( ( ( ( ( temp_output_2_0_g59648 * temp_output_2_0_g59648 ) * staticSwitch1087_g59604 ) + ( ( temp_output_2_0_g59647 * temp_output_2_0_g59647 ) * staticSwitch1083_g59604 ) ) + ( ( temp_output_2_0_g59649 * temp_output_2_0_g59649 ) * staticSwitch1084_g59604 ) ) * 2.2 );
					float4 lerpResult953_g59604 = lerp( RNM_0926_g59604 , RNM_11081_g59604 , Lightmap_Lerp_Value969_g59604);
					float4 RNM_Lerp950_g59604 = lerpResult953_g59604;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g59604 = temp_cast_1;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g59604 = Lightmap_0925_g59604;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g59604 = Lightmap_Lerp932_g59604;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g59604 = RNM_0926_g59604;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g59604 = RNM_Lerp950_g59604;
					#else
					float4 staticSwitch1014_g59604 = temp_cast_1;
					#endif
					float3 Lightmap46_g59604 = (staticSwitch1014_g59604).rgb;
					float3 World_Position2505_g59604 = PositionWS;
					float3 WorldPos1_g59655 = World_Position2505_g59604;
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal2504_g59604 = Normal_Map700_g59604;
					float3 worldNormal2504_g59604 = normalize( float3( dot( tanToWorld0, tanNormal2504_g59604 ), dot( tanToWorld1, tanNormal2504_g59604 ), dot( tanToWorld2, tanNormal2504_g59604 ) ) );
					float3 World_Normal2508_g59604 = worldNormal2504_g59604;
					float3 WorldNormal1_g59655 = World_Normal2508_g59604;
					float3 View_Direction2511_g59604 = ViewDirWS;
					float3 ViewDir1_g59655 = View_Direction2511_g59604;
					float3 temp_cast_3 = (0.04).xxx;
					float3 lerpResult1473_g59604 = lerp( temp_cast_3 , oAlbedo6_g59604 , Metallic1239_g59604);
					float3 switchResult1501_g59604 = (((ase_vface>0)?(World_Normal2508_g59604):(-World_Normal2508_g59604)));
					float dotResult1476_g59604 = dot( switchResult1501_g59604 , View_Direction2511_g59604 );
					float3 lerpResult1480_g59604 = lerp( lerpResult1473_g59604 , float3( 1,1,1 ) , pow( ( 1.0 - saturate( dotResult1476_g59604 ) ) , 5.0 ));
					float3 Fresnel1560_g59604 = lerpResult1480_g59604;
					float4 Fresnel1_g59655 = float4( Fresnel1560_g59604 , 0.0 );
					float2 temp_output_5_0_g59620 = UV02420_g59604;
					float2 UV633_g59620 = temp_output_5_0_g59620;
					float2 UV100_g59621 = UV633_g59620;
					float2 temp_output_51_0_g59621 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59621 * float2( 3.464,3.464 ) ) );
					float2 break55_g59621 = frac( temp_output_51_0_g59621 );
					float temp_output_56_0_g59621 = ( ( 1.0 - break55_g59621.x ) - break55_g59621.y );
					float2 temp_output_52_0_g59621 = floor( temp_output_51_0_g59621 );
					float2 temp_output_125_0_g59621 = ( temp_output_52_0_g59621 + float2( 1,1 ) );
					float2 ifLocalVar87_g59621 = 0;
					if( temp_output_56_0_g59621 > 0.0 )
					ifLocalVar87_g59621 = temp_output_52_0_g59621;
					else if( temp_output_56_0_g59621 == 0.0 )
					ifLocalVar87_g59621 = temp_output_125_0_g59621;
					else if( temp_output_56_0_g59621 < 0.0 )
					ifLocalVar87_g59621 = temp_output_125_0_g59621;
					float3 temp_output_7_0_g59622 = frac( ( (ifLocalVar87_g59621).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59622 = dot( temp_output_7_0_g59622 , ( (temp_output_7_0_g59622).yzx + 33.33 ) );
					float3 temp_output_12_0_g59622 = ( temp_output_7_0_g59622 + dotResult8_g59622 );
					float2 temp_output_597_0_g59620 = ( UV100_g59621 + frac( ( ( (temp_output_12_0_g59622).xx + (temp_output_12_0_g59622).yz ) * (temp_output_12_0_g59622).zy ) ) );
					float2 DDX631_g59620 = ddx( temp_output_5_0_g59620 );
					float2 DDY632_g59620 = ddy( temp_output_5_0_g59620 );
					float temp_output_65_0_g59621 = ( 0.0 - temp_output_56_0_g59621 );
					float ifLocalVar59_g59621 = 0;
					if( temp_output_56_0_g59621 <= 0.0 )
					ifLocalVar59_g59621 = temp_output_65_0_g59621;
					else
					ifLocalVar59_g59621 = temp_output_56_0_g59621;
					float temp_output_597_30_g59620 = ifLocalVar59_g59621;
					float2 temp_output_90_0_g59621 = ( temp_output_52_0_g59621 + float2( 0,1 ) );
					float2 temp_output_123_0_g59621 = ( temp_output_52_0_g59621 + float2( 1,0 ) );
					float2 ifLocalVar88_g59621 = 0;
					if( temp_output_56_0_g59621 > 0.0 )
					ifLocalVar88_g59621 = temp_output_90_0_g59621;
					else if( temp_output_56_0_g59621 == 0.0 )
					ifLocalVar88_g59621 = temp_output_123_0_g59621;
					else if( temp_output_56_0_g59621 < 0.0 )
					ifLocalVar88_g59621 = temp_output_123_0_g59621;
					float3 temp_output_7_0_g59623 = frac( ( (ifLocalVar88_g59621).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59623 = dot( temp_output_7_0_g59623 , ( (temp_output_7_0_g59623).yzx + 33.33 ) );
					float3 temp_output_12_0_g59623 = ( temp_output_7_0_g59623 + dotResult8_g59623 );
					float2 temp_output_597_26_g59620 = ( UV100_g59621 + frac( ( ( (temp_output_12_0_g59623).xx + (temp_output_12_0_g59623).yz ) * (temp_output_12_0_g59623).zy ) ) );
					float temp_output_66_0_g59621 = ( 1.0 - break55_g59621.y );
					float ifLocalVar60_g59621 = 0;
					if( temp_output_56_0_g59621 <= 0.0 )
					ifLocalVar60_g59621 = temp_output_66_0_g59621;
					else
					ifLocalVar60_g59621 = break55_g59621.y;
					float temp_output_597_28_g59620 = ifLocalVar60_g59621;
					float2 ifLocalVar89_g59621 = 0;
					if( temp_output_56_0_g59621 > 0.0 )
					ifLocalVar89_g59621 = temp_output_123_0_g59621;
					else if( temp_output_56_0_g59621 == 0.0 )
					ifLocalVar89_g59621 = temp_output_90_0_g59621;
					else if( temp_output_56_0_g59621 < 0.0 )
					ifLocalVar89_g59621 = temp_output_90_0_g59621;
					float3 temp_output_7_0_g59624 = frac( ( (ifLocalVar89_g59621).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59624 = dot( temp_output_7_0_g59624 , ( (temp_output_7_0_g59624).yzx + 33.33 ) );
					float3 temp_output_12_0_g59624 = ( temp_output_7_0_g59624 + dotResult8_g59624 );
					float2 temp_output_597_27_g59620 = ( UV100_g59621 + frac( ( ( (temp_output_12_0_g59624).xx + (temp_output_12_0_g59624).yz ) * (temp_output_12_0_g59624).zy ) ) );
					float temp_output_67_0_g59621 = ( 1.0 - break55_g59621.x );
					float ifLocalVar61_g59621 = 0;
					if( temp_output_56_0_g59621 <= 0.0 )
					ifLocalVar61_g59621 = temp_output_67_0_g59621;
					else
					ifLocalVar61_g59621 = break55_g59621.x;
					float temp_output_597_29_g59620 = ifLocalVar61_g59621;
					float4 Output_2D293_g59620 = ( ( tex2D( _GlossinessMap, temp_output_597_0_g59620, DDX631_g59620, DDY632_g59620 ) * temp_output_597_30_g59620 ) + ( tex2D( _GlossinessMap, temp_output_597_26_g59620, DDX631_g59620, DDY632_g59620 ) * temp_output_597_28_g59620 ) + ( tex2D( _GlossinessMap, temp_output_597_27_g59620, DDX631_g59620, DDY632_g59620 ) * temp_output_597_29_g59620 ) );
					float4 break31_g59620 = Output_2D293_g59620;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g59604 = break31_g59620.a;
					#else
					float staticSwitch1004_g59604 = tex2D( _GlossinessMap, UV02420_g59604 ).r;
					#endif
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g59604 = ( 1.0 - staticSwitch1004_g59604 );
					#else
					float staticSwitch845_g59604 = _Glossiness;
					#endif
					float temp_output_19_0_g59654 = staticSwitch845_g59604;
					float3 tanNormal2_g59654 = World_Normal2508_g59604;
					float3 worldNormal2_g59654 = float3( dot( tanToWorld0, tanNormal2_g59654 ), dot( tanToWorld1, tanNormal2_g59654 ), dot( tanToWorld2, tanNormal2_g59654 ) );
					float3 temp_output_3_0_g59654 = ddx( worldNormal2_g59654 );
					float dotResult5_g59654 = dot( temp_output_3_0_g59654 , temp_output_3_0_g59654 );
					float3 temp_output_4_0_g59654 = ddy( worldNormal2_g59654 );
					float dotResult6_g59654 = dot( temp_output_4_0_g59654 , temp_output_4_0_g59654 );
					#ifdef _USEGEOMETRICAA_ON
					float staticSwitch15_g59654 = min( temp_output_19_0_g59654, ( 1.0 - pow( saturate( max( dotResult5_g59654, dotResult6_g59654 ) ) , 0.333 ) ) );
					#else
					float staticSwitch15_g59654 = temp_output_19_0_g59654;
					#endif
					float Smoothness1399_g59604 = staticSwitch15_g59654;
					float Smoothness1_g59655 = Smoothness1399_g59604;
					float3 localIndirectGeometricSpecular1_g59655 = IndirectGeometricSpecular1_g59655( WorldPos1_g59655 , WorldNormal1_g59655 , ViewDir1_g59655 , Fresnel1_g59655 , Smoothness1_g59655 );
					float3 temp_output_2565_0_g59604 = localIndirectGeometricSpecular1_g59655;
					float3 temp_cast_5 = (0.02).xxx;
					float3 temp_cast_6 = (0.1).xxx;
					float3 smoothstepResult2430_g59604 = smoothstep( temp_cast_5 , temp_cast_6 , Lightmap46_g59604);
					#ifdef _USELIGHTMAPSPECULAR_ON
					float3 staticSwitch1469_g59604 = ( temp_output_2565_0_g59604 * smoothstepResult2430_g59604 );
					#else
					float3 staticSwitch1469_g59604 = temp_output_2565_0_g59604;
					#endif
					float3 Reflections1419_g59604 = staticSwitch1469_g59604;
					float4 temp_cast_7 = (Black1185_g59604).xxxx;
					float2 temp_output_5_0_g59615 = UV02420_g59604;
					float2 UV633_g59615 = temp_output_5_0_g59615;
					float2 UV100_g59616 = UV633_g59615;
					float2 temp_output_51_0_g59616 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59616 * float2( 3.464,3.464 ) ) );
					float2 break55_g59616 = frac( temp_output_51_0_g59616 );
					float temp_output_56_0_g59616 = ( ( 1.0 - break55_g59616.x ) - break55_g59616.y );
					float2 temp_output_52_0_g59616 = floor( temp_output_51_0_g59616 );
					float2 temp_output_125_0_g59616 = ( temp_output_52_0_g59616 + float2( 1,1 ) );
					float2 ifLocalVar87_g59616 = 0;
					if( temp_output_56_0_g59616 > 0.0 )
					ifLocalVar87_g59616 = temp_output_52_0_g59616;
					else if( temp_output_56_0_g59616 == 0.0 )
					ifLocalVar87_g59616 = temp_output_125_0_g59616;
					else if( temp_output_56_0_g59616 < 0.0 )
					ifLocalVar87_g59616 = temp_output_125_0_g59616;
					float3 temp_output_7_0_g59617 = frac( ( (ifLocalVar87_g59616).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59617 = dot( temp_output_7_0_g59617 , ( (temp_output_7_0_g59617).yzx + 33.33 ) );
					float3 temp_output_12_0_g59617 = ( temp_output_7_0_g59617 + dotResult8_g59617 );
					float2 temp_output_597_0_g59615 = ( UV100_g59616 + frac( ( ( (temp_output_12_0_g59617).xx + (temp_output_12_0_g59617).yz ) * (temp_output_12_0_g59617).zy ) ) );
					float2 DDX631_g59615 = ddx( temp_output_5_0_g59615 );
					float2 DDY632_g59615 = ddy( temp_output_5_0_g59615 );
					float temp_output_65_0_g59616 = ( 0.0 - temp_output_56_0_g59616 );
					float ifLocalVar59_g59616 = 0;
					if( temp_output_56_0_g59616 <= 0.0 )
					ifLocalVar59_g59616 = temp_output_65_0_g59616;
					else
					ifLocalVar59_g59616 = temp_output_56_0_g59616;
					float temp_output_597_30_g59615 = ifLocalVar59_g59616;
					float2 temp_output_90_0_g59616 = ( temp_output_52_0_g59616 + float2( 0,1 ) );
					float2 temp_output_123_0_g59616 = ( temp_output_52_0_g59616 + float2( 1,0 ) );
					float2 ifLocalVar88_g59616 = 0;
					if( temp_output_56_0_g59616 > 0.0 )
					ifLocalVar88_g59616 = temp_output_90_0_g59616;
					else if( temp_output_56_0_g59616 == 0.0 )
					ifLocalVar88_g59616 = temp_output_123_0_g59616;
					else if( temp_output_56_0_g59616 < 0.0 )
					ifLocalVar88_g59616 = temp_output_123_0_g59616;
					float3 temp_output_7_0_g59618 = frac( ( (ifLocalVar88_g59616).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59618 = dot( temp_output_7_0_g59618 , ( (temp_output_7_0_g59618).yzx + 33.33 ) );
					float3 temp_output_12_0_g59618 = ( temp_output_7_0_g59618 + dotResult8_g59618 );
					float2 temp_output_597_26_g59615 = ( UV100_g59616 + frac( ( ( (temp_output_12_0_g59618).xx + (temp_output_12_0_g59618).yz ) * (temp_output_12_0_g59618).zy ) ) );
					float temp_output_66_0_g59616 = ( 1.0 - break55_g59616.y );
					float ifLocalVar60_g59616 = 0;
					if( temp_output_56_0_g59616 <= 0.0 )
					ifLocalVar60_g59616 = temp_output_66_0_g59616;
					else
					ifLocalVar60_g59616 = break55_g59616.y;
					float temp_output_597_28_g59615 = ifLocalVar60_g59616;
					float2 ifLocalVar89_g59616 = 0;
					if( temp_output_56_0_g59616 > 0.0 )
					ifLocalVar89_g59616 = temp_output_123_0_g59616;
					else if( temp_output_56_0_g59616 == 0.0 )
					ifLocalVar89_g59616 = temp_output_90_0_g59616;
					else if( temp_output_56_0_g59616 < 0.0 )
					ifLocalVar89_g59616 = temp_output_90_0_g59616;
					float3 temp_output_7_0_g59619 = frac( ( (ifLocalVar89_g59616).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59619 = dot( temp_output_7_0_g59619 , ( (temp_output_7_0_g59619).yzx + 33.33 ) );
					float3 temp_output_12_0_g59619 = ( temp_output_7_0_g59619 + dotResult8_g59619 );
					float2 temp_output_597_27_g59615 = ( UV100_g59616 + frac( ( ( (temp_output_12_0_g59619).xx + (temp_output_12_0_g59619).yz ) * (temp_output_12_0_g59619).zy ) ) );
					float temp_output_67_0_g59616 = ( 1.0 - break55_g59616.x );
					float ifLocalVar61_g59616 = 0;
					if( temp_output_56_0_g59616 <= 0.0 )
					ifLocalVar61_g59616 = temp_output_67_0_g59616;
					else
					ifLocalVar61_g59616 = break55_g59616.x;
					float temp_output_597_29_g59615 = ifLocalVar61_g59616;
					float4 Output_2D293_g59615 = ( ( tex2D( _EmissionMap, temp_output_597_0_g59615, DDX631_g59615, DDY632_g59615 ) * temp_output_597_30_g59615 ) + ( tex2D( _EmissionMap, temp_output_597_26_g59615, DDX631_g59615, DDY632_g59615 ) * temp_output_597_28_g59615 ) + ( tex2D( _EmissionMap, temp_output_597_27_g59615, DDX631_g59615, DDY632_g59615 ) * temp_output_597_29_g59615 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g59604 = Output_2D293_g59615;
					#else
					float4 staticSwitch1006_g59604 = tex2D( _EmissionMap, UV02420_g59604 );
					#endif
					#if defined( _SPECIALEFFECTS_DISABLED )
					float4 staticSwitch1578_g59604 = staticSwitch1006_g59604;
					#elif defined( _SPECIALEFFECTS_LED )
					float4 staticSwitch1578_g59604 = float4( 0,0,0,0 );
					#else
					float4 staticSwitch1578_g59604 = staticSwitch1006_g59604;
					#endif
					#ifdef _EMISSIONENABLED_ON
					float4 staticSwitch1017_g59604 = ( float4( _EmissionColor , 0.0 ) * staticSwitch1578_g59604 * _EmissionIntensity );
					#else
					float4 staticSwitch1017_g59604 = temp_cast_7;
					#endif
					float3 Emission86_g59604 = (staticSwitch1017_g59604).rgb;
					float3 WorldPos97_g59656 = World_Position2505_g59604;
					float3 WorldNormal97_g59656 = World_Normal2508_g59604;
					float3 LightmapColor97_g59656 = Lightmap46_g59604;
					float3 ViewDir97_g59656 = View_Direction2511_g59604;
					float4 Fresnel97_g59656 = float4( Fresnel1560_g59604 , 0.0 );
					float Smoothness97_g59656 = Smoothness1399_g59604;
					float3 localSpecular97_g59656 = Specular( WorldPos97_g59656 , WorldNormal97_g59656 , LightmapColor97_g59656 , ViewDir97_g59656 , Fresnel97_g59656 , Smoothness97_g59656 );
					float3 Speculars2560_g59604 = localSpecular97_g59656;
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch1181_g59604 = Lightmap46_g59604;
					#else
					float3 staticSwitch1181_g59604 = ( ( aAlbedo1466_g59604 * Lightmap46_g59604 ) + Reflections1419_g59604 + Emission86_g59604 + Speculars2560_g59604 );
					#endif
					float3 temp_output_35_0_g59644 = staticSwitch1181_g59604;
					float3 Color353_g59644 = temp_output_35_0_g59644;
					#if defined( _LUTMODE_2D )
					float3 staticSwitch273_g59644 = saturate( temp_output_35_0_g59644 );
					#elif defined( _LUTMODE_3D )
					float3 staticSwitch273_g59644 = temp_output_35_0_g59644;
					#else
					float3 staticSwitch273_g59644 = temp_output_35_0_g59644;
					#endif
					float3 Color_Saturate49_g59644 = staticSwitch273_g59644;
					float Lut_Height213_g59644 = _LUTSize;
					float Lut_Width216_g59644 = ( _LUTSize * Lut_Height213_g59644 );
					float3 appendResult214_g59644 = (float3(( 1.0 / Lut_Width216_g59644 ) , ( 1.0 / Lut_Height213_g59644 ) , ( Lut_Height213_g59644 - 1.0 )));
					float3 Scale_Offset208_g59644 = appendResult214_g59644;
					float2 Scale_Factor292_g59644 = ( (Scale_Offset208_g59644).xy * (Scale_Offset208_g59644).z );
					float2 Offset299_g59644 = ( (Scale_Offset208_g59644).xy * 0.5 );
					float2 Adjusted_UV305_g59644 = ( ( (Color_Saturate49_g59644).xy * Scale_Factor292_g59644 ) + Offset299_g59644 );
					float Scaled_Blue280_g59644 = ( (Color_Saturate49_g59644).z * (Scale_Offset208_g59644).z );
					float Shift288_g59644 = floor( Scaled_Blue280_g59644 );
					float Final_X313_g59644 = ( (Adjusted_UV305_g59644).x + ( Shift288_g59644 * (Scale_Offset208_g59644).y ) );
					float2 appendResult326_g59644 = (float2(Final_X313_g59644 , (Adjusted_UV305_g59644).y));
					float2 Final_UV325_g59644 = appendResult326_g59644;
					float2 appendResult338_g59644 = (float2((Scale_Offset208_g59644).y , 0.0));
					float2 Offset_UV336_g59644 = ( Final_UV325_g59644 + appendResult338_g59644 );
					float3 lerpResult333_g59644 = lerp( tex2D( _2DLut, Final_UV325_g59644 ).rgb , tex2D( _2DLut, Offset_UV336_g59644 ).rgb , ( Scaled_Blue280_g59644 - Shift288_g59644 ));
					#ifdef _2DLUT
					float3 staticSwitch347_g59644 = lerpResult333_g59644;
					#else
					float3 staticSwitch347_g59644 = Color_Saturate49_g59644;
					#endif
					float3 TwoD_LUT346_g59644 = staticSwitch347_g59644;
					float3 RGB16_g59645 = ( ( log10( ( ( Color_Saturate49_g59644 * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 );
					#ifdef _3DLUT
					float3 staticSwitch194_g59644 = tex3D( _3DLut, RGB16_g59645 ).rgb;
					#else
					float3 staticSwitch194_g59644 = Color_Saturate49_g59644;
					#endif
					float3 ThreeD_LUT51_g59644 = staticSwitch194_g59644;
					#if defined( _LUTMODE_2D )
					float3 staticSwitch42_g59644 = TwoD_LUT346_g59644;
					#elif defined( _LUTMODE_3D )
					float3 staticSwitch42_g59644 = ThreeD_LUT51_g59644;
					#else
					float3 staticSwitch42_g59644 = ThreeD_LUT51_g59644;
					#endif
					#ifdef SHADER_API_MOBILE
					float3 staticSwitch41_g59644 = staticSwitch42_g59644;
					#else
					float3 staticSwitch41_g59644 = Color353_g59644;
					#endif
					
					#ifdef _LIGHTMAPDEBUG
					float staticSwitch1191_g59604 = White38_g59604;
					#else
					float staticSwitch1191_g59604 = staticSwitch1549_g59604.a;
					#endif
					

					o.Albedo = staticSwitch1180_g59604;
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

					o.Emission = staticSwitch41_g59644;
					o.Alpha = staticSwitch1191_g59604;
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
				#pragma shader_feature_local_fragment _MAINTEX
				#pragma shader_feature_local _STOCHASTICENABLED_ON


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
				uniform float4 _UdonSpecularLightDir[32];
				uniform float4 _UdonSpecularLightCol[32];
				uniform float4 _UdonSpecularLightPos[32];
				uniform float4 _UdonSpecularLightRight[32];
				uniform half4 _Color;
				uniform sampler2D _MainTex;
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

					float2 texCoord2357_g59604 = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV02420_g59604 = texCoord2357_g59604;
					float2 temp_output_5_0_g59637 = UV02420_g59604;
					float2 UV633_g59637 = temp_output_5_0_g59637;
					float2 UV100_g59638 = UV633_g59637;
					float2 temp_output_51_0_g59638 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59638 * float2( 3.464,3.464 ) ) );
					float2 break55_g59638 = frac( temp_output_51_0_g59638 );
					float temp_output_56_0_g59638 = ( ( 1.0 - break55_g59638.x ) - break55_g59638.y );
					float2 temp_output_52_0_g59638 = floor( temp_output_51_0_g59638 );
					float2 temp_output_125_0_g59638 = ( temp_output_52_0_g59638 + float2( 1,1 ) );
					float2 ifLocalVar87_g59638 = 0;
					if( temp_output_56_0_g59638 > 0.0 )
					ifLocalVar87_g59638 = temp_output_52_0_g59638;
					else if( temp_output_56_0_g59638 == 0.0 )
					ifLocalVar87_g59638 = temp_output_125_0_g59638;
					else if( temp_output_56_0_g59638 < 0.0 )
					ifLocalVar87_g59638 = temp_output_125_0_g59638;
					float3 temp_output_7_0_g59639 = frac( ( (ifLocalVar87_g59638).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59639 = dot( temp_output_7_0_g59639 , ( (temp_output_7_0_g59639).yzx + 33.33 ) );
					float3 temp_output_12_0_g59639 = ( temp_output_7_0_g59639 + dotResult8_g59639 );
					float2 temp_output_597_0_g59637 = ( UV100_g59638 + frac( ( ( (temp_output_12_0_g59639).xx + (temp_output_12_0_g59639).yz ) * (temp_output_12_0_g59639).zy ) ) );
					float2 DDX631_g59637 = ddx( temp_output_5_0_g59637 );
					float2 DDY632_g59637 = ddy( temp_output_5_0_g59637 );
					float temp_output_65_0_g59638 = ( 0.0 - temp_output_56_0_g59638 );
					float ifLocalVar59_g59638 = 0;
					if( temp_output_56_0_g59638 <= 0.0 )
					ifLocalVar59_g59638 = temp_output_65_0_g59638;
					else
					ifLocalVar59_g59638 = temp_output_56_0_g59638;
					float temp_output_597_30_g59637 = ifLocalVar59_g59638;
					float2 temp_output_90_0_g59638 = ( temp_output_52_0_g59638 + float2( 0,1 ) );
					float2 temp_output_123_0_g59638 = ( temp_output_52_0_g59638 + float2( 1,0 ) );
					float2 ifLocalVar88_g59638 = 0;
					if( temp_output_56_0_g59638 > 0.0 )
					ifLocalVar88_g59638 = temp_output_90_0_g59638;
					else if( temp_output_56_0_g59638 == 0.0 )
					ifLocalVar88_g59638 = temp_output_123_0_g59638;
					else if( temp_output_56_0_g59638 < 0.0 )
					ifLocalVar88_g59638 = temp_output_123_0_g59638;
					float3 temp_output_7_0_g59640 = frac( ( (ifLocalVar88_g59638).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59640 = dot( temp_output_7_0_g59640 , ( (temp_output_7_0_g59640).yzx + 33.33 ) );
					float3 temp_output_12_0_g59640 = ( temp_output_7_0_g59640 + dotResult8_g59640 );
					float2 temp_output_597_26_g59637 = ( UV100_g59638 + frac( ( ( (temp_output_12_0_g59640).xx + (temp_output_12_0_g59640).yz ) * (temp_output_12_0_g59640).zy ) ) );
					float temp_output_66_0_g59638 = ( 1.0 - break55_g59638.y );
					float ifLocalVar60_g59638 = 0;
					if( temp_output_56_0_g59638 <= 0.0 )
					ifLocalVar60_g59638 = temp_output_66_0_g59638;
					else
					ifLocalVar60_g59638 = break55_g59638.y;
					float temp_output_597_28_g59637 = ifLocalVar60_g59638;
					float2 ifLocalVar89_g59638 = 0;
					if( temp_output_56_0_g59638 > 0.0 )
					ifLocalVar89_g59638 = temp_output_123_0_g59638;
					else if( temp_output_56_0_g59638 == 0.0 )
					ifLocalVar89_g59638 = temp_output_90_0_g59638;
					else if( temp_output_56_0_g59638 < 0.0 )
					ifLocalVar89_g59638 = temp_output_90_0_g59638;
					float3 temp_output_7_0_g59641 = frac( ( (ifLocalVar89_g59638).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59641 = dot( temp_output_7_0_g59641 , ( (temp_output_7_0_g59641).yzx + 33.33 ) );
					float3 temp_output_12_0_g59641 = ( temp_output_7_0_g59641 + dotResult8_g59641 );
					float2 temp_output_597_27_g59637 = ( UV100_g59638 + frac( ( ( (temp_output_12_0_g59641).xx + (temp_output_12_0_g59641).yz ) * (temp_output_12_0_g59641).zy ) ) );
					float temp_output_67_0_g59638 = ( 1.0 - break55_g59638.x );
					float ifLocalVar61_g59638 = 0;
					if( temp_output_56_0_g59638 <= 0.0 )
					ifLocalVar61_g59638 = temp_output_67_0_g59638;
					else
					ifLocalVar61_g59638 = break55_g59638.x;
					float temp_output_597_29_g59637 = ifLocalVar61_g59638;
					float4 Output_2D293_g59637 = ( ( tex2D( _MainTex, temp_output_597_0_g59637, DDX631_g59637, DDY632_g59637 ) * temp_output_597_30_g59637 ) + ( tex2D( _MainTex, temp_output_597_26_g59637, DDX631_g59637, DDY632_g59637 ) * temp_output_597_28_g59637 ) + ( tex2D( _MainTex, temp_output_597_27_g59637, DDX631_g59637, DDY632_g59637 ) * temp_output_597_29_g59637 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g59604 = Output_2D293_g59637;
					#else
					float4 staticSwitch1001_g59604 = tex2D( _MainTex, UV02420_g59604 );
					#endif
					#ifdef _MAINTEX
					float4 staticSwitch1549_g59604 = staticSwitch1001_g59604;
					#else
					float4 staticSwitch1549_g59604 = _Color;
					#endif
					float White38_g59604 = 1.0;
					#ifdef _LIGHTMAPDEBUG
					float staticSwitch1191_g59604 = White38_g59604;
					#else
					float staticSwitch1191_g59604 = staticSwitch1549_g59604.a;
					#endif
					

					o.Normal = half3( 0, 0, 1 );

					o.Alpha = staticSwitch1191_g59604;
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
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2954;192,-1200;Inherit;False;Meenphie;0;;59604;b3ba55a08dd6b49c7be16c6f35cf2033;1,1008,1;0;5;FLOAT3;625;FLOAT3;624;FLOAT;156;FLOAT;427;FLOAT3;1024
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2889;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;True;1;LightMode=ForwardAdd;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2890;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2891;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2892;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2893;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2894;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ScenePickingPass;0;7;ScenePickingPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=ScenePickingPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2888;512,-1200;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;12;Meenphie/Standard/Cutout;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardBase;0;1;ForwardBase;17;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;1;False;;True;3;False;;False;False;True;3;RenderType=TransparentCutout=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;44;Category;0;0;  Instanced Terrain Normals;1;0;Workflow;3;639057697570214470;Surface;0;638915427204303550;  Blend;2;638915425920684140;  Dither Shadows;1;0;Two Sided;0;639027460080664250;Alpha Clipping;1;638915427324710130;  Use Shadow Threshold;0;638915420933436960;Deferred Pass;0;638915425282396370;Normal Space;0;0;Transmission;0;638915425258747670;  Transmission Shadow;0.5,False,;0;Translucency;0;638915425246861880;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;1;638922399804812020;Receive Shadows;0;638922399717523500;Receive Specular;0;638915388784334560;Receive Reflections;1;638915388803555030;GPU Instancing;1;638915411619689990;LOD CrossFade;1;0;Built-in Fog;1;0;Ambient Light;0;639049545902984550;Meta Pass;0;639048817054746750;Add Pass;0;639048817051401800;Override Baked GI;0;638915390973737640;Write Depth;0;638915421117196140;Extra Pre Pass;0;639048817123696260;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;0;Vertex Position;1;0;0;8;False;True;False;False;False;True;False;False;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2887;512,-1440;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;True;True;0;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;True;True;1;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;0;False;;True;3;False;;True;False;0;False;;0;False;;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;0;False;0
WireConnection;2888;0;2954;625
WireConnection;2888;2;2954;624
WireConnection;2888;7;2954;156
WireConnection;2888;8;2954;427
ASEEND*/
//CHKSM=89927F4A6FC60E3C37867A6FD1722B8BF1C04934