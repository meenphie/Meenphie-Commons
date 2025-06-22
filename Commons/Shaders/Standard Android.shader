// Made with Amplify Shader Editor v1.9.8.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Fairplex/RNM/Standard Mobile"
{
	Properties
	{
		[LS_DrawerCategory(SURFACE OPTIONS,true,_Cull,0,0)]_CATEGORY_SURFACEOPTIONS("CATEGORY_SURFACEOPTIONS", Float) = 1
		_Color("DIffuse Color", Color) = (1,1,1,1)
		[NoScaleOffset][Fairplex_DrawerTextureSingleLine]_MainTex("Diffuse Map", 2D) = "white" {}
		[Fairplex_DrawerTextureSingleLine]_NormalMap("Normal Map", 2D) = "bump" {}
		_NormalScale("Normal Scale", Float) = 1
		[Fairplex_DrawerTextureSingleLine]_MetallicMap("Metallic Map", 2D) = "white" {}
		[HDR][NoScaleOffset][Fairplex_DrawerTextureSingleLine]_EmissionMap1("Roughness Map", 2D) = "black" {}
		_Metallic("Metallic", Range( 0 , 1)) = 0
		[Fairplex_DrawerCategorySpace(10)]_Glossiness("Smoothness", Range( 0 , 1)) = 0.5
		[Fairplex_DrawerCategory(EMISSION,true,_EMISSION,0,0)]_CATEGORYEMISSION("CATEGORY EMISSION", Float) = 1
		[Fairplex_DrawerToggleLeft]_EMISSION("Enable Emission", Float) = 0
		[HDR][Gamma]_EmissionColor("Emission Color", Color) = (0,0,0)
		[NoScaleOffset][Fairplex_DrawerTextureSingleLine]_EmissionMap("Emission Map", 2D) = "black" {}
		_EmissionIntensity("Intensity", Float) = 0
		[Fairplex_DrawerEmissionFlags]_EmissionFlags("Global Illumination", Float) = 2
		[Fairplex_DrawerSpace(10)]_CATEGORYSPACEEMISSION("CATEGORY SPACE EMISSION", Float) = 0
		[Fairplex_DrawerCategory(LIGHTMAPPING,true,_LightmappingMode,0,0)]_CATEGORYLIGHTMAPPING("CATEGORY LIGHTMAPPING", Float) = 1
		[Fairplex_DrawerToggleLeft]_ENABLELIGHTMAPPING("Enable Lightmapping", Float) = 0
		[Fairplex_DrawerTextureSingleLine]_RNMX0("RNMX 0", 2D) = "gray" {}
		[Fairplex_DrawerTextureSingleLine]_RNMY0("RNMY 0", 2D) = "gray" {}
		[Fairplex_DrawerTextureSingleLine]_RNMZ0("RNMZ 0", 2D) = "gray" {}
		_RNMScale("RNM Scale", Float) = 2
		[Fairplex_DrawerToggleLeft]_LIGHTMAPOCCLUSION("Lightmap Occlusion", Float) = 0
		[Fairplex_DrawerSpace(10)]_CATEGORYSPACELIGHTMAPPING("CATEGORY SPACE LIGHTMAPPING", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord3( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
		[Header(Forward Rendering Options)]
		[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		[ToggleOff] _GlossyReflections("Reflections", Float) = 1.0
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 3.5
		#pragma shader_feature _SPECULARHIGHLIGHTS_OFF
		#pragma shader_feature _GLOSSYREFLECTIONS_OFF
		#define ASE_VERSION 19801
		#pragma only_renderers gles gles3 
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows nodynlightmap nodirlightmap nofog noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
			float2 uv3_texcoord3;
		};

		uniform float _CATEGORY_SURFACEOPTIONS;
		uniform float _CATEGORYSPACEEMISSION;
		uniform float _EmissionFlags;
		uniform float _CATEGORYSPACELIGHTMAPPING;
		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
		float4 _NormalMap_TexelSize;
		uniform float _NormalScale;
		uniform sampler2D _MainTex;
		uniform float4 _Color;
		uniform float _RNMScale;
		uniform sampler2D _RNMX0;
		uniform float4 _RNMX0_ST;
		float4 _RNMX0_TexelSize;
		uniform sampler2D _RNMY0;
		uniform sampler2D _RNMZ0;
		uniform float _CATEGORYLIGHTMAPPING;
		uniform float _ENABLELIGHTMAPPING;
		uniform float _Metallic;
		uniform sampler2D _MetallicMap;
		uniform float4 _MetallicMap_ST;
		uniform float3 _EmissionColor;
		uniform sampler2D _EmissionMap;
		uniform float _EmissionIntensity;
		uniform float _CATEGORYEMISSION;
		uniform float _EMISSION;
		uniform float _Glossiness;
		uniform sampler2D _EmissionMap1;
		uniform float _LIGHTMAPOCCLUSION;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float localBicubicPrepare2_g529 = ( 0.0 );
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			float2 Input_UV100_g529 = uv_NormalMap;
			float2 UV2_g529 = Input_UV100_g529;
			float4 TexelSize2_g529 = _NormalMap_TexelSize;
			float2 UV02_g529 = float2( 0,0 );
			float2 UV12_g529 = float2( 0,0 );
			float2 UV22_g529 = float2( 0,0 );
			float2 UV32_g529 = float2( 0,0 );
			float W02_g529 = 0;
			float W12_g529 = 0;
			{
			{
			 UV2_g529 = UV2_g529 * TexelSize2_g529.zw - 0.5;
			    float2 f = frac( UV2_g529 );
			    UV2_g529 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g529.x - 0.5, UV2_g529.x + 1.5, UV2_g529.y - 0.5, UV2_g529.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g529.xyxy;
			    UV02_g529 = off.xz;
			    UV12_g529 = off.yz;
			    UV22_g529 = off.xw;
			    UV32_g529 = off.yw;
			    W02_g529 = s.x / ( s.x + s.y );
			 W12_g529 = s.z / ( s.z + s.w );
			}
			}
			float temp_output_239_0_g529 = _NormalScale;
			float3 lerpResult46_g529 = lerp( UnpackScaleNormal( tex2D( _NormalMap, UV32_g529 ), temp_output_239_0_g529 ) , UnpackScaleNormal( tex2D( _NormalMap, UV22_g529 ), temp_output_239_0_g529 ) , W02_g529);
			float3 lerpResult45_g529 = lerp( UnpackScaleNormal( tex2D( _NormalMap, UV12_g529 ), temp_output_239_0_g529 ) , UnpackScaleNormal( tex2D( _NormalMap, UV02_g529 ), temp_output_239_0_g529 ) , W02_g529);
			float3 lerpResult44_g529 = lerp( lerpResult46_g529 , lerpResult45_g529 , W12_g529);
			float3 Output_2D131_g529 = lerpResult44_g529;
			o.Normal = Output_2D131_g529;
			float2 uv_MainTex259_g528 = i.uv_texcoord;
			float4 tex2DNode259_g528 = tex2D( _MainTex, uv_MainTex259_g528 );
			float3 Albedo6_g528 = ( tex2DNode259_g528.rgb * _Color.rgb );
			int White38_g528 = 1;
			float4 temp_cast_2 = White38_g528;
			float3 appendResult139_g537 = (float3(sqrt( ( 3.0 / 2.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float localBicubicPrepare2_g538 = ( 0.0 );
			float2 Input_UV100_g538 = uv_NormalMap;
			float2 UV2_g538 = Input_UV100_g538;
			float4 TexelSize2_g538 = _NormalMap_TexelSize;
			float2 UV02_g538 = float2( 0,0 );
			float2 UV12_g538 = float2( 0,0 );
			float2 UV22_g538 = float2( 0,0 );
			float2 UV32_g538 = float2( 0,0 );
			float W02_g538 = 0;
			float W12_g538 = 0;
			{
			{
			 UV2_g538 = UV2_g538 * TexelSize2_g538.zw - 0.5;
			    float2 f = frac( UV2_g538 );
			    UV2_g538 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g538.x - 0.5, UV2_g538.x + 1.5, UV2_g538.y - 0.5, UV2_g538.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g538.xyxy;
			    UV02_g538 = off.xz;
			    UV12_g538 = off.yz;
			    UV22_g538 = off.xw;
			    UV32_g538 = off.yw;
			    W02_g538 = s.x / ( s.x + s.y );
			 W12_g538 = s.z / ( s.z + s.w );
			}
			}
			float temp_output_239_0_g538 = _RNMScale;
			float3 lerpResult46_g538 = lerp( UnpackScaleNormal( tex2D( _NormalMap, UV32_g538 ), temp_output_239_0_g538 ) , UnpackScaleNormal( tex2D( _NormalMap, UV22_g538 ), temp_output_239_0_g538 ) , W02_g538);
			float3 lerpResult45_g538 = lerp( UnpackScaleNormal( tex2D( _NormalMap, UV12_g538 ), temp_output_239_0_g538 ) , UnpackScaleNormal( tex2D( _NormalMap, UV02_g538 ), temp_output_239_0_g538 ) , W02_g538);
			float3 lerpResult44_g538 = lerp( lerpResult46_g538 , lerpResult45_g538 , W12_g538);
			float3 Output_2D131_g538 = lerpResult44_g538;
			float3 normalizeResult326_g537 = normalize( Output_2D131_g538 );
			float3 Normal_Map318_g537 = normalizeResult326_g537;
			float dotResult121_g537 = dot( appendResult139_g537 , Normal_Map318_g537 );
			float localStochasticTiling2_g544 = ( 0.0 );
			float2 uv3_RNMX0 = i.uv3_texcoord3 * _RNMX0_ST.xy + _RNMX0_ST.zw;
			float2 UV2_g544 = uv3_RNMX0;
			float4 TexelSize2_g544 = _RNMX0_TexelSize;
			float4 Offsets2_g544 = float4( 0,0,0,0 );
			float2 Weights2_g544 = float2( 0,0 );
			{
			UV2_g544 = UV2_g544 * TexelSize2_g544.zw - 0.5;
			float2 f = frac( UV2_g544 );
			UV2_g544 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g544.x - 0.5, UV2_g544.x + 1.5, UV2_g544.y - 0.5, UV2_g544.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g544 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g544.xyxy;
			Weights2_g544 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g541 = Offsets2_g544;
			float4 Input_FetchOffsets197_g545 = temp_output_1_34_g541;
			float2 temp_output_1_54_g541 = Weights2_g544;
			float2 Input_FetchWeights200_g545 = temp_output_1_54_g541;
			float2 break187_g545 = Input_FetchWeights200_g545;
			float4 lerpResult181_g545 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g545).yw ) , tex2D( _RNMX0, (Input_FetchOffsets197_g545).xw ) , break187_g545.x);
			float4 lerpResult182_g545 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g545).yz ) , tex2D( _RNMX0, (Input_FetchOffsets197_g545).xz ) , break187_g545.x);
			float4 lerpResult176_g545 = lerp( lerpResult181_g545 , lerpResult182_g545 , break187_g545.y);
			float4 Output_Fetch2D202_g545 = lerpResult176_g545;
			float3 appendResult146_g537 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g537 = dot( appendResult146_g537 , Normal_Map318_g537 );
			float4 Input_FetchOffsets197_g542 = temp_output_1_34_g541;
			float2 Input_FetchWeights200_g542 = temp_output_1_54_g541;
			float2 break187_g542 = Input_FetchWeights200_g542;
			float4 lerpResult181_g542 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g542).yw ) , tex2D( _RNMY0, (Input_FetchOffsets197_g542).xw ) , break187_g542.x);
			float4 lerpResult182_g542 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g542).yz ) , tex2D( _RNMY0, (Input_FetchOffsets197_g542).xz ) , break187_g542.x);
			float4 lerpResult176_g542 = lerp( lerpResult181_g542 , lerpResult182_g542 , break187_g542.y);
			float4 Output_Fetch2D202_g542 = lerpResult176_g542;
			float3 appendResult149_g537 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g537 = dot( appendResult149_g537 , Normal_Map318_g537 );
			float4 Input_FetchOffsets197_g543 = temp_output_1_34_g541;
			float2 Input_FetchWeights200_g543 = temp_output_1_54_g541;
			float2 break187_g543 = Input_FetchWeights200_g543;
			float4 lerpResult181_g543 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g543).yw ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g543).xw ) , break187_g543.x);
			float4 lerpResult182_g543 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g543).yz ) , tex2D( _RNMZ0, (Input_FetchOffsets197_g543).xz ) , break187_g543.x);
			float4 lerpResult176_g543 = lerp( lerpResult181_g543 , lerpResult182_g543 , break187_g543.y);
			float4 Output_Fetch2D202_g543 = lerpResult176_g543;
			float4 temp_output_429_0_g528 = ( ( ( saturate( dotResult121_g537 ) * ( Output_Fetch2D202_g545 * 0.75 ) ) + ( saturate( dotResult122_g537 ) * ( Output_Fetch2D202_g542 * 0.75 ) ) ) + ( saturate( dotResult120_g537 ) * ( Output_Fetch2D202_g543 * 0.75 ) ) );
			float Enable_Lightmapping115_g528 = _ENABLELIGHTMAPPING;
			float4 lerpResult114_g528 = lerp( temp_cast_2 , ( temp_output_429_0_g528 + ( ( _CATEGORYLIGHTMAPPING + _CATEGORYSPACELIGHTMAPPING ) * 0.0 ) ) , Enable_Lightmapping115_g528);
			float4 Lightmap46_g528 = lerpResult114_g528;
			float4 lerpResult174_g528 = lerp( float4( Albedo6_g528 , 0.0 ) , ( float4( Albedo6_g528 , 0.0 ) * Lightmap46_g528 ) , Enable_Lightmapping115_g528);
			o.Albedo = lerpResult174_g528.rgb;
			float2 uv_MetallicMap = i.uv_texcoord * _MetallicMap_ST.xy + _MetallicMap_ST.zw;
			float3 Metallic54_g528 = ( _Metallic * tex2D( _MetallicMap, uv_MetallicMap ).rgb );
			float3 lerpResult189_g528 = lerp( float3( 0,0,0 ) , ( 1.0 - Metallic54_g528 ) , Enable_Lightmapping115_g528);
			float2 uv_EmissionMap81_g528 = i.uv_texcoord;
			float3 lerpResult98_g528 = lerp( float3( 0,0,0 ) , ( ( ( _EmissionColor + tex2D( _EmissionMap, uv_EmissionMap81_g528 ).rgb ) * _EmissionIntensity ) + ( ( _CATEGORYEMISSION + _CATEGORYSPACEEMISSION ) * 0.0 ) ) , _EMISSION);
			float3 Emission86_g528 = lerpResult98_g528;
			o.Emission = ( ( lerpResult174_g528 * float4( lerpResult189_g528 , 0.0 ) ) + float4( Emission86_g528 , 0.0 ) ).rgb;
			o.Metallic = Metallic54_g528.x;
			float2 uv_EmissionMap164_g528 = i.uv_texcoord;
			float4 Roughness326_g528 = ( _Glossiness * ( 1.0 - tex2D( _EmissionMap1, uv_EmissionMap164_g528 ) ) );
			o.Smoothness = Roughness326_g528.r;
			float4 temp_cast_9 = White38_g528;
			float4 clampResult67_g528 = clamp( Lightmap46_g528 , float4( 0,0,0,0 ) , float4( 1,0,0,0 ) );
			float4 lerpResult105_g528 = lerp( temp_cast_9 , clampResult67_g528 , _LIGHTMAPOCCLUSION);
			o.Occlusion = lerpResult105_g528.r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Fairplex/Standard iOS"
	CustomEditor "Fairplex_ShaderGUI"
}
/*ASEBEGIN
Version=19801
Node;AmplifyShaderEditor.FunctionNode;1569;192,-1200;Inherit;False;Fairplex Default;0;;528;b3ba55a08dd6b49c7be16c6f35cf2033;4,169,1,186,1,162,1,120,1;0;8;COLOR;0;FLOAT3;238;COLOR;94;FLOAT3;96;COLOR;97;COLOR;95;FLOAT;156;FLOAT;427
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;1092;512,-1200;Float;False;True;-1;3;Fairplex_ShaderGUI;0;0;Standard;Fairplex/RNM/Standard Mobile;False;False;False;False;False;False;False;True;True;True;False;True;False;False;False;False;False;False;True;True;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;2;gles;gles3;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;Fairplex/Standard iOS;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;1092;0;1569;0
WireConnection;1092;1;1569;238
WireConnection;1092;2;1569;94
WireConnection;1092;3;1569;96
WireConnection;1092;4;1569;97
WireConnection;1092;5;1569;95
ASEEND*/
//CHKSM=AAC6ABE97781AA152D5380CAF148032834A32218