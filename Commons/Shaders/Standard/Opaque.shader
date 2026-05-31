// Made with Amplify Shader Editor v1.9.9.9
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Standard/Opaque"
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
		

		

		Tags { "RenderType"="Opaque" }

	LOD 0

		

		Blend Off
		AlphaToMask Off
		Cull Back
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
				sampler2D _Sampler82968_g64869;
				uniform float _EmissionIntensity;
				uniform half4 _Color;
				uniform sampler2D _MainTex;
				sampler2D _Sampler82966_g64869;
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				sampler2D _Sampler82967_g64869;
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				sampler2D _Sampler82964_g64869;
				uniform sampler2D _BumpMap;
				sampler2D _Sampler82965_g64869;
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

					float2 texCoord2357_g64869 = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0A2420_g64869 = texCoord2357_g64869;
					float2 temp_output_5_0_g64894 = UV0A2420_g64869;
					float2 UV633_g64894 = temp_output_5_0_g64894;
					float2 UV100_g64895 = UV633_g64894;
					float2 temp_output_51_0_g64895 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g64895 * float2( 3.464,3.464 ) ) );
					float2 break55_g64895 = frac( temp_output_51_0_g64895 );
					float temp_output_56_0_g64895 = ( ( 1.0 - break55_g64895.x ) - break55_g64895.y );
					float2 temp_output_52_0_g64895 = floor( temp_output_51_0_g64895 );
					float2 temp_output_125_0_g64895 = ( temp_output_52_0_g64895 + float2( 1,1 ) );
					float2 ifLocalVar87_g64895 = 0;
					if( temp_output_56_0_g64895 > 0.0 )
					ifLocalVar87_g64895 = temp_output_52_0_g64895;
					else if( temp_output_56_0_g64895 == 0.0 )
					ifLocalVar87_g64895 = temp_output_125_0_g64895;
					else if( temp_output_56_0_g64895 < 0.0 )
					ifLocalVar87_g64895 = temp_output_125_0_g64895;
					float3 temp_output_7_0_g64896 = frac( ( (ifLocalVar87_g64895).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g64896 = dot( temp_output_7_0_g64896 , ( (temp_output_7_0_g64896).yzx + 33.33 ) );
					float3 temp_output_12_0_g64896 = ( temp_output_7_0_g64896 + dotResult8_g64896 );
					float2 temp_output_597_0_g64894 = ( UV100_g64895 + frac( ( ( (temp_output_12_0_g64896).xx + (temp_output_12_0_g64896).yz ) * (temp_output_12_0_g64896).zy ) ) );
					float2 DDX631_g64894 = ddx( temp_output_5_0_g64894 );
					float2 DDY632_g64894 = ddy( temp_output_5_0_g64894 );
					float temp_output_65_0_g64895 = ( 0.0 - temp_output_56_0_g64895 );
					float ifLocalVar59_g64895 = 0;
					if( temp_output_56_0_g64895 <= 0.0 )
					ifLocalVar59_g64895 = temp_output_65_0_g64895;
					else
					ifLocalVar59_g64895 = temp_output_56_0_g64895;
					float temp_output_597_30_g64894 = ifLocalVar59_g64895;
					float2 temp_output_90_0_g64895 = ( temp_output_52_0_g64895 + float2( 0,1 ) );
					float2 temp_output_123_0_g64895 = ( temp_output_52_0_g64895 + float2( 1,0 ) );
					float2 ifLocalVar88_g64895 = 0;
					if( temp_output_56_0_g64895 > 0.0 )
					ifLocalVar88_g64895 = temp_output_90_0_g64895;
					else if( temp_output_56_0_g64895 == 0.0 )
					ifLocalVar88_g64895 = temp_output_123_0_g64895;
					else if( temp_output_56_0_g64895 < 0.0 )
					ifLocalVar88_g64895 = temp_output_123_0_g64895;
					float3 temp_output_7_0_g64897 = frac( ( (ifLocalVar88_g64895).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g64897 = dot( temp_output_7_0_g64897 , ( (temp_output_7_0_g64897).yzx + 33.33 ) );
					float3 temp_output_12_0_g64897 = ( temp_output_7_0_g64897 + dotResult8_g64897 );
					float2 temp_output_597_26_g64894 = ( UV100_g64895 + frac( ( ( (temp_output_12_0_g64897).xx + (temp_output_12_0_g64897).yz ) * (temp_output_12_0_g64897).zy ) ) );
					float temp_output_66_0_g64895 = ( 1.0 - break55_g64895.y );
					float ifLocalVar60_g64895 = 0;
					if( temp_output_56_0_g64895 <= 0.0 )
					ifLocalVar60_g64895 = temp_output_66_0_g64895;
					else
					ifLocalVar60_g64895 = break55_g64895.y;
					float temp_output_597_28_g64894 = ifLocalVar60_g64895;
					float2 ifLocalVar89_g64895 = 0;
					if( temp_output_56_0_g64895 > 0.0 )
					ifLocalVar89_g64895 = temp_output_123_0_g64895;
					else if( temp_output_56_0_g64895 == 0.0 )
					ifLocalVar89_g64895 = temp_output_90_0_g64895;
					else if( temp_output_56_0_g64895 < 0.0 )
					ifLocalVar89_g64895 = temp_output_90_0_g64895;
					float3 temp_output_7_0_g64898 = frac( ( (ifLocalVar89_g64895).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g64898 = dot( temp_output_7_0_g64898 , ( (temp_output_7_0_g64898).yzx + 33.33 ) );
					float3 temp_output_12_0_g64898 = ( temp_output_7_0_g64898 + dotResult8_g64898 );
					float2 temp_output_597_27_g64894 = ( UV100_g64895 + frac( ( ( (temp_output_12_0_g64898).xx + (temp_output_12_0_g64898).yz ) * (temp_output_12_0_g64898).zy ) ) );
					float temp_output_67_0_g64895 = ( 1.0 - break55_g64895.x );
					float ifLocalVar61_g64895 = 0;
					if( temp_output_56_0_g64895 <= 0.0 )
					ifLocalVar61_g64895 = temp_output_67_0_g64895;
					else
					ifLocalVar61_g64895 = break55_g64895.x;
					float temp_output_597_29_g64894 = ifLocalVar61_g64895;
					float4 Output_2D293_g64894 = ( ( tex2D( _Sampler82968_g64869, temp_output_597_0_g64894, DDX631_g64894, DDY632_g64894 ) * temp_output_597_30_g64894 ) + ( tex2D( _Sampler82968_g64869, temp_output_597_26_g64894, DDX631_g64894, DDY632_g64894 ) * temp_output_597_28_g64894 ) + ( tex2D( _Sampler82968_g64869, temp_output_597_27_g64894, DDX631_g64894, DDY632_g64894 ) * temp_output_597_29_g64894 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g64869 = Output_2D293_g64894;
					#else
					float4 staticSwitch1006_g64869 = tex2D( _EmissionMap, UV0A2420_g64869 );
					#endif
					float3 temp_output_2531_0_g64869 = (( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g64869 * _EmissionIntensity )).rgb;
					float3 Emission86_g64869 = temp_output_2531_0_g64869;
					float Black1185_g64869 = 0.0;
					float3 temp_cast_1 = (Black1185_g64869).xxx;
					#ifdef _MAINTEX
					float4 staticSwitch1549_g64869 = tex2D( _MainTex, UV0A2420_g64869 );
					#else
					float4 staticSwitch1549_g64869 = _Color;
					#endif
					float2 temp_output_5_0_g64884 = UV0A2420_g64869;
					float2 UV633_g64884 = temp_output_5_0_g64884;
					float2 UV100_g64885 = UV633_g64884;
					float2 temp_output_51_0_g64885 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g64885 * float2( 3.464,3.464 ) ) );
					float2 break55_g64885 = frac( temp_output_51_0_g64885 );
					float temp_output_56_0_g64885 = ( ( 1.0 - break55_g64885.x ) - break55_g64885.y );
					float2 temp_output_52_0_g64885 = floor( temp_output_51_0_g64885 );
					float2 temp_output_125_0_g64885 = ( temp_output_52_0_g64885 + float2( 1,1 ) );
					float2 ifLocalVar87_g64885 = 0;
					if( temp_output_56_0_g64885 > 0.0 )
					ifLocalVar87_g64885 = temp_output_52_0_g64885;
					else if( temp_output_56_0_g64885 == 0.0 )
					ifLocalVar87_g64885 = temp_output_125_0_g64885;
					else if( temp_output_56_0_g64885 < 0.0 )
					ifLocalVar87_g64885 = temp_output_125_0_g64885;
					float3 temp_output_7_0_g64886 = frac( ( (ifLocalVar87_g64885).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g64886 = dot( temp_output_7_0_g64886 , ( (temp_output_7_0_g64886).yzx + 33.33 ) );
					float3 temp_output_12_0_g64886 = ( temp_output_7_0_g64886 + dotResult8_g64886 );
					float2 temp_output_597_0_g64884 = ( UV100_g64885 + frac( ( ( (temp_output_12_0_g64886).xx + (temp_output_12_0_g64886).yz ) * (temp_output_12_0_g64886).zy ) ) );
					float2 DDX631_g64884 = ddx( temp_output_5_0_g64884 );
					float2 DDY632_g64884 = ddy( temp_output_5_0_g64884 );
					float temp_output_65_0_g64885 = ( 0.0 - temp_output_56_0_g64885 );
					float ifLocalVar59_g64885 = 0;
					if( temp_output_56_0_g64885 <= 0.0 )
					ifLocalVar59_g64885 = temp_output_65_0_g64885;
					else
					ifLocalVar59_g64885 = temp_output_56_0_g64885;
					float temp_output_597_30_g64884 = ifLocalVar59_g64885;
					float2 temp_output_90_0_g64885 = ( temp_output_52_0_g64885 + float2( 0,1 ) );
					float2 temp_output_123_0_g64885 = ( temp_output_52_0_g64885 + float2( 1,0 ) );
					float2 ifLocalVar88_g64885 = 0;
					if( temp_output_56_0_g64885 > 0.0 )
					ifLocalVar88_g64885 = temp_output_90_0_g64885;
					else if( temp_output_56_0_g64885 == 0.0 )
					ifLocalVar88_g64885 = temp_output_123_0_g64885;
					else if( temp_output_56_0_g64885 < 0.0 )
					ifLocalVar88_g64885 = temp_output_123_0_g64885;
					float3 temp_output_7_0_g64887 = frac( ( (ifLocalVar88_g64885).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g64887 = dot( temp_output_7_0_g64887 , ( (temp_output_7_0_g64887).yzx + 33.33 ) );
					float3 temp_output_12_0_g64887 = ( temp_output_7_0_g64887 + dotResult8_g64887 );
					float2 temp_output_597_26_g64884 = ( UV100_g64885 + frac( ( ( (temp_output_12_0_g64887).xx + (temp_output_12_0_g64887).yz ) * (temp_output_12_0_g64887).zy ) ) );
					float temp_output_66_0_g64885 = ( 1.0 - break55_g64885.y );
					float ifLocalVar60_g64885 = 0;
					if( temp_output_56_0_g64885 <= 0.0 )
					ifLocalVar60_g64885 = temp_output_66_0_g64885;
					else
					ifLocalVar60_g64885 = break55_g64885.y;
					float temp_output_597_28_g64884 = ifLocalVar60_g64885;
					float2 ifLocalVar89_g64885 = 0;
					if( temp_output_56_0_g64885 > 0.0 )
					ifLocalVar89_g64885 = temp_output_123_0_g64885;
					else if( temp_output_56_0_g64885 == 0.0 )
					ifLocalVar89_g64885 = temp_output_90_0_g64885;
					else if( temp_output_56_0_g64885 < 0.0 )
					ifLocalVar89_g64885 = temp_output_90_0_g64885;
					float3 temp_output_7_0_g64888 = frac( ( (ifLocalVar89_g64885).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g64888 = dot( temp_output_7_0_g64888 , ( (temp_output_7_0_g64888).yzx + 33.33 ) );
					float3 temp_output_12_0_g64888 = ( temp_output_7_0_g64888 + dotResult8_g64888 );
					float2 temp_output_597_27_g64884 = ( UV100_g64885 + frac( ( ( (temp_output_12_0_g64888).xx + (temp_output_12_0_g64888).yz ) * (temp_output_12_0_g64888).zy ) ) );
					float temp_output_67_0_g64885 = ( 1.0 - break55_g64885.x );
					float ifLocalVar61_g64885 = 0;
					if( temp_output_56_0_g64885 <= 0.0 )
					ifLocalVar61_g64885 = temp_output_67_0_g64885;
					else
					ifLocalVar61_g64885 = break55_g64885.x;
					float temp_output_597_29_g64884 = ifLocalVar61_g64885;
					float4 Output_2D293_g64884 = ( ( tex2D( _Sampler82966_g64869, temp_output_597_0_g64884, DDX631_g64884, DDY632_g64884 ) * temp_output_597_30_g64884 ) + ( tex2D( _Sampler82966_g64869, temp_output_597_26_g64884, DDX631_g64884, DDY632_g64884 ) * temp_output_597_28_g64884 ) + ( tex2D( _Sampler82966_g64869, temp_output_597_27_g64884, DDX631_g64884, DDY632_g64884 ) * temp_output_597_29_g64884 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g64869 = Output_2D293_g64884;
					#else
					float4 staticSwitch1001_g64869 = staticSwitch1549_g64869;
					#endif
					float3 temp_output_2532_0_g64869 = (staticSwitch1001_g64869).rgb;
					float3 oAlbedo6_g64869 = temp_output_2532_0_g64869;
					float3 Color1_g64922 = oAlbedo6_g64869;
					#ifdef _METALLICMAP
					float staticSwitch846_g64869 = tex2D( _MetallicMap, UV0A2420_g64869 ).r;
					#else
					float staticSwitch846_g64869 = _Metallic;
					#endif
					float2 temp_output_5_0_g64904 = UV0A2420_g64869;
					float2 UV633_g64904 = temp_output_5_0_g64904;
					float2 UV100_g64905 = UV633_g64904;
					float2 temp_output_51_0_g64905 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g64905 * float2( 3.464,3.464 ) ) );
					float2 break55_g64905 = frac( temp_output_51_0_g64905 );
					float temp_output_56_0_g64905 = ( ( 1.0 - break55_g64905.x ) - break55_g64905.y );
					float2 temp_output_52_0_g64905 = floor( temp_output_51_0_g64905 );
					float2 temp_output_125_0_g64905 = ( temp_output_52_0_g64905 + float2( 1,1 ) );
					float2 ifLocalVar87_g64905 = 0;
					if( temp_output_56_0_g64905 > 0.0 )
					ifLocalVar87_g64905 = temp_output_52_0_g64905;
					else if( temp_output_56_0_g64905 == 0.0 )
					ifLocalVar87_g64905 = temp_output_125_0_g64905;
					else if( temp_output_56_0_g64905 < 0.0 )
					ifLocalVar87_g64905 = temp_output_125_0_g64905;
					float3 temp_output_7_0_g64906 = frac( ( (ifLocalVar87_g64905).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g64906 = dot( temp_output_7_0_g64906 , ( (temp_output_7_0_g64906).yzx + 33.33 ) );
					float3 temp_output_12_0_g64906 = ( temp_output_7_0_g64906 + dotResult8_g64906 );
					float2 temp_output_597_0_g64904 = ( UV100_g64905 + frac( ( ( (temp_output_12_0_g64906).xx + (temp_output_12_0_g64906).yz ) * (temp_output_12_0_g64906).zy ) ) );
					float2 DDX631_g64904 = ddx( temp_output_5_0_g64904 );
					float2 DDY632_g64904 = ddy( temp_output_5_0_g64904 );
					float temp_output_65_0_g64905 = ( 0.0 - temp_output_56_0_g64905 );
					float ifLocalVar59_g64905 = 0;
					if( temp_output_56_0_g64905 <= 0.0 )
					ifLocalVar59_g64905 = temp_output_65_0_g64905;
					else
					ifLocalVar59_g64905 = temp_output_56_0_g64905;
					float temp_output_597_30_g64904 = ifLocalVar59_g64905;
					float2 temp_output_90_0_g64905 = ( temp_output_52_0_g64905 + float2( 0,1 ) );
					float2 temp_output_123_0_g64905 = ( temp_output_52_0_g64905 + float2( 1,0 ) );
					float2 ifLocalVar88_g64905 = 0;
					if( temp_output_56_0_g64905 > 0.0 )
					ifLocalVar88_g64905 = temp_output_90_0_g64905;
					else if( temp_output_56_0_g64905 == 0.0 )
					ifLocalVar88_g64905 = temp_output_123_0_g64905;
					else if( temp_output_56_0_g64905 < 0.0 )
					ifLocalVar88_g64905 = temp_output_123_0_g64905;
					float3 temp_output_7_0_g64907 = frac( ( (ifLocalVar88_g64905).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g64907 = dot( temp_output_7_0_g64907 , ( (temp_output_7_0_g64907).yzx + 33.33 ) );
					float3 temp_output_12_0_g64907 = ( temp_output_7_0_g64907 + dotResult8_g64907 );
					float2 temp_output_597_26_g64904 = ( UV100_g64905 + frac( ( ( (temp_output_12_0_g64907).xx + (temp_output_12_0_g64907).yz ) * (temp_output_12_0_g64907).zy ) ) );
					float temp_output_66_0_g64905 = ( 1.0 - break55_g64905.y );
					float ifLocalVar60_g64905 = 0;
					if( temp_output_56_0_g64905 <= 0.0 )
					ifLocalVar60_g64905 = temp_output_66_0_g64905;
					else
					ifLocalVar60_g64905 = break55_g64905.y;
					float temp_output_597_28_g64904 = ifLocalVar60_g64905;
					float2 ifLocalVar89_g64905 = 0;
					if( temp_output_56_0_g64905 > 0.0 )
					ifLocalVar89_g64905 = temp_output_123_0_g64905;
					else if( temp_output_56_0_g64905 == 0.0 )
					ifLocalVar89_g64905 = temp_output_90_0_g64905;
					else if( temp_output_56_0_g64905 < 0.0 )
					ifLocalVar89_g64905 = temp_output_90_0_g64905;
					float3 temp_output_7_0_g64908 = frac( ( (ifLocalVar89_g64905).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g64908 = dot( temp_output_7_0_g64908 , ( (temp_output_7_0_g64908).yzx + 33.33 ) );
					float3 temp_output_12_0_g64908 = ( temp_output_7_0_g64908 + dotResult8_g64908 );
					float2 temp_output_597_27_g64904 = ( UV100_g64905 + frac( ( ( (temp_output_12_0_g64908).xx + (temp_output_12_0_g64908).yz ) * (temp_output_12_0_g64908).zy ) ) );
					float temp_output_67_0_g64905 = ( 1.0 - break55_g64905.x );
					float ifLocalVar61_g64905 = 0;
					if( temp_output_56_0_g64905 <= 0.0 )
					ifLocalVar61_g64905 = temp_output_67_0_g64905;
					else
					ifLocalVar61_g64905 = break55_g64905.x;
					float temp_output_597_29_g64904 = ifLocalVar61_g64905;
					float4 Output_2D293_g64904 = ( ( tex2D( _Sampler82967_g64869, temp_output_597_0_g64904, DDX631_g64904, DDY632_g64904 ) * temp_output_597_30_g64904 ) + ( tex2D( _Sampler82967_g64869, temp_output_597_26_g64904, DDX631_g64904, DDY632_g64904 ) * temp_output_597_28_g64904 ) + ( tex2D( _Sampler82967_g64869, temp_output_597_27_g64904, DDX631_g64904, DDY632_g64904 ) * temp_output_597_29_g64904 ) );
					float4 break31_g64904 = Output_2D293_g64904;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g64869 = break31_g64904.r;
					#else
					float staticSwitch1005_g64869 = staticSwitch846_g64869;
					#endif
					float Metallic1239_g64869 = staticSwitch1005_g64869;
					float Metallic1_g64922 = Metallic1239_g64869;
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g64869 = tex2D( _GlossinessMap, UV0A2420_g64869 ).r;
					#else
					float staticSwitch845_g64869 = _Glossiness;
					#endif
					float2 temp_output_5_0_g64889 = UV0A2420_g64869;
					float2 UV633_g64889 = temp_output_5_0_g64889;
					float2 UV100_g64890 = UV633_g64889;
					float2 temp_output_51_0_g64890 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g64890 * float2( 3.464,3.464 ) ) );
					float2 break55_g64890 = frac( temp_output_51_0_g64890 );
					float temp_output_56_0_g64890 = ( ( 1.0 - break55_g64890.x ) - break55_g64890.y );
					float2 temp_output_52_0_g64890 = floor( temp_output_51_0_g64890 );
					float2 temp_output_125_0_g64890 = ( temp_output_52_0_g64890 + float2( 1,1 ) );
					float2 ifLocalVar87_g64890 = 0;
					if( temp_output_56_0_g64890 > 0.0 )
					ifLocalVar87_g64890 = temp_output_52_0_g64890;
					else if( temp_output_56_0_g64890 == 0.0 )
					ifLocalVar87_g64890 = temp_output_125_0_g64890;
					else if( temp_output_56_0_g64890 < 0.0 )
					ifLocalVar87_g64890 = temp_output_125_0_g64890;
					float3 temp_output_7_0_g64891 = frac( ( (ifLocalVar87_g64890).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g64891 = dot( temp_output_7_0_g64891 , ( (temp_output_7_0_g64891).yzx + 33.33 ) );
					float3 temp_output_12_0_g64891 = ( temp_output_7_0_g64891 + dotResult8_g64891 );
					float2 temp_output_597_0_g64889 = ( UV100_g64890 + frac( ( ( (temp_output_12_0_g64891).xx + (temp_output_12_0_g64891).yz ) * (temp_output_12_0_g64891).zy ) ) );
					float2 DDX631_g64889 = ddx( temp_output_5_0_g64889 );
					float2 DDY632_g64889 = ddy( temp_output_5_0_g64889 );
					float temp_output_65_0_g64890 = ( 0.0 - temp_output_56_0_g64890 );
					float ifLocalVar59_g64890 = 0;
					if( temp_output_56_0_g64890 <= 0.0 )
					ifLocalVar59_g64890 = temp_output_65_0_g64890;
					else
					ifLocalVar59_g64890 = temp_output_56_0_g64890;
					float temp_output_597_30_g64889 = ifLocalVar59_g64890;
					float2 temp_output_90_0_g64890 = ( temp_output_52_0_g64890 + float2( 0,1 ) );
					float2 temp_output_123_0_g64890 = ( temp_output_52_0_g64890 + float2( 1,0 ) );
					float2 ifLocalVar88_g64890 = 0;
					if( temp_output_56_0_g64890 > 0.0 )
					ifLocalVar88_g64890 = temp_output_90_0_g64890;
					else if( temp_output_56_0_g64890 == 0.0 )
					ifLocalVar88_g64890 = temp_output_123_0_g64890;
					else if( temp_output_56_0_g64890 < 0.0 )
					ifLocalVar88_g64890 = temp_output_123_0_g64890;
					float3 temp_output_7_0_g64892 = frac( ( (ifLocalVar88_g64890).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g64892 = dot( temp_output_7_0_g64892 , ( (temp_output_7_0_g64892).yzx + 33.33 ) );
					float3 temp_output_12_0_g64892 = ( temp_output_7_0_g64892 + dotResult8_g64892 );
					float2 temp_output_597_26_g64889 = ( UV100_g64890 + frac( ( ( (temp_output_12_0_g64892).xx + (temp_output_12_0_g64892).yz ) * (temp_output_12_0_g64892).zy ) ) );
					float temp_output_66_0_g64890 = ( 1.0 - break55_g64890.y );
					float ifLocalVar60_g64890 = 0;
					if( temp_output_56_0_g64890 <= 0.0 )
					ifLocalVar60_g64890 = temp_output_66_0_g64890;
					else
					ifLocalVar60_g64890 = break55_g64890.y;
					float temp_output_597_28_g64889 = ifLocalVar60_g64890;
					float2 ifLocalVar89_g64890 = 0;
					if( temp_output_56_0_g64890 > 0.0 )
					ifLocalVar89_g64890 = temp_output_123_0_g64890;
					else if( temp_output_56_0_g64890 == 0.0 )
					ifLocalVar89_g64890 = temp_output_90_0_g64890;
					else if( temp_output_56_0_g64890 < 0.0 )
					ifLocalVar89_g64890 = temp_output_90_0_g64890;
					float3 temp_output_7_0_g64893 = frac( ( (ifLocalVar89_g64890).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g64893 = dot( temp_output_7_0_g64893 , ( (temp_output_7_0_g64893).yzx + 33.33 ) );
					float3 temp_output_12_0_g64893 = ( temp_output_7_0_g64893 + dotResult8_g64893 );
					float2 temp_output_597_27_g64889 = ( UV100_g64890 + frac( ( ( (temp_output_12_0_g64893).xx + (temp_output_12_0_g64893).yz ) * (temp_output_12_0_g64893).zy ) ) );
					float temp_output_67_0_g64890 = ( 1.0 - break55_g64890.x );
					float ifLocalVar61_g64890 = 0;
					if( temp_output_56_0_g64890 <= 0.0 )
					ifLocalVar61_g64890 = temp_output_67_0_g64890;
					else
					ifLocalVar61_g64890 = break55_g64890.x;
					float temp_output_597_29_g64889 = ifLocalVar61_g64890;
					float4 Output_2D293_g64889 = ( ( tex2D( _Sampler82964_g64869, temp_output_597_0_g64889, DDX631_g64889, DDY632_g64889 ) * temp_output_597_30_g64889 ) + ( tex2D( _Sampler82964_g64869, temp_output_597_26_g64889, DDX631_g64889, DDY632_g64889 ) * temp_output_597_28_g64889 ) + ( tex2D( _Sampler82964_g64869, temp_output_597_27_g64889, DDX631_g64889, DDY632_g64889 ) * temp_output_597_29_g64889 ) );
					float4 break31_g64889 = Output_2D293_g64889;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g64869 = ( 1.0 - break31_g64889.r );
					#else
					float staticSwitch1004_g64869 = ( 1.0 - staticSwitch845_g64869 );
					#endif
					float temp_output_19_0_g64919 = staticSwitch1004_g64869;
					float2 temp_output_5_0_g64879 = UV0A2420_g64869;
					float2 UV633_g64879 = temp_output_5_0_g64879;
					float2 UV100_g64880 = UV633_g64879;
					float2 temp_output_51_0_g64880 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g64880 * float2( 3.464,3.464 ) ) );
					float2 break55_g64880 = frac( temp_output_51_0_g64880 );
					float temp_output_56_0_g64880 = ( ( 1.0 - break55_g64880.x ) - break55_g64880.y );
					float2 temp_output_52_0_g64880 = floor( temp_output_51_0_g64880 );
					float2 temp_output_125_0_g64880 = ( temp_output_52_0_g64880 + float2( 1,1 ) );
					float2 ifLocalVar87_g64880 = 0;
					if( temp_output_56_0_g64880 > 0.0 )
					ifLocalVar87_g64880 = temp_output_52_0_g64880;
					else if( temp_output_56_0_g64880 == 0.0 )
					ifLocalVar87_g64880 = temp_output_125_0_g64880;
					else if( temp_output_56_0_g64880 < 0.0 )
					ifLocalVar87_g64880 = temp_output_125_0_g64880;
					float3 temp_output_7_0_g64881 = frac( ( (ifLocalVar87_g64880).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g64881 = dot( temp_output_7_0_g64881 , ( (temp_output_7_0_g64881).yzx + 33.33 ) );
					float3 temp_output_12_0_g64881 = ( temp_output_7_0_g64881 + dotResult8_g64881 );
					float2 temp_output_597_0_g64879 = ( UV100_g64880 + frac( ( ( (temp_output_12_0_g64881).xx + (temp_output_12_0_g64881).yz ) * (temp_output_12_0_g64881).zy ) ) );
					float2 DDX631_g64879 = ddx( temp_output_5_0_g64879 );
					float2 DDY632_g64879 = ddy( temp_output_5_0_g64879 );
					float Input_Scale617_g64879 = 1.5;
					float temp_output_65_0_g64880 = ( 0.0 - temp_output_56_0_g64880 );
					float ifLocalVar59_g64880 = 0;
					if( temp_output_56_0_g64880 <= 0.0 )
					ifLocalVar59_g64880 = temp_output_65_0_g64880;
					else
					ifLocalVar59_g64880 = temp_output_56_0_g64880;
					float temp_output_597_30_g64879 = ifLocalVar59_g64880;
					float2 temp_output_90_0_g64880 = ( temp_output_52_0_g64880 + float2( 0,1 ) );
					float2 temp_output_123_0_g64880 = ( temp_output_52_0_g64880 + float2( 1,0 ) );
					float2 ifLocalVar88_g64880 = 0;
					if( temp_output_56_0_g64880 > 0.0 )
					ifLocalVar88_g64880 = temp_output_90_0_g64880;
					else if( temp_output_56_0_g64880 == 0.0 )
					ifLocalVar88_g64880 = temp_output_123_0_g64880;
					else if( temp_output_56_0_g64880 < 0.0 )
					ifLocalVar88_g64880 = temp_output_123_0_g64880;
					float3 temp_output_7_0_g64882 = frac( ( (ifLocalVar88_g64880).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g64882 = dot( temp_output_7_0_g64882 , ( (temp_output_7_0_g64882).yzx + 33.33 ) );
					float3 temp_output_12_0_g64882 = ( temp_output_7_0_g64882 + dotResult8_g64882 );
					float2 temp_output_597_26_g64879 = ( UV100_g64880 + frac( ( ( (temp_output_12_0_g64882).xx + (temp_output_12_0_g64882).yz ) * (temp_output_12_0_g64882).zy ) ) );
					float temp_output_66_0_g64880 = ( 1.0 - break55_g64880.y );
					float ifLocalVar60_g64880 = 0;
					if( temp_output_56_0_g64880 <= 0.0 )
					ifLocalVar60_g64880 = temp_output_66_0_g64880;
					else
					ifLocalVar60_g64880 = break55_g64880.y;
					float temp_output_597_28_g64879 = ifLocalVar60_g64880;
					float2 ifLocalVar89_g64880 = 0;
					if( temp_output_56_0_g64880 > 0.0 )
					ifLocalVar89_g64880 = temp_output_123_0_g64880;
					else if( temp_output_56_0_g64880 == 0.0 )
					ifLocalVar89_g64880 = temp_output_90_0_g64880;
					else if( temp_output_56_0_g64880 < 0.0 )
					ifLocalVar89_g64880 = temp_output_90_0_g64880;
					float3 temp_output_7_0_g64883 = frac( ( (ifLocalVar89_g64880).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g64883 = dot( temp_output_7_0_g64883 , ( (temp_output_7_0_g64883).yzx + 33.33 ) );
					float3 temp_output_12_0_g64883 = ( temp_output_7_0_g64883 + dotResult8_g64883 );
					float2 temp_output_597_27_g64879 = ( UV100_g64880 + frac( ( ( (temp_output_12_0_g64883).xx + (temp_output_12_0_g64883).yz ) * (temp_output_12_0_g64883).zy ) ) );
					float temp_output_67_0_g64880 = ( 1.0 - break55_g64880.x );
					float ifLocalVar61_g64880 = 0;
					if( temp_output_56_0_g64880 <= 0.0 )
					ifLocalVar61_g64880 = temp_output_67_0_g64880;
					else
					ifLocalVar61_g64880 = break55_g64880.x;
					float temp_output_597_29_g64879 = ifLocalVar61_g64880;
					float3 Output_2D_Normal641_g64879 = ( ( UnpackScaleNormal( tex2D( _Sampler82965_g64869, temp_output_597_0_g64879, DDX631_g64879, DDY632_g64879 ), Input_Scale617_g64879 ) * temp_output_597_30_g64879 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g64869, temp_output_597_26_g64879, DDX631_g64879, DDY632_g64879 ), Input_Scale617_g64879 ) * temp_output_597_28_g64879 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g64869, temp_output_597_27_g64879, DDX631_g64879, DDY632_g64879 ), Input_Scale617_g64879 ) * float3( 0,0,0 ) * temp_output_597_29_g64879 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g64869 = Output_2D_Normal641_g64879;
					#else
					float3 staticSwitch1003_g64869 = UnpackScaleNormal( tex2D( _BumpMap, UV0A2420_g64869 ), 1.5 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g64869 = staticSwitch1003_g64869;
					#else
					float3 staticSwitch980_g64869 = float3( 0, 0, 1 );
					#endif
					float3 normalizeResult2878_g64869 = normalize( staticSwitch980_g64869 );
					float3 Normal_Map700_g64869 = normalizeResult2878_g64869;
					float3 ase_tangentWS = IN.ase_texcoord1.xyz;
					float3 ase_normalWS = IN.ase_texcoord2.xyz;
					float3 ase_bitangentWS = IN.ase_texcoord3.xyz;
					float3 tanToWorld0 = float3( ase_tangentWS.x, ase_bitangentWS.x, ase_normalWS.x );
					float3 tanToWorld1 = float3( ase_tangentWS.y, ase_bitangentWS.y, ase_normalWS.y );
					float3 tanToWorld2 = float3( ase_tangentWS.z, ase_bitangentWS.z, ase_normalWS.z );
					float3 tanNormal2504_g64869 = Normal_Map700_g64869;
					float3 worldNormal2504_g64869 = normalize( float3( dot( tanToWorld0, tanNormal2504_g64869 ), dot( tanToWorld1, tanNormal2504_g64869 ), dot( tanToWorld2, tanNormal2504_g64869 ) ) );
					float3 World_Normal2508_g64869 = worldNormal2504_g64869;
					float3 tanNormal2_g64919 = World_Normal2508_g64869;
					float3 worldNormal2_g64919 = float3( dot( tanToWorld0, tanNormal2_g64919 ), dot( tanToWorld1, tanNormal2_g64919 ), dot( tanToWorld2, tanNormal2_g64919 ) );
					float3 temp_output_3_0_g64919 = ddx( worldNormal2_g64919 );
					float dotResult5_g64919 = dot( temp_output_3_0_g64919 , temp_output_3_0_g64919 );
					float3 temp_output_4_0_g64919 = ddy( worldNormal2_g64919 );
					float dotResult6_g64919 = dot( temp_output_4_0_g64919 , temp_output_4_0_g64919 );
					#ifdef _USEGEOMETRICAA_ON
					float staticSwitch15_g64919 = min( temp_output_19_0_g64919, ( 1.0 - pow( saturate( max( dotResult5_g64919, dotResult6_g64919 ) ) , 0.25 ) ) );
					#else
					float staticSwitch15_g64919 = temp_output_19_0_g64919;
					#endif
					float Smoothness1399_g64869 = staticSwitch15_g64919;
					float Smoothness1_g64922 = Smoothness1399_g64869;
					float3 ase_positionWS = IN.ase_texcoord4.xyz;
					float3 ase_viewVectorWS = ( ( unity_OrthoParams.w == 0 ) ? _WorldSpaceCameraPos - ase_positionWS : UNITY_MATRIX_V[ 2 ].xyz );
					float3 ase_viewDirWS = normalize( ase_viewVectorWS );
					float3 View_Direction2511_g64869 = ase_viewDirWS;
					float3 ViewDir1_g64922 = View_Direction2511_g64869;
					float3 World_Position2505_g64869 = ase_positionWS;
					float3 WorldPos1_g64922 = World_Position2505_g64869;
					float3 WorldNormal1_g64922 = World_Normal2508_g64869;
					float4 temp_cast_2 = (Black1185_g64869).xxxx;
					float4 texCoord2426_g64869 = IN.ase_texcoord;
					texCoord2426_g64869.xy = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0B2361_g64869 = (texCoord2426_g64869).zw;
					float localBicubicPrepare2_g64878 = ( 0.0 );
					float2 Input_UV100_g64878 = UV0B2361_g64869;
					float2 UV2_g64878 = Input_UV100_g64878;
					float4 TexelSize2_g64878 = _Lightmap0_TexelSize;
					float2 UV02_g64878 = float2( 0,0 );
					float2 UV12_g64878 = float2( 0,0 );
					float2 UV22_g64878 = float2( 0,0 );
					float2 UV32_g64878 = float2( 0,0 );
					float W02_g64878 = 0;
					float W12_g64878 = 0;
					{
					{
					 UV2_g64878 = UV2_g64878 * TexelSize2_g64878.zw - 0.5;
					    float2 f = frac( UV2_g64878 );
					    UV2_g64878 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g64878.x - 0.5, UV2_g64878.x + 1.5, UV2_g64878.y - 0.5, UV2_g64878.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g64878.xyxy;
					    UV02_g64878 = off.xz;
					    UV12_g64878 = off.yz;
					    UV22_g64878 = off.xw;
					    UV32_g64878 = off.yw;
					    W02_g64878 = s.x / ( s.x + s.y );
					 W12_g64878 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g64878 = lerp( tex2D( _Lightmap0, UV32_g64878 ) , tex2D( _Lightmap0, UV22_g64878 ) , W02_g64878);
					float4 lerpResult45_g64878 = lerp( tex2D( _Lightmap0, UV12_g64878 ) , tex2D( _Lightmap0, UV02_g64878 ) , W02_g64878);
					float4 lerpResult44_g64878 = lerp( lerpResult46_g64878 , lerpResult45_g64878 , W12_g64878);
					float4 Output_2D_Auto131_g64878 = lerpResult44_g64878;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g64869 = Output_2D_Auto131_g64878;
					#else
					float4 staticSwitch1092_g64869 = float4( tex2D( _Lightmap0, UV0B2361_g64869 ).rgb , 0.0 );
					#endif
					float4 Lightmap_0925_g64869 = staticSwitch1092_g64869;
					float localBicubicPrepare2_g64876 = ( 0.0 );
					float2 Input_UV100_g64876 = UV0B2361_g64869;
					float2 UV2_g64876 = Input_UV100_g64876;
					float4 TexelSize2_g64876 = _Lightmap1_TexelSize;
					float2 UV02_g64876 = float2( 0,0 );
					float2 UV12_g64876 = float2( 0,0 );
					float2 UV22_g64876 = float2( 0,0 );
					float2 UV32_g64876 = float2( 0,0 );
					float W02_g64876 = 0;
					float W12_g64876 = 0;
					{
					{
					 UV2_g64876 = UV2_g64876 * TexelSize2_g64876.zw - 0.5;
					    float2 f = frac( UV2_g64876 );
					    UV2_g64876 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g64876.x - 0.5, UV2_g64876.x + 1.5, UV2_g64876.y - 0.5, UV2_g64876.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g64876.xyxy;
					    UV02_g64876 = off.xz;
					    UV12_g64876 = off.yz;
					    UV22_g64876 = off.xw;
					    UV32_g64876 = off.yw;
					    W02_g64876 = s.x / ( s.x + s.y );
					 W12_g64876 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g64876 = lerp( tex2D( _Lightmap1, UV32_g64876 ) , tex2D( _Lightmap1, UV22_g64876 ) , W02_g64876);
					float4 lerpResult45_g64876 = lerp( tex2D( _Lightmap1, UV12_g64876 ) , tex2D( _Lightmap1, UV02_g64876 ) , W02_g64876);
					float4 lerpResult44_g64876 = lerp( lerpResult46_g64876 , lerpResult45_g64876 , W12_g64876);
					float4 Output_2D_Auto131_g64876 = lerpResult44_g64876;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g64869 = Output_2D_Auto131_g64876;
					#else
					float4 staticSwitch1088_g64869 = tex2D( _Lightmap1, UV0B2361_g64869 );
					#endif
					float4 Lightmap_1956_g64869 = staticSwitch1088_g64869;
					float Lightmap_Lerp_Value969_g64869 = _UdonLightmapLerp;
					float4 lerpResult442_g64869 = lerp( Lightmap_0925_g64869 , Lightmap_1956_g64869 , Lightmap_Lerp_Value969_g64869);
					float4 Lightmap_Lerp932_g64869 = lerpResult442_g64869;
					float3 appendResult139_g64915 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 Normal_Map318_g64915 = Normal_Map700_g64869;
					float dotResult121_g64915 = dot( appendResult139_g64915 , Normal_Map318_g64915 );
					float temp_output_2_0_g64917 = saturate( dotResult121_g64915 );
					float localStochasticTiling2_g64900 = ( 0.0 );
					float2 UV2_g64900 = UV0B2361_g64869;
					float4 TexelSize2_g64900 = _UdonRNMX0_TexelSize;
					float4 Offsets2_g64900 = float4( 0,0,0,0 );
					float2 Weights2_g64900 = float2( 0,0 );
					{
					UV2_g64900 = UV2_g64900 * TexelSize2_g64900.zw - 0.5;
					float2 f = frac( UV2_g64900 );
					UV2_g64900 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g64900.x - 0.5, UV2_g64900.x + 1.5, UV2_g64900.y - 0.5, UV2_g64900.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g64900 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g64900.xyxy;
					Weights2_g64900 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g64899 = Offsets2_g64900;
					float4 Input_FetchOffsets197_g64901 = temp_output_1_34_g64899;
					float2 temp_output_1_54_g64899 = Weights2_g64900;
					float2 Input_FetchWeights200_g64901 = temp_output_1_54_g64899;
					float2 break187_g64901 = Input_FetchWeights200_g64901;
					float4 lerpResult181_g64901 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g64901).yw ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g64901).xw ) , break187_g64901.x);
					float4 lerpResult182_g64901 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g64901).yz ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g64901).xz ) , break187_g64901.x);
					float4 lerpResult176_g64901 = lerp( lerpResult181_g64901 , lerpResult182_g64901 , break187_g64901.y);
					float4 Output_Fetch2D_Auto202_g64901 = lerpResult176_g64901;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g64869 = Output_Fetch2D_Auto202_g64901;
					#else
					float4 staticSwitch1061_g64869 = tex2D( _UdonRNMX0, UV0B2361_g64869 );
					#endif
					float3 appendResult146_g64915 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g64915 = dot( appendResult146_g64915 , Normal_Map318_g64915 );
					float temp_output_2_0_g64916 = saturate( dotResult122_g64915 );
					float4 Input_FetchOffsets197_g64902 = temp_output_1_34_g64899;
					float2 Input_FetchWeights200_g64902 = temp_output_1_54_g64899;
					float2 break187_g64902 = Input_FetchWeights200_g64902;
					float4 lerpResult181_g64902 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g64902).yw ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g64902).xw ) , break187_g64902.x);
					float4 lerpResult182_g64902 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g64902).yz ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g64902).xz ) , break187_g64902.x);
					float4 lerpResult176_g64902 = lerp( lerpResult181_g64902 , lerpResult182_g64902 , break187_g64902.y);
					float4 Output_Fetch2D_Auto202_g64902 = lerpResult176_g64902;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g64869 = Output_Fetch2D_Auto202_g64902;
					#else
					float4 staticSwitch1062_g64869 = tex2D( _UdonRNMY0, UV0B2361_g64869 );
					#endif
					float3 appendResult149_g64915 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g64915 = dot( appendResult149_g64915 , Normal_Map318_g64915 );
					float temp_output_2_0_g64918 = saturate( dotResult120_g64915 );
					float4 Input_FetchOffsets197_g64903 = temp_output_1_34_g64899;
					float2 Input_FetchWeights200_g64903 = temp_output_1_54_g64899;
					float2 break187_g64903 = Input_FetchWeights200_g64903;
					float4 lerpResult181_g64903 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g64903).yw ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g64903).xw ) , break187_g64903.x);
					float4 lerpResult182_g64903 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g64903).yz ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g64903).xz ) , break187_g64903.x);
					float4 lerpResult176_g64903 = lerp( lerpResult181_g64903 , lerpResult182_g64903 , break187_g64903.y);
					float4 Output_Fetch2D_Auto202_g64903 = lerpResult176_g64903;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g64869 = Output_Fetch2D_Auto202_g64903;
					#else
					float4 staticSwitch1063_g64869 = tex2D( _UdonRNMZ0, UV0B2361_g64869 );
					#endif
					float4 temp_output_24_0_g64915 = ( ( ( ( temp_output_2_0_g64917 * temp_output_2_0_g64917 ) * staticSwitch1061_g64869 ) + ( ( temp_output_2_0_g64916 * temp_output_2_0_g64916 ) * staticSwitch1062_g64869 ) ) + ( ( temp_output_2_0_g64918 * temp_output_2_0_g64918 ) * staticSwitch1063_g64869 ) );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch372_g64915 = ( temp_output_24_0_g64915 * 1.2 );
					#else
					float4 staticSwitch372_g64915 = temp_output_24_0_g64915;
					#endif
					float4 RNM_0926_g64869 = staticSwitch372_g64915;
					float3 appendResult139_g64911 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 Normal_Map318_g64911 = Normal_Map700_g64869;
					float dotResult121_g64911 = dot( appendResult139_g64911 , Normal_Map318_g64911 );
					float temp_output_2_0_g64913 = saturate( dotResult121_g64911 );
					float localStochasticTiling2_g64871 = ( 0.0 );
					float2 UV2_g64871 = UV0B2361_g64869;
					float4 TexelSize2_g64871 = _UdonRNMX1_TexelSize;
					float4 Offsets2_g64871 = float4( 0,0,0,0 );
					float2 Weights2_g64871 = float2( 0,0 );
					{
					UV2_g64871 = UV2_g64871 * TexelSize2_g64871.zw - 0.5;
					float2 f = frac( UV2_g64871 );
					UV2_g64871 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g64871.x - 0.5, UV2_g64871.x + 1.5, UV2_g64871.y - 0.5, UV2_g64871.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g64871 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g64871.xyxy;
					Weights2_g64871 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g64870 = Offsets2_g64871;
					float4 Input_FetchOffsets197_g64872 = temp_output_1_34_g64870;
					float2 temp_output_1_54_g64870 = Weights2_g64871;
					float2 Input_FetchWeights200_g64872 = temp_output_1_54_g64870;
					float2 break187_g64872 = Input_FetchWeights200_g64872;
					float4 lerpResult181_g64872 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g64872).yw ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g64872).xw ) , break187_g64872.x);
					float4 lerpResult182_g64872 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g64872).yz ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g64872).xz ) , break187_g64872.x);
					float4 lerpResult176_g64872 = lerp( lerpResult181_g64872 , lerpResult182_g64872 , break187_g64872.y);
					float4 Output_Fetch2D_Auto202_g64872 = lerpResult176_g64872;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g64869 = Output_Fetch2D_Auto202_g64872;
					#else
					float4 staticSwitch1087_g64869 = tex2D( _UdonRNMX1, UV0B2361_g64869 );
					#endif
					float3 appendResult146_g64911 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g64911 = dot( appendResult146_g64911 , Normal_Map318_g64911 );
					float temp_output_2_0_g64912 = saturate( dotResult122_g64911 );
					float4 Input_FetchOffsets197_g64873 = temp_output_1_34_g64870;
					float2 Input_FetchWeights200_g64873 = temp_output_1_54_g64870;
					float2 break187_g64873 = Input_FetchWeights200_g64873;
					float4 lerpResult181_g64873 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g64873).yw ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g64873).xw ) , break187_g64873.x);
					float4 lerpResult182_g64873 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g64873).yz ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g64873).xz ) , break187_g64873.x);
					float4 lerpResult176_g64873 = lerp( lerpResult181_g64873 , lerpResult182_g64873 , break187_g64873.y);
					float4 Output_Fetch2D_Auto202_g64873 = lerpResult176_g64873;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g64869 = Output_Fetch2D_Auto202_g64873;
					#else
					float4 staticSwitch1083_g64869 = tex2D( _UdonRNMY1, UV0B2361_g64869 );
					#endif
					float3 appendResult149_g64911 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g64911 = dot( appendResult149_g64911 , Normal_Map318_g64911 );
					float temp_output_2_0_g64914 = saturate( dotResult120_g64911 );
					float4 Input_FetchOffsets197_g64874 = temp_output_1_34_g64870;
					float2 Input_FetchWeights200_g64874 = temp_output_1_54_g64870;
					float2 break187_g64874 = Input_FetchWeights200_g64874;
					float4 lerpResult181_g64874 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g64874).yw ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g64874).xw ) , break187_g64874.x);
					float4 lerpResult182_g64874 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g64874).yz ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g64874).xz ) , break187_g64874.x);
					float4 lerpResult176_g64874 = lerp( lerpResult181_g64874 , lerpResult182_g64874 , break187_g64874.y);
					float4 Output_Fetch2D_Auto202_g64874 = lerpResult176_g64874;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g64869 = Output_Fetch2D_Auto202_g64874;
					#else
					float4 staticSwitch1084_g64869 = tex2D( _UdonRNMZ1, UV0B2361_g64869 );
					#endif
					float4 temp_output_24_0_g64911 = ( ( ( ( temp_output_2_0_g64913 * temp_output_2_0_g64913 ) * staticSwitch1087_g64869 ) + ( ( temp_output_2_0_g64912 * temp_output_2_0_g64912 ) * staticSwitch1083_g64869 ) ) + ( ( temp_output_2_0_g64914 * temp_output_2_0_g64914 ) * staticSwitch1084_g64869 ) );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch372_g64911 = ( temp_output_24_0_g64911 * 1.2 );
					#else
					float4 staticSwitch372_g64911 = temp_output_24_0_g64911;
					#endif
					float4 RNM_11081_g64869 = staticSwitch372_g64911;
					float4 lerpResult953_g64869 = lerp( RNM_0926_g64869 , RNM_11081_g64869 , Lightmap_Lerp_Value969_g64869);
					float4 RNM_Lerp950_g64869 = lerpResult953_g64869;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g64869 = temp_cast_2;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g64869 = Lightmap_0925_g64869;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g64869 = Lightmap_Lerp932_g64869;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g64869 = RNM_0926_g64869;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g64869 = RNM_Lerp950_g64869;
					#else
					float4 staticSwitch1014_g64869 = temp_cast_2;
					#endif
					float3 Lightmap46_g64869 = (staticSwitch1014_g64869).rgb;
					float dotResult9_g64921 = dot( float3( 0.212673, 0.715152, 0.072175 ) , Lightmap46_g64869 );
					float smoothstepResult2_g64921 = smoothstep( 0.0 , 0.04 , dotResult9_g64921);
					float Lightmap_Mask3067_g64869 = smoothstepResult2_g64921;
					float LightmapMask1_g64922 = Lightmap_Mask3067_g64869;
					float3 localIndirectSpecular1_g64922 = IndirectSpecular( Color1_g64922 , Metallic1_g64922 , Smoothness1_g64922 , ViewDir1_g64922 , WorldPos1_g64922 , WorldNormal1_g64922 , LightmapMask1_g64922 );
					#ifdef _INDIRECTSPECULARS_ON
					float3 staticSwitch2971_g64869 = localIndirectSpecular1_g64922;
					#else
					float3 staticSwitch2971_g64869 = temp_cast_1;
					#endif
					float3 Indirect_Specular1419_g64869 = staticSwitch2971_g64869;
					float3 temp_cast_4 = (Black1185_g64869).xxx;
					float3 Color97_g64923 = oAlbedo6_g64869;
					float Metallic97_g64923 = Metallic1239_g64869;
					float Smoothness97_g64923 = Smoothness1399_g64869;
					float3 ViewDir97_g64923 = View_Direction2511_g64869;
					float3 WorldPos97_g64923 = World_Position2505_g64869;
					float3 WorldNormal97_g64923 = World_Normal2508_g64869;
					float White38_g64869 = 1.0;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float staticSwitch3085_g64869 = White38_g64869;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float staticSwitch3085_g64869 = Lightmap_Mask3067_g64869;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float staticSwitch3085_g64869 = Lightmap_Mask3067_g64869;
					#elif defined( _LIGHTMAPMODE_RNM )
					float staticSwitch3085_g64869 = Lightmap_Mask3067_g64869;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float staticSwitch3085_g64869 = Lightmap_Mask3067_g64869;
					#else
					float staticSwitch3085_g64869 = White38_g64869;
					#endif
					float LightmapMask97_g64923 = staticSwitch3085_g64869;
					float3 localDirectSpecular97_g64923 = DirectSpecular( Color97_g64923 , Metallic97_g64923 , Smoothness97_g64923 , ViewDir97_g64923 , WorldPos97_g64923 , WorldNormal97_g64923 , LightmapMask97_g64923 );
					#ifdef _DIRECTSPECULAR_ON
					float3 staticSwitch2969_g64869 = localDirectSpecular97_g64923;
					#else
					float3 staticSwitch2969_g64869 = temp_cast_4;
					#endif
					float3 Direct_Specular2560_g64869 = staticSwitch2969_g64869;
					float3 aAlbedo1466_g64869 = ( temp_output_2532_0_g64869 * ( 1.0 - Metallic1239_g64869 ) );
					float3 temp_output_1252_0_g64869 = ( aAlbedo1466_g64869 * Lightmap46_g64869 );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch1_g64920 = float4( ( temp_output_1252_0_g64869 + Emission86_g64869 + Indirect_Specular1419_g64869 ) , 0.0 );
					#else
					float4 staticSwitch1_g64920 = float4( ( Emission86_g64869 + Indirect_Specular1419_g64869 + Direct_Specular2560_g64869 + temp_output_1252_0_g64869 ) , 0.0 );
					#endif
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1181_g64869 = float4( Lightmap46_g64869 , 0.0 );
					#else
					float4 staticSwitch1181_g64869 = staticSwitch1_g64920;
					#endif
					float4 Color357_g64909 = staticSwitch1181_g64869;
					float4 LUT51_g64909 = tex3D( _LUT, ( ( log10( ( ( (Color357_g64909).xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 ) );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch359_g64909 = LUT51_g64909;
					#else
					float4 staticSwitch359_g64909 = Color357_g64909;
					#endif
					

					float4 Color = staticSwitch359_g64909;
					float Alpha = 1;
					half AlphaClipThreshold = 0.5;
					half AlphaClipThresholdShadow = 0.5;

					#if defined( ASE_DEPTH_WRITE_ON )
						outputDepth = IN.pos.z;
					#endif

					#ifdef _ALPHATEST_ON
						clip( Alpha - AlphaClipThreshold );
					#endif

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

				

				struct appdata
				{
					float4 vertex : POSITION;
					half3 normal : NORMAL;
					
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct v2f
				{
					V2F_SHADOW_CASTER;
					
					UNITY_VERTEX_INPUT_INSTANCE_ID
					UNITY_VERTEX_OUTPUT_STEREO
				};

				#ifdef UNITY_STANDARD_USE_DITHER_MASK
					sampler3D _DitherMaskLOD;
				#endif
				#ifdef ASE_TESSELLATION
					float _TessPhongStrength;
					float _TessValue;
					float _TessMin;
					float _TessMax;
					float _TessEdgeLength;
					float _TessMaxDisp;
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


				
				v2f vert( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID( v );
					v2f o;
					UNITY_INITIALIZE_OUTPUT( v2f, o );
					UNITY_TRANSFER_INSTANCE_ID( v, o );
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );

					

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

					TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
					return o;
				}

				half4 frag( v2f IN 
							#if defined( ASE_DEPTH_WRITE_ON )
								, out float outputDepth : SV_Depth
							#endif
							) : SV_Target
				{
					UNITY_SETUP_INSTANCE_ID(IN);

					#ifdef LOD_FADE_CROSSFADE
						UNITY_APPLY_DITHER_CROSSFADE(IN.pos.xy);
					#endif

					

					float Alpha = 1;
					half AlphaClipThreshold = 0.5;
					half AlphaClipThresholdShadow = 0.5;

					#if defined( ASE_DEPTH_WRITE_ON )
						outputDepth = IN.pos.z;
					#endif

					#ifdef _ALPHATEST_SHADOW_ON
						if (unity_LightShadowBias.z != 0.0)
							clip(Alpha - AlphaClipThresholdShadow);
						#ifdef _ALPHATEST_ON
						else
							clip(Alpha - AlphaClipThreshold);
						#endif
					#else
						#ifdef _ALPHATEST_ON
							clip(Alpha - AlphaClipThreshold);
						#endif
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
}
/*ASEBEGIN
Version=19909
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;6293;-64,-1280;Inherit;False;Meenphie;0;;64869;b3ba55a08dd6b49c7be16c6f35cf2033;6,1008,0,2632,0,2635,0,2619,0,2636,0,2670,0;0;4;FLOAT4;624;FLOAT;156;FLOAT;427;FLOAT;1024
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;6274;256,-1280;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;7;Meenphie/Standard/Opaque;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;7;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;False;;True;1;RenderType=Opaque=RenderType;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;5;Alpha Clipping;0;0;  Use Shadow Threshold;0;0;Cast Shadows;1;0;Write Depth;0;0;Vertex Position;1;0;0;2;True;True;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;6275;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;0770190933193b94aaa3065e307002fa;True;ShadowCaster;0;1;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;False;;True;1;RenderType=Opaque=RenderType;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
WireConnection;6274;0;6293;624
ASEEND*/
//CHKSM=30A87107DAF063ADAF8F9C569E55403D8E74A745