// Made with Amplify Shader Editor v1.9.9.4
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Lightmapped/Simple/Stochastic/Opaque"
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
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "ForceNoShadowCasting" = "True" "IsEmissive" = "true"  }
		Cull Back
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

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float2 temp_output_5_0_g1384 = uv_BumpMap;
			float2 UV633_g1384 = temp_output_5_0_g1384;
			float2 UV100_g1385 = UV633_g1384;
			float2 temp_output_51_0_g1385 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g1385 * float2( 3.464,3.464 ) ) );
			float2 break55_g1385 = frac( temp_output_51_0_g1385 );
			float temp_output_56_0_g1385 = ( ( 1.0 - break55_g1385.x ) - break55_g1385.y );
			float2 temp_output_52_0_g1385 = floor( temp_output_51_0_g1385 );
			float2 temp_output_125_0_g1385 = ( temp_output_52_0_g1385 + float2( 1,1 ) );
			float2 ifLocalVar87_g1385 = 0;
			if( temp_output_56_0_g1385 > 0.0 )
				ifLocalVar87_g1385 = temp_output_52_0_g1385;
			else if( temp_output_56_0_g1385 == 0.0 )
				ifLocalVar87_g1385 = temp_output_125_0_g1385;
			else if( temp_output_56_0_g1385 < 0.0 )
				ifLocalVar87_g1385 = temp_output_125_0_g1385;
			float3 temp_output_7_0_g1386 = frac( ( (ifLocalVar87_g1385).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
			float dotResult8_g1386 = dot( temp_output_7_0_g1386 , ( (temp_output_7_0_g1386).yzx + 33.33 ) );
			float3 temp_output_12_0_g1386 = ( temp_output_7_0_g1386 + dotResult8_g1386 );
			float2 temp_output_597_0_g1384 = ( UV100_g1385 + frac( ( ( (temp_output_12_0_g1386).xx + (temp_output_12_0_g1386).yz ) * (temp_output_12_0_g1386).zy ) ) );
			float2 DDX631_g1384 = ddx( temp_output_5_0_g1384 );
			float2 DDY632_g1384 = ddy( temp_output_5_0_g1384 );
			float Input_Scale617_g1384 = _NormalScale;
			float temp_output_65_0_g1385 = ( 0.0 - temp_output_56_0_g1385 );
			float ifLocalVar59_g1385 = 0;
			if( temp_output_56_0_g1385 <= 0.0 )
				ifLocalVar59_g1385 = temp_output_65_0_g1385;
			else
				ifLocalVar59_g1385 = temp_output_56_0_g1385;
			float temp_output_597_30_g1384 = ifLocalVar59_g1385;
			float2 temp_output_90_0_g1385 = ( temp_output_52_0_g1385 + float2( 0,1 ) );
			float2 temp_output_123_0_g1385 = ( temp_output_52_0_g1385 + float2( 1,0 ) );
			float2 ifLocalVar88_g1385 = 0;
			if( temp_output_56_0_g1385 > 0.0 )
				ifLocalVar88_g1385 = temp_output_90_0_g1385;
			else if( temp_output_56_0_g1385 == 0.0 )
				ifLocalVar88_g1385 = temp_output_123_0_g1385;
			else if( temp_output_56_0_g1385 < 0.0 )
				ifLocalVar88_g1385 = temp_output_123_0_g1385;
			float3 temp_output_7_0_g1387 = frac( ( (ifLocalVar88_g1385).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
			float dotResult8_g1387 = dot( temp_output_7_0_g1387 , ( (temp_output_7_0_g1387).yzx + 33.33 ) );
			float3 temp_output_12_0_g1387 = ( temp_output_7_0_g1387 + dotResult8_g1387 );
			float2 temp_output_597_26_g1384 = ( UV100_g1385 + frac( ( ( (temp_output_12_0_g1387).xx + (temp_output_12_0_g1387).yz ) * (temp_output_12_0_g1387).zy ) ) );
			float temp_output_66_0_g1385 = ( 1.0 - break55_g1385.y );
			float ifLocalVar60_g1385 = 0;
			if( temp_output_56_0_g1385 <= 0.0 )
				ifLocalVar60_g1385 = temp_output_66_0_g1385;
			else
				ifLocalVar60_g1385 = break55_g1385.y;
			float temp_output_597_28_g1384 = ifLocalVar60_g1385;
			float2 ifLocalVar89_g1385 = 0;
			if( temp_output_56_0_g1385 > 0.0 )
				ifLocalVar89_g1385 = temp_output_123_0_g1385;
			else if( temp_output_56_0_g1385 == 0.0 )
				ifLocalVar89_g1385 = temp_output_90_0_g1385;
			else if( temp_output_56_0_g1385 < 0.0 )
				ifLocalVar89_g1385 = temp_output_90_0_g1385;
			float3 temp_output_7_0_g1388 = frac( ( (ifLocalVar89_g1385).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
			float dotResult8_g1388 = dot( temp_output_7_0_g1388 , ( (temp_output_7_0_g1388).yzx + 33.33 ) );
			float3 temp_output_12_0_g1388 = ( temp_output_7_0_g1388 + dotResult8_g1388 );
			float2 temp_output_597_27_g1384 = ( UV100_g1385 + frac( ( ( (temp_output_12_0_g1388).xx + (temp_output_12_0_g1388).yz ) * (temp_output_12_0_g1388).zy ) ) );
			float temp_output_67_0_g1385 = ( 1.0 - break55_g1385.x );
			float ifLocalVar61_g1385 = 0;
			if( temp_output_56_0_g1385 <= 0.0 )
				ifLocalVar61_g1385 = temp_output_67_0_g1385;
			else
				ifLocalVar61_g1385 = break55_g1385.x;
			float temp_output_597_29_g1384 = ifLocalVar61_g1385;
			float3 Output_2D_Normal641_g1384 = ( ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_0_g1384, DDX631_g1384, DDY632_g1384 ), Input_Scale617_g1384 ) * temp_output_597_30_g1384 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_26_g1384, DDX631_g1384, DDY632_g1384 ), Input_Scale617_g1384 ) * temp_output_597_28_g1384 ) + ( UnpackScaleNormal( tex2D( _BumpMap, temp_output_597_27_g1384, DDX631_g1384, DDY632_g1384 ), Input_Scale617_g1384 ) * float3( 0,0,0 ) * temp_output_597_29_g1384 ) );
			#ifdef _BUMPMAP
				float3 staticSwitch980_g1352 = Output_2D_Normal641_g1384;
			#else
				float3 staticSwitch980_g1352 = float3( 0, 0, 1 );
			#endif
			float3 Normal_Map700_g1352 = staticSwitch980_g1352;
			o.Normal = Normal_Map700_g1352;
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 temp_output_5_0_g1389 = uv_MainTex;
			float2 UV633_g1389 = temp_output_5_0_g1389;
			float2 UV100_g1390 = UV633_g1389;
			float2 temp_output_51_0_g1390 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g1390 * float2( 3.464,3.464 ) ) );
			float2 break55_g1390 = frac( temp_output_51_0_g1390 );
			float temp_output_56_0_g1390 = ( ( 1.0 - break55_g1390.x ) - break55_g1390.y );
			float2 temp_output_52_0_g1390 = floor( temp_output_51_0_g1390 );
			float2 temp_output_125_0_g1390 = ( temp_output_52_0_g1390 + float2( 1,1 ) );
			float2 ifLocalVar87_g1390 = 0;
			if( temp_output_56_0_g1390 > 0.0 )
				ifLocalVar87_g1390 = temp_output_52_0_g1390;
			else if( temp_output_56_0_g1390 == 0.0 )
				ifLocalVar87_g1390 = temp_output_125_0_g1390;
			else if( temp_output_56_0_g1390 < 0.0 )
				ifLocalVar87_g1390 = temp_output_125_0_g1390;
			float3 temp_output_7_0_g1391 = frac( ( (ifLocalVar87_g1390).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
			float dotResult8_g1391 = dot( temp_output_7_0_g1391 , ( (temp_output_7_0_g1391).yzx + 33.33 ) );
			float3 temp_output_12_0_g1391 = ( temp_output_7_0_g1391 + dotResult8_g1391 );
			float2 temp_output_597_0_g1389 = ( UV100_g1390 + frac( ( ( (temp_output_12_0_g1391).xx + (temp_output_12_0_g1391).yz ) * (temp_output_12_0_g1391).zy ) ) );
			float2 DDX631_g1389 = ddx( temp_output_5_0_g1389 );
			float2 DDY632_g1389 = ddy( temp_output_5_0_g1389 );
			float temp_output_65_0_g1390 = ( 0.0 - temp_output_56_0_g1390 );
			float ifLocalVar59_g1390 = 0;
			if( temp_output_56_0_g1390 <= 0.0 )
				ifLocalVar59_g1390 = temp_output_65_0_g1390;
			else
				ifLocalVar59_g1390 = temp_output_56_0_g1390;
			float temp_output_597_30_g1389 = ifLocalVar59_g1390;
			float2 temp_output_90_0_g1390 = ( temp_output_52_0_g1390 + float2( 0,1 ) );
			float2 temp_output_123_0_g1390 = ( temp_output_52_0_g1390 + float2( 1,0 ) );
			float2 ifLocalVar88_g1390 = 0;
			if( temp_output_56_0_g1390 > 0.0 )
				ifLocalVar88_g1390 = temp_output_90_0_g1390;
			else if( temp_output_56_0_g1390 == 0.0 )
				ifLocalVar88_g1390 = temp_output_123_0_g1390;
			else if( temp_output_56_0_g1390 < 0.0 )
				ifLocalVar88_g1390 = temp_output_123_0_g1390;
			float3 temp_output_7_0_g1392 = frac( ( (ifLocalVar88_g1390).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
			float dotResult8_g1392 = dot( temp_output_7_0_g1392 , ( (temp_output_7_0_g1392).yzx + 33.33 ) );
			float3 temp_output_12_0_g1392 = ( temp_output_7_0_g1392 + dotResult8_g1392 );
			float2 temp_output_597_26_g1389 = ( UV100_g1390 + frac( ( ( (temp_output_12_0_g1392).xx + (temp_output_12_0_g1392).yz ) * (temp_output_12_0_g1392).zy ) ) );
			float temp_output_66_0_g1390 = ( 1.0 - break55_g1390.y );
			float ifLocalVar60_g1390 = 0;
			if( temp_output_56_0_g1390 <= 0.0 )
				ifLocalVar60_g1390 = temp_output_66_0_g1390;
			else
				ifLocalVar60_g1390 = break55_g1390.y;
			float temp_output_597_28_g1389 = ifLocalVar60_g1390;
			float2 ifLocalVar89_g1390 = 0;
			if( temp_output_56_0_g1390 > 0.0 )
				ifLocalVar89_g1390 = temp_output_123_0_g1390;
			else if( temp_output_56_0_g1390 == 0.0 )
				ifLocalVar89_g1390 = temp_output_90_0_g1390;
			else if( temp_output_56_0_g1390 < 0.0 )
				ifLocalVar89_g1390 = temp_output_90_0_g1390;
			float3 temp_output_7_0_g1393 = frac( ( (ifLocalVar89_g1390).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
			float dotResult8_g1393 = dot( temp_output_7_0_g1393 , ( (temp_output_7_0_g1393).yzx + 33.33 ) );
			float3 temp_output_12_0_g1393 = ( temp_output_7_0_g1393 + dotResult8_g1393 );
			float2 temp_output_597_27_g1389 = ( UV100_g1390 + frac( ( ( (temp_output_12_0_g1393).xx + (temp_output_12_0_g1393).yz ) * (temp_output_12_0_g1393).zy ) ) );
			float temp_output_67_0_g1390 = ( 1.0 - break55_g1390.x );
			float ifLocalVar61_g1390 = 0;
			if( temp_output_56_0_g1390 <= 0.0 )
				ifLocalVar61_g1390 = temp_output_67_0_g1390;
			else
				ifLocalVar61_g1390 = break55_g1390.x;
			float temp_output_597_29_g1389 = ifLocalVar61_g1390;
			float4 Output_2D293_g1389 = ( ( tex2D( _MainTex, temp_output_597_0_g1389, DDX631_g1389, DDY632_g1389 ) * temp_output_597_30_g1389 ) + ( tex2D( _MainTex, temp_output_597_26_g1389, DDX631_g1389, DDY632_g1389 ) * temp_output_597_28_g1389 ) + ( tex2D( _MainTex, temp_output_597_27_g1389, DDX631_g1389, DDY632_g1389 ) * temp_output_597_29_g1389 ) );
			float4 Albedo6_g1352 = ( _Color * Output_2D293_g1389 );
			o.Albedo = Albedo6_g1352.rgb;
			float4 temp_cast_1 = 0;
			float2 uv_EmissionMap = i.uv_texcoord * _EmissionMap_ST.xy + _EmissionMap_ST.zw;
			float2 temp_output_5_0_g1369 = uv_EmissionMap;
			float2 UV633_g1369 = temp_output_5_0_g1369;
			float2 UV100_g1370 = UV633_g1369;
			float2 temp_output_51_0_g1370 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g1370 * float2( 3.464,3.464 ) ) );
			float2 break55_g1370 = frac( temp_output_51_0_g1370 );
			float temp_output_56_0_g1370 = ( ( 1.0 - break55_g1370.x ) - break55_g1370.y );
			float2 temp_output_52_0_g1370 = floor( temp_output_51_0_g1370 );
			float2 temp_output_125_0_g1370 = ( temp_output_52_0_g1370 + float2( 1,1 ) );
			float2 ifLocalVar87_g1370 = 0;
			if( temp_output_56_0_g1370 > 0.0 )
				ifLocalVar87_g1370 = temp_output_52_0_g1370;
			else if( temp_output_56_0_g1370 == 0.0 )
				ifLocalVar87_g1370 = temp_output_125_0_g1370;
			else if( temp_output_56_0_g1370 < 0.0 )
				ifLocalVar87_g1370 = temp_output_125_0_g1370;
			float3 temp_output_7_0_g1371 = frac( ( (ifLocalVar87_g1370).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
			float dotResult8_g1371 = dot( temp_output_7_0_g1371 , ( (temp_output_7_0_g1371).yzx + 33.33 ) );
			float3 temp_output_12_0_g1371 = ( temp_output_7_0_g1371 + dotResult8_g1371 );
			float2 temp_output_597_0_g1369 = ( UV100_g1370 + frac( ( ( (temp_output_12_0_g1371).xx + (temp_output_12_0_g1371).yz ) * (temp_output_12_0_g1371).zy ) ) );
			float2 DDX631_g1369 = ddx( temp_output_5_0_g1369 );
			float2 DDY632_g1369 = ddy( temp_output_5_0_g1369 );
			float temp_output_65_0_g1370 = ( 0.0 - temp_output_56_0_g1370 );
			float ifLocalVar59_g1370 = 0;
			if( temp_output_56_0_g1370 <= 0.0 )
				ifLocalVar59_g1370 = temp_output_65_0_g1370;
			else
				ifLocalVar59_g1370 = temp_output_56_0_g1370;
			float temp_output_597_30_g1369 = ifLocalVar59_g1370;
			float2 temp_output_90_0_g1370 = ( temp_output_52_0_g1370 + float2( 0,1 ) );
			float2 temp_output_123_0_g1370 = ( temp_output_52_0_g1370 + float2( 1,0 ) );
			float2 ifLocalVar88_g1370 = 0;
			if( temp_output_56_0_g1370 > 0.0 )
				ifLocalVar88_g1370 = temp_output_90_0_g1370;
			else if( temp_output_56_0_g1370 == 0.0 )
				ifLocalVar88_g1370 = temp_output_123_0_g1370;
			else if( temp_output_56_0_g1370 < 0.0 )
				ifLocalVar88_g1370 = temp_output_123_0_g1370;
			float3 temp_output_7_0_g1372 = frac( ( (ifLocalVar88_g1370).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
			float dotResult8_g1372 = dot( temp_output_7_0_g1372 , ( (temp_output_7_0_g1372).yzx + 33.33 ) );
			float3 temp_output_12_0_g1372 = ( temp_output_7_0_g1372 + dotResult8_g1372 );
			float2 temp_output_597_26_g1369 = ( UV100_g1370 + frac( ( ( (temp_output_12_0_g1372).xx + (temp_output_12_0_g1372).yz ) * (temp_output_12_0_g1372).zy ) ) );
			float temp_output_66_0_g1370 = ( 1.0 - break55_g1370.y );
			float ifLocalVar60_g1370 = 0;
			if( temp_output_56_0_g1370 <= 0.0 )
				ifLocalVar60_g1370 = temp_output_66_0_g1370;
			else
				ifLocalVar60_g1370 = break55_g1370.y;
			float temp_output_597_28_g1369 = ifLocalVar60_g1370;
			float2 ifLocalVar89_g1370 = 0;
			if( temp_output_56_0_g1370 > 0.0 )
				ifLocalVar89_g1370 = temp_output_123_0_g1370;
			else if( temp_output_56_0_g1370 == 0.0 )
				ifLocalVar89_g1370 = temp_output_90_0_g1370;
			else if( temp_output_56_0_g1370 < 0.0 )
				ifLocalVar89_g1370 = temp_output_90_0_g1370;
			float3 temp_output_7_0_g1373 = frac( ( (ifLocalVar89_g1370).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
			float dotResult8_g1373 = dot( temp_output_7_0_g1373 , ( (temp_output_7_0_g1373).yzx + 33.33 ) );
			float3 temp_output_12_0_g1373 = ( temp_output_7_0_g1373 + dotResult8_g1373 );
			float2 temp_output_597_27_g1369 = ( UV100_g1370 + frac( ( ( (temp_output_12_0_g1373).xx + (temp_output_12_0_g1373).yz ) * (temp_output_12_0_g1373).zy ) ) );
			float temp_output_67_0_g1370 = ( 1.0 - break55_g1370.x );
			float ifLocalVar61_g1370 = 0;
			if( temp_output_56_0_g1370 <= 0.0 )
				ifLocalVar61_g1370 = temp_output_67_0_g1370;
			else
				ifLocalVar61_g1370 = break55_g1370.x;
			float temp_output_597_29_g1369 = ifLocalVar61_g1370;
			float4 Output_2D293_g1369 = ( ( tex2D( _EmissionMap, temp_output_597_0_g1369, DDX631_g1369, DDY632_g1369 ) * temp_output_597_30_g1369 ) + ( tex2D( _EmissionMap, temp_output_597_26_g1369, DDX631_g1369, DDY632_g1369 ) * temp_output_597_28_g1369 ) + ( tex2D( _EmissionMap, temp_output_597_27_g1369, DDX631_g1369, DDY632_g1369 ) * temp_output_597_29_g1369 ) );
			float4 lerpResult974_g1352 = lerp( temp_cast_1 , ( _EmissionColor + Output_2D293_g1369 ) , _EmissionEnabled);
			float4 Emission86_g1352 = lerpResult974_g1352;
			float Metallic_Value893_g1352 = _Metallic;
			float localBicubicPrepare2_g1354 = ( 0.0 );
			float2 uv3_Lightmap = i.uv3_texcoord3 * _Lightmap_ST.xy + _Lightmap_ST.zw;
			float2 Input_UV100_g1354 = uv3_Lightmap;
			float2 UV2_g1354 = Input_UV100_g1354;
			float4 TexelSize2_g1354 = _Lightmap_TexelSize;
			float2 UV02_g1354 = float2( 0,0 );
			float2 UV12_g1354 = float2( 0,0 );
			float2 UV22_g1354 = float2( 0,0 );
			float2 UV32_g1354 = float2( 0,0 );
			float W02_g1354 = 0;
			float W12_g1354 = 0;
			{
			{
			 UV2_g1354 = UV2_g1354 * TexelSize2_g1354.zw - 0.5;
			    float2 f = frac( UV2_g1354 );
			    UV2_g1354 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g1354.x - 0.5, UV2_g1354.x + 1.5, UV2_g1354.y - 0.5, UV2_g1354.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1354.xyxy;
			    UV02_g1354 = off.xz;
			    UV12_g1354 = off.yz;
			    UV22_g1354 = off.xw;
			    UV32_g1354 = off.yw;
			    W02_g1354 = s.x / ( s.x + s.y );
			 W12_g1354 = s.z / ( s.z + s.w );
			}
			}
			float4 lerpResult46_g1354 = lerp( tex2D( _Lightmap, UV32_g1354 ) , tex2D( _Lightmap, UV22_g1354 ) , W02_g1354);
			float4 lerpResult45_g1354 = lerp( tex2D( _Lightmap, UV12_g1354 ) , tex2D( _Lightmap, UV02_g1354 ) , W02_g1354);
			float4 lerpResult44_g1354 = lerp( lerpResult46_g1354 , lerpResult45_g1354 , W12_g1354);
			float4 Output_2D131_g1354 = lerpResult44_g1354;
			float4 Lightmap_0925_g1352 = Output_2D131_g1354;
			float Lightmap_GUI886_g1352 = ( _CATEGORYLIGHTMAPPING + _CATEGORYSPACELIGHTMAPPING );
			float4 temp_cast_2 = (Lightmap_GUI886_g1352).xxxx;
			float4 lerpResult882_g1352 = lerp( Lightmap_0925_g1352 , temp_cast_2 , float4( 0,0,0,0 ));
			float4 Lightmap46_g1352 = lerpResult882_g1352;
			float4 temp_output_614_0_g1352 = ( Albedo6_g1352 * ( ( 1.0 - Metallic_Value893_g1352 ) * Lightmap46_g1352 ) );
			o.Emission = ( Emission86_g1352 + temp_output_614_0_g1352 ).rgb;
			float2 uv_MetallicMap = i.uv_texcoord * _MetallicMap_ST.xy + _MetallicMap_ST.zw;
			float2 temp_output_5_0_g1374 = uv_MetallicMap;
			float2 UV633_g1374 = temp_output_5_0_g1374;
			float2 UV100_g1375 = UV633_g1374;
			float2 temp_output_51_0_g1375 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g1375 * float2( 3.464,3.464 ) ) );
			float2 break55_g1375 = frac( temp_output_51_0_g1375 );
			float temp_output_56_0_g1375 = ( ( 1.0 - break55_g1375.x ) - break55_g1375.y );
			float2 temp_output_52_0_g1375 = floor( temp_output_51_0_g1375 );
			float2 temp_output_125_0_g1375 = ( temp_output_52_0_g1375 + float2( 1,1 ) );
			float2 ifLocalVar87_g1375 = 0;
			if( temp_output_56_0_g1375 > 0.0 )
				ifLocalVar87_g1375 = temp_output_52_0_g1375;
			else if( temp_output_56_0_g1375 == 0.0 )
				ifLocalVar87_g1375 = temp_output_125_0_g1375;
			else if( temp_output_56_0_g1375 < 0.0 )
				ifLocalVar87_g1375 = temp_output_125_0_g1375;
			float3 temp_output_7_0_g1376 = frac( ( (ifLocalVar87_g1375).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
			float dotResult8_g1376 = dot( temp_output_7_0_g1376 , ( (temp_output_7_0_g1376).yzx + 33.33 ) );
			float3 temp_output_12_0_g1376 = ( temp_output_7_0_g1376 + dotResult8_g1376 );
			float2 temp_output_597_0_g1374 = ( UV100_g1375 + frac( ( ( (temp_output_12_0_g1376).xx + (temp_output_12_0_g1376).yz ) * (temp_output_12_0_g1376).zy ) ) );
			float2 DDX631_g1374 = ddx( temp_output_5_0_g1374 );
			float2 DDY632_g1374 = ddy( temp_output_5_0_g1374 );
			float temp_output_65_0_g1375 = ( 0.0 - temp_output_56_0_g1375 );
			float ifLocalVar59_g1375 = 0;
			if( temp_output_56_0_g1375 <= 0.0 )
				ifLocalVar59_g1375 = temp_output_65_0_g1375;
			else
				ifLocalVar59_g1375 = temp_output_56_0_g1375;
			float temp_output_597_30_g1374 = ifLocalVar59_g1375;
			float2 temp_output_90_0_g1375 = ( temp_output_52_0_g1375 + float2( 0,1 ) );
			float2 temp_output_123_0_g1375 = ( temp_output_52_0_g1375 + float2( 1,0 ) );
			float2 ifLocalVar88_g1375 = 0;
			if( temp_output_56_0_g1375 > 0.0 )
				ifLocalVar88_g1375 = temp_output_90_0_g1375;
			else if( temp_output_56_0_g1375 == 0.0 )
				ifLocalVar88_g1375 = temp_output_123_0_g1375;
			else if( temp_output_56_0_g1375 < 0.0 )
				ifLocalVar88_g1375 = temp_output_123_0_g1375;
			float3 temp_output_7_0_g1377 = frac( ( (ifLocalVar88_g1375).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
			float dotResult8_g1377 = dot( temp_output_7_0_g1377 , ( (temp_output_7_0_g1377).yzx + 33.33 ) );
			float3 temp_output_12_0_g1377 = ( temp_output_7_0_g1377 + dotResult8_g1377 );
			float2 temp_output_597_26_g1374 = ( UV100_g1375 + frac( ( ( (temp_output_12_0_g1377).xx + (temp_output_12_0_g1377).yz ) * (temp_output_12_0_g1377).zy ) ) );
			float temp_output_66_0_g1375 = ( 1.0 - break55_g1375.y );
			float ifLocalVar60_g1375 = 0;
			if( temp_output_56_0_g1375 <= 0.0 )
				ifLocalVar60_g1375 = temp_output_66_0_g1375;
			else
				ifLocalVar60_g1375 = break55_g1375.y;
			float temp_output_597_28_g1374 = ifLocalVar60_g1375;
			float2 ifLocalVar89_g1375 = 0;
			if( temp_output_56_0_g1375 > 0.0 )
				ifLocalVar89_g1375 = temp_output_123_0_g1375;
			else if( temp_output_56_0_g1375 == 0.0 )
				ifLocalVar89_g1375 = temp_output_90_0_g1375;
			else if( temp_output_56_0_g1375 < 0.0 )
				ifLocalVar89_g1375 = temp_output_90_0_g1375;
			float3 temp_output_7_0_g1378 = frac( ( (ifLocalVar89_g1375).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
			float dotResult8_g1378 = dot( temp_output_7_0_g1378 , ( (temp_output_7_0_g1378).yzx + 33.33 ) );
			float3 temp_output_12_0_g1378 = ( temp_output_7_0_g1378 + dotResult8_g1378 );
			float2 temp_output_597_27_g1374 = ( UV100_g1375 + frac( ( ( (temp_output_12_0_g1378).xx + (temp_output_12_0_g1378).yz ) * (temp_output_12_0_g1378).zy ) ) );
			float temp_output_67_0_g1375 = ( 1.0 - break55_g1375.x );
			float ifLocalVar61_g1375 = 0;
			if( temp_output_56_0_g1375 <= 0.0 )
				ifLocalVar61_g1375 = temp_output_67_0_g1375;
			else
				ifLocalVar61_g1375 = break55_g1375.x;
			float temp_output_597_29_g1374 = ifLocalVar61_g1375;
			float4 Output_2D293_g1374 = ( ( tex2D( _MetallicMap, temp_output_597_0_g1374, DDX631_g1374, DDY632_g1374 ) * temp_output_597_30_g1374 ) + ( tex2D( _MetallicMap, temp_output_597_26_g1374, DDX631_g1374, DDY632_g1374 ) * temp_output_597_28_g1374 ) + ( tex2D( _MetallicMap, temp_output_597_27_g1374, DDX631_g1374, DDY632_g1374 ) * temp_output_597_29_g1374 ) );
			float4 break31_g1374 = Output_2D293_g1374;
			float saferPower803_g1352 = abs( break31_g1374.a );
			#ifdef _METALLICMAP
				float staticSwitch846_g1352 = pow( saferPower803_g1352 , 3.0 );
			#else
				float staticSwitch846_g1352 = _Metallic;
			#endif
			float Metallic699_g1352 = staticSwitch846_g1352;
			o.Metallic = Metallic699_g1352;
			float2 uv_GlossinessMap = i.uv_texcoord * _GlossinessMap_ST.xy + _GlossinessMap_ST.zw;
			float2 temp_output_5_0_g1379 = uv_GlossinessMap;
			float2 UV633_g1379 = temp_output_5_0_g1379;
			float2 UV100_g1380 = UV633_g1379;
			float2 temp_output_51_0_g1380 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g1380 * float2( 3.464,3.464 ) ) );
			float2 break55_g1380 = frac( temp_output_51_0_g1380 );
			float temp_output_56_0_g1380 = ( ( 1.0 - break55_g1380.x ) - break55_g1380.y );
			float2 temp_output_52_0_g1380 = floor( temp_output_51_0_g1380 );
			float2 temp_output_125_0_g1380 = ( temp_output_52_0_g1380 + float2( 1,1 ) );
			float2 ifLocalVar87_g1380 = 0;
			if( temp_output_56_0_g1380 > 0.0 )
				ifLocalVar87_g1380 = temp_output_52_0_g1380;
			else if( temp_output_56_0_g1380 == 0.0 )
				ifLocalVar87_g1380 = temp_output_125_0_g1380;
			else if( temp_output_56_0_g1380 < 0.0 )
				ifLocalVar87_g1380 = temp_output_125_0_g1380;
			float3 temp_output_7_0_g1381 = frac( ( (ifLocalVar87_g1380).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
			float dotResult8_g1381 = dot( temp_output_7_0_g1381 , ( (temp_output_7_0_g1381).yzx + 33.33 ) );
			float3 temp_output_12_0_g1381 = ( temp_output_7_0_g1381 + dotResult8_g1381 );
			float2 temp_output_597_0_g1379 = ( UV100_g1380 + frac( ( ( (temp_output_12_0_g1381).xx + (temp_output_12_0_g1381).yz ) * (temp_output_12_0_g1381).zy ) ) );
			float2 DDX631_g1379 = ddx( temp_output_5_0_g1379 );
			float2 DDY632_g1379 = ddy( temp_output_5_0_g1379 );
			float temp_output_65_0_g1380 = ( 0.0 - temp_output_56_0_g1380 );
			float ifLocalVar59_g1380 = 0;
			if( temp_output_56_0_g1380 <= 0.0 )
				ifLocalVar59_g1380 = temp_output_65_0_g1380;
			else
				ifLocalVar59_g1380 = temp_output_56_0_g1380;
			float temp_output_597_30_g1379 = ifLocalVar59_g1380;
			float2 temp_output_90_0_g1380 = ( temp_output_52_0_g1380 + float2( 0,1 ) );
			float2 temp_output_123_0_g1380 = ( temp_output_52_0_g1380 + float2( 1,0 ) );
			float2 ifLocalVar88_g1380 = 0;
			if( temp_output_56_0_g1380 > 0.0 )
				ifLocalVar88_g1380 = temp_output_90_0_g1380;
			else if( temp_output_56_0_g1380 == 0.0 )
				ifLocalVar88_g1380 = temp_output_123_0_g1380;
			else if( temp_output_56_0_g1380 < 0.0 )
				ifLocalVar88_g1380 = temp_output_123_0_g1380;
			float3 temp_output_7_0_g1382 = frac( ( (ifLocalVar88_g1380).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
			float dotResult8_g1382 = dot( temp_output_7_0_g1382 , ( (temp_output_7_0_g1382).yzx + 33.33 ) );
			float3 temp_output_12_0_g1382 = ( temp_output_7_0_g1382 + dotResult8_g1382 );
			float2 temp_output_597_26_g1379 = ( UV100_g1380 + frac( ( ( (temp_output_12_0_g1382).xx + (temp_output_12_0_g1382).yz ) * (temp_output_12_0_g1382).zy ) ) );
			float temp_output_66_0_g1380 = ( 1.0 - break55_g1380.y );
			float ifLocalVar60_g1380 = 0;
			if( temp_output_56_0_g1380 <= 0.0 )
				ifLocalVar60_g1380 = temp_output_66_0_g1380;
			else
				ifLocalVar60_g1380 = break55_g1380.y;
			float temp_output_597_28_g1379 = ifLocalVar60_g1380;
			float2 ifLocalVar89_g1380 = 0;
			if( temp_output_56_0_g1380 > 0.0 )
				ifLocalVar89_g1380 = temp_output_123_0_g1380;
			else if( temp_output_56_0_g1380 == 0.0 )
				ifLocalVar89_g1380 = temp_output_90_0_g1380;
			else if( temp_output_56_0_g1380 < 0.0 )
				ifLocalVar89_g1380 = temp_output_90_0_g1380;
			float3 temp_output_7_0_g1383 = frac( ( (ifLocalVar89_g1380).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
			float dotResult8_g1383 = dot( temp_output_7_0_g1383 , ( (temp_output_7_0_g1383).yzx + 33.33 ) );
			float3 temp_output_12_0_g1383 = ( temp_output_7_0_g1383 + dotResult8_g1383 );
			float2 temp_output_597_27_g1379 = ( UV100_g1380 + frac( ( ( (temp_output_12_0_g1383).xx + (temp_output_12_0_g1383).yz ) * (temp_output_12_0_g1383).zy ) ) );
			float temp_output_67_0_g1380 = ( 1.0 - break55_g1380.x );
			float ifLocalVar61_g1380 = 0;
			if( temp_output_56_0_g1380 <= 0.0 )
				ifLocalVar61_g1380 = temp_output_67_0_g1380;
			else
				ifLocalVar61_g1380 = break55_g1380.x;
			float temp_output_597_29_g1379 = ifLocalVar61_g1380;
			float4 Output_2D293_g1379 = ( ( tex2D( _GlossinessMap, temp_output_597_0_g1379, DDX631_g1379, DDY632_g1379 ) * temp_output_597_30_g1379 ) + ( tex2D( _GlossinessMap, temp_output_597_26_g1379, DDX631_g1379, DDY632_g1379 ) * temp_output_597_28_g1379 ) + ( tex2D( _GlossinessMap, temp_output_597_27_g1379, DDX631_g1379, DDY632_g1379 ) * temp_output_597_29_g1379 ) );
			float4 break31_g1379 = Output_2D293_g1379;
			float saferPower804_g1352 = abs( break31_g1379.a );
			#ifdef _GLOSSINESSMAP
				float staticSwitch845_g1352 = ( 1.0 - pow( saferPower804_g1352 , 3.0 ) );
			#else
				float staticSwitch845_g1352 = _Glossiness;
			#endif
			float3 ase_normalWS = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 temp_output_3_0_g1394 = ddx( ase_normalWS );
			float dotResult5_g1394 = dot( temp_output_3_0_g1394 , temp_output_3_0_g1394 );
			float3 temp_output_4_0_g1394 = ddy( ase_normalWS );
			float dotResult6_g1394 = dot( temp_output_4_0_g1394 , temp_output_4_0_g1394 );
			#ifdef _USEGEOMETRICANTIALIASING_ON
				float staticSwitch824_g1352 = min( staticSwitch845_g1352 , ( 1.0 - pow( saturate( max( dotResult5_g1394 , dotResult6_g1394 ) ) , 0.333 ) ) );
			#else
				float staticSwitch824_g1352 = staticSwitch845_g1352;
			#endif
			o.Smoothness = staticSwitch824_g1352;
			float White38_g1352 = 1.0;
			float dotResult835_g1352 = dot( Lightmap46_g1352 , float4( float3( 0.299, 0.587, 0.114 ) , 0.0 ) );
			float saferPower606_g1352 = abs( dotResult835_g1352 );
			float lerpResult973_g1352 = lerp( White38_g1352 , pow( saferPower606_g1352 , _OcclusionPower ) , _LightmapOcclusionEnabled);
			o.Occlusion = lerpResult973_g1352;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19904
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2858;192,-1200;Inherit;False;Meenphie;0;;1352;b3ba55a08dd6b49c7be16c6f35cf2033;10,871,1,869,1,872,1,847,0,867,0,944,1,947,1,905,1,938,1,912,1;0;9;COLOR;625;FLOAT3;238;COLOR;624;FLOAT;96;FLOAT;97;FLOAT;95;FLOAT;156;FLOAT;427;FLOAT3;860
Node;AmplifyShaderEditor.StandardSurfaceOutputNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1092;512,-1200;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;0;Standard;Meenphie/Lightmapped/Simple/Stochastic/Opaque;False;False;False;False;False;False;False;True;True;False;False;False;False;False;False;True;False;False;True;True;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;ForwardOnly;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0.0001;0,0,0,0;VertexOffset;False;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;1092;0;2858;625
WireConnection;1092;1;2858;238
WireConnection;1092;2;2858;624
WireConnection;1092;3;2858;96
WireConnection;1092;4;2858;97
WireConnection;1092;5;2858;95
ASEEND*/
//CHKSM=43E99CA16DF0D89B9D43C8373111F6C2FAD5F70E