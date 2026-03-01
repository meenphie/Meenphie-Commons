// Made with Amplify Shader Editor v1.9.9.7
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Standard/Opaque"
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
				#define _SPECULARHIGHLIGHTS_OFF
				#define _GLOSSYREFLECTIONS_OFF
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

					float2 texCoord2357_g60740 = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV02420_g60740 = texCoord2357_g60740;
					float2 temp_output_5_0_g60787 = UV02420_g60740;
					float2 UV633_g60787 = temp_output_5_0_g60787;
					float2 UV100_g60788 = UV633_g60787;
					float2 temp_output_51_0_g60788 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60788 * float2( 3.464,3.464 ) ) );
					float2 break55_g60788 = frac( temp_output_51_0_g60788 );
					float temp_output_56_0_g60788 = ( ( 1.0 - break55_g60788.x ) - break55_g60788.y );
					float2 temp_output_52_0_g60788 = floor( temp_output_51_0_g60788 );
					float2 temp_output_125_0_g60788 = ( temp_output_52_0_g60788 + float2( 1,1 ) );
					float2 ifLocalVar87_g60788 = 0;
					if( temp_output_56_0_g60788 > 0.0 )
					ifLocalVar87_g60788 = temp_output_52_0_g60788;
					else if( temp_output_56_0_g60788 == 0.0 )
					ifLocalVar87_g60788 = temp_output_125_0_g60788;
					else if( temp_output_56_0_g60788 < 0.0 )
					ifLocalVar87_g60788 = temp_output_125_0_g60788;
					float3 temp_output_7_0_g60789 = frac( ( (ifLocalVar87_g60788).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60789 = dot( temp_output_7_0_g60789 , ( (temp_output_7_0_g60789).yzx + 33.33 ) );
					float3 temp_output_12_0_g60789 = ( temp_output_7_0_g60789 + dotResult8_g60789 );
					float2 temp_output_597_0_g60787 = ( UV100_g60788 + frac( ( ( (temp_output_12_0_g60789).xx + (temp_output_12_0_g60789).yz ) * (temp_output_12_0_g60789).zy ) ) );
					float2 DDX631_g60787 = ddx( temp_output_5_0_g60787 );
					float2 DDY632_g60787 = ddy( temp_output_5_0_g60787 );
					float temp_output_65_0_g60788 = ( 0.0 - temp_output_56_0_g60788 );
					float ifLocalVar59_g60788 = 0;
					if( temp_output_56_0_g60788 <= 0.0 )
					ifLocalVar59_g60788 = temp_output_65_0_g60788;
					else
					ifLocalVar59_g60788 = temp_output_56_0_g60788;
					float temp_output_597_30_g60787 = ifLocalVar59_g60788;
					float2 temp_output_90_0_g60788 = ( temp_output_52_0_g60788 + float2( 0,1 ) );
					float2 temp_output_123_0_g60788 = ( temp_output_52_0_g60788 + float2( 1,0 ) );
					float2 ifLocalVar88_g60788 = 0;
					if( temp_output_56_0_g60788 > 0.0 )
					ifLocalVar88_g60788 = temp_output_90_0_g60788;
					else if( temp_output_56_0_g60788 == 0.0 )
					ifLocalVar88_g60788 = temp_output_123_0_g60788;
					else if( temp_output_56_0_g60788 < 0.0 )
					ifLocalVar88_g60788 = temp_output_123_0_g60788;
					float3 temp_output_7_0_g60790 = frac( ( (ifLocalVar88_g60788).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60790 = dot( temp_output_7_0_g60790 , ( (temp_output_7_0_g60790).yzx + 33.33 ) );
					float3 temp_output_12_0_g60790 = ( temp_output_7_0_g60790 + dotResult8_g60790 );
					float2 temp_output_597_26_g60787 = ( UV100_g60788 + frac( ( ( (temp_output_12_0_g60790).xx + (temp_output_12_0_g60790).yz ) * (temp_output_12_0_g60790).zy ) ) );
					float temp_output_66_0_g60788 = ( 1.0 - break55_g60788.y );
					float ifLocalVar60_g60788 = 0;
					if( temp_output_56_0_g60788 <= 0.0 )
					ifLocalVar60_g60788 = temp_output_66_0_g60788;
					else
					ifLocalVar60_g60788 = break55_g60788.y;
					float temp_output_597_28_g60787 = ifLocalVar60_g60788;
					float2 ifLocalVar89_g60788 = 0;
					if( temp_output_56_0_g60788 > 0.0 )
					ifLocalVar89_g60788 = temp_output_123_0_g60788;
					else if( temp_output_56_0_g60788 == 0.0 )
					ifLocalVar89_g60788 = temp_output_90_0_g60788;
					else if( temp_output_56_0_g60788 < 0.0 )
					ifLocalVar89_g60788 = temp_output_90_0_g60788;
					float3 temp_output_7_0_g60791 = frac( ( (ifLocalVar89_g60788).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60791 = dot( temp_output_7_0_g60791 , ( (temp_output_7_0_g60791).yzx + 33.33 ) );
					float3 temp_output_12_0_g60791 = ( temp_output_7_0_g60791 + dotResult8_g60791 );
					float2 temp_output_597_27_g60787 = ( UV100_g60788 + frac( ( ( (temp_output_12_0_g60791).xx + (temp_output_12_0_g60791).yz ) * (temp_output_12_0_g60791).zy ) ) );
					float temp_output_67_0_g60788 = ( 1.0 - break55_g60788.x );
					float ifLocalVar61_g60788 = 0;
					if( temp_output_56_0_g60788 <= 0.0 )
					ifLocalVar61_g60788 = temp_output_67_0_g60788;
					else
					ifLocalVar61_g60788 = break55_g60788.x;
					float temp_output_597_29_g60787 = ifLocalVar61_g60788;
					float4 Output_2D293_g60787 = ( ( tex2D( _MainTex, temp_output_597_0_g60787, DDX631_g60787, DDY632_g60787 ) * temp_output_597_30_g60787 ) + ( tex2D( _MainTex, temp_output_597_26_g60787, DDX631_g60787, DDY632_g60787 ) * temp_output_597_28_g60787 ) + ( tex2D( _MainTex, temp_output_597_27_g60787, DDX631_g60787, DDY632_g60787 ) * temp_output_597_29_g60787 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g60740 = Output_2D293_g60787;
					#else
					float4 staticSwitch1001_g60740 = tex2D( _MainTex, UV02420_g60740 );
					#endif
					#ifdef _MAINTEX
					float4 staticSwitch1549_g60740 = staticSwitch1001_g60740;
					#else
					float4 staticSwitch1549_g60740 = _Color;
					#endif
					float4 oAlbedo6_g60740 = staticSwitch1549_g60740;
					float Black1185_g60740 = 0.0;
					float4 temp_cast_0 = (Black1185_g60740).xxxx;
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1180_g60740 = temp_cast_0;
					#else
					float4 staticSwitch1180_g60740 = oAlbedo6_g60740;
					#endif
					
					float2 temp_output_5_0_g60746 = UV02420_g60740;
					float2 UV633_g60746 = temp_output_5_0_g60746;
					float2 UV100_g60747 = UV633_g60746;
					float2 temp_output_51_0_g60747 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60747 * float2( 3.464,3.464 ) ) );
					float2 break55_g60747 = frac( temp_output_51_0_g60747 );
					float temp_output_56_0_g60747 = ( ( 1.0 - break55_g60747.x ) - break55_g60747.y );
					float2 temp_output_52_0_g60747 = floor( temp_output_51_0_g60747 );
					float2 temp_output_125_0_g60747 = ( temp_output_52_0_g60747 + float2( 1,1 ) );
					float2 ifLocalVar87_g60747 = 0;
					if( temp_output_56_0_g60747 > 0.0 )
					ifLocalVar87_g60747 = temp_output_52_0_g60747;
					else if( temp_output_56_0_g60747 == 0.0 )
					ifLocalVar87_g60747 = temp_output_125_0_g60747;
					else if( temp_output_56_0_g60747 < 0.0 )
					ifLocalVar87_g60747 = temp_output_125_0_g60747;
					float3 temp_output_7_0_g60748 = frac( ( (ifLocalVar87_g60747).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60748 = dot( temp_output_7_0_g60748 , ( (temp_output_7_0_g60748).yzx + 33.33 ) );
					float3 temp_output_12_0_g60748 = ( temp_output_7_0_g60748 + dotResult8_g60748 );
					float2 temp_output_597_0_g60746 = ( UV100_g60747 + frac( ( ( (temp_output_12_0_g60748).xx + (temp_output_12_0_g60748).yz ) * (temp_output_12_0_g60748).zy ) ) );
					float2 DDX631_g60746 = ddx( temp_output_5_0_g60746 );
					float2 DDY632_g60746 = ddy( temp_output_5_0_g60746 );
					float temp_output_65_0_g60747 = ( 0.0 - temp_output_56_0_g60747 );
					float ifLocalVar59_g60747 = 0;
					if( temp_output_56_0_g60747 <= 0.0 )
					ifLocalVar59_g60747 = temp_output_65_0_g60747;
					else
					ifLocalVar59_g60747 = temp_output_56_0_g60747;
					float temp_output_597_30_g60746 = ifLocalVar59_g60747;
					float2 temp_output_90_0_g60747 = ( temp_output_52_0_g60747 + float2( 0,1 ) );
					float2 temp_output_123_0_g60747 = ( temp_output_52_0_g60747 + float2( 1,0 ) );
					float2 ifLocalVar88_g60747 = 0;
					if( temp_output_56_0_g60747 > 0.0 )
					ifLocalVar88_g60747 = temp_output_90_0_g60747;
					else if( temp_output_56_0_g60747 == 0.0 )
					ifLocalVar88_g60747 = temp_output_123_0_g60747;
					else if( temp_output_56_0_g60747 < 0.0 )
					ifLocalVar88_g60747 = temp_output_123_0_g60747;
					float3 temp_output_7_0_g60749 = frac( ( (ifLocalVar88_g60747).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60749 = dot( temp_output_7_0_g60749 , ( (temp_output_7_0_g60749).yzx + 33.33 ) );
					float3 temp_output_12_0_g60749 = ( temp_output_7_0_g60749 + dotResult8_g60749 );
					float2 temp_output_597_26_g60746 = ( UV100_g60747 + frac( ( ( (temp_output_12_0_g60749).xx + (temp_output_12_0_g60749).yz ) * (temp_output_12_0_g60749).zy ) ) );
					float temp_output_66_0_g60747 = ( 1.0 - break55_g60747.y );
					float ifLocalVar60_g60747 = 0;
					if( temp_output_56_0_g60747 <= 0.0 )
					ifLocalVar60_g60747 = temp_output_66_0_g60747;
					else
					ifLocalVar60_g60747 = break55_g60747.y;
					float temp_output_597_28_g60746 = ifLocalVar60_g60747;
					float2 ifLocalVar89_g60747 = 0;
					if( temp_output_56_0_g60747 > 0.0 )
					ifLocalVar89_g60747 = temp_output_123_0_g60747;
					else if( temp_output_56_0_g60747 == 0.0 )
					ifLocalVar89_g60747 = temp_output_90_0_g60747;
					else if( temp_output_56_0_g60747 < 0.0 )
					ifLocalVar89_g60747 = temp_output_90_0_g60747;
					float3 temp_output_7_0_g60750 = frac( ( (ifLocalVar89_g60747).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60750 = dot( temp_output_7_0_g60750 , ( (temp_output_7_0_g60750).yzx + 33.33 ) );
					float3 temp_output_12_0_g60750 = ( temp_output_7_0_g60750 + dotResult8_g60750 );
					float2 temp_output_597_27_g60746 = ( UV100_g60747 + frac( ( ( (temp_output_12_0_g60750).xx + (temp_output_12_0_g60750).yz ) * (temp_output_12_0_g60750).zy ) ) );
					float temp_output_67_0_g60747 = ( 1.0 - break55_g60747.x );
					float ifLocalVar61_g60747 = 0;
					if( temp_output_56_0_g60747 <= 0.0 )
					ifLocalVar61_g60747 = temp_output_67_0_g60747;
					else
					ifLocalVar61_g60747 = break55_g60747.x;
					float temp_output_597_29_g60746 = ifLocalVar61_g60747;
					float4 Output_2D293_g60746 = ( ( tex2D( _MetallicMap, temp_output_597_0_g60746, DDX631_g60746, DDY632_g60746 ) * temp_output_597_30_g60746 ) + ( tex2D( _MetallicMap, temp_output_597_26_g60746, DDX631_g60746, DDY632_g60746 ) * temp_output_597_28_g60746 ) + ( tex2D( _MetallicMap, temp_output_597_27_g60746, DDX631_g60746, DDY632_g60746 ) * temp_output_597_29_g60746 ) );
					float4 break31_g60746 = Output_2D293_g60746;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g60740 = break31_g60746.a;
					#else
					float staticSwitch1005_g60740 = tex2D( _MetallicMap, UV02420_g60740 ).a;
					#endif
					#ifdef _METALLICMAP
					float staticSwitch846_g60740 = staticSwitch1005_g60740;
					#else
					float staticSwitch846_g60740 = _Metallic;
					#endif
					float Metallic1239_g60740 = staticSwitch846_g60740;
					float4 aAlbedo1466_g60740 = ( staticSwitch1549_g60740 * ( 1.0 - Metallic1239_g60740 ) );
					float White38_g60740 = 1.0;
					float4 temp_cast_2 = (White38_g60740).xxxx;
					float4 texCoord2426_g60740 = IN.ase_texcoord6;
					texCoord2426_g60740.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV12361_g60740 = (texCoord2426_g60740).zw;
					float localBicubicPrepare2_g60781 = ( 0.0 );
					float2 Input_UV100_g60781 = UV12361_g60740;
					float2 UV2_g60781 = Input_UV100_g60781;
					float4 TexelSize2_g60781 = _Lightmap0_TexelSize;
					float2 UV02_g60781 = float2( 0,0 );
					float2 UV12_g60781 = float2( 0,0 );
					float2 UV22_g60781 = float2( 0,0 );
					float2 UV32_g60781 = float2( 0,0 );
					float W02_g60781 = 0;
					float W12_g60781 = 0;
					{
					{
					 UV2_g60781 = UV2_g60781 * TexelSize2_g60781.zw - 0.5;
					    float2 f = frac( UV2_g60781 );
					    UV2_g60781 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g60781.x - 0.5, UV2_g60781.x + 1.5, UV2_g60781.y - 0.5, UV2_g60781.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60781.xyxy;
					    UV02_g60781 = off.xz;
					    UV12_g60781 = off.yz;
					    UV22_g60781 = off.xw;
					    UV32_g60781 = off.yw;
					    W02_g60781 = s.x / ( s.x + s.y );
					 W12_g60781 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g60781 = lerp( tex2D( _Lightmap0, UV32_g60781 ) , tex2D( _Lightmap0, UV22_g60781 ) , W02_g60781);
					float4 lerpResult45_g60781 = lerp( tex2D( _Lightmap0, UV12_g60781 ) , tex2D( _Lightmap0, UV02_g60781 ) , W02_g60781);
					float4 lerpResult44_g60781 = lerp( lerpResult46_g60781 , lerpResult45_g60781 , W12_g60781);
					float4 Output_2D_Auto131_g60781 = lerpResult44_g60781;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g60740 = Output_2D_Auto131_g60781;
					#else
					float4 staticSwitch1092_g60740 = tex2D( _Lightmap0, UV12361_g60740 );
					#endif
					float4 Lightmap_0925_g60740 = staticSwitch1092_g60740;
					float localBicubicPrepare2_g60779 = ( 0.0 );
					float2 Input_UV100_g60779 = UV12361_g60740;
					float2 UV2_g60779 = Input_UV100_g60779;
					float4 TexelSize2_g60779 = _Lightmap1_TexelSize;
					float2 UV02_g60779 = float2( 0,0 );
					float2 UV12_g60779 = float2( 0,0 );
					float2 UV22_g60779 = float2( 0,0 );
					float2 UV32_g60779 = float2( 0,0 );
					float W02_g60779 = 0;
					float W12_g60779 = 0;
					{
					{
					 UV2_g60779 = UV2_g60779 * TexelSize2_g60779.zw - 0.5;
					    float2 f = frac( UV2_g60779 );
					    UV2_g60779 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g60779.x - 0.5, UV2_g60779.x + 1.5, UV2_g60779.y - 0.5, UV2_g60779.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60779.xyxy;
					    UV02_g60779 = off.xz;
					    UV12_g60779 = off.yz;
					    UV22_g60779 = off.xw;
					    UV32_g60779 = off.yw;
					    W02_g60779 = s.x / ( s.x + s.y );
					 W12_g60779 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g60779 = lerp( tex2D( _Lightmap1, UV32_g60779 ) , tex2D( _Lightmap1, UV22_g60779 ) , W02_g60779);
					float4 lerpResult45_g60779 = lerp( tex2D( _Lightmap1, UV12_g60779 ) , tex2D( _Lightmap1, UV02_g60779 ) , W02_g60779);
					float4 lerpResult44_g60779 = lerp( lerpResult46_g60779 , lerpResult45_g60779 , W12_g60779);
					float4 Output_2D_Auto131_g60779 = lerpResult44_g60779;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g60740 = Output_2D_Auto131_g60779;
					#else
					float4 staticSwitch1088_g60740 = tex2D( _Lightmap1, UV12361_g60740 );
					#endif
					float4 Lightmap_1956_g60740 = staticSwitch1088_g60740;
					float4 lerpResult442_g60740 = lerp( Lightmap_0925_g60740 , Lightmap_1956_g60740 , _LIGHTMAPLERP);
					float4 Lightmap_Lerp932_g60740 = lerpResult442_g60740;
					float3 appendResult139_g60769 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float2 temp_output_5_0_g60741 = UV02420_g60740;
					float2 UV633_g60741 = temp_output_5_0_g60741;
					float2 UV100_g60742 = UV633_g60741;
					float2 temp_output_51_0_g60742 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60742 * float2( 3.464,3.464 ) ) );
					float2 break55_g60742 = frac( temp_output_51_0_g60742 );
					float temp_output_56_0_g60742 = ( ( 1.0 - break55_g60742.x ) - break55_g60742.y );
					float2 temp_output_52_0_g60742 = floor( temp_output_51_0_g60742 );
					float2 temp_output_125_0_g60742 = ( temp_output_52_0_g60742 + float2( 1,1 ) );
					float2 ifLocalVar87_g60742 = 0;
					if( temp_output_56_0_g60742 > 0.0 )
					ifLocalVar87_g60742 = temp_output_52_0_g60742;
					else if( temp_output_56_0_g60742 == 0.0 )
					ifLocalVar87_g60742 = temp_output_125_0_g60742;
					else if( temp_output_56_0_g60742 < 0.0 )
					ifLocalVar87_g60742 = temp_output_125_0_g60742;
					float3 temp_output_7_0_g60743 = frac( ( (ifLocalVar87_g60742).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60743 = dot( temp_output_7_0_g60743 , ( (temp_output_7_0_g60743).yzx + 33.33 ) );
					float3 temp_output_12_0_g60743 = ( temp_output_7_0_g60743 + dotResult8_g60743 );
					float2 temp_output_597_0_g60741 = ( UV100_g60742 + frac( ( ( (temp_output_12_0_g60743).xx + (temp_output_12_0_g60743).yz ) * (temp_output_12_0_g60743).zy ) ) );
					float2 DDX631_g60741 = ddx( temp_output_5_0_g60741 );
					float2 DDY632_g60741 = ddy( temp_output_5_0_g60741 );
					float Input_Scale617_g60741 = 2.0;
					float temp_output_65_0_g60742 = ( 0.0 - temp_output_56_0_g60742 );
					float ifLocalVar59_g60742 = 0;
					if( temp_output_56_0_g60742 <= 0.0 )
					ifLocalVar59_g60742 = temp_output_65_0_g60742;
					else
					ifLocalVar59_g60742 = temp_output_56_0_g60742;
					float temp_output_597_30_g60741 = ifLocalVar59_g60742;
					float2 temp_output_90_0_g60742 = ( temp_output_52_0_g60742 + float2( 0,1 ) );
					float2 temp_output_123_0_g60742 = ( temp_output_52_0_g60742 + float2( 1,0 ) );
					float2 ifLocalVar88_g60742 = 0;
					if( temp_output_56_0_g60742 > 0.0 )
					ifLocalVar88_g60742 = temp_output_90_0_g60742;
					else if( temp_output_56_0_g60742 == 0.0 )
					ifLocalVar88_g60742 = temp_output_123_0_g60742;
					else if( temp_output_56_0_g60742 < 0.0 )
					ifLocalVar88_g60742 = temp_output_123_0_g60742;
					float3 temp_output_7_0_g60744 = frac( ( (ifLocalVar88_g60742).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60744 = dot( temp_output_7_0_g60744 , ( (temp_output_7_0_g60744).yzx + 33.33 ) );
					float3 temp_output_12_0_g60744 = ( temp_output_7_0_g60744 + dotResult8_g60744 );
					float2 temp_output_597_26_g60741 = ( UV100_g60742 + frac( ( ( (temp_output_12_0_g60744).xx + (temp_output_12_0_g60744).yz ) * (temp_output_12_0_g60744).zy ) ) );
					float temp_output_66_0_g60742 = ( 1.0 - break55_g60742.y );
					float ifLocalVar60_g60742 = 0;
					if( temp_output_56_0_g60742 <= 0.0 )
					ifLocalVar60_g60742 = temp_output_66_0_g60742;
					else
					ifLocalVar60_g60742 = break55_g60742.y;
					float temp_output_597_28_g60741 = ifLocalVar60_g60742;
					float2 ifLocalVar89_g60742 = 0;
					if( temp_output_56_0_g60742 > 0.0 )
					ifLocalVar89_g60742 = temp_output_123_0_g60742;
					else if( temp_output_56_0_g60742 == 0.0 )
					ifLocalVar89_g60742 = temp_output_90_0_g60742;
					else if( temp_output_56_0_g60742 < 0.0 )
					ifLocalVar89_g60742 = temp_output_90_0_g60742;
					float3 temp_output_7_0_g60745 = frac( ( (ifLocalVar89_g60742).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60745 = dot( temp_output_7_0_g60745 , ( (temp_output_7_0_g60745).yzx + 33.33 ) );
					float3 temp_output_12_0_g60745 = ( temp_output_7_0_g60745 + dotResult8_g60745 );
					float2 temp_output_597_27_g60741 = ( UV100_g60742 + frac( ( ( (temp_output_12_0_g60745).xx + (temp_output_12_0_g60745).yz ) * (temp_output_12_0_g60745).zy ) ) );
					float temp_output_67_0_g60742 = ( 1.0 - break55_g60742.x );
					float ifLocalVar61_g60742 = 0;
					if( temp_output_56_0_g60742 <= 0.0 )
					ifLocalVar61_g60742 = temp_output_67_0_g60742;
					else
					ifLocalVar61_g60742 = break55_g60742.x;
					float temp_output_597_29_g60741 = ifLocalVar61_g60742;
					float3 Output_2D_Normal641_g60741 = ( ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_0_g60741, DDX631_g60741, DDY632_g60741 ), Input_Scale617_g60741 ) * temp_output_597_30_g60741 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_26_g60741, DDX631_g60741, DDY632_g60741 ), Input_Scale617_g60741 ) * temp_output_597_28_g60741 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_27_g60741, DDX631_g60741, DDY632_g60741 ), Input_Scale617_g60741 ) * float3( 0,0,0 ) * temp_output_597_29_g60741 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g60740 = Output_2D_Normal641_g60741;
					#else
					float3 staticSwitch1003_g60740 = UnpackScaleNormal( tex2D( _BumpMap, UV02420_g60740 ), 2.0 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g60740 = staticSwitch1003_g60740;
					#else
					float3 staticSwitch980_g60740 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g60740 = staticSwitch980_g60740;
					float3 normalizeResult326_g60769 = normalize( Normal_Map700_g60740 );
					float3 Normal_Map318_g60769 = normalizeResult326_g60769;
					float dotResult121_g60769 = dot( appendResult139_g60769 , Normal_Map318_g60769 );
					float temp_output_2_0_g60772 = saturate( dotResult121_g60769 );
					float localStochasticTiling2_g60783 = ( 0.0 );
					float2 UV2_g60783 = UV12361_g60740;
					float4 TexelSize2_g60783 = _RNMX0_TexelSize;
					float4 Offsets2_g60783 = float4( 0,0,0,0 );
					float2 Weights2_g60783 = float2( 0,0 );
					{
					UV2_g60783 = UV2_g60783 * TexelSize2_g60783.zw - 0.5;
					float2 f = frac( UV2_g60783 );
					UV2_g60783 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g60783.x - 0.5, UV2_g60783.x + 1.5, UV2_g60783.y - 0.5, UV2_g60783.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g60783 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60783.xyxy;
					Weights2_g60783 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g60782 = Offsets2_g60783;
					float4 Input_FetchOffsets197_g60784 = temp_output_1_34_g60782;
					float2 temp_output_1_54_g60782 = Weights2_g60783;
					float2 Input_FetchWeights200_g60784 = temp_output_1_54_g60782;
					float2 break187_g60784 = Input_FetchWeights200_g60784;
					float4 lerpResult181_g60784 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g60784).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g60784).xw ) , break187_g60784.x);
					float4 lerpResult182_g60784 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g60784).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g60784).xz ) , break187_g60784.x);
					float4 lerpResult176_g60784 = lerp( lerpResult181_g60784 , lerpResult182_g60784 , break187_g60784.y);
					float4 Output_Fetch2D_Auto202_g60784 = lerpResult176_g60784;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g60740 = Output_Fetch2D_Auto202_g60784;
					#else
					float4 staticSwitch1061_g60740 = tex2D( _RNMX0, UV12361_g60740 );
					#endif
					float3 appendResult146_g60769 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g60769 = dot( appendResult146_g60769 , Normal_Map318_g60769 );
					float temp_output_2_0_g60771 = saturate( dotResult122_g60769 );
					float4 Input_FetchOffsets197_g60785 = temp_output_1_34_g60782;
					float2 Input_FetchWeights200_g60785 = temp_output_1_54_g60782;
					float2 break187_g60785 = Input_FetchWeights200_g60785;
					float4 lerpResult181_g60785 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g60785).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g60785).xw ) , break187_g60785.x);
					float4 lerpResult182_g60785 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g60785).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g60785).xz ) , break187_g60785.x);
					float4 lerpResult176_g60785 = lerp( lerpResult181_g60785 , lerpResult182_g60785 , break187_g60785.y);
					float4 Output_Fetch2D_Auto202_g60785 = lerpResult176_g60785;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g60740 = Output_Fetch2D_Auto202_g60785;
					#else
					float4 staticSwitch1062_g60740 = tex2D( _RNMY0, UV12361_g60740 );
					#endif
					float3 appendResult149_g60769 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g60769 = dot( appendResult149_g60769 , Normal_Map318_g60769 );
					float temp_output_2_0_g60770 = saturate( dotResult120_g60769 );
					float4 Input_FetchOffsets197_g60786 = temp_output_1_34_g60782;
					float2 Input_FetchWeights200_g60786 = temp_output_1_54_g60782;
					float2 break187_g60786 = Input_FetchWeights200_g60786;
					float4 lerpResult181_g60786 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g60786).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g60786).xw ) , break187_g60786.x);
					float4 lerpResult182_g60786 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g60786).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g60786).xz ) , break187_g60786.x);
					float4 lerpResult176_g60786 = lerp( lerpResult181_g60786 , lerpResult182_g60786 , break187_g60786.y);
					float4 Output_Fetch2D_Auto202_g60786 = lerpResult176_g60786;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g60740 = Output_Fetch2D_Auto202_g60786;
					#else
					float4 staticSwitch1063_g60740 = tex2D( _RNMZ0, UV12361_g60740 );
					#endif
					float4 RNM_0926_g60740 = ( ( ( ( temp_output_2_0_g60772 * temp_output_2_0_g60772 ) * staticSwitch1061_g60740 ) + ( ( temp_output_2_0_g60771 * temp_output_2_0_g60771 ) * staticSwitch1062_g60740 ) ) + ( ( temp_output_2_0_g60770 * temp_output_2_0_g60770 ) * staticSwitch1063_g60740 ) );
					float3 appendResult139_g60765 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g60765 = normalize( Normal_Map700_g60740 );
					float3 Normal_Map318_g60765 = normalizeResult326_g60765;
					float dotResult121_g60765 = dot( appendResult139_g60765 , Normal_Map318_g60765 );
					float temp_output_2_0_g60768 = saturate( dotResult121_g60765 );
					float localStochasticTiling2_g60774 = ( 0.0 );
					float2 UV2_g60774 = UV12361_g60740;
					float4 TexelSize2_g60774 = _RNMX1_TexelSize;
					float4 Offsets2_g60774 = float4( 0,0,0,0 );
					float2 Weights2_g60774 = float2( 0,0 );
					{
					UV2_g60774 = UV2_g60774 * TexelSize2_g60774.zw - 0.5;
					float2 f = frac( UV2_g60774 );
					UV2_g60774 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g60774.x - 0.5, UV2_g60774.x + 1.5, UV2_g60774.y - 0.5, UV2_g60774.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g60774 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60774.xyxy;
					Weights2_g60774 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g60773 = Offsets2_g60774;
					float4 Input_FetchOffsets197_g60775 = temp_output_1_34_g60773;
					float2 temp_output_1_54_g60773 = Weights2_g60774;
					float2 Input_FetchWeights200_g60775 = temp_output_1_54_g60773;
					float2 break187_g60775 = Input_FetchWeights200_g60775;
					float4 lerpResult181_g60775 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g60775).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g60775).xw ) , break187_g60775.x);
					float4 lerpResult182_g60775 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g60775).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g60775).xz ) , break187_g60775.x);
					float4 lerpResult176_g60775 = lerp( lerpResult181_g60775 , lerpResult182_g60775 , break187_g60775.y);
					float4 Output_Fetch2D_Auto202_g60775 = lerpResult176_g60775;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g60740 = Output_Fetch2D_Auto202_g60775;
					#else
					float4 staticSwitch1087_g60740 = tex2D( _RNMX1, UV12361_g60740 );
					#endif
					float3 appendResult146_g60765 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g60765 = dot( appendResult146_g60765 , Normal_Map318_g60765 );
					float temp_output_2_0_g60767 = saturate( dotResult122_g60765 );
					float4 Input_FetchOffsets197_g60776 = temp_output_1_34_g60773;
					float2 Input_FetchWeights200_g60776 = temp_output_1_54_g60773;
					float2 break187_g60776 = Input_FetchWeights200_g60776;
					float4 lerpResult181_g60776 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g60776).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g60776).xw ) , break187_g60776.x);
					float4 lerpResult182_g60776 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g60776).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g60776).xz ) , break187_g60776.x);
					float4 lerpResult176_g60776 = lerp( lerpResult181_g60776 , lerpResult182_g60776 , break187_g60776.y);
					float4 Output_Fetch2D_Auto202_g60776 = lerpResult176_g60776;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g60740 = Output_Fetch2D_Auto202_g60776;
					#else
					float4 staticSwitch1083_g60740 = tex2D( _RNMY1, UV12361_g60740 );
					#endif
					float3 appendResult149_g60765 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g60765 = dot( appendResult149_g60765 , Normal_Map318_g60765 );
					float temp_output_2_0_g60766 = saturate( dotResult120_g60765 );
					float4 Input_FetchOffsets197_g60777 = temp_output_1_34_g60773;
					float2 Input_FetchWeights200_g60777 = temp_output_1_54_g60773;
					float2 break187_g60777 = Input_FetchWeights200_g60777;
					float4 lerpResult181_g60777 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g60777).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g60777).xw ) , break187_g60777.x);
					float4 lerpResult182_g60777 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g60777).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g60777).xz ) , break187_g60777.x);
					float4 lerpResult176_g60777 = lerp( lerpResult181_g60777 , lerpResult182_g60777 , break187_g60777.y);
					float4 Output_Fetch2D_Auto202_g60777 = lerpResult176_g60777;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g60740 = Output_Fetch2D_Auto202_g60777;
					#else
					float4 staticSwitch1084_g60740 = tex2D( _RNMZ1, UV12361_g60740 );
					#endif
					float4 RNM_11081_g60740 = ( ( ( ( temp_output_2_0_g60768 * temp_output_2_0_g60768 ) * staticSwitch1087_g60740 ) + ( ( temp_output_2_0_g60767 * temp_output_2_0_g60767 ) * staticSwitch1083_g60740 ) ) + ( ( temp_output_2_0_g60766 * temp_output_2_0_g60766 ) * staticSwitch1084_g60740 ) );
					float Lightmap_Lerp_Value969_g60740 = _LIGHTMAPLERP;
					float4 lerpResult953_g60740 = lerp( RNM_0926_g60740 , RNM_11081_g60740 , Lightmap_Lerp_Value969_g60740);
					float4 RNM_Lerp950_g60740 = lerpResult953_g60740;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g60740 = temp_cast_2;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g60740 = Lightmap_0925_g60740;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g60740 = Lightmap_Lerp932_g60740;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g60740 = RNM_0926_g60740;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g60740 = RNM_Lerp950_g60740;
					#else
					float4 staticSwitch1014_g60740 = temp_cast_2;
					#endif
					float4 Lightmap46_g60740 = staticSwitch1014_g60740;
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal1392_g60740 = Normal_Map700_g60740;
					float2 temp_output_5_0_g60758 = UV02420_g60740;
					float2 UV633_g60758 = temp_output_5_0_g60758;
					float2 UV100_g60759 = UV633_g60758;
					float2 temp_output_51_0_g60759 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60759 * float2( 3.464,3.464 ) ) );
					float2 break55_g60759 = frac( temp_output_51_0_g60759 );
					float temp_output_56_0_g60759 = ( ( 1.0 - break55_g60759.x ) - break55_g60759.y );
					float2 temp_output_52_0_g60759 = floor( temp_output_51_0_g60759 );
					float2 temp_output_125_0_g60759 = ( temp_output_52_0_g60759 + float2( 1,1 ) );
					float2 ifLocalVar87_g60759 = 0;
					if( temp_output_56_0_g60759 > 0.0 )
					ifLocalVar87_g60759 = temp_output_52_0_g60759;
					else if( temp_output_56_0_g60759 == 0.0 )
					ifLocalVar87_g60759 = temp_output_125_0_g60759;
					else if( temp_output_56_0_g60759 < 0.0 )
					ifLocalVar87_g60759 = temp_output_125_0_g60759;
					float3 temp_output_7_0_g60760 = frac( ( (ifLocalVar87_g60759).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60760 = dot( temp_output_7_0_g60760 , ( (temp_output_7_0_g60760).yzx + 33.33 ) );
					float3 temp_output_12_0_g60760 = ( temp_output_7_0_g60760 + dotResult8_g60760 );
					float2 temp_output_597_0_g60758 = ( UV100_g60759 + frac( ( ( (temp_output_12_0_g60760).xx + (temp_output_12_0_g60760).yz ) * (temp_output_12_0_g60760).zy ) ) );
					float2 DDX631_g60758 = ddx( temp_output_5_0_g60758 );
					float2 DDY632_g60758 = ddy( temp_output_5_0_g60758 );
					float temp_output_65_0_g60759 = ( 0.0 - temp_output_56_0_g60759 );
					float ifLocalVar59_g60759 = 0;
					if( temp_output_56_0_g60759 <= 0.0 )
					ifLocalVar59_g60759 = temp_output_65_0_g60759;
					else
					ifLocalVar59_g60759 = temp_output_56_0_g60759;
					float temp_output_597_30_g60758 = ifLocalVar59_g60759;
					float2 temp_output_90_0_g60759 = ( temp_output_52_0_g60759 + float2( 0,1 ) );
					float2 temp_output_123_0_g60759 = ( temp_output_52_0_g60759 + float2( 1,0 ) );
					float2 ifLocalVar88_g60759 = 0;
					if( temp_output_56_0_g60759 > 0.0 )
					ifLocalVar88_g60759 = temp_output_90_0_g60759;
					else if( temp_output_56_0_g60759 == 0.0 )
					ifLocalVar88_g60759 = temp_output_123_0_g60759;
					else if( temp_output_56_0_g60759 < 0.0 )
					ifLocalVar88_g60759 = temp_output_123_0_g60759;
					float3 temp_output_7_0_g60761 = frac( ( (ifLocalVar88_g60759).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60761 = dot( temp_output_7_0_g60761 , ( (temp_output_7_0_g60761).yzx + 33.33 ) );
					float3 temp_output_12_0_g60761 = ( temp_output_7_0_g60761 + dotResult8_g60761 );
					float2 temp_output_597_26_g60758 = ( UV100_g60759 + frac( ( ( (temp_output_12_0_g60761).xx + (temp_output_12_0_g60761).yz ) * (temp_output_12_0_g60761).zy ) ) );
					float temp_output_66_0_g60759 = ( 1.0 - break55_g60759.y );
					float ifLocalVar60_g60759 = 0;
					if( temp_output_56_0_g60759 <= 0.0 )
					ifLocalVar60_g60759 = temp_output_66_0_g60759;
					else
					ifLocalVar60_g60759 = break55_g60759.y;
					float temp_output_597_28_g60758 = ifLocalVar60_g60759;
					float2 ifLocalVar89_g60759 = 0;
					if( temp_output_56_0_g60759 > 0.0 )
					ifLocalVar89_g60759 = temp_output_123_0_g60759;
					else if( temp_output_56_0_g60759 == 0.0 )
					ifLocalVar89_g60759 = temp_output_90_0_g60759;
					else if( temp_output_56_0_g60759 < 0.0 )
					ifLocalVar89_g60759 = temp_output_90_0_g60759;
					float3 temp_output_7_0_g60762 = frac( ( (ifLocalVar89_g60759).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60762 = dot( temp_output_7_0_g60762 , ( (temp_output_7_0_g60762).yzx + 33.33 ) );
					float3 temp_output_12_0_g60762 = ( temp_output_7_0_g60762 + dotResult8_g60762 );
					float2 temp_output_597_27_g60758 = ( UV100_g60759 + frac( ( ( (temp_output_12_0_g60762).xx + (temp_output_12_0_g60762).yz ) * (temp_output_12_0_g60762).zy ) ) );
					float temp_output_67_0_g60759 = ( 1.0 - break55_g60759.x );
					float ifLocalVar61_g60759 = 0;
					if( temp_output_56_0_g60759 <= 0.0 )
					ifLocalVar61_g60759 = temp_output_67_0_g60759;
					else
					ifLocalVar61_g60759 = break55_g60759.x;
					float temp_output_597_29_g60758 = ifLocalVar61_g60759;
					float4 Output_2D293_g60758 = ( ( tex2D( _GlossinessMap, temp_output_597_0_g60758, DDX631_g60758, DDY632_g60758 ) * temp_output_597_30_g60758 ) + ( tex2D( _GlossinessMap, temp_output_597_26_g60758, DDX631_g60758, DDY632_g60758 ) * temp_output_597_28_g60758 ) + ( tex2D( _GlossinessMap, temp_output_597_27_g60758, DDX631_g60758, DDY632_g60758 ) * temp_output_597_29_g60758 ) );
					float4 break31_g60758 = Output_2D293_g60758;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g60740 = break31_g60758.a;
					#else
					float staticSwitch1004_g60740 = tex2D( _GlossinessMap, UV02420_g60740 ).r;
					#endif
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g60740 = ( 1.0 - staticSwitch1004_g60740 );
					#else
					float staticSwitch845_g60740 = _Glossiness;
					#endif
					float3 temp_output_3_0_g60751 = ddx( NormalWS );
					float dotResult5_g60751 = dot( temp_output_3_0_g60751 , temp_output_3_0_g60751 );
					float3 temp_output_4_0_g60751 = ddy( NormalWS );
					float dotResult6_g60751 = dot( temp_output_4_0_g60751 , temp_output_4_0_g60751 );
					#ifdef _USEGEOMETRICANTIALIASING_ON
					float staticSwitch824_g60740 = min( staticSwitch845_g60740, ( 1.0 - pow( saturate( max( dotResult5_g60751, dotResult6_g60751 ) ) , 0.333 ) ) );
					#else
					float staticSwitch824_g60740 = staticSwitch845_g60740;
					#endif
					float Smoothness1399_g60740 = staticSwitch824_g60740;
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
					Unity_GlossyEnvironmentData g1392_g60740 = UnityGlossyEnvironmentSetup( Smoothness1399_g60740, ViewDirWS, float3( dot( tanToWorld0, tanNormal1392_g60740 ), dot( tanToWorld1, tanNormal1392_g60740 ), dot( tanToWorld2, tanNormal1392_g60740 ) ), float3(0,0,0));
					float3 indirectSpecular1392_g60740 = UnityGI_IndirectSpecular( data, 1.0, float3( dot( tanToWorld0, tanNormal1392_g60740 ), dot( tanToWorld1, tanNormal1392_g60740 ), dot( tanToWorld2, tanNormal1392_g60740 ) ), g1392_g60740 );
					float4 temp_cast_4 = (0.04).xxxx;
					float4 lerpResult1473_g60740 = lerp( temp_cast_4 , oAlbedo6_g60740 , Metallic1239_g60740);
					float3 switchResult1501_g60740 = (((ase_vface>0)?(NormalWS):(-NormalWS)));
					float dotResult1476_g60740 = dot( switchResult1501_g60740 , ViewDirWS );
					float4 lerpResult1480_g60740 = lerp( lerpResult1473_g60740 , float4( 1,1,1,0 ) , pow( ( 1.0 - saturate( dotResult1476_g60740 ) ) , 5.0 ));
					float4 Fresnel1560_g60740 = lerpResult1480_g60740;
					float4 temp_output_1481_0_g60740 = ( float4( indirectSpecular1392_g60740 , 0.0 ) * Fresnel1560_g60740 );
					#ifdef _USELIGHTMAPSPECULAR_ON
					float4 staticSwitch1469_g60740 = ( temp_output_1481_0_g60740 * sqrt( Lightmap46_g60740 ) );
					#else
					float4 staticSwitch1469_g60740 = temp_output_1481_0_g60740;
					#endif
					float4 Specular1419_g60740 = staticSwitch1469_g60740;
					float4 temp_cast_5 = (Black1185_g60740).xxxx;
					float2 temp_output_5_0_g60752 = UV02420_g60740;
					float2 UV633_g60752 = temp_output_5_0_g60752;
					float2 UV100_g60753 = UV633_g60752;
					float2 temp_output_51_0_g60753 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60753 * float2( 3.464,3.464 ) ) );
					float2 break55_g60753 = frac( temp_output_51_0_g60753 );
					float temp_output_56_0_g60753 = ( ( 1.0 - break55_g60753.x ) - break55_g60753.y );
					float2 temp_output_52_0_g60753 = floor( temp_output_51_0_g60753 );
					float2 temp_output_125_0_g60753 = ( temp_output_52_0_g60753 + float2( 1,1 ) );
					float2 ifLocalVar87_g60753 = 0;
					if( temp_output_56_0_g60753 > 0.0 )
					ifLocalVar87_g60753 = temp_output_52_0_g60753;
					else if( temp_output_56_0_g60753 == 0.0 )
					ifLocalVar87_g60753 = temp_output_125_0_g60753;
					else if( temp_output_56_0_g60753 < 0.0 )
					ifLocalVar87_g60753 = temp_output_125_0_g60753;
					float3 temp_output_7_0_g60754 = frac( ( (ifLocalVar87_g60753).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60754 = dot( temp_output_7_0_g60754 , ( (temp_output_7_0_g60754).yzx + 33.33 ) );
					float3 temp_output_12_0_g60754 = ( temp_output_7_0_g60754 + dotResult8_g60754 );
					float2 temp_output_597_0_g60752 = ( UV100_g60753 + frac( ( ( (temp_output_12_0_g60754).xx + (temp_output_12_0_g60754).yz ) * (temp_output_12_0_g60754).zy ) ) );
					float2 DDX631_g60752 = ddx( temp_output_5_0_g60752 );
					float2 DDY632_g60752 = ddy( temp_output_5_0_g60752 );
					float temp_output_65_0_g60753 = ( 0.0 - temp_output_56_0_g60753 );
					float ifLocalVar59_g60753 = 0;
					if( temp_output_56_0_g60753 <= 0.0 )
					ifLocalVar59_g60753 = temp_output_65_0_g60753;
					else
					ifLocalVar59_g60753 = temp_output_56_0_g60753;
					float temp_output_597_30_g60752 = ifLocalVar59_g60753;
					float2 temp_output_90_0_g60753 = ( temp_output_52_0_g60753 + float2( 0,1 ) );
					float2 temp_output_123_0_g60753 = ( temp_output_52_0_g60753 + float2( 1,0 ) );
					float2 ifLocalVar88_g60753 = 0;
					if( temp_output_56_0_g60753 > 0.0 )
					ifLocalVar88_g60753 = temp_output_90_0_g60753;
					else if( temp_output_56_0_g60753 == 0.0 )
					ifLocalVar88_g60753 = temp_output_123_0_g60753;
					else if( temp_output_56_0_g60753 < 0.0 )
					ifLocalVar88_g60753 = temp_output_123_0_g60753;
					float3 temp_output_7_0_g60755 = frac( ( (ifLocalVar88_g60753).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60755 = dot( temp_output_7_0_g60755 , ( (temp_output_7_0_g60755).yzx + 33.33 ) );
					float3 temp_output_12_0_g60755 = ( temp_output_7_0_g60755 + dotResult8_g60755 );
					float2 temp_output_597_26_g60752 = ( UV100_g60753 + frac( ( ( (temp_output_12_0_g60755).xx + (temp_output_12_0_g60755).yz ) * (temp_output_12_0_g60755).zy ) ) );
					float temp_output_66_0_g60753 = ( 1.0 - break55_g60753.y );
					float ifLocalVar60_g60753 = 0;
					if( temp_output_56_0_g60753 <= 0.0 )
					ifLocalVar60_g60753 = temp_output_66_0_g60753;
					else
					ifLocalVar60_g60753 = break55_g60753.y;
					float temp_output_597_28_g60752 = ifLocalVar60_g60753;
					float2 ifLocalVar89_g60753 = 0;
					if( temp_output_56_0_g60753 > 0.0 )
					ifLocalVar89_g60753 = temp_output_123_0_g60753;
					else if( temp_output_56_0_g60753 == 0.0 )
					ifLocalVar89_g60753 = temp_output_90_0_g60753;
					else if( temp_output_56_0_g60753 < 0.0 )
					ifLocalVar89_g60753 = temp_output_90_0_g60753;
					float3 temp_output_7_0_g60756 = frac( ( (ifLocalVar89_g60753).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60756 = dot( temp_output_7_0_g60756 , ( (temp_output_7_0_g60756).yzx + 33.33 ) );
					float3 temp_output_12_0_g60756 = ( temp_output_7_0_g60756 + dotResult8_g60756 );
					float2 temp_output_597_27_g60752 = ( UV100_g60753 + frac( ( ( (temp_output_12_0_g60756).xx + (temp_output_12_0_g60756).yz ) * (temp_output_12_0_g60756).zy ) ) );
					float temp_output_67_0_g60753 = ( 1.0 - break55_g60753.x );
					float ifLocalVar61_g60753 = 0;
					if( temp_output_56_0_g60753 <= 0.0 )
					ifLocalVar61_g60753 = temp_output_67_0_g60753;
					else
					ifLocalVar61_g60753 = break55_g60753.x;
					float temp_output_597_29_g60752 = ifLocalVar61_g60753;
					float4 Output_2D293_g60752 = ( ( tex2D( _EmissionMap, temp_output_597_0_g60752, DDX631_g60752, DDY632_g60752 ) * temp_output_597_30_g60752 ) + ( tex2D( _EmissionMap, temp_output_597_26_g60752, DDX631_g60752, DDY632_g60752 ) * temp_output_597_28_g60752 ) + ( tex2D( _EmissionMap, temp_output_597_27_g60752, DDX631_g60752, DDY632_g60752 ) * temp_output_597_29_g60752 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g60740 = Output_2D293_g60752;
					#else
					float4 staticSwitch1006_g60740 = tex2D( _EmissionMap, UV02420_g60740 );
					#endif
					#if defined( _SPECIALEFFECTS_DISABLED )
					float4 staticSwitch1578_g60740 = staticSwitch1006_g60740;
					#elif defined( _SPECIALEFFECTS_LED )
					float4 staticSwitch1578_g60740 = float4( 0,0,0,0 );
					#else
					float4 staticSwitch1578_g60740 = staticSwitch1006_g60740;
					#endif
					#ifdef _EMISSIONENABLED_ON
					float4 staticSwitch1017_g60740 = ( float4( _EmissionColor , 0.0 ) * staticSwitch1578_g60740 * _EmissionIntensity );
					#else
					float4 staticSwitch1017_g60740 = temp_cast_5;
					#endif
					float4 Emission86_g60740 = staticSwitch1017_g60740;
					float3 WorldPos97_g60792 = PositionWS;
					float3 tanNormal85_g60792 = Normal_Map700_g60740;
					float3 worldNormal85_g60792 = float3( dot( tanToWorld0, tanNormal85_g60792 ), dot( tanToWorld1, tanNormal85_g60792 ), dot( tanToWorld2, tanNormal85_g60792 ) );
					float3 WorldNormal97_g60792 = worldNormal85_g60792;
					float Smoothness97_g60792 = Smoothness1399_g60740;
					float3 LightmapColor97_g60792 = Lightmap46_g60740.rgb;
					float3 ViewDir97_g60792 = ViewDirWS;
					float3 localSpecular97_g60792 = Specular( WorldPos97_g60792 , WorldNormal97_g60792 , Smoothness97_g60792 , LightmapColor97_g60792 , ViewDir97_g60792 );
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1181_g60740 = Lightmap46_g60740;
					#else
					float4 staticSwitch1181_g60740 = ( ( aAlbedo1466_g60740 * Lightmap46_g60740 ) + Specular1419_g60740 + Emission86_g60740 + float4( localSpecular97_g60792 , 0.0 ) );
					#endif
					float4 temp_output_35_0_g60763 = staticSwitch1181_g60740;
					float4 Color353_g60763 = temp_output_35_0_g60763;
					#if defined( _LUTMODE_2D )
					float4 staticSwitch273_g60763 = saturate( temp_output_35_0_g60763 );
					#elif defined( _LUTMODE_3D )
					float4 staticSwitch273_g60763 = temp_output_35_0_g60763;
					#else
					float4 staticSwitch273_g60763 = temp_output_35_0_g60763;
					#endif
					float4 Color_Saturate49_g60763 = staticSwitch273_g60763;
					float Lut_Height213_g60763 = _LUTSize;
					float Lut_Width216_g60763 = ( _LUTSize * Lut_Height213_g60763 );
					float3 appendResult214_g60763 = (float3(( 1.0 / Lut_Width216_g60763 ) , ( 1.0 / Lut_Height213_g60763 ) , ( Lut_Height213_g60763 - 1.0 )));
					float3 Scale_Offset208_g60763 = appendResult214_g60763;
					float2 Scale_Factor292_g60763 = ( (Scale_Offset208_g60763).xy * (Scale_Offset208_g60763).z );
					float2 Offset299_g60763 = ( (Scale_Offset208_g60763).xy * 0.5 );
					float3 Adjusted_UV305_g60763 = ( ( (Color_Saturate49_g60763).xyw * float3( Scale_Factor292_g60763 ,  0.0 ) ) + float3( Offset299_g60763 ,  0.0 ) );
					float2 Scaled_Blue280_g60763 = ( (Color_Saturate49_g60763).zw * (Scale_Offset208_g60763).z );
					float2 Shift288_g60763 = floor( Scaled_Blue280_g60763 );
					float2 Final_X313_g60763 = ( (Adjusted_UV305_g60763).xz + ( Shift288_g60763 * (Scale_Offset208_g60763).y ) );
					float2 appendResult326_g60763 = (float2(Final_X313_g60763));
					float2 Final_UV325_g60763 = appendResult326_g60763;
					float2 appendResult338_g60763 = (float2((Scale_Offset208_g60763).y , 0.0));
					float2 Offset_UV336_g60763 = ( Final_UV325_g60763 + appendResult338_g60763 );
					float3 lerpResult333_g60763 = lerp( tex2D( _2DLut, Final_UV325_g60763 ).rgb , tex2D( _2DLut, Offset_UV336_g60763 ).rgb , float3( ( Scaled_Blue280_g60763 - Shift288_g60763 ) ,  0.0 ));
					#ifdef _2DLUT
					float4 staticSwitch347_g60763 = float4( lerpResult333_g60763 , 0.0 );
					#else
					float4 staticSwitch347_g60763 = Color_Saturate49_g60763;
					#endif
					float4 TwoD_LUT346_g60763 = staticSwitch347_g60763;
					float3 RGB16_g60764 = ( ( log10( ( ( Color_Saturate49_g60763.xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 );
					#ifdef _3DLUT
					float4 staticSwitch194_g60763 = tex3D( _3DLut, RGB16_g60764 );
					#else
					float4 staticSwitch194_g60763 = Color_Saturate49_g60763;
					#endif
					float4 ThreeD_LUT51_g60763 = staticSwitch194_g60763;
					#if defined( _LUTMODE_2D )
					float4 staticSwitch42_g60763 = TwoD_LUT346_g60763;
					#elif defined( _LUTMODE_3D )
					float4 staticSwitch42_g60763 = ThreeD_LUT51_g60763;
					#else
					float4 staticSwitch42_g60763 = ThreeD_LUT51_g60763;
					#endif
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch41_g60763 = staticSwitch42_g60763;
					#else
					float4 staticSwitch41_g60763 = Color353_g60763;
					#endif
					

					o.Albedo = staticSwitch1180_g60740.rgb;
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

					o.Emission = staticSwitch41_g60763.xyz;
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
			
			Name "Deferred"
			Tags { "LightMode"="Deferred" }

			AlphaToMask Off

			CGPROGRAM
				#define ASE_GEOMETRY
				#define ASE_FRAGMENT_NORMAL 0
				#define ASE_RECEIVE_SHADOWS
				#pragma multi_compile_instancing
				#pragma multi_compile _ LOD_FADE_CROSSFADE
				#define _SPECULARHIGHLIGHTS_OFF
				#define _GLOSSYREFLECTIONS_OFF
				#define ASE_NO_AMBIENT 1
				#define ASE_LIGHTING_SIMPLE 1
				#define ASE_VERSION 19907

				#pragma vertex vert
				#pragma fragment frag
				#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
				#pragma multi_compile_prepassfinal
				#ifndef UNITY_PASS_DEFERRED
					#define UNITY_PASS_DEFERRED
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
					float4 ase_texcoord4 : TEXCOORD4;
					UNITY_VERTEX_INPUT_INSTANCE_ID
					UNITY_VERTEX_OUTPUT_STEREO
				};

				#ifdef LIGHTMAP_ON
				float4 unity_LightmapFade;
				#endif
				half4 unity_Ambient;
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
				

				v2f VertexFunction (appdata v  ) {
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					o.ase_texcoord4 = v.texcoord.xyzw;

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

				void frag (v2f IN , uint ase_vface : SV_IsFrontFace
					, out half4 outGBuffer0 : SV_Target0
					, out half4 outGBuffer1 : SV_Target1
					, out half4 outGBuffer2 : SV_Target2
					, out half4 outEmission : SV_Target3
					#if defined(SHADOWS_SHADOWMASK) && (UNITY_ALLOWED_MRT_COUNT > 4)
					, out half4 outShadowMask : SV_Target4
					#endif
					#if defined( ASE_DEPTH_WRITE_ON )
					, out float outputDepth : SV_Depth
					#endif
				)
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

					float3 PositionWS = IN.worldPos.xyz;
					half3 ViewDirWS = normalize( UnityWorldSpaceViewDir( PositionWS ) );
					float4 ScreenPosNorm = float4( IN.pos.xy * ( _ScreenParams.zw - 1.0 ), IN.pos.zw );
					float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, IN.pos.z ) * IN.pos.w;
					float4 ScreenPos = ComputeScreenPos( ClipPos );
					half3 NormalWS = IN.normalWS;
					half3 TangentWS = IN.tangentWS.xyz;
					half3 BitangentWS = cross( IN.normalWS, IN.tangentWS.xyz ) * IN.tangentWS.w * unity_WorldTransformParams.w;

					#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
						float2 sampleCoords = (IN.tangentWS.zw / _TerrainHeightmapRecipSize.zw + 0.5f) * _TerrainHeightmapRecipSize.xy;
						NormalWS = UnityObjectToWorldNormal(normalize(tex2D(_TerrainNormalmapTexture, sampleCoords).rgb * 2 - 1));
						TangentWS = -cross(unity_ObjectToWorld._13_23_33, NormalWS);
						BitangentWS = cross(NormalWS, -TangentWS);
					#endif

					float2 texCoord2357_g60740 = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV02420_g60740 = texCoord2357_g60740;
					float2 temp_output_5_0_g60787 = UV02420_g60740;
					float2 UV633_g60787 = temp_output_5_0_g60787;
					float2 UV100_g60788 = UV633_g60787;
					float2 temp_output_51_0_g60788 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60788 * float2( 3.464,3.464 ) ) );
					float2 break55_g60788 = frac( temp_output_51_0_g60788 );
					float temp_output_56_0_g60788 = ( ( 1.0 - break55_g60788.x ) - break55_g60788.y );
					float2 temp_output_52_0_g60788 = floor( temp_output_51_0_g60788 );
					float2 temp_output_125_0_g60788 = ( temp_output_52_0_g60788 + float2( 1,1 ) );
					float2 ifLocalVar87_g60788 = 0;
					if( temp_output_56_0_g60788 > 0.0 )
					ifLocalVar87_g60788 = temp_output_52_0_g60788;
					else if( temp_output_56_0_g60788 == 0.0 )
					ifLocalVar87_g60788 = temp_output_125_0_g60788;
					else if( temp_output_56_0_g60788 < 0.0 )
					ifLocalVar87_g60788 = temp_output_125_0_g60788;
					float3 temp_output_7_0_g60789 = frac( ( (ifLocalVar87_g60788).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60789 = dot( temp_output_7_0_g60789 , ( (temp_output_7_0_g60789).yzx + 33.33 ) );
					float3 temp_output_12_0_g60789 = ( temp_output_7_0_g60789 + dotResult8_g60789 );
					float2 temp_output_597_0_g60787 = ( UV100_g60788 + frac( ( ( (temp_output_12_0_g60789).xx + (temp_output_12_0_g60789).yz ) * (temp_output_12_0_g60789).zy ) ) );
					float2 DDX631_g60787 = ddx( temp_output_5_0_g60787 );
					float2 DDY632_g60787 = ddy( temp_output_5_0_g60787 );
					float temp_output_65_0_g60788 = ( 0.0 - temp_output_56_0_g60788 );
					float ifLocalVar59_g60788 = 0;
					if( temp_output_56_0_g60788 <= 0.0 )
					ifLocalVar59_g60788 = temp_output_65_0_g60788;
					else
					ifLocalVar59_g60788 = temp_output_56_0_g60788;
					float temp_output_597_30_g60787 = ifLocalVar59_g60788;
					float2 temp_output_90_0_g60788 = ( temp_output_52_0_g60788 + float2( 0,1 ) );
					float2 temp_output_123_0_g60788 = ( temp_output_52_0_g60788 + float2( 1,0 ) );
					float2 ifLocalVar88_g60788 = 0;
					if( temp_output_56_0_g60788 > 0.0 )
					ifLocalVar88_g60788 = temp_output_90_0_g60788;
					else if( temp_output_56_0_g60788 == 0.0 )
					ifLocalVar88_g60788 = temp_output_123_0_g60788;
					else if( temp_output_56_0_g60788 < 0.0 )
					ifLocalVar88_g60788 = temp_output_123_0_g60788;
					float3 temp_output_7_0_g60790 = frac( ( (ifLocalVar88_g60788).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60790 = dot( temp_output_7_0_g60790 , ( (temp_output_7_0_g60790).yzx + 33.33 ) );
					float3 temp_output_12_0_g60790 = ( temp_output_7_0_g60790 + dotResult8_g60790 );
					float2 temp_output_597_26_g60787 = ( UV100_g60788 + frac( ( ( (temp_output_12_0_g60790).xx + (temp_output_12_0_g60790).yz ) * (temp_output_12_0_g60790).zy ) ) );
					float temp_output_66_0_g60788 = ( 1.0 - break55_g60788.y );
					float ifLocalVar60_g60788 = 0;
					if( temp_output_56_0_g60788 <= 0.0 )
					ifLocalVar60_g60788 = temp_output_66_0_g60788;
					else
					ifLocalVar60_g60788 = break55_g60788.y;
					float temp_output_597_28_g60787 = ifLocalVar60_g60788;
					float2 ifLocalVar89_g60788 = 0;
					if( temp_output_56_0_g60788 > 0.0 )
					ifLocalVar89_g60788 = temp_output_123_0_g60788;
					else if( temp_output_56_0_g60788 == 0.0 )
					ifLocalVar89_g60788 = temp_output_90_0_g60788;
					else if( temp_output_56_0_g60788 < 0.0 )
					ifLocalVar89_g60788 = temp_output_90_0_g60788;
					float3 temp_output_7_0_g60791 = frac( ( (ifLocalVar89_g60788).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60791 = dot( temp_output_7_0_g60791 , ( (temp_output_7_0_g60791).yzx + 33.33 ) );
					float3 temp_output_12_0_g60791 = ( temp_output_7_0_g60791 + dotResult8_g60791 );
					float2 temp_output_597_27_g60787 = ( UV100_g60788 + frac( ( ( (temp_output_12_0_g60791).xx + (temp_output_12_0_g60791).yz ) * (temp_output_12_0_g60791).zy ) ) );
					float temp_output_67_0_g60788 = ( 1.0 - break55_g60788.x );
					float ifLocalVar61_g60788 = 0;
					if( temp_output_56_0_g60788 <= 0.0 )
					ifLocalVar61_g60788 = temp_output_67_0_g60788;
					else
					ifLocalVar61_g60788 = break55_g60788.x;
					float temp_output_597_29_g60787 = ifLocalVar61_g60788;
					float4 Output_2D293_g60787 = ( ( tex2D( _MainTex, temp_output_597_0_g60787, DDX631_g60787, DDY632_g60787 ) * temp_output_597_30_g60787 ) + ( tex2D( _MainTex, temp_output_597_26_g60787, DDX631_g60787, DDY632_g60787 ) * temp_output_597_28_g60787 ) + ( tex2D( _MainTex, temp_output_597_27_g60787, DDX631_g60787, DDY632_g60787 ) * temp_output_597_29_g60787 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g60740 = Output_2D293_g60787;
					#else
					float4 staticSwitch1001_g60740 = tex2D( _MainTex, UV02420_g60740 );
					#endif
					#ifdef _MAINTEX
					float4 staticSwitch1549_g60740 = staticSwitch1001_g60740;
					#else
					float4 staticSwitch1549_g60740 = _Color;
					#endif
					float4 oAlbedo6_g60740 = staticSwitch1549_g60740;
					float Black1185_g60740 = 0.0;
					float4 temp_cast_0 = (Black1185_g60740).xxxx;
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1180_g60740 = temp_cast_0;
					#else
					float4 staticSwitch1180_g60740 = oAlbedo6_g60740;
					#endif
					
					float2 temp_output_5_0_g60746 = UV02420_g60740;
					float2 UV633_g60746 = temp_output_5_0_g60746;
					float2 UV100_g60747 = UV633_g60746;
					float2 temp_output_51_0_g60747 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60747 * float2( 3.464,3.464 ) ) );
					float2 break55_g60747 = frac( temp_output_51_0_g60747 );
					float temp_output_56_0_g60747 = ( ( 1.0 - break55_g60747.x ) - break55_g60747.y );
					float2 temp_output_52_0_g60747 = floor( temp_output_51_0_g60747 );
					float2 temp_output_125_0_g60747 = ( temp_output_52_0_g60747 + float2( 1,1 ) );
					float2 ifLocalVar87_g60747 = 0;
					if( temp_output_56_0_g60747 > 0.0 )
					ifLocalVar87_g60747 = temp_output_52_0_g60747;
					else if( temp_output_56_0_g60747 == 0.0 )
					ifLocalVar87_g60747 = temp_output_125_0_g60747;
					else if( temp_output_56_0_g60747 < 0.0 )
					ifLocalVar87_g60747 = temp_output_125_0_g60747;
					float3 temp_output_7_0_g60748 = frac( ( (ifLocalVar87_g60747).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60748 = dot( temp_output_7_0_g60748 , ( (temp_output_7_0_g60748).yzx + 33.33 ) );
					float3 temp_output_12_0_g60748 = ( temp_output_7_0_g60748 + dotResult8_g60748 );
					float2 temp_output_597_0_g60746 = ( UV100_g60747 + frac( ( ( (temp_output_12_0_g60748).xx + (temp_output_12_0_g60748).yz ) * (temp_output_12_0_g60748).zy ) ) );
					float2 DDX631_g60746 = ddx( temp_output_5_0_g60746 );
					float2 DDY632_g60746 = ddy( temp_output_5_0_g60746 );
					float temp_output_65_0_g60747 = ( 0.0 - temp_output_56_0_g60747 );
					float ifLocalVar59_g60747 = 0;
					if( temp_output_56_0_g60747 <= 0.0 )
					ifLocalVar59_g60747 = temp_output_65_0_g60747;
					else
					ifLocalVar59_g60747 = temp_output_56_0_g60747;
					float temp_output_597_30_g60746 = ifLocalVar59_g60747;
					float2 temp_output_90_0_g60747 = ( temp_output_52_0_g60747 + float2( 0,1 ) );
					float2 temp_output_123_0_g60747 = ( temp_output_52_0_g60747 + float2( 1,0 ) );
					float2 ifLocalVar88_g60747 = 0;
					if( temp_output_56_0_g60747 > 0.0 )
					ifLocalVar88_g60747 = temp_output_90_0_g60747;
					else if( temp_output_56_0_g60747 == 0.0 )
					ifLocalVar88_g60747 = temp_output_123_0_g60747;
					else if( temp_output_56_0_g60747 < 0.0 )
					ifLocalVar88_g60747 = temp_output_123_0_g60747;
					float3 temp_output_7_0_g60749 = frac( ( (ifLocalVar88_g60747).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60749 = dot( temp_output_7_0_g60749 , ( (temp_output_7_0_g60749).yzx + 33.33 ) );
					float3 temp_output_12_0_g60749 = ( temp_output_7_0_g60749 + dotResult8_g60749 );
					float2 temp_output_597_26_g60746 = ( UV100_g60747 + frac( ( ( (temp_output_12_0_g60749).xx + (temp_output_12_0_g60749).yz ) * (temp_output_12_0_g60749).zy ) ) );
					float temp_output_66_0_g60747 = ( 1.0 - break55_g60747.y );
					float ifLocalVar60_g60747 = 0;
					if( temp_output_56_0_g60747 <= 0.0 )
					ifLocalVar60_g60747 = temp_output_66_0_g60747;
					else
					ifLocalVar60_g60747 = break55_g60747.y;
					float temp_output_597_28_g60746 = ifLocalVar60_g60747;
					float2 ifLocalVar89_g60747 = 0;
					if( temp_output_56_0_g60747 > 0.0 )
					ifLocalVar89_g60747 = temp_output_123_0_g60747;
					else if( temp_output_56_0_g60747 == 0.0 )
					ifLocalVar89_g60747 = temp_output_90_0_g60747;
					else if( temp_output_56_0_g60747 < 0.0 )
					ifLocalVar89_g60747 = temp_output_90_0_g60747;
					float3 temp_output_7_0_g60750 = frac( ( (ifLocalVar89_g60747).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60750 = dot( temp_output_7_0_g60750 , ( (temp_output_7_0_g60750).yzx + 33.33 ) );
					float3 temp_output_12_0_g60750 = ( temp_output_7_0_g60750 + dotResult8_g60750 );
					float2 temp_output_597_27_g60746 = ( UV100_g60747 + frac( ( ( (temp_output_12_0_g60750).xx + (temp_output_12_0_g60750).yz ) * (temp_output_12_0_g60750).zy ) ) );
					float temp_output_67_0_g60747 = ( 1.0 - break55_g60747.x );
					float ifLocalVar61_g60747 = 0;
					if( temp_output_56_0_g60747 <= 0.0 )
					ifLocalVar61_g60747 = temp_output_67_0_g60747;
					else
					ifLocalVar61_g60747 = break55_g60747.x;
					float temp_output_597_29_g60746 = ifLocalVar61_g60747;
					float4 Output_2D293_g60746 = ( ( tex2D( _MetallicMap, temp_output_597_0_g60746, DDX631_g60746, DDY632_g60746 ) * temp_output_597_30_g60746 ) + ( tex2D( _MetallicMap, temp_output_597_26_g60746, DDX631_g60746, DDY632_g60746 ) * temp_output_597_28_g60746 ) + ( tex2D( _MetallicMap, temp_output_597_27_g60746, DDX631_g60746, DDY632_g60746 ) * temp_output_597_29_g60746 ) );
					float4 break31_g60746 = Output_2D293_g60746;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g60740 = break31_g60746.a;
					#else
					float staticSwitch1005_g60740 = tex2D( _MetallicMap, UV02420_g60740 ).a;
					#endif
					#ifdef _METALLICMAP
					float staticSwitch846_g60740 = staticSwitch1005_g60740;
					#else
					float staticSwitch846_g60740 = _Metallic;
					#endif
					float Metallic1239_g60740 = staticSwitch846_g60740;
					float4 aAlbedo1466_g60740 = ( staticSwitch1549_g60740 * ( 1.0 - Metallic1239_g60740 ) );
					float White38_g60740 = 1.0;
					float4 temp_cast_2 = (White38_g60740).xxxx;
					float4 texCoord2426_g60740 = IN.ase_texcoord4;
					texCoord2426_g60740.xy = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV12361_g60740 = (texCoord2426_g60740).zw;
					float localBicubicPrepare2_g60781 = ( 0.0 );
					float2 Input_UV100_g60781 = UV12361_g60740;
					float2 UV2_g60781 = Input_UV100_g60781;
					float4 TexelSize2_g60781 = _Lightmap0_TexelSize;
					float2 UV02_g60781 = float2( 0,0 );
					float2 UV12_g60781 = float2( 0,0 );
					float2 UV22_g60781 = float2( 0,0 );
					float2 UV32_g60781 = float2( 0,0 );
					float W02_g60781 = 0;
					float W12_g60781 = 0;
					{
					{
					 UV2_g60781 = UV2_g60781 * TexelSize2_g60781.zw - 0.5;
					    float2 f = frac( UV2_g60781 );
					    UV2_g60781 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g60781.x - 0.5, UV2_g60781.x + 1.5, UV2_g60781.y - 0.5, UV2_g60781.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60781.xyxy;
					    UV02_g60781 = off.xz;
					    UV12_g60781 = off.yz;
					    UV22_g60781 = off.xw;
					    UV32_g60781 = off.yw;
					    W02_g60781 = s.x / ( s.x + s.y );
					 W12_g60781 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g60781 = lerp( tex2D( _Lightmap0, UV32_g60781 ) , tex2D( _Lightmap0, UV22_g60781 ) , W02_g60781);
					float4 lerpResult45_g60781 = lerp( tex2D( _Lightmap0, UV12_g60781 ) , tex2D( _Lightmap0, UV02_g60781 ) , W02_g60781);
					float4 lerpResult44_g60781 = lerp( lerpResult46_g60781 , lerpResult45_g60781 , W12_g60781);
					float4 Output_2D_Auto131_g60781 = lerpResult44_g60781;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g60740 = Output_2D_Auto131_g60781;
					#else
					float4 staticSwitch1092_g60740 = tex2D( _Lightmap0, UV12361_g60740 );
					#endif
					float4 Lightmap_0925_g60740 = staticSwitch1092_g60740;
					float localBicubicPrepare2_g60779 = ( 0.0 );
					float2 Input_UV100_g60779 = UV12361_g60740;
					float2 UV2_g60779 = Input_UV100_g60779;
					float4 TexelSize2_g60779 = _Lightmap1_TexelSize;
					float2 UV02_g60779 = float2( 0,0 );
					float2 UV12_g60779 = float2( 0,0 );
					float2 UV22_g60779 = float2( 0,0 );
					float2 UV32_g60779 = float2( 0,0 );
					float W02_g60779 = 0;
					float W12_g60779 = 0;
					{
					{
					 UV2_g60779 = UV2_g60779 * TexelSize2_g60779.zw - 0.5;
					    float2 f = frac( UV2_g60779 );
					    UV2_g60779 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g60779.x - 0.5, UV2_g60779.x + 1.5, UV2_g60779.y - 0.5, UV2_g60779.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60779.xyxy;
					    UV02_g60779 = off.xz;
					    UV12_g60779 = off.yz;
					    UV22_g60779 = off.xw;
					    UV32_g60779 = off.yw;
					    W02_g60779 = s.x / ( s.x + s.y );
					 W12_g60779 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g60779 = lerp( tex2D( _Lightmap1, UV32_g60779 ) , tex2D( _Lightmap1, UV22_g60779 ) , W02_g60779);
					float4 lerpResult45_g60779 = lerp( tex2D( _Lightmap1, UV12_g60779 ) , tex2D( _Lightmap1, UV02_g60779 ) , W02_g60779);
					float4 lerpResult44_g60779 = lerp( lerpResult46_g60779 , lerpResult45_g60779 , W12_g60779);
					float4 Output_2D_Auto131_g60779 = lerpResult44_g60779;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g60740 = Output_2D_Auto131_g60779;
					#else
					float4 staticSwitch1088_g60740 = tex2D( _Lightmap1, UV12361_g60740 );
					#endif
					float4 Lightmap_1956_g60740 = staticSwitch1088_g60740;
					float4 lerpResult442_g60740 = lerp( Lightmap_0925_g60740 , Lightmap_1956_g60740 , _LIGHTMAPLERP);
					float4 Lightmap_Lerp932_g60740 = lerpResult442_g60740;
					float3 appendResult139_g60769 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float2 temp_output_5_0_g60741 = UV02420_g60740;
					float2 UV633_g60741 = temp_output_5_0_g60741;
					float2 UV100_g60742 = UV633_g60741;
					float2 temp_output_51_0_g60742 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60742 * float2( 3.464,3.464 ) ) );
					float2 break55_g60742 = frac( temp_output_51_0_g60742 );
					float temp_output_56_0_g60742 = ( ( 1.0 - break55_g60742.x ) - break55_g60742.y );
					float2 temp_output_52_0_g60742 = floor( temp_output_51_0_g60742 );
					float2 temp_output_125_0_g60742 = ( temp_output_52_0_g60742 + float2( 1,1 ) );
					float2 ifLocalVar87_g60742 = 0;
					if( temp_output_56_0_g60742 > 0.0 )
					ifLocalVar87_g60742 = temp_output_52_0_g60742;
					else if( temp_output_56_0_g60742 == 0.0 )
					ifLocalVar87_g60742 = temp_output_125_0_g60742;
					else if( temp_output_56_0_g60742 < 0.0 )
					ifLocalVar87_g60742 = temp_output_125_0_g60742;
					float3 temp_output_7_0_g60743 = frac( ( (ifLocalVar87_g60742).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60743 = dot( temp_output_7_0_g60743 , ( (temp_output_7_0_g60743).yzx + 33.33 ) );
					float3 temp_output_12_0_g60743 = ( temp_output_7_0_g60743 + dotResult8_g60743 );
					float2 temp_output_597_0_g60741 = ( UV100_g60742 + frac( ( ( (temp_output_12_0_g60743).xx + (temp_output_12_0_g60743).yz ) * (temp_output_12_0_g60743).zy ) ) );
					float2 DDX631_g60741 = ddx( temp_output_5_0_g60741 );
					float2 DDY632_g60741 = ddy( temp_output_5_0_g60741 );
					float Input_Scale617_g60741 = 2.0;
					float temp_output_65_0_g60742 = ( 0.0 - temp_output_56_0_g60742 );
					float ifLocalVar59_g60742 = 0;
					if( temp_output_56_0_g60742 <= 0.0 )
					ifLocalVar59_g60742 = temp_output_65_0_g60742;
					else
					ifLocalVar59_g60742 = temp_output_56_0_g60742;
					float temp_output_597_30_g60741 = ifLocalVar59_g60742;
					float2 temp_output_90_0_g60742 = ( temp_output_52_0_g60742 + float2( 0,1 ) );
					float2 temp_output_123_0_g60742 = ( temp_output_52_0_g60742 + float2( 1,0 ) );
					float2 ifLocalVar88_g60742 = 0;
					if( temp_output_56_0_g60742 > 0.0 )
					ifLocalVar88_g60742 = temp_output_90_0_g60742;
					else if( temp_output_56_0_g60742 == 0.0 )
					ifLocalVar88_g60742 = temp_output_123_0_g60742;
					else if( temp_output_56_0_g60742 < 0.0 )
					ifLocalVar88_g60742 = temp_output_123_0_g60742;
					float3 temp_output_7_0_g60744 = frac( ( (ifLocalVar88_g60742).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60744 = dot( temp_output_7_0_g60744 , ( (temp_output_7_0_g60744).yzx + 33.33 ) );
					float3 temp_output_12_0_g60744 = ( temp_output_7_0_g60744 + dotResult8_g60744 );
					float2 temp_output_597_26_g60741 = ( UV100_g60742 + frac( ( ( (temp_output_12_0_g60744).xx + (temp_output_12_0_g60744).yz ) * (temp_output_12_0_g60744).zy ) ) );
					float temp_output_66_0_g60742 = ( 1.0 - break55_g60742.y );
					float ifLocalVar60_g60742 = 0;
					if( temp_output_56_0_g60742 <= 0.0 )
					ifLocalVar60_g60742 = temp_output_66_0_g60742;
					else
					ifLocalVar60_g60742 = break55_g60742.y;
					float temp_output_597_28_g60741 = ifLocalVar60_g60742;
					float2 ifLocalVar89_g60742 = 0;
					if( temp_output_56_0_g60742 > 0.0 )
					ifLocalVar89_g60742 = temp_output_123_0_g60742;
					else if( temp_output_56_0_g60742 == 0.0 )
					ifLocalVar89_g60742 = temp_output_90_0_g60742;
					else if( temp_output_56_0_g60742 < 0.0 )
					ifLocalVar89_g60742 = temp_output_90_0_g60742;
					float3 temp_output_7_0_g60745 = frac( ( (ifLocalVar89_g60742).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60745 = dot( temp_output_7_0_g60745 , ( (temp_output_7_0_g60745).yzx + 33.33 ) );
					float3 temp_output_12_0_g60745 = ( temp_output_7_0_g60745 + dotResult8_g60745 );
					float2 temp_output_597_27_g60741 = ( UV100_g60742 + frac( ( ( (temp_output_12_0_g60745).xx + (temp_output_12_0_g60745).yz ) * (temp_output_12_0_g60745).zy ) ) );
					float temp_output_67_0_g60742 = ( 1.0 - break55_g60742.x );
					float ifLocalVar61_g60742 = 0;
					if( temp_output_56_0_g60742 <= 0.0 )
					ifLocalVar61_g60742 = temp_output_67_0_g60742;
					else
					ifLocalVar61_g60742 = break55_g60742.x;
					float temp_output_597_29_g60741 = ifLocalVar61_g60742;
					float3 Output_2D_Normal641_g60741 = ( ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_0_g60741, DDX631_g60741, DDY632_g60741 ), Input_Scale617_g60741 ) * temp_output_597_30_g60741 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_26_g60741, DDX631_g60741, DDY632_g60741 ), Input_Scale617_g60741 ) * temp_output_597_28_g60741 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_27_g60741, DDX631_g60741, DDY632_g60741 ), Input_Scale617_g60741 ) * float3( 0,0,0 ) * temp_output_597_29_g60741 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g60740 = Output_2D_Normal641_g60741;
					#else
					float3 staticSwitch1003_g60740 = UnpackScaleNormal( tex2D( _BumpMap, UV02420_g60740 ), 2.0 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g60740 = staticSwitch1003_g60740;
					#else
					float3 staticSwitch980_g60740 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g60740 = staticSwitch980_g60740;
					float3 normalizeResult326_g60769 = normalize( Normal_Map700_g60740 );
					float3 Normal_Map318_g60769 = normalizeResult326_g60769;
					float dotResult121_g60769 = dot( appendResult139_g60769 , Normal_Map318_g60769 );
					float temp_output_2_0_g60772 = saturate( dotResult121_g60769 );
					float localStochasticTiling2_g60783 = ( 0.0 );
					float2 UV2_g60783 = UV12361_g60740;
					float4 TexelSize2_g60783 = _RNMX0_TexelSize;
					float4 Offsets2_g60783 = float4( 0,0,0,0 );
					float2 Weights2_g60783 = float2( 0,0 );
					{
					UV2_g60783 = UV2_g60783 * TexelSize2_g60783.zw - 0.5;
					float2 f = frac( UV2_g60783 );
					UV2_g60783 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g60783.x - 0.5, UV2_g60783.x + 1.5, UV2_g60783.y - 0.5, UV2_g60783.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g60783 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60783.xyxy;
					Weights2_g60783 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g60782 = Offsets2_g60783;
					float4 Input_FetchOffsets197_g60784 = temp_output_1_34_g60782;
					float2 temp_output_1_54_g60782 = Weights2_g60783;
					float2 Input_FetchWeights200_g60784 = temp_output_1_54_g60782;
					float2 break187_g60784 = Input_FetchWeights200_g60784;
					float4 lerpResult181_g60784 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g60784).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g60784).xw ) , break187_g60784.x);
					float4 lerpResult182_g60784 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g60784).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g60784).xz ) , break187_g60784.x);
					float4 lerpResult176_g60784 = lerp( lerpResult181_g60784 , lerpResult182_g60784 , break187_g60784.y);
					float4 Output_Fetch2D_Auto202_g60784 = lerpResult176_g60784;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g60740 = Output_Fetch2D_Auto202_g60784;
					#else
					float4 staticSwitch1061_g60740 = tex2D( _RNMX0, UV12361_g60740 );
					#endif
					float3 appendResult146_g60769 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g60769 = dot( appendResult146_g60769 , Normal_Map318_g60769 );
					float temp_output_2_0_g60771 = saturate( dotResult122_g60769 );
					float4 Input_FetchOffsets197_g60785 = temp_output_1_34_g60782;
					float2 Input_FetchWeights200_g60785 = temp_output_1_54_g60782;
					float2 break187_g60785 = Input_FetchWeights200_g60785;
					float4 lerpResult181_g60785 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g60785).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g60785).xw ) , break187_g60785.x);
					float4 lerpResult182_g60785 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g60785).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g60785).xz ) , break187_g60785.x);
					float4 lerpResult176_g60785 = lerp( lerpResult181_g60785 , lerpResult182_g60785 , break187_g60785.y);
					float4 Output_Fetch2D_Auto202_g60785 = lerpResult176_g60785;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g60740 = Output_Fetch2D_Auto202_g60785;
					#else
					float4 staticSwitch1062_g60740 = tex2D( _RNMY0, UV12361_g60740 );
					#endif
					float3 appendResult149_g60769 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g60769 = dot( appendResult149_g60769 , Normal_Map318_g60769 );
					float temp_output_2_0_g60770 = saturate( dotResult120_g60769 );
					float4 Input_FetchOffsets197_g60786 = temp_output_1_34_g60782;
					float2 Input_FetchWeights200_g60786 = temp_output_1_54_g60782;
					float2 break187_g60786 = Input_FetchWeights200_g60786;
					float4 lerpResult181_g60786 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g60786).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g60786).xw ) , break187_g60786.x);
					float4 lerpResult182_g60786 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g60786).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g60786).xz ) , break187_g60786.x);
					float4 lerpResult176_g60786 = lerp( lerpResult181_g60786 , lerpResult182_g60786 , break187_g60786.y);
					float4 Output_Fetch2D_Auto202_g60786 = lerpResult176_g60786;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g60740 = Output_Fetch2D_Auto202_g60786;
					#else
					float4 staticSwitch1063_g60740 = tex2D( _RNMZ0, UV12361_g60740 );
					#endif
					float4 RNM_0926_g60740 = ( ( ( ( temp_output_2_0_g60772 * temp_output_2_0_g60772 ) * staticSwitch1061_g60740 ) + ( ( temp_output_2_0_g60771 * temp_output_2_0_g60771 ) * staticSwitch1062_g60740 ) ) + ( ( temp_output_2_0_g60770 * temp_output_2_0_g60770 ) * staticSwitch1063_g60740 ) );
					float3 appendResult139_g60765 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g60765 = normalize( Normal_Map700_g60740 );
					float3 Normal_Map318_g60765 = normalizeResult326_g60765;
					float dotResult121_g60765 = dot( appendResult139_g60765 , Normal_Map318_g60765 );
					float temp_output_2_0_g60768 = saturate( dotResult121_g60765 );
					float localStochasticTiling2_g60774 = ( 0.0 );
					float2 UV2_g60774 = UV12361_g60740;
					float4 TexelSize2_g60774 = _RNMX1_TexelSize;
					float4 Offsets2_g60774 = float4( 0,0,0,0 );
					float2 Weights2_g60774 = float2( 0,0 );
					{
					UV2_g60774 = UV2_g60774 * TexelSize2_g60774.zw - 0.5;
					float2 f = frac( UV2_g60774 );
					UV2_g60774 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g60774.x - 0.5, UV2_g60774.x + 1.5, UV2_g60774.y - 0.5, UV2_g60774.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g60774 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60774.xyxy;
					Weights2_g60774 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g60773 = Offsets2_g60774;
					float4 Input_FetchOffsets197_g60775 = temp_output_1_34_g60773;
					float2 temp_output_1_54_g60773 = Weights2_g60774;
					float2 Input_FetchWeights200_g60775 = temp_output_1_54_g60773;
					float2 break187_g60775 = Input_FetchWeights200_g60775;
					float4 lerpResult181_g60775 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g60775).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g60775).xw ) , break187_g60775.x);
					float4 lerpResult182_g60775 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g60775).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g60775).xz ) , break187_g60775.x);
					float4 lerpResult176_g60775 = lerp( lerpResult181_g60775 , lerpResult182_g60775 , break187_g60775.y);
					float4 Output_Fetch2D_Auto202_g60775 = lerpResult176_g60775;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g60740 = Output_Fetch2D_Auto202_g60775;
					#else
					float4 staticSwitch1087_g60740 = tex2D( _RNMX1, UV12361_g60740 );
					#endif
					float3 appendResult146_g60765 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g60765 = dot( appendResult146_g60765 , Normal_Map318_g60765 );
					float temp_output_2_0_g60767 = saturate( dotResult122_g60765 );
					float4 Input_FetchOffsets197_g60776 = temp_output_1_34_g60773;
					float2 Input_FetchWeights200_g60776 = temp_output_1_54_g60773;
					float2 break187_g60776 = Input_FetchWeights200_g60776;
					float4 lerpResult181_g60776 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g60776).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g60776).xw ) , break187_g60776.x);
					float4 lerpResult182_g60776 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g60776).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g60776).xz ) , break187_g60776.x);
					float4 lerpResult176_g60776 = lerp( lerpResult181_g60776 , lerpResult182_g60776 , break187_g60776.y);
					float4 Output_Fetch2D_Auto202_g60776 = lerpResult176_g60776;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g60740 = Output_Fetch2D_Auto202_g60776;
					#else
					float4 staticSwitch1083_g60740 = tex2D( _RNMY1, UV12361_g60740 );
					#endif
					float3 appendResult149_g60765 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g60765 = dot( appendResult149_g60765 , Normal_Map318_g60765 );
					float temp_output_2_0_g60766 = saturate( dotResult120_g60765 );
					float4 Input_FetchOffsets197_g60777 = temp_output_1_34_g60773;
					float2 Input_FetchWeights200_g60777 = temp_output_1_54_g60773;
					float2 break187_g60777 = Input_FetchWeights200_g60777;
					float4 lerpResult181_g60777 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g60777).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g60777).xw ) , break187_g60777.x);
					float4 lerpResult182_g60777 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g60777).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g60777).xz ) , break187_g60777.x);
					float4 lerpResult176_g60777 = lerp( lerpResult181_g60777 , lerpResult182_g60777 , break187_g60777.y);
					float4 Output_Fetch2D_Auto202_g60777 = lerpResult176_g60777;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g60740 = Output_Fetch2D_Auto202_g60777;
					#else
					float4 staticSwitch1084_g60740 = tex2D( _RNMZ1, UV12361_g60740 );
					#endif
					float4 RNM_11081_g60740 = ( ( ( ( temp_output_2_0_g60768 * temp_output_2_0_g60768 ) * staticSwitch1087_g60740 ) + ( ( temp_output_2_0_g60767 * temp_output_2_0_g60767 ) * staticSwitch1083_g60740 ) ) + ( ( temp_output_2_0_g60766 * temp_output_2_0_g60766 ) * staticSwitch1084_g60740 ) );
					float Lightmap_Lerp_Value969_g60740 = _LIGHTMAPLERP;
					float4 lerpResult953_g60740 = lerp( RNM_0926_g60740 , RNM_11081_g60740 , Lightmap_Lerp_Value969_g60740);
					float4 RNM_Lerp950_g60740 = lerpResult953_g60740;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g60740 = temp_cast_2;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g60740 = Lightmap_0925_g60740;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g60740 = Lightmap_Lerp932_g60740;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g60740 = RNM_0926_g60740;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g60740 = RNM_Lerp950_g60740;
					#else
					float4 staticSwitch1014_g60740 = temp_cast_2;
					#endif
					float4 Lightmap46_g60740 = staticSwitch1014_g60740;
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal1392_g60740 = Normal_Map700_g60740;
					float2 temp_output_5_0_g60758 = UV02420_g60740;
					float2 UV633_g60758 = temp_output_5_0_g60758;
					float2 UV100_g60759 = UV633_g60758;
					float2 temp_output_51_0_g60759 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60759 * float2( 3.464,3.464 ) ) );
					float2 break55_g60759 = frac( temp_output_51_0_g60759 );
					float temp_output_56_0_g60759 = ( ( 1.0 - break55_g60759.x ) - break55_g60759.y );
					float2 temp_output_52_0_g60759 = floor( temp_output_51_0_g60759 );
					float2 temp_output_125_0_g60759 = ( temp_output_52_0_g60759 + float2( 1,1 ) );
					float2 ifLocalVar87_g60759 = 0;
					if( temp_output_56_0_g60759 > 0.0 )
					ifLocalVar87_g60759 = temp_output_52_0_g60759;
					else if( temp_output_56_0_g60759 == 0.0 )
					ifLocalVar87_g60759 = temp_output_125_0_g60759;
					else if( temp_output_56_0_g60759 < 0.0 )
					ifLocalVar87_g60759 = temp_output_125_0_g60759;
					float3 temp_output_7_0_g60760 = frac( ( (ifLocalVar87_g60759).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60760 = dot( temp_output_7_0_g60760 , ( (temp_output_7_0_g60760).yzx + 33.33 ) );
					float3 temp_output_12_0_g60760 = ( temp_output_7_0_g60760 + dotResult8_g60760 );
					float2 temp_output_597_0_g60758 = ( UV100_g60759 + frac( ( ( (temp_output_12_0_g60760).xx + (temp_output_12_0_g60760).yz ) * (temp_output_12_0_g60760).zy ) ) );
					float2 DDX631_g60758 = ddx( temp_output_5_0_g60758 );
					float2 DDY632_g60758 = ddy( temp_output_5_0_g60758 );
					float temp_output_65_0_g60759 = ( 0.0 - temp_output_56_0_g60759 );
					float ifLocalVar59_g60759 = 0;
					if( temp_output_56_0_g60759 <= 0.0 )
					ifLocalVar59_g60759 = temp_output_65_0_g60759;
					else
					ifLocalVar59_g60759 = temp_output_56_0_g60759;
					float temp_output_597_30_g60758 = ifLocalVar59_g60759;
					float2 temp_output_90_0_g60759 = ( temp_output_52_0_g60759 + float2( 0,1 ) );
					float2 temp_output_123_0_g60759 = ( temp_output_52_0_g60759 + float2( 1,0 ) );
					float2 ifLocalVar88_g60759 = 0;
					if( temp_output_56_0_g60759 > 0.0 )
					ifLocalVar88_g60759 = temp_output_90_0_g60759;
					else if( temp_output_56_0_g60759 == 0.0 )
					ifLocalVar88_g60759 = temp_output_123_0_g60759;
					else if( temp_output_56_0_g60759 < 0.0 )
					ifLocalVar88_g60759 = temp_output_123_0_g60759;
					float3 temp_output_7_0_g60761 = frac( ( (ifLocalVar88_g60759).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60761 = dot( temp_output_7_0_g60761 , ( (temp_output_7_0_g60761).yzx + 33.33 ) );
					float3 temp_output_12_0_g60761 = ( temp_output_7_0_g60761 + dotResult8_g60761 );
					float2 temp_output_597_26_g60758 = ( UV100_g60759 + frac( ( ( (temp_output_12_0_g60761).xx + (temp_output_12_0_g60761).yz ) * (temp_output_12_0_g60761).zy ) ) );
					float temp_output_66_0_g60759 = ( 1.0 - break55_g60759.y );
					float ifLocalVar60_g60759 = 0;
					if( temp_output_56_0_g60759 <= 0.0 )
					ifLocalVar60_g60759 = temp_output_66_0_g60759;
					else
					ifLocalVar60_g60759 = break55_g60759.y;
					float temp_output_597_28_g60758 = ifLocalVar60_g60759;
					float2 ifLocalVar89_g60759 = 0;
					if( temp_output_56_0_g60759 > 0.0 )
					ifLocalVar89_g60759 = temp_output_123_0_g60759;
					else if( temp_output_56_0_g60759 == 0.0 )
					ifLocalVar89_g60759 = temp_output_90_0_g60759;
					else if( temp_output_56_0_g60759 < 0.0 )
					ifLocalVar89_g60759 = temp_output_90_0_g60759;
					float3 temp_output_7_0_g60762 = frac( ( (ifLocalVar89_g60759).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60762 = dot( temp_output_7_0_g60762 , ( (temp_output_7_0_g60762).yzx + 33.33 ) );
					float3 temp_output_12_0_g60762 = ( temp_output_7_0_g60762 + dotResult8_g60762 );
					float2 temp_output_597_27_g60758 = ( UV100_g60759 + frac( ( ( (temp_output_12_0_g60762).xx + (temp_output_12_0_g60762).yz ) * (temp_output_12_0_g60762).zy ) ) );
					float temp_output_67_0_g60759 = ( 1.0 - break55_g60759.x );
					float ifLocalVar61_g60759 = 0;
					if( temp_output_56_0_g60759 <= 0.0 )
					ifLocalVar61_g60759 = temp_output_67_0_g60759;
					else
					ifLocalVar61_g60759 = break55_g60759.x;
					float temp_output_597_29_g60758 = ifLocalVar61_g60759;
					float4 Output_2D293_g60758 = ( ( tex2D( _GlossinessMap, temp_output_597_0_g60758, DDX631_g60758, DDY632_g60758 ) * temp_output_597_30_g60758 ) + ( tex2D( _GlossinessMap, temp_output_597_26_g60758, DDX631_g60758, DDY632_g60758 ) * temp_output_597_28_g60758 ) + ( tex2D( _GlossinessMap, temp_output_597_27_g60758, DDX631_g60758, DDY632_g60758 ) * temp_output_597_29_g60758 ) );
					float4 break31_g60758 = Output_2D293_g60758;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g60740 = break31_g60758.a;
					#else
					float staticSwitch1004_g60740 = tex2D( _GlossinessMap, UV02420_g60740 ).r;
					#endif
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g60740 = ( 1.0 - staticSwitch1004_g60740 );
					#else
					float staticSwitch845_g60740 = _Glossiness;
					#endif
					float3 temp_output_3_0_g60751 = ddx( NormalWS );
					float dotResult5_g60751 = dot( temp_output_3_0_g60751 , temp_output_3_0_g60751 );
					float3 temp_output_4_0_g60751 = ddy( NormalWS );
					float dotResult6_g60751 = dot( temp_output_4_0_g60751 , temp_output_4_0_g60751 );
					#ifdef _USEGEOMETRICANTIALIASING_ON
					float staticSwitch824_g60740 = min( staticSwitch845_g60740, ( 1.0 - pow( saturate( max( dotResult5_g60751, dotResult6_g60751 ) ) , 0.333 ) ) );
					#else
					float staticSwitch824_g60740 = staticSwitch845_g60740;
					#endif
					float Smoothness1399_g60740 = staticSwitch824_g60740;
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
					Unity_GlossyEnvironmentData g1392_g60740 = UnityGlossyEnvironmentSetup( Smoothness1399_g60740, ViewDirWS, float3( dot( tanToWorld0, tanNormal1392_g60740 ), dot( tanToWorld1, tanNormal1392_g60740 ), dot( tanToWorld2, tanNormal1392_g60740 ) ), float3(0,0,0));
					float3 indirectSpecular1392_g60740 = UnityGI_IndirectSpecular( data, 1.0, float3( dot( tanToWorld0, tanNormal1392_g60740 ), dot( tanToWorld1, tanNormal1392_g60740 ), dot( tanToWorld2, tanNormal1392_g60740 ) ), g1392_g60740 );
					float4 temp_cast_4 = (0.04).xxxx;
					float4 lerpResult1473_g60740 = lerp( temp_cast_4 , oAlbedo6_g60740 , Metallic1239_g60740);
					float3 switchResult1501_g60740 = (((ase_vface>0)?(NormalWS):(-NormalWS)));
					float dotResult1476_g60740 = dot( switchResult1501_g60740 , ViewDirWS );
					float4 lerpResult1480_g60740 = lerp( lerpResult1473_g60740 , float4( 1,1,1,0 ) , pow( ( 1.0 - saturate( dotResult1476_g60740 ) ) , 5.0 ));
					float4 Fresnel1560_g60740 = lerpResult1480_g60740;
					float4 temp_output_1481_0_g60740 = ( float4( indirectSpecular1392_g60740 , 0.0 ) * Fresnel1560_g60740 );
					#ifdef _USELIGHTMAPSPECULAR_ON
					float4 staticSwitch1469_g60740 = ( temp_output_1481_0_g60740 * sqrt( Lightmap46_g60740 ) );
					#else
					float4 staticSwitch1469_g60740 = temp_output_1481_0_g60740;
					#endif
					float4 Specular1419_g60740 = staticSwitch1469_g60740;
					float4 temp_cast_5 = (Black1185_g60740).xxxx;
					float2 temp_output_5_0_g60752 = UV02420_g60740;
					float2 UV633_g60752 = temp_output_5_0_g60752;
					float2 UV100_g60753 = UV633_g60752;
					float2 temp_output_51_0_g60753 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60753 * float2( 3.464,3.464 ) ) );
					float2 break55_g60753 = frac( temp_output_51_0_g60753 );
					float temp_output_56_0_g60753 = ( ( 1.0 - break55_g60753.x ) - break55_g60753.y );
					float2 temp_output_52_0_g60753 = floor( temp_output_51_0_g60753 );
					float2 temp_output_125_0_g60753 = ( temp_output_52_0_g60753 + float2( 1,1 ) );
					float2 ifLocalVar87_g60753 = 0;
					if( temp_output_56_0_g60753 > 0.0 )
					ifLocalVar87_g60753 = temp_output_52_0_g60753;
					else if( temp_output_56_0_g60753 == 0.0 )
					ifLocalVar87_g60753 = temp_output_125_0_g60753;
					else if( temp_output_56_0_g60753 < 0.0 )
					ifLocalVar87_g60753 = temp_output_125_0_g60753;
					float3 temp_output_7_0_g60754 = frac( ( (ifLocalVar87_g60753).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60754 = dot( temp_output_7_0_g60754 , ( (temp_output_7_0_g60754).yzx + 33.33 ) );
					float3 temp_output_12_0_g60754 = ( temp_output_7_0_g60754 + dotResult8_g60754 );
					float2 temp_output_597_0_g60752 = ( UV100_g60753 + frac( ( ( (temp_output_12_0_g60754).xx + (temp_output_12_0_g60754).yz ) * (temp_output_12_0_g60754).zy ) ) );
					float2 DDX631_g60752 = ddx( temp_output_5_0_g60752 );
					float2 DDY632_g60752 = ddy( temp_output_5_0_g60752 );
					float temp_output_65_0_g60753 = ( 0.0 - temp_output_56_0_g60753 );
					float ifLocalVar59_g60753 = 0;
					if( temp_output_56_0_g60753 <= 0.0 )
					ifLocalVar59_g60753 = temp_output_65_0_g60753;
					else
					ifLocalVar59_g60753 = temp_output_56_0_g60753;
					float temp_output_597_30_g60752 = ifLocalVar59_g60753;
					float2 temp_output_90_0_g60753 = ( temp_output_52_0_g60753 + float2( 0,1 ) );
					float2 temp_output_123_0_g60753 = ( temp_output_52_0_g60753 + float2( 1,0 ) );
					float2 ifLocalVar88_g60753 = 0;
					if( temp_output_56_0_g60753 > 0.0 )
					ifLocalVar88_g60753 = temp_output_90_0_g60753;
					else if( temp_output_56_0_g60753 == 0.0 )
					ifLocalVar88_g60753 = temp_output_123_0_g60753;
					else if( temp_output_56_0_g60753 < 0.0 )
					ifLocalVar88_g60753 = temp_output_123_0_g60753;
					float3 temp_output_7_0_g60755 = frac( ( (ifLocalVar88_g60753).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60755 = dot( temp_output_7_0_g60755 , ( (temp_output_7_0_g60755).yzx + 33.33 ) );
					float3 temp_output_12_0_g60755 = ( temp_output_7_0_g60755 + dotResult8_g60755 );
					float2 temp_output_597_26_g60752 = ( UV100_g60753 + frac( ( ( (temp_output_12_0_g60755).xx + (temp_output_12_0_g60755).yz ) * (temp_output_12_0_g60755).zy ) ) );
					float temp_output_66_0_g60753 = ( 1.0 - break55_g60753.y );
					float ifLocalVar60_g60753 = 0;
					if( temp_output_56_0_g60753 <= 0.0 )
					ifLocalVar60_g60753 = temp_output_66_0_g60753;
					else
					ifLocalVar60_g60753 = break55_g60753.y;
					float temp_output_597_28_g60752 = ifLocalVar60_g60753;
					float2 ifLocalVar89_g60753 = 0;
					if( temp_output_56_0_g60753 > 0.0 )
					ifLocalVar89_g60753 = temp_output_123_0_g60753;
					else if( temp_output_56_0_g60753 == 0.0 )
					ifLocalVar89_g60753 = temp_output_90_0_g60753;
					else if( temp_output_56_0_g60753 < 0.0 )
					ifLocalVar89_g60753 = temp_output_90_0_g60753;
					float3 temp_output_7_0_g60756 = frac( ( (ifLocalVar89_g60753).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60756 = dot( temp_output_7_0_g60756 , ( (temp_output_7_0_g60756).yzx + 33.33 ) );
					float3 temp_output_12_0_g60756 = ( temp_output_7_0_g60756 + dotResult8_g60756 );
					float2 temp_output_597_27_g60752 = ( UV100_g60753 + frac( ( ( (temp_output_12_0_g60756).xx + (temp_output_12_0_g60756).yz ) * (temp_output_12_0_g60756).zy ) ) );
					float temp_output_67_0_g60753 = ( 1.0 - break55_g60753.x );
					float ifLocalVar61_g60753 = 0;
					if( temp_output_56_0_g60753 <= 0.0 )
					ifLocalVar61_g60753 = temp_output_67_0_g60753;
					else
					ifLocalVar61_g60753 = break55_g60753.x;
					float temp_output_597_29_g60752 = ifLocalVar61_g60753;
					float4 Output_2D293_g60752 = ( ( tex2D( _EmissionMap, temp_output_597_0_g60752, DDX631_g60752, DDY632_g60752 ) * temp_output_597_30_g60752 ) + ( tex2D( _EmissionMap, temp_output_597_26_g60752, DDX631_g60752, DDY632_g60752 ) * temp_output_597_28_g60752 ) + ( tex2D( _EmissionMap, temp_output_597_27_g60752, DDX631_g60752, DDY632_g60752 ) * temp_output_597_29_g60752 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g60740 = Output_2D293_g60752;
					#else
					float4 staticSwitch1006_g60740 = tex2D( _EmissionMap, UV02420_g60740 );
					#endif
					#if defined( _SPECIALEFFECTS_DISABLED )
					float4 staticSwitch1578_g60740 = staticSwitch1006_g60740;
					#elif defined( _SPECIALEFFECTS_LED )
					float4 staticSwitch1578_g60740 = float4( 0,0,0,0 );
					#else
					float4 staticSwitch1578_g60740 = staticSwitch1006_g60740;
					#endif
					#ifdef _EMISSIONENABLED_ON
					float4 staticSwitch1017_g60740 = ( float4( _EmissionColor , 0.0 ) * staticSwitch1578_g60740 * _EmissionIntensity );
					#else
					float4 staticSwitch1017_g60740 = temp_cast_5;
					#endif
					float4 Emission86_g60740 = staticSwitch1017_g60740;
					float3 WorldPos97_g60792 = PositionWS;
					float3 tanNormal85_g60792 = Normal_Map700_g60740;
					float3 worldNormal85_g60792 = float3( dot( tanToWorld0, tanNormal85_g60792 ), dot( tanToWorld1, tanNormal85_g60792 ), dot( tanToWorld2, tanNormal85_g60792 ) );
					float3 WorldNormal97_g60792 = worldNormal85_g60792;
					float Smoothness97_g60792 = Smoothness1399_g60740;
					float3 LightmapColor97_g60792 = Lightmap46_g60740.rgb;
					float3 ViewDir97_g60792 = ViewDirWS;
					float3 localSpecular97_g60792 = Specular( WorldPos97_g60792 , WorldNormal97_g60792 , Smoothness97_g60792 , LightmapColor97_g60792 , ViewDir97_g60792 );
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1181_g60740 = Lightmap46_g60740;
					#else
					float4 staticSwitch1181_g60740 = ( ( aAlbedo1466_g60740 * Lightmap46_g60740 ) + Specular1419_g60740 + Emission86_g60740 + float4( localSpecular97_g60792 , 0.0 ) );
					#endif
					float4 temp_output_35_0_g60763 = staticSwitch1181_g60740;
					float4 Color353_g60763 = temp_output_35_0_g60763;
					#if defined( _LUTMODE_2D )
					float4 staticSwitch273_g60763 = saturate( temp_output_35_0_g60763 );
					#elif defined( _LUTMODE_3D )
					float4 staticSwitch273_g60763 = temp_output_35_0_g60763;
					#else
					float4 staticSwitch273_g60763 = temp_output_35_0_g60763;
					#endif
					float4 Color_Saturate49_g60763 = staticSwitch273_g60763;
					float Lut_Height213_g60763 = _LUTSize;
					float Lut_Width216_g60763 = ( _LUTSize * Lut_Height213_g60763 );
					float3 appendResult214_g60763 = (float3(( 1.0 / Lut_Width216_g60763 ) , ( 1.0 / Lut_Height213_g60763 ) , ( Lut_Height213_g60763 - 1.0 )));
					float3 Scale_Offset208_g60763 = appendResult214_g60763;
					float2 Scale_Factor292_g60763 = ( (Scale_Offset208_g60763).xy * (Scale_Offset208_g60763).z );
					float2 Offset299_g60763 = ( (Scale_Offset208_g60763).xy * 0.5 );
					float3 Adjusted_UV305_g60763 = ( ( (Color_Saturate49_g60763).xyw * float3( Scale_Factor292_g60763 ,  0.0 ) ) + float3( Offset299_g60763 ,  0.0 ) );
					float2 Scaled_Blue280_g60763 = ( (Color_Saturate49_g60763).zw * (Scale_Offset208_g60763).z );
					float2 Shift288_g60763 = floor( Scaled_Blue280_g60763 );
					float2 Final_X313_g60763 = ( (Adjusted_UV305_g60763).xz + ( Shift288_g60763 * (Scale_Offset208_g60763).y ) );
					float2 appendResult326_g60763 = (float2(Final_X313_g60763));
					float2 Final_UV325_g60763 = appendResult326_g60763;
					float2 appendResult338_g60763 = (float2((Scale_Offset208_g60763).y , 0.0));
					float2 Offset_UV336_g60763 = ( Final_UV325_g60763 + appendResult338_g60763 );
					float3 lerpResult333_g60763 = lerp( tex2D( _2DLut, Final_UV325_g60763 ).rgb , tex2D( _2DLut, Offset_UV336_g60763 ).rgb , float3( ( Scaled_Blue280_g60763 - Shift288_g60763 ) ,  0.0 ));
					#ifdef _2DLUT
					float4 staticSwitch347_g60763 = float4( lerpResult333_g60763 , 0.0 );
					#else
					float4 staticSwitch347_g60763 = Color_Saturate49_g60763;
					#endif
					float4 TwoD_LUT346_g60763 = staticSwitch347_g60763;
					float3 RGB16_g60764 = ( ( log10( ( ( Color_Saturate49_g60763.xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 );
					#ifdef _3DLUT
					float4 staticSwitch194_g60763 = tex3D( _3DLut, RGB16_g60764 );
					#else
					float4 staticSwitch194_g60763 = Color_Saturate49_g60763;
					#endif
					float4 ThreeD_LUT51_g60763 = staticSwitch194_g60763;
					#if defined( _LUTMODE_2D )
					float4 staticSwitch42_g60763 = TwoD_LUT346_g60763;
					#elif defined( _LUTMODE_3D )
					float4 staticSwitch42_g60763 = ThreeD_LUT51_g60763;
					#else
					float4 staticSwitch42_g60763 = ThreeD_LUT51_g60763;
					#endif
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch41_g60763 = staticSwitch42_g60763;
					#else
					float4 staticSwitch41_g60763 = Color353_g60763;
					#endif
					

					o.Albedo = staticSwitch1180_g60740.rgb;
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

					o.Emission = staticSwitch41_g60763.xyz;
					o.Alpha = 1;
					half AlphaClipThreshold = 0.5;
					half3 BakedGI = 0;

					#if defined( ASE_DEPTH_WRITE_ON )
						float DeviceDepth = IN.pos.z;
					#endif

					#if ( ASE_FRAGMENT_NORMAL == 0 )
						o.Normal = normalize( o.Normal.x * TangentWS + o.Normal.y * BitangentWS + o.Normal.z * NormalWS );
					#elif ( ASE_FRAGMENT_NORMAL == 1 )
						o.Normal = UnityObjectToWorldNormal( o.Normal );
					#elif ( ASE_FRAGMENT_NORMAL == 2 )
						// @diogo: already in world-space; do nothing
					#endif

					#ifdef _ALPHATEST_ON
						clip( o.Alpha - AlphaClipThreshold );
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
					gi.light.color = 0;
					gi.light.dir = half3( 0, 1, 0 );

					UnityGIInput giInput;
					UNITY_INITIALIZE_OUTPUT(UnityGIInput, giInput);
					giInput.light = gi.light;
					giInput.worldPos = PositionWS;
					giInput.worldViewDir = ViewDirWS;
					giInput.atten = 1;
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

					#if defined(ASE_LIGHTING_SIMPLE)
						#if defined(_SPECULAR_SETUP)
							outEmission = LightingBlinnPhong_Deferred( o, ViewDirWS, gi, outGBuffer0, outGBuffer1, outGBuffer2 );
						#else
							outEmission = LightingLambert_Deferred( o, gi, outGBuffer0, outGBuffer1, outGBuffer2 );
						#endif
					#else
						#if defined(_SPECULAR_SETUP)
							outEmission = LightingStandardSpecular_Deferred( o, ViewDirWS, gi, outGBuffer0, outGBuffer1, outGBuffer2 );
						#else
							outEmission = LightingStandard_Deferred( o, ViewDirWS, gi, outGBuffer0, outGBuffer1, outGBuffer2 );
						#endif
					#endif

					#if defined(SHADOWS_SHADOWMASK) && (UNITY_ALLOWED_MRT_COUNT > 4)
						outShadowMask = UnityGetRawBakedOcclusions( IN.ambientOrLightmapUV.xy, float3( 0, 0, 0 ) );
					#endif
					#ifndef UNITY_HDR_ON
						outEmission.rgb = exp2(-outEmission.rgb);
					#endif
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
				#define _GLOSSYREFLECTIONS_OFF
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
				#define _SPECULARHIGHLIGHTS_OFF
				#define _GLOSSYREFLECTIONS_OFF
				#define ASE_NO_AMBIENT 1
				#define ASE_LIGHTING_SIMPLE 1
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
				#define _SPECULARHIGHLIGHTS_OFF
				#define _GLOSSYREFLECTIONS_OFF
				#define ASE_NO_AMBIENT 1
				#define ASE_LIGHTING_SIMPLE 1
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
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5290;-144,-1280;Inherit;False;Meenphie;0;;60740;b3ba55a08dd6b49c7be16c6f35cf2033;1,1008,0;0;5;COLOR;625;FLOAT4;624;FLOAT;156;FLOAT;427;FLOAT3;1024
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5279;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5280;256,-1280;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;5;Meenphie/Standard/Opaque;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardBase;0;1;ForwardBase;17;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;44;Category;0;0;  Instanced Terrain Normals;1;0;Workflow;3;639079749420714040;Surface;0;0;  Blend;0;0;  Dither Shadows;1;0;Two Sided;1;0;Alpha Clipping;0;0;  Use Shadow Threshold;0;0;Deferred Pass;1;0;Normal Space;0;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;1;0;Receive Shadows;1;0;Receive Specular;0;639079748971954060;Receive Reflections;0;639079749029116410;GPU Instancing;1;0;LOD CrossFade;1;0;Built-in Fog;0;639079749092523460;Ambient Light;0;639079749088921010;Meta Pass;0;639079749085366090;Add Pass;0;639079749082074320;Override Baked GI;0;0;Write Depth;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;0;Vertex Position;1;0;0;8;False;True;False;True;False;True;True;True;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5281;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;True;1;LightMode=ForwardAdd;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5282;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5283;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5284;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5285;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5286;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ScenePickingPass;0;7;ScenePickingPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=Picking;False;False;0;;0;0;Standard;0;False;0
WireConnection;5280;0;5290;625
WireConnection;5280;2;5290;624
ASEEND*/
//CHKSM=CF56BFEF15149626A1099AF9C08B750D087BDAA8