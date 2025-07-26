// Made with Amplify Shader Editor v1.9.9.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Cutout"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		[Meenphie_DrawerCategory(SURFACE OPTIONS,true,0,0)] _CATEGORY_SURFACEOPTIONS( "CATEGORY_SURFACEOPTIONS", Float ) = 1
		_Color( "DIffuse Color", Color ) = ( 0.9058824, 0.9058824, 0.9058824, 1 )
		[NoScaleOffset][Meenphie_DrawerTextureSingleLine] _MainTex( "Diffuse Map", 2D ) = "white" {}
		[Meenphie_DrawerTextureSingleLine] _BumpMap( "Normal Map", 2D ) = "bump" {}
		_NormalScale( "Normal Scale", Float ) = 1
		[Meenphie_DrawerTextureSingleLine] _MetallicMap( "Metallic Map", 2D ) = "white" {}
		[HDR][NoScaleOffset][Meenphie_DrawerTextureSingleLine] _EmissionMap1( "Roughness Map", 2D ) = "black" {}
		_Metallic( "Metallic", Range( 0, 1 ) ) = 0
		_Glossiness( "Smoothness", Range( 0, 1 ) ) = 0.5
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESURFACEOPTIONS( "CATEGORY SPACE SURFACEOPTIONS", Float ) = 0
		[Meenphie_DrawerCategory(EMISSION,true,0,0)] _CATEGORYEMISSION( "CATEGORY EMISSION", Float ) = 1
		[Toggle( _EMISSION_ON )] _EMISSION( "Emission Enabled", Float ) = 0
		[HDR][Gamma] _EmissionColor( "Emission Color", Color ) = ( 0, 0, 0 )
		[NoScaleOffset][Meenphie_DrawerTextureSingleLine] _EmissionMap( "Emission Map", 2D ) = "black" {}
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
		_LightmapLerp( "LightmapLerp", Range( 0, 1 ) ) = 0
		[Toggle( _LIGHTMAPOCCLUSION_ON )] _LightmapOcclusion( "Lightmap Occlusion", Float ) = 1
		_OcclusionPower( "Occlusion Power", Float ) = 0.5
		[Toggle( _USEBICUBICSAMPLER1_ON )] _UseBicubicSampler1( "Use Bicubic Sampler", Float ) = 0
		[Toggle( _USEBICUBICSAMPLER_ON )] _UseBicubicSampler( "Use Bicubic Sampler", Float ) = 0
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACELIGHTMAPPING( "CATEGORY SPACE LIGHTMAPPING", Float ) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord3( "", 2D ) = "white" {}
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
		#pragma shader_feature _LIGHTMAP_DEBUG_MODE_ON
		#pragma shader_feature_local _LIGHTMAPPING_ON
		#pragma shader_feature_local _EMISSION_ON
		#pragma shader_feature_local _LIGHTMAPPINGMODE_SIMPLE _LIGHTMAPPINGMODE_RNM _LIGHTMAPPINGMODE_RNMLERP
		#pragma shader_feature_local _USEBICUBICSAMPLER1_ON
		#pragma shader_feature_local _USEBICUBICSAMPLER_ON
		#pragma shader_feature_local _LIGHTMAPOCCLUSION_ON
		#define ASE_VERSION 19901
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows novertexlights nodynlightmap nodirlightmap nofog noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
			float2 uv3_texcoord3;
		};

		uniform float _EmissionFlags;
		uniform float _CATEGORYSPACEEMISSION;
		uniform float _CATEGORYSPACESURFACEOPTIONS;
		uniform float _CATEGORYEMISSION;
		uniform float _CATEGORY_SURFACEOPTIONS;
		uniform float _CATEGORYSPACELIGHTMAPPING;
		uniform float _CATEGORYLIGHTMAPPING;
		uniform sampler2D _BumpMap;
		uniform float4 _BumpMap_ST;
		float4 _BumpMap_TexelSize;
		uniform float _NormalScale;
		uniform float4 _Color;
		uniform sampler2D _MainTex;
		uniform float3 _EmissionColor;
		uniform sampler2D _EmissionMap;
		uniform sampler2D _Lightmap;
		uniform float4 _Lightmap_ST;
		float4 _Lightmap_TexelSize;
		uniform sampler2D _RNMX0;
		uniform float4 _RNMX0_ST;
		float4 _RNMX0_TexelSize;
		uniform sampler2D _RNMY0;
		uniform float4 _RNMY0_ST;
		uniform sampler2D _RNMZ0;
		uniform float4 _RNMZ0_ST;
		uniform sampler2D _RNMX1;
		uniform float4 _RNMX1_ST;
		float4 _RNMX1_TexelSize;
		uniform sampler2D _RNMY1;
		uniform float4 _RNMY1_ST;
		uniform sampler2D _RNMZ1;
		uniform float4 _RNMZ1_ST;
		uniform float _LightmapLerp;
		uniform float _Metallic;
		uniform sampler2D _MetallicMap;
		uniform float4 _MetallicMap_ST;
		uniform float _Glossiness;
		uniform sampler2D _EmissionMap1;
		uniform float _OcclusionPower;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float localBicubicPrepare2_g1847 = ( 0.0 );
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float2 Input_UV100_g1847 = uv_BumpMap;
			float2 UV2_g1847 = Input_UV100_g1847;
			float4 TexelSize2_g1847 = _BumpMap_TexelSize;
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
			float3 lerpResult46_g1847 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV32_g1847 ), temp_output_239_0_g1847 ) , UnpackScaleNormal( tex2D( _BumpMap, UV22_g1847 ), temp_output_239_0_g1847 ) , W02_g1847);
			float3 lerpResult45_g1847 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV12_g1847 ), temp_output_239_0_g1847 ) , UnpackScaleNormal( tex2D( _BumpMap, UV02_g1847 ), temp_output_239_0_g1847 ) , W02_g1847);
			float3 lerpResult44_g1847 = lerp( lerpResult46_g1847 , lerpResult45_g1847 , W12_g1847);
			float3 Output_2D131_g1847 = lerpResult44_g1847;
			o.Normal = Output_2D131_g1847;
			float2 uv_MainTex259_g1846 = i.uv_texcoord;
			float4 tex2DNode259_g1846 = tex2D( _MainTex, uv_MainTex259_g1846 );
			float3 temp_output_5_0_g1846 = ( _Color.rgb * tex2DNode259_g1846.rgb );
			o.Albedo = temp_output_5_0_g1846;
			float3 temp_cast_0 = 0;
			float2 uv_EmissionMap81_g1846 = i.uv_texcoord;
			float3 Emission86_g1846 = ( _EmissionColor + tex2D( _EmissionMap, uv_EmissionMap81_g1846 ).rgb );
			#ifdef _EMISSION_ON
				float3 staticSwitch572_g1846 = Emission86_g1846;
			#else
				float3 staticSwitch572_g1846 = temp_cast_0;
			#endif
			float3 Albedo6_g1846 = temp_output_5_0_g1846;
			int White38_g1846 = 1;
			float4 temp_cast_4 = White38_g1846;
			float2 uv_Lightmap = i.uv_texcoord * _Lightmap_ST.xy + _Lightmap_ST.zw;
			float localBicubicPrepare2_g1863 = ( 0.0 );
			float2 uv3_Lightmap = i.uv3_texcoord3 * _Lightmap_ST.xy + _Lightmap_ST.zw;
			float2 Input_UV100_g1863 = uv3_Lightmap;
			float2 UV2_g1863 = Input_UV100_g1863;
			float4 TexelSize2_g1863 = _Lightmap_TexelSize;
			float2 UV02_g1863 = float2( 0,0 );
			float2 UV12_g1863 = float2( 0,0 );
			float2 UV22_g1863 = float2( 0,0 );
			float2 UV32_g1863 = float2( 0,0 );
			float W02_g1863 = 0;
			float W12_g1863 = 0;
			{
			{
			 UV2_g1863 = UV2_g1863 * TexelSize2_g1863.zw - 0.5;
			    float2 f = frac( UV2_g1863 );
			    UV2_g1863 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g1863.x - 0.5, UV2_g1863.x + 1.5, UV2_g1863.y - 0.5, UV2_g1863.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1863.xyxy;
			    UV02_g1863 = off.xz;
			    UV12_g1863 = off.yz;
			    UV22_g1863 = off.xw;
			    UV32_g1863 = off.yw;
			    W02_g1863 = s.x / ( s.x + s.y );
			 W12_g1863 = s.z / ( s.z + s.w );
			}
			}
			float4 lerpResult46_g1863 = lerp( tex2D( _Lightmap, UV32_g1863 ) , tex2D( _Lightmap, UV22_g1863 ) , W02_g1863);
			float4 lerpResult45_g1863 = lerp( tex2D( _Lightmap, UV12_g1863 ) , tex2D( _Lightmap, UV02_g1863 ) , W02_g1863);
			float4 lerpResult44_g1863 = lerp( lerpResult46_g1863 , lerpResult45_g1863 , W12_g1863);
			float4 Output_2D131_g1863 = lerpResult44_g1863;
			#ifdef _USEBICUBICSAMPLER1_ON
				float4 staticSwitch768_g1846 = Output_2D131_g1863;
			#else
				float4 staticSwitch768_g1846 = float4( tex2D( _Lightmap, uv_Lightmap ).rgb , 0.0 );
			#endif
			float3 appendResult139_g1848 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float localBicubicPrepare2_g1849 = ( 0.0 );
			float2 Input_UV100_g1849 = uv_BumpMap;
			float2 UV2_g1849 = Input_UV100_g1849;
			float4 TexelSize2_g1849 = _BumpMap_TexelSize;
			float2 UV02_g1849 = float2( 0,0 );
			float2 UV12_g1849 = float2( 0,0 );
			float2 UV22_g1849 = float2( 0,0 );
			float2 UV32_g1849 = float2( 0,0 );
			float W02_g1849 = 0;
			float W12_g1849 = 0;
			{
			{
			 UV2_g1849 = UV2_g1849 * TexelSize2_g1849.zw - 0.5;
			    float2 f = frac( UV2_g1849 );
			    UV2_g1849 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g1849.x - 0.5, UV2_g1849.x + 1.5, UV2_g1849.y - 0.5, UV2_g1849.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1849.xyxy;
			    UV02_g1849 = off.xz;
			    UV12_g1849 = off.yz;
			    UV22_g1849 = off.xw;
			    UV32_g1849 = off.yw;
			    W02_g1849 = s.x / ( s.x + s.y );
			 W12_g1849 = s.z / ( s.z + s.w );
			}
			}
			float Normal_Map_Scale700_g1846 = _NormalScale;
			float temp_output_239_0_g1849 = Normal_Map_Scale700_g1846;
			float3 lerpResult46_g1849 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV32_g1849 ), temp_output_239_0_g1849 ) , UnpackScaleNormal( tex2D( _BumpMap, UV22_g1849 ), temp_output_239_0_g1849 ) , W02_g1849);
			float3 lerpResult45_g1849 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV12_g1849 ), temp_output_239_0_g1849 ) , UnpackScaleNormal( tex2D( _BumpMap, UV02_g1849 ), temp_output_239_0_g1849 ) , W02_g1849);
			float3 lerpResult44_g1849 = lerp( lerpResult46_g1849 , lerpResult45_g1849 , W12_g1849);
			float3 Output_2D131_g1849 = lerpResult44_g1849;
			float3 normalizeResult326_g1848 = normalize( Output_2D131_g1849 );
			float3 Normal_Map318_g1848 = normalizeResult326_g1848;
			float dotResult121_g1848 = dot( appendResult139_g1848 , Normal_Map318_g1848 );
			float2 uv_RNMX0 = i.uv_texcoord * _RNMX0_ST.xy + _RNMX0_ST.zw;
			float localStochasticTiling2_g1853 = ( 0.0 );
			float2 uv3_RNMX0 = i.uv3_texcoord3 * _RNMX0_ST.xy + _RNMX0_ST.zw;
			float2 UV2_g1853 = uv3_RNMX0;
			float4 TexelSize2_g1853 = _RNMX0_TexelSize;
			float4 Offsets2_g1853 = float4( 0,0,0,0 );
			float2 Weights2_g1853 = float2( 0,0 );
			{
			UV2_g1853 = UV2_g1853 * TexelSize2_g1853.zw - 0.5;
			float2 f = frac( UV2_g1853 );
			UV2_g1853 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g1853.x - 0.5, UV2_g1853.x + 1.5, UV2_g1853.y - 0.5, UV2_g1853.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g1853 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1853.xyxy;
			Weights2_g1853 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g1850 = Offsets2_g1853;
			float4 Input_FetchOffsets197_g1854 = temp_output_1_34_g1850;
			float2 temp_output_1_54_g1850 = Weights2_g1853;
			float2 Input_FetchWeights200_g1854 = temp_output_1_54_g1850;
			float2 break187_g1854 = Input_FetchWeights200_g1854;
			float4 lerpResult181_g1854 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g1854).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g1854).xw ) , break187_g1854.x);
			float4 lerpResult182_g1854 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g1854).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g1854).xz ) , break187_g1854.x);
			float4 lerpResult176_g1854 = lerp( lerpResult181_g1854 , lerpResult182_g1854 , break187_g1854.y);
			float4 Output_Fetch2D202_g1854 = lerpResult176_g1854;
			#ifdef _USEBICUBICSAMPLER_ON
				float4 staticSwitch705_g1846 = Output_Fetch2D202_g1854;
			#else
				float4 staticSwitch705_g1846 = float4( tex2D( _RNMX0, uv_RNMX0 ).rgb , 0.0 );
			#endif
			float3 appendResult146_g1848 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g1848 = dot( appendResult146_g1848 , Normal_Map318_g1848 );
			float2 uv_RNMY0 = i.uv_texcoord * _RNMY0_ST.xy + _RNMY0_ST.zw;
			float4 Input_FetchOffsets197_g1851 = temp_output_1_34_g1850;
			float2 Input_FetchWeights200_g1851 = temp_output_1_54_g1850;
			float2 break187_g1851 = Input_FetchWeights200_g1851;
			float4 lerpResult181_g1851 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g1851).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g1851).xw ) , break187_g1851.x);
			float4 lerpResult182_g1851 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g1851).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g1851).xz ) , break187_g1851.x);
			float4 lerpResult176_g1851 = lerp( lerpResult181_g1851 , lerpResult182_g1851 , break187_g1851.y);
			float4 Output_Fetch2D202_g1851 = lerpResult176_g1851;
			#ifdef _USEBICUBICSAMPLER_ON
				float4 staticSwitch715_g1846 = Output_Fetch2D202_g1851;
			#else
				float4 staticSwitch715_g1846 = float4( tex2D( _RNMY0, uv_RNMY0 ).rgb , 0.0 );
			#endif
			float3 appendResult149_g1848 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g1848 = dot( appendResult149_g1848 , Normal_Map318_g1848 );
			float2 uv_RNMZ0 = i.uv_texcoord * _RNMZ0_ST.xy + _RNMZ0_ST.zw;
			float4 Input_FetchOffsets197_g1852 = temp_output_1_34_g1850;
			float2 Input_FetchWeights200_g1852 = temp_output_1_54_g1850;
			float2 break187_g1852 = Input_FetchWeights200_g1852;
			float4 lerpResult181_g1852 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g1852).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g1852).xw ) , break187_g1852.x);
			float4 lerpResult182_g1852 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g1852).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g1852).xz ) , break187_g1852.x);
			float4 lerpResult176_g1852 = lerp( lerpResult181_g1852 , lerpResult182_g1852 , break187_g1852.y);
			float4 Output_Fetch2D202_g1852 = lerpResult176_g1852;
			#ifdef _USEBICUBICSAMPLER_ON
				float4 staticSwitch716_g1846 = Output_Fetch2D202_g1852;
			#else
				float4 staticSwitch716_g1846 = float4( tex2D( _RNMZ0, uv_RNMZ0 ).rgb , 0.0 );
			#endif
			float4 temp_output_714_0_g1846 = ( ( ( saturate( dotResult121_g1848 ) * ( staticSwitch705_g1846 * 1.0 ) ) + ( saturate( dotResult122_g1848 ) * ( staticSwitch715_g1846 * 1.0 ) ) ) + ( saturate( dotResult120_g1848 ) * ( staticSwitch716_g1846 * 1.0 ) ) );
			float3 appendResult139_g1855 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float localBicubicPrepare2_g1856 = ( 0.0 );
			float2 Input_UV100_g1856 = uv_BumpMap;
			float2 UV2_g1856 = Input_UV100_g1856;
			float4 TexelSize2_g1856 = _BumpMap_TexelSize;
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
			float temp_output_239_0_g1856 = Normal_Map_Scale700_g1846;
			float3 lerpResult46_g1856 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV32_g1856 ), temp_output_239_0_g1856 ) , UnpackScaleNormal( tex2D( _BumpMap, UV22_g1856 ), temp_output_239_0_g1856 ) , W02_g1856);
			float3 lerpResult45_g1856 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV12_g1856 ), temp_output_239_0_g1856 ) , UnpackScaleNormal( tex2D( _BumpMap, UV02_g1856 ), temp_output_239_0_g1856 ) , W02_g1856);
			float3 lerpResult44_g1856 = lerp( lerpResult46_g1856 , lerpResult45_g1856 , W12_g1856);
			float3 Output_2D131_g1856 = lerpResult44_g1856;
			float3 normalizeResult326_g1855 = normalize( Output_2D131_g1856 );
			float3 Normal_Map318_g1855 = normalizeResult326_g1855;
			float dotResult121_g1855 = dot( appendResult139_g1855 , Normal_Map318_g1855 );
			float2 uv_RNMX1 = i.uv_texcoord * _RNMX1_ST.xy + _RNMX1_ST.zw;
			float localStochasticTiling2_g1860 = ( 0.0 );
			float2 uv3_RNMX1 = i.uv3_texcoord3 * _RNMX1_ST.xy + _RNMX1_ST.zw;
			float2 UV2_g1860 = uv3_RNMX1;
			float4 TexelSize2_g1860 = _RNMX1_TexelSize;
			float4 Offsets2_g1860 = float4( 0,0,0,0 );
			float2 Weights2_g1860 = float2( 0,0 );
			{
			UV2_g1860 = UV2_g1860 * TexelSize2_g1860.zw - 0.5;
			float2 f = frac( UV2_g1860 );
			UV2_g1860 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g1860.x - 0.5, UV2_g1860.x + 1.5, UV2_g1860.y - 0.5, UV2_g1860.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g1860 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1860.xyxy;
			Weights2_g1860 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g1857 = Offsets2_g1860;
			float4 Input_FetchOffsets197_g1861 = temp_output_1_34_g1857;
			float2 temp_output_1_54_g1857 = Weights2_g1860;
			float2 Input_FetchWeights200_g1861 = temp_output_1_54_g1857;
			float2 break187_g1861 = Input_FetchWeights200_g1861;
			float4 lerpResult181_g1861 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g1861).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g1861).xw ) , break187_g1861.x);
			float4 lerpResult182_g1861 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g1861).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g1861).xz ) , break187_g1861.x);
			float4 lerpResult176_g1861 = lerp( lerpResult181_g1861 , lerpResult182_g1861 , break187_g1861.y);
			float4 Output_Fetch2D202_g1861 = lerpResult176_g1861;
			#ifdef _USEBICUBICSAMPLER_ON
				float4 staticSwitch764_g1846 = Output_Fetch2D202_g1861;
			#else
				float4 staticSwitch764_g1846 = float4( tex2D( _RNMX1, uv_RNMX1 ).rgb , 0.0 );
			#endif
			float3 appendResult146_g1855 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g1855 = dot( appendResult146_g1855 , Normal_Map318_g1855 );
			float2 uv_RNMY1 = i.uv_texcoord * _RNMY1_ST.xy + _RNMY1_ST.zw;
			float4 Input_FetchOffsets197_g1858 = temp_output_1_34_g1857;
			float2 Input_FetchWeights200_g1858 = temp_output_1_54_g1857;
			float2 break187_g1858 = Input_FetchWeights200_g1858;
			float4 lerpResult181_g1858 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g1858).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g1858).xw ) , break187_g1858.x);
			float4 lerpResult182_g1858 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g1858).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g1858).xz ) , break187_g1858.x);
			float4 lerpResult176_g1858 = lerp( lerpResult181_g1858 , lerpResult182_g1858 , break187_g1858.y);
			float4 Output_Fetch2D202_g1858 = lerpResult176_g1858;
			#ifdef _USEBICUBICSAMPLER_ON
				float4 staticSwitch753_g1846 = Output_Fetch2D202_g1858;
			#else
				float4 staticSwitch753_g1846 = float4( tex2D( _RNMY1, uv_RNMY1 ).rgb , 0.0 );
			#endif
			float3 appendResult149_g1855 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g1855 = dot( appendResult149_g1855 , Normal_Map318_g1855 );
			float2 uv_RNMZ1 = i.uv_texcoord * _RNMZ1_ST.xy + _RNMZ1_ST.zw;
			float4 Input_FetchOffsets197_g1859 = temp_output_1_34_g1857;
			float2 Input_FetchWeights200_g1859 = temp_output_1_54_g1857;
			float2 break187_g1859 = Input_FetchWeights200_g1859;
			float4 lerpResult181_g1859 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g1859).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g1859).xw ) , break187_g1859.x);
			float4 lerpResult182_g1859 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g1859).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g1859).xz ) , break187_g1859.x);
			float4 lerpResult176_g1859 = lerp( lerpResult181_g1859 , lerpResult182_g1859 , break187_g1859.y);
			float4 Output_Fetch2D202_g1859 = lerpResult176_g1859;
			#ifdef _USEBICUBICSAMPLER_ON
				float4 staticSwitch750_g1846 = Output_Fetch2D202_g1859;
			#else
				float4 staticSwitch750_g1846 = float4( tex2D( _RNMZ1, uv_RNMZ1 ).rgb , 0.0 );
			#endif
			float4 lerpResult442_g1846 = lerp( temp_output_714_0_g1846 , ( ( ( saturate( dotResult121_g1855 ) * ( staticSwitch764_g1846 * 1.0 ) ) + ( saturate( dotResult122_g1855 ) * ( staticSwitch753_g1846 * 1.0 ) ) ) + ( saturate( dotResult120_g1855 ) * ( staticSwitch750_g1846 * 1.0 ) ) ) , _LightmapLerp);
			#if defined( _LIGHTMAPPINGMODE_SIMPLE )
				float4 staticSwitch565_g1846 = staticSwitch768_g1846;
			#elif defined( _LIGHTMAPPINGMODE_RNM )
				float4 staticSwitch565_g1846 = temp_output_714_0_g1846;
			#elif defined( _LIGHTMAPPINGMODE_RNMLERP )
				float4 staticSwitch565_g1846 = lerpResult442_g1846;
			#else
				float4 staticSwitch565_g1846 = staticSwitch768_g1846;
			#endif
			#ifdef _LIGHTMAPPING_ON
				float4 staticSwitch569_g1846 = staticSwitch565_g1846;
			#else
				float4 staticSwitch569_g1846 = temp_cast_4;
			#endif
			float4 Lightmap46_g1846 = staticSwitch569_g1846;
			#ifdef _LIGHTMAPPING_ON
				float4 staticSwitch566_g1846 = ( float4( Albedo6_g1846 , 0.0 ) * Lightmap46_g1846 );
			#else
				float4 staticSwitch566_g1846 = float4( Albedo6_g1846 , 0.0 );
			#endif
			#ifdef _LIGHTMAPPING_ON
				float4 staticSwitch696_g1846 = ( float4( staticSwitch572_g1846 , 0.0 ) + staticSwitch566_g1846 );
			#else
				float4 staticSwitch696_g1846 = ( float4( staticSwitch572_g1846 , 0.0 ) * staticSwitch566_g1846 );
			#endif
			#ifdef _LIGHTMAP_DEBUG_MODE_ON
				float4 staticSwitch686_g1846 = Lightmap46_g1846;
			#else
				float4 staticSwitch686_g1846 = staticSwitch696_g1846;
			#endif
			o.Emission = staticSwitch686_g1846.rgb;
			float2 uv_MetallicMap = i.uv_texcoord * _MetallicMap_ST.xy + _MetallicMap_ST.zw;
			#ifdef _LIGHTMAP_DEBUG_MODE_ON
				float3 staticSwitch692_g1846 = float3( 0,0,0 );
			#else
				float3 staticSwitch692_g1846 = ( _Metallic * tex2D( _MetallicMap, uv_MetallicMap ).rgb );
			#endif
			float3 Metallic699_g1846 = staticSwitch692_g1846;
			o.Metallic = Metallic699_g1846.x;
			float2 uv_EmissionMap164_g1846 = i.uv_texcoord;
			#ifdef _LIGHTMAP_DEBUG_MODE_ON
				float4 staticSwitch693_g1846 = float4( 0,0,0,0 );
			#else
				float4 staticSwitch693_g1846 = ( _Glossiness * ( 1.0 - tex2D( _EmissionMap1, uv_EmissionMap164_g1846 ) ) );
			#endif
			o.Smoothness = staticSwitch693_g1846.r;
			float4 temp_cast_16 = White38_g1846;
			float4 temp_cast_17 = White38_g1846;
			float4 saferPower606_g1846 = abs( Lightmap46_g1846 );
			float4 temp_cast_18 = (_OcclusionPower).xxxx;
			float4 clampResult579_g1846 = clamp( pow( saferPower606_g1846 , temp_cast_18 ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			#ifdef _LIGHTMAPOCCLUSION_ON
				float4 staticSwitch573_g1846 = clampResult579_g1846;
			#else
				float4 staticSwitch573_g1846 = temp_cast_17;
			#endif
			#ifdef _LIGHTMAPPING_ON
				float4 staticSwitch576_g1846 = staticSwitch573_g1846;
			#else
				float4 staticSwitch576_g1846 = temp_cast_16;
			#endif
			o.Occlusion = staticSwitch576_g1846.r;
			o.Alpha = 1;
			clip( tex2DNode259_g1846.a - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "Fairplex_ShaderGUI"
}
/*ASEBEGIN
Version=19901
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;832;208,-1200;Inherit;False;Meenphie Default;1;;1846;b3ba55a08dd6b49c7be16c6f35cf2033;0;0;8;FLOAT3;625;FLOAT3;238;COLOR;624;FLOAT3;96;COLOR;97;COLOR;95;FLOAT;156;FLOAT;427
Node;AmplifyShaderEditor.StandardSurfaceOutputNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;343;512,-1200;Float;False;True;-1;3;Fairplex_ShaderGUI;0;0;Standard;Meenphie/Cutout;False;False;False;False;False;True;False;True;True;True;False;True;False;False;True;False;False;False;True;True;False;Off;0;False;;0;False;;False;0;False;;0;False;;False;0;Masked;0.5;True;True;0;False;TransparentCutout;;AlphaTest;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0.0001;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;343;0;832;625
WireConnection;343;1;832;238
WireConnection;343;2;832;624
WireConnection;343;3;832;96
WireConnection;343;4;832;97
WireConnection;343;5;832;95
WireConnection;343;10;832;427
ASEEND*/
//CHKSM=D36FE8CBD8C3C24F503EE04A8876881B241F93EB