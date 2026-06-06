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
					float3 ase_normal : NORMAL;
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
				sampler2D _Sampler82968_g63859;
				uniform float _EmissionIntensity;
				uniform half4 _Color;
				uniform sampler2D _MainTex;
				sampler2D _Sampler82966_g63859;
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				sampler2D _Sampler82967_g63859;
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				sampler2D _Sampler82964_g63859;
				uniform sampler2D _BumpMap;
				sampler2D _Sampler82965_g63859;
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
					o.ase_normal = v.normal;
					
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

					float2 texCoord2357_g63859 = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
					float2 UV0A2420_g63859 = texCoord2357_g63859;
					float2 temp_output_5_0_g63884 = UV0A2420_g63859;
					float2 UV633_g63884 = temp_output_5_0_g63884;
					float2 UV100_g63885 = UV633_g63884;
					float2 temp_output_51_0_g63885 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g63885 * float2( 3.464,3.464 ) ) );
					float2 break55_g63885 = frac( temp_output_51_0_g63885 );
					float temp_output_56_0_g63885 = ( ( 1.0 - break55_g63885.x ) - break55_g63885.y );
					float2 temp_output_52_0_g63885 = floor( temp_output_51_0_g63885 );
					float2 temp_output_125_0_g63885 = ( temp_output_52_0_g63885 + float2( 1,1 ) );
					float2 ifLocalVar87_g63885 = 0;
					if( temp_output_56_0_g63885 > 0.0 )
					ifLocalVar87_g63885 = temp_output_52_0_g63885;
					else if( temp_output_56_0_g63885 == 0.0 )
					ifLocalVar87_g63885 = temp_output_125_0_g63885;
					else if( temp_output_56_0_g63885 < 0.0 )
					ifLocalVar87_g63885 = temp_output_125_0_g63885;
					float3 temp_output_7_0_g63886 = frac( ( (ifLocalVar87_g63885).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63886 = dot( temp_output_7_0_g63886 , ( (temp_output_7_0_g63886).yzx + 33.33 ) );
					float3 temp_output_12_0_g63886 = ( temp_output_7_0_g63886 + dotResult8_g63886 );
					float2 temp_output_597_0_g63884 = ( UV100_g63885 + frac( ( ( (temp_output_12_0_g63886).xx + (temp_output_12_0_g63886).yz ) * (temp_output_12_0_g63886).zy ) ) );
					float2 DDX631_g63884 = ddx( temp_output_5_0_g63884 );
					float2 DDY632_g63884 = ddy( temp_output_5_0_g63884 );
					float temp_output_65_0_g63885 = ( 0.0 - temp_output_56_0_g63885 );
					float ifLocalVar59_g63885 = 0;
					if( temp_output_56_0_g63885 <= 0.0 )
					ifLocalVar59_g63885 = temp_output_65_0_g63885;
					else
					ifLocalVar59_g63885 = temp_output_56_0_g63885;
					float temp_output_597_30_g63884 = ifLocalVar59_g63885;
					float2 temp_output_90_0_g63885 = ( temp_output_52_0_g63885 + float2( 0,1 ) );
					float2 temp_output_123_0_g63885 = ( temp_output_52_0_g63885 + float2( 1,0 ) );
					float2 ifLocalVar88_g63885 = 0;
					if( temp_output_56_0_g63885 > 0.0 )
					ifLocalVar88_g63885 = temp_output_90_0_g63885;
					else if( temp_output_56_0_g63885 == 0.0 )
					ifLocalVar88_g63885 = temp_output_123_0_g63885;
					else if( temp_output_56_0_g63885 < 0.0 )
					ifLocalVar88_g63885 = temp_output_123_0_g63885;
					float3 temp_output_7_0_g63887 = frac( ( (ifLocalVar88_g63885).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63887 = dot( temp_output_7_0_g63887 , ( (temp_output_7_0_g63887).yzx + 33.33 ) );
					float3 temp_output_12_0_g63887 = ( temp_output_7_0_g63887 + dotResult8_g63887 );
					float2 temp_output_597_26_g63884 = ( UV100_g63885 + frac( ( ( (temp_output_12_0_g63887).xx + (temp_output_12_0_g63887).yz ) * (temp_output_12_0_g63887).zy ) ) );
					float temp_output_66_0_g63885 = ( 1.0 - break55_g63885.y );
					float ifLocalVar60_g63885 = 0;
					if( temp_output_56_0_g63885 <= 0.0 )
					ifLocalVar60_g63885 = temp_output_66_0_g63885;
					else
					ifLocalVar60_g63885 = break55_g63885.y;
					float temp_output_597_28_g63884 = ifLocalVar60_g63885;
					float2 ifLocalVar89_g63885 = 0;
					if( temp_output_56_0_g63885 > 0.0 )
					ifLocalVar89_g63885 = temp_output_123_0_g63885;
					else if( temp_output_56_0_g63885 == 0.0 )
					ifLocalVar89_g63885 = temp_output_90_0_g63885;
					else if( temp_output_56_0_g63885 < 0.0 )
					ifLocalVar89_g63885 = temp_output_90_0_g63885;
					float3 temp_output_7_0_g63888 = frac( ( (ifLocalVar89_g63885).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63888 = dot( temp_output_7_0_g63888 , ( (temp_output_7_0_g63888).yzx + 33.33 ) );
					float3 temp_output_12_0_g63888 = ( temp_output_7_0_g63888 + dotResult8_g63888 );
					float2 temp_output_597_27_g63884 = ( UV100_g63885 + frac( ( ( (temp_output_12_0_g63888).xx + (temp_output_12_0_g63888).yz ) * (temp_output_12_0_g63888).zy ) ) );
					float temp_output_67_0_g63885 = ( 1.0 - break55_g63885.x );
					float ifLocalVar61_g63885 = 0;
					if( temp_output_56_0_g63885 <= 0.0 )
					ifLocalVar61_g63885 = temp_output_67_0_g63885;
					else
					ifLocalVar61_g63885 = break55_g63885.x;
					float temp_output_597_29_g63884 = ifLocalVar61_g63885;
					float4 Output_2D293_g63884 = ( ( tex2D( _Sampler82968_g63859, temp_output_597_0_g63884, DDX631_g63884, DDY632_g63884 ) * temp_output_597_30_g63884 ) + ( tex2D( _Sampler82968_g63859, temp_output_597_26_g63884, DDX631_g63884, DDY632_g63884 ) * temp_output_597_28_g63884 ) + ( tex2D( _Sampler82968_g63859, temp_output_597_27_g63884, DDX631_g63884, DDY632_g63884 ) * temp_output_597_29_g63884 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g63859 = Output_2D293_g63884;
					#else
					float4 staticSwitch1006_g63859 = tex2D( _EmissionMap, UV0A2420_g63859 );
					#endif
					float3 temp_output_2531_0_g63859 = (( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g63859 * _EmissionIntensity )).rgb;
					float3 Emission86_g63859 = temp_output_2531_0_g63859;
					float Black1185_g63859 = 0.0;
					float3 temp_cast_1 = (Black1185_g63859).xxx;
					float2 temp_output_5_0_g63874 = UV0A2420_g63859;
					float2 UV633_g63874 = temp_output_5_0_g63874;
					float2 UV100_g63875 = UV633_g63874;
					float2 temp_output_51_0_g63875 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g63875 * float2( 3.464,3.464 ) ) );
					float2 break55_g63875 = frac( temp_output_51_0_g63875 );
					float temp_output_56_0_g63875 = ( ( 1.0 - break55_g63875.x ) - break55_g63875.y );
					float2 temp_output_52_0_g63875 = floor( temp_output_51_0_g63875 );
					float2 temp_output_125_0_g63875 = ( temp_output_52_0_g63875 + float2( 1,1 ) );
					float2 ifLocalVar87_g63875 = 0;
					if( temp_output_56_0_g63875 > 0.0 )
					ifLocalVar87_g63875 = temp_output_52_0_g63875;
					else if( temp_output_56_0_g63875 == 0.0 )
					ifLocalVar87_g63875 = temp_output_125_0_g63875;
					else if( temp_output_56_0_g63875 < 0.0 )
					ifLocalVar87_g63875 = temp_output_125_0_g63875;
					float3 temp_output_7_0_g63876 = frac( ( (ifLocalVar87_g63875).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63876 = dot( temp_output_7_0_g63876 , ( (temp_output_7_0_g63876).yzx + 33.33 ) );
					float3 temp_output_12_0_g63876 = ( temp_output_7_0_g63876 + dotResult8_g63876 );
					float2 temp_output_597_0_g63874 = ( UV100_g63875 + frac( ( ( (temp_output_12_0_g63876).xx + (temp_output_12_0_g63876).yz ) * (temp_output_12_0_g63876).zy ) ) );
					float2 DDX631_g63874 = ddx( temp_output_5_0_g63874 );
					float2 DDY632_g63874 = ddy( temp_output_5_0_g63874 );
					float temp_output_65_0_g63875 = ( 0.0 - temp_output_56_0_g63875 );
					float ifLocalVar59_g63875 = 0;
					if( temp_output_56_0_g63875 <= 0.0 )
					ifLocalVar59_g63875 = temp_output_65_0_g63875;
					else
					ifLocalVar59_g63875 = temp_output_56_0_g63875;
					float temp_output_597_30_g63874 = ifLocalVar59_g63875;
					float2 temp_output_90_0_g63875 = ( temp_output_52_0_g63875 + float2( 0,1 ) );
					float2 temp_output_123_0_g63875 = ( temp_output_52_0_g63875 + float2( 1,0 ) );
					float2 ifLocalVar88_g63875 = 0;
					if( temp_output_56_0_g63875 > 0.0 )
					ifLocalVar88_g63875 = temp_output_90_0_g63875;
					else if( temp_output_56_0_g63875 == 0.0 )
					ifLocalVar88_g63875 = temp_output_123_0_g63875;
					else if( temp_output_56_0_g63875 < 0.0 )
					ifLocalVar88_g63875 = temp_output_123_0_g63875;
					float3 temp_output_7_0_g63877 = frac( ( (ifLocalVar88_g63875).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63877 = dot( temp_output_7_0_g63877 , ( (temp_output_7_0_g63877).yzx + 33.33 ) );
					float3 temp_output_12_0_g63877 = ( temp_output_7_0_g63877 + dotResult8_g63877 );
					float2 temp_output_597_26_g63874 = ( UV100_g63875 + frac( ( ( (temp_output_12_0_g63877).xx + (temp_output_12_0_g63877).yz ) * (temp_output_12_0_g63877).zy ) ) );
					float temp_output_66_0_g63875 = ( 1.0 - break55_g63875.y );
					float ifLocalVar60_g63875 = 0;
					if( temp_output_56_0_g63875 <= 0.0 )
					ifLocalVar60_g63875 = temp_output_66_0_g63875;
					else
					ifLocalVar60_g63875 = break55_g63875.y;
					float temp_output_597_28_g63874 = ifLocalVar60_g63875;
					float2 ifLocalVar89_g63875 = 0;
					if( temp_output_56_0_g63875 > 0.0 )
					ifLocalVar89_g63875 = temp_output_123_0_g63875;
					else if( temp_output_56_0_g63875 == 0.0 )
					ifLocalVar89_g63875 = temp_output_90_0_g63875;
					else if( temp_output_56_0_g63875 < 0.0 )
					ifLocalVar89_g63875 = temp_output_90_0_g63875;
					float3 temp_output_7_0_g63878 = frac( ( (ifLocalVar89_g63875).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63878 = dot( temp_output_7_0_g63878 , ( (temp_output_7_0_g63878).yzx + 33.33 ) );
					float3 temp_output_12_0_g63878 = ( temp_output_7_0_g63878 + dotResult8_g63878 );
					float2 temp_output_597_27_g63874 = ( UV100_g63875 + frac( ( ( (temp_output_12_0_g63878).xx + (temp_output_12_0_g63878).yz ) * (temp_output_12_0_g63878).zy ) ) );
					float temp_output_67_0_g63875 = ( 1.0 - break55_g63875.x );
					float ifLocalVar61_g63875 = 0;
					if( temp_output_56_0_g63875 <= 0.0 )
					ifLocalVar61_g63875 = temp_output_67_0_g63875;
					else
					ifLocalVar61_g63875 = break55_g63875.x;
					float temp_output_597_29_g63874 = ifLocalVar61_g63875;
					float4 Output_2D293_g63874 = ( ( tex2D( _Sampler82966_g63859, temp_output_597_0_g63874, DDX631_g63874, DDY632_g63874 ) * temp_output_597_30_g63874 ) + ( tex2D( _Sampler82966_g63859, temp_output_597_26_g63874, DDX631_g63874, DDY632_g63874 ) * temp_output_597_28_g63874 ) + ( tex2D( _Sampler82966_g63859, temp_output_597_27_g63874, DDX631_g63874, DDY632_g63874 ) * temp_output_597_29_g63874 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g63859 = Output_2D293_g63874;
					#else
					float4 staticSwitch1001_g63859 = ( _Color * tex2D( _MainTex, UV0A2420_g63859 ) );
					#endif
					float3 temp_output_2532_0_g63859 = (staticSwitch1001_g63859).rgb;
					float3 oAlbedo6_g63859 = temp_output_2532_0_g63859;
					float3 Color1_g63915 = oAlbedo6_g63859;
					#ifdef _METALLICMAP
					float staticSwitch846_g63859 = tex2D( _MetallicMap, UV0A2420_g63859 ).r;
					#else
					float staticSwitch846_g63859 = _Metallic;
					#endif
					float2 temp_output_5_0_g63894 = UV0A2420_g63859;
					float2 UV633_g63894 = temp_output_5_0_g63894;
					float2 UV100_g63895 = UV633_g63894;
					float2 temp_output_51_0_g63895 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g63895 * float2( 3.464,3.464 ) ) );
					float2 break55_g63895 = frac( temp_output_51_0_g63895 );
					float temp_output_56_0_g63895 = ( ( 1.0 - break55_g63895.x ) - break55_g63895.y );
					float2 temp_output_52_0_g63895 = floor( temp_output_51_0_g63895 );
					float2 temp_output_125_0_g63895 = ( temp_output_52_0_g63895 + float2( 1,1 ) );
					float2 ifLocalVar87_g63895 = 0;
					if( temp_output_56_0_g63895 > 0.0 )
					ifLocalVar87_g63895 = temp_output_52_0_g63895;
					else if( temp_output_56_0_g63895 == 0.0 )
					ifLocalVar87_g63895 = temp_output_125_0_g63895;
					else if( temp_output_56_0_g63895 < 0.0 )
					ifLocalVar87_g63895 = temp_output_125_0_g63895;
					float3 temp_output_7_0_g63896 = frac( ( (ifLocalVar87_g63895).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63896 = dot( temp_output_7_0_g63896 , ( (temp_output_7_0_g63896).yzx + 33.33 ) );
					float3 temp_output_12_0_g63896 = ( temp_output_7_0_g63896 + dotResult8_g63896 );
					float2 temp_output_597_0_g63894 = ( UV100_g63895 + frac( ( ( (temp_output_12_0_g63896).xx + (temp_output_12_0_g63896).yz ) * (temp_output_12_0_g63896).zy ) ) );
					float2 DDX631_g63894 = ddx( temp_output_5_0_g63894 );
					float2 DDY632_g63894 = ddy( temp_output_5_0_g63894 );
					float temp_output_65_0_g63895 = ( 0.0 - temp_output_56_0_g63895 );
					float ifLocalVar59_g63895 = 0;
					if( temp_output_56_0_g63895 <= 0.0 )
					ifLocalVar59_g63895 = temp_output_65_0_g63895;
					else
					ifLocalVar59_g63895 = temp_output_56_0_g63895;
					float temp_output_597_30_g63894 = ifLocalVar59_g63895;
					float2 temp_output_90_0_g63895 = ( temp_output_52_0_g63895 + float2( 0,1 ) );
					float2 temp_output_123_0_g63895 = ( temp_output_52_0_g63895 + float2( 1,0 ) );
					float2 ifLocalVar88_g63895 = 0;
					if( temp_output_56_0_g63895 > 0.0 )
					ifLocalVar88_g63895 = temp_output_90_0_g63895;
					else if( temp_output_56_0_g63895 == 0.0 )
					ifLocalVar88_g63895 = temp_output_123_0_g63895;
					else if( temp_output_56_0_g63895 < 0.0 )
					ifLocalVar88_g63895 = temp_output_123_0_g63895;
					float3 temp_output_7_0_g63897 = frac( ( (ifLocalVar88_g63895).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63897 = dot( temp_output_7_0_g63897 , ( (temp_output_7_0_g63897).yzx + 33.33 ) );
					float3 temp_output_12_0_g63897 = ( temp_output_7_0_g63897 + dotResult8_g63897 );
					float2 temp_output_597_26_g63894 = ( UV100_g63895 + frac( ( ( (temp_output_12_0_g63897).xx + (temp_output_12_0_g63897).yz ) * (temp_output_12_0_g63897).zy ) ) );
					float temp_output_66_0_g63895 = ( 1.0 - break55_g63895.y );
					float ifLocalVar60_g63895 = 0;
					if( temp_output_56_0_g63895 <= 0.0 )
					ifLocalVar60_g63895 = temp_output_66_0_g63895;
					else
					ifLocalVar60_g63895 = break55_g63895.y;
					float temp_output_597_28_g63894 = ifLocalVar60_g63895;
					float2 ifLocalVar89_g63895 = 0;
					if( temp_output_56_0_g63895 > 0.0 )
					ifLocalVar89_g63895 = temp_output_123_0_g63895;
					else if( temp_output_56_0_g63895 == 0.0 )
					ifLocalVar89_g63895 = temp_output_90_0_g63895;
					else if( temp_output_56_0_g63895 < 0.0 )
					ifLocalVar89_g63895 = temp_output_90_0_g63895;
					float3 temp_output_7_0_g63898 = frac( ( (ifLocalVar89_g63895).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63898 = dot( temp_output_7_0_g63898 , ( (temp_output_7_0_g63898).yzx + 33.33 ) );
					float3 temp_output_12_0_g63898 = ( temp_output_7_0_g63898 + dotResult8_g63898 );
					float2 temp_output_597_27_g63894 = ( UV100_g63895 + frac( ( ( (temp_output_12_0_g63898).xx + (temp_output_12_0_g63898).yz ) * (temp_output_12_0_g63898).zy ) ) );
					float temp_output_67_0_g63895 = ( 1.0 - break55_g63895.x );
					float ifLocalVar61_g63895 = 0;
					if( temp_output_56_0_g63895 <= 0.0 )
					ifLocalVar61_g63895 = temp_output_67_0_g63895;
					else
					ifLocalVar61_g63895 = break55_g63895.x;
					float temp_output_597_29_g63894 = ifLocalVar61_g63895;
					float4 Output_2D293_g63894 = ( ( tex2D( _Sampler82967_g63859, temp_output_597_0_g63894, DDX631_g63894, DDY632_g63894 ) * temp_output_597_30_g63894 ) + ( tex2D( _Sampler82967_g63859, temp_output_597_26_g63894, DDX631_g63894, DDY632_g63894 ) * temp_output_597_28_g63894 ) + ( tex2D( _Sampler82967_g63859, temp_output_597_27_g63894, DDX631_g63894, DDY632_g63894 ) * temp_output_597_29_g63894 ) );
					float4 break31_g63894 = Output_2D293_g63894;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g63859 = break31_g63894.r;
					#else
					float staticSwitch1005_g63859 = staticSwitch846_g63859;
					#endif
					float Metallic1239_g63859 = staticSwitch1005_g63859;
					float Metallic1_g63915 = Metallic1239_g63859;
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g63859 = tex2D( _GlossinessMap, UV0A2420_g63859 ).r;
					#else
					float staticSwitch845_g63859 = _Glossiness;
					#endif
					float2 temp_output_5_0_g63879 = UV0A2420_g63859;
					float2 UV633_g63879 = temp_output_5_0_g63879;
					float2 UV100_g63880 = UV633_g63879;
					float2 temp_output_51_0_g63880 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g63880 * float2( 3.464,3.464 ) ) );
					float2 break55_g63880 = frac( temp_output_51_0_g63880 );
					float temp_output_56_0_g63880 = ( ( 1.0 - break55_g63880.x ) - break55_g63880.y );
					float2 temp_output_52_0_g63880 = floor( temp_output_51_0_g63880 );
					float2 temp_output_125_0_g63880 = ( temp_output_52_0_g63880 + float2( 1,1 ) );
					float2 ifLocalVar87_g63880 = 0;
					if( temp_output_56_0_g63880 > 0.0 )
					ifLocalVar87_g63880 = temp_output_52_0_g63880;
					else if( temp_output_56_0_g63880 == 0.0 )
					ifLocalVar87_g63880 = temp_output_125_0_g63880;
					else if( temp_output_56_0_g63880 < 0.0 )
					ifLocalVar87_g63880 = temp_output_125_0_g63880;
					float3 temp_output_7_0_g63881 = frac( ( (ifLocalVar87_g63880).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63881 = dot( temp_output_7_0_g63881 , ( (temp_output_7_0_g63881).yzx + 33.33 ) );
					float3 temp_output_12_0_g63881 = ( temp_output_7_0_g63881 + dotResult8_g63881 );
					float2 temp_output_597_0_g63879 = ( UV100_g63880 + frac( ( ( (temp_output_12_0_g63881).xx + (temp_output_12_0_g63881).yz ) * (temp_output_12_0_g63881).zy ) ) );
					float2 DDX631_g63879 = ddx( temp_output_5_0_g63879 );
					float2 DDY632_g63879 = ddy( temp_output_5_0_g63879 );
					float temp_output_65_0_g63880 = ( 0.0 - temp_output_56_0_g63880 );
					float ifLocalVar59_g63880 = 0;
					if( temp_output_56_0_g63880 <= 0.0 )
					ifLocalVar59_g63880 = temp_output_65_0_g63880;
					else
					ifLocalVar59_g63880 = temp_output_56_0_g63880;
					float temp_output_597_30_g63879 = ifLocalVar59_g63880;
					float2 temp_output_90_0_g63880 = ( temp_output_52_0_g63880 + float2( 0,1 ) );
					float2 temp_output_123_0_g63880 = ( temp_output_52_0_g63880 + float2( 1,0 ) );
					float2 ifLocalVar88_g63880 = 0;
					if( temp_output_56_0_g63880 > 0.0 )
					ifLocalVar88_g63880 = temp_output_90_0_g63880;
					else if( temp_output_56_0_g63880 == 0.0 )
					ifLocalVar88_g63880 = temp_output_123_0_g63880;
					else if( temp_output_56_0_g63880 < 0.0 )
					ifLocalVar88_g63880 = temp_output_123_0_g63880;
					float3 temp_output_7_0_g63882 = frac( ( (ifLocalVar88_g63880).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63882 = dot( temp_output_7_0_g63882 , ( (temp_output_7_0_g63882).yzx + 33.33 ) );
					float3 temp_output_12_0_g63882 = ( temp_output_7_0_g63882 + dotResult8_g63882 );
					float2 temp_output_597_26_g63879 = ( UV100_g63880 + frac( ( ( (temp_output_12_0_g63882).xx + (temp_output_12_0_g63882).yz ) * (temp_output_12_0_g63882).zy ) ) );
					float temp_output_66_0_g63880 = ( 1.0 - break55_g63880.y );
					float ifLocalVar60_g63880 = 0;
					if( temp_output_56_0_g63880 <= 0.0 )
					ifLocalVar60_g63880 = temp_output_66_0_g63880;
					else
					ifLocalVar60_g63880 = break55_g63880.y;
					float temp_output_597_28_g63879 = ifLocalVar60_g63880;
					float2 ifLocalVar89_g63880 = 0;
					if( temp_output_56_0_g63880 > 0.0 )
					ifLocalVar89_g63880 = temp_output_123_0_g63880;
					else if( temp_output_56_0_g63880 == 0.0 )
					ifLocalVar89_g63880 = temp_output_90_0_g63880;
					else if( temp_output_56_0_g63880 < 0.0 )
					ifLocalVar89_g63880 = temp_output_90_0_g63880;
					float3 temp_output_7_0_g63883 = frac( ( (ifLocalVar89_g63880).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63883 = dot( temp_output_7_0_g63883 , ( (temp_output_7_0_g63883).yzx + 33.33 ) );
					float3 temp_output_12_0_g63883 = ( temp_output_7_0_g63883 + dotResult8_g63883 );
					float2 temp_output_597_27_g63879 = ( UV100_g63880 + frac( ( ( (temp_output_12_0_g63883).xx + (temp_output_12_0_g63883).yz ) * (temp_output_12_0_g63883).zy ) ) );
					float temp_output_67_0_g63880 = ( 1.0 - break55_g63880.x );
					float ifLocalVar61_g63880 = 0;
					if( temp_output_56_0_g63880 <= 0.0 )
					ifLocalVar61_g63880 = temp_output_67_0_g63880;
					else
					ifLocalVar61_g63880 = break55_g63880.x;
					float temp_output_597_29_g63879 = ifLocalVar61_g63880;
					float4 Output_2D293_g63879 = ( ( tex2D( _Sampler82964_g63859, temp_output_597_0_g63879, DDX631_g63879, DDY632_g63879 ) * temp_output_597_30_g63879 ) + ( tex2D( _Sampler82964_g63859, temp_output_597_26_g63879, DDX631_g63879, DDY632_g63879 ) * temp_output_597_28_g63879 ) + ( tex2D( _Sampler82964_g63859, temp_output_597_27_g63879, DDX631_g63879, DDY632_g63879 ) * temp_output_597_29_g63879 ) );
					float4 break31_g63879 = Output_2D293_g63879;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g63859 = ( 1.0 - break31_g63879.r );
					#else
					float staticSwitch1004_g63859 = ( 1.0 - staticSwitch845_g63859 );
					#endif
					float temp_output_19_0_g63901 = staticSwitch1004_g63859;
					float2 temp_output_5_0_g63869 = UV0A2420_g63859;
					float2 UV633_g63869 = temp_output_5_0_g63869;
					float2 UV100_g63870 = UV633_g63869;
					float2 temp_output_51_0_g63870 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g63870 * float2( 3.464,3.464 ) ) );
					float2 break55_g63870 = frac( temp_output_51_0_g63870 );
					float temp_output_56_0_g63870 = ( ( 1.0 - break55_g63870.x ) - break55_g63870.y );
					float2 temp_output_52_0_g63870 = floor( temp_output_51_0_g63870 );
					float2 temp_output_125_0_g63870 = ( temp_output_52_0_g63870 + float2( 1,1 ) );
					float2 ifLocalVar87_g63870 = 0;
					if( temp_output_56_0_g63870 > 0.0 )
					ifLocalVar87_g63870 = temp_output_52_0_g63870;
					else if( temp_output_56_0_g63870 == 0.0 )
					ifLocalVar87_g63870 = temp_output_125_0_g63870;
					else if( temp_output_56_0_g63870 < 0.0 )
					ifLocalVar87_g63870 = temp_output_125_0_g63870;
					float3 temp_output_7_0_g63871 = frac( ( (ifLocalVar87_g63870).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63871 = dot( temp_output_7_0_g63871 , ( (temp_output_7_0_g63871).yzx + 33.33 ) );
					float3 temp_output_12_0_g63871 = ( temp_output_7_0_g63871 + dotResult8_g63871 );
					float2 temp_output_597_0_g63869 = ( UV100_g63870 + frac( ( ( (temp_output_12_0_g63871).xx + (temp_output_12_0_g63871).yz ) * (temp_output_12_0_g63871).zy ) ) );
					float2 DDX631_g63869 = ddx( temp_output_5_0_g63869 );
					float2 DDY632_g63869 = ddy( temp_output_5_0_g63869 );
					float Input_Scale617_g63869 = 1.5;
					float temp_output_65_0_g63870 = ( 0.0 - temp_output_56_0_g63870 );
					float ifLocalVar59_g63870 = 0;
					if( temp_output_56_0_g63870 <= 0.0 )
					ifLocalVar59_g63870 = temp_output_65_0_g63870;
					else
					ifLocalVar59_g63870 = temp_output_56_0_g63870;
					float temp_output_597_30_g63869 = ifLocalVar59_g63870;
					float2 temp_output_90_0_g63870 = ( temp_output_52_0_g63870 + float2( 0,1 ) );
					float2 temp_output_123_0_g63870 = ( temp_output_52_0_g63870 + float2( 1,0 ) );
					float2 ifLocalVar88_g63870 = 0;
					if( temp_output_56_0_g63870 > 0.0 )
					ifLocalVar88_g63870 = temp_output_90_0_g63870;
					else if( temp_output_56_0_g63870 == 0.0 )
					ifLocalVar88_g63870 = temp_output_123_0_g63870;
					else if( temp_output_56_0_g63870 < 0.0 )
					ifLocalVar88_g63870 = temp_output_123_0_g63870;
					float3 temp_output_7_0_g63872 = frac( ( (ifLocalVar88_g63870).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63872 = dot( temp_output_7_0_g63872 , ( (temp_output_7_0_g63872).yzx + 33.33 ) );
					float3 temp_output_12_0_g63872 = ( temp_output_7_0_g63872 + dotResult8_g63872 );
					float2 temp_output_597_26_g63869 = ( UV100_g63870 + frac( ( ( (temp_output_12_0_g63872).xx + (temp_output_12_0_g63872).yz ) * (temp_output_12_0_g63872).zy ) ) );
					float temp_output_66_0_g63870 = ( 1.0 - break55_g63870.y );
					float ifLocalVar60_g63870 = 0;
					if( temp_output_56_0_g63870 <= 0.0 )
					ifLocalVar60_g63870 = temp_output_66_0_g63870;
					else
					ifLocalVar60_g63870 = break55_g63870.y;
					float temp_output_597_28_g63869 = ifLocalVar60_g63870;
					float2 ifLocalVar89_g63870 = 0;
					if( temp_output_56_0_g63870 > 0.0 )
					ifLocalVar89_g63870 = temp_output_123_0_g63870;
					else if( temp_output_56_0_g63870 == 0.0 )
					ifLocalVar89_g63870 = temp_output_90_0_g63870;
					else if( temp_output_56_0_g63870 < 0.0 )
					ifLocalVar89_g63870 = temp_output_90_0_g63870;
					float3 temp_output_7_0_g63873 = frac( ( (ifLocalVar89_g63870).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
					float dotResult8_g63873 = dot( temp_output_7_0_g63873 , ( (temp_output_7_0_g63873).yzx + 33.33 ) );
					float3 temp_output_12_0_g63873 = ( temp_output_7_0_g63873 + dotResult8_g63873 );
					float2 temp_output_597_27_g63869 = ( UV100_g63870 + frac( ( ( (temp_output_12_0_g63873).xx + (temp_output_12_0_g63873).yz ) * (temp_output_12_0_g63873).zy ) ) );
					float temp_output_67_0_g63870 = ( 1.0 - break55_g63870.x );
					float ifLocalVar61_g63870 = 0;
					if( temp_output_56_0_g63870 <= 0.0 )
					ifLocalVar61_g63870 = temp_output_67_0_g63870;
					else
					ifLocalVar61_g63870 = break55_g63870.x;
					float temp_output_597_29_g63869 = ifLocalVar61_g63870;
					float3 Output_2D_Normal641_g63869 = ( ( UnpackScaleNormal( tex2D( _Sampler82965_g63859, temp_output_597_0_g63869, DDX631_g63869, DDY632_g63869 ), Input_Scale617_g63869 ) * temp_output_597_30_g63869 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g63859, temp_output_597_26_g63869, DDX631_g63869, DDY632_g63869 ), Input_Scale617_g63869 ) * temp_output_597_28_g63869 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g63859, temp_output_597_27_g63869, DDX631_g63869, DDY632_g63869 ), Input_Scale617_g63869 ) * float3( 0,0,0 ) * temp_output_597_29_g63869 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g63859 = Output_2D_Normal641_g63869;
					#else
					float3 staticSwitch1003_g63859 = UnpackScaleNormal( tex2D( _BumpMap, UV0A2420_g63859 ), 1.5 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g63859 = staticSwitch1003_g63859;
					#else
					float3 staticSwitch980_g63859 = float3( 0, 0, 1 );
					#endif
					float3 normalizeResult2878_g63859 = normalize( staticSwitch980_g63859 );
					float3 Normal700_g63859 = normalizeResult2878_g63859;
					float3 ase_tangentWS = IN.ase_texcoord1.xyz;
					float3 ase_normalWS = IN.ase_texcoord2.xyz;
					float3 ase_bitangentWS = IN.ase_texcoord3.xyz;
					float3 tanToWorld0 = float3( ase_tangentWS.x, ase_bitangentWS.x, ase_normalWS.x );
					float3 tanToWorld1 = float3( ase_tangentWS.y, ase_bitangentWS.y, ase_normalWS.y );
					float3 tanToWorld2 = float3( ase_tangentWS.z, ase_bitangentWS.z, ase_normalWS.z );
					float3 tanNormal2504_g63859 = Normal700_g63859;
					float3 worldNormal2504_g63859 = normalize( float3( dot( tanToWorld0, tanNormal2504_g63859 ), dot( tanToWorld1, tanNormal2504_g63859 ), dot( tanToWorld2, tanNormal2504_g63859 ) ) );
					float3 World_Normal2508_g63859 = worldNormal2504_g63859;
					float3 tanNormal2_g63901 = World_Normal2508_g63859;
					float3 worldNormal2_g63901 = float3( dot( tanToWorld0, tanNormal2_g63901 ), dot( tanToWorld1, tanNormal2_g63901 ), dot( tanToWorld2, tanNormal2_g63901 ) );
					float3 temp_output_3_0_g63901 = ddx( worldNormal2_g63901 );
					float dotResult5_g63901 = dot( temp_output_3_0_g63901 , temp_output_3_0_g63901 );
					float3 temp_output_4_0_g63901 = ddy( worldNormal2_g63901 );
					float dotResult6_g63901 = dot( temp_output_4_0_g63901 , temp_output_4_0_g63901 );
					#ifdef _USEGEOMETRICAA_ON
					float staticSwitch15_g63901 = min( temp_output_19_0_g63901, ( 1.0 - pow( saturate( max( dotResult5_g63901, dotResult6_g63901 ) ) , 0.25 ) ) );
					#else
					float staticSwitch15_g63901 = temp_output_19_0_g63901;
					#endif
					float Smoothness1399_g63859 = staticSwitch15_g63901;
					float Smoothness1_g63915 = Smoothness1399_g63859;
					float3 ase_positionWS = IN.ase_texcoord4.xyz;
					float3 ase_viewVectorWS = ( ( unity_OrthoParams.w == 0 ) ? _WorldSpaceCameraPos - ase_positionWS : UNITY_MATRIX_V[ 2 ].xyz );
					float3 ase_viewDirWS = normalize( ase_viewVectorWS );
					float3 View_Direction2511_g63859 = ase_viewDirWS;
					float3 ViewDir1_g63915 = View_Direction2511_g63859;
					float3 World_Position2505_g63859 = ase_positionWS;
					float3 WorldPos1_g63915 = World_Position2505_g63859;
					float3 WorldNormal1_g63915 = World_Normal2508_g63859;
					float4 temp_cast_2 = (Black1185_g63859).xxxx;
					float4 texCoord2426_g63859 = IN.ase_texcoord;
					texCoord2426_g63859.xy = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
					float2 UV0B2361_g63859 = (texCoord2426_g63859).zw;
					float localBicubicPrepare2_g63868 = ( 0.0 );
					float2 Input_UV100_g63868 = UV0B2361_g63859;
					float2 UV2_g63868 = Input_UV100_g63868;
					float4 TexelSize2_g63868 = _Lightmap0_TexelSize;
					float2 UV02_g63868 = float2( 0,0 );
					float2 UV12_g63868 = float2( 0,0 );
					float2 UV22_g63868 = float2( 0,0 );
					float2 UV32_g63868 = float2( 0,0 );
					float W02_g63868 = 0;
					float W12_g63868 = 0;
					{
					{
					 UV2_g63868 = UV2_g63868 * TexelSize2_g63868.zw - 0.5;
					    float2 f = frac( UV2_g63868 );
					    UV2_g63868 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g63868.x - 0.5, UV2_g63868.x + 1.5, UV2_g63868.y - 0.5, UV2_g63868.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g63868.xyxy;
					    UV02_g63868 = off.xz;
					    UV12_g63868 = off.yz;
					    UV22_g63868 = off.xw;
					    UV32_g63868 = off.yw;
					    W02_g63868 = s.x / ( s.x + s.y );
					 W12_g63868 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g63868 = lerp( tex2D( _Lightmap0, UV32_g63868 ) , tex2D( _Lightmap0, UV22_g63868 ) , W02_g63868);
					float4 lerpResult45_g63868 = lerp( tex2D( _Lightmap0, UV12_g63868 ) , tex2D( _Lightmap0, UV02_g63868 ) , W02_g63868);
					float4 lerpResult44_g63868 = lerp( lerpResult46_g63868 , lerpResult45_g63868 , W12_g63868);
					float4 Output_2D_Auto131_g63868 = lerpResult44_g63868;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g63859 = Output_2D_Auto131_g63868;
					#else
					float4 staticSwitch1092_g63859 = float4( tex2D( _Lightmap0, UV0B2361_g63859 ).rgb , 0.0 );
					#endif
					float4 Lightmap_0925_g63859 = staticSwitch1092_g63859;
					float localBicubicPrepare2_g63866 = ( 0.0 );
					float2 Input_UV100_g63866 = UV0B2361_g63859;
					float2 UV2_g63866 = Input_UV100_g63866;
					float4 TexelSize2_g63866 = _Lightmap1_TexelSize;
					float2 UV02_g63866 = float2( 0,0 );
					float2 UV12_g63866 = float2( 0,0 );
					float2 UV22_g63866 = float2( 0,0 );
					float2 UV32_g63866 = float2( 0,0 );
					float W02_g63866 = 0;
					float W12_g63866 = 0;
					{
					{
					 UV2_g63866 = UV2_g63866 * TexelSize2_g63866.zw - 0.5;
					    float2 f = frac( UV2_g63866 );
					    UV2_g63866 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g63866.x - 0.5, UV2_g63866.x + 1.5, UV2_g63866.y - 0.5, UV2_g63866.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g63866.xyxy;
					    UV02_g63866 = off.xz;
					    UV12_g63866 = off.yz;
					    UV22_g63866 = off.xw;
					    UV32_g63866 = off.yw;
					    W02_g63866 = s.x / ( s.x + s.y );
					 W12_g63866 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g63866 = lerp( tex2D( _Lightmap1, UV32_g63866 ) , tex2D( _Lightmap1, UV22_g63866 ) , W02_g63866);
					float4 lerpResult45_g63866 = lerp( tex2D( _Lightmap1, UV12_g63866 ) , tex2D( _Lightmap1, UV02_g63866 ) , W02_g63866);
					float4 lerpResult44_g63866 = lerp( lerpResult46_g63866 , lerpResult45_g63866 , W12_g63866);
					float4 Output_2D_Auto131_g63866 = lerpResult44_g63866;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g63859 = Output_2D_Auto131_g63866;
					#else
					float4 staticSwitch1088_g63859 = tex2D( _Lightmap1, UV0B2361_g63859 );
					#endif
					float4 Lightmap_1956_g63859 = staticSwitch1088_g63859;
					float Lightmap_Lerp_Value969_g63859 = _UdonLightmapLerp;
					float4 lerpResult442_g63859 = lerp( Lightmap_0925_g63859 , Lightmap_1956_g63859 , Lightmap_Lerp_Value969_g63859);
					float4 Lightmap_Lerp932_g63859 = lerpResult442_g63859;
					float3 appendResult139_g63907 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 Normal_Map318_g63907 = Normal700_g63859;
					float dotResult121_g63907 = dot( appendResult139_g63907 , Normal_Map318_g63907 );
					float temp_output_2_0_g63909 = saturate( dotResult121_g63907 );
					float localStochasticTiling2_g63890 = ( 0.0 );
					float2 UV2_g63890 = UV0B2361_g63859;
					float4 TexelSize2_g63890 = _UdonRNMX0_TexelSize;
					float4 Offsets2_g63890 = float4( 0,0,0,0 );
					float2 Weights2_g63890 = float2( 0,0 );
					{
					UV2_g63890 = UV2_g63890 * TexelSize2_g63890.zw - 0.5;
					float2 f = frac( UV2_g63890 );
					UV2_g63890 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g63890.x - 0.5, UV2_g63890.x + 1.5, UV2_g63890.y - 0.5, UV2_g63890.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g63890 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g63890.xyxy;
					Weights2_g63890 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g63889 = Offsets2_g63890;
					float4 Input_FetchOffsets197_g63891 = temp_output_1_34_g63889;
					float2 temp_output_1_54_g63889 = Weights2_g63890;
					float2 Input_FetchWeights200_g63891 = temp_output_1_54_g63889;
					float2 break187_g63891 = Input_FetchWeights200_g63891;
					float4 lerpResult181_g63891 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g63891).yw ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g63891).xw ) , break187_g63891.x);
					float4 lerpResult182_g63891 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g63891).yz ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g63891).xz ) , break187_g63891.x);
					float4 lerpResult176_g63891 = lerp( lerpResult181_g63891 , lerpResult182_g63891 , break187_g63891.y);
					float4 Output_Fetch2D_Auto202_g63891 = lerpResult176_g63891;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g63859 = Output_Fetch2D_Auto202_g63891;
					#else
					float4 staticSwitch1061_g63859 = tex2D( _UdonRNMX0, UV0B2361_g63859 );
					#endif
					float3 appendResult146_g63907 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g63907 = dot( appendResult146_g63907 , Normal_Map318_g63907 );
					float temp_output_2_0_g63908 = saturate( dotResult122_g63907 );
					float4 Input_FetchOffsets197_g63892 = temp_output_1_34_g63889;
					float2 Input_FetchWeights200_g63892 = temp_output_1_54_g63889;
					float2 break187_g63892 = Input_FetchWeights200_g63892;
					float4 lerpResult181_g63892 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g63892).yw ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g63892).xw ) , break187_g63892.x);
					float4 lerpResult182_g63892 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g63892).yz ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g63892).xz ) , break187_g63892.x);
					float4 lerpResult176_g63892 = lerp( lerpResult181_g63892 , lerpResult182_g63892 , break187_g63892.y);
					float4 Output_Fetch2D_Auto202_g63892 = lerpResult176_g63892;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g63859 = Output_Fetch2D_Auto202_g63892;
					#else
					float4 staticSwitch1062_g63859 = tex2D( _UdonRNMY0, UV0B2361_g63859 );
					#endif
					float3 appendResult149_g63907 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g63907 = dot( appendResult149_g63907 , Normal_Map318_g63907 );
					float temp_output_2_0_g63910 = saturate( dotResult120_g63907 );
					float4 Input_FetchOffsets197_g63893 = temp_output_1_34_g63889;
					float2 Input_FetchWeights200_g63893 = temp_output_1_54_g63889;
					float2 break187_g63893 = Input_FetchWeights200_g63893;
					float4 lerpResult181_g63893 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g63893).yw ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g63893).xw ) , break187_g63893.x);
					float4 lerpResult182_g63893 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g63893).yz ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g63893).xz ) , break187_g63893.x);
					float4 lerpResult176_g63893 = lerp( lerpResult181_g63893 , lerpResult182_g63893 , break187_g63893.y);
					float4 Output_Fetch2D_Auto202_g63893 = lerpResult176_g63893;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g63859 = Output_Fetch2D_Auto202_g63893;
					#else
					float4 staticSwitch1063_g63859 = tex2D( _UdonRNMZ0, UV0B2361_g63859 );
					#endif
					float4 temp_output_3094_0_g63859 = ( ( ( ( ( temp_output_2_0_g63909 * temp_output_2_0_g63909 ) * staticSwitch1061_g63859 ) + ( ( temp_output_2_0_g63908 * temp_output_2_0_g63908 ) * staticSwitch1062_g63859 ) ) + ( ( temp_output_2_0_g63910 * temp_output_2_0_g63910 ) * staticSwitch1063_g63859 ) ) * 1.2 );
					float4 RNM_0926_g63859 = temp_output_3094_0_g63859;
					float3 appendResult139_g63903 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 Normal_Map318_g63903 = Normal700_g63859;
					float dotResult121_g63903 = dot( appendResult139_g63903 , Normal_Map318_g63903 );
					float temp_output_2_0_g63905 = saturate( dotResult121_g63903 );
					float localStochasticTiling2_g63861 = ( 0.0 );
					float2 UV2_g63861 = UV0B2361_g63859;
					float4 TexelSize2_g63861 = _UdonRNMX1_TexelSize;
					float4 Offsets2_g63861 = float4( 0,0,0,0 );
					float2 Weights2_g63861 = float2( 0,0 );
					{
					UV2_g63861 = UV2_g63861 * TexelSize2_g63861.zw - 0.5;
					float2 f = frac( UV2_g63861 );
					UV2_g63861 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g63861.x - 0.5, UV2_g63861.x + 1.5, UV2_g63861.y - 0.5, UV2_g63861.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g63861 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g63861.xyxy;
					Weights2_g63861 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g63860 = Offsets2_g63861;
					float4 Input_FetchOffsets197_g63862 = temp_output_1_34_g63860;
					float2 temp_output_1_54_g63860 = Weights2_g63861;
					float2 Input_FetchWeights200_g63862 = temp_output_1_54_g63860;
					float2 break187_g63862 = Input_FetchWeights200_g63862;
					float4 lerpResult181_g63862 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g63862).yw ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g63862).xw ) , break187_g63862.x);
					float4 lerpResult182_g63862 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g63862).yz ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g63862).xz ) , break187_g63862.x);
					float4 lerpResult176_g63862 = lerp( lerpResult181_g63862 , lerpResult182_g63862 , break187_g63862.y);
					float4 Output_Fetch2D_Auto202_g63862 = lerpResult176_g63862;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g63859 = Output_Fetch2D_Auto202_g63862;
					#else
					float4 staticSwitch1087_g63859 = tex2D( _UdonRNMX1, UV0B2361_g63859 );
					#endif
					float3 appendResult146_g63903 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g63903 = dot( appendResult146_g63903 , Normal_Map318_g63903 );
					float temp_output_2_0_g63904 = saturate( dotResult122_g63903 );
					float4 Input_FetchOffsets197_g63863 = temp_output_1_34_g63860;
					float2 Input_FetchWeights200_g63863 = temp_output_1_54_g63860;
					float2 break187_g63863 = Input_FetchWeights200_g63863;
					float4 lerpResult181_g63863 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g63863).yw ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g63863).xw ) , break187_g63863.x);
					float4 lerpResult182_g63863 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g63863).yz ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g63863).xz ) , break187_g63863.x);
					float4 lerpResult176_g63863 = lerp( lerpResult181_g63863 , lerpResult182_g63863 , break187_g63863.y);
					float4 Output_Fetch2D_Auto202_g63863 = lerpResult176_g63863;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g63859 = Output_Fetch2D_Auto202_g63863;
					#else
					float4 staticSwitch1083_g63859 = tex2D( _UdonRNMY1, UV0B2361_g63859 );
					#endif
					float3 appendResult149_g63903 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g63903 = dot( appendResult149_g63903 , Normal_Map318_g63903 );
					float temp_output_2_0_g63906 = saturate( dotResult120_g63903 );
					float4 Input_FetchOffsets197_g63864 = temp_output_1_34_g63860;
					float2 Input_FetchWeights200_g63864 = temp_output_1_54_g63860;
					float2 break187_g63864 = Input_FetchWeights200_g63864;
					float4 lerpResult181_g63864 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g63864).yw ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g63864).xw ) , break187_g63864.x);
					float4 lerpResult182_g63864 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g63864).yz ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g63864).xz ) , break187_g63864.x);
					float4 lerpResult176_g63864 = lerp( lerpResult181_g63864 , lerpResult182_g63864 , break187_g63864.y);
					float4 Output_Fetch2D_Auto202_g63864 = lerpResult176_g63864;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g63859 = Output_Fetch2D_Auto202_g63864;
					#else
					float4 staticSwitch1084_g63859 = tex2D( _UdonRNMZ1, UV0B2361_g63859 );
					#endif
					float4 RNM_11081_g63859 = ( ( ( ( ( temp_output_2_0_g63905 * temp_output_2_0_g63905 ) * staticSwitch1087_g63859 ) + ( ( temp_output_2_0_g63904 * temp_output_2_0_g63904 ) * staticSwitch1083_g63859 ) ) + ( ( temp_output_2_0_g63906 * temp_output_2_0_g63906 ) * staticSwitch1084_g63859 ) ) * 1.2 );
					float4 lerpResult953_g63859 = lerp( RNM_0926_g63859 , RNM_11081_g63859 , Lightmap_Lerp_Value969_g63859);
					float4 RNM_Lerp950_g63859 = lerpResult953_g63859;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g63859 = temp_cast_2;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g63859 = Lightmap_0925_g63859;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g63859 = Lightmap_Lerp932_g63859;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g63859 = RNM_0926_g63859;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g63859 = RNM_Lerp950_g63859;
					#else
					float4 staticSwitch1014_g63859 = temp_cast_2;
					#endif
					float3 Lightmap46_g63859 = (staticSwitch1014_g63859).rgb;
					float dotResult9_g63916 = dot( float3( 0.212673, 0.715152, 0.072175 ) , Lightmap46_g63859 );
					float smoothstepResult14_g63916 = smoothstep( 0.0 , 0.1 , dotResult9_g63916);
					float Indirect_Lightmap_Mask3118_g63859 = smoothstepResult14_g63916;
					float LightmapMask1_g63915 = Indirect_Lightmap_Mask3118_g63859;
					float3 localIndirectSpecular1_g63915 = IndirectSpecular( Color1_g63915 , Metallic1_g63915 , Smoothness1_g63915 , ViewDir1_g63915 , WorldPos1_g63915 , WorldNormal1_g63915 , LightmapMask1_g63915 );
					#ifdef _INDIRECTSPECULARS_ON
					float3 staticSwitch2971_g63859 = localIndirectSpecular1_g63915;
					#else
					float3 staticSwitch2971_g63859 = temp_cast_1;
					#endif
					float3 Indirect_Specular1419_g63859 = staticSwitch2971_g63859;
					float3 temp_cast_4 = (Black1185_g63859).xxx;
					float3 Color97_g63918 = oAlbedo6_g63859;
					float Metallic97_g63918 = Metallic1239_g63859;
					float Smoothness97_g63918 = Smoothness1399_g63859;
					float3 ViewDir97_g63918 = View_Direction2511_g63859;
					float3 WorldPos97_g63918 = World_Position2505_g63859;
					float3 WorldNormal97_g63918 = World_Normal2508_g63859;
					float3 Vertex_Normal3161_g63859 = IN.ase_normal;
					float3 GeoNormal97_g63918 = Vertex_Normal3161_g63859;
					float White38_g63859 = 1.0;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float staticSwitch3107_g63859 = Black1185_g63859;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float staticSwitch3107_g63859 = White38_g63859;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float staticSwitch3107_g63859 = White38_g63859;
					#elif defined( _LIGHTMAPMODE_RNM )
					float staticSwitch3107_g63859 = White38_g63859;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float staticSwitch3107_g63859 = White38_g63859;
					#else
					float staticSwitch3107_g63859 = Black1185_g63859;
					#endif
					float LightmapMode97_g63918 = staticSwitch3107_g63859;
					float dotResult9_g63917 = dot( float3( 0.212673, 0.715152, 0.072175 ) , Lightmap46_g63859 );
					float smoothstepResult2_g63917 = smoothstep( 0.0 , 0.1 , dotResult9_g63917);
					float Direct_Lightmap_Mask3067_g63859 = smoothstepResult2_g63917;
					float LightmapMask97_g63918 = Direct_Lightmap_Mask3067_g63859;
					float3 localDirectSpecular97_g63918 = DirectSpecular( Color97_g63918 , Metallic97_g63918 , Smoothness97_g63918 , ViewDir97_g63918 , WorldPos97_g63918 , WorldNormal97_g63918 , GeoNormal97_g63918 , LightmapMode97_g63918 , LightmapMask97_g63918 );
					#ifdef _DIRECTSPECULAR_ON
					float3 staticSwitch2969_g63859 = localDirectSpecular97_g63918;
					#else
					float3 staticSwitch2969_g63859 = temp_cast_4;
					#endif
					float3 Direct_Specular2560_g63859 = staticSwitch2969_g63859;
					float3 aAlbedo1466_g63859 = ( temp_output_2532_0_g63859 * ( 1.0 - Metallic1239_g63859 ) );
					float3 temp_output_1252_0_g63859 = ( aAlbedo1466_g63859 * Lightmap46_g63859 );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch1_g63902 = float4( ( temp_output_1252_0_g63859 + Emission86_g63859 + Indirect_Specular1419_g63859 ) , 0.0 );
					#else
					float4 staticSwitch1_g63902 = float4( ( Emission86_g63859 + Indirect_Specular1419_g63859 + Direct_Specular2560_g63859 + temp_output_1252_0_g63859 ) , 0.0 );
					#endif
					#ifdef _LIGHTMAPDEBUG
					float4 staticSwitch1181_g63859 = float4( Lightmap46_g63859 , 0.0 );
					#else
					float4 staticSwitch1181_g63859 = staticSwitch1_g63902;
					#endif
					float4 Color357_g63899 = staticSwitch1181_g63859;
					float4 LUT51_g63899 = tex3D( _LUT, ( ( log10( ( ( (Color357_g63899).xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 ) );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch359_g63899 = LUT51_g63899;
					#else
					float4 staticSwitch359_g63899 = Color357_g63899;
					#endif
					

					float4 Color = staticSwitch359_g63899;
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

	
	}
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
	
	Fallback Off
}
/*ASEBEGIN
Version=19909
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;6378;-64,-1280;Inherit;False;Meenphie;0;;63859;b3ba55a08dd6b49c7be16c6f35cf2033;6,1008,0,2632,0,2635,0,2619,0,2670,0,2636,0;0;3;FLOAT4;624;FLOAT;156;FLOAT;427
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;6274;256,-1280;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;7;Meenphie/Standard/Opaque;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;7;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;False;;True;2;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;5;Alpha Clipping;0;0;  Use Shadow Threshold;0;0;Cast Shadows;0;639163672731073790;Write Depth;0;0;Vertex Position;1;0;0;2;True;False;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;6275;256,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;7;New Amplify Shader;0770190933193b94aaa3065e307002fa;True;ShadowCaster;0;1;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;False;;True;2;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
WireConnection;6274;0;6378;624
ASEEND*/
//CHKSM=8E5E8BB9774C8FD9323252CA53071DA6CC45C801