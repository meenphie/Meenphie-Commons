// Made with Amplify Shader Editor v1.9.9.7
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
		

		

		Tags { "RenderType"="Transparent" "Queue"="Transparent+1" "DisableBatching"="False" }

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
				sampler2D _Sampler82966_g60114;
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				sampler2D _Sampler82967_g60114;
				uniform sampler2D _Lightmap0;
				float4 _Lightmap0_TexelSize;
				uniform sampler2D _Lightmap1;
				float4 _Lightmap1_TexelSize;
				uniform float _UdonLightmapLerp;
				uniform sampler2D _BumpMap;
				sampler2D _Sampler82965_g60114;
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
				sampler2D _Sampler82968_g60114;
				uniform float _EmissionIntensity;
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				sampler2D _Sampler82964_g60114;
				uniform float _IOR;


				float3 IndirectSpecular1_g60165( float3 Color, float Metallic, float Smoothness, float IOR, float3 Fresnel, float3 WorldPos, float3 WorldNormal, float3 ViewDir )
				{
					// --- 0. PARAMETERS ---
					float maxMip = 6.0;
					// --- 1. VECTORS ---
					float3 N = normalize(WorldNormal);
					float3 V = normalize(ViewDir);
					float3 R = reflect(-V, N);
					float nDotV = saturate(dot(N, V));
					// --- 2. BOX PROJECTION ---
					float3 ray = R;
					[branch]
					if (unity_SpecCube0_ProbePosition.w > 0.0)
					{
					    float3 safeRay = max(abs(ray), 1e-5) * sign(ray);
					    float3 rbMax = (unity_SpecCube0_BoxMax.xyz - WorldPos) / safeRay;
					    float3 rbMin = (unity_SpecCube0_BoxMin.xyz - WorldPos) / safeRay;
					    float3 rbMinMax = (ray > 0) ? rbMax : rbMin;
					    float fa = min(min(rbMinMax.x, rbMinMax.y), rbMinMax.z);
					    ray = ray * fa + (WorldPos - unity_SpecCube0_ProbePosition.xyz);
					}
					// --- 3. F0 (IOR-BASED) ---
					float iorTerm = (IOR - 1.0) / (IOR + 1.0);
					float f0_base = iorTerm * iorTerm;
					float3 F0 = lerp(f0_base.xxx, Color.rgb, Metallic);
					// --- 4. ROUGHNESS & SIGMOID CURVE ---
					float perceptualRoughness = 1.0 - Smoothness;
					// Transition brutale à l'horizon (0.1)
					float angleThreshold = smoothstep(0.0, 0.1, nDotV);
					float mipLevel = clamp(perceptualRoughness * angleThreshold * maxMip, 0.0, maxMip);
					// --- 5. FRESNEL PBR ---
					// On garde la compensation de rugosité pour éviter l'aliasing sur les bords
					float3 F = F0 + (max(Smoothness.xxx, F0) - F0) * pow(1.0 - nDotV, 5.0);
					// --- 6. SAMPLING ---
					float4 sampleCube = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, ray, mipLevel);
					float3 indirectSpec = DecodeHDR(sampleCube, unity_SpecCube0_HDR);
					return indirectSpec * F;
				}
				
				float3 DirectSpecular( float3 Color, float3 LightmapColor, float Metallic, float Smoothness, float IOR, float3 WorldPos, float3 WorldNormal, float3 ViewDir )
				{
					// --- CONFIGURATION ---
					float lumaStart = 0.05;
					float lumaEnd = 0.5;
					static const float PI_INV_8 = 0.0397887;
					#if defined(SHADER_API_MOBILE)
					static const float distStart = 4.0;
					static const float distEnd = 8.0;
					#else
					static const float distStart = 8.0;
					static const float distEnd = 16.0;
					#endif
					static const float fadeStartSq = distStart * distStart;
					static const float maxRadiusSq = distEnd * distEnd;
					// --- INITIALISATION ---
					float3 N = normalize(WorldNormal);
					float3 vDir = normalize(ViewDir);
					float3 R = reflect(-vDir, N);
					float3 F0 = lerp(float3(0.04, 0.04, 0.04), Color.rgb, Metallic);
					// --- MASQUES ---
					float luma = dot(LightmapColor, float3(0.2126, 0.7152, 0.0722));
					float lmMask = saturate((luma - lumaStart) / max(lumaEnd - lumaStart, 1e-4));
					// --- EARLY EXIT ---
					if (lmMask * Smoothness < 0.001 || _UdonSpecularLightCount == 0) return 0;
					// --- MATHS SPÉCULAIRES ---
					float shininess = exp2(10.0 * Smoothness + 1.0);
					float normalization = (shininess + 8.0) * PI_INV_8;
					float3 specAccum = 0;
					// --- BOUCLE DE LUMIÈRES ---
					for (int i = 0; i < (int)_UdonSpecularLightCount; i++) {
					    float4 posRange = _UdonSpecularLightPos[i];
					    float3 L_center = posRange.xyz - WorldPos;
					    float distSqCenter = dot(L_center, L_center);
					    float rangeSq = posRange.w * posRange.w;
					    if (distSqCenter > rangeSq) continue;
					    // Fade par lumière (distance tête → lumière, cohérent avec le culling C#)
					    float3 toCam = _WorldSpaceCameraPos - posRange.xyz;
					    float dist = sqrt(dot(toCam, toCam));
					    float t = saturate((dist - distStart) / max(distEnd - distStart, 1e-4));
					    float it = 1.0 - t;
					    float radiusFade = it * it * it;
					    if (radiusFade <= 0.0) continue;
					    float4 dirAngle = _UdonSpecularLightDir[i];
					    float3 L_center_norm = L_center * rsqrt(distSqCenter + 1e-5);
					    float spotMask = saturate((dot(-L_center_norm, dirAngle.xyz) - dirAngle.w) / max(0.01, 1.0 - dirAngle.w));
					    if (spotMask <= 0.0) continue;
					    float3 diff;
					    [branch]
					    if (dirAngle.w < -0.9) {
					        diff = L_center;
					    }
					    else {
					        float denom = dot(dirAngle.xyz, R);
					        float tPlane = dot(L_center, dirAngle.xyz) / (abs(denom) < 1e-3 ? 1e-3 : denom);
					        if (tPlane <= 0.0) continue;
					        float3 pReflection = WorldPos + R * tPlane;
					        float3 localP = pReflection - posRange.xyz;
					        float2 halfSize = float2(_UdonSpecularLightRight[i].w, _UdonSpecularLightUp[i].w);
					        float2 clampedPos = clamp(
					            float2(dot(localP, _UdonSpecularLightRight[i].xyz), dot(localP, _UdonSpecularLightUp[i].xyz)),
					            -halfSize, halfSize);
					        diff = (posRange.xyz + _UdonSpecularLightRight[i].xyz * clampedPos.x + _UdonSpecularLightUp[i].xyz * clampedPos.y) - WorldPos;
					    }
					    float dSq = dot(diff, diff);
					    float3 lDir = diff * rsqrt(dSq + 1e-5);
					    float3 H = normalize(lDir + vDir);
					    // Fresnel Schlick
					    float f_inv = 1.0 - saturate(dot(H, vDir));
					    float f2 = f_inv * f_inv;
					    float3 fresnel = F0 + (1.0 - F0) * f2 * f2 * f_inv;
					    float nDotH = saturate(dot(N, H));
					    float nDotL = saturate(dot(N, lDir));
					    float spec = exp2(shininess * nDotH - shininess) * normalization;
					    float falloff = saturate(1.0 - distSqCenter / rangeSq);
					    falloff = (falloff * falloff) / (dSq + 1.0);
					    specAccum += _UdonSpecularLightCol[i].rgb * (spec * fresnel * nDotL * _UdonSpecularLightCol[i].w * falloff * spotMask * radiusFade);
					}
					return specAccum * lmMask;
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

					float2 texCoord2357_g60114 = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0A2420_g60114 = texCoord2357_g60114;
					#ifdef _MAINTEX
					float4 staticSwitch1549_g60114 = tex2D( _MainTex, UV0A2420_g60114 );
					#else
					float4 staticSwitch1549_g60114 = _Color;
					#endif
					float2 temp_output_5_0_g60140 = UV0A2420_g60114;
					float2 UV633_g60140 = temp_output_5_0_g60140;
					float2 UV100_g60141 = UV633_g60140;
					float2 temp_output_51_0_g60141 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60141 * float2( 3.464,3.464 ) ) );
					float2 break55_g60141 = frac( temp_output_51_0_g60141 );
					float temp_output_56_0_g60141 = ( ( 1.0 - break55_g60141.x ) - break55_g60141.y );
					float2 temp_output_52_0_g60141 = floor( temp_output_51_0_g60141 );
					float2 temp_output_125_0_g60141 = ( temp_output_52_0_g60141 + float2( 1,1 ) );
					float2 ifLocalVar87_g60141 = 0;
					if( temp_output_56_0_g60141 > 0.0 )
					ifLocalVar87_g60141 = temp_output_52_0_g60141;
					else if( temp_output_56_0_g60141 == 0.0 )
					ifLocalVar87_g60141 = temp_output_125_0_g60141;
					else if( temp_output_56_0_g60141 < 0.0 )
					ifLocalVar87_g60141 = temp_output_125_0_g60141;
					float3 temp_output_7_0_g60142 = frac( ( (ifLocalVar87_g60141).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60142 = dot( temp_output_7_0_g60142 , ( (temp_output_7_0_g60142).yzx + 33.33 ) );
					float3 temp_output_12_0_g60142 = ( temp_output_7_0_g60142 + dotResult8_g60142 );
					float2 temp_output_597_0_g60140 = ( UV100_g60141 + frac( ( ( (temp_output_12_0_g60142).xx + (temp_output_12_0_g60142).yz ) * (temp_output_12_0_g60142).zy ) ) );
					float2 DDX631_g60140 = ddx( temp_output_5_0_g60140 );
					float2 DDY632_g60140 = ddy( temp_output_5_0_g60140 );
					float temp_output_65_0_g60141 = ( 0.0 - temp_output_56_0_g60141 );
					float ifLocalVar59_g60141 = 0;
					if( temp_output_56_0_g60141 <= 0.0 )
					ifLocalVar59_g60141 = temp_output_65_0_g60141;
					else
					ifLocalVar59_g60141 = temp_output_56_0_g60141;
					float temp_output_597_30_g60140 = ifLocalVar59_g60141;
					float2 temp_output_90_0_g60141 = ( temp_output_52_0_g60141 + float2( 0,1 ) );
					float2 temp_output_123_0_g60141 = ( temp_output_52_0_g60141 + float2( 1,0 ) );
					float2 ifLocalVar88_g60141 = 0;
					if( temp_output_56_0_g60141 > 0.0 )
					ifLocalVar88_g60141 = temp_output_90_0_g60141;
					else if( temp_output_56_0_g60141 == 0.0 )
					ifLocalVar88_g60141 = temp_output_123_0_g60141;
					else if( temp_output_56_0_g60141 < 0.0 )
					ifLocalVar88_g60141 = temp_output_123_0_g60141;
					float3 temp_output_7_0_g60143 = frac( ( (ifLocalVar88_g60141).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60143 = dot( temp_output_7_0_g60143 , ( (temp_output_7_0_g60143).yzx + 33.33 ) );
					float3 temp_output_12_0_g60143 = ( temp_output_7_0_g60143 + dotResult8_g60143 );
					float2 temp_output_597_26_g60140 = ( UV100_g60141 + frac( ( ( (temp_output_12_0_g60143).xx + (temp_output_12_0_g60143).yz ) * (temp_output_12_0_g60143).zy ) ) );
					float temp_output_66_0_g60141 = ( 1.0 - break55_g60141.y );
					float ifLocalVar60_g60141 = 0;
					if( temp_output_56_0_g60141 <= 0.0 )
					ifLocalVar60_g60141 = temp_output_66_0_g60141;
					else
					ifLocalVar60_g60141 = break55_g60141.y;
					float temp_output_597_28_g60140 = ifLocalVar60_g60141;
					float2 ifLocalVar89_g60141 = 0;
					if( temp_output_56_0_g60141 > 0.0 )
					ifLocalVar89_g60141 = temp_output_123_0_g60141;
					else if( temp_output_56_0_g60141 == 0.0 )
					ifLocalVar89_g60141 = temp_output_90_0_g60141;
					else if( temp_output_56_0_g60141 < 0.0 )
					ifLocalVar89_g60141 = temp_output_90_0_g60141;
					float3 temp_output_7_0_g60144 = frac( ( (ifLocalVar89_g60141).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60144 = dot( temp_output_7_0_g60144 , ( (temp_output_7_0_g60144).yzx + 33.33 ) );
					float3 temp_output_12_0_g60144 = ( temp_output_7_0_g60144 + dotResult8_g60144 );
					float2 temp_output_597_27_g60140 = ( UV100_g60141 + frac( ( ( (temp_output_12_0_g60144).xx + (temp_output_12_0_g60144).yz ) * (temp_output_12_0_g60144).zy ) ) );
					float temp_output_67_0_g60141 = ( 1.0 - break55_g60141.x );
					float ifLocalVar61_g60141 = 0;
					if( temp_output_56_0_g60141 <= 0.0 )
					ifLocalVar61_g60141 = temp_output_67_0_g60141;
					else
					ifLocalVar61_g60141 = break55_g60141.x;
					float temp_output_597_29_g60140 = ifLocalVar61_g60141;
					float4 Output_2D293_g60140 = ( ( tex2D( _Sampler82966_g60114, temp_output_597_0_g60140, DDX631_g60140, DDY632_g60140 ) * temp_output_597_30_g60140 ) + ( tex2D( _Sampler82966_g60114, temp_output_597_26_g60140, DDX631_g60140, DDY632_g60140 ) * temp_output_597_28_g60140 ) + ( tex2D( _Sampler82966_g60114, temp_output_597_27_g60140, DDX631_g60140, DDY632_g60140 ) * temp_output_597_29_g60140 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g60114 = Output_2D293_g60140;
					#else
					float4 staticSwitch1001_g60114 = staticSwitch1549_g60114;
					#endif
					float3 temp_output_2532_0_g60114 = (staticSwitch1001_g60114).rgb;
					float3 oAlbedo6_g60114 = temp_output_2532_0_g60114;
					float Black1185_g60114 = 0.0;
					float3 temp_cast_0 = (Black1185_g60114).xxx;
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch1180_g60114 = temp_cast_0;
					#else
					float3 staticSwitch1180_g60114 = oAlbedo6_g60114;
					#endif
					
					#ifdef _METALLICMAP
					float staticSwitch846_g60114 = tex2D( _MetallicMap, UV0A2420_g60114 ).r;
					#else
					float staticSwitch846_g60114 = _Metallic;
					#endif
					float2 temp_output_5_0_g60135 = UV0A2420_g60114;
					float2 UV633_g60135 = temp_output_5_0_g60135;
					float2 UV100_g60136 = UV633_g60135;
					float2 temp_output_51_0_g60136 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60136 * float2( 3.464,3.464 ) ) );
					float2 break55_g60136 = frac( temp_output_51_0_g60136 );
					float temp_output_56_0_g60136 = ( ( 1.0 - break55_g60136.x ) - break55_g60136.y );
					float2 temp_output_52_0_g60136 = floor( temp_output_51_0_g60136 );
					float2 temp_output_125_0_g60136 = ( temp_output_52_0_g60136 + float2( 1,1 ) );
					float2 ifLocalVar87_g60136 = 0;
					if( temp_output_56_0_g60136 > 0.0 )
					ifLocalVar87_g60136 = temp_output_52_0_g60136;
					else if( temp_output_56_0_g60136 == 0.0 )
					ifLocalVar87_g60136 = temp_output_125_0_g60136;
					else if( temp_output_56_0_g60136 < 0.0 )
					ifLocalVar87_g60136 = temp_output_125_0_g60136;
					float3 temp_output_7_0_g60137 = frac( ( (ifLocalVar87_g60136).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60137 = dot( temp_output_7_0_g60137 , ( (temp_output_7_0_g60137).yzx + 33.33 ) );
					float3 temp_output_12_0_g60137 = ( temp_output_7_0_g60137 + dotResult8_g60137 );
					float2 temp_output_597_0_g60135 = ( UV100_g60136 + frac( ( ( (temp_output_12_0_g60137).xx + (temp_output_12_0_g60137).yz ) * (temp_output_12_0_g60137).zy ) ) );
					float2 DDX631_g60135 = ddx( temp_output_5_0_g60135 );
					float2 DDY632_g60135 = ddy( temp_output_5_0_g60135 );
					float temp_output_65_0_g60136 = ( 0.0 - temp_output_56_0_g60136 );
					float ifLocalVar59_g60136 = 0;
					if( temp_output_56_0_g60136 <= 0.0 )
					ifLocalVar59_g60136 = temp_output_65_0_g60136;
					else
					ifLocalVar59_g60136 = temp_output_56_0_g60136;
					float temp_output_597_30_g60135 = ifLocalVar59_g60136;
					float2 temp_output_90_0_g60136 = ( temp_output_52_0_g60136 + float2( 0,1 ) );
					float2 temp_output_123_0_g60136 = ( temp_output_52_0_g60136 + float2( 1,0 ) );
					float2 ifLocalVar88_g60136 = 0;
					if( temp_output_56_0_g60136 > 0.0 )
					ifLocalVar88_g60136 = temp_output_90_0_g60136;
					else if( temp_output_56_0_g60136 == 0.0 )
					ifLocalVar88_g60136 = temp_output_123_0_g60136;
					else if( temp_output_56_0_g60136 < 0.0 )
					ifLocalVar88_g60136 = temp_output_123_0_g60136;
					float3 temp_output_7_0_g60138 = frac( ( (ifLocalVar88_g60136).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60138 = dot( temp_output_7_0_g60138 , ( (temp_output_7_0_g60138).yzx + 33.33 ) );
					float3 temp_output_12_0_g60138 = ( temp_output_7_0_g60138 + dotResult8_g60138 );
					float2 temp_output_597_26_g60135 = ( UV100_g60136 + frac( ( ( (temp_output_12_0_g60138).xx + (temp_output_12_0_g60138).yz ) * (temp_output_12_0_g60138).zy ) ) );
					float temp_output_66_0_g60136 = ( 1.0 - break55_g60136.y );
					float ifLocalVar60_g60136 = 0;
					if( temp_output_56_0_g60136 <= 0.0 )
					ifLocalVar60_g60136 = temp_output_66_0_g60136;
					else
					ifLocalVar60_g60136 = break55_g60136.y;
					float temp_output_597_28_g60135 = ifLocalVar60_g60136;
					float2 ifLocalVar89_g60136 = 0;
					if( temp_output_56_0_g60136 > 0.0 )
					ifLocalVar89_g60136 = temp_output_123_0_g60136;
					else if( temp_output_56_0_g60136 == 0.0 )
					ifLocalVar89_g60136 = temp_output_90_0_g60136;
					else if( temp_output_56_0_g60136 < 0.0 )
					ifLocalVar89_g60136 = temp_output_90_0_g60136;
					float3 temp_output_7_0_g60139 = frac( ( (ifLocalVar89_g60136).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60139 = dot( temp_output_7_0_g60139 , ( (temp_output_7_0_g60139).yzx + 33.33 ) );
					float3 temp_output_12_0_g60139 = ( temp_output_7_0_g60139 + dotResult8_g60139 );
					float2 temp_output_597_27_g60135 = ( UV100_g60136 + frac( ( ( (temp_output_12_0_g60139).xx + (temp_output_12_0_g60139).yz ) * (temp_output_12_0_g60139).zy ) ) );
					float temp_output_67_0_g60136 = ( 1.0 - break55_g60136.x );
					float ifLocalVar61_g60136 = 0;
					if( temp_output_56_0_g60136 <= 0.0 )
					ifLocalVar61_g60136 = temp_output_67_0_g60136;
					else
					ifLocalVar61_g60136 = break55_g60136.x;
					float temp_output_597_29_g60135 = ifLocalVar61_g60136;
					float4 Output_2D293_g60135 = ( ( tex2D( _Sampler82967_g60114, temp_output_597_0_g60135, DDX631_g60135, DDY632_g60135 ) * temp_output_597_30_g60135 ) + ( tex2D( _Sampler82967_g60114, temp_output_597_26_g60135, DDX631_g60135, DDY632_g60135 ) * temp_output_597_28_g60135 ) + ( tex2D( _Sampler82967_g60114, temp_output_597_27_g60135, DDX631_g60135, DDY632_g60135 ) * temp_output_597_29_g60135 ) );
					float4 break31_g60135 = Output_2D293_g60135;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g60114 = break31_g60135.r;
					#else
					float staticSwitch1005_g60114 = staticSwitch846_g60114;
					#endif
					float Metallic1239_g60114 = staticSwitch1005_g60114;
					float3 aAlbedo1466_g60114 = ( temp_output_2532_0_g60114 * ( 1.0 - Metallic1239_g60114 ) );
					float White38_g60114 = 1.0;
					float4 temp_cast_1 = (White38_g60114).xxxx;
					float4 texCoord2426_g60114 = IN.ase_texcoord6;
					texCoord2426_g60114.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0B2361_g60114 = (texCoord2426_g60114).zw;
					float localBicubicPrepare2_g60123 = ( 0.0 );
					float2 Input_UV100_g60123 = UV0B2361_g60114;
					float2 UV2_g60123 = Input_UV100_g60123;
					float4 TexelSize2_g60123 = _Lightmap0_TexelSize;
					float2 UV02_g60123 = float2( 0,0 );
					float2 UV12_g60123 = float2( 0,0 );
					float2 UV22_g60123 = float2( 0,0 );
					float2 UV32_g60123 = float2( 0,0 );
					float W02_g60123 = 0;
					float W12_g60123 = 0;
					{
					{
					 UV2_g60123 = UV2_g60123 * TexelSize2_g60123.zw - 0.5;
					    float2 f = frac( UV2_g60123 );
					    UV2_g60123 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g60123.x - 0.5, UV2_g60123.x + 1.5, UV2_g60123.y - 0.5, UV2_g60123.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60123.xyxy;
					    UV02_g60123 = off.xz;
					    UV12_g60123 = off.yz;
					    UV22_g60123 = off.xw;
					    UV32_g60123 = off.yw;
					    W02_g60123 = s.x / ( s.x + s.y );
					 W12_g60123 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g60123 = lerp( tex2D( _Lightmap0, UV32_g60123 ) , tex2D( _Lightmap0, UV22_g60123 ) , W02_g60123);
					float4 lerpResult45_g60123 = lerp( tex2D( _Lightmap0, UV12_g60123 ) , tex2D( _Lightmap0, UV02_g60123 ) , W02_g60123);
					float4 lerpResult44_g60123 = lerp( lerpResult46_g60123 , lerpResult45_g60123 , W12_g60123);
					float4 Output_2D_Auto131_g60123 = lerpResult44_g60123;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g60114 = Output_2D_Auto131_g60123;
					#else
					float4 staticSwitch1092_g60114 = float4( tex2D( _Lightmap0, UV0B2361_g60114 ).rgb , 0.0 );
					#endif
					float4 Lightmap_0925_g60114 = staticSwitch1092_g60114;
					float localBicubicPrepare2_g60121 = ( 0.0 );
					float2 Input_UV100_g60121 = UV0B2361_g60114;
					float2 UV2_g60121 = Input_UV100_g60121;
					float4 TexelSize2_g60121 = _Lightmap1_TexelSize;
					float2 UV02_g60121 = float2( 0,0 );
					float2 UV12_g60121 = float2( 0,0 );
					float2 UV22_g60121 = float2( 0,0 );
					float2 UV32_g60121 = float2( 0,0 );
					float W02_g60121 = 0;
					float W12_g60121 = 0;
					{
					{
					 UV2_g60121 = UV2_g60121 * TexelSize2_g60121.zw - 0.5;
					    float2 f = frac( UV2_g60121 );
					    UV2_g60121 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g60121.x - 0.5, UV2_g60121.x + 1.5, UV2_g60121.y - 0.5, UV2_g60121.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60121.xyxy;
					    UV02_g60121 = off.xz;
					    UV12_g60121 = off.yz;
					    UV22_g60121 = off.xw;
					    UV32_g60121 = off.yw;
					    W02_g60121 = s.x / ( s.x + s.y );
					 W12_g60121 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g60121 = lerp( tex2D( _Lightmap1, UV32_g60121 ) , tex2D( _Lightmap1, UV22_g60121 ) , W02_g60121);
					float4 lerpResult45_g60121 = lerp( tex2D( _Lightmap1, UV12_g60121 ) , tex2D( _Lightmap1, UV02_g60121 ) , W02_g60121);
					float4 lerpResult44_g60121 = lerp( lerpResult46_g60121 , lerpResult45_g60121 , W12_g60121);
					float4 Output_2D_Auto131_g60121 = lerpResult44_g60121;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g60114 = Output_2D_Auto131_g60121;
					#else
					float4 staticSwitch1088_g60114 = tex2D( _Lightmap1, UV0B2361_g60114 );
					#endif
					float4 Lightmap_1956_g60114 = staticSwitch1088_g60114;
					float Lightmap_Lerp_Value969_g60114 = _UdonLightmapLerp;
					float4 lerpResult442_g60114 = lerp( Lightmap_0925_g60114 , Lightmap_1956_g60114 , Lightmap_Lerp_Value969_g60114);
					float4 Lightmap_Lerp932_g60114 = lerpResult442_g60114;
					float3 appendResult139_g60160 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float2 temp_output_5_0_g60130 = UV0A2420_g60114;
					float2 UV633_g60130 = temp_output_5_0_g60130;
					float2 UV100_g60131 = UV633_g60130;
					float2 temp_output_51_0_g60131 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60131 * float2( 3.464,3.464 ) ) );
					float2 break55_g60131 = frac( temp_output_51_0_g60131 );
					float temp_output_56_0_g60131 = ( ( 1.0 - break55_g60131.x ) - break55_g60131.y );
					float2 temp_output_52_0_g60131 = floor( temp_output_51_0_g60131 );
					float2 temp_output_125_0_g60131 = ( temp_output_52_0_g60131 + float2( 1,1 ) );
					float2 ifLocalVar87_g60131 = 0;
					if( temp_output_56_0_g60131 > 0.0 )
					ifLocalVar87_g60131 = temp_output_52_0_g60131;
					else if( temp_output_56_0_g60131 == 0.0 )
					ifLocalVar87_g60131 = temp_output_125_0_g60131;
					else if( temp_output_56_0_g60131 < 0.0 )
					ifLocalVar87_g60131 = temp_output_125_0_g60131;
					float3 temp_output_7_0_g60132 = frac( ( (ifLocalVar87_g60131).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60132 = dot( temp_output_7_0_g60132 , ( (temp_output_7_0_g60132).yzx + 33.33 ) );
					float3 temp_output_12_0_g60132 = ( temp_output_7_0_g60132 + dotResult8_g60132 );
					float2 temp_output_597_0_g60130 = ( UV100_g60131 + frac( ( ( (temp_output_12_0_g60132).xx + (temp_output_12_0_g60132).yz ) * (temp_output_12_0_g60132).zy ) ) );
					float2 DDX631_g60130 = ddx( temp_output_5_0_g60130 );
					float2 DDY632_g60130 = ddy( temp_output_5_0_g60130 );
					float Input_Scale617_g60130 = 1.5;
					float temp_output_65_0_g60131 = ( 0.0 - temp_output_56_0_g60131 );
					float ifLocalVar59_g60131 = 0;
					if( temp_output_56_0_g60131 <= 0.0 )
					ifLocalVar59_g60131 = temp_output_65_0_g60131;
					else
					ifLocalVar59_g60131 = temp_output_56_0_g60131;
					float temp_output_597_30_g60130 = ifLocalVar59_g60131;
					float2 temp_output_90_0_g60131 = ( temp_output_52_0_g60131 + float2( 0,1 ) );
					float2 temp_output_123_0_g60131 = ( temp_output_52_0_g60131 + float2( 1,0 ) );
					float2 ifLocalVar88_g60131 = 0;
					if( temp_output_56_0_g60131 > 0.0 )
					ifLocalVar88_g60131 = temp_output_90_0_g60131;
					else if( temp_output_56_0_g60131 == 0.0 )
					ifLocalVar88_g60131 = temp_output_123_0_g60131;
					else if( temp_output_56_0_g60131 < 0.0 )
					ifLocalVar88_g60131 = temp_output_123_0_g60131;
					float3 temp_output_7_0_g60133 = frac( ( (ifLocalVar88_g60131).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60133 = dot( temp_output_7_0_g60133 , ( (temp_output_7_0_g60133).yzx + 33.33 ) );
					float3 temp_output_12_0_g60133 = ( temp_output_7_0_g60133 + dotResult8_g60133 );
					float2 temp_output_597_26_g60130 = ( UV100_g60131 + frac( ( ( (temp_output_12_0_g60133).xx + (temp_output_12_0_g60133).yz ) * (temp_output_12_0_g60133).zy ) ) );
					float temp_output_66_0_g60131 = ( 1.0 - break55_g60131.y );
					float ifLocalVar60_g60131 = 0;
					if( temp_output_56_0_g60131 <= 0.0 )
					ifLocalVar60_g60131 = temp_output_66_0_g60131;
					else
					ifLocalVar60_g60131 = break55_g60131.y;
					float temp_output_597_28_g60130 = ifLocalVar60_g60131;
					float2 ifLocalVar89_g60131 = 0;
					if( temp_output_56_0_g60131 > 0.0 )
					ifLocalVar89_g60131 = temp_output_123_0_g60131;
					else if( temp_output_56_0_g60131 == 0.0 )
					ifLocalVar89_g60131 = temp_output_90_0_g60131;
					else if( temp_output_56_0_g60131 < 0.0 )
					ifLocalVar89_g60131 = temp_output_90_0_g60131;
					float3 temp_output_7_0_g60134 = frac( ( (ifLocalVar89_g60131).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60134 = dot( temp_output_7_0_g60134 , ( (temp_output_7_0_g60134).yzx + 33.33 ) );
					float3 temp_output_12_0_g60134 = ( temp_output_7_0_g60134 + dotResult8_g60134 );
					float2 temp_output_597_27_g60130 = ( UV100_g60131 + frac( ( ( (temp_output_12_0_g60134).xx + (temp_output_12_0_g60134).yz ) * (temp_output_12_0_g60134).zy ) ) );
					float temp_output_67_0_g60131 = ( 1.0 - break55_g60131.x );
					float ifLocalVar61_g60131 = 0;
					if( temp_output_56_0_g60131 <= 0.0 )
					ifLocalVar61_g60131 = temp_output_67_0_g60131;
					else
					ifLocalVar61_g60131 = break55_g60131.x;
					float temp_output_597_29_g60130 = ifLocalVar61_g60131;
					float3 Output_2D_Normal641_g60130 = ( ( UnpackScaleNormal( tex2D( _Sampler82965_g60114, temp_output_597_0_g60130, DDX631_g60130, DDY632_g60130 ), Input_Scale617_g60130 ) * temp_output_597_30_g60130 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g60114, temp_output_597_26_g60130, DDX631_g60130, DDY632_g60130 ), Input_Scale617_g60130 ) * temp_output_597_28_g60130 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g60114, temp_output_597_27_g60130, DDX631_g60130, DDY632_g60130 ), Input_Scale617_g60130 ) * float3( 0,0,0 ) * temp_output_597_29_g60130 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g60114 = Output_2D_Normal641_g60130;
					#else
					float3 staticSwitch1003_g60114 = UnpackScaleNormal( tex2D( _BumpMap, UV0A2420_g60114 ), 1.5 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g60114 = staticSwitch1003_g60114;
					#else
					float3 staticSwitch980_g60114 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g60114 = staticSwitch980_g60114;
					float3 normalizeResult326_g60160 = normalize( Normal_Map700_g60114 );
					float3 Normal_Map318_g60160 = normalizeResult326_g60160;
					float dotResult121_g60160 = dot( appendResult139_g60160 , Normal_Map318_g60160 );
					float temp_output_2_0_g60162 = saturate( dotResult121_g60160 );
					float localStochasticTiling2_g60156 = ( 0.0 );
					float2 UV2_g60156 = UV0B2361_g60114;
					float4 TexelSize2_g60156 = _UdonRNMX0_TexelSize;
					float4 Offsets2_g60156 = float4( 0,0,0,0 );
					float2 Weights2_g60156 = float2( 0,0 );
					{
					UV2_g60156 = UV2_g60156 * TexelSize2_g60156.zw - 0.5;
					float2 f = frac( UV2_g60156 );
					UV2_g60156 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g60156.x - 0.5, UV2_g60156.x + 1.5, UV2_g60156.y - 0.5, UV2_g60156.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g60156 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60156.xyxy;
					Weights2_g60156 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g60155 = Offsets2_g60156;
					float4 Input_FetchOffsets197_g60157 = temp_output_1_34_g60155;
					float2 temp_output_1_54_g60155 = Weights2_g60156;
					float2 Input_FetchWeights200_g60157 = temp_output_1_54_g60155;
					float2 break187_g60157 = Input_FetchWeights200_g60157;
					float4 lerpResult181_g60157 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60157).yw ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60157).xw ) , break187_g60157.x);
					float4 lerpResult182_g60157 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60157).yz ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60157).xz ) , break187_g60157.x);
					float4 lerpResult176_g60157 = lerp( lerpResult181_g60157 , lerpResult182_g60157 , break187_g60157.y);
					float4 Output_Fetch2D_Auto202_g60157 = lerpResult176_g60157;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g60114 = Output_Fetch2D_Auto202_g60157;
					#else
					float4 staticSwitch1061_g60114 = tex2D( _UdonRNMX0, UV0B2361_g60114 );
					#endif
					float3 appendResult146_g60160 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g60160 = dot( appendResult146_g60160 , Normal_Map318_g60160 );
					float temp_output_2_0_g60161 = saturate( dotResult122_g60160 );
					float4 Input_FetchOffsets197_g60158 = temp_output_1_34_g60155;
					float2 Input_FetchWeights200_g60158 = temp_output_1_54_g60155;
					float2 break187_g60158 = Input_FetchWeights200_g60158;
					float4 lerpResult181_g60158 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60158).yw ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60158).xw ) , break187_g60158.x);
					float4 lerpResult182_g60158 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60158).yz ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60158).xz ) , break187_g60158.x);
					float4 lerpResult176_g60158 = lerp( lerpResult181_g60158 , lerpResult182_g60158 , break187_g60158.y);
					float4 Output_Fetch2D_Auto202_g60158 = lerpResult176_g60158;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g60114 = Output_Fetch2D_Auto202_g60158;
					#else
					float4 staticSwitch1062_g60114 = tex2D( _UdonRNMY0, UV0B2361_g60114 );
					#endif
					float3 appendResult149_g60160 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g60160 = dot( appendResult149_g60160 , Normal_Map318_g60160 );
					float temp_output_2_0_g60163 = saturate( dotResult120_g60160 );
					float4 Input_FetchOffsets197_g60159 = temp_output_1_34_g60155;
					float2 Input_FetchWeights200_g60159 = temp_output_1_54_g60155;
					float2 break187_g60159 = Input_FetchWeights200_g60159;
					float4 lerpResult181_g60159 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60159).yw ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60159).xw ) , break187_g60159.x);
					float4 lerpResult182_g60159 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60159).yz ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60159).xz ) , break187_g60159.x);
					float4 lerpResult176_g60159 = lerp( lerpResult181_g60159 , lerpResult182_g60159 , break187_g60159.y);
					float4 Output_Fetch2D_Auto202_g60159 = lerpResult176_g60159;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g60114 = Output_Fetch2D_Auto202_g60159;
					#else
					float4 staticSwitch1063_g60114 = tex2D( _UdonRNMZ0, UV0B2361_g60114 );
					#endif
					float4 RNM_0926_g60114 = ( ( ( ( ( temp_output_2_0_g60162 * temp_output_2_0_g60162 ) * staticSwitch1061_g60114 ) + ( ( temp_output_2_0_g60161 * temp_output_2_0_g60161 ) * staticSwitch1062_g60114 ) ) + ( ( temp_output_2_0_g60163 * temp_output_2_0_g60163 ) * staticSwitch1063_g60114 ) ) * 1.5 );
					float3 appendResult139_g60126 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g60126 = normalize( Normal_Map700_g60114 );
					float3 Normal_Map318_g60126 = normalizeResult326_g60126;
					float dotResult121_g60126 = dot( appendResult139_g60126 , Normal_Map318_g60126 );
					float temp_output_2_0_g60128 = saturate( dotResult121_g60126 );
					float localStochasticTiling2_g60116 = ( 0.0 );
					float2 UV2_g60116 = UV0B2361_g60114;
					float4 TexelSize2_g60116 = _UdonRNMX1_TexelSize;
					float4 Offsets2_g60116 = float4( 0,0,0,0 );
					float2 Weights2_g60116 = float2( 0,0 );
					{
					UV2_g60116 = UV2_g60116 * TexelSize2_g60116.zw - 0.5;
					float2 f = frac( UV2_g60116 );
					UV2_g60116 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g60116.x - 0.5, UV2_g60116.x + 1.5, UV2_g60116.y - 0.5, UV2_g60116.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g60116 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60116.xyxy;
					Weights2_g60116 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g60115 = Offsets2_g60116;
					float4 Input_FetchOffsets197_g60117 = temp_output_1_34_g60115;
					float2 temp_output_1_54_g60115 = Weights2_g60116;
					float2 Input_FetchWeights200_g60117 = temp_output_1_54_g60115;
					float2 break187_g60117 = Input_FetchWeights200_g60117;
					float4 lerpResult181_g60117 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60117).yw ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60117).xw ) , break187_g60117.x);
					float4 lerpResult182_g60117 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60117).yz ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60117).xz ) , break187_g60117.x);
					float4 lerpResult176_g60117 = lerp( lerpResult181_g60117 , lerpResult182_g60117 , break187_g60117.y);
					float4 Output_Fetch2D_Auto202_g60117 = lerpResult176_g60117;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g60114 = Output_Fetch2D_Auto202_g60117;
					#else
					float4 staticSwitch1087_g60114 = tex2D( _UdonRNMX1, UV0B2361_g60114 );
					#endif
					float3 appendResult146_g60126 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g60126 = dot( appendResult146_g60126 , Normal_Map318_g60126 );
					float temp_output_2_0_g60127 = saturate( dotResult122_g60126 );
					float4 Input_FetchOffsets197_g60118 = temp_output_1_34_g60115;
					float2 Input_FetchWeights200_g60118 = temp_output_1_54_g60115;
					float2 break187_g60118 = Input_FetchWeights200_g60118;
					float4 lerpResult181_g60118 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60118).yw ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60118).xw ) , break187_g60118.x);
					float4 lerpResult182_g60118 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60118).yz ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60118).xz ) , break187_g60118.x);
					float4 lerpResult176_g60118 = lerp( lerpResult181_g60118 , lerpResult182_g60118 , break187_g60118.y);
					float4 Output_Fetch2D_Auto202_g60118 = lerpResult176_g60118;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g60114 = Output_Fetch2D_Auto202_g60118;
					#else
					float4 staticSwitch1083_g60114 = tex2D( _UdonRNMY1, UV0B2361_g60114 );
					#endif
					float3 appendResult149_g60126 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g60126 = dot( appendResult149_g60126 , Normal_Map318_g60126 );
					float temp_output_2_0_g60129 = saturate( dotResult120_g60126 );
					float4 Input_FetchOffsets197_g60119 = temp_output_1_34_g60115;
					float2 Input_FetchWeights200_g60119 = temp_output_1_54_g60115;
					float2 break187_g60119 = Input_FetchWeights200_g60119;
					float4 lerpResult181_g60119 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60119).yw ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60119).xw ) , break187_g60119.x);
					float4 lerpResult182_g60119 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60119).yz ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60119).xz ) , break187_g60119.x);
					float4 lerpResult176_g60119 = lerp( lerpResult181_g60119 , lerpResult182_g60119 , break187_g60119.y);
					float4 Output_Fetch2D_Auto202_g60119 = lerpResult176_g60119;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g60114 = Output_Fetch2D_Auto202_g60119;
					#else
					float4 staticSwitch1084_g60114 = tex2D( _UdonRNMZ1, UV0B2361_g60114 );
					#endif
					float4 RNM_11081_g60114 = ( ( ( ( ( temp_output_2_0_g60128 * temp_output_2_0_g60128 ) * staticSwitch1087_g60114 ) + ( ( temp_output_2_0_g60127 * temp_output_2_0_g60127 ) * staticSwitch1083_g60114 ) ) + ( ( temp_output_2_0_g60129 * temp_output_2_0_g60129 ) * staticSwitch1084_g60114 ) ) * 1.5 );
					float4 lerpResult953_g60114 = lerp( RNM_0926_g60114 , RNM_11081_g60114 , Lightmap_Lerp_Value969_g60114);
					float4 RNM_Lerp950_g60114 = lerpResult953_g60114;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g60114 = temp_cast_1;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g60114 = Lightmap_0925_g60114;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g60114 = Lightmap_Lerp932_g60114;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g60114 = RNM_0926_g60114;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g60114 = RNM_Lerp950_g60114;
					#else
					float4 staticSwitch1014_g60114 = temp_cast_1;
					#endif
					float3 Lightmap46_g60114 = (staticSwitch1014_g60114).rgb;
					float2 temp_output_5_0_g60150 = UV0A2420_g60114;
					float2 UV633_g60150 = temp_output_5_0_g60150;
					float2 UV100_g60151 = UV633_g60150;
					float2 temp_output_51_0_g60151 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60151 * float2( 3.464,3.464 ) ) );
					float2 break55_g60151 = frac( temp_output_51_0_g60151 );
					float temp_output_56_0_g60151 = ( ( 1.0 - break55_g60151.x ) - break55_g60151.y );
					float2 temp_output_52_0_g60151 = floor( temp_output_51_0_g60151 );
					float2 temp_output_125_0_g60151 = ( temp_output_52_0_g60151 + float2( 1,1 ) );
					float2 ifLocalVar87_g60151 = 0;
					if( temp_output_56_0_g60151 > 0.0 )
					ifLocalVar87_g60151 = temp_output_52_0_g60151;
					else if( temp_output_56_0_g60151 == 0.0 )
					ifLocalVar87_g60151 = temp_output_125_0_g60151;
					else if( temp_output_56_0_g60151 < 0.0 )
					ifLocalVar87_g60151 = temp_output_125_0_g60151;
					float3 temp_output_7_0_g60152 = frac( ( (ifLocalVar87_g60151).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60152 = dot( temp_output_7_0_g60152 , ( (temp_output_7_0_g60152).yzx + 33.33 ) );
					float3 temp_output_12_0_g60152 = ( temp_output_7_0_g60152 + dotResult8_g60152 );
					float2 temp_output_597_0_g60150 = ( UV100_g60151 + frac( ( ( (temp_output_12_0_g60152).xx + (temp_output_12_0_g60152).yz ) * (temp_output_12_0_g60152).zy ) ) );
					float2 DDX631_g60150 = ddx( temp_output_5_0_g60150 );
					float2 DDY632_g60150 = ddy( temp_output_5_0_g60150 );
					float temp_output_65_0_g60151 = ( 0.0 - temp_output_56_0_g60151 );
					float ifLocalVar59_g60151 = 0;
					if( temp_output_56_0_g60151 <= 0.0 )
					ifLocalVar59_g60151 = temp_output_65_0_g60151;
					else
					ifLocalVar59_g60151 = temp_output_56_0_g60151;
					float temp_output_597_30_g60150 = ifLocalVar59_g60151;
					float2 temp_output_90_0_g60151 = ( temp_output_52_0_g60151 + float2( 0,1 ) );
					float2 temp_output_123_0_g60151 = ( temp_output_52_0_g60151 + float2( 1,0 ) );
					float2 ifLocalVar88_g60151 = 0;
					if( temp_output_56_0_g60151 > 0.0 )
					ifLocalVar88_g60151 = temp_output_90_0_g60151;
					else if( temp_output_56_0_g60151 == 0.0 )
					ifLocalVar88_g60151 = temp_output_123_0_g60151;
					else if( temp_output_56_0_g60151 < 0.0 )
					ifLocalVar88_g60151 = temp_output_123_0_g60151;
					float3 temp_output_7_0_g60153 = frac( ( (ifLocalVar88_g60151).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60153 = dot( temp_output_7_0_g60153 , ( (temp_output_7_0_g60153).yzx + 33.33 ) );
					float3 temp_output_12_0_g60153 = ( temp_output_7_0_g60153 + dotResult8_g60153 );
					float2 temp_output_597_26_g60150 = ( UV100_g60151 + frac( ( ( (temp_output_12_0_g60153).xx + (temp_output_12_0_g60153).yz ) * (temp_output_12_0_g60153).zy ) ) );
					float temp_output_66_0_g60151 = ( 1.0 - break55_g60151.y );
					float ifLocalVar60_g60151 = 0;
					if( temp_output_56_0_g60151 <= 0.0 )
					ifLocalVar60_g60151 = temp_output_66_0_g60151;
					else
					ifLocalVar60_g60151 = break55_g60151.y;
					float temp_output_597_28_g60150 = ifLocalVar60_g60151;
					float2 ifLocalVar89_g60151 = 0;
					if( temp_output_56_0_g60151 > 0.0 )
					ifLocalVar89_g60151 = temp_output_123_0_g60151;
					else if( temp_output_56_0_g60151 == 0.0 )
					ifLocalVar89_g60151 = temp_output_90_0_g60151;
					else if( temp_output_56_0_g60151 < 0.0 )
					ifLocalVar89_g60151 = temp_output_90_0_g60151;
					float3 temp_output_7_0_g60154 = frac( ( (ifLocalVar89_g60151).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60154 = dot( temp_output_7_0_g60154 , ( (temp_output_7_0_g60154).yzx + 33.33 ) );
					float3 temp_output_12_0_g60154 = ( temp_output_7_0_g60154 + dotResult8_g60154 );
					float2 temp_output_597_27_g60150 = ( UV100_g60151 + frac( ( ( (temp_output_12_0_g60154).xx + (temp_output_12_0_g60154).yz ) * (temp_output_12_0_g60154).zy ) ) );
					float temp_output_67_0_g60151 = ( 1.0 - break55_g60151.x );
					float ifLocalVar61_g60151 = 0;
					if( temp_output_56_0_g60151 <= 0.0 )
					ifLocalVar61_g60151 = temp_output_67_0_g60151;
					else
					ifLocalVar61_g60151 = break55_g60151.x;
					float temp_output_597_29_g60150 = ifLocalVar61_g60151;
					float4 Output_2D293_g60150 = ( ( tex2D( _Sampler82968_g60114, temp_output_597_0_g60150, DDX631_g60150, DDY632_g60150 ) * temp_output_597_30_g60150 ) + ( tex2D( _Sampler82968_g60114, temp_output_597_26_g60150, DDX631_g60150, DDY632_g60150 ) * temp_output_597_28_g60150 ) + ( tex2D( _Sampler82968_g60114, temp_output_597_27_g60150, DDX631_g60150, DDY632_g60150 ) * temp_output_597_29_g60150 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g60114 = Output_2D293_g60150;
					#else
					float4 staticSwitch1006_g60114 = tex2D( _EmissionMap, UV0A2420_g60114 );
					#endif
					float3 temp_output_2531_0_g60114 = (( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g60114 * _EmissionIntensity )).rgb;
					float3 Emission86_g60114 = temp_output_2531_0_g60114;
					float3 Color1_g60165 = oAlbedo6_g60114;
					float Metallic1_g60165 = Metallic1239_g60114;
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g60114 = tex2D( _GlossinessMap, UV0A2420_g60114 ).r;
					#else
					float staticSwitch845_g60114 = _Glossiness;
					#endif
					float2 temp_output_5_0_g60145 = UV0A2420_g60114;
					float2 UV633_g60145 = temp_output_5_0_g60145;
					float2 UV100_g60146 = UV633_g60145;
					float2 temp_output_51_0_g60146 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60146 * float2( 3.464,3.464 ) ) );
					float2 break55_g60146 = frac( temp_output_51_0_g60146 );
					float temp_output_56_0_g60146 = ( ( 1.0 - break55_g60146.x ) - break55_g60146.y );
					float2 temp_output_52_0_g60146 = floor( temp_output_51_0_g60146 );
					float2 temp_output_125_0_g60146 = ( temp_output_52_0_g60146 + float2( 1,1 ) );
					float2 ifLocalVar87_g60146 = 0;
					if( temp_output_56_0_g60146 > 0.0 )
					ifLocalVar87_g60146 = temp_output_52_0_g60146;
					else if( temp_output_56_0_g60146 == 0.0 )
					ifLocalVar87_g60146 = temp_output_125_0_g60146;
					else if( temp_output_56_0_g60146 < 0.0 )
					ifLocalVar87_g60146 = temp_output_125_0_g60146;
					float3 temp_output_7_0_g60147 = frac( ( (ifLocalVar87_g60146).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60147 = dot( temp_output_7_0_g60147 , ( (temp_output_7_0_g60147).yzx + 33.33 ) );
					float3 temp_output_12_0_g60147 = ( temp_output_7_0_g60147 + dotResult8_g60147 );
					float2 temp_output_597_0_g60145 = ( UV100_g60146 + frac( ( ( (temp_output_12_0_g60147).xx + (temp_output_12_0_g60147).yz ) * (temp_output_12_0_g60147).zy ) ) );
					float2 DDX631_g60145 = ddx( temp_output_5_0_g60145 );
					float2 DDY632_g60145 = ddy( temp_output_5_0_g60145 );
					float temp_output_65_0_g60146 = ( 0.0 - temp_output_56_0_g60146 );
					float ifLocalVar59_g60146 = 0;
					if( temp_output_56_0_g60146 <= 0.0 )
					ifLocalVar59_g60146 = temp_output_65_0_g60146;
					else
					ifLocalVar59_g60146 = temp_output_56_0_g60146;
					float temp_output_597_30_g60145 = ifLocalVar59_g60146;
					float2 temp_output_90_0_g60146 = ( temp_output_52_0_g60146 + float2( 0,1 ) );
					float2 temp_output_123_0_g60146 = ( temp_output_52_0_g60146 + float2( 1,0 ) );
					float2 ifLocalVar88_g60146 = 0;
					if( temp_output_56_0_g60146 > 0.0 )
					ifLocalVar88_g60146 = temp_output_90_0_g60146;
					else if( temp_output_56_0_g60146 == 0.0 )
					ifLocalVar88_g60146 = temp_output_123_0_g60146;
					else if( temp_output_56_0_g60146 < 0.0 )
					ifLocalVar88_g60146 = temp_output_123_0_g60146;
					float3 temp_output_7_0_g60148 = frac( ( (ifLocalVar88_g60146).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60148 = dot( temp_output_7_0_g60148 , ( (temp_output_7_0_g60148).yzx + 33.33 ) );
					float3 temp_output_12_0_g60148 = ( temp_output_7_0_g60148 + dotResult8_g60148 );
					float2 temp_output_597_26_g60145 = ( UV100_g60146 + frac( ( ( (temp_output_12_0_g60148).xx + (temp_output_12_0_g60148).yz ) * (temp_output_12_0_g60148).zy ) ) );
					float temp_output_66_0_g60146 = ( 1.0 - break55_g60146.y );
					float ifLocalVar60_g60146 = 0;
					if( temp_output_56_0_g60146 <= 0.0 )
					ifLocalVar60_g60146 = temp_output_66_0_g60146;
					else
					ifLocalVar60_g60146 = break55_g60146.y;
					float temp_output_597_28_g60145 = ifLocalVar60_g60146;
					float2 ifLocalVar89_g60146 = 0;
					if( temp_output_56_0_g60146 > 0.0 )
					ifLocalVar89_g60146 = temp_output_123_0_g60146;
					else if( temp_output_56_0_g60146 == 0.0 )
					ifLocalVar89_g60146 = temp_output_90_0_g60146;
					else if( temp_output_56_0_g60146 < 0.0 )
					ifLocalVar89_g60146 = temp_output_90_0_g60146;
					float3 temp_output_7_0_g60149 = frac( ( (ifLocalVar89_g60146).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60149 = dot( temp_output_7_0_g60149 , ( (temp_output_7_0_g60149).yzx + 33.33 ) );
					float3 temp_output_12_0_g60149 = ( temp_output_7_0_g60149 + dotResult8_g60149 );
					float2 temp_output_597_27_g60145 = ( UV100_g60146 + frac( ( ( (temp_output_12_0_g60149).xx + (temp_output_12_0_g60149).yz ) * (temp_output_12_0_g60149).zy ) ) );
					float temp_output_67_0_g60146 = ( 1.0 - break55_g60146.x );
					float ifLocalVar61_g60146 = 0;
					if( temp_output_56_0_g60146 <= 0.0 )
					ifLocalVar61_g60146 = temp_output_67_0_g60146;
					else
					ifLocalVar61_g60146 = break55_g60146.x;
					float temp_output_597_29_g60145 = ifLocalVar61_g60146;
					float4 Output_2D293_g60145 = ( ( tex2D( _Sampler82964_g60114, temp_output_597_0_g60145, DDX631_g60145, DDY632_g60145 ) * temp_output_597_30_g60145 ) + ( tex2D( _Sampler82964_g60114, temp_output_597_26_g60145, DDX631_g60145, DDY632_g60145 ) * temp_output_597_28_g60145 ) + ( tex2D( _Sampler82964_g60114, temp_output_597_27_g60145, DDX631_g60145, DDY632_g60145 ) * temp_output_597_29_g60145 ) );
					float4 break31_g60145 = Output_2D293_g60145;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g60114 = ( 1.0 - break31_g60145.r );
					#else
					float staticSwitch1004_g60114 = ( 1.0 - staticSwitch845_g60114 );
					#endif
					float temp_output_19_0_g60164 = staticSwitch1004_g60114;
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal2504_g60114 = Normal_Map700_g60114;
					float3 worldNormal2504_g60114 = normalize( float3( dot( tanToWorld0, tanNormal2504_g60114 ), dot( tanToWorld1, tanNormal2504_g60114 ), dot( tanToWorld2, tanNormal2504_g60114 ) ) );
					float3 World_Normal2508_g60114 = worldNormal2504_g60114;
					float3 tanNormal2_g60164 = World_Normal2508_g60114;
					float3 worldNormal2_g60164 = float3( dot( tanToWorld0, tanNormal2_g60164 ), dot( tanToWorld1, tanNormal2_g60164 ), dot( tanToWorld2, tanNormal2_g60164 ) );
					float3 temp_output_3_0_g60164 = ddx( worldNormal2_g60164 );
					float dotResult5_g60164 = dot( temp_output_3_0_g60164 , temp_output_3_0_g60164 );
					float3 temp_output_4_0_g60164 = ddy( worldNormal2_g60164 );
					float dotResult6_g60164 = dot( temp_output_4_0_g60164 , temp_output_4_0_g60164 );
					#ifdef _USEGEOMETRICAA_ON
					float staticSwitch15_g60164 = min( temp_output_19_0_g60164, ( 1.0 - pow( saturate( max( dotResult5_g60164, dotResult6_g60164 ) ) , 0.25 ) ) );
					#else
					float staticSwitch15_g60164 = temp_output_19_0_g60164;
					#endif
					float Smoothness1399_g60114 = staticSwitch15_g60164;
					float Smoothness1_g60165 = Smoothness1399_g60114;
					float IOR2700_g60114 = _IOR;
					float IOR1_g60165 = IOR2700_g60114;
					float3 temp_cast_4 = (0.04).xxx;
					float3 lerpResult1473_g60114 = lerp( temp_cast_4 , oAlbedo6_g60114 , Metallic1239_g60114);
					float3 switchResult1501_g60114 = (((ase_vface>0)?(World_Normal2508_g60114):(-World_Normal2508_g60114)));
					float3 View_Direction2511_g60114 = ViewDirWS;
					float dotResult1476_g60114 = dot( switchResult1501_g60114 , View_Direction2511_g60114 );
					float3 lerpResult1480_g60114 = lerp( lerpResult1473_g60114 , float3( 1,1,1 ) , pow( ( 1.0 - saturate( dotResult1476_g60114 ) ) , 5.0 ));
					float3 Fresnel1560_g60114 = lerpResult1480_g60114;
					float3 Fresnel1_g60165 = Fresnel1560_g60114;
					float3 World_Position2505_g60114 = PositionWS;
					float3 WorldPos1_g60165 = World_Position2505_g60114;
					float3 WorldNormal1_g60165 = World_Normal2508_g60114;
					float3 ViewDir1_g60165 = View_Direction2511_g60114;
					float3 localIndirectSpecular1_g60165 = IndirectSpecular1_g60165( Color1_g60165 , Metallic1_g60165 , Smoothness1_g60165 , IOR1_g60165 , Fresnel1_g60165 , WorldPos1_g60165 , WorldNormal1_g60165 , ViewDir1_g60165 );
					float3 temp_output_2778_0_g60114 = localIndirectSpecular1_g60165;
					float grayscale2713_g60114 = Luminance( Lightmap46_g60114 );
					float smoothstepResult2430_g60114 = smoothstep( 0.0 , 0.05 , grayscale2713_g60114);
					#ifdef _USELIGHTMAPPEDREFLECTIONS_ON
					float3 staticSwitch1469_g60114 = ( temp_output_2778_0_g60114 * smoothstepResult2430_g60114 );
					#else
					float3 staticSwitch1469_g60114 = temp_output_2778_0_g60114;
					#endif
					float3 Reflections1419_g60114 = staticSwitch1469_g60114;
					float3 Color97_g60166 = oAlbedo6_g60114;
					float3 LightmapColor97_g60166 = Lightmap46_g60114;
					float Metallic97_g60166 = Metallic1239_g60114;
					float Smoothness97_g60166 = Smoothness1399_g60114;
					float IOR97_g60166 = IOR2700_g60114;
					float3 WorldPos97_g60166 = World_Position2505_g60114;
					float3 WorldNormal97_g60166 = World_Normal2508_g60114;
					float3 ViewDir97_g60166 = View_Direction2511_g60114;
					float3 localDirectSpecular97_g60166 = DirectSpecular( Color97_g60166 , LightmapColor97_g60166 , Metallic97_g60166 , Smoothness97_g60166 , IOR97_g60166 , WorldPos97_g60166 , WorldNormal97_g60166 , ViewDir97_g60166 );
					float3 Speculars2560_g60114 = localDirectSpecular97_g60166;
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch1181_g60114 = Lightmap46_g60114;
					#else
					float3 staticSwitch1181_g60114 = ( ( aAlbedo1466_g60114 * Lightmap46_g60114 ) + Emission86_g60114 + Reflections1419_g60114 + Speculars2560_g60114 );
					#endif
					float3 temp_output_35_0_g60124 = staticSwitch1181_g60114;
					float3 Color353_g60124 = temp_output_35_0_g60124;
					#if defined( _LUTMODE_2D )
					float3 staticSwitch273_g60124 = saturate( temp_output_35_0_g60124 );
					#elif defined( _LUTMODE_3D )
					float3 staticSwitch273_g60124 = temp_output_35_0_g60124;
					#else
					float3 staticSwitch273_g60124 = temp_output_35_0_g60124;
					#endif
					float3 Color_Saturate49_g60124 = staticSwitch273_g60124;
					float Lut_Height213_g60124 = _LUTSize;
					float Lut_Width216_g60124 = ( _LUTSize * Lut_Height213_g60124 );
					float3 appendResult214_g60124 = (float3(( 1.0 / Lut_Width216_g60124 ) , ( 1.0 / Lut_Height213_g60124 ) , ( Lut_Height213_g60124 - 1.0 )));
					float3 Scale_Offset208_g60124 = appendResult214_g60124;
					float2 Scale_Factor292_g60124 = ( (Scale_Offset208_g60124).xy * (Scale_Offset208_g60124).z );
					float2 Offset299_g60124 = ( (Scale_Offset208_g60124).xy * 0.5 );
					float2 Adjusted_UV305_g60124 = ( ( (Color_Saturate49_g60124).xy * Scale_Factor292_g60124 ) + Offset299_g60124 );
					float Scaled_Blue280_g60124 = ( (Color_Saturate49_g60124).z * (Scale_Offset208_g60124).z );
					float Shift288_g60124 = floor( Scaled_Blue280_g60124 );
					float Final_X313_g60124 = ( (Adjusted_UV305_g60124).x + ( Shift288_g60124 * (Scale_Offset208_g60124).y ) );
					float2 appendResult326_g60124 = (float2(Final_X313_g60124 , (Adjusted_UV305_g60124).y));
					float2 Final_UV325_g60124 = appendResult326_g60124;
					float2 appendResult338_g60124 = (float2((Scale_Offset208_g60124).y , 0.0));
					float2 Offset_UV336_g60124 = ( Final_UV325_g60124 + appendResult338_g60124 );
					float3 lerpResult333_g60124 = lerp( tex2D( _2DLut, Final_UV325_g60124 ).rgb , tex2D( _2DLut, Offset_UV336_g60124 ).rgb , ( Scaled_Blue280_g60124 - Shift288_g60124 ));
					#ifdef _2DLUT
					float3 staticSwitch347_g60124 = lerpResult333_g60124;
					#else
					float3 staticSwitch347_g60124 = Color_Saturate49_g60124;
					#endif
					float3 TwoD_LUT346_g60124 = staticSwitch347_g60124;
					float3 RGB16_g60125 = ( ( log10( ( ( Color_Saturate49_g60124 * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 );
					#ifdef _3DLUT
					float3 staticSwitch194_g60124 = tex3D( _3DLut, RGB16_g60125 ).rgb;
					#else
					float3 staticSwitch194_g60124 = Color_Saturate49_g60124;
					#endif
					float3 ThreeD_LUT51_g60124 = staticSwitch194_g60124;
					#if defined( _LUTMODE_2D )
					float3 staticSwitch42_g60124 = TwoD_LUT346_g60124;
					#elif defined( _LUTMODE_3D )
					float3 staticSwitch42_g60124 = ThreeD_LUT51_g60124;
					#else
					float3 staticSwitch42_g60124 = ThreeD_LUT51_g60124;
					#endif
					#ifdef SHADER_API_MOBILE
					float3 staticSwitch41_g60124 = staticSwitch42_g60124;
					#else
					float3 staticSwitch41_g60124 = Color353_g60124;
					#endif
					

					o.Albedo = staticSwitch1180_g60114;
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

					o.Emission = staticSwitch41_g60124;
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
				#define ASE_FOG
				#define _SPECULARHIGHLIGHTS_OFF
				#define ASE_LIGHTING_SIMPLE 1
				#define _GLOSSYREFLECTIONS_OFF
				#define ASE_NO_AMBIENT 1
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
				#define _SPECULARHIGHLIGHTS_OFF
				#define ASE_LIGHTING_SIMPLE 1
				#define _GLOSSYREFLECTIONS_OFF
				#define ASE_NO_AMBIENT 1
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
			Tags { "LightMode"="ScenePickingPass" }

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
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3256;192,-1152;Inherit;False;Meenphie;0;;60114;b3ba55a08dd6b49c7be16c6f35cf2033;6,1008,0,2632,0,2635,0,2636,0,2670,0,2619,0;0;6;FLOAT3;625;FLOAT3;624;FLOAT;156;FLOAT;427;FLOAT;1024;FLOAT3;2765
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3152;640,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;12;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;True;False;False;True;False;False;False;False;False;False;False;True;1;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;1;LightMode=ForwardBase;False;False;0;False;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3154;640,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;12;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;True;False;False;True;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;True;1;LightMode=ForwardAdd;False;False;0;False;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3155;640,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;12;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;True;False;False;True;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;True;1;LightMode=Deferred;False;False;0;False;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3156;640,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;12;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;True;False;False;True;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;False;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3157;640,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;12;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;True;False;False;True;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;False;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3158;640,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;12;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;True;False;False;True;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;False;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3159;640,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;12;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ScenePickingPass;0;7;ScenePickingPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;True;False;False;True;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=ScenePickingPass;False;False;0;False;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3153;512,-1152;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;6;Meenphie/Standard/Transparent/Additive;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardBase;0;1;ForwardBase;17;True;True;0;1;False;;1;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;2;False;;True;3;False;;False;False;True;3;RenderType=Transparent=RenderType;Queue=Transparent=Queue=1;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;True;False;False;True;False;False;False;False;False;False;True;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;44;Category;0;0;  Instanced Terrain Normals;1;0;Workflow;3;639057697649873840;Surface;1;639116848959649190;  Blend;2;639116848980030270;  Dither Shadows;0;639116848994245360;Two Sided;0;639057698775949650;Alpha Clipping;0;0;  Use Shadow Threshold;0;0;Deferred Pass;0;639057697867054150;Normal Space;0;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;1;0;Receive Shadows;1;0;Receive Specular;0;639048816484624920;Receive Reflections;0;639116847657607100;GPU Instancing;1;0;LOD CrossFade;1;0;Built-in Fog;1;0;Ambient Light;0;639116847860649440;Meta Pass;0;639116847863196800;Add Pass;0;639048816879073320;Override Baked GI;0;0;Write Depth;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;0;Vertex Position;1;0;0;8;False;True;False;False;False;True;True;True;False;;False;0
WireConnection;3153;0;3256;625
WireConnection;3153;2;3256;624
ASEEND*/
//CHKSM=9BAE10C34045E9A37A0986E1E90769779C6F3E6F