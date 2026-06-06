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
		_Offset( "Offset", Float ) = 0
		[HideInInspector] GenKey__MetallicMap( "Assign keyword _METALLICMAP", Float ) = 1.0
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0
		[HideInInspector] GenKey__GlossinessMap( "Assign keyword _GLOSSINESSMAP", Float ) = 1.0
		[HideInInspector] GenKey__MainTex( "Assign keyword _MAINTEX", Float ) = 1.0

	}

	SubShader
	{
		

		

		/*ase_tags*/
		Tags { "RenderType"="Opaque" "Queue"="Geometry" }

		Cull Off

	LOD 0

		

		Blend Off
		AlphaToMask Off
		ColorMask RGBA
		ZWrite On
		ZClip True
		ZTest LEqual
		Offset [_Offset] , [_Offset]
		

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
			#define ASE_NEEDS_TEXTURE_COORDINATES2
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#pragma shader_feature _LIGHTMAPDEBUG
			#pragma shader_feature_local _STOCHASTICENABLED_ON
			#pragma shader_feature_local_fragment _EMISSIONUV_UV0 _EMISSIONUV_UV2
			#pragma shader_feature_local _INDIRECTSPECULARS_ON
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
			uniform float _Offset;
			uniform float3 _EmissionColor;
			uniform sampler2D _EmissionMap;
			sampler2D _Sampler82968_g59838;
			uniform float _EmissionIntensity;
			uniform half4 _Color;
			uniform sampler2D _MainTex;
			sampler2D _Sampler82966_g59838;
			uniform float _Metallic;
			uniform sampler2D _MetallicMap;
			sampler2D _Sampler82967_g59838;
			uniform float _Glossiness;
			uniform sampler2D _GlossinessMap;
			sampler2D _Sampler82964_g59838;
			uniform sampler2D _BumpMap;
			sampler2D _Sampler82965_g59838;
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
				o.ase_normal = v.normal;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.zw = 0;
				o.ase_texcoord2.w = 0;
				o.ase_texcoord3.w = 0;
				o.ase_texcoord4.w = 0;
				o.ase_texcoord5.w = 0;

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

				float2 texCoord2357_g59838 = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float2 UV0A2420_g59838 = texCoord2357_g59838;
				float2 texCoord2594_g59838 = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 UV2__Decals2595_g59838 = texCoord2594_g59838;
				#if defined( _EMISSIONUV_UV0 )
				float2 staticSwitch2642_g59838 = UV0A2420_g59838;
				#elif defined( _EMISSIONUV_UV2 )
				float2 staticSwitch2642_g59838 = UV2__Decals2595_g59838;
				#else
				float2 staticSwitch2642_g59838 = UV0A2420_g59838;
				#endif
				float2 temp_output_5_0_g59863 = staticSwitch2642_g59838;
				float2 UV633_g59863 = temp_output_5_0_g59863;
				float2 UV100_g59864 = UV633_g59863;
				float2 temp_output_51_0_g59864 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59864 * float2( 3.464,3.464 ) ) );
				float2 break55_g59864 = frac( temp_output_51_0_g59864 );
				float temp_output_56_0_g59864 = ( ( 1.0 - break55_g59864.x ) - break55_g59864.y );
				float2 temp_output_52_0_g59864 = floor( temp_output_51_0_g59864 );
				float2 temp_output_125_0_g59864 = ( temp_output_52_0_g59864 + float2( 1,1 ) );
				float2 ifLocalVar87_g59864 = 0;
				if( temp_output_56_0_g59864 > 0.0 )
				ifLocalVar87_g59864 = temp_output_52_0_g59864;
				else if( temp_output_56_0_g59864 == 0.0 )
				ifLocalVar87_g59864 = temp_output_125_0_g59864;
				else if( temp_output_56_0_g59864 < 0.0 )
				ifLocalVar87_g59864 = temp_output_125_0_g59864;
				float3 temp_output_7_0_g59865 = frac( ( (ifLocalVar87_g59864).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g59865 = dot( temp_output_7_0_g59865 , ( (temp_output_7_0_g59865).yzx + 33.33 ) );
				float3 temp_output_12_0_g59865 = ( temp_output_7_0_g59865 + dotResult8_g59865 );
				float2 temp_output_597_0_g59863 = ( UV100_g59864 + frac( ( ( (temp_output_12_0_g59865).xx + (temp_output_12_0_g59865).yz ) * (temp_output_12_0_g59865).zy ) ) );
				float2 DDX631_g59863 = ddx( temp_output_5_0_g59863 );
				float2 DDY632_g59863 = ddy( temp_output_5_0_g59863 );
				float temp_output_65_0_g59864 = ( 0.0 - temp_output_56_0_g59864 );
				float ifLocalVar59_g59864 = 0;
				if( temp_output_56_0_g59864 <= 0.0 )
				ifLocalVar59_g59864 = temp_output_65_0_g59864;
				else
				ifLocalVar59_g59864 = temp_output_56_0_g59864;
				float temp_output_597_30_g59863 = ifLocalVar59_g59864;
				float2 temp_output_90_0_g59864 = ( temp_output_52_0_g59864 + float2( 0,1 ) );
				float2 temp_output_123_0_g59864 = ( temp_output_52_0_g59864 + float2( 1,0 ) );
				float2 ifLocalVar88_g59864 = 0;
				if( temp_output_56_0_g59864 > 0.0 )
				ifLocalVar88_g59864 = temp_output_90_0_g59864;
				else if( temp_output_56_0_g59864 == 0.0 )
				ifLocalVar88_g59864 = temp_output_123_0_g59864;
				else if( temp_output_56_0_g59864 < 0.0 )
				ifLocalVar88_g59864 = temp_output_123_0_g59864;
				float3 temp_output_7_0_g59866 = frac( ( (ifLocalVar88_g59864).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g59866 = dot( temp_output_7_0_g59866 , ( (temp_output_7_0_g59866).yzx + 33.33 ) );
				float3 temp_output_12_0_g59866 = ( temp_output_7_0_g59866 + dotResult8_g59866 );
				float2 temp_output_597_26_g59863 = ( UV100_g59864 + frac( ( ( (temp_output_12_0_g59866).xx + (temp_output_12_0_g59866).yz ) * (temp_output_12_0_g59866).zy ) ) );
				float temp_output_66_0_g59864 = ( 1.0 - break55_g59864.y );
				float ifLocalVar60_g59864 = 0;
				if( temp_output_56_0_g59864 <= 0.0 )
				ifLocalVar60_g59864 = temp_output_66_0_g59864;
				else
				ifLocalVar60_g59864 = break55_g59864.y;
				float temp_output_597_28_g59863 = ifLocalVar60_g59864;
				float2 ifLocalVar89_g59864 = 0;
				if( temp_output_56_0_g59864 > 0.0 )
				ifLocalVar89_g59864 = temp_output_123_0_g59864;
				else if( temp_output_56_0_g59864 == 0.0 )
				ifLocalVar89_g59864 = temp_output_90_0_g59864;
				else if( temp_output_56_0_g59864 < 0.0 )
				ifLocalVar89_g59864 = temp_output_90_0_g59864;
				float3 temp_output_7_0_g59867 = frac( ( (ifLocalVar89_g59864).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g59867 = dot( temp_output_7_0_g59867 , ( (temp_output_7_0_g59867).yzx + 33.33 ) );
				float3 temp_output_12_0_g59867 = ( temp_output_7_0_g59867 + dotResult8_g59867 );
				float2 temp_output_597_27_g59863 = ( UV100_g59864 + frac( ( ( (temp_output_12_0_g59867).xx + (temp_output_12_0_g59867).yz ) * (temp_output_12_0_g59867).zy ) ) );
				float temp_output_67_0_g59864 = ( 1.0 - break55_g59864.x );
				float ifLocalVar61_g59864 = 0;
				if( temp_output_56_0_g59864 <= 0.0 )
				ifLocalVar61_g59864 = temp_output_67_0_g59864;
				else
				ifLocalVar61_g59864 = break55_g59864.x;
				float temp_output_597_29_g59863 = ifLocalVar61_g59864;
				float4 Output_2D293_g59863 = ( ( tex2D( _Sampler82968_g59838, temp_output_597_0_g59863, DDX631_g59863, DDY632_g59863 ) * temp_output_597_30_g59863 ) + ( tex2D( _Sampler82968_g59838, temp_output_597_26_g59863, DDX631_g59863, DDY632_g59863 ) * temp_output_597_28_g59863 ) + ( tex2D( _Sampler82968_g59838, temp_output_597_27_g59863, DDX631_g59863, DDY632_g59863 ) * temp_output_597_29_g59863 ) );
				#ifdef _STOCHASTICENABLED_ON
				float4 staticSwitch1006_g59838 = Output_2D293_g59863;
				#else
				float4 staticSwitch1006_g59838 = tex2D( _EmissionMap, staticSwitch2642_g59838 );
				#endif
				float3 temp_output_2531_0_g59838 = (( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g59838 * _EmissionIntensity )).rgb;
				float3 Emission86_g59838 = temp_output_2531_0_g59838;
				float Black1185_g59838 = 0.0;
				float3 temp_cast_1 = (Black1185_g59838).xxx;
				float2 temp_output_5_0_g59853 = UV2__Decals2595_g59838;
				float2 UV633_g59853 = temp_output_5_0_g59853;
				float2 UV100_g59854 = UV633_g59853;
				float2 temp_output_51_0_g59854 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59854 * float2( 3.464,3.464 ) ) );
				float2 break55_g59854 = frac( temp_output_51_0_g59854 );
				float temp_output_56_0_g59854 = ( ( 1.0 - break55_g59854.x ) - break55_g59854.y );
				float2 temp_output_52_0_g59854 = floor( temp_output_51_0_g59854 );
				float2 temp_output_125_0_g59854 = ( temp_output_52_0_g59854 + float2( 1,1 ) );
				float2 ifLocalVar87_g59854 = 0;
				if( temp_output_56_0_g59854 > 0.0 )
				ifLocalVar87_g59854 = temp_output_52_0_g59854;
				else if( temp_output_56_0_g59854 == 0.0 )
				ifLocalVar87_g59854 = temp_output_125_0_g59854;
				else if( temp_output_56_0_g59854 < 0.0 )
				ifLocalVar87_g59854 = temp_output_125_0_g59854;
				float3 temp_output_7_0_g59855 = frac( ( (ifLocalVar87_g59854).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g59855 = dot( temp_output_7_0_g59855 , ( (temp_output_7_0_g59855).yzx + 33.33 ) );
				float3 temp_output_12_0_g59855 = ( temp_output_7_0_g59855 + dotResult8_g59855 );
				float2 temp_output_597_0_g59853 = ( UV100_g59854 + frac( ( ( (temp_output_12_0_g59855).xx + (temp_output_12_0_g59855).yz ) * (temp_output_12_0_g59855).zy ) ) );
				float2 DDX631_g59853 = ddx( temp_output_5_0_g59853 );
				float2 DDY632_g59853 = ddy( temp_output_5_0_g59853 );
				float temp_output_65_0_g59854 = ( 0.0 - temp_output_56_0_g59854 );
				float ifLocalVar59_g59854 = 0;
				if( temp_output_56_0_g59854 <= 0.0 )
				ifLocalVar59_g59854 = temp_output_65_0_g59854;
				else
				ifLocalVar59_g59854 = temp_output_56_0_g59854;
				float temp_output_597_30_g59853 = ifLocalVar59_g59854;
				float2 temp_output_90_0_g59854 = ( temp_output_52_0_g59854 + float2( 0,1 ) );
				float2 temp_output_123_0_g59854 = ( temp_output_52_0_g59854 + float2( 1,0 ) );
				float2 ifLocalVar88_g59854 = 0;
				if( temp_output_56_0_g59854 > 0.0 )
				ifLocalVar88_g59854 = temp_output_90_0_g59854;
				else if( temp_output_56_0_g59854 == 0.0 )
				ifLocalVar88_g59854 = temp_output_123_0_g59854;
				else if( temp_output_56_0_g59854 < 0.0 )
				ifLocalVar88_g59854 = temp_output_123_0_g59854;
				float3 temp_output_7_0_g59856 = frac( ( (ifLocalVar88_g59854).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g59856 = dot( temp_output_7_0_g59856 , ( (temp_output_7_0_g59856).yzx + 33.33 ) );
				float3 temp_output_12_0_g59856 = ( temp_output_7_0_g59856 + dotResult8_g59856 );
				float2 temp_output_597_26_g59853 = ( UV100_g59854 + frac( ( ( (temp_output_12_0_g59856).xx + (temp_output_12_0_g59856).yz ) * (temp_output_12_0_g59856).zy ) ) );
				float temp_output_66_0_g59854 = ( 1.0 - break55_g59854.y );
				float ifLocalVar60_g59854 = 0;
				if( temp_output_56_0_g59854 <= 0.0 )
				ifLocalVar60_g59854 = temp_output_66_0_g59854;
				else
				ifLocalVar60_g59854 = break55_g59854.y;
				float temp_output_597_28_g59853 = ifLocalVar60_g59854;
				float2 ifLocalVar89_g59854 = 0;
				if( temp_output_56_0_g59854 > 0.0 )
				ifLocalVar89_g59854 = temp_output_123_0_g59854;
				else if( temp_output_56_0_g59854 == 0.0 )
				ifLocalVar89_g59854 = temp_output_90_0_g59854;
				else if( temp_output_56_0_g59854 < 0.0 )
				ifLocalVar89_g59854 = temp_output_90_0_g59854;
				float3 temp_output_7_0_g59857 = frac( ( (ifLocalVar89_g59854).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g59857 = dot( temp_output_7_0_g59857 , ( (temp_output_7_0_g59857).yzx + 33.33 ) );
				float3 temp_output_12_0_g59857 = ( temp_output_7_0_g59857 + dotResult8_g59857 );
				float2 temp_output_597_27_g59853 = ( UV100_g59854 + frac( ( ( (temp_output_12_0_g59857).xx + (temp_output_12_0_g59857).yz ) * (temp_output_12_0_g59857).zy ) ) );
				float temp_output_67_0_g59854 = ( 1.0 - break55_g59854.x );
				float ifLocalVar61_g59854 = 0;
				if( temp_output_56_0_g59854 <= 0.0 )
				ifLocalVar61_g59854 = temp_output_67_0_g59854;
				else
				ifLocalVar61_g59854 = break55_g59854.x;
				float temp_output_597_29_g59853 = ifLocalVar61_g59854;
				float4 Output_2D293_g59853 = ( ( tex2D( _Sampler82966_g59838, temp_output_597_0_g59853, DDX631_g59853, DDY632_g59853 ) * temp_output_597_30_g59853 ) + ( tex2D( _Sampler82966_g59838, temp_output_597_26_g59853, DDX631_g59853, DDY632_g59853 ) * temp_output_597_28_g59853 ) + ( tex2D( _Sampler82966_g59838, temp_output_597_27_g59853, DDX631_g59853, DDY632_g59853 ) * temp_output_597_29_g59853 ) );
				#ifdef _STOCHASTICENABLED_ON
				float4 staticSwitch1001_g59838 = Output_2D293_g59853;
				#else
				float4 staticSwitch1001_g59838 = ( _Color * tex2D( _MainTex, UV2__Decals2595_g59838 ) );
				#endif
				float3 temp_output_2532_0_g59838 = (staticSwitch1001_g59838).rgb;
				float3 oAlbedo6_g59838 = temp_output_2532_0_g59838;
				float3 Color1_g59991 = oAlbedo6_g59838;
				#if defined( _UV_UV0 )
				float2 staticSwitch2671_g59838 = UV0A2420_g59838;
				#elif defined( _UV_UV2 )
				float2 staticSwitch2671_g59838 = UV2__Decals2595_g59838;
				#else
				float2 staticSwitch2671_g59838 = UV2__Decals2595_g59838;
				#endif
				#ifdef _METALLICMAP
				float staticSwitch846_g59838 = tex2D( _MetallicMap, staticSwitch2671_g59838 ).r;
				#else
				float staticSwitch846_g59838 = _Metallic;
				#endif
				float2 temp_output_5_0_g59873 = staticSwitch2671_g59838;
				float2 UV633_g59873 = temp_output_5_0_g59873;
				float2 UV100_g59874 = UV633_g59873;
				float2 temp_output_51_0_g59874 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59874 * float2( 3.464,3.464 ) ) );
				float2 break55_g59874 = frac( temp_output_51_0_g59874 );
				float temp_output_56_0_g59874 = ( ( 1.0 - break55_g59874.x ) - break55_g59874.y );
				float2 temp_output_52_0_g59874 = floor( temp_output_51_0_g59874 );
				float2 temp_output_125_0_g59874 = ( temp_output_52_0_g59874 + float2( 1,1 ) );
				float2 ifLocalVar87_g59874 = 0;
				if( temp_output_56_0_g59874 > 0.0 )
				ifLocalVar87_g59874 = temp_output_52_0_g59874;
				else if( temp_output_56_0_g59874 == 0.0 )
				ifLocalVar87_g59874 = temp_output_125_0_g59874;
				else if( temp_output_56_0_g59874 < 0.0 )
				ifLocalVar87_g59874 = temp_output_125_0_g59874;
				float3 temp_output_7_0_g59875 = frac( ( (ifLocalVar87_g59874).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g59875 = dot( temp_output_7_0_g59875 , ( (temp_output_7_0_g59875).yzx + 33.33 ) );
				float3 temp_output_12_0_g59875 = ( temp_output_7_0_g59875 + dotResult8_g59875 );
				float2 temp_output_597_0_g59873 = ( UV100_g59874 + frac( ( ( (temp_output_12_0_g59875).xx + (temp_output_12_0_g59875).yz ) * (temp_output_12_0_g59875).zy ) ) );
				float2 DDX631_g59873 = ddx( temp_output_5_0_g59873 );
				float2 DDY632_g59873 = ddy( temp_output_5_0_g59873 );
				float temp_output_65_0_g59874 = ( 0.0 - temp_output_56_0_g59874 );
				float ifLocalVar59_g59874 = 0;
				if( temp_output_56_0_g59874 <= 0.0 )
				ifLocalVar59_g59874 = temp_output_65_0_g59874;
				else
				ifLocalVar59_g59874 = temp_output_56_0_g59874;
				float temp_output_597_30_g59873 = ifLocalVar59_g59874;
				float2 temp_output_90_0_g59874 = ( temp_output_52_0_g59874 + float2( 0,1 ) );
				float2 temp_output_123_0_g59874 = ( temp_output_52_0_g59874 + float2( 1,0 ) );
				float2 ifLocalVar88_g59874 = 0;
				if( temp_output_56_0_g59874 > 0.0 )
				ifLocalVar88_g59874 = temp_output_90_0_g59874;
				else if( temp_output_56_0_g59874 == 0.0 )
				ifLocalVar88_g59874 = temp_output_123_0_g59874;
				else if( temp_output_56_0_g59874 < 0.0 )
				ifLocalVar88_g59874 = temp_output_123_0_g59874;
				float3 temp_output_7_0_g59876 = frac( ( (ifLocalVar88_g59874).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g59876 = dot( temp_output_7_0_g59876 , ( (temp_output_7_0_g59876).yzx + 33.33 ) );
				float3 temp_output_12_0_g59876 = ( temp_output_7_0_g59876 + dotResult8_g59876 );
				float2 temp_output_597_26_g59873 = ( UV100_g59874 + frac( ( ( (temp_output_12_0_g59876).xx + (temp_output_12_0_g59876).yz ) * (temp_output_12_0_g59876).zy ) ) );
				float temp_output_66_0_g59874 = ( 1.0 - break55_g59874.y );
				float ifLocalVar60_g59874 = 0;
				if( temp_output_56_0_g59874 <= 0.0 )
				ifLocalVar60_g59874 = temp_output_66_0_g59874;
				else
				ifLocalVar60_g59874 = break55_g59874.y;
				float temp_output_597_28_g59873 = ifLocalVar60_g59874;
				float2 ifLocalVar89_g59874 = 0;
				if( temp_output_56_0_g59874 > 0.0 )
				ifLocalVar89_g59874 = temp_output_123_0_g59874;
				else if( temp_output_56_0_g59874 == 0.0 )
				ifLocalVar89_g59874 = temp_output_90_0_g59874;
				else if( temp_output_56_0_g59874 < 0.0 )
				ifLocalVar89_g59874 = temp_output_90_0_g59874;
				float3 temp_output_7_0_g59877 = frac( ( (ifLocalVar89_g59874).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g59877 = dot( temp_output_7_0_g59877 , ( (temp_output_7_0_g59877).yzx + 33.33 ) );
				float3 temp_output_12_0_g59877 = ( temp_output_7_0_g59877 + dotResult8_g59877 );
				float2 temp_output_597_27_g59873 = ( UV100_g59874 + frac( ( ( (temp_output_12_0_g59877).xx + (temp_output_12_0_g59877).yz ) * (temp_output_12_0_g59877).zy ) ) );
				float temp_output_67_0_g59874 = ( 1.0 - break55_g59874.x );
				float ifLocalVar61_g59874 = 0;
				if( temp_output_56_0_g59874 <= 0.0 )
				ifLocalVar61_g59874 = temp_output_67_0_g59874;
				else
				ifLocalVar61_g59874 = break55_g59874.x;
				float temp_output_597_29_g59873 = ifLocalVar61_g59874;
				float4 Output_2D293_g59873 = ( ( tex2D( _Sampler82967_g59838, temp_output_597_0_g59873, DDX631_g59873, DDY632_g59873 ) * temp_output_597_30_g59873 ) + ( tex2D( _Sampler82967_g59838, temp_output_597_26_g59873, DDX631_g59873, DDY632_g59873 ) * temp_output_597_28_g59873 ) + ( tex2D( _Sampler82967_g59838, temp_output_597_27_g59873, DDX631_g59873, DDY632_g59873 ) * temp_output_597_29_g59873 ) );
				float4 break31_g59873 = Output_2D293_g59873;
				#ifdef _STOCHASTICENABLED_ON
				float staticSwitch1005_g59838 = break31_g59873.r;
				#else
				float staticSwitch1005_g59838 = staticSwitch846_g59838;
				#endif
				float Metallic1239_g59838 = staticSwitch1005_g59838;
				float Metallic1_g59991 = Metallic1239_g59838;
				#if defined( _UV_UV0 )
				float2 staticSwitch2644_g59838 = UV0A2420_g59838;
				#elif defined( _UV_UV2 )
				float2 staticSwitch2644_g59838 = UV2__Decals2595_g59838;
				#else
				float2 staticSwitch2644_g59838 = UV2__Decals2595_g59838;
				#endif
				#ifdef _GLOSSINESSMAP
				float staticSwitch845_g59838 = tex2D( _GlossinessMap, staticSwitch2644_g59838 ).r;
				#else
				float staticSwitch845_g59838 = _Glossiness;
				#endif
				float2 temp_output_5_0_g59858 = staticSwitch2644_g59838;
				float2 UV633_g59858 = temp_output_5_0_g59858;
				float2 UV100_g59859 = UV633_g59858;
				float2 temp_output_51_0_g59859 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59859 * float2( 3.464,3.464 ) ) );
				float2 break55_g59859 = frac( temp_output_51_0_g59859 );
				float temp_output_56_0_g59859 = ( ( 1.0 - break55_g59859.x ) - break55_g59859.y );
				float2 temp_output_52_0_g59859 = floor( temp_output_51_0_g59859 );
				float2 temp_output_125_0_g59859 = ( temp_output_52_0_g59859 + float2( 1,1 ) );
				float2 ifLocalVar87_g59859 = 0;
				if( temp_output_56_0_g59859 > 0.0 )
				ifLocalVar87_g59859 = temp_output_52_0_g59859;
				else if( temp_output_56_0_g59859 == 0.0 )
				ifLocalVar87_g59859 = temp_output_125_0_g59859;
				else if( temp_output_56_0_g59859 < 0.0 )
				ifLocalVar87_g59859 = temp_output_125_0_g59859;
				float3 temp_output_7_0_g59860 = frac( ( (ifLocalVar87_g59859).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g59860 = dot( temp_output_7_0_g59860 , ( (temp_output_7_0_g59860).yzx + 33.33 ) );
				float3 temp_output_12_0_g59860 = ( temp_output_7_0_g59860 + dotResult8_g59860 );
				float2 temp_output_597_0_g59858 = ( UV100_g59859 + frac( ( ( (temp_output_12_0_g59860).xx + (temp_output_12_0_g59860).yz ) * (temp_output_12_0_g59860).zy ) ) );
				float2 DDX631_g59858 = ddx( temp_output_5_0_g59858 );
				float2 DDY632_g59858 = ddy( temp_output_5_0_g59858 );
				float temp_output_65_0_g59859 = ( 0.0 - temp_output_56_0_g59859 );
				float ifLocalVar59_g59859 = 0;
				if( temp_output_56_0_g59859 <= 0.0 )
				ifLocalVar59_g59859 = temp_output_65_0_g59859;
				else
				ifLocalVar59_g59859 = temp_output_56_0_g59859;
				float temp_output_597_30_g59858 = ifLocalVar59_g59859;
				float2 temp_output_90_0_g59859 = ( temp_output_52_0_g59859 + float2( 0,1 ) );
				float2 temp_output_123_0_g59859 = ( temp_output_52_0_g59859 + float2( 1,0 ) );
				float2 ifLocalVar88_g59859 = 0;
				if( temp_output_56_0_g59859 > 0.0 )
				ifLocalVar88_g59859 = temp_output_90_0_g59859;
				else if( temp_output_56_0_g59859 == 0.0 )
				ifLocalVar88_g59859 = temp_output_123_0_g59859;
				else if( temp_output_56_0_g59859 < 0.0 )
				ifLocalVar88_g59859 = temp_output_123_0_g59859;
				float3 temp_output_7_0_g59861 = frac( ( (ifLocalVar88_g59859).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g59861 = dot( temp_output_7_0_g59861 , ( (temp_output_7_0_g59861).yzx + 33.33 ) );
				float3 temp_output_12_0_g59861 = ( temp_output_7_0_g59861 + dotResult8_g59861 );
				float2 temp_output_597_26_g59858 = ( UV100_g59859 + frac( ( ( (temp_output_12_0_g59861).xx + (temp_output_12_0_g59861).yz ) * (temp_output_12_0_g59861).zy ) ) );
				float temp_output_66_0_g59859 = ( 1.0 - break55_g59859.y );
				float ifLocalVar60_g59859 = 0;
				if( temp_output_56_0_g59859 <= 0.0 )
				ifLocalVar60_g59859 = temp_output_66_0_g59859;
				else
				ifLocalVar60_g59859 = break55_g59859.y;
				float temp_output_597_28_g59858 = ifLocalVar60_g59859;
				float2 ifLocalVar89_g59859 = 0;
				if( temp_output_56_0_g59859 > 0.0 )
				ifLocalVar89_g59859 = temp_output_123_0_g59859;
				else if( temp_output_56_0_g59859 == 0.0 )
				ifLocalVar89_g59859 = temp_output_90_0_g59859;
				else if( temp_output_56_0_g59859 < 0.0 )
				ifLocalVar89_g59859 = temp_output_90_0_g59859;
				float3 temp_output_7_0_g59862 = frac( ( (ifLocalVar89_g59859).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g59862 = dot( temp_output_7_0_g59862 , ( (temp_output_7_0_g59862).yzx + 33.33 ) );
				float3 temp_output_12_0_g59862 = ( temp_output_7_0_g59862 + dotResult8_g59862 );
				float2 temp_output_597_27_g59858 = ( UV100_g59859 + frac( ( ( (temp_output_12_0_g59862).xx + (temp_output_12_0_g59862).yz ) * (temp_output_12_0_g59862).zy ) ) );
				float temp_output_67_0_g59859 = ( 1.0 - break55_g59859.x );
				float ifLocalVar61_g59859 = 0;
				if( temp_output_56_0_g59859 <= 0.0 )
				ifLocalVar61_g59859 = temp_output_67_0_g59859;
				else
				ifLocalVar61_g59859 = break55_g59859.x;
				float temp_output_597_29_g59858 = ifLocalVar61_g59859;
				float4 Output_2D293_g59858 = ( ( tex2D( _Sampler82964_g59838, temp_output_597_0_g59858, DDX631_g59858, DDY632_g59858 ) * temp_output_597_30_g59858 ) + ( tex2D( _Sampler82964_g59838, temp_output_597_26_g59858, DDX631_g59858, DDY632_g59858 ) * temp_output_597_28_g59858 ) + ( tex2D( _Sampler82964_g59838, temp_output_597_27_g59858, DDX631_g59858, DDY632_g59858 ) * temp_output_597_29_g59858 ) );
				float4 break31_g59858 = Output_2D293_g59858;
				#ifdef _STOCHASTICENABLED_ON
				float staticSwitch1004_g59838 = ( 1.0 - break31_g59858.r );
				#else
				float staticSwitch1004_g59838 = ( 1.0 - staticSwitch845_g59838 );
				#endif
				float temp_output_19_0_g59880 = staticSwitch1004_g59838;
				float2 temp_output_5_0_g59848 = UV0A2420_g59838;
				float2 UV633_g59848 = temp_output_5_0_g59848;
				float2 UV100_g59849 = UV633_g59848;
				float2 temp_output_51_0_g59849 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g59849 * float2( 3.464,3.464 ) ) );
				float2 break55_g59849 = frac( temp_output_51_0_g59849 );
				float temp_output_56_0_g59849 = ( ( 1.0 - break55_g59849.x ) - break55_g59849.y );
				float2 temp_output_52_0_g59849 = floor( temp_output_51_0_g59849 );
				float2 temp_output_125_0_g59849 = ( temp_output_52_0_g59849 + float2( 1,1 ) );
				float2 ifLocalVar87_g59849 = 0;
				if( temp_output_56_0_g59849 > 0.0 )
				ifLocalVar87_g59849 = temp_output_52_0_g59849;
				else if( temp_output_56_0_g59849 == 0.0 )
				ifLocalVar87_g59849 = temp_output_125_0_g59849;
				else if( temp_output_56_0_g59849 < 0.0 )
				ifLocalVar87_g59849 = temp_output_125_0_g59849;
				float3 temp_output_7_0_g59850 = frac( ( (ifLocalVar87_g59849).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g59850 = dot( temp_output_7_0_g59850 , ( (temp_output_7_0_g59850).yzx + 33.33 ) );
				float3 temp_output_12_0_g59850 = ( temp_output_7_0_g59850 + dotResult8_g59850 );
				float2 temp_output_597_0_g59848 = ( UV100_g59849 + frac( ( ( (temp_output_12_0_g59850).xx + (temp_output_12_0_g59850).yz ) * (temp_output_12_0_g59850).zy ) ) );
				float2 DDX631_g59848 = ddx( temp_output_5_0_g59848 );
				float2 DDY632_g59848 = ddy( temp_output_5_0_g59848 );
				float Input_Scale617_g59848 = 1.5;
				float temp_output_65_0_g59849 = ( 0.0 - temp_output_56_0_g59849 );
				float ifLocalVar59_g59849 = 0;
				if( temp_output_56_0_g59849 <= 0.0 )
				ifLocalVar59_g59849 = temp_output_65_0_g59849;
				else
				ifLocalVar59_g59849 = temp_output_56_0_g59849;
				float temp_output_597_30_g59848 = ifLocalVar59_g59849;
				float2 temp_output_90_0_g59849 = ( temp_output_52_0_g59849 + float2( 0,1 ) );
				float2 temp_output_123_0_g59849 = ( temp_output_52_0_g59849 + float2( 1,0 ) );
				float2 ifLocalVar88_g59849 = 0;
				if( temp_output_56_0_g59849 > 0.0 )
				ifLocalVar88_g59849 = temp_output_90_0_g59849;
				else if( temp_output_56_0_g59849 == 0.0 )
				ifLocalVar88_g59849 = temp_output_123_0_g59849;
				else if( temp_output_56_0_g59849 < 0.0 )
				ifLocalVar88_g59849 = temp_output_123_0_g59849;
				float3 temp_output_7_0_g59851 = frac( ( (ifLocalVar88_g59849).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g59851 = dot( temp_output_7_0_g59851 , ( (temp_output_7_0_g59851).yzx + 33.33 ) );
				float3 temp_output_12_0_g59851 = ( temp_output_7_0_g59851 + dotResult8_g59851 );
				float2 temp_output_597_26_g59848 = ( UV100_g59849 + frac( ( ( (temp_output_12_0_g59851).xx + (temp_output_12_0_g59851).yz ) * (temp_output_12_0_g59851).zy ) ) );
				float temp_output_66_0_g59849 = ( 1.0 - break55_g59849.y );
				float ifLocalVar60_g59849 = 0;
				if( temp_output_56_0_g59849 <= 0.0 )
				ifLocalVar60_g59849 = temp_output_66_0_g59849;
				else
				ifLocalVar60_g59849 = break55_g59849.y;
				float temp_output_597_28_g59848 = ifLocalVar60_g59849;
				float2 ifLocalVar89_g59849 = 0;
				if( temp_output_56_0_g59849 > 0.0 )
				ifLocalVar89_g59849 = temp_output_123_0_g59849;
				else if( temp_output_56_0_g59849 == 0.0 )
				ifLocalVar89_g59849 = temp_output_90_0_g59849;
				else if( temp_output_56_0_g59849 < 0.0 )
				ifLocalVar89_g59849 = temp_output_90_0_g59849;
				float3 temp_output_7_0_g59852 = frac( ( (ifLocalVar89_g59849).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g59852 = dot( temp_output_7_0_g59852 , ( (temp_output_7_0_g59852).yzx + 33.33 ) );
				float3 temp_output_12_0_g59852 = ( temp_output_7_0_g59852 + dotResult8_g59852 );
				float2 temp_output_597_27_g59848 = ( UV100_g59849 + frac( ( ( (temp_output_12_0_g59852).xx + (temp_output_12_0_g59852).yz ) * (temp_output_12_0_g59852).zy ) ) );
				float temp_output_67_0_g59849 = ( 1.0 - break55_g59849.x );
				float ifLocalVar61_g59849 = 0;
				if( temp_output_56_0_g59849 <= 0.0 )
				ifLocalVar61_g59849 = temp_output_67_0_g59849;
				else
				ifLocalVar61_g59849 = break55_g59849.x;
				float temp_output_597_29_g59848 = ifLocalVar61_g59849;
				float3 Output_2D_Normal641_g59848 = ( ( UnpackScaleNormal( tex2D( _Sampler82965_g59838, temp_output_597_0_g59848, DDX631_g59848, DDY632_g59848 ), Input_Scale617_g59848 ) * temp_output_597_30_g59848 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g59838, temp_output_597_26_g59848, DDX631_g59848, DDY632_g59848 ), Input_Scale617_g59848 ) * temp_output_597_28_g59848 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g59838, temp_output_597_27_g59848, DDX631_g59848, DDY632_g59848 ), Input_Scale617_g59848 ) * float3( 0,0,0 ) * temp_output_597_29_g59848 ) );
				#ifdef _STOCHASTICENABLED_ON
				float3 staticSwitch1003_g59838 = Output_2D_Normal641_g59848;
				#else
				float3 staticSwitch1003_g59838 = UnpackScaleNormal( tex2D( _BumpMap, UV0A2420_g59838 ), 1.5 );
				#endif
				#ifdef _BUMPMAP
				float3 staticSwitch980_g59838 = staticSwitch1003_g59838;
				#else
				float3 staticSwitch980_g59838 = float3( 0, 0, 1 );
				#endif
				float3 normalizeResult2878_g59838 = normalize( staticSwitch980_g59838 );
				float3 Normal700_g59838 = normalizeResult2878_g59838;
				float3 ase_tangentWS = IN.ase_texcoord2.xyz;
				float3 ase_normalWS = IN.ase_texcoord3.xyz;
				float3 ase_bitangentWS = IN.ase_texcoord4.xyz;
				float3 tanToWorld0 = float3( ase_tangentWS.x, ase_bitangentWS.x, ase_normalWS.x );
				float3 tanToWorld1 = float3( ase_tangentWS.y, ase_bitangentWS.y, ase_normalWS.y );
				float3 tanToWorld2 = float3( ase_tangentWS.z, ase_bitangentWS.z, ase_normalWS.z );
				float3 tanNormal2504_g59838 = Normal700_g59838;
				float3 worldNormal2504_g59838 = normalize( float3( dot( tanToWorld0, tanNormal2504_g59838 ), dot( tanToWorld1, tanNormal2504_g59838 ), dot( tanToWorld2, tanNormal2504_g59838 ) ) );
				float3 World_Normal2508_g59838 = worldNormal2504_g59838;
				float3 tanNormal2_g59880 = World_Normal2508_g59838;
				float3 worldNormal2_g59880 = float3( dot( tanToWorld0, tanNormal2_g59880 ), dot( tanToWorld1, tanNormal2_g59880 ), dot( tanToWorld2, tanNormal2_g59880 ) );
				float3 temp_output_3_0_g59880 = ddx( worldNormal2_g59880 );
				float dotResult5_g59880 = dot( temp_output_3_0_g59880 , temp_output_3_0_g59880 );
				float3 temp_output_4_0_g59880 = ddy( worldNormal2_g59880 );
				float dotResult6_g59880 = dot( temp_output_4_0_g59880 , temp_output_4_0_g59880 );
				#ifdef _USEGEOMETRICAA_ON
				float staticSwitch15_g59880 = min( temp_output_19_0_g59880, ( 1.0 - pow( saturate( max( dotResult5_g59880, dotResult6_g59880 ) ) , 0.25 ) ) );
				#else
				float staticSwitch15_g59880 = temp_output_19_0_g59880;
				#endif
				float Smoothness1399_g59838 = staticSwitch15_g59880;
				float Smoothness1_g59991 = Smoothness1399_g59838;
				float3 ase_positionWS = IN.ase_texcoord5.xyz;
				float3 ase_viewVectorWS = ( ( unity_OrthoParams.w == 0 ) ? _WorldSpaceCameraPos - ase_positionWS : UNITY_MATRIX_V[ 2 ].xyz );
				float3 ase_viewDirWS = normalize( ase_viewVectorWS );
				float3 View_Direction2511_g59838 = ase_viewDirWS;
				float3 ViewDir1_g59991 = View_Direction2511_g59838;
				float3 World_Position2505_g59838 = ase_positionWS;
				float3 WorldPos1_g59991 = World_Position2505_g59838;
				float3 WorldNormal1_g59991 = World_Normal2508_g59838;
				float4 temp_cast_2 = (Black1185_g59838).xxxx;
				float4 texCoord2426_g59838 = IN.ase_texcoord;
				texCoord2426_g59838.xy = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float2 UV0B2361_g59838 = (texCoord2426_g59838).zw;
				float localBicubicPrepare2_g59847 = ( 0.0 );
				float2 Input_UV100_g59847 = UV0B2361_g59838;
				float2 UV2_g59847 = Input_UV100_g59847;
				float4 TexelSize2_g59847 = _Lightmap0_TexelSize;
				float2 UV02_g59847 = float2( 0,0 );
				float2 UV12_g59847 = float2( 0,0 );
				float2 UV22_g59847 = float2( 0,0 );
				float2 UV32_g59847 = float2( 0,0 );
				float W02_g59847 = 0;
				float W12_g59847 = 0;
				{
				{
				 UV2_g59847 = UV2_g59847 * TexelSize2_g59847.zw - 0.5;
				    float2 f = frac( UV2_g59847 );
				    UV2_g59847 -= f;
				    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
				    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
				    float4 xs = xn * xn * xn;
				    float4 ys = yn * yn * yn;
				    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
				    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
				    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
				 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
				    float4 c = float4( UV2_g59847.x - 0.5, UV2_g59847.x + 1.5, UV2_g59847.y - 0.5, UV2_g59847.y + 1.5 );
				    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
				    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59847.xyxy;
				    UV02_g59847 = off.xz;
				    UV12_g59847 = off.yz;
				    UV22_g59847 = off.xw;
				    UV32_g59847 = off.yw;
				    W02_g59847 = s.x / ( s.x + s.y );
				 W12_g59847 = s.z / ( s.z + s.w );
				}
				}
				float4 lerpResult46_g59847 = lerp( tex2D( _Lightmap0, UV32_g59847 ) , tex2D( _Lightmap0, UV22_g59847 ) , W02_g59847);
				float4 lerpResult45_g59847 = lerp( tex2D( _Lightmap0, UV12_g59847 ) , tex2D( _Lightmap0, UV02_g59847 ) , W02_g59847);
				float4 lerpResult44_g59847 = lerp( lerpResult46_g59847 , lerpResult45_g59847 , W12_g59847);
				float4 Output_2D_Auto131_g59847 = lerpResult44_g59847;
				#ifdef _USEBICUBICFILTERING_ON
				float4 staticSwitch1092_g59838 = Output_2D_Auto131_g59847;
				#else
				float4 staticSwitch1092_g59838 = float4( tex2D( _Lightmap0, UV0B2361_g59838 ).rgb , 0.0 );
				#endif
				float4 Lightmap_0925_g59838 = staticSwitch1092_g59838;
				float localBicubicPrepare2_g59845 = ( 0.0 );
				float2 Input_UV100_g59845 = UV0B2361_g59838;
				float2 UV2_g59845 = Input_UV100_g59845;
				float4 TexelSize2_g59845 = _Lightmap1_TexelSize;
				float2 UV02_g59845 = float2( 0,0 );
				float2 UV12_g59845 = float2( 0,0 );
				float2 UV22_g59845 = float2( 0,0 );
				float2 UV32_g59845 = float2( 0,0 );
				float W02_g59845 = 0;
				float W12_g59845 = 0;
				{
				{
				 UV2_g59845 = UV2_g59845 * TexelSize2_g59845.zw - 0.5;
				    float2 f = frac( UV2_g59845 );
				    UV2_g59845 -= f;
				    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
				    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
				    float4 xs = xn * xn * xn;
				    float4 ys = yn * yn * yn;
				    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
				    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
				    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
				 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
				    float4 c = float4( UV2_g59845.x - 0.5, UV2_g59845.x + 1.5, UV2_g59845.y - 0.5, UV2_g59845.y + 1.5 );
				    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
				    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59845.xyxy;
				    UV02_g59845 = off.xz;
				    UV12_g59845 = off.yz;
				    UV22_g59845 = off.xw;
				    UV32_g59845 = off.yw;
				    W02_g59845 = s.x / ( s.x + s.y );
				 W12_g59845 = s.z / ( s.z + s.w );
				}
				}
				float4 lerpResult46_g59845 = lerp( tex2D( _Lightmap1, UV32_g59845 ) , tex2D( _Lightmap1, UV22_g59845 ) , W02_g59845);
				float4 lerpResult45_g59845 = lerp( tex2D( _Lightmap1, UV12_g59845 ) , tex2D( _Lightmap1, UV02_g59845 ) , W02_g59845);
				float4 lerpResult44_g59845 = lerp( lerpResult46_g59845 , lerpResult45_g59845 , W12_g59845);
				float4 Output_2D_Auto131_g59845 = lerpResult44_g59845;
				#ifdef _USEBICUBICFILTERING_ON
				float4 staticSwitch1088_g59838 = Output_2D_Auto131_g59845;
				#else
				float4 staticSwitch1088_g59838 = tex2D( _Lightmap1, UV0B2361_g59838 );
				#endif
				float4 Lightmap_1956_g59838 = staticSwitch1088_g59838;
				float Lightmap_Lerp_Value969_g59838 = _UdonLightmapLerp;
				float4 lerpResult442_g59838 = lerp( Lightmap_0925_g59838 , Lightmap_1956_g59838 , Lightmap_Lerp_Value969_g59838);
				float4 Lightmap_Lerp932_g59838 = lerpResult442_g59838;
				float3 appendResult139_g59981 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
				float3 Normal_Map318_g59981 = Normal700_g59838;
				float dotResult121_g59981 = dot( appendResult139_g59981 , Normal_Map318_g59981 );
				float temp_output_2_0_g59983 = saturate( dotResult121_g59981 );
				float localStochasticTiling2_g59869 = ( 0.0 );
				float2 UV2_g59869 = UV0B2361_g59838;
				float4 TexelSize2_g59869 = _UdonRNMX0_TexelSize;
				float4 Offsets2_g59869 = float4( 0,0,0,0 );
				float2 Weights2_g59869 = float2( 0,0 );
				{
				UV2_g59869 = UV2_g59869 * TexelSize2_g59869.zw - 0.5;
				float2 f = frac( UV2_g59869 );
				UV2_g59869 -= f;
				float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
				float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
				float4 xs = xn * xn * xn;
				float4 ys = yn * yn * yn;
				float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
				float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
				float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
				float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
				float4 c = float4( UV2_g59869.x - 0.5, UV2_g59869.x + 1.5, UV2_g59869.y - 0.5, UV2_g59869.y + 1.5 );
				float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
				float w0 = s.x / ( s.x + s.y );
				float w1 = s.z / ( s.z + s.w );
				Offsets2_g59869 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59869.xyxy;
				Weights2_g59869 = float2( w0, w1 );
				}
				float4 temp_output_1_34_g59868 = Offsets2_g59869;
				float4 Input_FetchOffsets197_g59870 = temp_output_1_34_g59868;
				float2 temp_output_1_54_g59868 = Weights2_g59869;
				float2 Input_FetchWeights200_g59870 = temp_output_1_54_g59868;
				float2 break187_g59870 = Input_FetchWeights200_g59870;
				float4 lerpResult181_g59870 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g59870).yw ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g59870).xw ) , break187_g59870.x);
				float4 lerpResult182_g59870 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g59870).yz ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g59870).xz ) , break187_g59870.x);
				float4 lerpResult176_g59870 = lerp( lerpResult181_g59870 , lerpResult182_g59870 , break187_g59870.y);
				float4 Output_Fetch2D_Auto202_g59870 = lerpResult176_g59870;
				#ifdef _USEBICUBICFILTERING_ON
				float4 staticSwitch1061_g59838 = Output_Fetch2D_Auto202_g59870;
				#else
				float4 staticSwitch1061_g59838 = tex2D( _UdonRNMX0, UV0B2361_g59838 );
				#endif
				float3 appendResult146_g59981 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
				float dotResult122_g59981 = dot( appendResult146_g59981 , Normal_Map318_g59981 );
				float temp_output_2_0_g59982 = saturate( dotResult122_g59981 );
				float4 Input_FetchOffsets197_g59871 = temp_output_1_34_g59868;
				float2 Input_FetchWeights200_g59871 = temp_output_1_54_g59868;
				float2 break187_g59871 = Input_FetchWeights200_g59871;
				float4 lerpResult181_g59871 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g59871).yw ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g59871).xw ) , break187_g59871.x);
				float4 lerpResult182_g59871 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g59871).yz ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g59871).xz ) , break187_g59871.x);
				float4 lerpResult176_g59871 = lerp( lerpResult181_g59871 , lerpResult182_g59871 , break187_g59871.y);
				float4 Output_Fetch2D_Auto202_g59871 = lerpResult176_g59871;
				#ifdef _USEBICUBICFILTERING_ON
				float4 staticSwitch1062_g59838 = Output_Fetch2D_Auto202_g59871;
				#else
				float4 staticSwitch1062_g59838 = tex2D( _UdonRNMY0, UV0B2361_g59838 );
				#endif
				float3 appendResult149_g59981 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
				float dotResult120_g59981 = dot( appendResult149_g59981 , Normal_Map318_g59981 );
				float temp_output_2_0_g59984 = saturate( dotResult120_g59981 );
				float4 Input_FetchOffsets197_g59872 = temp_output_1_34_g59868;
				float2 Input_FetchWeights200_g59872 = temp_output_1_54_g59868;
				float2 break187_g59872 = Input_FetchWeights200_g59872;
				float4 lerpResult181_g59872 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g59872).yw ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g59872).xw ) , break187_g59872.x);
				float4 lerpResult182_g59872 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g59872).yz ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g59872).xz ) , break187_g59872.x);
				float4 lerpResult176_g59872 = lerp( lerpResult181_g59872 , lerpResult182_g59872 , break187_g59872.y);
				float4 Output_Fetch2D_Auto202_g59872 = lerpResult176_g59872;
				#ifdef _USEBICUBICFILTERING_ON
				float4 staticSwitch1063_g59838 = Output_Fetch2D_Auto202_g59872;
				#else
				float4 staticSwitch1063_g59838 = tex2D( _UdonRNMZ0, UV0B2361_g59838 );
				#endif
				float4 temp_output_3094_0_g59838 = ( ( ( ( ( temp_output_2_0_g59983 * temp_output_2_0_g59983 ) * staticSwitch1061_g59838 ) + ( ( temp_output_2_0_g59982 * temp_output_2_0_g59982 ) * staticSwitch1062_g59838 ) ) + ( ( temp_output_2_0_g59984 * temp_output_2_0_g59984 ) * staticSwitch1063_g59838 ) ) * 1.2 );
				float4 RNM_0926_g59838 = temp_output_3094_0_g59838;
				float3 appendResult139_g59963 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
				float3 Normal_Map318_g59963 = Normal700_g59838;
				float dotResult121_g59963 = dot( appendResult139_g59963 , Normal_Map318_g59963 );
				float temp_output_2_0_g59965 = saturate( dotResult121_g59963 );
				float localStochasticTiling2_g59840 = ( 0.0 );
				float2 UV2_g59840 = UV0B2361_g59838;
				float4 TexelSize2_g59840 = _UdonRNMX1_TexelSize;
				float4 Offsets2_g59840 = float4( 0,0,0,0 );
				float2 Weights2_g59840 = float2( 0,0 );
				{
				UV2_g59840 = UV2_g59840 * TexelSize2_g59840.zw - 0.5;
				float2 f = frac( UV2_g59840 );
				UV2_g59840 -= f;
				float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
				float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
				float4 xs = xn * xn * xn;
				float4 ys = yn * yn * yn;
				float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
				float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
				float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
				float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
				float4 c = float4( UV2_g59840.x - 0.5, UV2_g59840.x + 1.5, UV2_g59840.y - 0.5, UV2_g59840.y + 1.5 );
				float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
				float w0 = s.x / ( s.x + s.y );
				float w1 = s.z / ( s.z + s.w );
				Offsets2_g59840 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59840.xyxy;
				Weights2_g59840 = float2( w0, w1 );
				}
				float4 temp_output_1_34_g59839 = Offsets2_g59840;
				float4 Input_FetchOffsets197_g59841 = temp_output_1_34_g59839;
				float2 temp_output_1_54_g59839 = Weights2_g59840;
				float2 Input_FetchWeights200_g59841 = temp_output_1_54_g59839;
				float2 break187_g59841 = Input_FetchWeights200_g59841;
				float4 lerpResult181_g59841 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g59841).yw ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g59841).xw ) , break187_g59841.x);
				float4 lerpResult182_g59841 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g59841).yz ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g59841).xz ) , break187_g59841.x);
				float4 lerpResult176_g59841 = lerp( lerpResult181_g59841 , lerpResult182_g59841 , break187_g59841.y);
				float4 Output_Fetch2D_Auto202_g59841 = lerpResult176_g59841;
				#ifdef _USEBICUBICFILTERING_ON
				float4 staticSwitch1087_g59838 = Output_Fetch2D_Auto202_g59841;
				#else
				float4 staticSwitch1087_g59838 = tex2D( _UdonRNMX1, UV0B2361_g59838 );
				#endif
				float3 appendResult146_g59963 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
				float dotResult122_g59963 = dot( appendResult146_g59963 , Normal_Map318_g59963 );
				float temp_output_2_0_g59964 = saturate( dotResult122_g59963 );
				float4 Input_FetchOffsets197_g59842 = temp_output_1_34_g59839;
				float2 Input_FetchWeights200_g59842 = temp_output_1_54_g59839;
				float2 break187_g59842 = Input_FetchWeights200_g59842;
				float4 lerpResult181_g59842 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g59842).yw ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g59842).xw ) , break187_g59842.x);
				float4 lerpResult182_g59842 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g59842).yz ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g59842).xz ) , break187_g59842.x);
				float4 lerpResult176_g59842 = lerp( lerpResult181_g59842 , lerpResult182_g59842 , break187_g59842.y);
				float4 Output_Fetch2D_Auto202_g59842 = lerpResult176_g59842;
				#ifdef _USEBICUBICFILTERING_ON
				float4 staticSwitch1083_g59838 = Output_Fetch2D_Auto202_g59842;
				#else
				float4 staticSwitch1083_g59838 = tex2D( _UdonRNMY1, UV0B2361_g59838 );
				#endif
				float3 appendResult149_g59963 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
				float dotResult120_g59963 = dot( appendResult149_g59963 , Normal_Map318_g59963 );
				float temp_output_2_0_g59966 = saturate( dotResult120_g59963 );
				float4 Input_FetchOffsets197_g59843 = temp_output_1_34_g59839;
				float2 Input_FetchWeights200_g59843 = temp_output_1_54_g59839;
				float2 break187_g59843 = Input_FetchWeights200_g59843;
				float4 lerpResult181_g59843 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g59843).yw ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g59843).xw ) , break187_g59843.x);
				float4 lerpResult182_g59843 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g59843).yz ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g59843).xz ) , break187_g59843.x);
				float4 lerpResult176_g59843 = lerp( lerpResult181_g59843 , lerpResult182_g59843 , break187_g59843.y);
				float4 Output_Fetch2D_Auto202_g59843 = lerpResult176_g59843;
				#ifdef _USEBICUBICFILTERING_ON
				float4 staticSwitch1084_g59838 = Output_Fetch2D_Auto202_g59843;
				#else
				float4 staticSwitch1084_g59838 = tex2D( _UdonRNMZ1, UV0B2361_g59838 );
				#endif
				float4 RNM_11081_g59838 = ( ( ( ( ( temp_output_2_0_g59965 * temp_output_2_0_g59965 ) * staticSwitch1087_g59838 ) + ( ( temp_output_2_0_g59964 * temp_output_2_0_g59964 ) * staticSwitch1083_g59838 ) ) + ( ( temp_output_2_0_g59966 * temp_output_2_0_g59966 ) * staticSwitch1084_g59838 ) ) * 1.2 );
				float4 lerpResult953_g59838 = lerp( RNM_0926_g59838 , RNM_11081_g59838 , Lightmap_Lerp_Value969_g59838);
				float4 RNM_Lerp950_g59838 = lerpResult953_g59838;
				#if defined( _LIGHTMAPMODE_DISABLED )
				float4 staticSwitch1014_g59838 = temp_cast_2;
				#elif defined( _LIGHTMAPMODE_SIMPLE )
				float4 staticSwitch1014_g59838 = Lightmap_0925_g59838;
				#elif defined( _LIGHTMAPMODE_SIMPLELERP )
				float4 staticSwitch1014_g59838 = Lightmap_Lerp932_g59838;
				#elif defined( _LIGHTMAPMODE_RNM )
				float4 staticSwitch1014_g59838 = RNM_0926_g59838;
				#elif defined( _LIGHTMAPMODE_RNMLERP )
				float4 staticSwitch1014_g59838 = RNM_Lerp950_g59838;
				#else
				float4 staticSwitch1014_g59838 = temp_cast_2;
				#endif
				float3 Lightmap46_g59838 = (staticSwitch1014_g59838).rgb;
				float dotResult9_g59992 = dot( float3( 0.212673, 0.715152, 0.072175 ) , Lightmap46_g59838 );
				float smoothstepResult14_g59992 = smoothstep( 0.0 , 0.1 , dotResult9_g59992);
				float Indirect_Lightmap_Mask3118_g59838 = smoothstepResult14_g59992;
				float LightmapMask1_g59991 = Indirect_Lightmap_Mask3118_g59838;
				float3 localIndirectSpecular1_g59991 = IndirectSpecular( Color1_g59991 , Metallic1_g59991 , Smoothness1_g59991 , ViewDir1_g59991 , WorldPos1_g59991 , WorldNormal1_g59991 , LightmapMask1_g59991 );
				#ifdef _INDIRECTSPECULARS_ON
				float3 staticSwitch2971_g59838 = localIndirectSpecular1_g59991;
				#else
				float3 staticSwitch2971_g59838 = temp_cast_1;
				#endif
				float3 Indirect_Specular1419_g59838 = staticSwitch2971_g59838;
				float3 temp_cast_4 = (Black1185_g59838).xxx;
				float3 Color97_g59994 = oAlbedo6_g59838;
				float Metallic97_g59994 = Metallic1239_g59838;
				float Smoothness97_g59994 = Smoothness1399_g59838;
				float3 ViewDir97_g59994 = View_Direction2511_g59838;
				float3 WorldPos97_g59994 = World_Position2505_g59838;
				float3 WorldNormal97_g59994 = World_Normal2508_g59838;
				float3 Vertex_Normal3161_g59838 = IN.ase_normal;
				float3 GeoNormal97_g59994 = Vertex_Normal3161_g59838;
				float White38_g59838 = 1.0;
				#if defined( _LIGHTMAPMODE_DISABLED )
				float staticSwitch3107_g59838 = Black1185_g59838;
				#elif defined( _LIGHTMAPMODE_SIMPLE )
				float staticSwitch3107_g59838 = White38_g59838;
				#elif defined( _LIGHTMAPMODE_SIMPLELERP )
				float staticSwitch3107_g59838 = White38_g59838;
				#elif defined( _LIGHTMAPMODE_RNM )
				float staticSwitch3107_g59838 = White38_g59838;
				#elif defined( _LIGHTMAPMODE_RNMLERP )
				float staticSwitch3107_g59838 = White38_g59838;
				#else
				float staticSwitch3107_g59838 = Black1185_g59838;
				#endif
				float LightmapMode97_g59994 = staticSwitch3107_g59838;
				float dotResult9_g59993 = dot( float3( 0.212673, 0.715152, 0.072175 ) , Lightmap46_g59838 );
				float smoothstepResult2_g59993 = smoothstep( 0.0 , 0.1 , dotResult9_g59993);
				float Direct_Lightmap_Mask3067_g59838 = smoothstepResult2_g59993;
				float LightmapMask97_g59994 = Direct_Lightmap_Mask3067_g59838;
				float3 localDirectSpecular97_g59994 = DirectSpecular( Color97_g59994 , Metallic97_g59994 , Smoothness97_g59994 , ViewDir97_g59994 , WorldPos97_g59994 , WorldNormal97_g59994 , GeoNormal97_g59994 , LightmapMode97_g59994 , LightmapMask97_g59994 );
				#ifdef _DIRECTSPECULAR_ON
				float3 staticSwitch2969_g59838 = localDirectSpecular97_g59994;
				#else
				float3 staticSwitch2969_g59838 = temp_cast_4;
				#endif
				float3 Direct_Specular2560_g59838 = staticSwitch2969_g59838;
				float3 aAlbedo1466_g59838 = ( temp_output_2532_0_g59838 * ( 1.0 - Metallic1239_g59838 ) );
				float3 temp_output_1252_0_g59838 = ( aAlbedo1466_g59838 * Lightmap46_g59838 );
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch1_g59881 = float4( ( temp_output_1252_0_g59838 + Emission86_g59838 + Indirect_Specular1419_g59838 ) , 0.0 );
				#else
				float4 staticSwitch1_g59881 = float4( ( Emission86_g59838 + Indirect_Specular1419_g59838 + Direct_Specular2560_g59838 + temp_output_1252_0_g59838 ) , 0.0 );
				#endif
				#ifdef _LIGHTMAPDEBUG
				float4 staticSwitch1181_g59838 = float4( Lightmap46_g59838 , 0.0 );
				#else
				float4 staticSwitch1181_g59838 = staticSwitch1_g59881;
				#endif
				float4 Color357_g59878 = staticSwitch1181_g59838;
				float4 LUT51_g59878 = tex3D( _LUT, ( ( log10( ( ( (Color357_g59878).xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 ) );
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch359_g59878 = LUT51_g59878;
				#else
				float4 staticSwitch359_g59878 = Color357_g59878;
				#endif
				

				float4 Color = staticSwitch359_g59878;
				float Alpha = staticSwitch1001_g59838.a;
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
}/*ASEBEGIN
Version=19909
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3018;192,-1200;Inherit;False;Meenphie;0;;59838;b3ba55a08dd6b49c7be16c6f35cf2033;6,1008,1,2632,1,2635,1,2619,1,2670,1,2636,1;0;3;FLOAT4;624;FLOAT;156;FLOAT;427
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3021;256,-1024;Inherit;False;Property;_Offset;Offset;51;0;Create;True;0;0;0;True;0;False;0;-1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3022;512,-1200;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;8;Meenphie/Standard/Transparent/Cutout;57d65cf91784ef85cbf389359c250935;True;Unlit;0;0;Unlit;7;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;0;False;;True;3;False;;True;True;0;True;_Offset;0;True;_Offset;True;1;False;;True;2;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;6;Rendering Mode;2;639164494747520140;Alpha Clipping;1;639164494797053590;  Use Shadow Threshold;0;0;Cast Shadows;0;639164494694335980;Write Depth;0;0;Vertex Position;1;0;0;2;True;False;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3023;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;57d65cf91784ef85cbf389359c250935;True;ShadowCaster;0;1;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;False;;True;2;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
WireConnection;3022;0;3018;624
WireConnection;3022;7;3018;156
WireConnection;3022;8;3018;427
ASEEND*/
//CHKSM=DE40502FF0DF43C2BA1B3EBFA2C34F13C05A7C12