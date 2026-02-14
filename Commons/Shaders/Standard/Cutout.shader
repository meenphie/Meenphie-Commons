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
		_NormalScale( "Normal Scale", Float ) = 1
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
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0
		[HideInInspector] GenKey__2DLut( "Assign keyword _2DLUT", Float ) = 1.0
		[HideInInspector] GenKey__GlossinessMap( "Assign keyword _GLOSSINESSMAP", Float ) = 1.0
		[HideInInspector] GenKey__3DLut( "Assign keyword _3DLUT", Float ) = 1.0
		[HideInInspector] GenKey__MetallicMap( "Assign keyword _METALLICMAP", Float ) = 1.0
		[HideInInspector] GenKey__MainTex( "Assign keyword _MAINTEX", Float ) = 1.0


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
				uniform float _NormalScale;
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


				float3 Specular( float3 WorldPos, float3 WorldNormal, float Smoothness, float3 LightmapColor, float3 ViewDir )
				{
					// --- CONFIGURATION ---
					float LumaStart = 0.01;
					float LumaEnd   = 1.0;
					float SpecBoost = 0.01;
					// --- 1. EARLY EXIT ---
					float luma = dot(LightmapColor, float3(0.21, 0.72, 0.07));
					float lmMask = smoothstep(LumaStart, LumaEnd, luma);
					// Combined check to exit early
					if (lmMask < 0.001 || Smoothness < 0.001 || _UdonSpecularLightCount == 0) return 0;
					// --- 2. SETUP ---
					float3 vDir = normalize(ViewDir);
					float3 N = normalize(WorldNormal);
					// Blinn-Phong exponent
					float shininess = exp2(10.0 * Smoothness + 1.0);
					float normalization = (shininess + 2.0) * 0.125;
					float nv = saturate(dot(N, vDir));
					// --- OPTIMIZED FRESNEL ---
					float fresBase = 1.0 - nv;
					float fresBase2 = fresBase * fresBase;
					float fresnel = 0.04 + (1.0 - 0.04) * (fresBase2 * fresBase2 * fresBase);
					// Ideal reflection vector
					float3 R = reflect(-vDir, N);
					float3 specAccum = 0.0;
					// --- 3. BOUCLE ---
					for (int i = 0; i < (int)_UdonSpecularLightCount; i++)
					{
					    float4 lightPosRange = _UdonSpecularLightPos[i];
					    float4 lightRightW = _UdonSpecularLightRight[i];
					    float4 lightUpH = _UdonSpecularLightUp[i];
					    float4 lightColInt = _UdonSpecularLightCol[i];
					    float3 center = lightPosRange.xyz;
					    float3 right  = lightRightW.xyz;
					    float3 up     = lightUpH.xyz;
					    float width   = lightRightW.w;
					    float height  = lightUpH.w;
					    float3 L = center - WorldPos;
					    
					    // Approximation of closest point on area light
					    float3 closestPoint = center;
					    float3 proj = R * dot(L, R) - L;
					    closestPoint += right * clamp(dot(proj, right), -width, width);
					    closestPoint += up * clamp(dot(proj, up), -height, height);
					    float3 diff = closestPoint - WorldPos;
					    float distSq = dot(diff, diff);
					    float range = lightPosRange.w;
					    
					    // Square falloff
					    float falloff = saturate(1.0 - (distSq / (range * range)));
					    falloff *= falloff;
					    if (falloff > 0)
					    {
					        float3 lDir = normalize(diff);
					        float nDotL = saturate(dot(N, lDir));
					        if (nDotL > 0)
					        {
					            float nDotH = saturate(dot(N, normalize(lDir + vDir)));
					            
					            // --- OPTIMIZED SPECULAR ---
					            float spec = exp2(shininess * (nDotH - 1.0)) * normalization;
					            
					            specAccum += lightColInt.rgb * (spec * nDotL * fresnel * falloff * lightColInt.w);
					        }
					    }
					}
					return specAccum * lmMask * SpecBoost;
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

					float2 texCoord2357_g59360 = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					float2 UV02420_g59360 = texCoord2357_g59360;
					float2 temp_output_5_0_g59438 = UV02420_g59360;
					float2 UV633_g59438 = temp_output_5_0_g59438;
					float2 UV100_g59439 = UV633_g59438;
					float2 temp_output_51_0_g59439 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59439 * float2( 3.464,3.464 ) ) );
					float2 break55_g59439 = frac( temp_output_51_0_g59439 );
					float temp_output_56_0_g59439 = ( ( 1.0 - break55_g59439.x ) - break55_g59439.y );
					float2 temp_output_52_0_g59439 = floor( temp_output_51_0_g59439 );
					float2 temp_output_125_0_g59439 = ( temp_output_52_0_g59439 + float2( 1,1 ) );
					float2 ifLocalVar87_g59439 = 0;
					if( temp_output_56_0_g59439 > 0.0 )
					ifLocalVar87_g59439 = temp_output_52_0_g59439;
					else if( temp_output_56_0_g59439 == 0.0 )
					ifLocalVar87_g59439 = temp_output_125_0_g59439;
					else if( temp_output_56_0_g59439 < 0.0 )
					ifLocalVar87_g59439 = temp_output_125_0_g59439;
					float3 temp_output_7_0_g59440 = frac( ( (ifLocalVar87_g59439).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59440 = dot( temp_output_7_0_g59440 , ( (temp_output_7_0_g59440).yzx + 33.33 ) );
					float3 temp_output_12_0_g59440 = ( temp_output_7_0_g59440 + dotResult8_g59440 );
					float2 temp_output_597_0_g59438 = ( UV100_g59439 + frac( ( ( (temp_output_12_0_g59440).xx + (temp_output_12_0_g59440).yz ) * (temp_output_12_0_g59440).zy ) ) );
					float2 DDX631_g59438 = ddx( temp_output_5_0_g59438 );
					float2 DDY632_g59438 = ddy( temp_output_5_0_g59438 );
					float temp_output_65_0_g59439 = ( 0.0 - temp_output_56_0_g59439 );
					float ifLocalVar59_g59439 = 0;
					if( temp_output_56_0_g59439 <= 0.0 )
					ifLocalVar59_g59439 = temp_output_65_0_g59439;
					else
					ifLocalVar59_g59439 = temp_output_56_0_g59439;
					float temp_output_597_30_g59438 = ifLocalVar59_g59439;
					float2 temp_output_90_0_g59439 = ( temp_output_52_0_g59439 + float2( 0,1 ) );
					float2 temp_output_123_0_g59439 = ( temp_output_52_0_g59439 + float2( 1,0 ) );
					float2 ifLocalVar88_g59439 = 0;
					if( temp_output_56_0_g59439 > 0.0 )
					ifLocalVar88_g59439 = temp_output_90_0_g59439;
					else if( temp_output_56_0_g59439 == 0.0 )
					ifLocalVar88_g59439 = temp_output_123_0_g59439;
					else if( temp_output_56_0_g59439 < 0.0 )
					ifLocalVar88_g59439 = temp_output_123_0_g59439;
					float3 temp_output_7_0_g59441 = frac( ( (ifLocalVar88_g59439).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59441 = dot( temp_output_7_0_g59441 , ( (temp_output_7_0_g59441).yzx + 33.33 ) );
					float3 temp_output_12_0_g59441 = ( temp_output_7_0_g59441 + dotResult8_g59441 );
					float2 temp_output_597_26_g59438 = ( UV100_g59439 + frac( ( ( (temp_output_12_0_g59441).xx + (temp_output_12_0_g59441).yz ) * (temp_output_12_0_g59441).zy ) ) );
					float temp_output_66_0_g59439 = ( 1.0 - break55_g59439.y );
					float ifLocalVar60_g59439 = 0;
					if( temp_output_56_0_g59439 <= 0.0 )
					ifLocalVar60_g59439 = temp_output_66_0_g59439;
					else
					ifLocalVar60_g59439 = break55_g59439.y;
					float temp_output_597_28_g59438 = ifLocalVar60_g59439;
					float2 ifLocalVar89_g59439 = 0;
					if( temp_output_56_0_g59439 > 0.0 )
					ifLocalVar89_g59439 = temp_output_123_0_g59439;
					else if( temp_output_56_0_g59439 == 0.0 )
					ifLocalVar89_g59439 = temp_output_90_0_g59439;
					else if( temp_output_56_0_g59439 < 0.0 )
					ifLocalVar89_g59439 = temp_output_90_0_g59439;
					float3 temp_output_7_0_g59442 = frac( ( (ifLocalVar89_g59439).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59442 = dot( temp_output_7_0_g59442 , ( (temp_output_7_0_g59442).yzx + 33.33 ) );
					float3 temp_output_12_0_g59442 = ( temp_output_7_0_g59442 + dotResult8_g59442 );
					float2 temp_output_597_27_g59438 = ( UV100_g59439 + frac( ( ( (temp_output_12_0_g59442).xx + (temp_output_12_0_g59442).yz ) * (temp_output_12_0_g59442).zy ) ) );
					float temp_output_67_0_g59439 = ( 1.0 - break55_g59439.x );
					float ifLocalVar61_g59439 = 0;
					if( temp_output_56_0_g59439 <= 0.0 )
					ifLocalVar61_g59439 = temp_output_67_0_g59439;
					else
					ifLocalVar61_g59439 = break55_g59439.x;
					float temp_output_597_29_g59438 = ifLocalVar61_g59439;
					float4 Output_2D293_g59438 = ( ( tex2D( _MainTex, temp_output_597_0_g59438, DDX631_g59438, DDY632_g59438 ) * temp_output_597_30_g59438 ) + ( tex2D( _MainTex, temp_output_597_26_g59438, DDX631_g59438, DDY632_g59438 ) * temp_output_597_28_g59438 ) + ( tex2D( _MainTex, temp_output_597_27_g59438, DDX631_g59438, DDY632_g59438 ) * temp_output_597_29_g59438 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g59360 = Output_2D293_g59438;
					#else
					float4 staticSwitch1001_g59360 = tex2D( _MainTex, UV02420_g59360 );
					#endif
					#ifdef _MAINTEX
					float4 staticSwitch1549_g59360 = staticSwitch1001_g59360;
					#else
					float4 staticSwitch1549_g59360 = _Color;
					#endif
					float4 oAlbedo6_g59360 = staticSwitch1549_g59360;
					float Black1185_g59360 = 0.0;
					float4 temp_cast_0 = (Black1185_g59360).xxxx;
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1180_g59360 = temp_cast_0;
					#else
					float4 staticSwitch1180_g59360 = oAlbedo6_g59360;
					#endif
					
					float2 temp_output_5_0_g59366 = UV02420_g59360;
					float2 UV633_g59366 = temp_output_5_0_g59366;
					float2 UV100_g59367 = UV633_g59366;
					float2 temp_output_51_0_g59367 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59367 * float2( 3.464,3.464 ) ) );
					float2 break55_g59367 = frac( temp_output_51_0_g59367 );
					float temp_output_56_0_g59367 = ( ( 1.0 - break55_g59367.x ) - break55_g59367.y );
					float2 temp_output_52_0_g59367 = floor( temp_output_51_0_g59367 );
					float2 temp_output_125_0_g59367 = ( temp_output_52_0_g59367 + float2( 1,1 ) );
					float2 ifLocalVar87_g59367 = 0;
					if( temp_output_56_0_g59367 > 0.0 )
					ifLocalVar87_g59367 = temp_output_52_0_g59367;
					else if( temp_output_56_0_g59367 == 0.0 )
					ifLocalVar87_g59367 = temp_output_125_0_g59367;
					else if( temp_output_56_0_g59367 < 0.0 )
					ifLocalVar87_g59367 = temp_output_125_0_g59367;
					float3 temp_output_7_0_g59368 = frac( ( (ifLocalVar87_g59367).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59368 = dot( temp_output_7_0_g59368 , ( (temp_output_7_0_g59368).yzx + 33.33 ) );
					float3 temp_output_12_0_g59368 = ( temp_output_7_0_g59368 + dotResult8_g59368 );
					float2 temp_output_597_0_g59366 = ( UV100_g59367 + frac( ( ( (temp_output_12_0_g59368).xx + (temp_output_12_0_g59368).yz ) * (temp_output_12_0_g59368).zy ) ) );
					float2 DDX631_g59366 = ddx( temp_output_5_0_g59366 );
					float2 DDY632_g59366 = ddy( temp_output_5_0_g59366 );
					float temp_output_65_0_g59367 = ( 0.0 - temp_output_56_0_g59367 );
					float ifLocalVar59_g59367 = 0;
					if( temp_output_56_0_g59367 <= 0.0 )
					ifLocalVar59_g59367 = temp_output_65_0_g59367;
					else
					ifLocalVar59_g59367 = temp_output_56_0_g59367;
					float temp_output_597_30_g59366 = ifLocalVar59_g59367;
					float2 temp_output_90_0_g59367 = ( temp_output_52_0_g59367 + float2( 0,1 ) );
					float2 temp_output_123_0_g59367 = ( temp_output_52_0_g59367 + float2( 1,0 ) );
					float2 ifLocalVar88_g59367 = 0;
					if( temp_output_56_0_g59367 > 0.0 )
					ifLocalVar88_g59367 = temp_output_90_0_g59367;
					else if( temp_output_56_0_g59367 == 0.0 )
					ifLocalVar88_g59367 = temp_output_123_0_g59367;
					else if( temp_output_56_0_g59367 < 0.0 )
					ifLocalVar88_g59367 = temp_output_123_0_g59367;
					float3 temp_output_7_0_g59369 = frac( ( (ifLocalVar88_g59367).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59369 = dot( temp_output_7_0_g59369 , ( (temp_output_7_0_g59369).yzx + 33.33 ) );
					float3 temp_output_12_0_g59369 = ( temp_output_7_0_g59369 + dotResult8_g59369 );
					float2 temp_output_597_26_g59366 = ( UV100_g59367 + frac( ( ( (temp_output_12_0_g59369).xx + (temp_output_12_0_g59369).yz ) * (temp_output_12_0_g59369).zy ) ) );
					float temp_output_66_0_g59367 = ( 1.0 - break55_g59367.y );
					float ifLocalVar60_g59367 = 0;
					if( temp_output_56_0_g59367 <= 0.0 )
					ifLocalVar60_g59367 = temp_output_66_0_g59367;
					else
					ifLocalVar60_g59367 = break55_g59367.y;
					float temp_output_597_28_g59366 = ifLocalVar60_g59367;
					float2 ifLocalVar89_g59367 = 0;
					if( temp_output_56_0_g59367 > 0.0 )
					ifLocalVar89_g59367 = temp_output_123_0_g59367;
					else if( temp_output_56_0_g59367 == 0.0 )
					ifLocalVar89_g59367 = temp_output_90_0_g59367;
					else if( temp_output_56_0_g59367 < 0.0 )
					ifLocalVar89_g59367 = temp_output_90_0_g59367;
					float3 temp_output_7_0_g59370 = frac( ( (ifLocalVar89_g59367).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59370 = dot( temp_output_7_0_g59370 , ( (temp_output_7_0_g59370).yzx + 33.33 ) );
					float3 temp_output_12_0_g59370 = ( temp_output_7_0_g59370 + dotResult8_g59370 );
					float2 temp_output_597_27_g59366 = ( UV100_g59367 + frac( ( ( (temp_output_12_0_g59370).xx + (temp_output_12_0_g59370).yz ) * (temp_output_12_0_g59370).zy ) ) );
					float temp_output_67_0_g59367 = ( 1.0 - break55_g59367.x );
					float ifLocalVar61_g59367 = 0;
					if( temp_output_56_0_g59367 <= 0.0 )
					ifLocalVar61_g59367 = temp_output_67_0_g59367;
					else
					ifLocalVar61_g59367 = break55_g59367.x;
					float temp_output_597_29_g59366 = ifLocalVar61_g59367;
					float4 Output_2D293_g59366 = ( ( tex2D( _MetallicMap, temp_output_597_0_g59366, DDX631_g59366, DDY632_g59366 ) * temp_output_597_30_g59366 ) + ( tex2D( _MetallicMap, temp_output_597_26_g59366, DDX631_g59366, DDY632_g59366 ) * temp_output_597_28_g59366 ) + ( tex2D( _MetallicMap, temp_output_597_27_g59366, DDX631_g59366, DDY632_g59366 ) * temp_output_597_29_g59366 ) );
					float4 break31_g59366 = Output_2D293_g59366;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g59360 = break31_g59366.a;
					#else
					float staticSwitch1005_g59360 = tex2D( _MetallicMap, UV02420_g59360 ).a;
					#endif
					#ifdef _METALLICMAP
					float staticSwitch846_g59360 = staticSwitch1005_g59360;
					#else
					float staticSwitch846_g59360 = _Metallic;
					#endif
					float Metallic1239_g59360 = staticSwitch846_g59360;
					float4 aAlbedo1466_g59360 = ( staticSwitch1549_g59360 * ( 1.0 - Metallic1239_g59360 ) );
					float White38_g59360 = 1.0;
					float4 temp_cast_2 = (White38_g59360).xxxx;
					float4 texCoord2426_g59360 = IN.ase_texcoord6;
					texCoord2426_g59360.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					float2 UV12361_g59360 = (texCoord2426_g59360).zw;
					float localBicubicPrepare2_g59432 = ( 0.0 );
					float2 Input_UV100_g59432 = UV12361_g59360;
					float2 UV2_g59432 = Input_UV100_g59432;
					float4 TexelSize2_g59432 = _Lightmap0_TexelSize;
					float2 UV02_g59432 = float2( 0,0 );
					float2 UV12_g59432 = float2( 0,0 );
					float2 UV22_g59432 = float2( 0,0 );
					float2 UV32_g59432 = float2( 0,0 );
					float W02_g59432 = 0;
					float W12_g59432 = 0;
					{
					{
					 UV2_g59432 = UV2_g59432 * TexelSize2_g59432.zw - 0.5;
					    float2 f = frac( UV2_g59432 );
					    UV2_g59432 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59432.x - 0.5, UV2_g59432.x + 1.5, UV2_g59432.y - 0.5, UV2_g59432.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59432.xyxy;
					    UV02_g59432 = off.xz;
					    UV12_g59432 = off.yz;
					    UV22_g59432 = off.xw;
					    UV32_g59432 = off.yw;
					    W02_g59432 = s.x / ( s.x + s.y );
					 W12_g59432 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59432 = lerp( tex2D( _Lightmap0, UV32_g59432 ) , tex2D( _Lightmap0, UV22_g59432 ) , W02_g59432);
					float4 lerpResult45_g59432 = lerp( tex2D( _Lightmap0, UV12_g59432 ) , tex2D( _Lightmap0, UV02_g59432 ) , W02_g59432);
					float4 lerpResult44_g59432 = lerp( lerpResult46_g59432 , lerpResult45_g59432 , W12_g59432);
					float4 Output_2D_Auto131_g59432 = lerpResult44_g59432;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g59360 = Output_2D_Auto131_g59432;
					#else
					float4 staticSwitch1092_g59360 = tex2D( _Lightmap0, UV12361_g59360 );
					#endif
					float4 Lightmap_0925_g59360 = staticSwitch1092_g59360;
					float localBicubicPrepare2_g59430 = ( 0.0 );
					float2 Input_UV100_g59430 = UV12361_g59360;
					float2 UV2_g59430 = Input_UV100_g59430;
					float4 TexelSize2_g59430 = _Lightmap1_TexelSize;
					float2 UV02_g59430 = float2( 0,0 );
					float2 UV12_g59430 = float2( 0,0 );
					float2 UV22_g59430 = float2( 0,0 );
					float2 UV32_g59430 = float2( 0,0 );
					float W02_g59430 = 0;
					float W12_g59430 = 0;
					{
					{
					 UV2_g59430 = UV2_g59430 * TexelSize2_g59430.zw - 0.5;
					    float2 f = frac( UV2_g59430 );
					    UV2_g59430 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59430.x - 0.5, UV2_g59430.x + 1.5, UV2_g59430.y - 0.5, UV2_g59430.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59430.xyxy;
					    UV02_g59430 = off.xz;
					    UV12_g59430 = off.yz;
					    UV22_g59430 = off.xw;
					    UV32_g59430 = off.yw;
					    W02_g59430 = s.x / ( s.x + s.y );
					 W12_g59430 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59430 = lerp( tex2D( _Lightmap1, UV32_g59430 ) , tex2D( _Lightmap1, UV22_g59430 ) , W02_g59430);
					float4 lerpResult45_g59430 = lerp( tex2D( _Lightmap1, UV12_g59430 ) , tex2D( _Lightmap1, UV02_g59430 ) , W02_g59430);
					float4 lerpResult44_g59430 = lerp( lerpResult46_g59430 , lerpResult45_g59430 , W12_g59430);
					float4 Output_2D_Auto131_g59430 = lerpResult44_g59430;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g59360 = Output_2D_Auto131_g59430;
					#else
					float4 staticSwitch1088_g59360 = tex2D( _Lightmap1, UV12361_g59360 );
					#endif
					float4 Lightmap_1956_g59360 = staticSwitch1088_g59360;
					float4 lerpResult442_g59360 = lerp( Lightmap_0925_g59360 , Lightmap_1956_g59360 , _LIGHTMAPLERP);
					float4 Lightmap_Lerp932_g59360 = lerpResult442_g59360;
					float3 appendResult139_g59396 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float2 temp_output_5_0_g59361 = UV02420_g59360;
					float2 UV633_g59361 = temp_output_5_0_g59361;
					float2 UV100_g59362 = UV633_g59361;
					float2 temp_output_51_0_g59362 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59362 * float2( 3.464,3.464 ) ) );
					float2 break55_g59362 = frac( temp_output_51_0_g59362 );
					float temp_output_56_0_g59362 = ( ( 1.0 - break55_g59362.x ) - break55_g59362.y );
					float2 temp_output_52_0_g59362 = floor( temp_output_51_0_g59362 );
					float2 temp_output_125_0_g59362 = ( temp_output_52_0_g59362 + float2( 1,1 ) );
					float2 ifLocalVar87_g59362 = 0;
					if( temp_output_56_0_g59362 > 0.0 )
					ifLocalVar87_g59362 = temp_output_52_0_g59362;
					else if( temp_output_56_0_g59362 == 0.0 )
					ifLocalVar87_g59362 = temp_output_125_0_g59362;
					else if( temp_output_56_0_g59362 < 0.0 )
					ifLocalVar87_g59362 = temp_output_125_0_g59362;
					float3 temp_output_7_0_g59363 = frac( ( (ifLocalVar87_g59362).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59363 = dot( temp_output_7_0_g59363 , ( (temp_output_7_0_g59363).yzx + 33.33 ) );
					float3 temp_output_12_0_g59363 = ( temp_output_7_0_g59363 + dotResult8_g59363 );
					float2 temp_output_597_0_g59361 = ( UV100_g59362 + frac( ( ( (temp_output_12_0_g59363).xx + (temp_output_12_0_g59363).yz ) * (temp_output_12_0_g59363).zy ) ) );
					float2 DDX631_g59361 = ddx( temp_output_5_0_g59361 );
					float2 DDY632_g59361 = ddy( temp_output_5_0_g59361 );
					float Input_Scale617_g59361 = _NormalScale;
					float temp_output_65_0_g59362 = ( 0.0 - temp_output_56_0_g59362 );
					float ifLocalVar59_g59362 = 0;
					if( temp_output_56_0_g59362 <= 0.0 )
					ifLocalVar59_g59362 = temp_output_65_0_g59362;
					else
					ifLocalVar59_g59362 = temp_output_56_0_g59362;
					float temp_output_597_30_g59361 = ifLocalVar59_g59362;
					float2 temp_output_90_0_g59362 = ( temp_output_52_0_g59362 + float2( 0,1 ) );
					float2 temp_output_123_0_g59362 = ( temp_output_52_0_g59362 + float2( 1,0 ) );
					float2 ifLocalVar88_g59362 = 0;
					if( temp_output_56_0_g59362 > 0.0 )
					ifLocalVar88_g59362 = temp_output_90_0_g59362;
					else if( temp_output_56_0_g59362 == 0.0 )
					ifLocalVar88_g59362 = temp_output_123_0_g59362;
					else if( temp_output_56_0_g59362 < 0.0 )
					ifLocalVar88_g59362 = temp_output_123_0_g59362;
					float3 temp_output_7_0_g59364 = frac( ( (ifLocalVar88_g59362).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59364 = dot( temp_output_7_0_g59364 , ( (temp_output_7_0_g59364).yzx + 33.33 ) );
					float3 temp_output_12_0_g59364 = ( temp_output_7_0_g59364 + dotResult8_g59364 );
					float2 temp_output_597_26_g59361 = ( UV100_g59362 + frac( ( ( (temp_output_12_0_g59364).xx + (temp_output_12_0_g59364).yz ) * (temp_output_12_0_g59364).zy ) ) );
					float temp_output_66_0_g59362 = ( 1.0 - break55_g59362.y );
					float ifLocalVar60_g59362 = 0;
					if( temp_output_56_0_g59362 <= 0.0 )
					ifLocalVar60_g59362 = temp_output_66_0_g59362;
					else
					ifLocalVar60_g59362 = break55_g59362.y;
					float temp_output_597_28_g59361 = ifLocalVar60_g59362;
					float2 ifLocalVar89_g59362 = 0;
					if( temp_output_56_0_g59362 > 0.0 )
					ifLocalVar89_g59362 = temp_output_123_0_g59362;
					else if( temp_output_56_0_g59362 == 0.0 )
					ifLocalVar89_g59362 = temp_output_90_0_g59362;
					else if( temp_output_56_0_g59362 < 0.0 )
					ifLocalVar89_g59362 = temp_output_90_0_g59362;
					float3 temp_output_7_0_g59365 = frac( ( (ifLocalVar89_g59362).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59365 = dot( temp_output_7_0_g59365 , ( (temp_output_7_0_g59365).yzx + 33.33 ) );
					float3 temp_output_12_0_g59365 = ( temp_output_7_0_g59365 + dotResult8_g59365 );
					float2 temp_output_597_27_g59361 = ( UV100_g59362 + frac( ( ( (temp_output_12_0_g59365).xx + (temp_output_12_0_g59365).yz ) * (temp_output_12_0_g59365).zy ) ) );
					float temp_output_67_0_g59362 = ( 1.0 - break55_g59362.x );
					float ifLocalVar61_g59362 = 0;
					if( temp_output_56_0_g59362 <= 0.0 )
					ifLocalVar61_g59362 = temp_output_67_0_g59362;
					else
					ifLocalVar61_g59362 = break55_g59362.x;
					float temp_output_597_29_g59361 = ifLocalVar61_g59362;
					float3 Output_2D_Normal641_g59361 = ( ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_0_g59361, DDX631_g59361, DDY632_g59361 ), Input_Scale617_g59361 ) * temp_output_597_30_g59361 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_26_g59361, DDX631_g59361, DDY632_g59361 ), Input_Scale617_g59361 ) * temp_output_597_28_g59361 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_27_g59361, DDX631_g59361, DDY632_g59361 ), Input_Scale617_g59361 ) * float3( 0,0,0 ) * temp_output_597_29_g59361 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g59360 = Output_2D_Normal641_g59361;
					#else
					float3 staticSwitch1003_g59360 = UnpackScaleNormal( tex2D( _BumpMap, UV02420_g59360 ), _NormalScale );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g59360 = staticSwitch1003_g59360;
					#else
					float3 staticSwitch980_g59360 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g59360 = staticSwitch980_g59360;
					float3 normalizeResult326_g59396 = normalize( Normal_Map700_g59360 );
					float3 Normal_Map318_g59396 = normalizeResult326_g59396;
					float dotResult121_g59396 = dot( appendResult139_g59396 , Normal_Map318_g59396 );
					float temp_output_2_0_g59399 = saturate( dotResult121_g59396 );
					float localStochasticTiling2_g59434 = ( 0.0 );
					float2 UV2_g59434 = UV12361_g59360;
					float4 TexelSize2_g59434 = _RNMX0_TexelSize;
					float4 Offsets2_g59434 = float4( 0,0,0,0 );
					float2 Weights2_g59434 = float2( 0,0 );
					{
					UV2_g59434 = UV2_g59434 * TexelSize2_g59434.zw - 0.5;
					float2 f = frac( UV2_g59434 );
					UV2_g59434 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g59434.x - 0.5, UV2_g59434.x + 1.5, UV2_g59434.y - 0.5, UV2_g59434.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g59434 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59434.xyxy;
					Weights2_g59434 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g59433 = Offsets2_g59434;
					float4 Input_FetchOffsets197_g59435 = temp_output_1_34_g59433;
					float2 temp_output_1_54_g59433 = Weights2_g59434;
					float2 Input_FetchWeights200_g59435 = temp_output_1_54_g59433;
					float2 break187_g59435 = Input_FetchWeights200_g59435;
					float4 lerpResult181_g59435 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g59435).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g59435).xw ) , break187_g59435.x);
					float4 lerpResult182_g59435 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g59435).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g59435).xz ) , break187_g59435.x);
					float4 lerpResult176_g59435 = lerp( lerpResult181_g59435 , lerpResult182_g59435 , break187_g59435.y);
					float4 Output_Fetch2D_Auto202_g59435 = lerpResult176_g59435;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g59360 = Output_Fetch2D_Auto202_g59435;
					#else
					float4 staticSwitch1061_g59360 = tex2D( _RNMX0, UV12361_g59360 );
					#endif
					float3 appendResult146_g59396 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59396 = dot( appendResult146_g59396 , Normal_Map318_g59396 );
					float temp_output_2_0_g59398 = saturate( dotResult122_g59396 );
					float4 Input_FetchOffsets197_g59436 = temp_output_1_34_g59433;
					float2 Input_FetchWeights200_g59436 = temp_output_1_54_g59433;
					float2 break187_g59436 = Input_FetchWeights200_g59436;
					float4 lerpResult181_g59436 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g59436).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g59436).xw ) , break187_g59436.x);
					float4 lerpResult182_g59436 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g59436).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g59436).xz ) , break187_g59436.x);
					float4 lerpResult176_g59436 = lerp( lerpResult181_g59436 , lerpResult182_g59436 , break187_g59436.y);
					float4 Output_Fetch2D_Auto202_g59436 = lerpResult176_g59436;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g59360 = Output_Fetch2D_Auto202_g59436;
					#else
					float4 staticSwitch1062_g59360 = tex2D( _RNMY0, UV12361_g59360 );
					#endif
					float3 appendResult149_g59396 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59396 = dot( appendResult149_g59396 , Normal_Map318_g59396 );
					float temp_output_2_0_g59397 = saturate( dotResult120_g59396 );
					float4 Input_FetchOffsets197_g59437 = temp_output_1_34_g59433;
					float2 Input_FetchWeights200_g59437 = temp_output_1_54_g59433;
					float2 break187_g59437 = Input_FetchWeights200_g59437;
					float4 lerpResult181_g59437 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g59437).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g59437).xw ) , break187_g59437.x);
					float4 lerpResult182_g59437 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g59437).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g59437).xz ) , break187_g59437.x);
					float4 lerpResult176_g59437 = lerp( lerpResult181_g59437 , lerpResult182_g59437 , break187_g59437.y);
					float4 Output_Fetch2D_Auto202_g59437 = lerpResult176_g59437;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g59360 = Output_Fetch2D_Auto202_g59437;
					#else
					float4 staticSwitch1063_g59360 = tex2D( _RNMZ0, UV12361_g59360 );
					#endif
					float4 RNM_0926_g59360 = ( ( ( ( temp_output_2_0_g59399 * temp_output_2_0_g59399 ) * staticSwitch1061_g59360 ) + ( ( temp_output_2_0_g59398 * temp_output_2_0_g59398 ) * staticSwitch1062_g59360 ) ) + ( ( temp_output_2_0_g59397 * temp_output_2_0_g59397 ) * staticSwitch1063_g59360 ) );
					float3 appendResult139_g59392 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g59392 = normalize( Normal_Map700_g59360 );
					float3 Normal_Map318_g59392 = normalizeResult326_g59392;
					float dotResult121_g59392 = dot( appendResult139_g59392 , Normal_Map318_g59392 );
					float temp_output_2_0_g59395 = saturate( dotResult121_g59392 );
					float localStochasticTiling2_g59425 = ( 0.0 );
					float2 UV2_g59425 = float2( 0,0 );
					float4 TexelSize2_g59425 = _RNMX1_TexelSize;
					float4 Offsets2_g59425 = float4( 0,0,0,0 );
					float2 Weights2_g59425 = float2( 0,0 );
					{
					UV2_g59425 = UV2_g59425 * TexelSize2_g59425.zw - 0.5;
					float2 f = frac( UV2_g59425 );
					UV2_g59425 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g59425.x - 0.5, UV2_g59425.x + 1.5, UV2_g59425.y - 0.5, UV2_g59425.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g59425 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59425.xyxy;
					Weights2_g59425 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g59424 = Offsets2_g59425;
					float4 Input_FetchOffsets197_g59426 = temp_output_1_34_g59424;
					float2 temp_output_1_54_g59424 = Weights2_g59425;
					float2 Input_FetchWeights200_g59426 = temp_output_1_54_g59424;
					float2 break187_g59426 = Input_FetchWeights200_g59426;
					float4 lerpResult181_g59426 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g59426).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g59426).xw ) , break187_g59426.x);
					float4 lerpResult182_g59426 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g59426).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g59426).xz ) , break187_g59426.x);
					float4 lerpResult176_g59426 = lerp( lerpResult181_g59426 , lerpResult182_g59426 , break187_g59426.y);
					float4 Output_Fetch2D_Auto202_g59426 = lerpResult176_g59426;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g59360 = Output_Fetch2D_Auto202_g59426;
					#else
					float4 staticSwitch1087_g59360 = tex2D( _RNMX1, UV12361_g59360 );
					#endif
					float3 appendResult146_g59392 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59392 = dot( appendResult146_g59392 , Normal_Map318_g59392 );
					float temp_output_2_0_g59394 = saturate( dotResult122_g59392 );
					float4 Input_FetchOffsets197_g59427 = temp_output_1_34_g59424;
					float2 Input_FetchWeights200_g59427 = temp_output_1_54_g59424;
					float2 break187_g59427 = Input_FetchWeights200_g59427;
					float4 lerpResult181_g59427 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g59427).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g59427).xw ) , break187_g59427.x);
					float4 lerpResult182_g59427 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g59427).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g59427).xz ) , break187_g59427.x);
					float4 lerpResult176_g59427 = lerp( lerpResult181_g59427 , lerpResult182_g59427 , break187_g59427.y);
					float4 Output_Fetch2D_Auto202_g59427 = lerpResult176_g59427;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g59360 = Output_Fetch2D_Auto202_g59427;
					#else
					float4 staticSwitch1083_g59360 = tex2D( _RNMY1, UV12361_g59360 );
					#endif
					float3 appendResult149_g59392 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59392 = dot( appendResult149_g59392 , Normal_Map318_g59392 );
					float temp_output_2_0_g59393 = saturate( dotResult120_g59392 );
					float4 Input_FetchOffsets197_g59428 = temp_output_1_34_g59424;
					float2 Input_FetchWeights200_g59428 = temp_output_1_54_g59424;
					float2 break187_g59428 = Input_FetchWeights200_g59428;
					float4 lerpResult181_g59428 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g59428).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g59428).xw ) , break187_g59428.x);
					float4 lerpResult182_g59428 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g59428).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g59428).xz ) , break187_g59428.x);
					float4 lerpResult176_g59428 = lerp( lerpResult181_g59428 , lerpResult182_g59428 , break187_g59428.y);
					float4 Output_Fetch2D_Auto202_g59428 = lerpResult176_g59428;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g59360 = Output_Fetch2D_Auto202_g59428;
					#else
					float4 staticSwitch1084_g59360 = tex2D( _RNMZ1, UV12361_g59360 );
					#endif
					float4 RNM_11081_g59360 = ( ( ( ( temp_output_2_0_g59395 * temp_output_2_0_g59395 ) * staticSwitch1087_g59360 ) + ( ( temp_output_2_0_g59394 * temp_output_2_0_g59394 ) * staticSwitch1083_g59360 ) ) + ( ( temp_output_2_0_g59393 * temp_output_2_0_g59393 ) * staticSwitch1084_g59360 ) );
					float Lightmap_Lerp_Value969_g59360 = _LIGHTMAPLERP;
					float4 lerpResult953_g59360 = lerp( RNM_0926_g59360 , RNM_11081_g59360 , Lightmap_Lerp_Value969_g59360);
					float4 RNM_Lerp950_g59360 = lerpResult953_g59360;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g59360 = temp_cast_2;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g59360 = Lightmap_0925_g59360;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g59360 = Lightmap_Lerp932_g59360;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g59360 = RNM_0926_g59360;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g59360 = RNM_Lerp950_g59360;
					#else
					float4 staticSwitch1014_g59360 = temp_cast_2;
					#endif
					float4 Lightmap46_g59360 = staticSwitch1014_g59360;
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal1392_g59360 = Normal_Map700_g59360;
					float2 temp_output_5_0_g59378 = UV02420_g59360;
					float2 UV633_g59378 = temp_output_5_0_g59378;
					float2 UV100_g59379 = UV633_g59378;
					float2 temp_output_51_0_g59379 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59379 * float2( 3.464,3.464 ) ) );
					float2 break55_g59379 = frac( temp_output_51_0_g59379 );
					float temp_output_56_0_g59379 = ( ( 1.0 - break55_g59379.x ) - break55_g59379.y );
					float2 temp_output_52_0_g59379 = floor( temp_output_51_0_g59379 );
					float2 temp_output_125_0_g59379 = ( temp_output_52_0_g59379 + float2( 1,1 ) );
					float2 ifLocalVar87_g59379 = 0;
					if( temp_output_56_0_g59379 > 0.0 )
					ifLocalVar87_g59379 = temp_output_52_0_g59379;
					else if( temp_output_56_0_g59379 == 0.0 )
					ifLocalVar87_g59379 = temp_output_125_0_g59379;
					else if( temp_output_56_0_g59379 < 0.0 )
					ifLocalVar87_g59379 = temp_output_125_0_g59379;
					float3 temp_output_7_0_g59380 = frac( ( (ifLocalVar87_g59379).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59380 = dot( temp_output_7_0_g59380 , ( (temp_output_7_0_g59380).yzx + 33.33 ) );
					float3 temp_output_12_0_g59380 = ( temp_output_7_0_g59380 + dotResult8_g59380 );
					float2 temp_output_597_0_g59378 = ( UV100_g59379 + frac( ( ( (temp_output_12_0_g59380).xx + (temp_output_12_0_g59380).yz ) * (temp_output_12_0_g59380).zy ) ) );
					float2 DDX631_g59378 = ddx( temp_output_5_0_g59378 );
					float2 DDY632_g59378 = ddy( temp_output_5_0_g59378 );
					float temp_output_65_0_g59379 = ( 0.0 - temp_output_56_0_g59379 );
					float ifLocalVar59_g59379 = 0;
					if( temp_output_56_0_g59379 <= 0.0 )
					ifLocalVar59_g59379 = temp_output_65_0_g59379;
					else
					ifLocalVar59_g59379 = temp_output_56_0_g59379;
					float temp_output_597_30_g59378 = ifLocalVar59_g59379;
					float2 temp_output_90_0_g59379 = ( temp_output_52_0_g59379 + float2( 0,1 ) );
					float2 temp_output_123_0_g59379 = ( temp_output_52_0_g59379 + float2( 1,0 ) );
					float2 ifLocalVar88_g59379 = 0;
					if( temp_output_56_0_g59379 > 0.0 )
					ifLocalVar88_g59379 = temp_output_90_0_g59379;
					else if( temp_output_56_0_g59379 == 0.0 )
					ifLocalVar88_g59379 = temp_output_123_0_g59379;
					else if( temp_output_56_0_g59379 < 0.0 )
					ifLocalVar88_g59379 = temp_output_123_0_g59379;
					float3 temp_output_7_0_g59381 = frac( ( (ifLocalVar88_g59379).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59381 = dot( temp_output_7_0_g59381 , ( (temp_output_7_0_g59381).yzx + 33.33 ) );
					float3 temp_output_12_0_g59381 = ( temp_output_7_0_g59381 + dotResult8_g59381 );
					float2 temp_output_597_26_g59378 = ( UV100_g59379 + frac( ( ( (temp_output_12_0_g59381).xx + (temp_output_12_0_g59381).yz ) * (temp_output_12_0_g59381).zy ) ) );
					float temp_output_66_0_g59379 = ( 1.0 - break55_g59379.y );
					float ifLocalVar60_g59379 = 0;
					if( temp_output_56_0_g59379 <= 0.0 )
					ifLocalVar60_g59379 = temp_output_66_0_g59379;
					else
					ifLocalVar60_g59379 = break55_g59379.y;
					float temp_output_597_28_g59378 = ifLocalVar60_g59379;
					float2 ifLocalVar89_g59379 = 0;
					if( temp_output_56_0_g59379 > 0.0 )
					ifLocalVar89_g59379 = temp_output_123_0_g59379;
					else if( temp_output_56_0_g59379 == 0.0 )
					ifLocalVar89_g59379 = temp_output_90_0_g59379;
					else if( temp_output_56_0_g59379 < 0.0 )
					ifLocalVar89_g59379 = temp_output_90_0_g59379;
					float3 temp_output_7_0_g59382 = frac( ( (ifLocalVar89_g59379).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59382 = dot( temp_output_7_0_g59382 , ( (temp_output_7_0_g59382).yzx + 33.33 ) );
					float3 temp_output_12_0_g59382 = ( temp_output_7_0_g59382 + dotResult8_g59382 );
					float2 temp_output_597_27_g59378 = ( UV100_g59379 + frac( ( ( (temp_output_12_0_g59382).xx + (temp_output_12_0_g59382).yz ) * (temp_output_12_0_g59382).zy ) ) );
					float temp_output_67_0_g59379 = ( 1.0 - break55_g59379.x );
					float ifLocalVar61_g59379 = 0;
					if( temp_output_56_0_g59379 <= 0.0 )
					ifLocalVar61_g59379 = temp_output_67_0_g59379;
					else
					ifLocalVar61_g59379 = break55_g59379.x;
					float temp_output_597_29_g59378 = ifLocalVar61_g59379;
					float4 Output_2D293_g59378 = ( ( tex2D( _GlossinessMap, temp_output_597_0_g59378, DDX631_g59378, DDY632_g59378 ) * temp_output_597_30_g59378 ) + ( tex2D( _GlossinessMap, temp_output_597_26_g59378, DDX631_g59378, DDY632_g59378 ) * temp_output_597_28_g59378 ) + ( tex2D( _GlossinessMap, temp_output_597_27_g59378, DDX631_g59378, DDY632_g59378 ) * temp_output_597_29_g59378 ) );
					float4 break31_g59378 = Output_2D293_g59378;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g59360 = break31_g59378.a;
					#else
					float staticSwitch1004_g59360 = tex2D( _GlossinessMap, UV02420_g59360 ).a;
					#endif
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g59360 = ( 1.0 - staticSwitch1004_g59360 );
					#else
					float staticSwitch845_g59360 = _Glossiness;
					#endif
					float3 temp_output_3_0_g59371 = ddx( NormalWS );
					float dotResult5_g59371 = dot( temp_output_3_0_g59371 , temp_output_3_0_g59371 );
					float3 temp_output_4_0_g59371 = ddy( NormalWS );
					float dotResult6_g59371 = dot( temp_output_4_0_g59371 , temp_output_4_0_g59371 );
					#ifdef _USEGEOMETRICANTIALIASING_ON
					float staticSwitch824_g59360 = min( staticSwitch845_g59360, ( 1.0 - pow( saturate( max( dotResult5_g59371, dotResult6_g59371 ) ) , 0.333 ) ) );
					#else
					float staticSwitch824_g59360 = staticSwitch845_g59360;
					#endif
					float Smoothness1399_g59360 = staticSwitch824_g59360;
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
					Unity_GlossyEnvironmentData g1392_g59360 = UnityGlossyEnvironmentSetup( Smoothness1399_g59360, ViewDirWS, float3( dot( tanToWorld0, tanNormal1392_g59360 ), dot( tanToWorld1, tanNormal1392_g59360 ), dot( tanToWorld2, tanNormal1392_g59360 ) ), float3(0,0,0));
					float3 indirectSpecular1392_g59360 = UnityGI_IndirectSpecular( data, 1.0, float3( dot( tanToWorld0, tanNormal1392_g59360 ), dot( tanToWorld1, tanNormal1392_g59360 ), dot( tanToWorld2, tanNormal1392_g59360 ) ), g1392_g59360 );
					float4 temp_cast_4 = (0.04).xxxx;
					float4 lerpResult1473_g59360 = lerp( temp_cast_4 , oAlbedo6_g59360 , Metallic1239_g59360);
					float3 switchResult1501_g59360 = (((ase_vface>0)?(NormalWS):(-NormalWS)));
					float dotResult1476_g59360 = dot( switchResult1501_g59360 , ViewDirWS );
					float4 lerpResult1480_g59360 = lerp( lerpResult1473_g59360 , float4( 1,1,1,0 ) , pow( ( 1.0 - saturate( dotResult1476_g59360 ) ) , 5.0 ));
					float4 Fresnel1560_g59360 = lerpResult1480_g59360;
					float4 temp_output_1481_0_g59360 = ( float4( indirectSpecular1392_g59360 , 0.0 ) * Fresnel1560_g59360 );
					#ifdef _USELIGHTMAPSPECULAR_ON
					float4 staticSwitch1469_g59360 = ( temp_output_1481_0_g59360 * sqrt( Lightmap46_g59360 ) );
					#else
					float4 staticSwitch1469_g59360 = temp_output_1481_0_g59360;
					#endif
					float4 Specular1419_g59360 = staticSwitch1469_g59360;
					float4 temp_cast_5 = 0;
					float2 temp_output_5_0_g59372 = UV02420_g59360;
					float2 UV633_g59372 = temp_output_5_0_g59372;
					float2 UV100_g59373 = UV633_g59372;
					float2 temp_output_51_0_g59373 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59373 * float2( 3.464,3.464 ) ) );
					float2 break55_g59373 = frac( temp_output_51_0_g59373 );
					float temp_output_56_0_g59373 = ( ( 1.0 - break55_g59373.x ) - break55_g59373.y );
					float2 temp_output_52_0_g59373 = floor( temp_output_51_0_g59373 );
					float2 temp_output_125_0_g59373 = ( temp_output_52_0_g59373 + float2( 1,1 ) );
					float2 ifLocalVar87_g59373 = 0;
					if( temp_output_56_0_g59373 > 0.0 )
					ifLocalVar87_g59373 = temp_output_52_0_g59373;
					else if( temp_output_56_0_g59373 == 0.0 )
					ifLocalVar87_g59373 = temp_output_125_0_g59373;
					else if( temp_output_56_0_g59373 < 0.0 )
					ifLocalVar87_g59373 = temp_output_125_0_g59373;
					float3 temp_output_7_0_g59374 = frac( ( (ifLocalVar87_g59373).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59374 = dot( temp_output_7_0_g59374 , ( (temp_output_7_0_g59374).yzx + 33.33 ) );
					float3 temp_output_12_0_g59374 = ( temp_output_7_0_g59374 + dotResult8_g59374 );
					float2 temp_output_597_0_g59372 = ( UV100_g59373 + frac( ( ( (temp_output_12_0_g59374).xx + (temp_output_12_0_g59374).yz ) * (temp_output_12_0_g59374).zy ) ) );
					float2 DDX631_g59372 = ddx( temp_output_5_0_g59372 );
					float2 DDY632_g59372 = ddy( temp_output_5_0_g59372 );
					float temp_output_65_0_g59373 = ( 0.0 - temp_output_56_0_g59373 );
					float ifLocalVar59_g59373 = 0;
					if( temp_output_56_0_g59373 <= 0.0 )
					ifLocalVar59_g59373 = temp_output_65_0_g59373;
					else
					ifLocalVar59_g59373 = temp_output_56_0_g59373;
					float temp_output_597_30_g59372 = ifLocalVar59_g59373;
					float2 temp_output_90_0_g59373 = ( temp_output_52_0_g59373 + float2( 0,1 ) );
					float2 temp_output_123_0_g59373 = ( temp_output_52_0_g59373 + float2( 1,0 ) );
					float2 ifLocalVar88_g59373 = 0;
					if( temp_output_56_0_g59373 > 0.0 )
					ifLocalVar88_g59373 = temp_output_90_0_g59373;
					else if( temp_output_56_0_g59373 == 0.0 )
					ifLocalVar88_g59373 = temp_output_123_0_g59373;
					else if( temp_output_56_0_g59373 < 0.0 )
					ifLocalVar88_g59373 = temp_output_123_0_g59373;
					float3 temp_output_7_0_g59375 = frac( ( (ifLocalVar88_g59373).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59375 = dot( temp_output_7_0_g59375 , ( (temp_output_7_0_g59375).yzx + 33.33 ) );
					float3 temp_output_12_0_g59375 = ( temp_output_7_0_g59375 + dotResult8_g59375 );
					float2 temp_output_597_26_g59372 = ( UV100_g59373 + frac( ( ( (temp_output_12_0_g59375).xx + (temp_output_12_0_g59375).yz ) * (temp_output_12_0_g59375).zy ) ) );
					float temp_output_66_0_g59373 = ( 1.0 - break55_g59373.y );
					float ifLocalVar60_g59373 = 0;
					if( temp_output_56_0_g59373 <= 0.0 )
					ifLocalVar60_g59373 = temp_output_66_0_g59373;
					else
					ifLocalVar60_g59373 = break55_g59373.y;
					float temp_output_597_28_g59372 = ifLocalVar60_g59373;
					float2 ifLocalVar89_g59373 = 0;
					if( temp_output_56_0_g59373 > 0.0 )
					ifLocalVar89_g59373 = temp_output_123_0_g59373;
					else if( temp_output_56_0_g59373 == 0.0 )
					ifLocalVar89_g59373 = temp_output_90_0_g59373;
					else if( temp_output_56_0_g59373 < 0.0 )
					ifLocalVar89_g59373 = temp_output_90_0_g59373;
					float3 temp_output_7_0_g59376 = frac( ( (ifLocalVar89_g59373).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59376 = dot( temp_output_7_0_g59376 , ( (temp_output_7_0_g59376).yzx + 33.33 ) );
					float3 temp_output_12_0_g59376 = ( temp_output_7_0_g59376 + dotResult8_g59376 );
					float2 temp_output_597_27_g59372 = ( UV100_g59373 + frac( ( ( (temp_output_12_0_g59376).xx + (temp_output_12_0_g59376).yz ) * (temp_output_12_0_g59376).zy ) ) );
					float temp_output_67_0_g59373 = ( 1.0 - break55_g59373.x );
					float ifLocalVar61_g59373 = 0;
					if( temp_output_56_0_g59373 <= 0.0 )
					ifLocalVar61_g59373 = temp_output_67_0_g59373;
					else
					ifLocalVar61_g59373 = break55_g59373.x;
					float temp_output_597_29_g59372 = ifLocalVar61_g59373;
					float4 Output_2D293_g59372 = ( ( tex2D( _EmissionMap, temp_output_597_0_g59372, DDX631_g59372, DDY632_g59372 ) * temp_output_597_30_g59372 ) + ( tex2D( _EmissionMap, temp_output_597_26_g59372, DDX631_g59372, DDY632_g59372 ) * temp_output_597_28_g59372 ) + ( tex2D( _EmissionMap, temp_output_597_27_g59372, DDX631_g59372, DDY632_g59372 ) * temp_output_597_29_g59372 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g59360 = Output_2D293_g59372;
					#else
					float4 staticSwitch1006_g59360 = tex2D( _EmissionMap, UV02420_g59360 );
					#endif
					#if defined( _SPECIALEFFECTS_DISABLED )
					float4 staticSwitch1578_g59360 = staticSwitch1006_g59360;
					#elif defined( _SPECIALEFFECTS_LED )
					float4 staticSwitch1578_g59360 = float4( 0,0,0,0 );
					#else
					float4 staticSwitch1578_g59360 = staticSwitch1006_g59360;
					#endif
					#ifdef _EMISSIONENABLED_ON
					float4 staticSwitch1017_g59360 = ( float4( _EmissionColor , 0.0 ) * staticSwitch1578_g59360 * _EmissionIntensity );
					#else
					float4 staticSwitch1017_g59360 = temp_cast_5;
					#endif
					float4 Emission86_g59360 = staticSwitch1017_g59360;
					float3 WorldPos97_g59385 = PositionWS;
					float3 tanNormal85_g59385 = Normal_Map700_g59360;
					float3 worldNormal85_g59385 = float3( dot( tanToWorld0, tanNormal85_g59385 ), dot( tanToWorld1, tanNormal85_g59385 ), dot( tanToWorld2, tanNormal85_g59385 ) );
					float3 WorldNormal97_g59385 = worldNormal85_g59385;
					float Smoothness97_g59385 = Smoothness1399_g59360;
					float3 LightmapColor97_g59385 = Lightmap46_g59360.rgb;
					float3 ViewDir97_g59385 = ViewDirWS;
					float3 localSpecular97_g59385 = Specular( WorldPos97_g59385 , WorldNormal97_g59385 , Smoothness97_g59385 , LightmapColor97_g59385 , ViewDir97_g59385 );
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1181_g59360 = Lightmap46_g59360;
					#else
					float4 staticSwitch1181_g59360 = ( ( aAlbedo1466_g59360 * Lightmap46_g59360 ) + Specular1419_g59360 + Emission86_g59360 + float4( localSpecular97_g59385 , 0.0 ) );
					#endif
					float4 temp_output_35_0_g59383 = staticSwitch1181_g59360;
					float4 Color353_g59383 = temp_output_35_0_g59383;
					#if defined( _LUTMODE_2D )
					float4 staticSwitch273_g59383 = saturate( temp_output_35_0_g59383 );
					#elif defined( _LUTMODE_3D )
					float4 staticSwitch273_g59383 = temp_output_35_0_g59383;
					#else
					float4 staticSwitch273_g59383 = temp_output_35_0_g59383;
					#endif
					float4 Color_Saturate49_g59383 = staticSwitch273_g59383;
					float Lut_Height213_g59383 = _LUTSize;
					float Lut_Width216_g59383 = ( _LUTSize * Lut_Height213_g59383 );
					float3 appendResult214_g59383 = (float3(( 1.0 / Lut_Width216_g59383 ) , ( 1.0 / Lut_Height213_g59383 ) , ( Lut_Height213_g59383 - 1.0 )));
					float3 Scale_Offset208_g59383 = appendResult214_g59383;
					float2 Scale_Factor292_g59383 = ( (Scale_Offset208_g59383).xy * (Scale_Offset208_g59383).z );
					float2 Offset299_g59383 = ( (Scale_Offset208_g59383).xy * 0.5 );
					float3 Adjusted_UV305_g59383 = ( ( (Color_Saturate49_g59383).xyw * float3( Scale_Factor292_g59383 ,  0.0 ) ) + float3( Offset299_g59383 ,  0.0 ) );
					float2 Scaled_Blue280_g59383 = ( (Color_Saturate49_g59383).zw * (Scale_Offset208_g59383).z );
					float2 Shift288_g59383 = floor( Scaled_Blue280_g59383 );
					float2 Final_X313_g59383 = ( (Adjusted_UV305_g59383).xz + ( Shift288_g59383 * (Scale_Offset208_g59383).y ) );
					float2 appendResult326_g59383 = (float2(Final_X313_g59383.x , (Adjusted_UV305_g59383).yz.x));
					float2 Final_UV325_g59383 = appendResult326_g59383;
					float2 appendResult338_g59383 = (float2((Scale_Offset208_g59383).y , 0.0));
					float2 Offset_UV336_g59383 = ( Final_UV325_g59383 + appendResult338_g59383 );
					float3 lerpResult333_g59383 = lerp( tex2D( _2DLut, Final_UV325_g59383 ).rgb , tex2D( _2DLut, Offset_UV336_g59383 ).rgb , float3( ( Scaled_Blue280_g59383 - Shift288_g59383 ) ,  0.0 ));
					#ifdef _2DLUT
					float4 staticSwitch347_g59383 = float4( lerpResult333_g59383 , 0.0 );
					#else
					float4 staticSwitch347_g59383 = Color_Saturate49_g59383;
					#endif
					float4 TwoD_LUT346_g59383 = staticSwitch347_g59383;
					float3 RGB16_g59384 = ( ( log10( ( ( Color_Saturate49_g59383.xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 );
					#ifdef _3DLUT
					float4 staticSwitch194_g59383 = tex3D( _3DLut, RGB16_g59384 );
					#else
					float4 staticSwitch194_g59383 = Color_Saturate49_g59383;
					#endif
					float4 ThreeD_LUT51_g59383 = staticSwitch194_g59383;
					#if defined( _LUTMODE_2D )
					float4 staticSwitch42_g59383 = TwoD_LUT346_g59383;
					#elif defined( _LUTMODE_3D )
					float4 staticSwitch42_g59383 = ThreeD_LUT51_g59383;
					#else
					float4 staticSwitch42_g59383 = ThreeD_LUT51_g59383;
					#endif
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch41_g59383 = staticSwitch42_g59383;
					#else
					float4 staticSwitch41_g59383 = Color353_g59383;
					#endif
					
					#ifdef _LIGHTMAPDEBUG
					float staticSwitch1191_g59360 = Black1185_g59360;
					#else
					float staticSwitch1191_g59360 = staticSwitch1549_g59360.a;
					#endif
					

					o.Albedo = staticSwitch1180_g59360.rgb;
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

					o.Emission = staticSwitch41_g59383.xyz;
					o.Alpha = staticSwitch1191_g59360;
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
				uniform float4 _UdonSpecularLightRight[32];
				uniform float4 _UdonSpecularLightCol[32];
				uniform float4 _UdonSpecularLightPos[32];
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

					float2 texCoord2357_g59360 = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
					float2 UV02420_g59360 = texCoord2357_g59360;
					float2 temp_output_5_0_g59438 = UV02420_g59360;
					float2 UV633_g59438 = temp_output_5_0_g59438;
					float2 UV100_g59439 = UV633_g59438;
					float2 temp_output_51_0_g59439 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59439 * float2( 3.464,3.464 ) ) );
					float2 break55_g59439 = frac( temp_output_51_0_g59439 );
					float temp_output_56_0_g59439 = ( ( 1.0 - break55_g59439.x ) - break55_g59439.y );
					float2 temp_output_52_0_g59439 = floor( temp_output_51_0_g59439 );
					float2 temp_output_125_0_g59439 = ( temp_output_52_0_g59439 + float2( 1,1 ) );
					float2 ifLocalVar87_g59439 = 0;
					if( temp_output_56_0_g59439 > 0.0 )
					ifLocalVar87_g59439 = temp_output_52_0_g59439;
					else if( temp_output_56_0_g59439 == 0.0 )
					ifLocalVar87_g59439 = temp_output_125_0_g59439;
					else if( temp_output_56_0_g59439 < 0.0 )
					ifLocalVar87_g59439 = temp_output_125_0_g59439;
					float3 temp_output_7_0_g59440 = frac( ( (ifLocalVar87_g59439).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59440 = dot( temp_output_7_0_g59440 , ( (temp_output_7_0_g59440).yzx + 33.33 ) );
					float3 temp_output_12_0_g59440 = ( temp_output_7_0_g59440 + dotResult8_g59440 );
					float2 temp_output_597_0_g59438 = ( UV100_g59439 + frac( ( ( (temp_output_12_0_g59440).xx + (temp_output_12_0_g59440).yz ) * (temp_output_12_0_g59440).zy ) ) );
					float2 DDX631_g59438 = ddx( temp_output_5_0_g59438 );
					float2 DDY632_g59438 = ddy( temp_output_5_0_g59438 );
					float temp_output_65_0_g59439 = ( 0.0 - temp_output_56_0_g59439 );
					float ifLocalVar59_g59439 = 0;
					if( temp_output_56_0_g59439 <= 0.0 )
					ifLocalVar59_g59439 = temp_output_65_0_g59439;
					else
					ifLocalVar59_g59439 = temp_output_56_0_g59439;
					float temp_output_597_30_g59438 = ifLocalVar59_g59439;
					float2 temp_output_90_0_g59439 = ( temp_output_52_0_g59439 + float2( 0,1 ) );
					float2 temp_output_123_0_g59439 = ( temp_output_52_0_g59439 + float2( 1,0 ) );
					float2 ifLocalVar88_g59439 = 0;
					if( temp_output_56_0_g59439 > 0.0 )
					ifLocalVar88_g59439 = temp_output_90_0_g59439;
					else if( temp_output_56_0_g59439 == 0.0 )
					ifLocalVar88_g59439 = temp_output_123_0_g59439;
					else if( temp_output_56_0_g59439 < 0.0 )
					ifLocalVar88_g59439 = temp_output_123_0_g59439;
					float3 temp_output_7_0_g59441 = frac( ( (ifLocalVar88_g59439).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59441 = dot( temp_output_7_0_g59441 , ( (temp_output_7_0_g59441).yzx + 33.33 ) );
					float3 temp_output_12_0_g59441 = ( temp_output_7_0_g59441 + dotResult8_g59441 );
					float2 temp_output_597_26_g59438 = ( UV100_g59439 + frac( ( ( (temp_output_12_0_g59441).xx + (temp_output_12_0_g59441).yz ) * (temp_output_12_0_g59441).zy ) ) );
					float temp_output_66_0_g59439 = ( 1.0 - break55_g59439.y );
					float ifLocalVar60_g59439 = 0;
					if( temp_output_56_0_g59439 <= 0.0 )
					ifLocalVar60_g59439 = temp_output_66_0_g59439;
					else
					ifLocalVar60_g59439 = break55_g59439.y;
					float temp_output_597_28_g59438 = ifLocalVar60_g59439;
					float2 ifLocalVar89_g59439 = 0;
					if( temp_output_56_0_g59439 > 0.0 )
					ifLocalVar89_g59439 = temp_output_123_0_g59439;
					else if( temp_output_56_0_g59439 == 0.0 )
					ifLocalVar89_g59439 = temp_output_90_0_g59439;
					else if( temp_output_56_0_g59439 < 0.0 )
					ifLocalVar89_g59439 = temp_output_90_0_g59439;
					float3 temp_output_7_0_g59442 = frac( ( (ifLocalVar89_g59439).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59442 = dot( temp_output_7_0_g59442 , ( (temp_output_7_0_g59442).yzx + 33.33 ) );
					float3 temp_output_12_0_g59442 = ( temp_output_7_0_g59442 + dotResult8_g59442 );
					float2 temp_output_597_27_g59438 = ( UV100_g59439 + frac( ( ( (temp_output_12_0_g59442).xx + (temp_output_12_0_g59442).yz ) * (temp_output_12_0_g59442).zy ) ) );
					float temp_output_67_0_g59439 = ( 1.0 - break55_g59439.x );
					float ifLocalVar61_g59439 = 0;
					if( temp_output_56_0_g59439 <= 0.0 )
					ifLocalVar61_g59439 = temp_output_67_0_g59439;
					else
					ifLocalVar61_g59439 = break55_g59439.x;
					float temp_output_597_29_g59438 = ifLocalVar61_g59439;
					float4 Output_2D293_g59438 = ( ( tex2D( _MainTex, temp_output_597_0_g59438, DDX631_g59438, DDY632_g59438 ) * temp_output_597_30_g59438 ) + ( tex2D( _MainTex, temp_output_597_26_g59438, DDX631_g59438, DDY632_g59438 ) * temp_output_597_28_g59438 ) + ( tex2D( _MainTex, temp_output_597_27_g59438, DDX631_g59438, DDY632_g59438 ) * temp_output_597_29_g59438 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g59360 = Output_2D293_g59438;
					#else
					float4 staticSwitch1001_g59360 = tex2D( _MainTex, UV02420_g59360 );
					#endif
					#ifdef _MAINTEX
					float4 staticSwitch1549_g59360 = staticSwitch1001_g59360;
					#else
					float4 staticSwitch1549_g59360 = _Color;
					#endif
					float Black1185_g59360 = 0.0;
					#ifdef _LIGHTMAPDEBUG
					float staticSwitch1191_g59360 = Black1185_g59360;
					#else
					float staticSwitch1191_g59360 = staticSwitch1549_g59360.a;
					#endif
					

					o.Normal = half3( 0, 0, 1 );

					o.Alpha = staticSwitch1191_g59360;
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
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2952;192,-1200;Inherit;False;Meenphie;0;;59360;b3ba55a08dd6b49c7be16c6f35cf2033;1,1008,1;0;5;COLOR;625;FLOAT4;624;FLOAT;156;FLOAT;427;FLOAT3;1024
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2889;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;True;1;LightMode=ForwardAdd;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2890;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2891;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2892;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2893;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2894;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ScenePickingPass;0;7;ScenePickingPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=ScenePickingPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2888;512,-1200;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;11;Meenphie/Standard/Cutout;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardBase;0;1;ForwardBase;17;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;1;False;;True;3;False;;False;False;True;3;RenderType=TransparentCutout=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;44;Category;0;0;  Instanced Terrain Normals;1;0;Workflow;3;639057697570214470;Surface;0;638915427204303550;  Blend;2;638915425920684140;  Dither Shadows;1;0;Two Sided;0;639027460080664250;Alpha Clipping;1;638915427324710130;  Use Shadow Threshold;0;638915420933436960;Deferred Pass;0;638915425282396370;Normal Space;0;0;Transmission;0;638915425258747670;  Transmission Shadow;0.5,False,;0;Translucency;0;638915425246861880;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;1;638922399804812020;Receive Shadows;0;638922399717523500;Receive Specular;0;638915388784334560;Receive Reflections;1;638915388803555030;GPU Instancing;1;638915411619689990;LOD CrossFade;1;0;Built-in Fog;1;0;Ambient Light;0;639049545902984550;Meta Pass;0;639048817054746750;Add Pass;0;639048817051401800;Override Baked GI;0;638915390973737640;Write Depth;0;638915421117196140;Extra Pre Pass;0;639048817123696260;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;0;Vertex Position;1;0;0;8;False;True;False;False;False;True;False;False;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2887;512,-1440;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;True;True;0;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;True;True;1;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;0;False;;True;3;False;;True;False;0;False;;0;False;;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;0;False;0
WireConnection;2888;0;2952;625
WireConnection;2888;2;2952;624
WireConnection;2888;7;2952;156
WireConnection;2888;8;2952;427
ASEEND*/
//CHKSM=C71A32283FA331E5FAB938BB3866327C2D5794AC