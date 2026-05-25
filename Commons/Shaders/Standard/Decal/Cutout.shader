// Made with Amplify Shader Editor v1.9.9.9
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Standard/Decal/Cutout"
{
	Properties
	{
		[Meenphie_DrawerCategory(SURFACE OPTIONS,true,0,0)] _CATEGORY_SURFACEOPTIONS( "CATEGORY_SURFACEOPTIONS", Float ) = 1
		_Color( "DIffuse Color", Color ) = ( 0.9058824, 0.9058824, 0.9058824, 1 )
		[NoScaleOffset][SingleLineTexture] _MainTex( "Base Color", 2D ) = "white" {}
		[NoScaleOffset][SingleLineTexture] _BumpMap( "Normal", 2D ) = "bump" {}
		_MaskClipValue( "Mask Clip Value", Range( 0, 1 ) ) = 0.5
		[NoScaleOffset][SingleLineTexture] _MetallicMap( "Metallic", 2D ) = "black" {}
		[NoScaleOffset][SingleLineTexture] _GlossinessMap( "Roughness", 2D ) = "black" {}
		[KeywordEnum( UV0,UV2 )] _UV( "UV", Float ) = 1
		_Metallic( "Metallic", Range( 0, 1 ) ) = 0
		_Glossiness( "Roughness", Range( 0, 1 ) ) = 0.5
		_IOR( "IOR", Range( 1, 2.5 ) ) = 1.5
		[Toggle( _USEGEOMETRICAA_ON )] _UseGeometricAA( "Use Geometric AA", Float ) = 1
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESURFACEOPTIONS( "CATEGORY SPACE SURFACEOPTIONS", Float ) = 0
		[Meenphie_DrawerCategory(EMISSION,true,0,0)] _CATEGORYEMISSION( "CATEGORY EMISSION", Float ) = 0
		[NoScaleOffset][SingleLineTexture] _EmissionMap( "Emission", 2D ) = "white" {}
		[KeywordEnum( UV0,UV2 )] _EmissionUV( "Emission UV", Float ) = 0
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
		[Toggle( _DIRECTSPECULAR_ON )] _DirectSpecular( "Direct Speculars", Float ) = 1
		[Toggle( _INDIRECTSPECULARS_ON )] _IndirectSpeculars( "Indirect Speculars", Float ) = 1
		[HideInInspector] GenKey__GlossinessMap( "Assign keyword _GLOSSINESSMAP", Float ) = 1.0
		[HideInInspector] GenKey__MainTex( "Assign keyword _MAINTEX", Float ) = 1.0
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
		

		

		Tags { "RenderType"="Opaque" "Queue"="AlphaTest+1" "DisableBatching"="False" }

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
				#define ASE_NO_AMBIENT 1
				#define ASE_LIGHTING_SIMPLE 1
				#define _ALPHATEST_ON
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
				#define ASE_NEEDS_VERT_NORMAL
				#define ASE_NEEDS_TEXTURE_COORDINATES2
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
				#pragma shader_feature_local_fragment _EMISSIONUV_UV0 _EMISSIONUV_UV2
				#pragma shader_feature_local _INDIRECTSPECULARS_ON
				#pragma shader_feature_local _USELIGHTMAPPEDREFLECTIONS_ON
				#pragma shader_feature_local _METALLICMAP
				#pragma shader_feature_local _UV_UV0 _UV_UV2
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
					float4 ase_texcoord7 : TEXCOORD7;
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
				sampler2D _Sampler82966_g59838;
				uniform float3 _EmissionColor;
				uniform sampler2D _EmissionMap;
				sampler2D _Sampler82968_g59838;
				uniform float _EmissionIntensity;
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				sampler2D _Sampler82967_g59838;
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				sampler2D _Sampler82964_g59838;
				uniform sampler2D _BumpMap;
				sampler2D _Sampler82965_g59838;
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
				uniform float _MaskClipValue;


				
				v2f VertexFunction( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 World_Position2505_g59838 = ase_positionWS;
					
					o.ase_texcoord6.xy = v.texcoord2.xyzw.xy;
					o.ase_texcoord7 = v.texcoord.xyzw;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord6.zw = 0;

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = ( v.normal * ( distance( World_Position2505_g59838 , _WorldSpaceCameraPos ) * 0.0005 ) );
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

					float2 texCoord2594_g59838 = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV22595_g59838 = texCoord2594_g59838;
					#ifdef _MAINTEX
					float4 staticSwitch1549_g59838 = tex2D( _MainTex, UV22595_g59838 );
					#else
					float4 staticSwitch1549_g59838 = _Color;
					#endif
					float2 temp_output_5_0_g59853 = UV22595_g59838;
					float2 UV633_g59853 = temp_output_5_0_g59853;
					float2 UV100_g59854 = UV633_g59853;
					float2 temp_output_51_0_g59854 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59854 * float2( 3.464,3.464 ) ) );
					float2 break55_g59854 = frac( temp_output_51_0_g59854 );
					float temp_output_56_0_g59854 = ( ( 1.0 - break55_g59854.x ) - break55_g59854.y );
					float2 temp_output_52_0_g59854 = floor( temp_output_51_0_g59854 );
					float2 temp_output_125_0_g59854 = ( temp_output_52_0_g59854 + float2( 1,1 ) );
					float2 ifLocalVar87_g59854 = 0;
					if( temp_output_56_0_g59854 > 0.0 )
					ifLocalVar87_g59854 = temp_output_52_0_g59854;
					else if( temp_output_56_0_g59854 == 0.0 )
					ifLocalVar87_g59854 = temp_output_125_0_g59854;
					else if( temp_output_56_0_g59854 < 0.0 )
					ifLocalVar87_g59854 = temp_output_125_0_g59854;
					float3 temp_output_7_0_g59855 = frac( ( (ifLocalVar87_g59854).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59855 = dot( temp_output_7_0_g59855 , ( (temp_output_7_0_g59855).yzx + 33.33 ) );
					float3 temp_output_12_0_g59855 = ( temp_output_7_0_g59855 + dotResult8_g59855 );
					float2 temp_output_597_0_g59853 = ( UV100_g59854 + frac( ( ( (temp_output_12_0_g59855).xx + (temp_output_12_0_g59855).yz ) * (temp_output_12_0_g59855).zy ) ) );
					float2 DDX631_g59853 = ddx( temp_output_5_0_g59853 );
					float2 DDY632_g59853 = ddy( temp_output_5_0_g59853 );
					float temp_output_65_0_g59854 = ( 0.0 - temp_output_56_0_g59854 );
					float ifLocalVar59_g59854 = 0;
					if( temp_output_56_0_g59854 <= 0.0 )
					ifLocalVar59_g59854 = temp_output_65_0_g59854;
					else
					ifLocalVar59_g59854 = temp_output_56_0_g59854;
					float temp_output_597_30_g59853 = ifLocalVar59_g59854;
					float2 temp_output_90_0_g59854 = ( temp_output_52_0_g59854 + float2( 0,1 ) );
					float2 temp_output_123_0_g59854 = ( temp_output_52_0_g59854 + float2( 1,0 ) );
					float2 ifLocalVar88_g59854 = 0;
					if( temp_output_56_0_g59854 > 0.0 )
					ifLocalVar88_g59854 = temp_output_90_0_g59854;
					else if( temp_output_56_0_g59854 == 0.0 )
					ifLocalVar88_g59854 = temp_output_123_0_g59854;
					else if( temp_output_56_0_g59854 < 0.0 )
					ifLocalVar88_g59854 = temp_output_123_0_g59854;
					float3 temp_output_7_0_g59856 = frac( ( (ifLocalVar88_g59854).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59856 = dot( temp_output_7_0_g59856 , ( (temp_output_7_0_g59856).yzx + 33.33 ) );
					float3 temp_output_12_0_g59856 = ( temp_output_7_0_g59856 + dotResult8_g59856 );
					float2 temp_output_597_26_g59853 = ( UV100_g59854 + frac( ( ( (temp_output_12_0_g59856).xx + (temp_output_12_0_g59856).yz ) * (temp_output_12_0_g59856).zy ) ) );
					float temp_output_66_0_g59854 = ( 1.0 - break55_g59854.y );
					float ifLocalVar60_g59854 = 0;
					if( temp_output_56_0_g59854 <= 0.0 )
					ifLocalVar60_g59854 = temp_output_66_0_g59854;
					else
					ifLocalVar60_g59854 = break55_g59854.y;
					float temp_output_597_28_g59853 = ifLocalVar60_g59854;
					float2 ifLocalVar89_g59854 = 0;
					if( temp_output_56_0_g59854 > 0.0 )
					ifLocalVar89_g59854 = temp_output_123_0_g59854;
					else if( temp_output_56_0_g59854 == 0.0 )
					ifLocalVar89_g59854 = temp_output_90_0_g59854;
					else if( temp_output_56_0_g59854 < 0.0 )
					ifLocalVar89_g59854 = temp_output_90_0_g59854;
					float3 temp_output_7_0_g59857 = frac( ( (ifLocalVar89_g59854).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59857 = dot( temp_output_7_0_g59857 , ( (temp_output_7_0_g59857).yzx + 33.33 ) );
					float3 temp_output_12_0_g59857 = ( temp_output_7_0_g59857 + dotResult8_g59857 );
					float2 temp_output_597_27_g59853 = ( UV100_g59854 + frac( ( ( (temp_output_12_0_g59857).xx + (temp_output_12_0_g59857).yz ) * (temp_output_12_0_g59857).zy ) ) );
					float temp_output_67_0_g59854 = ( 1.0 - break55_g59854.x );
					float ifLocalVar61_g59854 = 0;
					if( temp_output_56_0_g59854 <= 0.0 )
					ifLocalVar61_g59854 = temp_output_67_0_g59854;
					else
					ifLocalVar61_g59854 = break55_g59854.x;
					float temp_output_597_29_g59853 = ifLocalVar61_g59854;
					float4 Output_2D293_g59853 = ( ( tex2D( _Sampler82966_g59838, temp_output_597_0_g59853, DDX631_g59853, DDY632_g59853 ) * temp_output_597_30_g59853 ) + ( tex2D( _Sampler82966_g59838, temp_output_597_26_g59853, DDX631_g59853, DDY632_g59853 ) * temp_output_597_28_g59853 ) + ( tex2D( _Sampler82966_g59838, temp_output_597_27_g59853, DDX631_g59853, DDY632_g59853 ) * temp_output_597_29_g59853 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g59838 = Output_2D293_g59853;
					#else
					float4 staticSwitch1001_g59838 = staticSwitch1549_g59838;
					#endif
					float3 temp_output_2532_0_g59838 = (staticSwitch1001_g59838).rgb;
					float3 oAlbedo6_g59838 = temp_output_2532_0_g59838;
					float Black1185_g59838 = 0.0;
					float3 temp_cast_0 = (Black1185_g59838).xxx;
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch1180_g59838 = temp_cast_0;
					#else
					float3 staticSwitch1180_g59838 = oAlbedo6_g59838;
					#endif
					
					float2 texCoord2357_g59838 = IN.ase_texcoord7.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0A2420_g59838 = texCoord2357_g59838;
					#if defined( _EMISSIONUV_UV0 )
					float2 staticSwitch2642_g59838 = UV0A2420_g59838;
					#elif defined( _EMISSIONUV_UV2 )
					float2 staticSwitch2642_g59838 = UV22595_g59838;
					#else
					float2 staticSwitch2642_g59838 = UV0A2420_g59838;
					#endif
					float2 temp_output_5_0_g59863 = staticSwitch2642_g59838;
					float2 UV633_g59863 = temp_output_5_0_g59863;
					float2 UV100_g59864 = UV633_g59863;
					float2 temp_output_51_0_g59864 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59864 * float2( 3.464,3.464 ) ) );
					float2 break55_g59864 = frac( temp_output_51_0_g59864 );
					float temp_output_56_0_g59864 = ( ( 1.0 - break55_g59864.x ) - break55_g59864.y );
					float2 temp_output_52_0_g59864 = floor( temp_output_51_0_g59864 );
					float2 temp_output_125_0_g59864 = ( temp_output_52_0_g59864 + float2( 1,1 ) );
					float2 ifLocalVar87_g59864 = 0;
					if( temp_output_56_0_g59864 > 0.0 )
					ifLocalVar87_g59864 = temp_output_52_0_g59864;
					else if( temp_output_56_0_g59864 == 0.0 )
					ifLocalVar87_g59864 = temp_output_125_0_g59864;
					else if( temp_output_56_0_g59864 < 0.0 )
					ifLocalVar87_g59864 = temp_output_125_0_g59864;
					float3 temp_output_7_0_g59865 = frac( ( (ifLocalVar87_g59864).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59865 = dot( temp_output_7_0_g59865 , ( (temp_output_7_0_g59865).yzx + 33.33 ) );
					float3 temp_output_12_0_g59865 = ( temp_output_7_0_g59865 + dotResult8_g59865 );
					float2 temp_output_597_0_g59863 = ( UV100_g59864 + frac( ( ( (temp_output_12_0_g59865).xx + (temp_output_12_0_g59865).yz ) * (temp_output_12_0_g59865).zy ) ) );
					float2 DDX631_g59863 = ddx( temp_output_5_0_g59863 );
					float2 DDY632_g59863 = ddy( temp_output_5_0_g59863 );
					float temp_output_65_0_g59864 = ( 0.0 - temp_output_56_0_g59864 );
					float ifLocalVar59_g59864 = 0;
					if( temp_output_56_0_g59864 <= 0.0 )
					ifLocalVar59_g59864 = temp_output_65_0_g59864;
					else
					ifLocalVar59_g59864 = temp_output_56_0_g59864;
					float temp_output_597_30_g59863 = ifLocalVar59_g59864;
					float2 temp_output_90_0_g59864 = ( temp_output_52_0_g59864 + float2( 0,1 ) );
					float2 temp_output_123_0_g59864 = ( temp_output_52_0_g59864 + float2( 1,0 ) );
					float2 ifLocalVar88_g59864 = 0;
					if( temp_output_56_0_g59864 > 0.0 )
					ifLocalVar88_g59864 = temp_output_90_0_g59864;
					else if( temp_output_56_0_g59864 == 0.0 )
					ifLocalVar88_g59864 = temp_output_123_0_g59864;
					else if( temp_output_56_0_g59864 < 0.0 )
					ifLocalVar88_g59864 = temp_output_123_0_g59864;
					float3 temp_output_7_0_g59866 = frac( ( (ifLocalVar88_g59864).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59866 = dot( temp_output_7_0_g59866 , ( (temp_output_7_0_g59866).yzx + 33.33 ) );
					float3 temp_output_12_0_g59866 = ( temp_output_7_0_g59866 + dotResult8_g59866 );
					float2 temp_output_597_26_g59863 = ( UV100_g59864 + frac( ( ( (temp_output_12_0_g59866).xx + (temp_output_12_0_g59866).yz ) * (temp_output_12_0_g59866).zy ) ) );
					float temp_output_66_0_g59864 = ( 1.0 - break55_g59864.y );
					float ifLocalVar60_g59864 = 0;
					if( temp_output_56_0_g59864 <= 0.0 )
					ifLocalVar60_g59864 = temp_output_66_0_g59864;
					else
					ifLocalVar60_g59864 = break55_g59864.y;
					float temp_output_597_28_g59863 = ifLocalVar60_g59864;
					float2 ifLocalVar89_g59864 = 0;
					if( temp_output_56_0_g59864 > 0.0 )
					ifLocalVar89_g59864 = temp_output_123_0_g59864;
					else if( temp_output_56_0_g59864 == 0.0 )
					ifLocalVar89_g59864 = temp_output_90_0_g59864;
					else if( temp_output_56_0_g59864 < 0.0 )
					ifLocalVar89_g59864 = temp_output_90_0_g59864;
					float3 temp_output_7_0_g59867 = frac( ( (ifLocalVar89_g59864).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59867 = dot( temp_output_7_0_g59867 , ( (temp_output_7_0_g59867).yzx + 33.33 ) );
					float3 temp_output_12_0_g59867 = ( temp_output_7_0_g59867 + dotResult8_g59867 );
					float2 temp_output_597_27_g59863 = ( UV100_g59864 + frac( ( ( (temp_output_12_0_g59867).xx + (temp_output_12_0_g59867).yz ) * (temp_output_12_0_g59867).zy ) ) );
					float temp_output_67_0_g59864 = ( 1.0 - break55_g59864.x );
					float ifLocalVar61_g59864 = 0;
					if( temp_output_56_0_g59864 <= 0.0 )
					ifLocalVar61_g59864 = temp_output_67_0_g59864;
					else
					ifLocalVar61_g59864 = break55_g59864.x;
					float temp_output_597_29_g59863 = ifLocalVar61_g59864;
					float4 Output_2D293_g59863 = ( ( tex2D( _Sampler82968_g59838, temp_output_597_0_g59863, DDX631_g59863, DDY632_g59863 ) * temp_output_597_30_g59863 ) + ( tex2D( _Sampler82968_g59838, temp_output_597_26_g59863, DDX631_g59863, DDY632_g59863 ) * temp_output_597_28_g59863 ) + ( tex2D( _Sampler82968_g59838, temp_output_597_27_g59863, DDX631_g59863, DDY632_g59863 ) * temp_output_597_29_g59863 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g59838 = Output_2D293_g59863;
					#else
					float4 staticSwitch1006_g59838 = tex2D( _EmissionMap, staticSwitch2642_g59838 );
					#endif
					float3 temp_output_2531_0_g59838 = (( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g59838 * _EmissionIntensity )).rgb;
					float3 Emission86_g59838 = temp_output_2531_0_g59838;
					float3 temp_cast_2 = (Black1185_g59838).xxx;
					float3 Color1_g59891 = oAlbedo6_g59838;
					#if defined( _UV_UV0 )
					float2 staticSwitch2671_g59838 = UV0A2420_g59838;
					#elif defined( _UV_UV2 )
					float2 staticSwitch2671_g59838 = UV22595_g59838;
					#else
					float2 staticSwitch2671_g59838 = UV22595_g59838;
					#endif
					#ifdef _METALLICMAP
					float staticSwitch846_g59838 = tex2D( _MetallicMap, staticSwitch2671_g59838 ).r;
					#else
					float staticSwitch846_g59838 = _Metallic;
					#endif
					float2 temp_output_5_0_g59873 = staticSwitch2671_g59838;
					float2 UV633_g59873 = temp_output_5_0_g59873;
					float2 UV100_g59874 = UV633_g59873;
					float2 temp_output_51_0_g59874 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59874 * float2( 3.464,3.464 ) ) );
					float2 break55_g59874 = frac( temp_output_51_0_g59874 );
					float temp_output_56_0_g59874 = ( ( 1.0 - break55_g59874.x ) - break55_g59874.y );
					float2 temp_output_52_0_g59874 = floor( temp_output_51_0_g59874 );
					float2 temp_output_125_0_g59874 = ( temp_output_52_0_g59874 + float2( 1,1 ) );
					float2 ifLocalVar87_g59874 = 0;
					if( temp_output_56_0_g59874 > 0.0 )
					ifLocalVar87_g59874 = temp_output_52_0_g59874;
					else if( temp_output_56_0_g59874 == 0.0 )
					ifLocalVar87_g59874 = temp_output_125_0_g59874;
					else if( temp_output_56_0_g59874 < 0.0 )
					ifLocalVar87_g59874 = temp_output_125_0_g59874;
					float3 temp_output_7_0_g59875 = frac( ( (ifLocalVar87_g59874).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59875 = dot( temp_output_7_0_g59875 , ( (temp_output_7_0_g59875).yzx + 33.33 ) );
					float3 temp_output_12_0_g59875 = ( temp_output_7_0_g59875 + dotResult8_g59875 );
					float2 temp_output_597_0_g59873 = ( UV100_g59874 + frac( ( ( (temp_output_12_0_g59875).xx + (temp_output_12_0_g59875).yz ) * (temp_output_12_0_g59875).zy ) ) );
					float2 DDX631_g59873 = ddx( temp_output_5_0_g59873 );
					float2 DDY632_g59873 = ddy( temp_output_5_0_g59873 );
					float temp_output_65_0_g59874 = ( 0.0 - temp_output_56_0_g59874 );
					float ifLocalVar59_g59874 = 0;
					if( temp_output_56_0_g59874 <= 0.0 )
					ifLocalVar59_g59874 = temp_output_65_0_g59874;
					else
					ifLocalVar59_g59874 = temp_output_56_0_g59874;
					float temp_output_597_30_g59873 = ifLocalVar59_g59874;
					float2 temp_output_90_0_g59874 = ( temp_output_52_0_g59874 + float2( 0,1 ) );
					float2 temp_output_123_0_g59874 = ( temp_output_52_0_g59874 + float2( 1,0 ) );
					float2 ifLocalVar88_g59874 = 0;
					if( temp_output_56_0_g59874 > 0.0 )
					ifLocalVar88_g59874 = temp_output_90_0_g59874;
					else if( temp_output_56_0_g59874 == 0.0 )
					ifLocalVar88_g59874 = temp_output_123_0_g59874;
					else if( temp_output_56_0_g59874 < 0.0 )
					ifLocalVar88_g59874 = temp_output_123_0_g59874;
					float3 temp_output_7_0_g59876 = frac( ( (ifLocalVar88_g59874).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59876 = dot( temp_output_7_0_g59876 , ( (temp_output_7_0_g59876).yzx + 33.33 ) );
					float3 temp_output_12_0_g59876 = ( temp_output_7_0_g59876 + dotResult8_g59876 );
					float2 temp_output_597_26_g59873 = ( UV100_g59874 + frac( ( ( (temp_output_12_0_g59876).xx + (temp_output_12_0_g59876).yz ) * (temp_output_12_0_g59876).zy ) ) );
					float temp_output_66_0_g59874 = ( 1.0 - break55_g59874.y );
					float ifLocalVar60_g59874 = 0;
					if( temp_output_56_0_g59874 <= 0.0 )
					ifLocalVar60_g59874 = temp_output_66_0_g59874;
					else
					ifLocalVar60_g59874 = break55_g59874.y;
					float temp_output_597_28_g59873 = ifLocalVar60_g59874;
					float2 ifLocalVar89_g59874 = 0;
					if( temp_output_56_0_g59874 > 0.0 )
					ifLocalVar89_g59874 = temp_output_123_0_g59874;
					else if( temp_output_56_0_g59874 == 0.0 )
					ifLocalVar89_g59874 = temp_output_90_0_g59874;
					else if( temp_output_56_0_g59874 < 0.0 )
					ifLocalVar89_g59874 = temp_output_90_0_g59874;
					float3 temp_output_7_0_g59877 = frac( ( (ifLocalVar89_g59874).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59877 = dot( temp_output_7_0_g59877 , ( (temp_output_7_0_g59877).yzx + 33.33 ) );
					float3 temp_output_12_0_g59877 = ( temp_output_7_0_g59877 + dotResult8_g59877 );
					float2 temp_output_597_27_g59873 = ( UV100_g59874 + frac( ( ( (temp_output_12_0_g59877).xx + (temp_output_12_0_g59877).yz ) * (temp_output_12_0_g59877).zy ) ) );
					float temp_output_67_0_g59874 = ( 1.0 - break55_g59874.x );
					float ifLocalVar61_g59874 = 0;
					if( temp_output_56_0_g59874 <= 0.0 )
					ifLocalVar61_g59874 = temp_output_67_0_g59874;
					else
					ifLocalVar61_g59874 = break55_g59874.x;
					float temp_output_597_29_g59873 = ifLocalVar61_g59874;
					float4 Output_2D293_g59873 = ( ( tex2D( _Sampler82967_g59838, temp_output_597_0_g59873, DDX631_g59873, DDY632_g59873 ) * temp_output_597_30_g59873 ) + ( tex2D( _Sampler82967_g59838, temp_output_597_26_g59873, DDX631_g59873, DDY632_g59873 ) * temp_output_597_28_g59873 ) + ( tex2D( _Sampler82967_g59838, temp_output_597_27_g59873, DDX631_g59873, DDY632_g59873 ) * temp_output_597_29_g59873 ) );
					float4 break31_g59873 = Output_2D293_g59873;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g59838 = break31_g59873.r;
					#else
					float staticSwitch1005_g59838 = staticSwitch846_g59838;
					#endif
					float Metallic1239_g59838 = staticSwitch1005_g59838;
					float Metallic1_g59891 = Metallic1239_g59838;
					#if defined( _UV_UV0 )
					float2 staticSwitch2644_g59838 = UV0A2420_g59838;
					#elif defined( _UV_UV2 )
					float2 staticSwitch2644_g59838 = UV22595_g59838;
					#else
					float2 staticSwitch2644_g59838 = UV22595_g59838;
					#endif
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g59838 = tex2D( _GlossinessMap, staticSwitch2644_g59838 ).r;
					#else
					float staticSwitch845_g59838 = _Glossiness;
					#endif
					float2 temp_output_5_0_g59858 = staticSwitch2644_g59838;
					float2 UV633_g59858 = temp_output_5_0_g59858;
					float2 UV100_g59859 = UV633_g59858;
					float2 temp_output_51_0_g59859 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59859 * float2( 3.464,3.464 ) ) );
					float2 break55_g59859 = frac( temp_output_51_0_g59859 );
					float temp_output_56_0_g59859 = ( ( 1.0 - break55_g59859.x ) - break55_g59859.y );
					float2 temp_output_52_0_g59859 = floor( temp_output_51_0_g59859 );
					float2 temp_output_125_0_g59859 = ( temp_output_52_0_g59859 + float2( 1,1 ) );
					float2 ifLocalVar87_g59859 = 0;
					if( temp_output_56_0_g59859 > 0.0 )
					ifLocalVar87_g59859 = temp_output_52_0_g59859;
					else if( temp_output_56_0_g59859 == 0.0 )
					ifLocalVar87_g59859 = temp_output_125_0_g59859;
					else if( temp_output_56_0_g59859 < 0.0 )
					ifLocalVar87_g59859 = temp_output_125_0_g59859;
					float3 temp_output_7_0_g59860 = frac( ( (ifLocalVar87_g59859).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59860 = dot( temp_output_7_0_g59860 , ( (temp_output_7_0_g59860).yzx + 33.33 ) );
					float3 temp_output_12_0_g59860 = ( temp_output_7_0_g59860 + dotResult8_g59860 );
					float2 temp_output_597_0_g59858 = ( UV100_g59859 + frac( ( ( (temp_output_12_0_g59860).xx + (temp_output_12_0_g59860).yz ) * (temp_output_12_0_g59860).zy ) ) );
					float2 DDX631_g59858 = ddx( temp_output_5_0_g59858 );
					float2 DDY632_g59858 = ddy( temp_output_5_0_g59858 );
					float temp_output_65_0_g59859 = ( 0.0 - temp_output_56_0_g59859 );
					float ifLocalVar59_g59859 = 0;
					if( temp_output_56_0_g59859 <= 0.0 )
					ifLocalVar59_g59859 = temp_output_65_0_g59859;
					else
					ifLocalVar59_g59859 = temp_output_56_0_g59859;
					float temp_output_597_30_g59858 = ifLocalVar59_g59859;
					float2 temp_output_90_0_g59859 = ( temp_output_52_0_g59859 + float2( 0,1 ) );
					float2 temp_output_123_0_g59859 = ( temp_output_52_0_g59859 + float2( 1,0 ) );
					float2 ifLocalVar88_g59859 = 0;
					if( temp_output_56_0_g59859 > 0.0 )
					ifLocalVar88_g59859 = temp_output_90_0_g59859;
					else if( temp_output_56_0_g59859 == 0.0 )
					ifLocalVar88_g59859 = temp_output_123_0_g59859;
					else if( temp_output_56_0_g59859 < 0.0 )
					ifLocalVar88_g59859 = temp_output_123_0_g59859;
					float3 temp_output_7_0_g59861 = frac( ( (ifLocalVar88_g59859).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59861 = dot( temp_output_7_0_g59861 , ( (temp_output_7_0_g59861).yzx + 33.33 ) );
					float3 temp_output_12_0_g59861 = ( temp_output_7_0_g59861 + dotResult8_g59861 );
					float2 temp_output_597_26_g59858 = ( UV100_g59859 + frac( ( ( (temp_output_12_0_g59861).xx + (temp_output_12_0_g59861).yz ) * (temp_output_12_0_g59861).zy ) ) );
					float temp_output_66_0_g59859 = ( 1.0 - break55_g59859.y );
					float ifLocalVar60_g59859 = 0;
					if( temp_output_56_0_g59859 <= 0.0 )
					ifLocalVar60_g59859 = temp_output_66_0_g59859;
					else
					ifLocalVar60_g59859 = break55_g59859.y;
					float temp_output_597_28_g59858 = ifLocalVar60_g59859;
					float2 ifLocalVar89_g59859 = 0;
					if( temp_output_56_0_g59859 > 0.0 )
					ifLocalVar89_g59859 = temp_output_123_0_g59859;
					else if( temp_output_56_0_g59859 == 0.0 )
					ifLocalVar89_g59859 = temp_output_90_0_g59859;
					else if( temp_output_56_0_g59859 < 0.0 )
					ifLocalVar89_g59859 = temp_output_90_0_g59859;
					float3 temp_output_7_0_g59862 = frac( ( (ifLocalVar89_g59859).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59862 = dot( temp_output_7_0_g59862 , ( (temp_output_7_0_g59862).yzx + 33.33 ) );
					float3 temp_output_12_0_g59862 = ( temp_output_7_0_g59862 + dotResult8_g59862 );
					float2 temp_output_597_27_g59858 = ( UV100_g59859 + frac( ( ( (temp_output_12_0_g59862).xx + (temp_output_12_0_g59862).yz ) * (temp_output_12_0_g59862).zy ) ) );
					float temp_output_67_0_g59859 = ( 1.0 - break55_g59859.x );
					float ifLocalVar61_g59859 = 0;
					if( temp_output_56_0_g59859 <= 0.0 )
					ifLocalVar61_g59859 = temp_output_67_0_g59859;
					else
					ifLocalVar61_g59859 = break55_g59859.x;
					float temp_output_597_29_g59858 = ifLocalVar61_g59859;
					float4 Output_2D293_g59858 = ( ( tex2D( _Sampler82964_g59838, temp_output_597_0_g59858, DDX631_g59858, DDY632_g59858 ) * temp_output_597_30_g59858 ) + ( tex2D( _Sampler82964_g59838, temp_output_597_26_g59858, DDX631_g59858, DDY632_g59858 ) * temp_output_597_28_g59858 ) + ( tex2D( _Sampler82964_g59838, temp_output_597_27_g59858, DDX631_g59858, DDY632_g59858 ) * temp_output_597_29_g59858 ) );
					float4 break31_g59858 = Output_2D293_g59858;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g59838 = ( 1.0 - break31_g59858.r );
					#else
					float staticSwitch1004_g59838 = ( 1.0 - staticSwitch845_g59838 );
					#endif
					float temp_output_19_0_g59889 = staticSwitch1004_g59838;
					float2 temp_output_5_0_g59848 = UV0A2420_g59838;
					float2 UV633_g59848 = temp_output_5_0_g59848;
					float2 UV100_g59849 = UV633_g59848;
					float2 temp_output_51_0_g59849 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59849 * float2( 3.464,3.464 ) ) );
					float2 break55_g59849 = frac( temp_output_51_0_g59849 );
					float temp_output_56_0_g59849 = ( ( 1.0 - break55_g59849.x ) - break55_g59849.y );
					float2 temp_output_52_0_g59849 = floor( temp_output_51_0_g59849 );
					float2 temp_output_125_0_g59849 = ( temp_output_52_0_g59849 + float2( 1,1 ) );
					float2 ifLocalVar87_g59849 = 0;
					if( temp_output_56_0_g59849 > 0.0 )
					ifLocalVar87_g59849 = temp_output_52_0_g59849;
					else if( temp_output_56_0_g59849 == 0.0 )
					ifLocalVar87_g59849 = temp_output_125_0_g59849;
					else if( temp_output_56_0_g59849 < 0.0 )
					ifLocalVar87_g59849 = temp_output_125_0_g59849;
					float3 temp_output_7_0_g59850 = frac( ( (ifLocalVar87_g59849).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59850 = dot( temp_output_7_0_g59850 , ( (temp_output_7_0_g59850).yzx + 33.33 ) );
					float3 temp_output_12_0_g59850 = ( temp_output_7_0_g59850 + dotResult8_g59850 );
					float2 temp_output_597_0_g59848 = ( UV100_g59849 + frac( ( ( (temp_output_12_0_g59850).xx + (temp_output_12_0_g59850).yz ) * (temp_output_12_0_g59850).zy ) ) );
					float2 DDX631_g59848 = ddx( temp_output_5_0_g59848 );
					float2 DDY632_g59848 = ddy( temp_output_5_0_g59848 );
					float Input_Scale617_g59848 = 1.5;
					float temp_output_65_0_g59849 = ( 0.0 - temp_output_56_0_g59849 );
					float ifLocalVar59_g59849 = 0;
					if( temp_output_56_0_g59849 <= 0.0 )
					ifLocalVar59_g59849 = temp_output_65_0_g59849;
					else
					ifLocalVar59_g59849 = temp_output_56_0_g59849;
					float temp_output_597_30_g59848 = ifLocalVar59_g59849;
					float2 temp_output_90_0_g59849 = ( temp_output_52_0_g59849 + float2( 0,1 ) );
					float2 temp_output_123_0_g59849 = ( temp_output_52_0_g59849 + float2( 1,0 ) );
					float2 ifLocalVar88_g59849 = 0;
					if( temp_output_56_0_g59849 > 0.0 )
					ifLocalVar88_g59849 = temp_output_90_0_g59849;
					else if( temp_output_56_0_g59849 == 0.0 )
					ifLocalVar88_g59849 = temp_output_123_0_g59849;
					else if( temp_output_56_0_g59849 < 0.0 )
					ifLocalVar88_g59849 = temp_output_123_0_g59849;
					float3 temp_output_7_0_g59851 = frac( ( (ifLocalVar88_g59849).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59851 = dot( temp_output_7_0_g59851 , ( (temp_output_7_0_g59851).yzx + 33.33 ) );
					float3 temp_output_12_0_g59851 = ( temp_output_7_0_g59851 + dotResult8_g59851 );
					float2 temp_output_597_26_g59848 = ( UV100_g59849 + frac( ( ( (temp_output_12_0_g59851).xx + (temp_output_12_0_g59851).yz ) * (temp_output_12_0_g59851).zy ) ) );
					float temp_output_66_0_g59849 = ( 1.0 - break55_g59849.y );
					float ifLocalVar60_g59849 = 0;
					if( temp_output_56_0_g59849 <= 0.0 )
					ifLocalVar60_g59849 = temp_output_66_0_g59849;
					else
					ifLocalVar60_g59849 = break55_g59849.y;
					float temp_output_597_28_g59848 = ifLocalVar60_g59849;
					float2 ifLocalVar89_g59849 = 0;
					if( temp_output_56_0_g59849 > 0.0 )
					ifLocalVar89_g59849 = temp_output_123_0_g59849;
					else if( temp_output_56_0_g59849 == 0.0 )
					ifLocalVar89_g59849 = temp_output_90_0_g59849;
					else if( temp_output_56_0_g59849 < 0.0 )
					ifLocalVar89_g59849 = temp_output_90_0_g59849;
					float3 temp_output_7_0_g59852 = frac( ( (ifLocalVar89_g59849).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59852 = dot( temp_output_7_0_g59852 , ( (temp_output_7_0_g59852).yzx + 33.33 ) );
					float3 temp_output_12_0_g59852 = ( temp_output_7_0_g59852 + dotResult8_g59852 );
					float2 temp_output_597_27_g59848 = ( UV100_g59849 + frac( ( ( (temp_output_12_0_g59852).xx + (temp_output_12_0_g59852).yz ) * (temp_output_12_0_g59852).zy ) ) );
					float temp_output_67_0_g59849 = ( 1.0 - break55_g59849.x );
					float ifLocalVar61_g59849 = 0;
					if( temp_output_56_0_g59849 <= 0.0 )
					ifLocalVar61_g59849 = temp_output_67_0_g59849;
					else
					ifLocalVar61_g59849 = break55_g59849.x;
					float temp_output_597_29_g59848 = ifLocalVar61_g59849;
					float3 Output_2D_Normal641_g59848 = ( ( UnpackScaleNormal( tex2D( _Sampler82965_g59838, temp_output_597_0_g59848, DDX631_g59848, DDY632_g59848 ), Input_Scale617_g59848 ) * temp_output_597_30_g59848 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g59838, temp_output_597_26_g59848, DDX631_g59848, DDY632_g59848 ), Input_Scale617_g59848 ) * temp_output_597_28_g59848 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g59838, temp_output_597_27_g59848, DDX631_g59848, DDY632_g59848 ), Input_Scale617_g59848 ) * float3( 0,0,0 ) * temp_output_597_29_g59848 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g59838 = Output_2D_Normal641_g59848;
					#else
					float3 staticSwitch1003_g59838 = UnpackScaleNormal( tex2D( _BumpMap, UV0A2420_g59838 ), 1.5 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g59838 = staticSwitch1003_g59838;
					#else
					float3 staticSwitch980_g59838 = float3( 0, 0, 1 );
					#endif
					float3 normalizeResult2878_g59838 = normalize( staticSwitch980_g59838 );
					float3 Normal_Map700_g59838 = normalizeResult2878_g59838;
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal2504_g59838 = Normal_Map700_g59838;
					float3 worldNormal2504_g59838 = normalize( float3( dot( tanToWorld0, tanNormal2504_g59838 ), dot( tanToWorld1, tanNormal2504_g59838 ), dot( tanToWorld2, tanNormal2504_g59838 ) ) );
					float3 World_Normal2508_g59838 = worldNormal2504_g59838;
					float3 tanNormal2_g59889 = World_Normal2508_g59838;
					float3 worldNormal2_g59889 = float3( dot( tanToWorld0, tanNormal2_g59889 ), dot( tanToWorld1, tanNormal2_g59889 ), dot( tanToWorld2, tanNormal2_g59889 ) );
					float3 temp_output_3_0_g59889 = ddx( worldNormal2_g59889 );
					float dotResult5_g59889 = dot( temp_output_3_0_g59889 , temp_output_3_0_g59889 );
					float3 temp_output_4_0_g59889 = ddy( worldNormal2_g59889 );
					float dotResult6_g59889 = dot( temp_output_4_0_g59889 , temp_output_4_0_g59889 );
					#ifdef _USEGEOMETRICAA_ON
					float staticSwitch15_g59889 = min( temp_output_19_0_g59889, ( 1.0 - pow( saturate( max( dotResult5_g59889, dotResult6_g59889 ) ) , 0.25 ) ) );
					#else
					float staticSwitch15_g59889 = temp_output_19_0_g59889;
					#endif
					float Smoothness1399_g59838 = staticSwitch15_g59889;
					float Smoothness1_g59891 = Smoothness1399_g59838;
					float IOR2700_g59838 = _IOR;
					float IOR1_g59891 = IOR2700_g59838;
					float3 temp_cast_3 = (0.04).xxx;
					float3 lerpResult1473_g59838 = lerp( temp_cast_3 , oAlbedo6_g59838 , Metallic1239_g59838);
					float3 switchResult1501_g59838 = (((ase_vface>0)?(World_Normal2508_g59838):(-World_Normal2508_g59838)));
					float3 View_Direction2511_g59838 = ViewDirWS;
					float dotResult1476_g59838 = dot( switchResult1501_g59838 , View_Direction2511_g59838 );
					float3 lerpResult1480_g59838 = lerp( lerpResult1473_g59838 , float3( 1,1,1 ) , pow( ( 1.0 - saturate( dotResult1476_g59838 ) ) , 5.0 ));
					float3 Fresnel1560_g59838 = lerpResult1480_g59838;
					float3 Fresnel1_g59891 = Fresnel1560_g59838;
					float3 World_Position2505_g59838 = PositionWS;
					float3 WorldPos1_g59891 = World_Position2505_g59838;
					float3 WorldNormal1_g59891 = World_Normal2508_g59838;
					float3 ViewDir1_g59891 = View_Direction2511_g59838;
					float3 localIndirectSpecular1_g59891 = IndirectSpecular( Color1_g59891 , Metallic1_g59891 , Smoothness1_g59891 , IOR1_g59891 , Fresnel1_g59891 , WorldPos1_g59891 , WorldNormal1_g59891 , ViewDir1_g59891 );
					float3 temp_output_2958_0_g59838 = localIndirectSpecular1_g59891;
					float White38_g59838 = 1.0;
					float4 temp_cast_4 = (White38_g59838).xxxx;
					float4 texCoord2426_g59838 = IN.ase_texcoord7;
					texCoord2426_g59838.xy = IN.ase_texcoord7.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0B2361_g59838 = (texCoord2426_g59838).zw;
					float localBicubicPrepare2_g59847 = ( 0.0 );
					float2 Input_UV100_g59847 = UV0B2361_g59838;
					float2 UV2_g59847 = Input_UV100_g59847;
					float4 TexelSize2_g59847 = _Lightmap0_TexelSize;
					float2 UV02_g59847 = float2( 0,0 );
					float2 UV12_g59847 = float2( 0,0 );
					float2 UV22_g59847 = float2( 0,0 );
					float2 UV32_g59847 = float2( 0,0 );
					float W02_g59847 = 0;
					float W12_g59847 = 0;
					{
					{
					 UV2_g59847 = UV2_g59847 * TexelSize2_g59847.zw - 0.5;
					    float2 f = frac( UV2_g59847 );
					    UV2_g59847 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59847.x - 0.5, UV2_g59847.x + 1.5, UV2_g59847.y - 0.5, UV2_g59847.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59847.xyxy;
					    UV02_g59847 = off.xz;
					    UV12_g59847 = off.yz;
					    UV22_g59847 = off.xw;
					    UV32_g59847 = off.yw;
					    W02_g59847 = s.x / ( s.x + s.y );
					 W12_g59847 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59847 = lerp( tex2D( _Lightmap0, UV32_g59847 ) , tex2D( _Lightmap0, UV22_g59847 ) , W02_g59847);
					float4 lerpResult45_g59847 = lerp( tex2D( _Lightmap0, UV12_g59847 ) , tex2D( _Lightmap0, UV02_g59847 ) , W02_g59847);
					float4 lerpResult44_g59847 = lerp( lerpResult46_g59847 , lerpResult45_g59847 , W12_g59847);
					float4 Output_2D_Auto131_g59847 = lerpResult44_g59847;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g59838 = Output_2D_Auto131_g59847;
					#else
					float4 staticSwitch1092_g59838 = float4( tex2D( _Lightmap0, UV0B2361_g59838 ).rgb , 0.0 );
					#endif
					float4 Lightmap_0925_g59838 = staticSwitch1092_g59838;
					float localBicubicPrepare2_g59845 = ( 0.0 );
					float2 Input_UV100_g59845 = UV0B2361_g59838;
					float2 UV2_g59845 = Input_UV100_g59845;
					float4 TexelSize2_g59845 = _Lightmap1_TexelSize;
					float2 UV02_g59845 = float2( 0,0 );
					float2 UV12_g59845 = float2( 0,0 );
					float2 UV22_g59845 = float2( 0,0 );
					float2 UV32_g59845 = float2( 0,0 );
					float W02_g59845 = 0;
					float W12_g59845 = 0;
					{
					{
					 UV2_g59845 = UV2_g59845 * TexelSize2_g59845.zw - 0.5;
					    float2 f = frac( UV2_g59845 );
					    UV2_g59845 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59845.x - 0.5, UV2_g59845.x + 1.5, UV2_g59845.y - 0.5, UV2_g59845.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59845.xyxy;
					    UV02_g59845 = off.xz;
					    UV12_g59845 = off.yz;
					    UV22_g59845 = off.xw;
					    UV32_g59845 = off.yw;
					    W02_g59845 = s.x / ( s.x + s.y );
					 W12_g59845 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59845 = lerp( tex2D( _Lightmap1, UV32_g59845 ) , tex2D( _Lightmap1, UV22_g59845 ) , W02_g59845);
					float4 lerpResult45_g59845 = lerp( tex2D( _Lightmap1, UV12_g59845 ) , tex2D( _Lightmap1, UV02_g59845 ) , W02_g59845);
					float4 lerpResult44_g59845 = lerp( lerpResult46_g59845 , lerpResult45_g59845 , W12_g59845);
					float4 Output_2D_Auto131_g59845 = lerpResult44_g59845;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g59838 = Output_2D_Auto131_g59845;
					#else
					float4 staticSwitch1088_g59838 = tex2D( _Lightmap1, UV0B2361_g59838 );
					#endif
					float4 Lightmap_1956_g59838 = staticSwitch1088_g59838;
					float Lightmap_Lerp_Value969_g59838 = _UdonLightmapLerp;
					float4 lerpResult442_g59838 = lerp( Lightmap_0925_g59838 , Lightmap_1956_g59838 , Lightmap_Lerp_Value969_g59838);
					float4 Lightmap_Lerp932_g59838 = lerpResult442_g59838;
					float3 appendResult139_g59884 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 Normal_Map318_g59884 = Normal_Map700_g59838;
					float dotResult121_g59884 = dot( appendResult139_g59884 , Normal_Map318_g59884 );
					float temp_output_2_0_g59886 = saturate( dotResult121_g59884 );
					float localStochasticTiling2_g59869 = ( 0.0 );
					float2 UV2_g59869 = UV0B2361_g59838;
					float4 TexelSize2_g59869 = _UdonRNMX0_TexelSize;
					float4 Offsets2_g59869 = float4( 0,0,0,0 );
					float2 Weights2_g59869 = float2( 0,0 );
					{
					UV2_g59869 = UV2_g59869 * TexelSize2_g59869.zw - 0.5;
					float2 f = frac( UV2_g59869 );
					UV2_g59869 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g59869.x - 0.5, UV2_g59869.x + 1.5, UV2_g59869.y - 0.5, UV2_g59869.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g59869 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59869.xyxy;
					Weights2_g59869 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g59868 = Offsets2_g59869;
					float4 Input_FetchOffsets197_g59870 = temp_output_1_34_g59868;
					float2 temp_output_1_54_g59868 = Weights2_g59869;
					float2 Input_FetchWeights200_g59870 = temp_output_1_54_g59868;
					float2 break187_g59870 = Input_FetchWeights200_g59870;
					float4 lerpResult181_g59870 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g59870).yw ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g59870).xw ) , break187_g59870.x);
					float4 lerpResult182_g59870 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g59870).yz ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g59870).xz ) , break187_g59870.x);
					float4 lerpResult176_g59870 = lerp( lerpResult181_g59870 , lerpResult182_g59870 , break187_g59870.y);
					float4 Output_Fetch2D_Auto202_g59870 = lerpResult176_g59870;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g59838 = Output_Fetch2D_Auto202_g59870;
					#else
					float4 staticSwitch1061_g59838 = tex2D( _UdonRNMX0, UV0B2361_g59838 );
					#endif
					float3 appendResult146_g59884 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59884 = dot( appendResult146_g59884 , Normal_Map318_g59884 );
					float temp_output_2_0_g59885 = saturate( dotResult122_g59884 );
					float4 Input_FetchOffsets197_g59871 = temp_output_1_34_g59868;
					float2 Input_FetchWeights200_g59871 = temp_output_1_54_g59868;
					float2 break187_g59871 = Input_FetchWeights200_g59871;
					float4 lerpResult181_g59871 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g59871).yw ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g59871).xw ) , break187_g59871.x);
					float4 lerpResult182_g59871 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g59871).yz ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g59871).xz ) , break187_g59871.x);
					float4 lerpResult176_g59871 = lerp( lerpResult181_g59871 , lerpResult182_g59871 , break187_g59871.y);
					float4 Output_Fetch2D_Auto202_g59871 = lerpResult176_g59871;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g59838 = Output_Fetch2D_Auto202_g59871;
					#else
					float4 staticSwitch1062_g59838 = tex2D( _UdonRNMY0, UV0B2361_g59838 );
					#endif
					float3 appendResult149_g59884 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59884 = dot( appendResult149_g59884 , Normal_Map318_g59884 );
					float temp_output_2_0_g59887 = saturate( dotResult120_g59884 );
					float4 Input_FetchOffsets197_g59872 = temp_output_1_34_g59868;
					float2 Input_FetchWeights200_g59872 = temp_output_1_54_g59868;
					float2 break187_g59872 = Input_FetchWeights200_g59872;
					float4 lerpResult181_g59872 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g59872).yw ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g59872).xw ) , break187_g59872.x);
					float4 lerpResult182_g59872 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g59872).yz ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g59872).xz ) , break187_g59872.x);
					float4 lerpResult176_g59872 = lerp( lerpResult181_g59872 , lerpResult182_g59872 , break187_g59872.y);
					float4 Output_Fetch2D_Auto202_g59872 = lerpResult176_g59872;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g59838 = Output_Fetch2D_Auto202_g59872;
					#else
					float4 staticSwitch1063_g59838 = tex2D( _UdonRNMZ0, UV0B2361_g59838 );
					#endif
					float4 temp_output_24_0_g59884 = ( ( ( ( temp_output_2_0_g59886 * temp_output_2_0_g59886 ) * staticSwitch1061_g59838 ) + ( ( temp_output_2_0_g59885 * temp_output_2_0_g59885 ) * staticSwitch1062_g59838 ) ) + ( ( temp_output_2_0_g59887 * temp_output_2_0_g59887 ) * staticSwitch1063_g59838 ) );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch372_g59884 = ( temp_output_24_0_g59884 * 1.2 );
					#else
					float4 staticSwitch372_g59884 = temp_output_24_0_g59884;
					#endif
					float4 RNM_0926_g59838 = staticSwitch372_g59884;
					float3 appendResult139_g59880 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 Normal_Map318_g59880 = Normal_Map700_g59838;
					float dotResult121_g59880 = dot( appendResult139_g59880 , Normal_Map318_g59880 );
					float temp_output_2_0_g59882 = saturate( dotResult121_g59880 );
					float localStochasticTiling2_g59840 = ( 0.0 );
					float2 UV2_g59840 = UV0B2361_g59838;
					float4 TexelSize2_g59840 = _UdonRNMX1_TexelSize;
					float4 Offsets2_g59840 = float4( 0,0,0,0 );
					float2 Weights2_g59840 = float2( 0,0 );
					{
					UV2_g59840 = UV2_g59840 * TexelSize2_g59840.zw - 0.5;
					float2 f = frac( UV2_g59840 );
					UV2_g59840 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g59840.x - 0.5, UV2_g59840.x + 1.5, UV2_g59840.y - 0.5, UV2_g59840.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g59840 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59840.xyxy;
					Weights2_g59840 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g59839 = Offsets2_g59840;
					float4 Input_FetchOffsets197_g59841 = temp_output_1_34_g59839;
					float2 temp_output_1_54_g59839 = Weights2_g59840;
					float2 Input_FetchWeights200_g59841 = temp_output_1_54_g59839;
					float2 break187_g59841 = Input_FetchWeights200_g59841;
					float4 lerpResult181_g59841 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g59841).yw ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g59841).xw ) , break187_g59841.x);
					float4 lerpResult182_g59841 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g59841).yz ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g59841).xz ) , break187_g59841.x);
					float4 lerpResult176_g59841 = lerp( lerpResult181_g59841 , lerpResult182_g59841 , break187_g59841.y);
					float4 Output_Fetch2D_Auto202_g59841 = lerpResult176_g59841;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g59838 = Output_Fetch2D_Auto202_g59841;
					#else
					float4 staticSwitch1087_g59838 = tex2D( _UdonRNMX1, UV0B2361_g59838 );
					#endif
					float3 appendResult146_g59880 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59880 = dot( appendResult146_g59880 , Normal_Map318_g59880 );
					float temp_output_2_0_g59881 = saturate( dotResult122_g59880 );
					float4 Input_FetchOffsets197_g59842 = temp_output_1_34_g59839;
					float2 Input_FetchWeights200_g59842 = temp_output_1_54_g59839;
					float2 break187_g59842 = Input_FetchWeights200_g59842;
					float4 lerpResult181_g59842 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g59842).yw ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g59842).xw ) , break187_g59842.x);
					float4 lerpResult182_g59842 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g59842).yz ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g59842).xz ) , break187_g59842.x);
					float4 lerpResult176_g59842 = lerp( lerpResult181_g59842 , lerpResult182_g59842 , break187_g59842.y);
					float4 Output_Fetch2D_Auto202_g59842 = lerpResult176_g59842;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g59838 = Output_Fetch2D_Auto202_g59842;
					#else
					float4 staticSwitch1083_g59838 = tex2D( _UdonRNMY1, UV0B2361_g59838 );
					#endif
					float3 appendResult149_g59880 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59880 = dot( appendResult149_g59880 , Normal_Map318_g59880 );
					float temp_output_2_0_g59883 = saturate( dotResult120_g59880 );
					float4 Input_FetchOffsets197_g59843 = temp_output_1_34_g59839;
					float2 Input_FetchWeights200_g59843 = temp_output_1_54_g59839;
					float2 break187_g59843 = Input_FetchWeights200_g59843;
					float4 lerpResult181_g59843 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g59843).yw ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g59843).xw ) , break187_g59843.x);
					float4 lerpResult182_g59843 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g59843).yz ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g59843).xz ) , break187_g59843.x);
					float4 lerpResult176_g59843 = lerp( lerpResult181_g59843 , lerpResult182_g59843 , break187_g59843.y);
					float4 Output_Fetch2D_Auto202_g59843 = lerpResult176_g59843;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g59838 = Output_Fetch2D_Auto202_g59843;
					#else
					float4 staticSwitch1084_g59838 = tex2D( _UdonRNMZ1, UV0B2361_g59838 );
					#endif
					float4 temp_output_24_0_g59880 = ( ( ( ( temp_output_2_0_g59882 * temp_output_2_0_g59882 ) * staticSwitch1087_g59838 ) + ( ( temp_output_2_0_g59881 * temp_output_2_0_g59881 ) * staticSwitch1083_g59838 ) ) + ( ( temp_output_2_0_g59883 * temp_output_2_0_g59883 ) * staticSwitch1084_g59838 ) );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch372_g59880 = ( temp_output_24_0_g59880 * 1.2 );
					#else
					float4 staticSwitch372_g59880 = temp_output_24_0_g59880;
					#endif
					float4 RNM_11081_g59838 = staticSwitch372_g59880;
					float4 lerpResult953_g59838 = lerp( RNM_0926_g59838 , RNM_11081_g59838 , Lightmap_Lerp_Value969_g59838);
					float4 RNM_Lerp950_g59838 = lerpResult953_g59838;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g59838 = temp_cast_4;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g59838 = Lightmap_0925_g59838;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g59838 = Lightmap_Lerp932_g59838;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g59838 = RNM_0926_g59838;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g59838 = RNM_Lerp950_g59838;
					#else
					float4 staticSwitch1014_g59838 = temp_cast_4;
					#endif
					float3 Lightmap46_g59838 = (staticSwitch1014_g59838).rgb;
					float3 temp_output_6_0_g59888 = Lightmap46_g59838;
					float grayscale4_g59888 = Luminance( temp_output_6_0_g59888 );
					float smoothstepResult2_g59888 = smoothstep( 0.0 , 0.04 , grayscale4_g59888);
					#ifdef _USELIGHTMAPPEDREFLECTIONS_ON
					float3 staticSwitch1469_g59838 = ( temp_output_2958_0_g59838 * smoothstepResult2_g59888 );
					#else
					float3 staticSwitch1469_g59838 = temp_output_2958_0_g59838;
					#endif
					#ifdef _INDIRECTSPECULARS_ON
					float3 staticSwitch2971_g59838 = staticSwitch1469_g59838;
					#else
					float3 staticSwitch2971_g59838 = temp_cast_2;
					#endif
					float3 Indirect_Specular1419_g59838 = staticSwitch2971_g59838;
					float3 temp_cast_6 = (Black1185_g59838).xxx;
					float3 Color97_g59895 = oAlbedo6_g59838;
					float Metallic97_g59895 = Metallic1239_g59838;
					float Smoothness97_g59895 = Smoothness1399_g59838;
					float3 Lightmap97_g59895 = Lightmap46_g59838;
					float3 ViewDir97_g59895 = View_Direction2511_g59838;
					float3 WorldPos97_g59895 = World_Position2505_g59838;
					float3 WorldNormal97_g59895 = World_Normal2508_g59838;
					float3 localDirectSpecular97_g59895 = DirectSpecular( Color97_g59895 , Metallic97_g59895 , Smoothness97_g59895 , Lightmap97_g59895 , ViewDir97_g59895 , WorldPos97_g59895 , WorldNormal97_g59895 );
					#ifdef _DIRECTSPECULAR_ON
					float3 staticSwitch2969_g59838 = localDirectSpecular97_g59895;
					#else
					float3 staticSwitch2969_g59838 = temp_cast_6;
					#endif
					float3 Direct_Specular2560_g59838 = staticSwitch2969_g59838;
					float3 aAlbedo1466_g59838 = ( temp_output_2532_0_g59838 * ( 1.0 - Metallic1239_g59838 ) );
					float3 temp_output_1252_0_g59838 = ( aAlbedo1466_g59838 * Lightmap46_g59838 );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch1_g59890 = float4( ( temp_output_1252_0_g59838 + Emission86_g59838 + Indirect_Specular1419_g59838 ) , 0.0 );
					#else
					float4 staticSwitch1_g59890 = float4( ( Emission86_g59838 + Indirect_Specular1419_g59838 + Direct_Specular2560_g59838 + temp_output_1252_0_g59838 ) , 0.0 );
					#endif
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1181_g59838 = float4( Lightmap46_g59838 , 0.0 );
					#else
					float4 staticSwitch1181_g59838 = staticSwitch1_g59890;
					#endif
					float4 Color357_g59878 = staticSwitch1181_g59838;
					float4 LUT51_g59878 = tex3D( _LUT, ( ( log10( ( ( (Color357_g59878).xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 ) );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch359_g59878 = LUT51_g59878;
					#else
					float4 staticSwitch359_g59878 = Color357_g59878;
					#endif
					
					#ifdef _LIGHTMAPDEBUG
					float staticSwitch1191_g59838 = White38_g59838;
					#else
					float staticSwitch1191_g59838 = staticSwitch1001_g59838.a;
					#endif
					

					o.Albedo = staticSwitch1180_g59838;
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

					o.Emission = staticSwitch359_g59878.xyz;
					o.Alpha = staticSwitch1191_g59838;
					half AlphaClipThreshold = _MaskClipValue;
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
				#define ASE_NO_AMBIENT 1
				#define ASE_LIGHTING_SIMPLE 1
				#define _ALPHATEST_ON
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

				#define ASE_NEEDS_VERT_NORMAL
				#define ASE_NEEDS_TEXTURE_COORDINATES2
				#pragma shader_feature _LIGHTMAPDEBUG
				#pragma shader_feature_local _STOCHASTICENABLED_ON
				#pragma shader_feature_local _MAINTEX


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
				sampler2D _Sampler82966_g59838;
				uniform float _MaskClipValue;


				
				v2f VertexFunction( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 World_Position2505_g59838 = ase_positionWS;
					
					o.ase_texcoord1.xy = v.texcoord2.xyzw.xy;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord1.zw = 0;

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = ( v.normal * ( distance( World_Position2505_g59838 , _WorldSpaceCameraPos ) * 0.0005 ) );
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

					float2 texCoord2594_g59838 = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV22595_g59838 = texCoord2594_g59838;
					#ifdef _MAINTEX
					float4 staticSwitch1549_g59838 = tex2D( _MainTex, UV22595_g59838 );
					#else
					float4 staticSwitch1549_g59838 = _Color;
					#endif
					float2 temp_output_5_0_g59853 = UV22595_g59838;
					float2 UV633_g59853 = temp_output_5_0_g59853;
					float2 UV100_g59854 = UV633_g59853;
					float2 temp_output_51_0_g59854 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59854 * float2( 3.464,3.464 ) ) );
					float2 break55_g59854 = frac( temp_output_51_0_g59854 );
					float temp_output_56_0_g59854 = ( ( 1.0 - break55_g59854.x ) - break55_g59854.y );
					float2 temp_output_52_0_g59854 = floor( temp_output_51_0_g59854 );
					float2 temp_output_125_0_g59854 = ( temp_output_52_0_g59854 + float2( 1,1 ) );
					float2 ifLocalVar87_g59854 = 0;
					if( temp_output_56_0_g59854 > 0.0 )
					ifLocalVar87_g59854 = temp_output_52_0_g59854;
					else if( temp_output_56_0_g59854 == 0.0 )
					ifLocalVar87_g59854 = temp_output_125_0_g59854;
					else if( temp_output_56_0_g59854 < 0.0 )
					ifLocalVar87_g59854 = temp_output_125_0_g59854;
					float3 temp_output_7_0_g59855 = frac( ( (ifLocalVar87_g59854).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59855 = dot( temp_output_7_0_g59855 , ( (temp_output_7_0_g59855).yzx + 33.33 ) );
					float3 temp_output_12_0_g59855 = ( temp_output_7_0_g59855 + dotResult8_g59855 );
					float2 temp_output_597_0_g59853 = ( UV100_g59854 + frac( ( ( (temp_output_12_0_g59855).xx + (temp_output_12_0_g59855).yz ) * (temp_output_12_0_g59855).zy ) ) );
					float2 DDX631_g59853 = ddx( temp_output_5_0_g59853 );
					float2 DDY632_g59853 = ddy( temp_output_5_0_g59853 );
					float temp_output_65_0_g59854 = ( 0.0 - temp_output_56_0_g59854 );
					float ifLocalVar59_g59854 = 0;
					if( temp_output_56_0_g59854 <= 0.0 )
					ifLocalVar59_g59854 = temp_output_65_0_g59854;
					else
					ifLocalVar59_g59854 = temp_output_56_0_g59854;
					float temp_output_597_30_g59853 = ifLocalVar59_g59854;
					float2 temp_output_90_0_g59854 = ( temp_output_52_0_g59854 + float2( 0,1 ) );
					float2 temp_output_123_0_g59854 = ( temp_output_52_0_g59854 + float2( 1,0 ) );
					float2 ifLocalVar88_g59854 = 0;
					if( temp_output_56_0_g59854 > 0.0 )
					ifLocalVar88_g59854 = temp_output_90_0_g59854;
					else if( temp_output_56_0_g59854 == 0.0 )
					ifLocalVar88_g59854 = temp_output_123_0_g59854;
					else if( temp_output_56_0_g59854 < 0.0 )
					ifLocalVar88_g59854 = temp_output_123_0_g59854;
					float3 temp_output_7_0_g59856 = frac( ( (ifLocalVar88_g59854).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59856 = dot( temp_output_7_0_g59856 , ( (temp_output_7_0_g59856).yzx + 33.33 ) );
					float3 temp_output_12_0_g59856 = ( temp_output_7_0_g59856 + dotResult8_g59856 );
					float2 temp_output_597_26_g59853 = ( UV100_g59854 + frac( ( ( (temp_output_12_0_g59856).xx + (temp_output_12_0_g59856).yz ) * (temp_output_12_0_g59856).zy ) ) );
					float temp_output_66_0_g59854 = ( 1.0 - break55_g59854.y );
					float ifLocalVar60_g59854 = 0;
					if( temp_output_56_0_g59854 <= 0.0 )
					ifLocalVar60_g59854 = temp_output_66_0_g59854;
					else
					ifLocalVar60_g59854 = break55_g59854.y;
					float temp_output_597_28_g59853 = ifLocalVar60_g59854;
					float2 ifLocalVar89_g59854 = 0;
					if( temp_output_56_0_g59854 > 0.0 )
					ifLocalVar89_g59854 = temp_output_123_0_g59854;
					else if( temp_output_56_0_g59854 == 0.0 )
					ifLocalVar89_g59854 = temp_output_90_0_g59854;
					else if( temp_output_56_0_g59854 < 0.0 )
					ifLocalVar89_g59854 = temp_output_90_0_g59854;
					float3 temp_output_7_0_g59857 = frac( ( (ifLocalVar89_g59854).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59857 = dot( temp_output_7_0_g59857 , ( (temp_output_7_0_g59857).yzx + 33.33 ) );
					float3 temp_output_12_0_g59857 = ( temp_output_7_0_g59857 + dotResult8_g59857 );
					float2 temp_output_597_27_g59853 = ( UV100_g59854 + frac( ( ( (temp_output_12_0_g59857).xx + (temp_output_12_0_g59857).yz ) * (temp_output_12_0_g59857).zy ) ) );
					float temp_output_67_0_g59854 = ( 1.0 - break55_g59854.x );
					float ifLocalVar61_g59854 = 0;
					if( temp_output_56_0_g59854 <= 0.0 )
					ifLocalVar61_g59854 = temp_output_67_0_g59854;
					else
					ifLocalVar61_g59854 = break55_g59854.x;
					float temp_output_597_29_g59853 = ifLocalVar61_g59854;
					float4 Output_2D293_g59853 = ( ( tex2D( _Sampler82966_g59838, temp_output_597_0_g59853, DDX631_g59853, DDY632_g59853 ) * temp_output_597_30_g59853 ) + ( tex2D( _Sampler82966_g59838, temp_output_597_26_g59853, DDX631_g59853, DDY632_g59853 ) * temp_output_597_28_g59853 ) + ( tex2D( _Sampler82966_g59838, temp_output_597_27_g59853, DDX631_g59853, DDY632_g59853 ) * temp_output_597_29_g59853 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g59838 = Output_2D293_g59853;
					#else
					float4 staticSwitch1001_g59838 = staticSwitch1549_g59838;
					#endif
					float White38_g59838 = 1.0;
					#ifdef _LIGHTMAPDEBUG
					float staticSwitch1191_g59838 = White38_g59838;
					#else
					float staticSwitch1191_g59838 = staticSwitch1001_g59838.a;
					#endif
					

					o.Normal = half3( 0, 0, 1 );

					o.Alpha = staticSwitch1191_g59838;
					half AlphaClipThreshold = _MaskClipValue;
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
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3018;192,-1200;Inherit;False;Meenphie;0;;59838;b3ba55a08dd6b49c7be16c6f35cf2033;6,1008,1,2632,1,2635,1,2619,1,2636,1,2670,1;0;5;FLOAT3;625;FLOAT4;624;FLOAT;156;FLOAT;427;FLOAT3;1024
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2889;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;True;1;LightMode=ForwardAdd;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2890;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2891;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2892;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2893;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2894;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ScenePickingPass;0;7;ScenePickingPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=Picking;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2888;512,-1200;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;Meenphie/Standard/Decal/Cutout;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardBase;0;1;ForwardBase;17;True;True;0;1;False;;1;False;;0;1;False;;1;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=AlphaTest=Queue=1;DisableBatching=False=DisableBatching;True;3;True;12;all;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;44;Category;0;0;  Instanced Terrain Normals;1;0;Workflow;3;639057697570214470;Surface;0;639101656602007940;  Blend;2;639101656407308560;  Dither Shadows;1;0;Two Sided;1;639101642247268830;Alpha Clipping;1;639101657755960190;  Use Shadow Threshold;0;638915420933436960;Deferred Pass;0;638915425282396370;Normal Space;0;0;Transmission;0;638915425258747670;  Transmission Shadow;0.5,False,;0;Translucency;0;638915425246861880;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;1;638922399804812020;Receive Shadows;0;638922399717523500;Receive Specular;0;638915388784334560;Receive Reflections;1;638915388803555030;GPU Instancing;1;638915411619689990;LOD CrossFade;1;0;Built-in Fog;1;0;Ambient Light;0;639049545902984550;Meta Pass;0;639048817054746750;Add Pass;0;639048817051401800;Override Baked GI;0;638915390973737640;Write Depth;0;638915421117196140;Extra Pre Pass;0;639048817123696260;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;0;Vertex Position;1;0;0;8;False;True;False;False;False;True;False;False;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2887;512,-1440;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;True;12;all;0;True;True;0;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;True;True;1;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;0;False;;True;3;False;;True;False;0;False;;0;False;;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;0;False;0
WireConnection;2888;0;3018;625
WireConnection;2888;2;3018;624
WireConnection;2888;7;3018;156
WireConnection;2888;8;3018;427
WireConnection;2888;15;3018;1024
ASEEND*/
//CHKSM=355CE048EC47FC772786941936FBF4C9AA38038B