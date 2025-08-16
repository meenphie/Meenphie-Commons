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
		[HideInInspector] GenKey__GlossinessMap( "Assign keyword _GLOSSINESSMAP", Float ) = 1.0
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0
		[HideInInspector] GenKey__MetallicMap( "Assign keyword _METALLICMAP", Float ) = 1.0
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
		#pragma shader_feature_local _LIGHTMAPPING_ON
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
		uniform sampler2D _RNMX0;
		uniform float4 _RNMX0_ST;
		float4 _RNMX0_TexelSize;
		uniform sampler2D _RNMY0;
		uniform sampler2D _RNMZ0;
		uniform float3 _EmissionColor;
		uniform sampler2D _EmissionMap;
		uniform float _Metallic;
		uniform sampler2D _MetallicMap;
		uniform float4 _MetallicMap_ST;
		uniform float _Glossiness;
		uniform sampler2D _GlossinessMap;
		uniform float _OcclusionPower;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BumpMap830_g904 = i.uv_texcoord;
			#ifdef _BUMPMAP
				float3 staticSwitch844_g904 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap830_g904 ), _NormalScale );
			#else
				float3 staticSwitch844_g904 = float3( 0, 0, 1 );
			#endif
			float3 Normal_Map700_g904 = staticSwitch844_g904;
			o.Normal = Normal_Map700_g904;
			float2 uv_MainTex259_g904 = i.uv_texcoord;
			float4 tex2DNode259_g904 = tex2D( _MainTex, uv_MainTex259_g904 );
			float3 temp_output_5_0_g904 = ( _Color.rgb * tex2DNode259_g904.rgb );
			o.Albedo = temp_output_5_0_g904;
			float3 Albedo6_g904 = temp_output_5_0_g904;
			int White38_g904 = 1;
			float3 temp_cast_0 = White38_g904;
			float3 appendResult139_g906 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float3 normalizeResult326_g906 = normalize( Normal_Map700_g904 );
			float3 Normal_Map318_g906 = normalizeResult326_g906;
			float dotResult121_g906 = dot( appendResult139_g906 , Normal_Map318_g906 );
			float localStochasticTiling2_g908 = ( 0.0 );
			float2 uv3_RNMX0 = i.uv3_texcoord3 * _RNMX0_ST.xy + _RNMX0_ST.zw;
			float2 UV2_g908 = uv3_RNMX0;
			float4 TexelSize2_g908 = _RNMX0_TexelSize;
			float4 Offsets2_g908 = float4( 0,0,0,0 );
			float2 Weights2_g908 = float2( 0,0 );
			{
			UV2_g908 = UV2_g908 * TexelSize2_g908.zw - 0.5;
			float2 f = frac( UV2_g908 );
			UV2_g908 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g908.x - 0.5, UV2_g908.x + 1.5, UV2_g908.y - 0.5, UV2_g908.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g908 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g908.xyxy;
			Weights2_g908 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g907 = Offsets2_g908;
			float4 Input_FetchOffsets197_g911 = temp_output_1_34_g907;
			float2 temp_output_1_54_g907 = Weights2_g908;
			float2 Input_FetchWeights200_g911 = temp_output_1_54_g907;
			float2 break187_g911 = Input_FetchWeights200_g911;
			float3 lerpResult181_g911 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g911).yw ).rgb , tex2D( _RNMX0, (Input_FetchOffsets197_g911).xw ).rgb , break187_g911.x);
			float3 lerpResult182_g911 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g911).yz ).rgb , tex2D( _RNMX0, (Input_FetchOffsets197_g911).xz ).rgb , break187_g911.x);
			float3 lerpResult176_g911 = lerp( lerpResult181_g911 , lerpResult182_g911 , break187_g911.y);
			float3 Output_Fetch2D202_g911 = lerpResult176_g911;
			float3 appendResult146_g906 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g906 = dot( appendResult146_g906 , Normal_Map318_g906 );
			float4 Input_FetchOffsets197_g909 = temp_output_1_34_g907;
			float2 Input_FetchWeights200_g909 = temp_output_1_54_g907;
			float2 break187_g909 = Input_FetchWeights200_g909;
			float3 lerpResult181_g909 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g909).yw ).rgb , tex2D( _RNMY0, (Input_FetchOffsets197_g909).xw ).rgb , break187_g909.x);
			float3 lerpResult182_g909 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g909).yz ).rgb , tex2D( _RNMY0, (Input_FetchOffsets197_g909).xz ).rgb , break187_g909.x);
			float3 lerpResult176_g909 = lerp( lerpResult181_g909 , lerpResult182_g909 , break187_g909.y);
			float3 Output_Fetch2D202_g909 = lerpResult176_g909;
			float3 appendResult149_g906 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g906 = dot( appendResult149_g906 , Normal_Map318_g906 );
			float4 Input_FetchOffsets197_g910 = temp_output_1_34_g907;
			float2 Input_FetchWeights200_g910 = temp_output_1_54_g907;
			float2 break187_g910 = Input_FetchWeights200_g910;
			float3 lerpResult181_g910 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g910).yw ).rgb , tex2D( _RNMZ0, (Input_FetchOffsets197_g910).xw ).rgb , break187_g910.x);
			float3 lerpResult182_g910 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g910).yz ).rgb , tex2D( _RNMZ0, (Input_FetchOffsets197_g910).xz ).rgb , break187_g910.x);
			float3 lerpResult176_g910 = lerp( lerpResult181_g910 , lerpResult182_g910 , break187_g910.y);
			float3 Output_Fetch2D202_g910 = lerpResult176_g910;
			float3 temp_output_838_0_g904 = ( ( ( saturate( dotResult121_g906 ) * ( Output_Fetch2D202_g911 * 1.0 ) ) + ( saturate( dotResult122_g906 ) * ( Output_Fetch2D202_g909 * 1.0 ) ) ) + ( saturate( dotResult120_g906 ) * ( Output_Fetch2D202_g910 * 1.0 ) ) );
			#ifdef _LIGHTMAPPING_ON
				float3 staticSwitch566_g904 = temp_output_838_0_g904;
			#else
				float3 staticSwitch566_g904 = temp_cast_0;
			#endif
			float3 Lightmap46_g904 = staticSwitch566_g904;
			float3 temp_output_614_0_g904 = ( Albedo6_g904 * Lightmap46_g904 );
			float3 temp_cast_1 = 0;
			float2 uv_EmissionMap81_g904 = i.uv_texcoord;
			#ifdef _EMISSION_ON
				float3 staticSwitch851_g904 = ( _EmissionColor + tex2D( _EmissionMap, uv_EmissionMap81_g904 ).rgb );
			#else
				float3 staticSwitch851_g904 = temp_cast_1;
			#endif
			float3 Emission86_g904 = staticSwitch851_g904;
			#ifdef _LIGHTMAPPING_ON
				float3 staticSwitch696_g904 = ( Emission86_g904 + temp_output_614_0_g904 );
			#else
				float3 staticSwitch696_g904 = ( temp_output_614_0_g904 * Emission86_g904 );
			#endif
			o.Emission = staticSwitch696_g904;
			float2 uv_MetallicMap = i.uv_texcoord * _MetallicMap_ST.xy + _MetallicMap_ST.zw;
			float saferPower803_g904 = abs( tex2D( _MetallicMap, uv_MetallicMap ).a );
			#ifdef _METALLICMAP
				float staticSwitch846_g904 = pow( saferPower803_g904 , 3.0 );
			#else
				float staticSwitch846_g904 = _Metallic;
			#endif
			float Metallic699_g904 = staticSwitch846_g904;
			o.Metallic = Metallic699_g904;
			float2 uv_GlossinessMap64_g904 = i.uv_texcoord;
			float saferPower804_g904 = abs( tex2D( _GlossinessMap, uv_GlossinessMap64_g904 ).a );
			#ifdef _GLOSSINESSMAP
				float staticSwitch845_g904 = ( 1.0 - pow( saferPower804_g904 , 3.0 ) );
			#else
				float staticSwitch845_g904 = _Glossiness;
			#endif
			float3 ase_normalWS = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 temp_output_3_0_g905 = ddx( ase_normalWS );
			float dotResult5_g905 = dot( temp_output_3_0_g905 , temp_output_3_0_g905 );
			float3 temp_output_4_0_g905 = ddy( ase_normalWS );
			float dotResult6_g905 = dot( temp_output_4_0_g905 , temp_output_4_0_g905 );
			#ifdef _USEGEOMETRICANTIALIASING_ON
				float staticSwitch824_g904 = min( staticSwitch845_g904 , ( 1.0 - pow( saturate( max( dotResult5_g905 , dotResult6_g905 ) ) , 0.333 ) ) );
			#else
				float staticSwitch824_g904 = staticSwitch845_g904;
			#endif
			o.Smoothness = staticSwitch824_g904;
			float dotResult835_g904 = dot( Lightmap46_g904 , float3( 0.299, 0.587, 0.114 ) );
			float saferPower606_g904 = abs( dotResult835_g904 );
			#ifdef _LIGHTMAPOCCLUSION_ON
				float staticSwitch573_g904 = pow( saferPower606_g904 , _OcclusionPower );
			#else
				float staticSwitch573_g904 = (float)White38_g904;
			#endif
			o.Occlusion = staticSwitch573_g904;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19903
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2818;192,-1200;Inherit;False;Meenphie;0;;904;b3ba55a08dd6b49c7be16c6f35cf2033;1,847,1;0;8;FLOAT3;625;FLOAT3;238;FLOAT3;624;FLOAT;96;FLOAT;97;FLOAT;95;FLOAT;156;FLOAT;427
Node;AmplifyShaderEditor.StandardSurfaceOutputNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1092;512,-1200;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;0;Standard;Meenphie/RNM/Opaque;False;False;False;False;True;False;False;True;True;False;False;False;False;False;False;True;False;False;True;True;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;ForwardOnly;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0.0001;0,0,0,0;VertexOffset;False;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;1092;0;2818;625
WireConnection;1092;1;2818;238
WireConnection;1092;2;2818;624
WireConnection;1092;3;2818;96
WireConnection;1092;4;2818;97
WireConnection;1092;5;2818;95
ASEEND*/
//CHKSM=C3F46764DED0D724F9829C7EFE73844BE5ACAEDD