// Made with Amplify Shader Editor v1.9.9.14
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
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESURFACEOPTIONS( "CATEGORY SPACE SURFACEOPTIONS", Float ) = 0
		[Meenphie_DrawerCategory(EMISSION,true,0,0)] _CATEGORYEMISSION( "CATEGORY EMISSION", Float ) = 0
		[NoScaleOffset][SingleLineTexture] _EmissionMap( "Emission", 2D ) = "white" {}
		[Gamma] _EmissionColor( "Emission Color", Color ) = ( 1, 1, 1 )
		_EmissionIntensity( "Emission Intensity", Float ) = 0
		[Meenphie_DrawerEmissionFlags] _EmissionFlags( "Global Illumination", Float ) = 2
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACEEMISSION( "CATEGORY SPACE EMISSION", Float ) = 0
		[Meenphie_DrawerCategory(SUBSURFACE SCATTERING,true,0,0)] _CATEGORYSUBSURFACESCATTERING( "CATEGORYSUBSURFACE SCATTERING", Float ) = 0
		_SubsurfaceColor( "Subsurface Color", Color ) = ( 1, 0.4196078, 0.3686275, 0 )
		_Thickness( "Thickness", Range( 0, 1 ) ) = 0
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESUBSURFACESCATTERING( "CATEGORYSPACESUBSURFACE SCATTERING", Float ) = 0
		[Meenphie_DrawerCategory(LIGHTMAPPING,true,0,0)] _CATEGORYLIGHTING( "CATEGORY LIGHTING", Float ) = 0
		[Toggle( _DIFFUSE_ON )] _Diffuse( "Diffuse", Float ) = 1
		[Toggle( _SPECULARS_ON )] _Speculars( "Speculars", Float ) = 1
		[Toggle( _REFLECTIONS_ON )] _Reflections( "Reflections", Float ) = 1
		[HideInInspector] _LightGroupMask( "Light Group Mask", Float ) = 0
		[Toggle] _IsDynamicMesh( "Is Dynamic Mesh", Float ) = 0
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACELIGHTING( "CATEGORY SPACE LIGHTING", Float ) = 0
		[Meenphie_DrawerCategory(COLOR GRADING,true,0,0)] _CATEGORYCOLORGRADING( "CATEGORY COLOR GRADING", Float ) = 0
		[NoScaleOffset][SingleLineTexture] _LUT( "LUT", 3D ) = "black" {}
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACECOLORGRADING( "CATEGORY SPACE COLOR GRADING", Float ) = 0
		[Meenphie_DrawerCategory(SPECIAL EFFECTS,true,0,0)] _CATEGORYSPECIALEFFECTS( "CATEGORY SPECIAL EFFECTS", Float ) = 0
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESPECIALEFFECTS( "CATEGORY SPACE SPECIAL EFFECTS", Float ) = 0
		_Offset( "Offset", Float ) = 0
		[HideInInspector] GenKey__GlossinessMap( "Assign keyword _GLOSSINESSMAP", Float ) = 1.0
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0
		[HideInInspector] GenKey__MetallicMap( "Assign keyword _METALLICMAP", Float ) = 1.0

	}
	
	SubShader
	{
		

		

		Tags { "RenderType"="Opaque" }

	LOD 0

		ZWrite On
		ZClip True
		Cull Back
		AlphaToMask Off
		ColorMask RGBA
		Blend One Zero, One Zero
		BlendOp Add, Add
		Offset 0 , 0

		

		Blend One Zero, One Zero
		BlendOp Add, Add
		

		CGINCLUDE
			#pragma target 4.5
			// ensure rendering platforms toggle list is visible

			#ifndef GLOBAL_HEADER_INCLUDED
			#define GLOBAL_HEADER_INCLUDED
			float4 ComputeClipSpacePosition( float2 screenPosNorm, float deviceDepth )
			{
				float4 positionCS = float4( screenPosNorm * 2.0 - 1.0, deviceDepth, 1.0 );
			#if UNITY_UV_STARTS_AT_TOP
				positionCS.y = -positionCS.y;
			#endif
				return positionCS;
			}
			#endif
		ENDCG

		
		Pass
		{
			
			Name "Unlit"

			Cull Back
			ZWrite On
			ZTest LEqual
			Offset [_Offset] , [_Offset]
			ColorMask RGBA
			Blend One Zero, One Zero
			BlendOp Add, Add

			

			CGPROGRAM
				#define ASE_VERSION 19914
				#define ASE_USING_SAMPLING_MACROS 1

				#pragma vertex vert
				#pragma fragment frag
				#pragma multi_compile_instancing
				#include "UnityCG.cginc"

				#include "Packages/com.meenphie.lighting/Commons/Shaders/Custom Expressions/LayeredLightmapLighting.cginc"
				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#define ASE_NEEDS_TEXTURE_COORDINATES3
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES3
				#define ASE_NEEDS_VERT_NORMAL
				#define ASE_NEEDS_VERT_TANGENT
				#pragma shader_feature_local _DIFFUSE_ON
				#pragma shader_feature_local _UDON_MESH_ARRAYS_ON
				#pragma shader_feature_local _METALLICMAP
				#pragma shader_feature_local _GLOSSINESSMAP
				#pragma shader_feature_local _BUMPMAP
				#pragma shader_feature_local _REFLECTIONS_ON
				#pragma shader_feature_local _SPECULARS_ON
				#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
				#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
				#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex.SampleBias(samplerTex,coord,bias)
				#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex.SampleGrad(samplerTex,coord,ddx,ddy)
				#define SAMPLE_TEXTURE3D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
				#define SAMPLE_TEXTURE2D_ARRAY(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
				#else//ASE Sampling Macros
				#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
				#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex2Dlod(tex,float4(coord,0,lod))
				#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex2Dbias(tex,float4(coord,0,bias))
				#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex2Dgrad(tex,coord,ddx,ddy)
				#define SAMPLE_TEXTURE3D(tex,samplerTex,coord) tex3D(tex,coord)
				#define SAMPLE_TEXTURE2D_ARRAY(tex,samplertex,coord) tex2DArray(tex,coord)
				#endif//ASE Sampling Macros
				


				#if defined(ASE_WRITE_DEPTH_CONSERVATIVE) && (SHADER_TARGET >= 45)
					#define ASE_SV_DEPTH SV_DepthLessEqual
					#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
				#else
					#define ASE_SV_DEPTH SV_Depth
					#define ASE_SV_POSITION_QUALIFIERS
				#endif

				struct appdata
				{
					float4 vertex : POSITION;
					float3 normal : NORMAL;
					float4 tangent : TANGENT;
					float4 ase_texcoord : TEXCOORD0;
					float4 ase_texcoord3 : TEXCOORD3;
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct v2f
				{
					ASE_SV_POSITION_QUALIFIERS float4 pos : SV_POSITION;
					float4 ase_texcoord : TEXCOORD0;
					float4 ase_texcoord1 : TEXCOORD1;
					float4 ase_texcoord2 : TEXCOORD2;
					float4 ase_texcoord3 : TEXCOORD3;
					float4 ase_texcoord4 : TEXCOORD4;
					float4 ase_texcoord5 : TEXCOORD5;
					UNITY_VERTEX_INPUT_INSTANCE_ID
					UNITY_VERTEX_OUTPUT_STEREO
				};

				uniform float _Offset;
				uniform float _EmissionFlags;
				uniform float _CATEGORYEMISSION;
				uniform float _CATEGORYSPACEEMISSION;
				uniform float _CATEGORY_SURFACEOPTIONS;
				uniform float _CATEGORYSPACESURFACEOPTIONS;
				uniform float _CATEGORYSPACECOLORGRADING;
				uniform float _CATEGORYCOLORGRADING;
				uniform float _CATEGORYSPACESPECIALEFFECTS;
				uniform float _CATEGORYSPECIALEFFECTS;
				UNITY_DECLARE_TEX3D_NOSAMPLER(_LUT);
				SamplerState sampler_LUT;
				uniform float _CATEGORYLIGHTING;
				uniform float _CATEGORYSPACELIGHTING;
				uniform float _CATEGORYSUBSURFACESCATTERING;
				uniform float _CATEGORYSPACESUBSURFACESCATTERING;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MainTex);
				SamplerState sampler_MainTex;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_BumpMap);
				SamplerState sampler_BumpMap;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MetallicMap);
				SamplerState sampler_MetallicMap;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_GlossinessMap);
				SamplerState sampler_GlossinessMap;
				uniform half4 _Color;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(_UdonAlbedoArray);
				SamplerState sampler_UdonAlbedoArray;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(_TextureSample0);
				SamplerState sampler_TextureSample0;
				uniform float _Metallic;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(_UdonRoughnessArray);
				SamplerState sampler_UdonRoughnessArray;
				uniform float _Glossiness;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(_UdonNormalArray);
				SamplerState sampler_UdonNormalArray;
				uniform float4 _SubsurfaceColor;
				uniform float _Thickness;
				uniform float _LightGroupMask;
				uniform float _IsDynamicMesh;
				uniform float3 _EmissionColor;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_EmissionMap);
				SamplerState sampler_EmissionMap;
				uniform float _EmissionIntensity;


				
				v2f vert( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					o.ase_texcoord2.xyz = ase_positionWS;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					o.ase_texcoord3.xyz = ase_normalWS;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					o.ase_texcoord4.xyz = ase_tangentWS;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					o.ase_texcoord5.xyz = ase_bitangentWS;
					
					o.ase_texcoord = v.ase_texcoord;
					o.ase_texcoord1 = v.ase_texcoord3;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord2.w = 0;
					o.ase_texcoord3.w = 0;
					o.ase_texcoord4.w = 0;
					o.ase_texcoord5.w = 0;

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

					o.pos = UnityObjectToClipPos( v.vertex );

					#if defined( ASE_SHADOWS )
						UNITY_TRANSFER_SHADOW( o, v.texcoord );
					#endif
					return o;
				}

				half4 frag( v2f IN 
							#if defined( ASE_WRITE_DEPTH )
								, out float outputDepth : SV_Depth
							#endif
				) : SV_Target
				{
					UNITY_SETUP_INSTANCE_ID( IN );
					UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

					float4 ScreenPosNorm = float4( IN.pos.xy * ( _ScreenParams.zw - 1.0 ), IN.pos.zw );
					float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, IN.pos.z ) * IN.pos.w;
					float4 ScreenPos = ComputeScreenPos( ClipPos );

					float3 _Vector0 = float3(0,0,0);
					float localLayeredLightmapLighting97_g60075 = ( 0.0 );
					float4 texCoord2426_g1 = IN.ase_texcoord;
					texCoord2426_g1.xy = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
					float2 MainUV2420_g1 = (texCoord2426_g1).xy;
					float4 texCoord3368_g1 = IN.ase_texcoord1;
					texCoord3368_g1.xy = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
					float4 break3395_g1 = round( texCoord3368_g1 );
					float3 staticSwitch3388_g1 = ( float3 )0;
					#ifdef _UDON_MESH_ARRAYS_ON
					{
						float Index_Albedo3367_g1 = break3395_g1.x;
						float4 tex2DArrayNode3373_g1 = SAMPLE_TEXTURE2D_ARRAY( _UdonAlbedoArray, sampler_UdonAlbedoArray, float3(MainUV2420_g1,Index_Albedo3367_g1) );
						staticSwitch3388_g1 = tex2DArrayNode3373_g1.rgb;
					}
					#else
					{
						float2 uv_MainTex907_g1 = IN.ase_texcoord.xy;
						float4 tex2DNode907_g1 = SAMPLE_TEXTURE2D( _MainTex, sampler_MainTex, uv_MainTex907_g1 );
						staticSwitch3388_g1 = tex2DNode907_g1.rgb;
					}
					#endif
					float4 temp_output_3155_0_g1 = ( _Color * float4( staticSwitch3388_g1 , 0.0 ) );
					float3 Albedo6_g1 = (temp_output_3155_0_g1).rgb;
					float3 Color97_g60075 = Albedo6_g1;
					float staticSwitch3392_g1 = ( float )0;
					#ifdef _UDON_MESH_ARRAYS_ON
					{
						float2 uv3_TextureSample03385_g1 = IN.ase_texcoord1.xy;
						float Index_Metallic3382_g1 = break3395_g1.z;
						float4 tex2DArrayNode3385_g1 = SAMPLE_TEXTURE2D_ARRAY( _TextureSample0, sampler_TextureSample0, float3(uv3_TextureSample03385_g1,Index_Metallic3382_g1) );
						staticSwitch3392_g1 = tex2DArrayNode3385_g1.r;
					}
					#else
					{
						float4 tex2DNode48_g1 = SAMPLE_TEXTURE2D( _MetallicMap, sampler_MetallicMap, MainUV2420_g1 );
						staticSwitch3392_g1 = tex2DNode48_g1.r;
					}
					#endif
					float staticSwitch846_g1 = ( float )0;
					#ifdef _METALLICMAP
					{
						staticSwitch846_g1 = staticSwitch3392_g1;
					}
					#else
					{
						staticSwitch846_g1 = _Metallic;
					}
					#endif
					float Metallic1239_g1 = staticSwitch846_g1;
					float Metallic97_g60075 = Metallic1239_g1;
					float staticSwitch3393_g1 = ( float )0;
					#ifdef _UDON_MESH_ARRAYS_ON
					{
						float Index_Roughness3379_g1 = break3395_g1.w;
						float4 tex2DArrayNode3376_g1 = SAMPLE_TEXTURE2D_ARRAY( _UdonRoughnessArray, sampler_UdonRoughnessArray, float3(MainUV2420_g1,Index_Roughness3379_g1) );
						staticSwitch3393_g1 = tex2DArrayNode3376_g1.r;
					}
					#else
					{
						float4 tex2DNode64_g1 = SAMPLE_TEXTURE2D( _GlossinessMap, sampler_GlossinessMap, MainUV2420_g1 );
						staticSwitch3393_g1 = tex2DNode64_g1.r;
					}
					#endif
					float staticSwitch845_g1 = ( float )0;
					#ifdef _GLOSSINESSMAP
					{
						staticSwitch845_g1 = staticSwitch3393_g1;
					}
					#else
					{
						staticSwitch845_g1 = _Glossiness;
					}
					#endif
					float Roughness1399_g1 = staticSwitch845_g1;
					float Roughness97_g60075 = Roughness1399_g1;
					float3 ase_positionWS = IN.ase_texcoord2.xyz;
					float3 ase_viewVectorWS = ( ( unity_OrthoParams.w == 0 ) ? _WorldSpaceCameraPos - ase_positionWS : UNITY_MATRIX_V[ 2 ].xyz );
					float3 ase_viewDirWS = normalize( ase_viewVectorWS );
					float3 View_Direction2511_g1 = ase_viewDirWS;
					float3 ViewDir97_g60075 = View_Direction2511_g1;
					float3 World_Position2505_g1 = ase_positionWS;
					float3 WorldPos97_g60075 = World_Position2505_g1;
					float3 ase_normalWS = IN.ase_texcoord3.xyz;
					float3 Default_Normal3336_g1 = ase_normalWS;
					float3 DefaultNormal97_g60075 = Default_Normal3336_g1;
					float3 staticSwitch3391_g1 = ( float3 )0;
					#ifdef _UDON_MESH_ARRAYS_ON
					{
						float2 uv3_UdonNormalArray3386_g1 = IN.ase_texcoord1.xy;
						float Index_Normal3380_g1 = break3395_g1.y;
						float4 tex2DArrayNode3386_g1 = SAMPLE_TEXTURE2D_ARRAY( _UdonNormalArray, sampler_UdonNormalArray, float3(uv3_UdonNormalArray3386_g1,Index_Normal3380_g1) );
						staticSwitch3391_g1 = tex2DArrayNode3386_g1.rgb;
					}
					#else
					{
						float3 tex2DNode830_g1 = UnpackNormal( SAMPLE_TEXTURE2D( _BumpMap, sampler_BumpMap, MainUV2420_g1 ) );
						staticSwitch3391_g1 = tex2DNode830_g1;
					}
					#endif
					float3 staticSwitch980_g1 = ( float3 )0;
					#ifdef _BUMPMAP
					{
						staticSwitch980_g1 = staticSwitch3391_g1;
					}
					#else
					{
						staticSwitch980_g1 = float3( 0, 0, 1 );
					}
					#endif
					float3 normalizeResult2878_g1 = normalize( staticSwitch980_g1 );
					float3 Normal700_g1 = normalizeResult2878_g1;
					float3 ase_tangentWS = IN.ase_texcoord4.xyz;
					float3 ase_bitangentWS = IN.ase_texcoord5.xyz;
					float3 tanToWorld0 = float3( ase_tangentWS.x, ase_bitangentWS.x, ase_normalWS.x );
					float3 tanToWorld1 = float3( ase_tangentWS.y, ase_bitangentWS.y, ase_normalWS.y );
					float3 tanToWorld2 = float3( ase_tangentWS.z, ase_bitangentWS.z, ase_normalWS.z );
					float3 tanNormal2504_g1 = Normal700_g1;
					float3 worldNormal2504_g1 = normalize( float3( dot( tanToWorld0, tanNormal2504_g1 ), dot( tanToWorld1, tanNormal2504_g1 ), dot( tanToWorld2, tanNormal2504_g1 ) ) );
					float3 World_Normal2508_g1 = worldNormal2504_g1;
					float3 WorldNormal97_g60075 = World_Normal2508_g1;
					float3 Subsurface_Color3358_g1 = _SubsurfaceColor.rgb;
					float3 SubsurfaceColor97_g60075 = Subsurface_Color3358_g1;
					float Thickness97_g60075 = _Thickness;
					float2 MainUV97_g60075 = MainUV2420_g1;
					float2 LightmapUV2361_g1 = (texCoord2426_g1).zw;
					float2 LightmapUV97_g60075 = LightmapUV2361_g1;
					float LightGroupMask97_g60075 = _LightGroupMask;
					float IsDynamicMesh97_g60075 = _IsDynamicMesh;
					float3 Diffuse97_g60075 = float3( 0,0,0 );
					float3 Specular97_g60075 = float3( 0,0,0 );
					float3 Reflection97_g60075 = float3( 0,0,0 );
					LayeredLightmapLighting( Color97_g60075 , Metallic97_g60075 , Roughness97_g60075 , ViewDir97_g60075 , WorldPos97_g60075 , DefaultNormal97_g60075 , WorldNormal97_g60075 , SubsurfaceColor97_g60075 , Thickness97_g60075 , MainUV97_g60075 , LightmapUV97_g60075 , LightGroupMask97_g60075 , IsDynamicMesh97_g60075 , Diffuse97_g60075 , Specular97_g60075 , Reflection97_g60075 );
					#ifdef _DIFFUSE_ON
					float3 staticSwitch3319_g1 = Diffuse97_g60075;
					#else
					float3 staticSwitch3319_g1 = _Vector0;
					#endif
					float3 Diffuse2560_g1 = staticSwitch3319_g1;
					#ifdef _REFLECTIONS_ON
					float3 staticSwitch3318_g1 = Reflection97_g60075;
					#else
					float3 staticSwitch3318_g1 = _Vector0;
					#endif
					float3 Reflections1419_g1 = staticSwitch3318_g1;
					float4 tex2DNode81_g1 = SAMPLE_TEXTURE2D( _EmissionMap, sampler_EmissionMap, MainUV2420_g1 );
					float3 Emission86_g1 = ( _EmissionColor * tex2DNode81_g1.rgb * _EmissionIntensity );
					float4 staticSwitch1_g60057 = ( float4 )0;
					#ifdef SHADER_API_MOBILE
					{
						staticSwitch1_g60057 = float4( ( Diffuse2560_g1 + Reflections1419_g1 + Emission86_g1 ) , 0.0 );
					}
					#else
					{
						#ifdef _SPECULARS_ON
						float3 staticSwitch3317_g1 = Specular97_g60075;
						#else
						float3 staticSwitch3317_g1 = _Vector0;
						#endif
						float3 Speculars3240_g1 = staticSwitch3317_g1;
						staticSwitch1_g60057 = float4( ( Diffuse2560_g1 + Speculars3240_g1 + Reflections1419_g1 + Emission86_g1 ) , 0.0 );
					}
					#endif
					float4 Color357_g60073 = staticSwitch1_g60057;
					float4 staticSwitch359_g60073 = ( float4 )0;
					#ifdef SHADER_API_MOBILE
					{
						float4 LUT51_g60073 = SAMPLE_TEXTURE3D( _LUT, sampler_LUT, ( ( log10( ( ( (Color357_g60073).xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 ) );
						staticSwitch359_g60073 = LUT51_g60073;
					}
					#else
					{
						staticSwitch359_g60073 = Color357_g60073;
					}
					#endif
					

					float3 Color = staticSwitch359_g60073.xyz;
					float Alpha = 1;
					half AlphaClipThreshold = 0.5;
					half AlphaClipThresholdShadow = 0.5;

					#if defined( ASE_WRITE_DEPTH )
						outputDepth = IN.pos.z;
					#endif

					#ifdef _ALPHATEST_ON
						clip( Alpha - AlphaClipThreshold );
					#endif

				#if defined( ASE_SURFACE_TRANSPARENT ) || defined( ASE_OPAQUE_KEEP_ALPHA )
					return half4( Color, Alpha );
				#else
					return half4( Color, 1.0 );
				#endif
				}
			ENDCG
		}

	
	}
	
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
	
	Fallback Off
}
/*ASEBEGIN
Version=19914
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":6533,"pos":[-16,-1120],"params":["Inherit","False","Property","_Offset","Offset","41","0","Create","True","0","0","0","True","0","False","Object","-1","","0","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":6670,"pos":[-64,-1280],"params":["Inherit","False","Meenphie","0","","1","5cc94f8f8e02d10598af4792603e1e57","6,1008,0,2632,0,3311,0,2670,0,2635,0,2619,0","0","3","FLOAT4","624","FLOAT","156","FLOAT","427"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":6649,"pos":[256,-1280],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","7","New Amplify Shader","0770190933193b94aaa3065e307002fa","True","ExtraPrePass","0","0","ExtraPrePass","6","False","True","1","1","False","","0","False","","1","1","False","","0","False","","True","1","False","","1","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","False","True","True","0","False","","0","False","","True","1","False","","True","1","RenderType=Opaque=RenderType","True","3","True","12","all","0","False","True","1","1","False","","0","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","False","False","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":6650,"pos":[256,-1280],"params":["Float","False","True","-1","3","AmplifyShaderEditor.MaterialInspector","0","7","Meenphie/Standard/Opaque","0770190933193b94aaa3065e307002fa","True","Unlit","0","1","Unlit","8","False","True","1","1","False","","0","False","","1","1","False","","0","False","","True","1","False","","1","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","False","True","True","0","False","","0","False","","True","1","False","","True","1","RenderType=Opaque=RenderType","True","5","True","12","all","0","False","True","1","1","False","","0","False","","1","1","False","","0","False","","True","1","False","","1","False","","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","True","True","1","False","","True","3","False","","True","True","0","True","_Offset","0","True","_Offset","False","False","False","False","0","","0","0","Standard","10","Surface","0","0","  Keep Alpha","0","0","  Blend","0","0","Alpha Clipping","0","0","  Use Shadow Threshold","0","0","Cast Shadows","0","639230877298842180","Write Depth","0","0","  Conservative","0","0","Extra Pre Pass","0","0","Vertex Position","1","0","0","3","False","True","False","False","","True","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":6651,"pos":[256,-1280],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","7","New Amplify Shader","0770190933193b94aaa3065e307002fa","True","ShadowCaster","0","2","ShadowCaster","0","False","True","1","1","False","","0","False","","1","1","False","","0","False","","True","1","False","","1","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","False","True","True","0","False","","0","False","","True","1","False","","True","1","RenderType=Opaque=RenderType","True","3","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","False","","True","3","False","","False","False","True","1","LightMode=ShadowCaster","False","False","0","","0","0","Standard","0","False","0"]}
{"wire":[6650,0,6670,624]}
ASEEND*/
//CHKSM=832B8C8AB769E8DE673450EAF01290D5855AC5A7