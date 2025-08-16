// Made with Amplify Shader Editor v1.9.9.3
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/RNM/Opaque"
{
	Properties
	{
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
		[Meenphie_DrawerCategory(EMISSION,true,0,0)] _CATEGORYEMISSION( "CATEGORY EMISSION", Float ) = 1
		[Toggle( _EMISSION_ON )] _EMISSION( "Emission Enabled", Float ) = 0
		[HDR][Gamma] _EmissionColor( "Emission Color", Color ) = ( 0, 0, 0 )
		[NoScaleOffset][Meenphie_DrawerTextureSingleLine] _EmissionMap( "Emission Map", 2D ) = "black" {}
		[Meenphie_DrawerEmissionFlags] _EmissionFlags( "Global Illumination", Float ) = 2
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACEEMISSION( "CATEGORY SPACE EMISSION", Float ) = 0
		[Meenphie_DrawerCategory(LIGHTMAPPING,true,0,0)] _CATEGORYLIGHTMAPPING( "CATEGORY LIGHTMAPPING", Float ) = 1
		[Toggle( _LIGHTMAPPING_ON )] _LIGHTMAPPING( "Lightmapping Enabled", Float ) = 1
		[Meenphie_DrawerTextureSingleLine] _RNMX0( "RNMX 0", 2D ) = "gray" {}
		[Meenphie_DrawerTextureSingleLine] _RNMY0( "RNMY 0", 2D ) = "gray" {}
		[Meenphie_DrawerTextureSingleLine] _RNMZ0( "RNMZ 0", 2D ) = "gray" {}
		[Toggle( _LIGHTMAPOCCLUSION_ON )] _LightmapOcclusion( "Lightmap Occlusion", Float ) = 1
		_OcclusionPower( "Occlusion Power", Float ) = 0.5
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACELIGHTMAPPING( "CATEGORY SPACE LIGHTMAPPING", Float ) = 0
		[HideInInspector] _texcoord3( "", 2D ) = "white" {}
		[HideInInspector] GenKey__MetallicMap( "Assign keyword _METALLICMAP", Float ) = 1.0
		[HideInInspector] GenKey__GlossinessMap( "Assign keyword _GLOSSINESSMAP", Float ) = 1.0
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
		#pragma shader_feature_local_fragment _LIGHTMAPPING_ON
		#pragma shader_feature_local_fragment _EMISSION_ON
		#pragma shader_feature_local_fragment _METALLICMAP
		#pragma shader_feature_local_fragment _USEGEOMETRICANTIALIASING_ON
		#pragma shader_feature_local_fragment _GLOSSINESSMAP
		#pragma shader_feature_local_fragment _LIGHTMAPOCCLUSION_ON
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
		uniform sampler2D _BumpMap;
		uniform float _NormalScale;
		uniform float4 _Color;
		uniform sampler2D _MainTex;
		uniform float3 _EmissionColor;
		uniform sampler2D _EmissionMap;
		uniform sampler2D _RNMX0;
		uniform float4 _RNMX0_ST;
		float4 _RNMX0_TexelSize;
		uniform sampler2D _RNMY0;
		uniform sampler2D _RNMZ0;
		uniform float _Metallic;
		uniform sampler2D _MetallicMap;
		uniform float4 _MetallicMap_ST;
		uniform float _Glossiness;
		uniform sampler2D _GlossinessMap;
		uniform float _OcclusionPower;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BumpMap830_g520 = i.uv_texcoord;
			#ifdef _BUMPMAP
				float3 staticSwitch844_g520 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap830_g520 ), _NormalScale );
			#else
				float3 staticSwitch844_g520 = float3( 0, 0, 1 );
			#endif
			float3 Normal_Map700_g520 = staticSwitch844_g520;
			o.Normal = Normal_Map700_g520;
			float2 uv_MainTex259_g520 = i.uv_texcoord;
			float4 tex2DNode259_g520 = tex2D( _MainTex, uv_MainTex259_g520 );
			float3 temp_output_5_0_g520 = ( _Color.rgb * tex2DNode259_g520.rgb );
			o.Albedo = temp_output_5_0_g520;
			float3 temp_cast_0 = 0;
			float2 uv_EmissionMap81_g520 = i.uv_texcoord;
			float3 Emission86_g520 = ( _EmissionColor + tex2D( _EmissionMap, uv_EmissionMap81_g520 ).rgb );
			#ifdef _EMISSION_ON
				float3 staticSwitch572_g520 = Emission86_g520;
			#else
				float3 staticSwitch572_g520 = temp_cast_0;
			#endif
			float3 Albedo6_g520 = temp_output_5_0_g520;
			int White38_g520 = 1;
			float3 temp_cast_1 = White38_g520;
			float3 appendResult139_g522 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float3 normalizeResult326_g522 = normalize( Normal_Map700_g520 );
			float3 Normal_Map318_g522 = normalizeResult326_g522;
			float dotResult121_g522 = dot( appendResult139_g522 , Normal_Map318_g522 );
			float localStochasticTiling2_g524 = ( 0.0 );
			float2 uv3_RNMX0 = i.uv3_texcoord3 * _RNMX0_ST.xy + _RNMX0_ST.zw;
			float2 UV2_g524 = uv3_RNMX0;
			float4 TexelSize2_g524 = _RNMX0_TexelSize;
			float4 Offsets2_g524 = float4( 0,0,0,0 );
			float2 Weights2_g524 = float2( 0,0 );
			{
			UV2_g524 = UV2_g524 * TexelSize2_g524.zw - 0.5;
			float2 f = frac( UV2_g524 );
			UV2_g524 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g524.x - 0.5, UV2_g524.x + 1.5, UV2_g524.y - 0.5, UV2_g524.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g524 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g524.xyxy;
			Weights2_g524 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g523 = Offsets2_g524;
			float4 Input_FetchOffsets197_g527 = temp_output_1_34_g523;
			float2 temp_output_1_54_g523 = Weights2_g524;
			float2 Input_FetchWeights200_g527 = temp_output_1_54_g523;
			float2 break187_g527 = Input_FetchWeights200_g527;
			float3 lerpResult181_g527 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g527).yw ).rgb , tex2D( _RNMX0, (Input_FetchOffsets197_g527).xw ).rgb , break187_g527.x);
			float3 lerpResult182_g527 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g527).yz ).rgb , tex2D( _RNMX0, (Input_FetchOffsets197_g527).xz ).rgb , break187_g527.x);
			float3 lerpResult176_g527 = lerp( lerpResult181_g527 , lerpResult182_g527 , break187_g527.y);
			float3 Output_Fetch2D202_g527 = lerpResult176_g527;
			float3 appendResult146_g522 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g522 = dot( appendResult146_g522 , Normal_Map318_g522 );
			float4 Input_FetchOffsets197_g525 = temp_output_1_34_g523;
			float2 Input_FetchWeights200_g525 = temp_output_1_54_g523;
			float2 break187_g525 = Input_FetchWeights200_g525;
			float3 lerpResult181_g525 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g525).yw ).rgb , tex2D( _RNMY0, (Input_FetchOffsets197_g525).xw ).rgb , break187_g525.x);
			float3 lerpResult182_g525 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g525).yz ).rgb , tex2D( _RNMY0, (Input_FetchOffsets197_g525).xz ).rgb , break187_g525.x);
			float3 lerpResult176_g525 = lerp( lerpResult181_g525 , lerpResult182_g525 , break187_g525.y);
			float3 Output_Fetch2D202_g525 = lerpResult176_g525;
			float3 appendResult149_g522 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g522 = dot( appendResult149_g522 , Normal_Map318_g522 );
			float4 Input_FetchOffsets197_g526 = temp_output_1_34_g523;
			float2 Input_FetchWeights200_g526 = temp_output_1_54_g523;
			float2 break187_g526 = Input_FetchWeights200_g526;
			float3 lerpResult181_g526 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g526).yw ).rgb , tex2D( _RNMZ0, (Input_FetchOffsets197_g526).xw ).rgb , break187_g526.x);
			float3 lerpResult182_g526 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g526).yz ).rgb , tex2D( _RNMZ0, (Input_FetchOffsets197_g526).xz ).rgb , break187_g526.x);
			float3 lerpResult176_g526 = lerp( lerpResult181_g526 , lerpResult182_g526 , break187_g526.y);
			float3 Output_Fetch2D202_g526 = lerpResult176_g526;
			float3 temp_output_838_0_g520 = ( ( ( saturate( dotResult121_g522 ) * ( Output_Fetch2D202_g527 * 1.0 ) ) + ( saturate( dotResult122_g522 ) * ( Output_Fetch2D202_g525 * 1.0 ) ) ) + ( saturate( dotResult120_g522 ) * ( Output_Fetch2D202_g526 * 1.0 ) ) );
			#ifdef _LIGHTMAPPING_ON
				float3 staticSwitch569_g520 = temp_output_838_0_g520;
			#else
				float3 staticSwitch569_g520 = temp_cast_1;
			#endif
			float3 Lightmap46_g520 = staticSwitch569_g520;
			#ifdef _LIGHTMAPPING_ON
				float3 staticSwitch566_g520 = ( Albedo6_g520 * Lightmap46_g520 );
			#else
				float3 staticSwitch566_g520 = Albedo6_g520;
			#endif
			#ifdef _LIGHTMAPPING_ON
				float3 staticSwitch696_g520 = ( staticSwitch572_g520 + staticSwitch566_g520 );
			#else
				float3 staticSwitch696_g520 = ( staticSwitch572_g520 * staticSwitch566_g520 );
			#endif
			o.Emission = staticSwitch696_g520;
			float2 uv_MetallicMap = i.uv_texcoord * _MetallicMap_ST.xy + _MetallicMap_ST.zw;
			float saferPower803_g520 = abs( tex2D( _MetallicMap, uv_MetallicMap ).a );
			#ifdef _METALLICMAP
				float staticSwitch846_g520 = pow( saferPower803_g520 , 3.0 );
			#else
				float staticSwitch846_g520 = _Metallic;
			#endif
			float Metallic699_g520 = staticSwitch846_g520;
			o.Metallic = Metallic699_g520;
			float2 uv_GlossinessMap64_g520 = i.uv_texcoord;
			float saferPower804_g520 = abs( tex2D( _GlossinessMap, uv_GlossinessMap64_g520 ).a );
			#ifdef _GLOSSINESSMAP
				float staticSwitch845_g520 = ( 1.0 - pow( saferPower804_g520 , 3.0 ) );
			#else
				float staticSwitch845_g520 = _Glossiness;
			#endif
			float3 ase_normalWS = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 temp_output_3_0_g521 = ddx( ase_normalWS );
			float dotResult5_g521 = dot( temp_output_3_0_g521 , temp_output_3_0_g521 );
			float3 temp_output_4_0_g521 = ddy( ase_normalWS );
			float dotResult6_g521 = dot( temp_output_4_0_g521 , temp_output_4_0_g521 );
			#ifdef _USEGEOMETRICANTIALIASING_ON
				float staticSwitch824_g520 = min( staticSwitch845_g520 , ( 1.0 - pow( saturate( max( dotResult5_g521 , dotResult6_g521 ) ) , 0.333 ) ) );
			#else
				float staticSwitch824_g520 = staticSwitch845_g520;
			#endif
			o.Smoothness = staticSwitch824_g520;
			float dotResult835_g520 = dot( Lightmap46_g520 , float3( 0.299, 0.587, 0.114 ) );
			float saferPower606_g520 = abs( dotResult835_g520 );
			#ifdef _LIGHTMAPOCCLUSION_ON
				float staticSwitch573_g520 = pow( saferPower606_g520 , _OcclusionPower );
			#else
				float staticSwitch573_g520 = (float)White38_g520;
			#endif
			#ifdef _LIGHTMAPPING_ON
				float staticSwitch576_g520 = staticSwitch573_g520;
			#else
				float staticSwitch576_g520 = (float)White38_g520;
			#endif
			o.Occlusion = staticSwitch576_g520;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19903
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2794;192,-1200;Inherit;False;RNM;0;;520;b3ba55a08dd6b49c7be16c6f35cf2033;1,847,1;0;8;FLOAT3;625;FLOAT3;238;FLOAT3;624;FLOAT;96;FLOAT;97;FLOAT;95;FLOAT;156;FLOAT;427
Node;AmplifyShaderEditor.StandardSurfaceOutputNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1092;512,-1200;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;0;Standard;Meenphie/RNM/Opaque;False;False;False;False;True;False;False;True;True;False;False;False;False;False;False;True;False;False;True;True;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;ForwardOnly;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0.0001;0,0,0,0;VertexOffset;False;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;1092;0;2794;625
WireConnection;1092;1;2794;238
WireConnection;1092;2;2794;624
WireConnection;1092;3;2794;96
WireConnection;1092;4;2794;97
WireConnection;1092;5;2794;95
ASEEND*/
//CHKSM=689776CD4513F18467CFCC1F136AD15BB41D871D