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
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float localBicubicPrepare2_g1865 = ( 0.0 );
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float2 Input_UV100_g1865 = uv_BumpMap;
			float2 UV2_g1865 = Input_UV100_g1865;
			float4 TexelSize2_g1865 = _BumpMap_TexelSize;
			float2 UV02_g1865 = float2( 0,0 );
			float2 UV12_g1865 = float2( 0,0 );
			float2 UV22_g1865 = float2( 0,0 );
			float2 UV32_g1865 = float2( 0,0 );
			float W02_g1865 = 0;
			float W12_g1865 = 0;
			{
			{
			 UV2_g1865 = UV2_g1865 * TexelSize2_g1865.zw - 0.5;
			    float2 f = frac( UV2_g1865 );
			    UV2_g1865 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g1865.x - 0.5, UV2_g1865.x + 1.5, UV2_g1865.y - 0.5, UV2_g1865.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1865.xyxy;
			    UV02_g1865 = off.xz;
			    UV12_g1865 = off.yz;
			    UV22_g1865 = off.xw;
			    UV32_g1865 = off.yw;
			    W02_g1865 = s.x / ( s.x + s.y );
			 W12_g1865 = s.z / ( s.z + s.w );
			}
			}
			float temp_output_239_0_g1865 = _NormalScale;
			float3 lerpResult46_g1865 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV32_g1865 ), temp_output_239_0_g1865 ) , UnpackScaleNormal( tex2D( _BumpMap, UV22_g1865 ), temp_output_239_0_g1865 ) , W02_g1865);
			float3 lerpResult45_g1865 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV12_g1865 ), temp_output_239_0_g1865 ) , UnpackScaleNormal( tex2D( _BumpMap, UV02_g1865 ), temp_output_239_0_g1865 ) , W02_g1865);
			float3 lerpResult44_g1865 = lerp( lerpResult46_g1865 , lerpResult45_g1865 , W12_g1865);
			float3 Output_2D131_g1865 = lerpResult44_g1865;
			o.Normal = Output_2D131_g1865;
			float2 uv_MainTex259_g1864 = i.uv_texcoord;
			float4 tex2DNode259_g1864 = tex2D( _MainTex, uv_MainTex259_g1864 );
			float3 temp_output_5_0_g1864 = ( _Color.rgb * tex2DNode259_g1864.rgb );
			o.Albedo = temp_output_5_0_g1864;
			float3 temp_cast_0 = 0;
			float2 uv_EmissionMap81_g1864 = i.uv_texcoord;
			float3 Emission86_g1864 = ( _EmissionColor + tex2D( _EmissionMap, uv_EmissionMap81_g1864 ).rgb );
			#ifdef _EMISSION_ON
				float3 staticSwitch572_g1864 = Emission86_g1864;
			#else
				float3 staticSwitch572_g1864 = temp_cast_0;
			#endif
			float3 Albedo6_g1864 = temp_output_5_0_g1864;
			int White38_g1864 = 1;
			float4 temp_cast_4 = White38_g1864;
			float localBicubicPrepare2_g1876 = ( 0.0 );
			float2 uv3_Lightmap = i.uv3_texcoord3 * _Lightmap_ST.xy + _Lightmap_ST.zw;
			float2 Input_UV100_g1876 = uv3_Lightmap;
			float2 UV2_g1876 = Input_UV100_g1876;
			float4 TexelSize2_g1876 = _Lightmap_TexelSize;
			float2 UV02_g1876 = float2( 0,0 );
			float2 UV12_g1876 = float2( 0,0 );
			float2 UV22_g1876 = float2( 0,0 );
			float2 UV32_g1876 = float2( 0,0 );
			float W02_g1876 = 0;
			float W12_g1876 = 0;
			{
			{
			 UV2_g1876 = UV2_g1876 * TexelSize2_g1876.zw - 0.5;
			    float2 f = frac( UV2_g1876 );
			    UV2_g1876 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g1876.x - 0.5, UV2_g1876.x + 1.5, UV2_g1876.y - 0.5, UV2_g1876.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1876.xyxy;
			    UV02_g1876 = off.xz;
			    UV12_g1876 = off.yz;
			    UV22_g1876 = off.xw;
			    UV32_g1876 = off.yw;
			    W02_g1876 = s.x / ( s.x + s.y );
			 W12_g1876 = s.z / ( s.z + s.w );
			}
			}
			float4 lerpResult46_g1876 = lerp( tex2D( _Lightmap, UV32_g1876 ) , tex2D( _Lightmap, UV22_g1876 ) , W02_g1876);
			float4 lerpResult45_g1876 = lerp( tex2D( _Lightmap, UV12_g1876 ) , tex2D( _Lightmap, UV02_g1876 ) , W02_g1876);
			float4 lerpResult44_g1876 = lerp( lerpResult46_g1876 , lerpResult45_g1876 , W12_g1876);
			float4 Output_2D131_g1876 = lerpResult44_g1876;
			#ifdef _USEBICUBICSAMPLER_ON
				float4 staticSwitch768_g1864 = Output_2D131_g1876;
			#else
				float4 staticSwitch768_g1864 = float4( tex2D( _Lightmap, i.uv3_texcoord3 ).rgb , 0.0 );
			#endif
			float3 appendResult139_g1866 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float localBicubicPrepare2_g1867 = ( 0.0 );
			float2 Input_UV100_g1867 = uv_BumpMap;
			float2 UV2_g1867 = Input_UV100_g1867;
			float4 TexelSize2_g1867 = _BumpMap_TexelSize;
			float2 UV02_g1867 = float2( 0,0 );
			float2 UV12_g1867 = float2( 0,0 );
			float2 UV22_g1867 = float2( 0,0 );
			float2 UV32_g1867 = float2( 0,0 );
			float W02_g1867 = 0;
			float W12_g1867 = 0;
			{
			{
			 UV2_g1867 = UV2_g1867 * TexelSize2_g1867.zw - 0.5;
			    float2 f = frac( UV2_g1867 );
			    UV2_g1867 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g1867.x - 0.5, UV2_g1867.x + 1.5, UV2_g1867.y - 0.5, UV2_g1867.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1867.xyxy;
			    UV02_g1867 = off.xz;
			    UV12_g1867 = off.yz;
			    UV22_g1867 = off.xw;
			    UV32_g1867 = off.yw;
			    W02_g1867 = s.x / ( s.x + s.y );
			 W12_g1867 = s.z / ( s.z + s.w );
			}
			}
			float Normal_Map_Scale700_g1864 = _NormalScale;
			float temp_output_239_0_g1867 = Normal_Map_Scale700_g1864;
			float3 lerpResult46_g1867 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV32_g1867 ), temp_output_239_0_g1867 ) , UnpackScaleNormal( tex2D( _BumpMap, UV22_g1867 ), temp_output_239_0_g1867 ) , W02_g1867);
			float3 lerpResult45_g1867 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV12_g1867 ), temp_output_239_0_g1867 ) , UnpackScaleNormal( tex2D( _BumpMap, UV02_g1867 ), temp_output_239_0_g1867 ) , W02_g1867);
			float3 lerpResult44_g1867 = lerp( lerpResult46_g1867 , lerpResult45_g1867 , W12_g1867);
			float3 Output_2D131_g1867 = lerpResult44_g1867;
			float3 normalizeResult326_g1866 = normalize( Output_2D131_g1867 );
			float3 Normal_Map318_g1866 = normalizeResult326_g1866;
			float dotResult121_g1866 = dot( appendResult139_g1866 , Normal_Map318_g1866 );
			float localStochasticTiling2_g1880 = ( 0.0 );
			float2 uv3_RNMX0 = i.uv3_texcoord3 * _RNMX0_ST.xy + _RNMX0_ST.zw;
			float2 UV2_g1880 = uv3_RNMX0;
			float4 TexelSize2_g1880 = _RNMX0_TexelSize;
			float4 Offsets2_g1880 = float4( 0,0,0,0 );
			float2 Weights2_g1880 = float2( 0,0 );
			{
			UV2_g1880 = UV2_g1880 * TexelSize2_g1880.zw - 0.5;
			float2 f = frac( UV2_g1880 );
			UV2_g1880 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g1880.x - 0.5, UV2_g1880.x + 1.5, UV2_g1880.y - 0.5, UV2_g1880.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g1880 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1880.xyxy;
			Weights2_g1880 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g1877 = Offsets2_g1880;
			float4 Input_FetchOffsets197_g1881 = temp_output_1_34_g1877;
			float2 temp_output_1_54_g1877 = Weights2_g1880;
			float2 Input_FetchWeights200_g1881 = temp_output_1_54_g1877;
			float2 break187_g1881 = Input_FetchWeights200_g1881;
			float4 lerpResult181_g1881 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g1881).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g1881).xw ) , break187_g1881.x);
			float4 lerpResult182_g1881 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g1881).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g1881).xz ) , break187_g1881.x);
			float4 lerpResult176_g1881 = lerp( lerpResult181_g1881 , lerpResult182_g1881 , break187_g1881.y);
			float4 Output_Fetch2D202_g1881 = lerpResult176_g1881;
			#ifdef _USEBICUBICSAMPLER_ON
				float4 staticSwitch705_g1864 = Output_Fetch2D202_g1881;
			#else
				float4 staticSwitch705_g1864 = float4( tex2D( _RNMX0, i.uv3_texcoord3 ).rgb , 0.0 );
			#endif
			float3 appendResult146_g1866 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g1866 = dot( appendResult146_g1866 , Normal_Map318_g1866 );
			float4 Input_FetchOffsets197_g1878 = temp_output_1_34_g1877;
			float2 Input_FetchWeights200_g1878 = temp_output_1_54_g1877;
			float2 break187_g1878 = Input_FetchWeights200_g1878;
			float4 lerpResult181_g1878 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g1878).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g1878).xw ) , break187_g1878.x);
			float4 lerpResult182_g1878 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g1878).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g1878).xz ) , break187_g1878.x);
			float4 lerpResult176_g1878 = lerp( lerpResult181_g1878 , lerpResult182_g1878 , break187_g1878.y);
			float4 Output_Fetch2D202_g1878 = lerpResult176_g1878;
			#ifdef _USEBICUBICSAMPLER_ON
				float4 staticSwitch715_g1864 = Output_Fetch2D202_g1878;
			#else
				float4 staticSwitch715_g1864 = float4( tex2D( _RNMY0, i.uv3_texcoord3 ).rgb , 0.0 );
			#endif
			float3 appendResult149_g1866 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g1866 = dot( appendResult149_g1866 , Normal_Map318_g1866 );
			float4 Input_FetchOffsets197_g1879 = temp_output_1_34_g1877;
			float2 Input_FetchWeights200_g1879 = temp_output_1_54_g1877;
			float2 break187_g1879 = Input_FetchWeights200_g1879;
			float4 lerpResult181_g1879 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g1879).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g1879).xw ) , break187_g1879.x);
			float4 lerpResult182_g1879 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g1879).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g1879).xz ) , break187_g1879.x);
			float4 lerpResult176_g1879 = lerp( lerpResult181_g1879 , lerpResult182_g1879 , break187_g1879.y);
			float4 Output_Fetch2D202_g1879 = lerpResult176_g1879;
			#ifdef _USEBICUBICSAMPLER_ON
				float4 staticSwitch716_g1864 = Output_Fetch2D202_g1879;
			#else
				float4 staticSwitch716_g1864 = float4( tex2D( _RNMZ0, i.uv3_texcoord3 ).rgb , 0.0 );
			#endif
			float4 temp_output_714_0_g1864 = ( ( ( saturate( dotResult121_g1866 ) * ( staticSwitch705_g1864 * 1.0 ) ) + ( saturate( dotResult122_g1866 ) * ( staticSwitch715_g1864 * 1.0 ) ) ) + ( saturate( dotResult120_g1866 ) * ( staticSwitch716_g1864 * 1.0 ) ) );
			float3 appendResult139_g1868 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float localBicubicPrepare2_g1869 = ( 0.0 );
			float2 Input_UV100_g1869 = uv_BumpMap;
			float2 UV2_g1869 = Input_UV100_g1869;
			float4 TexelSize2_g1869 = _BumpMap_TexelSize;
			float2 UV02_g1869 = float2( 0,0 );
			float2 UV12_g1869 = float2( 0,0 );
			float2 UV22_g1869 = float2( 0,0 );
			float2 UV32_g1869 = float2( 0,0 );
			float W02_g1869 = 0;
			float W12_g1869 = 0;
			{
			{
			 UV2_g1869 = UV2_g1869 * TexelSize2_g1869.zw - 0.5;
			    float2 f = frac( UV2_g1869 );
			    UV2_g1869 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g1869.x - 0.5, UV2_g1869.x + 1.5, UV2_g1869.y - 0.5, UV2_g1869.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1869.xyxy;
			    UV02_g1869 = off.xz;
			    UV12_g1869 = off.yz;
			    UV22_g1869 = off.xw;
			    UV32_g1869 = off.yw;
			    W02_g1869 = s.x / ( s.x + s.y );
			 W12_g1869 = s.z / ( s.z + s.w );
			}
			}
			float temp_output_239_0_g1869 = Normal_Map_Scale700_g1864;
			float3 lerpResult46_g1869 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV32_g1869 ), temp_output_239_0_g1869 ) , UnpackScaleNormal( tex2D( _BumpMap, UV22_g1869 ), temp_output_239_0_g1869 ) , W02_g1869);
			float3 lerpResult45_g1869 = lerp( UnpackScaleNormal( tex2D( _BumpMap, UV12_g1869 ), temp_output_239_0_g1869 ) , UnpackScaleNormal( tex2D( _BumpMap, UV02_g1869 ), temp_output_239_0_g1869 ) , W02_g1869);
			float3 lerpResult44_g1869 = lerp( lerpResult46_g1869 , lerpResult45_g1869 , W12_g1869);
			float3 Output_2D131_g1869 = lerpResult44_g1869;
			float3 normalizeResult326_g1868 = normalize( Output_2D131_g1869 );
			float3 Normal_Map318_g1868 = normalizeResult326_g1868;
			float dotResult121_g1868 = dot( appendResult139_g1868 , Normal_Map318_g1868 );
			float localStochasticTiling2_g1873 = ( 0.0 );
			float2 uv3_RNMX1 = i.uv3_texcoord3 * _RNMX1_ST.xy + _RNMX1_ST.zw;
			float2 UV2_g1873 = uv3_RNMX1;
			float4 TexelSize2_g1873 = _RNMX1_TexelSize;
			float4 Offsets2_g1873 = float4( 0,0,0,0 );
			float2 Weights2_g1873 = float2( 0,0 );
			{
			UV2_g1873 = UV2_g1873 * TexelSize2_g1873.zw - 0.5;
			float2 f = frac( UV2_g1873 );
			UV2_g1873 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g1873.x - 0.5, UV2_g1873.x + 1.5, UV2_g1873.y - 0.5, UV2_g1873.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g1873 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1873.xyxy;
			Weights2_g1873 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g1870 = Offsets2_g1873;
			float4 Input_FetchOffsets197_g1874 = temp_output_1_34_g1870;
			float2 temp_output_1_54_g1870 = Weights2_g1873;
			float2 Input_FetchWeights200_g1874 = temp_output_1_54_g1870;
			float2 break187_g1874 = Input_FetchWeights200_g1874;
			float4 lerpResult181_g1874 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g1874).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g1874).xw ) , break187_g1874.x);
			float4 lerpResult182_g1874 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g1874).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g1874).xz ) , break187_g1874.x);
			float4 lerpResult176_g1874 = lerp( lerpResult181_g1874 , lerpResult182_g1874 , break187_g1874.y);
			float4 Output_Fetch2D202_g1874 = lerpResult176_g1874;
			#ifdef _USEBICUBICSAMPLER_ON
				float4 staticSwitch764_g1864 = Output_Fetch2D202_g1874;
			#else
				float4 staticSwitch764_g1864 = float4( tex2D( _RNMX1, i.uv3_texcoord3 ).rgb , 0.0 );
			#endif
			float3 appendResult146_g1868 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g1868 = dot( appendResult146_g1868 , Normal_Map318_g1868 );
			float4 Input_FetchOffsets197_g1871 = temp_output_1_34_g1870;
			float2 Input_FetchWeights200_g1871 = temp_output_1_54_g1870;
			float2 break187_g1871 = Input_FetchWeights200_g1871;
			float4 lerpResult181_g1871 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g1871).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g1871).xw ) , break187_g1871.x);
			float4 lerpResult182_g1871 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g1871).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g1871).xz ) , break187_g1871.x);
			float4 lerpResult176_g1871 = lerp( lerpResult181_g1871 , lerpResult182_g1871 , break187_g1871.y);
			float4 Output_Fetch2D202_g1871 = lerpResult176_g1871;
			#ifdef _USEBICUBICSAMPLER_ON
				float4 staticSwitch753_g1864 = Output_Fetch2D202_g1871;
			#else
				float4 staticSwitch753_g1864 = float4( tex2D( _RNMY1, i.uv3_texcoord3 ).rgb , 0.0 );
			#endif
			float3 appendResult149_g1868 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g1868 = dot( appendResult149_g1868 , Normal_Map318_g1868 );
			float4 Input_FetchOffsets197_g1872 = temp_output_1_34_g1870;
			float2 Input_FetchWeights200_g1872 = temp_output_1_54_g1870;
			float2 break187_g1872 = Input_FetchWeights200_g1872;
			float4 lerpResult181_g1872 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g1872).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g1872).xw ) , break187_g1872.x);
			float4 lerpResult182_g1872 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g1872).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g1872).xz ) , break187_g1872.x);
			float4 lerpResult176_g1872 = lerp( lerpResult181_g1872 , lerpResult182_g1872 , break187_g1872.y);
			float4 Output_Fetch2D202_g1872 = lerpResult176_g1872;
			#ifdef _USEBICUBICSAMPLER_ON
				float4 staticSwitch750_g1864 = Output_Fetch2D202_g1872;
			#else
				float4 staticSwitch750_g1864 = float4( tex2D( _RNMZ1, i.uv3_texcoord3 ).rgb , 0.0 );
			#endif
			float4 lerpResult442_g1864 = lerp( temp_output_714_0_g1864 , ( ( ( saturate( dotResult121_g1868 ) * ( staticSwitch764_g1864 * 1.0 ) ) + ( saturate( dotResult122_g1868 ) * ( staticSwitch753_g1864 * 1.0 ) ) ) + ( saturate( dotResult120_g1868 ) * ( staticSwitch750_g1864 * 1.0 ) ) ) , _LightmapLerp);
			#if defined( _LIGHTMAPPINGMODE_SIMPLE )
				float4 staticSwitch565_g1864 = staticSwitch768_g1864;
			#elif defined( _LIGHTMAPPINGMODE_RNM )
				float4 staticSwitch565_g1864 = temp_output_714_0_g1864;
			#elif defined( _LIGHTMAPPINGMODE_RNMLERP )
				float4 staticSwitch565_g1864 = lerpResult442_g1864;
			#else
				float4 staticSwitch565_g1864 = staticSwitch768_g1864;
			#endif
			#ifdef _LIGHTMAPPING_ON
				float4 staticSwitch569_g1864 = staticSwitch565_g1864;
			#else
				float4 staticSwitch569_g1864 = temp_cast_4;
			#endif
			float4 Lightmap46_g1864 = staticSwitch569_g1864;
			#ifdef _LIGHTMAPPING_ON
				float4 staticSwitch566_g1864 = ( float4( Albedo6_g1864 , 0.0 ) * Lightmap46_g1864 );
			#else
				float4 staticSwitch566_g1864 = float4( Albedo6_g1864 , 0.0 );
			#endif
			#ifdef _LIGHTMAPPING_ON
				float4 staticSwitch696_g1864 = ( float4( staticSwitch572_g1864 , 0.0 ) + staticSwitch566_g1864 );
			#else
				float4 staticSwitch696_g1864 = ( float4( staticSwitch572_g1864 , 0.0 ) * staticSwitch566_g1864 );
			#endif
			#ifdef _LIGHTMAP_DEBUG_MODE_ON
				float4 staticSwitch686_g1864 = Lightmap46_g1864;
			#else
				float4 staticSwitch686_g1864 = staticSwitch696_g1864;
			#endif
			o.Emission = staticSwitch686_g1864.rgb;
			float2 uv_MetallicMap = i.uv_texcoord * _MetallicMap_ST.xy + _MetallicMap_ST.zw;
			#ifdef _LIGHTMAP_DEBUG_MODE_ON
				float3 staticSwitch692_g1864 = float3( 0,0,0 );
			#else
				float3 staticSwitch692_g1864 = ( _Metallic * tex2D( _MetallicMap, uv_MetallicMap ).rgb );
			#endif
			float3 Metallic699_g1864 = staticSwitch692_g1864;
			o.Metallic = Metallic699_g1864.x;
			float2 uv_EmissionMap164_g1864 = i.uv_texcoord;
			#ifdef _LIGHTMAP_DEBUG_MODE_ON
				float4 staticSwitch693_g1864 = float4( 0,0,0,0 );
			#else
				float4 staticSwitch693_g1864 = ( _Glossiness * ( 1.0 - tex2D( _EmissionMap1, uv_EmissionMap164_g1864 ) ) );
			#endif
			o.Smoothness = staticSwitch693_g1864.r;
			float4 temp_cast_16 = White38_g1864;
			float4 temp_cast_17 = White38_g1864;
			float4 saferPower606_g1864 = abs( Lightmap46_g1864 );
			float4 temp_cast_18 = (_OcclusionPower).xxxx;
			float4 clampResult579_g1864 = clamp( pow( saferPower606_g1864 , temp_cast_18 ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			#ifdef _LIGHTMAPOCCLUSION_ON
				float4 staticSwitch573_g1864 = clampResult579_g1864;
			#else
				float4 staticSwitch573_g1864 = temp_cast_17;
			#endif
			#ifdef _LIGHTMAPPING_ON
				float4 staticSwitch576_g1864 = staticSwitch573_g1864;
			#else
				float4 staticSwitch576_g1864 = temp_cast_16;
			#endif
			o.Occlusion = staticSwitch576_g1864.r;
			o.Alpha = 1;
			clip( tex2DNode259_g1864.a - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "Fairplex_ShaderGUI"
}
/*ASEBEGIN
Version=19901
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;833;192,-1200;Inherit;False;Meenphie Default;1;;1864;b3ba55a08dd6b49c7be16c6f35cf2033;0;0;8;FLOAT3;625;FLOAT3;238;COLOR;624;FLOAT3;96;COLOR;97;COLOR;95;FLOAT;156;FLOAT;427
Node;AmplifyShaderEditor.StandardSurfaceOutputNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;343;512,-1200;Float;False;True;-1;3;Fairplex_ShaderGUI;0;0;Standard;Meenphie/Cutout;False;False;False;False;True;False;False;True;True;False;False;False;False;False;True;True;False;False;True;True;False;Off;0;False;;0;False;;False;0;False;;0;False;;False;0;Masked;0.5;True;False;0;False;TransparentCutout;;AlphaTest;ForwardOnly;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0.0001;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;343;0;833;625
WireConnection;343;1;833;238
WireConnection;343;2;833;624
WireConnection;343;3;833;96
WireConnection;343;4;833;97
WireConnection;343;5;833;95
WireConnection;343;10;833;427
ASEEND*/
//CHKSM=9C0C1220E82DD85EB5AAC3076A4FC494C47D32F3