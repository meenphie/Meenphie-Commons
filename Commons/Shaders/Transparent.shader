// Made with Amplify Shader Editor v1.9.8.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/RNM/Transparent"
{
	Properties
	{
		[Meenphie_DrawerCategory(SURFACE OPTIONS,true,_Cull,0,0)]_CATEGORY_SURFACEOPTIONS("CATEGORY_SURFACEOPTIONS", Float) = 0
		_Color("DIffuse Color", Color) = (1,1,1,1)
		[NoScaleOffset][Meenphie_DrawerTextureSingleLine]_MainTex("Diffuse Map", 2D) = "white" {}
		[Meenphie_DrawerTextureSingleLine]_NormalMap("Normal Map", 2D) = "bump" {}
		_NormalScale("Normal Scale", Float) = 1
		[Meenphie_DrawerTextureSingleLine]_MetallicMap("Metallic Map", 2D) = "white" {}
		[HDR][NoScaleOffset][Meenphie_DrawerTextureSingleLine]_EmissionMap1("Roughness Map", 2D) = "black" {}
		_Metallic("Metallic", Range( 0 , 1)) = 0
		_Glossiness("Smoothness", Range( 0 , 1)) = 0.5
		[Meenphie_DrawerCategorySpace(10)]_CATEGORYSPACESURFACEOPTIONS("CATEGORY SPACE SURFACEOPTIONS", Float) = 0
		[Meenphie_DrawerCategory(EMISSION,true,_EMISSION,0,0)]_CATEGORYEMISSION("CATEGORY EMISSION", Float) = 0
		[Toggle(_EMISSION_ON)] _EMISSION("Enabled", Float) = 0
		[HDR][Gamma]_EmissionColor("Emission Color", Color) = (0,0,0)
		[NoScaleOffset][Meenphie_DrawerTextureSingleLine]_EmissionMap("Emission Map", 2D) = "black" {}
		_EmissionIntensity("Intensity", Float) = 0
		[Meenphie_DrawerEmissionFlags]_EmissionFlags("Global Illumination", Float) = 2
		[Meenphie_DrawerCategory(PARALLAX,true,0,0)]_CATEGORYPARALLAX("CATEGORY PARALLAX", Float) = 0
		[Toggle(__PARALLAX_ON)] __PARALLAX("Parallax Enabled", Float) = 0
		[NoScaleOffset][SingleLineTexture]_HeightMap("HeightMap", 2D) = "white" {}
		_ParallaxScale("Parallax Scale", Range( 0 , 1)) = 0.015
		_RefPlane("Ref Plane", Range( -1 , 1)) = 0.5
		[Meenphie_DrawerCategorySpace(10)]_CATEGORYSPACEPARALLAX("CATEGORY SPACE PARALLAX", Float) = 0
		[Meenphie_DrawerCategory(LIGHTMAPPING,true,0,0)]_CATEGORYLIGHTMAPPING("CATEGORY LIGHTMAPPING", Float) = 0
		[Toggle(_LIGHTMAPPING_ON)] _LIGHTMAPPING("Lightmapping Enabled", Float) = 0
		[KeywordEnum(Simple,RNM,RNMLerp)] _LIGHTMAPPINGMODE("Lightmap Mode", Float) = 0
		[Meenphie_DrawerTextureSingleLine]_Lightmap("Lightmap", 2D) = "gray" {}
		[Meenphie_DrawerTextureSingleLine]_RNMX0("RNMX 0", 2D) = "gray" {}
		[Meenphie_DrawerTextureSingleLine]_RNMY0("RNMY 0", 2D) = "gray" {}
		[Meenphie_DrawerTextureSingleLine]_RNMZ0("RNMZ 0", 2D) = "gray" {}
		[Meenphie_DrawerTextureSingleLine]_RNMX1("RNMX 1", 2D) = "gray" {}
		[Meenphie_DrawerTextureSingleLine]_RNMY1("RNMY 1", 2D) = "gray" {}
		[Meenphie_DrawerTextureSingleLine]_RNMZ1("RNMZ 1", 2D) = "gray" {}
		_RNMScale("RNM Scale", Float) = 2
		_LightmapLerp("LightmapLerp", Range( 0 , 1)) = 0
		[Toggle(_LIGHTMAPOCCLUSION_ON)] _LightmapOcclusion("Lightmap Occlusion", Float) = 1
		_OcclusionPower("Occlusion Power", Float) = 1
		[Meenphie_DrawerCategorySpace(10)]_CATEGORYSPACELIGHTMAPPING("CATEGORY SPACE LIGHTMAPPING", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord3( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
		[Header(Forward Rendering Options)]
		[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		[ToggleOff] _GlossyReflections("Reflections", Float) = 1.0
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "ForceNoShadowCasting" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 3.5
		#pragma shader_feature _SPECULARHIGHLIGHTS_OFF
		#pragma shader_feature _GLOSSYREFLECTIONS_OFF
		#pragma shader_feature_local __PARALLAX_ON
		#pragma shader_feature_local _LIGHTMAPPING_ON
		#pragma shader_feature_local _EMISSION_ON
		#pragma shader_feature_local _LIGHTMAPPINGMODE_SIMPLE _LIGHTMAPPINGMODE_RNM _LIGHTMAPPINGMODE_RNMLERP
		#pragma shader_feature_local _LIGHTMAPOCCLUSION_ON
		#define ASE_VERSION 19801
		#pragma only_renderers d3d11 glcore vulkan 
		#pragma surface surf Standard alpha:fade keepalpha exclude_path:deferred noambient nodynlightmap nodirlightmap 
		struct Input
		{
			float2 uv_texcoord;
			float3 viewDir;
			INTERNAL_DATA
			float3 worldNormal;
			float3 worldPos;
			float2 uv3_texcoord3;
		};

		uniform float _CATEGORYLIGHTMAPPING;
		uniform float _CATEGORYSPACELIGHTMAPPING;
		uniform float _EmissionFlags;
		uniform float _CATEGORYEMISSION;
		uniform float _CATEGORY_SURFACEOPTIONS;
		uniform float _CATEGORYSPACESURFACEOPTIONS;
		uniform float _CATEGORYPARALLAX;
		uniform float _CATEGORYSPACEPARALLAX;
		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
		float4 _NormalMap_TexelSize;
		uniform float _NormalScale;
		uniform sampler2D _MainTex;
		uniform float3 _EmissionColor;
		uniform sampler2D _EmissionMap;
		uniform float _EmissionIntensity;
		uniform sampler2D _HeightMap;
		uniform float _ParallaxScale;
		uniform float _RefPlane;
		uniform float4 _HeightMap_ST;
		uniform float4 _Color;
		uniform sampler2D _Lightmap;
		uniform float4 _Lightmap_ST;
		float4 _Lightmap_TexelSize;
		uniform float _RNMScale;
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


		inline float2 POM( sampler2D heightMap, float2 uvs, float2 dx, float2 dy, float3 normalWorld, float3 viewWorld, float3 viewDirTan, int minSamples, int maxSamples, int sidewallSteps, float parallax, float refPlane, float2 tilling, float2 curv, int index )
		{
			float3 result = 0;
			float stepIndex = 0;
			float numSteps = floor( lerp( (float)maxSamples, (float)minSamples, saturate( dot( normalWorld, viewWorld ) ) ) );
			float layerHeight = 1.0 / numSteps;
			float2 plane = parallax * ( viewDirTan.xy / viewDirTan.z );
			uvs.xy += refPlane * plane;
			float2 deltaTex = -plane * layerHeight;
			float2 prevTexOffset = 0;
			float prevRayZ = 1.0f;
			float prevHeight = 0.0f;
			float2 currTexOffset = deltaTex;
			float currRayZ = 1.0f - layerHeight;
			float currHeight = 0.0f;
			float intersection = 0;
			float2 finalTexOffset = 0;
			while ( stepIndex < numSteps + 1 )
			{
			 	currHeight = tex2Dgrad( heightMap, uvs + currTexOffset, dx, dy ).r;
			 	if ( currHeight > currRayZ )
			 	{
			 	 	stepIndex = numSteps + 1;
			 	}
			 	else
			 	{
			 	 	stepIndex++;
			 	 	prevTexOffset = currTexOffset;
			 	 	prevRayZ = currRayZ;
			 	 	prevHeight = currHeight;
			 	 	currTexOffset += deltaTex;
			 	 	currRayZ -= layerHeight;
			 	}
			}
			float sectionSteps = sidewallSteps;
			float sectionIndex = 0;
			float newZ = 0;
			float newHeight = 0;
			while ( sectionIndex < sectionSteps )
			{
			 	intersection = ( prevHeight - prevRayZ ) / ( prevHeight - currHeight + currRayZ - prevRayZ );
			 	finalTexOffset = prevTexOffset + intersection * deltaTex;
			 	newZ = prevRayZ - intersection * layerHeight;
			 	newHeight = tex2Dgrad( heightMap, uvs + finalTexOffset, dx, dy ).r;
			 	if ( newHeight > newZ )
			 	{
			 	 	currTexOffset = finalTexOffset;
			 	 	currHeight = newHeight;
			 	 	currRayZ = newZ;
			 	 	deltaTex = intersection * deltaTex;
			 	 	layerHeight = intersection * layerHeight;
			 	}
			 	else
			 	{
			 	 	prevTexOffset = finalTexOffset;
			 	 	prevHeight = newHeight;
			 	 	prevRayZ = newZ;
			 	 	deltaTex = ( 1 - intersection ) * deltaTex;
			 	 	layerHeight = ( 1 - intersection ) * layerHeight;
			 	}
			 	sectionIndex++;
			}
			return uvs.xy + finalTexOffset;
		}


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float localBicubicPrepare2_g2538 = ( 0.0 );
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			float2 Input_UV100_g2538 = uv_NormalMap;
			float2 UV2_g2538 = Input_UV100_g2538;
			float4 TexelSize2_g2538 = _NormalMap_TexelSize;
			float2 UV02_g2538 = float2( 0,0 );
			float2 UV12_g2538 = float2( 0,0 );
			float2 UV22_g2538 = float2( 0,0 );
			float2 UV32_g2538 = float2( 0,0 );
			float W02_g2538 = 0;
			float W12_g2538 = 0;
			{
			{
			 UV2_g2538 = UV2_g2538 * TexelSize2_g2538.zw - 0.5;
			    float2 f = frac( UV2_g2538 );
			    UV2_g2538 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g2538.x - 0.5, UV2_g2538.x + 1.5, UV2_g2538.y - 0.5, UV2_g2538.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g2538.xyxy;
			    UV02_g2538 = off.xz;
			    UV12_g2538 = off.yz;
			    UV22_g2538 = off.xw;
			    UV32_g2538 = off.yw;
			    W02_g2538 = s.x / ( s.x + s.y );
			 W12_g2538 = s.z / ( s.z + s.w );
			}
			}
			float temp_output_239_0_g2538 = _NormalScale;
			float3 lerpResult46_g2538 = lerp( UnpackScaleNormal( tex2D( _NormalMap, UV32_g2538 ), temp_output_239_0_g2538 ) , UnpackScaleNormal( tex2D( _NormalMap, UV22_g2538 ), temp_output_239_0_g2538 ) , W02_g2538);
			float3 lerpResult45_g2538 = lerp( UnpackScaleNormal( tex2D( _NormalMap, UV12_g2538 ), temp_output_239_0_g2538 ) , UnpackScaleNormal( tex2D( _NormalMap, UV02_g2538 ), temp_output_239_0_g2538 ) , W02_g2538);
			float3 lerpResult44_g2538 = lerp( lerpResult46_g2538 , lerpResult45_g2538 , W12_g2538);
			float3 Output_2D131_g2538 = lerpResult44_g2538;
			o.Normal = Output_2D131_g2538;
			float2 uv_MainTex259_g2537 = i.uv_texcoord;
			float4 tex2DNode259_g2537 = tex2D( _MainTex, uv_MainTex259_g2537 );
			o.Albedo = tex2DNode259_g2537.rgb;
			float3 temp_cast_0 = 0;
			float2 uv_EmissionMap81_g2537 = i.uv_texcoord;
			#ifdef _EMISSION_ON
				float3 staticSwitch572_g2537 = ( ( _EmissionColor + tex2D( _EmissionMap, uv_EmissionMap81_g2537 ).rgb ) * _EmissionIntensity );
			#else
				float3 staticSwitch572_g2537 = temp_cast_0;
			#endif
			float3 Emission86_g2537 = staticSwitch572_g2537;
			float3 ase_normalWS = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_positionWS = i.worldPos;
			float3 ase_viewVectorWS = ( _WorldSpaceCameraPos.xyz - ase_positionWS );
			float3 ase_viewDirWS = normalize( ase_viewVectorWS );
			float2 OffsetPOM456_g2537 = POM( _HeightMap, i.uv_texcoord, ddx(i.uv_texcoord), ddy(i.uv_texcoord), ase_normalWS, ase_viewDirWS, i.viewDir, 128, 128, 10, _ParallaxScale, _RefPlane, _HeightMap_ST.xy, float2(10,0), 0 );
			#ifdef __PARALLAX_ON
				float2 staticSwitch554_g2537 = OffsetPOM456_g2537;
			#else
				float2 staticSwitch554_g2537 = i.uv_texcoord;
			#endif
			float2 Parallax_Mapping538_g2537 = staticSwitch554_g2537;
			#ifdef __PARALLAX_ON
				float3 staticSwitch563_g2537 = tex2D( _MainTex, Parallax_Mapping538_g2537, ddx( i.uv_texcoord ), ddy( i.uv_texcoord ) ).rgb;
			#else
				float3 staticSwitch563_g2537 = tex2DNode259_g2537.rgb;
			#endif
			float3 Albedo6_g2537 = ( staticSwitch563_g2537 * _Color.rgb );
			int White38_g2537 = 1;
			float4 temp_cast_3 = White38_g2537;
			float localBicubicPrepare2_g2550 = ( 0.0 );
			float2 uv3_Lightmap = i.uv3_texcoord3 * _Lightmap_ST.xy + _Lightmap_ST.zw;
			float2 Input_UV100_g2550 = uv3_Lightmap;
			float2 UV2_g2550 = Input_UV100_g2550;
			float4 TexelSize2_g2550 = _Lightmap_TexelSize;
			float2 UV02_g2550 = float2( 0,0 );
			float2 UV12_g2550 = float2( 0,0 );
			float2 UV22_g2550 = float2( 0,0 );
			float2 UV32_g2550 = float2( 0,0 );
			float W02_g2550 = 0;
			float W12_g2550 = 0;
			{
			{
			 UV2_g2550 = UV2_g2550 * TexelSize2_g2550.zw - 0.5;
			    float2 f = frac( UV2_g2550 );
			    UV2_g2550 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g2550.x - 0.5, UV2_g2550.x + 1.5, UV2_g2550.y - 0.5, UV2_g2550.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g2550.xyxy;
			    UV02_g2550 = off.xz;
			    UV12_g2550 = off.yz;
			    UV22_g2550 = off.xw;
			    UV32_g2550 = off.yw;
			    W02_g2550 = s.x / ( s.x + s.y );
			 W12_g2550 = s.z / ( s.z + s.w );
			}
			}
			float4 lerpResult46_g2550 = lerp( tex2D( _Lightmap, UV32_g2550 ) , tex2D( _Lightmap, UV22_g2550 ) , W02_g2550);
			float4 lerpResult45_g2550 = lerp( tex2D( _Lightmap, UV12_g2550 ) , tex2D( _Lightmap, UV02_g2550 ) , W02_g2550);
			float4 lerpResult44_g2550 = lerp( lerpResult46_g2550 , lerpResult45_g2550 , W12_g2550);
			float4 Output_2D131_g2550 = lerpResult44_g2550;
			float3 appendResult139_g2553 = (float3(sqrt( ( 3.0 / 2.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float localBicubicPrepare2_g2554 = ( 0.0 );
			float2 Input_UV100_g2554 = uv_NormalMap;
			float2 UV2_g2554 = Input_UV100_g2554;
			float4 TexelSize2_g2554 = _NormalMap_TexelSize;
			float2 UV02_g2554 = float2( 0,0 );
			float2 UV12_g2554 = float2( 0,0 );
			float2 UV22_g2554 = float2( 0,0 );
			float2 UV32_g2554 = float2( 0,0 );
			float W02_g2554 = 0;
			float W12_g2554 = 0;
			{
			{
			 UV2_g2554 = UV2_g2554 * TexelSize2_g2554.zw - 0.5;
			    float2 f = frac( UV2_g2554 );
			    UV2_g2554 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g2554.x - 0.5, UV2_g2554.x + 1.5, UV2_g2554.y - 0.5, UV2_g2554.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g2554.xyxy;
			    UV02_g2554 = off.xz;
			    UV12_g2554 = off.yz;
			    UV22_g2554 = off.xw;
			    UV32_g2554 = off.yw;
			    W02_g2554 = s.x / ( s.x + s.y );
			 W12_g2554 = s.z / ( s.z + s.w );
			}
			}
			float temp_output_239_0_g2554 = _RNMScale;
			float3 lerpResult46_g2554 = lerp( UnpackScaleNormal( tex2D( _NormalMap, UV32_g2554 ), temp_output_239_0_g2554 ) , UnpackScaleNormal( tex2D( _NormalMap, UV22_g2554 ), temp_output_239_0_g2554 ) , W02_g2554);
			float3 lerpResult45_g2554 = lerp( UnpackScaleNormal( tex2D( _NormalMap, UV12_g2554 ), temp_output_239_0_g2554 ) , UnpackScaleNormal( tex2D( _NormalMap, UV02_g2554 ), temp_output_239_0_g2554 ) , W02_g2554);
			float3 lerpResult44_g2554 = lerp( lerpResult46_g2554 , lerpResult45_g2554 , W12_g2554);
			float3 Output_2D131_g2554 = lerpResult44_g2554;
			float3 normalizeResult326_g2553 = normalize( Output_2D131_g2554 );
			float3 Normal_Map318_g2553 = normalizeResult326_g2553;
			float dotResult121_g2553 = dot( appendResult139_g2553 , Normal_Map318_g2553 );
			float localStochasticTiling2_g2547 = ( 0.0 );
			float2 uv3_RNMX0 = i.uv3_texcoord3 * _RNMX0_ST.xy + _RNMX0_ST.zw;
			float2 UV2_g2547 = uv3_RNMX0;
			float4 TexelSize2_g2547 = _RNMX0_TexelSize;
			float4 Offsets2_g2547 = float4( 0,0,0,0 );
			float2 Weights2_g2547 = float2( 0,0 );
			{
			UV2_g2547 = UV2_g2547 * TexelSize2_g2547.zw - 0.5;
			float2 f = frac( UV2_g2547 );
			UV2_g2547 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g2547.x - 0.5, UV2_g2547.x + 1.5, UV2_g2547.y - 0.5, UV2_g2547.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g2547 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g2547.xyxy;
			Weights2_g2547 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g2544 = Offsets2_g2547;
			float4 Input_FetchOffsets197_g2548 = temp_output_1_34_g2544;
			float2 temp_output_1_54_g2544 = Weights2_g2547;
			float2 Input_FetchWeights200_g2548 = temp_output_1_54_g2544;
			float2 break187_g2548 = Input_FetchWeights200_g2548;
			float4 lerpResult181_g2548 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g2548).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g2548).xw ) , break187_g2548.x);
			float4 lerpResult182_g2548 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g2548).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g2548).xz ) , break187_g2548.x);
			float4 lerpResult176_g2548 = lerp( lerpResult181_g2548 , lerpResult182_g2548 , break187_g2548.y);
			float4 Output_Fetch2D202_g2548 = lerpResult176_g2548;
			float3 appendResult146_g2553 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g2553 = dot( appendResult146_g2553 , Normal_Map318_g2553 );
			float4 Input_FetchOffsets197_g2545 = temp_output_1_34_g2544;
			float2 Input_FetchWeights200_g2545 = temp_output_1_54_g2544;
			float2 break187_g2545 = Input_FetchWeights200_g2545;
			float4 lerpResult181_g2545 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g2545).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g2545).xw ) , break187_g2545.x);
			float4 lerpResult182_g2545 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g2545).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g2545).xz ) , break187_g2545.x);
			float4 lerpResult176_g2545 = lerp( lerpResult181_g2545 , lerpResult182_g2545 , break187_g2545.y);
			float4 Output_Fetch2D202_g2545 = lerpResult176_g2545;
			float3 appendResult149_g2553 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g2553 = dot( appendResult149_g2553 , Normal_Map318_g2553 );
			float4 Input_FetchOffsets197_g2546 = temp_output_1_34_g2544;
			float2 Input_FetchWeights200_g2546 = temp_output_1_54_g2544;
			float2 break187_g2546 = Input_FetchWeights200_g2546;
			float4 lerpResult181_g2546 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g2546).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g2546).xw ) , break187_g2546.x);
			float4 lerpResult182_g2546 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g2546).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g2546).xz ) , break187_g2546.x);
			float4 lerpResult176_g2546 = lerp( lerpResult181_g2546 , lerpResult182_g2546 , break187_g2546.y);
			float4 Output_Fetch2D202_g2546 = lerpResult176_g2546;
			float4 temp_output_590_0_g2537 = ( ( ( saturate( dotResult121_g2553 ) * ( Output_Fetch2D202_g2548 * 0.5 ) ) + ( saturate( dotResult122_g2553 ) * ( Output_Fetch2D202_g2545 * 0.5 ) ) ) + ( saturate( dotResult120_g2553 ) * ( Output_Fetch2D202_g2546 * 0.5 ) ) );
			float3 appendResult139_g2551 = (float3(sqrt( ( 3.0 / 2.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float localBicubicPrepare2_g2552 = ( 0.0 );
			float2 Input_UV100_g2552 = uv_NormalMap;
			float2 UV2_g2552 = Input_UV100_g2552;
			float4 TexelSize2_g2552 = _NormalMap_TexelSize;
			float2 UV02_g2552 = float2( 0,0 );
			float2 UV12_g2552 = float2( 0,0 );
			float2 UV22_g2552 = float2( 0,0 );
			float2 UV32_g2552 = float2( 0,0 );
			float W02_g2552 = 0;
			float W12_g2552 = 0;
			{
			{
			 UV2_g2552 = UV2_g2552 * TexelSize2_g2552.zw - 0.5;
			    float2 f = frac( UV2_g2552 );
			    UV2_g2552 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g2552.x - 0.5, UV2_g2552.x + 1.5, UV2_g2552.y - 0.5, UV2_g2552.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g2552.xyxy;
			    UV02_g2552 = off.xz;
			    UV12_g2552 = off.yz;
			    UV22_g2552 = off.xw;
			    UV32_g2552 = off.yw;
			    W02_g2552 = s.x / ( s.x + s.y );
			 W12_g2552 = s.z / ( s.z + s.w );
			}
			}
			float RNM_Scale447_g2537 = _RNMScale;
			float temp_output_239_0_g2552 = RNM_Scale447_g2537;
			float3 lerpResult46_g2552 = lerp( UnpackScaleNormal( tex2D( _NormalMap, UV32_g2552 ), temp_output_239_0_g2552 ) , UnpackScaleNormal( tex2D( _NormalMap, UV22_g2552 ), temp_output_239_0_g2552 ) , W02_g2552);
			float3 lerpResult45_g2552 = lerp( UnpackScaleNormal( tex2D( _NormalMap, UV12_g2552 ), temp_output_239_0_g2552 ) , UnpackScaleNormal( tex2D( _NormalMap, UV02_g2552 ), temp_output_239_0_g2552 ) , W02_g2552);
			float3 lerpResult44_g2552 = lerp( lerpResult46_g2552 , lerpResult45_g2552 , W12_g2552);
			float3 Output_2D131_g2552 = lerpResult44_g2552;
			float3 normalizeResult326_g2551 = normalize( Output_2D131_g2552 );
			float3 Normal_Map318_g2551 = normalizeResult326_g2551;
			float dotResult121_g2551 = dot( appendResult139_g2551 , Normal_Map318_g2551 );
			float localStochasticTiling2_g2542 = ( 0.0 );
			float2 uv3_RNMX1 = i.uv3_texcoord3 * _RNMX1_ST.xy + _RNMX1_ST.zw;
			float2 UV2_g2542 = uv3_RNMX1;
			float4 TexelSize2_g2542 = _RNMX1_TexelSize;
			float4 Offsets2_g2542 = float4( 0,0,0,0 );
			float2 Weights2_g2542 = float2( 0,0 );
			{
			UV2_g2542 = UV2_g2542 * TexelSize2_g2542.zw - 0.5;
			float2 f = frac( UV2_g2542 );
			UV2_g2542 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g2542.x - 0.5, UV2_g2542.x + 1.5, UV2_g2542.y - 0.5, UV2_g2542.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g2542 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g2542.xyxy;
			Weights2_g2542 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g2539 = Offsets2_g2542;
			float4 Input_FetchOffsets197_g2543 = temp_output_1_34_g2539;
			float2 temp_output_1_54_g2539 = Weights2_g2542;
			float2 Input_FetchWeights200_g2543 = temp_output_1_54_g2539;
			float2 break187_g2543 = Input_FetchWeights200_g2543;
			float4 lerpResult181_g2543 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g2543).yw ) , tex2D( _RNMX1, (Input_FetchOffsets197_g2543).xw ) , break187_g2543.x);
			float4 lerpResult182_g2543 = lerp( tex2D( _RNMX1, (Input_FetchOffsets197_g2543).yz ) , tex2D( _RNMX1, (Input_FetchOffsets197_g2543).xz ) , break187_g2543.x);
			float4 lerpResult176_g2543 = lerp( lerpResult181_g2543 , lerpResult182_g2543 , break187_g2543.y);
			float4 Output_Fetch2D202_g2543 = lerpResult176_g2543;
			float3 appendResult146_g2551 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g2551 = dot( appendResult146_g2551 , Normal_Map318_g2551 );
			float4 Input_FetchOffsets197_g2540 = temp_output_1_34_g2539;
			float2 Input_FetchWeights200_g2540 = temp_output_1_54_g2539;
			float2 break187_g2540 = Input_FetchWeights200_g2540;
			float4 lerpResult181_g2540 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g2540).yw ) , tex2D( _RNMY1, (Input_FetchOffsets197_g2540).xw ) , break187_g2540.x);
			float4 lerpResult182_g2540 = lerp( tex2D( _RNMY1, (Input_FetchOffsets197_g2540).yz ) , tex2D( _RNMY1, (Input_FetchOffsets197_g2540).xz ) , break187_g2540.x);
			float4 lerpResult176_g2540 = lerp( lerpResult181_g2540 , lerpResult182_g2540 , break187_g2540.y);
			float4 Output_Fetch2D202_g2540 = lerpResult176_g2540;
			float3 appendResult149_g2551 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g2551 = dot( appendResult149_g2551 , Normal_Map318_g2551 );
			float4 Input_FetchOffsets197_g2541 = temp_output_1_34_g2539;
			float2 Input_FetchWeights200_g2541 = temp_output_1_54_g2539;
			float2 break187_g2541 = Input_FetchWeights200_g2541;
			float4 lerpResult181_g2541 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g2541).yw ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g2541).xw ) , break187_g2541.x);
			float4 lerpResult182_g2541 = lerp( tex2D( _RNMZ1, (Input_FetchOffsets197_g2541).yz ) , tex2D( _RNMZ1, (Input_FetchOffsets197_g2541).xz ) , break187_g2541.x);
			float4 lerpResult176_g2541 = lerp( lerpResult181_g2541 , lerpResult182_g2541 , break187_g2541.y);
			float4 Output_Fetch2D202_g2541 = lerpResult176_g2541;
			float4 lerpResult442_g2537 = lerp( temp_output_590_0_g2537 , ( ( ( saturate( dotResult121_g2551 ) * ( Output_Fetch2D202_g2543 * 0.5 ) ) + ( saturate( dotResult122_g2551 ) * ( Output_Fetch2D202_g2540 * 0.5 ) ) ) + ( saturate( dotResult120_g2551 ) * ( Output_Fetch2D202_g2541 * 0.5 ) ) ) , _LightmapLerp);
			#if defined( _LIGHTMAPPINGMODE_SIMPLE )
				float4 staticSwitch565_g2537 = Output_2D131_g2550;
			#elif defined( _LIGHTMAPPINGMODE_RNM )
				float4 staticSwitch565_g2537 = temp_output_590_0_g2537;
			#elif defined( _LIGHTMAPPINGMODE_RNMLERP )
				float4 staticSwitch565_g2537 = lerpResult442_g2537;
			#else
				float4 staticSwitch565_g2537 = Output_2D131_g2550;
			#endif
			#ifdef _LIGHTMAPPING_ON
				float4 staticSwitch569_g2537 = staticSwitch565_g2537;
			#else
				float4 staticSwitch569_g2537 = temp_cast_3;
			#endif
			float4 Lightmap46_g2537 = staticSwitch569_g2537;
			#ifdef _LIGHTMAPPING_ON
				float4 staticSwitch566_g2537 = ( ( float4( Albedo6_g2537 , 0.0 ) * Lightmap46_g2537 ) + float4( Emission86_g2537 , 0.0 ) );
			#else
				float4 staticSwitch566_g2537 = float4( Emission86_g2537 , 0.0 );
			#endif
			o.Emission = staticSwitch566_g2537.rgb;
			float2 uv_MetallicMap = i.uv_texcoord * _MetallicMap_ST.xy + _MetallicMap_ST.zw;
			float3 Metallic54_g2537 = ( _Metallic * tex2D( _MetallicMap, uv_MetallicMap ).rgb );
			o.Metallic = Metallic54_g2537.x;
			float2 uv_EmissionMap164_g2537 = i.uv_texcoord;
			float4 temp_output_70_0_g2537 = ( _Glossiness * ( 1.0 - tex2D( _EmissionMap1, uv_EmissionMap164_g2537 ) ) );
			o.Smoothness = temp_output_70_0_g2537.r;
			float4 temp_cast_8 = White38_g2537;
			float4 temp_cast_9 = White38_g2537;
			float4 saferPower606_g2537 = abs( Lightmap46_g2537 );
			float4 temp_cast_10 = (_OcclusionPower).xxxx;
			float4 clampResult579_g2537 = clamp( pow( saferPower606_g2537 , temp_cast_10 ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			#ifdef _LIGHTMAPOCCLUSION_ON
				float4 staticSwitch573_g2537 = clampResult579_g2537;
			#else
				float4 staticSwitch573_g2537 = temp_cast_9;
			#endif
			#ifdef _LIGHTMAPPING_ON
				float4 staticSwitch576_g2537 = staticSwitch573_g2537;
			#else
				float4 staticSwitch576_g2537 = temp_cast_8;
			#endif
			o.Occlusion = staticSwitch576_g2537.r;
			o.Alpha = ( tex2DNode259_g2537.a * _Color.a );
		}

		ENDCG
	}
	Fallback "Fairplex/Standard Mobile"
	CustomEditor "Meenphie_ShaderGUI"
}
/*ASEBEGIN
Version=19801
Node;AmplifyShaderEditor.FunctionNode;2643;0,-1200;Inherit;False;Meenphie Default;0;;2537;b3ba55a08dd6b49c7be16c6f35cf2033;0;0;8;FLOAT3;625;FLOAT3;238;COLOR;624;FLOAT3;96;COLOR;97;COLOR;95;FLOAT;156;FLOAT;427
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;1092;512,-1200;Float;False;True;-1;3;Meenphie_ShaderGUI;0;0;Standard;Meenphie/RNM/Transparent;False;False;False;False;True;False;False;True;True;False;False;False;False;False;True;True;False;False;True;True;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;ForwardOnly;3;d3d11;glcore;vulkan;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;2;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0.0001;0,0,0,0;VertexOffset;False;False;Cylindrical;False;True;Relative;0;Fairplex/Standard Mobile;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;1092;0;2643;625
WireConnection;1092;1;2643;238
WireConnection;1092;2;2643;624
WireConnection;1092;3;2643;96
WireConnection;1092;4;2643;97
WireConnection;1092;5;2643;95
WireConnection;1092;9;2643;156
ASEEND*/
//CHKSM=D7F375B46815278BF6625878C043ECD138C6480E