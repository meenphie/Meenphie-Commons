// Made with Amplify Shader Editor v1.9.9.9
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
		[NoScaleOffset][SingleLineTexture] _UdonRNMX0( "RNMX 0", 2D ) = "black" {}
		[NoScaleOffset][SingleLineTexture] _UdonRNMY0( "RNMY 0", 2D ) = "black" {}
		[NoScaleOffset][SingleLineTexture] _UdonRNMZ0( "RNMZ 0", 2D ) = "black" {}
		[NoScaleOffset][SingleLineTexture] _UdonRNMX1( "RNMX 1", 2D ) = "black" {}
		[NoScaleOffset][SingleLineTexture] _UdonRNMY1( "RNMY 1", 2D ) = "black" {}
		[NoScaleOffset][SingleLineTexture] _UdonRNMZ1( "RNMZ 1", 2D ) = "black" {}
		_UdonLightmapLerp( "Lightmap Lerp", Range( 0, 1 ) ) = 0
		[Toggle( _USEBICUBICFILTERING_ON )] _UseBicubicFiltering( "Use Bicubic Filtering", Float ) = 1
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACELIGHTMAPPING( "CATEGORY SPACE LIGHTMAPPING", Float ) = 0
		[Meenphie_DrawerCategory(STOCHASTIC,true,0,0)] _CATEGORYSTOCHASTIC( "CATEGORY STOCHASTIC", Float ) = 0
		[Toggle( _STOCHASTICENABLED_ON )] _StochasticEnabled( "Stochastic Enabled", Float ) = 0
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESTOCHASTIC( "CATEGORY SPACE STOCHASTIC", Float ) = 0
		[Meenphie_DrawerCategory(COLOR GRADING,true,0,0)] _CATEGORYCOLORGRADING( "CATEGORY COLOR GRADING", Float ) = 0
		[NoScaleOffset][SingleLineTexture] _LUT( "LUT", 3D ) = "black" {}
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACECOLORGRADING( "CATEGORY SPACE COLOR GRADING", Float ) = 0
		[Meenphie_DrawerCategory(SPECIAL EFFECTS,true,0,0)] _CATEGORYSPECIALEFFECTS( "CATEGORY SPECIAL EFFECTS", Float ) = 0
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESPECIALEFFECTS( "CATEGORY SPACE SPECIAL EFFECTS", Float ) = 0
		[Toggle( _DIRECTSPECULAR_ON )] _DirectSpecular( "Direct Speculars", Float ) = 1
		[Toggle( _INDIRECTSPECULARS_ON )] _IndirectSpeculars( "Indirect Speculars", Float ) = 1
		[HideInInspector] GenKey__GlossinessMap( "Assign keyword _GLOSSINESSMAP", Float ) = 1.0
		[HideInInspector] GenKey__MetallicMap( "Assign keyword _METALLICMAP", Float ) = 1.0
		[HideInInspector] GenKey__MainTex( "Assign keyword _MAINTEX", Float ) = 1.0
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0


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
				#define ASE_LIGHTING_SIMPLE 1
				#pragma multi_compile_fog
				#define ASE_FOG
				#define _SPECULARHIGHLIGHTS_OFF
				#define _GLOSSYREFLECTIONS_OFF
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

				#include "Packages/com.meenphie.commons/Commons/Shaders/Custom Expressions/IndirectSpecular.cginc"
				#include "UnityStandardUtils.cginc"
				#include "Packages/com.meenphie.commons/Commons/Shaders/Custom Expressions/DirectSpecular.cginc"
				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#define ASE_NEEDS_WORLD_TANGENT
				#define ASE_NEEDS_FRAG_WORLD_TANGENT
				#define ASE_NEEDS_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_BITANGENT
				#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
				#define ASE_NEEDS_WORLD_POSITION
				#define ASE_NEEDS_FRAG_WORLD_POSITION
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
				#pragma shader_feature _LIGHTMAPDEBUG
				#pragma shader_feature_local _STOCHASTICENABLED_ON
				#pragma shader_feature_local _MAINTEX
				#pragma shader_feature_local _INDIRECTSPECULARS_ON
				#pragma shader_feature_local _METALLICMAP
				#pragma shader_feature_local _USEGEOMETRICAA_ON
				#pragma shader_feature_local _GLOSSINESSMAP
				#pragma shader_feature_local _BUMPMAP
				#pragma shader_feature_local _LIGHTMAPMODE_DISABLED _LIGHTMAPMODE_SIMPLE _LIGHTMAPMODE_SIMPLELERP _LIGHTMAPMODE_RNM _LIGHTMAPMODE_RNMLERP
				#pragma shader_feature_local _USEBICUBICFILTERING_ON
				#pragma shader_feature_local _DIRECTSPECULAR_ON


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
				uniform sampler3D _LUT;
				uniform half4 _Color;
				uniform sampler2D _MainTex;
				sampler2D _Sampler82966_g63714;
				uniform float3 _EmissionColor;
				uniform sampler2D _EmissionMap;
				sampler2D _Sampler82968_g63714;
				uniform float _EmissionIntensity;
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				sampler2D _Sampler82967_g63714;
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				sampler2D _Sampler82964_g63714;
				uniform sampler2D _BumpMap;
				sampler2D _Sampler82965_g63714;
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

					float2 texCoord2357_g63714 = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0A2420_g63714 = texCoord2357_g63714;
					#ifdef _MAINTEX
					float4 staticSwitch1549_g63714 = tex2D( _MainTex, UV0A2420_g63714 );
					#else
					float4 staticSwitch1549_g63714 = _Color;
					#endif
					float2 temp_output_5_0_g63729 = UV0A2420_g63714;
					float2 UV633_g63729 = temp_output_5_0_g63729;
					float2 UV100_g63730 = UV633_g63729;
					float2 temp_output_51_0_g63730 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g63730 * float2( 3.464,3.464 ) ) );
					float2 break55_g63730 = frac( temp_output_51_0_g63730 );
					float temp_output_56_0_g63730 = ( ( 1.0 - break55_g63730.x ) - break55_g63730.y );
					float2 temp_output_52_0_g63730 = floor( temp_output_51_0_g63730 );
					float2 temp_output_125_0_g63730 = ( temp_output_52_0_g63730 + float2( 1,1 ) );
					float2 ifLocalVar87_g63730 = 0;
					if( temp_output_56_0_g63730 > 0.0 )
					ifLocalVar87_g63730 = temp_output_52_0_g63730;
					else if( temp_output_56_0_g63730 == 0.0 )
					ifLocalVar87_g63730 = temp_output_125_0_g63730;
					else if( temp_output_56_0_g63730 < 0.0 )
					ifLocalVar87_g63730 = temp_output_125_0_g63730;
					float3 temp_output_7_0_g63731 = frac( ( (ifLocalVar87_g63730).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63731 = dot( temp_output_7_0_g63731 , ( (temp_output_7_0_g63731).yzx + 33.33 ) );
					float3 temp_output_12_0_g63731 = ( temp_output_7_0_g63731 + dotResult8_g63731 );
					float2 temp_output_597_0_g63729 = ( UV100_g63730 + frac( ( ( (temp_output_12_0_g63731).xx + (temp_output_12_0_g63731).yz ) * (temp_output_12_0_g63731).zy ) ) );
					float2 DDX631_g63729 = ddx( temp_output_5_0_g63729 );
					float2 DDY632_g63729 = ddy( temp_output_5_0_g63729 );
					float temp_output_65_0_g63730 = ( 0.0 - temp_output_56_0_g63730 );
					float ifLocalVar59_g63730 = 0;
					if( temp_output_56_0_g63730 <= 0.0 )
					ifLocalVar59_g63730 = temp_output_65_0_g63730;
					else
					ifLocalVar59_g63730 = temp_output_56_0_g63730;
					float temp_output_597_30_g63729 = ifLocalVar59_g63730;
					float2 temp_output_90_0_g63730 = ( temp_output_52_0_g63730 + float2( 0,1 ) );
					float2 temp_output_123_0_g63730 = ( temp_output_52_0_g63730 + float2( 1,0 ) );
					float2 ifLocalVar88_g63730 = 0;
					if( temp_output_56_0_g63730 > 0.0 )
					ifLocalVar88_g63730 = temp_output_90_0_g63730;
					else if( temp_output_56_0_g63730 == 0.0 )
					ifLocalVar88_g63730 = temp_output_123_0_g63730;
					else if( temp_output_56_0_g63730 < 0.0 )
					ifLocalVar88_g63730 = temp_output_123_0_g63730;
					float3 temp_output_7_0_g63732 = frac( ( (ifLocalVar88_g63730).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63732 = dot( temp_output_7_0_g63732 , ( (temp_output_7_0_g63732).yzx + 33.33 ) );
					float3 temp_output_12_0_g63732 = ( temp_output_7_0_g63732 + dotResult8_g63732 );
					float2 temp_output_597_26_g63729 = ( UV100_g63730 + frac( ( ( (temp_output_12_0_g63732).xx + (temp_output_12_0_g63732).yz ) * (temp_output_12_0_g63732).zy ) ) );
					float temp_output_66_0_g63730 = ( 1.0 - break55_g63730.y );
					float ifLocalVar60_g63730 = 0;
					if( temp_output_56_0_g63730 <= 0.0 )
					ifLocalVar60_g63730 = temp_output_66_0_g63730;
					else
					ifLocalVar60_g63730 = break55_g63730.y;
					float temp_output_597_28_g63729 = ifLocalVar60_g63730;
					float2 ifLocalVar89_g63730 = 0;
					if( temp_output_56_0_g63730 > 0.0 )
					ifLocalVar89_g63730 = temp_output_123_0_g63730;
					else if( temp_output_56_0_g63730 == 0.0 )
					ifLocalVar89_g63730 = temp_output_90_0_g63730;
					else if( temp_output_56_0_g63730 < 0.0 )
					ifLocalVar89_g63730 = temp_output_90_0_g63730;
					float3 temp_output_7_0_g63733 = frac( ( (ifLocalVar89_g63730).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63733 = dot( temp_output_7_0_g63733 , ( (temp_output_7_0_g63733).yzx + 33.33 ) );
					float3 temp_output_12_0_g63733 = ( temp_output_7_0_g63733 + dotResult8_g63733 );
					float2 temp_output_597_27_g63729 = ( UV100_g63730 + frac( ( ( (temp_output_12_0_g63733).xx + (temp_output_12_0_g63733).yz ) * (temp_output_12_0_g63733).zy ) ) );
					float temp_output_67_0_g63730 = ( 1.0 - break55_g63730.x );
					float ifLocalVar61_g63730 = 0;
					if( temp_output_56_0_g63730 <= 0.0 )
					ifLocalVar61_g63730 = temp_output_67_0_g63730;
					else
					ifLocalVar61_g63730 = break55_g63730.x;
					float temp_output_597_29_g63729 = ifLocalVar61_g63730;
					float4 Output_2D293_g63729 = ( ( tex2D( _Sampler82966_g63714, temp_output_597_0_g63729, DDX631_g63729, DDY632_g63729 ) * temp_output_597_30_g63729 ) + ( tex2D( _Sampler82966_g63714, temp_output_597_26_g63729, DDX631_g63729, DDY632_g63729 ) * temp_output_597_28_g63729 ) + ( tex2D( _Sampler82966_g63714, temp_output_597_27_g63729, DDX631_g63729, DDY632_g63729 ) * temp_output_597_29_g63729 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g63714 = Output_2D293_g63729;
					#else
					float4 staticSwitch1001_g63714 = staticSwitch1549_g63714;
					#endif
					float3 temp_output_2532_0_g63714 = (staticSwitch1001_g63714).rgb;
					float3 oAlbedo6_g63714 = temp_output_2532_0_g63714;
					float Black1185_g63714 = 0.0;
					float3 temp_cast_0 = (Black1185_g63714).xxx;
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch1180_g63714 = temp_cast_0;
					#else
					float3 staticSwitch1180_g63714 = oAlbedo6_g63714;
					#endif
					
					float2 temp_output_5_0_g63739 = UV0A2420_g63714;
					float2 UV633_g63739 = temp_output_5_0_g63739;
					float2 UV100_g63740 = UV633_g63739;
					float2 temp_output_51_0_g63740 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g63740 * float2( 3.464,3.464 ) ) );
					float2 break55_g63740 = frac( temp_output_51_0_g63740 );
					float temp_output_56_0_g63740 = ( ( 1.0 - break55_g63740.x ) - break55_g63740.y );
					float2 temp_output_52_0_g63740 = floor( temp_output_51_0_g63740 );
					float2 temp_output_125_0_g63740 = ( temp_output_52_0_g63740 + float2( 1,1 ) );
					float2 ifLocalVar87_g63740 = 0;
					if( temp_output_56_0_g63740 > 0.0 )
					ifLocalVar87_g63740 = temp_output_52_0_g63740;
					else if( temp_output_56_0_g63740 == 0.0 )
					ifLocalVar87_g63740 = temp_output_125_0_g63740;
					else if( temp_output_56_0_g63740 < 0.0 )
					ifLocalVar87_g63740 = temp_output_125_0_g63740;
					float3 temp_output_7_0_g63741 = frac( ( (ifLocalVar87_g63740).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63741 = dot( temp_output_7_0_g63741 , ( (temp_output_7_0_g63741).yzx + 33.33 ) );
					float3 temp_output_12_0_g63741 = ( temp_output_7_0_g63741 + dotResult8_g63741 );
					float2 temp_output_597_0_g63739 = ( UV100_g63740 + frac( ( ( (temp_output_12_0_g63741).xx + (temp_output_12_0_g63741).yz ) * (temp_output_12_0_g63741).zy ) ) );
					float2 DDX631_g63739 = ddx( temp_output_5_0_g63739 );
					float2 DDY632_g63739 = ddy( temp_output_5_0_g63739 );
					float temp_output_65_0_g63740 = ( 0.0 - temp_output_56_0_g63740 );
					float ifLocalVar59_g63740 = 0;
					if( temp_output_56_0_g63740 <= 0.0 )
					ifLocalVar59_g63740 = temp_output_65_0_g63740;
					else
					ifLocalVar59_g63740 = temp_output_56_0_g63740;
					float temp_output_597_30_g63739 = ifLocalVar59_g63740;
					float2 temp_output_90_0_g63740 = ( temp_output_52_0_g63740 + float2( 0,1 ) );
					float2 temp_output_123_0_g63740 = ( temp_output_52_0_g63740 + float2( 1,0 ) );
					float2 ifLocalVar88_g63740 = 0;
					if( temp_output_56_0_g63740 > 0.0 )
					ifLocalVar88_g63740 = temp_output_90_0_g63740;
					else if( temp_output_56_0_g63740 == 0.0 )
					ifLocalVar88_g63740 = temp_output_123_0_g63740;
					else if( temp_output_56_0_g63740 < 0.0 )
					ifLocalVar88_g63740 = temp_output_123_0_g63740;
					float3 temp_output_7_0_g63742 = frac( ( (ifLocalVar88_g63740).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63742 = dot( temp_output_7_0_g63742 , ( (temp_output_7_0_g63742).yzx + 33.33 ) );
					float3 temp_output_12_0_g63742 = ( temp_output_7_0_g63742 + dotResult8_g63742 );
					float2 temp_output_597_26_g63739 = ( UV100_g63740 + frac( ( ( (temp_output_12_0_g63742).xx + (temp_output_12_0_g63742).yz ) * (temp_output_12_0_g63742).zy ) ) );
					float temp_output_66_0_g63740 = ( 1.0 - break55_g63740.y );
					float ifLocalVar60_g63740 = 0;
					if( temp_output_56_0_g63740 <= 0.0 )
					ifLocalVar60_g63740 = temp_output_66_0_g63740;
					else
					ifLocalVar60_g63740 = break55_g63740.y;
					float temp_output_597_28_g63739 = ifLocalVar60_g63740;
					float2 ifLocalVar89_g63740 = 0;
					if( temp_output_56_0_g63740 > 0.0 )
					ifLocalVar89_g63740 = temp_output_123_0_g63740;
					else if( temp_output_56_0_g63740 == 0.0 )
					ifLocalVar89_g63740 = temp_output_90_0_g63740;
					else if( temp_output_56_0_g63740 < 0.0 )
					ifLocalVar89_g63740 = temp_output_90_0_g63740;
					float3 temp_output_7_0_g63743 = frac( ( (ifLocalVar89_g63740).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63743 = dot( temp_output_7_0_g63743 , ( (temp_output_7_0_g63743).yzx + 33.33 ) );
					float3 temp_output_12_0_g63743 = ( temp_output_7_0_g63743 + dotResult8_g63743 );
					float2 temp_output_597_27_g63739 = ( UV100_g63740 + frac( ( ( (temp_output_12_0_g63743).xx + (temp_output_12_0_g63743).yz ) * (temp_output_12_0_g63743).zy ) ) );
					float temp_output_67_0_g63740 = ( 1.0 - break55_g63740.x );
					float ifLocalVar61_g63740 = 0;
					if( temp_output_56_0_g63740 <= 0.0 )
					ifLocalVar61_g63740 = temp_output_67_0_g63740;
					else
					ifLocalVar61_g63740 = break55_g63740.x;
					float temp_output_597_29_g63739 = ifLocalVar61_g63740;
					float4 Output_2D293_g63739 = ( ( tex2D( _Sampler82968_g63714, temp_output_597_0_g63739, DDX631_g63739, DDY632_g63739 ) * temp_output_597_30_g63739 ) + ( tex2D( _Sampler82968_g63714, temp_output_597_26_g63739, DDX631_g63739, DDY632_g63739 ) * temp_output_597_28_g63739 ) + ( tex2D( _Sampler82968_g63714, temp_output_597_27_g63739, DDX631_g63739, DDY632_g63739 ) * temp_output_597_29_g63739 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g63714 = Output_2D293_g63739;
					#else
					float4 staticSwitch1006_g63714 = tex2D( _EmissionMap, UV0A2420_g63714 );
					#endif
					float3 temp_output_2531_0_g63714 = (( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g63714 * _EmissionIntensity )).rgb;
					float3 Emission86_g63714 = temp_output_2531_0_g63714;
					float3 temp_cast_2 = (Black1185_g63714).xxx;
					float3 Color1_g63768 = oAlbedo6_g63714;
					#ifdef _METALLICMAP
					float staticSwitch846_g63714 = tex2D( _MetallicMap, UV0A2420_g63714 ).r;
					#else
					float staticSwitch846_g63714 = _Metallic;
					#endif
					float2 temp_output_5_0_g63749 = UV0A2420_g63714;
					float2 UV633_g63749 = temp_output_5_0_g63749;
					float2 UV100_g63750 = UV633_g63749;
					float2 temp_output_51_0_g63750 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g63750 * float2( 3.464,3.464 ) ) );
					float2 break55_g63750 = frac( temp_output_51_0_g63750 );
					float temp_output_56_0_g63750 = ( ( 1.0 - break55_g63750.x ) - break55_g63750.y );
					float2 temp_output_52_0_g63750 = floor( temp_output_51_0_g63750 );
					float2 temp_output_125_0_g63750 = ( temp_output_52_0_g63750 + float2( 1,1 ) );
					float2 ifLocalVar87_g63750 = 0;
					if( temp_output_56_0_g63750 > 0.0 )
					ifLocalVar87_g63750 = temp_output_52_0_g63750;
					else if( temp_output_56_0_g63750 == 0.0 )
					ifLocalVar87_g63750 = temp_output_125_0_g63750;
					else if( temp_output_56_0_g63750 < 0.0 )
					ifLocalVar87_g63750 = temp_output_125_0_g63750;
					float3 temp_output_7_0_g63751 = frac( ( (ifLocalVar87_g63750).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63751 = dot( temp_output_7_0_g63751 , ( (temp_output_7_0_g63751).yzx + 33.33 ) );
					float3 temp_output_12_0_g63751 = ( temp_output_7_0_g63751 + dotResult8_g63751 );
					float2 temp_output_597_0_g63749 = ( UV100_g63750 + frac( ( ( (temp_output_12_0_g63751).xx + (temp_output_12_0_g63751).yz ) * (temp_output_12_0_g63751).zy ) ) );
					float2 DDX631_g63749 = ddx( temp_output_5_0_g63749 );
					float2 DDY632_g63749 = ddy( temp_output_5_0_g63749 );
					float temp_output_65_0_g63750 = ( 0.0 - temp_output_56_0_g63750 );
					float ifLocalVar59_g63750 = 0;
					if( temp_output_56_0_g63750 <= 0.0 )
					ifLocalVar59_g63750 = temp_output_65_0_g63750;
					else
					ifLocalVar59_g63750 = temp_output_56_0_g63750;
					float temp_output_597_30_g63749 = ifLocalVar59_g63750;
					float2 temp_output_90_0_g63750 = ( temp_output_52_0_g63750 + float2( 0,1 ) );
					float2 temp_output_123_0_g63750 = ( temp_output_52_0_g63750 + float2( 1,0 ) );
					float2 ifLocalVar88_g63750 = 0;
					if( temp_output_56_0_g63750 > 0.0 )
					ifLocalVar88_g63750 = temp_output_90_0_g63750;
					else if( temp_output_56_0_g63750 == 0.0 )
					ifLocalVar88_g63750 = temp_output_123_0_g63750;
					else if( temp_output_56_0_g63750 < 0.0 )
					ifLocalVar88_g63750 = temp_output_123_0_g63750;
					float3 temp_output_7_0_g63752 = frac( ( (ifLocalVar88_g63750).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63752 = dot( temp_output_7_0_g63752 , ( (temp_output_7_0_g63752).yzx + 33.33 ) );
					float3 temp_output_12_0_g63752 = ( temp_output_7_0_g63752 + dotResult8_g63752 );
					float2 temp_output_597_26_g63749 = ( UV100_g63750 + frac( ( ( (temp_output_12_0_g63752).xx + (temp_output_12_0_g63752).yz ) * (temp_output_12_0_g63752).zy ) ) );
					float temp_output_66_0_g63750 = ( 1.0 - break55_g63750.y );
					float ifLocalVar60_g63750 = 0;
					if( temp_output_56_0_g63750 <= 0.0 )
					ifLocalVar60_g63750 = temp_output_66_0_g63750;
					else
					ifLocalVar60_g63750 = break55_g63750.y;
					float temp_output_597_28_g63749 = ifLocalVar60_g63750;
					float2 ifLocalVar89_g63750 = 0;
					if( temp_output_56_0_g63750 > 0.0 )
					ifLocalVar89_g63750 = temp_output_123_0_g63750;
					else if( temp_output_56_0_g63750 == 0.0 )
					ifLocalVar89_g63750 = temp_output_90_0_g63750;
					else if( temp_output_56_0_g63750 < 0.0 )
					ifLocalVar89_g63750 = temp_output_90_0_g63750;
					float3 temp_output_7_0_g63753 = frac( ( (ifLocalVar89_g63750).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63753 = dot( temp_output_7_0_g63753 , ( (temp_output_7_0_g63753).yzx + 33.33 ) );
					float3 temp_output_12_0_g63753 = ( temp_output_7_0_g63753 + dotResult8_g63753 );
					float2 temp_output_597_27_g63749 = ( UV100_g63750 + frac( ( ( (temp_output_12_0_g63753).xx + (temp_output_12_0_g63753).yz ) * (temp_output_12_0_g63753).zy ) ) );
					float temp_output_67_0_g63750 = ( 1.0 - break55_g63750.x );
					float ifLocalVar61_g63750 = 0;
					if( temp_output_56_0_g63750 <= 0.0 )
					ifLocalVar61_g63750 = temp_output_67_0_g63750;
					else
					ifLocalVar61_g63750 = break55_g63750.x;
					float temp_output_597_29_g63749 = ifLocalVar61_g63750;
					float4 Output_2D293_g63749 = ( ( tex2D( _Sampler82967_g63714, temp_output_597_0_g63749, DDX631_g63749, DDY632_g63749 ) * temp_output_597_30_g63749 ) + ( tex2D( _Sampler82967_g63714, temp_output_597_26_g63749, DDX631_g63749, DDY632_g63749 ) * temp_output_597_28_g63749 ) + ( tex2D( _Sampler82967_g63714, temp_output_597_27_g63749, DDX631_g63749, DDY632_g63749 ) * temp_output_597_29_g63749 ) );
					float4 break31_g63749 = Output_2D293_g63749;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g63714 = break31_g63749.r;
					#else
					float staticSwitch1005_g63714 = staticSwitch846_g63714;
					#endif
					float Metallic1239_g63714 = staticSwitch1005_g63714;
					float Metallic1_g63768 = Metallic1239_g63714;
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g63714 = tex2D( _GlossinessMap, UV0A2420_g63714 ).r;
					#else
					float staticSwitch845_g63714 = _Glossiness;
					#endif
					float2 temp_output_5_0_g63734 = UV0A2420_g63714;
					float2 UV633_g63734 = temp_output_5_0_g63734;
					float2 UV100_g63735 = UV633_g63734;
					float2 temp_output_51_0_g63735 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g63735 * float2( 3.464,3.464 ) ) );
					float2 break55_g63735 = frac( temp_output_51_0_g63735 );
					float temp_output_56_0_g63735 = ( ( 1.0 - break55_g63735.x ) - break55_g63735.y );
					float2 temp_output_52_0_g63735 = floor( temp_output_51_0_g63735 );
					float2 temp_output_125_0_g63735 = ( temp_output_52_0_g63735 + float2( 1,1 ) );
					float2 ifLocalVar87_g63735 = 0;
					if( temp_output_56_0_g63735 > 0.0 )
					ifLocalVar87_g63735 = temp_output_52_0_g63735;
					else if( temp_output_56_0_g63735 == 0.0 )
					ifLocalVar87_g63735 = temp_output_125_0_g63735;
					else if( temp_output_56_0_g63735 < 0.0 )
					ifLocalVar87_g63735 = temp_output_125_0_g63735;
					float3 temp_output_7_0_g63736 = frac( ( (ifLocalVar87_g63735).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63736 = dot( temp_output_7_0_g63736 , ( (temp_output_7_0_g63736).yzx + 33.33 ) );
					float3 temp_output_12_0_g63736 = ( temp_output_7_0_g63736 + dotResult8_g63736 );
					float2 temp_output_597_0_g63734 = ( UV100_g63735 + frac( ( ( (temp_output_12_0_g63736).xx + (temp_output_12_0_g63736).yz ) * (temp_output_12_0_g63736).zy ) ) );
					float2 DDX631_g63734 = ddx( temp_output_5_0_g63734 );
					float2 DDY632_g63734 = ddy( temp_output_5_0_g63734 );
					float temp_output_65_0_g63735 = ( 0.0 - temp_output_56_0_g63735 );
					float ifLocalVar59_g63735 = 0;
					if( temp_output_56_0_g63735 <= 0.0 )
					ifLocalVar59_g63735 = temp_output_65_0_g63735;
					else
					ifLocalVar59_g63735 = temp_output_56_0_g63735;
					float temp_output_597_30_g63734 = ifLocalVar59_g63735;
					float2 temp_output_90_0_g63735 = ( temp_output_52_0_g63735 + float2( 0,1 ) );
					float2 temp_output_123_0_g63735 = ( temp_output_52_0_g63735 + float2( 1,0 ) );
					float2 ifLocalVar88_g63735 = 0;
					if( temp_output_56_0_g63735 > 0.0 )
					ifLocalVar88_g63735 = temp_output_90_0_g63735;
					else if( temp_output_56_0_g63735 == 0.0 )
					ifLocalVar88_g63735 = temp_output_123_0_g63735;
					else if( temp_output_56_0_g63735 < 0.0 )
					ifLocalVar88_g63735 = temp_output_123_0_g63735;
					float3 temp_output_7_0_g63737 = frac( ( (ifLocalVar88_g63735).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63737 = dot( temp_output_7_0_g63737 , ( (temp_output_7_0_g63737).yzx + 33.33 ) );
					float3 temp_output_12_0_g63737 = ( temp_output_7_0_g63737 + dotResult8_g63737 );
					float2 temp_output_597_26_g63734 = ( UV100_g63735 + frac( ( ( (temp_output_12_0_g63737).xx + (temp_output_12_0_g63737).yz ) * (temp_output_12_0_g63737).zy ) ) );
					float temp_output_66_0_g63735 = ( 1.0 - break55_g63735.y );
					float ifLocalVar60_g63735 = 0;
					if( temp_output_56_0_g63735 <= 0.0 )
					ifLocalVar60_g63735 = temp_output_66_0_g63735;
					else
					ifLocalVar60_g63735 = break55_g63735.y;
					float temp_output_597_28_g63734 = ifLocalVar60_g63735;
					float2 ifLocalVar89_g63735 = 0;
					if( temp_output_56_0_g63735 > 0.0 )
					ifLocalVar89_g63735 = temp_output_123_0_g63735;
					else if( temp_output_56_0_g63735 == 0.0 )
					ifLocalVar89_g63735 = temp_output_90_0_g63735;
					else if( temp_output_56_0_g63735 < 0.0 )
					ifLocalVar89_g63735 = temp_output_90_0_g63735;
					float3 temp_output_7_0_g63738 = frac( ( (ifLocalVar89_g63735).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63738 = dot( temp_output_7_0_g63738 , ( (temp_output_7_0_g63738).yzx + 33.33 ) );
					float3 temp_output_12_0_g63738 = ( temp_output_7_0_g63738 + dotResult8_g63738 );
					float2 temp_output_597_27_g63734 = ( UV100_g63735 + frac( ( ( (temp_output_12_0_g63738).xx + (temp_output_12_0_g63738).yz ) * (temp_output_12_0_g63738).zy ) ) );
					float temp_output_67_0_g63735 = ( 1.0 - break55_g63735.x );
					float ifLocalVar61_g63735 = 0;
					if( temp_output_56_0_g63735 <= 0.0 )
					ifLocalVar61_g63735 = temp_output_67_0_g63735;
					else
					ifLocalVar61_g63735 = break55_g63735.x;
					float temp_output_597_29_g63734 = ifLocalVar61_g63735;
					float4 Output_2D293_g63734 = ( ( tex2D( _Sampler82964_g63714, temp_output_597_0_g63734, DDX631_g63734, DDY632_g63734 ) * temp_output_597_30_g63734 ) + ( tex2D( _Sampler82964_g63714, temp_output_597_26_g63734, DDX631_g63734, DDY632_g63734 ) * temp_output_597_28_g63734 ) + ( tex2D( _Sampler82964_g63714, temp_output_597_27_g63734, DDX631_g63734, DDY632_g63734 ) * temp_output_597_29_g63734 ) );
					float4 break31_g63734 = Output_2D293_g63734;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g63714 = ( 1.0 - break31_g63734.r );
					#else
					float staticSwitch1004_g63714 = ( 1.0 - staticSwitch845_g63714 );
					#endif
					float temp_output_19_0_g63764 = staticSwitch1004_g63714;
					float2 temp_output_5_0_g63724 = UV0A2420_g63714;
					float2 UV633_g63724 = temp_output_5_0_g63724;
					float2 UV100_g63725 = UV633_g63724;
					float2 temp_output_51_0_g63725 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g63725 * float2( 3.464,3.464 ) ) );
					float2 break55_g63725 = frac( temp_output_51_0_g63725 );
					float temp_output_56_0_g63725 = ( ( 1.0 - break55_g63725.x ) - break55_g63725.y );
					float2 temp_output_52_0_g63725 = floor( temp_output_51_0_g63725 );
					float2 temp_output_125_0_g63725 = ( temp_output_52_0_g63725 + float2( 1,1 ) );
					float2 ifLocalVar87_g63725 = 0;
					if( temp_output_56_0_g63725 > 0.0 )
					ifLocalVar87_g63725 = temp_output_52_0_g63725;
					else if( temp_output_56_0_g63725 == 0.0 )
					ifLocalVar87_g63725 = temp_output_125_0_g63725;
					else if( temp_output_56_0_g63725 < 0.0 )
					ifLocalVar87_g63725 = temp_output_125_0_g63725;
					float3 temp_output_7_0_g63726 = frac( ( (ifLocalVar87_g63725).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63726 = dot( temp_output_7_0_g63726 , ( (temp_output_7_0_g63726).yzx + 33.33 ) );
					float3 temp_output_12_0_g63726 = ( temp_output_7_0_g63726 + dotResult8_g63726 );
					float2 temp_output_597_0_g63724 = ( UV100_g63725 + frac( ( ( (temp_output_12_0_g63726).xx + (temp_output_12_0_g63726).yz ) * (temp_output_12_0_g63726).zy ) ) );
					float2 DDX631_g63724 = ddx( temp_output_5_0_g63724 );
					float2 DDY632_g63724 = ddy( temp_output_5_0_g63724 );
					float Input_Scale617_g63724 = 1.5;
					float temp_output_65_0_g63725 = ( 0.0 - temp_output_56_0_g63725 );
					float ifLocalVar59_g63725 = 0;
					if( temp_output_56_0_g63725 <= 0.0 )
					ifLocalVar59_g63725 = temp_output_65_0_g63725;
					else
					ifLocalVar59_g63725 = temp_output_56_0_g63725;
					float temp_output_597_30_g63724 = ifLocalVar59_g63725;
					float2 temp_output_90_0_g63725 = ( temp_output_52_0_g63725 + float2( 0,1 ) );
					float2 temp_output_123_0_g63725 = ( temp_output_52_0_g63725 + float2( 1,0 ) );
					float2 ifLocalVar88_g63725 = 0;
					if( temp_output_56_0_g63725 > 0.0 )
					ifLocalVar88_g63725 = temp_output_90_0_g63725;
					else if( temp_output_56_0_g63725 == 0.0 )
					ifLocalVar88_g63725 = temp_output_123_0_g63725;
					else if( temp_output_56_0_g63725 < 0.0 )
					ifLocalVar88_g63725 = temp_output_123_0_g63725;
					float3 temp_output_7_0_g63727 = frac( ( (ifLocalVar88_g63725).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63727 = dot( temp_output_7_0_g63727 , ( (temp_output_7_0_g63727).yzx + 33.33 ) );
					float3 temp_output_12_0_g63727 = ( temp_output_7_0_g63727 + dotResult8_g63727 );
					float2 temp_output_597_26_g63724 = ( UV100_g63725 + frac( ( ( (temp_output_12_0_g63727).xx + (temp_output_12_0_g63727).yz ) * (temp_output_12_0_g63727).zy ) ) );
					float temp_output_66_0_g63725 = ( 1.0 - break55_g63725.y );
					float ifLocalVar60_g63725 = 0;
					if( temp_output_56_0_g63725 <= 0.0 )
					ifLocalVar60_g63725 = temp_output_66_0_g63725;
					else
					ifLocalVar60_g63725 = break55_g63725.y;
					float temp_output_597_28_g63724 = ifLocalVar60_g63725;
					float2 ifLocalVar89_g63725 = 0;
					if( temp_output_56_0_g63725 > 0.0 )
					ifLocalVar89_g63725 = temp_output_123_0_g63725;
					else if( temp_output_56_0_g63725 == 0.0 )
					ifLocalVar89_g63725 = temp_output_90_0_g63725;
					else if( temp_output_56_0_g63725 < 0.0 )
					ifLocalVar89_g63725 = temp_output_90_0_g63725;
					float3 temp_output_7_0_g63728 = frac( ( (ifLocalVar89_g63725).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63728 = dot( temp_output_7_0_g63728 , ( (temp_output_7_0_g63728).yzx + 33.33 ) );
					float3 temp_output_12_0_g63728 = ( temp_output_7_0_g63728 + dotResult8_g63728 );
					float2 temp_output_597_27_g63724 = ( UV100_g63725 + frac( ( ( (temp_output_12_0_g63728).xx + (temp_output_12_0_g63728).yz ) * (temp_output_12_0_g63728).zy ) ) );
					float temp_output_67_0_g63725 = ( 1.0 - break55_g63725.x );
					float ifLocalVar61_g63725 = 0;
					if( temp_output_56_0_g63725 <= 0.0 )
					ifLocalVar61_g63725 = temp_output_67_0_g63725;
					else
					ifLocalVar61_g63725 = break55_g63725.x;
					float temp_output_597_29_g63724 = ifLocalVar61_g63725;
					float3 Output_2D_Normal641_g63724 = ( ( UnpackScaleNormal( tex2D( _Sampler82965_g63714, temp_output_597_0_g63724, DDX631_g63724, DDY632_g63724 ), Input_Scale617_g63724 ) * temp_output_597_30_g63724 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g63714, temp_output_597_26_g63724, DDX631_g63724, DDY632_g63724 ), Input_Scale617_g63724 ) * temp_output_597_28_g63724 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g63714, temp_output_597_27_g63724, DDX631_g63724, DDY632_g63724 ), Input_Scale617_g63724 ) * float3( 0,0,0 ) * temp_output_597_29_g63724 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g63714 = Output_2D_Normal641_g63724;
					#else
					float3 staticSwitch1003_g63714 = UnpackScaleNormal( tex2D( _BumpMap, UV0A2420_g63714 ), 1.5 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g63714 = staticSwitch1003_g63714;
					#else
					float3 staticSwitch980_g63714 = float3( 0, 0, 1 );
					#endif
					float3 normalizeResult2878_g63714 = normalize( staticSwitch980_g63714 );
					float3 Normal_Map700_g63714 = normalizeResult2878_g63714;
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal2504_g63714 = Normal_Map700_g63714;
					float3 worldNormal2504_g63714 = normalize( float3( dot( tanToWorld0, tanNormal2504_g63714 ), dot( tanToWorld1, tanNormal2504_g63714 ), dot( tanToWorld2, tanNormal2504_g63714 ) ) );
					float3 World_Normal2508_g63714 = worldNormal2504_g63714;
					float3 tanNormal2_g63764 = World_Normal2508_g63714;
					float3 worldNormal2_g63764 = float3( dot( tanToWorld0, tanNormal2_g63764 ), dot( tanToWorld1, tanNormal2_g63764 ), dot( tanToWorld2, tanNormal2_g63764 ) );
					float3 temp_output_3_0_g63764 = ddx( worldNormal2_g63764 );
					float dotResult5_g63764 = dot( temp_output_3_0_g63764 , temp_output_3_0_g63764 );
					float3 temp_output_4_0_g63764 = ddy( worldNormal2_g63764 );
					float dotResult6_g63764 = dot( temp_output_4_0_g63764 , temp_output_4_0_g63764 );
					#ifdef _USEGEOMETRICAA_ON
					float staticSwitch15_g63764 = min( temp_output_19_0_g63764, ( 1.0 - pow( saturate( max( dotResult5_g63764, dotResult6_g63764 ) ) , 0.25 ) ) );
					#else
					float staticSwitch15_g63764 = temp_output_19_0_g63764;
					#endif
					float Smoothness1399_g63714 = staticSwitch15_g63764;
					float Smoothness1_g63768 = Smoothness1399_g63714;
					float3 View_Direction2511_g63714 = ViewDirWS;
					float3 ViewDir1_g63768 = View_Direction2511_g63714;
					float3 World_Position2505_g63714 = PositionWS;
					float3 WorldPos1_g63768 = World_Position2505_g63714;
					float3 WorldNormal1_g63768 = World_Normal2508_g63714;
					float White38_g63714 = 1.0;
					float4 temp_cast_3 = (White38_g63714).xxxx;
					float4 texCoord2426_g63714 = IN.ase_texcoord6;
					texCoord2426_g63714.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0B2361_g63714 = (texCoord2426_g63714).zw;
					float localBicubicPrepare2_g63723 = ( 0.0 );
					float2 Input_UV100_g63723 = UV0B2361_g63714;
					float2 UV2_g63723 = Input_UV100_g63723;
					float4 TexelSize2_g63723 = _Lightmap0_TexelSize;
					float2 UV02_g63723 = float2( 0,0 );
					float2 UV12_g63723 = float2( 0,0 );
					float2 UV22_g63723 = float2( 0,0 );
					float2 UV32_g63723 = float2( 0,0 );
					float W02_g63723 = 0;
					float W12_g63723 = 0;
					{
					{
					 UV2_g63723 = UV2_g63723 * TexelSize2_g63723.zw - 0.5;
					    float2 f = frac( UV2_g63723 );
					    UV2_g63723 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g63723.x - 0.5, UV2_g63723.x + 1.5, UV2_g63723.y - 0.5, UV2_g63723.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g63723.xyxy;
					    UV02_g63723 = off.xz;
					    UV12_g63723 = off.yz;
					    UV22_g63723 = off.xw;
					    UV32_g63723 = off.yw;
					    W02_g63723 = s.x / ( s.x + s.y );
					 W12_g63723 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g63723 = lerp( tex2D( _Lightmap0, UV32_g63723 ) , tex2D( _Lightmap0, UV22_g63723 ) , W02_g63723);
					float4 lerpResult45_g63723 = lerp( tex2D( _Lightmap0, UV12_g63723 ) , tex2D( _Lightmap0, UV02_g63723 ) , W02_g63723);
					float4 lerpResult44_g63723 = lerp( lerpResult46_g63723 , lerpResult45_g63723 , W12_g63723);
					float4 Output_2D_Auto131_g63723 = lerpResult44_g63723;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g63714 = Output_2D_Auto131_g63723;
					#else
					float4 staticSwitch1092_g63714 = float4( tex2D( _Lightmap0, UV0B2361_g63714 ).rgb , 0.0 );
					#endif
					float4 Lightmap_0925_g63714 = staticSwitch1092_g63714;
					float localBicubicPrepare2_g63721 = ( 0.0 );
					float2 Input_UV100_g63721 = UV0B2361_g63714;
					float2 UV2_g63721 = Input_UV100_g63721;
					float4 TexelSize2_g63721 = _Lightmap1_TexelSize;
					float2 UV02_g63721 = float2( 0,0 );
					float2 UV12_g63721 = float2( 0,0 );
					float2 UV22_g63721 = float2( 0,0 );
					float2 UV32_g63721 = float2( 0,0 );
					float W02_g63721 = 0;
					float W12_g63721 = 0;
					{
					{
					 UV2_g63721 = UV2_g63721 * TexelSize2_g63721.zw - 0.5;
					    float2 f = frac( UV2_g63721 );
					    UV2_g63721 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g63721.x - 0.5, UV2_g63721.x + 1.5, UV2_g63721.y - 0.5, UV2_g63721.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g63721.xyxy;
					    UV02_g63721 = off.xz;
					    UV12_g63721 = off.yz;
					    UV22_g63721 = off.xw;
					    UV32_g63721 = off.yw;
					    W02_g63721 = s.x / ( s.x + s.y );
					 W12_g63721 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g63721 = lerp( tex2D( _Lightmap1, UV32_g63721 ) , tex2D( _Lightmap1, UV22_g63721 ) , W02_g63721);
					float4 lerpResult45_g63721 = lerp( tex2D( _Lightmap1, UV12_g63721 ) , tex2D( _Lightmap1, UV02_g63721 ) , W02_g63721);
					float4 lerpResult44_g63721 = lerp( lerpResult46_g63721 , lerpResult45_g63721 , W12_g63721);
					float4 Output_2D_Auto131_g63721 = lerpResult44_g63721;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g63714 = Output_2D_Auto131_g63721;
					#else
					float4 staticSwitch1088_g63714 = tex2D( _Lightmap1, UV0B2361_g63714 );
					#endif
					float4 Lightmap_1956_g63714 = staticSwitch1088_g63714;
					float Lightmap_Lerp_Value969_g63714 = _UdonLightmapLerp;
					float4 lerpResult442_g63714 = lerp( Lightmap_0925_g63714 , Lightmap_1956_g63714 , Lightmap_Lerp_Value969_g63714);
					float4 Lightmap_Lerp932_g63714 = lerpResult442_g63714;
					float3 appendResult139_g63760 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 Normal_Map318_g63760 = Normal_Map700_g63714;
					float dotResult121_g63760 = dot( appendResult139_g63760 , Normal_Map318_g63760 );
					float temp_output_2_0_g63762 = saturate( dotResult121_g63760 );
					float localStochasticTiling2_g63745 = ( 0.0 );
					float2 UV2_g63745 = UV0B2361_g63714;
					float4 TexelSize2_g63745 = _UdonRNMX0_TexelSize;
					float4 Offsets2_g63745 = float4( 0,0,0,0 );
					float2 Weights2_g63745 = float2( 0,0 );
					{
					UV2_g63745 = UV2_g63745 * TexelSize2_g63745.zw - 0.5;
					float2 f = frac( UV2_g63745 );
					UV2_g63745 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g63745.x - 0.5, UV2_g63745.x + 1.5, UV2_g63745.y - 0.5, UV2_g63745.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g63745 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g63745.xyxy;
					Weights2_g63745 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g63744 = Offsets2_g63745;
					float4 Input_FetchOffsets197_g63746 = temp_output_1_34_g63744;
					float2 temp_output_1_54_g63744 = Weights2_g63745;
					float2 Input_FetchWeights200_g63746 = temp_output_1_54_g63744;
					float2 break187_g63746 = Input_FetchWeights200_g63746;
					float4 lerpResult181_g63746 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g63746).yw ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g63746).xw ) , break187_g63746.x);
					float4 lerpResult182_g63746 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g63746).yz ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g63746).xz ) , break187_g63746.x);
					float4 lerpResult176_g63746 = lerp( lerpResult181_g63746 , lerpResult182_g63746 , break187_g63746.y);
					float4 Output_Fetch2D_Auto202_g63746 = lerpResult176_g63746;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g63714 = Output_Fetch2D_Auto202_g63746;
					#else
					float4 staticSwitch1061_g63714 = tex2D( _UdonRNMX0, UV0B2361_g63714 );
					#endif
					float3 appendResult146_g63760 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g63760 = dot( appendResult146_g63760 , Normal_Map318_g63760 );
					float temp_output_2_0_g63761 = saturate( dotResult122_g63760 );
					float4 Input_FetchOffsets197_g63747 = temp_output_1_34_g63744;
					float2 Input_FetchWeights200_g63747 = temp_output_1_54_g63744;
					float2 break187_g63747 = Input_FetchWeights200_g63747;
					float4 lerpResult181_g63747 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g63747).yw ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g63747).xw ) , break187_g63747.x);
					float4 lerpResult182_g63747 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g63747).yz ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g63747).xz ) , break187_g63747.x);
					float4 lerpResult176_g63747 = lerp( lerpResult181_g63747 , lerpResult182_g63747 , break187_g63747.y);
					float4 Output_Fetch2D_Auto202_g63747 = lerpResult176_g63747;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g63714 = Output_Fetch2D_Auto202_g63747;
					#else
					float4 staticSwitch1062_g63714 = tex2D( _UdonRNMY0, UV0B2361_g63714 );
					#endif
					float3 appendResult149_g63760 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g63760 = dot( appendResult149_g63760 , Normal_Map318_g63760 );
					float temp_output_2_0_g63763 = saturate( dotResult120_g63760 );
					float4 Input_FetchOffsets197_g63748 = temp_output_1_34_g63744;
					float2 Input_FetchWeights200_g63748 = temp_output_1_54_g63744;
					float2 break187_g63748 = Input_FetchWeights200_g63748;
					float4 lerpResult181_g63748 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g63748).yw ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g63748).xw ) , break187_g63748.x);
					float4 lerpResult182_g63748 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g63748).yz ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g63748).xz ) , break187_g63748.x);
					float4 lerpResult176_g63748 = lerp( lerpResult181_g63748 , lerpResult182_g63748 , break187_g63748.y);
					float4 Output_Fetch2D_Auto202_g63748 = lerpResult176_g63748;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g63714 = Output_Fetch2D_Auto202_g63748;
					#else
					float4 staticSwitch1063_g63714 = tex2D( _UdonRNMZ0, UV0B2361_g63714 );
					#endif
					float4 temp_output_24_0_g63760 = ( ( ( ( temp_output_2_0_g63762 * temp_output_2_0_g63762 ) * staticSwitch1061_g63714 ) + ( ( temp_output_2_0_g63761 * temp_output_2_0_g63761 ) * staticSwitch1062_g63714 ) ) + ( ( temp_output_2_0_g63763 * temp_output_2_0_g63763 ) * staticSwitch1063_g63714 ) );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch372_g63760 = ( temp_output_24_0_g63760 * 1.2 );
					#else
					float4 staticSwitch372_g63760 = temp_output_24_0_g63760;
					#endif
					float4 RNM_0926_g63714 = staticSwitch372_g63760;
					float3 appendResult139_g63756 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 Normal_Map318_g63756 = Normal_Map700_g63714;
					float dotResult121_g63756 = dot( appendResult139_g63756 , Normal_Map318_g63756 );
					float temp_output_2_0_g63758 = saturate( dotResult121_g63756 );
					float localStochasticTiling2_g63716 = ( 0.0 );
					float2 UV2_g63716 = UV0B2361_g63714;
					float4 TexelSize2_g63716 = _UdonRNMX1_TexelSize;
					float4 Offsets2_g63716 = float4( 0,0,0,0 );
					float2 Weights2_g63716 = float2( 0,0 );
					{
					UV2_g63716 = UV2_g63716 * TexelSize2_g63716.zw - 0.5;
					float2 f = frac( UV2_g63716 );
					UV2_g63716 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g63716.x - 0.5, UV2_g63716.x + 1.5, UV2_g63716.y - 0.5, UV2_g63716.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g63716 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g63716.xyxy;
					Weights2_g63716 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g63715 = Offsets2_g63716;
					float4 Input_FetchOffsets197_g63717 = temp_output_1_34_g63715;
					float2 temp_output_1_54_g63715 = Weights2_g63716;
					float2 Input_FetchWeights200_g63717 = temp_output_1_54_g63715;
					float2 break187_g63717 = Input_FetchWeights200_g63717;
					float4 lerpResult181_g63717 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g63717).yw ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g63717).xw ) , break187_g63717.x);
					float4 lerpResult182_g63717 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g63717).yz ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g63717).xz ) , break187_g63717.x);
					float4 lerpResult176_g63717 = lerp( lerpResult181_g63717 , lerpResult182_g63717 , break187_g63717.y);
					float4 Output_Fetch2D_Auto202_g63717 = lerpResult176_g63717;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g63714 = Output_Fetch2D_Auto202_g63717;
					#else
					float4 staticSwitch1087_g63714 = tex2D( _UdonRNMX1, UV0B2361_g63714 );
					#endif
					float3 appendResult146_g63756 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g63756 = dot( appendResult146_g63756 , Normal_Map318_g63756 );
					float temp_output_2_0_g63757 = saturate( dotResult122_g63756 );
					float4 Input_FetchOffsets197_g63718 = temp_output_1_34_g63715;
					float2 Input_FetchWeights200_g63718 = temp_output_1_54_g63715;
					float2 break187_g63718 = Input_FetchWeights200_g63718;
					float4 lerpResult181_g63718 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g63718).yw ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g63718).xw ) , break187_g63718.x);
					float4 lerpResult182_g63718 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g63718).yz ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g63718).xz ) , break187_g63718.x);
					float4 lerpResult176_g63718 = lerp( lerpResult181_g63718 , lerpResult182_g63718 , break187_g63718.y);
					float4 Output_Fetch2D_Auto202_g63718 = lerpResult176_g63718;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g63714 = Output_Fetch2D_Auto202_g63718;
					#else
					float4 staticSwitch1083_g63714 = tex2D( _UdonRNMY1, UV0B2361_g63714 );
					#endif
					float3 appendResult149_g63756 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g63756 = dot( appendResult149_g63756 , Normal_Map318_g63756 );
					float temp_output_2_0_g63759 = saturate( dotResult120_g63756 );
					float4 Input_FetchOffsets197_g63719 = temp_output_1_34_g63715;
					float2 Input_FetchWeights200_g63719 = temp_output_1_54_g63715;
					float2 break187_g63719 = Input_FetchWeights200_g63719;
					float4 lerpResult181_g63719 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g63719).yw ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g63719).xw ) , break187_g63719.x);
					float4 lerpResult182_g63719 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g63719).yz ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g63719).xz ) , break187_g63719.x);
					float4 lerpResult176_g63719 = lerp( lerpResult181_g63719 , lerpResult182_g63719 , break187_g63719.y);
					float4 Output_Fetch2D_Auto202_g63719 = lerpResult176_g63719;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g63714 = Output_Fetch2D_Auto202_g63719;
					#else
					float4 staticSwitch1084_g63714 = tex2D( _UdonRNMZ1, UV0B2361_g63714 );
					#endif
					float4 temp_output_24_0_g63756 = ( ( ( ( temp_output_2_0_g63758 * temp_output_2_0_g63758 ) * staticSwitch1087_g63714 ) + ( ( temp_output_2_0_g63757 * temp_output_2_0_g63757 ) * staticSwitch1083_g63714 ) ) + ( ( temp_output_2_0_g63759 * temp_output_2_0_g63759 ) * staticSwitch1084_g63714 ) );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch372_g63756 = ( temp_output_24_0_g63756 * 1.2 );
					#else
					float4 staticSwitch372_g63756 = temp_output_24_0_g63756;
					#endif
					float4 RNM_11081_g63714 = staticSwitch372_g63756;
					float4 lerpResult953_g63714 = lerp( RNM_0926_g63714 , RNM_11081_g63714 , Lightmap_Lerp_Value969_g63714);
					float4 RNM_Lerp950_g63714 = lerpResult953_g63714;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g63714 = temp_cast_3;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g63714 = Lightmap_0925_g63714;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g63714 = Lightmap_Lerp932_g63714;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g63714 = RNM_0926_g63714;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g63714 = RNM_Lerp950_g63714;
					#else
					float4 staticSwitch1014_g63714 = temp_cast_3;
					#endif
					float3 Lightmap46_g63714 = (staticSwitch1014_g63714).rgb;
					float dotResult9_g63767 = dot( float3( 0.212673, 0.715152, 0.072175 ) , Lightmap46_g63714 );
					float smoothstepResult2_g63767 = smoothstep( 0.0 , 0.04 , dotResult9_g63767);
					float Lightmap_Mask3067_g63714 = smoothstepResult2_g63767;
					float LightmapMask1_g63768 = Lightmap_Mask3067_g63714;
					float3 localIndirectSpecular1_g63768 = IndirectSpecular( Color1_g63768 , Metallic1_g63768 , Smoothness1_g63768 , ViewDir1_g63768 , WorldPos1_g63768 , WorldNormal1_g63768 , LightmapMask1_g63768 );
					#ifdef _INDIRECTSPECULARS_ON
					float3 staticSwitch2971_g63714 = localIndirectSpecular1_g63768;
					#else
					float3 staticSwitch2971_g63714 = temp_cast_2;
					#endif
					float3 Indirect_Specular1419_g63714 = staticSwitch2971_g63714;
					float3 temp_cast_5 = (Black1185_g63714).xxx;
					float3 Color97_g63766 = oAlbedo6_g63714;
					float Metallic97_g63766 = Metallic1239_g63714;
					float Smoothness97_g63766 = Smoothness1399_g63714;
					float3 ViewDir97_g63766 = View_Direction2511_g63714;
					float3 WorldPos97_g63766 = World_Position2505_g63714;
					float3 WorldNormal97_g63766 = World_Normal2508_g63714;
					float LightmapMask97_g63766 = Lightmap_Mask3067_g63714;
					float3 localDirectSpecular97_g63766 = DirectSpecular( Color97_g63766 , Metallic97_g63766 , Smoothness97_g63766 , ViewDir97_g63766 , WorldPos97_g63766 , WorldNormal97_g63766 , LightmapMask97_g63766 );
					#ifdef _DIRECTSPECULAR_ON
					float3 staticSwitch2969_g63714 = localDirectSpecular97_g63766;
					#else
					float3 staticSwitch2969_g63714 = temp_cast_5;
					#endif
					float3 Direct_Specular2560_g63714 = staticSwitch2969_g63714;
					float3 aAlbedo1466_g63714 = ( temp_output_2532_0_g63714 * ( 1.0 - Metallic1239_g63714 ) );
					float3 temp_output_1252_0_g63714 = ( aAlbedo1466_g63714 * Lightmap46_g63714 );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch1_g63765 = float4( ( temp_output_1252_0_g63714 + Emission86_g63714 + Indirect_Specular1419_g63714 ) , 0.0 );
					#else
					float4 staticSwitch1_g63765 = float4( ( Emission86_g63714 + Indirect_Specular1419_g63714 + Direct_Specular2560_g63714 + temp_output_1252_0_g63714 ) , 0.0 );
					#endif
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1181_g63714 = float4( Lightmap46_g63714 , 0.0 );
					#else
					float4 staticSwitch1181_g63714 = staticSwitch1_g63765;
					#endif
					float4 Color357_g63754 = staticSwitch1181_g63714;
					float4 LUT51_g63754 = tex3D( _LUT, ( ( log10( ( ( (Color357_g63754).xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 ) );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch359_g63754 = LUT51_g63754;
					#else
					float4 staticSwitch359_g63754 = Color357_g63754;
					#endif
					

					o.Albedo = staticSwitch1180_g63714;
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

					o.Emission = staticSwitch359_g63754.xyz;
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
			
			Name "SceneSelectionPass"
			Tags { "LightMode"="SceneSelectionPass" }

			ZWrite On

			CGPROGRAM
				#define ASE_GEOMETRY
				#define ASE_FRAGMENT_NORMAL 0
				#define ASE_RECEIVE_SHADOWS
				#pragma multi_compile_instancing
				#pragma multi_compile _ LOD_FADE_CROSSFADE
				#define ASE_LIGHTING_SIMPLE 1
				#define ASE_FOG
				#define _SPECULARHIGHLIGHTS_OFF
				#define _GLOSSYREFLECTIONS_OFF
				#define ASE_VERSION 19909

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
				uniform float _CATEGORYSPACESURFACEOPTIONS;
				uniform sampler3D _LUT;


				
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
						IN.pos.z = IN.pos.z;
					#endif

					#ifdef _ALPHATEST_ON
						clip( Alpha - AlphaClipThreshold );
					#endif

					#if defined( ASE_DEPTH_WRITE_ON )
						outputDepth = IN.pos.z;
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
				#define ASE_LIGHTING_SIMPLE 1
				#define ASE_FOG
				#define _SPECULARHIGHLIGHTS_OFF
				#define _GLOSSYREFLECTIONS_OFF
				#define ASE_VERSION 19909

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
				uniform float _CATEGORYSPACESURFACEOPTIONS;
				uniform sampler3D _LUT;


				
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
						IN.pos.z = IN.pos.z;
					#endif

					#ifdef _ALPHATEST_ON
						clip( Alpha - AlphaClipThreshold );
					#endif

					#if defined( ASE_DEPTH_WRITE_ON )
						outputDepth = IN.pos.z;
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
Version=19909
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;6270;-64,-1280;Inherit;False;Meenphie;0;;63714;b3ba55a08dd6b49c7be16c6f35cf2033;6,1008,0,2632,0,2635,0,2619,0,2636,0,2670,0;0;5;FLOAT3;625;FLOAT4;624;FLOAT;156;FLOAT;427;FLOAT;1024
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5279;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5280;256,-1280;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;Meenphie/Standard/Opaque;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardBase;0;1;ForwardBase;17;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;44;Category;0;0;  Instanced Terrain Normals;1;0;Workflow;3;639079749420714040;Surface;0;0;  Blend;0;0;  Dither Shadows;1;0;Two Sided;1;0;Alpha Clipping;0;0;  Use Shadow Threshold;0;0;Deferred Pass;0;639079951064078170;Normal Space;0;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;0;639108440689538340;Receive Shadows;1;0;Receive Specular;0;639147837478528560;Receive Reflections;0;639147837487264880;GPU Instancing;1;0;LOD CrossFade;1;0;Built-in Fog;1;639105044169342440;Ambient Light;1;639111933610282130;Meta Pass;0;639111933576947160;Add Pass;0;639111933580732010;Override Baked GI;0;0;Write Depth;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;0;Vertex Position;1;0;0;8;False;True;False;False;False;False;True;True;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5281;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;True;1;LightMode=ForwardAdd;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5282;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5283;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5284;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5285;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5286;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ScenePickingPass;0;7;ScenePickingPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=Picking;False;False;0;;0;0;Standard;0;False;0
WireConnection;5280;0;6270;625
WireConnection;5280;2;6270;624
ASEEND*/
//CHKSM=7018E177B63DF2B37D00F62DB0CDC792FF496D52