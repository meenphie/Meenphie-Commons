// Made with Amplify Shader Editor v1.9.9.7
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SSR"
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
		[Toggle( _USEGEOMETRICANTIALIASING_ON )] _UseGeometricAntiAliasing( "Use Geometric Anti Aliasing", Float ) = 1
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
		[HideInInspector] GenKey__MainTex( "Assign keyword _MAINTEX", Float ) = 1.0
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0
		[HideInInspector] GenKey__2DLut( "Assign keyword _2DLUT", Float ) = 1.0
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

		GrabPass{ }

		Pass
		{
			
			Name "ForwardBase"
			Tags { "LightMode"="ForwardBase" }

			Blend One Zero

			CGPROGRAM
				#define ASE_GEOMETRY
				#define ASE_FRAGMENT_NORMAL 0
				#define ASE_RECEIVE_SHADOWS
				#pragma multi_compile_instancing
				#pragma multi_compile _ LOD_FADE_CROSSFADE
				#pragma multi_compile_fog
				#define ASE_FOG
				#define ASE_LIGHTING_SIMPLE 1
				#define _SPECULARHIGHLIGHTS_OFF
				#define _GLOSSYREFLECTIONS_OFF
				#define ASE_VERSION 19907
				#if defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED)
				#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex);
				#else
				#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex)
				#endif

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
				#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
				#define ASE_NEEDS_WORLD_TANGENT
				#define ASE_NEEDS_FRAG_WORLD_TANGENT
				#define ASE_NEEDS_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_BITANGENT
				#pragma shader_feature _LIGHTMAPDEBUG
				#pragma shader_feature_local_fragment _MAINTEX
				#pragma shader_feature_local _STOCHASTICENABLED_ON
				#pragma shader_feature_local_fragment _METALLICMAP
				#pragma shader_feature_local _LIGHTMAPMODE_DISABLED _LIGHTMAPMODE_SIMPLE _LIGHTMAPMODE_SIMPLELERP _LIGHTMAPMODE_RNM _LIGHTMAPMODE_RNMLERP
				#pragma shader_feature_local _USEBICUBICFILTERING_ON
				#pragma shader_feature_local_fragment _BUMPMAP
				#pragma shader_feature_local_fragment _USELIGHTMAPSPECULAR_ON
				#pragma shader_feature_local_fragment _USEGEOMETRICANTIALIASING_ON
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
				UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
				uniform float4 _UdonSpecularLightUp[32];
				uniform float4 _UdonSpecularLightRight[32];
				uniform float4 _UdonSpecularLightCol[32];
				uniform float4 _UdonSpecularLightPos[32];
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
				ASE_DECLARE_SCREENSPACE_TEXTURE( _GrabTexture )


				float3 Specular( float3 WorldPos, float3 WorldNormal, float Smoothness, float3 LightmapColor, float3 ViewDir )
				{
					// --- CONFIGURATION ORIGINALE ---
					float LumaStart = 0.01;
					float LumaEnd   = 1.0;
					float SpecBoost = 0.2;
					// --- CONFIGURATION TRANSITION RADIUS ---
					// Doit être cohérent avec ton activationRadius dans Udon (50.0)
					float MaxRadius = 8.0; 
					float RadiusFadeStart = 0.0; // Le fondu commence à 40m
					// --- 1. EARLY EXIT ---
					float luma = dot(LightmapColor, float3(0.22, 0.70, 0.08));
					float lmMask = smoothstep(LumaStart, LumaEnd, luma);
					if (lmMask < 0.001 || Smoothness < 0.01 || _UdonSpecularLightCount == 0) return 0;
					// --- CALCUL DU FADE DE RAYON (SÉCURITÉ UDON) ---
					float playerDist = distance(_WorldSpaceCameraPos, WorldPos);
					// On crée un masque qui s'adoucit quand on s'approche des 50m
					float radiusFade = 1.0 - smoothstep(RadiusFadeStart, MaxRadius, playerDist);
					// Exit si on est au-delà du rayon d'activation
					if (radiusFade < 0.001) return 0;
					// --- 2. SETUP ---
					float3 vDir = normalize(ViewDir);
					float3 N = normalize(WorldNormal);
					float sharpSmooth = pow(Smoothness, 1.5); 
					float shininess = exp2(10.0 * sharpSmooth + 2.0); 
					float normalization = (shininess + 2.0) * 0.125;
					float nv = saturate(dot(N, vDir));
					float fresnel = 0.04 + 0.96 * pow(1.0 - nv, 5.0); 
					float3 R = reflect(-vDir, N);
					float3 specAccum = 0.0;
					// --- 3. BOUCLE ---
					int lightCount = (int)_UdonSpecularLightCount;
					for (int i = 0; i < lightCount; i++)
					{
					    float4 lightPosRange = _UdonSpecularLightPos[i];
					    float3 center = lightPosRange.xyz;
					    float range   = lightPosRange.w;
					    float3 L = center - WorldPos;
					    
					    float3 proj = R * dot(L, R) - L;
					    float3 closestPoint = center;
					    closestPoint += _UdonSpecularLightRight[i].xyz * clamp(dot(proj, _UdonSpecularLightRight[i].xyz), -_UdonSpecularLightRight[i].w, _UdonSpecularLightRight[i].w);
					    closestPoint += _UdonSpecularLightUp[i].xyz * clamp(dot(proj, _UdonSpecularLightUp[i].xyz), -_UdonSpecularLightUp[i].w, _UdonSpecularLightUp[i].w);
					    float3 diff = closestPoint - WorldPos;
					    float distSq = dot(diff, diff);
					    
					    float falloff = saturate(1.0 - (distSq / (range * range)));
					    falloff *= falloff; 
					    if (falloff > 0)
					    {
					        float3 lDir = normalize(diff);
					        float nDotL = saturate(dot(N, lDir));
					        if (nDotL > 0)
					        {
					            float nDotH = saturate(dot(N, normalize(lDir + vDir)));
					            float spec = pow(nDotH, shininess) * normalization;
					            specAccum += _UdonSpecularLightCol[i].rgb * (spec * nDotL * _UdonSpecularLightCol[i].w * falloff);
					        }
					    }
					}
					// Multiplié par radiusFade pour une disparition douce aux limites de l'Udon
					return specAccum * fresnel * lmMask * SpecBoost * radiusFade;
				}
				
				float4 MyCustomExpression8_g59713( float3 worldPos, float3 worldNormal, float3 viewDir, float _Steps, float _StepSize, float _Thickness, float _Jitter )
				{
					// Calcul des UV écran pour le Jitter et la profondeur
					float2 screenUV = ComputeScreenPos(mul(unity_MatrixVP, float4(worldPos, 1.0))).xy / ComputeScreenPos(mul(unity_MatrixVP, float4(worldPos, 1.0))).w;
					float3 V = normalize(viewDir);
					float3 N = normalize(worldNormal);
					float3 R = reflect(-V, N);
					float3 vPos = mul(unity_MatrixV, float4(worldPos, 1.0)).xyz;
					float3 vDir = mul((float3x3)unity_MatrixV, R);
					vDir = normalize(vDir);
					// Utilisation du Jitter pour casser les lignes
					float noise = frac(sin(dot(screenUV, float2(12.9898, 78.233))) * 43758.5453);
					float currentDist = _StepSize + (noise * _StepSize * _Jitter);
					float4 res = float4(0,0,0,0);
					for (int i = 0; i < (int)_Steps; i++)
					{
					    float3 p = vPos + vDir * currentDist;
					    float4 proj = mul(unity_CameraProjection, float4(p, 1.0));
					    float2 uv = (proj.xy / proj.w) * 0.5 + 0.5;
					    // Sortie si hors écran
					    if (uv.x < 0 || uv.x > 1 || uv.y < 0 || uv.y > 1) break;
					    // Lecture de la profondeur
					    float sceneZ = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, uv));
					    float rayZ = -p.z;
					    // Épaisseur adaptative (astuce pour "souder" les lignes)
					    float thickness = _Thickness * (1.0 + currentDist * 0.1);
					    if (rayZ > sceneZ && rayZ < sceneZ + thickness)
					    {
					        // On renvoie les UV pour le Grab Screen et 1 dans le W pour le masque
					        return float4(uv, 0, 1.0);
					    }
					    currentDist += _StepSize;
					}
					return res;
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

					float2 texCoord2357_g59660 = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV02420_g59660 = texCoord2357_g59660;
					float2 temp_output_5_0_g59707 = UV02420_g59660;
					float2 UV633_g59707 = temp_output_5_0_g59707;
					float2 UV100_g59708 = UV633_g59707;
					float2 temp_output_51_0_g59708 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59708 * float2( 3.464,3.464 ) ) );
					float2 break55_g59708 = frac( temp_output_51_0_g59708 );
					float temp_output_56_0_g59708 = ( ( 1.0 - break55_g59708.x ) - break55_g59708.y );
					float2 temp_output_52_0_g59708 = floor( temp_output_51_0_g59708 );
					float2 temp_output_125_0_g59708 = ( temp_output_52_0_g59708 + float2( 1,1 ) );
					float2 ifLocalVar87_g59708 = 0;
					if( temp_output_56_0_g59708 > 0.0 )
					ifLocalVar87_g59708 = temp_output_52_0_g59708;
					else if( temp_output_56_0_g59708 == 0.0 )
					ifLocalVar87_g59708 = temp_output_125_0_g59708;
					else if( temp_output_56_0_g59708 < 0.0 )
					ifLocalVar87_g59708 = temp_output_125_0_g59708;
					float3 temp_output_7_0_g59709 = frac( ( (ifLocalVar87_g59708).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59709 = dot( temp_output_7_0_g59709 , ( (temp_output_7_0_g59709).yzx + 33.33 ) );
					float3 temp_output_12_0_g59709 = ( temp_output_7_0_g59709 + dotResult8_g59709 );
					float2 temp_output_597_0_g59707 = ( UV100_g59708 + frac( ( ( (temp_output_12_0_g59709).xx + (temp_output_12_0_g59709).yz ) * (temp_output_12_0_g59709).zy ) ) );
					float2 DDX631_g59707 = ddx( temp_output_5_0_g59707 );
					float2 DDY632_g59707 = ddy( temp_output_5_0_g59707 );
					float temp_output_65_0_g59708 = ( 0.0 - temp_output_56_0_g59708 );
					float ifLocalVar59_g59708 = 0;
					if( temp_output_56_0_g59708 <= 0.0 )
					ifLocalVar59_g59708 = temp_output_65_0_g59708;
					else
					ifLocalVar59_g59708 = temp_output_56_0_g59708;
					float temp_output_597_30_g59707 = ifLocalVar59_g59708;
					float2 temp_output_90_0_g59708 = ( temp_output_52_0_g59708 + float2( 0,1 ) );
					float2 temp_output_123_0_g59708 = ( temp_output_52_0_g59708 + float2( 1,0 ) );
					float2 ifLocalVar88_g59708 = 0;
					if( temp_output_56_0_g59708 > 0.0 )
					ifLocalVar88_g59708 = temp_output_90_0_g59708;
					else if( temp_output_56_0_g59708 == 0.0 )
					ifLocalVar88_g59708 = temp_output_123_0_g59708;
					else if( temp_output_56_0_g59708 < 0.0 )
					ifLocalVar88_g59708 = temp_output_123_0_g59708;
					float3 temp_output_7_0_g59710 = frac( ( (ifLocalVar88_g59708).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59710 = dot( temp_output_7_0_g59710 , ( (temp_output_7_0_g59710).yzx + 33.33 ) );
					float3 temp_output_12_0_g59710 = ( temp_output_7_0_g59710 + dotResult8_g59710 );
					float2 temp_output_597_26_g59707 = ( UV100_g59708 + frac( ( ( (temp_output_12_0_g59710).xx + (temp_output_12_0_g59710).yz ) * (temp_output_12_0_g59710).zy ) ) );
					float temp_output_66_0_g59708 = ( 1.0 - break55_g59708.y );
					float ifLocalVar60_g59708 = 0;
					if( temp_output_56_0_g59708 <= 0.0 )
					ifLocalVar60_g59708 = temp_output_66_0_g59708;
					else
					ifLocalVar60_g59708 = break55_g59708.y;
					float temp_output_597_28_g59707 = ifLocalVar60_g59708;
					float2 ifLocalVar89_g59708 = 0;
					if( temp_output_56_0_g59708 > 0.0 )
					ifLocalVar89_g59708 = temp_output_123_0_g59708;
					else if( temp_output_56_0_g59708 == 0.0 )
					ifLocalVar89_g59708 = temp_output_90_0_g59708;
					else if( temp_output_56_0_g59708 < 0.0 )
					ifLocalVar89_g59708 = temp_output_90_0_g59708;
					float3 temp_output_7_0_g59711 = frac( ( (ifLocalVar89_g59708).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59711 = dot( temp_output_7_0_g59711 , ( (temp_output_7_0_g59711).yzx + 33.33 ) );
					float3 temp_output_12_0_g59711 = ( temp_output_7_0_g59711 + dotResult8_g59711 );
					float2 temp_output_597_27_g59707 = ( UV100_g59708 + frac( ( ( (temp_output_12_0_g59711).xx + (temp_output_12_0_g59711).yz ) * (temp_output_12_0_g59711).zy ) ) );
					float temp_output_67_0_g59708 = ( 1.0 - break55_g59708.x );
					float ifLocalVar61_g59708 = 0;
					if( temp_output_56_0_g59708 <= 0.0 )
					ifLocalVar61_g59708 = temp_output_67_0_g59708;
					else
					ifLocalVar61_g59708 = break55_g59708.x;
					float temp_output_597_29_g59707 = ifLocalVar61_g59708;
					float4 Output_2D293_g59707 = ( ( tex2D( _MainTex, temp_output_597_0_g59707, DDX631_g59707, DDY632_g59707 ) * temp_output_597_30_g59707 ) + ( tex2D( _MainTex, temp_output_597_26_g59707, DDX631_g59707, DDY632_g59707 ) * temp_output_597_28_g59707 ) + ( tex2D( _MainTex, temp_output_597_27_g59707, DDX631_g59707, DDY632_g59707 ) * temp_output_597_29_g59707 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g59660 = Output_2D293_g59707;
					#else
					float4 staticSwitch1001_g59660 = tex2D( _MainTex, UV02420_g59660 );
					#endif
					#ifdef _MAINTEX
					float4 staticSwitch1549_g59660 = staticSwitch1001_g59660;
					#else
					float4 staticSwitch1549_g59660 = _Color;
					#endif
					float4 oAlbedo6_g59660 = staticSwitch1549_g59660;
					float Black1185_g59660 = 0.0;
					float4 temp_cast_0 = (Black1185_g59660).xxxx;
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1180_g59660 = temp_cast_0;
					#else
					float4 staticSwitch1180_g59660 = oAlbedo6_g59660;
					#endif
					
					float2 temp_output_5_0_g59666 = UV02420_g59660;
					float2 UV633_g59666 = temp_output_5_0_g59666;
					float2 UV100_g59667 = UV633_g59666;
					float2 temp_output_51_0_g59667 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59667 * float2( 3.464,3.464 ) ) );
					float2 break55_g59667 = frac( temp_output_51_0_g59667 );
					float temp_output_56_0_g59667 = ( ( 1.0 - break55_g59667.x ) - break55_g59667.y );
					float2 temp_output_52_0_g59667 = floor( temp_output_51_0_g59667 );
					float2 temp_output_125_0_g59667 = ( temp_output_52_0_g59667 + float2( 1,1 ) );
					float2 ifLocalVar87_g59667 = 0;
					if( temp_output_56_0_g59667 > 0.0 )
					ifLocalVar87_g59667 = temp_output_52_0_g59667;
					else if( temp_output_56_0_g59667 == 0.0 )
					ifLocalVar87_g59667 = temp_output_125_0_g59667;
					else if( temp_output_56_0_g59667 < 0.0 )
					ifLocalVar87_g59667 = temp_output_125_0_g59667;
					float3 temp_output_7_0_g59668 = frac( ( (ifLocalVar87_g59667).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59668 = dot( temp_output_7_0_g59668 , ( (temp_output_7_0_g59668).yzx + 33.33 ) );
					float3 temp_output_12_0_g59668 = ( temp_output_7_0_g59668 + dotResult8_g59668 );
					float2 temp_output_597_0_g59666 = ( UV100_g59667 + frac( ( ( (temp_output_12_0_g59668).xx + (temp_output_12_0_g59668).yz ) * (temp_output_12_0_g59668).zy ) ) );
					float2 DDX631_g59666 = ddx( temp_output_5_0_g59666 );
					float2 DDY632_g59666 = ddy( temp_output_5_0_g59666 );
					float temp_output_65_0_g59667 = ( 0.0 - temp_output_56_0_g59667 );
					float ifLocalVar59_g59667 = 0;
					if( temp_output_56_0_g59667 <= 0.0 )
					ifLocalVar59_g59667 = temp_output_65_0_g59667;
					else
					ifLocalVar59_g59667 = temp_output_56_0_g59667;
					float temp_output_597_30_g59666 = ifLocalVar59_g59667;
					float2 temp_output_90_0_g59667 = ( temp_output_52_0_g59667 + float2( 0,1 ) );
					float2 temp_output_123_0_g59667 = ( temp_output_52_0_g59667 + float2( 1,0 ) );
					float2 ifLocalVar88_g59667 = 0;
					if( temp_output_56_0_g59667 > 0.0 )
					ifLocalVar88_g59667 = temp_output_90_0_g59667;
					else if( temp_output_56_0_g59667 == 0.0 )
					ifLocalVar88_g59667 = temp_output_123_0_g59667;
					else if( temp_output_56_0_g59667 < 0.0 )
					ifLocalVar88_g59667 = temp_output_123_0_g59667;
					float3 temp_output_7_0_g59669 = frac( ( (ifLocalVar88_g59667).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59669 = dot( temp_output_7_0_g59669 , ( (temp_output_7_0_g59669).yzx + 33.33 ) );
					float3 temp_output_12_0_g59669 = ( temp_output_7_0_g59669 + dotResult8_g59669 );
					float2 temp_output_597_26_g59666 = ( UV100_g59667 + frac( ( ( (temp_output_12_0_g59669).xx + (temp_output_12_0_g59669).yz ) * (temp_output_12_0_g59669).zy ) ) );
					float temp_output_66_0_g59667 = ( 1.0 - break55_g59667.y );
					float ifLocalVar60_g59667 = 0;
					if( temp_output_56_0_g59667 <= 0.0 )
					ifLocalVar60_g59667 = temp_output_66_0_g59667;
					else
					ifLocalVar60_g59667 = break55_g59667.y;
					float temp_output_597_28_g59666 = ifLocalVar60_g59667;
					float2 ifLocalVar89_g59667 = 0;
					if( temp_output_56_0_g59667 > 0.0 )
					ifLocalVar89_g59667 = temp_output_123_0_g59667;
					else if( temp_output_56_0_g59667 == 0.0 )
					ifLocalVar89_g59667 = temp_output_90_0_g59667;
					else if( temp_output_56_0_g59667 < 0.0 )
					ifLocalVar89_g59667 = temp_output_90_0_g59667;
					float3 temp_output_7_0_g59670 = frac( ( (ifLocalVar89_g59667).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59670 = dot( temp_output_7_0_g59670 , ( (temp_output_7_0_g59670).yzx + 33.33 ) );
					float3 temp_output_12_0_g59670 = ( temp_output_7_0_g59670 + dotResult8_g59670 );
					float2 temp_output_597_27_g59666 = ( UV100_g59667 + frac( ( ( (temp_output_12_0_g59670).xx + (temp_output_12_0_g59670).yz ) * (temp_output_12_0_g59670).zy ) ) );
					float temp_output_67_0_g59667 = ( 1.0 - break55_g59667.x );
					float ifLocalVar61_g59667 = 0;
					if( temp_output_56_0_g59667 <= 0.0 )
					ifLocalVar61_g59667 = temp_output_67_0_g59667;
					else
					ifLocalVar61_g59667 = break55_g59667.x;
					float temp_output_597_29_g59666 = ifLocalVar61_g59667;
					float4 Output_2D293_g59666 = ( ( tex2D( _MetallicMap, temp_output_597_0_g59666, DDX631_g59666, DDY632_g59666 ) * temp_output_597_30_g59666 ) + ( tex2D( _MetallicMap, temp_output_597_26_g59666, DDX631_g59666, DDY632_g59666 ) * temp_output_597_28_g59666 ) + ( tex2D( _MetallicMap, temp_output_597_27_g59666, DDX631_g59666, DDY632_g59666 ) * temp_output_597_29_g59666 ) );
					float4 break31_g59666 = Output_2D293_g59666;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g59660 = break31_g59666.a;
					#else
					float staticSwitch1005_g59660 = tex2D( _MetallicMap, UV02420_g59660 ).a;
					#endif
					#ifdef _METALLICMAP
					float staticSwitch846_g59660 = staticSwitch1005_g59660;
					#else
					float staticSwitch846_g59660 = _Metallic;
					#endif
					float Metallic1239_g59660 = staticSwitch846_g59660;
					float4 aAlbedo1466_g59660 = ( staticSwitch1549_g59660 * ( 1.0 - Metallic1239_g59660 ) );
					float White38_g59660 = 1.0;
					float4 temp_cast_2 = (White38_g59660).xxxx;
					float4 texCoord2426_g59660 = IN.ase_texcoord6;
					texCoord2426_g59660.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV12361_g59660 = (texCoord2426_g59660).zw;
					float localBicubicPrepare2_g59701 = ( 0.0 );
					float2 Input_UV100_g59701 = UV12361_g59660;
					float2 UV2_g59701 = Input_UV100_g59701;
					float4 TexelSize2_g59701 = _Lightmap0_TexelSize;
					float2 UV02_g59701 = float2( 0,0 );
					float2 UV12_g59701 = float2( 0,0 );
					float2 UV22_g59701 = float2( 0,0 );
					float2 UV32_g59701 = float2( 0,0 );
					float W02_g59701 = 0;
					float W12_g59701 = 0;
					{
					{
					 UV2_g59701 = UV2_g59701 * TexelSize2_g59701.zw - 0.5;
					    float2 f = frac( UV2_g59701 );
					    UV2_g59701 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59701.x - 0.5, UV2_g59701.x + 1.5, UV2_g59701.y - 0.5, UV2_g59701.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59701.xyxy;
					    UV02_g59701 = off.xz;
					    UV12_g59701 = off.yz;
					    UV22_g59701 = off.xw;
					    UV32_g59701 = off.yw;
					    W02_g59701 = s.x / ( s.x + s.y );
					 W12_g59701 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59701 = lerp( tex2D( _Lightmap0, UV32_g59701 ) , tex2D( _Lightmap0, UV22_g59701 ) , W02_g59701);
					float4 lerpResult45_g59701 = lerp( tex2D( _Lightmap0, UV12_g59701 ) , tex2D( _Lightmap0, UV02_g59701 ) , W02_g59701);
					float4 lerpResult44_g59701 = lerp( lerpResult46_g59701 , lerpResult45_g59701 , W12_g59701);
					float4 Output_2D_Auto131_g59701 = lerpResult44_g59701;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g59660 = Output_2D_Auto131_g59701;
					#else
					float4 staticSwitch1092_g59660 = tex2D( _Lightmap0, UV12361_g59660 );
					#endif
					float4 Lightmap_0925_g59660 = staticSwitch1092_g59660;
					float localBicubicPrepare2_g59699 = ( 0.0 );
					float2 Input_UV100_g59699 = UV12361_g59660;
					float2 UV2_g59699 = Input_UV100_g59699;
					float4 TexelSize2_g59699 = _Lightmap1_TexelSize;
					float2 UV02_g59699 = float2( 0,0 );
					float2 UV12_g59699 = float2( 0,0 );
					float2 UV22_g59699 = float2( 0,0 );
					float2 UV32_g59699 = float2( 0,0 );
					float W02_g59699 = 0;
					float W12_g59699 = 0;
					{
					{
					 UV2_g59699 = UV2_g59699 * TexelSize2_g59699.zw - 0.5;
					    float2 f = frac( UV2_g59699 );
					    UV2_g59699 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59699.x - 0.5, UV2_g59699.x + 1.5, UV2_g59699.y - 0.5, UV2_g59699.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59699.xyxy;
					    UV02_g59699 = off.xz;
					    UV12_g59699 = off.yz;
					    UV22_g59699 = off.xw;
					    UV32_g59699 = off.yw;
					    W02_g59699 = s.x / ( s.x + s.y );
					 W12_g59699 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59699 = lerp( tex2D( _Lightmap1, UV32_g59699 ) , tex2D( _Lightmap1, UV22_g59699 ) , W02_g59699);
					float4 lerpResult45_g59699 = lerp( tex2D( _Lightmap1, UV12_g59699 ) , tex2D( _Lightmap1, UV02_g59699 ) , W02_g59699);
					float4 lerpResult44_g59699 = lerp( lerpResult46_g59699 , lerpResult45_g59699 , W12_g59699);
					float4 Output_2D_Auto131_g59699 = lerpResult44_g59699;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g59660 = Output_2D_Auto131_g59699;
					#else
					float4 staticSwitch1088_g59660 = tex2D( _Lightmap1, UV12361_g59660 );
					#endif
					float4 Lightmap_1956_g59660 = staticSwitch1088_g59660;
					float4 lerpResult442_g59660 = lerp( Lightmap_0925_g59660 , Lightmap_1956_g59660 , _LIGHTMAPLERP);
					float4 Lightmap_Lerp932_g59660 = lerpResult442_g59660;
					float3 appendResult139_g59689 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float2 temp_output_5_0_g59661 = UV02420_g59660;
					float2 UV633_g59661 = temp_output_5_0_g59661;
					float2 UV100_g59662 = UV633_g59661;
					float2 temp_output_51_0_g59662 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59662 * float2( 3.464,3.464 ) ) );
					float2 break55_g59662 = frac( temp_output_51_0_g59662 );
					float temp_output_56_0_g59662 = ( ( 1.0 - break55_g59662.x ) - break55_g59662.y );
					float2 temp_output_52_0_g59662 = floor( temp_output_51_0_g59662 );
					float2 temp_output_125_0_g59662 = ( temp_output_52_0_g59662 + float2( 1,1 ) );
					float2 ifLocalVar87_g59662 = 0;
					if( temp_output_56_0_g59662 > 0.0 )
					ifLocalVar87_g59662 = temp_output_52_0_g59662;
					else if( temp_output_56_0_g59662 == 0.0 )
					ifLocalVar87_g59662 = temp_output_125_0_g59662;
					else if( temp_output_56_0_g59662 < 0.0 )
					ifLocalVar87_g59662 = temp_output_125_0_g59662;
					float3 temp_output_7_0_g59663 = frac( ( (ifLocalVar87_g59662).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59663 = dot( temp_output_7_0_g59663 , ( (temp_output_7_0_g59663).yzx + 33.33 ) );
					float3 temp_output_12_0_g59663 = ( temp_output_7_0_g59663 + dotResult8_g59663 );
					float2 temp_output_597_0_g59661 = ( UV100_g59662 + frac( ( ( (temp_output_12_0_g59663).xx + (temp_output_12_0_g59663).yz ) * (temp_output_12_0_g59663).zy ) ) );
					float2 DDX631_g59661 = ddx( temp_output_5_0_g59661 );
					float2 DDY632_g59661 = ddy( temp_output_5_0_g59661 );
					float Input_Scale617_g59661 = 2.0;
					float temp_output_65_0_g59662 = ( 0.0 - temp_output_56_0_g59662 );
					float ifLocalVar59_g59662 = 0;
					if( temp_output_56_0_g59662 <= 0.0 )
					ifLocalVar59_g59662 = temp_output_65_0_g59662;
					else
					ifLocalVar59_g59662 = temp_output_56_0_g59662;
					float temp_output_597_30_g59661 = ifLocalVar59_g59662;
					float2 temp_output_90_0_g59662 = ( temp_output_52_0_g59662 + float2( 0,1 ) );
					float2 temp_output_123_0_g59662 = ( temp_output_52_0_g59662 + float2( 1,0 ) );
					float2 ifLocalVar88_g59662 = 0;
					if( temp_output_56_0_g59662 > 0.0 )
					ifLocalVar88_g59662 = temp_output_90_0_g59662;
					else if( temp_output_56_0_g59662 == 0.0 )
					ifLocalVar88_g59662 = temp_output_123_0_g59662;
					else if( temp_output_56_0_g59662 < 0.0 )
					ifLocalVar88_g59662 = temp_output_123_0_g59662;
					float3 temp_output_7_0_g59664 = frac( ( (ifLocalVar88_g59662).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59664 = dot( temp_output_7_0_g59664 , ( (temp_output_7_0_g59664).yzx + 33.33 ) );
					float3 temp_output_12_0_g59664 = ( temp_output_7_0_g59664 + dotResult8_g59664 );
					float2 temp_output_597_26_g59661 = ( UV100_g59662 + frac( ( ( (temp_output_12_0_g59664).xx + (temp_output_12_0_g59664).yz ) * (temp_output_12_0_g59664).zy ) ) );
					float temp_output_66_0_g59662 = ( 1.0 - break55_g59662.y );
					float ifLocalVar60_g59662 = 0;
					if( temp_output_56_0_g59662 <= 0.0 )
					ifLocalVar60_g59662 = temp_output_66_0_g59662;
					else
					ifLocalVar60_g59662 = break55_g59662.y;
					float temp_output_597_28_g59661 = ifLocalVar60_g59662;
					float2 ifLocalVar89_g59662 = 0;
					if( temp_output_56_0_g59662 > 0.0 )
					ifLocalVar89_g59662 = temp_output_123_0_g59662;
					else if( temp_output_56_0_g59662 == 0.0 )
					ifLocalVar89_g59662 = temp_output_90_0_g59662;
					else if( temp_output_56_0_g59662 < 0.0 )
					ifLocalVar89_g59662 = temp_output_90_0_g59662;
					float3 temp_output_7_0_g59665 = frac( ( (ifLocalVar89_g59662).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59665 = dot( temp_output_7_0_g59665 , ( (temp_output_7_0_g59665).yzx + 33.33 ) );
					float3 temp_output_12_0_g59665 = ( temp_output_7_0_g59665 + dotResult8_g59665 );
					float2 temp_output_597_27_g59661 = ( UV100_g59662 + frac( ( ( (temp_output_12_0_g59665).xx + (temp_output_12_0_g59665).yz ) * (temp_output_12_0_g59665).zy ) ) );
					float temp_output_67_0_g59662 = ( 1.0 - break55_g59662.x );
					float ifLocalVar61_g59662 = 0;
					if( temp_output_56_0_g59662 <= 0.0 )
					ifLocalVar61_g59662 = temp_output_67_0_g59662;
					else
					ifLocalVar61_g59662 = break55_g59662.x;
					float temp_output_597_29_g59661 = ifLocalVar61_g59662;
					float3 Output_2D_Normal641_g59661 = ( ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_0_g59661, DDX631_g59661, DDY632_g59661 ), Input_Scale617_g59661 ) * temp_output_597_30_g59661 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_26_g59661, DDX631_g59661, DDY632_g59661 ), Input_Scale617_g59661 ) * temp_output_597_28_g59661 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_27_g59661, DDX631_g59661, DDY632_g59661 ), Input_Scale617_g59661 ) * float3( 0,0,0 ) * temp_output_597_29_g59661 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g59660 = Output_2D_Normal641_g59661;
					#else
					float3 staticSwitch1003_g59660 = UnpackScaleNormal( tex2D( _BumpMap, UV02420_g59660 ), 2.0 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g59660 = staticSwitch1003_g59660;
					#else
					float3 staticSwitch980_g59660 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g59660 = staticSwitch980_g59660;
					float3 normalizeResult326_g59689 = normalize( Normal_Map700_g59660 );
					float3 Normal_Map318_g59689 = normalizeResult326_g59689;
					float dotResult121_g59689 = dot( appendResult139_g59689 , Normal_Map318_g59689 );
					float temp_output_2_0_g59692 = saturate( dotResult121_g59689 );
					float localStochasticTiling2_g59703 = ( 0.0 );
					float2 UV2_g59703 = UV12361_g59660;
					float4 TexelSize2_g59703 = _RNMX0_TexelSize;
					float4 Offsets2_g59703 = float4( 0,0,0,0 );
					float2 Weights2_g59703 = float2( 0,0 );
					{
					UV2_g59703 = UV2_g59703 * TexelSize2_g59703.zw - 0.5;
					float2 f = frac( UV2_g59703 );
					UV2_g59703 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g59703.x - 0.5, UV2_g59703.x + 1.5, UV2_g59703.y - 0.5, UV2_g59703.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g59703 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59703.xyxy;
					Weights2_g59703 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g59702 = Offsets2_g59703;
					float4 Input_FetchOffsets197_g59704 = temp_output_1_34_g59702;
					float2 temp_output_1_54_g59702 = Weights2_g59703;
					float2 Input_FetchWeights200_g59704 = temp_output_1_54_g59702;
					float2 break187_g59704 = Input_FetchWeights200_g59704;
					float4 lerpResult181_g59704 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g59704).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g59704).xw ) , break187_g59704.x);
					float4 lerpResult182_g59704 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g59704).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g59704).xz ) , break187_g59704.x);
					float4 lerpResult176_g59704 = lerp( lerpResult181_g59704 , lerpResult182_g59704 , break187_g59704.y);
					float4 Output_Fetch2D_Auto202_g59704 = lerpResult176_g59704;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g59660 = Output_Fetch2D_Auto202_g59704;
					#else
					float4 staticSwitch1061_g59660 = tex2D( _RNMX0, UV12361_g59660 );
					#endif
					float3 appendResult146_g59689 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59689 = dot( appendResult146_g59689 , Normal_Map318_g59689 );
					float temp_output_2_0_g59691 = saturate( dotResult122_g59689 );
					float4 Input_FetchOffsets197_g59705 = temp_output_1_34_g59702;
					float2 Input_FetchWeights200_g59705 = temp_output_1_54_g59702;
					float2 break187_g59705 = Input_FetchWeights200_g59705;
					float4 lerpResult181_g59705 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g59705).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g59705).xw ) , break187_g59705.x);
					float4 lerpResult182_g59705 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g59705).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g59705).xz ) , break187_g59705.x);
					float4 lerpResult176_g59705 = lerp( lerpResult181_g59705 , lerpResult182_g59705 , break187_g59705.y);
					float4 Output_Fetch2D_Auto202_g59705 = lerpResult176_g59705;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g59660 = Output_Fetch2D_Auto202_g59705;
					#else
					float4 staticSwitch1062_g59660 = tex2D( _RNMY0, UV12361_g59660 );
					#endif
					float3 appendResult149_g59689 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59689 = dot( appendResult149_g59689 , Normal_Map318_g59689 );
					float temp_output_2_0_g59690 = saturate( dotResult120_g59689 );
					float4 Input_FetchOffsets197_g59706 = temp_output_1_34_g59702;
					float2 Input_FetchWeights200_g59706 = temp_output_1_54_g59702;
					float2 break187_g59706 = Input_FetchWeights200_g59706;
					float4 lerpResult181_g59706 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g59706).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g59706).xw ) , break187_g59706.x);
					float4 lerpResult182_g59706 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g59706).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g59706).xz ) , break187_g59706.x);
					float4 lerpResult176_g59706 = lerp( lerpResult181_g59706 , lerpResult182_g59706 , break187_g59706.y);
					float4 Output_Fetch2D_Auto202_g59706 = lerpResult176_g59706;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g59660 = Output_Fetch2D_Auto202_g59706;
					#else
					float4 staticSwitch1063_g59660 = tex2D( _RNMZ0, UV12361_g59660 );
					#endif
					float4 RNM_0926_g59660 = ( ( ( ( temp_output_2_0_g59692 * temp_output_2_0_g59692 ) * staticSwitch1061_g59660 ) + ( ( temp_output_2_0_g59691 * temp_output_2_0_g59691 ) * staticSwitch1062_g59660 ) ) + ( ( temp_output_2_0_g59690 * temp_output_2_0_g59690 ) * staticSwitch1063_g59660 ) );
					float3 appendResult139_g59685 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g59685 = normalize( Normal_Map700_g59660 );
					float3 Normal_Map318_g59685 = normalizeResult326_g59685;
					float dotResult121_g59685 = dot( appendResult139_g59685 , Normal_Map318_g59685 );
					float temp_output_2_0_g59688 = saturate( dotResult121_g59685 );
					float localStochasticTiling2_g59694 = ( 0.0 );
					float2 UV2_g59694 = UV12361_g59660;
					float4 TexelSize2_g59694 = _RNMX1_TexelSize;
					float4 Offsets2_g59694 = float4( 0,0,0,0 );
					float2 Weights2_g59694 = float2( 0,0 );
					{
					UV2_g59694 = UV2_g59694 * TexelSize2_g59694.zw - 0.5;
					float2 f = frac( UV2_g59694 );
					UV2_g59694 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g59694.x - 0.5, UV2_g59694.x + 1.5, UV2_g59694.y - 0.5, UV2_g59694.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g59694 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59694.xyxy;
					Weights2_g59694 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g59693 = Offsets2_g59694;
					float4 Input_FetchOffsets197_g59695 = temp_output_1_34_g59693;
					float2 temp_output_1_54_g59693 = Weights2_g59694;
					float2 Input_FetchWeights200_g59695 = temp_output_1_54_g59693;
					float2 break187_g59695 = Input_FetchWeights200_g59695;
					float4 lerpResult181_g59695 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g59695).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g59695).xw ) , break187_g59695.x);
					float4 lerpResult182_g59695 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g59695).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g59695).xz ) , break187_g59695.x);
					float4 lerpResult176_g59695 = lerp( lerpResult181_g59695 , lerpResult182_g59695 , break187_g59695.y);
					float4 Output_Fetch2D_Auto202_g59695 = lerpResult176_g59695;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g59660 = Output_Fetch2D_Auto202_g59695;
					#else
					float4 staticSwitch1087_g59660 = tex2D( _RNMX1, UV12361_g59660 );
					#endif
					float3 appendResult146_g59685 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59685 = dot( appendResult146_g59685 , Normal_Map318_g59685 );
					float temp_output_2_0_g59687 = saturate( dotResult122_g59685 );
					float4 Input_FetchOffsets197_g59696 = temp_output_1_34_g59693;
					float2 Input_FetchWeights200_g59696 = temp_output_1_54_g59693;
					float2 break187_g59696 = Input_FetchWeights200_g59696;
					float4 lerpResult181_g59696 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g59696).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g59696).xw ) , break187_g59696.x);
					float4 lerpResult182_g59696 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g59696).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g59696).xz ) , break187_g59696.x);
					float4 lerpResult176_g59696 = lerp( lerpResult181_g59696 , lerpResult182_g59696 , break187_g59696.y);
					float4 Output_Fetch2D_Auto202_g59696 = lerpResult176_g59696;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g59660 = Output_Fetch2D_Auto202_g59696;
					#else
					float4 staticSwitch1083_g59660 = tex2D( _RNMY1, UV12361_g59660 );
					#endif
					float3 appendResult149_g59685 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59685 = dot( appendResult149_g59685 , Normal_Map318_g59685 );
					float temp_output_2_0_g59686 = saturate( dotResult120_g59685 );
					float4 Input_FetchOffsets197_g59697 = temp_output_1_34_g59693;
					float2 Input_FetchWeights200_g59697 = temp_output_1_54_g59693;
					float2 break187_g59697 = Input_FetchWeights200_g59697;
					float4 lerpResult181_g59697 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g59697).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g59697).xw ) , break187_g59697.x);
					float4 lerpResult182_g59697 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g59697).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g59697).xz ) , break187_g59697.x);
					float4 lerpResult176_g59697 = lerp( lerpResult181_g59697 , lerpResult182_g59697 , break187_g59697.y);
					float4 Output_Fetch2D_Auto202_g59697 = lerpResult176_g59697;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g59660 = Output_Fetch2D_Auto202_g59697;
					#else
					float4 staticSwitch1084_g59660 = tex2D( _RNMZ1, UV12361_g59660 );
					#endif
					float4 RNM_11081_g59660 = ( ( ( ( temp_output_2_0_g59688 * temp_output_2_0_g59688 ) * staticSwitch1087_g59660 ) + ( ( temp_output_2_0_g59687 * temp_output_2_0_g59687 ) * staticSwitch1083_g59660 ) ) + ( ( temp_output_2_0_g59686 * temp_output_2_0_g59686 ) * staticSwitch1084_g59660 ) );
					float Lightmap_Lerp_Value969_g59660 = _LIGHTMAPLERP;
					float4 lerpResult953_g59660 = lerp( RNM_0926_g59660 , RNM_11081_g59660 , Lightmap_Lerp_Value969_g59660);
					float4 RNM_Lerp950_g59660 = lerpResult953_g59660;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g59660 = temp_cast_2;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g59660 = Lightmap_0925_g59660;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g59660 = Lightmap_Lerp932_g59660;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g59660 = RNM_0926_g59660;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g59660 = RNM_Lerp950_g59660;
					#else
					float4 staticSwitch1014_g59660 = temp_cast_2;
					#endif
					float4 Lightmap46_g59660 = staticSwitch1014_g59660;
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal1392_g59660 = Normal_Map700_g59660;
					float2 temp_output_5_0_g59678 = UV02420_g59660;
					float2 UV633_g59678 = temp_output_5_0_g59678;
					float2 UV100_g59679 = UV633_g59678;
					float2 temp_output_51_0_g59679 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59679 * float2( 3.464,3.464 ) ) );
					float2 break55_g59679 = frac( temp_output_51_0_g59679 );
					float temp_output_56_0_g59679 = ( ( 1.0 - break55_g59679.x ) - break55_g59679.y );
					float2 temp_output_52_0_g59679 = floor( temp_output_51_0_g59679 );
					float2 temp_output_125_0_g59679 = ( temp_output_52_0_g59679 + float2( 1,1 ) );
					float2 ifLocalVar87_g59679 = 0;
					if( temp_output_56_0_g59679 > 0.0 )
					ifLocalVar87_g59679 = temp_output_52_0_g59679;
					else if( temp_output_56_0_g59679 == 0.0 )
					ifLocalVar87_g59679 = temp_output_125_0_g59679;
					else if( temp_output_56_0_g59679 < 0.0 )
					ifLocalVar87_g59679 = temp_output_125_0_g59679;
					float3 temp_output_7_0_g59680 = frac( ( (ifLocalVar87_g59679).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59680 = dot( temp_output_7_0_g59680 , ( (temp_output_7_0_g59680).yzx + 33.33 ) );
					float3 temp_output_12_0_g59680 = ( temp_output_7_0_g59680 + dotResult8_g59680 );
					float2 temp_output_597_0_g59678 = ( UV100_g59679 + frac( ( ( (temp_output_12_0_g59680).xx + (temp_output_12_0_g59680).yz ) * (temp_output_12_0_g59680).zy ) ) );
					float2 DDX631_g59678 = ddx( temp_output_5_0_g59678 );
					float2 DDY632_g59678 = ddy( temp_output_5_0_g59678 );
					float temp_output_65_0_g59679 = ( 0.0 - temp_output_56_0_g59679 );
					float ifLocalVar59_g59679 = 0;
					if( temp_output_56_0_g59679 <= 0.0 )
					ifLocalVar59_g59679 = temp_output_65_0_g59679;
					else
					ifLocalVar59_g59679 = temp_output_56_0_g59679;
					float temp_output_597_30_g59678 = ifLocalVar59_g59679;
					float2 temp_output_90_0_g59679 = ( temp_output_52_0_g59679 + float2( 0,1 ) );
					float2 temp_output_123_0_g59679 = ( temp_output_52_0_g59679 + float2( 1,0 ) );
					float2 ifLocalVar88_g59679 = 0;
					if( temp_output_56_0_g59679 > 0.0 )
					ifLocalVar88_g59679 = temp_output_90_0_g59679;
					else if( temp_output_56_0_g59679 == 0.0 )
					ifLocalVar88_g59679 = temp_output_123_0_g59679;
					else if( temp_output_56_0_g59679 < 0.0 )
					ifLocalVar88_g59679 = temp_output_123_0_g59679;
					float3 temp_output_7_0_g59681 = frac( ( (ifLocalVar88_g59679).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59681 = dot( temp_output_7_0_g59681 , ( (temp_output_7_0_g59681).yzx + 33.33 ) );
					float3 temp_output_12_0_g59681 = ( temp_output_7_0_g59681 + dotResult8_g59681 );
					float2 temp_output_597_26_g59678 = ( UV100_g59679 + frac( ( ( (temp_output_12_0_g59681).xx + (temp_output_12_0_g59681).yz ) * (temp_output_12_0_g59681).zy ) ) );
					float temp_output_66_0_g59679 = ( 1.0 - break55_g59679.y );
					float ifLocalVar60_g59679 = 0;
					if( temp_output_56_0_g59679 <= 0.0 )
					ifLocalVar60_g59679 = temp_output_66_0_g59679;
					else
					ifLocalVar60_g59679 = break55_g59679.y;
					float temp_output_597_28_g59678 = ifLocalVar60_g59679;
					float2 ifLocalVar89_g59679 = 0;
					if( temp_output_56_0_g59679 > 0.0 )
					ifLocalVar89_g59679 = temp_output_123_0_g59679;
					else if( temp_output_56_0_g59679 == 0.0 )
					ifLocalVar89_g59679 = temp_output_90_0_g59679;
					else if( temp_output_56_0_g59679 < 0.0 )
					ifLocalVar89_g59679 = temp_output_90_0_g59679;
					float3 temp_output_7_0_g59682 = frac( ( (ifLocalVar89_g59679).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59682 = dot( temp_output_7_0_g59682 , ( (temp_output_7_0_g59682).yzx + 33.33 ) );
					float3 temp_output_12_0_g59682 = ( temp_output_7_0_g59682 + dotResult8_g59682 );
					float2 temp_output_597_27_g59678 = ( UV100_g59679 + frac( ( ( (temp_output_12_0_g59682).xx + (temp_output_12_0_g59682).yz ) * (temp_output_12_0_g59682).zy ) ) );
					float temp_output_67_0_g59679 = ( 1.0 - break55_g59679.x );
					float ifLocalVar61_g59679 = 0;
					if( temp_output_56_0_g59679 <= 0.0 )
					ifLocalVar61_g59679 = temp_output_67_0_g59679;
					else
					ifLocalVar61_g59679 = break55_g59679.x;
					float temp_output_597_29_g59678 = ifLocalVar61_g59679;
					float4 Output_2D293_g59678 = ( ( tex2D( _GlossinessMap, temp_output_597_0_g59678, DDX631_g59678, DDY632_g59678 ) * temp_output_597_30_g59678 ) + ( tex2D( _GlossinessMap, temp_output_597_26_g59678, DDX631_g59678, DDY632_g59678 ) * temp_output_597_28_g59678 ) + ( tex2D( _GlossinessMap, temp_output_597_27_g59678, DDX631_g59678, DDY632_g59678 ) * temp_output_597_29_g59678 ) );
					float4 break31_g59678 = Output_2D293_g59678;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g59660 = break31_g59678.a;
					#else
					float staticSwitch1004_g59660 = tex2D( _GlossinessMap, UV02420_g59660 ).r;
					#endif
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g59660 = ( 1.0 - staticSwitch1004_g59660 );
					#else
					float staticSwitch845_g59660 = _Glossiness;
					#endif
					float3 temp_output_3_0_g59671 = ddx( NormalWS );
					float dotResult5_g59671 = dot( temp_output_3_0_g59671 , temp_output_3_0_g59671 );
					float3 temp_output_4_0_g59671 = ddy( NormalWS );
					float dotResult6_g59671 = dot( temp_output_4_0_g59671 , temp_output_4_0_g59671 );
					#ifdef _USEGEOMETRICANTIALIASING_ON
					float staticSwitch824_g59660 = min( staticSwitch845_g59660, ( 1.0 - pow( saturate( max( dotResult5_g59671, dotResult6_g59671 ) ) , 0.333 ) ) );
					#else
					float staticSwitch824_g59660 = staticSwitch845_g59660;
					#endif
					float Smoothness1399_g59660 = staticSwitch824_g59660;
					UnityGIInput data;
					UNITY_INITIALIZE_OUTPUT( UnityGIInput, data );
					data.worldPos = PositionWS;
					data.worldViewDir = ViewDirWS;
					data.probeHDR[0] = unity_SpecCube0_HDR;
					data.probeHDR[1] = unity_SpecCube1_HDR;
					#if UNITY_SPECCUBE_BLENDING || UNITY_SPECCUBE_BOX_PROJECTION //specdataif0
					data.boxMin[0] = unity_SpecCube0_BoxMin;
					#endif //specdataif0
					#if UNITY_SPECCUBE_BOX_PROJECTION //specdataif1
					data.boxMax[0] = unity_SpecCube0_BoxMax;
					data.probePosition[0] = unity_SpecCube0_ProbePosition;
					data.boxMax[1] = unity_SpecCube1_BoxMax;
					data.boxMin[1] = unity_SpecCube1_BoxMin;
					data.probePosition[1] = unity_SpecCube1_ProbePosition;
					#endif //specdataif1
					Unity_GlossyEnvironmentData g1392_g59660 = UnityGlossyEnvironmentSetup( Smoothness1399_g59660, ViewDirWS, float3( dot( tanToWorld0, tanNormal1392_g59660 ), dot( tanToWorld1, tanNormal1392_g59660 ), dot( tanToWorld2, tanNormal1392_g59660 ) ), float3(0,0,0));
					float3 indirectSpecular1392_g59660 = UnityGI_IndirectSpecular( data, 1.0, float3( dot( tanToWorld0, tanNormal1392_g59660 ), dot( tanToWorld1, tanNormal1392_g59660 ), dot( tanToWorld2, tanNormal1392_g59660 ) ), g1392_g59660 );
					float4 temp_cast_4 = (0.04).xxxx;
					float4 lerpResult1473_g59660 = lerp( temp_cast_4 , oAlbedo6_g59660 , Metallic1239_g59660);
					float3 switchResult1501_g59660 = (((ase_vface>0)?(NormalWS):(-NormalWS)));
					float dotResult1476_g59660 = dot( switchResult1501_g59660 , ViewDirWS );
					float4 lerpResult1480_g59660 = lerp( lerpResult1473_g59660 , float4( 1,1,1,0 ) , pow( ( 1.0 - saturate( dotResult1476_g59660 ) ) , 5.0 ));
					float4 Fresnel1560_g59660 = lerpResult1480_g59660;
					float4 temp_output_1481_0_g59660 = ( float4( indirectSpecular1392_g59660 , 0.0 ) * Fresnel1560_g59660 );
					#ifdef _USELIGHTMAPSPECULAR_ON
					float4 staticSwitch1469_g59660 = ( temp_output_1481_0_g59660 * sqrt( Lightmap46_g59660 ) );
					#else
					float4 staticSwitch1469_g59660 = temp_output_1481_0_g59660;
					#endif
					float4 Specular1419_g59660 = staticSwitch1469_g59660;
					float4 temp_cast_5 = (Black1185_g59660).xxxx;
					float2 temp_output_5_0_g59672 = UV02420_g59660;
					float2 UV633_g59672 = temp_output_5_0_g59672;
					float2 UV100_g59673 = UV633_g59672;
					float2 temp_output_51_0_g59673 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59673 * float2( 3.464,3.464 ) ) );
					float2 break55_g59673 = frac( temp_output_51_0_g59673 );
					float temp_output_56_0_g59673 = ( ( 1.0 - break55_g59673.x ) - break55_g59673.y );
					float2 temp_output_52_0_g59673 = floor( temp_output_51_0_g59673 );
					float2 temp_output_125_0_g59673 = ( temp_output_52_0_g59673 + float2( 1,1 ) );
					float2 ifLocalVar87_g59673 = 0;
					if( temp_output_56_0_g59673 > 0.0 )
					ifLocalVar87_g59673 = temp_output_52_0_g59673;
					else if( temp_output_56_0_g59673 == 0.0 )
					ifLocalVar87_g59673 = temp_output_125_0_g59673;
					else if( temp_output_56_0_g59673 < 0.0 )
					ifLocalVar87_g59673 = temp_output_125_0_g59673;
					float3 temp_output_7_0_g59674 = frac( ( (ifLocalVar87_g59673).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59674 = dot( temp_output_7_0_g59674 , ( (temp_output_7_0_g59674).yzx + 33.33 ) );
					float3 temp_output_12_0_g59674 = ( temp_output_7_0_g59674 + dotResult8_g59674 );
					float2 temp_output_597_0_g59672 = ( UV100_g59673 + frac( ( ( (temp_output_12_0_g59674).xx + (temp_output_12_0_g59674).yz ) * (temp_output_12_0_g59674).zy ) ) );
					float2 DDX631_g59672 = ddx( temp_output_5_0_g59672 );
					float2 DDY632_g59672 = ddy( temp_output_5_0_g59672 );
					float temp_output_65_0_g59673 = ( 0.0 - temp_output_56_0_g59673 );
					float ifLocalVar59_g59673 = 0;
					if( temp_output_56_0_g59673 <= 0.0 )
					ifLocalVar59_g59673 = temp_output_65_0_g59673;
					else
					ifLocalVar59_g59673 = temp_output_56_0_g59673;
					float temp_output_597_30_g59672 = ifLocalVar59_g59673;
					float2 temp_output_90_0_g59673 = ( temp_output_52_0_g59673 + float2( 0,1 ) );
					float2 temp_output_123_0_g59673 = ( temp_output_52_0_g59673 + float2( 1,0 ) );
					float2 ifLocalVar88_g59673 = 0;
					if( temp_output_56_0_g59673 > 0.0 )
					ifLocalVar88_g59673 = temp_output_90_0_g59673;
					else if( temp_output_56_0_g59673 == 0.0 )
					ifLocalVar88_g59673 = temp_output_123_0_g59673;
					else if( temp_output_56_0_g59673 < 0.0 )
					ifLocalVar88_g59673 = temp_output_123_0_g59673;
					float3 temp_output_7_0_g59675 = frac( ( (ifLocalVar88_g59673).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59675 = dot( temp_output_7_0_g59675 , ( (temp_output_7_0_g59675).yzx + 33.33 ) );
					float3 temp_output_12_0_g59675 = ( temp_output_7_0_g59675 + dotResult8_g59675 );
					float2 temp_output_597_26_g59672 = ( UV100_g59673 + frac( ( ( (temp_output_12_0_g59675).xx + (temp_output_12_0_g59675).yz ) * (temp_output_12_0_g59675).zy ) ) );
					float temp_output_66_0_g59673 = ( 1.0 - break55_g59673.y );
					float ifLocalVar60_g59673 = 0;
					if( temp_output_56_0_g59673 <= 0.0 )
					ifLocalVar60_g59673 = temp_output_66_0_g59673;
					else
					ifLocalVar60_g59673 = break55_g59673.y;
					float temp_output_597_28_g59672 = ifLocalVar60_g59673;
					float2 ifLocalVar89_g59673 = 0;
					if( temp_output_56_0_g59673 > 0.0 )
					ifLocalVar89_g59673 = temp_output_123_0_g59673;
					else if( temp_output_56_0_g59673 == 0.0 )
					ifLocalVar89_g59673 = temp_output_90_0_g59673;
					else if( temp_output_56_0_g59673 < 0.0 )
					ifLocalVar89_g59673 = temp_output_90_0_g59673;
					float3 temp_output_7_0_g59676 = frac( ( (ifLocalVar89_g59673).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59676 = dot( temp_output_7_0_g59676 , ( (temp_output_7_0_g59676).yzx + 33.33 ) );
					float3 temp_output_12_0_g59676 = ( temp_output_7_0_g59676 + dotResult8_g59676 );
					float2 temp_output_597_27_g59672 = ( UV100_g59673 + frac( ( ( (temp_output_12_0_g59676).xx + (temp_output_12_0_g59676).yz ) * (temp_output_12_0_g59676).zy ) ) );
					float temp_output_67_0_g59673 = ( 1.0 - break55_g59673.x );
					float ifLocalVar61_g59673 = 0;
					if( temp_output_56_0_g59673 <= 0.0 )
					ifLocalVar61_g59673 = temp_output_67_0_g59673;
					else
					ifLocalVar61_g59673 = break55_g59673.x;
					float temp_output_597_29_g59672 = ifLocalVar61_g59673;
					float4 Output_2D293_g59672 = ( ( tex2D( _EmissionMap, temp_output_597_0_g59672, DDX631_g59672, DDY632_g59672 ) * temp_output_597_30_g59672 ) + ( tex2D( _EmissionMap, temp_output_597_26_g59672, DDX631_g59672, DDY632_g59672 ) * temp_output_597_28_g59672 ) + ( tex2D( _EmissionMap, temp_output_597_27_g59672, DDX631_g59672, DDY632_g59672 ) * temp_output_597_29_g59672 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g59660 = Output_2D293_g59672;
					#else
					float4 staticSwitch1006_g59660 = tex2D( _EmissionMap, UV02420_g59660 );
					#endif
					#if defined( _SPECIALEFFECTS_DISABLED )
					float4 staticSwitch1578_g59660 = staticSwitch1006_g59660;
					#elif defined( _SPECIALEFFECTS_LED )
					float4 staticSwitch1578_g59660 = float4( 0,0,0,0 );
					#else
					float4 staticSwitch1578_g59660 = staticSwitch1006_g59660;
					#endif
					#ifdef _EMISSIONENABLED_ON
					float4 staticSwitch1017_g59660 = ( float4( _EmissionColor , 0.0 ) * staticSwitch1578_g59660 * _EmissionIntensity );
					#else
					float4 staticSwitch1017_g59660 = temp_cast_5;
					#endif
					float4 Emission86_g59660 = staticSwitch1017_g59660;
					float3 WorldPos97_g59712 = PositionWS;
					float3 tanNormal85_g59712 = Normal_Map700_g59660;
					float3 worldNormal85_g59712 = float3( dot( tanToWorld0, tanNormal85_g59712 ), dot( tanToWorld1, tanNormal85_g59712 ), dot( tanToWorld2, tanNormal85_g59712 ) );
					float3 WorldNormal97_g59712 = worldNormal85_g59712;
					float Smoothness97_g59712 = Smoothness1399_g59660;
					float3 LightmapColor97_g59712 = Lightmap46_g59660.rgb;
					float3 ViewDir97_g59712 = ViewDirWS;
					float3 localSpecular97_g59712 = Specular( WorldPos97_g59712 , WorldNormal97_g59712 , Smoothness97_g59712 , LightmapColor97_g59712 , ViewDir97_g59712 );
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1181_g59660 = Lightmap46_g59660;
					#else
					float4 staticSwitch1181_g59660 = ( ( aAlbedo1466_g59660 * Lightmap46_g59660 ) + Specular1419_g59660 + Emission86_g59660 + float4( localSpecular97_g59712 , 0.0 ) );
					#endif
					float4 temp_output_35_0_g59683 = staticSwitch1181_g59660;
					float4 Color353_g59683 = temp_output_35_0_g59683;
					#if defined( _LUTMODE_2D )
					float4 staticSwitch273_g59683 = saturate( temp_output_35_0_g59683 );
					#elif defined( _LUTMODE_3D )
					float4 staticSwitch273_g59683 = temp_output_35_0_g59683;
					#else
					float4 staticSwitch273_g59683 = temp_output_35_0_g59683;
					#endif
					float4 Color_Saturate49_g59683 = staticSwitch273_g59683;
					float Lut_Height213_g59683 = _LUTSize;
					float Lut_Width216_g59683 = ( _LUTSize * Lut_Height213_g59683 );
					float3 appendResult214_g59683 = (float3(( 1.0 / Lut_Width216_g59683 ) , ( 1.0 / Lut_Height213_g59683 ) , ( Lut_Height213_g59683 - 1.0 )));
					float3 Scale_Offset208_g59683 = appendResult214_g59683;
					float2 Scale_Factor292_g59683 = ( (Scale_Offset208_g59683).xy * (Scale_Offset208_g59683).z );
					float2 Offset299_g59683 = ( (Scale_Offset208_g59683).xy * 0.5 );
					float3 Adjusted_UV305_g59683 = ( ( (Color_Saturate49_g59683).xyw * float3( Scale_Factor292_g59683 ,  0.0 ) ) + float3( Offset299_g59683 ,  0.0 ) );
					float2 Scaled_Blue280_g59683 = ( (Color_Saturate49_g59683).zw * (Scale_Offset208_g59683).z );
					float2 Shift288_g59683 = floor( Scaled_Blue280_g59683 );
					float2 Final_X313_g59683 = ( (Adjusted_UV305_g59683).xz + ( Shift288_g59683 * (Scale_Offset208_g59683).y ) );
					float2 appendResult326_g59683 = (float2(Final_X313_g59683));
					float2 Final_UV325_g59683 = appendResult326_g59683;
					float2 appendResult338_g59683 = (float2((Scale_Offset208_g59683).y , 0.0));
					float2 Offset_UV336_g59683 = ( Final_UV325_g59683 + appendResult338_g59683 );
					float3 lerpResult333_g59683 = lerp( tex2D( _2DLut, Final_UV325_g59683 ).rgb , tex2D( _2DLut, Offset_UV336_g59683 ).rgb , float3( ( Scaled_Blue280_g59683 - Shift288_g59683 ) ,  0.0 ));
					#ifdef _2DLUT
					float4 staticSwitch347_g59683 = float4( lerpResult333_g59683 , 0.0 );
					#else
					float4 staticSwitch347_g59683 = Color_Saturate49_g59683;
					#endif
					float4 TwoD_LUT346_g59683 = staticSwitch347_g59683;
					float3 RGB16_g59684 = ( ( log10( ( ( Color_Saturate49_g59683.xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 );
					#ifdef _3DLUT
					float4 staticSwitch194_g59683 = tex3D( _3DLut, RGB16_g59684 );
					#else
					float4 staticSwitch194_g59683 = Color_Saturate49_g59683;
					#endif
					float4 ThreeD_LUT51_g59683 = staticSwitch194_g59683;
					#if defined( _LUTMODE_2D )
					float4 staticSwitch42_g59683 = TwoD_LUT346_g59683;
					#elif defined( _LUTMODE_3D )
					float4 staticSwitch42_g59683 = ThreeD_LUT51_g59683;
					#else
					float4 staticSwitch42_g59683 = ThreeD_LUT51_g59683;
					#endif
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch41_g59683 = staticSwitch42_g59683;
					#else
					float4 staticSwitch41_g59683 = Color353_g59683;
					#endif
					float3 worldPos8_g59713 = PositionWS;
					float3 worldNormal8_g59713 = NormalWS;
					float3 viewDir8_g59713 = ViewDirWS;
					float _Steps8_g59713 = 50.0;
					float _StepSize8_g59713 = 0.5;
					float _Thickness8_g59713 = 0.02;
					float _Jitter8_g59713 = 0.5;
					float4 localMyCustomExpression8_g59713 = MyCustomExpression8_g59713( worldPos8_g59713 , worldNormal8_g59713 , viewDir8_g59713 , _Steps8_g59713 , _StepSize8_g59713 , _Thickness8_g59713 , _Jitter8_g59713 );
					float4 screenColor33_g59713 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,(localMyCustomExpression8_g59713).xy);
					float4 lerpResult45_g59713 = lerp( float4( staticSwitch41_g59683.xyz , 0.0 ) , screenColor33_g59713 , (localMyCustomExpression8_g59713).w);
					

					o.Albedo = staticSwitch1180_g59660.rgb;
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

					o.Emission = lerpResult45_g59713.rgb;
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

		GrabPass{ }

		Pass
		{
			
			Name "ForwardAdd"
			Tags { "LightMode"="ForwardAdd" }
			ZWrite Off
			Blend One One

			CGPROGRAM
				#define ASE_GEOMETRY
				#define ASE_FRAGMENT_NORMAL 0
				#define ASE_RECEIVE_SHADOWS
				#pragma multi_compile_instancing
				#pragma multi_compile _ LOD_FADE_CROSSFADE
				#pragma multi_compile_fog
				#define ASE_FOG
				#define ASE_LIGHTING_SIMPLE 1
				#define _SPECULARHIGHLIGHTS_OFF
				#define _GLOSSYREFLECTIONS_OFF
				#define ASE_VERSION 19907
				#if defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED)
				#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex);
				#else
				#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex)
				#endif

				#pragma vertex vert
				#pragma fragment frag
				#pragma skip_variants INSTANCING_ON
				#pragma multi_compile_fwdadd_fullshadows
				#ifndef UNITY_PASS_FORWARDADD
					#define UNITY_PASS_FORWARDADD
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
				#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
				#define ASE_NEEDS_FRAG_WORLD_TANGENT
				#define ASE_NEEDS_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_BITANGENT
				#pragma shader_feature _LIGHTMAPDEBUG
				#pragma shader_feature_local_fragment _MAINTEX
				#pragma shader_feature_local _STOCHASTICENABLED_ON
				#pragma shader_feature_local_fragment _METALLICMAP
				#pragma shader_feature_local _LIGHTMAPMODE_DISABLED _LIGHTMAPMODE_SIMPLE _LIGHTMAPMODE_SIMPLELERP _LIGHTMAPMODE_RNM _LIGHTMAPMODE_RNMLERP
				#pragma shader_feature_local _USEBICUBICFILTERING_ON
				#pragma shader_feature_local_fragment _BUMPMAP
				#pragma shader_feature_local_fragment _USELIGHTMAPSPECULAR_ON
				#pragma shader_feature_local_fragment _USEGEOMETRICANTIALIASING_ON
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
					UNITY_LIGHTING_COORDS( 3, 4 )
					float4 ase_texcoord5 : TEXCOORD5;
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
				UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
				uniform float4 _UdonSpecularLightUp[32];
				uniform float4 _UdonSpecularLightRight[32];
				uniform float4 _UdonSpecularLightCol[32];
				uniform float4 _UdonSpecularLightPos[32];
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
				ASE_DECLARE_SCREENSPACE_TEXTURE( _GrabTexture )


				float3 Specular( float3 WorldPos, float3 WorldNormal, float Smoothness, float3 LightmapColor, float3 ViewDir )
				{
					// --- CONFIGURATION ORIGINALE ---
					float LumaStart = 0.01;
					float LumaEnd   = 1.0;
					float SpecBoost = 0.2;
					// --- CONFIGURATION TRANSITION RADIUS ---
					// Doit être cohérent avec ton activationRadius dans Udon (50.0)
					float MaxRadius = 8.0; 
					float RadiusFadeStart = 0.0; // Le fondu commence à 40m
					// --- 1. EARLY EXIT ---
					float luma = dot(LightmapColor, float3(0.22, 0.70, 0.08));
					float lmMask = smoothstep(LumaStart, LumaEnd, luma);
					if (lmMask < 0.001 || Smoothness < 0.01 || _UdonSpecularLightCount == 0) return 0;
					// --- CALCUL DU FADE DE RAYON (SÉCURITÉ UDON) ---
					float playerDist = distance(_WorldSpaceCameraPos, WorldPos);
					// On crée un masque qui s'adoucit quand on s'approche des 50m
					float radiusFade = 1.0 - smoothstep(RadiusFadeStart, MaxRadius, playerDist);
					// Exit si on est au-delà du rayon d'activation
					if (radiusFade < 0.001) return 0;
					// --- 2. SETUP ---
					float3 vDir = normalize(ViewDir);
					float3 N = normalize(WorldNormal);
					float sharpSmooth = pow(Smoothness, 1.5); 
					float shininess = exp2(10.0 * sharpSmooth + 2.0); 
					float normalization = (shininess + 2.0) * 0.125;
					float nv = saturate(dot(N, vDir));
					float fresnel = 0.04 + 0.96 * pow(1.0 - nv, 5.0); 
					float3 R = reflect(-vDir, N);
					float3 specAccum = 0.0;
					// --- 3. BOUCLE ---
					int lightCount = (int)_UdonSpecularLightCount;
					for (int i = 0; i < lightCount; i++)
					{
					    float4 lightPosRange = _UdonSpecularLightPos[i];
					    float3 center = lightPosRange.xyz;
					    float range   = lightPosRange.w;
					    float3 L = center - WorldPos;
					    
					    float3 proj = R * dot(L, R) - L;
					    float3 closestPoint = center;
					    closestPoint += _UdonSpecularLightRight[i].xyz * clamp(dot(proj, _UdonSpecularLightRight[i].xyz), -_UdonSpecularLightRight[i].w, _UdonSpecularLightRight[i].w);
					    closestPoint += _UdonSpecularLightUp[i].xyz * clamp(dot(proj, _UdonSpecularLightUp[i].xyz), -_UdonSpecularLightUp[i].w, _UdonSpecularLightUp[i].w);
					    float3 diff = closestPoint - WorldPos;
					    float distSq = dot(diff, diff);
					    
					    float falloff = saturate(1.0 - (distSq / (range * range)));
					    falloff *= falloff; 
					    if (falloff > 0)
					    {
					        float3 lDir = normalize(diff);
					        float nDotL = saturate(dot(N, lDir));
					        if (nDotL > 0)
					        {
					            float nDotH = saturate(dot(N, normalize(lDir + vDir)));
					            float spec = pow(nDotH, shininess) * normalization;
					            specAccum += _UdonSpecularLightCol[i].rgb * (spec * nDotL * _UdonSpecularLightCol[i].w * falloff);
					        }
					    }
					}
					// Multiplié par radiusFade pour une disparition douce aux limites de l'Udon
					return specAccum * fresnel * lmMask * SpecBoost * radiusFade;
				}
				
				float4 MyCustomExpression8_g59713( float3 worldPos, float3 worldNormal, float3 viewDir, float _Steps, float _StepSize, float _Thickness, float _Jitter )
				{
					// Calcul des UV écran pour le Jitter et la profondeur
					float2 screenUV = ComputeScreenPos(mul(unity_MatrixVP, float4(worldPos, 1.0))).xy / ComputeScreenPos(mul(unity_MatrixVP, float4(worldPos, 1.0))).w;
					float3 V = normalize(viewDir);
					float3 N = normalize(worldNormal);
					float3 R = reflect(-V, N);
					float3 vPos = mul(unity_MatrixV, float4(worldPos, 1.0)).xyz;
					float3 vDir = mul((float3x3)unity_MatrixV, R);
					vDir = normalize(vDir);
					// Utilisation du Jitter pour casser les lignes
					float noise = frac(sin(dot(screenUV, float2(12.9898, 78.233))) * 43758.5453);
					float currentDist = _StepSize + (noise * _StepSize * _Jitter);
					float4 res = float4(0,0,0,0);
					for (int i = 0; i < (int)_Steps; i++)
					{
					    float3 p = vPos + vDir * currentDist;
					    float4 proj = mul(unity_CameraProjection, float4(p, 1.0));
					    float2 uv = (proj.xy / proj.w) * 0.5 + 0.5;
					    // Sortie si hors écran
					    if (uv.x < 0 || uv.x > 1 || uv.y < 0 || uv.y > 1) break;
					    // Lecture de la profondeur
					    float sceneZ = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, uv));
					    float rayZ = -p.z;
					    // Épaisseur adaptative (astuce pour "souder" les lignes)
					    float thickness = _Thickness * (1.0 + currentDist * 0.1);
					    if (rayZ > sceneZ && rayZ < sceneZ + thickness)
					    {
					        // On renvoie les UV pour le Grab Screen et 1 dans le W pour le masque
					        return float4(uv, 0, 1.0);
					    }
					    currentDist += _StepSize;
					}
					return res;
				}
				

				v2f VertexFunction (appdata v  ) {
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					o.ase_texcoord5 = v.texcoord.xyzw;

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

					UNITY_TRANSFER_LIGHTING(o, v.texcoord1.xy);
					#if defined( ASE_FOG )
						UNITY_TRANSFER_FOG_COMBINED_WITH_WORLD_POS( o, o.pos );
					#endif

					#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
						o.tangentWS.zw = v.texcoord.xy;
						o.tangentWS.xy = v.texcoord.xy * unity_LightmapST.xy + unity_LightmapST.zw;
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

				half4 frag ( v2f IN , uint ase_vface : SV_IsFrontFace
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

					float2 texCoord2357_g59660 = IN.ase_texcoord5.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV02420_g59660 = texCoord2357_g59660;
					float2 temp_output_5_0_g59707 = UV02420_g59660;
					float2 UV633_g59707 = temp_output_5_0_g59707;
					float2 UV100_g59708 = UV633_g59707;
					float2 temp_output_51_0_g59708 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59708 * float2( 3.464,3.464 ) ) );
					float2 break55_g59708 = frac( temp_output_51_0_g59708 );
					float temp_output_56_0_g59708 = ( ( 1.0 - break55_g59708.x ) - break55_g59708.y );
					float2 temp_output_52_0_g59708 = floor( temp_output_51_0_g59708 );
					float2 temp_output_125_0_g59708 = ( temp_output_52_0_g59708 + float2( 1,1 ) );
					float2 ifLocalVar87_g59708 = 0;
					if( temp_output_56_0_g59708 > 0.0 )
					ifLocalVar87_g59708 = temp_output_52_0_g59708;
					else if( temp_output_56_0_g59708 == 0.0 )
					ifLocalVar87_g59708 = temp_output_125_0_g59708;
					else if( temp_output_56_0_g59708 < 0.0 )
					ifLocalVar87_g59708 = temp_output_125_0_g59708;
					float3 temp_output_7_0_g59709 = frac( ( (ifLocalVar87_g59708).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59709 = dot( temp_output_7_0_g59709 , ( (temp_output_7_0_g59709).yzx + 33.33 ) );
					float3 temp_output_12_0_g59709 = ( temp_output_7_0_g59709 + dotResult8_g59709 );
					float2 temp_output_597_0_g59707 = ( UV100_g59708 + frac( ( ( (temp_output_12_0_g59709).xx + (temp_output_12_0_g59709).yz ) * (temp_output_12_0_g59709).zy ) ) );
					float2 DDX631_g59707 = ddx( temp_output_5_0_g59707 );
					float2 DDY632_g59707 = ddy( temp_output_5_0_g59707 );
					float temp_output_65_0_g59708 = ( 0.0 - temp_output_56_0_g59708 );
					float ifLocalVar59_g59708 = 0;
					if( temp_output_56_0_g59708 <= 0.0 )
					ifLocalVar59_g59708 = temp_output_65_0_g59708;
					else
					ifLocalVar59_g59708 = temp_output_56_0_g59708;
					float temp_output_597_30_g59707 = ifLocalVar59_g59708;
					float2 temp_output_90_0_g59708 = ( temp_output_52_0_g59708 + float2( 0,1 ) );
					float2 temp_output_123_0_g59708 = ( temp_output_52_0_g59708 + float2( 1,0 ) );
					float2 ifLocalVar88_g59708 = 0;
					if( temp_output_56_0_g59708 > 0.0 )
					ifLocalVar88_g59708 = temp_output_90_0_g59708;
					else if( temp_output_56_0_g59708 == 0.0 )
					ifLocalVar88_g59708 = temp_output_123_0_g59708;
					else if( temp_output_56_0_g59708 < 0.0 )
					ifLocalVar88_g59708 = temp_output_123_0_g59708;
					float3 temp_output_7_0_g59710 = frac( ( (ifLocalVar88_g59708).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59710 = dot( temp_output_7_0_g59710 , ( (temp_output_7_0_g59710).yzx + 33.33 ) );
					float3 temp_output_12_0_g59710 = ( temp_output_7_0_g59710 + dotResult8_g59710 );
					float2 temp_output_597_26_g59707 = ( UV100_g59708 + frac( ( ( (temp_output_12_0_g59710).xx + (temp_output_12_0_g59710).yz ) * (temp_output_12_0_g59710).zy ) ) );
					float temp_output_66_0_g59708 = ( 1.0 - break55_g59708.y );
					float ifLocalVar60_g59708 = 0;
					if( temp_output_56_0_g59708 <= 0.0 )
					ifLocalVar60_g59708 = temp_output_66_0_g59708;
					else
					ifLocalVar60_g59708 = break55_g59708.y;
					float temp_output_597_28_g59707 = ifLocalVar60_g59708;
					float2 ifLocalVar89_g59708 = 0;
					if( temp_output_56_0_g59708 > 0.0 )
					ifLocalVar89_g59708 = temp_output_123_0_g59708;
					else if( temp_output_56_0_g59708 == 0.0 )
					ifLocalVar89_g59708 = temp_output_90_0_g59708;
					else if( temp_output_56_0_g59708 < 0.0 )
					ifLocalVar89_g59708 = temp_output_90_0_g59708;
					float3 temp_output_7_0_g59711 = frac( ( (ifLocalVar89_g59708).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59711 = dot( temp_output_7_0_g59711 , ( (temp_output_7_0_g59711).yzx + 33.33 ) );
					float3 temp_output_12_0_g59711 = ( temp_output_7_0_g59711 + dotResult8_g59711 );
					float2 temp_output_597_27_g59707 = ( UV100_g59708 + frac( ( ( (temp_output_12_0_g59711).xx + (temp_output_12_0_g59711).yz ) * (temp_output_12_0_g59711).zy ) ) );
					float temp_output_67_0_g59708 = ( 1.0 - break55_g59708.x );
					float ifLocalVar61_g59708 = 0;
					if( temp_output_56_0_g59708 <= 0.0 )
					ifLocalVar61_g59708 = temp_output_67_0_g59708;
					else
					ifLocalVar61_g59708 = break55_g59708.x;
					float temp_output_597_29_g59707 = ifLocalVar61_g59708;
					float4 Output_2D293_g59707 = ( ( tex2D( _MainTex, temp_output_597_0_g59707, DDX631_g59707, DDY632_g59707 ) * temp_output_597_30_g59707 ) + ( tex2D( _MainTex, temp_output_597_26_g59707, DDX631_g59707, DDY632_g59707 ) * temp_output_597_28_g59707 ) + ( tex2D( _MainTex, temp_output_597_27_g59707, DDX631_g59707, DDY632_g59707 ) * temp_output_597_29_g59707 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g59660 = Output_2D293_g59707;
					#else
					float4 staticSwitch1001_g59660 = tex2D( _MainTex, UV02420_g59660 );
					#endif
					#ifdef _MAINTEX
					float4 staticSwitch1549_g59660 = staticSwitch1001_g59660;
					#else
					float4 staticSwitch1549_g59660 = _Color;
					#endif
					float4 oAlbedo6_g59660 = staticSwitch1549_g59660;
					float Black1185_g59660 = 0.0;
					float4 temp_cast_0 = (Black1185_g59660).xxxx;
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1180_g59660 = temp_cast_0;
					#else
					float4 staticSwitch1180_g59660 = oAlbedo6_g59660;
					#endif
					
					float2 temp_output_5_0_g59666 = UV02420_g59660;
					float2 UV633_g59666 = temp_output_5_0_g59666;
					float2 UV100_g59667 = UV633_g59666;
					float2 temp_output_51_0_g59667 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59667 * float2( 3.464,3.464 ) ) );
					float2 break55_g59667 = frac( temp_output_51_0_g59667 );
					float temp_output_56_0_g59667 = ( ( 1.0 - break55_g59667.x ) - break55_g59667.y );
					float2 temp_output_52_0_g59667 = floor( temp_output_51_0_g59667 );
					float2 temp_output_125_0_g59667 = ( temp_output_52_0_g59667 + float2( 1,1 ) );
					float2 ifLocalVar87_g59667 = 0;
					if( temp_output_56_0_g59667 > 0.0 )
					ifLocalVar87_g59667 = temp_output_52_0_g59667;
					else if( temp_output_56_0_g59667 == 0.0 )
					ifLocalVar87_g59667 = temp_output_125_0_g59667;
					else if( temp_output_56_0_g59667 < 0.0 )
					ifLocalVar87_g59667 = temp_output_125_0_g59667;
					float3 temp_output_7_0_g59668 = frac( ( (ifLocalVar87_g59667).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59668 = dot( temp_output_7_0_g59668 , ( (temp_output_7_0_g59668).yzx + 33.33 ) );
					float3 temp_output_12_0_g59668 = ( temp_output_7_0_g59668 + dotResult8_g59668 );
					float2 temp_output_597_0_g59666 = ( UV100_g59667 + frac( ( ( (temp_output_12_0_g59668).xx + (temp_output_12_0_g59668).yz ) * (temp_output_12_0_g59668).zy ) ) );
					float2 DDX631_g59666 = ddx( temp_output_5_0_g59666 );
					float2 DDY632_g59666 = ddy( temp_output_5_0_g59666 );
					float temp_output_65_0_g59667 = ( 0.0 - temp_output_56_0_g59667 );
					float ifLocalVar59_g59667 = 0;
					if( temp_output_56_0_g59667 <= 0.0 )
					ifLocalVar59_g59667 = temp_output_65_0_g59667;
					else
					ifLocalVar59_g59667 = temp_output_56_0_g59667;
					float temp_output_597_30_g59666 = ifLocalVar59_g59667;
					float2 temp_output_90_0_g59667 = ( temp_output_52_0_g59667 + float2( 0,1 ) );
					float2 temp_output_123_0_g59667 = ( temp_output_52_0_g59667 + float2( 1,0 ) );
					float2 ifLocalVar88_g59667 = 0;
					if( temp_output_56_0_g59667 > 0.0 )
					ifLocalVar88_g59667 = temp_output_90_0_g59667;
					else if( temp_output_56_0_g59667 == 0.0 )
					ifLocalVar88_g59667 = temp_output_123_0_g59667;
					else if( temp_output_56_0_g59667 < 0.0 )
					ifLocalVar88_g59667 = temp_output_123_0_g59667;
					float3 temp_output_7_0_g59669 = frac( ( (ifLocalVar88_g59667).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59669 = dot( temp_output_7_0_g59669 , ( (temp_output_7_0_g59669).yzx + 33.33 ) );
					float3 temp_output_12_0_g59669 = ( temp_output_7_0_g59669 + dotResult8_g59669 );
					float2 temp_output_597_26_g59666 = ( UV100_g59667 + frac( ( ( (temp_output_12_0_g59669).xx + (temp_output_12_0_g59669).yz ) * (temp_output_12_0_g59669).zy ) ) );
					float temp_output_66_0_g59667 = ( 1.0 - break55_g59667.y );
					float ifLocalVar60_g59667 = 0;
					if( temp_output_56_0_g59667 <= 0.0 )
					ifLocalVar60_g59667 = temp_output_66_0_g59667;
					else
					ifLocalVar60_g59667 = break55_g59667.y;
					float temp_output_597_28_g59666 = ifLocalVar60_g59667;
					float2 ifLocalVar89_g59667 = 0;
					if( temp_output_56_0_g59667 > 0.0 )
					ifLocalVar89_g59667 = temp_output_123_0_g59667;
					else if( temp_output_56_0_g59667 == 0.0 )
					ifLocalVar89_g59667 = temp_output_90_0_g59667;
					else if( temp_output_56_0_g59667 < 0.0 )
					ifLocalVar89_g59667 = temp_output_90_0_g59667;
					float3 temp_output_7_0_g59670 = frac( ( (ifLocalVar89_g59667).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59670 = dot( temp_output_7_0_g59670 , ( (temp_output_7_0_g59670).yzx + 33.33 ) );
					float3 temp_output_12_0_g59670 = ( temp_output_7_0_g59670 + dotResult8_g59670 );
					float2 temp_output_597_27_g59666 = ( UV100_g59667 + frac( ( ( (temp_output_12_0_g59670).xx + (temp_output_12_0_g59670).yz ) * (temp_output_12_0_g59670).zy ) ) );
					float temp_output_67_0_g59667 = ( 1.0 - break55_g59667.x );
					float ifLocalVar61_g59667 = 0;
					if( temp_output_56_0_g59667 <= 0.0 )
					ifLocalVar61_g59667 = temp_output_67_0_g59667;
					else
					ifLocalVar61_g59667 = break55_g59667.x;
					float temp_output_597_29_g59666 = ifLocalVar61_g59667;
					float4 Output_2D293_g59666 = ( ( tex2D( _MetallicMap, temp_output_597_0_g59666, DDX631_g59666, DDY632_g59666 ) * temp_output_597_30_g59666 ) + ( tex2D( _MetallicMap, temp_output_597_26_g59666, DDX631_g59666, DDY632_g59666 ) * temp_output_597_28_g59666 ) + ( tex2D( _MetallicMap, temp_output_597_27_g59666, DDX631_g59666, DDY632_g59666 ) * temp_output_597_29_g59666 ) );
					float4 break31_g59666 = Output_2D293_g59666;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g59660 = break31_g59666.a;
					#else
					float staticSwitch1005_g59660 = tex2D( _MetallicMap, UV02420_g59660 ).a;
					#endif
					#ifdef _METALLICMAP
					float staticSwitch846_g59660 = staticSwitch1005_g59660;
					#else
					float staticSwitch846_g59660 = _Metallic;
					#endif
					float Metallic1239_g59660 = staticSwitch846_g59660;
					float4 aAlbedo1466_g59660 = ( staticSwitch1549_g59660 * ( 1.0 - Metallic1239_g59660 ) );
					float White38_g59660 = 1.0;
					float4 temp_cast_2 = (White38_g59660).xxxx;
					float4 texCoord2426_g59660 = IN.ase_texcoord5;
					texCoord2426_g59660.xy = IN.ase_texcoord5.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV12361_g59660 = (texCoord2426_g59660).zw;
					float localBicubicPrepare2_g59701 = ( 0.0 );
					float2 Input_UV100_g59701 = UV12361_g59660;
					float2 UV2_g59701 = Input_UV100_g59701;
					float4 TexelSize2_g59701 = _Lightmap0_TexelSize;
					float2 UV02_g59701 = float2( 0,0 );
					float2 UV12_g59701 = float2( 0,0 );
					float2 UV22_g59701 = float2( 0,0 );
					float2 UV32_g59701 = float2( 0,0 );
					float W02_g59701 = 0;
					float W12_g59701 = 0;
					{
					{
					 UV2_g59701 = UV2_g59701 * TexelSize2_g59701.zw - 0.5;
					    float2 f = frac( UV2_g59701 );
					    UV2_g59701 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59701.x - 0.5, UV2_g59701.x + 1.5, UV2_g59701.y - 0.5, UV2_g59701.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59701.xyxy;
					    UV02_g59701 = off.xz;
					    UV12_g59701 = off.yz;
					    UV22_g59701 = off.xw;
					    UV32_g59701 = off.yw;
					    W02_g59701 = s.x / ( s.x + s.y );
					 W12_g59701 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59701 = lerp( tex2D( _Lightmap0, UV32_g59701 ) , tex2D( _Lightmap0, UV22_g59701 ) , W02_g59701);
					float4 lerpResult45_g59701 = lerp( tex2D( _Lightmap0, UV12_g59701 ) , tex2D( _Lightmap0, UV02_g59701 ) , W02_g59701);
					float4 lerpResult44_g59701 = lerp( lerpResult46_g59701 , lerpResult45_g59701 , W12_g59701);
					float4 Output_2D_Auto131_g59701 = lerpResult44_g59701;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g59660 = Output_2D_Auto131_g59701;
					#else
					float4 staticSwitch1092_g59660 = tex2D( _Lightmap0, UV12361_g59660 );
					#endif
					float4 Lightmap_0925_g59660 = staticSwitch1092_g59660;
					float localBicubicPrepare2_g59699 = ( 0.0 );
					float2 Input_UV100_g59699 = UV12361_g59660;
					float2 UV2_g59699 = Input_UV100_g59699;
					float4 TexelSize2_g59699 = _Lightmap1_TexelSize;
					float2 UV02_g59699 = float2( 0,0 );
					float2 UV12_g59699 = float2( 0,0 );
					float2 UV22_g59699 = float2( 0,0 );
					float2 UV32_g59699 = float2( 0,0 );
					float W02_g59699 = 0;
					float W12_g59699 = 0;
					{
					{
					 UV2_g59699 = UV2_g59699 * TexelSize2_g59699.zw - 0.5;
					    float2 f = frac( UV2_g59699 );
					    UV2_g59699 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59699.x - 0.5, UV2_g59699.x + 1.5, UV2_g59699.y - 0.5, UV2_g59699.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59699.xyxy;
					    UV02_g59699 = off.xz;
					    UV12_g59699 = off.yz;
					    UV22_g59699 = off.xw;
					    UV32_g59699 = off.yw;
					    W02_g59699 = s.x / ( s.x + s.y );
					 W12_g59699 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59699 = lerp( tex2D( _Lightmap1, UV32_g59699 ) , tex2D( _Lightmap1, UV22_g59699 ) , W02_g59699);
					float4 lerpResult45_g59699 = lerp( tex2D( _Lightmap1, UV12_g59699 ) , tex2D( _Lightmap1, UV02_g59699 ) , W02_g59699);
					float4 lerpResult44_g59699 = lerp( lerpResult46_g59699 , lerpResult45_g59699 , W12_g59699);
					float4 Output_2D_Auto131_g59699 = lerpResult44_g59699;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g59660 = Output_2D_Auto131_g59699;
					#else
					float4 staticSwitch1088_g59660 = tex2D( _Lightmap1, UV12361_g59660 );
					#endif
					float4 Lightmap_1956_g59660 = staticSwitch1088_g59660;
					float4 lerpResult442_g59660 = lerp( Lightmap_0925_g59660 , Lightmap_1956_g59660 , _LIGHTMAPLERP);
					float4 Lightmap_Lerp932_g59660 = lerpResult442_g59660;
					float3 appendResult139_g59689 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float2 temp_output_5_0_g59661 = UV02420_g59660;
					float2 UV633_g59661 = temp_output_5_0_g59661;
					float2 UV100_g59662 = UV633_g59661;
					float2 temp_output_51_0_g59662 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59662 * float2( 3.464,3.464 ) ) );
					float2 break55_g59662 = frac( temp_output_51_0_g59662 );
					float temp_output_56_0_g59662 = ( ( 1.0 - break55_g59662.x ) - break55_g59662.y );
					float2 temp_output_52_0_g59662 = floor( temp_output_51_0_g59662 );
					float2 temp_output_125_0_g59662 = ( temp_output_52_0_g59662 + float2( 1,1 ) );
					float2 ifLocalVar87_g59662 = 0;
					if( temp_output_56_0_g59662 > 0.0 )
					ifLocalVar87_g59662 = temp_output_52_0_g59662;
					else if( temp_output_56_0_g59662 == 0.0 )
					ifLocalVar87_g59662 = temp_output_125_0_g59662;
					else if( temp_output_56_0_g59662 < 0.0 )
					ifLocalVar87_g59662 = temp_output_125_0_g59662;
					float3 temp_output_7_0_g59663 = frac( ( (ifLocalVar87_g59662).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59663 = dot( temp_output_7_0_g59663 , ( (temp_output_7_0_g59663).yzx + 33.33 ) );
					float3 temp_output_12_0_g59663 = ( temp_output_7_0_g59663 + dotResult8_g59663 );
					float2 temp_output_597_0_g59661 = ( UV100_g59662 + frac( ( ( (temp_output_12_0_g59663).xx + (temp_output_12_0_g59663).yz ) * (temp_output_12_0_g59663).zy ) ) );
					float2 DDX631_g59661 = ddx( temp_output_5_0_g59661 );
					float2 DDY632_g59661 = ddy( temp_output_5_0_g59661 );
					float Input_Scale617_g59661 = 2.0;
					float temp_output_65_0_g59662 = ( 0.0 - temp_output_56_0_g59662 );
					float ifLocalVar59_g59662 = 0;
					if( temp_output_56_0_g59662 <= 0.0 )
					ifLocalVar59_g59662 = temp_output_65_0_g59662;
					else
					ifLocalVar59_g59662 = temp_output_56_0_g59662;
					float temp_output_597_30_g59661 = ifLocalVar59_g59662;
					float2 temp_output_90_0_g59662 = ( temp_output_52_0_g59662 + float2( 0,1 ) );
					float2 temp_output_123_0_g59662 = ( temp_output_52_0_g59662 + float2( 1,0 ) );
					float2 ifLocalVar88_g59662 = 0;
					if( temp_output_56_0_g59662 > 0.0 )
					ifLocalVar88_g59662 = temp_output_90_0_g59662;
					else if( temp_output_56_0_g59662 == 0.0 )
					ifLocalVar88_g59662 = temp_output_123_0_g59662;
					else if( temp_output_56_0_g59662 < 0.0 )
					ifLocalVar88_g59662 = temp_output_123_0_g59662;
					float3 temp_output_7_0_g59664 = frac( ( (ifLocalVar88_g59662).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59664 = dot( temp_output_7_0_g59664 , ( (temp_output_7_0_g59664).yzx + 33.33 ) );
					float3 temp_output_12_0_g59664 = ( temp_output_7_0_g59664 + dotResult8_g59664 );
					float2 temp_output_597_26_g59661 = ( UV100_g59662 + frac( ( ( (temp_output_12_0_g59664).xx + (temp_output_12_0_g59664).yz ) * (temp_output_12_0_g59664).zy ) ) );
					float temp_output_66_0_g59662 = ( 1.0 - break55_g59662.y );
					float ifLocalVar60_g59662 = 0;
					if( temp_output_56_0_g59662 <= 0.0 )
					ifLocalVar60_g59662 = temp_output_66_0_g59662;
					else
					ifLocalVar60_g59662 = break55_g59662.y;
					float temp_output_597_28_g59661 = ifLocalVar60_g59662;
					float2 ifLocalVar89_g59662 = 0;
					if( temp_output_56_0_g59662 > 0.0 )
					ifLocalVar89_g59662 = temp_output_123_0_g59662;
					else if( temp_output_56_0_g59662 == 0.0 )
					ifLocalVar89_g59662 = temp_output_90_0_g59662;
					else if( temp_output_56_0_g59662 < 0.0 )
					ifLocalVar89_g59662 = temp_output_90_0_g59662;
					float3 temp_output_7_0_g59665 = frac( ( (ifLocalVar89_g59662).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59665 = dot( temp_output_7_0_g59665 , ( (temp_output_7_0_g59665).yzx + 33.33 ) );
					float3 temp_output_12_0_g59665 = ( temp_output_7_0_g59665 + dotResult8_g59665 );
					float2 temp_output_597_27_g59661 = ( UV100_g59662 + frac( ( ( (temp_output_12_0_g59665).xx + (temp_output_12_0_g59665).yz ) * (temp_output_12_0_g59665).zy ) ) );
					float temp_output_67_0_g59662 = ( 1.0 - break55_g59662.x );
					float ifLocalVar61_g59662 = 0;
					if( temp_output_56_0_g59662 <= 0.0 )
					ifLocalVar61_g59662 = temp_output_67_0_g59662;
					else
					ifLocalVar61_g59662 = break55_g59662.x;
					float temp_output_597_29_g59661 = ifLocalVar61_g59662;
					float3 Output_2D_Normal641_g59661 = ( ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_0_g59661, DDX631_g59661, DDY632_g59661 ), Input_Scale617_g59661 ) * temp_output_597_30_g59661 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_26_g59661, DDX631_g59661, DDY632_g59661 ), Input_Scale617_g59661 ) * temp_output_597_28_g59661 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_27_g59661, DDX631_g59661, DDY632_g59661 ), Input_Scale617_g59661 ) * float3( 0,0,0 ) * temp_output_597_29_g59661 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g59660 = Output_2D_Normal641_g59661;
					#else
					float3 staticSwitch1003_g59660 = UnpackScaleNormal( tex2D( _BumpMap, UV02420_g59660 ), 2.0 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g59660 = staticSwitch1003_g59660;
					#else
					float3 staticSwitch980_g59660 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g59660 = staticSwitch980_g59660;
					float3 normalizeResult326_g59689 = normalize( Normal_Map700_g59660 );
					float3 Normal_Map318_g59689 = normalizeResult326_g59689;
					float dotResult121_g59689 = dot( appendResult139_g59689 , Normal_Map318_g59689 );
					float temp_output_2_0_g59692 = saturate( dotResult121_g59689 );
					float localStochasticTiling2_g59703 = ( 0.0 );
					float2 UV2_g59703 = UV12361_g59660;
					float4 TexelSize2_g59703 = _RNMX0_TexelSize;
					float4 Offsets2_g59703 = float4( 0,0,0,0 );
					float2 Weights2_g59703 = float2( 0,0 );
					{
					UV2_g59703 = UV2_g59703 * TexelSize2_g59703.zw - 0.5;
					float2 f = frac( UV2_g59703 );
					UV2_g59703 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g59703.x - 0.5, UV2_g59703.x + 1.5, UV2_g59703.y - 0.5, UV2_g59703.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g59703 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59703.xyxy;
					Weights2_g59703 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g59702 = Offsets2_g59703;
					float4 Input_FetchOffsets197_g59704 = temp_output_1_34_g59702;
					float2 temp_output_1_54_g59702 = Weights2_g59703;
					float2 Input_FetchWeights200_g59704 = temp_output_1_54_g59702;
					float2 break187_g59704 = Input_FetchWeights200_g59704;
					float4 lerpResult181_g59704 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g59704).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g59704).xw ) , break187_g59704.x);
					float4 lerpResult182_g59704 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g59704).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g59704).xz ) , break187_g59704.x);
					float4 lerpResult176_g59704 = lerp( lerpResult181_g59704 , lerpResult182_g59704 , break187_g59704.y);
					float4 Output_Fetch2D_Auto202_g59704 = lerpResult176_g59704;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g59660 = Output_Fetch2D_Auto202_g59704;
					#else
					float4 staticSwitch1061_g59660 = tex2D( _RNMX0, UV12361_g59660 );
					#endif
					float3 appendResult146_g59689 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59689 = dot( appendResult146_g59689 , Normal_Map318_g59689 );
					float temp_output_2_0_g59691 = saturate( dotResult122_g59689 );
					float4 Input_FetchOffsets197_g59705 = temp_output_1_34_g59702;
					float2 Input_FetchWeights200_g59705 = temp_output_1_54_g59702;
					float2 break187_g59705 = Input_FetchWeights200_g59705;
					float4 lerpResult181_g59705 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g59705).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g59705).xw ) , break187_g59705.x);
					float4 lerpResult182_g59705 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g59705).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g59705).xz ) , break187_g59705.x);
					float4 lerpResult176_g59705 = lerp( lerpResult181_g59705 , lerpResult182_g59705 , break187_g59705.y);
					float4 Output_Fetch2D_Auto202_g59705 = lerpResult176_g59705;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g59660 = Output_Fetch2D_Auto202_g59705;
					#else
					float4 staticSwitch1062_g59660 = tex2D( _RNMY0, UV12361_g59660 );
					#endif
					float3 appendResult149_g59689 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59689 = dot( appendResult149_g59689 , Normal_Map318_g59689 );
					float temp_output_2_0_g59690 = saturate( dotResult120_g59689 );
					float4 Input_FetchOffsets197_g59706 = temp_output_1_34_g59702;
					float2 Input_FetchWeights200_g59706 = temp_output_1_54_g59702;
					float2 break187_g59706 = Input_FetchWeights200_g59706;
					float4 lerpResult181_g59706 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g59706).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g59706).xw ) , break187_g59706.x);
					float4 lerpResult182_g59706 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g59706).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g59706).xz ) , break187_g59706.x);
					float4 lerpResult176_g59706 = lerp( lerpResult181_g59706 , lerpResult182_g59706 , break187_g59706.y);
					float4 Output_Fetch2D_Auto202_g59706 = lerpResult176_g59706;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g59660 = Output_Fetch2D_Auto202_g59706;
					#else
					float4 staticSwitch1063_g59660 = tex2D( _RNMZ0, UV12361_g59660 );
					#endif
					float4 RNM_0926_g59660 = ( ( ( ( temp_output_2_0_g59692 * temp_output_2_0_g59692 ) * staticSwitch1061_g59660 ) + ( ( temp_output_2_0_g59691 * temp_output_2_0_g59691 ) * staticSwitch1062_g59660 ) ) + ( ( temp_output_2_0_g59690 * temp_output_2_0_g59690 ) * staticSwitch1063_g59660 ) );
					float3 appendResult139_g59685 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g59685 = normalize( Normal_Map700_g59660 );
					float3 Normal_Map318_g59685 = normalizeResult326_g59685;
					float dotResult121_g59685 = dot( appendResult139_g59685 , Normal_Map318_g59685 );
					float temp_output_2_0_g59688 = saturate( dotResult121_g59685 );
					float localStochasticTiling2_g59694 = ( 0.0 );
					float2 UV2_g59694 = UV12361_g59660;
					float4 TexelSize2_g59694 = _RNMX1_TexelSize;
					float4 Offsets2_g59694 = float4( 0,0,0,0 );
					float2 Weights2_g59694 = float2( 0,0 );
					{
					UV2_g59694 = UV2_g59694 * TexelSize2_g59694.zw - 0.5;
					float2 f = frac( UV2_g59694 );
					UV2_g59694 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g59694.x - 0.5, UV2_g59694.x + 1.5, UV2_g59694.y - 0.5, UV2_g59694.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g59694 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59694.xyxy;
					Weights2_g59694 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g59693 = Offsets2_g59694;
					float4 Input_FetchOffsets197_g59695 = temp_output_1_34_g59693;
					float2 temp_output_1_54_g59693 = Weights2_g59694;
					float2 Input_FetchWeights200_g59695 = temp_output_1_54_g59693;
					float2 break187_g59695 = Input_FetchWeights200_g59695;
					float4 lerpResult181_g59695 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g59695).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g59695).xw ) , break187_g59695.x);
					float4 lerpResult182_g59695 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g59695).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g59695).xz ) , break187_g59695.x);
					float4 lerpResult176_g59695 = lerp( lerpResult181_g59695 , lerpResult182_g59695 , break187_g59695.y);
					float4 Output_Fetch2D_Auto202_g59695 = lerpResult176_g59695;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g59660 = Output_Fetch2D_Auto202_g59695;
					#else
					float4 staticSwitch1087_g59660 = tex2D( _RNMX1, UV12361_g59660 );
					#endif
					float3 appendResult146_g59685 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59685 = dot( appendResult146_g59685 , Normal_Map318_g59685 );
					float temp_output_2_0_g59687 = saturate( dotResult122_g59685 );
					float4 Input_FetchOffsets197_g59696 = temp_output_1_34_g59693;
					float2 Input_FetchWeights200_g59696 = temp_output_1_54_g59693;
					float2 break187_g59696 = Input_FetchWeights200_g59696;
					float4 lerpResult181_g59696 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g59696).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g59696).xw ) , break187_g59696.x);
					float4 lerpResult182_g59696 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g59696).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g59696).xz ) , break187_g59696.x);
					float4 lerpResult176_g59696 = lerp( lerpResult181_g59696 , lerpResult182_g59696 , break187_g59696.y);
					float4 Output_Fetch2D_Auto202_g59696 = lerpResult176_g59696;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g59660 = Output_Fetch2D_Auto202_g59696;
					#else
					float4 staticSwitch1083_g59660 = tex2D( _RNMY1, UV12361_g59660 );
					#endif
					float3 appendResult149_g59685 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59685 = dot( appendResult149_g59685 , Normal_Map318_g59685 );
					float temp_output_2_0_g59686 = saturate( dotResult120_g59685 );
					float4 Input_FetchOffsets197_g59697 = temp_output_1_34_g59693;
					float2 Input_FetchWeights200_g59697 = temp_output_1_54_g59693;
					float2 break187_g59697 = Input_FetchWeights200_g59697;
					float4 lerpResult181_g59697 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g59697).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g59697).xw ) , break187_g59697.x);
					float4 lerpResult182_g59697 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g59697).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g59697).xz ) , break187_g59697.x);
					float4 lerpResult176_g59697 = lerp( lerpResult181_g59697 , lerpResult182_g59697 , break187_g59697.y);
					float4 Output_Fetch2D_Auto202_g59697 = lerpResult176_g59697;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g59660 = Output_Fetch2D_Auto202_g59697;
					#else
					float4 staticSwitch1084_g59660 = tex2D( _RNMZ1, UV12361_g59660 );
					#endif
					float4 RNM_11081_g59660 = ( ( ( ( temp_output_2_0_g59688 * temp_output_2_0_g59688 ) * staticSwitch1087_g59660 ) + ( ( temp_output_2_0_g59687 * temp_output_2_0_g59687 ) * staticSwitch1083_g59660 ) ) + ( ( temp_output_2_0_g59686 * temp_output_2_0_g59686 ) * staticSwitch1084_g59660 ) );
					float Lightmap_Lerp_Value969_g59660 = _LIGHTMAPLERP;
					float4 lerpResult953_g59660 = lerp( RNM_0926_g59660 , RNM_11081_g59660 , Lightmap_Lerp_Value969_g59660);
					float4 RNM_Lerp950_g59660 = lerpResult953_g59660;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g59660 = temp_cast_2;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g59660 = Lightmap_0925_g59660;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g59660 = Lightmap_Lerp932_g59660;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g59660 = RNM_0926_g59660;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g59660 = RNM_Lerp950_g59660;
					#else
					float4 staticSwitch1014_g59660 = temp_cast_2;
					#endif
					float4 Lightmap46_g59660 = staticSwitch1014_g59660;
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal1392_g59660 = Normal_Map700_g59660;
					float2 temp_output_5_0_g59678 = UV02420_g59660;
					float2 UV633_g59678 = temp_output_5_0_g59678;
					float2 UV100_g59679 = UV633_g59678;
					float2 temp_output_51_0_g59679 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59679 * float2( 3.464,3.464 ) ) );
					float2 break55_g59679 = frac( temp_output_51_0_g59679 );
					float temp_output_56_0_g59679 = ( ( 1.0 - break55_g59679.x ) - break55_g59679.y );
					float2 temp_output_52_0_g59679 = floor( temp_output_51_0_g59679 );
					float2 temp_output_125_0_g59679 = ( temp_output_52_0_g59679 + float2( 1,1 ) );
					float2 ifLocalVar87_g59679 = 0;
					if( temp_output_56_0_g59679 > 0.0 )
					ifLocalVar87_g59679 = temp_output_52_0_g59679;
					else if( temp_output_56_0_g59679 == 0.0 )
					ifLocalVar87_g59679 = temp_output_125_0_g59679;
					else if( temp_output_56_0_g59679 < 0.0 )
					ifLocalVar87_g59679 = temp_output_125_0_g59679;
					float3 temp_output_7_0_g59680 = frac( ( (ifLocalVar87_g59679).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59680 = dot( temp_output_7_0_g59680 , ( (temp_output_7_0_g59680).yzx + 33.33 ) );
					float3 temp_output_12_0_g59680 = ( temp_output_7_0_g59680 + dotResult8_g59680 );
					float2 temp_output_597_0_g59678 = ( UV100_g59679 + frac( ( ( (temp_output_12_0_g59680).xx + (temp_output_12_0_g59680).yz ) * (temp_output_12_0_g59680).zy ) ) );
					float2 DDX631_g59678 = ddx( temp_output_5_0_g59678 );
					float2 DDY632_g59678 = ddy( temp_output_5_0_g59678 );
					float temp_output_65_0_g59679 = ( 0.0 - temp_output_56_0_g59679 );
					float ifLocalVar59_g59679 = 0;
					if( temp_output_56_0_g59679 <= 0.0 )
					ifLocalVar59_g59679 = temp_output_65_0_g59679;
					else
					ifLocalVar59_g59679 = temp_output_56_0_g59679;
					float temp_output_597_30_g59678 = ifLocalVar59_g59679;
					float2 temp_output_90_0_g59679 = ( temp_output_52_0_g59679 + float2( 0,1 ) );
					float2 temp_output_123_0_g59679 = ( temp_output_52_0_g59679 + float2( 1,0 ) );
					float2 ifLocalVar88_g59679 = 0;
					if( temp_output_56_0_g59679 > 0.0 )
					ifLocalVar88_g59679 = temp_output_90_0_g59679;
					else if( temp_output_56_0_g59679 == 0.0 )
					ifLocalVar88_g59679 = temp_output_123_0_g59679;
					else if( temp_output_56_0_g59679 < 0.0 )
					ifLocalVar88_g59679 = temp_output_123_0_g59679;
					float3 temp_output_7_0_g59681 = frac( ( (ifLocalVar88_g59679).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59681 = dot( temp_output_7_0_g59681 , ( (temp_output_7_0_g59681).yzx + 33.33 ) );
					float3 temp_output_12_0_g59681 = ( temp_output_7_0_g59681 + dotResult8_g59681 );
					float2 temp_output_597_26_g59678 = ( UV100_g59679 + frac( ( ( (temp_output_12_0_g59681).xx + (temp_output_12_0_g59681).yz ) * (temp_output_12_0_g59681).zy ) ) );
					float temp_output_66_0_g59679 = ( 1.0 - break55_g59679.y );
					float ifLocalVar60_g59679 = 0;
					if( temp_output_56_0_g59679 <= 0.0 )
					ifLocalVar60_g59679 = temp_output_66_0_g59679;
					else
					ifLocalVar60_g59679 = break55_g59679.y;
					float temp_output_597_28_g59678 = ifLocalVar60_g59679;
					float2 ifLocalVar89_g59679 = 0;
					if( temp_output_56_0_g59679 > 0.0 )
					ifLocalVar89_g59679 = temp_output_123_0_g59679;
					else if( temp_output_56_0_g59679 == 0.0 )
					ifLocalVar89_g59679 = temp_output_90_0_g59679;
					else if( temp_output_56_0_g59679 < 0.0 )
					ifLocalVar89_g59679 = temp_output_90_0_g59679;
					float3 temp_output_7_0_g59682 = frac( ( (ifLocalVar89_g59679).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59682 = dot( temp_output_7_0_g59682 , ( (temp_output_7_0_g59682).yzx + 33.33 ) );
					float3 temp_output_12_0_g59682 = ( temp_output_7_0_g59682 + dotResult8_g59682 );
					float2 temp_output_597_27_g59678 = ( UV100_g59679 + frac( ( ( (temp_output_12_0_g59682).xx + (temp_output_12_0_g59682).yz ) * (temp_output_12_0_g59682).zy ) ) );
					float temp_output_67_0_g59679 = ( 1.0 - break55_g59679.x );
					float ifLocalVar61_g59679 = 0;
					if( temp_output_56_0_g59679 <= 0.0 )
					ifLocalVar61_g59679 = temp_output_67_0_g59679;
					else
					ifLocalVar61_g59679 = break55_g59679.x;
					float temp_output_597_29_g59678 = ifLocalVar61_g59679;
					float4 Output_2D293_g59678 = ( ( tex2D( _GlossinessMap, temp_output_597_0_g59678, DDX631_g59678, DDY632_g59678 ) * temp_output_597_30_g59678 ) + ( tex2D( _GlossinessMap, temp_output_597_26_g59678, DDX631_g59678, DDY632_g59678 ) * temp_output_597_28_g59678 ) + ( tex2D( _GlossinessMap, temp_output_597_27_g59678, DDX631_g59678, DDY632_g59678 ) * temp_output_597_29_g59678 ) );
					float4 break31_g59678 = Output_2D293_g59678;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g59660 = break31_g59678.a;
					#else
					float staticSwitch1004_g59660 = tex2D( _GlossinessMap, UV02420_g59660 ).r;
					#endif
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g59660 = ( 1.0 - staticSwitch1004_g59660 );
					#else
					float staticSwitch845_g59660 = _Glossiness;
					#endif
					float3 temp_output_3_0_g59671 = ddx( NormalWS );
					float dotResult5_g59671 = dot( temp_output_3_0_g59671 , temp_output_3_0_g59671 );
					float3 temp_output_4_0_g59671 = ddy( NormalWS );
					float dotResult6_g59671 = dot( temp_output_4_0_g59671 , temp_output_4_0_g59671 );
					#ifdef _USEGEOMETRICANTIALIASING_ON
					float staticSwitch824_g59660 = min( staticSwitch845_g59660, ( 1.0 - pow( saturate( max( dotResult5_g59671, dotResult6_g59671 ) ) , 0.333 ) ) );
					#else
					float staticSwitch824_g59660 = staticSwitch845_g59660;
					#endif
					float Smoothness1399_g59660 = staticSwitch824_g59660;
					UnityGIInput data;
					UNITY_INITIALIZE_OUTPUT( UnityGIInput, data );
					data.worldPos = PositionWS;
					data.worldViewDir = ViewDirWS;
					data.probeHDR[0] = unity_SpecCube0_HDR;
					data.probeHDR[1] = unity_SpecCube1_HDR;
					#if UNITY_SPECCUBE_BLENDING || UNITY_SPECCUBE_BOX_PROJECTION //specdataif0
					data.boxMin[0] = unity_SpecCube0_BoxMin;
					#endif //specdataif0
					#if UNITY_SPECCUBE_BOX_PROJECTION //specdataif1
					data.boxMax[0] = unity_SpecCube0_BoxMax;
					data.probePosition[0] = unity_SpecCube0_ProbePosition;
					data.boxMax[1] = unity_SpecCube1_BoxMax;
					data.boxMin[1] = unity_SpecCube1_BoxMin;
					data.probePosition[1] = unity_SpecCube1_ProbePosition;
					#endif //specdataif1
					Unity_GlossyEnvironmentData g1392_g59660 = UnityGlossyEnvironmentSetup( Smoothness1399_g59660, ViewDirWS, float3( dot( tanToWorld0, tanNormal1392_g59660 ), dot( tanToWorld1, tanNormal1392_g59660 ), dot( tanToWorld2, tanNormal1392_g59660 ) ), float3(0,0,0));
					float3 indirectSpecular1392_g59660 = UnityGI_IndirectSpecular( data, 1.0, float3( dot( tanToWorld0, tanNormal1392_g59660 ), dot( tanToWorld1, tanNormal1392_g59660 ), dot( tanToWorld2, tanNormal1392_g59660 ) ), g1392_g59660 );
					float4 temp_cast_4 = (0.04).xxxx;
					float4 lerpResult1473_g59660 = lerp( temp_cast_4 , oAlbedo6_g59660 , Metallic1239_g59660);
					float3 switchResult1501_g59660 = (((ase_vface>0)?(NormalWS):(-NormalWS)));
					float dotResult1476_g59660 = dot( switchResult1501_g59660 , ViewDirWS );
					float4 lerpResult1480_g59660 = lerp( lerpResult1473_g59660 , float4( 1,1,1,0 ) , pow( ( 1.0 - saturate( dotResult1476_g59660 ) ) , 5.0 ));
					float4 Fresnel1560_g59660 = lerpResult1480_g59660;
					float4 temp_output_1481_0_g59660 = ( float4( indirectSpecular1392_g59660 , 0.0 ) * Fresnel1560_g59660 );
					#ifdef _USELIGHTMAPSPECULAR_ON
					float4 staticSwitch1469_g59660 = ( temp_output_1481_0_g59660 * sqrt( Lightmap46_g59660 ) );
					#else
					float4 staticSwitch1469_g59660 = temp_output_1481_0_g59660;
					#endif
					float4 Specular1419_g59660 = staticSwitch1469_g59660;
					float4 temp_cast_5 = (Black1185_g59660).xxxx;
					float2 temp_output_5_0_g59672 = UV02420_g59660;
					float2 UV633_g59672 = temp_output_5_0_g59672;
					float2 UV100_g59673 = UV633_g59672;
					float2 temp_output_51_0_g59673 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59673 * float2( 3.464,3.464 ) ) );
					float2 break55_g59673 = frac( temp_output_51_0_g59673 );
					float temp_output_56_0_g59673 = ( ( 1.0 - break55_g59673.x ) - break55_g59673.y );
					float2 temp_output_52_0_g59673 = floor( temp_output_51_0_g59673 );
					float2 temp_output_125_0_g59673 = ( temp_output_52_0_g59673 + float2( 1,1 ) );
					float2 ifLocalVar87_g59673 = 0;
					if( temp_output_56_0_g59673 > 0.0 )
					ifLocalVar87_g59673 = temp_output_52_0_g59673;
					else if( temp_output_56_0_g59673 == 0.0 )
					ifLocalVar87_g59673 = temp_output_125_0_g59673;
					else if( temp_output_56_0_g59673 < 0.0 )
					ifLocalVar87_g59673 = temp_output_125_0_g59673;
					float3 temp_output_7_0_g59674 = frac( ( (ifLocalVar87_g59673).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59674 = dot( temp_output_7_0_g59674 , ( (temp_output_7_0_g59674).yzx + 33.33 ) );
					float3 temp_output_12_0_g59674 = ( temp_output_7_0_g59674 + dotResult8_g59674 );
					float2 temp_output_597_0_g59672 = ( UV100_g59673 + frac( ( ( (temp_output_12_0_g59674).xx + (temp_output_12_0_g59674).yz ) * (temp_output_12_0_g59674).zy ) ) );
					float2 DDX631_g59672 = ddx( temp_output_5_0_g59672 );
					float2 DDY632_g59672 = ddy( temp_output_5_0_g59672 );
					float temp_output_65_0_g59673 = ( 0.0 - temp_output_56_0_g59673 );
					float ifLocalVar59_g59673 = 0;
					if( temp_output_56_0_g59673 <= 0.0 )
					ifLocalVar59_g59673 = temp_output_65_0_g59673;
					else
					ifLocalVar59_g59673 = temp_output_56_0_g59673;
					float temp_output_597_30_g59672 = ifLocalVar59_g59673;
					float2 temp_output_90_0_g59673 = ( temp_output_52_0_g59673 + float2( 0,1 ) );
					float2 temp_output_123_0_g59673 = ( temp_output_52_0_g59673 + float2( 1,0 ) );
					float2 ifLocalVar88_g59673 = 0;
					if( temp_output_56_0_g59673 > 0.0 )
					ifLocalVar88_g59673 = temp_output_90_0_g59673;
					else if( temp_output_56_0_g59673 == 0.0 )
					ifLocalVar88_g59673 = temp_output_123_0_g59673;
					else if( temp_output_56_0_g59673 < 0.0 )
					ifLocalVar88_g59673 = temp_output_123_0_g59673;
					float3 temp_output_7_0_g59675 = frac( ( (ifLocalVar88_g59673).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59675 = dot( temp_output_7_0_g59675 , ( (temp_output_7_0_g59675).yzx + 33.33 ) );
					float3 temp_output_12_0_g59675 = ( temp_output_7_0_g59675 + dotResult8_g59675 );
					float2 temp_output_597_26_g59672 = ( UV100_g59673 + frac( ( ( (temp_output_12_0_g59675).xx + (temp_output_12_0_g59675).yz ) * (temp_output_12_0_g59675).zy ) ) );
					float temp_output_66_0_g59673 = ( 1.0 - break55_g59673.y );
					float ifLocalVar60_g59673 = 0;
					if( temp_output_56_0_g59673 <= 0.0 )
					ifLocalVar60_g59673 = temp_output_66_0_g59673;
					else
					ifLocalVar60_g59673 = break55_g59673.y;
					float temp_output_597_28_g59672 = ifLocalVar60_g59673;
					float2 ifLocalVar89_g59673 = 0;
					if( temp_output_56_0_g59673 > 0.0 )
					ifLocalVar89_g59673 = temp_output_123_0_g59673;
					else if( temp_output_56_0_g59673 == 0.0 )
					ifLocalVar89_g59673 = temp_output_90_0_g59673;
					else if( temp_output_56_0_g59673 < 0.0 )
					ifLocalVar89_g59673 = temp_output_90_0_g59673;
					float3 temp_output_7_0_g59676 = frac( ( (ifLocalVar89_g59673).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59676 = dot( temp_output_7_0_g59676 , ( (temp_output_7_0_g59676).yzx + 33.33 ) );
					float3 temp_output_12_0_g59676 = ( temp_output_7_0_g59676 + dotResult8_g59676 );
					float2 temp_output_597_27_g59672 = ( UV100_g59673 + frac( ( ( (temp_output_12_0_g59676).xx + (temp_output_12_0_g59676).yz ) * (temp_output_12_0_g59676).zy ) ) );
					float temp_output_67_0_g59673 = ( 1.0 - break55_g59673.x );
					float ifLocalVar61_g59673 = 0;
					if( temp_output_56_0_g59673 <= 0.0 )
					ifLocalVar61_g59673 = temp_output_67_0_g59673;
					else
					ifLocalVar61_g59673 = break55_g59673.x;
					float temp_output_597_29_g59672 = ifLocalVar61_g59673;
					float4 Output_2D293_g59672 = ( ( tex2D( _EmissionMap, temp_output_597_0_g59672, DDX631_g59672, DDY632_g59672 ) * temp_output_597_30_g59672 ) + ( tex2D( _EmissionMap, temp_output_597_26_g59672, DDX631_g59672, DDY632_g59672 ) * temp_output_597_28_g59672 ) + ( tex2D( _EmissionMap, temp_output_597_27_g59672, DDX631_g59672, DDY632_g59672 ) * temp_output_597_29_g59672 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g59660 = Output_2D293_g59672;
					#else
					float4 staticSwitch1006_g59660 = tex2D( _EmissionMap, UV02420_g59660 );
					#endif
					#if defined( _SPECIALEFFECTS_DISABLED )
					float4 staticSwitch1578_g59660 = staticSwitch1006_g59660;
					#elif defined( _SPECIALEFFECTS_LED )
					float4 staticSwitch1578_g59660 = float4( 0,0,0,0 );
					#else
					float4 staticSwitch1578_g59660 = staticSwitch1006_g59660;
					#endif
					#ifdef _EMISSIONENABLED_ON
					float4 staticSwitch1017_g59660 = ( float4( _EmissionColor , 0.0 ) * staticSwitch1578_g59660 * _EmissionIntensity );
					#else
					float4 staticSwitch1017_g59660 = temp_cast_5;
					#endif
					float4 Emission86_g59660 = staticSwitch1017_g59660;
					float3 WorldPos97_g59712 = PositionWS;
					float3 tanNormal85_g59712 = Normal_Map700_g59660;
					float3 worldNormal85_g59712 = float3( dot( tanToWorld0, tanNormal85_g59712 ), dot( tanToWorld1, tanNormal85_g59712 ), dot( tanToWorld2, tanNormal85_g59712 ) );
					float3 WorldNormal97_g59712 = worldNormal85_g59712;
					float Smoothness97_g59712 = Smoothness1399_g59660;
					float3 LightmapColor97_g59712 = Lightmap46_g59660.rgb;
					float3 ViewDir97_g59712 = ViewDirWS;
					float3 localSpecular97_g59712 = Specular( WorldPos97_g59712 , WorldNormal97_g59712 , Smoothness97_g59712 , LightmapColor97_g59712 , ViewDir97_g59712 );
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1181_g59660 = Lightmap46_g59660;
					#else
					float4 staticSwitch1181_g59660 = ( ( aAlbedo1466_g59660 * Lightmap46_g59660 ) + Specular1419_g59660 + Emission86_g59660 + float4( localSpecular97_g59712 , 0.0 ) );
					#endif
					float4 temp_output_35_0_g59683 = staticSwitch1181_g59660;
					float4 Color353_g59683 = temp_output_35_0_g59683;
					#if defined( _LUTMODE_2D )
					float4 staticSwitch273_g59683 = saturate( temp_output_35_0_g59683 );
					#elif defined( _LUTMODE_3D )
					float4 staticSwitch273_g59683 = temp_output_35_0_g59683;
					#else
					float4 staticSwitch273_g59683 = temp_output_35_0_g59683;
					#endif
					float4 Color_Saturate49_g59683 = staticSwitch273_g59683;
					float Lut_Height213_g59683 = _LUTSize;
					float Lut_Width216_g59683 = ( _LUTSize * Lut_Height213_g59683 );
					float3 appendResult214_g59683 = (float3(( 1.0 / Lut_Width216_g59683 ) , ( 1.0 / Lut_Height213_g59683 ) , ( Lut_Height213_g59683 - 1.0 )));
					float3 Scale_Offset208_g59683 = appendResult214_g59683;
					float2 Scale_Factor292_g59683 = ( (Scale_Offset208_g59683).xy * (Scale_Offset208_g59683).z );
					float2 Offset299_g59683 = ( (Scale_Offset208_g59683).xy * 0.5 );
					float3 Adjusted_UV305_g59683 = ( ( (Color_Saturate49_g59683).xyw * float3( Scale_Factor292_g59683 ,  0.0 ) ) + float3( Offset299_g59683 ,  0.0 ) );
					float2 Scaled_Blue280_g59683 = ( (Color_Saturate49_g59683).zw * (Scale_Offset208_g59683).z );
					float2 Shift288_g59683 = floor( Scaled_Blue280_g59683 );
					float2 Final_X313_g59683 = ( (Adjusted_UV305_g59683).xz + ( Shift288_g59683 * (Scale_Offset208_g59683).y ) );
					float2 appendResult326_g59683 = (float2(Final_X313_g59683));
					float2 Final_UV325_g59683 = appendResult326_g59683;
					float2 appendResult338_g59683 = (float2((Scale_Offset208_g59683).y , 0.0));
					float2 Offset_UV336_g59683 = ( Final_UV325_g59683 + appendResult338_g59683 );
					float3 lerpResult333_g59683 = lerp( tex2D( _2DLut, Final_UV325_g59683 ).rgb , tex2D( _2DLut, Offset_UV336_g59683 ).rgb , float3( ( Scaled_Blue280_g59683 - Shift288_g59683 ) ,  0.0 ));
					#ifdef _2DLUT
					float4 staticSwitch347_g59683 = float4( lerpResult333_g59683 , 0.0 );
					#else
					float4 staticSwitch347_g59683 = Color_Saturate49_g59683;
					#endif
					float4 TwoD_LUT346_g59683 = staticSwitch347_g59683;
					float3 RGB16_g59684 = ( ( log10( ( ( Color_Saturate49_g59683.xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 );
					#ifdef _3DLUT
					float4 staticSwitch194_g59683 = tex3D( _3DLut, RGB16_g59684 );
					#else
					float4 staticSwitch194_g59683 = Color_Saturate49_g59683;
					#endif
					float4 ThreeD_LUT51_g59683 = staticSwitch194_g59683;
					#if defined( _LUTMODE_2D )
					float4 staticSwitch42_g59683 = TwoD_LUT346_g59683;
					#elif defined( _LUTMODE_3D )
					float4 staticSwitch42_g59683 = ThreeD_LUT51_g59683;
					#else
					float4 staticSwitch42_g59683 = ThreeD_LUT51_g59683;
					#endif
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch41_g59683 = staticSwitch42_g59683;
					#else
					float4 staticSwitch41_g59683 = Color353_g59683;
					#endif
					float3 worldPos8_g59713 = PositionWS;
					float3 worldNormal8_g59713 = NormalWS;
					float3 viewDir8_g59713 = ViewDirWS;
					float _Steps8_g59713 = 50.0;
					float _StepSize8_g59713 = 0.5;
					float _Thickness8_g59713 = 0.02;
					float _Jitter8_g59713 = 0.5;
					float4 localMyCustomExpression8_g59713 = MyCustomExpression8_g59713( worldPos8_g59713 , worldNormal8_g59713 , viewDir8_g59713 , _Steps8_g59713 , _StepSize8_g59713 , _Thickness8_g59713 , _Jitter8_g59713 );
					float4 screenColor33_g59713 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,(localMyCustomExpression8_g59713).xy);
					float4 lerpResult45_g59713 = lerp( float4( staticSwitch41_g59683.xyz , 0.0 ) , screenColor33_g59713 , (localMyCustomExpression8_g59713).w);
					

					o.Albedo = staticSwitch1180_g59660.rgb;
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

					o.Emission = lerpResult45_g59713.rgb;
					o.Alpha = 1;
					half AlphaClipThreshold = 0.5;
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
					gi.light.color *= atten;

					half4 c = 0;
					#if defined(ASE_LIGHTING_SIMPLE)
						#if defined(_SPECULAR_SETUP)
							c += LightingBlinnPhong (o, ViewDirWS, gi);
						#else
							c += LightingLambert( o, gi );
						#endif
					#else
						#if defined(_SPECULAR_SETUP)
							c += LightingStandardSpecular(o, ViewDirWS, gi);
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

					#if defined( ASE_FOG )
						UNITY_EXTRACT_FOG_FROM_WORLD_POS( IN );
						UNITY_APPLY_FOG(_unity_fogCoord, c.rgb);
					#endif
					return c;
				}
			ENDCG
		}

		GrabPass{ }

		Pass
		{
			
			Name "Meta"
			Tags { "LightMode"="Meta" }
			Cull Off

			CGPROGRAM
				#define ASE_GEOMETRY
				#define ASE_FRAGMENT_NORMAL 0
				#define ASE_RECEIVE_SHADOWS
				#pragma multi_compile_instancing
				#pragma multi_compile _ LOD_FADE_CROSSFADE
				#define ASE_FOG
				#define ASE_LIGHTING_SIMPLE 1
				#define _SPECULARHIGHLIGHTS_OFF
				#define _GLOSSYREFLECTIONS_OFF
				#define ASE_VERSION 19907
				#if defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED)
				#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex);
				#else
				#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex)
				#endif

				#pragma vertex vert
				#pragma fragment frag
				#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
				#pragma shader_feature EDITOR_VISUALIZATION
				#ifndef UNITY_PASS_META
					#define UNITY_PASS_META
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
				#include "UnityMetaPass.cginc"

				#include "UnityStandardUtils.cginc"
				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
				#define ASE_NEEDS_VERT_TANGENT
				#define ASE_NEEDS_VERT_NORMAL
				#pragma shader_feature _LIGHTMAPDEBUG
				#pragma shader_feature_local_fragment _MAINTEX
				#pragma shader_feature_local _STOCHASTICENABLED_ON
				#pragma shader_feature_local_fragment _METALLICMAP
				#pragma shader_feature_local _LIGHTMAPMODE_DISABLED _LIGHTMAPMODE_SIMPLE _LIGHTMAPMODE_SIMPLELERP _LIGHTMAPMODE_RNM _LIGHTMAPMODE_RNMLERP
				#pragma shader_feature_local _USEBICUBICFILTERING_ON
				#pragma shader_feature_local_fragment _BUMPMAP
				#pragma shader_feature_local_fragment _USELIGHTMAPSPECULAR_ON
				#pragma shader_feature_local_fragment _USEGEOMETRICANTIALIASING_ON
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
					#ifdef EDITOR_VISUALIZATION
						float2 vizUV : TEXCOORD0;
						float4 lightCoord : TEXCOORD1;
					#endif
					float4 ase_texcoord2 : TEXCOORD2;
					float4 ase_texcoord3 : TEXCOORD3;
					float4 ase_texcoord4 : TEXCOORD4;
					float4 ase_texcoord5 : TEXCOORD5;
					float4 ase_texcoord6 : TEXCOORD6;
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
				UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
				uniform float4 _UdonSpecularLightUp[32];
				uniform float4 _UdonSpecularLightRight[32];
				uniform float4 _UdonSpecularLightCol[32];
				uniform float4 _UdonSpecularLightPos[32];
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
				ASE_DECLARE_SCREENSPACE_TEXTURE( _GrabTexture )


				float3 Specular( float3 WorldPos, float3 WorldNormal, float Smoothness, float3 LightmapColor, float3 ViewDir )
				{
					// --- CONFIGURATION ORIGINALE ---
					float LumaStart = 0.01;
					float LumaEnd   = 1.0;
					float SpecBoost = 0.2;
					// --- CONFIGURATION TRANSITION RADIUS ---
					// Doit être cohérent avec ton activationRadius dans Udon (50.0)
					float MaxRadius = 8.0; 
					float RadiusFadeStart = 0.0; // Le fondu commence à 40m
					// --- 1. EARLY EXIT ---
					float luma = dot(LightmapColor, float3(0.22, 0.70, 0.08));
					float lmMask = smoothstep(LumaStart, LumaEnd, luma);
					if (lmMask < 0.001 || Smoothness < 0.01 || _UdonSpecularLightCount == 0) return 0;
					// --- CALCUL DU FADE DE RAYON (SÉCURITÉ UDON) ---
					float playerDist = distance(_WorldSpaceCameraPos, WorldPos);
					// On crée un masque qui s'adoucit quand on s'approche des 50m
					float radiusFade = 1.0 - smoothstep(RadiusFadeStart, MaxRadius, playerDist);
					// Exit si on est au-delà du rayon d'activation
					if (radiusFade < 0.001) return 0;
					// --- 2. SETUP ---
					float3 vDir = normalize(ViewDir);
					float3 N = normalize(WorldNormal);
					float sharpSmooth = pow(Smoothness, 1.5); 
					float shininess = exp2(10.0 * sharpSmooth + 2.0); 
					float normalization = (shininess + 2.0) * 0.125;
					float nv = saturate(dot(N, vDir));
					float fresnel = 0.04 + 0.96 * pow(1.0 - nv, 5.0); 
					float3 R = reflect(-vDir, N);
					float3 specAccum = 0.0;
					// --- 3. BOUCLE ---
					int lightCount = (int)_UdonSpecularLightCount;
					for (int i = 0; i < lightCount; i++)
					{
					    float4 lightPosRange = _UdonSpecularLightPos[i];
					    float3 center = lightPosRange.xyz;
					    float range   = lightPosRange.w;
					    float3 L = center - WorldPos;
					    
					    float3 proj = R * dot(L, R) - L;
					    float3 closestPoint = center;
					    closestPoint += _UdonSpecularLightRight[i].xyz * clamp(dot(proj, _UdonSpecularLightRight[i].xyz), -_UdonSpecularLightRight[i].w, _UdonSpecularLightRight[i].w);
					    closestPoint += _UdonSpecularLightUp[i].xyz * clamp(dot(proj, _UdonSpecularLightUp[i].xyz), -_UdonSpecularLightUp[i].w, _UdonSpecularLightUp[i].w);
					    float3 diff = closestPoint - WorldPos;
					    float distSq = dot(diff, diff);
					    
					    float falloff = saturate(1.0 - (distSq / (range * range)));
					    falloff *= falloff; 
					    if (falloff > 0)
					    {
					        float3 lDir = normalize(diff);
					        float nDotL = saturate(dot(N, lDir));
					        if (nDotL > 0)
					        {
					            float nDotH = saturate(dot(N, normalize(lDir + vDir)));
					            float spec = pow(nDotH, shininess) * normalization;
					            specAccum += _UdonSpecularLightCol[i].rgb * (spec * nDotL * _UdonSpecularLightCol[i].w * falloff);
					        }
					    }
					}
					// Multiplié par radiusFade pour une disparition douce aux limites de l'Udon
					return specAccum * fresnel * lmMask * SpecBoost * radiusFade;
				}
				
				float4 MyCustomExpression8_g59713( float3 worldPos, float3 worldNormal, float3 viewDir, float _Steps, float _StepSize, float _Thickness, float _Jitter )
				{
					// Calcul des UV écran pour le Jitter et la profondeur
					float2 screenUV = ComputeScreenPos(mul(unity_MatrixVP, float4(worldPos, 1.0))).xy / ComputeScreenPos(mul(unity_MatrixVP, float4(worldPos, 1.0))).w;
					float3 V = normalize(viewDir);
					float3 N = normalize(worldNormal);
					float3 R = reflect(-V, N);
					float3 vPos = mul(unity_MatrixV, float4(worldPos, 1.0)).xyz;
					float3 vDir = mul((float3x3)unity_MatrixV, R);
					vDir = normalize(vDir);
					// Utilisation du Jitter pour casser les lignes
					float noise = frac(sin(dot(screenUV, float2(12.9898, 78.233))) * 43758.5453);
					float currentDist = _StepSize + (noise * _StepSize * _Jitter);
					float4 res = float4(0,0,0,0);
					for (int i = 0; i < (int)_Steps; i++)
					{
					    float3 p = vPos + vDir * currentDist;
					    float4 proj = mul(unity_CameraProjection, float4(p, 1.0));
					    float2 uv = (proj.xy / proj.w) * 0.5 + 0.5;
					    // Sortie si hors écran
					    if (uv.x < 0 || uv.x > 1 || uv.y < 0 || uv.y > 1) break;
					    // Lecture de la profondeur
					    float sceneZ = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, uv));
					    float rayZ = -p.z;
					    // Épaisseur adaptative (astuce pour "souder" les lignes)
					    float thickness = _Thickness * (1.0 + currentDist * 0.1);
					    if (rayZ > sceneZ && rayZ < sceneZ + thickness)
					    {
					        // On renvoie les UV pour le Grab Screen et 1 dans le W pour le masque
					        return float4(uv, 0, 1.0);
					    }
					    currentDist += _StepSize;
					}
					return res;
				}
				

				v2f VertexFunction( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					o.ase_texcoord3.xyz = ase_positionWS;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					o.ase_texcoord4.xyz = ase_tangentWS;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					o.ase_texcoord5.xyz = ase_normalWS;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					o.ase_texcoord6.xyz = ase_bitangentWS;
					
					o.ase_texcoord2 = v.texcoord.xyzw;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord3.w = 0;
					o.ase_texcoord4.w = 0;
					o.ase_texcoord5.w = 0;
					o.ase_texcoord6.w = 0;

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

					#ifdef EDITOR_VISUALIZATION
						o.vizUV = 0;
						o.lightCoord = 0;
						if (unity_VisualizationMode == EDITORVIZ_TEXTURE)
							o.vizUV = UnityMetaVizUV(unity_EditorViz_UVIndex, v.texcoord.xy, v.texcoord1.xy, v.texcoord2.xy, unity_EditorViz_Texture_ST);
						else if (unity_VisualizationMode == EDITORVIZ_SHOWLIGHTMASK)
						{
							o.vizUV = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
							o.lightCoord = mul(unity_EditorViz_WorldToLight, mul(unity_ObjectToWorld, float4(v.vertex.xyz, 1)));
						}
					#endif

					o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST);
					return o;
				}

				#if defined(ASE_TESSELLATION)
				struct VertexControl
				{
					float4 vertex : INTERNALTESSPOS;
					float4 tangent : TANGENT;
					float3 normal : NORMAL;
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
				v2f vert( appdata v )
				{
					return VertexFunction( v );
				}
				#endif

				half4 frag( v2f IN , uint ase_vface : SV_IsFrontFace ) : SV_Target
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

					float2 texCoord2357_g59660 = IN.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV02420_g59660 = texCoord2357_g59660;
					float2 temp_output_5_0_g59707 = UV02420_g59660;
					float2 UV633_g59707 = temp_output_5_0_g59707;
					float2 UV100_g59708 = UV633_g59707;
					float2 temp_output_51_0_g59708 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59708 * float2( 3.464,3.464 ) ) );
					float2 break55_g59708 = frac( temp_output_51_0_g59708 );
					float temp_output_56_0_g59708 = ( ( 1.0 - break55_g59708.x ) - break55_g59708.y );
					float2 temp_output_52_0_g59708 = floor( temp_output_51_0_g59708 );
					float2 temp_output_125_0_g59708 = ( temp_output_52_0_g59708 + float2( 1,1 ) );
					float2 ifLocalVar87_g59708 = 0;
					if( temp_output_56_0_g59708 > 0.0 )
					ifLocalVar87_g59708 = temp_output_52_0_g59708;
					else if( temp_output_56_0_g59708 == 0.0 )
					ifLocalVar87_g59708 = temp_output_125_0_g59708;
					else if( temp_output_56_0_g59708 < 0.0 )
					ifLocalVar87_g59708 = temp_output_125_0_g59708;
					float3 temp_output_7_0_g59709 = frac( ( (ifLocalVar87_g59708).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59709 = dot( temp_output_7_0_g59709 , ( (temp_output_7_0_g59709).yzx + 33.33 ) );
					float3 temp_output_12_0_g59709 = ( temp_output_7_0_g59709 + dotResult8_g59709 );
					float2 temp_output_597_0_g59707 = ( UV100_g59708 + frac( ( ( (temp_output_12_0_g59709).xx + (temp_output_12_0_g59709).yz ) * (temp_output_12_0_g59709).zy ) ) );
					float2 DDX631_g59707 = ddx( temp_output_5_0_g59707 );
					float2 DDY632_g59707 = ddy( temp_output_5_0_g59707 );
					float temp_output_65_0_g59708 = ( 0.0 - temp_output_56_0_g59708 );
					float ifLocalVar59_g59708 = 0;
					if( temp_output_56_0_g59708 <= 0.0 )
					ifLocalVar59_g59708 = temp_output_65_0_g59708;
					else
					ifLocalVar59_g59708 = temp_output_56_0_g59708;
					float temp_output_597_30_g59707 = ifLocalVar59_g59708;
					float2 temp_output_90_0_g59708 = ( temp_output_52_0_g59708 + float2( 0,1 ) );
					float2 temp_output_123_0_g59708 = ( temp_output_52_0_g59708 + float2( 1,0 ) );
					float2 ifLocalVar88_g59708 = 0;
					if( temp_output_56_0_g59708 > 0.0 )
					ifLocalVar88_g59708 = temp_output_90_0_g59708;
					else if( temp_output_56_0_g59708 == 0.0 )
					ifLocalVar88_g59708 = temp_output_123_0_g59708;
					else if( temp_output_56_0_g59708 < 0.0 )
					ifLocalVar88_g59708 = temp_output_123_0_g59708;
					float3 temp_output_7_0_g59710 = frac( ( (ifLocalVar88_g59708).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59710 = dot( temp_output_7_0_g59710 , ( (temp_output_7_0_g59710).yzx + 33.33 ) );
					float3 temp_output_12_0_g59710 = ( temp_output_7_0_g59710 + dotResult8_g59710 );
					float2 temp_output_597_26_g59707 = ( UV100_g59708 + frac( ( ( (temp_output_12_0_g59710).xx + (temp_output_12_0_g59710).yz ) * (temp_output_12_0_g59710).zy ) ) );
					float temp_output_66_0_g59708 = ( 1.0 - break55_g59708.y );
					float ifLocalVar60_g59708 = 0;
					if( temp_output_56_0_g59708 <= 0.0 )
					ifLocalVar60_g59708 = temp_output_66_0_g59708;
					else
					ifLocalVar60_g59708 = break55_g59708.y;
					float temp_output_597_28_g59707 = ifLocalVar60_g59708;
					float2 ifLocalVar89_g59708 = 0;
					if( temp_output_56_0_g59708 > 0.0 )
					ifLocalVar89_g59708 = temp_output_123_0_g59708;
					else if( temp_output_56_0_g59708 == 0.0 )
					ifLocalVar89_g59708 = temp_output_90_0_g59708;
					else if( temp_output_56_0_g59708 < 0.0 )
					ifLocalVar89_g59708 = temp_output_90_0_g59708;
					float3 temp_output_7_0_g59711 = frac( ( (ifLocalVar89_g59708).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59711 = dot( temp_output_7_0_g59711 , ( (temp_output_7_0_g59711).yzx + 33.33 ) );
					float3 temp_output_12_0_g59711 = ( temp_output_7_0_g59711 + dotResult8_g59711 );
					float2 temp_output_597_27_g59707 = ( UV100_g59708 + frac( ( ( (temp_output_12_0_g59711).xx + (temp_output_12_0_g59711).yz ) * (temp_output_12_0_g59711).zy ) ) );
					float temp_output_67_0_g59708 = ( 1.0 - break55_g59708.x );
					float ifLocalVar61_g59708 = 0;
					if( temp_output_56_0_g59708 <= 0.0 )
					ifLocalVar61_g59708 = temp_output_67_0_g59708;
					else
					ifLocalVar61_g59708 = break55_g59708.x;
					float temp_output_597_29_g59707 = ifLocalVar61_g59708;
					float4 Output_2D293_g59707 = ( ( tex2D( _MainTex, temp_output_597_0_g59707, DDX631_g59707, DDY632_g59707 ) * temp_output_597_30_g59707 ) + ( tex2D( _MainTex, temp_output_597_26_g59707, DDX631_g59707, DDY632_g59707 ) * temp_output_597_28_g59707 ) + ( tex2D( _MainTex, temp_output_597_27_g59707, DDX631_g59707, DDY632_g59707 ) * temp_output_597_29_g59707 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g59660 = Output_2D293_g59707;
					#else
					float4 staticSwitch1001_g59660 = tex2D( _MainTex, UV02420_g59660 );
					#endif
					#ifdef _MAINTEX
					float4 staticSwitch1549_g59660 = staticSwitch1001_g59660;
					#else
					float4 staticSwitch1549_g59660 = _Color;
					#endif
					float4 oAlbedo6_g59660 = staticSwitch1549_g59660;
					float Black1185_g59660 = 0.0;
					float4 temp_cast_0 = (Black1185_g59660).xxxx;
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1180_g59660 = temp_cast_0;
					#else
					float4 staticSwitch1180_g59660 = oAlbedo6_g59660;
					#endif
					
					float2 temp_output_5_0_g59666 = UV02420_g59660;
					float2 UV633_g59666 = temp_output_5_0_g59666;
					float2 UV100_g59667 = UV633_g59666;
					float2 temp_output_51_0_g59667 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59667 * float2( 3.464,3.464 ) ) );
					float2 break55_g59667 = frac( temp_output_51_0_g59667 );
					float temp_output_56_0_g59667 = ( ( 1.0 - break55_g59667.x ) - break55_g59667.y );
					float2 temp_output_52_0_g59667 = floor( temp_output_51_0_g59667 );
					float2 temp_output_125_0_g59667 = ( temp_output_52_0_g59667 + float2( 1,1 ) );
					float2 ifLocalVar87_g59667 = 0;
					if( temp_output_56_0_g59667 > 0.0 )
					ifLocalVar87_g59667 = temp_output_52_0_g59667;
					else if( temp_output_56_0_g59667 == 0.0 )
					ifLocalVar87_g59667 = temp_output_125_0_g59667;
					else if( temp_output_56_0_g59667 < 0.0 )
					ifLocalVar87_g59667 = temp_output_125_0_g59667;
					float3 temp_output_7_0_g59668 = frac( ( (ifLocalVar87_g59667).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59668 = dot( temp_output_7_0_g59668 , ( (temp_output_7_0_g59668).yzx + 33.33 ) );
					float3 temp_output_12_0_g59668 = ( temp_output_7_0_g59668 + dotResult8_g59668 );
					float2 temp_output_597_0_g59666 = ( UV100_g59667 + frac( ( ( (temp_output_12_0_g59668).xx + (temp_output_12_0_g59668).yz ) * (temp_output_12_0_g59668).zy ) ) );
					float2 DDX631_g59666 = ddx( temp_output_5_0_g59666 );
					float2 DDY632_g59666 = ddy( temp_output_5_0_g59666 );
					float temp_output_65_0_g59667 = ( 0.0 - temp_output_56_0_g59667 );
					float ifLocalVar59_g59667 = 0;
					if( temp_output_56_0_g59667 <= 0.0 )
					ifLocalVar59_g59667 = temp_output_65_0_g59667;
					else
					ifLocalVar59_g59667 = temp_output_56_0_g59667;
					float temp_output_597_30_g59666 = ifLocalVar59_g59667;
					float2 temp_output_90_0_g59667 = ( temp_output_52_0_g59667 + float2( 0,1 ) );
					float2 temp_output_123_0_g59667 = ( temp_output_52_0_g59667 + float2( 1,0 ) );
					float2 ifLocalVar88_g59667 = 0;
					if( temp_output_56_0_g59667 > 0.0 )
					ifLocalVar88_g59667 = temp_output_90_0_g59667;
					else if( temp_output_56_0_g59667 == 0.0 )
					ifLocalVar88_g59667 = temp_output_123_0_g59667;
					else if( temp_output_56_0_g59667 < 0.0 )
					ifLocalVar88_g59667 = temp_output_123_0_g59667;
					float3 temp_output_7_0_g59669 = frac( ( (ifLocalVar88_g59667).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59669 = dot( temp_output_7_0_g59669 , ( (temp_output_7_0_g59669).yzx + 33.33 ) );
					float3 temp_output_12_0_g59669 = ( temp_output_7_0_g59669 + dotResult8_g59669 );
					float2 temp_output_597_26_g59666 = ( UV100_g59667 + frac( ( ( (temp_output_12_0_g59669).xx + (temp_output_12_0_g59669).yz ) * (temp_output_12_0_g59669).zy ) ) );
					float temp_output_66_0_g59667 = ( 1.0 - break55_g59667.y );
					float ifLocalVar60_g59667 = 0;
					if( temp_output_56_0_g59667 <= 0.0 )
					ifLocalVar60_g59667 = temp_output_66_0_g59667;
					else
					ifLocalVar60_g59667 = break55_g59667.y;
					float temp_output_597_28_g59666 = ifLocalVar60_g59667;
					float2 ifLocalVar89_g59667 = 0;
					if( temp_output_56_0_g59667 > 0.0 )
					ifLocalVar89_g59667 = temp_output_123_0_g59667;
					else if( temp_output_56_0_g59667 == 0.0 )
					ifLocalVar89_g59667 = temp_output_90_0_g59667;
					else if( temp_output_56_0_g59667 < 0.0 )
					ifLocalVar89_g59667 = temp_output_90_0_g59667;
					float3 temp_output_7_0_g59670 = frac( ( (ifLocalVar89_g59667).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59670 = dot( temp_output_7_0_g59670 , ( (temp_output_7_0_g59670).yzx + 33.33 ) );
					float3 temp_output_12_0_g59670 = ( temp_output_7_0_g59670 + dotResult8_g59670 );
					float2 temp_output_597_27_g59666 = ( UV100_g59667 + frac( ( ( (temp_output_12_0_g59670).xx + (temp_output_12_0_g59670).yz ) * (temp_output_12_0_g59670).zy ) ) );
					float temp_output_67_0_g59667 = ( 1.0 - break55_g59667.x );
					float ifLocalVar61_g59667 = 0;
					if( temp_output_56_0_g59667 <= 0.0 )
					ifLocalVar61_g59667 = temp_output_67_0_g59667;
					else
					ifLocalVar61_g59667 = break55_g59667.x;
					float temp_output_597_29_g59666 = ifLocalVar61_g59667;
					float4 Output_2D293_g59666 = ( ( tex2D( _MetallicMap, temp_output_597_0_g59666, DDX631_g59666, DDY632_g59666 ) * temp_output_597_30_g59666 ) + ( tex2D( _MetallicMap, temp_output_597_26_g59666, DDX631_g59666, DDY632_g59666 ) * temp_output_597_28_g59666 ) + ( tex2D( _MetallicMap, temp_output_597_27_g59666, DDX631_g59666, DDY632_g59666 ) * temp_output_597_29_g59666 ) );
					float4 break31_g59666 = Output_2D293_g59666;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g59660 = break31_g59666.a;
					#else
					float staticSwitch1005_g59660 = tex2D( _MetallicMap, UV02420_g59660 ).a;
					#endif
					#ifdef _METALLICMAP
					float staticSwitch846_g59660 = staticSwitch1005_g59660;
					#else
					float staticSwitch846_g59660 = _Metallic;
					#endif
					float Metallic1239_g59660 = staticSwitch846_g59660;
					float4 aAlbedo1466_g59660 = ( staticSwitch1549_g59660 * ( 1.0 - Metallic1239_g59660 ) );
					float White38_g59660 = 1.0;
					float4 temp_cast_2 = (White38_g59660).xxxx;
					float4 texCoord2426_g59660 = IN.ase_texcoord2;
					texCoord2426_g59660.xy = IN.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV12361_g59660 = (texCoord2426_g59660).zw;
					float localBicubicPrepare2_g59701 = ( 0.0 );
					float2 Input_UV100_g59701 = UV12361_g59660;
					float2 UV2_g59701 = Input_UV100_g59701;
					float4 TexelSize2_g59701 = _Lightmap0_TexelSize;
					float2 UV02_g59701 = float2( 0,0 );
					float2 UV12_g59701 = float2( 0,0 );
					float2 UV22_g59701 = float2( 0,0 );
					float2 UV32_g59701 = float2( 0,0 );
					float W02_g59701 = 0;
					float W12_g59701 = 0;
					{
					{
					 UV2_g59701 = UV2_g59701 * TexelSize2_g59701.zw - 0.5;
					    float2 f = frac( UV2_g59701 );
					    UV2_g59701 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59701.x - 0.5, UV2_g59701.x + 1.5, UV2_g59701.y - 0.5, UV2_g59701.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59701.xyxy;
					    UV02_g59701 = off.xz;
					    UV12_g59701 = off.yz;
					    UV22_g59701 = off.xw;
					    UV32_g59701 = off.yw;
					    W02_g59701 = s.x / ( s.x + s.y );
					 W12_g59701 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59701 = lerp( tex2D( _Lightmap0, UV32_g59701 ) , tex2D( _Lightmap0, UV22_g59701 ) , W02_g59701);
					float4 lerpResult45_g59701 = lerp( tex2D( _Lightmap0, UV12_g59701 ) , tex2D( _Lightmap0, UV02_g59701 ) , W02_g59701);
					float4 lerpResult44_g59701 = lerp( lerpResult46_g59701 , lerpResult45_g59701 , W12_g59701);
					float4 Output_2D_Auto131_g59701 = lerpResult44_g59701;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g59660 = Output_2D_Auto131_g59701;
					#else
					float4 staticSwitch1092_g59660 = tex2D( _Lightmap0, UV12361_g59660 );
					#endif
					float4 Lightmap_0925_g59660 = staticSwitch1092_g59660;
					float localBicubicPrepare2_g59699 = ( 0.0 );
					float2 Input_UV100_g59699 = UV12361_g59660;
					float2 UV2_g59699 = Input_UV100_g59699;
					float4 TexelSize2_g59699 = _Lightmap1_TexelSize;
					float2 UV02_g59699 = float2( 0,0 );
					float2 UV12_g59699 = float2( 0,0 );
					float2 UV22_g59699 = float2( 0,0 );
					float2 UV32_g59699 = float2( 0,0 );
					float W02_g59699 = 0;
					float W12_g59699 = 0;
					{
					{
					 UV2_g59699 = UV2_g59699 * TexelSize2_g59699.zw - 0.5;
					    float2 f = frac( UV2_g59699 );
					    UV2_g59699 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59699.x - 0.5, UV2_g59699.x + 1.5, UV2_g59699.y - 0.5, UV2_g59699.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59699.xyxy;
					    UV02_g59699 = off.xz;
					    UV12_g59699 = off.yz;
					    UV22_g59699 = off.xw;
					    UV32_g59699 = off.yw;
					    W02_g59699 = s.x / ( s.x + s.y );
					 W12_g59699 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59699 = lerp( tex2D( _Lightmap1, UV32_g59699 ) , tex2D( _Lightmap1, UV22_g59699 ) , W02_g59699);
					float4 lerpResult45_g59699 = lerp( tex2D( _Lightmap1, UV12_g59699 ) , tex2D( _Lightmap1, UV02_g59699 ) , W02_g59699);
					float4 lerpResult44_g59699 = lerp( lerpResult46_g59699 , lerpResult45_g59699 , W12_g59699);
					float4 Output_2D_Auto131_g59699 = lerpResult44_g59699;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g59660 = Output_2D_Auto131_g59699;
					#else
					float4 staticSwitch1088_g59660 = tex2D( _Lightmap1, UV12361_g59660 );
					#endif
					float4 Lightmap_1956_g59660 = staticSwitch1088_g59660;
					float4 lerpResult442_g59660 = lerp( Lightmap_0925_g59660 , Lightmap_1956_g59660 , _LIGHTMAPLERP);
					float4 Lightmap_Lerp932_g59660 = lerpResult442_g59660;
					float3 appendResult139_g59689 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float2 temp_output_5_0_g59661 = UV02420_g59660;
					float2 UV633_g59661 = temp_output_5_0_g59661;
					float2 UV100_g59662 = UV633_g59661;
					float2 temp_output_51_0_g59662 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59662 * float2( 3.464,3.464 ) ) );
					float2 break55_g59662 = frac( temp_output_51_0_g59662 );
					float temp_output_56_0_g59662 = ( ( 1.0 - break55_g59662.x ) - break55_g59662.y );
					float2 temp_output_52_0_g59662 = floor( temp_output_51_0_g59662 );
					float2 temp_output_125_0_g59662 = ( temp_output_52_0_g59662 + float2( 1,1 ) );
					float2 ifLocalVar87_g59662 = 0;
					if( temp_output_56_0_g59662 > 0.0 )
					ifLocalVar87_g59662 = temp_output_52_0_g59662;
					else if( temp_output_56_0_g59662 == 0.0 )
					ifLocalVar87_g59662 = temp_output_125_0_g59662;
					else if( temp_output_56_0_g59662 < 0.0 )
					ifLocalVar87_g59662 = temp_output_125_0_g59662;
					float3 temp_output_7_0_g59663 = frac( ( (ifLocalVar87_g59662).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59663 = dot( temp_output_7_0_g59663 , ( (temp_output_7_0_g59663).yzx + 33.33 ) );
					float3 temp_output_12_0_g59663 = ( temp_output_7_0_g59663 + dotResult8_g59663 );
					float2 temp_output_597_0_g59661 = ( UV100_g59662 + frac( ( ( (temp_output_12_0_g59663).xx + (temp_output_12_0_g59663).yz ) * (temp_output_12_0_g59663).zy ) ) );
					float2 DDX631_g59661 = ddx( temp_output_5_0_g59661 );
					float2 DDY632_g59661 = ddy( temp_output_5_0_g59661 );
					float Input_Scale617_g59661 = 2.0;
					float temp_output_65_0_g59662 = ( 0.0 - temp_output_56_0_g59662 );
					float ifLocalVar59_g59662 = 0;
					if( temp_output_56_0_g59662 <= 0.0 )
					ifLocalVar59_g59662 = temp_output_65_0_g59662;
					else
					ifLocalVar59_g59662 = temp_output_56_0_g59662;
					float temp_output_597_30_g59661 = ifLocalVar59_g59662;
					float2 temp_output_90_0_g59662 = ( temp_output_52_0_g59662 + float2( 0,1 ) );
					float2 temp_output_123_0_g59662 = ( temp_output_52_0_g59662 + float2( 1,0 ) );
					float2 ifLocalVar88_g59662 = 0;
					if( temp_output_56_0_g59662 > 0.0 )
					ifLocalVar88_g59662 = temp_output_90_0_g59662;
					else if( temp_output_56_0_g59662 == 0.0 )
					ifLocalVar88_g59662 = temp_output_123_0_g59662;
					else if( temp_output_56_0_g59662 < 0.0 )
					ifLocalVar88_g59662 = temp_output_123_0_g59662;
					float3 temp_output_7_0_g59664 = frac( ( (ifLocalVar88_g59662).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59664 = dot( temp_output_7_0_g59664 , ( (temp_output_7_0_g59664).yzx + 33.33 ) );
					float3 temp_output_12_0_g59664 = ( temp_output_7_0_g59664 + dotResult8_g59664 );
					float2 temp_output_597_26_g59661 = ( UV100_g59662 + frac( ( ( (temp_output_12_0_g59664).xx + (temp_output_12_0_g59664).yz ) * (temp_output_12_0_g59664).zy ) ) );
					float temp_output_66_0_g59662 = ( 1.0 - break55_g59662.y );
					float ifLocalVar60_g59662 = 0;
					if( temp_output_56_0_g59662 <= 0.0 )
					ifLocalVar60_g59662 = temp_output_66_0_g59662;
					else
					ifLocalVar60_g59662 = break55_g59662.y;
					float temp_output_597_28_g59661 = ifLocalVar60_g59662;
					float2 ifLocalVar89_g59662 = 0;
					if( temp_output_56_0_g59662 > 0.0 )
					ifLocalVar89_g59662 = temp_output_123_0_g59662;
					else if( temp_output_56_0_g59662 == 0.0 )
					ifLocalVar89_g59662 = temp_output_90_0_g59662;
					else if( temp_output_56_0_g59662 < 0.0 )
					ifLocalVar89_g59662 = temp_output_90_0_g59662;
					float3 temp_output_7_0_g59665 = frac( ( (ifLocalVar89_g59662).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59665 = dot( temp_output_7_0_g59665 , ( (temp_output_7_0_g59665).yzx + 33.33 ) );
					float3 temp_output_12_0_g59665 = ( temp_output_7_0_g59665 + dotResult8_g59665 );
					float2 temp_output_597_27_g59661 = ( UV100_g59662 + frac( ( ( (temp_output_12_0_g59665).xx + (temp_output_12_0_g59665).yz ) * (temp_output_12_0_g59665).zy ) ) );
					float temp_output_67_0_g59662 = ( 1.0 - break55_g59662.x );
					float ifLocalVar61_g59662 = 0;
					if( temp_output_56_0_g59662 <= 0.0 )
					ifLocalVar61_g59662 = temp_output_67_0_g59662;
					else
					ifLocalVar61_g59662 = break55_g59662.x;
					float temp_output_597_29_g59661 = ifLocalVar61_g59662;
					float3 Output_2D_Normal641_g59661 = ( ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_0_g59661, DDX631_g59661, DDY632_g59661 ), Input_Scale617_g59661 ) * temp_output_597_30_g59661 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_26_g59661, DDX631_g59661, DDY632_g59661 ), Input_Scale617_g59661 ) * temp_output_597_28_g59661 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_27_g59661, DDX631_g59661, DDY632_g59661 ), Input_Scale617_g59661 ) * float3( 0,0,0 ) * temp_output_597_29_g59661 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g59660 = Output_2D_Normal641_g59661;
					#else
					float3 staticSwitch1003_g59660 = UnpackScaleNormal( tex2D( _BumpMap, UV02420_g59660 ), 2.0 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g59660 = staticSwitch1003_g59660;
					#else
					float3 staticSwitch980_g59660 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g59660 = staticSwitch980_g59660;
					float3 normalizeResult326_g59689 = normalize( Normal_Map700_g59660 );
					float3 Normal_Map318_g59689 = normalizeResult326_g59689;
					float dotResult121_g59689 = dot( appendResult139_g59689 , Normal_Map318_g59689 );
					float temp_output_2_0_g59692 = saturate( dotResult121_g59689 );
					float localStochasticTiling2_g59703 = ( 0.0 );
					float2 UV2_g59703 = UV12361_g59660;
					float4 TexelSize2_g59703 = _RNMX0_TexelSize;
					float4 Offsets2_g59703 = float4( 0,0,0,0 );
					float2 Weights2_g59703 = float2( 0,0 );
					{
					UV2_g59703 = UV2_g59703 * TexelSize2_g59703.zw - 0.5;
					float2 f = frac( UV2_g59703 );
					UV2_g59703 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g59703.x - 0.5, UV2_g59703.x + 1.5, UV2_g59703.y - 0.5, UV2_g59703.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g59703 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59703.xyxy;
					Weights2_g59703 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g59702 = Offsets2_g59703;
					float4 Input_FetchOffsets197_g59704 = temp_output_1_34_g59702;
					float2 temp_output_1_54_g59702 = Weights2_g59703;
					float2 Input_FetchWeights200_g59704 = temp_output_1_54_g59702;
					float2 break187_g59704 = Input_FetchWeights200_g59704;
					float4 lerpResult181_g59704 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g59704).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g59704).xw ) , break187_g59704.x);
					float4 lerpResult182_g59704 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g59704).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g59704).xz ) , break187_g59704.x);
					float4 lerpResult176_g59704 = lerp( lerpResult181_g59704 , lerpResult182_g59704 , break187_g59704.y);
					float4 Output_Fetch2D_Auto202_g59704 = lerpResult176_g59704;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g59660 = Output_Fetch2D_Auto202_g59704;
					#else
					float4 staticSwitch1061_g59660 = tex2D( _RNMX0, UV12361_g59660 );
					#endif
					float3 appendResult146_g59689 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59689 = dot( appendResult146_g59689 , Normal_Map318_g59689 );
					float temp_output_2_0_g59691 = saturate( dotResult122_g59689 );
					float4 Input_FetchOffsets197_g59705 = temp_output_1_34_g59702;
					float2 Input_FetchWeights200_g59705 = temp_output_1_54_g59702;
					float2 break187_g59705 = Input_FetchWeights200_g59705;
					float4 lerpResult181_g59705 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g59705).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g59705).xw ) , break187_g59705.x);
					float4 lerpResult182_g59705 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g59705).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g59705).xz ) , break187_g59705.x);
					float4 lerpResult176_g59705 = lerp( lerpResult181_g59705 , lerpResult182_g59705 , break187_g59705.y);
					float4 Output_Fetch2D_Auto202_g59705 = lerpResult176_g59705;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g59660 = Output_Fetch2D_Auto202_g59705;
					#else
					float4 staticSwitch1062_g59660 = tex2D( _RNMY0, UV12361_g59660 );
					#endif
					float3 appendResult149_g59689 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59689 = dot( appendResult149_g59689 , Normal_Map318_g59689 );
					float temp_output_2_0_g59690 = saturate( dotResult120_g59689 );
					float4 Input_FetchOffsets197_g59706 = temp_output_1_34_g59702;
					float2 Input_FetchWeights200_g59706 = temp_output_1_54_g59702;
					float2 break187_g59706 = Input_FetchWeights200_g59706;
					float4 lerpResult181_g59706 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g59706).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g59706).xw ) , break187_g59706.x);
					float4 lerpResult182_g59706 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g59706).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g59706).xz ) , break187_g59706.x);
					float4 lerpResult176_g59706 = lerp( lerpResult181_g59706 , lerpResult182_g59706 , break187_g59706.y);
					float4 Output_Fetch2D_Auto202_g59706 = lerpResult176_g59706;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g59660 = Output_Fetch2D_Auto202_g59706;
					#else
					float4 staticSwitch1063_g59660 = tex2D( _RNMZ0, UV12361_g59660 );
					#endif
					float4 RNM_0926_g59660 = ( ( ( ( temp_output_2_0_g59692 * temp_output_2_0_g59692 ) * staticSwitch1061_g59660 ) + ( ( temp_output_2_0_g59691 * temp_output_2_0_g59691 ) * staticSwitch1062_g59660 ) ) + ( ( temp_output_2_0_g59690 * temp_output_2_0_g59690 ) * staticSwitch1063_g59660 ) );
					float3 appendResult139_g59685 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g59685 = normalize( Normal_Map700_g59660 );
					float3 Normal_Map318_g59685 = normalizeResult326_g59685;
					float dotResult121_g59685 = dot( appendResult139_g59685 , Normal_Map318_g59685 );
					float temp_output_2_0_g59688 = saturate( dotResult121_g59685 );
					float localStochasticTiling2_g59694 = ( 0.0 );
					float2 UV2_g59694 = UV12361_g59660;
					float4 TexelSize2_g59694 = _RNMX1_TexelSize;
					float4 Offsets2_g59694 = float4( 0,0,0,0 );
					float2 Weights2_g59694 = float2( 0,0 );
					{
					UV2_g59694 = UV2_g59694 * TexelSize2_g59694.zw - 0.5;
					float2 f = frac( UV2_g59694 );
					UV2_g59694 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g59694.x - 0.5, UV2_g59694.x + 1.5, UV2_g59694.y - 0.5, UV2_g59694.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g59694 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59694.xyxy;
					Weights2_g59694 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g59693 = Offsets2_g59694;
					float4 Input_FetchOffsets197_g59695 = temp_output_1_34_g59693;
					float2 temp_output_1_54_g59693 = Weights2_g59694;
					float2 Input_FetchWeights200_g59695 = temp_output_1_54_g59693;
					float2 break187_g59695 = Input_FetchWeights200_g59695;
					float4 lerpResult181_g59695 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g59695).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g59695).xw ) , break187_g59695.x);
					float4 lerpResult182_g59695 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g59695).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g59695).xz ) , break187_g59695.x);
					float4 lerpResult176_g59695 = lerp( lerpResult181_g59695 , lerpResult182_g59695 , break187_g59695.y);
					float4 Output_Fetch2D_Auto202_g59695 = lerpResult176_g59695;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g59660 = Output_Fetch2D_Auto202_g59695;
					#else
					float4 staticSwitch1087_g59660 = tex2D( _RNMX1, UV12361_g59660 );
					#endif
					float3 appendResult146_g59685 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59685 = dot( appendResult146_g59685 , Normal_Map318_g59685 );
					float temp_output_2_0_g59687 = saturate( dotResult122_g59685 );
					float4 Input_FetchOffsets197_g59696 = temp_output_1_34_g59693;
					float2 Input_FetchWeights200_g59696 = temp_output_1_54_g59693;
					float2 break187_g59696 = Input_FetchWeights200_g59696;
					float4 lerpResult181_g59696 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g59696).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g59696).xw ) , break187_g59696.x);
					float4 lerpResult182_g59696 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g59696).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g59696).xz ) , break187_g59696.x);
					float4 lerpResult176_g59696 = lerp( lerpResult181_g59696 , lerpResult182_g59696 , break187_g59696.y);
					float4 Output_Fetch2D_Auto202_g59696 = lerpResult176_g59696;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g59660 = Output_Fetch2D_Auto202_g59696;
					#else
					float4 staticSwitch1083_g59660 = tex2D( _RNMY1, UV12361_g59660 );
					#endif
					float3 appendResult149_g59685 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59685 = dot( appendResult149_g59685 , Normal_Map318_g59685 );
					float temp_output_2_0_g59686 = saturate( dotResult120_g59685 );
					float4 Input_FetchOffsets197_g59697 = temp_output_1_34_g59693;
					float2 Input_FetchWeights200_g59697 = temp_output_1_54_g59693;
					float2 break187_g59697 = Input_FetchWeights200_g59697;
					float4 lerpResult181_g59697 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g59697).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g59697).xw ) , break187_g59697.x);
					float4 lerpResult182_g59697 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g59697).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g59697).xz ) , break187_g59697.x);
					float4 lerpResult176_g59697 = lerp( lerpResult181_g59697 , lerpResult182_g59697 , break187_g59697.y);
					float4 Output_Fetch2D_Auto202_g59697 = lerpResult176_g59697;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g59660 = Output_Fetch2D_Auto202_g59697;
					#else
					float4 staticSwitch1084_g59660 = tex2D( _RNMZ1, UV12361_g59660 );
					#endif
					float4 RNM_11081_g59660 = ( ( ( ( temp_output_2_0_g59688 * temp_output_2_0_g59688 ) * staticSwitch1087_g59660 ) + ( ( temp_output_2_0_g59687 * temp_output_2_0_g59687 ) * staticSwitch1083_g59660 ) ) + ( ( temp_output_2_0_g59686 * temp_output_2_0_g59686 ) * staticSwitch1084_g59660 ) );
					float Lightmap_Lerp_Value969_g59660 = _LIGHTMAPLERP;
					float4 lerpResult953_g59660 = lerp( RNM_0926_g59660 , RNM_11081_g59660 , Lightmap_Lerp_Value969_g59660);
					float4 RNM_Lerp950_g59660 = lerpResult953_g59660;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g59660 = temp_cast_2;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g59660 = Lightmap_0925_g59660;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g59660 = Lightmap_Lerp932_g59660;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g59660 = RNM_0926_g59660;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g59660 = RNM_Lerp950_g59660;
					#else
					float4 staticSwitch1014_g59660 = temp_cast_2;
					#endif
					float4 Lightmap46_g59660 = staticSwitch1014_g59660;
					float3 ase_positionWS = IN.ase_texcoord3.xyz;
					float3 ase_viewVectorWS = ( _WorldSpaceCameraPos.xyz - ase_positionWS );
					float3 ase_viewDirWS = normalize( ase_viewVectorWS );
					float3 ase_tangentWS = IN.ase_texcoord4.xyz;
					float3 ase_normalWS = IN.ase_texcoord5.xyz;
					float3 ase_bitangentWS = IN.ase_texcoord6.xyz;
					float3 tanToWorld0 = float3( ase_tangentWS.x, ase_bitangentWS.x, ase_normalWS.x );
					float3 tanToWorld1 = float3( ase_tangentWS.y, ase_bitangentWS.y, ase_normalWS.y );
					float3 tanToWorld2 = float3( ase_tangentWS.z, ase_bitangentWS.z, ase_normalWS.z );
					float3 tanNormal1392_g59660 = Normal_Map700_g59660;
					float2 temp_output_5_0_g59678 = UV02420_g59660;
					float2 UV633_g59678 = temp_output_5_0_g59678;
					float2 UV100_g59679 = UV633_g59678;
					float2 temp_output_51_0_g59679 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59679 * float2( 3.464,3.464 ) ) );
					float2 break55_g59679 = frac( temp_output_51_0_g59679 );
					float temp_output_56_0_g59679 = ( ( 1.0 - break55_g59679.x ) - break55_g59679.y );
					float2 temp_output_52_0_g59679 = floor( temp_output_51_0_g59679 );
					float2 temp_output_125_0_g59679 = ( temp_output_52_0_g59679 + float2( 1,1 ) );
					float2 ifLocalVar87_g59679 = 0;
					if( temp_output_56_0_g59679 > 0.0 )
					ifLocalVar87_g59679 = temp_output_52_0_g59679;
					else if( temp_output_56_0_g59679 == 0.0 )
					ifLocalVar87_g59679 = temp_output_125_0_g59679;
					else if( temp_output_56_0_g59679 < 0.0 )
					ifLocalVar87_g59679 = temp_output_125_0_g59679;
					float3 temp_output_7_0_g59680 = frac( ( (ifLocalVar87_g59679).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59680 = dot( temp_output_7_0_g59680 , ( (temp_output_7_0_g59680).yzx + 33.33 ) );
					float3 temp_output_12_0_g59680 = ( temp_output_7_0_g59680 + dotResult8_g59680 );
					float2 temp_output_597_0_g59678 = ( UV100_g59679 + frac( ( ( (temp_output_12_0_g59680).xx + (temp_output_12_0_g59680).yz ) * (temp_output_12_0_g59680).zy ) ) );
					float2 DDX631_g59678 = ddx( temp_output_5_0_g59678 );
					float2 DDY632_g59678 = ddy( temp_output_5_0_g59678 );
					float temp_output_65_0_g59679 = ( 0.0 - temp_output_56_0_g59679 );
					float ifLocalVar59_g59679 = 0;
					if( temp_output_56_0_g59679 <= 0.0 )
					ifLocalVar59_g59679 = temp_output_65_0_g59679;
					else
					ifLocalVar59_g59679 = temp_output_56_0_g59679;
					float temp_output_597_30_g59678 = ifLocalVar59_g59679;
					float2 temp_output_90_0_g59679 = ( temp_output_52_0_g59679 + float2( 0,1 ) );
					float2 temp_output_123_0_g59679 = ( temp_output_52_0_g59679 + float2( 1,0 ) );
					float2 ifLocalVar88_g59679 = 0;
					if( temp_output_56_0_g59679 > 0.0 )
					ifLocalVar88_g59679 = temp_output_90_0_g59679;
					else if( temp_output_56_0_g59679 == 0.0 )
					ifLocalVar88_g59679 = temp_output_123_0_g59679;
					else if( temp_output_56_0_g59679 < 0.0 )
					ifLocalVar88_g59679 = temp_output_123_0_g59679;
					float3 temp_output_7_0_g59681 = frac( ( (ifLocalVar88_g59679).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59681 = dot( temp_output_7_0_g59681 , ( (temp_output_7_0_g59681).yzx + 33.33 ) );
					float3 temp_output_12_0_g59681 = ( temp_output_7_0_g59681 + dotResult8_g59681 );
					float2 temp_output_597_26_g59678 = ( UV100_g59679 + frac( ( ( (temp_output_12_0_g59681).xx + (temp_output_12_0_g59681).yz ) * (temp_output_12_0_g59681).zy ) ) );
					float temp_output_66_0_g59679 = ( 1.0 - break55_g59679.y );
					float ifLocalVar60_g59679 = 0;
					if( temp_output_56_0_g59679 <= 0.0 )
					ifLocalVar60_g59679 = temp_output_66_0_g59679;
					else
					ifLocalVar60_g59679 = break55_g59679.y;
					float temp_output_597_28_g59678 = ifLocalVar60_g59679;
					float2 ifLocalVar89_g59679 = 0;
					if( temp_output_56_0_g59679 > 0.0 )
					ifLocalVar89_g59679 = temp_output_123_0_g59679;
					else if( temp_output_56_0_g59679 == 0.0 )
					ifLocalVar89_g59679 = temp_output_90_0_g59679;
					else if( temp_output_56_0_g59679 < 0.0 )
					ifLocalVar89_g59679 = temp_output_90_0_g59679;
					float3 temp_output_7_0_g59682 = frac( ( (ifLocalVar89_g59679).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59682 = dot( temp_output_7_0_g59682 , ( (temp_output_7_0_g59682).yzx + 33.33 ) );
					float3 temp_output_12_0_g59682 = ( temp_output_7_0_g59682 + dotResult8_g59682 );
					float2 temp_output_597_27_g59678 = ( UV100_g59679 + frac( ( ( (temp_output_12_0_g59682).xx + (temp_output_12_0_g59682).yz ) * (temp_output_12_0_g59682).zy ) ) );
					float temp_output_67_0_g59679 = ( 1.0 - break55_g59679.x );
					float ifLocalVar61_g59679 = 0;
					if( temp_output_56_0_g59679 <= 0.0 )
					ifLocalVar61_g59679 = temp_output_67_0_g59679;
					else
					ifLocalVar61_g59679 = break55_g59679.x;
					float temp_output_597_29_g59678 = ifLocalVar61_g59679;
					float4 Output_2D293_g59678 = ( ( tex2D( _GlossinessMap, temp_output_597_0_g59678, DDX631_g59678, DDY632_g59678 ) * temp_output_597_30_g59678 ) + ( tex2D( _GlossinessMap, temp_output_597_26_g59678, DDX631_g59678, DDY632_g59678 ) * temp_output_597_28_g59678 ) + ( tex2D( _GlossinessMap, temp_output_597_27_g59678, DDX631_g59678, DDY632_g59678 ) * temp_output_597_29_g59678 ) );
					float4 break31_g59678 = Output_2D293_g59678;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g59660 = break31_g59678.a;
					#else
					float staticSwitch1004_g59660 = tex2D( _GlossinessMap, UV02420_g59660 ).r;
					#endif
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g59660 = ( 1.0 - staticSwitch1004_g59660 );
					#else
					float staticSwitch845_g59660 = _Glossiness;
					#endif
					float3 temp_output_3_0_g59671 = ddx( ase_normalWS );
					float dotResult5_g59671 = dot( temp_output_3_0_g59671 , temp_output_3_0_g59671 );
					float3 temp_output_4_0_g59671 = ddy( ase_normalWS );
					float dotResult6_g59671 = dot( temp_output_4_0_g59671 , temp_output_4_0_g59671 );
					#ifdef _USEGEOMETRICANTIALIASING_ON
					float staticSwitch824_g59660 = min( staticSwitch845_g59660, ( 1.0 - pow( saturate( max( dotResult5_g59671, dotResult6_g59671 ) ) , 0.333 ) ) );
					#else
					float staticSwitch824_g59660 = staticSwitch845_g59660;
					#endif
					float Smoothness1399_g59660 = staticSwitch824_g59660;
					UnityGIInput data;
					UNITY_INITIALIZE_OUTPUT( UnityGIInput, data );
					data.worldPos = ase_positionWS;
					data.worldViewDir = ase_viewDirWS;
					data.probeHDR[0] = unity_SpecCube0_HDR;
					data.probeHDR[1] = unity_SpecCube1_HDR;
					#if UNITY_SPECCUBE_BLENDING || UNITY_SPECCUBE_BOX_PROJECTION //specdataif0
					data.boxMin[0] = unity_SpecCube0_BoxMin;
					#endif //specdataif0
					#if UNITY_SPECCUBE_BOX_PROJECTION //specdataif1
					data.boxMax[0] = unity_SpecCube0_BoxMax;
					data.probePosition[0] = unity_SpecCube0_ProbePosition;
					data.boxMax[1] = unity_SpecCube1_BoxMax;
					data.boxMin[1] = unity_SpecCube1_BoxMin;
					data.probePosition[1] = unity_SpecCube1_ProbePosition;
					#endif //specdataif1
					Unity_GlossyEnvironmentData g1392_g59660 = UnityGlossyEnvironmentSetup( Smoothness1399_g59660, ase_viewDirWS, float3( dot( tanToWorld0, tanNormal1392_g59660 ), dot( tanToWorld1, tanNormal1392_g59660 ), dot( tanToWorld2, tanNormal1392_g59660 ) ), float3(0,0,0));
					float3 indirectSpecular1392_g59660 = UnityGI_IndirectSpecular( data, 1.0, float3( dot( tanToWorld0, tanNormal1392_g59660 ), dot( tanToWorld1, tanNormal1392_g59660 ), dot( tanToWorld2, tanNormal1392_g59660 ) ), g1392_g59660 );
					float4 temp_cast_4 = (0.04).xxxx;
					float4 lerpResult1473_g59660 = lerp( temp_cast_4 , oAlbedo6_g59660 , Metallic1239_g59660);
					float3 switchResult1501_g59660 = (((ase_vface>0)?(ase_normalWS):(-ase_normalWS)));
					float dotResult1476_g59660 = dot( switchResult1501_g59660 , ase_viewDirWS );
					float4 lerpResult1480_g59660 = lerp( lerpResult1473_g59660 , float4( 1,1,1,0 ) , pow( ( 1.0 - saturate( dotResult1476_g59660 ) ) , 5.0 ));
					float4 Fresnel1560_g59660 = lerpResult1480_g59660;
					float4 temp_output_1481_0_g59660 = ( float4( indirectSpecular1392_g59660 , 0.0 ) * Fresnel1560_g59660 );
					#ifdef _USELIGHTMAPSPECULAR_ON
					float4 staticSwitch1469_g59660 = ( temp_output_1481_0_g59660 * sqrt( Lightmap46_g59660 ) );
					#else
					float4 staticSwitch1469_g59660 = temp_output_1481_0_g59660;
					#endif
					float4 Specular1419_g59660 = staticSwitch1469_g59660;
					float4 temp_cast_5 = (Black1185_g59660).xxxx;
					float2 temp_output_5_0_g59672 = UV02420_g59660;
					float2 UV633_g59672 = temp_output_5_0_g59672;
					float2 UV100_g59673 = UV633_g59672;
					float2 temp_output_51_0_g59673 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59673 * float2( 3.464,3.464 ) ) );
					float2 break55_g59673 = frac( temp_output_51_0_g59673 );
					float temp_output_56_0_g59673 = ( ( 1.0 - break55_g59673.x ) - break55_g59673.y );
					float2 temp_output_52_0_g59673 = floor( temp_output_51_0_g59673 );
					float2 temp_output_125_0_g59673 = ( temp_output_52_0_g59673 + float2( 1,1 ) );
					float2 ifLocalVar87_g59673 = 0;
					if( temp_output_56_0_g59673 > 0.0 )
					ifLocalVar87_g59673 = temp_output_52_0_g59673;
					else if( temp_output_56_0_g59673 == 0.0 )
					ifLocalVar87_g59673 = temp_output_125_0_g59673;
					else if( temp_output_56_0_g59673 < 0.0 )
					ifLocalVar87_g59673 = temp_output_125_0_g59673;
					float3 temp_output_7_0_g59674 = frac( ( (ifLocalVar87_g59673).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59674 = dot( temp_output_7_0_g59674 , ( (temp_output_7_0_g59674).yzx + 33.33 ) );
					float3 temp_output_12_0_g59674 = ( temp_output_7_0_g59674 + dotResult8_g59674 );
					float2 temp_output_597_0_g59672 = ( UV100_g59673 + frac( ( ( (temp_output_12_0_g59674).xx + (temp_output_12_0_g59674).yz ) * (temp_output_12_0_g59674).zy ) ) );
					float2 DDX631_g59672 = ddx( temp_output_5_0_g59672 );
					float2 DDY632_g59672 = ddy( temp_output_5_0_g59672 );
					float temp_output_65_0_g59673 = ( 0.0 - temp_output_56_0_g59673 );
					float ifLocalVar59_g59673 = 0;
					if( temp_output_56_0_g59673 <= 0.0 )
					ifLocalVar59_g59673 = temp_output_65_0_g59673;
					else
					ifLocalVar59_g59673 = temp_output_56_0_g59673;
					float temp_output_597_30_g59672 = ifLocalVar59_g59673;
					float2 temp_output_90_0_g59673 = ( temp_output_52_0_g59673 + float2( 0,1 ) );
					float2 temp_output_123_0_g59673 = ( temp_output_52_0_g59673 + float2( 1,0 ) );
					float2 ifLocalVar88_g59673 = 0;
					if( temp_output_56_0_g59673 > 0.0 )
					ifLocalVar88_g59673 = temp_output_90_0_g59673;
					else if( temp_output_56_0_g59673 == 0.0 )
					ifLocalVar88_g59673 = temp_output_123_0_g59673;
					else if( temp_output_56_0_g59673 < 0.0 )
					ifLocalVar88_g59673 = temp_output_123_0_g59673;
					float3 temp_output_7_0_g59675 = frac( ( (ifLocalVar88_g59673).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59675 = dot( temp_output_7_0_g59675 , ( (temp_output_7_0_g59675).yzx + 33.33 ) );
					float3 temp_output_12_0_g59675 = ( temp_output_7_0_g59675 + dotResult8_g59675 );
					float2 temp_output_597_26_g59672 = ( UV100_g59673 + frac( ( ( (temp_output_12_0_g59675).xx + (temp_output_12_0_g59675).yz ) * (temp_output_12_0_g59675).zy ) ) );
					float temp_output_66_0_g59673 = ( 1.0 - break55_g59673.y );
					float ifLocalVar60_g59673 = 0;
					if( temp_output_56_0_g59673 <= 0.0 )
					ifLocalVar60_g59673 = temp_output_66_0_g59673;
					else
					ifLocalVar60_g59673 = break55_g59673.y;
					float temp_output_597_28_g59672 = ifLocalVar60_g59673;
					float2 ifLocalVar89_g59673 = 0;
					if( temp_output_56_0_g59673 > 0.0 )
					ifLocalVar89_g59673 = temp_output_123_0_g59673;
					else if( temp_output_56_0_g59673 == 0.0 )
					ifLocalVar89_g59673 = temp_output_90_0_g59673;
					else if( temp_output_56_0_g59673 < 0.0 )
					ifLocalVar89_g59673 = temp_output_90_0_g59673;
					float3 temp_output_7_0_g59676 = frac( ( (ifLocalVar89_g59673).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59676 = dot( temp_output_7_0_g59676 , ( (temp_output_7_0_g59676).yzx + 33.33 ) );
					float3 temp_output_12_0_g59676 = ( temp_output_7_0_g59676 + dotResult8_g59676 );
					float2 temp_output_597_27_g59672 = ( UV100_g59673 + frac( ( ( (temp_output_12_0_g59676).xx + (temp_output_12_0_g59676).yz ) * (temp_output_12_0_g59676).zy ) ) );
					float temp_output_67_0_g59673 = ( 1.0 - break55_g59673.x );
					float ifLocalVar61_g59673 = 0;
					if( temp_output_56_0_g59673 <= 0.0 )
					ifLocalVar61_g59673 = temp_output_67_0_g59673;
					else
					ifLocalVar61_g59673 = break55_g59673.x;
					float temp_output_597_29_g59672 = ifLocalVar61_g59673;
					float4 Output_2D293_g59672 = ( ( tex2D( _EmissionMap, temp_output_597_0_g59672, DDX631_g59672, DDY632_g59672 ) * temp_output_597_30_g59672 ) + ( tex2D( _EmissionMap, temp_output_597_26_g59672, DDX631_g59672, DDY632_g59672 ) * temp_output_597_28_g59672 ) + ( tex2D( _EmissionMap, temp_output_597_27_g59672, DDX631_g59672, DDY632_g59672 ) * temp_output_597_29_g59672 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g59660 = Output_2D293_g59672;
					#else
					float4 staticSwitch1006_g59660 = tex2D( _EmissionMap, UV02420_g59660 );
					#endif
					#if defined( _SPECIALEFFECTS_DISABLED )
					float4 staticSwitch1578_g59660 = staticSwitch1006_g59660;
					#elif defined( _SPECIALEFFECTS_LED )
					float4 staticSwitch1578_g59660 = float4( 0,0,0,0 );
					#else
					float4 staticSwitch1578_g59660 = staticSwitch1006_g59660;
					#endif
					#ifdef _EMISSIONENABLED_ON
					float4 staticSwitch1017_g59660 = ( float4( _EmissionColor , 0.0 ) * staticSwitch1578_g59660 * _EmissionIntensity );
					#else
					float4 staticSwitch1017_g59660 = temp_cast_5;
					#endif
					float4 Emission86_g59660 = staticSwitch1017_g59660;
					float3 WorldPos97_g59712 = ase_positionWS;
					float3 tanNormal85_g59712 = Normal_Map700_g59660;
					float3 worldNormal85_g59712 = float3( dot( tanToWorld0, tanNormal85_g59712 ), dot( tanToWorld1, tanNormal85_g59712 ), dot( tanToWorld2, tanNormal85_g59712 ) );
					float3 WorldNormal97_g59712 = worldNormal85_g59712;
					float Smoothness97_g59712 = Smoothness1399_g59660;
					float3 LightmapColor97_g59712 = Lightmap46_g59660.rgb;
					float3 ViewDir97_g59712 = ase_viewDirWS;
					float3 localSpecular97_g59712 = Specular( WorldPos97_g59712 , WorldNormal97_g59712 , Smoothness97_g59712 , LightmapColor97_g59712 , ViewDir97_g59712 );
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1181_g59660 = Lightmap46_g59660;
					#else
					float4 staticSwitch1181_g59660 = ( ( aAlbedo1466_g59660 * Lightmap46_g59660 ) + Specular1419_g59660 + Emission86_g59660 + float4( localSpecular97_g59712 , 0.0 ) );
					#endif
					float4 temp_output_35_0_g59683 = staticSwitch1181_g59660;
					float4 Color353_g59683 = temp_output_35_0_g59683;
					#if defined( _LUTMODE_2D )
					float4 staticSwitch273_g59683 = saturate( temp_output_35_0_g59683 );
					#elif defined( _LUTMODE_3D )
					float4 staticSwitch273_g59683 = temp_output_35_0_g59683;
					#else
					float4 staticSwitch273_g59683 = temp_output_35_0_g59683;
					#endif
					float4 Color_Saturate49_g59683 = staticSwitch273_g59683;
					float Lut_Height213_g59683 = _LUTSize;
					float Lut_Width216_g59683 = ( _LUTSize * Lut_Height213_g59683 );
					float3 appendResult214_g59683 = (float3(( 1.0 / Lut_Width216_g59683 ) , ( 1.0 / Lut_Height213_g59683 ) , ( Lut_Height213_g59683 - 1.0 )));
					float3 Scale_Offset208_g59683 = appendResult214_g59683;
					float2 Scale_Factor292_g59683 = ( (Scale_Offset208_g59683).xy * (Scale_Offset208_g59683).z );
					float2 Offset299_g59683 = ( (Scale_Offset208_g59683).xy * 0.5 );
					float3 Adjusted_UV305_g59683 = ( ( (Color_Saturate49_g59683).xyw * float3( Scale_Factor292_g59683 ,  0.0 ) ) + float3( Offset299_g59683 ,  0.0 ) );
					float2 Scaled_Blue280_g59683 = ( (Color_Saturate49_g59683).zw * (Scale_Offset208_g59683).z );
					float2 Shift288_g59683 = floor( Scaled_Blue280_g59683 );
					float2 Final_X313_g59683 = ( (Adjusted_UV305_g59683).xz + ( Shift288_g59683 * (Scale_Offset208_g59683).y ) );
					float2 appendResult326_g59683 = (float2(Final_X313_g59683));
					float2 Final_UV325_g59683 = appendResult326_g59683;
					float2 appendResult338_g59683 = (float2((Scale_Offset208_g59683).y , 0.0));
					float2 Offset_UV336_g59683 = ( Final_UV325_g59683 + appendResult338_g59683 );
					float3 lerpResult333_g59683 = lerp( tex2D( _2DLut, Final_UV325_g59683 ).rgb , tex2D( _2DLut, Offset_UV336_g59683 ).rgb , float3( ( Scaled_Blue280_g59683 - Shift288_g59683 ) ,  0.0 ));
					#ifdef _2DLUT
					float4 staticSwitch347_g59683 = float4( lerpResult333_g59683 , 0.0 );
					#else
					float4 staticSwitch347_g59683 = Color_Saturate49_g59683;
					#endif
					float4 TwoD_LUT346_g59683 = staticSwitch347_g59683;
					float3 RGB16_g59684 = ( ( log10( ( ( Color_Saturate49_g59683.xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 );
					#ifdef _3DLUT
					float4 staticSwitch194_g59683 = tex3D( _3DLut, RGB16_g59684 );
					#else
					float4 staticSwitch194_g59683 = Color_Saturate49_g59683;
					#endif
					float4 ThreeD_LUT51_g59683 = staticSwitch194_g59683;
					#if defined( _LUTMODE_2D )
					float4 staticSwitch42_g59683 = TwoD_LUT346_g59683;
					#elif defined( _LUTMODE_3D )
					float4 staticSwitch42_g59683 = ThreeD_LUT51_g59683;
					#else
					float4 staticSwitch42_g59683 = ThreeD_LUT51_g59683;
					#endif
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch41_g59683 = staticSwitch42_g59683;
					#else
					float4 staticSwitch41_g59683 = Color353_g59683;
					#endif
					float3 worldPos8_g59713 = ase_positionWS;
					float3 worldNormal8_g59713 = ase_normalWS;
					float3 viewDir8_g59713 = ase_viewDirWS;
					float _Steps8_g59713 = 50.0;
					float _StepSize8_g59713 = 0.5;
					float _Thickness8_g59713 = 0.02;
					float _Jitter8_g59713 = 0.5;
					float4 localMyCustomExpression8_g59713 = MyCustomExpression8_g59713( worldPos8_g59713 , worldNormal8_g59713 , viewDir8_g59713 , _Steps8_g59713 , _StepSize8_g59713 , _Thickness8_g59713 , _Jitter8_g59713 );
					float4 screenColor33_g59713 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,(localMyCustomExpression8_g59713).xy);
					float4 lerpResult45_g59713 = lerp( float4( staticSwitch41_g59683.xyz , 0.0 ) , screenColor33_g59713 , (localMyCustomExpression8_g59713).w);
					

					o.Albedo = staticSwitch1180_g59660.rgb;
					o.Normal = half3( 0, 0, 1 );
					o.Emission = lerpResult45_g59713.rgb;
					o.Alpha = 1;
					half AlphaClipThreshold = 0.5;

					#ifdef _ALPHATEST_ON
						clip( o.Alpha - AlphaClipThreshold );
					#endif

					UnityMetaInput metaIN;
					UNITY_INITIALIZE_OUTPUT(UnityMetaInput, metaIN);
					metaIN.Albedo = o.Albedo;
					metaIN.Emission = o.Emission;
					#ifdef EDITOR_VISUALIZATION
						metaIN.VizUV = IN.vizUV;
						metaIN.LightCoord = IN.lightCoord;
					#endif
					return UnityMetaFragment(metaIN);
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
				#define ASE_LIGHTING_SIMPLE 1
				#define _SPECULARHIGHLIGHTS_OFF
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
				UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
				uniform float4 _UdonSpecularLightUp[32];
				uniform float4 _UdonSpecularLightRight[32];
				uniform float4 _UdonSpecularLightCol[32];
				uniform float4 _UdonSpecularLightPos[32];


				
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
				#define ASE_FOG
				#define ASE_LIGHTING_SIMPLE 1
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
				UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
				uniform float4 _UdonSpecularLightUp[32];
				uniform float4 _UdonSpecularLightRight[32];
				uniform float4 _UdonSpecularLightCol[32];
				uniform float4 _UdonSpecularLightPos[32];


				
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
				#define ASE_FOG
				#define ASE_LIGHTING_SIMPLE 1
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
				UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
				uniform float4 _UdonSpecularLightUp[32];
				uniform float4 _UdonSpecularLightRight[32];
				uniform float4 _UdonSpecularLightCol[32];
				uniform float4 _UdonSpecularLightPos[32];


				
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
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;53;-720,544;Inherit;False;Property;_roughness;roughness;49;0;Create;True;0;0;0;False;0;False;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;12;-560,-48;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ViewDirInputsCoordNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2;-560,112;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3;-560,256;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;127;16,48;Inherit;False;SSR;47;;59713;8bccd81f365a34d69ad5e7e83377c6e1;0;7;44;FLOAT3;0,0,0;False;21;FLOAT3;0.02,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;6;FLOAT;50;False;7;FLOAT;0.02;False;31;FLOAT;0.5;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;125;-592,-224;Inherit;False;Meenphie;0;;59660;b3ba55a08dd6b49c7be16c6f35cf2033;1,1008,0;0;5;COLOR;625;FLOAT4;624;FLOAT;156;FLOAT;427;FLOAT3;1024
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;30;320,0;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;5;SSR;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardBase;0;1;ForwardBase;17;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;44;Category;0;0;  Instanced Terrain Normals;1;0;Workflow;3;639079774250446720;Surface;0;639079823605396220;  Blend;0;0;  Dither Shadows;1;639079823204246840;Two Sided;1;0;Alpha Clipping;0;0;  Use Shadow Threshold;0;0;Deferred Pass;0;639079823215068570;Normal Space;0;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;1;0;Receive Shadows;1;0;Receive Specular;0;639079775807888620;Receive Reflections;0;639079775816023110;GPU Instancing;1;0;LOD CrossFade;1;0;Built-in Fog;1;0;Ambient Light;1;0;Meta Pass;1;0;Add Pass;1;0;Override Baked GI;0;0;Write Depth;0;639079830770414430;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;0;Vertex Position;1;0;0;8;False;True;True;False;True;True;True;True;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;29;-288,48;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;31;0,0;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;True;1;LightMode=ForwardAdd;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;32;0,0;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;33;0,0;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;34;0,0;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;35;0,0;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;36;0,0;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ScenePickingPass;0;7;ScenePickingPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=Picking;False;False;0;;0;0;Standard;0;False;0
WireConnection;127;44;125;624
WireConnection;127;21;12;0
WireConnection;127;2;2;0
WireConnection;127;3;3;0
WireConnection;30;0;125;625
WireConnection;30;2;127;0
ASEEND*/
//CHKSM=B298608BE4709C9B913103EB030AEBB0D3376CD3