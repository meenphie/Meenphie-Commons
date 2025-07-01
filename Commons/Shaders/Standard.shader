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
		_RNMScale( "RNM Scale", Float ) = 2
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
			float localBicubicPrepare2_g3942 = ( 0.0 );
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float2 Input_UV100_g3942 = uv_BumpMap;
			float2 UV2_g3942 = Input_UV100_g3942;
			float4 TexelSize2_g3942 = _BumpMap_TexelSize;
			float2 UV02_g3942 = float2( 0,0 );
			float2 UV12_g3942 = float2( 0,0 );
			float2 UV22_g3942 = float2( 0,0 );
			float2 UV32_g3942 = float2( 0,0 );
			float W02_g3942 = 0;
			float W12_g3942 = 0;
			{
			{
			 UV2_g3942 = UV2_g3942 * TexelSize2_g3942.zw - 0.5;
			    float2 f = frac( UV2_g3942 );
			    UV2_g3942 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g3942.x - 0.5, UV2_g3942.x + 1.5, UV2_g3942.y - 0.5, UV2_g3942.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g3942.xyxy;
			    UV02_g3942 = off.xz;
			    UV12_g3942 = off.yz;
			    UV22_g3942 = off.xw;
			    UV32_g3942 = off.yw;
			    W02_g3942 = s.x / ( s.x + s.y );
			 W12_g3942 = s.z / ( s.z + s.w );
			}
			}
			float temp_output_239_0_g3942 = _NormalScale;
			float3 lerpResult46_g3942 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV32_g3942 ), temp_output_239_0_g3942 ) , UnpackScaleNormal( tex2D( _BumpMap, UV22_g3942 ), temp_output_239_0_g3942 ) , W02_g3942);
			float3 lerpResult45_g3942 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV12_g3942 ), temp_output_239_0_g3942 ) , UnpackScaleNormal( tex2D( _BumpMap, UV02_g3942 ), temp_output_239_0_g3942 ) , W02_g3942);
			float3 lerpResult44_g3942 = lerp( lerpResult46_g3942 , lerpResult45_g3942 , W12_g3942);
			float3 Output_2D131_g3942 = lerpResult44_g3942;
			o.Normal = Output_2D131_g3942;
			float2 uv_MainTex259_g3941 = i.uv_texcoord;
			float4 tex2DNode259_g3941 = tex2D( _MainTex, uv_MainTex259_g3941 );
			float3 temp_output_5_0_g3941 = ( _Color.rgb * tex2DNode259_g3941.rgb );
			o.Albedo = temp_output_5_0_g3941;
			float3 temp_cast_0 = 0;
			float2 uv_EmissionMap81_g3941 = i.uv_texcoord;
			float3 Emission86_g3941 = ( _EmissionColor + tex2D( _EmissionMap, uv_EmissionMap81_g3941 ).rgb );
			#ifdef _EMISSION_ON
				float3 staticSwitch572_g3941 = Emission86_g3941;
			#else
				float3 staticSwitch572_g3941 = temp_cast_0;
			#endif
			float3 Albedo6_g3941 = temp_output_5_0_g3941;
			int White38_g3941 = 1;
			float4 temp_cast_4 = White38_g3941;
			float localBicubicPrepare2_g3949 = ( 0.0 );
			float2 uv3_Lightmap = i.uv3_texcoord3 * _Lightmap_ST.xy + _Lightmap_ST.zw;
			float2 Input_UV100_g3949 = uv3_Lightmap;
			float2 UV2_g3949 = Input_UV100_g3949;
			float4 TexelSize2_g3949 = _Lightmap_TexelSize;
			float2 UV02_g3949 = float2( 0,0 );
			float2 UV12_g3949 = float2( 0,0 );
			float2 UV22_g3949 = float2( 0,0 );
			float2 UV32_g3949 = float2( 0,0 );
			float W02_g3949 = 0;
			float W12_g3949 = 0;
			{
			{
			 UV2_g3949 = UV2_g3949 * TexelSize2_g3949.zw - 0.5;
			    float2 f = frac( UV2_g3949 );
			    UV2_g3949 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g3949.x - 0.5, UV2_g3949.x + 1.5, UV2_g3949.y - 0.5, UV2_g3949.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g3949.xyxy;
			    UV02_g3949 = off.xz;
			    UV12_g3949 = off.yz;
			    UV22_g3949 = off.xw;
			    UV32_g3949 = off.yw;
			    W02_g3949 = s.x / ( s.x + s.y );
			 W12_g3949 = s.z / ( s.z + s.w );
			}
			}
			float4 lerpResult46_g3949 = lerp( tex2D( _Lightmap, UV32_g3949 ) , tex2D( _Lightmap, UV22_g3949 ) , W02_g3949);
			float4 lerpResult45_g3949 = lerp( tex2D( _Lightmap, UV12_g3949 ) , tex2D( _Lightmap, UV02_g3949 ) , W02_g3949);
			float4 lerpResult44_g3949 = lerp( lerpResult46_g3949 , lerpResult45_g3949 , W12_g3949);
			float4 Output_2D131_g3949 = lerpResult44_g3949;
			float3 appendResult139_g3957 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float localBicubicPrepare2_g3958 = ( 0.0 );
			float2 Input_UV100_g3958 = uv_BumpMap;
			float2 UV2_g3958 = Input_UV100_g3958;
			float4 TexelSize2_g3958 = _BumpMap_TexelSize;
			float2 UV02_g3958 = float2( 0,0 );
			float2 UV12_g3958 = float2( 0,0 );
			float2 UV22_g3958 = float2( 0,0 );
			float2 UV32_g3958 = float2( 0,0 );
			float W02_g3958 = 0;
			float W12_g3958 = 0;
			{
			{
			 UV2_g3958 = UV2_g3958 * TexelSize2_g3958.zw - 0.5;
			    float2 f = frac( UV2_g3958 );
			    UV2_g3958 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g3958.x - 0.5, UV2_g3958.x + 1.5, UV2_g3958.y - 0.5, UV2_g3958.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g3958.xyxy;
			    UV02_g3958 = off.xz;
			    UV12_g3958 = off.yz;
			    UV22_g3958 = off.xw;
			    UV32_g3958 = off.yw;
			    W02_g3958 = s.x / ( s.x + s.y );
			 W12_g3958 = s.z / ( s.z + s.w );
			}
			}
			float temp_output_239_0_g3958 = _RNMScale;
			float3 lerpResult46_g3958 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV32_g3958 ), temp_output_239_0_g3958 ) , UnpackScaleNormal( tex2D( _BumpMap, UV22_g3958 ), temp_output_239_0_g3958 ) , W02_g3958);
			float3 lerpResult45_g3958 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV12_g3958 ), temp_output_239_0_g3958 ) , UnpackScaleNormal( tex2D( _BumpMap, UV02_g3958 ), temp_output_239_0_g3958 ) , W02_g3958);
			float3 lerpResult44_g3958 = lerp( lerpResult46_g3958 , lerpResult45_g3958 , W12_g3958);
			float3 Output_2D131_g3958 = lerpResult44_g3958;
			float3 normalizeResult326_g3957 = normalize( Output_2D131_g3958 );
			float3 Normal_Map318_g3957 = normalizeResult326_g3957;
			float dotResult121_g3957 = dot( appendResult139_g3957 , Normal_Map318_g3957 );
			float localStochasticTiling2_g3955 = ( 0.0 );
			float2 uv3_RNMX0 = i.uv3_texcoord3 * _RNMX0_ST.xy + _RNMX0_ST.zw;
			float2 UV2_g3955 = uv3_RNMX0;
			float4 TexelSize2_g3955 = _RNMX0_TexelSize;
			float4 Offsets2_g3955 = float4( 0,0,0,0 );
			float2 Weights2_g3955 = float2( 0,0 );
			{
			UV2_g3955 = UV2_g3955 * TexelSize2_g3955.zw - 0.5;
			float2 f = frac( UV2_g3955 );
			UV2_g3955 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g3955.x - 0.5, UV2_g3955.x + 1.5, UV2_g3955.y - 0.5, UV2_g3955.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g3955 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g3955.xyxy;
			Weights2_g3955 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g3952 = Offsets2_g3955;
			float4 Input_FetchOffsets197_g3956 = temp_output_1_34_g3952;
			float2 temp_output_1_54_g3952 = Weights2_g3955;
			float2 Input_FetchWeights200_g3956 = temp_output_1_54_g3952;
			float2 break187_g3956 = Input_FetchWeights200_g3956;
			float4 lerpResult181_g3956 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g3956).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g3956).xw ) , break187_g3956.x);
			float4 lerpResult182_g3956 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g3956).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g3956).xz ) , break187_g3956.x);
			float4 lerpResult176_g3956 = lerp( lerpResult181_g3956 , lerpResult182_g3956 , break187_g3956.y);
			float4 Output_Fetch2D202_g3956 = lerpResult176_g3956;
			float3 appendResult146_g3957 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g3957 = dot( appendResult146_g3957 , Normal_Map318_g3957 );
			float4 Input_FetchOffsets197_g3953 = temp_output_1_34_g3952;
			float2 Input_FetchWeights200_g3953 = temp_output_1_54_g3952;
			float2 break187_g3953 = Input_FetchWeights200_g3953;
			float4 lerpResult181_g3953 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g3953).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g3953).xw ) , break187_g3953.x);
			float4 lerpResult182_g3953 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g3953).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g3953).xz ) , break187_g3953.x);
			float4 lerpResult176_g3953 = lerp( lerpResult181_g3953 , lerpResult182_g3953 , break187_g3953.y);
			float4 Output_Fetch2D202_g3953 = lerpResult176_g3953;
			float3 appendResult149_g3957 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g3957 = dot( appendResult149_g3957 , Normal_Map318_g3957 );
			float4 Input_FetchOffsets197_g3954 = temp_output_1_34_g3952;
			float2 Input_FetchWeights200_g3954 = temp_output_1_54_g3952;
			float2 break187_g3954 = Input_FetchWeights200_g3954;
			float4 lerpResult181_g3954 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g3954).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g3954).xw ) , break187_g3954.x);
			float4 lerpResult182_g3954 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g3954).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g3954).xz ) , break187_g3954.x);
			float4 lerpResult176_g3954 = lerp( lerpResult181_g3954 , lerpResult182_g3954 , break187_g3954.y);
			float4 Output_Fetch2D202_g3954 = lerpResult176_g3954;
			float4 temp_output_590_0_g3941 = ( ( ( saturate( dotResult121_g3957 ) * ( Output_Fetch2D202_g3956 * 1.0 ) ) + ( saturate( dotResult122_g3957 ) * ( Output_Fetch2D202_g3953 * 1.0 ) ) ) + ( saturate( dotResult120_g3957 ) * ( Output_Fetch2D202_g3954 * 1.0 ) ) );
			float3 appendResult139_g3950 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float localBicubicPrepare2_g3951 = ( 0.0 );
			float2 Input_UV100_g3951 = uv_BumpMap;
			float2 UV2_g3951 = Input_UV100_g3951;
			float4 TexelSize2_g3951 = _BumpMap_TexelSize;
			float2 UV02_g3951 = float2( 0,0 );
			float2 UV12_g3951 = float2( 0,0 );
			float2 UV22_g3951 = float2( 0,0 );
			float2 UV32_g3951 = float2( 0,0 );
			float W02_g3951 = 0;
			float W12_g3951 = 0;
			{
			{
			 UV2_g3951 = UV2_g3951 * TexelSize2_g3951.zw - 0.5;
			    float2 f = frac( UV2_g3951 );
			    UV2_g3951 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g3951.x - 0.5, UV2_g3951.x + 1.5, UV2_g3951.y - 0.5, UV2_g3951.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g3951.xyxy;
			    UV02_g3951 = off.xz;
			    UV12_g3951 = off.yz;
			    UV22_g3951 = off.xw;
			    UV32_g3951 = off.yw;
			    W02_g3951 = s.x / ( s.x + s.y );
			 W12_g3951 = s.z / ( s.z + s.w );
			}
			}
			float RNM_Scale447_g3941 = _RNMScale;
			float temp_output_239_0_g3951 = RNM_Scale447_g3941;
			float3 lerpResult46_g3951 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV32_g3951 ), temp_output_239_0_g3951 ) , UnpackScaleNormal( tex2D( _BumpMap, UV22_g3951 ), temp_output_239_0_g3951 ) , W02_g3951);
			float3 lerpResult45_g3951 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV12_g3951 ), temp_output_239_0_g3951 ) , UnpackScaleNormal( tex2D( _BumpMap, UV02_g3951 ), temp_output_239_0_g3951 ) , W02_g3951);
			float3 lerpResult44_g3951 = lerp( lerpResult46_g3951 , lerpResult45_g3951 , W12_g3951);
			float3 Output_2D131_g3951 = lerpResult44_g3951;
			float3 normalizeResult326_g3950 = normalize( Output_2D131_g3951 );
			float3 Normal_Map318_g3950 = normalizeResult326_g3950;
			float dotResult121_g3950 = dot( appendResult139_g3950 , Normal_Map318_g3950 );
			float localStochasticTiling2_g3946 = ( 0.0 );
			float2 uv3_RNMX1 = i.uv3_texcoord3 * _RNMX1_ST.xy + _RNMX1_ST.zw;
			float2 UV2_g3946 = uv3_RNMX1;
			float4 TexelSize2_g3946 = _RNMX1_TexelSize;
			float4 Offsets2_g3946 = float4( 0,0,0,0 );
			float2 Weights2_g3946 = float2( 0,0 );
			{
			UV2_g3946 = UV2_g3946 * TexelSize2_g3946.zw - 0.5;
			float2 f = frac( UV2_g3946 );
			UV2_g3946 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g3946.x - 0.5, UV2_g3946.x + 1.5, UV2_g3946.y - 0.5, UV2_g3946.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g3946 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g3946.xyxy;
			Weights2_g3946 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g3943 = Offsets2_g3946;
			float4 Input_FetchOffsets197_g3947 = temp_output_1_34_g3943;
			float2 temp_output_1_54_g3943 = Weights2_g3946;
			float2 Input_FetchWeights200_g3947 = temp_output_1_54_g3943;
			float2 break187_g3947 = Input_FetchWeights200_g3947;
			float4 lerpResult181_g3947 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g3947).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g3947).xw ) , break187_g3947.x);
			float4 lerpResult182_g3947 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g3947).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g3947).xz ) , break187_g3947.x);
			float4 lerpResult176_g3947 = lerp( lerpResult181_g3947 , lerpResult182_g3947 , break187_g3947.y);
			float4 Output_Fetch2D202_g3947 = lerpResult176_g3947;
			float3 appendResult146_g3950 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g3950 = dot( appendResult146_g3950 , Normal_Map318_g3950 );
			float4 Input_FetchOffsets197_g3944 = temp_output_1_34_g3943;
			float2 Input_FetchWeights200_g3944 = temp_output_1_54_g3943;
			float2 break187_g3944 = Input_FetchWeights200_g3944;
			float4 lerpResult181_g3944 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g3944).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g3944).xw ) , break187_g3944.x);
			float4 lerpResult182_g3944 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g3944).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g3944).xz ) , break187_g3944.x);
			float4 lerpResult176_g3944 = lerp( lerpResult181_g3944 , lerpResult182_g3944 , break187_g3944.y);
			float4 Output_Fetch2D202_g3944 = lerpResult176_g3944;
			float3 appendResult149_g3950 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g3950 = dot( appendResult149_g3950 , Normal_Map318_g3950 );
			float4 Input_FetchOffsets197_g3945 = temp_output_1_34_g3943;
			float2 Input_FetchWeights200_g3945 = temp_output_1_54_g3943;
			float2 break187_g3945 = Input_FetchWeights200_g3945;
			float4 lerpResult181_g3945 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g3945).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g3945).xw ) , break187_g3945.x);
			float4 lerpResult182_g3945 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g3945).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g3945).xz ) , break187_g3945.x);
			float4 lerpResult176_g3945 = lerp( lerpResult181_g3945 , lerpResult182_g3945 , break187_g3945.y);
			float4 Output_Fetch2D202_g3945 = lerpResult176_g3945;
			float4 lerpResult442_g3941 = lerp( temp_output_590_0_g3941 , ( ( ( saturate( dotResult121_g3950 ) * ( Output_Fetch2D202_g3947 * 1.0 ) ) + ( saturate( dotResult122_g3950 ) * ( Output_Fetch2D202_g3944 * 1.0 ) ) ) + ( saturate( dotResult120_g3950 ) * ( Output_Fetch2D202_g3945 * 1.0 ) ) ) , _LightmapLerp);
			#if defined( _LIGHTMAPPINGMODE_SIMPLE )
				float4 staticSwitch565_g3941 = Output_2D131_g3949;
			#elif defined( _LIGHTMAPPINGMODE_RNM )
				float4 staticSwitch565_g3941 = temp_output_590_0_g3941;
			#elif defined( _LIGHTMAPPINGMODE_RNMLERP )
				float4 staticSwitch565_g3941 = lerpResult442_g3941;
			#else
				float4 staticSwitch565_g3941 = Output_2D131_g3949;
			#endif
			#ifdef _LIGHTMAPPING_ON
				float4 staticSwitch569_g3941 = staticSwitch565_g3941;
			#else
				float4 staticSwitch569_g3941 = temp_cast_4;
			#endif
			float4 Lightmap46_g3941 = staticSwitch569_g3941;
			#ifdef _LIGHTMAPPING_ON
				float4 staticSwitch566_g3941 = ( float4( Albedo6_g3941 , 0.0 ) * Lightmap46_g3941 );
			#else
				float4 staticSwitch566_g3941 = float4( Albedo6_g3941 , 0.0 );
			#endif
			#ifdef _LIGHTMAPPING_ON
				float4 staticSwitch696_g3941 = ( float4( staticSwitch572_g3941 , 0.0 ) + staticSwitch566_g3941 );
			#else
				float4 staticSwitch696_g3941 = ( float4( staticSwitch572_g3941 , 0.0 ) * staticSwitch566_g3941 );
			#endif
			#ifdef _LIGHTMAP_DEBUG_MODE_ON
				float4 staticSwitch686_g3941 = Lightmap46_g3941;
			#else
				float4 staticSwitch686_g3941 = staticSwitch696_g3941;
			#endif
			o.Emission = staticSwitch686_g3941.rgb;
			float2 uv_MetallicMap = i.uv_texcoord * _MetallicMap_ST.xy + _MetallicMap_ST.zw;
			#ifdef _LIGHTMAP_DEBUG_MODE_ON
				float3 staticSwitch692_g3941 = float3( 0,0,0 );
			#else
				float3 staticSwitch692_g3941 = ( _Metallic * tex2D( _MetallicMap, uv_MetallicMap ).rgb );
			#endif
			float3 Metallic699_g3941 = staticSwitch692_g3941;
			o.Metallic = Metallic699_g3941.x;
			float2 uv_EmissionMap164_g3941 = i.uv_texcoord;
			#ifdef _LIGHTMAP_DEBUG_MODE_ON
				float4 staticSwitch693_g3941 = float4( 0,0,0,0 );
			#else
				float4 staticSwitch693_g3941 = ( _Glossiness * ( 1.0 - tex2D( _EmissionMap1, uv_EmissionMap164_g3941 ) ) );
			#endif
			o.Smoothness = staticSwitch693_g3941.r;
			float4 temp_cast_9 = White38_g3941;
			float4 temp_cast_10 = White38_g3941;
			float4 saferPower606_g3941 = abs( Lightmap46_g3941 );
			float4 temp_cast_11 = (_OcclusionPower).xxxx;
			float4 clampResult579_g3941 = clamp( pow( saferPower606_g3941 , temp_cast_11 ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			#ifdef _LIGHTMAPOCCLUSION_ON
				float4 staticSwitch573_g3941 = clampResult579_g3941;
			#else
				float4 staticSwitch573_g3941 = temp_cast_10;
			#endif
			#ifdef _LIGHTMAPPING_ON
				float4 staticSwitch576_g3941 = staticSwitch573_g3941;
			#else
				float4 staticSwitch576_g3941 = temp_cast_9;
			#endif
			o.Occlusion = staticSwitch576_g3941.r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Fairplex/Standard Mobile"
	CustomEditor "Meenphie_ShaderGUI"
}
/*ASEBEGIN
Version=19901
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2731;240,-1200;Inherit;False;Meenphie Default;0;;3941;b3ba55a08dd6b49c7be16c6f35cf2033;0;0;8;FLOAT3;625;FLOAT3;238;COLOR;624;FLOAT3;96;COLOR;97;COLOR;95;FLOAT;156;FLOAT;427
Node;AmplifyShaderEditor.StandardSurfaceOutputNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1092;512,-1200;Float;False;True;-1;3;Meenphie_ShaderGUI;0;0;Standard;Meenphie/Standard;False;False;False;False;True;False;False;True;True;False;False;False;False;False;False;True;False;False;True;True;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;ForwardOnly;3;d3d11;glcore;vulkan;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0.0001;0,0,0,0;VertexOffset;False;False;Cylindrical;False;True;Relative;0;Fairplex/Standard Mobile;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;1092;0;2731;625
WireConnection;1092;1;2731;238
WireConnection;1092;2;2731;624
WireConnection;1092;3;2731;96
WireConnection;1092;4;2731;97
WireConnection;1092;5;2731;95
ASEEND*/
//CHKSM=9A151BF313213C2B8088D9B30EF6483221EDDFC3