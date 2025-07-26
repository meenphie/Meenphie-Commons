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
		#pragma shader_feature_local _USEBICUBICSAMPLER1_ON
		#pragma shader_feature_local _USEBICUBICSAMPLER_ON
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

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float localBicubicPrepare2_g4070 = ( 0.0 );
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float2 Input_UV100_g4070 = uv_BumpMap;
			float2 UV2_g4070 = Input_UV100_g4070;
			float4 TexelSize2_g4070 = _BumpMap_TexelSize;
			float2 UV02_g4070 = float2( 0,0 );
			float2 UV12_g4070 = float2( 0,0 );
			float2 UV22_g4070 = float2( 0,0 );
			float2 UV32_g4070 = float2( 0,0 );
			float W02_g4070 = 0;
			float W12_g4070 = 0;
			{
			{
			 UV2_g4070 = UV2_g4070 * TexelSize2_g4070.zw - 0.5;
			    float2 f = frac( UV2_g4070 );
			    UV2_g4070 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g4070.x - 0.5, UV2_g4070.x + 1.5, UV2_g4070.y - 0.5, UV2_g4070.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g4070.xyxy;
			    UV02_g4070 = off.xz;
			    UV12_g4070 = off.yz;
			    UV22_g4070 = off.xw;
			    UV32_g4070 = off.yw;
			    W02_g4070 = s.x / ( s.x + s.y );
			 W12_g4070 = s.z / ( s.z + s.w );
			}
			}
			float temp_output_239_0_g4070 = _NormalScale;
			float3 lerpResult46_g4070 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV32_g4070 ), temp_output_239_0_g4070 ) , UnpackScaleNormal( tex2D( _BumpMap, UV22_g4070 ), temp_output_239_0_g4070 ) , W02_g4070);
			float3 lerpResult45_g4070 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV12_g4070 ), temp_output_239_0_g4070 ) , UnpackScaleNormal( tex2D( _BumpMap, UV02_g4070 ), temp_output_239_0_g4070 ) , W02_g4070);
			float3 lerpResult44_g4070 = lerp( lerpResult46_g4070 , lerpResult45_g4070 , W12_g4070);
			float3 Output_2D131_g4070 = lerpResult44_g4070;
			o.Normal = Output_2D131_g4070;
			float2 uv_MainTex259_g4069 = i.uv_texcoord;
			float4 tex2DNode259_g4069 = tex2D( _MainTex, uv_MainTex259_g4069 );
			float3 temp_output_5_0_g4069 = ( _Color.rgb * tex2DNode259_g4069.rgb );
			o.Albedo = temp_output_5_0_g4069;
			float3 temp_cast_0 = 0;
			float2 uv_EmissionMap81_g4069 = i.uv_texcoord;
			float3 Emission86_g4069 = ( _EmissionColor + tex2D( _EmissionMap, uv_EmissionMap81_g4069 ).rgb );
			#ifdef _EMISSION_ON
				float3 staticSwitch572_g4069 = Emission86_g4069;
			#else
				float3 staticSwitch572_g4069 = temp_cast_0;
			#endif
			float3 Albedo6_g4069 = temp_output_5_0_g4069;
			int White38_g4069 = 1;
			float4 temp_cast_4 = White38_g4069;
			float2 uv_Lightmap = i.uv_texcoord * _Lightmap_ST.xy + _Lightmap_ST.zw;
			float localBicubicPrepare2_g4086 = ( 0.0 );
			float2 uv3_Lightmap = i.uv3_texcoord3 * _Lightmap_ST.xy + _Lightmap_ST.zw;
			float2 Input_UV100_g4086 = uv3_Lightmap;
			float2 UV2_g4086 = Input_UV100_g4086;
			float4 TexelSize2_g4086 = _Lightmap_TexelSize;
			float2 UV02_g4086 = float2( 0,0 );
			float2 UV12_g4086 = float2( 0,0 );
			float2 UV22_g4086 = float2( 0,0 );
			float2 UV32_g4086 = float2( 0,0 );
			float W02_g4086 = 0;
			float W12_g4086 = 0;
			{
			{
			 UV2_g4086 = UV2_g4086 * TexelSize2_g4086.zw - 0.5;
			    float2 f = frac( UV2_g4086 );
			    UV2_g4086 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g4086.x - 0.5, UV2_g4086.x + 1.5, UV2_g4086.y - 0.5, UV2_g4086.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g4086.xyxy;
			    UV02_g4086 = off.xz;
			    UV12_g4086 = off.yz;
			    UV22_g4086 = off.xw;
			    UV32_g4086 = off.yw;
			    W02_g4086 = s.x / ( s.x + s.y );
			 W12_g4086 = s.z / ( s.z + s.w );
			}
			}
			float4 lerpResult46_g4086 = lerp( tex2D( _Lightmap, UV32_g4086 ) , tex2D( _Lightmap, UV22_g4086 ) , W02_g4086);
			float4 lerpResult45_g4086 = lerp( tex2D( _Lightmap, UV12_g4086 ) , tex2D( _Lightmap, UV02_g4086 ) , W02_g4086);
			float4 lerpResult44_g4086 = lerp( lerpResult46_g4086 , lerpResult45_g4086 , W12_g4086);
			float4 Output_2D131_g4086 = lerpResult44_g4086;
			#ifdef _USEBICUBICSAMPLER1_ON
				float4 staticSwitch768_g4069 = Output_2D131_g4086;
			#else
				float4 staticSwitch768_g4069 = float4( tex2D( _Lightmap, uv_Lightmap ).rgb , 0.0 );
			#endif
			float3 appendResult139_g4071 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float localBicubicPrepare2_g4072 = ( 0.0 );
			float2 Input_UV100_g4072 = uv_BumpMap;
			float2 UV2_g4072 = Input_UV100_g4072;
			float4 TexelSize2_g4072 = _BumpMap_TexelSize;
			float2 UV02_g4072 = float2( 0,0 );
			float2 UV12_g4072 = float2( 0,0 );
			float2 UV22_g4072 = float2( 0,0 );
			float2 UV32_g4072 = float2( 0,0 );
			float W02_g4072 = 0;
			float W12_g4072 = 0;
			{
			{
			 UV2_g4072 = UV2_g4072 * TexelSize2_g4072.zw - 0.5;
			    float2 f = frac( UV2_g4072 );
			    UV2_g4072 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g4072.x - 0.5, UV2_g4072.x + 1.5, UV2_g4072.y - 0.5, UV2_g4072.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g4072.xyxy;
			    UV02_g4072 = off.xz;
			    UV12_g4072 = off.yz;
			    UV22_g4072 = off.xw;
			    UV32_g4072 = off.yw;
			    W02_g4072 = s.x / ( s.x + s.y );
			 W12_g4072 = s.z / ( s.z + s.w );
			}
			}
			float Normal_Map_Scale700_g4069 = _NormalScale;
			float temp_output_239_0_g4072 = Normal_Map_Scale700_g4069;
			float3 lerpResult46_g4072 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV32_g4072 ), temp_output_239_0_g4072 ) , UnpackScaleNormal( tex2D( _BumpMap, UV22_g4072 ), temp_output_239_0_g4072 ) , W02_g4072);
			float3 lerpResult45_g4072 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV12_g4072 ), temp_output_239_0_g4072 ) , UnpackScaleNormal( tex2D( _BumpMap, UV02_g4072 ), temp_output_239_0_g4072 ) , W02_g4072);
			float3 lerpResult44_g4072 = lerp( lerpResult46_g4072 , lerpResult45_g4072 , W12_g4072);
			float3 Output_2D131_g4072 = lerpResult44_g4072;
			float3 normalizeResult326_g4071 = normalize( Output_2D131_g4072 );
			float3 Normal_Map318_g4071 = normalizeResult326_g4071;
			float dotResult121_g4071 = dot( appendResult139_g4071 , Normal_Map318_g4071 );
			float2 uv_RNMX0 = i.uv_texcoord * _RNMX0_ST.xy + _RNMX0_ST.zw;
			float localStochasticTiling2_g4076 = ( 0.0 );
			float2 uv3_RNMX0 = i.uv3_texcoord3 * _RNMX0_ST.xy + _RNMX0_ST.zw;
			float2 UV2_g4076 = uv3_RNMX0;
			float4 TexelSize2_g4076 = _RNMX0_TexelSize;
			float4 Offsets2_g4076 = float4( 0,0,0,0 );
			float2 Weights2_g4076 = float2( 0,0 );
			{
			UV2_g4076 = UV2_g4076 * TexelSize2_g4076.zw - 0.5;
			float2 f = frac( UV2_g4076 );
			UV2_g4076 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g4076.x - 0.5, UV2_g4076.x + 1.5, UV2_g4076.y - 0.5, UV2_g4076.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g4076 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g4076.xyxy;
			Weights2_g4076 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g4073 = Offsets2_g4076;
			float4 Input_FetchOffsets197_g4077 = temp_output_1_34_g4073;
			float2 temp_output_1_54_g4073 = Weights2_g4076;
			float2 Input_FetchWeights200_g4077 = temp_output_1_54_g4073;
			float2 break187_g4077 = Input_FetchWeights200_g4077;
			float4 lerpResult181_g4077 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g4077).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g4077).xw ) , break187_g4077.x);
			float4 lerpResult182_g4077 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g4077).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g4077).xz ) , break187_g4077.x);
			float4 lerpResult176_g4077 = lerp( lerpResult181_g4077 , lerpResult182_g4077 , break187_g4077.y);
			float4 Output_Fetch2D202_g4077 = lerpResult176_g4077;
			#ifdef _USEBICUBICSAMPLER_ON
				float4 staticSwitch705_g4069 = Output_Fetch2D202_g4077;
			#else
				float4 staticSwitch705_g4069 = float4( tex2D( _RNMX0, uv_RNMX0 ).rgb , 0.0 );
			#endif
			float3 appendResult146_g4071 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g4071 = dot( appendResult146_g4071 , Normal_Map318_g4071 );
			float2 uv_RNMY0 = i.uv_texcoord * _RNMY0_ST.xy + _RNMY0_ST.zw;
			float4 Input_FetchOffsets197_g4074 = temp_output_1_34_g4073;
			float2 Input_FetchWeights200_g4074 = temp_output_1_54_g4073;
			float2 break187_g4074 = Input_FetchWeights200_g4074;
			float4 lerpResult181_g4074 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g4074).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g4074).xw ) , break187_g4074.x);
			float4 lerpResult182_g4074 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g4074).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g4074).xz ) , break187_g4074.x);
			float4 lerpResult176_g4074 = lerp( lerpResult181_g4074 , lerpResult182_g4074 , break187_g4074.y);
			float4 Output_Fetch2D202_g4074 = lerpResult176_g4074;
			#ifdef _USEBICUBICSAMPLER_ON
				float4 staticSwitch715_g4069 = Output_Fetch2D202_g4074;
			#else
				float4 staticSwitch715_g4069 = float4( tex2D( _RNMY0, uv_RNMY0 ).rgb , 0.0 );
			#endif
			float3 appendResult149_g4071 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g4071 = dot( appendResult149_g4071 , Normal_Map318_g4071 );
			float2 uv_RNMZ0 = i.uv_texcoord * _RNMZ0_ST.xy + _RNMZ0_ST.zw;
			float4 Input_FetchOffsets197_g4075 = temp_output_1_34_g4073;
			float2 Input_FetchWeights200_g4075 = temp_output_1_54_g4073;
			float2 break187_g4075 = Input_FetchWeights200_g4075;
			float4 lerpResult181_g4075 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g4075).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g4075).xw ) , break187_g4075.x);
			float4 lerpResult182_g4075 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g4075).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g4075).xz ) , break187_g4075.x);
			float4 lerpResult176_g4075 = lerp( lerpResult181_g4075 , lerpResult182_g4075 , break187_g4075.y);
			float4 Output_Fetch2D202_g4075 = lerpResult176_g4075;
			#ifdef _USEBICUBICSAMPLER_ON
				float4 staticSwitch716_g4069 = Output_Fetch2D202_g4075;
			#else
				float4 staticSwitch716_g4069 = float4( tex2D( _RNMZ0, uv_RNMZ0 ).rgb , 0.0 );
			#endif
			float4 temp_output_714_0_g4069 = ( ( ( saturate( dotResult121_g4071 ) * ( staticSwitch705_g4069 * 1.0 ) ) + ( saturate( dotResult122_g4071 ) * ( staticSwitch715_g4069 * 1.0 ) ) ) + ( saturate( dotResult120_g4071 ) * ( staticSwitch716_g4069 * 1.0 ) ) );
			float3 appendResult139_g4078 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float localBicubicPrepare2_g4079 = ( 0.0 );
			float2 Input_UV100_g4079 = uv_BumpMap;
			float2 UV2_g4079 = Input_UV100_g4079;
			float4 TexelSize2_g4079 = _BumpMap_TexelSize;
			float2 UV02_g4079 = float2( 0,0 );
			float2 UV12_g4079 = float2( 0,0 );
			float2 UV22_g4079 = float2( 0,0 );
			float2 UV32_g4079 = float2( 0,0 );
			float W02_g4079 = 0;
			float W12_g4079 = 0;
			{
			{
			 UV2_g4079 = UV2_g4079 * TexelSize2_g4079.zw - 0.5;
			    float2 f = frac( UV2_g4079 );
			    UV2_g4079 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g4079.x - 0.5, UV2_g4079.x + 1.5, UV2_g4079.y - 0.5, UV2_g4079.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g4079.xyxy;
			    UV02_g4079 = off.xz;
			    UV12_g4079 = off.yz;
			    UV22_g4079 = off.xw;
			    UV32_g4079 = off.yw;
			    W02_g4079 = s.x / ( s.x + s.y );
			 W12_g4079 = s.z / ( s.z + s.w );
			}
			}
			float temp_output_239_0_g4079 = Normal_Map_Scale700_g4069;
			float3 lerpResult46_g4079 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV32_g4079 ), temp_output_239_0_g4079 ) , UnpackScaleNormal( tex2D( _BumpMap, UV22_g4079 ), temp_output_239_0_g4079 ) , W02_g4079);
			float3 lerpResult45_g4079 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV12_g4079 ), temp_output_239_0_g4079 ) , UnpackScaleNormal( tex2D( _BumpMap, UV02_g4079 ), temp_output_239_0_g4079 ) , W02_g4079);
			float3 lerpResult44_g4079 = lerp( lerpResult46_g4079 , lerpResult45_g4079 , W12_g4079);
			float3 Output_2D131_g4079 = lerpResult44_g4079;
			float3 normalizeResult326_g4078 = normalize( Output_2D131_g4079 );
			float3 Normal_Map318_g4078 = normalizeResult326_g4078;
			float dotResult121_g4078 = dot( appendResult139_g4078 , Normal_Map318_g4078 );
			float2 uv_RNMX1 = i.uv_texcoord * _RNMX1_ST.xy + _RNMX1_ST.zw;
			float localStochasticTiling2_g4083 = ( 0.0 );
			float2 uv3_RNMX1 = i.uv3_texcoord3 * _RNMX1_ST.xy + _RNMX1_ST.zw;
			float2 UV2_g4083 = uv3_RNMX1;
			float4 TexelSize2_g4083 = _RNMX1_TexelSize;
			float4 Offsets2_g4083 = float4( 0,0,0,0 );
			float2 Weights2_g4083 = float2( 0,0 );
			{
			UV2_g4083 = UV2_g4083 * TexelSize2_g4083.zw - 0.5;
			float2 f = frac( UV2_g4083 );
			UV2_g4083 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g4083.x - 0.5, UV2_g4083.x + 1.5, UV2_g4083.y - 0.5, UV2_g4083.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g4083 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g4083.xyxy;
			Weights2_g4083 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g4080 = Offsets2_g4083;
			float4 Input_FetchOffsets197_g4084 = temp_output_1_34_g4080;
			float2 temp_output_1_54_g4080 = Weights2_g4083;
			float2 Input_FetchWeights200_g4084 = temp_output_1_54_g4080;
			float2 break187_g4084 = Input_FetchWeights200_g4084;
			float4 lerpResult181_g4084 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g4084).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g4084).xw ) , break187_g4084.x);
			float4 lerpResult182_g4084 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g4084).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g4084).xz ) , break187_g4084.x);
			float4 lerpResult176_g4084 = lerp( lerpResult181_g4084 , lerpResult182_g4084 , break187_g4084.y);
			float4 Output_Fetch2D202_g4084 = lerpResult176_g4084;
			#ifdef _USEBICUBICSAMPLER_ON
				float4 staticSwitch764_g4069 = Output_Fetch2D202_g4084;
			#else
				float4 staticSwitch764_g4069 = float4( tex2D( _RNMX1, uv_RNMX1 ).rgb , 0.0 );
			#endif
			float3 appendResult146_g4078 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g4078 = dot( appendResult146_g4078 , Normal_Map318_g4078 );
			float2 uv_RNMY1 = i.uv_texcoord * _RNMY1_ST.xy + _RNMY1_ST.zw;
			float4 Input_FetchOffsets197_g4081 = temp_output_1_34_g4080;
			float2 Input_FetchWeights200_g4081 = temp_output_1_54_g4080;
			float2 break187_g4081 = Input_FetchWeights200_g4081;
			float4 lerpResult181_g4081 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g4081).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g4081).xw ) , break187_g4081.x);
			float4 lerpResult182_g4081 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g4081).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g4081).xz ) , break187_g4081.x);
			float4 lerpResult176_g4081 = lerp( lerpResult181_g4081 , lerpResult182_g4081 , break187_g4081.y);
			float4 Output_Fetch2D202_g4081 = lerpResult176_g4081;
			#ifdef _USEBICUBICSAMPLER_ON
				float4 staticSwitch753_g4069 = Output_Fetch2D202_g4081;
			#else
				float4 staticSwitch753_g4069 = float4( tex2D( _RNMY1, uv_RNMY1 ).rgb , 0.0 );
			#endif
			float3 appendResult149_g4078 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g4078 = dot( appendResult149_g4078 , Normal_Map318_g4078 );
			float2 uv_RNMZ1 = i.uv_texcoord * _RNMZ1_ST.xy + _RNMZ1_ST.zw;
			float4 Input_FetchOffsets197_g4082 = temp_output_1_34_g4080;
			float2 Input_FetchWeights200_g4082 = temp_output_1_54_g4080;
			float2 break187_g4082 = Input_FetchWeights200_g4082;
			float4 lerpResult181_g4082 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g4082).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g4082).xw ) , break187_g4082.x);
			float4 lerpResult182_g4082 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g4082).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g4082).xz ) , break187_g4082.x);
			float4 lerpResult176_g4082 = lerp( lerpResult181_g4082 , lerpResult182_g4082 , break187_g4082.y);
			float4 Output_Fetch2D202_g4082 = lerpResult176_g4082;
			#ifdef _USEBICUBICSAMPLER_ON
				float4 staticSwitch750_g4069 = Output_Fetch2D202_g4082;
			#else
				float4 staticSwitch750_g4069 = float4( tex2D( _RNMZ1, uv_RNMZ1 ).rgb , 0.0 );
			#endif
			float4 lerpResult442_g4069 = lerp( temp_output_714_0_g4069 , ( ( ( saturate( dotResult121_g4078 ) * ( staticSwitch764_g4069 * 1.0 ) ) + ( saturate( dotResult122_g4078 ) * ( staticSwitch753_g4069 * 1.0 ) ) ) + ( saturate( dotResult120_g4078 ) * ( staticSwitch750_g4069 * 1.0 ) ) ) , _LightmapLerp);
			#if defined( _LIGHTMAPPINGMODE_SIMPLE )
				float4 staticSwitch565_g4069 = staticSwitch768_g4069;
			#elif defined( _LIGHTMAPPINGMODE_RNM )
				float4 staticSwitch565_g4069 = temp_output_714_0_g4069;
			#elif defined( _LIGHTMAPPINGMODE_RNMLERP )
				float4 staticSwitch565_g4069 = lerpResult442_g4069;
			#else
				float4 staticSwitch565_g4069 = staticSwitch768_g4069;
			#endif
			#ifdef _LIGHTMAPPING_ON
				float4 staticSwitch569_g4069 = staticSwitch565_g4069;
			#else
				float4 staticSwitch569_g4069 = temp_cast_4;
			#endif
			float4 Lightmap46_g4069 = staticSwitch569_g4069;
			#ifdef _LIGHTMAPPING_ON
				float4 staticSwitch566_g4069 = ( float4( Albedo6_g4069 , 0.0 ) * Lightmap46_g4069 );
			#else
				float4 staticSwitch566_g4069 = float4( Albedo6_g4069 , 0.0 );
			#endif
			#ifdef _LIGHTMAPPING_ON
				float4 staticSwitch696_g4069 = ( float4( staticSwitch572_g4069 , 0.0 ) + staticSwitch566_g4069 );
			#else
				float4 staticSwitch696_g4069 = ( float4( staticSwitch572_g4069 , 0.0 ) * staticSwitch566_g4069 );
			#endif
			#ifdef _LIGHTMAP_DEBUG_MODE_ON
				float4 staticSwitch686_g4069 = Lightmap46_g4069;
			#else
				float4 staticSwitch686_g4069 = staticSwitch696_g4069;
			#endif
			o.Emission = staticSwitch686_g4069.rgb;
			float2 uv_MetallicMap = i.uv_texcoord * _MetallicMap_ST.xy + _MetallicMap_ST.zw;
			#ifdef _LIGHTMAP_DEBUG_MODE_ON
				float3 staticSwitch692_g4069 = float3( 0,0,0 );
			#else
				float3 staticSwitch692_g4069 = ( _Metallic * tex2D( _MetallicMap, uv_MetallicMap ).rgb );
			#endif
			float3 Metallic699_g4069 = staticSwitch692_g4069;
			o.Metallic = Metallic699_g4069.x;
			float2 uv_EmissionMap164_g4069 = i.uv_texcoord;
			#ifdef _LIGHTMAP_DEBUG_MODE_ON
				float4 staticSwitch693_g4069 = float4( 0,0,0,0 );
			#else
				float4 staticSwitch693_g4069 = ( _Glossiness * ( 1.0 - tex2D( _EmissionMap1, uv_EmissionMap164_g4069 ) ) );
			#endif
			o.Smoothness = staticSwitch693_g4069.r;
			float4 temp_cast_16 = White38_g4069;
			float4 temp_cast_17 = White38_g4069;
			float4 saferPower606_g4069 = abs( Lightmap46_g4069 );
			float4 temp_cast_18 = (_OcclusionPower).xxxx;
			float4 clampResult579_g4069 = clamp( pow( saferPower606_g4069 , temp_cast_18 ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			#ifdef _LIGHTMAPOCCLUSION_ON
				float4 staticSwitch573_g4069 = clampResult579_g4069;
			#else
				float4 staticSwitch573_g4069 = temp_cast_17;
			#endif
			#ifdef _LIGHTMAPPING_ON
				float4 staticSwitch576_g4069 = staticSwitch573_g4069;
			#else
				float4 staticSwitch576_g4069 = temp_cast_16;
			#endif
			o.Occlusion = staticSwitch576_g4069.r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Fairplex/Standard Mobile"
	CustomEditor "Meenphie_ShaderGUI"
}
/*ASEBEGIN
Version=19901
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2738;240,-1200;Inherit;False;Meenphie Default;0;;4069;b3ba55a08dd6b49c7be16c6f35cf2033;0;0;8;FLOAT3;625;FLOAT3;238;COLOR;624;FLOAT3;96;COLOR;97;COLOR;95;FLOAT;156;FLOAT;427
Node;AmplifyShaderEditor.StandardSurfaceOutputNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1092;512,-1200;Float;False;True;-1;3;Meenphie_ShaderGUI;0;0;Standard;Meenphie/Standard;False;False;False;False;True;False;False;True;True;False;False;False;False;False;False;True;False;False;True;True;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;ForwardOnly;3;d3d11;glcore;vulkan;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0.0001;0,0,0,0;VertexOffset;False;False;Cylindrical;False;True;Relative;0;Fairplex/Standard Mobile;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;1092;0;2738;625
WireConnection;1092;1;2738;238
WireConnection;1092;2;2738;624
WireConnection;1092;3;2738;96
WireConnection;1092;4;2738;97
WireConnection;1092;5;2738;95
ASEEND*/
//CHKSM=03C2280ACC19EAE27FB20BC2D547F27CD727072D