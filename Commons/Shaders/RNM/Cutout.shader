// Made with Amplify Shader Editor v1.9.9.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/RNM/Cutout"
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
		[Toggle( _USEGEOMETRICANTIALIASING_ON )] _UseGeometricAntiAliasing( "Use Geometric Anti Aliasing", Float ) = 0
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
		[Toggle( _USEBICUBICSAMPLER_ON )] _UseBicubicSampler( "Use Bicubic Sampler", Float ) = 1
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
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IgnoreProjector" = "True" "ForceNoShadowCasting" = "True" "IsEmissive" = "true"  }
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
		#pragma shader_feature_local _USEBICUBICSAMPLER_ON
		#pragma shader_feature_local _USEGEOMETRICANTIALIASING_ON
		#pragma shader_feature_local _LIGHTMAPOCCLUSION_ON
		#define ASE_VERSION 19901
		#pragma surface surf Standard keepalpha exclude_path:deferred noambient nodynlightmap nodirlightmap 
		struct Input
		{
			float2 uv_texcoord;
			float2 uv3_texcoord3;
			float3 worldNormal;
			INTERNAL_DATA
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
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float localBicubicPrepare2_g1955 = ( 0.0 );
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float2 Input_UV100_g1955 = uv_BumpMap;
			float2 UV2_g1955 = Input_UV100_g1955;
			float4 TexelSize2_g1955 = _BumpMap_TexelSize;
			float2 UV02_g1955 = float2( 0,0 );
			float2 UV12_g1955 = float2( 0,0 );
			float2 UV22_g1955 = float2( 0,0 );
			float2 UV32_g1955 = float2( 0,0 );
			float W02_g1955 = 0;
			float W12_g1955 = 0;
			{
			{
			 UV2_g1955 = UV2_g1955 * TexelSize2_g1955.zw - 0.5;
			    float2 f = frac( UV2_g1955 );
			    UV2_g1955 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g1955.x - 0.5, UV2_g1955.x + 1.5, UV2_g1955.y - 0.5, UV2_g1955.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1955.xyxy;
			    UV02_g1955 = off.xz;
			    UV12_g1955 = off.yz;
			    UV22_g1955 = off.xw;
			    UV32_g1955 = off.yw;
			    W02_g1955 = s.x / ( s.x + s.y );
			 W12_g1955 = s.z / ( s.z + s.w );
			}
			}
			float temp_output_239_0_g1955 = _NormalScale;
			float3 lerpResult46_g1955 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV32_g1955 ), temp_output_239_0_g1955 ) , UnpackScaleNormal( tex2D( _BumpMap, UV22_g1955 ), temp_output_239_0_g1955 ) , W02_g1955);
			float3 lerpResult45_g1955 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV12_g1955 ), temp_output_239_0_g1955 ) , UnpackScaleNormal( tex2D( _BumpMap, UV02_g1955 ), temp_output_239_0_g1955 ) , W02_g1955);
			float3 lerpResult44_g1955 = lerp( lerpResult46_g1955 , lerpResult45_g1955 , W12_g1955);
			float3 Output_2D131_g1955 = lerpResult44_g1955;
			o.Normal = Output_2D131_g1955;
			float2 uv_MainTex259_g1954 = i.uv_texcoord;
			float4 tex2DNode259_g1954 = tex2D( _MainTex, uv_MainTex259_g1954 );
			float3 temp_output_5_0_g1954 = ( _Color.rgb * tex2DNode259_g1954.rgb );
			o.Albedo = temp_output_5_0_g1954;
			float3 temp_cast_0 = 0;
			float2 uv_EmissionMap81_g1954 = i.uv_texcoord;
			float3 Emission86_g1954 = ( _EmissionColor + tex2D( _EmissionMap, uv_EmissionMap81_g1954 ).rgb );
			#ifdef _EMISSION_ON
				float3 staticSwitch572_g1954 = Emission86_g1954;
			#else
				float3 staticSwitch572_g1954 = temp_cast_0;
			#endif
			float3 Albedo6_g1954 = temp_output_5_0_g1954;
			int White38_g1954 = 1;
			float3 temp_cast_1 = White38_g1954;
			float localBicubicPrepare2_g1966 = ( 0.0 );
			float2 uv3_Lightmap = i.uv3_texcoord3 * _Lightmap_ST.xy + _Lightmap_ST.zw;
			float2 Input_UV100_g1966 = uv3_Lightmap;
			float2 UV2_g1966 = Input_UV100_g1966;
			float4 TexelSize2_g1966 = _Lightmap_TexelSize;
			float2 UV02_g1966 = float2( 0,0 );
			float2 UV12_g1966 = float2( 0,0 );
			float2 UV22_g1966 = float2( 0,0 );
			float2 UV32_g1966 = float2( 0,0 );
			float W02_g1966 = 0;
			float W12_g1966 = 0;
			{
			{
			 UV2_g1966 = UV2_g1966 * TexelSize2_g1966.zw - 0.5;
			    float2 f = frac( UV2_g1966 );
			    UV2_g1966 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g1966.x - 0.5, UV2_g1966.x + 1.5, UV2_g1966.y - 0.5, UV2_g1966.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1966.xyxy;
			    UV02_g1966 = off.xz;
			    UV12_g1966 = off.yz;
			    UV22_g1966 = off.xw;
			    UV32_g1966 = off.yw;
			    W02_g1966 = s.x / ( s.x + s.y );
			 W12_g1966 = s.z / ( s.z + s.w );
			}
			}
			float3 lerpResult46_g1966 = lerp( tex2D( _Lightmap, UV32_g1966 ).rgb , tex2D( _Lightmap, UV22_g1966 ).rgb , W02_g1966);
			float3 lerpResult45_g1966 = lerp( tex2D( _Lightmap, UV12_g1966 ).rgb , tex2D( _Lightmap, UV02_g1966 ).rgb , W02_g1966);
			float3 lerpResult44_g1966 = lerp( lerpResult46_g1966 , lerpResult45_g1966 , W12_g1966);
			float3 Output_2D131_g1966 = lerpResult44_g1966;
			#ifdef _USEBICUBICSAMPLER_ON
				float3 staticSwitch768_g1954 = Output_2D131_g1966;
			#else
				float3 staticSwitch768_g1954 = tex2D( _Lightmap, i.uv3_texcoord3 ).rgb;
			#endif
			float3 appendResult139_g1956 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float localBicubicPrepare2_g1957 = ( 0.0 );
			float2 Input_UV100_g1957 = uv_BumpMap;
			float2 UV2_g1957 = Input_UV100_g1957;
			float4 TexelSize2_g1957 = _BumpMap_TexelSize;
			float2 UV02_g1957 = float2( 0,0 );
			float2 UV12_g1957 = float2( 0,0 );
			float2 UV22_g1957 = float2( 0,0 );
			float2 UV32_g1957 = float2( 0,0 );
			float W02_g1957 = 0;
			float W12_g1957 = 0;
			{
			{
			 UV2_g1957 = UV2_g1957 * TexelSize2_g1957.zw - 0.5;
			    float2 f = frac( UV2_g1957 );
			    UV2_g1957 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g1957.x - 0.5, UV2_g1957.x + 1.5, UV2_g1957.y - 0.5, UV2_g1957.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1957.xyxy;
			    UV02_g1957 = off.xz;
			    UV12_g1957 = off.yz;
			    UV22_g1957 = off.xw;
			    UV32_g1957 = off.yw;
			    W02_g1957 = s.x / ( s.x + s.y );
			 W12_g1957 = s.z / ( s.z + s.w );
			}
			}
			float Normal_Map_Scale700_g1954 = _NormalScale;
			float temp_output_239_0_g1957 = Normal_Map_Scale700_g1954;
			float3 lerpResult46_g1957 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV32_g1957 ), temp_output_239_0_g1957 ) , UnpackScaleNormal( tex2D( _BumpMap, UV22_g1957 ), temp_output_239_0_g1957 ) , W02_g1957);
			float3 lerpResult45_g1957 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV12_g1957 ), temp_output_239_0_g1957 ) , UnpackScaleNormal( tex2D( _BumpMap, UV02_g1957 ), temp_output_239_0_g1957 ) , W02_g1957);
			float3 lerpResult44_g1957 = lerp( lerpResult46_g1957 , lerpResult45_g1957 , W12_g1957);
			float3 Output_2D131_g1957 = lerpResult44_g1957;
			float3 normalizeResult326_g1956 = normalize( Output_2D131_g1957 );
			float3 Normal_Map318_g1956 = normalizeResult326_g1956;
			float dotResult121_g1956 = dot( appendResult139_g1956 , Normal_Map318_g1956 );
			float localStochasticTiling2_g1968 = ( 0.0 );
			float2 uv3_RNMX0 = i.uv3_texcoord3 * _RNMX0_ST.xy + _RNMX0_ST.zw;
			float2 UV2_g1968 = uv3_RNMX0;
			float4 TexelSize2_g1968 = _RNMX0_TexelSize;
			float4 Offsets2_g1968 = float4( 0,0,0,0 );
			float2 Weights2_g1968 = float2( 0,0 );
			{
			UV2_g1968 = UV2_g1968 * TexelSize2_g1968.zw - 0.5;
			float2 f = frac( UV2_g1968 );
			UV2_g1968 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g1968.x - 0.5, UV2_g1968.x + 1.5, UV2_g1968.y - 0.5, UV2_g1968.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g1968 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1968.xyxy;
			Weights2_g1968 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g1967 = Offsets2_g1968;
			float4 Input_FetchOffsets197_g1971 = temp_output_1_34_g1967;
			float2 temp_output_1_54_g1967 = Weights2_g1968;
			float2 Input_FetchWeights200_g1971 = temp_output_1_54_g1967;
			float2 break187_g1971 = Input_FetchWeights200_g1971;
			float3 lerpResult181_g1971 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g1971).yw ).rgb , tex2D( _RNMX0, (Input_FetchOffsets197_g1971).xw ).rgb , break187_g1971.x);
			float3 lerpResult182_g1971 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g1971).yz ).rgb , tex2D( _RNMX0, (Input_FetchOffsets197_g1971).xz ).rgb , break187_g1971.x);
			float3 lerpResult176_g1971 = lerp( lerpResult181_g1971 , lerpResult182_g1971 , break187_g1971.y);
			float3 Output_Fetch2D202_g1971 = lerpResult176_g1971;
			#ifdef _USEBICUBICSAMPLER_ON
				float3 staticSwitch705_g1954 = Output_Fetch2D202_g1971;
			#else
				float3 staticSwitch705_g1954 = tex2D( _RNMX0, i.uv3_texcoord3 ).rgb;
			#endif
			float3 appendResult146_g1956 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g1956 = dot( appendResult146_g1956 , Normal_Map318_g1956 );
			float4 Input_FetchOffsets197_g1969 = temp_output_1_34_g1967;
			float2 Input_FetchWeights200_g1969 = temp_output_1_54_g1967;
			float2 break187_g1969 = Input_FetchWeights200_g1969;
			float3 lerpResult181_g1969 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g1969).yw ).rgb , tex2D( _RNMY0, (Input_FetchOffsets197_g1969).xw ).rgb , break187_g1969.x);
			float3 lerpResult182_g1969 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g1969).yz ).rgb , tex2D( _RNMY0, (Input_FetchOffsets197_g1969).xz ).rgb , break187_g1969.x);
			float3 lerpResult176_g1969 = lerp( lerpResult181_g1969 , lerpResult182_g1969 , break187_g1969.y);
			float3 Output_Fetch2D202_g1969 = lerpResult176_g1969;
			#ifdef _USEBICUBICSAMPLER_ON
				float3 staticSwitch715_g1954 = Output_Fetch2D202_g1969;
			#else
				float3 staticSwitch715_g1954 = tex2D( _RNMY0, i.uv3_texcoord3 ).rgb;
			#endif
			float3 appendResult149_g1956 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g1956 = dot( appendResult149_g1956 , Normal_Map318_g1956 );
			float4 Input_FetchOffsets197_g1970 = temp_output_1_34_g1967;
			float2 Input_FetchWeights200_g1970 = temp_output_1_54_g1967;
			float2 break187_g1970 = Input_FetchWeights200_g1970;
			float3 lerpResult181_g1970 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g1970).yw ).rgb , tex2D( _RNMZ0, (Input_FetchOffsets197_g1970).xw ).rgb , break187_g1970.x);
			float3 lerpResult182_g1970 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g1970).yz ).rgb , tex2D( _RNMZ0, (Input_FetchOffsets197_g1970).xz ).rgb , break187_g1970.x);
			float3 lerpResult176_g1970 = lerp( lerpResult181_g1970 , lerpResult182_g1970 , break187_g1970.y);
			float3 Output_Fetch2D202_g1970 = lerpResult176_g1970;
			#ifdef _USEBICUBICSAMPLER_ON
				float3 staticSwitch716_g1954 = Output_Fetch2D202_g1970;
			#else
				float3 staticSwitch716_g1954 = tex2D( _RNMZ0, i.uv3_texcoord3 ).rgb;
			#endif
			float3 temp_output_714_0_g1954 = ( ( ( saturate( dotResult121_g1956 ) * ( staticSwitch705_g1954 * 1.0 ) ) + ( saturate( dotResult122_g1956 ) * ( staticSwitch715_g1954 * 1.0 ) ) ) + ( saturate( dotResult120_g1956 ) * ( staticSwitch716_g1954 * 1.0 ) ) );
			float3 appendResult139_g1958 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float localBicubicPrepare2_g1959 = ( 0.0 );
			float2 Input_UV100_g1959 = uv_BumpMap;
			float2 UV2_g1959 = Input_UV100_g1959;
			float4 TexelSize2_g1959 = _BumpMap_TexelSize;
			float2 UV02_g1959 = float2( 0,0 );
			float2 UV12_g1959 = float2( 0,0 );
			float2 UV22_g1959 = float2( 0,0 );
			float2 UV32_g1959 = float2( 0,0 );
			float W02_g1959 = 0;
			float W12_g1959 = 0;
			{
			{
			 UV2_g1959 = UV2_g1959 * TexelSize2_g1959.zw - 0.5;
			    float2 f = frac( UV2_g1959 );
			    UV2_g1959 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g1959.x - 0.5, UV2_g1959.x + 1.5, UV2_g1959.y - 0.5, UV2_g1959.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1959.xyxy;
			    UV02_g1959 = off.xz;
			    UV12_g1959 = off.yz;
			    UV22_g1959 = off.xw;
			    UV32_g1959 = off.yw;
			    W02_g1959 = s.x / ( s.x + s.y );
			 W12_g1959 = s.z / ( s.z + s.w );
			}
			}
			float temp_output_239_0_g1959 = Normal_Map_Scale700_g1954;
			float3 lerpResult46_g1959 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV32_g1959 ), temp_output_239_0_g1959 ) , UnpackScaleNormal( tex2D( _BumpMap, UV22_g1959 ), temp_output_239_0_g1959 ) , W02_g1959);
			float3 lerpResult45_g1959 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV12_g1959 ), temp_output_239_0_g1959 ) , UnpackScaleNormal( tex2D( _BumpMap, UV02_g1959 ), temp_output_239_0_g1959 ) , W02_g1959);
			float3 lerpResult44_g1959 = lerp( lerpResult46_g1959 , lerpResult45_g1959 , W12_g1959);
			float3 Output_2D131_g1959 = lerpResult44_g1959;
			float3 normalizeResult326_g1958 = normalize( Output_2D131_g1959 );
			float3 Normal_Map318_g1958 = normalizeResult326_g1958;
			float dotResult121_g1958 = dot( appendResult139_g1958 , Normal_Map318_g1958 );
			float localStochasticTiling2_g1961 = ( 0.0 );
			float2 uv3_RNMX1 = i.uv3_texcoord3 * _RNMX1_ST.xy + _RNMX1_ST.zw;
			float2 UV2_g1961 = uv3_RNMX1;
			float4 TexelSize2_g1961 = _RNMX1_TexelSize;
			float4 Offsets2_g1961 = float4( 0,0,0,0 );
			float2 Weights2_g1961 = float2( 0,0 );
			{
			UV2_g1961 = UV2_g1961 * TexelSize2_g1961.zw - 0.5;
			float2 f = frac( UV2_g1961 );
			UV2_g1961 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g1961.x - 0.5, UV2_g1961.x + 1.5, UV2_g1961.y - 0.5, UV2_g1961.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g1961 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1961.xyxy;
			Weights2_g1961 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g1960 = Offsets2_g1961;
			float4 Input_FetchOffsets197_g1964 = temp_output_1_34_g1960;
			float2 temp_output_1_54_g1960 = Weights2_g1961;
			float2 Input_FetchWeights200_g1964 = temp_output_1_54_g1960;
			float2 break187_g1964 = Input_FetchWeights200_g1964;
			float3 lerpResult181_g1964 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g1964).yw ).rgb , tex2D( _RNMX1, (Input_FetchOffsets197_g1964).xw ).rgb , break187_g1964.x);
			float3 lerpResult182_g1964 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g1964).yz ).rgb , tex2D( _RNMX1, (Input_FetchOffsets197_g1964).xz ).rgb , break187_g1964.x);
			float3 lerpResult176_g1964 = lerp( lerpResult181_g1964 , lerpResult182_g1964 , break187_g1964.y);
			float3 Output_Fetch2D202_g1964 = lerpResult176_g1964;
			#ifdef _USEBICUBICSAMPLER_ON
				float3 staticSwitch764_g1954 = Output_Fetch2D202_g1964;
			#else
				float3 staticSwitch764_g1954 = tex2D( _RNMX1, i.uv3_texcoord3 ).rgb;
			#endif
			float3 appendResult146_g1958 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g1958 = dot( appendResult146_g1958 , Normal_Map318_g1958 );
			float4 Input_FetchOffsets197_g1962 = temp_output_1_34_g1960;
			float2 Input_FetchWeights200_g1962 = temp_output_1_54_g1960;
			float2 break187_g1962 = Input_FetchWeights200_g1962;
			float3 lerpResult181_g1962 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g1962).yw ).rgb , tex2D( _RNMY1, (Input_FetchOffsets197_g1962).xw ).rgb , break187_g1962.x);
			float3 lerpResult182_g1962 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g1962).yz ).rgb , tex2D( _RNMY1, (Input_FetchOffsets197_g1962).xz ).rgb , break187_g1962.x);
			float3 lerpResult176_g1962 = lerp( lerpResult181_g1962 , lerpResult182_g1962 , break187_g1962.y);
			float3 Output_Fetch2D202_g1962 = lerpResult176_g1962;
			#ifdef _USEBICUBICSAMPLER_ON
				float3 staticSwitch753_g1954 = Output_Fetch2D202_g1962;
			#else
				float3 staticSwitch753_g1954 = tex2D( _RNMY1, i.uv3_texcoord3 ).rgb;
			#endif
			float3 appendResult149_g1958 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g1958 = dot( appendResult149_g1958 , Normal_Map318_g1958 );
			float4 Input_FetchOffsets197_g1963 = temp_output_1_34_g1960;
			float2 Input_FetchWeights200_g1963 = temp_output_1_54_g1960;
			float2 break187_g1963 = Input_FetchWeights200_g1963;
			float3 lerpResult181_g1963 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g1963).yw ).rgb , tex2D( _RNMZ1, (Input_FetchOffsets197_g1963).xw ).rgb , break187_g1963.x);
			float3 lerpResult182_g1963 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g1963).yz ).rgb , tex2D( _RNMZ1, (Input_FetchOffsets197_g1963).xz ).rgb , break187_g1963.x);
			float3 lerpResult176_g1963 = lerp( lerpResult181_g1963 , lerpResult182_g1963 , break187_g1963.y);
			float3 Output_Fetch2D202_g1963 = lerpResult176_g1963;
			#ifdef _USEBICUBICSAMPLER_ON
				float3 staticSwitch750_g1954 = Output_Fetch2D202_g1963;
			#else
				float3 staticSwitch750_g1954 = tex2D( _RNMZ1, i.uv3_texcoord3 ).rgb;
			#endif
			float3 lerpResult442_g1954 = lerp( temp_output_714_0_g1954 , ( ( ( saturate( dotResult121_g1958 ) * ( staticSwitch764_g1954 * 1.0 ) ) + ( saturate( dotResult122_g1958 ) * ( staticSwitch753_g1954 * 1.0 ) ) ) + ( saturate( dotResult120_g1958 ) * ( staticSwitch750_g1954 * 1.0 ) ) ) , _LightmapLerp);
			#if defined( _LIGHTMAPPINGMODE_SIMPLE )
				float3 staticSwitch565_g1954 = staticSwitch768_g1954;
			#elif defined( _LIGHTMAPPINGMODE_RNM )
				float3 staticSwitch565_g1954 = temp_output_714_0_g1954;
			#elif defined( _LIGHTMAPPINGMODE_RNMLERP )
				float3 staticSwitch565_g1954 = lerpResult442_g1954;
			#else
				float3 staticSwitch565_g1954 = staticSwitch768_g1954;
			#endif
			#ifdef _LIGHTMAPPING_ON
				float3 staticSwitch569_g1954 = staticSwitch565_g1954;
			#else
				float3 staticSwitch569_g1954 = temp_cast_1;
			#endif
			float3 Lightmap46_g1954 = staticSwitch569_g1954;
			#ifdef _LIGHTMAPPING_ON
				float3 staticSwitch566_g1954 = ( Albedo6_g1954 * Lightmap46_g1954 );
			#else
				float3 staticSwitch566_g1954 = Albedo6_g1954;
			#endif
			#ifdef _LIGHTMAPPING_ON
				float3 staticSwitch696_g1954 = ( staticSwitch572_g1954 + staticSwitch566_g1954 );
			#else
				float3 staticSwitch696_g1954 = ( staticSwitch572_g1954 * staticSwitch566_g1954 );
			#endif
			#ifdef _LIGHTMAP_DEBUG_MODE_ON
				float3 staticSwitch686_g1954 = Lightmap46_g1954;
			#else
				float3 staticSwitch686_g1954 = staticSwitch696_g1954;
			#endif
			o.Emission = staticSwitch686_g1954;
			float2 uv_MetallicMap = i.uv_texcoord * _MetallicMap_ST.xy + _MetallicMap_ST.zw;
			float saferPower803_g1954 = abs( tex2D( _MetallicMap, uv_MetallicMap ).a );
			#ifdef _LIGHTMAP_DEBUG_MODE_ON
				float staticSwitch692_g1954 = 0.0;
			#else
				float staticSwitch692_g1954 = ( _Metallic * pow( saferPower803_g1954 , 3.0 ) );
			#endif
			float Metallic699_g1954 = staticSwitch692_g1954;
			o.Metallic = Metallic699_g1954;
			float2 uv_EmissionMap164_g1954 = i.uv_texcoord;
			float saferPower804_g1954 = abs( tex2D( _EmissionMap1, uv_EmissionMap164_g1954 ).a );
			float temp_output_70_0_g1954 = ( _Glossiness * ( 1.0 - pow( saferPower804_g1954 , 3.0 ) ) );
			float3 ase_normalWS = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 temp_output_3_0_g1972 = ddx( ase_normalWS );
			float dotResult5_g1972 = dot( temp_output_3_0_g1972 , temp_output_3_0_g1972 );
			float3 temp_output_4_0_g1972 = ddy( ase_normalWS );
			float dotResult6_g1972 = dot( temp_output_4_0_g1972 , temp_output_4_0_g1972 );
			#ifdef _USEGEOMETRICANTIALIASING_ON
				float staticSwitch824_g1954 = min( temp_output_70_0_g1954 , ( 1.0 - pow( saturate( max( dotResult5_g1972 , dotResult6_g1972 ) ) , 0.333 ) ) );
			#else
				float staticSwitch824_g1954 = temp_output_70_0_g1954;
			#endif
			#ifdef _LIGHTMAP_DEBUG_MODE_ON
				float staticSwitch693_g1954 = 0.0;
			#else
				float staticSwitch693_g1954 = staticSwitch824_g1954;
			#endif
			o.Smoothness = staticSwitch693_g1954;
			float grayscale799_g1954 = Luminance( Lightmap46_g1954 );
			float saferPower606_g1954 = abs( grayscale799_g1954 );
			float clampResult579_g1954 = clamp( pow( saferPower606_g1954 , _OcclusionPower ) , 0.0 , 1.0 );
			#ifdef _LIGHTMAPOCCLUSION_ON
				float staticSwitch573_g1954 = clampResult579_g1954;
			#else
				float staticSwitch573_g1954 = (float)White38_g1954;
			#endif
			#ifdef _LIGHTMAPPING_ON
				float staticSwitch576_g1954 = staticSwitch573_g1954;
			#else
				float staticSwitch576_g1954 = (float)White38_g1954;
			#endif
			o.Occlusion = staticSwitch576_g1954;
			o.Alpha = 1;
			clip( tex2DNode259_g1954.a - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "Meenphie_ShaderGUI"
}
/*ASEBEGIN
Version=19901
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;838;192,-1200;Inherit;False;RNM;1;;1954;b3ba55a08dd6b49c7be16c6f35cf2033;0;0;8;FLOAT3;625;FLOAT3;238;FLOAT3;624;FLOAT;96;FLOAT;97;FLOAT;95;FLOAT;156;FLOAT;427
Node;AmplifyShaderEditor.StandardSurfaceOutputNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;343;512,-1200;Float;False;True;-1;3;Meenphie_ShaderGUI;0;0;Standard;Meenphie/RNM/Cutout;False;False;False;False;True;False;False;True;True;False;False;False;False;False;True;True;False;False;True;True;False;Off;0;False;;0;False;;False;0;False;;0;False;;False;0;Masked;0.5;True;False;0;False;TransparentCutout;;AlphaTest;ForwardOnly;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0.0001;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;343;0;838;625
WireConnection;343;1;838;238
WireConnection;343;2;838;624
WireConnection;343;3;838;96
WireConnection;343;4;838;97
WireConnection;343;5;838;95
WireConnection;343;10;838;427
ASEEND*/
//CHKSM=E5DBF0E4828AFE080F86CD14FFA774BDF8E76B93