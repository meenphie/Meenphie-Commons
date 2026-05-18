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
		[NoScaleOffset][SingleLineTexture] _LUT( "LUT", 3D ) = "black" {}
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACECOLORGRADING( "CATEGORY SPACE COLOR GRADING", Float ) = 0
		[Meenphie_DrawerCategory(SPECIAL EFFECTS,true,0,0)] _CATEGORYSPECIALEFFECTS( "CATEGORY SPECIAL EFFECTS", Float ) = 0
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESPECIALEFFECTS( "CATEGORY SPACE SPECIAL EFFECTS", Float ) = 0
		[HideInInspector] GenKey__MainTex( "Assign keyword _MAINTEX", Float ) = 1.0
		[HideInInspector] GenKey__GlossinessMap( "Assign keyword _GLOSSINESSMAP", Float ) = 1.0
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0
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
				#pragma shader_feature_local _USELIGHTMAPPEDREFLECTIONS_ON
				#pragma shader_feature_local _METALLICMAP
				#pragma shader_feature_local _USEGEOMETRICAA_ON
				#pragma shader_feature_local _GLOSSINESSMAP
				#pragma shader_feature_local _BUMPMAP
				#pragma shader_feature_local _LIGHTMAPMODE_DISABLED _LIGHTMAPMODE_SIMPLE _LIGHTMAPMODE_SIMPLELERP _LIGHTMAPMODE_RNM _LIGHTMAPMODE_RNMLERP
				#pragma shader_feature_local _USEBICUBICFILTERING_ON


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
				sampler2D _Sampler82966_g60613;
				uniform float3 _EmissionColor;
				uniform sampler2D _EmissionMap;
				sampler2D _Sampler82968_g60613;
				uniform float _EmissionIntensity;
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				sampler2D _Sampler82967_g60613;
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				sampler2D _Sampler82964_g60613;
				uniform sampler2D _BumpMap;
				sampler2D _Sampler82965_g60613;
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

					float2 texCoord2357_g60613 = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0A2420_g60613 = texCoord2357_g60613;
					#ifdef _MAINTEX
					float4 staticSwitch1549_g60613 = tex2D( _MainTex, UV0A2420_g60613 );
					#else
					float4 staticSwitch1549_g60613 = _Color;
					#endif
					float2 temp_output_5_0_g60628 = UV0A2420_g60613;
					float2 UV633_g60628 = temp_output_5_0_g60628;
					float2 UV100_g60629 = UV633_g60628;
					float2 temp_output_51_0_g60629 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60629 * float2( 3.464,3.464 ) ) );
					float2 break55_g60629 = frac( temp_output_51_0_g60629 );
					float temp_output_56_0_g60629 = ( ( 1.0 - break55_g60629.x ) - break55_g60629.y );
					float2 temp_output_52_0_g60629 = floor( temp_output_51_0_g60629 );
					float2 temp_output_125_0_g60629 = ( temp_output_52_0_g60629 + float2( 1,1 ) );
					float2 ifLocalVar87_g60629 = 0;
					if( temp_output_56_0_g60629 > 0.0 )
					ifLocalVar87_g60629 = temp_output_52_0_g60629;
					else if( temp_output_56_0_g60629 == 0.0 )
					ifLocalVar87_g60629 = temp_output_125_0_g60629;
					else if( temp_output_56_0_g60629 < 0.0 )
					ifLocalVar87_g60629 = temp_output_125_0_g60629;
					float3 temp_output_7_0_g60630 = frac( ( (ifLocalVar87_g60629).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60630 = dot( temp_output_7_0_g60630 , ( (temp_output_7_0_g60630).yzx + 33.33 ) );
					float3 temp_output_12_0_g60630 = ( temp_output_7_0_g60630 + dotResult8_g60630 );
					float2 temp_output_597_0_g60628 = ( UV100_g60629 + frac( ( ( (temp_output_12_0_g60630).xx + (temp_output_12_0_g60630).yz ) * (temp_output_12_0_g60630).zy ) ) );
					float2 DDX631_g60628 = ddx( temp_output_5_0_g60628 );
					float2 DDY632_g60628 = ddy( temp_output_5_0_g60628 );
					float temp_output_65_0_g60629 = ( 0.0 - temp_output_56_0_g60629 );
					float ifLocalVar59_g60629 = 0;
					if( temp_output_56_0_g60629 <= 0.0 )
					ifLocalVar59_g60629 = temp_output_65_0_g60629;
					else
					ifLocalVar59_g60629 = temp_output_56_0_g60629;
					float temp_output_597_30_g60628 = ifLocalVar59_g60629;
					float2 temp_output_90_0_g60629 = ( temp_output_52_0_g60629 + float2( 0,1 ) );
					float2 temp_output_123_0_g60629 = ( temp_output_52_0_g60629 + float2( 1,0 ) );
					float2 ifLocalVar88_g60629 = 0;
					if( temp_output_56_0_g60629 > 0.0 )
					ifLocalVar88_g60629 = temp_output_90_0_g60629;
					else if( temp_output_56_0_g60629 == 0.0 )
					ifLocalVar88_g60629 = temp_output_123_0_g60629;
					else if( temp_output_56_0_g60629 < 0.0 )
					ifLocalVar88_g60629 = temp_output_123_0_g60629;
					float3 temp_output_7_0_g60631 = frac( ( (ifLocalVar88_g60629).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60631 = dot( temp_output_7_0_g60631 , ( (temp_output_7_0_g60631).yzx + 33.33 ) );
					float3 temp_output_12_0_g60631 = ( temp_output_7_0_g60631 + dotResult8_g60631 );
					float2 temp_output_597_26_g60628 = ( UV100_g60629 + frac( ( ( (temp_output_12_0_g60631).xx + (temp_output_12_0_g60631).yz ) * (temp_output_12_0_g60631).zy ) ) );
					float temp_output_66_0_g60629 = ( 1.0 - break55_g60629.y );
					float ifLocalVar60_g60629 = 0;
					if( temp_output_56_0_g60629 <= 0.0 )
					ifLocalVar60_g60629 = temp_output_66_0_g60629;
					else
					ifLocalVar60_g60629 = break55_g60629.y;
					float temp_output_597_28_g60628 = ifLocalVar60_g60629;
					float2 ifLocalVar89_g60629 = 0;
					if( temp_output_56_0_g60629 > 0.0 )
					ifLocalVar89_g60629 = temp_output_123_0_g60629;
					else if( temp_output_56_0_g60629 == 0.0 )
					ifLocalVar89_g60629 = temp_output_90_0_g60629;
					else if( temp_output_56_0_g60629 < 0.0 )
					ifLocalVar89_g60629 = temp_output_90_0_g60629;
					float3 temp_output_7_0_g60632 = frac( ( (ifLocalVar89_g60629).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60632 = dot( temp_output_7_0_g60632 , ( (temp_output_7_0_g60632).yzx + 33.33 ) );
					float3 temp_output_12_0_g60632 = ( temp_output_7_0_g60632 + dotResult8_g60632 );
					float2 temp_output_597_27_g60628 = ( UV100_g60629 + frac( ( ( (temp_output_12_0_g60632).xx + (temp_output_12_0_g60632).yz ) * (temp_output_12_0_g60632).zy ) ) );
					float temp_output_67_0_g60629 = ( 1.0 - break55_g60629.x );
					float ifLocalVar61_g60629 = 0;
					if( temp_output_56_0_g60629 <= 0.0 )
					ifLocalVar61_g60629 = temp_output_67_0_g60629;
					else
					ifLocalVar61_g60629 = break55_g60629.x;
					float temp_output_597_29_g60628 = ifLocalVar61_g60629;
					float4 Output_2D293_g60628 = ( ( tex2D( _Sampler82966_g60613, temp_output_597_0_g60628, DDX631_g60628, DDY632_g60628 ) * temp_output_597_30_g60628 ) + ( tex2D( _Sampler82966_g60613, temp_output_597_26_g60628, DDX631_g60628, DDY632_g60628 ) * temp_output_597_28_g60628 ) + ( tex2D( _Sampler82966_g60613, temp_output_597_27_g60628, DDX631_g60628, DDY632_g60628 ) * temp_output_597_29_g60628 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g60613 = Output_2D293_g60628;
					#else
					float4 staticSwitch1001_g60613 = staticSwitch1549_g60613;
					#endif
					float3 temp_output_2532_0_g60613 = (staticSwitch1001_g60613).rgb;
					float3 oAlbedo6_g60613 = temp_output_2532_0_g60613;
					float Black1185_g60613 = 0.0;
					float3 temp_cast_0 = (Black1185_g60613).xxx;
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch1180_g60613 = temp_cast_0;
					#else
					float3 staticSwitch1180_g60613 = oAlbedo6_g60613;
					#endif
					
					float2 temp_output_5_0_g60638 = UV0A2420_g60613;
					float2 UV633_g60638 = temp_output_5_0_g60638;
					float2 UV100_g60639 = UV633_g60638;
					float2 temp_output_51_0_g60639 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60639 * float2( 3.464,3.464 ) ) );
					float2 break55_g60639 = frac( temp_output_51_0_g60639 );
					float temp_output_56_0_g60639 = ( ( 1.0 - break55_g60639.x ) - break55_g60639.y );
					float2 temp_output_52_0_g60639 = floor( temp_output_51_0_g60639 );
					float2 temp_output_125_0_g60639 = ( temp_output_52_0_g60639 + float2( 1,1 ) );
					float2 ifLocalVar87_g60639 = 0;
					if( temp_output_56_0_g60639 > 0.0 )
					ifLocalVar87_g60639 = temp_output_52_0_g60639;
					else if( temp_output_56_0_g60639 == 0.0 )
					ifLocalVar87_g60639 = temp_output_125_0_g60639;
					else if( temp_output_56_0_g60639 < 0.0 )
					ifLocalVar87_g60639 = temp_output_125_0_g60639;
					float3 temp_output_7_0_g60640 = frac( ( (ifLocalVar87_g60639).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60640 = dot( temp_output_7_0_g60640 , ( (temp_output_7_0_g60640).yzx + 33.33 ) );
					float3 temp_output_12_0_g60640 = ( temp_output_7_0_g60640 + dotResult8_g60640 );
					float2 temp_output_597_0_g60638 = ( UV100_g60639 + frac( ( ( (temp_output_12_0_g60640).xx + (temp_output_12_0_g60640).yz ) * (temp_output_12_0_g60640).zy ) ) );
					float2 DDX631_g60638 = ddx( temp_output_5_0_g60638 );
					float2 DDY632_g60638 = ddy( temp_output_5_0_g60638 );
					float temp_output_65_0_g60639 = ( 0.0 - temp_output_56_0_g60639 );
					float ifLocalVar59_g60639 = 0;
					if( temp_output_56_0_g60639 <= 0.0 )
					ifLocalVar59_g60639 = temp_output_65_0_g60639;
					else
					ifLocalVar59_g60639 = temp_output_56_0_g60639;
					float temp_output_597_30_g60638 = ifLocalVar59_g60639;
					float2 temp_output_90_0_g60639 = ( temp_output_52_0_g60639 + float2( 0,1 ) );
					float2 temp_output_123_0_g60639 = ( temp_output_52_0_g60639 + float2( 1,0 ) );
					float2 ifLocalVar88_g60639 = 0;
					if( temp_output_56_0_g60639 > 0.0 )
					ifLocalVar88_g60639 = temp_output_90_0_g60639;
					else if( temp_output_56_0_g60639 == 0.0 )
					ifLocalVar88_g60639 = temp_output_123_0_g60639;
					else if( temp_output_56_0_g60639 < 0.0 )
					ifLocalVar88_g60639 = temp_output_123_0_g60639;
					float3 temp_output_7_0_g60641 = frac( ( (ifLocalVar88_g60639).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60641 = dot( temp_output_7_0_g60641 , ( (temp_output_7_0_g60641).yzx + 33.33 ) );
					float3 temp_output_12_0_g60641 = ( temp_output_7_0_g60641 + dotResult8_g60641 );
					float2 temp_output_597_26_g60638 = ( UV100_g60639 + frac( ( ( (temp_output_12_0_g60641).xx + (temp_output_12_0_g60641).yz ) * (temp_output_12_0_g60641).zy ) ) );
					float temp_output_66_0_g60639 = ( 1.0 - break55_g60639.y );
					float ifLocalVar60_g60639 = 0;
					if( temp_output_56_0_g60639 <= 0.0 )
					ifLocalVar60_g60639 = temp_output_66_0_g60639;
					else
					ifLocalVar60_g60639 = break55_g60639.y;
					float temp_output_597_28_g60638 = ifLocalVar60_g60639;
					float2 ifLocalVar89_g60639 = 0;
					if( temp_output_56_0_g60639 > 0.0 )
					ifLocalVar89_g60639 = temp_output_123_0_g60639;
					else if( temp_output_56_0_g60639 == 0.0 )
					ifLocalVar89_g60639 = temp_output_90_0_g60639;
					else if( temp_output_56_0_g60639 < 0.0 )
					ifLocalVar89_g60639 = temp_output_90_0_g60639;
					float3 temp_output_7_0_g60642 = frac( ( (ifLocalVar89_g60639).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60642 = dot( temp_output_7_0_g60642 , ( (temp_output_7_0_g60642).yzx + 33.33 ) );
					float3 temp_output_12_0_g60642 = ( temp_output_7_0_g60642 + dotResult8_g60642 );
					float2 temp_output_597_27_g60638 = ( UV100_g60639 + frac( ( ( (temp_output_12_0_g60642).xx + (temp_output_12_0_g60642).yz ) * (temp_output_12_0_g60642).zy ) ) );
					float temp_output_67_0_g60639 = ( 1.0 - break55_g60639.x );
					float ifLocalVar61_g60639 = 0;
					if( temp_output_56_0_g60639 <= 0.0 )
					ifLocalVar61_g60639 = temp_output_67_0_g60639;
					else
					ifLocalVar61_g60639 = break55_g60639.x;
					float temp_output_597_29_g60638 = ifLocalVar61_g60639;
					float4 Output_2D293_g60638 = ( ( tex2D( _Sampler82968_g60613, temp_output_597_0_g60638, DDX631_g60638, DDY632_g60638 ) * temp_output_597_30_g60638 ) + ( tex2D( _Sampler82968_g60613, temp_output_597_26_g60638, DDX631_g60638, DDY632_g60638 ) * temp_output_597_28_g60638 ) + ( tex2D( _Sampler82968_g60613, temp_output_597_27_g60638, DDX631_g60638, DDY632_g60638 ) * temp_output_597_29_g60638 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g60613 = Output_2D293_g60638;
					#else
					float4 staticSwitch1006_g60613 = tex2D( _EmissionMap, UV0A2420_g60613 );
					#endif
					float3 temp_output_2531_0_g60613 = (( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g60613 * _EmissionIntensity )).rgb;
					float3 Emission86_g60613 = temp_output_2531_0_g60613;
					float3 Color1_g60666 = oAlbedo6_g60613;
					#ifdef _METALLICMAP
					float staticSwitch846_g60613 = tex2D( _MetallicMap, UV0A2420_g60613 ).r;
					#else
					float staticSwitch846_g60613 = _Metallic;
					#endif
					float2 temp_output_5_0_g60648 = UV0A2420_g60613;
					float2 UV633_g60648 = temp_output_5_0_g60648;
					float2 UV100_g60649 = UV633_g60648;
					float2 temp_output_51_0_g60649 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60649 * float2( 3.464,3.464 ) ) );
					float2 break55_g60649 = frac( temp_output_51_0_g60649 );
					float temp_output_56_0_g60649 = ( ( 1.0 - break55_g60649.x ) - break55_g60649.y );
					float2 temp_output_52_0_g60649 = floor( temp_output_51_0_g60649 );
					float2 temp_output_125_0_g60649 = ( temp_output_52_0_g60649 + float2( 1,1 ) );
					float2 ifLocalVar87_g60649 = 0;
					if( temp_output_56_0_g60649 > 0.0 )
					ifLocalVar87_g60649 = temp_output_52_0_g60649;
					else if( temp_output_56_0_g60649 == 0.0 )
					ifLocalVar87_g60649 = temp_output_125_0_g60649;
					else if( temp_output_56_0_g60649 < 0.0 )
					ifLocalVar87_g60649 = temp_output_125_0_g60649;
					float3 temp_output_7_0_g60650 = frac( ( (ifLocalVar87_g60649).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60650 = dot( temp_output_7_0_g60650 , ( (temp_output_7_0_g60650).yzx + 33.33 ) );
					float3 temp_output_12_0_g60650 = ( temp_output_7_0_g60650 + dotResult8_g60650 );
					float2 temp_output_597_0_g60648 = ( UV100_g60649 + frac( ( ( (temp_output_12_0_g60650).xx + (temp_output_12_0_g60650).yz ) * (temp_output_12_0_g60650).zy ) ) );
					float2 DDX631_g60648 = ddx( temp_output_5_0_g60648 );
					float2 DDY632_g60648 = ddy( temp_output_5_0_g60648 );
					float temp_output_65_0_g60649 = ( 0.0 - temp_output_56_0_g60649 );
					float ifLocalVar59_g60649 = 0;
					if( temp_output_56_0_g60649 <= 0.0 )
					ifLocalVar59_g60649 = temp_output_65_0_g60649;
					else
					ifLocalVar59_g60649 = temp_output_56_0_g60649;
					float temp_output_597_30_g60648 = ifLocalVar59_g60649;
					float2 temp_output_90_0_g60649 = ( temp_output_52_0_g60649 + float2( 0,1 ) );
					float2 temp_output_123_0_g60649 = ( temp_output_52_0_g60649 + float2( 1,0 ) );
					float2 ifLocalVar88_g60649 = 0;
					if( temp_output_56_0_g60649 > 0.0 )
					ifLocalVar88_g60649 = temp_output_90_0_g60649;
					else if( temp_output_56_0_g60649 == 0.0 )
					ifLocalVar88_g60649 = temp_output_123_0_g60649;
					else if( temp_output_56_0_g60649 < 0.0 )
					ifLocalVar88_g60649 = temp_output_123_0_g60649;
					float3 temp_output_7_0_g60651 = frac( ( (ifLocalVar88_g60649).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60651 = dot( temp_output_7_0_g60651 , ( (temp_output_7_0_g60651).yzx + 33.33 ) );
					float3 temp_output_12_0_g60651 = ( temp_output_7_0_g60651 + dotResult8_g60651 );
					float2 temp_output_597_26_g60648 = ( UV100_g60649 + frac( ( ( (temp_output_12_0_g60651).xx + (temp_output_12_0_g60651).yz ) * (temp_output_12_0_g60651).zy ) ) );
					float temp_output_66_0_g60649 = ( 1.0 - break55_g60649.y );
					float ifLocalVar60_g60649 = 0;
					if( temp_output_56_0_g60649 <= 0.0 )
					ifLocalVar60_g60649 = temp_output_66_0_g60649;
					else
					ifLocalVar60_g60649 = break55_g60649.y;
					float temp_output_597_28_g60648 = ifLocalVar60_g60649;
					float2 ifLocalVar89_g60649 = 0;
					if( temp_output_56_0_g60649 > 0.0 )
					ifLocalVar89_g60649 = temp_output_123_0_g60649;
					else if( temp_output_56_0_g60649 == 0.0 )
					ifLocalVar89_g60649 = temp_output_90_0_g60649;
					else if( temp_output_56_0_g60649 < 0.0 )
					ifLocalVar89_g60649 = temp_output_90_0_g60649;
					float3 temp_output_7_0_g60652 = frac( ( (ifLocalVar89_g60649).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60652 = dot( temp_output_7_0_g60652 , ( (temp_output_7_0_g60652).yzx + 33.33 ) );
					float3 temp_output_12_0_g60652 = ( temp_output_7_0_g60652 + dotResult8_g60652 );
					float2 temp_output_597_27_g60648 = ( UV100_g60649 + frac( ( ( (temp_output_12_0_g60652).xx + (temp_output_12_0_g60652).yz ) * (temp_output_12_0_g60652).zy ) ) );
					float temp_output_67_0_g60649 = ( 1.0 - break55_g60649.x );
					float ifLocalVar61_g60649 = 0;
					if( temp_output_56_0_g60649 <= 0.0 )
					ifLocalVar61_g60649 = temp_output_67_0_g60649;
					else
					ifLocalVar61_g60649 = break55_g60649.x;
					float temp_output_597_29_g60648 = ifLocalVar61_g60649;
					float4 Output_2D293_g60648 = ( ( tex2D( _Sampler82967_g60613, temp_output_597_0_g60648, DDX631_g60648, DDY632_g60648 ) * temp_output_597_30_g60648 ) + ( tex2D( _Sampler82967_g60613, temp_output_597_26_g60648, DDX631_g60648, DDY632_g60648 ) * temp_output_597_28_g60648 ) + ( tex2D( _Sampler82967_g60613, temp_output_597_27_g60648, DDX631_g60648, DDY632_g60648 ) * temp_output_597_29_g60648 ) );
					float4 break31_g60648 = Output_2D293_g60648;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g60613 = break31_g60648.r;
					#else
					float staticSwitch1005_g60613 = staticSwitch846_g60613;
					#endif
					float Metallic1239_g60613 = staticSwitch1005_g60613;
					float Metallic1_g60666 = Metallic1239_g60613;
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g60613 = tex2D( _GlossinessMap, UV0A2420_g60613 ).r;
					#else
					float staticSwitch845_g60613 = _Glossiness;
					#endif
					float2 temp_output_5_0_g60633 = UV0A2420_g60613;
					float2 UV633_g60633 = temp_output_5_0_g60633;
					float2 UV100_g60634 = UV633_g60633;
					float2 temp_output_51_0_g60634 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60634 * float2( 3.464,3.464 ) ) );
					float2 break55_g60634 = frac( temp_output_51_0_g60634 );
					float temp_output_56_0_g60634 = ( ( 1.0 - break55_g60634.x ) - break55_g60634.y );
					float2 temp_output_52_0_g60634 = floor( temp_output_51_0_g60634 );
					float2 temp_output_125_0_g60634 = ( temp_output_52_0_g60634 + float2( 1,1 ) );
					float2 ifLocalVar87_g60634 = 0;
					if( temp_output_56_0_g60634 > 0.0 )
					ifLocalVar87_g60634 = temp_output_52_0_g60634;
					else if( temp_output_56_0_g60634 == 0.0 )
					ifLocalVar87_g60634 = temp_output_125_0_g60634;
					else if( temp_output_56_0_g60634 < 0.0 )
					ifLocalVar87_g60634 = temp_output_125_0_g60634;
					float3 temp_output_7_0_g60635 = frac( ( (ifLocalVar87_g60634).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60635 = dot( temp_output_7_0_g60635 , ( (temp_output_7_0_g60635).yzx + 33.33 ) );
					float3 temp_output_12_0_g60635 = ( temp_output_7_0_g60635 + dotResult8_g60635 );
					float2 temp_output_597_0_g60633 = ( UV100_g60634 + frac( ( ( (temp_output_12_0_g60635).xx + (temp_output_12_0_g60635).yz ) * (temp_output_12_0_g60635).zy ) ) );
					float2 DDX631_g60633 = ddx( temp_output_5_0_g60633 );
					float2 DDY632_g60633 = ddy( temp_output_5_0_g60633 );
					float temp_output_65_0_g60634 = ( 0.0 - temp_output_56_0_g60634 );
					float ifLocalVar59_g60634 = 0;
					if( temp_output_56_0_g60634 <= 0.0 )
					ifLocalVar59_g60634 = temp_output_65_0_g60634;
					else
					ifLocalVar59_g60634 = temp_output_56_0_g60634;
					float temp_output_597_30_g60633 = ifLocalVar59_g60634;
					float2 temp_output_90_0_g60634 = ( temp_output_52_0_g60634 + float2( 0,1 ) );
					float2 temp_output_123_0_g60634 = ( temp_output_52_0_g60634 + float2( 1,0 ) );
					float2 ifLocalVar88_g60634 = 0;
					if( temp_output_56_0_g60634 > 0.0 )
					ifLocalVar88_g60634 = temp_output_90_0_g60634;
					else if( temp_output_56_0_g60634 == 0.0 )
					ifLocalVar88_g60634 = temp_output_123_0_g60634;
					else if( temp_output_56_0_g60634 < 0.0 )
					ifLocalVar88_g60634 = temp_output_123_0_g60634;
					float3 temp_output_7_0_g60636 = frac( ( (ifLocalVar88_g60634).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60636 = dot( temp_output_7_0_g60636 , ( (temp_output_7_0_g60636).yzx + 33.33 ) );
					float3 temp_output_12_0_g60636 = ( temp_output_7_0_g60636 + dotResult8_g60636 );
					float2 temp_output_597_26_g60633 = ( UV100_g60634 + frac( ( ( (temp_output_12_0_g60636).xx + (temp_output_12_0_g60636).yz ) * (temp_output_12_0_g60636).zy ) ) );
					float temp_output_66_0_g60634 = ( 1.0 - break55_g60634.y );
					float ifLocalVar60_g60634 = 0;
					if( temp_output_56_0_g60634 <= 0.0 )
					ifLocalVar60_g60634 = temp_output_66_0_g60634;
					else
					ifLocalVar60_g60634 = break55_g60634.y;
					float temp_output_597_28_g60633 = ifLocalVar60_g60634;
					float2 ifLocalVar89_g60634 = 0;
					if( temp_output_56_0_g60634 > 0.0 )
					ifLocalVar89_g60634 = temp_output_123_0_g60634;
					else if( temp_output_56_0_g60634 == 0.0 )
					ifLocalVar89_g60634 = temp_output_90_0_g60634;
					else if( temp_output_56_0_g60634 < 0.0 )
					ifLocalVar89_g60634 = temp_output_90_0_g60634;
					float3 temp_output_7_0_g60637 = frac( ( (ifLocalVar89_g60634).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60637 = dot( temp_output_7_0_g60637 , ( (temp_output_7_0_g60637).yzx + 33.33 ) );
					float3 temp_output_12_0_g60637 = ( temp_output_7_0_g60637 + dotResult8_g60637 );
					float2 temp_output_597_27_g60633 = ( UV100_g60634 + frac( ( ( (temp_output_12_0_g60637).xx + (temp_output_12_0_g60637).yz ) * (temp_output_12_0_g60637).zy ) ) );
					float temp_output_67_0_g60634 = ( 1.0 - break55_g60634.x );
					float ifLocalVar61_g60634 = 0;
					if( temp_output_56_0_g60634 <= 0.0 )
					ifLocalVar61_g60634 = temp_output_67_0_g60634;
					else
					ifLocalVar61_g60634 = break55_g60634.x;
					float temp_output_597_29_g60633 = ifLocalVar61_g60634;
					float4 Output_2D293_g60633 = ( ( tex2D( _Sampler82964_g60613, temp_output_597_0_g60633, DDX631_g60633, DDY632_g60633 ) * temp_output_597_30_g60633 ) + ( tex2D( _Sampler82964_g60613, temp_output_597_26_g60633, DDX631_g60633, DDY632_g60633 ) * temp_output_597_28_g60633 ) + ( tex2D( _Sampler82964_g60613, temp_output_597_27_g60633, DDX631_g60633, DDY632_g60633 ) * temp_output_597_29_g60633 ) );
					float4 break31_g60633 = Output_2D293_g60633;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g60613 = ( 1.0 - break31_g60633.r );
					#else
					float staticSwitch1004_g60613 = ( 1.0 - staticSwitch845_g60613 );
					#endif
					float temp_output_19_0_g60667 = staticSwitch1004_g60613;
					float2 temp_output_5_0_g60623 = UV0A2420_g60613;
					float2 UV633_g60623 = temp_output_5_0_g60623;
					float2 UV100_g60624 = UV633_g60623;
					float2 temp_output_51_0_g60624 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60624 * float2( 3.464,3.464 ) ) );
					float2 break55_g60624 = frac( temp_output_51_0_g60624 );
					float temp_output_56_0_g60624 = ( ( 1.0 - break55_g60624.x ) - break55_g60624.y );
					float2 temp_output_52_0_g60624 = floor( temp_output_51_0_g60624 );
					float2 temp_output_125_0_g60624 = ( temp_output_52_0_g60624 + float2( 1,1 ) );
					float2 ifLocalVar87_g60624 = 0;
					if( temp_output_56_0_g60624 > 0.0 )
					ifLocalVar87_g60624 = temp_output_52_0_g60624;
					else if( temp_output_56_0_g60624 == 0.0 )
					ifLocalVar87_g60624 = temp_output_125_0_g60624;
					else if( temp_output_56_0_g60624 < 0.0 )
					ifLocalVar87_g60624 = temp_output_125_0_g60624;
					float3 temp_output_7_0_g60625 = frac( ( (ifLocalVar87_g60624).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60625 = dot( temp_output_7_0_g60625 , ( (temp_output_7_0_g60625).yzx + 33.33 ) );
					float3 temp_output_12_0_g60625 = ( temp_output_7_0_g60625 + dotResult8_g60625 );
					float2 temp_output_597_0_g60623 = ( UV100_g60624 + frac( ( ( (temp_output_12_0_g60625).xx + (temp_output_12_0_g60625).yz ) * (temp_output_12_0_g60625).zy ) ) );
					float2 DDX631_g60623 = ddx( temp_output_5_0_g60623 );
					float2 DDY632_g60623 = ddy( temp_output_5_0_g60623 );
					float Input_Scale617_g60623 = 1.5;
					float temp_output_65_0_g60624 = ( 0.0 - temp_output_56_0_g60624 );
					float ifLocalVar59_g60624 = 0;
					if( temp_output_56_0_g60624 <= 0.0 )
					ifLocalVar59_g60624 = temp_output_65_0_g60624;
					else
					ifLocalVar59_g60624 = temp_output_56_0_g60624;
					float temp_output_597_30_g60623 = ifLocalVar59_g60624;
					float2 temp_output_90_0_g60624 = ( temp_output_52_0_g60624 + float2( 0,1 ) );
					float2 temp_output_123_0_g60624 = ( temp_output_52_0_g60624 + float2( 1,0 ) );
					float2 ifLocalVar88_g60624 = 0;
					if( temp_output_56_0_g60624 > 0.0 )
					ifLocalVar88_g60624 = temp_output_90_0_g60624;
					else if( temp_output_56_0_g60624 == 0.0 )
					ifLocalVar88_g60624 = temp_output_123_0_g60624;
					else if( temp_output_56_0_g60624 < 0.0 )
					ifLocalVar88_g60624 = temp_output_123_0_g60624;
					float3 temp_output_7_0_g60626 = frac( ( (ifLocalVar88_g60624).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60626 = dot( temp_output_7_0_g60626 , ( (temp_output_7_0_g60626).yzx + 33.33 ) );
					float3 temp_output_12_0_g60626 = ( temp_output_7_0_g60626 + dotResult8_g60626 );
					float2 temp_output_597_26_g60623 = ( UV100_g60624 + frac( ( ( (temp_output_12_0_g60626).xx + (temp_output_12_0_g60626).yz ) * (temp_output_12_0_g60626).zy ) ) );
					float temp_output_66_0_g60624 = ( 1.0 - break55_g60624.y );
					float ifLocalVar60_g60624 = 0;
					if( temp_output_56_0_g60624 <= 0.0 )
					ifLocalVar60_g60624 = temp_output_66_0_g60624;
					else
					ifLocalVar60_g60624 = break55_g60624.y;
					float temp_output_597_28_g60623 = ifLocalVar60_g60624;
					float2 ifLocalVar89_g60624 = 0;
					if( temp_output_56_0_g60624 > 0.0 )
					ifLocalVar89_g60624 = temp_output_123_0_g60624;
					else if( temp_output_56_0_g60624 == 0.0 )
					ifLocalVar89_g60624 = temp_output_90_0_g60624;
					else if( temp_output_56_0_g60624 < 0.0 )
					ifLocalVar89_g60624 = temp_output_90_0_g60624;
					float3 temp_output_7_0_g60627 = frac( ( (ifLocalVar89_g60624).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60627 = dot( temp_output_7_0_g60627 , ( (temp_output_7_0_g60627).yzx + 33.33 ) );
					float3 temp_output_12_0_g60627 = ( temp_output_7_0_g60627 + dotResult8_g60627 );
					float2 temp_output_597_27_g60623 = ( UV100_g60624 + frac( ( ( (temp_output_12_0_g60627).xx + (temp_output_12_0_g60627).yz ) * (temp_output_12_0_g60627).zy ) ) );
					float temp_output_67_0_g60624 = ( 1.0 - break55_g60624.x );
					float ifLocalVar61_g60624 = 0;
					if( temp_output_56_0_g60624 <= 0.0 )
					ifLocalVar61_g60624 = temp_output_67_0_g60624;
					else
					ifLocalVar61_g60624 = break55_g60624.x;
					float temp_output_597_29_g60623 = ifLocalVar61_g60624;
					float3 Output_2D_Normal641_g60623 = ( ( UnpackScaleNormal( tex2D( _Sampler82965_g60613, temp_output_597_0_g60623, DDX631_g60623, DDY632_g60623 ), Input_Scale617_g60623 ) * temp_output_597_30_g60623 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g60613, temp_output_597_26_g60623, DDX631_g60623, DDY632_g60623 ), Input_Scale617_g60623 ) * temp_output_597_28_g60623 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g60613, temp_output_597_27_g60623, DDX631_g60623, DDY632_g60623 ), Input_Scale617_g60623 ) * float3( 0,0,0 ) * temp_output_597_29_g60623 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g60613 = Output_2D_Normal641_g60623;
					#else
					float3 staticSwitch1003_g60613 = UnpackScaleNormal( tex2D( _BumpMap, UV0A2420_g60613 ), 1.5 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g60613 = staticSwitch1003_g60613;
					#else
					float3 staticSwitch980_g60613 = float3( 0, 0, 1 );
					#endif
					float3 normalizeResult2878_g60613 = normalize( staticSwitch980_g60613 );
					float3 Normal_Map700_g60613 = normalizeResult2878_g60613;
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal2504_g60613 = Normal_Map700_g60613;
					float3 worldNormal2504_g60613 = normalize( float3( dot( tanToWorld0, tanNormal2504_g60613 ), dot( tanToWorld1, tanNormal2504_g60613 ), dot( tanToWorld2, tanNormal2504_g60613 ) ) );
					float3 World_Normal2508_g60613 = worldNormal2504_g60613;
					float3 tanNormal2_g60667 = World_Normal2508_g60613;
					float3 worldNormal2_g60667 = float3( dot( tanToWorld0, tanNormal2_g60667 ), dot( tanToWorld1, tanNormal2_g60667 ), dot( tanToWorld2, tanNormal2_g60667 ) );
					float3 temp_output_3_0_g60667 = ddx( worldNormal2_g60667 );
					float dotResult5_g60667 = dot( temp_output_3_0_g60667 , temp_output_3_0_g60667 );
					float3 temp_output_4_0_g60667 = ddy( worldNormal2_g60667 );
					float dotResult6_g60667 = dot( temp_output_4_0_g60667 , temp_output_4_0_g60667 );
					#ifdef _USEGEOMETRICAA_ON
					float staticSwitch15_g60667 = min( temp_output_19_0_g60667, ( 1.0 - pow( saturate( max( dotResult5_g60667, dotResult6_g60667 ) ) , 0.25 ) ) );
					#else
					float staticSwitch15_g60667 = temp_output_19_0_g60667;
					#endif
					float Smoothness1399_g60613 = staticSwitch15_g60667;
					float Smoothness1_g60666 = Smoothness1399_g60613;
					float IOR2700_g60613 = _IOR;
					float IOR1_g60666 = IOR2700_g60613;
					float3 temp_cast_2 = (0.04).xxx;
					float3 lerpResult1473_g60613 = lerp( temp_cast_2 , oAlbedo6_g60613 , Metallic1239_g60613);
					float3 switchResult1501_g60613 = (((ase_vface>0)?(World_Normal2508_g60613):(-World_Normal2508_g60613)));
					float3 View_Direction2511_g60613 = ViewDirWS;
					float dotResult1476_g60613 = dot( switchResult1501_g60613 , View_Direction2511_g60613 );
					float3 lerpResult1480_g60613 = lerp( lerpResult1473_g60613 , float3( 1,1,1 ) , pow( ( 1.0 - saturate( dotResult1476_g60613 ) ) , 5.0 ));
					float3 Fresnel1560_g60613 = lerpResult1480_g60613;
					float3 Fresnel1_g60666 = Fresnel1560_g60613;
					float3 World_Position2505_g60613 = PositionWS;
					float3 WorldPos1_g60666 = World_Position2505_g60613;
					float3 WorldNormal1_g60666 = World_Normal2508_g60613;
					float3 ViewDir1_g60666 = View_Direction2511_g60613;
					float3 localIndirectSpecular1_g60666 = IndirectSpecular( Color1_g60666 , Metallic1_g60666 , Smoothness1_g60666 , IOR1_g60666 , Fresnel1_g60666 , WorldPos1_g60666 , WorldNormal1_g60666 , ViewDir1_g60666 );
					float3 temp_output_2958_0_g60613 = localIndirectSpecular1_g60666;
					float White38_g60613 = 1.0;
					float4 temp_cast_3 = (White38_g60613).xxxx;
					float4 texCoord2426_g60613 = IN.ase_texcoord6;
					texCoord2426_g60613.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0B2361_g60613 = (texCoord2426_g60613).zw;
					float localBicubicPrepare2_g60622 = ( 0.0 );
					float2 Input_UV100_g60622 = UV0B2361_g60613;
					float2 UV2_g60622 = Input_UV100_g60622;
					float4 TexelSize2_g60622 = _Lightmap0_TexelSize;
					float2 UV02_g60622 = float2( 0,0 );
					float2 UV12_g60622 = float2( 0,0 );
					float2 UV22_g60622 = float2( 0,0 );
					float2 UV32_g60622 = float2( 0,0 );
					float W02_g60622 = 0;
					float W12_g60622 = 0;
					{
					{
					 UV2_g60622 = UV2_g60622 * TexelSize2_g60622.zw - 0.5;
					    float2 f = frac( UV2_g60622 );
					    UV2_g60622 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g60622.x - 0.5, UV2_g60622.x + 1.5, UV2_g60622.y - 0.5, UV2_g60622.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60622.xyxy;
					    UV02_g60622 = off.xz;
					    UV12_g60622 = off.yz;
					    UV22_g60622 = off.xw;
					    UV32_g60622 = off.yw;
					    W02_g60622 = s.x / ( s.x + s.y );
					 W12_g60622 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g60622 = lerp( tex2D( _Lightmap0, UV32_g60622 ) , tex2D( _Lightmap0, UV22_g60622 ) , W02_g60622);
					float4 lerpResult45_g60622 = lerp( tex2D( _Lightmap0, UV12_g60622 ) , tex2D( _Lightmap0, UV02_g60622 ) , W02_g60622);
					float4 lerpResult44_g60622 = lerp( lerpResult46_g60622 , lerpResult45_g60622 , W12_g60622);
					float4 Output_2D_Auto131_g60622 = lerpResult44_g60622;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g60613 = Output_2D_Auto131_g60622;
					#else
					float4 staticSwitch1092_g60613 = float4( tex2D( _Lightmap0, UV0B2361_g60613 ).rgb , 0.0 );
					#endif
					float4 Lightmap_0925_g60613 = staticSwitch1092_g60613;
					float localBicubicPrepare2_g60620 = ( 0.0 );
					float2 Input_UV100_g60620 = UV0B2361_g60613;
					float2 UV2_g60620 = Input_UV100_g60620;
					float4 TexelSize2_g60620 = _Lightmap1_TexelSize;
					float2 UV02_g60620 = float2( 0,0 );
					float2 UV12_g60620 = float2( 0,0 );
					float2 UV22_g60620 = float2( 0,0 );
					float2 UV32_g60620 = float2( 0,0 );
					float W02_g60620 = 0;
					float W12_g60620 = 0;
					{
					{
					 UV2_g60620 = UV2_g60620 * TexelSize2_g60620.zw - 0.5;
					    float2 f = frac( UV2_g60620 );
					    UV2_g60620 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g60620.x - 0.5, UV2_g60620.x + 1.5, UV2_g60620.y - 0.5, UV2_g60620.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60620.xyxy;
					    UV02_g60620 = off.xz;
					    UV12_g60620 = off.yz;
					    UV22_g60620 = off.xw;
					    UV32_g60620 = off.yw;
					    W02_g60620 = s.x / ( s.x + s.y );
					 W12_g60620 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g60620 = lerp( tex2D( _Lightmap1, UV32_g60620 ) , tex2D( _Lightmap1, UV22_g60620 ) , W02_g60620);
					float4 lerpResult45_g60620 = lerp( tex2D( _Lightmap1, UV12_g60620 ) , tex2D( _Lightmap1, UV02_g60620 ) , W02_g60620);
					float4 lerpResult44_g60620 = lerp( lerpResult46_g60620 , lerpResult45_g60620 , W12_g60620);
					float4 Output_2D_Auto131_g60620 = lerpResult44_g60620;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g60613 = Output_2D_Auto131_g60620;
					#else
					float4 staticSwitch1088_g60613 = tex2D( _Lightmap1, UV0B2361_g60613 );
					#endif
					float4 Lightmap_1956_g60613 = staticSwitch1088_g60613;
					float Lightmap_Lerp_Value969_g60613 = _UdonLightmapLerp;
					float4 lerpResult442_g60613 = lerp( Lightmap_0925_g60613 , Lightmap_1956_g60613 , Lightmap_Lerp_Value969_g60613);
					float4 Lightmap_Lerp932_g60613 = lerpResult442_g60613;
					float3 appendResult139_g60660 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 Normal_Map318_g60660 = Normal_Map700_g60613;
					float dotResult121_g60660 = dot( appendResult139_g60660 , Normal_Map318_g60660 );
					float temp_output_2_0_g60662 = saturate( dotResult121_g60660 );
					float localStochasticTiling2_g60644 = ( 0.0 );
					float2 UV2_g60644 = UV0B2361_g60613;
					float4 TexelSize2_g60644 = _UdonRNMX0_TexelSize;
					float4 Offsets2_g60644 = float4( 0,0,0,0 );
					float2 Weights2_g60644 = float2( 0,0 );
					{
					UV2_g60644 = UV2_g60644 * TexelSize2_g60644.zw - 0.5;
					float2 f = frac( UV2_g60644 );
					UV2_g60644 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g60644.x - 0.5, UV2_g60644.x + 1.5, UV2_g60644.y - 0.5, UV2_g60644.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g60644 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60644.xyxy;
					Weights2_g60644 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g60643 = Offsets2_g60644;
					float4 Input_FetchOffsets197_g60645 = temp_output_1_34_g60643;
					float2 temp_output_1_54_g60643 = Weights2_g60644;
					float2 Input_FetchWeights200_g60645 = temp_output_1_54_g60643;
					float2 break187_g60645 = Input_FetchWeights200_g60645;
					float4 lerpResult181_g60645 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60645).yw ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60645).xw ) , break187_g60645.x);
					float4 lerpResult182_g60645 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60645).yz ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60645).xz ) , break187_g60645.x);
					float4 lerpResult176_g60645 = lerp( lerpResult181_g60645 , lerpResult182_g60645 , break187_g60645.y);
					float4 Output_Fetch2D_Auto202_g60645 = lerpResult176_g60645;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g60613 = Output_Fetch2D_Auto202_g60645;
					#else
					float4 staticSwitch1061_g60613 = tex2D( _UdonRNMX0, UV0B2361_g60613 );
					#endif
					float3 appendResult146_g60660 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g60660 = dot( appendResult146_g60660 , Normal_Map318_g60660 );
					float temp_output_2_0_g60661 = saturate( dotResult122_g60660 );
					float4 Input_FetchOffsets197_g60646 = temp_output_1_34_g60643;
					float2 Input_FetchWeights200_g60646 = temp_output_1_54_g60643;
					float2 break187_g60646 = Input_FetchWeights200_g60646;
					float4 lerpResult181_g60646 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60646).yw ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60646).xw ) , break187_g60646.x);
					float4 lerpResult182_g60646 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60646).yz ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60646).xz ) , break187_g60646.x);
					float4 lerpResult176_g60646 = lerp( lerpResult181_g60646 , lerpResult182_g60646 , break187_g60646.y);
					float4 Output_Fetch2D_Auto202_g60646 = lerpResult176_g60646;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g60613 = Output_Fetch2D_Auto202_g60646;
					#else
					float4 staticSwitch1062_g60613 = tex2D( _UdonRNMY0, UV0B2361_g60613 );
					#endif
					float3 appendResult149_g60660 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g60660 = dot( appendResult149_g60660 , Normal_Map318_g60660 );
					float temp_output_2_0_g60663 = saturate( dotResult120_g60660 );
					float4 Input_FetchOffsets197_g60647 = temp_output_1_34_g60643;
					float2 Input_FetchWeights200_g60647 = temp_output_1_54_g60643;
					float2 break187_g60647 = Input_FetchWeights200_g60647;
					float4 lerpResult181_g60647 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60647).yw ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60647).xw ) , break187_g60647.x);
					float4 lerpResult182_g60647 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60647).yz ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60647).xz ) , break187_g60647.x);
					float4 lerpResult176_g60647 = lerp( lerpResult181_g60647 , lerpResult182_g60647 , break187_g60647.y);
					float4 Output_Fetch2D_Auto202_g60647 = lerpResult176_g60647;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g60613 = Output_Fetch2D_Auto202_g60647;
					#else
					float4 staticSwitch1063_g60613 = tex2D( _UdonRNMZ0, UV0B2361_g60613 );
					#endif
					float4 temp_output_24_0_g60660 = ( ( ( ( temp_output_2_0_g60662 * temp_output_2_0_g60662 ) * staticSwitch1061_g60613 ) + ( ( temp_output_2_0_g60661 * temp_output_2_0_g60661 ) * staticSwitch1062_g60613 ) ) + ( ( temp_output_2_0_g60663 * temp_output_2_0_g60663 ) * staticSwitch1063_g60613 ) );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch372_g60660 = ( temp_output_24_0_g60660 * 1.2 );
					#else
					float4 staticSwitch372_g60660 = temp_output_24_0_g60660;
					#endif
					float4 RNM_0926_g60613 = staticSwitch372_g60660;
					float3 appendResult139_g60656 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 Normal_Map318_g60656 = Normal_Map700_g60613;
					float dotResult121_g60656 = dot( appendResult139_g60656 , Normal_Map318_g60656 );
					float temp_output_2_0_g60658 = saturate( dotResult121_g60656 );
					float localStochasticTiling2_g60615 = ( 0.0 );
					float2 UV2_g60615 = UV0B2361_g60613;
					float4 TexelSize2_g60615 = _UdonRNMX1_TexelSize;
					float4 Offsets2_g60615 = float4( 0,0,0,0 );
					float2 Weights2_g60615 = float2( 0,0 );
					{
					UV2_g60615 = UV2_g60615 * TexelSize2_g60615.zw - 0.5;
					float2 f = frac( UV2_g60615 );
					UV2_g60615 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g60615.x - 0.5, UV2_g60615.x + 1.5, UV2_g60615.y - 0.5, UV2_g60615.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g60615 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60615.xyxy;
					Weights2_g60615 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g60614 = Offsets2_g60615;
					float4 Input_FetchOffsets197_g60616 = temp_output_1_34_g60614;
					float2 temp_output_1_54_g60614 = Weights2_g60615;
					float2 Input_FetchWeights200_g60616 = temp_output_1_54_g60614;
					float2 break187_g60616 = Input_FetchWeights200_g60616;
					float4 lerpResult181_g60616 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60616).yw ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60616).xw ) , break187_g60616.x);
					float4 lerpResult182_g60616 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60616).yz ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60616).xz ) , break187_g60616.x);
					float4 lerpResult176_g60616 = lerp( lerpResult181_g60616 , lerpResult182_g60616 , break187_g60616.y);
					float4 Output_Fetch2D_Auto202_g60616 = lerpResult176_g60616;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g60613 = Output_Fetch2D_Auto202_g60616;
					#else
					float4 staticSwitch1087_g60613 = tex2D( _UdonRNMX1, UV0B2361_g60613 );
					#endif
					float3 appendResult146_g60656 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g60656 = dot( appendResult146_g60656 , Normal_Map318_g60656 );
					float temp_output_2_0_g60657 = saturate( dotResult122_g60656 );
					float4 Input_FetchOffsets197_g60617 = temp_output_1_34_g60614;
					float2 Input_FetchWeights200_g60617 = temp_output_1_54_g60614;
					float2 break187_g60617 = Input_FetchWeights200_g60617;
					float4 lerpResult181_g60617 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60617).yw ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60617).xw ) , break187_g60617.x);
					float4 lerpResult182_g60617 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60617).yz ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60617).xz ) , break187_g60617.x);
					float4 lerpResult176_g60617 = lerp( lerpResult181_g60617 , lerpResult182_g60617 , break187_g60617.y);
					float4 Output_Fetch2D_Auto202_g60617 = lerpResult176_g60617;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g60613 = Output_Fetch2D_Auto202_g60617;
					#else
					float4 staticSwitch1083_g60613 = tex2D( _UdonRNMY1, UV0B2361_g60613 );
					#endif
					float3 appendResult149_g60656 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g60656 = dot( appendResult149_g60656 , Normal_Map318_g60656 );
					float temp_output_2_0_g60659 = saturate( dotResult120_g60656 );
					float4 Input_FetchOffsets197_g60618 = temp_output_1_34_g60614;
					float2 Input_FetchWeights200_g60618 = temp_output_1_54_g60614;
					float2 break187_g60618 = Input_FetchWeights200_g60618;
					float4 lerpResult181_g60618 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60618).yw ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60618).xw ) , break187_g60618.x);
					float4 lerpResult182_g60618 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60618).yz ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60618).xz ) , break187_g60618.x);
					float4 lerpResult176_g60618 = lerp( lerpResult181_g60618 , lerpResult182_g60618 , break187_g60618.y);
					float4 Output_Fetch2D_Auto202_g60618 = lerpResult176_g60618;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g60613 = Output_Fetch2D_Auto202_g60618;
					#else
					float4 staticSwitch1084_g60613 = tex2D( _UdonRNMZ1, UV0B2361_g60613 );
					#endif
					float4 temp_output_24_0_g60656 = ( ( ( ( temp_output_2_0_g60658 * temp_output_2_0_g60658 ) * staticSwitch1087_g60613 ) + ( ( temp_output_2_0_g60657 * temp_output_2_0_g60657 ) * staticSwitch1083_g60613 ) ) + ( ( temp_output_2_0_g60659 * temp_output_2_0_g60659 ) * staticSwitch1084_g60613 ) );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch372_g60656 = ( temp_output_24_0_g60656 * 1.2 );
					#else
					float4 staticSwitch372_g60656 = temp_output_24_0_g60656;
					#endif
					float4 RNM_11081_g60613 = staticSwitch372_g60656;
					float4 lerpResult953_g60613 = lerp( RNM_0926_g60613 , RNM_11081_g60613 , Lightmap_Lerp_Value969_g60613);
					float4 RNM_Lerp950_g60613 = lerpResult953_g60613;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g60613 = temp_cast_3;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g60613 = Lightmap_0925_g60613;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g60613 = Lightmap_Lerp932_g60613;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g60613 = RNM_0926_g60613;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g60613 = RNM_Lerp950_g60613;
					#else
					float4 staticSwitch1014_g60613 = temp_cast_3;
					#endif
					float3 Lightmap46_g60613 = (staticSwitch1014_g60613).rgb;
					float3 temp_output_6_0_g60664 = Lightmap46_g60613;
					float grayscale4_g60664 = Luminance( temp_output_6_0_g60664 );
					float smoothstepResult2_g60664 = smoothstep( 0.0 , 0.04 , grayscale4_g60664);
					#ifdef _USELIGHTMAPPEDREFLECTIONS_ON
					float3 staticSwitch1469_g60613 = ( temp_output_2958_0_g60613 * smoothstepResult2_g60664 );
					#else
					float3 staticSwitch1469_g60613 = temp_output_2958_0_g60613;
					#endif
					float3 Indirect_Specular1419_g60613 = staticSwitch1469_g60613;
					float3 Color97_g60665 = oAlbedo6_g60613;
					float Metallic97_g60665 = Metallic1239_g60613;
					float Smoothness97_g60665 = Smoothness1399_g60613;
					float IOR97_g60665 = IOR2700_g60613;
					float3 Fresnel97_g60665 = Fresnel1560_g60613;
					float3 Lightmap97_g60665 = Lightmap46_g60613;
					float3 WorldPos97_g60665 = World_Position2505_g60613;
					float3 WorldNormal97_g60665 = World_Normal2508_g60613;
					float3 WorldDir97_g60665 = View_Direction2511_g60613;
					float3 localDirectSpecular97_g60665 = DirectSpecular( Color97_g60665 , Metallic97_g60665 , Smoothness97_g60665 , IOR97_g60665 , Fresnel97_g60665 , Lightmap97_g60665 , WorldPos97_g60665 , WorldNormal97_g60665 , WorldDir97_g60665 );
					float3 Direct_Specular2560_g60613 = localDirectSpecular97_g60665;
					float3 aAlbedo1466_g60613 = ( temp_output_2532_0_g60613 * ( 1.0 - Metallic1239_g60613 ) );
					float3 temp_output_1252_0_g60613 = ( aAlbedo1466_g60613 * Lightmap46_g60613 );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch1_g60653 = float4( ( temp_output_1252_0_g60613 + Emission86_g60613 + Indirect_Specular1419_g60613 ) , 0.0 );
					#else
					float4 staticSwitch1_g60653 = float4( ( Emission86_g60613 + Indirect_Specular1419_g60613 + Direct_Specular2560_g60613 + temp_output_1252_0_g60613 ) , 0.0 );
					#endif
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1181_g60613 = float4( Lightmap46_g60613 , 0.0 );
					#else
					float4 staticSwitch1181_g60613 = staticSwitch1_g60653;
					#endif
					float4 Color357_g60654 = staticSwitch1181_g60613;
					float4 LUT51_g60654 = tex3D( _LUT, ( ( log10( ( ( (Color357_g60654).xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 ) );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch359_g60654 = LUT51_g60654;
					#else
					float4 staticSwitch359_g60654 = Color357_g60654;
					#endif
					

					o.Albedo = staticSwitch1180_g60613;
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

					o.Emission = staticSwitch359_g60654.xyz;
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
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;6180;0,-1280;Inherit;False;Meenphie;0;;60613;b3ba55a08dd6b49c7be16c6f35cf2033;6,1008,0,2632,0,2635,0,2619,0,2636,0,2670,0;0;5;FLOAT3;625;FLOAT4;624;FLOAT;156;FLOAT;427;FLOAT;1024
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5279;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5280;256,-1280;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;Meenphie/Standard/Opaque;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardBase;0;1;ForwardBase;17;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;44;Category;0;0;  Instanced Terrain Normals;1;0;Workflow;3;639079749420714040;Surface;0;0;  Blend;0;0;  Dither Shadows;1;0;Two Sided;1;0;Alpha Clipping;0;0;  Use Shadow Threshold;0;0;Deferred Pass;0;639079951064078170;Normal Space;0;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;0;639108440689538340;Receive Shadows;1;0;Receive Specular;0;639108440701916390;Receive Reflections;0;639108447998214750;GPU Instancing;1;0;LOD CrossFade;1;0;Built-in Fog;1;639105044169342440;Ambient Light;1;639111933610282130;Meta Pass;0;639111933576947160;Add Pass;0;639111933580732010;Override Baked GI;0;0;Write Depth;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;0;Vertex Position;1;0;0;8;False;True;False;False;False;False;True;True;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5281;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;True;1;LightMode=ForwardAdd;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5282;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5283;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5284;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5285;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5286;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ScenePickingPass;0;7;ScenePickingPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=Picking;False;False;0;;0;0;Standard;0;False;0
WireConnection;5280;0;6180;625
WireConnection;5280;2;6180;624
ASEEND*/
//CHKSM=8A2E1503DF65F22EE108F08871A6B5232793CD43