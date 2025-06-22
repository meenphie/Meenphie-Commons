// Made with Amplify Shader Editor v1.9.9.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Double Layer Surface"
{
	Properties
	{
		[Meenphie_DrawerCategory(SURFACE OPTIONS,true,0,0)] _CATEGORY_SURFACEOPTIONS( "CATEGORY_SURFACEOPTIONS", Float ) = 1
		_Color( "DIffuse Color", Color ) = ( 0.9058824, 0.9058824, 0.9058824, 1 )
		[NoScaleOffset][Meenphie_DrawerTextureSingleLine] _MainTex( "Diffuse Map", 2D ) = "white" {}
		[Meenphie_DrawerTextureSingleLine] _BumpMap( "Normal Map", 2D ) = "bump" {}
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESURFACEOPTIONS( "CATEGORY SPACE SURFACEOPTIONS", Float ) = 0
		[Meenphie_DrawerCategory(EMISSION,true,0,0)] _CATEGORYEMISSION( "CATEGORY EMISSION", Float ) = 1
		[Toggle( _EMISSION_ON )] _EMISSION( "Emission Enabled", Float ) = 0
		[HDR][Gamma] _EmissionColor( "Emission Color", Color ) = ( 0, 0, 0 )
		[NoScaleOffset][Meenphie_DrawerTextureSingleLine] _EmissionMap( "Emission Map", 2D ) = "black" {}
		_EmissionIntensity( "Intensity", Float ) = 0
		[Meenphie_DrawerEmissionFlags] _EmissionFlags( "Global Illumination", Float ) = 2
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACEEMISSION( "CATEGORY SPACE EMISSION", Float ) = 0
		[Meenphie_DrawerCategory(LIGHTMAPPING,true,0,0)] _CATEGORYLIGHTMAPPING( "CATEGORY LIGHTMAPPING", Float ) = 1
		[Toggle( _LIGHTMAPPING_ON )] _LIGHTMAPPING( "Lightmapping Enabled", Float ) = 0
		[KeywordEnum( Simple,RNM,RNMLerp )] _LIGHTMAPPINGMODE( "Lightmap Mode", Float ) = 0
		[Meenphie_DrawerTextureSingleLine] _Lightmap( "Lightmap", 2D ) = "gray" {}
		[Meenphie_DrawerTextureSingleLine] _RNMX0( "RNMX 0", 2D ) = "gray" {}
		[Meenphie_DrawerTextureSingleLine] _RNMY0( "RNMY 0", 2D ) = "gray" {}
		[Meenphie_DrawerTextureSingleLine] _RNMZ0( "RNMZ 0", 2D ) = "gray" {}
		[Meenphie_DrawerTextureSingleLine] _RNMX1( "RNMX 1", 2D ) = "gray" {}
		[Meenphie_DrawerTextureSingleLine] _RNMY1( "RNMY 1", 2D ) = "gray" {}
		[Meenphie_DrawerTextureSingleLine] _RNMZ1( "RNMZ 1", 2D ) = "gray" {}
		_RNMScale( "RNM Scale", Float ) = 2
		_LightmapLerp( "LightmapLerp", Range( 0, 1 ) ) = 0
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACELIGHTMAPPING( "CATEGORY SPACE LIGHTMAPPING", Float ) = 0
		_BaseColor1( "Base Color 1", Color ) = ( 1, 0.9310344, 0, 0 )
		_BaseColor2( "Base Color 2", Color ) = ( 1, 0.9310344, 0, 0 )
		_BaseMetallic( "Base Metallic", Range( 0, 1 ) ) = 0
		_BaseSmoothness( "Base Smoothness", Range( 0, 1 ) ) = 0
		_BaseOcclusion( "Base Occlusion", Range( 0, 1 ) ) = 0
		_FlakesRGBcolorvariationAmask( "Flakes (RGB = color variation, A = mask)", 2D ) = "white" {}
		_FlakeColorVariationAmount( "Flake Color Variation Amount", Range( 0, 1 ) ) = 0
		_FlakesColor1( "Flakes Color 1", Color ) = ( 1, 0.9310344, 0, 0 )
		_FlakesColor2( "Flakes Color 2", Color ) = ( 1, 0.9310344, 0, 0 )
		_FlakesMetallic( "Flakes Metallic", Range( 0, 1 ) ) = 0
		_FlakesSmoothness( "Flakes Smoothness", Range( 0, 1 ) ) = 0
		_FlakesNormal( "Flakes Normal", 2D ) = "bump" {}
		_FlakesBump( "Flakes Bump", Range( 0, 1 ) ) = 0
		_CoatNormal( "Coat Normal", 2D ) = "bump" {}
		_CoatBump( "Coat Bump", Range( 0, 1 ) ) = 0
		_CoatAmount( "Coat Amount", Range( 0, 1 ) ) = 0
		_CoatSmoothness( "Coat Smoothness", Range( 0, 1 ) ) = 0
		[HideInInspector] _texcoord3( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
		[Header(Forward Rendering Options)]
		[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		[ToggleOff] _GlossyReflections("Reflections", Float) = 1.0
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "ForceNoShadowCasting" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 3.5
		#pragma shader_feature _SPECULARHIGHLIGHTS_OFF
		#pragma shader_feature _GLOSSYREFLECTIONS_OFF
		#pragma shader_feature _LIGHTMAP_DEBUG_MODE_ON
		#pragma shader_feature_local _EMISSION_ON
		#pragma shader_feature_local _LIGHTMAPPING_ON
		#pragma shader_feature_local _LIGHTMAPPINGMODE_SIMPLE _LIGHTMAPPINGMODE_RNM _LIGHTMAPPINGMODE_RNMLERP
		#define ASE_VERSION 19901
		#pragma only_renderers d3d11 glcore vulkan 
		#pragma surface surf StandardCustomLighting keepalpha exclude_path:deferred noambient nodynlightmap nodirlightmap 
		struct Input
		{
			float2 uv_texcoord;
			float2 uv3_texcoord3;
			float3 worldNormal;
			INTERNAL_DATA
			float3 worldPos;
			float4 vertexColor : COLOR;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform float _EmissionFlags;
		uniform float _CATEGORYSPACEEMISSION;
		uniform float _CATEGORYSPACESURFACEOPTIONS;
		uniform float _CATEGORYSPACELIGHTMAPPING;
		uniform float _CATEGORYLIGHTMAPPING;
		uniform float _CATEGORYEMISSION;
		uniform float _CATEGORY_SURFACEOPTIONS;
		uniform float4 _Color;
		uniform sampler2D _MainTex;
		uniform sampler2D _Lightmap;
		uniform float4 _Lightmap_ST;
		float4 _Lightmap_TexelSize;
		uniform sampler2D _BumpMap;
		uniform float4 _BumpMap_ST;
		float4 _BumpMap_TexelSize;
		uniform float _RNMScale;
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
		uniform float _LightmapLerp;
		uniform float3 _EmissionColor;
		uniform sampler2D _EmissionMap;
		uniform float _EmissionIntensity;
		uniform float4 _BaseColor1;
		uniform float4 _BaseColor2;
		uniform float4 _FlakesColor1;
		uniform float4 _FlakesColor2;
		uniform sampler2D _FlakesRGBcolorvariationAmask;
		uniform float4 _FlakesRGBcolorvariationAmask_ST;
		uniform float _FlakeColorVariationAmount;
		uniform sampler2D _FlakesNormal;
		uniform float _FlakesBump;
		uniform float _BaseMetallic;
		uniform float _FlakesMetallic;
		uniform float _BaseSmoothness;
		uniform float _FlakesSmoothness;
		uniform float _BaseOcclusion;
		uniform sampler2D _CoatNormal;
		uniform float4 _CoatNormal_ST;
		uniform float _CoatBump;
		uniform float _CoatSmoothness;
		uniform float _CoatAmount;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			SurfaceOutputStandard s2807 = (SurfaceOutputStandard ) 0;
			float3 ase_positionWS = i.worldPos;
			float3 ase_viewVectorWS = ( _WorldSpaceCameraPos.xyz - ase_positionWS );
			float3 ase_viewDirWS = normalize( ase_viewVectorWS );
			float3 ase_normalWS = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float fresnelNdotV2762 = dot( ase_normalWS, ase_viewDirWS );
			float fresnelNode2762 = ( 0.05 + 1.0 * pow( 1.0 - fresnelNdotV2762, 1.0 ) );
			float4 lerpResult2788 = lerp( _BaseColor1 , _BaseColor2 , fresnelNode2762);
			float4 lerpResult2769 = lerp( _FlakesColor1 , _FlakesColor2 , fresnelNode2762);
			float2 uv_FlakesRGBcolorvariationAmask = i.uv_texcoord * _FlakesRGBcolorvariationAmask_ST.xy + _FlakesRGBcolorvariationAmask_ST.zw;
			float4 tex2DNode2776 = tex2D( _FlakesRGBcolorvariationAmask, uv_FlakesRGBcolorvariationAmask );
			float4 lerpResult2789 = lerp( lerpResult2769 , tex2DNode2776 , _FlakeColorVariationAmount);
			float FlakeMask2792 = tex2DNode2776.a;
			float4 lerpResult2797 = lerp( lerpResult2788 , lerpResult2789 , FlakeMask2792);
			s2807.Albedo = lerpResult2797.rgb;
			s2807.Normal = normalize( WorldNormalVector( i , UnpackScaleNormal( tex2D( _FlakesNormal, uv_FlakesRGBcolorvariationAmask ), _FlakesBump ) ) );
			s2807.Emission = float3( 0,0,0 );
			float lerpResult2801 = lerp( _BaseMetallic , _FlakesMetallic , FlakeMask2792);
			s2807.Metallic = lerpResult2801;
			float lerpResult2805 = lerp( _BaseSmoothness , _FlakesSmoothness , FlakeMask2792);
			s2807.Smoothness = lerpResult2805;
			float fresnelNdotV2768 = dot( ase_normalWS, ase_viewDirWS );
			float fresnelNode2768 = ( 0.05 + 1.0 * pow( 1.0 - fresnelNdotV2768, 5.0 ) );
			float lerpResult2785 = lerp( i.vertexColor.r , 1.0 , _BaseOcclusion);
			s2807.Occlusion = ( saturate( ( 1.0 - fresnelNode2768 ) ) * lerpResult2785 );

			data.light = gi.light;

			UnityGI gi2807 = gi;
			#ifdef UNITY_PASS_FORWARDBASE
			Unity_GlossyEnvironmentData g2807 = UnityGlossyEnvironmentSetup( s2807.Smoothness, data.worldViewDir, s2807.Normal, float3(0,0,0));
			gi2807 = UnityGlobalIllumination( data, s2807.Occlusion, s2807.Normal, g2807 );
			#endif

			float3 surfResult2807 = LightingStandard ( s2807, viewDir, gi2807 ).rgb;
			surfResult2807 += s2807.Emission;

			#ifdef UNITY_PASS_FORWARDADD//2807
			surfResult2807 -= s2807.Emission;
			#endif//2807
			SurfaceOutputStandardSpecular s2808 = (SurfaceOutputStandardSpecular ) 0;
			s2808.Albedo = float3( 0,0,0 );
			float2 uv_CoatNormal = i.uv_texcoord * _CoatNormal_ST.xy + _CoatNormal_ST.zw;
			s2808.Normal = normalize( WorldNormalVector( i , UnpackScaleNormal( tex2D( _CoatNormal, uv_CoatNormal ), _CoatBump ) ) );
			s2808.Emission = float3( 0,0,0 );
			float3 temp_cast_7 = (1.0).xxx;
			s2808.Specular = temp_cast_7;
			s2808.Smoothness = _CoatSmoothness;
			s2808.Occlusion = 1.0;

			data.light = gi.light;

			UnityGI gi2808 = gi;
			#ifdef UNITY_PASS_FORWARDBASE
			Unity_GlossyEnvironmentData g2808 = UnityGlossyEnvironmentSetup( s2808.Smoothness, data.worldViewDir, s2808.Normal, float3(0,0,0));
			gi2808 = UnityGlobalIllumination( data, s2808.Occlusion, s2808.Normal, g2808 );
			#endif

			float3 surfResult2808 = LightingStandardSpecular ( s2808, viewDir, gi2808 ).rgb;
			surfResult2808 += s2808.Emission;

			#ifdef UNITY_PASS_FORWARDADD//2808
			surfResult2808 -= s2808.Emission;
			#endif//2808
			float3 lerpResult2809 = lerp( surfResult2807 , surfResult2808 , ( ( fresnelNode2768 * _CoatAmount ) * lerpResult2785 ));
			c.rgb = lerpResult2809;
			c.a = 1;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			o.Normal = float3(0,0,1);
			float3 temp_cast_0 = 0;
			float2 uv_MainTex259_g1 = i.uv_texcoord;
			float4 tex2DNode259_g1 = tex2D( _MainTex, uv_MainTex259_g1 );
			float3 temp_output_5_0_g1 = ( _Color.rgb * tex2DNode259_g1.rgb );
			float3 Albedo6_g1 = temp_output_5_0_g1;
			#ifdef _EMISSION_ON
				float3 staticSwitch691_g1 = Albedo6_g1;
			#else
				float3 staticSwitch691_g1 = temp_cast_0;
			#endif
			int White38_g1 = 1;
			float4 temp_cast_3 = White38_g1;
			float localBicubicPrepare2_g340 = ( 0.0 );
			float2 uv3_Lightmap = i.uv3_texcoord3 * _Lightmap_ST.xy + _Lightmap_ST.zw;
			float2 Input_UV100_g340 = uv3_Lightmap;
			float2 UV2_g340 = Input_UV100_g340;
			float4 TexelSize2_g340 = _Lightmap_TexelSize;
			float2 UV02_g340 = float2( 0,0 );
			float2 UV12_g340 = float2( 0,0 );
			float2 UV22_g340 = float2( 0,0 );
			float2 UV32_g340 = float2( 0,0 );
			float W02_g340 = 0;
			float W12_g340 = 0;
			{
			{
			 UV2_g340 = UV2_g340 * TexelSize2_g340.zw - 0.5;
			    float2 f = frac( UV2_g340 );
			    UV2_g340 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g340.x - 0.5, UV2_g340.x + 1.5, UV2_g340.y - 0.5, UV2_g340.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g340.xyxy;
			    UV02_g340 = off.xz;
			    UV12_g340 = off.yz;
			    UV22_g340 = off.xw;
			    UV32_g340 = off.yw;
			    W02_g340 = s.x / ( s.x + s.y );
			 W12_g340 = s.z / ( s.z + s.w );
			}
			}
			float4 lerpResult46_g340 = lerp( tex2D( _Lightmap, UV32_g340 ) , tex2D( _Lightmap, UV22_g340 ) , W02_g340);
			float4 lerpResult45_g340 = lerp( tex2D( _Lightmap, UV12_g340 ) , tex2D( _Lightmap, UV02_g340 ) , W02_g340);
			float4 lerpResult44_g340 = lerp( lerpResult46_g340 , lerpResult45_g340 , W12_g340);
			float4 Output_2D131_g340 = lerpResult44_g340;
			float3 appendResult139_g351 = (float3(sqrt( ( 3.0 / 2.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float localBicubicPrepare2_g352 = ( 0.0 );
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float2 Input_UV100_g352 = uv_BumpMap;
			float2 UV2_g352 = Input_UV100_g352;
			float4 TexelSize2_g352 = _BumpMap_TexelSize;
			float2 UV02_g352 = float2( 0,0 );
			float2 UV12_g352 = float2( 0,0 );
			float2 UV22_g352 = float2( 0,0 );
			float2 UV32_g352 = float2( 0,0 );
			float W02_g352 = 0;
			float W12_g352 = 0;
			{
			{
			 UV2_g352 = UV2_g352 * TexelSize2_g352.zw - 0.5;
			    float2 f = frac( UV2_g352 );
			    UV2_g352 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g352.x - 0.5, UV2_g352.x + 1.5, UV2_g352.y - 0.5, UV2_g352.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g352.xyxy;
			    UV02_g352 = off.xz;
			    UV12_g352 = off.yz;
			    UV22_g352 = off.xw;
			    UV32_g352 = off.yw;
			    W02_g352 = s.x / ( s.x + s.y );
			 W12_g352 = s.z / ( s.z + s.w );
			}
			}
			float temp_output_239_0_g352 = _RNMScale;
			float3 lerpResult46_g352 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV32_g352 ), temp_output_239_0_g352 ) , UnpackScaleNormal( tex2D( _BumpMap, UV22_g352 ), temp_output_239_0_g352 ) , W02_g352);
			float3 lerpResult45_g352 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV12_g352 ), temp_output_239_0_g352 ) , UnpackScaleNormal( tex2D( _BumpMap, UV02_g352 ), temp_output_239_0_g352 ) , W02_g352);
			float3 lerpResult44_g352 = lerp( lerpResult46_g352 , lerpResult45_g352 , W12_g352);
			float3 Output_2D131_g352 = lerpResult44_g352;
			float3 normalizeResult326_g351 = normalize( Output_2D131_g352 );
			float3 Normal_Map318_g351 = normalizeResult326_g351;
			float dotResult121_g351 = dot( appendResult139_g351 , Normal_Map318_g351 );
			float localStochasticTiling2_g356 = ( 0.0 );
			float2 uv3_RNMX0 = i.uv3_texcoord3 * _RNMX0_ST.xy + _RNMX0_ST.zw;
			float2 UV2_g356 = uv3_RNMX0;
			float4 TexelSize2_g356 = _RNMX0_TexelSize;
			float4 Offsets2_g356 = float4( 0,0,0,0 );
			float2 Weights2_g356 = float2( 0,0 );
			{
			UV2_g356 = UV2_g356 * TexelSize2_g356.zw - 0.5;
			float2 f = frac( UV2_g356 );
			UV2_g356 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g356.x - 0.5, UV2_g356.x + 1.5, UV2_g356.y - 0.5, UV2_g356.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g356 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g356.xyxy;
			Weights2_g356 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g353 = Offsets2_g356;
			float4 Input_FetchOffsets197_g357 = temp_output_1_34_g353;
			float2 temp_output_1_54_g353 = Weights2_g356;
			float2 Input_FetchWeights200_g357 = temp_output_1_54_g353;
			float2 break187_g357 = Input_FetchWeights200_g357;
			float4 lerpResult181_g357 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g357).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g357).xw ) , break187_g357.x);
			float4 lerpResult182_g357 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g357).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g357).xz ) , break187_g357.x);
			float4 lerpResult176_g357 = lerp( lerpResult181_g357 , lerpResult182_g357 , break187_g357.y);
			float4 Output_Fetch2D202_g357 = lerpResult176_g357;
			float3 appendResult146_g351 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g351 = dot( appendResult146_g351 , Normal_Map318_g351 );
			float4 Input_FetchOffsets197_g354 = temp_output_1_34_g353;
			float2 Input_FetchWeights200_g354 = temp_output_1_54_g353;
			float2 break187_g354 = Input_FetchWeights200_g354;
			float4 lerpResult181_g354 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g354).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g354).xw ) , break187_g354.x);
			float4 lerpResult182_g354 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g354).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g354).xz ) , break187_g354.x);
			float4 lerpResult176_g354 = lerp( lerpResult181_g354 , lerpResult182_g354 , break187_g354.y);
			float4 Output_Fetch2D202_g354 = lerpResult176_g354;
			float3 appendResult149_g351 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g351 = dot( appendResult149_g351 , Normal_Map318_g351 );
			float4 Input_FetchOffsets197_g355 = temp_output_1_34_g353;
			float2 Input_FetchWeights200_g355 = temp_output_1_54_g353;
			float2 break187_g355 = Input_FetchWeights200_g355;
			float4 lerpResult181_g355 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g355).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g355).xw ) , break187_g355.x);
			float4 lerpResult182_g355 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g355).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g355).xz ) , break187_g355.x);
			float4 lerpResult176_g355 = lerp( lerpResult181_g355 , lerpResult182_g355 , break187_g355.y);
			float4 Output_Fetch2D202_g355 = lerpResult176_g355;
			float4 temp_output_590_0_g1 = ( ( ( saturate( dotResult121_g351 ) * ( Output_Fetch2D202_g357 * 0.5 ) ) + ( saturate( dotResult122_g351 ) * ( Output_Fetch2D202_g354 * 0.5 ) ) ) + ( saturate( dotResult120_g351 ) * ( Output_Fetch2D202_g355 * 0.5 ) ) );
			float3 appendResult139_g349 = (float3(sqrt( ( 3.0 / 2.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float localBicubicPrepare2_g350 = ( 0.0 );
			float2 Input_UV100_g350 = uv_BumpMap;
			float2 UV2_g350 = Input_UV100_g350;
			float4 TexelSize2_g350 = _BumpMap_TexelSize;
			float2 UV02_g350 = float2( 0,0 );
			float2 UV12_g350 = float2( 0,0 );
			float2 UV22_g350 = float2( 0,0 );
			float2 UV32_g350 = float2( 0,0 );
			float W02_g350 = 0;
			float W12_g350 = 0;
			{
			{
			 UV2_g350 = UV2_g350 * TexelSize2_g350.zw - 0.5;
			    float2 f = frac( UV2_g350 );
			    UV2_g350 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g350.x - 0.5, UV2_g350.x + 1.5, UV2_g350.y - 0.5, UV2_g350.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g350.xyxy;
			    UV02_g350 = off.xz;
			    UV12_g350 = off.yz;
			    UV22_g350 = off.xw;
			    UV32_g350 = off.yw;
			    W02_g350 = s.x / ( s.x + s.y );
			 W12_g350 = s.z / ( s.z + s.w );
			}
			}
			float RNM_Scale447_g1 = _RNMScale;
			float temp_output_239_0_g350 = RNM_Scale447_g1;
			float3 lerpResult46_g350 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV32_g350 ), temp_output_239_0_g350 ) , UnpackScaleNormal( tex2D( _BumpMap, UV22_g350 ), temp_output_239_0_g350 ) , W02_g350);
			float3 lerpResult45_g350 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV12_g350 ), temp_output_239_0_g350 ) , UnpackScaleNormal( tex2D( _BumpMap, UV02_g350 ), temp_output_239_0_g350 ) , W02_g350);
			float3 lerpResult44_g350 = lerp( lerpResult46_g350 , lerpResult45_g350 , W12_g350);
			float3 Output_2D131_g350 = lerpResult44_g350;
			float3 normalizeResult326_g349 = normalize( Output_2D131_g350 );
			float3 Normal_Map318_g349 = normalizeResult326_g349;
			float dotResult121_g349 = dot( appendResult139_g349 , Normal_Map318_g349 );
			float localStochasticTiling2_g326 = ( 0.0 );
			float2 uv3_RNMX1 = i.uv3_texcoord3 * _RNMX1_ST.xy + _RNMX1_ST.zw;
			float2 UV2_g326 = uv3_RNMX1;
			float4 TexelSize2_g326 = _RNMX1_TexelSize;
			float4 Offsets2_g326 = float4( 0,0,0,0 );
			float2 Weights2_g326 = float2( 0,0 );
			{
			UV2_g326 = UV2_g326 * TexelSize2_g326.zw - 0.5;
			float2 f = frac( UV2_g326 );
			UV2_g326 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g326.x - 0.5, UV2_g326.x + 1.5, UV2_g326.y - 0.5, UV2_g326.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g326 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g326.xyxy;
			Weights2_g326 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g323 = Offsets2_g326;
			float4 Input_FetchOffsets197_g327 = temp_output_1_34_g323;
			float2 temp_output_1_54_g323 = Weights2_g326;
			float2 Input_FetchWeights200_g327 = temp_output_1_54_g323;
			float2 break187_g327 = Input_FetchWeights200_g327;
			float4 lerpResult181_g327 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g327).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g327).xw ) , break187_g327.x);
			float4 lerpResult182_g327 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g327).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g327).xz ) , break187_g327.x);
			float4 lerpResult176_g327 = lerp( lerpResult181_g327 , lerpResult182_g327 , break187_g327.y);
			float4 Output_Fetch2D202_g327 = lerpResult176_g327;
			float3 appendResult146_g349 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g349 = dot( appendResult146_g349 , Normal_Map318_g349 );
			float4 Input_FetchOffsets197_g324 = temp_output_1_34_g323;
			float2 Input_FetchWeights200_g324 = temp_output_1_54_g323;
			float2 break187_g324 = Input_FetchWeights200_g324;
			float4 lerpResult181_g324 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g324).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g324).xw ) , break187_g324.x);
			float4 lerpResult182_g324 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g324).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g324).xz ) , break187_g324.x);
			float4 lerpResult176_g324 = lerp( lerpResult181_g324 , lerpResult182_g324 , break187_g324.y);
			float4 Output_Fetch2D202_g324 = lerpResult176_g324;
			float3 appendResult149_g349 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g349 = dot( appendResult149_g349 , Normal_Map318_g349 );
			float4 Input_FetchOffsets197_g325 = temp_output_1_34_g323;
			float2 Input_FetchWeights200_g325 = temp_output_1_54_g323;
			float2 break187_g325 = Input_FetchWeights200_g325;
			float4 lerpResult181_g325 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g325).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g325).xw ) , break187_g325.x);
			float4 lerpResult182_g325 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g325).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g325).xz ) , break187_g325.x);
			float4 lerpResult176_g325 = lerp( lerpResult181_g325 , lerpResult182_g325 , break187_g325.y);
			float4 Output_Fetch2D202_g325 = lerpResult176_g325;
			float4 lerpResult442_g1 = lerp( temp_output_590_0_g1 , ( ( ( saturate( dotResult121_g349 ) * ( Output_Fetch2D202_g327 * 0.5 ) ) + ( saturate( dotResult122_g349 ) * ( Output_Fetch2D202_g324 * 0.5 ) ) ) + ( saturate( dotResult120_g349 ) * ( Output_Fetch2D202_g325 * 0.5 ) ) ) , _LightmapLerp);
			#if defined( _LIGHTMAPPINGMODE_SIMPLE )
				float4 staticSwitch565_g1 = Output_2D131_g340;
			#elif defined( _LIGHTMAPPINGMODE_RNM )
				float4 staticSwitch565_g1 = temp_output_590_0_g1;
			#elif defined( _LIGHTMAPPINGMODE_RNMLERP )
				float4 staticSwitch565_g1 = lerpResult442_g1;
			#else
				float4 staticSwitch565_g1 = Output_2D131_g340;
			#endif
			#ifdef _LIGHTMAPPING_ON
				float4 staticSwitch569_g1 = staticSwitch565_g1;
			#else
				float4 staticSwitch569_g1 = temp_cast_3;
			#endif
			float4 Lightmap46_g1 = staticSwitch569_g1;
			#ifdef _LIGHTMAPPING_ON
				float4 staticSwitch566_g1 = ( float4( Albedo6_g1 , 0.0 ) * Lightmap46_g1 );
			#else
				float4 staticSwitch566_g1 = float4( staticSwitch691_g1 , 0.0 );
			#endif
			float2 uv_EmissionMap81_g1 = i.uv_texcoord;
			float3 Emission86_g1 = ( ( _EmissionColor + tex2D( _EmissionMap, uv_EmissionMap81_g1 ).rgb ) * _EmissionIntensity );
			#ifdef _EMISSION_ON
				float4 staticSwitch572_g1 = ( staticSwitch566_g1 + float4( Emission86_g1 , 0.0 ) );
			#else
				float4 staticSwitch572_g1 = staticSwitch566_g1;
			#endif
			#ifdef _LIGHTMAP_DEBUG_MODE_ON
				float4 staticSwitch686_g1 = Lightmap46_g1;
			#else
				float4 staticSwitch686_g1 = staticSwitch572_g1;
			#endif
			o.Emission = staticSwitch686_g1.rgb;
		}

		ENDCG
	}
	Fallback "Fairplex/Standard Mobile"
	CustomEditor "Meenphie_ShaderGUI"
}
/*ASEBEGIN
Version=19901
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2761;-3664,-2352;Inherit;False;348.1;312.8;Comment;1;2762;Dual Toning Factor;1,1,1,1;0;0
Node;AmplifyShaderEditor.FresnelNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2762;-3632,-2304;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;1;FLOAT;0.05;False;2;FLOAT;1;False;3;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2763;-2720,-2656;Inherit;False;2602.156;1370.458;Comment;25;2807;2805;2801;2798;2797;2796;2795;2794;2793;2792;2791;2790;2789;2788;2786;2783;2780;2779;2778;2777;2776;2770;2769;2766;2765;Base Layer With Dual Toning Flakes;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2764;-2752,-784;Inherit;False;1024.147;552.1847;Simple fresnel blend;11;2800;2799;2785;2784;2782;2775;2774;2773;2772;2771;2768;Blend Factor;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2765;-2624,-1776;Float;False;Property;_FlakesColor1;Flakes Color 1;40;0;Create;True;0;0;0;False;0;False;1,0.9310344,0,0;0.7352942,0.02162632,0.3612324,0;False;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2766;-2624,-1584;Float;False;Property;_FlakesColor2;Flakes Color 2;41;0;Create;True;0;0;0;False;0;False;1,0.9310344,0,0;0.02162628,0.05607837,0.7352942,0;False;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.WireNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2767;-3024,-1536;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2770;-2656,-2192;Inherit;False;0;2776;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FresnelNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2768;-2704,-736;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;1;FLOAT;0.05;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2769;-2288,-1472;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2776;-2192,-2208;Inherit;True;Property;_FlakesRGBcolorvariationAmask;Flakes (RGB = color variation, A = mask);38;0;Create;True;0;0;0;False;0;False;-1;None;2741be98b31d56c43ad9cfbcaf99a799;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2771;-2400,-384;Float;False;Constant;_Float0;Float 0;17;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2772;-2736,-496;Float;False;Property;_CoatAmount;Coat Amount;48;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2773;-2400,-736;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2774;-2736,-368;Float;False;Property;_BaseOcclusion;Base Occlusion;37;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2775;-2400,-560;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2777;-1664,-1952;Float;False;Property;_FlakeColorVariationAmount;Flake Color Variation Amount;39;0;Create;True;0;0;0;False;0;False;0;0.08;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2778;-2080,-2608;Float;False;Property;_BaseColor1;Base Color 1;33;0;Create;True;0;0;0;False;0;False;1,0.9310344,0,0;0.3970578,0.1923269,0.03503461,0;False;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.WireNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2779;-1696,-1968;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2780;-2080,-2416;Float;False;Property;_BaseColor2;Base Color 2;34;0;Create;True;0;0;0;False;0;False;1,0.9310344,0,0;0.03503464,0.08247139,0.3970579,0;False;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2781;-1168,-1040;Inherit;False;1016.546;470.1129;This mirror layer that to mimc a coating layer;5;2808;2804;2803;2802;2787;Coating Layer (Specular);1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2792;-1808,-2096;Float;False;FlakeMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2782;-2384,-656;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2783;-1312,-1824;Float;False;Property;_BaseMetallic;Base Metallic;35;0;Create;True;0;0;0;False;0;False;0;0.6;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2784;-2160,-736;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2785;-2128,-400;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2786;-1216,-2064;Inherit;False;2792;FlakeMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2787;-1104,-928;Float;False;Property;_CoatBump;Coat Bump;47;0;Create;True;0;0;0;False;0;False;0;0.1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2788;-1344,-2352;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2789;-1360,-2192;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2790;-2672,-1872;Float;False;Property;_FlakesBump;Flakes Bump;45;0;Create;True;0;0;0;False;0;False;0;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2791;-1680,-1456;Float;False;Property;_FlakesSmoothness;Flakes Smoothness;43;0;Create;True;0;0;0;False;0;False;0;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2793;-1664,-1536;Float;False;Property;_BaseSmoothness;Base Smoothness;36;0;Create;True;0;0;0;False;0;False;0;0.4;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2794;-1648,-1392;Inherit;False;2792;FlakeMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2795;-1312,-1744;Float;False;Property;_FlakesMetallic;Flakes Metallic;42;0;Create;True;0;0;0;False;0;False;0;0.8;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2796;-1264,-1648;Inherit;False;2792;FlakeMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2797;-880,-2128;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2799;-1904,-736;Inherit;False;2;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2800;-1904,-592;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2801;-896,-1824;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2802;-752,-992;Inherit;True;Property;_CoatNormal;Coat Normal;46;0;Create;True;0;0;0;False;0;False;-1;None;b3d940e75e1f5d24684cd93a2758e1bf;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;0.5;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2803;-768,-688;Float;False;Property;_CoatSmoothness;Coat Smoothness;49;0;Create;True;0;0;0;False;0;False;0;0.95;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2804;-656,-768;Float;False;Constant;_Spec;Spec;18;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2805;-1312,-1488;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2798;-2240,-1920;Inherit;True;Property;_FlakesNormal;Flakes Normal;44;0;Create;True;0;0;0;False;0;False;-1;None;a268ab862991c4743a9281c69bb2c36a;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.WireNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2806;-112,-544;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomStandardSurface, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2807;-368,-1920;Inherit;False;Metallic;Tangent;6;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,1;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CustomStandardSurface, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2808;-400,-912;Inherit;False;Specular;Tangent;6;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,1;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2809;288,-960;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2810;320,-1216;Inherit;False;Meenphie Default;0;;1;b3ba55a08dd6b49c7be16c6f35cf2033;0;0;8;FLOAT3;625;FLOAT3;238;COLOR;624;FLOAT3;96;COLOR;97;COLOR;95;FLOAT;156;FLOAT;427
Node;AmplifyShaderEditor.StandardSurfaceOutputNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1092;656,-1200;Float;False;True;-1;3;Meenphie_ShaderGUI;0;0;CustomLighting;Meenphie/Double Layer Surface;False;False;False;False;True;False;False;True;True;False;False;False;False;False;False;True;False;False;True;True;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;ForwardOnly;3;d3d11;glcore;vulkan;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0.0001;0,0,0,0;VertexOffset;False;False;Cylindrical;False;True;Relative;0;Fairplex/Standard Mobile;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2767;0;2762;0
WireConnection;2769;0;2765;0
WireConnection;2769;1;2766;0
WireConnection;2769;2;2767;0
WireConnection;2776;1;2770;0
WireConnection;2773;0;2768;0
WireConnection;2779;0;2769;0
WireConnection;2792;0;2776;4
WireConnection;2782;0;2768;0
WireConnection;2782;1;2772;0
WireConnection;2784;0;2773;0
WireConnection;2785;0;2775;1
WireConnection;2785;1;2771;0
WireConnection;2785;2;2774;0
WireConnection;2788;0;2778;0
WireConnection;2788;1;2780;0
WireConnection;2788;2;2762;0
WireConnection;2789;0;2779;0
WireConnection;2789;1;2776;0
WireConnection;2789;2;2777;0
WireConnection;2797;0;2788;0
WireConnection;2797;1;2789;0
WireConnection;2797;2;2786;0
WireConnection;2799;0;2784;0
WireConnection;2799;1;2785;0
WireConnection;2800;0;2782;0
WireConnection;2800;1;2785;0
WireConnection;2801;0;2783;0
WireConnection;2801;1;2795;0
WireConnection;2801;2;2796;0
WireConnection;2802;5;2787;0
WireConnection;2805;0;2793;0
WireConnection;2805;1;2791;0
WireConnection;2805;2;2794;0
WireConnection;2798;1;2770;0
WireConnection;2798;5;2790;0
WireConnection;2806;0;2800;0
WireConnection;2807;0;2797;0
WireConnection;2807;1;2798;0
WireConnection;2807;3;2801;0
WireConnection;2807;4;2805;0
WireConnection;2807;5;2799;0
WireConnection;2808;1;2802;0
WireConnection;2808;3;2804;0
WireConnection;2808;4;2803;0
WireConnection;2809;0;2807;0
WireConnection;2809;1;2808;0
WireConnection;2809;2;2806;0
WireConnection;1092;2;2810;624
WireConnection;1092;13;2809;0
ASEEND*/
//CHKSM=589F6050BDF19963687A8D8552C8C077EE9A47B6