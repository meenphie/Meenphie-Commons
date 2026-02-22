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
				#pragma multi_compile _ LOD_FADE_CROSSFADE
				#pragma multi_compile_fog
				#define ASE_FOG
				#define _SPECULARHIGHLIGHTS_OFF
				#define ASE_LIGHTING_SIMPLE 1
				#define ASE_NO_AMBIENT 1
				#pragma multi_compile_instancing
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

					float2 texCoord2357_g59498 = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV02420_g59498 = texCoord2357_g59498;
					float2 temp_output_5_0_g59545 = UV02420_g59498;
					float2 UV633_g59545 = temp_output_5_0_g59545;
					float2 UV100_g59546 = UV633_g59545;
					float2 temp_output_51_0_g59546 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59546 * float2( 3.464,3.464 ) ) );
					float2 break55_g59546 = frac( temp_output_51_0_g59546 );
					float temp_output_56_0_g59546 = ( ( 1.0 - break55_g59546.x ) - break55_g59546.y );
					float2 temp_output_52_0_g59546 = floor( temp_output_51_0_g59546 );
					float2 temp_output_125_0_g59546 = ( temp_output_52_0_g59546 + float2( 1,1 ) );
					float2 ifLocalVar87_g59546 = 0;
					if( temp_output_56_0_g59546 > 0.0 )
					ifLocalVar87_g59546 = temp_output_52_0_g59546;
					else if( temp_output_56_0_g59546 == 0.0 )
					ifLocalVar87_g59546 = temp_output_125_0_g59546;
					else if( temp_output_56_0_g59546 < 0.0 )
					ifLocalVar87_g59546 = temp_output_125_0_g59546;
					float3 temp_output_7_0_g59547 = frac( ( (ifLocalVar87_g59546).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59547 = dot( temp_output_7_0_g59547 , ( (temp_output_7_0_g59547).yzx + 33.33 ) );
					float3 temp_output_12_0_g59547 = ( temp_output_7_0_g59547 + dotResult8_g59547 );
					float2 temp_output_597_0_g59545 = ( UV100_g59546 + frac( ( ( (temp_output_12_0_g59547).xx + (temp_output_12_0_g59547).yz ) * (temp_output_12_0_g59547).zy ) ) );
					float2 DDX631_g59545 = ddx( temp_output_5_0_g59545 );
					float2 DDY632_g59545 = ddy( temp_output_5_0_g59545 );
					float temp_output_65_0_g59546 = ( 0.0 - temp_output_56_0_g59546 );
					float ifLocalVar59_g59546 = 0;
					if( temp_output_56_0_g59546 <= 0.0 )
					ifLocalVar59_g59546 = temp_output_65_0_g59546;
					else
					ifLocalVar59_g59546 = temp_output_56_0_g59546;
					float temp_output_597_30_g59545 = ifLocalVar59_g59546;
					float2 temp_output_90_0_g59546 = ( temp_output_52_0_g59546 + float2( 0,1 ) );
					float2 temp_output_123_0_g59546 = ( temp_output_52_0_g59546 + float2( 1,0 ) );
					float2 ifLocalVar88_g59546 = 0;
					if( temp_output_56_0_g59546 > 0.0 )
					ifLocalVar88_g59546 = temp_output_90_0_g59546;
					else if( temp_output_56_0_g59546 == 0.0 )
					ifLocalVar88_g59546 = temp_output_123_0_g59546;
					else if( temp_output_56_0_g59546 < 0.0 )
					ifLocalVar88_g59546 = temp_output_123_0_g59546;
					float3 temp_output_7_0_g59548 = frac( ( (ifLocalVar88_g59546).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59548 = dot( temp_output_7_0_g59548 , ( (temp_output_7_0_g59548).yzx + 33.33 ) );
					float3 temp_output_12_0_g59548 = ( temp_output_7_0_g59548 + dotResult8_g59548 );
					float2 temp_output_597_26_g59545 = ( UV100_g59546 + frac( ( ( (temp_output_12_0_g59548).xx + (temp_output_12_0_g59548).yz ) * (temp_output_12_0_g59548).zy ) ) );
					float temp_output_66_0_g59546 = ( 1.0 - break55_g59546.y );
					float ifLocalVar60_g59546 = 0;
					if( temp_output_56_0_g59546 <= 0.0 )
					ifLocalVar60_g59546 = temp_output_66_0_g59546;
					else
					ifLocalVar60_g59546 = break55_g59546.y;
					float temp_output_597_28_g59545 = ifLocalVar60_g59546;
					float2 ifLocalVar89_g59546 = 0;
					if( temp_output_56_0_g59546 > 0.0 )
					ifLocalVar89_g59546 = temp_output_123_0_g59546;
					else if( temp_output_56_0_g59546 == 0.0 )
					ifLocalVar89_g59546 = temp_output_90_0_g59546;
					else if( temp_output_56_0_g59546 < 0.0 )
					ifLocalVar89_g59546 = temp_output_90_0_g59546;
					float3 temp_output_7_0_g59549 = frac( ( (ifLocalVar89_g59546).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59549 = dot( temp_output_7_0_g59549 , ( (temp_output_7_0_g59549).yzx + 33.33 ) );
					float3 temp_output_12_0_g59549 = ( temp_output_7_0_g59549 + dotResult8_g59549 );
					float2 temp_output_597_27_g59545 = ( UV100_g59546 + frac( ( ( (temp_output_12_0_g59549).xx + (temp_output_12_0_g59549).yz ) * (temp_output_12_0_g59549).zy ) ) );
					float temp_output_67_0_g59546 = ( 1.0 - break55_g59546.x );
					float ifLocalVar61_g59546 = 0;
					if( temp_output_56_0_g59546 <= 0.0 )
					ifLocalVar61_g59546 = temp_output_67_0_g59546;
					else
					ifLocalVar61_g59546 = break55_g59546.x;
					float temp_output_597_29_g59545 = ifLocalVar61_g59546;
					float4 Output_2D293_g59545 = ( ( tex2D( _MainTex, temp_output_597_0_g59545, DDX631_g59545, DDY632_g59545 ) * temp_output_597_30_g59545 ) + ( tex2D( _MainTex, temp_output_597_26_g59545, DDX631_g59545, DDY632_g59545 ) * temp_output_597_28_g59545 ) + ( tex2D( _MainTex, temp_output_597_27_g59545, DDX631_g59545, DDY632_g59545 ) * temp_output_597_29_g59545 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g59498 = Output_2D293_g59545;
					#else
					float4 staticSwitch1001_g59498 = tex2D( _MainTex, UV02420_g59498 );
					#endif
					#ifdef _MAINTEX
					float4 staticSwitch1549_g59498 = staticSwitch1001_g59498;
					#else
					float4 staticSwitch1549_g59498 = _Color;
					#endif
					float4 oAlbedo6_g59498 = staticSwitch1549_g59498;
					float Black1185_g59498 = 0.0;
					float4 temp_cast_0 = (Black1185_g59498).xxxx;
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1180_g59498 = temp_cast_0;
					#else
					float4 staticSwitch1180_g59498 = oAlbedo6_g59498;
					#endif
					
					float2 temp_output_5_0_g59504 = UV02420_g59498;
					float2 UV633_g59504 = temp_output_5_0_g59504;
					float2 UV100_g59505 = UV633_g59504;
					float2 temp_output_51_0_g59505 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59505 * float2( 3.464,3.464 ) ) );
					float2 break55_g59505 = frac( temp_output_51_0_g59505 );
					float temp_output_56_0_g59505 = ( ( 1.0 - break55_g59505.x ) - break55_g59505.y );
					float2 temp_output_52_0_g59505 = floor( temp_output_51_0_g59505 );
					float2 temp_output_125_0_g59505 = ( temp_output_52_0_g59505 + float2( 1,1 ) );
					float2 ifLocalVar87_g59505 = 0;
					if( temp_output_56_0_g59505 > 0.0 )
					ifLocalVar87_g59505 = temp_output_52_0_g59505;
					else if( temp_output_56_0_g59505 == 0.0 )
					ifLocalVar87_g59505 = temp_output_125_0_g59505;
					else if( temp_output_56_0_g59505 < 0.0 )
					ifLocalVar87_g59505 = temp_output_125_0_g59505;
					float3 temp_output_7_0_g59506 = frac( ( (ifLocalVar87_g59505).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59506 = dot( temp_output_7_0_g59506 , ( (temp_output_7_0_g59506).yzx + 33.33 ) );
					float3 temp_output_12_0_g59506 = ( temp_output_7_0_g59506 + dotResult8_g59506 );
					float2 temp_output_597_0_g59504 = ( UV100_g59505 + frac( ( ( (temp_output_12_0_g59506).xx + (temp_output_12_0_g59506).yz ) * (temp_output_12_0_g59506).zy ) ) );
					float2 DDX631_g59504 = ddx( temp_output_5_0_g59504 );
					float2 DDY632_g59504 = ddy( temp_output_5_0_g59504 );
					float temp_output_65_0_g59505 = ( 0.0 - temp_output_56_0_g59505 );
					float ifLocalVar59_g59505 = 0;
					if( temp_output_56_0_g59505 <= 0.0 )
					ifLocalVar59_g59505 = temp_output_65_0_g59505;
					else
					ifLocalVar59_g59505 = temp_output_56_0_g59505;
					float temp_output_597_30_g59504 = ifLocalVar59_g59505;
					float2 temp_output_90_0_g59505 = ( temp_output_52_0_g59505 + float2( 0,1 ) );
					float2 temp_output_123_0_g59505 = ( temp_output_52_0_g59505 + float2( 1,0 ) );
					float2 ifLocalVar88_g59505 = 0;
					if( temp_output_56_0_g59505 > 0.0 )
					ifLocalVar88_g59505 = temp_output_90_0_g59505;
					else if( temp_output_56_0_g59505 == 0.0 )
					ifLocalVar88_g59505 = temp_output_123_0_g59505;
					else if( temp_output_56_0_g59505 < 0.0 )
					ifLocalVar88_g59505 = temp_output_123_0_g59505;
					float3 temp_output_7_0_g59507 = frac( ( (ifLocalVar88_g59505).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59507 = dot( temp_output_7_0_g59507 , ( (temp_output_7_0_g59507).yzx + 33.33 ) );
					float3 temp_output_12_0_g59507 = ( temp_output_7_0_g59507 + dotResult8_g59507 );
					float2 temp_output_597_26_g59504 = ( UV100_g59505 + frac( ( ( (temp_output_12_0_g59507).xx + (temp_output_12_0_g59507).yz ) * (temp_output_12_0_g59507).zy ) ) );
					float temp_output_66_0_g59505 = ( 1.0 - break55_g59505.y );
					float ifLocalVar60_g59505 = 0;
					if( temp_output_56_0_g59505 <= 0.0 )
					ifLocalVar60_g59505 = temp_output_66_0_g59505;
					else
					ifLocalVar60_g59505 = break55_g59505.y;
					float temp_output_597_28_g59504 = ifLocalVar60_g59505;
					float2 ifLocalVar89_g59505 = 0;
					if( temp_output_56_0_g59505 > 0.0 )
					ifLocalVar89_g59505 = temp_output_123_0_g59505;
					else if( temp_output_56_0_g59505 == 0.0 )
					ifLocalVar89_g59505 = temp_output_90_0_g59505;
					else if( temp_output_56_0_g59505 < 0.0 )
					ifLocalVar89_g59505 = temp_output_90_0_g59505;
					float3 temp_output_7_0_g59508 = frac( ( (ifLocalVar89_g59505).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59508 = dot( temp_output_7_0_g59508 , ( (temp_output_7_0_g59508).yzx + 33.33 ) );
					float3 temp_output_12_0_g59508 = ( temp_output_7_0_g59508 + dotResult8_g59508 );
					float2 temp_output_597_27_g59504 = ( UV100_g59505 + frac( ( ( (temp_output_12_0_g59508).xx + (temp_output_12_0_g59508).yz ) * (temp_output_12_0_g59508).zy ) ) );
					float temp_output_67_0_g59505 = ( 1.0 - break55_g59505.x );
					float ifLocalVar61_g59505 = 0;
					if( temp_output_56_0_g59505 <= 0.0 )
					ifLocalVar61_g59505 = temp_output_67_0_g59505;
					else
					ifLocalVar61_g59505 = break55_g59505.x;
					float temp_output_597_29_g59504 = ifLocalVar61_g59505;
					float4 Output_2D293_g59504 = ( ( tex2D( _MetallicMap, temp_output_597_0_g59504, DDX631_g59504, DDY632_g59504 ) * temp_output_597_30_g59504 ) + ( tex2D( _MetallicMap, temp_output_597_26_g59504, DDX631_g59504, DDY632_g59504 ) * temp_output_597_28_g59504 ) + ( tex2D( _MetallicMap, temp_output_597_27_g59504, DDX631_g59504, DDY632_g59504 ) * temp_output_597_29_g59504 ) );
					float4 break31_g59504 = Output_2D293_g59504;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g59498 = break31_g59504.a;
					#else
					float staticSwitch1005_g59498 = tex2D( _MetallicMap, UV02420_g59498 ).a;
					#endif
					#ifdef _METALLICMAP
					float staticSwitch846_g59498 = staticSwitch1005_g59498;
					#else
					float staticSwitch846_g59498 = _Metallic;
					#endif
					float Metallic1239_g59498 = staticSwitch846_g59498;
					float4 aAlbedo1466_g59498 = ( staticSwitch1549_g59498 * ( 1.0 - Metallic1239_g59498 ) );
					float White38_g59498 = 1.0;
					float4 temp_cast_2 = (White38_g59498).xxxx;
					float4 texCoord2426_g59498 = IN.ase_texcoord6;
					texCoord2426_g59498.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV12361_g59498 = (texCoord2426_g59498).zw;
					float localBicubicPrepare2_g59539 = ( 0.0 );
					float2 Input_UV100_g59539 = UV12361_g59498;
					float2 UV2_g59539 = Input_UV100_g59539;
					float4 TexelSize2_g59539 = _Lightmap0_TexelSize;
					float2 UV02_g59539 = float2( 0,0 );
					float2 UV12_g59539 = float2( 0,0 );
					float2 UV22_g59539 = float2( 0,0 );
					float2 UV32_g59539 = float2( 0,0 );
					float W02_g59539 = 0;
					float W12_g59539 = 0;
					{
					{
					 UV2_g59539 = UV2_g59539 * TexelSize2_g59539.zw - 0.5;
					    float2 f = frac( UV2_g59539 );
					    UV2_g59539 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59539.x - 0.5, UV2_g59539.x + 1.5, UV2_g59539.y - 0.5, UV2_g59539.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59539.xyxy;
					    UV02_g59539 = off.xz;
					    UV12_g59539 = off.yz;
					    UV22_g59539 = off.xw;
					    UV32_g59539 = off.yw;
					    W02_g59539 = s.x / ( s.x + s.y );
					 W12_g59539 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59539 = lerp( tex2D( _Lightmap0, UV32_g59539 ) , tex2D( _Lightmap0, UV22_g59539 ) , W02_g59539);
					float4 lerpResult45_g59539 = lerp( tex2D( _Lightmap0, UV12_g59539 ) , tex2D( _Lightmap0, UV02_g59539 ) , W02_g59539);
					float4 lerpResult44_g59539 = lerp( lerpResult46_g59539 , lerpResult45_g59539 , W12_g59539);
					float4 Output_2D_Auto131_g59539 = lerpResult44_g59539;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g59498 = Output_2D_Auto131_g59539;
					#else
					float4 staticSwitch1092_g59498 = tex2D( _Lightmap0, UV12361_g59498 );
					#endif
					float4 Lightmap_0925_g59498 = staticSwitch1092_g59498;
					float localBicubicPrepare2_g59537 = ( 0.0 );
					float2 Input_UV100_g59537 = UV12361_g59498;
					float2 UV2_g59537 = Input_UV100_g59537;
					float4 TexelSize2_g59537 = _Lightmap1_TexelSize;
					float2 UV02_g59537 = float2( 0,0 );
					float2 UV12_g59537 = float2( 0,0 );
					float2 UV22_g59537 = float2( 0,0 );
					float2 UV32_g59537 = float2( 0,0 );
					float W02_g59537 = 0;
					float W12_g59537 = 0;
					{
					{
					 UV2_g59537 = UV2_g59537 * TexelSize2_g59537.zw - 0.5;
					    float2 f = frac( UV2_g59537 );
					    UV2_g59537 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59537.x - 0.5, UV2_g59537.x + 1.5, UV2_g59537.y - 0.5, UV2_g59537.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59537.xyxy;
					    UV02_g59537 = off.xz;
					    UV12_g59537 = off.yz;
					    UV22_g59537 = off.xw;
					    UV32_g59537 = off.yw;
					    W02_g59537 = s.x / ( s.x + s.y );
					 W12_g59537 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59537 = lerp( tex2D( _Lightmap1, UV32_g59537 ) , tex2D( _Lightmap1, UV22_g59537 ) , W02_g59537);
					float4 lerpResult45_g59537 = lerp( tex2D( _Lightmap1, UV12_g59537 ) , tex2D( _Lightmap1, UV02_g59537 ) , W02_g59537);
					float4 lerpResult44_g59537 = lerp( lerpResult46_g59537 , lerpResult45_g59537 , W12_g59537);
					float4 Output_2D_Auto131_g59537 = lerpResult44_g59537;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g59498 = Output_2D_Auto131_g59537;
					#else
					float4 staticSwitch1088_g59498 = tex2D( _Lightmap1, UV12361_g59498 );
					#endif
					float4 Lightmap_1956_g59498 = staticSwitch1088_g59498;
					float4 lerpResult442_g59498 = lerp( Lightmap_0925_g59498 , Lightmap_1956_g59498 , _LIGHTMAPLERP);
					float4 Lightmap_Lerp932_g59498 = lerpResult442_g59498;
					float3 appendResult139_g59527 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float2 temp_output_5_0_g59499 = UV02420_g59498;
					float2 UV633_g59499 = temp_output_5_0_g59499;
					float2 UV100_g59500 = UV633_g59499;
					float2 temp_output_51_0_g59500 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59500 * float2( 3.464,3.464 ) ) );
					float2 break55_g59500 = frac( temp_output_51_0_g59500 );
					float temp_output_56_0_g59500 = ( ( 1.0 - break55_g59500.x ) - break55_g59500.y );
					float2 temp_output_52_0_g59500 = floor( temp_output_51_0_g59500 );
					float2 temp_output_125_0_g59500 = ( temp_output_52_0_g59500 + float2( 1,1 ) );
					float2 ifLocalVar87_g59500 = 0;
					if( temp_output_56_0_g59500 > 0.0 )
					ifLocalVar87_g59500 = temp_output_52_0_g59500;
					else if( temp_output_56_0_g59500 == 0.0 )
					ifLocalVar87_g59500 = temp_output_125_0_g59500;
					else if( temp_output_56_0_g59500 < 0.0 )
					ifLocalVar87_g59500 = temp_output_125_0_g59500;
					float3 temp_output_7_0_g59501 = frac( ( (ifLocalVar87_g59500).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59501 = dot( temp_output_7_0_g59501 , ( (temp_output_7_0_g59501).yzx + 33.33 ) );
					float3 temp_output_12_0_g59501 = ( temp_output_7_0_g59501 + dotResult8_g59501 );
					float2 temp_output_597_0_g59499 = ( UV100_g59500 + frac( ( ( (temp_output_12_0_g59501).xx + (temp_output_12_0_g59501).yz ) * (temp_output_12_0_g59501).zy ) ) );
					float2 DDX631_g59499 = ddx( temp_output_5_0_g59499 );
					float2 DDY632_g59499 = ddy( temp_output_5_0_g59499 );
					float Input_Scale617_g59499 = 2.0;
					float temp_output_65_0_g59500 = ( 0.0 - temp_output_56_0_g59500 );
					float ifLocalVar59_g59500 = 0;
					if( temp_output_56_0_g59500 <= 0.0 )
					ifLocalVar59_g59500 = temp_output_65_0_g59500;
					else
					ifLocalVar59_g59500 = temp_output_56_0_g59500;
					float temp_output_597_30_g59499 = ifLocalVar59_g59500;
					float2 temp_output_90_0_g59500 = ( temp_output_52_0_g59500 + float2( 0,1 ) );
					float2 temp_output_123_0_g59500 = ( temp_output_52_0_g59500 + float2( 1,0 ) );
					float2 ifLocalVar88_g59500 = 0;
					if( temp_output_56_0_g59500 > 0.0 )
					ifLocalVar88_g59500 = temp_output_90_0_g59500;
					else if( temp_output_56_0_g59500 == 0.0 )
					ifLocalVar88_g59500 = temp_output_123_0_g59500;
					else if( temp_output_56_0_g59500 < 0.0 )
					ifLocalVar88_g59500 = temp_output_123_0_g59500;
					float3 temp_output_7_0_g59502 = frac( ( (ifLocalVar88_g59500).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59502 = dot( temp_output_7_0_g59502 , ( (temp_output_7_0_g59502).yzx + 33.33 ) );
					float3 temp_output_12_0_g59502 = ( temp_output_7_0_g59502 + dotResult8_g59502 );
					float2 temp_output_597_26_g59499 = ( UV100_g59500 + frac( ( ( (temp_output_12_0_g59502).xx + (temp_output_12_0_g59502).yz ) * (temp_output_12_0_g59502).zy ) ) );
					float temp_output_66_0_g59500 = ( 1.0 - break55_g59500.y );
					float ifLocalVar60_g59500 = 0;
					if( temp_output_56_0_g59500 <= 0.0 )
					ifLocalVar60_g59500 = temp_output_66_0_g59500;
					else
					ifLocalVar60_g59500 = break55_g59500.y;
					float temp_output_597_28_g59499 = ifLocalVar60_g59500;
					float2 ifLocalVar89_g59500 = 0;
					if( temp_output_56_0_g59500 > 0.0 )
					ifLocalVar89_g59500 = temp_output_123_0_g59500;
					else if( temp_output_56_0_g59500 == 0.0 )
					ifLocalVar89_g59500 = temp_output_90_0_g59500;
					else if( temp_output_56_0_g59500 < 0.0 )
					ifLocalVar89_g59500 = temp_output_90_0_g59500;
					float3 temp_output_7_0_g59503 = frac( ( (ifLocalVar89_g59500).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59503 = dot( temp_output_7_0_g59503 , ( (temp_output_7_0_g59503).yzx + 33.33 ) );
					float3 temp_output_12_0_g59503 = ( temp_output_7_0_g59503 + dotResult8_g59503 );
					float2 temp_output_597_27_g59499 = ( UV100_g59500 + frac( ( ( (temp_output_12_0_g59503).xx + (temp_output_12_0_g59503).yz ) * (temp_output_12_0_g59503).zy ) ) );
					float temp_output_67_0_g59500 = ( 1.0 - break55_g59500.x );
					float ifLocalVar61_g59500 = 0;
					if( temp_output_56_0_g59500 <= 0.0 )
					ifLocalVar61_g59500 = temp_output_67_0_g59500;
					else
					ifLocalVar61_g59500 = break55_g59500.x;
					float temp_output_597_29_g59499 = ifLocalVar61_g59500;
					float3 Output_2D_Normal641_g59499 = ( ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_0_g59499, DDX631_g59499, DDY632_g59499 ), Input_Scale617_g59499 ) * temp_output_597_30_g59499 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_26_g59499, DDX631_g59499, DDY632_g59499 ), Input_Scale617_g59499 ) * temp_output_597_28_g59499 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_27_g59499, DDX631_g59499, DDY632_g59499 ), Input_Scale617_g59499 ) * float3( 0,0,0 ) * temp_output_597_29_g59499 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g59498 = Output_2D_Normal641_g59499;
					#else
					float3 staticSwitch1003_g59498 = UnpackScaleNormal( tex2D( _BumpMap, UV02420_g59498 ), 2.0 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g59498 = staticSwitch1003_g59498;
					#else
					float3 staticSwitch980_g59498 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g59498 = staticSwitch980_g59498;
					float3 normalizeResult326_g59527 = normalize( Normal_Map700_g59498 );
					float3 Normal_Map318_g59527 = normalizeResult326_g59527;
					float dotResult121_g59527 = dot( appendResult139_g59527 , Normal_Map318_g59527 );
					float temp_output_2_0_g59530 = saturate( dotResult121_g59527 );
					float localStochasticTiling2_g59541 = ( 0.0 );
					float2 UV2_g59541 = UV12361_g59498;
					float4 TexelSize2_g59541 = _RNMX0_TexelSize;
					float4 Offsets2_g59541 = float4( 0,0,0,0 );
					float2 Weights2_g59541 = float2( 0,0 );
					{
					UV2_g59541 = UV2_g59541 * TexelSize2_g59541.zw - 0.5;
					float2 f = frac( UV2_g59541 );
					UV2_g59541 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g59541.x - 0.5, UV2_g59541.x + 1.5, UV2_g59541.y - 0.5, UV2_g59541.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g59541 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59541.xyxy;
					Weights2_g59541 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g59540 = Offsets2_g59541;
					float4 Input_FetchOffsets197_g59542 = temp_output_1_34_g59540;
					float2 temp_output_1_54_g59540 = Weights2_g59541;
					float2 Input_FetchWeights200_g59542 = temp_output_1_54_g59540;
					float2 break187_g59542 = Input_FetchWeights200_g59542;
					float4 lerpResult181_g59542 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g59542).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g59542).xw ) , break187_g59542.x);
					float4 lerpResult182_g59542 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g59542).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g59542).xz ) , break187_g59542.x);
					float4 lerpResult176_g59542 = lerp( lerpResult181_g59542 , lerpResult182_g59542 , break187_g59542.y);
					float4 Output_Fetch2D_Auto202_g59542 = lerpResult176_g59542;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g59498 = Output_Fetch2D_Auto202_g59542;
					#else
					float4 staticSwitch1061_g59498 = tex2D( _RNMX0, UV12361_g59498 );
					#endif
					float3 appendResult146_g59527 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59527 = dot( appendResult146_g59527 , Normal_Map318_g59527 );
					float temp_output_2_0_g59529 = saturate( dotResult122_g59527 );
					float4 Input_FetchOffsets197_g59543 = temp_output_1_34_g59540;
					float2 Input_FetchWeights200_g59543 = temp_output_1_54_g59540;
					float2 break187_g59543 = Input_FetchWeights200_g59543;
					float4 lerpResult181_g59543 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g59543).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g59543).xw ) , break187_g59543.x);
					float4 lerpResult182_g59543 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g59543).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g59543).xz ) , break187_g59543.x);
					float4 lerpResult176_g59543 = lerp( lerpResult181_g59543 , lerpResult182_g59543 , break187_g59543.y);
					float4 Output_Fetch2D_Auto202_g59543 = lerpResult176_g59543;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g59498 = Output_Fetch2D_Auto202_g59543;
					#else
					float4 staticSwitch1062_g59498 = tex2D( _RNMY0, UV12361_g59498 );
					#endif
					float3 appendResult149_g59527 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59527 = dot( appendResult149_g59527 , Normal_Map318_g59527 );
					float temp_output_2_0_g59528 = saturate( dotResult120_g59527 );
					float4 Input_FetchOffsets197_g59544 = temp_output_1_34_g59540;
					float2 Input_FetchWeights200_g59544 = temp_output_1_54_g59540;
					float2 break187_g59544 = Input_FetchWeights200_g59544;
					float4 lerpResult181_g59544 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g59544).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g59544).xw ) , break187_g59544.x);
					float4 lerpResult182_g59544 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g59544).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g59544).xz ) , break187_g59544.x);
					float4 lerpResult176_g59544 = lerp( lerpResult181_g59544 , lerpResult182_g59544 , break187_g59544.y);
					float4 Output_Fetch2D_Auto202_g59544 = lerpResult176_g59544;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g59498 = Output_Fetch2D_Auto202_g59544;
					#else
					float4 staticSwitch1063_g59498 = tex2D( _RNMZ0, UV12361_g59498 );
					#endif
					float4 RNM_0926_g59498 = ( ( ( ( temp_output_2_0_g59530 * temp_output_2_0_g59530 ) * staticSwitch1061_g59498 ) + ( ( temp_output_2_0_g59529 * temp_output_2_0_g59529 ) * staticSwitch1062_g59498 ) ) + ( ( temp_output_2_0_g59528 * temp_output_2_0_g59528 ) * staticSwitch1063_g59498 ) );
					float3 appendResult139_g59523 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g59523 = normalize( Normal_Map700_g59498 );
					float3 Normal_Map318_g59523 = normalizeResult326_g59523;
					float dotResult121_g59523 = dot( appendResult139_g59523 , Normal_Map318_g59523 );
					float temp_output_2_0_g59526 = saturate( dotResult121_g59523 );
					float localStochasticTiling2_g59532 = ( 0.0 );
					float2 UV2_g59532 = UV12361_g59498;
					float4 TexelSize2_g59532 = _RNMX1_TexelSize;
					float4 Offsets2_g59532 = float4( 0,0,0,0 );
					float2 Weights2_g59532 = float2( 0,0 );
					{
					UV2_g59532 = UV2_g59532 * TexelSize2_g59532.zw - 0.5;
					float2 f = frac( UV2_g59532 );
					UV2_g59532 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g59532.x - 0.5, UV2_g59532.x + 1.5, UV2_g59532.y - 0.5, UV2_g59532.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g59532 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59532.xyxy;
					Weights2_g59532 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g59531 = Offsets2_g59532;
					float4 Input_FetchOffsets197_g59533 = temp_output_1_34_g59531;
					float2 temp_output_1_54_g59531 = Weights2_g59532;
					float2 Input_FetchWeights200_g59533 = temp_output_1_54_g59531;
					float2 break187_g59533 = Input_FetchWeights200_g59533;
					float4 lerpResult181_g59533 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g59533).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g59533).xw ) , break187_g59533.x);
					float4 lerpResult182_g59533 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g59533).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g59533).xz ) , break187_g59533.x);
					float4 lerpResult176_g59533 = lerp( lerpResult181_g59533 , lerpResult182_g59533 , break187_g59533.y);
					float4 Output_Fetch2D_Auto202_g59533 = lerpResult176_g59533;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g59498 = Output_Fetch2D_Auto202_g59533;
					#else
					float4 staticSwitch1087_g59498 = tex2D( _RNMX1, UV12361_g59498 );
					#endif
					float3 appendResult146_g59523 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59523 = dot( appendResult146_g59523 , Normal_Map318_g59523 );
					float temp_output_2_0_g59525 = saturate( dotResult122_g59523 );
					float4 Input_FetchOffsets197_g59534 = temp_output_1_34_g59531;
					float2 Input_FetchWeights200_g59534 = temp_output_1_54_g59531;
					float2 break187_g59534 = Input_FetchWeights200_g59534;
					float4 lerpResult181_g59534 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g59534).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g59534).xw ) , break187_g59534.x);
					float4 lerpResult182_g59534 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g59534).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g59534).xz ) , break187_g59534.x);
					float4 lerpResult176_g59534 = lerp( lerpResult181_g59534 , lerpResult182_g59534 , break187_g59534.y);
					float4 Output_Fetch2D_Auto202_g59534 = lerpResult176_g59534;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g59498 = Output_Fetch2D_Auto202_g59534;
					#else
					float4 staticSwitch1083_g59498 = tex2D( _RNMY1, UV12361_g59498 );
					#endif
					float3 appendResult149_g59523 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59523 = dot( appendResult149_g59523 , Normal_Map318_g59523 );
					float temp_output_2_0_g59524 = saturate( dotResult120_g59523 );
					float4 Input_FetchOffsets197_g59535 = temp_output_1_34_g59531;
					float2 Input_FetchWeights200_g59535 = temp_output_1_54_g59531;
					float2 break187_g59535 = Input_FetchWeights200_g59535;
					float4 lerpResult181_g59535 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g59535).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g59535).xw ) , break187_g59535.x);
					float4 lerpResult182_g59535 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g59535).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g59535).xz ) , break187_g59535.x);
					float4 lerpResult176_g59535 = lerp( lerpResult181_g59535 , lerpResult182_g59535 , break187_g59535.y);
					float4 Output_Fetch2D_Auto202_g59535 = lerpResult176_g59535;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g59498 = Output_Fetch2D_Auto202_g59535;
					#else
					float4 staticSwitch1084_g59498 = tex2D( _RNMZ1, UV12361_g59498 );
					#endif
					float4 RNM_11081_g59498 = ( ( ( ( temp_output_2_0_g59526 * temp_output_2_0_g59526 ) * staticSwitch1087_g59498 ) + ( ( temp_output_2_0_g59525 * temp_output_2_0_g59525 ) * staticSwitch1083_g59498 ) ) + ( ( temp_output_2_0_g59524 * temp_output_2_0_g59524 ) * staticSwitch1084_g59498 ) );
					float Lightmap_Lerp_Value969_g59498 = _LIGHTMAPLERP;
					float4 lerpResult953_g59498 = lerp( RNM_0926_g59498 , RNM_11081_g59498 , Lightmap_Lerp_Value969_g59498);
					float4 RNM_Lerp950_g59498 = lerpResult953_g59498;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g59498 = temp_cast_2;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g59498 = Lightmap_0925_g59498;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g59498 = Lightmap_Lerp932_g59498;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g59498 = RNM_0926_g59498;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g59498 = RNM_Lerp950_g59498;
					#else
					float4 staticSwitch1014_g59498 = temp_cast_2;
					#endif
					float4 Lightmap46_g59498 = staticSwitch1014_g59498;
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal1392_g59498 = Normal_Map700_g59498;
					float2 temp_output_5_0_g59516 = UV02420_g59498;
					float2 UV633_g59516 = temp_output_5_0_g59516;
					float2 UV100_g59517 = UV633_g59516;
					float2 temp_output_51_0_g59517 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59517 * float2( 3.464,3.464 ) ) );
					float2 break55_g59517 = frac( temp_output_51_0_g59517 );
					float temp_output_56_0_g59517 = ( ( 1.0 - break55_g59517.x ) - break55_g59517.y );
					float2 temp_output_52_0_g59517 = floor( temp_output_51_0_g59517 );
					float2 temp_output_125_0_g59517 = ( temp_output_52_0_g59517 + float2( 1,1 ) );
					float2 ifLocalVar87_g59517 = 0;
					if( temp_output_56_0_g59517 > 0.0 )
					ifLocalVar87_g59517 = temp_output_52_0_g59517;
					else if( temp_output_56_0_g59517 == 0.0 )
					ifLocalVar87_g59517 = temp_output_125_0_g59517;
					else if( temp_output_56_0_g59517 < 0.0 )
					ifLocalVar87_g59517 = temp_output_125_0_g59517;
					float3 temp_output_7_0_g59518 = frac( ( (ifLocalVar87_g59517).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59518 = dot( temp_output_7_0_g59518 , ( (temp_output_7_0_g59518).yzx + 33.33 ) );
					float3 temp_output_12_0_g59518 = ( temp_output_7_0_g59518 + dotResult8_g59518 );
					float2 temp_output_597_0_g59516 = ( UV100_g59517 + frac( ( ( (temp_output_12_0_g59518).xx + (temp_output_12_0_g59518).yz ) * (temp_output_12_0_g59518).zy ) ) );
					float2 DDX631_g59516 = ddx( temp_output_5_0_g59516 );
					float2 DDY632_g59516 = ddy( temp_output_5_0_g59516 );
					float temp_output_65_0_g59517 = ( 0.0 - temp_output_56_0_g59517 );
					float ifLocalVar59_g59517 = 0;
					if( temp_output_56_0_g59517 <= 0.0 )
					ifLocalVar59_g59517 = temp_output_65_0_g59517;
					else
					ifLocalVar59_g59517 = temp_output_56_0_g59517;
					float temp_output_597_30_g59516 = ifLocalVar59_g59517;
					float2 temp_output_90_0_g59517 = ( temp_output_52_0_g59517 + float2( 0,1 ) );
					float2 temp_output_123_0_g59517 = ( temp_output_52_0_g59517 + float2( 1,0 ) );
					float2 ifLocalVar88_g59517 = 0;
					if( temp_output_56_0_g59517 > 0.0 )
					ifLocalVar88_g59517 = temp_output_90_0_g59517;
					else if( temp_output_56_0_g59517 == 0.0 )
					ifLocalVar88_g59517 = temp_output_123_0_g59517;
					else if( temp_output_56_0_g59517 < 0.0 )
					ifLocalVar88_g59517 = temp_output_123_0_g59517;
					float3 temp_output_7_0_g59519 = frac( ( (ifLocalVar88_g59517).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59519 = dot( temp_output_7_0_g59519 , ( (temp_output_7_0_g59519).yzx + 33.33 ) );
					float3 temp_output_12_0_g59519 = ( temp_output_7_0_g59519 + dotResult8_g59519 );
					float2 temp_output_597_26_g59516 = ( UV100_g59517 + frac( ( ( (temp_output_12_0_g59519).xx + (temp_output_12_0_g59519).yz ) * (temp_output_12_0_g59519).zy ) ) );
					float temp_output_66_0_g59517 = ( 1.0 - break55_g59517.y );
					float ifLocalVar60_g59517 = 0;
					if( temp_output_56_0_g59517 <= 0.0 )
					ifLocalVar60_g59517 = temp_output_66_0_g59517;
					else
					ifLocalVar60_g59517 = break55_g59517.y;
					float temp_output_597_28_g59516 = ifLocalVar60_g59517;
					float2 ifLocalVar89_g59517 = 0;
					if( temp_output_56_0_g59517 > 0.0 )
					ifLocalVar89_g59517 = temp_output_123_0_g59517;
					else if( temp_output_56_0_g59517 == 0.0 )
					ifLocalVar89_g59517 = temp_output_90_0_g59517;
					else if( temp_output_56_0_g59517 < 0.0 )
					ifLocalVar89_g59517 = temp_output_90_0_g59517;
					float3 temp_output_7_0_g59520 = frac( ( (ifLocalVar89_g59517).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59520 = dot( temp_output_7_0_g59520 , ( (temp_output_7_0_g59520).yzx + 33.33 ) );
					float3 temp_output_12_0_g59520 = ( temp_output_7_0_g59520 + dotResult8_g59520 );
					float2 temp_output_597_27_g59516 = ( UV100_g59517 + frac( ( ( (temp_output_12_0_g59520).xx + (temp_output_12_0_g59520).yz ) * (temp_output_12_0_g59520).zy ) ) );
					float temp_output_67_0_g59517 = ( 1.0 - break55_g59517.x );
					float ifLocalVar61_g59517 = 0;
					if( temp_output_56_0_g59517 <= 0.0 )
					ifLocalVar61_g59517 = temp_output_67_0_g59517;
					else
					ifLocalVar61_g59517 = break55_g59517.x;
					float temp_output_597_29_g59516 = ifLocalVar61_g59517;
					float4 Output_2D293_g59516 = ( ( tex2D( _GlossinessMap, temp_output_597_0_g59516, DDX631_g59516, DDY632_g59516 ) * temp_output_597_30_g59516 ) + ( tex2D( _GlossinessMap, temp_output_597_26_g59516, DDX631_g59516, DDY632_g59516 ) * temp_output_597_28_g59516 ) + ( tex2D( _GlossinessMap, temp_output_597_27_g59516, DDX631_g59516, DDY632_g59516 ) * temp_output_597_29_g59516 ) );
					float4 break31_g59516 = Output_2D293_g59516;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g59498 = break31_g59516.a;
					#else
					float staticSwitch1004_g59498 = tex2D( _GlossinessMap, UV02420_g59498 ).r;
					#endif
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g59498 = ( 1.0 - staticSwitch1004_g59498 );
					#else
					float staticSwitch845_g59498 = _Glossiness;
					#endif
					float3 temp_output_3_0_g59509 = ddx( NormalWS );
					float dotResult5_g59509 = dot( temp_output_3_0_g59509 , temp_output_3_0_g59509 );
					float3 temp_output_4_0_g59509 = ddy( NormalWS );
					float dotResult6_g59509 = dot( temp_output_4_0_g59509 , temp_output_4_0_g59509 );
					#ifdef _USEGEOMETRICANTIALIASING_ON
					float staticSwitch824_g59498 = min( staticSwitch845_g59498, ( 1.0 - pow( saturate( max( dotResult5_g59509, dotResult6_g59509 ) ) , 0.333 ) ) );
					#else
					float staticSwitch824_g59498 = staticSwitch845_g59498;
					#endif
					float Smoothness1399_g59498 = staticSwitch824_g59498;
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
					Unity_GlossyEnvironmentData g1392_g59498 = UnityGlossyEnvironmentSetup( Smoothness1399_g59498, ViewDirWS, float3( dot( tanToWorld0, tanNormal1392_g59498 ), dot( tanToWorld1, tanNormal1392_g59498 ), dot( tanToWorld2, tanNormal1392_g59498 ) ), float3(0,0,0));
					float3 indirectSpecular1392_g59498 = UnityGI_IndirectSpecular( data, 1.0, float3( dot( tanToWorld0, tanNormal1392_g59498 ), dot( tanToWorld1, tanNormal1392_g59498 ), dot( tanToWorld2, tanNormal1392_g59498 ) ), g1392_g59498 );
					float4 temp_cast_4 = (0.04).xxxx;
					float4 lerpResult1473_g59498 = lerp( temp_cast_4 , oAlbedo6_g59498 , Metallic1239_g59498);
					float3 switchResult1501_g59498 = (((ase_vface>0)?(NormalWS):(-NormalWS)));
					float dotResult1476_g59498 = dot( switchResult1501_g59498 , ViewDirWS );
					float4 lerpResult1480_g59498 = lerp( lerpResult1473_g59498 , float4( 1,1,1,0 ) , pow( ( 1.0 - saturate( dotResult1476_g59498 ) ) , 5.0 ));
					float4 Fresnel1560_g59498 = lerpResult1480_g59498;
					float4 temp_output_1481_0_g59498 = ( float4( indirectSpecular1392_g59498 , 0.0 ) * Fresnel1560_g59498 );
					#ifdef _USELIGHTMAPSPECULAR_ON
					float4 staticSwitch1469_g59498 = ( temp_output_1481_0_g59498 * sqrt( Lightmap46_g59498 ) );
					#else
					float4 staticSwitch1469_g59498 = temp_output_1481_0_g59498;
					#endif
					float4 Specular1419_g59498 = staticSwitch1469_g59498;
					float4 temp_cast_5 = (Black1185_g59498).xxxx;
					float2 temp_output_5_0_g59510 = UV02420_g59498;
					float2 UV633_g59510 = temp_output_5_0_g59510;
					float2 UV100_g59511 = UV633_g59510;
					float2 temp_output_51_0_g59511 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59511 * float2( 3.464,3.464 ) ) );
					float2 break55_g59511 = frac( temp_output_51_0_g59511 );
					float temp_output_56_0_g59511 = ( ( 1.0 - break55_g59511.x ) - break55_g59511.y );
					float2 temp_output_52_0_g59511 = floor( temp_output_51_0_g59511 );
					float2 temp_output_125_0_g59511 = ( temp_output_52_0_g59511 + float2( 1,1 ) );
					float2 ifLocalVar87_g59511 = 0;
					if( temp_output_56_0_g59511 > 0.0 )
					ifLocalVar87_g59511 = temp_output_52_0_g59511;
					else if( temp_output_56_0_g59511 == 0.0 )
					ifLocalVar87_g59511 = temp_output_125_0_g59511;
					else if( temp_output_56_0_g59511 < 0.0 )
					ifLocalVar87_g59511 = temp_output_125_0_g59511;
					float3 temp_output_7_0_g59512 = frac( ( (ifLocalVar87_g59511).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59512 = dot( temp_output_7_0_g59512 , ( (temp_output_7_0_g59512).yzx + 33.33 ) );
					float3 temp_output_12_0_g59512 = ( temp_output_7_0_g59512 + dotResult8_g59512 );
					float2 temp_output_597_0_g59510 = ( UV100_g59511 + frac( ( ( (temp_output_12_0_g59512).xx + (temp_output_12_0_g59512).yz ) * (temp_output_12_0_g59512).zy ) ) );
					float2 DDX631_g59510 = ddx( temp_output_5_0_g59510 );
					float2 DDY632_g59510 = ddy( temp_output_5_0_g59510 );
					float temp_output_65_0_g59511 = ( 0.0 - temp_output_56_0_g59511 );
					float ifLocalVar59_g59511 = 0;
					if( temp_output_56_0_g59511 <= 0.0 )
					ifLocalVar59_g59511 = temp_output_65_0_g59511;
					else
					ifLocalVar59_g59511 = temp_output_56_0_g59511;
					float temp_output_597_30_g59510 = ifLocalVar59_g59511;
					float2 temp_output_90_0_g59511 = ( temp_output_52_0_g59511 + float2( 0,1 ) );
					float2 temp_output_123_0_g59511 = ( temp_output_52_0_g59511 + float2( 1,0 ) );
					float2 ifLocalVar88_g59511 = 0;
					if( temp_output_56_0_g59511 > 0.0 )
					ifLocalVar88_g59511 = temp_output_90_0_g59511;
					else if( temp_output_56_0_g59511 == 0.0 )
					ifLocalVar88_g59511 = temp_output_123_0_g59511;
					else if( temp_output_56_0_g59511 < 0.0 )
					ifLocalVar88_g59511 = temp_output_123_0_g59511;
					float3 temp_output_7_0_g59513 = frac( ( (ifLocalVar88_g59511).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59513 = dot( temp_output_7_0_g59513 , ( (temp_output_7_0_g59513).yzx + 33.33 ) );
					float3 temp_output_12_0_g59513 = ( temp_output_7_0_g59513 + dotResult8_g59513 );
					float2 temp_output_597_26_g59510 = ( UV100_g59511 + frac( ( ( (temp_output_12_0_g59513).xx + (temp_output_12_0_g59513).yz ) * (temp_output_12_0_g59513).zy ) ) );
					float temp_output_66_0_g59511 = ( 1.0 - break55_g59511.y );
					float ifLocalVar60_g59511 = 0;
					if( temp_output_56_0_g59511 <= 0.0 )
					ifLocalVar60_g59511 = temp_output_66_0_g59511;
					else
					ifLocalVar60_g59511 = break55_g59511.y;
					float temp_output_597_28_g59510 = ifLocalVar60_g59511;
					float2 ifLocalVar89_g59511 = 0;
					if( temp_output_56_0_g59511 > 0.0 )
					ifLocalVar89_g59511 = temp_output_123_0_g59511;
					else if( temp_output_56_0_g59511 == 0.0 )
					ifLocalVar89_g59511 = temp_output_90_0_g59511;
					else if( temp_output_56_0_g59511 < 0.0 )
					ifLocalVar89_g59511 = temp_output_90_0_g59511;
					float3 temp_output_7_0_g59514 = frac( ( (ifLocalVar89_g59511).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59514 = dot( temp_output_7_0_g59514 , ( (temp_output_7_0_g59514).yzx + 33.33 ) );
					float3 temp_output_12_0_g59514 = ( temp_output_7_0_g59514 + dotResult8_g59514 );
					float2 temp_output_597_27_g59510 = ( UV100_g59511 + frac( ( ( (temp_output_12_0_g59514).xx + (temp_output_12_0_g59514).yz ) * (temp_output_12_0_g59514).zy ) ) );
					float temp_output_67_0_g59511 = ( 1.0 - break55_g59511.x );
					float ifLocalVar61_g59511 = 0;
					if( temp_output_56_0_g59511 <= 0.0 )
					ifLocalVar61_g59511 = temp_output_67_0_g59511;
					else
					ifLocalVar61_g59511 = break55_g59511.x;
					float temp_output_597_29_g59510 = ifLocalVar61_g59511;
					float4 Output_2D293_g59510 = ( ( tex2D( _EmissionMap, temp_output_597_0_g59510, DDX631_g59510, DDY632_g59510 ) * temp_output_597_30_g59510 ) + ( tex2D( _EmissionMap, temp_output_597_26_g59510, DDX631_g59510, DDY632_g59510 ) * temp_output_597_28_g59510 ) + ( tex2D( _EmissionMap, temp_output_597_27_g59510, DDX631_g59510, DDY632_g59510 ) * temp_output_597_29_g59510 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g59498 = Output_2D293_g59510;
					#else
					float4 staticSwitch1006_g59498 = tex2D( _EmissionMap, UV02420_g59498 );
					#endif
					#if defined( _SPECIALEFFECTS_DISABLED )
					float4 staticSwitch1578_g59498 = staticSwitch1006_g59498;
					#elif defined( _SPECIALEFFECTS_LED )
					float4 staticSwitch1578_g59498 = float4( 0,0,0,0 );
					#else
					float4 staticSwitch1578_g59498 = staticSwitch1006_g59498;
					#endif
					#ifdef _EMISSIONENABLED_ON
					float4 staticSwitch1017_g59498 = ( float4( _EmissionColor , 0.0 ) * staticSwitch1578_g59498 * _EmissionIntensity );
					#else
					float4 staticSwitch1017_g59498 = temp_cast_5;
					#endif
					float4 Emission86_g59498 = staticSwitch1017_g59498;
					float3 WorldPos97_g59550 = PositionWS;
					float3 tanNormal85_g59550 = Normal_Map700_g59498;
					float3 worldNormal85_g59550 = float3( dot( tanToWorld0, tanNormal85_g59550 ), dot( tanToWorld1, tanNormal85_g59550 ), dot( tanToWorld2, tanNormal85_g59550 ) );
					float3 WorldNormal97_g59550 = worldNormal85_g59550;
					float Smoothness97_g59550 = Smoothness1399_g59498;
					float3 LightmapColor97_g59550 = Lightmap46_g59498.rgb;
					float3 ViewDir97_g59550 = ViewDirWS;
					float3 localSpecular97_g59550 = Specular( WorldPos97_g59550 , WorldNormal97_g59550 , Smoothness97_g59550 , LightmapColor97_g59550 , ViewDir97_g59550 );
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1181_g59498 = Lightmap46_g59498;
					#else
					float4 staticSwitch1181_g59498 = ( ( aAlbedo1466_g59498 * Lightmap46_g59498 ) + Specular1419_g59498 + Emission86_g59498 + float4( localSpecular97_g59550 , 0.0 ) );
					#endif
					float4 temp_output_35_0_g59521 = staticSwitch1181_g59498;
					float4 Color353_g59521 = temp_output_35_0_g59521;
					#if defined( _LUTMODE_2D )
					float4 staticSwitch273_g59521 = saturate( temp_output_35_0_g59521 );
					#elif defined( _LUTMODE_3D )
					float4 staticSwitch273_g59521 = temp_output_35_0_g59521;
					#else
					float4 staticSwitch273_g59521 = temp_output_35_0_g59521;
					#endif
					float4 Color_Saturate49_g59521 = staticSwitch273_g59521;
					float Lut_Height213_g59521 = _LUTSize;
					float Lut_Width216_g59521 = ( _LUTSize * Lut_Height213_g59521 );
					float3 appendResult214_g59521 = (float3(( 1.0 / Lut_Width216_g59521 ) , ( 1.0 / Lut_Height213_g59521 ) , ( Lut_Height213_g59521 - 1.0 )));
					float3 Scale_Offset208_g59521 = appendResult214_g59521;
					float2 Scale_Factor292_g59521 = ( (Scale_Offset208_g59521).xy * (Scale_Offset208_g59521).z );
					float2 Offset299_g59521 = ( (Scale_Offset208_g59521).xy * 0.5 );
					float3 Adjusted_UV305_g59521 = ( ( (Color_Saturate49_g59521).xyw * float3( Scale_Factor292_g59521 ,  0.0 ) ) + float3( Offset299_g59521 ,  0.0 ) );
					float2 Scaled_Blue280_g59521 = ( (Color_Saturate49_g59521).zw * (Scale_Offset208_g59521).z );
					float2 Shift288_g59521 = floor( Scaled_Blue280_g59521 );
					float2 Final_X313_g59521 = ( (Adjusted_UV305_g59521).xz + ( Shift288_g59521 * (Scale_Offset208_g59521).y ) );
					float2 appendResult326_g59521 = (float2(Final_X313_g59521.x , (Adjusted_UV305_g59521).yz.x));
					float2 Final_UV325_g59521 = appendResult326_g59521;
					float2 appendResult338_g59521 = (float2((Scale_Offset208_g59521).y , 0.0));
					float2 Offset_UV336_g59521 = ( Final_UV325_g59521 + appendResult338_g59521 );
					float3 lerpResult333_g59521 = lerp( tex2D( _2DLut, Final_UV325_g59521 ).rgb , tex2D( _2DLut, Offset_UV336_g59521 ).rgb , float3( ( Scaled_Blue280_g59521 - Shift288_g59521 ) ,  0.0 ));
					#ifdef _2DLUT
					float4 staticSwitch347_g59521 = float4( lerpResult333_g59521 , 0.0 );
					#else
					float4 staticSwitch347_g59521 = Color_Saturate49_g59521;
					#endif
					float4 TwoD_LUT346_g59521 = staticSwitch347_g59521;
					float3 RGB16_g59522 = ( ( log10( ( ( Color_Saturate49_g59521.xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 );
					#ifdef _3DLUT
					float4 staticSwitch194_g59521 = tex3D( _3DLut, RGB16_g59522 );
					#else
					float4 staticSwitch194_g59521 = Color_Saturate49_g59521;
					#endif
					float4 ThreeD_LUT51_g59521 = staticSwitch194_g59521;
					#if defined( _LUTMODE_2D )
					float4 staticSwitch42_g59521 = TwoD_LUT346_g59521;
					#elif defined( _LUTMODE_3D )
					float4 staticSwitch42_g59521 = ThreeD_LUT51_g59521;
					#else
					float4 staticSwitch42_g59521 = ThreeD_LUT51_g59521;
					#endif
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch41_g59521 = staticSwitch42_g59521;
					#else
					float4 staticSwitch41_g59521 = Color353_g59521;
					#endif
					

					o.Albedo = staticSwitch1180_g59498.rgb;
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

					o.Emission = staticSwitch41_g59521.xyz;
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
				#pragma multi_compile _ LOD_FADE_CROSSFADE
				#define ASE_FOG
				#define _SPECULARHIGHLIGHTS_OFF
				#define ASE_LIGHTING_SIMPLE 1
				#define ASE_NO_AMBIENT 1
				#pragma multi_compile_instancing
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

	
	}
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
	
	Fallback Off
}
/*ASEBEGIN
Version=19907
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5257;-64,-1280;Inherit;False;Meenphie;0;;59498;b3ba55a08dd6b49c7be16c6f35cf2033;1,1008,0;0;5;COLOR;625;FLOAT4;624;FLOAT;156;FLOAT;427;FLOAT3;1024
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3740;576,-1248;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;12;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;True;False;False;True;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;True;1;LightMode=ForwardAdd;False;False;0;False;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3741;576,-1248;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;12;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;True;False;False;True;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;True;1;LightMode=Deferred;False;False;0;False;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3742;576,-1248;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;12;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;True;False;False;True;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;False;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3743;576,-1248;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;12;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;True;False;False;True;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;False;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3744;576,-1248;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;12;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;True;False;False;True;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;False;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3745;576,-1248;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;12;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ScenePickingPass;0;7;ScenePickingPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;True;False;False;True;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=ScenePickingPass;False;False;0;False;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3739;256,-1280;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;5;Meenphie/Standard/Opaque;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardBase;0;1;ForwardBase;17;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;True;False;False;True;False;False;False;False;False;False;True;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;44;Category;0;0;  Instanced Terrain Normals;1;0;Workflow;3;639057696496085390;Surface;0;0;  Blend;0;0;  Dither Shadows;1;0;Two Sided;1;0;Alpha Clipping;0;0;  Use Shadow Threshold;0;0;Deferred Pass;0;639057697912147530;Normal Space;0;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;1;0;Receive Shadows;1;0;Receive Specular;0;639048816800849430;Receive Reflections;1;639048816832280840;GPU Instancing;1;639073784654359690;LOD CrossFade;1;0;Built-in Fog;1;0;Ambient Light;0;639061815177509650;Meta Pass;0;639061815024024000;Add Pass;0;639061815027117730;Override Baked GI;0;0;Write Depth;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;0;Vertex Position;1;0;0;8;False;True;False;False;False;True;False;False;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3738;256,-1536;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;12;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;True;False;False;True;False;False;False;False;False;False;True;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;1;LightMode=ForwardBase;False;False;0;False;0;0;Standard;0;False;0
WireConnection;3739;0;5257;625
WireConnection;3739;2;5257;624
ASEEND*/
//CHKSM=08D6E069581301B0193CF779E54372E099980B12