// Made with Amplify Shader Editor v1.9.9.4
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Lightmapped/RNM/Cutout"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		[Meenphie_DrawerCategory(SURFACE OPTIONS,true,0,0)] _CATEGORY_SURFACEOPTIONS( "CATEGORY_SURFACEOPTIONS", Float ) = 1
		_Color( "DIffuse Color", Color ) = ( 0.9058824, 0.9058824, 0.9058824, 1 )
		[NoScaleOffset][SingleLineTexture] _MainTex( "Diffuse Map", 2D ) = "white" {}
		[NoScaleOffset][SingleLineTexture] _BumpMap( "Normal Map", 2D ) = "white" {}
		_NormalScale( "Normal Scale", Float ) = 1
		[NoScaleOffset][SingleLineTexture] _MetallicMap( "Metallic Map", 2D ) = "white" {}
		[NoScaleOffset][SingleLineTexture] _GlossinessMap( "Roughness Map", 2D ) = "white" {}
		_Metallic( "Metallic", Range( 0, 1 ) ) = 0
		_Glossiness( "Smoothness", Range( 0, 1 ) ) = 0.5
		[Toggle( _USEGEOMETRICANTIALIASING_ON )] _UseGeometricAntiAliasing( "Use Geometric Anti Aliasing", Float ) = 1
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESURFACEOPTIONS( "CATEGORY SPACE SURFACEOPTIONS", Float ) = 0
		[Meenphie_DrawerCategory(EMISSION,true,0,0)] _CATEGORYEMISSION( "CATEGORY EMISSION", Float ) = 0
		[Toggle( _EMISSION_ON )] _EMISSION( "Emission Enabled", Float ) = 0
		[HDR][Gamma] _EmissionColor( "Emission Color", Color ) = ( 0, 0, 0, 0 )
		[NoScaleOffset][SingleLineTexture] _EmissionMap( "Emission Map", 2D ) = "black" {}
		[Meenphie_DrawerEmissionFlags] _EmissionFlags( "Global Illumination", Float ) = 2
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACEEMISSION( "CATEGORY SPACE EMISSION", Float ) = 0
		[Meenphie_DrawerCategory(LIGHTMAPPING,true,0,0)] _CATEGORYLIGHTMAPPING( "CATEGORY LIGHTMAPPING", Float ) = 0
		[Meenphie_DrawerTextureSingleLine] _RNMX0( "RNMX 0", 2D ) = "black" {}
		[Meenphie_DrawerTextureSingleLine] _RNMY0( "RNMY 0", 2D ) = "black" {}
		[Meenphie_DrawerTextureSingleLine] _RNMZ0( "RNMZ 0", 2D ) = "black" {}
		[Meenphie_DrawerTextureSingleLine] _RNMX1( "RNMX 1", 2D ) = "black" {}
		[Meenphie_DrawerTextureSingleLine] _RNMY1( "RNMY 1", 2D ) = "black" {}
		[Meenphie_DrawerTextureSingleLine] _RNMZ1( "RNMZ 1", 2D ) = "black" {}
		_LightmapLerp1( "LightmapLerp", Range( 0, 1 ) ) = 1
		[Toggle( _LIGHTMAPOCCLUSION_ON )] _LightmapOcclusion( "Lightmap Occlusion", Float ) = 1
		_OcclusionPower( "Occlusion Power", Float ) = 1
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACELIGHTMAPPING( "CATEGORY SPACE LIGHTMAPPING", Float ) = 0
		[HideInInspector] _texcoord3( "", 2D ) = "white" {}
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0
		[HideInInspector] GenKey__MainTex( "Assign keyword _MAINTEX", Float ) = 1.0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
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
		#pragma shader_feature_local_fragment _BUMPMAP
		#pragma shader_feature_local_fragment _MAINTEX
		#pragma shader_feature_local_fragment _EMISSION_ON
		#pragma shader_feature_local_fragment _METALLICMAP
		#pragma shader_feature_local_fragment _USEGEOMETRICANTIALIASING_ON
		#pragma shader_feature_local_fragment _GLOSSINESSMAP
		#pragma shader_feature_local_fragment _LIGHTMAPOCCLUSION_ON
		#define ASE_VERSION 19904
		#pragma surface surf Standard keepalpha exclude_path:deferred nodynlightmap nodirlightmap 
		struct Input
		{
			float2 uv_texcoord;
			float2 uv3_texcoord3;
			float3 worldNormal;
			INTERNAL_DATA
		};

		uniform float _CATEGORY_SURFACEOPTIONS;
		uniform float _CATEGORYSPACESURFACEOPTIONS;
		uniform float _EmissionFlags;
		uniform float _CATEGORYEMISSION;
		uniform float _CATEGORYSPACEEMISSION;
		uniform sampler2D _BumpMap;
		uniform float _NormalScale;
		uniform float4 _Color;
		uniform sampler2D _MainTex;
		uniform float4 _EmissionColor;
		uniform sampler2D _EmissionMap;
		uniform float _Metallic;
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
		uniform float _LightmapLerp1;
		uniform float _CATEGORYLIGHTMAPPING;
		uniform float _CATEGORYSPACELIGHTMAPPING;
		uniform sampler2D _MetallicMap;
		uniform float _Glossiness;
		uniform sampler2D _GlossinessMap;
		uniform float _OcclusionPower;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BumpMap830_g1986 = i.uv_texcoord;
			#ifdef _BUMPMAP
				float3 staticSwitch844_g1986 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap830_g1986 ), _NormalScale );
			#else
				float3 staticSwitch844_g1986 = float3( 0, 0, 1 );
			#endif
			float3 Normal_Map700_g1986 = staticSwitch844_g1986;
			o.Normal = Normal_Map700_g1986;
			float2 uv_MainTex907_g1986 = i.uv_texcoord;
			#ifdef _MAINTEX
				float4 staticSwitch899_g1986 = tex2D( _MainTex, uv_MainTex907_g1986 );
			#else
				float4 staticSwitch899_g1986 = _Color;
			#endif
			float4 Albedo6_g1986 = staticSwitch899_g1986;
			o.Albedo = Albedo6_g1986.rgb;
			float4 temp_cast_1 = 0;
			float2 uv_EmissionMap81_g1986 = i.uv_texcoord;
			#ifdef _EMISSION_ON
				float4 staticSwitch851_g1986 = ( _EmissionColor + tex2D( _EmissionMap, uv_EmissionMap81_g1986 ) );
			#else
				float4 staticSwitch851_g1986 = temp_cast_1;
			#endif
			float4 Emission86_g1986 = staticSwitch851_g1986;
			float Metallic_Value893_g1986 = _Metallic;
			float3 appendResult139_g2002 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float3 normalizeResult326_g2002 = normalize( Normal_Map700_g1986 );
			float3 Normal_Map318_g2002 = normalizeResult326_g2002;
			float dotResult121_g2002 = dot( appendResult139_g2002 , Normal_Map318_g2002 );
			float localStochasticTiling2_g1998 = ( 0.0 );
			float2 uv3_RNMX0 = i.uv3_texcoord3 * _RNMX0_ST.xy + _RNMX0_ST.zw;
			float2 UV2_g1998 = uv3_RNMX0;
			float4 TexelSize2_g1998 = _RNMX0_TexelSize;
			float4 Offsets2_g1998 = float4( 0,0,0,0 );
			float2 Weights2_g1998 = float2( 0,0 );
			{
			UV2_g1998 = UV2_g1998 * TexelSize2_g1998.zw - 0.5;
			float2 f = frac( UV2_g1998 );
			UV2_g1998 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g1998.x - 0.5, UV2_g1998.x + 1.5, UV2_g1998.y - 0.5, UV2_g1998.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g1998 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1998.xyxy;
			Weights2_g1998 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g1997 = Offsets2_g1998;
			float4 Input_FetchOffsets197_g2001 = temp_output_1_34_g1997;
			float2 temp_output_1_54_g1997 = Weights2_g1998;
			float2 Input_FetchWeights200_g2001 = temp_output_1_54_g1997;
			float2 break187_g2001 = Input_FetchWeights200_g2001;
			float4 lerpResult181_g2001 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g2001).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g2001).xw ) , break187_g2001.x);
			float4 lerpResult182_g2001 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g2001).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g2001).xz ) , break187_g2001.x);
			float4 lerpResult176_g2001 = lerp( lerpResult181_g2001 , lerpResult182_g2001 , break187_g2001.y);
			float4 Output_Fetch2D202_g2001 = lerpResult176_g2001;
			float3 appendResult146_g2002 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g2002 = dot( appendResult146_g2002 , Normal_Map318_g2002 );
			float4 Input_FetchOffsets197_g1999 = temp_output_1_34_g1997;
			float2 Input_FetchWeights200_g1999 = temp_output_1_54_g1997;
			float2 break187_g1999 = Input_FetchWeights200_g1999;
			float4 lerpResult181_g1999 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g1999).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g1999).xw ) , break187_g1999.x);
			float4 lerpResult182_g1999 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g1999).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g1999).xz ) , break187_g1999.x);
			float4 lerpResult176_g1999 = lerp( lerpResult181_g1999 , lerpResult182_g1999 , break187_g1999.y);
			float4 Output_Fetch2D202_g1999 = lerpResult176_g1999;
			float3 appendResult149_g2002 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g2002 = dot( appendResult149_g2002 , Normal_Map318_g2002 );
			float4 Input_FetchOffsets197_g2000 = temp_output_1_34_g1997;
			float2 Input_FetchWeights200_g2000 = temp_output_1_54_g1997;
			float2 break187_g2000 = Input_FetchWeights200_g2000;
			float4 lerpResult181_g2000 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g2000).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g2000).xw ) , break187_g2000.x);
			float4 lerpResult182_g2000 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g2000).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g2000).xz ) , break187_g2000.x);
			float4 lerpResult176_g2000 = lerp( lerpResult181_g2000 , lerpResult182_g2000 , break187_g2000.y);
			float4 Output_Fetch2D202_g2000 = lerpResult176_g2000;
			float4 RNM_0926_g1986 = ( ( ( saturate( dotResult121_g2002 ) * ( Output_Fetch2D202_g2001 * 0.8 ) ) + ( saturate( dotResult122_g2002 ) * ( Output_Fetch2D202_g1999 * 0.8 ) ) ) + ( saturate( dotResult120_g2002 ) * ( Output_Fetch2D202_g2000 * 0.8 ) ) );
			float3 appendResult139_g2003 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float3 normalizeResult326_g2003 = normalize( Normal_Map700_g1986 );
			float3 Normal_Map318_g2003 = normalizeResult326_g2003;
			float dotResult121_g2003 = dot( appendResult139_g2003 , Normal_Map318_g2003 );
			float localStochasticTiling2_g1993 = ( 0.0 );
			float2 uv3_RNMX1 = i.uv3_texcoord3 * _RNMX1_ST.xy + _RNMX1_ST.zw;
			float2 UV2_g1993 = uv3_RNMX1;
			float4 TexelSize2_g1993 = _RNMX1_TexelSize;
			float4 Offsets2_g1993 = float4( 0,0,0,0 );
			float2 Weights2_g1993 = float2( 0,0 );
			{
			UV2_g1993 = UV2_g1993 * TexelSize2_g1993.zw - 0.5;
			float2 f = frac( UV2_g1993 );
			UV2_g1993 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g1993.x - 0.5, UV2_g1993.x + 1.5, UV2_g1993.y - 0.5, UV2_g1993.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g1993 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1993.xyxy;
			Weights2_g1993 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g1992 = Offsets2_g1993;
			float4 Input_FetchOffsets197_g1996 = temp_output_1_34_g1992;
			float2 temp_output_1_54_g1992 = Weights2_g1993;
			float2 Input_FetchWeights200_g1996 = temp_output_1_54_g1992;
			float2 break187_g1996 = Input_FetchWeights200_g1996;
			float4 lerpResult181_g1996 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g1996).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g1996).xw ) , break187_g1996.x);
			float4 lerpResult182_g1996 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g1996).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g1996).xz ) , break187_g1996.x);
			float4 lerpResult176_g1996 = lerp( lerpResult181_g1996 , lerpResult182_g1996 , break187_g1996.y);
			float4 Output_Fetch2D202_g1996 = lerpResult176_g1996;
			float3 appendResult146_g2003 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g2003 = dot( appendResult146_g2003 , Normal_Map318_g2003 );
			float4 Input_FetchOffsets197_g1994 = temp_output_1_34_g1992;
			float2 Input_FetchWeights200_g1994 = temp_output_1_54_g1992;
			float2 break187_g1994 = Input_FetchWeights200_g1994;
			float4 lerpResult181_g1994 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g1994).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g1994).xw ) , break187_g1994.x);
			float4 lerpResult182_g1994 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g1994).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g1994).xz ) , break187_g1994.x);
			float4 lerpResult176_g1994 = lerp( lerpResult181_g1994 , lerpResult182_g1994 , break187_g1994.y);
			float4 Output_Fetch2D202_g1994 = lerpResult176_g1994;
			float3 appendResult149_g2003 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g2003 = dot( appendResult149_g2003 , Normal_Map318_g2003 );
			float4 Input_FetchOffsets197_g1995 = temp_output_1_34_g1992;
			float2 Input_FetchWeights200_g1995 = temp_output_1_54_g1992;
			float2 break187_g1995 = Input_FetchWeights200_g1995;
			float4 lerpResult181_g1995 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g1995).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g1995).xw ) , break187_g1995.x);
			float4 lerpResult182_g1995 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g1995).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g1995).xz ) , break187_g1995.x);
			float4 lerpResult176_g1995 = lerp( lerpResult181_g1995 , lerpResult182_g1995 , break187_g1995.y);
			float4 Output_Fetch2D202_g1995 = lerpResult176_g1995;
			float4 RNM_1927_g1986 = ( ( ( saturate( dotResult121_g2003 ) * ( Output_Fetch2D202_g1996 * 0.8 ) ) + ( saturate( dotResult122_g2003 ) * ( Output_Fetch2D202_g1994 * 0.8 ) ) ) + ( saturate( dotResult120_g2003 ) * ( Output_Fetch2D202_g1995 * 0.8 ) ) );
			float4 lerpResult953_g1986 = lerp( RNM_0926_g1986 , RNM_1927_g1986 , _LightmapLerp1);
			float4 RNM_Lerp950_g1986 = lerpResult953_g1986;
			float Lightmap_GUI886_g1986 = ( _CATEGORYLIGHTMAPPING + _CATEGORYSPACELIGHTMAPPING );
			float4 temp_cast_2 = (Lightmap_GUI886_g1986).xxxx;
			float4 lerpResult882_g1986 = lerp( RNM_Lerp950_g1986 , temp_cast_2 , float4( 0,0,0,0 ));
			float4 Lightmap46_g1986 = lerpResult882_g1986;
			float4 temp_output_614_0_g1986 = ( Albedo6_g1986 * ( ( 1.0 - Metallic_Value893_g1986 ) * Lightmap46_g1986 ) );
			o.Emission = ( Emission86_g1986 + temp_output_614_0_g1986 ).rgb;
			float2 uv_MetallicMap48_g1986 = i.uv_texcoord;
			float saferPower803_g1986 = abs( tex2D( _MetallicMap, uv_MetallicMap48_g1986 ).a );
			#ifdef _METALLICMAP
				float staticSwitch846_g1986 = pow( saferPower803_g1986 , 3.0 );
			#else
				float staticSwitch846_g1986 = _Metallic;
			#endif
			float Metallic699_g1986 = staticSwitch846_g1986;
			o.Metallic = Metallic699_g1986;
			float2 uv_GlossinessMap64_g1986 = i.uv_texcoord;
			float saferPower804_g1986 = abs( tex2D( _GlossinessMap, uv_GlossinessMap64_g1986 ).a );
			#ifdef _GLOSSINESSMAP
				float staticSwitch845_g1986 = ( 1.0 - pow( saferPower804_g1986 , 3.0 ) );
			#else
				float staticSwitch845_g1986 = _Glossiness;
			#endif
			float3 ase_normalWS = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 temp_output_3_0_g1987 = ddx( ase_normalWS );
			float dotResult5_g1987 = dot( temp_output_3_0_g1987 , temp_output_3_0_g1987 );
			float3 temp_output_4_0_g1987 = ddy( ase_normalWS );
			float dotResult6_g1987 = dot( temp_output_4_0_g1987 , temp_output_4_0_g1987 );
			#ifdef _USEGEOMETRICANTIALIASING_ON
				float staticSwitch824_g1986 = min( staticSwitch845_g1986 , ( 1.0 - pow( saturate( max( dotResult5_g1987 , dotResult6_g1987 ) ) , 0.333 ) ) );
			#else
				float staticSwitch824_g1986 = staticSwitch845_g1986;
			#endif
			o.Smoothness = staticSwitch824_g1986;
			float White38_g1986 = 1.0;
			float dotResult835_g1986 = dot( Lightmap46_g1986 , float4( float3( 0.299, 0.587, 0.114 ) , 0.0 ) );
			float saferPower606_g1986 = abs( dotResult835_g1986 );
			#ifdef _LIGHTMAPOCCLUSION_ON
				float staticSwitch573_g1986 = pow( saferPower606_g1986 , _OcclusionPower );
			#else
				float staticSwitch573_g1986 = White38_g1986;
			#endif
			o.Occlusion = staticSwitch573_g1986;
			o.Alpha = 1;
			clip( tex2D( _MainTex, uv_MainTex907_g1986 ).a - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19904
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;840;192,-1200;Inherit;False;Meenphie;1;;1986;b3ba55a08dd6b49c7be16c6f35cf2033;10,871,1,872,1,869,1,847,1,867,0,947,0,912,0,944,0,938,0,905,0;0;9;COLOR;625;FLOAT3;238;COLOR;624;FLOAT;96;FLOAT;97;FLOAT;95;FLOAT;156;FLOAT;427;FLOAT3;860
Node;AmplifyShaderEditor.StandardSurfaceOutputNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;343;512,-1200;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;0;Standard;Meenphie/Lightmapped/RNM/Cutout;False;False;False;False;False;False;False;True;True;False;False;False;False;False;True;True;False;False;True;True;False;Off;0;False;;0;False;;False;0;False;;0;False;;False;0;Masked;0.5;True;False;0;False;TransparentCutout;;AlphaTest;ForwardOnly;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0.0001;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;343;0;840;625
WireConnection;343;1;840;238
WireConnection;343;2;840;624
WireConnection;343;3;840;96
WireConnection;343;4;840;97
WireConnection;343;5;840;95
WireConnection;343;10;840;427
ASEEND*/
//CHKSM=8ECD44242D748948912BFAEF3A0B183CC6DE18CD