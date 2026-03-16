// Made with Amplify Shader Editor v1.9.9.7
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Standard/Transparent Blend"
{
	Properties
	{
		[Meenphie_DrawerCategory(SURFACE OPTIONS,true,0,0)] _CATEGORY_SURFACEOPTIONS( "CATEGORY_SURFACEOPTIONS", Float ) = 1
		_Color( "DIffuse Color", Color ) = ( 0.9058824, 0.9058824, 0.9058824, 1 )
		[NoScaleOffset][SingleLineTexture] _MainTex( "Diffuse Map", 2D ) = "white" {}
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
		[HideInInspector] GenKey__2DLut( "Assign keyword _2DLUT", Float ) = 1.0
		[HideInInspector] GenKey__MainTex( "Assign keyword _MAINTEX", Float ) = 1.0
		[HideInInspector] GenKey__MetallicMap( "Assign keyword _METALLICMAP", Float ) = 1.0
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
		

		

		Tags { "RenderType"="Transparent" "Queue"="Transparent" "DisableBatching"="False" }

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

			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
				#define ASE_GEOMETRY
				#define _ALPHABLEND_ON 1
				#define ASE_FRAGMENT_NORMAL 0
				#define ASE_RECEIVE_SHADOWS
				#pragma multi_compile_instancing
				#pragma multi_compile _ LOD_FADE_CROSSFADE
				#pragma multi_compile_fog
				#define ASE_FOG
				#define ASE_LIGHTING_SIMPLE 1
				#define ASE_NO_AMBIENT 1
				#define _SPECULARHIGHLIGHTS_OFF
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


				float3 IndirectGeometricSpecular1_g59606( float3 WorldPos, float3 WorldNormal, float3 ViewDir, float4 Fresnel, float Smoothness )
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

					float2 texCoord2357_g59553 = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV02420_g59553 = texCoord2357_g59553;
					float2 temp_output_5_0_g59586 = UV02420_g59553;
					float2 UV633_g59586 = temp_output_5_0_g59586;
					float2 UV100_g59587 = UV633_g59586;
					float2 temp_output_51_0_g59587 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59587 * float2( 3.464,3.464 ) ) );
					float2 break55_g59587 = frac( temp_output_51_0_g59587 );
					float temp_output_56_0_g59587 = ( ( 1.0 - break55_g59587.x ) - break55_g59587.y );
					float2 temp_output_52_0_g59587 = floor( temp_output_51_0_g59587 );
					float2 temp_output_125_0_g59587 = ( temp_output_52_0_g59587 + float2( 1,1 ) );
					float2 ifLocalVar87_g59587 = 0;
					if( temp_output_56_0_g59587 > 0.0 )
					ifLocalVar87_g59587 = temp_output_52_0_g59587;
					else if( temp_output_56_0_g59587 == 0.0 )
					ifLocalVar87_g59587 = temp_output_125_0_g59587;
					else if( temp_output_56_0_g59587 < 0.0 )
					ifLocalVar87_g59587 = temp_output_125_0_g59587;
					float3 temp_output_7_0_g59588 = frac( ( (ifLocalVar87_g59587).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59588 = dot( temp_output_7_0_g59588 , ( (temp_output_7_0_g59588).yzx + 33.33 ) );
					float3 temp_output_12_0_g59588 = ( temp_output_7_0_g59588 + dotResult8_g59588 );
					float2 temp_output_597_0_g59586 = ( UV100_g59587 + frac( ( ( (temp_output_12_0_g59588).xx + (temp_output_12_0_g59588).yz ) * (temp_output_12_0_g59588).zy ) ) );
					float2 DDX631_g59586 = ddx( temp_output_5_0_g59586 );
					float2 DDY632_g59586 = ddy( temp_output_5_0_g59586 );
					float temp_output_65_0_g59587 = ( 0.0 - temp_output_56_0_g59587 );
					float ifLocalVar59_g59587 = 0;
					if( temp_output_56_0_g59587 <= 0.0 )
					ifLocalVar59_g59587 = temp_output_65_0_g59587;
					else
					ifLocalVar59_g59587 = temp_output_56_0_g59587;
					float temp_output_597_30_g59586 = ifLocalVar59_g59587;
					float2 temp_output_90_0_g59587 = ( temp_output_52_0_g59587 + float2( 0,1 ) );
					float2 temp_output_123_0_g59587 = ( temp_output_52_0_g59587 + float2( 1,0 ) );
					float2 ifLocalVar88_g59587 = 0;
					if( temp_output_56_0_g59587 > 0.0 )
					ifLocalVar88_g59587 = temp_output_90_0_g59587;
					else if( temp_output_56_0_g59587 == 0.0 )
					ifLocalVar88_g59587 = temp_output_123_0_g59587;
					else if( temp_output_56_0_g59587 < 0.0 )
					ifLocalVar88_g59587 = temp_output_123_0_g59587;
					float3 temp_output_7_0_g59589 = frac( ( (ifLocalVar88_g59587).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59589 = dot( temp_output_7_0_g59589 , ( (temp_output_7_0_g59589).yzx + 33.33 ) );
					float3 temp_output_12_0_g59589 = ( temp_output_7_0_g59589 + dotResult8_g59589 );
					float2 temp_output_597_26_g59586 = ( UV100_g59587 + frac( ( ( (temp_output_12_0_g59589).xx + (temp_output_12_0_g59589).yz ) * (temp_output_12_0_g59589).zy ) ) );
					float temp_output_66_0_g59587 = ( 1.0 - break55_g59587.y );
					float ifLocalVar60_g59587 = 0;
					if( temp_output_56_0_g59587 <= 0.0 )
					ifLocalVar60_g59587 = temp_output_66_0_g59587;
					else
					ifLocalVar60_g59587 = break55_g59587.y;
					float temp_output_597_28_g59586 = ifLocalVar60_g59587;
					float2 ifLocalVar89_g59587 = 0;
					if( temp_output_56_0_g59587 > 0.0 )
					ifLocalVar89_g59587 = temp_output_123_0_g59587;
					else if( temp_output_56_0_g59587 == 0.0 )
					ifLocalVar89_g59587 = temp_output_90_0_g59587;
					else if( temp_output_56_0_g59587 < 0.0 )
					ifLocalVar89_g59587 = temp_output_90_0_g59587;
					float3 temp_output_7_0_g59590 = frac( ( (ifLocalVar89_g59587).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59590 = dot( temp_output_7_0_g59590 , ( (temp_output_7_0_g59590).yzx + 33.33 ) );
					float3 temp_output_12_0_g59590 = ( temp_output_7_0_g59590 + dotResult8_g59590 );
					float2 temp_output_597_27_g59586 = ( UV100_g59587 + frac( ( ( (temp_output_12_0_g59590).xx + (temp_output_12_0_g59590).yz ) * (temp_output_12_0_g59590).zy ) ) );
					float temp_output_67_0_g59587 = ( 1.0 - break55_g59587.x );
					float ifLocalVar61_g59587 = 0;
					if( temp_output_56_0_g59587 <= 0.0 )
					ifLocalVar61_g59587 = temp_output_67_0_g59587;
					else
					ifLocalVar61_g59587 = break55_g59587.x;
					float temp_output_597_29_g59586 = ifLocalVar61_g59587;
					float4 Output_2D293_g59586 = ( ( tex2D( _MainTex, temp_output_597_0_g59586, DDX631_g59586, DDY632_g59586 ) * temp_output_597_30_g59586 ) + ( tex2D( _MainTex, temp_output_597_26_g59586, DDX631_g59586, DDY632_g59586 ) * temp_output_597_28_g59586 ) + ( tex2D( _MainTex, temp_output_597_27_g59586, DDX631_g59586, DDY632_g59586 ) * temp_output_597_29_g59586 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g59553 = Output_2D293_g59586;
					#else
					float4 staticSwitch1001_g59553 = tex2D( _MainTex, UV02420_g59553 );
					#endif
					#ifdef _MAINTEX
					float4 staticSwitch1549_g59553 = staticSwitch1001_g59553;
					#else
					float4 staticSwitch1549_g59553 = _Color;
					#endif
					float3 temp_output_2532_0_g59553 = (staticSwitch1549_g59553).rgb;
					float3 oAlbedo6_g59553 = temp_output_2532_0_g59553;
					float Black1185_g59553 = 0.0;
					float3 temp_cast_0 = (Black1185_g59553).xxx;
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch1180_g59553 = temp_cast_0;
					#else
					float3 staticSwitch1180_g59553 = oAlbedo6_g59553;
					#endif
					
					float2 temp_output_5_0_g59559 = UV02420_g59553;
					float2 UV633_g59559 = temp_output_5_0_g59559;
					float2 UV100_g59560 = UV633_g59559;
					float2 temp_output_51_0_g59560 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59560 * float2( 3.464,3.464 ) ) );
					float2 break55_g59560 = frac( temp_output_51_0_g59560 );
					float temp_output_56_0_g59560 = ( ( 1.0 - break55_g59560.x ) - break55_g59560.y );
					float2 temp_output_52_0_g59560 = floor( temp_output_51_0_g59560 );
					float2 temp_output_125_0_g59560 = ( temp_output_52_0_g59560 + float2( 1,1 ) );
					float2 ifLocalVar87_g59560 = 0;
					if( temp_output_56_0_g59560 > 0.0 )
					ifLocalVar87_g59560 = temp_output_52_0_g59560;
					else if( temp_output_56_0_g59560 == 0.0 )
					ifLocalVar87_g59560 = temp_output_125_0_g59560;
					else if( temp_output_56_0_g59560 < 0.0 )
					ifLocalVar87_g59560 = temp_output_125_0_g59560;
					float3 temp_output_7_0_g59561 = frac( ( (ifLocalVar87_g59560).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59561 = dot( temp_output_7_0_g59561 , ( (temp_output_7_0_g59561).yzx + 33.33 ) );
					float3 temp_output_12_0_g59561 = ( temp_output_7_0_g59561 + dotResult8_g59561 );
					float2 temp_output_597_0_g59559 = ( UV100_g59560 + frac( ( ( (temp_output_12_0_g59561).xx + (temp_output_12_0_g59561).yz ) * (temp_output_12_0_g59561).zy ) ) );
					float2 DDX631_g59559 = ddx( temp_output_5_0_g59559 );
					float2 DDY632_g59559 = ddy( temp_output_5_0_g59559 );
					float temp_output_65_0_g59560 = ( 0.0 - temp_output_56_0_g59560 );
					float ifLocalVar59_g59560 = 0;
					if( temp_output_56_0_g59560 <= 0.0 )
					ifLocalVar59_g59560 = temp_output_65_0_g59560;
					else
					ifLocalVar59_g59560 = temp_output_56_0_g59560;
					float temp_output_597_30_g59559 = ifLocalVar59_g59560;
					float2 temp_output_90_0_g59560 = ( temp_output_52_0_g59560 + float2( 0,1 ) );
					float2 temp_output_123_0_g59560 = ( temp_output_52_0_g59560 + float2( 1,0 ) );
					float2 ifLocalVar88_g59560 = 0;
					if( temp_output_56_0_g59560 > 0.0 )
					ifLocalVar88_g59560 = temp_output_90_0_g59560;
					else if( temp_output_56_0_g59560 == 0.0 )
					ifLocalVar88_g59560 = temp_output_123_0_g59560;
					else if( temp_output_56_0_g59560 < 0.0 )
					ifLocalVar88_g59560 = temp_output_123_0_g59560;
					float3 temp_output_7_0_g59562 = frac( ( (ifLocalVar88_g59560).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59562 = dot( temp_output_7_0_g59562 , ( (temp_output_7_0_g59562).yzx + 33.33 ) );
					float3 temp_output_12_0_g59562 = ( temp_output_7_0_g59562 + dotResult8_g59562 );
					float2 temp_output_597_26_g59559 = ( UV100_g59560 + frac( ( ( (temp_output_12_0_g59562).xx + (temp_output_12_0_g59562).yz ) * (temp_output_12_0_g59562).zy ) ) );
					float temp_output_66_0_g59560 = ( 1.0 - break55_g59560.y );
					float ifLocalVar60_g59560 = 0;
					if( temp_output_56_0_g59560 <= 0.0 )
					ifLocalVar60_g59560 = temp_output_66_0_g59560;
					else
					ifLocalVar60_g59560 = break55_g59560.y;
					float temp_output_597_28_g59559 = ifLocalVar60_g59560;
					float2 ifLocalVar89_g59560 = 0;
					if( temp_output_56_0_g59560 > 0.0 )
					ifLocalVar89_g59560 = temp_output_123_0_g59560;
					else if( temp_output_56_0_g59560 == 0.0 )
					ifLocalVar89_g59560 = temp_output_90_0_g59560;
					else if( temp_output_56_0_g59560 < 0.0 )
					ifLocalVar89_g59560 = temp_output_90_0_g59560;
					float3 temp_output_7_0_g59563 = frac( ( (ifLocalVar89_g59560).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59563 = dot( temp_output_7_0_g59563 , ( (temp_output_7_0_g59563).yzx + 33.33 ) );
					float3 temp_output_12_0_g59563 = ( temp_output_7_0_g59563 + dotResult8_g59563 );
					float2 temp_output_597_27_g59559 = ( UV100_g59560 + frac( ( ( (temp_output_12_0_g59563).xx + (temp_output_12_0_g59563).yz ) * (temp_output_12_0_g59563).zy ) ) );
					float temp_output_67_0_g59560 = ( 1.0 - break55_g59560.x );
					float ifLocalVar61_g59560 = 0;
					if( temp_output_56_0_g59560 <= 0.0 )
					ifLocalVar61_g59560 = temp_output_67_0_g59560;
					else
					ifLocalVar61_g59560 = break55_g59560.x;
					float temp_output_597_29_g59559 = ifLocalVar61_g59560;
					float4 Output_2D293_g59559 = ( ( tex2D( _MetallicMap, temp_output_597_0_g59559, DDX631_g59559, DDY632_g59559 ) * temp_output_597_30_g59559 ) + ( tex2D( _MetallicMap, temp_output_597_26_g59559, DDX631_g59559, DDY632_g59559 ) * temp_output_597_28_g59559 ) + ( tex2D( _MetallicMap, temp_output_597_27_g59559, DDX631_g59559, DDY632_g59559 ) * temp_output_597_29_g59559 ) );
					float4 break31_g59559 = Output_2D293_g59559;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g59553 = break31_g59559.a;
					#else
					float staticSwitch1005_g59553 = tex2D( _MetallicMap, UV02420_g59553 ).a;
					#endif
					#ifdef _METALLICMAP
					float staticSwitch846_g59553 = staticSwitch1005_g59553;
					#else
					float staticSwitch846_g59553 = _Metallic;
					#endif
					float Metallic1239_g59553 = staticSwitch846_g59553;
					float3 aAlbedo1466_g59553 = ( temp_output_2532_0_g59553 * ( 1.0 - Metallic1239_g59553 ) );
					float White38_g59553 = 1.0;
					float4 temp_cast_1 = (White38_g59553).xxxx;
					float4 texCoord2426_g59553 = IN.ase_texcoord6;
					texCoord2426_g59553.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV12361_g59553 = (texCoord2426_g59553).zw;
					float localBicubicPrepare2_g59592 = ( 0.0 );
					float2 Input_UV100_g59592 = UV12361_g59553;
					float2 UV2_g59592 = Input_UV100_g59592;
					float4 TexelSize2_g59592 = _Lightmap0_TexelSize;
					float2 UV02_g59592 = float2( 0,0 );
					float2 UV12_g59592 = float2( 0,0 );
					float2 UV22_g59592 = float2( 0,0 );
					float2 UV32_g59592 = float2( 0,0 );
					float W02_g59592 = 0;
					float W12_g59592 = 0;
					{
					{
					 UV2_g59592 = UV2_g59592 * TexelSize2_g59592.zw - 0.5;
					    float2 f = frac( UV2_g59592 );
					    UV2_g59592 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59592.x - 0.5, UV2_g59592.x + 1.5, UV2_g59592.y - 0.5, UV2_g59592.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59592.xyxy;
					    UV02_g59592 = off.xz;
					    UV12_g59592 = off.yz;
					    UV22_g59592 = off.xw;
					    UV32_g59592 = off.yw;
					    W02_g59592 = s.x / ( s.x + s.y );
					 W12_g59592 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59592 = lerp( tex2D( _Lightmap0, UV32_g59592 ) , tex2D( _Lightmap0, UV22_g59592 ) , W02_g59592);
					float4 lerpResult45_g59592 = lerp( tex2D( _Lightmap0, UV12_g59592 ) , tex2D( _Lightmap0, UV02_g59592 ) , W02_g59592);
					float4 lerpResult44_g59592 = lerp( lerpResult46_g59592 , lerpResult45_g59592 , W12_g59592);
					float4 Output_2D_Auto131_g59592 = lerpResult44_g59592;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g59553 = Output_2D_Auto131_g59592;
					#else
					float4 staticSwitch1092_g59553 = float4( tex2D( _Lightmap0, UV12361_g59553 ).rgb , 0.0 );
					#endif
					float4 Lightmap_0925_g59553 = staticSwitch1092_g59553;
					float localBicubicPrepare2_g59580 = ( 0.0 );
					float2 Input_UV100_g59580 = UV12361_g59553;
					float2 UV2_g59580 = Input_UV100_g59580;
					float4 TexelSize2_g59580 = _Lightmap1_TexelSize;
					float2 UV02_g59580 = float2( 0,0 );
					float2 UV12_g59580 = float2( 0,0 );
					float2 UV22_g59580 = float2( 0,0 );
					float2 UV32_g59580 = float2( 0,0 );
					float W02_g59580 = 0;
					float W12_g59580 = 0;
					{
					{
					 UV2_g59580 = UV2_g59580 * TexelSize2_g59580.zw - 0.5;
					    float2 f = frac( UV2_g59580 );
					    UV2_g59580 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59580.x - 0.5, UV2_g59580.x + 1.5, UV2_g59580.y - 0.5, UV2_g59580.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59580.xyxy;
					    UV02_g59580 = off.xz;
					    UV12_g59580 = off.yz;
					    UV22_g59580 = off.xw;
					    UV32_g59580 = off.yw;
					    W02_g59580 = s.x / ( s.x + s.y );
					 W12_g59580 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59580 = lerp( tex2D( _Lightmap1, UV32_g59580 ) , tex2D( _Lightmap1, UV22_g59580 ) , W02_g59580);
					float4 lerpResult45_g59580 = lerp( tex2D( _Lightmap1, UV12_g59580 ) , tex2D( _Lightmap1, UV02_g59580 ) , W02_g59580);
					float4 lerpResult44_g59580 = lerp( lerpResult46_g59580 , lerpResult45_g59580 , W12_g59580);
					float4 Output_2D_Auto131_g59580 = lerpResult44_g59580;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g59553 = Output_2D_Auto131_g59580;
					#else
					float4 staticSwitch1088_g59553 = tex2D( _Lightmap1, UV12361_g59553 );
					#endif
					float4 Lightmap_1956_g59553 = staticSwitch1088_g59553;
					float Lightmap_Lerp_Value969_g59553 = _LIGHTMAPLERP;
					float4 lerpResult442_g59553 = lerp( Lightmap_0925_g59553 , Lightmap_1956_g59553 , Lightmap_Lerp_Value969_g59553);
					float4 Lightmap_Lerp932_g59553 = lerpResult442_g59553;
					float3 appendResult139_g59599 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float2 temp_output_5_0_g59554 = UV02420_g59553;
					float2 UV633_g59554 = temp_output_5_0_g59554;
					float2 UV100_g59555 = UV633_g59554;
					float2 temp_output_51_0_g59555 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59555 * float2( 3.464,3.464 ) ) );
					float2 break55_g59555 = frac( temp_output_51_0_g59555 );
					float temp_output_56_0_g59555 = ( ( 1.0 - break55_g59555.x ) - break55_g59555.y );
					float2 temp_output_52_0_g59555 = floor( temp_output_51_0_g59555 );
					float2 temp_output_125_0_g59555 = ( temp_output_52_0_g59555 + float2( 1,1 ) );
					float2 ifLocalVar87_g59555 = 0;
					if( temp_output_56_0_g59555 > 0.0 )
					ifLocalVar87_g59555 = temp_output_52_0_g59555;
					else if( temp_output_56_0_g59555 == 0.0 )
					ifLocalVar87_g59555 = temp_output_125_0_g59555;
					else if( temp_output_56_0_g59555 < 0.0 )
					ifLocalVar87_g59555 = temp_output_125_0_g59555;
					float3 temp_output_7_0_g59556 = frac( ( (ifLocalVar87_g59555).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59556 = dot( temp_output_7_0_g59556 , ( (temp_output_7_0_g59556).yzx + 33.33 ) );
					float3 temp_output_12_0_g59556 = ( temp_output_7_0_g59556 + dotResult8_g59556 );
					float2 temp_output_597_0_g59554 = ( UV100_g59555 + frac( ( ( (temp_output_12_0_g59556).xx + (temp_output_12_0_g59556).yz ) * (temp_output_12_0_g59556).zy ) ) );
					float2 DDX631_g59554 = ddx( temp_output_5_0_g59554 );
					float2 DDY632_g59554 = ddy( temp_output_5_0_g59554 );
					float Input_Scale617_g59554 = 1.5;
					float temp_output_65_0_g59555 = ( 0.0 - temp_output_56_0_g59555 );
					float ifLocalVar59_g59555 = 0;
					if( temp_output_56_0_g59555 <= 0.0 )
					ifLocalVar59_g59555 = temp_output_65_0_g59555;
					else
					ifLocalVar59_g59555 = temp_output_56_0_g59555;
					float temp_output_597_30_g59554 = ifLocalVar59_g59555;
					float2 temp_output_90_0_g59555 = ( temp_output_52_0_g59555 + float2( 0,1 ) );
					float2 temp_output_123_0_g59555 = ( temp_output_52_0_g59555 + float2( 1,0 ) );
					float2 ifLocalVar88_g59555 = 0;
					if( temp_output_56_0_g59555 > 0.0 )
					ifLocalVar88_g59555 = temp_output_90_0_g59555;
					else if( temp_output_56_0_g59555 == 0.0 )
					ifLocalVar88_g59555 = temp_output_123_0_g59555;
					else if( temp_output_56_0_g59555 < 0.0 )
					ifLocalVar88_g59555 = temp_output_123_0_g59555;
					float3 temp_output_7_0_g59557 = frac( ( (ifLocalVar88_g59555).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59557 = dot( temp_output_7_0_g59557 , ( (temp_output_7_0_g59557).yzx + 33.33 ) );
					float3 temp_output_12_0_g59557 = ( temp_output_7_0_g59557 + dotResult8_g59557 );
					float2 temp_output_597_26_g59554 = ( UV100_g59555 + frac( ( ( (temp_output_12_0_g59557).xx + (temp_output_12_0_g59557).yz ) * (temp_output_12_0_g59557).zy ) ) );
					float temp_output_66_0_g59555 = ( 1.0 - break55_g59555.y );
					float ifLocalVar60_g59555 = 0;
					if( temp_output_56_0_g59555 <= 0.0 )
					ifLocalVar60_g59555 = temp_output_66_0_g59555;
					else
					ifLocalVar60_g59555 = break55_g59555.y;
					float temp_output_597_28_g59554 = ifLocalVar60_g59555;
					float2 ifLocalVar89_g59555 = 0;
					if( temp_output_56_0_g59555 > 0.0 )
					ifLocalVar89_g59555 = temp_output_123_0_g59555;
					else if( temp_output_56_0_g59555 == 0.0 )
					ifLocalVar89_g59555 = temp_output_90_0_g59555;
					else if( temp_output_56_0_g59555 < 0.0 )
					ifLocalVar89_g59555 = temp_output_90_0_g59555;
					float3 temp_output_7_0_g59558 = frac( ( (ifLocalVar89_g59555).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59558 = dot( temp_output_7_0_g59558 , ( (temp_output_7_0_g59558).yzx + 33.33 ) );
					float3 temp_output_12_0_g59558 = ( temp_output_7_0_g59558 + dotResult8_g59558 );
					float2 temp_output_597_27_g59554 = ( UV100_g59555 + frac( ( ( (temp_output_12_0_g59558).xx + (temp_output_12_0_g59558).yz ) * (temp_output_12_0_g59558).zy ) ) );
					float temp_output_67_0_g59555 = ( 1.0 - break55_g59555.x );
					float ifLocalVar61_g59555 = 0;
					if( temp_output_56_0_g59555 <= 0.0 )
					ifLocalVar61_g59555 = temp_output_67_0_g59555;
					else
					ifLocalVar61_g59555 = break55_g59555.x;
					float temp_output_597_29_g59554 = ifLocalVar61_g59555;
					float3 Output_2D_Normal641_g59554 = ( ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_0_g59554, DDX631_g59554, DDY632_g59554 ), Input_Scale617_g59554 ) * temp_output_597_30_g59554 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_26_g59554, DDX631_g59554, DDY632_g59554 ), Input_Scale617_g59554 ) * temp_output_597_28_g59554 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_27_g59554, DDX631_g59554, DDY632_g59554 ), Input_Scale617_g59554 ) * float3( 0,0,0 ) * temp_output_597_29_g59554 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g59553 = Output_2D_Normal641_g59554;
					#else
					float3 staticSwitch1003_g59553 = UnpackScaleNormal( tex2D( _BumpMap, UV02420_g59553 ), 1.5 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g59553 = staticSwitch1003_g59553;
					#else
					float3 staticSwitch980_g59553 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g59553 = staticSwitch980_g59553;
					float3 normalizeResult326_g59599 = normalize( Normal_Map700_g59553 );
					float3 Normal_Map318_g59599 = normalizeResult326_g59599;
					float dotResult121_g59599 = dot( appendResult139_g59599 , Normal_Map318_g59599 );
					float temp_output_2_0_g59601 = saturate( dotResult121_g59599 );
					float localStochasticTiling2_g59582 = ( 0.0 );
					float2 UV2_g59582 = UV12361_g59553;
					float4 TexelSize2_g59582 = _RNMX0_TexelSize;
					float4 Offsets2_g59582 = float4( 0,0,0,0 );
					float2 Weights2_g59582 = float2( 0,0 );
					{
					UV2_g59582 = UV2_g59582 * TexelSize2_g59582.zw - 0.5;
					float2 f = frac( UV2_g59582 );
					UV2_g59582 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g59582.x - 0.5, UV2_g59582.x + 1.5, UV2_g59582.y - 0.5, UV2_g59582.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g59582 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59582.xyxy;
					Weights2_g59582 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g59581 = Offsets2_g59582;
					float4 Input_FetchOffsets197_g59583 = temp_output_1_34_g59581;
					float2 temp_output_1_54_g59581 = Weights2_g59582;
					float2 Input_FetchWeights200_g59583 = temp_output_1_54_g59581;
					float2 break187_g59583 = Input_FetchWeights200_g59583;
					float4 lerpResult181_g59583 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g59583).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g59583).xw ) , break187_g59583.x);
					float4 lerpResult182_g59583 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g59583).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g59583).xz ) , break187_g59583.x);
					float4 lerpResult176_g59583 = lerp( lerpResult181_g59583 , lerpResult182_g59583 , break187_g59583.y);
					float4 Output_Fetch2D_Auto202_g59583 = lerpResult176_g59583;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g59553 = Output_Fetch2D_Auto202_g59583;
					#else
					float4 staticSwitch1061_g59553 = tex2D( _RNMX0, UV12361_g59553 );
					#endif
					float3 appendResult146_g59599 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59599 = dot( appendResult146_g59599 , Normal_Map318_g59599 );
					float temp_output_2_0_g59600 = saturate( dotResult122_g59599 );
					float4 Input_FetchOffsets197_g59584 = temp_output_1_34_g59581;
					float2 Input_FetchWeights200_g59584 = temp_output_1_54_g59581;
					float2 break187_g59584 = Input_FetchWeights200_g59584;
					float4 lerpResult181_g59584 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g59584).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g59584).xw ) , break187_g59584.x);
					float4 lerpResult182_g59584 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g59584).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g59584).xz ) , break187_g59584.x);
					float4 lerpResult176_g59584 = lerp( lerpResult181_g59584 , lerpResult182_g59584 , break187_g59584.y);
					float4 Output_Fetch2D_Auto202_g59584 = lerpResult176_g59584;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g59553 = Output_Fetch2D_Auto202_g59584;
					#else
					float4 staticSwitch1062_g59553 = tex2D( _RNMY0, UV12361_g59553 );
					#endif
					float3 appendResult149_g59599 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59599 = dot( appendResult149_g59599 , Normal_Map318_g59599 );
					float temp_output_2_0_g59602 = saturate( dotResult120_g59599 );
					float4 Input_FetchOffsets197_g59585 = temp_output_1_34_g59581;
					float2 Input_FetchWeights200_g59585 = temp_output_1_54_g59581;
					float2 break187_g59585 = Input_FetchWeights200_g59585;
					float4 lerpResult181_g59585 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g59585).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g59585).xw ) , break187_g59585.x);
					float4 lerpResult182_g59585 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g59585).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g59585).xz ) , break187_g59585.x);
					float4 lerpResult176_g59585 = lerp( lerpResult181_g59585 , lerpResult182_g59585 , break187_g59585.y);
					float4 Output_Fetch2D_Auto202_g59585 = lerpResult176_g59585;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g59553 = Output_Fetch2D_Auto202_g59585;
					#else
					float4 staticSwitch1063_g59553 = tex2D( _RNMZ0, UV12361_g59553 );
					#endif
					float4 RNM_0926_g59553 = ( ( ( ( ( temp_output_2_0_g59601 * temp_output_2_0_g59601 ) * staticSwitch1061_g59553 ) + ( ( temp_output_2_0_g59600 * temp_output_2_0_g59600 ) * staticSwitch1062_g59553 ) ) + ( ( temp_output_2_0_g59602 * temp_output_2_0_g59602 ) * staticSwitch1063_g59553 ) ) * 2.2 );
					float3 appendResult139_g59595 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g59595 = normalize( Normal_Map700_g59553 );
					float3 Normal_Map318_g59595 = normalizeResult326_g59595;
					float dotResult121_g59595 = dot( appendResult139_g59595 , Normal_Map318_g59595 );
					float temp_output_2_0_g59597 = saturate( dotResult121_g59595 );
					float localStochasticTiling2_g59575 = ( 0.0 );
					float2 UV2_g59575 = UV12361_g59553;
					float4 TexelSize2_g59575 = _RNMX1_TexelSize;
					float4 Offsets2_g59575 = float4( 0,0,0,0 );
					float2 Weights2_g59575 = float2( 0,0 );
					{
					UV2_g59575 = UV2_g59575 * TexelSize2_g59575.zw - 0.5;
					float2 f = frac( UV2_g59575 );
					UV2_g59575 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g59575.x - 0.5, UV2_g59575.x + 1.5, UV2_g59575.y - 0.5, UV2_g59575.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g59575 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59575.xyxy;
					Weights2_g59575 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g59574 = Offsets2_g59575;
					float4 Input_FetchOffsets197_g59576 = temp_output_1_34_g59574;
					float2 temp_output_1_54_g59574 = Weights2_g59575;
					float2 Input_FetchWeights200_g59576 = temp_output_1_54_g59574;
					float2 break187_g59576 = Input_FetchWeights200_g59576;
					float4 lerpResult181_g59576 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g59576).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g59576).xw ) , break187_g59576.x);
					float4 lerpResult182_g59576 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g59576).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g59576).xz ) , break187_g59576.x);
					float4 lerpResult176_g59576 = lerp( lerpResult181_g59576 , lerpResult182_g59576 , break187_g59576.y);
					float4 Output_Fetch2D_Auto202_g59576 = lerpResult176_g59576;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g59553 = Output_Fetch2D_Auto202_g59576;
					#else
					float4 staticSwitch1087_g59553 = tex2D( _RNMX1, UV12361_g59553 );
					#endif
					float3 appendResult146_g59595 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59595 = dot( appendResult146_g59595 , Normal_Map318_g59595 );
					float temp_output_2_0_g59596 = saturate( dotResult122_g59595 );
					float4 Input_FetchOffsets197_g59577 = temp_output_1_34_g59574;
					float2 Input_FetchWeights200_g59577 = temp_output_1_54_g59574;
					float2 break187_g59577 = Input_FetchWeights200_g59577;
					float4 lerpResult181_g59577 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g59577).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g59577).xw ) , break187_g59577.x);
					float4 lerpResult182_g59577 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g59577).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g59577).xz ) , break187_g59577.x);
					float4 lerpResult176_g59577 = lerp( lerpResult181_g59577 , lerpResult182_g59577 , break187_g59577.y);
					float4 Output_Fetch2D_Auto202_g59577 = lerpResult176_g59577;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g59553 = Output_Fetch2D_Auto202_g59577;
					#else
					float4 staticSwitch1083_g59553 = tex2D( _RNMY1, UV12361_g59553 );
					#endif
					float3 appendResult149_g59595 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59595 = dot( appendResult149_g59595 , Normal_Map318_g59595 );
					float temp_output_2_0_g59598 = saturate( dotResult120_g59595 );
					float4 Input_FetchOffsets197_g59578 = temp_output_1_34_g59574;
					float2 Input_FetchWeights200_g59578 = temp_output_1_54_g59574;
					float2 break187_g59578 = Input_FetchWeights200_g59578;
					float4 lerpResult181_g59578 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g59578).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g59578).xw ) , break187_g59578.x);
					float4 lerpResult182_g59578 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g59578).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g59578).xz ) , break187_g59578.x);
					float4 lerpResult176_g59578 = lerp( lerpResult181_g59578 , lerpResult182_g59578 , break187_g59578.y);
					float4 Output_Fetch2D_Auto202_g59578 = lerpResult176_g59578;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g59553 = Output_Fetch2D_Auto202_g59578;
					#else
					float4 staticSwitch1084_g59553 = tex2D( _RNMZ1, UV12361_g59553 );
					#endif
					float4 RNM_11081_g59553 = ( ( ( ( ( temp_output_2_0_g59597 * temp_output_2_0_g59597 ) * staticSwitch1087_g59553 ) + ( ( temp_output_2_0_g59596 * temp_output_2_0_g59596 ) * staticSwitch1083_g59553 ) ) + ( ( temp_output_2_0_g59598 * temp_output_2_0_g59598 ) * staticSwitch1084_g59553 ) ) * 2.2 );
					float4 lerpResult953_g59553 = lerp( RNM_0926_g59553 , RNM_11081_g59553 , Lightmap_Lerp_Value969_g59553);
					float4 RNM_Lerp950_g59553 = lerpResult953_g59553;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g59553 = temp_cast_1;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g59553 = Lightmap_0925_g59553;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g59553 = Lightmap_Lerp932_g59553;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g59553 = RNM_0926_g59553;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g59553 = RNM_Lerp950_g59553;
					#else
					float4 staticSwitch1014_g59553 = temp_cast_1;
					#endif
					float3 Lightmap46_g59553 = (staticSwitch1014_g59553).rgb;
					float3 World_Position2505_g59553 = PositionWS;
					float3 WorldPos1_g59606 = World_Position2505_g59553;
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal2504_g59553 = Normal_Map700_g59553;
					float3 worldNormal2504_g59553 = normalize( float3( dot( tanToWorld0, tanNormal2504_g59553 ), dot( tanToWorld1, tanNormal2504_g59553 ), dot( tanToWorld2, tanNormal2504_g59553 ) ) );
					float3 World_Normal2508_g59553 = worldNormal2504_g59553;
					float3 WorldNormal1_g59606 = World_Normal2508_g59553;
					float3 View_Direction2511_g59553 = ViewDirWS;
					float3 ViewDir1_g59606 = View_Direction2511_g59553;
					float3 temp_cast_3 = (0.04).xxx;
					float3 lerpResult1473_g59553 = lerp( temp_cast_3 , oAlbedo6_g59553 , Metallic1239_g59553);
					float3 switchResult1501_g59553 = (((ase_vface>0)?(World_Normal2508_g59553):(-World_Normal2508_g59553)));
					float dotResult1476_g59553 = dot( switchResult1501_g59553 , View_Direction2511_g59553 );
					float3 lerpResult1480_g59553 = lerp( lerpResult1473_g59553 , float3( 1,1,1 ) , pow( ( 1.0 - saturate( dotResult1476_g59553 ) ) , 5.0 ));
					float3 Fresnel1560_g59553 = lerpResult1480_g59553;
					float4 Fresnel1_g59606 = float4( Fresnel1560_g59553 , 0.0 );
					float2 temp_output_5_0_g59569 = UV02420_g59553;
					float2 UV633_g59569 = temp_output_5_0_g59569;
					float2 UV100_g59570 = UV633_g59569;
					float2 temp_output_51_0_g59570 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59570 * float2( 3.464,3.464 ) ) );
					float2 break55_g59570 = frac( temp_output_51_0_g59570 );
					float temp_output_56_0_g59570 = ( ( 1.0 - break55_g59570.x ) - break55_g59570.y );
					float2 temp_output_52_0_g59570 = floor( temp_output_51_0_g59570 );
					float2 temp_output_125_0_g59570 = ( temp_output_52_0_g59570 + float2( 1,1 ) );
					float2 ifLocalVar87_g59570 = 0;
					if( temp_output_56_0_g59570 > 0.0 )
					ifLocalVar87_g59570 = temp_output_52_0_g59570;
					else if( temp_output_56_0_g59570 == 0.0 )
					ifLocalVar87_g59570 = temp_output_125_0_g59570;
					else if( temp_output_56_0_g59570 < 0.0 )
					ifLocalVar87_g59570 = temp_output_125_0_g59570;
					float3 temp_output_7_0_g59571 = frac( ( (ifLocalVar87_g59570).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59571 = dot( temp_output_7_0_g59571 , ( (temp_output_7_0_g59571).yzx + 33.33 ) );
					float3 temp_output_12_0_g59571 = ( temp_output_7_0_g59571 + dotResult8_g59571 );
					float2 temp_output_597_0_g59569 = ( UV100_g59570 + frac( ( ( (temp_output_12_0_g59571).xx + (temp_output_12_0_g59571).yz ) * (temp_output_12_0_g59571).zy ) ) );
					float2 DDX631_g59569 = ddx( temp_output_5_0_g59569 );
					float2 DDY632_g59569 = ddy( temp_output_5_0_g59569 );
					float temp_output_65_0_g59570 = ( 0.0 - temp_output_56_0_g59570 );
					float ifLocalVar59_g59570 = 0;
					if( temp_output_56_0_g59570 <= 0.0 )
					ifLocalVar59_g59570 = temp_output_65_0_g59570;
					else
					ifLocalVar59_g59570 = temp_output_56_0_g59570;
					float temp_output_597_30_g59569 = ifLocalVar59_g59570;
					float2 temp_output_90_0_g59570 = ( temp_output_52_0_g59570 + float2( 0,1 ) );
					float2 temp_output_123_0_g59570 = ( temp_output_52_0_g59570 + float2( 1,0 ) );
					float2 ifLocalVar88_g59570 = 0;
					if( temp_output_56_0_g59570 > 0.0 )
					ifLocalVar88_g59570 = temp_output_90_0_g59570;
					else if( temp_output_56_0_g59570 == 0.0 )
					ifLocalVar88_g59570 = temp_output_123_0_g59570;
					else if( temp_output_56_0_g59570 < 0.0 )
					ifLocalVar88_g59570 = temp_output_123_0_g59570;
					float3 temp_output_7_0_g59572 = frac( ( (ifLocalVar88_g59570).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59572 = dot( temp_output_7_0_g59572 , ( (temp_output_7_0_g59572).yzx + 33.33 ) );
					float3 temp_output_12_0_g59572 = ( temp_output_7_0_g59572 + dotResult8_g59572 );
					float2 temp_output_597_26_g59569 = ( UV100_g59570 + frac( ( ( (temp_output_12_0_g59572).xx + (temp_output_12_0_g59572).yz ) * (temp_output_12_0_g59572).zy ) ) );
					float temp_output_66_0_g59570 = ( 1.0 - break55_g59570.y );
					float ifLocalVar60_g59570 = 0;
					if( temp_output_56_0_g59570 <= 0.0 )
					ifLocalVar60_g59570 = temp_output_66_0_g59570;
					else
					ifLocalVar60_g59570 = break55_g59570.y;
					float temp_output_597_28_g59569 = ifLocalVar60_g59570;
					float2 ifLocalVar89_g59570 = 0;
					if( temp_output_56_0_g59570 > 0.0 )
					ifLocalVar89_g59570 = temp_output_123_0_g59570;
					else if( temp_output_56_0_g59570 == 0.0 )
					ifLocalVar89_g59570 = temp_output_90_0_g59570;
					else if( temp_output_56_0_g59570 < 0.0 )
					ifLocalVar89_g59570 = temp_output_90_0_g59570;
					float3 temp_output_7_0_g59573 = frac( ( (ifLocalVar89_g59570).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59573 = dot( temp_output_7_0_g59573 , ( (temp_output_7_0_g59573).yzx + 33.33 ) );
					float3 temp_output_12_0_g59573 = ( temp_output_7_0_g59573 + dotResult8_g59573 );
					float2 temp_output_597_27_g59569 = ( UV100_g59570 + frac( ( ( (temp_output_12_0_g59573).xx + (temp_output_12_0_g59573).yz ) * (temp_output_12_0_g59573).zy ) ) );
					float temp_output_67_0_g59570 = ( 1.0 - break55_g59570.x );
					float ifLocalVar61_g59570 = 0;
					if( temp_output_56_0_g59570 <= 0.0 )
					ifLocalVar61_g59570 = temp_output_67_0_g59570;
					else
					ifLocalVar61_g59570 = break55_g59570.x;
					float temp_output_597_29_g59569 = ifLocalVar61_g59570;
					float4 Output_2D293_g59569 = ( ( tex2D( _GlossinessMap, temp_output_597_0_g59569, DDX631_g59569, DDY632_g59569 ) * temp_output_597_30_g59569 ) + ( tex2D( _GlossinessMap, temp_output_597_26_g59569, DDX631_g59569, DDY632_g59569 ) * temp_output_597_28_g59569 ) + ( tex2D( _GlossinessMap, temp_output_597_27_g59569, DDX631_g59569, DDY632_g59569 ) * temp_output_597_29_g59569 ) );
					float4 break31_g59569 = Output_2D293_g59569;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g59553 = break31_g59569.a;
					#else
					float staticSwitch1004_g59553 = tex2D( _GlossinessMap, UV02420_g59553 ).r;
					#endif
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g59553 = ( 1.0 - staticSwitch1004_g59553 );
					#else
					float staticSwitch845_g59553 = _Glossiness;
					#endif
					float temp_output_19_0_g59605 = staticSwitch845_g59553;
					float3 tanNormal2_g59605 = World_Normal2508_g59553;
					float3 worldNormal2_g59605 = float3( dot( tanToWorld0, tanNormal2_g59605 ), dot( tanToWorld1, tanNormal2_g59605 ), dot( tanToWorld2, tanNormal2_g59605 ) );
					float3 temp_output_3_0_g59605 = ddx( worldNormal2_g59605 );
					float dotResult5_g59605 = dot( temp_output_3_0_g59605 , temp_output_3_0_g59605 );
					float3 temp_output_4_0_g59605 = ddy( worldNormal2_g59605 );
					float dotResult6_g59605 = dot( temp_output_4_0_g59605 , temp_output_4_0_g59605 );
					#ifdef _USEGEOMETRICAA_ON
					float staticSwitch15_g59605 = min( temp_output_19_0_g59605, ( 1.0 - pow( saturate( max( dotResult5_g59605, dotResult6_g59605 ) ) , 0.333 ) ) );
					#else
					float staticSwitch15_g59605 = temp_output_19_0_g59605;
					#endif
					float Smoothness1399_g59553 = staticSwitch15_g59605;
					float Smoothness1_g59606 = Smoothness1399_g59553;
					float3 localIndirectGeometricSpecular1_g59606 = IndirectGeometricSpecular1_g59606( WorldPos1_g59606 , WorldNormal1_g59606 , ViewDir1_g59606 , Fresnel1_g59606 , Smoothness1_g59606 );
					float3 temp_output_2565_0_g59553 = localIndirectGeometricSpecular1_g59606;
					float3 temp_cast_5 = (0.02).xxx;
					float3 temp_cast_6 = (0.1).xxx;
					float3 smoothstepResult2430_g59553 = smoothstep( temp_cast_5 , temp_cast_6 , Lightmap46_g59553);
					#ifdef _USELIGHTMAPSPECULAR_ON
					float3 staticSwitch1469_g59553 = ( temp_output_2565_0_g59553 * smoothstepResult2430_g59553 );
					#else
					float3 staticSwitch1469_g59553 = temp_output_2565_0_g59553;
					#endif
					float3 Reflections1419_g59553 = staticSwitch1469_g59553;
					float4 temp_cast_7 = (Black1185_g59553).xxxx;
					float2 temp_output_5_0_g59564 = UV02420_g59553;
					float2 UV633_g59564 = temp_output_5_0_g59564;
					float2 UV100_g59565 = UV633_g59564;
					float2 temp_output_51_0_g59565 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59565 * float2( 3.464,3.464 ) ) );
					float2 break55_g59565 = frac( temp_output_51_0_g59565 );
					float temp_output_56_0_g59565 = ( ( 1.0 - break55_g59565.x ) - break55_g59565.y );
					float2 temp_output_52_0_g59565 = floor( temp_output_51_0_g59565 );
					float2 temp_output_125_0_g59565 = ( temp_output_52_0_g59565 + float2( 1,1 ) );
					float2 ifLocalVar87_g59565 = 0;
					if( temp_output_56_0_g59565 > 0.0 )
					ifLocalVar87_g59565 = temp_output_52_0_g59565;
					else if( temp_output_56_0_g59565 == 0.0 )
					ifLocalVar87_g59565 = temp_output_125_0_g59565;
					else if( temp_output_56_0_g59565 < 0.0 )
					ifLocalVar87_g59565 = temp_output_125_0_g59565;
					float3 temp_output_7_0_g59566 = frac( ( (ifLocalVar87_g59565).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59566 = dot( temp_output_7_0_g59566 , ( (temp_output_7_0_g59566).yzx + 33.33 ) );
					float3 temp_output_12_0_g59566 = ( temp_output_7_0_g59566 + dotResult8_g59566 );
					float2 temp_output_597_0_g59564 = ( UV100_g59565 + frac( ( ( (temp_output_12_0_g59566).xx + (temp_output_12_0_g59566).yz ) * (temp_output_12_0_g59566).zy ) ) );
					float2 DDX631_g59564 = ddx( temp_output_5_0_g59564 );
					float2 DDY632_g59564 = ddy( temp_output_5_0_g59564 );
					float temp_output_65_0_g59565 = ( 0.0 - temp_output_56_0_g59565 );
					float ifLocalVar59_g59565 = 0;
					if( temp_output_56_0_g59565 <= 0.0 )
					ifLocalVar59_g59565 = temp_output_65_0_g59565;
					else
					ifLocalVar59_g59565 = temp_output_56_0_g59565;
					float temp_output_597_30_g59564 = ifLocalVar59_g59565;
					float2 temp_output_90_0_g59565 = ( temp_output_52_0_g59565 + float2( 0,1 ) );
					float2 temp_output_123_0_g59565 = ( temp_output_52_0_g59565 + float2( 1,0 ) );
					float2 ifLocalVar88_g59565 = 0;
					if( temp_output_56_0_g59565 > 0.0 )
					ifLocalVar88_g59565 = temp_output_90_0_g59565;
					else if( temp_output_56_0_g59565 == 0.0 )
					ifLocalVar88_g59565 = temp_output_123_0_g59565;
					else if( temp_output_56_0_g59565 < 0.0 )
					ifLocalVar88_g59565 = temp_output_123_0_g59565;
					float3 temp_output_7_0_g59567 = frac( ( (ifLocalVar88_g59565).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59567 = dot( temp_output_7_0_g59567 , ( (temp_output_7_0_g59567).yzx + 33.33 ) );
					float3 temp_output_12_0_g59567 = ( temp_output_7_0_g59567 + dotResult8_g59567 );
					float2 temp_output_597_26_g59564 = ( UV100_g59565 + frac( ( ( (temp_output_12_0_g59567).xx + (temp_output_12_0_g59567).yz ) * (temp_output_12_0_g59567).zy ) ) );
					float temp_output_66_0_g59565 = ( 1.0 - break55_g59565.y );
					float ifLocalVar60_g59565 = 0;
					if( temp_output_56_0_g59565 <= 0.0 )
					ifLocalVar60_g59565 = temp_output_66_0_g59565;
					else
					ifLocalVar60_g59565 = break55_g59565.y;
					float temp_output_597_28_g59564 = ifLocalVar60_g59565;
					float2 ifLocalVar89_g59565 = 0;
					if( temp_output_56_0_g59565 > 0.0 )
					ifLocalVar89_g59565 = temp_output_123_0_g59565;
					else if( temp_output_56_0_g59565 == 0.0 )
					ifLocalVar89_g59565 = temp_output_90_0_g59565;
					else if( temp_output_56_0_g59565 < 0.0 )
					ifLocalVar89_g59565 = temp_output_90_0_g59565;
					float3 temp_output_7_0_g59568 = frac( ( (ifLocalVar89_g59565).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59568 = dot( temp_output_7_0_g59568 , ( (temp_output_7_0_g59568).yzx + 33.33 ) );
					float3 temp_output_12_0_g59568 = ( temp_output_7_0_g59568 + dotResult8_g59568 );
					float2 temp_output_597_27_g59564 = ( UV100_g59565 + frac( ( ( (temp_output_12_0_g59568).xx + (temp_output_12_0_g59568).yz ) * (temp_output_12_0_g59568).zy ) ) );
					float temp_output_67_0_g59565 = ( 1.0 - break55_g59565.x );
					float ifLocalVar61_g59565 = 0;
					if( temp_output_56_0_g59565 <= 0.0 )
					ifLocalVar61_g59565 = temp_output_67_0_g59565;
					else
					ifLocalVar61_g59565 = break55_g59565.x;
					float temp_output_597_29_g59564 = ifLocalVar61_g59565;
					float4 Output_2D293_g59564 = ( ( tex2D( _EmissionMap, temp_output_597_0_g59564, DDX631_g59564, DDY632_g59564 ) * temp_output_597_30_g59564 ) + ( tex2D( _EmissionMap, temp_output_597_26_g59564, DDX631_g59564, DDY632_g59564 ) * temp_output_597_28_g59564 ) + ( tex2D( _EmissionMap, temp_output_597_27_g59564, DDX631_g59564, DDY632_g59564 ) * temp_output_597_29_g59564 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g59553 = Output_2D293_g59564;
					#else
					float4 staticSwitch1006_g59553 = tex2D( _EmissionMap, UV02420_g59553 );
					#endif
					#if defined( _SPECIALEFFECTS_DISABLED )
					float4 staticSwitch1578_g59553 = staticSwitch1006_g59553;
					#elif defined( _SPECIALEFFECTS_LED )
					float4 staticSwitch1578_g59553 = float4( 0,0,0,0 );
					#else
					float4 staticSwitch1578_g59553 = staticSwitch1006_g59553;
					#endif
					#ifdef _EMISSIONENABLED_ON
					float4 staticSwitch1017_g59553 = ( float4( _EmissionColor , 0.0 ) * staticSwitch1578_g59553 * _EmissionIntensity );
					#else
					float4 staticSwitch1017_g59553 = temp_cast_7;
					#endif
					float3 Emission86_g59553 = (staticSwitch1017_g59553).rgb;
					float3 WorldPos97_g59608 = World_Position2505_g59553;
					float3 WorldNormal97_g59608 = World_Normal2508_g59553;
					float3 LightmapColor97_g59608 = Lightmap46_g59553;
					float3 ViewDir97_g59608 = View_Direction2511_g59553;
					float4 Fresnel97_g59608 = float4( Fresnel1560_g59553 , 0.0 );
					float Smoothness97_g59608 = Smoothness1399_g59553;
					float3 localSpecular97_g59608 = Specular( WorldPos97_g59608 , WorldNormal97_g59608 , LightmapColor97_g59608 , ViewDir97_g59608 , Fresnel97_g59608 , Smoothness97_g59608 );
					float3 Speculars2560_g59553 = localSpecular97_g59608;
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch1181_g59553 = Lightmap46_g59553;
					#else
					float3 staticSwitch1181_g59553 = ( ( aAlbedo1466_g59553 * Lightmap46_g59553 ) + Reflections1419_g59553 + Emission86_g59553 + Speculars2560_g59553 );
					#endif
					float3 temp_output_35_0_g59593 = staticSwitch1181_g59553;
					float3 Color353_g59593 = temp_output_35_0_g59593;
					#if defined( _LUTMODE_2D )
					float3 staticSwitch273_g59593 = saturate( temp_output_35_0_g59593 );
					#elif defined( _LUTMODE_3D )
					float3 staticSwitch273_g59593 = temp_output_35_0_g59593;
					#else
					float3 staticSwitch273_g59593 = temp_output_35_0_g59593;
					#endif
					float3 Color_Saturate49_g59593 = staticSwitch273_g59593;
					float Lut_Height213_g59593 = _LUTSize;
					float Lut_Width216_g59593 = ( _LUTSize * Lut_Height213_g59593 );
					float3 appendResult214_g59593 = (float3(( 1.0 / Lut_Width216_g59593 ) , ( 1.0 / Lut_Height213_g59593 ) , ( Lut_Height213_g59593 - 1.0 )));
					float3 Scale_Offset208_g59593 = appendResult214_g59593;
					float2 Scale_Factor292_g59593 = ( (Scale_Offset208_g59593).xy * (Scale_Offset208_g59593).z );
					float2 Offset299_g59593 = ( (Scale_Offset208_g59593).xy * 0.5 );
					float2 Adjusted_UV305_g59593 = ( ( (Color_Saturate49_g59593).xy * Scale_Factor292_g59593 ) + Offset299_g59593 );
					float Scaled_Blue280_g59593 = ( (Color_Saturate49_g59593).z * (Scale_Offset208_g59593).z );
					float Shift288_g59593 = floor( Scaled_Blue280_g59593 );
					float Final_X313_g59593 = ( (Adjusted_UV305_g59593).x + ( Shift288_g59593 * (Scale_Offset208_g59593).y ) );
					float2 appendResult326_g59593 = (float2(Final_X313_g59593 , (Adjusted_UV305_g59593).y));
					float2 Final_UV325_g59593 = appendResult326_g59593;
					float2 appendResult338_g59593 = (float2((Scale_Offset208_g59593).y , 0.0));
					float2 Offset_UV336_g59593 = ( Final_UV325_g59593 + appendResult338_g59593 );
					float3 lerpResult333_g59593 = lerp( tex2D( _2DLut, Final_UV325_g59593 ).rgb , tex2D( _2DLut, Offset_UV336_g59593 ).rgb , ( Scaled_Blue280_g59593 - Shift288_g59593 ));
					#ifdef _2DLUT
					float3 staticSwitch347_g59593 = lerpResult333_g59593;
					#else
					float3 staticSwitch347_g59593 = Color_Saturate49_g59593;
					#endif
					float3 TwoD_LUT346_g59593 = staticSwitch347_g59593;
					float3 RGB16_g59594 = ( ( log10( ( ( Color_Saturate49_g59593 * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 );
					#ifdef _3DLUT
					float3 staticSwitch194_g59593 = tex3D( _3DLut, RGB16_g59594 ).rgb;
					#else
					float3 staticSwitch194_g59593 = Color_Saturate49_g59593;
					#endif
					float3 ThreeD_LUT51_g59593 = staticSwitch194_g59593;
					#if defined( _LUTMODE_2D )
					float3 staticSwitch42_g59593 = TwoD_LUT346_g59593;
					#elif defined( _LUTMODE_3D )
					float3 staticSwitch42_g59593 = ThreeD_LUT51_g59593;
					#else
					float3 staticSwitch42_g59593 = ThreeD_LUT51_g59593;
					#endif
					#ifdef SHADER_API_MOBILE
					float3 staticSwitch41_g59593 = staticSwitch42_g59593;
					#else
					float3 staticSwitch41_g59593 = Color353_g59593;
					#endif
					
					#ifdef _LIGHTMAPDEBUG
					float staticSwitch1191_g59553 = White38_g59553;
					#else
					float staticSwitch1191_g59553 = staticSwitch1549_g59553.a;
					#endif
					

					o.Albedo = staticSwitch1180_g59553;
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

					o.Emission = staticSwitch41_g59593;
					o.Alpha = staticSwitch1191_g59553;
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
				#define _ALPHABLEND_ON 1
				#define ASE_FRAGMENT_NORMAL 0
				#define ASE_RECEIVE_SHADOWS
				#pragma multi_compile_instancing
				#pragma multi_compile _ LOD_FADE_CROSSFADE
				#define ASE_FOG
				#define ASE_LIGHTING_SIMPLE 1
				#define ASE_NO_AMBIENT 1
				#define _SPECULARHIGHLIGHTS_OFF
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

					float2 texCoord2357_g59553 = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV02420_g59553 = texCoord2357_g59553;
					float2 temp_output_5_0_g59586 = UV02420_g59553;
					float2 UV633_g59586 = temp_output_5_0_g59586;
					float2 UV100_g59587 = UV633_g59586;
					float2 temp_output_51_0_g59587 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59587 * float2( 3.464,3.464 ) ) );
					float2 break55_g59587 = frac( temp_output_51_0_g59587 );
					float temp_output_56_0_g59587 = ( ( 1.0 - break55_g59587.x ) - break55_g59587.y );
					float2 temp_output_52_0_g59587 = floor( temp_output_51_0_g59587 );
					float2 temp_output_125_0_g59587 = ( temp_output_52_0_g59587 + float2( 1,1 ) );
					float2 ifLocalVar87_g59587 = 0;
					if( temp_output_56_0_g59587 > 0.0 )
					ifLocalVar87_g59587 = temp_output_52_0_g59587;
					else if( temp_output_56_0_g59587 == 0.0 )
					ifLocalVar87_g59587 = temp_output_125_0_g59587;
					else if( temp_output_56_0_g59587 < 0.0 )
					ifLocalVar87_g59587 = temp_output_125_0_g59587;
					float3 temp_output_7_0_g59588 = frac( ( (ifLocalVar87_g59587).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59588 = dot( temp_output_7_0_g59588 , ( (temp_output_7_0_g59588).yzx + 33.33 ) );
					float3 temp_output_12_0_g59588 = ( temp_output_7_0_g59588 + dotResult8_g59588 );
					float2 temp_output_597_0_g59586 = ( UV100_g59587 + frac( ( ( (temp_output_12_0_g59588).xx + (temp_output_12_0_g59588).yz ) * (temp_output_12_0_g59588).zy ) ) );
					float2 DDX631_g59586 = ddx( temp_output_5_0_g59586 );
					float2 DDY632_g59586 = ddy( temp_output_5_0_g59586 );
					float temp_output_65_0_g59587 = ( 0.0 - temp_output_56_0_g59587 );
					float ifLocalVar59_g59587 = 0;
					if( temp_output_56_0_g59587 <= 0.0 )
					ifLocalVar59_g59587 = temp_output_65_0_g59587;
					else
					ifLocalVar59_g59587 = temp_output_56_0_g59587;
					float temp_output_597_30_g59586 = ifLocalVar59_g59587;
					float2 temp_output_90_0_g59587 = ( temp_output_52_0_g59587 + float2( 0,1 ) );
					float2 temp_output_123_0_g59587 = ( temp_output_52_0_g59587 + float2( 1,0 ) );
					float2 ifLocalVar88_g59587 = 0;
					if( temp_output_56_0_g59587 > 0.0 )
					ifLocalVar88_g59587 = temp_output_90_0_g59587;
					else if( temp_output_56_0_g59587 == 0.0 )
					ifLocalVar88_g59587 = temp_output_123_0_g59587;
					else if( temp_output_56_0_g59587 < 0.0 )
					ifLocalVar88_g59587 = temp_output_123_0_g59587;
					float3 temp_output_7_0_g59589 = frac( ( (ifLocalVar88_g59587).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59589 = dot( temp_output_7_0_g59589 , ( (temp_output_7_0_g59589).yzx + 33.33 ) );
					float3 temp_output_12_0_g59589 = ( temp_output_7_0_g59589 + dotResult8_g59589 );
					float2 temp_output_597_26_g59586 = ( UV100_g59587 + frac( ( ( (temp_output_12_0_g59589).xx + (temp_output_12_0_g59589).yz ) * (temp_output_12_0_g59589).zy ) ) );
					float temp_output_66_0_g59587 = ( 1.0 - break55_g59587.y );
					float ifLocalVar60_g59587 = 0;
					if( temp_output_56_0_g59587 <= 0.0 )
					ifLocalVar60_g59587 = temp_output_66_0_g59587;
					else
					ifLocalVar60_g59587 = break55_g59587.y;
					float temp_output_597_28_g59586 = ifLocalVar60_g59587;
					float2 ifLocalVar89_g59587 = 0;
					if( temp_output_56_0_g59587 > 0.0 )
					ifLocalVar89_g59587 = temp_output_123_0_g59587;
					else if( temp_output_56_0_g59587 == 0.0 )
					ifLocalVar89_g59587 = temp_output_90_0_g59587;
					else if( temp_output_56_0_g59587 < 0.0 )
					ifLocalVar89_g59587 = temp_output_90_0_g59587;
					float3 temp_output_7_0_g59590 = frac( ( (ifLocalVar89_g59587).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59590 = dot( temp_output_7_0_g59590 , ( (temp_output_7_0_g59590).yzx + 33.33 ) );
					float3 temp_output_12_0_g59590 = ( temp_output_7_0_g59590 + dotResult8_g59590 );
					float2 temp_output_597_27_g59586 = ( UV100_g59587 + frac( ( ( (temp_output_12_0_g59590).xx + (temp_output_12_0_g59590).yz ) * (temp_output_12_0_g59590).zy ) ) );
					float temp_output_67_0_g59587 = ( 1.0 - break55_g59587.x );
					float ifLocalVar61_g59587 = 0;
					if( temp_output_56_0_g59587 <= 0.0 )
					ifLocalVar61_g59587 = temp_output_67_0_g59587;
					else
					ifLocalVar61_g59587 = break55_g59587.x;
					float temp_output_597_29_g59586 = ifLocalVar61_g59587;
					float4 Output_2D293_g59586 = ( ( tex2D( _MainTex, temp_output_597_0_g59586, DDX631_g59586, DDY632_g59586 ) * temp_output_597_30_g59586 ) + ( tex2D( _MainTex, temp_output_597_26_g59586, DDX631_g59586, DDY632_g59586 ) * temp_output_597_28_g59586 ) + ( tex2D( _MainTex, temp_output_597_27_g59586, DDX631_g59586, DDY632_g59586 ) * temp_output_597_29_g59586 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g59553 = Output_2D293_g59586;
					#else
					float4 staticSwitch1001_g59553 = tex2D( _MainTex, UV02420_g59553 );
					#endif
					#ifdef _MAINTEX
					float4 staticSwitch1549_g59553 = staticSwitch1001_g59553;
					#else
					float4 staticSwitch1549_g59553 = _Color;
					#endif
					float White38_g59553 = 1.0;
					#ifdef _LIGHTMAPDEBUG
					float staticSwitch1191_g59553 = White38_g59553;
					#else
					float staticSwitch1191_g59553 = staticSwitch1549_g59553.a;
					#endif
					

					o.Normal = half3( 0, 0, 1 );

					o.Alpha = staticSwitch1191_g59553;
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
				#define _ALPHABLEND_ON 1
				#define ASE_FRAGMENT_NORMAL 0
				#define ASE_RECEIVE_SHADOWS
				#pragma multi_compile_instancing
				#pragma multi_compile _ LOD_FADE_CROSSFADE
				#define ASE_FOG
				#define ASE_LIGHTING_SIMPLE 1
				#define ASE_NO_AMBIENT 1
				#define _SPECULARHIGHLIGHTS_OFF
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

				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#pragma shader_feature _LIGHTMAPDEBUG
				#pragma shader_feature_local_fragment _MAINTEX
				#pragma shader_feature_local _STOCHASTICENABLED_ON


				int _ObjectId;
				int _PassValue;

				struct appdata
				{
					float4 vertex : POSITION;
					half3 normal : NORMAL;
					half4 tangent : TANGENT;
					float4 ase_texcoord : TEXCOORD0;
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct v2f
				{
					float4 pos : SV_POSITION;
					float4 worldPos : TEXCOORD0; // xyz = positionWS
					half3 normalWS : TEXCOORD1;
					float4 ase_texcoord2 : TEXCOORD2;
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


				
				v2f VertexFunction( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					o.ase_texcoord2 = v.ase_texcoord;

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
					o.normal = v.normal;
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
					o.normal = patch[0].normal * bary.x + patch[1].normal * bary.y + patch[2].normal * bary.z;
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

					float2 texCoord2357_g59553 = IN.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV02420_g59553 = texCoord2357_g59553;
					float2 temp_output_5_0_g59586 = UV02420_g59553;
					float2 UV633_g59586 = temp_output_5_0_g59586;
					float2 UV100_g59587 = UV633_g59586;
					float2 temp_output_51_0_g59587 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59587 * float2( 3.464,3.464 ) ) );
					float2 break55_g59587 = frac( temp_output_51_0_g59587 );
					float temp_output_56_0_g59587 = ( ( 1.0 - break55_g59587.x ) - break55_g59587.y );
					float2 temp_output_52_0_g59587 = floor( temp_output_51_0_g59587 );
					float2 temp_output_125_0_g59587 = ( temp_output_52_0_g59587 + float2( 1,1 ) );
					float2 ifLocalVar87_g59587 = 0;
					if( temp_output_56_0_g59587 > 0.0 )
					ifLocalVar87_g59587 = temp_output_52_0_g59587;
					else if( temp_output_56_0_g59587 == 0.0 )
					ifLocalVar87_g59587 = temp_output_125_0_g59587;
					else if( temp_output_56_0_g59587 < 0.0 )
					ifLocalVar87_g59587 = temp_output_125_0_g59587;
					float3 temp_output_7_0_g59588 = frac( ( (ifLocalVar87_g59587).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59588 = dot( temp_output_7_0_g59588 , ( (temp_output_7_0_g59588).yzx + 33.33 ) );
					float3 temp_output_12_0_g59588 = ( temp_output_7_0_g59588 + dotResult8_g59588 );
					float2 temp_output_597_0_g59586 = ( UV100_g59587 + frac( ( ( (temp_output_12_0_g59588).xx + (temp_output_12_0_g59588).yz ) * (temp_output_12_0_g59588).zy ) ) );
					float2 DDX631_g59586 = ddx( temp_output_5_0_g59586 );
					float2 DDY632_g59586 = ddy( temp_output_5_0_g59586 );
					float temp_output_65_0_g59587 = ( 0.0 - temp_output_56_0_g59587 );
					float ifLocalVar59_g59587 = 0;
					if( temp_output_56_0_g59587 <= 0.0 )
					ifLocalVar59_g59587 = temp_output_65_0_g59587;
					else
					ifLocalVar59_g59587 = temp_output_56_0_g59587;
					float temp_output_597_30_g59586 = ifLocalVar59_g59587;
					float2 temp_output_90_0_g59587 = ( temp_output_52_0_g59587 + float2( 0,1 ) );
					float2 temp_output_123_0_g59587 = ( temp_output_52_0_g59587 + float2( 1,0 ) );
					float2 ifLocalVar88_g59587 = 0;
					if( temp_output_56_0_g59587 > 0.0 )
					ifLocalVar88_g59587 = temp_output_90_0_g59587;
					else if( temp_output_56_0_g59587 == 0.0 )
					ifLocalVar88_g59587 = temp_output_123_0_g59587;
					else if( temp_output_56_0_g59587 < 0.0 )
					ifLocalVar88_g59587 = temp_output_123_0_g59587;
					float3 temp_output_7_0_g59589 = frac( ( (ifLocalVar88_g59587).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59589 = dot( temp_output_7_0_g59589 , ( (temp_output_7_0_g59589).yzx + 33.33 ) );
					float3 temp_output_12_0_g59589 = ( temp_output_7_0_g59589 + dotResult8_g59589 );
					float2 temp_output_597_26_g59586 = ( UV100_g59587 + frac( ( ( (temp_output_12_0_g59589).xx + (temp_output_12_0_g59589).yz ) * (temp_output_12_0_g59589).zy ) ) );
					float temp_output_66_0_g59587 = ( 1.0 - break55_g59587.y );
					float ifLocalVar60_g59587 = 0;
					if( temp_output_56_0_g59587 <= 0.0 )
					ifLocalVar60_g59587 = temp_output_66_0_g59587;
					else
					ifLocalVar60_g59587 = break55_g59587.y;
					float temp_output_597_28_g59586 = ifLocalVar60_g59587;
					float2 ifLocalVar89_g59587 = 0;
					if( temp_output_56_0_g59587 > 0.0 )
					ifLocalVar89_g59587 = temp_output_123_0_g59587;
					else if( temp_output_56_0_g59587 == 0.0 )
					ifLocalVar89_g59587 = temp_output_90_0_g59587;
					else if( temp_output_56_0_g59587 < 0.0 )
					ifLocalVar89_g59587 = temp_output_90_0_g59587;
					float3 temp_output_7_0_g59590 = frac( ( (ifLocalVar89_g59587).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59590 = dot( temp_output_7_0_g59590 , ( (temp_output_7_0_g59590).yzx + 33.33 ) );
					float3 temp_output_12_0_g59590 = ( temp_output_7_0_g59590 + dotResult8_g59590 );
					float2 temp_output_597_27_g59586 = ( UV100_g59587 + frac( ( ( (temp_output_12_0_g59590).xx + (temp_output_12_0_g59590).yz ) * (temp_output_12_0_g59590).zy ) ) );
					float temp_output_67_0_g59587 = ( 1.0 - break55_g59587.x );
					float ifLocalVar61_g59587 = 0;
					if( temp_output_56_0_g59587 <= 0.0 )
					ifLocalVar61_g59587 = temp_output_67_0_g59587;
					else
					ifLocalVar61_g59587 = break55_g59587.x;
					float temp_output_597_29_g59586 = ifLocalVar61_g59587;
					float4 Output_2D293_g59586 = ( ( tex2D( _MainTex, temp_output_597_0_g59586, DDX631_g59586, DDY632_g59586 ) * temp_output_597_30_g59586 ) + ( tex2D( _MainTex, temp_output_597_26_g59586, DDX631_g59586, DDY632_g59586 ) * temp_output_597_28_g59586 ) + ( tex2D( _MainTex, temp_output_597_27_g59586, DDX631_g59586, DDY632_g59586 ) * temp_output_597_29_g59586 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g59553 = Output_2D293_g59586;
					#else
					float4 staticSwitch1001_g59553 = tex2D( _MainTex, UV02420_g59553 );
					#endif
					#ifdef _MAINTEX
					float4 staticSwitch1549_g59553 = staticSwitch1001_g59553;
					#else
					float4 staticSwitch1549_g59553 = _Color;
					#endif
					float White38_g59553 = 1.0;
					#ifdef _LIGHTMAPDEBUG
					float staticSwitch1191_g59553 = White38_g59553;
					#else
					float staticSwitch1191_g59553 = staticSwitch1549_g59553.a;
					#endif
					

					half Alpha = staticSwitch1191_g59553;
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
				#define _ALPHABLEND_ON 1
				#define ASE_FRAGMENT_NORMAL 0
				#define ASE_RECEIVE_SHADOWS
				#pragma multi_compile_instancing
				#pragma multi_compile _ LOD_FADE_CROSSFADE
				#define ASE_FOG
				#define ASE_LIGHTING_SIMPLE 1
				#define ASE_NO_AMBIENT 1
				#define _SPECULARHIGHLIGHTS_OFF
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

				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#pragma shader_feature _LIGHTMAPDEBUG
				#pragma shader_feature_local_fragment _MAINTEX
				#pragma shader_feature_local _STOCHASTICENABLED_ON


				float4 _SelectionID;

				struct appdata
				{
					float4 vertex : POSITION;
					half3 normal : NORMAL;
					half4 tangent : TANGENT;
					float4 ase_texcoord : TEXCOORD0;
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct v2f
				{
					float4 pos : SV_POSITION;
					float4 worldPos : TEXCOORD0; // xyz = positionWS
					half3 normalWS : TEXCOORD1;
					float4 ase_texcoord2 : TEXCOORD2;
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


				
				v2f VertexFunction( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					o.ase_texcoord2 = v.ase_texcoord;

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
					o.normal = v.normal;
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
					o.normal = patch[0].normal * bary.x + patch[1].normal * bary.y + patch[2].normal * bary.z;
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

					float2 texCoord2357_g59553 = IN.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV02420_g59553 = texCoord2357_g59553;
					float2 temp_output_5_0_g59586 = UV02420_g59553;
					float2 UV633_g59586 = temp_output_5_0_g59586;
					float2 UV100_g59587 = UV633_g59586;
					float2 temp_output_51_0_g59587 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59587 * float2( 3.464,3.464 ) ) );
					float2 break55_g59587 = frac( temp_output_51_0_g59587 );
					float temp_output_56_0_g59587 = ( ( 1.0 - break55_g59587.x ) - break55_g59587.y );
					float2 temp_output_52_0_g59587 = floor( temp_output_51_0_g59587 );
					float2 temp_output_125_0_g59587 = ( temp_output_52_0_g59587 + float2( 1,1 ) );
					float2 ifLocalVar87_g59587 = 0;
					if( temp_output_56_0_g59587 > 0.0 )
					ifLocalVar87_g59587 = temp_output_52_0_g59587;
					else if( temp_output_56_0_g59587 == 0.0 )
					ifLocalVar87_g59587 = temp_output_125_0_g59587;
					else if( temp_output_56_0_g59587 < 0.0 )
					ifLocalVar87_g59587 = temp_output_125_0_g59587;
					float3 temp_output_7_0_g59588 = frac( ( (ifLocalVar87_g59587).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59588 = dot( temp_output_7_0_g59588 , ( (temp_output_7_0_g59588).yzx + 33.33 ) );
					float3 temp_output_12_0_g59588 = ( temp_output_7_0_g59588 + dotResult8_g59588 );
					float2 temp_output_597_0_g59586 = ( UV100_g59587 + frac( ( ( (temp_output_12_0_g59588).xx + (temp_output_12_0_g59588).yz ) * (temp_output_12_0_g59588).zy ) ) );
					float2 DDX631_g59586 = ddx( temp_output_5_0_g59586 );
					float2 DDY632_g59586 = ddy( temp_output_5_0_g59586 );
					float temp_output_65_0_g59587 = ( 0.0 - temp_output_56_0_g59587 );
					float ifLocalVar59_g59587 = 0;
					if( temp_output_56_0_g59587 <= 0.0 )
					ifLocalVar59_g59587 = temp_output_65_0_g59587;
					else
					ifLocalVar59_g59587 = temp_output_56_0_g59587;
					float temp_output_597_30_g59586 = ifLocalVar59_g59587;
					float2 temp_output_90_0_g59587 = ( temp_output_52_0_g59587 + float2( 0,1 ) );
					float2 temp_output_123_0_g59587 = ( temp_output_52_0_g59587 + float2( 1,0 ) );
					float2 ifLocalVar88_g59587 = 0;
					if( temp_output_56_0_g59587 > 0.0 )
					ifLocalVar88_g59587 = temp_output_90_0_g59587;
					else if( temp_output_56_0_g59587 == 0.0 )
					ifLocalVar88_g59587 = temp_output_123_0_g59587;
					else if( temp_output_56_0_g59587 < 0.0 )
					ifLocalVar88_g59587 = temp_output_123_0_g59587;
					float3 temp_output_7_0_g59589 = frac( ( (ifLocalVar88_g59587).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59589 = dot( temp_output_7_0_g59589 , ( (temp_output_7_0_g59589).yzx + 33.33 ) );
					float3 temp_output_12_0_g59589 = ( temp_output_7_0_g59589 + dotResult8_g59589 );
					float2 temp_output_597_26_g59586 = ( UV100_g59587 + frac( ( ( (temp_output_12_0_g59589).xx + (temp_output_12_0_g59589).yz ) * (temp_output_12_0_g59589).zy ) ) );
					float temp_output_66_0_g59587 = ( 1.0 - break55_g59587.y );
					float ifLocalVar60_g59587 = 0;
					if( temp_output_56_0_g59587 <= 0.0 )
					ifLocalVar60_g59587 = temp_output_66_0_g59587;
					else
					ifLocalVar60_g59587 = break55_g59587.y;
					float temp_output_597_28_g59586 = ifLocalVar60_g59587;
					float2 ifLocalVar89_g59587 = 0;
					if( temp_output_56_0_g59587 > 0.0 )
					ifLocalVar89_g59587 = temp_output_123_0_g59587;
					else if( temp_output_56_0_g59587 == 0.0 )
					ifLocalVar89_g59587 = temp_output_90_0_g59587;
					else if( temp_output_56_0_g59587 < 0.0 )
					ifLocalVar89_g59587 = temp_output_90_0_g59587;
					float3 temp_output_7_0_g59590 = frac( ( (ifLocalVar89_g59587).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59590 = dot( temp_output_7_0_g59590 , ( (temp_output_7_0_g59590).yzx + 33.33 ) );
					float3 temp_output_12_0_g59590 = ( temp_output_7_0_g59590 + dotResult8_g59590 );
					float2 temp_output_597_27_g59586 = ( UV100_g59587 + frac( ( ( (temp_output_12_0_g59590).xx + (temp_output_12_0_g59590).yz ) * (temp_output_12_0_g59590).zy ) ) );
					float temp_output_67_0_g59587 = ( 1.0 - break55_g59587.x );
					float ifLocalVar61_g59587 = 0;
					if( temp_output_56_0_g59587 <= 0.0 )
					ifLocalVar61_g59587 = temp_output_67_0_g59587;
					else
					ifLocalVar61_g59587 = break55_g59587.x;
					float temp_output_597_29_g59586 = ifLocalVar61_g59587;
					float4 Output_2D293_g59586 = ( ( tex2D( _MainTex, temp_output_597_0_g59586, DDX631_g59586, DDY632_g59586 ) * temp_output_597_30_g59586 ) + ( tex2D( _MainTex, temp_output_597_26_g59586, DDX631_g59586, DDY632_g59586 ) * temp_output_597_28_g59586 ) + ( tex2D( _MainTex, temp_output_597_27_g59586, DDX631_g59586, DDY632_g59586 ) * temp_output_597_29_g59586 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g59553 = Output_2D293_g59586;
					#else
					float4 staticSwitch1001_g59553 = tex2D( _MainTex, UV02420_g59553 );
					#endif
					#ifdef _MAINTEX
					float4 staticSwitch1549_g59553 = staticSwitch1001_g59553;
					#else
					float4 staticSwitch1549_g59553 = _Color;
					#endif
					float White38_g59553 = 1.0;
					#ifdef _LIGHTMAPDEBUG
					float staticSwitch1191_g59553 = White38_g59553;
					#else
					float staticSwitch1191_g59553 = staticSwitch1549_g59553.a;
					#endif
					

					half Alpha = staticSwitch1191_g59553;
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
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;12;-320,0;Inherit;False;Meenphie;0;;59553;b3ba55a08dd6b49c7be16c6f35cf2033;1,1008,0;0;5;FLOAT3;625;FLOAT3;624;FLOAT;156;FLOAT;427;FLOAT3;1024
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1;0,0;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2;0,0;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;12;Meenphie/Standard/Transparent Blend;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardBase;0;1;ForwardBase;17;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;1;False;;True;3;False;;False;False;True;3;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;1;5;False;;10;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;44;Category;0;0;  Instanced Terrain Normals;1;0;Workflow;3;639073670281448880;Surface;1;639073670302367760;  Blend;0;0;  Dither Shadows;0;639073793954374050;Two Sided;0;639073793987660130;Alpha Clipping;0;0;  Use Shadow Threshold;0;0;Deferred Pass;0;639079951110521800;Normal Space;0;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;1;0;Receive Shadows;1;0;Receive Specular;0;639073808757328170;Receive Reflections;1;639073808765822660;GPU Instancing;1;0;LOD CrossFade;1;0;Built-in Fog;1;0;Ambient Light;0;639073784690656320;Meta Pass;0;639073784693261280;Add Pass;0;639073784695577680;Override Baked GI;0;0;Write Depth;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;0;Vertex Position;1;0;0;8;False;True;False;False;False;True;True;True;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3;0,0;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;4;5;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;True;1;LightMode=ForwardAdd;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;4;0,0;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5;0,0;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;6;0,0;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;7;0,0;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;8;0,0;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ScenePickingPass;0;7;ScenePickingPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=Picking;False;False;0;;0;0;Standard;0;False;0
WireConnection;2;0;12;625
WireConnection;2;2;12;624
WireConnection;2;7;12;156
ASEEND*/
//CHKSM=8D7D206C9117B39FB9378F5A3DDBE9A0D5F6B93B