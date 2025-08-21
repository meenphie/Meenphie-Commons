// Made with Amplify Shader Editor v1.9.9.4
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Lightmapped/RNM/Opaque (Outline)"
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
		[Toggle( _EMISSION_ON )] _EMISSION( "Emission Enabled", Float ) = 0
		[HDR][Gamma] _EmissionColor( "Emission Color", Color ) = ( 0, 0, 0, 0 )
		[NoScaleOffset][SingleLineTexture] _EmissionMap( "Emission Map", 2D ) = "black" {}
		[Meenphie_DrawerEmissionFlags] _EmissionFlags( "Global Illumination", Float ) = 2
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACEEMISSION( "CATEGORY SPACE EMISSION", Float ) = 0
		[Meenphie_DrawerCategory(LIGHTMAPPING,true,0,0)] _CATEGORYLIGHTMAPPING( "CATEGORY LIGHTMAPPING", Float ) = 0
		[Meenphie_DrawerTextureSingleLine] _RNMX0( "RNMX 0", 2D ) = "black" {}
		[Meenphie_DrawerTextureSingleLine] _RNMY0( "RNMY 0", 2D ) = "black" {}
		[Meenphie_DrawerTextureSingleLine] _RNMZ0( "RNMZ 0", 2D ) = "black" {}
		[Meenphie_DrawerTextureSingleLine] _RNMX1( "RNMX 1", 2D ) = "black" {}
		[Meenphie_DrawerTextureSingleLine] _RNMY1( "RNMY 1", 2D ) = "black" {}
		[Meenphie_DrawerTextureSingleLine] _RNMZ1( "RNMZ 1", 2D ) = "black" {}
		_LightmapLerp1( "LightmapLerp", Range( 0, 1 ) ) = 1
		[Toggle( _LIGHTMAPOCCLUSION_ON )] _LightmapOcclusion( "Lightmap Occlusion", Float ) = 1
		_OcclusionPower( "Occlusion Power", Float ) = 1
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACELIGHTMAPPING( "CATEGORY SPACE LIGHTMAPPING", Float ) = 0
		[Meenphie_DrawerCategory(OUTLINE,true,0,0)] _CATEGORYOUTLINE( "CATEGORY OUTLINE", Float ) = 0
		_OutlineColor( "Outline Color", Color ) = ( 0.02, 0.02, 0.02, 0 )
		_OutlineWidth( "Outline Width", Range( 0, 0.01 ) ) = 0.005
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACEOUTLINE( "CATEGORY SPACE OUTLINE", Float ) = 0
		[HideInInspector] _texcoord3( "", 2D ) = "white" {}
		[HideInInspector] GenKey__MainTex( "Assign keyword _MAINTEX", Float ) = 1.0
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
		[Header(Forward Rendering Options)]
		[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		[ToggleOff] _GlossyReflections("Reflections", Float) = 1.0
	}

	SubShader
	{
		Tags{ }
		Cull Front
		CGPROGRAM
		#pragma target 3.0
		#pragma surface outlineSurf Outline nofog  keepalpha noshadow noambient novertexlights nolightmap nodynlightmap nodirlightmap nometa noforwardadd vertex:outlineVertexDataFunc 
		
		
		
		
		struct Input
		{
			half filler;
		};
		uniform float4 _OutlineColor;
		uniform float _OutlineWidth;
		
		void outlineVertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float outlineVar = ( _OutlineWidth * v.color.r );
			v.vertex.xyz += ( v.normal * outlineVar );
		}
		inline half4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return half4 ( 0,0,0, s.Alpha); }
		void outlineSurf( Input i, inout SurfaceOutput o )
		{
			o.Emission = _OutlineColor.rgb;
		}
		ENDCG
		

		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "ForceNoShadowCasting" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 3.5
		#pragma shader_feature _SPECULARHIGHLIGHTS_OFF
		#pragma shader_feature _GLOSSYREFLECTIONS_OFF
		#pragma shader_feature_local_fragment _BUMPMAP
		#pragma shader_feature_local_fragment _MAINTEX
		#pragma shader_feature_local_fragment _EMISSION_ON
		#pragma shader_feature_local_fragment _METALLICMAP
		#pragma shader_feature_local_fragment _USEGEOMETRICANTIALIASING_ON
		#pragma shader_feature_local_fragment _GLOSSINESSMAP
		#pragma shader_feature_local_fragment _LIGHTMAPOCCLUSION_ON
		#define ASE_VERSION 19904
		#pragma surface surf Standard keepalpha exclude_path:deferred nodynlightmap nodirlightmap vertex:vertexDataFunc 
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
		uniform float _CATEGORYOUTLINE;
		uniform float _CATEGORYSPACEOUTLINE;
		uniform sampler2D _BumpMap;
		uniform float _NormalScale;
		uniform float4 _Color;
		uniform sampler2D _MainTex;
		uniform float4 _EmissionColor;
		uniform sampler2D _EmissionMap;
		uniform float _Metallic;
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
		uniform float _LightmapLerp1;
		uniform float _CATEGORYLIGHTMAPPING;
		uniform float _CATEGORYSPACELIGHTMAPPING;
		uniform sampler2D _MetallicMap;
		uniform float _Glossiness;
		uniform sampler2D _GlossinessMap;
		uniform float _OcclusionPower;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float Outline_GUI888_g1402 = ( _CATEGORYOUTLINE + _CATEGORYSPACEOUTLINE );
			float3 temp_cast_0 = (Outline_GUI888_g1402).xxx;
			float3 lerpResult889_g1402 = lerp( 0 , temp_cast_0 , float3( 0,0,0 ));
			v.vertex.xyz += lerpResult889_g1402;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BumpMap830_g1402 = i.uv_texcoord;
			#ifdef _BUMPMAP
				float3 staticSwitch844_g1402 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap830_g1402 ), _NormalScale );
			#else
				float3 staticSwitch844_g1402 = float3( 0, 0, 1 );
			#endif
			float3 Normal_Map700_g1402 = staticSwitch844_g1402;
			o.Normal = Normal_Map700_g1402;
			float2 uv_MainTex907_g1402 = i.uv_texcoord;
			#ifdef _MAINTEX
				float4 staticSwitch899_g1402 = tex2D( _MainTex, uv_MainTex907_g1402 );
			#else
				float4 staticSwitch899_g1402 = _Color;
			#endif
			float4 Albedo6_g1402 = staticSwitch899_g1402;
			o.Albedo = Albedo6_g1402.rgb;
			float4 temp_cast_1 = 0;
			float2 uv_EmissionMap81_g1402 = i.uv_texcoord;
			#ifdef _EMISSION_ON
				float4 staticSwitch851_g1402 = ( _EmissionColor + tex2D( _EmissionMap, uv_EmissionMap81_g1402 ) );
			#else
				float4 staticSwitch851_g1402 = temp_cast_1;
			#endif
			float4 Emission86_g1402 = staticSwitch851_g1402;
			float Metallic_Value893_g1402 = _Metallic;
			float3 appendResult139_g1418 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float3 normalizeResult326_g1418 = normalize( Normal_Map700_g1402 );
			float3 Normal_Map318_g1418 = normalizeResult326_g1418;
			float dotResult121_g1418 = dot( appendResult139_g1418 , Normal_Map318_g1418 );
			float localStochasticTiling2_g1414 = ( 0.0 );
			float2 uv3_RNMX0 = i.uv3_texcoord3 * _RNMX0_ST.xy + _RNMX0_ST.zw;
			float2 UV2_g1414 = uv3_RNMX0;
			float4 TexelSize2_g1414 = _RNMX0_TexelSize;
			float4 Offsets2_g1414 = float4( 0,0,0,0 );
			float2 Weights2_g1414 = float2( 0,0 );
			{
			UV2_g1414 = UV2_g1414 * TexelSize2_g1414.zw - 0.5;
			float2 f = frac( UV2_g1414 );
			UV2_g1414 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g1414.x - 0.5, UV2_g1414.x + 1.5, UV2_g1414.y - 0.5, UV2_g1414.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g1414 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1414.xyxy;
			Weights2_g1414 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g1413 = Offsets2_g1414;
			float4 Input_FetchOffsets197_g1417 = temp_output_1_34_g1413;
			float2 temp_output_1_54_g1413 = Weights2_g1414;
			float2 Input_FetchWeights200_g1417 = temp_output_1_54_g1413;
			float2 break187_g1417 = Input_FetchWeights200_g1417;
			float4 lerpResult181_g1417 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g1417).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g1417).xw ) , break187_g1417.x);
			float4 lerpResult182_g1417 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g1417).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g1417).xz ) , break187_g1417.x);
			float4 lerpResult176_g1417 = lerp( lerpResult181_g1417 , lerpResult182_g1417 , break187_g1417.y);
			float4 Output_Fetch2D202_g1417 = lerpResult176_g1417;
			float3 appendResult146_g1418 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g1418 = dot( appendResult146_g1418 , Normal_Map318_g1418 );
			float4 Input_FetchOffsets197_g1415 = temp_output_1_34_g1413;
			float2 Input_FetchWeights200_g1415 = temp_output_1_54_g1413;
			float2 break187_g1415 = Input_FetchWeights200_g1415;
			float4 lerpResult181_g1415 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g1415).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g1415).xw ) , break187_g1415.x);
			float4 lerpResult182_g1415 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g1415).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g1415).xz ) , break187_g1415.x);
			float4 lerpResult176_g1415 = lerp( lerpResult181_g1415 , lerpResult182_g1415 , break187_g1415.y);
			float4 Output_Fetch2D202_g1415 = lerpResult176_g1415;
			float3 appendResult149_g1418 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g1418 = dot( appendResult149_g1418 , Normal_Map318_g1418 );
			float4 Input_FetchOffsets197_g1416 = temp_output_1_34_g1413;
			float2 Input_FetchWeights200_g1416 = temp_output_1_54_g1413;
			float2 break187_g1416 = Input_FetchWeights200_g1416;
			float4 lerpResult181_g1416 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g1416).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g1416).xw ) , break187_g1416.x);
			float4 lerpResult182_g1416 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g1416).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g1416).xz ) , break187_g1416.x);
			float4 lerpResult176_g1416 = lerp( lerpResult181_g1416 , lerpResult182_g1416 , break187_g1416.y);
			float4 Output_Fetch2D202_g1416 = lerpResult176_g1416;
			float4 RNM_0926_g1402 = ( ( ( saturate( dotResult121_g1418 ) * ( Output_Fetch2D202_g1417 * 0.8 ) ) + ( saturate( dotResult122_g1418 ) * ( Output_Fetch2D202_g1415 * 0.8 ) ) ) + ( saturate( dotResult120_g1418 ) * ( Output_Fetch2D202_g1416 * 0.8 ) ) );
			float3 appendResult139_g1419 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float3 normalizeResult326_g1419 = normalize( Normal_Map700_g1402 );
			float3 Normal_Map318_g1419 = normalizeResult326_g1419;
			float dotResult121_g1419 = dot( appendResult139_g1419 , Normal_Map318_g1419 );
			float localStochasticTiling2_g1409 = ( 0.0 );
			float2 uv3_RNMX1 = i.uv3_texcoord3 * _RNMX1_ST.xy + _RNMX1_ST.zw;
			float2 UV2_g1409 = uv3_RNMX1;
			float4 TexelSize2_g1409 = _RNMX1_TexelSize;
			float4 Offsets2_g1409 = float4( 0,0,0,0 );
			float2 Weights2_g1409 = float2( 0,0 );
			{
			UV2_g1409 = UV2_g1409 * TexelSize2_g1409.zw - 0.5;
			float2 f = frac( UV2_g1409 );
			UV2_g1409 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g1409.x - 0.5, UV2_g1409.x + 1.5, UV2_g1409.y - 0.5, UV2_g1409.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g1409 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1409.xyxy;
			Weights2_g1409 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g1408 = Offsets2_g1409;
			float4 Input_FetchOffsets197_g1412 = temp_output_1_34_g1408;
			float2 temp_output_1_54_g1408 = Weights2_g1409;
			float2 Input_FetchWeights200_g1412 = temp_output_1_54_g1408;
			float2 break187_g1412 = Input_FetchWeights200_g1412;
			float4 lerpResult181_g1412 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g1412).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g1412).xw ) , break187_g1412.x);
			float4 lerpResult182_g1412 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g1412).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g1412).xz ) , break187_g1412.x);
			float4 lerpResult176_g1412 = lerp( lerpResult181_g1412 , lerpResult182_g1412 , break187_g1412.y);
			float4 Output_Fetch2D202_g1412 = lerpResult176_g1412;
			float3 appendResult146_g1419 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g1419 = dot( appendResult146_g1419 , Normal_Map318_g1419 );
			float4 Input_FetchOffsets197_g1410 = temp_output_1_34_g1408;
			float2 Input_FetchWeights200_g1410 = temp_output_1_54_g1408;
			float2 break187_g1410 = Input_FetchWeights200_g1410;
			float4 lerpResult181_g1410 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g1410).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g1410).xw ) , break187_g1410.x);
			float4 lerpResult182_g1410 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g1410).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g1410).xz ) , break187_g1410.x);
			float4 lerpResult176_g1410 = lerp( lerpResult181_g1410 , lerpResult182_g1410 , break187_g1410.y);
			float4 Output_Fetch2D202_g1410 = lerpResult176_g1410;
			float3 appendResult149_g1419 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g1419 = dot( appendResult149_g1419 , Normal_Map318_g1419 );
			float4 Input_FetchOffsets197_g1411 = temp_output_1_34_g1408;
			float2 Input_FetchWeights200_g1411 = temp_output_1_54_g1408;
			float2 break187_g1411 = Input_FetchWeights200_g1411;
			float4 lerpResult181_g1411 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g1411).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g1411).xw ) , break187_g1411.x);
			float4 lerpResult182_g1411 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g1411).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g1411).xz ) , break187_g1411.x);
			float4 lerpResult176_g1411 = lerp( lerpResult181_g1411 , lerpResult182_g1411 , break187_g1411.y);
			float4 Output_Fetch2D202_g1411 = lerpResult176_g1411;
			float4 RNM_1927_g1402 = ( ( ( saturate( dotResult121_g1419 ) * ( Output_Fetch2D202_g1412 * 0.8 ) ) + ( saturate( dotResult122_g1419 ) * ( Output_Fetch2D202_g1410 * 0.8 ) ) ) + ( saturate( dotResult120_g1419 ) * ( Output_Fetch2D202_g1411 * 0.8 ) ) );
			float4 lerpResult953_g1402 = lerp( RNM_0926_g1402 , RNM_1927_g1402 , _LightmapLerp1);
			float4 RNM_Lerp950_g1402 = lerpResult953_g1402;
			float Lightmap_GUI886_g1402 = ( _CATEGORYLIGHTMAPPING + _CATEGORYSPACELIGHTMAPPING );
			float4 temp_cast_2 = (Lightmap_GUI886_g1402).xxxx;
			float4 lerpResult882_g1402 = lerp( RNM_Lerp950_g1402 , temp_cast_2 , float4( 0,0,0,0 ));
			float4 Lightmap46_g1402 = lerpResult882_g1402;
			float4 temp_output_614_0_g1402 = ( Albedo6_g1402 * ( ( 1.0 - Metallic_Value893_g1402 ) * Lightmap46_g1402 ) );
			o.Emission = ( Emission86_g1402 + temp_output_614_0_g1402 ).rgb;
			float2 uv_MetallicMap48_g1402 = i.uv_texcoord;
			float saferPower803_g1402 = abs( tex2D( _MetallicMap, uv_MetallicMap48_g1402 ).a );
			#ifdef _METALLICMAP
				float staticSwitch846_g1402 = pow( saferPower803_g1402 , 3.0 );
			#else
				float staticSwitch846_g1402 = _Metallic;
			#endif
			float Metallic699_g1402 = staticSwitch846_g1402;
			o.Metallic = Metallic699_g1402;
			float2 uv_GlossinessMap64_g1402 = i.uv_texcoord;
			float saferPower804_g1402 = abs( tex2D( _GlossinessMap, uv_GlossinessMap64_g1402 ).a );
			#ifdef _GLOSSINESSMAP
				float staticSwitch845_g1402 = ( 1.0 - pow( saferPower804_g1402 , 3.0 ) );
			#else
				float staticSwitch845_g1402 = _Glossiness;
			#endif
			float3 ase_normalWS = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 temp_output_3_0_g1403 = ddx( ase_normalWS );
			float dotResult5_g1403 = dot( temp_output_3_0_g1403 , temp_output_3_0_g1403 );
			float3 temp_output_4_0_g1403 = ddy( ase_normalWS );
			float dotResult6_g1403 = dot( temp_output_4_0_g1403 , temp_output_4_0_g1403 );
			#ifdef _USEGEOMETRICANTIALIASING_ON
				float staticSwitch824_g1402 = min( staticSwitch845_g1402 , ( 1.0 - pow( saturate( max( dotResult5_g1403 , dotResult6_g1403 ) ) , 0.333 ) ) );
			#else
				float staticSwitch824_g1402 = staticSwitch845_g1402;
			#endif
			o.Smoothness = staticSwitch824_g1402;
			float White38_g1402 = 1.0;
			float dotResult835_g1402 = dot( Lightmap46_g1402 , float4( float3( 0.299, 0.587, 0.114 ) , 0.0 ) );
			float saferPower606_g1402 = abs( dotResult835_g1402 );
			#ifdef _LIGHTMAPOCCLUSION_ON
				float staticSwitch573_g1402 = pow( saferPower606_g1402 , _OcclusionPower );
			#else
				float staticSwitch573_g1402 = White38_g1402;
			#endif
			o.Occlusion = staticSwitch573_g1402;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19904
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2859;192,-1200;Inherit;False;Meenphie;0;;1402;b3ba55a08dd6b49c7be16c6f35cf2033;10,871,1,872,1,869,1,847,1,867,1,947,0,912,0,944,0,938,0,905,0;0;9;COLOR;625;FLOAT3;238;COLOR;624;FLOAT;96;FLOAT;97;FLOAT;95;FLOAT;156;FLOAT;427;FLOAT3;860
Node;AmplifyShaderEditor.StandardSurfaceOutputNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1092;512,-1200;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;0;Standard;Meenphie/Lightmapped/RNM/Opaque (Outline);False;False;False;False;False;False;False;True;True;False;False;False;False;False;False;True;False;False;True;True;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;ForwardOnly;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0.0001;0,0,0,0;VertexOffset;False;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;1092;0;2859;625
WireConnection;1092;1;2859;238
WireConnection;1092;2;2859;624
WireConnection;1092;3;2859;96
WireConnection;1092;4;2859;97
WireConnection;1092;5;2859;95
WireConnection;1092;11;2859;860
ASEEND*/
//CHKSM=9AB60A4298DAACB00A59FE0617E3B81FD4CA848F