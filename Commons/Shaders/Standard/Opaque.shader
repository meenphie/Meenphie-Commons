// Made with Amplify Shader Editor v1.9.9.5
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Standard/Opaque"
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
		[Meenphie_DrawerCategory(OUTLINE,true,0,0)] _CATEGORYOUTLINE1( "CATEGORY OUTLINE", Float ) = 0
		[Toggle( _OUTLINEENABLED_ON )] _OutlineEnabled( "Outline Enabled", Float ) = 1
		_OutlineColor( "Outline Color", Color ) = ( 0.1, 0.1, 0.1 )
		_OutlineWidth( "Outline Width", Range( 0, 0.01 ) ) = 0.00025
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACEOUTLINE1( "CATEGORY SPACE OUTLINE", Float ) = 0
		[HideInInspector] GenKey__2DLut( "Assign keyword _2DLUT", Float ) = 1.0
		[HideInInspector] GenKey__MetallicMap( "Assign keyword _METALLICMAP", Float ) = 1.0
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0
		[HideInInspector] GenKey__MainTex( "Assign keyword _MAINTEX", Float ) = 1.0
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
			Name "ExtraPrePass"
			Tags { "LightMode"="ForwardBase" }

			Blend Off
			Cull Front
			ZWrite On
			ZTest LEqual
			Offset 0,0
			ColorMask RGBA

			

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

				#define ASE_NEEDS_VERT_NORMAL
				#pragma shader_feature _LIGHTMAPDEBUG
				#pragma shader_feature_local _OUTLINEENABLED_ON


				struct appdata
				{
					float4 vertex : POSITION;
					half3 normal : NORMAL;
					half4 tangent : TANGENT;
					float4 texcoord1 : TEXCOORD1;
					float4 texcoord2 : TEXCOORD2;
					float4 ase_color : COLOR;
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct v2f
				{
					float4 pos : SV_POSITION;
					float4 worldPos : TEXCOORD0; // xyz = positionWS, w = fogCoord
					half3 normalWS : TEXCOORD1;
					half4 tangentWS : TEXCOORD2;
					UNITY_LIGHTING_COORDS( 3, 4 )
					
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
				uniform sampler2D _2DLut;
				uniform float _LUTSize;
				uniform sampler3D _3DLut;
				uniform float _CATEGORYSPACECOLORGRADING;
				uniform float _CATEGORYCOLORGRADING;
				uniform float _CATEGORYSPACESPECIALEFFECTS;
				uniform float _CATEGORYSPECIALEFFECTS;
				uniform float _OutlineWidth;
				uniform float _CATEGORYOUTLINE1;
				uniform float _CATEGORYSPACEOUTLINE1;
				uniform float3 _OutlineColor;


				
				v2f VertexFunction (appdata v  ) {
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					float3 temp_cast_0 = (asfloat( -1 )).xxx;
					float Outline_GUI6_g65392 = ( _CATEGORYOUTLINE1 + _CATEGORYSPACEOUTLINE1 );
					float3 temp_cast_1 = (Outline_GUI6_g65392).xxx;
					float3 lerpResult11_g65392 = lerp( ( _OutlineWidth * v.normal * (v.ase_color).rgb ) , temp_cast_1 , float3( 0,0,0 ));
					#ifdef _OUTLINEENABLED_ON
					float3 staticSwitch13_g65392 = lerpResult11_g65392;
					#else
					float3 staticSwitch13_g65392 = temp_cast_0;
					#endif
					float3 temp_cast_2 = (asfloat( -1 )).xxx;
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch19_g65392 = temp_cast_2;
					#else
					float3 staticSwitch19_g65392 = staticSwitch13_g65392;
					#endif
					

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = staticSwitch19_g65392;
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
					float4 texcoord1 : TEXCOORD1;
					float4 texcoord2 : TEXCOORD2;
					float4 ase_color : COLOR;

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
					o.ase_color = v.ase_color;
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
					o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
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

					

					half3 Color = _OutlineColor;
					half Alpha = 1;
					half AlphaClipThreshold = 0.5;

					#if defined( ASE_DEPTH_WRITE_ON )
						float DeviceDepth = IN.pos.z;
					#endif

					half4 c = half4( Color, Alpha );

					#ifdef _ALPHATEST_ON
						clip( Alpha - AlphaClipThreshold );
					#endif

					#if defined( ASE_DEPTH_WRITE_ON )
						outputDepth = DeviceDepth;
					#endif

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
			
			Name "ForwardBase"
			Tags { "LightMode"="ForwardBase" }

			Blend Off

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
				uniform sampler2D _2DLut;
				uniform float _LUTSize;
				uniform sampler3D _3DLut;
				uniform float _CATEGORYSPACECOLORGRADING;
				uniform float _CATEGORYCOLORGRADING;
				uniform float _CATEGORYSPACESPECIALEFFECTS;
				uniform float _CATEGORYSPECIALEFFECTS;
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

					float2 uv_MainTex907_g92033 = IN.ase_texcoord6.xy;
					float2 uv_MainTex = IN.ase_texcoord6.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					float2 temp_output_5_0_g92044 = uv_MainTex;
					float2 UV633_g92044 = temp_output_5_0_g92044;
					float2 UV100_g92045 = UV633_g92044;
					float2 temp_output_51_0_g92045 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g92045 * float2( 3.464,3.464 ) ) );
					float2 break55_g92045 = frac( temp_output_51_0_g92045 );
					float temp_output_56_0_g92045 = ( ( 1.0 - break55_g92045.x ) - break55_g92045.y );
					float2 temp_output_52_0_g92045 = floor( temp_output_51_0_g92045 );
					float2 temp_output_125_0_g92045 = ( temp_output_52_0_g92045 + float2( 1,1 ) );
					float2 ifLocalVar87_g92045 = 0;
					if( temp_output_56_0_g92045 > 0.0 )
					ifLocalVar87_g92045 = temp_output_52_0_g92045;
					else if( temp_output_56_0_g92045 == 0.0 )
					ifLocalVar87_g92045 = temp_output_125_0_g92045;
					else if( temp_output_56_0_g92045 < 0.0 )
					ifLocalVar87_g92045 = temp_output_125_0_g92045;
					float3 temp_output_7_0_g92046 = frac( ( (ifLocalVar87_g92045).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g92046 = dot( temp_output_7_0_g92046 , ( (temp_output_7_0_g92046).yzx + 33.33 ) );
					float3 temp_output_12_0_g92046 = ( temp_output_7_0_g92046 + dotResult8_g92046 );
					float2 temp_output_597_0_g92044 = ( UV100_g92045 + frac( ( ( (temp_output_12_0_g92046).xx + (temp_output_12_0_g92046).yz ) * (temp_output_12_0_g92046).zy ) ) );
					float2 DDX631_g92044 = ddx( temp_output_5_0_g92044 );
					float2 DDY632_g92044 = ddy( temp_output_5_0_g92044 );
					float temp_output_65_0_g92045 = ( 0.0 - temp_output_56_0_g92045 );
					float ifLocalVar59_g92045 = 0;
					if( temp_output_56_0_g92045 <= 0.0 )
					ifLocalVar59_g92045 = temp_output_65_0_g92045;
					else
					ifLocalVar59_g92045 = temp_output_56_0_g92045;
					float temp_output_597_30_g92044 = ifLocalVar59_g92045;
					float2 temp_output_90_0_g92045 = ( temp_output_52_0_g92045 + float2( 0,1 ) );
					float2 temp_output_123_0_g92045 = ( temp_output_52_0_g92045 + float2( 1,0 ) );
					float2 ifLocalVar88_g92045 = 0;
					if( temp_output_56_0_g92045 > 0.0 )
					ifLocalVar88_g92045 = temp_output_90_0_g92045;
					else if( temp_output_56_0_g92045 == 0.0 )
					ifLocalVar88_g92045 = temp_output_123_0_g92045;
					else if( temp_output_56_0_g92045 < 0.0 )
					ifLocalVar88_g92045 = temp_output_123_0_g92045;
					float3 temp_output_7_0_g92047 = frac( ( (ifLocalVar88_g92045).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g92047 = dot( temp_output_7_0_g92047 , ( (temp_output_7_0_g92047).yzx + 33.33 ) );
					float3 temp_output_12_0_g92047 = ( temp_output_7_0_g92047 + dotResult8_g92047 );
					float2 temp_output_597_26_g92044 = ( UV100_g92045 + frac( ( ( (temp_output_12_0_g92047).xx + (temp_output_12_0_g92047).yz ) * (temp_output_12_0_g92047).zy ) ) );
					float temp_output_66_0_g92045 = ( 1.0 - break55_g92045.y );
					float ifLocalVar60_g92045 = 0;
					if( temp_output_56_0_g92045 <= 0.0 )
					ifLocalVar60_g92045 = temp_output_66_0_g92045;
					else
					ifLocalVar60_g92045 = break55_g92045.y;
					float temp_output_597_28_g92044 = ifLocalVar60_g92045;
					float2 ifLocalVar89_g92045 = 0;
					if( temp_output_56_0_g92045 > 0.0 )
					ifLocalVar89_g92045 = temp_output_123_0_g92045;
					else if( temp_output_56_0_g92045 == 0.0 )
					ifLocalVar89_g92045 = temp_output_90_0_g92045;
					else if( temp_output_56_0_g92045 < 0.0 )
					ifLocalVar89_g92045 = temp_output_90_0_g92045;
					float3 temp_output_7_0_g92048 = frac( ( (ifLocalVar89_g92045).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g92048 = dot( temp_output_7_0_g92048 , ( (temp_output_7_0_g92048).yzx + 33.33 ) );
					float3 temp_output_12_0_g92048 = ( temp_output_7_0_g92048 + dotResult8_g92048 );
					float2 temp_output_597_27_g92044 = ( UV100_g92045 + frac( ( ( (temp_output_12_0_g92048).xx + (temp_output_12_0_g92048).yz ) * (temp_output_12_0_g92048).zy ) ) );
					float temp_output_67_0_g92045 = ( 1.0 - break55_g92045.x );
					float ifLocalVar61_g92045 = 0;
					if( temp_output_56_0_g92045 <= 0.0 )
					ifLocalVar61_g92045 = temp_output_67_0_g92045;
					else
					ifLocalVar61_g92045 = break55_g92045.x;
					float temp_output_597_29_g92044 = ifLocalVar61_g92045;
					float4 Output_2D293_g92044 = ( ( tex2D( _MainTex, temp_output_597_0_g92044, DDX631_g92044, DDY632_g92044 ) * temp_output_597_30_g92044 ) + ( tex2D( _MainTex, temp_output_597_26_g92044, DDX631_g92044, DDY632_g92044 ) * temp_output_597_28_g92044 ) + ( tex2D( _MainTex, temp_output_597_27_g92044, DDX631_g92044, DDY632_g92044 ) * temp_output_597_29_g92044 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g92033 = Output_2D293_g92044;
					#else
					float4 staticSwitch1001_g92033 = tex2D( _MainTex, uv_MainTex907_g92033 );
					#endif
					#ifdef _MAINTEX
					float4 staticSwitch1549_g92033 = staticSwitch1001_g92033;
					#else
					float4 staticSwitch1549_g92033 = _Color;
					#endif
					float4 oAlbedo6_g92033 = staticSwitch1549_g92033;
					float Black1185_g92033 = 0.0;
					float4 temp_cast_0 = (Black1185_g92033).xxxx;
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1180_g92033 = temp_cast_0;
					#else
					float4 staticSwitch1180_g92033 = oAlbedo6_g92033;
					#endif
					
					float2 uv_MetallicMap48_g92033 = IN.ase_texcoord6.xy;
					float2 uv_MetallicMap = IN.ase_texcoord6.xy * _MetallicMap_ST.xy + _MetallicMap_ST.zw;
					float2 temp_output_5_0_g92063 = uv_MetallicMap;
					float2 UV633_g92063 = temp_output_5_0_g92063;
					float2 UV100_g92064 = UV633_g92063;
					float2 temp_output_51_0_g92064 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g92064 * float2( 3.464,3.464 ) ) );
					float2 break55_g92064 = frac( temp_output_51_0_g92064 );
					float temp_output_56_0_g92064 = ( ( 1.0 - break55_g92064.x ) - break55_g92064.y );
					float2 temp_output_52_0_g92064 = floor( temp_output_51_0_g92064 );
					float2 temp_output_125_0_g92064 = ( temp_output_52_0_g92064 + float2( 1,1 ) );
					float2 ifLocalVar87_g92064 = 0;
					if( temp_output_56_0_g92064 > 0.0 )
					ifLocalVar87_g92064 = temp_output_52_0_g92064;
					else if( temp_output_56_0_g92064 == 0.0 )
					ifLocalVar87_g92064 = temp_output_125_0_g92064;
					else if( temp_output_56_0_g92064 < 0.0 )
					ifLocalVar87_g92064 = temp_output_125_0_g92064;
					float3 temp_output_7_0_g92065 = frac( ( (ifLocalVar87_g92064).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g92065 = dot( temp_output_7_0_g92065 , ( (temp_output_7_0_g92065).yzx + 33.33 ) );
					float3 temp_output_12_0_g92065 = ( temp_output_7_0_g92065 + dotResult8_g92065 );
					float2 temp_output_597_0_g92063 = ( UV100_g92064 + frac( ( ( (temp_output_12_0_g92065).xx + (temp_output_12_0_g92065).yz ) * (temp_output_12_0_g92065).zy ) ) );
					float2 DDX631_g92063 = ddx( temp_output_5_0_g92063 );
					float2 DDY632_g92063 = ddy( temp_output_5_0_g92063 );
					float temp_output_65_0_g92064 = ( 0.0 - temp_output_56_0_g92064 );
					float ifLocalVar59_g92064 = 0;
					if( temp_output_56_0_g92064 <= 0.0 )
					ifLocalVar59_g92064 = temp_output_65_0_g92064;
					else
					ifLocalVar59_g92064 = temp_output_56_0_g92064;
					float temp_output_597_30_g92063 = ifLocalVar59_g92064;
					float2 temp_output_90_0_g92064 = ( temp_output_52_0_g92064 + float2( 0,1 ) );
					float2 temp_output_123_0_g92064 = ( temp_output_52_0_g92064 + float2( 1,0 ) );
					float2 ifLocalVar88_g92064 = 0;
					if( temp_output_56_0_g92064 > 0.0 )
					ifLocalVar88_g92064 = temp_output_90_0_g92064;
					else if( temp_output_56_0_g92064 == 0.0 )
					ifLocalVar88_g92064 = temp_output_123_0_g92064;
					else if( temp_output_56_0_g92064 < 0.0 )
					ifLocalVar88_g92064 = temp_output_123_0_g92064;
					float3 temp_output_7_0_g92066 = frac( ( (ifLocalVar88_g92064).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g92066 = dot( temp_output_7_0_g92066 , ( (temp_output_7_0_g92066).yzx + 33.33 ) );
					float3 temp_output_12_0_g92066 = ( temp_output_7_0_g92066 + dotResult8_g92066 );
					float2 temp_output_597_26_g92063 = ( UV100_g92064 + frac( ( ( (temp_output_12_0_g92066).xx + (temp_output_12_0_g92066).yz ) * (temp_output_12_0_g92066).zy ) ) );
					float temp_output_66_0_g92064 = ( 1.0 - break55_g92064.y );
					float ifLocalVar60_g92064 = 0;
					if( temp_output_56_0_g92064 <= 0.0 )
					ifLocalVar60_g92064 = temp_output_66_0_g92064;
					else
					ifLocalVar60_g92064 = break55_g92064.y;
					float temp_output_597_28_g92063 = ifLocalVar60_g92064;
					float2 ifLocalVar89_g92064 = 0;
					if( temp_output_56_0_g92064 > 0.0 )
					ifLocalVar89_g92064 = temp_output_123_0_g92064;
					else if( temp_output_56_0_g92064 == 0.0 )
					ifLocalVar89_g92064 = temp_output_90_0_g92064;
					else if( temp_output_56_0_g92064 < 0.0 )
					ifLocalVar89_g92064 = temp_output_90_0_g92064;
					float3 temp_output_7_0_g92067 = frac( ( (ifLocalVar89_g92064).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g92067 = dot( temp_output_7_0_g92067 , ( (temp_output_7_0_g92067).yzx + 33.33 ) );
					float3 temp_output_12_0_g92067 = ( temp_output_7_0_g92067 + dotResult8_g92067 );
					float2 temp_output_597_27_g92063 = ( UV100_g92064 + frac( ( ( (temp_output_12_0_g92067).xx + (temp_output_12_0_g92067).yz ) * (temp_output_12_0_g92067).zy ) ) );
					float temp_output_67_0_g92064 = ( 1.0 - break55_g92064.x );
					float ifLocalVar61_g92064 = 0;
					if( temp_output_56_0_g92064 <= 0.0 )
					ifLocalVar61_g92064 = temp_output_67_0_g92064;
					else
					ifLocalVar61_g92064 = break55_g92064.x;
					float temp_output_597_29_g92063 = ifLocalVar61_g92064;
					float4 Output_2D293_g92063 = ( ( tex2D( _MetallicMap, temp_output_597_0_g92063, DDX631_g92063, DDY632_g92063 ) * temp_output_597_30_g92063 ) + ( tex2D( _MetallicMap, temp_output_597_26_g92063, DDX631_g92063, DDY632_g92063 ) * temp_output_597_28_g92063 ) + ( tex2D( _MetallicMap, temp_output_597_27_g92063, DDX631_g92063, DDY632_g92063 ) * temp_output_597_29_g92063 ) );
					float4 break31_g92063 = Output_2D293_g92063;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g92033 = break31_g92063.a;
					#else
					float staticSwitch1005_g92033 = tex2D( _MetallicMap, uv_MetallicMap48_g92033 ).a;
					#endif
					#ifdef _METALLICMAP
					float staticSwitch846_g92033 = staticSwitch1005_g92033;
					#else
					float staticSwitch846_g92033 = _Metallic;
					#endif
					float Metallic1239_g92033 = staticSwitch846_g92033;
					float4 aAlbedo1466_g92033 = ( staticSwitch1549_g92033 * ( 1.0 - Metallic1239_g92033 ) );
					float White38_g92033 = 1.0;
					float4 temp_cast_2 = (White38_g92033).xxxx;
					float2 texCoord1093_g92033 = IN.ase_texcoord6.zw * float2( 1,1 ) + float2( 0,0 );
					float localBicubicPrepare2_g92057 = ( 0.0 );
					float2 uv3_Lightmap0 = IN.ase_texcoord6.zw * _Lightmap0_ST.xy + _Lightmap0_ST.zw;
					float2 Input_UV100_g92057 = uv3_Lightmap0;
					float2 UV2_g92057 = Input_UV100_g92057;
					float4 TexelSize2_g92057 = _Lightmap0_TexelSize;
					float2 UV02_g92057 = float2( 0,0 );
					float2 UV12_g92057 = float2( 0,0 );
					float2 UV22_g92057 = float2( 0,0 );
					float2 UV32_g92057 = float2( 0,0 );
					float W02_g92057 = 0;
					float W12_g92057 = 0;
					{
					{
					 UV2_g92057 = UV2_g92057 * TexelSize2_g92057.zw - 0.5;
					    float2 f = frac( UV2_g92057 );
					    UV2_g92057 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g92057.x - 0.5, UV2_g92057.x + 1.5, UV2_g92057.y - 0.5, UV2_g92057.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g92057.xyxy;
					    UV02_g92057 = off.xz;
					    UV12_g92057 = off.yz;
					    UV22_g92057 = off.xw;
					    UV32_g92057 = off.yw;
					    W02_g92057 = s.x / ( s.x + s.y );
					 W12_g92057 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g92057 = lerp( tex2D( _Lightmap0, UV32_g92057 ) , tex2D( _Lightmap0, UV22_g92057 ) , W02_g92057);
					float4 lerpResult45_g92057 = lerp( tex2D( _Lightmap0, UV12_g92057 ) , tex2D( _Lightmap0, UV02_g92057 ) , W02_g92057);
					float4 lerpResult44_g92057 = lerp( lerpResult46_g92057 , lerpResult45_g92057 , W12_g92057);
					float4 Output_2D131_g92057 = lerpResult44_g92057;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g92033 = Output_2D131_g92057;
					#else
					float4 staticSwitch1092_g92033 = tex2D( _Lightmap0, texCoord1093_g92033 );
					#endif
					float4 Lightmap_0925_g92033 = staticSwitch1092_g92033;
					float2 texCoord1090_g92033 = IN.ase_texcoord6.zw * float2( 1,1 ) + float2( 0,0 );
					float localBicubicPrepare2_g92055 = ( 0.0 );
					float2 uv3_Lightmap1 = IN.ase_texcoord6.zw * _Lightmap1_ST.xy + _Lightmap1_ST.zw;
					float2 Input_UV100_g92055 = uv3_Lightmap1;
					float2 UV2_g92055 = Input_UV100_g92055;
					float4 TexelSize2_g92055 = _Lightmap1_TexelSize;
					float2 UV02_g92055 = float2( 0,0 );
					float2 UV12_g92055 = float2( 0,0 );
					float2 UV22_g92055 = float2( 0,0 );
					float2 UV32_g92055 = float2( 0,0 );
					float W02_g92055 = 0;
					float W12_g92055 = 0;
					{
					{
					 UV2_g92055 = UV2_g92055 * TexelSize2_g92055.zw - 0.5;
					    float2 f = frac( UV2_g92055 );
					    UV2_g92055 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g92055.x - 0.5, UV2_g92055.x + 1.5, UV2_g92055.y - 0.5, UV2_g92055.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g92055.xyxy;
					    UV02_g92055 = off.xz;
					    UV12_g92055 = off.yz;
					    UV22_g92055 = off.xw;
					    UV32_g92055 = off.yw;
					    W02_g92055 = s.x / ( s.x + s.y );
					 W12_g92055 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g92055 = lerp( tex2D( _Lightmap1, UV32_g92055 ) , tex2D( _Lightmap1, UV22_g92055 ) , W02_g92055);
					float4 lerpResult45_g92055 = lerp( tex2D( _Lightmap1, UV12_g92055 ) , tex2D( _Lightmap1, UV02_g92055 ) , W02_g92055);
					float4 lerpResult44_g92055 = lerp( lerpResult46_g92055 , lerpResult45_g92055 , W12_g92055);
					float4 Output_2D131_g92055 = lerpResult44_g92055;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g92033 = Output_2D131_g92055;
					#else
					float4 staticSwitch1088_g92033 = tex2D( _Lightmap1, texCoord1090_g92033 );
					#endif
					float4 Lightmap_1956_g92033 = staticSwitch1088_g92033;
					float4 lerpResult442_g92033 = lerp( Lightmap_0925_g92033 , Lightmap_1956_g92033 , _LIGHTMAPLERP);
					float4 Lightmap_Lerp932_g92033 = lerpResult442_g92033;
					float3 appendResult139_g92080 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float2 uv_BumpMap830_g92033 = IN.ase_texcoord6.xy;
					float2 uv_BumpMap = IN.ase_texcoord6.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					float2 temp_output_5_0_g92039 = uv_BumpMap;
					float2 UV633_g92039 = temp_output_5_0_g92039;
					float2 UV100_g92040 = UV633_g92039;
					float2 temp_output_51_0_g92040 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g92040 * float2( 3.464,3.464 ) ) );
					float2 break55_g92040 = frac( temp_output_51_0_g92040 );
					float temp_output_56_0_g92040 = ( ( 1.0 - break55_g92040.x ) - break55_g92040.y );
					float2 temp_output_52_0_g92040 = floor( temp_output_51_0_g92040 );
					float2 temp_output_125_0_g92040 = ( temp_output_52_0_g92040 + float2( 1,1 ) );
					float2 ifLocalVar87_g92040 = 0;
					if( temp_output_56_0_g92040 > 0.0 )
					ifLocalVar87_g92040 = temp_output_52_0_g92040;
					else if( temp_output_56_0_g92040 == 0.0 )
					ifLocalVar87_g92040 = temp_output_125_0_g92040;
					else if( temp_output_56_0_g92040 < 0.0 )
					ifLocalVar87_g92040 = temp_output_125_0_g92040;
					float3 temp_output_7_0_g92041 = frac( ( (ifLocalVar87_g92040).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g92041 = dot( temp_output_7_0_g92041 , ( (temp_output_7_0_g92041).yzx + 33.33 ) );
					float3 temp_output_12_0_g92041 = ( temp_output_7_0_g92041 + dotResult8_g92041 );
					float2 temp_output_597_0_g92039 = ( UV100_g92040 + frac( ( ( (temp_output_12_0_g92041).xx + (temp_output_12_0_g92041).yz ) * (temp_output_12_0_g92041).zy ) ) );
					float2 DDX631_g92039 = ddx( temp_output_5_0_g92039 );
					float2 DDY632_g92039 = ddy( temp_output_5_0_g92039 );
					float Input_Scale617_g92039 = _NormalScale;
					float temp_output_65_0_g92040 = ( 0.0 - temp_output_56_0_g92040 );
					float ifLocalVar59_g92040 = 0;
					if( temp_output_56_0_g92040 <= 0.0 )
					ifLocalVar59_g92040 = temp_output_65_0_g92040;
					else
					ifLocalVar59_g92040 = temp_output_56_0_g92040;
					float temp_output_597_30_g92039 = ifLocalVar59_g92040;
					float2 temp_output_90_0_g92040 = ( temp_output_52_0_g92040 + float2( 0,1 ) );
					float2 temp_output_123_0_g92040 = ( temp_output_52_0_g92040 + float2( 1,0 ) );
					float2 ifLocalVar88_g92040 = 0;
					if( temp_output_56_0_g92040 > 0.0 )
					ifLocalVar88_g92040 = temp_output_90_0_g92040;
					else if( temp_output_56_0_g92040 == 0.0 )
					ifLocalVar88_g92040 = temp_output_123_0_g92040;
					else if( temp_output_56_0_g92040 < 0.0 )
					ifLocalVar88_g92040 = temp_output_123_0_g92040;
					float3 temp_output_7_0_g92042 = frac( ( (ifLocalVar88_g92040).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g92042 = dot( temp_output_7_0_g92042 , ( (temp_output_7_0_g92042).yzx + 33.33 ) );
					float3 temp_output_12_0_g92042 = ( temp_output_7_0_g92042 + dotResult8_g92042 );
					float2 temp_output_597_26_g92039 = ( UV100_g92040 + frac( ( ( (temp_output_12_0_g92042).xx + (temp_output_12_0_g92042).yz ) * (temp_output_12_0_g92042).zy ) ) );
					float temp_output_66_0_g92040 = ( 1.0 - break55_g92040.y );
					float ifLocalVar60_g92040 = 0;
					if( temp_output_56_0_g92040 <= 0.0 )
					ifLocalVar60_g92040 = temp_output_66_0_g92040;
					else
					ifLocalVar60_g92040 = break55_g92040.y;
					float temp_output_597_28_g92039 = ifLocalVar60_g92040;
					float2 ifLocalVar89_g92040 = 0;
					if( temp_output_56_0_g92040 > 0.0 )
					ifLocalVar89_g92040 = temp_output_123_0_g92040;
					else if( temp_output_56_0_g92040 == 0.0 )
					ifLocalVar89_g92040 = temp_output_90_0_g92040;
					else if( temp_output_56_0_g92040 < 0.0 )
					ifLocalVar89_g92040 = temp_output_90_0_g92040;
					float3 temp_output_7_0_g92043 = frac( ( (ifLocalVar89_g92040).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g92043 = dot( temp_output_7_0_g92043 , ( (temp_output_7_0_g92043).yzx + 33.33 ) );
					float3 temp_output_12_0_g92043 = ( temp_output_7_0_g92043 + dotResult8_g92043 );
					float2 temp_output_597_27_g92039 = ( UV100_g92040 + frac( ( ( (temp_output_12_0_g92043).xx + (temp_output_12_0_g92043).yz ) * (temp_output_12_0_g92043).zy ) ) );
					float temp_output_67_0_g92040 = ( 1.0 - break55_g92040.x );
					float ifLocalVar61_g92040 = 0;
					if( temp_output_56_0_g92040 <= 0.0 )
					ifLocalVar61_g92040 = temp_output_67_0_g92040;
					else
					ifLocalVar61_g92040 = break55_g92040.x;
					float temp_output_597_29_g92039 = ifLocalVar61_g92040;
					float3 Output_2D_Normal641_g92039 = ( ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_0_g92039, DDX631_g92039, DDY632_g92039 ), Input_Scale617_g92039 ) * temp_output_597_30_g92039 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_26_g92039, DDX631_g92039, DDY632_g92039 ), Input_Scale617_g92039 ) * temp_output_597_28_g92039 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_27_g92039, DDX631_g92039, DDY632_g92039 ), Input_Scale617_g92039 ) * float3( 0,0,0 ) * temp_output_597_29_g92039 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g92033 = Output_2D_Normal641_g92039;
					#else
					float3 staticSwitch1003_g92033 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap830_g92033 ), _NormalScale );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g92033 = staticSwitch1003_g92033;
					#else
					float3 staticSwitch980_g92033 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g92033 = staticSwitch980_g92033;
					float3 normalizeResult326_g92080 = normalize( Normal_Map700_g92033 );
					float3 Normal_Map318_g92080 = normalizeResult326_g92080;
					float dotResult121_g92080 = dot( appendResult139_g92080 , Normal_Map318_g92080 );
					float temp_output_2_0_g92083 = max( 0.0 , dotResult121_g92080 );
					float2 texCoord1070_g92033 = IN.ase_texcoord6.zw * float2( 1,1 ) + float2( 0,0 );
					float4 tex2DNode1068_g92033 = tex2D( _RNMX0, texCoord1070_g92033 );
					float localStochasticTiling2_g92059 = ( 0.0 );
					float2 uv3_RNMX0 = IN.ase_texcoord6.zw * _RNMX0_ST.xy + _RNMX0_ST.zw;
					float2 UV2_g92059 = uv3_RNMX0;
					float4 TexelSize2_g92059 = _RNMX0_TexelSize;
					float4 Offsets2_g92059 = float4( 0,0,0,0 );
					float2 Weights2_g92059 = float2( 0,0 );
					{
					UV2_g92059 = UV2_g92059 * TexelSize2_g92059.zw - 0.5;
					float2 f = frac( UV2_g92059 );
					UV2_g92059 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g92059.x - 0.5, UV2_g92059.x + 1.5, UV2_g92059.y - 0.5, UV2_g92059.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g92059 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g92059.xyxy;
					Weights2_g92059 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g92058 = Offsets2_g92059;
					float4 Input_FetchOffsets197_g92062 = temp_output_1_34_g92058;
					float2 temp_output_1_54_g92058 = Weights2_g92059;
					float2 Input_FetchWeights200_g92062 = temp_output_1_54_g92058;
					float2 break187_g92062 = Input_FetchWeights200_g92062;
					float4 lerpResult181_g92062 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g92062).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g92062).xw ) , break187_g92062.x);
					float4 lerpResult182_g92062 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g92062).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g92062).xz ) , break187_g92062.x);
					float4 lerpResult176_g92062 = lerp( lerpResult181_g92062 , lerpResult182_g92062 , break187_g92062.y);
					float4 Output_Fetch2D202_g92062 = lerpResult176_g92062;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g92033 = Output_Fetch2D202_g92062;
					#else
					float4 staticSwitch1061_g92033 = tex2DNode1068_g92033;
					#endif
					float3 appendResult146_g92080 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g92080 = dot( appendResult146_g92080 , Normal_Map318_g92080 );
					float temp_output_2_0_g92082 = max( 0.0 , dotResult122_g92080 );
					float4 tex2DNode1069_g92033 = tex2D( _RNMY0, texCoord1070_g92033 );
					float4 Input_FetchOffsets197_g92060 = temp_output_1_34_g92058;
					float2 Input_FetchWeights200_g92060 = temp_output_1_54_g92058;
					float2 break187_g92060 = Input_FetchWeights200_g92060;
					float4 lerpResult181_g92060 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g92060).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g92060).xw ) , break187_g92060.x);
					float4 lerpResult182_g92060 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g92060).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g92060).xz ) , break187_g92060.x);
					float4 lerpResult176_g92060 = lerp( lerpResult181_g92060 , lerpResult182_g92060 , break187_g92060.y);
					float4 Output_Fetch2D202_g92060 = lerpResult176_g92060;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g92033 = Output_Fetch2D202_g92060;
					#else
					float4 staticSwitch1062_g92033 = tex2DNode1069_g92033;
					#endif
					float3 appendResult149_g92080 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g92080 = dot( appendResult149_g92080 , Normal_Map318_g92080 );
					float temp_output_2_0_g92081 = max( 0.0 , dotResult120_g92080 );
					float4 tex2DNode1071_g92033 = tex2D( _RNMZ0, texCoord1070_g92033 );
					float4 Input_FetchOffsets197_g92061 = temp_output_1_34_g92058;
					float2 Input_FetchWeights200_g92061 = temp_output_1_54_g92058;
					float2 break187_g92061 = Input_FetchWeights200_g92061;
					float4 lerpResult181_g92061 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g92061).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g92061).xw ) , break187_g92061.x);
					float4 lerpResult182_g92061 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g92061).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g92061).xz ) , break187_g92061.x);
					float4 lerpResult176_g92061 = lerp( lerpResult181_g92061 , lerpResult182_g92061 , break187_g92061.y);
					float4 Output_Fetch2D202_g92061 = lerpResult176_g92061;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g92033 = Output_Fetch2D202_g92061;
					#else
					float4 staticSwitch1063_g92033 = tex2DNode1071_g92033;
					#endif
					float4 temp_output_24_0_g92080 = ( ( ( ( temp_output_2_0_g92083 * temp_output_2_0_g92083 ) * staticSwitch1061_g92033 ) + ( ( temp_output_2_0_g92082 * temp_output_2_0_g92082 ) * staticSwitch1062_g92033 ) ) + ( ( temp_output_2_0_g92081 * temp_output_2_0_g92081 ) * staticSwitch1063_g92033 ) );
					float4 RNM_0926_g92033 = temp_output_24_0_g92080;
					float3 appendResult139_g92076 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g92076 = normalize( Normal_Map700_g92033 );
					float3 Normal_Map318_g92076 = normalizeResult326_g92076;
					float dotResult121_g92076 = dot( appendResult139_g92076 , Normal_Map318_g92076 );
					float temp_output_2_0_g92079 = max( 0.0 , dotResult121_g92076 );
					float2 texCoord1086_g92033 = IN.ase_texcoord6.zw * float2( 1,1 ) + float2( 0,0 );
					float localStochasticTiling2_g92050 = ( 0.0 );
					float2 uv3_RNMX1 = IN.ase_texcoord6.zw * _RNMX1_ST.xy + _RNMX1_ST.zw;
					float2 UV2_g92050 = uv3_RNMX1;
					float4 TexelSize2_g92050 = _RNMX1_TexelSize;
					float4 Offsets2_g92050 = float4( 0,0,0,0 );
					float2 Weights2_g92050 = float2( 0,0 );
					{
					UV2_g92050 = UV2_g92050 * TexelSize2_g92050.zw - 0.5;
					float2 f = frac( UV2_g92050 );
					UV2_g92050 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g92050.x - 0.5, UV2_g92050.x + 1.5, UV2_g92050.y - 0.5, UV2_g92050.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g92050 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g92050.xyxy;
					Weights2_g92050 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g92049 = Offsets2_g92050;
					float4 Input_FetchOffsets197_g92053 = temp_output_1_34_g92049;
					float2 temp_output_1_54_g92049 = Weights2_g92050;
					float2 Input_FetchWeights200_g92053 = temp_output_1_54_g92049;
					float2 break187_g92053 = Input_FetchWeights200_g92053;
					float4 lerpResult181_g92053 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g92053).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g92053).xw ) , break187_g92053.x);
					float4 lerpResult182_g92053 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g92053).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g92053).xz ) , break187_g92053.x);
					float4 lerpResult176_g92053 = lerp( lerpResult181_g92053 , lerpResult182_g92053 , break187_g92053.y);
					float4 Output_Fetch2D202_g92053 = lerpResult176_g92053;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g92033 = Output_Fetch2D202_g92053;
					#else
					float4 staticSwitch1087_g92033 = tex2D( _RNMX1, texCoord1086_g92033 );
					#endif
					float3 appendResult146_g92076 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g92076 = dot( appendResult146_g92076 , Normal_Map318_g92076 );
					float temp_output_2_0_g92078 = max( 0.0 , dotResult122_g92076 );
					float4 Input_FetchOffsets197_g92051 = temp_output_1_34_g92049;
					float2 Input_FetchWeights200_g92051 = temp_output_1_54_g92049;
					float2 break187_g92051 = Input_FetchWeights200_g92051;
					float4 lerpResult181_g92051 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g92051).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g92051).xw ) , break187_g92051.x);
					float4 lerpResult182_g92051 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g92051).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g92051).xz ) , break187_g92051.x);
					float4 lerpResult176_g92051 = lerp( lerpResult181_g92051 , lerpResult182_g92051 , break187_g92051.y);
					float4 Output_Fetch2D202_g92051 = lerpResult176_g92051;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g92033 = Output_Fetch2D202_g92051;
					#else
					float4 staticSwitch1083_g92033 = tex2D( _RNMY1, texCoord1086_g92033 );
					#endif
					float3 appendResult149_g92076 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g92076 = dot( appendResult149_g92076 , Normal_Map318_g92076 );
					float temp_output_2_0_g92077 = max( 0.0 , dotResult120_g92076 );
					float4 Input_FetchOffsets197_g92052 = temp_output_1_34_g92049;
					float2 Input_FetchWeights200_g92052 = temp_output_1_54_g92049;
					float2 break187_g92052 = Input_FetchWeights200_g92052;
					float4 lerpResult181_g92052 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g92052).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g92052).xw ) , break187_g92052.x);
					float4 lerpResult182_g92052 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g92052).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g92052).xz ) , break187_g92052.x);
					float4 lerpResult176_g92052 = lerp( lerpResult181_g92052 , lerpResult182_g92052 , break187_g92052.y);
					float4 Output_Fetch2D202_g92052 = lerpResult176_g92052;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g92033 = Output_Fetch2D202_g92052;
					#else
					float4 staticSwitch1084_g92033 = tex2D( _RNMZ1, texCoord1086_g92033 );
					#endif
					float4 temp_output_24_0_g92076 = ( ( ( ( temp_output_2_0_g92079 * temp_output_2_0_g92079 ) * staticSwitch1087_g92033 ) + ( ( temp_output_2_0_g92078 * temp_output_2_0_g92078 ) * staticSwitch1083_g92033 ) ) + ( ( temp_output_2_0_g92077 * temp_output_2_0_g92077 ) * staticSwitch1084_g92033 ) );
					float4 RNM_11081_g92033 = temp_output_24_0_g92076;
					float Lightmap_Lerp_Value969_g92033 = _LIGHTMAPLERP;
					float4 lerpResult953_g92033 = lerp( RNM_0926_g92033 , RNM_11081_g92033 , Lightmap_Lerp_Value969_g92033);
					float4 RNM_Lerp950_g92033 = lerpResult953_g92033;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g92033 = temp_cast_2;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g92033 = Lightmap_0925_g92033;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g92033 = Lightmap_Lerp932_g92033;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g92033 = RNM_0926_g92033;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g92033 = RNM_Lerp950_g92033;
					#else
					float4 staticSwitch1014_g92033 = temp_cast_2;
					#endif
					float4 Lightmap46_g92033 = staticSwitch1014_g92033;
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal1392_g92033 = Normal_Map700_g92033;
					float2 uv_GlossinessMap64_g92033 = IN.ase_texcoord6.xy;
					float2 uv_GlossinessMap = IN.ase_texcoord6.xy * _GlossinessMap_ST.xy + _GlossinessMap_ST.zw;
					float2 temp_output_5_0_g92034 = uv_GlossinessMap;
					float2 UV633_g92034 = temp_output_5_0_g92034;
					float2 UV100_g92035 = UV633_g92034;
					float2 temp_output_51_0_g92035 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g92035 * float2( 3.464,3.464 ) ) );
					float2 break55_g92035 = frac( temp_output_51_0_g92035 );
					float temp_output_56_0_g92035 = ( ( 1.0 - break55_g92035.x ) - break55_g92035.y );
					float2 temp_output_52_0_g92035 = floor( temp_output_51_0_g92035 );
					float2 temp_output_125_0_g92035 = ( temp_output_52_0_g92035 + float2( 1,1 ) );
					float2 ifLocalVar87_g92035 = 0;
					if( temp_output_56_0_g92035 > 0.0 )
					ifLocalVar87_g92035 = temp_output_52_0_g92035;
					else if( temp_output_56_0_g92035 == 0.0 )
					ifLocalVar87_g92035 = temp_output_125_0_g92035;
					else if( temp_output_56_0_g92035 < 0.0 )
					ifLocalVar87_g92035 = temp_output_125_0_g92035;
					float3 temp_output_7_0_g92036 = frac( ( (ifLocalVar87_g92035).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g92036 = dot( temp_output_7_0_g92036 , ( (temp_output_7_0_g92036).yzx + 33.33 ) );
					float3 temp_output_12_0_g92036 = ( temp_output_7_0_g92036 + dotResult8_g92036 );
					float2 temp_output_597_0_g92034 = ( UV100_g92035 + frac( ( ( (temp_output_12_0_g92036).xx + (temp_output_12_0_g92036).yz ) * (temp_output_12_0_g92036).zy ) ) );
					float2 DDX631_g92034 = ddx( temp_output_5_0_g92034 );
					float2 DDY632_g92034 = ddy( temp_output_5_0_g92034 );
					float temp_output_65_0_g92035 = ( 0.0 - temp_output_56_0_g92035 );
					float ifLocalVar59_g92035 = 0;
					if( temp_output_56_0_g92035 <= 0.0 )
					ifLocalVar59_g92035 = temp_output_65_0_g92035;
					else
					ifLocalVar59_g92035 = temp_output_56_0_g92035;
					float temp_output_597_30_g92034 = ifLocalVar59_g92035;
					float2 temp_output_90_0_g92035 = ( temp_output_52_0_g92035 + float2( 0,1 ) );
					float2 temp_output_123_0_g92035 = ( temp_output_52_0_g92035 + float2( 1,0 ) );
					float2 ifLocalVar88_g92035 = 0;
					if( temp_output_56_0_g92035 > 0.0 )
					ifLocalVar88_g92035 = temp_output_90_0_g92035;
					else if( temp_output_56_0_g92035 == 0.0 )
					ifLocalVar88_g92035 = temp_output_123_0_g92035;
					else if( temp_output_56_0_g92035 < 0.0 )
					ifLocalVar88_g92035 = temp_output_123_0_g92035;
					float3 temp_output_7_0_g92037 = frac( ( (ifLocalVar88_g92035).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g92037 = dot( temp_output_7_0_g92037 , ( (temp_output_7_0_g92037).yzx + 33.33 ) );
					float3 temp_output_12_0_g92037 = ( temp_output_7_0_g92037 + dotResult8_g92037 );
					float2 temp_output_597_26_g92034 = ( UV100_g92035 + frac( ( ( (temp_output_12_0_g92037).xx + (temp_output_12_0_g92037).yz ) * (temp_output_12_0_g92037).zy ) ) );
					float temp_output_66_0_g92035 = ( 1.0 - break55_g92035.y );
					float ifLocalVar60_g92035 = 0;
					if( temp_output_56_0_g92035 <= 0.0 )
					ifLocalVar60_g92035 = temp_output_66_0_g92035;
					else
					ifLocalVar60_g92035 = break55_g92035.y;
					float temp_output_597_28_g92034 = ifLocalVar60_g92035;
					float2 ifLocalVar89_g92035 = 0;
					if( temp_output_56_0_g92035 > 0.0 )
					ifLocalVar89_g92035 = temp_output_123_0_g92035;
					else if( temp_output_56_0_g92035 == 0.0 )
					ifLocalVar89_g92035 = temp_output_90_0_g92035;
					else if( temp_output_56_0_g92035 < 0.0 )
					ifLocalVar89_g92035 = temp_output_90_0_g92035;
					float3 temp_output_7_0_g92038 = frac( ( (ifLocalVar89_g92035).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g92038 = dot( temp_output_7_0_g92038 , ( (temp_output_7_0_g92038).yzx + 33.33 ) );
					float3 temp_output_12_0_g92038 = ( temp_output_7_0_g92038 + dotResult8_g92038 );
					float2 temp_output_597_27_g92034 = ( UV100_g92035 + frac( ( ( (temp_output_12_0_g92038).xx + (temp_output_12_0_g92038).yz ) * (temp_output_12_0_g92038).zy ) ) );
					float temp_output_67_0_g92035 = ( 1.0 - break55_g92035.x );
					float ifLocalVar61_g92035 = 0;
					if( temp_output_56_0_g92035 <= 0.0 )
					ifLocalVar61_g92035 = temp_output_67_0_g92035;
					else
					ifLocalVar61_g92035 = break55_g92035.x;
					float temp_output_597_29_g92034 = ifLocalVar61_g92035;
					float4 Output_2D293_g92034 = ( ( tex2D( _GlossinessMap, temp_output_597_0_g92034, DDX631_g92034, DDY632_g92034 ) * temp_output_597_30_g92034 ) + ( tex2D( _GlossinessMap, temp_output_597_26_g92034, DDX631_g92034, DDY632_g92034 ) * temp_output_597_28_g92034 ) + ( tex2D( _GlossinessMap, temp_output_597_27_g92034, DDX631_g92034, DDY632_g92034 ) * temp_output_597_29_g92034 ) );
					float4 break31_g92034 = Output_2D293_g92034;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g92033 = break31_g92034.a;
					#else
					float staticSwitch1004_g92033 = tex2D( _GlossinessMap, uv_GlossinessMap64_g92033 ).a;
					#endif
					float saferPower804_g92033 = abs( staticSwitch1004_g92033 );
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g92033 = ( 1.0 - pow( saferPower804_g92033 , 3.0 ) );
					#else
					float staticSwitch845_g92033 = _Glossiness;
					#endif
					float3 temp_output_3_0_g92070 = ddx( NormalWS );
					float dotResult5_g92070 = dot( temp_output_3_0_g92070 , temp_output_3_0_g92070 );
					float3 temp_output_4_0_g92070 = ddy( NormalWS );
					float dotResult6_g92070 = dot( temp_output_4_0_g92070 , temp_output_4_0_g92070 );
					#ifdef _USEGEOMETRICANTIALIASING_ON
					float staticSwitch824_g92033 = min( staticSwitch845_g92033 , ( 1.0 - pow( saturate( max( dotResult5_g92070 , dotResult6_g92070 ) ) , 0.333 ) ) );
					#else
					float staticSwitch824_g92033 = staticSwitch845_g92033;
					#endif
					float Smoothness1399_g92033 = staticSwitch824_g92033;
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
					Unity_GlossyEnvironmentData g1392_g92033 = UnityGlossyEnvironmentSetup( Smoothness1399_g92033, ViewDirWS, float3( dot( tanToWorld0, tanNormal1392_g92033 ), dot( tanToWorld1, tanNormal1392_g92033 ), dot( tanToWorld2, tanNormal1392_g92033 ) ), float3(0,0,0));
					float3 indirectSpecular1392_g92033 = UnityGI_IndirectSpecular( data, 1.0, float3( dot( tanToWorld0, tanNormal1392_g92033 ), dot( tanToWorld1, tanNormal1392_g92033 ), dot( tanToWorld2, tanNormal1392_g92033 ) ), g1392_g92033 );
					float4 temp_cast_4 = (0.04).xxxx;
					float4 lerpResult1473_g92033 = lerp( temp_cast_4 , oAlbedo6_g92033 , Metallic1239_g92033);
					float3 switchResult1501_g92033 = (((ase_vface>0)?(NormalWS):(-NormalWS)));
					float dotResult1476_g92033 = dot( switchResult1501_g92033 , ViewDirWS );
					float4 lerpResult1480_g92033 = lerp( lerpResult1473_g92033 , float4( 1,1,1,0 ) , pow( ( 1.0 - saturate( dotResult1476_g92033 ) ) , 5.0 ));
					float4 Fresnel1560_g92033 = lerpResult1480_g92033;
					float4 temp_output_1481_0_g92033 = ( float4( indirectSpecular1392_g92033 , 0.0 ) * Fresnel1560_g92033 );
					#ifdef _USELIGHTMAPSPECULAR_ON
					float4 staticSwitch1469_g92033 = ( temp_output_1481_0_g92033 * sqrt( Lightmap46_g92033 ) );
					#else
					float4 staticSwitch1469_g92033 = temp_output_1481_0_g92033;
					#endif
					float4 Specular1419_g92033 = staticSwitch1469_g92033;
					float4 temp_cast_5 = 0;
					float2 uv_EmissionMap81_g92033 = IN.ase_texcoord6.xy;
					float2 uv_EmissionMap = IN.ase_texcoord6.xy * _EmissionMap_ST.xy + _EmissionMap_ST.zw;
					float2 temp_output_5_0_g92071 = uv_EmissionMap;
					float2 UV633_g92071 = temp_output_5_0_g92071;
					float2 UV100_g92072 = UV633_g92071;
					float2 temp_output_51_0_g92072 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g92072 * float2( 3.464,3.464 ) ) );
					float2 break55_g92072 = frac( temp_output_51_0_g92072 );
					float temp_output_56_0_g92072 = ( ( 1.0 - break55_g92072.x ) - break55_g92072.y );
					float2 temp_output_52_0_g92072 = floor( temp_output_51_0_g92072 );
					float2 temp_output_125_0_g92072 = ( temp_output_52_0_g92072 + float2( 1,1 ) );
					float2 ifLocalVar87_g92072 = 0;
					if( temp_output_56_0_g92072 > 0.0 )
					ifLocalVar87_g92072 = temp_output_52_0_g92072;
					else if( temp_output_56_0_g92072 == 0.0 )
					ifLocalVar87_g92072 = temp_output_125_0_g92072;
					else if( temp_output_56_0_g92072 < 0.0 )
					ifLocalVar87_g92072 = temp_output_125_0_g92072;
					float3 temp_output_7_0_g92073 = frac( ( (ifLocalVar87_g92072).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g92073 = dot( temp_output_7_0_g92073 , ( (temp_output_7_0_g92073).yzx + 33.33 ) );
					float3 temp_output_12_0_g92073 = ( temp_output_7_0_g92073 + dotResult8_g92073 );
					float2 temp_output_597_0_g92071 = ( UV100_g92072 + frac( ( ( (temp_output_12_0_g92073).xx + (temp_output_12_0_g92073).yz ) * (temp_output_12_0_g92073).zy ) ) );
					float2 DDX631_g92071 = ddx( temp_output_5_0_g92071 );
					float2 DDY632_g92071 = ddy( temp_output_5_0_g92071 );
					float temp_output_65_0_g92072 = ( 0.0 - temp_output_56_0_g92072 );
					float ifLocalVar59_g92072 = 0;
					if( temp_output_56_0_g92072 <= 0.0 )
					ifLocalVar59_g92072 = temp_output_65_0_g92072;
					else
					ifLocalVar59_g92072 = temp_output_56_0_g92072;
					float temp_output_597_30_g92071 = ifLocalVar59_g92072;
					float2 temp_output_90_0_g92072 = ( temp_output_52_0_g92072 + float2( 0,1 ) );
					float2 temp_output_123_0_g92072 = ( temp_output_52_0_g92072 + float2( 1,0 ) );
					float2 ifLocalVar88_g92072 = 0;
					if( temp_output_56_0_g92072 > 0.0 )
					ifLocalVar88_g92072 = temp_output_90_0_g92072;
					else if( temp_output_56_0_g92072 == 0.0 )
					ifLocalVar88_g92072 = temp_output_123_0_g92072;
					else if( temp_output_56_0_g92072 < 0.0 )
					ifLocalVar88_g92072 = temp_output_123_0_g92072;
					float3 temp_output_7_0_g92074 = frac( ( (ifLocalVar88_g92072).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g92074 = dot( temp_output_7_0_g92074 , ( (temp_output_7_0_g92074).yzx + 33.33 ) );
					float3 temp_output_12_0_g92074 = ( temp_output_7_0_g92074 + dotResult8_g92074 );
					float2 temp_output_597_26_g92071 = ( UV100_g92072 + frac( ( ( (temp_output_12_0_g92074).xx + (temp_output_12_0_g92074).yz ) * (temp_output_12_0_g92074).zy ) ) );
					float temp_output_66_0_g92072 = ( 1.0 - break55_g92072.y );
					float ifLocalVar60_g92072 = 0;
					if( temp_output_56_0_g92072 <= 0.0 )
					ifLocalVar60_g92072 = temp_output_66_0_g92072;
					else
					ifLocalVar60_g92072 = break55_g92072.y;
					float temp_output_597_28_g92071 = ifLocalVar60_g92072;
					float2 ifLocalVar89_g92072 = 0;
					if( temp_output_56_0_g92072 > 0.0 )
					ifLocalVar89_g92072 = temp_output_123_0_g92072;
					else if( temp_output_56_0_g92072 == 0.0 )
					ifLocalVar89_g92072 = temp_output_90_0_g92072;
					else if( temp_output_56_0_g92072 < 0.0 )
					ifLocalVar89_g92072 = temp_output_90_0_g92072;
					float3 temp_output_7_0_g92075 = frac( ( (ifLocalVar89_g92072).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g92075 = dot( temp_output_7_0_g92075 , ( (temp_output_7_0_g92075).yzx + 33.33 ) );
					float3 temp_output_12_0_g92075 = ( temp_output_7_0_g92075 + dotResult8_g92075 );
					float2 temp_output_597_27_g92071 = ( UV100_g92072 + frac( ( ( (temp_output_12_0_g92075).xx + (temp_output_12_0_g92075).yz ) * (temp_output_12_0_g92075).zy ) ) );
					float temp_output_67_0_g92072 = ( 1.0 - break55_g92072.x );
					float ifLocalVar61_g92072 = 0;
					if( temp_output_56_0_g92072 <= 0.0 )
					ifLocalVar61_g92072 = temp_output_67_0_g92072;
					else
					ifLocalVar61_g92072 = break55_g92072.x;
					float temp_output_597_29_g92071 = ifLocalVar61_g92072;
					float4 Output_2D293_g92071 = ( ( tex2D( _EmissionMap, temp_output_597_0_g92071, DDX631_g92071, DDY632_g92071 ) * temp_output_597_30_g92071 ) + ( tex2D( _EmissionMap, temp_output_597_26_g92071, DDX631_g92071, DDY632_g92071 ) * temp_output_597_28_g92071 ) + ( tex2D( _EmissionMap, temp_output_597_27_g92071, DDX631_g92071, DDY632_g92071 ) * temp_output_597_29_g92071 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g92033 = Output_2D293_g92071;
					#else
					float4 staticSwitch1006_g92033 = tex2D( _EmissionMap, uv_EmissionMap81_g92033 );
					#endif
					#if defined( _SPECIALEFFECTS_DISABLED )
					float4 staticSwitch1578_g92033 = staticSwitch1006_g92033;
					#elif defined( _SPECIALEFFECTS_LED )
					float4 staticSwitch1578_g92033 = float4( 0,0,0,0 );
					#else
					float4 staticSwitch1578_g92033 = staticSwitch1006_g92033;
					#endif
					#ifdef _EMISSIONENABLED_ON
					float4 staticSwitch1017_g92033 = ( float4( _EmissionColor , 0.0 ) * staticSwitch1578_g92033 * _EmissionIntensity );
					#else
					float4 staticSwitch1017_g92033 = temp_cast_5;
					#endif
					float4 Emission86_g92033 = staticSwitch1017_g92033;
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1181_g92033 = Lightmap46_g92033;
					#else
					float4 staticSwitch1181_g92033 = ( ( ( aAlbedo1466_g92033 * Lightmap46_g92033 ) + Specular1419_g92033 ) + Emission86_g92033 );
					#endif
					float4 temp_output_35_0_g92068 = staticSwitch1181_g92033;
					float4 Color353_g92068 = temp_output_35_0_g92068;
					#if defined( _LUTMODE_2D )
					float4 staticSwitch273_g92068 = saturate( temp_output_35_0_g92068 );
					#elif defined( _LUTMODE_3D )
					float4 staticSwitch273_g92068 = temp_output_35_0_g92068;
					#else
					float4 staticSwitch273_g92068 = temp_output_35_0_g92068;
					#endif
					float4 Color_Saturate49_g92068 = staticSwitch273_g92068;
					float Lut_Height213_g92068 = _LUTSize;
					float Lut_Width216_g92068 = ( _LUTSize * Lut_Height213_g92068 );
					float3 appendResult214_g92068 = (float3(( 1.0 / Lut_Width216_g92068 ) , ( 1.0 / Lut_Height213_g92068 ) , ( Lut_Height213_g92068 - 1.0 )));
					float3 Scale_Offset208_g92068 = appendResult214_g92068;
					float2 Scale_Factor292_g92068 = ( (Scale_Offset208_g92068).xy * (Scale_Offset208_g92068).z );
					float2 Offset299_g92068 = ( (Scale_Offset208_g92068).xy * 0.5 );
					float3 Adjusted_UV305_g92068 = ( ( (Color_Saturate49_g92068).xyw * float3( Scale_Factor292_g92068 ,  0.0 ) ) + float3( Offset299_g92068 ,  0.0 ) );
					float2 Scaled_Blue280_g92068 = ( (Color_Saturate49_g92068).zw * (Scale_Offset208_g92068).z );
					float2 Shift288_g92068 = floor( Scaled_Blue280_g92068 );
					float2 Final_X313_g92068 = ( (Adjusted_UV305_g92068).xz + ( Shift288_g92068 * (Scale_Offset208_g92068).y ) );
					float2 appendResult326_g92068 = (float2(Final_X313_g92068));
					float2 Final_UV325_g92068 = appendResult326_g92068;
					float2 appendResult338_g92068 = (float2((Scale_Offset208_g92068).y , 0.0));
					float2 Offset_UV336_g92068 = ( Final_UV325_g92068 + appendResult338_g92068 );
					float3 lerpResult333_g92068 = lerp( tex2D( _2DLut, Final_UV325_g92068 ).rgb , tex2D( _2DLut, Offset_UV336_g92068 ).rgb , float3( ( Scaled_Blue280_g92068 - Shift288_g92068 ) ,  0.0 ));
					#ifdef _2DLUT
					float4 staticSwitch347_g92068 = float4( lerpResult333_g92068 , 0.0 );
					#else
					float4 staticSwitch347_g92068 = Color_Saturate49_g92068;
					#endif
					float4 TwoD_LUT346_g92068 = staticSwitch347_g92068;
					float3 RGB16_g92069 = ( ( log10( ( ( Color_Saturate49_g92068.xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 );
					#ifdef _3DLUT
					float4 staticSwitch194_g92068 = tex3D( _3DLut, RGB16_g92069 );
					#else
					float4 staticSwitch194_g92068 = Color_Saturate49_g92068;
					#endif
					float4 ThreeD_LUT51_g92068 = staticSwitch194_g92068;
					#if defined( _LUTMODE_2D )
					float4 staticSwitch42_g92068 = TwoD_LUT346_g92068;
					#elif defined( _LUTMODE_3D )
					float4 staticSwitch42_g92068 = ThreeD_LUT51_g92068;
					#else
					float4 staticSwitch42_g92068 = ThreeD_LUT51_g92068;
					#endif
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch41_g92068 = staticSwitch42_g92068;
					#else
					float4 staticSwitch41_g92068 = Color353_g92068;
					#endif
					

					o.Albedo = staticSwitch1180_g92033.rgb;
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

					o.Emission = staticSwitch41_g92068.xyz;
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
				uniform sampler2D _2DLut;
				uniform float _LUTSize;
				uniform sampler3D _3DLut;
				uniform float _CATEGORYSPACECOLORGRADING;
				uniform float _CATEGORYCOLORGRADING;
				uniform float _CATEGORYSPACESPECIALEFFECTS;
				uniform float _CATEGORYSPECIALEFFECTS;


				
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
Version=19905
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3381;-96,-1536;Inherit;False;Meenphie Outline;46;;65392;d39aa08508dd494aeb2901b7a0739759;0;0;2;FLOAT3;17;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;4233;-64,-1280;Inherit;False;Meenphie;0;;92033;b3ba55a08dd6b49c7be16c6f35cf2033;1,1008,0;0;5;COLOR;625;FLOAT4;624;FLOAT;156;FLOAT;427;FLOAT3;1024
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3740;576,-1248;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;True;1;LightMode=ForwardAdd;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3741;576,-1248;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3742;576,-1248;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3743;576,-1248;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3744;576,-1248;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3745;576,-1248;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ScenePickingPass;0;7;ScenePickingPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;True;1;LightMode=ScenePickingPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3738;256,-1536;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;True;True;0;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;True;True;1;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;1;False;;True;3;False;;True;False;0;False;;0;False;;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3739;256,-1280;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;Meenphie/Standard/Opaque;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardBase;0;1;ForwardBase;17;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;True;True;0;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;44;Category;0;0;  Instanced Terrain Normals;1;0;Workflow;3;639028274621142910;Surface;0;0;  Blend;0;0;  Dither Shadows;1;0;Two Sided;1;0;Alpha Clipping;0;0;  Use Shadow Threshold;0;0;Deferred Pass;0;639028266079385620;Normal Space;0;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;1;0;Receive Shadows;0;639028268792086470;Receive Specular;0;639028266947641220;Receive Reflections;1;639028266981665430;GPU Instancing;1;0;LOD CrossFade;1;0;Built-in Fog;1;0;Ambient Light;1;639028267400084780;Meta Pass;0;639028267284008090;Add Pass;0;639028267286352120;Override Baked GI;0;0;Write Depth;0;0;Extra Pre Pass;1;639028267465020320;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;0;Vertex Position;1;0;0;8;True;True;False;False;False;True;False;False;False;;False;0
WireConnection;3738;0;3381;17
WireConnection;3738;3;3381;0
WireConnection;3739;0;4233;625
WireConnection;3739;2;4233;624
ASEEND*/
//CHKSM=BC67FA5680E1F3F9E903D73FB1EE32BF55A550D6