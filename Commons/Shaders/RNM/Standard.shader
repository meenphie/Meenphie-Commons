// Made with Amplify Shader Editor v1.9.9.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/RNM/Standard"
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
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IgnoreProjector" = "True" "ForceNoShadowCasting" = "True" "IsEmissive" = "true"  }
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
			float localBicubicPrepare2_g4142 = ( 0.0 );
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float2 Input_UV100_g4142 = uv_BumpMap;
			float2 UV2_g4142 = Input_UV100_g4142;
			float4 TexelSize2_g4142 = _BumpMap_TexelSize;
			float2 UV02_g4142 = float2( 0,0 );
			float2 UV12_g4142 = float2( 0,0 );
			float2 UV22_g4142 = float2( 0,0 );
			float2 UV32_g4142 = float2( 0,0 );
			float W02_g4142 = 0;
			float W12_g4142 = 0;
			{
			{
			 UV2_g4142 = UV2_g4142 * TexelSize2_g4142.zw - 0.5;
			    float2 f = frac( UV2_g4142 );
			    UV2_g4142 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g4142.x - 0.5, UV2_g4142.x + 1.5, UV2_g4142.y - 0.5, UV2_g4142.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g4142.xyxy;
			    UV02_g4142 = off.xz;
			    UV12_g4142 = off.yz;
			    UV22_g4142 = off.xw;
			    UV32_g4142 = off.yw;
			    W02_g4142 = s.x / ( s.x + s.y );
			 W12_g4142 = s.z / ( s.z + s.w );
			}
			}
			float temp_output_239_0_g4142 = _NormalScale;
			float3 lerpResult46_g4142 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV32_g4142 ), temp_output_239_0_g4142 ) , UnpackScaleNormal( tex2D( _BumpMap, UV22_g4142 ), temp_output_239_0_g4142 ) , W02_g4142);
			float3 lerpResult45_g4142 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV12_g4142 ), temp_output_239_0_g4142 ) , UnpackScaleNormal( tex2D( _BumpMap, UV02_g4142 ), temp_output_239_0_g4142 ) , W02_g4142);
			float3 lerpResult44_g4142 = lerp( lerpResult46_g4142 , lerpResult45_g4142 , W12_g4142);
			float3 Output_2D131_g4142 = lerpResult44_g4142;
			o.Normal = Output_2D131_g4142;
			float2 uv_MainTex259_g4141 = i.uv_texcoord;
			float4 tex2DNode259_g4141 = tex2D( _MainTex, uv_MainTex259_g4141 );
			float3 temp_output_5_0_g4141 = ( _Color.rgb * tex2DNode259_g4141.rgb );
			o.Albedo = temp_output_5_0_g4141;
			float3 temp_cast_0 = 0;
			float2 uv_EmissionMap81_g4141 = i.uv_texcoord;
			float3 Emission86_g4141 = ( _EmissionColor + tex2D( _EmissionMap, uv_EmissionMap81_g4141 ).rgb );
			#ifdef _EMISSION_ON
				float3 staticSwitch572_g4141 = Emission86_g4141;
			#else
				float3 staticSwitch572_g4141 = temp_cast_0;
			#endif
			float3 Albedo6_g4141 = temp_output_5_0_g4141;
			int White38_g4141 = 1;
			float3 temp_cast_1 = White38_g4141;
			float localBicubicPrepare2_g4153 = ( 0.0 );
			float2 uv3_Lightmap = i.uv3_texcoord3 * _Lightmap_ST.xy + _Lightmap_ST.zw;
			float2 Input_UV100_g4153 = uv3_Lightmap;
			float2 UV2_g4153 = Input_UV100_g4153;
			float4 TexelSize2_g4153 = _Lightmap_TexelSize;
			float2 UV02_g4153 = float2( 0,0 );
			float2 UV12_g4153 = float2( 0,0 );
			float2 UV22_g4153 = float2( 0,0 );
			float2 UV32_g4153 = float2( 0,0 );
			float W02_g4153 = 0;
			float W12_g4153 = 0;
			{
			{
			 UV2_g4153 = UV2_g4153 * TexelSize2_g4153.zw - 0.5;
			    float2 f = frac( UV2_g4153 );
			    UV2_g4153 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g4153.x - 0.5, UV2_g4153.x + 1.5, UV2_g4153.y - 0.5, UV2_g4153.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g4153.xyxy;
			    UV02_g4153 = off.xz;
			    UV12_g4153 = off.yz;
			    UV22_g4153 = off.xw;
			    UV32_g4153 = off.yw;
			    W02_g4153 = s.x / ( s.x + s.y );
			 W12_g4153 = s.z / ( s.z + s.w );
			}
			}
			float3 lerpResult46_g4153 = lerp( tex2D( _Lightmap, UV32_g4153 ).rgb , tex2D( _Lightmap, UV22_g4153 ).rgb , W02_g4153);
			float3 lerpResult45_g4153 = lerp( tex2D( _Lightmap, UV12_g4153 ).rgb , tex2D( _Lightmap, UV02_g4153 ).rgb , W02_g4153);
			float3 lerpResult44_g4153 = lerp( lerpResult46_g4153 , lerpResult45_g4153 , W12_g4153);
			float3 Output_2D131_g4153 = lerpResult44_g4153;
			#ifdef _USEBICUBICSAMPLER_ON
				float3 staticSwitch768_g4141 = Output_2D131_g4153;
			#else
				float3 staticSwitch768_g4141 = tex2D( _Lightmap, i.uv3_texcoord3 ).rgb;
			#endif
			float3 appendResult139_g4143 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float localBicubicPrepare2_g4144 = ( 0.0 );
			float2 Input_UV100_g4144 = uv_BumpMap;
			float2 UV2_g4144 = Input_UV100_g4144;
			float4 TexelSize2_g4144 = _BumpMap_TexelSize;
			float2 UV02_g4144 = float2( 0,0 );
			float2 UV12_g4144 = float2( 0,0 );
			float2 UV22_g4144 = float2( 0,0 );
			float2 UV32_g4144 = float2( 0,0 );
			float W02_g4144 = 0;
			float W12_g4144 = 0;
			{
			{
			 UV2_g4144 = UV2_g4144 * TexelSize2_g4144.zw - 0.5;
			    float2 f = frac( UV2_g4144 );
			    UV2_g4144 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g4144.x - 0.5, UV2_g4144.x + 1.5, UV2_g4144.y - 0.5, UV2_g4144.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g4144.xyxy;
			    UV02_g4144 = off.xz;
			    UV12_g4144 = off.yz;
			    UV22_g4144 = off.xw;
			    UV32_g4144 = off.yw;
			    W02_g4144 = s.x / ( s.x + s.y );
			 W12_g4144 = s.z / ( s.z + s.w );
			}
			}
			float Normal_Map_Scale700_g4141 = _NormalScale;
			float temp_output_239_0_g4144 = Normal_Map_Scale700_g4141;
			float3 lerpResult46_g4144 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV32_g4144 ), temp_output_239_0_g4144 ) , UnpackScaleNormal( tex2D( _BumpMap, UV22_g4144 ), temp_output_239_0_g4144 ) , W02_g4144);
			float3 lerpResult45_g4144 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV12_g4144 ), temp_output_239_0_g4144 ) , UnpackScaleNormal( tex2D( _BumpMap, UV02_g4144 ), temp_output_239_0_g4144 ) , W02_g4144);
			float3 lerpResult44_g4144 = lerp( lerpResult46_g4144 , lerpResult45_g4144 , W12_g4144);
			float3 Output_2D131_g4144 = lerpResult44_g4144;
			float3 normalizeResult326_g4143 = normalize( Output_2D131_g4144 );
			float3 Normal_Map318_g4143 = normalizeResult326_g4143;
			float dotResult121_g4143 = dot( appendResult139_g4143 , Normal_Map318_g4143 );
			float localStochasticTiling2_g4155 = ( 0.0 );
			float2 uv3_RNMX0 = i.uv3_texcoord3 * _RNMX0_ST.xy + _RNMX0_ST.zw;
			float2 UV2_g4155 = uv3_RNMX0;
			float4 TexelSize2_g4155 = _RNMX0_TexelSize;
			float4 Offsets2_g4155 = float4( 0,0,0,0 );
			float2 Weights2_g4155 = float2( 0,0 );
			{
			UV2_g4155 = UV2_g4155 * TexelSize2_g4155.zw - 0.5;
			float2 f = frac( UV2_g4155 );
			UV2_g4155 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g4155.x - 0.5, UV2_g4155.x + 1.5, UV2_g4155.y - 0.5, UV2_g4155.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g4155 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g4155.xyxy;
			Weights2_g4155 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g4154 = Offsets2_g4155;
			float4 Input_FetchOffsets197_g4158 = temp_output_1_34_g4154;
			float2 temp_output_1_54_g4154 = Weights2_g4155;
			float2 Input_FetchWeights200_g4158 = temp_output_1_54_g4154;
			float2 break187_g4158 = Input_FetchWeights200_g4158;
			float3 lerpResult181_g4158 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g4158).yw ).rgb , tex2D( _RNMX0, (Input_FetchOffsets197_g4158).xw ).rgb , break187_g4158.x);
			float3 lerpResult182_g4158 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g4158).yz ).rgb , tex2D( _RNMX0, (Input_FetchOffsets197_g4158).xz ).rgb , break187_g4158.x);
			float3 lerpResult176_g4158 = lerp( lerpResult181_g4158 , lerpResult182_g4158 , break187_g4158.y);
			float3 Output_Fetch2D202_g4158 = lerpResult176_g4158;
			#ifdef _USEBICUBICSAMPLER_ON
				float3 staticSwitch705_g4141 = Output_Fetch2D202_g4158;
			#else
				float3 staticSwitch705_g4141 = tex2D( _RNMX0, i.uv3_texcoord3 ).rgb;
			#endif
			float3 appendResult146_g4143 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g4143 = dot( appendResult146_g4143 , Normal_Map318_g4143 );
			float4 Input_FetchOffsets197_g4156 = temp_output_1_34_g4154;
			float2 Input_FetchWeights200_g4156 = temp_output_1_54_g4154;
			float2 break187_g4156 = Input_FetchWeights200_g4156;
			float3 lerpResult181_g4156 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g4156).yw ).rgb , tex2D( _RNMY0, (Input_FetchOffsets197_g4156).xw ).rgb , break187_g4156.x);
			float3 lerpResult182_g4156 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g4156).yz ).rgb , tex2D( _RNMY0, (Input_FetchOffsets197_g4156).xz ).rgb , break187_g4156.x);
			float3 lerpResult176_g4156 = lerp( lerpResult181_g4156 , lerpResult182_g4156 , break187_g4156.y);
			float3 Output_Fetch2D202_g4156 = lerpResult176_g4156;
			#ifdef _USEBICUBICSAMPLER_ON
				float3 staticSwitch715_g4141 = Output_Fetch2D202_g4156;
			#else
				float3 staticSwitch715_g4141 = tex2D( _RNMY0, i.uv3_texcoord3 ).rgb;
			#endif
			float3 appendResult149_g4143 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g4143 = dot( appendResult149_g4143 , Normal_Map318_g4143 );
			float4 Input_FetchOffsets197_g4157 = temp_output_1_34_g4154;
			float2 Input_FetchWeights200_g4157 = temp_output_1_54_g4154;
			float2 break187_g4157 = Input_FetchWeights200_g4157;
			float3 lerpResult181_g4157 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g4157).yw ).rgb , tex2D( _RNMZ0, (Input_FetchOffsets197_g4157).xw ).rgb , break187_g4157.x);
			float3 lerpResult182_g4157 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g4157).yz ).rgb , tex2D( _RNMZ0, (Input_FetchOffsets197_g4157).xz ).rgb , break187_g4157.x);
			float3 lerpResult176_g4157 = lerp( lerpResult181_g4157 , lerpResult182_g4157 , break187_g4157.y);
			float3 Output_Fetch2D202_g4157 = lerpResult176_g4157;
			#ifdef _USEBICUBICSAMPLER_ON
				float3 staticSwitch716_g4141 = Output_Fetch2D202_g4157;
			#else
				float3 staticSwitch716_g4141 = tex2D( _RNMZ0, i.uv3_texcoord3 ).rgb;
			#endif
			float3 temp_output_714_0_g4141 = ( ( ( saturate( dotResult121_g4143 ) * ( staticSwitch705_g4141 * 1.0 ) ) + ( saturate( dotResult122_g4143 ) * ( staticSwitch715_g4141 * 1.0 ) ) ) + ( saturate( dotResult120_g4143 ) * ( staticSwitch716_g4141 * 1.0 ) ) );
			float3 appendResult139_g4145 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float localBicubicPrepare2_g4146 = ( 0.0 );
			float2 Input_UV100_g4146 = uv_BumpMap;
			float2 UV2_g4146 = Input_UV100_g4146;
			float4 TexelSize2_g4146 = _BumpMap_TexelSize;
			float2 UV02_g4146 = float2( 0,0 );
			float2 UV12_g4146 = float2( 0,0 );
			float2 UV22_g4146 = float2( 0,0 );
			float2 UV32_g4146 = float2( 0,0 );
			float W02_g4146 = 0;
			float W12_g4146 = 0;
			{
			{
			 UV2_g4146 = UV2_g4146 * TexelSize2_g4146.zw - 0.5;
			    float2 f = frac( UV2_g4146 );
			    UV2_g4146 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g4146.x - 0.5, UV2_g4146.x + 1.5, UV2_g4146.y - 0.5, UV2_g4146.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g4146.xyxy;
			    UV02_g4146 = off.xz;
			    UV12_g4146 = off.yz;
			    UV22_g4146 = off.xw;
			    UV32_g4146 = off.yw;
			    W02_g4146 = s.x / ( s.x + s.y );
			 W12_g4146 = s.z / ( s.z + s.w );
			}
			}
			float temp_output_239_0_g4146 = Normal_Map_Scale700_g4141;
			float3 lerpResult46_g4146 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV32_g4146 ), temp_output_239_0_g4146 ) , UnpackScaleNormal( tex2D( _BumpMap, UV22_g4146 ), temp_output_239_0_g4146 ) , W02_g4146);
			float3 lerpResult45_g4146 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV12_g4146 ), temp_output_239_0_g4146 ) , UnpackScaleNormal( tex2D( _BumpMap, UV02_g4146 ), temp_output_239_0_g4146 ) , W02_g4146);
			float3 lerpResult44_g4146 = lerp( lerpResult46_g4146 , lerpResult45_g4146 , W12_g4146);
			float3 Output_2D131_g4146 = lerpResult44_g4146;
			float3 normalizeResult326_g4145 = normalize( Output_2D131_g4146 );
			float3 Normal_Map318_g4145 = normalizeResult326_g4145;
			float dotResult121_g4145 = dot( appendResult139_g4145 , Normal_Map318_g4145 );
			float localStochasticTiling2_g4148 = ( 0.0 );
			float2 uv3_RNMX1 = i.uv3_texcoord3 * _RNMX1_ST.xy + _RNMX1_ST.zw;
			float2 UV2_g4148 = uv3_RNMX1;
			float4 TexelSize2_g4148 = _RNMX1_TexelSize;
			float4 Offsets2_g4148 = float4( 0,0,0,0 );
			float2 Weights2_g4148 = float2( 0,0 );
			{
			UV2_g4148 = UV2_g4148 * TexelSize2_g4148.zw - 0.5;
			float2 f = frac( UV2_g4148 );
			UV2_g4148 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g4148.x - 0.5, UV2_g4148.x + 1.5, UV2_g4148.y - 0.5, UV2_g4148.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g4148 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g4148.xyxy;
			Weights2_g4148 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g4147 = Offsets2_g4148;
			float4 Input_FetchOffsets197_g4151 = temp_output_1_34_g4147;
			float2 temp_output_1_54_g4147 = Weights2_g4148;
			float2 Input_FetchWeights200_g4151 = temp_output_1_54_g4147;
			float2 break187_g4151 = Input_FetchWeights200_g4151;
			float3 lerpResult181_g4151 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g4151).yw ).rgb , tex2D( _RNMX1, (Input_FetchOffsets197_g4151).xw ).rgb , break187_g4151.x);
			float3 lerpResult182_g4151 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g4151).yz ).rgb , tex2D( _RNMX1, (Input_FetchOffsets197_g4151).xz ).rgb , break187_g4151.x);
			float3 lerpResult176_g4151 = lerp( lerpResult181_g4151 , lerpResult182_g4151 , break187_g4151.y);
			float3 Output_Fetch2D202_g4151 = lerpResult176_g4151;
			#ifdef _USEBICUBICSAMPLER_ON
				float3 staticSwitch764_g4141 = Output_Fetch2D202_g4151;
			#else
				float3 staticSwitch764_g4141 = tex2D( _RNMX1, i.uv3_texcoord3 ).rgb;
			#endif
			float3 appendResult146_g4145 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g4145 = dot( appendResult146_g4145 , Normal_Map318_g4145 );
			float4 Input_FetchOffsets197_g4149 = temp_output_1_34_g4147;
			float2 Input_FetchWeights200_g4149 = temp_output_1_54_g4147;
			float2 break187_g4149 = Input_FetchWeights200_g4149;
			float3 lerpResult181_g4149 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g4149).yw ).rgb , tex2D( _RNMY1, (Input_FetchOffsets197_g4149).xw ).rgb , break187_g4149.x);
			float3 lerpResult182_g4149 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g4149).yz ).rgb , tex2D( _RNMY1, (Input_FetchOffsets197_g4149).xz ).rgb , break187_g4149.x);
			float3 lerpResult176_g4149 = lerp( lerpResult181_g4149 , lerpResult182_g4149 , break187_g4149.y);
			float3 Output_Fetch2D202_g4149 = lerpResult176_g4149;
			#ifdef _USEBICUBICSAMPLER_ON
				float3 staticSwitch753_g4141 = Output_Fetch2D202_g4149;
			#else
				float3 staticSwitch753_g4141 = tex2D( _RNMY1, i.uv3_texcoord3 ).rgb;
			#endif
			float3 appendResult149_g4145 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g4145 = dot( appendResult149_g4145 , Normal_Map318_g4145 );
			float4 Input_FetchOffsets197_g4150 = temp_output_1_34_g4147;
			float2 Input_FetchWeights200_g4150 = temp_output_1_54_g4147;
			float2 break187_g4150 = Input_FetchWeights200_g4150;
			float3 lerpResult181_g4150 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g4150).yw ).rgb , tex2D( _RNMZ1, (Input_FetchOffsets197_g4150).xw ).rgb , break187_g4150.x);
			float3 lerpResult182_g4150 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g4150).yz ).rgb , tex2D( _RNMZ1, (Input_FetchOffsets197_g4150).xz ).rgb , break187_g4150.x);
			float3 lerpResult176_g4150 = lerp( lerpResult181_g4150 , lerpResult182_g4150 , break187_g4150.y);
			float3 Output_Fetch2D202_g4150 = lerpResult176_g4150;
			#ifdef _USEBICUBICSAMPLER_ON
				float3 staticSwitch750_g4141 = Output_Fetch2D202_g4150;
			#else
				float3 staticSwitch750_g4141 = tex2D( _RNMZ1, i.uv3_texcoord3 ).rgb;
			#endif
			float3 lerpResult442_g4141 = lerp( temp_output_714_0_g4141 , ( ( ( saturate( dotResult121_g4145 ) * ( staticSwitch764_g4141 * 1.0 ) ) + ( saturate( dotResult122_g4145 ) * ( staticSwitch753_g4141 * 1.0 ) ) ) + ( saturate( dotResult120_g4145 ) * ( staticSwitch750_g4141 * 1.0 ) ) ) , _LightmapLerp);
			#if defined( _LIGHTMAPPINGMODE_SIMPLE )
				float3 staticSwitch565_g4141 = staticSwitch768_g4141;
			#elif defined( _LIGHTMAPPINGMODE_RNM )
				float3 staticSwitch565_g4141 = temp_output_714_0_g4141;
			#elif defined( _LIGHTMAPPINGMODE_RNMLERP )
				float3 staticSwitch565_g4141 = lerpResult442_g4141;
			#else
				float3 staticSwitch565_g4141 = staticSwitch768_g4141;
			#endif
			#ifdef _LIGHTMAPPING_ON
				float3 staticSwitch569_g4141 = staticSwitch565_g4141;
			#else
				float3 staticSwitch569_g4141 = temp_cast_1;
			#endif
			float3 Lightmap46_g4141 = staticSwitch569_g4141;
			#ifdef _LIGHTMAPPING_ON
				float3 staticSwitch566_g4141 = ( Albedo6_g4141 * Lightmap46_g4141 );
			#else
				float3 staticSwitch566_g4141 = Albedo6_g4141;
			#endif
			#ifdef _LIGHTMAPPING_ON
				float3 staticSwitch696_g4141 = ( staticSwitch572_g4141 + staticSwitch566_g4141 );
			#else
				float3 staticSwitch696_g4141 = ( staticSwitch572_g4141 * staticSwitch566_g4141 );
			#endif
			#ifdef _LIGHTMAP_DEBUG_MODE_ON
				float3 staticSwitch686_g4141 = Lightmap46_g4141;
			#else
				float3 staticSwitch686_g4141 = staticSwitch696_g4141;
			#endif
			o.Emission = staticSwitch686_g4141;
			float2 uv_MetallicMap = i.uv_texcoord * _MetallicMap_ST.xy + _MetallicMap_ST.zw;
			float saferPower803_g4141 = abs( tex2D( _MetallicMap, uv_MetallicMap ).a );
			#ifdef _LIGHTMAP_DEBUG_MODE_ON
				float staticSwitch692_g4141 = 0.0;
			#else
				float staticSwitch692_g4141 = ( _Metallic * pow( saferPower803_g4141 , 3.0 ) );
			#endif
			float Metallic699_g4141 = staticSwitch692_g4141;
			o.Metallic = Metallic699_g4141;
			float2 uv_EmissionMap164_g4141 = i.uv_texcoord;
			float saferPower804_g4141 = abs( tex2D( _EmissionMap1, uv_EmissionMap164_g4141 ).a );
			#ifdef _LIGHTMAP_DEBUG_MODE_ON
				float staticSwitch693_g4141 = 0.0;
			#else
				float staticSwitch693_g4141 = ( _Glossiness * ( 1.0 - pow( saferPower804_g4141 , 3.0 ) ) );
			#endif
			o.Smoothness = staticSwitch693_g4141;
			float grayscale799_g4141 = Luminance( Lightmap46_g4141 );
			float saferPower606_g4141 = abs( grayscale799_g4141 );
			float clampResult579_g4141 = clamp( pow( saferPower606_g4141 , _OcclusionPower ) , 0.0 , 1.0 );
			#ifdef _LIGHTMAPOCCLUSION_ON
				float staticSwitch573_g4141 = clampResult579_g4141;
			#else
				float staticSwitch573_g4141 = (float)White38_g4141;
			#endif
			#ifdef _LIGHTMAPPING_ON
				float staticSwitch576_g4141 = staticSwitch573_g4141;
			#else
				float staticSwitch576_g4141 = (float)White38_g4141;
			#endif
			o.Occlusion = staticSwitch576_g4141;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "Meenphie_ShaderGUI"
}
/*ASEBEGIN
Version=19901
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2742;192,-1200;Inherit;False;RNM;0;;4141;b3ba55a08dd6b49c7be16c6f35cf2033;0;0;8;FLOAT3;625;FLOAT3;238;FLOAT3;624;FLOAT;96;FLOAT;97;FLOAT;95;FLOAT;156;FLOAT;427
Node;AmplifyShaderEditor.StandardSurfaceOutputNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1092;512,-1200;Float;False;True;-1;3;Meenphie_ShaderGUI;0;0;Standard;Meenphie/RNM/Standard;False;False;False;False;True;False;False;True;True;False;False;False;False;False;True;True;False;False;True;True;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;ForwardOnly;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0.0001;0,0,0,0;VertexOffset;False;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;1092;0;2742;625
WireConnection;1092;1;2742;238
WireConnection;1092;2;2742;624
WireConnection;1092;3;2742;96
WireConnection;1092;4;2742;97
WireConnection;1092;5;2742;95
ASEEND*/
//CHKSM=CE54900863488493B4F1AC8D17A6FB2D3507E695