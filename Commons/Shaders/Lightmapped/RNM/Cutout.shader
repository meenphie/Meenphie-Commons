// Made with Amplify Shader Editor v1.9.9.4
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Lightmapped/RNM/Cutout"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		[Meenphie_DrawerCategory(SURFACE OPTIONS,true,0,0)] _CATEGORY_SURFACEOPTIONS( "CATEGORY_SURFACEOPTIONS", Float ) = 1
		_Color( "DIffuse Color", Color ) = ( 0.9058824, 0.9058824, 0.9058824, 1 )
		[NoScaleOffset][Meenphie_DrawerTextureSingleLine] _MainTex( "Diffuse Map", 2D ) = "white" {}
		[NoScaleOffset][Meenphie_DrawerTextureSingleLine] _BumpMap( "Normal Map", 2D ) = "bump" {}
		[Meenphie_DrawerTextureSingleLine] _MetallicMap( "Metallic Map", 2D ) = "white" {}
		[NoScaleOffset][Meenphie_DrawerTextureSingleLine] _GlossinessMap( "Roughness Map", 2D ) = "black" {}
		_NormalScale( "Normal Scale", Float ) = 1
		_Metallic( "Metallic", Range( 0, 1 ) ) = 0
		_Glossiness( "Smoothness", Range( 0, 1 ) ) = 0.5
		[Toggle( _USEGEOMETRICANTIALIASING_ON )] _UseGeometricAntiAliasing( "Use Geometric Anti Aliasing", Float ) = 1
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESURFACEOPTIONS( "CATEGORY SPACE SURFACEOPTIONS", Float ) = 0
		[Meenphie_DrawerCategory(EMISSION,true,0,0)] _CATEGORYEMISSION( "CATEGORY EMISSION", Float ) = 0
		[Toggle( _EMISSION_ON )] _EMISSION( "Emission Enabled", Float ) = 0
		[HDR][Gamma] _EmissionColor( "Emission Color", Color ) = ( 0, 0, 0 )
		[NoScaleOffset][Meenphie_DrawerTextureSingleLine] _EmissionMap( "Emission Map", 2D ) = "black" {}
		[Meenphie_DrawerEmissionFlags] _EmissionFlags( "Global Illumination", Float ) = 2
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACEEMISSION( "CATEGORY SPACE EMISSION", Float ) = 0
		[Meenphie_DrawerCategory(LIGHTMAPPING,true,0,0)] _CATEGORYLIGHTMAPPING( "CATEGORY LIGHTMAPPING", Float ) = 0
		[Meenphie_DrawerTextureSingleLine] _RNMX0( "RNMX 0", 2D ) = "black" {}
		[Meenphie_DrawerTextureSingleLine] _RNMY0( "RNMY 0", 2D ) = "black" {}
		[Meenphie_DrawerTextureSingleLine] _RNMZ0( "RNMZ 0", 2D ) = "black" {}
		[Toggle( _LIGHTMAPOCCLUSION_ON )] _LightmapOcclusion( "Lightmap Occlusion", Float ) = 1
		_OcclusionPower( "Occlusion Power", Float ) = 1
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACELIGHTMAPPING( "CATEGORY SPACE LIGHTMAPPING", Float ) = 0
		[HideInInspector] _texcoord3( "", 2D ) = "white" {}
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0
		[HideInInspector] GenKey__MetallicMap( "Assign keyword _METALLICMAP", Float ) = 1.0
		[HideInInspector] GenKey__GlossinessMap( "Assign keyword _GLOSSINESSMAP", Float ) = 1.0
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
		uniform float _CATEGORYEMISSION;
		uniform float _CATEGORYSPACEEMISSION;
		uniform float _EmissionFlags;
		uniform sampler2D _BumpMap;
		uniform float _NormalScale;
		uniform float4 _Color;
		uniform sampler2D _MainTex;
		uniform float3 _EmissionColor;
		uniform sampler2D _EmissionMap;
		uniform float _Metallic;
		uniform sampler2D _RNMX0;
		uniform float4 _RNMX0_ST;
		float4 _RNMX0_TexelSize;
		uniform sampler2D _RNMY0;
		uniform sampler2D _RNMZ0;
		uniform float _CATEGORYLIGHTMAPPING;
		uniform float _CATEGORYSPACELIGHTMAPPING;
		uniform sampler2D _MetallicMap;
		uniform float4 _MetallicMap_ST;
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
			float2 uv_MainTex259_g1986 = i.uv_texcoord;
			float4 tex2DNode259_g1986 = tex2D( _MainTex, uv_MainTex259_g1986 );
			float3 temp_output_5_0_g1986 = ( _Color.rgb * tex2DNode259_g1986.rgb );
			o.Albedo = temp_output_5_0_g1986;
			float3 temp_cast_0 = 0;
			float2 uv_EmissionMap81_g1986 = i.uv_texcoord;
			#ifdef _EMISSION_ON
				float3 staticSwitch851_g1986 = ( _EmissionColor + tex2D( _EmissionMap, uv_EmissionMap81_g1986 ).rgb );
			#else
				float3 staticSwitch851_g1986 = temp_cast_0;
			#endif
			float3 Emission86_g1986 = staticSwitch851_g1986;
			float3 Albedo6_g1986 = temp_output_5_0_g1986;
			float Metallic_Value893_g1986 = _Metallic;
			float3 appendResult139_g1988 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float3 normalizeResult326_g1988 = normalize( Normal_Map700_g1986 );
			float3 Normal_Map318_g1988 = normalizeResult326_g1988;
			float dotResult121_g1988 = dot( appendResult139_g1988 , Normal_Map318_g1988 );
			float localStochasticTiling2_g1996 = ( 0.0 );
			float2 uv3_RNMX0 = i.uv3_texcoord3 * _RNMX0_ST.xy + _RNMX0_ST.zw;
			float2 UV2_g1996 = uv3_RNMX0;
			float4 TexelSize2_g1996 = _RNMX0_TexelSize;
			float4 Offsets2_g1996 = float4( 0,0,0,0 );
			float2 Weights2_g1996 = float2( 0,0 );
			{
			UV2_g1996 = UV2_g1996 * TexelSize2_g1996.zw - 0.5;
			float2 f = frac( UV2_g1996 );
			UV2_g1996 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g1996.x - 0.5, UV2_g1996.x + 1.5, UV2_g1996.y - 0.5, UV2_g1996.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g1996 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1996.xyxy;
			Weights2_g1996 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g1995 = Offsets2_g1996;
			float4 Input_FetchOffsets197_g1999 = temp_output_1_34_g1995;
			float2 temp_output_1_54_g1995 = Weights2_g1996;
			float2 Input_FetchWeights200_g1999 = temp_output_1_54_g1995;
			float2 break187_g1999 = Input_FetchWeights200_g1999;
			float4 lerpResult181_g1999 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g1999).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g1999).xw ) , break187_g1999.x);
			float4 lerpResult182_g1999 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g1999).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g1999).xz ) , break187_g1999.x);
			float4 lerpResult176_g1999 = lerp( lerpResult181_g1999 , lerpResult182_g1999 , break187_g1999.y);
			float4 Output_Fetch2D202_g1999 = lerpResult176_g1999;
			float3 appendResult146_g1988 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g1988 = dot( appendResult146_g1988 , Normal_Map318_g1988 );
			float4 Input_FetchOffsets197_g1997 = temp_output_1_34_g1995;
			float2 Input_FetchWeights200_g1997 = temp_output_1_54_g1995;
			float2 break187_g1997 = Input_FetchWeights200_g1997;
			float4 lerpResult181_g1997 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g1997).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g1997).xw ) , break187_g1997.x);
			float4 lerpResult182_g1997 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g1997).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g1997).xz ) , break187_g1997.x);
			float4 lerpResult176_g1997 = lerp( lerpResult181_g1997 , lerpResult182_g1997 , break187_g1997.y);
			float4 Output_Fetch2D202_g1997 = lerpResult176_g1997;
			float3 appendResult149_g1988 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g1988 = dot( appendResult149_g1988 , Normal_Map318_g1988 );
			float4 Input_FetchOffsets197_g1998 = temp_output_1_34_g1995;
			float2 Input_FetchWeights200_g1998 = temp_output_1_54_g1995;
			float2 break187_g1998 = Input_FetchWeights200_g1998;
			float4 lerpResult181_g1998 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g1998).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g1998).xw ) , break187_g1998.x);
			float4 lerpResult182_g1998 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g1998).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g1998).xz ) , break187_g1998.x);
			float4 lerpResult176_g1998 = lerp( lerpResult181_g1998 , lerpResult182_g1998 , break187_g1998.y);
			float4 Output_Fetch2D202_g1998 = lerpResult176_g1998;
			float4 temp_output_838_0_g1986 = ( ( ( saturate( dotResult121_g1988 ) * ( Output_Fetch2D202_g1999 * 1.0 ) ) + ( saturate( dotResult122_g1988 ) * ( Output_Fetch2D202_g1997 * 1.0 ) ) ) + ( saturate( dotResult120_g1988 ) * ( Output_Fetch2D202_g1998 * 1.0 ) ) );
			float Lightmap_GUI886_g1986 = ( _CATEGORYLIGHTMAPPING + _CATEGORYSPACELIGHTMAPPING );
			float4 temp_cast_3 = (Lightmap_GUI886_g1986).xxxx;
			float4 lerpResult882_g1986 = lerp( temp_output_838_0_g1986 , temp_cast_3 , float4( 0,0,0,0 ));
			float4 Lightmap46_g1986 = lerpResult882_g1986;
			float4 temp_output_614_0_g1986 = ( float4( Albedo6_g1986 , 0.0 ) * ( ( 1.0 - Metallic_Value893_g1986 ) * Lightmap46_g1986 ) );
			o.Emission = ( float4( Emission86_g1986 , 0.0 ) + temp_output_614_0_g1986 ).rgb;
			float2 uv_MetallicMap = i.uv_texcoord * _MetallicMap_ST.xy + _MetallicMap_ST.zw;
			float saferPower803_g1986 = abs( tex2D( _MetallicMap, uv_MetallicMap ).a );
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
			clip( tex2DNode259_g1986.a - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19904
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;840;192,-1200;Inherit;False;Meenphie;1;;1986;b3ba55a08dd6b49c7be16c6f35cf2033;5,869,1,872,1,871,1,847,1,867,0;0;9;FLOAT3;625;FLOAT3;238;COLOR;624;FLOAT;96;FLOAT;97;FLOAT;95;FLOAT;156;FLOAT;427;FLOAT3;860
Node;AmplifyShaderEditor.StandardSurfaceOutputNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;343;512,-1200;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;0;Standard;Meenphie/Lightmapped/RNM/Cutout;False;False;False;False;False;False;False;True;True;False;False;False;False;False;True;True;False;False;True;True;False;Off;0;False;;0;False;;False;0;False;;0;False;;False;0;Masked;0.5;True;False;0;False;TransparentCutout;;AlphaTest;ForwardOnly;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0.0001;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;343;0;840;625
WireConnection;343;1;840;238
WireConnection;343;2;840;624
WireConnection;343;3;840;96
WireConnection;343;4;840;97
WireConnection;343;5;840;95
WireConnection;343;10;840;427
ASEEND*/
//CHKSM=3232CEA18673A4436B2405BF5E8A12F66C1F5A9C