// Made with Amplify Shader Editor v1.9.9.4
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Lightmapped/Simple/Cutout"
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
		[Meenphie_DrawerCategory(LIGHTMAPPING,true,0,0)] _CATEGORYLIGHTMAPPING( "CATEGORY LIGHTMAPPING", Float ) = 0
		[NoScaleOffset][SingleLineTexture] _Lightmap( "Lightmap", 2D ) = "black" {}
		[Toggle] _LightmapOcclusionEnabled( "Lightmap Occlusion Enabled", Float ) = 1
		_OcclusionPower( "Occlusion Power", Float ) = 1
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACELIGHTMAPPING( "CATEGORY SPACE LIGHTMAPPING", Float ) = 0
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		[HideInInspector] _texcoord3( "", 2D ) = "white" {}
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0
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
		#pragma shader_feature_local_fragment _METALLICMAP
		#pragma shader_feature_local_fragment _USEGEOMETRICANTIALIASING_ON
		#pragma shader_feature_local_fragment _GLOSSINESSMAP
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
		uniform float _EmissionFlags;
		uniform float _CATEGORYEMISSION;
		uniform float _CATEGORYSPACEEMISSION;
		uniform sampler2D _BumpMap;
		uniform float _NormalScale;
		uniform float4 _Color;
		uniform sampler2D _MainTex;
		uniform float4 _EmissionColor;
		uniform sampler2D _EmissionMap;
		uniform float _EmissionEnabled;
		uniform float _Metallic;
		uniform sampler2D _Lightmap;
		uniform float4 _Lightmap_ST;
		float4 _Lightmap_TexelSize;
		uniform float _CATEGORYLIGHTMAPPING;
		uniform float _CATEGORYSPACELIGHTMAPPING;
		uniform sampler2D _MetallicMap;
		uniform float _Glossiness;
		uniform sampler2D _GlossinessMap;
		uniform float _OcclusionPower;
		uniform float _LightmapOcclusionEnabled;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BumpMap830_g2287 = i.uv_texcoord;
			#ifdef _BUMPMAP
				float3 staticSwitch980_g2287 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap830_g2287 ), _NormalScale );
			#else
				float3 staticSwitch980_g2287 = float3( 0, 0, 1 );
			#endif
			float3 Normal_Map700_g2287 = staticSwitch980_g2287;
			o.Normal = Normal_Map700_g2287;
			float2 uv_MainTex907_g2287 = i.uv_texcoord;
			float4 Albedo6_g2287 = ( _Color * tex2D( _MainTex, uv_MainTex907_g2287 ) );
			o.Albedo = Albedo6_g2287.rgb;
			float4 temp_cast_1 = 0;
			float2 uv_EmissionMap81_g2287 = i.uv_texcoord;
			float4 lerpResult974_g2287 = lerp( temp_cast_1 , ( _EmissionColor + tex2D( _EmissionMap, uv_EmissionMap81_g2287 ) ) , _EmissionEnabled);
			float4 Emission86_g2287 = lerpResult974_g2287;
			float Metallic_Value893_g2287 = _Metallic;
			float localBicubicPrepare2_g2289 = ( 0.0 );
			float2 uv3_Lightmap = i.uv3_texcoord3 * _Lightmap_ST.xy + _Lightmap_ST.zw;
			float2 Input_UV100_g2289 = uv3_Lightmap;
			float2 UV2_g2289 = Input_UV100_g2289;
			float4 TexelSize2_g2289 = _Lightmap_TexelSize;
			float2 UV02_g2289 = float2( 0,0 );
			float2 UV12_g2289 = float2( 0,0 );
			float2 UV22_g2289 = float2( 0,0 );
			float2 UV32_g2289 = float2( 0,0 );
			float W02_g2289 = 0;
			float W12_g2289 = 0;
			{
			{
			 UV2_g2289 = UV2_g2289 * TexelSize2_g2289.zw - 0.5;
			    float2 f = frac( UV2_g2289 );
			    UV2_g2289 -= f;
			    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			    float4 xs = xn * xn * xn;
			    float4 ys = yn * yn * yn;
			    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			    float4 c = float4( UV2_g2289.x - 0.5, UV2_g2289.x + 1.5, UV2_g2289.y - 0.5, UV2_g2289.y + 1.5 );
			    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g2289.xyxy;
			    UV02_g2289 = off.xz;
			    UV12_g2289 = off.yz;
			    UV22_g2289 = off.xw;
			    UV32_g2289 = off.yw;
			    W02_g2289 = s.x / ( s.x + s.y );
			 W12_g2289 = s.z / ( s.z + s.w );
			}
			}
			float4 lerpResult46_g2289 = lerp( tex2D( _Lightmap, UV32_g2289 ) , tex2D( _Lightmap, UV22_g2289 ) , W02_g2289);
			float4 lerpResult45_g2289 = lerp( tex2D( _Lightmap, UV12_g2289 ) , tex2D( _Lightmap, UV02_g2289 ) , W02_g2289);
			float4 lerpResult44_g2289 = lerp( lerpResult46_g2289 , lerpResult45_g2289 , W12_g2289);
			float4 Output_2D131_g2289 = lerpResult44_g2289;
			float4 Lightmap_0925_g2287 = Output_2D131_g2289;
			float Lightmap_GUI886_g2287 = ( _CATEGORYLIGHTMAPPING + _CATEGORYSPACELIGHTMAPPING );
			float4 temp_cast_2 = (Lightmap_GUI886_g2287).xxxx;
			float4 lerpResult882_g2287 = lerp( Lightmap_0925_g2287 , temp_cast_2 , float4( 0,0,0,0 ));
			float4 Lightmap46_g2287 = lerpResult882_g2287;
			float4 temp_output_614_0_g2287 = ( Albedo6_g2287 * ( ( 1.0 - Metallic_Value893_g2287 ) * Lightmap46_g2287 ) );
			o.Emission = ( Emission86_g2287 + temp_output_614_0_g2287 ).rgb;
			float2 uv_MetallicMap48_g2287 = i.uv_texcoord;
			float saferPower803_g2287 = abs( tex2D( _MetallicMap, uv_MetallicMap48_g2287 ).a );
			#ifdef _METALLICMAP
				float staticSwitch846_g2287 = pow( saferPower803_g2287 , 3.0 );
			#else
				float staticSwitch846_g2287 = _Metallic;
			#endif
			float Metallic699_g2287 = staticSwitch846_g2287;
			o.Metallic = Metallic699_g2287;
			float2 uv_GlossinessMap64_g2287 = i.uv_texcoord;
			float saferPower804_g2287 = abs( tex2D( _GlossinessMap, uv_GlossinessMap64_g2287 ).a );
			#ifdef _GLOSSINESSMAP
				float staticSwitch845_g2287 = ( 1.0 - pow( saferPower804_g2287 , 3.0 ) );
			#else
				float staticSwitch845_g2287 = _Glossiness;
			#endif
			float3 ase_normalWS = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 temp_output_3_0_g2329 = ddx( ase_normalWS );
			float dotResult5_g2329 = dot( temp_output_3_0_g2329 , temp_output_3_0_g2329 );
			float3 temp_output_4_0_g2329 = ddy( ase_normalWS );
			float dotResult6_g2329 = dot( temp_output_4_0_g2329 , temp_output_4_0_g2329 );
			#ifdef _USEGEOMETRICANTIALIASING_ON
				float staticSwitch824_g2287 = min( staticSwitch845_g2287 , ( 1.0 - pow( saturate( max( dotResult5_g2329 , dotResult6_g2329 ) ) , 0.333 ) ) );
			#else
				float staticSwitch824_g2287 = staticSwitch845_g2287;
			#endif
			o.Smoothness = staticSwitch824_g2287;
			float White38_g2287 = 1.0;
			float dotResult835_g2287 = dot( Lightmap46_g2287 , float4( float3( 0.299, 0.587, 0.114 ) , 0.0 ) );
			float saferPower606_g2287 = abs( dotResult835_g2287 );
			float lerpResult973_g2287 = lerp( White38_g2287 , pow( saferPower606_g2287 , _OcclusionPower ) , _LightmapOcclusionEnabled);
			o.Occlusion = lerpResult973_g2287;
			o.Alpha = 1;
			clip( tex2D( _MainTex, uv_MainTex907_g2287 ).a - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19904
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;847;192,-1200;Inherit;False;Meenphie;0;;2287;b3ba55a08dd6b49c7be16c6f35cf2033;10,871,1,869,1,872,1,847,0,867,0,944,0,947,0,905,0,938,0,912,0;0;9;COLOR;625;FLOAT3;238;COLOR;624;FLOAT;96;FLOAT;97;FLOAT;95;FLOAT;156;FLOAT;427;FLOAT3;860
Node;AmplifyShaderEditor.StandardSurfaceOutputNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;343;512,-1200;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;0;Standard;Meenphie/Lightmapped/Simple/Cutout;False;False;False;False;False;False;False;True;True;False;False;False;False;False;True;True;False;False;True;True;False;Off;0;False;;0;False;;False;0;False;;0;False;;False;0;Masked;0.5;True;False;0;False;TransparentCutout;;AlphaTest;ForwardOnly;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0.0001;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;35;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;343;0;847;625
WireConnection;343;1;847;238
WireConnection;343;2;847;624
WireConnection;343;3;847;96
WireConnection;343;4;847;97
WireConnection;343;5;847;95
WireConnection;343;10;847;427
ASEEND*/
//CHKSM=3AEE6D00BDB5943C7222F8F4559DC0300B7B4E3A