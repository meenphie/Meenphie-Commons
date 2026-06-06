// Made with Amplify Shader Editor v1.9.9.9
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Standard/Transparent/Alpha"
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
		[HideInInspector] GenKey__MetallicMap( "Assign keyword _METALLICMAP", Float ) = 1.0
		[HideInInspector] GenKey__MainTex( "Assign keyword _MAINTEX", Float ) = 1.0
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0
		[HideInInspector] GenKey__GlossinessMap( "Assign keyword _GLOSSINESSMAP", Float ) = 1.0

	}

	SubShader
	{
		

		

		/*ase_tags*/
		Tags { "RenderType"="Transparent" "Queue"="Transparent" }

		Cull Back

	LOD 0

		

		Blend SrcAlpha OneMinusSrcAlpha
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
			sampler2D _Sampler82968_g60214;
			uniform float _EmissionIntensity;
			uniform half4 _Color;
			uniform sampler2D _MainTex;
			sampler2D _Sampler82966_g60214;
			uniform float _Metallic;
			uniform sampler2D _MetallicMap;
			sampler2D _Sampler82967_g60214;
			uniform float _Glossiness;
			uniform sampler2D _GlossinessMap;
			sampler2D _Sampler82964_g60214;
			uniform sampler2D _BumpMap;
			sampler2D _Sampler82965_g60214;
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

				float2 texCoord2357_g60214 = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float2 UV0A2420_g60214 = texCoord2357_g60214;
				float2 texCoord2594_g60214 = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 UV2__Decals2595_g60214 = texCoord2594_g60214;
				#if defined( _EMISSIONUV_UV0 )
				float2 staticSwitch2642_g60214 = UV0A2420_g60214;
				#elif defined( _EMISSIONUV_UV2 )
				float2 staticSwitch2642_g60214 = UV2__Decals2595_g60214;
				#else
				float2 staticSwitch2642_g60214 = UV0A2420_g60214;
				#endif
				float2 temp_output_5_0_g60239 = staticSwitch2642_g60214;
				float2 UV633_g60239 = temp_output_5_0_g60239;
				float2 UV100_g60240 = UV633_g60239;
				float2 temp_output_51_0_g60240 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60240 * float2( 3.464,3.464 ) ) );
				float2 break55_g60240 = frac( temp_output_51_0_g60240 );
				float temp_output_56_0_g60240 = ( ( 1.0 - break55_g60240.x ) - break55_g60240.y );
				float2 temp_output_52_0_g60240 = floor( temp_output_51_0_g60240 );
				float2 temp_output_125_0_g60240 = ( temp_output_52_0_g60240 + float2( 1,1 ) );
				float2 ifLocalVar87_g60240 = 0;
				if( temp_output_56_0_g60240 > 0.0 )
				ifLocalVar87_g60240 = temp_output_52_0_g60240;
				else if( temp_output_56_0_g60240 == 0.0 )
				ifLocalVar87_g60240 = temp_output_125_0_g60240;
				else if( temp_output_56_0_g60240 < 0.0 )
				ifLocalVar87_g60240 = temp_output_125_0_g60240;
				float3 temp_output_7_0_g60241 = frac( ( (ifLocalVar87_g60240).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g60241 = dot( temp_output_7_0_g60241 , ( (temp_output_7_0_g60241).yzx + 33.33 ) );
				float3 temp_output_12_0_g60241 = ( temp_output_7_0_g60241 + dotResult8_g60241 );
				float2 temp_output_597_0_g60239 = ( UV100_g60240 + frac( ( ( (temp_output_12_0_g60241).xx + (temp_output_12_0_g60241).yz ) * (temp_output_12_0_g60241).zy ) ) );
				float2 DDX631_g60239 = ddx( temp_output_5_0_g60239 );
				float2 DDY632_g60239 = ddy( temp_output_5_0_g60239 );
				float temp_output_65_0_g60240 = ( 0.0 - temp_output_56_0_g60240 );
				float ifLocalVar59_g60240 = 0;
				if( temp_output_56_0_g60240 <= 0.0 )
				ifLocalVar59_g60240 = temp_output_65_0_g60240;
				else
				ifLocalVar59_g60240 = temp_output_56_0_g60240;
				float temp_output_597_30_g60239 = ifLocalVar59_g60240;
				float2 temp_output_90_0_g60240 = ( temp_output_52_0_g60240 + float2( 0,1 ) );
				float2 temp_output_123_0_g60240 = ( temp_output_52_0_g60240 + float2( 1,0 ) );
				float2 ifLocalVar88_g60240 = 0;
				if( temp_output_56_0_g60240 > 0.0 )
				ifLocalVar88_g60240 = temp_output_90_0_g60240;
				else if( temp_output_56_0_g60240 == 0.0 )
				ifLocalVar88_g60240 = temp_output_123_0_g60240;
				else if( temp_output_56_0_g60240 < 0.0 )
				ifLocalVar88_g60240 = temp_output_123_0_g60240;
				float3 temp_output_7_0_g60242 = frac( ( (ifLocalVar88_g60240).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g60242 = dot( temp_output_7_0_g60242 , ( (temp_output_7_0_g60242).yzx + 33.33 ) );
				float3 temp_output_12_0_g60242 = ( temp_output_7_0_g60242 + dotResult8_g60242 );
				float2 temp_output_597_26_g60239 = ( UV100_g60240 + frac( ( ( (temp_output_12_0_g60242).xx + (temp_output_12_0_g60242).yz ) * (temp_output_12_0_g60242).zy ) ) );
				float temp_output_66_0_g60240 = ( 1.0 - break55_g60240.y );
				float ifLocalVar60_g60240 = 0;
				if( temp_output_56_0_g60240 <= 0.0 )
				ifLocalVar60_g60240 = temp_output_66_0_g60240;
				else
				ifLocalVar60_g60240 = break55_g60240.y;
				float temp_output_597_28_g60239 = ifLocalVar60_g60240;
				float2 ifLocalVar89_g60240 = 0;
				if( temp_output_56_0_g60240 > 0.0 )
				ifLocalVar89_g60240 = temp_output_123_0_g60240;
				else if( temp_output_56_0_g60240 == 0.0 )
				ifLocalVar89_g60240 = temp_output_90_0_g60240;
				else if( temp_output_56_0_g60240 < 0.0 )
				ifLocalVar89_g60240 = temp_output_90_0_g60240;
				float3 temp_output_7_0_g60243 = frac( ( (ifLocalVar89_g60240).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g60243 = dot( temp_output_7_0_g60243 , ( (temp_output_7_0_g60243).yzx + 33.33 ) );
				float3 temp_output_12_0_g60243 = ( temp_output_7_0_g60243 + dotResult8_g60243 );
				float2 temp_output_597_27_g60239 = ( UV100_g60240 + frac( ( ( (temp_output_12_0_g60243).xx + (temp_output_12_0_g60243).yz ) * (temp_output_12_0_g60243).zy ) ) );
				float temp_output_67_0_g60240 = ( 1.0 - break55_g60240.x );
				float ifLocalVar61_g60240 = 0;
				if( temp_output_56_0_g60240 <= 0.0 )
				ifLocalVar61_g60240 = temp_output_67_0_g60240;
				else
				ifLocalVar61_g60240 = break55_g60240.x;
				float temp_output_597_29_g60239 = ifLocalVar61_g60240;
				float4 Output_2D293_g60239 = ( ( tex2D( _Sampler82968_g60214, temp_output_597_0_g60239, DDX631_g60239, DDY632_g60239 ) * temp_output_597_30_g60239 ) + ( tex2D( _Sampler82968_g60214, temp_output_597_26_g60239, DDX631_g60239, DDY632_g60239 ) * temp_output_597_28_g60239 ) + ( tex2D( _Sampler82968_g60214, temp_output_597_27_g60239, DDX631_g60239, DDY632_g60239 ) * temp_output_597_29_g60239 ) );
				#ifdef _STOCHASTICENABLED_ON
				float4 staticSwitch1006_g60214 = Output_2D293_g60239;
				#else
				float4 staticSwitch1006_g60214 = tex2D( _EmissionMap, staticSwitch2642_g60214 );
				#endif
				float3 temp_output_2531_0_g60214 = (( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g60214 * _EmissionIntensity )).rgb;
				float3 Emission86_g60214 = temp_output_2531_0_g60214;
				float Black1185_g60214 = 0.0;
				float3 temp_cast_1 = (Black1185_g60214).xxx;
				float2 temp_output_5_0_g60229 = UV2__Decals2595_g60214;
				float2 UV633_g60229 = temp_output_5_0_g60229;
				float2 UV100_g60230 = UV633_g60229;
				float2 temp_output_51_0_g60230 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60230 * float2( 3.464,3.464 ) ) );
				float2 break55_g60230 = frac( temp_output_51_0_g60230 );
				float temp_output_56_0_g60230 = ( ( 1.0 - break55_g60230.x ) - break55_g60230.y );
				float2 temp_output_52_0_g60230 = floor( temp_output_51_0_g60230 );
				float2 temp_output_125_0_g60230 = ( temp_output_52_0_g60230 + float2( 1,1 ) );
				float2 ifLocalVar87_g60230 = 0;
				if( temp_output_56_0_g60230 > 0.0 )
				ifLocalVar87_g60230 = temp_output_52_0_g60230;
				else if( temp_output_56_0_g60230 == 0.0 )
				ifLocalVar87_g60230 = temp_output_125_0_g60230;
				else if( temp_output_56_0_g60230 < 0.0 )
				ifLocalVar87_g60230 = temp_output_125_0_g60230;
				float3 temp_output_7_0_g60231 = frac( ( (ifLocalVar87_g60230).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g60231 = dot( temp_output_7_0_g60231 , ( (temp_output_7_0_g60231).yzx + 33.33 ) );
				float3 temp_output_12_0_g60231 = ( temp_output_7_0_g60231 + dotResult8_g60231 );
				float2 temp_output_597_0_g60229 = ( UV100_g60230 + frac( ( ( (temp_output_12_0_g60231).xx + (temp_output_12_0_g60231).yz ) * (temp_output_12_0_g60231).zy ) ) );
				float2 DDX631_g60229 = ddx( temp_output_5_0_g60229 );
				float2 DDY632_g60229 = ddy( temp_output_5_0_g60229 );
				float temp_output_65_0_g60230 = ( 0.0 - temp_output_56_0_g60230 );
				float ifLocalVar59_g60230 = 0;
				if( temp_output_56_0_g60230 <= 0.0 )
				ifLocalVar59_g60230 = temp_output_65_0_g60230;
				else
				ifLocalVar59_g60230 = temp_output_56_0_g60230;
				float temp_output_597_30_g60229 = ifLocalVar59_g60230;
				float2 temp_output_90_0_g60230 = ( temp_output_52_0_g60230 + float2( 0,1 ) );
				float2 temp_output_123_0_g60230 = ( temp_output_52_0_g60230 + float2( 1,0 ) );
				float2 ifLocalVar88_g60230 = 0;
				if( temp_output_56_0_g60230 > 0.0 )
				ifLocalVar88_g60230 = temp_output_90_0_g60230;
				else if( temp_output_56_0_g60230 == 0.0 )
				ifLocalVar88_g60230 = temp_output_123_0_g60230;
				else if( temp_output_56_0_g60230 < 0.0 )
				ifLocalVar88_g60230 = temp_output_123_0_g60230;
				float3 temp_output_7_0_g60232 = frac( ( (ifLocalVar88_g60230).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g60232 = dot( temp_output_7_0_g60232 , ( (temp_output_7_0_g60232).yzx + 33.33 ) );
				float3 temp_output_12_0_g60232 = ( temp_output_7_0_g60232 + dotResult8_g60232 );
				float2 temp_output_597_26_g60229 = ( UV100_g60230 + frac( ( ( (temp_output_12_0_g60232).xx + (temp_output_12_0_g60232).yz ) * (temp_output_12_0_g60232).zy ) ) );
				float temp_output_66_0_g60230 = ( 1.0 - break55_g60230.y );
				float ifLocalVar60_g60230 = 0;
				if( temp_output_56_0_g60230 <= 0.0 )
				ifLocalVar60_g60230 = temp_output_66_0_g60230;
				else
				ifLocalVar60_g60230 = break55_g60230.y;
				float temp_output_597_28_g60229 = ifLocalVar60_g60230;
				float2 ifLocalVar89_g60230 = 0;
				if( temp_output_56_0_g60230 > 0.0 )
				ifLocalVar89_g60230 = temp_output_123_0_g60230;
				else if( temp_output_56_0_g60230 == 0.0 )
				ifLocalVar89_g60230 = temp_output_90_0_g60230;
				else if( temp_output_56_0_g60230 < 0.0 )
				ifLocalVar89_g60230 = temp_output_90_0_g60230;
				float3 temp_output_7_0_g60233 = frac( ( (ifLocalVar89_g60230).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g60233 = dot( temp_output_7_0_g60233 , ( (temp_output_7_0_g60233).yzx + 33.33 ) );
				float3 temp_output_12_0_g60233 = ( temp_output_7_0_g60233 + dotResult8_g60233 );
				float2 temp_output_597_27_g60229 = ( UV100_g60230 + frac( ( ( (temp_output_12_0_g60233).xx + (temp_output_12_0_g60233).yz ) * (temp_output_12_0_g60233).zy ) ) );
				float temp_output_67_0_g60230 = ( 1.0 - break55_g60230.x );
				float ifLocalVar61_g60230 = 0;
				if( temp_output_56_0_g60230 <= 0.0 )
				ifLocalVar61_g60230 = temp_output_67_0_g60230;
				else
				ifLocalVar61_g60230 = break55_g60230.x;
				float temp_output_597_29_g60229 = ifLocalVar61_g60230;
				float4 Output_2D293_g60229 = ( ( tex2D( _Sampler82966_g60214, temp_output_597_0_g60229, DDX631_g60229, DDY632_g60229 ) * temp_output_597_30_g60229 ) + ( tex2D( _Sampler82966_g60214, temp_output_597_26_g60229, DDX631_g60229, DDY632_g60229 ) * temp_output_597_28_g60229 ) + ( tex2D( _Sampler82966_g60214, temp_output_597_27_g60229, DDX631_g60229, DDY632_g60229 ) * temp_output_597_29_g60229 ) );
				#ifdef _STOCHASTICENABLED_ON
				float4 staticSwitch1001_g60214 = Output_2D293_g60229;
				#else
				float4 staticSwitch1001_g60214 = ( _Color * tex2D( _MainTex, UV2__Decals2595_g60214 ) );
				#endif
				float3 temp_output_2532_0_g60214 = (staticSwitch1001_g60214).rgb;
				float3 oAlbedo6_g60214 = temp_output_2532_0_g60214;
				float3 Color1_g60270 = oAlbedo6_g60214;
				#if defined( _UV_UV0 )
				float2 staticSwitch2671_g60214 = UV0A2420_g60214;
				#elif defined( _UV_UV2 )
				float2 staticSwitch2671_g60214 = UV2__Decals2595_g60214;
				#else
				float2 staticSwitch2671_g60214 = UV2__Decals2595_g60214;
				#endif
				#ifdef _METALLICMAP
				float staticSwitch846_g60214 = tex2D( _MetallicMap, staticSwitch2671_g60214 ).r;
				#else
				float staticSwitch846_g60214 = _Metallic;
				#endif
				float2 temp_output_5_0_g60249 = staticSwitch2671_g60214;
				float2 UV633_g60249 = temp_output_5_0_g60249;
				float2 UV100_g60250 = UV633_g60249;
				float2 temp_output_51_0_g60250 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60250 * float2( 3.464,3.464 ) ) );
				float2 break55_g60250 = frac( temp_output_51_0_g60250 );
				float temp_output_56_0_g60250 = ( ( 1.0 - break55_g60250.x ) - break55_g60250.y );
				float2 temp_output_52_0_g60250 = floor( temp_output_51_0_g60250 );
				float2 temp_output_125_0_g60250 = ( temp_output_52_0_g60250 + float2( 1,1 ) );
				float2 ifLocalVar87_g60250 = 0;
				if( temp_output_56_0_g60250 > 0.0 )
				ifLocalVar87_g60250 = temp_output_52_0_g60250;
				else if( temp_output_56_0_g60250 == 0.0 )
				ifLocalVar87_g60250 = temp_output_125_0_g60250;
				else if( temp_output_56_0_g60250 < 0.0 )
				ifLocalVar87_g60250 = temp_output_125_0_g60250;
				float3 temp_output_7_0_g60251 = frac( ( (ifLocalVar87_g60250).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g60251 = dot( temp_output_7_0_g60251 , ( (temp_output_7_0_g60251).yzx + 33.33 ) );
				float3 temp_output_12_0_g60251 = ( temp_output_7_0_g60251 + dotResult8_g60251 );
				float2 temp_output_597_0_g60249 = ( UV100_g60250 + frac( ( ( (temp_output_12_0_g60251).xx + (temp_output_12_0_g60251).yz ) * (temp_output_12_0_g60251).zy ) ) );
				float2 DDX631_g60249 = ddx( temp_output_5_0_g60249 );
				float2 DDY632_g60249 = ddy( temp_output_5_0_g60249 );
				float temp_output_65_0_g60250 = ( 0.0 - temp_output_56_0_g60250 );
				float ifLocalVar59_g60250 = 0;
				if( temp_output_56_0_g60250 <= 0.0 )
				ifLocalVar59_g60250 = temp_output_65_0_g60250;
				else
				ifLocalVar59_g60250 = temp_output_56_0_g60250;
				float temp_output_597_30_g60249 = ifLocalVar59_g60250;
				float2 temp_output_90_0_g60250 = ( temp_output_52_0_g60250 + float2( 0,1 ) );
				float2 temp_output_123_0_g60250 = ( temp_output_52_0_g60250 + float2( 1,0 ) );
				float2 ifLocalVar88_g60250 = 0;
				if( temp_output_56_0_g60250 > 0.0 )
				ifLocalVar88_g60250 = temp_output_90_0_g60250;
				else if( temp_output_56_0_g60250 == 0.0 )
				ifLocalVar88_g60250 = temp_output_123_0_g60250;
				else if( temp_output_56_0_g60250 < 0.0 )
				ifLocalVar88_g60250 = temp_output_123_0_g60250;
				float3 temp_output_7_0_g60252 = frac( ( (ifLocalVar88_g60250).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g60252 = dot( temp_output_7_0_g60252 , ( (temp_output_7_0_g60252).yzx + 33.33 ) );
				float3 temp_output_12_0_g60252 = ( temp_output_7_0_g60252 + dotResult8_g60252 );
				float2 temp_output_597_26_g60249 = ( UV100_g60250 + frac( ( ( (temp_output_12_0_g60252).xx + (temp_output_12_0_g60252).yz ) * (temp_output_12_0_g60252).zy ) ) );
				float temp_output_66_0_g60250 = ( 1.0 - break55_g60250.y );
				float ifLocalVar60_g60250 = 0;
				if( temp_output_56_0_g60250 <= 0.0 )
				ifLocalVar60_g60250 = temp_output_66_0_g60250;
				else
				ifLocalVar60_g60250 = break55_g60250.y;
				float temp_output_597_28_g60249 = ifLocalVar60_g60250;
				float2 ifLocalVar89_g60250 = 0;
				if( temp_output_56_0_g60250 > 0.0 )
				ifLocalVar89_g60250 = temp_output_123_0_g60250;
				else if( temp_output_56_0_g60250 == 0.0 )
				ifLocalVar89_g60250 = temp_output_90_0_g60250;
				else if( temp_output_56_0_g60250 < 0.0 )
				ifLocalVar89_g60250 = temp_output_90_0_g60250;
				float3 temp_output_7_0_g60253 = frac( ( (ifLocalVar89_g60250).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g60253 = dot( temp_output_7_0_g60253 , ( (temp_output_7_0_g60253).yzx + 33.33 ) );
				float3 temp_output_12_0_g60253 = ( temp_output_7_0_g60253 + dotResult8_g60253 );
				float2 temp_output_597_27_g60249 = ( UV100_g60250 + frac( ( ( (temp_output_12_0_g60253).xx + (temp_output_12_0_g60253).yz ) * (temp_output_12_0_g60253).zy ) ) );
				float temp_output_67_0_g60250 = ( 1.0 - break55_g60250.x );
				float ifLocalVar61_g60250 = 0;
				if( temp_output_56_0_g60250 <= 0.0 )
				ifLocalVar61_g60250 = temp_output_67_0_g60250;
				else
				ifLocalVar61_g60250 = break55_g60250.x;
				float temp_output_597_29_g60249 = ifLocalVar61_g60250;
				float4 Output_2D293_g60249 = ( ( tex2D( _Sampler82967_g60214, temp_output_597_0_g60249, DDX631_g60249, DDY632_g60249 ) * temp_output_597_30_g60249 ) + ( tex2D( _Sampler82967_g60214, temp_output_597_26_g60249, DDX631_g60249, DDY632_g60249 ) * temp_output_597_28_g60249 ) + ( tex2D( _Sampler82967_g60214, temp_output_597_27_g60249, DDX631_g60249, DDY632_g60249 ) * temp_output_597_29_g60249 ) );
				float4 break31_g60249 = Output_2D293_g60249;
				#ifdef _STOCHASTICENABLED_ON
				float staticSwitch1005_g60214 = break31_g60249.r;
				#else
				float staticSwitch1005_g60214 = staticSwitch846_g60214;
				#endif
				float Metallic1239_g60214 = staticSwitch1005_g60214;
				float Metallic1_g60270 = Metallic1239_g60214;
				#if defined( _UV_UV0 )
				float2 staticSwitch2644_g60214 = UV0A2420_g60214;
				#elif defined( _UV_UV2 )
				float2 staticSwitch2644_g60214 = UV2__Decals2595_g60214;
				#else
				float2 staticSwitch2644_g60214 = UV2__Decals2595_g60214;
				#endif
				#ifdef _GLOSSINESSMAP
				float staticSwitch845_g60214 = tex2D( _GlossinessMap, staticSwitch2644_g60214 ).r;
				#else
				float staticSwitch845_g60214 = _Glossiness;
				#endif
				float2 temp_output_5_0_g60234 = staticSwitch2644_g60214;
				float2 UV633_g60234 = temp_output_5_0_g60234;
				float2 UV100_g60235 = UV633_g60234;
				float2 temp_output_51_0_g60235 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60235 * float2( 3.464,3.464 ) ) );
				float2 break55_g60235 = frac( temp_output_51_0_g60235 );
				float temp_output_56_0_g60235 = ( ( 1.0 - break55_g60235.x ) - break55_g60235.y );
				float2 temp_output_52_0_g60235 = floor( temp_output_51_0_g60235 );
				float2 temp_output_125_0_g60235 = ( temp_output_52_0_g60235 + float2( 1,1 ) );
				float2 ifLocalVar87_g60235 = 0;
				if( temp_output_56_0_g60235 > 0.0 )
				ifLocalVar87_g60235 = temp_output_52_0_g60235;
				else if( temp_output_56_0_g60235 == 0.0 )
				ifLocalVar87_g60235 = temp_output_125_0_g60235;
				else if( temp_output_56_0_g60235 < 0.0 )
				ifLocalVar87_g60235 = temp_output_125_0_g60235;
				float3 temp_output_7_0_g60236 = frac( ( (ifLocalVar87_g60235).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g60236 = dot( temp_output_7_0_g60236 , ( (temp_output_7_0_g60236).yzx + 33.33 ) );
				float3 temp_output_12_0_g60236 = ( temp_output_7_0_g60236 + dotResult8_g60236 );
				float2 temp_output_597_0_g60234 = ( UV100_g60235 + frac( ( ( (temp_output_12_0_g60236).xx + (temp_output_12_0_g60236).yz ) * (temp_output_12_0_g60236).zy ) ) );
				float2 DDX631_g60234 = ddx( temp_output_5_0_g60234 );
				float2 DDY632_g60234 = ddy( temp_output_5_0_g60234 );
				float temp_output_65_0_g60235 = ( 0.0 - temp_output_56_0_g60235 );
				float ifLocalVar59_g60235 = 0;
				if( temp_output_56_0_g60235 <= 0.0 )
				ifLocalVar59_g60235 = temp_output_65_0_g60235;
				else
				ifLocalVar59_g60235 = temp_output_56_0_g60235;
				float temp_output_597_30_g60234 = ifLocalVar59_g60235;
				float2 temp_output_90_0_g60235 = ( temp_output_52_0_g60235 + float2( 0,1 ) );
				float2 temp_output_123_0_g60235 = ( temp_output_52_0_g60235 + float2( 1,0 ) );
				float2 ifLocalVar88_g60235 = 0;
				if( temp_output_56_0_g60235 > 0.0 )
				ifLocalVar88_g60235 = temp_output_90_0_g60235;
				else if( temp_output_56_0_g60235 == 0.0 )
				ifLocalVar88_g60235 = temp_output_123_0_g60235;
				else if( temp_output_56_0_g60235 < 0.0 )
				ifLocalVar88_g60235 = temp_output_123_0_g60235;
				float3 temp_output_7_0_g60237 = frac( ( (ifLocalVar88_g60235).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g60237 = dot( temp_output_7_0_g60237 , ( (temp_output_7_0_g60237).yzx + 33.33 ) );
				float3 temp_output_12_0_g60237 = ( temp_output_7_0_g60237 + dotResult8_g60237 );
				float2 temp_output_597_26_g60234 = ( UV100_g60235 + frac( ( ( (temp_output_12_0_g60237).xx + (temp_output_12_0_g60237).yz ) * (temp_output_12_0_g60237).zy ) ) );
				float temp_output_66_0_g60235 = ( 1.0 - break55_g60235.y );
				float ifLocalVar60_g60235 = 0;
				if( temp_output_56_0_g60235 <= 0.0 )
				ifLocalVar60_g60235 = temp_output_66_0_g60235;
				else
				ifLocalVar60_g60235 = break55_g60235.y;
				float temp_output_597_28_g60234 = ifLocalVar60_g60235;
				float2 ifLocalVar89_g60235 = 0;
				if( temp_output_56_0_g60235 > 0.0 )
				ifLocalVar89_g60235 = temp_output_123_0_g60235;
				else if( temp_output_56_0_g60235 == 0.0 )
				ifLocalVar89_g60235 = temp_output_90_0_g60235;
				else if( temp_output_56_0_g60235 < 0.0 )
				ifLocalVar89_g60235 = temp_output_90_0_g60235;
				float3 temp_output_7_0_g60238 = frac( ( (ifLocalVar89_g60235).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g60238 = dot( temp_output_7_0_g60238 , ( (temp_output_7_0_g60238).yzx + 33.33 ) );
				float3 temp_output_12_0_g60238 = ( temp_output_7_0_g60238 + dotResult8_g60238 );
				float2 temp_output_597_27_g60234 = ( UV100_g60235 + frac( ( ( (temp_output_12_0_g60238).xx + (temp_output_12_0_g60238).yz ) * (temp_output_12_0_g60238).zy ) ) );
				float temp_output_67_0_g60235 = ( 1.0 - break55_g60235.x );
				float ifLocalVar61_g60235 = 0;
				if( temp_output_56_0_g60235 <= 0.0 )
				ifLocalVar61_g60235 = temp_output_67_0_g60235;
				else
				ifLocalVar61_g60235 = break55_g60235.x;
				float temp_output_597_29_g60234 = ifLocalVar61_g60235;
				float4 Output_2D293_g60234 = ( ( tex2D( _Sampler82964_g60214, temp_output_597_0_g60234, DDX631_g60234, DDY632_g60234 ) * temp_output_597_30_g60234 ) + ( tex2D( _Sampler82964_g60214, temp_output_597_26_g60234, DDX631_g60234, DDY632_g60234 ) * temp_output_597_28_g60234 ) + ( tex2D( _Sampler82964_g60214, temp_output_597_27_g60234, DDX631_g60234, DDY632_g60234 ) * temp_output_597_29_g60234 ) );
				float4 break31_g60234 = Output_2D293_g60234;
				#ifdef _STOCHASTICENABLED_ON
				float staticSwitch1004_g60214 = ( 1.0 - break31_g60234.r );
				#else
				float staticSwitch1004_g60214 = ( 1.0 - staticSwitch845_g60214 );
				#endif
				float temp_output_19_0_g60256 = staticSwitch1004_g60214;
				float2 temp_output_5_0_g60224 = UV0A2420_g60214;
				float2 UV633_g60224 = temp_output_5_0_g60224;
				float2 UV100_g60225 = UV633_g60224;
				float2 temp_output_51_0_g60225 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60225 * float2( 3.464,3.464 ) ) );
				float2 break55_g60225 = frac( temp_output_51_0_g60225 );
				float temp_output_56_0_g60225 = ( ( 1.0 - break55_g60225.x ) - break55_g60225.y );
				float2 temp_output_52_0_g60225 = floor( temp_output_51_0_g60225 );
				float2 temp_output_125_0_g60225 = ( temp_output_52_0_g60225 + float2( 1,1 ) );
				float2 ifLocalVar87_g60225 = 0;
				if( temp_output_56_0_g60225 > 0.0 )
				ifLocalVar87_g60225 = temp_output_52_0_g60225;
				else if( temp_output_56_0_g60225 == 0.0 )
				ifLocalVar87_g60225 = temp_output_125_0_g60225;
				else if( temp_output_56_0_g60225 < 0.0 )
				ifLocalVar87_g60225 = temp_output_125_0_g60225;
				float3 temp_output_7_0_g60226 = frac( ( (ifLocalVar87_g60225).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g60226 = dot( temp_output_7_0_g60226 , ( (temp_output_7_0_g60226).yzx + 33.33 ) );
				float3 temp_output_12_0_g60226 = ( temp_output_7_0_g60226 + dotResult8_g60226 );
				float2 temp_output_597_0_g60224 = ( UV100_g60225 + frac( ( ( (temp_output_12_0_g60226).xx + (temp_output_12_0_g60226).yz ) * (temp_output_12_0_g60226).zy ) ) );
				float2 DDX631_g60224 = ddx( temp_output_5_0_g60224 );
				float2 DDY632_g60224 = ddy( temp_output_5_0_g60224 );
				float Input_Scale617_g60224 = 1.5;
				float temp_output_65_0_g60225 = ( 0.0 - temp_output_56_0_g60225 );
				float ifLocalVar59_g60225 = 0;
				if( temp_output_56_0_g60225 <= 0.0 )
				ifLocalVar59_g60225 = temp_output_65_0_g60225;
				else
				ifLocalVar59_g60225 = temp_output_56_0_g60225;
				float temp_output_597_30_g60224 = ifLocalVar59_g60225;
				float2 temp_output_90_0_g60225 = ( temp_output_52_0_g60225 + float2( 0,1 ) );
				float2 temp_output_123_0_g60225 = ( temp_output_52_0_g60225 + float2( 1,0 ) );
				float2 ifLocalVar88_g60225 = 0;
				if( temp_output_56_0_g60225 > 0.0 )
				ifLocalVar88_g60225 = temp_output_90_0_g60225;
				else if( temp_output_56_0_g60225 == 0.0 )
				ifLocalVar88_g60225 = temp_output_123_0_g60225;
				else if( temp_output_56_0_g60225 < 0.0 )
				ifLocalVar88_g60225 = temp_output_123_0_g60225;
				float3 temp_output_7_0_g60227 = frac( ( (ifLocalVar88_g60225).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g60227 = dot( temp_output_7_0_g60227 , ( (temp_output_7_0_g60227).yzx + 33.33 ) );
				float3 temp_output_12_0_g60227 = ( temp_output_7_0_g60227 + dotResult8_g60227 );
				float2 temp_output_597_26_g60224 = ( UV100_g60225 + frac( ( ( (temp_output_12_0_g60227).xx + (temp_output_12_0_g60227).yz ) * (temp_output_12_0_g60227).zy ) ) );
				float temp_output_66_0_g60225 = ( 1.0 - break55_g60225.y );
				float ifLocalVar60_g60225 = 0;
				if( temp_output_56_0_g60225 <= 0.0 )
				ifLocalVar60_g60225 = temp_output_66_0_g60225;
				else
				ifLocalVar60_g60225 = break55_g60225.y;
				float temp_output_597_28_g60224 = ifLocalVar60_g60225;
				float2 ifLocalVar89_g60225 = 0;
				if( temp_output_56_0_g60225 > 0.0 )
				ifLocalVar89_g60225 = temp_output_123_0_g60225;
				else if( temp_output_56_0_g60225 == 0.0 )
				ifLocalVar89_g60225 = temp_output_90_0_g60225;
				else if( temp_output_56_0_g60225 < 0.0 )
				ifLocalVar89_g60225 = temp_output_90_0_g60225;
				float3 temp_output_7_0_g60228 = frac( ( (ifLocalVar89_g60225).xyx * float3( 0.1031, 0.103, 0.0973 ) ) );
				float dotResult8_g60228 = dot( temp_output_7_0_g60228 , ( (temp_output_7_0_g60228).yzx + 33.33 ) );
				float3 temp_output_12_0_g60228 = ( temp_output_7_0_g60228 + dotResult8_g60228 );
				float2 temp_output_597_27_g60224 = ( UV100_g60225 + frac( ( ( (temp_output_12_0_g60228).xx + (temp_output_12_0_g60228).yz ) * (temp_output_12_0_g60228).zy ) ) );
				float temp_output_67_0_g60225 = ( 1.0 - break55_g60225.x );
				float ifLocalVar61_g60225 = 0;
				if( temp_output_56_0_g60225 <= 0.0 )
				ifLocalVar61_g60225 = temp_output_67_0_g60225;
				else
				ifLocalVar61_g60225 = break55_g60225.x;
				float temp_output_597_29_g60224 = ifLocalVar61_g60225;
				float3 Output_2D_Normal641_g60224 = ( ( UnpackScaleNormal( tex2D( _Sampler82965_g60214, temp_output_597_0_g60224, DDX631_g60224, DDY632_g60224 ), Input_Scale617_g60224 ) * temp_output_597_30_g60224 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g60214, temp_output_597_26_g60224, DDX631_g60224, DDY632_g60224 ), Input_Scale617_g60224 ) * temp_output_597_28_g60224 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g60214, temp_output_597_27_g60224, DDX631_g60224, DDY632_g60224 ), Input_Scale617_g60224 ) * float3( 0,0,0 ) * temp_output_597_29_g60224 ) );
				#ifdef _STOCHASTICENABLED_ON
				float3 staticSwitch1003_g60214 = Output_2D_Normal641_g60224;
				#else
				float3 staticSwitch1003_g60214 = UnpackScaleNormal( tex2D( _BumpMap, UV0A2420_g60214 ), 1.5 );
				#endif
				#ifdef _BUMPMAP
				float3 staticSwitch980_g60214 = staticSwitch1003_g60214;
				#else
				float3 staticSwitch980_g60214 = float3( 0, 0, 1 );
				#endif
				float3 normalizeResult2878_g60214 = normalize( staticSwitch980_g60214 );
				float3 Normal700_g60214 = normalizeResult2878_g60214;
				float3 ase_tangentWS = IN.ase_texcoord2.xyz;
				float3 ase_normalWS = IN.ase_texcoord3.xyz;
				float3 ase_bitangentWS = IN.ase_texcoord4.xyz;
				float3 tanToWorld0 = float3( ase_tangentWS.x, ase_bitangentWS.x, ase_normalWS.x );
				float3 tanToWorld1 = float3( ase_tangentWS.y, ase_bitangentWS.y, ase_normalWS.y );
				float3 tanToWorld2 = float3( ase_tangentWS.z, ase_bitangentWS.z, ase_normalWS.z );
				float3 tanNormal2504_g60214 = Normal700_g60214;
				float3 worldNormal2504_g60214 = normalize( float3( dot( tanToWorld0, tanNormal2504_g60214 ), dot( tanToWorld1, tanNormal2504_g60214 ), dot( tanToWorld2, tanNormal2504_g60214 ) ) );
				float3 World_Normal2508_g60214 = worldNormal2504_g60214;
				float3 tanNormal2_g60256 = World_Normal2508_g60214;
				float3 worldNormal2_g60256 = float3( dot( tanToWorld0, tanNormal2_g60256 ), dot( tanToWorld1, tanNormal2_g60256 ), dot( tanToWorld2, tanNormal2_g60256 ) );
				float3 temp_output_3_0_g60256 = ddx( worldNormal2_g60256 );
				float dotResult5_g60256 = dot( temp_output_3_0_g60256 , temp_output_3_0_g60256 );
				float3 temp_output_4_0_g60256 = ddy( worldNormal2_g60256 );
				float dotResult6_g60256 = dot( temp_output_4_0_g60256 , temp_output_4_0_g60256 );
				#ifdef _USEGEOMETRICAA_ON
				float staticSwitch15_g60256 = min( temp_output_19_0_g60256, ( 1.0 - pow( saturate( max( dotResult5_g60256, dotResult6_g60256 ) ) , 0.25 ) ) );
				#else
				float staticSwitch15_g60256 = temp_output_19_0_g60256;
				#endif
				float Smoothness1399_g60214 = staticSwitch15_g60256;
				float Smoothness1_g60270 = Smoothness1399_g60214;
				float3 ase_positionWS = IN.ase_texcoord5.xyz;
				float3 ase_viewVectorWS = ( ( unity_OrthoParams.w == 0 ) ? _WorldSpaceCameraPos - ase_positionWS : UNITY_MATRIX_V[ 2 ].xyz );
				float3 ase_viewDirWS = normalize( ase_viewVectorWS );
				float3 View_Direction2511_g60214 = ase_viewDirWS;
				float3 ViewDir1_g60270 = View_Direction2511_g60214;
				float3 World_Position2505_g60214 = ase_positionWS;
				float3 WorldPos1_g60270 = World_Position2505_g60214;
				float3 WorldNormal1_g60270 = World_Normal2508_g60214;
				float4 temp_cast_2 = (Black1185_g60214).xxxx;
				float4 texCoord2426_g60214 = IN.ase_texcoord;
				texCoord2426_g60214.xy = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float2 UV0B2361_g60214 = (texCoord2426_g60214).zw;
				float localBicubicPrepare2_g60223 = ( 0.0 );
				float2 Input_UV100_g60223 = UV0B2361_g60214;
				float2 UV2_g60223 = Input_UV100_g60223;
				float4 TexelSize2_g60223 = _Lightmap0_TexelSize;
				float2 UV02_g60223 = float2( 0,0 );
				float2 UV12_g60223 = float2( 0,0 );
				float2 UV22_g60223 = float2( 0,0 );
				float2 UV32_g60223 = float2( 0,0 );
				float W02_g60223 = 0;
				float W12_g60223 = 0;
				{
				{
				 UV2_g60223 = UV2_g60223 * TexelSize2_g60223.zw - 0.5;
				    float2 f = frac( UV2_g60223 );
				    UV2_g60223 -= f;
				    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
				    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
				    float4 xs = xn * xn * xn;
				    float4 ys = yn * yn * yn;
				    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
				    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
				    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
				 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
				    float4 c = float4( UV2_g60223.x - 0.5, UV2_g60223.x + 1.5, UV2_g60223.y - 0.5, UV2_g60223.y + 1.5 );
				    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
				    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60223.xyxy;
				    UV02_g60223 = off.xz;
				    UV12_g60223 = off.yz;
				    UV22_g60223 = off.xw;
				    UV32_g60223 = off.yw;
				    W02_g60223 = s.x / ( s.x + s.y );
				 W12_g60223 = s.z / ( s.z + s.w );
				}
				}
				float4 lerpResult46_g60223 = lerp( tex2D( _Lightmap0, UV32_g60223 ) , tex2D( _Lightmap0, UV22_g60223 ) , W02_g60223);
				float4 lerpResult45_g60223 = lerp( tex2D( _Lightmap0, UV12_g60223 ) , tex2D( _Lightmap0, UV02_g60223 ) , W02_g60223);
				float4 lerpResult44_g60223 = lerp( lerpResult46_g60223 , lerpResult45_g60223 , W12_g60223);
				float4 Output_2D_Auto131_g60223 = lerpResult44_g60223;
				#ifdef _USEBICUBICFILTERING_ON
				float4 staticSwitch1092_g60214 = Output_2D_Auto131_g60223;
				#else
				float4 staticSwitch1092_g60214 = float4( tex2D( _Lightmap0, UV0B2361_g60214 ).rgb , 0.0 );
				#endif
				float4 Lightmap_0925_g60214 = staticSwitch1092_g60214;
				float localBicubicPrepare2_g60221 = ( 0.0 );
				float2 Input_UV100_g60221 = UV0B2361_g60214;
				float2 UV2_g60221 = Input_UV100_g60221;
				float4 TexelSize2_g60221 = _Lightmap1_TexelSize;
				float2 UV02_g60221 = float2( 0,0 );
				float2 UV12_g60221 = float2( 0,0 );
				float2 UV22_g60221 = float2( 0,0 );
				float2 UV32_g60221 = float2( 0,0 );
				float W02_g60221 = 0;
				float W12_g60221 = 0;
				{
				{
				 UV2_g60221 = UV2_g60221 * TexelSize2_g60221.zw - 0.5;
				    float2 f = frac( UV2_g60221 );
				    UV2_g60221 -= f;
				    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
				    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
				    float4 xs = xn * xn * xn;
				    float4 ys = yn * yn * yn;
				    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
				    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
				    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
				 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
				    float4 c = float4( UV2_g60221.x - 0.5, UV2_g60221.x + 1.5, UV2_g60221.y - 0.5, UV2_g60221.y + 1.5 );
				    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
				    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60221.xyxy;
				    UV02_g60221 = off.xz;
				    UV12_g60221 = off.yz;
				    UV22_g60221 = off.xw;
				    UV32_g60221 = off.yw;
				    W02_g60221 = s.x / ( s.x + s.y );
				 W12_g60221 = s.z / ( s.z + s.w );
				}
				}
				float4 lerpResult46_g60221 = lerp( tex2D( _Lightmap1, UV32_g60221 ) , tex2D( _Lightmap1, UV22_g60221 ) , W02_g60221);
				float4 lerpResult45_g60221 = lerp( tex2D( _Lightmap1, UV12_g60221 ) , tex2D( _Lightmap1, UV02_g60221 ) , W02_g60221);
				float4 lerpResult44_g60221 = lerp( lerpResult46_g60221 , lerpResult45_g60221 , W12_g60221);
				float4 Output_2D_Auto131_g60221 = lerpResult44_g60221;
				#ifdef _USEBICUBICFILTERING_ON
				float4 staticSwitch1088_g60214 = Output_2D_Auto131_g60221;
				#else
				float4 staticSwitch1088_g60214 = tex2D( _Lightmap1, UV0B2361_g60214 );
				#endif
				float4 Lightmap_1956_g60214 = staticSwitch1088_g60214;
				float Lightmap_Lerp_Value969_g60214 = _UdonLightmapLerp;
				float4 lerpResult442_g60214 = lerp( Lightmap_0925_g60214 , Lightmap_1956_g60214 , Lightmap_Lerp_Value969_g60214);
				float4 Lightmap_Lerp932_g60214 = lerpResult442_g60214;
				float3 appendResult139_g60262 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
				float3 Normal_Map318_g60262 = Normal700_g60214;
				float dotResult121_g60262 = dot( appendResult139_g60262 , Normal_Map318_g60262 );
				float temp_output_2_0_g60264 = saturate( dotResult121_g60262 );
				float localStochasticTiling2_g60245 = ( 0.0 );
				float2 UV2_g60245 = UV0B2361_g60214;
				float4 TexelSize2_g60245 = _UdonRNMX0_TexelSize;
				float4 Offsets2_g60245 = float4( 0,0,0,0 );
				float2 Weights2_g60245 = float2( 0,0 );
				{
				UV2_g60245 = UV2_g60245 * TexelSize2_g60245.zw - 0.5;
				float2 f = frac( UV2_g60245 );
				UV2_g60245 -= f;
				float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
				float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
				float4 xs = xn * xn * xn;
				float4 ys = yn * yn * yn;
				float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
				float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
				float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
				float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
				float4 c = float4( UV2_g60245.x - 0.5, UV2_g60245.x + 1.5, UV2_g60245.y - 0.5, UV2_g60245.y + 1.5 );
				float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
				float w0 = s.x / ( s.x + s.y );
				float w1 = s.z / ( s.z + s.w );
				Offsets2_g60245 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60245.xyxy;
				Weights2_g60245 = float2( w0, w1 );
				}
				float4 temp_output_1_34_g60244 = Offsets2_g60245;
				float4 Input_FetchOffsets197_g60246 = temp_output_1_34_g60244;
				float2 temp_output_1_54_g60244 = Weights2_g60245;
				float2 Input_FetchWeights200_g60246 = temp_output_1_54_g60244;
				float2 break187_g60246 = Input_FetchWeights200_g60246;
				float4 lerpResult181_g60246 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60246).yw ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60246).xw ) , break187_g60246.x);
				float4 lerpResult182_g60246 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60246).yz ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60246).xz ) , break187_g60246.x);
				float4 lerpResult176_g60246 = lerp( lerpResult181_g60246 , lerpResult182_g60246 , break187_g60246.y);
				float4 Output_Fetch2D_Auto202_g60246 = lerpResult176_g60246;
				#ifdef _USEBICUBICFILTERING_ON
				float4 staticSwitch1061_g60214 = Output_Fetch2D_Auto202_g60246;
				#else
				float4 staticSwitch1061_g60214 = tex2D( _UdonRNMX0, UV0B2361_g60214 );
				#endif
				float3 appendResult146_g60262 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
				float dotResult122_g60262 = dot( appendResult146_g60262 , Normal_Map318_g60262 );
				float temp_output_2_0_g60263 = saturate( dotResult122_g60262 );
				float4 Input_FetchOffsets197_g60247 = temp_output_1_34_g60244;
				float2 Input_FetchWeights200_g60247 = temp_output_1_54_g60244;
				float2 break187_g60247 = Input_FetchWeights200_g60247;
				float4 lerpResult181_g60247 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60247).yw ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60247).xw ) , break187_g60247.x);
				float4 lerpResult182_g60247 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60247).yz ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60247).xz ) , break187_g60247.x);
				float4 lerpResult176_g60247 = lerp( lerpResult181_g60247 , lerpResult182_g60247 , break187_g60247.y);
				float4 Output_Fetch2D_Auto202_g60247 = lerpResult176_g60247;
				#ifdef _USEBICUBICFILTERING_ON
				float4 staticSwitch1062_g60214 = Output_Fetch2D_Auto202_g60247;
				#else
				float4 staticSwitch1062_g60214 = tex2D( _UdonRNMY0, UV0B2361_g60214 );
				#endif
				float3 appendResult149_g60262 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
				float dotResult120_g60262 = dot( appendResult149_g60262 , Normal_Map318_g60262 );
				float temp_output_2_0_g60265 = saturate( dotResult120_g60262 );
				float4 Input_FetchOffsets197_g60248 = temp_output_1_34_g60244;
				float2 Input_FetchWeights200_g60248 = temp_output_1_54_g60244;
				float2 break187_g60248 = Input_FetchWeights200_g60248;
				float4 lerpResult181_g60248 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60248).yw ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60248).xw ) , break187_g60248.x);
				float4 lerpResult182_g60248 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60248).yz ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60248).xz ) , break187_g60248.x);
				float4 lerpResult176_g60248 = lerp( lerpResult181_g60248 , lerpResult182_g60248 , break187_g60248.y);
				float4 Output_Fetch2D_Auto202_g60248 = lerpResult176_g60248;
				#ifdef _USEBICUBICFILTERING_ON
				float4 staticSwitch1063_g60214 = Output_Fetch2D_Auto202_g60248;
				#else
				float4 staticSwitch1063_g60214 = tex2D( _UdonRNMZ0, UV0B2361_g60214 );
				#endif
				float4 temp_output_3094_0_g60214 = ( ( ( ( ( temp_output_2_0_g60264 * temp_output_2_0_g60264 ) * staticSwitch1061_g60214 ) + ( ( temp_output_2_0_g60263 * temp_output_2_0_g60263 ) * staticSwitch1062_g60214 ) ) + ( ( temp_output_2_0_g60265 * temp_output_2_0_g60265 ) * staticSwitch1063_g60214 ) ) * 1.2 );
				float4 RNM_0926_g60214 = temp_output_3094_0_g60214;
				float3 appendResult139_g60258 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
				float3 Normal_Map318_g60258 = Normal700_g60214;
				float dotResult121_g60258 = dot( appendResult139_g60258 , Normal_Map318_g60258 );
				float temp_output_2_0_g60260 = saturate( dotResult121_g60258 );
				float localStochasticTiling2_g60216 = ( 0.0 );
				float2 UV2_g60216 = UV0B2361_g60214;
				float4 TexelSize2_g60216 = _UdonRNMX1_TexelSize;
				float4 Offsets2_g60216 = float4( 0,0,0,0 );
				float2 Weights2_g60216 = float2( 0,0 );
				{
				UV2_g60216 = UV2_g60216 * TexelSize2_g60216.zw - 0.5;
				float2 f = frac( UV2_g60216 );
				UV2_g60216 -= f;
				float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
				float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
				float4 xs = xn * xn * xn;
				float4 ys = yn * yn * yn;
				float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
				float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
				float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
				float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
				float4 c = float4( UV2_g60216.x - 0.5, UV2_g60216.x + 1.5, UV2_g60216.y - 0.5, UV2_g60216.y + 1.5 );
				float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
				float w0 = s.x / ( s.x + s.y );
				float w1 = s.z / ( s.z + s.w );
				Offsets2_g60216 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60216.xyxy;
				Weights2_g60216 = float2( w0, w1 );
				}
				float4 temp_output_1_34_g60215 = Offsets2_g60216;
				float4 Input_FetchOffsets197_g60217 = temp_output_1_34_g60215;
				float2 temp_output_1_54_g60215 = Weights2_g60216;
				float2 Input_FetchWeights200_g60217 = temp_output_1_54_g60215;
				float2 break187_g60217 = Input_FetchWeights200_g60217;
				float4 lerpResult181_g60217 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60217).yw ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60217).xw ) , break187_g60217.x);
				float4 lerpResult182_g60217 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60217).yz ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60217).xz ) , break187_g60217.x);
				float4 lerpResult176_g60217 = lerp( lerpResult181_g60217 , lerpResult182_g60217 , break187_g60217.y);
				float4 Output_Fetch2D_Auto202_g60217 = lerpResult176_g60217;
				#ifdef _USEBICUBICFILTERING_ON
				float4 staticSwitch1087_g60214 = Output_Fetch2D_Auto202_g60217;
				#else
				float4 staticSwitch1087_g60214 = tex2D( _UdonRNMX1, UV0B2361_g60214 );
				#endif
				float3 appendResult146_g60258 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
				float dotResult122_g60258 = dot( appendResult146_g60258 , Normal_Map318_g60258 );
				float temp_output_2_0_g60259 = saturate( dotResult122_g60258 );
				float4 Input_FetchOffsets197_g60218 = temp_output_1_34_g60215;
				float2 Input_FetchWeights200_g60218 = temp_output_1_54_g60215;
				float2 break187_g60218 = Input_FetchWeights200_g60218;
				float4 lerpResult181_g60218 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60218).yw ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60218).xw ) , break187_g60218.x);
				float4 lerpResult182_g60218 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60218).yz ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60218).xz ) , break187_g60218.x);
				float4 lerpResult176_g60218 = lerp( lerpResult181_g60218 , lerpResult182_g60218 , break187_g60218.y);
				float4 Output_Fetch2D_Auto202_g60218 = lerpResult176_g60218;
				#ifdef _USEBICUBICFILTERING_ON
				float4 staticSwitch1083_g60214 = Output_Fetch2D_Auto202_g60218;
				#else
				float4 staticSwitch1083_g60214 = tex2D( _UdonRNMY1, UV0B2361_g60214 );
				#endif
				float3 appendResult149_g60258 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
				float dotResult120_g60258 = dot( appendResult149_g60258 , Normal_Map318_g60258 );
				float temp_output_2_0_g60261 = saturate( dotResult120_g60258 );
				float4 Input_FetchOffsets197_g60219 = temp_output_1_34_g60215;
				float2 Input_FetchWeights200_g60219 = temp_output_1_54_g60215;
				float2 break187_g60219 = Input_FetchWeights200_g60219;
				float4 lerpResult181_g60219 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60219).yw ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60219).xw ) , break187_g60219.x);
				float4 lerpResult182_g60219 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60219).yz ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60219).xz ) , break187_g60219.x);
				float4 lerpResult176_g60219 = lerp( lerpResult181_g60219 , lerpResult182_g60219 , break187_g60219.y);
				float4 Output_Fetch2D_Auto202_g60219 = lerpResult176_g60219;
				#ifdef _USEBICUBICFILTERING_ON
				float4 staticSwitch1084_g60214 = Output_Fetch2D_Auto202_g60219;
				#else
				float4 staticSwitch1084_g60214 = tex2D( _UdonRNMZ1, UV0B2361_g60214 );
				#endif
				float4 RNM_11081_g60214 = ( ( ( ( ( temp_output_2_0_g60260 * temp_output_2_0_g60260 ) * staticSwitch1087_g60214 ) + ( ( temp_output_2_0_g60259 * temp_output_2_0_g60259 ) * staticSwitch1083_g60214 ) ) + ( ( temp_output_2_0_g60261 * temp_output_2_0_g60261 ) * staticSwitch1084_g60214 ) ) * 1.2 );
				float4 lerpResult953_g60214 = lerp( RNM_0926_g60214 , RNM_11081_g60214 , Lightmap_Lerp_Value969_g60214);
				float4 RNM_Lerp950_g60214 = lerpResult953_g60214;
				#if defined( _LIGHTMAPMODE_DISABLED )
				float4 staticSwitch1014_g60214 = temp_cast_2;
				#elif defined( _LIGHTMAPMODE_SIMPLE )
				float4 staticSwitch1014_g60214 = Lightmap_0925_g60214;
				#elif defined( _LIGHTMAPMODE_SIMPLELERP )
				float4 staticSwitch1014_g60214 = Lightmap_Lerp932_g60214;
				#elif defined( _LIGHTMAPMODE_RNM )
				float4 staticSwitch1014_g60214 = RNM_0926_g60214;
				#elif defined( _LIGHTMAPMODE_RNMLERP )
				float4 staticSwitch1014_g60214 = RNM_Lerp950_g60214;
				#else
				float4 staticSwitch1014_g60214 = temp_cast_2;
				#endif
				float3 Lightmap46_g60214 = (staticSwitch1014_g60214).rgb;
				float dotResult9_g60271 = dot( float3( 0.212673, 0.715152, 0.072175 ) , Lightmap46_g60214 );
				float smoothstepResult14_g60271 = smoothstep( 0.0 , 0.1 , dotResult9_g60271);
				float Indirect_Lightmap_Mask3118_g60214 = smoothstepResult14_g60271;
				float LightmapMask1_g60270 = Indirect_Lightmap_Mask3118_g60214;
				float3 localIndirectSpecular1_g60270 = IndirectSpecular( Color1_g60270 , Metallic1_g60270 , Smoothness1_g60270 , ViewDir1_g60270 , WorldPos1_g60270 , WorldNormal1_g60270 , LightmapMask1_g60270 );
				#ifdef _INDIRECTSPECULARS_ON
				float3 staticSwitch2971_g60214 = localIndirectSpecular1_g60270;
				#else
				float3 staticSwitch2971_g60214 = temp_cast_1;
				#endif
				float3 Indirect_Specular1419_g60214 = staticSwitch2971_g60214;
				float3 temp_cast_4 = (Black1185_g60214).xxx;
				float3 Color97_g60273 = oAlbedo6_g60214;
				float Metallic97_g60273 = Metallic1239_g60214;
				float Smoothness97_g60273 = Smoothness1399_g60214;
				float3 ViewDir97_g60273 = View_Direction2511_g60214;
				float3 WorldPos97_g60273 = World_Position2505_g60214;
				float3 WorldNormal97_g60273 = World_Normal2508_g60214;
				float3 Vertex_Normal3161_g60214 = IN.ase_normal;
				float3 GeoNormal97_g60273 = Vertex_Normal3161_g60214;
				float White38_g60214 = 1.0;
				#if defined( _LIGHTMAPMODE_DISABLED )
				float staticSwitch3107_g60214 = Black1185_g60214;
				#elif defined( _LIGHTMAPMODE_SIMPLE )
				float staticSwitch3107_g60214 = White38_g60214;
				#elif defined( _LIGHTMAPMODE_SIMPLELERP )
				float staticSwitch3107_g60214 = White38_g60214;
				#elif defined( _LIGHTMAPMODE_RNM )
				float staticSwitch3107_g60214 = White38_g60214;
				#elif defined( _LIGHTMAPMODE_RNMLERP )
				float staticSwitch3107_g60214 = White38_g60214;
				#else
				float staticSwitch3107_g60214 = Black1185_g60214;
				#endif
				float LightmapMode97_g60273 = staticSwitch3107_g60214;
				float dotResult9_g60272 = dot( float3( 0.212673, 0.715152, 0.072175 ) , Lightmap46_g60214 );
				float smoothstepResult2_g60272 = smoothstep( 0.0 , 0.1 , dotResult9_g60272);
				float Direct_Lightmap_Mask3067_g60214 = smoothstepResult2_g60272;
				float LightmapMask97_g60273 = Direct_Lightmap_Mask3067_g60214;
				float3 localDirectSpecular97_g60273 = DirectSpecular( Color97_g60273 , Metallic97_g60273 , Smoothness97_g60273 , ViewDir97_g60273 , WorldPos97_g60273 , WorldNormal97_g60273 , GeoNormal97_g60273 , LightmapMode97_g60273 , LightmapMask97_g60273 );
				#ifdef _DIRECTSPECULAR_ON
				float3 staticSwitch2969_g60214 = localDirectSpecular97_g60273;
				#else
				float3 staticSwitch2969_g60214 = temp_cast_4;
				#endif
				float3 Direct_Specular2560_g60214 = staticSwitch2969_g60214;
				float3 aAlbedo1466_g60214 = ( temp_output_2532_0_g60214 * ( 1.0 - Metallic1239_g60214 ) );
				float3 temp_output_1252_0_g60214 = ( aAlbedo1466_g60214 * Lightmap46_g60214 );
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch1_g60257 = float4( ( temp_output_1252_0_g60214 + Emission86_g60214 + Indirect_Specular1419_g60214 ) , 0.0 );
				#else
				float4 staticSwitch1_g60257 = float4( ( Emission86_g60214 + Indirect_Specular1419_g60214 + Direct_Specular2560_g60214 + temp_output_1252_0_g60214 ) , 0.0 );
				#endif
				#ifdef _LIGHTMAPDEBUG
				float4 staticSwitch1181_g60214 = float4( Lightmap46_g60214 , 0.0 );
				#else
				float4 staticSwitch1181_g60214 = staticSwitch1_g60257;
				#endif
				float4 Color357_g60254 = staticSwitch1181_g60214;
				float4 LUT51_g60254 = tex3D( _LUT, ( ( log10( ( ( (Color357_g60254).xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 ) );
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch359_g60254 = LUT51_g60254;
				#else
				float4 staticSwitch359_g60254 = Color357_g60254;
				#endif
				

				float4 Color = staticSwitch359_g60254;
				float Alpha = staticSwitch1001_g60214.a;
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
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3064;192,-1200;Inherit;False;Meenphie;0;;60214;b3ba55a08dd6b49c7be16c6f35cf2033;6,1008,0,2632,1,2635,1,2619,1,2670,1,2636,1;0;3;FLOAT4;624;FLOAT;156;FLOAT;427
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3057;256,-1024;Inherit;False;Property;_Offset;Offset;51;0;Create;True;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3066;512,-1200;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;8;Meenphie/Standard/Transparent/Alpha;57d65cf91784ef85cbf389359c250935;True;Unlit;0;0;Unlit;7;True;True;2;5;False;;10;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;2;False;;True;3;False;;True;True;-1;True;_Offset;-1;True;_Offset;True;1;False;;True;2;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;6;Rendering Mode;1;639163669611142150;Alpha Clipping;0;0;  Use Shadow Threshold;0;0;Cast Shadows;0;639163669616938460;Write Depth;0;0;Vertex Position;1;0;0;2;True;False;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3067;512,-1200;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;57d65cf91784ef85cbf389359c250935;True;ShadowCaster;0;1;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;False;;True;2;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
WireConnection;3066;0;3064;624
WireConnection;3066;7;3064;156
ASEEND*/
//CHKSM=E0A708114FFC611A70EACC47DFFBA398F121A251