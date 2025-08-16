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
		[Meenphie_DrawerTextureSingleLine] _RNMX0( "RNMX 0", 2D ) = "gray" {}
		[Meenphie_DrawerTextureSingleLine] _RNMY0( "RNMY 0", 2D ) = "gray" {}
		[Meenphie_DrawerTextureSingleLine] _RNMZ0( "RNMZ 0", 2D ) = "gray" {}
		[Toggle( _LIGHTMAPOCCLUSION_ON )] _LightmapOcclusion( "Lightmap Occlusion", Float ) = 1
		_OcclusionPower( "Occlusion Power", Float ) = 1
		[HideInInspector] _texcoord3( "", 2D ) = "white" {}
		[HideInInspector] GenKey__MetallicMap( "Assign keyword _METALLICMAP", Float ) = 1.0
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0
		[HideInInspector] GenKey__GlossinessMap( "Assign keyword _GLOSSINESSMAP", Float ) = 1.0
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
		#pragma shader_feature_local_fragment _EMISSION_ON
		#pragma shader_feature_local_fragment _METALLICMAP
		#pragma shader_feature_local_fragment _USEGEOMETRICANTIALIASING_ON
		#pragma shader_feature_local_fragment _GLOSSINESSMAP
		#pragma shader_feature_local_fragment _LIGHTMAPOCCLUSION_ON
		#define ASE_VERSION 19903
		#pragma surface surf Standard keepalpha exclude_path:deferred nodynlightmap nodirlightmap 
		struct Input
		{
			float2 uv_texcoord;
			float2 uv3_texcoord3;
			float3 worldNormal;
			INTERNAL_DATA
		};

		uniform float _CATEGORYSPACESURFACEOPTIONS;
		uniform float _CATEGORY_SURFACEOPTIONS;
		uniform float _EmissionFlags;
		uniform float _CATEGORYSPACEEMISSION;
		uniform float _CATEGORYEMISSION;
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
			float2 uv_BumpMap830_g1336 = i.uv_texcoord;
			#ifdef _BUMPMAP
				float3 staticSwitch844_g1336 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap830_g1336 ), _NormalScale );
			#else
				float3 staticSwitch844_g1336 = float3( 0, 0, 1 );
			#endif
			float3 Normal_Map700_g1336 = staticSwitch844_g1336;
			o.Normal = Normal_Map700_g1336;
			float2 uv_MainTex259_g1336 = i.uv_texcoord;
			float4 tex2DNode259_g1336 = tex2D( _MainTex, uv_MainTex259_g1336 );
			float3 temp_output_5_0_g1336 = ( _Color.rgb * tex2DNode259_g1336.rgb );
			o.Albedo = temp_output_5_0_g1336;
			float3 temp_cast_0 = 0;
			float2 uv_EmissionMap81_g1336 = i.uv_texcoord;
			#ifdef _EMISSION_ON
				float3 staticSwitch851_g1336 = ( _EmissionColor + tex2D( _EmissionMap, uv_EmissionMap81_g1336 ).rgb );
			#else
				float3 staticSwitch851_g1336 = temp_cast_0;
			#endif
			float3 Emission86_g1336 = staticSwitch851_g1336;
			float3 Albedo6_g1336 = temp_output_5_0_g1336;
			float3 appendResult139_g1338 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
			float3 normalizeResult326_g1338 = normalize( Normal_Map700_g1336 );
			float3 Normal_Map318_g1338 = normalizeResult326_g1338;
			float dotResult121_g1338 = dot( appendResult139_g1338 , Normal_Map318_g1338 );
			float localStochasticTiling2_g1340 = ( 0.0 );
			float2 uv3_RNMX0 = i.uv3_texcoord3 * _RNMX0_ST.xy + _RNMX0_ST.zw;
			float2 UV2_g1340 = uv3_RNMX0;
			float4 TexelSize2_g1340 = _RNMX0_TexelSize;
			float4 Offsets2_g1340 = float4( 0,0,0,0 );
			float2 Weights2_g1340 = float2( 0,0 );
			{
			UV2_g1340 = UV2_g1340 * TexelSize2_g1340.zw - 0.5;
			float2 f = frac( UV2_g1340 );
			UV2_g1340 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV2_g1340.x - 0.5, UV2_g1340.x + 1.5, UV2_g1340.y - 0.5, UV2_g1340.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets2_g1340 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1340.xyxy;
			Weights2_g1340 = float2( w0, w1 );
			}
			float4 temp_output_1_34_g1339 = Offsets2_g1340;
			float4 Input_FetchOffsets197_g1343 = temp_output_1_34_g1339;
			float2 temp_output_1_54_g1339 = Weights2_g1340;
			float2 Input_FetchWeights200_g1343 = temp_output_1_54_g1339;
			float2 break187_g1343 = Input_FetchWeights200_g1343;
			float3 lerpResult181_g1343 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g1343).yw ).rgb , tex2D( _RNMX0, (Input_FetchOffsets197_g1343).xw ).rgb , break187_g1343.x);
			float3 lerpResult182_g1343 = lerp( tex2D( _RNMX0, (Input_FetchOffsets197_g1343).yz ).rgb , tex2D( _RNMX0, (Input_FetchOffsets197_g1343).xz ).rgb , break187_g1343.x);
			float3 lerpResult176_g1343 = lerp( lerpResult181_g1343 , lerpResult182_g1343 , break187_g1343.y);
			float3 Output_Fetch2D202_g1343 = lerpResult176_g1343;
			float3 appendResult146_g1338 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult122_g1338 = dot( appendResult146_g1338 , Normal_Map318_g1338 );
			float4 Input_FetchOffsets197_g1341 = temp_output_1_34_g1339;
			float2 Input_FetchWeights200_g1341 = temp_output_1_54_g1339;
			float2 break187_g1341 = Input_FetchWeights200_g1341;
			float3 lerpResult181_g1341 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g1341).yw ).rgb , tex2D( _RNMY0, (Input_FetchOffsets197_g1341).xw ).rgb , break187_g1341.x);
			float3 lerpResult182_g1341 = lerp( tex2D( _RNMY0, (Input_FetchOffsets197_g1341).yz ).rgb , tex2D( _RNMY0, (Input_FetchOffsets197_g1341).xz ).rgb , break187_g1341.x);
			float3 lerpResult176_g1341 = lerp( lerpResult181_g1341 , lerpResult182_g1341 , break187_g1341.y);
			float3 Output_Fetch2D202_g1341 = lerpResult176_g1341;
			float3 appendResult149_g1338 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
			float dotResult120_g1338 = dot( appendResult149_g1338 , Normal_Map318_g1338 );
			float4 Input_FetchOffsets197_g1342 = temp_output_1_34_g1339;
			float2 Input_FetchWeights200_g1342 = temp_output_1_54_g1339;
			float2 break187_g1342 = Input_FetchWeights200_g1342;
			float3 lerpResult181_g1342 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g1342).yw ).rgb , tex2D( _RNMZ0, (Input_FetchOffsets197_g1342).xw ).rgb , break187_g1342.x);
			float3 lerpResult182_g1342 = lerp( tex2D( _RNMZ0, (Input_FetchOffsets197_g1342).yz ).rgb , tex2D( _RNMZ0, (Input_FetchOffsets197_g1342).xz ).rgb , break187_g1342.x);
			float3 lerpResult176_g1342 = lerp( lerpResult181_g1342 , lerpResult182_g1342 , break187_g1342.y);
			float3 Output_Fetch2D202_g1342 = lerpResult176_g1342;
			float3 temp_output_838_0_g1336 = ( ( ( saturate( dotResult121_g1338 ) * ( Output_Fetch2D202_g1343 * 1.0 ) ) + ( saturate( dotResult122_g1338 ) * ( Output_Fetch2D202_g1341 * 1.0 ) ) ) + ( saturate( dotResult120_g1338 ) * ( Output_Fetch2D202_g1342 * 1.0 ) ) );
			float3 Lightmap46_g1336 = temp_output_838_0_g1336;
			float3 temp_output_614_0_g1336 = ( Albedo6_g1336 * Lightmap46_g1336 );
			o.Emission = ( Emission86_g1336 + temp_output_614_0_g1336 );
			float2 uv_MetallicMap = i.uv_texcoord * _MetallicMap_ST.xy + _MetallicMap_ST.zw;
			float saferPower803_g1336 = abs( tex2D( _MetallicMap, uv_MetallicMap ).a );
			#ifdef _METALLICMAP
				float staticSwitch846_g1336 = pow( saferPower803_g1336 , 3.0 );
			#else
				float staticSwitch846_g1336 = _Metallic;
			#endif
			float Metallic699_g1336 = staticSwitch846_g1336;
			o.Metallic = Metallic699_g1336;
			float2 uv_GlossinessMap64_g1336 = i.uv_texcoord;
			float saferPower804_g1336 = abs( tex2D( _GlossinessMap, uv_GlossinessMap64_g1336 ).a );
			#ifdef _GLOSSINESSMAP
				float staticSwitch845_g1336 = ( 1.0 - pow( saferPower804_g1336 , 3.0 ) );
			#else
				float staticSwitch845_g1336 = _Glossiness;
			#endif
			float3 ase_normalWS = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 temp_output_3_0_g1337 = ddx( ase_normalWS );
			float dotResult5_g1337 = dot( temp_output_3_0_g1337 , temp_output_3_0_g1337 );
			float3 temp_output_4_0_g1337 = ddy( ase_normalWS );
			float dotResult6_g1337 = dot( temp_output_4_0_g1337 , temp_output_4_0_g1337 );
			#ifdef _USEGEOMETRICANTIALIASING_ON
				float staticSwitch824_g1336 = min( staticSwitch845_g1336 , ( 1.0 - pow( saturate( max( dotResult5_g1337 , dotResult6_g1337 ) ) , 0.333 ) ) );
			#else
				float staticSwitch824_g1336 = staticSwitch845_g1336;
			#endif
			o.Smoothness = staticSwitch824_g1336;
			float White38_g1336 = 1.0;
			float dotResult835_g1336 = dot( Lightmap46_g1336 , float3( 0.299, 0.587, 0.114 ) );
			float saferPower606_g1336 = abs( dotResult835_g1336 );
			#ifdef _LIGHTMAPOCCLUSION_ON
				float staticSwitch573_g1336 = pow( saferPower606_g1336 , _OcclusionPower );
			#else
				float staticSwitch573_g1336 = White38_g1336;
			#endif
			o.Occlusion = staticSwitch573_g1336;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19903
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2857;192,-1200;Inherit;False;Meenphie;0;;1336;b3ba55a08dd6b49c7be16c6f35cf2033;5,869,1,871,1,872,1,847,1,867,0;0;9;FLOAT3;625;FLOAT3;238;FLOAT3;624;FLOAT;96;FLOAT;97;FLOAT;95;FLOAT;156;FLOAT;427;FLOAT3;860
Node;AmplifyShaderEditor.StandardSurfaceOutputNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1092;512,-1200;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;0;Standard;Meenphie/RNM/Opaque;False;False;False;False;False;False;False;True;True;False;False;False;False;False;False;True;False;False;True;True;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;ForwardOnly;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0.0001;0,0,0,0;VertexOffset;False;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;1092;0;2857;625
WireConnection;1092;1;2857;238
WireConnection;1092;2;2857;624
WireConnection;1092;3;2857;96
WireConnection;1092;4;2857;97
WireConnection;1092;5;2857;95
ASEEND*/
//CHKSM=7E08E1492C8F4B0AC90781BD5BB9B34F1CBD0B8E