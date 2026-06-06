// Made with Amplify Shader Editor v1.9.9.9
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Standard/Transparent/Cutout"
{
	Properties
	{
		[Meenphie_DrawerCategory(SURFACE OPTIONS,true,0,0)] _CATEGORY_SURFACEOPTIONS( "CATEGORY_SURFACEOPTIONS", Float ) = 1
		_Color( "DIffuse Color", Color ) = ( 0.9058824, 0.9058824, 0.9058824, 1 )
		[NoScaleOffset][SingleLineTexture] _MainTex( "Base Color", 2D ) = "white" {}
		[NoScaleOffset][SingleLineTexture] _BumpMap( "Normal", 2D ) = "bump" {}
		_MaskClipValue( "Mask Clip Value", Range( 0, 1 ) ) = 0.5
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
		[HideInInspector] GenKey__MetallicMap( "Assign keyword _METALLICMAP", Float ) = 1.0
		[HideInInspector] GenKey__GlossinessMap( "Assign keyword _GLOSSINESSMAP", Float ) = 1.0
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0
		[HideInInspector] GenKey__MainTex( "Assign keyword _MAINTEX", Float ) = 1.0

	}

	SubShader
	{
		

		

		Tags { "RenderType"="Transparent" "Queue"="Transparent" }

	LOD 0

		

		Blend Off
		AlphaToMask Off
		Cull Off
		ColorMask RGBA
		ZWrite On
		ZClip True
		ZTest LEqual
		Offset 0 , 0
		

		CGINCLUDE
			#pragma target 3.5
			// ensure rendering platforms toggle list is visible

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
				#define _ALPHATEST_ON
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
				sampler2D _Sampler82968_g60028;
				uniform float _EmissionIntensity;
				uniform half4 _Color;
				uniform sampler2D _MainTex;
				sampler2D _Sampler82966_g60028;
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				sampler2D _Sampler82967_g60028;
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				sampler2D _Sampler82964_g60028;
				uniform sampler2D _BumpMap;
				sampler2D _Sampler82965_g60028;
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
				uniform float _MaskClipValue;


				
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

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = defaultVertexValue;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = v.normal;

					o.pos = UnityObjectToClipPos( v.vertex );

					#if defined( ASE_SHADOWS )
						UNITY_TRANSFER_SHADOW( o, v.texcoord );
					#endif
					return o;
				}

				half4 frag( v2f IN 
							#if defined( ASE_DEPTH_WRITE_ON )
								, out float outputDepth : SV_Depth
							#endif
				) : SV_Target
				{
					UNITY_SETUP_INSTANCE_ID( IN );
					UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

					float4 ScreenPosNorm = float4( IN.pos.xy * ( _ScreenParams.zw - 1.0 ), IN.pos.zw );
					float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, IN.pos.z ) * IN.pos.w;
					float4 ScreenPos = ComputeScreenPos( ClipPos );

					float2 texCoord2357_g60028 = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0A2420_g60028 = texCoord2357_g60028;
					float2 temp_output_5_0_g60053 = UV0A2420_g60028;
					float2 UV633_g60053 = temp_output_5_0_g60053;
					float2 UV100_g60054 = UV633_g60053;
					float2 temp_output_51_0_g60054 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60054 * float2( 3.464,3.464 ) ) );
					float2 break55_g60054 = frac( temp_output_51_0_g60054 );
					float temp_output_56_0_g60054 = ( ( 1.0 - break55_g60054.x ) - break55_g60054.y );
					float2 temp_output_52_0_g60054 = floor( temp_output_51_0_g60054 );
					float2 temp_output_125_0_g60054 = ( temp_output_52_0_g60054 + float2( 1,1 ) );
					float2 ifLocalVar87_g60054 = 0;
					if( temp_output_56_0_g60054 > 0.0 )
					ifLocalVar87_g60054 = temp_output_52_0_g60054;
					else if( temp_output_56_0_g60054 == 0.0 )
					ifLocalVar87_g60054 = temp_output_125_0_g60054;
					else if( temp_output_56_0_g60054 < 0.0 )
					ifLocalVar87_g60054 = temp_output_125_0_g60054;
					float3 temp_output_7_0_g60055 = frac( ( (ifLocalVar87_g60054).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60055 = dot( temp_output_7_0_g60055 , ( (temp_output_7_0_g60055).yzx + 33.33 ) );
					float3 temp_output_12_0_g60055 = ( temp_output_7_0_g60055 + dotResult8_g60055 );
					float2 temp_output_597_0_g60053 = ( UV100_g60054 + frac( ( ( (temp_output_12_0_g60055).xx + (temp_output_12_0_g60055).yz ) * (temp_output_12_0_g60055).zy ) ) );
					float2 DDX631_g60053 = ddx( temp_output_5_0_g60053 );
					float2 DDY632_g60053 = ddy( temp_output_5_0_g60053 );
					float temp_output_65_0_g60054 = ( 0.0 - temp_output_56_0_g60054 );
					float ifLocalVar59_g60054 = 0;
					if( temp_output_56_0_g60054 <= 0.0 )
					ifLocalVar59_g60054 = temp_output_65_0_g60054;
					else
					ifLocalVar59_g60054 = temp_output_56_0_g60054;
					float temp_output_597_30_g60053 = ifLocalVar59_g60054;
					float2 temp_output_90_0_g60054 = ( temp_output_52_0_g60054 + float2( 0,1 ) );
					float2 temp_output_123_0_g60054 = ( temp_output_52_0_g60054 + float2( 1,0 ) );
					float2 ifLocalVar88_g60054 = 0;
					if( temp_output_56_0_g60054 > 0.0 )
					ifLocalVar88_g60054 = temp_output_90_0_g60054;
					else if( temp_output_56_0_g60054 == 0.0 )
					ifLocalVar88_g60054 = temp_output_123_0_g60054;
					else if( temp_output_56_0_g60054 < 0.0 )
					ifLocalVar88_g60054 = temp_output_123_0_g60054;
					float3 temp_output_7_0_g60056 = frac( ( (ifLocalVar88_g60054).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60056 = dot( temp_output_7_0_g60056 , ( (temp_output_7_0_g60056).yzx + 33.33 ) );
					float3 temp_output_12_0_g60056 = ( temp_output_7_0_g60056 + dotResult8_g60056 );
					float2 temp_output_597_26_g60053 = ( UV100_g60054 + frac( ( ( (temp_output_12_0_g60056).xx + (temp_output_12_0_g60056).yz ) * (temp_output_12_0_g60056).zy ) ) );
					float temp_output_66_0_g60054 = ( 1.0 - break55_g60054.y );
					float ifLocalVar60_g60054 = 0;
					if( temp_output_56_0_g60054 <= 0.0 )
					ifLocalVar60_g60054 = temp_output_66_0_g60054;
					else
					ifLocalVar60_g60054 = break55_g60054.y;
					float temp_output_597_28_g60053 = ifLocalVar60_g60054;
					float2 ifLocalVar89_g60054 = 0;
					if( temp_output_56_0_g60054 > 0.0 )
					ifLocalVar89_g60054 = temp_output_123_0_g60054;
					else if( temp_output_56_0_g60054 == 0.0 )
					ifLocalVar89_g60054 = temp_output_90_0_g60054;
					else if( temp_output_56_0_g60054 < 0.0 )
					ifLocalVar89_g60054 = temp_output_90_0_g60054;
					float3 temp_output_7_0_g60057 = frac( ( (ifLocalVar89_g60054).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60057 = dot( temp_output_7_0_g60057 , ( (temp_output_7_0_g60057).yzx + 33.33 ) );
					float3 temp_output_12_0_g60057 = ( temp_output_7_0_g60057 + dotResult8_g60057 );
					float2 temp_output_597_27_g60053 = ( UV100_g60054 + frac( ( ( (temp_output_12_0_g60057).xx + (temp_output_12_0_g60057).yz ) * (temp_output_12_0_g60057).zy ) ) );
					float temp_output_67_0_g60054 = ( 1.0 - break55_g60054.x );
					float ifLocalVar61_g60054 = 0;
					if( temp_output_56_0_g60054 <= 0.0 )
					ifLocalVar61_g60054 = temp_output_67_0_g60054;
					else
					ifLocalVar61_g60054 = break55_g60054.x;
					float temp_output_597_29_g60053 = ifLocalVar61_g60054;
					float4 Output_2D293_g60053 = ( ( tex2D( _Sampler82968_g60028, temp_output_597_0_g60053, DDX631_g60053, DDY632_g60053 ) * temp_output_597_30_g60053 ) + ( tex2D( _Sampler82968_g60028, temp_output_597_26_g60053, DDX631_g60053, DDY632_g60053 ) * temp_output_597_28_g60053 ) + ( tex2D( _Sampler82968_g60028, temp_output_597_27_g60053, DDX631_g60053, DDY632_g60053 ) * temp_output_597_29_g60053 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g60028 = Output_2D293_g60053;
					#else
					float4 staticSwitch1006_g60028 = tex2D( _EmissionMap, UV0A2420_g60028 );
					#endif
					float3 temp_output_2531_0_g60028 = (( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g60028 * _EmissionIntensity )).rgb;
					float3 Emission86_g60028 = temp_output_2531_0_g60028;
					float Black1185_g60028 = 0.0;
					float3 temp_cast_1 = (Black1185_g60028).xxx;
					#ifdef _MAINTEX
					float4 staticSwitch1549_g60028 = tex2D( _MainTex, UV0A2420_g60028 );
					#else
					float4 staticSwitch1549_g60028 = _Color;
					#endif
					float2 temp_output_5_0_g60043 = UV0A2420_g60028;
					float2 UV633_g60043 = temp_output_5_0_g60043;
					float2 UV100_g60044 = UV633_g60043;
					float2 temp_output_51_0_g60044 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60044 * float2( 3.464,3.464 ) ) );
					float2 break55_g60044 = frac( temp_output_51_0_g60044 );
					float temp_output_56_0_g60044 = ( ( 1.0 - break55_g60044.x ) - break55_g60044.y );
					float2 temp_output_52_0_g60044 = floor( temp_output_51_0_g60044 );
					float2 temp_output_125_0_g60044 = ( temp_output_52_0_g60044 + float2( 1,1 ) );
					float2 ifLocalVar87_g60044 = 0;
					if( temp_output_56_0_g60044 > 0.0 )
					ifLocalVar87_g60044 = temp_output_52_0_g60044;
					else if( temp_output_56_0_g60044 == 0.0 )
					ifLocalVar87_g60044 = temp_output_125_0_g60044;
					else if( temp_output_56_0_g60044 < 0.0 )
					ifLocalVar87_g60044 = temp_output_125_0_g60044;
					float3 temp_output_7_0_g60045 = frac( ( (ifLocalVar87_g60044).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60045 = dot( temp_output_7_0_g60045 , ( (temp_output_7_0_g60045).yzx + 33.33 ) );
					float3 temp_output_12_0_g60045 = ( temp_output_7_0_g60045 + dotResult8_g60045 );
					float2 temp_output_597_0_g60043 = ( UV100_g60044 + frac( ( ( (temp_output_12_0_g60045).xx + (temp_output_12_0_g60045).yz ) * (temp_output_12_0_g60045).zy ) ) );
					float2 DDX631_g60043 = ddx( temp_output_5_0_g60043 );
					float2 DDY632_g60043 = ddy( temp_output_5_0_g60043 );
					float temp_output_65_0_g60044 = ( 0.0 - temp_output_56_0_g60044 );
					float ifLocalVar59_g60044 = 0;
					if( temp_output_56_0_g60044 <= 0.0 )
					ifLocalVar59_g60044 = temp_output_65_0_g60044;
					else
					ifLocalVar59_g60044 = temp_output_56_0_g60044;
					float temp_output_597_30_g60043 = ifLocalVar59_g60044;
					float2 temp_output_90_0_g60044 = ( temp_output_52_0_g60044 + float2( 0,1 ) );
					float2 temp_output_123_0_g60044 = ( temp_output_52_0_g60044 + float2( 1,0 ) );
					float2 ifLocalVar88_g60044 = 0;
					if( temp_output_56_0_g60044 > 0.0 )
					ifLocalVar88_g60044 = temp_output_90_0_g60044;
					else if( temp_output_56_0_g60044 == 0.0 )
					ifLocalVar88_g60044 = temp_output_123_0_g60044;
					else if( temp_output_56_0_g60044 < 0.0 )
					ifLocalVar88_g60044 = temp_output_123_0_g60044;
					float3 temp_output_7_0_g60046 = frac( ( (ifLocalVar88_g60044).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60046 = dot( temp_output_7_0_g60046 , ( (temp_output_7_0_g60046).yzx + 33.33 ) );
					float3 temp_output_12_0_g60046 = ( temp_output_7_0_g60046 + dotResult8_g60046 );
					float2 temp_output_597_26_g60043 = ( UV100_g60044 + frac( ( ( (temp_output_12_0_g60046).xx + (temp_output_12_0_g60046).yz ) * (temp_output_12_0_g60046).zy ) ) );
					float temp_output_66_0_g60044 = ( 1.0 - break55_g60044.y );
					float ifLocalVar60_g60044 = 0;
					if( temp_output_56_0_g60044 <= 0.0 )
					ifLocalVar60_g60044 = temp_output_66_0_g60044;
					else
					ifLocalVar60_g60044 = break55_g60044.y;
					float temp_output_597_28_g60043 = ifLocalVar60_g60044;
					float2 ifLocalVar89_g60044 = 0;
					if( temp_output_56_0_g60044 > 0.0 )
					ifLocalVar89_g60044 = temp_output_123_0_g60044;
					else if( temp_output_56_0_g60044 == 0.0 )
					ifLocalVar89_g60044 = temp_output_90_0_g60044;
					else if( temp_output_56_0_g60044 < 0.0 )
					ifLocalVar89_g60044 = temp_output_90_0_g60044;
					float3 temp_output_7_0_g60047 = frac( ( (ifLocalVar89_g60044).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60047 = dot( temp_output_7_0_g60047 , ( (temp_output_7_0_g60047).yzx + 33.33 ) );
					float3 temp_output_12_0_g60047 = ( temp_output_7_0_g60047 + dotResult8_g60047 );
					float2 temp_output_597_27_g60043 = ( UV100_g60044 + frac( ( ( (temp_output_12_0_g60047).xx + (temp_output_12_0_g60047).yz ) * (temp_output_12_0_g60047).zy ) ) );
					float temp_output_67_0_g60044 = ( 1.0 - break55_g60044.x );
					float ifLocalVar61_g60044 = 0;
					if( temp_output_56_0_g60044 <= 0.0 )
					ifLocalVar61_g60044 = temp_output_67_0_g60044;
					else
					ifLocalVar61_g60044 = break55_g60044.x;
					float temp_output_597_29_g60043 = ifLocalVar61_g60044;
					float4 Output_2D293_g60043 = ( ( tex2D( _Sampler82966_g60028, temp_output_597_0_g60043, DDX631_g60043, DDY632_g60043 ) * temp_output_597_30_g60043 ) + ( tex2D( _Sampler82966_g60028, temp_output_597_26_g60043, DDX631_g60043, DDY632_g60043 ) * temp_output_597_28_g60043 ) + ( tex2D( _Sampler82966_g60028, temp_output_597_27_g60043, DDX631_g60043, DDY632_g60043 ) * temp_output_597_29_g60043 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g60028 = Output_2D293_g60043;
					#else
					float4 staticSwitch1001_g60028 = staticSwitch1549_g60028;
					#endif
					float3 temp_output_2532_0_g60028 = (staticSwitch1001_g60028).rgb;
					float3 oAlbedo6_g60028 = temp_output_2532_0_g60028;
					float3 Color1_g60087 = oAlbedo6_g60028;
					#ifdef _METALLICMAP
					float staticSwitch846_g60028 = tex2D( _MetallicMap, UV0A2420_g60028 ).r;
					#else
					float staticSwitch846_g60028 = _Metallic;
					#endif
					float2 temp_output_5_0_g60063 = UV0A2420_g60028;
					float2 UV633_g60063 = temp_output_5_0_g60063;
					float2 UV100_g60064 = UV633_g60063;
					float2 temp_output_51_0_g60064 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60064 * float2( 3.464,3.464 ) ) );
					float2 break55_g60064 = frac( temp_output_51_0_g60064 );
					float temp_output_56_0_g60064 = ( ( 1.0 - break55_g60064.x ) - break55_g60064.y );
					float2 temp_output_52_0_g60064 = floor( temp_output_51_0_g60064 );
					float2 temp_output_125_0_g60064 = ( temp_output_52_0_g60064 + float2( 1,1 ) );
					float2 ifLocalVar87_g60064 = 0;
					if( temp_output_56_0_g60064 > 0.0 )
					ifLocalVar87_g60064 = temp_output_52_0_g60064;
					else if( temp_output_56_0_g60064 == 0.0 )
					ifLocalVar87_g60064 = temp_output_125_0_g60064;
					else if( temp_output_56_0_g60064 < 0.0 )
					ifLocalVar87_g60064 = temp_output_125_0_g60064;
					float3 temp_output_7_0_g60065 = frac( ( (ifLocalVar87_g60064).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60065 = dot( temp_output_7_0_g60065 , ( (temp_output_7_0_g60065).yzx + 33.33 ) );
					float3 temp_output_12_0_g60065 = ( temp_output_7_0_g60065 + dotResult8_g60065 );
					float2 temp_output_597_0_g60063 = ( UV100_g60064 + frac( ( ( (temp_output_12_0_g60065).xx + (temp_output_12_0_g60065).yz ) * (temp_output_12_0_g60065).zy ) ) );
					float2 DDX631_g60063 = ddx( temp_output_5_0_g60063 );
					float2 DDY632_g60063 = ddy( temp_output_5_0_g60063 );
					float temp_output_65_0_g60064 = ( 0.0 - temp_output_56_0_g60064 );
					float ifLocalVar59_g60064 = 0;
					if( temp_output_56_0_g60064 <= 0.0 )
					ifLocalVar59_g60064 = temp_output_65_0_g60064;
					else
					ifLocalVar59_g60064 = temp_output_56_0_g60064;
					float temp_output_597_30_g60063 = ifLocalVar59_g60064;
					float2 temp_output_90_0_g60064 = ( temp_output_52_0_g60064 + float2( 0,1 ) );
					float2 temp_output_123_0_g60064 = ( temp_output_52_0_g60064 + float2( 1,0 ) );
					float2 ifLocalVar88_g60064 = 0;
					if( temp_output_56_0_g60064 > 0.0 )
					ifLocalVar88_g60064 = temp_output_90_0_g60064;
					else if( temp_output_56_0_g60064 == 0.0 )
					ifLocalVar88_g60064 = temp_output_123_0_g60064;
					else if( temp_output_56_0_g60064 < 0.0 )
					ifLocalVar88_g60064 = temp_output_123_0_g60064;
					float3 temp_output_7_0_g60066 = frac( ( (ifLocalVar88_g60064).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60066 = dot( temp_output_7_0_g60066 , ( (temp_output_7_0_g60066).yzx + 33.33 ) );
					float3 temp_output_12_0_g60066 = ( temp_output_7_0_g60066 + dotResult8_g60066 );
					float2 temp_output_597_26_g60063 = ( UV100_g60064 + frac( ( ( (temp_output_12_0_g60066).xx + (temp_output_12_0_g60066).yz ) * (temp_output_12_0_g60066).zy ) ) );
					float temp_output_66_0_g60064 = ( 1.0 - break55_g60064.y );
					float ifLocalVar60_g60064 = 0;
					if( temp_output_56_0_g60064 <= 0.0 )
					ifLocalVar60_g60064 = temp_output_66_0_g60064;
					else
					ifLocalVar60_g60064 = break55_g60064.y;
					float temp_output_597_28_g60063 = ifLocalVar60_g60064;
					float2 ifLocalVar89_g60064 = 0;
					if( temp_output_56_0_g60064 > 0.0 )
					ifLocalVar89_g60064 = temp_output_123_0_g60064;
					else if( temp_output_56_0_g60064 == 0.0 )
					ifLocalVar89_g60064 = temp_output_90_0_g60064;
					else if( temp_output_56_0_g60064 < 0.0 )
					ifLocalVar89_g60064 = temp_output_90_0_g60064;
					float3 temp_output_7_0_g60067 = frac( ( (ifLocalVar89_g60064).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60067 = dot( temp_output_7_0_g60067 , ( (temp_output_7_0_g60067).yzx + 33.33 ) );
					float3 temp_output_12_0_g60067 = ( temp_output_7_0_g60067 + dotResult8_g60067 );
					float2 temp_output_597_27_g60063 = ( UV100_g60064 + frac( ( ( (temp_output_12_0_g60067).xx + (temp_output_12_0_g60067).yz ) * (temp_output_12_0_g60067).zy ) ) );
					float temp_output_67_0_g60064 = ( 1.0 - break55_g60064.x );
					float ifLocalVar61_g60064 = 0;
					if( temp_output_56_0_g60064 <= 0.0 )
					ifLocalVar61_g60064 = temp_output_67_0_g60064;
					else
					ifLocalVar61_g60064 = break55_g60064.x;
					float temp_output_597_29_g60063 = ifLocalVar61_g60064;
					float4 Output_2D293_g60063 = ( ( tex2D( _Sampler82967_g60028, temp_output_597_0_g60063, DDX631_g60063, DDY632_g60063 ) * temp_output_597_30_g60063 ) + ( tex2D( _Sampler82967_g60028, temp_output_597_26_g60063, DDX631_g60063, DDY632_g60063 ) * temp_output_597_28_g60063 ) + ( tex2D( _Sampler82967_g60028, temp_output_597_27_g60063, DDX631_g60063, DDY632_g60063 ) * temp_output_597_29_g60063 ) );
					float4 break31_g60063 = Output_2D293_g60063;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g60028 = break31_g60063.r;
					#else
					float staticSwitch1005_g60028 = staticSwitch846_g60028;
					#endif
					float Metallic1239_g60028 = staticSwitch1005_g60028;
					float Metallic1_g60087 = Metallic1239_g60028;
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g60028 = tex2D( _GlossinessMap, UV0A2420_g60028 ).r;
					#else
					float staticSwitch845_g60028 = _Glossiness;
					#endif
					float2 temp_output_5_0_g60048 = UV0A2420_g60028;
					float2 UV633_g60048 = temp_output_5_0_g60048;
					float2 UV100_g60049 = UV633_g60048;
					float2 temp_output_51_0_g60049 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60049 * float2( 3.464,3.464 ) ) );
					float2 break55_g60049 = frac( temp_output_51_0_g60049 );
					float temp_output_56_0_g60049 = ( ( 1.0 - break55_g60049.x ) - break55_g60049.y );
					float2 temp_output_52_0_g60049 = floor( temp_output_51_0_g60049 );
					float2 temp_output_125_0_g60049 = ( temp_output_52_0_g60049 + float2( 1,1 ) );
					float2 ifLocalVar87_g60049 = 0;
					if( temp_output_56_0_g60049 > 0.0 )
					ifLocalVar87_g60049 = temp_output_52_0_g60049;
					else if( temp_output_56_0_g60049 == 0.0 )
					ifLocalVar87_g60049 = temp_output_125_0_g60049;
					else if( temp_output_56_0_g60049 < 0.0 )
					ifLocalVar87_g60049 = temp_output_125_0_g60049;
					float3 temp_output_7_0_g60050 = frac( ( (ifLocalVar87_g60049).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60050 = dot( temp_output_7_0_g60050 , ( (temp_output_7_0_g60050).yzx + 33.33 ) );
					float3 temp_output_12_0_g60050 = ( temp_output_7_0_g60050 + dotResult8_g60050 );
					float2 temp_output_597_0_g60048 = ( UV100_g60049 + frac( ( ( (temp_output_12_0_g60050).xx + (temp_output_12_0_g60050).yz ) * (temp_output_12_0_g60050).zy ) ) );
					float2 DDX631_g60048 = ddx( temp_output_5_0_g60048 );
					float2 DDY632_g60048 = ddy( temp_output_5_0_g60048 );
					float temp_output_65_0_g60049 = ( 0.0 - temp_output_56_0_g60049 );
					float ifLocalVar59_g60049 = 0;
					if( temp_output_56_0_g60049 <= 0.0 )
					ifLocalVar59_g60049 = temp_output_65_0_g60049;
					else
					ifLocalVar59_g60049 = temp_output_56_0_g60049;
					float temp_output_597_30_g60048 = ifLocalVar59_g60049;
					float2 temp_output_90_0_g60049 = ( temp_output_52_0_g60049 + float2( 0,1 ) );
					float2 temp_output_123_0_g60049 = ( temp_output_52_0_g60049 + float2( 1,0 ) );
					float2 ifLocalVar88_g60049 = 0;
					if( temp_output_56_0_g60049 > 0.0 )
					ifLocalVar88_g60049 = temp_output_90_0_g60049;
					else if( temp_output_56_0_g60049 == 0.0 )
					ifLocalVar88_g60049 = temp_output_123_0_g60049;
					else if( temp_output_56_0_g60049 < 0.0 )
					ifLocalVar88_g60049 = temp_output_123_0_g60049;
					float3 temp_output_7_0_g60051 = frac( ( (ifLocalVar88_g60049).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60051 = dot( temp_output_7_0_g60051 , ( (temp_output_7_0_g60051).yzx + 33.33 ) );
					float3 temp_output_12_0_g60051 = ( temp_output_7_0_g60051 + dotResult8_g60051 );
					float2 temp_output_597_26_g60048 = ( UV100_g60049 + frac( ( ( (temp_output_12_0_g60051).xx + (temp_output_12_0_g60051).yz ) * (temp_output_12_0_g60051).zy ) ) );
					float temp_output_66_0_g60049 = ( 1.0 - break55_g60049.y );
					float ifLocalVar60_g60049 = 0;
					if( temp_output_56_0_g60049 <= 0.0 )
					ifLocalVar60_g60049 = temp_output_66_0_g60049;
					else
					ifLocalVar60_g60049 = break55_g60049.y;
					float temp_output_597_28_g60048 = ifLocalVar60_g60049;
					float2 ifLocalVar89_g60049 = 0;
					if( temp_output_56_0_g60049 > 0.0 )
					ifLocalVar89_g60049 = temp_output_123_0_g60049;
					else if( temp_output_56_0_g60049 == 0.0 )
					ifLocalVar89_g60049 = temp_output_90_0_g60049;
					else if( temp_output_56_0_g60049 < 0.0 )
					ifLocalVar89_g60049 = temp_output_90_0_g60049;
					float3 temp_output_7_0_g60052 = frac( ( (ifLocalVar89_g60049).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60052 = dot( temp_output_7_0_g60052 , ( (temp_output_7_0_g60052).yzx + 33.33 ) );
					float3 temp_output_12_0_g60052 = ( temp_output_7_0_g60052 + dotResult8_g60052 );
					float2 temp_output_597_27_g60048 = ( UV100_g60049 + frac( ( ( (temp_output_12_0_g60052).xx + (temp_output_12_0_g60052).yz ) * (temp_output_12_0_g60052).zy ) ) );
					float temp_output_67_0_g60049 = ( 1.0 - break55_g60049.x );
					float ifLocalVar61_g60049 = 0;
					if( temp_output_56_0_g60049 <= 0.0 )
					ifLocalVar61_g60049 = temp_output_67_0_g60049;
					else
					ifLocalVar61_g60049 = break55_g60049.x;
					float temp_output_597_29_g60048 = ifLocalVar61_g60049;
					float4 Output_2D293_g60048 = ( ( tex2D( _Sampler82964_g60028, temp_output_597_0_g60048, DDX631_g60048, DDY632_g60048 ) * temp_output_597_30_g60048 ) + ( tex2D( _Sampler82964_g60028, temp_output_597_26_g60048, DDX631_g60048, DDY632_g60048 ) * temp_output_597_28_g60048 ) + ( tex2D( _Sampler82964_g60028, temp_output_597_27_g60048, DDX631_g60048, DDY632_g60048 ) * temp_output_597_29_g60048 ) );
					float4 break31_g60048 = Output_2D293_g60048;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g60028 = ( 1.0 - break31_g60048.r );
					#else
					float staticSwitch1004_g60028 = ( 1.0 - staticSwitch845_g60028 );
					#endif
					float temp_output_19_0_g60070 = staticSwitch1004_g60028;
					float2 temp_output_5_0_g60038 = UV0A2420_g60028;
					float2 UV633_g60038 = temp_output_5_0_g60038;
					float2 UV100_g60039 = UV633_g60038;
					float2 temp_output_51_0_g60039 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60039 * float2( 3.464,3.464 ) ) );
					float2 break55_g60039 = frac( temp_output_51_0_g60039 );
					float temp_output_56_0_g60039 = ( ( 1.0 - break55_g60039.x ) - break55_g60039.y );
					float2 temp_output_52_0_g60039 = floor( temp_output_51_0_g60039 );
					float2 temp_output_125_0_g60039 = ( temp_output_52_0_g60039 + float2( 1,1 ) );
					float2 ifLocalVar87_g60039 = 0;
					if( temp_output_56_0_g60039 > 0.0 )
					ifLocalVar87_g60039 = temp_output_52_0_g60039;
					else if( temp_output_56_0_g60039 == 0.0 )
					ifLocalVar87_g60039 = temp_output_125_0_g60039;
					else if( temp_output_56_0_g60039 < 0.0 )
					ifLocalVar87_g60039 = temp_output_125_0_g60039;
					float3 temp_output_7_0_g60040 = frac( ( (ifLocalVar87_g60039).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60040 = dot( temp_output_7_0_g60040 , ( (temp_output_7_0_g60040).yzx + 33.33 ) );
					float3 temp_output_12_0_g60040 = ( temp_output_7_0_g60040 + dotResult8_g60040 );
					float2 temp_output_597_0_g60038 = ( UV100_g60039 + frac( ( ( (temp_output_12_0_g60040).xx + (temp_output_12_0_g60040).yz ) * (temp_output_12_0_g60040).zy ) ) );
					float2 DDX631_g60038 = ddx( temp_output_5_0_g60038 );
					float2 DDY632_g60038 = ddy( temp_output_5_0_g60038 );
					float Input_Scale617_g60038 = 1.5;
					float temp_output_65_0_g60039 = ( 0.0 - temp_output_56_0_g60039 );
					float ifLocalVar59_g60039 = 0;
					if( temp_output_56_0_g60039 <= 0.0 )
					ifLocalVar59_g60039 = temp_output_65_0_g60039;
					else
					ifLocalVar59_g60039 = temp_output_56_0_g60039;
					float temp_output_597_30_g60038 = ifLocalVar59_g60039;
					float2 temp_output_90_0_g60039 = ( temp_output_52_0_g60039 + float2( 0,1 ) );
					float2 temp_output_123_0_g60039 = ( temp_output_52_0_g60039 + float2( 1,0 ) );
					float2 ifLocalVar88_g60039 = 0;
					if( temp_output_56_0_g60039 > 0.0 )
					ifLocalVar88_g60039 = temp_output_90_0_g60039;
					else if( temp_output_56_0_g60039 == 0.0 )
					ifLocalVar88_g60039 = temp_output_123_0_g60039;
					else if( temp_output_56_0_g60039 < 0.0 )
					ifLocalVar88_g60039 = temp_output_123_0_g60039;
					float3 temp_output_7_0_g60041 = frac( ( (ifLocalVar88_g60039).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60041 = dot( temp_output_7_0_g60041 , ( (temp_output_7_0_g60041).yzx + 33.33 ) );
					float3 temp_output_12_0_g60041 = ( temp_output_7_0_g60041 + dotResult8_g60041 );
					float2 temp_output_597_26_g60038 = ( UV100_g60039 + frac( ( ( (temp_output_12_0_g60041).xx + (temp_output_12_0_g60041).yz ) * (temp_output_12_0_g60041).zy ) ) );
					float temp_output_66_0_g60039 = ( 1.0 - break55_g60039.y );
					float ifLocalVar60_g60039 = 0;
					if( temp_output_56_0_g60039 <= 0.0 )
					ifLocalVar60_g60039 = temp_output_66_0_g60039;
					else
					ifLocalVar60_g60039 = break55_g60039.y;
					float temp_output_597_28_g60038 = ifLocalVar60_g60039;
					float2 ifLocalVar89_g60039 = 0;
					if( temp_output_56_0_g60039 > 0.0 )
					ifLocalVar89_g60039 = temp_output_123_0_g60039;
					else if( temp_output_56_0_g60039 == 0.0 )
					ifLocalVar89_g60039 = temp_output_90_0_g60039;
					else if( temp_output_56_0_g60039 < 0.0 )
					ifLocalVar89_g60039 = temp_output_90_0_g60039;
					float3 temp_output_7_0_g60042 = frac( ( (ifLocalVar89_g60039).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g60042 = dot( temp_output_7_0_g60042 , ( (temp_output_7_0_g60042).yzx + 33.33 ) );
					float3 temp_output_12_0_g60042 = ( temp_output_7_0_g60042 + dotResult8_g60042 );
					float2 temp_output_597_27_g60038 = ( UV100_g60039 + frac( ( ( (temp_output_12_0_g60042).xx + (temp_output_12_0_g60042).yz ) * (temp_output_12_0_g60042).zy ) ) );
					float temp_output_67_0_g60039 = ( 1.0 - break55_g60039.x );
					float ifLocalVar61_g60039 = 0;
					if( temp_output_56_0_g60039 <= 0.0 )
					ifLocalVar61_g60039 = temp_output_67_0_g60039;
					else
					ifLocalVar61_g60039 = break55_g60039.x;
					float temp_output_597_29_g60038 = ifLocalVar61_g60039;
					float3 Output_2D_Normal641_g60038 = ( ( UnpackScaleNormal( tex2D( _Sampler82965_g60028, temp_output_597_0_g60038, DDX631_g60038, DDY632_g60038 ), Input_Scale617_g60038 ) * temp_output_597_30_g60038 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g60028, temp_output_597_26_g60038, DDX631_g60038, DDY632_g60038 ), Input_Scale617_g60038 ) * temp_output_597_28_g60038 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g60028, temp_output_597_27_g60038, DDX631_g60038, DDY632_g60038 ), Input_Scale617_g60038 ) * float3( 0,0,0 ) * temp_output_597_29_g60038 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g60028 = Output_2D_Normal641_g60038;
					#else
					float3 staticSwitch1003_g60028 = UnpackScaleNormal( tex2D( _BumpMap, UV0A2420_g60028 ), 1.5 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g60028 = staticSwitch1003_g60028;
					#else
					float3 staticSwitch980_g60028 = float3( 0, 0, 1 );
					#endif
					float3 normalizeResult2878_g60028 = normalize( staticSwitch980_g60028 );
					float3 Normal_Map700_g60028 = normalizeResult2878_g60028;
					float3 ase_tangentWS = IN.ase_texcoord1.xyz;
					float3 ase_normalWS = IN.ase_texcoord2.xyz;
					float3 ase_bitangentWS = IN.ase_texcoord3.xyz;
					float3 tanToWorld0 = float3( ase_tangentWS.x, ase_bitangentWS.x, ase_normalWS.x );
					float3 tanToWorld1 = float3( ase_tangentWS.y, ase_bitangentWS.y, ase_normalWS.y );
					float3 tanToWorld2 = float3( ase_tangentWS.z, ase_bitangentWS.z, ase_normalWS.z );
					float3 tanNormal2504_g60028 = Normal_Map700_g60028;
					float3 worldNormal2504_g60028 = normalize( float3( dot( tanToWorld0, tanNormal2504_g60028 ), dot( tanToWorld1, tanNormal2504_g60028 ), dot( tanToWorld2, tanNormal2504_g60028 ) ) );
					float3 World_Normal2508_g60028 = worldNormal2504_g60028;
					float3 tanNormal2_g60070 = World_Normal2508_g60028;
					float3 worldNormal2_g60070 = float3( dot( tanToWorld0, tanNormal2_g60070 ), dot( tanToWorld1, tanNormal2_g60070 ), dot( tanToWorld2, tanNormal2_g60070 ) );
					float3 temp_output_3_0_g60070 = ddx( worldNormal2_g60070 );
					float dotResult5_g60070 = dot( temp_output_3_0_g60070 , temp_output_3_0_g60070 );
					float3 temp_output_4_0_g60070 = ddy( worldNormal2_g60070 );
					float dotResult6_g60070 = dot( temp_output_4_0_g60070 , temp_output_4_0_g60070 );
					#ifdef _USEGEOMETRICAA_ON
					float staticSwitch15_g60070 = min( temp_output_19_0_g60070, ( 1.0 - pow( saturate( max( dotResult5_g60070, dotResult6_g60070 ) ) , 0.25 ) ) );
					#else
					float staticSwitch15_g60070 = temp_output_19_0_g60070;
					#endif
					float Smoothness1399_g60028 = staticSwitch15_g60070;
					float Smoothness1_g60087 = Smoothness1399_g60028;
					float3 ase_positionWS = IN.ase_texcoord4.xyz;
					float3 ase_viewVectorWS = ( ( unity_OrthoParams.w == 0 ) ? _WorldSpaceCameraPos - ase_positionWS : UNITY_MATRIX_V[ 2 ].xyz );
					float3 ase_viewDirWS = normalize( ase_viewVectorWS );
					float3 View_Direction2511_g60028 = ase_viewDirWS;
					float3 ViewDir1_g60087 = View_Direction2511_g60028;
					float3 World_Position2505_g60028 = ase_positionWS;
					float3 WorldPos1_g60087 = World_Position2505_g60028;
					float3 WorldNormal1_g60087 = World_Normal2508_g60028;
					float White38_g60028 = 1.0;
					float4 temp_cast_2 = (Black1185_g60028).xxxx;
					float4 texCoord2426_g60028 = IN.ase_texcoord;
					texCoord2426_g60028.xy = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0B2361_g60028 = (texCoord2426_g60028).zw;
					float localBicubicPrepare2_g60037 = ( 0.0 );
					float2 Input_UV100_g60037 = UV0B2361_g60028;
					float2 UV2_g60037 = Input_UV100_g60037;
					float4 TexelSize2_g60037 = _Lightmap0_TexelSize;
					float2 UV02_g60037 = float2( 0,0 );
					float2 UV12_g60037 = float2( 0,0 );
					float2 UV22_g60037 = float2( 0,0 );
					float2 UV32_g60037 = float2( 0,0 );
					float W02_g60037 = 0;
					float W12_g60037 = 0;
					{
					{
					 UV2_g60037 = UV2_g60037 * TexelSize2_g60037.zw - 0.5;
					    float2 f = frac( UV2_g60037 );
					    UV2_g60037 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g60037.x - 0.5, UV2_g60037.x + 1.5, UV2_g60037.y - 0.5, UV2_g60037.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60037.xyxy;
					    UV02_g60037 = off.xz;
					    UV12_g60037 = off.yz;
					    UV22_g60037 = off.xw;
					    UV32_g60037 = off.yw;
					    W02_g60037 = s.x / ( s.x + s.y );
					 W12_g60037 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g60037 = lerp( tex2D( _Lightmap0, UV32_g60037 ) , tex2D( _Lightmap0, UV22_g60037 ) , W02_g60037);
					float4 lerpResult45_g60037 = lerp( tex2D( _Lightmap0, UV12_g60037 ) , tex2D( _Lightmap0, UV02_g60037 ) , W02_g60037);
					float4 lerpResult44_g60037 = lerp( lerpResult46_g60037 , lerpResult45_g60037 , W12_g60037);
					float4 Output_2D_Auto131_g60037 = lerpResult44_g60037;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g60028 = Output_2D_Auto131_g60037;
					#else
					float4 staticSwitch1092_g60028 = float4( tex2D( _Lightmap0, UV0B2361_g60028 ).rgb , 0.0 );
					#endif
					float4 Lightmap_0925_g60028 = staticSwitch1092_g60028;
					float localBicubicPrepare2_g60035 = ( 0.0 );
					float2 Input_UV100_g60035 = UV0B2361_g60028;
					float2 UV2_g60035 = Input_UV100_g60035;
					float4 TexelSize2_g60035 = _Lightmap1_TexelSize;
					float2 UV02_g60035 = float2( 0,0 );
					float2 UV12_g60035 = float2( 0,0 );
					float2 UV22_g60035 = float2( 0,0 );
					float2 UV32_g60035 = float2( 0,0 );
					float W02_g60035 = 0;
					float W12_g60035 = 0;
					{
					{
					 UV2_g60035 = UV2_g60035 * TexelSize2_g60035.zw - 0.5;
					    float2 f = frac( UV2_g60035 );
					    UV2_g60035 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g60035.x - 0.5, UV2_g60035.x + 1.5, UV2_g60035.y - 0.5, UV2_g60035.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60035.xyxy;
					    UV02_g60035 = off.xz;
					    UV12_g60035 = off.yz;
					    UV22_g60035 = off.xw;
					    UV32_g60035 = off.yw;
					    W02_g60035 = s.x / ( s.x + s.y );
					 W12_g60035 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g60035 = lerp( tex2D( _Lightmap1, UV32_g60035 ) , tex2D( _Lightmap1, UV22_g60035 ) , W02_g60035);
					float4 lerpResult45_g60035 = lerp( tex2D( _Lightmap1, UV12_g60035 ) , tex2D( _Lightmap1, UV02_g60035 ) , W02_g60035);
					float4 lerpResult44_g60035 = lerp( lerpResult46_g60035 , lerpResult45_g60035 , W12_g60035);
					float4 Output_2D_Auto131_g60035 = lerpResult44_g60035;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g60028 = Output_2D_Auto131_g60035;
					#else
					float4 staticSwitch1088_g60028 = tex2D( _Lightmap1, UV0B2361_g60028 );
					#endif
					float4 Lightmap_1956_g60028 = staticSwitch1088_g60028;
					float Lightmap_Lerp_Value969_g60028 = _UdonLightmapLerp;
					float4 lerpResult442_g60028 = lerp( Lightmap_0925_g60028 , Lightmap_1956_g60028 , Lightmap_Lerp_Value969_g60028);
					float4 Lightmap_Lerp932_g60028 = lerpResult442_g60028;
					float3 appendResult139_g60077 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 Normal_Map318_g60077 = Normal_Map700_g60028;
					float dotResult121_g60077 = dot( appendResult139_g60077 , Normal_Map318_g60077 );
					float temp_output_2_0_g60079 = saturate( dotResult121_g60077 );
					float localStochasticTiling2_g60059 = ( 0.0 );
					float2 UV2_g60059 = UV0B2361_g60028;
					float4 TexelSize2_g60059 = _UdonRNMX0_TexelSize;
					float4 Offsets2_g60059 = float4( 0,0,0,0 );
					float2 Weights2_g60059 = float2( 0,0 );
					{
					UV2_g60059 = UV2_g60059 * TexelSize2_g60059.zw - 0.5;
					float2 f = frac( UV2_g60059 );
					UV2_g60059 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g60059.x - 0.5, UV2_g60059.x + 1.5, UV2_g60059.y - 0.5, UV2_g60059.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g60059 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60059.xyxy;
					Weights2_g60059 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g60058 = Offsets2_g60059;
					float4 Input_FetchOffsets197_g60060 = temp_output_1_34_g60058;
					float2 temp_output_1_54_g60058 = Weights2_g60059;
					float2 Input_FetchWeights200_g60060 = temp_output_1_54_g60058;
					float2 break187_g60060 = Input_FetchWeights200_g60060;
					float4 lerpResult181_g60060 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60060).yw ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60060).xw ) , break187_g60060.x);
					float4 lerpResult182_g60060 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60060).yz ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60060).xz ) , break187_g60060.x);
					float4 lerpResult176_g60060 = lerp( lerpResult181_g60060 , lerpResult182_g60060 , break187_g60060.y);
					float4 Output_Fetch2D_Auto202_g60060 = lerpResult176_g60060;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g60028 = Output_Fetch2D_Auto202_g60060;
					#else
					float4 staticSwitch1061_g60028 = tex2D( _UdonRNMX0, UV0B2361_g60028 );
					#endif
					float3 appendResult146_g60077 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g60077 = dot( appendResult146_g60077 , Normal_Map318_g60077 );
					float temp_output_2_0_g60078 = saturate( dotResult122_g60077 );
					float4 Input_FetchOffsets197_g60061 = temp_output_1_34_g60058;
					float2 Input_FetchWeights200_g60061 = temp_output_1_54_g60058;
					float2 break187_g60061 = Input_FetchWeights200_g60061;
					float4 lerpResult181_g60061 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60061).yw ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60061).xw ) , break187_g60061.x);
					float4 lerpResult182_g60061 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60061).yz ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60061).xz ) , break187_g60061.x);
					float4 lerpResult176_g60061 = lerp( lerpResult181_g60061 , lerpResult182_g60061 , break187_g60061.y);
					float4 Output_Fetch2D_Auto202_g60061 = lerpResult176_g60061;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g60028 = Output_Fetch2D_Auto202_g60061;
					#else
					float4 staticSwitch1062_g60028 = tex2D( _UdonRNMY0, UV0B2361_g60028 );
					#endif
					float3 appendResult149_g60077 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g60077 = dot( appendResult149_g60077 , Normal_Map318_g60077 );
					float temp_output_2_0_g60080 = saturate( dotResult120_g60077 );
					float4 Input_FetchOffsets197_g60062 = temp_output_1_34_g60058;
					float2 Input_FetchWeights200_g60062 = temp_output_1_54_g60058;
					float2 break187_g60062 = Input_FetchWeights200_g60062;
					float4 lerpResult181_g60062 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60062).yw ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60062).xw ) , break187_g60062.x);
					float4 lerpResult182_g60062 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60062).yz ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60062).xz ) , break187_g60062.x);
					float4 lerpResult176_g60062 = lerp( lerpResult181_g60062 , lerpResult182_g60062 , break187_g60062.y);
					float4 Output_Fetch2D_Auto202_g60062 = lerpResult176_g60062;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g60028 = Output_Fetch2D_Auto202_g60062;
					#else
					float4 staticSwitch1063_g60028 = tex2D( _UdonRNMZ0, UV0B2361_g60028 );
					#endif
					float4 temp_output_3094_0_g60028 = ( ( ( ( ( temp_output_2_0_g60079 * temp_output_2_0_g60079 ) * staticSwitch1061_g60028 ) + ( ( temp_output_2_0_g60078 * temp_output_2_0_g60078 ) * staticSwitch1062_g60028 ) ) + ( ( temp_output_2_0_g60080 * temp_output_2_0_g60080 ) * staticSwitch1063_g60028 ) ) * 1.2 );
					float4 RNM_0926_g60028 = temp_output_3094_0_g60028;
					float3 appendResult139_g60072 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 Normal_Map318_g60072 = Normal_Map700_g60028;
					float dotResult121_g60072 = dot( appendResult139_g60072 , Normal_Map318_g60072 );
					float temp_output_2_0_g60074 = saturate( dotResult121_g60072 );
					float localStochasticTiling2_g60030 = ( 0.0 );
					float2 UV2_g60030 = UV0B2361_g60028;
					float4 TexelSize2_g60030 = _UdonRNMX1_TexelSize;
					float4 Offsets2_g60030 = float4( 0,0,0,0 );
					float2 Weights2_g60030 = float2( 0,0 );
					{
					UV2_g60030 = UV2_g60030 * TexelSize2_g60030.zw - 0.5;
					float2 f = frac( UV2_g60030 );
					UV2_g60030 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g60030.x - 0.5, UV2_g60030.x + 1.5, UV2_g60030.y - 0.5, UV2_g60030.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g60030 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60030.xyxy;
					Weights2_g60030 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g60029 = Offsets2_g60030;
					float4 Input_FetchOffsets197_g60031 = temp_output_1_34_g60029;
					float2 temp_output_1_54_g60029 = Weights2_g60030;
					float2 Input_FetchWeights200_g60031 = temp_output_1_54_g60029;
					float2 break187_g60031 = Input_FetchWeights200_g60031;
					float4 lerpResult181_g60031 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60031).yw ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60031).xw ) , break187_g60031.x);
					float4 lerpResult182_g60031 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60031).yz ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60031).xz ) , break187_g60031.x);
					float4 lerpResult176_g60031 = lerp( lerpResult181_g60031 , lerpResult182_g60031 , break187_g60031.y);
					float4 Output_Fetch2D_Auto202_g60031 = lerpResult176_g60031;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g60028 = Output_Fetch2D_Auto202_g60031;
					#else
					float4 staticSwitch1087_g60028 = tex2D( _UdonRNMX1, UV0B2361_g60028 );
					#endif
					float3 appendResult146_g60072 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g60072 = dot( appendResult146_g60072 , Normal_Map318_g60072 );
					float temp_output_2_0_g60073 = saturate( dotResult122_g60072 );
					float4 Input_FetchOffsets197_g60032 = temp_output_1_34_g60029;
					float2 Input_FetchWeights200_g60032 = temp_output_1_54_g60029;
					float2 break187_g60032 = Input_FetchWeights200_g60032;
					float4 lerpResult181_g60032 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60032).yw ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60032).xw ) , break187_g60032.x);
					float4 lerpResult182_g60032 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60032).yz ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60032).xz ) , break187_g60032.x);
					float4 lerpResult176_g60032 = lerp( lerpResult181_g60032 , lerpResult182_g60032 , break187_g60032.y);
					float4 Output_Fetch2D_Auto202_g60032 = lerpResult176_g60032;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g60028 = Output_Fetch2D_Auto202_g60032;
					#else
					float4 staticSwitch1083_g60028 = tex2D( _UdonRNMY1, UV0B2361_g60028 );
					#endif
					float3 appendResult149_g60072 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g60072 = dot( appendResult149_g60072 , Normal_Map318_g60072 );
					float temp_output_2_0_g60075 = saturate( dotResult120_g60072 );
					float4 Input_FetchOffsets197_g60033 = temp_output_1_34_g60029;
					float2 Input_FetchWeights200_g60033 = temp_output_1_54_g60029;
					float2 break187_g60033 = Input_FetchWeights200_g60033;
					float4 lerpResult181_g60033 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60033).yw ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60033).xw ) , break187_g60033.x);
					float4 lerpResult182_g60033 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60033).yz ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60033).xz ) , break187_g60033.x);
					float4 lerpResult176_g60033 = lerp( lerpResult181_g60033 , lerpResult182_g60033 , break187_g60033.y);
					float4 Output_Fetch2D_Auto202_g60033 = lerpResult176_g60033;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g60028 = Output_Fetch2D_Auto202_g60033;
					#else
					float4 staticSwitch1084_g60028 = tex2D( _UdonRNMZ1, UV0B2361_g60028 );
					#endif
					float4 RNM_11081_g60028 = ( ( ( ( ( temp_output_2_0_g60074 * temp_output_2_0_g60074 ) * staticSwitch1087_g60028 ) + ( ( temp_output_2_0_g60073 * temp_output_2_0_g60073 ) * staticSwitch1083_g60028 ) ) + ( ( temp_output_2_0_g60075 * temp_output_2_0_g60075 ) * staticSwitch1084_g60028 ) ) * 1.2 );
					float4 lerpResult953_g60028 = lerp( RNM_0926_g60028 , RNM_11081_g60028 , Lightmap_Lerp_Value969_g60028);
					float4 RNM_Lerp950_g60028 = lerpResult953_g60028;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g60028 = temp_cast_2;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g60028 = Lightmap_0925_g60028;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g60028 = Lightmap_Lerp932_g60028;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g60028 = RNM_0926_g60028;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g60028 = RNM_Lerp950_g60028;
					#else
					float4 staticSwitch1014_g60028 = temp_cast_2;
					#endif
					float3 Lightmap46_g60028 = (staticSwitch1014_g60028).rgb;
					float dotResult9_g60086 = dot( float3( 0.212673, 0.715152, 0.072175 ) , Lightmap46_g60028 );
					float smoothstepResult14_g60086 = smoothstep( 0.0 , 0.04 , dotResult9_g60086);
					float Indirect_Lightmap_Mask3118_g60028 = smoothstepResult14_g60086;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float staticSwitch3145_g60028 = White38_g60028;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float staticSwitch3145_g60028 = Indirect_Lightmap_Mask3118_g60028;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float staticSwitch3145_g60028 = Indirect_Lightmap_Mask3118_g60028;
					#elif defined( _LIGHTMAPMODE_RNM )
					float staticSwitch3145_g60028 = Indirect_Lightmap_Mask3118_g60028;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float staticSwitch3145_g60028 = Indirect_Lightmap_Mask3118_g60028;
					#else
					float staticSwitch3145_g60028 = White38_g60028;
					#endif
					float LightmapMask1_g60087 = staticSwitch3145_g60028;
					float3 localIndirectSpecular1_g60087 = IndirectSpecular( Color1_g60087 , Metallic1_g60087 , Smoothness1_g60087 , ViewDir1_g60087 , WorldPos1_g60087 , WorldNormal1_g60087 , LightmapMask1_g60087 );
					#ifdef _INDIRECTSPECULARS_ON
					float3 staticSwitch2971_g60028 = localIndirectSpecular1_g60087;
					#else
					float3 staticSwitch2971_g60028 = temp_cast_1;
					#endif
					float3 Indirect_Specular1419_g60028 = staticSwitch2971_g60028;
					float3 temp_cast_4 = (Black1185_g60028).xxx;
					float3 Color97_g60076 = oAlbedo6_g60028;
					float Metallic97_g60076 = Metallic1239_g60028;
					float Smoothness97_g60076 = Smoothness1399_g60028;
					float3 ViewDir97_g60076 = View_Direction2511_g60028;
					float3 WorldPos97_g60076 = World_Position2505_g60028;
					float3 WorldNormal97_g60076 = World_Normal2508_g60028;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float staticSwitch3107_g60028 = Black1185_g60028;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float staticSwitch3107_g60028 = White38_g60028;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float staticSwitch3107_g60028 = White38_g60028;
					#elif defined( _LIGHTMAPMODE_RNM )
					float staticSwitch3107_g60028 = White38_g60028;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float staticSwitch3107_g60028 = White38_g60028;
					#else
					float staticSwitch3107_g60028 = Black1185_g60028;
					#endif
					float LightmapMode97_g60076 = staticSwitch3107_g60028;
					float dotResult9_g60085 = dot( float3( 0.212673, 0.715152, 0.072175 ) , Lightmap46_g60028 );
					float smoothstepResult2_g60085 = smoothstep( 0.0 , 0.4 , dotResult9_g60085);
					float Direct_Lightmap_Mask3067_g60028 = smoothstepResult2_g60085;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float staticSwitch3085_g60028 = White38_g60028;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float staticSwitch3085_g60028 = Direct_Lightmap_Mask3067_g60028;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float staticSwitch3085_g60028 = Direct_Lightmap_Mask3067_g60028;
					#elif defined( _LIGHTMAPMODE_RNM )
					float staticSwitch3085_g60028 = Direct_Lightmap_Mask3067_g60028;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float staticSwitch3085_g60028 = Direct_Lightmap_Mask3067_g60028;
					#else
					float staticSwitch3085_g60028 = White38_g60028;
					#endif
					float LightmapMask97_g60076 = staticSwitch3085_g60028;
					float3 localDirectSpecular97_g60076 = DirectSpecular( Color97_g60076 , Metallic97_g60076 , Smoothness97_g60076 , ViewDir97_g60076 , WorldPos97_g60076 , WorldNormal97_g60076 , LightmapMode97_g60076 , LightmapMask97_g60076 );
					#ifdef _DIRECTSPECULAR_ON
					float3 staticSwitch2969_g60028 = localDirectSpecular97_g60076;
					#else
					float3 staticSwitch2969_g60028 = temp_cast_4;
					#endif
					float3 Direct_Specular2560_g60028 = staticSwitch2969_g60028;
					float3 aAlbedo1466_g60028 = ( temp_output_2532_0_g60028 * ( 1.0 - Metallic1239_g60028 ) );
					float3 temp_output_1252_0_g60028 = ( aAlbedo1466_g60028 * Lightmap46_g60028 );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch1_g60071 = float4( ( temp_output_1252_0_g60028 + Emission86_g60028 + Indirect_Specular1419_g60028 ) , 0.0 );
					#else
					float4 staticSwitch1_g60071 = float4( ( Emission86_g60028 + Indirect_Specular1419_g60028 + Direct_Specular2560_g60028 + temp_output_1252_0_g60028 ) , 0.0 );
					#endif
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1181_g60028 = float4( Lightmap46_g60028 , 0.0 );
					#else
					float4 staticSwitch1181_g60028 = staticSwitch1_g60071;
					#endif
					float4 Color357_g60068 = staticSwitch1181_g60028;
					float4 LUT51_g60068 = tex3D( _LUT, ( ( log10( ( ( (Color357_g60068).xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 ) );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch359_g60068 = LUT51_g60068;
					#else
					float4 staticSwitch359_g60068 = Color357_g60068;
					#endif
					

					float4 Color = staticSwitch359_g60068;
					float Alpha = staticSwitch1001_g60028.a;
					half AlphaClipThreshold = _MaskClipValue;
					half AlphaClipThresholdShadow = 0.5;

					#if defined( ASE_DEPTH_WRITE_ON )
						outputDepth = IN.pos.z;
					#endif

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
}
/*ASEBEGIN
Version=19909
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2962;192,-1200;Inherit;False;Meenphie;0;;60028;b3ba55a08dd6b49c7be16c6f35cf2033;6,1008,1,2632,0,2635,0,2619,0,2670,0,2636,0;0;3;FLOAT4;624;FLOAT;156;FLOAT;427
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2963;512,-1200;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;7;Meenphie/Standard/Transparent/Cutout;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;7;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;True;True;2;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;False;;True;2;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;5;Alpha Clipping;1;639163625814314340;  Use Shadow Threshold;0;0;Cast Shadows;0;639163625880783710;Write Depth;0;0;Vertex Position;1;0;0;2;True;False;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2964;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;0770190933193b94aaa3065e307002fa;True;ShadowCaster;0;1;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;False;;True;2;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
WireConnection;2963;0;2962;624
WireConnection;2963;7;2962;156
WireConnection;2963;8;2962;427
ASEEND*/
//CHKSM=041FE96D1A6A7EFAAE222C73A0F0BD3B229554CD