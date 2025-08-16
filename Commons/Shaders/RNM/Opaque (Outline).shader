// Made with Amplify Shader Editor v1.9.9.3
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/RNM/Opaque (Outline)"
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
		_OcclusionPower( "Occlusion Power", Float ) = 1
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACELIGHTMAPPING( "CATEGORY SPACE LIGHTMAPPING", Float ) = 0
		[Meenphie_DrawerCategory(OUTLINE,true,0,0)] _CATEGORYOUTLINE( "CATEGORY OUTLINE", Float ) = 1
		_OutlineColor1( "Outline Color", Color ) = ( 0.05, 0.05, 0.05, 0 )
		_OutlineWidth1( "Outline Width", Float ) = 0.005
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACEOUTLINE( "CATEGORY SPACE OUTLINE", Float ) = 0
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
		Tags{ }
		Cull Front
		CGPROGRAM
		#pragma target 3.0
		#pragma surface outlineSurf Outline nofog  keepalpha noshadow noambient novertexlights nolightmap nodynlightmap nodirlightmap nometa noforwardadd vertex:outlineVertexDataFunc 
		
		
		
		
		struct Input
		{
			half filler;
		};
		uniform float4 _OutlineColor1;
		uniform float _OutlineWidth1;
		
		void outlineVertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float outlineVar = _OutlineWidth1;
			v.vertex.xyz += ( v.normal * outlineVar );
		}
		inline half4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return half4 ( 0,0,0, s.Alpha); }
		void outlineSurf( Input i, inout SurfaceOutput o )
		{
			o.Emission = _OutlineColor1.rgb;
		}
		ENDCG
		

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
		#pragma surface surf Standard keepalpha exclude_path:deferred noambient nodynlightmap nodirlightmap vertex:vertexDataFunc 
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
		uniform float _CATEGORYSPACEOUTLINE;
		uniform float _CATEGORYOUTLINE;
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

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			v.vertex.xyz += 0;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BumpMap830_g952 = i.uv_texcoord;
			#ifdef _BUMPMAP
				float3 staticSwitch844_g952 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap830_g952 ), _NormalScale );
			#else
				float3 staticSwitch844_g952 = float3( 0, 0, 1 );
			#endif
			float3 Normal_Map700_g952 = staticSwitch844_g952;
			o.Normal = Normal_Map700_g952;
			float2 uv_MainTex259_g952 = i.uv_texcoord;
			float4 tex2DNode259_g952 = tex2D( _MainTex, uv_MainTex259_g952 );
			float3 temp_output_5_0_g952 = ( _Color.rgb * tex2DNode259_g952.rgb );
			o.Albedo = temp_output_5_0_g952;
			float3 Albedo6_g952 = temp_output_5_0_g952;
			int White38_g952 = 1;
			float3 temp_cast_0 = White38_g952;
			float3 appendResult139_g954 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float3 normalizeResult326_g954 = normalize( Normal_Map700_g952 );
			float3 Normal_Map318_g954 = normalizeResult326_g954;
			float dotResult121_g954 = dot( appendResult139_g954 , Normal_Map318_g954 );
			float localStochasticTiling2_g956 = ( 0.0 );
			float2 uv3_RNMX0 = i.uv3_texcoord3 * _RNMX0_ST.xy + _RNMX0_ST.zw;
			float2 UV2_g956 = uv3_RNMX0;
			float4 TexelSize2_g956 = _RNMX0_TexelSize;
			float4 Offsets2_g956 = float4( 0,0,0,0 );
			float2 Weights2_g956 = float2( 0,0 );
			{
			UV2_g956 = UV2_g956 * TexelSize2_g956.zw - 0.5;
			float2 f = frac( UV2_g956 );
			UV2_g956 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g956.x - 0.5, UV2_g956.x + 1.5, UV2_g956.y - 0.5, UV2_g956.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g956 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g956.xyxy;
			Weights2_g956 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g955 = Offsets2_g956;
			float4 Input_FetchOffsets197_g959 = temp_output_1_34_g955;
			float2 temp_output_1_54_g955 = Weights2_g956;
			float2 Input_FetchWeights200_g959 = temp_output_1_54_g955;
			float2 break187_g959 = Input_FetchWeights200_g959;
			float3 lerpResult181_g959 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g959).yw ).rgb , tex2D( _RNMX0, (Input_FetchOffsets197_g959).xw ).rgb , break187_g959.x);
			float3 lerpResult182_g959 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g959).yz ).rgb , tex2D( _RNMX0, (Input_FetchOffsets197_g959).xz ).rgb , break187_g959.x);
			float3 lerpResult176_g959 = lerp( lerpResult181_g959 , lerpResult182_g959 , break187_g959.y);
			float3 Output_Fetch2D202_g959 = lerpResult176_g959;
			float3 appendResult146_g954 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g954 = dot( appendResult146_g954 , Normal_Map318_g954 );
			float4 Input_FetchOffsets197_g957 = temp_output_1_34_g955;
			float2 Input_FetchWeights200_g957 = temp_output_1_54_g955;
			float2 break187_g957 = Input_FetchWeights200_g957;
			float3 lerpResult181_g957 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g957).yw ).rgb , tex2D( _RNMY0, (Input_FetchOffsets197_g957).xw ).rgb , break187_g957.x);
			float3 lerpResult182_g957 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g957).yz ).rgb , tex2D( _RNMY0, (Input_FetchOffsets197_g957).xz ).rgb , break187_g957.x);
			float3 lerpResult176_g957 = lerp( lerpResult181_g957 , lerpResult182_g957 , break187_g957.y);
			float3 Output_Fetch2D202_g957 = lerpResult176_g957;
			float3 appendResult149_g954 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g954 = dot( appendResult149_g954 , Normal_Map318_g954 );
			float4 Input_FetchOffsets197_g958 = temp_output_1_34_g955;
			float2 Input_FetchWeights200_g958 = temp_output_1_54_g955;
			float2 break187_g958 = Input_FetchWeights200_g958;
			float3 lerpResult181_g958 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g958).yw ).rgb , tex2D( _RNMZ0, (Input_FetchOffsets197_g958).xw ).rgb , break187_g958.x);
			float3 lerpResult182_g958 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g958).yz ).rgb , tex2D( _RNMZ0, (Input_FetchOffsets197_g958).xz ).rgb , break187_g958.x);
			float3 lerpResult176_g958 = lerp( lerpResult181_g958 , lerpResult182_g958 , break187_g958.y);
			float3 Output_Fetch2D202_g958 = lerpResult176_g958;
			float3 temp_output_838_0_g952 = ( ( ( saturate( dotResult121_g954 ) * ( Output_Fetch2D202_g959 * 1.0 ) ) + ( saturate( dotResult122_g954 ) * ( Output_Fetch2D202_g957 * 1.0 ) ) ) + ( saturate( dotResult120_g954 ) * ( Output_Fetch2D202_g958 * 1.0 ) ) );
			#ifdef _LIGHTMAPPING_ON
				float3 staticSwitch566_g952 = temp_output_838_0_g952;
			#else
				float3 staticSwitch566_g952 = temp_cast_0;
			#endif
			float3 Lightmap46_g952 = staticSwitch566_g952;
			float3 temp_output_614_0_g952 = ( Albedo6_g952 * Lightmap46_g952 );
			float3 temp_cast_1 = 0;
			float2 uv_EmissionMap81_g952 = i.uv_texcoord;
			#ifdef _EMISSION_ON
				float3 staticSwitch851_g952 = ( _EmissionColor + tex2D( _EmissionMap, uv_EmissionMap81_g952 ).rgb );
			#else
				float3 staticSwitch851_g952 = temp_cast_1;
			#endif
			float3 Emission86_g952 = staticSwitch851_g952;
			#ifdef _LIGHTMAPPING_ON
				float3 staticSwitch696_g952 = ( Emission86_g952 + temp_output_614_0_g952 );
			#else
				float3 staticSwitch696_g952 = ( temp_output_614_0_g952 * Emission86_g952 );
			#endif
			o.Emission = staticSwitch696_g952;
			float2 uv_MetallicMap = i.uv_texcoord * _MetallicMap_ST.xy + _MetallicMap_ST.zw;
			float saferPower803_g952 = abs( tex2D( _MetallicMap, uv_MetallicMap ).a );
			#ifdef _METALLICMAP
				float staticSwitch846_g952 = pow( saferPower803_g952 , 3.0 );
			#else
				float staticSwitch846_g952 = _Metallic;
			#endif
			float Metallic699_g952 = staticSwitch846_g952;
			o.Metallic = Metallic699_g952;
			float2 uv_GlossinessMap64_g952 = i.uv_texcoord;
			float saferPower804_g952 = abs( tex2D( _GlossinessMap, uv_GlossinessMap64_g952 ).a );
			#ifdef _GLOSSINESSMAP
				float staticSwitch845_g952 = ( 1.0 - pow( saferPower804_g952 , 3.0 ) );
			#else
				float staticSwitch845_g952 = _Glossiness;
			#endif
			float3 ase_normalWS = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 temp_output_3_0_g953 = ddx( ase_normalWS );
			float dotResult5_g953 = dot( temp_output_3_0_g953 , temp_output_3_0_g953 );
			float3 temp_output_4_0_g953 = ddy( ase_normalWS );
			float dotResult6_g953 = dot( temp_output_4_0_g953 , temp_output_4_0_g953 );
			#ifdef _USEGEOMETRICANTIALIASING_ON
				float staticSwitch824_g952 = min( staticSwitch845_g952 , ( 1.0 - pow( saturate( max( dotResult5_g953 , dotResult6_g953 ) ) , 0.333 ) ) );
			#else
				float staticSwitch824_g952 = staticSwitch845_g952;
			#endif
			o.Smoothness = staticSwitch824_g952;
			float dotResult835_g952 = dot( Lightmap46_g952 , float3( 0.299, 0.587, 0.114 ) );
			float saferPower606_g952 = abs( dotResult835_g952 );
			#ifdef _LIGHTMAPOCCLUSION_ON
				float staticSwitch573_g952 = pow( saferPower606_g952 , _OcclusionPower );
			#else
				float staticSwitch573_g952 = (float)White38_g952;
			#endif
			#ifdef _LIGHTMAPPING_ON
				float staticSwitch576_g952 = staticSwitch573_g952;
			#else
				float staticSwitch576_g952 = (float)White38_g952;
			#endif
			o.Occlusion = staticSwitch576_g952;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19903
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2821;-128,-1008;Inherit;False;Property;_OutlineColor1;Outline Color;32;0;Create;True;0;0;0;False;0;False;0.05,0.05,0.05,0;0,0,0,0;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2822;-96,-800;Inherit;False;Property;_OutlineWidth1;Outline Width;33;0;Create;True;0;0;0;False;0;False;0.005;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2825;-160,-704;Inherit;False;378.5096;233.4124;Comment;2;2827;2826;LIGHTMAP GUI;0,0,0,1;0;0
Node;AmplifyShaderEditor.OutlineNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2823;192,-912;Inherit;False;0;True;None;0;0;Front;True;True;True;True;0;False;;3;0;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2824;192,-1200;Inherit;False;Meenphie;0;;952;b3ba55a08dd6b49c7be16c6f35cf2033;1,847,1;0;8;FLOAT3;625;FLOAT3;238;FLOAT3;624;FLOAT;96;FLOAT;97;FLOAT;95;FLOAT;156;FLOAT;427
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2827;-80,-640;Inherit;False;Property;_CATEGORYOUTLINE;CATEGORY OUTLINE;31;0;Create;True;0;0;0;True;1;Meenphie_DrawerCategory(OUTLINE,true,0,0);False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2826;-112,-560;Inherit;False;Property;_CATEGORYSPACEOUTLINE;CATEGORY SPACE OUTLINE;34;0;Create;True;0;0;0;True;1;Meenphie_DrawerCategorySpace(10);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1092;512,-1200;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;0;Standard;Meenphie/RNM/Opaque (Outline);False;False;False;False;True;False;False;True;True;False;False;False;False;False;False;True;False;False;True;True;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;ForwardOnly;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;True;0.01;0,0,0,0;VertexOffset;False;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2823;0;2821;5
WireConnection;2823;1;2822;0
WireConnection;1092;0;2824;625
WireConnection;1092;1;2824;238
WireConnection;1092;2;2824;624
WireConnection;1092;3;2824;96
WireConnection;1092;4;2824;97
WireConnection;1092;5;2824;95
WireConnection;1092;11;2823;0
ASEEND*/
//CHKSM=4172BB2D6171EC9DB389D366924FBDEEB1408A5B