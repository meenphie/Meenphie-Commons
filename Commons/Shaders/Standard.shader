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
		[Toggle( _USEBICUBICSAMPLER_ON )] _UseBicubicSampler( "Use Bicubic Sampler", Float ) = 0
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
			float localBicubicPrepare2_g4054 = ( 0.0 );
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float2 Input_UV100_g4054 = uv_BumpMap;
			float2 UV2_g4054 = Input_UV100_g4054;
			float4 TexelSize2_g4054 = _BumpMap_TexelSize;
			float2 UV02_g4054 = float2( 0,0 );
			float2 UV12_g4054 = float2( 0,0 );
			float2 UV22_g4054 = float2( 0,0 );
			float2 UV32_g4054 = float2( 0,0 );
			float W02_g4054 = 0;
			float W12_g4054 = 0;
			{
			{
			 UV2_g4054 = UV2_g4054 * TexelSize2_g4054.zw - 0.5;
			    float2 f = frac( UV2_g4054 );
			    UV2_g4054 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g4054.x - 0.5, UV2_g4054.x + 1.5, UV2_g4054.y - 0.5, UV2_g4054.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g4054.xyxy;
			    UV02_g4054 = off.xz;
			    UV12_g4054 = off.yz;
			    UV22_g4054 = off.xw;
			    UV32_g4054 = off.yw;
			    W02_g4054 = s.x / ( s.x + s.y );
			 W12_g4054 = s.z / ( s.z + s.w );
			}
			}
			float temp_output_239_0_g4054 = _NormalScale;
			float3 lerpResult46_g4054 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV32_g4054 ), temp_output_239_0_g4054 ) , UnpackScaleNormal( tex2D( _BumpMap, UV22_g4054 ), temp_output_239_0_g4054 ) , W02_g4054);
			float3 lerpResult45_g4054 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV12_g4054 ), temp_output_239_0_g4054 ) , UnpackScaleNormal( tex2D( _BumpMap, UV02_g4054 ), temp_output_239_0_g4054 ) , W02_g4054);
			float3 lerpResult44_g4054 = lerp( lerpResult46_g4054 , lerpResult45_g4054 , W12_g4054);
			float3 Output_2D131_g4054 = lerpResult44_g4054;
			o.Normal = Output_2D131_g4054;
			float2 uv_MainTex259_g4051 = i.uv_texcoord;
			float4 tex2DNode259_g4051 = tex2D( _MainTex, uv_MainTex259_g4051 );
			float3 temp_output_5_0_g4051 = ( _Color.rgb * tex2DNode259_g4051.rgb );
			o.Albedo = temp_output_5_0_g4051;
			float3 temp_cast_0 = 0;
			float2 uv_EmissionMap81_g4051 = i.uv_texcoord;
			float3 Emission86_g4051 = ( _EmissionColor + tex2D( _EmissionMap, uv_EmissionMap81_g4051 ).rgb );
			#ifdef _EMISSION_ON
				float3 staticSwitch572_g4051 = Emission86_g4051;
			#else
				float3 staticSwitch572_g4051 = temp_cast_0;
			#endif
			float3 Albedo6_g4051 = temp_output_5_0_g4051;
			int White38_g4051 = 1;
			float4 temp_cast_4 = White38_g4051;
			float localBicubicPrepare2_g4053 = ( 0.0 );
			float2 uv3_Lightmap = i.uv3_texcoord3 * _Lightmap_ST.xy + _Lightmap_ST.zw;
			float2 Input_UV100_g4053 = uv3_Lightmap;
			float2 UV2_g4053 = Input_UV100_g4053;
			float4 TexelSize2_g4053 = _Lightmap_TexelSize;
			float2 UV02_g4053 = float2( 0,0 );
			float2 UV12_g4053 = float2( 0,0 );
			float2 UV22_g4053 = float2( 0,0 );
			float2 UV32_g4053 = float2( 0,0 );
			float W02_g4053 = 0;
			float W12_g4053 = 0;
			{
			{
			 UV2_g4053 = UV2_g4053 * TexelSize2_g4053.zw - 0.5;
			    float2 f = frac( UV2_g4053 );
			    UV2_g4053 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g4053.x - 0.5, UV2_g4053.x + 1.5, UV2_g4053.y - 0.5, UV2_g4053.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g4053.xyxy;
			    UV02_g4053 = off.xz;
			    UV12_g4053 = off.yz;
			    UV22_g4053 = off.xw;
			    UV32_g4053 = off.yw;
			    W02_g4053 = s.x / ( s.x + s.y );
			 W12_g4053 = s.z / ( s.z + s.w );
			}
			}
			float4 lerpResult46_g4053 = lerp( tex2D( _Lightmap, UV32_g4053 ) , tex2D( _Lightmap, UV22_g4053 ) , W02_g4053);
			float4 lerpResult45_g4053 = lerp( tex2D( _Lightmap, UV12_g4053 ) , tex2D( _Lightmap, UV02_g4053 ) , W02_g4053);
			float4 lerpResult44_g4053 = lerp( lerpResult46_g4053 , lerpResult45_g4053 , W12_g4053);
			float4 Output_2D131_g4053 = lerpResult44_g4053;
			float3 appendResult139_g4055 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float localBicubicPrepare2_g4056 = ( 0.0 );
			float2 Input_UV100_g4056 = uv_BumpMap;
			float2 UV2_g4056 = Input_UV100_g4056;
			float4 TexelSize2_g4056 = _BumpMap_TexelSize;
			float2 UV02_g4056 = float2( 0,0 );
			float2 UV12_g4056 = float2( 0,0 );
			float2 UV22_g4056 = float2( 0,0 );
			float2 UV32_g4056 = float2( 0,0 );
			float W02_g4056 = 0;
			float W12_g4056 = 0;
			{
			{
			 UV2_g4056 = UV2_g4056 * TexelSize2_g4056.zw - 0.5;
			    float2 f = frac( UV2_g4056 );
			    UV2_g4056 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g4056.x - 0.5, UV2_g4056.x + 1.5, UV2_g4056.y - 0.5, UV2_g4056.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g4056.xyxy;
			    UV02_g4056 = off.xz;
			    UV12_g4056 = off.yz;
			    UV22_g4056 = off.xw;
			    UV32_g4056 = off.yw;
			    W02_g4056 = s.x / ( s.x + s.y );
			 W12_g4056 = s.z / ( s.z + s.w );
			}
			}
			float Normal_Map_Scale700_g4051 = _NormalScale;
			float temp_output_239_0_g4056 = Normal_Map_Scale700_g4051;
			float3 lerpResult46_g4056 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV32_g4056 ), temp_output_239_0_g4056 ) , UnpackScaleNormal( tex2D( _BumpMap, UV22_g4056 ), temp_output_239_0_g4056 ) , W02_g4056);
			float3 lerpResult45_g4056 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV12_g4056 ), temp_output_239_0_g4056 ) , UnpackScaleNormal( tex2D( _BumpMap, UV02_g4056 ), temp_output_239_0_g4056 ) , W02_g4056);
			float3 lerpResult44_g4056 = lerp( lerpResult46_g4056 , lerpResult45_g4056 , W12_g4056);
			float3 Output_2D131_g4056 = lerpResult44_g4056;
			float3 normalizeResult326_g4055 = normalize( Output_2D131_g4056 );
			float3 Normal_Map318_g4055 = normalizeResult326_g4055;
			float dotResult121_g4055 = dot( appendResult139_g4055 , Normal_Map318_g4055 );
			float2 uv_RNMX0 = i.uv_texcoord * _RNMX0_ST.xy + _RNMX0_ST.zw;
			float localStochasticTiling2_g4060 = ( 0.0 );
			float2 uv3_RNMX0 = i.uv3_texcoord3 * _RNMX0_ST.xy + _RNMX0_ST.zw;
			float2 UV2_g4060 = uv3_RNMX0;
			float4 TexelSize2_g4060 = _RNMX0_TexelSize;
			float4 Offsets2_g4060 = float4( 0,0,0,0 );
			float2 Weights2_g4060 = float2( 0,0 );
			{
			UV2_g4060 = UV2_g4060 * TexelSize2_g4060.zw - 0.5;
			float2 f = frac( UV2_g4060 );
			UV2_g4060 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g4060.x - 0.5, UV2_g4060.x + 1.5, UV2_g4060.y - 0.5, UV2_g4060.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g4060 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g4060.xyxy;
			Weights2_g4060 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g4057 = Offsets2_g4060;
			float4 Input_FetchOffsets197_g4061 = temp_output_1_34_g4057;
			float2 temp_output_1_54_g4057 = Weights2_g4060;
			float2 Input_FetchWeights200_g4061 = temp_output_1_54_g4057;
			float2 break187_g4061 = Input_FetchWeights200_g4061;
			float4 lerpResult181_g4061 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g4061).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g4061).xw ) , break187_g4061.x);
			float4 lerpResult182_g4061 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g4061).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g4061).xz ) , break187_g4061.x);
			float4 lerpResult176_g4061 = lerp( lerpResult181_g4061 , lerpResult182_g4061 , break187_g4061.y);
			float4 Output_Fetch2D202_g4061 = lerpResult176_g4061;
			#ifdef _USEBICUBICSAMPLER_ON
				float4 staticSwitch705_g4051 = Output_Fetch2D202_g4061;
			#else
				float4 staticSwitch705_g4051 = float4( tex2D( _RNMX0, uv_RNMX0 ).rgb , 0.0 );
			#endif
			float3 appendResult146_g4055 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g4055 = dot( appendResult146_g4055 , Normal_Map318_g4055 );
			float2 uv_RNMY0 = i.uv_texcoord * _RNMY0_ST.xy + _RNMY0_ST.zw;
			float4 Input_FetchOffsets197_g4058 = temp_output_1_34_g4057;
			float2 Input_FetchWeights200_g4058 = temp_output_1_54_g4057;
			float2 break187_g4058 = Input_FetchWeights200_g4058;
			float4 lerpResult181_g4058 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g4058).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g4058).xw ) , break187_g4058.x);
			float4 lerpResult182_g4058 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g4058).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g4058).xz ) , break187_g4058.x);
			float4 lerpResult176_g4058 = lerp( lerpResult181_g4058 , lerpResult182_g4058 , break187_g4058.y);
			float4 Output_Fetch2D202_g4058 = lerpResult176_g4058;
			#ifdef _USEBICUBICSAMPLER_ON
				float4 staticSwitch715_g4051 = Output_Fetch2D202_g4058;
			#else
				float4 staticSwitch715_g4051 = float4( tex2D( _RNMY0, uv_RNMY0 ).rgb , 0.0 );
			#endif
			float3 appendResult149_g4055 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g4055 = dot( appendResult149_g4055 , Normal_Map318_g4055 );
			float2 uv_RNMZ0 = i.uv_texcoord * _RNMZ0_ST.xy + _RNMZ0_ST.zw;
			float4 Input_FetchOffsets197_g4059 = temp_output_1_34_g4057;
			float2 Input_FetchWeights200_g4059 = temp_output_1_54_g4057;
			float2 break187_g4059 = Input_FetchWeights200_g4059;
			float4 lerpResult181_g4059 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g4059).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g4059).xw ) , break187_g4059.x);
			float4 lerpResult182_g4059 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g4059).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g4059).xz ) , break187_g4059.x);
			float4 lerpResult176_g4059 = lerp( lerpResult181_g4059 , lerpResult182_g4059 , break187_g4059.y);
			float4 Output_Fetch2D202_g4059 = lerpResult176_g4059;
			#ifdef _USEBICUBICSAMPLER_ON
				float4 staticSwitch716_g4051 = Output_Fetch2D202_g4059;
			#else
				float4 staticSwitch716_g4051 = float4( tex2D( _RNMZ0, uv_RNMZ0 ).rgb , 0.0 );
			#endif
			float4 temp_output_714_0_g4051 = ( ( ( saturate( dotResult121_g4055 ) * ( staticSwitch705_g4051 * 1.0 ) ) + ( saturate( dotResult122_g4055 ) * ( staticSwitch715_g4051 * 1.0 ) ) ) + ( saturate( dotResult120_g4055 ) * ( staticSwitch716_g4051 * 1.0 ) ) );
			float3 appendResult139_g4062 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float localBicubicPrepare2_g4063 = ( 0.0 );
			float2 Input_UV100_g4063 = uv_BumpMap;
			float2 UV2_g4063 = Input_UV100_g4063;
			float4 TexelSize2_g4063 = _BumpMap_TexelSize;
			float2 UV02_g4063 = float2( 0,0 );
			float2 UV12_g4063 = float2( 0,0 );
			float2 UV22_g4063 = float2( 0,0 );
			float2 UV32_g4063 = float2( 0,0 );
			float W02_g4063 = 0;
			float W12_g4063 = 0;
			{
			{
			 UV2_g4063 = UV2_g4063 * TexelSize2_g4063.zw - 0.5;
			    float2 f = frac( UV2_g4063 );
			    UV2_g4063 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g4063.x - 0.5, UV2_g4063.x + 1.5, UV2_g4063.y - 0.5, UV2_g4063.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g4063.xyxy;
			    UV02_g4063 = off.xz;
			    UV12_g4063 = off.yz;
			    UV22_g4063 = off.xw;
			    UV32_g4063 = off.yw;
			    W02_g4063 = s.x / ( s.x + s.y );
			 W12_g4063 = s.z / ( s.z + s.w );
			}
			}
			float temp_output_239_0_g4063 = Normal_Map_Scale700_g4051;
			float3 lerpResult46_g4063 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV32_g4063 ), temp_output_239_0_g4063 ) , UnpackScaleNormal( tex2D( _BumpMap, UV22_g4063 ), temp_output_239_0_g4063 ) , W02_g4063);
			float3 lerpResult45_g4063 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV12_g4063 ), temp_output_239_0_g4063 ) , UnpackScaleNormal( tex2D( _BumpMap, UV02_g4063 ), temp_output_239_0_g4063 ) , W02_g4063);
			float3 lerpResult44_g4063 = lerp( lerpResult46_g4063 , lerpResult45_g4063 , W12_g4063);
			float3 Output_2D131_g4063 = lerpResult44_g4063;
			float3 normalizeResult326_g4062 = normalize( Output_2D131_g4063 );
			float3 Normal_Map318_g4062 = normalizeResult326_g4062;
			float dotResult121_g4062 = dot( appendResult139_g4062 , Normal_Map318_g4062 );
			float2 uv_RNMX1 = i.uv_texcoord * _RNMX1_ST.xy + _RNMX1_ST.zw;
			float localStochasticTiling2_g4067 = ( 0.0 );
			float2 uv3_RNMX1 = i.uv3_texcoord3 * _RNMX1_ST.xy + _RNMX1_ST.zw;
			float2 UV2_g4067 = uv3_RNMX1;
			float4 TexelSize2_g4067 = _RNMX1_TexelSize;
			float4 Offsets2_g4067 = float4( 0,0,0,0 );
			float2 Weights2_g4067 = float2( 0,0 );
			{
			UV2_g4067 = UV2_g4067 * TexelSize2_g4067.zw - 0.5;
			float2 f = frac( UV2_g4067 );
			UV2_g4067 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g4067.x - 0.5, UV2_g4067.x + 1.5, UV2_g4067.y - 0.5, UV2_g4067.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g4067 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g4067.xyxy;
			Weights2_g4067 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g4064 = Offsets2_g4067;
			float4 Input_FetchOffsets197_g4068 = temp_output_1_34_g4064;
			float2 temp_output_1_54_g4064 = Weights2_g4067;
			float2 Input_FetchWeights200_g4068 = temp_output_1_54_g4064;
			float2 break187_g4068 = Input_FetchWeights200_g4068;
			float4 lerpResult181_g4068 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g4068).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g4068).xw ) , break187_g4068.x);
			float4 lerpResult182_g4068 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g4068).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g4068).xz ) , break187_g4068.x);
			float4 lerpResult176_g4068 = lerp( lerpResult181_g4068 , lerpResult182_g4068 , break187_g4068.y);
			float4 Output_Fetch2D202_g4068 = lerpResult176_g4068;
			#ifdef _USEBICUBICSAMPLER_ON
				float4 staticSwitch764_g4051 = Output_Fetch2D202_g4068;
			#else
				float4 staticSwitch764_g4051 = float4( tex2D( _RNMX1, uv_RNMX1 ).rgb , 0.0 );
			#endif
			float3 appendResult146_g4062 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g4062 = dot( appendResult146_g4062 , Normal_Map318_g4062 );
			float2 uv_RNMY1 = i.uv_texcoord * _RNMY1_ST.xy + _RNMY1_ST.zw;
			float4 Input_FetchOffsets197_g4065 = temp_output_1_34_g4064;
			float2 Input_FetchWeights200_g4065 = temp_output_1_54_g4064;
			float2 break187_g4065 = Input_FetchWeights200_g4065;
			float4 lerpResult181_g4065 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g4065).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g4065).xw ) , break187_g4065.x);
			float4 lerpResult182_g4065 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g4065).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g4065).xz ) , break187_g4065.x);
			float4 lerpResult176_g4065 = lerp( lerpResult181_g4065 , lerpResult182_g4065 , break187_g4065.y);
			float4 Output_Fetch2D202_g4065 = lerpResult176_g4065;
			#ifdef _USEBICUBICSAMPLER_ON
				float4 staticSwitch753_g4051 = Output_Fetch2D202_g4065;
			#else
				float4 staticSwitch753_g4051 = float4( tex2D( _RNMY1, uv_RNMY1 ).rgb , 0.0 );
			#endif
			float3 appendResult149_g4062 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g4062 = dot( appendResult149_g4062 , Normal_Map318_g4062 );
			float2 uv_RNMZ1 = i.uv_texcoord * _RNMZ1_ST.xy + _RNMZ1_ST.zw;
			float4 Input_FetchOffsets197_g4066 = temp_output_1_34_g4064;
			float2 Input_FetchWeights200_g4066 = temp_output_1_54_g4064;
			float2 break187_g4066 = Input_FetchWeights200_g4066;
			float4 lerpResult181_g4066 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g4066).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g4066).xw ) , break187_g4066.x);
			float4 lerpResult182_g4066 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g4066).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g4066).xz ) , break187_g4066.x);
			float4 lerpResult176_g4066 = lerp( lerpResult181_g4066 , lerpResult182_g4066 , break187_g4066.y);
			float4 Output_Fetch2D202_g4066 = lerpResult176_g4066;
			#ifdef _USEBICUBICSAMPLER_ON
				float4 staticSwitch750_g4051 = Output_Fetch2D202_g4066;
			#else
				float4 staticSwitch750_g4051 = float4( tex2D( _RNMZ1, uv_RNMZ1 ).rgb , 0.0 );
			#endif
			float4 lerpResult442_g4051 = lerp( temp_output_714_0_g4051 , ( ( ( saturate( dotResult121_g4062 ) * ( staticSwitch764_g4051 * 1.0 ) ) + ( saturate( dotResult122_g4062 ) * ( staticSwitch753_g4051 * 1.0 ) ) ) + ( saturate( dotResult120_g4062 ) * ( staticSwitch750_g4051 * 1.0 ) ) ) , _LightmapLerp);
			#if defined( _LIGHTMAPPINGMODE_SIMPLE )
				float4 staticSwitch565_g4051 = Output_2D131_g4053;
			#elif defined( _LIGHTMAPPINGMODE_RNM )
				float4 staticSwitch565_g4051 = temp_output_714_0_g4051;
			#elif defined( _LIGHTMAPPINGMODE_RNMLERP )
				float4 staticSwitch565_g4051 = lerpResult442_g4051;
			#else
				float4 staticSwitch565_g4051 = Output_2D131_g4053;
			#endif
			#ifdef _LIGHTMAPPING_ON
				float4 staticSwitch569_g4051 = staticSwitch565_g4051;
			#else
				float4 staticSwitch569_g4051 = temp_cast_4;
			#endif
			float4 Lightmap46_g4051 = staticSwitch569_g4051;
			#ifdef _LIGHTMAPPING_ON
				float4 staticSwitch566_g4051 = ( float4( Albedo6_g4051 , 0.0 ) * Lightmap46_g4051 );
			#else
				float4 staticSwitch566_g4051 = float4( Albedo6_g4051 , 0.0 );
			#endif
			#ifdef _LIGHTMAPPING_ON
				float4 staticSwitch696_g4051 = ( float4( staticSwitch572_g4051 , 0.0 ) + staticSwitch566_g4051 );
			#else
				float4 staticSwitch696_g4051 = ( float4( staticSwitch572_g4051 , 0.0 ) * staticSwitch566_g4051 );
			#endif
			#ifdef _LIGHTMAP_DEBUG_MODE_ON
				float4 staticSwitch686_g4051 = Lightmap46_g4051;
			#else
				float4 staticSwitch686_g4051 = staticSwitch696_g4051;
			#endif
			o.Emission = staticSwitch686_g4051.rgb;
			float2 uv_MetallicMap = i.uv_texcoord * _MetallicMap_ST.xy + _MetallicMap_ST.zw;
			#ifdef _LIGHTMAP_DEBUG_MODE_ON
				float3 staticSwitch692_g4051 = float3( 0,0,0 );
			#else
				float3 staticSwitch692_g4051 = ( _Metallic * tex2D( _MetallicMap, uv_MetallicMap ).rgb );
			#endif
			float3 Metallic699_g4051 = staticSwitch692_g4051;
			o.Metallic = Metallic699_g4051.x;
			float2 uv_EmissionMap164_g4051 = i.uv_texcoord;
			#ifdef _LIGHTMAP_DEBUG_MODE_ON
				float4 staticSwitch693_g4051 = float4( 0,0,0,0 );
			#else
				float4 staticSwitch693_g4051 = ( _Glossiness * ( 1.0 - tex2D( _EmissionMap1, uv_EmissionMap164_g4051 ) ) );
			#endif
			o.Smoothness = staticSwitch693_g4051.r;
			float4 temp_cast_15 = White38_g4051;
			float4 temp_cast_16 = White38_g4051;
			float4 saferPower606_g4051 = abs( Lightmap46_g4051 );
			float4 temp_cast_17 = (_OcclusionPower).xxxx;
			float4 clampResult579_g4051 = clamp( pow( saferPower606_g4051 , temp_cast_17 ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			#ifdef _LIGHTMAPOCCLUSION_ON
				float4 staticSwitch573_g4051 = clampResult579_g4051;
			#else
				float4 staticSwitch573_g4051 = temp_cast_16;
			#endif
			#ifdef _LIGHTMAPPING_ON
				float4 staticSwitch576_g4051 = staticSwitch573_g4051;
			#else
				float4 staticSwitch576_g4051 = temp_cast_15;
			#endif
			o.Occlusion = staticSwitch576_g4051.r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Fairplex/Standard Mobile"
	CustomEditor "Meenphie_ShaderGUI"
}
/*ASEBEGIN
Version=19901
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2737;240,-1200;Inherit;False;Meenphie Default;0;;4051;b3ba55a08dd6b49c7be16c6f35cf2033;0;0;8;FLOAT3;625;FLOAT3;238;COLOR;624;FLOAT3;96;COLOR;97;COLOR;95;FLOAT;156;FLOAT;427
Node;AmplifyShaderEditor.StandardSurfaceOutputNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1092;512,-1200;Float;False;True;-1;3;Meenphie_ShaderGUI;0;0;Standard;Meenphie/Standard;False;False;False;False;True;False;False;True;True;False;False;False;False;False;False;True;False;False;True;True;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;ForwardOnly;3;d3d11;glcore;vulkan;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0.0001;0,0,0,0;VertexOffset;False;False;Cylindrical;False;True;Relative;0;Fairplex/Standard Mobile;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;1092;0;2737;625
WireConnection;1092;1;2737;238
WireConnection;1092;2;2737;624
WireConnection;1092;3;2737;96
WireConnection;1092;4;2737;97
WireConnection;1092;5;2737;95
ASEEND*/
//CHKSM=0EDD8EADF5205CC3E84CAE9F642DA7E901913CC2