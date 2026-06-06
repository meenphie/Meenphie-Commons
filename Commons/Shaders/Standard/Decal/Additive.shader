// Made with Amplify Shader Editor v1.9.9.9
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Standard/Decal/Additive"
{
	Properties
	{
		[Meenphie_DrawerCategory(SURFACE OPTIONS,true,0,0)] _CATEGORY_SURFACEOPTIONS( "CATEGORY_SURFACEOPTIONS", Float ) = 1
		_Color( "DIffuse Color", Color ) = ( 0.9058824, 0.9058824, 0.9058824, 1 )
		[NoScaleOffset][SingleLineTexture] _MainTex( "Base Color", 2D ) = "white" {}
		[NoScaleOffset][SingleLineTexture] _BumpMap( "Normal", 2D ) = "bump" {}
		[NoScaleOffset][SingleLineTexture] _MetallicMap( "Metallic", 2D ) = "black" {}
		[NoScaleOffset][SingleLineTexture] _GlossinessMap( "Roughness", 2D ) = "black" {}
		[KeywordEnum( UV0,UV2 )] _UV( "UV", Float ) = 1
		_Metallic( "Metallic", Range( 0, 1 ) ) = 0
		_Glossiness( "Roughness", Range( 0, 1 ) ) = 0.5
		[Toggle( _USEGEOMETRICAA_ON )] _UseGeometricAA( "Use Geometric AA", Float ) = 1
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESURFACEOPTIONS( "CATEGORY SPACE SURFACEOPTIONS", Float ) = 0
		[Meenphie_DrawerCategory(EMISSION,true,0,0)] _CATEGORYEMISSION( "CATEGORY EMISSION", Float ) = 0
		[NoScaleOffset][SingleLineTexture] _EmissionMap( "Emission", 2D ) = "white" {}
		[KeywordEnum( UV0,UV2 )] _EmissionUV( "Emission UV", Float ) = 0
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
		

		

		Tags { "RenderType"="Transparent" "Queue"="Transparent+1" }

	LOD 0

		

		Blend One One
		AlphaToMask Off
		Cull Back
		ColorMask RGBA
		ZWrite Off
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
				#define ASE_NEEDS_TEXTURE_COORDINATES2
				#define ASE_NEEDS_VERT_NORMAL
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
				#pragma shader_feature _LIGHTMAPDEBUG
				#pragma shader_feature_local _STOCHASTICENABLED_ON
				#pragma shader_feature_local_fragment _EMISSIONUV_UV0 _EMISSIONUV_UV2
				#pragma shader_feature_local _INDIRECTSPECULARS_ON
				#pragma shader_feature_local _MAINTEX
				#pragma shader_feature_local _METALLICMAP
				#pragma shader_feature_local _UV_UV0 _UV_UV2
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
					float4 ase_texcoord2 : TEXCOORD2;
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
					float4 ase_texcoord5 : TEXCOORD5;
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
				sampler2D _Sampler82968_g59939;
				uniform float _EmissionIntensity;
				uniform half4 _Color;
				uniform sampler2D _MainTex;
				sampler2D _Sampler82966_g59939;
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				sampler2D _Sampler82967_g59939;
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				sampler2D _Sampler82964_g59939;
				uniform sampler2D _BumpMap;
				sampler2D _Sampler82965_g59939;
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
					o.ase_texcoord2.xyz = ase_tangentWS;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					o.ase_texcoord3.xyz = ase_normalWS;
					float ase_tangentSign = v.ase_tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					o.ase_texcoord4.xyz = ase_bitangentWS;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					o.ase_texcoord5.xyz = ase_positionWS;
					
					o.ase_texcoord = v.ase_texcoord;
					o.ase_texcoord1.xy = v.ase_texcoord2.xy;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord1.zw = 0;
					o.ase_texcoord2.w = 0;
					o.ase_texcoord3.w = 0;
					o.ase_texcoord4.w = 0;
					o.ase_texcoord5.w = 0;

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

					float2 texCoord2357_g59939 = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0A2420_g59939 = texCoord2357_g59939;
					float2 texCoord2594_g59939 = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV22595_g59939 = texCoord2594_g59939;
					#if defined( _EMISSIONUV_UV0 )
					float2 staticSwitch2642_g59939 = UV0A2420_g59939;
					#elif defined( _EMISSIONUV_UV2 )
					float2 staticSwitch2642_g59939 = UV22595_g59939;
					#else
					float2 staticSwitch2642_g59939 = UV0A2420_g59939;
					#endif
					float2 temp_output_5_0_g59964 = staticSwitch2642_g59939;
					float2 UV633_g59964 = temp_output_5_0_g59964;
					float2 UV100_g59965 = UV633_g59964;
					float2 temp_output_51_0_g59965 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59965 * float2( 3.464,3.464 ) ) );
					float2 break55_g59965 = frac( temp_output_51_0_g59965 );
					float temp_output_56_0_g59965 = ( ( 1.0 - break55_g59965.x ) - break55_g59965.y );
					float2 temp_output_52_0_g59965 = floor( temp_output_51_0_g59965 );
					float2 temp_output_125_0_g59965 = ( temp_output_52_0_g59965 + float2( 1,1 ) );
					float2 ifLocalVar87_g59965 = 0;
					if( temp_output_56_0_g59965 > 0.0 )
					ifLocalVar87_g59965 = temp_output_52_0_g59965;
					else if( temp_output_56_0_g59965 == 0.0 )
					ifLocalVar87_g59965 = temp_output_125_0_g59965;
					else if( temp_output_56_0_g59965 < 0.0 )
					ifLocalVar87_g59965 = temp_output_125_0_g59965;
					float3 temp_output_7_0_g59966 = frac( ( (ifLocalVar87_g59965).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59966 = dot( temp_output_7_0_g59966 , ( (temp_output_7_0_g59966).yzx + 33.33 ) );
					float3 temp_output_12_0_g59966 = ( temp_output_7_0_g59966 + dotResult8_g59966 );
					float2 temp_output_597_0_g59964 = ( UV100_g59965 + frac( ( ( (temp_output_12_0_g59966).xx + (temp_output_12_0_g59966).yz ) * (temp_output_12_0_g59966).zy ) ) );
					float2 DDX631_g59964 = ddx( temp_output_5_0_g59964 );
					float2 DDY632_g59964 = ddy( temp_output_5_0_g59964 );
					float temp_output_65_0_g59965 = ( 0.0 - temp_output_56_0_g59965 );
					float ifLocalVar59_g59965 = 0;
					if( temp_output_56_0_g59965 <= 0.0 )
					ifLocalVar59_g59965 = temp_output_65_0_g59965;
					else
					ifLocalVar59_g59965 = temp_output_56_0_g59965;
					float temp_output_597_30_g59964 = ifLocalVar59_g59965;
					float2 temp_output_90_0_g59965 = ( temp_output_52_0_g59965 + float2( 0,1 ) );
					float2 temp_output_123_0_g59965 = ( temp_output_52_0_g59965 + float2( 1,0 ) );
					float2 ifLocalVar88_g59965 = 0;
					if( temp_output_56_0_g59965 > 0.0 )
					ifLocalVar88_g59965 = temp_output_90_0_g59965;
					else if( temp_output_56_0_g59965 == 0.0 )
					ifLocalVar88_g59965 = temp_output_123_0_g59965;
					else if( temp_output_56_0_g59965 < 0.0 )
					ifLocalVar88_g59965 = temp_output_123_0_g59965;
					float3 temp_output_7_0_g59967 = frac( ( (ifLocalVar88_g59965).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59967 = dot( temp_output_7_0_g59967 , ( (temp_output_7_0_g59967).yzx + 33.33 ) );
					float3 temp_output_12_0_g59967 = ( temp_output_7_0_g59967 + dotResult8_g59967 );
					float2 temp_output_597_26_g59964 = ( UV100_g59965 + frac( ( ( (temp_output_12_0_g59967).xx + (temp_output_12_0_g59967).yz ) * (temp_output_12_0_g59967).zy ) ) );
					float temp_output_66_0_g59965 = ( 1.0 - break55_g59965.y );
					float ifLocalVar60_g59965 = 0;
					if( temp_output_56_0_g59965 <= 0.0 )
					ifLocalVar60_g59965 = temp_output_66_0_g59965;
					else
					ifLocalVar60_g59965 = break55_g59965.y;
					float temp_output_597_28_g59964 = ifLocalVar60_g59965;
					float2 ifLocalVar89_g59965 = 0;
					if( temp_output_56_0_g59965 > 0.0 )
					ifLocalVar89_g59965 = temp_output_123_0_g59965;
					else if( temp_output_56_0_g59965 == 0.0 )
					ifLocalVar89_g59965 = temp_output_90_0_g59965;
					else if( temp_output_56_0_g59965 < 0.0 )
					ifLocalVar89_g59965 = temp_output_90_0_g59965;
					float3 temp_output_7_0_g59968 = frac( ( (ifLocalVar89_g59965).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59968 = dot( temp_output_7_0_g59968 , ( (temp_output_7_0_g59968).yzx + 33.33 ) );
					float3 temp_output_12_0_g59968 = ( temp_output_7_0_g59968 + dotResult8_g59968 );
					float2 temp_output_597_27_g59964 = ( UV100_g59965 + frac( ( ( (temp_output_12_0_g59968).xx + (temp_output_12_0_g59968).yz ) * (temp_output_12_0_g59968).zy ) ) );
					float temp_output_67_0_g59965 = ( 1.0 - break55_g59965.x );
					float ifLocalVar61_g59965 = 0;
					if( temp_output_56_0_g59965 <= 0.0 )
					ifLocalVar61_g59965 = temp_output_67_0_g59965;
					else
					ifLocalVar61_g59965 = break55_g59965.x;
					float temp_output_597_29_g59964 = ifLocalVar61_g59965;
					float4 Output_2D293_g59964 = ( ( tex2D( _Sampler82968_g59939, temp_output_597_0_g59964, DDX631_g59964, DDY632_g59964 ) * temp_output_597_30_g59964 ) + ( tex2D( _Sampler82968_g59939, temp_output_597_26_g59964, DDX631_g59964, DDY632_g59964 ) * temp_output_597_28_g59964 ) + ( tex2D( _Sampler82968_g59939, temp_output_597_27_g59964, DDX631_g59964, DDY632_g59964 ) * temp_output_597_29_g59964 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g59939 = Output_2D293_g59964;
					#else
					float4 staticSwitch1006_g59939 = tex2D( _EmissionMap, staticSwitch2642_g59939 );
					#endif
					float3 temp_output_2531_0_g59939 = (( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g59939 * _EmissionIntensity )).rgb;
					float3 Emission86_g59939 = temp_output_2531_0_g59939;
					float Black1185_g59939 = 0.0;
					float3 temp_cast_1 = (Black1185_g59939).xxx;
					#ifdef _MAINTEX
					float4 staticSwitch1549_g59939 = tex2D( _MainTex, UV22595_g59939 );
					#else
					float4 staticSwitch1549_g59939 = _Color;
					#endif
					float2 temp_output_5_0_g59954 = UV22595_g59939;
					float2 UV633_g59954 = temp_output_5_0_g59954;
					float2 UV100_g59955 = UV633_g59954;
					float2 temp_output_51_0_g59955 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59955 * float2( 3.464,3.464 ) ) );
					float2 break55_g59955 = frac( temp_output_51_0_g59955 );
					float temp_output_56_0_g59955 = ( ( 1.0 - break55_g59955.x ) - break55_g59955.y );
					float2 temp_output_52_0_g59955 = floor( temp_output_51_0_g59955 );
					float2 temp_output_125_0_g59955 = ( temp_output_52_0_g59955 + float2( 1,1 ) );
					float2 ifLocalVar87_g59955 = 0;
					if( temp_output_56_0_g59955 > 0.0 )
					ifLocalVar87_g59955 = temp_output_52_0_g59955;
					else if( temp_output_56_0_g59955 == 0.0 )
					ifLocalVar87_g59955 = temp_output_125_0_g59955;
					else if( temp_output_56_0_g59955 < 0.0 )
					ifLocalVar87_g59955 = temp_output_125_0_g59955;
					float3 temp_output_7_0_g59956 = frac( ( (ifLocalVar87_g59955).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59956 = dot( temp_output_7_0_g59956 , ( (temp_output_7_0_g59956).yzx + 33.33 ) );
					float3 temp_output_12_0_g59956 = ( temp_output_7_0_g59956 + dotResult8_g59956 );
					float2 temp_output_597_0_g59954 = ( UV100_g59955 + frac( ( ( (temp_output_12_0_g59956).xx + (temp_output_12_0_g59956).yz ) * (temp_output_12_0_g59956).zy ) ) );
					float2 DDX631_g59954 = ddx( temp_output_5_0_g59954 );
					float2 DDY632_g59954 = ddy( temp_output_5_0_g59954 );
					float temp_output_65_0_g59955 = ( 0.0 - temp_output_56_0_g59955 );
					float ifLocalVar59_g59955 = 0;
					if( temp_output_56_0_g59955 <= 0.0 )
					ifLocalVar59_g59955 = temp_output_65_0_g59955;
					else
					ifLocalVar59_g59955 = temp_output_56_0_g59955;
					float temp_output_597_30_g59954 = ifLocalVar59_g59955;
					float2 temp_output_90_0_g59955 = ( temp_output_52_0_g59955 + float2( 0,1 ) );
					float2 temp_output_123_0_g59955 = ( temp_output_52_0_g59955 + float2( 1,0 ) );
					float2 ifLocalVar88_g59955 = 0;
					if( temp_output_56_0_g59955 > 0.0 )
					ifLocalVar88_g59955 = temp_output_90_0_g59955;
					else if( temp_output_56_0_g59955 == 0.0 )
					ifLocalVar88_g59955 = temp_output_123_0_g59955;
					else if( temp_output_56_0_g59955 < 0.0 )
					ifLocalVar88_g59955 = temp_output_123_0_g59955;
					float3 temp_output_7_0_g59957 = frac( ( (ifLocalVar88_g59955).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59957 = dot( temp_output_7_0_g59957 , ( (temp_output_7_0_g59957).yzx + 33.33 ) );
					float3 temp_output_12_0_g59957 = ( temp_output_7_0_g59957 + dotResult8_g59957 );
					float2 temp_output_597_26_g59954 = ( UV100_g59955 + frac( ( ( (temp_output_12_0_g59957).xx + (temp_output_12_0_g59957).yz ) * (temp_output_12_0_g59957).zy ) ) );
					float temp_output_66_0_g59955 = ( 1.0 - break55_g59955.y );
					float ifLocalVar60_g59955 = 0;
					if( temp_output_56_0_g59955 <= 0.0 )
					ifLocalVar60_g59955 = temp_output_66_0_g59955;
					else
					ifLocalVar60_g59955 = break55_g59955.y;
					float temp_output_597_28_g59954 = ifLocalVar60_g59955;
					float2 ifLocalVar89_g59955 = 0;
					if( temp_output_56_0_g59955 > 0.0 )
					ifLocalVar89_g59955 = temp_output_123_0_g59955;
					else if( temp_output_56_0_g59955 == 0.0 )
					ifLocalVar89_g59955 = temp_output_90_0_g59955;
					else if( temp_output_56_0_g59955 < 0.0 )
					ifLocalVar89_g59955 = temp_output_90_0_g59955;
					float3 temp_output_7_0_g59958 = frac( ( (ifLocalVar89_g59955).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59958 = dot( temp_output_7_0_g59958 , ( (temp_output_7_0_g59958).yzx + 33.33 ) );
					float3 temp_output_12_0_g59958 = ( temp_output_7_0_g59958 + dotResult8_g59958 );
					float2 temp_output_597_27_g59954 = ( UV100_g59955 + frac( ( ( (temp_output_12_0_g59958).xx + (temp_output_12_0_g59958).yz ) * (temp_output_12_0_g59958).zy ) ) );
					float temp_output_67_0_g59955 = ( 1.0 - break55_g59955.x );
					float ifLocalVar61_g59955 = 0;
					if( temp_output_56_0_g59955 <= 0.0 )
					ifLocalVar61_g59955 = temp_output_67_0_g59955;
					else
					ifLocalVar61_g59955 = break55_g59955.x;
					float temp_output_597_29_g59954 = ifLocalVar61_g59955;
					float4 Output_2D293_g59954 = ( ( tex2D( _Sampler82966_g59939, temp_output_597_0_g59954, DDX631_g59954, DDY632_g59954 ) * temp_output_597_30_g59954 ) + ( tex2D( _Sampler82966_g59939, temp_output_597_26_g59954, DDX631_g59954, DDY632_g59954 ) * temp_output_597_28_g59954 ) + ( tex2D( _Sampler82966_g59939, temp_output_597_27_g59954, DDX631_g59954, DDY632_g59954 ) * temp_output_597_29_g59954 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g59939 = Output_2D293_g59954;
					#else
					float4 staticSwitch1001_g59939 = staticSwitch1549_g59939;
					#endif
					float3 temp_output_2532_0_g59939 = (staticSwitch1001_g59939).rgb;
					float3 oAlbedo6_g59939 = temp_output_2532_0_g59939;
					float3 Color1_g59991 = oAlbedo6_g59939;
					#if defined( _UV_UV0 )
					float2 staticSwitch2671_g59939 = UV0A2420_g59939;
					#elif defined( _UV_UV2 )
					float2 staticSwitch2671_g59939 = UV22595_g59939;
					#else
					float2 staticSwitch2671_g59939 = UV22595_g59939;
					#endif
					#ifdef _METALLICMAP
					float staticSwitch846_g59939 = tex2D( _MetallicMap, staticSwitch2671_g59939 ).r;
					#else
					float staticSwitch846_g59939 = _Metallic;
					#endif
					float2 temp_output_5_0_g59974 = staticSwitch2671_g59939;
					float2 UV633_g59974 = temp_output_5_0_g59974;
					float2 UV100_g59975 = UV633_g59974;
					float2 temp_output_51_0_g59975 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59975 * float2( 3.464,3.464 ) ) );
					float2 break55_g59975 = frac( temp_output_51_0_g59975 );
					float temp_output_56_0_g59975 = ( ( 1.0 - break55_g59975.x ) - break55_g59975.y );
					float2 temp_output_52_0_g59975 = floor( temp_output_51_0_g59975 );
					float2 temp_output_125_0_g59975 = ( temp_output_52_0_g59975 + float2( 1,1 ) );
					float2 ifLocalVar87_g59975 = 0;
					if( temp_output_56_0_g59975 > 0.0 )
					ifLocalVar87_g59975 = temp_output_52_0_g59975;
					else if( temp_output_56_0_g59975 == 0.0 )
					ifLocalVar87_g59975 = temp_output_125_0_g59975;
					else if( temp_output_56_0_g59975 < 0.0 )
					ifLocalVar87_g59975 = temp_output_125_0_g59975;
					float3 temp_output_7_0_g59976 = frac( ( (ifLocalVar87_g59975).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59976 = dot( temp_output_7_0_g59976 , ( (temp_output_7_0_g59976).yzx + 33.33 ) );
					float3 temp_output_12_0_g59976 = ( temp_output_7_0_g59976 + dotResult8_g59976 );
					float2 temp_output_597_0_g59974 = ( UV100_g59975 + frac( ( ( (temp_output_12_0_g59976).xx + (temp_output_12_0_g59976).yz ) * (temp_output_12_0_g59976).zy ) ) );
					float2 DDX631_g59974 = ddx( temp_output_5_0_g59974 );
					float2 DDY632_g59974 = ddy( temp_output_5_0_g59974 );
					float temp_output_65_0_g59975 = ( 0.0 - temp_output_56_0_g59975 );
					float ifLocalVar59_g59975 = 0;
					if( temp_output_56_0_g59975 <= 0.0 )
					ifLocalVar59_g59975 = temp_output_65_0_g59975;
					else
					ifLocalVar59_g59975 = temp_output_56_0_g59975;
					float temp_output_597_30_g59974 = ifLocalVar59_g59975;
					float2 temp_output_90_0_g59975 = ( temp_output_52_0_g59975 + float2( 0,1 ) );
					float2 temp_output_123_0_g59975 = ( temp_output_52_0_g59975 + float2( 1,0 ) );
					float2 ifLocalVar88_g59975 = 0;
					if( temp_output_56_0_g59975 > 0.0 )
					ifLocalVar88_g59975 = temp_output_90_0_g59975;
					else if( temp_output_56_0_g59975 == 0.0 )
					ifLocalVar88_g59975 = temp_output_123_0_g59975;
					else if( temp_output_56_0_g59975 < 0.0 )
					ifLocalVar88_g59975 = temp_output_123_0_g59975;
					float3 temp_output_7_0_g59977 = frac( ( (ifLocalVar88_g59975).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59977 = dot( temp_output_7_0_g59977 , ( (temp_output_7_0_g59977).yzx + 33.33 ) );
					float3 temp_output_12_0_g59977 = ( temp_output_7_0_g59977 + dotResult8_g59977 );
					float2 temp_output_597_26_g59974 = ( UV100_g59975 + frac( ( ( (temp_output_12_0_g59977).xx + (temp_output_12_0_g59977).yz ) * (temp_output_12_0_g59977).zy ) ) );
					float temp_output_66_0_g59975 = ( 1.0 - break55_g59975.y );
					float ifLocalVar60_g59975 = 0;
					if( temp_output_56_0_g59975 <= 0.0 )
					ifLocalVar60_g59975 = temp_output_66_0_g59975;
					else
					ifLocalVar60_g59975 = break55_g59975.y;
					float temp_output_597_28_g59974 = ifLocalVar60_g59975;
					float2 ifLocalVar89_g59975 = 0;
					if( temp_output_56_0_g59975 > 0.0 )
					ifLocalVar89_g59975 = temp_output_123_0_g59975;
					else if( temp_output_56_0_g59975 == 0.0 )
					ifLocalVar89_g59975 = temp_output_90_0_g59975;
					else if( temp_output_56_0_g59975 < 0.0 )
					ifLocalVar89_g59975 = temp_output_90_0_g59975;
					float3 temp_output_7_0_g59978 = frac( ( (ifLocalVar89_g59975).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59978 = dot( temp_output_7_0_g59978 , ( (temp_output_7_0_g59978).yzx + 33.33 ) );
					float3 temp_output_12_0_g59978 = ( temp_output_7_0_g59978 + dotResult8_g59978 );
					float2 temp_output_597_27_g59974 = ( UV100_g59975 + frac( ( ( (temp_output_12_0_g59978).xx + (temp_output_12_0_g59978).yz ) * (temp_output_12_0_g59978).zy ) ) );
					float temp_output_67_0_g59975 = ( 1.0 - break55_g59975.x );
					float ifLocalVar61_g59975 = 0;
					if( temp_output_56_0_g59975 <= 0.0 )
					ifLocalVar61_g59975 = temp_output_67_0_g59975;
					else
					ifLocalVar61_g59975 = break55_g59975.x;
					float temp_output_597_29_g59974 = ifLocalVar61_g59975;
					float4 Output_2D293_g59974 = ( ( tex2D( _Sampler82967_g59939, temp_output_597_0_g59974, DDX631_g59974, DDY632_g59974 ) * temp_output_597_30_g59974 ) + ( tex2D( _Sampler82967_g59939, temp_output_597_26_g59974, DDX631_g59974, DDY632_g59974 ) * temp_output_597_28_g59974 ) + ( tex2D( _Sampler82967_g59939, temp_output_597_27_g59974, DDX631_g59974, DDY632_g59974 ) * temp_output_597_29_g59974 ) );
					float4 break31_g59974 = Output_2D293_g59974;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g59939 = break31_g59974.r;
					#else
					float staticSwitch1005_g59939 = staticSwitch846_g59939;
					#endif
					float Metallic1239_g59939 = staticSwitch1005_g59939;
					float Metallic1_g59991 = Metallic1239_g59939;
					#if defined( _UV_UV0 )
					float2 staticSwitch2644_g59939 = UV0A2420_g59939;
					#elif defined( _UV_UV2 )
					float2 staticSwitch2644_g59939 = UV22595_g59939;
					#else
					float2 staticSwitch2644_g59939 = UV22595_g59939;
					#endif
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g59939 = tex2D( _GlossinessMap, staticSwitch2644_g59939 ).r;
					#else
					float staticSwitch845_g59939 = _Glossiness;
					#endif
					float2 temp_output_5_0_g59959 = staticSwitch2644_g59939;
					float2 UV633_g59959 = temp_output_5_0_g59959;
					float2 UV100_g59960 = UV633_g59959;
					float2 temp_output_51_0_g59960 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59960 * float2( 3.464,3.464 ) ) );
					float2 break55_g59960 = frac( temp_output_51_0_g59960 );
					float temp_output_56_0_g59960 = ( ( 1.0 - break55_g59960.x ) - break55_g59960.y );
					float2 temp_output_52_0_g59960 = floor( temp_output_51_0_g59960 );
					float2 temp_output_125_0_g59960 = ( temp_output_52_0_g59960 + float2( 1,1 ) );
					float2 ifLocalVar87_g59960 = 0;
					if( temp_output_56_0_g59960 > 0.0 )
					ifLocalVar87_g59960 = temp_output_52_0_g59960;
					else if( temp_output_56_0_g59960 == 0.0 )
					ifLocalVar87_g59960 = temp_output_125_0_g59960;
					else if( temp_output_56_0_g59960 < 0.0 )
					ifLocalVar87_g59960 = temp_output_125_0_g59960;
					float3 temp_output_7_0_g59961 = frac( ( (ifLocalVar87_g59960).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59961 = dot( temp_output_7_0_g59961 , ( (temp_output_7_0_g59961).yzx + 33.33 ) );
					float3 temp_output_12_0_g59961 = ( temp_output_7_0_g59961 + dotResult8_g59961 );
					float2 temp_output_597_0_g59959 = ( UV100_g59960 + frac( ( ( (temp_output_12_0_g59961).xx + (temp_output_12_0_g59961).yz ) * (temp_output_12_0_g59961).zy ) ) );
					float2 DDX631_g59959 = ddx( temp_output_5_0_g59959 );
					float2 DDY632_g59959 = ddy( temp_output_5_0_g59959 );
					float temp_output_65_0_g59960 = ( 0.0 - temp_output_56_0_g59960 );
					float ifLocalVar59_g59960 = 0;
					if( temp_output_56_0_g59960 <= 0.0 )
					ifLocalVar59_g59960 = temp_output_65_0_g59960;
					else
					ifLocalVar59_g59960 = temp_output_56_0_g59960;
					float temp_output_597_30_g59959 = ifLocalVar59_g59960;
					float2 temp_output_90_0_g59960 = ( temp_output_52_0_g59960 + float2( 0,1 ) );
					float2 temp_output_123_0_g59960 = ( temp_output_52_0_g59960 + float2( 1,0 ) );
					float2 ifLocalVar88_g59960 = 0;
					if( temp_output_56_0_g59960 > 0.0 )
					ifLocalVar88_g59960 = temp_output_90_0_g59960;
					else if( temp_output_56_0_g59960 == 0.0 )
					ifLocalVar88_g59960 = temp_output_123_0_g59960;
					else if( temp_output_56_0_g59960 < 0.0 )
					ifLocalVar88_g59960 = temp_output_123_0_g59960;
					float3 temp_output_7_0_g59962 = frac( ( (ifLocalVar88_g59960).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59962 = dot( temp_output_7_0_g59962 , ( (temp_output_7_0_g59962).yzx + 33.33 ) );
					float3 temp_output_12_0_g59962 = ( temp_output_7_0_g59962 + dotResult8_g59962 );
					float2 temp_output_597_26_g59959 = ( UV100_g59960 + frac( ( ( (temp_output_12_0_g59962).xx + (temp_output_12_0_g59962).yz ) * (temp_output_12_0_g59962).zy ) ) );
					float temp_output_66_0_g59960 = ( 1.0 - break55_g59960.y );
					float ifLocalVar60_g59960 = 0;
					if( temp_output_56_0_g59960 <= 0.0 )
					ifLocalVar60_g59960 = temp_output_66_0_g59960;
					else
					ifLocalVar60_g59960 = break55_g59960.y;
					float temp_output_597_28_g59959 = ifLocalVar60_g59960;
					float2 ifLocalVar89_g59960 = 0;
					if( temp_output_56_0_g59960 > 0.0 )
					ifLocalVar89_g59960 = temp_output_123_0_g59960;
					else if( temp_output_56_0_g59960 == 0.0 )
					ifLocalVar89_g59960 = temp_output_90_0_g59960;
					else if( temp_output_56_0_g59960 < 0.0 )
					ifLocalVar89_g59960 = temp_output_90_0_g59960;
					float3 temp_output_7_0_g59963 = frac( ( (ifLocalVar89_g59960).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59963 = dot( temp_output_7_0_g59963 , ( (temp_output_7_0_g59963).yzx + 33.33 ) );
					float3 temp_output_12_0_g59963 = ( temp_output_7_0_g59963 + dotResult8_g59963 );
					float2 temp_output_597_27_g59959 = ( UV100_g59960 + frac( ( ( (temp_output_12_0_g59963).xx + (temp_output_12_0_g59963).yz ) * (temp_output_12_0_g59963).zy ) ) );
					float temp_output_67_0_g59960 = ( 1.0 - break55_g59960.x );
					float ifLocalVar61_g59960 = 0;
					if( temp_output_56_0_g59960 <= 0.0 )
					ifLocalVar61_g59960 = temp_output_67_0_g59960;
					else
					ifLocalVar61_g59960 = break55_g59960.x;
					float temp_output_597_29_g59959 = ifLocalVar61_g59960;
					float4 Output_2D293_g59959 = ( ( tex2D( _Sampler82964_g59939, temp_output_597_0_g59959, DDX631_g59959, DDY632_g59959 ) * temp_output_597_30_g59959 ) + ( tex2D( _Sampler82964_g59939, temp_output_597_26_g59959, DDX631_g59959, DDY632_g59959 ) * temp_output_597_28_g59959 ) + ( tex2D( _Sampler82964_g59939, temp_output_597_27_g59959, DDX631_g59959, DDY632_g59959 ) * temp_output_597_29_g59959 ) );
					float4 break31_g59959 = Output_2D293_g59959;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g59939 = ( 1.0 - break31_g59959.r );
					#else
					float staticSwitch1004_g59939 = ( 1.0 - staticSwitch845_g59939 );
					#endif
					float temp_output_19_0_g59981 = staticSwitch1004_g59939;
					float2 temp_output_5_0_g59949 = UV0A2420_g59939;
					float2 UV633_g59949 = temp_output_5_0_g59949;
					float2 UV100_g59950 = UV633_g59949;
					float2 temp_output_51_0_g59950 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59950 * float2( 3.464,3.464 ) ) );
					float2 break55_g59950 = frac( temp_output_51_0_g59950 );
					float temp_output_56_0_g59950 = ( ( 1.0 - break55_g59950.x ) - break55_g59950.y );
					float2 temp_output_52_0_g59950 = floor( temp_output_51_0_g59950 );
					float2 temp_output_125_0_g59950 = ( temp_output_52_0_g59950 + float2( 1,1 ) );
					float2 ifLocalVar87_g59950 = 0;
					if( temp_output_56_0_g59950 > 0.0 )
					ifLocalVar87_g59950 = temp_output_52_0_g59950;
					else if( temp_output_56_0_g59950 == 0.0 )
					ifLocalVar87_g59950 = temp_output_125_0_g59950;
					else if( temp_output_56_0_g59950 < 0.0 )
					ifLocalVar87_g59950 = temp_output_125_0_g59950;
					float3 temp_output_7_0_g59951 = frac( ( (ifLocalVar87_g59950).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59951 = dot( temp_output_7_0_g59951 , ( (temp_output_7_0_g59951).yzx + 33.33 ) );
					float3 temp_output_12_0_g59951 = ( temp_output_7_0_g59951 + dotResult8_g59951 );
					float2 temp_output_597_0_g59949 = ( UV100_g59950 + frac( ( ( (temp_output_12_0_g59951).xx + (temp_output_12_0_g59951).yz ) * (temp_output_12_0_g59951).zy ) ) );
					float2 DDX631_g59949 = ddx( temp_output_5_0_g59949 );
					float2 DDY632_g59949 = ddy( temp_output_5_0_g59949 );
					float Input_Scale617_g59949 = 1.5;
					float temp_output_65_0_g59950 = ( 0.0 - temp_output_56_0_g59950 );
					float ifLocalVar59_g59950 = 0;
					if( temp_output_56_0_g59950 <= 0.0 )
					ifLocalVar59_g59950 = temp_output_65_0_g59950;
					else
					ifLocalVar59_g59950 = temp_output_56_0_g59950;
					float temp_output_597_30_g59949 = ifLocalVar59_g59950;
					float2 temp_output_90_0_g59950 = ( temp_output_52_0_g59950 + float2( 0,1 ) );
					float2 temp_output_123_0_g59950 = ( temp_output_52_0_g59950 + float2( 1,0 ) );
					float2 ifLocalVar88_g59950 = 0;
					if( temp_output_56_0_g59950 > 0.0 )
					ifLocalVar88_g59950 = temp_output_90_0_g59950;
					else if( temp_output_56_0_g59950 == 0.0 )
					ifLocalVar88_g59950 = temp_output_123_0_g59950;
					else if( temp_output_56_0_g59950 < 0.0 )
					ifLocalVar88_g59950 = temp_output_123_0_g59950;
					float3 temp_output_7_0_g59952 = frac( ( (ifLocalVar88_g59950).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59952 = dot( temp_output_7_0_g59952 , ( (temp_output_7_0_g59952).yzx + 33.33 ) );
					float3 temp_output_12_0_g59952 = ( temp_output_7_0_g59952 + dotResult8_g59952 );
					float2 temp_output_597_26_g59949 = ( UV100_g59950 + frac( ( ( (temp_output_12_0_g59952).xx + (temp_output_12_0_g59952).yz ) * (temp_output_12_0_g59952).zy ) ) );
					float temp_output_66_0_g59950 = ( 1.0 - break55_g59950.y );
					float ifLocalVar60_g59950 = 0;
					if( temp_output_56_0_g59950 <= 0.0 )
					ifLocalVar60_g59950 = temp_output_66_0_g59950;
					else
					ifLocalVar60_g59950 = break55_g59950.y;
					float temp_output_597_28_g59949 = ifLocalVar60_g59950;
					float2 ifLocalVar89_g59950 = 0;
					if( temp_output_56_0_g59950 > 0.0 )
					ifLocalVar89_g59950 = temp_output_123_0_g59950;
					else if( temp_output_56_0_g59950 == 0.0 )
					ifLocalVar89_g59950 = temp_output_90_0_g59950;
					else if( temp_output_56_0_g59950 < 0.0 )
					ifLocalVar89_g59950 = temp_output_90_0_g59950;
					float3 temp_output_7_0_g59953 = frac( ( (ifLocalVar89_g59950).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g59953 = dot( temp_output_7_0_g59953 , ( (temp_output_7_0_g59953).yzx + 33.33 ) );
					float3 temp_output_12_0_g59953 = ( temp_output_7_0_g59953 + dotResult8_g59953 );
					float2 temp_output_597_27_g59949 = ( UV100_g59950 + frac( ( ( (temp_output_12_0_g59953).xx + (temp_output_12_0_g59953).yz ) * (temp_output_12_0_g59953).zy ) ) );
					float temp_output_67_0_g59950 = ( 1.0 - break55_g59950.x );
					float ifLocalVar61_g59950 = 0;
					if( temp_output_56_0_g59950 <= 0.0 )
					ifLocalVar61_g59950 = temp_output_67_0_g59950;
					else
					ifLocalVar61_g59950 = break55_g59950.x;
					float temp_output_597_29_g59949 = ifLocalVar61_g59950;
					float3 Output_2D_Normal641_g59949 = ( ( UnpackScaleNormal( tex2D( _Sampler82965_g59939, temp_output_597_0_g59949, DDX631_g59949, DDY632_g59949 ), Input_Scale617_g59949 ) * temp_output_597_30_g59949 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g59939, temp_output_597_26_g59949, DDX631_g59949, DDY632_g59949 ), Input_Scale617_g59949 ) * temp_output_597_28_g59949 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g59939, temp_output_597_27_g59949, DDX631_g59949, DDY632_g59949 ), Input_Scale617_g59949 ) * float3( 0,0,0 ) * temp_output_597_29_g59949 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g59939 = Output_2D_Normal641_g59949;
					#else
					float3 staticSwitch1003_g59939 = UnpackScaleNormal( tex2D( _BumpMap, UV0A2420_g59939 ), 1.5 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g59939 = staticSwitch1003_g59939;
					#else
					float3 staticSwitch980_g59939 = float3( 0, 0, 1 );
					#endif
					float3 normalizeResult2878_g59939 = normalize( staticSwitch980_g59939 );
					float3 Normal_Map700_g59939 = normalizeResult2878_g59939;
					float3 ase_tangentWS = IN.ase_texcoord2.xyz;
					float3 ase_normalWS = IN.ase_texcoord3.xyz;
					float3 ase_bitangentWS = IN.ase_texcoord4.xyz;
					float3 tanToWorld0 = float3( ase_tangentWS.x, ase_bitangentWS.x, ase_normalWS.x );
					float3 tanToWorld1 = float3( ase_tangentWS.y, ase_bitangentWS.y, ase_normalWS.y );
					float3 tanToWorld2 = float3( ase_tangentWS.z, ase_bitangentWS.z, ase_normalWS.z );
					float3 tanNormal2504_g59939 = Normal_Map700_g59939;
					float3 worldNormal2504_g59939 = normalize( float3( dot( tanToWorld0, tanNormal2504_g59939 ), dot( tanToWorld1, tanNormal2504_g59939 ), dot( tanToWorld2, tanNormal2504_g59939 ) ) );
					float3 World_Normal2508_g59939 = worldNormal2504_g59939;
					float3 tanNormal2_g59981 = World_Normal2508_g59939;
					float3 worldNormal2_g59981 = float3( dot( tanToWorld0, tanNormal2_g59981 ), dot( tanToWorld1, tanNormal2_g59981 ), dot( tanToWorld2, tanNormal2_g59981 ) );
					float3 temp_output_3_0_g59981 = ddx( worldNormal2_g59981 );
					float dotResult5_g59981 = dot( temp_output_3_0_g59981 , temp_output_3_0_g59981 );
					float3 temp_output_4_0_g59981 = ddy( worldNormal2_g59981 );
					float dotResult6_g59981 = dot( temp_output_4_0_g59981 , temp_output_4_0_g59981 );
					#ifdef _USEGEOMETRICAA_ON
					float staticSwitch15_g59981 = min( temp_output_19_0_g59981, ( 1.0 - pow( saturate( max( dotResult5_g59981, dotResult6_g59981 ) ) , 0.25 ) ) );
					#else
					float staticSwitch15_g59981 = temp_output_19_0_g59981;
					#endif
					float Smoothness1399_g59939 = staticSwitch15_g59981;
					float Smoothness1_g59991 = Smoothness1399_g59939;
					float3 ase_positionWS = IN.ase_texcoord5.xyz;
					float3 ase_viewVectorWS = ( ( unity_OrthoParams.w == 0 ) ? _WorldSpaceCameraPos - ase_positionWS : UNITY_MATRIX_V[ 2 ].xyz );
					float3 ase_viewDirWS = normalize( ase_viewVectorWS );
					float3 View_Direction2511_g59939 = ase_viewDirWS;
					float3 ViewDir1_g59991 = View_Direction2511_g59939;
					float3 World_Position2505_g59939 = ase_positionWS;
					float3 WorldPos1_g59991 = World_Position2505_g59939;
					float3 WorldNormal1_g59991 = World_Normal2508_g59939;
					float4 temp_cast_2 = (Black1185_g59939).xxxx;
					float4 texCoord2426_g59939 = IN.ase_texcoord;
					texCoord2426_g59939.xy = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0B2361_g59939 = (texCoord2426_g59939).zw;
					float localBicubicPrepare2_g59948 = ( 0.0 );
					float2 Input_UV100_g59948 = UV0B2361_g59939;
					float2 UV2_g59948 = Input_UV100_g59948;
					float4 TexelSize2_g59948 = _Lightmap0_TexelSize;
					float2 UV02_g59948 = float2( 0,0 );
					float2 UV12_g59948 = float2( 0,0 );
					float2 UV22_g59948 = float2( 0,0 );
					float2 UV32_g59948 = float2( 0,0 );
					float W02_g59948 = 0;
					float W12_g59948 = 0;
					{
					{
					 UV2_g59948 = UV2_g59948 * TexelSize2_g59948.zw - 0.5;
					    float2 f = frac( UV2_g59948 );
					    UV2_g59948 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59948.x - 0.5, UV2_g59948.x + 1.5, UV2_g59948.y - 0.5, UV2_g59948.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59948.xyxy;
					    UV02_g59948 = off.xz;
					    UV12_g59948 = off.yz;
					    UV22_g59948 = off.xw;
					    UV32_g59948 = off.yw;
					    W02_g59948 = s.x / ( s.x + s.y );
					 W12_g59948 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59948 = lerp( tex2D( _Lightmap0, UV32_g59948 ) , tex2D( _Lightmap0, UV22_g59948 ) , W02_g59948);
					float4 lerpResult45_g59948 = lerp( tex2D( _Lightmap0, UV12_g59948 ) , tex2D( _Lightmap0, UV02_g59948 ) , W02_g59948);
					float4 lerpResult44_g59948 = lerp( lerpResult46_g59948 , lerpResult45_g59948 , W12_g59948);
					float4 Output_2D_Auto131_g59948 = lerpResult44_g59948;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g59939 = Output_2D_Auto131_g59948;
					#else
					float4 staticSwitch1092_g59939 = float4( tex2D( _Lightmap0, UV0B2361_g59939 ).rgb , 0.0 );
					#endif
					float4 Lightmap_0925_g59939 = staticSwitch1092_g59939;
					float localBicubicPrepare2_g59946 = ( 0.0 );
					float2 Input_UV100_g59946 = UV0B2361_g59939;
					float2 UV2_g59946 = Input_UV100_g59946;
					float4 TexelSize2_g59946 = _Lightmap1_TexelSize;
					float2 UV02_g59946 = float2( 0,0 );
					float2 UV12_g59946 = float2( 0,0 );
					float2 UV22_g59946 = float2( 0,0 );
					float2 UV32_g59946 = float2( 0,0 );
					float W02_g59946 = 0;
					float W12_g59946 = 0;
					{
					{
					 UV2_g59946 = UV2_g59946 * TexelSize2_g59946.zw - 0.5;
					    float2 f = frac( UV2_g59946 );
					    UV2_g59946 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59946.x - 0.5, UV2_g59946.x + 1.5, UV2_g59946.y - 0.5, UV2_g59946.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59946.xyxy;
					    UV02_g59946 = off.xz;
					    UV12_g59946 = off.yz;
					    UV22_g59946 = off.xw;
					    UV32_g59946 = off.yw;
					    W02_g59946 = s.x / ( s.x + s.y );
					 W12_g59946 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59946 = lerp( tex2D( _Lightmap1, UV32_g59946 ) , tex2D( _Lightmap1, UV22_g59946 ) , W02_g59946);
					float4 lerpResult45_g59946 = lerp( tex2D( _Lightmap1, UV12_g59946 ) , tex2D( _Lightmap1, UV02_g59946 ) , W02_g59946);
					float4 lerpResult44_g59946 = lerp( lerpResult46_g59946 , lerpResult45_g59946 , W12_g59946);
					float4 Output_2D_Auto131_g59946 = lerpResult44_g59946;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g59939 = Output_2D_Auto131_g59946;
					#else
					float4 staticSwitch1088_g59939 = tex2D( _Lightmap1, UV0B2361_g59939 );
					#endif
					float4 Lightmap_1956_g59939 = staticSwitch1088_g59939;
					float Lightmap_Lerp_Value969_g59939 = _UdonLightmapLerp;
					float4 lerpResult442_g59939 = lerp( Lightmap_0925_g59939 , Lightmap_1956_g59939 , Lightmap_Lerp_Value969_g59939);
					float4 Lightmap_Lerp932_g59939 = lerpResult442_g59939;
					float3 appendResult139_g59987 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 Normal_Map318_g59987 = Normal_Map700_g59939;
					float dotResult121_g59987 = dot( appendResult139_g59987 , Normal_Map318_g59987 );
					float temp_output_2_0_g59989 = saturate( dotResult121_g59987 );
					float localStochasticTiling2_g59970 = ( 0.0 );
					float2 UV2_g59970 = UV0B2361_g59939;
					float4 TexelSize2_g59970 = _UdonRNMX0_TexelSize;
					float4 Offsets2_g59970 = float4( 0,0,0,0 );
					float2 Weights2_g59970 = float2( 0,0 );
					{
					UV2_g59970 = UV2_g59970 * TexelSize2_g59970.zw - 0.5;
					float2 f = frac( UV2_g59970 );
					UV2_g59970 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g59970.x - 0.5, UV2_g59970.x + 1.5, UV2_g59970.y - 0.5, UV2_g59970.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g59970 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59970.xyxy;
					Weights2_g59970 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g59969 = Offsets2_g59970;
					float4 Input_FetchOffsets197_g59971 = temp_output_1_34_g59969;
					float2 temp_output_1_54_g59969 = Weights2_g59970;
					float2 Input_FetchWeights200_g59971 = temp_output_1_54_g59969;
					float2 break187_g59971 = Input_FetchWeights200_g59971;
					float4 lerpResult181_g59971 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g59971).yw ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g59971).xw ) , break187_g59971.x);
					float4 lerpResult182_g59971 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g59971).yz ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g59971).xz ) , break187_g59971.x);
					float4 lerpResult176_g59971 = lerp( lerpResult181_g59971 , lerpResult182_g59971 , break187_g59971.y);
					float4 Output_Fetch2D_Auto202_g59971 = lerpResult176_g59971;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g59939 = Output_Fetch2D_Auto202_g59971;
					#else
					float4 staticSwitch1061_g59939 = tex2D( _UdonRNMX0, UV0B2361_g59939 );
					#endif
					float3 appendResult146_g59987 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59987 = dot( appendResult146_g59987 , Normal_Map318_g59987 );
					float temp_output_2_0_g59988 = saturate( dotResult122_g59987 );
					float4 Input_FetchOffsets197_g59972 = temp_output_1_34_g59969;
					float2 Input_FetchWeights200_g59972 = temp_output_1_54_g59969;
					float2 break187_g59972 = Input_FetchWeights200_g59972;
					float4 lerpResult181_g59972 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g59972).yw ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g59972).xw ) , break187_g59972.x);
					float4 lerpResult182_g59972 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g59972).yz ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g59972).xz ) , break187_g59972.x);
					float4 lerpResult176_g59972 = lerp( lerpResult181_g59972 , lerpResult182_g59972 , break187_g59972.y);
					float4 Output_Fetch2D_Auto202_g59972 = lerpResult176_g59972;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g59939 = Output_Fetch2D_Auto202_g59972;
					#else
					float4 staticSwitch1062_g59939 = tex2D( _UdonRNMY0, UV0B2361_g59939 );
					#endif
					float3 appendResult149_g59987 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59987 = dot( appendResult149_g59987 , Normal_Map318_g59987 );
					float temp_output_2_0_g59990 = saturate( dotResult120_g59987 );
					float4 Input_FetchOffsets197_g59973 = temp_output_1_34_g59969;
					float2 Input_FetchWeights200_g59973 = temp_output_1_54_g59969;
					float2 break187_g59973 = Input_FetchWeights200_g59973;
					float4 lerpResult181_g59973 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g59973).yw ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g59973).xw ) , break187_g59973.x);
					float4 lerpResult182_g59973 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g59973).yz ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g59973).xz ) , break187_g59973.x);
					float4 lerpResult176_g59973 = lerp( lerpResult181_g59973 , lerpResult182_g59973 , break187_g59973.y);
					float4 Output_Fetch2D_Auto202_g59973 = lerpResult176_g59973;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g59939 = Output_Fetch2D_Auto202_g59973;
					#else
					float4 staticSwitch1063_g59939 = tex2D( _UdonRNMZ0, UV0B2361_g59939 );
					#endif
					float4 RNM_0926_g59939 = ( ( ( ( ( temp_output_2_0_g59989 * temp_output_2_0_g59989 ) * staticSwitch1061_g59939 ) + ( ( temp_output_2_0_g59988 * temp_output_2_0_g59988 ) * staticSwitch1062_g59939 ) ) + ( ( temp_output_2_0_g59990 * temp_output_2_0_g59990 ) * staticSwitch1063_g59939 ) ) * 1.2 );
					float3 appendResult139_g59983 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 Normal_Map318_g59983 = Normal_Map700_g59939;
					float dotResult121_g59983 = dot( appendResult139_g59983 , Normal_Map318_g59983 );
					float temp_output_2_0_g59985 = saturate( dotResult121_g59983 );
					float localStochasticTiling2_g59941 = ( 0.0 );
					float2 UV2_g59941 = UV0B2361_g59939;
					float4 TexelSize2_g59941 = _UdonRNMX1_TexelSize;
					float4 Offsets2_g59941 = float4( 0,0,0,0 );
					float2 Weights2_g59941 = float2( 0,0 );
					{
					UV2_g59941 = UV2_g59941 * TexelSize2_g59941.zw - 0.5;
					float2 f = frac( UV2_g59941 );
					UV2_g59941 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g59941.x - 0.5, UV2_g59941.x + 1.5, UV2_g59941.y - 0.5, UV2_g59941.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g59941 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59941.xyxy;
					Weights2_g59941 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g59940 = Offsets2_g59941;
					float4 Input_FetchOffsets197_g59942 = temp_output_1_34_g59940;
					float2 temp_output_1_54_g59940 = Weights2_g59941;
					float2 Input_FetchWeights200_g59942 = temp_output_1_54_g59940;
					float2 break187_g59942 = Input_FetchWeights200_g59942;
					float4 lerpResult181_g59942 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g59942).yw ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g59942).xw ) , break187_g59942.x);
					float4 lerpResult182_g59942 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g59942).yz ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g59942).xz ) , break187_g59942.x);
					float4 lerpResult176_g59942 = lerp( lerpResult181_g59942 , lerpResult182_g59942 , break187_g59942.y);
					float4 Output_Fetch2D_Auto202_g59942 = lerpResult176_g59942;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g59939 = Output_Fetch2D_Auto202_g59942;
					#else
					float4 staticSwitch1087_g59939 = tex2D( _UdonRNMX1, UV0B2361_g59939 );
					#endif
					float3 appendResult146_g59983 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59983 = dot( appendResult146_g59983 , Normal_Map318_g59983 );
					float temp_output_2_0_g59984 = saturate( dotResult122_g59983 );
					float4 Input_FetchOffsets197_g59943 = temp_output_1_34_g59940;
					float2 Input_FetchWeights200_g59943 = temp_output_1_54_g59940;
					float2 break187_g59943 = Input_FetchWeights200_g59943;
					float4 lerpResult181_g59943 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g59943).yw ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g59943).xw ) , break187_g59943.x);
					float4 lerpResult182_g59943 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g59943).yz ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g59943).xz ) , break187_g59943.x);
					float4 lerpResult176_g59943 = lerp( lerpResult181_g59943 , lerpResult182_g59943 , break187_g59943.y);
					float4 Output_Fetch2D_Auto202_g59943 = lerpResult176_g59943;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g59939 = Output_Fetch2D_Auto202_g59943;
					#else
					float4 staticSwitch1083_g59939 = tex2D( _UdonRNMY1, UV0B2361_g59939 );
					#endif
					float3 appendResult149_g59983 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59983 = dot( appendResult149_g59983 , Normal_Map318_g59983 );
					float temp_output_2_0_g59986 = saturate( dotResult120_g59983 );
					float4 Input_FetchOffsets197_g59944 = temp_output_1_34_g59940;
					float2 Input_FetchWeights200_g59944 = temp_output_1_54_g59940;
					float2 break187_g59944 = Input_FetchWeights200_g59944;
					float4 lerpResult181_g59944 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g59944).yw ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g59944).xw ) , break187_g59944.x);
					float4 lerpResult182_g59944 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g59944).yz ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g59944).xz ) , break187_g59944.x);
					float4 lerpResult176_g59944 = lerp( lerpResult181_g59944 , lerpResult182_g59944 , break187_g59944.y);
					float4 Output_Fetch2D_Auto202_g59944 = lerpResult176_g59944;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g59939 = Output_Fetch2D_Auto202_g59944;
					#else
					float4 staticSwitch1084_g59939 = tex2D( _UdonRNMZ1, UV0B2361_g59939 );
					#endif
					float4 RNM_11081_g59939 = ( ( ( ( ( temp_output_2_0_g59985 * temp_output_2_0_g59985 ) * staticSwitch1087_g59939 ) + ( ( temp_output_2_0_g59984 * temp_output_2_0_g59984 ) * staticSwitch1083_g59939 ) ) + ( ( temp_output_2_0_g59986 * temp_output_2_0_g59986 ) * staticSwitch1084_g59939 ) ) * 1.2 );
					float4 lerpResult953_g59939 = lerp( RNM_0926_g59939 , RNM_11081_g59939 , Lightmap_Lerp_Value969_g59939);
					float4 RNM_Lerp950_g59939 = lerpResult953_g59939;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g59939 = temp_cast_2;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g59939 = Lightmap_0925_g59939;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g59939 = Lightmap_Lerp932_g59939;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g59939 = RNM_0926_g59939;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g59939 = RNM_Lerp950_g59939;
					#else
					float4 staticSwitch1014_g59939 = temp_cast_2;
					#endif
					float3 Lightmap46_g59939 = (staticSwitch1014_g59939).rgb;
					float dotResult9_g59993 = dot( float3( 0.212673, 0.715152, 0.072175 ) , Lightmap46_g59939 );
					float smoothstepResult14_g59993 = smoothstep( 0.0 , 0.04 , dotResult9_g59993);
					float Indirect_Lightmap_Mask3118_g59939 = smoothstepResult14_g59993;
					float LightmapMask1_g59991 = Indirect_Lightmap_Mask3118_g59939;
					float3 localIndirectSpecular1_g59991 = IndirectSpecular( Color1_g59991 , Metallic1_g59991 , Smoothness1_g59991 , ViewDir1_g59991 , WorldPos1_g59991 , WorldNormal1_g59991 , LightmapMask1_g59991 );
					#ifdef _INDIRECTSPECULARS_ON
					float3 staticSwitch2971_g59939 = localIndirectSpecular1_g59991;
					#else
					float3 staticSwitch2971_g59939 = temp_cast_1;
					#endif
					float3 Indirect_Specular1419_g59939 = staticSwitch2971_g59939;
					float3 temp_cast_4 = (Black1185_g59939).xxx;
					float3 Color97_g59992 = oAlbedo6_g59939;
					float Metallic97_g59992 = Metallic1239_g59939;
					float Smoothness97_g59992 = Smoothness1399_g59939;
					float3 ViewDir97_g59992 = View_Direction2511_g59939;
					float3 WorldPos97_g59992 = World_Position2505_g59939;
					float3 WorldNormal97_g59992 = World_Normal2508_g59939;
					float White38_g59939 = 1.0;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float staticSwitch3107_g59939 = Black1185_g59939;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float staticSwitch3107_g59939 = White38_g59939;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float staticSwitch3107_g59939 = White38_g59939;
					#elif defined( _LIGHTMAPMODE_RNM )
					float staticSwitch3107_g59939 = White38_g59939;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float staticSwitch3107_g59939 = White38_g59939;
					#else
					float staticSwitch3107_g59939 = Black1185_g59939;
					#endif
					float LightmapMode97_g59992 = staticSwitch3107_g59939;
					float dotResult9_g59994 = dot( float3( 0.212673, 0.715152, 0.072175 ) , Lightmap46_g59939 );
					float smoothstepResult2_g59994 = smoothstep( 0.0 , 0.4 , dotResult9_g59994);
					float Direct_Lightmap_Mask3067_g59939 = smoothstepResult2_g59994;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float staticSwitch3085_g59939 = White38_g59939;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float staticSwitch3085_g59939 = Direct_Lightmap_Mask3067_g59939;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float staticSwitch3085_g59939 = Direct_Lightmap_Mask3067_g59939;
					#elif defined( _LIGHTMAPMODE_RNM )
					float staticSwitch3085_g59939 = Direct_Lightmap_Mask3067_g59939;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float staticSwitch3085_g59939 = Direct_Lightmap_Mask3067_g59939;
					#else
					float staticSwitch3085_g59939 = White38_g59939;
					#endif
					float LightmapMask97_g59992 = staticSwitch3085_g59939;
					float3 localDirectSpecular97_g59992 = DirectSpecular( Color97_g59992 , Metallic97_g59992 , Smoothness97_g59992 , ViewDir97_g59992 , WorldPos97_g59992 , WorldNormal97_g59992 , LightmapMode97_g59992 , LightmapMask97_g59992 );
					#ifdef _DIRECTSPECULAR_ON
					float3 staticSwitch2969_g59939 = localDirectSpecular97_g59992;
					#else
					float3 staticSwitch2969_g59939 = temp_cast_4;
					#endif
					float3 Direct_Specular2560_g59939 = staticSwitch2969_g59939;
					float3 aAlbedo1466_g59939 = ( temp_output_2532_0_g59939 * ( 1.0 - Metallic1239_g59939 ) );
					float3 temp_output_1252_0_g59939 = ( aAlbedo1466_g59939 * Lightmap46_g59939 );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch1_g59982 = float4( ( temp_output_1252_0_g59939 + Emission86_g59939 + Indirect_Specular1419_g59939 ) , 0.0 );
					#else
					float4 staticSwitch1_g59982 = float4( ( Emission86_g59939 + Indirect_Specular1419_g59939 + Direct_Specular2560_g59939 + temp_output_1252_0_g59939 ) , 0.0 );
					#endif
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1181_g59939 = float4( Lightmap46_g59939 , 0.0 );
					#else
					float4 staticSwitch1181_g59939 = staticSwitch1_g59982;
					#endif
					float4 Color357_g59979 = staticSwitch1181_g59939;
					float4 LUT51_g59979 = tex3D( _LUT, ( ( log10( ( ( (Color357_g59979).xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 ) );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch359_g59979 = LUT51_g59979;
					#else
					float4 staticSwitch359_g59979 = Color357_g59979;
					#endif
					

					float4 Color = staticSwitch359_g59979;
					float Alpha = staticSwitch1001_g59939.a;
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
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3048;192,-1200;Inherit;False;Meenphie;0;;59939;b3ba55a08dd6b49c7be16c6f35cf2033;6,1008,0,2632,1,2635,1,2619,1,2670,1,2636,1;0;3;FLOAT4;624;FLOAT;156;FLOAT;427
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3049;512,-1200;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;8;Meenphie/Standard/Decal/Additive;95d28ca0904218e4fa77b1221c962cb8;True;Unlit;0;0;Unlit;3;True;True;4;1;False;;1;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;2;False;;True;3;False;;True;False;-1;False;;-1;False;;True;1;False;;True;2;RenderType=Transparent=RenderType;Queue=Transparent=Queue=1;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;2;Alpha Clipping;0;0;Cast Shadows;0;639161721158429220;0;2;True;False;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3050;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;95d28ca0904218e4fa77b1221c962cb8;True;ShadowCaster;0;1;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;False;;True;2;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
WireConnection;3049;0;3048;624
WireConnection;3049;7;3048;156
ASEEND*/
//CHKSM=D0D2485FB4335BA83D267CB7398B95FD57EE917D