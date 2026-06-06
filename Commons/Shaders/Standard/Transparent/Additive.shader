// Made with Amplify Shader Editor v1.9.9.9
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Standard/Transparent/Additive"
{
	Properties
	{
		[Meenphie_DrawerCategory(SURFACE OPTIONS,true,0,0)] _CATEGORY_SURFACEOPTIONS( "CATEGORY_SURFACEOPTIONS", Float ) = 1
		_Color( "DIffuse Color", Color ) = ( 0.9058824, 0.9058824, 0.9058824, 1 )
		[NoScaleOffset][SingleLineTexture] _MainTex( "Base Color", 2D ) = "white" {}
		[NoScaleOffset][SingleLineTexture] _BumpMap( "Normal", 2D ) = "bump" {}
		[NoScaleOffset][SingleLineTexture] _MetallicMap( "Metallic", 2D ) = "black" {}
		[NoScaleOffset][SingleLineTexture] _GlossinessMap( "Roughness", 2D ) = "black" {}
		_Metallic( "Metallic", Range( 0, 1 ) ) = 0
		_Glossiness( "Roughness", Range( 0, 1 ) ) = 0.5
		[Toggle( _USEGEOMETRICAA_ON )] _UseGeometricAA( "Use Geometric AA", Float ) = 1
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESURFACEOPTIONS( "CATEGORY SPACE SURFACEOPTIONS", Float ) = 0
		[Meenphie_DrawerCategory(EMISSION,true,0,0)] _CATEGORYEMISSION( "CATEGORY EMISSION", Float ) = 0
		[NoScaleOffset][SingleLineTexture] _EmissionMap( "Emission", 2D ) = "white" {}
		[Gamma] _EmissionColor( "Emission Color", Color ) = ( 1, 1, 1 )
		_EmissionIntensity( "Emission Intensity", Float ) = 0
		[Meenphie_DrawerEmissionFlags] _EmissionFlags( "Global Illumination", Float ) = 2
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACEEMISSION( "CATEGORY SPACE EMISSION", Float ) = 0
		[Meenphie_DrawerCategory(LIGHTMAPPING,true,0,0)] _CATEGORYLIGHTMAPPING( "CATEGORY LIGHTMAPPING", Float ) = 0
		[KeywordEnum( Disabled,Simple,SimpleLerp,RNM,RNMLerp )] _LightmapMode( "Lightmap Mode", Float ) = 0
		[NoScaleOffset][SingleLineTexture] _Lightmap0( "Lightmap 0", 2D ) = "black" {}
		[NoScaleOffset][SingleLineTexture] _Lightmap1( "Lightmap 1", 2D ) = "black" {}
		[NoScaleOffset][SingleLineTexture] _UdonRNMX0( "RNMX 0", 2D ) = "black" {}
		[NoScaleOffset][SingleLineTexture] _UdonRNMY0( "RNMY 0", 2D ) = "black" {}
		[NoScaleOffset][SingleLineTexture] _UdonRNMZ0( "RNMZ 0", 2D ) = "black" {}
		[NoScaleOffset][SingleLineTexture] _UdonRNMX1( "RNMX 1", 2D ) = "black" {}
		[NoScaleOffset][SingleLineTexture] _UdonRNMY1( "RNMY 1", 2D ) = "black" {}
		[NoScaleOffset][SingleLineTexture] _UdonRNMZ1( "RNMZ 1", 2D ) = "black" {}
		_UdonLightmapLerp( "Lightmap Lerp", Range( 0, 1 ) ) = 0
		[Toggle( _USEBICUBICFILTERING_ON )] _UseBicubicFiltering( "Use Bicubic Filtering", Float ) = 1
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACELIGHTMAPPING( "CATEGORY SPACE LIGHTMAPPING", Float ) = 0
		[Meenphie_DrawerCategory(STOCHASTIC,true,0,0)] _CATEGORYSTOCHASTIC( "CATEGORY STOCHASTIC", Float ) = 0
		[Toggle( _STOCHASTICENABLED_ON )] _StochasticEnabled( "Stochastic Enabled", Float ) = 0
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESTOCHASTIC( "CATEGORY SPACE STOCHASTIC", Float ) = 0
		[Meenphie_DrawerCategory(COLOR GRADING,true,0,0)] _CATEGORYCOLORGRADING( "CATEGORY COLOR GRADING", Float ) = 0
		[NoScaleOffset][SingleLineTexture] _LUT( "LUT", 3D ) = "black" {}
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACECOLORGRADING( "CATEGORY SPACE COLOR GRADING", Float ) = 0
		[Meenphie_DrawerCategory(SPECIAL EFFECTS,true,0,0)] _CATEGORYSPECIALEFFECTS( "CATEGORY SPECIAL EFFECTS", Float ) = 0
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESPECIALEFFECTS( "CATEGORY SPACE SPECIAL EFFECTS", Float ) = 0
		[Toggle( _DIRECTSPECULAR_ON )] _DirectSpecular( "Direct Speculars", Float ) = 1
		[Toggle( _INDIRECTSPECULARS_ON )] _IndirectSpeculars( "Indirect Speculars", Float ) = 1
		[HideInInspector] GenKey__GlossinessMap( "Assign keyword _GLOSSINESSMAP", Float ) = 1.0
		[HideInInspector] GenKey__MetallicMap( "Assign keyword _METALLICMAP", Float ) = 1.0
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0
		[HideInInspector] GenKey__MainTex( "Assign keyword _MAINTEX", Float ) = 1.0

	}

	SubShader
	{
		

		

		Tags { "RenderType"="Transparent" "Queue"="Transparent" }

	LOD 0

		

		Blend One One
		AlphaToMask Off
		Cull Back
		ColorMask RGBA
		ZWrite On
		ZClip True
		ZTest LEqual
		

		CGINCLUDE
			#pragma target 3.5
			

			float4 ComputeClipSpacePosition( float2 screenPosNorm, float deviceDepth )
			{
				float4 positionCS = float4( screenPosNorm * 2.0 - 1.0, deviceDepth, 1.0 );
			#if UNITY_UV_STARTS_AT_TOP
				positionCS.y = -positionCS.y;
			#endif
				return positionCS;
			}
		ENDCG

		
		Pass
		{
			Name "Unlit"
			Tags { "LightMode"="ForwardBase" }

			CGPROGRAM
				#define ASE_VERSION 19909

				#pragma vertex vert
				#pragma fragment frag
				#pragma multi_compile_instancing
				#include "UnityCG.cginc"

				#include "Packages/com.meenphie.commons/Commons/Shaders/Custom Expressions/IndirectSpecular.cginc"
				#include "UnityStandardUtils.cginc"
				#include "Packages/com.meenphie.commons/Commons/Shaders/Custom Expressions/DirectSpecular.cginc"
				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#define ASE_NEEDS_VERT_NORMAL
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
				#pragma shader_feature _LIGHTMAPDEBUG
				#pragma shader_feature_local _STOCHASTICENABLED_ON
				#pragma shader_feature_local _INDIRECTSPECULARS_ON
				#pragma shader_feature_local _MAINTEX
				#pragma shader_feature_local _METALLICMAP
				#pragma shader_feature_local _USEGEOMETRICAA_ON
				#pragma shader_feature_local _GLOSSINESSMAP
				#pragma shader_feature_local _BUMPMAP
				#pragma shader_feature_local _LIGHTMAPMODE_DISABLED _LIGHTMAPMODE_SIMPLE _LIGHTMAPMODE_SIMPLELERP _LIGHTMAPMODE_RNM _LIGHTMAPMODE_RNMLERP
				#pragma shader_feature_local _USEBICUBICFILTERING_ON
				#pragma shader_feature_local _DIRECTSPECULAR_ON


				struct appdata
				{
					float4 vertex : POSITION;
					half3 normal : NORMAL;
					float4 ase_texcoord : TEXCOORD0;
					float4 ase_tangent : TANGENT;
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct v2f
				{
					float4 pos : SV_POSITION;
					float4 ase_texcoord : TEXCOORD0;
					float4 ase_texcoord1 : TEXCOORD1;
					float4 ase_texcoord2 : TEXCOORD2;
					float4 ase_texcoord3 : TEXCOORD3;
					float4 ase_texcoord4 : TEXCOORD4;
					UNITY_VERTEX_INPUT_INSTANCE_ID
					UNITY_VERTEX_OUTPUT_STEREO
				};

				uniform float _CATEGORY_SURFACEOPTIONS;
				uniform float _EmissionFlags;
				uniform float _CATEGORYEMISSION;
				uniform float _CATEGORYSPACEEMISSION;
				uniform float _CATEGORYLIGHTMAPPING;
				uniform float _CATEGORYSPACELIGHTMAPPING;
				uniform float _CATEGORYSTOCHASTIC;
				uniform float _CATEGORYSPACESTOCHASTIC;
				uniform float _CATEGORYSPACECOLORGRADING;
				uniform float _CATEGORYCOLORGRADING;
				uniform float _CATEGORYSPACESPECIALEFFECTS;
				uniform float _CATEGORYSPECIALEFFECTS;
				uniform float _CATEGORYSPACESURFACEOPTIONS;
				uniform sampler3D _LUT;
				uniform float3 _EmissionColor;
				uniform sampler2D _EmissionMap;
				sampler2D _Sampler82968_g60856;
				uniform float _EmissionIntensity;
				uniform half4 _Color;
				uniform sampler2D _MainTex;
				sampler2D _Sampler82966_g60856;
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				sampler2D _Sampler82967_g60856;
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				sampler2D _Sampler82964_g60856;
				uniform sampler2D _BumpMap;
				sampler2D _Sampler82965_g60856;
				uniform sampler2D _Lightmap0;
				float4 _Lightmap0_TexelSize;
				uniform sampler2D _Lightmap1;
				float4 _Lightmap1_TexelSize;
				uniform float _UdonLightmapLerp;
				uniform sampler2D _UdonRNMX0;
				float4 _UdonRNMX0_TexelSize;
				uniform sampler2D _UdonRNMY0;
				uniform sampler2D _UdonRNMZ0;
				uniform sampler2D _UdonRNMX1;
				float4 _UdonRNMX1_TexelSize;
				uniform sampler2D _UdonRNMY1;
				uniform sampler2D _UdonRNMZ1;


				
				v2f vert( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					float3 ase_tangentWS = UnityObjectToWorldDir( v.ase_tangent );
					o.ase_texcoord1.xyz = ase_tangentWS;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					o.ase_texcoord2.xyz = ase_normalWS;
					float ase_tangentSign = v.ase_tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					o.ase_texcoord3.xyz = ase_bitangentWS;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					o.ase_texcoord4.xyz = ase_positionWS;
					
					o.ase_texcoord = v.ase_texcoord;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord1.w = 0;
					o.ase_texcoord2.w = 0;
					o.ase_texcoord3.w = 0;
					o.ase_texcoord4.w = 0;

					v.vertex.w = 1;
					o.pos = UnityObjectToClipPos( v.vertex );

					return o;
				}

				half4 frag( v2f IN  ) : SV_Target
				{
					UNITY_SETUP_INSTANCE_ID( IN );
					UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

					float4 ScreenPosNorm = float4( IN.pos.xy * ( _ScreenParams.zw - 1.0 ), IN.pos.zw );
					float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, IN.pos.z ) * IN.pos.w;
					float4 ScreenPos = ComputeScreenPos( ClipPos );

					float2 texCoord2357_g60856 = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0A2420_g60856 = texCoord2357_g60856;
					float2 temp_output_5_0_g60881 = UV0A2420_g60856;
					float2 UV633_g60881 = temp_output_5_0_g60881;
					float2 UV100_g60882 = UV633_g60881;
					float2 temp_output_51_0_g60882 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60882 * float2( 3.464,3.464 ) ) );
					float2 break55_g60882 = frac( temp_output_51_0_g60882 );
					float temp_output_56_0_g60882 = ( ( 1.0 - break55_g60882.x ) - break55_g60882.y );
					float2 temp_output_52_0_g60882 = floor( temp_output_51_0_g60882 );
					float2 temp_output_125_0_g60882 = ( temp_output_52_0_g60882 + float2( 1,1 ) );
					float2 ifLocalVar87_g60882 = 0;
					if( temp_output_56_0_g60882 > 0.0 )
					ifLocalVar87_g60882 = temp_output_52_0_g60882;
					else if( temp_output_56_0_g60882 == 0.0 )
					ifLocalVar87_g60882 = temp_output_125_0_g60882;
					else if( temp_output_56_0_g60882 < 0.0 )
					ifLocalVar87_g60882 = temp_output_125_0_g60882;
					float3 temp_output_7_0_g60883 = frac( ( (ifLocalVar87_g60882).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60883 = dot( temp_output_7_0_g60883 , ( (temp_output_7_0_g60883).yzx + 33.33 ) );
					float3 temp_output_12_0_g60883 = ( temp_output_7_0_g60883 + dotResult8_g60883 );
					float2 temp_output_597_0_g60881 = ( UV100_g60882 + frac( ( ( (temp_output_12_0_g60883).xx + (temp_output_12_0_g60883).yz ) * (temp_output_12_0_g60883).zy ) ) );
					float2 DDX631_g60881 = ddx( temp_output_5_0_g60881 );
					float2 DDY632_g60881 = ddy( temp_output_5_0_g60881 );
					float temp_output_65_0_g60882 = ( 0.0 - temp_output_56_0_g60882 );
					float ifLocalVar59_g60882 = 0;
					if( temp_output_56_0_g60882 <= 0.0 )
					ifLocalVar59_g60882 = temp_output_65_0_g60882;
					else
					ifLocalVar59_g60882 = temp_output_56_0_g60882;
					float temp_output_597_30_g60881 = ifLocalVar59_g60882;
					float2 temp_output_90_0_g60882 = ( temp_output_52_0_g60882 + float2( 0,1 ) );
					float2 temp_output_123_0_g60882 = ( temp_output_52_0_g60882 + float2( 1,0 ) );
					float2 ifLocalVar88_g60882 = 0;
					if( temp_output_56_0_g60882 > 0.0 )
					ifLocalVar88_g60882 = temp_output_90_0_g60882;
					else if( temp_output_56_0_g60882 == 0.0 )
					ifLocalVar88_g60882 = temp_output_123_0_g60882;
					else if( temp_output_56_0_g60882 < 0.0 )
					ifLocalVar88_g60882 = temp_output_123_0_g60882;
					float3 temp_output_7_0_g60884 = frac( ( (ifLocalVar88_g60882).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60884 = dot( temp_output_7_0_g60884 , ( (temp_output_7_0_g60884).yzx + 33.33 ) );
					float3 temp_output_12_0_g60884 = ( temp_output_7_0_g60884 + dotResult8_g60884 );
					float2 temp_output_597_26_g60881 = ( UV100_g60882 + frac( ( ( (temp_output_12_0_g60884).xx + (temp_output_12_0_g60884).yz ) * (temp_output_12_0_g60884).zy ) ) );
					float temp_output_66_0_g60882 = ( 1.0 - break55_g60882.y );
					float ifLocalVar60_g60882 = 0;
					if( temp_output_56_0_g60882 <= 0.0 )
					ifLocalVar60_g60882 = temp_output_66_0_g60882;
					else
					ifLocalVar60_g60882 = break55_g60882.y;
					float temp_output_597_28_g60881 = ifLocalVar60_g60882;
					float2 ifLocalVar89_g60882 = 0;
					if( temp_output_56_0_g60882 > 0.0 )
					ifLocalVar89_g60882 = temp_output_123_0_g60882;
					else if( temp_output_56_0_g60882 == 0.0 )
					ifLocalVar89_g60882 = temp_output_90_0_g60882;
					else if( temp_output_56_0_g60882 < 0.0 )
					ifLocalVar89_g60882 = temp_output_90_0_g60882;
					float3 temp_output_7_0_g60885 = frac( ( (ifLocalVar89_g60882).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60885 = dot( temp_output_7_0_g60885 , ( (temp_output_7_0_g60885).yzx + 33.33 ) );
					float3 temp_output_12_0_g60885 = ( temp_output_7_0_g60885 + dotResult8_g60885 );
					float2 temp_output_597_27_g60881 = ( UV100_g60882 + frac( ( ( (temp_output_12_0_g60885).xx + (temp_output_12_0_g60885).yz ) * (temp_output_12_0_g60885).zy ) ) );
					float temp_output_67_0_g60882 = ( 1.0 - break55_g60882.x );
					float ifLocalVar61_g60882 = 0;
					if( temp_output_56_0_g60882 <= 0.0 )
					ifLocalVar61_g60882 = temp_output_67_0_g60882;
					else
					ifLocalVar61_g60882 = break55_g60882.x;
					float temp_output_597_29_g60881 = ifLocalVar61_g60882;
					float4 Output_2D293_g60881 = ( ( tex2D( _Sampler82968_g60856, temp_output_597_0_g60881, DDX631_g60881, DDY632_g60881 ) * temp_output_597_30_g60881 ) + ( tex2D( _Sampler82968_g60856, temp_output_597_26_g60881, DDX631_g60881, DDY632_g60881 ) * temp_output_597_28_g60881 ) + ( tex2D( _Sampler82968_g60856, temp_output_597_27_g60881, DDX631_g60881, DDY632_g60881 ) * temp_output_597_29_g60881 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g60856 = Output_2D293_g60881;
					#else
					float4 staticSwitch1006_g60856 = tex2D( _EmissionMap, UV0A2420_g60856 );
					#endif
					float3 temp_output_2531_0_g60856 = (( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g60856 * _EmissionIntensity )).rgb;
					float3 Emission86_g60856 = temp_output_2531_0_g60856;
					float Black1185_g60856 = 0.0;
					float3 temp_cast_1 = (Black1185_g60856).xxx;
					#ifdef _MAINTEX
					float4 staticSwitch1549_g60856 = tex2D( _MainTex, UV0A2420_g60856 );
					#else
					float4 staticSwitch1549_g60856 = _Color;
					#endif
					float2 temp_output_5_0_g60871 = UV0A2420_g60856;
					float2 UV633_g60871 = temp_output_5_0_g60871;
					float2 UV100_g60872 = UV633_g60871;
					float2 temp_output_51_0_g60872 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60872 * float2( 3.464,3.464 ) ) );
					float2 break55_g60872 = frac( temp_output_51_0_g60872 );
					float temp_output_56_0_g60872 = ( ( 1.0 - break55_g60872.x ) - break55_g60872.y );
					float2 temp_output_52_0_g60872 = floor( temp_output_51_0_g60872 );
					float2 temp_output_125_0_g60872 = ( temp_output_52_0_g60872 + float2( 1,1 ) );
					float2 ifLocalVar87_g60872 = 0;
					if( temp_output_56_0_g60872 > 0.0 )
					ifLocalVar87_g60872 = temp_output_52_0_g60872;
					else if( temp_output_56_0_g60872 == 0.0 )
					ifLocalVar87_g60872 = temp_output_125_0_g60872;
					else if( temp_output_56_0_g60872 < 0.0 )
					ifLocalVar87_g60872 = temp_output_125_0_g60872;
					float3 temp_output_7_0_g60873 = frac( ( (ifLocalVar87_g60872).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60873 = dot( temp_output_7_0_g60873 , ( (temp_output_7_0_g60873).yzx + 33.33 ) );
					float3 temp_output_12_0_g60873 = ( temp_output_7_0_g60873 + dotResult8_g60873 );
					float2 temp_output_597_0_g60871 = ( UV100_g60872 + frac( ( ( (temp_output_12_0_g60873).xx + (temp_output_12_0_g60873).yz ) * (temp_output_12_0_g60873).zy ) ) );
					float2 DDX631_g60871 = ddx( temp_output_5_0_g60871 );
					float2 DDY632_g60871 = ddy( temp_output_5_0_g60871 );
					float temp_output_65_0_g60872 = ( 0.0 - temp_output_56_0_g60872 );
					float ifLocalVar59_g60872 = 0;
					if( temp_output_56_0_g60872 <= 0.0 )
					ifLocalVar59_g60872 = temp_output_65_0_g60872;
					else
					ifLocalVar59_g60872 = temp_output_56_0_g60872;
					float temp_output_597_30_g60871 = ifLocalVar59_g60872;
					float2 temp_output_90_0_g60872 = ( temp_output_52_0_g60872 + float2( 0,1 ) );
					float2 temp_output_123_0_g60872 = ( temp_output_52_0_g60872 + float2( 1,0 ) );
					float2 ifLocalVar88_g60872 = 0;
					if( temp_output_56_0_g60872 > 0.0 )
					ifLocalVar88_g60872 = temp_output_90_0_g60872;
					else if( temp_output_56_0_g60872 == 0.0 )
					ifLocalVar88_g60872 = temp_output_123_0_g60872;
					else if( temp_output_56_0_g60872 < 0.0 )
					ifLocalVar88_g60872 = temp_output_123_0_g60872;
					float3 temp_output_7_0_g60874 = frac( ( (ifLocalVar88_g60872).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60874 = dot( temp_output_7_0_g60874 , ( (temp_output_7_0_g60874).yzx + 33.33 ) );
					float3 temp_output_12_0_g60874 = ( temp_output_7_0_g60874 + dotResult8_g60874 );
					float2 temp_output_597_26_g60871 = ( UV100_g60872 + frac( ( ( (temp_output_12_0_g60874).xx + (temp_output_12_0_g60874).yz ) * (temp_output_12_0_g60874).zy ) ) );
					float temp_output_66_0_g60872 = ( 1.0 - break55_g60872.y );
					float ifLocalVar60_g60872 = 0;
					if( temp_output_56_0_g60872 <= 0.0 )
					ifLocalVar60_g60872 = temp_output_66_0_g60872;
					else
					ifLocalVar60_g60872 = break55_g60872.y;
					float temp_output_597_28_g60871 = ifLocalVar60_g60872;
					float2 ifLocalVar89_g60872 = 0;
					if( temp_output_56_0_g60872 > 0.0 )
					ifLocalVar89_g60872 = temp_output_123_0_g60872;
					else if( temp_output_56_0_g60872 == 0.0 )
					ifLocalVar89_g60872 = temp_output_90_0_g60872;
					else if( temp_output_56_0_g60872 < 0.0 )
					ifLocalVar89_g60872 = temp_output_90_0_g60872;
					float3 temp_output_7_0_g60875 = frac( ( (ifLocalVar89_g60872).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60875 = dot( temp_output_7_0_g60875 , ( (temp_output_7_0_g60875).yzx + 33.33 ) );
					float3 temp_output_12_0_g60875 = ( temp_output_7_0_g60875 + dotResult8_g60875 );
					float2 temp_output_597_27_g60871 = ( UV100_g60872 + frac( ( ( (temp_output_12_0_g60875).xx + (temp_output_12_0_g60875).yz ) * (temp_output_12_0_g60875).zy ) ) );
					float temp_output_67_0_g60872 = ( 1.0 - break55_g60872.x );
					float ifLocalVar61_g60872 = 0;
					if( temp_output_56_0_g60872 <= 0.0 )
					ifLocalVar61_g60872 = temp_output_67_0_g60872;
					else
					ifLocalVar61_g60872 = break55_g60872.x;
					float temp_output_597_29_g60871 = ifLocalVar61_g60872;
					float4 Output_2D293_g60871 = ( ( tex2D( _Sampler82966_g60856, temp_output_597_0_g60871, DDX631_g60871, DDY632_g60871 ) * temp_output_597_30_g60871 ) + ( tex2D( _Sampler82966_g60856, temp_output_597_26_g60871, DDX631_g60871, DDY632_g60871 ) * temp_output_597_28_g60871 ) + ( tex2D( _Sampler82966_g60856, temp_output_597_27_g60871, DDX631_g60871, DDY632_g60871 ) * temp_output_597_29_g60871 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g60856 = Output_2D293_g60871;
					#else
					float4 staticSwitch1001_g60856 = staticSwitch1549_g60856;
					#endif
					float3 temp_output_2532_0_g60856 = (staticSwitch1001_g60856).rgb;
					float3 oAlbedo6_g60856 = temp_output_2532_0_g60856;
					float3 Color1_g60915 = oAlbedo6_g60856;
					#ifdef _METALLICMAP
					float staticSwitch846_g60856 = tex2D( _MetallicMap, UV0A2420_g60856 ).r;
					#else
					float staticSwitch846_g60856 = _Metallic;
					#endif
					float2 temp_output_5_0_g60891 = UV0A2420_g60856;
					float2 UV633_g60891 = temp_output_5_0_g60891;
					float2 UV100_g60892 = UV633_g60891;
					float2 temp_output_51_0_g60892 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60892 * float2( 3.464,3.464 ) ) );
					float2 break55_g60892 = frac( temp_output_51_0_g60892 );
					float temp_output_56_0_g60892 = ( ( 1.0 - break55_g60892.x ) - break55_g60892.y );
					float2 temp_output_52_0_g60892 = floor( temp_output_51_0_g60892 );
					float2 temp_output_125_0_g60892 = ( temp_output_52_0_g60892 + float2( 1,1 ) );
					float2 ifLocalVar87_g60892 = 0;
					if( temp_output_56_0_g60892 > 0.0 )
					ifLocalVar87_g60892 = temp_output_52_0_g60892;
					else if( temp_output_56_0_g60892 == 0.0 )
					ifLocalVar87_g60892 = temp_output_125_0_g60892;
					else if( temp_output_56_0_g60892 < 0.0 )
					ifLocalVar87_g60892 = temp_output_125_0_g60892;
					float3 temp_output_7_0_g60893 = frac( ( (ifLocalVar87_g60892).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60893 = dot( temp_output_7_0_g60893 , ( (temp_output_7_0_g60893).yzx + 33.33 ) );
					float3 temp_output_12_0_g60893 = ( temp_output_7_0_g60893 + dotResult8_g60893 );
					float2 temp_output_597_0_g60891 = ( UV100_g60892 + frac( ( ( (temp_output_12_0_g60893).xx + (temp_output_12_0_g60893).yz ) * (temp_output_12_0_g60893).zy ) ) );
					float2 DDX631_g60891 = ddx( temp_output_5_0_g60891 );
					float2 DDY632_g60891 = ddy( temp_output_5_0_g60891 );
					float temp_output_65_0_g60892 = ( 0.0 - temp_output_56_0_g60892 );
					float ifLocalVar59_g60892 = 0;
					if( temp_output_56_0_g60892 <= 0.0 )
					ifLocalVar59_g60892 = temp_output_65_0_g60892;
					else
					ifLocalVar59_g60892 = temp_output_56_0_g60892;
					float temp_output_597_30_g60891 = ifLocalVar59_g60892;
					float2 temp_output_90_0_g60892 = ( temp_output_52_0_g60892 + float2( 0,1 ) );
					float2 temp_output_123_0_g60892 = ( temp_output_52_0_g60892 + float2( 1,0 ) );
					float2 ifLocalVar88_g60892 = 0;
					if( temp_output_56_0_g60892 > 0.0 )
					ifLocalVar88_g60892 = temp_output_90_0_g60892;
					else if( temp_output_56_0_g60892 == 0.0 )
					ifLocalVar88_g60892 = temp_output_123_0_g60892;
					else if( temp_output_56_0_g60892 < 0.0 )
					ifLocalVar88_g60892 = temp_output_123_0_g60892;
					float3 temp_output_7_0_g60894 = frac( ( (ifLocalVar88_g60892).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60894 = dot( temp_output_7_0_g60894 , ( (temp_output_7_0_g60894).yzx + 33.33 ) );
					float3 temp_output_12_0_g60894 = ( temp_output_7_0_g60894 + dotResult8_g60894 );
					float2 temp_output_597_26_g60891 = ( UV100_g60892 + frac( ( ( (temp_output_12_0_g60894).xx + (temp_output_12_0_g60894).yz ) * (temp_output_12_0_g60894).zy ) ) );
					float temp_output_66_0_g60892 = ( 1.0 - break55_g60892.y );
					float ifLocalVar60_g60892 = 0;
					if( temp_output_56_0_g60892 <= 0.0 )
					ifLocalVar60_g60892 = temp_output_66_0_g60892;
					else
					ifLocalVar60_g60892 = break55_g60892.y;
					float temp_output_597_28_g60891 = ifLocalVar60_g60892;
					float2 ifLocalVar89_g60892 = 0;
					if( temp_output_56_0_g60892 > 0.0 )
					ifLocalVar89_g60892 = temp_output_123_0_g60892;
					else if( temp_output_56_0_g60892 == 0.0 )
					ifLocalVar89_g60892 = temp_output_90_0_g60892;
					else if( temp_output_56_0_g60892 < 0.0 )
					ifLocalVar89_g60892 = temp_output_90_0_g60892;
					float3 temp_output_7_0_g60895 = frac( ( (ifLocalVar89_g60892).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60895 = dot( temp_output_7_0_g60895 , ( (temp_output_7_0_g60895).yzx + 33.33 ) );
					float3 temp_output_12_0_g60895 = ( temp_output_7_0_g60895 + dotResult8_g60895 );
					float2 temp_output_597_27_g60891 = ( UV100_g60892 + frac( ( ( (temp_output_12_0_g60895).xx + (temp_output_12_0_g60895).yz ) * (temp_output_12_0_g60895).zy ) ) );
					float temp_output_67_0_g60892 = ( 1.0 - break55_g60892.x );
					float ifLocalVar61_g60892 = 0;
					if( temp_output_56_0_g60892 <= 0.0 )
					ifLocalVar61_g60892 = temp_output_67_0_g60892;
					else
					ifLocalVar61_g60892 = break55_g60892.x;
					float temp_output_597_29_g60891 = ifLocalVar61_g60892;
					float4 Output_2D293_g60891 = ( ( tex2D( _Sampler82967_g60856, temp_output_597_0_g60891, DDX631_g60891, DDY632_g60891 ) * temp_output_597_30_g60891 ) + ( tex2D( _Sampler82967_g60856, temp_output_597_26_g60891, DDX631_g60891, DDY632_g60891 ) * temp_output_597_28_g60891 ) + ( tex2D( _Sampler82967_g60856, temp_output_597_27_g60891, DDX631_g60891, DDY632_g60891 ) * temp_output_597_29_g60891 ) );
					float4 break31_g60891 = Output_2D293_g60891;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g60856 = break31_g60891.r;
					#else
					float staticSwitch1005_g60856 = staticSwitch846_g60856;
					#endif
					float Metallic1239_g60856 = staticSwitch1005_g60856;
					float Metallic1_g60915 = Metallic1239_g60856;
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g60856 = tex2D( _GlossinessMap, UV0A2420_g60856 ).r;
					#else
					float staticSwitch845_g60856 = _Glossiness;
					#endif
					float2 temp_output_5_0_g60876 = UV0A2420_g60856;
					float2 UV633_g60876 = temp_output_5_0_g60876;
					float2 UV100_g60877 = UV633_g60876;
					float2 temp_output_51_0_g60877 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60877 * float2( 3.464,3.464 ) ) );
					float2 break55_g60877 = frac( temp_output_51_0_g60877 );
					float temp_output_56_0_g60877 = ( ( 1.0 - break55_g60877.x ) - break55_g60877.y );
					float2 temp_output_52_0_g60877 = floor( temp_output_51_0_g60877 );
					float2 temp_output_125_0_g60877 = ( temp_output_52_0_g60877 + float2( 1,1 ) );
					float2 ifLocalVar87_g60877 = 0;
					if( temp_output_56_0_g60877 > 0.0 )
					ifLocalVar87_g60877 = temp_output_52_0_g60877;
					else if( temp_output_56_0_g60877 == 0.0 )
					ifLocalVar87_g60877 = temp_output_125_0_g60877;
					else if( temp_output_56_0_g60877 < 0.0 )
					ifLocalVar87_g60877 = temp_output_125_0_g60877;
					float3 temp_output_7_0_g60878 = frac( ( (ifLocalVar87_g60877).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60878 = dot( temp_output_7_0_g60878 , ( (temp_output_7_0_g60878).yzx + 33.33 ) );
					float3 temp_output_12_0_g60878 = ( temp_output_7_0_g60878 + dotResult8_g60878 );
					float2 temp_output_597_0_g60876 = ( UV100_g60877 + frac( ( ( (temp_output_12_0_g60878).xx + (temp_output_12_0_g60878).yz ) * (temp_output_12_0_g60878).zy ) ) );
					float2 DDX631_g60876 = ddx( temp_output_5_0_g60876 );
					float2 DDY632_g60876 = ddy( temp_output_5_0_g60876 );
					float temp_output_65_0_g60877 = ( 0.0 - temp_output_56_0_g60877 );
					float ifLocalVar59_g60877 = 0;
					if( temp_output_56_0_g60877 <= 0.0 )
					ifLocalVar59_g60877 = temp_output_65_0_g60877;
					else
					ifLocalVar59_g60877 = temp_output_56_0_g60877;
					float temp_output_597_30_g60876 = ifLocalVar59_g60877;
					float2 temp_output_90_0_g60877 = ( temp_output_52_0_g60877 + float2( 0,1 ) );
					float2 temp_output_123_0_g60877 = ( temp_output_52_0_g60877 + float2( 1,0 ) );
					float2 ifLocalVar88_g60877 = 0;
					if( temp_output_56_0_g60877 > 0.0 )
					ifLocalVar88_g60877 = temp_output_90_0_g60877;
					else if( temp_output_56_0_g60877 == 0.0 )
					ifLocalVar88_g60877 = temp_output_123_0_g60877;
					else if( temp_output_56_0_g60877 < 0.0 )
					ifLocalVar88_g60877 = temp_output_123_0_g60877;
					float3 temp_output_7_0_g60879 = frac( ( (ifLocalVar88_g60877).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60879 = dot( temp_output_7_0_g60879 , ( (temp_output_7_0_g60879).yzx + 33.33 ) );
					float3 temp_output_12_0_g60879 = ( temp_output_7_0_g60879 + dotResult8_g60879 );
					float2 temp_output_597_26_g60876 = ( UV100_g60877 + frac( ( ( (temp_output_12_0_g60879).xx + (temp_output_12_0_g60879).yz ) * (temp_output_12_0_g60879).zy ) ) );
					float temp_output_66_0_g60877 = ( 1.0 - break55_g60877.y );
					float ifLocalVar60_g60877 = 0;
					if( temp_output_56_0_g60877 <= 0.0 )
					ifLocalVar60_g60877 = temp_output_66_0_g60877;
					else
					ifLocalVar60_g60877 = break55_g60877.y;
					float temp_output_597_28_g60876 = ifLocalVar60_g60877;
					float2 ifLocalVar89_g60877 = 0;
					if( temp_output_56_0_g60877 > 0.0 )
					ifLocalVar89_g60877 = temp_output_123_0_g60877;
					else if( temp_output_56_0_g60877 == 0.0 )
					ifLocalVar89_g60877 = temp_output_90_0_g60877;
					else if( temp_output_56_0_g60877 < 0.0 )
					ifLocalVar89_g60877 = temp_output_90_0_g60877;
					float3 temp_output_7_0_g60880 = frac( ( (ifLocalVar89_g60877).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60880 = dot( temp_output_7_0_g60880 , ( (temp_output_7_0_g60880).yzx + 33.33 ) );
					float3 temp_output_12_0_g60880 = ( temp_output_7_0_g60880 + dotResult8_g60880 );
					float2 temp_output_597_27_g60876 = ( UV100_g60877 + frac( ( ( (temp_output_12_0_g60880).xx + (temp_output_12_0_g60880).yz ) * (temp_output_12_0_g60880).zy ) ) );
					float temp_output_67_0_g60877 = ( 1.0 - break55_g60877.x );
					float ifLocalVar61_g60877 = 0;
					if( temp_output_56_0_g60877 <= 0.0 )
					ifLocalVar61_g60877 = temp_output_67_0_g60877;
					else
					ifLocalVar61_g60877 = break55_g60877.x;
					float temp_output_597_29_g60876 = ifLocalVar61_g60877;
					float4 Output_2D293_g60876 = ( ( tex2D( _Sampler82964_g60856, temp_output_597_0_g60876, DDX631_g60876, DDY632_g60876 ) * temp_output_597_30_g60876 ) + ( tex2D( _Sampler82964_g60856, temp_output_597_26_g60876, DDX631_g60876, DDY632_g60876 ) * temp_output_597_28_g60876 ) + ( tex2D( _Sampler82964_g60856, temp_output_597_27_g60876, DDX631_g60876, DDY632_g60876 ) * temp_output_597_29_g60876 ) );
					float4 break31_g60876 = Output_2D293_g60876;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g60856 = ( 1.0 - break31_g60876.r );
					#else
					float staticSwitch1004_g60856 = ( 1.0 - staticSwitch845_g60856 );
					#endif
					float temp_output_19_0_g60898 = staticSwitch1004_g60856;
					float2 temp_output_5_0_g60866 = UV0A2420_g60856;
					float2 UV633_g60866 = temp_output_5_0_g60866;
					float2 UV100_g60867 = UV633_g60866;
					float2 temp_output_51_0_g60867 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60867 * float2( 3.464,3.464 ) ) );
					float2 break55_g60867 = frac( temp_output_51_0_g60867 );
					float temp_output_56_0_g60867 = ( ( 1.0 - break55_g60867.x ) - break55_g60867.y );
					float2 temp_output_52_0_g60867 = floor( temp_output_51_0_g60867 );
					float2 temp_output_125_0_g60867 = ( temp_output_52_0_g60867 + float2( 1,1 ) );
					float2 ifLocalVar87_g60867 = 0;
					if( temp_output_56_0_g60867 > 0.0 )
					ifLocalVar87_g60867 = temp_output_52_0_g60867;
					else if( temp_output_56_0_g60867 == 0.0 )
					ifLocalVar87_g60867 = temp_output_125_0_g60867;
					else if( temp_output_56_0_g60867 < 0.0 )
					ifLocalVar87_g60867 = temp_output_125_0_g60867;
					float3 temp_output_7_0_g60868 = frac( ( (ifLocalVar87_g60867).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60868 = dot( temp_output_7_0_g60868 , ( (temp_output_7_0_g60868).yzx + 33.33 ) );
					float3 temp_output_12_0_g60868 = ( temp_output_7_0_g60868 + dotResult8_g60868 );
					float2 temp_output_597_0_g60866 = ( UV100_g60867 + frac( ( ( (temp_output_12_0_g60868).xx + (temp_output_12_0_g60868).yz ) * (temp_output_12_0_g60868).zy ) ) );
					float2 DDX631_g60866 = ddx( temp_output_5_0_g60866 );
					float2 DDY632_g60866 = ddy( temp_output_5_0_g60866 );
					float Input_Scale617_g60866 = 1.5;
					float temp_output_65_0_g60867 = ( 0.0 - temp_output_56_0_g60867 );
					float ifLocalVar59_g60867 = 0;
					if( temp_output_56_0_g60867 <= 0.0 )
					ifLocalVar59_g60867 = temp_output_65_0_g60867;
					else
					ifLocalVar59_g60867 = temp_output_56_0_g60867;
					float temp_output_597_30_g60866 = ifLocalVar59_g60867;
					float2 temp_output_90_0_g60867 = ( temp_output_52_0_g60867 + float2( 0,1 ) );
					float2 temp_output_123_0_g60867 = ( temp_output_52_0_g60867 + float2( 1,0 ) );
					float2 ifLocalVar88_g60867 = 0;
					if( temp_output_56_0_g60867 > 0.0 )
					ifLocalVar88_g60867 = temp_output_90_0_g60867;
					else if( temp_output_56_0_g60867 == 0.0 )
					ifLocalVar88_g60867 = temp_output_123_0_g60867;
					else if( temp_output_56_0_g60867 < 0.0 )
					ifLocalVar88_g60867 = temp_output_123_0_g60867;
					float3 temp_output_7_0_g60869 = frac( ( (ifLocalVar88_g60867).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60869 = dot( temp_output_7_0_g60869 , ( (temp_output_7_0_g60869).yzx + 33.33 ) );
					float3 temp_output_12_0_g60869 = ( temp_output_7_0_g60869 + dotResult8_g60869 );
					float2 temp_output_597_26_g60866 = ( UV100_g60867 + frac( ( ( (temp_output_12_0_g60869).xx + (temp_output_12_0_g60869).yz ) * (temp_output_12_0_g60869).zy ) ) );
					float temp_output_66_0_g60867 = ( 1.0 - break55_g60867.y );
					float ifLocalVar60_g60867 = 0;
					if( temp_output_56_0_g60867 <= 0.0 )
					ifLocalVar60_g60867 = temp_output_66_0_g60867;
					else
					ifLocalVar60_g60867 = break55_g60867.y;
					float temp_output_597_28_g60866 = ifLocalVar60_g60867;
					float2 ifLocalVar89_g60867 = 0;
					if( temp_output_56_0_g60867 > 0.0 )
					ifLocalVar89_g60867 = temp_output_123_0_g60867;
					else if( temp_output_56_0_g60867 == 0.0 )
					ifLocalVar89_g60867 = temp_output_90_0_g60867;
					else if( temp_output_56_0_g60867 < 0.0 )
					ifLocalVar89_g60867 = temp_output_90_0_g60867;
					float3 temp_output_7_0_g60870 = frac( ( (ifLocalVar89_g60867).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60870 = dot( temp_output_7_0_g60870 , ( (temp_output_7_0_g60870).yzx + 33.33 ) );
					float3 temp_output_12_0_g60870 = ( temp_output_7_0_g60870 + dotResult8_g60870 );
					float2 temp_output_597_27_g60866 = ( UV100_g60867 + frac( ( ( (temp_output_12_0_g60870).xx + (temp_output_12_0_g60870).yz ) * (temp_output_12_0_g60870).zy ) ) );
					float temp_output_67_0_g60867 = ( 1.0 - break55_g60867.x );
					float ifLocalVar61_g60867 = 0;
					if( temp_output_56_0_g60867 <= 0.0 )
					ifLocalVar61_g60867 = temp_output_67_0_g60867;
					else
					ifLocalVar61_g60867 = break55_g60867.x;
					float temp_output_597_29_g60866 = ifLocalVar61_g60867;
					float3 Output_2D_Normal641_g60866 = ( ( UnpackScaleNormal( tex2D( _Sampler82965_g60856, temp_output_597_0_g60866, DDX631_g60866, DDY632_g60866 ), Input_Scale617_g60866 ) * temp_output_597_30_g60866 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g60856, temp_output_597_26_g60866, DDX631_g60866, DDY632_g60866 ), Input_Scale617_g60866 ) * temp_output_597_28_g60866 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g60856, temp_output_597_27_g60866, DDX631_g60866, DDY632_g60866 ), Input_Scale617_g60866 ) * float3( 0,0,0 ) * temp_output_597_29_g60866 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g60856 = Output_2D_Normal641_g60866;
					#else
					float3 staticSwitch1003_g60856 = UnpackScaleNormal( tex2D( _BumpMap, UV0A2420_g60856 ), 1.5 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g60856 = staticSwitch1003_g60856;
					#else
					float3 staticSwitch980_g60856 = float3( 0, 0, 1 );
					#endif
					float3 normalizeResult2878_g60856 = normalize( staticSwitch980_g60856 );
					float3 Normal_Map700_g60856 = normalizeResult2878_g60856;
					float3 ase_tangentWS = IN.ase_texcoord1.xyz;
					float3 ase_normalWS = IN.ase_texcoord2.xyz;
					float3 ase_bitangentWS = IN.ase_texcoord3.xyz;
					float3 tanToWorld0 = float3( ase_tangentWS.x, ase_bitangentWS.x, ase_normalWS.x );
					float3 tanToWorld1 = float3( ase_tangentWS.y, ase_bitangentWS.y, ase_normalWS.y );
					float3 tanToWorld2 = float3( ase_tangentWS.z, ase_bitangentWS.z, ase_normalWS.z );
					float3 tanNormal2504_g60856 = Normal_Map700_g60856;
					float3 worldNormal2504_g60856 = normalize( float3( dot( tanToWorld0, tanNormal2504_g60856 ), dot( tanToWorld1, tanNormal2504_g60856 ), dot( tanToWorld2, tanNormal2504_g60856 ) ) );
					float3 World_Normal2508_g60856 = worldNormal2504_g60856;
					float3 tanNormal2_g60898 = World_Normal2508_g60856;
					float3 worldNormal2_g60898 = float3( dot( tanToWorld0, tanNormal2_g60898 ), dot( tanToWorld1, tanNormal2_g60898 ), dot( tanToWorld2, tanNormal2_g60898 ) );
					float3 temp_output_3_0_g60898 = ddx( worldNormal2_g60898 );
					float dotResult5_g60898 = dot( temp_output_3_0_g60898 , temp_output_3_0_g60898 );
					float3 temp_output_4_0_g60898 = ddy( worldNormal2_g60898 );
					float dotResult6_g60898 = dot( temp_output_4_0_g60898 , temp_output_4_0_g60898 );
					#ifdef _USEGEOMETRICAA_ON
					float staticSwitch15_g60898 = min( temp_output_19_0_g60898, ( 1.0 - pow( saturate( max( dotResult5_g60898, dotResult6_g60898 ) ) , 0.25 ) ) );
					#else
					float staticSwitch15_g60898 = temp_output_19_0_g60898;
					#endif
					float Smoothness1399_g60856 = staticSwitch15_g60898;
					float Smoothness1_g60915 = Smoothness1399_g60856;
					float3 ase_positionWS = IN.ase_texcoord4.xyz;
					float3 ase_viewVectorWS = ( ( unity_OrthoParams.w == 0 ) ? _WorldSpaceCameraPos - ase_positionWS : UNITY_MATRIX_V[ 2 ].xyz );
					float3 ase_viewDirWS = normalize( ase_viewVectorWS );
					float3 View_Direction2511_g60856 = ase_viewDirWS;
					float3 ViewDir1_g60915 = View_Direction2511_g60856;
					float3 World_Position2505_g60856 = ase_positionWS;
					float3 WorldPos1_g60915 = World_Position2505_g60856;
					float3 WorldNormal1_g60915 = World_Normal2508_g60856;
					float White38_g60856 = 1.0;
					float4 temp_cast_2 = (Black1185_g60856).xxxx;
					float4 texCoord2426_g60856 = IN.ase_texcoord;
					texCoord2426_g60856.xy = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0B2361_g60856 = (texCoord2426_g60856).zw;
					float localBicubicPrepare2_g60865 = ( 0.0 );
					float2 Input_UV100_g60865 = UV0B2361_g60856;
					float2 UV2_g60865 = Input_UV100_g60865;
					float4 TexelSize2_g60865 = _Lightmap0_TexelSize;
					float2 UV02_g60865 = float2( 0,0 );
					float2 UV12_g60865 = float2( 0,0 );
					float2 UV22_g60865 = float2( 0,0 );
					float2 UV32_g60865 = float2( 0,0 );
					float W02_g60865 = 0;
					float W12_g60865 = 0;
					{
					{
					 UV2_g60865 = UV2_g60865 * TexelSize2_g60865.zw - 0.5;
					    float2 f = frac( UV2_g60865 );
					    UV2_g60865 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g60865.x - 0.5, UV2_g60865.x + 1.5, UV2_g60865.y - 0.5, UV2_g60865.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60865.xyxy;
					    UV02_g60865 = off.xz;
					    UV12_g60865 = off.yz;
					    UV22_g60865 = off.xw;
					    UV32_g60865 = off.yw;
					    W02_g60865 = s.x / ( s.x + s.y );
					 W12_g60865 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g60865 = lerp( tex2D( _Lightmap0, UV32_g60865 ) , tex2D( _Lightmap0, UV22_g60865 ) , W02_g60865);
					float4 lerpResult45_g60865 = lerp( tex2D( _Lightmap0, UV12_g60865 ) , tex2D( _Lightmap0, UV02_g60865 ) , W02_g60865);
					float4 lerpResult44_g60865 = lerp( lerpResult46_g60865 , lerpResult45_g60865 , W12_g60865);
					float4 Output_2D_Auto131_g60865 = lerpResult44_g60865;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g60856 = Output_2D_Auto131_g60865;
					#else
					float4 staticSwitch1092_g60856 = float4( tex2D( _Lightmap0, UV0B2361_g60856 ).rgb , 0.0 );
					#endif
					float4 Lightmap_0925_g60856 = staticSwitch1092_g60856;
					float localBicubicPrepare2_g60863 = ( 0.0 );
					float2 Input_UV100_g60863 = UV0B2361_g60856;
					float2 UV2_g60863 = Input_UV100_g60863;
					float4 TexelSize2_g60863 = _Lightmap1_TexelSize;
					float2 UV02_g60863 = float2( 0,0 );
					float2 UV12_g60863 = float2( 0,0 );
					float2 UV22_g60863 = float2( 0,0 );
					float2 UV32_g60863 = float2( 0,0 );
					float W02_g60863 = 0;
					float W12_g60863 = 0;
					{
					{
					 UV2_g60863 = UV2_g60863 * TexelSize2_g60863.zw - 0.5;
					    float2 f = frac( UV2_g60863 );
					    UV2_g60863 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g60863.x - 0.5, UV2_g60863.x + 1.5, UV2_g60863.y - 0.5, UV2_g60863.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60863.xyxy;
					    UV02_g60863 = off.xz;
					    UV12_g60863 = off.yz;
					    UV22_g60863 = off.xw;
					    UV32_g60863 = off.yw;
					    W02_g60863 = s.x / ( s.x + s.y );
					 W12_g60863 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g60863 = lerp( tex2D( _Lightmap1, UV32_g60863 ) , tex2D( _Lightmap1, UV22_g60863 ) , W02_g60863);
					float4 lerpResult45_g60863 = lerp( tex2D( _Lightmap1, UV12_g60863 ) , tex2D( _Lightmap1, UV02_g60863 ) , W02_g60863);
					float4 lerpResult44_g60863 = lerp( lerpResult46_g60863 , lerpResult45_g60863 , W12_g60863);
					float4 Output_2D_Auto131_g60863 = lerpResult44_g60863;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g60856 = Output_2D_Auto131_g60863;
					#else
					float4 staticSwitch1088_g60856 = tex2D( _Lightmap1, UV0B2361_g60856 );
					#endif
					float4 Lightmap_1956_g60856 = staticSwitch1088_g60856;
					float Lightmap_Lerp_Value969_g60856 = _UdonLightmapLerp;
					float4 lerpResult442_g60856 = lerp( Lightmap_0925_g60856 , Lightmap_1956_g60856 , Lightmap_Lerp_Value969_g60856);
					float4 Lightmap_Lerp932_g60856 = lerpResult442_g60856;
					float3 appendResult139_g60905 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 Normal_Map318_g60905 = Normal_Map700_g60856;
					float dotResult121_g60905 = dot( appendResult139_g60905 , Normal_Map318_g60905 );
					float temp_output_2_0_g60907 = saturate( dotResult121_g60905 );
					float localStochasticTiling2_g60887 = ( 0.0 );
					float2 UV2_g60887 = UV0B2361_g60856;
					float4 TexelSize2_g60887 = _UdonRNMX0_TexelSize;
					float4 Offsets2_g60887 = float4( 0,0,0,0 );
					float2 Weights2_g60887 = float2( 0,0 );
					{
					UV2_g60887 = UV2_g60887 * TexelSize2_g60887.zw - 0.5;
					float2 f = frac( UV2_g60887 );
					UV2_g60887 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g60887.x - 0.5, UV2_g60887.x + 1.5, UV2_g60887.y - 0.5, UV2_g60887.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g60887 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60887.xyxy;
					Weights2_g60887 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g60886 = Offsets2_g60887;
					float4 Input_FetchOffsets197_g60888 = temp_output_1_34_g60886;
					float2 temp_output_1_54_g60886 = Weights2_g60887;
					float2 Input_FetchWeights200_g60888 = temp_output_1_54_g60886;
					float2 break187_g60888 = Input_FetchWeights200_g60888;
					float4 lerpResult181_g60888 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60888).yw ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60888).xw ) , break187_g60888.x);
					float4 lerpResult182_g60888 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60888).yz ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60888).xz ) , break187_g60888.x);
					float4 lerpResult176_g60888 = lerp( lerpResult181_g60888 , lerpResult182_g60888 , break187_g60888.y);
					float4 Output_Fetch2D_Auto202_g60888 = lerpResult176_g60888;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g60856 = Output_Fetch2D_Auto202_g60888;
					#else
					float4 staticSwitch1061_g60856 = tex2D( _UdonRNMX0, UV0B2361_g60856 );
					#endif
					float3 appendResult146_g60905 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g60905 = dot( appendResult146_g60905 , Normal_Map318_g60905 );
					float temp_output_2_0_g60906 = saturate( dotResult122_g60905 );
					float4 Input_FetchOffsets197_g60889 = temp_output_1_34_g60886;
					float2 Input_FetchWeights200_g60889 = temp_output_1_54_g60886;
					float2 break187_g60889 = Input_FetchWeights200_g60889;
					float4 lerpResult181_g60889 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60889).yw ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60889).xw ) , break187_g60889.x);
					float4 lerpResult182_g60889 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60889).yz ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60889).xz ) , break187_g60889.x);
					float4 lerpResult176_g60889 = lerp( lerpResult181_g60889 , lerpResult182_g60889 , break187_g60889.y);
					float4 Output_Fetch2D_Auto202_g60889 = lerpResult176_g60889;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g60856 = Output_Fetch2D_Auto202_g60889;
					#else
					float4 staticSwitch1062_g60856 = tex2D( _UdonRNMY0, UV0B2361_g60856 );
					#endif
					float3 appendResult149_g60905 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g60905 = dot( appendResult149_g60905 , Normal_Map318_g60905 );
					float temp_output_2_0_g60908 = saturate( dotResult120_g60905 );
					float4 Input_FetchOffsets197_g60890 = temp_output_1_34_g60886;
					float2 Input_FetchWeights200_g60890 = temp_output_1_54_g60886;
					float2 break187_g60890 = Input_FetchWeights200_g60890;
					float4 lerpResult181_g60890 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60890).yw ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60890).xw ) , break187_g60890.x);
					float4 lerpResult182_g60890 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60890).yz ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60890).xz ) , break187_g60890.x);
					float4 lerpResult176_g60890 = lerp( lerpResult181_g60890 , lerpResult182_g60890 , break187_g60890.y);
					float4 Output_Fetch2D_Auto202_g60890 = lerpResult176_g60890;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g60856 = Output_Fetch2D_Auto202_g60890;
					#else
					float4 staticSwitch1063_g60856 = tex2D( _UdonRNMZ0, UV0B2361_g60856 );
					#endif
					float4 temp_output_3094_0_g60856 = ( ( ( ( ( temp_output_2_0_g60907 * temp_output_2_0_g60907 ) * staticSwitch1061_g60856 ) + ( ( temp_output_2_0_g60906 * temp_output_2_0_g60906 ) * staticSwitch1062_g60856 ) ) + ( ( temp_output_2_0_g60908 * temp_output_2_0_g60908 ) * staticSwitch1063_g60856 ) ) * 1.2 );
					float4 RNM_0926_g60856 = temp_output_3094_0_g60856;
					float3 appendResult139_g60900 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 Normal_Map318_g60900 = Normal_Map700_g60856;
					float dotResult121_g60900 = dot( appendResult139_g60900 , Normal_Map318_g60900 );
					float temp_output_2_0_g60902 = saturate( dotResult121_g60900 );
					float localStochasticTiling2_g60858 = ( 0.0 );
					float2 UV2_g60858 = UV0B2361_g60856;
					float4 TexelSize2_g60858 = _UdonRNMX1_TexelSize;
					float4 Offsets2_g60858 = float4( 0,0,0,0 );
					float2 Weights2_g60858 = float2( 0,0 );
					{
					UV2_g60858 = UV2_g60858 * TexelSize2_g60858.zw - 0.5;
					float2 f = frac( UV2_g60858 );
					UV2_g60858 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g60858.x - 0.5, UV2_g60858.x + 1.5, UV2_g60858.y - 0.5, UV2_g60858.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g60858 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60858.xyxy;
					Weights2_g60858 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g60857 = Offsets2_g60858;
					float4 Input_FetchOffsets197_g60859 = temp_output_1_34_g60857;
					float2 temp_output_1_54_g60857 = Weights2_g60858;
					float2 Input_FetchWeights200_g60859 = temp_output_1_54_g60857;
					float2 break187_g60859 = Input_FetchWeights200_g60859;
					float4 lerpResult181_g60859 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60859).yw ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60859).xw ) , break187_g60859.x);
					float4 lerpResult182_g60859 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60859).yz ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60859).xz ) , break187_g60859.x);
					float4 lerpResult176_g60859 = lerp( lerpResult181_g60859 , lerpResult182_g60859 , break187_g60859.y);
					float4 Output_Fetch2D_Auto202_g60859 = lerpResult176_g60859;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g60856 = Output_Fetch2D_Auto202_g60859;
					#else
					float4 staticSwitch1087_g60856 = tex2D( _UdonRNMX1, UV0B2361_g60856 );
					#endif
					float3 appendResult146_g60900 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g60900 = dot( appendResult146_g60900 , Normal_Map318_g60900 );
					float temp_output_2_0_g60901 = saturate( dotResult122_g60900 );
					float4 Input_FetchOffsets197_g60860 = temp_output_1_34_g60857;
					float2 Input_FetchWeights200_g60860 = temp_output_1_54_g60857;
					float2 break187_g60860 = Input_FetchWeights200_g60860;
					float4 lerpResult181_g60860 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60860).yw ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60860).xw ) , break187_g60860.x);
					float4 lerpResult182_g60860 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60860).yz ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60860).xz ) , break187_g60860.x);
					float4 lerpResult176_g60860 = lerp( lerpResult181_g60860 , lerpResult182_g60860 , break187_g60860.y);
					float4 Output_Fetch2D_Auto202_g60860 = lerpResult176_g60860;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g60856 = Output_Fetch2D_Auto202_g60860;
					#else
					float4 staticSwitch1083_g60856 = tex2D( _UdonRNMY1, UV0B2361_g60856 );
					#endif
					float3 appendResult149_g60900 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g60900 = dot( appendResult149_g60900 , Normal_Map318_g60900 );
					float temp_output_2_0_g60903 = saturate( dotResult120_g60900 );
					float4 Input_FetchOffsets197_g60861 = temp_output_1_34_g60857;
					float2 Input_FetchWeights200_g60861 = temp_output_1_54_g60857;
					float2 break187_g60861 = Input_FetchWeights200_g60861;
					float4 lerpResult181_g60861 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60861).yw ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60861).xw ) , break187_g60861.x);
					float4 lerpResult182_g60861 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60861).yz ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60861).xz ) , break187_g60861.x);
					float4 lerpResult176_g60861 = lerp( lerpResult181_g60861 , lerpResult182_g60861 , break187_g60861.y);
					float4 Output_Fetch2D_Auto202_g60861 = lerpResult176_g60861;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g60856 = Output_Fetch2D_Auto202_g60861;
					#else
					float4 staticSwitch1084_g60856 = tex2D( _UdonRNMZ1, UV0B2361_g60856 );
					#endif
					float4 RNM_11081_g60856 = ( ( ( ( ( temp_output_2_0_g60902 * temp_output_2_0_g60902 ) * staticSwitch1087_g60856 ) + ( ( temp_output_2_0_g60901 * temp_output_2_0_g60901 ) * staticSwitch1083_g60856 ) ) + ( ( temp_output_2_0_g60903 * temp_output_2_0_g60903 ) * staticSwitch1084_g60856 ) ) * 1.2 );
					float4 lerpResult953_g60856 = lerp( RNM_0926_g60856 , RNM_11081_g60856 , Lightmap_Lerp_Value969_g60856);
					float4 RNM_Lerp950_g60856 = lerpResult953_g60856;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g60856 = temp_cast_2;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g60856 = Lightmap_0925_g60856;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g60856 = Lightmap_Lerp932_g60856;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g60856 = RNM_0926_g60856;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g60856 = RNM_Lerp950_g60856;
					#else
					float4 staticSwitch1014_g60856 = temp_cast_2;
					#endif
					float3 Lightmap46_g60856 = (staticSwitch1014_g60856).rgb;
					float dotResult9_g60914 = dot( float3( 0.212673, 0.715152, 0.072175 ) , Lightmap46_g60856 );
					float smoothstepResult14_g60914 = smoothstep( 0.0 , 0.04 , dotResult9_g60914);
					float Indirect_Lightmap_Mask3118_g60856 = smoothstepResult14_g60914;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float staticSwitch3145_g60856 = White38_g60856;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float staticSwitch3145_g60856 = Indirect_Lightmap_Mask3118_g60856;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float staticSwitch3145_g60856 = Indirect_Lightmap_Mask3118_g60856;
					#elif defined( _LIGHTMAPMODE_RNM )
					float staticSwitch3145_g60856 = Indirect_Lightmap_Mask3118_g60856;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float staticSwitch3145_g60856 = Indirect_Lightmap_Mask3118_g60856;
					#else
					float staticSwitch3145_g60856 = White38_g60856;
					#endif
					float LightmapMask1_g60915 = staticSwitch3145_g60856;
					float3 localIndirectSpecular1_g60915 = IndirectSpecular( Color1_g60915 , Metallic1_g60915 , Smoothness1_g60915 , ViewDir1_g60915 , WorldPos1_g60915 , WorldNormal1_g60915 , LightmapMask1_g60915 );
					#ifdef _INDIRECTSPECULARS_ON
					float3 staticSwitch2971_g60856 = localIndirectSpecular1_g60915;
					#else
					float3 staticSwitch2971_g60856 = temp_cast_1;
					#endif
					float3 Indirect_Specular1419_g60856 = staticSwitch2971_g60856;
					float3 temp_cast_4 = (Black1185_g60856).xxx;
					float3 Color97_g60904 = oAlbedo6_g60856;
					float Metallic97_g60904 = Metallic1239_g60856;
					float Smoothness97_g60904 = Smoothness1399_g60856;
					float3 ViewDir97_g60904 = View_Direction2511_g60856;
					float3 WorldPos97_g60904 = World_Position2505_g60856;
					float3 WorldNormal97_g60904 = World_Normal2508_g60856;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float staticSwitch3107_g60856 = Black1185_g60856;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float staticSwitch3107_g60856 = White38_g60856;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float staticSwitch3107_g60856 = White38_g60856;
					#elif defined( _LIGHTMAPMODE_RNM )
					float staticSwitch3107_g60856 = White38_g60856;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float staticSwitch3107_g60856 = White38_g60856;
					#else
					float staticSwitch3107_g60856 = Black1185_g60856;
					#endif
					float LightmapMode97_g60904 = staticSwitch3107_g60856;
					float dotResult9_g60913 = dot( float3( 0.212673, 0.715152, 0.072175 ) , Lightmap46_g60856 );
					float smoothstepResult2_g60913 = smoothstep( 0.0 , 0.4 , dotResult9_g60913);
					float Direct_Lightmap_Mask3067_g60856 = smoothstepResult2_g60913;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float staticSwitch3085_g60856 = White38_g60856;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float staticSwitch3085_g60856 = Direct_Lightmap_Mask3067_g60856;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float staticSwitch3085_g60856 = Direct_Lightmap_Mask3067_g60856;
					#elif defined( _LIGHTMAPMODE_RNM )
					float staticSwitch3085_g60856 = Direct_Lightmap_Mask3067_g60856;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float staticSwitch3085_g60856 = Direct_Lightmap_Mask3067_g60856;
					#else
					float staticSwitch3085_g60856 = White38_g60856;
					#endif
					float LightmapMask97_g60904 = staticSwitch3085_g60856;
					float3 localDirectSpecular97_g60904 = DirectSpecular( Color97_g60904 , Metallic97_g60904 , Smoothness97_g60904 , ViewDir97_g60904 , WorldPos97_g60904 , WorldNormal97_g60904 , LightmapMode97_g60904 , LightmapMask97_g60904 );
					#ifdef _DIRECTSPECULAR_ON
					float3 staticSwitch2969_g60856 = localDirectSpecular97_g60904;
					#else
					float3 staticSwitch2969_g60856 = temp_cast_4;
					#endif
					float3 Direct_Specular2560_g60856 = staticSwitch2969_g60856;
					float3 aAlbedo1466_g60856 = ( temp_output_2532_0_g60856 * ( 1.0 - Metallic1239_g60856 ) );
					float3 temp_output_1252_0_g60856 = ( aAlbedo1466_g60856 * Lightmap46_g60856 );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch1_g60899 = float4( ( temp_output_1252_0_g60856 + Emission86_g60856 + Indirect_Specular1419_g60856 ) , 0.0 );
					#else
					float4 staticSwitch1_g60899 = float4( ( Emission86_g60856 + Indirect_Specular1419_g60856 + Direct_Specular2560_g60856 + temp_output_1252_0_g60856 ) , 0.0 );
					#endif
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1181_g60856 = float4( Lightmap46_g60856 , 0.0 );
					#else
					float4 staticSwitch1181_g60856 = staticSwitch1_g60899;
					#endif
					float4 Color357_g60896 = staticSwitch1181_g60856;
					float4 LUT51_g60896 = tex3D( _LUT, ( ( log10( ( ( (Color357_g60896).xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 ) );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch359_g60896 = LUT51_g60896;
					#else
					float4 staticSwitch359_g60896 = Color357_g60896;
					#endif
					

					float4 Color = staticSwitch359_g60896;
					float Alpha = 1;
					half AlphaClipThreshold = 0.5;

					#ifdef _ALPHATEST_ON
						clip( Alpha - AlphaClipThreshold );
					#endif

					Color.a = Alpha;
					
					return Color;
				}
			ENDCG
		}

	
	}
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
	
	Fallback Off
}/*ASEBEGIN
Version=19909
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3270;192,-1152;Inherit;False;Meenphie;0;;60856;b3ba55a08dd6b49c7be16c6f35cf2033;6,1008,0,2632,0,2635,0,2619,0,2670,0,2636,0;0;3;FLOAT4;624;FLOAT;156;FLOAT;427
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3271;512,-1152;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;8;Meenphie/Standard/Transparent/Additive;95d28ca0904218e4fa77b1221c962cb8;True;Unlit;0;0;Unlit;3;True;True;4;1;False;;1;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;1;False;;True;3;False;;True;False;0;False;;0;False;;True;1;False;;True;2;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;2;Alpha Clipping;0;0;Cast Shadows;0;639161721900197570;0;2;True;False;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3272;512,-1152;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;95d28ca0904218e4fa77b1221c962cb8;True;ShadowCaster;0;1;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;False;;True;2;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
WireConnection;3271;0;3270;624
ASEEND*/
//CHKSM=485FA38C14EDD1B71A05C18E7D33869C2668BE4F