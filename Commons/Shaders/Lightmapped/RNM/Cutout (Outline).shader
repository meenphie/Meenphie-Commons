// Made with Amplify Shader Editor v1.9.9.4
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Lightmapped/RNM/Cutout (Outline)"
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
		[Meenphie_DrawerCategory(OUTLINE,true,0,0)] _CATEGORYOUTLINE( "CATEGORY OUTLINE", Float ) = 0
		_OutlineColor( "Outline Color", Color ) = ( 0.02, 0.02, 0.02, 0 )
		_OutlineWidth( "Outline Width", Range( 0, 0.01 ) ) = 0.005
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACEOUTLINE( "CATEGORY SPACE OUTLINE", Float ) = 0
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
		Tags{ }
		Cull Front
		CGPROGRAM
		#pragma target 3.0
		#pragma surface outlineSurf Outline nofog  keepalpha noshadow noambient novertexlights nolightmap nodynlightmap nodirlightmap nometa noforwardadd vertex:outlineVertexDataFunc 
		
		
		
		
		struct Input
		{
			half filler;
		};
		uniform float4 _OutlineColor;
		uniform float _OutlineWidth;
		
		void outlineVertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float outlineVar = ( _OutlineWidth * v.color.r );
			v.vertex.xyz += ( v.normal * outlineVar );
		}
		inline half4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return half4 ( 0,0,0, s.Alpha); }
		void outlineSurf( Input i, inout SurfaceOutput o )
		{
			o.Emission = _OutlineColor.rgb;
		}
		ENDCG
		

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
		#pragma surface surf Standard keepalpha exclude_path:deferred nodynlightmap nodirlightmap vertex:vertexDataFunc 
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
		uniform float _CATEGORYOUTLINE;
		uniform float _CATEGORYSPACEOUTLINE;
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

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float Outline_GUI888_g1954 = ( _CATEGORYOUTLINE + _CATEGORYSPACEOUTLINE );
			float3 temp_cast_0 = (Outline_GUI888_g1954).xxx;
			float3 lerpResult889_g1954 = lerp( 0 , temp_cast_0 , float3( 0,0,0 ));
			v.vertex.xyz += lerpResult889_g1954;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BumpMap830_g1954 = i.uv_texcoord;
			#ifdef _BUMPMAP
				float3 staticSwitch844_g1954 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap830_g1954 ), _NormalScale );
			#else
				float3 staticSwitch844_g1954 = float3( 0, 0, 1 );
			#endif
			float3 Normal_Map700_g1954 = staticSwitch844_g1954;
			o.Normal = Normal_Map700_g1954;
			float2 uv_MainTex907_g1954 = i.uv_texcoord;
			#ifdef _MAINTEX
				float4 staticSwitch899_g1954 = tex2D( _MainTex, uv_MainTex907_g1954 );
			#else
				float4 staticSwitch899_g1954 = _Color;
			#endif
			float4 Albedo6_g1954 = staticSwitch899_g1954;
			o.Albedo = Albedo6_g1954.rgb;
			float4 temp_cast_1 = 0;
			float2 uv_EmissionMap81_g1954 = i.uv_texcoord;
			#ifdef _EMISSION_ON
				float4 staticSwitch851_g1954 = ( _EmissionColor + tex2D( _EmissionMap, uv_EmissionMap81_g1954 ) );
			#else
				float4 staticSwitch851_g1954 = temp_cast_1;
			#endif
			float4 Emission86_g1954 = staticSwitch851_g1954;
			float Metallic_Value893_g1954 = _Metallic;
			float3 appendResult139_g1970 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float3 normalizeResult326_g1970 = normalize( Normal_Map700_g1954 );
			float3 Normal_Map318_g1970 = normalizeResult326_g1970;
			float dotResult121_g1970 = dot( appendResult139_g1970 , Normal_Map318_g1970 );
			float localStochasticTiling2_g1966 = ( 0.0 );
			float2 uv3_RNMX0 = i.uv3_texcoord3 * _RNMX0_ST.xy + _RNMX0_ST.zw;
			float2 UV2_g1966 = uv3_RNMX0;
			float4 TexelSize2_g1966 = _RNMX0_TexelSize;
			float4 Offsets2_g1966 = float4( 0,0,0,0 );
			float2 Weights2_g1966 = float2( 0,0 );
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
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g1966 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1966.xyxy;
			Weights2_g1966 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g1965 = Offsets2_g1966;
			float4 Input_FetchOffsets197_g1969 = temp_output_1_34_g1965;
			float2 temp_output_1_54_g1965 = Weights2_g1966;
			float2 Input_FetchWeights200_g1969 = temp_output_1_54_g1965;
			float2 break187_g1969 = Input_FetchWeights200_g1969;
			float4 lerpResult181_g1969 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g1969).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g1969).xw ) , break187_g1969.x);
			float4 lerpResult182_g1969 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g1969).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g1969).xz ) , break187_g1969.x);
			float4 lerpResult176_g1969 = lerp( lerpResult181_g1969 , lerpResult182_g1969 , break187_g1969.y);
			float4 Output_Fetch2D202_g1969 = lerpResult176_g1969;
			float3 appendResult146_g1970 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g1970 = dot( appendResult146_g1970 , Normal_Map318_g1970 );
			float4 Input_FetchOffsets197_g1967 = temp_output_1_34_g1965;
			float2 Input_FetchWeights200_g1967 = temp_output_1_54_g1965;
			float2 break187_g1967 = Input_FetchWeights200_g1967;
			float4 lerpResult181_g1967 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g1967).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g1967).xw ) , break187_g1967.x);
			float4 lerpResult182_g1967 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g1967).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g1967).xz ) , break187_g1967.x);
			float4 lerpResult176_g1967 = lerp( lerpResult181_g1967 , lerpResult182_g1967 , break187_g1967.y);
			float4 Output_Fetch2D202_g1967 = lerpResult176_g1967;
			float3 appendResult149_g1970 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g1970 = dot( appendResult149_g1970 , Normal_Map318_g1970 );
			float4 Input_FetchOffsets197_g1968 = temp_output_1_34_g1965;
			float2 Input_FetchWeights200_g1968 = temp_output_1_54_g1965;
			float2 break187_g1968 = Input_FetchWeights200_g1968;
			float4 lerpResult181_g1968 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g1968).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g1968).xw ) , break187_g1968.x);
			float4 lerpResult182_g1968 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g1968).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g1968).xz ) , break187_g1968.x);
			float4 lerpResult176_g1968 = lerp( lerpResult181_g1968 , lerpResult182_g1968 , break187_g1968.y);
			float4 Output_Fetch2D202_g1968 = lerpResult176_g1968;
			float4 RNM_0926_g1954 = ( ( ( saturate( dotResult121_g1970 ) * ( Output_Fetch2D202_g1969 * 0.8 ) ) + ( saturate( dotResult122_g1970 ) * ( Output_Fetch2D202_g1967 * 0.8 ) ) ) + ( saturate( dotResult120_g1970 ) * ( Output_Fetch2D202_g1968 * 0.8 ) ) );
			float3 appendResult139_g1971 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float3 normalizeResult326_g1971 = normalize( Normal_Map700_g1954 );
			float3 Normal_Map318_g1971 = normalizeResult326_g1971;
			float dotResult121_g1971 = dot( appendResult139_g1971 , Normal_Map318_g1971 );
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
			float4 lerpResult181_g1964 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g1964).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g1964).xw ) , break187_g1964.x);
			float4 lerpResult182_g1964 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g1964).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g1964).xz ) , break187_g1964.x);
			float4 lerpResult176_g1964 = lerp( lerpResult181_g1964 , lerpResult182_g1964 , break187_g1964.y);
			float4 Output_Fetch2D202_g1964 = lerpResult176_g1964;
			float3 appendResult146_g1971 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g1971 = dot( appendResult146_g1971 , Normal_Map318_g1971 );
			float4 Input_FetchOffsets197_g1962 = temp_output_1_34_g1960;
			float2 Input_FetchWeights200_g1962 = temp_output_1_54_g1960;
			float2 break187_g1962 = Input_FetchWeights200_g1962;
			float4 lerpResult181_g1962 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g1962).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g1962).xw ) , break187_g1962.x);
			float4 lerpResult182_g1962 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g1962).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g1962).xz ) , break187_g1962.x);
			float4 lerpResult176_g1962 = lerp( lerpResult181_g1962 , lerpResult182_g1962 , break187_g1962.y);
			float4 Output_Fetch2D202_g1962 = lerpResult176_g1962;
			float3 appendResult149_g1971 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g1971 = dot( appendResult149_g1971 , Normal_Map318_g1971 );
			float4 Input_FetchOffsets197_g1963 = temp_output_1_34_g1960;
			float2 Input_FetchWeights200_g1963 = temp_output_1_54_g1960;
			float2 break187_g1963 = Input_FetchWeights200_g1963;
			float4 lerpResult181_g1963 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g1963).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g1963).xw ) , break187_g1963.x);
			float4 lerpResult182_g1963 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g1963).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g1963).xz ) , break187_g1963.x);
			float4 lerpResult176_g1963 = lerp( lerpResult181_g1963 , lerpResult182_g1963 , break187_g1963.y);
			float4 Output_Fetch2D202_g1963 = lerpResult176_g1963;
			float4 RNM_1927_g1954 = ( ( ( saturate( dotResult121_g1971 ) * ( Output_Fetch2D202_g1964 * 0.8 ) ) + ( saturate( dotResult122_g1971 ) * ( Output_Fetch2D202_g1962 * 0.8 ) ) ) + ( saturate( dotResult120_g1971 ) * ( Output_Fetch2D202_g1963 * 0.8 ) ) );
			float4 lerpResult953_g1954 = lerp( RNM_0926_g1954 , RNM_1927_g1954 , _LightmapLerp1);
			float4 RNM_Lerp950_g1954 = lerpResult953_g1954;
			float Lightmap_GUI886_g1954 = ( _CATEGORYLIGHTMAPPING + _CATEGORYSPACELIGHTMAPPING );
			float4 temp_cast_2 = (Lightmap_GUI886_g1954).xxxx;
			float4 lerpResult882_g1954 = lerp( RNM_Lerp950_g1954 , temp_cast_2 , float4( 0,0,0,0 ));
			float4 Lightmap46_g1954 = lerpResult882_g1954;
			float4 temp_output_614_0_g1954 = ( Albedo6_g1954 * ( ( 1.0 - Metallic_Value893_g1954 ) * Lightmap46_g1954 ) );
			o.Emission = ( Emission86_g1954 + temp_output_614_0_g1954 ).rgb;
			float2 uv_MetallicMap48_g1954 = i.uv_texcoord;
			float saferPower803_g1954 = abs( tex2D( _MetallicMap, uv_MetallicMap48_g1954 ).a );
			#ifdef _METALLICMAP
				float staticSwitch846_g1954 = pow( saferPower803_g1954 , 3.0 );
			#else
				float staticSwitch846_g1954 = _Metallic;
			#endif
			float Metallic699_g1954 = staticSwitch846_g1954;
			o.Metallic = Metallic699_g1954;
			float2 uv_GlossinessMap64_g1954 = i.uv_texcoord;
			float saferPower804_g1954 = abs( tex2D( _GlossinessMap, uv_GlossinessMap64_g1954 ).a );
			#ifdef _GLOSSINESSMAP
				float staticSwitch845_g1954 = ( 1.0 - pow( saferPower804_g1954 , 3.0 ) );
			#else
				float staticSwitch845_g1954 = _Glossiness;
			#endif
			float3 ase_normalWS = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 temp_output_3_0_g1955 = ddx( ase_normalWS );
			float dotResult5_g1955 = dot( temp_output_3_0_g1955 , temp_output_3_0_g1955 );
			float3 temp_output_4_0_g1955 = ddy( ase_normalWS );
			float dotResult6_g1955 = dot( temp_output_4_0_g1955 , temp_output_4_0_g1955 );
			#ifdef _USEGEOMETRICANTIALIASING_ON
				float staticSwitch824_g1954 = min( staticSwitch845_g1954 , ( 1.0 - pow( saturate( max( dotResult5_g1955 , dotResult6_g1955 ) ) , 0.333 ) ) );
			#else
				float staticSwitch824_g1954 = staticSwitch845_g1954;
			#endif
			o.Smoothness = staticSwitch824_g1954;
			float White38_g1954 = 1.0;
			float dotResult835_g1954 = dot( Lightmap46_g1954 , float4( float3( 0.299, 0.587, 0.114 ) , 0.0 ) );
			float saferPower606_g1954 = abs( dotResult835_g1954 );
			#ifdef _LIGHTMAPOCCLUSION_ON
				float staticSwitch573_g1954 = pow( saferPower606_g1954 , _OcclusionPower );
			#else
				float staticSwitch573_g1954 = White38_g1954;
			#endif
			o.Occlusion = staticSwitch573_g1954;
			o.Alpha = 1;
			clip( tex2D( _MainTex, uv_MainTex907_g1954 ).a - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19904
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;838;192,-1200;Inherit;False;Meenphie;1;;1954;b3ba55a08dd6b49c7be16c6f35cf2033;10,871,1,872,1,869,1,847,1,867,1,947,0,912,0,944,0,938,0,905,0;0;9;COLOR;625;FLOAT3;238;COLOR;624;FLOAT;96;FLOAT;97;FLOAT;95;FLOAT;156;FLOAT;427;FLOAT3;860
Node;AmplifyShaderEditor.StandardSurfaceOutputNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;343;512,-1200;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;0;Standard;Meenphie/Lightmapped/RNM/Cutout (Outline);False;False;False;False;False;False;False;True;True;False;False;False;False;False;True;True;False;False;True;True;False;Off;0;False;;0;False;;False;0;False;;0;False;;False;0;Masked;0.5;True;False;0;False;TransparentCutout;;AlphaTest;ForwardOnly;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0.0001;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;343;0;838;625
WireConnection;343;1;838;238
WireConnection;343;2;838;624
WireConnection;343;3;838;96
WireConnection;343;4;838;97
WireConnection;343;5;838;95
WireConnection;343;10;838;427
WireConnection;343;11;838;860
ASEEND*/
//CHKSM=D36D03DBE5924C941368939AE89251AC84F00E1D