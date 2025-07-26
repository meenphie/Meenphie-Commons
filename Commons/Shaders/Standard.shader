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
			float localBicubicPrepare2_g3994 = ( 0.0 );
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float2 Input_UV100_g3994 = uv_BumpMap;
			float2 UV2_g3994 = Input_UV100_g3994;
			float4 TexelSize2_g3994 = _BumpMap_TexelSize;
			float2 UV02_g3994 = float2( 0,0 );
			float2 UV12_g3994 = float2( 0,0 );
			float2 UV22_g3994 = float2( 0,0 );
			float2 UV32_g3994 = float2( 0,0 );
			float W02_g3994 = 0;
			float W12_g3994 = 0;
			{
			{
			 UV2_g3994 = UV2_g3994 * TexelSize2_g3994.zw - 0.5;
			    float2 f = frac( UV2_g3994 );
			    UV2_g3994 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g3994.x - 0.5, UV2_g3994.x + 1.5, UV2_g3994.y - 0.5, UV2_g3994.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g3994.xyxy;
			    UV02_g3994 = off.xz;
			    UV12_g3994 = off.yz;
			    UV22_g3994 = off.xw;
			    UV32_g3994 = off.yw;
			    W02_g3994 = s.x / ( s.x + s.y );
			 W12_g3994 = s.z / ( s.z + s.w );
			}
			}
			float temp_output_239_0_g3994 = _NormalScale;
			float3 lerpResult46_g3994 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV32_g3994 ), temp_output_239_0_g3994 ) , UnpackScaleNormal( tex2D( _BumpMap, UV22_g3994 ), temp_output_239_0_g3994 ) , W02_g3994);
			float3 lerpResult45_g3994 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV12_g3994 ), temp_output_239_0_g3994 ) , UnpackScaleNormal( tex2D( _BumpMap, UV02_g3994 ), temp_output_239_0_g3994 ) , W02_g3994);
			float3 lerpResult44_g3994 = lerp( lerpResult46_g3994 , lerpResult45_g3994 , W12_g3994);
			float3 Output_2D131_g3994 = lerpResult44_g3994;
			o.Normal = Output_2D131_g3994;
			float2 uv_MainTex259_g3977 = i.uv_texcoord;
			float4 tex2DNode259_g3977 = tex2D( _MainTex, uv_MainTex259_g3977 );
			float3 temp_output_5_0_g3977 = ( _Color.rgb * tex2DNode259_g3977.rgb );
			o.Albedo = temp_output_5_0_g3977;
			float3 temp_cast_0 = 0;
			float2 uv_EmissionMap81_g3977 = i.uv_texcoord;
			float3 Emission86_g3977 = ( _EmissionColor + tex2D( _EmissionMap, uv_EmissionMap81_g3977 ).rgb );
			#ifdef _EMISSION_ON
				float3 staticSwitch572_g3977 = Emission86_g3977;
			#else
				float3 staticSwitch572_g3977 = temp_cast_0;
			#endif
			float3 Albedo6_g3977 = temp_output_5_0_g3977;
			int White38_g3977 = 1;
			float4 temp_cast_4 = White38_g3977;
			float localBicubicPrepare2_g3984 = ( 0.0 );
			float2 uv3_Lightmap = i.uv3_texcoord3 * _Lightmap_ST.xy + _Lightmap_ST.zw;
			float2 Input_UV100_g3984 = uv3_Lightmap;
			float2 UV2_g3984 = Input_UV100_g3984;
			float4 TexelSize2_g3984 = _Lightmap_TexelSize;
			float2 UV02_g3984 = float2( 0,0 );
			float2 UV12_g3984 = float2( 0,0 );
			float2 UV22_g3984 = float2( 0,0 );
			float2 UV32_g3984 = float2( 0,0 );
			float W02_g3984 = 0;
			float W12_g3984 = 0;
			{
			{
			 UV2_g3984 = UV2_g3984 * TexelSize2_g3984.zw - 0.5;
			    float2 f = frac( UV2_g3984 );
			    UV2_g3984 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g3984.x - 0.5, UV2_g3984.x + 1.5, UV2_g3984.y - 0.5, UV2_g3984.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g3984.xyxy;
			    UV02_g3984 = off.xz;
			    UV12_g3984 = off.yz;
			    UV22_g3984 = off.xw;
			    UV32_g3984 = off.yw;
			    W02_g3984 = s.x / ( s.x + s.y );
			 W12_g3984 = s.z / ( s.z + s.w );
			}
			}
			float4 lerpResult46_g3984 = lerp( tex2D( _Lightmap, UV32_g3984 ) , tex2D( _Lightmap, UV22_g3984 ) , W02_g3984);
			float4 lerpResult45_g3984 = lerp( tex2D( _Lightmap, UV12_g3984 ) , tex2D( _Lightmap, UV02_g3984 ) , W02_g3984);
			float4 lerpResult44_g3984 = lerp( lerpResult46_g3984 , lerpResult45_g3984 , W12_g3984);
			float4 Output_2D131_g3984 = lerpResult44_g3984;
			float3 appendResult139_g3992 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float localBicubicPrepare2_g3993 = ( 0.0 );
			float2 Input_UV100_g3993 = uv_BumpMap;
			float2 UV2_g3993 = Input_UV100_g3993;
			float4 TexelSize2_g3993 = _BumpMap_TexelSize;
			float2 UV02_g3993 = float2( 0,0 );
			float2 UV12_g3993 = float2( 0,0 );
			float2 UV22_g3993 = float2( 0,0 );
			float2 UV32_g3993 = float2( 0,0 );
			float W02_g3993 = 0;
			float W12_g3993 = 0;
			{
			{
			 UV2_g3993 = UV2_g3993 * TexelSize2_g3993.zw - 0.5;
			    float2 f = frac( UV2_g3993 );
			    UV2_g3993 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g3993.x - 0.5, UV2_g3993.x + 1.5, UV2_g3993.y - 0.5, UV2_g3993.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g3993.xyxy;
			    UV02_g3993 = off.xz;
			    UV12_g3993 = off.yz;
			    UV22_g3993 = off.xw;
			    UV32_g3993 = off.yw;
			    W02_g3993 = s.x / ( s.x + s.y );
			 W12_g3993 = s.z / ( s.z + s.w );
			}
			}
			float Normal_Map_Scale700_g3977 = _NormalScale;
			float temp_output_239_0_g3993 = Normal_Map_Scale700_g3977;
			float3 lerpResult46_g3993 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV32_g3993 ), temp_output_239_0_g3993 ) , UnpackScaleNormal( tex2D( _BumpMap, UV22_g3993 ), temp_output_239_0_g3993 ) , W02_g3993);
			float3 lerpResult45_g3993 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV12_g3993 ), temp_output_239_0_g3993 ) , UnpackScaleNormal( tex2D( _BumpMap, UV02_g3993 ), temp_output_239_0_g3993 ) , W02_g3993);
			float3 lerpResult44_g3993 = lerp( lerpResult46_g3993 , lerpResult45_g3993 , W12_g3993);
			float3 Output_2D131_g3993 = lerpResult44_g3993;
			float3 normalizeResult326_g3992 = normalize( Output_2D131_g3993 );
			float3 Normal_Map318_g3992 = normalizeResult326_g3992;
			float dotResult121_g3992 = dot( appendResult139_g3992 , Normal_Map318_g3992 );
			float localStochasticTiling2_g3990 = ( 0.0 );
			float2 uv3_RNMX0 = i.uv3_texcoord3 * _RNMX0_ST.xy + _RNMX0_ST.zw;
			float2 UV2_g3990 = uv3_RNMX0;
			float4 TexelSize2_g3990 = _RNMX0_TexelSize;
			float4 Offsets2_g3990 = float4( 0,0,0,0 );
			float2 Weights2_g3990 = float2( 0,0 );
			{
			UV2_g3990 = UV2_g3990 * TexelSize2_g3990.zw - 0.5;
			float2 f = frac( UV2_g3990 );
			UV2_g3990 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g3990.x - 0.5, UV2_g3990.x + 1.5, UV2_g3990.y - 0.5, UV2_g3990.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g3990 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g3990.xyxy;
			Weights2_g3990 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g3987 = Offsets2_g3990;
			float4 Input_FetchOffsets197_g3991 = temp_output_1_34_g3987;
			float2 temp_output_1_54_g3987 = Weights2_g3990;
			float2 Input_FetchWeights200_g3991 = temp_output_1_54_g3987;
			float2 break187_g3991 = Input_FetchWeights200_g3991;
			float4 lerpResult181_g3991 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g3991).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g3991).xw ) , break187_g3991.x);
			float4 lerpResult182_g3991 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g3991).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g3991).xz ) , break187_g3991.x);
			float4 lerpResult176_g3991 = lerp( lerpResult181_g3991 , lerpResult182_g3991 , break187_g3991.y);
			float4 Output_Fetch2D202_g3991 = lerpResult176_g3991;
			float3 appendResult146_g3992 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g3992 = dot( appendResult146_g3992 , Normal_Map318_g3992 );
			float4 Input_FetchOffsets197_g3988 = temp_output_1_34_g3987;
			float2 Input_FetchWeights200_g3988 = temp_output_1_54_g3987;
			float2 break187_g3988 = Input_FetchWeights200_g3988;
			float4 lerpResult181_g3988 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g3988).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g3988).xw ) , break187_g3988.x);
			float4 lerpResult182_g3988 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g3988).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g3988).xz ) , break187_g3988.x);
			float4 lerpResult176_g3988 = lerp( lerpResult181_g3988 , lerpResult182_g3988 , break187_g3988.y);
			float4 Output_Fetch2D202_g3988 = lerpResult176_g3988;
			float3 appendResult149_g3992 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g3992 = dot( appendResult149_g3992 , Normal_Map318_g3992 );
			float4 Input_FetchOffsets197_g3989 = temp_output_1_34_g3987;
			float2 Input_FetchWeights200_g3989 = temp_output_1_54_g3987;
			float2 break187_g3989 = Input_FetchWeights200_g3989;
			float4 lerpResult181_g3989 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g3989).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g3989).xw ) , break187_g3989.x);
			float4 lerpResult182_g3989 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g3989).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g3989).xz ) , break187_g3989.x);
			float4 lerpResult176_g3989 = lerp( lerpResult181_g3989 , lerpResult182_g3989 , break187_g3989.y);
			float4 Output_Fetch2D202_g3989 = lerpResult176_g3989;
			float4 temp_output_590_0_g3977 = ( ( ( saturate( dotResult121_g3992 ) * ( Output_Fetch2D202_g3991 * 1.0 ) ) + ( saturate( dotResult122_g3992 ) * ( Output_Fetch2D202_g3988 * 1.0 ) ) ) + ( saturate( dotResult120_g3992 ) * ( Output_Fetch2D202_g3989 * 1.0 ) ) );
			float3 appendResult139_g3985 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float localBicubicPrepare2_g3986 = ( 0.0 );
			float2 Input_UV100_g3986 = uv_BumpMap;
			float2 UV2_g3986 = Input_UV100_g3986;
			float4 TexelSize2_g3986 = _BumpMap_TexelSize;
			float2 UV02_g3986 = float2( 0,0 );
			float2 UV12_g3986 = float2( 0,0 );
			float2 UV22_g3986 = float2( 0,0 );
			float2 UV32_g3986 = float2( 0,0 );
			float W02_g3986 = 0;
			float W12_g3986 = 0;
			{
			{
			 UV2_g3986 = UV2_g3986 * TexelSize2_g3986.zw - 0.5;
			    float2 f = frac( UV2_g3986 );
			    UV2_g3986 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g3986.x - 0.5, UV2_g3986.x + 1.5, UV2_g3986.y - 0.5, UV2_g3986.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g3986.xyxy;
			    UV02_g3986 = off.xz;
			    UV12_g3986 = off.yz;
			    UV22_g3986 = off.xw;
			    UV32_g3986 = off.yw;
			    W02_g3986 = s.x / ( s.x + s.y );
			 W12_g3986 = s.z / ( s.z + s.w );
			}
			}
			float temp_output_239_0_g3986 = Normal_Map_Scale700_g3977;
			float3 lerpResult46_g3986 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV32_g3986 ), temp_output_239_0_g3986 ) , UnpackScaleNormal( tex2D( _BumpMap, UV22_g3986 ), temp_output_239_0_g3986 ) , W02_g3986);
			float3 lerpResult45_g3986 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV12_g3986 ), temp_output_239_0_g3986 ) , UnpackScaleNormal( tex2D( _BumpMap, UV02_g3986 ), temp_output_239_0_g3986 ) , W02_g3986);
			float3 lerpResult44_g3986 = lerp( lerpResult46_g3986 , lerpResult45_g3986 , W12_g3986);
			float3 Output_2D131_g3986 = lerpResult44_g3986;
			float3 normalizeResult326_g3985 = normalize( Output_2D131_g3986 );
			float3 Normal_Map318_g3985 = normalizeResult326_g3985;
			float dotResult121_g3985 = dot( appendResult139_g3985 , Normal_Map318_g3985 );
			float localStochasticTiling2_g3981 = ( 0.0 );
			float2 uv3_RNMX1 = i.uv3_texcoord3 * _RNMX1_ST.xy + _RNMX1_ST.zw;
			float2 UV2_g3981 = uv3_RNMX1;
			float4 TexelSize2_g3981 = _RNMX1_TexelSize;
			float4 Offsets2_g3981 = float4( 0,0,0,0 );
			float2 Weights2_g3981 = float2( 0,0 );
			{
			UV2_g3981 = UV2_g3981 * TexelSize2_g3981.zw - 0.5;
			float2 f = frac( UV2_g3981 );
			UV2_g3981 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g3981.x - 0.5, UV2_g3981.x + 1.5, UV2_g3981.y - 0.5, UV2_g3981.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g3981 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g3981.xyxy;
			Weights2_g3981 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g3978 = Offsets2_g3981;
			float4 Input_FetchOffsets197_g3982 = temp_output_1_34_g3978;
			float2 temp_output_1_54_g3978 = Weights2_g3981;
			float2 Input_FetchWeights200_g3982 = temp_output_1_54_g3978;
			float2 break187_g3982 = Input_FetchWeights200_g3982;
			float4 lerpResult181_g3982 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g3982).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g3982).xw ) , break187_g3982.x);
			float4 lerpResult182_g3982 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g3982).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g3982).xz ) , break187_g3982.x);
			float4 lerpResult176_g3982 = lerp( lerpResult181_g3982 , lerpResult182_g3982 , break187_g3982.y);
			float4 Output_Fetch2D202_g3982 = lerpResult176_g3982;
			float3 appendResult146_g3985 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g3985 = dot( appendResult146_g3985 , Normal_Map318_g3985 );
			float4 Input_FetchOffsets197_g3979 = temp_output_1_34_g3978;
			float2 Input_FetchWeights200_g3979 = temp_output_1_54_g3978;
			float2 break187_g3979 = Input_FetchWeights200_g3979;
			float4 lerpResult181_g3979 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g3979).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g3979).xw ) , break187_g3979.x);
			float4 lerpResult182_g3979 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g3979).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g3979).xz ) , break187_g3979.x);
			float4 lerpResult176_g3979 = lerp( lerpResult181_g3979 , lerpResult182_g3979 , break187_g3979.y);
			float4 Output_Fetch2D202_g3979 = lerpResult176_g3979;
			float3 appendResult149_g3985 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g3985 = dot( appendResult149_g3985 , Normal_Map318_g3985 );
			float4 Input_FetchOffsets197_g3980 = temp_output_1_34_g3978;
			float2 Input_FetchWeights200_g3980 = temp_output_1_54_g3978;
			float2 break187_g3980 = Input_FetchWeights200_g3980;
			float4 lerpResult181_g3980 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g3980).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g3980).xw ) , break187_g3980.x);
			float4 lerpResult182_g3980 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g3980).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g3980).xz ) , break187_g3980.x);
			float4 lerpResult176_g3980 = lerp( lerpResult181_g3980 , lerpResult182_g3980 , break187_g3980.y);
			float4 Output_Fetch2D202_g3980 = lerpResult176_g3980;
			float4 lerpResult442_g3977 = lerp( temp_output_590_0_g3977 , ( ( ( saturate( dotResult121_g3985 ) * ( Output_Fetch2D202_g3982 * 1.0 ) ) + ( saturate( dotResult122_g3985 ) * ( Output_Fetch2D202_g3979 * 1.0 ) ) ) + ( saturate( dotResult120_g3985 ) * ( Output_Fetch2D202_g3980 * 1.0 ) ) ) , _LightmapLerp);
			#if defined( _LIGHTMAPPINGMODE_SIMPLE )
				float4 staticSwitch565_g3977 = Output_2D131_g3984;
			#elif defined( _LIGHTMAPPINGMODE_RNM )
				float4 staticSwitch565_g3977 = temp_output_590_0_g3977;
			#elif defined( _LIGHTMAPPINGMODE_RNMLERP )
				float4 staticSwitch565_g3977 = lerpResult442_g3977;
			#else
				float4 staticSwitch565_g3977 = Output_2D131_g3984;
			#endif
			#ifdef _LIGHTMAPPING_ON
				float4 staticSwitch569_g3977 = staticSwitch565_g3977;
			#else
				float4 staticSwitch569_g3977 = temp_cast_4;
			#endif
			float4 Lightmap46_g3977 = staticSwitch569_g3977;
			#ifdef _LIGHTMAPPING_ON
				float4 staticSwitch566_g3977 = ( float4( Albedo6_g3977 , 0.0 ) * Lightmap46_g3977 );
			#else
				float4 staticSwitch566_g3977 = float4( Albedo6_g3977 , 0.0 );
			#endif
			#ifdef _LIGHTMAPPING_ON
				float4 staticSwitch696_g3977 = ( float4( staticSwitch572_g3977 , 0.0 ) + staticSwitch566_g3977 );
			#else
				float4 staticSwitch696_g3977 = ( float4( staticSwitch572_g3977 , 0.0 ) * staticSwitch566_g3977 );
			#endif
			#ifdef _LIGHTMAP_DEBUG_MODE_ON
				float4 staticSwitch686_g3977 = Lightmap46_g3977;
			#else
				float4 staticSwitch686_g3977 = staticSwitch696_g3977;
			#endif
			o.Emission = staticSwitch686_g3977.rgb;
			float2 uv_MetallicMap = i.uv_texcoord * _MetallicMap_ST.xy + _MetallicMap_ST.zw;
			#ifdef _LIGHTMAP_DEBUG_MODE_ON
				float3 staticSwitch692_g3977 = float3( 0,0,0 );
			#else
				float3 staticSwitch692_g3977 = ( _Metallic * tex2D( _MetallicMap, uv_MetallicMap ).rgb );
			#endif
			float3 Metallic699_g3977 = staticSwitch692_g3977;
			o.Metallic = Metallic699_g3977.x;
			float2 uv_EmissionMap164_g3977 = i.uv_texcoord;
			#ifdef _LIGHTMAP_DEBUG_MODE_ON
				float4 staticSwitch693_g3977 = float4( 0,0,0,0 );
			#else
				float4 staticSwitch693_g3977 = ( _Glossiness * ( 1.0 - tex2D( _EmissionMap1, uv_EmissionMap164_g3977 ) ) );
			#endif
			o.Smoothness = staticSwitch693_g3977.r;
			float4 temp_cast_9 = White38_g3977;
			float4 temp_cast_10 = White38_g3977;
			float4 saferPower606_g3977 = abs( Lightmap46_g3977 );
			float4 temp_cast_11 = (_OcclusionPower).xxxx;
			float4 clampResult579_g3977 = clamp( pow( saferPower606_g3977 , temp_cast_11 ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			#ifdef _LIGHTMAPOCCLUSION_ON
				float4 staticSwitch573_g3977 = clampResult579_g3977;
			#else
				float4 staticSwitch573_g3977 = temp_cast_10;
			#endif
			#ifdef _LIGHTMAPPING_ON
				float4 staticSwitch576_g3977 = staticSwitch573_g3977;
			#else
				float4 staticSwitch576_g3977 = temp_cast_9;
			#endif
			o.Occlusion = staticSwitch576_g3977.r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Fairplex/Standard Mobile"
	CustomEditor "Meenphie_ShaderGUI"
}
/*ASEBEGIN
Version=19901
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2733;240,-1200;Inherit;False;Meenphie Default;0;;3977;b3ba55a08dd6b49c7be16c6f35cf2033;0;0;8;FLOAT3;625;FLOAT3;238;COLOR;624;FLOAT3;96;COLOR;97;COLOR;95;FLOAT;156;FLOAT;427
Node;AmplifyShaderEditor.StandardSurfaceOutputNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1092;512,-1200;Float;False;True;-1;3;Meenphie_ShaderGUI;0;0;Standard;Meenphie/Standard;False;False;False;False;True;False;False;True;True;False;False;False;False;False;False;True;False;False;True;True;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;ForwardOnly;3;d3d11;glcore;vulkan;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0.0001;0,0,0,0;VertexOffset;False;False;Cylindrical;False;True;Relative;0;Fairplex/Standard Mobile;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;1092;0;2733;625
WireConnection;1092;1;2733;238
WireConnection;1092;2;2733;624
WireConnection;1092;3;2733;96
WireConnection;1092;4;2733;97
WireConnection;1092;5;2733;95
ASEEND*/
//CHKSM=550F44C1E7FCF3B9FFDD49C776C144815615B051