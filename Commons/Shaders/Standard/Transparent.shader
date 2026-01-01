// Made with Amplify Shader Editor v1.9.9.5
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Standard/Transparent"
{
	Properties
	{
		[Meenphie_DrawerCategory(SURFACE OPTIONS,true,0,0)] _CATEGORY_SURFACEOPTIONS( "CATEGORY_SURFACEOPTIONS", Float ) = 1
		_Color( "DIffuse Color", Color ) = ( 0.9058824, 0.9058824, 0.9058824, 1 )
		[NoScaleOffset][SingleLineTexture] _MainTex( "Diffuse Map", 2D ) = "white" {}
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
		[Gamma] _EmissionColor( "Emission Color", Color ) = ( 0, 0, 0 )
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
		[HideInInspector] GenKey__EmissionMap( "Assign keyword _EMISSIONMAP", Float ) = 1.0
		[HideInInspector] GenKey__3DLut( "Assign keyword _3DLUT", Float ) = 1.0
		[HideInInspector] GenKey__MetallicMap( "Assign keyword _METALLICMAP", Float ) = 1.0
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0
		[HideInInspector] GenKey__2DLut( "Assign keyword _2DLUT", Float ) = 1.0
		[HideInInspector] GenKey__GlossinessMap( "Assign keyword _GLOSSINESSMAP", Float ) = 1.0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}


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
		

		

		Tags { "RenderType"="Opaque" "Queue"="Transparent+1" "DisableBatching"="False" }

	LOD 0

		Cull Off
		AlphaToMask Off
		ZWrite Off
		ZTest LEqual
		ColorMask RGBA

		

		Blend Off
		

		CGINCLUDE
			#pragma target 3.5

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
				#pragma multi_compile_instancing
				#pragma multi_compile _ LOD_FADE_CROSSFADE
				#pragma multi_compile_fog
				#define ASE_FOG
				#define _SPECULARHIGHLIGHTS_OFF
				#define ASE_LIGHTING_SIMPLE 1
				#define ASE_VERSION 19905

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
				#define ASE_NEEDS_VERT_NORMAL
				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
				#define ASE_NEEDS_TEXTURE_COORDINATES2
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
				#define ASE_NEEDS_WORLD_POSITION
				#define ASE_NEEDS_FRAG_WORLD_POSITION
				#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
				#define ASE_NEEDS_WORLD_TANGENT
				#define ASE_NEEDS_FRAG_WORLD_TANGENT
				#define ASE_NEEDS_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_BITANGENT
				#pragma shader_feature _LIGHTMAPDEBUG
				#pragma shader_feature_local _STOCHASTICENABLED_ON
				#pragma shader_feature_local_fragment _METALLICMAP
				#pragma shader_feature_local _LIGHTMAPMODE_DISABLED _LIGHTMAPMODE_SIMPLE _LIGHTMAPMODE_SIMPLELERP _LIGHTMAPMODE_RNM _LIGHTMAPMODE_RNMLERP
				#pragma shader_feature_local _USEBICUBICFILTERING_ON
				#pragma shader_feature_local_fragment _BUMPMAP
				#pragma shader_feature_local_fragment _USELIGHTMAPSPECULAR_ON
				#pragma shader_feature_local_fragment _USEGEOMETRICANTIALIASING_ON
				#pragma shader_feature_local_fragment _GLOSSINESSMAP
				#pragma shader_feature_local _EMISSIONENABLED_ON
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
				uniform sampler2D _2DLut;
				uniform float _LUTSize;
				uniform sampler3D _3DLut;
				uniform float4 _Color;
				uniform sampler2D _MainTex;
				uniform float4 _MainTex_ST;
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				uniform float4 _MetallicMap_ST;
				uniform sampler2D _Lightmap0;
				uniform float4 _Lightmap0_ST;
				float4 _Lightmap0_TexelSize;
				uniform sampler2D _Lightmap1;
				uniform float4 _Lightmap1_ST;
				float4 _Lightmap1_TexelSize;
				uniform float _LIGHTMAPLERP;
				uniform sampler2D _BumpMap;
				uniform float _NormalScale;
				uniform float4 _BumpMap_ST;
				uniform sampler2D _RNMX0;
				uniform float4 _RNMX0_ST;
				float4 _RNMX0_TexelSize;
				uniform sampler2D _RNMY0;
				uniform sampler2D _RNMZ0;
				uniform sampler2D _RNMX1;
				uniform float4 _RNMX1_ST;
				float4 _RNMX1_TexelSize;
				uniform sampler2D _RNMY1;
				uniform sampler2D _RNMZ1;
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				uniform float4 _GlossinessMap_ST;
				uniform float3 _EmissionColor;
				uniform sampler2D _EmissionMap;
				uniform float4 _EmissionMap_ST;
				uniform float _EmissionIntensity;


				
				v2f VertexFunction( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					o.ase_texcoord6.xy = v.texcoord.xyzw.xy;
					o.ase_texcoord6.zw = v.texcoord2.xyzw.xy;

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = ( v.normal * -0.0001 );
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

					float2 uv_MainTex907_g65271 = IN.ase_texcoord6.xy;
					float2 uv_MainTex = IN.ase_texcoord6.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					float2 temp_output_5_0_g65287 = uv_MainTex;
					float2 UV633_g65287 = temp_output_5_0_g65287;
					float2 UV100_g65288 = UV633_g65287;
					float2 temp_output_51_0_g65288 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g65288 * float2( 3.464,3.464 ) ) );
					float2 break55_g65288 = frac( temp_output_51_0_g65288 );
					float temp_output_56_0_g65288 = ( ( 1.0 - break55_g65288.x ) - break55_g65288.y );
					float2 temp_output_52_0_g65288 = floor( temp_output_51_0_g65288 );
					float2 temp_output_125_0_g65288 = ( temp_output_52_0_g65288 + float2( 1,1 ) );
					float2 ifLocalVar87_g65288 = 0;
					if( temp_output_56_0_g65288 > 0.0 )
					ifLocalVar87_g65288 = temp_output_52_0_g65288;
					else if( temp_output_56_0_g65288 == 0.0 )
					ifLocalVar87_g65288 = temp_output_125_0_g65288;
					else if( temp_output_56_0_g65288 < 0.0 )
					ifLocalVar87_g65288 = temp_output_125_0_g65288;
					float3 temp_output_7_0_g65289 = frac( ( (ifLocalVar87_g65288).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g65289 = dot( temp_output_7_0_g65289 , ( (temp_output_7_0_g65289).yzx + 33.33 ) );
					float3 temp_output_12_0_g65289 = ( temp_output_7_0_g65289 + dotResult8_g65289 );
					float2 temp_output_597_0_g65287 = ( UV100_g65288 + frac( ( ( (temp_output_12_0_g65289).xx + (temp_output_12_0_g65289).yz ) * (temp_output_12_0_g65289).zy ) ) );
					float2 DDX631_g65287 = ddx( temp_output_5_0_g65287 );
					float2 DDY632_g65287 = ddy( temp_output_5_0_g65287 );
					float temp_output_65_0_g65288 = ( 0.0 - temp_output_56_0_g65288 );
					float ifLocalVar59_g65288 = 0;
					if( temp_output_56_0_g65288 <= 0.0 )
					ifLocalVar59_g65288 = temp_output_65_0_g65288;
					else
					ifLocalVar59_g65288 = temp_output_56_0_g65288;
					float temp_output_597_30_g65287 = ifLocalVar59_g65288;
					float2 temp_output_90_0_g65288 = ( temp_output_52_0_g65288 + float2( 0,1 ) );
					float2 temp_output_123_0_g65288 = ( temp_output_52_0_g65288 + float2( 1,0 ) );
					float2 ifLocalVar88_g65288 = 0;
					if( temp_output_56_0_g65288 > 0.0 )
					ifLocalVar88_g65288 = temp_output_90_0_g65288;
					else if( temp_output_56_0_g65288 == 0.0 )
					ifLocalVar88_g65288 = temp_output_123_0_g65288;
					else if( temp_output_56_0_g65288 < 0.0 )
					ifLocalVar88_g65288 = temp_output_123_0_g65288;
					float3 temp_output_7_0_g65290 = frac( ( (ifLocalVar88_g65288).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g65290 = dot( temp_output_7_0_g65290 , ( (temp_output_7_0_g65290).yzx + 33.33 ) );
					float3 temp_output_12_0_g65290 = ( temp_output_7_0_g65290 + dotResult8_g65290 );
					float2 temp_output_597_26_g65287 = ( UV100_g65288 + frac( ( ( (temp_output_12_0_g65290).xx + (temp_output_12_0_g65290).yz ) * (temp_output_12_0_g65290).zy ) ) );
					float temp_output_66_0_g65288 = ( 1.0 - break55_g65288.y );
					float ifLocalVar60_g65288 = 0;
					if( temp_output_56_0_g65288 <= 0.0 )
					ifLocalVar60_g65288 = temp_output_66_0_g65288;
					else
					ifLocalVar60_g65288 = break55_g65288.y;
					float temp_output_597_28_g65287 = ifLocalVar60_g65288;
					float2 ifLocalVar89_g65288 = 0;
					if( temp_output_56_0_g65288 > 0.0 )
					ifLocalVar89_g65288 = temp_output_123_0_g65288;
					else if( temp_output_56_0_g65288 == 0.0 )
					ifLocalVar89_g65288 = temp_output_90_0_g65288;
					else if( temp_output_56_0_g65288 < 0.0 )
					ifLocalVar89_g65288 = temp_output_90_0_g65288;
					float3 temp_output_7_0_g65291 = frac( ( (ifLocalVar89_g65288).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g65291 = dot( temp_output_7_0_g65291 , ( (temp_output_7_0_g65291).yzx + 33.33 ) );
					float3 temp_output_12_0_g65291 = ( temp_output_7_0_g65291 + dotResult8_g65291 );
					float2 temp_output_597_27_g65287 = ( UV100_g65288 + frac( ( ( (temp_output_12_0_g65291).xx + (temp_output_12_0_g65291).yz ) * (temp_output_12_0_g65291).zy ) ) );
					float temp_output_67_0_g65288 = ( 1.0 - break55_g65288.x );
					float ifLocalVar61_g65288 = 0;
					if( temp_output_56_0_g65288 <= 0.0 )
					ifLocalVar61_g65288 = temp_output_67_0_g65288;
					else
					ifLocalVar61_g65288 = break55_g65288.x;
					float temp_output_597_29_g65287 = ifLocalVar61_g65288;
					float4 Output_2D293_g65287 = ( ( tex2D( _MainTex, temp_output_597_0_g65287, DDX631_g65287, DDY632_g65287 ) * temp_output_597_30_g65287 ) + ( tex2D( _MainTex, temp_output_597_26_g65287, DDX631_g65287, DDY632_g65287 ) * temp_output_597_28_g65287 ) + ( tex2D( _MainTex, temp_output_597_27_g65287, DDX631_g65287, DDY632_g65287 ) * temp_output_597_29_g65287 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g65271 = Output_2D293_g65287;
					#else
					float4 staticSwitch1001_g65271 = tex2D( _MainTex, uv_MainTex907_g65271 );
					#endif
					float4 temp_output_976_0_g65271 = ( _Color * staticSwitch1001_g65271 );
					float4 oAlbedo6_g65271 = temp_output_976_0_g65271;
					float Black1185_g65271 = 0.0;
					float4 temp_cast_0 = (Black1185_g65271).xxxx;
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1180_g65271 = temp_cast_0;
					#else
					float4 staticSwitch1180_g65271 = oAlbedo6_g65271;
					#endif
					
					float2 uv_MetallicMap48_g65271 = IN.ase_texcoord6.xy;
					float2 uv_MetallicMap = IN.ase_texcoord6.xy * _MetallicMap_ST.xy + _MetallicMap_ST.zw;
					float2 temp_output_5_0_g65308 = uv_MetallicMap;
					float2 UV633_g65308 = temp_output_5_0_g65308;
					float2 UV100_g65309 = UV633_g65308;
					float2 temp_output_51_0_g65309 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g65309 * float2( 3.464,3.464 ) ) );
					float2 break55_g65309 = frac( temp_output_51_0_g65309 );
					float temp_output_56_0_g65309 = ( ( 1.0 - break55_g65309.x ) - break55_g65309.y );
					float2 temp_output_52_0_g65309 = floor( temp_output_51_0_g65309 );
					float2 temp_output_125_0_g65309 = ( temp_output_52_0_g65309 + float2( 1,1 ) );
					float2 ifLocalVar87_g65309 = 0;
					if( temp_output_56_0_g65309 > 0.0 )
					ifLocalVar87_g65309 = temp_output_52_0_g65309;
					else if( temp_output_56_0_g65309 == 0.0 )
					ifLocalVar87_g65309 = temp_output_125_0_g65309;
					else if( temp_output_56_0_g65309 < 0.0 )
					ifLocalVar87_g65309 = temp_output_125_0_g65309;
					float3 temp_output_7_0_g65310 = frac( ( (ifLocalVar87_g65309).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g65310 = dot( temp_output_7_0_g65310 , ( (temp_output_7_0_g65310).yzx + 33.33 ) );
					float3 temp_output_12_0_g65310 = ( temp_output_7_0_g65310 + dotResult8_g65310 );
					float2 temp_output_597_0_g65308 = ( UV100_g65309 + frac( ( ( (temp_output_12_0_g65310).xx + (temp_output_12_0_g65310).yz ) * (temp_output_12_0_g65310).zy ) ) );
					float2 DDX631_g65308 = ddx( temp_output_5_0_g65308 );
					float2 DDY632_g65308 = ddy( temp_output_5_0_g65308 );
					float temp_output_65_0_g65309 = ( 0.0 - temp_output_56_0_g65309 );
					float ifLocalVar59_g65309 = 0;
					if( temp_output_56_0_g65309 <= 0.0 )
					ifLocalVar59_g65309 = temp_output_65_0_g65309;
					else
					ifLocalVar59_g65309 = temp_output_56_0_g65309;
					float temp_output_597_30_g65308 = ifLocalVar59_g65309;
					float2 temp_output_90_0_g65309 = ( temp_output_52_0_g65309 + float2( 0,1 ) );
					float2 temp_output_123_0_g65309 = ( temp_output_52_0_g65309 + float2( 1,0 ) );
					float2 ifLocalVar88_g65309 = 0;
					if( temp_output_56_0_g65309 > 0.0 )
					ifLocalVar88_g65309 = temp_output_90_0_g65309;
					else if( temp_output_56_0_g65309 == 0.0 )
					ifLocalVar88_g65309 = temp_output_123_0_g65309;
					else if( temp_output_56_0_g65309 < 0.0 )
					ifLocalVar88_g65309 = temp_output_123_0_g65309;
					float3 temp_output_7_0_g65311 = frac( ( (ifLocalVar88_g65309).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g65311 = dot( temp_output_7_0_g65311 , ( (temp_output_7_0_g65311).yzx + 33.33 ) );
					float3 temp_output_12_0_g65311 = ( temp_output_7_0_g65311 + dotResult8_g65311 );
					float2 temp_output_597_26_g65308 = ( UV100_g65309 + frac( ( ( (temp_output_12_0_g65311).xx + (temp_output_12_0_g65311).yz ) * (temp_output_12_0_g65311).zy ) ) );
					float temp_output_66_0_g65309 = ( 1.0 - break55_g65309.y );
					float ifLocalVar60_g65309 = 0;
					if( temp_output_56_0_g65309 <= 0.0 )
					ifLocalVar60_g65309 = temp_output_66_0_g65309;
					else
					ifLocalVar60_g65309 = break55_g65309.y;
					float temp_output_597_28_g65308 = ifLocalVar60_g65309;
					float2 ifLocalVar89_g65309 = 0;
					if( temp_output_56_0_g65309 > 0.0 )
					ifLocalVar89_g65309 = temp_output_123_0_g65309;
					else if( temp_output_56_0_g65309 == 0.0 )
					ifLocalVar89_g65309 = temp_output_90_0_g65309;
					else if( temp_output_56_0_g65309 < 0.0 )
					ifLocalVar89_g65309 = temp_output_90_0_g65309;
					float3 temp_output_7_0_g65312 = frac( ( (ifLocalVar89_g65309).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g65312 = dot( temp_output_7_0_g65312 , ( (temp_output_7_0_g65312).yzx + 33.33 ) );
					float3 temp_output_12_0_g65312 = ( temp_output_7_0_g65312 + dotResult8_g65312 );
					float2 temp_output_597_27_g65308 = ( UV100_g65309 + frac( ( ( (temp_output_12_0_g65312).xx + (temp_output_12_0_g65312).yz ) * (temp_output_12_0_g65312).zy ) ) );
					float temp_output_67_0_g65309 = ( 1.0 - break55_g65309.x );
					float ifLocalVar61_g65309 = 0;
					if( temp_output_56_0_g65309 <= 0.0 )
					ifLocalVar61_g65309 = temp_output_67_0_g65309;
					else
					ifLocalVar61_g65309 = break55_g65309.x;
					float temp_output_597_29_g65308 = ifLocalVar61_g65309;
					float4 Output_2D293_g65308 = ( ( tex2D( _MetallicMap, temp_output_597_0_g65308, DDX631_g65308, DDY632_g65308 ) * temp_output_597_30_g65308 ) + ( tex2D( _MetallicMap, temp_output_597_26_g65308, DDX631_g65308, DDY632_g65308 ) * temp_output_597_28_g65308 ) + ( tex2D( _MetallicMap, temp_output_597_27_g65308, DDX631_g65308, DDY632_g65308 ) * temp_output_597_29_g65308 ) );
					float4 break31_g65308 = Output_2D293_g65308;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g65271 = break31_g65308.a;
					#else
					float staticSwitch1005_g65271 = tex2D( _MetallicMap, uv_MetallicMap48_g65271 ).a;
					#endif
					#ifdef _METALLICMAP
					float staticSwitch846_g65271 = staticSwitch1005_g65271;
					#else
					float staticSwitch846_g65271 = _Metallic;
					#endif
					float Metallic1239_g65271 = staticSwitch846_g65271;
					float4 aAlbedo1466_g65271 = ( temp_output_976_0_g65271 * ( 1.0 - Metallic1239_g65271 ) );
					float White38_g65271 = 1.0;
					float4 temp_cast_2 = (White38_g65271).xxxx;
					float2 texCoord1093_g65271 = IN.ase_texcoord6.zw * float2( 1,1 ) + float2( 0,0 );
					float localBicubicPrepare2_g65300 = ( 0.0 );
					float2 uv3_Lightmap0 = IN.ase_texcoord6.zw * _Lightmap0_ST.xy + _Lightmap0_ST.zw;
					float2 Input_UV100_g65300 = uv3_Lightmap0;
					float2 UV2_g65300 = Input_UV100_g65300;
					float4 TexelSize2_g65300 = _Lightmap0_TexelSize;
					float2 UV02_g65300 = float2( 0,0 );
					float2 UV12_g65300 = float2( 0,0 );
					float2 UV22_g65300 = float2( 0,0 );
					float2 UV32_g65300 = float2( 0,0 );
					float W02_g65300 = 0;
					float W12_g65300 = 0;
					{
					{
					 UV2_g65300 = UV2_g65300 * TexelSize2_g65300.zw - 0.5;
					    float2 f = frac( UV2_g65300 );
					    UV2_g65300 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g65300.x - 0.5, UV2_g65300.x + 1.5, UV2_g65300.y - 0.5, UV2_g65300.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g65300.xyxy;
					    UV02_g65300 = off.xz;
					    UV12_g65300 = off.yz;
					    UV22_g65300 = off.xw;
					    UV32_g65300 = off.yw;
					    W02_g65300 = s.x / ( s.x + s.y );
					 W12_g65300 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g65300 = lerp( tex2D( _Lightmap0, UV32_g65300 ) , tex2D( _Lightmap0, UV22_g65300 ) , W02_g65300);
					float4 lerpResult45_g65300 = lerp( tex2D( _Lightmap0, UV12_g65300 ) , tex2D( _Lightmap0, UV02_g65300 ) , W02_g65300);
					float4 lerpResult44_g65300 = lerp( lerpResult46_g65300 , lerpResult45_g65300 , W12_g65300);
					float4 Output_2D131_g65300 = lerpResult44_g65300;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g65271 = Output_2D131_g65300;
					#else
					float4 staticSwitch1092_g65271 = tex2D( _Lightmap0, texCoord1093_g65271 );
					#endif
					float4 Lightmap_0925_g65271 = staticSwitch1092_g65271;
					float2 texCoord1090_g65271 = IN.ase_texcoord6.zw * float2( 1,1 ) + float2( 0,0 );
					float localBicubicPrepare2_g65298 = ( 0.0 );
					float2 uv3_Lightmap1 = IN.ase_texcoord6.zw * _Lightmap1_ST.xy + _Lightmap1_ST.zw;
					float2 Input_UV100_g65298 = uv3_Lightmap1;
					float2 UV2_g65298 = Input_UV100_g65298;
					float4 TexelSize2_g65298 = _Lightmap1_TexelSize;
					float2 UV02_g65298 = float2( 0,0 );
					float2 UV12_g65298 = float2( 0,0 );
					float2 UV22_g65298 = float2( 0,0 );
					float2 UV32_g65298 = float2( 0,0 );
					float W02_g65298 = 0;
					float W12_g65298 = 0;
					{
					{
					 UV2_g65298 = UV2_g65298 * TexelSize2_g65298.zw - 0.5;
					    float2 f = frac( UV2_g65298 );
					    UV2_g65298 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g65298.x - 0.5, UV2_g65298.x + 1.5, UV2_g65298.y - 0.5, UV2_g65298.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g65298.xyxy;
					    UV02_g65298 = off.xz;
					    UV12_g65298 = off.yz;
					    UV22_g65298 = off.xw;
					    UV32_g65298 = off.yw;
					    W02_g65298 = s.x / ( s.x + s.y );
					 W12_g65298 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g65298 = lerp( tex2D( _Lightmap1, UV32_g65298 ) , tex2D( _Lightmap1, UV22_g65298 ) , W02_g65298);
					float4 lerpResult45_g65298 = lerp( tex2D( _Lightmap1, UV12_g65298 ) , tex2D( _Lightmap1, UV02_g65298 ) , W02_g65298);
					float4 lerpResult44_g65298 = lerp( lerpResult46_g65298 , lerpResult45_g65298 , W12_g65298);
					float4 Output_2D131_g65298 = lerpResult44_g65298;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g65271 = Output_2D131_g65298;
					#else
					float4 staticSwitch1088_g65271 = tex2D( _Lightmap1, texCoord1090_g65271 );
					#endif
					float4 Lightmap_1956_g65271 = staticSwitch1088_g65271;
					float4 lerpResult442_g65271 = lerp( Lightmap_0925_g65271 , Lightmap_1956_g65271 , _LIGHTMAPLERP);
					float4 Lightmap_Lerp932_g65271 = lerpResult442_g65271;
					float3 appendResult139_g65307 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float2 uv_BumpMap830_g65271 = IN.ase_texcoord6.xy;
					float2 uv_BumpMap = IN.ase_texcoord6.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					float2 temp_output_5_0_g65282 = uv_BumpMap;
					float2 UV633_g65282 = temp_output_5_0_g65282;
					float2 UV100_g65283 = UV633_g65282;
					float2 temp_output_51_0_g65283 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g65283 * float2( 3.464,3.464 ) ) );
					float2 break55_g65283 = frac( temp_output_51_0_g65283 );
					float temp_output_56_0_g65283 = ( ( 1.0 - break55_g65283.x ) - break55_g65283.y );
					float2 temp_output_52_0_g65283 = floor( temp_output_51_0_g65283 );
					float2 temp_output_125_0_g65283 = ( temp_output_52_0_g65283 + float2( 1,1 ) );
					float2 ifLocalVar87_g65283 = 0;
					if( temp_output_56_0_g65283 > 0.0 )
					ifLocalVar87_g65283 = temp_output_52_0_g65283;
					else if( temp_output_56_0_g65283 == 0.0 )
					ifLocalVar87_g65283 = temp_output_125_0_g65283;
					else if( temp_output_56_0_g65283 < 0.0 )
					ifLocalVar87_g65283 = temp_output_125_0_g65283;
					float3 temp_output_7_0_g65284 = frac( ( (ifLocalVar87_g65283).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g65284 = dot( temp_output_7_0_g65284 , ( (temp_output_7_0_g65284).yzx + 33.33 ) );
					float3 temp_output_12_0_g65284 = ( temp_output_7_0_g65284 + dotResult8_g65284 );
					float2 temp_output_597_0_g65282 = ( UV100_g65283 + frac( ( ( (temp_output_12_0_g65284).xx + (temp_output_12_0_g65284).yz ) * (temp_output_12_0_g65284).zy ) ) );
					float2 DDX631_g65282 = ddx( temp_output_5_0_g65282 );
					float2 DDY632_g65282 = ddy( temp_output_5_0_g65282 );
					float Input_Scale617_g65282 = _NormalScale;
					float temp_output_65_0_g65283 = ( 0.0 - temp_output_56_0_g65283 );
					float ifLocalVar59_g65283 = 0;
					if( temp_output_56_0_g65283 <= 0.0 )
					ifLocalVar59_g65283 = temp_output_65_0_g65283;
					else
					ifLocalVar59_g65283 = temp_output_56_0_g65283;
					float temp_output_597_30_g65282 = ifLocalVar59_g65283;
					float2 temp_output_90_0_g65283 = ( temp_output_52_0_g65283 + float2( 0,1 ) );
					float2 temp_output_123_0_g65283 = ( temp_output_52_0_g65283 + float2( 1,0 ) );
					float2 ifLocalVar88_g65283 = 0;
					if( temp_output_56_0_g65283 > 0.0 )
					ifLocalVar88_g65283 = temp_output_90_0_g65283;
					else if( temp_output_56_0_g65283 == 0.0 )
					ifLocalVar88_g65283 = temp_output_123_0_g65283;
					else if( temp_output_56_0_g65283 < 0.0 )
					ifLocalVar88_g65283 = temp_output_123_0_g65283;
					float3 temp_output_7_0_g65285 = frac( ( (ifLocalVar88_g65283).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g65285 = dot( temp_output_7_0_g65285 , ( (temp_output_7_0_g65285).yzx + 33.33 ) );
					float3 temp_output_12_0_g65285 = ( temp_output_7_0_g65285 + dotResult8_g65285 );
					float2 temp_output_597_26_g65282 = ( UV100_g65283 + frac( ( ( (temp_output_12_0_g65285).xx + (temp_output_12_0_g65285).yz ) * (temp_output_12_0_g65285).zy ) ) );
					float temp_output_66_0_g65283 = ( 1.0 - break55_g65283.y );
					float ifLocalVar60_g65283 = 0;
					if( temp_output_56_0_g65283 <= 0.0 )
					ifLocalVar60_g65283 = temp_output_66_0_g65283;
					else
					ifLocalVar60_g65283 = break55_g65283.y;
					float temp_output_597_28_g65282 = ifLocalVar60_g65283;
					float2 ifLocalVar89_g65283 = 0;
					if( temp_output_56_0_g65283 > 0.0 )
					ifLocalVar89_g65283 = temp_output_123_0_g65283;
					else if( temp_output_56_0_g65283 == 0.0 )
					ifLocalVar89_g65283 = temp_output_90_0_g65283;
					else if( temp_output_56_0_g65283 < 0.0 )
					ifLocalVar89_g65283 = temp_output_90_0_g65283;
					float3 temp_output_7_0_g65286 = frac( ( (ifLocalVar89_g65283).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g65286 = dot( temp_output_7_0_g65286 , ( (temp_output_7_0_g65286).yzx + 33.33 ) );
					float3 temp_output_12_0_g65286 = ( temp_output_7_0_g65286 + dotResult8_g65286 );
					float2 temp_output_597_27_g65282 = ( UV100_g65283 + frac( ( ( (temp_output_12_0_g65286).xx + (temp_output_12_0_g65286).yz ) * (temp_output_12_0_g65286).zy ) ) );
					float temp_output_67_0_g65283 = ( 1.0 - break55_g65283.x );
					float ifLocalVar61_g65283 = 0;
					if( temp_output_56_0_g65283 <= 0.0 )
					ifLocalVar61_g65283 = temp_output_67_0_g65283;
					else
					ifLocalVar61_g65283 = break55_g65283.x;
					float temp_output_597_29_g65282 = ifLocalVar61_g65283;
					float3 Output_2D_Normal641_g65282 = ( ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_0_g65282, DDX631_g65282, DDY632_g65282 ), Input_Scale617_g65282 ) * temp_output_597_30_g65282 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_26_g65282, DDX631_g65282, DDY632_g65282 ), Input_Scale617_g65282 ) * temp_output_597_28_g65282 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_27_g65282, DDX631_g65282, DDY632_g65282 ), Input_Scale617_g65282 ) * float3( 0,0,0 ) * temp_output_597_29_g65282 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g65271 = Output_2D_Normal641_g65282;
					#else
					float3 staticSwitch1003_g65271 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap830_g65271 ), _NormalScale );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g65271 = staticSwitch1003_g65271;
					#else
					float3 staticSwitch980_g65271 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g65271 = staticSwitch980_g65271;
					float3 normalizeResult326_g65307 = normalize( Normal_Map700_g65271 );
					float3 Normal_Map318_g65307 = normalizeResult326_g65307;
					float dotResult121_g65307 = dot( appendResult139_g65307 , Normal_Map318_g65307 );
					float2 texCoord1070_g65271 = IN.ase_texcoord6.zw * float2( 1,1 ) + float2( 0,0 );
					float localStochasticTiling2_g65302 = ( 0.0 );
					float2 uv3_RNMX0 = IN.ase_texcoord6.zw * _RNMX0_ST.xy + _RNMX0_ST.zw;
					float2 UV2_g65302 = uv3_RNMX0;
					float4 TexelSize2_g65302 = _RNMX0_TexelSize;
					float4 Offsets2_g65302 = float4( 0,0,0,0 );
					float2 Weights2_g65302 = float2( 0,0 );
					{
					UV2_g65302 = UV2_g65302 * TexelSize2_g65302.zw - 0.5;
					float2 f = frac( UV2_g65302 );
					UV2_g65302 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g65302.x - 0.5, UV2_g65302.x + 1.5, UV2_g65302.y - 0.5, UV2_g65302.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g65302 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g65302.xyxy;
					Weights2_g65302 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g65301 = Offsets2_g65302;
					float4 Input_FetchOffsets197_g65305 = temp_output_1_34_g65301;
					float2 temp_output_1_54_g65301 = Weights2_g65302;
					float2 Input_FetchWeights200_g65305 = temp_output_1_54_g65301;
					float2 break187_g65305 = Input_FetchWeights200_g65305;
					float4 lerpResult181_g65305 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g65305).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g65305).xw ) , break187_g65305.x);
					float4 lerpResult182_g65305 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g65305).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g65305).xz ) , break187_g65305.x);
					float4 lerpResult176_g65305 = lerp( lerpResult181_g65305 , lerpResult182_g65305 , break187_g65305.y);
					float4 Output_Fetch2D202_g65305 = lerpResult176_g65305;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g65271 = Output_Fetch2D202_g65305;
					#else
					float4 staticSwitch1061_g65271 = tex2D( _RNMX0, texCoord1070_g65271 );
					#endif
					float3 appendResult146_g65307 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g65307 = dot( appendResult146_g65307 , Normal_Map318_g65307 );
					float4 Input_FetchOffsets197_g65303 = temp_output_1_34_g65301;
					float2 Input_FetchWeights200_g65303 = temp_output_1_54_g65301;
					float2 break187_g65303 = Input_FetchWeights200_g65303;
					float4 lerpResult181_g65303 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g65303).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g65303).xw ) , break187_g65303.x);
					float4 lerpResult182_g65303 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g65303).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g65303).xz ) , break187_g65303.x);
					float4 lerpResult176_g65303 = lerp( lerpResult181_g65303 , lerpResult182_g65303 , break187_g65303.y);
					float4 Output_Fetch2D202_g65303 = lerpResult176_g65303;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g65271 = Output_Fetch2D202_g65303;
					#else
					float4 staticSwitch1062_g65271 = tex2D( _RNMY0, texCoord1070_g65271 );
					#endif
					float3 appendResult149_g65307 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g65307 = dot( appendResult149_g65307 , Normal_Map318_g65307 );
					float4 Input_FetchOffsets197_g65304 = temp_output_1_34_g65301;
					float2 Input_FetchWeights200_g65304 = temp_output_1_54_g65301;
					float2 break187_g65304 = Input_FetchWeights200_g65304;
					float4 lerpResult181_g65304 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g65304).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g65304).xw ) , break187_g65304.x);
					float4 lerpResult182_g65304 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g65304).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g65304).xz ) , break187_g65304.x);
					float4 lerpResult176_g65304 = lerp( lerpResult181_g65304 , lerpResult182_g65304 , break187_g65304.y);
					float4 Output_Fetch2D202_g65304 = lerpResult176_g65304;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g65271 = Output_Fetch2D202_g65304;
					#else
					float4 staticSwitch1063_g65271 = tex2D( _RNMZ0, texCoord1070_g65271 );
					#endif
					float4 RNM_0926_g65271 = ( ( ( saturate( dotResult121_g65307 ) * ( staticSwitch1061_g65271 * 0.33334 ) ) + ( saturate( dotResult122_g65307 ) * ( staticSwitch1062_g65271 * 0.33334 ) ) ) + ( saturate( dotResult120_g65307 ) * ( staticSwitch1063_g65271 * 0.33334 ) ) );
					float3 appendResult139_g65306 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g65306 = normalize( Normal_Map700_g65271 );
					float3 Normal_Map318_g65306 = normalizeResult326_g65306;
					float dotResult121_g65306 = dot( appendResult139_g65306 , Normal_Map318_g65306 );
					float2 texCoord1086_g65271 = IN.ase_texcoord6.zw * float2( 1,1 ) + float2( 0,0 );
					float localStochasticTiling2_g65293 = ( 0.0 );
					float2 uv3_RNMX1 = IN.ase_texcoord6.zw * _RNMX1_ST.xy + _RNMX1_ST.zw;
					float2 UV2_g65293 = uv3_RNMX1;
					float4 TexelSize2_g65293 = _RNMX1_TexelSize;
					float4 Offsets2_g65293 = float4( 0,0,0,0 );
					float2 Weights2_g65293 = float2( 0,0 );
					{
					UV2_g65293 = UV2_g65293 * TexelSize2_g65293.zw - 0.5;
					float2 f = frac( UV2_g65293 );
					UV2_g65293 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g65293.x - 0.5, UV2_g65293.x + 1.5, UV2_g65293.y - 0.5, UV2_g65293.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g65293 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g65293.xyxy;
					Weights2_g65293 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g65292 = Offsets2_g65293;
					float4 Input_FetchOffsets197_g65296 = temp_output_1_34_g65292;
					float2 temp_output_1_54_g65292 = Weights2_g65293;
					float2 Input_FetchWeights200_g65296 = temp_output_1_54_g65292;
					float2 break187_g65296 = Input_FetchWeights200_g65296;
					float4 lerpResult181_g65296 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g65296).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g65296).xw ) , break187_g65296.x);
					float4 lerpResult182_g65296 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g65296).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g65296).xz ) , break187_g65296.x);
					float4 lerpResult176_g65296 = lerp( lerpResult181_g65296 , lerpResult182_g65296 , break187_g65296.y);
					float4 Output_Fetch2D202_g65296 = lerpResult176_g65296;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g65271 = Output_Fetch2D202_g65296;
					#else
					float4 staticSwitch1087_g65271 = tex2D( _RNMX1, texCoord1086_g65271 );
					#endif
					float3 appendResult146_g65306 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g65306 = dot( appendResult146_g65306 , Normal_Map318_g65306 );
					float4 Input_FetchOffsets197_g65294 = temp_output_1_34_g65292;
					float2 Input_FetchWeights200_g65294 = temp_output_1_54_g65292;
					float2 break187_g65294 = Input_FetchWeights200_g65294;
					float4 lerpResult181_g65294 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g65294).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g65294).xw ) , break187_g65294.x);
					float4 lerpResult182_g65294 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g65294).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g65294).xz ) , break187_g65294.x);
					float4 lerpResult176_g65294 = lerp( lerpResult181_g65294 , lerpResult182_g65294 , break187_g65294.y);
					float4 Output_Fetch2D202_g65294 = lerpResult176_g65294;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g65271 = Output_Fetch2D202_g65294;
					#else
					float4 staticSwitch1083_g65271 = tex2D( _RNMY1, texCoord1086_g65271 );
					#endif
					float3 appendResult149_g65306 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g65306 = dot( appendResult149_g65306 , Normal_Map318_g65306 );
					float4 Input_FetchOffsets197_g65295 = temp_output_1_34_g65292;
					float2 Input_FetchWeights200_g65295 = temp_output_1_54_g65292;
					float2 break187_g65295 = Input_FetchWeights200_g65295;
					float4 lerpResult181_g65295 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g65295).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g65295).xw ) , break187_g65295.x);
					float4 lerpResult182_g65295 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g65295).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g65295).xz ) , break187_g65295.x);
					float4 lerpResult176_g65295 = lerp( lerpResult181_g65295 , lerpResult182_g65295 , break187_g65295.y);
					float4 Output_Fetch2D202_g65295 = lerpResult176_g65295;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g65271 = Output_Fetch2D202_g65295;
					#else
					float4 staticSwitch1084_g65271 = tex2D( _RNMZ1, texCoord1086_g65271 );
					#endif
					float4 RNM_11081_g65271 = ( ( ( saturate( dotResult121_g65306 ) * ( staticSwitch1087_g65271 * 0.33334 ) ) + ( saturate( dotResult122_g65306 ) * ( staticSwitch1083_g65271 * 0.33334 ) ) ) + ( saturate( dotResult120_g65306 ) * ( staticSwitch1084_g65271 * 0.33334 ) ) );
					float Lightmap_Lerp_Value969_g65271 = _LIGHTMAPLERP;
					float4 lerpResult953_g65271 = lerp( RNM_0926_g65271 , RNM_11081_g65271 , Lightmap_Lerp_Value969_g65271);
					float4 RNM_Lerp950_g65271 = lerpResult953_g65271;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g65271 = temp_cast_2;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g65271 = Lightmap_0925_g65271;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g65271 = Lightmap_Lerp932_g65271;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g65271 = RNM_0926_g65271;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g65271 = RNM_Lerp950_g65271;
					#else
					float4 staticSwitch1014_g65271 = temp_cast_2;
					#endif
					float4 Lightmap46_g65271 = staticSwitch1014_g65271;
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal1392_g65271 = Normal_Map700_g65271;
					float2 uv_GlossinessMap64_g65271 = IN.ase_texcoord6.xy;
					float2 uv_GlossinessMap = IN.ase_texcoord6.xy * _GlossinessMap_ST.xy + _GlossinessMap_ST.zw;
					float2 temp_output_5_0_g65277 = uv_GlossinessMap;
					float2 UV633_g65277 = temp_output_5_0_g65277;
					float2 UV100_g65278 = UV633_g65277;
					float2 temp_output_51_0_g65278 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g65278 * float2( 3.464,3.464 ) ) );
					float2 break55_g65278 = frac( temp_output_51_0_g65278 );
					float temp_output_56_0_g65278 = ( ( 1.0 - break55_g65278.x ) - break55_g65278.y );
					float2 temp_output_52_0_g65278 = floor( temp_output_51_0_g65278 );
					float2 temp_output_125_0_g65278 = ( temp_output_52_0_g65278 + float2( 1,1 ) );
					float2 ifLocalVar87_g65278 = 0;
					if( temp_output_56_0_g65278 > 0.0 )
					ifLocalVar87_g65278 = temp_output_52_0_g65278;
					else if( temp_output_56_0_g65278 == 0.0 )
					ifLocalVar87_g65278 = temp_output_125_0_g65278;
					else if( temp_output_56_0_g65278 < 0.0 )
					ifLocalVar87_g65278 = temp_output_125_0_g65278;
					float3 temp_output_7_0_g65279 = frac( ( (ifLocalVar87_g65278).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g65279 = dot( temp_output_7_0_g65279 , ( (temp_output_7_0_g65279).yzx + 33.33 ) );
					float3 temp_output_12_0_g65279 = ( temp_output_7_0_g65279 + dotResult8_g65279 );
					float2 temp_output_597_0_g65277 = ( UV100_g65278 + frac( ( ( (temp_output_12_0_g65279).xx + (temp_output_12_0_g65279).yz ) * (temp_output_12_0_g65279).zy ) ) );
					float2 DDX631_g65277 = ddx( temp_output_5_0_g65277 );
					float2 DDY632_g65277 = ddy( temp_output_5_0_g65277 );
					float temp_output_65_0_g65278 = ( 0.0 - temp_output_56_0_g65278 );
					float ifLocalVar59_g65278 = 0;
					if( temp_output_56_0_g65278 <= 0.0 )
					ifLocalVar59_g65278 = temp_output_65_0_g65278;
					else
					ifLocalVar59_g65278 = temp_output_56_0_g65278;
					float temp_output_597_30_g65277 = ifLocalVar59_g65278;
					float2 temp_output_90_0_g65278 = ( temp_output_52_0_g65278 + float2( 0,1 ) );
					float2 temp_output_123_0_g65278 = ( temp_output_52_0_g65278 + float2( 1,0 ) );
					float2 ifLocalVar88_g65278 = 0;
					if( temp_output_56_0_g65278 > 0.0 )
					ifLocalVar88_g65278 = temp_output_90_0_g65278;
					else if( temp_output_56_0_g65278 == 0.0 )
					ifLocalVar88_g65278 = temp_output_123_0_g65278;
					else if( temp_output_56_0_g65278 < 0.0 )
					ifLocalVar88_g65278 = temp_output_123_0_g65278;
					float3 temp_output_7_0_g65280 = frac( ( (ifLocalVar88_g65278).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g65280 = dot( temp_output_7_0_g65280 , ( (temp_output_7_0_g65280).yzx + 33.33 ) );
					float3 temp_output_12_0_g65280 = ( temp_output_7_0_g65280 + dotResult8_g65280 );
					float2 temp_output_597_26_g65277 = ( UV100_g65278 + frac( ( ( (temp_output_12_0_g65280).xx + (temp_output_12_0_g65280).yz ) * (temp_output_12_0_g65280).zy ) ) );
					float temp_output_66_0_g65278 = ( 1.0 - break55_g65278.y );
					float ifLocalVar60_g65278 = 0;
					if( temp_output_56_0_g65278 <= 0.0 )
					ifLocalVar60_g65278 = temp_output_66_0_g65278;
					else
					ifLocalVar60_g65278 = break55_g65278.y;
					float temp_output_597_28_g65277 = ifLocalVar60_g65278;
					float2 ifLocalVar89_g65278 = 0;
					if( temp_output_56_0_g65278 > 0.0 )
					ifLocalVar89_g65278 = temp_output_123_0_g65278;
					else if( temp_output_56_0_g65278 == 0.0 )
					ifLocalVar89_g65278 = temp_output_90_0_g65278;
					else if( temp_output_56_0_g65278 < 0.0 )
					ifLocalVar89_g65278 = temp_output_90_0_g65278;
					float3 temp_output_7_0_g65281 = frac( ( (ifLocalVar89_g65278).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g65281 = dot( temp_output_7_0_g65281 , ( (temp_output_7_0_g65281).yzx + 33.33 ) );
					float3 temp_output_12_0_g65281 = ( temp_output_7_0_g65281 + dotResult8_g65281 );
					float2 temp_output_597_27_g65277 = ( UV100_g65278 + frac( ( ( (temp_output_12_0_g65281).xx + (temp_output_12_0_g65281).yz ) * (temp_output_12_0_g65281).zy ) ) );
					float temp_output_67_0_g65278 = ( 1.0 - break55_g65278.x );
					float ifLocalVar61_g65278 = 0;
					if( temp_output_56_0_g65278 <= 0.0 )
					ifLocalVar61_g65278 = temp_output_67_0_g65278;
					else
					ifLocalVar61_g65278 = break55_g65278.x;
					float temp_output_597_29_g65277 = ifLocalVar61_g65278;
					float4 Output_2D293_g65277 = ( ( tex2D( _GlossinessMap, temp_output_597_0_g65277, DDX631_g65277, DDY632_g65277 ) * temp_output_597_30_g65277 ) + ( tex2D( _GlossinessMap, temp_output_597_26_g65277, DDX631_g65277, DDY632_g65277 ) * temp_output_597_28_g65277 ) + ( tex2D( _GlossinessMap, temp_output_597_27_g65277, DDX631_g65277, DDY632_g65277 ) * temp_output_597_29_g65277 ) );
					float4 break31_g65277 = Output_2D293_g65277;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g65271 = break31_g65277.a;
					#else
					float staticSwitch1004_g65271 = tex2D( _GlossinessMap, uv_GlossinessMap64_g65271 ).a;
					#endif
					float saferPower804_g65271 = abs( staticSwitch1004_g65271 );
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g65271 = ( 1.0 - pow( saferPower804_g65271 , 3.0 ) );
					#else
					float staticSwitch845_g65271 = _Glossiness;
					#endif
					float3 temp_output_3_0_g65315 = ddx( NormalWS );
					float dotResult5_g65315 = dot( temp_output_3_0_g65315 , temp_output_3_0_g65315 );
					float3 temp_output_4_0_g65315 = ddy( NormalWS );
					float dotResult6_g65315 = dot( temp_output_4_0_g65315 , temp_output_4_0_g65315 );
					#ifdef _USEGEOMETRICANTIALIASING_ON
					float staticSwitch824_g65271 = min( staticSwitch845_g65271 , ( 1.0 - pow( saturate( max( dotResult5_g65315 , dotResult6_g65315 ) ) , 0.333 ) ) );
					#else
					float staticSwitch824_g65271 = staticSwitch845_g65271;
					#endif
					float Smoothness1399_g65271 = staticSwitch824_g65271;
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
					Unity_GlossyEnvironmentData g1392_g65271 = UnityGlossyEnvironmentSetup( Smoothness1399_g65271, ViewDirWS, float3( dot( tanToWorld0, tanNormal1392_g65271 ), dot( tanToWorld1, tanNormal1392_g65271 ), dot( tanToWorld2, tanNormal1392_g65271 ) ), float3(0,0,0));
					float3 indirectSpecular1392_g65271 = UnityGI_IndirectSpecular( data, 1.0, float3( dot( tanToWorld0, tanNormal1392_g65271 ), dot( tanToWorld1, tanNormal1392_g65271 ), dot( tanToWorld2, tanNormal1392_g65271 ) ), g1392_g65271 );
					float4 temp_cast_4 = (0.04).xxxx;
					float4 lerpResult1473_g65271 = lerp( temp_cast_4 , oAlbedo6_g65271 , Metallic1239_g65271);
					float3 switchResult1501_g65271 = (((ase_vface>0)?(NormalWS):(-NormalWS)));
					float dotResult1476_g65271 = dot( switchResult1501_g65271 , ViewDirWS );
					float4 lerpResult1480_g65271 = lerp( lerpResult1473_g65271 , float4( 1,1,1,0 ) , pow( ( 1.0 - saturate( dotResult1476_g65271 ) ) , 5.0 ));
					float4 temp_output_1481_0_g65271 = ( float4( indirectSpecular1392_g65271 , 0.0 ) * lerpResult1480_g65271 );
					#ifdef _USELIGHTMAPSPECULAR_ON
					float4 staticSwitch1469_g65271 = ( temp_output_1481_0_g65271 * Lightmap46_g65271 );
					#else
					float4 staticSwitch1469_g65271 = temp_output_1481_0_g65271;
					#endif
					float4 Specular1419_g65271 = staticSwitch1469_g65271;
					float4 temp_cast_5 = 0;
					float2 uv_EmissionMap81_g65271 = IN.ase_texcoord6.xy;
					float2 uv_EmissionMap = IN.ase_texcoord6.xy * _EmissionMap_ST.xy + _EmissionMap_ST.zw;
					float2 temp_output_5_0_g65272 = uv_EmissionMap;
					float2 UV633_g65272 = temp_output_5_0_g65272;
					float2 UV100_g65273 = UV633_g65272;
					float2 temp_output_51_0_g65273 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g65273 * float2( 3.464,3.464 ) ) );
					float2 break55_g65273 = frac( temp_output_51_0_g65273 );
					float temp_output_56_0_g65273 = ( ( 1.0 - break55_g65273.x ) - break55_g65273.y );
					float2 temp_output_52_0_g65273 = floor( temp_output_51_0_g65273 );
					float2 temp_output_125_0_g65273 = ( temp_output_52_0_g65273 + float2( 1,1 ) );
					float2 ifLocalVar87_g65273 = 0;
					if( temp_output_56_0_g65273 > 0.0 )
					ifLocalVar87_g65273 = temp_output_52_0_g65273;
					else if( temp_output_56_0_g65273 == 0.0 )
					ifLocalVar87_g65273 = temp_output_125_0_g65273;
					else if( temp_output_56_0_g65273 < 0.0 )
					ifLocalVar87_g65273 = temp_output_125_0_g65273;
					float3 temp_output_7_0_g65274 = frac( ( (ifLocalVar87_g65273).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g65274 = dot( temp_output_7_0_g65274 , ( (temp_output_7_0_g65274).yzx + 33.33 ) );
					float3 temp_output_12_0_g65274 = ( temp_output_7_0_g65274 + dotResult8_g65274 );
					float2 temp_output_597_0_g65272 = ( UV100_g65273 + frac( ( ( (temp_output_12_0_g65274).xx + (temp_output_12_0_g65274).yz ) * (temp_output_12_0_g65274).zy ) ) );
					float2 DDX631_g65272 = ddx( temp_output_5_0_g65272 );
					float2 DDY632_g65272 = ddy( temp_output_5_0_g65272 );
					float temp_output_65_0_g65273 = ( 0.0 - temp_output_56_0_g65273 );
					float ifLocalVar59_g65273 = 0;
					if( temp_output_56_0_g65273 <= 0.0 )
					ifLocalVar59_g65273 = temp_output_65_0_g65273;
					else
					ifLocalVar59_g65273 = temp_output_56_0_g65273;
					float temp_output_597_30_g65272 = ifLocalVar59_g65273;
					float2 temp_output_90_0_g65273 = ( temp_output_52_0_g65273 + float2( 0,1 ) );
					float2 temp_output_123_0_g65273 = ( temp_output_52_0_g65273 + float2( 1,0 ) );
					float2 ifLocalVar88_g65273 = 0;
					if( temp_output_56_0_g65273 > 0.0 )
					ifLocalVar88_g65273 = temp_output_90_0_g65273;
					else if( temp_output_56_0_g65273 == 0.0 )
					ifLocalVar88_g65273 = temp_output_123_0_g65273;
					else if( temp_output_56_0_g65273 < 0.0 )
					ifLocalVar88_g65273 = temp_output_123_0_g65273;
					float3 temp_output_7_0_g65275 = frac( ( (ifLocalVar88_g65273).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g65275 = dot( temp_output_7_0_g65275 , ( (temp_output_7_0_g65275).yzx + 33.33 ) );
					float3 temp_output_12_0_g65275 = ( temp_output_7_0_g65275 + dotResult8_g65275 );
					float2 temp_output_597_26_g65272 = ( UV100_g65273 + frac( ( ( (temp_output_12_0_g65275).xx + (temp_output_12_0_g65275).yz ) * (temp_output_12_0_g65275).zy ) ) );
					float temp_output_66_0_g65273 = ( 1.0 - break55_g65273.y );
					float ifLocalVar60_g65273 = 0;
					if( temp_output_56_0_g65273 <= 0.0 )
					ifLocalVar60_g65273 = temp_output_66_0_g65273;
					else
					ifLocalVar60_g65273 = break55_g65273.y;
					float temp_output_597_28_g65272 = ifLocalVar60_g65273;
					float2 ifLocalVar89_g65273 = 0;
					if( temp_output_56_0_g65273 > 0.0 )
					ifLocalVar89_g65273 = temp_output_123_0_g65273;
					else if( temp_output_56_0_g65273 == 0.0 )
					ifLocalVar89_g65273 = temp_output_90_0_g65273;
					else if( temp_output_56_0_g65273 < 0.0 )
					ifLocalVar89_g65273 = temp_output_90_0_g65273;
					float3 temp_output_7_0_g65276 = frac( ( (ifLocalVar89_g65273).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g65276 = dot( temp_output_7_0_g65276 , ( (temp_output_7_0_g65276).yzx + 33.33 ) );
					float3 temp_output_12_0_g65276 = ( temp_output_7_0_g65276 + dotResult8_g65276 );
					float2 temp_output_597_27_g65272 = ( UV100_g65273 + frac( ( ( (temp_output_12_0_g65276).xx + (temp_output_12_0_g65276).yz ) * (temp_output_12_0_g65276).zy ) ) );
					float temp_output_67_0_g65273 = ( 1.0 - break55_g65273.x );
					float ifLocalVar61_g65273 = 0;
					if( temp_output_56_0_g65273 <= 0.0 )
					ifLocalVar61_g65273 = temp_output_67_0_g65273;
					else
					ifLocalVar61_g65273 = break55_g65273.x;
					float temp_output_597_29_g65272 = ifLocalVar61_g65273;
					float4 Output_2D293_g65272 = ( ( tex2D( _EmissionMap, temp_output_597_0_g65272, DDX631_g65272, DDY632_g65272 ) * temp_output_597_30_g65272 ) + ( tex2D( _EmissionMap, temp_output_597_26_g65272, DDX631_g65272, DDY632_g65272 ) * temp_output_597_28_g65272 ) + ( tex2D( _EmissionMap, temp_output_597_27_g65272, DDX631_g65272, DDY632_g65272 ) * temp_output_597_29_g65272 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g65271 = Output_2D293_g65272;
					#else
					float4 staticSwitch1006_g65271 = tex2D( _EmissionMap, uv_EmissionMap81_g65271 );
					#endif
					#ifdef _EMISSIONENABLED_ON
					float4 staticSwitch1017_g65271 = ( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g65271 * _EmissionIntensity );
					#else
					float4 staticSwitch1017_g65271 = temp_cast_5;
					#endif
					float4 Emission86_g65271 = staticSwitch1017_g65271;
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1181_g65271 = Lightmap46_g65271;
					#else
					float4 staticSwitch1181_g65271 = ( ( ( aAlbedo1466_g65271 * Lightmap46_g65271 ) + Specular1419_g65271 ) + Emission86_g65271 );
					#endif
					float4 temp_output_35_0_g65313 = staticSwitch1181_g65271;
					float4 Color353_g65313 = temp_output_35_0_g65313;
					#if defined( _LUTMODE_2D )
					float4 staticSwitch273_g65313 = saturate( temp_output_35_0_g65313 );
					#elif defined( _LUTMODE_3D )
					float4 staticSwitch273_g65313 = temp_output_35_0_g65313;
					#else
					float4 staticSwitch273_g65313 = temp_output_35_0_g65313;
					#endif
					float4 Color_Saturate49_g65313 = staticSwitch273_g65313;
					float Lut_Height213_g65313 = _LUTSize;
					float Lut_Width216_g65313 = ( _LUTSize * Lut_Height213_g65313 );
					float3 appendResult214_g65313 = (float3(( 1.0 / Lut_Width216_g65313 ) , ( 1.0 / Lut_Height213_g65313 ) , ( Lut_Height213_g65313 - 1.0 )));
					float3 Scale_Offset208_g65313 = appendResult214_g65313;
					float2 Scale_Factor292_g65313 = ( (Scale_Offset208_g65313).xy * (Scale_Offset208_g65313).z );
					float2 Offset299_g65313 = ( (Scale_Offset208_g65313).xy * 0.5 );
					float3 Adjusted_UV305_g65313 = ( ( (Color_Saturate49_g65313).xyw * float3( Scale_Factor292_g65313 ,  0.0 ) ) + float3( Offset299_g65313 ,  0.0 ) );
					float2 Scaled_Blue280_g65313 = ( (Color_Saturate49_g65313).zw * (Scale_Offset208_g65313).z );
					float2 Shift288_g65313 = floor( Scaled_Blue280_g65313 );
					float2 Final_X313_g65313 = ( (Adjusted_UV305_g65313).xz + ( Shift288_g65313 * (Scale_Offset208_g65313).y ) );
					float2 appendResult326_g65313 = (float2(Final_X313_g65313.x , (Adjusted_UV305_g65313).yz.x));
					float2 Final_UV325_g65313 = appendResult326_g65313;
					float2 appendResult338_g65313 = (float2((Scale_Offset208_g65313).y , 0.0));
					float2 Offset_UV336_g65313 = ( Final_UV325_g65313 + appendResult338_g65313 );
					float3 lerpResult333_g65313 = lerp( tex2D( _2DLut, Final_UV325_g65313 ).rgb , tex2D( _2DLut, Offset_UV336_g65313 ).rgb , float3( ( Scaled_Blue280_g65313 - Shift288_g65313 ) ,  0.0 ));
					#ifdef _2DLUT
					float4 staticSwitch347_g65313 = float4( lerpResult333_g65313 , 0.0 );
					#else
					float4 staticSwitch347_g65313 = Color_Saturate49_g65313;
					#endif
					float4 TwoD_LUT346_g65313 = staticSwitch347_g65313;
					float3 RGB16_g65314 = ( ( log10( ( ( Color_Saturate49_g65313.xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 );
					#ifdef _3DLUT
					float4 staticSwitch194_g65313 = tex3D( _3DLut, RGB16_g65314 );
					#else
					float4 staticSwitch194_g65313 = Color_Saturate49_g65313;
					#endif
					float4 ThreeD_LUT51_g65313 = staticSwitch194_g65313;
					#if defined( _LUTMODE_2D )
					float4 staticSwitch42_g65313 = TwoD_LUT346_g65313;
					#elif defined( _LUTMODE_3D )
					float4 staticSwitch42_g65313 = ThreeD_LUT51_g65313;
					#else
					float4 staticSwitch42_g65313 = ThreeD_LUT51_g65313;
					#endif
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch41_g65313 = staticSwitch42_g65313;
					#else
					float4 staticSwitch41_g65313 = Color353_g65313;
					#endif
					

					o.Albedo = staticSwitch1180_g65271.rgb;
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

					o.Emission = staticSwitch41_g65313.xyz;
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
				#pragma multi_compile_instancing
				#pragma multi_compile _ LOD_FADE_CROSSFADE
				#define ASE_FOG
				#define _SPECULARHIGHLIGHTS_OFF
				#define ASE_LIGHTING_SIMPLE 1
				#define ASE_VERSION 19905

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

				#define ASE_NEEDS_VERT_NORMAL


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
				uniform sampler2D _2DLut;
				uniform float _LUTSize;
				uniform sampler3D _3DLut;


				
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
					float3 vertexValue = ( v.normal * -0.0001 );
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
Version=19905
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3225;192,-1152;Inherit;False;Meenphie;0;;65271;b3ba55a08dd6b49c7be16c6f35cf2033;1,1008,0;0;5;COLOR;625;FLOAT4;624;FLOAT;156;FLOAT;427;FLOAT3;1024
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3152;640,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3154;640,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;True;1;LightMode=ForwardAdd;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3155;640,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3156;640,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3157;640,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3158;640,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3159;640,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ScenePickingPass;0;7;ScenePickingPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;True;1;LightMode=ScenePickingPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3153;512,-1152;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;Meenphie/Standard/Transparent;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardBase;0;1;ForwardBase;17;True;True;0;1;False;;1;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;2;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Transparent=Queue=1;DisableBatching=False=DisableBatching;True;3;False;0;True;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;44;Category;0;0;  Instanced Terrain Normals;1;0;Workflow;3;639028269801588900;Surface;0;0;  Blend;0;0;  Dither Shadows;1;0;Two Sided;0;639028301219140840;Alpha Clipping;0;0;  Use Shadow Threshold;0;0;Deferred Pass;0;639028268621643780;Normal Space;0;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;1;0;Receive Shadows;0;639028268754114200;Receive Specular;0;639028267060738170;Receive Reflections;1;639028267072870000;GPU Instancing;1;0;LOD CrossFade;1;0;Built-in Fog;1;0;Ambient Light;1;639028468867084280;Meta Pass;0;639028267333272080;Add Pass;0;639028267330516570;Override Baked GI;0;0;Write Depth;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;0;Vertex Position;1;0;0;8;False;True;False;False;False;True;False;False;False;;False;0
WireConnection;3153;0;3225;625
WireConnection;3153;2;3225;624
WireConnection;3153;15;3225;1024
ASEEND*/
//CHKSM=72D0160D47BA11B39BEEF27EB6296458ACD76405