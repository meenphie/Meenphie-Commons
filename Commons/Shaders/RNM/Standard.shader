// Made with Amplify Shader Editor v1.9.9.3
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/RNM/Standard"
{
	Properties
	{
		[Meenphie_DrawerCategory(SURFACE OPTIONS,true,0,0)] _CATEGORY_SURFACEOPTIONS( "CATEGORY_SURFACEOPTIONS", Float ) = 1
		_Color( "DIffuse Color", Color ) = ( 0.9058824, 0.9058824, 0.9058824, 1 )
		[NoScaleOffset][Meenphie_DrawerTextureSingleLine] _MainTex( "Diffuse Map", 2D ) = "white" {}
		[NoScaleOffset][Meenphie_DrawerTextureSingleLine] _NormalMap( "Normal Map", 2D ) = "bump" {}
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
		[HideInInspector] _texcoord3( "", 2D ) = "white" {}
		[HideInInspector] GenKey__NormalMap( "Assign keyword _NORMALMAP", Float ) = 1.0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
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
		#pragma shader_feature_local_fragment _NORMALMAP
		#pragma shader_feature_local _LIGHTMAPPING_ON
		#pragma shader_feature_local _EMISSION_ON
		#pragma shader_feature_local _LIGHTMAPPINGMODE_SIMPLE _LIGHTMAPPINGMODE_RNM _LIGHTMAPPINGMODE_RNMLERP
		#pragma shader_feature_local _USEBICUBICSAMPLER_ON
		#pragma shader_feature_local _USEGEOMETRICANTIALIASING_ON
		#pragma shader_feature_local _LIGHTMAPOCCLUSION_ON
		#define ASE_VERSION 19903
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
		uniform sampler2D _NormalMap;
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
			float2 uv_NormalMap830_g503 = i.uv_texcoord;
			#ifdef _NORMALMAP
				float3 staticSwitch844_g503 = UnpackScaleNormal( tex2D( _NormalMap, uv_NormalMap830_g503 ), _NormalScale );
			#else
				float3 staticSwitch844_g503 = float3( 0, 0, 1 );
			#endif
			float3 Normal_Map700_g503 = staticSwitch844_g503;
			o.Normal = Normal_Map700_g503;
			float2 uv_MainTex259_g503 = i.uv_texcoord;
			float4 tex2DNode259_g503 = tex2D( _MainTex, uv_MainTex259_g503 );
			float3 temp_output_5_0_g503 = ( _Color.rgb * tex2DNode259_g503.rgb );
			o.Albedo = temp_output_5_0_g503;
			float3 temp_cast_0 = 0;
			float2 uv_EmissionMap81_g503 = i.uv_texcoord;
			float3 Emission86_g503 = ( _EmissionColor + tex2D( _EmissionMap, uv_EmissionMap81_g503 ).rgb );
			#ifdef _EMISSION_ON
				float3 staticSwitch572_g503 = Emission86_g503;
			#else
				float3 staticSwitch572_g503 = temp_cast_0;
			#endif
			float3 Albedo6_g503 = temp_output_5_0_g503;
			int White38_g503 = 1;
			float3 temp_cast_1 = White38_g503;
			float localBicubicPrepare2_g518 = ( 0.0 );
			float2 uv3_Lightmap = i.uv3_texcoord3 * _Lightmap_ST.xy + _Lightmap_ST.zw;
			float2 Input_UV100_g518 = uv3_Lightmap;
			float2 UV2_g518 = Input_UV100_g518;
			float4 TexelSize2_g518 = _Lightmap_TexelSize;
			float2 UV02_g518 = float2( 0,0 );
			float2 UV12_g518 = float2( 0,0 );
			float2 UV22_g518 = float2( 0,0 );
			float2 UV32_g518 = float2( 0,0 );
			float W02_g518 = 0;
			float W12_g518 = 0;
			{
			{
			 UV2_g518 = UV2_g518 * TexelSize2_g518.zw - 0.5;
			    float2 f = frac( UV2_g518 );
			    UV2_g518 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g518.x - 0.5, UV2_g518.x + 1.5, UV2_g518.y - 0.5, UV2_g518.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g518.xyxy;
			    UV02_g518 = off.xz;
			    UV12_g518 = off.yz;
			    UV22_g518 = off.xw;
			    UV32_g518 = off.yw;
			    W02_g518 = s.x / ( s.x + s.y );
			 W12_g518 = s.z / ( s.z + s.w );
			}
			}
			float3 lerpResult46_g518 = lerp( tex2D( _Lightmap, UV32_g518 ).rgb , tex2D( _Lightmap, UV22_g518 ).rgb , W02_g518);
			float3 lerpResult45_g518 = lerp( tex2D( _Lightmap, UV12_g518 ).rgb , tex2D( _Lightmap, UV02_g518 ).rgb , W02_g518);
			float3 lerpResult44_g518 = lerp( lerpResult46_g518 , lerpResult45_g518 , W12_g518);
			float3 Output_2D131_g518 = lerpResult44_g518;
			#ifdef _USEBICUBICSAMPLER_ON
				float3 staticSwitch768_g503 = Output_2D131_g518;
			#else
				float3 staticSwitch768_g503 = tex2D( _Lightmap, i.uv3_texcoord3 ).rgb;
			#endif
			float3 appendResult139_g506 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float3 normalizeResult326_g506 = normalize( Normal_Map700_g503 );
			float3 Normal_Map318_g506 = normalizeResult326_g506;
			float dotResult121_g506 = dot( appendResult139_g506 , Normal_Map318_g506 );
			float localStochasticTiling2_g513 = ( 0.0 );
			float2 uv3_RNMX0 = i.uv3_texcoord3 * _RNMX0_ST.xy + _RNMX0_ST.zw;
			float2 UV2_g513 = uv3_RNMX0;
			float4 TexelSize2_g513 = _RNMX0_TexelSize;
			float4 Offsets2_g513 = float4( 0,0,0,0 );
			float2 Weights2_g513 = float2( 0,0 );
			{
			UV2_g513 = UV2_g513 * TexelSize2_g513.zw - 0.5;
			float2 f = frac( UV2_g513 );
			UV2_g513 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g513.x - 0.5, UV2_g513.x + 1.5, UV2_g513.y - 0.5, UV2_g513.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g513 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g513.xyxy;
			Weights2_g513 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g512 = Offsets2_g513;
			float4 Input_FetchOffsets197_g516 = temp_output_1_34_g512;
			float2 temp_output_1_54_g512 = Weights2_g513;
			float2 Input_FetchWeights200_g516 = temp_output_1_54_g512;
			float2 break187_g516 = Input_FetchWeights200_g516;
			float3 lerpResult181_g516 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g516).yw ).rgb , tex2D( _RNMX0, (Input_FetchOffsets197_g516).xw ).rgb , break187_g516.x);
			float3 lerpResult182_g516 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g516).yz ).rgb , tex2D( _RNMX0, (Input_FetchOffsets197_g516).xz ).rgb , break187_g516.x);
			float3 lerpResult176_g516 = lerp( lerpResult181_g516 , lerpResult182_g516 , break187_g516.y);
			float3 Output_Fetch2D202_g516 = lerpResult176_g516;
			#ifdef _USEBICUBICSAMPLER_ON
				float3 staticSwitch705_g503 = Output_Fetch2D202_g516;
			#else
				float3 staticSwitch705_g503 = tex2D( _RNMX0, i.uv3_texcoord3 ).rgb;
			#endif
			float3 appendResult146_g506 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g506 = dot( appendResult146_g506 , Normal_Map318_g506 );
			float4 Input_FetchOffsets197_g514 = temp_output_1_34_g512;
			float2 Input_FetchWeights200_g514 = temp_output_1_54_g512;
			float2 break187_g514 = Input_FetchWeights200_g514;
			float3 lerpResult181_g514 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g514).yw ).rgb , tex2D( _RNMY0, (Input_FetchOffsets197_g514).xw ).rgb , break187_g514.x);
			float3 lerpResult182_g514 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g514).yz ).rgb , tex2D( _RNMY0, (Input_FetchOffsets197_g514).xz ).rgb , break187_g514.x);
			float3 lerpResult176_g514 = lerp( lerpResult181_g514 , lerpResult182_g514 , break187_g514.y);
			float3 Output_Fetch2D202_g514 = lerpResult176_g514;
			#ifdef _USEBICUBICSAMPLER_ON
				float3 staticSwitch715_g503 = Output_Fetch2D202_g514;
			#else
				float3 staticSwitch715_g503 = tex2D( _RNMY0, i.uv3_texcoord3 ).rgb;
			#endif
			float3 appendResult149_g506 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g506 = dot( appendResult149_g506 , Normal_Map318_g506 );
			float4 Input_FetchOffsets197_g515 = temp_output_1_34_g512;
			float2 Input_FetchWeights200_g515 = temp_output_1_54_g512;
			float2 break187_g515 = Input_FetchWeights200_g515;
			float3 lerpResult181_g515 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g515).yw ).rgb , tex2D( _RNMZ0, (Input_FetchOffsets197_g515).xw ).rgb , break187_g515.x);
			float3 lerpResult182_g515 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g515).yz ).rgb , tex2D( _RNMZ0, (Input_FetchOffsets197_g515).xz ).rgb , break187_g515.x);
			float3 lerpResult176_g515 = lerp( lerpResult181_g515 , lerpResult182_g515 , break187_g515.y);
			float3 Output_Fetch2D202_g515 = lerpResult176_g515;
			#ifdef _USEBICUBICSAMPLER_ON
				float3 staticSwitch716_g503 = Output_Fetch2D202_g515;
			#else
				float3 staticSwitch716_g503 = tex2D( _RNMZ0, i.uv3_texcoord3 ).rgb;
			#endif
			float3 temp_output_838_0_g503 = ( ( ( saturate( dotResult121_g506 ) * ( staticSwitch705_g503 * 1.0 ) ) + ( saturate( dotResult122_g506 ) * ( staticSwitch715_g503 * 1.0 ) ) ) + ( saturate( dotResult120_g506 ) * ( staticSwitch716_g503 * 1.0 ) ) );
			float3 appendResult139_g505 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float3 normalizeResult326_g505 = normalize( Normal_Map700_g503 );
			float3 Normal_Map318_g505 = normalizeResult326_g505;
			float dotResult121_g505 = dot( appendResult139_g505 , Normal_Map318_g505 );
			float localStochasticTiling2_g508 = ( 0.0 );
			float2 uv3_RNMX1 = i.uv3_texcoord3 * _RNMX1_ST.xy + _RNMX1_ST.zw;
			float2 UV2_g508 = uv3_RNMX1;
			float4 TexelSize2_g508 = _RNMX1_TexelSize;
			float4 Offsets2_g508 = float4( 0,0,0,0 );
			float2 Weights2_g508 = float2( 0,0 );
			{
			UV2_g508 = UV2_g508 * TexelSize2_g508.zw - 0.5;
			float2 f = frac( UV2_g508 );
			UV2_g508 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g508.x - 0.5, UV2_g508.x + 1.5, UV2_g508.y - 0.5, UV2_g508.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g508 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g508.xyxy;
			Weights2_g508 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g507 = Offsets2_g508;
			float4 Input_FetchOffsets197_g511 = temp_output_1_34_g507;
			float2 temp_output_1_54_g507 = Weights2_g508;
			float2 Input_FetchWeights200_g511 = temp_output_1_54_g507;
			float2 break187_g511 = Input_FetchWeights200_g511;
			float3 lerpResult181_g511 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g511).yw ).rgb , tex2D( _RNMX1, (Input_FetchOffsets197_g511).xw ).rgb , break187_g511.x);
			float3 lerpResult182_g511 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g511).yz ).rgb , tex2D( _RNMX1, (Input_FetchOffsets197_g511).xz ).rgb , break187_g511.x);
			float3 lerpResult176_g511 = lerp( lerpResult181_g511 , lerpResult182_g511 , break187_g511.y);
			float3 Output_Fetch2D202_g511 = lerpResult176_g511;
			#ifdef _USEBICUBICSAMPLER_ON
				float3 staticSwitch764_g503 = Output_Fetch2D202_g511;
			#else
				float3 staticSwitch764_g503 = tex2D( _RNMX1, i.uv3_texcoord3 ).rgb;
			#endif
			float3 appendResult146_g505 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g505 = dot( appendResult146_g505 , Normal_Map318_g505 );
			float4 Input_FetchOffsets197_g509 = temp_output_1_34_g507;
			float2 Input_FetchWeights200_g509 = temp_output_1_54_g507;
			float2 break187_g509 = Input_FetchWeights200_g509;
			float3 lerpResult181_g509 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g509).yw ).rgb , tex2D( _RNMY1, (Input_FetchOffsets197_g509).xw ).rgb , break187_g509.x);
			float3 lerpResult182_g509 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g509).yz ).rgb , tex2D( _RNMY1, (Input_FetchOffsets197_g509).xz ).rgb , break187_g509.x);
			float3 lerpResult176_g509 = lerp( lerpResult181_g509 , lerpResult182_g509 , break187_g509.y);
			float3 Output_Fetch2D202_g509 = lerpResult176_g509;
			#ifdef _USEBICUBICSAMPLER_ON
				float3 staticSwitch753_g503 = Output_Fetch2D202_g509;
			#else
				float3 staticSwitch753_g503 = tex2D( _RNMY1, i.uv3_texcoord3 ).rgb;
			#endif
			float3 appendResult149_g505 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g505 = dot( appendResult149_g505 , Normal_Map318_g505 );
			float4 Input_FetchOffsets197_g510 = temp_output_1_34_g507;
			float2 Input_FetchWeights200_g510 = temp_output_1_54_g507;
			float2 break187_g510 = Input_FetchWeights200_g510;
			float3 lerpResult181_g510 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g510).yw ).rgb , tex2D( _RNMZ1, (Input_FetchOffsets197_g510).xw ).rgb , break187_g510.x);
			float3 lerpResult182_g510 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g510).yz ).rgb , tex2D( _RNMZ1, (Input_FetchOffsets197_g510).xz ).rgb , break187_g510.x);
			float3 lerpResult176_g510 = lerp( lerpResult181_g510 , lerpResult182_g510 , break187_g510.y);
			float3 Output_Fetch2D202_g510 = lerpResult176_g510;
			#ifdef _USEBICUBICSAMPLER_ON
				float3 staticSwitch750_g503 = Output_Fetch2D202_g510;
			#else
				float3 staticSwitch750_g503 = tex2D( _RNMZ1, i.uv3_texcoord3 ).rgb;
			#endif
			float3 lerpResult442_g503 = lerp( temp_output_838_0_g503 , ( ( ( saturate( dotResult121_g505 ) * ( staticSwitch764_g503 * 1.0 ) ) + ( saturate( dotResult122_g505 ) * ( staticSwitch753_g503 * 1.0 ) ) ) + ( saturate( dotResult120_g505 ) * ( staticSwitch750_g503 * 1.0 ) ) ) , _LightmapLerp);
			#if defined( _LIGHTMAPPINGMODE_SIMPLE )
				float3 staticSwitch565_g503 = staticSwitch768_g503;
			#elif defined( _LIGHTMAPPINGMODE_RNM )
				float3 staticSwitch565_g503 = temp_output_838_0_g503;
			#elif defined( _LIGHTMAPPINGMODE_RNMLERP )
				float3 staticSwitch565_g503 = lerpResult442_g503;
			#else
				float3 staticSwitch565_g503 = staticSwitch768_g503;
			#endif
			#ifdef _LIGHTMAPPING_ON
				float3 staticSwitch569_g503 = staticSwitch565_g503;
			#else
				float3 staticSwitch569_g503 = temp_cast_1;
			#endif
			float3 Lightmap46_g503 = staticSwitch569_g503;
			#ifdef _LIGHTMAPPING_ON
				float3 staticSwitch566_g503 = ( Albedo6_g503 * Lightmap46_g503 );
			#else
				float3 staticSwitch566_g503 = Albedo6_g503;
			#endif
			#ifdef _LIGHTMAPPING_ON
				float3 staticSwitch696_g503 = ( staticSwitch572_g503 + staticSwitch566_g503 );
			#else
				float3 staticSwitch696_g503 = ( staticSwitch572_g503 * staticSwitch566_g503 );
			#endif
			o.Emission = staticSwitch696_g503;
			float2 uv_MetallicMap = i.uv_texcoord * _MetallicMap_ST.xy + _MetallicMap_ST.zw;
			float saferPower803_g503 = abs( tex2D( _MetallicMap, uv_MetallicMap ).a );
			float Metallic699_g503 = ( _Metallic * pow( saferPower803_g503 , 3.0 ) );
			o.Metallic = Metallic699_g503;
			float2 uv_EmissionMap164_g503 = i.uv_texcoord;
			float saferPower804_g503 = abs( tex2D( _EmissionMap1, uv_EmissionMap164_g503 ).a );
			float temp_output_70_0_g503 = ( _Glossiness * ( 1.0 - pow( saferPower804_g503 , 3.0 ) ) );
			float3 ase_normalWS = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 temp_output_3_0_g504 = ddx( ase_normalWS );
			float dotResult5_g504 = dot( temp_output_3_0_g504 , temp_output_3_0_g504 );
			float3 temp_output_4_0_g504 = ddy( ase_normalWS );
			float dotResult6_g504 = dot( temp_output_4_0_g504 , temp_output_4_0_g504 );
			#ifdef _USEGEOMETRICANTIALIASING_ON
				float staticSwitch824_g503 = min( temp_output_70_0_g503 , ( 1.0 - pow( saturate( max( dotResult5_g504 , dotResult6_g504 ) ) , 0.333 ) ) );
			#else
				float staticSwitch824_g503 = temp_output_70_0_g503;
			#endif
			o.Smoothness = staticSwitch824_g503;
			float dotResult835_g503 = dot( Lightmap46_g503 , float3( 0.299, 0.587, 0.114 ) );
			float saferPower606_g503 = abs( dotResult835_g503 );
			#ifdef _LIGHTMAPOCCLUSION_ON
				float staticSwitch573_g503 = pow( saferPower606_g503 , _OcclusionPower );
			#else
				float staticSwitch573_g503 = (float)White38_g503;
			#endif
			#ifdef _LIGHTMAPPING_ON
				float staticSwitch576_g503 = staticSwitch573_g503;
			#else
				float staticSwitch576_g503 = (float)White38_g503;
			#endif
			o.Occlusion = staticSwitch576_g503;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=19903
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2765;192,-1200;Inherit;False;RNM;0;;503;b3ba55a08dd6b49c7be16c6f35cf2033;3,831,0,833,0,834,0;0;8;FLOAT3;625;FLOAT3;238;FLOAT3;624;FLOAT;96;FLOAT;97;FLOAT;95;FLOAT;156;FLOAT;427
Node;AmplifyShaderEditor.StandardSurfaceOutputNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1092;512,-1200;Float;False;True;-1;3;;0;0;Standard;Meenphie/RNM/Standard;False;False;False;False;True;False;False;True;True;False;False;False;False;False;True;True;False;False;True;True;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;ForwardOnly;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0.0001;0,0,0,0;VertexOffset;False;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;1092;0;2765;625
WireConnection;1092;1;2765;238
WireConnection;1092;2;2765;624
WireConnection;1092;3;2765;96
WireConnection;1092;4;2765;97
WireConnection;1092;5;2765;95
ASEEND*/
//CHKSM=7ED8B8575D7712BCD384A0A14E71E8BDF40BFAD5