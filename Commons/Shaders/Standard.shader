// Made with Amplify Shader Editor v1.9.9.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Standard"
{
	Properties
	{
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
		_RNMScale( "RNM Scale", Float ) = 1.5
		_LightmapLerp( "LightmapLerp", Range( 0, 1 ) ) = 0
		[Toggle( _LIGHTMAPOCCLUSION_ON )] _LightmapOcclusion( "Lightmap Occlusion", Float ) = 1
		_OcclusionPower( "Occlusion Power", Float ) = 0.5
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACELIGHTMAPPING( "CATEGORY SPACE LIGHTMAPPING", Float ) = 0
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
		#include "UnityStandardUtils.cginc"
		#pragma target 3.5
		#pragma shader_feature _SPECULARHIGHLIGHTS_OFF
		#pragma shader_feature _GLOSSYREFLECTIONS_OFF
		#pragma shader_feature _LIGHTMAP_DEBUG_MODE_ON
		#pragma shader_feature_local _LIGHTMAPPING_ON
		#pragma shader_feature_local _EMISSION_ON
		#pragma shader_feature_local _LIGHTMAPPINGMODE_SIMPLE _LIGHTMAPPINGMODE_RNM _LIGHTMAPPINGMODE_RNMLERP
		#pragma shader_feature_local _LIGHTMAPOCCLUSION_ON
		#define ASE_VERSION 19901
		#pragma only_renderers d3d11 glcore vulkan 
		#pragma surface surf Standard keepalpha exclude_path:deferred noambient nodynlightmap nodirlightmap 
		struct Input
		{
			float2 uv_texcoord;
			float2 uv3_texcoord3;
		};

		uniform float _EmissionFlags;
		uniform float _CATEGORYSPACEEMISSION;
		uniform float _CATEGORYSPACESURFACEOPTIONS;
		uniform float _CATEGORYSPACELIGHTMAPPING;
		uniform float _CATEGORYLIGHTMAPPING;
		uniform float _CATEGORYEMISSION;
		uniform float _CATEGORY_SURFACEOPTIONS;
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
		uniform float _Metallic;
		uniform sampler2D _MetallicMap;
		uniform float4 _MetallicMap_ST;
		uniform float _Glossiness;
		uniform sampler2D _EmissionMap1;
		uniform float _OcclusionPower;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float localBicubicPrepare2_g3816 = ( 0.0 );
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float2 Input_UV100_g3816 = uv_BumpMap;
			float2 UV2_g3816 = Input_UV100_g3816;
			float4 TexelSize2_g3816 = _BumpMap_TexelSize;
			float2 UV02_g3816 = float2( 0,0 );
			float2 UV12_g3816 = float2( 0,0 );
			float2 UV22_g3816 = float2( 0,0 );
			float2 UV32_g3816 = float2( 0,0 );
			float W02_g3816 = 0;
			float W12_g3816 = 0;
			{
			{
			 UV2_g3816 = UV2_g3816 * TexelSize2_g3816.zw - 0.5;
			    float2 f = frac( UV2_g3816 );
			    UV2_g3816 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g3816.x - 0.5, UV2_g3816.x + 1.5, UV2_g3816.y - 0.5, UV2_g3816.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g3816.xyxy;
			    UV02_g3816 = off.xz;
			    UV12_g3816 = off.yz;
			    UV22_g3816 = off.xw;
			    UV32_g3816 = off.yw;
			    W02_g3816 = s.x / ( s.x + s.y );
			 W12_g3816 = s.z / ( s.z + s.w );
			}
			}
			float temp_output_239_0_g3816 = _NormalScale;
			float3 lerpResult46_g3816 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV32_g3816 ), temp_output_239_0_g3816 ) , UnpackScaleNormal( tex2D( _BumpMap, UV22_g3816 ), temp_output_239_0_g3816 ) , W02_g3816);
			float3 lerpResult45_g3816 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV12_g3816 ), temp_output_239_0_g3816 ) , UnpackScaleNormal( tex2D( _BumpMap, UV02_g3816 ), temp_output_239_0_g3816 ) , W02_g3816);
			float3 lerpResult44_g3816 = lerp( lerpResult46_g3816 , lerpResult45_g3816 , W12_g3816);
			float3 Output_2D131_g3816 = lerpResult44_g3816;
			o.Normal = Output_2D131_g3816;
			float2 uv_MainTex259_g3815 = i.uv_texcoord;
			float4 tex2DNode259_g3815 = tex2D( _MainTex, uv_MainTex259_g3815 );
			float3 temp_output_5_0_g3815 = ( _Color.rgb * tex2DNode259_g3815.rgb );
			o.Albedo = temp_output_5_0_g3815;
			float3 temp_cast_0 = 0;
			float2 uv_EmissionMap81_g3815 = i.uv_texcoord;
			float3 Emission86_g3815 = ( _EmissionColor + tex2D( _EmissionMap, uv_EmissionMap81_g3815 ).rgb );
			#ifdef _EMISSION_ON
				float3 staticSwitch572_g3815 = Emission86_g3815;
			#else
				float3 staticSwitch572_g3815 = temp_cast_0;
			#endif
			float3 Albedo6_g3815 = temp_output_5_0_g3815;
			int White38_g3815 = 1;
			float4 temp_cast_4 = White38_g3815;
			float localBicubicPrepare2_g3823 = ( 0.0 );
			float2 uv3_Lightmap = i.uv3_texcoord3 * _Lightmap_ST.xy + _Lightmap_ST.zw;
			float2 Input_UV100_g3823 = uv3_Lightmap;
			float2 UV2_g3823 = Input_UV100_g3823;
			float4 TexelSize2_g3823 = _Lightmap_TexelSize;
			float2 UV02_g3823 = float2( 0,0 );
			float2 UV12_g3823 = float2( 0,0 );
			float2 UV22_g3823 = float2( 0,0 );
			float2 UV32_g3823 = float2( 0,0 );
			float W02_g3823 = 0;
			float W12_g3823 = 0;
			{
			{
			 UV2_g3823 = UV2_g3823 * TexelSize2_g3823.zw - 0.5;
			    float2 f = frac( UV2_g3823 );
			    UV2_g3823 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g3823.x - 0.5, UV2_g3823.x + 1.5, UV2_g3823.y - 0.5, UV2_g3823.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g3823.xyxy;
			    UV02_g3823 = off.xz;
			    UV12_g3823 = off.yz;
			    UV22_g3823 = off.xw;
			    UV32_g3823 = off.yw;
			    W02_g3823 = s.x / ( s.x + s.y );
			 W12_g3823 = s.z / ( s.z + s.w );
			}
			}
			float4 lerpResult46_g3823 = lerp( tex2D( _Lightmap, UV32_g3823 ) , tex2D( _Lightmap, UV22_g3823 ) , W02_g3823);
			float4 lerpResult45_g3823 = lerp( tex2D( _Lightmap, UV12_g3823 ) , tex2D( _Lightmap, UV02_g3823 ) , W02_g3823);
			float4 lerpResult44_g3823 = lerp( lerpResult46_g3823 , lerpResult45_g3823 , W12_g3823);
			float4 Output_2D131_g3823 = lerpResult44_g3823;
			float3 appendResult139_g3826 = (float3(sqrt( ( 3.0 / 2.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float localBicubicPrepare2_g3827 = ( 0.0 );
			float2 Input_UV100_g3827 = uv_BumpMap;
			float2 UV2_g3827 = Input_UV100_g3827;
			float4 TexelSize2_g3827 = _BumpMap_TexelSize;
			float2 UV02_g3827 = float2( 0,0 );
			float2 UV12_g3827 = float2( 0,0 );
			float2 UV22_g3827 = float2( 0,0 );
			float2 UV32_g3827 = float2( 0,0 );
			float W02_g3827 = 0;
			float W12_g3827 = 0;
			{
			{
			 UV2_g3827 = UV2_g3827 * TexelSize2_g3827.zw - 0.5;
			    float2 f = frac( UV2_g3827 );
			    UV2_g3827 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g3827.x - 0.5, UV2_g3827.x + 1.5, UV2_g3827.y - 0.5, UV2_g3827.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g3827.xyxy;
			    UV02_g3827 = off.xz;
			    UV12_g3827 = off.yz;
			    UV22_g3827 = off.xw;
			    UV32_g3827 = off.yw;
			    W02_g3827 = s.x / ( s.x + s.y );
			 W12_g3827 = s.z / ( s.z + s.w );
			}
			}
			float temp_output_239_0_g3827 = _RNMScale;
			float3 lerpResult46_g3827 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV32_g3827 ), temp_output_239_0_g3827 ) , UnpackScaleNormal( tex2D( _BumpMap, UV22_g3827 ), temp_output_239_0_g3827 ) , W02_g3827);
			float3 lerpResult45_g3827 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV12_g3827 ), temp_output_239_0_g3827 ) , UnpackScaleNormal( tex2D( _BumpMap, UV02_g3827 ), temp_output_239_0_g3827 ) , W02_g3827);
			float3 lerpResult44_g3827 = lerp( lerpResult46_g3827 , lerpResult45_g3827 , W12_g3827);
			float3 Output_2D131_g3827 = lerpResult44_g3827;
			float3 normalizeResult326_g3826 = normalize( Output_2D131_g3827 );
			float3 Normal_Map318_g3826 = normalizeResult326_g3826;
			float dotResult121_g3826 = dot( appendResult139_g3826 , Normal_Map318_g3826 );
			float localStochasticTiling2_g3831 = ( 0.0 );
			float2 uv3_RNMX0 = i.uv3_texcoord3 * _RNMX0_ST.xy + _RNMX0_ST.zw;
			float2 UV2_g3831 = uv3_RNMX0;
			float4 TexelSize2_g3831 = _RNMX0_TexelSize;
			float4 Offsets2_g3831 = float4( 0,0,0,0 );
			float2 Weights2_g3831 = float2( 0,0 );
			{
			UV2_g3831 = UV2_g3831 * TexelSize2_g3831.zw - 0.5;
			float2 f = frac( UV2_g3831 );
			UV2_g3831 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g3831.x - 0.5, UV2_g3831.x + 1.5, UV2_g3831.y - 0.5, UV2_g3831.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g3831 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g3831.xyxy;
			Weights2_g3831 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g3828 = Offsets2_g3831;
			float4 Input_FetchOffsets197_g3832 = temp_output_1_34_g3828;
			float2 temp_output_1_54_g3828 = Weights2_g3831;
			float2 Input_FetchWeights200_g3832 = temp_output_1_54_g3828;
			float2 break187_g3832 = Input_FetchWeights200_g3832;
			float4 lerpResult181_g3832 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g3832).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g3832).xw ) , break187_g3832.x);
			float4 lerpResult182_g3832 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g3832).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g3832).xz ) , break187_g3832.x);
			float4 lerpResult176_g3832 = lerp( lerpResult181_g3832 , lerpResult182_g3832 , break187_g3832.y);
			float4 Output_Fetch2D202_g3832 = lerpResult176_g3832;
			float3 appendResult146_g3826 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g3826 = dot( appendResult146_g3826 , Normal_Map318_g3826 );
			float4 Input_FetchOffsets197_g3829 = temp_output_1_34_g3828;
			float2 Input_FetchWeights200_g3829 = temp_output_1_54_g3828;
			float2 break187_g3829 = Input_FetchWeights200_g3829;
			float4 lerpResult181_g3829 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g3829).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g3829).xw ) , break187_g3829.x);
			float4 lerpResult182_g3829 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g3829).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g3829).xz ) , break187_g3829.x);
			float4 lerpResult176_g3829 = lerp( lerpResult181_g3829 , lerpResult182_g3829 , break187_g3829.y);
			float4 Output_Fetch2D202_g3829 = lerpResult176_g3829;
			float3 appendResult149_g3826 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g3826 = dot( appendResult149_g3826 , Normal_Map318_g3826 );
			float4 Input_FetchOffsets197_g3830 = temp_output_1_34_g3828;
			float2 Input_FetchWeights200_g3830 = temp_output_1_54_g3828;
			float2 break187_g3830 = Input_FetchWeights200_g3830;
			float4 lerpResult181_g3830 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g3830).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g3830).xw ) , break187_g3830.x);
			float4 lerpResult182_g3830 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g3830).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g3830).xz ) , break187_g3830.x);
			float4 lerpResult176_g3830 = lerp( lerpResult181_g3830 , lerpResult182_g3830 , break187_g3830.y);
			float4 Output_Fetch2D202_g3830 = lerpResult176_g3830;
			float4 temp_output_590_0_g3815 = ( ( ( saturate( dotResult121_g3826 ) * ( Output_Fetch2D202_g3832 * 0.5 ) ) + ( saturate( dotResult122_g3826 ) * ( Output_Fetch2D202_g3829 * 0.5 ) ) ) + ( saturate( dotResult120_g3826 ) * ( Output_Fetch2D202_g3830 * 0.5 ) ) );
			float3 appendResult139_g3824 = (float3(sqrt( ( 3.0 / 2.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float localBicubicPrepare2_g3825 = ( 0.0 );
			float2 Input_UV100_g3825 = uv_BumpMap;
			float2 UV2_g3825 = Input_UV100_g3825;
			float4 TexelSize2_g3825 = _BumpMap_TexelSize;
			float2 UV02_g3825 = float2( 0,0 );
			float2 UV12_g3825 = float2( 0,0 );
			float2 UV22_g3825 = float2( 0,0 );
			float2 UV32_g3825 = float2( 0,0 );
			float W02_g3825 = 0;
			float W12_g3825 = 0;
			{
			{
			 UV2_g3825 = UV2_g3825 * TexelSize2_g3825.zw - 0.5;
			    float2 f = frac( UV2_g3825 );
			    UV2_g3825 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g3825.x - 0.5, UV2_g3825.x + 1.5, UV2_g3825.y - 0.5, UV2_g3825.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g3825.xyxy;
			    UV02_g3825 = off.xz;
			    UV12_g3825 = off.yz;
			    UV22_g3825 = off.xw;
			    UV32_g3825 = off.yw;
			    W02_g3825 = s.x / ( s.x + s.y );
			 W12_g3825 = s.z / ( s.z + s.w );
			}
			}
			float RNM_Scale447_g3815 = _RNMScale;
			float temp_output_239_0_g3825 = RNM_Scale447_g3815;
			float3 lerpResult46_g3825 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV32_g3825 ), temp_output_239_0_g3825 ) , UnpackScaleNormal( tex2D( _BumpMap, UV22_g3825 ), temp_output_239_0_g3825 ) , W02_g3825);
			float3 lerpResult45_g3825 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV12_g3825 ), temp_output_239_0_g3825 ) , UnpackScaleNormal( tex2D( _BumpMap, UV02_g3825 ), temp_output_239_0_g3825 ) , W02_g3825);
			float3 lerpResult44_g3825 = lerp( lerpResult46_g3825 , lerpResult45_g3825 , W12_g3825);
			float3 Output_2D131_g3825 = lerpResult44_g3825;
			float3 normalizeResult326_g3824 = normalize( Output_2D131_g3825 );
			float3 Normal_Map318_g3824 = normalizeResult326_g3824;
			float dotResult121_g3824 = dot( appendResult139_g3824 , Normal_Map318_g3824 );
			float localStochasticTiling2_g3820 = ( 0.0 );
			float2 uv3_RNMX1 = i.uv3_texcoord3 * _RNMX1_ST.xy + _RNMX1_ST.zw;
			float2 UV2_g3820 = uv3_RNMX1;
			float4 TexelSize2_g3820 = _RNMX1_TexelSize;
			float4 Offsets2_g3820 = float4( 0,0,0,0 );
			float2 Weights2_g3820 = float2( 0,0 );
			{
			UV2_g3820 = UV2_g3820 * TexelSize2_g3820.zw - 0.5;
			float2 f = frac( UV2_g3820 );
			UV2_g3820 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g3820.x - 0.5, UV2_g3820.x + 1.5, UV2_g3820.y - 0.5, UV2_g3820.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g3820 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g3820.xyxy;
			Weights2_g3820 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g3817 = Offsets2_g3820;
			float4 Input_FetchOffsets197_g3821 = temp_output_1_34_g3817;
			float2 temp_output_1_54_g3817 = Weights2_g3820;
			float2 Input_FetchWeights200_g3821 = temp_output_1_54_g3817;
			float2 break187_g3821 = Input_FetchWeights200_g3821;
			float4 lerpResult181_g3821 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g3821).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g3821).xw ) , break187_g3821.x);
			float4 lerpResult182_g3821 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g3821).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g3821).xz ) , break187_g3821.x);
			float4 lerpResult176_g3821 = lerp( lerpResult181_g3821 , lerpResult182_g3821 , break187_g3821.y);
			float4 Output_Fetch2D202_g3821 = lerpResult176_g3821;
			float3 appendResult146_g3824 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g3824 = dot( appendResult146_g3824 , Normal_Map318_g3824 );
			float4 Input_FetchOffsets197_g3818 = temp_output_1_34_g3817;
			float2 Input_FetchWeights200_g3818 = temp_output_1_54_g3817;
			float2 break187_g3818 = Input_FetchWeights200_g3818;
			float4 lerpResult181_g3818 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g3818).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g3818).xw ) , break187_g3818.x);
			float4 lerpResult182_g3818 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g3818).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g3818).xz ) , break187_g3818.x);
			float4 lerpResult176_g3818 = lerp( lerpResult181_g3818 , lerpResult182_g3818 , break187_g3818.y);
			float4 Output_Fetch2D202_g3818 = lerpResult176_g3818;
			float3 appendResult149_g3824 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g3824 = dot( appendResult149_g3824 , Normal_Map318_g3824 );
			float4 Input_FetchOffsets197_g3819 = temp_output_1_34_g3817;
			float2 Input_FetchWeights200_g3819 = temp_output_1_54_g3817;
			float2 break187_g3819 = Input_FetchWeights200_g3819;
			float4 lerpResult181_g3819 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g3819).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g3819).xw ) , break187_g3819.x);
			float4 lerpResult182_g3819 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g3819).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g3819).xz ) , break187_g3819.x);
			float4 lerpResult176_g3819 = lerp( lerpResult181_g3819 , lerpResult182_g3819 , break187_g3819.y);
			float4 Output_Fetch2D202_g3819 = lerpResult176_g3819;
			float4 lerpResult442_g3815 = lerp( temp_output_590_0_g3815 , ( ( ( saturate( dotResult121_g3824 ) * ( Output_Fetch2D202_g3821 * 0.5 ) ) + ( saturate( dotResult122_g3824 ) * ( Output_Fetch2D202_g3818 * 0.5 ) ) ) + ( saturate( dotResult120_g3824 ) * ( Output_Fetch2D202_g3819 * 0.5 ) ) ) , _LightmapLerp);
			#if defined( _LIGHTMAPPINGMODE_SIMPLE )
				float4 staticSwitch565_g3815 = Output_2D131_g3823;
			#elif defined( _LIGHTMAPPINGMODE_RNM )
				float4 staticSwitch565_g3815 = temp_output_590_0_g3815;
			#elif defined( _LIGHTMAPPINGMODE_RNMLERP )
				float4 staticSwitch565_g3815 = lerpResult442_g3815;
			#else
				float4 staticSwitch565_g3815 = Output_2D131_g3823;
			#endif
			#ifdef _LIGHTMAPPING_ON
				float4 staticSwitch569_g3815 = staticSwitch565_g3815;
			#else
				float4 staticSwitch569_g3815 = temp_cast_4;
			#endif
			float4 Lightmap46_g3815 = staticSwitch569_g3815;
			#ifdef _LIGHTMAPPING_ON
				float4 staticSwitch566_g3815 = ( float4( Albedo6_g3815 , 0.0 ) * Lightmap46_g3815 );
			#else
				float4 staticSwitch566_g3815 = float4( Albedo6_g3815 , 0.0 );
			#endif
			#ifdef _LIGHTMAPPING_ON
				float4 staticSwitch696_g3815 = ( float4( staticSwitch572_g3815 , 0.0 ) + staticSwitch566_g3815 );
			#else
				float4 staticSwitch696_g3815 = ( float4( staticSwitch572_g3815 , 0.0 ) * staticSwitch566_g3815 );
			#endif
			#ifdef _LIGHTMAP_DEBUG_MODE_ON
				float4 staticSwitch686_g3815 = Lightmap46_g3815;
			#else
				float4 staticSwitch686_g3815 = staticSwitch696_g3815;
			#endif
			o.Emission = staticSwitch686_g3815.rgb;
			float2 uv_MetallicMap = i.uv_texcoord * _MetallicMap_ST.xy + _MetallicMap_ST.zw;
			#ifdef _LIGHTMAP_DEBUG_MODE_ON
				float3 staticSwitch692_g3815 = float3( 0,0,0 );
			#else
				float3 staticSwitch692_g3815 = ( _Metallic * tex2D( _MetallicMap, uv_MetallicMap ).rgb );
			#endif
			o.Metallic = staticSwitch692_g3815.x;
			float2 uv_EmissionMap164_g3815 = i.uv_texcoord;
			#ifdef _LIGHTMAP_DEBUG_MODE_ON
				float4 staticSwitch693_g3815 = float4( 0,0,0,0 );
			#else
				float4 staticSwitch693_g3815 = ( _Glossiness * ( 1.0 - tex2D( _EmissionMap1, uv_EmissionMap164_g3815 ) ) );
			#endif
			o.Smoothness = staticSwitch693_g3815.r;
			float4 temp_cast_9 = White38_g3815;
			float4 temp_cast_10 = White38_g3815;
			float4 saferPower606_g3815 = abs( Lightmap46_g3815 );
			float4 temp_cast_11 = (_OcclusionPower).xxxx;
			float4 clampResult579_g3815 = clamp( pow( saferPower606_g3815 , temp_cast_11 ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			#ifdef _LIGHTMAPOCCLUSION_ON
				float4 staticSwitch573_g3815 = clampResult579_g3815;
			#else
				float4 staticSwitch573_g3815 = temp_cast_10;
			#endif
			#ifdef _LIGHTMAPPING_ON
				float4 staticSwitch576_g3815 = staticSwitch573_g3815;
			#else
				float4 staticSwitch576_g3815 = temp_cast_9;
			#endif
			o.Occlusion = staticSwitch576_g3815.r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Fairplex/Standard Mobile"
	CustomEditor "Meenphie_ShaderGUI"
}
/*ASEBEGIN
Version=19901
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2724;240,-1200;Inherit;False;Meenphie Default;0;;3815;b3ba55a08dd6b49c7be16c6f35cf2033;0;0;8;FLOAT3;625;FLOAT3;238;COLOR;624;FLOAT3;96;COLOR;97;COLOR;95;FLOAT;156;FLOAT;427
Node;AmplifyShaderEditor.StandardSurfaceOutputNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1092;512,-1200;Float;False;True;-1;3;Meenphie_ShaderGUI;0;0;Standard;Meenphie/Standard;False;False;False;False;True;False;False;True;True;False;False;False;False;False;False;True;False;False;True;True;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;ForwardOnly;3;d3d11;glcore;vulkan;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0.0001;0,0,0,0;VertexOffset;False;False;Cylindrical;False;True;Relative;0;Fairplex/Standard Mobile;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;1092;0;2724;625
WireConnection;1092;1;2724;238
WireConnection;1092;2;2724;624
WireConnection;1092;3;2724;96
WireConnection;1092;4;2724;97
WireConnection;1092;5;2724;95
ASEEND*/
//CHKSM=D1E46AF71C0E13E672847858633E8F8E431E2349