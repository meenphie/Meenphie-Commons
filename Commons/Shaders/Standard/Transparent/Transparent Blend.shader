// Made with Amplify Shader Editor v1.9.9.9
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Standard/Transparent/Transparent Blend"
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

		

		Blend SrcAlpha OneMinusSrcAlpha
		AlphaToMask Off
		Cull Back
		ColorMask RGBA
		ZWrite On
		ZClip True
		ZTest LEqual
		Offset 0 , 0
		

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
				sampler2D _Sampler82968_g59553;
				uniform float _EmissionIntensity;
				uniform half4 _Color;
				uniform sampler2D _MainTex;
				sampler2D _Sampler82966_g59553;
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				sampler2D _Sampler82967_g59553;
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				sampler2D _Sampler82964_g59553;
				uniform sampler2D _BumpMap;
				sampler2D _Sampler82965_g59553;
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

					float2 texCoord2357_g59553 = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0A2420_g59553 = texCoord2357_g59553;
					float2 temp_output_5_0_g59692 = UV0A2420_g59553;
					float2 UV633_g59692 = temp_output_5_0_g59692;
					float2 UV100_g59693 = UV633_g59692;
					float2 temp_output_51_0_g59693 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59693 * float2( 3.464,3.464 ) ) );
					float2 break55_g59693 = frac( temp_output_51_0_g59693 );
					float temp_output_56_0_g59693 = ( ( 1.0 - break55_g59693.x ) - break55_g59693.y );
					float2 temp_output_52_0_g59693 = floor( temp_output_51_0_g59693 );
					float2 temp_output_125_0_g59693 = ( temp_output_52_0_g59693 + float2( 1,1 ) );
					float2 ifLocalVar87_g59693 = 0;
					if( temp_output_56_0_g59693 > 0.0 )
					ifLocalVar87_g59693 = temp_output_52_0_g59693;
					else if( temp_output_56_0_g59693 == 0.0 )
					ifLocalVar87_g59693 = temp_output_125_0_g59693;
					else if( temp_output_56_0_g59693 < 0.0 )
					ifLocalVar87_g59693 = temp_output_125_0_g59693;
					float3 temp_output_7_0_g59694 = frac( ( (ifLocalVar87_g59693).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59694 = dot( temp_output_7_0_g59694 , ( (temp_output_7_0_g59694).yzx + 33.33 ) );
					float3 temp_output_12_0_g59694 = ( temp_output_7_0_g59694 + dotResult8_g59694 );
					float2 temp_output_597_0_g59692 = ( UV100_g59693 + frac( ( ( (temp_output_12_0_g59694).xx + (temp_output_12_0_g59694).yz ) * (temp_output_12_0_g59694).zy ) ) );
					float2 DDX631_g59692 = ddx( temp_output_5_0_g59692 );
					float2 DDY632_g59692 = ddy( temp_output_5_0_g59692 );
					float temp_output_65_0_g59693 = ( 0.0 - temp_output_56_0_g59693 );
					float ifLocalVar59_g59693 = 0;
					if( temp_output_56_0_g59693 <= 0.0 )
					ifLocalVar59_g59693 = temp_output_65_0_g59693;
					else
					ifLocalVar59_g59693 = temp_output_56_0_g59693;
					float temp_output_597_30_g59692 = ifLocalVar59_g59693;
					float2 temp_output_90_0_g59693 = ( temp_output_52_0_g59693 + float2( 0,1 ) );
					float2 temp_output_123_0_g59693 = ( temp_output_52_0_g59693 + float2( 1,0 ) );
					float2 ifLocalVar88_g59693 = 0;
					if( temp_output_56_0_g59693 > 0.0 )
					ifLocalVar88_g59693 = temp_output_90_0_g59693;
					else if( temp_output_56_0_g59693 == 0.0 )
					ifLocalVar88_g59693 = temp_output_123_0_g59693;
					else if( temp_output_56_0_g59693 < 0.0 )
					ifLocalVar88_g59693 = temp_output_123_0_g59693;
					float3 temp_output_7_0_g59695 = frac( ( (ifLocalVar88_g59693).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59695 = dot( temp_output_7_0_g59695 , ( (temp_output_7_0_g59695).yzx + 33.33 ) );
					float3 temp_output_12_0_g59695 = ( temp_output_7_0_g59695 + dotResult8_g59695 );
					float2 temp_output_597_26_g59692 = ( UV100_g59693 + frac( ( ( (temp_output_12_0_g59695).xx + (temp_output_12_0_g59695).yz ) * (temp_output_12_0_g59695).zy ) ) );
					float temp_output_66_0_g59693 = ( 1.0 - break55_g59693.y );
					float ifLocalVar60_g59693 = 0;
					if( temp_output_56_0_g59693 <= 0.0 )
					ifLocalVar60_g59693 = temp_output_66_0_g59693;
					else
					ifLocalVar60_g59693 = break55_g59693.y;
					float temp_output_597_28_g59692 = ifLocalVar60_g59693;
					float2 ifLocalVar89_g59693 = 0;
					if( temp_output_56_0_g59693 > 0.0 )
					ifLocalVar89_g59693 = temp_output_123_0_g59693;
					else if( temp_output_56_0_g59693 == 0.0 )
					ifLocalVar89_g59693 = temp_output_90_0_g59693;
					else if( temp_output_56_0_g59693 < 0.0 )
					ifLocalVar89_g59693 = temp_output_90_0_g59693;
					float3 temp_output_7_0_g59696 = frac( ( (ifLocalVar89_g59693).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59696 = dot( temp_output_7_0_g59696 , ( (temp_output_7_0_g59696).yzx + 33.33 ) );
					float3 temp_output_12_0_g59696 = ( temp_output_7_0_g59696 + dotResult8_g59696 );
					float2 temp_output_597_27_g59692 = ( UV100_g59693 + frac( ( ( (temp_output_12_0_g59696).xx + (temp_output_12_0_g59696).yz ) * (temp_output_12_0_g59696).zy ) ) );
					float temp_output_67_0_g59693 = ( 1.0 - break55_g59693.x );
					float ifLocalVar61_g59693 = 0;
					if( temp_output_56_0_g59693 <= 0.0 )
					ifLocalVar61_g59693 = temp_output_67_0_g59693;
					else
					ifLocalVar61_g59693 = break55_g59693.x;
					float temp_output_597_29_g59692 = ifLocalVar61_g59693;
					float4 Output_2D293_g59692 = ( ( tex2D( _Sampler82968_g59553, temp_output_597_0_g59692, DDX631_g59692, DDY632_g59692 ) * temp_output_597_30_g59692 ) + ( tex2D( _Sampler82968_g59553, temp_output_597_26_g59692, DDX631_g59692, DDY632_g59692 ) * temp_output_597_28_g59692 ) + ( tex2D( _Sampler82968_g59553, temp_output_597_27_g59692, DDX631_g59692, DDY632_g59692 ) * temp_output_597_29_g59692 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g59553 = Output_2D293_g59692;
					#else
					float4 staticSwitch1006_g59553 = tex2D( _EmissionMap, UV0A2420_g59553 );
					#endif
					float3 temp_output_2531_0_g59553 = (( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g59553 * _EmissionIntensity )).rgb;
					float3 Emission86_g59553 = temp_output_2531_0_g59553;
					float Black1185_g59553 = 0.0;
					float3 temp_cast_1 = (Black1185_g59553).xxx;
					#ifdef _MAINTEX
					float4 staticSwitch1549_g59553 = tex2D( _MainTex, UV0A2420_g59553 );
					#else
					float4 staticSwitch1549_g59553 = _Color;
					#endif
					float2 temp_output_5_0_g59681 = UV0A2420_g59553;
					float2 UV633_g59681 = temp_output_5_0_g59681;
					float2 UV100_g59682 = UV633_g59681;
					float2 temp_output_51_0_g59682 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59682 * float2( 3.464,3.464 ) ) );
					float2 break55_g59682 = frac( temp_output_51_0_g59682 );
					float temp_output_56_0_g59682 = ( ( 1.0 - break55_g59682.x ) - break55_g59682.y );
					float2 temp_output_52_0_g59682 = floor( temp_output_51_0_g59682 );
					float2 temp_output_125_0_g59682 = ( temp_output_52_0_g59682 + float2( 1,1 ) );
					float2 ifLocalVar87_g59682 = 0;
					if( temp_output_56_0_g59682 > 0.0 )
					ifLocalVar87_g59682 = temp_output_52_0_g59682;
					else if( temp_output_56_0_g59682 == 0.0 )
					ifLocalVar87_g59682 = temp_output_125_0_g59682;
					else if( temp_output_56_0_g59682 < 0.0 )
					ifLocalVar87_g59682 = temp_output_125_0_g59682;
					float3 temp_output_7_0_g59683 = frac( ( (ifLocalVar87_g59682).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59683 = dot( temp_output_7_0_g59683 , ( (temp_output_7_0_g59683).yzx + 33.33 ) );
					float3 temp_output_12_0_g59683 = ( temp_output_7_0_g59683 + dotResult8_g59683 );
					float2 temp_output_597_0_g59681 = ( UV100_g59682 + frac( ( ( (temp_output_12_0_g59683).xx + (temp_output_12_0_g59683).yz ) * (temp_output_12_0_g59683).zy ) ) );
					float2 DDX631_g59681 = ddx( temp_output_5_0_g59681 );
					float2 DDY632_g59681 = ddy( temp_output_5_0_g59681 );
					float temp_output_65_0_g59682 = ( 0.0 - temp_output_56_0_g59682 );
					float ifLocalVar59_g59682 = 0;
					if( temp_output_56_0_g59682 <= 0.0 )
					ifLocalVar59_g59682 = temp_output_65_0_g59682;
					else
					ifLocalVar59_g59682 = temp_output_56_0_g59682;
					float temp_output_597_30_g59681 = ifLocalVar59_g59682;
					float2 temp_output_90_0_g59682 = ( temp_output_52_0_g59682 + float2( 0,1 ) );
					float2 temp_output_123_0_g59682 = ( temp_output_52_0_g59682 + float2( 1,0 ) );
					float2 ifLocalVar88_g59682 = 0;
					if( temp_output_56_0_g59682 > 0.0 )
					ifLocalVar88_g59682 = temp_output_90_0_g59682;
					else if( temp_output_56_0_g59682 == 0.0 )
					ifLocalVar88_g59682 = temp_output_123_0_g59682;
					else if( temp_output_56_0_g59682 < 0.0 )
					ifLocalVar88_g59682 = temp_output_123_0_g59682;
					float3 temp_output_7_0_g59684 = frac( ( (ifLocalVar88_g59682).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59684 = dot( temp_output_7_0_g59684 , ( (temp_output_7_0_g59684).yzx + 33.33 ) );
					float3 temp_output_12_0_g59684 = ( temp_output_7_0_g59684 + dotResult8_g59684 );
					float2 temp_output_597_26_g59681 = ( UV100_g59682 + frac( ( ( (temp_output_12_0_g59684).xx + (temp_output_12_0_g59684).yz ) * (temp_output_12_0_g59684).zy ) ) );
					float temp_output_66_0_g59682 = ( 1.0 - break55_g59682.y );
					float ifLocalVar60_g59682 = 0;
					if( temp_output_56_0_g59682 <= 0.0 )
					ifLocalVar60_g59682 = temp_output_66_0_g59682;
					else
					ifLocalVar60_g59682 = break55_g59682.y;
					float temp_output_597_28_g59681 = ifLocalVar60_g59682;
					float2 ifLocalVar89_g59682 = 0;
					if( temp_output_56_0_g59682 > 0.0 )
					ifLocalVar89_g59682 = temp_output_123_0_g59682;
					else if( temp_output_56_0_g59682 == 0.0 )
					ifLocalVar89_g59682 = temp_output_90_0_g59682;
					else if( temp_output_56_0_g59682 < 0.0 )
					ifLocalVar89_g59682 = temp_output_90_0_g59682;
					float3 temp_output_7_0_g59685 = frac( ( (ifLocalVar89_g59682).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59685 = dot( temp_output_7_0_g59685 , ( (temp_output_7_0_g59685).yzx + 33.33 ) );
					float3 temp_output_12_0_g59685 = ( temp_output_7_0_g59685 + dotResult8_g59685 );
					float2 temp_output_597_27_g59681 = ( UV100_g59682 + frac( ( ( (temp_output_12_0_g59685).xx + (temp_output_12_0_g59685).yz ) * (temp_output_12_0_g59685).zy ) ) );
					float temp_output_67_0_g59682 = ( 1.0 - break55_g59682.x );
					float ifLocalVar61_g59682 = 0;
					if( temp_output_56_0_g59682 <= 0.0 )
					ifLocalVar61_g59682 = temp_output_67_0_g59682;
					else
					ifLocalVar61_g59682 = break55_g59682.x;
					float temp_output_597_29_g59681 = ifLocalVar61_g59682;
					float4 Output_2D293_g59681 = ( ( tex2D( _Sampler82966_g59553, temp_output_597_0_g59681, DDX631_g59681, DDY632_g59681 ) * temp_output_597_30_g59681 ) + ( tex2D( _Sampler82966_g59553, temp_output_597_26_g59681, DDX631_g59681, DDY632_g59681 ) * temp_output_597_28_g59681 ) + ( tex2D( _Sampler82966_g59553, temp_output_597_27_g59681, DDX631_g59681, DDY632_g59681 ) * temp_output_597_29_g59681 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g59553 = Output_2D293_g59681;
					#else
					float4 staticSwitch1001_g59553 = staticSwitch1549_g59553;
					#endif
					float3 temp_output_2532_0_g59553 = (staticSwitch1001_g59553).rgb;
					float3 oAlbedo6_g59553 = temp_output_2532_0_g59553;
					float3 Color1_g59991 = oAlbedo6_g59553;
					#ifdef _METALLICMAP
					float staticSwitch846_g59553 = tex2D( _MetallicMap, UV0A2420_g59553 ).r;
					#else
					float staticSwitch846_g59553 = _Metallic;
					#endif
					float2 temp_output_5_0_g59755 = UV0A2420_g59553;
					float2 UV633_g59755 = temp_output_5_0_g59755;
					float2 UV100_g59756 = UV633_g59755;
					float2 temp_output_51_0_g59756 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59756 * float2( 3.464,3.464 ) ) );
					float2 break55_g59756 = frac( temp_output_51_0_g59756 );
					float temp_output_56_0_g59756 = ( ( 1.0 - break55_g59756.x ) - break55_g59756.y );
					float2 temp_output_52_0_g59756 = floor( temp_output_51_0_g59756 );
					float2 temp_output_125_0_g59756 = ( temp_output_52_0_g59756 + float2( 1,1 ) );
					float2 ifLocalVar87_g59756 = 0;
					if( temp_output_56_0_g59756 > 0.0 )
					ifLocalVar87_g59756 = temp_output_52_0_g59756;
					else if( temp_output_56_0_g59756 == 0.0 )
					ifLocalVar87_g59756 = temp_output_125_0_g59756;
					else if( temp_output_56_0_g59756 < 0.0 )
					ifLocalVar87_g59756 = temp_output_125_0_g59756;
					float3 temp_output_7_0_g59757 = frac( ( (ifLocalVar87_g59756).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59757 = dot( temp_output_7_0_g59757 , ( (temp_output_7_0_g59757).yzx + 33.33 ) );
					float3 temp_output_12_0_g59757 = ( temp_output_7_0_g59757 + dotResult8_g59757 );
					float2 temp_output_597_0_g59755 = ( UV100_g59756 + frac( ( ( (temp_output_12_0_g59757).xx + (temp_output_12_0_g59757).yz ) * (temp_output_12_0_g59757).zy ) ) );
					float2 DDX631_g59755 = ddx( temp_output_5_0_g59755 );
					float2 DDY632_g59755 = ddy( temp_output_5_0_g59755 );
					float temp_output_65_0_g59756 = ( 0.0 - temp_output_56_0_g59756 );
					float ifLocalVar59_g59756 = 0;
					if( temp_output_56_0_g59756 <= 0.0 )
					ifLocalVar59_g59756 = temp_output_65_0_g59756;
					else
					ifLocalVar59_g59756 = temp_output_56_0_g59756;
					float temp_output_597_30_g59755 = ifLocalVar59_g59756;
					float2 temp_output_90_0_g59756 = ( temp_output_52_0_g59756 + float2( 0,1 ) );
					float2 temp_output_123_0_g59756 = ( temp_output_52_0_g59756 + float2( 1,0 ) );
					float2 ifLocalVar88_g59756 = 0;
					if( temp_output_56_0_g59756 > 0.0 )
					ifLocalVar88_g59756 = temp_output_90_0_g59756;
					else if( temp_output_56_0_g59756 == 0.0 )
					ifLocalVar88_g59756 = temp_output_123_0_g59756;
					else if( temp_output_56_0_g59756 < 0.0 )
					ifLocalVar88_g59756 = temp_output_123_0_g59756;
					float3 temp_output_7_0_g59758 = frac( ( (ifLocalVar88_g59756).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59758 = dot( temp_output_7_0_g59758 , ( (temp_output_7_0_g59758).yzx + 33.33 ) );
					float3 temp_output_12_0_g59758 = ( temp_output_7_0_g59758 + dotResult8_g59758 );
					float2 temp_output_597_26_g59755 = ( UV100_g59756 + frac( ( ( (temp_output_12_0_g59758).xx + (temp_output_12_0_g59758).yz ) * (temp_output_12_0_g59758).zy ) ) );
					float temp_output_66_0_g59756 = ( 1.0 - break55_g59756.y );
					float ifLocalVar60_g59756 = 0;
					if( temp_output_56_0_g59756 <= 0.0 )
					ifLocalVar60_g59756 = temp_output_66_0_g59756;
					else
					ifLocalVar60_g59756 = break55_g59756.y;
					float temp_output_597_28_g59755 = ifLocalVar60_g59756;
					float2 ifLocalVar89_g59756 = 0;
					if( temp_output_56_0_g59756 > 0.0 )
					ifLocalVar89_g59756 = temp_output_123_0_g59756;
					else if( temp_output_56_0_g59756 == 0.0 )
					ifLocalVar89_g59756 = temp_output_90_0_g59756;
					else if( temp_output_56_0_g59756 < 0.0 )
					ifLocalVar89_g59756 = temp_output_90_0_g59756;
					float3 temp_output_7_0_g59759 = frac( ( (ifLocalVar89_g59756).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59759 = dot( temp_output_7_0_g59759 , ( (temp_output_7_0_g59759).yzx + 33.33 ) );
					float3 temp_output_12_0_g59759 = ( temp_output_7_0_g59759 + dotResult8_g59759 );
					float2 temp_output_597_27_g59755 = ( UV100_g59756 + frac( ( ( (temp_output_12_0_g59759).xx + (temp_output_12_0_g59759).yz ) * (temp_output_12_0_g59759).zy ) ) );
					float temp_output_67_0_g59756 = ( 1.0 - break55_g59756.x );
					float ifLocalVar61_g59756 = 0;
					if( temp_output_56_0_g59756 <= 0.0 )
					ifLocalVar61_g59756 = temp_output_67_0_g59756;
					else
					ifLocalVar61_g59756 = break55_g59756.x;
					float temp_output_597_29_g59755 = ifLocalVar61_g59756;
					float4 Output_2D293_g59755 = ( ( tex2D( _Sampler82967_g59553, temp_output_597_0_g59755, DDX631_g59755, DDY632_g59755 ) * temp_output_597_30_g59755 ) + ( tex2D( _Sampler82967_g59553, temp_output_597_26_g59755, DDX631_g59755, DDY632_g59755 ) * temp_output_597_28_g59755 ) + ( tex2D( _Sampler82967_g59553, temp_output_597_27_g59755, DDX631_g59755, DDY632_g59755 ) * temp_output_597_29_g59755 ) );
					float4 break31_g59755 = Output_2D293_g59755;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g59553 = break31_g59755.r;
					#else
					float staticSwitch1005_g59553 = staticSwitch846_g59553;
					#endif
					float Metallic1239_g59553 = staticSwitch1005_g59553;
					float Metallic1_g59991 = Metallic1239_g59553;
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g59553 = tex2D( _GlossinessMap, UV0A2420_g59553 ).r;
					#else
					float staticSwitch845_g59553 = _Glossiness;
					#endif
					float2 temp_output_5_0_g59686 = UV0A2420_g59553;
					float2 UV633_g59686 = temp_output_5_0_g59686;
					float2 UV100_g59687 = UV633_g59686;
					float2 temp_output_51_0_g59687 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59687 * float2( 3.464,3.464 ) ) );
					float2 break55_g59687 = frac( temp_output_51_0_g59687 );
					float temp_output_56_0_g59687 = ( ( 1.0 - break55_g59687.x ) - break55_g59687.y );
					float2 temp_output_52_0_g59687 = floor( temp_output_51_0_g59687 );
					float2 temp_output_125_0_g59687 = ( temp_output_52_0_g59687 + float2( 1,1 ) );
					float2 ifLocalVar87_g59687 = 0;
					if( temp_output_56_0_g59687 > 0.0 )
					ifLocalVar87_g59687 = temp_output_52_0_g59687;
					else if( temp_output_56_0_g59687 == 0.0 )
					ifLocalVar87_g59687 = temp_output_125_0_g59687;
					else if( temp_output_56_0_g59687 < 0.0 )
					ifLocalVar87_g59687 = temp_output_125_0_g59687;
					float3 temp_output_7_0_g59688 = frac( ( (ifLocalVar87_g59687).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59688 = dot( temp_output_7_0_g59688 , ( (temp_output_7_0_g59688).yzx + 33.33 ) );
					float3 temp_output_12_0_g59688 = ( temp_output_7_0_g59688 + dotResult8_g59688 );
					float2 temp_output_597_0_g59686 = ( UV100_g59687 + frac( ( ( (temp_output_12_0_g59688).xx + (temp_output_12_0_g59688).yz ) * (temp_output_12_0_g59688).zy ) ) );
					float2 DDX631_g59686 = ddx( temp_output_5_0_g59686 );
					float2 DDY632_g59686 = ddy( temp_output_5_0_g59686 );
					float temp_output_65_0_g59687 = ( 0.0 - temp_output_56_0_g59687 );
					float ifLocalVar59_g59687 = 0;
					if( temp_output_56_0_g59687 <= 0.0 )
					ifLocalVar59_g59687 = temp_output_65_0_g59687;
					else
					ifLocalVar59_g59687 = temp_output_56_0_g59687;
					float temp_output_597_30_g59686 = ifLocalVar59_g59687;
					float2 temp_output_90_0_g59687 = ( temp_output_52_0_g59687 + float2( 0,1 ) );
					float2 temp_output_123_0_g59687 = ( temp_output_52_0_g59687 + float2( 1,0 ) );
					float2 ifLocalVar88_g59687 = 0;
					if( temp_output_56_0_g59687 > 0.0 )
					ifLocalVar88_g59687 = temp_output_90_0_g59687;
					else if( temp_output_56_0_g59687 == 0.0 )
					ifLocalVar88_g59687 = temp_output_123_0_g59687;
					else if( temp_output_56_0_g59687 < 0.0 )
					ifLocalVar88_g59687 = temp_output_123_0_g59687;
					float3 temp_output_7_0_g59689 = frac( ( (ifLocalVar88_g59687).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59689 = dot( temp_output_7_0_g59689 , ( (temp_output_7_0_g59689).yzx + 33.33 ) );
					float3 temp_output_12_0_g59689 = ( temp_output_7_0_g59689 + dotResult8_g59689 );
					float2 temp_output_597_26_g59686 = ( UV100_g59687 + frac( ( ( (temp_output_12_0_g59689).xx + (temp_output_12_0_g59689).yz ) * (temp_output_12_0_g59689).zy ) ) );
					float temp_output_66_0_g59687 = ( 1.0 - break55_g59687.y );
					float ifLocalVar60_g59687 = 0;
					if( temp_output_56_0_g59687 <= 0.0 )
					ifLocalVar60_g59687 = temp_output_66_0_g59687;
					else
					ifLocalVar60_g59687 = break55_g59687.y;
					float temp_output_597_28_g59686 = ifLocalVar60_g59687;
					float2 ifLocalVar89_g59687 = 0;
					if( temp_output_56_0_g59687 > 0.0 )
					ifLocalVar89_g59687 = temp_output_123_0_g59687;
					else if( temp_output_56_0_g59687 == 0.0 )
					ifLocalVar89_g59687 = temp_output_90_0_g59687;
					else if( temp_output_56_0_g59687 < 0.0 )
					ifLocalVar89_g59687 = temp_output_90_0_g59687;
					float3 temp_output_7_0_g59690 = frac( ( (ifLocalVar89_g59687).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59690 = dot( temp_output_7_0_g59690 , ( (temp_output_7_0_g59690).yzx + 33.33 ) );
					float3 temp_output_12_0_g59690 = ( temp_output_7_0_g59690 + dotResult8_g59690 );
					float2 temp_output_597_27_g59686 = ( UV100_g59687 + frac( ( ( (temp_output_12_0_g59690).xx + (temp_output_12_0_g59690).yz ) * (temp_output_12_0_g59690).zy ) ) );
					float temp_output_67_0_g59687 = ( 1.0 - break55_g59687.x );
					float ifLocalVar61_g59687 = 0;
					if( temp_output_56_0_g59687 <= 0.0 )
					ifLocalVar61_g59687 = temp_output_67_0_g59687;
					else
					ifLocalVar61_g59687 = break55_g59687.x;
					float temp_output_597_29_g59686 = ifLocalVar61_g59687;
					float4 Output_2D293_g59686 = ( ( tex2D( _Sampler82964_g59553, temp_output_597_0_g59686, DDX631_g59686, DDY632_g59686 ) * temp_output_597_30_g59686 ) + ( tex2D( _Sampler82964_g59553, temp_output_597_26_g59686, DDX631_g59686, DDY632_g59686 ) * temp_output_597_28_g59686 ) + ( tex2D( _Sampler82964_g59553, temp_output_597_27_g59686, DDX631_g59686, DDY632_g59686 ) * temp_output_597_29_g59686 ) );
					float4 break31_g59686 = Output_2D293_g59686;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g59553 = ( 1.0 - break31_g59686.r );
					#else
					float staticSwitch1004_g59553 = ( 1.0 - staticSwitch845_g59553 );
					#endif
					float temp_output_19_0_g59852 = staticSwitch1004_g59553;
					float2 temp_output_5_0_g59660 = UV0A2420_g59553;
					float2 UV633_g59660 = temp_output_5_0_g59660;
					float2 UV100_g59661 = UV633_g59660;
					float2 temp_output_51_0_g59661 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59661 * float2( 3.464,3.464 ) ) );
					float2 break55_g59661 = frac( temp_output_51_0_g59661 );
					float temp_output_56_0_g59661 = ( ( 1.0 - break55_g59661.x ) - break55_g59661.y );
					float2 temp_output_52_0_g59661 = floor( temp_output_51_0_g59661 );
					float2 temp_output_125_0_g59661 = ( temp_output_52_0_g59661 + float2( 1,1 ) );
					float2 ifLocalVar87_g59661 = 0;
					if( temp_output_56_0_g59661 > 0.0 )
					ifLocalVar87_g59661 = temp_output_52_0_g59661;
					else if( temp_output_56_0_g59661 == 0.0 )
					ifLocalVar87_g59661 = temp_output_125_0_g59661;
					else if( temp_output_56_0_g59661 < 0.0 )
					ifLocalVar87_g59661 = temp_output_125_0_g59661;
					float3 temp_output_7_0_g59662 = frac( ( (ifLocalVar87_g59661).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59662 = dot( temp_output_7_0_g59662 , ( (temp_output_7_0_g59662).yzx + 33.33 ) );
					float3 temp_output_12_0_g59662 = ( temp_output_7_0_g59662 + dotResult8_g59662 );
					float2 temp_output_597_0_g59660 = ( UV100_g59661 + frac( ( ( (temp_output_12_0_g59662).xx + (temp_output_12_0_g59662).yz ) * (temp_output_12_0_g59662).zy ) ) );
					float2 DDX631_g59660 = ddx( temp_output_5_0_g59660 );
					float2 DDY632_g59660 = ddy( temp_output_5_0_g59660 );
					float Input_Scale617_g59660 = 1.5;
					float temp_output_65_0_g59661 = ( 0.0 - temp_output_56_0_g59661 );
					float ifLocalVar59_g59661 = 0;
					if( temp_output_56_0_g59661 <= 0.0 )
					ifLocalVar59_g59661 = temp_output_65_0_g59661;
					else
					ifLocalVar59_g59661 = temp_output_56_0_g59661;
					float temp_output_597_30_g59660 = ifLocalVar59_g59661;
					float2 temp_output_90_0_g59661 = ( temp_output_52_0_g59661 + float2( 0,1 ) );
					float2 temp_output_123_0_g59661 = ( temp_output_52_0_g59661 + float2( 1,0 ) );
					float2 ifLocalVar88_g59661 = 0;
					if( temp_output_56_0_g59661 > 0.0 )
					ifLocalVar88_g59661 = temp_output_90_0_g59661;
					else if( temp_output_56_0_g59661 == 0.0 )
					ifLocalVar88_g59661 = temp_output_123_0_g59661;
					else if( temp_output_56_0_g59661 < 0.0 )
					ifLocalVar88_g59661 = temp_output_123_0_g59661;
					float3 temp_output_7_0_g59663 = frac( ( (ifLocalVar88_g59661).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59663 = dot( temp_output_7_0_g59663 , ( (temp_output_7_0_g59663).yzx + 33.33 ) );
					float3 temp_output_12_0_g59663 = ( temp_output_7_0_g59663 + dotResult8_g59663 );
					float2 temp_output_597_26_g59660 = ( UV100_g59661 + frac( ( ( (temp_output_12_0_g59663).xx + (temp_output_12_0_g59663).yz ) * (temp_output_12_0_g59663).zy ) ) );
					float temp_output_66_0_g59661 = ( 1.0 - break55_g59661.y );
					float ifLocalVar60_g59661 = 0;
					if( temp_output_56_0_g59661 <= 0.0 )
					ifLocalVar60_g59661 = temp_output_66_0_g59661;
					else
					ifLocalVar60_g59661 = break55_g59661.y;
					float temp_output_597_28_g59660 = ifLocalVar60_g59661;
					float2 ifLocalVar89_g59661 = 0;
					if( temp_output_56_0_g59661 > 0.0 )
					ifLocalVar89_g59661 = temp_output_123_0_g59661;
					else if( temp_output_56_0_g59661 == 0.0 )
					ifLocalVar89_g59661 = temp_output_90_0_g59661;
					else if( temp_output_56_0_g59661 < 0.0 )
					ifLocalVar89_g59661 = temp_output_90_0_g59661;
					float3 temp_output_7_0_g59664 = frac( ( (ifLocalVar89_g59661).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59664 = dot( temp_output_7_0_g59664 , ( (temp_output_7_0_g59664).yzx + 33.33 ) );
					float3 temp_output_12_0_g59664 = ( temp_output_7_0_g59664 + dotResult8_g59664 );
					float2 temp_output_597_27_g59660 = ( UV100_g59661 + frac( ( ( (temp_output_12_0_g59664).xx + (temp_output_12_0_g59664).yz ) * (temp_output_12_0_g59664).zy ) ) );
					float temp_output_67_0_g59661 = ( 1.0 - break55_g59661.x );
					float ifLocalVar61_g59661 = 0;
					if( temp_output_56_0_g59661 <= 0.0 )
					ifLocalVar61_g59661 = temp_output_67_0_g59661;
					else
					ifLocalVar61_g59661 = break55_g59661.x;
					float temp_output_597_29_g59660 = ifLocalVar61_g59661;
					float3 Output_2D_Normal641_g59660 = ( ( UnpackScaleNormal( tex2D( _Sampler82965_g59553, temp_output_597_0_g59660, DDX631_g59660, DDY632_g59660 ), Input_Scale617_g59660 ) * temp_output_597_30_g59660 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g59553, temp_output_597_26_g59660, DDX631_g59660, DDY632_g59660 ), Input_Scale617_g59660 ) * temp_output_597_28_g59660 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g59553, temp_output_597_27_g59660, DDX631_g59660, DDY632_g59660 ), Input_Scale617_g59660 ) * float3( 0,0,0 ) * temp_output_597_29_g59660 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g59553 = Output_2D_Normal641_g59660;
					#else
					float3 staticSwitch1003_g59553 = UnpackScaleNormal( tex2D( _BumpMap, UV0A2420_g59553 ), 1.5 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g59553 = staticSwitch1003_g59553;
					#else
					float3 staticSwitch980_g59553 = float3( 0, 0, 1 );
					#endif
					float3 normalizeResult2878_g59553 = normalize( staticSwitch980_g59553 );
					float3 Normal_Map700_g59553 = normalizeResult2878_g59553;
					float3 ase_tangentWS = IN.ase_texcoord1.xyz;
					float3 ase_normalWS = IN.ase_texcoord2.xyz;
					float3 ase_bitangentWS = IN.ase_texcoord3.xyz;
					float3 tanToWorld0 = float3( ase_tangentWS.x, ase_bitangentWS.x, ase_normalWS.x );
					float3 tanToWorld1 = float3( ase_tangentWS.y, ase_bitangentWS.y, ase_normalWS.y );
					float3 tanToWorld2 = float3( ase_tangentWS.z, ase_bitangentWS.z, ase_normalWS.z );
					float3 tanNormal2504_g59553 = Normal_Map700_g59553;
					float3 worldNormal2504_g59553 = normalize( float3( dot( tanToWorld0, tanNormal2504_g59553 ), dot( tanToWorld1, tanNormal2504_g59553 ), dot( tanToWorld2, tanNormal2504_g59553 ) ) );
					float3 World_Normal2508_g59553 = worldNormal2504_g59553;
					float3 tanNormal2_g59852 = World_Normal2508_g59553;
					float3 worldNormal2_g59852 = float3( dot( tanToWorld0, tanNormal2_g59852 ), dot( tanToWorld1, tanNormal2_g59852 ), dot( tanToWorld2, tanNormal2_g59852 ) );
					float3 temp_output_3_0_g59852 = ddx( worldNormal2_g59852 );
					float dotResult5_g59852 = dot( temp_output_3_0_g59852 , temp_output_3_0_g59852 );
					float3 temp_output_4_0_g59852 = ddy( worldNormal2_g59852 );
					float dotResult6_g59852 = dot( temp_output_4_0_g59852 , temp_output_4_0_g59852 );
					#ifdef _USEGEOMETRICAA_ON
					float staticSwitch15_g59852 = min( temp_output_19_0_g59852, ( 1.0 - pow( saturate( max( dotResult5_g59852, dotResult6_g59852 ) ) , 0.25 ) ) );
					#else
					float staticSwitch15_g59852 = temp_output_19_0_g59852;
					#endif
					float Smoothness1399_g59553 = staticSwitch15_g59852;
					float Smoothness1_g59991 = Smoothness1399_g59553;
					float3 ase_positionWS = IN.ase_texcoord4.xyz;
					float3 ase_viewVectorWS = ( ( unity_OrthoParams.w == 0 ) ? _WorldSpaceCameraPos - ase_positionWS : UNITY_MATRIX_V[ 2 ].xyz );
					float3 ase_viewDirWS = normalize( ase_viewVectorWS );
					float3 View_Direction2511_g59553 = ase_viewDirWS;
					float3 ViewDir1_g59991 = View_Direction2511_g59553;
					float3 World_Position2505_g59553 = ase_positionWS;
					float3 WorldPos1_g59991 = World_Position2505_g59553;
					float3 WorldNormal1_g59991 = World_Normal2508_g59553;
					float White38_g59553 = 1.0;
					float4 temp_cast_2 = (Black1185_g59553).xxxx;
					float4 texCoord2426_g59553 = IN.ase_texcoord;
					texCoord2426_g59553.xy = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0B2361_g59553 = (texCoord2426_g59553).zw;
					float localBicubicPrepare2_g59567 = ( 0.0 );
					float2 Input_UV100_g59567 = UV0B2361_g59553;
					float2 UV2_g59567 = Input_UV100_g59567;
					float4 TexelSize2_g59567 = _Lightmap0_TexelSize;
					float2 UV02_g59567 = float2( 0,0 );
					float2 UV12_g59567 = float2( 0,0 );
					float2 UV22_g59567 = float2( 0,0 );
					float2 UV32_g59567 = float2( 0,0 );
					float W02_g59567 = 0;
					float W12_g59567 = 0;
					{
					{
					 UV2_g59567 = UV2_g59567 * TexelSize2_g59567.zw - 0.5;
					    float2 f = frac( UV2_g59567 );
					    UV2_g59567 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59567.x - 0.5, UV2_g59567.x + 1.5, UV2_g59567.y - 0.5, UV2_g59567.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59567.xyxy;
					    UV02_g59567 = off.xz;
					    UV12_g59567 = off.yz;
					    UV22_g59567 = off.xw;
					    UV32_g59567 = off.yw;
					    W02_g59567 = s.x / ( s.x + s.y );
					 W12_g59567 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59567 = lerp( tex2D( _Lightmap0, UV32_g59567 ) , tex2D( _Lightmap0, UV22_g59567 ) , W02_g59567);
					float4 lerpResult45_g59567 = lerp( tex2D( _Lightmap0, UV12_g59567 ) , tex2D( _Lightmap0, UV02_g59567 ) , W02_g59567);
					float4 lerpResult44_g59567 = lerp( lerpResult46_g59567 , lerpResult45_g59567 , W12_g59567);
					float4 Output_2D_Auto131_g59567 = lerpResult44_g59567;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g59553 = Output_2D_Auto131_g59567;
					#else
					float4 staticSwitch1092_g59553 = float4( tex2D( _Lightmap0, UV0B2361_g59553 ).rgb , 0.0 );
					#endif
					float4 Lightmap_0925_g59553 = staticSwitch1092_g59553;
					float localBicubicPrepare2_g59560 = ( 0.0 );
					float2 Input_UV100_g59560 = UV0B2361_g59553;
					float2 UV2_g59560 = Input_UV100_g59560;
					float4 TexelSize2_g59560 = _Lightmap1_TexelSize;
					float2 UV02_g59560 = float2( 0,0 );
					float2 UV12_g59560 = float2( 0,0 );
					float2 UV22_g59560 = float2( 0,0 );
					float2 UV32_g59560 = float2( 0,0 );
					float W02_g59560 = 0;
					float W12_g59560 = 0;
					{
					{
					 UV2_g59560 = UV2_g59560 * TexelSize2_g59560.zw - 0.5;
					    float2 f = frac( UV2_g59560 );
					    UV2_g59560 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59560.x - 0.5, UV2_g59560.x + 1.5, UV2_g59560.y - 0.5, UV2_g59560.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59560.xyxy;
					    UV02_g59560 = off.xz;
					    UV12_g59560 = off.yz;
					    UV22_g59560 = off.xw;
					    UV32_g59560 = off.yw;
					    W02_g59560 = s.x / ( s.x + s.y );
					 W12_g59560 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59560 = lerp( tex2D( _Lightmap1, UV32_g59560 ) , tex2D( _Lightmap1, UV22_g59560 ) , W02_g59560);
					float4 lerpResult45_g59560 = lerp( tex2D( _Lightmap1, UV12_g59560 ) , tex2D( _Lightmap1, UV02_g59560 ) , W02_g59560);
					float4 lerpResult44_g59560 = lerp( lerpResult46_g59560 , lerpResult45_g59560 , W12_g59560);
					float4 Output_2D_Auto131_g59560 = lerpResult44_g59560;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g59553 = Output_2D_Auto131_g59560;
					#else
					float4 staticSwitch1088_g59553 = tex2D( _Lightmap1, UV0B2361_g59553 );
					#endif
					float4 Lightmap_1956_g59553 = staticSwitch1088_g59553;
					float Lightmap_Lerp_Value969_g59553 = _UdonLightmapLerp;
					float4 lerpResult442_g59553 = lerp( Lightmap_0925_g59553 , Lightmap_1956_g59553 , Lightmap_Lerp_Value969_g59553);
					float4 Lightmap_Lerp932_g59553 = lerpResult442_g59553;
					float3 appendResult139_g59981 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 Normal_Map318_g59981 = Normal_Map700_g59553;
					float dotResult121_g59981 = dot( appendResult139_g59981 , Normal_Map318_g59981 );
					float temp_output_2_0_g59983 = saturate( dotResult121_g59981 );
					float localStochasticTiling2_g59698 = ( 0.0 );
					float2 UV2_g59698 = UV0B2361_g59553;
					float4 TexelSize2_g59698 = _UdonRNMX0_TexelSize;
					float4 Offsets2_g59698 = float4( 0,0,0,0 );
					float2 Weights2_g59698 = float2( 0,0 );
					{
					UV2_g59698 = UV2_g59698 * TexelSize2_g59698.zw - 0.5;
					float2 f = frac( UV2_g59698 );
					UV2_g59698 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g59698.x - 0.5, UV2_g59698.x + 1.5, UV2_g59698.y - 0.5, UV2_g59698.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g59698 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59698.xyxy;
					Weights2_g59698 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g59697 = Offsets2_g59698;
					float4 Input_FetchOffsets197_g59699 = temp_output_1_34_g59697;
					float2 temp_output_1_54_g59697 = Weights2_g59698;
					float2 Input_FetchWeights200_g59699 = temp_output_1_54_g59697;
					float2 break187_g59699 = Input_FetchWeights200_g59699;
					float4 lerpResult181_g59699 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g59699).yw ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g59699).xw ) , break187_g59699.x);
					float4 lerpResult182_g59699 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g59699).yz ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g59699).xz ) , break187_g59699.x);
					float4 lerpResult176_g59699 = lerp( lerpResult181_g59699 , lerpResult182_g59699 , break187_g59699.y);
					float4 Output_Fetch2D_Auto202_g59699 = lerpResult176_g59699;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g59553 = Output_Fetch2D_Auto202_g59699;
					#else
					float4 staticSwitch1061_g59553 = tex2D( _UdonRNMX0, UV0B2361_g59553 );
					#endif
					float3 appendResult146_g59981 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59981 = dot( appendResult146_g59981 , Normal_Map318_g59981 );
					float temp_output_2_0_g59982 = saturate( dotResult122_g59981 );
					float4 Input_FetchOffsets197_g59700 = temp_output_1_34_g59697;
					float2 Input_FetchWeights200_g59700 = temp_output_1_54_g59697;
					float2 break187_g59700 = Input_FetchWeights200_g59700;
					float4 lerpResult181_g59700 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g59700).yw ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g59700).xw ) , break187_g59700.x);
					float4 lerpResult182_g59700 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g59700).yz ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g59700).xz ) , break187_g59700.x);
					float4 lerpResult176_g59700 = lerp( lerpResult181_g59700 , lerpResult182_g59700 , break187_g59700.y);
					float4 Output_Fetch2D_Auto202_g59700 = lerpResult176_g59700;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g59553 = Output_Fetch2D_Auto202_g59700;
					#else
					float4 staticSwitch1062_g59553 = tex2D( _UdonRNMY0, UV0B2361_g59553 );
					#endif
					float3 appendResult149_g59981 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59981 = dot( appendResult149_g59981 , Normal_Map318_g59981 );
					float temp_output_2_0_g59984 = saturate( dotResult120_g59981 );
					float4 Input_FetchOffsets197_g59701 = temp_output_1_34_g59697;
					float2 Input_FetchWeights200_g59701 = temp_output_1_54_g59697;
					float2 break187_g59701 = Input_FetchWeights200_g59701;
					float4 lerpResult181_g59701 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g59701).yw ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g59701).xw ) , break187_g59701.x);
					float4 lerpResult182_g59701 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g59701).yz ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g59701).xz ) , break187_g59701.x);
					float4 lerpResult176_g59701 = lerp( lerpResult181_g59701 , lerpResult182_g59701 , break187_g59701.y);
					float4 Output_Fetch2D_Auto202_g59701 = lerpResult176_g59701;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g59553 = Output_Fetch2D_Auto202_g59701;
					#else
					float4 staticSwitch1063_g59553 = tex2D( _UdonRNMZ0, UV0B2361_g59553 );
					#endif
					float4 temp_output_3094_0_g59553 = ( ( ( ( ( temp_output_2_0_g59983 * temp_output_2_0_g59983 ) * staticSwitch1061_g59553 ) + ( ( temp_output_2_0_g59982 * temp_output_2_0_g59982 ) * staticSwitch1062_g59553 ) ) + ( ( temp_output_2_0_g59984 * temp_output_2_0_g59984 ) * staticSwitch1063_g59553 ) ) * 1.2 );
					float4 RNM_0926_g59553 = temp_output_3094_0_g59553;
					float3 appendResult139_g59963 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 Normal_Map318_g59963 = Normal_Map700_g59553;
					float dotResult121_g59963 = dot( appendResult139_g59963 , Normal_Map318_g59963 );
					float temp_output_2_0_g59965 = saturate( dotResult121_g59963 );
					float localStochasticTiling2_g59555 = ( 0.0 );
					float2 UV2_g59555 = UV0B2361_g59553;
					float4 TexelSize2_g59555 = _UdonRNMX1_TexelSize;
					float4 Offsets2_g59555 = float4( 0,0,0,0 );
					float2 Weights2_g59555 = float2( 0,0 );
					{
					UV2_g59555 = UV2_g59555 * TexelSize2_g59555.zw - 0.5;
					float2 f = frac( UV2_g59555 );
					UV2_g59555 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g59555.x - 0.5, UV2_g59555.x + 1.5, UV2_g59555.y - 0.5, UV2_g59555.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g59555 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59555.xyxy;
					Weights2_g59555 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g59554 = Offsets2_g59555;
					float4 Input_FetchOffsets197_g59556 = temp_output_1_34_g59554;
					float2 temp_output_1_54_g59554 = Weights2_g59555;
					float2 Input_FetchWeights200_g59556 = temp_output_1_54_g59554;
					float2 break187_g59556 = Input_FetchWeights200_g59556;
					float4 lerpResult181_g59556 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g59556).yw ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g59556).xw ) , break187_g59556.x);
					float4 lerpResult182_g59556 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g59556).yz ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g59556).xz ) , break187_g59556.x);
					float4 lerpResult176_g59556 = lerp( lerpResult181_g59556 , lerpResult182_g59556 , break187_g59556.y);
					float4 Output_Fetch2D_Auto202_g59556 = lerpResult176_g59556;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g59553 = Output_Fetch2D_Auto202_g59556;
					#else
					float4 staticSwitch1087_g59553 = tex2D( _UdonRNMX1, UV0B2361_g59553 );
					#endif
					float3 appendResult146_g59963 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59963 = dot( appendResult146_g59963 , Normal_Map318_g59963 );
					float temp_output_2_0_g59964 = saturate( dotResult122_g59963 );
					float4 Input_FetchOffsets197_g59557 = temp_output_1_34_g59554;
					float2 Input_FetchWeights200_g59557 = temp_output_1_54_g59554;
					float2 break187_g59557 = Input_FetchWeights200_g59557;
					float4 lerpResult181_g59557 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g59557).yw ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g59557).xw ) , break187_g59557.x);
					float4 lerpResult182_g59557 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g59557).yz ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g59557).xz ) , break187_g59557.x);
					float4 lerpResult176_g59557 = lerp( lerpResult181_g59557 , lerpResult182_g59557 , break187_g59557.y);
					float4 Output_Fetch2D_Auto202_g59557 = lerpResult176_g59557;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g59553 = Output_Fetch2D_Auto202_g59557;
					#else
					float4 staticSwitch1083_g59553 = tex2D( _UdonRNMY1, UV0B2361_g59553 );
					#endif
					float3 appendResult149_g59963 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59963 = dot( appendResult149_g59963 , Normal_Map318_g59963 );
					float temp_output_2_0_g59966 = saturate( dotResult120_g59963 );
					float4 Input_FetchOffsets197_g59558 = temp_output_1_34_g59554;
					float2 Input_FetchWeights200_g59558 = temp_output_1_54_g59554;
					float2 break187_g59558 = Input_FetchWeights200_g59558;
					float4 lerpResult181_g59558 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g59558).yw ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g59558).xw ) , break187_g59558.x);
					float4 lerpResult182_g59558 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g59558).yz ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g59558).xz ) , break187_g59558.x);
					float4 lerpResult176_g59558 = lerp( lerpResult181_g59558 , lerpResult182_g59558 , break187_g59558.y);
					float4 Output_Fetch2D_Auto202_g59558 = lerpResult176_g59558;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g59553 = Output_Fetch2D_Auto202_g59558;
					#else
					float4 staticSwitch1084_g59553 = tex2D( _UdonRNMZ1, UV0B2361_g59553 );
					#endif
					float4 RNM_11081_g59553 = ( ( ( ( ( temp_output_2_0_g59965 * temp_output_2_0_g59965 ) * staticSwitch1087_g59553 ) + ( ( temp_output_2_0_g59964 * temp_output_2_0_g59964 ) * staticSwitch1083_g59553 ) ) + ( ( temp_output_2_0_g59966 * temp_output_2_0_g59966 ) * staticSwitch1084_g59553 ) ) * 1.2 );
					float4 lerpResult953_g59553 = lerp( RNM_0926_g59553 , RNM_11081_g59553 , Lightmap_Lerp_Value969_g59553);
					float4 RNM_Lerp950_g59553 = lerpResult953_g59553;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g59553 = temp_cast_2;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g59553 = Lightmap_0925_g59553;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g59553 = Lightmap_Lerp932_g59553;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g59553 = RNM_0926_g59553;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g59553 = RNM_Lerp950_g59553;
					#else
					float4 staticSwitch1014_g59553 = temp_cast_2;
					#endif
					float3 Lightmap46_g59553 = (staticSwitch1014_g59553).rgb;
					float dotResult9_g59990 = dot( float3( 0.212673, 0.715152, 0.072175 ) , Lightmap46_g59553 );
					float smoothstepResult14_g59990 = smoothstep( 0.0 , 0.04 , dotResult9_g59990);
					float Indirect_Lightmap_Mask3118_g59553 = smoothstepResult14_g59990;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float staticSwitch3145_g59553 = White38_g59553;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float staticSwitch3145_g59553 = Indirect_Lightmap_Mask3118_g59553;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float staticSwitch3145_g59553 = Indirect_Lightmap_Mask3118_g59553;
					#elif defined( _LIGHTMAPMODE_RNM )
					float staticSwitch3145_g59553 = Indirect_Lightmap_Mask3118_g59553;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float staticSwitch3145_g59553 = Indirect_Lightmap_Mask3118_g59553;
					#else
					float staticSwitch3145_g59553 = White38_g59553;
					#endif
					float LightmapMask1_g59991 = staticSwitch3145_g59553;
					float3 localIndirectSpecular1_g59991 = IndirectSpecular( Color1_g59991 , Metallic1_g59991 , Smoothness1_g59991 , ViewDir1_g59991 , WorldPos1_g59991 , WorldNormal1_g59991 , LightmapMask1_g59991 );
					#ifdef _INDIRECTSPECULARS_ON
					float3 staticSwitch2971_g59553 = localIndirectSpecular1_g59991;
					#else
					float3 staticSwitch2971_g59553 = temp_cast_1;
					#endif
					float3 Indirect_Specular1419_g59553 = staticSwitch2971_g59553;
					float3 temp_cast_4 = (Black1185_g59553).xxx;
					float3 Color97_g59972 = oAlbedo6_g59553;
					float Metallic97_g59972 = Metallic1239_g59553;
					float Smoothness97_g59972 = Smoothness1399_g59553;
					float3 ViewDir97_g59972 = View_Direction2511_g59553;
					float3 WorldPos97_g59972 = World_Position2505_g59553;
					float3 WorldNormal97_g59972 = World_Normal2508_g59553;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float staticSwitch3107_g59553 = Black1185_g59553;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float staticSwitch3107_g59553 = White38_g59553;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float staticSwitch3107_g59553 = White38_g59553;
					#elif defined( _LIGHTMAPMODE_RNM )
					float staticSwitch3107_g59553 = White38_g59553;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float staticSwitch3107_g59553 = White38_g59553;
					#else
					float staticSwitch3107_g59553 = Black1185_g59553;
					#endif
					float LightmapMode97_g59972 = staticSwitch3107_g59553;
					float dotResult9_g59989 = dot( float3( 0.212673, 0.715152, 0.072175 ) , Lightmap46_g59553 );
					float smoothstepResult2_g59989 = smoothstep( 0.0 , 0.4 , dotResult9_g59989);
					float Direct_Lightmap_Mask3067_g59553 = smoothstepResult2_g59989;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float staticSwitch3085_g59553 = White38_g59553;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float staticSwitch3085_g59553 = Direct_Lightmap_Mask3067_g59553;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float staticSwitch3085_g59553 = Direct_Lightmap_Mask3067_g59553;
					#elif defined( _LIGHTMAPMODE_RNM )
					float staticSwitch3085_g59553 = Direct_Lightmap_Mask3067_g59553;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float staticSwitch3085_g59553 = Direct_Lightmap_Mask3067_g59553;
					#else
					float staticSwitch3085_g59553 = White38_g59553;
					#endif
					float LightmapMask97_g59972 = staticSwitch3085_g59553;
					float3 localDirectSpecular97_g59972 = DirectSpecular( Color97_g59972 , Metallic97_g59972 , Smoothness97_g59972 , ViewDir97_g59972 , WorldPos97_g59972 , WorldNormal97_g59972 , LightmapMode97_g59972 , LightmapMask97_g59972 );
					#ifdef _DIRECTSPECULAR_ON
					float3 staticSwitch2969_g59553 = localDirectSpecular97_g59972;
					#else
					float3 staticSwitch2969_g59553 = temp_cast_4;
					#endif
					float3 Direct_Specular2560_g59553 = staticSwitch2969_g59553;
					float3 aAlbedo1466_g59553 = ( temp_output_2532_0_g59553 * ( 1.0 - Metallic1239_g59553 ) );
					float3 temp_output_1252_0_g59553 = ( aAlbedo1466_g59553 * Lightmap46_g59553 );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch1_g59863 = float4( ( temp_output_1252_0_g59553 + Emission86_g59553 + Indirect_Specular1419_g59553 ) , 0.0 );
					#else
					float4 staticSwitch1_g59863 = float4( ( Emission86_g59553 + Indirect_Specular1419_g59553 + Direct_Specular2560_g59553 + temp_output_1252_0_g59553 ) , 0.0 );
					#endif
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1181_g59553 = float4( Lightmap46_g59553 , 0.0 );
					#else
					float4 staticSwitch1181_g59553 = staticSwitch1_g59863;
					#endif
					float4 Color357_g59831 = staticSwitch1181_g59553;
					float4 LUT51_g59831 = tex3D( _LUT, ( ( log10( ( ( (Color357_g59831).xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 ) );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch359_g59831 = LUT51_g59831;
					#else
					float4 staticSwitch359_g59831 = Color357_g59831;
					#endif
					

					float4 Color = staticSwitch359_g59831;
					float Alpha = staticSwitch1001_g59553.a;
					half AlphaClipThreshold = 0.5;

					#ifdef _ALPHATEST_ON
						clip( Alpha - AlphaClipThreshold );
					#endif

					Color.a = Alpha;
					
					return Color;
				}
			ENDCG
		}

		
		Pass
		{
			
			Name "ShadowCaster"
			Tags { "LightMode"="ShadowCaster" }
			ZWrite On
			ZTest LEqual
			AlphaToMask Off

			CGPROGRAM
				#define ASE_VERSION 19909

				#pragma vertex vert
				#pragma fragment frag
				#pragma multi_compile_shadowcaster
				#ifndef UNITY_PASS_SHADOWCASTER
					#define UNITY_PASS_SHADOWCASTER
				#endif
				#include "HLSLSupport.cginc"
				#include "UnityShaderVariables.cginc"
				#include "UnityCG.cginc"
				#include "Lighting.cginc"
				#include "UnityPBSLighting.cginc"

				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#pragma shader_feature_local _STOCHASTICENABLED_ON
				#pragma shader_feature_local _MAINTEX


				struct appdata
				{
					float4 vertex : POSITION;
					half3 normal : NORMAL;
					float4 ase_texcoord : TEXCOORD0;
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct v2f
				{
					V2F_SHADOW_CASTER;
					float4 ase_texcoord1 : TEXCOORD1;
					UNITY_VERTEX_INPUT_INSTANCE_ID
					UNITY_VERTEX_OUTPUT_STEREO
				};

				#ifdef UNITY_STANDARD_USE_DITHER_MASK
					sampler3D _DitherMaskLOD;
				#endif

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
				uniform half4 _Color;
				uniform sampler2D _MainTex;
				sampler2D _Sampler82966_g59553;


				
				v2f vert( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID( v );
					v2f o;
					UNITY_INITIALIZE_OUTPUT( v2f, o );
					UNITY_TRANSFER_INSTANCE_ID( v, o );
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );

					o.ase_texcoord1 = v.ase_texcoord;

					v.vertex.w = 1;
					TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
					return o;
				}

				half4 frag( v2f IN  ) : SV_Target
				{
					UNITY_SETUP_INSTANCE_ID(IN);

					#ifdef LOD_FADE_CROSSFADE
						UNITY_APPLY_DITHER_CROSSFADE(IN.pos.xy);
					#endif

					float2 texCoord2357_g59553 = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0A2420_g59553 = texCoord2357_g59553;
					#ifdef _MAINTEX
					float4 staticSwitch1549_g59553 = tex2D( _MainTex, UV0A2420_g59553 );
					#else
					float4 staticSwitch1549_g59553 = _Color;
					#endif
					float2 temp_output_5_0_g59681 = UV0A2420_g59553;
					float2 UV633_g59681 = temp_output_5_0_g59681;
					float2 UV100_g59682 = UV633_g59681;
					float2 temp_output_51_0_g59682 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59682 * float2( 3.464,3.464 ) ) );
					float2 break55_g59682 = frac( temp_output_51_0_g59682 );
					float temp_output_56_0_g59682 = ( ( 1.0 - break55_g59682.x ) - break55_g59682.y );
					float2 temp_output_52_0_g59682 = floor( temp_output_51_0_g59682 );
					float2 temp_output_125_0_g59682 = ( temp_output_52_0_g59682 + float2( 1,1 ) );
					float2 ifLocalVar87_g59682 = 0;
					if( temp_output_56_0_g59682 > 0.0 )
					ifLocalVar87_g59682 = temp_output_52_0_g59682;
					else if( temp_output_56_0_g59682 == 0.0 )
					ifLocalVar87_g59682 = temp_output_125_0_g59682;
					else if( temp_output_56_0_g59682 < 0.0 )
					ifLocalVar87_g59682 = temp_output_125_0_g59682;
					float3 temp_output_7_0_g59683 = frac( ( (ifLocalVar87_g59682).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59683 = dot( temp_output_7_0_g59683 , ( (temp_output_7_0_g59683).yzx + 33.33 ) );
					float3 temp_output_12_0_g59683 = ( temp_output_7_0_g59683 + dotResult8_g59683 );
					float2 temp_output_597_0_g59681 = ( UV100_g59682 + frac( ( ( (temp_output_12_0_g59683).xx + (temp_output_12_0_g59683).yz ) * (temp_output_12_0_g59683).zy ) ) );
					float2 DDX631_g59681 = ddx( temp_output_5_0_g59681 );
					float2 DDY632_g59681 = ddy( temp_output_5_0_g59681 );
					float temp_output_65_0_g59682 = ( 0.0 - temp_output_56_0_g59682 );
					float ifLocalVar59_g59682 = 0;
					if( temp_output_56_0_g59682 <= 0.0 )
					ifLocalVar59_g59682 = temp_output_65_0_g59682;
					else
					ifLocalVar59_g59682 = temp_output_56_0_g59682;
					float temp_output_597_30_g59681 = ifLocalVar59_g59682;
					float2 temp_output_90_0_g59682 = ( temp_output_52_0_g59682 + float2( 0,1 ) );
					float2 temp_output_123_0_g59682 = ( temp_output_52_0_g59682 + float2( 1,0 ) );
					float2 ifLocalVar88_g59682 = 0;
					if( temp_output_56_0_g59682 > 0.0 )
					ifLocalVar88_g59682 = temp_output_90_0_g59682;
					else if( temp_output_56_0_g59682 == 0.0 )
					ifLocalVar88_g59682 = temp_output_123_0_g59682;
					else if( temp_output_56_0_g59682 < 0.0 )
					ifLocalVar88_g59682 = temp_output_123_0_g59682;
					float3 temp_output_7_0_g59684 = frac( ( (ifLocalVar88_g59682).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59684 = dot( temp_output_7_0_g59684 , ( (temp_output_7_0_g59684).yzx + 33.33 ) );
					float3 temp_output_12_0_g59684 = ( temp_output_7_0_g59684 + dotResult8_g59684 );
					float2 temp_output_597_26_g59681 = ( UV100_g59682 + frac( ( ( (temp_output_12_0_g59684).xx + (temp_output_12_0_g59684).yz ) * (temp_output_12_0_g59684).zy ) ) );
					float temp_output_66_0_g59682 = ( 1.0 - break55_g59682.y );
					float ifLocalVar60_g59682 = 0;
					if( temp_output_56_0_g59682 <= 0.0 )
					ifLocalVar60_g59682 = temp_output_66_0_g59682;
					else
					ifLocalVar60_g59682 = break55_g59682.y;
					float temp_output_597_28_g59681 = ifLocalVar60_g59682;
					float2 ifLocalVar89_g59682 = 0;
					if( temp_output_56_0_g59682 > 0.0 )
					ifLocalVar89_g59682 = temp_output_123_0_g59682;
					else if( temp_output_56_0_g59682 == 0.0 )
					ifLocalVar89_g59682 = temp_output_90_0_g59682;
					else if( temp_output_56_0_g59682 < 0.0 )
					ifLocalVar89_g59682 = temp_output_90_0_g59682;
					float3 temp_output_7_0_g59685 = frac( ( (ifLocalVar89_g59682).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59685 = dot( temp_output_7_0_g59685 , ( (temp_output_7_0_g59685).yzx + 33.33 ) );
					float3 temp_output_12_0_g59685 = ( temp_output_7_0_g59685 + dotResult8_g59685 );
					float2 temp_output_597_27_g59681 = ( UV100_g59682 + frac( ( ( (temp_output_12_0_g59685).xx + (temp_output_12_0_g59685).yz ) * (temp_output_12_0_g59685).zy ) ) );
					float temp_output_67_0_g59682 = ( 1.0 - break55_g59682.x );
					float ifLocalVar61_g59682 = 0;
					if( temp_output_56_0_g59682 <= 0.0 )
					ifLocalVar61_g59682 = temp_output_67_0_g59682;
					else
					ifLocalVar61_g59682 = break55_g59682.x;
					float temp_output_597_29_g59681 = ifLocalVar61_g59682;
					float4 Output_2D293_g59681 = ( ( tex2D( _Sampler82966_g59553, temp_output_597_0_g59681, DDX631_g59681, DDY632_g59681 ) * temp_output_597_30_g59681 ) + ( tex2D( _Sampler82966_g59553, temp_output_597_26_g59681, DDX631_g59681, DDY632_g59681 ) * temp_output_597_28_g59681 ) + ( tex2D( _Sampler82966_g59553, temp_output_597_27_g59681, DDX631_g59681, DDY632_g59681 ) * temp_output_597_29_g59681 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g59553 = Output_2D293_g59681;
					#else
					float4 staticSwitch1001_g59553 = staticSwitch1549_g59553;
					#endif
					

					float Alpha = staticSwitch1001_g59553.a;
					half AlphaClipThreshold = 0.5;

					#ifdef _ALPHATEST_ON
						clip(Alpha - AlphaClipThreshold);
					#endif

					#ifdef UNITY_STANDARD_USE_DITHER_MASK
						half alphaRef = tex3D(_DitherMaskLOD, float3(IN.pos.xy*0.25,Alpha*0.9375)).a;
						clip(alphaRef - 0.01);
					#endif

					SHADOW_CASTER_FRAGMENT(IN)
				}
			ENDCG
		}
		
	}
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
	
	Fallback Off
}/*ASEBEGIN
Version=19909
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;12;-320,0;Inherit;False;Meenphie;0;;59553;b3ba55a08dd6b49c7be16c6f35cf2033;6,1008,0,2632,0,2635,0,2619,0,2670,0,2636,0;0;3;FLOAT4;624;FLOAT;156;FLOAT;427
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;13;0,0;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;8;Meenphie/Standard/Transparent/Transparent Blend;95d28ca0904218e4fa77b1221c962cb8;True;Unlit;0;0;Unlit;3;True;True;2;5;False;;10;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;False;;True;2;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;2;Alpha Clipping;0;0;Cast Shadows;1;0;0;2;True;True;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;14;0,0;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;95d28ca0904218e4fa77b1221c962cb8;True;ShadowCaster;0;1;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;False;;True;2;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
WireConnection;13;0;12;624
WireConnection;13;7;12;156
ASEEND*/
//CHKSM=8591615E00AA345D7EE397C4CBFE28221EDE6D1F