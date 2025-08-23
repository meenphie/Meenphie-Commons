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
		[NoScaleOffset][SingleLineTexture] _MetallicMap( "Metallic Map", 2D ) = "white" {}
		[NoScaleOffset][SingleLineTexture] _GlossinessMap( "Roughness Map", 2D ) = "white" {}
		_Metallic( "Metallic", Range( 0, 1 ) ) = 0
		_Glossiness( "Smoothness", Range( 0, 1 ) ) = 0.5
		[Toggle( _USEGEOMETRICANTIALIASING_ON )] _UseGeometricAntiAliasing( "Use Geometric Anti Aliasing", Float ) = 1
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESURFACEOPTIONS( "CATEGORY SPACE SURFACEOPTIONS", Float ) = 0
		[Meenphie_DrawerCategory(EMISSION,true,0,0)] _CATEGORYEMISSION( "CATEGORY EMISSION", Float ) = 0
		[Toggle( _EMISSIONENABLED_ON )] _EmissionEnabled( "Emission Enabled", Float ) = 0
		[HDR][Gamma] _EmissionColor( "Emission Color", Color ) = ( 0, 0, 0, 0 )
		[NoScaleOffset][SingleLineTexture] _EmissionMap( "Emission Map", 2D ) = "black" {}
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
		_LightmapLerp( "LightmapLerp", Range( 0, 1 ) ) = 0
		[Toggle( _LIGHTMAPOCCLUSIONENABLED_ON )] _LightmapOcclusionEnabled( "Lightmap Occlusion Enabled", Float ) = 1
		_OcclusionPower( "Occlusion Power", Float ) = 1
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACELIGHTMAPPING( "CATEGORY SPACE LIGHTMAPPING", Float ) = 0
		[Meenphie_DrawerCategory(STOCHASTIC,true,0,0)] _CATEGORYSTOCHASTIC( "CATEGORY STOCHASTIC", Float ) = 0
		[Toggle( _STOCHASTICENABLED_ON )] _StochasticEnabled( "Stochastic Enabled", Float ) = 0
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESTOCHASTIC( "CATEGORY SPACE STOCHASTIC", Float ) = 0
		[HideInInspector] GenKey__MetallicMap( "Assign keyword _METALLICMAP", Float ) = 1.0
		[HideInInspector] GenKey__GlossinessMap( "Assign keyword _GLOSSINESSMAP", Float ) = 1.0
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0
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
		

		

		Tags { "RenderType"="Opaque" "Queue"="Transparent" "DisableBatching"="False" }

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
				#define ASE_RECEIVE_SHADOWS
				#pragma multi_compile _ LOD_FADE_CROSSFADE
				#pragma multi_compile_fog
				#define ASE_FOG
				#pragma multi_compile_local_fragment _SPECULARHIGHLIGHTS_OFF
				#pragma multi_compile_instancing
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
				#define ASE_NEEDS_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_NORMAL
				#define ASE_NEEDS_TEXTURE_COORDINATES2
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
				#pragma shader_feature_local _STOCHASTICENABLED_ON
				#pragma shader_feature_local_fragment _BUMPMAP
				#pragma shader_feature_local_fragment _METALLICMAP
				#pragma shader_feature_local_fragment _USEGEOMETRICANTIALIASING_ON
				#pragma shader_feature_local_fragment _GLOSSINESSMAP
				#pragma shader_feature_local _LIGHTMAPMODE_DISABLED _LIGHTMAPMODE_SIMPLE _LIGHTMAPMODE_SIMPLELERP _LIGHTMAPMODE_RNM _LIGHTMAPMODE_RNMLERP
				#pragma shader_feature_local _LIGHTMAPOCCLUSIONENABLED_ON
				#pragma shader_feature_local _EMISSIONENABLED_ON


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
				uniform float _CATEGORYSPACESTOCHASTIC;
				uniform float _CATEGORYSTOCHASTIC;
				uniform float _CATEGORYLIGHTMAPPING;
				uniform float _CATEGORYSPACELIGHTMAPPING;
				uniform float4 _Color;
				uniform sampler2D _MainTex;
				uniform float4 _MainTex_ST;
				uniform sampler2D _BumpMap;
				uniform float _NormalScale;
				uniform float4 _BumpMap_ST;
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				uniform float4 _MetallicMap_ST;
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				uniform float4 _GlossinessMap_ST;
				uniform sampler2D _Lightmap0;
				uniform float4 _Lightmap0_ST;
				float4 _Lightmap0_TexelSize;
				uniform sampler2D _Lightmap1;
				uniform float4 _Lightmap1_ST;
				float4 _Lightmap1_TexelSize;
				uniform float _LightmapLerp;
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
				uniform float _OcclusionPower;
				uniform float4 _EmissionColor;
				uniform sampler2D _EmissionMap;
				uniform float4 _EmissionMap_ST;


				
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
					float3 vertexValue = ( v.normal * -0.001 );
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

					float2 uv_MainTex907_g2409 = IN.ase_texcoord6.xy;
					float2 uv_MainTex = IN.ase_texcoord6.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					float2 temp_output_5_0_g2446 = uv_MainTex;
					float2 UV633_g2446 = temp_output_5_0_g2446;
					float2 UV100_g2447 = UV633_g2446;
					float2 temp_output_51_0_g2447 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g2447 * float2( 3.464,3.464 ) ) );
					float2 break55_g2447 = frac( temp_output_51_0_g2447 );
					float temp_output_56_0_g2447 = ( ( 1.0 - break55_g2447.x ) - break55_g2447.y );
					float2 temp_output_52_0_g2447 = floor( temp_output_51_0_g2447 );
					float2 temp_output_125_0_g2447 = ( temp_output_52_0_g2447 + float2( 1,1 ) );
					float2 ifLocalVar87_g2447 = 0;
					if( temp_output_56_0_g2447 > 0.0 )
					ifLocalVar87_g2447 = temp_output_52_0_g2447;
					else if( temp_output_56_0_g2447 == 0.0 )
					ifLocalVar87_g2447 = temp_output_125_0_g2447;
					else if( temp_output_56_0_g2447 < 0.0 )
					ifLocalVar87_g2447 = temp_output_125_0_g2447;
					float3 temp_output_7_0_g2448 = frac( ( (ifLocalVar87_g2447).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2448 = dot( temp_output_7_0_g2448 , ( (temp_output_7_0_g2448).yzx + 33.33 ) );
					float3 temp_output_12_0_g2448 = ( temp_output_7_0_g2448 + dotResult8_g2448 );
					float2 temp_output_597_0_g2446 = ( UV100_g2447 + frac( ( ( (temp_output_12_0_g2448).xx + (temp_output_12_0_g2448).yz ) * (temp_output_12_0_g2448).zy ) ) );
					float2 DDX631_g2446 = ddx( temp_output_5_0_g2446 );
					float2 DDY632_g2446 = ddy( temp_output_5_0_g2446 );
					float temp_output_65_0_g2447 = ( 0.0 - temp_output_56_0_g2447 );
					float ifLocalVar59_g2447 = 0;
					if( temp_output_56_0_g2447 <= 0.0 )
					ifLocalVar59_g2447 = temp_output_65_0_g2447;
					else
					ifLocalVar59_g2447 = temp_output_56_0_g2447;
					float temp_output_597_30_g2446 = ifLocalVar59_g2447;
					float2 temp_output_90_0_g2447 = ( temp_output_52_0_g2447 + float2( 0,1 ) );
					float2 temp_output_123_0_g2447 = ( temp_output_52_0_g2447 + float2( 1,0 ) );
					float2 ifLocalVar88_g2447 = 0;
					if( temp_output_56_0_g2447 > 0.0 )
					ifLocalVar88_g2447 = temp_output_90_0_g2447;
					else if( temp_output_56_0_g2447 == 0.0 )
					ifLocalVar88_g2447 = temp_output_123_0_g2447;
					else if( temp_output_56_0_g2447 < 0.0 )
					ifLocalVar88_g2447 = temp_output_123_0_g2447;
					float3 temp_output_7_0_g2449 = frac( ( (ifLocalVar88_g2447).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2449 = dot( temp_output_7_0_g2449 , ( (temp_output_7_0_g2449).yzx + 33.33 ) );
					float3 temp_output_12_0_g2449 = ( temp_output_7_0_g2449 + dotResult8_g2449 );
					float2 temp_output_597_26_g2446 = ( UV100_g2447 + frac( ( ( (temp_output_12_0_g2449).xx + (temp_output_12_0_g2449).yz ) * (temp_output_12_0_g2449).zy ) ) );
					float temp_output_66_0_g2447 = ( 1.0 - break55_g2447.y );
					float ifLocalVar60_g2447 = 0;
					if( temp_output_56_0_g2447 <= 0.0 )
					ifLocalVar60_g2447 = temp_output_66_0_g2447;
					else
					ifLocalVar60_g2447 = break55_g2447.y;
					float temp_output_597_28_g2446 = ifLocalVar60_g2447;
					float2 ifLocalVar89_g2447 = 0;
					if( temp_output_56_0_g2447 > 0.0 )
					ifLocalVar89_g2447 = temp_output_123_0_g2447;
					else if( temp_output_56_0_g2447 == 0.0 )
					ifLocalVar89_g2447 = temp_output_90_0_g2447;
					else if( temp_output_56_0_g2447 < 0.0 )
					ifLocalVar89_g2447 = temp_output_90_0_g2447;
					float3 temp_output_7_0_g2450 = frac( ( (ifLocalVar89_g2447).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2450 = dot( temp_output_7_0_g2450 , ( (temp_output_7_0_g2450).yzx + 33.33 ) );
					float3 temp_output_12_0_g2450 = ( temp_output_7_0_g2450 + dotResult8_g2450 );
					float2 temp_output_597_27_g2446 = ( UV100_g2447 + frac( ( ( (temp_output_12_0_g2450).xx + (temp_output_12_0_g2450).yz ) * (temp_output_12_0_g2450).zy ) ) );
					float temp_output_67_0_g2447 = ( 1.0 - break55_g2447.x );
					float ifLocalVar61_g2447 = 0;
					if( temp_output_56_0_g2447 <= 0.0 )
					ifLocalVar61_g2447 = temp_output_67_0_g2447;
					else
					ifLocalVar61_g2447 = break55_g2447.x;
					float temp_output_597_29_g2446 = ifLocalVar61_g2447;
					float4 Output_2D293_g2446 = ( ( tex2D( _MainTex, temp_output_597_0_g2446, DDX631_g2446, DDY632_g2446 ) * temp_output_597_30_g2446 ) + ( tex2D( _MainTex, temp_output_597_26_g2446, DDX631_g2446, DDY632_g2446 ) * temp_output_597_28_g2446 ) + ( tex2D( _MainTex, temp_output_597_27_g2446, DDX631_g2446, DDY632_g2446 ) * temp_output_597_29_g2446 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g2409 = Output_2D293_g2446;
					#else
					float4 staticSwitch1001_g2409 = tex2D( _MainTex, uv_MainTex907_g2409 );
					#endif
					float4 temp_output_976_0_g2409 = ( _Color * staticSwitch1001_g2409 );
					float4 Albedo6_g2409 = temp_output_976_0_g2409;
					
					float2 uv_BumpMap830_g2409 = IN.ase_texcoord6.xy;
					float2 uv_BumpMap = IN.ase_texcoord6.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					float2 temp_output_5_0_g2441 = uv_BumpMap;
					float2 UV633_g2441 = temp_output_5_0_g2441;
					float2 UV100_g2442 = UV633_g2441;
					float2 temp_output_51_0_g2442 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g2442 * float2( 3.464,3.464 ) ) );
					float2 break55_g2442 = frac( temp_output_51_0_g2442 );
					float temp_output_56_0_g2442 = ( ( 1.0 - break55_g2442.x ) - break55_g2442.y );
					float2 temp_output_52_0_g2442 = floor( temp_output_51_0_g2442 );
					float2 temp_output_125_0_g2442 = ( temp_output_52_0_g2442 + float2( 1,1 ) );
					float2 ifLocalVar87_g2442 = 0;
					if( temp_output_56_0_g2442 > 0.0 )
					ifLocalVar87_g2442 = temp_output_52_0_g2442;
					else if( temp_output_56_0_g2442 == 0.0 )
					ifLocalVar87_g2442 = temp_output_125_0_g2442;
					else if( temp_output_56_0_g2442 < 0.0 )
					ifLocalVar87_g2442 = temp_output_125_0_g2442;
					float3 temp_output_7_0_g2443 = frac( ( (ifLocalVar87_g2442).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2443 = dot( temp_output_7_0_g2443 , ( (temp_output_7_0_g2443).yzx + 33.33 ) );
					float3 temp_output_12_0_g2443 = ( temp_output_7_0_g2443 + dotResult8_g2443 );
					float2 temp_output_597_0_g2441 = ( UV100_g2442 + frac( ( ( (temp_output_12_0_g2443).xx + (temp_output_12_0_g2443).yz ) * (temp_output_12_0_g2443).zy ) ) );
					float2 DDX631_g2441 = ddx( temp_output_5_0_g2441 );
					float2 DDY632_g2441 = ddy( temp_output_5_0_g2441 );
					float Input_Scale617_g2441 = _NormalScale;
					float temp_output_65_0_g2442 = ( 0.0 - temp_output_56_0_g2442 );
					float ifLocalVar59_g2442 = 0;
					if( temp_output_56_0_g2442 <= 0.0 )
					ifLocalVar59_g2442 = temp_output_65_0_g2442;
					else
					ifLocalVar59_g2442 = temp_output_56_0_g2442;
					float temp_output_597_30_g2441 = ifLocalVar59_g2442;
					float2 temp_output_90_0_g2442 = ( temp_output_52_0_g2442 + float2( 0,1 ) );
					float2 temp_output_123_0_g2442 = ( temp_output_52_0_g2442 + float2( 1,0 ) );
					float2 ifLocalVar88_g2442 = 0;
					if( temp_output_56_0_g2442 > 0.0 )
					ifLocalVar88_g2442 = temp_output_90_0_g2442;
					else if( temp_output_56_0_g2442 == 0.0 )
					ifLocalVar88_g2442 = temp_output_123_0_g2442;
					else if( temp_output_56_0_g2442 < 0.0 )
					ifLocalVar88_g2442 = temp_output_123_0_g2442;
					float3 temp_output_7_0_g2444 = frac( ( (ifLocalVar88_g2442).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2444 = dot( temp_output_7_0_g2444 , ( (temp_output_7_0_g2444).yzx + 33.33 ) );
					float3 temp_output_12_0_g2444 = ( temp_output_7_0_g2444 + dotResult8_g2444 );
					float2 temp_output_597_26_g2441 = ( UV100_g2442 + frac( ( ( (temp_output_12_0_g2444).xx + (temp_output_12_0_g2444).yz ) * (temp_output_12_0_g2444).zy ) ) );
					float temp_output_66_0_g2442 = ( 1.0 - break55_g2442.y );
					float ifLocalVar60_g2442 = 0;
					if( temp_output_56_0_g2442 <= 0.0 )
					ifLocalVar60_g2442 = temp_output_66_0_g2442;
					else
					ifLocalVar60_g2442 = break55_g2442.y;
					float temp_output_597_28_g2441 = ifLocalVar60_g2442;
					float2 ifLocalVar89_g2442 = 0;
					if( temp_output_56_0_g2442 > 0.0 )
					ifLocalVar89_g2442 = temp_output_123_0_g2442;
					else if( temp_output_56_0_g2442 == 0.0 )
					ifLocalVar89_g2442 = temp_output_90_0_g2442;
					else if( temp_output_56_0_g2442 < 0.0 )
					ifLocalVar89_g2442 = temp_output_90_0_g2442;
					float3 temp_output_7_0_g2445 = frac( ( (ifLocalVar89_g2442).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2445 = dot( temp_output_7_0_g2445 , ( (temp_output_7_0_g2445).yzx + 33.33 ) );
					float3 temp_output_12_0_g2445 = ( temp_output_7_0_g2445 + dotResult8_g2445 );
					float2 temp_output_597_27_g2441 = ( UV100_g2442 + frac( ( ( (temp_output_12_0_g2445).xx + (temp_output_12_0_g2445).yz ) * (temp_output_12_0_g2445).zy ) ) );
					float temp_output_67_0_g2442 = ( 1.0 - break55_g2442.x );
					float ifLocalVar61_g2442 = 0;
					if( temp_output_56_0_g2442 <= 0.0 )
					ifLocalVar61_g2442 = temp_output_67_0_g2442;
					else
					ifLocalVar61_g2442 = break55_g2442.x;
					float temp_output_597_29_g2441 = ifLocalVar61_g2442;
					float3 Output_2D_Normal641_g2441 = ( ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_0_g2441, DDX631_g2441, DDY632_g2441 ), Input_Scale617_g2441 ) * temp_output_597_30_g2441 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_26_g2441, DDX631_g2441, DDY632_g2441 ), Input_Scale617_g2441 ) * temp_output_597_28_g2441 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_27_g2441, DDX631_g2441, DDY632_g2441 ), Input_Scale617_g2441 ) * float3( 0,0,0 ) * temp_output_597_29_g2441 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g2409 = Output_2D_Normal641_g2441;
					#else
					float3 staticSwitch1003_g2409 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap830_g2409 ), _NormalScale );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g2409 = staticSwitch1003_g2409;
					#else
					float3 staticSwitch980_g2409 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g2409 = staticSwitch980_g2409;
					
					float2 uv_MetallicMap48_g2409 = IN.ase_texcoord6.xy;
					float2 uv_MetallicMap = IN.ase_texcoord6.xy * _MetallicMap_ST.xy + _MetallicMap_ST.zw;
					float2 temp_output_5_0_g2431 = uv_MetallicMap;
					float2 UV633_g2431 = temp_output_5_0_g2431;
					float2 UV100_g2432 = UV633_g2431;
					float2 temp_output_51_0_g2432 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g2432 * float2( 3.464,3.464 ) ) );
					float2 break55_g2432 = frac( temp_output_51_0_g2432 );
					float temp_output_56_0_g2432 = ( ( 1.0 - break55_g2432.x ) - break55_g2432.y );
					float2 temp_output_52_0_g2432 = floor( temp_output_51_0_g2432 );
					float2 temp_output_125_0_g2432 = ( temp_output_52_0_g2432 + float2( 1,1 ) );
					float2 ifLocalVar87_g2432 = 0;
					if( temp_output_56_0_g2432 > 0.0 )
					ifLocalVar87_g2432 = temp_output_52_0_g2432;
					else if( temp_output_56_0_g2432 == 0.0 )
					ifLocalVar87_g2432 = temp_output_125_0_g2432;
					else if( temp_output_56_0_g2432 < 0.0 )
					ifLocalVar87_g2432 = temp_output_125_0_g2432;
					float3 temp_output_7_0_g2433 = frac( ( (ifLocalVar87_g2432).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2433 = dot( temp_output_7_0_g2433 , ( (temp_output_7_0_g2433).yzx + 33.33 ) );
					float3 temp_output_12_0_g2433 = ( temp_output_7_0_g2433 + dotResult8_g2433 );
					float2 temp_output_597_0_g2431 = ( UV100_g2432 + frac( ( ( (temp_output_12_0_g2433).xx + (temp_output_12_0_g2433).yz ) * (temp_output_12_0_g2433).zy ) ) );
					float2 DDX631_g2431 = ddx( temp_output_5_0_g2431 );
					float2 DDY632_g2431 = ddy( temp_output_5_0_g2431 );
					float temp_output_65_0_g2432 = ( 0.0 - temp_output_56_0_g2432 );
					float ifLocalVar59_g2432 = 0;
					if( temp_output_56_0_g2432 <= 0.0 )
					ifLocalVar59_g2432 = temp_output_65_0_g2432;
					else
					ifLocalVar59_g2432 = temp_output_56_0_g2432;
					float temp_output_597_30_g2431 = ifLocalVar59_g2432;
					float2 temp_output_90_0_g2432 = ( temp_output_52_0_g2432 + float2( 0,1 ) );
					float2 temp_output_123_0_g2432 = ( temp_output_52_0_g2432 + float2( 1,0 ) );
					float2 ifLocalVar88_g2432 = 0;
					if( temp_output_56_0_g2432 > 0.0 )
					ifLocalVar88_g2432 = temp_output_90_0_g2432;
					else if( temp_output_56_0_g2432 == 0.0 )
					ifLocalVar88_g2432 = temp_output_123_0_g2432;
					else if( temp_output_56_0_g2432 < 0.0 )
					ifLocalVar88_g2432 = temp_output_123_0_g2432;
					float3 temp_output_7_0_g2434 = frac( ( (ifLocalVar88_g2432).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2434 = dot( temp_output_7_0_g2434 , ( (temp_output_7_0_g2434).yzx + 33.33 ) );
					float3 temp_output_12_0_g2434 = ( temp_output_7_0_g2434 + dotResult8_g2434 );
					float2 temp_output_597_26_g2431 = ( UV100_g2432 + frac( ( ( (temp_output_12_0_g2434).xx + (temp_output_12_0_g2434).yz ) * (temp_output_12_0_g2434).zy ) ) );
					float temp_output_66_0_g2432 = ( 1.0 - break55_g2432.y );
					float ifLocalVar60_g2432 = 0;
					if( temp_output_56_0_g2432 <= 0.0 )
					ifLocalVar60_g2432 = temp_output_66_0_g2432;
					else
					ifLocalVar60_g2432 = break55_g2432.y;
					float temp_output_597_28_g2431 = ifLocalVar60_g2432;
					float2 ifLocalVar89_g2432 = 0;
					if( temp_output_56_0_g2432 > 0.0 )
					ifLocalVar89_g2432 = temp_output_123_0_g2432;
					else if( temp_output_56_0_g2432 == 0.0 )
					ifLocalVar89_g2432 = temp_output_90_0_g2432;
					else if( temp_output_56_0_g2432 < 0.0 )
					ifLocalVar89_g2432 = temp_output_90_0_g2432;
					float3 temp_output_7_0_g2435 = frac( ( (ifLocalVar89_g2432).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2435 = dot( temp_output_7_0_g2435 , ( (temp_output_7_0_g2435).yzx + 33.33 ) );
					float3 temp_output_12_0_g2435 = ( temp_output_7_0_g2435 + dotResult8_g2435 );
					float2 temp_output_597_27_g2431 = ( UV100_g2432 + frac( ( ( (temp_output_12_0_g2435).xx + (temp_output_12_0_g2435).yz ) * (temp_output_12_0_g2435).zy ) ) );
					float temp_output_67_0_g2432 = ( 1.0 - break55_g2432.x );
					float ifLocalVar61_g2432 = 0;
					if( temp_output_56_0_g2432 <= 0.0 )
					ifLocalVar61_g2432 = temp_output_67_0_g2432;
					else
					ifLocalVar61_g2432 = break55_g2432.x;
					float temp_output_597_29_g2431 = ifLocalVar61_g2432;
					float4 Output_2D293_g2431 = ( ( tex2D( _MetallicMap, temp_output_597_0_g2431, DDX631_g2431, DDY632_g2431 ) * temp_output_597_30_g2431 ) + ( tex2D( _MetallicMap, temp_output_597_26_g2431, DDX631_g2431, DDY632_g2431 ) * temp_output_597_28_g2431 ) + ( tex2D( _MetallicMap, temp_output_597_27_g2431, DDX631_g2431, DDY632_g2431 ) * temp_output_597_29_g2431 ) );
					float4 break31_g2431 = Output_2D293_g2431;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g2409 = break31_g2431.a;
					#else
					float staticSwitch1005_g2409 = tex2D( _MetallicMap, uv_MetallicMap48_g2409 ).a;
					#endif
					float saferPower803_g2409 = abs( staticSwitch1005_g2409 );
					#ifdef _METALLICMAP
					float staticSwitch846_g2409 = pow( saferPower803_g2409 , 3.0 );
					#else
					float staticSwitch846_g2409 = _Metallic;
					#endif
					float Metallic699_g2409 = staticSwitch846_g2409;
					
					float2 uv_GlossinessMap64_g2409 = IN.ase_texcoord6.xy;
					float2 uv_GlossinessMap = IN.ase_texcoord6.xy * _GlossinessMap_ST.xy + _GlossinessMap_ST.zw;
					float2 temp_output_5_0_g2436 = uv_GlossinessMap;
					float2 UV633_g2436 = temp_output_5_0_g2436;
					float2 UV100_g2437 = UV633_g2436;
					float2 temp_output_51_0_g2437 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g2437 * float2( 3.464,3.464 ) ) );
					float2 break55_g2437 = frac( temp_output_51_0_g2437 );
					float temp_output_56_0_g2437 = ( ( 1.0 - break55_g2437.x ) - break55_g2437.y );
					float2 temp_output_52_0_g2437 = floor( temp_output_51_0_g2437 );
					float2 temp_output_125_0_g2437 = ( temp_output_52_0_g2437 + float2( 1,1 ) );
					float2 ifLocalVar87_g2437 = 0;
					if( temp_output_56_0_g2437 > 0.0 )
					ifLocalVar87_g2437 = temp_output_52_0_g2437;
					else if( temp_output_56_0_g2437 == 0.0 )
					ifLocalVar87_g2437 = temp_output_125_0_g2437;
					else if( temp_output_56_0_g2437 < 0.0 )
					ifLocalVar87_g2437 = temp_output_125_0_g2437;
					float3 temp_output_7_0_g2438 = frac( ( (ifLocalVar87_g2437).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2438 = dot( temp_output_7_0_g2438 , ( (temp_output_7_0_g2438).yzx + 33.33 ) );
					float3 temp_output_12_0_g2438 = ( temp_output_7_0_g2438 + dotResult8_g2438 );
					float2 temp_output_597_0_g2436 = ( UV100_g2437 + frac( ( ( (temp_output_12_0_g2438).xx + (temp_output_12_0_g2438).yz ) * (temp_output_12_0_g2438).zy ) ) );
					float2 DDX631_g2436 = ddx( temp_output_5_0_g2436 );
					float2 DDY632_g2436 = ddy( temp_output_5_0_g2436 );
					float temp_output_65_0_g2437 = ( 0.0 - temp_output_56_0_g2437 );
					float ifLocalVar59_g2437 = 0;
					if( temp_output_56_0_g2437 <= 0.0 )
					ifLocalVar59_g2437 = temp_output_65_0_g2437;
					else
					ifLocalVar59_g2437 = temp_output_56_0_g2437;
					float temp_output_597_30_g2436 = ifLocalVar59_g2437;
					float2 temp_output_90_0_g2437 = ( temp_output_52_0_g2437 + float2( 0,1 ) );
					float2 temp_output_123_0_g2437 = ( temp_output_52_0_g2437 + float2( 1,0 ) );
					float2 ifLocalVar88_g2437 = 0;
					if( temp_output_56_0_g2437 > 0.0 )
					ifLocalVar88_g2437 = temp_output_90_0_g2437;
					else if( temp_output_56_0_g2437 == 0.0 )
					ifLocalVar88_g2437 = temp_output_123_0_g2437;
					else if( temp_output_56_0_g2437 < 0.0 )
					ifLocalVar88_g2437 = temp_output_123_0_g2437;
					float3 temp_output_7_0_g2439 = frac( ( (ifLocalVar88_g2437).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2439 = dot( temp_output_7_0_g2439 , ( (temp_output_7_0_g2439).yzx + 33.33 ) );
					float3 temp_output_12_0_g2439 = ( temp_output_7_0_g2439 + dotResult8_g2439 );
					float2 temp_output_597_26_g2436 = ( UV100_g2437 + frac( ( ( (temp_output_12_0_g2439).xx + (temp_output_12_0_g2439).yz ) * (temp_output_12_0_g2439).zy ) ) );
					float temp_output_66_0_g2437 = ( 1.0 - break55_g2437.y );
					float ifLocalVar60_g2437 = 0;
					if( temp_output_56_0_g2437 <= 0.0 )
					ifLocalVar60_g2437 = temp_output_66_0_g2437;
					else
					ifLocalVar60_g2437 = break55_g2437.y;
					float temp_output_597_28_g2436 = ifLocalVar60_g2437;
					float2 ifLocalVar89_g2437 = 0;
					if( temp_output_56_0_g2437 > 0.0 )
					ifLocalVar89_g2437 = temp_output_123_0_g2437;
					else if( temp_output_56_0_g2437 == 0.0 )
					ifLocalVar89_g2437 = temp_output_90_0_g2437;
					else if( temp_output_56_0_g2437 < 0.0 )
					ifLocalVar89_g2437 = temp_output_90_0_g2437;
					float3 temp_output_7_0_g2440 = frac( ( (ifLocalVar89_g2437).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2440 = dot( temp_output_7_0_g2440 , ( (temp_output_7_0_g2440).yzx + 33.33 ) );
					float3 temp_output_12_0_g2440 = ( temp_output_7_0_g2440 + dotResult8_g2440 );
					float2 temp_output_597_27_g2436 = ( UV100_g2437 + frac( ( ( (temp_output_12_0_g2440).xx + (temp_output_12_0_g2440).yz ) * (temp_output_12_0_g2440).zy ) ) );
					float temp_output_67_0_g2437 = ( 1.0 - break55_g2437.x );
					float ifLocalVar61_g2437 = 0;
					if( temp_output_56_0_g2437 <= 0.0 )
					ifLocalVar61_g2437 = temp_output_67_0_g2437;
					else
					ifLocalVar61_g2437 = break55_g2437.x;
					float temp_output_597_29_g2436 = ifLocalVar61_g2437;
					float4 Output_2D293_g2436 = ( ( tex2D( _GlossinessMap, temp_output_597_0_g2436, DDX631_g2436, DDY632_g2436 ) * temp_output_597_30_g2436 ) + ( tex2D( _GlossinessMap, temp_output_597_26_g2436, DDX631_g2436, DDY632_g2436 ) * temp_output_597_28_g2436 ) + ( tex2D( _GlossinessMap, temp_output_597_27_g2436, DDX631_g2436, DDY632_g2436 ) * temp_output_597_29_g2436 ) );
					float4 break31_g2436 = Output_2D293_g2436;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g2409 = break31_g2436.a;
					#else
					float staticSwitch1004_g2409 = tex2D( _GlossinessMap, uv_GlossinessMap64_g2409 ).a;
					#endif
					float saferPower804_g2409 = abs( staticSwitch1004_g2409 );
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g2409 = ( 1.0 - pow( saferPower804_g2409 , 3.0 ) );
					#else
					float staticSwitch845_g2409 = _Glossiness;
					#endif
					float3 temp_output_3_0_g2451 = ddx( NormalWS );
					float dotResult5_g2451 = dot( temp_output_3_0_g2451 , temp_output_3_0_g2451 );
					float3 temp_output_4_0_g2451 = ddy( NormalWS );
					float dotResult6_g2451 = dot( temp_output_4_0_g2451 , temp_output_4_0_g2451 );
					#ifdef _USEGEOMETRICANTIALIASING_ON
					float staticSwitch824_g2409 = min( staticSwitch845_g2409 , ( 1.0 - pow( saturate( max( dotResult5_g2451 , dotResult6_g2451 ) ) , 0.333 ) ) );
					#else
					float staticSwitch824_g2409 = staticSwitch845_g2409;
					#endif
					
					float White38_g2409 = 1.0;
					float4 temp_cast_1 = (White38_g2409).xxxx;
					float localBicubicPrepare2_g2411 = ( 0.0 );
					float2 uv3_Lightmap0 = IN.ase_texcoord6.zw * _Lightmap0_ST.xy + _Lightmap0_ST.zw;
					float2 Input_UV100_g2411 = uv3_Lightmap0;
					float2 UV2_g2411 = Input_UV100_g2411;
					float4 TexelSize2_g2411 = _Lightmap0_TexelSize;
					float2 UV02_g2411 = float2( 0,0 );
					float2 UV12_g2411 = float2( 0,0 );
					float2 UV22_g2411 = float2( 0,0 );
					float2 UV32_g2411 = float2( 0,0 );
					float W02_g2411 = 0;
					float W12_g2411 = 0;
					{
					{
					 UV2_g2411 = UV2_g2411 * TexelSize2_g2411.zw - 0.5;
					    float2 f = frac( UV2_g2411 );
					    UV2_g2411 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g2411.x - 0.5, UV2_g2411.x + 1.5, UV2_g2411.y - 0.5, UV2_g2411.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g2411.xyxy;
					    UV02_g2411 = off.xz;
					    UV12_g2411 = off.yz;
					    UV22_g2411 = off.xw;
					    UV32_g2411 = off.yw;
					    W02_g2411 = s.x / ( s.x + s.y );
					 W12_g2411 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g2411 = lerp( tex2D( _Lightmap0, UV32_g2411 ) , tex2D( _Lightmap0, UV22_g2411 ) , W02_g2411);
					float4 lerpResult45_g2411 = lerp( tex2D( _Lightmap0, UV12_g2411 ) , tex2D( _Lightmap0, UV02_g2411 ) , W02_g2411);
					float4 lerpResult44_g2411 = lerp( lerpResult46_g2411 , lerpResult45_g2411 , W12_g2411);
					float4 Output_2D131_g2411 = lerpResult44_g2411;
					float4 Lightmap_0925_g2409 = Output_2D131_g2411;
					float localBicubicPrepare2_g2413 = ( 0.0 );
					float2 uv3_Lightmap1 = IN.ase_texcoord6.zw * _Lightmap1_ST.xy + _Lightmap1_ST.zw;
					float2 Input_UV100_g2413 = uv3_Lightmap1;
					float2 UV2_g2413 = Input_UV100_g2413;
					float4 TexelSize2_g2413 = _Lightmap1_TexelSize;
					float2 UV02_g2413 = float2( 0,0 );
					float2 UV12_g2413 = float2( 0,0 );
					float2 UV22_g2413 = float2( 0,0 );
					float2 UV32_g2413 = float2( 0,0 );
					float W02_g2413 = 0;
					float W12_g2413 = 0;
					{
					{
					 UV2_g2413 = UV2_g2413 * TexelSize2_g2413.zw - 0.5;
					    float2 f = frac( UV2_g2413 );
					    UV2_g2413 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g2413.x - 0.5, UV2_g2413.x + 1.5, UV2_g2413.y - 0.5, UV2_g2413.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g2413.xyxy;
					    UV02_g2413 = off.xz;
					    UV12_g2413 = off.yz;
					    UV22_g2413 = off.xw;
					    UV32_g2413 = off.yw;
					    W02_g2413 = s.x / ( s.x + s.y );
					 W12_g2413 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g2413 = lerp( tex2D( _Lightmap1, UV32_g2413 ) , tex2D( _Lightmap1, UV22_g2413 ) , W02_g2413);
					float4 lerpResult45_g2413 = lerp( tex2D( _Lightmap1, UV12_g2413 ) , tex2D( _Lightmap1, UV02_g2413 ) , W02_g2413);
					float4 lerpResult44_g2413 = lerp( lerpResult46_g2413 , lerpResult45_g2413 , W12_g2413);
					float4 Output_2D131_g2413 = lerpResult44_g2413;
					float4 Lightmap_1956_g2409 = Output_2D131_g2413;
					float4 lerpResult442_g2409 = lerp( Lightmap_0925_g2409 , Lightmap_1956_g2409 , _LightmapLerp);
					float4 Lightmap_Lerp932_g2409 = lerpResult442_g2409;
					float3 appendResult139_g2424 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g2424 = normalize( Normal_Map700_g2409 );
					float3 Normal_Map318_g2424 = normalizeResult326_g2424;
					float dotResult121_g2424 = dot( appendResult139_g2424 , Normal_Map318_g2424 );
					float localStochasticTiling2_g2420 = ( 0.0 );
					float2 uv3_RNMX0 = IN.ase_texcoord6.zw * _RNMX0_ST.xy + _RNMX0_ST.zw;
					float2 UV2_g2420 = uv3_RNMX0;
					float4 TexelSize2_g2420 = _RNMX0_TexelSize;
					float4 Offsets2_g2420 = float4( 0,0,0,0 );
					float2 Weights2_g2420 = float2( 0,0 );
					{
					UV2_g2420 = UV2_g2420 * TexelSize2_g2420.zw - 0.5;
					float2 f = frac( UV2_g2420 );
					UV2_g2420 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g2420.x - 0.5, UV2_g2420.x + 1.5, UV2_g2420.y - 0.5, UV2_g2420.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g2420 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g2420.xyxy;
					Weights2_g2420 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g2419 = Offsets2_g2420;
					float4 Input_FetchOffsets197_g2423 = temp_output_1_34_g2419;
					float2 temp_output_1_54_g2419 = Weights2_g2420;
					float2 Input_FetchWeights200_g2423 = temp_output_1_54_g2419;
					float2 break187_g2423 = Input_FetchWeights200_g2423;
					float4 lerpResult181_g2423 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g2423).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g2423).xw ) , break187_g2423.x);
					float4 lerpResult182_g2423 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g2423).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g2423).xz ) , break187_g2423.x);
					float4 lerpResult176_g2423 = lerp( lerpResult181_g2423 , lerpResult182_g2423 , break187_g2423.y);
					float4 Output_Fetch2D202_g2423 = lerpResult176_g2423;
					float3 appendResult146_g2424 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g2424 = dot( appendResult146_g2424 , Normal_Map318_g2424 );
					float4 Input_FetchOffsets197_g2421 = temp_output_1_34_g2419;
					float2 Input_FetchWeights200_g2421 = temp_output_1_54_g2419;
					float2 break187_g2421 = Input_FetchWeights200_g2421;
					float4 lerpResult181_g2421 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g2421).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g2421).xw ) , break187_g2421.x);
					float4 lerpResult182_g2421 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g2421).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g2421).xz ) , break187_g2421.x);
					float4 lerpResult176_g2421 = lerp( lerpResult181_g2421 , lerpResult182_g2421 , break187_g2421.y);
					float4 Output_Fetch2D202_g2421 = lerpResult176_g2421;
					float3 appendResult149_g2424 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g2424 = dot( appendResult149_g2424 , Normal_Map318_g2424 );
					float4 Input_FetchOffsets197_g2422 = temp_output_1_34_g2419;
					float2 Input_FetchWeights200_g2422 = temp_output_1_54_g2419;
					float2 break187_g2422 = Input_FetchWeights200_g2422;
					float4 lerpResult181_g2422 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g2422).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g2422).xw ) , break187_g2422.x);
					float4 lerpResult182_g2422 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g2422).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g2422).xz ) , break187_g2422.x);
					float4 lerpResult176_g2422 = lerp( lerpResult181_g2422 , lerpResult182_g2422 , break187_g2422.y);
					float4 Output_Fetch2D202_g2422 = lerpResult176_g2422;
					float4 RNM_0926_g2409 = ( ( ( saturate( dotResult121_g2424 ) * ( Output_Fetch2D202_g2423 * 0.8 ) ) + ( saturate( dotResult122_g2424 ) * ( Output_Fetch2D202_g2421 * 0.8 ) ) ) + ( saturate( dotResult120_g2424 ) * ( Output_Fetch2D202_g2422 * 0.8 ) ) );
					float3 appendResult139_g2425 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g2425 = normalize( Normal_Map700_g2409 );
					float3 Normal_Map318_g2425 = normalizeResult326_g2425;
					float dotResult121_g2425 = dot( appendResult139_g2425 , Normal_Map318_g2425 );
					float localStochasticTiling2_g2415 = ( 0.0 );
					float2 uv3_RNMX1 = IN.ase_texcoord6.zw * _RNMX1_ST.xy + _RNMX1_ST.zw;
					float2 UV2_g2415 = uv3_RNMX1;
					float4 TexelSize2_g2415 = _RNMX1_TexelSize;
					float4 Offsets2_g2415 = float4( 0,0,0,0 );
					float2 Weights2_g2415 = float2( 0,0 );
					{
					UV2_g2415 = UV2_g2415 * TexelSize2_g2415.zw - 0.5;
					float2 f = frac( UV2_g2415 );
					UV2_g2415 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g2415.x - 0.5, UV2_g2415.x + 1.5, UV2_g2415.y - 0.5, UV2_g2415.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g2415 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g2415.xyxy;
					Weights2_g2415 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g2414 = Offsets2_g2415;
					float4 Input_FetchOffsets197_g2418 = temp_output_1_34_g2414;
					float2 temp_output_1_54_g2414 = Weights2_g2415;
					float2 Input_FetchWeights200_g2418 = temp_output_1_54_g2414;
					float2 break187_g2418 = Input_FetchWeights200_g2418;
					float4 lerpResult181_g2418 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g2418).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g2418).xw ) , break187_g2418.x);
					float4 lerpResult182_g2418 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g2418).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g2418).xz ) , break187_g2418.x);
					float4 lerpResult176_g2418 = lerp( lerpResult181_g2418 , lerpResult182_g2418 , break187_g2418.y);
					float4 Output_Fetch2D202_g2418 = lerpResult176_g2418;
					float3 appendResult146_g2425 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g2425 = dot( appendResult146_g2425 , Normal_Map318_g2425 );
					float4 Input_FetchOffsets197_g2416 = temp_output_1_34_g2414;
					float2 Input_FetchWeights200_g2416 = temp_output_1_54_g2414;
					float2 break187_g2416 = Input_FetchWeights200_g2416;
					float4 lerpResult181_g2416 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g2416).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g2416).xw ) , break187_g2416.x);
					float4 lerpResult182_g2416 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g2416).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g2416).xz ) , break187_g2416.x);
					float4 lerpResult176_g2416 = lerp( lerpResult181_g2416 , lerpResult182_g2416 , break187_g2416.y);
					float4 Output_Fetch2D202_g2416 = lerpResult176_g2416;
					float3 appendResult149_g2425 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g2425 = dot( appendResult149_g2425 , Normal_Map318_g2425 );
					float4 Input_FetchOffsets197_g2417 = temp_output_1_34_g2414;
					float2 Input_FetchWeights200_g2417 = temp_output_1_54_g2414;
					float2 break187_g2417 = Input_FetchWeights200_g2417;
					float4 lerpResult181_g2417 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g2417).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g2417).xw ) , break187_g2417.x);
					float4 lerpResult182_g2417 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g2417).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g2417).xz ) , break187_g2417.x);
					float4 lerpResult176_g2417 = lerp( lerpResult181_g2417 , lerpResult182_g2417 , break187_g2417.y);
					float4 Output_Fetch2D202_g2417 = lerpResult176_g2417;
					float4 RNM_1927_g2409 = ( ( ( saturate( dotResult121_g2425 ) * ( Output_Fetch2D202_g2418 * 0.8 ) ) + ( saturate( dotResult122_g2425 ) * ( Output_Fetch2D202_g2416 * 0.8 ) ) ) + ( saturate( dotResult120_g2425 ) * ( Output_Fetch2D202_g2417 * 0.8 ) ) );
					float4 lerpResult953_g2409 = lerp( RNM_0926_g2409 , RNM_1927_g2409 , Metallic699_g2409);
					float4 RNM_Lerp950_g2409 = lerpResult953_g2409;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g2409 = temp_cast_1;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g2409 = Lightmap_0925_g2409;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g2409 = Lightmap_Lerp932_g2409;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g2409 = RNM_0926_g2409;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g2409 = RNM_Lerp950_g2409;
					#else
					float4 staticSwitch1014_g2409 = temp_cast_1;
					#endif
					float4 Lightmap46_g2409 = staticSwitch1014_g2409;
					float dotResult835_g2409 = dot( Lightmap46_g2409 , float4( float3( 0.299, 0.587, 0.114 ) , 0.0 ) );
					float saferPower606_g2409 = abs( dotResult835_g2409 );
					#ifdef _LIGHTMAPOCCLUSIONENABLED_ON
					float staticSwitch1018_g2409 = pow( saferPower606_g2409 , _OcclusionPower );
					#else
					float staticSwitch1018_g2409 = White38_g2409;
					#endif
					#if defined( _LIGHTMAPMODE_DISABLED )
					float staticSwitch1016_g2409 = White38_g2409;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float staticSwitch1016_g2409 = staticSwitch1018_g2409;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float staticSwitch1016_g2409 = staticSwitch1018_g2409;
					#elif defined( _LIGHTMAPMODE_RNM )
					float staticSwitch1016_g2409 = staticSwitch1018_g2409;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float staticSwitch1016_g2409 = staticSwitch1018_g2409;
					#else
					float staticSwitch1016_g2409 = White38_g2409;
					#endif
					
					float4 temp_output_614_0_g2409 = ( Albedo6_g2409 * Lightmap46_g2409 );
					float4 temp_cast_3 = 0;
					float2 uv_EmissionMap81_g2409 = IN.ase_texcoord6.xy;
					float2 uv_EmissionMap = IN.ase_texcoord6.xy * _EmissionMap_ST.xy + _EmissionMap_ST.zw;
					float2 temp_output_5_0_g2426 = uv_EmissionMap;
					float2 UV633_g2426 = temp_output_5_0_g2426;
					float2 UV100_g2427 = UV633_g2426;
					float2 temp_output_51_0_g2427 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g2427 * float2( 3.464,3.464 ) ) );
					float2 break55_g2427 = frac( temp_output_51_0_g2427 );
					float temp_output_56_0_g2427 = ( ( 1.0 - break55_g2427.x ) - break55_g2427.y );
					float2 temp_output_52_0_g2427 = floor( temp_output_51_0_g2427 );
					float2 temp_output_125_0_g2427 = ( temp_output_52_0_g2427 + float2( 1,1 ) );
					float2 ifLocalVar87_g2427 = 0;
					if( temp_output_56_0_g2427 > 0.0 )
					ifLocalVar87_g2427 = temp_output_52_0_g2427;
					else if( temp_output_56_0_g2427 == 0.0 )
					ifLocalVar87_g2427 = temp_output_125_0_g2427;
					else if( temp_output_56_0_g2427 < 0.0 )
					ifLocalVar87_g2427 = temp_output_125_0_g2427;
					float3 temp_output_7_0_g2428 = frac( ( (ifLocalVar87_g2427).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2428 = dot( temp_output_7_0_g2428 , ( (temp_output_7_0_g2428).yzx + 33.33 ) );
					float3 temp_output_12_0_g2428 = ( temp_output_7_0_g2428 + dotResult8_g2428 );
					float2 temp_output_597_0_g2426 = ( UV100_g2427 + frac( ( ( (temp_output_12_0_g2428).xx + (temp_output_12_0_g2428).yz ) * (temp_output_12_0_g2428).zy ) ) );
					float2 DDX631_g2426 = ddx( temp_output_5_0_g2426 );
					float2 DDY632_g2426 = ddy( temp_output_5_0_g2426 );
					float temp_output_65_0_g2427 = ( 0.0 - temp_output_56_0_g2427 );
					float ifLocalVar59_g2427 = 0;
					if( temp_output_56_0_g2427 <= 0.0 )
					ifLocalVar59_g2427 = temp_output_65_0_g2427;
					else
					ifLocalVar59_g2427 = temp_output_56_0_g2427;
					float temp_output_597_30_g2426 = ifLocalVar59_g2427;
					float2 temp_output_90_0_g2427 = ( temp_output_52_0_g2427 + float2( 0,1 ) );
					float2 temp_output_123_0_g2427 = ( temp_output_52_0_g2427 + float2( 1,0 ) );
					float2 ifLocalVar88_g2427 = 0;
					if( temp_output_56_0_g2427 > 0.0 )
					ifLocalVar88_g2427 = temp_output_90_0_g2427;
					else if( temp_output_56_0_g2427 == 0.0 )
					ifLocalVar88_g2427 = temp_output_123_0_g2427;
					else if( temp_output_56_0_g2427 < 0.0 )
					ifLocalVar88_g2427 = temp_output_123_0_g2427;
					float3 temp_output_7_0_g2429 = frac( ( (ifLocalVar88_g2427).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2429 = dot( temp_output_7_0_g2429 , ( (temp_output_7_0_g2429).yzx + 33.33 ) );
					float3 temp_output_12_0_g2429 = ( temp_output_7_0_g2429 + dotResult8_g2429 );
					float2 temp_output_597_26_g2426 = ( UV100_g2427 + frac( ( ( (temp_output_12_0_g2429).xx + (temp_output_12_0_g2429).yz ) * (temp_output_12_0_g2429).zy ) ) );
					float temp_output_66_0_g2427 = ( 1.0 - break55_g2427.y );
					float ifLocalVar60_g2427 = 0;
					if( temp_output_56_0_g2427 <= 0.0 )
					ifLocalVar60_g2427 = temp_output_66_0_g2427;
					else
					ifLocalVar60_g2427 = break55_g2427.y;
					float temp_output_597_28_g2426 = ifLocalVar60_g2427;
					float2 ifLocalVar89_g2427 = 0;
					if( temp_output_56_0_g2427 > 0.0 )
					ifLocalVar89_g2427 = temp_output_123_0_g2427;
					else if( temp_output_56_0_g2427 == 0.0 )
					ifLocalVar89_g2427 = temp_output_90_0_g2427;
					else if( temp_output_56_0_g2427 < 0.0 )
					ifLocalVar89_g2427 = temp_output_90_0_g2427;
					float3 temp_output_7_0_g2430 = frac( ( (ifLocalVar89_g2427).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2430 = dot( temp_output_7_0_g2430 , ( (temp_output_7_0_g2430).yzx + 33.33 ) );
					float3 temp_output_12_0_g2430 = ( temp_output_7_0_g2430 + dotResult8_g2430 );
					float2 temp_output_597_27_g2426 = ( UV100_g2427 + frac( ( ( (temp_output_12_0_g2430).xx + (temp_output_12_0_g2430).yz ) * (temp_output_12_0_g2430).zy ) ) );
					float temp_output_67_0_g2427 = ( 1.0 - break55_g2427.x );
					float ifLocalVar61_g2427 = 0;
					if( temp_output_56_0_g2427 <= 0.0 )
					ifLocalVar61_g2427 = temp_output_67_0_g2427;
					else
					ifLocalVar61_g2427 = break55_g2427.x;
					float temp_output_597_29_g2426 = ifLocalVar61_g2427;
					float4 Output_2D293_g2426 = ( ( tex2D( _EmissionMap, temp_output_597_0_g2426, DDX631_g2426, DDY632_g2426 ) * temp_output_597_30_g2426 ) + ( tex2D( _EmissionMap, temp_output_597_26_g2426, DDX631_g2426, DDY632_g2426 ) * temp_output_597_28_g2426 ) + ( tex2D( _EmissionMap, temp_output_597_27_g2426, DDX631_g2426, DDY632_g2426 ) * temp_output_597_29_g2426 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g2409 = Output_2D293_g2426;
					#else
					float4 staticSwitch1006_g2409 = tex2D( _EmissionMap, uv_EmissionMap81_g2409 );
					#endif
					#ifdef _EMISSIONENABLED_ON
					float4 staticSwitch1017_g2409 = ( _EmissionColor + staticSwitch1006_g2409 );
					#else
					float4 staticSwitch1017_g2409 = temp_cast_3;
					#endif
					float4 Emission86_g2409 = staticSwitch1017_g2409;
					float4 temp_output_690_0_g2409 = ( Emission86_g2409 + temp_output_614_0_g2409 );
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1019_g2409 = ( temp_output_614_0_g2409 * Emission86_g2409 );
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1019_g2409 = temp_output_690_0_g2409;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1019_g2409 = temp_output_690_0_g2409;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1019_g2409 = temp_output_690_0_g2409;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1019_g2409 = temp_output_690_0_g2409;
					#else
					float4 staticSwitch1019_g2409 = ( temp_output_614_0_g2409 * Emission86_g2409 );
					#endif
					

					o.Albedo = Albedo6_g2409.rgb;
					o.Normal = Normal_Map700_g2409;

					half3 Specular = half3( 0, 0, 0 );
					half Metallic = Metallic699_g2409;
					half Smoothness = staticSwitch824_g2409;
					half Occlusion = staticSwitch1016_g2409;

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

					o.Emission = staticSwitch1019_g2409.rgb;
					o.Alpha = temp_output_976_0_g2409.a;
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
				#define ASE_RECEIVE_SHADOWS
				#pragma multi_compile _ LOD_FADE_CROSSFADE
				#pragma multi_compile_fog
				#define ASE_FOG
				#pragma multi_compile_local_fragment _SPECULARHIGHLIGHTS_OFF
				#pragma multi_compile_instancing
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
				#define ASE_NEEDS_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_NORMAL
				#define ASE_NEEDS_TEXTURE_COORDINATES2
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
				#pragma shader_feature_local _STOCHASTICENABLED_ON
				#pragma shader_feature_local_fragment _BUMPMAP
				#pragma shader_feature_local_fragment _METALLICMAP
				#pragma shader_feature_local_fragment _USEGEOMETRICANTIALIASING_ON
				#pragma shader_feature_local_fragment _GLOSSINESSMAP
				#pragma shader_feature_local _LIGHTMAPMODE_DISABLED _LIGHTMAPMODE_SIMPLE _LIGHTMAPMODE_SIMPLELERP _LIGHTMAPMODE_RNM _LIGHTMAPMODE_RNMLERP
				#pragma shader_feature_local _LIGHTMAPOCCLUSIONENABLED_ON
				#pragma shader_feature_local _EMISSIONENABLED_ON


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
				uniform float _CATEGORYSPACESTOCHASTIC;
				uniform float _CATEGORYSTOCHASTIC;
				uniform float _CATEGORYLIGHTMAPPING;
				uniform float _CATEGORYSPACELIGHTMAPPING;
				uniform float4 _Color;
				uniform sampler2D _MainTex;
				uniform float4 _MainTex_ST;
				uniform sampler2D _BumpMap;
				uniform float _NormalScale;
				uniform float4 _BumpMap_ST;
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				uniform float4 _MetallicMap_ST;
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				uniform float4 _GlossinessMap_ST;
				uniform sampler2D _Lightmap0;
				uniform float4 _Lightmap0_ST;
				float4 _Lightmap0_TexelSize;
				uniform sampler2D _Lightmap1;
				uniform float4 _Lightmap1_ST;
				float4 _Lightmap1_TexelSize;
				uniform float _LightmapLerp;
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
				uniform float _OcclusionPower;
				uniform float4 _EmissionColor;
				uniform sampler2D _EmissionMap;
				uniform float4 _EmissionMap_ST;


				
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
					float3 vertexValue = ( v.normal * -0.001 );
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

					float2 uv_MainTex907_g2409 = IN.ase_texcoord5.xy;
					float2 uv_MainTex = IN.ase_texcoord5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					float2 temp_output_5_0_g2446 = uv_MainTex;
					float2 UV633_g2446 = temp_output_5_0_g2446;
					float2 UV100_g2447 = UV633_g2446;
					float2 temp_output_51_0_g2447 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g2447 * float2( 3.464,3.464 ) ) );
					float2 break55_g2447 = frac( temp_output_51_0_g2447 );
					float temp_output_56_0_g2447 = ( ( 1.0 - break55_g2447.x ) - break55_g2447.y );
					float2 temp_output_52_0_g2447 = floor( temp_output_51_0_g2447 );
					float2 temp_output_125_0_g2447 = ( temp_output_52_0_g2447 + float2( 1,1 ) );
					float2 ifLocalVar87_g2447 = 0;
					if( temp_output_56_0_g2447 > 0.0 )
					ifLocalVar87_g2447 = temp_output_52_0_g2447;
					else if( temp_output_56_0_g2447 == 0.0 )
					ifLocalVar87_g2447 = temp_output_125_0_g2447;
					else if( temp_output_56_0_g2447 < 0.0 )
					ifLocalVar87_g2447 = temp_output_125_0_g2447;
					float3 temp_output_7_0_g2448 = frac( ( (ifLocalVar87_g2447).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2448 = dot( temp_output_7_0_g2448 , ( (temp_output_7_0_g2448).yzx + 33.33 ) );
					float3 temp_output_12_0_g2448 = ( temp_output_7_0_g2448 + dotResult8_g2448 );
					float2 temp_output_597_0_g2446 = ( UV100_g2447 + frac( ( ( (temp_output_12_0_g2448).xx + (temp_output_12_0_g2448).yz ) * (temp_output_12_0_g2448).zy ) ) );
					float2 DDX631_g2446 = ddx( temp_output_5_0_g2446 );
					float2 DDY632_g2446 = ddy( temp_output_5_0_g2446 );
					float temp_output_65_0_g2447 = ( 0.0 - temp_output_56_0_g2447 );
					float ifLocalVar59_g2447 = 0;
					if( temp_output_56_0_g2447 <= 0.0 )
					ifLocalVar59_g2447 = temp_output_65_0_g2447;
					else
					ifLocalVar59_g2447 = temp_output_56_0_g2447;
					float temp_output_597_30_g2446 = ifLocalVar59_g2447;
					float2 temp_output_90_0_g2447 = ( temp_output_52_0_g2447 + float2( 0,1 ) );
					float2 temp_output_123_0_g2447 = ( temp_output_52_0_g2447 + float2( 1,0 ) );
					float2 ifLocalVar88_g2447 = 0;
					if( temp_output_56_0_g2447 > 0.0 )
					ifLocalVar88_g2447 = temp_output_90_0_g2447;
					else if( temp_output_56_0_g2447 == 0.0 )
					ifLocalVar88_g2447 = temp_output_123_0_g2447;
					else if( temp_output_56_0_g2447 < 0.0 )
					ifLocalVar88_g2447 = temp_output_123_0_g2447;
					float3 temp_output_7_0_g2449 = frac( ( (ifLocalVar88_g2447).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2449 = dot( temp_output_7_0_g2449 , ( (temp_output_7_0_g2449).yzx + 33.33 ) );
					float3 temp_output_12_0_g2449 = ( temp_output_7_0_g2449 + dotResult8_g2449 );
					float2 temp_output_597_26_g2446 = ( UV100_g2447 + frac( ( ( (temp_output_12_0_g2449).xx + (temp_output_12_0_g2449).yz ) * (temp_output_12_0_g2449).zy ) ) );
					float temp_output_66_0_g2447 = ( 1.0 - break55_g2447.y );
					float ifLocalVar60_g2447 = 0;
					if( temp_output_56_0_g2447 <= 0.0 )
					ifLocalVar60_g2447 = temp_output_66_0_g2447;
					else
					ifLocalVar60_g2447 = break55_g2447.y;
					float temp_output_597_28_g2446 = ifLocalVar60_g2447;
					float2 ifLocalVar89_g2447 = 0;
					if( temp_output_56_0_g2447 > 0.0 )
					ifLocalVar89_g2447 = temp_output_123_0_g2447;
					else if( temp_output_56_0_g2447 == 0.0 )
					ifLocalVar89_g2447 = temp_output_90_0_g2447;
					else if( temp_output_56_0_g2447 < 0.0 )
					ifLocalVar89_g2447 = temp_output_90_0_g2447;
					float3 temp_output_7_0_g2450 = frac( ( (ifLocalVar89_g2447).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2450 = dot( temp_output_7_0_g2450 , ( (temp_output_7_0_g2450).yzx + 33.33 ) );
					float3 temp_output_12_0_g2450 = ( temp_output_7_0_g2450 + dotResult8_g2450 );
					float2 temp_output_597_27_g2446 = ( UV100_g2447 + frac( ( ( (temp_output_12_0_g2450).xx + (temp_output_12_0_g2450).yz ) * (temp_output_12_0_g2450).zy ) ) );
					float temp_output_67_0_g2447 = ( 1.0 - break55_g2447.x );
					float ifLocalVar61_g2447 = 0;
					if( temp_output_56_0_g2447 <= 0.0 )
					ifLocalVar61_g2447 = temp_output_67_0_g2447;
					else
					ifLocalVar61_g2447 = break55_g2447.x;
					float temp_output_597_29_g2446 = ifLocalVar61_g2447;
					float4 Output_2D293_g2446 = ( ( tex2D( _MainTex, temp_output_597_0_g2446, DDX631_g2446, DDY632_g2446 ) * temp_output_597_30_g2446 ) + ( tex2D( _MainTex, temp_output_597_26_g2446, DDX631_g2446, DDY632_g2446 ) * temp_output_597_28_g2446 ) + ( tex2D( _MainTex, temp_output_597_27_g2446, DDX631_g2446, DDY632_g2446 ) * temp_output_597_29_g2446 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g2409 = Output_2D293_g2446;
					#else
					float4 staticSwitch1001_g2409 = tex2D( _MainTex, uv_MainTex907_g2409 );
					#endif
					float4 temp_output_976_0_g2409 = ( _Color * staticSwitch1001_g2409 );
					float4 Albedo6_g2409 = temp_output_976_0_g2409;
					
					float2 uv_BumpMap830_g2409 = IN.ase_texcoord5.xy;
					float2 uv_BumpMap = IN.ase_texcoord5.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					float2 temp_output_5_0_g2441 = uv_BumpMap;
					float2 UV633_g2441 = temp_output_5_0_g2441;
					float2 UV100_g2442 = UV633_g2441;
					float2 temp_output_51_0_g2442 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g2442 * float2( 3.464,3.464 ) ) );
					float2 break55_g2442 = frac( temp_output_51_0_g2442 );
					float temp_output_56_0_g2442 = ( ( 1.0 - break55_g2442.x ) - break55_g2442.y );
					float2 temp_output_52_0_g2442 = floor( temp_output_51_0_g2442 );
					float2 temp_output_125_0_g2442 = ( temp_output_52_0_g2442 + float2( 1,1 ) );
					float2 ifLocalVar87_g2442 = 0;
					if( temp_output_56_0_g2442 > 0.0 )
					ifLocalVar87_g2442 = temp_output_52_0_g2442;
					else if( temp_output_56_0_g2442 == 0.0 )
					ifLocalVar87_g2442 = temp_output_125_0_g2442;
					else if( temp_output_56_0_g2442 < 0.0 )
					ifLocalVar87_g2442 = temp_output_125_0_g2442;
					float3 temp_output_7_0_g2443 = frac( ( (ifLocalVar87_g2442).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2443 = dot( temp_output_7_0_g2443 , ( (temp_output_7_0_g2443).yzx + 33.33 ) );
					float3 temp_output_12_0_g2443 = ( temp_output_7_0_g2443 + dotResult8_g2443 );
					float2 temp_output_597_0_g2441 = ( UV100_g2442 + frac( ( ( (temp_output_12_0_g2443).xx + (temp_output_12_0_g2443).yz ) * (temp_output_12_0_g2443).zy ) ) );
					float2 DDX631_g2441 = ddx( temp_output_5_0_g2441 );
					float2 DDY632_g2441 = ddy( temp_output_5_0_g2441 );
					float Input_Scale617_g2441 = _NormalScale;
					float temp_output_65_0_g2442 = ( 0.0 - temp_output_56_0_g2442 );
					float ifLocalVar59_g2442 = 0;
					if( temp_output_56_0_g2442 <= 0.0 )
					ifLocalVar59_g2442 = temp_output_65_0_g2442;
					else
					ifLocalVar59_g2442 = temp_output_56_0_g2442;
					float temp_output_597_30_g2441 = ifLocalVar59_g2442;
					float2 temp_output_90_0_g2442 = ( temp_output_52_0_g2442 + float2( 0,1 ) );
					float2 temp_output_123_0_g2442 = ( temp_output_52_0_g2442 + float2( 1,0 ) );
					float2 ifLocalVar88_g2442 = 0;
					if( temp_output_56_0_g2442 > 0.0 )
					ifLocalVar88_g2442 = temp_output_90_0_g2442;
					else if( temp_output_56_0_g2442 == 0.0 )
					ifLocalVar88_g2442 = temp_output_123_0_g2442;
					else if( temp_output_56_0_g2442 < 0.0 )
					ifLocalVar88_g2442 = temp_output_123_0_g2442;
					float3 temp_output_7_0_g2444 = frac( ( (ifLocalVar88_g2442).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2444 = dot( temp_output_7_0_g2444 , ( (temp_output_7_0_g2444).yzx + 33.33 ) );
					float3 temp_output_12_0_g2444 = ( temp_output_7_0_g2444 + dotResult8_g2444 );
					float2 temp_output_597_26_g2441 = ( UV100_g2442 + frac( ( ( (temp_output_12_0_g2444).xx + (temp_output_12_0_g2444).yz ) * (temp_output_12_0_g2444).zy ) ) );
					float temp_output_66_0_g2442 = ( 1.0 - break55_g2442.y );
					float ifLocalVar60_g2442 = 0;
					if( temp_output_56_0_g2442 <= 0.0 )
					ifLocalVar60_g2442 = temp_output_66_0_g2442;
					else
					ifLocalVar60_g2442 = break55_g2442.y;
					float temp_output_597_28_g2441 = ifLocalVar60_g2442;
					float2 ifLocalVar89_g2442 = 0;
					if( temp_output_56_0_g2442 > 0.0 )
					ifLocalVar89_g2442 = temp_output_123_0_g2442;
					else if( temp_output_56_0_g2442 == 0.0 )
					ifLocalVar89_g2442 = temp_output_90_0_g2442;
					else if( temp_output_56_0_g2442 < 0.0 )
					ifLocalVar89_g2442 = temp_output_90_0_g2442;
					float3 temp_output_7_0_g2445 = frac( ( (ifLocalVar89_g2442).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2445 = dot( temp_output_7_0_g2445 , ( (temp_output_7_0_g2445).yzx + 33.33 ) );
					float3 temp_output_12_0_g2445 = ( temp_output_7_0_g2445 + dotResult8_g2445 );
					float2 temp_output_597_27_g2441 = ( UV100_g2442 + frac( ( ( (temp_output_12_0_g2445).xx + (temp_output_12_0_g2445).yz ) * (temp_output_12_0_g2445).zy ) ) );
					float temp_output_67_0_g2442 = ( 1.0 - break55_g2442.x );
					float ifLocalVar61_g2442 = 0;
					if( temp_output_56_0_g2442 <= 0.0 )
					ifLocalVar61_g2442 = temp_output_67_0_g2442;
					else
					ifLocalVar61_g2442 = break55_g2442.x;
					float temp_output_597_29_g2441 = ifLocalVar61_g2442;
					float3 Output_2D_Normal641_g2441 = ( ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_0_g2441, DDX631_g2441, DDY632_g2441 ), Input_Scale617_g2441 ) * temp_output_597_30_g2441 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_26_g2441, DDX631_g2441, DDY632_g2441 ), Input_Scale617_g2441 ) * temp_output_597_28_g2441 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_27_g2441, DDX631_g2441, DDY632_g2441 ), Input_Scale617_g2441 ) * float3( 0,0,0 ) * temp_output_597_29_g2441 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g2409 = Output_2D_Normal641_g2441;
					#else
					float3 staticSwitch1003_g2409 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap830_g2409 ), _NormalScale );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g2409 = staticSwitch1003_g2409;
					#else
					float3 staticSwitch980_g2409 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g2409 = staticSwitch980_g2409;
					
					float2 uv_MetallicMap48_g2409 = IN.ase_texcoord5.xy;
					float2 uv_MetallicMap = IN.ase_texcoord5.xy * _MetallicMap_ST.xy + _MetallicMap_ST.zw;
					float2 temp_output_5_0_g2431 = uv_MetallicMap;
					float2 UV633_g2431 = temp_output_5_0_g2431;
					float2 UV100_g2432 = UV633_g2431;
					float2 temp_output_51_0_g2432 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g2432 * float2( 3.464,3.464 ) ) );
					float2 break55_g2432 = frac( temp_output_51_0_g2432 );
					float temp_output_56_0_g2432 = ( ( 1.0 - break55_g2432.x ) - break55_g2432.y );
					float2 temp_output_52_0_g2432 = floor( temp_output_51_0_g2432 );
					float2 temp_output_125_0_g2432 = ( temp_output_52_0_g2432 + float2( 1,1 ) );
					float2 ifLocalVar87_g2432 = 0;
					if( temp_output_56_0_g2432 > 0.0 )
					ifLocalVar87_g2432 = temp_output_52_0_g2432;
					else if( temp_output_56_0_g2432 == 0.0 )
					ifLocalVar87_g2432 = temp_output_125_0_g2432;
					else if( temp_output_56_0_g2432 < 0.0 )
					ifLocalVar87_g2432 = temp_output_125_0_g2432;
					float3 temp_output_7_0_g2433 = frac( ( (ifLocalVar87_g2432).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2433 = dot( temp_output_7_0_g2433 , ( (temp_output_7_0_g2433).yzx + 33.33 ) );
					float3 temp_output_12_0_g2433 = ( temp_output_7_0_g2433 + dotResult8_g2433 );
					float2 temp_output_597_0_g2431 = ( UV100_g2432 + frac( ( ( (temp_output_12_0_g2433).xx + (temp_output_12_0_g2433).yz ) * (temp_output_12_0_g2433).zy ) ) );
					float2 DDX631_g2431 = ddx( temp_output_5_0_g2431 );
					float2 DDY632_g2431 = ddy( temp_output_5_0_g2431 );
					float temp_output_65_0_g2432 = ( 0.0 - temp_output_56_0_g2432 );
					float ifLocalVar59_g2432 = 0;
					if( temp_output_56_0_g2432 <= 0.0 )
					ifLocalVar59_g2432 = temp_output_65_0_g2432;
					else
					ifLocalVar59_g2432 = temp_output_56_0_g2432;
					float temp_output_597_30_g2431 = ifLocalVar59_g2432;
					float2 temp_output_90_0_g2432 = ( temp_output_52_0_g2432 + float2( 0,1 ) );
					float2 temp_output_123_0_g2432 = ( temp_output_52_0_g2432 + float2( 1,0 ) );
					float2 ifLocalVar88_g2432 = 0;
					if( temp_output_56_0_g2432 > 0.0 )
					ifLocalVar88_g2432 = temp_output_90_0_g2432;
					else if( temp_output_56_0_g2432 == 0.0 )
					ifLocalVar88_g2432 = temp_output_123_0_g2432;
					else if( temp_output_56_0_g2432 < 0.0 )
					ifLocalVar88_g2432 = temp_output_123_0_g2432;
					float3 temp_output_7_0_g2434 = frac( ( (ifLocalVar88_g2432).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2434 = dot( temp_output_7_0_g2434 , ( (temp_output_7_0_g2434).yzx + 33.33 ) );
					float3 temp_output_12_0_g2434 = ( temp_output_7_0_g2434 + dotResult8_g2434 );
					float2 temp_output_597_26_g2431 = ( UV100_g2432 + frac( ( ( (temp_output_12_0_g2434).xx + (temp_output_12_0_g2434).yz ) * (temp_output_12_0_g2434).zy ) ) );
					float temp_output_66_0_g2432 = ( 1.0 - break55_g2432.y );
					float ifLocalVar60_g2432 = 0;
					if( temp_output_56_0_g2432 <= 0.0 )
					ifLocalVar60_g2432 = temp_output_66_0_g2432;
					else
					ifLocalVar60_g2432 = break55_g2432.y;
					float temp_output_597_28_g2431 = ifLocalVar60_g2432;
					float2 ifLocalVar89_g2432 = 0;
					if( temp_output_56_0_g2432 > 0.0 )
					ifLocalVar89_g2432 = temp_output_123_0_g2432;
					else if( temp_output_56_0_g2432 == 0.0 )
					ifLocalVar89_g2432 = temp_output_90_0_g2432;
					else if( temp_output_56_0_g2432 < 0.0 )
					ifLocalVar89_g2432 = temp_output_90_0_g2432;
					float3 temp_output_7_0_g2435 = frac( ( (ifLocalVar89_g2432).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2435 = dot( temp_output_7_0_g2435 , ( (temp_output_7_0_g2435).yzx + 33.33 ) );
					float3 temp_output_12_0_g2435 = ( temp_output_7_0_g2435 + dotResult8_g2435 );
					float2 temp_output_597_27_g2431 = ( UV100_g2432 + frac( ( ( (temp_output_12_0_g2435).xx + (temp_output_12_0_g2435).yz ) * (temp_output_12_0_g2435).zy ) ) );
					float temp_output_67_0_g2432 = ( 1.0 - break55_g2432.x );
					float ifLocalVar61_g2432 = 0;
					if( temp_output_56_0_g2432 <= 0.0 )
					ifLocalVar61_g2432 = temp_output_67_0_g2432;
					else
					ifLocalVar61_g2432 = break55_g2432.x;
					float temp_output_597_29_g2431 = ifLocalVar61_g2432;
					float4 Output_2D293_g2431 = ( ( tex2D( _MetallicMap, temp_output_597_0_g2431, DDX631_g2431, DDY632_g2431 ) * temp_output_597_30_g2431 ) + ( tex2D( _MetallicMap, temp_output_597_26_g2431, DDX631_g2431, DDY632_g2431 ) * temp_output_597_28_g2431 ) + ( tex2D( _MetallicMap, temp_output_597_27_g2431, DDX631_g2431, DDY632_g2431 ) * temp_output_597_29_g2431 ) );
					float4 break31_g2431 = Output_2D293_g2431;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g2409 = break31_g2431.a;
					#else
					float staticSwitch1005_g2409 = tex2D( _MetallicMap, uv_MetallicMap48_g2409 ).a;
					#endif
					float saferPower803_g2409 = abs( staticSwitch1005_g2409 );
					#ifdef _METALLICMAP
					float staticSwitch846_g2409 = pow( saferPower803_g2409 , 3.0 );
					#else
					float staticSwitch846_g2409 = _Metallic;
					#endif
					float Metallic699_g2409 = staticSwitch846_g2409;
					
					float2 uv_GlossinessMap64_g2409 = IN.ase_texcoord5.xy;
					float2 uv_GlossinessMap = IN.ase_texcoord5.xy * _GlossinessMap_ST.xy + _GlossinessMap_ST.zw;
					float2 temp_output_5_0_g2436 = uv_GlossinessMap;
					float2 UV633_g2436 = temp_output_5_0_g2436;
					float2 UV100_g2437 = UV633_g2436;
					float2 temp_output_51_0_g2437 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g2437 * float2( 3.464,3.464 ) ) );
					float2 break55_g2437 = frac( temp_output_51_0_g2437 );
					float temp_output_56_0_g2437 = ( ( 1.0 - break55_g2437.x ) - break55_g2437.y );
					float2 temp_output_52_0_g2437 = floor( temp_output_51_0_g2437 );
					float2 temp_output_125_0_g2437 = ( temp_output_52_0_g2437 + float2( 1,1 ) );
					float2 ifLocalVar87_g2437 = 0;
					if( temp_output_56_0_g2437 > 0.0 )
					ifLocalVar87_g2437 = temp_output_52_0_g2437;
					else if( temp_output_56_0_g2437 == 0.0 )
					ifLocalVar87_g2437 = temp_output_125_0_g2437;
					else if( temp_output_56_0_g2437 < 0.0 )
					ifLocalVar87_g2437 = temp_output_125_0_g2437;
					float3 temp_output_7_0_g2438 = frac( ( (ifLocalVar87_g2437).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2438 = dot( temp_output_7_0_g2438 , ( (temp_output_7_0_g2438).yzx + 33.33 ) );
					float3 temp_output_12_0_g2438 = ( temp_output_7_0_g2438 + dotResult8_g2438 );
					float2 temp_output_597_0_g2436 = ( UV100_g2437 + frac( ( ( (temp_output_12_0_g2438).xx + (temp_output_12_0_g2438).yz ) * (temp_output_12_0_g2438).zy ) ) );
					float2 DDX631_g2436 = ddx( temp_output_5_0_g2436 );
					float2 DDY632_g2436 = ddy( temp_output_5_0_g2436 );
					float temp_output_65_0_g2437 = ( 0.0 - temp_output_56_0_g2437 );
					float ifLocalVar59_g2437 = 0;
					if( temp_output_56_0_g2437 <= 0.0 )
					ifLocalVar59_g2437 = temp_output_65_0_g2437;
					else
					ifLocalVar59_g2437 = temp_output_56_0_g2437;
					float temp_output_597_30_g2436 = ifLocalVar59_g2437;
					float2 temp_output_90_0_g2437 = ( temp_output_52_0_g2437 + float2( 0,1 ) );
					float2 temp_output_123_0_g2437 = ( temp_output_52_0_g2437 + float2( 1,0 ) );
					float2 ifLocalVar88_g2437 = 0;
					if( temp_output_56_0_g2437 > 0.0 )
					ifLocalVar88_g2437 = temp_output_90_0_g2437;
					else if( temp_output_56_0_g2437 == 0.0 )
					ifLocalVar88_g2437 = temp_output_123_0_g2437;
					else if( temp_output_56_0_g2437 < 0.0 )
					ifLocalVar88_g2437 = temp_output_123_0_g2437;
					float3 temp_output_7_0_g2439 = frac( ( (ifLocalVar88_g2437).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2439 = dot( temp_output_7_0_g2439 , ( (temp_output_7_0_g2439).yzx + 33.33 ) );
					float3 temp_output_12_0_g2439 = ( temp_output_7_0_g2439 + dotResult8_g2439 );
					float2 temp_output_597_26_g2436 = ( UV100_g2437 + frac( ( ( (temp_output_12_0_g2439).xx + (temp_output_12_0_g2439).yz ) * (temp_output_12_0_g2439).zy ) ) );
					float temp_output_66_0_g2437 = ( 1.0 - break55_g2437.y );
					float ifLocalVar60_g2437 = 0;
					if( temp_output_56_0_g2437 <= 0.0 )
					ifLocalVar60_g2437 = temp_output_66_0_g2437;
					else
					ifLocalVar60_g2437 = break55_g2437.y;
					float temp_output_597_28_g2436 = ifLocalVar60_g2437;
					float2 ifLocalVar89_g2437 = 0;
					if( temp_output_56_0_g2437 > 0.0 )
					ifLocalVar89_g2437 = temp_output_123_0_g2437;
					else if( temp_output_56_0_g2437 == 0.0 )
					ifLocalVar89_g2437 = temp_output_90_0_g2437;
					else if( temp_output_56_0_g2437 < 0.0 )
					ifLocalVar89_g2437 = temp_output_90_0_g2437;
					float3 temp_output_7_0_g2440 = frac( ( (ifLocalVar89_g2437).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2440 = dot( temp_output_7_0_g2440 , ( (temp_output_7_0_g2440).yzx + 33.33 ) );
					float3 temp_output_12_0_g2440 = ( temp_output_7_0_g2440 + dotResult8_g2440 );
					float2 temp_output_597_27_g2436 = ( UV100_g2437 + frac( ( ( (temp_output_12_0_g2440).xx + (temp_output_12_0_g2440).yz ) * (temp_output_12_0_g2440).zy ) ) );
					float temp_output_67_0_g2437 = ( 1.0 - break55_g2437.x );
					float ifLocalVar61_g2437 = 0;
					if( temp_output_56_0_g2437 <= 0.0 )
					ifLocalVar61_g2437 = temp_output_67_0_g2437;
					else
					ifLocalVar61_g2437 = break55_g2437.x;
					float temp_output_597_29_g2436 = ifLocalVar61_g2437;
					float4 Output_2D293_g2436 = ( ( tex2D( _GlossinessMap, temp_output_597_0_g2436, DDX631_g2436, DDY632_g2436 ) * temp_output_597_30_g2436 ) + ( tex2D( _GlossinessMap, temp_output_597_26_g2436, DDX631_g2436, DDY632_g2436 ) * temp_output_597_28_g2436 ) + ( tex2D( _GlossinessMap, temp_output_597_27_g2436, DDX631_g2436, DDY632_g2436 ) * temp_output_597_29_g2436 ) );
					float4 break31_g2436 = Output_2D293_g2436;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g2409 = break31_g2436.a;
					#else
					float staticSwitch1004_g2409 = tex2D( _GlossinessMap, uv_GlossinessMap64_g2409 ).a;
					#endif
					float saferPower804_g2409 = abs( staticSwitch1004_g2409 );
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g2409 = ( 1.0 - pow( saferPower804_g2409 , 3.0 ) );
					#else
					float staticSwitch845_g2409 = _Glossiness;
					#endif
					float3 temp_output_3_0_g2451 = ddx( NormalWS );
					float dotResult5_g2451 = dot( temp_output_3_0_g2451 , temp_output_3_0_g2451 );
					float3 temp_output_4_0_g2451 = ddy( NormalWS );
					float dotResult6_g2451 = dot( temp_output_4_0_g2451 , temp_output_4_0_g2451 );
					#ifdef _USEGEOMETRICANTIALIASING_ON
					float staticSwitch824_g2409 = min( staticSwitch845_g2409 , ( 1.0 - pow( saturate( max( dotResult5_g2451 , dotResult6_g2451 ) ) , 0.333 ) ) );
					#else
					float staticSwitch824_g2409 = staticSwitch845_g2409;
					#endif
					
					float White38_g2409 = 1.0;
					float4 temp_cast_1 = (White38_g2409).xxxx;
					float localBicubicPrepare2_g2411 = ( 0.0 );
					float2 uv3_Lightmap0 = IN.ase_texcoord5.zw * _Lightmap0_ST.xy + _Lightmap0_ST.zw;
					float2 Input_UV100_g2411 = uv3_Lightmap0;
					float2 UV2_g2411 = Input_UV100_g2411;
					float4 TexelSize2_g2411 = _Lightmap0_TexelSize;
					float2 UV02_g2411 = float2( 0,0 );
					float2 UV12_g2411 = float2( 0,0 );
					float2 UV22_g2411 = float2( 0,0 );
					float2 UV32_g2411 = float2( 0,0 );
					float W02_g2411 = 0;
					float W12_g2411 = 0;
					{
					{
					 UV2_g2411 = UV2_g2411 * TexelSize2_g2411.zw - 0.5;
					    float2 f = frac( UV2_g2411 );
					    UV2_g2411 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g2411.x - 0.5, UV2_g2411.x + 1.5, UV2_g2411.y - 0.5, UV2_g2411.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g2411.xyxy;
					    UV02_g2411 = off.xz;
					    UV12_g2411 = off.yz;
					    UV22_g2411 = off.xw;
					    UV32_g2411 = off.yw;
					    W02_g2411 = s.x / ( s.x + s.y );
					 W12_g2411 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g2411 = lerp( tex2D( _Lightmap0, UV32_g2411 ) , tex2D( _Lightmap0, UV22_g2411 ) , W02_g2411);
					float4 lerpResult45_g2411 = lerp( tex2D( _Lightmap0, UV12_g2411 ) , tex2D( _Lightmap0, UV02_g2411 ) , W02_g2411);
					float4 lerpResult44_g2411 = lerp( lerpResult46_g2411 , lerpResult45_g2411 , W12_g2411);
					float4 Output_2D131_g2411 = lerpResult44_g2411;
					float4 Lightmap_0925_g2409 = Output_2D131_g2411;
					float localBicubicPrepare2_g2413 = ( 0.0 );
					float2 uv3_Lightmap1 = IN.ase_texcoord5.zw * _Lightmap1_ST.xy + _Lightmap1_ST.zw;
					float2 Input_UV100_g2413 = uv3_Lightmap1;
					float2 UV2_g2413 = Input_UV100_g2413;
					float4 TexelSize2_g2413 = _Lightmap1_TexelSize;
					float2 UV02_g2413 = float2( 0,0 );
					float2 UV12_g2413 = float2( 0,0 );
					float2 UV22_g2413 = float2( 0,0 );
					float2 UV32_g2413 = float2( 0,0 );
					float W02_g2413 = 0;
					float W12_g2413 = 0;
					{
					{
					 UV2_g2413 = UV2_g2413 * TexelSize2_g2413.zw - 0.5;
					    float2 f = frac( UV2_g2413 );
					    UV2_g2413 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g2413.x - 0.5, UV2_g2413.x + 1.5, UV2_g2413.y - 0.5, UV2_g2413.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g2413.xyxy;
					    UV02_g2413 = off.xz;
					    UV12_g2413 = off.yz;
					    UV22_g2413 = off.xw;
					    UV32_g2413 = off.yw;
					    W02_g2413 = s.x / ( s.x + s.y );
					 W12_g2413 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g2413 = lerp( tex2D( _Lightmap1, UV32_g2413 ) , tex2D( _Lightmap1, UV22_g2413 ) , W02_g2413);
					float4 lerpResult45_g2413 = lerp( tex2D( _Lightmap1, UV12_g2413 ) , tex2D( _Lightmap1, UV02_g2413 ) , W02_g2413);
					float4 lerpResult44_g2413 = lerp( lerpResult46_g2413 , lerpResult45_g2413 , W12_g2413);
					float4 Output_2D131_g2413 = lerpResult44_g2413;
					float4 Lightmap_1956_g2409 = Output_2D131_g2413;
					float4 lerpResult442_g2409 = lerp( Lightmap_0925_g2409 , Lightmap_1956_g2409 , _LightmapLerp);
					float4 Lightmap_Lerp932_g2409 = lerpResult442_g2409;
					float3 appendResult139_g2424 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g2424 = normalize( Normal_Map700_g2409 );
					float3 Normal_Map318_g2424 = normalizeResult326_g2424;
					float dotResult121_g2424 = dot( appendResult139_g2424 , Normal_Map318_g2424 );
					float localStochasticTiling2_g2420 = ( 0.0 );
					float2 uv3_RNMX0 = IN.ase_texcoord5.zw * _RNMX0_ST.xy + _RNMX0_ST.zw;
					float2 UV2_g2420 = uv3_RNMX0;
					float4 TexelSize2_g2420 = _RNMX0_TexelSize;
					float4 Offsets2_g2420 = float4( 0,0,0,0 );
					float2 Weights2_g2420 = float2( 0,0 );
					{
					UV2_g2420 = UV2_g2420 * TexelSize2_g2420.zw - 0.5;
					float2 f = frac( UV2_g2420 );
					UV2_g2420 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g2420.x - 0.5, UV2_g2420.x + 1.5, UV2_g2420.y - 0.5, UV2_g2420.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g2420 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g2420.xyxy;
					Weights2_g2420 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g2419 = Offsets2_g2420;
					float4 Input_FetchOffsets197_g2423 = temp_output_1_34_g2419;
					float2 temp_output_1_54_g2419 = Weights2_g2420;
					float2 Input_FetchWeights200_g2423 = temp_output_1_54_g2419;
					float2 break187_g2423 = Input_FetchWeights200_g2423;
					float4 lerpResult181_g2423 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g2423).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g2423).xw ) , break187_g2423.x);
					float4 lerpResult182_g2423 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g2423).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g2423).xz ) , break187_g2423.x);
					float4 lerpResult176_g2423 = lerp( lerpResult181_g2423 , lerpResult182_g2423 , break187_g2423.y);
					float4 Output_Fetch2D202_g2423 = lerpResult176_g2423;
					float3 appendResult146_g2424 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g2424 = dot( appendResult146_g2424 , Normal_Map318_g2424 );
					float4 Input_FetchOffsets197_g2421 = temp_output_1_34_g2419;
					float2 Input_FetchWeights200_g2421 = temp_output_1_54_g2419;
					float2 break187_g2421 = Input_FetchWeights200_g2421;
					float4 lerpResult181_g2421 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g2421).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g2421).xw ) , break187_g2421.x);
					float4 lerpResult182_g2421 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g2421).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g2421).xz ) , break187_g2421.x);
					float4 lerpResult176_g2421 = lerp( lerpResult181_g2421 , lerpResult182_g2421 , break187_g2421.y);
					float4 Output_Fetch2D202_g2421 = lerpResult176_g2421;
					float3 appendResult149_g2424 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g2424 = dot( appendResult149_g2424 , Normal_Map318_g2424 );
					float4 Input_FetchOffsets197_g2422 = temp_output_1_34_g2419;
					float2 Input_FetchWeights200_g2422 = temp_output_1_54_g2419;
					float2 break187_g2422 = Input_FetchWeights200_g2422;
					float4 lerpResult181_g2422 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g2422).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g2422).xw ) , break187_g2422.x);
					float4 lerpResult182_g2422 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g2422).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g2422).xz ) , break187_g2422.x);
					float4 lerpResult176_g2422 = lerp( lerpResult181_g2422 , lerpResult182_g2422 , break187_g2422.y);
					float4 Output_Fetch2D202_g2422 = lerpResult176_g2422;
					float4 RNM_0926_g2409 = ( ( ( saturate( dotResult121_g2424 ) * ( Output_Fetch2D202_g2423 * 0.8 ) ) + ( saturate( dotResult122_g2424 ) * ( Output_Fetch2D202_g2421 * 0.8 ) ) ) + ( saturate( dotResult120_g2424 ) * ( Output_Fetch2D202_g2422 * 0.8 ) ) );
					float3 appendResult139_g2425 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g2425 = normalize( Normal_Map700_g2409 );
					float3 Normal_Map318_g2425 = normalizeResult326_g2425;
					float dotResult121_g2425 = dot( appendResult139_g2425 , Normal_Map318_g2425 );
					float localStochasticTiling2_g2415 = ( 0.0 );
					float2 uv3_RNMX1 = IN.ase_texcoord5.zw * _RNMX1_ST.xy + _RNMX1_ST.zw;
					float2 UV2_g2415 = uv3_RNMX1;
					float4 TexelSize2_g2415 = _RNMX1_TexelSize;
					float4 Offsets2_g2415 = float4( 0,0,0,0 );
					float2 Weights2_g2415 = float2( 0,0 );
					{
					UV2_g2415 = UV2_g2415 * TexelSize2_g2415.zw - 0.5;
					float2 f = frac( UV2_g2415 );
					UV2_g2415 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g2415.x - 0.5, UV2_g2415.x + 1.5, UV2_g2415.y - 0.5, UV2_g2415.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g2415 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g2415.xyxy;
					Weights2_g2415 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g2414 = Offsets2_g2415;
					float4 Input_FetchOffsets197_g2418 = temp_output_1_34_g2414;
					float2 temp_output_1_54_g2414 = Weights2_g2415;
					float2 Input_FetchWeights200_g2418 = temp_output_1_54_g2414;
					float2 break187_g2418 = Input_FetchWeights200_g2418;
					float4 lerpResult181_g2418 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g2418).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g2418).xw ) , break187_g2418.x);
					float4 lerpResult182_g2418 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g2418).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g2418).xz ) , break187_g2418.x);
					float4 lerpResult176_g2418 = lerp( lerpResult181_g2418 , lerpResult182_g2418 , break187_g2418.y);
					float4 Output_Fetch2D202_g2418 = lerpResult176_g2418;
					float3 appendResult146_g2425 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g2425 = dot( appendResult146_g2425 , Normal_Map318_g2425 );
					float4 Input_FetchOffsets197_g2416 = temp_output_1_34_g2414;
					float2 Input_FetchWeights200_g2416 = temp_output_1_54_g2414;
					float2 break187_g2416 = Input_FetchWeights200_g2416;
					float4 lerpResult181_g2416 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g2416).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g2416).xw ) , break187_g2416.x);
					float4 lerpResult182_g2416 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g2416).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g2416).xz ) , break187_g2416.x);
					float4 lerpResult176_g2416 = lerp( lerpResult181_g2416 , lerpResult182_g2416 , break187_g2416.y);
					float4 Output_Fetch2D202_g2416 = lerpResult176_g2416;
					float3 appendResult149_g2425 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g2425 = dot( appendResult149_g2425 , Normal_Map318_g2425 );
					float4 Input_FetchOffsets197_g2417 = temp_output_1_34_g2414;
					float2 Input_FetchWeights200_g2417 = temp_output_1_54_g2414;
					float2 break187_g2417 = Input_FetchWeights200_g2417;
					float4 lerpResult181_g2417 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g2417).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g2417).xw ) , break187_g2417.x);
					float4 lerpResult182_g2417 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g2417).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g2417).xz ) , break187_g2417.x);
					float4 lerpResult176_g2417 = lerp( lerpResult181_g2417 , lerpResult182_g2417 , break187_g2417.y);
					float4 Output_Fetch2D202_g2417 = lerpResult176_g2417;
					float4 RNM_1927_g2409 = ( ( ( saturate( dotResult121_g2425 ) * ( Output_Fetch2D202_g2418 * 0.8 ) ) + ( saturate( dotResult122_g2425 ) * ( Output_Fetch2D202_g2416 * 0.8 ) ) ) + ( saturate( dotResult120_g2425 ) * ( Output_Fetch2D202_g2417 * 0.8 ) ) );
					float4 lerpResult953_g2409 = lerp( RNM_0926_g2409 , RNM_1927_g2409 , Metallic699_g2409);
					float4 RNM_Lerp950_g2409 = lerpResult953_g2409;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g2409 = temp_cast_1;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g2409 = Lightmap_0925_g2409;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g2409 = Lightmap_Lerp932_g2409;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g2409 = RNM_0926_g2409;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g2409 = RNM_Lerp950_g2409;
					#else
					float4 staticSwitch1014_g2409 = temp_cast_1;
					#endif
					float4 Lightmap46_g2409 = staticSwitch1014_g2409;
					float dotResult835_g2409 = dot( Lightmap46_g2409 , float4( float3( 0.299, 0.587, 0.114 ) , 0.0 ) );
					float saferPower606_g2409 = abs( dotResult835_g2409 );
					#ifdef _LIGHTMAPOCCLUSIONENABLED_ON
					float staticSwitch1018_g2409 = pow( saferPower606_g2409 , _OcclusionPower );
					#else
					float staticSwitch1018_g2409 = White38_g2409;
					#endif
					#if defined( _LIGHTMAPMODE_DISABLED )
					float staticSwitch1016_g2409 = White38_g2409;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float staticSwitch1016_g2409 = staticSwitch1018_g2409;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float staticSwitch1016_g2409 = staticSwitch1018_g2409;
					#elif defined( _LIGHTMAPMODE_RNM )
					float staticSwitch1016_g2409 = staticSwitch1018_g2409;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float staticSwitch1016_g2409 = staticSwitch1018_g2409;
					#else
					float staticSwitch1016_g2409 = White38_g2409;
					#endif
					
					float4 temp_output_614_0_g2409 = ( Albedo6_g2409 * Lightmap46_g2409 );
					float4 temp_cast_3 = 0;
					float2 uv_EmissionMap81_g2409 = IN.ase_texcoord5.xy;
					float2 uv_EmissionMap = IN.ase_texcoord5.xy * _EmissionMap_ST.xy + _EmissionMap_ST.zw;
					float2 temp_output_5_0_g2426 = uv_EmissionMap;
					float2 UV633_g2426 = temp_output_5_0_g2426;
					float2 UV100_g2427 = UV633_g2426;
					float2 temp_output_51_0_g2427 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g2427 * float2( 3.464,3.464 ) ) );
					float2 break55_g2427 = frac( temp_output_51_0_g2427 );
					float temp_output_56_0_g2427 = ( ( 1.0 - break55_g2427.x ) - break55_g2427.y );
					float2 temp_output_52_0_g2427 = floor( temp_output_51_0_g2427 );
					float2 temp_output_125_0_g2427 = ( temp_output_52_0_g2427 + float2( 1,1 ) );
					float2 ifLocalVar87_g2427 = 0;
					if( temp_output_56_0_g2427 > 0.0 )
					ifLocalVar87_g2427 = temp_output_52_0_g2427;
					else if( temp_output_56_0_g2427 == 0.0 )
					ifLocalVar87_g2427 = temp_output_125_0_g2427;
					else if( temp_output_56_0_g2427 < 0.0 )
					ifLocalVar87_g2427 = temp_output_125_0_g2427;
					float3 temp_output_7_0_g2428 = frac( ( (ifLocalVar87_g2427).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2428 = dot( temp_output_7_0_g2428 , ( (temp_output_7_0_g2428).yzx + 33.33 ) );
					float3 temp_output_12_0_g2428 = ( temp_output_7_0_g2428 + dotResult8_g2428 );
					float2 temp_output_597_0_g2426 = ( UV100_g2427 + frac( ( ( (temp_output_12_0_g2428).xx + (temp_output_12_0_g2428).yz ) * (temp_output_12_0_g2428).zy ) ) );
					float2 DDX631_g2426 = ddx( temp_output_5_0_g2426 );
					float2 DDY632_g2426 = ddy( temp_output_5_0_g2426 );
					float temp_output_65_0_g2427 = ( 0.0 - temp_output_56_0_g2427 );
					float ifLocalVar59_g2427 = 0;
					if( temp_output_56_0_g2427 <= 0.0 )
					ifLocalVar59_g2427 = temp_output_65_0_g2427;
					else
					ifLocalVar59_g2427 = temp_output_56_0_g2427;
					float temp_output_597_30_g2426 = ifLocalVar59_g2427;
					float2 temp_output_90_0_g2427 = ( temp_output_52_0_g2427 + float2( 0,1 ) );
					float2 temp_output_123_0_g2427 = ( temp_output_52_0_g2427 + float2( 1,0 ) );
					float2 ifLocalVar88_g2427 = 0;
					if( temp_output_56_0_g2427 > 0.0 )
					ifLocalVar88_g2427 = temp_output_90_0_g2427;
					else if( temp_output_56_0_g2427 == 0.0 )
					ifLocalVar88_g2427 = temp_output_123_0_g2427;
					else if( temp_output_56_0_g2427 < 0.0 )
					ifLocalVar88_g2427 = temp_output_123_0_g2427;
					float3 temp_output_7_0_g2429 = frac( ( (ifLocalVar88_g2427).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2429 = dot( temp_output_7_0_g2429 , ( (temp_output_7_0_g2429).yzx + 33.33 ) );
					float3 temp_output_12_0_g2429 = ( temp_output_7_0_g2429 + dotResult8_g2429 );
					float2 temp_output_597_26_g2426 = ( UV100_g2427 + frac( ( ( (temp_output_12_0_g2429).xx + (temp_output_12_0_g2429).yz ) * (temp_output_12_0_g2429).zy ) ) );
					float temp_output_66_0_g2427 = ( 1.0 - break55_g2427.y );
					float ifLocalVar60_g2427 = 0;
					if( temp_output_56_0_g2427 <= 0.0 )
					ifLocalVar60_g2427 = temp_output_66_0_g2427;
					else
					ifLocalVar60_g2427 = break55_g2427.y;
					float temp_output_597_28_g2426 = ifLocalVar60_g2427;
					float2 ifLocalVar89_g2427 = 0;
					if( temp_output_56_0_g2427 > 0.0 )
					ifLocalVar89_g2427 = temp_output_123_0_g2427;
					else if( temp_output_56_0_g2427 == 0.0 )
					ifLocalVar89_g2427 = temp_output_90_0_g2427;
					else if( temp_output_56_0_g2427 < 0.0 )
					ifLocalVar89_g2427 = temp_output_90_0_g2427;
					float3 temp_output_7_0_g2430 = frac( ( (ifLocalVar89_g2427).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2430 = dot( temp_output_7_0_g2430 , ( (temp_output_7_0_g2430).yzx + 33.33 ) );
					float3 temp_output_12_0_g2430 = ( temp_output_7_0_g2430 + dotResult8_g2430 );
					float2 temp_output_597_27_g2426 = ( UV100_g2427 + frac( ( ( (temp_output_12_0_g2430).xx + (temp_output_12_0_g2430).yz ) * (temp_output_12_0_g2430).zy ) ) );
					float temp_output_67_0_g2427 = ( 1.0 - break55_g2427.x );
					float ifLocalVar61_g2427 = 0;
					if( temp_output_56_0_g2427 <= 0.0 )
					ifLocalVar61_g2427 = temp_output_67_0_g2427;
					else
					ifLocalVar61_g2427 = break55_g2427.x;
					float temp_output_597_29_g2426 = ifLocalVar61_g2427;
					float4 Output_2D293_g2426 = ( ( tex2D( _EmissionMap, temp_output_597_0_g2426, DDX631_g2426, DDY632_g2426 ) * temp_output_597_30_g2426 ) + ( tex2D( _EmissionMap, temp_output_597_26_g2426, DDX631_g2426, DDY632_g2426 ) * temp_output_597_28_g2426 ) + ( tex2D( _EmissionMap, temp_output_597_27_g2426, DDX631_g2426, DDY632_g2426 ) * temp_output_597_29_g2426 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g2409 = Output_2D293_g2426;
					#else
					float4 staticSwitch1006_g2409 = tex2D( _EmissionMap, uv_EmissionMap81_g2409 );
					#endif
					#ifdef _EMISSIONENABLED_ON
					float4 staticSwitch1017_g2409 = ( _EmissionColor + staticSwitch1006_g2409 );
					#else
					float4 staticSwitch1017_g2409 = temp_cast_3;
					#endif
					float4 Emission86_g2409 = staticSwitch1017_g2409;
					float4 temp_output_690_0_g2409 = ( Emission86_g2409 + temp_output_614_0_g2409 );
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1019_g2409 = ( temp_output_614_0_g2409 * Emission86_g2409 );
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1019_g2409 = temp_output_690_0_g2409;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1019_g2409 = temp_output_690_0_g2409;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1019_g2409 = temp_output_690_0_g2409;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1019_g2409 = temp_output_690_0_g2409;
					#else
					float4 staticSwitch1019_g2409 = ( temp_output_614_0_g2409 * Emission86_g2409 );
					#endif
					

					o.Albedo = Albedo6_g2409.rgb;
					o.Normal = Normal_Map700_g2409;

					half3 Specular = half3( 0, 0, 0 );
					half Metallic = Metallic699_g2409;
					half Smoothness = staticSwitch824_g2409;
					half Occlusion = staticSwitch1016_g2409;

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

					o.Emission = staticSwitch1019_g2409.rgb;
					o.Alpha = temp_output_976_0_g2409.a;
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
				#define ASE_RECEIVE_SHADOWS
				#pragma multi_compile _ LOD_FADE_CROSSFADE
				#define ASE_FOG
				#pragma multi_compile_instancing
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
				#pragma shader_feature_local _STOCHASTICENABLED_ON
				#pragma shader_feature_local _LIGHTMAPMODE_DISABLED _LIGHTMAPMODE_SIMPLE _LIGHTMAPMODE_SIMPLELERP _LIGHTMAPMODE_RNM _LIGHTMAPMODE_RNMLERP
				#pragma shader_feature_local_fragment _BUMPMAP
				#pragma shader_feature_local_fragment _METALLICMAP
				#pragma shader_feature_local _EMISSIONENABLED_ON


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
				uniform float _CATEGORYSPACESTOCHASTIC;
				uniform float _CATEGORYSTOCHASTIC;
				uniform float _CATEGORYLIGHTMAPPING;
				uniform float _CATEGORYSPACELIGHTMAPPING;
				uniform float4 _Color;
				uniform sampler2D _MainTex;
				uniform float4 _MainTex_ST;
				uniform sampler2D _Lightmap0;
				uniform float4 _Lightmap0_ST;
				float4 _Lightmap0_TexelSize;
				uniform sampler2D _Lightmap1;
				uniform float4 _Lightmap1_ST;
				float4 _Lightmap1_TexelSize;
				uniform float _LightmapLerp;
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
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				uniform float4 _MetallicMap_ST;
				uniform float4 _EmissionColor;
				uniform sampler2D _EmissionMap;
				uniform float4 _EmissionMap_ST;


				
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
					float3 vertexValue = ( v.normal * -0.001 );
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

					float2 uv_MainTex907_g2409 = IN.ase_texcoord2.xy;
					float2 uv_MainTex = IN.ase_texcoord2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					float2 temp_output_5_0_g2446 = uv_MainTex;
					float2 UV633_g2446 = temp_output_5_0_g2446;
					float2 UV100_g2447 = UV633_g2446;
					float2 temp_output_51_0_g2447 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g2447 * float2( 3.464,3.464 ) ) );
					float2 break55_g2447 = frac( temp_output_51_0_g2447 );
					float temp_output_56_0_g2447 = ( ( 1.0 - break55_g2447.x ) - break55_g2447.y );
					float2 temp_output_52_0_g2447 = floor( temp_output_51_0_g2447 );
					float2 temp_output_125_0_g2447 = ( temp_output_52_0_g2447 + float2( 1,1 ) );
					float2 ifLocalVar87_g2447 = 0;
					if( temp_output_56_0_g2447 > 0.0 )
					ifLocalVar87_g2447 = temp_output_52_0_g2447;
					else if( temp_output_56_0_g2447 == 0.0 )
					ifLocalVar87_g2447 = temp_output_125_0_g2447;
					else if( temp_output_56_0_g2447 < 0.0 )
					ifLocalVar87_g2447 = temp_output_125_0_g2447;
					float3 temp_output_7_0_g2448 = frac( ( (ifLocalVar87_g2447).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2448 = dot( temp_output_7_0_g2448 , ( (temp_output_7_0_g2448).yzx + 33.33 ) );
					float3 temp_output_12_0_g2448 = ( temp_output_7_0_g2448 + dotResult8_g2448 );
					float2 temp_output_597_0_g2446 = ( UV100_g2447 + frac( ( ( (temp_output_12_0_g2448).xx + (temp_output_12_0_g2448).yz ) * (temp_output_12_0_g2448).zy ) ) );
					float2 DDX631_g2446 = ddx( temp_output_5_0_g2446 );
					float2 DDY632_g2446 = ddy( temp_output_5_0_g2446 );
					float temp_output_65_0_g2447 = ( 0.0 - temp_output_56_0_g2447 );
					float ifLocalVar59_g2447 = 0;
					if( temp_output_56_0_g2447 <= 0.0 )
					ifLocalVar59_g2447 = temp_output_65_0_g2447;
					else
					ifLocalVar59_g2447 = temp_output_56_0_g2447;
					float temp_output_597_30_g2446 = ifLocalVar59_g2447;
					float2 temp_output_90_0_g2447 = ( temp_output_52_0_g2447 + float2( 0,1 ) );
					float2 temp_output_123_0_g2447 = ( temp_output_52_0_g2447 + float2( 1,0 ) );
					float2 ifLocalVar88_g2447 = 0;
					if( temp_output_56_0_g2447 > 0.0 )
					ifLocalVar88_g2447 = temp_output_90_0_g2447;
					else if( temp_output_56_0_g2447 == 0.0 )
					ifLocalVar88_g2447 = temp_output_123_0_g2447;
					else if( temp_output_56_0_g2447 < 0.0 )
					ifLocalVar88_g2447 = temp_output_123_0_g2447;
					float3 temp_output_7_0_g2449 = frac( ( (ifLocalVar88_g2447).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2449 = dot( temp_output_7_0_g2449 , ( (temp_output_7_0_g2449).yzx + 33.33 ) );
					float3 temp_output_12_0_g2449 = ( temp_output_7_0_g2449 + dotResult8_g2449 );
					float2 temp_output_597_26_g2446 = ( UV100_g2447 + frac( ( ( (temp_output_12_0_g2449).xx + (temp_output_12_0_g2449).yz ) * (temp_output_12_0_g2449).zy ) ) );
					float temp_output_66_0_g2447 = ( 1.0 - break55_g2447.y );
					float ifLocalVar60_g2447 = 0;
					if( temp_output_56_0_g2447 <= 0.0 )
					ifLocalVar60_g2447 = temp_output_66_0_g2447;
					else
					ifLocalVar60_g2447 = break55_g2447.y;
					float temp_output_597_28_g2446 = ifLocalVar60_g2447;
					float2 ifLocalVar89_g2447 = 0;
					if( temp_output_56_0_g2447 > 0.0 )
					ifLocalVar89_g2447 = temp_output_123_0_g2447;
					else if( temp_output_56_0_g2447 == 0.0 )
					ifLocalVar89_g2447 = temp_output_90_0_g2447;
					else if( temp_output_56_0_g2447 < 0.0 )
					ifLocalVar89_g2447 = temp_output_90_0_g2447;
					float3 temp_output_7_0_g2450 = frac( ( (ifLocalVar89_g2447).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2450 = dot( temp_output_7_0_g2450 , ( (temp_output_7_0_g2450).yzx + 33.33 ) );
					float3 temp_output_12_0_g2450 = ( temp_output_7_0_g2450 + dotResult8_g2450 );
					float2 temp_output_597_27_g2446 = ( UV100_g2447 + frac( ( ( (temp_output_12_0_g2450).xx + (temp_output_12_0_g2450).yz ) * (temp_output_12_0_g2450).zy ) ) );
					float temp_output_67_0_g2447 = ( 1.0 - break55_g2447.x );
					float ifLocalVar61_g2447 = 0;
					if( temp_output_56_0_g2447 <= 0.0 )
					ifLocalVar61_g2447 = temp_output_67_0_g2447;
					else
					ifLocalVar61_g2447 = break55_g2447.x;
					float temp_output_597_29_g2446 = ifLocalVar61_g2447;
					float4 Output_2D293_g2446 = ( ( tex2D( _MainTex, temp_output_597_0_g2446, DDX631_g2446, DDY632_g2446 ) * temp_output_597_30_g2446 ) + ( tex2D( _MainTex, temp_output_597_26_g2446, DDX631_g2446, DDY632_g2446 ) * temp_output_597_28_g2446 ) + ( tex2D( _MainTex, temp_output_597_27_g2446, DDX631_g2446, DDY632_g2446 ) * temp_output_597_29_g2446 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g2409 = Output_2D293_g2446;
					#else
					float4 staticSwitch1001_g2409 = tex2D( _MainTex, uv_MainTex907_g2409 );
					#endif
					float4 temp_output_976_0_g2409 = ( _Color * staticSwitch1001_g2409 );
					float4 Albedo6_g2409 = temp_output_976_0_g2409;
					
					float White38_g2409 = 1.0;
					float4 temp_cast_1 = (White38_g2409).xxxx;
					float localBicubicPrepare2_g2411 = ( 0.0 );
					float2 uv3_Lightmap0 = IN.ase_texcoord2.zw * _Lightmap0_ST.xy + _Lightmap0_ST.zw;
					float2 Input_UV100_g2411 = uv3_Lightmap0;
					float2 UV2_g2411 = Input_UV100_g2411;
					float4 TexelSize2_g2411 = _Lightmap0_TexelSize;
					float2 UV02_g2411 = float2( 0,0 );
					float2 UV12_g2411 = float2( 0,0 );
					float2 UV22_g2411 = float2( 0,0 );
					float2 UV32_g2411 = float2( 0,0 );
					float W02_g2411 = 0;
					float W12_g2411 = 0;
					{
					{
					 UV2_g2411 = UV2_g2411 * TexelSize2_g2411.zw - 0.5;
					    float2 f = frac( UV2_g2411 );
					    UV2_g2411 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g2411.x - 0.5, UV2_g2411.x + 1.5, UV2_g2411.y - 0.5, UV2_g2411.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g2411.xyxy;
					    UV02_g2411 = off.xz;
					    UV12_g2411 = off.yz;
					    UV22_g2411 = off.xw;
					    UV32_g2411 = off.yw;
					    W02_g2411 = s.x / ( s.x + s.y );
					 W12_g2411 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g2411 = lerp( tex2D( _Lightmap0, UV32_g2411 ) , tex2D( _Lightmap0, UV22_g2411 ) , W02_g2411);
					float4 lerpResult45_g2411 = lerp( tex2D( _Lightmap0, UV12_g2411 ) , tex2D( _Lightmap0, UV02_g2411 ) , W02_g2411);
					float4 lerpResult44_g2411 = lerp( lerpResult46_g2411 , lerpResult45_g2411 , W12_g2411);
					float4 Output_2D131_g2411 = lerpResult44_g2411;
					float4 Lightmap_0925_g2409 = Output_2D131_g2411;
					float localBicubicPrepare2_g2413 = ( 0.0 );
					float2 uv3_Lightmap1 = IN.ase_texcoord2.zw * _Lightmap1_ST.xy + _Lightmap1_ST.zw;
					float2 Input_UV100_g2413 = uv3_Lightmap1;
					float2 UV2_g2413 = Input_UV100_g2413;
					float4 TexelSize2_g2413 = _Lightmap1_TexelSize;
					float2 UV02_g2413 = float2( 0,0 );
					float2 UV12_g2413 = float2( 0,0 );
					float2 UV22_g2413 = float2( 0,0 );
					float2 UV32_g2413 = float2( 0,0 );
					float W02_g2413 = 0;
					float W12_g2413 = 0;
					{
					{
					 UV2_g2413 = UV2_g2413 * TexelSize2_g2413.zw - 0.5;
					    float2 f = frac( UV2_g2413 );
					    UV2_g2413 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g2413.x - 0.5, UV2_g2413.x + 1.5, UV2_g2413.y - 0.5, UV2_g2413.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g2413.xyxy;
					    UV02_g2413 = off.xz;
					    UV12_g2413 = off.yz;
					    UV22_g2413 = off.xw;
					    UV32_g2413 = off.yw;
					    W02_g2413 = s.x / ( s.x + s.y );
					 W12_g2413 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g2413 = lerp( tex2D( _Lightmap1, UV32_g2413 ) , tex2D( _Lightmap1, UV22_g2413 ) , W02_g2413);
					float4 lerpResult45_g2413 = lerp( tex2D( _Lightmap1, UV12_g2413 ) , tex2D( _Lightmap1, UV02_g2413 ) , W02_g2413);
					float4 lerpResult44_g2413 = lerp( lerpResult46_g2413 , lerpResult45_g2413 , W12_g2413);
					float4 Output_2D131_g2413 = lerpResult44_g2413;
					float4 Lightmap_1956_g2409 = Output_2D131_g2413;
					float4 lerpResult442_g2409 = lerp( Lightmap_0925_g2409 , Lightmap_1956_g2409 , _LightmapLerp);
					float4 Lightmap_Lerp932_g2409 = lerpResult442_g2409;
					float3 appendResult139_g2424 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float2 uv_BumpMap830_g2409 = IN.ase_texcoord2.xy;
					float2 uv_BumpMap = IN.ase_texcoord2.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					float2 temp_output_5_0_g2441 = uv_BumpMap;
					float2 UV633_g2441 = temp_output_5_0_g2441;
					float2 UV100_g2442 = UV633_g2441;
					float2 temp_output_51_0_g2442 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g2442 * float2( 3.464,3.464 ) ) );
					float2 break55_g2442 = frac( temp_output_51_0_g2442 );
					float temp_output_56_0_g2442 = ( ( 1.0 - break55_g2442.x ) - break55_g2442.y );
					float2 temp_output_52_0_g2442 = floor( temp_output_51_0_g2442 );
					float2 temp_output_125_0_g2442 = ( temp_output_52_0_g2442 + float2( 1,1 ) );
					float2 ifLocalVar87_g2442 = 0;
					if( temp_output_56_0_g2442 > 0.0 )
					ifLocalVar87_g2442 = temp_output_52_0_g2442;
					else if( temp_output_56_0_g2442 == 0.0 )
					ifLocalVar87_g2442 = temp_output_125_0_g2442;
					else if( temp_output_56_0_g2442 < 0.0 )
					ifLocalVar87_g2442 = temp_output_125_0_g2442;
					float3 temp_output_7_0_g2443 = frac( ( (ifLocalVar87_g2442).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2443 = dot( temp_output_7_0_g2443 , ( (temp_output_7_0_g2443).yzx + 33.33 ) );
					float3 temp_output_12_0_g2443 = ( temp_output_7_0_g2443 + dotResult8_g2443 );
					float2 temp_output_597_0_g2441 = ( UV100_g2442 + frac( ( ( (temp_output_12_0_g2443).xx + (temp_output_12_0_g2443).yz ) * (temp_output_12_0_g2443).zy ) ) );
					float2 DDX631_g2441 = ddx( temp_output_5_0_g2441 );
					float2 DDY632_g2441 = ddy( temp_output_5_0_g2441 );
					float Input_Scale617_g2441 = _NormalScale;
					float temp_output_65_0_g2442 = ( 0.0 - temp_output_56_0_g2442 );
					float ifLocalVar59_g2442 = 0;
					if( temp_output_56_0_g2442 <= 0.0 )
					ifLocalVar59_g2442 = temp_output_65_0_g2442;
					else
					ifLocalVar59_g2442 = temp_output_56_0_g2442;
					float temp_output_597_30_g2441 = ifLocalVar59_g2442;
					float2 temp_output_90_0_g2442 = ( temp_output_52_0_g2442 + float2( 0,1 ) );
					float2 temp_output_123_0_g2442 = ( temp_output_52_0_g2442 + float2( 1,0 ) );
					float2 ifLocalVar88_g2442 = 0;
					if( temp_output_56_0_g2442 > 0.0 )
					ifLocalVar88_g2442 = temp_output_90_0_g2442;
					else if( temp_output_56_0_g2442 == 0.0 )
					ifLocalVar88_g2442 = temp_output_123_0_g2442;
					else if( temp_output_56_0_g2442 < 0.0 )
					ifLocalVar88_g2442 = temp_output_123_0_g2442;
					float3 temp_output_7_0_g2444 = frac( ( (ifLocalVar88_g2442).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2444 = dot( temp_output_7_0_g2444 , ( (temp_output_7_0_g2444).yzx + 33.33 ) );
					float3 temp_output_12_0_g2444 = ( temp_output_7_0_g2444 + dotResult8_g2444 );
					float2 temp_output_597_26_g2441 = ( UV100_g2442 + frac( ( ( (temp_output_12_0_g2444).xx + (temp_output_12_0_g2444).yz ) * (temp_output_12_0_g2444).zy ) ) );
					float temp_output_66_0_g2442 = ( 1.0 - break55_g2442.y );
					float ifLocalVar60_g2442 = 0;
					if( temp_output_56_0_g2442 <= 0.0 )
					ifLocalVar60_g2442 = temp_output_66_0_g2442;
					else
					ifLocalVar60_g2442 = break55_g2442.y;
					float temp_output_597_28_g2441 = ifLocalVar60_g2442;
					float2 ifLocalVar89_g2442 = 0;
					if( temp_output_56_0_g2442 > 0.0 )
					ifLocalVar89_g2442 = temp_output_123_0_g2442;
					else if( temp_output_56_0_g2442 == 0.0 )
					ifLocalVar89_g2442 = temp_output_90_0_g2442;
					else if( temp_output_56_0_g2442 < 0.0 )
					ifLocalVar89_g2442 = temp_output_90_0_g2442;
					float3 temp_output_7_0_g2445 = frac( ( (ifLocalVar89_g2442).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2445 = dot( temp_output_7_0_g2445 , ( (temp_output_7_0_g2445).yzx + 33.33 ) );
					float3 temp_output_12_0_g2445 = ( temp_output_7_0_g2445 + dotResult8_g2445 );
					float2 temp_output_597_27_g2441 = ( UV100_g2442 + frac( ( ( (temp_output_12_0_g2445).xx + (temp_output_12_0_g2445).yz ) * (temp_output_12_0_g2445).zy ) ) );
					float temp_output_67_0_g2442 = ( 1.0 - break55_g2442.x );
					float ifLocalVar61_g2442 = 0;
					if( temp_output_56_0_g2442 <= 0.0 )
					ifLocalVar61_g2442 = temp_output_67_0_g2442;
					else
					ifLocalVar61_g2442 = break55_g2442.x;
					float temp_output_597_29_g2441 = ifLocalVar61_g2442;
					float3 Output_2D_Normal641_g2441 = ( ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_0_g2441, DDX631_g2441, DDY632_g2441 ), Input_Scale617_g2441 ) * temp_output_597_30_g2441 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_26_g2441, DDX631_g2441, DDY632_g2441 ), Input_Scale617_g2441 ) * temp_output_597_28_g2441 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_27_g2441, DDX631_g2441, DDY632_g2441 ), Input_Scale617_g2441 ) * float3( 0,0,0 ) * temp_output_597_29_g2441 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g2409 = Output_2D_Normal641_g2441;
					#else
					float3 staticSwitch1003_g2409 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap830_g2409 ), _NormalScale );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g2409 = staticSwitch1003_g2409;
					#else
					float3 staticSwitch980_g2409 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g2409 = staticSwitch980_g2409;
					float3 normalizeResult326_g2424 = normalize( Normal_Map700_g2409 );
					float3 Normal_Map318_g2424 = normalizeResult326_g2424;
					float dotResult121_g2424 = dot( appendResult139_g2424 , Normal_Map318_g2424 );
					float localStochasticTiling2_g2420 = ( 0.0 );
					float2 uv3_RNMX0 = IN.ase_texcoord2.zw * _RNMX0_ST.xy + _RNMX0_ST.zw;
					float2 UV2_g2420 = uv3_RNMX0;
					float4 TexelSize2_g2420 = _RNMX0_TexelSize;
					float4 Offsets2_g2420 = float4( 0,0,0,0 );
					float2 Weights2_g2420 = float2( 0,0 );
					{
					UV2_g2420 = UV2_g2420 * TexelSize2_g2420.zw - 0.5;
					float2 f = frac( UV2_g2420 );
					UV2_g2420 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g2420.x - 0.5, UV2_g2420.x + 1.5, UV2_g2420.y - 0.5, UV2_g2420.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g2420 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g2420.xyxy;
					Weights2_g2420 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g2419 = Offsets2_g2420;
					float4 Input_FetchOffsets197_g2423 = temp_output_1_34_g2419;
					float2 temp_output_1_54_g2419 = Weights2_g2420;
					float2 Input_FetchWeights200_g2423 = temp_output_1_54_g2419;
					float2 break187_g2423 = Input_FetchWeights200_g2423;
					float4 lerpResult181_g2423 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g2423).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g2423).xw ) , break187_g2423.x);
					float4 lerpResult182_g2423 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g2423).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g2423).xz ) , break187_g2423.x);
					float4 lerpResult176_g2423 = lerp( lerpResult181_g2423 , lerpResult182_g2423 , break187_g2423.y);
					float4 Output_Fetch2D202_g2423 = lerpResult176_g2423;
					float3 appendResult146_g2424 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g2424 = dot( appendResult146_g2424 , Normal_Map318_g2424 );
					float4 Input_FetchOffsets197_g2421 = temp_output_1_34_g2419;
					float2 Input_FetchWeights200_g2421 = temp_output_1_54_g2419;
					float2 break187_g2421 = Input_FetchWeights200_g2421;
					float4 lerpResult181_g2421 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g2421).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g2421).xw ) , break187_g2421.x);
					float4 lerpResult182_g2421 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g2421).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g2421).xz ) , break187_g2421.x);
					float4 lerpResult176_g2421 = lerp( lerpResult181_g2421 , lerpResult182_g2421 , break187_g2421.y);
					float4 Output_Fetch2D202_g2421 = lerpResult176_g2421;
					float3 appendResult149_g2424 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g2424 = dot( appendResult149_g2424 , Normal_Map318_g2424 );
					float4 Input_FetchOffsets197_g2422 = temp_output_1_34_g2419;
					float2 Input_FetchWeights200_g2422 = temp_output_1_54_g2419;
					float2 break187_g2422 = Input_FetchWeights200_g2422;
					float4 lerpResult181_g2422 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g2422).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g2422).xw ) , break187_g2422.x);
					float4 lerpResult182_g2422 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g2422).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g2422).xz ) , break187_g2422.x);
					float4 lerpResult176_g2422 = lerp( lerpResult181_g2422 , lerpResult182_g2422 , break187_g2422.y);
					float4 Output_Fetch2D202_g2422 = lerpResult176_g2422;
					float4 RNM_0926_g2409 = ( ( ( saturate( dotResult121_g2424 ) * ( Output_Fetch2D202_g2423 * 0.8 ) ) + ( saturate( dotResult122_g2424 ) * ( Output_Fetch2D202_g2421 * 0.8 ) ) ) + ( saturate( dotResult120_g2424 ) * ( Output_Fetch2D202_g2422 * 0.8 ) ) );
					float3 appendResult139_g2425 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g2425 = normalize( Normal_Map700_g2409 );
					float3 Normal_Map318_g2425 = normalizeResult326_g2425;
					float dotResult121_g2425 = dot( appendResult139_g2425 , Normal_Map318_g2425 );
					float localStochasticTiling2_g2415 = ( 0.0 );
					float2 uv3_RNMX1 = IN.ase_texcoord2.zw * _RNMX1_ST.xy + _RNMX1_ST.zw;
					float2 UV2_g2415 = uv3_RNMX1;
					float4 TexelSize2_g2415 = _RNMX1_TexelSize;
					float4 Offsets2_g2415 = float4( 0,0,0,0 );
					float2 Weights2_g2415 = float2( 0,0 );
					{
					UV2_g2415 = UV2_g2415 * TexelSize2_g2415.zw - 0.5;
					float2 f = frac( UV2_g2415 );
					UV2_g2415 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g2415.x - 0.5, UV2_g2415.x + 1.5, UV2_g2415.y - 0.5, UV2_g2415.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g2415 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g2415.xyxy;
					Weights2_g2415 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g2414 = Offsets2_g2415;
					float4 Input_FetchOffsets197_g2418 = temp_output_1_34_g2414;
					float2 temp_output_1_54_g2414 = Weights2_g2415;
					float2 Input_FetchWeights200_g2418 = temp_output_1_54_g2414;
					float2 break187_g2418 = Input_FetchWeights200_g2418;
					float4 lerpResult181_g2418 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g2418).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g2418).xw ) , break187_g2418.x);
					float4 lerpResult182_g2418 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g2418).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g2418).xz ) , break187_g2418.x);
					float4 lerpResult176_g2418 = lerp( lerpResult181_g2418 , lerpResult182_g2418 , break187_g2418.y);
					float4 Output_Fetch2D202_g2418 = lerpResult176_g2418;
					float3 appendResult146_g2425 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g2425 = dot( appendResult146_g2425 , Normal_Map318_g2425 );
					float4 Input_FetchOffsets197_g2416 = temp_output_1_34_g2414;
					float2 Input_FetchWeights200_g2416 = temp_output_1_54_g2414;
					float2 break187_g2416 = Input_FetchWeights200_g2416;
					float4 lerpResult181_g2416 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g2416).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g2416).xw ) , break187_g2416.x);
					float4 lerpResult182_g2416 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g2416).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g2416).xz ) , break187_g2416.x);
					float4 lerpResult176_g2416 = lerp( lerpResult181_g2416 , lerpResult182_g2416 , break187_g2416.y);
					float4 Output_Fetch2D202_g2416 = lerpResult176_g2416;
					float3 appendResult149_g2425 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g2425 = dot( appendResult149_g2425 , Normal_Map318_g2425 );
					float4 Input_FetchOffsets197_g2417 = temp_output_1_34_g2414;
					float2 Input_FetchWeights200_g2417 = temp_output_1_54_g2414;
					float2 break187_g2417 = Input_FetchWeights200_g2417;
					float4 lerpResult181_g2417 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g2417).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g2417).xw ) , break187_g2417.x);
					float4 lerpResult182_g2417 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g2417).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g2417).xz ) , break187_g2417.x);
					float4 lerpResult176_g2417 = lerp( lerpResult181_g2417 , lerpResult182_g2417 , break187_g2417.y);
					float4 Output_Fetch2D202_g2417 = lerpResult176_g2417;
					float4 RNM_1927_g2409 = ( ( ( saturate( dotResult121_g2425 ) * ( Output_Fetch2D202_g2418 * 0.8 ) ) + ( saturate( dotResult122_g2425 ) * ( Output_Fetch2D202_g2416 * 0.8 ) ) ) + ( saturate( dotResult120_g2425 ) * ( Output_Fetch2D202_g2417 * 0.8 ) ) );
					float2 uv_MetallicMap48_g2409 = IN.ase_texcoord2.xy;
					float2 uv_MetallicMap = IN.ase_texcoord2.xy * _MetallicMap_ST.xy + _MetallicMap_ST.zw;
					float2 temp_output_5_0_g2431 = uv_MetallicMap;
					float2 UV633_g2431 = temp_output_5_0_g2431;
					float2 UV100_g2432 = UV633_g2431;
					float2 temp_output_51_0_g2432 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g2432 * float2( 3.464,3.464 ) ) );
					float2 break55_g2432 = frac( temp_output_51_0_g2432 );
					float temp_output_56_0_g2432 = ( ( 1.0 - break55_g2432.x ) - break55_g2432.y );
					float2 temp_output_52_0_g2432 = floor( temp_output_51_0_g2432 );
					float2 temp_output_125_0_g2432 = ( temp_output_52_0_g2432 + float2( 1,1 ) );
					float2 ifLocalVar87_g2432 = 0;
					if( temp_output_56_0_g2432 > 0.0 )
					ifLocalVar87_g2432 = temp_output_52_0_g2432;
					else if( temp_output_56_0_g2432 == 0.0 )
					ifLocalVar87_g2432 = temp_output_125_0_g2432;
					else if( temp_output_56_0_g2432 < 0.0 )
					ifLocalVar87_g2432 = temp_output_125_0_g2432;
					float3 temp_output_7_0_g2433 = frac( ( (ifLocalVar87_g2432).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2433 = dot( temp_output_7_0_g2433 , ( (temp_output_7_0_g2433).yzx + 33.33 ) );
					float3 temp_output_12_0_g2433 = ( temp_output_7_0_g2433 + dotResult8_g2433 );
					float2 temp_output_597_0_g2431 = ( UV100_g2432 + frac( ( ( (temp_output_12_0_g2433).xx + (temp_output_12_0_g2433).yz ) * (temp_output_12_0_g2433).zy ) ) );
					float2 DDX631_g2431 = ddx( temp_output_5_0_g2431 );
					float2 DDY632_g2431 = ddy( temp_output_5_0_g2431 );
					float temp_output_65_0_g2432 = ( 0.0 - temp_output_56_0_g2432 );
					float ifLocalVar59_g2432 = 0;
					if( temp_output_56_0_g2432 <= 0.0 )
					ifLocalVar59_g2432 = temp_output_65_0_g2432;
					else
					ifLocalVar59_g2432 = temp_output_56_0_g2432;
					float temp_output_597_30_g2431 = ifLocalVar59_g2432;
					float2 temp_output_90_0_g2432 = ( temp_output_52_0_g2432 + float2( 0,1 ) );
					float2 temp_output_123_0_g2432 = ( temp_output_52_0_g2432 + float2( 1,0 ) );
					float2 ifLocalVar88_g2432 = 0;
					if( temp_output_56_0_g2432 > 0.0 )
					ifLocalVar88_g2432 = temp_output_90_0_g2432;
					else if( temp_output_56_0_g2432 == 0.0 )
					ifLocalVar88_g2432 = temp_output_123_0_g2432;
					else if( temp_output_56_0_g2432 < 0.0 )
					ifLocalVar88_g2432 = temp_output_123_0_g2432;
					float3 temp_output_7_0_g2434 = frac( ( (ifLocalVar88_g2432).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2434 = dot( temp_output_7_0_g2434 , ( (temp_output_7_0_g2434).yzx + 33.33 ) );
					float3 temp_output_12_0_g2434 = ( temp_output_7_0_g2434 + dotResult8_g2434 );
					float2 temp_output_597_26_g2431 = ( UV100_g2432 + frac( ( ( (temp_output_12_0_g2434).xx + (temp_output_12_0_g2434).yz ) * (temp_output_12_0_g2434).zy ) ) );
					float temp_output_66_0_g2432 = ( 1.0 - break55_g2432.y );
					float ifLocalVar60_g2432 = 0;
					if( temp_output_56_0_g2432 <= 0.0 )
					ifLocalVar60_g2432 = temp_output_66_0_g2432;
					else
					ifLocalVar60_g2432 = break55_g2432.y;
					float temp_output_597_28_g2431 = ifLocalVar60_g2432;
					float2 ifLocalVar89_g2432 = 0;
					if( temp_output_56_0_g2432 > 0.0 )
					ifLocalVar89_g2432 = temp_output_123_0_g2432;
					else if( temp_output_56_0_g2432 == 0.0 )
					ifLocalVar89_g2432 = temp_output_90_0_g2432;
					else if( temp_output_56_0_g2432 < 0.0 )
					ifLocalVar89_g2432 = temp_output_90_0_g2432;
					float3 temp_output_7_0_g2435 = frac( ( (ifLocalVar89_g2432).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2435 = dot( temp_output_7_0_g2435 , ( (temp_output_7_0_g2435).yzx + 33.33 ) );
					float3 temp_output_12_0_g2435 = ( temp_output_7_0_g2435 + dotResult8_g2435 );
					float2 temp_output_597_27_g2431 = ( UV100_g2432 + frac( ( ( (temp_output_12_0_g2435).xx + (temp_output_12_0_g2435).yz ) * (temp_output_12_0_g2435).zy ) ) );
					float temp_output_67_0_g2432 = ( 1.0 - break55_g2432.x );
					float ifLocalVar61_g2432 = 0;
					if( temp_output_56_0_g2432 <= 0.0 )
					ifLocalVar61_g2432 = temp_output_67_0_g2432;
					else
					ifLocalVar61_g2432 = break55_g2432.x;
					float temp_output_597_29_g2431 = ifLocalVar61_g2432;
					float4 Output_2D293_g2431 = ( ( tex2D( _MetallicMap, temp_output_597_0_g2431, DDX631_g2431, DDY632_g2431 ) * temp_output_597_30_g2431 ) + ( tex2D( _MetallicMap, temp_output_597_26_g2431, DDX631_g2431, DDY632_g2431 ) * temp_output_597_28_g2431 ) + ( tex2D( _MetallicMap, temp_output_597_27_g2431, DDX631_g2431, DDY632_g2431 ) * temp_output_597_29_g2431 ) );
					float4 break31_g2431 = Output_2D293_g2431;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g2409 = break31_g2431.a;
					#else
					float staticSwitch1005_g2409 = tex2D( _MetallicMap, uv_MetallicMap48_g2409 ).a;
					#endif
					float saferPower803_g2409 = abs( staticSwitch1005_g2409 );
					#ifdef _METALLICMAP
					float staticSwitch846_g2409 = pow( saferPower803_g2409 , 3.0 );
					#else
					float staticSwitch846_g2409 = _Metallic;
					#endif
					float Metallic699_g2409 = staticSwitch846_g2409;
					float4 lerpResult953_g2409 = lerp( RNM_0926_g2409 , RNM_1927_g2409 , Metallic699_g2409);
					float4 RNM_Lerp950_g2409 = lerpResult953_g2409;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g2409 = temp_cast_1;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g2409 = Lightmap_0925_g2409;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g2409 = Lightmap_Lerp932_g2409;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g2409 = RNM_0926_g2409;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g2409 = RNM_Lerp950_g2409;
					#else
					float4 staticSwitch1014_g2409 = temp_cast_1;
					#endif
					float4 Lightmap46_g2409 = staticSwitch1014_g2409;
					float4 temp_output_614_0_g2409 = ( Albedo6_g2409 * Lightmap46_g2409 );
					float4 temp_cast_2 = 0;
					float2 uv_EmissionMap81_g2409 = IN.ase_texcoord2.xy;
					float2 uv_EmissionMap = IN.ase_texcoord2.xy * _EmissionMap_ST.xy + _EmissionMap_ST.zw;
					float2 temp_output_5_0_g2426 = uv_EmissionMap;
					float2 UV633_g2426 = temp_output_5_0_g2426;
					float2 UV100_g2427 = UV633_g2426;
					float2 temp_output_51_0_g2427 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g2427 * float2( 3.464,3.464 ) ) );
					float2 break55_g2427 = frac( temp_output_51_0_g2427 );
					float temp_output_56_0_g2427 = ( ( 1.0 - break55_g2427.x ) - break55_g2427.y );
					float2 temp_output_52_0_g2427 = floor( temp_output_51_0_g2427 );
					float2 temp_output_125_0_g2427 = ( temp_output_52_0_g2427 + float2( 1,1 ) );
					float2 ifLocalVar87_g2427 = 0;
					if( temp_output_56_0_g2427 > 0.0 )
					ifLocalVar87_g2427 = temp_output_52_0_g2427;
					else if( temp_output_56_0_g2427 == 0.0 )
					ifLocalVar87_g2427 = temp_output_125_0_g2427;
					else if( temp_output_56_0_g2427 < 0.0 )
					ifLocalVar87_g2427 = temp_output_125_0_g2427;
					float3 temp_output_7_0_g2428 = frac( ( (ifLocalVar87_g2427).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2428 = dot( temp_output_7_0_g2428 , ( (temp_output_7_0_g2428).yzx + 33.33 ) );
					float3 temp_output_12_0_g2428 = ( temp_output_7_0_g2428 + dotResult8_g2428 );
					float2 temp_output_597_0_g2426 = ( UV100_g2427 + frac( ( ( (temp_output_12_0_g2428).xx + (temp_output_12_0_g2428).yz ) * (temp_output_12_0_g2428).zy ) ) );
					float2 DDX631_g2426 = ddx( temp_output_5_0_g2426 );
					float2 DDY632_g2426 = ddy( temp_output_5_0_g2426 );
					float temp_output_65_0_g2427 = ( 0.0 - temp_output_56_0_g2427 );
					float ifLocalVar59_g2427 = 0;
					if( temp_output_56_0_g2427 <= 0.0 )
					ifLocalVar59_g2427 = temp_output_65_0_g2427;
					else
					ifLocalVar59_g2427 = temp_output_56_0_g2427;
					float temp_output_597_30_g2426 = ifLocalVar59_g2427;
					float2 temp_output_90_0_g2427 = ( temp_output_52_0_g2427 + float2( 0,1 ) );
					float2 temp_output_123_0_g2427 = ( temp_output_52_0_g2427 + float2( 1,0 ) );
					float2 ifLocalVar88_g2427 = 0;
					if( temp_output_56_0_g2427 > 0.0 )
					ifLocalVar88_g2427 = temp_output_90_0_g2427;
					else if( temp_output_56_0_g2427 == 0.0 )
					ifLocalVar88_g2427 = temp_output_123_0_g2427;
					else if( temp_output_56_0_g2427 < 0.0 )
					ifLocalVar88_g2427 = temp_output_123_0_g2427;
					float3 temp_output_7_0_g2429 = frac( ( (ifLocalVar88_g2427).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2429 = dot( temp_output_7_0_g2429 , ( (temp_output_7_0_g2429).yzx + 33.33 ) );
					float3 temp_output_12_0_g2429 = ( temp_output_7_0_g2429 + dotResult8_g2429 );
					float2 temp_output_597_26_g2426 = ( UV100_g2427 + frac( ( ( (temp_output_12_0_g2429).xx + (temp_output_12_0_g2429).yz ) * (temp_output_12_0_g2429).zy ) ) );
					float temp_output_66_0_g2427 = ( 1.0 - break55_g2427.y );
					float ifLocalVar60_g2427 = 0;
					if( temp_output_56_0_g2427 <= 0.0 )
					ifLocalVar60_g2427 = temp_output_66_0_g2427;
					else
					ifLocalVar60_g2427 = break55_g2427.y;
					float temp_output_597_28_g2426 = ifLocalVar60_g2427;
					float2 ifLocalVar89_g2427 = 0;
					if( temp_output_56_0_g2427 > 0.0 )
					ifLocalVar89_g2427 = temp_output_123_0_g2427;
					else if( temp_output_56_0_g2427 == 0.0 )
					ifLocalVar89_g2427 = temp_output_90_0_g2427;
					else if( temp_output_56_0_g2427 < 0.0 )
					ifLocalVar89_g2427 = temp_output_90_0_g2427;
					float3 temp_output_7_0_g2430 = frac( ( (ifLocalVar89_g2427).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g2430 = dot( temp_output_7_0_g2430 , ( (temp_output_7_0_g2430).yzx + 33.33 ) );
					float3 temp_output_12_0_g2430 = ( temp_output_7_0_g2430 + dotResult8_g2430 );
					float2 temp_output_597_27_g2426 = ( UV100_g2427 + frac( ( ( (temp_output_12_0_g2430).xx + (temp_output_12_0_g2430).yz ) * (temp_output_12_0_g2430).zy ) ) );
					float temp_output_67_0_g2427 = ( 1.0 - break55_g2427.x );
					float ifLocalVar61_g2427 = 0;
					if( temp_output_56_0_g2427 <= 0.0 )
					ifLocalVar61_g2427 = temp_output_67_0_g2427;
					else
					ifLocalVar61_g2427 = break55_g2427.x;
					float temp_output_597_29_g2426 = ifLocalVar61_g2427;
					float4 Output_2D293_g2426 = ( ( tex2D( _EmissionMap, temp_output_597_0_g2426, DDX631_g2426, DDY632_g2426 ) * temp_output_597_30_g2426 ) + ( tex2D( _EmissionMap, temp_output_597_26_g2426, DDX631_g2426, DDY632_g2426 ) * temp_output_597_28_g2426 ) + ( tex2D( _EmissionMap, temp_output_597_27_g2426, DDX631_g2426, DDY632_g2426 ) * temp_output_597_29_g2426 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g2409 = Output_2D293_g2426;
					#else
					float4 staticSwitch1006_g2409 = tex2D( _EmissionMap, uv_EmissionMap81_g2409 );
					#endif
					#ifdef _EMISSIONENABLED_ON
					float4 staticSwitch1017_g2409 = ( _EmissionColor + staticSwitch1006_g2409 );
					#else
					float4 staticSwitch1017_g2409 = temp_cast_2;
					#endif
					float4 Emission86_g2409 = staticSwitch1017_g2409;
					float4 temp_output_690_0_g2409 = ( Emission86_g2409 + temp_output_614_0_g2409 );
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1019_g2409 = ( temp_output_614_0_g2409 * Emission86_g2409 );
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1019_g2409 = temp_output_690_0_g2409;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1019_g2409 = temp_output_690_0_g2409;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1019_g2409 = temp_output_690_0_g2409;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1019_g2409 = temp_output_690_0_g2409;
					#else
					float4 staticSwitch1019_g2409 = ( temp_output_614_0_g2409 * Emission86_g2409 );
					#endif
					

					o.Albedo = Albedo6_g2409.rgb;
					o.Normal = half3( 0, 0, 1 );
					o.Emission = staticSwitch1019_g2409.rgb;
					o.Alpha = temp_output_976_0_g2409.a;
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

		
	}
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
	
	Fallback Off
}
/*ASEBEGIN
Version=19904
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2967;192,-1200;Inherit;False;Meenphie;0;;2409;b3ba55a08dd6b49c7be16c6f35cf2033;1,1008,0;0;9;COLOR;625;FLOAT3;238;FLOAT;96;FLOAT;97;FLOAT;95;COLOR;624;FLOAT;156;FLOAT;427;FLOAT3;1024
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2889;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;True;1;LightMode=ForwardAdd;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2890;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2891;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2892;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2893;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2894;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ScenePickingPass;0;7;ScenePickingPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;True;1;LightMode=ScenePickingPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2887;480,-1440;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;True;True;2;5;False;;10;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;True;True;1;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;2;False;;True;0;False;;True;False;0;False;;0;False;;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2888;512,-1200;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;Meenphie/Standard/Transparent;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardBase;0;1;ForwardBase;17;True;True;0;1;False;;1;False;;0;1;False;;1;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;True;True;2;False;;True;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;2;False;;True;0;False;_ZTest;False;True;3;RenderType=Opaque=RenderType;Queue=Transparent=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;True;True;4;1;False;;1;False;;0;1;False;;1;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;44;Category,InvertActionOnDeselection;0;0;  Instanced Terrain Normals;1;0;Workflow;1;0;Surface;0;638915536266677850;  Blend;0;638915486026768330;  Dither Shadows;0;638915443249087440;Two Sided;0;638915494950662450;Alpha Clipping;0;638915444112671460;  Use Shadow Threshold;0;638915420933436960;Deferred Pass;0;638915425282396370;Normal Space,InvertActionOnDeselection;0;0;Transmission;0;638915425258747670;  Transmission Shadow;0.5,False,;0;Translucency;0;638915425246861880;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;0;638915410807634230;Receive Shadows;1;0;Receive Specular;0;638915388784334560;Receive Reflections;1;638915388803555030;GPU Instancing;1;638915411619689990;LOD CrossFade;1;0;Built-in Fog;1;0;Ambient Light;1;0;Meta Pass;1;0;Add Pass;1;0;Override Baked GI;0;638915390973737640;Write Depth;0;638915488214535980;Extra Pre Pass;0;638915495230384640;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;0;Vertex Position,InvertActionOnDeselection;1;0;0;8;False;True;True;False;True;False;False;False;False;;False;0
WireConnection;2888;0;2967;625
WireConnection;2888;1;2967;238
WireConnection;2888;4;2967;96
WireConnection;2888;5;2967;97
WireConnection;2888;6;2967;95
WireConnection;2888;2;2967;624
WireConnection;2888;7;2967;156
WireConnection;2888;15;2967;1024
ASEEND*/
//CHKSM=FECAAF0B53749F3B67C490218F98929E7597F6D2