// Made with Amplify Shader Editor v1.9.8.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Fairplex/RNM/Cutout"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		[LS_DrawerCategory(SURFACE OPTIONS,true,_Cull,0,0)]_CATEGORY_SURFACEOPTIONS("CATEGORY_SURFACEOPTIONS", Float) = 1
		_Color("DIffuse Color", Color) = (1,1,1,1)
		[NoScaleOffset][Fairplex_DrawerTextureSingleLine]_MainTex("Diffuse Map", 2D) = "white" {}
		[Fairplex_DrawerTextureSingleLine]_NormalMap("Normal Map", 2D) = "bump" {}
		_NormalScale("Normal Scale", Float) = 1
		[Fairplex_DrawerTextureSingleLine]_MetallicMap("Metallic Map", 2D) = "white" {}
		[HDR][NoScaleOffset][Fairplex_DrawerTextureSingleLine]_EmissionMap1("Roughness Map", 2D) = "black" {}
		_Metallic("Metallic", Range( 0 , 1)) = 0
		[Fairplex_DrawerCategorySpace(10)]_Glossiness("Smoothness", Range( 0 , 1)) = 0.5
		[Fairplex_DrawerCategory(EMISSION,true,_EMISSION,0,0)]_CATEGORYEMISSION("CATEGORY EMISSION", Float) = 1
		[Fairplex_DrawerToggleLeft]_EMISSION("Enable Emission", Float) = 0
		[HDR][Gamma]_EmissionColor("Emission Color", Color) = (0,0,0)
		[NoScaleOffset][Fairplex_DrawerTextureSingleLine]_EmissionMap("Emission Map", 2D) = "black" {}
		_EmissionIntensity("Intensity", Float) = 0
		[Fairplex_DrawerEmissionFlags]_EmissionFlags("Global Illumination", Float) = 2
		[Fairplex_DrawerSpace(10)]_CATEGORYSPACEEMISSION("CATEGORY SPACE EMISSION", Float) = 0
		[Fairplex_DrawerCategory(LIGHTMAPPING,true,_LightmappingMode,0,0)]_CATEGORYLIGHTMAPPING("CATEGORY LIGHTMAPPING", Float) = 1
		[Fairplex_DrawerToggleLeft]_ENABLELIGHTMAPPING("Enable Lightmapping", Float) = 0
		[Fairplex_DrawerTextureSingleLine]_RNMX0("RNMX 0", 2D) = "gray" {}
		[Fairplex_DrawerTextureSingleLine]_RNMY0("RNMY 0", 2D) = "gray" {}
		[Fairplex_DrawerTextureSingleLine]_RNMZ0("RNMZ 0", 2D) = "gray" {}
		[Fairplex_DrawerTextureSingleLine]_RNMX1("RNMX 1", 2D) = "gray" {}
		[Fairplex_DrawerTextureSingleLine]_RNMY1("RNMY 1", 2D) = "gray" {}
		[Fairplex_DrawerTextureSingleLine]_RNMZ1("RNMZ 1", 2D) = "gray" {}
		_LightmapLerp("LightmapLerp", Range( 0 , 1)) = 0
		_RNMScale("RNM Scale", Float) = 2
		[Fairplex_DrawerToggleLeft]_LIGHTMAPOCCLUSION("Lightmap Occlusion", Float) = 0
		[Fairplex_DrawerSpace(10)]_CATEGORYSPACELIGHTMAPPING("CATEGORY SPACE LIGHTMAPPING", Float) = 0
		[HideInInspector] _texcoord3( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
		[Header(Forward Rendering Options)]
		[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		[ToggleOff] _GlossyReflections("Reflections", Float) = 1.0
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 3.5
		#pragma shader_feature _SPECULARHIGHLIGHTS_OFF
		#pragma shader_feature _GLOSSYREFLECTIONS_OFF
		#define ASE_VERSION 19801
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows novertexlights nodynlightmap nodirlightmap nofog noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
			float2 uv3_texcoord3;
		};

		uniform float _CATEGORY_SURFACEOPTIONS;
		uniform float _CATEGORYSPACEEMISSION;
		uniform float _EmissionFlags;
		uniform float _CATEGORYSPACELIGHTMAPPING;
		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
		float4 _NormalMap_TexelSize;
		uniform float _NormalScale;
		uniform sampler2D _MainTex;
		uniform float4 _Color;
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
		uniform float _CATEGORYLIGHTMAPPING;
		uniform float _ENABLELIGHTMAPPING;
		uniform float _Metallic;
		uniform sampler2D _MetallicMap;
		uniform float4 _MetallicMap_ST;
		uniform float3 _EmissionColor;
		uniform sampler2D _EmissionMap;
		uniform float _EmissionIntensity;
		uniform float _CATEGORYEMISSION;
		uniform float _EMISSION;
		uniform float _Glossiness;
		uniform sampler2D _EmissionMap1;
		uniform float _LIGHTMAPOCCLUSION;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float localBicubicPrepare2_g1847 = ( 0.0 );
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			float2 Input_UV100_g1847 = uv_NormalMap;
			float2 UV2_g1847 = Input_UV100_g1847;
			float4 TexelSize2_g1847 = _NormalMap_TexelSize;
			float2 UV02_g1847 = float2( 0,0 );
			float2 UV12_g1847 = float2( 0,0 );
			float2 UV22_g1847 = float2( 0,0 );
			float2 UV32_g1847 = float2( 0,0 );
			float W02_g1847 = 0;
			float W12_g1847 = 0;
			{
			{
			 UV2_g1847 = UV2_g1847 * TexelSize2_g1847.zw - 0.5;
			    float2 f = frac( UV2_g1847 );
			    UV2_g1847 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g1847.x - 0.5, UV2_g1847.x + 1.5, UV2_g1847.y - 0.5, UV2_g1847.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1847.xyxy;
			    UV02_g1847 = off.xz;
			    UV12_g1847 = off.yz;
			    UV22_g1847 = off.xw;
			    UV32_g1847 = off.yw;
			    W02_g1847 = s.x / ( s.x + s.y );
			 W12_g1847 = s.z / ( s.z + s.w );
			}
			}
			float temp_output_239_0_g1847 = _NormalScale;
			float3 lerpResult46_g1847 = lerp( UnpackScaleNormal( tex2D( _NormalMap, UV32_g1847 ), temp_output_239_0_g1847 ) , UnpackScaleNormal( tex2D( _NormalMap, UV22_g1847 ), temp_output_239_0_g1847 ) , W02_g1847);
			float3 lerpResult45_g1847 = lerp( UnpackScaleNormal( tex2D( _NormalMap, UV12_g1847 ), temp_output_239_0_g1847 ) , UnpackScaleNormal( tex2D( _NormalMap, UV02_g1847 ), temp_output_239_0_g1847 ) , W02_g1847);
			float3 lerpResult44_g1847 = lerp( lerpResult46_g1847 , lerpResult45_g1847 , W12_g1847);
			float3 Output_2D131_g1847 = lerpResult44_g1847;
			o.Normal = Output_2D131_g1847;
			float2 uv_MainTex259_g1846 = i.uv_texcoord;
			float4 tex2DNode259_g1846 = tex2D( _MainTex, uv_MainTex259_g1846 );
			float3 Albedo6_g1846 = ( tex2DNode259_g1846.rgb * _Color.rgb );
			int White38_g1846 = 1;
			float4 temp_cast_2 = White38_g1846;
			float3 appendResult139_g1855 = (float3(sqrt( ( 3.0 / 2.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float localBicubicPrepare2_g1856 = ( 0.0 );
			float2 Input_UV100_g1856 = uv_NormalMap;
			float2 UV2_g1856 = Input_UV100_g1856;
			float4 TexelSize2_g1856 = _NormalMap_TexelSize;
			float2 UV02_g1856 = float2( 0,0 );
			float2 UV12_g1856 = float2( 0,0 );
			float2 UV22_g1856 = float2( 0,0 );
			float2 UV32_g1856 = float2( 0,0 );
			float W02_g1856 = 0;
			float W12_g1856 = 0;
			{
			{
			 UV2_g1856 = UV2_g1856 * TexelSize2_g1856.zw - 0.5;
			    float2 f = frac( UV2_g1856 );
			    UV2_g1856 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g1856.x - 0.5, UV2_g1856.x + 1.5, UV2_g1856.y - 0.5, UV2_g1856.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1856.xyxy;
			    UV02_g1856 = off.xz;
			    UV12_g1856 = off.yz;
			    UV22_g1856 = off.xw;
			    UV32_g1856 = off.yw;
			    W02_g1856 = s.x / ( s.x + s.y );
			 W12_g1856 = s.z / ( s.z + s.w );
			}
			}
			float temp_output_239_0_g1856 = _RNMScale;
			float3 lerpResult46_g1856 = lerp( UnpackScaleNormal( tex2D( _NormalMap, UV32_g1856 ), temp_output_239_0_g1856 ) , UnpackScaleNormal( tex2D( _NormalMap, UV22_g1856 ), temp_output_239_0_g1856 ) , W02_g1856);
			float3 lerpResult45_g1856 = lerp( UnpackScaleNormal( tex2D( _NormalMap, UV12_g1856 ), temp_output_239_0_g1856 ) , UnpackScaleNormal( tex2D( _NormalMap, UV02_g1856 ), temp_output_239_0_g1856 ) , W02_g1856);
			float3 lerpResult44_g1856 = lerp( lerpResult46_g1856 , lerpResult45_g1856 , W12_g1856);
			float3 Output_2D131_g1856 = lerpResult44_g1856;
			float3 normalizeResult326_g1855 = normalize( Output_2D131_g1856 );
			float3 Normal_Map318_g1855 = normalizeResult326_g1855;
			float dotResult121_g1855 = dot( appendResult139_g1855 , Normal_Map318_g1855 );
			float localStochasticTiling2_g1862 = ( 0.0 );
			float2 uv3_RNMX0 = i.uv3_texcoord3 * _RNMX0_ST.xy + _RNMX0_ST.zw;
			float2 UV2_g1862 = uv3_RNMX0;
			float4 TexelSize2_g1862 = _RNMX0_TexelSize;
			float4 Offsets2_g1862 = float4( 0,0,0,0 );
			float2 Weights2_g1862 = float2( 0,0 );
			{
			UV2_g1862 = UV2_g1862 * TexelSize2_g1862.zw - 0.5;
			float2 f = frac( UV2_g1862 );
			UV2_g1862 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g1862.x - 0.5, UV2_g1862.x + 1.5, UV2_g1862.y - 0.5, UV2_g1862.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g1862 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1862.xyxy;
			Weights2_g1862 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g1859 = Offsets2_g1862;
			float4 Input_FetchOffsets197_g1863 = temp_output_1_34_g1859;
			float2 temp_output_1_54_g1859 = Weights2_g1862;
			float2 Input_FetchWeights200_g1863 = temp_output_1_54_g1859;
			float2 break187_g1863 = Input_FetchWeights200_g1863;
			float4 lerpResult181_g1863 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g1863).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g1863).xw ) , break187_g1863.x);
			float4 lerpResult182_g1863 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g1863).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g1863).xz ) , break187_g1863.x);
			float4 lerpResult176_g1863 = lerp( lerpResult181_g1863 , lerpResult182_g1863 , break187_g1863.y);
			float4 Output_Fetch2D202_g1863 = lerpResult176_g1863;
			float3 appendResult146_g1855 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g1855 = dot( appendResult146_g1855 , Normal_Map318_g1855 );
			float4 Input_FetchOffsets197_g1860 = temp_output_1_34_g1859;
			float2 Input_FetchWeights200_g1860 = temp_output_1_54_g1859;
			float2 break187_g1860 = Input_FetchWeights200_g1860;
			float4 lerpResult181_g1860 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g1860).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g1860).xw ) , break187_g1860.x);
			float4 lerpResult182_g1860 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g1860).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g1860).xz ) , break187_g1860.x);
			float4 lerpResult176_g1860 = lerp( lerpResult181_g1860 , lerpResult182_g1860 , break187_g1860.y);
			float4 Output_Fetch2D202_g1860 = lerpResult176_g1860;
			float3 appendResult149_g1855 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g1855 = dot( appendResult149_g1855 , Normal_Map318_g1855 );
			float4 Input_FetchOffsets197_g1861 = temp_output_1_34_g1859;
			float2 Input_FetchWeights200_g1861 = temp_output_1_54_g1859;
			float2 break187_g1861 = Input_FetchWeights200_g1861;
			float4 lerpResult181_g1861 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g1861).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g1861).xw ) , break187_g1861.x);
			float4 lerpResult182_g1861 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g1861).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g1861).xz ) , break187_g1861.x);
			float4 lerpResult176_g1861 = lerp( lerpResult181_g1861 , lerpResult182_g1861 , break187_g1861.y);
			float4 Output_Fetch2D202_g1861 = lerpResult176_g1861;
			float4 temp_output_429_0_g1846 = ( ( ( saturate( dotResult121_g1855 ) * ( Output_Fetch2D202_g1863 * 0.75 ) ) + ( saturate( dotResult122_g1855 ) * ( Output_Fetch2D202_g1860 * 0.75 ) ) ) + ( saturate( dotResult120_g1855 ) * ( Output_Fetch2D202_g1861 * 0.75 ) ) );
			float3 appendResult139_g1857 = (float3(sqrt( ( 3.0 / 2.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float localBicubicPrepare2_g1858 = ( 0.0 );
			float2 Input_UV100_g1858 = uv_NormalMap;
			float2 UV2_g1858 = Input_UV100_g1858;
			float4 TexelSize2_g1858 = _NormalMap_TexelSize;
			float2 UV02_g1858 = float2( 0,0 );
			float2 UV12_g1858 = float2( 0,0 );
			float2 UV22_g1858 = float2( 0,0 );
			float2 UV32_g1858 = float2( 0,0 );
			float W02_g1858 = 0;
			float W12_g1858 = 0;
			{
			{
			 UV2_g1858 = UV2_g1858 * TexelSize2_g1858.zw - 0.5;
			    float2 f = frac( UV2_g1858 );
			    UV2_g1858 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g1858.x - 0.5, UV2_g1858.x + 1.5, UV2_g1858.y - 0.5, UV2_g1858.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1858.xyxy;
			    UV02_g1858 = off.xz;
			    UV12_g1858 = off.yz;
			    UV22_g1858 = off.xw;
			    UV32_g1858 = off.yw;
			    W02_g1858 = s.x / ( s.x + s.y );
			 W12_g1858 = s.z / ( s.z + s.w );
			}
			}
			float RNM_Scale447_g1846 = _RNMScale;
			float temp_output_239_0_g1858 = RNM_Scale447_g1846;
			float3 lerpResult46_g1858 = lerp( UnpackScaleNormal( tex2D( _NormalMap, UV32_g1858 ), temp_output_239_0_g1858 ) , UnpackScaleNormal( tex2D( _NormalMap, UV22_g1858 ), temp_output_239_0_g1858 ) , W02_g1858);
			float3 lerpResult45_g1858 = lerp( UnpackScaleNormal( tex2D( _NormalMap, UV12_g1858 ), temp_output_239_0_g1858 ) , UnpackScaleNormal( tex2D( _NormalMap, UV02_g1858 ), temp_output_239_0_g1858 ) , W02_g1858);
			float3 lerpResult44_g1858 = lerp( lerpResult46_g1858 , lerpResult45_g1858 , W12_g1858);
			float3 Output_2D131_g1858 = lerpResult44_g1858;
			float3 normalizeResult326_g1857 = normalize( Output_2D131_g1858 );
			float3 Normal_Map318_g1857 = normalizeResult326_g1857;
			float dotResult121_g1857 = dot( appendResult139_g1857 , Normal_Map318_g1857 );
			float localStochasticTiling2_g1851 = ( 0.0 );
			float2 uv3_RNMX1 = i.uv3_texcoord3 * _RNMX1_ST.xy + _RNMX1_ST.zw;
			float2 UV2_g1851 = uv3_RNMX1;
			float4 TexelSize2_g1851 = _RNMX1_TexelSize;
			float4 Offsets2_g1851 = float4( 0,0,0,0 );
			float2 Weights2_g1851 = float2( 0,0 );
			{
			UV2_g1851 = UV2_g1851 * TexelSize2_g1851.zw - 0.5;
			float2 f = frac( UV2_g1851 );
			UV2_g1851 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g1851.x - 0.5, UV2_g1851.x + 1.5, UV2_g1851.y - 0.5, UV2_g1851.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g1851 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1851.xyxy;
			Weights2_g1851 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g1848 = Offsets2_g1851;
			float4 Input_FetchOffsets197_g1852 = temp_output_1_34_g1848;
			float2 temp_output_1_54_g1848 = Weights2_g1851;
			float2 Input_FetchWeights200_g1852 = temp_output_1_54_g1848;
			float2 break187_g1852 = Input_FetchWeights200_g1852;
			float4 lerpResult181_g1852 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g1852).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g1852).xw ) , break187_g1852.x);
			float4 lerpResult182_g1852 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g1852).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g1852).xz ) , break187_g1852.x);
			float4 lerpResult176_g1852 = lerp( lerpResult181_g1852 , lerpResult182_g1852 , break187_g1852.y);
			float4 Output_Fetch2D202_g1852 = lerpResult176_g1852;
			float3 appendResult146_g1857 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g1857 = dot( appendResult146_g1857 , Normal_Map318_g1857 );
			float4 Input_FetchOffsets197_g1849 = temp_output_1_34_g1848;
			float2 Input_FetchWeights200_g1849 = temp_output_1_54_g1848;
			float2 break187_g1849 = Input_FetchWeights200_g1849;
			float4 lerpResult181_g1849 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g1849).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g1849).xw ) , break187_g1849.x);
			float4 lerpResult182_g1849 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g1849).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g1849).xz ) , break187_g1849.x);
			float4 lerpResult176_g1849 = lerp( lerpResult181_g1849 , lerpResult182_g1849 , break187_g1849.y);
			float4 Output_Fetch2D202_g1849 = lerpResult176_g1849;
			float3 appendResult149_g1857 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g1857 = dot( appendResult149_g1857 , Normal_Map318_g1857 );
			float4 Input_FetchOffsets197_g1850 = temp_output_1_34_g1848;
			float2 Input_FetchWeights200_g1850 = temp_output_1_54_g1848;
			float2 break187_g1850 = Input_FetchWeights200_g1850;
			float4 lerpResult181_g1850 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g1850).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g1850).xw ) , break187_g1850.x);
			float4 lerpResult182_g1850 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g1850).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g1850).xz ) , break187_g1850.x);
			float4 lerpResult176_g1850 = lerp( lerpResult181_g1850 , lerpResult182_g1850 , break187_g1850.y);
			float4 Output_Fetch2D202_g1850 = lerpResult176_g1850;
			float4 lerpResult442_g1846 = lerp( temp_output_429_0_g1846 , ( ( ( saturate( dotResult121_g1857 ) * ( Output_Fetch2D202_g1852 * 0.75 ) ) + ( saturate( dotResult122_g1857 ) * ( Output_Fetch2D202_g1849 * 0.75 ) ) ) + ( saturate( dotResult120_g1857 ) * ( Output_Fetch2D202_g1850 * 0.75 ) ) ) , _LightmapLerp);
			float Enable_Lightmapping115_g1846 = _ENABLELIGHTMAPPING;
			float4 lerpResult114_g1846 = lerp( temp_cast_2 , ( lerpResult442_g1846 + ( ( _CATEGORYLIGHTMAPPING + _CATEGORYSPACELIGHTMAPPING ) * 0.0 ) ) , Enable_Lightmapping115_g1846);
			float4 Lightmap46_g1846 = lerpResult114_g1846;
			float4 lerpResult174_g1846 = lerp( float4( Albedo6_g1846 , 0.0 ) , ( float4( Albedo6_g1846 , 0.0 ) * Lightmap46_g1846 ) , Enable_Lightmapping115_g1846);
			o.Albedo = lerpResult174_g1846.rgb;
			float2 uv_MetallicMap = i.uv_texcoord * _MetallicMap_ST.xy + _MetallicMap_ST.zw;
			float3 Metallic54_g1846 = ( _Metallic * tex2D( _MetallicMap, uv_MetallicMap ).rgb );
			float3 lerpResult189_g1846 = lerp( float3( 0,0,0 ) , ( 1.0 - Metallic54_g1846 ) , Enable_Lightmapping115_g1846);
			float2 uv_EmissionMap81_g1846 = i.uv_texcoord;
			float3 lerpResult98_g1846 = lerp( float3( 0,0,0 ) , ( ( ( _EmissionColor + tex2D( _EmissionMap, uv_EmissionMap81_g1846 ).rgb ) * _EmissionIntensity ) + ( ( _CATEGORYEMISSION + _CATEGORYSPACEEMISSION ) * 0.0 ) ) , _EMISSION);
			float3 Emission86_g1846 = lerpResult98_g1846;
			o.Emission = ( ( lerpResult174_g1846 * float4( lerpResult189_g1846 , 0.0 ) ) + float4( Emission86_g1846 , 0.0 ) ).rgb;
			o.Metallic = Metallic54_g1846.x;
			float2 uv_EmissionMap164_g1846 = i.uv_texcoord;
			float4 Roughness326_g1846 = ( _Glossiness * ( 1.0 - tex2D( _EmissionMap1, uv_EmissionMap164_g1846 ) ) );
			o.Smoothness = Roughness326_g1846.r;
			float4 temp_cast_9 = White38_g1846;
			float4 clampResult67_g1846 = clamp( Lightmap46_g1846 , float4( 0,0,0,0 ) , float4( 1,0,0,0 ) );
			float4 lerpResult105_g1846 = lerp( temp_cast_9 , clampResult67_g1846 , _LIGHTMAPOCCLUSION);
			o.Occlusion = lerpResult105_g1846.r;
			o.Alpha = 1;
			clip( tex2DNode259_g1846.a - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "Fairplex_ShaderGUI"
}
/*ASEBEGIN
Version=19801
Node;AmplifyShaderEditor.FunctionNode;832;208,-1200;Inherit;False;Fairplex Default;1;;1846;b3ba55a08dd6b49c7be16c6f35cf2033;4,169,1,186,1,162,1,120,2;0;8;COLOR;0;FLOAT3;238;COLOR;94;FLOAT3;96;COLOR;97;COLOR;95;FLOAT;156;FLOAT;427
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;343;512,-1200;Float;False;True;-1;3;Fairplex_ShaderGUI;0;0;Standard;Fairplex/RNM/Cutout;False;False;False;False;False;True;False;True;True;True;False;True;False;False;True;False;False;False;True;True;False;Off;0;False;;0;False;;False;0;False;;0;False;;False;0;Masked;0.5;True;True;0;False;TransparentCutout;;AlphaTest;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0.0001;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;343;0;832;0
WireConnection;343;1;832;238
WireConnection;343;2;832;94
WireConnection;343;3;832;96
WireConnection;343;4;832;97
WireConnection;343;5;832;95
WireConnection;343;10;832;427
ASEEND*/
//CHKSM=AD697EBCE43B34E447646BA34D076F45DB0C48A5