// Made with Amplify Shader Editor v1.9.9.4
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Lightmapped/RNM/Opaque"
{
	Properties
	{
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
		[HideInInspector] GenKey__MainTex( "Assign keyword _MAINTEX", Float ) = 1.0
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0
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

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BumpMap830_g1352 = i.uv_texcoord;
			#ifdef _BUMPMAP
				float3 staticSwitch844_g1352 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap830_g1352 ), _NormalScale );
			#else
				float3 staticSwitch844_g1352 = float3( 0, 0, 1 );
			#endif
			float3 Normal_Map700_g1352 = staticSwitch844_g1352;
			o.Normal = Normal_Map700_g1352;
			float2 uv_MainTex907_g1352 = i.uv_texcoord;
			#ifdef _MAINTEX
				float4 staticSwitch899_g1352 = tex2D( _MainTex, uv_MainTex907_g1352 );
			#else
				float4 staticSwitch899_g1352 = _Color;
			#endif
			float4 Albedo6_g1352 = staticSwitch899_g1352;
			o.Albedo = Albedo6_g1352.rgb;
			float4 temp_cast_1 = 0;
			float2 uv_EmissionMap81_g1352 = i.uv_texcoord;
			#ifdef _EMISSION_ON
				float4 staticSwitch851_g1352 = ( _EmissionColor + tex2D( _EmissionMap, uv_EmissionMap81_g1352 ) );
			#else
				float4 staticSwitch851_g1352 = temp_cast_1;
			#endif
			float4 Emission86_g1352 = staticSwitch851_g1352;
			float Metallic_Value893_g1352 = _Metallic;
			float3 appendResult139_g1368 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float3 normalizeResult326_g1368 = normalize( Normal_Map700_g1352 );
			float3 Normal_Map318_g1368 = normalizeResult326_g1368;
			float dotResult121_g1368 = dot( appendResult139_g1368 , Normal_Map318_g1368 );
			float localStochasticTiling2_g1364 = ( 0.0 );
			float2 uv3_RNMX0 = i.uv3_texcoord3 * _RNMX0_ST.xy + _RNMX0_ST.zw;
			float2 UV2_g1364 = uv3_RNMX0;
			float4 TexelSize2_g1364 = _RNMX0_TexelSize;
			float4 Offsets2_g1364 = float4( 0,0,0,0 );
			float2 Weights2_g1364 = float2( 0,0 );
			{
			UV2_g1364 = UV2_g1364 * TexelSize2_g1364.zw - 0.5;
			float2 f = frac( UV2_g1364 );
			UV2_g1364 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g1364.x - 0.5, UV2_g1364.x + 1.5, UV2_g1364.y - 0.5, UV2_g1364.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g1364 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1364.xyxy;
			Weights2_g1364 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g1363 = Offsets2_g1364;
			float4 Input_FetchOffsets197_g1367 = temp_output_1_34_g1363;
			float2 temp_output_1_54_g1363 = Weights2_g1364;
			float2 Input_FetchWeights200_g1367 = temp_output_1_54_g1363;
			float2 break187_g1367 = Input_FetchWeights200_g1367;
			float4 lerpResult181_g1367 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g1367).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g1367).xw ) , break187_g1367.x);
			float4 lerpResult182_g1367 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g1367).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g1367).xz ) , break187_g1367.x);
			float4 lerpResult176_g1367 = lerp( lerpResult181_g1367 , lerpResult182_g1367 , break187_g1367.y);
			float4 Output_Fetch2D202_g1367 = lerpResult176_g1367;
			float3 appendResult146_g1368 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g1368 = dot( appendResult146_g1368 , Normal_Map318_g1368 );
			float4 Input_FetchOffsets197_g1365 = temp_output_1_34_g1363;
			float2 Input_FetchWeights200_g1365 = temp_output_1_54_g1363;
			float2 break187_g1365 = Input_FetchWeights200_g1365;
			float4 lerpResult181_g1365 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g1365).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g1365).xw ) , break187_g1365.x);
			float4 lerpResult182_g1365 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g1365).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g1365).xz ) , break187_g1365.x);
			float4 lerpResult176_g1365 = lerp( lerpResult181_g1365 , lerpResult182_g1365 , break187_g1365.y);
			float4 Output_Fetch2D202_g1365 = lerpResult176_g1365;
			float3 appendResult149_g1368 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g1368 = dot( appendResult149_g1368 , Normal_Map318_g1368 );
			float4 Input_FetchOffsets197_g1366 = temp_output_1_34_g1363;
			float2 Input_FetchWeights200_g1366 = temp_output_1_54_g1363;
			float2 break187_g1366 = Input_FetchWeights200_g1366;
			float4 lerpResult181_g1366 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g1366).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g1366).xw ) , break187_g1366.x);
			float4 lerpResult182_g1366 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g1366).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g1366).xz ) , break187_g1366.x);
			float4 lerpResult176_g1366 = lerp( lerpResult181_g1366 , lerpResult182_g1366 , break187_g1366.y);
			float4 Output_Fetch2D202_g1366 = lerpResult176_g1366;
			float4 RNM_0926_g1352 = ( ( ( saturate( dotResult121_g1368 ) * ( Output_Fetch2D202_g1367 * 0.8 ) ) + ( saturate( dotResult122_g1368 ) * ( Output_Fetch2D202_g1365 * 0.8 ) ) ) + ( saturate( dotResult120_g1368 ) * ( Output_Fetch2D202_g1366 * 0.8 ) ) );
			float3 appendResult139_g1369 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float3 normalizeResult326_g1369 = normalize( Normal_Map700_g1352 );
			float3 Normal_Map318_g1369 = normalizeResult326_g1369;
			float dotResult121_g1369 = dot( appendResult139_g1369 , Normal_Map318_g1369 );
			float localStochasticTiling2_g1359 = ( 0.0 );
			float2 uv3_RNMX1 = i.uv3_texcoord3 * _RNMX1_ST.xy + _RNMX1_ST.zw;
			float2 UV2_g1359 = uv3_RNMX1;
			float4 TexelSize2_g1359 = _RNMX1_TexelSize;
			float4 Offsets2_g1359 = float4( 0,0,0,0 );
			float2 Weights2_g1359 = float2( 0,0 );
			{
			UV2_g1359 = UV2_g1359 * TexelSize2_g1359.zw - 0.5;
			float2 f = frac( UV2_g1359 );
			UV2_g1359 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g1359.x - 0.5, UV2_g1359.x + 1.5, UV2_g1359.y - 0.5, UV2_g1359.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g1359 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1359.xyxy;
			Weights2_g1359 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g1358 = Offsets2_g1359;
			float4 Input_FetchOffsets197_g1362 = temp_output_1_34_g1358;
			float2 temp_output_1_54_g1358 = Weights2_g1359;
			float2 Input_FetchWeights200_g1362 = temp_output_1_54_g1358;
			float2 break187_g1362 = Input_FetchWeights200_g1362;
			float4 lerpResult181_g1362 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g1362).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g1362).xw ) , break187_g1362.x);
			float4 lerpResult182_g1362 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g1362).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g1362).xz ) , break187_g1362.x);
			float4 lerpResult176_g1362 = lerp( lerpResult181_g1362 , lerpResult182_g1362 , break187_g1362.y);
			float4 Output_Fetch2D202_g1362 = lerpResult176_g1362;
			float3 appendResult146_g1369 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g1369 = dot( appendResult146_g1369 , Normal_Map318_g1369 );
			float4 Input_FetchOffsets197_g1360 = temp_output_1_34_g1358;
			float2 Input_FetchWeights200_g1360 = temp_output_1_54_g1358;
			float2 break187_g1360 = Input_FetchWeights200_g1360;
			float4 lerpResult181_g1360 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g1360).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g1360).xw ) , break187_g1360.x);
			float4 lerpResult182_g1360 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g1360).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g1360).xz ) , break187_g1360.x);
			float4 lerpResult176_g1360 = lerp( lerpResult181_g1360 , lerpResult182_g1360 , break187_g1360.y);
			float4 Output_Fetch2D202_g1360 = lerpResult176_g1360;
			float3 appendResult149_g1369 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g1369 = dot( appendResult149_g1369 , Normal_Map318_g1369 );
			float4 Input_FetchOffsets197_g1361 = temp_output_1_34_g1358;
			float2 Input_FetchWeights200_g1361 = temp_output_1_54_g1358;
			float2 break187_g1361 = Input_FetchWeights200_g1361;
			float4 lerpResult181_g1361 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g1361).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g1361).xw ) , break187_g1361.x);
			float4 lerpResult182_g1361 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g1361).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g1361).xz ) , break187_g1361.x);
			float4 lerpResult176_g1361 = lerp( lerpResult181_g1361 , lerpResult182_g1361 , break187_g1361.y);
			float4 Output_Fetch2D202_g1361 = lerpResult176_g1361;
			float4 RNM_1927_g1352 = ( ( ( saturate( dotResult121_g1369 ) * ( Output_Fetch2D202_g1362 * 0.8 ) ) + ( saturate( dotResult122_g1369 ) * ( Output_Fetch2D202_g1360 * 0.8 ) ) ) + ( saturate( dotResult120_g1369 ) * ( Output_Fetch2D202_g1361 * 0.8 ) ) );
			float4 lerpResult953_g1352 = lerp( RNM_0926_g1352 , RNM_1927_g1352 , _LightmapLerp1);
			float4 RNM_Lerp950_g1352 = lerpResult953_g1352;
			float Lightmap_GUI886_g1352 = ( _CATEGORYLIGHTMAPPING + _CATEGORYSPACELIGHTMAPPING );
			float4 temp_cast_2 = (Lightmap_GUI886_g1352).xxxx;
			float4 lerpResult882_g1352 = lerp( RNM_Lerp950_g1352 , temp_cast_2 , float4( 0,0,0,0 ));
			float4 Lightmap46_g1352 = lerpResult882_g1352;
			float4 temp_output_614_0_g1352 = ( Albedo6_g1352 * ( ( 1.0 - Metallic_Value893_g1352 ) * Lightmap46_g1352 ) );
			o.Emission = ( Emission86_g1352 + temp_output_614_0_g1352 ).rgb;
			float2 uv_MetallicMap48_g1352 = i.uv_texcoord;
			float saferPower803_g1352 = abs( tex2D( _MetallicMap, uv_MetallicMap48_g1352 ).a );
			#ifdef _METALLICMAP
				float staticSwitch846_g1352 = pow( saferPower803_g1352 , 3.0 );
			#else
				float staticSwitch846_g1352 = _Metallic;
			#endif
			float Metallic699_g1352 = staticSwitch846_g1352;
			o.Metallic = Metallic699_g1352;
			float2 uv_GlossinessMap64_g1352 = i.uv_texcoord;
			float saferPower804_g1352 = abs( tex2D( _GlossinessMap, uv_GlossinessMap64_g1352 ).a );
			#ifdef _GLOSSINESSMAP
				float staticSwitch845_g1352 = ( 1.0 - pow( saferPower804_g1352 , 3.0 ) );
			#else
				float staticSwitch845_g1352 = _Glossiness;
			#endif
			float3 ase_normalWS = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 temp_output_3_0_g1353 = ddx( ase_normalWS );
			float dotResult5_g1353 = dot( temp_output_3_0_g1353 , temp_output_3_0_g1353 );
			float3 temp_output_4_0_g1353 = ddy( ase_normalWS );
			float dotResult6_g1353 = dot( temp_output_4_0_g1353 , temp_output_4_0_g1353 );
			#ifdef _USEGEOMETRICANTIALIASING_ON
				float staticSwitch824_g1352 = min( staticSwitch845_g1352 , ( 1.0 - pow( saturate( max( dotResult5_g1353 , dotResult6_g1353 ) ) , 0.333 ) ) );
			#else
				float staticSwitch824_g1352 = staticSwitch845_g1352;
			#endif
			o.Smoothness = staticSwitch824_g1352;
			float White38_g1352 = 1.0;
			float dotResult835_g1352 = dot( Lightmap46_g1352 , float4( float3( 0.299, 0.587, 0.114 ) , 0.0 ) );
			float saferPower606_g1352 = abs( dotResult835_g1352 );
			#ifdef _LIGHTMAPOCCLUSION_ON
				float staticSwitch573_g1352 = pow( saferPower606_g1352 , _OcclusionPower );
			#else
				float staticSwitch573_g1352 = White38_g1352;
			#endif
			o.Occlusion = staticSwitch573_g1352;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19904
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2858;192,-1200;Inherit;False;Meenphie;0;;1352;b3ba55a08dd6b49c7be16c6f35cf2033;10,871,1,872,1,869,1,847,1,867,0,947,0,912,0,944,0,938,0,905,0;0;9;COLOR;625;FLOAT3;238;COLOR;624;FLOAT;96;FLOAT;97;FLOAT;95;FLOAT;156;FLOAT;427;FLOAT3;860
Node;AmplifyShaderEditor.StandardSurfaceOutputNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1092;512,-1200;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;0;Standard;Meenphie/Lightmapped/RNM/Opaque;False;False;False;False;False;False;False;True;True;False;False;False;False;False;False;True;False;False;True;True;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;ForwardOnly;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0.0001;0,0,0,0;VertexOffset;False;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;1092;0;2858;625
WireConnection;1092;1;2858;238
WireConnection;1092;2;2858;624
WireConnection;1092;3;2858;96
WireConnection;1092;4;2858;97
WireConnection;1092;5;2858;95
ASEEND*/
//CHKSM=703AD2FBA1E7490870BD605727E718B934D15AE3