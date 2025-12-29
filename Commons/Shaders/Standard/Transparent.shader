// Made with Amplify Shader Editor v1.9.9.4
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Standard/Transparent"
{
	Properties
	{
		[Meenphie_DrawerCategory(SURFACE OPTIONS,true,0,0)] _CATEGORY_SURFACEOPTIONS( "CATEGORY_SURFACEOPTIONS", Float ) = 1
		_Color( "DIffuse Color", Color ) = ( 0.9058824, 0.9058824, 0.9058824, 1 )
		[NoScaleOffset][SingleLineTexture] _MainTex( "Diffuse Map", 2D ) = "white" {}
		[NoScaleOffset][SingleLineTexture] _BumpMap( "Normal Map", 2D ) = "white" {}
		_NormalScale( "Normal Scale", Float ) = 1
		_SpecularColor( "Specular Color", Color ) = ( 1, 1, 1, 0 )
		[NoScaleOffset][SingleLineTexture] _SpecularMap( "Specular Map", 2D ) = "white" {}
		[NoScaleOffset][SingleLineTexture] _GlossinessMap( "Roughness Map", 2D ) = "white" {}
		_Specular( "Specular", Range( 0, 1 ) ) = 0
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
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0
		[HideInInspector] GenKey__SpecularMap( "Assign keyword _SPECULARMAP", Float ) = 1.0
		[HideInInspector] GenKey__EmissionMap( "Assign keyword _EMISSIONMAP", Float ) = 1.0
		[HideInInspector] GenKey__2DLut( "Assign keyword _2DLUT", Float ) = 1.0
		[HideInInspector] GenKey__GlossinessMap( "Assign keyword _GLOSSINESSMAP", Float ) = 1.0
		[HideInInspector] GenKey__3DLut( "Assign keyword _3DLUT", Float ) = 1.0
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
				#pragma multi_compile _ LOD_FADE_CROSSFADE
				#pragma multi_compile_fog
				#define ASE_FOG
				#pragma multi_compile_local_fragment _SPECULARHIGHLIGHTS_OFF
				#pragma multi_compile_instancing
				#define _SPECULAR_SETUP 1
				#define ASE_VERSION 19904

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
				#define ASE_NEEDS_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_NORMAL
				#pragma shader_feature _LIGHTMAPDEBUG
				#pragma shader_feature_local _STOCHASTICENABLED_ON
				#pragma shader_feature_local_fragment _BUMPMAP
				#pragma shader_feature_local _LIGHTMAPMODE_DISABLED _LIGHTMAPMODE_SIMPLE _LIGHTMAPMODE_SIMPLELERP _LIGHTMAPMODE_RNM _LIGHTMAPMODE_RNMLERP
				#pragma shader_feature_local _USEBICUBICFILTERING_ON
				#pragma shader_feature_local_fragment _METALLICMAP
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
					float4 positionWS : TEXCOORD0; // xyz = positionWS, w = fogCoord
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
				uniform sampler2D _BumpMap;
				uniform float _NormalScale;
				uniform float4 _BumpMap_ST;
				uniform sampler2D _Lightmap0;
				uniform float4 _Lightmap0_ST;
				float4 _Lightmap0_TexelSize;
				uniform sampler2D _Lightmap1;
				uniform float4 _Lightmap1_ST;
				float4 _Lightmap1_TexelSize;
				uniform float _LIGHTMAPLERP;
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
				uniform float _Specular;
				uniform sampler2D _SpecularMap;
				uniform float4 _SpecularMap_ST;
				uniform float4 _SpecularColor;
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
					o.positionWS.xyz = positionWS;
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
						o.positionWS.w = o.pos.z;
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
							UNITY_LIGHT_ATTENUATION( temp, IN, IN.positionWS.xyz )
							atten = temp;
						#else
							atten = 1;
						#endif
					}

					float3 PositionWS = IN.positionWS.xyz;
					half3 ViewDirWS = normalize( UnityWorldSpaceViewDir( PositionWS ) );
					float4 ScreenPosNorm = float4( IN.pos.xy * ( _ScreenParams.zw - 1.0 ), IN.pos.zw );
					float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, IN.pos.z ) * IN.pos.w;
					float4 ScreenPos = ComputeScreenPos( ClipPos );
					half3 NormalWS = IN.normalWS;
					half3 TangentWS = IN.tangentWS.xyz;
					half3 BitangentWS = cross( IN.normalWS, IN.tangentWS.xyz ) * IN.tangentWS.w * unity_WorldTransformParams.w;
					half3 LightAtten = atten;
					float FogCoord = IN.positionWS.w;

					#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
						float2 sampleCoords = (IN.tangentWS.zw / _TerrainHeightmapRecipSize.zw + 0.5f) * _TerrainHeightmapRecipSize.xy;
						NormalWS = UnityObjectToWorldNormal(normalize(tex2D(_TerrainNormalmapTexture, sampleCoords).rgb * 2 - 1));
						TangentWS = -cross(unity_ObjectToWorld._13_23_33, NormalWS);
						BitangentWS = cross(NormalWS, -TangentWS);
					#endif

					float2 uv_MainTex907_g59004 = IN.ase_texcoord6.xy;
					float4 tex2DNode907_g59004 = tex2D( _MainTex, uv_MainTex907_g59004 );
					float2 uv_MainTex = IN.ase_texcoord6.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					float2 temp_output_5_0_g59020 = uv_MainTex;
					float2 UV633_g59020 = temp_output_5_0_g59020;
					float2 UV100_g59021 = UV633_g59020;
					float2 temp_output_51_0_g59021 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59021 * float2( 3.464,3.464 ) ) );
					float2 break55_g59021 = frac( temp_output_51_0_g59021 );
					float temp_output_56_0_g59021 = ( ( 1.0 - break55_g59021.x ) - break55_g59021.y );
					float2 temp_output_52_0_g59021 = floor( temp_output_51_0_g59021 );
					float2 temp_output_125_0_g59021 = ( temp_output_52_0_g59021 + float2( 1,1 ) );
					float2 ifLocalVar87_g59021 = 0;
					if( temp_output_56_0_g59021 > 0.0 )
					ifLocalVar87_g59021 = temp_output_52_0_g59021;
					else if( temp_output_56_0_g59021 == 0.0 )
					ifLocalVar87_g59021 = temp_output_125_0_g59021;
					else if( temp_output_56_0_g59021 < 0.0 )
					ifLocalVar87_g59021 = temp_output_125_0_g59021;
					float3 temp_output_7_0_g59022 = frac( ( (ifLocalVar87_g59021).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59022 = dot( temp_output_7_0_g59022 , ( (temp_output_7_0_g59022).yzx + 33.33 ) );
					float3 temp_output_12_0_g59022 = ( temp_output_7_0_g59022 + dotResult8_g59022 );
					float2 temp_output_597_0_g59020 = ( UV100_g59021 + frac( ( ( (temp_output_12_0_g59022).xx + (temp_output_12_0_g59022).yz ) * (temp_output_12_0_g59022).zy ) ) );
					float2 DDX631_g59020 = ddx( temp_output_5_0_g59020 );
					float2 DDY632_g59020 = ddy( temp_output_5_0_g59020 );
					float temp_output_65_0_g59021 = ( 0.0 - temp_output_56_0_g59021 );
					float ifLocalVar59_g59021 = 0;
					if( temp_output_56_0_g59021 <= 0.0 )
					ifLocalVar59_g59021 = temp_output_65_0_g59021;
					else
					ifLocalVar59_g59021 = temp_output_56_0_g59021;
					float temp_output_597_30_g59020 = ifLocalVar59_g59021;
					float2 temp_output_90_0_g59021 = ( temp_output_52_0_g59021 + float2( 0,1 ) );
					float2 temp_output_123_0_g59021 = ( temp_output_52_0_g59021 + float2( 1,0 ) );
					float2 ifLocalVar88_g59021 = 0;
					if( temp_output_56_0_g59021 > 0.0 )
					ifLocalVar88_g59021 = temp_output_90_0_g59021;
					else if( temp_output_56_0_g59021 == 0.0 )
					ifLocalVar88_g59021 = temp_output_123_0_g59021;
					else if( temp_output_56_0_g59021 < 0.0 )
					ifLocalVar88_g59021 = temp_output_123_0_g59021;
					float3 temp_output_7_0_g59023 = frac( ( (ifLocalVar88_g59021).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59023 = dot( temp_output_7_0_g59023 , ( (temp_output_7_0_g59023).yzx + 33.33 ) );
					float3 temp_output_12_0_g59023 = ( temp_output_7_0_g59023 + dotResult8_g59023 );
					float2 temp_output_597_26_g59020 = ( UV100_g59021 + frac( ( ( (temp_output_12_0_g59023).xx + (temp_output_12_0_g59023).yz ) * (temp_output_12_0_g59023).zy ) ) );
					float temp_output_66_0_g59021 = ( 1.0 - break55_g59021.y );
					float ifLocalVar60_g59021 = 0;
					if( temp_output_56_0_g59021 <= 0.0 )
					ifLocalVar60_g59021 = temp_output_66_0_g59021;
					else
					ifLocalVar60_g59021 = break55_g59021.y;
					float temp_output_597_28_g59020 = ifLocalVar60_g59021;
					float2 ifLocalVar89_g59021 = 0;
					if( temp_output_56_0_g59021 > 0.0 )
					ifLocalVar89_g59021 = temp_output_123_0_g59021;
					else if( temp_output_56_0_g59021 == 0.0 )
					ifLocalVar89_g59021 = temp_output_90_0_g59021;
					else if( temp_output_56_0_g59021 < 0.0 )
					ifLocalVar89_g59021 = temp_output_90_0_g59021;
					float3 temp_output_7_0_g59024 = frac( ( (ifLocalVar89_g59021).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59024 = dot( temp_output_7_0_g59024 , ( (temp_output_7_0_g59024).yzx + 33.33 ) );
					float3 temp_output_12_0_g59024 = ( temp_output_7_0_g59024 + dotResult8_g59024 );
					float2 temp_output_597_27_g59020 = ( UV100_g59021 + frac( ( ( (temp_output_12_0_g59024).xx + (temp_output_12_0_g59024).yz ) * (temp_output_12_0_g59024).zy ) ) );
					float temp_output_67_0_g59021 = ( 1.0 - break55_g59021.x );
					float ifLocalVar61_g59021 = 0;
					if( temp_output_56_0_g59021 <= 0.0 )
					ifLocalVar61_g59021 = temp_output_67_0_g59021;
					else
					ifLocalVar61_g59021 = break55_g59021.x;
					float temp_output_597_29_g59020 = ifLocalVar61_g59021;
					float4 Output_2D293_g59020 = ( ( tex2D( _MainTex, temp_output_597_0_g59020, DDX631_g59020, DDY632_g59020 ) * temp_output_597_30_g59020 ) + ( tex2D( _MainTex, temp_output_597_26_g59020, DDX631_g59020, DDY632_g59020 ) * temp_output_597_28_g59020 ) + ( tex2D( _MainTex, temp_output_597_27_g59020, DDX631_g59020, DDY632_g59020 ) * temp_output_597_29_g59020 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g59004 = Output_2D293_g59020;
					#else
					float4 staticSwitch1001_g59004 = tex2DNode907_g59004;
					#endif
					float4 temp_output_976_0_g59004 = ( _Color * staticSwitch1001_g59004 );
					float4 Albedo6_g59004 = temp_output_976_0_g59004;
					float Black1185_g59004 = 0.0;
					float4 temp_cast_0 = (Black1185_g59004).xxxx;
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1180_g59004 = temp_cast_0;
					#else
					float4 staticSwitch1180_g59004 = Albedo6_g59004;
					#endif
					
					float2 uv_BumpMap830_g59004 = IN.ase_texcoord6.xy;
					float2 uv_BumpMap = IN.ase_texcoord6.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					float2 temp_output_5_0_g59015 = uv_BumpMap;
					float2 UV633_g59015 = temp_output_5_0_g59015;
					float2 UV100_g59016 = UV633_g59015;
					float2 temp_output_51_0_g59016 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59016 * float2( 3.464,3.464 ) ) );
					float2 break55_g59016 = frac( temp_output_51_0_g59016 );
					float temp_output_56_0_g59016 = ( ( 1.0 - break55_g59016.x ) - break55_g59016.y );
					float2 temp_output_52_0_g59016 = floor( temp_output_51_0_g59016 );
					float2 temp_output_125_0_g59016 = ( temp_output_52_0_g59016 + float2( 1,1 ) );
					float2 ifLocalVar87_g59016 = 0;
					if( temp_output_56_0_g59016 > 0.0 )
					ifLocalVar87_g59016 = temp_output_52_0_g59016;
					else if( temp_output_56_0_g59016 == 0.0 )
					ifLocalVar87_g59016 = temp_output_125_0_g59016;
					else if( temp_output_56_0_g59016 < 0.0 )
					ifLocalVar87_g59016 = temp_output_125_0_g59016;
					float3 temp_output_7_0_g59017 = frac( ( (ifLocalVar87_g59016).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59017 = dot( temp_output_7_0_g59017 , ( (temp_output_7_0_g59017).yzx + 33.33 ) );
					float3 temp_output_12_0_g59017 = ( temp_output_7_0_g59017 + dotResult8_g59017 );
					float2 temp_output_597_0_g59015 = ( UV100_g59016 + frac( ( ( (temp_output_12_0_g59017).xx + (temp_output_12_0_g59017).yz ) * (temp_output_12_0_g59017).zy ) ) );
					float2 DDX631_g59015 = ddx( temp_output_5_0_g59015 );
					float2 DDY632_g59015 = ddy( temp_output_5_0_g59015 );
					float Input_Scale617_g59015 = _NormalScale;
					float temp_output_65_0_g59016 = ( 0.0 - temp_output_56_0_g59016 );
					float ifLocalVar59_g59016 = 0;
					if( temp_output_56_0_g59016 <= 0.0 )
					ifLocalVar59_g59016 = temp_output_65_0_g59016;
					else
					ifLocalVar59_g59016 = temp_output_56_0_g59016;
					float temp_output_597_30_g59015 = ifLocalVar59_g59016;
					float2 temp_output_90_0_g59016 = ( temp_output_52_0_g59016 + float2( 0,1 ) );
					float2 temp_output_123_0_g59016 = ( temp_output_52_0_g59016 + float2( 1,0 ) );
					float2 ifLocalVar88_g59016 = 0;
					if( temp_output_56_0_g59016 > 0.0 )
					ifLocalVar88_g59016 = temp_output_90_0_g59016;
					else if( temp_output_56_0_g59016 == 0.0 )
					ifLocalVar88_g59016 = temp_output_123_0_g59016;
					else if( temp_output_56_0_g59016 < 0.0 )
					ifLocalVar88_g59016 = temp_output_123_0_g59016;
					float3 temp_output_7_0_g59018 = frac( ( (ifLocalVar88_g59016).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59018 = dot( temp_output_7_0_g59018 , ( (temp_output_7_0_g59018).yzx + 33.33 ) );
					float3 temp_output_12_0_g59018 = ( temp_output_7_0_g59018 + dotResult8_g59018 );
					float2 temp_output_597_26_g59015 = ( UV100_g59016 + frac( ( ( (temp_output_12_0_g59018).xx + (temp_output_12_0_g59018).yz ) * (temp_output_12_0_g59018).zy ) ) );
					float temp_output_66_0_g59016 = ( 1.0 - break55_g59016.y );
					float ifLocalVar60_g59016 = 0;
					if( temp_output_56_0_g59016 <= 0.0 )
					ifLocalVar60_g59016 = temp_output_66_0_g59016;
					else
					ifLocalVar60_g59016 = break55_g59016.y;
					float temp_output_597_28_g59015 = ifLocalVar60_g59016;
					float2 ifLocalVar89_g59016 = 0;
					if( temp_output_56_0_g59016 > 0.0 )
					ifLocalVar89_g59016 = temp_output_123_0_g59016;
					else if( temp_output_56_0_g59016 == 0.0 )
					ifLocalVar89_g59016 = temp_output_90_0_g59016;
					else if( temp_output_56_0_g59016 < 0.0 )
					ifLocalVar89_g59016 = temp_output_90_0_g59016;
					float3 temp_output_7_0_g59019 = frac( ( (ifLocalVar89_g59016).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59019 = dot( temp_output_7_0_g59019 , ( (temp_output_7_0_g59019).yzx + 33.33 ) );
					float3 temp_output_12_0_g59019 = ( temp_output_7_0_g59019 + dotResult8_g59019 );
					float2 temp_output_597_27_g59015 = ( UV100_g59016 + frac( ( ( (temp_output_12_0_g59019).xx + (temp_output_12_0_g59019).yz ) * (temp_output_12_0_g59019).zy ) ) );
					float temp_output_67_0_g59016 = ( 1.0 - break55_g59016.x );
					float ifLocalVar61_g59016 = 0;
					if( temp_output_56_0_g59016 <= 0.0 )
					ifLocalVar61_g59016 = temp_output_67_0_g59016;
					else
					ifLocalVar61_g59016 = break55_g59016.x;
					float temp_output_597_29_g59015 = ifLocalVar61_g59016;
					float3 Output_2D_Normal641_g59015 = ( ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_0_g59015, DDX631_g59015, DDY632_g59015 ), Input_Scale617_g59015 ) * temp_output_597_30_g59015 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_26_g59015, DDX631_g59015, DDY632_g59015 ), Input_Scale617_g59015 ) * temp_output_597_28_g59015 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_27_g59015, DDX631_g59015, DDY632_g59015 ), Input_Scale617_g59015 ) * float3( 0,0,0 ) * temp_output_597_29_g59015 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g59004 = Output_2D_Normal641_g59015;
					#else
					float3 staticSwitch1003_g59004 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap830_g59004 ), _NormalScale );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g59004 = staticSwitch1003_g59004;
					#else
					float3 staticSwitch980_g59004 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g59004 = staticSwitch980_g59004;
					
					float White38_g59004 = 1.0;
					float4 temp_cast_2 = (White38_g59004).xxxx;
					float2 texCoord1093_g59004 = IN.ase_texcoord6.zw * float2( 1,1 ) + float2( 0,0 );
					float localBicubicPrepare2_g59033 = ( 0.0 );
					float2 uv3_Lightmap0 = IN.ase_texcoord6.zw * _Lightmap0_ST.xy + _Lightmap0_ST.zw;
					float2 Input_UV100_g59033 = uv3_Lightmap0;
					float2 UV2_g59033 = Input_UV100_g59033;
					float4 TexelSize2_g59033 = _Lightmap0_TexelSize;
					float2 UV02_g59033 = float2( 0,0 );
					float2 UV12_g59033 = float2( 0,0 );
					float2 UV22_g59033 = float2( 0,0 );
					float2 UV32_g59033 = float2( 0,0 );
					float W02_g59033 = 0;
					float W12_g59033 = 0;
					{
					{
					 UV2_g59033 = UV2_g59033 * TexelSize2_g59033.zw - 0.5;
					    float2 f = frac( UV2_g59033 );
					    UV2_g59033 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59033.x - 0.5, UV2_g59033.x + 1.5, UV2_g59033.y - 0.5, UV2_g59033.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59033.xyxy;
					    UV02_g59033 = off.xz;
					    UV12_g59033 = off.yz;
					    UV22_g59033 = off.xw;
					    UV32_g59033 = off.yw;
					    W02_g59033 = s.x / ( s.x + s.y );
					 W12_g59033 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59033 = lerp( tex2D( _Lightmap0, UV32_g59033 ) , tex2D( _Lightmap0, UV22_g59033 ) , W02_g59033);
					float4 lerpResult45_g59033 = lerp( tex2D( _Lightmap0, UV12_g59033 ) , tex2D( _Lightmap0, UV02_g59033 ) , W02_g59033);
					float4 lerpResult44_g59033 = lerp( lerpResult46_g59033 , lerpResult45_g59033 , W12_g59033);
					float4 Output_2D131_g59033 = lerpResult44_g59033;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g59004 = Output_2D131_g59033;
					#else
					float4 staticSwitch1092_g59004 = tex2D( _Lightmap0, texCoord1093_g59004 );
					#endif
					float4 Lightmap_0925_g59004 = staticSwitch1092_g59004;
					float2 texCoord1090_g59004 = IN.ase_texcoord6.zw * float2( 1,1 ) + float2( 0,0 );
					float localBicubicPrepare2_g59031 = ( 0.0 );
					float2 uv3_Lightmap1 = IN.ase_texcoord6.zw * _Lightmap1_ST.xy + _Lightmap1_ST.zw;
					float2 Input_UV100_g59031 = uv3_Lightmap1;
					float2 UV2_g59031 = Input_UV100_g59031;
					float4 TexelSize2_g59031 = _Lightmap1_TexelSize;
					float2 UV02_g59031 = float2( 0,0 );
					float2 UV12_g59031 = float2( 0,0 );
					float2 UV22_g59031 = float2( 0,0 );
					float2 UV32_g59031 = float2( 0,0 );
					float W02_g59031 = 0;
					float W12_g59031 = 0;
					{
					{
					 UV2_g59031 = UV2_g59031 * TexelSize2_g59031.zw - 0.5;
					    float2 f = frac( UV2_g59031 );
					    UV2_g59031 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59031.x - 0.5, UV2_g59031.x + 1.5, UV2_g59031.y - 0.5, UV2_g59031.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59031.xyxy;
					    UV02_g59031 = off.xz;
					    UV12_g59031 = off.yz;
					    UV22_g59031 = off.xw;
					    UV32_g59031 = off.yw;
					    W02_g59031 = s.x / ( s.x + s.y );
					 W12_g59031 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59031 = lerp( tex2D( _Lightmap1, UV32_g59031 ) , tex2D( _Lightmap1, UV22_g59031 ) , W02_g59031);
					float4 lerpResult45_g59031 = lerp( tex2D( _Lightmap1, UV12_g59031 ) , tex2D( _Lightmap1, UV02_g59031 ) , W02_g59031);
					float4 lerpResult44_g59031 = lerp( lerpResult46_g59031 , lerpResult45_g59031 , W12_g59031);
					float4 Output_2D131_g59031 = lerpResult44_g59031;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g59004 = Output_2D131_g59031;
					#else
					float4 staticSwitch1088_g59004 = tex2D( _Lightmap1, texCoord1090_g59004 );
					#endif
					float4 Lightmap_1956_g59004 = staticSwitch1088_g59004;
					float4 lerpResult442_g59004 = lerp( Lightmap_0925_g59004 , Lightmap_1956_g59004 , _LIGHTMAPLERP);
					float4 Lightmap_Lerp932_g59004 = lerpResult442_g59004;
					float3 appendResult139_g59040 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g59040 = normalize( Normal_Map700_g59004 );
					float3 Normal_Map318_g59040 = normalizeResult326_g59040;
					float dotResult121_g59040 = dot( appendResult139_g59040 , Normal_Map318_g59040 );
					float2 texCoord1070_g59004 = IN.ase_texcoord6.zw * float2( 1,1 ) + float2( 0,0 );
					float localStochasticTiling2_g59035 = ( 0.0 );
					float2 uv3_RNMX0 = IN.ase_texcoord6.zw * _RNMX0_ST.xy + _RNMX0_ST.zw;
					float2 UV2_g59035 = uv3_RNMX0;
					float4 TexelSize2_g59035 = _RNMX0_TexelSize;
					float4 Offsets2_g59035 = float4( 0,0,0,0 );
					float2 Weights2_g59035 = float2( 0,0 );
					{
					UV2_g59035 = UV2_g59035 * TexelSize2_g59035.zw - 0.5;
					float2 f = frac( UV2_g59035 );
					UV2_g59035 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g59035.x - 0.5, UV2_g59035.x + 1.5, UV2_g59035.y - 0.5, UV2_g59035.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g59035 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59035.xyxy;
					Weights2_g59035 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g59034 = Offsets2_g59035;
					float4 Input_FetchOffsets197_g59038 = temp_output_1_34_g59034;
					float2 temp_output_1_54_g59034 = Weights2_g59035;
					float2 Input_FetchWeights200_g59038 = temp_output_1_54_g59034;
					float2 break187_g59038 = Input_FetchWeights200_g59038;
					float4 lerpResult181_g59038 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g59038).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g59038).xw ) , break187_g59038.x);
					float4 lerpResult182_g59038 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g59038).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g59038).xz ) , break187_g59038.x);
					float4 lerpResult176_g59038 = lerp( lerpResult181_g59038 , lerpResult182_g59038 , break187_g59038.y);
					float4 Output_Fetch2D202_g59038 = lerpResult176_g59038;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g59004 = Output_Fetch2D202_g59038;
					#else
					float4 staticSwitch1061_g59004 = tex2D( _RNMX0, texCoord1070_g59004 );
					#endif
					float3 appendResult146_g59040 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59040 = dot( appendResult146_g59040 , Normal_Map318_g59040 );
					float4 Input_FetchOffsets197_g59036 = temp_output_1_34_g59034;
					float2 Input_FetchWeights200_g59036 = temp_output_1_54_g59034;
					float2 break187_g59036 = Input_FetchWeights200_g59036;
					float4 lerpResult181_g59036 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g59036).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g59036).xw ) , break187_g59036.x);
					float4 lerpResult182_g59036 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g59036).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g59036).xz ) , break187_g59036.x);
					float4 lerpResult176_g59036 = lerp( lerpResult181_g59036 , lerpResult182_g59036 , break187_g59036.y);
					float4 Output_Fetch2D202_g59036 = lerpResult176_g59036;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g59004 = Output_Fetch2D202_g59036;
					#else
					float4 staticSwitch1062_g59004 = tex2D( _RNMY0, texCoord1070_g59004 );
					#endif
					float3 appendResult149_g59040 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59040 = dot( appendResult149_g59040 , Normal_Map318_g59040 );
					float4 Input_FetchOffsets197_g59037 = temp_output_1_34_g59034;
					float2 Input_FetchWeights200_g59037 = temp_output_1_54_g59034;
					float2 break187_g59037 = Input_FetchWeights200_g59037;
					float4 lerpResult181_g59037 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g59037).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g59037).xw ) , break187_g59037.x);
					float4 lerpResult182_g59037 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g59037).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g59037).xz ) , break187_g59037.x);
					float4 lerpResult176_g59037 = lerp( lerpResult181_g59037 , lerpResult182_g59037 , break187_g59037.y);
					float4 Output_Fetch2D202_g59037 = lerpResult176_g59037;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g59004 = Output_Fetch2D202_g59037;
					#else
					float4 staticSwitch1063_g59004 = tex2D( _RNMZ0, texCoord1070_g59004 );
					#endif
					float4 RNM_0926_g59004 = ( ( ( saturate( dotResult121_g59040 ) * ( staticSwitch1061_g59004 * 0.33334 ) ) + ( saturate( dotResult122_g59040 ) * ( staticSwitch1062_g59004 * 0.33334 ) ) ) + ( saturate( dotResult120_g59040 ) * ( staticSwitch1063_g59004 * 0.33334 ) ) );
					float3 appendResult139_g59039 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g59039 = normalize( Normal_Map700_g59004 );
					float3 Normal_Map318_g59039 = normalizeResult326_g59039;
					float dotResult121_g59039 = dot( appendResult139_g59039 , Normal_Map318_g59039 );
					float2 texCoord1086_g59004 = IN.ase_texcoord6.zw * float2( 1,1 ) + float2( 0,0 );
					float localStochasticTiling2_g59026 = ( 0.0 );
					float2 uv3_RNMX1 = IN.ase_texcoord6.zw * _RNMX1_ST.xy + _RNMX1_ST.zw;
					float2 UV2_g59026 = uv3_RNMX1;
					float4 TexelSize2_g59026 = _RNMX1_TexelSize;
					float4 Offsets2_g59026 = float4( 0,0,0,0 );
					float2 Weights2_g59026 = float2( 0,0 );
					{
					UV2_g59026 = UV2_g59026 * TexelSize2_g59026.zw - 0.5;
					float2 f = frac( UV2_g59026 );
					UV2_g59026 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g59026.x - 0.5, UV2_g59026.x + 1.5, UV2_g59026.y - 0.5, UV2_g59026.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g59026 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59026.xyxy;
					Weights2_g59026 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g59025 = Offsets2_g59026;
					float4 Input_FetchOffsets197_g59029 = temp_output_1_34_g59025;
					float2 temp_output_1_54_g59025 = Weights2_g59026;
					float2 Input_FetchWeights200_g59029 = temp_output_1_54_g59025;
					float2 break187_g59029 = Input_FetchWeights200_g59029;
					float4 lerpResult181_g59029 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g59029).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g59029).xw ) , break187_g59029.x);
					float4 lerpResult182_g59029 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g59029).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g59029).xz ) , break187_g59029.x);
					float4 lerpResult176_g59029 = lerp( lerpResult181_g59029 , lerpResult182_g59029 , break187_g59029.y);
					float4 Output_Fetch2D202_g59029 = lerpResult176_g59029;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g59004 = Output_Fetch2D202_g59029;
					#else
					float4 staticSwitch1087_g59004 = tex2D( _RNMX1, texCoord1086_g59004 );
					#endif
					float3 appendResult146_g59039 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59039 = dot( appendResult146_g59039 , Normal_Map318_g59039 );
					float4 Input_FetchOffsets197_g59027 = temp_output_1_34_g59025;
					float2 Input_FetchWeights200_g59027 = temp_output_1_54_g59025;
					float2 break187_g59027 = Input_FetchWeights200_g59027;
					float4 lerpResult181_g59027 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g59027).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g59027).xw ) , break187_g59027.x);
					float4 lerpResult182_g59027 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g59027).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g59027).xz ) , break187_g59027.x);
					float4 lerpResult176_g59027 = lerp( lerpResult181_g59027 , lerpResult182_g59027 , break187_g59027.y);
					float4 Output_Fetch2D202_g59027 = lerpResult176_g59027;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g59004 = Output_Fetch2D202_g59027;
					#else
					float4 staticSwitch1083_g59004 = tex2D( _RNMY1, texCoord1086_g59004 );
					#endif
					float3 appendResult149_g59039 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59039 = dot( appendResult149_g59039 , Normal_Map318_g59039 );
					float4 Input_FetchOffsets197_g59028 = temp_output_1_34_g59025;
					float2 Input_FetchWeights200_g59028 = temp_output_1_54_g59025;
					float2 break187_g59028 = Input_FetchWeights200_g59028;
					float4 lerpResult181_g59028 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g59028).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g59028).xw ) , break187_g59028.x);
					float4 lerpResult182_g59028 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g59028).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g59028).xz ) , break187_g59028.x);
					float4 lerpResult176_g59028 = lerp( lerpResult181_g59028 , lerpResult182_g59028 , break187_g59028.y);
					float4 Output_Fetch2D202_g59028 = lerpResult176_g59028;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g59004 = Output_Fetch2D202_g59028;
					#else
					float4 staticSwitch1084_g59004 = tex2D( _RNMZ1, texCoord1086_g59004 );
					#endif
					float4 RNM_11081_g59004 = ( ( ( saturate( dotResult121_g59039 ) * ( staticSwitch1087_g59004 * 0.33334 ) ) + ( saturate( dotResult122_g59039 ) * ( staticSwitch1083_g59004 * 0.33334 ) ) ) + ( saturate( dotResult120_g59039 ) * ( staticSwitch1084_g59004 * 0.33334 ) ) );
					float Lightmap_Lerp_Value969_g59004 = _LIGHTMAPLERP;
					float4 lerpResult953_g59004 = lerp( RNM_0926_g59004 , RNM_11081_g59004 , Lightmap_Lerp_Value969_g59004);
					float4 RNM_Lerp950_g59004 = lerpResult953_g59004;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g59004 = temp_cast_2;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g59004 = Lightmap_0925_g59004;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g59004 = Lightmap_Lerp932_g59004;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g59004 = RNM_0926_g59004;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g59004 = RNM_Lerp950_g59004;
					#else
					float4 staticSwitch1014_g59004 = temp_cast_2;
					#endif
					float4 Lightmap46_g59004 = staticSwitch1014_g59004;
					float2 uv_SpecularMap48_g59004 = IN.ase_texcoord6.xy;
					float2 uv_SpecularMap = IN.ase_texcoord6.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
					float2 temp_output_5_0_g59042 = uv_SpecularMap;
					float2 UV633_g59042 = temp_output_5_0_g59042;
					float2 UV100_g59043 = UV633_g59042;
					float2 temp_output_51_0_g59043 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59043 * float2( 3.464,3.464 ) ) );
					float2 break55_g59043 = frac( temp_output_51_0_g59043 );
					float temp_output_56_0_g59043 = ( ( 1.0 - break55_g59043.x ) - break55_g59043.y );
					float2 temp_output_52_0_g59043 = floor( temp_output_51_0_g59043 );
					float2 temp_output_125_0_g59043 = ( temp_output_52_0_g59043 + float2( 1,1 ) );
					float2 ifLocalVar87_g59043 = 0;
					if( temp_output_56_0_g59043 > 0.0 )
					ifLocalVar87_g59043 = temp_output_52_0_g59043;
					else if( temp_output_56_0_g59043 == 0.0 )
					ifLocalVar87_g59043 = temp_output_125_0_g59043;
					else if( temp_output_56_0_g59043 < 0.0 )
					ifLocalVar87_g59043 = temp_output_125_0_g59043;
					float3 temp_output_7_0_g59044 = frac( ( (ifLocalVar87_g59043).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59044 = dot( temp_output_7_0_g59044 , ( (temp_output_7_0_g59044).yzx + 33.33 ) );
					float3 temp_output_12_0_g59044 = ( temp_output_7_0_g59044 + dotResult8_g59044 );
					float2 temp_output_597_0_g59042 = ( UV100_g59043 + frac( ( ( (temp_output_12_0_g59044).xx + (temp_output_12_0_g59044).yz ) * (temp_output_12_0_g59044).zy ) ) );
					float2 DDX631_g59042 = ddx( temp_output_5_0_g59042 );
					float2 DDY632_g59042 = ddy( temp_output_5_0_g59042 );
					float temp_output_65_0_g59043 = ( 0.0 - temp_output_56_0_g59043 );
					float ifLocalVar59_g59043 = 0;
					if( temp_output_56_0_g59043 <= 0.0 )
					ifLocalVar59_g59043 = temp_output_65_0_g59043;
					else
					ifLocalVar59_g59043 = temp_output_56_0_g59043;
					float temp_output_597_30_g59042 = ifLocalVar59_g59043;
					float2 temp_output_90_0_g59043 = ( temp_output_52_0_g59043 + float2( 0,1 ) );
					float2 temp_output_123_0_g59043 = ( temp_output_52_0_g59043 + float2( 1,0 ) );
					float2 ifLocalVar88_g59043 = 0;
					if( temp_output_56_0_g59043 > 0.0 )
					ifLocalVar88_g59043 = temp_output_90_0_g59043;
					else if( temp_output_56_0_g59043 == 0.0 )
					ifLocalVar88_g59043 = temp_output_123_0_g59043;
					else if( temp_output_56_0_g59043 < 0.0 )
					ifLocalVar88_g59043 = temp_output_123_0_g59043;
					float3 temp_output_7_0_g59045 = frac( ( (ifLocalVar88_g59043).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59045 = dot( temp_output_7_0_g59045 , ( (temp_output_7_0_g59045).yzx + 33.33 ) );
					float3 temp_output_12_0_g59045 = ( temp_output_7_0_g59045 + dotResult8_g59045 );
					float2 temp_output_597_26_g59042 = ( UV100_g59043 + frac( ( ( (temp_output_12_0_g59045).xx + (temp_output_12_0_g59045).yz ) * (temp_output_12_0_g59045).zy ) ) );
					float temp_output_66_0_g59043 = ( 1.0 - break55_g59043.y );
					float ifLocalVar60_g59043 = 0;
					if( temp_output_56_0_g59043 <= 0.0 )
					ifLocalVar60_g59043 = temp_output_66_0_g59043;
					else
					ifLocalVar60_g59043 = break55_g59043.y;
					float temp_output_597_28_g59042 = ifLocalVar60_g59043;
					float2 ifLocalVar89_g59043 = 0;
					if( temp_output_56_0_g59043 > 0.0 )
					ifLocalVar89_g59043 = temp_output_123_0_g59043;
					else if( temp_output_56_0_g59043 == 0.0 )
					ifLocalVar89_g59043 = temp_output_90_0_g59043;
					else if( temp_output_56_0_g59043 < 0.0 )
					ifLocalVar89_g59043 = temp_output_90_0_g59043;
					float3 temp_output_7_0_g59046 = frac( ( (ifLocalVar89_g59043).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59046 = dot( temp_output_7_0_g59046 , ( (temp_output_7_0_g59046).yzx + 33.33 ) );
					float3 temp_output_12_0_g59046 = ( temp_output_7_0_g59046 + dotResult8_g59046 );
					float2 temp_output_597_27_g59042 = ( UV100_g59043 + frac( ( ( (temp_output_12_0_g59046).xx + (temp_output_12_0_g59046).yz ) * (temp_output_12_0_g59046).zy ) ) );
					float temp_output_67_0_g59043 = ( 1.0 - break55_g59043.x );
					float ifLocalVar61_g59043 = 0;
					if( temp_output_56_0_g59043 <= 0.0 )
					ifLocalVar61_g59043 = temp_output_67_0_g59043;
					else
					ifLocalVar61_g59043 = break55_g59043.x;
					float temp_output_597_29_g59042 = ifLocalVar61_g59043;
					float4 Output_2D293_g59042 = ( ( tex2D( _SpecularMap, temp_output_597_0_g59042, DDX631_g59042, DDY632_g59042 ) * temp_output_597_30_g59042 ) + ( tex2D( _SpecularMap, temp_output_597_26_g59042, DDX631_g59042, DDY632_g59042 ) * temp_output_597_28_g59042 ) + ( tex2D( _SpecularMap, temp_output_597_27_g59042, DDX631_g59042, DDY632_g59042 ) * temp_output_597_29_g59042 ) );
					float4 break31_g59042 = Output_2D293_g59042;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g59004 = break31_g59042.a;
					#else
					float staticSwitch1005_g59004 = tex2D( _SpecularMap, uv_SpecularMap48_g59004 ).a;
					#endif
					#ifdef _METALLICMAP
					float staticSwitch846_g59004 = staticSwitch1005_g59004;
					#else
					float staticSwitch846_g59004 = _Specular;
					#endif
					float3 lerpResult1237_g59004 = lerp( _SpecularColor.rgb , float3( 1,1,1 ) , Albedo6_g59004.rgb);
					float4 DiffuseMap1235_g59004 = tex2DNode907_g59004;
					float4 temp_cast_5 = (Black1185_g59004).xxxx;
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1188_g59004 = temp_cast_5;
					#else
					float4 staticSwitch1188_g59004 = ( Lightmap46_g59004 * staticSwitch846_g59004 * float4( lerpResult1237_g59004 , 0.0 ) * DiffuseMap1235_g59004 );
					#endif
					
					float2 uv_GlossinessMap64_g59004 = IN.ase_texcoord6.xy;
					float2 uv_GlossinessMap = IN.ase_texcoord6.xy * _GlossinessMap_ST.xy + _GlossinessMap_ST.zw;
					float2 temp_output_5_0_g59010 = uv_GlossinessMap;
					float2 UV633_g59010 = temp_output_5_0_g59010;
					float2 UV100_g59011 = UV633_g59010;
					float2 temp_output_51_0_g59011 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59011 * float2( 3.464,3.464 ) ) );
					float2 break55_g59011 = frac( temp_output_51_0_g59011 );
					float temp_output_56_0_g59011 = ( ( 1.0 - break55_g59011.x ) - break55_g59011.y );
					float2 temp_output_52_0_g59011 = floor( temp_output_51_0_g59011 );
					float2 temp_output_125_0_g59011 = ( temp_output_52_0_g59011 + float2( 1,1 ) );
					float2 ifLocalVar87_g59011 = 0;
					if( temp_output_56_0_g59011 > 0.0 )
					ifLocalVar87_g59011 = temp_output_52_0_g59011;
					else if( temp_output_56_0_g59011 == 0.0 )
					ifLocalVar87_g59011 = temp_output_125_0_g59011;
					else if( temp_output_56_0_g59011 < 0.0 )
					ifLocalVar87_g59011 = temp_output_125_0_g59011;
					float3 temp_output_7_0_g59012 = frac( ( (ifLocalVar87_g59011).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59012 = dot( temp_output_7_0_g59012 , ( (temp_output_7_0_g59012).yzx + 33.33 ) );
					float3 temp_output_12_0_g59012 = ( temp_output_7_0_g59012 + dotResult8_g59012 );
					float2 temp_output_597_0_g59010 = ( UV100_g59011 + frac( ( ( (temp_output_12_0_g59012).xx + (temp_output_12_0_g59012).yz ) * (temp_output_12_0_g59012).zy ) ) );
					float2 DDX631_g59010 = ddx( temp_output_5_0_g59010 );
					float2 DDY632_g59010 = ddy( temp_output_5_0_g59010 );
					float temp_output_65_0_g59011 = ( 0.0 - temp_output_56_0_g59011 );
					float ifLocalVar59_g59011 = 0;
					if( temp_output_56_0_g59011 <= 0.0 )
					ifLocalVar59_g59011 = temp_output_65_0_g59011;
					else
					ifLocalVar59_g59011 = temp_output_56_0_g59011;
					float temp_output_597_30_g59010 = ifLocalVar59_g59011;
					float2 temp_output_90_0_g59011 = ( temp_output_52_0_g59011 + float2( 0,1 ) );
					float2 temp_output_123_0_g59011 = ( temp_output_52_0_g59011 + float2( 1,0 ) );
					float2 ifLocalVar88_g59011 = 0;
					if( temp_output_56_0_g59011 > 0.0 )
					ifLocalVar88_g59011 = temp_output_90_0_g59011;
					else if( temp_output_56_0_g59011 == 0.0 )
					ifLocalVar88_g59011 = temp_output_123_0_g59011;
					else if( temp_output_56_0_g59011 < 0.0 )
					ifLocalVar88_g59011 = temp_output_123_0_g59011;
					float3 temp_output_7_0_g59013 = frac( ( (ifLocalVar88_g59011).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59013 = dot( temp_output_7_0_g59013 , ( (temp_output_7_0_g59013).yzx + 33.33 ) );
					float3 temp_output_12_0_g59013 = ( temp_output_7_0_g59013 + dotResult8_g59013 );
					float2 temp_output_597_26_g59010 = ( UV100_g59011 + frac( ( ( (temp_output_12_0_g59013).xx + (temp_output_12_0_g59013).yz ) * (temp_output_12_0_g59013).zy ) ) );
					float temp_output_66_0_g59011 = ( 1.0 - break55_g59011.y );
					float ifLocalVar60_g59011 = 0;
					if( temp_output_56_0_g59011 <= 0.0 )
					ifLocalVar60_g59011 = temp_output_66_0_g59011;
					else
					ifLocalVar60_g59011 = break55_g59011.y;
					float temp_output_597_28_g59010 = ifLocalVar60_g59011;
					float2 ifLocalVar89_g59011 = 0;
					if( temp_output_56_0_g59011 > 0.0 )
					ifLocalVar89_g59011 = temp_output_123_0_g59011;
					else if( temp_output_56_0_g59011 == 0.0 )
					ifLocalVar89_g59011 = temp_output_90_0_g59011;
					else if( temp_output_56_0_g59011 < 0.0 )
					ifLocalVar89_g59011 = temp_output_90_0_g59011;
					float3 temp_output_7_0_g59014 = frac( ( (ifLocalVar89_g59011).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59014 = dot( temp_output_7_0_g59014 , ( (temp_output_7_0_g59014).yzx + 33.33 ) );
					float3 temp_output_12_0_g59014 = ( temp_output_7_0_g59014 + dotResult8_g59014 );
					float2 temp_output_597_27_g59010 = ( UV100_g59011 + frac( ( ( (temp_output_12_0_g59014).xx + (temp_output_12_0_g59014).yz ) * (temp_output_12_0_g59014).zy ) ) );
					float temp_output_67_0_g59011 = ( 1.0 - break55_g59011.x );
					float ifLocalVar61_g59011 = 0;
					if( temp_output_56_0_g59011 <= 0.0 )
					ifLocalVar61_g59011 = temp_output_67_0_g59011;
					else
					ifLocalVar61_g59011 = break55_g59011.x;
					float temp_output_597_29_g59010 = ifLocalVar61_g59011;
					float4 Output_2D293_g59010 = ( ( tex2D( _GlossinessMap, temp_output_597_0_g59010, DDX631_g59010, DDY632_g59010 ) * temp_output_597_30_g59010 ) + ( tex2D( _GlossinessMap, temp_output_597_26_g59010, DDX631_g59010, DDY632_g59010 ) * temp_output_597_28_g59010 ) + ( tex2D( _GlossinessMap, temp_output_597_27_g59010, DDX631_g59010, DDY632_g59010 ) * temp_output_597_29_g59010 ) );
					float4 break31_g59010 = Output_2D293_g59010;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g59004 = break31_g59010.a;
					#else
					float staticSwitch1004_g59004 = tex2D( _GlossinessMap, uv_GlossinessMap64_g59004 ).a;
					#endif
					float saferPower804_g59004 = abs( staticSwitch1004_g59004 );
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g59004 = ( 1.0 - pow( saferPower804_g59004 , 3.0 ) );
					#else
					float staticSwitch845_g59004 = _Glossiness;
					#endif
					float3 temp_output_3_0_g59041 = ddx( NormalWS );
					float dotResult5_g59041 = dot( temp_output_3_0_g59041 , temp_output_3_0_g59041 );
					float3 temp_output_4_0_g59041 = ddy( NormalWS );
					float dotResult6_g59041 = dot( temp_output_4_0_g59041 , temp_output_4_0_g59041 );
					#ifdef _USEGEOMETRICANTIALIASING_ON
					float staticSwitch824_g59004 = min( staticSwitch845_g59004 , ( 1.0 - pow( saturate( max( dotResult5_g59041 , dotResult6_g59041 ) ) , 0.333 ) ) );
					#else
					float staticSwitch824_g59004 = staticSwitch845_g59004;
					#endif
					#ifdef _LIGHTMAPDEBUG
					float staticSwitch1183_g59004 = Black1185_g59004;
					#else
					float staticSwitch1183_g59004 = staticSwitch824_g59004;
					#endif
					
					float4 temp_cast_8 = 0;
					float2 uv_EmissionMap81_g59004 = IN.ase_texcoord6.xy;
					float2 uv_EmissionMap = IN.ase_texcoord6.xy * _EmissionMap_ST.xy + _EmissionMap_ST.zw;
					float2 temp_output_5_0_g59005 = uv_EmissionMap;
					float2 UV633_g59005 = temp_output_5_0_g59005;
					float2 UV100_g59006 = UV633_g59005;
					float2 temp_output_51_0_g59006 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59006 * float2( 3.464,3.464 ) ) );
					float2 break55_g59006 = frac( temp_output_51_0_g59006 );
					float temp_output_56_0_g59006 = ( ( 1.0 - break55_g59006.x ) - break55_g59006.y );
					float2 temp_output_52_0_g59006 = floor( temp_output_51_0_g59006 );
					float2 temp_output_125_0_g59006 = ( temp_output_52_0_g59006 + float2( 1,1 ) );
					float2 ifLocalVar87_g59006 = 0;
					if( temp_output_56_0_g59006 > 0.0 )
					ifLocalVar87_g59006 = temp_output_52_0_g59006;
					else if( temp_output_56_0_g59006 == 0.0 )
					ifLocalVar87_g59006 = temp_output_125_0_g59006;
					else if( temp_output_56_0_g59006 < 0.0 )
					ifLocalVar87_g59006 = temp_output_125_0_g59006;
					float3 temp_output_7_0_g59007 = frac( ( (ifLocalVar87_g59006).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59007 = dot( temp_output_7_0_g59007 , ( (temp_output_7_0_g59007).yzx + 33.33 ) );
					float3 temp_output_12_0_g59007 = ( temp_output_7_0_g59007 + dotResult8_g59007 );
					float2 temp_output_597_0_g59005 = ( UV100_g59006 + frac( ( ( (temp_output_12_0_g59007).xx + (temp_output_12_0_g59007).yz ) * (temp_output_12_0_g59007).zy ) ) );
					float2 DDX631_g59005 = ddx( temp_output_5_0_g59005 );
					float2 DDY632_g59005 = ddy( temp_output_5_0_g59005 );
					float temp_output_65_0_g59006 = ( 0.0 - temp_output_56_0_g59006 );
					float ifLocalVar59_g59006 = 0;
					if( temp_output_56_0_g59006 <= 0.0 )
					ifLocalVar59_g59006 = temp_output_65_0_g59006;
					else
					ifLocalVar59_g59006 = temp_output_56_0_g59006;
					float temp_output_597_30_g59005 = ifLocalVar59_g59006;
					float2 temp_output_90_0_g59006 = ( temp_output_52_0_g59006 + float2( 0,1 ) );
					float2 temp_output_123_0_g59006 = ( temp_output_52_0_g59006 + float2( 1,0 ) );
					float2 ifLocalVar88_g59006 = 0;
					if( temp_output_56_0_g59006 > 0.0 )
					ifLocalVar88_g59006 = temp_output_90_0_g59006;
					else if( temp_output_56_0_g59006 == 0.0 )
					ifLocalVar88_g59006 = temp_output_123_0_g59006;
					else if( temp_output_56_0_g59006 < 0.0 )
					ifLocalVar88_g59006 = temp_output_123_0_g59006;
					float3 temp_output_7_0_g59008 = frac( ( (ifLocalVar88_g59006).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59008 = dot( temp_output_7_0_g59008 , ( (temp_output_7_0_g59008).yzx + 33.33 ) );
					float3 temp_output_12_0_g59008 = ( temp_output_7_0_g59008 + dotResult8_g59008 );
					float2 temp_output_597_26_g59005 = ( UV100_g59006 + frac( ( ( (temp_output_12_0_g59008).xx + (temp_output_12_0_g59008).yz ) * (temp_output_12_0_g59008).zy ) ) );
					float temp_output_66_0_g59006 = ( 1.0 - break55_g59006.y );
					float ifLocalVar60_g59006 = 0;
					if( temp_output_56_0_g59006 <= 0.0 )
					ifLocalVar60_g59006 = temp_output_66_0_g59006;
					else
					ifLocalVar60_g59006 = break55_g59006.y;
					float temp_output_597_28_g59005 = ifLocalVar60_g59006;
					float2 ifLocalVar89_g59006 = 0;
					if( temp_output_56_0_g59006 > 0.0 )
					ifLocalVar89_g59006 = temp_output_123_0_g59006;
					else if( temp_output_56_0_g59006 == 0.0 )
					ifLocalVar89_g59006 = temp_output_90_0_g59006;
					else if( temp_output_56_0_g59006 < 0.0 )
					ifLocalVar89_g59006 = temp_output_90_0_g59006;
					float3 temp_output_7_0_g59009 = frac( ( (ifLocalVar89_g59006).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59009 = dot( temp_output_7_0_g59009 , ( (temp_output_7_0_g59009).yzx + 33.33 ) );
					float3 temp_output_12_0_g59009 = ( temp_output_7_0_g59009 + dotResult8_g59009 );
					float2 temp_output_597_27_g59005 = ( UV100_g59006 + frac( ( ( (temp_output_12_0_g59009).xx + (temp_output_12_0_g59009).yz ) * (temp_output_12_0_g59009).zy ) ) );
					float temp_output_67_0_g59006 = ( 1.0 - break55_g59006.x );
					float ifLocalVar61_g59006 = 0;
					if( temp_output_56_0_g59006 <= 0.0 )
					ifLocalVar61_g59006 = temp_output_67_0_g59006;
					else
					ifLocalVar61_g59006 = break55_g59006.x;
					float temp_output_597_29_g59005 = ifLocalVar61_g59006;
					float4 Output_2D293_g59005 = ( ( tex2D( _EmissionMap, temp_output_597_0_g59005, DDX631_g59005, DDY632_g59005 ) * temp_output_597_30_g59005 ) + ( tex2D( _EmissionMap, temp_output_597_26_g59005, DDX631_g59005, DDY632_g59005 ) * temp_output_597_28_g59005 ) + ( tex2D( _EmissionMap, temp_output_597_27_g59005, DDX631_g59005, DDY632_g59005 ) * temp_output_597_29_g59005 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g59004 = Output_2D293_g59005;
					#else
					float4 staticSwitch1006_g59004 = tex2D( _EmissionMap, uv_EmissionMap81_g59004 );
					#endif
					#ifdef _EMISSIONENABLED_ON
					float4 staticSwitch1017_g59004 = ( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g59004 * _EmissionIntensity );
					#else
					float4 staticSwitch1017_g59004 = temp_cast_8;
					#endif
					float4 Emission86_g59004 = staticSwitch1017_g59004;
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1181_g59004 = Lightmap46_g59004;
					#else
					float4 staticSwitch1181_g59004 = ( ( Albedo6_g59004 * Lightmap46_g59004 ) + Emission86_g59004 );
					#endif
					float4 temp_output_35_0_g59047 = staticSwitch1181_g59004;
					float4 Color353_g59047 = temp_output_35_0_g59047;
					#if defined( _LUTMODE_2D )
					float4 staticSwitch273_g59047 = saturate( temp_output_35_0_g59047 );
					#elif defined( _LUTMODE_3D )
					float4 staticSwitch273_g59047 = temp_output_35_0_g59047;
					#else
					float4 staticSwitch273_g59047 = temp_output_35_0_g59047;
					#endif
					float4 Color_Saturate49_g59047 = staticSwitch273_g59047;
					float Lut_Height213_g59047 = _LUTSize;
					float Lut_Width216_g59047 = ( _LUTSize * Lut_Height213_g59047 );
					float3 appendResult214_g59047 = (float3(( 1.0 / Lut_Width216_g59047 ) , ( 1.0 / Lut_Height213_g59047 ) , ( Lut_Height213_g59047 - 1.0 )));
					float3 Scale_Offset208_g59047 = appendResult214_g59047;
					float2 Scale_Factor292_g59047 = ( (Scale_Offset208_g59047).xy * (Scale_Offset208_g59047).z );
					float2 Offset299_g59047 = ( (Scale_Offset208_g59047).xy * 0.5 );
					float3 Adjusted_UV305_g59047 = ( ( (Color_Saturate49_g59047).xyw * float3( Scale_Factor292_g59047 ,  0.0 ) ) + float3( Offset299_g59047 ,  0.0 ) );
					float2 Scaled_Blue280_g59047 = ( (Color_Saturate49_g59047).zw * (Scale_Offset208_g59047).z );
					float2 Shift288_g59047 = floor( Scaled_Blue280_g59047 );
					float2 Final_X313_g59047 = ( (Adjusted_UV305_g59047).xz + ( Shift288_g59047 * (Scale_Offset208_g59047).y ) );
					float2 appendResult326_g59047 = (float2(Final_X313_g59047.x , (Adjusted_UV305_g59047).yz.x));
					float2 Final_UV325_g59047 = appendResult326_g59047;
					float2 appendResult338_g59047 = (float2((Scale_Offset208_g59047).y , 0.0));
					float2 Offset_UV336_g59047 = ( Final_UV325_g59047 + appendResult338_g59047 );
					float3 lerpResult333_g59047 = lerp( tex2D( _2DLut, Final_UV325_g59047 ).rgb , tex2D( _2DLut, Offset_UV336_g59047 ).rgb , float3( ( Scaled_Blue280_g59047 - Shift288_g59047 ) ,  0.0 ));
					#ifdef _2DLUT
					float4 staticSwitch347_g59047 = float4( lerpResult333_g59047 , 0.0 );
					#else
					float4 staticSwitch347_g59047 = Color_Saturate49_g59047;
					#endif
					float4 TwoD_LUT346_g59047 = staticSwitch347_g59047;
					float3 RGB16_g59048 = ( ( log10( ( ( Color_Saturate49_g59047.xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 );
					#ifdef _3DLUT
					float4 staticSwitch194_g59047 = tex3D( _3DLut, RGB16_g59048 );
					#else
					float4 staticSwitch194_g59047 = Color_Saturate49_g59047;
					#endif
					float4 ThreeD_LUT51_g59047 = staticSwitch194_g59047;
					#if defined( _LUTMODE_2D )
					float4 staticSwitch42_g59047 = TwoD_LUT346_g59047;
					#elif defined( _LUTMODE_3D )
					float4 staticSwitch42_g59047 = ThreeD_LUT51_g59047;
					#else
					float4 staticSwitch42_g59047 = ThreeD_LUT51_g59047;
					#endif
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch41_g59047 = staticSwitch42_g59047;
					#else
					float4 staticSwitch41_g59047 = Color353_g59047;
					#endif
					
					#ifdef _LIGHTMAPDEBUG
					float staticSwitch1191_g59004 = Black1185_g59004;
					#else
					float staticSwitch1191_g59004 = temp_output_976_0_g59004.a;
					#endif
					

					o.Albedo = staticSwitch1180_g59004.rgb;
					o.Normal = Normal_Map700_g59004;

					half3 Specular = staticSwitch1188_g59004.rgb;
					half Metallic = 0;
					half Smoothness = staticSwitch1183_g59004;
					half Occlusion = saturate( Lightmap46_g59004 ).r;

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

					o.Emission = staticSwitch41_g59047.xyz;
					o.Alpha = staticSwitch1191_g59004;
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
						UNITY_APPLY_FOG( FogCoord, c );
					#endif
					return c;
				}
			ENDCG
		}

		
		Pass
		{
			
			Name "ForwardAdd"
			Tags { "LightMode"="ForwardAdd" }
			ZWrite Off
			Blend One One

			CGPROGRAM
				#define ASE_GEOMETRY
				#define ASE_FRAGMENT_NORMAL 0
				#pragma multi_compile _ LOD_FADE_CROSSFADE
				#pragma multi_compile_fog
				#define ASE_FOG
				#pragma multi_compile_local_fragment _SPECULARHIGHLIGHTS_OFF
				#pragma multi_compile_instancing
				#define _SPECULAR_SETUP 1
				#define ASE_VERSION 19904

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
				#define ASE_NEEDS_VERT_NORMAL
				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
				#define ASE_NEEDS_TEXTURE_COORDINATES2
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
				#define ASE_NEEDS_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_NORMAL
				#pragma shader_feature _LIGHTMAPDEBUG
				#pragma shader_feature_local _STOCHASTICENABLED_ON
				#pragma shader_feature_local_fragment _BUMPMAP
				#pragma shader_feature_local _LIGHTMAPMODE_DISABLED _LIGHTMAPMODE_SIMPLE _LIGHTMAPMODE_SIMPLELERP _LIGHTMAPMODE_RNM _LIGHTMAPMODE_RNMLERP
				#pragma shader_feature_local _USEBICUBICFILTERING_ON
				#pragma shader_feature_local_fragment _METALLICMAP
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
					float4 positionWS : TEXCOORD0; // xyz = positionWS, w = fogCoord
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
				uniform sampler2D _2DLut;
				uniform float _LUTSize;
				uniform sampler3D _3DLut;
				uniform float4 _Color;
				uniform sampler2D _MainTex;
				uniform float4 _MainTex_ST;
				uniform sampler2D _BumpMap;
				uniform float _NormalScale;
				uniform float4 _BumpMap_ST;
				uniform sampler2D _Lightmap0;
				uniform float4 _Lightmap0_ST;
				float4 _Lightmap0_TexelSize;
				uniform sampler2D _Lightmap1;
				uniform float4 _Lightmap1_ST;
				float4 _Lightmap1_TexelSize;
				uniform float _LIGHTMAPLERP;
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
				uniform float _Specular;
				uniform sampler2D _SpecularMap;
				uniform float4 _SpecularMap_ST;
				uniform float4 _SpecularColor;
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				uniform float4 _GlossinessMap_ST;
				uniform float3 _EmissionColor;
				uniform sampler2D _EmissionMap;
				uniform float4 _EmissionMap_ST;
				uniform float _EmissionIntensity;


				
				v2f VertexFunction (appdata v  ) {
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					o.ase_texcoord5.xy = v.texcoord.xyzw.xy;
					o.ase_texcoord5.zw = v.texcoord2.xyzw.xy;

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
					o.positionWS.xyz = positionWS;
					o.normalWS = normalWS;
					o.tangentWS = half4( tangentWS, v.tangent.w );

					UNITY_TRANSFER_LIGHTING(o, v.texcoord1.xy);
					#if defined( ASE_FOG )
						o.positionWS.w = o.pos.z;
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

				half4 frag ( v2f IN 
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
							UNITY_LIGHT_ATTENUATION( temp, IN, IN.positionWS.xyz )
							atten = temp;
						#else
							atten = 1;
						#endif
					}

					float3 PositionWS = IN.positionWS.xyz;
					half3 ViewDirWS = normalize( UnityWorldSpaceViewDir( PositionWS ) );
					float4 ScreenPosNorm = float4( IN.pos.xy * ( _ScreenParams.zw - 1.0 ), IN.pos.zw );
					float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, IN.pos.z ) * IN.pos.w;
					float4 ScreenPos = ComputeScreenPos( ClipPos );
					half3 NormalWS = IN.normalWS;
					half3 TangentWS = IN.tangentWS.xyz;
					half3 BitangentWS = cross( IN.normalWS, IN.tangentWS.xyz ) * IN.tangentWS.w * unity_WorldTransformParams.w;
					half3 LightAtten = atten;
					float FogCoord = IN.positionWS.w;

					#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
						float2 sampleCoords = (IN.tangentWS.zw / _TerrainHeightmapRecipSize.zw + 0.5f) * _TerrainHeightmapRecipSize.xy;
						NormalWS = UnityObjectToWorldNormal(normalize(tex2D(_TerrainNormalmapTexture, sampleCoords).rgb * 2 - 1));
						TangentWS = -cross(unity_ObjectToWorld._13_23_33, NormalWS);
						BitangentWS = cross(NormalWS, -TangentWS);
					#endif

					float2 uv_MainTex907_g59004 = IN.ase_texcoord5.xy;
					float4 tex2DNode907_g59004 = tex2D( _MainTex, uv_MainTex907_g59004 );
					float2 uv_MainTex = IN.ase_texcoord5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					float2 temp_output_5_0_g59020 = uv_MainTex;
					float2 UV633_g59020 = temp_output_5_0_g59020;
					float2 UV100_g59021 = UV633_g59020;
					float2 temp_output_51_0_g59021 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59021 * float2( 3.464,3.464 ) ) );
					float2 break55_g59021 = frac( temp_output_51_0_g59021 );
					float temp_output_56_0_g59021 = ( ( 1.0 - break55_g59021.x ) - break55_g59021.y );
					float2 temp_output_52_0_g59021 = floor( temp_output_51_0_g59021 );
					float2 temp_output_125_0_g59021 = ( temp_output_52_0_g59021 + float2( 1,1 ) );
					float2 ifLocalVar87_g59021 = 0;
					if( temp_output_56_0_g59021 > 0.0 )
					ifLocalVar87_g59021 = temp_output_52_0_g59021;
					else if( temp_output_56_0_g59021 == 0.0 )
					ifLocalVar87_g59021 = temp_output_125_0_g59021;
					else if( temp_output_56_0_g59021 < 0.0 )
					ifLocalVar87_g59021 = temp_output_125_0_g59021;
					float3 temp_output_7_0_g59022 = frac( ( (ifLocalVar87_g59021).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59022 = dot( temp_output_7_0_g59022 , ( (temp_output_7_0_g59022).yzx + 33.33 ) );
					float3 temp_output_12_0_g59022 = ( temp_output_7_0_g59022 + dotResult8_g59022 );
					float2 temp_output_597_0_g59020 = ( UV100_g59021 + frac( ( ( (temp_output_12_0_g59022).xx + (temp_output_12_0_g59022).yz ) * (temp_output_12_0_g59022).zy ) ) );
					float2 DDX631_g59020 = ddx( temp_output_5_0_g59020 );
					float2 DDY632_g59020 = ddy( temp_output_5_0_g59020 );
					float temp_output_65_0_g59021 = ( 0.0 - temp_output_56_0_g59021 );
					float ifLocalVar59_g59021 = 0;
					if( temp_output_56_0_g59021 <= 0.0 )
					ifLocalVar59_g59021 = temp_output_65_0_g59021;
					else
					ifLocalVar59_g59021 = temp_output_56_0_g59021;
					float temp_output_597_30_g59020 = ifLocalVar59_g59021;
					float2 temp_output_90_0_g59021 = ( temp_output_52_0_g59021 + float2( 0,1 ) );
					float2 temp_output_123_0_g59021 = ( temp_output_52_0_g59021 + float2( 1,0 ) );
					float2 ifLocalVar88_g59021 = 0;
					if( temp_output_56_0_g59021 > 0.0 )
					ifLocalVar88_g59021 = temp_output_90_0_g59021;
					else if( temp_output_56_0_g59021 == 0.0 )
					ifLocalVar88_g59021 = temp_output_123_0_g59021;
					else if( temp_output_56_0_g59021 < 0.0 )
					ifLocalVar88_g59021 = temp_output_123_0_g59021;
					float3 temp_output_7_0_g59023 = frac( ( (ifLocalVar88_g59021).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59023 = dot( temp_output_7_0_g59023 , ( (temp_output_7_0_g59023).yzx + 33.33 ) );
					float3 temp_output_12_0_g59023 = ( temp_output_7_0_g59023 + dotResult8_g59023 );
					float2 temp_output_597_26_g59020 = ( UV100_g59021 + frac( ( ( (temp_output_12_0_g59023).xx + (temp_output_12_0_g59023).yz ) * (temp_output_12_0_g59023).zy ) ) );
					float temp_output_66_0_g59021 = ( 1.0 - break55_g59021.y );
					float ifLocalVar60_g59021 = 0;
					if( temp_output_56_0_g59021 <= 0.0 )
					ifLocalVar60_g59021 = temp_output_66_0_g59021;
					else
					ifLocalVar60_g59021 = break55_g59021.y;
					float temp_output_597_28_g59020 = ifLocalVar60_g59021;
					float2 ifLocalVar89_g59021 = 0;
					if( temp_output_56_0_g59021 > 0.0 )
					ifLocalVar89_g59021 = temp_output_123_0_g59021;
					else if( temp_output_56_0_g59021 == 0.0 )
					ifLocalVar89_g59021 = temp_output_90_0_g59021;
					else if( temp_output_56_0_g59021 < 0.0 )
					ifLocalVar89_g59021 = temp_output_90_0_g59021;
					float3 temp_output_7_0_g59024 = frac( ( (ifLocalVar89_g59021).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59024 = dot( temp_output_7_0_g59024 , ( (temp_output_7_0_g59024).yzx + 33.33 ) );
					float3 temp_output_12_0_g59024 = ( temp_output_7_0_g59024 + dotResult8_g59024 );
					float2 temp_output_597_27_g59020 = ( UV100_g59021 + frac( ( ( (temp_output_12_0_g59024).xx + (temp_output_12_0_g59024).yz ) * (temp_output_12_0_g59024).zy ) ) );
					float temp_output_67_0_g59021 = ( 1.0 - break55_g59021.x );
					float ifLocalVar61_g59021 = 0;
					if( temp_output_56_0_g59021 <= 0.0 )
					ifLocalVar61_g59021 = temp_output_67_0_g59021;
					else
					ifLocalVar61_g59021 = break55_g59021.x;
					float temp_output_597_29_g59020 = ifLocalVar61_g59021;
					float4 Output_2D293_g59020 = ( ( tex2D( _MainTex, temp_output_597_0_g59020, DDX631_g59020, DDY632_g59020 ) * temp_output_597_30_g59020 ) + ( tex2D( _MainTex, temp_output_597_26_g59020, DDX631_g59020, DDY632_g59020 ) * temp_output_597_28_g59020 ) + ( tex2D( _MainTex, temp_output_597_27_g59020, DDX631_g59020, DDY632_g59020 ) * temp_output_597_29_g59020 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g59004 = Output_2D293_g59020;
					#else
					float4 staticSwitch1001_g59004 = tex2DNode907_g59004;
					#endif
					float4 temp_output_976_0_g59004 = ( _Color * staticSwitch1001_g59004 );
					float4 Albedo6_g59004 = temp_output_976_0_g59004;
					float Black1185_g59004 = 0.0;
					float4 temp_cast_0 = (Black1185_g59004).xxxx;
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1180_g59004 = temp_cast_0;
					#else
					float4 staticSwitch1180_g59004 = Albedo6_g59004;
					#endif
					
					float2 uv_BumpMap830_g59004 = IN.ase_texcoord5.xy;
					float2 uv_BumpMap = IN.ase_texcoord5.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					float2 temp_output_5_0_g59015 = uv_BumpMap;
					float2 UV633_g59015 = temp_output_5_0_g59015;
					float2 UV100_g59016 = UV633_g59015;
					float2 temp_output_51_0_g59016 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59016 * float2( 3.464,3.464 ) ) );
					float2 break55_g59016 = frac( temp_output_51_0_g59016 );
					float temp_output_56_0_g59016 = ( ( 1.0 - break55_g59016.x ) - break55_g59016.y );
					float2 temp_output_52_0_g59016 = floor( temp_output_51_0_g59016 );
					float2 temp_output_125_0_g59016 = ( temp_output_52_0_g59016 + float2( 1,1 ) );
					float2 ifLocalVar87_g59016 = 0;
					if( temp_output_56_0_g59016 > 0.0 )
					ifLocalVar87_g59016 = temp_output_52_0_g59016;
					else if( temp_output_56_0_g59016 == 0.0 )
					ifLocalVar87_g59016 = temp_output_125_0_g59016;
					else if( temp_output_56_0_g59016 < 0.0 )
					ifLocalVar87_g59016 = temp_output_125_0_g59016;
					float3 temp_output_7_0_g59017 = frac( ( (ifLocalVar87_g59016).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59017 = dot( temp_output_7_0_g59017 , ( (temp_output_7_0_g59017).yzx + 33.33 ) );
					float3 temp_output_12_0_g59017 = ( temp_output_7_0_g59017 + dotResult8_g59017 );
					float2 temp_output_597_0_g59015 = ( UV100_g59016 + frac( ( ( (temp_output_12_0_g59017).xx + (temp_output_12_0_g59017).yz ) * (temp_output_12_0_g59017).zy ) ) );
					float2 DDX631_g59015 = ddx( temp_output_5_0_g59015 );
					float2 DDY632_g59015 = ddy( temp_output_5_0_g59015 );
					float Input_Scale617_g59015 = _NormalScale;
					float temp_output_65_0_g59016 = ( 0.0 - temp_output_56_0_g59016 );
					float ifLocalVar59_g59016 = 0;
					if( temp_output_56_0_g59016 <= 0.0 )
					ifLocalVar59_g59016 = temp_output_65_0_g59016;
					else
					ifLocalVar59_g59016 = temp_output_56_0_g59016;
					float temp_output_597_30_g59015 = ifLocalVar59_g59016;
					float2 temp_output_90_0_g59016 = ( temp_output_52_0_g59016 + float2( 0,1 ) );
					float2 temp_output_123_0_g59016 = ( temp_output_52_0_g59016 + float2( 1,0 ) );
					float2 ifLocalVar88_g59016 = 0;
					if( temp_output_56_0_g59016 > 0.0 )
					ifLocalVar88_g59016 = temp_output_90_0_g59016;
					else if( temp_output_56_0_g59016 == 0.0 )
					ifLocalVar88_g59016 = temp_output_123_0_g59016;
					else if( temp_output_56_0_g59016 < 0.0 )
					ifLocalVar88_g59016 = temp_output_123_0_g59016;
					float3 temp_output_7_0_g59018 = frac( ( (ifLocalVar88_g59016).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59018 = dot( temp_output_7_0_g59018 , ( (temp_output_7_0_g59018).yzx + 33.33 ) );
					float3 temp_output_12_0_g59018 = ( temp_output_7_0_g59018 + dotResult8_g59018 );
					float2 temp_output_597_26_g59015 = ( UV100_g59016 + frac( ( ( (temp_output_12_0_g59018).xx + (temp_output_12_0_g59018).yz ) * (temp_output_12_0_g59018).zy ) ) );
					float temp_output_66_0_g59016 = ( 1.0 - break55_g59016.y );
					float ifLocalVar60_g59016 = 0;
					if( temp_output_56_0_g59016 <= 0.0 )
					ifLocalVar60_g59016 = temp_output_66_0_g59016;
					else
					ifLocalVar60_g59016 = break55_g59016.y;
					float temp_output_597_28_g59015 = ifLocalVar60_g59016;
					float2 ifLocalVar89_g59016 = 0;
					if( temp_output_56_0_g59016 > 0.0 )
					ifLocalVar89_g59016 = temp_output_123_0_g59016;
					else if( temp_output_56_0_g59016 == 0.0 )
					ifLocalVar89_g59016 = temp_output_90_0_g59016;
					else if( temp_output_56_0_g59016 < 0.0 )
					ifLocalVar89_g59016 = temp_output_90_0_g59016;
					float3 temp_output_7_0_g59019 = frac( ( (ifLocalVar89_g59016).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59019 = dot( temp_output_7_0_g59019 , ( (temp_output_7_0_g59019).yzx + 33.33 ) );
					float3 temp_output_12_0_g59019 = ( temp_output_7_0_g59019 + dotResult8_g59019 );
					float2 temp_output_597_27_g59015 = ( UV100_g59016 + frac( ( ( (temp_output_12_0_g59019).xx + (temp_output_12_0_g59019).yz ) * (temp_output_12_0_g59019).zy ) ) );
					float temp_output_67_0_g59016 = ( 1.0 - break55_g59016.x );
					float ifLocalVar61_g59016 = 0;
					if( temp_output_56_0_g59016 <= 0.0 )
					ifLocalVar61_g59016 = temp_output_67_0_g59016;
					else
					ifLocalVar61_g59016 = break55_g59016.x;
					float temp_output_597_29_g59015 = ifLocalVar61_g59016;
					float3 Output_2D_Normal641_g59015 = ( ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_0_g59015, DDX631_g59015, DDY632_g59015 ), Input_Scale617_g59015 ) * temp_output_597_30_g59015 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_26_g59015, DDX631_g59015, DDY632_g59015 ), Input_Scale617_g59015 ) * temp_output_597_28_g59015 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_27_g59015, DDX631_g59015, DDY632_g59015 ), Input_Scale617_g59015 ) * float3( 0,0,0 ) * temp_output_597_29_g59015 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g59004 = Output_2D_Normal641_g59015;
					#else
					float3 staticSwitch1003_g59004 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap830_g59004 ), _NormalScale );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g59004 = staticSwitch1003_g59004;
					#else
					float3 staticSwitch980_g59004 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g59004 = staticSwitch980_g59004;
					
					float White38_g59004 = 1.0;
					float4 temp_cast_2 = (White38_g59004).xxxx;
					float2 texCoord1093_g59004 = IN.ase_texcoord5.zw * float2( 1,1 ) + float2( 0,0 );
					float localBicubicPrepare2_g59033 = ( 0.0 );
					float2 uv3_Lightmap0 = IN.ase_texcoord5.zw * _Lightmap0_ST.xy + _Lightmap0_ST.zw;
					float2 Input_UV100_g59033 = uv3_Lightmap0;
					float2 UV2_g59033 = Input_UV100_g59033;
					float4 TexelSize2_g59033 = _Lightmap0_TexelSize;
					float2 UV02_g59033 = float2( 0,0 );
					float2 UV12_g59033 = float2( 0,0 );
					float2 UV22_g59033 = float2( 0,0 );
					float2 UV32_g59033 = float2( 0,0 );
					float W02_g59033 = 0;
					float W12_g59033 = 0;
					{
					{
					 UV2_g59033 = UV2_g59033 * TexelSize2_g59033.zw - 0.5;
					    float2 f = frac( UV2_g59033 );
					    UV2_g59033 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59033.x - 0.5, UV2_g59033.x + 1.5, UV2_g59033.y - 0.5, UV2_g59033.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59033.xyxy;
					    UV02_g59033 = off.xz;
					    UV12_g59033 = off.yz;
					    UV22_g59033 = off.xw;
					    UV32_g59033 = off.yw;
					    W02_g59033 = s.x / ( s.x + s.y );
					 W12_g59033 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59033 = lerp( tex2D( _Lightmap0, UV32_g59033 ) , tex2D( _Lightmap0, UV22_g59033 ) , W02_g59033);
					float4 lerpResult45_g59033 = lerp( tex2D( _Lightmap0, UV12_g59033 ) , tex2D( _Lightmap0, UV02_g59033 ) , W02_g59033);
					float4 lerpResult44_g59033 = lerp( lerpResult46_g59033 , lerpResult45_g59033 , W12_g59033);
					float4 Output_2D131_g59033 = lerpResult44_g59033;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g59004 = Output_2D131_g59033;
					#else
					float4 staticSwitch1092_g59004 = tex2D( _Lightmap0, texCoord1093_g59004 );
					#endif
					float4 Lightmap_0925_g59004 = staticSwitch1092_g59004;
					float2 texCoord1090_g59004 = IN.ase_texcoord5.zw * float2( 1,1 ) + float2( 0,0 );
					float localBicubicPrepare2_g59031 = ( 0.0 );
					float2 uv3_Lightmap1 = IN.ase_texcoord5.zw * _Lightmap1_ST.xy + _Lightmap1_ST.zw;
					float2 Input_UV100_g59031 = uv3_Lightmap1;
					float2 UV2_g59031 = Input_UV100_g59031;
					float4 TexelSize2_g59031 = _Lightmap1_TexelSize;
					float2 UV02_g59031 = float2( 0,0 );
					float2 UV12_g59031 = float2( 0,0 );
					float2 UV22_g59031 = float2( 0,0 );
					float2 UV32_g59031 = float2( 0,0 );
					float W02_g59031 = 0;
					float W12_g59031 = 0;
					{
					{
					 UV2_g59031 = UV2_g59031 * TexelSize2_g59031.zw - 0.5;
					    float2 f = frac( UV2_g59031 );
					    UV2_g59031 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59031.x - 0.5, UV2_g59031.x + 1.5, UV2_g59031.y - 0.5, UV2_g59031.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59031.xyxy;
					    UV02_g59031 = off.xz;
					    UV12_g59031 = off.yz;
					    UV22_g59031 = off.xw;
					    UV32_g59031 = off.yw;
					    W02_g59031 = s.x / ( s.x + s.y );
					 W12_g59031 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59031 = lerp( tex2D( _Lightmap1, UV32_g59031 ) , tex2D( _Lightmap1, UV22_g59031 ) , W02_g59031);
					float4 lerpResult45_g59031 = lerp( tex2D( _Lightmap1, UV12_g59031 ) , tex2D( _Lightmap1, UV02_g59031 ) , W02_g59031);
					float4 lerpResult44_g59031 = lerp( lerpResult46_g59031 , lerpResult45_g59031 , W12_g59031);
					float4 Output_2D131_g59031 = lerpResult44_g59031;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g59004 = Output_2D131_g59031;
					#else
					float4 staticSwitch1088_g59004 = tex2D( _Lightmap1, texCoord1090_g59004 );
					#endif
					float4 Lightmap_1956_g59004 = staticSwitch1088_g59004;
					float4 lerpResult442_g59004 = lerp( Lightmap_0925_g59004 , Lightmap_1956_g59004 , _LIGHTMAPLERP);
					float4 Lightmap_Lerp932_g59004 = lerpResult442_g59004;
					float3 appendResult139_g59040 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g59040 = normalize( Normal_Map700_g59004 );
					float3 Normal_Map318_g59040 = normalizeResult326_g59040;
					float dotResult121_g59040 = dot( appendResult139_g59040 , Normal_Map318_g59040 );
					float2 texCoord1070_g59004 = IN.ase_texcoord5.zw * float2( 1,1 ) + float2( 0,0 );
					float localStochasticTiling2_g59035 = ( 0.0 );
					float2 uv3_RNMX0 = IN.ase_texcoord5.zw * _RNMX0_ST.xy + _RNMX0_ST.zw;
					float2 UV2_g59035 = uv3_RNMX0;
					float4 TexelSize2_g59035 = _RNMX0_TexelSize;
					float4 Offsets2_g59035 = float4( 0,0,0,0 );
					float2 Weights2_g59035 = float2( 0,0 );
					{
					UV2_g59035 = UV2_g59035 * TexelSize2_g59035.zw - 0.5;
					float2 f = frac( UV2_g59035 );
					UV2_g59035 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g59035.x - 0.5, UV2_g59035.x + 1.5, UV2_g59035.y - 0.5, UV2_g59035.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g59035 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59035.xyxy;
					Weights2_g59035 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g59034 = Offsets2_g59035;
					float4 Input_FetchOffsets197_g59038 = temp_output_1_34_g59034;
					float2 temp_output_1_54_g59034 = Weights2_g59035;
					float2 Input_FetchWeights200_g59038 = temp_output_1_54_g59034;
					float2 break187_g59038 = Input_FetchWeights200_g59038;
					float4 lerpResult181_g59038 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g59038).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g59038).xw ) , break187_g59038.x);
					float4 lerpResult182_g59038 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g59038).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g59038).xz ) , break187_g59038.x);
					float4 lerpResult176_g59038 = lerp( lerpResult181_g59038 , lerpResult182_g59038 , break187_g59038.y);
					float4 Output_Fetch2D202_g59038 = lerpResult176_g59038;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g59004 = Output_Fetch2D202_g59038;
					#else
					float4 staticSwitch1061_g59004 = tex2D( _RNMX0, texCoord1070_g59004 );
					#endif
					float3 appendResult146_g59040 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59040 = dot( appendResult146_g59040 , Normal_Map318_g59040 );
					float4 Input_FetchOffsets197_g59036 = temp_output_1_34_g59034;
					float2 Input_FetchWeights200_g59036 = temp_output_1_54_g59034;
					float2 break187_g59036 = Input_FetchWeights200_g59036;
					float4 lerpResult181_g59036 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g59036).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g59036).xw ) , break187_g59036.x);
					float4 lerpResult182_g59036 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g59036).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g59036).xz ) , break187_g59036.x);
					float4 lerpResult176_g59036 = lerp( lerpResult181_g59036 , lerpResult182_g59036 , break187_g59036.y);
					float4 Output_Fetch2D202_g59036 = lerpResult176_g59036;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g59004 = Output_Fetch2D202_g59036;
					#else
					float4 staticSwitch1062_g59004 = tex2D( _RNMY0, texCoord1070_g59004 );
					#endif
					float3 appendResult149_g59040 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59040 = dot( appendResult149_g59040 , Normal_Map318_g59040 );
					float4 Input_FetchOffsets197_g59037 = temp_output_1_34_g59034;
					float2 Input_FetchWeights200_g59037 = temp_output_1_54_g59034;
					float2 break187_g59037 = Input_FetchWeights200_g59037;
					float4 lerpResult181_g59037 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g59037).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g59037).xw ) , break187_g59037.x);
					float4 lerpResult182_g59037 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g59037).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g59037).xz ) , break187_g59037.x);
					float4 lerpResult176_g59037 = lerp( lerpResult181_g59037 , lerpResult182_g59037 , break187_g59037.y);
					float4 Output_Fetch2D202_g59037 = lerpResult176_g59037;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g59004 = Output_Fetch2D202_g59037;
					#else
					float4 staticSwitch1063_g59004 = tex2D( _RNMZ0, texCoord1070_g59004 );
					#endif
					float4 RNM_0926_g59004 = ( ( ( saturate( dotResult121_g59040 ) * ( staticSwitch1061_g59004 * 0.33334 ) ) + ( saturate( dotResult122_g59040 ) * ( staticSwitch1062_g59004 * 0.33334 ) ) ) + ( saturate( dotResult120_g59040 ) * ( staticSwitch1063_g59004 * 0.33334 ) ) );
					float3 appendResult139_g59039 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g59039 = normalize( Normal_Map700_g59004 );
					float3 Normal_Map318_g59039 = normalizeResult326_g59039;
					float dotResult121_g59039 = dot( appendResult139_g59039 , Normal_Map318_g59039 );
					float2 texCoord1086_g59004 = IN.ase_texcoord5.zw * float2( 1,1 ) + float2( 0,0 );
					float localStochasticTiling2_g59026 = ( 0.0 );
					float2 uv3_RNMX1 = IN.ase_texcoord5.zw * _RNMX1_ST.xy + _RNMX1_ST.zw;
					float2 UV2_g59026 = uv3_RNMX1;
					float4 TexelSize2_g59026 = _RNMX1_TexelSize;
					float4 Offsets2_g59026 = float4( 0,0,0,0 );
					float2 Weights2_g59026 = float2( 0,0 );
					{
					UV2_g59026 = UV2_g59026 * TexelSize2_g59026.zw - 0.5;
					float2 f = frac( UV2_g59026 );
					UV2_g59026 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g59026.x - 0.5, UV2_g59026.x + 1.5, UV2_g59026.y - 0.5, UV2_g59026.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g59026 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59026.xyxy;
					Weights2_g59026 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g59025 = Offsets2_g59026;
					float4 Input_FetchOffsets197_g59029 = temp_output_1_34_g59025;
					float2 temp_output_1_54_g59025 = Weights2_g59026;
					float2 Input_FetchWeights200_g59029 = temp_output_1_54_g59025;
					float2 break187_g59029 = Input_FetchWeights200_g59029;
					float4 lerpResult181_g59029 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g59029).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g59029).xw ) , break187_g59029.x);
					float4 lerpResult182_g59029 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g59029).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g59029).xz ) , break187_g59029.x);
					float4 lerpResult176_g59029 = lerp( lerpResult181_g59029 , lerpResult182_g59029 , break187_g59029.y);
					float4 Output_Fetch2D202_g59029 = lerpResult176_g59029;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g59004 = Output_Fetch2D202_g59029;
					#else
					float4 staticSwitch1087_g59004 = tex2D( _RNMX1, texCoord1086_g59004 );
					#endif
					float3 appendResult146_g59039 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59039 = dot( appendResult146_g59039 , Normal_Map318_g59039 );
					float4 Input_FetchOffsets197_g59027 = temp_output_1_34_g59025;
					float2 Input_FetchWeights200_g59027 = temp_output_1_54_g59025;
					float2 break187_g59027 = Input_FetchWeights200_g59027;
					float4 lerpResult181_g59027 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g59027).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g59027).xw ) , break187_g59027.x);
					float4 lerpResult182_g59027 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g59027).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g59027).xz ) , break187_g59027.x);
					float4 lerpResult176_g59027 = lerp( lerpResult181_g59027 , lerpResult182_g59027 , break187_g59027.y);
					float4 Output_Fetch2D202_g59027 = lerpResult176_g59027;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g59004 = Output_Fetch2D202_g59027;
					#else
					float4 staticSwitch1083_g59004 = tex2D( _RNMY1, texCoord1086_g59004 );
					#endif
					float3 appendResult149_g59039 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59039 = dot( appendResult149_g59039 , Normal_Map318_g59039 );
					float4 Input_FetchOffsets197_g59028 = temp_output_1_34_g59025;
					float2 Input_FetchWeights200_g59028 = temp_output_1_54_g59025;
					float2 break187_g59028 = Input_FetchWeights200_g59028;
					float4 lerpResult181_g59028 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g59028).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g59028).xw ) , break187_g59028.x);
					float4 lerpResult182_g59028 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g59028).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g59028).xz ) , break187_g59028.x);
					float4 lerpResult176_g59028 = lerp( lerpResult181_g59028 , lerpResult182_g59028 , break187_g59028.y);
					float4 Output_Fetch2D202_g59028 = lerpResult176_g59028;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g59004 = Output_Fetch2D202_g59028;
					#else
					float4 staticSwitch1084_g59004 = tex2D( _RNMZ1, texCoord1086_g59004 );
					#endif
					float4 RNM_11081_g59004 = ( ( ( saturate( dotResult121_g59039 ) * ( staticSwitch1087_g59004 * 0.33334 ) ) + ( saturate( dotResult122_g59039 ) * ( staticSwitch1083_g59004 * 0.33334 ) ) ) + ( saturate( dotResult120_g59039 ) * ( staticSwitch1084_g59004 * 0.33334 ) ) );
					float Lightmap_Lerp_Value969_g59004 = _LIGHTMAPLERP;
					float4 lerpResult953_g59004 = lerp( RNM_0926_g59004 , RNM_11081_g59004 , Lightmap_Lerp_Value969_g59004);
					float4 RNM_Lerp950_g59004 = lerpResult953_g59004;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g59004 = temp_cast_2;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g59004 = Lightmap_0925_g59004;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g59004 = Lightmap_Lerp932_g59004;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g59004 = RNM_0926_g59004;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g59004 = RNM_Lerp950_g59004;
					#else
					float4 staticSwitch1014_g59004 = temp_cast_2;
					#endif
					float4 Lightmap46_g59004 = staticSwitch1014_g59004;
					float2 uv_SpecularMap48_g59004 = IN.ase_texcoord5.xy;
					float2 uv_SpecularMap = IN.ase_texcoord5.xy * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
					float2 temp_output_5_0_g59042 = uv_SpecularMap;
					float2 UV633_g59042 = temp_output_5_0_g59042;
					float2 UV100_g59043 = UV633_g59042;
					float2 temp_output_51_0_g59043 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59043 * float2( 3.464,3.464 ) ) );
					float2 break55_g59043 = frac( temp_output_51_0_g59043 );
					float temp_output_56_0_g59043 = ( ( 1.0 - break55_g59043.x ) - break55_g59043.y );
					float2 temp_output_52_0_g59043 = floor( temp_output_51_0_g59043 );
					float2 temp_output_125_0_g59043 = ( temp_output_52_0_g59043 + float2( 1,1 ) );
					float2 ifLocalVar87_g59043 = 0;
					if( temp_output_56_0_g59043 > 0.0 )
					ifLocalVar87_g59043 = temp_output_52_0_g59043;
					else if( temp_output_56_0_g59043 == 0.0 )
					ifLocalVar87_g59043 = temp_output_125_0_g59043;
					else if( temp_output_56_0_g59043 < 0.0 )
					ifLocalVar87_g59043 = temp_output_125_0_g59043;
					float3 temp_output_7_0_g59044 = frac( ( (ifLocalVar87_g59043).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59044 = dot( temp_output_7_0_g59044 , ( (temp_output_7_0_g59044).yzx + 33.33 ) );
					float3 temp_output_12_0_g59044 = ( temp_output_7_0_g59044 + dotResult8_g59044 );
					float2 temp_output_597_0_g59042 = ( UV100_g59043 + frac( ( ( (temp_output_12_0_g59044).xx + (temp_output_12_0_g59044).yz ) * (temp_output_12_0_g59044).zy ) ) );
					float2 DDX631_g59042 = ddx( temp_output_5_0_g59042 );
					float2 DDY632_g59042 = ddy( temp_output_5_0_g59042 );
					float temp_output_65_0_g59043 = ( 0.0 - temp_output_56_0_g59043 );
					float ifLocalVar59_g59043 = 0;
					if( temp_output_56_0_g59043 <= 0.0 )
					ifLocalVar59_g59043 = temp_output_65_0_g59043;
					else
					ifLocalVar59_g59043 = temp_output_56_0_g59043;
					float temp_output_597_30_g59042 = ifLocalVar59_g59043;
					float2 temp_output_90_0_g59043 = ( temp_output_52_0_g59043 + float2( 0,1 ) );
					float2 temp_output_123_0_g59043 = ( temp_output_52_0_g59043 + float2( 1,0 ) );
					float2 ifLocalVar88_g59043 = 0;
					if( temp_output_56_0_g59043 > 0.0 )
					ifLocalVar88_g59043 = temp_output_90_0_g59043;
					else if( temp_output_56_0_g59043 == 0.0 )
					ifLocalVar88_g59043 = temp_output_123_0_g59043;
					else if( temp_output_56_0_g59043 < 0.0 )
					ifLocalVar88_g59043 = temp_output_123_0_g59043;
					float3 temp_output_7_0_g59045 = frac( ( (ifLocalVar88_g59043).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59045 = dot( temp_output_7_0_g59045 , ( (temp_output_7_0_g59045).yzx + 33.33 ) );
					float3 temp_output_12_0_g59045 = ( temp_output_7_0_g59045 + dotResult8_g59045 );
					float2 temp_output_597_26_g59042 = ( UV100_g59043 + frac( ( ( (temp_output_12_0_g59045).xx + (temp_output_12_0_g59045).yz ) * (temp_output_12_0_g59045).zy ) ) );
					float temp_output_66_0_g59043 = ( 1.0 - break55_g59043.y );
					float ifLocalVar60_g59043 = 0;
					if( temp_output_56_0_g59043 <= 0.0 )
					ifLocalVar60_g59043 = temp_output_66_0_g59043;
					else
					ifLocalVar60_g59043 = break55_g59043.y;
					float temp_output_597_28_g59042 = ifLocalVar60_g59043;
					float2 ifLocalVar89_g59043 = 0;
					if( temp_output_56_0_g59043 > 0.0 )
					ifLocalVar89_g59043 = temp_output_123_0_g59043;
					else if( temp_output_56_0_g59043 == 0.0 )
					ifLocalVar89_g59043 = temp_output_90_0_g59043;
					else if( temp_output_56_0_g59043 < 0.0 )
					ifLocalVar89_g59043 = temp_output_90_0_g59043;
					float3 temp_output_7_0_g59046 = frac( ( (ifLocalVar89_g59043).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59046 = dot( temp_output_7_0_g59046 , ( (temp_output_7_0_g59046).yzx + 33.33 ) );
					float3 temp_output_12_0_g59046 = ( temp_output_7_0_g59046 + dotResult8_g59046 );
					float2 temp_output_597_27_g59042 = ( UV100_g59043 + frac( ( ( (temp_output_12_0_g59046).xx + (temp_output_12_0_g59046).yz ) * (temp_output_12_0_g59046).zy ) ) );
					float temp_output_67_0_g59043 = ( 1.0 - break55_g59043.x );
					float ifLocalVar61_g59043 = 0;
					if( temp_output_56_0_g59043 <= 0.0 )
					ifLocalVar61_g59043 = temp_output_67_0_g59043;
					else
					ifLocalVar61_g59043 = break55_g59043.x;
					float temp_output_597_29_g59042 = ifLocalVar61_g59043;
					float4 Output_2D293_g59042 = ( ( tex2D( _SpecularMap, temp_output_597_0_g59042, DDX631_g59042, DDY632_g59042 ) * temp_output_597_30_g59042 ) + ( tex2D( _SpecularMap, temp_output_597_26_g59042, DDX631_g59042, DDY632_g59042 ) * temp_output_597_28_g59042 ) + ( tex2D( _SpecularMap, temp_output_597_27_g59042, DDX631_g59042, DDY632_g59042 ) * temp_output_597_29_g59042 ) );
					float4 break31_g59042 = Output_2D293_g59042;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g59004 = break31_g59042.a;
					#else
					float staticSwitch1005_g59004 = tex2D( _SpecularMap, uv_SpecularMap48_g59004 ).a;
					#endif
					#ifdef _METALLICMAP
					float staticSwitch846_g59004 = staticSwitch1005_g59004;
					#else
					float staticSwitch846_g59004 = _Specular;
					#endif
					float3 lerpResult1237_g59004 = lerp( _SpecularColor.rgb , float3( 1,1,1 ) , Albedo6_g59004.rgb);
					float4 DiffuseMap1235_g59004 = tex2DNode907_g59004;
					float4 temp_cast_5 = (Black1185_g59004).xxxx;
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1188_g59004 = temp_cast_5;
					#else
					float4 staticSwitch1188_g59004 = ( Lightmap46_g59004 * staticSwitch846_g59004 * float4( lerpResult1237_g59004 , 0.0 ) * DiffuseMap1235_g59004 );
					#endif
					
					float2 uv_GlossinessMap64_g59004 = IN.ase_texcoord5.xy;
					float2 uv_GlossinessMap = IN.ase_texcoord5.xy * _GlossinessMap_ST.xy + _GlossinessMap_ST.zw;
					float2 temp_output_5_0_g59010 = uv_GlossinessMap;
					float2 UV633_g59010 = temp_output_5_0_g59010;
					float2 UV100_g59011 = UV633_g59010;
					float2 temp_output_51_0_g59011 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59011 * float2( 3.464,3.464 ) ) );
					float2 break55_g59011 = frac( temp_output_51_0_g59011 );
					float temp_output_56_0_g59011 = ( ( 1.0 - break55_g59011.x ) - break55_g59011.y );
					float2 temp_output_52_0_g59011 = floor( temp_output_51_0_g59011 );
					float2 temp_output_125_0_g59011 = ( temp_output_52_0_g59011 + float2( 1,1 ) );
					float2 ifLocalVar87_g59011 = 0;
					if( temp_output_56_0_g59011 > 0.0 )
					ifLocalVar87_g59011 = temp_output_52_0_g59011;
					else if( temp_output_56_0_g59011 == 0.0 )
					ifLocalVar87_g59011 = temp_output_125_0_g59011;
					else if( temp_output_56_0_g59011 < 0.0 )
					ifLocalVar87_g59011 = temp_output_125_0_g59011;
					float3 temp_output_7_0_g59012 = frac( ( (ifLocalVar87_g59011).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59012 = dot( temp_output_7_0_g59012 , ( (temp_output_7_0_g59012).yzx + 33.33 ) );
					float3 temp_output_12_0_g59012 = ( temp_output_7_0_g59012 + dotResult8_g59012 );
					float2 temp_output_597_0_g59010 = ( UV100_g59011 + frac( ( ( (temp_output_12_0_g59012).xx + (temp_output_12_0_g59012).yz ) * (temp_output_12_0_g59012).zy ) ) );
					float2 DDX631_g59010 = ddx( temp_output_5_0_g59010 );
					float2 DDY632_g59010 = ddy( temp_output_5_0_g59010 );
					float temp_output_65_0_g59011 = ( 0.0 - temp_output_56_0_g59011 );
					float ifLocalVar59_g59011 = 0;
					if( temp_output_56_0_g59011 <= 0.0 )
					ifLocalVar59_g59011 = temp_output_65_0_g59011;
					else
					ifLocalVar59_g59011 = temp_output_56_0_g59011;
					float temp_output_597_30_g59010 = ifLocalVar59_g59011;
					float2 temp_output_90_0_g59011 = ( temp_output_52_0_g59011 + float2( 0,1 ) );
					float2 temp_output_123_0_g59011 = ( temp_output_52_0_g59011 + float2( 1,0 ) );
					float2 ifLocalVar88_g59011 = 0;
					if( temp_output_56_0_g59011 > 0.0 )
					ifLocalVar88_g59011 = temp_output_90_0_g59011;
					else if( temp_output_56_0_g59011 == 0.0 )
					ifLocalVar88_g59011 = temp_output_123_0_g59011;
					else if( temp_output_56_0_g59011 < 0.0 )
					ifLocalVar88_g59011 = temp_output_123_0_g59011;
					float3 temp_output_7_0_g59013 = frac( ( (ifLocalVar88_g59011).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59013 = dot( temp_output_7_0_g59013 , ( (temp_output_7_0_g59013).yzx + 33.33 ) );
					float3 temp_output_12_0_g59013 = ( temp_output_7_0_g59013 + dotResult8_g59013 );
					float2 temp_output_597_26_g59010 = ( UV100_g59011 + frac( ( ( (temp_output_12_0_g59013).xx + (temp_output_12_0_g59013).yz ) * (temp_output_12_0_g59013).zy ) ) );
					float temp_output_66_0_g59011 = ( 1.0 - break55_g59011.y );
					float ifLocalVar60_g59011 = 0;
					if( temp_output_56_0_g59011 <= 0.0 )
					ifLocalVar60_g59011 = temp_output_66_0_g59011;
					else
					ifLocalVar60_g59011 = break55_g59011.y;
					float temp_output_597_28_g59010 = ifLocalVar60_g59011;
					float2 ifLocalVar89_g59011 = 0;
					if( temp_output_56_0_g59011 > 0.0 )
					ifLocalVar89_g59011 = temp_output_123_0_g59011;
					else if( temp_output_56_0_g59011 == 0.0 )
					ifLocalVar89_g59011 = temp_output_90_0_g59011;
					else if( temp_output_56_0_g59011 < 0.0 )
					ifLocalVar89_g59011 = temp_output_90_0_g59011;
					float3 temp_output_7_0_g59014 = frac( ( (ifLocalVar89_g59011).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59014 = dot( temp_output_7_0_g59014 , ( (temp_output_7_0_g59014).yzx + 33.33 ) );
					float3 temp_output_12_0_g59014 = ( temp_output_7_0_g59014 + dotResult8_g59014 );
					float2 temp_output_597_27_g59010 = ( UV100_g59011 + frac( ( ( (temp_output_12_0_g59014).xx + (temp_output_12_0_g59014).yz ) * (temp_output_12_0_g59014).zy ) ) );
					float temp_output_67_0_g59011 = ( 1.0 - break55_g59011.x );
					float ifLocalVar61_g59011 = 0;
					if( temp_output_56_0_g59011 <= 0.0 )
					ifLocalVar61_g59011 = temp_output_67_0_g59011;
					else
					ifLocalVar61_g59011 = break55_g59011.x;
					float temp_output_597_29_g59010 = ifLocalVar61_g59011;
					float4 Output_2D293_g59010 = ( ( tex2D( _GlossinessMap, temp_output_597_0_g59010, DDX631_g59010, DDY632_g59010 ) * temp_output_597_30_g59010 ) + ( tex2D( _GlossinessMap, temp_output_597_26_g59010, DDX631_g59010, DDY632_g59010 ) * temp_output_597_28_g59010 ) + ( tex2D( _GlossinessMap, temp_output_597_27_g59010, DDX631_g59010, DDY632_g59010 ) * temp_output_597_29_g59010 ) );
					float4 break31_g59010 = Output_2D293_g59010;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g59004 = break31_g59010.a;
					#else
					float staticSwitch1004_g59004 = tex2D( _GlossinessMap, uv_GlossinessMap64_g59004 ).a;
					#endif
					float saferPower804_g59004 = abs( staticSwitch1004_g59004 );
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g59004 = ( 1.0 - pow( saferPower804_g59004 , 3.0 ) );
					#else
					float staticSwitch845_g59004 = _Glossiness;
					#endif
					float3 temp_output_3_0_g59041 = ddx( NormalWS );
					float dotResult5_g59041 = dot( temp_output_3_0_g59041 , temp_output_3_0_g59041 );
					float3 temp_output_4_0_g59041 = ddy( NormalWS );
					float dotResult6_g59041 = dot( temp_output_4_0_g59041 , temp_output_4_0_g59041 );
					#ifdef _USEGEOMETRICANTIALIASING_ON
					float staticSwitch824_g59004 = min( staticSwitch845_g59004 , ( 1.0 - pow( saturate( max( dotResult5_g59041 , dotResult6_g59041 ) ) , 0.333 ) ) );
					#else
					float staticSwitch824_g59004 = staticSwitch845_g59004;
					#endif
					#ifdef _LIGHTMAPDEBUG
					float staticSwitch1183_g59004 = Black1185_g59004;
					#else
					float staticSwitch1183_g59004 = staticSwitch824_g59004;
					#endif
					
					float4 temp_cast_8 = 0;
					float2 uv_EmissionMap81_g59004 = IN.ase_texcoord5.xy;
					float2 uv_EmissionMap = IN.ase_texcoord5.xy * _EmissionMap_ST.xy + _EmissionMap_ST.zw;
					float2 temp_output_5_0_g59005 = uv_EmissionMap;
					float2 UV633_g59005 = temp_output_5_0_g59005;
					float2 UV100_g59006 = UV633_g59005;
					float2 temp_output_51_0_g59006 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59006 * float2( 3.464,3.464 ) ) );
					float2 break55_g59006 = frac( temp_output_51_0_g59006 );
					float temp_output_56_0_g59006 = ( ( 1.0 - break55_g59006.x ) - break55_g59006.y );
					float2 temp_output_52_0_g59006 = floor( temp_output_51_0_g59006 );
					float2 temp_output_125_0_g59006 = ( temp_output_52_0_g59006 + float2( 1,1 ) );
					float2 ifLocalVar87_g59006 = 0;
					if( temp_output_56_0_g59006 > 0.0 )
					ifLocalVar87_g59006 = temp_output_52_0_g59006;
					else if( temp_output_56_0_g59006 == 0.0 )
					ifLocalVar87_g59006 = temp_output_125_0_g59006;
					else if( temp_output_56_0_g59006 < 0.0 )
					ifLocalVar87_g59006 = temp_output_125_0_g59006;
					float3 temp_output_7_0_g59007 = frac( ( (ifLocalVar87_g59006).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59007 = dot( temp_output_7_0_g59007 , ( (temp_output_7_0_g59007).yzx + 33.33 ) );
					float3 temp_output_12_0_g59007 = ( temp_output_7_0_g59007 + dotResult8_g59007 );
					float2 temp_output_597_0_g59005 = ( UV100_g59006 + frac( ( ( (temp_output_12_0_g59007).xx + (temp_output_12_0_g59007).yz ) * (temp_output_12_0_g59007).zy ) ) );
					float2 DDX631_g59005 = ddx( temp_output_5_0_g59005 );
					float2 DDY632_g59005 = ddy( temp_output_5_0_g59005 );
					float temp_output_65_0_g59006 = ( 0.0 - temp_output_56_0_g59006 );
					float ifLocalVar59_g59006 = 0;
					if( temp_output_56_0_g59006 <= 0.0 )
					ifLocalVar59_g59006 = temp_output_65_0_g59006;
					else
					ifLocalVar59_g59006 = temp_output_56_0_g59006;
					float temp_output_597_30_g59005 = ifLocalVar59_g59006;
					float2 temp_output_90_0_g59006 = ( temp_output_52_0_g59006 + float2( 0,1 ) );
					float2 temp_output_123_0_g59006 = ( temp_output_52_0_g59006 + float2( 1,0 ) );
					float2 ifLocalVar88_g59006 = 0;
					if( temp_output_56_0_g59006 > 0.0 )
					ifLocalVar88_g59006 = temp_output_90_0_g59006;
					else if( temp_output_56_0_g59006 == 0.0 )
					ifLocalVar88_g59006 = temp_output_123_0_g59006;
					else if( temp_output_56_0_g59006 < 0.0 )
					ifLocalVar88_g59006 = temp_output_123_0_g59006;
					float3 temp_output_7_0_g59008 = frac( ( (ifLocalVar88_g59006).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59008 = dot( temp_output_7_0_g59008 , ( (temp_output_7_0_g59008).yzx + 33.33 ) );
					float3 temp_output_12_0_g59008 = ( temp_output_7_0_g59008 + dotResult8_g59008 );
					float2 temp_output_597_26_g59005 = ( UV100_g59006 + frac( ( ( (temp_output_12_0_g59008).xx + (temp_output_12_0_g59008).yz ) * (temp_output_12_0_g59008).zy ) ) );
					float temp_output_66_0_g59006 = ( 1.0 - break55_g59006.y );
					float ifLocalVar60_g59006 = 0;
					if( temp_output_56_0_g59006 <= 0.0 )
					ifLocalVar60_g59006 = temp_output_66_0_g59006;
					else
					ifLocalVar60_g59006 = break55_g59006.y;
					float temp_output_597_28_g59005 = ifLocalVar60_g59006;
					float2 ifLocalVar89_g59006 = 0;
					if( temp_output_56_0_g59006 > 0.0 )
					ifLocalVar89_g59006 = temp_output_123_0_g59006;
					else if( temp_output_56_0_g59006 == 0.0 )
					ifLocalVar89_g59006 = temp_output_90_0_g59006;
					else if( temp_output_56_0_g59006 < 0.0 )
					ifLocalVar89_g59006 = temp_output_90_0_g59006;
					float3 temp_output_7_0_g59009 = frac( ( (ifLocalVar89_g59006).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59009 = dot( temp_output_7_0_g59009 , ( (temp_output_7_0_g59009).yzx + 33.33 ) );
					float3 temp_output_12_0_g59009 = ( temp_output_7_0_g59009 + dotResult8_g59009 );
					float2 temp_output_597_27_g59005 = ( UV100_g59006 + frac( ( ( (temp_output_12_0_g59009).xx + (temp_output_12_0_g59009).yz ) * (temp_output_12_0_g59009).zy ) ) );
					float temp_output_67_0_g59006 = ( 1.0 - break55_g59006.x );
					float ifLocalVar61_g59006 = 0;
					if( temp_output_56_0_g59006 <= 0.0 )
					ifLocalVar61_g59006 = temp_output_67_0_g59006;
					else
					ifLocalVar61_g59006 = break55_g59006.x;
					float temp_output_597_29_g59005 = ifLocalVar61_g59006;
					float4 Output_2D293_g59005 = ( ( tex2D( _EmissionMap, temp_output_597_0_g59005, DDX631_g59005, DDY632_g59005 ) * temp_output_597_30_g59005 ) + ( tex2D( _EmissionMap, temp_output_597_26_g59005, DDX631_g59005, DDY632_g59005 ) * temp_output_597_28_g59005 ) + ( tex2D( _EmissionMap, temp_output_597_27_g59005, DDX631_g59005, DDY632_g59005 ) * temp_output_597_29_g59005 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g59004 = Output_2D293_g59005;
					#else
					float4 staticSwitch1006_g59004 = tex2D( _EmissionMap, uv_EmissionMap81_g59004 );
					#endif
					#ifdef _EMISSIONENABLED_ON
					float4 staticSwitch1017_g59004 = ( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g59004 * _EmissionIntensity );
					#else
					float4 staticSwitch1017_g59004 = temp_cast_8;
					#endif
					float4 Emission86_g59004 = staticSwitch1017_g59004;
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1181_g59004 = Lightmap46_g59004;
					#else
					float4 staticSwitch1181_g59004 = ( ( Albedo6_g59004 * Lightmap46_g59004 ) + Emission86_g59004 );
					#endif
					float4 temp_output_35_0_g59047 = staticSwitch1181_g59004;
					float4 Color353_g59047 = temp_output_35_0_g59047;
					#if defined( _LUTMODE_2D )
					float4 staticSwitch273_g59047 = saturate( temp_output_35_0_g59047 );
					#elif defined( _LUTMODE_3D )
					float4 staticSwitch273_g59047 = temp_output_35_0_g59047;
					#else
					float4 staticSwitch273_g59047 = temp_output_35_0_g59047;
					#endif
					float4 Color_Saturate49_g59047 = staticSwitch273_g59047;
					float Lut_Height213_g59047 = _LUTSize;
					float Lut_Width216_g59047 = ( _LUTSize * Lut_Height213_g59047 );
					float3 appendResult214_g59047 = (float3(( 1.0 / Lut_Width216_g59047 ) , ( 1.0 / Lut_Height213_g59047 ) , ( Lut_Height213_g59047 - 1.0 )));
					float3 Scale_Offset208_g59047 = appendResult214_g59047;
					float2 Scale_Factor292_g59047 = ( (Scale_Offset208_g59047).xy * (Scale_Offset208_g59047).z );
					float2 Offset299_g59047 = ( (Scale_Offset208_g59047).xy * 0.5 );
					float3 Adjusted_UV305_g59047 = ( ( (Color_Saturate49_g59047).xyw * float3( Scale_Factor292_g59047 ,  0.0 ) ) + float3( Offset299_g59047 ,  0.0 ) );
					float2 Scaled_Blue280_g59047 = ( (Color_Saturate49_g59047).zw * (Scale_Offset208_g59047).z );
					float2 Shift288_g59047 = floor( Scaled_Blue280_g59047 );
					float2 Final_X313_g59047 = ( (Adjusted_UV305_g59047).xz + ( Shift288_g59047 * (Scale_Offset208_g59047).y ) );
					float2 appendResult326_g59047 = (float2(Final_X313_g59047.x , (Adjusted_UV305_g59047).yz.x));
					float2 Final_UV325_g59047 = appendResult326_g59047;
					float2 appendResult338_g59047 = (float2((Scale_Offset208_g59047).y , 0.0));
					float2 Offset_UV336_g59047 = ( Final_UV325_g59047 + appendResult338_g59047 );
					float3 lerpResult333_g59047 = lerp( tex2D( _2DLut, Final_UV325_g59047 ).rgb , tex2D( _2DLut, Offset_UV336_g59047 ).rgb , float3( ( Scaled_Blue280_g59047 - Shift288_g59047 ) ,  0.0 ));
					#ifdef _2DLUT
					float4 staticSwitch347_g59047 = float4( lerpResult333_g59047 , 0.0 );
					#else
					float4 staticSwitch347_g59047 = Color_Saturate49_g59047;
					#endif
					float4 TwoD_LUT346_g59047 = staticSwitch347_g59047;
					float3 RGB16_g59048 = ( ( log10( ( ( Color_Saturate49_g59047.xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 );
					#ifdef _3DLUT
					float4 staticSwitch194_g59047 = tex3D( _3DLut, RGB16_g59048 );
					#else
					float4 staticSwitch194_g59047 = Color_Saturate49_g59047;
					#endif
					float4 ThreeD_LUT51_g59047 = staticSwitch194_g59047;
					#if defined( _LUTMODE_2D )
					float4 staticSwitch42_g59047 = TwoD_LUT346_g59047;
					#elif defined( _LUTMODE_3D )
					float4 staticSwitch42_g59047 = ThreeD_LUT51_g59047;
					#else
					float4 staticSwitch42_g59047 = ThreeD_LUT51_g59047;
					#endif
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch41_g59047 = staticSwitch42_g59047;
					#else
					float4 staticSwitch41_g59047 = Color353_g59047;
					#endif
					
					#ifdef _LIGHTMAPDEBUG
					float staticSwitch1191_g59004 = Black1185_g59004;
					#else
					float staticSwitch1191_g59004 = temp_output_976_0_g59004.a;
					#endif
					

					o.Albedo = staticSwitch1180_g59004.rgb;
					o.Normal = Normal_Map700_g59004;

					half3 Specular = staticSwitch1188_g59004.rgb;
					half Metallic = 0;
					half Smoothness = staticSwitch1183_g59004;
					half Occlusion = saturate( Lightmap46_g59004 ).r;

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

					o.Emission = staticSwitch41_g59047.xyz;
					o.Alpha = staticSwitch1191_g59004;
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
						UNITY_APPLY_FOG( FogCoord, c );
					#endif
					return c;
				}
			ENDCG
		}

		
		Pass
		{
			
			Name "Meta"
			Tags { "LightMode"="Meta" }
			Cull Off

			CGPROGRAM
				#define ASE_GEOMETRY
				#define ASE_FRAGMENT_NORMAL 0
				#pragma multi_compile _ LOD_FADE_CROSSFADE
				#define ASE_FOG
				#pragma multi_compile_instancing
				#define _SPECULAR_SETUP 1
				#define ASE_VERSION 19904

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
				#define ASE_NEEDS_VERT_NORMAL
				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
				#define ASE_NEEDS_TEXTURE_COORDINATES2
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
				#pragma shader_feature _LIGHTMAPDEBUG
				#pragma shader_feature_local _STOCHASTICENABLED_ON
				#pragma shader_feature_local _LIGHTMAPMODE_DISABLED _LIGHTMAPMODE_SIMPLE _LIGHTMAPMODE_SIMPLELERP _LIGHTMAPMODE_RNM _LIGHTMAPMODE_RNMLERP
				#pragma shader_feature_local _USEBICUBICFILTERING_ON
				#pragma shader_feature_local_fragment _BUMPMAP
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
					#ifdef EDITOR_VISUALIZATION
						float2 vizUV : TEXCOORD0;
						float4 lightCoord : TEXCOORD1;
					#endif
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
				uniform sampler2D _2DLut;
				uniform float _LUTSize;
				uniform sampler3D _3DLut;
				uniform float4 _Color;
				uniform sampler2D _MainTex;
				uniform float4 _MainTex_ST;
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

					o.ase_texcoord2.xy = v.texcoord.xyzw.xy;
					o.ase_texcoord2.zw = v.texcoord2.xyzw.xy;

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

				half4 frag( v2f IN  ) : SV_Target
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

					float2 uv_MainTex907_g59004 = IN.ase_texcoord2.xy;
					float4 tex2DNode907_g59004 = tex2D( _MainTex, uv_MainTex907_g59004 );
					float2 uv_MainTex = IN.ase_texcoord2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					float2 temp_output_5_0_g59020 = uv_MainTex;
					float2 UV633_g59020 = temp_output_5_0_g59020;
					float2 UV100_g59021 = UV633_g59020;
					float2 temp_output_51_0_g59021 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59021 * float2( 3.464,3.464 ) ) );
					float2 break55_g59021 = frac( temp_output_51_0_g59021 );
					float temp_output_56_0_g59021 = ( ( 1.0 - break55_g59021.x ) - break55_g59021.y );
					float2 temp_output_52_0_g59021 = floor( temp_output_51_0_g59021 );
					float2 temp_output_125_0_g59021 = ( temp_output_52_0_g59021 + float2( 1,1 ) );
					float2 ifLocalVar87_g59021 = 0;
					if( temp_output_56_0_g59021 > 0.0 )
					ifLocalVar87_g59021 = temp_output_52_0_g59021;
					else if( temp_output_56_0_g59021 == 0.0 )
					ifLocalVar87_g59021 = temp_output_125_0_g59021;
					else if( temp_output_56_0_g59021 < 0.0 )
					ifLocalVar87_g59021 = temp_output_125_0_g59021;
					float3 temp_output_7_0_g59022 = frac( ( (ifLocalVar87_g59021).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59022 = dot( temp_output_7_0_g59022 , ( (temp_output_7_0_g59022).yzx + 33.33 ) );
					float3 temp_output_12_0_g59022 = ( temp_output_7_0_g59022 + dotResult8_g59022 );
					float2 temp_output_597_0_g59020 = ( UV100_g59021 + frac( ( ( (temp_output_12_0_g59022).xx + (temp_output_12_0_g59022).yz ) * (temp_output_12_0_g59022).zy ) ) );
					float2 DDX631_g59020 = ddx( temp_output_5_0_g59020 );
					float2 DDY632_g59020 = ddy( temp_output_5_0_g59020 );
					float temp_output_65_0_g59021 = ( 0.0 - temp_output_56_0_g59021 );
					float ifLocalVar59_g59021 = 0;
					if( temp_output_56_0_g59021 <= 0.0 )
					ifLocalVar59_g59021 = temp_output_65_0_g59021;
					else
					ifLocalVar59_g59021 = temp_output_56_0_g59021;
					float temp_output_597_30_g59020 = ifLocalVar59_g59021;
					float2 temp_output_90_0_g59021 = ( temp_output_52_0_g59021 + float2( 0,1 ) );
					float2 temp_output_123_0_g59021 = ( temp_output_52_0_g59021 + float2( 1,0 ) );
					float2 ifLocalVar88_g59021 = 0;
					if( temp_output_56_0_g59021 > 0.0 )
					ifLocalVar88_g59021 = temp_output_90_0_g59021;
					else if( temp_output_56_0_g59021 == 0.0 )
					ifLocalVar88_g59021 = temp_output_123_0_g59021;
					else if( temp_output_56_0_g59021 < 0.0 )
					ifLocalVar88_g59021 = temp_output_123_0_g59021;
					float3 temp_output_7_0_g59023 = frac( ( (ifLocalVar88_g59021).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59023 = dot( temp_output_7_0_g59023 , ( (temp_output_7_0_g59023).yzx + 33.33 ) );
					float3 temp_output_12_0_g59023 = ( temp_output_7_0_g59023 + dotResult8_g59023 );
					float2 temp_output_597_26_g59020 = ( UV100_g59021 + frac( ( ( (temp_output_12_0_g59023).xx + (temp_output_12_0_g59023).yz ) * (temp_output_12_0_g59023).zy ) ) );
					float temp_output_66_0_g59021 = ( 1.0 - break55_g59021.y );
					float ifLocalVar60_g59021 = 0;
					if( temp_output_56_0_g59021 <= 0.0 )
					ifLocalVar60_g59021 = temp_output_66_0_g59021;
					else
					ifLocalVar60_g59021 = break55_g59021.y;
					float temp_output_597_28_g59020 = ifLocalVar60_g59021;
					float2 ifLocalVar89_g59021 = 0;
					if( temp_output_56_0_g59021 > 0.0 )
					ifLocalVar89_g59021 = temp_output_123_0_g59021;
					else if( temp_output_56_0_g59021 == 0.0 )
					ifLocalVar89_g59021 = temp_output_90_0_g59021;
					else if( temp_output_56_0_g59021 < 0.0 )
					ifLocalVar89_g59021 = temp_output_90_0_g59021;
					float3 temp_output_7_0_g59024 = frac( ( (ifLocalVar89_g59021).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59024 = dot( temp_output_7_0_g59024 , ( (temp_output_7_0_g59024).yzx + 33.33 ) );
					float3 temp_output_12_0_g59024 = ( temp_output_7_0_g59024 + dotResult8_g59024 );
					float2 temp_output_597_27_g59020 = ( UV100_g59021 + frac( ( ( (temp_output_12_0_g59024).xx + (temp_output_12_0_g59024).yz ) * (temp_output_12_0_g59024).zy ) ) );
					float temp_output_67_0_g59021 = ( 1.0 - break55_g59021.x );
					float ifLocalVar61_g59021 = 0;
					if( temp_output_56_0_g59021 <= 0.0 )
					ifLocalVar61_g59021 = temp_output_67_0_g59021;
					else
					ifLocalVar61_g59021 = break55_g59021.x;
					float temp_output_597_29_g59020 = ifLocalVar61_g59021;
					float4 Output_2D293_g59020 = ( ( tex2D( _MainTex, temp_output_597_0_g59020, DDX631_g59020, DDY632_g59020 ) * temp_output_597_30_g59020 ) + ( tex2D( _MainTex, temp_output_597_26_g59020, DDX631_g59020, DDY632_g59020 ) * temp_output_597_28_g59020 ) + ( tex2D( _MainTex, temp_output_597_27_g59020, DDX631_g59020, DDY632_g59020 ) * temp_output_597_29_g59020 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g59004 = Output_2D293_g59020;
					#else
					float4 staticSwitch1001_g59004 = tex2DNode907_g59004;
					#endif
					float4 temp_output_976_0_g59004 = ( _Color * staticSwitch1001_g59004 );
					float4 Albedo6_g59004 = temp_output_976_0_g59004;
					float Black1185_g59004 = 0.0;
					float4 temp_cast_0 = (Black1185_g59004).xxxx;
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1180_g59004 = temp_cast_0;
					#else
					float4 staticSwitch1180_g59004 = Albedo6_g59004;
					#endif
					
					float White38_g59004 = 1.0;
					float4 temp_cast_2 = (White38_g59004).xxxx;
					float2 texCoord1093_g59004 = IN.ase_texcoord2.zw * float2( 1,1 ) + float2( 0,0 );
					float localBicubicPrepare2_g59033 = ( 0.0 );
					float2 uv3_Lightmap0 = IN.ase_texcoord2.zw * _Lightmap0_ST.xy + _Lightmap0_ST.zw;
					float2 Input_UV100_g59033 = uv3_Lightmap0;
					float2 UV2_g59033 = Input_UV100_g59033;
					float4 TexelSize2_g59033 = _Lightmap0_TexelSize;
					float2 UV02_g59033 = float2( 0,0 );
					float2 UV12_g59033 = float2( 0,0 );
					float2 UV22_g59033 = float2( 0,0 );
					float2 UV32_g59033 = float2( 0,0 );
					float W02_g59033 = 0;
					float W12_g59033 = 0;
					{
					{
					 UV2_g59033 = UV2_g59033 * TexelSize2_g59033.zw - 0.5;
					    float2 f = frac( UV2_g59033 );
					    UV2_g59033 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59033.x - 0.5, UV2_g59033.x + 1.5, UV2_g59033.y - 0.5, UV2_g59033.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59033.xyxy;
					    UV02_g59033 = off.xz;
					    UV12_g59033 = off.yz;
					    UV22_g59033 = off.xw;
					    UV32_g59033 = off.yw;
					    W02_g59033 = s.x / ( s.x + s.y );
					 W12_g59033 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59033 = lerp( tex2D( _Lightmap0, UV32_g59033 ) , tex2D( _Lightmap0, UV22_g59033 ) , W02_g59033);
					float4 lerpResult45_g59033 = lerp( tex2D( _Lightmap0, UV12_g59033 ) , tex2D( _Lightmap0, UV02_g59033 ) , W02_g59033);
					float4 lerpResult44_g59033 = lerp( lerpResult46_g59033 , lerpResult45_g59033 , W12_g59033);
					float4 Output_2D131_g59033 = lerpResult44_g59033;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g59004 = Output_2D131_g59033;
					#else
					float4 staticSwitch1092_g59004 = tex2D( _Lightmap0, texCoord1093_g59004 );
					#endif
					float4 Lightmap_0925_g59004 = staticSwitch1092_g59004;
					float2 texCoord1090_g59004 = IN.ase_texcoord2.zw * float2( 1,1 ) + float2( 0,0 );
					float localBicubicPrepare2_g59031 = ( 0.0 );
					float2 uv3_Lightmap1 = IN.ase_texcoord2.zw * _Lightmap1_ST.xy + _Lightmap1_ST.zw;
					float2 Input_UV100_g59031 = uv3_Lightmap1;
					float2 UV2_g59031 = Input_UV100_g59031;
					float4 TexelSize2_g59031 = _Lightmap1_TexelSize;
					float2 UV02_g59031 = float2( 0,0 );
					float2 UV12_g59031 = float2( 0,0 );
					float2 UV22_g59031 = float2( 0,0 );
					float2 UV32_g59031 = float2( 0,0 );
					float W02_g59031 = 0;
					float W12_g59031 = 0;
					{
					{
					 UV2_g59031 = UV2_g59031 * TexelSize2_g59031.zw - 0.5;
					    float2 f = frac( UV2_g59031 );
					    UV2_g59031 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59031.x - 0.5, UV2_g59031.x + 1.5, UV2_g59031.y - 0.5, UV2_g59031.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59031.xyxy;
					    UV02_g59031 = off.xz;
					    UV12_g59031 = off.yz;
					    UV22_g59031 = off.xw;
					    UV32_g59031 = off.yw;
					    W02_g59031 = s.x / ( s.x + s.y );
					 W12_g59031 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59031 = lerp( tex2D( _Lightmap1, UV32_g59031 ) , tex2D( _Lightmap1, UV22_g59031 ) , W02_g59031);
					float4 lerpResult45_g59031 = lerp( tex2D( _Lightmap1, UV12_g59031 ) , tex2D( _Lightmap1, UV02_g59031 ) , W02_g59031);
					float4 lerpResult44_g59031 = lerp( lerpResult46_g59031 , lerpResult45_g59031 , W12_g59031);
					float4 Output_2D131_g59031 = lerpResult44_g59031;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g59004 = Output_2D131_g59031;
					#else
					float4 staticSwitch1088_g59004 = tex2D( _Lightmap1, texCoord1090_g59004 );
					#endif
					float4 Lightmap_1956_g59004 = staticSwitch1088_g59004;
					float4 lerpResult442_g59004 = lerp( Lightmap_0925_g59004 , Lightmap_1956_g59004 , _LIGHTMAPLERP);
					float4 Lightmap_Lerp932_g59004 = lerpResult442_g59004;
					float3 appendResult139_g59040 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float2 uv_BumpMap830_g59004 = IN.ase_texcoord2.xy;
					float2 uv_BumpMap = IN.ase_texcoord2.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					float2 temp_output_5_0_g59015 = uv_BumpMap;
					float2 UV633_g59015 = temp_output_5_0_g59015;
					float2 UV100_g59016 = UV633_g59015;
					float2 temp_output_51_0_g59016 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59016 * float2( 3.464,3.464 ) ) );
					float2 break55_g59016 = frac( temp_output_51_0_g59016 );
					float temp_output_56_0_g59016 = ( ( 1.0 - break55_g59016.x ) - break55_g59016.y );
					float2 temp_output_52_0_g59016 = floor( temp_output_51_0_g59016 );
					float2 temp_output_125_0_g59016 = ( temp_output_52_0_g59016 + float2( 1,1 ) );
					float2 ifLocalVar87_g59016 = 0;
					if( temp_output_56_0_g59016 > 0.0 )
					ifLocalVar87_g59016 = temp_output_52_0_g59016;
					else if( temp_output_56_0_g59016 == 0.0 )
					ifLocalVar87_g59016 = temp_output_125_0_g59016;
					else if( temp_output_56_0_g59016 < 0.0 )
					ifLocalVar87_g59016 = temp_output_125_0_g59016;
					float3 temp_output_7_0_g59017 = frac( ( (ifLocalVar87_g59016).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59017 = dot( temp_output_7_0_g59017 , ( (temp_output_7_0_g59017).yzx + 33.33 ) );
					float3 temp_output_12_0_g59017 = ( temp_output_7_0_g59017 + dotResult8_g59017 );
					float2 temp_output_597_0_g59015 = ( UV100_g59016 + frac( ( ( (temp_output_12_0_g59017).xx + (temp_output_12_0_g59017).yz ) * (temp_output_12_0_g59017).zy ) ) );
					float2 DDX631_g59015 = ddx( temp_output_5_0_g59015 );
					float2 DDY632_g59015 = ddy( temp_output_5_0_g59015 );
					float Input_Scale617_g59015 = _NormalScale;
					float temp_output_65_0_g59016 = ( 0.0 - temp_output_56_0_g59016 );
					float ifLocalVar59_g59016 = 0;
					if( temp_output_56_0_g59016 <= 0.0 )
					ifLocalVar59_g59016 = temp_output_65_0_g59016;
					else
					ifLocalVar59_g59016 = temp_output_56_0_g59016;
					float temp_output_597_30_g59015 = ifLocalVar59_g59016;
					float2 temp_output_90_0_g59016 = ( temp_output_52_0_g59016 + float2( 0,1 ) );
					float2 temp_output_123_0_g59016 = ( temp_output_52_0_g59016 + float2( 1,0 ) );
					float2 ifLocalVar88_g59016 = 0;
					if( temp_output_56_0_g59016 > 0.0 )
					ifLocalVar88_g59016 = temp_output_90_0_g59016;
					else if( temp_output_56_0_g59016 == 0.0 )
					ifLocalVar88_g59016 = temp_output_123_0_g59016;
					else if( temp_output_56_0_g59016 < 0.0 )
					ifLocalVar88_g59016 = temp_output_123_0_g59016;
					float3 temp_output_7_0_g59018 = frac( ( (ifLocalVar88_g59016).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59018 = dot( temp_output_7_0_g59018 , ( (temp_output_7_0_g59018).yzx + 33.33 ) );
					float3 temp_output_12_0_g59018 = ( temp_output_7_0_g59018 + dotResult8_g59018 );
					float2 temp_output_597_26_g59015 = ( UV100_g59016 + frac( ( ( (temp_output_12_0_g59018).xx + (temp_output_12_0_g59018).yz ) * (temp_output_12_0_g59018).zy ) ) );
					float temp_output_66_0_g59016 = ( 1.0 - break55_g59016.y );
					float ifLocalVar60_g59016 = 0;
					if( temp_output_56_0_g59016 <= 0.0 )
					ifLocalVar60_g59016 = temp_output_66_0_g59016;
					else
					ifLocalVar60_g59016 = break55_g59016.y;
					float temp_output_597_28_g59015 = ifLocalVar60_g59016;
					float2 ifLocalVar89_g59016 = 0;
					if( temp_output_56_0_g59016 > 0.0 )
					ifLocalVar89_g59016 = temp_output_123_0_g59016;
					else if( temp_output_56_0_g59016 == 0.0 )
					ifLocalVar89_g59016 = temp_output_90_0_g59016;
					else if( temp_output_56_0_g59016 < 0.0 )
					ifLocalVar89_g59016 = temp_output_90_0_g59016;
					float3 temp_output_7_0_g59019 = frac( ( (ifLocalVar89_g59016).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59019 = dot( temp_output_7_0_g59019 , ( (temp_output_7_0_g59019).yzx + 33.33 ) );
					float3 temp_output_12_0_g59019 = ( temp_output_7_0_g59019 + dotResult8_g59019 );
					float2 temp_output_597_27_g59015 = ( UV100_g59016 + frac( ( ( (temp_output_12_0_g59019).xx + (temp_output_12_0_g59019).yz ) * (temp_output_12_0_g59019).zy ) ) );
					float temp_output_67_0_g59016 = ( 1.0 - break55_g59016.x );
					float ifLocalVar61_g59016 = 0;
					if( temp_output_56_0_g59016 <= 0.0 )
					ifLocalVar61_g59016 = temp_output_67_0_g59016;
					else
					ifLocalVar61_g59016 = break55_g59016.x;
					float temp_output_597_29_g59015 = ifLocalVar61_g59016;
					float3 Output_2D_Normal641_g59015 = ( ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_0_g59015, DDX631_g59015, DDY632_g59015 ), Input_Scale617_g59015 ) * temp_output_597_30_g59015 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_26_g59015, DDX631_g59015, DDY632_g59015 ), Input_Scale617_g59015 ) * temp_output_597_28_g59015 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_27_g59015, DDX631_g59015, DDY632_g59015 ), Input_Scale617_g59015 ) * float3( 0,0,0 ) * temp_output_597_29_g59015 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g59004 = Output_2D_Normal641_g59015;
					#else
					float3 staticSwitch1003_g59004 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap830_g59004 ), _NormalScale );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g59004 = staticSwitch1003_g59004;
					#else
					float3 staticSwitch980_g59004 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g59004 = staticSwitch980_g59004;
					float3 normalizeResult326_g59040 = normalize( Normal_Map700_g59004 );
					float3 Normal_Map318_g59040 = normalizeResult326_g59040;
					float dotResult121_g59040 = dot( appendResult139_g59040 , Normal_Map318_g59040 );
					float2 texCoord1070_g59004 = IN.ase_texcoord2.zw * float2( 1,1 ) + float2( 0,0 );
					float localStochasticTiling2_g59035 = ( 0.0 );
					float2 uv3_RNMX0 = IN.ase_texcoord2.zw * _RNMX0_ST.xy + _RNMX0_ST.zw;
					float2 UV2_g59035 = uv3_RNMX0;
					float4 TexelSize2_g59035 = _RNMX0_TexelSize;
					float4 Offsets2_g59035 = float4( 0,0,0,0 );
					float2 Weights2_g59035 = float2( 0,0 );
					{
					UV2_g59035 = UV2_g59035 * TexelSize2_g59035.zw - 0.5;
					float2 f = frac( UV2_g59035 );
					UV2_g59035 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g59035.x - 0.5, UV2_g59035.x + 1.5, UV2_g59035.y - 0.5, UV2_g59035.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g59035 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59035.xyxy;
					Weights2_g59035 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g59034 = Offsets2_g59035;
					float4 Input_FetchOffsets197_g59038 = temp_output_1_34_g59034;
					float2 temp_output_1_54_g59034 = Weights2_g59035;
					float2 Input_FetchWeights200_g59038 = temp_output_1_54_g59034;
					float2 break187_g59038 = Input_FetchWeights200_g59038;
					float4 lerpResult181_g59038 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g59038).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g59038).xw ) , break187_g59038.x);
					float4 lerpResult182_g59038 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g59038).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g59038).xz ) , break187_g59038.x);
					float4 lerpResult176_g59038 = lerp( lerpResult181_g59038 , lerpResult182_g59038 , break187_g59038.y);
					float4 Output_Fetch2D202_g59038 = lerpResult176_g59038;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g59004 = Output_Fetch2D202_g59038;
					#else
					float4 staticSwitch1061_g59004 = tex2D( _RNMX0, texCoord1070_g59004 );
					#endif
					float3 appendResult146_g59040 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59040 = dot( appendResult146_g59040 , Normal_Map318_g59040 );
					float4 Input_FetchOffsets197_g59036 = temp_output_1_34_g59034;
					float2 Input_FetchWeights200_g59036 = temp_output_1_54_g59034;
					float2 break187_g59036 = Input_FetchWeights200_g59036;
					float4 lerpResult181_g59036 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g59036).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g59036).xw ) , break187_g59036.x);
					float4 lerpResult182_g59036 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g59036).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g59036).xz ) , break187_g59036.x);
					float4 lerpResult176_g59036 = lerp( lerpResult181_g59036 , lerpResult182_g59036 , break187_g59036.y);
					float4 Output_Fetch2D202_g59036 = lerpResult176_g59036;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g59004 = Output_Fetch2D202_g59036;
					#else
					float4 staticSwitch1062_g59004 = tex2D( _RNMY0, texCoord1070_g59004 );
					#endif
					float3 appendResult149_g59040 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59040 = dot( appendResult149_g59040 , Normal_Map318_g59040 );
					float4 Input_FetchOffsets197_g59037 = temp_output_1_34_g59034;
					float2 Input_FetchWeights200_g59037 = temp_output_1_54_g59034;
					float2 break187_g59037 = Input_FetchWeights200_g59037;
					float4 lerpResult181_g59037 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g59037).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g59037).xw ) , break187_g59037.x);
					float4 lerpResult182_g59037 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g59037).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g59037).xz ) , break187_g59037.x);
					float4 lerpResult176_g59037 = lerp( lerpResult181_g59037 , lerpResult182_g59037 , break187_g59037.y);
					float4 Output_Fetch2D202_g59037 = lerpResult176_g59037;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g59004 = Output_Fetch2D202_g59037;
					#else
					float4 staticSwitch1063_g59004 = tex2D( _RNMZ0, texCoord1070_g59004 );
					#endif
					float4 RNM_0926_g59004 = ( ( ( saturate( dotResult121_g59040 ) * ( staticSwitch1061_g59004 * 0.33334 ) ) + ( saturate( dotResult122_g59040 ) * ( staticSwitch1062_g59004 * 0.33334 ) ) ) + ( saturate( dotResult120_g59040 ) * ( staticSwitch1063_g59004 * 0.33334 ) ) );
					float3 appendResult139_g59039 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g59039 = normalize( Normal_Map700_g59004 );
					float3 Normal_Map318_g59039 = normalizeResult326_g59039;
					float dotResult121_g59039 = dot( appendResult139_g59039 , Normal_Map318_g59039 );
					float2 texCoord1086_g59004 = IN.ase_texcoord2.zw * float2( 1,1 ) + float2( 0,0 );
					float localStochasticTiling2_g59026 = ( 0.0 );
					float2 uv3_RNMX1 = IN.ase_texcoord2.zw * _RNMX1_ST.xy + _RNMX1_ST.zw;
					float2 UV2_g59026 = uv3_RNMX1;
					float4 TexelSize2_g59026 = _RNMX1_TexelSize;
					float4 Offsets2_g59026 = float4( 0,0,0,0 );
					float2 Weights2_g59026 = float2( 0,0 );
					{
					UV2_g59026 = UV2_g59026 * TexelSize2_g59026.zw - 0.5;
					float2 f = frac( UV2_g59026 );
					UV2_g59026 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g59026.x - 0.5, UV2_g59026.x + 1.5, UV2_g59026.y - 0.5, UV2_g59026.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g59026 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59026.xyxy;
					Weights2_g59026 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g59025 = Offsets2_g59026;
					float4 Input_FetchOffsets197_g59029 = temp_output_1_34_g59025;
					float2 temp_output_1_54_g59025 = Weights2_g59026;
					float2 Input_FetchWeights200_g59029 = temp_output_1_54_g59025;
					float2 break187_g59029 = Input_FetchWeights200_g59029;
					float4 lerpResult181_g59029 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g59029).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g59029).xw ) , break187_g59029.x);
					float4 lerpResult182_g59029 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g59029).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g59029).xz ) , break187_g59029.x);
					float4 lerpResult176_g59029 = lerp( lerpResult181_g59029 , lerpResult182_g59029 , break187_g59029.y);
					float4 Output_Fetch2D202_g59029 = lerpResult176_g59029;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g59004 = Output_Fetch2D202_g59029;
					#else
					float4 staticSwitch1087_g59004 = tex2D( _RNMX1, texCoord1086_g59004 );
					#endif
					float3 appendResult146_g59039 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59039 = dot( appendResult146_g59039 , Normal_Map318_g59039 );
					float4 Input_FetchOffsets197_g59027 = temp_output_1_34_g59025;
					float2 Input_FetchWeights200_g59027 = temp_output_1_54_g59025;
					float2 break187_g59027 = Input_FetchWeights200_g59027;
					float4 lerpResult181_g59027 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g59027).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g59027).xw ) , break187_g59027.x);
					float4 lerpResult182_g59027 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g59027).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g59027).xz ) , break187_g59027.x);
					float4 lerpResult176_g59027 = lerp( lerpResult181_g59027 , lerpResult182_g59027 , break187_g59027.y);
					float4 Output_Fetch2D202_g59027 = lerpResult176_g59027;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g59004 = Output_Fetch2D202_g59027;
					#else
					float4 staticSwitch1083_g59004 = tex2D( _RNMY1, texCoord1086_g59004 );
					#endif
					float3 appendResult149_g59039 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59039 = dot( appendResult149_g59039 , Normal_Map318_g59039 );
					float4 Input_FetchOffsets197_g59028 = temp_output_1_34_g59025;
					float2 Input_FetchWeights200_g59028 = temp_output_1_54_g59025;
					float2 break187_g59028 = Input_FetchWeights200_g59028;
					float4 lerpResult181_g59028 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g59028).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g59028).xw ) , break187_g59028.x);
					float4 lerpResult182_g59028 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g59028).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g59028).xz ) , break187_g59028.x);
					float4 lerpResult176_g59028 = lerp( lerpResult181_g59028 , lerpResult182_g59028 , break187_g59028.y);
					float4 Output_Fetch2D202_g59028 = lerpResult176_g59028;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g59004 = Output_Fetch2D202_g59028;
					#else
					float4 staticSwitch1084_g59004 = tex2D( _RNMZ1, texCoord1086_g59004 );
					#endif
					float4 RNM_11081_g59004 = ( ( ( saturate( dotResult121_g59039 ) * ( staticSwitch1087_g59004 * 0.33334 ) ) + ( saturate( dotResult122_g59039 ) * ( staticSwitch1083_g59004 * 0.33334 ) ) ) + ( saturate( dotResult120_g59039 ) * ( staticSwitch1084_g59004 * 0.33334 ) ) );
					float Lightmap_Lerp_Value969_g59004 = _LIGHTMAPLERP;
					float4 lerpResult953_g59004 = lerp( RNM_0926_g59004 , RNM_11081_g59004 , Lightmap_Lerp_Value969_g59004);
					float4 RNM_Lerp950_g59004 = lerpResult953_g59004;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g59004 = temp_cast_2;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g59004 = Lightmap_0925_g59004;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g59004 = Lightmap_Lerp932_g59004;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g59004 = RNM_0926_g59004;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g59004 = RNM_Lerp950_g59004;
					#else
					float4 staticSwitch1014_g59004 = temp_cast_2;
					#endif
					float4 Lightmap46_g59004 = staticSwitch1014_g59004;
					float4 temp_cast_3 = 0;
					float2 uv_EmissionMap81_g59004 = IN.ase_texcoord2.xy;
					float2 uv_EmissionMap = IN.ase_texcoord2.xy * _EmissionMap_ST.xy + _EmissionMap_ST.zw;
					float2 temp_output_5_0_g59005 = uv_EmissionMap;
					float2 UV633_g59005 = temp_output_5_0_g59005;
					float2 UV100_g59006 = UV633_g59005;
					float2 temp_output_51_0_g59006 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59006 * float2( 3.464,3.464 ) ) );
					float2 break55_g59006 = frac( temp_output_51_0_g59006 );
					float temp_output_56_0_g59006 = ( ( 1.0 - break55_g59006.x ) - break55_g59006.y );
					float2 temp_output_52_0_g59006 = floor( temp_output_51_0_g59006 );
					float2 temp_output_125_0_g59006 = ( temp_output_52_0_g59006 + float2( 1,1 ) );
					float2 ifLocalVar87_g59006 = 0;
					if( temp_output_56_0_g59006 > 0.0 )
					ifLocalVar87_g59006 = temp_output_52_0_g59006;
					else if( temp_output_56_0_g59006 == 0.0 )
					ifLocalVar87_g59006 = temp_output_125_0_g59006;
					else if( temp_output_56_0_g59006 < 0.0 )
					ifLocalVar87_g59006 = temp_output_125_0_g59006;
					float3 temp_output_7_0_g59007 = frac( ( (ifLocalVar87_g59006).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59007 = dot( temp_output_7_0_g59007 , ( (temp_output_7_0_g59007).yzx + 33.33 ) );
					float3 temp_output_12_0_g59007 = ( temp_output_7_0_g59007 + dotResult8_g59007 );
					float2 temp_output_597_0_g59005 = ( UV100_g59006 + frac( ( ( (temp_output_12_0_g59007).xx + (temp_output_12_0_g59007).yz ) * (temp_output_12_0_g59007).zy ) ) );
					float2 DDX631_g59005 = ddx( temp_output_5_0_g59005 );
					float2 DDY632_g59005 = ddy( temp_output_5_0_g59005 );
					float temp_output_65_0_g59006 = ( 0.0 - temp_output_56_0_g59006 );
					float ifLocalVar59_g59006 = 0;
					if( temp_output_56_0_g59006 <= 0.0 )
					ifLocalVar59_g59006 = temp_output_65_0_g59006;
					else
					ifLocalVar59_g59006 = temp_output_56_0_g59006;
					float temp_output_597_30_g59005 = ifLocalVar59_g59006;
					float2 temp_output_90_0_g59006 = ( temp_output_52_0_g59006 + float2( 0,1 ) );
					float2 temp_output_123_0_g59006 = ( temp_output_52_0_g59006 + float2( 1,0 ) );
					float2 ifLocalVar88_g59006 = 0;
					if( temp_output_56_0_g59006 > 0.0 )
					ifLocalVar88_g59006 = temp_output_90_0_g59006;
					else if( temp_output_56_0_g59006 == 0.0 )
					ifLocalVar88_g59006 = temp_output_123_0_g59006;
					else if( temp_output_56_0_g59006 < 0.0 )
					ifLocalVar88_g59006 = temp_output_123_0_g59006;
					float3 temp_output_7_0_g59008 = frac( ( (ifLocalVar88_g59006).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59008 = dot( temp_output_7_0_g59008 , ( (temp_output_7_0_g59008).yzx + 33.33 ) );
					float3 temp_output_12_0_g59008 = ( temp_output_7_0_g59008 + dotResult8_g59008 );
					float2 temp_output_597_26_g59005 = ( UV100_g59006 + frac( ( ( (temp_output_12_0_g59008).xx + (temp_output_12_0_g59008).yz ) * (temp_output_12_0_g59008).zy ) ) );
					float temp_output_66_0_g59006 = ( 1.0 - break55_g59006.y );
					float ifLocalVar60_g59006 = 0;
					if( temp_output_56_0_g59006 <= 0.0 )
					ifLocalVar60_g59006 = temp_output_66_0_g59006;
					else
					ifLocalVar60_g59006 = break55_g59006.y;
					float temp_output_597_28_g59005 = ifLocalVar60_g59006;
					float2 ifLocalVar89_g59006 = 0;
					if( temp_output_56_0_g59006 > 0.0 )
					ifLocalVar89_g59006 = temp_output_123_0_g59006;
					else if( temp_output_56_0_g59006 == 0.0 )
					ifLocalVar89_g59006 = temp_output_90_0_g59006;
					else if( temp_output_56_0_g59006 < 0.0 )
					ifLocalVar89_g59006 = temp_output_90_0_g59006;
					float3 temp_output_7_0_g59009 = frac( ( (ifLocalVar89_g59006).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59009 = dot( temp_output_7_0_g59009 , ( (temp_output_7_0_g59009).yzx + 33.33 ) );
					float3 temp_output_12_0_g59009 = ( temp_output_7_0_g59009 + dotResult8_g59009 );
					float2 temp_output_597_27_g59005 = ( UV100_g59006 + frac( ( ( (temp_output_12_0_g59009).xx + (temp_output_12_0_g59009).yz ) * (temp_output_12_0_g59009).zy ) ) );
					float temp_output_67_0_g59006 = ( 1.0 - break55_g59006.x );
					float ifLocalVar61_g59006 = 0;
					if( temp_output_56_0_g59006 <= 0.0 )
					ifLocalVar61_g59006 = temp_output_67_0_g59006;
					else
					ifLocalVar61_g59006 = break55_g59006.x;
					float temp_output_597_29_g59005 = ifLocalVar61_g59006;
					float4 Output_2D293_g59005 = ( ( tex2D( _EmissionMap, temp_output_597_0_g59005, DDX631_g59005, DDY632_g59005 ) * temp_output_597_30_g59005 ) + ( tex2D( _EmissionMap, temp_output_597_26_g59005, DDX631_g59005, DDY632_g59005 ) * temp_output_597_28_g59005 ) + ( tex2D( _EmissionMap, temp_output_597_27_g59005, DDX631_g59005, DDY632_g59005 ) * temp_output_597_29_g59005 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g59004 = Output_2D293_g59005;
					#else
					float4 staticSwitch1006_g59004 = tex2D( _EmissionMap, uv_EmissionMap81_g59004 );
					#endif
					#ifdef _EMISSIONENABLED_ON
					float4 staticSwitch1017_g59004 = ( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g59004 * _EmissionIntensity );
					#else
					float4 staticSwitch1017_g59004 = temp_cast_3;
					#endif
					float4 Emission86_g59004 = staticSwitch1017_g59004;
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1181_g59004 = Lightmap46_g59004;
					#else
					float4 staticSwitch1181_g59004 = ( ( Albedo6_g59004 * Lightmap46_g59004 ) + Emission86_g59004 );
					#endif
					float4 temp_output_35_0_g59047 = staticSwitch1181_g59004;
					float4 Color353_g59047 = temp_output_35_0_g59047;
					#if defined( _LUTMODE_2D )
					float4 staticSwitch273_g59047 = saturate( temp_output_35_0_g59047 );
					#elif defined( _LUTMODE_3D )
					float4 staticSwitch273_g59047 = temp_output_35_0_g59047;
					#else
					float4 staticSwitch273_g59047 = temp_output_35_0_g59047;
					#endif
					float4 Color_Saturate49_g59047 = staticSwitch273_g59047;
					float Lut_Height213_g59047 = _LUTSize;
					float Lut_Width216_g59047 = ( _LUTSize * Lut_Height213_g59047 );
					float3 appendResult214_g59047 = (float3(( 1.0 / Lut_Width216_g59047 ) , ( 1.0 / Lut_Height213_g59047 ) , ( Lut_Height213_g59047 - 1.0 )));
					float3 Scale_Offset208_g59047 = appendResult214_g59047;
					float2 Scale_Factor292_g59047 = ( (Scale_Offset208_g59047).xy * (Scale_Offset208_g59047).z );
					float2 Offset299_g59047 = ( (Scale_Offset208_g59047).xy * 0.5 );
					float3 Adjusted_UV305_g59047 = ( ( (Color_Saturate49_g59047).xyw * float3( Scale_Factor292_g59047 ,  0.0 ) ) + float3( Offset299_g59047 ,  0.0 ) );
					float2 Scaled_Blue280_g59047 = ( (Color_Saturate49_g59047).zw * (Scale_Offset208_g59047).z );
					float2 Shift288_g59047 = floor( Scaled_Blue280_g59047 );
					float2 Final_X313_g59047 = ( (Adjusted_UV305_g59047).xz + ( Shift288_g59047 * (Scale_Offset208_g59047).y ) );
					float2 appendResult326_g59047 = (float2(Final_X313_g59047.x , (Adjusted_UV305_g59047).yz.x));
					float2 Final_UV325_g59047 = appendResult326_g59047;
					float2 appendResult338_g59047 = (float2((Scale_Offset208_g59047).y , 0.0));
					float2 Offset_UV336_g59047 = ( Final_UV325_g59047 + appendResult338_g59047 );
					float3 lerpResult333_g59047 = lerp( tex2D( _2DLut, Final_UV325_g59047 ).rgb , tex2D( _2DLut, Offset_UV336_g59047 ).rgb , float3( ( Scaled_Blue280_g59047 - Shift288_g59047 ) ,  0.0 ));
					#ifdef _2DLUT
					float4 staticSwitch347_g59047 = float4( lerpResult333_g59047 , 0.0 );
					#else
					float4 staticSwitch347_g59047 = Color_Saturate49_g59047;
					#endif
					float4 TwoD_LUT346_g59047 = staticSwitch347_g59047;
					float3 RGB16_g59048 = ( ( log10( ( ( Color_Saturate49_g59047.xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 );
					#ifdef _3DLUT
					float4 staticSwitch194_g59047 = tex3D( _3DLut, RGB16_g59048 );
					#else
					float4 staticSwitch194_g59047 = Color_Saturate49_g59047;
					#endif
					float4 ThreeD_LUT51_g59047 = staticSwitch194_g59047;
					#if defined( _LUTMODE_2D )
					float4 staticSwitch42_g59047 = TwoD_LUT346_g59047;
					#elif defined( _LUTMODE_3D )
					float4 staticSwitch42_g59047 = ThreeD_LUT51_g59047;
					#else
					float4 staticSwitch42_g59047 = ThreeD_LUT51_g59047;
					#endif
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch41_g59047 = staticSwitch42_g59047;
					#else
					float4 staticSwitch41_g59047 = Color353_g59047;
					#endif
					
					#ifdef _LIGHTMAPDEBUG
					float staticSwitch1191_g59004 = Black1185_g59004;
					#else
					float staticSwitch1191_g59004 = temp_output_976_0_g59004.a;
					#endif
					

					o.Albedo = staticSwitch1180_g59004.rgb;
					o.Normal = half3( 0, 0, 1 );
					o.Emission = staticSwitch41_g59047.xyz;
					o.Alpha = staticSwitch1191_g59004;
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
				#pragma multi_compile _ LOD_FADE_CROSSFADE
				#define ASE_FOG
				#pragma multi_compile_instancing
				#define _SPECULAR_SETUP 1
				#define ASE_VERSION 19904

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
				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
				#pragma shader_feature _LIGHTMAPDEBUG
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
				uniform sampler2D _2DLut;
				uniform float _LUTSize;
				uniform sampler3D _3DLut;
				uniform float4 _Color;
				uniform sampler2D _MainTex;
				uniform float4 _MainTex_ST;


				
				v2f VertexFunction( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					o.ase_texcoord1.xy = v.ase_texcoord.xy;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord1.zw = 0;

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

					float2 uv_MainTex907_g59004 = IN.ase_texcoord1.xy;
					float4 tex2DNode907_g59004 = tex2D( _MainTex, uv_MainTex907_g59004 );
					float2 uv_MainTex = IN.ase_texcoord1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					float2 temp_output_5_0_g59020 = uv_MainTex;
					float2 UV633_g59020 = temp_output_5_0_g59020;
					float2 UV100_g59021 = UV633_g59020;
					float2 temp_output_51_0_g59021 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59021 * float2( 3.464,3.464 ) ) );
					float2 break55_g59021 = frac( temp_output_51_0_g59021 );
					float temp_output_56_0_g59021 = ( ( 1.0 - break55_g59021.x ) - break55_g59021.y );
					float2 temp_output_52_0_g59021 = floor( temp_output_51_0_g59021 );
					float2 temp_output_125_0_g59021 = ( temp_output_52_0_g59021 + float2( 1,1 ) );
					float2 ifLocalVar87_g59021 = 0;
					if( temp_output_56_0_g59021 > 0.0 )
					ifLocalVar87_g59021 = temp_output_52_0_g59021;
					else if( temp_output_56_0_g59021 == 0.0 )
					ifLocalVar87_g59021 = temp_output_125_0_g59021;
					else if( temp_output_56_0_g59021 < 0.0 )
					ifLocalVar87_g59021 = temp_output_125_0_g59021;
					float3 temp_output_7_0_g59022 = frac( ( (ifLocalVar87_g59021).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59022 = dot( temp_output_7_0_g59022 , ( (temp_output_7_0_g59022).yzx + 33.33 ) );
					float3 temp_output_12_0_g59022 = ( temp_output_7_0_g59022 + dotResult8_g59022 );
					float2 temp_output_597_0_g59020 = ( UV100_g59021 + frac( ( ( (temp_output_12_0_g59022).xx + (temp_output_12_0_g59022).yz ) * (temp_output_12_0_g59022).zy ) ) );
					float2 DDX631_g59020 = ddx( temp_output_5_0_g59020 );
					float2 DDY632_g59020 = ddy( temp_output_5_0_g59020 );
					float temp_output_65_0_g59021 = ( 0.0 - temp_output_56_0_g59021 );
					float ifLocalVar59_g59021 = 0;
					if( temp_output_56_0_g59021 <= 0.0 )
					ifLocalVar59_g59021 = temp_output_65_0_g59021;
					else
					ifLocalVar59_g59021 = temp_output_56_0_g59021;
					float temp_output_597_30_g59020 = ifLocalVar59_g59021;
					float2 temp_output_90_0_g59021 = ( temp_output_52_0_g59021 + float2( 0,1 ) );
					float2 temp_output_123_0_g59021 = ( temp_output_52_0_g59021 + float2( 1,0 ) );
					float2 ifLocalVar88_g59021 = 0;
					if( temp_output_56_0_g59021 > 0.0 )
					ifLocalVar88_g59021 = temp_output_90_0_g59021;
					else if( temp_output_56_0_g59021 == 0.0 )
					ifLocalVar88_g59021 = temp_output_123_0_g59021;
					else if( temp_output_56_0_g59021 < 0.0 )
					ifLocalVar88_g59021 = temp_output_123_0_g59021;
					float3 temp_output_7_0_g59023 = frac( ( (ifLocalVar88_g59021).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59023 = dot( temp_output_7_0_g59023 , ( (temp_output_7_0_g59023).yzx + 33.33 ) );
					float3 temp_output_12_0_g59023 = ( temp_output_7_0_g59023 + dotResult8_g59023 );
					float2 temp_output_597_26_g59020 = ( UV100_g59021 + frac( ( ( (temp_output_12_0_g59023).xx + (temp_output_12_0_g59023).yz ) * (temp_output_12_0_g59023).zy ) ) );
					float temp_output_66_0_g59021 = ( 1.0 - break55_g59021.y );
					float ifLocalVar60_g59021 = 0;
					if( temp_output_56_0_g59021 <= 0.0 )
					ifLocalVar60_g59021 = temp_output_66_0_g59021;
					else
					ifLocalVar60_g59021 = break55_g59021.y;
					float temp_output_597_28_g59020 = ifLocalVar60_g59021;
					float2 ifLocalVar89_g59021 = 0;
					if( temp_output_56_0_g59021 > 0.0 )
					ifLocalVar89_g59021 = temp_output_123_0_g59021;
					else if( temp_output_56_0_g59021 == 0.0 )
					ifLocalVar89_g59021 = temp_output_90_0_g59021;
					else if( temp_output_56_0_g59021 < 0.0 )
					ifLocalVar89_g59021 = temp_output_90_0_g59021;
					float3 temp_output_7_0_g59024 = frac( ( (ifLocalVar89_g59021).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59024 = dot( temp_output_7_0_g59024 , ( (temp_output_7_0_g59024).yzx + 33.33 ) );
					float3 temp_output_12_0_g59024 = ( temp_output_7_0_g59024 + dotResult8_g59024 );
					float2 temp_output_597_27_g59020 = ( UV100_g59021 + frac( ( ( (temp_output_12_0_g59024).xx + (temp_output_12_0_g59024).yz ) * (temp_output_12_0_g59024).zy ) ) );
					float temp_output_67_0_g59021 = ( 1.0 - break55_g59021.x );
					float ifLocalVar61_g59021 = 0;
					if( temp_output_56_0_g59021 <= 0.0 )
					ifLocalVar61_g59021 = temp_output_67_0_g59021;
					else
					ifLocalVar61_g59021 = break55_g59021.x;
					float temp_output_597_29_g59020 = ifLocalVar61_g59021;
					float4 Output_2D293_g59020 = ( ( tex2D( _MainTex, temp_output_597_0_g59020, DDX631_g59020, DDY632_g59020 ) * temp_output_597_30_g59020 ) + ( tex2D( _MainTex, temp_output_597_26_g59020, DDX631_g59020, DDY632_g59020 ) * temp_output_597_28_g59020 ) + ( tex2D( _MainTex, temp_output_597_27_g59020, DDX631_g59020, DDY632_g59020 ) * temp_output_597_29_g59020 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g59004 = Output_2D293_g59020;
					#else
					float4 staticSwitch1001_g59004 = tex2DNode907_g59004;
					#endif
					float4 temp_output_976_0_g59004 = ( _Color * staticSwitch1001_g59004 );
					float Black1185_g59004 = 0.0;
					#ifdef _LIGHTMAPDEBUG
					float staticSwitch1191_g59004 = Black1185_g59004;
					#else
					float staticSwitch1191_g59004 = temp_output_976_0_g59004.a;
					#endif
					

					o.Normal = half3( 0, 0, 1 );

					o.Alpha = staticSwitch1191_g59004;
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
Version=19904
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2975;192,-1200;Inherit;False;Meenphie;0;;59004;b3ba55a08dd6b49c7be16c6f35cf2033;1,1008,0;0;9;COLOR;625;FLOAT3;238;COLOR;96;FLOAT;97;COLOR;1042;FLOAT4;624;FLOAT;156;FLOAT;427;FLOAT3;1024
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2889;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;True;1;LightMode=ForwardAdd;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2890;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2891;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2892;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2893;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2894;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ScenePickingPass;0;7;ScenePickingPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;True;1;LightMode=ScenePickingPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2887;480,-1440;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;True;True;2;5;False;;10;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;True;True;1;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;2;False;;True;0;False;;True;False;0;False;;0;False;;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2888;512,-1200;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;Meenphie/Standard/Transparent;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardBase;0;1;ForwardBase;17;True;True;0;1;False;;1;False;;0;1;False;;1;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;True;True;2;False;;True;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;2;False;;True;0;False;_ZTest;False;True;3;RenderType=Opaque=RenderType;Queue=Transparent=Queue=1;DisableBatching=False=DisableBatching;True;3;False;0;True;True;4;1;False;;1;False;;0;1;False;;1;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;44;Category;0;0;  Instanced Terrain Normals;1;0;Workflow;0;639025664925191880;Surface;0;638915536266677850;  Blend;0;638915486026768330;  Dither Shadows;0;638915443249087440;Two Sided;0;638915494950662450;Alpha Clipping;0;638915444112671460;  Use Shadow Threshold;0;638915420933436960;Deferred Pass;0;638915425282396370;Normal Space;0;0;Transmission;0;638915425258747670;  Transmission Shadow;0.5,False,;0;Translucency;0;638915425246861880;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;1;638922400288384950;Receive Shadows;0;638922400294457600;Receive Specular;0;638915388784334560;Receive Reflections;1;638915388803555030;GPU Instancing;1;638915411619689990;LOD CrossFade;1;0;Built-in Fog;1;0;Ambient Light;1;0;Meta Pass;1;0;Add Pass;1;0;Override Baked GI;0;638915390973737640;Write Depth;0;638915488214535980;Extra Pre Pass;0;638915495230384640;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;0;Vertex Position;1;0;0;8;False;True;True;False;True;True;False;False;False;;False;0
WireConnection;2888;0;2975;625
WireConnection;2888;1;2975;238
WireConnection;2888;3;2975;96
WireConnection;2888;5;2975;97
WireConnection;2888;6;2975;1042
WireConnection;2888;2;2975;624
WireConnection;2888;7;2975;156
WireConnection;2888;15;2975;1024
ASEEND*/
//CHKSM=A7C11C2D921827434B63D4041079AF572D43CC38