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
		[NoScaleOffset][SingleLineTexture] _RNMX0( "RNMX 0", 2D ) = "black" {}
		[NoScaleOffset][SingleLineTexture] _RNMY0( "RNMY 0", 2D ) = "black" {}
		[NoScaleOffset][SingleLineTexture] _RNMZ0( "RNMZ 0", 2D ) = "black" {}
		[NoScaleOffset][SingleLineTexture] _RNMX1( "RNMX 1", 2D ) = "black" {}
		[NoScaleOffset][SingleLineTexture] _RNMY1( "RNMY 1", 2D ) = "black" {}
		[NoScaleOffset][SingleLineTexture] _RNMZ1( "RNMZ 1", 2D ) = "black" {}
		_UdonLightmapLerp( "Lightmap Lerp", Range( 0, 1 ) ) = 0
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
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESPECIALEFFECTS( "CATEGORY SPACE SPECIAL EFFECTS", Float ) = 0
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0
		[HideInInspector] GenKey__2DLut( "Assign keyword _2DLUT", Float ) = 1.0
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
				#define _SPECULARHIGHLIGHTS_OFF
				#define ASE_NO_AMBIENT 1
				#define ASE_LIGHTING_SIMPLE 1
				#pragma multi_compile_fog
				#define ASE_FOG
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
				#pragma shader_feature_fragment _LIGHTMAPDEBUG
				#pragma shader_feature_local_fragment _STOCHASTICENABLED_ON
				#pragma shader_feature_local_fragment _MAINTEX
				#pragma shader_feature_local_fragment _METALLICMAP
				#pragma shader_feature_local_fragment _LIGHTMAPMODE_DISABLED _LIGHTMAPMODE_SIMPLE _LIGHTMAPMODE_SIMPLELERP _LIGHTMAPMODE_RNM _LIGHTMAPMODE_RNMLERP
				#pragma shader_feature_local_fragment _USEBICUBICFILTERING_ON
				#pragma shader_feature_local_fragment _BUMPMAP
				#pragma shader_feature_local_fragment _USELIGHTMAPSPECULAR_ON
				#pragma shader_feature_local _USEGEOMETRICAA_ON
				#pragma shader_feature_local_fragment _GLOSSINESSMAP
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
				uniform float _UdonSpecularLightCount;
				uniform float _CATEGORYSPACESURFACEOPTIONS;
				uniform float4 _UdonSpecularLightUp[32];
				uniform float4 _UdonSpecularLightDir[32];
				uniform float4 _UdonSpecularLightCol[32];
				uniform float4 _UdonSpecularLightPos[32];
				uniform float4 _UdonSpecularLightRight[32];
				uniform half4 _Color;
				uniform sampler2D _MainTex;
				sampler2D _Sampler82966_g59903;
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				sampler2D _Sampler82967_g59903;
				uniform sampler2D _Lightmap0;
				float4 _Lightmap0_TexelSize;
				uniform sampler2D _Lightmap1;
				float4 _Lightmap1_TexelSize;
				uniform float _UdonLightmapLerp;
				uniform sampler2D _BumpMap;
				sampler2D _Sampler82965_g59903;
				uniform sampler2D _RNMX0;
				float4 _RNMX0_TexelSize;
				uniform sampler2D _RNMY0;
				uniform sampler2D _RNMZ0;
				uniform sampler2D _RNMX1;
				float4 _RNMX1_TexelSize;
				uniform sampler2D _RNMY1;
				uniform sampler2D _RNMZ1;
				uniform float3 _EmissionColor;
				uniform sampler2D _EmissionMap;
				sampler2D _Sampler82968_g59903;
				uniform float _EmissionIntensity;
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				sampler2D _Sampler82964_g59903;


				float3 IndirectSpecularWithBoxProjection1_g59920( float3 WorldPos, float3 WorldNormal, float3 ViewDir, float3 Fresnel, float Smoothness )
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
				
				float3 Specular( float3 AlbedoColor, float3 LightmapColor, float Metallic, float Smoothness, float3 Fresnel, float3 WorldPos, float3 WorldNormal, float3 ViewDir )
				{
					// --- CONFIGURATION ---
					float LumaStart = 0.02;
					float LumaEnd = 0.4;
					float MaxRadius = 10.0;
					float RadiusFadeStart = 0.0;
					float specBoost = 2.0;
					float3 f0_dielectric = float3(0.2, 0.2, 0.2);
					float3 f0_metal = AlbedoColor.rgb;
					float3 specularColorTint = lerp(f0_dielectric, f0_metal, Metallic);
					float luma = dot(LightmapColor, float3(0.22, 0.70, 0.08));
					float lmMask = saturate((luma - LumaStart) / max(LumaEnd - LumaStart, 0.0001));
					// Fade de distance
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
					    float3 L_center = posRange.xyz - WorldPos;
					    float distSqCenter = dot(L_center, L_center);
					    float3 L_center_norm = L_center * rsqrt(distSqCenter + 0.0001);
					    float theta = dot(-L_center_norm, dirAngle.xyz);
					    float spotMask = saturate((theta - dirAngle.w) / max(0.01, 1.0 - dirAngle.w));
					    if (spotMask > 0.001)
					    {
					        float atten = saturate(1.0 - (distSqCenter / (posRange.w * posRange.w)));
					        if (atten > 0.001)
					        {
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
					return specAccum * specularColorTint * specBoost * Fresnel * radiusFade * lmMask;
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

					float2 texCoord2357_g59903 = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0A2420_g59903 = texCoord2357_g59903;
					#ifdef _MAINTEX
					float4 staticSwitch1549_g59903 = tex2D( _MainTex, UV0A2420_g59903 );
					#else
					float4 staticSwitch1549_g59903 = _Color;
					#endif
					float2 temp_output_5_0_g59940 = UV0A2420_g59903;
					float2 UV633_g59940 = temp_output_5_0_g59940;
					float2 UV100_g59941 = UV633_g59940;
					float2 temp_output_51_0_g59941 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59941 * float2( 3.464,3.464 ) ) );
					float2 break55_g59941 = frac( temp_output_51_0_g59941 );
					float temp_output_56_0_g59941 = ( ( 1.0 - break55_g59941.x ) - break55_g59941.y );
					float2 temp_output_52_0_g59941 = floor( temp_output_51_0_g59941 );
					float2 temp_output_125_0_g59941 = ( temp_output_52_0_g59941 + float2( 1,1 ) );
					float2 ifLocalVar87_g59941 = 0;
					if( temp_output_56_0_g59941 > 0.0 )
					ifLocalVar87_g59941 = temp_output_52_0_g59941;
					else if( temp_output_56_0_g59941 == 0.0 )
					ifLocalVar87_g59941 = temp_output_125_0_g59941;
					else if( temp_output_56_0_g59941 < 0.0 )
					ifLocalVar87_g59941 = temp_output_125_0_g59941;
					float3 temp_output_7_0_g59942 = frac( ( (ifLocalVar87_g59941).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59942 = dot( temp_output_7_0_g59942 , ( (temp_output_7_0_g59942).yzx + 33.33 ) );
					float3 temp_output_12_0_g59942 = ( temp_output_7_0_g59942 + dotResult8_g59942 );
					float2 temp_output_597_0_g59940 = ( UV100_g59941 + frac( ( ( (temp_output_12_0_g59942).xx + (temp_output_12_0_g59942).yz ) * (temp_output_12_0_g59942).zy ) ) );
					float2 DDX631_g59940 = ddx( temp_output_5_0_g59940 );
					float2 DDY632_g59940 = ddy( temp_output_5_0_g59940 );
					float temp_output_65_0_g59941 = ( 0.0 - temp_output_56_0_g59941 );
					float ifLocalVar59_g59941 = 0;
					if( temp_output_56_0_g59941 <= 0.0 )
					ifLocalVar59_g59941 = temp_output_65_0_g59941;
					else
					ifLocalVar59_g59941 = temp_output_56_0_g59941;
					float temp_output_597_30_g59940 = ifLocalVar59_g59941;
					float2 temp_output_90_0_g59941 = ( temp_output_52_0_g59941 + float2( 0,1 ) );
					float2 temp_output_123_0_g59941 = ( temp_output_52_0_g59941 + float2( 1,0 ) );
					float2 ifLocalVar88_g59941 = 0;
					if( temp_output_56_0_g59941 > 0.0 )
					ifLocalVar88_g59941 = temp_output_90_0_g59941;
					else if( temp_output_56_0_g59941 == 0.0 )
					ifLocalVar88_g59941 = temp_output_123_0_g59941;
					else if( temp_output_56_0_g59941 < 0.0 )
					ifLocalVar88_g59941 = temp_output_123_0_g59941;
					float3 temp_output_7_0_g59943 = frac( ( (ifLocalVar88_g59941).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59943 = dot( temp_output_7_0_g59943 , ( (temp_output_7_0_g59943).yzx + 33.33 ) );
					float3 temp_output_12_0_g59943 = ( temp_output_7_0_g59943 + dotResult8_g59943 );
					float2 temp_output_597_26_g59940 = ( UV100_g59941 + frac( ( ( (temp_output_12_0_g59943).xx + (temp_output_12_0_g59943).yz ) * (temp_output_12_0_g59943).zy ) ) );
					float temp_output_66_0_g59941 = ( 1.0 - break55_g59941.y );
					float ifLocalVar60_g59941 = 0;
					if( temp_output_56_0_g59941 <= 0.0 )
					ifLocalVar60_g59941 = temp_output_66_0_g59941;
					else
					ifLocalVar60_g59941 = break55_g59941.y;
					float temp_output_597_28_g59940 = ifLocalVar60_g59941;
					float2 ifLocalVar89_g59941 = 0;
					if( temp_output_56_0_g59941 > 0.0 )
					ifLocalVar89_g59941 = temp_output_123_0_g59941;
					else if( temp_output_56_0_g59941 == 0.0 )
					ifLocalVar89_g59941 = temp_output_90_0_g59941;
					else if( temp_output_56_0_g59941 < 0.0 )
					ifLocalVar89_g59941 = temp_output_90_0_g59941;
					float3 temp_output_7_0_g59944 = frac( ( (ifLocalVar89_g59941).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59944 = dot( temp_output_7_0_g59944 , ( (temp_output_7_0_g59944).yzx + 33.33 ) );
					float3 temp_output_12_0_g59944 = ( temp_output_7_0_g59944 + dotResult8_g59944 );
					float2 temp_output_597_27_g59940 = ( UV100_g59941 + frac( ( ( (temp_output_12_0_g59944).xx + (temp_output_12_0_g59944).yz ) * (temp_output_12_0_g59944).zy ) ) );
					float temp_output_67_0_g59941 = ( 1.0 - break55_g59941.x );
					float ifLocalVar61_g59941 = 0;
					if( temp_output_56_0_g59941 <= 0.0 )
					ifLocalVar61_g59941 = temp_output_67_0_g59941;
					else
					ifLocalVar61_g59941 = break55_g59941.x;
					float temp_output_597_29_g59940 = ifLocalVar61_g59941;
					float4 Output_2D293_g59940 = ( ( tex2D( _Sampler82966_g59903, temp_output_597_0_g59940, DDX631_g59940, DDY632_g59940 ) * temp_output_597_30_g59940 ) + ( tex2D( _Sampler82966_g59903, temp_output_597_26_g59940, DDX631_g59940, DDY632_g59940 ) * temp_output_597_28_g59940 ) + ( tex2D( _Sampler82966_g59903, temp_output_597_27_g59940, DDX631_g59940, DDY632_g59940 ) * temp_output_597_29_g59940 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g59903 = Output_2D293_g59940;
					#else
					float4 staticSwitch1001_g59903 = staticSwitch1549_g59903;
					#endif
					float3 temp_output_2532_0_g59903 = (staticSwitch1001_g59903).rgb;
					float3 oAlbedo6_g59903 = temp_output_2532_0_g59903;
					float Black1185_g59903 = 0.0;
					float3 temp_cast_0 = (Black1185_g59903).xxx;
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch1180_g59903 = temp_cast_0;
					#else
					float3 staticSwitch1180_g59903 = oAlbedo6_g59903;
					#endif
					
					#ifdef _METALLICMAP
					float staticSwitch846_g59903 = tex2D( _MetallicMap, UV0A2420_g59903 ).r;
					#else
					float staticSwitch846_g59903 = _Metallic;
					#endif
					float2 temp_output_5_0_g59935 = UV0A2420_g59903;
					float2 UV633_g59935 = temp_output_5_0_g59935;
					float2 UV100_g59936 = UV633_g59935;
					float2 temp_output_51_0_g59936 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59936 * float2( 3.464,3.464 ) ) );
					float2 break55_g59936 = frac( temp_output_51_0_g59936 );
					float temp_output_56_0_g59936 = ( ( 1.0 - break55_g59936.x ) - break55_g59936.y );
					float2 temp_output_52_0_g59936 = floor( temp_output_51_0_g59936 );
					float2 temp_output_125_0_g59936 = ( temp_output_52_0_g59936 + float2( 1,1 ) );
					float2 ifLocalVar87_g59936 = 0;
					if( temp_output_56_0_g59936 > 0.0 )
					ifLocalVar87_g59936 = temp_output_52_0_g59936;
					else if( temp_output_56_0_g59936 == 0.0 )
					ifLocalVar87_g59936 = temp_output_125_0_g59936;
					else if( temp_output_56_0_g59936 < 0.0 )
					ifLocalVar87_g59936 = temp_output_125_0_g59936;
					float3 temp_output_7_0_g59937 = frac( ( (ifLocalVar87_g59936).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59937 = dot( temp_output_7_0_g59937 , ( (temp_output_7_0_g59937).yzx + 33.33 ) );
					float3 temp_output_12_0_g59937 = ( temp_output_7_0_g59937 + dotResult8_g59937 );
					float2 temp_output_597_0_g59935 = ( UV100_g59936 + frac( ( ( (temp_output_12_0_g59937).xx + (temp_output_12_0_g59937).yz ) * (temp_output_12_0_g59937).zy ) ) );
					float2 DDX631_g59935 = ddx( temp_output_5_0_g59935 );
					float2 DDY632_g59935 = ddy( temp_output_5_0_g59935 );
					float temp_output_65_0_g59936 = ( 0.0 - temp_output_56_0_g59936 );
					float ifLocalVar59_g59936 = 0;
					if( temp_output_56_0_g59936 <= 0.0 )
					ifLocalVar59_g59936 = temp_output_65_0_g59936;
					else
					ifLocalVar59_g59936 = temp_output_56_0_g59936;
					float temp_output_597_30_g59935 = ifLocalVar59_g59936;
					float2 temp_output_90_0_g59936 = ( temp_output_52_0_g59936 + float2( 0,1 ) );
					float2 temp_output_123_0_g59936 = ( temp_output_52_0_g59936 + float2( 1,0 ) );
					float2 ifLocalVar88_g59936 = 0;
					if( temp_output_56_0_g59936 > 0.0 )
					ifLocalVar88_g59936 = temp_output_90_0_g59936;
					else if( temp_output_56_0_g59936 == 0.0 )
					ifLocalVar88_g59936 = temp_output_123_0_g59936;
					else if( temp_output_56_0_g59936 < 0.0 )
					ifLocalVar88_g59936 = temp_output_123_0_g59936;
					float3 temp_output_7_0_g59938 = frac( ( (ifLocalVar88_g59936).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59938 = dot( temp_output_7_0_g59938 , ( (temp_output_7_0_g59938).yzx + 33.33 ) );
					float3 temp_output_12_0_g59938 = ( temp_output_7_0_g59938 + dotResult8_g59938 );
					float2 temp_output_597_26_g59935 = ( UV100_g59936 + frac( ( ( (temp_output_12_0_g59938).xx + (temp_output_12_0_g59938).yz ) * (temp_output_12_0_g59938).zy ) ) );
					float temp_output_66_0_g59936 = ( 1.0 - break55_g59936.y );
					float ifLocalVar60_g59936 = 0;
					if( temp_output_56_0_g59936 <= 0.0 )
					ifLocalVar60_g59936 = temp_output_66_0_g59936;
					else
					ifLocalVar60_g59936 = break55_g59936.y;
					float temp_output_597_28_g59935 = ifLocalVar60_g59936;
					float2 ifLocalVar89_g59936 = 0;
					if( temp_output_56_0_g59936 > 0.0 )
					ifLocalVar89_g59936 = temp_output_123_0_g59936;
					else if( temp_output_56_0_g59936 == 0.0 )
					ifLocalVar89_g59936 = temp_output_90_0_g59936;
					else if( temp_output_56_0_g59936 < 0.0 )
					ifLocalVar89_g59936 = temp_output_90_0_g59936;
					float3 temp_output_7_0_g59939 = frac( ( (ifLocalVar89_g59936).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59939 = dot( temp_output_7_0_g59939 , ( (temp_output_7_0_g59939).yzx + 33.33 ) );
					float3 temp_output_12_0_g59939 = ( temp_output_7_0_g59939 + dotResult8_g59939 );
					float2 temp_output_597_27_g59935 = ( UV100_g59936 + frac( ( ( (temp_output_12_0_g59939).xx + (temp_output_12_0_g59939).yz ) * (temp_output_12_0_g59939).zy ) ) );
					float temp_output_67_0_g59936 = ( 1.0 - break55_g59936.x );
					float ifLocalVar61_g59936 = 0;
					if( temp_output_56_0_g59936 <= 0.0 )
					ifLocalVar61_g59936 = temp_output_67_0_g59936;
					else
					ifLocalVar61_g59936 = break55_g59936.x;
					float temp_output_597_29_g59935 = ifLocalVar61_g59936;
					float4 Output_2D293_g59935 = ( ( tex2D( _Sampler82967_g59903, temp_output_597_0_g59935, DDX631_g59935, DDY632_g59935 ) * temp_output_597_30_g59935 ) + ( tex2D( _Sampler82967_g59903, temp_output_597_26_g59935, DDX631_g59935, DDY632_g59935 ) * temp_output_597_28_g59935 ) + ( tex2D( _Sampler82967_g59903, temp_output_597_27_g59935, DDX631_g59935, DDY632_g59935 ) * temp_output_597_29_g59935 ) );
					float4 break31_g59935 = Output_2D293_g59935;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g59903 = break31_g59935.r;
					#else
					float staticSwitch1005_g59903 = staticSwitch846_g59903;
					#endif
					float Metallic1239_g59903 = staticSwitch1005_g59903;
					float3 aAlbedo1466_g59903 = ( temp_output_2532_0_g59903 * ( 1.0 - Metallic1239_g59903 ) );
					float White38_g59903 = 1.0;
					float4 temp_cast_1 = (White38_g59903).xxxx;
					float4 texCoord2426_g59903 = IN.ase_texcoord6;
					texCoord2426_g59903.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0B2361_g59903 = (texCoord2426_g59903).zw;
					float localBicubicPrepare2_g59917 = ( 0.0 );
					float2 Input_UV100_g59917 = UV0B2361_g59903;
					float2 UV2_g59917 = Input_UV100_g59917;
					float4 TexelSize2_g59917 = _Lightmap0_TexelSize;
					float2 UV02_g59917 = float2( 0,0 );
					float2 UV12_g59917 = float2( 0,0 );
					float2 UV22_g59917 = float2( 0,0 );
					float2 UV32_g59917 = float2( 0,0 );
					float W02_g59917 = 0;
					float W12_g59917 = 0;
					{
					{
					 UV2_g59917 = UV2_g59917 * TexelSize2_g59917.zw - 0.5;
					    float2 f = frac( UV2_g59917 );
					    UV2_g59917 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59917.x - 0.5, UV2_g59917.x + 1.5, UV2_g59917.y - 0.5, UV2_g59917.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59917.xyxy;
					    UV02_g59917 = off.xz;
					    UV12_g59917 = off.yz;
					    UV22_g59917 = off.xw;
					    UV32_g59917 = off.yw;
					    W02_g59917 = s.x / ( s.x + s.y );
					 W12_g59917 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59917 = lerp( tex2D( _Lightmap0, UV32_g59917 ) , tex2D( _Lightmap0, UV22_g59917 ) , W02_g59917);
					float4 lerpResult45_g59917 = lerp( tex2D( _Lightmap0, UV12_g59917 ) , tex2D( _Lightmap0, UV02_g59917 ) , W02_g59917);
					float4 lerpResult44_g59917 = lerp( lerpResult46_g59917 , lerpResult45_g59917 , W12_g59917);
					float4 Output_2D_Auto131_g59917 = lerpResult44_g59917;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g59903 = Output_2D_Auto131_g59917;
					#else
					float4 staticSwitch1092_g59903 = float4( tex2D( _Lightmap0, UV0B2361_g59903 ).rgb , 0.0 );
					#endif
					float4 Lightmap_0925_g59903 = staticSwitch1092_g59903;
					float localBicubicPrepare2_g59910 = ( 0.0 );
					float2 Input_UV100_g59910 = UV0B2361_g59903;
					float2 UV2_g59910 = Input_UV100_g59910;
					float4 TexelSize2_g59910 = _Lightmap1_TexelSize;
					float2 UV02_g59910 = float2( 0,0 );
					float2 UV12_g59910 = float2( 0,0 );
					float2 UV22_g59910 = float2( 0,0 );
					float2 UV32_g59910 = float2( 0,0 );
					float W02_g59910 = 0;
					float W12_g59910 = 0;
					{
					{
					 UV2_g59910 = UV2_g59910 * TexelSize2_g59910.zw - 0.5;
					    float2 f = frac( UV2_g59910 );
					    UV2_g59910 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59910.x - 0.5, UV2_g59910.x + 1.5, UV2_g59910.y - 0.5, UV2_g59910.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59910.xyxy;
					    UV02_g59910 = off.xz;
					    UV12_g59910 = off.yz;
					    UV22_g59910 = off.xw;
					    UV32_g59910 = off.yw;
					    W02_g59910 = s.x / ( s.x + s.y );
					 W12_g59910 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59910 = lerp( tex2D( _Lightmap1, UV32_g59910 ) , tex2D( _Lightmap1, UV22_g59910 ) , W02_g59910);
					float4 lerpResult45_g59910 = lerp( tex2D( _Lightmap1, UV12_g59910 ) , tex2D( _Lightmap1, UV02_g59910 ) , W02_g59910);
					float4 lerpResult44_g59910 = lerp( lerpResult46_g59910 , lerpResult45_g59910 , W12_g59910);
					float4 Output_2D_Auto131_g59910 = lerpResult44_g59910;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g59903 = Output_2D_Auto131_g59910;
					#else
					float4 staticSwitch1088_g59903 = tex2D( _Lightmap1, UV0B2361_g59903 );
					#endif
					float4 Lightmap_1956_g59903 = staticSwitch1088_g59903;
					float Lightmap_Lerp_Value969_g59903 = _UdonLightmapLerp;
					float4 lerpResult442_g59903 = lerp( Lightmap_0925_g59903 , Lightmap_1956_g59903 , Lightmap_Lerp_Value969_g59903);
					float4 Lightmap_Lerp932_g59903 = lerpResult442_g59903;
					float3 appendResult139_g59926 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float2 temp_output_5_0_g59930 = UV0A2420_g59903;
					float2 UV633_g59930 = temp_output_5_0_g59930;
					float2 UV100_g59931 = UV633_g59930;
					float2 temp_output_51_0_g59931 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59931 * float2( 3.464,3.464 ) ) );
					float2 break55_g59931 = frac( temp_output_51_0_g59931 );
					float temp_output_56_0_g59931 = ( ( 1.0 - break55_g59931.x ) - break55_g59931.y );
					float2 temp_output_52_0_g59931 = floor( temp_output_51_0_g59931 );
					float2 temp_output_125_0_g59931 = ( temp_output_52_0_g59931 + float2( 1,1 ) );
					float2 ifLocalVar87_g59931 = 0;
					if( temp_output_56_0_g59931 > 0.0 )
					ifLocalVar87_g59931 = temp_output_52_0_g59931;
					else if( temp_output_56_0_g59931 == 0.0 )
					ifLocalVar87_g59931 = temp_output_125_0_g59931;
					else if( temp_output_56_0_g59931 < 0.0 )
					ifLocalVar87_g59931 = temp_output_125_0_g59931;
					float3 temp_output_7_0_g59932 = frac( ( (ifLocalVar87_g59931).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59932 = dot( temp_output_7_0_g59932 , ( (temp_output_7_0_g59932).yzx + 33.33 ) );
					float3 temp_output_12_0_g59932 = ( temp_output_7_0_g59932 + dotResult8_g59932 );
					float2 temp_output_597_0_g59930 = ( UV100_g59931 + frac( ( ( (temp_output_12_0_g59932).xx + (temp_output_12_0_g59932).yz ) * (temp_output_12_0_g59932).zy ) ) );
					float2 DDX631_g59930 = ddx( temp_output_5_0_g59930 );
					float2 DDY632_g59930 = ddy( temp_output_5_0_g59930 );
					float Input_Scale617_g59930 = 1.5;
					float temp_output_65_0_g59931 = ( 0.0 - temp_output_56_0_g59931 );
					float ifLocalVar59_g59931 = 0;
					if( temp_output_56_0_g59931 <= 0.0 )
					ifLocalVar59_g59931 = temp_output_65_0_g59931;
					else
					ifLocalVar59_g59931 = temp_output_56_0_g59931;
					float temp_output_597_30_g59930 = ifLocalVar59_g59931;
					float2 temp_output_90_0_g59931 = ( temp_output_52_0_g59931 + float2( 0,1 ) );
					float2 temp_output_123_0_g59931 = ( temp_output_52_0_g59931 + float2( 1,0 ) );
					float2 ifLocalVar88_g59931 = 0;
					if( temp_output_56_0_g59931 > 0.0 )
					ifLocalVar88_g59931 = temp_output_90_0_g59931;
					else if( temp_output_56_0_g59931 == 0.0 )
					ifLocalVar88_g59931 = temp_output_123_0_g59931;
					else if( temp_output_56_0_g59931 < 0.0 )
					ifLocalVar88_g59931 = temp_output_123_0_g59931;
					float3 temp_output_7_0_g59933 = frac( ( (ifLocalVar88_g59931).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59933 = dot( temp_output_7_0_g59933 , ( (temp_output_7_0_g59933).yzx + 33.33 ) );
					float3 temp_output_12_0_g59933 = ( temp_output_7_0_g59933 + dotResult8_g59933 );
					float2 temp_output_597_26_g59930 = ( UV100_g59931 + frac( ( ( (temp_output_12_0_g59933).xx + (temp_output_12_0_g59933).yz ) * (temp_output_12_0_g59933).zy ) ) );
					float temp_output_66_0_g59931 = ( 1.0 - break55_g59931.y );
					float ifLocalVar60_g59931 = 0;
					if( temp_output_56_0_g59931 <= 0.0 )
					ifLocalVar60_g59931 = temp_output_66_0_g59931;
					else
					ifLocalVar60_g59931 = break55_g59931.y;
					float temp_output_597_28_g59930 = ifLocalVar60_g59931;
					float2 ifLocalVar89_g59931 = 0;
					if( temp_output_56_0_g59931 > 0.0 )
					ifLocalVar89_g59931 = temp_output_123_0_g59931;
					else if( temp_output_56_0_g59931 == 0.0 )
					ifLocalVar89_g59931 = temp_output_90_0_g59931;
					else if( temp_output_56_0_g59931 < 0.0 )
					ifLocalVar89_g59931 = temp_output_90_0_g59931;
					float3 temp_output_7_0_g59934 = frac( ( (ifLocalVar89_g59931).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59934 = dot( temp_output_7_0_g59934 , ( (temp_output_7_0_g59934).yzx + 33.33 ) );
					float3 temp_output_12_0_g59934 = ( temp_output_7_0_g59934 + dotResult8_g59934 );
					float2 temp_output_597_27_g59930 = ( UV100_g59931 + frac( ( ( (temp_output_12_0_g59934).xx + (temp_output_12_0_g59934).yz ) * (temp_output_12_0_g59934).zy ) ) );
					float temp_output_67_0_g59931 = ( 1.0 - break55_g59931.x );
					float ifLocalVar61_g59931 = 0;
					if( temp_output_56_0_g59931 <= 0.0 )
					ifLocalVar61_g59931 = temp_output_67_0_g59931;
					else
					ifLocalVar61_g59931 = break55_g59931.x;
					float temp_output_597_29_g59930 = ifLocalVar61_g59931;
					float3 Output_2D_Normal641_g59930 = ( ( UnpackScaleNormal( tex2D( _Sampler82965_g59903, temp_output_597_0_g59930, DDX631_g59930, DDY632_g59930 ), Input_Scale617_g59930 ) * temp_output_597_30_g59930 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g59903, temp_output_597_26_g59930, DDX631_g59930, DDY632_g59930 ), Input_Scale617_g59930 ) * temp_output_597_28_g59930 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g59903, temp_output_597_27_g59930, DDX631_g59930, DDY632_g59930 ), Input_Scale617_g59930 ) * float3( 0,0,0 ) * temp_output_597_29_g59930 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g59903 = Output_2D_Normal641_g59930;
					#else
					float3 staticSwitch1003_g59903 = UnpackScaleNormal( tex2D( _BumpMap, UV0A2420_g59903 ), 1.5 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g59903 = staticSwitch1003_g59903;
					#else
					float3 staticSwitch980_g59903 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g59903 = staticSwitch980_g59903;
					float3 normalizeResult326_g59926 = normalize( Normal_Map700_g59903 );
					float3 Normal_Map318_g59926 = normalizeResult326_g59926;
					float dotResult121_g59926 = dot( appendResult139_g59926 , Normal_Map318_g59926 );
					float temp_output_2_0_g59928 = saturate( dotResult121_g59926 );
					float localStochasticTiling2_g59912 = ( 0.0 );
					float2 UV2_g59912 = UV0B2361_g59903;
					float4 TexelSize2_g59912 = _RNMX0_TexelSize;
					float4 Offsets2_g59912 = float4( 0,0,0,0 );
					float2 Weights2_g59912 = float2( 0,0 );
					{
					UV2_g59912 = UV2_g59912 * TexelSize2_g59912.zw - 0.5;
					float2 f = frac( UV2_g59912 );
					UV2_g59912 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g59912.x - 0.5, UV2_g59912.x + 1.5, UV2_g59912.y - 0.5, UV2_g59912.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g59912 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59912.xyxy;
					Weights2_g59912 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g59911 = Offsets2_g59912;
					float4 Input_FetchOffsets197_g59913 = temp_output_1_34_g59911;
					float2 temp_output_1_54_g59911 = Weights2_g59912;
					float2 Input_FetchWeights200_g59913 = temp_output_1_54_g59911;
					float2 break187_g59913 = Input_FetchWeights200_g59913;
					float4 lerpResult181_g59913 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g59913).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g59913).xw ) , break187_g59913.x);
					float4 lerpResult182_g59913 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g59913).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g59913).xz ) , break187_g59913.x);
					float4 lerpResult176_g59913 = lerp( lerpResult181_g59913 , lerpResult182_g59913 , break187_g59913.y);
					float4 Output_Fetch2D_Auto202_g59913 = lerpResult176_g59913;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g59903 = Output_Fetch2D_Auto202_g59913;
					#else
					float4 staticSwitch1061_g59903 = tex2D( _RNMX0, UV0B2361_g59903 );
					#endif
					float3 appendResult146_g59926 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59926 = dot( appendResult146_g59926 , Normal_Map318_g59926 );
					float temp_output_2_0_g59927 = saturate( dotResult122_g59926 );
					float4 Input_FetchOffsets197_g59914 = temp_output_1_34_g59911;
					float2 Input_FetchWeights200_g59914 = temp_output_1_54_g59911;
					float2 break187_g59914 = Input_FetchWeights200_g59914;
					float4 lerpResult181_g59914 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g59914).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g59914).xw ) , break187_g59914.x);
					float4 lerpResult182_g59914 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g59914).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g59914).xz ) , break187_g59914.x);
					float4 lerpResult176_g59914 = lerp( lerpResult181_g59914 , lerpResult182_g59914 , break187_g59914.y);
					float4 Output_Fetch2D_Auto202_g59914 = lerpResult176_g59914;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g59903 = Output_Fetch2D_Auto202_g59914;
					#else
					float4 staticSwitch1062_g59903 = tex2D( _RNMY0, UV0B2361_g59903 );
					#endif
					float3 appendResult149_g59926 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59926 = dot( appendResult149_g59926 , Normal_Map318_g59926 );
					float temp_output_2_0_g59929 = saturate( dotResult120_g59926 );
					float4 Input_FetchOffsets197_g59915 = temp_output_1_34_g59911;
					float2 Input_FetchWeights200_g59915 = temp_output_1_54_g59911;
					float2 break187_g59915 = Input_FetchWeights200_g59915;
					float4 lerpResult181_g59915 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g59915).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g59915).xw ) , break187_g59915.x);
					float4 lerpResult182_g59915 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g59915).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g59915).xz ) , break187_g59915.x);
					float4 lerpResult176_g59915 = lerp( lerpResult181_g59915 , lerpResult182_g59915 , break187_g59915.y);
					float4 Output_Fetch2D_Auto202_g59915 = lerpResult176_g59915;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g59903 = Output_Fetch2D_Auto202_g59915;
					#else
					float4 staticSwitch1063_g59903 = tex2D( _RNMZ0, UV0B2361_g59903 );
					#endif
					float4 RNM_0926_g59903 = ( ( ( ( ( temp_output_2_0_g59928 * temp_output_2_0_g59928 ) * staticSwitch1061_g59903 ) + ( ( temp_output_2_0_g59927 * temp_output_2_0_g59927 ) * staticSwitch1062_g59903 ) ) + ( ( temp_output_2_0_g59929 * temp_output_2_0_g59929 ) * staticSwitch1063_g59903 ) ) * 1.5 );
					float3 appendResult139_g59922 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g59922 = normalize( Normal_Map700_g59903 );
					float3 Normal_Map318_g59922 = normalizeResult326_g59922;
					float dotResult121_g59922 = dot( appendResult139_g59922 , Normal_Map318_g59922 );
					float temp_output_2_0_g59924 = saturate( dotResult121_g59922 );
					float localStochasticTiling2_g59905 = ( 0.0 );
					float2 UV2_g59905 = UV0B2361_g59903;
					float4 TexelSize2_g59905 = _RNMX1_TexelSize;
					float4 Offsets2_g59905 = float4( 0,0,0,0 );
					float2 Weights2_g59905 = float2( 0,0 );
					{
					UV2_g59905 = UV2_g59905 * TexelSize2_g59905.zw - 0.5;
					float2 f = frac( UV2_g59905 );
					UV2_g59905 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g59905.x - 0.5, UV2_g59905.x + 1.5, UV2_g59905.y - 0.5, UV2_g59905.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g59905 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59905.xyxy;
					Weights2_g59905 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g59904 = Offsets2_g59905;
					float4 Input_FetchOffsets197_g59906 = temp_output_1_34_g59904;
					float2 temp_output_1_54_g59904 = Weights2_g59905;
					float2 Input_FetchWeights200_g59906 = temp_output_1_54_g59904;
					float2 break187_g59906 = Input_FetchWeights200_g59906;
					float4 lerpResult181_g59906 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g59906).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g59906).xw ) , break187_g59906.x);
					float4 lerpResult182_g59906 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g59906).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g59906).xz ) , break187_g59906.x);
					float4 lerpResult176_g59906 = lerp( lerpResult181_g59906 , lerpResult182_g59906 , break187_g59906.y);
					float4 Output_Fetch2D_Auto202_g59906 = lerpResult176_g59906;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g59903 = Output_Fetch2D_Auto202_g59906;
					#else
					float4 staticSwitch1087_g59903 = tex2D( _RNMX1, UV0B2361_g59903 );
					#endif
					float3 appendResult146_g59922 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59922 = dot( appendResult146_g59922 , Normal_Map318_g59922 );
					float temp_output_2_0_g59923 = saturate( dotResult122_g59922 );
					float4 Input_FetchOffsets197_g59907 = temp_output_1_34_g59904;
					float2 Input_FetchWeights200_g59907 = temp_output_1_54_g59904;
					float2 break187_g59907 = Input_FetchWeights200_g59907;
					float4 lerpResult181_g59907 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g59907).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g59907).xw ) , break187_g59907.x);
					float4 lerpResult182_g59907 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g59907).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g59907).xz ) , break187_g59907.x);
					float4 lerpResult176_g59907 = lerp( lerpResult181_g59907 , lerpResult182_g59907 , break187_g59907.y);
					float4 Output_Fetch2D_Auto202_g59907 = lerpResult176_g59907;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g59903 = Output_Fetch2D_Auto202_g59907;
					#else
					float4 staticSwitch1083_g59903 = tex2D( _RNMY1, UV0B2361_g59903 );
					#endif
					float3 appendResult149_g59922 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59922 = dot( appendResult149_g59922 , Normal_Map318_g59922 );
					float temp_output_2_0_g59925 = saturate( dotResult120_g59922 );
					float4 Input_FetchOffsets197_g59908 = temp_output_1_34_g59904;
					float2 Input_FetchWeights200_g59908 = temp_output_1_54_g59904;
					float2 break187_g59908 = Input_FetchWeights200_g59908;
					float4 lerpResult181_g59908 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g59908).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g59908).xw ) , break187_g59908.x);
					float4 lerpResult182_g59908 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g59908).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g59908).xz ) , break187_g59908.x);
					float4 lerpResult176_g59908 = lerp( lerpResult181_g59908 , lerpResult182_g59908 , break187_g59908.y);
					float4 Output_Fetch2D_Auto202_g59908 = lerpResult176_g59908;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g59903 = Output_Fetch2D_Auto202_g59908;
					#else
					float4 staticSwitch1084_g59903 = tex2D( _RNMZ1, UV0B2361_g59903 );
					#endif
					float4 RNM_11081_g59903 = ( ( ( ( ( temp_output_2_0_g59924 * temp_output_2_0_g59924 ) * staticSwitch1087_g59903 ) + ( ( temp_output_2_0_g59923 * temp_output_2_0_g59923 ) * staticSwitch1083_g59903 ) ) + ( ( temp_output_2_0_g59925 * temp_output_2_0_g59925 ) * staticSwitch1084_g59903 ) ) * 1.5 );
					float4 lerpResult953_g59903 = lerp( RNM_0926_g59903 , RNM_11081_g59903 , Lightmap_Lerp_Value969_g59903);
					float4 RNM_Lerp950_g59903 = lerpResult953_g59903;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g59903 = temp_cast_1;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g59903 = Lightmap_0925_g59903;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g59903 = Lightmap_Lerp932_g59903;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g59903 = RNM_0926_g59903;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g59903 = RNM_Lerp950_g59903;
					#else
					float4 staticSwitch1014_g59903 = temp_cast_1;
					#endif
					float3 Lightmap46_g59903 = (staticSwitch1014_g59903).rgb;
					float2 temp_output_5_0_g59951 = UV0A2420_g59903;
					float2 UV633_g59951 = temp_output_5_0_g59951;
					float2 UV100_g59952 = UV633_g59951;
					float2 temp_output_51_0_g59952 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59952 * float2( 3.464,3.464 ) ) );
					float2 break55_g59952 = frac( temp_output_51_0_g59952 );
					float temp_output_56_0_g59952 = ( ( 1.0 - break55_g59952.x ) - break55_g59952.y );
					float2 temp_output_52_0_g59952 = floor( temp_output_51_0_g59952 );
					float2 temp_output_125_0_g59952 = ( temp_output_52_0_g59952 + float2( 1,1 ) );
					float2 ifLocalVar87_g59952 = 0;
					if( temp_output_56_0_g59952 > 0.0 )
					ifLocalVar87_g59952 = temp_output_52_0_g59952;
					else if( temp_output_56_0_g59952 == 0.0 )
					ifLocalVar87_g59952 = temp_output_125_0_g59952;
					else if( temp_output_56_0_g59952 < 0.0 )
					ifLocalVar87_g59952 = temp_output_125_0_g59952;
					float3 temp_output_7_0_g59953 = frac( ( (ifLocalVar87_g59952).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59953 = dot( temp_output_7_0_g59953 , ( (temp_output_7_0_g59953).yzx + 33.33 ) );
					float3 temp_output_12_0_g59953 = ( temp_output_7_0_g59953 + dotResult8_g59953 );
					float2 temp_output_597_0_g59951 = ( UV100_g59952 + frac( ( ( (temp_output_12_0_g59953).xx + (temp_output_12_0_g59953).yz ) * (temp_output_12_0_g59953).zy ) ) );
					float2 DDX631_g59951 = ddx( temp_output_5_0_g59951 );
					float2 DDY632_g59951 = ddy( temp_output_5_0_g59951 );
					float temp_output_65_0_g59952 = ( 0.0 - temp_output_56_0_g59952 );
					float ifLocalVar59_g59952 = 0;
					if( temp_output_56_0_g59952 <= 0.0 )
					ifLocalVar59_g59952 = temp_output_65_0_g59952;
					else
					ifLocalVar59_g59952 = temp_output_56_0_g59952;
					float temp_output_597_30_g59951 = ifLocalVar59_g59952;
					float2 temp_output_90_0_g59952 = ( temp_output_52_0_g59952 + float2( 0,1 ) );
					float2 temp_output_123_0_g59952 = ( temp_output_52_0_g59952 + float2( 1,0 ) );
					float2 ifLocalVar88_g59952 = 0;
					if( temp_output_56_0_g59952 > 0.0 )
					ifLocalVar88_g59952 = temp_output_90_0_g59952;
					else if( temp_output_56_0_g59952 == 0.0 )
					ifLocalVar88_g59952 = temp_output_123_0_g59952;
					else if( temp_output_56_0_g59952 < 0.0 )
					ifLocalVar88_g59952 = temp_output_123_0_g59952;
					float3 temp_output_7_0_g59954 = frac( ( (ifLocalVar88_g59952).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59954 = dot( temp_output_7_0_g59954 , ( (temp_output_7_0_g59954).yzx + 33.33 ) );
					float3 temp_output_12_0_g59954 = ( temp_output_7_0_g59954 + dotResult8_g59954 );
					float2 temp_output_597_26_g59951 = ( UV100_g59952 + frac( ( ( (temp_output_12_0_g59954).xx + (temp_output_12_0_g59954).yz ) * (temp_output_12_0_g59954).zy ) ) );
					float temp_output_66_0_g59952 = ( 1.0 - break55_g59952.y );
					float ifLocalVar60_g59952 = 0;
					if( temp_output_56_0_g59952 <= 0.0 )
					ifLocalVar60_g59952 = temp_output_66_0_g59952;
					else
					ifLocalVar60_g59952 = break55_g59952.y;
					float temp_output_597_28_g59951 = ifLocalVar60_g59952;
					float2 ifLocalVar89_g59952 = 0;
					if( temp_output_56_0_g59952 > 0.0 )
					ifLocalVar89_g59952 = temp_output_123_0_g59952;
					else if( temp_output_56_0_g59952 == 0.0 )
					ifLocalVar89_g59952 = temp_output_90_0_g59952;
					else if( temp_output_56_0_g59952 < 0.0 )
					ifLocalVar89_g59952 = temp_output_90_0_g59952;
					float3 temp_output_7_0_g59955 = frac( ( (ifLocalVar89_g59952).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59955 = dot( temp_output_7_0_g59955 , ( (temp_output_7_0_g59955).yzx + 33.33 ) );
					float3 temp_output_12_0_g59955 = ( temp_output_7_0_g59955 + dotResult8_g59955 );
					float2 temp_output_597_27_g59951 = ( UV100_g59952 + frac( ( ( (temp_output_12_0_g59955).xx + (temp_output_12_0_g59955).yz ) * (temp_output_12_0_g59955).zy ) ) );
					float temp_output_67_0_g59952 = ( 1.0 - break55_g59952.x );
					float ifLocalVar61_g59952 = 0;
					if( temp_output_56_0_g59952 <= 0.0 )
					ifLocalVar61_g59952 = temp_output_67_0_g59952;
					else
					ifLocalVar61_g59952 = break55_g59952.x;
					float temp_output_597_29_g59951 = ifLocalVar61_g59952;
					float4 Output_2D293_g59951 = ( ( tex2D( _Sampler82968_g59903, temp_output_597_0_g59951, DDX631_g59951, DDY632_g59951 ) * temp_output_597_30_g59951 ) + ( tex2D( _Sampler82968_g59903, temp_output_597_26_g59951, DDX631_g59951, DDY632_g59951 ) * temp_output_597_28_g59951 ) + ( tex2D( _Sampler82968_g59903, temp_output_597_27_g59951, DDX631_g59951, DDY632_g59951 ) * temp_output_597_29_g59951 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g59903 = Output_2D293_g59951;
					#else
					float4 staticSwitch1006_g59903 = tex2D( _EmissionMap, UV0A2420_g59903 );
					#endif
					float3 temp_output_2531_0_g59903 = (( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g59903 * _EmissionIntensity )).rgb;
					float3 Emission86_g59903 = temp_output_2531_0_g59903;
					float3 World_Position2505_g59903 = PositionWS;
					float3 WorldPos1_g59920 = World_Position2505_g59903;
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal2504_g59903 = Normal_Map700_g59903;
					float3 worldNormal2504_g59903 = normalize( float3( dot( tanToWorld0, tanNormal2504_g59903 ), dot( tanToWorld1, tanNormal2504_g59903 ), dot( tanToWorld2, tanNormal2504_g59903 ) ) );
					float3 World_Normal2508_g59903 = worldNormal2504_g59903;
					float3 WorldNormal1_g59920 = World_Normal2508_g59903;
					float3 View_Direction2511_g59903 = ViewDirWS;
					float3 ViewDir1_g59920 = View_Direction2511_g59903;
					float3 temp_cast_4 = (0.04).xxx;
					float3 lerpResult1473_g59903 = lerp( temp_cast_4 , oAlbedo6_g59903 , Metallic1239_g59903);
					float3 switchResult1501_g59903 = (((ase_vface>0)?(World_Normal2508_g59903):(-World_Normal2508_g59903)));
					float dotResult1476_g59903 = dot( switchResult1501_g59903 , View_Direction2511_g59903 );
					float3 lerpResult1480_g59903 = lerp( lerpResult1473_g59903 , float3( 1,1,1 ) , pow( ( 1.0 - saturate( dotResult1476_g59903 ) ) , 5.0 ));
					float3 Fresnel1560_g59903 = lerpResult1480_g59903;
					float3 Fresnel1_g59920 = Fresnel1560_g59903;
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g59903 = tex2D( _GlossinessMap, UV0A2420_g59903 ).r;
					#else
					float staticSwitch845_g59903 = _Glossiness;
					#endif
					float2 temp_output_5_0_g59945 = UV0A2420_g59903;
					float2 UV633_g59945 = temp_output_5_0_g59945;
					float2 UV100_g59946 = UV633_g59945;
					float2 temp_output_51_0_g59946 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59946 * float2( 3.464,3.464 ) ) );
					float2 break55_g59946 = frac( temp_output_51_0_g59946 );
					float temp_output_56_0_g59946 = ( ( 1.0 - break55_g59946.x ) - break55_g59946.y );
					float2 temp_output_52_0_g59946 = floor( temp_output_51_0_g59946 );
					float2 temp_output_125_0_g59946 = ( temp_output_52_0_g59946 + float2( 1,1 ) );
					float2 ifLocalVar87_g59946 = 0;
					if( temp_output_56_0_g59946 > 0.0 )
					ifLocalVar87_g59946 = temp_output_52_0_g59946;
					else if( temp_output_56_0_g59946 == 0.0 )
					ifLocalVar87_g59946 = temp_output_125_0_g59946;
					else if( temp_output_56_0_g59946 < 0.0 )
					ifLocalVar87_g59946 = temp_output_125_0_g59946;
					float3 temp_output_7_0_g59947 = frac( ( (ifLocalVar87_g59946).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59947 = dot( temp_output_7_0_g59947 , ( (temp_output_7_0_g59947).yzx + 33.33 ) );
					float3 temp_output_12_0_g59947 = ( temp_output_7_0_g59947 + dotResult8_g59947 );
					float2 temp_output_597_0_g59945 = ( UV100_g59946 + frac( ( ( (temp_output_12_0_g59947).xx + (temp_output_12_0_g59947).yz ) * (temp_output_12_0_g59947).zy ) ) );
					float2 DDX631_g59945 = ddx( temp_output_5_0_g59945 );
					float2 DDY632_g59945 = ddy( temp_output_5_0_g59945 );
					float temp_output_65_0_g59946 = ( 0.0 - temp_output_56_0_g59946 );
					float ifLocalVar59_g59946 = 0;
					if( temp_output_56_0_g59946 <= 0.0 )
					ifLocalVar59_g59946 = temp_output_65_0_g59946;
					else
					ifLocalVar59_g59946 = temp_output_56_0_g59946;
					float temp_output_597_30_g59945 = ifLocalVar59_g59946;
					float2 temp_output_90_0_g59946 = ( temp_output_52_0_g59946 + float2( 0,1 ) );
					float2 temp_output_123_0_g59946 = ( temp_output_52_0_g59946 + float2( 1,0 ) );
					float2 ifLocalVar88_g59946 = 0;
					if( temp_output_56_0_g59946 > 0.0 )
					ifLocalVar88_g59946 = temp_output_90_0_g59946;
					else if( temp_output_56_0_g59946 == 0.0 )
					ifLocalVar88_g59946 = temp_output_123_0_g59946;
					else if( temp_output_56_0_g59946 < 0.0 )
					ifLocalVar88_g59946 = temp_output_123_0_g59946;
					float3 temp_output_7_0_g59948 = frac( ( (ifLocalVar88_g59946).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59948 = dot( temp_output_7_0_g59948 , ( (temp_output_7_0_g59948).yzx + 33.33 ) );
					float3 temp_output_12_0_g59948 = ( temp_output_7_0_g59948 + dotResult8_g59948 );
					float2 temp_output_597_26_g59945 = ( UV100_g59946 + frac( ( ( (temp_output_12_0_g59948).xx + (temp_output_12_0_g59948).yz ) * (temp_output_12_0_g59948).zy ) ) );
					float temp_output_66_0_g59946 = ( 1.0 - break55_g59946.y );
					float ifLocalVar60_g59946 = 0;
					if( temp_output_56_0_g59946 <= 0.0 )
					ifLocalVar60_g59946 = temp_output_66_0_g59946;
					else
					ifLocalVar60_g59946 = break55_g59946.y;
					float temp_output_597_28_g59945 = ifLocalVar60_g59946;
					float2 ifLocalVar89_g59946 = 0;
					if( temp_output_56_0_g59946 > 0.0 )
					ifLocalVar89_g59946 = temp_output_123_0_g59946;
					else if( temp_output_56_0_g59946 == 0.0 )
					ifLocalVar89_g59946 = temp_output_90_0_g59946;
					else if( temp_output_56_0_g59946 < 0.0 )
					ifLocalVar89_g59946 = temp_output_90_0_g59946;
					float3 temp_output_7_0_g59949 = frac( ( (ifLocalVar89_g59946).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59949 = dot( temp_output_7_0_g59949 , ( (temp_output_7_0_g59949).yzx + 33.33 ) );
					float3 temp_output_12_0_g59949 = ( temp_output_7_0_g59949 + dotResult8_g59949 );
					float2 temp_output_597_27_g59945 = ( UV100_g59946 + frac( ( ( (temp_output_12_0_g59949).xx + (temp_output_12_0_g59949).yz ) * (temp_output_12_0_g59949).zy ) ) );
					float temp_output_67_0_g59946 = ( 1.0 - break55_g59946.x );
					float ifLocalVar61_g59946 = 0;
					if( temp_output_56_0_g59946 <= 0.0 )
					ifLocalVar61_g59946 = temp_output_67_0_g59946;
					else
					ifLocalVar61_g59946 = break55_g59946.x;
					float temp_output_597_29_g59945 = ifLocalVar61_g59946;
					float4 Output_2D293_g59945 = ( ( tex2D( _Sampler82964_g59903, temp_output_597_0_g59945, DDX631_g59945, DDY632_g59945 ) * temp_output_597_30_g59945 ) + ( tex2D( _Sampler82964_g59903, temp_output_597_26_g59945, DDX631_g59945, DDY632_g59945 ) * temp_output_597_28_g59945 ) + ( tex2D( _Sampler82964_g59903, temp_output_597_27_g59945, DDX631_g59945, DDY632_g59945 ) * temp_output_597_29_g59945 ) );
					float4 break31_g59945 = Output_2D293_g59945;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g59903 = ( 1.0 - break31_g59945.r );
					#else
					float staticSwitch1004_g59903 = ( 1.0 - staticSwitch845_g59903 );
					#endif
					float temp_output_19_0_g59950 = staticSwitch1004_g59903;
					float3 tanNormal2_g59950 = World_Normal2508_g59903;
					float3 worldNormal2_g59950 = float3( dot( tanToWorld0, tanNormal2_g59950 ), dot( tanToWorld1, tanNormal2_g59950 ), dot( tanToWorld2, tanNormal2_g59950 ) );
					float3 temp_output_3_0_g59950 = ddx( worldNormal2_g59950 );
					float dotResult5_g59950 = dot( temp_output_3_0_g59950 , temp_output_3_0_g59950 );
					float3 temp_output_4_0_g59950 = ddy( worldNormal2_g59950 );
					float dotResult6_g59950 = dot( temp_output_4_0_g59950 , temp_output_4_0_g59950 );
					#ifdef _USEGEOMETRICAA_ON
					float staticSwitch15_g59950 = min( temp_output_19_0_g59950, ( 1.0 - pow( saturate( max( dotResult5_g59950, dotResult6_g59950 ) ) , 0.333 ) ) );
					#else
					float staticSwitch15_g59950 = temp_output_19_0_g59950;
					#endif
					float Smoothness1399_g59903 = staticSwitch15_g59950;
					float Smoothness1_g59920 = Smoothness1399_g59903;
					float3 localIndirectSpecularWithBoxProjection1_g59920 = IndirectSpecularWithBoxProjection1_g59920( WorldPos1_g59920 , WorldNormal1_g59920 , ViewDir1_g59920 , Fresnel1_g59920 , Smoothness1_g59920 );
					float3 temp_output_2578_0_g59903 = localIndirectSpecularWithBoxProjection1_g59920;
					float3 temp_cast_5 = (0.02).xxx;
					float3 temp_cast_6 = (0.1).xxx;
					float3 smoothstepResult2430_g59903 = smoothstep( temp_cast_5 , temp_cast_6 , Lightmap46_g59903);
					#ifdef _USELIGHTMAPSPECULAR_ON
					float3 staticSwitch1469_g59903 = ( temp_output_2578_0_g59903 * smoothstepResult2430_g59903 );
					#else
					float3 staticSwitch1469_g59903 = temp_output_2578_0_g59903;
					#endif
					float3 Reflections1419_g59903 = staticSwitch1469_g59903;
					float3 AlbedoColor97_g59921 = oAlbedo6_g59903;
					float3 LightmapColor97_g59921 = Lightmap46_g59903;
					float Metallic97_g59921 = Metallic1239_g59903;
					float Smoothness97_g59921 = Smoothness1399_g59903;
					float3 Fresnel97_g59921 = Fresnel1560_g59903;
					float3 WorldPos97_g59921 = World_Position2505_g59903;
					float3 WorldNormal97_g59921 = World_Normal2508_g59903;
					float3 ViewDir97_g59921 = View_Direction2511_g59903;
					float3 localSpecular97_g59921 = Specular( AlbedoColor97_g59921 , LightmapColor97_g59921 , Metallic97_g59921 , Smoothness97_g59921 , Fresnel97_g59921 , WorldPos97_g59921 , WorldNormal97_g59921 , ViewDir97_g59921 );
					float3 Speculars2560_g59903 = localSpecular97_g59921;
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch1181_g59903 = Lightmap46_g59903;
					#else
					float3 staticSwitch1181_g59903 = ( ( aAlbedo1466_g59903 * Lightmap46_g59903 ) + Emission86_g59903 + Reflections1419_g59903 + Speculars2560_g59903 );
					#endif
					float3 temp_output_35_0_g59918 = staticSwitch1181_g59903;
					float3 Color353_g59918 = temp_output_35_0_g59918;
					#if defined( _LUTMODE_2D )
					float3 staticSwitch273_g59918 = saturate( temp_output_35_0_g59918 );
					#elif defined( _LUTMODE_3D )
					float3 staticSwitch273_g59918 = temp_output_35_0_g59918;
					#else
					float3 staticSwitch273_g59918 = temp_output_35_0_g59918;
					#endif
					float3 Color_Saturate49_g59918 = staticSwitch273_g59918;
					float Lut_Height213_g59918 = _LUTSize;
					float Lut_Width216_g59918 = ( _LUTSize * Lut_Height213_g59918 );
					float3 appendResult214_g59918 = (float3(( 1.0 / Lut_Width216_g59918 ) , ( 1.0 / Lut_Height213_g59918 ) , ( Lut_Height213_g59918 - 1.0 )));
					float3 Scale_Offset208_g59918 = appendResult214_g59918;
					float2 Scale_Factor292_g59918 = ( (Scale_Offset208_g59918).xy * (Scale_Offset208_g59918).z );
					float2 Offset299_g59918 = ( (Scale_Offset208_g59918).xy * 0.5 );
					float2 Adjusted_UV305_g59918 = ( ( (Color_Saturate49_g59918).xy * Scale_Factor292_g59918 ) + Offset299_g59918 );
					float Scaled_Blue280_g59918 = ( (Color_Saturate49_g59918).z * (Scale_Offset208_g59918).z );
					float Shift288_g59918 = floor( Scaled_Blue280_g59918 );
					float Final_X313_g59918 = ( (Adjusted_UV305_g59918).x + ( Shift288_g59918 * (Scale_Offset208_g59918).y ) );
					float2 appendResult326_g59918 = (float2(Final_X313_g59918 , (Adjusted_UV305_g59918).y));
					float2 Final_UV325_g59918 = appendResult326_g59918;
					float2 appendResult338_g59918 = (float2((Scale_Offset208_g59918).y , 0.0));
					float2 Offset_UV336_g59918 = ( Final_UV325_g59918 + appendResult338_g59918 );
					float3 lerpResult333_g59918 = lerp( tex2D( _2DLut, Final_UV325_g59918 ).rgb , tex2D( _2DLut, Offset_UV336_g59918 ).rgb , ( Scaled_Blue280_g59918 - Shift288_g59918 ));
					#ifdef _2DLUT
					float3 staticSwitch347_g59918 = lerpResult333_g59918;
					#else
					float3 staticSwitch347_g59918 = Color_Saturate49_g59918;
					#endif
					float3 TwoD_LUT346_g59918 = staticSwitch347_g59918;
					float3 RGB16_g59919 = ( ( log10( ( ( Color_Saturate49_g59918 * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 );
					#ifdef _3DLUT
					float3 staticSwitch194_g59918 = tex3D( _3DLut, RGB16_g59919 ).rgb;
					#else
					float3 staticSwitch194_g59918 = Color_Saturate49_g59918;
					#endif
					float3 ThreeD_LUT51_g59918 = staticSwitch194_g59918;
					#if defined( _LUTMODE_2D )
					float3 staticSwitch42_g59918 = TwoD_LUT346_g59918;
					#elif defined( _LUTMODE_3D )
					float3 staticSwitch42_g59918 = ThreeD_LUT51_g59918;
					#else
					float3 staticSwitch42_g59918 = ThreeD_LUT51_g59918;
					#endif
					#ifdef SHADER_API_MOBILE
					float3 staticSwitch41_g59918 = staticSwitch42_g59918;
					#else
					float3 staticSwitch41_g59918 = Color353_g59918;
					#endif
					

					o.Albedo = staticSwitch1180_g59903;
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

					o.Emission = staticSwitch41_g59918;
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
				#define ASE_FOG
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
				uniform float _CATEGORYSPACESURFACEOPTIONS;
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
				#define ASE_FOG
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
				uniform float _UdonSpecularLightCount;
				uniform float _CATEGORYSPACESURFACEOPTIONS;
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
				#define _SPECULARHIGHLIGHTS_OFF
				#define ASE_NO_AMBIENT 1
				#define ASE_LIGHTING_SIMPLE 1
				#define ASE_FOG
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
				uniform float _UdonSpecularLightCount;
				uniform float _CATEGORYSPACESURFACEOPTIONS;
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
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5509;-64,-1280;Inherit;False;Meenphie;0;;59903;b3ba55a08dd6b49c7be16c6f35cf2033;5,1008,0,2632,0,2619,0,2635,0,2636,0;0;5;FLOAT3;625;FLOAT3;624;FLOAT;156;FLOAT;427;FLOAT;1024
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5279;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5280;256,-1280;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;5;Meenphie/Standard/Opaque;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardBase;0;1;ForwardBase;17;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;True;True;0;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;44;Category;0;0;  Instanced Terrain Normals;1;0;Workflow;3;639079749420714040;Surface;0;0;  Blend;0;0;  Dither Shadows;1;0;Two Sided;1;0;Alpha Clipping;0;0;  Use Shadow Threshold;0;0;Deferred Pass;0;639079951064078170;Normal Space;0;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;1;0;Receive Shadows;1;0;Receive Specular;0;639079748971954060;Receive Reflections;1;639079891103345210;GPU Instancing;1;0;LOD CrossFade;1;0;Built-in Fog;1;639105044169342440;Ambient Light;0;639079749088921010;Meta Pass;0;639079749085366090;Add Pass;0;639079749082074320;Override Baked GI;0;0;Write Depth;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;0;Vertex Position;1;0;0;8;False;True;False;False;False;True;True;True;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5281;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;True;1;LightMode=ForwardAdd;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5282;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5283;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5284;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5285;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5286;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ScenePickingPass;0;7;ScenePickingPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=Picking;False;False;0;;0;0;Standard;0;False;0
WireConnection;5280;0;5509;625
WireConnection;5280;2;5509;624
ASEEND*/
//CHKSM=20AB993261FFDDC1CFF52E46DF357BD1BB2B2A74