// Made with Amplify Shader Editor v1.9.9.4
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Standard/Transparent"
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
		[Toggle] _EmissionEnabled( "Emission Enabled", Float ) = 0
		[HDR][Gamma] _EmissionColor( "Emission Color", Color ) = ( 0, 0, 0, 0 )
		[NoScaleOffset][SingleLineTexture] _EmissionMap( "Emission Map", 2D ) = "black" {}
		[Meenphie_DrawerEmissionFlags] _EmissionFlags( "Global Illumination", Float ) = 2
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACEEMISSION( "CATEGORY SPACE EMISSION", Float ) = 0
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
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
		#pragma shader_feature_local_fragment _BUMPMAP
		#pragma shader_feature_local_fragment _METALLICMAP
		#pragma shader_feature_local_fragment _USEGEOMETRICANTIALIASING_ON
		#pragma shader_feature_local_fragment _GLOSSINESSMAP
		#define ASE_VERSION 19904
		#pragma surface surf Standard alpha:fade keepalpha exclude_path:deferred nodynlightmap nodirlightmap 
		struct Input
		{
			float2 uv_texcoord;
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
		uniform float _Metallic;
		uniform float4 _EmissionColor;
		uniform sampler2D _EmissionMap;
		uniform float _EmissionEnabled;
		uniform sampler2D _MetallicMap;
		uniform float _Glossiness;
		uniform sampler2D _GlossinessMap;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BumpMap830_g2555 = i.uv_texcoord;
			#ifdef _BUMPMAP
				float3 staticSwitch980_g2555 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap830_g2555 ), _NormalScale );
			#else
				float3 staticSwitch980_g2555 = float3( 0, 0, 1 );
			#endif
			float3 Normal_Map700_g2555 = staticSwitch980_g2555;
			o.Normal = Normal_Map700_g2555;
			float2 uv_MainTex907_g2555 = i.uv_texcoord;
			float4 Albedo6_g2555 = ( _Color * tex2D( _MainTex, uv_MainTex907_g2555 ) );
			o.Albedo = Albedo6_g2555.rgb;
			float Metallic_Value893_g2555 = _Metallic;
			float White38_g2555 = 1.0;
			float Lightmap46_g2555 = White38_g2555;
			float4 temp_output_614_0_g2555 = ( Albedo6_g2555 * ( ( 1.0 - Metallic_Value893_g2555 ) * Lightmap46_g2555 ) );
			float4 temp_cast_1 = 0;
			float2 uv_EmissionMap81_g2555 = i.uv_texcoord;
			float4 lerpResult974_g2555 = lerp( temp_cast_1 , ( _EmissionColor + tex2D( _EmissionMap, uv_EmissionMap81_g2555 ) ) , _EmissionEnabled);
			float4 Emission86_g2555 = lerpResult974_g2555;
			o.Emission = ( temp_output_614_0_g2555 * Emission86_g2555 ).rgb;
			float2 uv_MetallicMap48_g2555 = i.uv_texcoord;
			float saferPower803_g2555 = abs( tex2D( _MetallicMap, uv_MetallicMap48_g2555 ).a );
			#ifdef _METALLICMAP
				float staticSwitch846_g2555 = pow( saferPower803_g2555 , 3.0 );
			#else
				float staticSwitch846_g2555 = _Metallic;
			#endif
			float Metallic699_g2555 = staticSwitch846_g2555;
			o.Metallic = Metallic699_g2555;
			float2 uv_GlossinessMap64_g2555 = i.uv_texcoord;
			float saferPower804_g2555 = abs( tex2D( _GlossinessMap, uv_GlossinessMap64_g2555 ).a );
			#ifdef _GLOSSINESSMAP
				float staticSwitch845_g2555 = ( 1.0 - pow( saferPower804_g2555 , 3.0 ) );
			#else
				float staticSwitch845_g2555 = _Glossiness;
			#endif
			float3 ase_normalWS = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 temp_output_3_0_g2597 = ddx( ase_normalWS );
			float dotResult5_g2597 = dot( temp_output_3_0_g2597 , temp_output_3_0_g2597 );
			float3 temp_output_4_0_g2597 = ddy( ase_normalWS );
			float dotResult6_g2597 = dot( temp_output_4_0_g2597 , temp_output_4_0_g2597 );
			#ifdef _USEGEOMETRICANTIALIASING_ON
				float staticSwitch824_g2555 = min( staticSwitch845_g2555 , ( 1.0 - pow( saturate( max( dotResult5_g2597 , dotResult6_g2597 ) ) , 0.333 ) ) );
			#else
				float staticSwitch824_g2555 = staticSwitch845_g2555;
			#endif
			o.Smoothness = staticSwitch824_g2555;
			o.Occlusion = White38_g2555;
			o.Alpha = _Color.a;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19904
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2644;192,-1200;Inherit;False;Meenphie;0;;2555;b3ba55a08dd6b49c7be16c6f35cf2033;10,871,0,869,0,872,0,847,1,867,0,944,0,947,0,905,0,938,0,912,0;0;9;COLOR;625;FLOAT3;238;COLOR;624;FLOAT;96;FLOAT;97;FLOAT;95;FLOAT;156;FLOAT;427;FLOAT3;860
Node;AmplifyShaderEditor.StandardSurfaceOutputNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1092;512,-1200;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;0;Standard;Meenphie/Standard/Transparent;False;False;False;False;False;False;False;True;True;False;False;False;False;False;True;True;False;False;True;True;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;ForwardOnly;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;2;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0.0001;0,0,0,0;VertexOffset;False;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;1092;0;2644;625
WireConnection;1092;1;2644;238
WireConnection;1092;2;2644;624
WireConnection;1092;3;2644;96
WireConnection;1092;4;2644;97
WireConnection;1092;5;2644;95
WireConnection;1092;9;2644;156
ASEEND*/
//CHKSM=7CBD1D6CABD1C583D9E3080F63D6780F7015C6B0