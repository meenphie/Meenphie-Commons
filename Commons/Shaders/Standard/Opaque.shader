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
		

		

		Tags { "RenderType"="Opaque" "Queue"="Geometry" }

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
				sampler2D _Sampler82968_g62479;
				uniform float _EmissionIntensity;
				uniform half4 _Color;
				uniform sampler2D _MainTex;
				sampler2D _Sampler82966_g62479;
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				sampler2D _Sampler82967_g62479;
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				sampler2D _Sampler82964_g62479;
				uniform sampler2D _BumpMap;
				sampler2D _Sampler82965_g62479;
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


				float3 LightProbes3146_g62479( float3 Normal )
				{
					return ShadeSH9(float4(normalize(Normal), 1.0));
				}
				

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

					float2 texCoord2357_g62479 = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0A2420_g62479 = texCoord2357_g62479;
					float2 temp_output_5_0_g62504 = UV0A2420_g62479;
					float2 UV633_g62504 = temp_output_5_0_g62504;
					float2 UV100_g62505 = UV633_g62504;
					float2 temp_output_51_0_g62505 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g62505 * float2( 3.464,3.464 ) ) );
					float2 break55_g62505 = frac( temp_output_51_0_g62505 );
					float temp_output_56_0_g62505 = ( ( 1.0 - break55_g62505.x ) - break55_g62505.y );
					float2 temp_output_52_0_g62505 = floor( temp_output_51_0_g62505 );
					float2 temp_output_125_0_g62505 = ( temp_output_52_0_g62505 + float2( 1,1 ) );
					float2 ifLocalVar87_g62505 = 0;
					if( temp_output_56_0_g62505 > 0.0 )
					ifLocalVar87_g62505 = temp_output_52_0_g62505;
					else if( temp_output_56_0_g62505 == 0.0 )
					ifLocalVar87_g62505 = temp_output_125_0_g62505;
					else if( temp_output_56_0_g62505 < 0.0 )
					ifLocalVar87_g62505 = temp_output_125_0_g62505;
					float3 temp_output_7_0_g62506 = frac( ( (ifLocalVar87_g62505).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g62506 = dot( temp_output_7_0_g62506 , ( (temp_output_7_0_g62506).yzx + 33.33 ) );
					float3 temp_output_12_0_g62506 = ( temp_output_7_0_g62506 + dotResult8_g62506 );
					float2 temp_output_597_0_g62504 = ( UV100_g62505 + frac( ( ( (temp_output_12_0_g62506).xx + (temp_output_12_0_g62506).yz ) * (temp_output_12_0_g62506).zy ) ) );
					float2 DDX631_g62504 = ddx( temp_output_5_0_g62504 );
					float2 DDY632_g62504 = ddy( temp_output_5_0_g62504 );
					float temp_output_65_0_g62505 = ( 0.0 - temp_output_56_0_g62505 );
					float ifLocalVar59_g62505 = 0;
					if( temp_output_56_0_g62505 <= 0.0 )
					ifLocalVar59_g62505 = temp_output_65_0_g62505;
					else
					ifLocalVar59_g62505 = temp_output_56_0_g62505;
					float temp_output_597_30_g62504 = ifLocalVar59_g62505;
					float2 temp_output_90_0_g62505 = ( temp_output_52_0_g62505 + float2( 0,1 ) );
					float2 temp_output_123_0_g62505 = ( temp_output_52_0_g62505 + float2( 1,0 ) );
					float2 ifLocalVar88_g62505 = 0;
					if( temp_output_56_0_g62505 > 0.0 )
					ifLocalVar88_g62505 = temp_output_90_0_g62505;
					else if( temp_output_56_0_g62505 == 0.0 )
					ifLocalVar88_g62505 = temp_output_123_0_g62505;
					else if( temp_output_56_0_g62505 < 0.0 )
					ifLocalVar88_g62505 = temp_output_123_0_g62505;
					float3 temp_output_7_0_g62507 = frac( ( (ifLocalVar88_g62505).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g62507 = dot( temp_output_7_0_g62507 , ( (temp_output_7_0_g62507).yzx + 33.33 ) );
					float3 temp_output_12_0_g62507 = ( temp_output_7_0_g62507 + dotResult8_g62507 );
					float2 temp_output_597_26_g62504 = ( UV100_g62505 + frac( ( ( (temp_output_12_0_g62507).xx + (temp_output_12_0_g62507).yz ) * (temp_output_12_0_g62507).zy ) ) );
					float temp_output_66_0_g62505 = ( 1.0 - break55_g62505.y );
					float ifLocalVar60_g62505 = 0;
					if( temp_output_56_0_g62505 <= 0.0 )
					ifLocalVar60_g62505 = temp_output_66_0_g62505;
					else
					ifLocalVar60_g62505 = break55_g62505.y;
					float temp_output_597_28_g62504 = ifLocalVar60_g62505;
					float2 ifLocalVar89_g62505 = 0;
					if( temp_output_56_0_g62505 > 0.0 )
					ifLocalVar89_g62505 = temp_output_123_0_g62505;
					else if( temp_output_56_0_g62505 == 0.0 )
					ifLocalVar89_g62505 = temp_output_90_0_g62505;
					else if( temp_output_56_0_g62505 < 0.0 )
					ifLocalVar89_g62505 = temp_output_90_0_g62505;
					float3 temp_output_7_0_g62508 = frac( ( (ifLocalVar89_g62505).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g62508 = dot( temp_output_7_0_g62508 , ( (temp_output_7_0_g62508).yzx + 33.33 ) );
					float3 temp_output_12_0_g62508 = ( temp_output_7_0_g62508 + dotResult8_g62508 );
					float2 temp_output_597_27_g62504 = ( UV100_g62505 + frac( ( ( (temp_output_12_0_g62508).xx + (temp_output_12_0_g62508).yz ) * (temp_output_12_0_g62508).zy ) ) );
					float temp_output_67_0_g62505 = ( 1.0 - break55_g62505.x );
					float ifLocalVar61_g62505 = 0;
					if( temp_output_56_0_g62505 <= 0.0 )
					ifLocalVar61_g62505 = temp_output_67_0_g62505;
					else
					ifLocalVar61_g62505 = break55_g62505.x;
					float temp_output_597_29_g62504 = ifLocalVar61_g62505;
					float4 Output_2D293_g62504 = ( ( tex2D( _Sampler82968_g62479, temp_output_597_0_g62504, DDX631_g62504, DDY632_g62504 ) * temp_output_597_30_g62504 ) + ( tex2D( _Sampler82968_g62479, temp_output_597_26_g62504, DDX631_g62504, DDY632_g62504 ) * temp_output_597_28_g62504 ) + ( tex2D( _Sampler82968_g62479, temp_output_597_27_g62504, DDX631_g62504, DDY632_g62504 ) * temp_output_597_29_g62504 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g62479 = Output_2D293_g62504;
					#else
					float4 staticSwitch1006_g62479 = tex2D( _EmissionMap, UV0A2420_g62479 );
					#endif
					float3 temp_output_2531_0_g62479 = (( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g62479 * _EmissionIntensity )).rgb;
					float3 Emission86_g62479 = temp_output_2531_0_g62479;
					float Black1185_g62479 = 0.0;
					float3 temp_cast_1 = (Black1185_g62479).xxx;
					#ifdef _MAINTEX
					float4 staticSwitch1549_g62479 = tex2D( _MainTex, UV0A2420_g62479 );
					#else
					float4 staticSwitch1549_g62479 = _Color;
					#endif
					float2 temp_output_5_0_g62494 = UV0A2420_g62479;
					float2 UV633_g62494 = temp_output_5_0_g62494;
					float2 UV100_g62495 = UV633_g62494;
					float2 temp_output_51_0_g62495 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g62495 * float2( 3.464,3.464 ) ) );
					float2 break55_g62495 = frac( temp_output_51_0_g62495 );
					float temp_output_56_0_g62495 = ( ( 1.0 - break55_g62495.x ) - break55_g62495.y );
					float2 temp_output_52_0_g62495 = floor( temp_output_51_0_g62495 );
					float2 temp_output_125_0_g62495 = ( temp_output_52_0_g62495 + float2( 1,1 ) );
					float2 ifLocalVar87_g62495 = 0;
					if( temp_output_56_0_g62495 > 0.0 )
					ifLocalVar87_g62495 = temp_output_52_0_g62495;
					else if( temp_output_56_0_g62495 == 0.0 )
					ifLocalVar87_g62495 = temp_output_125_0_g62495;
					else if( temp_output_56_0_g62495 < 0.0 )
					ifLocalVar87_g62495 = temp_output_125_0_g62495;
					float3 temp_output_7_0_g62496 = frac( ( (ifLocalVar87_g62495).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g62496 = dot( temp_output_7_0_g62496 , ( (temp_output_7_0_g62496).yzx + 33.33 ) );
					float3 temp_output_12_0_g62496 = ( temp_output_7_0_g62496 + dotResult8_g62496 );
					float2 temp_output_597_0_g62494 = ( UV100_g62495 + frac( ( ( (temp_output_12_0_g62496).xx + (temp_output_12_0_g62496).yz ) * (temp_output_12_0_g62496).zy ) ) );
					float2 DDX631_g62494 = ddx( temp_output_5_0_g62494 );
					float2 DDY632_g62494 = ddy( temp_output_5_0_g62494 );
					float temp_output_65_0_g62495 = ( 0.0 - temp_output_56_0_g62495 );
					float ifLocalVar59_g62495 = 0;
					if( temp_output_56_0_g62495 <= 0.0 )
					ifLocalVar59_g62495 = temp_output_65_0_g62495;
					else
					ifLocalVar59_g62495 = temp_output_56_0_g62495;
					float temp_output_597_30_g62494 = ifLocalVar59_g62495;
					float2 temp_output_90_0_g62495 = ( temp_output_52_0_g62495 + float2( 0,1 ) );
					float2 temp_output_123_0_g62495 = ( temp_output_52_0_g62495 + float2( 1,0 ) );
					float2 ifLocalVar88_g62495 = 0;
					if( temp_output_56_0_g62495 > 0.0 )
					ifLocalVar88_g62495 = temp_output_90_0_g62495;
					else if( temp_output_56_0_g62495 == 0.0 )
					ifLocalVar88_g62495 = temp_output_123_0_g62495;
					else if( temp_output_56_0_g62495 < 0.0 )
					ifLocalVar88_g62495 = temp_output_123_0_g62495;
					float3 temp_output_7_0_g62497 = frac( ( (ifLocalVar88_g62495).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g62497 = dot( temp_output_7_0_g62497 , ( (temp_output_7_0_g62497).yzx + 33.33 ) );
					float3 temp_output_12_0_g62497 = ( temp_output_7_0_g62497 + dotResult8_g62497 );
					float2 temp_output_597_26_g62494 = ( UV100_g62495 + frac( ( ( (temp_output_12_0_g62497).xx + (temp_output_12_0_g62497).yz ) * (temp_output_12_0_g62497).zy ) ) );
					float temp_output_66_0_g62495 = ( 1.0 - break55_g62495.y );
					float ifLocalVar60_g62495 = 0;
					if( temp_output_56_0_g62495 <= 0.0 )
					ifLocalVar60_g62495 = temp_output_66_0_g62495;
					else
					ifLocalVar60_g62495 = break55_g62495.y;
					float temp_output_597_28_g62494 = ifLocalVar60_g62495;
					float2 ifLocalVar89_g62495 = 0;
					if( temp_output_56_0_g62495 > 0.0 )
					ifLocalVar89_g62495 = temp_output_123_0_g62495;
					else if( temp_output_56_0_g62495 == 0.0 )
					ifLocalVar89_g62495 = temp_output_90_0_g62495;
					else if( temp_output_56_0_g62495 < 0.0 )
					ifLocalVar89_g62495 = temp_output_90_0_g62495;
					float3 temp_output_7_0_g62498 = frac( ( (ifLocalVar89_g62495).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g62498 = dot( temp_output_7_0_g62498 , ( (temp_output_7_0_g62498).yzx + 33.33 ) );
					float3 temp_output_12_0_g62498 = ( temp_output_7_0_g62498 + dotResult8_g62498 );
					float2 temp_output_597_27_g62494 = ( UV100_g62495 + frac( ( ( (temp_output_12_0_g62498).xx + (temp_output_12_0_g62498).yz ) * (temp_output_12_0_g62498).zy ) ) );
					float temp_output_67_0_g62495 = ( 1.0 - break55_g62495.x );
					float ifLocalVar61_g62495 = 0;
					if( temp_output_56_0_g62495 <= 0.0 )
					ifLocalVar61_g62495 = temp_output_67_0_g62495;
					else
					ifLocalVar61_g62495 = break55_g62495.x;
					float temp_output_597_29_g62494 = ifLocalVar61_g62495;
					float4 Output_2D293_g62494 = ( ( tex2D( _Sampler82966_g62479, temp_output_597_0_g62494, DDX631_g62494, DDY632_g62494 ) * temp_output_597_30_g62494 ) + ( tex2D( _Sampler82966_g62479, temp_output_597_26_g62494, DDX631_g62494, DDY632_g62494 ) * temp_output_597_28_g62494 ) + ( tex2D( _Sampler82966_g62479, temp_output_597_27_g62494, DDX631_g62494, DDY632_g62494 ) * temp_output_597_29_g62494 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g62479 = Output_2D293_g62494;
					#else
					float4 staticSwitch1001_g62479 = staticSwitch1549_g62479;
					#endif
					float3 temp_output_2532_0_g62479 = (staticSwitch1001_g62479).rgb;
					float3 oAlbedo6_g62479 = temp_output_2532_0_g62479;
					float3 Color1_g62538 = oAlbedo6_g62479;
					#ifdef _METALLICMAP
					float staticSwitch846_g62479 = tex2D( _MetallicMap, UV0A2420_g62479 ).r;
					#else
					float staticSwitch846_g62479 = _Metallic;
					#endif
					float2 temp_output_5_0_g62514 = UV0A2420_g62479;
					float2 UV633_g62514 = temp_output_5_0_g62514;
					float2 UV100_g62515 = UV633_g62514;
					float2 temp_output_51_0_g62515 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g62515 * float2( 3.464,3.464 ) ) );
					float2 break55_g62515 = frac( temp_output_51_0_g62515 );
					float temp_output_56_0_g62515 = ( ( 1.0 - break55_g62515.x ) - break55_g62515.y );
					float2 temp_output_52_0_g62515 = floor( temp_output_51_0_g62515 );
					float2 temp_output_125_0_g62515 = ( temp_output_52_0_g62515 + float2( 1,1 ) );
					float2 ifLocalVar87_g62515 = 0;
					if( temp_output_56_0_g62515 > 0.0 )
					ifLocalVar87_g62515 = temp_output_52_0_g62515;
					else if( temp_output_56_0_g62515 == 0.0 )
					ifLocalVar87_g62515 = temp_output_125_0_g62515;
					else if( temp_output_56_0_g62515 < 0.0 )
					ifLocalVar87_g62515 = temp_output_125_0_g62515;
					float3 temp_output_7_0_g62516 = frac( ( (ifLocalVar87_g62515).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g62516 = dot( temp_output_7_0_g62516 , ( (temp_output_7_0_g62516).yzx + 33.33 ) );
					float3 temp_output_12_0_g62516 = ( temp_output_7_0_g62516 + dotResult8_g62516 );
					float2 temp_output_597_0_g62514 = ( UV100_g62515 + frac( ( ( (temp_output_12_0_g62516).xx + (temp_output_12_0_g62516).yz ) * (temp_output_12_0_g62516).zy ) ) );
					float2 DDX631_g62514 = ddx( temp_output_5_0_g62514 );
					float2 DDY632_g62514 = ddy( temp_output_5_0_g62514 );
					float temp_output_65_0_g62515 = ( 0.0 - temp_output_56_0_g62515 );
					float ifLocalVar59_g62515 = 0;
					if( temp_output_56_0_g62515 <= 0.0 )
					ifLocalVar59_g62515 = temp_output_65_0_g62515;
					else
					ifLocalVar59_g62515 = temp_output_56_0_g62515;
					float temp_output_597_30_g62514 = ifLocalVar59_g62515;
					float2 temp_output_90_0_g62515 = ( temp_output_52_0_g62515 + float2( 0,1 ) );
					float2 temp_output_123_0_g62515 = ( temp_output_52_0_g62515 + float2( 1,0 ) );
					float2 ifLocalVar88_g62515 = 0;
					if( temp_output_56_0_g62515 > 0.0 )
					ifLocalVar88_g62515 = temp_output_90_0_g62515;
					else if( temp_output_56_0_g62515 == 0.0 )
					ifLocalVar88_g62515 = temp_output_123_0_g62515;
					else if( temp_output_56_0_g62515 < 0.0 )
					ifLocalVar88_g62515 = temp_output_123_0_g62515;
					float3 temp_output_7_0_g62517 = frac( ( (ifLocalVar88_g62515).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g62517 = dot( temp_output_7_0_g62517 , ( (temp_output_7_0_g62517).yzx + 33.33 ) );
					float3 temp_output_12_0_g62517 = ( temp_output_7_0_g62517 + dotResult8_g62517 );
					float2 temp_output_597_26_g62514 = ( UV100_g62515 + frac( ( ( (temp_output_12_0_g62517).xx + (temp_output_12_0_g62517).yz ) * (temp_output_12_0_g62517).zy ) ) );
					float temp_output_66_0_g62515 = ( 1.0 - break55_g62515.y );
					float ifLocalVar60_g62515 = 0;
					if( temp_output_56_0_g62515 <= 0.0 )
					ifLocalVar60_g62515 = temp_output_66_0_g62515;
					else
					ifLocalVar60_g62515 = break55_g62515.y;
					float temp_output_597_28_g62514 = ifLocalVar60_g62515;
					float2 ifLocalVar89_g62515 = 0;
					if( temp_output_56_0_g62515 > 0.0 )
					ifLocalVar89_g62515 = temp_output_123_0_g62515;
					else if( temp_output_56_0_g62515 == 0.0 )
					ifLocalVar89_g62515 = temp_output_90_0_g62515;
					else if( temp_output_56_0_g62515 < 0.0 )
					ifLocalVar89_g62515 = temp_output_90_0_g62515;
					float3 temp_output_7_0_g62518 = frac( ( (ifLocalVar89_g62515).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g62518 = dot( temp_output_7_0_g62518 , ( (temp_output_7_0_g62518).yzx + 33.33 ) );
					float3 temp_output_12_0_g62518 = ( temp_output_7_0_g62518 + dotResult8_g62518 );
					float2 temp_output_597_27_g62514 = ( UV100_g62515 + frac( ( ( (temp_output_12_0_g62518).xx + (temp_output_12_0_g62518).yz ) * (temp_output_12_0_g62518).zy ) ) );
					float temp_output_67_0_g62515 = ( 1.0 - break55_g62515.x );
					float ifLocalVar61_g62515 = 0;
					if( temp_output_56_0_g62515 <= 0.0 )
					ifLocalVar61_g62515 = temp_output_67_0_g62515;
					else
					ifLocalVar61_g62515 = break55_g62515.x;
					float temp_output_597_29_g62514 = ifLocalVar61_g62515;
					float4 Output_2D293_g62514 = ( ( tex2D( _Sampler82967_g62479, temp_output_597_0_g62514, DDX631_g62514, DDY632_g62514 ) * temp_output_597_30_g62514 ) + ( tex2D( _Sampler82967_g62479, temp_output_597_26_g62514, DDX631_g62514, DDY632_g62514 ) * temp_output_597_28_g62514 ) + ( tex2D( _Sampler82967_g62479, temp_output_597_27_g62514, DDX631_g62514, DDY632_g62514 ) * temp_output_597_29_g62514 ) );
					float4 break31_g62514 = Output_2D293_g62514;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g62479 = break31_g62514.r;
					#else
					float staticSwitch1005_g62479 = staticSwitch846_g62479;
					#endif
					float Metallic1239_g62479 = staticSwitch1005_g62479;
					float Metallic1_g62538 = Metallic1239_g62479;
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g62479 = tex2D( _GlossinessMap, UV0A2420_g62479 ).r;
					#else
					float staticSwitch845_g62479 = _Glossiness;
					#endif
					float2 temp_output_5_0_g62499 = UV0A2420_g62479;
					float2 UV633_g62499 = temp_output_5_0_g62499;
					float2 UV100_g62500 = UV633_g62499;
					float2 temp_output_51_0_g62500 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g62500 * float2( 3.464,3.464 ) ) );
					float2 break55_g62500 = frac( temp_output_51_0_g62500 );
					float temp_output_56_0_g62500 = ( ( 1.0 - break55_g62500.x ) - break55_g62500.y );
					float2 temp_output_52_0_g62500 = floor( temp_output_51_0_g62500 );
					float2 temp_output_125_0_g62500 = ( temp_output_52_0_g62500 + float2( 1,1 ) );
					float2 ifLocalVar87_g62500 = 0;
					if( temp_output_56_0_g62500 > 0.0 )
					ifLocalVar87_g62500 = temp_output_52_0_g62500;
					else if( temp_output_56_0_g62500 == 0.0 )
					ifLocalVar87_g62500 = temp_output_125_0_g62500;
					else if( temp_output_56_0_g62500 < 0.0 )
					ifLocalVar87_g62500 = temp_output_125_0_g62500;
					float3 temp_output_7_0_g62501 = frac( ( (ifLocalVar87_g62500).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g62501 = dot( temp_output_7_0_g62501 , ( (temp_output_7_0_g62501).yzx + 33.33 ) );
					float3 temp_output_12_0_g62501 = ( temp_output_7_0_g62501 + dotResult8_g62501 );
					float2 temp_output_597_0_g62499 = ( UV100_g62500 + frac( ( ( (temp_output_12_0_g62501).xx + (temp_output_12_0_g62501).yz ) * (temp_output_12_0_g62501).zy ) ) );
					float2 DDX631_g62499 = ddx( temp_output_5_0_g62499 );
					float2 DDY632_g62499 = ddy( temp_output_5_0_g62499 );
					float temp_output_65_0_g62500 = ( 0.0 - temp_output_56_0_g62500 );
					float ifLocalVar59_g62500 = 0;
					if( temp_output_56_0_g62500 <= 0.0 )
					ifLocalVar59_g62500 = temp_output_65_0_g62500;
					else
					ifLocalVar59_g62500 = temp_output_56_0_g62500;
					float temp_output_597_30_g62499 = ifLocalVar59_g62500;
					float2 temp_output_90_0_g62500 = ( temp_output_52_0_g62500 + float2( 0,1 ) );
					float2 temp_output_123_0_g62500 = ( temp_output_52_0_g62500 + float2( 1,0 ) );
					float2 ifLocalVar88_g62500 = 0;
					if( temp_output_56_0_g62500 > 0.0 )
					ifLocalVar88_g62500 = temp_output_90_0_g62500;
					else if( temp_output_56_0_g62500 == 0.0 )
					ifLocalVar88_g62500 = temp_output_123_0_g62500;
					else if( temp_output_56_0_g62500 < 0.0 )
					ifLocalVar88_g62500 = temp_output_123_0_g62500;
					float3 temp_output_7_0_g62502 = frac( ( (ifLocalVar88_g62500).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g62502 = dot( temp_output_7_0_g62502 , ( (temp_output_7_0_g62502).yzx + 33.33 ) );
					float3 temp_output_12_0_g62502 = ( temp_output_7_0_g62502 + dotResult8_g62502 );
					float2 temp_output_597_26_g62499 = ( UV100_g62500 + frac( ( ( (temp_output_12_0_g62502).xx + (temp_output_12_0_g62502).yz ) * (temp_output_12_0_g62502).zy ) ) );
					float temp_output_66_0_g62500 = ( 1.0 - break55_g62500.y );
					float ifLocalVar60_g62500 = 0;
					if( temp_output_56_0_g62500 <= 0.0 )
					ifLocalVar60_g62500 = temp_output_66_0_g62500;
					else
					ifLocalVar60_g62500 = break55_g62500.y;
					float temp_output_597_28_g62499 = ifLocalVar60_g62500;
					float2 ifLocalVar89_g62500 = 0;
					if( temp_output_56_0_g62500 > 0.0 )
					ifLocalVar89_g62500 = temp_output_123_0_g62500;
					else if( temp_output_56_0_g62500 == 0.0 )
					ifLocalVar89_g62500 = temp_output_90_0_g62500;
					else if( temp_output_56_0_g62500 < 0.0 )
					ifLocalVar89_g62500 = temp_output_90_0_g62500;
					float3 temp_output_7_0_g62503 = frac( ( (ifLocalVar89_g62500).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g62503 = dot( temp_output_7_0_g62503 , ( (temp_output_7_0_g62503).yzx + 33.33 ) );
					float3 temp_output_12_0_g62503 = ( temp_output_7_0_g62503 + dotResult8_g62503 );
					float2 temp_output_597_27_g62499 = ( UV100_g62500 + frac( ( ( (temp_output_12_0_g62503).xx + (temp_output_12_0_g62503).yz ) * (temp_output_12_0_g62503).zy ) ) );
					float temp_output_67_0_g62500 = ( 1.0 - break55_g62500.x );
					float ifLocalVar61_g62500 = 0;
					if( temp_output_56_0_g62500 <= 0.0 )
					ifLocalVar61_g62500 = temp_output_67_0_g62500;
					else
					ifLocalVar61_g62500 = break55_g62500.x;
					float temp_output_597_29_g62499 = ifLocalVar61_g62500;
					float4 Output_2D293_g62499 = ( ( tex2D( _Sampler82964_g62479, temp_output_597_0_g62499, DDX631_g62499, DDY632_g62499 ) * temp_output_597_30_g62499 ) + ( tex2D( _Sampler82964_g62479, temp_output_597_26_g62499, DDX631_g62499, DDY632_g62499 ) * temp_output_597_28_g62499 ) + ( tex2D( _Sampler82964_g62479, temp_output_597_27_g62499, DDX631_g62499, DDY632_g62499 ) * temp_output_597_29_g62499 ) );
					float4 break31_g62499 = Output_2D293_g62499;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g62479 = ( 1.0 - break31_g62499.r );
					#else
					float staticSwitch1004_g62479 = ( 1.0 - staticSwitch845_g62479 );
					#endif
					float temp_output_19_0_g62521 = staticSwitch1004_g62479;
					float2 temp_output_5_0_g62489 = UV0A2420_g62479;
					float2 UV633_g62489 = temp_output_5_0_g62489;
					float2 UV100_g62490 = UV633_g62489;
					float2 temp_output_51_0_g62490 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g62490 * float2( 3.464,3.464 ) ) );
					float2 break55_g62490 = frac( temp_output_51_0_g62490 );
					float temp_output_56_0_g62490 = ( ( 1.0 - break55_g62490.x ) - break55_g62490.y );
					float2 temp_output_52_0_g62490 = floor( temp_output_51_0_g62490 );
					float2 temp_output_125_0_g62490 = ( temp_output_52_0_g62490 + float2( 1,1 ) );
					float2 ifLocalVar87_g62490 = 0;
					if( temp_output_56_0_g62490 > 0.0 )
					ifLocalVar87_g62490 = temp_output_52_0_g62490;
					else if( temp_output_56_0_g62490 == 0.0 )
					ifLocalVar87_g62490 = temp_output_125_0_g62490;
					else if( temp_output_56_0_g62490 < 0.0 )
					ifLocalVar87_g62490 = temp_output_125_0_g62490;
					float3 temp_output_7_0_g62491 = frac( ( (ifLocalVar87_g62490).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g62491 = dot( temp_output_7_0_g62491 , ( (temp_output_7_0_g62491).yzx + 33.33 ) );
					float3 temp_output_12_0_g62491 = ( temp_output_7_0_g62491 + dotResult8_g62491 );
					float2 temp_output_597_0_g62489 = ( UV100_g62490 + frac( ( ( (temp_output_12_0_g62491).xx + (temp_output_12_0_g62491).yz ) * (temp_output_12_0_g62491).zy ) ) );
					float2 DDX631_g62489 = ddx( temp_output_5_0_g62489 );
					float2 DDY632_g62489 = ddy( temp_output_5_0_g62489 );
					float Input_Scale617_g62489 = 1.5;
					float temp_output_65_0_g62490 = ( 0.0 - temp_output_56_0_g62490 );
					float ifLocalVar59_g62490 = 0;
					if( temp_output_56_0_g62490 <= 0.0 )
					ifLocalVar59_g62490 = temp_output_65_0_g62490;
					else
					ifLocalVar59_g62490 = temp_output_56_0_g62490;
					float temp_output_597_30_g62489 = ifLocalVar59_g62490;
					float2 temp_output_90_0_g62490 = ( temp_output_52_0_g62490 + float2( 0,1 ) );
					float2 temp_output_123_0_g62490 = ( temp_output_52_0_g62490 + float2( 1,0 ) );
					float2 ifLocalVar88_g62490 = 0;
					if( temp_output_56_0_g62490 > 0.0 )
					ifLocalVar88_g62490 = temp_output_90_0_g62490;
					else if( temp_output_56_0_g62490 == 0.0 )
					ifLocalVar88_g62490 = temp_output_123_0_g62490;
					else if( temp_output_56_0_g62490 < 0.0 )
					ifLocalVar88_g62490 = temp_output_123_0_g62490;
					float3 temp_output_7_0_g62492 = frac( ( (ifLocalVar88_g62490).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g62492 = dot( temp_output_7_0_g62492 , ( (temp_output_7_0_g62492).yzx + 33.33 ) );
					float3 temp_output_12_0_g62492 = ( temp_output_7_0_g62492 + dotResult8_g62492 );
					float2 temp_output_597_26_g62489 = ( UV100_g62490 + frac( ( ( (temp_output_12_0_g62492).xx + (temp_output_12_0_g62492).yz ) * (temp_output_12_0_g62492).zy ) ) );
					float temp_output_66_0_g62490 = ( 1.0 - break55_g62490.y );
					float ifLocalVar60_g62490 = 0;
					if( temp_output_56_0_g62490 <= 0.0 )
					ifLocalVar60_g62490 = temp_output_66_0_g62490;
					else
					ifLocalVar60_g62490 = break55_g62490.y;
					float temp_output_597_28_g62489 = ifLocalVar60_g62490;
					float2 ifLocalVar89_g62490 = 0;
					if( temp_output_56_0_g62490 > 0.0 )
					ifLocalVar89_g62490 = temp_output_123_0_g62490;
					else if( temp_output_56_0_g62490 == 0.0 )
					ifLocalVar89_g62490 = temp_output_90_0_g62490;
					else if( temp_output_56_0_g62490 < 0.0 )
					ifLocalVar89_g62490 = temp_output_90_0_g62490;
					float3 temp_output_7_0_g62493 = frac( ( (ifLocalVar89_g62490).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g62493 = dot( temp_output_7_0_g62493 , ( (temp_output_7_0_g62493).yzx + 33.33 ) );
					float3 temp_output_12_0_g62493 = ( temp_output_7_0_g62493 + dotResult8_g62493 );
					float2 temp_output_597_27_g62489 = ( UV100_g62490 + frac( ( ( (temp_output_12_0_g62493).xx + (temp_output_12_0_g62493).yz ) * (temp_output_12_0_g62493).zy ) ) );
					float temp_output_67_0_g62490 = ( 1.0 - break55_g62490.x );
					float ifLocalVar61_g62490 = 0;
					if( temp_output_56_0_g62490 <= 0.0 )
					ifLocalVar61_g62490 = temp_output_67_0_g62490;
					else
					ifLocalVar61_g62490 = break55_g62490.x;
					float temp_output_597_29_g62489 = ifLocalVar61_g62490;
					float3 Output_2D_Normal641_g62489 = ( ( UnpackScaleNormal( tex2D( _Sampler82965_g62479, temp_output_597_0_g62489, DDX631_g62489, DDY632_g62489 ), Input_Scale617_g62489 ) * temp_output_597_30_g62489 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g62479, temp_output_597_26_g62489, DDX631_g62489, DDY632_g62489 ), Input_Scale617_g62489 ) * temp_output_597_28_g62489 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g62479, temp_output_597_27_g62489, DDX631_g62489, DDY632_g62489 ), Input_Scale617_g62489 ) * float3( 0,0,0 ) * temp_output_597_29_g62489 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g62479 = Output_2D_Normal641_g62489;
					#else
					float3 staticSwitch1003_g62479 = UnpackScaleNormal( tex2D( _BumpMap, UV0A2420_g62479 ), 1.5 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g62479 = staticSwitch1003_g62479;
					#else
					float3 staticSwitch980_g62479 = float3( 0, 0, 1 );
					#endif
					float3 normalizeResult2878_g62479 = normalize( staticSwitch980_g62479 );
					float3 Normal700_g62479 = normalizeResult2878_g62479;
					float3 ase_tangentWS = IN.ase_texcoord1.xyz;
					float3 ase_normalWS = IN.ase_texcoord2.xyz;
					float3 ase_bitangentWS = IN.ase_texcoord3.xyz;
					float3 tanToWorld0 = float3( ase_tangentWS.x, ase_bitangentWS.x, ase_normalWS.x );
					float3 tanToWorld1 = float3( ase_tangentWS.y, ase_bitangentWS.y, ase_normalWS.y );
					float3 tanToWorld2 = float3( ase_tangentWS.z, ase_bitangentWS.z, ase_normalWS.z );
					float3 tanNormal2504_g62479 = Normal700_g62479;
					float3 worldNormal2504_g62479 = normalize( float3( dot( tanToWorld0, tanNormal2504_g62479 ), dot( tanToWorld1, tanNormal2504_g62479 ), dot( tanToWorld2, tanNormal2504_g62479 ) ) );
					float3 World_Normal2508_g62479 = worldNormal2504_g62479;
					float3 tanNormal2_g62521 = World_Normal2508_g62479;
					float3 worldNormal2_g62521 = float3( dot( tanToWorld0, tanNormal2_g62521 ), dot( tanToWorld1, tanNormal2_g62521 ), dot( tanToWorld2, tanNormal2_g62521 ) );
					float3 temp_output_3_0_g62521 = ddx( worldNormal2_g62521 );
					float dotResult5_g62521 = dot( temp_output_3_0_g62521 , temp_output_3_0_g62521 );
					float3 temp_output_4_0_g62521 = ddy( worldNormal2_g62521 );
					float dotResult6_g62521 = dot( temp_output_4_0_g62521 , temp_output_4_0_g62521 );
					#ifdef _USEGEOMETRICAA_ON
					float staticSwitch15_g62521 = min( temp_output_19_0_g62521, ( 1.0 - pow( saturate( max( dotResult5_g62521, dotResult6_g62521 ) ) , 0.25 ) ) );
					#else
					float staticSwitch15_g62521 = temp_output_19_0_g62521;
					#endif
					float Smoothness1399_g62479 = staticSwitch15_g62521;
					float Smoothness1_g62538 = Smoothness1399_g62479;
					float3 ase_positionWS = IN.ase_texcoord4.xyz;
					float3 ase_viewVectorWS = ( ( unity_OrthoParams.w == 0 ) ? _WorldSpaceCameraPos - ase_positionWS : UNITY_MATRIX_V[ 2 ].xyz );
					float3 ase_viewDirWS = normalize( ase_viewVectorWS );
					float3 View_Direction2511_g62479 = ase_viewDirWS;
					float3 ViewDir1_g62538 = View_Direction2511_g62479;
					float3 World_Position2505_g62479 = ase_positionWS;
					float3 WorldPos1_g62538 = World_Position2505_g62479;
					float3 WorldNormal1_g62538 = World_Normal2508_g62479;
					float White38_g62479 = 1.0;
					float4 temp_cast_2 = (Black1185_g62479).xxxx;
					float4 texCoord2426_g62479 = IN.ase_texcoord;
					texCoord2426_g62479.xy = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
					half2 UV0B2361_g62479 = (texCoord2426_g62479).zw;
					float localBicubicPrepare2_g62488 = ( 0.0 );
					float2 Input_UV100_g62488 = UV0B2361_g62479;
					float2 UV2_g62488 = Input_UV100_g62488;
					float4 TexelSize2_g62488 = _Lightmap0_TexelSize;
					float2 UV02_g62488 = float2( 0,0 );
					float2 UV12_g62488 = float2( 0,0 );
					float2 UV22_g62488 = float2( 0,0 );
					float2 UV32_g62488 = float2( 0,0 );
					float W02_g62488 = 0;
					float W12_g62488 = 0;
					{
					{
					 UV2_g62488 = UV2_g62488 * TexelSize2_g62488.zw - 0.5;
					    float2 f = frac( UV2_g62488 );
					    UV2_g62488 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g62488.x - 0.5, UV2_g62488.x + 1.5, UV2_g62488.y - 0.5, UV2_g62488.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g62488.xyxy;
					    UV02_g62488 = off.xz;
					    UV12_g62488 = off.yz;
					    UV22_g62488 = off.xw;
					    UV32_g62488 = off.yw;
					    W02_g62488 = s.x / ( s.x + s.y );
					 W12_g62488 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g62488 = lerp( tex2D( _Lightmap0, UV32_g62488 ) , tex2D( _Lightmap0, UV22_g62488 ) , W02_g62488);
					float4 lerpResult45_g62488 = lerp( tex2D( _Lightmap0, UV12_g62488 ) , tex2D( _Lightmap0, UV02_g62488 ) , W02_g62488);
					float4 lerpResult44_g62488 = lerp( lerpResult46_g62488 , lerpResult45_g62488 , W12_g62488);
					float4 Output_2D_Auto131_g62488 = lerpResult44_g62488;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g62479 = Output_2D_Auto131_g62488;
					#else
					float4 staticSwitch1092_g62479 = float4( tex2D( _Lightmap0, UV0B2361_g62479 ).rgb , 0.0 );
					#endif
					float4 Lightmap_0925_g62479 = staticSwitch1092_g62479;
					float localBicubicPrepare2_g62486 = ( 0.0 );
					float2 Input_UV100_g62486 = UV0B2361_g62479;
					float2 UV2_g62486 = Input_UV100_g62486;
					float4 TexelSize2_g62486 = _Lightmap1_TexelSize;
					float2 UV02_g62486 = float2( 0,0 );
					float2 UV12_g62486 = float2( 0,0 );
					float2 UV22_g62486 = float2( 0,0 );
					float2 UV32_g62486 = float2( 0,0 );
					float W02_g62486 = 0;
					float W12_g62486 = 0;
					{
					{
					 UV2_g62486 = UV2_g62486 * TexelSize2_g62486.zw - 0.5;
					    float2 f = frac( UV2_g62486 );
					    UV2_g62486 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g62486.x - 0.5, UV2_g62486.x + 1.5, UV2_g62486.y - 0.5, UV2_g62486.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g62486.xyxy;
					    UV02_g62486 = off.xz;
					    UV12_g62486 = off.yz;
					    UV22_g62486 = off.xw;
					    UV32_g62486 = off.yw;
					    W02_g62486 = s.x / ( s.x + s.y );
					 W12_g62486 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g62486 = lerp( tex2D( _Lightmap1, UV32_g62486 ) , tex2D( _Lightmap1, UV22_g62486 ) , W02_g62486);
					float4 lerpResult45_g62486 = lerp( tex2D( _Lightmap1, UV12_g62486 ) , tex2D( _Lightmap1, UV02_g62486 ) , W02_g62486);
					float4 lerpResult44_g62486 = lerp( lerpResult46_g62486 , lerpResult45_g62486 , W12_g62486);
					float4 Output_2D_Auto131_g62486 = lerpResult44_g62486;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g62479 = Output_2D_Auto131_g62486;
					#else
					float4 staticSwitch1088_g62479 = tex2D( _Lightmap1, UV0B2361_g62479 );
					#endif
					float4 Lightmap_1956_g62479 = staticSwitch1088_g62479;
					float Lightmap_Lerp_Value969_g62479 = _UdonLightmapLerp;
					float4 lerpResult442_g62479 = lerp( Lightmap_0925_g62479 , Lightmap_1956_g62479 , Lightmap_Lerp_Value969_g62479);
					float4 Lightmap_Lerp932_g62479 = lerpResult442_g62479;
					float3 appendResult139_g62528 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 Normal_Map318_g62528 = Normal700_g62479;
					float dotResult121_g62528 = dot( appendResult139_g62528 , Normal_Map318_g62528 );
					float temp_output_2_0_g62530 = saturate( dotResult121_g62528 );
					float localStochasticTiling2_g62510 = ( 0.0 );
					float2 UV2_g62510 = UV0B2361_g62479;
					float4 TexelSize2_g62510 = _UdonRNMX0_TexelSize;
					float4 Offsets2_g62510 = float4( 0,0,0,0 );
					float2 Weights2_g62510 = float2( 0,0 );
					{
					UV2_g62510 = UV2_g62510 * TexelSize2_g62510.zw - 0.5;
					float2 f = frac( UV2_g62510 );
					UV2_g62510 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g62510.x - 0.5, UV2_g62510.x + 1.5, UV2_g62510.y - 0.5, UV2_g62510.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g62510 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g62510.xyxy;
					Weights2_g62510 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g62509 = Offsets2_g62510;
					float4 Input_FetchOffsets197_g62511 = temp_output_1_34_g62509;
					float2 temp_output_1_54_g62509 = Weights2_g62510;
					float2 Input_FetchWeights200_g62511 = temp_output_1_54_g62509;
					float2 break187_g62511 = Input_FetchWeights200_g62511;
					float4 lerpResult181_g62511 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g62511).yw ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g62511).xw ) , break187_g62511.x);
					float4 lerpResult182_g62511 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g62511).yz ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g62511).xz ) , break187_g62511.x);
					float4 lerpResult176_g62511 = lerp( lerpResult181_g62511 , lerpResult182_g62511 , break187_g62511.y);
					float4 Output_Fetch2D_Auto202_g62511 = lerpResult176_g62511;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g62479 = Output_Fetch2D_Auto202_g62511;
					#else
					float4 staticSwitch1061_g62479 = tex2D( _UdonRNMX0, UV0B2361_g62479 );
					#endif
					float3 appendResult146_g62528 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g62528 = dot( appendResult146_g62528 , Normal_Map318_g62528 );
					float temp_output_2_0_g62529 = saturate( dotResult122_g62528 );
					float4 Input_FetchOffsets197_g62512 = temp_output_1_34_g62509;
					float2 Input_FetchWeights200_g62512 = temp_output_1_54_g62509;
					float2 break187_g62512 = Input_FetchWeights200_g62512;
					float4 lerpResult181_g62512 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g62512).yw ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g62512).xw ) , break187_g62512.x);
					float4 lerpResult182_g62512 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g62512).yz ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g62512).xz ) , break187_g62512.x);
					float4 lerpResult176_g62512 = lerp( lerpResult181_g62512 , lerpResult182_g62512 , break187_g62512.y);
					float4 Output_Fetch2D_Auto202_g62512 = lerpResult176_g62512;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g62479 = Output_Fetch2D_Auto202_g62512;
					#else
					float4 staticSwitch1062_g62479 = tex2D( _UdonRNMY0, UV0B2361_g62479 );
					#endif
					float3 appendResult149_g62528 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g62528 = dot( appendResult149_g62528 , Normal_Map318_g62528 );
					float temp_output_2_0_g62531 = saturate( dotResult120_g62528 );
					float4 Input_FetchOffsets197_g62513 = temp_output_1_34_g62509;
					float2 Input_FetchWeights200_g62513 = temp_output_1_54_g62509;
					float2 break187_g62513 = Input_FetchWeights200_g62513;
					float4 lerpResult181_g62513 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g62513).yw ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g62513).xw ) , break187_g62513.x);
					float4 lerpResult182_g62513 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g62513).yz ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g62513).xz ) , break187_g62513.x);
					float4 lerpResult176_g62513 = lerp( lerpResult181_g62513 , lerpResult182_g62513 , break187_g62513.y);
					float4 Output_Fetch2D_Auto202_g62513 = lerpResult176_g62513;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g62479 = Output_Fetch2D_Auto202_g62513;
					#else
					float4 staticSwitch1063_g62479 = tex2D( _UdonRNMZ0, UV0B2361_g62479 );
					#endif
					float4 temp_output_3094_0_g62479 = ( ( ( ( ( temp_output_2_0_g62530 * temp_output_2_0_g62530 ) * staticSwitch1061_g62479 ) + ( ( temp_output_2_0_g62529 * temp_output_2_0_g62529 ) * staticSwitch1062_g62479 ) ) + ( ( temp_output_2_0_g62531 * temp_output_2_0_g62531 ) * staticSwitch1063_g62479 ) ) * 1.2 );
					float4 RNM_0926_g62479 = temp_output_3094_0_g62479;
					float3 appendResult139_g62523 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 Normal_Map318_g62523 = Normal700_g62479;
					float dotResult121_g62523 = dot( appendResult139_g62523 , Normal_Map318_g62523 );
					float temp_output_2_0_g62525 = saturate( dotResult121_g62523 );
					float localStochasticTiling2_g62481 = ( 0.0 );
					float2 UV2_g62481 = UV0B2361_g62479;
					float4 TexelSize2_g62481 = _UdonRNMX1_TexelSize;
					float4 Offsets2_g62481 = float4( 0,0,0,0 );
					float2 Weights2_g62481 = float2( 0,0 );
					{
					UV2_g62481 = UV2_g62481 * TexelSize2_g62481.zw - 0.5;
					float2 f = frac( UV2_g62481 );
					UV2_g62481 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g62481.x - 0.5, UV2_g62481.x + 1.5, UV2_g62481.y - 0.5, UV2_g62481.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g62481 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g62481.xyxy;
					Weights2_g62481 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g62480 = Offsets2_g62481;
					float4 Input_FetchOffsets197_g62482 = temp_output_1_34_g62480;
					float2 temp_output_1_54_g62480 = Weights2_g62481;
					float2 Input_FetchWeights200_g62482 = temp_output_1_54_g62480;
					float2 break187_g62482 = Input_FetchWeights200_g62482;
					float4 lerpResult181_g62482 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g62482).yw ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g62482).xw ) , break187_g62482.x);
					float4 lerpResult182_g62482 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g62482).yz ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g62482).xz ) , break187_g62482.x);
					float4 lerpResult176_g62482 = lerp( lerpResult181_g62482 , lerpResult182_g62482 , break187_g62482.y);
					float4 Output_Fetch2D_Auto202_g62482 = lerpResult176_g62482;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g62479 = Output_Fetch2D_Auto202_g62482;
					#else
					float4 staticSwitch1087_g62479 = tex2D( _UdonRNMX1, UV0B2361_g62479 );
					#endif
					float3 appendResult146_g62523 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g62523 = dot( appendResult146_g62523 , Normal_Map318_g62523 );
					float temp_output_2_0_g62524 = saturate( dotResult122_g62523 );
					float4 Input_FetchOffsets197_g62483 = temp_output_1_34_g62480;
					float2 Input_FetchWeights200_g62483 = temp_output_1_54_g62480;
					float2 break187_g62483 = Input_FetchWeights200_g62483;
					float4 lerpResult181_g62483 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g62483).yw ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g62483).xw ) , break187_g62483.x);
					float4 lerpResult182_g62483 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g62483).yz ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g62483).xz ) , break187_g62483.x);
					float4 lerpResult176_g62483 = lerp( lerpResult181_g62483 , lerpResult182_g62483 , break187_g62483.y);
					float4 Output_Fetch2D_Auto202_g62483 = lerpResult176_g62483;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g62479 = Output_Fetch2D_Auto202_g62483;
					#else
					float4 staticSwitch1083_g62479 = tex2D( _UdonRNMY1, UV0B2361_g62479 );
					#endif
					float3 appendResult149_g62523 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g62523 = dot( appendResult149_g62523 , Normal_Map318_g62523 );
					float temp_output_2_0_g62526 = saturate( dotResult120_g62523 );
					float4 Input_FetchOffsets197_g62484 = temp_output_1_34_g62480;
					float2 Input_FetchWeights200_g62484 = temp_output_1_54_g62480;
					float2 break187_g62484 = Input_FetchWeights200_g62484;
					float4 lerpResult181_g62484 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g62484).yw ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g62484).xw ) , break187_g62484.x);
					float4 lerpResult182_g62484 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g62484).yz ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g62484).xz ) , break187_g62484.x);
					float4 lerpResult176_g62484 = lerp( lerpResult181_g62484 , lerpResult182_g62484 , break187_g62484.y);
					float4 Output_Fetch2D_Auto202_g62484 = lerpResult176_g62484;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g62479 = Output_Fetch2D_Auto202_g62484;
					#else
					float4 staticSwitch1084_g62479 = tex2D( _UdonRNMZ1, UV0B2361_g62479 );
					#endif
					float4 RNM_11081_g62479 = ( ( ( ( ( temp_output_2_0_g62525 * temp_output_2_0_g62525 ) * staticSwitch1087_g62479 ) + ( ( temp_output_2_0_g62524 * temp_output_2_0_g62524 ) * staticSwitch1083_g62479 ) ) + ( ( temp_output_2_0_g62526 * temp_output_2_0_g62526 ) * staticSwitch1084_g62479 ) ) * 1.2 );
					float4 lerpResult953_g62479 = lerp( RNM_0926_g62479 , RNM_11081_g62479 , Lightmap_Lerp_Value969_g62479);
					float4 RNM_Lerp950_g62479 = lerpResult953_g62479;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g62479 = temp_cast_2;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g62479 = Lightmap_0925_g62479;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g62479 = Lightmap_Lerp932_g62479;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g62479 = RNM_0926_g62479;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g62479 = RNM_Lerp950_g62479;
					#else
					float4 staticSwitch1014_g62479 = temp_cast_2;
					#endif
					float3 Lightmap46_g62479 = (staticSwitch1014_g62479).rgb;
					float dotResult9_g62537 = dot( float3( 0.212673, 0.715152, 0.072175 ) , Lightmap46_g62479 );
					float smoothstepResult14_g62537 = smoothstep( 0.0 , 0.04 , dotResult9_g62537);
					float Indirect_Lightmap_Mask3118_g62479 = smoothstepResult14_g62537;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float staticSwitch3145_g62479 = White38_g62479;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float staticSwitch3145_g62479 = Indirect_Lightmap_Mask3118_g62479;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float staticSwitch3145_g62479 = Indirect_Lightmap_Mask3118_g62479;
					#elif defined( _LIGHTMAPMODE_RNM )
					float staticSwitch3145_g62479 = Indirect_Lightmap_Mask3118_g62479;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float staticSwitch3145_g62479 = Indirect_Lightmap_Mask3118_g62479;
					#else
					float staticSwitch3145_g62479 = White38_g62479;
					#endif
					float LightmapMask1_g62538 = staticSwitch3145_g62479;
					float3 localIndirectSpecular1_g62538 = IndirectSpecular( Color1_g62538 , Metallic1_g62538 , Smoothness1_g62538 , ViewDir1_g62538 , WorldPos1_g62538 , WorldNormal1_g62538 , LightmapMask1_g62538 );
					#ifdef _INDIRECTSPECULARS_ON
					float3 staticSwitch2971_g62479 = localIndirectSpecular1_g62538;
					#else
					float3 staticSwitch2971_g62479 = temp_cast_1;
					#endif
					float3 Indirect_Specular1419_g62479 = staticSwitch2971_g62479;
					float3 temp_cast_4 = (Black1185_g62479).xxx;
					float3 Color97_g62527 = oAlbedo6_g62479;
					float Metallic97_g62527 = Metallic1239_g62479;
					float Smoothness97_g62527 = Smoothness1399_g62479;
					float3 ViewDir97_g62527 = View_Direction2511_g62479;
					float3 WorldPos97_g62527 = World_Position2505_g62479;
					float3 WorldNormal97_g62527 = World_Normal2508_g62479;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float staticSwitch3107_g62479 = Black1185_g62479;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float staticSwitch3107_g62479 = White38_g62479;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float staticSwitch3107_g62479 = White38_g62479;
					#elif defined( _LIGHTMAPMODE_RNM )
					float staticSwitch3107_g62479 = White38_g62479;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float staticSwitch3107_g62479 = White38_g62479;
					#else
					float staticSwitch3107_g62479 = Black1185_g62479;
					#endif
					float LightmapMode97_g62527 = staticSwitch3107_g62479;
					float dotResult9_g62536 = dot( float3( 0.212673, 0.715152, 0.072175 ) , Lightmap46_g62479 );
					float smoothstepResult2_g62536 = smoothstep( 0.0 , 0.4 , dotResult9_g62536);
					float Direct_Lightmap_Mask3067_g62479 = smoothstepResult2_g62536;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float staticSwitch3085_g62479 = White38_g62479;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float staticSwitch3085_g62479 = Direct_Lightmap_Mask3067_g62479;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float staticSwitch3085_g62479 = Direct_Lightmap_Mask3067_g62479;
					#elif defined( _LIGHTMAPMODE_RNM )
					float staticSwitch3085_g62479 = Direct_Lightmap_Mask3067_g62479;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float staticSwitch3085_g62479 = Direct_Lightmap_Mask3067_g62479;
					#else
					float staticSwitch3085_g62479 = White38_g62479;
					#endif
					float LightmapMask97_g62527 = staticSwitch3085_g62479;
					float3 localDirectSpecular97_g62527 = DirectSpecular( Color97_g62527 , Metallic97_g62527 , Smoothness97_g62527 , ViewDir97_g62527 , WorldPos97_g62527 , WorldNormal97_g62527 , LightmapMode97_g62527 , LightmapMask97_g62527 );
					#ifdef _DIRECTSPECULAR_ON
					float3 staticSwitch2969_g62479 = localDirectSpecular97_g62527;
					#else
					float3 staticSwitch2969_g62479 = temp_cast_4;
					#endif
					float3 Direct_Specular2560_g62479 = staticSwitch2969_g62479;
					float3 aAlbedo1466_g62479 = ( temp_output_2532_0_g62479 * ( 1.0 - Metallic1239_g62479 ) );
					float3 temp_output_1252_0_g62479 = ( aAlbedo1466_g62479 * Lightmap46_g62479 );
					float3 Normal3146_g62479 = Normal700_g62479;
					float3 localLightProbes3146_g62479 = LightProbes3146_g62479( Normal3146_g62479 );
					float3 temp_cast_5 = (Black1185_g62479).xxx;
					float3 temp_cast_6 = (Black1185_g62479).xxx;
					float3 temp_cast_7 = (Black1185_g62479).xxx;
					float3 temp_cast_8 = (Black1185_g62479).xxx;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float3 staticSwitch3148_g62479 = localLightProbes3146_g62479;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float3 staticSwitch3148_g62479 = temp_cast_5;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float3 staticSwitch3148_g62479 = temp_cast_6;
					#elif defined( _LIGHTMAPMODE_RNM )
					float3 staticSwitch3148_g62479 = temp_cast_7;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float3 staticSwitch3148_g62479 = temp_cast_8;
					#else
					float3 staticSwitch3148_g62479 = localLightProbes3146_g62479;
					#endif
					float3 Light_Probes3151_g62479 = staticSwitch3148_g62479;
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch1_g62522 = float4( ( temp_output_1252_0_g62479 + Emission86_g62479 + Indirect_Specular1419_g62479 + Light_Probes3151_g62479 ) , 0.0 );
					#else
					float4 staticSwitch1_g62522 = float4( ( Emission86_g62479 + Indirect_Specular1419_g62479 + Direct_Specular2560_g62479 + temp_output_1252_0_g62479 + Light_Probes3151_g62479 ) , 0.0 );
					#endif
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1181_g62479 = float4( Lightmap46_g62479 , 0.0 );
					#else
					float4 staticSwitch1181_g62479 = staticSwitch1_g62522;
					#endif
					float4 Color357_g62519 = staticSwitch1181_g62479;
					float4 LUT51_g62519 = tex3D( _LUT, ( ( log10( ( ( (Color357_g62519).xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 ) );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch359_g62519 = LUT51_g62519;
					#else
					float4 staticSwitch359_g62519 = Color357_g62519;
					#endif
					

					float4 Color = staticSwitch359_g62519;
					float Alpha = 1;
					half AlphaClipThreshold = 0.5;
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
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;6355;-64,-1280;Inherit;False;Meenphie;0;;62479;b3ba55a08dd6b49c7be16c6f35cf2033;6,1008,0,2632,0,2635,0,2619,0,2670,0,2636,0;0;3;FLOAT4;624;FLOAT;156;FLOAT;427
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;6274;256,-1280;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;7;Meenphie/Standard/Opaque;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;7;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;False;;True;2;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;5;Alpha Clipping;0;0;  Use Shadow Threshold;0;0;Cast Shadows;1;0;Write Depth;0;0;Vertex Position;1;0;0;2;True;True;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;6275;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;7;New Amplify Shader;0770190933193b94aaa3065e307002fa;True;ShadowCaster;0;1;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;False;;True;2;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
WireConnection;6274;0;6355;624
ASEEND*/
//CHKSM=0901F1BFAAB5C93BBC5FCA68B8819ABE8E91A33E