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
		[HideInInspector] GenKey__GlossinessMap( "Assign keyword _GLOSSINESSMAP", Float ) = 1.0
		[HideInInspector] GenKey__MetallicMap( "Assign keyword _METALLICMAP", Float ) = 1.0
		[HideInInspector] GenKey__MainTex( "Assign keyword _MAINTEX", Float ) = 1.0
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0

	}

	SubShader
	{
		

		

		/*ase_tags*/
		Tags { "RenderType"="Transparent" "Queue"="Transparent" }

		Cull Off

	LOD 0

		

		Blend One One
		AlphaToMask Off
		ColorMask RGBA
		ZWrite Off
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

			uniform float _Offset;
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
			sampler2D _Sampler82968_g59999;
			uniform float _EmissionIntensity;
			uniform half4 _Color;
			uniform sampler2D _MainTex;
			sampler2D _Sampler82966_g59999;
			uniform float _Metallic;
			uniform sampler2D _MetallicMap;
			sampler2D _Sampler82967_g59999;
			uniform float _Glossiness;
			uniform sampler2D _GlossinessMap;
			sampler2D _Sampler82964_g59999;
			uniform sampler2D _BumpMap;
			sampler2D _Sampler82965_g59999;
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

				float2 texCoord2357_g59999 = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float2 UV0A2420_g59999 = texCoord2357_g59999;
				float2 texCoord2594_g59999 = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 UV2__Decals2595_g59999 = texCoord2594_g59999;
				#if defined( _EMISSIONUV_UV0 )
				float2 staticSwitch2642_g59999 = UV0A2420_g59999;
				#elif defined( _EMISSIONUV_UV2 )
				float2 staticSwitch2642_g59999 = UV2__Decals2595_g59999;
				#else
				float2 staticSwitch2642_g59999 = UV0A2420_g59999;
				#endif
				float2 temp_output_5_0_g60024 = staticSwitch2642_g59999;
				float2 UV633_g60024 = temp_output_5_0_g60024;
				float2 UV100_g60025 = UV633_g60024;
				float2 temp_output_51_0_g60025 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60025 * float2( 3.464,3.464 ) ) );
				float2 break55_g60025 = frac( temp_output_51_0_g60025 );
				float temp_output_56_0_g60025 = ( ( 1.0 - break55_g60025.x ) - break55_g60025.y );
				float2 temp_output_52_0_g60025 = floor( temp_output_51_0_g60025 );
				float2 temp_output_125_0_g60025 = ( temp_output_52_0_g60025 + float2( 1,1 ) );
				float2 ifLocalVar87_g60025 = 0;
				if( temp_output_56_0_g60025 > 0.0 )
				ifLocalVar87_g60025 = temp_output_52_0_g60025;
				else if( temp_output_56_0_g60025 == 0.0 )
				ifLocalVar87_g60025 = temp_output_125_0_g60025;
				else if( temp_output_56_0_g60025 < 0.0 )
				ifLocalVar87_g60025 = temp_output_125_0_g60025;
				float3 temp_output_7_0_g60026 = frac( ( (ifLocalVar87_g60025).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g60026 = dot( temp_output_7_0_g60026 , ( (temp_output_7_0_g60026).yzx + 33.33 ) );
				float3 temp_output_12_0_g60026 = ( temp_output_7_0_g60026 + dotResult8_g60026 );
				float2 temp_output_597_0_g60024 = ( UV100_g60025 + frac( ( ( (temp_output_12_0_g60026).xx + (temp_output_12_0_g60026).yz ) * (temp_output_12_0_g60026).zy ) ) );
				float2 DDX631_g60024 = ddx( temp_output_5_0_g60024 );
				float2 DDY632_g60024 = ddy( temp_output_5_0_g60024 );
				float temp_output_65_0_g60025 = ( 0.0 - temp_output_56_0_g60025 );
				float ifLocalVar59_g60025 = 0;
				if( temp_output_56_0_g60025 <= 0.0 )
				ifLocalVar59_g60025 = temp_output_65_0_g60025;
				else
				ifLocalVar59_g60025 = temp_output_56_0_g60025;
				float temp_output_597_30_g60024 = ifLocalVar59_g60025;
				float2 temp_output_90_0_g60025 = ( temp_output_52_0_g60025 + float2( 0,1 ) );
				float2 temp_output_123_0_g60025 = ( temp_output_52_0_g60025 + float2( 1,0 ) );
				float2 ifLocalVar88_g60025 = 0;
				if( temp_output_56_0_g60025 > 0.0 )
				ifLocalVar88_g60025 = temp_output_90_0_g60025;
				else if( temp_output_56_0_g60025 == 0.0 )
				ifLocalVar88_g60025 = temp_output_123_0_g60025;
				else if( temp_output_56_0_g60025 < 0.0 )
				ifLocalVar88_g60025 = temp_output_123_0_g60025;
				float3 temp_output_7_0_g60027 = frac( ( (ifLocalVar88_g60025).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g60027 = dot( temp_output_7_0_g60027 , ( (temp_output_7_0_g60027).yzx + 33.33 ) );
				float3 temp_output_12_0_g60027 = ( temp_output_7_0_g60027 + dotResult8_g60027 );
				float2 temp_output_597_26_g60024 = ( UV100_g60025 + frac( ( ( (temp_output_12_0_g60027).xx + (temp_output_12_0_g60027).yz ) * (temp_output_12_0_g60027).zy ) ) );
				float temp_output_66_0_g60025 = ( 1.0 - break55_g60025.y );
				float ifLocalVar60_g60025 = 0;
				if( temp_output_56_0_g60025 <= 0.0 )
				ifLocalVar60_g60025 = temp_output_66_0_g60025;
				else
				ifLocalVar60_g60025 = break55_g60025.y;
				float temp_output_597_28_g60024 = ifLocalVar60_g60025;
				float2 ifLocalVar89_g60025 = 0;
				if( temp_output_56_0_g60025 > 0.0 )
				ifLocalVar89_g60025 = temp_output_123_0_g60025;
				else if( temp_output_56_0_g60025 == 0.0 )
				ifLocalVar89_g60025 = temp_output_90_0_g60025;
				else if( temp_output_56_0_g60025 < 0.0 )
				ifLocalVar89_g60025 = temp_output_90_0_g60025;
				float3 temp_output_7_0_g60028 = frac( ( (ifLocalVar89_g60025).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g60028 = dot( temp_output_7_0_g60028 , ( (temp_output_7_0_g60028).yzx + 33.33 ) );
				float3 temp_output_12_0_g60028 = ( temp_output_7_0_g60028 + dotResult8_g60028 );
				float2 temp_output_597_27_g60024 = ( UV100_g60025 + frac( ( ( (temp_output_12_0_g60028).xx + (temp_output_12_0_g60028).yz ) * (temp_output_12_0_g60028).zy ) ) );
				float temp_output_67_0_g60025 = ( 1.0 - break55_g60025.x );
				float ifLocalVar61_g60025 = 0;
				if( temp_output_56_0_g60025 <= 0.0 )
				ifLocalVar61_g60025 = temp_output_67_0_g60025;
				else
				ifLocalVar61_g60025 = break55_g60025.x;
				float temp_output_597_29_g60024 = ifLocalVar61_g60025;
				float4 Output_2D293_g60024 = ( ( tex2D( _Sampler82968_g59999, temp_output_597_0_g60024, DDX631_g60024, DDY632_g60024 ) * temp_output_597_30_g60024 ) + ( tex2D( _Sampler82968_g59999, temp_output_597_26_g60024, DDX631_g60024, DDY632_g60024 ) * temp_output_597_28_g60024 ) + ( tex2D( _Sampler82968_g59999, temp_output_597_27_g60024, DDX631_g60024, DDY632_g60024 ) * temp_output_597_29_g60024 ) );
				#ifdef _STOCHASTICENABLED_ON
				float4 staticSwitch1006_g59999 = Output_2D293_g60024;
				#else
				float4 staticSwitch1006_g59999 = tex2D( _EmissionMap, staticSwitch2642_g59999 );
				#endif
				float3 temp_output_2531_0_g59999 = (( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g59999 * _EmissionIntensity )).rgb;
				float3 Emission86_g59999 = temp_output_2531_0_g59999;
				float Black1185_g59999 = 0.0;
				float3 temp_cast_1 = (Black1185_g59999).xxx;
				float2 temp_output_5_0_g60014 = UV2__Decals2595_g59999;
				float2 UV633_g60014 = temp_output_5_0_g60014;
				float2 UV100_g60015 = UV633_g60014;
				float2 temp_output_51_0_g60015 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60015 * float2( 3.464,3.464 ) ) );
				float2 break55_g60015 = frac( temp_output_51_0_g60015 );
				float temp_output_56_0_g60015 = ( ( 1.0 - break55_g60015.x ) - break55_g60015.y );
				float2 temp_output_52_0_g60015 = floor( temp_output_51_0_g60015 );
				float2 temp_output_125_0_g60015 = ( temp_output_52_0_g60015 + float2( 1,1 ) );
				float2 ifLocalVar87_g60015 = 0;
				if( temp_output_56_0_g60015 > 0.0 )
				ifLocalVar87_g60015 = temp_output_52_0_g60015;
				else if( temp_output_56_0_g60015 == 0.0 )
				ifLocalVar87_g60015 = temp_output_125_0_g60015;
				else if( temp_output_56_0_g60015 < 0.0 )
				ifLocalVar87_g60015 = temp_output_125_0_g60015;
				float3 temp_output_7_0_g60016 = frac( ( (ifLocalVar87_g60015).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g60016 = dot( temp_output_7_0_g60016 , ( (temp_output_7_0_g60016).yzx + 33.33 ) );
				float3 temp_output_12_0_g60016 = ( temp_output_7_0_g60016 + dotResult8_g60016 );
				float2 temp_output_597_0_g60014 = ( UV100_g60015 + frac( ( ( (temp_output_12_0_g60016).xx + (temp_output_12_0_g60016).yz ) * (temp_output_12_0_g60016).zy ) ) );
				float2 DDX631_g60014 = ddx( temp_output_5_0_g60014 );
				float2 DDY632_g60014 = ddy( temp_output_5_0_g60014 );
				float temp_output_65_0_g60015 = ( 0.0 - temp_output_56_0_g60015 );
				float ifLocalVar59_g60015 = 0;
				if( temp_output_56_0_g60015 <= 0.0 )
				ifLocalVar59_g60015 = temp_output_65_0_g60015;
				else
				ifLocalVar59_g60015 = temp_output_56_0_g60015;
				float temp_output_597_30_g60014 = ifLocalVar59_g60015;
				float2 temp_output_90_0_g60015 = ( temp_output_52_0_g60015 + float2( 0,1 ) );
				float2 temp_output_123_0_g60015 = ( temp_output_52_0_g60015 + float2( 1,0 ) );
				float2 ifLocalVar88_g60015 = 0;
				if( temp_output_56_0_g60015 > 0.0 )
				ifLocalVar88_g60015 = temp_output_90_0_g60015;
				else if( temp_output_56_0_g60015 == 0.0 )
				ifLocalVar88_g60015 = temp_output_123_0_g60015;
				else if( temp_output_56_0_g60015 < 0.0 )
				ifLocalVar88_g60015 = temp_output_123_0_g60015;
				float3 temp_output_7_0_g60017 = frac( ( (ifLocalVar88_g60015).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g60017 = dot( temp_output_7_0_g60017 , ( (temp_output_7_0_g60017).yzx + 33.33 ) );
				float3 temp_output_12_0_g60017 = ( temp_output_7_0_g60017 + dotResult8_g60017 );
				float2 temp_output_597_26_g60014 = ( UV100_g60015 + frac( ( ( (temp_output_12_0_g60017).xx + (temp_output_12_0_g60017).yz ) * (temp_output_12_0_g60017).zy ) ) );
				float temp_output_66_0_g60015 = ( 1.0 - break55_g60015.y );
				float ifLocalVar60_g60015 = 0;
				if( temp_output_56_0_g60015 <= 0.0 )
				ifLocalVar60_g60015 = temp_output_66_0_g60015;
				else
				ifLocalVar60_g60015 = break55_g60015.y;
				float temp_output_597_28_g60014 = ifLocalVar60_g60015;
				float2 ifLocalVar89_g60015 = 0;
				if( temp_output_56_0_g60015 > 0.0 )
				ifLocalVar89_g60015 = temp_output_123_0_g60015;
				else if( temp_output_56_0_g60015 == 0.0 )
				ifLocalVar89_g60015 = temp_output_90_0_g60015;
				else if( temp_output_56_0_g60015 < 0.0 )
				ifLocalVar89_g60015 = temp_output_90_0_g60015;
				float3 temp_output_7_0_g60018 = frac( ( (ifLocalVar89_g60015).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g60018 = dot( temp_output_7_0_g60018 , ( (temp_output_7_0_g60018).yzx + 33.33 ) );
				float3 temp_output_12_0_g60018 = ( temp_output_7_0_g60018 + dotResult8_g60018 );
				float2 temp_output_597_27_g60014 = ( UV100_g60015 + frac( ( ( (temp_output_12_0_g60018).xx + (temp_output_12_0_g60018).yz ) * (temp_output_12_0_g60018).zy ) ) );
				float temp_output_67_0_g60015 = ( 1.0 - break55_g60015.x );
				float ifLocalVar61_g60015 = 0;
				if( temp_output_56_0_g60015 <= 0.0 )
				ifLocalVar61_g60015 = temp_output_67_0_g60015;
				else
				ifLocalVar61_g60015 = break55_g60015.x;
				float temp_output_597_29_g60014 = ifLocalVar61_g60015;
				float4 Output_2D293_g60014 = ( ( tex2D( _Sampler82966_g59999, temp_output_597_0_g60014, DDX631_g60014, DDY632_g60014 ) * temp_output_597_30_g60014 ) + ( tex2D( _Sampler82966_g59999, temp_output_597_26_g60014, DDX631_g60014, DDY632_g60014 ) * temp_output_597_28_g60014 ) + ( tex2D( _Sampler82966_g59999, temp_output_597_27_g60014, DDX631_g60014, DDY632_g60014 ) * temp_output_597_29_g60014 ) );
				#ifdef _STOCHASTICENABLED_ON
				float4 staticSwitch1001_g59999 = Output_2D293_g60014;
				#else
				float4 staticSwitch1001_g59999 = ( _Color * tex2D( _MainTex, UV2__Decals2595_g59999 ) );
				#endif
				float3 temp_output_2532_0_g59999 = (staticSwitch1001_g59999).rgb;
				float3 oAlbedo6_g59999 = temp_output_2532_0_g59999;
				float3 Color1_g60055 = oAlbedo6_g59999;
				#if defined( _UV_UV0 )
				float2 staticSwitch2671_g59999 = UV0A2420_g59999;
				#elif defined( _UV_UV2 )
				float2 staticSwitch2671_g59999 = UV2__Decals2595_g59999;
				#else
				float2 staticSwitch2671_g59999 = UV2__Decals2595_g59999;
				#endif
				#ifdef _METALLICMAP
				float staticSwitch846_g59999 = tex2D( _MetallicMap, staticSwitch2671_g59999 ).r;
				#else
				float staticSwitch846_g59999 = _Metallic;
				#endif
				float2 temp_output_5_0_g60034 = staticSwitch2671_g59999;
				float2 UV633_g60034 = temp_output_5_0_g60034;
				float2 UV100_g60035 = UV633_g60034;
				float2 temp_output_51_0_g60035 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60035 * float2( 3.464,3.464 ) ) );
				float2 break55_g60035 = frac( temp_output_51_0_g60035 );
				float temp_output_56_0_g60035 = ( ( 1.0 - break55_g60035.x ) - break55_g60035.y );
				float2 temp_output_52_0_g60035 = floor( temp_output_51_0_g60035 );
				float2 temp_output_125_0_g60035 = ( temp_output_52_0_g60035 + float2( 1,1 ) );
				float2 ifLocalVar87_g60035 = 0;
				if( temp_output_56_0_g60035 > 0.0 )
				ifLocalVar87_g60035 = temp_output_52_0_g60035;
				else if( temp_output_56_0_g60035 == 0.0 )
				ifLocalVar87_g60035 = temp_output_125_0_g60035;
				else if( temp_output_56_0_g60035 < 0.0 )
				ifLocalVar87_g60035 = temp_output_125_0_g60035;
				float3 temp_output_7_0_g60036 = frac( ( (ifLocalVar87_g60035).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g60036 = dot( temp_output_7_0_g60036 , ( (temp_output_7_0_g60036).yzx + 33.33 ) );
				float3 temp_output_12_0_g60036 = ( temp_output_7_0_g60036 + dotResult8_g60036 );
				float2 temp_output_597_0_g60034 = ( UV100_g60035 + frac( ( ( (temp_output_12_0_g60036).xx + (temp_output_12_0_g60036).yz ) * (temp_output_12_0_g60036).zy ) ) );
				float2 DDX631_g60034 = ddx( temp_output_5_0_g60034 );
				float2 DDY632_g60034 = ddy( temp_output_5_0_g60034 );
				float temp_output_65_0_g60035 = ( 0.0 - temp_output_56_0_g60035 );
				float ifLocalVar59_g60035 = 0;
				if( temp_output_56_0_g60035 <= 0.0 )
				ifLocalVar59_g60035 = temp_output_65_0_g60035;
				else
				ifLocalVar59_g60035 = temp_output_56_0_g60035;
				float temp_output_597_30_g60034 = ifLocalVar59_g60035;
				float2 temp_output_90_0_g60035 = ( temp_output_52_0_g60035 + float2( 0,1 ) );
				float2 temp_output_123_0_g60035 = ( temp_output_52_0_g60035 + float2( 1,0 ) );
				float2 ifLocalVar88_g60035 = 0;
				if( temp_output_56_0_g60035 > 0.0 )
				ifLocalVar88_g60035 = temp_output_90_0_g60035;
				else if( temp_output_56_0_g60035 == 0.0 )
				ifLocalVar88_g60035 = temp_output_123_0_g60035;
				else if( temp_output_56_0_g60035 < 0.0 )
				ifLocalVar88_g60035 = temp_output_123_0_g60035;
				float3 temp_output_7_0_g60037 = frac( ( (ifLocalVar88_g60035).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g60037 = dot( temp_output_7_0_g60037 , ( (temp_output_7_0_g60037).yzx + 33.33 ) );
				float3 temp_output_12_0_g60037 = ( temp_output_7_0_g60037 + dotResult8_g60037 );
				float2 temp_output_597_26_g60034 = ( UV100_g60035 + frac( ( ( (temp_output_12_0_g60037).xx + (temp_output_12_0_g60037).yz ) * (temp_output_12_0_g60037).zy ) ) );
				float temp_output_66_0_g60035 = ( 1.0 - break55_g60035.y );
				float ifLocalVar60_g60035 = 0;
				if( temp_output_56_0_g60035 <= 0.0 )
				ifLocalVar60_g60035 = temp_output_66_0_g60035;
				else
				ifLocalVar60_g60035 = break55_g60035.y;
				float temp_output_597_28_g60034 = ifLocalVar60_g60035;
				float2 ifLocalVar89_g60035 = 0;
				if( temp_output_56_0_g60035 > 0.0 )
				ifLocalVar89_g60035 = temp_output_123_0_g60035;
				else if( temp_output_56_0_g60035 == 0.0 )
				ifLocalVar89_g60035 = temp_output_90_0_g60035;
				else if( temp_output_56_0_g60035 < 0.0 )
				ifLocalVar89_g60035 = temp_output_90_0_g60035;
				float3 temp_output_7_0_g60038 = frac( ( (ifLocalVar89_g60035).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g60038 = dot( temp_output_7_0_g60038 , ( (temp_output_7_0_g60038).yzx + 33.33 ) );
				float3 temp_output_12_0_g60038 = ( temp_output_7_0_g60038 + dotResult8_g60038 );
				float2 temp_output_597_27_g60034 = ( UV100_g60035 + frac( ( ( (temp_output_12_0_g60038).xx + (temp_output_12_0_g60038).yz ) * (temp_output_12_0_g60038).zy ) ) );
				float temp_output_67_0_g60035 = ( 1.0 - break55_g60035.x );
				float ifLocalVar61_g60035 = 0;
				if( temp_output_56_0_g60035 <= 0.0 )
				ifLocalVar61_g60035 = temp_output_67_0_g60035;
				else
				ifLocalVar61_g60035 = break55_g60035.x;
				float temp_output_597_29_g60034 = ifLocalVar61_g60035;
				float4 Output_2D293_g60034 = ( ( tex2D( _Sampler82967_g59999, temp_output_597_0_g60034, DDX631_g60034, DDY632_g60034 ) * temp_output_597_30_g60034 ) + ( tex2D( _Sampler82967_g59999, temp_output_597_26_g60034, DDX631_g60034, DDY632_g60034 ) * temp_output_597_28_g60034 ) + ( tex2D( _Sampler82967_g59999, temp_output_597_27_g60034, DDX631_g60034, DDY632_g60034 ) * temp_output_597_29_g60034 ) );
				float4 break31_g60034 = Output_2D293_g60034;
				#ifdef _STOCHASTICENABLED_ON
				float staticSwitch1005_g59999 = break31_g60034.r;
				#else
				float staticSwitch1005_g59999 = staticSwitch846_g59999;
				#endif
				float Metallic1239_g59999 = staticSwitch1005_g59999;
				float Metallic1_g60055 = Metallic1239_g59999;
				#if defined( _UV_UV0 )
				float2 staticSwitch2644_g59999 = UV0A2420_g59999;
				#elif defined( _UV_UV2 )
				float2 staticSwitch2644_g59999 = UV2__Decals2595_g59999;
				#else
				float2 staticSwitch2644_g59999 = UV2__Decals2595_g59999;
				#endif
				#ifdef _GLOSSINESSMAP
				float staticSwitch845_g59999 = tex2D( _GlossinessMap, staticSwitch2644_g59999 ).r;
				#else
				float staticSwitch845_g59999 = _Glossiness;
				#endif
				float2 temp_output_5_0_g60019 = staticSwitch2644_g59999;
				float2 UV633_g60019 = temp_output_5_0_g60019;
				float2 UV100_g60020 = UV633_g60019;
				float2 temp_output_51_0_g60020 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60020 * float2( 3.464,3.464 ) ) );
				float2 break55_g60020 = frac( temp_output_51_0_g60020 );
				float temp_output_56_0_g60020 = ( ( 1.0 - break55_g60020.x ) - break55_g60020.y );
				float2 temp_output_52_0_g60020 = floor( temp_output_51_0_g60020 );
				float2 temp_output_125_0_g60020 = ( temp_output_52_0_g60020 + float2( 1,1 ) );
				float2 ifLocalVar87_g60020 = 0;
				if( temp_output_56_0_g60020 > 0.0 )
				ifLocalVar87_g60020 = temp_output_52_0_g60020;
				else if( temp_output_56_0_g60020 == 0.0 )
				ifLocalVar87_g60020 = temp_output_125_0_g60020;
				else if( temp_output_56_0_g60020 < 0.0 )
				ifLocalVar87_g60020 = temp_output_125_0_g60020;
				float3 temp_output_7_0_g60021 = frac( ( (ifLocalVar87_g60020).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g60021 = dot( temp_output_7_0_g60021 , ( (temp_output_7_0_g60021).yzx + 33.33 ) );
				float3 temp_output_12_0_g60021 = ( temp_output_7_0_g60021 + dotResult8_g60021 );
				float2 temp_output_597_0_g60019 = ( UV100_g60020 + frac( ( ( (temp_output_12_0_g60021).xx + (temp_output_12_0_g60021).yz ) * (temp_output_12_0_g60021).zy ) ) );
				float2 DDX631_g60019 = ddx( temp_output_5_0_g60019 );
				float2 DDY632_g60019 = ddy( temp_output_5_0_g60019 );
				float temp_output_65_0_g60020 = ( 0.0 - temp_output_56_0_g60020 );
				float ifLocalVar59_g60020 = 0;
				if( temp_output_56_0_g60020 <= 0.0 )
				ifLocalVar59_g60020 = temp_output_65_0_g60020;
				else
				ifLocalVar59_g60020 = temp_output_56_0_g60020;
				float temp_output_597_30_g60019 = ifLocalVar59_g60020;
				float2 temp_output_90_0_g60020 = ( temp_output_52_0_g60020 + float2( 0,1 ) );
				float2 temp_output_123_0_g60020 = ( temp_output_52_0_g60020 + float2( 1,0 ) );
				float2 ifLocalVar88_g60020 = 0;
				if( temp_output_56_0_g60020 > 0.0 )
				ifLocalVar88_g60020 = temp_output_90_0_g60020;
				else if( temp_output_56_0_g60020 == 0.0 )
				ifLocalVar88_g60020 = temp_output_123_0_g60020;
				else if( temp_output_56_0_g60020 < 0.0 )
				ifLocalVar88_g60020 = temp_output_123_0_g60020;
				float3 temp_output_7_0_g60022 = frac( ( (ifLocalVar88_g60020).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g60022 = dot( temp_output_7_0_g60022 , ( (temp_output_7_0_g60022).yzx + 33.33 ) );
				float3 temp_output_12_0_g60022 = ( temp_output_7_0_g60022 + dotResult8_g60022 );
				float2 temp_output_597_26_g60019 = ( UV100_g60020 + frac( ( ( (temp_output_12_0_g60022).xx + (temp_output_12_0_g60022).yz ) * (temp_output_12_0_g60022).zy ) ) );
				float temp_output_66_0_g60020 = ( 1.0 - break55_g60020.y );
				float ifLocalVar60_g60020 = 0;
				if( temp_output_56_0_g60020 <= 0.0 )
				ifLocalVar60_g60020 = temp_output_66_0_g60020;
				else
				ifLocalVar60_g60020 = break55_g60020.y;
				float temp_output_597_28_g60019 = ifLocalVar60_g60020;
				float2 ifLocalVar89_g60020 = 0;
				if( temp_output_56_0_g60020 > 0.0 )
				ifLocalVar89_g60020 = temp_output_123_0_g60020;
				else if( temp_output_56_0_g60020 == 0.0 )
				ifLocalVar89_g60020 = temp_output_90_0_g60020;
				else if( temp_output_56_0_g60020 < 0.0 )
				ifLocalVar89_g60020 = temp_output_90_0_g60020;
				float3 temp_output_7_0_g60023 = frac( ( (ifLocalVar89_g60020).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g60023 = dot( temp_output_7_0_g60023 , ( (temp_output_7_0_g60023).yzx + 33.33 ) );
				float3 temp_output_12_0_g60023 = ( temp_output_7_0_g60023 + dotResult8_g60023 );
				float2 temp_output_597_27_g60019 = ( UV100_g60020 + frac( ( ( (temp_output_12_0_g60023).xx + (temp_output_12_0_g60023).yz ) * (temp_output_12_0_g60023).zy ) ) );
				float temp_output_67_0_g60020 = ( 1.0 - break55_g60020.x );
				float ifLocalVar61_g60020 = 0;
				if( temp_output_56_0_g60020 <= 0.0 )
				ifLocalVar61_g60020 = temp_output_67_0_g60020;
				else
				ifLocalVar61_g60020 = break55_g60020.x;
				float temp_output_597_29_g60019 = ifLocalVar61_g60020;
				float4 Output_2D293_g60019 = ( ( tex2D( _Sampler82964_g59999, temp_output_597_0_g60019, DDX631_g60019, DDY632_g60019 ) * temp_output_597_30_g60019 ) + ( tex2D( _Sampler82964_g59999, temp_output_597_26_g60019, DDX631_g60019, DDY632_g60019 ) * temp_output_597_28_g60019 ) + ( tex2D( _Sampler82964_g59999, temp_output_597_27_g60019, DDX631_g60019, DDY632_g60019 ) * temp_output_597_29_g60019 ) );
				float4 break31_g60019 = Output_2D293_g60019;
				#ifdef _STOCHASTICENABLED_ON
				float staticSwitch1004_g59999 = ( 1.0 - break31_g60019.r );
				#else
				float staticSwitch1004_g59999 = ( 1.0 - staticSwitch845_g59999 );
				#endif
				float temp_output_19_0_g60041 = staticSwitch1004_g59999;
				float2 temp_output_5_0_g60009 = UV0A2420_g59999;
				float2 UV633_g60009 = temp_output_5_0_g60009;
				float2 UV100_g60010 = UV633_g60009;
				float2 temp_output_51_0_g60010 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60010 * float2( 3.464,3.464 ) ) );
				float2 break55_g60010 = frac( temp_output_51_0_g60010 );
				float temp_output_56_0_g60010 = ( ( 1.0 - break55_g60010.x ) - break55_g60010.y );
				float2 temp_output_52_0_g60010 = floor( temp_output_51_0_g60010 );
				float2 temp_output_125_0_g60010 = ( temp_output_52_0_g60010 + float2( 1,1 ) );
				float2 ifLocalVar87_g60010 = 0;
				if( temp_output_56_0_g60010 > 0.0 )
				ifLocalVar87_g60010 = temp_output_52_0_g60010;
				else if( temp_output_56_0_g60010 == 0.0 )
				ifLocalVar87_g60010 = temp_output_125_0_g60010;
				else if( temp_output_56_0_g60010 < 0.0 )
				ifLocalVar87_g60010 = temp_output_125_0_g60010;
				float3 temp_output_7_0_g60011 = frac( ( (ifLocalVar87_g60010).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g60011 = dot( temp_output_7_0_g60011 , ( (temp_output_7_0_g60011).yzx + 33.33 ) );
				float3 temp_output_12_0_g60011 = ( temp_output_7_0_g60011 + dotResult8_g60011 );
				float2 temp_output_597_0_g60009 = ( UV100_g60010 + frac( ( ( (temp_output_12_0_g60011).xx + (temp_output_12_0_g60011).yz ) * (temp_output_12_0_g60011).zy ) ) );
				float2 DDX631_g60009 = ddx( temp_output_5_0_g60009 );
				float2 DDY632_g60009 = ddy( temp_output_5_0_g60009 );
				float Input_Scale617_g60009 = 1.5;
				float temp_output_65_0_g60010 = ( 0.0 - temp_output_56_0_g60010 );
				float ifLocalVar59_g60010 = 0;
				if( temp_output_56_0_g60010 <= 0.0 )
				ifLocalVar59_g60010 = temp_output_65_0_g60010;
				else
				ifLocalVar59_g60010 = temp_output_56_0_g60010;
				float temp_output_597_30_g60009 = ifLocalVar59_g60010;
				float2 temp_output_90_0_g60010 = ( temp_output_52_0_g60010 + float2( 0,1 ) );
				float2 temp_output_123_0_g60010 = ( temp_output_52_0_g60010 + float2( 1,0 ) );
				float2 ifLocalVar88_g60010 = 0;
				if( temp_output_56_0_g60010 > 0.0 )
				ifLocalVar88_g60010 = temp_output_90_0_g60010;
				else if( temp_output_56_0_g60010 == 0.0 )
				ifLocalVar88_g60010 = temp_output_123_0_g60010;
				else if( temp_output_56_0_g60010 < 0.0 )
				ifLocalVar88_g60010 = temp_output_123_0_g60010;
				float3 temp_output_7_0_g60012 = frac( ( (ifLocalVar88_g60010).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g60012 = dot( temp_output_7_0_g60012 , ( (temp_output_7_0_g60012).yzx + 33.33 ) );
				float3 temp_output_12_0_g60012 = ( temp_output_7_0_g60012 + dotResult8_g60012 );
				float2 temp_output_597_26_g60009 = ( UV100_g60010 + frac( ( ( (temp_output_12_0_g60012).xx + (temp_output_12_0_g60012).yz ) * (temp_output_12_0_g60012).zy ) ) );
				float temp_output_66_0_g60010 = ( 1.0 - break55_g60010.y );
				float ifLocalVar60_g60010 = 0;
				if( temp_output_56_0_g60010 <= 0.0 )
				ifLocalVar60_g60010 = temp_output_66_0_g60010;
				else
				ifLocalVar60_g60010 = break55_g60010.y;
				float temp_output_597_28_g60009 = ifLocalVar60_g60010;
				float2 ifLocalVar89_g60010 = 0;
				if( temp_output_56_0_g60010 > 0.0 )
				ifLocalVar89_g60010 = temp_output_123_0_g60010;
				else if( temp_output_56_0_g60010 == 0.0 )
				ifLocalVar89_g60010 = temp_output_90_0_g60010;
				else if( temp_output_56_0_g60010 < 0.0 )
				ifLocalVar89_g60010 = temp_output_90_0_g60010;
				float3 temp_output_7_0_g60013 = frac( ( (ifLocalVar89_g60010).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g60013 = dot( temp_output_7_0_g60013 , ( (temp_output_7_0_g60013).yzx + 33.33 ) );
				float3 temp_output_12_0_g60013 = ( temp_output_7_0_g60013 + dotResult8_g60013 );
				float2 temp_output_597_27_g60009 = ( UV100_g60010 + frac( ( ( (temp_output_12_0_g60013).xx + (temp_output_12_0_g60013).yz ) * (temp_output_12_0_g60013).zy ) ) );
				float temp_output_67_0_g60010 = ( 1.0 - break55_g60010.x );
				float ifLocalVar61_g60010 = 0;
				if( temp_output_56_0_g60010 <= 0.0 )
				ifLocalVar61_g60010 = temp_output_67_0_g60010;
				else
				ifLocalVar61_g60010 = break55_g60010.x;
				float temp_output_597_29_g60009 = ifLocalVar61_g60010;
				float3 Output_2D_Normal641_g60009 = ( ( UnpackScaleNormal( tex2D( _Sampler82965_g59999, temp_output_597_0_g60009, DDX631_g60009, DDY632_g60009 ), Input_Scale617_g60009 ) * temp_output_597_30_g60009 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g59999, temp_output_597_26_g60009, DDX631_g60009, DDY632_g60009 ), Input_Scale617_g60009 ) * temp_output_597_28_g60009 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g59999, temp_output_597_27_g60009, DDX631_g60009, DDY632_g60009 ), Input_Scale617_g60009 ) * float3( 0,0,0 ) * temp_output_597_29_g60009 ) );
				#ifdef _STOCHASTICENABLED_ON
				float3 staticSwitch1003_g59999 = Output_2D_Normal641_g60009;
				#else
				float3 staticSwitch1003_g59999 = UnpackScaleNormal( tex2D( _BumpMap, UV0A2420_g59999 ), 1.5 );
				#endif
				#ifdef _BUMPMAP
				float3 staticSwitch980_g59999 = staticSwitch1003_g59999;
				#else
				float3 staticSwitch980_g59999 = float3( 0, 0, 1 );
				#endif
				float3 normalizeResult2878_g59999 = normalize( staticSwitch980_g59999 );
				float3 Normal700_g59999 = normalizeResult2878_g59999;
				float3 ase_tangentWS = IN.ase_texcoord2.xyz;
				float3 ase_normalWS = IN.ase_texcoord3.xyz;
				float3 ase_bitangentWS = IN.ase_texcoord4.xyz;
				float3 tanToWorld0 = float3( ase_tangentWS.x, ase_bitangentWS.x, ase_normalWS.x );
				float3 tanToWorld1 = float3( ase_tangentWS.y, ase_bitangentWS.y, ase_normalWS.y );
				float3 tanToWorld2 = float3( ase_tangentWS.z, ase_bitangentWS.z, ase_normalWS.z );
				float3 tanNormal2504_g59999 = Normal700_g59999;
				float3 worldNormal2504_g59999 = normalize( float3( dot( tanToWorld0, tanNormal2504_g59999 ), dot( tanToWorld1, tanNormal2504_g59999 ), dot( tanToWorld2, tanNormal2504_g59999 ) ) );
				float3 World_Normal2508_g59999 = worldNormal2504_g59999;
				float3 tanNormal2_g60041 = World_Normal2508_g59999;
				float3 worldNormal2_g60041 = float3( dot( tanToWorld0, tanNormal2_g60041 ), dot( tanToWorld1, tanNormal2_g60041 ), dot( tanToWorld2, tanNormal2_g60041 ) );
				float3 temp_output_3_0_g60041 = ddx( worldNormal2_g60041 );
				float dotResult5_g60041 = dot( temp_output_3_0_g60041 , temp_output_3_0_g60041 );
				float3 temp_output_4_0_g60041 = ddy( worldNormal2_g60041 );
				float dotResult6_g60041 = dot( temp_output_4_0_g60041 , temp_output_4_0_g60041 );
				#ifdef _USEGEOMETRICAA_ON
				float staticSwitch15_g60041 = min( temp_output_19_0_g60041, ( 1.0 - pow( saturate( max( dotResult5_g60041, dotResult6_g60041 ) ) , 0.25 ) ) );
				#else
				float staticSwitch15_g60041 = temp_output_19_0_g60041;
				#endif
				float Smoothness1399_g59999 = staticSwitch15_g60041;
				float Smoothness1_g60055 = Smoothness1399_g59999;
				float3 ase_positionWS = IN.ase_texcoord5.xyz;
				float3 ase_viewVectorWS = ( ( unity_OrthoParams.w == 0 ) ? _WorldSpaceCameraPos - ase_positionWS : UNITY_MATRIX_V[ 2 ].xyz );
				float3 ase_viewDirWS = normalize( ase_viewVectorWS );
				float3 View_Direction2511_g59999 = ase_viewDirWS;
				float3 ViewDir1_g60055 = View_Direction2511_g59999;
				float3 World_Position2505_g59999 = ase_positionWS;
				float3 WorldPos1_g60055 = World_Position2505_g59999;
				float3 WorldNormal1_g60055 = World_Normal2508_g59999;
				float4 temp_cast_2 = (Black1185_g59999).xxxx;
				float4 texCoord2426_g59999 = IN.ase_texcoord;
				texCoord2426_g59999.xy = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float2 UV0B2361_g59999 = (texCoord2426_g59999).zw;
				float localBicubicPrepare2_g60008 = ( 0.0 );
				float2 Input_UV100_g60008 = UV0B2361_g59999;
				float2 UV2_g60008 = Input_UV100_g60008;
				float4 TexelSize2_g60008 = _Lightmap0_TexelSize;
				float2 UV02_g60008 = float2( 0,0 );
				float2 UV12_g60008 = float2( 0,0 );
				float2 UV22_g60008 = float2( 0,0 );
				float2 UV32_g60008 = float2( 0,0 );
				float W02_g60008 = 0;
				float W12_g60008 = 0;
				{
				{
				 UV2_g60008 = UV2_g60008 * TexelSize2_g60008.zw - 0.5;
				    float2 f = frac( UV2_g60008 );
				    UV2_g60008 -= f;
				    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
				    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
				    float4 xs = xn * xn * xn;
				    float4 ys = yn * yn * yn;
				    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
				    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
				    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
				 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
				    float4 c = float4( UV2_g60008.x - 0.5, UV2_g60008.x + 1.5, UV2_g60008.y - 0.5, UV2_g60008.y + 1.5 );
				    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
				    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60008.xyxy;
				    UV02_g60008 = off.xz;
				    UV12_g60008 = off.yz;
				    UV22_g60008 = off.xw;
				    UV32_g60008 = off.yw;
				    W02_g60008 = s.x / ( s.x + s.y );
				 W12_g60008 = s.z / ( s.z + s.w );
				}
				}
				float4 lerpResult46_g60008 = lerp( tex2D( _Lightmap0, UV32_g60008 ) , tex2D( _Lightmap0, UV22_g60008 ) , W02_g60008);
				float4 lerpResult45_g60008 = lerp( tex2D( _Lightmap0, UV12_g60008 ) , tex2D( _Lightmap0, UV02_g60008 ) , W02_g60008);
				float4 lerpResult44_g60008 = lerp( lerpResult46_g60008 , lerpResult45_g60008 , W12_g60008);
				float4 Output_2D_Auto131_g60008 = lerpResult44_g60008;
				#ifdef _USEBICUBICFILTERING_ON
				float4 staticSwitch1092_g59999 = Output_2D_Auto131_g60008;
				#else
				float4 staticSwitch1092_g59999 = float4( tex2D( _Lightmap0, UV0B2361_g59999 ).rgb , 0.0 );
				#endif
				float4 Lightmap_0925_g59999 = staticSwitch1092_g59999;
				float localBicubicPrepare2_g60006 = ( 0.0 );
				float2 Input_UV100_g60006 = UV0B2361_g59999;
				float2 UV2_g60006 = Input_UV100_g60006;
				float4 TexelSize2_g60006 = _Lightmap1_TexelSize;
				float2 UV02_g60006 = float2( 0,0 );
				float2 UV12_g60006 = float2( 0,0 );
				float2 UV22_g60006 = float2( 0,0 );
				float2 UV32_g60006 = float2( 0,0 );
				float W02_g60006 = 0;
				float W12_g60006 = 0;
				{
				{
				 UV2_g60006 = UV2_g60006 * TexelSize2_g60006.zw - 0.5;
				    float2 f = frac( UV2_g60006 );
				    UV2_g60006 -= f;
				    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
				    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
				    float4 xs = xn * xn * xn;
				    float4 ys = yn * yn * yn;
				    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
				    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
				    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
				 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
				    float4 c = float4( UV2_g60006.x - 0.5, UV2_g60006.x + 1.5, UV2_g60006.y - 0.5, UV2_g60006.y + 1.5 );
				    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
				    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60006.xyxy;
				    UV02_g60006 = off.xz;
				    UV12_g60006 = off.yz;
				    UV22_g60006 = off.xw;
				    UV32_g60006 = off.yw;
				    W02_g60006 = s.x / ( s.x + s.y );
				 W12_g60006 = s.z / ( s.z + s.w );
				}
				}
				float4 lerpResult46_g60006 = lerp( tex2D( _Lightmap1, UV32_g60006 ) , tex2D( _Lightmap1, UV22_g60006 ) , W02_g60006);
				float4 lerpResult45_g60006 = lerp( tex2D( _Lightmap1, UV12_g60006 ) , tex2D( _Lightmap1, UV02_g60006 ) , W02_g60006);
				float4 lerpResult44_g60006 = lerp( lerpResult46_g60006 , lerpResult45_g60006 , W12_g60006);
				float4 Output_2D_Auto131_g60006 = lerpResult44_g60006;
				#ifdef _USEBICUBICFILTERING_ON
				float4 staticSwitch1088_g59999 = Output_2D_Auto131_g60006;
				#else
				float4 staticSwitch1088_g59999 = tex2D( _Lightmap1, UV0B2361_g59999 );
				#endif
				float4 Lightmap_1956_g59999 = staticSwitch1088_g59999;
				float Lightmap_Lerp_Value969_g59999 = _UdonLightmapLerp;
				float4 lerpResult442_g59999 = lerp( Lightmap_0925_g59999 , Lightmap_1956_g59999 , Lightmap_Lerp_Value969_g59999);
				float4 Lightmap_Lerp932_g59999 = lerpResult442_g59999;
				float3 appendResult139_g60047 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
				float3 Normal_Map318_g60047 = Normal700_g59999;
				float dotResult121_g60047 = dot( appendResult139_g60047 , Normal_Map318_g60047 );
				float temp_output_2_0_g60049 = saturate( dotResult121_g60047 );
				float localStochasticTiling2_g60030 = ( 0.0 );
				float2 UV2_g60030 = UV0B2361_g59999;
				float4 TexelSize2_g60030 = _UdonRNMX0_TexelSize;
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
				float4 lerpResult181_g60031 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60031).yw ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60031).xw ) , break187_g60031.x);
				float4 lerpResult182_g60031 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60031).yz ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60031).xz ) , break187_g60031.x);
				float4 lerpResult176_g60031 = lerp( lerpResult181_g60031 , lerpResult182_g60031 , break187_g60031.y);
				float4 Output_Fetch2D_Auto202_g60031 = lerpResult176_g60031;
				#ifdef _USEBICUBICFILTERING_ON
				float4 staticSwitch1061_g59999 = Output_Fetch2D_Auto202_g60031;
				#else
				float4 staticSwitch1061_g59999 = tex2D( _UdonRNMX0, UV0B2361_g59999 );
				#endif
				float3 appendResult146_g60047 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
				float dotResult122_g60047 = dot( appendResult146_g60047 , Normal_Map318_g60047 );
				float temp_output_2_0_g60048 = saturate( dotResult122_g60047 );
				float4 Input_FetchOffsets197_g60032 = temp_output_1_34_g60029;
				float2 Input_FetchWeights200_g60032 = temp_output_1_54_g60029;
				float2 break187_g60032 = Input_FetchWeights200_g60032;
				float4 lerpResult181_g60032 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60032).yw ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60032).xw ) , break187_g60032.x);
				float4 lerpResult182_g60032 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60032).yz ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60032).xz ) , break187_g60032.x);
				float4 lerpResult176_g60032 = lerp( lerpResult181_g60032 , lerpResult182_g60032 , break187_g60032.y);
				float4 Output_Fetch2D_Auto202_g60032 = lerpResult176_g60032;
				#ifdef _USEBICUBICFILTERING_ON
				float4 staticSwitch1062_g59999 = Output_Fetch2D_Auto202_g60032;
				#else
				float4 staticSwitch1062_g59999 = tex2D( _UdonRNMY0, UV0B2361_g59999 );
				#endif
				float3 appendResult149_g60047 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
				float dotResult120_g60047 = dot( appendResult149_g60047 , Normal_Map318_g60047 );
				float temp_output_2_0_g60050 = saturate( dotResult120_g60047 );
				float4 Input_FetchOffsets197_g60033 = temp_output_1_34_g60029;
				float2 Input_FetchWeights200_g60033 = temp_output_1_54_g60029;
				float2 break187_g60033 = Input_FetchWeights200_g60033;
				float4 lerpResult181_g60033 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60033).yw ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60033).xw ) , break187_g60033.x);
				float4 lerpResult182_g60033 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60033).yz ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60033).xz ) , break187_g60033.x);
				float4 lerpResult176_g60033 = lerp( lerpResult181_g60033 , lerpResult182_g60033 , break187_g60033.y);
				float4 Output_Fetch2D_Auto202_g60033 = lerpResult176_g60033;
				#ifdef _USEBICUBICFILTERING_ON
				float4 staticSwitch1063_g59999 = Output_Fetch2D_Auto202_g60033;
				#else
				float4 staticSwitch1063_g59999 = tex2D( _UdonRNMZ0, UV0B2361_g59999 );
				#endif
				float4 temp_output_3094_0_g59999 = ( ( ( ( ( temp_output_2_0_g60049 * temp_output_2_0_g60049 ) * staticSwitch1061_g59999 ) + ( ( temp_output_2_0_g60048 * temp_output_2_0_g60048 ) * staticSwitch1062_g59999 ) ) + ( ( temp_output_2_0_g60050 * temp_output_2_0_g60050 ) * staticSwitch1063_g59999 ) ) * 1.2 );
				float4 RNM_0926_g59999 = temp_output_3094_0_g59999;
				float3 appendResult139_g60043 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
				float3 Normal_Map318_g60043 = Normal700_g59999;
				float dotResult121_g60043 = dot( appendResult139_g60043 , Normal_Map318_g60043 );
				float temp_output_2_0_g60045 = saturate( dotResult121_g60043 );
				float localStochasticTiling2_g60001 = ( 0.0 );
				float2 UV2_g60001 = UV0B2361_g59999;
				float4 TexelSize2_g60001 = _UdonRNMX1_TexelSize;
				float4 Offsets2_g60001 = float4( 0,0,0,0 );
				float2 Weights2_g60001 = float2( 0,0 );
				{
				UV2_g60001 = UV2_g60001 * TexelSize2_g60001.zw - 0.5;
				float2 f = frac( UV2_g60001 );
				UV2_g60001 -= f;
				float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
				float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
				float4 xs = xn * xn * xn;
				float4 ys = yn * yn * yn;
				float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
				float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
				float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
				float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
				float4 c = float4( UV2_g60001.x - 0.5, UV2_g60001.x + 1.5, UV2_g60001.y - 0.5, UV2_g60001.y + 1.5 );
				float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
				float w0 = s.x / ( s.x + s.y );
				float w1 = s.z / ( s.z + s.w );
				Offsets2_g60001 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60001.xyxy;
				Weights2_g60001 = float2( w0, w1 );
				}
				float4 temp_output_1_34_g60000 = Offsets2_g60001;
				float4 Input_FetchOffsets197_g60002 = temp_output_1_34_g60000;
				float2 temp_output_1_54_g60000 = Weights2_g60001;
				float2 Input_FetchWeights200_g60002 = temp_output_1_54_g60000;
				float2 break187_g60002 = Input_FetchWeights200_g60002;
				float4 lerpResult181_g60002 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60002).yw ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60002).xw ) , break187_g60002.x);
				float4 lerpResult182_g60002 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60002).yz ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60002).xz ) , break187_g60002.x);
				float4 lerpResult176_g60002 = lerp( lerpResult181_g60002 , lerpResult182_g60002 , break187_g60002.y);
				float4 Output_Fetch2D_Auto202_g60002 = lerpResult176_g60002;
				#ifdef _USEBICUBICFILTERING_ON
				float4 staticSwitch1087_g59999 = Output_Fetch2D_Auto202_g60002;
				#else
				float4 staticSwitch1087_g59999 = tex2D( _UdonRNMX1, UV0B2361_g59999 );
				#endif
				float3 appendResult146_g60043 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
				float dotResult122_g60043 = dot( appendResult146_g60043 , Normal_Map318_g60043 );
				float temp_output_2_0_g60044 = saturate( dotResult122_g60043 );
				float4 Input_FetchOffsets197_g60003 = temp_output_1_34_g60000;
				float2 Input_FetchWeights200_g60003 = temp_output_1_54_g60000;
				float2 break187_g60003 = Input_FetchWeights200_g60003;
				float4 lerpResult181_g60003 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60003).yw ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60003).xw ) , break187_g60003.x);
				float4 lerpResult182_g60003 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60003).yz ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60003).xz ) , break187_g60003.x);
				float4 lerpResult176_g60003 = lerp( lerpResult181_g60003 , lerpResult182_g60003 , break187_g60003.y);
				float4 Output_Fetch2D_Auto202_g60003 = lerpResult176_g60003;
				#ifdef _USEBICUBICFILTERING_ON
				float4 staticSwitch1083_g59999 = Output_Fetch2D_Auto202_g60003;
				#else
				float4 staticSwitch1083_g59999 = tex2D( _UdonRNMY1, UV0B2361_g59999 );
				#endif
				float3 appendResult149_g60043 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
				float dotResult120_g60043 = dot( appendResult149_g60043 , Normal_Map318_g60043 );
				float temp_output_2_0_g60046 = saturate( dotResult120_g60043 );
				float4 Input_FetchOffsets197_g60004 = temp_output_1_34_g60000;
				float2 Input_FetchWeights200_g60004 = temp_output_1_54_g60000;
				float2 break187_g60004 = Input_FetchWeights200_g60004;
				float4 lerpResult181_g60004 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60004).yw ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60004).xw ) , break187_g60004.x);
				float4 lerpResult182_g60004 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60004).yz ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60004).xz ) , break187_g60004.x);
				float4 lerpResult176_g60004 = lerp( lerpResult181_g60004 , lerpResult182_g60004 , break187_g60004.y);
				float4 Output_Fetch2D_Auto202_g60004 = lerpResult176_g60004;
				#ifdef _USEBICUBICFILTERING_ON
				float4 staticSwitch1084_g59999 = Output_Fetch2D_Auto202_g60004;
				#else
				float4 staticSwitch1084_g59999 = tex2D( _UdonRNMZ1, UV0B2361_g59999 );
				#endif
				float4 RNM_11081_g59999 = ( ( ( ( ( temp_output_2_0_g60045 * temp_output_2_0_g60045 ) * staticSwitch1087_g59999 ) + ( ( temp_output_2_0_g60044 * temp_output_2_0_g60044 ) * staticSwitch1083_g59999 ) ) + ( ( temp_output_2_0_g60046 * temp_output_2_0_g60046 ) * staticSwitch1084_g59999 ) ) * 1.2 );
				float4 lerpResult953_g59999 = lerp( RNM_0926_g59999 , RNM_11081_g59999 , Lightmap_Lerp_Value969_g59999);
				float4 RNM_Lerp950_g59999 = lerpResult953_g59999;
				#if defined( _LIGHTMAPMODE_DISABLED )
				float4 staticSwitch1014_g59999 = temp_cast_2;
				#elif defined( _LIGHTMAPMODE_SIMPLE )
				float4 staticSwitch1014_g59999 = Lightmap_0925_g59999;
				#elif defined( _LIGHTMAPMODE_SIMPLELERP )
				float4 staticSwitch1014_g59999 = Lightmap_Lerp932_g59999;
				#elif defined( _LIGHTMAPMODE_RNM )
				float4 staticSwitch1014_g59999 = RNM_0926_g59999;
				#elif defined( _LIGHTMAPMODE_RNMLERP )
				float4 staticSwitch1014_g59999 = RNM_Lerp950_g59999;
				#else
				float4 staticSwitch1014_g59999 = temp_cast_2;
				#endif
				float3 Lightmap46_g59999 = (staticSwitch1014_g59999).rgb;
				float dotResult9_g60056 = dot( float3( 0.212673, 0.715152, 0.072175 ) , Lightmap46_g59999 );
				float smoothstepResult14_g60056 = smoothstep( 0.0 , 0.1 , dotResult9_g60056);
				float Indirect_Lightmap_Mask3118_g59999 = smoothstepResult14_g60056;
				float LightmapMask1_g60055 = Indirect_Lightmap_Mask3118_g59999;
				float3 localIndirectSpecular1_g60055 = IndirectSpecular( Color1_g60055 , Metallic1_g60055 , Smoothness1_g60055 , ViewDir1_g60055 , WorldPos1_g60055 , WorldNormal1_g60055 , LightmapMask1_g60055 );
				#ifdef _INDIRECTSPECULARS_ON
				float3 staticSwitch2971_g59999 = localIndirectSpecular1_g60055;
				#else
				float3 staticSwitch2971_g59999 = temp_cast_1;
				#endif
				float3 Indirect_Specular1419_g59999 = staticSwitch2971_g59999;
				float3 temp_cast_4 = (Black1185_g59999).xxx;
				float3 Color97_g60058 = oAlbedo6_g59999;
				float Metallic97_g60058 = Metallic1239_g59999;
				float Smoothness97_g60058 = Smoothness1399_g59999;
				float3 ViewDir97_g60058 = View_Direction2511_g59999;
				float3 WorldPos97_g60058 = World_Position2505_g59999;
				float3 WorldNormal97_g60058 = World_Normal2508_g59999;
				float3 Vertex_Normal3161_g59999 = IN.ase_normal;
				float3 GeoNormal97_g60058 = Vertex_Normal3161_g59999;
				float White38_g59999 = 1.0;
				#if defined( _LIGHTMAPMODE_DISABLED )
				float staticSwitch3107_g59999 = Black1185_g59999;
				#elif defined( _LIGHTMAPMODE_SIMPLE )
				float staticSwitch3107_g59999 = White38_g59999;
				#elif defined( _LIGHTMAPMODE_SIMPLELERP )
				float staticSwitch3107_g59999 = White38_g59999;
				#elif defined( _LIGHTMAPMODE_RNM )
				float staticSwitch3107_g59999 = White38_g59999;
				#elif defined( _LIGHTMAPMODE_RNMLERP )
				float staticSwitch3107_g59999 = White38_g59999;
				#else
				float staticSwitch3107_g59999 = Black1185_g59999;
				#endif
				float LightmapMode97_g60058 = staticSwitch3107_g59999;
				float dotResult9_g60057 = dot( float3( 0.212673, 0.715152, 0.072175 ) , Lightmap46_g59999 );
				float smoothstepResult2_g60057 = smoothstep( 0.0 , 0.1 , dotResult9_g60057);
				float Direct_Lightmap_Mask3067_g59999 = smoothstepResult2_g60057;
				float LightmapMask97_g60058 = Direct_Lightmap_Mask3067_g59999;
				float3 localDirectSpecular97_g60058 = DirectSpecular( Color97_g60058 , Metallic97_g60058 , Smoothness97_g60058 , ViewDir97_g60058 , WorldPos97_g60058 , WorldNormal97_g60058 , GeoNormal97_g60058 , LightmapMode97_g60058 , LightmapMask97_g60058 );
				#ifdef _DIRECTSPECULAR_ON
				float3 staticSwitch2969_g59999 = localDirectSpecular97_g60058;
				#else
				float3 staticSwitch2969_g59999 = temp_cast_4;
				#endif
				float3 Direct_Specular2560_g59999 = staticSwitch2969_g59999;
				float3 aAlbedo1466_g59999 = ( temp_output_2532_0_g59999 * ( 1.0 - Metallic1239_g59999 ) );
				float3 temp_output_1252_0_g59999 = ( aAlbedo1466_g59999 * Lightmap46_g59999 );
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch1_g60042 = float4( ( temp_output_1252_0_g59999 + Emission86_g59999 + Indirect_Specular1419_g59999 ) , 0.0 );
				#else
				float4 staticSwitch1_g60042 = float4( ( Emission86_g59999 + Indirect_Specular1419_g59999 + Direct_Specular2560_g59999 + temp_output_1252_0_g59999 ) , 0.0 );
				#endif
				#ifdef _LIGHTMAPDEBUG
				float4 staticSwitch1181_g59999 = float4( Lightmap46_g59999 , 0.0 );
				#else
				float4 staticSwitch1181_g59999 = staticSwitch1_g60042;
				#endif
				float4 Color357_g60039 = staticSwitch1181_g59999;
				float4 LUT51_g60039 = tex3D( _LUT, ( ( log10( ( ( (Color357_g60039).xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 ) );
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch359_g60039 = LUT51_g60039;
				#else
				float4 staticSwitch359_g60039 = Color357_g60039;
				#endif
				

				float4 Color = staticSwitch359_g60039;
				float Alpha = staticSwitch1001_g59999.a;
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

	
	}
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
	
	Fallback Off
}/*ASEBEGIN
Version=19909
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3054;256,-1040;Inherit;False;Property;_Offset;Offset;51;0;Create;True;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3059;192,-1200;Inherit;False;Meenphie;0;;59999;b3ba55a08dd6b49c7be16c6f35cf2033;6,1008,0,2632,1,2635,1,2619,1,2670,1,2636,1;0;3;FLOAT4;624;FLOAT;156;FLOAT;427
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3061;512,-1200;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;8;Meenphie/Standard/Transparent/Additive;57d65cf91784ef85cbf389359c250935;True;Unlit;0;0;Unlit;7;True;True;4;1;False;;1;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;2;False;;True;3;False;;True;True;0;True;_Offset;0;True;_Offset;True;1;False;;True;2;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;6;Rendering Mode;1;639164495460152840;Alpha Clipping;0;0;  Use Shadow Threshold;0;0;Cast Shadows;0;639164482795055170;Write Depth;0;0;Vertex Position;1;0;0;2;True;False;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3062;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;8;New Amplify Shader;57d65cf91784ef85cbf389359c250935;True;ShadowCaster;0;1;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;False;;True;2;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
WireConnection;3061;0;3059;624
WireConnection;3061;7;3059;156
ASEEND*/
//CHKSM=82F3D7BF309ED475ECC8B40543B9361A4C9643B3