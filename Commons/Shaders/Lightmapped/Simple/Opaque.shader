// Made with Amplify Shader Editor v1.9.9.4
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Lightmapped/Simple/Opaque"
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
		[Meenphie_DrawerCategory(EMISSION,true,0,0)] _CATEGORYEMISSION( "CATEGORY EMISSION", Float ) = 0
		[Toggle( _EMISSION_ON )] _EMISSION( "Emission Enabled", Float ) = 0
		[HDR][Gamma] _EmissionColor( "Emission Color", Color ) = ( 0, 0, 0 )
		[NoScaleOffset][Meenphie_DrawerTextureSingleLine] _EmissionMap( "Emission Map", 2D ) = "black" {}
		[Meenphie_DrawerEmissionFlags] _EmissionFlags( "Global Illumination", Float ) = 2
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACEEMISSION( "CATEGORY SPACE EMISSION", Float ) = 0
		[Meenphie_DrawerCategory(LIGHTMAPPING,true,0,0)] _CATEGORYLIGHTMAPPING( "CATEGORY LIGHTMAPPING", Float ) = 0
		[Meenphie_DrawerTextureSingleLine] _Lightmap( "Lightmap", 2D ) = "black" {}
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
		uniform sampler2D _Lightmap;
		uniform float4 _Lightmap_ST;
		float4 _Lightmap_TexelSize;
		uniform float _CATEGORYLIGHTMAPPING;
		uniform float _CATEGORYSPACELIGHTMAPPING;
		uniform sampler2D _MetallicMap;
		uniform float4 _MetallicMap_ST;
		uniform float _Glossiness;
		uniform sampler2D _GlossinessMap;
		uniform float _OcclusionPower;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BumpMap830_g1368 = i.uv_texcoord;
			#ifdef _BUMPMAP
				float3 staticSwitch844_g1368 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap830_g1368 ), _NormalScale );
			#else
				float3 staticSwitch844_g1368 = float3( 0, 0, 1 );
			#endif
			float3 Normal_Map700_g1368 = staticSwitch844_g1368;
			o.Normal = Normal_Map700_g1368;
			float2 uv_MainTex259_g1368 = i.uv_texcoord;
			float4 tex2DNode259_g1368 = tex2D( _MainTex, uv_MainTex259_g1368 );
			float3 temp_output_5_0_g1368 = ( _Color.rgb * tex2DNode259_g1368.rgb );
			o.Albedo = temp_output_5_0_g1368;
			float3 temp_cast_0 = 0;
			float2 uv_EmissionMap81_g1368 = i.uv_texcoord;
			#ifdef _EMISSION_ON
				float3 staticSwitch851_g1368 = ( _EmissionColor + tex2D( _EmissionMap, uv_EmissionMap81_g1368 ).rgb );
			#else
				float3 staticSwitch851_g1368 = temp_cast_0;
			#endif
			float3 Emission86_g1368 = staticSwitch851_g1368;
			float3 Albedo6_g1368 = temp_output_5_0_g1368;
			float Metallic_Value893_g1368 = _Metallic;
			float localBicubicPrepare2_g1383 = ( 0.0 );
			float2 uv3_Lightmap = i.uv3_texcoord3 * _Lightmap_ST.xy + _Lightmap_ST.zw;
			float2 Input_UV100_g1383 = uv3_Lightmap;
			float2 UV2_g1383 = Input_UV100_g1383;
			float4 TexelSize2_g1383 = _Lightmap_TexelSize;
			float2 UV02_g1383 = float2( 0,0 );
			float2 UV12_g1383 = float2( 0,0 );
			float2 UV22_g1383 = float2( 0,0 );
			float2 UV32_g1383 = float2( 0,0 );
			float W02_g1383 = 0;
			float W12_g1383 = 0;
			{
			{
			 UV2_g1383 = UV2_g1383 * TexelSize2_g1383.zw - 0.5;
			    float2 f = frac( UV2_g1383 );
			    UV2_g1383 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g1383.x - 0.5, UV2_g1383.x + 1.5, UV2_g1383.y - 0.5, UV2_g1383.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g1383.xyxy;
			    UV02_g1383 = off.xz;
			    UV12_g1383 = off.yz;
			    UV22_g1383 = off.xw;
			    UV32_g1383 = off.yw;
			    W02_g1383 = s.x / ( s.x + s.y );
			 W12_g1383 = s.z / ( s.z + s.w );
			}
			}
			float4 lerpResult46_g1383 = lerp( tex2D( _Lightmap, UV32_g1383 ) , tex2D( _Lightmap, UV22_g1383 ) , W02_g1383);
			float4 lerpResult45_g1383 = lerp( tex2D( _Lightmap, UV12_g1383 ) , tex2D( _Lightmap, UV02_g1383 ) , W02_g1383);
			float4 lerpResult44_g1383 = lerp( lerpResult46_g1383 , lerpResult45_g1383 , W12_g1383);
			float4 Output_2D131_g1383 = lerpResult44_g1383;
			float Lightmap_GUI886_g1368 = ( _CATEGORYLIGHTMAPPING + _CATEGORYSPACELIGHTMAPPING );
			float4 temp_cast_3 = (Lightmap_GUI886_g1368).xxxx;
			float4 lerpResult882_g1368 = lerp( Output_2D131_g1383 , temp_cast_3 , float4( 0,0,0,0 ));
			float4 Lightmap46_g1368 = lerpResult882_g1368;
			float4 temp_output_614_0_g1368 = ( float4( Albedo6_g1368 , 0.0 ) * ( ( 1.0 - Metallic_Value893_g1368 ) * Lightmap46_g1368 ) );
			o.Emission = ( float4( Emission86_g1368 , 0.0 ) + temp_output_614_0_g1368 ).rgb;
			float2 uv_MetallicMap = i.uv_texcoord * _MetallicMap_ST.xy + _MetallicMap_ST.zw;
			float saferPower803_g1368 = abs( tex2D( _MetallicMap, uv_MetallicMap ).a );
			#ifdef _METALLICMAP
				float staticSwitch846_g1368 = pow( saferPower803_g1368 , 3.0 );
			#else
				float staticSwitch846_g1368 = _Metallic;
			#endif
			float Metallic699_g1368 = staticSwitch846_g1368;
			o.Metallic = Metallic699_g1368;
			float2 uv_GlossinessMap64_g1368 = i.uv_texcoord;
			float saferPower804_g1368 = abs( tex2D( _GlossinessMap, uv_GlossinessMap64_g1368 ).a );
			#ifdef _GLOSSINESSMAP
				float staticSwitch845_g1368 = ( 1.0 - pow( saferPower804_g1368 , 3.0 ) );
			#else
				float staticSwitch845_g1368 = _Glossiness;
			#endif
			float3 ase_normalWS = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 temp_output_3_0_g1369 = ddx( ase_normalWS );
			float dotResult5_g1369 = dot( temp_output_3_0_g1369 , temp_output_3_0_g1369 );
			float3 temp_output_4_0_g1369 = ddy( ase_normalWS );
			float dotResult6_g1369 = dot( temp_output_4_0_g1369 , temp_output_4_0_g1369 );
			#ifdef _USEGEOMETRICANTIALIASING_ON
				float staticSwitch824_g1368 = min( staticSwitch845_g1368 , ( 1.0 - pow( saturate( max( dotResult5_g1369 , dotResult6_g1369 ) ) , 0.333 ) ) );
			#else
				float staticSwitch824_g1368 = staticSwitch845_g1368;
			#endif
			o.Smoothness = staticSwitch824_g1368;
			float White38_g1368 = 1.0;
			float dotResult835_g1368 = dot( Lightmap46_g1368 , float4( float3( 0.299, 0.587, 0.114 ) , 0.0 ) );
			float saferPower606_g1368 = abs( dotResult835_g1368 );
			#ifdef _LIGHTMAPOCCLUSION_ON
				float staticSwitch573_g1368 = pow( saferPower606_g1368 , _OcclusionPower );
			#else
				float staticSwitch573_g1368 = White38_g1368;
			#endif
			o.Occlusion = staticSwitch573_g1368;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19904
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2859;192,-1200;Inherit;False;Meenphie;0;;1368;b3ba55a08dd6b49c7be16c6f35cf2033;5,869,1,872,1,871,1,847,0,867,0;0;9;FLOAT3;625;FLOAT3;238;COLOR;624;FLOAT;96;FLOAT;97;FLOAT;95;FLOAT;156;FLOAT;427;FLOAT3;860
Node;AmplifyShaderEditor.StandardSurfaceOutputNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1092;512,-1200;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;0;Standard;Meenphie/Lightmapped/Simple/Opaque;False;False;False;False;False;False;False;True;True;False;False;False;False;False;False;True;False;False;True;True;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;ForwardOnly;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0.0001;0,0,0,0;VertexOffset;False;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;1092;0;2859;625
WireConnection;1092;1;2859;238
WireConnection;1092;2;2859;624
WireConnection;1092;3;2859;96
WireConnection;1092;4;2859;97
WireConnection;1092;5;2859;95
ASEEND*/
//CHKSM=C6ED1C28D02D23D66B85432B95FA097E15A36F84