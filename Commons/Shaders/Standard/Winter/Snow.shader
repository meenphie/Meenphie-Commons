// Made with Amplify Shader Editor v1.9.9.9
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Standard/Winter/Snow"
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
		[Toggle( _USELIGHTMAPPEDREFLECTIONS_ON )] _UseLightmappedReflections( "Use Lightmapped Specular", Float ) = 1
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACELIGHTMAPPING( "CATEGORY SPACE LIGHTMAPPING", Float ) = 0
		[Meenphie_DrawerCategory(STOCHASTIC,true,0,0)] _CATEGORYSTOCHASTIC( "CATEGORY STOCHASTIC", Float ) = 0
		[Toggle( _STOCHASTICENABLED_ON )] _StochasticEnabled( "Stochastic Enabled", Float ) = 0
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESTOCHASTIC( "CATEGORY SPACE STOCHASTIC", Float ) = 0
		[Meenphie_DrawerCategory(COLOR GRADING,true,0,0)] _CATEGORYCOLORGRADING( "CATEGORY COLOR GRADING", Float ) = 0
		[NoScaleOffset][SingleLineTexture] _3DLut( "3D Lut", 3D ) = "black" {}
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACECOLORGRADING( "CATEGORY SPACE COLOR GRADING", Float ) = 0
		[Meenphie_DrawerCategory(SPECIAL EFFECTS,true,0,0)] _CATEGORYSPECIALEFFECTS( "CATEGORY SPECIAL EFFECTS", Float ) = 0
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESPECIALEFFECTS( "CATEGORY SPACE SPECIAL EFFECTS", Float ) = 0
		[Meenphie_DrawerCategory(SNOW,true,0,0)] _CATEGORYSNOW( "CATEGORY SNOW", Float ) = 0
		_Intensity( "Intensity", Float ) = 100
		_VoronoiScale( "Voronoi Scale", Float ) = 500
		_NoiseScale( "Noise Scale", Float ) = 500
		_NoisePower( "Noise Power", Float ) = 10
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESNOW( "CATEGORY SPACE SNOW", Float ) = 0
		[HideInInspector] GenKey__GlossinessMap( "Assign keyword _GLOSSINESSMAP", Float ) = 1.0
		[HideInInspector] GenKey__MetallicMap( "Assign keyword _METALLICMAP", Float ) = 1.0
		[HideInInspector] GenKey__MainTex( "Assign keyword _MAINTEX", Float ) = 1.0
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
				#pragma multi_compile _ LOD_FADE_CROSSFADE
				#pragma multi_compile_fog
				#define ASE_FOG
				#define _SPECULARHIGHLIGHTS_OFF
				#pragma multi_compile_instancing
				#define _SPECULAR_SETUP 1
				#define ASE_VERSION 19909

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
				#pragma shader_feature_local _USELIGHTMAPPEDREFLECTIONS_ON
				#pragma shader_feature_local _METALLICMAP
				#pragma shader_feature_local _USEGEOMETRICAA_ON
				#pragma shader_feature_local _GLOSSINESSMAP
				#pragma shader_feature_local _BUMPMAP
				#pragma shader_feature_local _LIGHTMAPMODE_DISABLED _LIGHTMAPMODE_SIMPLE _LIGHTMAPMODE_SIMPLELERP _LIGHTMAPMODE_RNM _LIGHTMAPMODE_RNMLERP
				#pragma shader_feature_local _USEBICUBICFILTERING_ON
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
				uniform float _CATEGORYSPACESURFACEOPTIONS;
				uniform float _UdonSpecularLightCount;
				uniform sampler3D _3DLut;
				uniform float _CATEGORYSNOW;
				uniform float _CATEGORYSPACESNOW;
				uniform float4 _UdonSpecularLightUp[32];
				uniform float4 _UdonSpecularLightDir[32];
				uniform float4 _UdonSpecularLightCol[32];
				uniform float4 _UdonSpecularLightPos[32];
				uniform float4 _UdonSpecularLightRight[32];
				uniform half4 _Color;
				uniform sampler2D _MainTex;
				sampler2D _Sampler82966_g5296;
				uniform float _Intensity;
				uniform float _VoronoiScale;
				uniform float _NoiseScale;
				uniform float _NoisePower;
				uniform float3 _EmissionColor;
				uniform sampler2D _EmissionMap;
				sampler2D _Sampler82968_g5296;
				uniform float _EmissionIntensity;
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				sampler2D _Sampler82967_g5296;
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				sampler2D _Sampler82964_g5296;
				uniform sampler2D _BumpMap;
				sampler2D _Sampler82965_g5296;
				uniform float _IOR;
				uniform sampler2D _Lightmap0;
				float4 _Lightmap0_TexelSize;
				uniform sampler2D _Lightmap1;
				float4 _Lightmap1_TexelSize;
				uniform float _UdonLightmapLerp;
				uniform sampler2D _UdonRNMX0;
				float4 _UdonRNMX0_TexelSize;
				uniform sampler2D _UdonRNMY0;
				uniform sampler2D _UdonRNMZ0;
				uniform sampler2D _UdonRNMX1;
				float4 _UdonRNMX1_TexelSize;
				uniform sampler2D _UdonRNMY1;
				uniform sampler2D _UdonRNMZ1;


						float2 voronoihash3_g59831( float2 p )
						{
							
							p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
							return frac( sin( p ) *43758.5453);
						}
				
						float voronoi3_g59831( float2 v, float time, inout float2 id, inout float2 mr, float smoothness, inout float2 smoothId )
						{
							float2 n = floor( v );
							float2 f = frac( v );
							float F1 = 8.0;
							float F2 = 8.0; float2 mg = 0; int i, j;
							for ( j = -2; j <= 2; j++ )
							{
								for ( i = -2; i <= 2; i++ )
							 	{
							 		float2 g = float2( i, j );
							 		float2 o = voronoihash3_g59831( n + g );
									o = ( sin( time + o * 6.2831 ) * 0.5 + 0.5 ); float2 r = f - g - o;
									float d = 0.5 * dot( r, r );
							 		if( d<F1 ) {
							 			F2 = F1;
							 			F1 = d; mg = g; mr = r; id = o;
							 		} else if( d<F2 ) {
							 			F2 = d;
							
							 		}
							 	}
							}
							return F2 - F1;
						}
				
				inline float noise_randomValue (float2 uv) { return frac(sin(dot(uv, float2(12.9898, 78.233)))*43758.5453); }
				inline float noise_interpolate (float a, float b, float t) { return (1.0-t)*a + (t*b); }
				inline float valueNoise (float2 uv)
				{
					float2 i = floor(uv);
					float2 f = frac( uv );
					f = f* f * (3.0 - 2.0 * f);
					uv = abs( frac(uv) - 0.5);
					float2 c0 = i + float2( 0.0, 0.0 );
					float2 c1 = i + float2( 1.0, 0.0 );
					float2 c2 = i + float2( 0.0, 1.0 );
					float2 c3 = i + float2( 1.0, 1.0 );
					float r0 = noise_randomValue( c0 );
					float r1 = noise_randomValue( c1 );
					float r2 = noise_randomValue( c2 );
					float r3 = noise_randomValue( c3 );
					float bottomOfGrid = noise_interpolate( r0, r1, f.x );
					float topOfGrid = noise_interpolate( r2, r3, f.x );
					float t = noise_interpolate( bottomOfGrid, topOfGrid, f.y );
					return t;
				}
				
				float SimpleNoise(float2 UV)
				{
					float t = 0.0;
					float freq = pow( 2.0, float( 0 ) );
					float amp = pow( 0.5, float( 3 - 0 ) );
					t += valueNoise( UV/freq )*amp;
					freq = pow(2.0, float(1));
					amp = pow(0.5, float(3-1));
					t += valueNoise( UV/freq )*amp;
					freq = pow(2.0, float(2));
					amp = pow(0.5, float(3-2));
					t += valueNoise( UV/freq )*amp;
					return t;
				}
				
				float3 IndirectSpecular1_g59751( float3 Color, float Metallic, float Smoothness, float IOR, float3 Fresnel, float3 WorldPos, float3 WorldNormal, float3 ViewDir )
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
					float roughnessOrig       = 1.0 - Smoothness;
					float perceptualRoughness = saturate(roughnessOrig);
					// --- 5. MIP MAPPING ---
					float angleThreshold = smoothstep(0.0, 0.1, nDotV);
					float mipLevel       = clamp(perceptualRoughness * angleThreshold * maxMip, 0.0, maxMip);
					// --- 6. FRESNEL PBR ---
					float3 F = F0 + (max(float3(Smoothness, Smoothness, Smoothness), F0) - F0) * pow(1.0 - nDotV, 5.0);
					// --- 7. ATTENUATION ---
					float logCurve  = 1.0 - sqrt(roughnessOrig);
					float finalFade = lerp(logCurve, 1.0, Metallic);
					// --- 8. SAMPLING ---
					float4 sampleCube   = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, ray, mipLevel);
					float3 indirectSpec = DecodeHDR(sampleCube, unity_SpecCube0_HDR);
					return indirectSpec * F * finalFade;
				}
				
				float3 DirectSpecular( float3 Color, float Metallic, float Smoothness, float SmoothnessAA, float IOR, float3 Fresnel, float3 Lightmap, float3 WorldPos, float3 WorldNormal, float3 ViewDir )
				{
					// --- CONFIGURATION ---
					static const float specBoost  = 0.01;
					static const float lumaStart  = 0.02;
					static const float lumaEnd    = 0.5;
					static const float metalBrightness = 10.0;
					static const float metalPeakMax    = 2.0;
					static const float maxVisibleDist = 16.0;
					static const float fadeStart      = 8.0;
					// --- INIT ---
					float3 N    = normalize(WorldNormal);
					float3 vDir = normalize(ViewDir);
					float3 R    = reflect(-vDir, N);
					// --- LIGHTMAP MASK ---
					float  luma   = dot(Lightmap, float3(0.2126, 0.7152, 0.0722));
					float  lmMask = smoothstep(lumaStart, lumaEnd, luma);
					float3 lmTint = lmMask * lerp(1.0, Lightmap / max(luma, 1e-4), Metallic);
					if (Smoothness < 0.0001 || _UdonSpecularLightCount < 0.5 || lmMask <= 0.0001) return 0.0;
					// --- ROUGHNESS & AA LOGIC ---
					// 1. Original artist intent
					float roughnessOrig = 1.0 - Smoothness;
					float alphaOrig     = roughnessOrig * roughnessOrig;
					float alpha2Orig    = max(alphaOrig * alphaOrig, 0.0001);
					// 2. Geometric AA roughness (prevents flickering, used for lobe shape)
					float roughnessAA = 1.0 - SmoothnessAA;
					float alphaAA     = roughnessAA * roughnessAA;
					float alpha2AA    = max(alphaAA * alphaAA, 0.0001);
					// 3. Metal brightness control
					float peakRatio          = min(sqrt(alpha2AA / alpha2Orig), metalPeakMax);
					float metalPeakBoost     = lerp(0.0, peakRatio, metalBrightness);
					float energyCompensation = lerp(1.0, metalPeakBoost, Metallic);
					// 4. Perceptual falloff (dielectrics only)
					float logCurve  = 1.0 - sqrt(roughnessOrig);
					float finalFade = lerp(logCurve, 1.0, Metallic);
					// --- SPECULAR LOOP ---
					float  nDotV     = max(dot(N, vDir), 1e-4);
					float3 specAccum = 0;
					int    loopCount = (int)_UdonSpecularLightCount;
					for (int i = 0; i < loopCount; i++) {
					    float4 posRange = _UdonSpecularLightPos[i];
					    // Distance fade — full brightness within fadeStart, then linear falloff to maxVisibleDist
					    float camDist      = distance(_WorldSpaceCameraPos, posRange.xyz);
					    float distanceFade = saturate(1.0 - (camDist - fadeStart) / max(maxVisibleDist - fadeStart, 1e-4));
					    if (distanceFade <= 0.0) continue;
					    float3 L_vector = posRange.xyz - WorldPos;
					    float  distSq   = dot(L_vector, L_vector);
					    float4 dirAngle = _UdonSpecularLightDir[i];
					    float3 L_norm   = L_vector * rsqrt(max(distSq, 1e-6));
					    // Spot mask
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
					        // MRP area light
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
					        // Rectangle mask — softness follows AA roughness
					        float  softness   = max(0.1, roughnessAA * 2.0);
					        float2 distToEdge = abs(localP) - halfSize;
					        rectMask = smoothstep(softness, 0.0, length(max(distToEdge, 0.0)));
					    }
					    if (rectMask <= 0.0) continue;
					    float  dSqDiff = dot(diff, diff);
					    float3 lDir    = diff * rsqrt(max(dSqDiff, 1e-6));
					    float3 H       = normalize(lDir + vDir);
					    float nDotH = saturate(dot(N, H));
					    float nDotL = saturate(dot(N, lDir));
					    // GGX NDF — AA lobe shape for everyone
					    float d_denom = nDotH * nDotH * (alpha2AA - 1.0) + 1.0;
					    float D       = alpha2AA / (3.14159 * d_denom * d_denom + 1e-7);
					    // Smith visibility — consistent with AA alpha
					    float k  = alphaAA * 0.5;
					    float Gv = nDotV / (nDotV * (1.0 - k) + k);
					    float Gl = nDotL / (nDotL * (1.0 - k) + k);
					    float G  = Gv * Gl;
					    // Cook-Torrance, no Fresnel — handled externally
					    float3 spec = (D * G) / max(4.0 * nDotV * nDotL, 0.001);
					    // Accumulate — max(0) guards against negatives
					    specAccum += max(0.0, _UdonSpecularLightCol[i].rgb
					        * _UdonSpecularLightCol[i].w
					        * spec
					        * nDotL
					        * spotMask
					        * distanceFade
					        * rectMask);
					}
					// --- FINAL ---
					float3 colorTint = lerp(1.0, Color.rgb, Metallic);
					float3 result = specAccum * colorTint * lmTint * specBoost * finalFade * energyCompensation;
					return result;
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

					float2 texCoord2357_g5296 = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0A2420_g5296 = texCoord2357_g5296;
					#ifdef _MAINTEX
					float4 staticSwitch1549_g5296 = tex2D( _MainTex, UV0A2420_g5296 );
					#else
					float4 staticSwitch1549_g5296 = _Color;
					#endif
					float2 temp_output_5_0_g59681 = UV0A2420_g5296;
					float2 UV633_g59681 = temp_output_5_0_g59681;
					float2 UV100_g59682 = UV633_g59681;
					float2 temp_output_51_0_g59682 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59682 * float2( 3.464,3.464 ) ) );
					float2 break55_g59682 = frac( temp_output_51_0_g59682 );
					float temp_output_56_0_g59682 = ( ( 1.0 - break55_g59682.x ) - break55_g59682.y );
					float2 temp_output_52_0_g59682 = floor( temp_output_51_0_g59682 );
					float2 temp_output_125_0_g59682 = ( temp_output_52_0_g59682 + float2( 1,1 ) );
					float2 ifLocalVar87_g59682 = 0;
					if( temp_output_56_0_g59682 > 0.0 )
					ifLocalVar87_g59682 = temp_output_52_0_g59682;
					else if( temp_output_56_0_g59682 == 0.0 )
					ifLocalVar87_g59682 = temp_output_125_0_g59682;
					else if( temp_output_56_0_g59682 < 0.0 )
					ifLocalVar87_g59682 = temp_output_125_0_g59682;
					float3 temp_output_7_0_g59683 = frac( ( (ifLocalVar87_g59682).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59683 = dot( temp_output_7_0_g59683 , ( (temp_output_7_0_g59683).yzx + 33.33 ) );
					float3 temp_output_12_0_g59683 = ( temp_output_7_0_g59683 + dotResult8_g59683 );
					float2 temp_output_597_0_g59681 = ( UV100_g59682 + frac( ( ( (temp_output_12_0_g59683).xx + (temp_output_12_0_g59683).yz ) * (temp_output_12_0_g59683).zy ) ) );
					float2 DDX631_g59681 = ddx( temp_output_5_0_g59681 );
					float2 DDY632_g59681 = ddy( temp_output_5_0_g59681 );
					float temp_output_65_0_g59682 = ( 0.0 - temp_output_56_0_g59682 );
					float ifLocalVar59_g59682 = 0;
					if( temp_output_56_0_g59682 <= 0.0 )
					ifLocalVar59_g59682 = temp_output_65_0_g59682;
					else
					ifLocalVar59_g59682 = temp_output_56_0_g59682;
					float temp_output_597_30_g59681 = ifLocalVar59_g59682;
					float2 temp_output_90_0_g59682 = ( temp_output_52_0_g59682 + float2( 0,1 ) );
					float2 temp_output_123_0_g59682 = ( temp_output_52_0_g59682 + float2( 1,0 ) );
					float2 ifLocalVar88_g59682 = 0;
					if( temp_output_56_0_g59682 > 0.0 )
					ifLocalVar88_g59682 = temp_output_90_0_g59682;
					else if( temp_output_56_0_g59682 == 0.0 )
					ifLocalVar88_g59682 = temp_output_123_0_g59682;
					else if( temp_output_56_0_g59682 < 0.0 )
					ifLocalVar88_g59682 = temp_output_123_0_g59682;
					float3 temp_output_7_0_g59684 = frac( ( (ifLocalVar88_g59682).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59684 = dot( temp_output_7_0_g59684 , ( (temp_output_7_0_g59684).yzx + 33.33 ) );
					float3 temp_output_12_0_g59684 = ( temp_output_7_0_g59684 + dotResult8_g59684 );
					float2 temp_output_597_26_g59681 = ( UV100_g59682 + frac( ( ( (temp_output_12_0_g59684).xx + (temp_output_12_0_g59684).yz ) * (temp_output_12_0_g59684).zy ) ) );
					float temp_output_66_0_g59682 = ( 1.0 - break55_g59682.y );
					float ifLocalVar60_g59682 = 0;
					if( temp_output_56_0_g59682 <= 0.0 )
					ifLocalVar60_g59682 = temp_output_66_0_g59682;
					else
					ifLocalVar60_g59682 = break55_g59682.y;
					float temp_output_597_28_g59681 = ifLocalVar60_g59682;
					float2 ifLocalVar89_g59682 = 0;
					if( temp_output_56_0_g59682 > 0.0 )
					ifLocalVar89_g59682 = temp_output_123_0_g59682;
					else if( temp_output_56_0_g59682 == 0.0 )
					ifLocalVar89_g59682 = temp_output_90_0_g59682;
					else if( temp_output_56_0_g59682 < 0.0 )
					ifLocalVar89_g59682 = temp_output_90_0_g59682;
					float3 temp_output_7_0_g59685 = frac( ( (ifLocalVar89_g59682).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59685 = dot( temp_output_7_0_g59685 , ( (temp_output_7_0_g59685).yzx + 33.33 ) );
					float3 temp_output_12_0_g59685 = ( temp_output_7_0_g59685 + dotResult8_g59685 );
					float2 temp_output_597_27_g59681 = ( UV100_g59682 + frac( ( ( (temp_output_12_0_g59685).xx + (temp_output_12_0_g59685).yz ) * (temp_output_12_0_g59685).zy ) ) );
					float temp_output_67_0_g59682 = ( 1.0 - break55_g59682.x );
					float ifLocalVar61_g59682 = 0;
					if( temp_output_56_0_g59682 <= 0.0 )
					ifLocalVar61_g59682 = temp_output_67_0_g59682;
					else
					ifLocalVar61_g59682 = break55_g59682.x;
					float temp_output_597_29_g59681 = ifLocalVar61_g59682;
					float4 Output_2D293_g59681 = ( ( tex2D( _Sampler82966_g5296, temp_output_597_0_g59681, DDX631_g59681, DDY632_g59681 ) * temp_output_597_30_g59681 ) + ( tex2D( _Sampler82966_g5296, temp_output_597_26_g59681, DDX631_g59681, DDY632_g59681 ) * temp_output_597_28_g59681 ) + ( tex2D( _Sampler82966_g5296, temp_output_597_27_g59681, DDX631_g59681, DDY632_g59681 ) * temp_output_597_29_g59681 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g5296 = Output_2D293_g59681;
					#else
					float4 staticSwitch1001_g5296 = staticSwitch1549_g5296;
					#endif
					float3 temp_output_2532_0_g5296 = (staticSwitch1001_g5296).rgb;
					float3 oAlbedo6_g5296 = temp_output_2532_0_g5296;
					float Black1185_g5296 = 0.0;
					float3 temp_cast_0 = (Black1185_g5296).xxx;
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch1180_g5296 = temp_cast_0;
					#else
					float3 staticSwitch1180_g5296 = oAlbedo6_g5296;
					#endif
					
					float time3_g59831 = 0.0;
					float2 voronoiSmoothId3_g59831 = 0;
					float2 coords3_g59831 = IN.ase_texcoord6.xy * _VoronoiScale;
					float2 id3_g59831 = 0;
					float2 uv3_g59831 = 0;
					float voroi3_g59831 = voronoi3_g59831( coords3_g59831, time3_g59831, id3_g59831, uv3_g59831, 0, voronoiSmoothId3_g59831 );
					float saferPower5_g59831 = abs( voroi3_g59831 );
					float2 texCoord4_g59831 = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					float simpleNoise8_g59831 = SimpleNoise( texCoord4_g59831*_NoiseScale );
					float saferPower6_g59831 = abs( simpleNoise8_g59831 );
					float clampResult12_g59831 = clamp( ( ( _Intensity * pow( saferPower5_g59831 , 5.0 ) ) * pow( saferPower6_g59831 , _NoisePower ) ) , 0.0 , 1.0 );
					float3 temp_cast_1 = (clampResult12_g59831).xxx;
					
					float2 temp_output_5_0_g59692 = UV0A2420_g5296;
					float2 UV633_g59692 = temp_output_5_0_g59692;
					float2 UV100_g59693 = UV633_g59692;
					float2 temp_output_51_0_g59693 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59693 * float2( 3.464,3.464 ) ) );
					float2 break55_g59693 = frac( temp_output_51_0_g59693 );
					float temp_output_56_0_g59693 = ( ( 1.0 - break55_g59693.x ) - break55_g59693.y );
					float2 temp_output_52_0_g59693 = floor( temp_output_51_0_g59693 );
					float2 temp_output_125_0_g59693 = ( temp_output_52_0_g59693 + float2( 1,1 ) );
					float2 ifLocalVar87_g59693 = 0;
					if( temp_output_56_0_g59693 > 0.0 )
					ifLocalVar87_g59693 = temp_output_52_0_g59693;
					else if( temp_output_56_0_g59693 == 0.0 )
					ifLocalVar87_g59693 = temp_output_125_0_g59693;
					else if( temp_output_56_0_g59693 < 0.0 )
					ifLocalVar87_g59693 = temp_output_125_0_g59693;
					float3 temp_output_7_0_g59694 = frac( ( (ifLocalVar87_g59693).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59694 = dot( temp_output_7_0_g59694 , ( (temp_output_7_0_g59694).yzx + 33.33 ) );
					float3 temp_output_12_0_g59694 = ( temp_output_7_0_g59694 + dotResult8_g59694 );
					float2 temp_output_597_0_g59692 = ( UV100_g59693 + frac( ( ( (temp_output_12_0_g59694).xx + (temp_output_12_0_g59694).yz ) * (temp_output_12_0_g59694).zy ) ) );
					float2 DDX631_g59692 = ddx( temp_output_5_0_g59692 );
					float2 DDY632_g59692 = ddy( temp_output_5_0_g59692 );
					float temp_output_65_0_g59693 = ( 0.0 - temp_output_56_0_g59693 );
					float ifLocalVar59_g59693 = 0;
					if( temp_output_56_0_g59693 <= 0.0 )
					ifLocalVar59_g59693 = temp_output_65_0_g59693;
					else
					ifLocalVar59_g59693 = temp_output_56_0_g59693;
					float temp_output_597_30_g59692 = ifLocalVar59_g59693;
					float2 temp_output_90_0_g59693 = ( temp_output_52_0_g59693 + float2( 0,1 ) );
					float2 temp_output_123_0_g59693 = ( temp_output_52_0_g59693 + float2( 1,0 ) );
					float2 ifLocalVar88_g59693 = 0;
					if( temp_output_56_0_g59693 > 0.0 )
					ifLocalVar88_g59693 = temp_output_90_0_g59693;
					else if( temp_output_56_0_g59693 == 0.0 )
					ifLocalVar88_g59693 = temp_output_123_0_g59693;
					else if( temp_output_56_0_g59693 < 0.0 )
					ifLocalVar88_g59693 = temp_output_123_0_g59693;
					float3 temp_output_7_0_g59695 = frac( ( (ifLocalVar88_g59693).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59695 = dot( temp_output_7_0_g59695 , ( (temp_output_7_0_g59695).yzx + 33.33 ) );
					float3 temp_output_12_0_g59695 = ( temp_output_7_0_g59695 + dotResult8_g59695 );
					float2 temp_output_597_26_g59692 = ( UV100_g59693 + frac( ( ( (temp_output_12_0_g59695).xx + (temp_output_12_0_g59695).yz ) * (temp_output_12_0_g59695).zy ) ) );
					float temp_output_66_0_g59693 = ( 1.0 - break55_g59693.y );
					float ifLocalVar60_g59693 = 0;
					if( temp_output_56_0_g59693 <= 0.0 )
					ifLocalVar60_g59693 = temp_output_66_0_g59693;
					else
					ifLocalVar60_g59693 = break55_g59693.y;
					float temp_output_597_28_g59692 = ifLocalVar60_g59693;
					float2 ifLocalVar89_g59693 = 0;
					if( temp_output_56_0_g59693 > 0.0 )
					ifLocalVar89_g59693 = temp_output_123_0_g59693;
					else if( temp_output_56_0_g59693 == 0.0 )
					ifLocalVar89_g59693 = temp_output_90_0_g59693;
					else if( temp_output_56_0_g59693 < 0.0 )
					ifLocalVar89_g59693 = temp_output_90_0_g59693;
					float3 temp_output_7_0_g59696 = frac( ( (ifLocalVar89_g59693).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59696 = dot( temp_output_7_0_g59696 , ( (temp_output_7_0_g59696).yzx + 33.33 ) );
					float3 temp_output_12_0_g59696 = ( temp_output_7_0_g59696 + dotResult8_g59696 );
					float2 temp_output_597_27_g59692 = ( UV100_g59693 + frac( ( ( (temp_output_12_0_g59696).xx + (temp_output_12_0_g59696).yz ) * (temp_output_12_0_g59696).zy ) ) );
					float temp_output_67_0_g59693 = ( 1.0 - break55_g59693.x );
					float ifLocalVar61_g59693 = 0;
					if( temp_output_56_0_g59693 <= 0.0 )
					ifLocalVar61_g59693 = temp_output_67_0_g59693;
					else
					ifLocalVar61_g59693 = break55_g59693.x;
					float temp_output_597_29_g59692 = ifLocalVar61_g59693;
					float4 Output_2D293_g59692 = ( ( tex2D( _Sampler82968_g5296, temp_output_597_0_g59692, DDX631_g59692, DDY632_g59692 ) * temp_output_597_30_g59692 ) + ( tex2D( _Sampler82968_g5296, temp_output_597_26_g59692, DDX631_g59692, DDY632_g59692 ) * temp_output_597_28_g59692 ) + ( tex2D( _Sampler82968_g5296, temp_output_597_27_g59692, DDX631_g59692, DDY632_g59692 ) * temp_output_597_29_g59692 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g5296 = Output_2D293_g59692;
					#else
					float4 staticSwitch1006_g5296 = tex2D( _EmissionMap, UV0A2420_g5296 );
					#endif
					float3 temp_output_2531_0_g5296 = (( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g5296 * _EmissionIntensity )).rgb;
					float3 Emission86_g5296 = temp_output_2531_0_g5296;
					float3 Color1_g59751 = oAlbedo6_g5296;
					#ifdef _METALLICMAP
					float staticSwitch846_g5296 = tex2D( _MetallicMap, UV0A2420_g5296 ).r;
					#else
					float staticSwitch846_g5296 = _Metallic;
					#endif
					float2 temp_output_5_0_g59755 = UV0A2420_g5296;
					float2 UV633_g59755 = temp_output_5_0_g59755;
					float2 UV100_g59756 = UV633_g59755;
					float2 temp_output_51_0_g59756 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59756 * float2( 3.464,3.464 ) ) );
					float2 break55_g59756 = frac( temp_output_51_0_g59756 );
					float temp_output_56_0_g59756 = ( ( 1.0 - break55_g59756.x ) - break55_g59756.y );
					float2 temp_output_52_0_g59756 = floor( temp_output_51_0_g59756 );
					float2 temp_output_125_0_g59756 = ( temp_output_52_0_g59756 + float2( 1,1 ) );
					float2 ifLocalVar87_g59756 = 0;
					if( temp_output_56_0_g59756 > 0.0 )
					ifLocalVar87_g59756 = temp_output_52_0_g59756;
					else if( temp_output_56_0_g59756 == 0.0 )
					ifLocalVar87_g59756 = temp_output_125_0_g59756;
					else if( temp_output_56_0_g59756 < 0.0 )
					ifLocalVar87_g59756 = temp_output_125_0_g59756;
					float3 temp_output_7_0_g59757 = frac( ( (ifLocalVar87_g59756).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59757 = dot( temp_output_7_0_g59757 , ( (temp_output_7_0_g59757).yzx + 33.33 ) );
					float3 temp_output_12_0_g59757 = ( temp_output_7_0_g59757 + dotResult8_g59757 );
					float2 temp_output_597_0_g59755 = ( UV100_g59756 + frac( ( ( (temp_output_12_0_g59757).xx + (temp_output_12_0_g59757).yz ) * (temp_output_12_0_g59757).zy ) ) );
					float2 DDX631_g59755 = ddx( temp_output_5_0_g59755 );
					float2 DDY632_g59755 = ddy( temp_output_5_0_g59755 );
					float temp_output_65_0_g59756 = ( 0.0 - temp_output_56_0_g59756 );
					float ifLocalVar59_g59756 = 0;
					if( temp_output_56_0_g59756 <= 0.0 )
					ifLocalVar59_g59756 = temp_output_65_0_g59756;
					else
					ifLocalVar59_g59756 = temp_output_56_0_g59756;
					float temp_output_597_30_g59755 = ifLocalVar59_g59756;
					float2 temp_output_90_0_g59756 = ( temp_output_52_0_g59756 + float2( 0,1 ) );
					float2 temp_output_123_0_g59756 = ( temp_output_52_0_g59756 + float2( 1,0 ) );
					float2 ifLocalVar88_g59756 = 0;
					if( temp_output_56_0_g59756 > 0.0 )
					ifLocalVar88_g59756 = temp_output_90_0_g59756;
					else if( temp_output_56_0_g59756 == 0.0 )
					ifLocalVar88_g59756 = temp_output_123_0_g59756;
					else if( temp_output_56_0_g59756 < 0.0 )
					ifLocalVar88_g59756 = temp_output_123_0_g59756;
					float3 temp_output_7_0_g59758 = frac( ( (ifLocalVar88_g59756).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59758 = dot( temp_output_7_0_g59758 , ( (temp_output_7_0_g59758).yzx + 33.33 ) );
					float3 temp_output_12_0_g59758 = ( temp_output_7_0_g59758 + dotResult8_g59758 );
					float2 temp_output_597_26_g59755 = ( UV100_g59756 + frac( ( ( (temp_output_12_0_g59758).xx + (temp_output_12_0_g59758).yz ) * (temp_output_12_0_g59758).zy ) ) );
					float temp_output_66_0_g59756 = ( 1.0 - break55_g59756.y );
					float ifLocalVar60_g59756 = 0;
					if( temp_output_56_0_g59756 <= 0.0 )
					ifLocalVar60_g59756 = temp_output_66_0_g59756;
					else
					ifLocalVar60_g59756 = break55_g59756.y;
					float temp_output_597_28_g59755 = ifLocalVar60_g59756;
					float2 ifLocalVar89_g59756 = 0;
					if( temp_output_56_0_g59756 > 0.0 )
					ifLocalVar89_g59756 = temp_output_123_0_g59756;
					else if( temp_output_56_0_g59756 == 0.0 )
					ifLocalVar89_g59756 = temp_output_90_0_g59756;
					else if( temp_output_56_0_g59756 < 0.0 )
					ifLocalVar89_g59756 = temp_output_90_0_g59756;
					float3 temp_output_7_0_g59759 = frac( ( (ifLocalVar89_g59756).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59759 = dot( temp_output_7_0_g59759 , ( (temp_output_7_0_g59759).yzx + 33.33 ) );
					float3 temp_output_12_0_g59759 = ( temp_output_7_0_g59759 + dotResult8_g59759 );
					float2 temp_output_597_27_g59755 = ( UV100_g59756 + frac( ( ( (temp_output_12_0_g59759).xx + (temp_output_12_0_g59759).yz ) * (temp_output_12_0_g59759).zy ) ) );
					float temp_output_67_0_g59756 = ( 1.0 - break55_g59756.x );
					float ifLocalVar61_g59756 = 0;
					if( temp_output_56_0_g59756 <= 0.0 )
					ifLocalVar61_g59756 = temp_output_67_0_g59756;
					else
					ifLocalVar61_g59756 = break55_g59756.x;
					float temp_output_597_29_g59755 = ifLocalVar61_g59756;
					float4 Output_2D293_g59755 = ( ( tex2D( _Sampler82967_g5296, temp_output_597_0_g59755, DDX631_g59755, DDY632_g59755 ) * temp_output_597_30_g59755 ) + ( tex2D( _Sampler82967_g5296, temp_output_597_26_g59755, DDX631_g59755, DDY632_g59755 ) * temp_output_597_28_g59755 ) + ( tex2D( _Sampler82967_g5296, temp_output_597_27_g59755, DDX631_g59755, DDY632_g59755 ) * temp_output_597_29_g59755 ) );
					float4 break31_g59755 = Output_2D293_g59755;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g5296 = break31_g59755.r;
					#else
					float staticSwitch1005_g5296 = staticSwitch846_g5296;
					#endif
					float Metallic1239_g5296 = staticSwitch1005_g5296;
					float Metallic1_g59751 = Metallic1239_g5296;
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g5296 = tex2D( _GlossinessMap, UV0A2420_g5296 ).r;
					#else
					float staticSwitch845_g5296 = _Glossiness;
					#endif
					float2 temp_output_5_0_g59686 = UV0A2420_g5296;
					float2 UV633_g59686 = temp_output_5_0_g59686;
					float2 UV100_g59687 = UV633_g59686;
					float2 temp_output_51_0_g59687 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59687 * float2( 3.464,3.464 ) ) );
					float2 break55_g59687 = frac( temp_output_51_0_g59687 );
					float temp_output_56_0_g59687 = ( ( 1.0 - break55_g59687.x ) - break55_g59687.y );
					float2 temp_output_52_0_g59687 = floor( temp_output_51_0_g59687 );
					float2 temp_output_125_0_g59687 = ( temp_output_52_0_g59687 + float2( 1,1 ) );
					float2 ifLocalVar87_g59687 = 0;
					if( temp_output_56_0_g59687 > 0.0 )
					ifLocalVar87_g59687 = temp_output_52_0_g59687;
					else if( temp_output_56_0_g59687 == 0.0 )
					ifLocalVar87_g59687 = temp_output_125_0_g59687;
					else if( temp_output_56_0_g59687 < 0.0 )
					ifLocalVar87_g59687 = temp_output_125_0_g59687;
					float3 temp_output_7_0_g59688 = frac( ( (ifLocalVar87_g59687).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59688 = dot( temp_output_7_0_g59688 , ( (temp_output_7_0_g59688).yzx + 33.33 ) );
					float3 temp_output_12_0_g59688 = ( temp_output_7_0_g59688 + dotResult8_g59688 );
					float2 temp_output_597_0_g59686 = ( UV100_g59687 + frac( ( ( (temp_output_12_0_g59688).xx + (temp_output_12_0_g59688).yz ) * (temp_output_12_0_g59688).zy ) ) );
					float2 DDX631_g59686 = ddx( temp_output_5_0_g59686 );
					float2 DDY632_g59686 = ddy( temp_output_5_0_g59686 );
					float temp_output_65_0_g59687 = ( 0.0 - temp_output_56_0_g59687 );
					float ifLocalVar59_g59687 = 0;
					if( temp_output_56_0_g59687 <= 0.0 )
					ifLocalVar59_g59687 = temp_output_65_0_g59687;
					else
					ifLocalVar59_g59687 = temp_output_56_0_g59687;
					float temp_output_597_30_g59686 = ifLocalVar59_g59687;
					float2 temp_output_90_0_g59687 = ( temp_output_52_0_g59687 + float2( 0,1 ) );
					float2 temp_output_123_0_g59687 = ( temp_output_52_0_g59687 + float2( 1,0 ) );
					float2 ifLocalVar88_g59687 = 0;
					if( temp_output_56_0_g59687 > 0.0 )
					ifLocalVar88_g59687 = temp_output_90_0_g59687;
					else if( temp_output_56_0_g59687 == 0.0 )
					ifLocalVar88_g59687 = temp_output_123_0_g59687;
					else if( temp_output_56_0_g59687 < 0.0 )
					ifLocalVar88_g59687 = temp_output_123_0_g59687;
					float3 temp_output_7_0_g59689 = frac( ( (ifLocalVar88_g59687).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59689 = dot( temp_output_7_0_g59689 , ( (temp_output_7_0_g59689).yzx + 33.33 ) );
					float3 temp_output_12_0_g59689 = ( temp_output_7_0_g59689 + dotResult8_g59689 );
					float2 temp_output_597_26_g59686 = ( UV100_g59687 + frac( ( ( (temp_output_12_0_g59689).xx + (temp_output_12_0_g59689).yz ) * (temp_output_12_0_g59689).zy ) ) );
					float temp_output_66_0_g59687 = ( 1.0 - break55_g59687.y );
					float ifLocalVar60_g59687 = 0;
					if( temp_output_56_0_g59687 <= 0.0 )
					ifLocalVar60_g59687 = temp_output_66_0_g59687;
					else
					ifLocalVar60_g59687 = break55_g59687.y;
					float temp_output_597_28_g59686 = ifLocalVar60_g59687;
					float2 ifLocalVar89_g59687 = 0;
					if( temp_output_56_0_g59687 > 0.0 )
					ifLocalVar89_g59687 = temp_output_123_0_g59687;
					else if( temp_output_56_0_g59687 == 0.0 )
					ifLocalVar89_g59687 = temp_output_90_0_g59687;
					else if( temp_output_56_0_g59687 < 0.0 )
					ifLocalVar89_g59687 = temp_output_90_0_g59687;
					float3 temp_output_7_0_g59690 = frac( ( (ifLocalVar89_g59687).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59690 = dot( temp_output_7_0_g59690 , ( (temp_output_7_0_g59690).yzx + 33.33 ) );
					float3 temp_output_12_0_g59690 = ( temp_output_7_0_g59690 + dotResult8_g59690 );
					float2 temp_output_597_27_g59686 = ( UV100_g59687 + frac( ( ( (temp_output_12_0_g59690).xx + (temp_output_12_0_g59690).yz ) * (temp_output_12_0_g59690).zy ) ) );
					float temp_output_67_0_g59687 = ( 1.0 - break55_g59687.x );
					float ifLocalVar61_g59687 = 0;
					if( temp_output_56_0_g59687 <= 0.0 )
					ifLocalVar61_g59687 = temp_output_67_0_g59687;
					else
					ifLocalVar61_g59687 = break55_g59687.x;
					float temp_output_597_29_g59686 = ifLocalVar61_g59687;
					float4 Output_2D293_g59686 = ( ( tex2D( _Sampler82964_g5296, temp_output_597_0_g59686, DDX631_g59686, DDY632_g59686 ) * temp_output_597_30_g59686 ) + ( tex2D( _Sampler82964_g5296, temp_output_597_26_g59686, DDX631_g59686, DDY632_g59686 ) * temp_output_597_28_g59686 ) + ( tex2D( _Sampler82964_g5296, temp_output_597_27_g59686, DDX631_g59686, DDY632_g59686 ) * temp_output_597_29_g59686 ) );
					float4 break31_g59686 = Output_2D293_g59686;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g5296 = ( 1.0 - break31_g59686.r );
					#else
					float staticSwitch1004_g5296 = ( 1.0 - staticSwitch845_g5296 );
					#endif
					float temp_output_19_0_g59745 = staticSwitch1004_g5296;
					float2 temp_output_5_0_g59660 = UV0A2420_g5296;
					float2 UV633_g59660 = temp_output_5_0_g59660;
					float2 UV100_g59661 = UV633_g59660;
					float2 temp_output_51_0_g59661 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59661 * float2( 3.464,3.464 ) ) );
					float2 break55_g59661 = frac( temp_output_51_0_g59661 );
					float temp_output_56_0_g59661 = ( ( 1.0 - break55_g59661.x ) - break55_g59661.y );
					float2 temp_output_52_0_g59661 = floor( temp_output_51_0_g59661 );
					float2 temp_output_125_0_g59661 = ( temp_output_52_0_g59661 + float2( 1,1 ) );
					float2 ifLocalVar87_g59661 = 0;
					if( temp_output_56_0_g59661 > 0.0 )
					ifLocalVar87_g59661 = temp_output_52_0_g59661;
					else if( temp_output_56_0_g59661 == 0.0 )
					ifLocalVar87_g59661 = temp_output_125_0_g59661;
					else if( temp_output_56_0_g59661 < 0.0 )
					ifLocalVar87_g59661 = temp_output_125_0_g59661;
					float3 temp_output_7_0_g59662 = frac( ( (ifLocalVar87_g59661).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59662 = dot( temp_output_7_0_g59662 , ( (temp_output_7_0_g59662).yzx + 33.33 ) );
					float3 temp_output_12_0_g59662 = ( temp_output_7_0_g59662 + dotResult8_g59662 );
					float2 temp_output_597_0_g59660 = ( UV100_g59661 + frac( ( ( (temp_output_12_0_g59662).xx + (temp_output_12_0_g59662).yz ) * (temp_output_12_0_g59662).zy ) ) );
					float2 DDX631_g59660 = ddx( temp_output_5_0_g59660 );
					float2 DDY632_g59660 = ddy( temp_output_5_0_g59660 );
					float Input_Scale617_g59660 = 1.5;
					float temp_output_65_0_g59661 = ( 0.0 - temp_output_56_0_g59661 );
					float ifLocalVar59_g59661 = 0;
					if( temp_output_56_0_g59661 <= 0.0 )
					ifLocalVar59_g59661 = temp_output_65_0_g59661;
					else
					ifLocalVar59_g59661 = temp_output_56_0_g59661;
					float temp_output_597_30_g59660 = ifLocalVar59_g59661;
					float2 temp_output_90_0_g59661 = ( temp_output_52_0_g59661 + float2( 0,1 ) );
					float2 temp_output_123_0_g59661 = ( temp_output_52_0_g59661 + float2( 1,0 ) );
					float2 ifLocalVar88_g59661 = 0;
					if( temp_output_56_0_g59661 > 0.0 )
					ifLocalVar88_g59661 = temp_output_90_0_g59661;
					else if( temp_output_56_0_g59661 == 0.0 )
					ifLocalVar88_g59661 = temp_output_123_0_g59661;
					else if( temp_output_56_0_g59661 < 0.0 )
					ifLocalVar88_g59661 = temp_output_123_0_g59661;
					float3 temp_output_7_0_g59663 = frac( ( (ifLocalVar88_g59661).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59663 = dot( temp_output_7_0_g59663 , ( (temp_output_7_0_g59663).yzx + 33.33 ) );
					float3 temp_output_12_0_g59663 = ( temp_output_7_0_g59663 + dotResult8_g59663 );
					float2 temp_output_597_26_g59660 = ( UV100_g59661 + frac( ( ( (temp_output_12_0_g59663).xx + (temp_output_12_0_g59663).yz ) * (temp_output_12_0_g59663).zy ) ) );
					float temp_output_66_0_g59661 = ( 1.0 - break55_g59661.y );
					float ifLocalVar60_g59661 = 0;
					if( temp_output_56_0_g59661 <= 0.0 )
					ifLocalVar60_g59661 = temp_output_66_0_g59661;
					else
					ifLocalVar60_g59661 = break55_g59661.y;
					float temp_output_597_28_g59660 = ifLocalVar60_g59661;
					float2 ifLocalVar89_g59661 = 0;
					if( temp_output_56_0_g59661 > 0.0 )
					ifLocalVar89_g59661 = temp_output_123_0_g59661;
					else if( temp_output_56_0_g59661 == 0.0 )
					ifLocalVar89_g59661 = temp_output_90_0_g59661;
					else if( temp_output_56_0_g59661 < 0.0 )
					ifLocalVar89_g59661 = temp_output_90_0_g59661;
					float3 temp_output_7_0_g59664 = frac( ( (ifLocalVar89_g59661).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59664 = dot( temp_output_7_0_g59664 , ( (temp_output_7_0_g59664).yzx + 33.33 ) );
					float3 temp_output_12_0_g59664 = ( temp_output_7_0_g59664 + dotResult8_g59664 );
					float2 temp_output_597_27_g59660 = ( UV100_g59661 + frac( ( ( (temp_output_12_0_g59664).xx + (temp_output_12_0_g59664).yz ) * (temp_output_12_0_g59664).zy ) ) );
					float temp_output_67_0_g59661 = ( 1.0 - break55_g59661.x );
					float ifLocalVar61_g59661 = 0;
					if( temp_output_56_0_g59661 <= 0.0 )
					ifLocalVar61_g59661 = temp_output_67_0_g59661;
					else
					ifLocalVar61_g59661 = break55_g59661.x;
					float temp_output_597_29_g59660 = ifLocalVar61_g59661;
					float3 Output_2D_Normal641_g59660 = ( ( UnpackScaleNormal( tex2D( _Sampler82965_g5296, temp_output_597_0_g59660, DDX631_g59660, DDY632_g59660 ), Input_Scale617_g59660 ) * temp_output_597_30_g59660 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g5296, temp_output_597_26_g59660, DDX631_g59660, DDY632_g59660 ), Input_Scale617_g59660 ) * temp_output_597_28_g59660 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g5296, temp_output_597_27_g59660, DDX631_g59660, DDY632_g59660 ), Input_Scale617_g59660 ) * float3( 0,0,0 ) * temp_output_597_29_g59660 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g5296 = Output_2D_Normal641_g59660;
					#else
					float3 staticSwitch1003_g5296 = UnpackScaleNormal( tex2D( _BumpMap, UV0A2420_g5296 ), 1.5 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g5296 = staticSwitch1003_g5296;
					#else
					float3 staticSwitch980_g5296 = float3( 0, 0, 1 );
					#endif
					float3 normalizeResult2878_g5296 = normalize( staticSwitch980_g5296 );
					float3 Normal_Map700_g5296 = normalizeResult2878_g5296;
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal2504_g5296 = Normal_Map700_g5296;
					float3 worldNormal2504_g5296 = normalize( float3( dot( tanToWorld0, tanNormal2504_g5296 ), dot( tanToWorld1, tanNormal2504_g5296 ), dot( tanToWorld2, tanNormal2504_g5296 ) ) );
					float3 World_Normal2508_g5296 = worldNormal2504_g5296;
					float3 tanNormal2_g59745 = World_Normal2508_g5296;
					float3 worldNormal2_g59745 = float3( dot( tanToWorld0, tanNormal2_g59745 ), dot( tanToWorld1, tanNormal2_g59745 ), dot( tanToWorld2, tanNormal2_g59745 ) );
					float3 temp_output_3_0_g59745 = ddx( worldNormal2_g59745 );
					float dotResult5_g59745 = dot( temp_output_3_0_g59745 , temp_output_3_0_g59745 );
					float3 temp_output_4_0_g59745 = ddy( worldNormal2_g59745 );
					float dotResult6_g59745 = dot( temp_output_4_0_g59745 , temp_output_4_0_g59745 );
					#ifdef _USEGEOMETRICAA_ON
					float staticSwitch15_g59745 = min( temp_output_19_0_g59745, ( 1.0 - pow( saturate( max( dotResult5_g59745, dotResult6_g59745 ) ) , 0.25 ) ) );
					#else
					float staticSwitch15_g59745 = temp_output_19_0_g59745;
					#endif
					float SmoothnessAA1399_g5296 = staticSwitch15_g59745;
					float Smoothness1_g59751 = SmoothnessAA1399_g5296;
					float IOR2700_g5296 = _IOR;
					float IOR1_g59751 = IOR2700_g5296;
					float3 temp_cast_3 = (0.04).xxx;
					float3 lerpResult1473_g5296 = lerp( temp_cast_3 , oAlbedo6_g5296 , Metallic1239_g5296);
					float3 switchResult1501_g5296 = (((ase_vface>0)?(World_Normal2508_g5296):(-World_Normal2508_g5296)));
					float3 View_Direction2511_g5296 = ViewDirWS;
					float dotResult1476_g5296 = dot( switchResult1501_g5296 , View_Direction2511_g5296 );
					float3 lerpResult1480_g5296 = lerp( lerpResult1473_g5296 , float3( 1,1,1 ) , pow( ( 1.0 - saturate( dotResult1476_g5296 ) ) , 5.0 ));
					float3 Fresnel1560_g5296 = lerpResult1480_g5296;
					float3 Fresnel1_g59751 = Fresnel1560_g5296;
					float3 World_Position2505_g5296 = PositionWS;
					float3 WorldPos1_g59751 = World_Position2505_g5296;
					float3 WorldNormal1_g59751 = World_Normal2508_g5296;
					float3 ViewDir1_g59751 = View_Direction2511_g5296;
					float3 localIndirectSpecular1_g59751 = IndirectSpecular1_g59751( Color1_g59751 , Metallic1_g59751 , Smoothness1_g59751 , IOR1_g59751 , Fresnel1_g59751 , WorldPos1_g59751 , WorldNormal1_g59751 , ViewDir1_g59751 );
					float3 temp_output_2848_0_g5296 = localIndirectSpecular1_g59751;
					float White38_g5296 = 1.0;
					float4 temp_cast_4 = (White38_g5296).xxxx;
					float4 texCoord2426_g5296 = IN.ase_texcoord6;
					texCoord2426_g5296.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0B2361_g5296 = (texCoord2426_g5296).zw;
					float localBicubicPrepare2_g59567 = ( 0.0 );
					float2 Input_UV100_g59567 = UV0B2361_g5296;
					float2 UV2_g59567 = Input_UV100_g59567;
					float4 TexelSize2_g59567 = _Lightmap0_TexelSize;
					float2 UV02_g59567 = float2( 0,0 );
					float2 UV12_g59567 = float2( 0,0 );
					float2 UV22_g59567 = float2( 0,0 );
					float2 UV32_g59567 = float2( 0,0 );
					float W02_g59567 = 0;
					float W12_g59567 = 0;
					{
					{
					 UV2_g59567 = UV2_g59567 * TexelSize2_g59567.zw - 0.5;
					    float2 f = frac( UV2_g59567 );
					    UV2_g59567 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59567.x - 0.5, UV2_g59567.x + 1.5, UV2_g59567.y - 0.5, UV2_g59567.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59567.xyxy;
					    UV02_g59567 = off.xz;
					    UV12_g59567 = off.yz;
					    UV22_g59567 = off.xw;
					    UV32_g59567 = off.yw;
					    W02_g59567 = s.x / ( s.x + s.y );
					 W12_g59567 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59567 = lerp( tex2D( _Lightmap0, UV32_g59567 ) , tex2D( _Lightmap0, UV22_g59567 ) , W02_g59567);
					float4 lerpResult45_g59567 = lerp( tex2D( _Lightmap0, UV12_g59567 ) , tex2D( _Lightmap0, UV02_g59567 ) , W02_g59567);
					float4 lerpResult44_g59567 = lerp( lerpResult46_g59567 , lerpResult45_g59567 , W12_g59567);
					float4 Output_2D_Auto131_g59567 = lerpResult44_g59567;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g5296 = Output_2D_Auto131_g59567;
					#else
					float4 staticSwitch1092_g5296 = float4( tex2D( _Lightmap0, UV0B2361_g5296 ).rgb , 0.0 );
					#endif
					float4 Lightmap_0925_g5296 = staticSwitch1092_g5296;
					float localBicubicPrepare2_g59430 = ( 0.0 );
					float2 Input_UV100_g59430 = UV0B2361_g5296;
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
					float4 staticSwitch1088_g5296 = Output_2D_Auto131_g59430;
					#else
					float4 staticSwitch1088_g5296 = tex2D( _Lightmap1, UV0B2361_g5296 );
					#endif
					float4 Lightmap_1956_g5296 = staticSwitch1088_g5296;
					float Lightmap_Lerp_Value969_g5296 = _UdonLightmapLerp;
					float4 lerpResult442_g5296 = lerp( Lightmap_0925_g5296 , Lightmap_1956_g5296 , Lightmap_Lerp_Value969_g5296);
					float4 Lightmap_Lerp932_g5296 = lerpResult442_g5296;
					float3 appendResult139_g59780 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 Normal_Map318_g59780 = Normal_Map700_g5296;
					float dotResult121_g59780 = dot( appendResult139_g59780 , Normal_Map318_g59780 );
					float temp_output_2_0_g59782 = saturate( dotResult121_g59780 );
					float localStochasticTiling2_g59698 = ( 0.0 );
					float2 UV2_g59698 = UV0B2361_g5296;
					float4 TexelSize2_g59698 = _UdonRNMX0_TexelSize;
					float4 Offsets2_g59698 = float4( 0,0,0,0 );
					float2 Weights2_g59698 = float2( 0,0 );
					{
					UV2_g59698 = UV2_g59698 * TexelSize2_g59698.zw - 0.5;
					float2 f = frac( UV2_g59698 );
					UV2_g59698 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g59698.x - 0.5, UV2_g59698.x + 1.5, UV2_g59698.y - 0.5, UV2_g59698.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g59698 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59698.xyxy;
					Weights2_g59698 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g59697 = Offsets2_g59698;
					float4 Input_FetchOffsets197_g59699 = temp_output_1_34_g59697;
					float2 temp_output_1_54_g59697 = Weights2_g59698;
					float2 Input_FetchWeights200_g59699 = temp_output_1_54_g59697;
					float2 break187_g59699 = Input_FetchWeights200_g59699;
					float4 lerpResult181_g59699 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g59699).yw ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g59699).xw ) , break187_g59699.x);
					float4 lerpResult182_g59699 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g59699).yz ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g59699).xz ) , break187_g59699.x);
					float4 lerpResult176_g59699 = lerp( lerpResult181_g59699 , lerpResult182_g59699 , break187_g59699.y);
					float4 Output_Fetch2D_Auto202_g59699 = lerpResult176_g59699;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g5296 = Output_Fetch2D_Auto202_g59699;
					#else
					float4 staticSwitch1061_g5296 = tex2D( _UdonRNMX0, UV0B2361_g5296 );
					#endif
					float3 appendResult146_g59780 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59780 = dot( appendResult146_g59780 , Normal_Map318_g59780 );
					float temp_output_2_0_g59781 = saturate( dotResult122_g59780 );
					float4 Input_FetchOffsets197_g59700 = temp_output_1_34_g59697;
					float2 Input_FetchWeights200_g59700 = temp_output_1_54_g59697;
					float2 break187_g59700 = Input_FetchWeights200_g59700;
					float4 lerpResult181_g59700 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g59700).yw ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g59700).xw ) , break187_g59700.x);
					float4 lerpResult182_g59700 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g59700).yz ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g59700).xz ) , break187_g59700.x);
					float4 lerpResult176_g59700 = lerp( lerpResult181_g59700 , lerpResult182_g59700 , break187_g59700.y);
					float4 Output_Fetch2D_Auto202_g59700 = lerpResult176_g59700;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g5296 = Output_Fetch2D_Auto202_g59700;
					#else
					float4 staticSwitch1062_g5296 = tex2D( _UdonRNMY0, UV0B2361_g5296 );
					#endif
					float3 appendResult149_g59780 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59780 = dot( appendResult149_g59780 , Normal_Map318_g59780 );
					float temp_output_2_0_g59783 = saturate( dotResult120_g59780 );
					float4 Input_FetchOffsets197_g59701 = temp_output_1_34_g59697;
					float2 Input_FetchWeights200_g59701 = temp_output_1_54_g59697;
					float2 break187_g59701 = Input_FetchWeights200_g59701;
					float4 lerpResult181_g59701 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g59701).yw ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g59701).xw ) , break187_g59701.x);
					float4 lerpResult182_g59701 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g59701).yz ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g59701).xz ) , break187_g59701.x);
					float4 lerpResult176_g59701 = lerp( lerpResult181_g59701 , lerpResult182_g59701 , break187_g59701.y);
					float4 Output_Fetch2D_Auto202_g59701 = lerpResult176_g59701;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g5296 = Output_Fetch2D_Auto202_g59701;
					#else
					float4 staticSwitch1063_g5296 = tex2D( _UdonRNMZ0, UV0B2361_g5296 );
					#endif
					float4 temp_output_24_0_g59780 = ( ( ( ( temp_output_2_0_g59782 * temp_output_2_0_g59782 ) * staticSwitch1061_g5296 ) + ( ( temp_output_2_0_g59781 * temp_output_2_0_g59781 ) * staticSwitch1062_g5296 ) ) + ( ( temp_output_2_0_g59783 * temp_output_2_0_g59783 ) * staticSwitch1063_g5296 ) );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch372_g59780 = ( temp_output_24_0_g59780 * 1.5 );
					#else
					float4 staticSwitch372_g59780 = temp_output_24_0_g59780;
					#endif
					float4 RNM_0926_g5296 = staticSwitch372_g59780;
					float3 appendResult139_g59776 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 Normal_Map318_g59776 = Normal_Map700_g5296;
					float dotResult121_g59776 = dot( appendResult139_g59776 , Normal_Map318_g59776 );
					float temp_output_2_0_g59778 = saturate( dotResult121_g59776 );
					float localStochasticTiling2_g59425 = ( 0.0 );
					float2 UV2_g59425 = UV0B2361_g5296;
					float4 TexelSize2_g59425 = _UdonRNMX1_TexelSize;
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
					float4 lerpResult181_g59426 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g59426).yw ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g59426).xw ) , break187_g59426.x);
					float4 lerpResult182_g59426 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g59426).yz ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g59426).xz ) , break187_g59426.x);
					float4 lerpResult176_g59426 = lerp( lerpResult181_g59426 , lerpResult182_g59426 , break187_g59426.y);
					float4 Output_Fetch2D_Auto202_g59426 = lerpResult176_g59426;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g5296 = Output_Fetch2D_Auto202_g59426;
					#else
					float4 staticSwitch1087_g5296 = tex2D( _UdonRNMX1, UV0B2361_g5296 );
					#endif
					float3 appendResult146_g59776 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59776 = dot( appendResult146_g59776 , Normal_Map318_g59776 );
					float temp_output_2_0_g59777 = saturate( dotResult122_g59776 );
					float4 Input_FetchOffsets197_g59427 = temp_output_1_34_g59424;
					float2 Input_FetchWeights200_g59427 = temp_output_1_54_g59424;
					float2 break187_g59427 = Input_FetchWeights200_g59427;
					float4 lerpResult181_g59427 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g59427).yw ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g59427).xw ) , break187_g59427.x);
					float4 lerpResult182_g59427 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g59427).yz ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g59427).xz ) , break187_g59427.x);
					float4 lerpResult176_g59427 = lerp( lerpResult181_g59427 , lerpResult182_g59427 , break187_g59427.y);
					float4 Output_Fetch2D_Auto202_g59427 = lerpResult176_g59427;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g5296 = Output_Fetch2D_Auto202_g59427;
					#else
					float4 staticSwitch1083_g5296 = tex2D( _UdonRNMY1, UV0B2361_g5296 );
					#endif
					float3 appendResult149_g59776 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59776 = dot( appendResult149_g59776 , Normal_Map318_g59776 );
					float temp_output_2_0_g59779 = saturate( dotResult120_g59776 );
					float4 Input_FetchOffsets197_g59428 = temp_output_1_34_g59424;
					float2 Input_FetchWeights200_g59428 = temp_output_1_54_g59424;
					float2 break187_g59428 = Input_FetchWeights200_g59428;
					float4 lerpResult181_g59428 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g59428).yw ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g59428).xw ) , break187_g59428.x);
					float4 lerpResult182_g59428 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g59428).yz ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g59428).xz ) , break187_g59428.x);
					float4 lerpResult176_g59428 = lerp( lerpResult181_g59428 , lerpResult182_g59428 , break187_g59428.y);
					float4 Output_Fetch2D_Auto202_g59428 = lerpResult176_g59428;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g5296 = Output_Fetch2D_Auto202_g59428;
					#else
					float4 staticSwitch1084_g5296 = tex2D( _UdonRNMZ1, UV0B2361_g5296 );
					#endif
					float4 temp_output_24_0_g59776 = ( ( ( ( temp_output_2_0_g59778 * temp_output_2_0_g59778 ) * staticSwitch1087_g5296 ) + ( ( temp_output_2_0_g59777 * temp_output_2_0_g59777 ) * staticSwitch1083_g5296 ) ) + ( ( temp_output_2_0_g59779 * temp_output_2_0_g59779 ) * staticSwitch1084_g5296 ) );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch372_g59776 = ( temp_output_24_0_g59776 * 1.5 );
					#else
					float4 staticSwitch372_g59776 = temp_output_24_0_g59776;
					#endif
					float4 RNM_11081_g5296 = staticSwitch372_g59776;
					float4 lerpResult953_g5296 = lerp( RNM_0926_g5296 , RNM_11081_g5296 , Lightmap_Lerp_Value969_g5296);
					float4 RNM_Lerp950_g5296 = lerpResult953_g5296;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g5296 = temp_cast_4;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g5296 = Lightmap_0925_g5296;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g5296 = Lightmap_Lerp932_g5296;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g5296 = RNM_0926_g5296;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g5296 = RNM_Lerp950_g5296;
					#else
					float4 staticSwitch1014_g5296 = temp_cast_4;
					#endif
					float3 Lightmap46_g5296 = (staticSwitch1014_g5296).rgb;
					float3 temp_output_6_0_g59800 = Lightmap46_g5296;
					float grayscale4_g59800 = Luminance( temp_output_6_0_g59800 );
					float smoothstepResult2_g59800 = smoothstep( 0.0 , 0.02 , grayscale4_g59800);
					#ifdef _USELIGHTMAPPEDREFLECTIONS_ON
					float3 staticSwitch1469_g5296 = ( temp_output_2848_0_g5296 * smoothstepResult2_g59800 );
					#else
					float3 staticSwitch1469_g5296 = temp_output_2848_0_g5296;
					#endif
					float3 Indirect_Specular1419_g5296 = staticSwitch1469_g5296;
					float3 Color97_g59826 = oAlbedo6_g5296;
					float Metallic97_g59826 = Metallic1239_g5296;
					float Smoothness2838_g5296 = staticSwitch1004_g5296;
					float Smoothness97_g59826 = Smoothness2838_g5296;
					float SmoothnessAA97_g59826 = SmoothnessAA1399_g5296;
					float IOR97_g59826 = IOR2700_g5296;
					float3 Fresnel97_g59826 = Fresnel1560_g5296;
					float3 Lightmap97_g59826 = Lightmap46_g5296;
					float3 WorldPos97_g59826 = World_Position2505_g5296;
					float3 WorldNormal97_g59826 = World_Normal2508_g5296;
					float3 ViewDir97_g59826 = View_Direction2511_g5296;
					float3 localDirectSpecular97_g59826 = DirectSpecular( Color97_g59826 , Metallic97_g59826 , Smoothness97_g59826 , SmoothnessAA97_g59826 , IOR97_g59826 , Fresnel97_g59826 , Lightmap97_g59826 , WorldPos97_g59826 , WorldNormal97_g59826 , ViewDir97_g59826 );
					float3 Direct_Specular2560_g5296 = localDirectSpecular97_g59826;
					float3 aAlbedo1466_g5296 = ( temp_output_2532_0_g5296 * ( 1.0 - Metallic1239_g5296 ) );
					float3 temp_output_1252_0_g5296 = ( aAlbedo1466_g5296 * Lightmap46_g5296 );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch1_g59830 = float4( ( temp_output_1252_0_g5296 + Emission86_g5296 + Indirect_Specular1419_g5296 ) , 0.0 );
					#else
					float4 staticSwitch1_g59830 = float4( ( Emission86_g5296 + Indirect_Specular1419_g5296 + Direct_Specular2560_g5296 + temp_output_1252_0_g5296 ) , 0.0 );
					#endif
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1181_g5296 = float4( Lightmap46_g5296 , 0.0 );
					#else
					float4 staticSwitch1181_g5296 = staticSwitch1_g59830;
					#endif
					float4 Color357_g59828 = staticSwitch1181_g5296;
					#ifdef _3DLUT
					float4 staticSwitch194_g59828 = tex3D( _3DLut, ( ( log10( ( ( (Color357_g59828).xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 ) );
					#else
					float4 staticSwitch194_g59828 = Color357_g59828;
					#endif
					float4 LUT51_g59828 = staticSwitch194_g59828;
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch359_g59828 = LUT51_g59828;
					#else
					float4 staticSwitch359_g59828 = Color357_g59828;
					#endif
					

					o.Albedo = staticSwitch1180_g5296;
					o.Normal = half3( 0, 0, 1 );

					half3 Specular = temp_cast_1;
					half Metallic = 0;
					half Smoothness = 1.0;
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

					o.Emission = staticSwitch359_g59828.xyz;
					o.Alpha = 1;
					half AlphaClipThreshold = 0.5;
					half AlphaClipThresholdShadow = 0.5;
					half3 BakedGI = 0;
					half3 Transmission = 1;
					half3 Translucency = 1;

					#if defined( ASE_DEPTH_WRITE_ON )
						IN.pos.z = IN.pos.z;
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
						outputDepth = IN.pos.z;
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
				#define _SPECULAR_SETUP 1
				#define ASE_VERSION 19909

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
				uniform float _CATEGORYSPACESURFACEOPTIONS;
				uniform float _UdonSpecularLightCount;
				uniform sampler3D _3DLut;
				uniform float _CATEGORYSNOW;
				uniform float _CATEGORYSPACESNOW;
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
						IN.pos.z = IN.pos.z;
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
						outputDepth = IN.pos.z;
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
Version=19909
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3034;192,-1200;Inherit;False;Meenphie;0;;5296;b3ba55a08dd6b49c7be16c6f35cf2033;6,1008,0,2632,0,2635,0,2619,0,2636,0,2670,0;0;5;FLOAT3;625;FLOAT4;624;FLOAT;156;FLOAT;427;FLOAT;1024
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3038;224,-976;Inherit;False;Snow Particles;47;;59831;5e2d84d094b538e50a87a98a44c75956;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3039;-30.5,-1068;Inherit;False;Constant;_Float5;Float 5;4;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2889;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;True;1;LightMode=ForwardAdd;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2890;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2891;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2892;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2893;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2894;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ScenePickingPass;0;7;ScenePickingPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=Picking;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2887;480,-1440;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;True;True;0;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;True;True;1;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;0;False;;True;3;False;;True;False;0;False;;0;False;;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2888;512,-1200;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;Meenphie/Standard/Winter/Snow;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardBase;0;1;ForwardBase;17;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;True;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;0;False;;True;0;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;True;True;0;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;44;Category;0;0;  Instanced Terrain Normals;1;0;Workflow;0;639095264227823430;Surface;0;0;  Blend;0;0;  Dither Shadows;1;0;Two Sided;1;638915389515035230;Alpha Clipping;0;0;  Use Shadow Threshold;0;0;Deferred Pass;0;638915388739756900;Normal Space;0;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;1;638922400255637350;Receive Shadows;0;638922400261099240;Receive Specular;0;638915388784334560;Receive Reflections;1;638915388803555030;GPU Instancing;1;638915411619689990;LOD CrossFade;1;0;Built-in Fog;1;0;Ambient Light;1;0;Meta Pass;0;639095263521573180;Add Pass;0;639095263518086110;Override Baked GI;0;638915390973737640;Write Depth;0;638915391054792770;Extra Pre Pass;0;639095262833915570;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;0;Vertex Position;1;0;0;8;False;True;False;False;False;True;False;False;False;;False;0
WireConnection;2888;0;3034;625
WireConnection;2888;3;3038;0
WireConnection;2888;5;3039;0
WireConnection;2888;2;3034;624
ASEEND*/
//CHKSM=5DA1E0D253CD447DF0D4541FCD61AA4FD74BB890