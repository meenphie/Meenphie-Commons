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
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACELIGHTMAPPING( "CATEGORY SPACE LIGHTMAPPING", Float ) = 0
		[Meenphie_DrawerCategory(STOCHASTIC,true,0,0)] _CATEGORYSTOCHASTIC( "CATEGORY STOCHASTIC", Float ) = 0
		[Toggle( _STOCHASTICENABLED_ON )] _StochasticEnabled( "Stochastic Enabled", Float ) = 0
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESTOCHASTIC( "CATEGORY SPACE STOCHASTIC", Float ) = 0
		[Meenphie_DrawerCategory(OUTLINE,true,0,0)] _CATEGORYOUTLINE1( "CATEGORY OUTLINE", Float ) = 0
		[Toggle( _OUTLINEENABLED_ON )] _OutlineEnabled( "Outline Enabled", Float ) = 1
		_OutlineColor( "Outline Color", Color ) = ( 0.02, 0.02, 0.02 )
		_OutlineWidth( "Outline Width", Range( 0, 0.01 ) ) = 0.005
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACEOUTLINE1( "CATEGORY SPACE OUTLINE", Float ) = 0
		[HideInInspector] GenKey__GlossinessMap( "Assign keyword _GLOSSINESSMAP", Float ) = 1.0
		[HideInInspector] GenKey__MetallicMap( "Assign keyword _METALLICMAP", Float ) = 1.0
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
				uniform float _CATEGORYSPACESTOCHASTIC;
				uniform float _CATEGORYSTOCHASTIC;
				uniform float _CATEGORYLIGHTMAPPING;
				uniform float _CATEGORYSPACELIGHTMAPPING;
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

					float2 uv_MainTex907_g1505 = IN.ase_texcoord6.xy;
					float2 uv_MainTex = IN.ase_texcoord6.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					float2 temp_output_5_0_g1542 = uv_MainTex;
					float2 UV633_g1542 = temp_output_5_0_g1542;
					float2 UV100_g1543 = UV633_g1542;
					float2 temp_output_51_0_g1543 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g1543 * float2( 3.464,3.464 ) ) );
					float2 break55_g1543 = frac( temp_output_51_0_g1543 );
					float temp_output_56_0_g1543 = ( ( 1.0 - break55_g1543.x ) - break55_g1543.y );
					float2 temp_output_52_0_g1543 = floor( temp_output_51_0_g1543 );
					float2 temp_output_125_0_g1543 = ( temp_output_52_0_g1543 + float2( 1,1 ) );
					float2 ifLocalVar87_g1543 = 0;
					if( temp_output_56_0_g1543 > 0.0 )
					ifLocalVar87_g1543 = temp_output_52_0_g1543;
					else if( temp_output_56_0_g1543 == 0.0 )
					ifLocalVar87_g1543 = temp_output_125_0_g1543;
					else if( temp_output_56_0_g1543 < 0.0 )
					ifLocalVar87_g1543 = temp_output_125_0_g1543;
					float3 temp_output_7_0_g1544 = frac( ( (ifLocalVar87_g1543).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1544 = dot( temp_output_7_0_g1544 , ( (temp_output_7_0_g1544).yzx + 33.33 ) );
					float3 temp_output_12_0_g1544 = ( temp_output_7_0_g1544 + dotResult8_g1544 );
					float2 temp_output_597_0_g1542 = ( UV100_g1543 + frac( ( ( (temp_output_12_0_g1544).xx + (temp_output_12_0_g1544).yz ) * (temp_output_12_0_g1544).zy ) ) );
					float2 DDX631_g1542 = ddx( temp_output_5_0_g1542 );
					float2 DDY632_g1542 = ddy( temp_output_5_0_g1542 );
					float temp_output_65_0_g1543 = ( 0.0 - temp_output_56_0_g1543 );
					float ifLocalVar59_g1543 = 0;
					if( temp_output_56_0_g1543 <= 0.0 )
					ifLocalVar59_g1543 = temp_output_65_0_g1543;
					else
					ifLocalVar59_g1543 = temp_output_56_0_g1543;
					float temp_output_597_30_g1542 = ifLocalVar59_g1543;
					float2 temp_output_90_0_g1543 = ( temp_output_52_0_g1543 + float2( 0,1 ) );
					float2 temp_output_123_0_g1543 = ( temp_output_52_0_g1543 + float2( 1,0 ) );
					float2 ifLocalVar88_g1543 = 0;
					if( temp_output_56_0_g1543 > 0.0 )
					ifLocalVar88_g1543 = temp_output_90_0_g1543;
					else if( temp_output_56_0_g1543 == 0.0 )
					ifLocalVar88_g1543 = temp_output_123_0_g1543;
					else if( temp_output_56_0_g1543 < 0.0 )
					ifLocalVar88_g1543 = temp_output_123_0_g1543;
					float3 temp_output_7_0_g1545 = frac( ( (ifLocalVar88_g1543).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1545 = dot( temp_output_7_0_g1545 , ( (temp_output_7_0_g1545).yzx + 33.33 ) );
					float3 temp_output_12_0_g1545 = ( temp_output_7_0_g1545 + dotResult8_g1545 );
					float2 temp_output_597_26_g1542 = ( UV100_g1543 + frac( ( ( (temp_output_12_0_g1545).xx + (temp_output_12_0_g1545).yz ) * (temp_output_12_0_g1545).zy ) ) );
					float temp_output_66_0_g1543 = ( 1.0 - break55_g1543.y );
					float ifLocalVar60_g1543 = 0;
					if( temp_output_56_0_g1543 <= 0.0 )
					ifLocalVar60_g1543 = temp_output_66_0_g1543;
					else
					ifLocalVar60_g1543 = break55_g1543.y;
					float temp_output_597_28_g1542 = ifLocalVar60_g1543;
					float2 ifLocalVar89_g1543 = 0;
					if( temp_output_56_0_g1543 > 0.0 )
					ifLocalVar89_g1543 = temp_output_123_0_g1543;
					else if( temp_output_56_0_g1543 == 0.0 )
					ifLocalVar89_g1543 = temp_output_90_0_g1543;
					else if( temp_output_56_0_g1543 < 0.0 )
					ifLocalVar89_g1543 = temp_output_90_0_g1543;
					float3 temp_output_7_0_g1546 = frac( ( (ifLocalVar89_g1543).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1546 = dot( temp_output_7_0_g1546 , ( (temp_output_7_0_g1546).yzx + 33.33 ) );
					float3 temp_output_12_0_g1546 = ( temp_output_7_0_g1546 + dotResult8_g1546 );
					float2 temp_output_597_27_g1542 = ( UV100_g1543 + frac( ( ( (temp_output_12_0_g1546).xx + (temp_output_12_0_g1546).yz ) * (temp_output_12_0_g1546).zy ) ) );
					float temp_output_67_0_g1543 = ( 1.0 - break55_g1543.x );
					float ifLocalVar61_g1543 = 0;
					if( temp_output_56_0_g1543 <= 0.0 )
					ifLocalVar61_g1543 = temp_output_67_0_g1543;
					else
					ifLocalVar61_g1543 = break55_g1543.x;
					float temp_output_597_29_g1542 = ifLocalVar61_g1543;
					float4 Output_2D293_g1542 = ( ( tex2D( _MainTex, temp_output_597_0_g1542, DDX631_g1542, DDY632_g1542 ) * temp_output_597_30_g1542 ) + ( tex2D( _MainTex, temp_output_597_26_g1542, DDX631_g1542, DDY632_g1542 ) * temp_output_597_28_g1542 ) + ( tex2D( _MainTex, temp_output_597_27_g1542, DDX631_g1542, DDY632_g1542 ) * temp_output_597_29_g1542 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g1505 = Output_2D293_g1542;
					#else
					float4 staticSwitch1001_g1505 = tex2D( _MainTex, uv_MainTex907_g1505 );
					#endif
					float4 temp_output_976_0_g1505 = ( _Color * staticSwitch1001_g1505 );
					float4 Albedo6_g1505 = temp_output_976_0_g1505;
					
					float2 uv_BumpMap830_g1505 = IN.ase_texcoord6.xy;
					float2 uv_BumpMap = IN.ase_texcoord6.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					float2 temp_output_5_0_g1537 = uv_BumpMap;
					float2 UV633_g1537 = temp_output_5_0_g1537;
					float2 UV100_g1538 = UV633_g1537;
					float2 temp_output_51_0_g1538 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g1538 * float2( 3.464,3.464 ) ) );
					float2 break55_g1538 = frac( temp_output_51_0_g1538 );
					float temp_output_56_0_g1538 = ( ( 1.0 - break55_g1538.x ) - break55_g1538.y );
					float2 temp_output_52_0_g1538 = floor( temp_output_51_0_g1538 );
					float2 temp_output_125_0_g1538 = ( temp_output_52_0_g1538 + float2( 1,1 ) );
					float2 ifLocalVar87_g1538 = 0;
					if( temp_output_56_0_g1538 > 0.0 )
					ifLocalVar87_g1538 = temp_output_52_0_g1538;
					else if( temp_output_56_0_g1538 == 0.0 )
					ifLocalVar87_g1538 = temp_output_125_0_g1538;
					else if( temp_output_56_0_g1538 < 0.0 )
					ifLocalVar87_g1538 = temp_output_125_0_g1538;
					float3 temp_output_7_0_g1539 = frac( ( (ifLocalVar87_g1538).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1539 = dot( temp_output_7_0_g1539 , ( (temp_output_7_0_g1539).yzx + 33.33 ) );
					float3 temp_output_12_0_g1539 = ( temp_output_7_0_g1539 + dotResult8_g1539 );
					float2 temp_output_597_0_g1537 = ( UV100_g1538 + frac( ( ( (temp_output_12_0_g1539).xx + (temp_output_12_0_g1539).yz ) * (temp_output_12_0_g1539).zy ) ) );
					float2 DDX631_g1537 = ddx( temp_output_5_0_g1537 );
					float2 DDY632_g1537 = ddy( temp_output_5_0_g1537 );
					float Input_Scale617_g1537 = _NormalScale;
					float temp_output_65_0_g1538 = ( 0.0 - temp_output_56_0_g1538 );
					float ifLocalVar59_g1538 = 0;
					if( temp_output_56_0_g1538 <= 0.0 )
					ifLocalVar59_g1538 = temp_output_65_0_g1538;
					else
					ifLocalVar59_g1538 = temp_output_56_0_g1538;
					float temp_output_597_30_g1537 = ifLocalVar59_g1538;
					float2 temp_output_90_0_g1538 = ( temp_output_52_0_g1538 + float2( 0,1 ) );
					float2 temp_output_123_0_g1538 = ( temp_output_52_0_g1538 + float2( 1,0 ) );
					float2 ifLocalVar88_g1538 = 0;
					if( temp_output_56_0_g1538 > 0.0 )
					ifLocalVar88_g1538 = temp_output_90_0_g1538;
					else if( temp_output_56_0_g1538 == 0.0 )
					ifLocalVar88_g1538 = temp_output_123_0_g1538;
					else if( temp_output_56_0_g1538 < 0.0 )
					ifLocalVar88_g1538 = temp_output_123_0_g1538;
					float3 temp_output_7_0_g1540 = frac( ( (ifLocalVar88_g1538).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1540 = dot( temp_output_7_0_g1540 , ( (temp_output_7_0_g1540).yzx + 33.33 ) );
					float3 temp_output_12_0_g1540 = ( temp_output_7_0_g1540 + dotResult8_g1540 );
					float2 temp_output_597_26_g1537 = ( UV100_g1538 + frac( ( ( (temp_output_12_0_g1540).xx + (temp_output_12_0_g1540).yz ) * (temp_output_12_0_g1540).zy ) ) );
					float temp_output_66_0_g1538 = ( 1.0 - break55_g1538.y );
					float ifLocalVar60_g1538 = 0;
					if( temp_output_56_0_g1538 <= 0.0 )
					ifLocalVar60_g1538 = temp_output_66_0_g1538;
					else
					ifLocalVar60_g1538 = break55_g1538.y;
					float temp_output_597_28_g1537 = ifLocalVar60_g1538;
					float2 ifLocalVar89_g1538 = 0;
					if( temp_output_56_0_g1538 > 0.0 )
					ifLocalVar89_g1538 = temp_output_123_0_g1538;
					else if( temp_output_56_0_g1538 == 0.0 )
					ifLocalVar89_g1538 = temp_output_90_0_g1538;
					else if( temp_output_56_0_g1538 < 0.0 )
					ifLocalVar89_g1538 = temp_output_90_0_g1538;
					float3 temp_output_7_0_g1541 = frac( ( (ifLocalVar89_g1538).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1541 = dot( temp_output_7_0_g1541 , ( (temp_output_7_0_g1541).yzx + 33.33 ) );
					float3 temp_output_12_0_g1541 = ( temp_output_7_0_g1541 + dotResult8_g1541 );
					float2 temp_output_597_27_g1537 = ( UV100_g1538 + frac( ( ( (temp_output_12_0_g1541).xx + (temp_output_12_0_g1541).yz ) * (temp_output_12_0_g1541).zy ) ) );
					float temp_output_67_0_g1538 = ( 1.0 - break55_g1538.x );
					float ifLocalVar61_g1538 = 0;
					if( temp_output_56_0_g1538 <= 0.0 )
					ifLocalVar61_g1538 = temp_output_67_0_g1538;
					else
					ifLocalVar61_g1538 = break55_g1538.x;
					float temp_output_597_29_g1537 = ifLocalVar61_g1538;
					float3 Output_2D_Normal641_g1537 = ( ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_0_g1537, DDX631_g1537, DDY632_g1537 ), Input_Scale617_g1537 ) * temp_output_597_30_g1537 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_26_g1537, DDX631_g1537, DDY632_g1537 ), Input_Scale617_g1537 ) * temp_output_597_28_g1537 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_27_g1537, DDX631_g1537, DDY632_g1537 ), Input_Scale617_g1537 ) * float3( 0,0,0 ) * temp_output_597_29_g1537 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g1505 = Output_2D_Normal641_g1537;
					#else
					float3 staticSwitch1003_g1505 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap830_g1505 ), _NormalScale );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g1505 = staticSwitch1003_g1505;
					#else
					float3 staticSwitch980_g1505 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g1505 = staticSwitch980_g1505;
					
					float2 uv_MetallicMap48_g1505 = IN.ase_texcoord6.xy;
					float2 uv_MetallicMap = IN.ase_texcoord6.xy * _MetallicMap_ST.xy + _MetallicMap_ST.zw;
					float2 temp_output_5_0_g1527 = uv_MetallicMap;
					float2 UV633_g1527 = temp_output_5_0_g1527;
					float2 UV100_g1528 = UV633_g1527;
					float2 temp_output_51_0_g1528 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g1528 * float2( 3.464,3.464 ) ) );
					float2 break55_g1528 = frac( temp_output_51_0_g1528 );
					float temp_output_56_0_g1528 = ( ( 1.0 - break55_g1528.x ) - break55_g1528.y );
					float2 temp_output_52_0_g1528 = floor( temp_output_51_0_g1528 );
					float2 temp_output_125_0_g1528 = ( temp_output_52_0_g1528 + float2( 1,1 ) );
					float2 ifLocalVar87_g1528 = 0;
					if( temp_output_56_0_g1528 > 0.0 )
					ifLocalVar87_g1528 = temp_output_52_0_g1528;
					else if( temp_output_56_0_g1528 == 0.0 )
					ifLocalVar87_g1528 = temp_output_125_0_g1528;
					else if( temp_output_56_0_g1528 < 0.0 )
					ifLocalVar87_g1528 = temp_output_125_0_g1528;
					float3 temp_output_7_0_g1529 = frac( ( (ifLocalVar87_g1528).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1529 = dot( temp_output_7_0_g1529 , ( (temp_output_7_0_g1529).yzx + 33.33 ) );
					float3 temp_output_12_0_g1529 = ( temp_output_7_0_g1529 + dotResult8_g1529 );
					float2 temp_output_597_0_g1527 = ( UV100_g1528 + frac( ( ( (temp_output_12_0_g1529).xx + (temp_output_12_0_g1529).yz ) * (temp_output_12_0_g1529).zy ) ) );
					float2 DDX631_g1527 = ddx( temp_output_5_0_g1527 );
					float2 DDY632_g1527 = ddy( temp_output_5_0_g1527 );
					float temp_output_65_0_g1528 = ( 0.0 - temp_output_56_0_g1528 );
					float ifLocalVar59_g1528 = 0;
					if( temp_output_56_0_g1528 <= 0.0 )
					ifLocalVar59_g1528 = temp_output_65_0_g1528;
					else
					ifLocalVar59_g1528 = temp_output_56_0_g1528;
					float temp_output_597_30_g1527 = ifLocalVar59_g1528;
					float2 temp_output_90_0_g1528 = ( temp_output_52_0_g1528 + float2( 0,1 ) );
					float2 temp_output_123_0_g1528 = ( temp_output_52_0_g1528 + float2( 1,0 ) );
					float2 ifLocalVar88_g1528 = 0;
					if( temp_output_56_0_g1528 > 0.0 )
					ifLocalVar88_g1528 = temp_output_90_0_g1528;
					else if( temp_output_56_0_g1528 == 0.0 )
					ifLocalVar88_g1528 = temp_output_123_0_g1528;
					else if( temp_output_56_0_g1528 < 0.0 )
					ifLocalVar88_g1528 = temp_output_123_0_g1528;
					float3 temp_output_7_0_g1530 = frac( ( (ifLocalVar88_g1528).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1530 = dot( temp_output_7_0_g1530 , ( (temp_output_7_0_g1530).yzx + 33.33 ) );
					float3 temp_output_12_0_g1530 = ( temp_output_7_0_g1530 + dotResult8_g1530 );
					float2 temp_output_597_26_g1527 = ( UV100_g1528 + frac( ( ( (temp_output_12_0_g1530).xx + (temp_output_12_0_g1530).yz ) * (temp_output_12_0_g1530).zy ) ) );
					float temp_output_66_0_g1528 = ( 1.0 - break55_g1528.y );
					float ifLocalVar60_g1528 = 0;
					if( temp_output_56_0_g1528 <= 0.0 )
					ifLocalVar60_g1528 = temp_output_66_0_g1528;
					else
					ifLocalVar60_g1528 = break55_g1528.y;
					float temp_output_597_28_g1527 = ifLocalVar60_g1528;
					float2 ifLocalVar89_g1528 = 0;
					if( temp_output_56_0_g1528 > 0.0 )
					ifLocalVar89_g1528 = temp_output_123_0_g1528;
					else if( temp_output_56_0_g1528 == 0.0 )
					ifLocalVar89_g1528 = temp_output_90_0_g1528;
					else if( temp_output_56_0_g1528 < 0.0 )
					ifLocalVar89_g1528 = temp_output_90_0_g1528;
					float3 temp_output_7_0_g1531 = frac( ( (ifLocalVar89_g1528).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1531 = dot( temp_output_7_0_g1531 , ( (temp_output_7_0_g1531).yzx + 33.33 ) );
					float3 temp_output_12_0_g1531 = ( temp_output_7_0_g1531 + dotResult8_g1531 );
					float2 temp_output_597_27_g1527 = ( UV100_g1528 + frac( ( ( (temp_output_12_0_g1531).xx + (temp_output_12_0_g1531).yz ) * (temp_output_12_0_g1531).zy ) ) );
					float temp_output_67_0_g1528 = ( 1.0 - break55_g1528.x );
					float ifLocalVar61_g1528 = 0;
					if( temp_output_56_0_g1528 <= 0.0 )
					ifLocalVar61_g1528 = temp_output_67_0_g1528;
					else
					ifLocalVar61_g1528 = break55_g1528.x;
					float temp_output_597_29_g1527 = ifLocalVar61_g1528;
					float4 Output_2D293_g1527 = ( ( tex2D( _MetallicMap, temp_output_597_0_g1527, DDX631_g1527, DDY632_g1527 ) * temp_output_597_30_g1527 ) + ( tex2D( _MetallicMap, temp_output_597_26_g1527, DDX631_g1527, DDY632_g1527 ) * temp_output_597_28_g1527 ) + ( tex2D( _MetallicMap, temp_output_597_27_g1527, DDX631_g1527, DDY632_g1527 ) * temp_output_597_29_g1527 ) );
					float4 break31_g1527 = Output_2D293_g1527;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g1505 = break31_g1527.a;
					#else
					float staticSwitch1005_g1505 = tex2D( _MetallicMap, uv_MetallicMap48_g1505 ).a;
					#endif
					float saferPower803_g1505 = abs( staticSwitch1005_g1505 );
					#ifdef _METALLICMAP
					float staticSwitch846_g1505 = pow( saferPower803_g1505 , 3.0 );
					#else
					float staticSwitch846_g1505 = _Metallic;
					#endif
					float Metallic699_g1505 = staticSwitch846_g1505;
					
					float2 uv_GlossinessMap64_g1505 = IN.ase_texcoord6.xy;
					float2 uv_GlossinessMap = IN.ase_texcoord6.xy * _GlossinessMap_ST.xy + _GlossinessMap_ST.zw;
					float2 temp_output_5_0_g1532 = uv_GlossinessMap;
					float2 UV633_g1532 = temp_output_5_0_g1532;
					float2 UV100_g1533 = UV633_g1532;
					float2 temp_output_51_0_g1533 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g1533 * float2( 3.464,3.464 ) ) );
					float2 break55_g1533 = frac( temp_output_51_0_g1533 );
					float temp_output_56_0_g1533 = ( ( 1.0 - break55_g1533.x ) - break55_g1533.y );
					float2 temp_output_52_0_g1533 = floor( temp_output_51_0_g1533 );
					float2 temp_output_125_0_g1533 = ( temp_output_52_0_g1533 + float2( 1,1 ) );
					float2 ifLocalVar87_g1533 = 0;
					if( temp_output_56_0_g1533 > 0.0 )
					ifLocalVar87_g1533 = temp_output_52_0_g1533;
					else if( temp_output_56_0_g1533 == 0.0 )
					ifLocalVar87_g1533 = temp_output_125_0_g1533;
					else if( temp_output_56_0_g1533 < 0.0 )
					ifLocalVar87_g1533 = temp_output_125_0_g1533;
					float3 temp_output_7_0_g1534 = frac( ( (ifLocalVar87_g1533).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1534 = dot( temp_output_7_0_g1534 , ( (temp_output_7_0_g1534).yzx + 33.33 ) );
					float3 temp_output_12_0_g1534 = ( temp_output_7_0_g1534 + dotResult8_g1534 );
					float2 temp_output_597_0_g1532 = ( UV100_g1533 + frac( ( ( (temp_output_12_0_g1534).xx + (temp_output_12_0_g1534).yz ) * (temp_output_12_0_g1534).zy ) ) );
					float2 DDX631_g1532 = ddx( temp_output_5_0_g1532 );
					float2 DDY632_g1532 = ddy( temp_output_5_0_g1532 );
					float temp_output_65_0_g1533 = ( 0.0 - temp_output_56_0_g1533 );
					float ifLocalVar59_g1533 = 0;
					if( temp_output_56_0_g1533 <= 0.0 )
					ifLocalVar59_g1533 = temp_output_65_0_g1533;
					else
					ifLocalVar59_g1533 = temp_output_56_0_g1533;
					float temp_output_597_30_g1532 = ifLocalVar59_g1533;
					float2 temp_output_90_0_g1533 = ( temp_output_52_0_g1533 + float2( 0,1 ) );
					float2 temp_output_123_0_g1533 = ( temp_output_52_0_g1533 + float2( 1,0 ) );
					float2 ifLocalVar88_g1533 = 0;
					if( temp_output_56_0_g1533 > 0.0 )
					ifLocalVar88_g1533 = temp_output_90_0_g1533;
					else if( temp_output_56_0_g1533 == 0.0 )
					ifLocalVar88_g1533 = temp_output_123_0_g1533;
					else if( temp_output_56_0_g1533 < 0.0 )
					ifLocalVar88_g1533 = temp_output_123_0_g1533;
					float3 temp_output_7_0_g1535 = frac( ( (ifLocalVar88_g1533).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1535 = dot( temp_output_7_0_g1535 , ( (temp_output_7_0_g1535).yzx + 33.33 ) );
					float3 temp_output_12_0_g1535 = ( temp_output_7_0_g1535 + dotResult8_g1535 );
					float2 temp_output_597_26_g1532 = ( UV100_g1533 + frac( ( ( (temp_output_12_0_g1535).xx + (temp_output_12_0_g1535).yz ) * (temp_output_12_0_g1535).zy ) ) );
					float temp_output_66_0_g1533 = ( 1.0 - break55_g1533.y );
					float ifLocalVar60_g1533 = 0;
					if( temp_output_56_0_g1533 <= 0.0 )
					ifLocalVar60_g1533 = temp_output_66_0_g1533;
					else
					ifLocalVar60_g1533 = break55_g1533.y;
					float temp_output_597_28_g1532 = ifLocalVar60_g1533;
					float2 ifLocalVar89_g1533 = 0;
					if( temp_output_56_0_g1533 > 0.0 )
					ifLocalVar89_g1533 = temp_output_123_0_g1533;
					else if( temp_output_56_0_g1533 == 0.0 )
					ifLocalVar89_g1533 = temp_output_90_0_g1533;
					else if( temp_output_56_0_g1533 < 0.0 )
					ifLocalVar89_g1533 = temp_output_90_0_g1533;
					float3 temp_output_7_0_g1536 = frac( ( (ifLocalVar89_g1533).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1536 = dot( temp_output_7_0_g1536 , ( (temp_output_7_0_g1536).yzx + 33.33 ) );
					float3 temp_output_12_0_g1536 = ( temp_output_7_0_g1536 + dotResult8_g1536 );
					float2 temp_output_597_27_g1532 = ( UV100_g1533 + frac( ( ( (temp_output_12_0_g1536).xx + (temp_output_12_0_g1536).yz ) * (temp_output_12_0_g1536).zy ) ) );
					float temp_output_67_0_g1533 = ( 1.0 - break55_g1533.x );
					float ifLocalVar61_g1533 = 0;
					if( temp_output_56_0_g1533 <= 0.0 )
					ifLocalVar61_g1533 = temp_output_67_0_g1533;
					else
					ifLocalVar61_g1533 = break55_g1533.x;
					float temp_output_597_29_g1532 = ifLocalVar61_g1533;
					float4 Output_2D293_g1532 = ( ( tex2D( _GlossinessMap, temp_output_597_0_g1532, DDX631_g1532, DDY632_g1532 ) * temp_output_597_30_g1532 ) + ( tex2D( _GlossinessMap, temp_output_597_26_g1532, DDX631_g1532, DDY632_g1532 ) * temp_output_597_28_g1532 ) + ( tex2D( _GlossinessMap, temp_output_597_27_g1532, DDX631_g1532, DDY632_g1532 ) * temp_output_597_29_g1532 ) );
					float4 break31_g1532 = Output_2D293_g1532;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g1505 = break31_g1532.a;
					#else
					float staticSwitch1004_g1505 = tex2D( _GlossinessMap, uv_GlossinessMap64_g1505 ).a;
					#endif
					float saferPower804_g1505 = abs( staticSwitch1004_g1505 );
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g1505 = ( 1.0 - pow( saferPower804_g1505 , 3.0 ) );
					#else
					float staticSwitch845_g1505 = _Glossiness;
					#endif
					float3 temp_output_3_0_g1547 = ddx( NormalWS );
					float dotResult5_g1547 = dot( temp_output_3_0_g1547 , temp_output_3_0_g1547 );
					float3 temp_output_4_0_g1547 = ddy( NormalWS );
					float dotResult6_g1547 = dot( temp_output_4_0_g1547 , temp_output_4_0_g1547 );
					#ifdef _USEGEOMETRICANTIALIASING_ON
					float staticSwitch824_g1505 = min( staticSwitch845_g1505 , ( 1.0 - pow( saturate( max( dotResult5_g1547 , dotResult6_g1547 ) ) , 0.333 ) ) );
					#else
					float staticSwitch824_g1505 = staticSwitch845_g1505;
					#endif
					
					float White38_g1505 = 1.0;
					float4 temp_cast_1 = (White38_g1505).xxxx;
					float localBicubicPrepare2_g1507 = ( 0.0 );
					float2 uv3_Lightmap0 = IN.ase_texcoord6.zw * _Lightmap0_ST.xy + _Lightmap0_ST.zw;
					float2 Input_UV100_g1507 = uv3_Lightmap0;
					float2 UV2_g1507 = Input_UV100_g1507;
					float4 TexelSize2_g1507 = _Lightmap0_TexelSize;
					float2 UV02_g1507 = float2( 0,0 );
					float2 UV12_g1507 = float2( 0,0 );
					float2 UV22_g1507 = float2( 0,0 );
					float2 UV32_g1507 = float2( 0,0 );
					float W02_g1507 = 0;
					float W12_g1507 = 0;
					{
					{
					 UV2_g1507 = UV2_g1507 * TexelSize2_g1507.zw - 0.5;
					    float2 f = frac( UV2_g1507 );
					    UV2_g1507 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g1507.x - 0.5, UV2_g1507.x + 1.5, UV2_g1507.y - 0.5, UV2_g1507.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1507.xyxy;
					    UV02_g1507 = off.xz;
					    UV12_g1507 = off.yz;
					    UV22_g1507 = off.xw;
					    UV32_g1507 = off.yw;
					    W02_g1507 = s.x / ( s.x + s.y );
					 W12_g1507 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g1507 = lerp( tex2D( _Lightmap0, UV32_g1507 ) , tex2D( _Lightmap0, UV22_g1507 ) , W02_g1507);
					float4 lerpResult45_g1507 = lerp( tex2D( _Lightmap0, UV12_g1507 ) , tex2D( _Lightmap0, UV02_g1507 ) , W02_g1507);
					float4 lerpResult44_g1507 = lerp( lerpResult46_g1507 , lerpResult45_g1507 , W12_g1507);
					float4 Output_2D131_g1507 = lerpResult44_g1507;
					float4 Lightmap_0925_g1505 = Output_2D131_g1507;
					float localBicubicPrepare2_g1509 = ( 0.0 );
					float2 uv3_Lightmap1 = IN.ase_texcoord6.zw * _Lightmap1_ST.xy + _Lightmap1_ST.zw;
					float2 Input_UV100_g1509 = uv3_Lightmap1;
					float2 UV2_g1509 = Input_UV100_g1509;
					float4 TexelSize2_g1509 = _Lightmap1_TexelSize;
					float2 UV02_g1509 = float2( 0,0 );
					float2 UV12_g1509 = float2( 0,0 );
					float2 UV22_g1509 = float2( 0,0 );
					float2 UV32_g1509 = float2( 0,0 );
					float W02_g1509 = 0;
					float W12_g1509 = 0;
					{
					{
					 UV2_g1509 = UV2_g1509 * TexelSize2_g1509.zw - 0.5;
					    float2 f = frac( UV2_g1509 );
					    UV2_g1509 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g1509.x - 0.5, UV2_g1509.x + 1.5, UV2_g1509.y - 0.5, UV2_g1509.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1509.xyxy;
					    UV02_g1509 = off.xz;
					    UV12_g1509 = off.yz;
					    UV22_g1509 = off.xw;
					    UV32_g1509 = off.yw;
					    W02_g1509 = s.x / ( s.x + s.y );
					 W12_g1509 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g1509 = lerp( tex2D( _Lightmap1, UV32_g1509 ) , tex2D( _Lightmap1, UV22_g1509 ) , W02_g1509);
					float4 lerpResult45_g1509 = lerp( tex2D( _Lightmap1, UV12_g1509 ) , tex2D( _Lightmap1, UV02_g1509 ) , W02_g1509);
					float4 lerpResult44_g1509 = lerp( lerpResult46_g1509 , lerpResult45_g1509 , W12_g1509);
					float4 Output_2D131_g1509 = lerpResult44_g1509;
					float4 Lightmap_1956_g1505 = Output_2D131_g1509;
					float4 lerpResult442_g1505 = lerp( Lightmap_0925_g1505 , Lightmap_1956_g1505 , _LightmapLerp);
					float4 Lightmap_Lerp932_g1505 = lerpResult442_g1505;
					float3 appendResult139_g1520 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g1520 = normalize( Normal_Map700_g1505 );
					float3 Normal_Map318_g1520 = normalizeResult326_g1520;
					float dotResult121_g1520 = dot( appendResult139_g1520 , Normal_Map318_g1520 );
					float localStochasticTiling2_g1516 = ( 0.0 );
					float2 uv3_RNMX0 = IN.ase_texcoord6.zw * _RNMX0_ST.xy + _RNMX0_ST.zw;
					float2 UV2_g1516 = uv3_RNMX0;
					float4 TexelSize2_g1516 = _RNMX0_TexelSize;
					float4 Offsets2_g1516 = float4( 0,0,0,0 );
					float2 Weights2_g1516 = float2( 0,0 );
					{
					UV2_g1516 = UV2_g1516 * TexelSize2_g1516.zw - 0.5;
					float2 f = frac( UV2_g1516 );
					UV2_g1516 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g1516.x - 0.5, UV2_g1516.x + 1.5, UV2_g1516.y - 0.5, UV2_g1516.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g1516 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1516.xyxy;
					Weights2_g1516 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g1515 = Offsets2_g1516;
					float4 Input_FetchOffsets197_g1519 = temp_output_1_34_g1515;
					float2 temp_output_1_54_g1515 = Weights2_g1516;
					float2 Input_FetchWeights200_g1519 = temp_output_1_54_g1515;
					float2 break187_g1519 = Input_FetchWeights200_g1519;
					float4 lerpResult181_g1519 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g1519).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g1519).xw ) , break187_g1519.x);
					float4 lerpResult182_g1519 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g1519).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g1519).xz ) , break187_g1519.x);
					float4 lerpResult176_g1519 = lerp( lerpResult181_g1519 , lerpResult182_g1519 , break187_g1519.y);
					float4 Output_Fetch2D202_g1519 = lerpResult176_g1519;
					float3 appendResult146_g1520 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g1520 = dot( appendResult146_g1520 , Normal_Map318_g1520 );
					float4 Input_FetchOffsets197_g1517 = temp_output_1_34_g1515;
					float2 Input_FetchWeights200_g1517 = temp_output_1_54_g1515;
					float2 break187_g1517 = Input_FetchWeights200_g1517;
					float4 lerpResult181_g1517 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g1517).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g1517).xw ) , break187_g1517.x);
					float4 lerpResult182_g1517 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g1517).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g1517).xz ) , break187_g1517.x);
					float4 lerpResult176_g1517 = lerp( lerpResult181_g1517 , lerpResult182_g1517 , break187_g1517.y);
					float4 Output_Fetch2D202_g1517 = lerpResult176_g1517;
					float3 appendResult149_g1520 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g1520 = dot( appendResult149_g1520 , Normal_Map318_g1520 );
					float4 Input_FetchOffsets197_g1518 = temp_output_1_34_g1515;
					float2 Input_FetchWeights200_g1518 = temp_output_1_54_g1515;
					float2 break187_g1518 = Input_FetchWeights200_g1518;
					float4 lerpResult181_g1518 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g1518).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g1518).xw ) , break187_g1518.x);
					float4 lerpResult182_g1518 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g1518).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g1518).xz ) , break187_g1518.x);
					float4 lerpResult176_g1518 = lerp( lerpResult181_g1518 , lerpResult182_g1518 , break187_g1518.y);
					float4 Output_Fetch2D202_g1518 = lerpResult176_g1518;
					float4 RNM_0926_g1505 = ( ( ( saturate( dotResult121_g1520 ) * ( Output_Fetch2D202_g1519 * 0.8 ) ) + ( saturate( dotResult122_g1520 ) * ( Output_Fetch2D202_g1517 * 0.8 ) ) ) + ( saturate( dotResult120_g1520 ) * ( Output_Fetch2D202_g1518 * 0.8 ) ) );
					float3 appendResult139_g1521 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g1521 = normalize( Normal_Map700_g1505 );
					float3 Normal_Map318_g1521 = normalizeResult326_g1521;
					float dotResult121_g1521 = dot( appendResult139_g1521 , Normal_Map318_g1521 );
					float localStochasticTiling2_g1511 = ( 0.0 );
					float2 uv3_RNMX1 = IN.ase_texcoord6.zw * _RNMX1_ST.xy + _RNMX1_ST.zw;
					float2 UV2_g1511 = uv3_RNMX1;
					float4 TexelSize2_g1511 = _RNMX1_TexelSize;
					float4 Offsets2_g1511 = float4( 0,0,0,0 );
					float2 Weights2_g1511 = float2( 0,0 );
					{
					UV2_g1511 = UV2_g1511 * TexelSize2_g1511.zw - 0.5;
					float2 f = frac( UV2_g1511 );
					UV2_g1511 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g1511.x - 0.5, UV2_g1511.x + 1.5, UV2_g1511.y - 0.5, UV2_g1511.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g1511 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1511.xyxy;
					Weights2_g1511 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g1510 = Offsets2_g1511;
					float4 Input_FetchOffsets197_g1514 = temp_output_1_34_g1510;
					float2 temp_output_1_54_g1510 = Weights2_g1511;
					float2 Input_FetchWeights200_g1514 = temp_output_1_54_g1510;
					float2 break187_g1514 = Input_FetchWeights200_g1514;
					float4 lerpResult181_g1514 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g1514).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g1514).xw ) , break187_g1514.x);
					float4 lerpResult182_g1514 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g1514).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g1514).xz ) , break187_g1514.x);
					float4 lerpResult176_g1514 = lerp( lerpResult181_g1514 , lerpResult182_g1514 , break187_g1514.y);
					float4 Output_Fetch2D202_g1514 = lerpResult176_g1514;
					float3 appendResult146_g1521 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g1521 = dot( appendResult146_g1521 , Normal_Map318_g1521 );
					float4 Input_FetchOffsets197_g1512 = temp_output_1_34_g1510;
					float2 Input_FetchWeights200_g1512 = temp_output_1_54_g1510;
					float2 break187_g1512 = Input_FetchWeights200_g1512;
					float4 lerpResult181_g1512 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g1512).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g1512).xw ) , break187_g1512.x);
					float4 lerpResult182_g1512 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g1512).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g1512).xz ) , break187_g1512.x);
					float4 lerpResult176_g1512 = lerp( lerpResult181_g1512 , lerpResult182_g1512 , break187_g1512.y);
					float4 Output_Fetch2D202_g1512 = lerpResult176_g1512;
					float3 appendResult149_g1521 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g1521 = dot( appendResult149_g1521 , Normal_Map318_g1521 );
					float4 Input_FetchOffsets197_g1513 = temp_output_1_34_g1510;
					float2 Input_FetchWeights200_g1513 = temp_output_1_54_g1510;
					float2 break187_g1513 = Input_FetchWeights200_g1513;
					float4 lerpResult181_g1513 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g1513).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g1513).xw ) , break187_g1513.x);
					float4 lerpResult182_g1513 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g1513).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g1513).xz ) , break187_g1513.x);
					float4 lerpResult176_g1513 = lerp( lerpResult181_g1513 , lerpResult182_g1513 , break187_g1513.y);
					float4 Output_Fetch2D202_g1513 = lerpResult176_g1513;
					float4 RNM_1927_g1505 = ( ( ( saturate( dotResult121_g1521 ) * ( Output_Fetch2D202_g1514 * 0.8 ) ) + ( saturate( dotResult122_g1521 ) * ( Output_Fetch2D202_g1512 * 0.8 ) ) ) + ( saturate( dotResult120_g1521 ) * ( Output_Fetch2D202_g1513 * 0.8 ) ) );
					float Lightmap_Lerp_Value969_g1505 = _LightmapLerp;
					float4 lerpResult953_g1505 = lerp( RNM_0926_g1505 , RNM_1927_g1505 , Lightmap_Lerp_Value969_g1505);
					float4 RNM_Lerp950_g1505 = lerpResult953_g1505;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g1505 = temp_cast_1;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g1505 = Lightmap_0925_g1505;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g1505 = Lightmap_Lerp932_g1505;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g1505 = RNM_0926_g1505;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g1505 = RNM_Lerp950_g1505;
					#else
					float4 staticSwitch1014_g1505 = temp_cast_1;
					#endif
					float4 Lightmap46_g1505 = staticSwitch1014_g1505;
					float dotResult835_g1505 = dot( Lightmap46_g1505 , float4( float3( 0.299, 0.587, 0.114 ) , 0.0 ) );
					float saferPower606_g1505 = abs( dotResult835_g1505 );
					#ifdef _LIGHTMAPOCCLUSIONENABLED_ON
					float staticSwitch1018_g1505 = pow( saferPower606_g1505 , _OcclusionPower );
					#else
					float staticSwitch1018_g1505 = White38_g1505;
					#endif
					#if defined( _LIGHTMAPMODE_DISABLED )
					float staticSwitch1016_g1505 = White38_g1505;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float staticSwitch1016_g1505 = staticSwitch1018_g1505;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float staticSwitch1016_g1505 = staticSwitch1018_g1505;
					#elif defined( _LIGHTMAPMODE_RNM )
					float staticSwitch1016_g1505 = staticSwitch1018_g1505;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float staticSwitch1016_g1505 = staticSwitch1018_g1505;
					#else
					float staticSwitch1016_g1505 = White38_g1505;
					#endif
					
					float4 temp_output_614_0_g1505 = ( Albedo6_g1505 * Lightmap46_g1505 );
					float4 temp_cast_3 = 0;
					float2 uv_EmissionMap81_g1505 = IN.ase_texcoord6.xy;
					float2 uv_EmissionMap = IN.ase_texcoord6.xy * _EmissionMap_ST.xy + _EmissionMap_ST.zw;
					float2 temp_output_5_0_g1522 = uv_EmissionMap;
					float2 UV633_g1522 = temp_output_5_0_g1522;
					float2 UV100_g1523 = UV633_g1522;
					float2 temp_output_51_0_g1523 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g1523 * float2( 3.464,3.464 ) ) );
					float2 break55_g1523 = frac( temp_output_51_0_g1523 );
					float temp_output_56_0_g1523 = ( ( 1.0 - break55_g1523.x ) - break55_g1523.y );
					float2 temp_output_52_0_g1523 = floor( temp_output_51_0_g1523 );
					float2 temp_output_125_0_g1523 = ( temp_output_52_0_g1523 + float2( 1,1 ) );
					float2 ifLocalVar87_g1523 = 0;
					if( temp_output_56_0_g1523 > 0.0 )
					ifLocalVar87_g1523 = temp_output_52_0_g1523;
					else if( temp_output_56_0_g1523 == 0.0 )
					ifLocalVar87_g1523 = temp_output_125_0_g1523;
					else if( temp_output_56_0_g1523 < 0.0 )
					ifLocalVar87_g1523 = temp_output_125_0_g1523;
					float3 temp_output_7_0_g1524 = frac( ( (ifLocalVar87_g1523).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1524 = dot( temp_output_7_0_g1524 , ( (temp_output_7_0_g1524).yzx + 33.33 ) );
					float3 temp_output_12_0_g1524 = ( temp_output_7_0_g1524 + dotResult8_g1524 );
					float2 temp_output_597_0_g1522 = ( UV100_g1523 + frac( ( ( (temp_output_12_0_g1524).xx + (temp_output_12_0_g1524).yz ) * (temp_output_12_0_g1524).zy ) ) );
					float2 DDX631_g1522 = ddx( temp_output_5_0_g1522 );
					float2 DDY632_g1522 = ddy( temp_output_5_0_g1522 );
					float temp_output_65_0_g1523 = ( 0.0 - temp_output_56_0_g1523 );
					float ifLocalVar59_g1523 = 0;
					if( temp_output_56_0_g1523 <= 0.0 )
					ifLocalVar59_g1523 = temp_output_65_0_g1523;
					else
					ifLocalVar59_g1523 = temp_output_56_0_g1523;
					float temp_output_597_30_g1522 = ifLocalVar59_g1523;
					float2 temp_output_90_0_g1523 = ( temp_output_52_0_g1523 + float2( 0,1 ) );
					float2 temp_output_123_0_g1523 = ( temp_output_52_0_g1523 + float2( 1,0 ) );
					float2 ifLocalVar88_g1523 = 0;
					if( temp_output_56_0_g1523 > 0.0 )
					ifLocalVar88_g1523 = temp_output_90_0_g1523;
					else if( temp_output_56_0_g1523 == 0.0 )
					ifLocalVar88_g1523 = temp_output_123_0_g1523;
					else if( temp_output_56_0_g1523 < 0.0 )
					ifLocalVar88_g1523 = temp_output_123_0_g1523;
					float3 temp_output_7_0_g1525 = frac( ( (ifLocalVar88_g1523).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1525 = dot( temp_output_7_0_g1525 , ( (temp_output_7_0_g1525).yzx + 33.33 ) );
					float3 temp_output_12_0_g1525 = ( temp_output_7_0_g1525 + dotResult8_g1525 );
					float2 temp_output_597_26_g1522 = ( UV100_g1523 + frac( ( ( (temp_output_12_0_g1525).xx + (temp_output_12_0_g1525).yz ) * (temp_output_12_0_g1525).zy ) ) );
					float temp_output_66_0_g1523 = ( 1.0 - break55_g1523.y );
					float ifLocalVar60_g1523 = 0;
					if( temp_output_56_0_g1523 <= 0.0 )
					ifLocalVar60_g1523 = temp_output_66_0_g1523;
					else
					ifLocalVar60_g1523 = break55_g1523.y;
					float temp_output_597_28_g1522 = ifLocalVar60_g1523;
					float2 ifLocalVar89_g1523 = 0;
					if( temp_output_56_0_g1523 > 0.0 )
					ifLocalVar89_g1523 = temp_output_123_0_g1523;
					else if( temp_output_56_0_g1523 == 0.0 )
					ifLocalVar89_g1523 = temp_output_90_0_g1523;
					else if( temp_output_56_0_g1523 < 0.0 )
					ifLocalVar89_g1523 = temp_output_90_0_g1523;
					float3 temp_output_7_0_g1526 = frac( ( (ifLocalVar89_g1523).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1526 = dot( temp_output_7_0_g1526 , ( (temp_output_7_0_g1526).yzx + 33.33 ) );
					float3 temp_output_12_0_g1526 = ( temp_output_7_0_g1526 + dotResult8_g1526 );
					float2 temp_output_597_27_g1522 = ( UV100_g1523 + frac( ( ( (temp_output_12_0_g1526).xx + (temp_output_12_0_g1526).yz ) * (temp_output_12_0_g1526).zy ) ) );
					float temp_output_67_0_g1523 = ( 1.0 - break55_g1523.x );
					float ifLocalVar61_g1523 = 0;
					if( temp_output_56_0_g1523 <= 0.0 )
					ifLocalVar61_g1523 = temp_output_67_0_g1523;
					else
					ifLocalVar61_g1523 = break55_g1523.x;
					float temp_output_597_29_g1522 = ifLocalVar61_g1523;
					float4 Output_2D293_g1522 = ( ( tex2D( _EmissionMap, temp_output_597_0_g1522, DDX631_g1522, DDY632_g1522 ) * temp_output_597_30_g1522 ) + ( tex2D( _EmissionMap, temp_output_597_26_g1522, DDX631_g1522, DDY632_g1522 ) * temp_output_597_28_g1522 ) + ( tex2D( _EmissionMap, temp_output_597_27_g1522, DDX631_g1522, DDY632_g1522 ) * temp_output_597_29_g1522 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g1505 = Output_2D293_g1522;
					#else
					float4 staticSwitch1006_g1505 = tex2D( _EmissionMap, uv_EmissionMap81_g1505 );
					#endif
					#ifdef _EMISSIONENABLED_ON
					float4 staticSwitch1017_g1505 = ( _EmissionColor + staticSwitch1006_g1505 );
					#else
					float4 staticSwitch1017_g1505 = temp_cast_3;
					#endif
					float4 Emission86_g1505 = staticSwitch1017_g1505;
					float4 temp_output_690_0_g1505 = ( Emission86_g1505 + temp_output_614_0_g1505 );
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1019_g1505 = ( temp_output_614_0_g1505 * Emission86_g1505 );
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1019_g1505 = temp_output_690_0_g1505;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1019_g1505 = temp_output_690_0_g1505;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1019_g1505 = temp_output_690_0_g1505;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1019_g1505 = temp_output_690_0_g1505;
					#else
					float4 staticSwitch1019_g1505 = ( temp_output_614_0_g1505 * Emission86_g1505 );
					#endif
					

					o.Albedo = Albedo6_g1505.rgb;
					o.Normal = Normal_Map700_g1505;

					half3 Specular = half3( 0, 0, 0 );
					half Metallic = Metallic699_g1505;
					half Smoothness = staticSwitch824_g1505;
					half Occlusion = staticSwitch1016_g1505;

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

					o.Emission = staticSwitch1019_g1505.rgb;
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

					float2 uv_MainTex907_g1505 = IN.ase_texcoord5.xy;
					float2 uv_MainTex = IN.ase_texcoord5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					float2 temp_output_5_0_g1542 = uv_MainTex;
					float2 UV633_g1542 = temp_output_5_0_g1542;
					float2 UV100_g1543 = UV633_g1542;
					float2 temp_output_51_0_g1543 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g1543 * float2( 3.464,3.464 ) ) );
					float2 break55_g1543 = frac( temp_output_51_0_g1543 );
					float temp_output_56_0_g1543 = ( ( 1.0 - break55_g1543.x ) - break55_g1543.y );
					float2 temp_output_52_0_g1543 = floor( temp_output_51_0_g1543 );
					float2 temp_output_125_0_g1543 = ( temp_output_52_0_g1543 + float2( 1,1 ) );
					float2 ifLocalVar87_g1543 = 0;
					if( temp_output_56_0_g1543 > 0.0 )
					ifLocalVar87_g1543 = temp_output_52_0_g1543;
					else if( temp_output_56_0_g1543 == 0.0 )
					ifLocalVar87_g1543 = temp_output_125_0_g1543;
					else if( temp_output_56_0_g1543 < 0.0 )
					ifLocalVar87_g1543 = temp_output_125_0_g1543;
					float3 temp_output_7_0_g1544 = frac( ( (ifLocalVar87_g1543).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1544 = dot( temp_output_7_0_g1544 , ( (temp_output_7_0_g1544).yzx + 33.33 ) );
					float3 temp_output_12_0_g1544 = ( temp_output_7_0_g1544 + dotResult8_g1544 );
					float2 temp_output_597_0_g1542 = ( UV100_g1543 + frac( ( ( (temp_output_12_0_g1544).xx + (temp_output_12_0_g1544).yz ) * (temp_output_12_0_g1544).zy ) ) );
					float2 DDX631_g1542 = ddx( temp_output_5_0_g1542 );
					float2 DDY632_g1542 = ddy( temp_output_5_0_g1542 );
					float temp_output_65_0_g1543 = ( 0.0 - temp_output_56_0_g1543 );
					float ifLocalVar59_g1543 = 0;
					if( temp_output_56_0_g1543 <= 0.0 )
					ifLocalVar59_g1543 = temp_output_65_0_g1543;
					else
					ifLocalVar59_g1543 = temp_output_56_0_g1543;
					float temp_output_597_30_g1542 = ifLocalVar59_g1543;
					float2 temp_output_90_0_g1543 = ( temp_output_52_0_g1543 + float2( 0,1 ) );
					float2 temp_output_123_0_g1543 = ( temp_output_52_0_g1543 + float2( 1,0 ) );
					float2 ifLocalVar88_g1543 = 0;
					if( temp_output_56_0_g1543 > 0.0 )
					ifLocalVar88_g1543 = temp_output_90_0_g1543;
					else if( temp_output_56_0_g1543 == 0.0 )
					ifLocalVar88_g1543 = temp_output_123_0_g1543;
					else if( temp_output_56_0_g1543 < 0.0 )
					ifLocalVar88_g1543 = temp_output_123_0_g1543;
					float3 temp_output_7_0_g1545 = frac( ( (ifLocalVar88_g1543).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1545 = dot( temp_output_7_0_g1545 , ( (temp_output_7_0_g1545).yzx + 33.33 ) );
					float3 temp_output_12_0_g1545 = ( temp_output_7_0_g1545 + dotResult8_g1545 );
					float2 temp_output_597_26_g1542 = ( UV100_g1543 + frac( ( ( (temp_output_12_0_g1545).xx + (temp_output_12_0_g1545).yz ) * (temp_output_12_0_g1545).zy ) ) );
					float temp_output_66_0_g1543 = ( 1.0 - break55_g1543.y );
					float ifLocalVar60_g1543 = 0;
					if( temp_output_56_0_g1543 <= 0.0 )
					ifLocalVar60_g1543 = temp_output_66_0_g1543;
					else
					ifLocalVar60_g1543 = break55_g1543.y;
					float temp_output_597_28_g1542 = ifLocalVar60_g1543;
					float2 ifLocalVar89_g1543 = 0;
					if( temp_output_56_0_g1543 > 0.0 )
					ifLocalVar89_g1543 = temp_output_123_0_g1543;
					else if( temp_output_56_0_g1543 == 0.0 )
					ifLocalVar89_g1543 = temp_output_90_0_g1543;
					else if( temp_output_56_0_g1543 < 0.0 )
					ifLocalVar89_g1543 = temp_output_90_0_g1543;
					float3 temp_output_7_0_g1546 = frac( ( (ifLocalVar89_g1543).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1546 = dot( temp_output_7_0_g1546 , ( (temp_output_7_0_g1546).yzx + 33.33 ) );
					float3 temp_output_12_0_g1546 = ( temp_output_7_0_g1546 + dotResult8_g1546 );
					float2 temp_output_597_27_g1542 = ( UV100_g1543 + frac( ( ( (temp_output_12_0_g1546).xx + (temp_output_12_0_g1546).yz ) * (temp_output_12_0_g1546).zy ) ) );
					float temp_output_67_0_g1543 = ( 1.0 - break55_g1543.x );
					float ifLocalVar61_g1543 = 0;
					if( temp_output_56_0_g1543 <= 0.0 )
					ifLocalVar61_g1543 = temp_output_67_0_g1543;
					else
					ifLocalVar61_g1543 = break55_g1543.x;
					float temp_output_597_29_g1542 = ifLocalVar61_g1543;
					float4 Output_2D293_g1542 = ( ( tex2D( _MainTex, temp_output_597_0_g1542, DDX631_g1542, DDY632_g1542 ) * temp_output_597_30_g1542 ) + ( tex2D( _MainTex, temp_output_597_26_g1542, DDX631_g1542, DDY632_g1542 ) * temp_output_597_28_g1542 ) + ( tex2D( _MainTex, temp_output_597_27_g1542, DDX631_g1542, DDY632_g1542 ) * temp_output_597_29_g1542 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g1505 = Output_2D293_g1542;
					#else
					float4 staticSwitch1001_g1505 = tex2D( _MainTex, uv_MainTex907_g1505 );
					#endif
					float4 temp_output_976_0_g1505 = ( _Color * staticSwitch1001_g1505 );
					float4 Albedo6_g1505 = temp_output_976_0_g1505;
					
					float2 uv_BumpMap830_g1505 = IN.ase_texcoord5.xy;
					float2 uv_BumpMap = IN.ase_texcoord5.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					float2 temp_output_5_0_g1537 = uv_BumpMap;
					float2 UV633_g1537 = temp_output_5_0_g1537;
					float2 UV100_g1538 = UV633_g1537;
					float2 temp_output_51_0_g1538 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g1538 * float2( 3.464,3.464 ) ) );
					float2 break55_g1538 = frac( temp_output_51_0_g1538 );
					float temp_output_56_0_g1538 = ( ( 1.0 - break55_g1538.x ) - break55_g1538.y );
					float2 temp_output_52_0_g1538 = floor( temp_output_51_0_g1538 );
					float2 temp_output_125_0_g1538 = ( temp_output_52_0_g1538 + float2( 1,1 ) );
					float2 ifLocalVar87_g1538 = 0;
					if( temp_output_56_0_g1538 > 0.0 )
					ifLocalVar87_g1538 = temp_output_52_0_g1538;
					else if( temp_output_56_0_g1538 == 0.0 )
					ifLocalVar87_g1538 = temp_output_125_0_g1538;
					else if( temp_output_56_0_g1538 < 0.0 )
					ifLocalVar87_g1538 = temp_output_125_0_g1538;
					float3 temp_output_7_0_g1539 = frac( ( (ifLocalVar87_g1538).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1539 = dot( temp_output_7_0_g1539 , ( (temp_output_7_0_g1539).yzx + 33.33 ) );
					float3 temp_output_12_0_g1539 = ( temp_output_7_0_g1539 + dotResult8_g1539 );
					float2 temp_output_597_0_g1537 = ( UV100_g1538 + frac( ( ( (temp_output_12_0_g1539).xx + (temp_output_12_0_g1539).yz ) * (temp_output_12_0_g1539).zy ) ) );
					float2 DDX631_g1537 = ddx( temp_output_5_0_g1537 );
					float2 DDY632_g1537 = ddy( temp_output_5_0_g1537 );
					float Input_Scale617_g1537 = _NormalScale;
					float temp_output_65_0_g1538 = ( 0.0 - temp_output_56_0_g1538 );
					float ifLocalVar59_g1538 = 0;
					if( temp_output_56_0_g1538 <= 0.0 )
					ifLocalVar59_g1538 = temp_output_65_0_g1538;
					else
					ifLocalVar59_g1538 = temp_output_56_0_g1538;
					float temp_output_597_30_g1537 = ifLocalVar59_g1538;
					float2 temp_output_90_0_g1538 = ( temp_output_52_0_g1538 + float2( 0,1 ) );
					float2 temp_output_123_0_g1538 = ( temp_output_52_0_g1538 + float2( 1,0 ) );
					float2 ifLocalVar88_g1538 = 0;
					if( temp_output_56_0_g1538 > 0.0 )
					ifLocalVar88_g1538 = temp_output_90_0_g1538;
					else if( temp_output_56_0_g1538 == 0.0 )
					ifLocalVar88_g1538 = temp_output_123_0_g1538;
					else if( temp_output_56_0_g1538 < 0.0 )
					ifLocalVar88_g1538 = temp_output_123_0_g1538;
					float3 temp_output_7_0_g1540 = frac( ( (ifLocalVar88_g1538).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1540 = dot( temp_output_7_0_g1540 , ( (temp_output_7_0_g1540).yzx + 33.33 ) );
					float3 temp_output_12_0_g1540 = ( temp_output_7_0_g1540 + dotResult8_g1540 );
					float2 temp_output_597_26_g1537 = ( UV100_g1538 + frac( ( ( (temp_output_12_0_g1540).xx + (temp_output_12_0_g1540).yz ) * (temp_output_12_0_g1540).zy ) ) );
					float temp_output_66_0_g1538 = ( 1.0 - break55_g1538.y );
					float ifLocalVar60_g1538 = 0;
					if( temp_output_56_0_g1538 <= 0.0 )
					ifLocalVar60_g1538 = temp_output_66_0_g1538;
					else
					ifLocalVar60_g1538 = break55_g1538.y;
					float temp_output_597_28_g1537 = ifLocalVar60_g1538;
					float2 ifLocalVar89_g1538 = 0;
					if( temp_output_56_0_g1538 > 0.0 )
					ifLocalVar89_g1538 = temp_output_123_0_g1538;
					else if( temp_output_56_0_g1538 == 0.0 )
					ifLocalVar89_g1538 = temp_output_90_0_g1538;
					else if( temp_output_56_0_g1538 < 0.0 )
					ifLocalVar89_g1538 = temp_output_90_0_g1538;
					float3 temp_output_7_0_g1541 = frac( ( (ifLocalVar89_g1538).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1541 = dot( temp_output_7_0_g1541 , ( (temp_output_7_0_g1541).yzx + 33.33 ) );
					float3 temp_output_12_0_g1541 = ( temp_output_7_0_g1541 + dotResult8_g1541 );
					float2 temp_output_597_27_g1537 = ( UV100_g1538 + frac( ( ( (temp_output_12_0_g1541).xx + (temp_output_12_0_g1541).yz ) * (temp_output_12_0_g1541).zy ) ) );
					float temp_output_67_0_g1538 = ( 1.0 - break55_g1538.x );
					float ifLocalVar61_g1538 = 0;
					if( temp_output_56_0_g1538 <= 0.0 )
					ifLocalVar61_g1538 = temp_output_67_0_g1538;
					else
					ifLocalVar61_g1538 = break55_g1538.x;
					float temp_output_597_29_g1537 = ifLocalVar61_g1538;
					float3 Output_2D_Normal641_g1537 = ( ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_0_g1537, DDX631_g1537, DDY632_g1537 ), Input_Scale617_g1537 ) * temp_output_597_30_g1537 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_26_g1537, DDX631_g1537, DDY632_g1537 ), Input_Scale617_g1537 ) * temp_output_597_28_g1537 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_27_g1537, DDX631_g1537, DDY632_g1537 ), Input_Scale617_g1537 ) * float3( 0,0,0 ) * temp_output_597_29_g1537 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g1505 = Output_2D_Normal641_g1537;
					#else
					float3 staticSwitch1003_g1505 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap830_g1505 ), _NormalScale );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g1505 = staticSwitch1003_g1505;
					#else
					float3 staticSwitch980_g1505 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g1505 = staticSwitch980_g1505;
					
					float2 uv_MetallicMap48_g1505 = IN.ase_texcoord5.xy;
					float2 uv_MetallicMap = IN.ase_texcoord5.xy * _MetallicMap_ST.xy + _MetallicMap_ST.zw;
					float2 temp_output_5_0_g1527 = uv_MetallicMap;
					float2 UV633_g1527 = temp_output_5_0_g1527;
					float2 UV100_g1528 = UV633_g1527;
					float2 temp_output_51_0_g1528 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g1528 * float2( 3.464,3.464 ) ) );
					float2 break55_g1528 = frac( temp_output_51_0_g1528 );
					float temp_output_56_0_g1528 = ( ( 1.0 - break55_g1528.x ) - break55_g1528.y );
					float2 temp_output_52_0_g1528 = floor( temp_output_51_0_g1528 );
					float2 temp_output_125_0_g1528 = ( temp_output_52_0_g1528 + float2( 1,1 ) );
					float2 ifLocalVar87_g1528 = 0;
					if( temp_output_56_0_g1528 > 0.0 )
					ifLocalVar87_g1528 = temp_output_52_0_g1528;
					else if( temp_output_56_0_g1528 == 0.0 )
					ifLocalVar87_g1528 = temp_output_125_0_g1528;
					else if( temp_output_56_0_g1528 < 0.0 )
					ifLocalVar87_g1528 = temp_output_125_0_g1528;
					float3 temp_output_7_0_g1529 = frac( ( (ifLocalVar87_g1528).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1529 = dot( temp_output_7_0_g1529 , ( (temp_output_7_0_g1529).yzx + 33.33 ) );
					float3 temp_output_12_0_g1529 = ( temp_output_7_0_g1529 + dotResult8_g1529 );
					float2 temp_output_597_0_g1527 = ( UV100_g1528 + frac( ( ( (temp_output_12_0_g1529).xx + (temp_output_12_0_g1529).yz ) * (temp_output_12_0_g1529).zy ) ) );
					float2 DDX631_g1527 = ddx( temp_output_5_0_g1527 );
					float2 DDY632_g1527 = ddy( temp_output_5_0_g1527 );
					float temp_output_65_0_g1528 = ( 0.0 - temp_output_56_0_g1528 );
					float ifLocalVar59_g1528 = 0;
					if( temp_output_56_0_g1528 <= 0.0 )
					ifLocalVar59_g1528 = temp_output_65_0_g1528;
					else
					ifLocalVar59_g1528 = temp_output_56_0_g1528;
					float temp_output_597_30_g1527 = ifLocalVar59_g1528;
					float2 temp_output_90_0_g1528 = ( temp_output_52_0_g1528 + float2( 0,1 ) );
					float2 temp_output_123_0_g1528 = ( temp_output_52_0_g1528 + float2( 1,0 ) );
					float2 ifLocalVar88_g1528 = 0;
					if( temp_output_56_0_g1528 > 0.0 )
					ifLocalVar88_g1528 = temp_output_90_0_g1528;
					else if( temp_output_56_0_g1528 == 0.0 )
					ifLocalVar88_g1528 = temp_output_123_0_g1528;
					else if( temp_output_56_0_g1528 < 0.0 )
					ifLocalVar88_g1528 = temp_output_123_0_g1528;
					float3 temp_output_7_0_g1530 = frac( ( (ifLocalVar88_g1528).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1530 = dot( temp_output_7_0_g1530 , ( (temp_output_7_0_g1530).yzx + 33.33 ) );
					float3 temp_output_12_0_g1530 = ( temp_output_7_0_g1530 + dotResult8_g1530 );
					float2 temp_output_597_26_g1527 = ( UV100_g1528 + frac( ( ( (temp_output_12_0_g1530).xx + (temp_output_12_0_g1530).yz ) * (temp_output_12_0_g1530).zy ) ) );
					float temp_output_66_0_g1528 = ( 1.0 - break55_g1528.y );
					float ifLocalVar60_g1528 = 0;
					if( temp_output_56_0_g1528 <= 0.0 )
					ifLocalVar60_g1528 = temp_output_66_0_g1528;
					else
					ifLocalVar60_g1528 = break55_g1528.y;
					float temp_output_597_28_g1527 = ifLocalVar60_g1528;
					float2 ifLocalVar89_g1528 = 0;
					if( temp_output_56_0_g1528 > 0.0 )
					ifLocalVar89_g1528 = temp_output_123_0_g1528;
					else if( temp_output_56_0_g1528 == 0.0 )
					ifLocalVar89_g1528 = temp_output_90_0_g1528;
					else if( temp_output_56_0_g1528 < 0.0 )
					ifLocalVar89_g1528 = temp_output_90_0_g1528;
					float3 temp_output_7_0_g1531 = frac( ( (ifLocalVar89_g1528).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1531 = dot( temp_output_7_0_g1531 , ( (temp_output_7_0_g1531).yzx + 33.33 ) );
					float3 temp_output_12_0_g1531 = ( temp_output_7_0_g1531 + dotResult8_g1531 );
					float2 temp_output_597_27_g1527 = ( UV100_g1528 + frac( ( ( (temp_output_12_0_g1531).xx + (temp_output_12_0_g1531).yz ) * (temp_output_12_0_g1531).zy ) ) );
					float temp_output_67_0_g1528 = ( 1.0 - break55_g1528.x );
					float ifLocalVar61_g1528 = 0;
					if( temp_output_56_0_g1528 <= 0.0 )
					ifLocalVar61_g1528 = temp_output_67_0_g1528;
					else
					ifLocalVar61_g1528 = break55_g1528.x;
					float temp_output_597_29_g1527 = ifLocalVar61_g1528;
					float4 Output_2D293_g1527 = ( ( tex2D( _MetallicMap, temp_output_597_0_g1527, DDX631_g1527, DDY632_g1527 ) * temp_output_597_30_g1527 ) + ( tex2D( _MetallicMap, temp_output_597_26_g1527, DDX631_g1527, DDY632_g1527 ) * temp_output_597_28_g1527 ) + ( tex2D( _MetallicMap, temp_output_597_27_g1527, DDX631_g1527, DDY632_g1527 ) * temp_output_597_29_g1527 ) );
					float4 break31_g1527 = Output_2D293_g1527;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g1505 = break31_g1527.a;
					#else
					float staticSwitch1005_g1505 = tex2D( _MetallicMap, uv_MetallicMap48_g1505 ).a;
					#endif
					float saferPower803_g1505 = abs( staticSwitch1005_g1505 );
					#ifdef _METALLICMAP
					float staticSwitch846_g1505 = pow( saferPower803_g1505 , 3.0 );
					#else
					float staticSwitch846_g1505 = _Metallic;
					#endif
					float Metallic699_g1505 = staticSwitch846_g1505;
					
					float2 uv_GlossinessMap64_g1505 = IN.ase_texcoord5.xy;
					float2 uv_GlossinessMap = IN.ase_texcoord5.xy * _GlossinessMap_ST.xy + _GlossinessMap_ST.zw;
					float2 temp_output_5_0_g1532 = uv_GlossinessMap;
					float2 UV633_g1532 = temp_output_5_0_g1532;
					float2 UV100_g1533 = UV633_g1532;
					float2 temp_output_51_0_g1533 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g1533 * float2( 3.464,3.464 ) ) );
					float2 break55_g1533 = frac( temp_output_51_0_g1533 );
					float temp_output_56_0_g1533 = ( ( 1.0 - break55_g1533.x ) - break55_g1533.y );
					float2 temp_output_52_0_g1533 = floor( temp_output_51_0_g1533 );
					float2 temp_output_125_0_g1533 = ( temp_output_52_0_g1533 + float2( 1,1 ) );
					float2 ifLocalVar87_g1533 = 0;
					if( temp_output_56_0_g1533 > 0.0 )
					ifLocalVar87_g1533 = temp_output_52_0_g1533;
					else if( temp_output_56_0_g1533 == 0.0 )
					ifLocalVar87_g1533 = temp_output_125_0_g1533;
					else if( temp_output_56_0_g1533 < 0.0 )
					ifLocalVar87_g1533 = temp_output_125_0_g1533;
					float3 temp_output_7_0_g1534 = frac( ( (ifLocalVar87_g1533).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1534 = dot( temp_output_7_0_g1534 , ( (temp_output_7_0_g1534).yzx + 33.33 ) );
					float3 temp_output_12_0_g1534 = ( temp_output_7_0_g1534 + dotResult8_g1534 );
					float2 temp_output_597_0_g1532 = ( UV100_g1533 + frac( ( ( (temp_output_12_0_g1534).xx + (temp_output_12_0_g1534).yz ) * (temp_output_12_0_g1534).zy ) ) );
					float2 DDX631_g1532 = ddx( temp_output_5_0_g1532 );
					float2 DDY632_g1532 = ddy( temp_output_5_0_g1532 );
					float temp_output_65_0_g1533 = ( 0.0 - temp_output_56_0_g1533 );
					float ifLocalVar59_g1533 = 0;
					if( temp_output_56_0_g1533 <= 0.0 )
					ifLocalVar59_g1533 = temp_output_65_0_g1533;
					else
					ifLocalVar59_g1533 = temp_output_56_0_g1533;
					float temp_output_597_30_g1532 = ifLocalVar59_g1533;
					float2 temp_output_90_0_g1533 = ( temp_output_52_0_g1533 + float2( 0,1 ) );
					float2 temp_output_123_0_g1533 = ( temp_output_52_0_g1533 + float2( 1,0 ) );
					float2 ifLocalVar88_g1533 = 0;
					if( temp_output_56_0_g1533 > 0.0 )
					ifLocalVar88_g1533 = temp_output_90_0_g1533;
					else if( temp_output_56_0_g1533 == 0.0 )
					ifLocalVar88_g1533 = temp_output_123_0_g1533;
					else if( temp_output_56_0_g1533 < 0.0 )
					ifLocalVar88_g1533 = temp_output_123_0_g1533;
					float3 temp_output_7_0_g1535 = frac( ( (ifLocalVar88_g1533).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1535 = dot( temp_output_7_0_g1535 , ( (temp_output_7_0_g1535).yzx + 33.33 ) );
					float3 temp_output_12_0_g1535 = ( temp_output_7_0_g1535 + dotResult8_g1535 );
					float2 temp_output_597_26_g1532 = ( UV100_g1533 + frac( ( ( (temp_output_12_0_g1535).xx + (temp_output_12_0_g1535).yz ) * (temp_output_12_0_g1535).zy ) ) );
					float temp_output_66_0_g1533 = ( 1.0 - break55_g1533.y );
					float ifLocalVar60_g1533 = 0;
					if( temp_output_56_0_g1533 <= 0.0 )
					ifLocalVar60_g1533 = temp_output_66_0_g1533;
					else
					ifLocalVar60_g1533 = break55_g1533.y;
					float temp_output_597_28_g1532 = ifLocalVar60_g1533;
					float2 ifLocalVar89_g1533 = 0;
					if( temp_output_56_0_g1533 > 0.0 )
					ifLocalVar89_g1533 = temp_output_123_0_g1533;
					else if( temp_output_56_0_g1533 == 0.0 )
					ifLocalVar89_g1533 = temp_output_90_0_g1533;
					else if( temp_output_56_0_g1533 < 0.0 )
					ifLocalVar89_g1533 = temp_output_90_0_g1533;
					float3 temp_output_7_0_g1536 = frac( ( (ifLocalVar89_g1533).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1536 = dot( temp_output_7_0_g1536 , ( (temp_output_7_0_g1536).yzx + 33.33 ) );
					float3 temp_output_12_0_g1536 = ( temp_output_7_0_g1536 + dotResult8_g1536 );
					float2 temp_output_597_27_g1532 = ( UV100_g1533 + frac( ( ( (temp_output_12_0_g1536).xx + (temp_output_12_0_g1536).yz ) * (temp_output_12_0_g1536).zy ) ) );
					float temp_output_67_0_g1533 = ( 1.0 - break55_g1533.x );
					float ifLocalVar61_g1533 = 0;
					if( temp_output_56_0_g1533 <= 0.0 )
					ifLocalVar61_g1533 = temp_output_67_0_g1533;
					else
					ifLocalVar61_g1533 = break55_g1533.x;
					float temp_output_597_29_g1532 = ifLocalVar61_g1533;
					float4 Output_2D293_g1532 = ( ( tex2D( _GlossinessMap, temp_output_597_0_g1532, DDX631_g1532, DDY632_g1532 ) * temp_output_597_30_g1532 ) + ( tex2D( _GlossinessMap, temp_output_597_26_g1532, DDX631_g1532, DDY632_g1532 ) * temp_output_597_28_g1532 ) + ( tex2D( _GlossinessMap, temp_output_597_27_g1532, DDX631_g1532, DDY632_g1532 ) * temp_output_597_29_g1532 ) );
					float4 break31_g1532 = Output_2D293_g1532;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g1505 = break31_g1532.a;
					#else
					float staticSwitch1004_g1505 = tex2D( _GlossinessMap, uv_GlossinessMap64_g1505 ).a;
					#endif
					float saferPower804_g1505 = abs( staticSwitch1004_g1505 );
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g1505 = ( 1.0 - pow( saferPower804_g1505 , 3.0 ) );
					#else
					float staticSwitch845_g1505 = _Glossiness;
					#endif
					float3 temp_output_3_0_g1547 = ddx( NormalWS );
					float dotResult5_g1547 = dot( temp_output_3_0_g1547 , temp_output_3_0_g1547 );
					float3 temp_output_4_0_g1547 = ddy( NormalWS );
					float dotResult6_g1547 = dot( temp_output_4_0_g1547 , temp_output_4_0_g1547 );
					#ifdef _USEGEOMETRICANTIALIASING_ON
					float staticSwitch824_g1505 = min( staticSwitch845_g1505 , ( 1.0 - pow( saturate( max( dotResult5_g1547 , dotResult6_g1547 ) ) , 0.333 ) ) );
					#else
					float staticSwitch824_g1505 = staticSwitch845_g1505;
					#endif
					
					float White38_g1505 = 1.0;
					float4 temp_cast_1 = (White38_g1505).xxxx;
					float localBicubicPrepare2_g1507 = ( 0.0 );
					float2 uv3_Lightmap0 = IN.ase_texcoord5.zw * _Lightmap0_ST.xy + _Lightmap0_ST.zw;
					float2 Input_UV100_g1507 = uv3_Lightmap0;
					float2 UV2_g1507 = Input_UV100_g1507;
					float4 TexelSize2_g1507 = _Lightmap0_TexelSize;
					float2 UV02_g1507 = float2( 0,0 );
					float2 UV12_g1507 = float2( 0,0 );
					float2 UV22_g1507 = float2( 0,0 );
					float2 UV32_g1507 = float2( 0,0 );
					float W02_g1507 = 0;
					float W12_g1507 = 0;
					{
					{
					 UV2_g1507 = UV2_g1507 * TexelSize2_g1507.zw - 0.5;
					    float2 f = frac( UV2_g1507 );
					    UV2_g1507 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g1507.x - 0.5, UV2_g1507.x + 1.5, UV2_g1507.y - 0.5, UV2_g1507.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1507.xyxy;
					    UV02_g1507 = off.xz;
					    UV12_g1507 = off.yz;
					    UV22_g1507 = off.xw;
					    UV32_g1507 = off.yw;
					    W02_g1507 = s.x / ( s.x + s.y );
					 W12_g1507 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g1507 = lerp( tex2D( _Lightmap0, UV32_g1507 ) , tex2D( _Lightmap0, UV22_g1507 ) , W02_g1507);
					float4 lerpResult45_g1507 = lerp( tex2D( _Lightmap0, UV12_g1507 ) , tex2D( _Lightmap0, UV02_g1507 ) , W02_g1507);
					float4 lerpResult44_g1507 = lerp( lerpResult46_g1507 , lerpResult45_g1507 , W12_g1507);
					float4 Output_2D131_g1507 = lerpResult44_g1507;
					float4 Lightmap_0925_g1505 = Output_2D131_g1507;
					float localBicubicPrepare2_g1509 = ( 0.0 );
					float2 uv3_Lightmap1 = IN.ase_texcoord5.zw * _Lightmap1_ST.xy + _Lightmap1_ST.zw;
					float2 Input_UV100_g1509 = uv3_Lightmap1;
					float2 UV2_g1509 = Input_UV100_g1509;
					float4 TexelSize2_g1509 = _Lightmap1_TexelSize;
					float2 UV02_g1509 = float2( 0,0 );
					float2 UV12_g1509 = float2( 0,0 );
					float2 UV22_g1509 = float2( 0,0 );
					float2 UV32_g1509 = float2( 0,0 );
					float W02_g1509 = 0;
					float W12_g1509 = 0;
					{
					{
					 UV2_g1509 = UV2_g1509 * TexelSize2_g1509.zw - 0.5;
					    float2 f = frac( UV2_g1509 );
					    UV2_g1509 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g1509.x - 0.5, UV2_g1509.x + 1.5, UV2_g1509.y - 0.5, UV2_g1509.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1509.xyxy;
					    UV02_g1509 = off.xz;
					    UV12_g1509 = off.yz;
					    UV22_g1509 = off.xw;
					    UV32_g1509 = off.yw;
					    W02_g1509 = s.x / ( s.x + s.y );
					 W12_g1509 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g1509 = lerp( tex2D( _Lightmap1, UV32_g1509 ) , tex2D( _Lightmap1, UV22_g1509 ) , W02_g1509);
					float4 lerpResult45_g1509 = lerp( tex2D( _Lightmap1, UV12_g1509 ) , tex2D( _Lightmap1, UV02_g1509 ) , W02_g1509);
					float4 lerpResult44_g1509 = lerp( lerpResult46_g1509 , lerpResult45_g1509 , W12_g1509);
					float4 Output_2D131_g1509 = lerpResult44_g1509;
					float4 Lightmap_1956_g1505 = Output_2D131_g1509;
					float4 lerpResult442_g1505 = lerp( Lightmap_0925_g1505 , Lightmap_1956_g1505 , _LightmapLerp);
					float4 Lightmap_Lerp932_g1505 = lerpResult442_g1505;
					float3 appendResult139_g1520 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g1520 = normalize( Normal_Map700_g1505 );
					float3 Normal_Map318_g1520 = normalizeResult326_g1520;
					float dotResult121_g1520 = dot( appendResult139_g1520 , Normal_Map318_g1520 );
					float localStochasticTiling2_g1516 = ( 0.0 );
					float2 uv3_RNMX0 = IN.ase_texcoord5.zw * _RNMX0_ST.xy + _RNMX0_ST.zw;
					float2 UV2_g1516 = uv3_RNMX0;
					float4 TexelSize2_g1516 = _RNMX0_TexelSize;
					float4 Offsets2_g1516 = float4( 0,0,0,0 );
					float2 Weights2_g1516 = float2( 0,0 );
					{
					UV2_g1516 = UV2_g1516 * TexelSize2_g1516.zw - 0.5;
					float2 f = frac( UV2_g1516 );
					UV2_g1516 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g1516.x - 0.5, UV2_g1516.x + 1.5, UV2_g1516.y - 0.5, UV2_g1516.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g1516 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1516.xyxy;
					Weights2_g1516 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g1515 = Offsets2_g1516;
					float4 Input_FetchOffsets197_g1519 = temp_output_1_34_g1515;
					float2 temp_output_1_54_g1515 = Weights2_g1516;
					float2 Input_FetchWeights200_g1519 = temp_output_1_54_g1515;
					float2 break187_g1519 = Input_FetchWeights200_g1519;
					float4 lerpResult181_g1519 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g1519).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g1519).xw ) , break187_g1519.x);
					float4 lerpResult182_g1519 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g1519).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g1519).xz ) , break187_g1519.x);
					float4 lerpResult176_g1519 = lerp( lerpResult181_g1519 , lerpResult182_g1519 , break187_g1519.y);
					float4 Output_Fetch2D202_g1519 = lerpResult176_g1519;
					float3 appendResult146_g1520 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g1520 = dot( appendResult146_g1520 , Normal_Map318_g1520 );
					float4 Input_FetchOffsets197_g1517 = temp_output_1_34_g1515;
					float2 Input_FetchWeights200_g1517 = temp_output_1_54_g1515;
					float2 break187_g1517 = Input_FetchWeights200_g1517;
					float4 lerpResult181_g1517 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g1517).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g1517).xw ) , break187_g1517.x);
					float4 lerpResult182_g1517 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g1517).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g1517).xz ) , break187_g1517.x);
					float4 lerpResult176_g1517 = lerp( lerpResult181_g1517 , lerpResult182_g1517 , break187_g1517.y);
					float4 Output_Fetch2D202_g1517 = lerpResult176_g1517;
					float3 appendResult149_g1520 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g1520 = dot( appendResult149_g1520 , Normal_Map318_g1520 );
					float4 Input_FetchOffsets197_g1518 = temp_output_1_34_g1515;
					float2 Input_FetchWeights200_g1518 = temp_output_1_54_g1515;
					float2 break187_g1518 = Input_FetchWeights200_g1518;
					float4 lerpResult181_g1518 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g1518).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g1518).xw ) , break187_g1518.x);
					float4 lerpResult182_g1518 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g1518).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g1518).xz ) , break187_g1518.x);
					float4 lerpResult176_g1518 = lerp( lerpResult181_g1518 , lerpResult182_g1518 , break187_g1518.y);
					float4 Output_Fetch2D202_g1518 = lerpResult176_g1518;
					float4 RNM_0926_g1505 = ( ( ( saturate( dotResult121_g1520 ) * ( Output_Fetch2D202_g1519 * 0.8 ) ) + ( saturate( dotResult122_g1520 ) * ( Output_Fetch2D202_g1517 * 0.8 ) ) ) + ( saturate( dotResult120_g1520 ) * ( Output_Fetch2D202_g1518 * 0.8 ) ) );
					float3 appendResult139_g1521 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g1521 = normalize( Normal_Map700_g1505 );
					float3 Normal_Map318_g1521 = normalizeResult326_g1521;
					float dotResult121_g1521 = dot( appendResult139_g1521 , Normal_Map318_g1521 );
					float localStochasticTiling2_g1511 = ( 0.0 );
					float2 uv3_RNMX1 = IN.ase_texcoord5.zw * _RNMX1_ST.xy + _RNMX1_ST.zw;
					float2 UV2_g1511 = uv3_RNMX1;
					float4 TexelSize2_g1511 = _RNMX1_TexelSize;
					float4 Offsets2_g1511 = float4( 0,0,0,0 );
					float2 Weights2_g1511 = float2( 0,0 );
					{
					UV2_g1511 = UV2_g1511 * TexelSize2_g1511.zw - 0.5;
					float2 f = frac( UV2_g1511 );
					UV2_g1511 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g1511.x - 0.5, UV2_g1511.x + 1.5, UV2_g1511.y - 0.5, UV2_g1511.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g1511 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1511.xyxy;
					Weights2_g1511 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g1510 = Offsets2_g1511;
					float4 Input_FetchOffsets197_g1514 = temp_output_1_34_g1510;
					float2 temp_output_1_54_g1510 = Weights2_g1511;
					float2 Input_FetchWeights200_g1514 = temp_output_1_54_g1510;
					float2 break187_g1514 = Input_FetchWeights200_g1514;
					float4 lerpResult181_g1514 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g1514).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g1514).xw ) , break187_g1514.x);
					float4 lerpResult182_g1514 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g1514).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g1514).xz ) , break187_g1514.x);
					float4 lerpResult176_g1514 = lerp( lerpResult181_g1514 , lerpResult182_g1514 , break187_g1514.y);
					float4 Output_Fetch2D202_g1514 = lerpResult176_g1514;
					float3 appendResult146_g1521 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g1521 = dot( appendResult146_g1521 , Normal_Map318_g1521 );
					float4 Input_FetchOffsets197_g1512 = temp_output_1_34_g1510;
					float2 Input_FetchWeights200_g1512 = temp_output_1_54_g1510;
					float2 break187_g1512 = Input_FetchWeights200_g1512;
					float4 lerpResult181_g1512 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g1512).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g1512).xw ) , break187_g1512.x);
					float4 lerpResult182_g1512 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g1512).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g1512).xz ) , break187_g1512.x);
					float4 lerpResult176_g1512 = lerp( lerpResult181_g1512 , lerpResult182_g1512 , break187_g1512.y);
					float4 Output_Fetch2D202_g1512 = lerpResult176_g1512;
					float3 appendResult149_g1521 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g1521 = dot( appendResult149_g1521 , Normal_Map318_g1521 );
					float4 Input_FetchOffsets197_g1513 = temp_output_1_34_g1510;
					float2 Input_FetchWeights200_g1513 = temp_output_1_54_g1510;
					float2 break187_g1513 = Input_FetchWeights200_g1513;
					float4 lerpResult181_g1513 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g1513).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g1513).xw ) , break187_g1513.x);
					float4 lerpResult182_g1513 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g1513).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g1513).xz ) , break187_g1513.x);
					float4 lerpResult176_g1513 = lerp( lerpResult181_g1513 , lerpResult182_g1513 , break187_g1513.y);
					float4 Output_Fetch2D202_g1513 = lerpResult176_g1513;
					float4 RNM_1927_g1505 = ( ( ( saturate( dotResult121_g1521 ) * ( Output_Fetch2D202_g1514 * 0.8 ) ) + ( saturate( dotResult122_g1521 ) * ( Output_Fetch2D202_g1512 * 0.8 ) ) ) + ( saturate( dotResult120_g1521 ) * ( Output_Fetch2D202_g1513 * 0.8 ) ) );
					float Lightmap_Lerp_Value969_g1505 = _LightmapLerp;
					float4 lerpResult953_g1505 = lerp( RNM_0926_g1505 , RNM_1927_g1505 , Lightmap_Lerp_Value969_g1505);
					float4 RNM_Lerp950_g1505 = lerpResult953_g1505;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g1505 = temp_cast_1;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g1505 = Lightmap_0925_g1505;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g1505 = Lightmap_Lerp932_g1505;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g1505 = RNM_0926_g1505;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g1505 = RNM_Lerp950_g1505;
					#else
					float4 staticSwitch1014_g1505 = temp_cast_1;
					#endif
					float4 Lightmap46_g1505 = staticSwitch1014_g1505;
					float dotResult835_g1505 = dot( Lightmap46_g1505 , float4( float3( 0.299, 0.587, 0.114 ) , 0.0 ) );
					float saferPower606_g1505 = abs( dotResult835_g1505 );
					#ifdef _LIGHTMAPOCCLUSIONENABLED_ON
					float staticSwitch1018_g1505 = pow( saferPower606_g1505 , _OcclusionPower );
					#else
					float staticSwitch1018_g1505 = White38_g1505;
					#endif
					#if defined( _LIGHTMAPMODE_DISABLED )
					float staticSwitch1016_g1505 = White38_g1505;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float staticSwitch1016_g1505 = staticSwitch1018_g1505;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float staticSwitch1016_g1505 = staticSwitch1018_g1505;
					#elif defined( _LIGHTMAPMODE_RNM )
					float staticSwitch1016_g1505 = staticSwitch1018_g1505;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float staticSwitch1016_g1505 = staticSwitch1018_g1505;
					#else
					float staticSwitch1016_g1505 = White38_g1505;
					#endif
					
					float4 temp_output_614_0_g1505 = ( Albedo6_g1505 * Lightmap46_g1505 );
					float4 temp_cast_3 = 0;
					float2 uv_EmissionMap81_g1505 = IN.ase_texcoord5.xy;
					float2 uv_EmissionMap = IN.ase_texcoord5.xy * _EmissionMap_ST.xy + _EmissionMap_ST.zw;
					float2 temp_output_5_0_g1522 = uv_EmissionMap;
					float2 UV633_g1522 = temp_output_5_0_g1522;
					float2 UV100_g1523 = UV633_g1522;
					float2 temp_output_51_0_g1523 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g1523 * float2( 3.464,3.464 ) ) );
					float2 break55_g1523 = frac( temp_output_51_0_g1523 );
					float temp_output_56_0_g1523 = ( ( 1.0 - break55_g1523.x ) - break55_g1523.y );
					float2 temp_output_52_0_g1523 = floor( temp_output_51_0_g1523 );
					float2 temp_output_125_0_g1523 = ( temp_output_52_0_g1523 + float2( 1,1 ) );
					float2 ifLocalVar87_g1523 = 0;
					if( temp_output_56_0_g1523 > 0.0 )
					ifLocalVar87_g1523 = temp_output_52_0_g1523;
					else if( temp_output_56_0_g1523 == 0.0 )
					ifLocalVar87_g1523 = temp_output_125_0_g1523;
					else if( temp_output_56_0_g1523 < 0.0 )
					ifLocalVar87_g1523 = temp_output_125_0_g1523;
					float3 temp_output_7_0_g1524 = frac( ( (ifLocalVar87_g1523).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1524 = dot( temp_output_7_0_g1524 , ( (temp_output_7_0_g1524).yzx + 33.33 ) );
					float3 temp_output_12_0_g1524 = ( temp_output_7_0_g1524 + dotResult8_g1524 );
					float2 temp_output_597_0_g1522 = ( UV100_g1523 + frac( ( ( (temp_output_12_0_g1524).xx + (temp_output_12_0_g1524).yz ) * (temp_output_12_0_g1524).zy ) ) );
					float2 DDX631_g1522 = ddx( temp_output_5_0_g1522 );
					float2 DDY632_g1522 = ddy( temp_output_5_0_g1522 );
					float temp_output_65_0_g1523 = ( 0.0 - temp_output_56_0_g1523 );
					float ifLocalVar59_g1523 = 0;
					if( temp_output_56_0_g1523 <= 0.0 )
					ifLocalVar59_g1523 = temp_output_65_0_g1523;
					else
					ifLocalVar59_g1523 = temp_output_56_0_g1523;
					float temp_output_597_30_g1522 = ifLocalVar59_g1523;
					float2 temp_output_90_0_g1523 = ( temp_output_52_0_g1523 + float2( 0,1 ) );
					float2 temp_output_123_0_g1523 = ( temp_output_52_0_g1523 + float2( 1,0 ) );
					float2 ifLocalVar88_g1523 = 0;
					if( temp_output_56_0_g1523 > 0.0 )
					ifLocalVar88_g1523 = temp_output_90_0_g1523;
					else if( temp_output_56_0_g1523 == 0.0 )
					ifLocalVar88_g1523 = temp_output_123_0_g1523;
					else if( temp_output_56_0_g1523 < 0.0 )
					ifLocalVar88_g1523 = temp_output_123_0_g1523;
					float3 temp_output_7_0_g1525 = frac( ( (ifLocalVar88_g1523).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1525 = dot( temp_output_7_0_g1525 , ( (temp_output_7_0_g1525).yzx + 33.33 ) );
					float3 temp_output_12_0_g1525 = ( temp_output_7_0_g1525 + dotResult8_g1525 );
					float2 temp_output_597_26_g1522 = ( UV100_g1523 + frac( ( ( (temp_output_12_0_g1525).xx + (temp_output_12_0_g1525).yz ) * (temp_output_12_0_g1525).zy ) ) );
					float temp_output_66_0_g1523 = ( 1.0 - break55_g1523.y );
					float ifLocalVar60_g1523 = 0;
					if( temp_output_56_0_g1523 <= 0.0 )
					ifLocalVar60_g1523 = temp_output_66_0_g1523;
					else
					ifLocalVar60_g1523 = break55_g1523.y;
					float temp_output_597_28_g1522 = ifLocalVar60_g1523;
					float2 ifLocalVar89_g1523 = 0;
					if( temp_output_56_0_g1523 > 0.0 )
					ifLocalVar89_g1523 = temp_output_123_0_g1523;
					else if( temp_output_56_0_g1523 == 0.0 )
					ifLocalVar89_g1523 = temp_output_90_0_g1523;
					else if( temp_output_56_0_g1523 < 0.0 )
					ifLocalVar89_g1523 = temp_output_90_0_g1523;
					float3 temp_output_7_0_g1526 = frac( ( (ifLocalVar89_g1523).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1526 = dot( temp_output_7_0_g1526 , ( (temp_output_7_0_g1526).yzx + 33.33 ) );
					float3 temp_output_12_0_g1526 = ( temp_output_7_0_g1526 + dotResult8_g1526 );
					float2 temp_output_597_27_g1522 = ( UV100_g1523 + frac( ( ( (temp_output_12_0_g1526).xx + (temp_output_12_0_g1526).yz ) * (temp_output_12_0_g1526).zy ) ) );
					float temp_output_67_0_g1523 = ( 1.0 - break55_g1523.x );
					float ifLocalVar61_g1523 = 0;
					if( temp_output_56_0_g1523 <= 0.0 )
					ifLocalVar61_g1523 = temp_output_67_0_g1523;
					else
					ifLocalVar61_g1523 = break55_g1523.x;
					float temp_output_597_29_g1522 = ifLocalVar61_g1523;
					float4 Output_2D293_g1522 = ( ( tex2D( _EmissionMap, temp_output_597_0_g1522, DDX631_g1522, DDY632_g1522 ) * temp_output_597_30_g1522 ) + ( tex2D( _EmissionMap, temp_output_597_26_g1522, DDX631_g1522, DDY632_g1522 ) * temp_output_597_28_g1522 ) + ( tex2D( _EmissionMap, temp_output_597_27_g1522, DDX631_g1522, DDY632_g1522 ) * temp_output_597_29_g1522 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g1505 = Output_2D293_g1522;
					#else
					float4 staticSwitch1006_g1505 = tex2D( _EmissionMap, uv_EmissionMap81_g1505 );
					#endif
					#ifdef _EMISSIONENABLED_ON
					float4 staticSwitch1017_g1505 = ( _EmissionColor + staticSwitch1006_g1505 );
					#else
					float4 staticSwitch1017_g1505 = temp_cast_3;
					#endif
					float4 Emission86_g1505 = staticSwitch1017_g1505;
					float4 temp_output_690_0_g1505 = ( Emission86_g1505 + temp_output_614_0_g1505 );
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1019_g1505 = ( temp_output_614_0_g1505 * Emission86_g1505 );
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1019_g1505 = temp_output_690_0_g1505;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1019_g1505 = temp_output_690_0_g1505;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1019_g1505 = temp_output_690_0_g1505;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1019_g1505 = temp_output_690_0_g1505;
					#else
					float4 staticSwitch1019_g1505 = ( temp_output_614_0_g1505 * Emission86_g1505 );
					#endif
					

					o.Albedo = Albedo6_g1505.rgb;
					o.Normal = Normal_Map700_g1505;

					half3 Specular = half3( 0, 0, 0 );
					half Metallic = Metallic699_g1505;
					half Smoothness = staticSwitch824_g1505;
					half Occlusion = staticSwitch1016_g1505;

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

					o.Emission = staticSwitch1019_g1505.rgb;
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
				#pragma shader_feature_local_fragment _BUMPMAP
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

					float2 uv_MainTex907_g1505 = IN.ase_texcoord2.xy;
					float2 uv_MainTex = IN.ase_texcoord2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					float2 temp_output_5_0_g1542 = uv_MainTex;
					float2 UV633_g1542 = temp_output_5_0_g1542;
					float2 UV100_g1543 = UV633_g1542;
					float2 temp_output_51_0_g1543 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g1543 * float2( 3.464,3.464 ) ) );
					float2 break55_g1543 = frac( temp_output_51_0_g1543 );
					float temp_output_56_0_g1543 = ( ( 1.0 - break55_g1543.x ) - break55_g1543.y );
					float2 temp_output_52_0_g1543 = floor( temp_output_51_0_g1543 );
					float2 temp_output_125_0_g1543 = ( temp_output_52_0_g1543 + float2( 1,1 ) );
					float2 ifLocalVar87_g1543 = 0;
					if( temp_output_56_0_g1543 > 0.0 )
					ifLocalVar87_g1543 = temp_output_52_0_g1543;
					else if( temp_output_56_0_g1543 == 0.0 )
					ifLocalVar87_g1543 = temp_output_125_0_g1543;
					else if( temp_output_56_0_g1543 < 0.0 )
					ifLocalVar87_g1543 = temp_output_125_0_g1543;
					float3 temp_output_7_0_g1544 = frac( ( (ifLocalVar87_g1543).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1544 = dot( temp_output_7_0_g1544 , ( (temp_output_7_0_g1544).yzx + 33.33 ) );
					float3 temp_output_12_0_g1544 = ( temp_output_7_0_g1544 + dotResult8_g1544 );
					float2 temp_output_597_0_g1542 = ( UV100_g1543 + frac( ( ( (temp_output_12_0_g1544).xx + (temp_output_12_0_g1544).yz ) * (temp_output_12_0_g1544).zy ) ) );
					float2 DDX631_g1542 = ddx( temp_output_5_0_g1542 );
					float2 DDY632_g1542 = ddy( temp_output_5_0_g1542 );
					float temp_output_65_0_g1543 = ( 0.0 - temp_output_56_0_g1543 );
					float ifLocalVar59_g1543 = 0;
					if( temp_output_56_0_g1543 <= 0.0 )
					ifLocalVar59_g1543 = temp_output_65_0_g1543;
					else
					ifLocalVar59_g1543 = temp_output_56_0_g1543;
					float temp_output_597_30_g1542 = ifLocalVar59_g1543;
					float2 temp_output_90_0_g1543 = ( temp_output_52_0_g1543 + float2( 0,1 ) );
					float2 temp_output_123_0_g1543 = ( temp_output_52_0_g1543 + float2( 1,0 ) );
					float2 ifLocalVar88_g1543 = 0;
					if( temp_output_56_0_g1543 > 0.0 )
					ifLocalVar88_g1543 = temp_output_90_0_g1543;
					else if( temp_output_56_0_g1543 == 0.0 )
					ifLocalVar88_g1543 = temp_output_123_0_g1543;
					else if( temp_output_56_0_g1543 < 0.0 )
					ifLocalVar88_g1543 = temp_output_123_0_g1543;
					float3 temp_output_7_0_g1545 = frac( ( (ifLocalVar88_g1543).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1545 = dot( temp_output_7_0_g1545 , ( (temp_output_7_0_g1545).yzx + 33.33 ) );
					float3 temp_output_12_0_g1545 = ( temp_output_7_0_g1545 + dotResult8_g1545 );
					float2 temp_output_597_26_g1542 = ( UV100_g1543 + frac( ( ( (temp_output_12_0_g1545).xx + (temp_output_12_0_g1545).yz ) * (temp_output_12_0_g1545).zy ) ) );
					float temp_output_66_0_g1543 = ( 1.0 - break55_g1543.y );
					float ifLocalVar60_g1543 = 0;
					if( temp_output_56_0_g1543 <= 0.0 )
					ifLocalVar60_g1543 = temp_output_66_0_g1543;
					else
					ifLocalVar60_g1543 = break55_g1543.y;
					float temp_output_597_28_g1542 = ifLocalVar60_g1543;
					float2 ifLocalVar89_g1543 = 0;
					if( temp_output_56_0_g1543 > 0.0 )
					ifLocalVar89_g1543 = temp_output_123_0_g1543;
					else if( temp_output_56_0_g1543 == 0.0 )
					ifLocalVar89_g1543 = temp_output_90_0_g1543;
					else if( temp_output_56_0_g1543 < 0.0 )
					ifLocalVar89_g1543 = temp_output_90_0_g1543;
					float3 temp_output_7_0_g1546 = frac( ( (ifLocalVar89_g1543).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1546 = dot( temp_output_7_0_g1546 , ( (temp_output_7_0_g1546).yzx + 33.33 ) );
					float3 temp_output_12_0_g1546 = ( temp_output_7_0_g1546 + dotResult8_g1546 );
					float2 temp_output_597_27_g1542 = ( UV100_g1543 + frac( ( ( (temp_output_12_0_g1546).xx + (temp_output_12_0_g1546).yz ) * (temp_output_12_0_g1546).zy ) ) );
					float temp_output_67_0_g1543 = ( 1.0 - break55_g1543.x );
					float ifLocalVar61_g1543 = 0;
					if( temp_output_56_0_g1543 <= 0.0 )
					ifLocalVar61_g1543 = temp_output_67_0_g1543;
					else
					ifLocalVar61_g1543 = break55_g1543.x;
					float temp_output_597_29_g1542 = ifLocalVar61_g1543;
					float4 Output_2D293_g1542 = ( ( tex2D( _MainTex, temp_output_597_0_g1542, DDX631_g1542, DDY632_g1542 ) * temp_output_597_30_g1542 ) + ( tex2D( _MainTex, temp_output_597_26_g1542, DDX631_g1542, DDY632_g1542 ) * temp_output_597_28_g1542 ) + ( tex2D( _MainTex, temp_output_597_27_g1542, DDX631_g1542, DDY632_g1542 ) * temp_output_597_29_g1542 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g1505 = Output_2D293_g1542;
					#else
					float4 staticSwitch1001_g1505 = tex2D( _MainTex, uv_MainTex907_g1505 );
					#endif
					float4 temp_output_976_0_g1505 = ( _Color * staticSwitch1001_g1505 );
					float4 Albedo6_g1505 = temp_output_976_0_g1505;
					
					float White38_g1505 = 1.0;
					float4 temp_cast_1 = (White38_g1505).xxxx;
					float localBicubicPrepare2_g1507 = ( 0.0 );
					float2 uv3_Lightmap0 = IN.ase_texcoord2.zw * _Lightmap0_ST.xy + _Lightmap0_ST.zw;
					float2 Input_UV100_g1507 = uv3_Lightmap0;
					float2 UV2_g1507 = Input_UV100_g1507;
					float4 TexelSize2_g1507 = _Lightmap0_TexelSize;
					float2 UV02_g1507 = float2( 0,0 );
					float2 UV12_g1507 = float2( 0,0 );
					float2 UV22_g1507 = float2( 0,0 );
					float2 UV32_g1507 = float2( 0,0 );
					float W02_g1507 = 0;
					float W12_g1507 = 0;
					{
					{
					 UV2_g1507 = UV2_g1507 * TexelSize2_g1507.zw - 0.5;
					    float2 f = frac( UV2_g1507 );
					    UV2_g1507 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g1507.x - 0.5, UV2_g1507.x + 1.5, UV2_g1507.y - 0.5, UV2_g1507.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1507.xyxy;
					    UV02_g1507 = off.xz;
					    UV12_g1507 = off.yz;
					    UV22_g1507 = off.xw;
					    UV32_g1507 = off.yw;
					    W02_g1507 = s.x / ( s.x + s.y );
					 W12_g1507 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g1507 = lerp( tex2D( _Lightmap0, UV32_g1507 ) , tex2D( _Lightmap0, UV22_g1507 ) , W02_g1507);
					float4 lerpResult45_g1507 = lerp( tex2D( _Lightmap0, UV12_g1507 ) , tex2D( _Lightmap0, UV02_g1507 ) , W02_g1507);
					float4 lerpResult44_g1507 = lerp( lerpResult46_g1507 , lerpResult45_g1507 , W12_g1507);
					float4 Output_2D131_g1507 = lerpResult44_g1507;
					float4 Lightmap_0925_g1505 = Output_2D131_g1507;
					float localBicubicPrepare2_g1509 = ( 0.0 );
					float2 uv3_Lightmap1 = IN.ase_texcoord2.zw * _Lightmap1_ST.xy + _Lightmap1_ST.zw;
					float2 Input_UV100_g1509 = uv3_Lightmap1;
					float2 UV2_g1509 = Input_UV100_g1509;
					float4 TexelSize2_g1509 = _Lightmap1_TexelSize;
					float2 UV02_g1509 = float2( 0,0 );
					float2 UV12_g1509 = float2( 0,0 );
					float2 UV22_g1509 = float2( 0,0 );
					float2 UV32_g1509 = float2( 0,0 );
					float W02_g1509 = 0;
					float W12_g1509 = 0;
					{
					{
					 UV2_g1509 = UV2_g1509 * TexelSize2_g1509.zw - 0.5;
					    float2 f = frac( UV2_g1509 );
					    UV2_g1509 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g1509.x - 0.5, UV2_g1509.x + 1.5, UV2_g1509.y - 0.5, UV2_g1509.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1509.xyxy;
					    UV02_g1509 = off.xz;
					    UV12_g1509 = off.yz;
					    UV22_g1509 = off.xw;
					    UV32_g1509 = off.yw;
					    W02_g1509 = s.x / ( s.x + s.y );
					 W12_g1509 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g1509 = lerp( tex2D( _Lightmap1, UV32_g1509 ) , tex2D( _Lightmap1, UV22_g1509 ) , W02_g1509);
					float4 lerpResult45_g1509 = lerp( tex2D( _Lightmap1, UV12_g1509 ) , tex2D( _Lightmap1, UV02_g1509 ) , W02_g1509);
					float4 lerpResult44_g1509 = lerp( lerpResult46_g1509 , lerpResult45_g1509 , W12_g1509);
					float4 Output_2D131_g1509 = lerpResult44_g1509;
					float4 Lightmap_1956_g1505 = Output_2D131_g1509;
					float4 lerpResult442_g1505 = lerp( Lightmap_0925_g1505 , Lightmap_1956_g1505 , _LightmapLerp);
					float4 Lightmap_Lerp932_g1505 = lerpResult442_g1505;
					float3 appendResult139_g1520 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float2 uv_BumpMap830_g1505 = IN.ase_texcoord2.xy;
					float2 uv_BumpMap = IN.ase_texcoord2.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					float2 temp_output_5_0_g1537 = uv_BumpMap;
					float2 UV633_g1537 = temp_output_5_0_g1537;
					float2 UV100_g1538 = UV633_g1537;
					float2 temp_output_51_0_g1538 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g1538 * float2( 3.464,3.464 ) ) );
					float2 break55_g1538 = frac( temp_output_51_0_g1538 );
					float temp_output_56_0_g1538 = ( ( 1.0 - break55_g1538.x ) - break55_g1538.y );
					float2 temp_output_52_0_g1538 = floor( temp_output_51_0_g1538 );
					float2 temp_output_125_0_g1538 = ( temp_output_52_0_g1538 + float2( 1,1 ) );
					float2 ifLocalVar87_g1538 = 0;
					if( temp_output_56_0_g1538 > 0.0 )
					ifLocalVar87_g1538 = temp_output_52_0_g1538;
					else if( temp_output_56_0_g1538 == 0.0 )
					ifLocalVar87_g1538 = temp_output_125_0_g1538;
					else if( temp_output_56_0_g1538 < 0.0 )
					ifLocalVar87_g1538 = temp_output_125_0_g1538;
					float3 temp_output_7_0_g1539 = frac( ( (ifLocalVar87_g1538).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1539 = dot( temp_output_7_0_g1539 , ( (temp_output_7_0_g1539).yzx + 33.33 ) );
					float3 temp_output_12_0_g1539 = ( temp_output_7_0_g1539 + dotResult8_g1539 );
					float2 temp_output_597_0_g1537 = ( UV100_g1538 + frac( ( ( (temp_output_12_0_g1539).xx + (temp_output_12_0_g1539).yz ) * (temp_output_12_0_g1539).zy ) ) );
					float2 DDX631_g1537 = ddx( temp_output_5_0_g1537 );
					float2 DDY632_g1537 = ddy( temp_output_5_0_g1537 );
					float Input_Scale617_g1537 = _NormalScale;
					float temp_output_65_0_g1538 = ( 0.0 - temp_output_56_0_g1538 );
					float ifLocalVar59_g1538 = 0;
					if( temp_output_56_0_g1538 <= 0.0 )
					ifLocalVar59_g1538 = temp_output_65_0_g1538;
					else
					ifLocalVar59_g1538 = temp_output_56_0_g1538;
					float temp_output_597_30_g1537 = ifLocalVar59_g1538;
					float2 temp_output_90_0_g1538 = ( temp_output_52_0_g1538 + float2( 0,1 ) );
					float2 temp_output_123_0_g1538 = ( temp_output_52_0_g1538 + float2( 1,0 ) );
					float2 ifLocalVar88_g1538 = 0;
					if( temp_output_56_0_g1538 > 0.0 )
					ifLocalVar88_g1538 = temp_output_90_0_g1538;
					else if( temp_output_56_0_g1538 == 0.0 )
					ifLocalVar88_g1538 = temp_output_123_0_g1538;
					else if( temp_output_56_0_g1538 < 0.0 )
					ifLocalVar88_g1538 = temp_output_123_0_g1538;
					float3 temp_output_7_0_g1540 = frac( ( (ifLocalVar88_g1538).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1540 = dot( temp_output_7_0_g1540 , ( (temp_output_7_0_g1540).yzx + 33.33 ) );
					float3 temp_output_12_0_g1540 = ( temp_output_7_0_g1540 + dotResult8_g1540 );
					float2 temp_output_597_26_g1537 = ( UV100_g1538 + frac( ( ( (temp_output_12_0_g1540).xx + (temp_output_12_0_g1540).yz ) * (temp_output_12_0_g1540).zy ) ) );
					float temp_output_66_0_g1538 = ( 1.0 - break55_g1538.y );
					float ifLocalVar60_g1538 = 0;
					if( temp_output_56_0_g1538 <= 0.0 )
					ifLocalVar60_g1538 = temp_output_66_0_g1538;
					else
					ifLocalVar60_g1538 = break55_g1538.y;
					float temp_output_597_28_g1537 = ifLocalVar60_g1538;
					float2 ifLocalVar89_g1538 = 0;
					if( temp_output_56_0_g1538 > 0.0 )
					ifLocalVar89_g1538 = temp_output_123_0_g1538;
					else if( temp_output_56_0_g1538 == 0.0 )
					ifLocalVar89_g1538 = temp_output_90_0_g1538;
					else if( temp_output_56_0_g1538 < 0.0 )
					ifLocalVar89_g1538 = temp_output_90_0_g1538;
					float3 temp_output_7_0_g1541 = frac( ( (ifLocalVar89_g1538).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1541 = dot( temp_output_7_0_g1541 , ( (temp_output_7_0_g1541).yzx + 33.33 ) );
					float3 temp_output_12_0_g1541 = ( temp_output_7_0_g1541 + dotResult8_g1541 );
					float2 temp_output_597_27_g1537 = ( UV100_g1538 + frac( ( ( (temp_output_12_0_g1541).xx + (temp_output_12_0_g1541).yz ) * (temp_output_12_0_g1541).zy ) ) );
					float temp_output_67_0_g1538 = ( 1.0 - break55_g1538.x );
					float ifLocalVar61_g1538 = 0;
					if( temp_output_56_0_g1538 <= 0.0 )
					ifLocalVar61_g1538 = temp_output_67_0_g1538;
					else
					ifLocalVar61_g1538 = break55_g1538.x;
					float temp_output_597_29_g1537 = ifLocalVar61_g1538;
					float3 Output_2D_Normal641_g1537 = ( ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_0_g1537, DDX631_g1537, DDY632_g1537 ), Input_Scale617_g1537 ) * temp_output_597_30_g1537 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_26_g1537, DDX631_g1537, DDY632_g1537 ), Input_Scale617_g1537 ) * temp_output_597_28_g1537 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_27_g1537, DDX631_g1537, DDY632_g1537 ), Input_Scale617_g1537 ) * float3( 0,0,0 ) * temp_output_597_29_g1537 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g1505 = Output_2D_Normal641_g1537;
					#else
					float3 staticSwitch1003_g1505 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap830_g1505 ), _NormalScale );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g1505 = staticSwitch1003_g1505;
					#else
					float3 staticSwitch980_g1505 = float3( 0, 0, 1 );
					#endif
					float3 Normal_Map700_g1505 = staticSwitch980_g1505;
					float3 normalizeResult326_g1520 = normalize( Normal_Map700_g1505 );
					float3 Normal_Map318_g1520 = normalizeResult326_g1520;
					float dotResult121_g1520 = dot( appendResult139_g1520 , Normal_Map318_g1520 );
					float localStochasticTiling2_g1516 = ( 0.0 );
					float2 uv3_RNMX0 = IN.ase_texcoord2.zw * _RNMX0_ST.xy + _RNMX0_ST.zw;
					float2 UV2_g1516 = uv3_RNMX0;
					float4 TexelSize2_g1516 = _RNMX0_TexelSize;
					float4 Offsets2_g1516 = float4( 0,0,0,0 );
					float2 Weights2_g1516 = float2( 0,0 );
					{
					UV2_g1516 = UV2_g1516 * TexelSize2_g1516.zw - 0.5;
					float2 f = frac( UV2_g1516 );
					UV2_g1516 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g1516.x - 0.5, UV2_g1516.x + 1.5, UV2_g1516.y - 0.5, UV2_g1516.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g1516 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1516.xyxy;
					Weights2_g1516 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g1515 = Offsets2_g1516;
					float4 Input_FetchOffsets197_g1519 = temp_output_1_34_g1515;
					float2 temp_output_1_54_g1515 = Weights2_g1516;
					float2 Input_FetchWeights200_g1519 = temp_output_1_54_g1515;
					float2 break187_g1519 = Input_FetchWeights200_g1519;
					float4 lerpResult181_g1519 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g1519).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g1519).xw ) , break187_g1519.x);
					float4 lerpResult182_g1519 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g1519).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g1519).xz ) , break187_g1519.x);
					float4 lerpResult176_g1519 = lerp( lerpResult181_g1519 , lerpResult182_g1519 , break187_g1519.y);
					float4 Output_Fetch2D202_g1519 = lerpResult176_g1519;
					float3 appendResult146_g1520 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g1520 = dot( appendResult146_g1520 , Normal_Map318_g1520 );
					float4 Input_FetchOffsets197_g1517 = temp_output_1_34_g1515;
					float2 Input_FetchWeights200_g1517 = temp_output_1_54_g1515;
					float2 break187_g1517 = Input_FetchWeights200_g1517;
					float4 lerpResult181_g1517 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g1517).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g1517).xw ) , break187_g1517.x);
					float4 lerpResult182_g1517 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g1517).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g1517).xz ) , break187_g1517.x);
					float4 lerpResult176_g1517 = lerp( lerpResult181_g1517 , lerpResult182_g1517 , break187_g1517.y);
					float4 Output_Fetch2D202_g1517 = lerpResult176_g1517;
					float3 appendResult149_g1520 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g1520 = dot( appendResult149_g1520 , Normal_Map318_g1520 );
					float4 Input_FetchOffsets197_g1518 = temp_output_1_34_g1515;
					float2 Input_FetchWeights200_g1518 = temp_output_1_54_g1515;
					float2 break187_g1518 = Input_FetchWeights200_g1518;
					float4 lerpResult181_g1518 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g1518).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g1518).xw ) , break187_g1518.x);
					float4 lerpResult182_g1518 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g1518).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g1518).xz ) , break187_g1518.x);
					float4 lerpResult176_g1518 = lerp( lerpResult181_g1518 , lerpResult182_g1518 , break187_g1518.y);
					float4 Output_Fetch2D202_g1518 = lerpResult176_g1518;
					float4 RNM_0926_g1505 = ( ( ( saturate( dotResult121_g1520 ) * ( Output_Fetch2D202_g1519 * 0.8 ) ) + ( saturate( dotResult122_g1520 ) * ( Output_Fetch2D202_g1517 * 0.8 ) ) ) + ( saturate( dotResult120_g1520 ) * ( Output_Fetch2D202_g1518 * 0.8 ) ) );
					float3 appendResult139_g1521 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 normalizeResult326_g1521 = normalize( Normal_Map700_g1505 );
					float3 Normal_Map318_g1521 = normalizeResult326_g1521;
					float dotResult121_g1521 = dot( appendResult139_g1521 , Normal_Map318_g1521 );
					float localStochasticTiling2_g1511 = ( 0.0 );
					float2 uv3_RNMX1 = IN.ase_texcoord2.zw * _RNMX1_ST.xy + _RNMX1_ST.zw;
					float2 UV2_g1511 = uv3_RNMX1;
					float4 TexelSize2_g1511 = _RNMX1_TexelSize;
					float4 Offsets2_g1511 = float4( 0,0,0,0 );
					float2 Weights2_g1511 = float2( 0,0 );
					{
					UV2_g1511 = UV2_g1511 * TexelSize2_g1511.zw - 0.5;
					float2 f = frac( UV2_g1511 );
					UV2_g1511 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g1511.x - 0.5, UV2_g1511.x + 1.5, UV2_g1511.y - 0.5, UV2_g1511.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g1511 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1511.xyxy;
					Weights2_g1511 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g1510 = Offsets2_g1511;
					float4 Input_FetchOffsets197_g1514 = temp_output_1_34_g1510;
					float2 temp_output_1_54_g1510 = Weights2_g1511;
					float2 Input_FetchWeights200_g1514 = temp_output_1_54_g1510;
					float2 break187_g1514 = Input_FetchWeights200_g1514;
					float4 lerpResult181_g1514 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g1514).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g1514).xw ) , break187_g1514.x);
					float4 lerpResult182_g1514 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g1514).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g1514).xz ) , break187_g1514.x);
					float4 lerpResult176_g1514 = lerp( lerpResult181_g1514 , lerpResult182_g1514 , break187_g1514.y);
					float4 Output_Fetch2D202_g1514 = lerpResult176_g1514;
					float3 appendResult146_g1521 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g1521 = dot( appendResult146_g1521 , Normal_Map318_g1521 );
					float4 Input_FetchOffsets197_g1512 = temp_output_1_34_g1510;
					float2 Input_FetchWeights200_g1512 = temp_output_1_54_g1510;
					float2 break187_g1512 = Input_FetchWeights200_g1512;
					float4 lerpResult181_g1512 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g1512).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g1512).xw ) , break187_g1512.x);
					float4 lerpResult182_g1512 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g1512).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g1512).xz ) , break187_g1512.x);
					float4 lerpResult176_g1512 = lerp( lerpResult181_g1512 , lerpResult182_g1512 , break187_g1512.y);
					float4 Output_Fetch2D202_g1512 = lerpResult176_g1512;
					float3 appendResult149_g1521 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g1521 = dot( appendResult149_g1521 , Normal_Map318_g1521 );
					float4 Input_FetchOffsets197_g1513 = temp_output_1_34_g1510;
					float2 Input_FetchWeights200_g1513 = temp_output_1_54_g1510;
					float2 break187_g1513 = Input_FetchWeights200_g1513;
					float4 lerpResult181_g1513 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g1513).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g1513).xw ) , break187_g1513.x);
					float4 lerpResult182_g1513 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g1513).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g1513).xz ) , break187_g1513.x);
					float4 lerpResult176_g1513 = lerp( lerpResult181_g1513 , lerpResult182_g1513 , break187_g1513.y);
					float4 Output_Fetch2D202_g1513 = lerpResult176_g1513;
					float4 RNM_1927_g1505 = ( ( ( saturate( dotResult121_g1521 ) * ( Output_Fetch2D202_g1514 * 0.8 ) ) + ( saturate( dotResult122_g1521 ) * ( Output_Fetch2D202_g1512 * 0.8 ) ) ) + ( saturate( dotResult120_g1521 ) * ( Output_Fetch2D202_g1513 * 0.8 ) ) );
					float Lightmap_Lerp_Value969_g1505 = _LightmapLerp;
					float4 lerpResult953_g1505 = lerp( RNM_0926_g1505 , RNM_1927_g1505 , Lightmap_Lerp_Value969_g1505);
					float4 RNM_Lerp950_g1505 = lerpResult953_g1505;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g1505 = temp_cast_1;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g1505 = Lightmap_0925_g1505;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g1505 = Lightmap_Lerp932_g1505;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g1505 = RNM_0926_g1505;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g1505 = RNM_Lerp950_g1505;
					#else
					float4 staticSwitch1014_g1505 = temp_cast_1;
					#endif
					float4 Lightmap46_g1505 = staticSwitch1014_g1505;
					float4 temp_output_614_0_g1505 = ( Albedo6_g1505 * Lightmap46_g1505 );
					float4 temp_cast_2 = 0;
					float2 uv_EmissionMap81_g1505 = IN.ase_texcoord2.xy;
					float2 uv_EmissionMap = IN.ase_texcoord2.xy * _EmissionMap_ST.xy + _EmissionMap_ST.zw;
					float2 temp_output_5_0_g1522 = uv_EmissionMap;
					float2 UV633_g1522 = temp_output_5_0_g1522;
					float2 UV100_g1523 = UV633_g1522;
					float2 temp_output_51_0_g1523 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g1523 * float2( 3.464,3.464 ) ) );
					float2 break55_g1523 = frac( temp_output_51_0_g1523 );
					float temp_output_56_0_g1523 = ( ( 1.0 - break55_g1523.x ) - break55_g1523.y );
					float2 temp_output_52_0_g1523 = floor( temp_output_51_0_g1523 );
					float2 temp_output_125_0_g1523 = ( temp_output_52_0_g1523 + float2( 1,1 ) );
					float2 ifLocalVar87_g1523 = 0;
					if( temp_output_56_0_g1523 > 0.0 )
					ifLocalVar87_g1523 = temp_output_52_0_g1523;
					else if( temp_output_56_0_g1523 == 0.0 )
					ifLocalVar87_g1523 = temp_output_125_0_g1523;
					else if( temp_output_56_0_g1523 < 0.0 )
					ifLocalVar87_g1523 = temp_output_125_0_g1523;
					float3 temp_output_7_0_g1524 = frac( ( (ifLocalVar87_g1523).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1524 = dot( temp_output_7_0_g1524 , ( (temp_output_7_0_g1524).yzx + 33.33 ) );
					float3 temp_output_12_0_g1524 = ( temp_output_7_0_g1524 + dotResult8_g1524 );
					float2 temp_output_597_0_g1522 = ( UV100_g1523 + frac( ( ( (temp_output_12_0_g1524).xx + (temp_output_12_0_g1524).yz ) * (temp_output_12_0_g1524).zy ) ) );
					float2 DDX631_g1522 = ddx( temp_output_5_0_g1522 );
					float2 DDY632_g1522 = ddy( temp_output_5_0_g1522 );
					float temp_output_65_0_g1523 = ( 0.0 - temp_output_56_0_g1523 );
					float ifLocalVar59_g1523 = 0;
					if( temp_output_56_0_g1523 <= 0.0 )
					ifLocalVar59_g1523 = temp_output_65_0_g1523;
					else
					ifLocalVar59_g1523 = temp_output_56_0_g1523;
					float temp_output_597_30_g1522 = ifLocalVar59_g1523;
					float2 temp_output_90_0_g1523 = ( temp_output_52_0_g1523 + float2( 0,1 ) );
					float2 temp_output_123_0_g1523 = ( temp_output_52_0_g1523 + float2( 1,0 ) );
					float2 ifLocalVar88_g1523 = 0;
					if( temp_output_56_0_g1523 > 0.0 )
					ifLocalVar88_g1523 = temp_output_90_0_g1523;
					else if( temp_output_56_0_g1523 == 0.0 )
					ifLocalVar88_g1523 = temp_output_123_0_g1523;
					else if( temp_output_56_0_g1523 < 0.0 )
					ifLocalVar88_g1523 = temp_output_123_0_g1523;
					float3 temp_output_7_0_g1525 = frac( ( (ifLocalVar88_g1523).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1525 = dot( temp_output_7_0_g1525 , ( (temp_output_7_0_g1525).yzx + 33.33 ) );
					float3 temp_output_12_0_g1525 = ( temp_output_7_0_g1525 + dotResult8_g1525 );
					float2 temp_output_597_26_g1522 = ( UV100_g1523 + frac( ( ( (temp_output_12_0_g1525).xx + (temp_output_12_0_g1525).yz ) * (temp_output_12_0_g1525).zy ) ) );
					float temp_output_66_0_g1523 = ( 1.0 - break55_g1523.y );
					float ifLocalVar60_g1523 = 0;
					if( temp_output_56_0_g1523 <= 0.0 )
					ifLocalVar60_g1523 = temp_output_66_0_g1523;
					else
					ifLocalVar60_g1523 = break55_g1523.y;
					float temp_output_597_28_g1522 = ifLocalVar60_g1523;
					float2 ifLocalVar89_g1523 = 0;
					if( temp_output_56_0_g1523 > 0.0 )
					ifLocalVar89_g1523 = temp_output_123_0_g1523;
					else if( temp_output_56_0_g1523 == 0.0 )
					ifLocalVar89_g1523 = temp_output_90_0_g1523;
					else if( temp_output_56_0_g1523 < 0.0 )
					ifLocalVar89_g1523 = temp_output_90_0_g1523;
					float3 temp_output_7_0_g1526 = frac( ( (ifLocalVar89_g1523).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g1526 = dot( temp_output_7_0_g1526 , ( (temp_output_7_0_g1526).yzx + 33.33 ) );
					float3 temp_output_12_0_g1526 = ( temp_output_7_0_g1526 + dotResult8_g1526 );
					float2 temp_output_597_27_g1522 = ( UV100_g1523 + frac( ( ( (temp_output_12_0_g1526).xx + (temp_output_12_0_g1526).yz ) * (temp_output_12_0_g1526).zy ) ) );
					float temp_output_67_0_g1523 = ( 1.0 - break55_g1523.x );
					float ifLocalVar61_g1523 = 0;
					if( temp_output_56_0_g1523 <= 0.0 )
					ifLocalVar61_g1523 = temp_output_67_0_g1523;
					else
					ifLocalVar61_g1523 = break55_g1523.x;
					float temp_output_597_29_g1522 = ifLocalVar61_g1523;
					float4 Output_2D293_g1522 = ( ( tex2D( _EmissionMap, temp_output_597_0_g1522, DDX631_g1522, DDY632_g1522 ) * temp_output_597_30_g1522 ) + ( tex2D( _EmissionMap, temp_output_597_26_g1522, DDX631_g1522, DDY632_g1522 ) * temp_output_597_28_g1522 ) + ( tex2D( _EmissionMap, temp_output_597_27_g1522, DDX631_g1522, DDY632_g1522 ) * temp_output_597_29_g1522 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g1505 = Output_2D293_g1522;
					#else
					float4 staticSwitch1006_g1505 = tex2D( _EmissionMap, uv_EmissionMap81_g1505 );
					#endif
					#ifdef _EMISSIONENABLED_ON
					float4 staticSwitch1017_g1505 = ( _EmissionColor + staticSwitch1006_g1505 );
					#else
					float4 staticSwitch1017_g1505 = temp_cast_2;
					#endif
					float4 Emission86_g1505 = staticSwitch1017_g1505;
					float4 temp_output_690_0_g1505 = ( Emission86_g1505 + temp_output_614_0_g1505 );
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1019_g1505 = ( temp_output_614_0_g1505 * Emission86_g1505 );
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1019_g1505 = temp_output_690_0_g1505;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1019_g1505 = temp_output_690_0_g1505;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1019_g1505 = temp_output_690_0_g1505;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1019_g1505 = temp_output_690_0_g1505;
					#else
					float4 staticSwitch1019_g1505 = ( temp_output_614_0_g1505 * Emission86_g1505 );
					#endif
					

					o.Albedo = Albedo6_g1505.rgb;
					o.Normal = half3( 0, 0, 1 );
					o.Emission = staticSwitch1019_g1505.rgb;
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
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2925;192,-1200;Inherit;False;Meenphie;0;;1505;b3ba55a08dd6b49c7be16c6f35cf2033;1,1008,0;0;9;COLOR;625;FLOAT3;238;FLOAT;96;FLOAT;97;FLOAT;95;COLOR;624;FLOAT;156;FLOAT;427;FLOAT3;1024
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2930;160,-1408;Inherit;False;Meenphie Outline;36;;1551;d39aa08508dd494aeb2901b7a0739759;0;0;2;FLOAT3;17;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2889;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;True;1;LightMode=ForwardAdd;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2890;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2891;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2892;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2893;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2894;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ScenePickingPass;0;7;ScenePickingPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;True;1;LightMode=ScenePickingPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2887;480,-1440;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;True;True;0;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;True;True;1;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;0;False;;True;0;False;;True;False;0;False;;0;False;;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2888;512,-1200;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;Meenphie/Standard/Opaque;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardBase;0;1;ForwardBase;17;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;True;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;0;False;;True;0;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;3;False;0;True;True;0;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;44;Category,InvertActionOnDeselection;0;0;  Instanced Terrain Normals;1;0;Workflow;1;638915476438868730;Surface;0;0;  Blend;0;0;  Dither Shadows;1;0;Two Sided;1;638915389515035230;Alpha Clipping;0;0;  Use Shadow Threshold;0;0;Deferred Pass;0;638915388739756900;Normal Space,InvertActionOnDeselection;0;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;0;638915410807634230;Receive Shadows;1;0;Receive Specular;0;638915388784334560;Receive Reflections;1;638915388803555030;GPU Instancing;1;638915411619689990;LOD CrossFade;1;0;Built-in Fog;1;0;Ambient Light;1;0;Meta Pass;1;0;Add Pass;1;0;Override Baked GI;0;638915390973737640;Write Depth;0;638915391054792770;Extra Pre Pass;1;638915414992188530;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;0;Vertex Position,InvertActionOnDeselection;1;0;0;8;True;True;True;False;True;False;False;False;False;;False;0
WireConnection;2887;0;2930;17
WireConnection;2887;3;2930;0
WireConnection;2888;0;2925;625
WireConnection;2888;1;2925;238
WireConnection;2888;4;2925;96
WireConnection;2888;5;2925;97
WireConnection;2888;6;2925;95
WireConnection;2888;2;2925;624
ASEEND*/
//CHKSM=FF88E5548B7BFBCA65B14F0ACDB5C81E44343AB7