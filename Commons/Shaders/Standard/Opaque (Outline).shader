// Made with Amplify Shader Editor v1.9.9.3
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Standard/Opaque (Outline)"
{
	Properties
	{
		_EdgeLength( "Edge length", Range( 2, 50 ) ) = 15
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
		[Meenphie_DrawerCategory(OUTLINE,true,0,0)] _CATEGORYOUTLINE( "CATEGORY OUTLINE", Float ) = 0
		_OutlineColor( "Outline Color", Color ) = ( 0.02, 0.02, 0.02, 0 )
		_OutlineWidth( "Outline Width", Range( 0, 0.01 ) ) = 0.005
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACEOUTLINE( "CATEGORY SPACE OUTLINE", Float ) = 0
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
		Tags{ }
		Cull Front
		CGPROGRAM
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma surface outlineSurf Outline nofog  keepalpha noshadow noambient novertexlights nolightmap nodynlightmap nodirlightmap nometa noforwardadd vertex:outlineVertexDataFunc tessellate:tessFunction 
		
		
		
		
		struct Input
		{
			half filler;
		};
		uniform float4 _OutlineColor;
		uniform float _OutlineWidth;
		
		uniform float _EdgeLength;

		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityEdgeLengthBasedTess( v0.vertex, v1.vertex, v2.vertex, _EdgeLength );
		}

		void outlineVertexDataFunc( inout appdata_full v )
		{
			float outlineVar = ( _OutlineWidth * v.color.r );
			v.vertex.xyz += ( v.normal * outlineVar );
		}
		inline half4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return half4 ( 0,0,0, s.Alpha); }
		void outlineSurf( Input i, inout SurfaceOutput o )
		{
			o.Emission = _OutlineColor.rgb;
		}
		ENDCG
		

		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "ForceNoShadowCasting" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma shader_feature _SPECULARHIGHLIGHTS_OFF
		#pragma shader_feature _GLOSSYREFLECTIONS_OFF
		#pragma shader_feature_local_fragment _BUMPMAP
		#pragma shader_feature_local_fragment _EMISSION_ON
		#pragma shader_feature_local_fragment _METALLICMAP
		#pragma shader_feature_local_fragment _USEGEOMETRICANTIALIASING_ON
		#pragma shader_feature_local_fragment _GLOSSINESSMAP
		#define ASE_VERSION 19903
		#pragma surface surf Standard keepalpha exclude_path:deferred nodynlightmap nodirlightmap vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldNormal;
			INTERNAL_DATA
		};

		uniform float _CATEGORY_SURFACEOPTIONS;
		uniform float _CATEGORYSPACESURFACEOPTIONS;
		uniform float _CATEGORYEMISSION;
		uniform float _CATEGORYSPACEEMISSION;
		uniform float _EmissionFlags;
		uniform float _CATEGORYOUTLINE;
		uniform float _CATEGORYSPACEOUTLINE;
		uniform sampler2D _BumpMap;
		uniform float _NormalScale;
		uniform float4 _Color;
		uniform sampler2D _MainTex;
		uniform float3 _EmissionColor;
		uniform sampler2D _EmissionMap;
		uniform float _Metallic;
		uniform sampler2D _MetallicMap;
		uniform float4 _MetallicMap_ST;
		uniform float _Glossiness;
		uniform sampler2D _GlossinessMap;
		uniform float _EdgeLength;

		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityEdgeLengthBasedTess( v0.vertex, v1.vertex, v2.vertex, _EdgeLength );
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float Outline_GUI888_g1528 = ( _CATEGORYOUTLINE + _CATEGORYSPACEOUTLINE );
			float3 temp_cast_0 = (Outline_GUI888_g1528).xxx;
			float3 lerpResult889_g1528 = lerp( 0 , temp_cast_0 , float3( 0,0,0 ));
			v.vertex.xyz += lerpResult889_g1528;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BumpMap830_g1528 = i.uv_texcoord;
			#ifdef _BUMPMAP
				float3 staticSwitch844_g1528 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap830_g1528 ), _NormalScale );
			#else
				float3 staticSwitch844_g1528 = float3( 0, 0, 1 );
			#endif
			float3 Normal_Map700_g1528 = staticSwitch844_g1528;
			o.Normal = Normal_Map700_g1528;
			float2 uv_MainTex259_g1528 = i.uv_texcoord;
			float4 tex2DNode259_g1528 = tex2D( _MainTex, uv_MainTex259_g1528 );
			float3 temp_output_5_0_g1528 = ( _Color.rgb * tex2DNode259_g1528.rgb );
			o.Albedo = temp_output_5_0_g1528;
			float3 Albedo6_g1528 = temp_output_5_0_g1528;
			float White38_g1528 = 1.0;
			float Lightmap46_g1528 = White38_g1528;
			float3 temp_output_614_0_g1528 = ( Albedo6_g1528 * Lightmap46_g1528 );
			float3 temp_cast_0 = 0;
			float2 uv_EmissionMap81_g1528 = i.uv_texcoord;
			#ifdef _EMISSION_ON
				float3 staticSwitch851_g1528 = ( _EmissionColor + tex2D( _EmissionMap, uv_EmissionMap81_g1528 ).rgb );
			#else
				float3 staticSwitch851_g1528 = temp_cast_0;
			#endif
			float3 Emission86_g1528 = staticSwitch851_g1528;
			o.Emission = ( temp_output_614_0_g1528 * Emission86_g1528 );
			float2 uv_MetallicMap = i.uv_texcoord * _MetallicMap_ST.xy + _MetallicMap_ST.zw;
			float saferPower803_g1528 = abs( tex2D( _MetallicMap, uv_MetallicMap ).a );
			#ifdef _METALLICMAP
				float staticSwitch846_g1528 = pow( saferPower803_g1528 , 3.0 );
			#else
				float staticSwitch846_g1528 = _Metallic;
			#endif
			float Metallic699_g1528 = staticSwitch846_g1528;
			o.Metallic = Metallic699_g1528;
			float2 uv_GlossinessMap64_g1528 = i.uv_texcoord;
			float saferPower804_g1528 = abs( tex2D( _GlossinessMap, uv_GlossinessMap64_g1528 ).a );
			#ifdef _GLOSSINESSMAP
				float staticSwitch845_g1528 = ( 1.0 - pow( saferPower804_g1528 , 3.0 ) );
			#else
				float staticSwitch845_g1528 = _Glossiness;
			#endif
			float3 ase_normalWS = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 temp_output_3_0_g1529 = ddx( ase_normalWS );
			float dotResult5_g1529 = dot( temp_output_3_0_g1529 , temp_output_3_0_g1529 );
			float3 temp_output_4_0_g1529 = ddy( ase_normalWS );
			float dotResult6_g1529 = dot( temp_output_4_0_g1529 , temp_output_4_0_g1529 );
			#ifdef _USEGEOMETRICANTIALIASING_ON
				float staticSwitch824_g1528 = min( staticSwitch845_g1528 , ( 1.0 - pow( saturate( max( dotResult5_g1529 , dotResult6_g1529 ) ) , 0.333 ) ) );
			#else
				float staticSwitch824_g1528 = staticSwitch845_g1528;
			#endif
			o.Smoothness = staticSwitch824_g1528;
			o.Occlusion = White38_g1528;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19903
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2880;192,-1200;Inherit;False;Meenphie;5;;1528;b3ba55a08dd6b49c7be16c6f35cf2033;5,869,0,871,0,872,0,847,0,867,1;0;9;FLOAT3;625;FLOAT3;238;FLOAT3;624;FLOAT;96;FLOAT;97;FLOAT;95;FLOAT;156;FLOAT;427;FLOAT3;860
Node;AmplifyShaderEditor.StandardSurfaceOutputNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1092;512,-1200;Float;False;True;-1;6;AmplifyShaderEditor.MaterialInspector;0;0;Standard;Meenphie/Standard/Opaque (Outline);False;False;False;False;False;False;False;True;True;False;False;False;False;False;False;True;False;False;True;True;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;ForwardOnly;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;2;15;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0.0001;0,0,0,0;VertexOffset;False;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;0;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;1092;0;2880;625
WireConnection;1092;1;2880;238
WireConnection;1092;2;2880;624
WireConnection;1092;3;2880;96
WireConnection;1092;4;2880;97
WireConnection;1092;5;2880;95
WireConnection;1092;11;2880;860
ASEEND*/
//CHKSM=D57A331EB49CEE0E4A61FA677298F8F4C3BDEBBD