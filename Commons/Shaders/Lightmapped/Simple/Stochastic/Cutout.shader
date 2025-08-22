// Made with Amplify Shader Editor v1.9.9.4
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Lightmapped/Simple/Stochastic/Cutout"
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
		[Toggle] _EmissionEnabled( "Emission Enabled", Float ) = 0
		[HDR][Gamma] _EmissionColor( "Emission Color", Color ) = ( 0, 0, 0, 0 )
		[NoScaleOffset][SingleLineTexture] _EmissionMap( "Emission Map", 2D ) = "black" {}
		[Meenphie_DrawerEmissionFlags] _EmissionFlags( "Global Illumination", Float ) = 2
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACEEMISSION( "CATEGORY SPACE EMISSION", Float ) = 0
		[Meenphie_DrawerCategory(LIGHTMAPPING,true,0,0)] _CATEGORYLIGHTMAPPING( "CATEGORY LIGHTMAPPING", Float ) = 0
		[NoScaleOffset][SingleLineTexture] _Lightmap( "Lightmap", 2D ) = "black" {}
		[Toggle] _LightmapOcclusionEnabled( "Lightmap Occlusion Enabled", Float ) = 1
		_OcclusionPower( "Occlusion Power", Float ) = 1
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACELIGHTMAPPING( "CATEGORY SPACE LIGHTMAPPING", Float ) = 0
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord3( "", 2D ) = "white" {}
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0
		[HideInInspector] __dirty( "", Int ) = 1
		[Header(Forward Rendering Options)]
		[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		[ToggleOff] _GlossyReflections("Reflections", Float) = 1.0
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IgnoreProjector" = "True" "ForceNoShadowCasting" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 3.5
		#pragma shader_feature _SPECULARHIGHLIGHTS_OFF
		#pragma shader_feature _GLOSSYREFLECTIONS_OFF
		#pragma shader_feature_local_fragment _BUMPMAP
		#pragma shader_feature_local_fragment _METALLICMAP
		#pragma shader_feature_local_fragment _USEGEOMETRICANTIALIASING_ON
		#pragma shader_feature_local_fragment _GLOSSINESSMAP
		#define ASE_VERSION 19904
		#pragma surface surf Standard keepalpha exclude_path:deferred nodynlightmap nodirlightmap 
		struct Input
		{
			float2 uv_texcoord;
			float2 uv3_texcoord3;
			float3 worldNormal;
			INTERNAL_DATA
		};

		uniform float _CATEGORY_SURFACEOPTIONS;
		uniform float _CATEGORYSPACESURFACEOPTIONS;
		uniform float _EmissionFlags;
		uniform float _CATEGORYEMISSION;
		uniform float _CATEGORYSPACEEMISSION;
		uniform sampler2D _BumpMap;
		uniform float4 _BumpMap_ST;
		uniform float _NormalScale;
		uniform float4 _Color;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float4 _EmissionColor;
		uniform sampler2D _EmissionMap;
		uniform float4 _EmissionMap_ST;
		uniform float _EmissionEnabled;
		uniform float _Metallic;
		uniform sampler2D _Lightmap;
		uniform float4 _Lightmap_ST;
		float4 _Lightmap_TexelSize;
		uniform float _CATEGORYLIGHTMAPPING;
		uniform float _CATEGORYSPACELIGHTMAPPING;
		uniform sampler2D _MetallicMap;
		uniform float4 _MetallicMap_ST;
		uniform float _Glossiness;
		uniform sampler2D _GlossinessMap;
		uniform float4 _GlossinessMap_ST;
		uniform float _OcclusionPower;
		uniform float _LightmapOcclusionEnabled;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float2 temp_output_5_0_g2319 = uv_BumpMap;
			float2 UV633_g2319 = temp_output_5_0_g2319;
			float2 UV100_g2320 = UV633_g2319;
			float2 temp_output_51_0_g2320 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g2320 * float2( 3.464,3.464 ) ) );
			float2 break55_g2320 = frac( temp_output_51_0_g2320 );
			float temp_output_56_0_g2320 = ( ( 1.0 - break55_g2320.x ) - break55_g2320.y );
			float2 temp_output_52_0_g2320 = floor( temp_output_51_0_g2320 );
			float2 temp_output_125_0_g2320 = ( temp_output_52_0_g2320 + float2( 1,1 ) );
			float2 ifLocalVar87_g2320 = 0;
			if( temp_output_56_0_g2320 > 0.0 )
				ifLocalVar87_g2320 = temp_output_52_0_g2320;
			else if( temp_output_56_0_g2320 == 0.0 )
				ifLocalVar87_g2320 = temp_output_125_0_g2320;
			else if( temp_output_56_0_g2320 < 0.0 )
				ifLocalVar87_g2320 = temp_output_125_0_g2320;
			float3 temp_output_7_0_g2321 = frac( ( (ifLocalVar87_g2320).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
			float dotResult8_g2321 = dot( temp_output_7_0_g2321 , ( (temp_output_7_0_g2321).yzx + 33.33 ) );
			float3 temp_output_12_0_g2321 = ( temp_output_7_0_g2321 + dotResult8_g2321 );
			float2 temp_output_597_0_g2319 = ( UV100_g2320 + frac( ( ( (temp_output_12_0_g2321).xx + (temp_output_12_0_g2321).yz ) * (temp_output_12_0_g2321).zy ) ) );
			float2 DDX631_g2319 = ddx( temp_output_5_0_g2319 );
			float2 DDY632_g2319 = ddy( temp_output_5_0_g2319 );
			float Input_Scale617_g2319 = _NormalScale;
			float temp_output_65_0_g2320 = ( 0.0 - temp_output_56_0_g2320 );
			float ifLocalVar59_g2320 = 0;
			if( temp_output_56_0_g2320 <= 0.0 )
				ifLocalVar59_g2320 = temp_output_65_0_g2320;
			else
				ifLocalVar59_g2320 = temp_output_56_0_g2320;
			float temp_output_597_30_g2319 = ifLocalVar59_g2320;
			float2 temp_output_90_0_g2320 = ( temp_output_52_0_g2320 + float2( 0,1 ) );
			float2 temp_output_123_0_g2320 = ( temp_output_52_0_g2320 + float2( 1,0 ) );
			float2 ifLocalVar88_g2320 = 0;
			if( temp_output_56_0_g2320 > 0.0 )
				ifLocalVar88_g2320 = temp_output_90_0_g2320;
			else if( temp_output_56_0_g2320 == 0.0 )
				ifLocalVar88_g2320 = temp_output_123_0_g2320;
			else if( temp_output_56_0_g2320 < 0.0 )
				ifLocalVar88_g2320 = temp_output_123_0_g2320;
			float3 temp_output_7_0_g2322 = frac( ( (ifLocalVar88_g2320).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
			float dotResult8_g2322 = dot( temp_output_7_0_g2322 , ( (temp_output_7_0_g2322).yzx + 33.33 ) );
			float3 temp_output_12_0_g2322 = ( temp_output_7_0_g2322 + dotResult8_g2322 );
			float2 temp_output_597_26_g2319 = ( UV100_g2320 + frac( ( ( (temp_output_12_0_g2322).xx + (temp_output_12_0_g2322).yz ) * (temp_output_12_0_g2322).zy ) ) );
			float temp_output_66_0_g2320 = ( 1.0 - break55_g2320.y );
			float ifLocalVar60_g2320 = 0;
			if( temp_output_56_0_g2320 <= 0.0 )
				ifLocalVar60_g2320 = temp_output_66_0_g2320;
			else
				ifLocalVar60_g2320 = break55_g2320.y;
			float temp_output_597_28_g2319 = ifLocalVar60_g2320;
			float2 ifLocalVar89_g2320 = 0;
			if( temp_output_56_0_g2320 > 0.0 )
				ifLocalVar89_g2320 = temp_output_123_0_g2320;
			else if( temp_output_56_0_g2320 == 0.0 )
				ifLocalVar89_g2320 = temp_output_90_0_g2320;
			else if( temp_output_56_0_g2320 < 0.0 )
				ifLocalVar89_g2320 = temp_output_90_0_g2320;
			float3 temp_output_7_0_g2323 = frac( ( (ifLocalVar89_g2320).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
			float dotResult8_g2323 = dot( temp_output_7_0_g2323 , ( (temp_output_7_0_g2323).yzx + 33.33 ) );
			float3 temp_output_12_0_g2323 = ( temp_output_7_0_g2323 + dotResult8_g2323 );
			float2 temp_output_597_27_g2319 = ( UV100_g2320 + frac( ( ( (temp_output_12_0_g2323).xx + (temp_output_12_0_g2323).yz ) * (temp_output_12_0_g2323).zy ) ) );
			float temp_output_67_0_g2320 = ( 1.0 - break55_g2320.x );
			float ifLocalVar61_g2320 = 0;
			if( temp_output_56_0_g2320 <= 0.0 )
				ifLocalVar61_g2320 = temp_output_67_0_g2320;
			else
				ifLocalVar61_g2320 = break55_g2320.x;
			float temp_output_597_29_g2319 = ifLocalVar61_g2320;
			float3 Output_2D_Normal641_g2319 = ( ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_0_g2319, DDX631_g2319, DDY632_g2319 ), Input_Scale617_g2319 ) * temp_output_597_30_g2319 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_26_g2319, DDX631_g2319, DDY632_g2319 ), Input_Scale617_g2319 ) * temp_output_597_28_g2319 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_27_g2319, DDX631_g2319, DDY632_g2319 ), Input_Scale617_g2319 ) * float3( 0,0,0 ) * temp_output_597_29_g2319 ) );
			#ifdef _BUMPMAP
				float3 staticSwitch980_g2287 = Output_2D_Normal641_g2319;
			#else
				float3 staticSwitch980_g2287 = float3( 0, 0, 1 );
			#endif
			float3 Normal_Map700_g2287 = staticSwitch980_g2287;
			o.Normal = Normal_Map700_g2287;
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 temp_output_5_0_g2324 = uv_MainTex;
			float2 UV633_g2324 = temp_output_5_0_g2324;
			float2 UV100_g2325 = UV633_g2324;
			float2 temp_output_51_0_g2325 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g2325 * float2( 3.464,3.464 ) ) );
			float2 break55_g2325 = frac( temp_output_51_0_g2325 );
			float temp_output_56_0_g2325 = ( ( 1.0 - break55_g2325.x ) - break55_g2325.y );
			float2 temp_output_52_0_g2325 = floor( temp_output_51_0_g2325 );
			float2 temp_output_125_0_g2325 = ( temp_output_52_0_g2325 + float2( 1,1 ) );
			float2 ifLocalVar87_g2325 = 0;
			if( temp_output_56_0_g2325 > 0.0 )
				ifLocalVar87_g2325 = temp_output_52_0_g2325;
			else if( temp_output_56_0_g2325 == 0.0 )
				ifLocalVar87_g2325 = temp_output_125_0_g2325;
			else if( temp_output_56_0_g2325 < 0.0 )
				ifLocalVar87_g2325 = temp_output_125_0_g2325;
			float3 temp_output_7_0_g2326 = frac( ( (ifLocalVar87_g2325).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
			float dotResult8_g2326 = dot( temp_output_7_0_g2326 , ( (temp_output_7_0_g2326).yzx + 33.33 ) );
			float3 temp_output_12_0_g2326 = ( temp_output_7_0_g2326 + dotResult8_g2326 );
			float2 temp_output_597_0_g2324 = ( UV100_g2325 + frac( ( ( (temp_output_12_0_g2326).xx + (temp_output_12_0_g2326).yz ) * (temp_output_12_0_g2326).zy ) ) );
			float2 DDX631_g2324 = ddx( temp_output_5_0_g2324 );
			float2 DDY632_g2324 = ddy( temp_output_5_0_g2324 );
			float temp_output_65_0_g2325 = ( 0.0 - temp_output_56_0_g2325 );
			float ifLocalVar59_g2325 = 0;
			if( temp_output_56_0_g2325 <= 0.0 )
				ifLocalVar59_g2325 = temp_output_65_0_g2325;
			else
				ifLocalVar59_g2325 = temp_output_56_0_g2325;
			float temp_output_597_30_g2324 = ifLocalVar59_g2325;
			float2 temp_output_90_0_g2325 = ( temp_output_52_0_g2325 + float2( 0,1 ) );
			float2 temp_output_123_0_g2325 = ( temp_output_52_0_g2325 + float2( 1,0 ) );
			float2 ifLocalVar88_g2325 = 0;
			if( temp_output_56_0_g2325 > 0.0 )
				ifLocalVar88_g2325 = temp_output_90_0_g2325;
			else if( temp_output_56_0_g2325 == 0.0 )
				ifLocalVar88_g2325 = temp_output_123_0_g2325;
			else if( temp_output_56_0_g2325 < 0.0 )
				ifLocalVar88_g2325 = temp_output_123_0_g2325;
			float3 temp_output_7_0_g2327 = frac( ( (ifLocalVar88_g2325).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
			float dotResult8_g2327 = dot( temp_output_7_0_g2327 , ( (temp_output_7_0_g2327).yzx + 33.33 ) );
			float3 temp_output_12_0_g2327 = ( temp_output_7_0_g2327 + dotResult8_g2327 );
			float2 temp_output_597_26_g2324 = ( UV100_g2325 + frac( ( ( (temp_output_12_0_g2327).xx + (temp_output_12_0_g2327).yz ) * (temp_output_12_0_g2327).zy ) ) );
			float temp_output_66_0_g2325 = ( 1.0 - break55_g2325.y );
			float ifLocalVar60_g2325 = 0;
			if( temp_output_56_0_g2325 <= 0.0 )
				ifLocalVar60_g2325 = temp_output_66_0_g2325;
			else
				ifLocalVar60_g2325 = break55_g2325.y;
			float temp_output_597_28_g2324 = ifLocalVar60_g2325;
			float2 ifLocalVar89_g2325 = 0;
			if( temp_output_56_0_g2325 > 0.0 )
				ifLocalVar89_g2325 = temp_output_123_0_g2325;
			else if( temp_output_56_0_g2325 == 0.0 )
				ifLocalVar89_g2325 = temp_output_90_0_g2325;
			else if( temp_output_56_0_g2325 < 0.0 )
				ifLocalVar89_g2325 = temp_output_90_0_g2325;
			float3 temp_output_7_0_g2328 = frac( ( (ifLocalVar89_g2325).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
			float dotResult8_g2328 = dot( temp_output_7_0_g2328 , ( (temp_output_7_0_g2328).yzx + 33.33 ) );
			float3 temp_output_12_0_g2328 = ( temp_output_7_0_g2328 + dotResult8_g2328 );
			float2 temp_output_597_27_g2324 = ( UV100_g2325 + frac( ( ( (temp_output_12_0_g2328).xx + (temp_output_12_0_g2328).yz ) * (temp_output_12_0_g2328).zy ) ) );
			float temp_output_67_0_g2325 = ( 1.0 - break55_g2325.x );
			float ifLocalVar61_g2325 = 0;
			if( temp_output_56_0_g2325 <= 0.0 )
				ifLocalVar61_g2325 = temp_output_67_0_g2325;
			else
				ifLocalVar61_g2325 = break55_g2325.x;
			float temp_output_597_29_g2324 = ifLocalVar61_g2325;
			float4 Output_2D293_g2324 = ( ( tex2D( _MainTex, temp_output_597_0_g2324, DDX631_g2324, DDY632_g2324 ) * temp_output_597_30_g2324 ) + ( tex2D( _MainTex, temp_output_597_26_g2324, DDX631_g2324, DDY632_g2324 ) * temp_output_597_28_g2324 ) + ( tex2D( _MainTex, temp_output_597_27_g2324, DDX631_g2324, DDY632_g2324 ) * temp_output_597_29_g2324 ) );
			float4 Albedo6_g2287 = ( _Color * Output_2D293_g2324 );
			o.Albedo = Albedo6_g2287.rgb;
			float4 temp_cast_1 = 0;
			float2 uv_EmissionMap = i.uv_texcoord * _EmissionMap_ST.xy + _EmissionMap_ST.zw;
			float2 temp_output_5_0_g2304 = uv_EmissionMap;
			float2 UV633_g2304 = temp_output_5_0_g2304;
			float2 UV100_g2305 = UV633_g2304;
			float2 temp_output_51_0_g2305 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g2305 * float2( 3.464,3.464 ) ) );
			float2 break55_g2305 = frac( temp_output_51_0_g2305 );
			float temp_output_56_0_g2305 = ( ( 1.0 - break55_g2305.x ) - break55_g2305.y );
			float2 temp_output_52_0_g2305 = floor( temp_output_51_0_g2305 );
			float2 temp_output_125_0_g2305 = ( temp_output_52_0_g2305 + float2( 1,1 ) );
			float2 ifLocalVar87_g2305 = 0;
			if( temp_output_56_0_g2305 > 0.0 )
				ifLocalVar87_g2305 = temp_output_52_0_g2305;
			else if( temp_output_56_0_g2305 == 0.0 )
				ifLocalVar87_g2305 = temp_output_125_0_g2305;
			else if( temp_output_56_0_g2305 < 0.0 )
				ifLocalVar87_g2305 = temp_output_125_0_g2305;
			float3 temp_output_7_0_g2306 = frac( ( (ifLocalVar87_g2305).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
			float dotResult8_g2306 = dot( temp_output_7_0_g2306 , ( (temp_output_7_0_g2306).yzx + 33.33 ) );
			float3 temp_output_12_0_g2306 = ( temp_output_7_0_g2306 + dotResult8_g2306 );
			float2 temp_output_597_0_g2304 = ( UV100_g2305 + frac( ( ( (temp_output_12_0_g2306).xx + (temp_output_12_0_g2306).yz ) * (temp_output_12_0_g2306).zy ) ) );
			float2 DDX631_g2304 = ddx( temp_output_5_0_g2304 );
			float2 DDY632_g2304 = ddy( temp_output_5_0_g2304 );
			float temp_output_65_0_g2305 = ( 0.0 - temp_output_56_0_g2305 );
			float ifLocalVar59_g2305 = 0;
			if( temp_output_56_0_g2305 <= 0.0 )
				ifLocalVar59_g2305 = temp_output_65_0_g2305;
			else
				ifLocalVar59_g2305 = temp_output_56_0_g2305;
			float temp_output_597_30_g2304 = ifLocalVar59_g2305;
			float2 temp_output_90_0_g2305 = ( temp_output_52_0_g2305 + float2( 0,1 ) );
			float2 temp_output_123_0_g2305 = ( temp_output_52_0_g2305 + float2( 1,0 ) );
			float2 ifLocalVar88_g2305 = 0;
			if( temp_output_56_0_g2305 > 0.0 )
				ifLocalVar88_g2305 = temp_output_90_0_g2305;
			else if( temp_output_56_0_g2305 == 0.0 )
				ifLocalVar88_g2305 = temp_output_123_0_g2305;
			else if( temp_output_56_0_g2305 < 0.0 )
				ifLocalVar88_g2305 = temp_output_123_0_g2305;
			float3 temp_output_7_0_g2307 = frac( ( (ifLocalVar88_g2305).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
			float dotResult8_g2307 = dot( temp_output_7_0_g2307 , ( (temp_output_7_0_g2307).yzx + 33.33 ) );
			float3 temp_output_12_0_g2307 = ( temp_output_7_0_g2307 + dotResult8_g2307 );
			float2 temp_output_597_26_g2304 = ( UV100_g2305 + frac( ( ( (temp_output_12_0_g2307).xx + (temp_output_12_0_g2307).yz ) * (temp_output_12_0_g2307).zy ) ) );
			float temp_output_66_0_g2305 = ( 1.0 - break55_g2305.y );
			float ifLocalVar60_g2305 = 0;
			if( temp_output_56_0_g2305 <= 0.0 )
				ifLocalVar60_g2305 = temp_output_66_0_g2305;
			else
				ifLocalVar60_g2305 = break55_g2305.y;
			float temp_output_597_28_g2304 = ifLocalVar60_g2305;
			float2 ifLocalVar89_g2305 = 0;
			if( temp_output_56_0_g2305 > 0.0 )
				ifLocalVar89_g2305 = temp_output_123_0_g2305;
			else if( temp_output_56_0_g2305 == 0.0 )
				ifLocalVar89_g2305 = temp_output_90_0_g2305;
			else if( temp_output_56_0_g2305 < 0.0 )
				ifLocalVar89_g2305 = temp_output_90_0_g2305;
			float3 temp_output_7_0_g2308 = frac( ( (ifLocalVar89_g2305).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
			float dotResult8_g2308 = dot( temp_output_7_0_g2308 , ( (temp_output_7_0_g2308).yzx + 33.33 ) );
			float3 temp_output_12_0_g2308 = ( temp_output_7_0_g2308 + dotResult8_g2308 );
			float2 temp_output_597_27_g2304 = ( UV100_g2305 + frac( ( ( (temp_output_12_0_g2308).xx + (temp_output_12_0_g2308).yz ) * (temp_output_12_0_g2308).zy ) ) );
			float temp_output_67_0_g2305 = ( 1.0 - break55_g2305.x );
			float ifLocalVar61_g2305 = 0;
			if( temp_output_56_0_g2305 <= 0.0 )
				ifLocalVar61_g2305 = temp_output_67_0_g2305;
			else
				ifLocalVar61_g2305 = break55_g2305.x;
			float temp_output_597_29_g2304 = ifLocalVar61_g2305;
			float4 Output_2D293_g2304 = ( ( tex2D( _EmissionMap, temp_output_597_0_g2304, DDX631_g2304, DDY632_g2304 ) * temp_output_597_30_g2304 ) + ( tex2D( _EmissionMap, temp_output_597_26_g2304, DDX631_g2304, DDY632_g2304 ) * temp_output_597_28_g2304 ) + ( tex2D( _EmissionMap, temp_output_597_27_g2304, DDX631_g2304, DDY632_g2304 ) * temp_output_597_29_g2304 ) );
			float4 lerpResult974_g2287 = lerp( temp_cast_1 , ( _EmissionColor + Output_2D293_g2304 ) , _EmissionEnabled);
			float4 Emission86_g2287 = lerpResult974_g2287;
			float Metallic_Value893_g2287 = _Metallic;
			float localBicubicPrepare2_g2289 = ( 0.0 );
			float2 uv3_Lightmap = i.uv3_texcoord3 * _Lightmap_ST.xy + _Lightmap_ST.zw;
			float2 Input_UV100_g2289 = uv3_Lightmap;
			float2 UV2_g2289 = Input_UV100_g2289;
			float4 TexelSize2_g2289 = _Lightmap_TexelSize;
			float2 UV02_g2289 = float2( 0,0 );
			float2 UV12_g2289 = float2( 0,0 );
			float2 UV22_g2289 = float2( 0,0 );
			float2 UV32_g2289 = float2( 0,0 );
			float W02_g2289 = 0;
			float W12_g2289 = 0;
			{
			{
			 UV2_g2289 = UV2_g2289 * TexelSize2_g2289.zw - 0.5;
			    float2 f = frac( UV2_g2289 );
			    UV2_g2289 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g2289.x - 0.5, UV2_g2289.x + 1.5, UV2_g2289.y - 0.5, UV2_g2289.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g2289.xyxy;
			    UV02_g2289 = off.xz;
			    UV12_g2289 = off.yz;
			    UV22_g2289 = off.xw;
			    UV32_g2289 = off.yw;
			    W02_g2289 = s.x / ( s.x + s.y );
			 W12_g2289 = s.z / ( s.z + s.w );
			}
			}
			float4 lerpResult46_g2289 = lerp( tex2D( _Lightmap, UV32_g2289 ) , tex2D( _Lightmap, UV22_g2289 ) , W02_g2289);
			float4 lerpResult45_g2289 = lerp( tex2D( _Lightmap, UV12_g2289 ) , tex2D( _Lightmap, UV02_g2289 ) , W02_g2289);
			float4 lerpResult44_g2289 = lerp( lerpResult46_g2289 , lerpResult45_g2289 , W12_g2289);
			float4 Output_2D131_g2289 = lerpResult44_g2289;
			float4 Lightmap_0925_g2287 = Output_2D131_g2289;
			float Lightmap_GUI886_g2287 = ( _CATEGORYLIGHTMAPPING + _CATEGORYSPACELIGHTMAPPING );
			float4 temp_cast_2 = (Lightmap_GUI886_g2287).xxxx;
			float4 lerpResult882_g2287 = lerp( Lightmap_0925_g2287 , temp_cast_2 , float4( 0,0,0,0 ));
			float4 Lightmap46_g2287 = lerpResult882_g2287;
			float4 temp_output_614_0_g2287 = ( Albedo6_g2287 * ( ( 1.0 - Metallic_Value893_g2287 ) * Lightmap46_g2287 ) );
			o.Emission = ( Emission86_g2287 + temp_output_614_0_g2287 ).rgb;
			float2 uv_MetallicMap = i.uv_texcoord * _MetallicMap_ST.xy + _MetallicMap_ST.zw;
			float2 temp_output_5_0_g2309 = uv_MetallicMap;
			float2 UV633_g2309 = temp_output_5_0_g2309;
			float2 UV100_g2310 = UV633_g2309;
			float2 temp_output_51_0_g2310 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g2310 * float2( 3.464,3.464 ) ) );
			float2 break55_g2310 = frac( temp_output_51_0_g2310 );
			float temp_output_56_0_g2310 = ( ( 1.0 - break55_g2310.x ) - break55_g2310.y );
			float2 temp_output_52_0_g2310 = floor( temp_output_51_0_g2310 );
			float2 temp_output_125_0_g2310 = ( temp_output_52_0_g2310 + float2( 1,1 ) );
			float2 ifLocalVar87_g2310 = 0;
			if( temp_output_56_0_g2310 > 0.0 )
				ifLocalVar87_g2310 = temp_output_52_0_g2310;
			else if( temp_output_56_0_g2310 == 0.0 )
				ifLocalVar87_g2310 = temp_output_125_0_g2310;
			else if( temp_output_56_0_g2310 < 0.0 )
				ifLocalVar87_g2310 = temp_output_125_0_g2310;
			float3 temp_output_7_0_g2311 = frac( ( (ifLocalVar87_g2310).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
			float dotResult8_g2311 = dot( temp_output_7_0_g2311 , ( (temp_output_7_0_g2311).yzx + 33.33 ) );
			float3 temp_output_12_0_g2311 = ( temp_output_7_0_g2311 + dotResult8_g2311 );
			float2 temp_output_597_0_g2309 = ( UV100_g2310 + frac( ( ( (temp_output_12_0_g2311).xx + (temp_output_12_0_g2311).yz ) * (temp_output_12_0_g2311).zy ) ) );
			float2 DDX631_g2309 = ddx( temp_output_5_0_g2309 );
			float2 DDY632_g2309 = ddy( temp_output_5_0_g2309 );
			float temp_output_65_0_g2310 = ( 0.0 - temp_output_56_0_g2310 );
			float ifLocalVar59_g2310 = 0;
			if( temp_output_56_0_g2310 <= 0.0 )
				ifLocalVar59_g2310 = temp_output_65_0_g2310;
			else
				ifLocalVar59_g2310 = temp_output_56_0_g2310;
			float temp_output_597_30_g2309 = ifLocalVar59_g2310;
			float2 temp_output_90_0_g2310 = ( temp_output_52_0_g2310 + float2( 0,1 ) );
			float2 temp_output_123_0_g2310 = ( temp_output_52_0_g2310 + float2( 1,0 ) );
			float2 ifLocalVar88_g2310 = 0;
			if( temp_output_56_0_g2310 > 0.0 )
				ifLocalVar88_g2310 = temp_output_90_0_g2310;
			else if( temp_output_56_0_g2310 == 0.0 )
				ifLocalVar88_g2310 = temp_output_123_0_g2310;
			else if( temp_output_56_0_g2310 < 0.0 )
				ifLocalVar88_g2310 = temp_output_123_0_g2310;
			float3 temp_output_7_0_g2312 = frac( ( (ifLocalVar88_g2310).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
			float dotResult8_g2312 = dot( temp_output_7_0_g2312 , ( (temp_output_7_0_g2312).yzx + 33.33 ) );
			float3 temp_output_12_0_g2312 = ( temp_output_7_0_g2312 + dotResult8_g2312 );
			float2 temp_output_597_26_g2309 = ( UV100_g2310 + frac( ( ( (temp_output_12_0_g2312).xx + (temp_output_12_0_g2312).yz ) * (temp_output_12_0_g2312).zy ) ) );
			float temp_output_66_0_g2310 = ( 1.0 - break55_g2310.y );
			float ifLocalVar60_g2310 = 0;
			if( temp_output_56_0_g2310 <= 0.0 )
				ifLocalVar60_g2310 = temp_output_66_0_g2310;
			else
				ifLocalVar60_g2310 = break55_g2310.y;
			float temp_output_597_28_g2309 = ifLocalVar60_g2310;
			float2 ifLocalVar89_g2310 = 0;
			if( temp_output_56_0_g2310 > 0.0 )
				ifLocalVar89_g2310 = temp_output_123_0_g2310;
			else if( temp_output_56_0_g2310 == 0.0 )
				ifLocalVar89_g2310 = temp_output_90_0_g2310;
			else if( temp_output_56_0_g2310 < 0.0 )
				ifLocalVar89_g2310 = temp_output_90_0_g2310;
			float3 temp_output_7_0_g2313 = frac( ( (ifLocalVar89_g2310).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
			float dotResult8_g2313 = dot( temp_output_7_0_g2313 , ( (temp_output_7_0_g2313).yzx + 33.33 ) );
			float3 temp_output_12_0_g2313 = ( temp_output_7_0_g2313 + dotResult8_g2313 );
			float2 temp_output_597_27_g2309 = ( UV100_g2310 + frac( ( ( (temp_output_12_0_g2313).xx + (temp_output_12_0_g2313).yz ) * (temp_output_12_0_g2313).zy ) ) );
			float temp_output_67_0_g2310 = ( 1.0 - break55_g2310.x );
			float ifLocalVar61_g2310 = 0;
			if( temp_output_56_0_g2310 <= 0.0 )
				ifLocalVar61_g2310 = temp_output_67_0_g2310;
			else
				ifLocalVar61_g2310 = break55_g2310.x;
			float temp_output_597_29_g2309 = ifLocalVar61_g2310;
			float4 Output_2D293_g2309 = ( ( tex2D( _MetallicMap, temp_output_597_0_g2309, DDX631_g2309, DDY632_g2309 ) * temp_output_597_30_g2309 ) + ( tex2D( _MetallicMap, temp_output_597_26_g2309, DDX631_g2309, DDY632_g2309 ) * temp_output_597_28_g2309 ) + ( tex2D( _MetallicMap, temp_output_597_27_g2309, DDX631_g2309, DDY632_g2309 ) * temp_output_597_29_g2309 ) );
			float4 break31_g2309 = Output_2D293_g2309;
			float saferPower803_g2287 = abs( break31_g2309.a );
			#ifdef _METALLICMAP
				float staticSwitch846_g2287 = pow( saferPower803_g2287 , 3.0 );
			#else
				float staticSwitch846_g2287 = _Metallic;
			#endif
			float Metallic699_g2287 = staticSwitch846_g2287;
			o.Metallic = Metallic699_g2287;
			float2 uv_GlossinessMap = i.uv_texcoord * _GlossinessMap_ST.xy + _GlossinessMap_ST.zw;
			float2 temp_output_5_0_g2314 = uv_GlossinessMap;
			float2 UV633_g2314 = temp_output_5_0_g2314;
			float2 UV100_g2315 = UV633_g2314;
			float2 temp_output_51_0_g2315 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g2315 * float2( 3.464,3.464 ) ) );
			float2 break55_g2315 = frac( temp_output_51_0_g2315 );
			float temp_output_56_0_g2315 = ( ( 1.0 - break55_g2315.x ) - break55_g2315.y );
			float2 temp_output_52_0_g2315 = floor( temp_output_51_0_g2315 );
			float2 temp_output_125_0_g2315 = ( temp_output_52_0_g2315 + float2( 1,1 ) );
			float2 ifLocalVar87_g2315 = 0;
			if( temp_output_56_0_g2315 > 0.0 )
				ifLocalVar87_g2315 = temp_output_52_0_g2315;
			else if( temp_output_56_0_g2315 == 0.0 )
				ifLocalVar87_g2315 = temp_output_125_0_g2315;
			else if( temp_output_56_0_g2315 < 0.0 )
				ifLocalVar87_g2315 = temp_output_125_0_g2315;
			float3 temp_output_7_0_g2316 = frac( ( (ifLocalVar87_g2315).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
			float dotResult8_g2316 = dot( temp_output_7_0_g2316 , ( (temp_output_7_0_g2316).yzx + 33.33 ) );
			float3 temp_output_12_0_g2316 = ( temp_output_7_0_g2316 + dotResult8_g2316 );
			float2 temp_output_597_0_g2314 = ( UV100_g2315 + frac( ( ( (temp_output_12_0_g2316).xx + (temp_output_12_0_g2316).yz ) * (temp_output_12_0_g2316).zy ) ) );
			float2 DDX631_g2314 = ddx( temp_output_5_0_g2314 );
			float2 DDY632_g2314 = ddy( temp_output_5_0_g2314 );
			float temp_output_65_0_g2315 = ( 0.0 - temp_output_56_0_g2315 );
			float ifLocalVar59_g2315 = 0;
			if( temp_output_56_0_g2315 <= 0.0 )
				ifLocalVar59_g2315 = temp_output_65_0_g2315;
			else
				ifLocalVar59_g2315 = temp_output_56_0_g2315;
			float temp_output_597_30_g2314 = ifLocalVar59_g2315;
			float2 temp_output_90_0_g2315 = ( temp_output_52_0_g2315 + float2( 0,1 ) );
			float2 temp_output_123_0_g2315 = ( temp_output_52_0_g2315 + float2( 1,0 ) );
			float2 ifLocalVar88_g2315 = 0;
			if( temp_output_56_0_g2315 > 0.0 )
				ifLocalVar88_g2315 = temp_output_90_0_g2315;
			else if( temp_output_56_0_g2315 == 0.0 )
				ifLocalVar88_g2315 = temp_output_123_0_g2315;
			else if( temp_output_56_0_g2315 < 0.0 )
				ifLocalVar88_g2315 = temp_output_123_0_g2315;
			float3 temp_output_7_0_g2317 = frac( ( (ifLocalVar88_g2315).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
			float dotResult8_g2317 = dot( temp_output_7_0_g2317 , ( (temp_output_7_0_g2317).yzx + 33.33 ) );
			float3 temp_output_12_0_g2317 = ( temp_output_7_0_g2317 + dotResult8_g2317 );
			float2 temp_output_597_26_g2314 = ( UV100_g2315 + frac( ( ( (temp_output_12_0_g2317).xx + (temp_output_12_0_g2317).yz ) * (temp_output_12_0_g2317).zy ) ) );
			float temp_output_66_0_g2315 = ( 1.0 - break55_g2315.y );
			float ifLocalVar60_g2315 = 0;
			if( temp_output_56_0_g2315 <= 0.0 )
				ifLocalVar60_g2315 = temp_output_66_0_g2315;
			else
				ifLocalVar60_g2315 = break55_g2315.y;
			float temp_output_597_28_g2314 = ifLocalVar60_g2315;
			float2 ifLocalVar89_g2315 = 0;
			if( temp_output_56_0_g2315 > 0.0 )
				ifLocalVar89_g2315 = temp_output_123_0_g2315;
			else if( temp_output_56_0_g2315 == 0.0 )
				ifLocalVar89_g2315 = temp_output_90_0_g2315;
			else if( temp_output_56_0_g2315 < 0.0 )
				ifLocalVar89_g2315 = temp_output_90_0_g2315;
			float3 temp_output_7_0_g2318 = frac( ( (ifLocalVar89_g2315).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
			float dotResult8_g2318 = dot( temp_output_7_0_g2318 , ( (temp_output_7_0_g2318).yzx + 33.33 ) );
			float3 temp_output_12_0_g2318 = ( temp_output_7_0_g2318 + dotResult8_g2318 );
			float2 temp_output_597_27_g2314 = ( UV100_g2315 + frac( ( ( (temp_output_12_0_g2318).xx + (temp_output_12_0_g2318).yz ) * (temp_output_12_0_g2318).zy ) ) );
			float temp_output_67_0_g2315 = ( 1.0 - break55_g2315.x );
			float ifLocalVar61_g2315 = 0;
			if( temp_output_56_0_g2315 <= 0.0 )
				ifLocalVar61_g2315 = temp_output_67_0_g2315;
			else
				ifLocalVar61_g2315 = break55_g2315.x;
			float temp_output_597_29_g2314 = ifLocalVar61_g2315;
			float4 Output_2D293_g2314 = ( ( tex2D( _GlossinessMap, temp_output_597_0_g2314, DDX631_g2314, DDY632_g2314 ) * temp_output_597_30_g2314 ) + ( tex2D( _GlossinessMap, temp_output_597_26_g2314, DDX631_g2314, DDY632_g2314 ) * temp_output_597_28_g2314 ) + ( tex2D( _GlossinessMap, temp_output_597_27_g2314, DDX631_g2314, DDY632_g2314 ) * temp_output_597_29_g2314 ) );
			float4 break31_g2314 = Output_2D293_g2314;
			float saferPower804_g2287 = abs( break31_g2314.a );
			#ifdef _GLOSSINESSMAP
				float staticSwitch845_g2287 = ( 1.0 - pow( saferPower804_g2287 , 3.0 ) );
			#else
				float staticSwitch845_g2287 = _Glossiness;
			#endif
			float3 ase_normalWS = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 temp_output_3_0_g2329 = ddx( ase_normalWS );
			float dotResult5_g2329 = dot( temp_output_3_0_g2329 , temp_output_3_0_g2329 );
			float3 temp_output_4_0_g2329 = ddy( ase_normalWS );
			float dotResult6_g2329 = dot( temp_output_4_0_g2329 , temp_output_4_0_g2329 );
			#ifdef _USEGEOMETRICANTIALIASING_ON
				float staticSwitch824_g2287 = min( staticSwitch845_g2287 , ( 1.0 - pow( saturate( max( dotResult5_g2329 , dotResult6_g2329 ) ) , 0.333 ) ) );
			#else
				float staticSwitch824_g2287 = staticSwitch845_g2287;
			#endif
			o.Smoothness = staticSwitch824_g2287;
			float White38_g2287 = 1.0;
			float dotResult835_g2287 = dot( Lightmap46_g2287 , float4( float3( 0.299, 0.587, 0.114 ) , 0.0 ) );
			float saferPower606_g2287 = abs( dotResult835_g2287 );
			float lerpResult973_g2287 = lerp( White38_g2287 , pow( saferPower606_g2287 , _OcclusionPower ) , _LightmapOcclusionEnabled);
			o.Occlusion = lerpResult973_g2287;
			o.Alpha = 1;
			clip( Output_2D293_g2324.a - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19904
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;847;192,-1200;Inherit;False;Meenphie;0;;2287;b3ba55a08dd6b49c7be16c6f35cf2033;10,871,1,869,1,872,1,847,0,867,0,944,1,947,1,905,1,938,1,912,1;0;9;COLOR;625;FLOAT3;238;COLOR;624;FLOAT;96;FLOAT;97;FLOAT;95;FLOAT;156;FLOAT;427;FLOAT3;860
Node;AmplifyShaderEditor.StandardSurfaceOutputNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;343;512,-1200;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;0;Standard;Meenphie/Lightmapped/Simple/Stochastic/Cutout;False;False;False;False;False;False;False;True;True;False;False;False;False;False;True;True;False;False;True;True;False;Off;0;False;;0;False;;False;0;False;;0;False;;False;0;Masked;0.5;True;False;0;False;TransparentCutout;;AlphaTest;ForwardOnly;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0.0001;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;35;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;343;0;847;625
WireConnection;343;1;847;238
WireConnection;343;2;847;624
WireConnection;343;3;847;96
WireConnection;343;4;847;97
WireConnection;343;5;847;95
WireConnection;343;10;847;427
ASEEND*/
//CHKSM=5E2EF69D9D4F3A031F8B1DA119B9C4EBCAA5C5A4