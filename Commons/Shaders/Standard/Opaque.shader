// Made with Amplify Shader Editor v1.9.9.4
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Standard/Opaque"
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
		[Meenphie_DrawerCategory(OUTLINE,true,0,0)] _CATEGORYOUTLINE1( "CATEGORY OUTLINE", Float ) = 0
		[Toggle( _OUTLINEENABLED_ON )] _OutlineEnabled( "Outline Enabled", Float ) = 1
		_OutlineColor( "Outline Color", Color ) = ( 0.02, 0.02, 0.02 )
		_OutlineWidth( "Outline Width", Range( 0, 0.01 ) ) = 0.005
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACEOUTLINE1( "CATEGORY SPACE OUTLINE", Float ) = 0
		[HideInInspector] GenKey__MetallicMap( "Assign keyword _METALLICMAP", Float ) = 1.0
		[HideInInspector] GenKey__2DLut( "Assign keyword _2DLUT", Float ) = 1.0
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0
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
				#define ASE_RECEIVE_SHADOWS
				#pragma multi_compile _ LOD_FADE_CROSSFADE
				#pragma multi_compile_fog
				#define ASE_FOG
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

				#define ASE_NEEDS_VERT_NORMAL
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
					float4 positionWS : TEXCOORD0; // xyz = positionWS, w = fogCoord
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
				uniform float _CATEGORYSPACECOLORGRADING;
				uniform float _CATEGORYCOLORGRADING;
				uniform sampler2D _2DLut;
				uniform float _LUTSize;
				uniform sampler3D _3DLut;
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

					float4 temp_cast_0 = (asfloat( -1 )).xxxx;
					float Outline_GUI6_g1551 = ( _CATEGORYOUTLINE1 + _CATEGORYSPACEOUTLINE1 );
					float4 temp_cast_2 = (Outline_GUI6_g1551).xxxx;
					float4 lerpResult11_g1551 = lerp( ( float4( v.normal , 0.0 ) * v.ase_color * _OutlineWidth ) , temp_cast_2 , float4( 0,0,0,0 ));
					#ifdef _OUTLINEENABLED_ON
					float4 staticSwitch13_g1551 = lerpResult11_g1551;
					#else
					float4 staticSwitch13_g1551 = temp_cast_0;
					#endif
					

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = staticSwitch13_g1551.rgb;
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

					#ifdef _OUTLINEENABLED_ON
					float3 staticSwitch18_g1551 = _OutlineColor;
					#else
					float3 staticSwitch18_g1551 = float3( 0,0,0 );
					#endif
					

					half3 Color = staticSwitch18_g1551;
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
						UNITY_APPLY_FOG( FogCoord, c );
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
				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
				#define ASE_NEEDS_TEXTURE_COORDINATES2
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
				#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
				#define ASE_NEEDS_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_NORMAL
				#pragma shader_feature_local _STOCHASTICENABLED_ON
				#pragma shader_feature_local_fragment _BUMPMAP
				#pragma shader_feature_local_fragment _METALLICMAP
				#pragma shader_feature_local_fragment _USEGEOMETRICANTIALIASING_ON
				#pragma shader_feature_local _LIGHTMAPMODE_DISABLED _LIGHTMAPMODE_SIMPLE _LIGHTMAPMODE_SIMPLELERP _LIGHTMAPMODE_RNM _LIGHTMAPMODE_RNMLERP
				#pragma shader_feature_local _LIGHTMAPOCCLUSIONENABLED_ON
				#pragma shader_feature_local _USEBICUBICFILTERING_ON
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
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				uniform float4 _MetallicMap_ST;
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
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				uniform float4 _GlossinessMap_ST;
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

					float2 uv_MainTex907_g61063 = IN.ase_texcoord6.xy;
					float2 uv_MainTex = IN.ase_texcoord6.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					float2 temp_output_5_0_g61085 = uv_MainTex;
					float2 UV633_g61085 = temp_output_5_0_g61085;
					float2 UV100_g61086 = UV633_g61085;
					float2 temp_output_51_0_g61086 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g61086 * float2( 3.464,3.464 ) ) );
					float2 break55_g61086 = frac( temp_output_51_0_g61086 );
					float temp_output_56_0_g61086 = ( ( 1.0 - break55_g61086.x ) - break55_g61086.y );
					float2 temp_output_52_0_g61086 = floor( temp_output_51_0_g61086 );
					float2 temp_output_125_0_g61086 = ( temp_output_52_0_g61086 + float2( 1,1 ) );
					float2 ifLocalVar87_g61086 = 0;
					if( temp_output_56_0_g61086 > 0.0 )
					ifLocalVar87_g61086 = temp_output_52_0_g61086;
					else if( temp_output_56_0_g61086 == 0.0 )
					ifLocalVar87_g61086 = temp_output_125_0_g61086;
					else if( temp_output_56_0_g61086 < 0.0 )
					ifLocalVar87_g61086 = temp_output_125_0_g61086;
					float3 temp_output_7_0_g61087 = frac( ( (ifLocalVar87_g61086).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61087 = dot( temp_output_7_0_g61087 , ( (temp_output_7_0_g61087).yzx + 33.33 ) );
					float3 temp_output_12_0_g61087 = ( temp_output_7_0_g61087 + dotResult8_g61087 );
					float2 temp_output_597_0_g61085 = ( UV100_g61086 + frac( ( ( (temp_output_12_0_g61087).xx + (temp_output_12_0_g61087).yz ) * (temp_output_12_0_g61087).zy ) ) );
					float2 DDX631_g61085 = ddx( temp_output_5_0_g61085 );
					float2 DDY632_g61085 = ddy( temp_output_5_0_g61085 );
					float temp_output_65_0_g61086 = ( 0.0 - temp_output_56_0_g61086 );
					float ifLocalVar59_g61086 = 0;
					if( temp_output_56_0_g61086 <= 0.0 )
					ifLocalVar59_g61086 = temp_output_65_0_g61086;
					else
					ifLocalVar59_g61086 = temp_output_56_0_g61086;
					float temp_output_597_30_g61085 = ifLocalVar59_g61086;
					float2 temp_output_90_0_g61086 = ( temp_output_52_0_g61086 + float2( 0,1 ) );
					float2 temp_output_123_0_g61086 = ( temp_output_52_0_g61086 + float2( 1,0 ) );
					float2 ifLocalVar88_g61086 = 0;
					if( temp_output_56_0_g61086 > 0.0 )
					ifLocalVar88_g61086 = temp_output_90_0_g61086;
					else if( temp_output_56_0_g61086 == 0.0 )
					ifLocalVar88_g61086 = temp_output_123_0_g61086;
					else if( temp_output_56_0_g61086 < 0.0 )
					ifLocalVar88_g61086 = temp_output_123_0_g61086;
					float3 temp_output_7_0_g61088 = frac( ( (ifLocalVar88_g61086).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61088 = dot( temp_output_7_0_g61088 , ( (temp_output_7_0_g61088).yzx + 33.33 ) );
					float3 temp_output_12_0_g61088 = ( temp_output_7_0_g61088 + dotResult8_g61088 );
					float2 temp_output_597_26_g61085 = ( UV100_g61086 + frac( ( ( (temp_output_12_0_g61088).xx + (temp_output_12_0_g61088).yz ) * (temp_output_12_0_g61088).zy ) ) );
					float temp_output_66_0_g61086 = ( 1.0 - break55_g61086.y );
					float ifLocalVar60_g61086 = 0;
					if( temp_output_56_0_g61086 <= 0.0 )
					ifLocalVar60_g61086 = temp_output_66_0_g61086;
					else
					ifLocalVar60_g61086 = break55_g61086.y;
					float temp_output_597_28_g61085 = ifLocalVar60_g61086;
					float2 ifLocalVar89_g61086 = 0;
					if( temp_output_56_0_g61086 > 0.0 )
					ifLocalVar89_g61086 = temp_output_123_0_g61086;
					else if( temp_output_56_0_g61086 == 0.0 )
					ifLocalVar89_g61086 = temp_output_90_0_g61086;
					else if( temp_output_56_0_g61086 < 0.0 )
					ifLocalVar89_g61086 = temp_output_90_0_g61086;
					float3 temp_output_7_0_g61089 = frac( ( (ifLocalVar89_g61086).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61089 = dot( temp_output_7_0_g61089 , ( (temp_output_7_0_g61089).yzx + 33.33 ) );
					float3 temp_output_12_0_g61089 = ( temp_output_7_0_g61089 + dotResult8_g61089 );
					float2 temp_output_597_27_g61085 = ( UV100_g61086 + frac( ( ( (temp_output_12_0_g61089).xx + (temp_output_12_0_g61089).yz ) * (temp_output_12_0_g61089).zy ) ) );
					float temp_output_67_0_g61086 = ( 1.0 - break55_g61086.x );
					float ifLocalVar61_g61086 = 0;
					if( temp_output_56_0_g61086 <= 0.0 )
					ifLocalVar61_g61086 = temp_output_67_0_g61086;
					else
					ifLocalVar61_g61086 = break55_g61086.x;
					float temp_output_597_29_g61085 = ifLocalVar61_g61086;
					float4 Output_2D293_g61085 = ( ( tex2D( _MainTex, temp_output_597_0_g61085, DDX631_g61085, DDY632_g61085 ) * temp_output_597_30_g61085 ) + ( tex2D( _MainTex, temp_output_597_26_g61085, DDX631_g61085, DDY632_g61085 ) * temp_output_597_28_g61085 ) + ( tex2D( _MainTex, temp_output_597_27_g61085, DDX631_g61085, DDY632_g61085 ) * temp_output_597_29_g61085 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g61063 = Output_2D293_g61085;
					#else
					float4 staticSwitch1001_g61063 = tex2D( _MainTex, uv_MainTex907_g61063 );
					#endif
					float4 temp_output_976_0_g61063 = ( _Color * staticSwitch1001_g61063 );
					float4 Albedo6_g61063 = temp_output_976_0_g61063;
					
					float2 uv_BumpMap830_g61063 = IN.ase_texcoord6.xy;
					float2 uv_BumpMap = IN.ase_texcoord6.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					float2 temp_output_5_0_g61079 = uv_BumpMap;
					float2 UV633_g61079 = temp_output_5_0_g61079;
					float2 UV100_g61080 = UV633_g61079;
					float2 temp_output_51_0_g61080 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g61080 * float2( 3.464,3.464 ) ) );
					float2 break55_g61080 = frac( temp_output_51_0_g61080 );
					float temp_output_56_0_g61080 = ( ( 1.0 - break55_g61080.x ) - break55_g61080.y );
					float2 temp_output_52_0_g61080 = floor( temp_output_51_0_g61080 );
					float2 temp_output_125_0_g61080 = ( temp_output_52_0_g61080 + float2( 1,1 ) );
					float2 ifLocalVar87_g61080 = 0;
					if( temp_output_56_0_g61080 > 0.0 )
					ifLocalVar87_g61080 = temp_output_52_0_g61080;
					else if( temp_output_56_0_g61080 == 0.0 )
					ifLocalVar87_g61080 = temp_output_125_0_g61080;
					else if( temp_output_56_0_g61080 < 0.0 )
					ifLocalVar87_g61080 = temp_output_125_0_g61080;
					float3 temp_output_7_0_g61081 = frac( ( (ifLocalVar87_g61080).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61081 = dot( temp_output_7_0_g61081 , ( (temp_output_7_0_g61081).yzx + 33.33 ) );
					float3 temp_output_12_0_g61081 = ( temp_output_7_0_g61081 + dotResult8_g61081 );
					float2 temp_output_597_0_g61079 = ( UV100_g61080 + frac( ( ( (temp_output_12_0_g61081).xx + (temp_output_12_0_g61081).yz ) * (temp_output_12_0_g61081).zy ) ) );
					float2 DDX631_g61079 = ddx( temp_output_5_0_g61079 );
					float2 DDY632_g61079 = ddy( temp_output_5_0_g61079 );
					float Input_Scale617_g61079 = _NormalScale;
					float temp_output_65_0_g61080 = ( 0.0 - temp_output_56_0_g61080 );
					float ifLocalVar59_g61080 = 0;
					if( temp_output_56_0_g61080 <= 0.0 )
					ifLocalVar59_g61080 = temp_output_65_0_g61080;
					else
					ifLocalVar59_g61080 = temp_output_56_0_g61080;
					float temp_output_597_30_g61079 = ifLocalVar59_g61080;
					float2 temp_output_90_0_g61080 = ( temp_output_52_0_g61080 + float2( 0,1 ) );
					float2 temp_output_123_0_g61080 = ( temp_output_52_0_g61080 + float2( 1,0 ) );
					float2 ifLocalVar88_g61080 = 0;
					if( temp_output_56_0_g61080 > 0.0 )
					ifLocalVar88_g61080 = temp_output_90_0_g61080;
					else if( temp_output_56_0_g61080 == 0.0 )
					ifLocalVar88_g61080 = temp_output_123_0_g61080;
					else if( temp_output_56_0_g61080 < 0.0 )
					ifLocalVar88_g61080 = temp_output_123_0_g61080;
					float3 temp_output_7_0_g61082 = frac( ( (ifLocalVar88_g61080).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61082 = dot( temp_output_7_0_g61082 , ( (temp_output_7_0_g61082).yzx + 33.33 ) );
					float3 temp_output_12_0_g61082 = ( temp_output_7_0_g61082 + dotResult8_g61082 );
					float2 temp_output_597_26_g61079 = ( UV100_g61080 + frac( ( ( (temp_output_12_0_g61082).xx + (temp_output_12_0_g61082).yz ) * (temp_output_12_0_g61082).zy ) ) );
					float temp_output_66_0_g61080 = ( 1.0 - break55_g61080.y );
					float ifLocalVar60_g61080 = 0;
					if( temp_output_56_0_g61080 <= 0.0 )
					ifLocalVar60_g61080 = temp_output_66_0_g61080;
					else
					ifLocalVar60_g61080 = break55_g61080.y;
					float temp_output_597_28_g61079 = ifLocalVar60_g61080;
					float2 ifLocalVar89_g61080 = 0;
					if( temp_output_56_0_g61080 > 0.0 )
					ifLocalVar89_g61080 = temp_output_123_0_g61080;
					else if( temp_output_56_0_g61080 == 0.0 )
					ifLocalVar89_g61080 = temp_output_90_0_g61080;
					else if( temp_output_56_0_g61080 < 0.0 )
					ifLocalVar89_g61080 = temp_output_90_0_g61080;
					float3 temp_output_7_0_g61083 = frac( ( (ifLocalVar89_g61080).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61083 = dot( temp_output_7_0_g61083 , ( (temp_output_7_0_g61083).yzx + 33.33 ) );
					float3 temp_output_12_0_g61083 = ( temp_output_7_0_g61083 + dotResult8_g61083 );
					float2 temp_output_597_27_g61079 = ( UV100_g61080 + frac( ( ( (temp_output_12_0_g61083).xx + (temp_output_12_0_g61083).yz ) * (temp_output_12_0_g61083).zy ) ) );
					float temp_output_67_0_g61080 = ( 1.0 - break55_g61080.x );
					float ifLocalVar61_g61080 = 0;
					if( temp_output_56_0_g61080 <= 0.0 )
					ifLocalVar61_g61080 = temp_output_67_0_g61080;
					else
					ifLocalVar61_g61080 = break55_g61080.x;
					float temp_output_597_29_g61079 = ifLocalVar61_g61080;
					float3 Output_2D_Normal641_g61079 = ( ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_0_g61079, DDX631_g61079, DDY632_g61079 ), Input_Scale617_g61079 ) * temp_output_597_30_g61079 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_26_g61079, DDX631_g61079, DDY632_g61079 ), Input_Scale617_g61079 ) * temp_output_597_28_g61079 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_27_g61079, DDX631_g61079, DDY632_g61079 ), Input_Scale617_g61079 ) * float3( 0,0,0 ) * temp_output_597_29_g61079 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g61063 = Output_2D_Normal641_g61079;
					#else
					float3 staticSwitch1003_g61063 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap830_g61063 ), _NormalScale );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g61063 = staticSwitch1003_g61063;
					#else
					float3 staticSwitch980_g61063 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g61063 = staticSwitch980_g61063;
					
					float2 uv_MetallicMap48_g61063 = IN.ase_texcoord6.xy;
					float2 uv_MetallicMap = IN.ase_texcoord6.xy * _MetallicMap_ST.xy + _MetallicMap_ST.zw;
					float2 temp_output_5_0_g61069 = uv_MetallicMap;
					float2 UV633_g61069 = temp_output_5_0_g61069;
					float2 UV100_g61070 = UV633_g61069;
					float2 temp_output_51_0_g61070 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g61070 * float2( 3.464,3.464 ) ) );
					float2 break55_g61070 = frac( temp_output_51_0_g61070 );
					float temp_output_56_0_g61070 = ( ( 1.0 - break55_g61070.x ) - break55_g61070.y );
					float2 temp_output_52_0_g61070 = floor( temp_output_51_0_g61070 );
					float2 temp_output_125_0_g61070 = ( temp_output_52_0_g61070 + float2( 1,1 ) );
					float2 ifLocalVar87_g61070 = 0;
					if( temp_output_56_0_g61070 > 0.0 )
					ifLocalVar87_g61070 = temp_output_52_0_g61070;
					else if( temp_output_56_0_g61070 == 0.0 )
					ifLocalVar87_g61070 = temp_output_125_0_g61070;
					else if( temp_output_56_0_g61070 < 0.0 )
					ifLocalVar87_g61070 = temp_output_125_0_g61070;
					float3 temp_output_7_0_g61071 = frac( ( (ifLocalVar87_g61070).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61071 = dot( temp_output_7_0_g61071 , ( (temp_output_7_0_g61071).yzx + 33.33 ) );
					float3 temp_output_12_0_g61071 = ( temp_output_7_0_g61071 + dotResult8_g61071 );
					float2 temp_output_597_0_g61069 = ( UV100_g61070 + frac( ( ( (temp_output_12_0_g61071).xx + (temp_output_12_0_g61071).yz ) * (temp_output_12_0_g61071).zy ) ) );
					float2 DDX631_g61069 = ddx( temp_output_5_0_g61069 );
					float2 DDY632_g61069 = ddy( temp_output_5_0_g61069 );
					float temp_output_65_0_g61070 = ( 0.0 - temp_output_56_0_g61070 );
					float ifLocalVar59_g61070 = 0;
					if( temp_output_56_0_g61070 <= 0.0 )
					ifLocalVar59_g61070 = temp_output_65_0_g61070;
					else
					ifLocalVar59_g61070 = temp_output_56_0_g61070;
					float temp_output_597_30_g61069 = ifLocalVar59_g61070;
					float2 temp_output_90_0_g61070 = ( temp_output_52_0_g61070 + float2( 0,1 ) );
					float2 temp_output_123_0_g61070 = ( temp_output_52_0_g61070 + float2( 1,0 ) );
					float2 ifLocalVar88_g61070 = 0;
					if( temp_output_56_0_g61070 > 0.0 )
					ifLocalVar88_g61070 = temp_output_90_0_g61070;
					else if( temp_output_56_0_g61070 == 0.0 )
					ifLocalVar88_g61070 = temp_output_123_0_g61070;
					else if( temp_output_56_0_g61070 < 0.0 )
					ifLocalVar88_g61070 = temp_output_123_0_g61070;
					float3 temp_output_7_0_g61072 = frac( ( (ifLocalVar88_g61070).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61072 = dot( temp_output_7_0_g61072 , ( (temp_output_7_0_g61072).yzx + 33.33 ) );
					float3 temp_output_12_0_g61072 = ( temp_output_7_0_g61072 + dotResult8_g61072 );
					float2 temp_output_597_26_g61069 = ( UV100_g61070 + frac( ( ( (temp_output_12_0_g61072).xx + (temp_output_12_0_g61072).yz ) * (temp_output_12_0_g61072).zy ) ) );
					float temp_output_66_0_g61070 = ( 1.0 - break55_g61070.y );
					float ifLocalVar60_g61070 = 0;
					if( temp_output_56_0_g61070 <= 0.0 )
					ifLocalVar60_g61070 = temp_output_66_0_g61070;
					else
					ifLocalVar60_g61070 = break55_g61070.y;
					float temp_output_597_28_g61069 = ifLocalVar60_g61070;
					float2 ifLocalVar89_g61070 = 0;
					if( temp_output_56_0_g61070 > 0.0 )
					ifLocalVar89_g61070 = temp_output_123_0_g61070;
					else if( temp_output_56_0_g61070 == 0.0 )
					ifLocalVar89_g61070 = temp_output_90_0_g61070;
					else if( temp_output_56_0_g61070 < 0.0 )
					ifLocalVar89_g61070 = temp_output_90_0_g61070;
					float3 temp_output_7_0_g61073 = frac( ( (ifLocalVar89_g61070).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61073 = dot( temp_output_7_0_g61073 , ( (temp_output_7_0_g61073).yzx + 33.33 ) );
					float3 temp_output_12_0_g61073 = ( temp_output_7_0_g61073 + dotResult8_g61073 );
					float2 temp_output_597_27_g61069 = ( UV100_g61070 + frac( ( ( (temp_output_12_0_g61073).xx + (temp_output_12_0_g61073).yz ) * (temp_output_12_0_g61073).zy ) ) );
					float temp_output_67_0_g61070 = ( 1.0 - break55_g61070.x );
					float ifLocalVar61_g61070 = 0;
					if( temp_output_56_0_g61070 <= 0.0 )
					ifLocalVar61_g61070 = temp_output_67_0_g61070;
					else
					ifLocalVar61_g61070 = break55_g61070.x;
					float temp_output_597_29_g61069 = ifLocalVar61_g61070;
					float4 Output_2D293_g61069 = ( ( tex2D( _MetallicMap, temp_output_597_0_g61069, DDX631_g61069, DDY632_g61069 ) * temp_output_597_30_g61069 ) + ( tex2D( _MetallicMap, temp_output_597_26_g61069, DDX631_g61069, DDY632_g61069 ) * temp_output_597_28_g61069 ) + ( tex2D( _MetallicMap, temp_output_597_27_g61069, DDX631_g61069, DDY632_g61069 ) * temp_output_597_29_g61069 ) );
					float4 break31_g61069 = Output_2D293_g61069;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g61063 = break31_g61069.a;
					#else
					float staticSwitch1005_g61063 = tex2D( _MetallicMap, uv_MetallicMap48_g61063 ).a;
					#endif
					float saferPower803_g61063 = abs( staticSwitch1005_g61063 );
					#ifdef _METALLICMAP
					float staticSwitch846_g61063 = pow( saferPower803_g61063 , 3.0 );
					#else
					float staticSwitch846_g61063 = _Metallic;
					#endif
					float Metallic699_g61063 = staticSwitch846_g61063;
					
					float White38_g61063 = 1.0;
					float4 temp_cast_1 = (White38_g61063).xxxx;
					float2 texCoord1093_g61063 = IN.ase_texcoord6.zw * float2( 1,1 ) + float2( 0,0 );
					float localBicubicPrepare2_g61098 = ( 0.0 );
					float2 uv3_Lightmap0 = IN.ase_texcoord6.zw * _Lightmap0_ST.xy + _Lightmap0_ST.zw;
					float2 Input_UV100_g61098 = uv3_Lightmap0;
					float2 UV2_g61098 = Input_UV100_g61098;
					float4 TexelSize2_g61098 = _Lightmap0_TexelSize;
					float2 UV02_g61098 = float2( 0,0 );
					float2 UV12_g61098 = float2( 0,0 );
					float2 UV22_g61098 = float2( 0,0 );
					float2 UV32_g61098 = float2( 0,0 );
					float W02_g61098 = 0;
					float W12_g61098 = 0;
					{
					{
					 UV2_g61098 = UV2_g61098 * TexelSize2_g61098.zw - 0.5;
					    float2 f = frac( UV2_g61098 );
					    UV2_g61098 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g61098.x - 0.5, UV2_g61098.x + 1.5, UV2_g61098.y - 0.5, UV2_g61098.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g61098.xyxy;
					    UV02_g61098 = off.xz;
					    UV12_g61098 = off.yz;
					    UV22_g61098 = off.xw;
					    UV32_g61098 = off.yw;
					    W02_g61098 = s.x / ( s.x + s.y );
					 W12_g61098 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g61098 = lerp( tex2D( _Lightmap0, UV32_g61098 ) , tex2D( _Lightmap0, UV22_g61098 ) , W02_g61098);
					float4 lerpResult45_g61098 = lerp( tex2D( _Lightmap0, UV12_g61098 ) , tex2D( _Lightmap0, UV02_g61098 ) , W02_g61098);
					float4 lerpResult44_g61098 = lerp( lerpResult46_g61098 , lerpResult45_g61098 , W12_g61098);
					float4 Output_2D131_g61098 = lerpResult44_g61098;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g61063 = Output_2D131_g61098;
					#else
					float4 staticSwitch1092_g61063 = tex2D( _Lightmap0, texCoord1093_g61063 );
					#endif
					float4 Lightmap_0925_g61063 = staticSwitch1092_g61063;
					float2 texCoord1090_g61063 = IN.ase_texcoord6.zw * float2( 1,1 ) + float2( 0,0 );
					float localBicubicPrepare2_g61096 = ( 0.0 );
					float2 uv3_Lightmap1 = IN.ase_texcoord6.zw * _Lightmap1_ST.xy + _Lightmap1_ST.zw;
					float2 Input_UV100_g61096 = uv3_Lightmap1;
					float2 UV2_g61096 = Input_UV100_g61096;
					float4 TexelSize2_g61096 = _Lightmap1_TexelSize;
					float2 UV02_g61096 = float2( 0,0 );
					float2 UV12_g61096 = float2( 0,0 );
					float2 UV22_g61096 = float2( 0,0 );
					float2 UV32_g61096 = float2( 0,0 );
					float W02_g61096 = 0;
					float W12_g61096 = 0;
					{
					{
					 UV2_g61096 = UV2_g61096 * TexelSize2_g61096.zw - 0.5;
					    float2 f = frac( UV2_g61096 );
					    UV2_g61096 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g61096.x - 0.5, UV2_g61096.x + 1.5, UV2_g61096.y - 0.5, UV2_g61096.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g61096.xyxy;
					    UV02_g61096 = off.xz;
					    UV12_g61096 = off.yz;
					    UV22_g61096 = off.xw;
					    UV32_g61096 = off.yw;
					    W02_g61096 = s.x / ( s.x + s.y );
					 W12_g61096 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g61096 = lerp( tex2D( _Lightmap1, UV32_g61096 ) , tex2D( _Lightmap1, UV22_g61096 ) , W02_g61096);
					float4 lerpResult45_g61096 = lerp( tex2D( _Lightmap1, UV12_g61096 ) , tex2D( _Lightmap1, UV02_g61096 ) , W02_g61096);
					float4 lerpResult44_g61096 = lerp( lerpResult46_g61096 , lerpResult45_g61096 , W12_g61096);
					float4 Output_2D131_g61096 = lerpResult44_g61096;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g61063 = Output_2D131_g61096;
					#else
					float4 staticSwitch1088_g61063 = tex2D( _Lightmap1, texCoord1090_g61063 );
					#endif
					float4 Lightmap_1956_g61063 = staticSwitch1088_g61063;
					float4 lerpResult442_g61063 = lerp( Lightmap_0925_g61063 , Lightmap_1956_g61063 , _LightmapLerp);
					float4 Lightmap_Lerp932_g61063 = lerpResult442_g61063;
					float3 appendResult139_g61099 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g61099 = normalize( Normal_Map700_g61063 );
					float3 Normal_Map318_g61099 = normalizeResult326_g61099;
					float dotResult121_g61099 = dot( appendResult139_g61099 , Normal_Map318_g61099 );
					float2 texCoord1070_g61063 = IN.ase_texcoord6.zw * float2( 1,1 ) + float2( 0,0 );
					float localStochasticTiling2_g61104 = ( 0.0 );
					float2 uv3_RNMX0 = IN.ase_texcoord6.zw * _RNMX0_ST.xy + _RNMX0_ST.zw;
					float2 UV2_g61104 = uv3_RNMX0;
					float4 TexelSize2_g61104 = _RNMX0_TexelSize;
					float4 Offsets2_g61104 = float4( 0,0,0,0 );
					float2 Weights2_g61104 = float2( 0,0 );
					{
					UV2_g61104 = UV2_g61104 * TexelSize2_g61104.zw - 0.5;
					float2 f = frac( UV2_g61104 );
					UV2_g61104 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g61104.x - 0.5, UV2_g61104.x + 1.5, UV2_g61104.y - 0.5, UV2_g61104.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g61104 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g61104.xyxy;
					Weights2_g61104 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g61103 = Offsets2_g61104;
					float4 Input_FetchOffsets197_g61107 = temp_output_1_34_g61103;
					float2 temp_output_1_54_g61103 = Weights2_g61104;
					float2 Input_FetchWeights200_g61107 = temp_output_1_54_g61103;
					float2 break187_g61107 = Input_FetchWeights200_g61107;
					float4 lerpResult181_g61107 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g61107).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g61107).xw ) , break187_g61107.x);
					float4 lerpResult182_g61107 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g61107).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g61107).xz ) , break187_g61107.x);
					float4 lerpResult176_g61107 = lerp( lerpResult181_g61107 , lerpResult182_g61107 , break187_g61107.y);
					float4 Output_Fetch2D202_g61107 = lerpResult176_g61107;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g61063 = Output_Fetch2D202_g61107;
					#else
					float4 staticSwitch1061_g61063 = tex2D( _RNMX0, texCoord1070_g61063 );
					#endif
					float3 appendResult146_g61099 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g61099 = dot( appendResult146_g61099 , Normal_Map318_g61099 );
					float4 Input_FetchOffsets197_g61105 = temp_output_1_34_g61103;
					float2 Input_FetchWeights200_g61105 = temp_output_1_54_g61103;
					float2 break187_g61105 = Input_FetchWeights200_g61105;
					float4 lerpResult181_g61105 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g61105).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g61105).xw ) , break187_g61105.x);
					float4 lerpResult182_g61105 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g61105).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g61105).xz ) , break187_g61105.x);
					float4 lerpResult176_g61105 = lerp( lerpResult181_g61105 , lerpResult182_g61105 , break187_g61105.y);
					float4 Output_Fetch2D202_g61105 = lerpResult176_g61105;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g61063 = Output_Fetch2D202_g61105;
					#else
					float4 staticSwitch1062_g61063 = tex2D( _RNMY0, texCoord1070_g61063 );
					#endif
					float3 appendResult149_g61099 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g61099 = dot( appendResult149_g61099 , Normal_Map318_g61099 );
					float4 Input_FetchOffsets197_g61106 = temp_output_1_34_g61103;
					float2 Input_FetchWeights200_g61106 = temp_output_1_54_g61103;
					float2 break187_g61106 = Input_FetchWeights200_g61106;
					float4 lerpResult181_g61106 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g61106).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g61106).xw ) , break187_g61106.x);
					float4 lerpResult182_g61106 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g61106).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g61106).xz ) , break187_g61106.x);
					float4 lerpResult176_g61106 = lerp( lerpResult181_g61106 , lerpResult182_g61106 , break187_g61106.y);
					float4 Output_Fetch2D202_g61106 = lerpResult176_g61106;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g61063 = Output_Fetch2D202_g61106;
					#else
					float4 staticSwitch1063_g61063 = tex2D( _RNMZ0, texCoord1070_g61063 );
					#endif
					float4 RNM_0926_g61063 = ( ( ( dotResult121_g61099 * ( staticSwitch1061_g61063 * 0.5 ) ) + ( dotResult122_g61099 * ( staticSwitch1062_g61063 * 0.5 ) ) ) + ( dotResult120_g61099 * ( staticSwitch1063_g61063 * 0.5 ) ) );
					float3 appendResult139_g61100 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g61100 = normalize( Normal_Map700_g61063 );
					float3 Normal_Map318_g61100 = normalizeResult326_g61100;
					float dotResult121_g61100 = dot( appendResult139_g61100 , Normal_Map318_g61100 );
					float2 texCoord1086_g61063 = IN.ase_texcoord6.zw * float2( 1,1 ) + float2( 0,0 );
					float localStochasticTiling2_g61091 = ( 0.0 );
					float2 uv3_RNMX1 = IN.ase_texcoord6.zw * _RNMX1_ST.xy + _RNMX1_ST.zw;
					float2 UV2_g61091 = uv3_RNMX1;
					float4 TexelSize2_g61091 = _RNMX1_TexelSize;
					float4 Offsets2_g61091 = float4( 0,0,0,0 );
					float2 Weights2_g61091 = float2( 0,0 );
					{
					UV2_g61091 = UV2_g61091 * TexelSize2_g61091.zw - 0.5;
					float2 f = frac( UV2_g61091 );
					UV2_g61091 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g61091.x - 0.5, UV2_g61091.x + 1.5, UV2_g61091.y - 0.5, UV2_g61091.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g61091 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g61091.xyxy;
					Weights2_g61091 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g61090 = Offsets2_g61091;
					float4 Input_FetchOffsets197_g61094 = temp_output_1_34_g61090;
					float2 temp_output_1_54_g61090 = Weights2_g61091;
					float2 Input_FetchWeights200_g61094 = temp_output_1_54_g61090;
					float2 break187_g61094 = Input_FetchWeights200_g61094;
					float4 lerpResult181_g61094 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g61094).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g61094).xw ) , break187_g61094.x);
					float4 lerpResult182_g61094 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g61094).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g61094).xz ) , break187_g61094.x);
					float4 lerpResult176_g61094 = lerp( lerpResult181_g61094 , lerpResult182_g61094 , break187_g61094.y);
					float4 Output_Fetch2D202_g61094 = lerpResult176_g61094;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g61063 = Output_Fetch2D202_g61094;
					#else
					float4 staticSwitch1087_g61063 = tex2D( _RNMX1, texCoord1086_g61063 );
					#endif
					float3 appendResult146_g61100 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g61100 = dot( appendResult146_g61100 , Normal_Map318_g61100 );
					float4 Input_FetchOffsets197_g61092 = temp_output_1_34_g61090;
					float2 Input_FetchWeights200_g61092 = temp_output_1_54_g61090;
					float2 break187_g61092 = Input_FetchWeights200_g61092;
					float4 lerpResult181_g61092 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g61092).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g61092).xw ) , break187_g61092.x);
					float4 lerpResult182_g61092 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g61092).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g61092).xz ) , break187_g61092.x);
					float4 lerpResult176_g61092 = lerp( lerpResult181_g61092 , lerpResult182_g61092 , break187_g61092.y);
					float4 Output_Fetch2D202_g61092 = lerpResult176_g61092;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g61063 = Output_Fetch2D202_g61092;
					#else
					float4 staticSwitch1083_g61063 = tex2D( _RNMY1, texCoord1086_g61063 );
					#endif
					float3 appendResult149_g61100 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g61100 = dot( appendResult149_g61100 , Normal_Map318_g61100 );
					float4 Input_FetchOffsets197_g61093 = temp_output_1_34_g61090;
					float2 Input_FetchWeights200_g61093 = temp_output_1_54_g61090;
					float2 break187_g61093 = Input_FetchWeights200_g61093;
					float4 lerpResult181_g61093 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g61093).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g61093).xw ) , break187_g61093.x);
					float4 lerpResult182_g61093 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g61093).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g61093).xz ) , break187_g61093.x);
					float4 lerpResult176_g61093 = lerp( lerpResult181_g61093 , lerpResult182_g61093 , break187_g61093.y);
					float4 Output_Fetch2D202_g61093 = lerpResult176_g61093;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g61063 = Output_Fetch2D202_g61093;
					#else
					float4 staticSwitch1084_g61063 = tex2D( _RNMZ1, texCoord1086_g61063 );
					#endif
					float4 RNM_11081_g61063 = ( ( ( dotResult121_g61100 * ( staticSwitch1087_g61063 * 0.5 ) ) + ( dotResult122_g61100 * ( staticSwitch1083_g61063 * 0.5 ) ) ) + ( dotResult120_g61100 * ( staticSwitch1084_g61063 * 0.5 ) ) );
					float Lightmap_Lerp_Value969_g61063 = _LightmapLerp;
					float4 lerpResult953_g61063 = lerp( RNM_0926_g61063 , RNM_11081_g61063 , Lightmap_Lerp_Value969_g61063);
					float4 RNM_Lerp950_g61063 = lerpResult953_g61063;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g61063 = temp_cast_1;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g61063 = Lightmap_0925_g61063;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g61063 = Lightmap_Lerp932_g61063;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g61063 = RNM_0926_g61063;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g61063 = RNM_Lerp950_g61063;
					#else
					float4 staticSwitch1014_g61063 = temp_cast_1;
					#endif
					float4 Lightmap46_g61063 = staticSwitch1014_g61063;
					float3 linearToGamma1047_g61063 = LinearToGammaSpace( Lightmap46_g61063.rgb );
					float grayscale1048_g61063 = dot( linearToGamma1047_g61063, float3( 0.299, 0.587, 0.114 ) );
					float saferPower606_g61063 = abs( grayscale1048_g61063 );
					#ifdef _LIGHTMAPOCCLUSIONENABLED_ON
					float staticSwitch1018_g61063 = pow( saferPower606_g61063 , _OcclusionPower );
					#else
					float staticSwitch1018_g61063 = White38_g61063;
					#endif
					#if defined( _LIGHTMAPMODE_DISABLED )
					float staticSwitch1016_g61063 = White38_g61063;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float staticSwitch1016_g61063 = staticSwitch1018_g61063;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float staticSwitch1016_g61063 = staticSwitch1018_g61063;
					#elif defined( _LIGHTMAPMODE_RNM )
					float staticSwitch1016_g61063 = staticSwitch1018_g61063;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float staticSwitch1016_g61063 = staticSwitch1018_g61063;
					#else
					float staticSwitch1016_g61063 = White38_g61063;
					#endif
					float fresnelNdotV1050_g61063 = dot( NormalWS, ViewDirWS );
					float f01050_g61063 = 0.5;
					float fresnelNode1050_g61063 = ( f01050_g61063 + ( 1.0 - f01050_g61063 ) * pow( max( 1.0 - fresnelNdotV1050_g61063 , 0.0001 ), 5 ) );
					float clampResult1031_g61063 = clamp( ( staticSwitch1016_g61063 + fresnelNode1050_g61063 ) , 0.0 , 1.0 );
					float Lightmap_Occlusion1025_g61063 = clampResult1031_g61063;
					float2 uv_GlossinessMap64_g61063 = IN.ase_texcoord6.xy;
					float2 uv_GlossinessMap = IN.ase_texcoord6.xy * _GlossinessMap_ST.xy + _GlossinessMap_ST.zw;
					float2 temp_output_5_0_g61074 = uv_GlossinessMap;
					float2 UV633_g61074 = temp_output_5_0_g61074;
					float2 UV100_g61075 = UV633_g61074;
					float2 temp_output_51_0_g61075 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g61075 * float2( 3.464,3.464 ) ) );
					float2 break55_g61075 = frac( temp_output_51_0_g61075 );
					float temp_output_56_0_g61075 = ( ( 1.0 - break55_g61075.x ) - break55_g61075.y );
					float2 temp_output_52_0_g61075 = floor( temp_output_51_0_g61075 );
					float2 temp_output_125_0_g61075 = ( temp_output_52_0_g61075 + float2( 1,1 ) );
					float2 ifLocalVar87_g61075 = 0;
					if( temp_output_56_0_g61075 > 0.0 )
					ifLocalVar87_g61075 = temp_output_52_0_g61075;
					else if( temp_output_56_0_g61075 == 0.0 )
					ifLocalVar87_g61075 = temp_output_125_0_g61075;
					else if( temp_output_56_0_g61075 < 0.0 )
					ifLocalVar87_g61075 = temp_output_125_0_g61075;
					float3 temp_output_7_0_g61076 = frac( ( (ifLocalVar87_g61075).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61076 = dot( temp_output_7_0_g61076 , ( (temp_output_7_0_g61076).yzx + 33.33 ) );
					float3 temp_output_12_0_g61076 = ( temp_output_7_0_g61076 + dotResult8_g61076 );
					float2 temp_output_597_0_g61074 = ( UV100_g61075 + frac( ( ( (temp_output_12_0_g61076).xx + (temp_output_12_0_g61076).yz ) * (temp_output_12_0_g61076).zy ) ) );
					float2 DDX631_g61074 = ddx( temp_output_5_0_g61074 );
					float2 DDY632_g61074 = ddy( temp_output_5_0_g61074 );
					float temp_output_65_0_g61075 = ( 0.0 - temp_output_56_0_g61075 );
					float ifLocalVar59_g61075 = 0;
					if( temp_output_56_0_g61075 <= 0.0 )
					ifLocalVar59_g61075 = temp_output_65_0_g61075;
					else
					ifLocalVar59_g61075 = temp_output_56_0_g61075;
					float temp_output_597_30_g61074 = ifLocalVar59_g61075;
					float2 temp_output_90_0_g61075 = ( temp_output_52_0_g61075 + float2( 0,1 ) );
					float2 temp_output_123_0_g61075 = ( temp_output_52_0_g61075 + float2( 1,0 ) );
					float2 ifLocalVar88_g61075 = 0;
					if( temp_output_56_0_g61075 > 0.0 )
					ifLocalVar88_g61075 = temp_output_90_0_g61075;
					else if( temp_output_56_0_g61075 == 0.0 )
					ifLocalVar88_g61075 = temp_output_123_0_g61075;
					else if( temp_output_56_0_g61075 < 0.0 )
					ifLocalVar88_g61075 = temp_output_123_0_g61075;
					float3 temp_output_7_0_g61077 = frac( ( (ifLocalVar88_g61075).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61077 = dot( temp_output_7_0_g61077 , ( (temp_output_7_0_g61077).yzx + 33.33 ) );
					float3 temp_output_12_0_g61077 = ( temp_output_7_0_g61077 + dotResult8_g61077 );
					float2 temp_output_597_26_g61074 = ( UV100_g61075 + frac( ( ( (temp_output_12_0_g61077).xx + (temp_output_12_0_g61077).yz ) * (temp_output_12_0_g61077).zy ) ) );
					float temp_output_66_0_g61075 = ( 1.0 - break55_g61075.y );
					float ifLocalVar60_g61075 = 0;
					if( temp_output_56_0_g61075 <= 0.0 )
					ifLocalVar60_g61075 = temp_output_66_0_g61075;
					else
					ifLocalVar60_g61075 = break55_g61075.y;
					float temp_output_597_28_g61074 = ifLocalVar60_g61075;
					float2 ifLocalVar89_g61075 = 0;
					if( temp_output_56_0_g61075 > 0.0 )
					ifLocalVar89_g61075 = temp_output_123_0_g61075;
					else if( temp_output_56_0_g61075 == 0.0 )
					ifLocalVar89_g61075 = temp_output_90_0_g61075;
					else if( temp_output_56_0_g61075 < 0.0 )
					ifLocalVar89_g61075 = temp_output_90_0_g61075;
					float3 temp_output_7_0_g61078 = frac( ( (ifLocalVar89_g61075).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61078 = dot( temp_output_7_0_g61078 , ( (temp_output_7_0_g61078).yzx + 33.33 ) );
					float3 temp_output_12_0_g61078 = ( temp_output_7_0_g61078 + dotResult8_g61078 );
					float2 temp_output_597_27_g61074 = ( UV100_g61075 + frac( ( ( (temp_output_12_0_g61078).xx + (temp_output_12_0_g61078).yz ) * (temp_output_12_0_g61078).zy ) ) );
					float temp_output_67_0_g61075 = ( 1.0 - break55_g61075.x );
					float ifLocalVar61_g61075 = 0;
					if( temp_output_56_0_g61075 <= 0.0 )
					ifLocalVar61_g61075 = temp_output_67_0_g61075;
					else
					ifLocalVar61_g61075 = break55_g61075.x;
					float temp_output_597_29_g61074 = ifLocalVar61_g61075;
					float4 Output_2D293_g61074 = ( ( tex2D( _GlossinessMap, temp_output_597_0_g61074, DDX631_g61074, DDY632_g61074 ) * temp_output_597_30_g61074 ) + ( tex2D( _GlossinessMap, temp_output_597_26_g61074, DDX631_g61074, DDY632_g61074 ) * temp_output_597_28_g61074 ) + ( tex2D( _GlossinessMap, temp_output_597_27_g61074, DDX631_g61074, DDY632_g61074 ) * temp_output_597_29_g61074 ) );
					float4 break31_g61074 = Output_2D293_g61074;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g61063 = break31_g61074.a;
					#else
					float staticSwitch1004_g61063 = tex2D( _GlossinessMap, uv_GlossinessMap64_g61063 ).a;
					#endif
					float saferPower804_g61063 = abs( staticSwitch1004_g61063 );
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g61063 = ( 1.0 - pow( saferPower804_g61063 , 3.0 ) );
					#else
					float staticSwitch845_g61063 = _Glossiness;
					#endif
					float temp_output_1030_0_g61063 = ( Lightmap_Occlusion1025_g61063 * staticSwitch845_g61063 );
					float3 temp_output_3_0_g61084 = ddx( NormalWS );
					float dotResult5_g61084 = dot( temp_output_3_0_g61084 , temp_output_3_0_g61084 );
					float3 temp_output_4_0_g61084 = ddy( NormalWS );
					float dotResult6_g61084 = dot( temp_output_4_0_g61084 , temp_output_4_0_g61084 );
					#ifdef _USEGEOMETRICANTIALIASING_ON
					float staticSwitch824_g61063 = min( temp_output_1030_0_g61063 , ( 1.0 - pow( saturate( max( dotResult5_g61084 , dotResult6_g61084 ) ) , 0.333 ) ) );
					#else
					float staticSwitch824_g61063 = temp_output_1030_0_g61063;
					#endif
					
					float4 temp_output_614_0_g61063 = ( Albedo6_g61063 * ( ( 1.0 - Metallic699_g61063 ) * Lightmap46_g61063 ) );
					float4 temp_cast_4 = 0;
					float2 uv_EmissionMap81_g61063 = IN.ase_texcoord6.xy;
					float2 uv_EmissionMap = IN.ase_texcoord6.xy * _EmissionMap_ST.xy + _EmissionMap_ST.zw;
					float2 temp_output_5_0_g61064 = uv_EmissionMap;
					float2 UV633_g61064 = temp_output_5_0_g61064;
					float2 UV100_g61065 = UV633_g61064;
					float2 temp_output_51_0_g61065 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g61065 * float2( 3.464,3.464 ) ) );
					float2 break55_g61065 = frac( temp_output_51_0_g61065 );
					float temp_output_56_0_g61065 = ( ( 1.0 - break55_g61065.x ) - break55_g61065.y );
					float2 temp_output_52_0_g61065 = floor( temp_output_51_0_g61065 );
					float2 temp_output_125_0_g61065 = ( temp_output_52_0_g61065 + float2( 1,1 ) );
					float2 ifLocalVar87_g61065 = 0;
					if( temp_output_56_0_g61065 > 0.0 )
					ifLocalVar87_g61065 = temp_output_52_0_g61065;
					else if( temp_output_56_0_g61065 == 0.0 )
					ifLocalVar87_g61065 = temp_output_125_0_g61065;
					else if( temp_output_56_0_g61065 < 0.0 )
					ifLocalVar87_g61065 = temp_output_125_0_g61065;
					float3 temp_output_7_0_g61066 = frac( ( (ifLocalVar87_g61065).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61066 = dot( temp_output_7_0_g61066 , ( (temp_output_7_0_g61066).yzx + 33.33 ) );
					float3 temp_output_12_0_g61066 = ( temp_output_7_0_g61066 + dotResult8_g61066 );
					float2 temp_output_597_0_g61064 = ( UV100_g61065 + frac( ( ( (temp_output_12_0_g61066).xx + (temp_output_12_0_g61066).yz ) * (temp_output_12_0_g61066).zy ) ) );
					float2 DDX631_g61064 = ddx( temp_output_5_0_g61064 );
					float2 DDY632_g61064 = ddy( temp_output_5_0_g61064 );
					float temp_output_65_0_g61065 = ( 0.0 - temp_output_56_0_g61065 );
					float ifLocalVar59_g61065 = 0;
					if( temp_output_56_0_g61065 <= 0.0 )
					ifLocalVar59_g61065 = temp_output_65_0_g61065;
					else
					ifLocalVar59_g61065 = temp_output_56_0_g61065;
					float temp_output_597_30_g61064 = ifLocalVar59_g61065;
					float2 temp_output_90_0_g61065 = ( temp_output_52_0_g61065 + float2( 0,1 ) );
					float2 temp_output_123_0_g61065 = ( temp_output_52_0_g61065 + float2( 1,0 ) );
					float2 ifLocalVar88_g61065 = 0;
					if( temp_output_56_0_g61065 > 0.0 )
					ifLocalVar88_g61065 = temp_output_90_0_g61065;
					else if( temp_output_56_0_g61065 == 0.0 )
					ifLocalVar88_g61065 = temp_output_123_0_g61065;
					else if( temp_output_56_0_g61065 < 0.0 )
					ifLocalVar88_g61065 = temp_output_123_0_g61065;
					float3 temp_output_7_0_g61067 = frac( ( (ifLocalVar88_g61065).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61067 = dot( temp_output_7_0_g61067 , ( (temp_output_7_0_g61067).yzx + 33.33 ) );
					float3 temp_output_12_0_g61067 = ( temp_output_7_0_g61067 + dotResult8_g61067 );
					float2 temp_output_597_26_g61064 = ( UV100_g61065 + frac( ( ( (temp_output_12_0_g61067).xx + (temp_output_12_0_g61067).yz ) * (temp_output_12_0_g61067).zy ) ) );
					float temp_output_66_0_g61065 = ( 1.0 - break55_g61065.y );
					float ifLocalVar60_g61065 = 0;
					if( temp_output_56_0_g61065 <= 0.0 )
					ifLocalVar60_g61065 = temp_output_66_0_g61065;
					else
					ifLocalVar60_g61065 = break55_g61065.y;
					float temp_output_597_28_g61064 = ifLocalVar60_g61065;
					float2 ifLocalVar89_g61065 = 0;
					if( temp_output_56_0_g61065 > 0.0 )
					ifLocalVar89_g61065 = temp_output_123_0_g61065;
					else if( temp_output_56_0_g61065 == 0.0 )
					ifLocalVar89_g61065 = temp_output_90_0_g61065;
					else if( temp_output_56_0_g61065 < 0.0 )
					ifLocalVar89_g61065 = temp_output_90_0_g61065;
					float3 temp_output_7_0_g61068 = frac( ( (ifLocalVar89_g61065).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61068 = dot( temp_output_7_0_g61068 , ( (temp_output_7_0_g61068).yzx + 33.33 ) );
					float3 temp_output_12_0_g61068 = ( temp_output_7_0_g61068 + dotResult8_g61068 );
					float2 temp_output_597_27_g61064 = ( UV100_g61065 + frac( ( ( (temp_output_12_0_g61068).xx + (temp_output_12_0_g61068).yz ) * (temp_output_12_0_g61068).zy ) ) );
					float temp_output_67_0_g61065 = ( 1.0 - break55_g61065.x );
					float ifLocalVar61_g61065 = 0;
					if( temp_output_56_0_g61065 <= 0.0 )
					ifLocalVar61_g61065 = temp_output_67_0_g61065;
					else
					ifLocalVar61_g61065 = break55_g61065.x;
					float temp_output_597_29_g61064 = ifLocalVar61_g61065;
					float4 Output_2D293_g61064 = ( ( tex2D( _EmissionMap, temp_output_597_0_g61064, DDX631_g61064, DDY632_g61064 ) * temp_output_597_30_g61064 ) + ( tex2D( _EmissionMap, temp_output_597_26_g61064, DDX631_g61064, DDY632_g61064 ) * temp_output_597_28_g61064 ) + ( tex2D( _EmissionMap, temp_output_597_27_g61064, DDX631_g61064, DDY632_g61064 ) * temp_output_597_29_g61064 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g61063 = Output_2D293_g61064;
					#else
					float4 staticSwitch1006_g61063 = tex2D( _EmissionMap, uv_EmissionMap81_g61063 );
					#endif
					#ifdef _EMISSIONENABLED_ON
					float4 staticSwitch1017_g61063 = ( _EmissionColor + staticSwitch1006_g61063 );
					#else
					float4 staticSwitch1017_g61063 = temp_cast_4;
					#endif
					float4 Emission86_g61063 = staticSwitch1017_g61063;
					float4 temp_output_690_0_g61063 = ( Emission86_g61063 + temp_output_614_0_g61063 );
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1019_g61063 = ( temp_output_614_0_g61063 * Emission86_g61063 );
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1019_g61063 = temp_output_690_0_g61063;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1019_g61063 = temp_output_690_0_g61063;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1019_g61063 = temp_output_690_0_g61063;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1019_g61063 = temp_output_690_0_g61063;
					#else
					float4 staticSwitch1019_g61063 = ( temp_output_614_0_g61063 * Emission86_g61063 );
					#endif
					float3 temp_output_35_0_g61101 = staticSwitch1019_g61063.rgb;
					float3 Color353_g61101 = temp_output_35_0_g61101;
					#if defined( _LUTMODE_2D )
					float3 staticSwitch273_g61101 = saturate( temp_output_35_0_g61101 );
					#elif defined( _LUTMODE_3D )
					float3 staticSwitch273_g61101 = temp_output_35_0_g61101;
					#else
					float3 staticSwitch273_g61101 = temp_output_35_0_g61101;
					#endif
					float3 Color_Saturate49_g61101 = staticSwitch273_g61101;
					float Lut_Height213_g61101 = _LUTSize;
					float Lut_Width216_g61101 = ( _LUTSize * Lut_Height213_g61101 );
					float3 appendResult214_g61101 = (float3(( 1.0 / Lut_Width216_g61101 ) , ( 1.0 / Lut_Height213_g61101 ) , ( Lut_Height213_g61101 - 1.0 )));
					float3 Scale_Offset208_g61101 = appendResult214_g61101;
					float2 Scale_Factor292_g61101 = ( (Scale_Offset208_g61101).xy * (Scale_Offset208_g61101).z );
					float2 Offset299_g61101 = ( (Scale_Offset208_g61101).xy * 0.5 );
					float2 Adjusted_UV305_g61101 = ( ( (Color_Saturate49_g61101).xy * Scale_Factor292_g61101 ) + Offset299_g61101 );
					float Scaled_Blue280_g61101 = ( (Color_Saturate49_g61101).z * (Scale_Offset208_g61101).z );
					float Shift288_g61101 = floor( Scaled_Blue280_g61101 );
					float Final_X313_g61101 = ( (Adjusted_UV305_g61101).x + ( Shift288_g61101 * (Scale_Offset208_g61101).y ) );
					float2 appendResult326_g61101 = (float2(Final_X313_g61101 , (Adjusted_UV305_g61101).y));
					float2 Final_UV325_g61101 = appendResult326_g61101;
					float2 appendResult338_g61101 = (float2((Scale_Offset208_g61101).y , 0.0));
					float2 Offset_UV336_g61101 = ( Final_UV325_g61101 + appendResult338_g61101 );
					float3 lerpResult333_g61101 = lerp( tex2D( _2DLut, Final_UV325_g61101 ).rgb , tex2D( _2DLut, Offset_UV336_g61101 ).rgb , ( Scaled_Blue280_g61101 - Shift288_g61101 ));
					#ifdef _2DLUT
					float3 staticSwitch347_g61101 = lerpResult333_g61101;
					#else
					float3 staticSwitch347_g61101 = Color_Saturate49_g61101;
					#endif
					float3 TwoD_LUT346_g61101 = staticSwitch347_g61101;
					float3 RGB16_g61102 = ( ( log10( ( ( Color_Saturate49_g61101 * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 );
					#ifdef _3DLUT
					float3 staticSwitch194_g61101 = tex3D( _3DLut, RGB16_g61102 ).rgb;
					#else
					float3 staticSwitch194_g61101 = Color_Saturate49_g61101;
					#endif
					float3 ThreeD_LUT51_g61101 = staticSwitch194_g61101;
					#if defined( _LUTMODE_2D )
					float3 staticSwitch42_g61101 = TwoD_LUT346_g61101;
					#elif defined( _LUTMODE_3D )
					float3 staticSwitch42_g61101 = ThreeD_LUT51_g61101;
					#else
					float3 staticSwitch42_g61101 = ThreeD_LUT51_g61101;
					#endif
					#ifdef SHADER_API_MOBILE
					float3 staticSwitch41_g61101 = staticSwitch42_g61101;
					#else
					float3 staticSwitch41_g61101 = Color353_g61101;
					#endif
					

					o.Albedo = Albedo6_g61063.rgb;
					o.Normal = Normal_Map700_g61063;

					half3 Specular = half3( 0, 0, 0 );
					half Metallic = Metallic699_g61063;
					half Smoothness = staticSwitch824_g61063;
					half Occlusion = staticSwitch1016_g61063;

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

					o.Emission = staticSwitch41_g61101;
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
				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
				#define ASE_NEEDS_TEXTURE_COORDINATES2
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
				#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
				#define ASE_NEEDS_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_NORMAL
				#pragma shader_feature_local _STOCHASTICENABLED_ON
				#pragma shader_feature_local_fragment _BUMPMAP
				#pragma shader_feature_local_fragment _METALLICMAP
				#pragma shader_feature_local_fragment _USEGEOMETRICANTIALIASING_ON
				#pragma shader_feature_local _LIGHTMAPMODE_DISABLED _LIGHTMAPMODE_SIMPLE _LIGHTMAPMODE_SIMPLELERP _LIGHTMAPMODE_RNM _LIGHTMAPMODE_RNMLERP
				#pragma shader_feature_local _LIGHTMAPOCCLUSIONENABLED_ON
				#pragma shader_feature_local _USEBICUBICFILTERING_ON
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
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				uniform float4 _MetallicMap_ST;
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
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				uniform float4 _GlossinessMap_ST;
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

					float2 uv_MainTex907_g61063 = IN.ase_texcoord5.xy;
					float2 uv_MainTex = IN.ase_texcoord5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					float2 temp_output_5_0_g61085 = uv_MainTex;
					float2 UV633_g61085 = temp_output_5_0_g61085;
					float2 UV100_g61086 = UV633_g61085;
					float2 temp_output_51_0_g61086 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g61086 * float2( 3.464,3.464 ) ) );
					float2 break55_g61086 = frac( temp_output_51_0_g61086 );
					float temp_output_56_0_g61086 = ( ( 1.0 - break55_g61086.x ) - break55_g61086.y );
					float2 temp_output_52_0_g61086 = floor( temp_output_51_0_g61086 );
					float2 temp_output_125_0_g61086 = ( temp_output_52_0_g61086 + float2( 1,1 ) );
					float2 ifLocalVar87_g61086 = 0;
					if( temp_output_56_0_g61086 > 0.0 )
					ifLocalVar87_g61086 = temp_output_52_0_g61086;
					else if( temp_output_56_0_g61086 == 0.0 )
					ifLocalVar87_g61086 = temp_output_125_0_g61086;
					else if( temp_output_56_0_g61086 < 0.0 )
					ifLocalVar87_g61086 = temp_output_125_0_g61086;
					float3 temp_output_7_0_g61087 = frac( ( (ifLocalVar87_g61086).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61087 = dot( temp_output_7_0_g61087 , ( (temp_output_7_0_g61087).yzx + 33.33 ) );
					float3 temp_output_12_0_g61087 = ( temp_output_7_0_g61087 + dotResult8_g61087 );
					float2 temp_output_597_0_g61085 = ( UV100_g61086 + frac( ( ( (temp_output_12_0_g61087).xx + (temp_output_12_0_g61087).yz ) * (temp_output_12_0_g61087).zy ) ) );
					float2 DDX631_g61085 = ddx( temp_output_5_0_g61085 );
					float2 DDY632_g61085 = ddy( temp_output_5_0_g61085 );
					float temp_output_65_0_g61086 = ( 0.0 - temp_output_56_0_g61086 );
					float ifLocalVar59_g61086 = 0;
					if( temp_output_56_0_g61086 <= 0.0 )
					ifLocalVar59_g61086 = temp_output_65_0_g61086;
					else
					ifLocalVar59_g61086 = temp_output_56_0_g61086;
					float temp_output_597_30_g61085 = ifLocalVar59_g61086;
					float2 temp_output_90_0_g61086 = ( temp_output_52_0_g61086 + float2( 0,1 ) );
					float2 temp_output_123_0_g61086 = ( temp_output_52_0_g61086 + float2( 1,0 ) );
					float2 ifLocalVar88_g61086 = 0;
					if( temp_output_56_0_g61086 > 0.0 )
					ifLocalVar88_g61086 = temp_output_90_0_g61086;
					else if( temp_output_56_0_g61086 == 0.0 )
					ifLocalVar88_g61086 = temp_output_123_0_g61086;
					else if( temp_output_56_0_g61086 < 0.0 )
					ifLocalVar88_g61086 = temp_output_123_0_g61086;
					float3 temp_output_7_0_g61088 = frac( ( (ifLocalVar88_g61086).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61088 = dot( temp_output_7_0_g61088 , ( (temp_output_7_0_g61088).yzx + 33.33 ) );
					float3 temp_output_12_0_g61088 = ( temp_output_7_0_g61088 + dotResult8_g61088 );
					float2 temp_output_597_26_g61085 = ( UV100_g61086 + frac( ( ( (temp_output_12_0_g61088).xx + (temp_output_12_0_g61088).yz ) * (temp_output_12_0_g61088).zy ) ) );
					float temp_output_66_0_g61086 = ( 1.0 - break55_g61086.y );
					float ifLocalVar60_g61086 = 0;
					if( temp_output_56_0_g61086 <= 0.0 )
					ifLocalVar60_g61086 = temp_output_66_0_g61086;
					else
					ifLocalVar60_g61086 = break55_g61086.y;
					float temp_output_597_28_g61085 = ifLocalVar60_g61086;
					float2 ifLocalVar89_g61086 = 0;
					if( temp_output_56_0_g61086 > 0.0 )
					ifLocalVar89_g61086 = temp_output_123_0_g61086;
					else if( temp_output_56_0_g61086 == 0.0 )
					ifLocalVar89_g61086 = temp_output_90_0_g61086;
					else if( temp_output_56_0_g61086 < 0.0 )
					ifLocalVar89_g61086 = temp_output_90_0_g61086;
					float3 temp_output_7_0_g61089 = frac( ( (ifLocalVar89_g61086).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61089 = dot( temp_output_7_0_g61089 , ( (temp_output_7_0_g61089).yzx + 33.33 ) );
					float3 temp_output_12_0_g61089 = ( temp_output_7_0_g61089 + dotResult8_g61089 );
					float2 temp_output_597_27_g61085 = ( UV100_g61086 + frac( ( ( (temp_output_12_0_g61089).xx + (temp_output_12_0_g61089).yz ) * (temp_output_12_0_g61089).zy ) ) );
					float temp_output_67_0_g61086 = ( 1.0 - break55_g61086.x );
					float ifLocalVar61_g61086 = 0;
					if( temp_output_56_0_g61086 <= 0.0 )
					ifLocalVar61_g61086 = temp_output_67_0_g61086;
					else
					ifLocalVar61_g61086 = break55_g61086.x;
					float temp_output_597_29_g61085 = ifLocalVar61_g61086;
					float4 Output_2D293_g61085 = ( ( tex2D( _MainTex, temp_output_597_0_g61085, DDX631_g61085, DDY632_g61085 ) * temp_output_597_30_g61085 ) + ( tex2D( _MainTex, temp_output_597_26_g61085, DDX631_g61085, DDY632_g61085 ) * temp_output_597_28_g61085 ) + ( tex2D( _MainTex, temp_output_597_27_g61085, DDX631_g61085, DDY632_g61085 ) * temp_output_597_29_g61085 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g61063 = Output_2D293_g61085;
					#else
					float4 staticSwitch1001_g61063 = tex2D( _MainTex, uv_MainTex907_g61063 );
					#endif
					float4 temp_output_976_0_g61063 = ( _Color * staticSwitch1001_g61063 );
					float4 Albedo6_g61063 = temp_output_976_0_g61063;
					
					float2 uv_BumpMap830_g61063 = IN.ase_texcoord5.xy;
					float2 uv_BumpMap = IN.ase_texcoord5.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					float2 temp_output_5_0_g61079 = uv_BumpMap;
					float2 UV633_g61079 = temp_output_5_0_g61079;
					float2 UV100_g61080 = UV633_g61079;
					float2 temp_output_51_0_g61080 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g61080 * float2( 3.464,3.464 ) ) );
					float2 break55_g61080 = frac( temp_output_51_0_g61080 );
					float temp_output_56_0_g61080 = ( ( 1.0 - break55_g61080.x ) - break55_g61080.y );
					float2 temp_output_52_0_g61080 = floor( temp_output_51_0_g61080 );
					float2 temp_output_125_0_g61080 = ( temp_output_52_0_g61080 + float2( 1,1 ) );
					float2 ifLocalVar87_g61080 = 0;
					if( temp_output_56_0_g61080 > 0.0 )
					ifLocalVar87_g61080 = temp_output_52_0_g61080;
					else if( temp_output_56_0_g61080 == 0.0 )
					ifLocalVar87_g61080 = temp_output_125_0_g61080;
					else if( temp_output_56_0_g61080 < 0.0 )
					ifLocalVar87_g61080 = temp_output_125_0_g61080;
					float3 temp_output_7_0_g61081 = frac( ( (ifLocalVar87_g61080).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61081 = dot( temp_output_7_0_g61081 , ( (temp_output_7_0_g61081).yzx + 33.33 ) );
					float3 temp_output_12_0_g61081 = ( temp_output_7_0_g61081 + dotResult8_g61081 );
					float2 temp_output_597_0_g61079 = ( UV100_g61080 + frac( ( ( (temp_output_12_0_g61081).xx + (temp_output_12_0_g61081).yz ) * (temp_output_12_0_g61081).zy ) ) );
					float2 DDX631_g61079 = ddx( temp_output_5_0_g61079 );
					float2 DDY632_g61079 = ddy( temp_output_5_0_g61079 );
					float Input_Scale617_g61079 = _NormalScale;
					float temp_output_65_0_g61080 = ( 0.0 - temp_output_56_0_g61080 );
					float ifLocalVar59_g61080 = 0;
					if( temp_output_56_0_g61080 <= 0.0 )
					ifLocalVar59_g61080 = temp_output_65_0_g61080;
					else
					ifLocalVar59_g61080 = temp_output_56_0_g61080;
					float temp_output_597_30_g61079 = ifLocalVar59_g61080;
					float2 temp_output_90_0_g61080 = ( temp_output_52_0_g61080 + float2( 0,1 ) );
					float2 temp_output_123_0_g61080 = ( temp_output_52_0_g61080 + float2( 1,0 ) );
					float2 ifLocalVar88_g61080 = 0;
					if( temp_output_56_0_g61080 > 0.0 )
					ifLocalVar88_g61080 = temp_output_90_0_g61080;
					else if( temp_output_56_0_g61080 == 0.0 )
					ifLocalVar88_g61080 = temp_output_123_0_g61080;
					else if( temp_output_56_0_g61080 < 0.0 )
					ifLocalVar88_g61080 = temp_output_123_0_g61080;
					float3 temp_output_7_0_g61082 = frac( ( (ifLocalVar88_g61080).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61082 = dot( temp_output_7_0_g61082 , ( (temp_output_7_0_g61082).yzx + 33.33 ) );
					float3 temp_output_12_0_g61082 = ( temp_output_7_0_g61082 + dotResult8_g61082 );
					float2 temp_output_597_26_g61079 = ( UV100_g61080 + frac( ( ( (temp_output_12_0_g61082).xx + (temp_output_12_0_g61082).yz ) * (temp_output_12_0_g61082).zy ) ) );
					float temp_output_66_0_g61080 = ( 1.0 - break55_g61080.y );
					float ifLocalVar60_g61080 = 0;
					if( temp_output_56_0_g61080 <= 0.0 )
					ifLocalVar60_g61080 = temp_output_66_0_g61080;
					else
					ifLocalVar60_g61080 = break55_g61080.y;
					float temp_output_597_28_g61079 = ifLocalVar60_g61080;
					float2 ifLocalVar89_g61080 = 0;
					if( temp_output_56_0_g61080 > 0.0 )
					ifLocalVar89_g61080 = temp_output_123_0_g61080;
					else if( temp_output_56_0_g61080 == 0.0 )
					ifLocalVar89_g61080 = temp_output_90_0_g61080;
					else if( temp_output_56_0_g61080 < 0.0 )
					ifLocalVar89_g61080 = temp_output_90_0_g61080;
					float3 temp_output_7_0_g61083 = frac( ( (ifLocalVar89_g61080).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61083 = dot( temp_output_7_0_g61083 , ( (temp_output_7_0_g61083).yzx + 33.33 ) );
					float3 temp_output_12_0_g61083 = ( temp_output_7_0_g61083 + dotResult8_g61083 );
					float2 temp_output_597_27_g61079 = ( UV100_g61080 + frac( ( ( (temp_output_12_0_g61083).xx + (temp_output_12_0_g61083).yz ) * (temp_output_12_0_g61083).zy ) ) );
					float temp_output_67_0_g61080 = ( 1.0 - break55_g61080.x );
					float ifLocalVar61_g61080 = 0;
					if( temp_output_56_0_g61080 <= 0.0 )
					ifLocalVar61_g61080 = temp_output_67_0_g61080;
					else
					ifLocalVar61_g61080 = break55_g61080.x;
					float temp_output_597_29_g61079 = ifLocalVar61_g61080;
					float3 Output_2D_Normal641_g61079 = ( ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_0_g61079, DDX631_g61079, DDY632_g61079 ), Input_Scale617_g61079 ) * temp_output_597_30_g61079 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_26_g61079, DDX631_g61079, DDY632_g61079 ), Input_Scale617_g61079 ) * temp_output_597_28_g61079 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_27_g61079, DDX631_g61079, DDY632_g61079 ), Input_Scale617_g61079 ) * float3( 0,0,0 ) * temp_output_597_29_g61079 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g61063 = Output_2D_Normal641_g61079;
					#else
					float3 staticSwitch1003_g61063 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap830_g61063 ), _NormalScale );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g61063 = staticSwitch1003_g61063;
					#else
					float3 staticSwitch980_g61063 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g61063 = staticSwitch980_g61063;
					
					float2 uv_MetallicMap48_g61063 = IN.ase_texcoord5.xy;
					float2 uv_MetallicMap = IN.ase_texcoord5.xy * _MetallicMap_ST.xy + _MetallicMap_ST.zw;
					float2 temp_output_5_0_g61069 = uv_MetallicMap;
					float2 UV633_g61069 = temp_output_5_0_g61069;
					float2 UV100_g61070 = UV633_g61069;
					float2 temp_output_51_0_g61070 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g61070 * float2( 3.464,3.464 ) ) );
					float2 break55_g61070 = frac( temp_output_51_0_g61070 );
					float temp_output_56_0_g61070 = ( ( 1.0 - break55_g61070.x ) - break55_g61070.y );
					float2 temp_output_52_0_g61070 = floor( temp_output_51_0_g61070 );
					float2 temp_output_125_0_g61070 = ( temp_output_52_0_g61070 + float2( 1,1 ) );
					float2 ifLocalVar87_g61070 = 0;
					if( temp_output_56_0_g61070 > 0.0 )
					ifLocalVar87_g61070 = temp_output_52_0_g61070;
					else if( temp_output_56_0_g61070 == 0.0 )
					ifLocalVar87_g61070 = temp_output_125_0_g61070;
					else if( temp_output_56_0_g61070 < 0.0 )
					ifLocalVar87_g61070 = temp_output_125_0_g61070;
					float3 temp_output_7_0_g61071 = frac( ( (ifLocalVar87_g61070).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61071 = dot( temp_output_7_0_g61071 , ( (temp_output_7_0_g61071).yzx + 33.33 ) );
					float3 temp_output_12_0_g61071 = ( temp_output_7_0_g61071 + dotResult8_g61071 );
					float2 temp_output_597_0_g61069 = ( UV100_g61070 + frac( ( ( (temp_output_12_0_g61071).xx + (temp_output_12_0_g61071).yz ) * (temp_output_12_0_g61071).zy ) ) );
					float2 DDX631_g61069 = ddx( temp_output_5_0_g61069 );
					float2 DDY632_g61069 = ddy( temp_output_5_0_g61069 );
					float temp_output_65_0_g61070 = ( 0.0 - temp_output_56_0_g61070 );
					float ifLocalVar59_g61070 = 0;
					if( temp_output_56_0_g61070 <= 0.0 )
					ifLocalVar59_g61070 = temp_output_65_0_g61070;
					else
					ifLocalVar59_g61070 = temp_output_56_0_g61070;
					float temp_output_597_30_g61069 = ifLocalVar59_g61070;
					float2 temp_output_90_0_g61070 = ( temp_output_52_0_g61070 + float2( 0,1 ) );
					float2 temp_output_123_0_g61070 = ( temp_output_52_0_g61070 + float2( 1,0 ) );
					float2 ifLocalVar88_g61070 = 0;
					if( temp_output_56_0_g61070 > 0.0 )
					ifLocalVar88_g61070 = temp_output_90_0_g61070;
					else if( temp_output_56_0_g61070 == 0.0 )
					ifLocalVar88_g61070 = temp_output_123_0_g61070;
					else if( temp_output_56_0_g61070 < 0.0 )
					ifLocalVar88_g61070 = temp_output_123_0_g61070;
					float3 temp_output_7_0_g61072 = frac( ( (ifLocalVar88_g61070).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61072 = dot( temp_output_7_0_g61072 , ( (temp_output_7_0_g61072).yzx + 33.33 ) );
					float3 temp_output_12_0_g61072 = ( temp_output_7_0_g61072 + dotResult8_g61072 );
					float2 temp_output_597_26_g61069 = ( UV100_g61070 + frac( ( ( (temp_output_12_0_g61072).xx + (temp_output_12_0_g61072).yz ) * (temp_output_12_0_g61072).zy ) ) );
					float temp_output_66_0_g61070 = ( 1.0 - break55_g61070.y );
					float ifLocalVar60_g61070 = 0;
					if( temp_output_56_0_g61070 <= 0.0 )
					ifLocalVar60_g61070 = temp_output_66_0_g61070;
					else
					ifLocalVar60_g61070 = break55_g61070.y;
					float temp_output_597_28_g61069 = ifLocalVar60_g61070;
					float2 ifLocalVar89_g61070 = 0;
					if( temp_output_56_0_g61070 > 0.0 )
					ifLocalVar89_g61070 = temp_output_123_0_g61070;
					else if( temp_output_56_0_g61070 == 0.0 )
					ifLocalVar89_g61070 = temp_output_90_0_g61070;
					else if( temp_output_56_0_g61070 < 0.0 )
					ifLocalVar89_g61070 = temp_output_90_0_g61070;
					float3 temp_output_7_0_g61073 = frac( ( (ifLocalVar89_g61070).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61073 = dot( temp_output_7_0_g61073 , ( (temp_output_7_0_g61073).yzx + 33.33 ) );
					float3 temp_output_12_0_g61073 = ( temp_output_7_0_g61073 + dotResult8_g61073 );
					float2 temp_output_597_27_g61069 = ( UV100_g61070 + frac( ( ( (temp_output_12_0_g61073).xx + (temp_output_12_0_g61073).yz ) * (temp_output_12_0_g61073).zy ) ) );
					float temp_output_67_0_g61070 = ( 1.0 - break55_g61070.x );
					float ifLocalVar61_g61070 = 0;
					if( temp_output_56_0_g61070 <= 0.0 )
					ifLocalVar61_g61070 = temp_output_67_0_g61070;
					else
					ifLocalVar61_g61070 = break55_g61070.x;
					float temp_output_597_29_g61069 = ifLocalVar61_g61070;
					float4 Output_2D293_g61069 = ( ( tex2D( _MetallicMap, temp_output_597_0_g61069, DDX631_g61069, DDY632_g61069 ) * temp_output_597_30_g61069 ) + ( tex2D( _MetallicMap, temp_output_597_26_g61069, DDX631_g61069, DDY632_g61069 ) * temp_output_597_28_g61069 ) + ( tex2D( _MetallicMap, temp_output_597_27_g61069, DDX631_g61069, DDY632_g61069 ) * temp_output_597_29_g61069 ) );
					float4 break31_g61069 = Output_2D293_g61069;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g61063 = break31_g61069.a;
					#else
					float staticSwitch1005_g61063 = tex2D( _MetallicMap, uv_MetallicMap48_g61063 ).a;
					#endif
					float saferPower803_g61063 = abs( staticSwitch1005_g61063 );
					#ifdef _METALLICMAP
					float staticSwitch846_g61063 = pow( saferPower803_g61063 , 3.0 );
					#else
					float staticSwitch846_g61063 = _Metallic;
					#endif
					float Metallic699_g61063 = staticSwitch846_g61063;
					
					float White38_g61063 = 1.0;
					float4 temp_cast_1 = (White38_g61063).xxxx;
					float2 texCoord1093_g61063 = IN.ase_texcoord5.zw * float2( 1,1 ) + float2( 0,0 );
					float localBicubicPrepare2_g61098 = ( 0.0 );
					float2 uv3_Lightmap0 = IN.ase_texcoord5.zw * _Lightmap0_ST.xy + _Lightmap0_ST.zw;
					float2 Input_UV100_g61098 = uv3_Lightmap0;
					float2 UV2_g61098 = Input_UV100_g61098;
					float4 TexelSize2_g61098 = _Lightmap0_TexelSize;
					float2 UV02_g61098 = float2( 0,0 );
					float2 UV12_g61098 = float2( 0,0 );
					float2 UV22_g61098 = float2( 0,0 );
					float2 UV32_g61098 = float2( 0,0 );
					float W02_g61098 = 0;
					float W12_g61098 = 0;
					{
					{
					 UV2_g61098 = UV2_g61098 * TexelSize2_g61098.zw - 0.5;
					    float2 f = frac( UV2_g61098 );
					    UV2_g61098 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g61098.x - 0.5, UV2_g61098.x + 1.5, UV2_g61098.y - 0.5, UV2_g61098.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g61098.xyxy;
					    UV02_g61098 = off.xz;
					    UV12_g61098 = off.yz;
					    UV22_g61098 = off.xw;
					    UV32_g61098 = off.yw;
					    W02_g61098 = s.x / ( s.x + s.y );
					 W12_g61098 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g61098 = lerp( tex2D( _Lightmap0, UV32_g61098 ) , tex2D( _Lightmap0, UV22_g61098 ) , W02_g61098);
					float4 lerpResult45_g61098 = lerp( tex2D( _Lightmap0, UV12_g61098 ) , tex2D( _Lightmap0, UV02_g61098 ) , W02_g61098);
					float4 lerpResult44_g61098 = lerp( lerpResult46_g61098 , lerpResult45_g61098 , W12_g61098);
					float4 Output_2D131_g61098 = lerpResult44_g61098;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g61063 = Output_2D131_g61098;
					#else
					float4 staticSwitch1092_g61063 = tex2D( _Lightmap0, texCoord1093_g61063 );
					#endif
					float4 Lightmap_0925_g61063 = staticSwitch1092_g61063;
					float2 texCoord1090_g61063 = IN.ase_texcoord5.zw * float2( 1,1 ) + float2( 0,0 );
					float localBicubicPrepare2_g61096 = ( 0.0 );
					float2 uv3_Lightmap1 = IN.ase_texcoord5.zw * _Lightmap1_ST.xy + _Lightmap1_ST.zw;
					float2 Input_UV100_g61096 = uv3_Lightmap1;
					float2 UV2_g61096 = Input_UV100_g61096;
					float4 TexelSize2_g61096 = _Lightmap1_TexelSize;
					float2 UV02_g61096 = float2( 0,0 );
					float2 UV12_g61096 = float2( 0,0 );
					float2 UV22_g61096 = float2( 0,0 );
					float2 UV32_g61096 = float2( 0,0 );
					float W02_g61096 = 0;
					float W12_g61096 = 0;
					{
					{
					 UV2_g61096 = UV2_g61096 * TexelSize2_g61096.zw - 0.5;
					    float2 f = frac( UV2_g61096 );
					    UV2_g61096 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g61096.x - 0.5, UV2_g61096.x + 1.5, UV2_g61096.y - 0.5, UV2_g61096.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g61096.xyxy;
					    UV02_g61096 = off.xz;
					    UV12_g61096 = off.yz;
					    UV22_g61096 = off.xw;
					    UV32_g61096 = off.yw;
					    W02_g61096 = s.x / ( s.x + s.y );
					 W12_g61096 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g61096 = lerp( tex2D( _Lightmap1, UV32_g61096 ) , tex2D( _Lightmap1, UV22_g61096 ) , W02_g61096);
					float4 lerpResult45_g61096 = lerp( tex2D( _Lightmap1, UV12_g61096 ) , tex2D( _Lightmap1, UV02_g61096 ) , W02_g61096);
					float4 lerpResult44_g61096 = lerp( lerpResult46_g61096 , lerpResult45_g61096 , W12_g61096);
					float4 Output_2D131_g61096 = lerpResult44_g61096;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g61063 = Output_2D131_g61096;
					#else
					float4 staticSwitch1088_g61063 = tex2D( _Lightmap1, texCoord1090_g61063 );
					#endif
					float4 Lightmap_1956_g61063 = staticSwitch1088_g61063;
					float4 lerpResult442_g61063 = lerp( Lightmap_0925_g61063 , Lightmap_1956_g61063 , _LightmapLerp);
					float4 Lightmap_Lerp932_g61063 = lerpResult442_g61063;
					float3 appendResult139_g61099 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g61099 = normalize( Normal_Map700_g61063 );
					float3 Normal_Map318_g61099 = normalizeResult326_g61099;
					float dotResult121_g61099 = dot( appendResult139_g61099 , Normal_Map318_g61099 );
					float2 texCoord1070_g61063 = IN.ase_texcoord5.zw * float2( 1,1 ) + float2( 0,0 );
					float localStochasticTiling2_g61104 = ( 0.0 );
					float2 uv3_RNMX0 = IN.ase_texcoord5.zw * _RNMX0_ST.xy + _RNMX0_ST.zw;
					float2 UV2_g61104 = uv3_RNMX0;
					float4 TexelSize2_g61104 = _RNMX0_TexelSize;
					float4 Offsets2_g61104 = float4( 0,0,0,0 );
					float2 Weights2_g61104 = float2( 0,0 );
					{
					UV2_g61104 = UV2_g61104 * TexelSize2_g61104.zw - 0.5;
					float2 f = frac( UV2_g61104 );
					UV2_g61104 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g61104.x - 0.5, UV2_g61104.x + 1.5, UV2_g61104.y - 0.5, UV2_g61104.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g61104 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g61104.xyxy;
					Weights2_g61104 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g61103 = Offsets2_g61104;
					float4 Input_FetchOffsets197_g61107 = temp_output_1_34_g61103;
					float2 temp_output_1_54_g61103 = Weights2_g61104;
					float2 Input_FetchWeights200_g61107 = temp_output_1_54_g61103;
					float2 break187_g61107 = Input_FetchWeights200_g61107;
					float4 lerpResult181_g61107 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g61107).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g61107).xw ) , break187_g61107.x);
					float4 lerpResult182_g61107 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g61107).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g61107).xz ) , break187_g61107.x);
					float4 lerpResult176_g61107 = lerp( lerpResult181_g61107 , lerpResult182_g61107 , break187_g61107.y);
					float4 Output_Fetch2D202_g61107 = lerpResult176_g61107;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g61063 = Output_Fetch2D202_g61107;
					#else
					float4 staticSwitch1061_g61063 = tex2D( _RNMX0, texCoord1070_g61063 );
					#endif
					float3 appendResult146_g61099 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g61099 = dot( appendResult146_g61099 , Normal_Map318_g61099 );
					float4 Input_FetchOffsets197_g61105 = temp_output_1_34_g61103;
					float2 Input_FetchWeights200_g61105 = temp_output_1_54_g61103;
					float2 break187_g61105 = Input_FetchWeights200_g61105;
					float4 lerpResult181_g61105 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g61105).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g61105).xw ) , break187_g61105.x);
					float4 lerpResult182_g61105 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g61105).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g61105).xz ) , break187_g61105.x);
					float4 lerpResult176_g61105 = lerp( lerpResult181_g61105 , lerpResult182_g61105 , break187_g61105.y);
					float4 Output_Fetch2D202_g61105 = lerpResult176_g61105;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g61063 = Output_Fetch2D202_g61105;
					#else
					float4 staticSwitch1062_g61063 = tex2D( _RNMY0, texCoord1070_g61063 );
					#endif
					float3 appendResult149_g61099 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g61099 = dot( appendResult149_g61099 , Normal_Map318_g61099 );
					float4 Input_FetchOffsets197_g61106 = temp_output_1_34_g61103;
					float2 Input_FetchWeights200_g61106 = temp_output_1_54_g61103;
					float2 break187_g61106 = Input_FetchWeights200_g61106;
					float4 lerpResult181_g61106 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g61106).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g61106).xw ) , break187_g61106.x);
					float4 lerpResult182_g61106 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g61106).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g61106).xz ) , break187_g61106.x);
					float4 lerpResult176_g61106 = lerp( lerpResult181_g61106 , lerpResult182_g61106 , break187_g61106.y);
					float4 Output_Fetch2D202_g61106 = lerpResult176_g61106;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g61063 = Output_Fetch2D202_g61106;
					#else
					float4 staticSwitch1063_g61063 = tex2D( _RNMZ0, texCoord1070_g61063 );
					#endif
					float4 RNM_0926_g61063 = ( ( ( dotResult121_g61099 * ( staticSwitch1061_g61063 * 0.5 ) ) + ( dotResult122_g61099 * ( staticSwitch1062_g61063 * 0.5 ) ) ) + ( dotResult120_g61099 * ( staticSwitch1063_g61063 * 0.5 ) ) );
					float3 appendResult139_g61100 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g61100 = normalize( Normal_Map700_g61063 );
					float3 Normal_Map318_g61100 = normalizeResult326_g61100;
					float dotResult121_g61100 = dot( appendResult139_g61100 , Normal_Map318_g61100 );
					float2 texCoord1086_g61063 = IN.ase_texcoord5.zw * float2( 1,1 ) + float2( 0,0 );
					float localStochasticTiling2_g61091 = ( 0.0 );
					float2 uv3_RNMX1 = IN.ase_texcoord5.zw * _RNMX1_ST.xy + _RNMX1_ST.zw;
					float2 UV2_g61091 = uv3_RNMX1;
					float4 TexelSize2_g61091 = _RNMX1_TexelSize;
					float4 Offsets2_g61091 = float4( 0,0,0,0 );
					float2 Weights2_g61091 = float2( 0,0 );
					{
					UV2_g61091 = UV2_g61091 * TexelSize2_g61091.zw - 0.5;
					float2 f = frac( UV2_g61091 );
					UV2_g61091 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g61091.x - 0.5, UV2_g61091.x + 1.5, UV2_g61091.y - 0.5, UV2_g61091.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g61091 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g61091.xyxy;
					Weights2_g61091 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g61090 = Offsets2_g61091;
					float4 Input_FetchOffsets197_g61094 = temp_output_1_34_g61090;
					float2 temp_output_1_54_g61090 = Weights2_g61091;
					float2 Input_FetchWeights200_g61094 = temp_output_1_54_g61090;
					float2 break187_g61094 = Input_FetchWeights200_g61094;
					float4 lerpResult181_g61094 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g61094).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g61094).xw ) , break187_g61094.x);
					float4 lerpResult182_g61094 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g61094).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g61094).xz ) , break187_g61094.x);
					float4 lerpResult176_g61094 = lerp( lerpResult181_g61094 , lerpResult182_g61094 , break187_g61094.y);
					float4 Output_Fetch2D202_g61094 = lerpResult176_g61094;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g61063 = Output_Fetch2D202_g61094;
					#else
					float4 staticSwitch1087_g61063 = tex2D( _RNMX1, texCoord1086_g61063 );
					#endif
					float3 appendResult146_g61100 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g61100 = dot( appendResult146_g61100 , Normal_Map318_g61100 );
					float4 Input_FetchOffsets197_g61092 = temp_output_1_34_g61090;
					float2 Input_FetchWeights200_g61092 = temp_output_1_54_g61090;
					float2 break187_g61092 = Input_FetchWeights200_g61092;
					float4 lerpResult181_g61092 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g61092).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g61092).xw ) , break187_g61092.x);
					float4 lerpResult182_g61092 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g61092).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g61092).xz ) , break187_g61092.x);
					float4 lerpResult176_g61092 = lerp( lerpResult181_g61092 , lerpResult182_g61092 , break187_g61092.y);
					float4 Output_Fetch2D202_g61092 = lerpResult176_g61092;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g61063 = Output_Fetch2D202_g61092;
					#else
					float4 staticSwitch1083_g61063 = tex2D( _RNMY1, texCoord1086_g61063 );
					#endif
					float3 appendResult149_g61100 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g61100 = dot( appendResult149_g61100 , Normal_Map318_g61100 );
					float4 Input_FetchOffsets197_g61093 = temp_output_1_34_g61090;
					float2 Input_FetchWeights200_g61093 = temp_output_1_54_g61090;
					float2 break187_g61093 = Input_FetchWeights200_g61093;
					float4 lerpResult181_g61093 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g61093).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g61093).xw ) , break187_g61093.x);
					float4 lerpResult182_g61093 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g61093).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g61093).xz ) , break187_g61093.x);
					float4 lerpResult176_g61093 = lerp( lerpResult181_g61093 , lerpResult182_g61093 , break187_g61093.y);
					float4 Output_Fetch2D202_g61093 = lerpResult176_g61093;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g61063 = Output_Fetch2D202_g61093;
					#else
					float4 staticSwitch1084_g61063 = tex2D( _RNMZ1, texCoord1086_g61063 );
					#endif
					float4 RNM_11081_g61063 = ( ( ( dotResult121_g61100 * ( staticSwitch1087_g61063 * 0.5 ) ) + ( dotResult122_g61100 * ( staticSwitch1083_g61063 * 0.5 ) ) ) + ( dotResult120_g61100 * ( staticSwitch1084_g61063 * 0.5 ) ) );
					float Lightmap_Lerp_Value969_g61063 = _LightmapLerp;
					float4 lerpResult953_g61063 = lerp( RNM_0926_g61063 , RNM_11081_g61063 , Lightmap_Lerp_Value969_g61063);
					float4 RNM_Lerp950_g61063 = lerpResult953_g61063;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g61063 = temp_cast_1;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g61063 = Lightmap_0925_g61063;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g61063 = Lightmap_Lerp932_g61063;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g61063 = RNM_0926_g61063;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g61063 = RNM_Lerp950_g61063;
					#else
					float4 staticSwitch1014_g61063 = temp_cast_1;
					#endif
					float4 Lightmap46_g61063 = staticSwitch1014_g61063;
					float3 linearToGamma1047_g61063 = LinearToGammaSpace( Lightmap46_g61063.rgb );
					float grayscale1048_g61063 = dot( linearToGamma1047_g61063, float3( 0.299, 0.587, 0.114 ) );
					float saferPower606_g61063 = abs( grayscale1048_g61063 );
					#ifdef _LIGHTMAPOCCLUSIONENABLED_ON
					float staticSwitch1018_g61063 = pow( saferPower606_g61063 , _OcclusionPower );
					#else
					float staticSwitch1018_g61063 = White38_g61063;
					#endif
					#if defined( _LIGHTMAPMODE_DISABLED )
					float staticSwitch1016_g61063 = White38_g61063;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float staticSwitch1016_g61063 = staticSwitch1018_g61063;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float staticSwitch1016_g61063 = staticSwitch1018_g61063;
					#elif defined( _LIGHTMAPMODE_RNM )
					float staticSwitch1016_g61063 = staticSwitch1018_g61063;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float staticSwitch1016_g61063 = staticSwitch1018_g61063;
					#else
					float staticSwitch1016_g61063 = White38_g61063;
					#endif
					float fresnelNdotV1050_g61063 = dot( NormalWS, ViewDirWS );
					float f01050_g61063 = 0.5;
					float fresnelNode1050_g61063 = ( f01050_g61063 + ( 1.0 - f01050_g61063 ) * pow( max( 1.0 - fresnelNdotV1050_g61063 , 0.0001 ), 5 ) );
					float clampResult1031_g61063 = clamp( ( staticSwitch1016_g61063 + fresnelNode1050_g61063 ) , 0.0 , 1.0 );
					float Lightmap_Occlusion1025_g61063 = clampResult1031_g61063;
					float2 uv_GlossinessMap64_g61063 = IN.ase_texcoord5.xy;
					float2 uv_GlossinessMap = IN.ase_texcoord5.xy * _GlossinessMap_ST.xy + _GlossinessMap_ST.zw;
					float2 temp_output_5_0_g61074 = uv_GlossinessMap;
					float2 UV633_g61074 = temp_output_5_0_g61074;
					float2 UV100_g61075 = UV633_g61074;
					float2 temp_output_51_0_g61075 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g61075 * float2( 3.464,3.464 ) ) );
					float2 break55_g61075 = frac( temp_output_51_0_g61075 );
					float temp_output_56_0_g61075 = ( ( 1.0 - break55_g61075.x ) - break55_g61075.y );
					float2 temp_output_52_0_g61075 = floor( temp_output_51_0_g61075 );
					float2 temp_output_125_0_g61075 = ( temp_output_52_0_g61075 + float2( 1,1 ) );
					float2 ifLocalVar87_g61075 = 0;
					if( temp_output_56_0_g61075 > 0.0 )
					ifLocalVar87_g61075 = temp_output_52_0_g61075;
					else if( temp_output_56_0_g61075 == 0.0 )
					ifLocalVar87_g61075 = temp_output_125_0_g61075;
					else if( temp_output_56_0_g61075 < 0.0 )
					ifLocalVar87_g61075 = temp_output_125_0_g61075;
					float3 temp_output_7_0_g61076 = frac( ( (ifLocalVar87_g61075).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61076 = dot( temp_output_7_0_g61076 , ( (temp_output_7_0_g61076).yzx + 33.33 ) );
					float3 temp_output_12_0_g61076 = ( temp_output_7_0_g61076 + dotResult8_g61076 );
					float2 temp_output_597_0_g61074 = ( UV100_g61075 + frac( ( ( (temp_output_12_0_g61076).xx + (temp_output_12_0_g61076).yz ) * (temp_output_12_0_g61076).zy ) ) );
					float2 DDX631_g61074 = ddx( temp_output_5_0_g61074 );
					float2 DDY632_g61074 = ddy( temp_output_5_0_g61074 );
					float temp_output_65_0_g61075 = ( 0.0 - temp_output_56_0_g61075 );
					float ifLocalVar59_g61075 = 0;
					if( temp_output_56_0_g61075 <= 0.0 )
					ifLocalVar59_g61075 = temp_output_65_0_g61075;
					else
					ifLocalVar59_g61075 = temp_output_56_0_g61075;
					float temp_output_597_30_g61074 = ifLocalVar59_g61075;
					float2 temp_output_90_0_g61075 = ( temp_output_52_0_g61075 + float2( 0,1 ) );
					float2 temp_output_123_0_g61075 = ( temp_output_52_0_g61075 + float2( 1,0 ) );
					float2 ifLocalVar88_g61075 = 0;
					if( temp_output_56_0_g61075 > 0.0 )
					ifLocalVar88_g61075 = temp_output_90_0_g61075;
					else if( temp_output_56_0_g61075 == 0.0 )
					ifLocalVar88_g61075 = temp_output_123_0_g61075;
					else if( temp_output_56_0_g61075 < 0.0 )
					ifLocalVar88_g61075 = temp_output_123_0_g61075;
					float3 temp_output_7_0_g61077 = frac( ( (ifLocalVar88_g61075).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61077 = dot( temp_output_7_0_g61077 , ( (temp_output_7_0_g61077).yzx + 33.33 ) );
					float3 temp_output_12_0_g61077 = ( temp_output_7_0_g61077 + dotResult8_g61077 );
					float2 temp_output_597_26_g61074 = ( UV100_g61075 + frac( ( ( (temp_output_12_0_g61077).xx + (temp_output_12_0_g61077).yz ) * (temp_output_12_0_g61077).zy ) ) );
					float temp_output_66_0_g61075 = ( 1.0 - break55_g61075.y );
					float ifLocalVar60_g61075 = 0;
					if( temp_output_56_0_g61075 <= 0.0 )
					ifLocalVar60_g61075 = temp_output_66_0_g61075;
					else
					ifLocalVar60_g61075 = break55_g61075.y;
					float temp_output_597_28_g61074 = ifLocalVar60_g61075;
					float2 ifLocalVar89_g61075 = 0;
					if( temp_output_56_0_g61075 > 0.0 )
					ifLocalVar89_g61075 = temp_output_123_0_g61075;
					else if( temp_output_56_0_g61075 == 0.0 )
					ifLocalVar89_g61075 = temp_output_90_0_g61075;
					else if( temp_output_56_0_g61075 < 0.0 )
					ifLocalVar89_g61075 = temp_output_90_0_g61075;
					float3 temp_output_7_0_g61078 = frac( ( (ifLocalVar89_g61075).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61078 = dot( temp_output_7_0_g61078 , ( (temp_output_7_0_g61078).yzx + 33.33 ) );
					float3 temp_output_12_0_g61078 = ( temp_output_7_0_g61078 + dotResult8_g61078 );
					float2 temp_output_597_27_g61074 = ( UV100_g61075 + frac( ( ( (temp_output_12_0_g61078).xx + (temp_output_12_0_g61078).yz ) * (temp_output_12_0_g61078).zy ) ) );
					float temp_output_67_0_g61075 = ( 1.0 - break55_g61075.x );
					float ifLocalVar61_g61075 = 0;
					if( temp_output_56_0_g61075 <= 0.0 )
					ifLocalVar61_g61075 = temp_output_67_0_g61075;
					else
					ifLocalVar61_g61075 = break55_g61075.x;
					float temp_output_597_29_g61074 = ifLocalVar61_g61075;
					float4 Output_2D293_g61074 = ( ( tex2D( _GlossinessMap, temp_output_597_0_g61074, DDX631_g61074, DDY632_g61074 ) * temp_output_597_30_g61074 ) + ( tex2D( _GlossinessMap, temp_output_597_26_g61074, DDX631_g61074, DDY632_g61074 ) * temp_output_597_28_g61074 ) + ( tex2D( _GlossinessMap, temp_output_597_27_g61074, DDX631_g61074, DDY632_g61074 ) * temp_output_597_29_g61074 ) );
					float4 break31_g61074 = Output_2D293_g61074;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g61063 = break31_g61074.a;
					#else
					float staticSwitch1004_g61063 = tex2D( _GlossinessMap, uv_GlossinessMap64_g61063 ).a;
					#endif
					float saferPower804_g61063 = abs( staticSwitch1004_g61063 );
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g61063 = ( 1.0 - pow( saferPower804_g61063 , 3.0 ) );
					#else
					float staticSwitch845_g61063 = _Glossiness;
					#endif
					float temp_output_1030_0_g61063 = ( Lightmap_Occlusion1025_g61063 * staticSwitch845_g61063 );
					float3 temp_output_3_0_g61084 = ddx( NormalWS );
					float dotResult5_g61084 = dot( temp_output_3_0_g61084 , temp_output_3_0_g61084 );
					float3 temp_output_4_0_g61084 = ddy( NormalWS );
					float dotResult6_g61084 = dot( temp_output_4_0_g61084 , temp_output_4_0_g61084 );
					#ifdef _USEGEOMETRICANTIALIASING_ON
					float staticSwitch824_g61063 = min( temp_output_1030_0_g61063 , ( 1.0 - pow( saturate( max( dotResult5_g61084 , dotResult6_g61084 ) ) , 0.333 ) ) );
					#else
					float staticSwitch824_g61063 = temp_output_1030_0_g61063;
					#endif
					
					float4 temp_output_614_0_g61063 = ( Albedo6_g61063 * ( ( 1.0 - Metallic699_g61063 ) * Lightmap46_g61063 ) );
					float4 temp_cast_4 = 0;
					float2 uv_EmissionMap81_g61063 = IN.ase_texcoord5.xy;
					float2 uv_EmissionMap = IN.ase_texcoord5.xy * _EmissionMap_ST.xy + _EmissionMap_ST.zw;
					float2 temp_output_5_0_g61064 = uv_EmissionMap;
					float2 UV633_g61064 = temp_output_5_0_g61064;
					float2 UV100_g61065 = UV633_g61064;
					float2 temp_output_51_0_g61065 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g61065 * float2( 3.464,3.464 ) ) );
					float2 break55_g61065 = frac( temp_output_51_0_g61065 );
					float temp_output_56_0_g61065 = ( ( 1.0 - break55_g61065.x ) - break55_g61065.y );
					float2 temp_output_52_0_g61065 = floor( temp_output_51_0_g61065 );
					float2 temp_output_125_0_g61065 = ( temp_output_52_0_g61065 + float2( 1,1 ) );
					float2 ifLocalVar87_g61065 = 0;
					if( temp_output_56_0_g61065 > 0.0 )
					ifLocalVar87_g61065 = temp_output_52_0_g61065;
					else if( temp_output_56_0_g61065 == 0.0 )
					ifLocalVar87_g61065 = temp_output_125_0_g61065;
					else if( temp_output_56_0_g61065 < 0.0 )
					ifLocalVar87_g61065 = temp_output_125_0_g61065;
					float3 temp_output_7_0_g61066 = frac( ( (ifLocalVar87_g61065).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61066 = dot( temp_output_7_0_g61066 , ( (temp_output_7_0_g61066).yzx + 33.33 ) );
					float3 temp_output_12_0_g61066 = ( temp_output_7_0_g61066 + dotResult8_g61066 );
					float2 temp_output_597_0_g61064 = ( UV100_g61065 + frac( ( ( (temp_output_12_0_g61066).xx + (temp_output_12_0_g61066).yz ) * (temp_output_12_0_g61066).zy ) ) );
					float2 DDX631_g61064 = ddx( temp_output_5_0_g61064 );
					float2 DDY632_g61064 = ddy( temp_output_5_0_g61064 );
					float temp_output_65_0_g61065 = ( 0.0 - temp_output_56_0_g61065 );
					float ifLocalVar59_g61065 = 0;
					if( temp_output_56_0_g61065 <= 0.0 )
					ifLocalVar59_g61065 = temp_output_65_0_g61065;
					else
					ifLocalVar59_g61065 = temp_output_56_0_g61065;
					float temp_output_597_30_g61064 = ifLocalVar59_g61065;
					float2 temp_output_90_0_g61065 = ( temp_output_52_0_g61065 + float2( 0,1 ) );
					float2 temp_output_123_0_g61065 = ( temp_output_52_0_g61065 + float2( 1,0 ) );
					float2 ifLocalVar88_g61065 = 0;
					if( temp_output_56_0_g61065 > 0.0 )
					ifLocalVar88_g61065 = temp_output_90_0_g61065;
					else if( temp_output_56_0_g61065 == 0.0 )
					ifLocalVar88_g61065 = temp_output_123_0_g61065;
					else if( temp_output_56_0_g61065 < 0.0 )
					ifLocalVar88_g61065 = temp_output_123_0_g61065;
					float3 temp_output_7_0_g61067 = frac( ( (ifLocalVar88_g61065).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61067 = dot( temp_output_7_0_g61067 , ( (temp_output_7_0_g61067).yzx + 33.33 ) );
					float3 temp_output_12_0_g61067 = ( temp_output_7_0_g61067 + dotResult8_g61067 );
					float2 temp_output_597_26_g61064 = ( UV100_g61065 + frac( ( ( (temp_output_12_0_g61067).xx + (temp_output_12_0_g61067).yz ) * (temp_output_12_0_g61067).zy ) ) );
					float temp_output_66_0_g61065 = ( 1.0 - break55_g61065.y );
					float ifLocalVar60_g61065 = 0;
					if( temp_output_56_0_g61065 <= 0.0 )
					ifLocalVar60_g61065 = temp_output_66_0_g61065;
					else
					ifLocalVar60_g61065 = break55_g61065.y;
					float temp_output_597_28_g61064 = ifLocalVar60_g61065;
					float2 ifLocalVar89_g61065 = 0;
					if( temp_output_56_0_g61065 > 0.0 )
					ifLocalVar89_g61065 = temp_output_123_0_g61065;
					else if( temp_output_56_0_g61065 == 0.0 )
					ifLocalVar89_g61065 = temp_output_90_0_g61065;
					else if( temp_output_56_0_g61065 < 0.0 )
					ifLocalVar89_g61065 = temp_output_90_0_g61065;
					float3 temp_output_7_0_g61068 = frac( ( (ifLocalVar89_g61065).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61068 = dot( temp_output_7_0_g61068 , ( (temp_output_7_0_g61068).yzx + 33.33 ) );
					float3 temp_output_12_0_g61068 = ( temp_output_7_0_g61068 + dotResult8_g61068 );
					float2 temp_output_597_27_g61064 = ( UV100_g61065 + frac( ( ( (temp_output_12_0_g61068).xx + (temp_output_12_0_g61068).yz ) * (temp_output_12_0_g61068).zy ) ) );
					float temp_output_67_0_g61065 = ( 1.0 - break55_g61065.x );
					float ifLocalVar61_g61065 = 0;
					if( temp_output_56_0_g61065 <= 0.0 )
					ifLocalVar61_g61065 = temp_output_67_0_g61065;
					else
					ifLocalVar61_g61065 = break55_g61065.x;
					float temp_output_597_29_g61064 = ifLocalVar61_g61065;
					float4 Output_2D293_g61064 = ( ( tex2D( _EmissionMap, temp_output_597_0_g61064, DDX631_g61064, DDY632_g61064 ) * temp_output_597_30_g61064 ) + ( tex2D( _EmissionMap, temp_output_597_26_g61064, DDX631_g61064, DDY632_g61064 ) * temp_output_597_28_g61064 ) + ( tex2D( _EmissionMap, temp_output_597_27_g61064, DDX631_g61064, DDY632_g61064 ) * temp_output_597_29_g61064 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g61063 = Output_2D293_g61064;
					#else
					float4 staticSwitch1006_g61063 = tex2D( _EmissionMap, uv_EmissionMap81_g61063 );
					#endif
					#ifdef _EMISSIONENABLED_ON
					float4 staticSwitch1017_g61063 = ( _EmissionColor + staticSwitch1006_g61063 );
					#else
					float4 staticSwitch1017_g61063 = temp_cast_4;
					#endif
					float4 Emission86_g61063 = staticSwitch1017_g61063;
					float4 temp_output_690_0_g61063 = ( Emission86_g61063 + temp_output_614_0_g61063 );
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1019_g61063 = ( temp_output_614_0_g61063 * Emission86_g61063 );
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1019_g61063 = temp_output_690_0_g61063;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1019_g61063 = temp_output_690_0_g61063;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1019_g61063 = temp_output_690_0_g61063;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1019_g61063 = temp_output_690_0_g61063;
					#else
					float4 staticSwitch1019_g61063 = ( temp_output_614_0_g61063 * Emission86_g61063 );
					#endif
					float3 temp_output_35_0_g61101 = staticSwitch1019_g61063.rgb;
					float3 Color353_g61101 = temp_output_35_0_g61101;
					#if defined( _LUTMODE_2D )
					float3 staticSwitch273_g61101 = saturate( temp_output_35_0_g61101 );
					#elif defined( _LUTMODE_3D )
					float3 staticSwitch273_g61101 = temp_output_35_0_g61101;
					#else
					float3 staticSwitch273_g61101 = temp_output_35_0_g61101;
					#endif
					float3 Color_Saturate49_g61101 = staticSwitch273_g61101;
					float Lut_Height213_g61101 = _LUTSize;
					float Lut_Width216_g61101 = ( _LUTSize * Lut_Height213_g61101 );
					float3 appendResult214_g61101 = (float3(( 1.0 / Lut_Width216_g61101 ) , ( 1.0 / Lut_Height213_g61101 ) , ( Lut_Height213_g61101 - 1.0 )));
					float3 Scale_Offset208_g61101 = appendResult214_g61101;
					float2 Scale_Factor292_g61101 = ( (Scale_Offset208_g61101).xy * (Scale_Offset208_g61101).z );
					float2 Offset299_g61101 = ( (Scale_Offset208_g61101).xy * 0.5 );
					float2 Adjusted_UV305_g61101 = ( ( (Color_Saturate49_g61101).xy * Scale_Factor292_g61101 ) + Offset299_g61101 );
					float Scaled_Blue280_g61101 = ( (Color_Saturate49_g61101).z * (Scale_Offset208_g61101).z );
					float Shift288_g61101 = floor( Scaled_Blue280_g61101 );
					float Final_X313_g61101 = ( (Adjusted_UV305_g61101).x + ( Shift288_g61101 * (Scale_Offset208_g61101).y ) );
					float2 appendResult326_g61101 = (float2(Final_X313_g61101 , (Adjusted_UV305_g61101).y));
					float2 Final_UV325_g61101 = appendResult326_g61101;
					float2 appendResult338_g61101 = (float2((Scale_Offset208_g61101).y , 0.0));
					float2 Offset_UV336_g61101 = ( Final_UV325_g61101 + appendResult338_g61101 );
					float3 lerpResult333_g61101 = lerp( tex2D( _2DLut, Final_UV325_g61101 ).rgb , tex2D( _2DLut, Offset_UV336_g61101 ).rgb , ( Scaled_Blue280_g61101 - Shift288_g61101 ));
					#ifdef _2DLUT
					float3 staticSwitch347_g61101 = lerpResult333_g61101;
					#else
					float3 staticSwitch347_g61101 = Color_Saturate49_g61101;
					#endif
					float3 TwoD_LUT346_g61101 = staticSwitch347_g61101;
					float3 RGB16_g61102 = ( ( log10( ( ( Color_Saturate49_g61101 * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 );
					#ifdef _3DLUT
					float3 staticSwitch194_g61101 = tex3D( _3DLut, RGB16_g61102 ).rgb;
					#else
					float3 staticSwitch194_g61101 = Color_Saturate49_g61101;
					#endif
					float3 ThreeD_LUT51_g61101 = staticSwitch194_g61101;
					#if defined( _LUTMODE_2D )
					float3 staticSwitch42_g61101 = TwoD_LUT346_g61101;
					#elif defined( _LUTMODE_3D )
					float3 staticSwitch42_g61101 = ThreeD_LUT51_g61101;
					#else
					float3 staticSwitch42_g61101 = ThreeD_LUT51_g61101;
					#endif
					#ifdef SHADER_API_MOBILE
					float3 staticSwitch41_g61101 = staticSwitch42_g61101;
					#else
					float3 staticSwitch41_g61101 = Color353_g61101;
					#endif
					

					o.Albedo = Albedo6_g61063.rgb;
					o.Normal = Normal_Map700_g61063;

					half3 Specular = half3( 0, 0, 0 );
					half Metallic = Metallic699_g61063;
					half Smoothness = staticSwitch824_g61063;
					half Occlusion = staticSwitch1016_g61063;

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

					o.Emission = staticSwitch41_g61101;
					o.Alpha = 1;
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
				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
				#define ASE_NEEDS_TEXTURE_COORDINATES2
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
				#pragma shader_feature_local _STOCHASTICENABLED_ON
				#pragma shader_feature_local _LIGHTMAPMODE_DISABLED _LIGHTMAPMODE_SIMPLE _LIGHTMAPMODE_SIMPLELERP _LIGHTMAPMODE_RNM _LIGHTMAPMODE_RNMLERP
				#pragma shader_feature_local_fragment _METALLICMAP
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
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				uniform float4 _MetallicMap_ST;
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
					float3 vertexValue = defaultVertexValue;
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

					float2 uv_MainTex907_g61063 = IN.ase_texcoord2.xy;
					float2 uv_MainTex = IN.ase_texcoord2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					float2 temp_output_5_0_g61085 = uv_MainTex;
					float2 UV633_g61085 = temp_output_5_0_g61085;
					float2 UV100_g61086 = UV633_g61085;
					float2 temp_output_51_0_g61086 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g61086 * float2( 3.464,3.464 ) ) );
					float2 break55_g61086 = frac( temp_output_51_0_g61086 );
					float temp_output_56_0_g61086 = ( ( 1.0 - break55_g61086.x ) - break55_g61086.y );
					float2 temp_output_52_0_g61086 = floor( temp_output_51_0_g61086 );
					float2 temp_output_125_0_g61086 = ( temp_output_52_0_g61086 + float2( 1,1 ) );
					float2 ifLocalVar87_g61086 = 0;
					if( temp_output_56_0_g61086 > 0.0 )
					ifLocalVar87_g61086 = temp_output_52_0_g61086;
					else if( temp_output_56_0_g61086 == 0.0 )
					ifLocalVar87_g61086 = temp_output_125_0_g61086;
					else if( temp_output_56_0_g61086 < 0.0 )
					ifLocalVar87_g61086 = temp_output_125_0_g61086;
					float3 temp_output_7_0_g61087 = frac( ( (ifLocalVar87_g61086).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61087 = dot( temp_output_7_0_g61087 , ( (temp_output_7_0_g61087).yzx + 33.33 ) );
					float3 temp_output_12_0_g61087 = ( temp_output_7_0_g61087 + dotResult8_g61087 );
					float2 temp_output_597_0_g61085 = ( UV100_g61086 + frac( ( ( (temp_output_12_0_g61087).xx + (temp_output_12_0_g61087).yz ) * (temp_output_12_0_g61087).zy ) ) );
					float2 DDX631_g61085 = ddx( temp_output_5_0_g61085 );
					float2 DDY632_g61085 = ddy( temp_output_5_0_g61085 );
					float temp_output_65_0_g61086 = ( 0.0 - temp_output_56_0_g61086 );
					float ifLocalVar59_g61086 = 0;
					if( temp_output_56_0_g61086 <= 0.0 )
					ifLocalVar59_g61086 = temp_output_65_0_g61086;
					else
					ifLocalVar59_g61086 = temp_output_56_0_g61086;
					float temp_output_597_30_g61085 = ifLocalVar59_g61086;
					float2 temp_output_90_0_g61086 = ( temp_output_52_0_g61086 + float2( 0,1 ) );
					float2 temp_output_123_0_g61086 = ( temp_output_52_0_g61086 + float2( 1,0 ) );
					float2 ifLocalVar88_g61086 = 0;
					if( temp_output_56_0_g61086 > 0.0 )
					ifLocalVar88_g61086 = temp_output_90_0_g61086;
					else if( temp_output_56_0_g61086 == 0.0 )
					ifLocalVar88_g61086 = temp_output_123_0_g61086;
					else if( temp_output_56_0_g61086 < 0.0 )
					ifLocalVar88_g61086 = temp_output_123_0_g61086;
					float3 temp_output_7_0_g61088 = frac( ( (ifLocalVar88_g61086).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61088 = dot( temp_output_7_0_g61088 , ( (temp_output_7_0_g61088).yzx + 33.33 ) );
					float3 temp_output_12_0_g61088 = ( temp_output_7_0_g61088 + dotResult8_g61088 );
					float2 temp_output_597_26_g61085 = ( UV100_g61086 + frac( ( ( (temp_output_12_0_g61088).xx + (temp_output_12_0_g61088).yz ) * (temp_output_12_0_g61088).zy ) ) );
					float temp_output_66_0_g61086 = ( 1.0 - break55_g61086.y );
					float ifLocalVar60_g61086 = 0;
					if( temp_output_56_0_g61086 <= 0.0 )
					ifLocalVar60_g61086 = temp_output_66_0_g61086;
					else
					ifLocalVar60_g61086 = break55_g61086.y;
					float temp_output_597_28_g61085 = ifLocalVar60_g61086;
					float2 ifLocalVar89_g61086 = 0;
					if( temp_output_56_0_g61086 > 0.0 )
					ifLocalVar89_g61086 = temp_output_123_0_g61086;
					else if( temp_output_56_0_g61086 == 0.0 )
					ifLocalVar89_g61086 = temp_output_90_0_g61086;
					else if( temp_output_56_0_g61086 < 0.0 )
					ifLocalVar89_g61086 = temp_output_90_0_g61086;
					float3 temp_output_7_0_g61089 = frac( ( (ifLocalVar89_g61086).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61089 = dot( temp_output_7_0_g61089 , ( (temp_output_7_0_g61089).yzx + 33.33 ) );
					float3 temp_output_12_0_g61089 = ( temp_output_7_0_g61089 + dotResult8_g61089 );
					float2 temp_output_597_27_g61085 = ( UV100_g61086 + frac( ( ( (temp_output_12_0_g61089).xx + (temp_output_12_0_g61089).yz ) * (temp_output_12_0_g61089).zy ) ) );
					float temp_output_67_0_g61086 = ( 1.0 - break55_g61086.x );
					float ifLocalVar61_g61086 = 0;
					if( temp_output_56_0_g61086 <= 0.0 )
					ifLocalVar61_g61086 = temp_output_67_0_g61086;
					else
					ifLocalVar61_g61086 = break55_g61086.x;
					float temp_output_597_29_g61085 = ifLocalVar61_g61086;
					float4 Output_2D293_g61085 = ( ( tex2D( _MainTex, temp_output_597_0_g61085, DDX631_g61085, DDY632_g61085 ) * temp_output_597_30_g61085 ) + ( tex2D( _MainTex, temp_output_597_26_g61085, DDX631_g61085, DDY632_g61085 ) * temp_output_597_28_g61085 ) + ( tex2D( _MainTex, temp_output_597_27_g61085, DDX631_g61085, DDY632_g61085 ) * temp_output_597_29_g61085 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g61063 = Output_2D293_g61085;
					#else
					float4 staticSwitch1001_g61063 = tex2D( _MainTex, uv_MainTex907_g61063 );
					#endif
					float4 temp_output_976_0_g61063 = ( _Color * staticSwitch1001_g61063 );
					float4 Albedo6_g61063 = temp_output_976_0_g61063;
					
					float2 uv_MetallicMap48_g61063 = IN.ase_texcoord2.xy;
					float2 uv_MetallicMap = IN.ase_texcoord2.xy * _MetallicMap_ST.xy + _MetallicMap_ST.zw;
					float2 temp_output_5_0_g61069 = uv_MetallicMap;
					float2 UV633_g61069 = temp_output_5_0_g61069;
					float2 UV100_g61070 = UV633_g61069;
					float2 temp_output_51_0_g61070 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g61070 * float2( 3.464,3.464 ) ) );
					float2 break55_g61070 = frac( temp_output_51_0_g61070 );
					float temp_output_56_0_g61070 = ( ( 1.0 - break55_g61070.x ) - break55_g61070.y );
					float2 temp_output_52_0_g61070 = floor( temp_output_51_0_g61070 );
					float2 temp_output_125_0_g61070 = ( temp_output_52_0_g61070 + float2( 1,1 ) );
					float2 ifLocalVar87_g61070 = 0;
					if( temp_output_56_0_g61070 > 0.0 )
					ifLocalVar87_g61070 = temp_output_52_0_g61070;
					else if( temp_output_56_0_g61070 == 0.0 )
					ifLocalVar87_g61070 = temp_output_125_0_g61070;
					else if( temp_output_56_0_g61070 < 0.0 )
					ifLocalVar87_g61070 = temp_output_125_0_g61070;
					float3 temp_output_7_0_g61071 = frac( ( (ifLocalVar87_g61070).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61071 = dot( temp_output_7_0_g61071 , ( (temp_output_7_0_g61071).yzx + 33.33 ) );
					float3 temp_output_12_0_g61071 = ( temp_output_7_0_g61071 + dotResult8_g61071 );
					float2 temp_output_597_0_g61069 = ( UV100_g61070 + frac( ( ( (temp_output_12_0_g61071).xx + (temp_output_12_0_g61071).yz ) * (temp_output_12_0_g61071).zy ) ) );
					float2 DDX631_g61069 = ddx( temp_output_5_0_g61069 );
					float2 DDY632_g61069 = ddy( temp_output_5_0_g61069 );
					float temp_output_65_0_g61070 = ( 0.0 - temp_output_56_0_g61070 );
					float ifLocalVar59_g61070 = 0;
					if( temp_output_56_0_g61070 <= 0.0 )
					ifLocalVar59_g61070 = temp_output_65_0_g61070;
					else
					ifLocalVar59_g61070 = temp_output_56_0_g61070;
					float temp_output_597_30_g61069 = ifLocalVar59_g61070;
					float2 temp_output_90_0_g61070 = ( temp_output_52_0_g61070 + float2( 0,1 ) );
					float2 temp_output_123_0_g61070 = ( temp_output_52_0_g61070 + float2( 1,0 ) );
					float2 ifLocalVar88_g61070 = 0;
					if( temp_output_56_0_g61070 > 0.0 )
					ifLocalVar88_g61070 = temp_output_90_0_g61070;
					else if( temp_output_56_0_g61070 == 0.0 )
					ifLocalVar88_g61070 = temp_output_123_0_g61070;
					else if( temp_output_56_0_g61070 < 0.0 )
					ifLocalVar88_g61070 = temp_output_123_0_g61070;
					float3 temp_output_7_0_g61072 = frac( ( (ifLocalVar88_g61070).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61072 = dot( temp_output_7_0_g61072 , ( (temp_output_7_0_g61072).yzx + 33.33 ) );
					float3 temp_output_12_0_g61072 = ( temp_output_7_0_g61072 + dotResult8_g61072 );
					float2 temp_output_597_26_g61069 = ( UV100_g61070 + frac( ( ( (temp_output_12_0_g61072).xx + (temp_output_12_0_g61072).yz ) * (temp_output_12_0_g61072).zy ) ) );
					float temp_output_66_0_g61070 = ( 1.0 - break55_g61070.y );
					float ifLocalVar60_g61070 = 0;
					if( temp_output_56_0_g61070 <= 0.0 )
					ifLocalVar60_g61070 = temp_output_66_0_g61070;
					else
					ifLocalVar60_g61070 = break55_g61070.y;
					float temp_output_597_28_g61069 = ifLocalVar60_g61070;
					float2 ifLocalVar89_g61070 = 0;
					if( temp_output_56_0_g61070 > 0.0 )
					ifLocalVar89_g61070 = temp_output_123_0_g61070;
					else if( temp_output_56_0_g61070 == 0.0 )
					ifLocalVar89_g61070 = temp_output_90_0_g61070;
					else if( temp_output_56_0_g61070 < 0.0 )
					ifLocalVar89_g61070 = temp_output_90_0_g61070;
					float3 temp_output_7_0_g61073 = frac( ( (ifLocalVar89_g61070).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61073 = dot( temp_output_7_0_g61073 , ( (temp_output_7_0_g61073).yzx + 33.33 ) );
					float3 temp_output_12_0_g61073 = ( temp_output_7_0_g61073 + dotResult8_g61073 );
					float2 temp_output_597_27_g61069 = ( UV100_g61070 + frac( ( ( (temp_output_12_0_g61073).xx + (temp_output_12_0_g61073).yz ) * (temp_output_12_0_g61073).zy ) ) );
					float temp_output_67_0_g61070 = ( 1.0 - break55_g61070.x );
					float ifLocalVar61_g61070 = 0;
					if( temp_output_56_0_g61070 <= 0.0 )
					ifLocalVar61_g61070 = temp_output_67_0_g61070;
					else
					ifLocalVar61_g61070 = break55_g61070.x;
					float temp_output_597_29_g61069 = ifLocalVar61_g61070;
					float4 Output_2D293_g61069 = ( ( tex2D( _MetallicMap, temp_output_597_0_g61069, DDX631_g61069, DDY632_g61069 ) * temp_output_597_30_g61069 ) + ( tex2D( _MetallicMap, temp_output_597_26_g61069, DDX631_g61069, DDY632_g61069 ) * temp_output_597_28_g61069 ) + ( tex2D( _MetallicMap, temp_output_597_27_g61069, DDX631_g61069, DDY632_g61069 ) * temp_output_597_29_g61069 ) );
					float4 break31_g61069 = Output_2D293_g61069;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g61063 = break31_g61069.a;
					#else
					float staticSwitch1005_g61063 = tex2D( _MetallicMap, uv_MetallicMap48_g61063 ).a;
					#endif
					float saferPower803_g61063 = abs( staticSwitch1005_g61063 );
					#ifdef _METALLICMAP
					float staticSwitch846_g61063 = pow( saferPower803_g61063 , 3.0 );
					#else
					float staticSwitch846_g61063 = _Metallic;
					#endif
					float Metallic699_g61063 = staticSwitch846_g61063;
					float White38_g61063 = 1.0;
					float4 temp_cast_1 = (White38_g61063).xxxx;
					float2 texCoord1093_g61063 = IN.ase_texcoord2.zw * float2( 1,1 ) + float2( 0,0 );
					float localBicubicPrepare2_g61098 = ( 0.0 );
					float2 uv3_Lightmap0 = IN.ase_texcoord2.zw * _Lightmap0_ST.xy + _Lightmap0_ST.zw;
					float2 Input_UV100_g61098 = uv3_Lightmap0;
					float2 UV2_g61098 = Input_UV100_g61098;
					float4 TexelSize2_g61098 = _Lightmap0_TexelSize;
					float2 UV02_g61098 = float2( 0,0 );
					float2 UV12_g61098 = float2( 0,0 );
					float2 UV22_g61098 = float2( 0,0 );
					float2 UV32_g61098 = float2( 0,0 );
					float W02_g61098 = 0;
					float W12_g61098 = 0;
					{
					{
					 UV2_g61098 = UV2_g61098 * TexelSize2_g61098.zw - 0.5;
					    float2 f = frac( UV2_g61098 );
					    UV2_g61098 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g61098.x - 0.5, UV2_g61098.x + 1.5, UV2_g61098.y - 0.5, UV2_g61098.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g61098.xyxy;
					    UV02_g61098 = off.xz;
					    UV12_g61098 = off.yz;
					    UV22_g61098 = off.xw;
					    UV32_g61098 = off.yw;
					    W02_g61098 = s.x / ( s.x + s.y );
					 W12_g61098 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g61098 = lerp( tex2D( _Lightmap0, UV32_g61098 ) , tex2D( _Lightmap0, UV22_g61098 ) , W02_g61098);
					float4 lerpResult45_g61098 = lerp( tex2D( _Lightmap0, UV12_g61098 ) , tex2D( _Lightmap0, UV02_g61098 ) , W02_g61098);
					float4 lerpResult44_g61098 = lerp( lerpResult46_g61098 , lerpResult45_g61098 , W12_g61098);
					float4 Output_2D131_g61098 = lerpResult44_g61098;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g61063 = Output_2D131_g61098;
					#else
					float4 staticSwitch1092_g61063 = tex2D( _Lightmap0, texCoord1093_g61063 );
					#endif
					float4 Lightmap_0925_g61063 = staticSwitch1092_g61063;
					float2 texCoord1090_g61063 = IN.ase_texcoord2.zw * float2( 1,1 ) + float2( 0,0 );
					float localBicubicPrepare2_g61096 = ( 0.0 );
					float2 uv3_Lightmap1 = IN.ase_texcoord2.zw * _Lightmap1_ST.xy + _Lightmap1_ST.zw;
					float2 Input_UV100_g61096 = uv3_Lightmap1;
					float2 UV2_g61096 = Input_UV100_g61096;
					float4 TexelSize2_g61096 = _Lightmap1_TexelSize;
					float2 UV02_g61096 = float2( 0,0 );
					float2 UV12_g61096 = float2( 0,0 );
					float2 UV22_g61096 = float2( 0,0 );
					float2 UV32_g61096 = float2( 0,0 );
					float W02_g61096 = 0;
					float W12_g61096 = 0;
					{
					{
					 UV2_g61096 = UV2_g61096 * TexelSize2_g61096.zw - 0.5;
					    float2 f = frac( UV2_g61096 );
					    UV2_g61096 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g61096.x - 0.5, UV2_g61096.x + 1.5, UV2_g61096.y - 0.5, UV2_g61096.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g61096.xyxy;
					    UV02_g61096 = off.xz;
					    UV12_g61096 = off.yz;
					    UV22_g61096 = off.xw;
					    UV32_g61096 = off.yw;
					    W02_g61096 = s.x / ( s.x + s.y );
					 W12_g61096 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g61096 = lerp( tex2D( _Lightmap1, UV32_g61096 ) , tex2D( _Lightmap1, UV22_g61096 ) , W02_g61096);
					float4 lerpResult45_g61096 = lerp( tex2D( _Lightmap1, UV12_g61096 ) , tex2D( _Lightmap1, UV02_g61096 ) , W02_g61096);
					float4 lerpResult44_g61096 = lerp( lerpResult46_g61096 , lerpResult45_g61096 , W12_g61096);
					float4 Output_2D131_g61096 = lerpResult44_g61096;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g61063 = Output_2D131_g61096;
					#else
					float4 staticSwitch1088_g61063 = tex2D( _Lightmap1, texCoord1090_g61063 );
					#endif
					float4 Lightmap_1956_g61063 = staticSwitch1088_g61063;
					float4 lerpResult442_g61063 = lerp( Lightmap_0925_g61063 , Lightmap_1956_g61063 , _LightmapLerp);
					float4 Lightmap_Lerp932_g61063 = lerpResult442_g61063;
					float3 appendResult139_g61099 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float2 uv_BumpMap830_g61063 = IN.ase_texcoord2.xy;
					float2 uv_BumpMap = IN.ase_texcoord2.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					float2 temp_output_5_0_g61079 = uv_BumpMap;
					float2 UV633_g61079 = temp_output_5_0_g61079;
					float2 UV100_g61080 = UV633_g61079;
					float2 temp_output_51_0_g61080 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g61080 * float2( 3.464,3.464 ) ) );
					float2 break55_g61080 = frac( temp_output_51_0_g61080 );
					float temp_output_56_0_g61080 = ( ( 1.0 - break55_g61080.x ) - break55_g61080.y );
					float2 temp_output_52_0_g61080 = floor( temp_output_51_0_g61080 );
					float2 temp_output_125_0_g61080 = ( temp_output_52_0_g61080 + float2( 1,1 ) );
					float2 ifLocalVar87_g61080 = 0;
					if( temp_output_56_0_g61080 > 0.0 )
					ifLocalVar87_g61080 = temp_output_52_0_g61080;
					else if( temp_output_56_0_g61080 == 0.0 )
					ifLocalVar87_g61080 = temp_output_125_0_g61080;
					else if( temp_output_56_0_g61080 < 0.0 )
					ifLocalVar87_g61080 = temp_output_125_0_g61080;
					float3 temp_output_7_0_g61081 = frac( ( (ifLocalVar87_g61080).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61081 = dot( temp_output_7_0_g61081 , ( (temp_output_7_0_g61081).yzx + 33.33 ) );
					float3 temp_output_12_0_g61081 = ( temp_output_7_0_g61081 + dotResult8_g61081 );
					float2 temp_output_597_0_g61079 = ( UV100_g61080 + frac( ( ( (temp_output_12_0_g61081).xx + (temp_output_12_0_g61081).yz ) * (temp_output_12_0_g61081).zy ) ) );
					float2 DDX631_g61079 = ddx( temp_output_5_0_g61079 );
					float2 DDY632_g61079 = ddy( temp_output_5_0_g61079 );
					float Input_Scale617_g61079 = _NormalScale;
					float temp_output_65_0_g61080 = ( 0.0 - temp_output_56_0_g61080 );
					float ifLocalVar59_g61080 = 0;
					if( temp_output_56_0_g61080 <= 0.0 )
					ifLocalVar59_g61080 = temp_output_65_0_g61080;
					else
					ifLocalVar59_g61080 = temp_output_56_0_g61080;
					float temp_output_597_30_g61079 = ifLocalVar59_g61080;
					float2 temp_output_90_0_g61080 = ( temp_output_52_0_g61080 + float2( 0,1 ) );
					float2 temp_output_123_0_g61080 = ( temp_output_52_0_g61080 + float2( 1,0 ) );
					float2 ifLocalVar88_g61080 = 0;
					if( temp_output_56_0_g61080 > 0.0 )
					ifLocalVar88_g61080 = temp_output_90_0_g61080;
					else if( temp_output_56_0_g61080 == 0.0 )
					ifLocalVar88_g61080 = temp_output_123_0_g61080;
					else if( temp_output_56_0_g61080 < 0.0 )
					ifLocalVar88_g61080 = temp_output_123_0_g61080;
					float3 temp_output_7_0_g61082 = frac( ( (ifLocalVar88_g61080).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61082 = dot( temp_output_7_0_g61082 , ( (temp_output_7_0_g61082).yzx + 33.33 ) );
					float3 temp_output_12_0_g61082 = ( temp_output_7_0_g61082 + dotResult8_g61082 );
					float2 temp_output_597_26_g61079 = ( UV100_g61080 + frac( ( ( (temp_output_12_0_g61082).xx + (temp_output_12_0_g61082).yz ) * (temp_output_12_0_g61082).zy ) ) );
					float temp_output_66_0_g61080 = ( 1.0 - break55_g61080.y );
					float ifLocalVar60_g61080 = 0;
					if( temp_output_56_0_g61080 <= 0.0 )
					ifLocalVar60_g61080 = temp_output_66_0_g61080;
					else
					ifLocalVar60_g61080 = break55_g61080.y;
					float temp_output_597_28_g61079 = ifLocalVar60_g61080;
					float2 ifLocalVar89_g61080 = 0;
					if( temp_output_56_0_g61080 > 0.0 )
					ifLocalVar89_g61080 = temp_output_123_0_g61080;
					else if( temp_output_56_0_g61080 == 0.0 )
					ifLocalVar89_g61080 = temp_output_90_0_g61080;
					else if( temp_output_56_0_g61080 < 0.0 )
					ifLocalVar89_g61080 = temp_output_90_0_g61080;
					float3 temp_output_7_0_g61083 = frac( ( (ifLocalVar89_g61080).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61083 = dot( temp_output_7_0_g61083 , ( (temp_output_7_0_g61083).yzx + 33.33 ) );
					float3 temp_output_12_0_g61083 = ( temp_output_7_0_g61083 + dotResult8_g61083 );
					float2 temp_output_597_27_g61079 = ( UV100_g61080 + frac( ( ( (temp_output_12_0_g61083).xx + (temp_output_12_0_g61083).yz ) * (temp_output_12_0_g61083).zy ) ) );
					float temp_output_67_0_g61080 = ( 1.0 - break55_g61080.x );
					float ifLocalVar61_g61080 = 0;
					if( temp_output_56_0_g61080 <= 0.0 )
					ifLocalVar61_g61080 = temp_output_67_0_g61080;
					else
					ifLocalVar61_g61080 = break55_g61080.x;
					float temp_output_597_29_g61079 = ifLocalVar61_g61080;
					float3 Output_2D_Normal641_g61079 = ( ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_0_g61079, DDX631_g61079, DDY632_g61079 ), Input_Scale617_g61079 ) * temp_output_597_30_g61079 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_26_g61079, DDX631_g61079, DDY632_g61079 ), Input_Scale617_g61079 ) * temp_output_597_28_g61079 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_27_g61079, DDX631_g61079, DDY632_g61079 ), Input_Scale617_g61079 ) * float3( 0,0,0 ) * temp_output_597_29_g61079 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g61063 = Output_2D_Normal641_g61079;
					#else
					float3 staticSwitch1003_g61063 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap830_g61063 ), _NormalScale );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g61063 = staticSwitch1003_g61063;
					#else
					float3 staticSwitch980_g61063 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g61063 = staticSwitch980_g61063;
					float3 normalizeResult326_g61099 = normalize( Normal_Map700_g61063 );
					float3 Normal_Map318_g61099 = normalizeResult326_g61099;
					float dotResult121_g61099 = dot( appendResult139_g61099 , Normal_Map318_g61099 );
					float2 texCoord1070_g61063 = IN.ase_texcoord2.zw * float2( 1,1 ) + float2( 0,0 );
					float localStochasticTiling2_g61104 = ( 0.0 );
					float2 uv3_RNMX0 = IN.ase_texcoord2.zw * _RNMX0_ST.xy + _RNMX0_ST.zw;
					float2 UV2_g61104 = uv3_RNMX0;
					float4 TexelSize2_g61104 = _RNMX0_TexelSize;
					float4 Offsets2_g61104 = float4( 0,0,0,0 );
					float2 Weights2_g61104 = float2( 0,0 );
					{
					UV2_g61104 = UV2_g61104 * TexelSize2_g61104.zw - 0.5;
					float2 f = frac( UV2_g61104 );
					UV2_g61104 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g61104.x - 0.5, UV2_g61104.x + 1.5, UV2_g61104.y - 0.5, UV2_g61104.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g61104 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g61104.xyxy;
					Weights2_g61104 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g61103 = Offsets2_g61104;
					float4 Input_FetchOffsets197_g61107 = temp_output_1_34_g61103;
					float2 temp_output_1_54_g61103 = Weights2_g61104;
					float2 Input_FetchWeights200_g61107 = temp_output_1_54_g61103;
					float2 break187_g61107 = Input_FetchWeights200_g61107;
					float4 lerpResult181_g61107 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g61107).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g61107).xw ) , break187_g61107.x);
					float4 lerpResult182_g61107 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g61107).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g61107).xz ) , break187_g61107.x);
					float4 lerpResult176_g61107 = lerp( lerpResult181_g61107 , lerpResult182_g61107 , break187_g61107.y);
					float4 Output_Fetch2D202_g61107 = lerpResult176_g61107;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g61063 = Output_Fetch2D202_g61107;
					#else
					float4 staticSwitch1061_g61063 = tex2D( _RNMX0, texCoord1070_g61063 );
					#endif
					float3 appendResult146_g61099 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g61099 = dot( appendResult146_g61099 , Normal_Map318_g61099 );
					float4 Input_FetchOffsets197_g61105 = temp_output_1_34_g61103;
					float2 Input_FetchWeights200_g61105 = temp_output_1_54_g61103;
					float2 break187_g61105 = Input_FetchWeights200_g61105;
					float4 lerpResult181_g61105 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g61105).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g61105).xw ) , break187_g61105.x);
					float4 lerpResult182_g61105 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g61105).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g61105).xz ) , break187_g61105.x);
					float4 lerpResult176_g61105 = lerp( lerpResult181_g61105 , lerpResult182_g61105 , break187_g61105.y);
					float4 Output_Fetch2D202_g61105 = lerpResult176_g61105;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g61063 = Output_Fetch2D202_g61105;
					#else
					float4 staticSwitch1062_g61063 = tex2D( _RNMY0, texCoord1070_g61063 );
					#endif
					float3 appendResult149_g61099 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g61099 = dot( appendResult149_g61099 , Normal_Map318_g61099 );
					float4 Input_FetchOffsets197_g61106 = temp_output_1_34_g61103;
					float2 Input_FetchWeights200_g61106 = temp_output_1_54_g61103;
					float2 break187_g61106 = Input_FetchWeights200_g61106;
					float4 lerpResult181_g61106 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g61106).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g61106).xw ) , break187_g61106.x);
					float4 lerpResult182_g61106 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g61106).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g61106).xz ) , break187_g61106.x);
					float4 lerpResult176_g61106 = lerp( lerpResult181_g61106 , lerpResult182_g61106 , break187_g61106.y);
					float4 Output_Fetch2D202_g61106 = lerpResult176_g61106;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g61063 = Output_Fetch2D202_g61106;
					#else
					float4 staticSwitch1063_g61063 = tex2D( _RNMZ0, texCoord1070_g61063 );
					#endif
					float4 RNM_0926_g61063 = ( ( ( dotResult121_g61099 * ( staticSwitch1061_g61063 * 0.5 ) ) + ( dotResult122_g61099 * ( staticSwitch1062_g61063 * 0.5 ) ) ) + ( dotResult120_g61099 * ( staticSwitch1063_g61063 * 0.5 ) ) );
					float3 appendResult139_g61100 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g61100 = normalize( Normal_Map700_g61063 );
					float3 Normal_Map318_g61100 = normalizeResult326_g61100;
					float dotResult121_g61100 = dot( appendResult139_g61100 , Normal_Map318_g61100 );
					float2 texCoord1086_g61063 = IN.ase_texcoord2.zw * float2( 1,1 ) + float2( 0,0 );
					float localStochasticTiling2_g61091 = ( 0.0 );
					float2 uv3_RNMX1 = IN.ase_texcoord2.zw * _RNMX1_ST.xy + _RNMX1_ST.zw;
					float2 UV2_g61091 = uv3_RNMX1;
					float4 TexelSize2_g61091 = _RNMX1_TexelSize;
					float4 Offsets2_g61091 = float4( 0,0,0,0 );
					float2 Weights2_g61091 = float2( 0,0 );
					{
					UV2_g61091 = UV2_g61091 * TexelSize2_g61091.zw - 0.5;
					float2 f = frac( UV2_g61091 );
					UV2_g61091 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g61091.x - 0.5, UV2_g61091.x + 1.5, UV2_g61091.y - 0.5, UV2_g61091.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g61091 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g61091.xyxy;
					Weights2_g61091 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g61090 = Offsets2_g61091;
					float4 Input_FetchOffsets197_g61094 = temp_output_1_34_g61090;
					float2 temp_output_1_54_g61090 = Weights2_g61091;
					float2 Input_FetchWeights200_g61094 = temp_output_1_54_g61090;
					float2 break187_g61094 = Input_FetchWeights200_g61094;
					float4 lerpResult181_g61094 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g61094).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g61094).xw ) , break187_g61094.x);
					float4 lerpResult182_g61094 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g61094).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g61094).xz ) , break187_g61094.x);
					float4 lerpResult176_g61094 = lerp( lerpResult181_g61094 , lerpResult182_g61094 , break187_g61094.y);
					float4 Output_Fetch2D202_g61094 = lerpResult176_g61094;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g61063 = Output_Fetch2D202_g61094;
					#else
					float4 staticSwitch1087_g61063 = tex2D( _RNMX1, texCoord1086_g61063 );
					#endif
					float3 appendResult146_g61100 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g61100 = dot( appendResult146_g61100 , Normal_Map318_g61100 );
					float4 Input_FetchOffsets197_g61092 = temp_output_1_34_g61090;
					float2 Input_FetchWeights200_g61092 = temp_output_1_54_g61090;
					float2 break187_g61092 = Input_FetchWeights200_g61092;
					float4 lerpResult181_g61092 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g61092).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g61092).xw ) , break187_g61092.x);
					float4 lerpResult182_g61092 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g61092).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g61092).xz ) , break187_g61092.x);
					float4 lerpResult176_g61092 = lerp( lerpResult181_g61092 , lerpResult182_g61092 , break187_g61092.y);
					float4 Output_Fetch2D202_g61092 = lerpResult176_g61092;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g61063 = Output_Fetch2D202_g61092;
					#else
					float4 staticSwitch1083_g61063 = tex2D( _RNMY1, texCoord1086_g61063 );
					#endif
					float3 appendResult149_g61100 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g61100 = dot( appendResult149_g61100 , Normal_Map318_g61100 );
					float4 Input_FetchOffsets197_g61093 = temp_output_1_34_g61090;
					float2 Input_FetchWeights200_g61093 = temp_output_1_54_g61090;
					float2 break187_g61093 = Input_FetchWeights200_g61093;
					float4 lerpResult181_g61093 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g61093).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g61093).xw ) , break187_g61093.x);
					float4 lerpResult182_g61093 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g61093).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g61093).xz ) , break187_g61093.x);
					float4 lerpResult176_g61093 = lerp( lerpResult181_g61093 , lerpResult182_g61093 , break187_g61093.y);
					float4 Output_Fetch2D202_g61093 = lerpResult176_g61093;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g61063 = Output_Fetch2D202_g61093;
					#else
					float4 staticSwitch1084_g61063 = tex2D( _RNMZ1, texCoord1086_g61063 );
					#endif
					float4 RNM_11081_g61063 = ( ( ( dotResult121_g61100 * ( staticSwitch1087_g61063 * 0.5 ) ) + ( dotResult122_g61100 * ( staticSwitch1083_g61063 * 0.5 ) ) ) + ( dotResult120_g61100 * ( staticSwitch1084_g61063 * 0.5 ) ) );
					float Lightmap_Lerp_Value969_g61063 = _LightmapLerp;
					float4 lerpResult953_g61063 = lerp( RNM_0926_g61063 , RNM_11081_g61063 , Lightmap_Lerp_Value969_g61063);
					float4 RNM_Lerp950_g61063 = lerpResult953_g61063;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g61063 = temp_cast_1;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g61063 = Lightmap_0925_g61063;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g61063 = Lightmap_Lerp932_g61063;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g61063 = RNM_0926_g61063;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g61063 = RNM_Lerp950_g61063;
					#else
					float4 staticSwitch1014_g61063 = temp_cast_1;
					#endif
					float4 Lightmap46_g61063 = staticSwitch1014_g61063;
					float4 temp_output_614_0_g61063 = ( Albedo6_g61063 * ( ( 1.0 - Metallic699_g61063 ) * Lightmap46_g61063 ) );
					float4 temp_cast_2 = 0;
					float2 uv_EmissionMap81_g61063 = IN.ase_texcoord2.xy;
					float2 uv_EmissionMap = IN.ase_texcoord2.xy * _EmissionMap_ST.xy + _EmissionMap_ST.zw;
					float2 temp_output_5_0_g61064 = uv_EmissionMap;
					float2 UV633_g61064 = temp_output_5_0_g61064;
					float2 UV100_g61065 = UV633_g61064;
					float2 temp_output_51_0_g61065 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g61065 * float2( 3.464,3.464 ) ) );
					float2 break55_g61065 = frac( temp_output_51_0_g61065 );
					float temp_output_56_0_g61065 = ( ( 1.0 - break55_g61065.x ) - break55_g61065.y );
					float2 temp_output_52_0_g61065 = floor( temp_output_51_0_g61065 );
					float2 temp_output_125_0_g61065 = ( temp_output_52_0_g61065 + float2( 1,1 ) );
					float2 ifLocalVar87_g61065 = 0;
					if( temp_output_56_0_g61065 > 0.0 )
					ifLocalVar87_g61065 = temp_output_52_0_g61065;
					else if( temp_output_56_0_g61065 == 0.0 )
					ifLocalVar87_g61065 = temp_output_125_0_g61065;
					else if( temp_output_56_0_g61065 < 0.0 )
					ifLocalVar87_g61065 = temp_output_125_0_g61065;
					float3 temp_output_7_0_g61066 = frac( ( (ifLocalVar87_g61065).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61066 = dot( temp_output_7_0_g61066 , ( (temp_output_7_0_g61066).yzx + 33.33 ) );
					float3 temp_output_12_0_g61066 = ( temp_output_7_0_g61066 + dotResult8_g61066 );
					float2 temp_output_597_0_g61064 = ( UV100_g61065 + frac( ( ( (temp_output_12_0_g61066).xx + (temp_output_12_0_g61066).yz ) * (temp_output_12_0_g61066).zy ) ) );
					float2 DDX631_g61064 = ddx( temp_output_5_0_g61064 );
					float2 DDY632_g61064 = ddy( temp_output_5_0_g61064 );
					float temp_output_65_0_g61065 = ( 0.0 - temp_output_56_0_g61065 );
					float ifLocalVar59_g61065 = 0;
					if( temp_output_56_0_g61065 <= 0.0 )
					ifLocalVar59_g61065 = temp_output_65_0_g61065;
					else
					ifLocalVar59_g61065 = temp_output_56_0_g61065;
					float temp_output_597_30_g61064 = ifLocalVar59_g61065;
					float2 temp_output_90_0_g61065 = ( temp_output_52_0_g61065 + float2( 0,1 ) );
					float2 temp_output_123_0_g61065 = ( temp_output_52_0_g61065 + float2( 1,0 ) );
					float2 ifLocalVar88_g61065 = 0;
					if( temp_output_56_0_g61065 > 0.0 )
					ifLocalVar88_g61065 = temp_output_90_0_g61065;
					else if( temp_output_56_0_g61065 == 0.0 )
					ifLocalVar88_g61065 = temp_output_123_0_g61065;
					else if( temp_output_56_0_g61065 < 0.0 )
					ifLocalVar88_g61065 = temp_output_123_0_g61065;
					float3 temp_output_7_0_g61067 = frac( ( (ifLocalVar88_g61065).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61067 = dot( temp_output_7_0_g61067 , ( (temp_output_7_0_g61067).yzx + 33.33 ) );
					float3 temp_output_12_0_g61067 = ( temp_output_7_0_g61067 + dotResult8_g61067 );
					float2 temp_output_597_26_g61064 = ( UV100_g61065 + frac( ( ( (temp_output_12_0_g61067).xx + (temp_output_12_0_g61067).yz ) * (temp_output_12_0_g61067).zy ) ) );
					float temp_output_66_0_g61065 = ( 1.0 - break55_g61065.y );
					float ifLocalVar60_g61065 = 0;
					if( temp_output_56_0_g61065 <= 0.0 )
					ifLocalVar60_g61065 = temp_output_66_0_g61065;
					else
					ifLocalVar60_g61065 = break55_g61065.y;
					float temp_output_597_28_g61064 = ifLocalVar60_g61065;
					float2 ifLocalVar89_g61065 = 0;
					if( temp_output_56_0_g61065 > 0.0 )
					ifLocalVar89_g61065 = temp_output_123_0_g61065;
					else if( temp_output_56_0_g61065 == 0.0 )
					ifLocalVar89_g61065 = temp_output_90_0_g61065;
					else if( temp_output_56_0_g61065 < 0.0 )
					ifLocalVar89_g61065 = temp_output_90_0_g61065;
					float3 temp_output_7_0_g61068 = frac( ( (ifLocalVar89_g61065).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g61068 = dot( temp_output_7_0_g61068 , ( (temp_output_7_0_g61068).yzx + 33.33 ) );
					float3 temp_output_12_0_g61068 = ( temp_output_7_0_g61068 + dotResult8_g61068 );
					float2 temp_output_597_27_g61064 = ( UV100_g61065 + frac( ( ( (temp_output_12_0_g61068).xx + (temp_output_12_0_g61068).yz ) * (temp_output_12_0_g61068).zy ) ) );
					float temp_output_67_0_g61065 = ( 1.0 - break55_g61065.x );
					float ifLocalVar61_g61065 = 0;
					if( temp_output_56_0_g61065 <= 0.0 )
					ifLocalVar61_g61065 = temp_output_67_0_g61065;
					else
					ifLocalVar61_g61065 = break55_g61065.x;
					float temp_output_597_29_g61064 = ifLocalVar61_g61065;
					float4 Output_2D293_g61064 = ( ( tex2D( _EmissionMap, temp_output_597_0_g61064, DDX631_g61064, DDY632_g61064 ) * temp_output_597_30_g61064 ) + ( tex2D( _EmissionMap, temp_output_597_26_g61064, DDX631_g61064, DDY632_g61064 ) * temp_output_597_28_g61064 ) + ( tex2D( _EmissionMap, temp_output_597_27_g61064, DDX631_g61064, DDY632_g61064 ) * temp_output_597_29_g61064 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g61063 = Output_2D293_g61064;
					#else
					float4 staticSwitch1006_g61063 = tex2D( _EmissionMap, uv_EmissionMap81_g61063 );
					#endif
					#ifdef _EMISSIONENABLED_ON
					float4 staticSwitch1017_g61063 = ( _EmissionColor + staticSwitch1006_g61063 );
					#else
					float4 staticSwitch1017_g61063 = temp_cast_2;
					#endif
					float4 Emission86_g61063 = staticSwitch1017_g61063;
					float4 temp_output_690_0_g61063 = ( Emission86_g61063 + temp_output_614_0_g61063 );
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1019_g61063 = ( temp_output_614_0_g61063 * Emission86_g61063 );
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1019_g61063 = temp_output_690_0_g61063;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1019_g61063 = temp_output_690_0_g61063;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1019_g61063 = temp_output_690_0_g61063;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1019_g61063 = temp_output_690_0_g61063;
					#else
					float4 staticSwitch1019_g61063 = ( temp_output_614_0_g61063 * Emission86_g61063 );
					#endif
					float3 temp_output_35_0_g61101 = staticSwitch1019_g61063.rgb;
					float3 Color353_g61101 = temp_output_35_0_g61101;
					#if defined( _LUTMODE_2D )
					float3 staticSwitch273_g61101 = saturate( temp_output_35_0_g61101 );
					#elif defined( _LUTMODE_3D )
					float3 staticSwitch273_g61101 = temp_output_35_0_g61101;
					#else
					float3 staticSwitch273_g61101 = temp_output_35_0_g61101;
					#endif
					float3 Color_Saturate49_g61101 = staticSwitch273_g61101;
					float Lut_Height213_g61101 = _LUTSize;
					float Lut_Width216_g61101 = ( _LUTSize * Lut_Height213_g61101 );
					float3 appendResult214_g61101 = (float3(( 1.0 / Lut_Width216_g61101 ) , ( 1.0 / Lut_Height213_g61101 ) , ( Lut_Height213_g61101 - 1.0 )));
					float3 Scale_Offset208_g61101 = appendResult214_g61101;
					float2 Scale_Factor292_g61101 = ( (Scale_Offset208_g61101).xy * (Scale_Offset208_g61101).z );
					float2 Offset299_g61101 = ( (Scale_Offset208_g61101).xy * 0.5 );
					float2 Adjusted_UV305_g61101 = ( ( (Color_Saturate49_g61101).xy * Scale_Factor292_g61101 ) + Offset299_g61101 );
					float Scaled_Blue280_g61101 = ( (Color_Saturate49_g61101).z * (Scale_Offset208_g61101).z );
					float Shift288_g61101 = floor( Scaled_Blue280_g61101 );
					float Final_X313_g61101 = ( (Adjusted_UV305_g61101).x + ( Shift288_g61101 * (Scale_Offset208_g61101).y ) );
					float2 appendResult326_g61101 = (float2(Final_X313_g61101 , (Adjusted_UV305_g61101).y));
					float2 Final_UV325_g61101 = appendResult326_g61101;
					float2 appendResult338_g61101 = (float2((Scale_Offset208_g61101).y , 0.0));
					float2 Offset_UV336_g61101 = ( Final_UV325_g61101 + appendResult338_g61101 );
					float3 lerpResult333_g61101 = lerp( tex2D( _2DLut, Final_UV325_g61101 ).rgb , tex2D( _2DLut, Offset_UV336_g61101 ).rgb , ( Scaled_Blue280_g61101 - Shift288_g61101 ));
					#ifdef _2DLUT
					float3 staticSwitch347_g61101 = lerpResult333_g61101;
					#else
					float3 staticSwitch347_g61101 = Color_Saturate49_g61101;
					#endif
					float3 TwoD_LUT346_g61101 = staticSwitch347_g61101;
					float3 RGB16_g61102 = ( ( log10( ( ( Color_Saturate49_g61101 * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 );
					#ifdef _3DLUT
					float3 staticSwitch194_g61101 = tex3D( _3DLut, RGB16_g61102 ).rgb;
					#else
					float3 staticSwitch194_g61101 = Color_Saturate49_g61101;
					#endif
					float3 ThreeD_LUT51_g61101 = staticSwitch194_g61101;
					#if defined( _LUTMODE_2D )
					float3 staticSwitch42_g61101 = TwoD_LUT346_g61101;
					#elif defined( _LUTMODE_3D )
					float3 staticSwitch42_g61101 = ThreeD_LUT51_g61101;
					#else
					float3 staticSwitch42_g61101 = ThreeD_LUT51_g61101;
					#endif
					#ifdef SHADER_API_MOBILE
					float3 staticSwitch41_g61101 = staticSwitch42_g61101;
					#else
					float3 staticSwitch41_g61101 = Color353_g61101;
					#endif
					

					o.Albedo = Albedo6_g61063.rgb;
					o.Normal = half3( 0, 0, 1 );
					o.Emission = staticSwitch41_g61101;
					o.Alpha = 1;
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
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2930;160,-1408;Inherit;False;Meenphie Outline;44;;1551;d39aa08508dd494aeb2901b7a0739759;0;0;2;FLOAT3;17;COLOR;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3251;192,-1200;Inherit;False;Meenphie;0;;61063;b3ba55a08dd6b49c7be16c6f35cf2033;1,1008,0;0;9;COLOR;625;FLOAT3;238;FLOAT;96;FLOAT;97;FLOAT;1042;FLOAT3;624;FLOAT;156;FLOAT;427;FLOAT3;1024
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2889;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;True;1;LightMode=ForwardAdd;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2890;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2891;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2892;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2893;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2894;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ScenePickingPass;0;7;ScenePickingPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;True;1;LightMode=ScenePickingPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2887;480,-1440;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;True;True;0;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;True;True;1;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;0;False;;True;0;False;;True;False;0;False;;0;False;;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2888;512,-1200;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;Meenphie/Standard/Opaque;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardBase;0;1;ForwardBase;17;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;True;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;0;False;;True;0;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;True;True;0;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;44;Category;0;0;  Instanced Terrain Normals;1;0;Workflow;1;638915476438868730;Surface;0;0;  Blend;0;0;  Dither Shadows;1;0;Two Sided;1;638915389515035230;Alpha Clipping;0;0;  Use Shadow Threshold;0;0;Deferred Pass;0;638915388739756900;Normal Space;0;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;0;638915410807634230;Receive Shadows;1;0;Receive Specular;0;638915388784334560;Receive Reflections;1;638915388803555030;GPU Instancing;1;638915411619689990;LOD CrossFade;1;0;Built-in Fog;1;0;Ambient Light;1;0;Meta Pass;1;0;Add Pass;1;0;Override Baked GI;0;638915390973737640;Write Depth;0;638915391054792770;Extra Pre Pass;1;638915414992188530;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;0;Vertex Position;1;0;0;8;True;True;True;False;True;False;False;False;False;;False;0
WireConnection;2887;0;2930;17
WireConnection;2887;3;2930;0
WireConnection;2888;0;3251;625
WireConnection;2888;1;3251;238
WireConnection;2888;4;3251;96
WireConnection;2888;5;3251;97
WireConnection;2888;6;3251;1042
WireConnection;2888;2;3251;624
ASEEND*/
//CHKSM=B7BAF537CBAA682FF0A6866F76FFEAB74542E8DA