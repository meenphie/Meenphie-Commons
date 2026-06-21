// Made with Amplify Shader Editor v1.9.9.10
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
		[NoScaleOffset][SingleLineTexture] _UdonLightmap( "Lightmap 0", 2D ) = "black" {}
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
		[Toggle( _INDIRECTSPECULARS_ON )] _IndirectSpeculars( "Indirect Speculars", Float ) = 1
		[HideInInspector] GenKey__GlossinessMap( "Assign keyword _GLOSSINESSMAP", Float ) = 1.0
		[HideInInspector] GenKey__MainTex( "Assign keyword _MAINTEX", Float ) = 1.0
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0
		[HideInInspector] GenKey__MetallicMap( "Assign keyword _METALLICMAP", Float ) = 1.0

	}

	SubShader
	{
		

		

		Tags { "RenderType"="Opaque" "Queue"="Geometry" }

	LOD 0

		ZWrite On
		Cull Back
		AlphaToMask Off
		ColorMask RGBA
		Blend One Zero, One Zero
		BlendOp Add, Add

		

		Blend Off
		

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

			Cull Back
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA
			Blend One Zero, One Zero
			BlendOp Add, Add

			

			CGPROGRAM
				#define ASE_VERSION 19910

				#pragma vertex vert
				#pragma fragment frag
				#pragma multi_compile_instancing
				#include "UnityCG.cginc"

				#include "Packages/com.meenphie.commons/Commons/Shaders/Custom Expressions/DirectSpecular.cginc"
				#include "UnityStandardUtils.cginc"
				#include "Packages/com.meenphie.commons/Commons/Shaders/Custom Expressions/IndirectSpecular.cginc"
				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#define ASE_NEEDS_VERT_TANGENT
				#define ASE_NEEDS_VERT_NORMAL
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
				#pragma shader_feature _LIGHTMAPDEBUG
				#pragma shader_feature_local _STOCHASTICENABLED_ON
				#pragma shader_feature_local _METALLICMAP
				#pragma shader_feature_local _USEGEOMETRICAA_ON
				#pragma shader_feature_local _GLOSSINESSMAP
				#pragma shader_feature_local _BUMPMAP
				#pragma shader_feature_local _INDIRECTSPECULARS_ON
				#pragma shader_feature_local _LIGHTMAPMODE_DISABLED _LIGHTMAPMODE_SIMPLE _LIGHTMAPMODE_SIMPLELERP _LIGHTMAPMODE_RNM _LIGHTMAPMODE_RNMLERP
				#pragma shader_feature_local _USEBICUBICFILTERING_ON


				#if defined(ASE_WRITE_DEPTH_CONSERVATIVE) && (SHADER_TARGET >= 45)
					#define ASE_SV_DEPTH SV_DepthLessEqual
					#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
				#else
					#define ASE_SV_DEPTH SV_Depth
					#define ASE_SV_POSITION_QUALIFIERS
				#endif

				struct appdata
				{
					float4 vertex : POSITION;
					float3 normal : NORMAL;
					float4 tangent : TANGENT;
					float4 ase_texcoord : TEXCOORD0;
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct v2f
				{
					ASE_SV_POSITION_QUALIFIERS float4 pos : SV_POSITION;
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
				uniform float _CATEGORYSPACELIGHTMAPPING;
				uniform float _CATEGORYSTOCHASTIC;
				uniform float _CATEGORYSPACESTOCHASTIC;
				uniform float _CATEGORYSPACECOLORGRADING;
				uniform float _CATEGORYCOLORGRADING;
				uniform float _CATEGORYSPACESPECIALEFFECTS;
				uniform float _CATEGORYSPECIALEFFECTS;
				uniform float _CATEGORYSPACESURFACEOPTIONS;
				uniform float _CATEGORYLIGHTMAPPING;
				uniform sampler3D _LUT;
				uniform half4 _Color;
				uniform sampler2D _MainTex;
				sampler2D _Sampler82966_g1;
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				sampler2D _Sampler82967_g1;
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				sampler2D _Sampler82964_g1;
				uniform sampler2D _BumpMap;
				sampler2D _Sampler82965_g1;
				uniform sampler2D _UdonLightmap;
				float4 _UdonLightmap_TexelSize;
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
				uniform float3 _EmissionColor;
				uniform sampler2D _EmissionMap;
				sampler2D _Sampler82968_g1;
				uniform float _EmissionIntensity;


				float2 Hash22( float2 p )
				{
					float3 p3 = frac( p.xyx * float3( 0.1031, 0.1030, 0.0973 ) );
					p3 += dot( p3, p3.yzx + 33.33 );
					return frac( ( p3.xx + p3.yz ) * p3.zy );
				}
				

				v2f vert( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					o.ase_texcoord1.xyz = ase_tangentWS;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					o.ase_texcoord2.xyz = ase_normalWS;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
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
					v.tangent = v.tangent;

					o.pos = UnityObjectToClipPos( v.vertex );

					#if defined( ASE_SHADOWS )
						UNITY_TRANSFER_SHADOW( o, v.texcoord );
					#endif
					return o;
				}

				half4 frag( v2f IN 
							#if defined( ASE_WRITE_DEPTH )
								, out float outputDepth : SV_Depth
							#endif
				) : SV_Target
				{
					UNITY_SETUP_INSTANCE_ID( IN );
					UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

					float4 ScreenPosNorm = float4( IN.pos.xy * ( _ScreenParams.zw - 1.0 ), IN.pos.zw );
					float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, IN.pos.z ) * IN.pos.w;
					float4 ScreenPos = ComputeScreenPos( ClipPos );

					float2 texCoord2357_g1 = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
					float2 UV_Diffuse2420_g1 = texCoord2357_g1;
					float2 temp_output_5_0_g59681 = UV_Diffuse2420_g1;
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
					float2 temp_output_597_0_g59681 = ( UV100_g59682 + Hash22( ifLocalVar87_g59682 ) );
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
					float2 temp_output_597_26_g59681 = ( UV100_g59682 + Hash22( ifLocalVar88_g59682 ) );
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
					float2 temp_output_597_27_g59681 = ( UV100_g59682 + Hash22( ifLocalVar89_g59682 ) );
					float temp_output_67_0_g59682 = ( 1.0 - break55_g59682.x );
					float ifLocalVar61_g59682 = 0;
					if( temp_output_56_0_g59682 <= 0.0 )
					ifLocalVar61_g59682 = temp_output_67_0_g59682;
					else
					ifLocalVar61_g59682 = break55_g59682.x;
					float temp_output_597_29_g59681 = ifLocalVar61_g59682;
					float4 Output_2D293_g59681 = ( ( tex2D( _Sampler82966_g1, temp_output_597_0_g59681, DDX631_g59681, DDY632_g59681 ) * temp_output_597_30_g59681 ) + ( tex2D( _Sampler82966_g1, temp_output_597_26_g59681, DDX631_g59681, DDY632_g59681 ) * temp_output_597_28_g59681 ) + ( tex2D( _Sampler82966_g1, temp_output_597_27_g59681, DDX631_g59681, DDY632_g59681 ) * temp_output_597_29_g59681 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g1 = Output_2D293_g59681;
					#else
					float4 staticSwitch1001_g1 = ( _Color * tex2D( _MainTex, UV_Diffuse2420_g1 ) );
					#endif
					float3 temp_output_2532_0_g1 = (staticSwitch1001_g1).rgb;
					float3 oAlbedo6_g1 = temp_output_2532_0_g1;
					float3 Color97_g60026 = oAlbedo6_g1;
					#ifdef _METALLICMAP
					float staticSwitch846_g1 = tex2D( _MetallicMap, UV_Diffuse2420_g1 ).r;
					#else
					float staticSwitch846_g1 = _Metallic;
					#endif
					float2 temp_output_5_0_g59755 = UV_Diffuse2420_g1;
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
					float2 temp_output_597_0_g59755 = ( UV100_g59756 + Hash22( ifLocalVar87_g59756 ) );
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
					float2 temp_output_597_26_g59755 = ( UV100_g59756 + Hash22( ifLocalVar88_g59756 ) );
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
					float2 temp_output_597_27_g59755 = ( UV100_g59756 + Hash22( ifLocalVar89_g59756 ) );
					float temp_output_67_0_g59756 = ( 1.0 - break55_g59756.x );
					float ifLocalVar61_g59756 = 0;
					if( temp_output_56_0_g59756 <= 0.0 )
					ifLocalVar61_g59756 = temp_output_67_0_g59756;
					else
					ifLocalVar61_g59756 = break55_g59756.x;
					float temp_output_597_29_g59755 = ifLocalVar61_g59756;
					float4 Output_2D293_g59755 = ( ( tex2D( _Sampler82967_g1, temp_output_597_0_g59755, DDX631_g59755, DDY632_g59755 ) * temp_output_597_30_g59755 ) + ( tex2D( _Sampler82967_g1, temp_output_597_26_g59755, DDX631_g59755, DDY632_g59755 ) * temp_output_597_28_g59755 ) + ( tex2D( _Sampler82967_g1, temp_output_597_27_g59755, DDX631_g59755, DDY632_g59755 ) * temp_output_597_29_g59755 ) );
					float4 break31_g59755 = Output_2D293_g59755;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g1 = break31_g59755.r;
					#else
					float staticSwitch1005_g1 = staticSwitch846_g1;
					#endif
					float Metallic1239_g1 = staticSwitch1005_g1;
					float Metallic97_g60026 = Metallic1239_g1;
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g1 = tex2D( _GlossinessMap, UV_Diffuse2420_g1 ).r;
					#else
					float staticSwitch845_g1 = _Glossiness;
					#endif
					float2 temp_output_5_0_g59686 = UV_Diffuse2420_g1;
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
					float2 temp_output_597_0_g59686 = ( UV100_g59687 + Hash22( ifLocalVar87_g59687 ) );
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
					float2 temp_output_597_26_g59686 = ( UV100_g59687 + Hash22( ifLocalVar88_g59687 ) );
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
					float2 temp_output_597_27_g59686 = ( UV100_g59687 + Hash22( ifLocalVar89_g59687 ) );
					float temp_output_67_0_g59687 = ( 1.0 - break55_g59687.x );
					float ifLocalVar61_g59687 = 0;
					if( temp_output_56_0_g59687 <= 0.0 )
					ifLocalVar61_g59687 = temp_output_67_0_g59687;
					else
					ifLocalVar61_g59687 = break55_g59687.x;
					float temp_output_597_29_g59686 = ifLocalVar61_g59687;
					float4 Output_2D293_g59686 = ( ( tex2D( _Sampler82964_g1, temp_output_597_0_g59686, DDX631_g59686, DDY632_g59686 ) * temp_output_597_30_g59686 ) + ( tex2D( _Sampler82964_g1, temp_output_597_26_g59686, DDX631_g59686, DDY632_g59686 ) * temp_output_597_28_g59686 ) + ( tex2D( _Sampler82964_g1, temp_output_597_27_g59686, DDX631_g59686, DDY632_g59686 ) * temp_output_597_29_g59686 ) );
					float4 break31_g59686 = Output_2D293_g59686;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g1 = ( 1.0 - break31_g59686.r );
					#else
					float staticSwitch1004_g1 = ( 1.0 - staticSwitch845_g1 );
					#endif
					float temp_output_19_0_g60007 = staticSwitch1004_g1;
					float2 temp_output_5_0_g59660 = UV_Diffuse2420_g1;
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
					float2 temp_output_597_0_g59660 = ( UV100_g59661 + Hash22( ifLocalVar87_g59661 ) );
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
					float2 temp_output_597_26_g59660 = ( UV100_g59661 + Hash22( ifLocalVar88_g59661 ) );
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
					float2 temp_output_597_27_g59660 = ( UV100_g59661 + Hash22( ifLocalVar89_g59661 ) );
					float temp_output_67_0_g59661 = ( 1.0 - break55_g59661.x );
					float ifLocalVar61_g59661 = 0;
					if( temp_output_56_0_g59661 <= 0.0 )
					ifLocalVar61_g59661 = temp_output_67_0_g59661;
					else
					ifLocalVar61_g59661 = break55_g59661.x;
					float temp_output_597_29_g59660 = ifLocalVar61_g59661;
					float3 Output_2D_Normal641_g59660 = ( ( UnpackScaleNormal( tex2D( _Sampler82965_g1, temp_output_597_0_g59660, DDX631_g59660, DDY632_g59660 ), Input_Scale617_g59660 ) * temp_output_597_30_g59660 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g1, temp_output_597_26_g59660, DDX631_g59660, DDY632_g59660 ), Input_Scale617_g59660 ) * temp_output_597_28_g59660 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g1, temp_output_597_27_g59660, DDX631_g59660, DDY632_g59660 ), Input_Scale617_g59660 ) * float3( 0,0,0 ) * temp_output_597_29_g59660 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g1 = Output_2D_Normal641_g59660;
					#else
					float3 staticSwitch1003_g1 = UnpackScaleNormal( tex2D( _BumpMap, UV_Diffuse2420_g1 ), 1.5 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g1 = staticSwitch1003_g1;
					#else
					float3 staticSwitch980_g1 = float3( 0, 0, 1 );
					#endif
					float3 normalizeResult2878_g1 = normalize( staticSwitch980_g1 );
					float3 Normal700_g1 = normalizeResult2878_g1;
					float3 ase_tangentWS = IN.ase_texcoord1.xyz;
					float3 ase_normalWS = IN.ase_texcoord2.xyz;
					float3 ase_bitangentWS = IN.ase_texcoord3.xyz;
					float3 tanToWorld0 = float3( ase_tangentWS.x, ase_bitangentWS.x, ase_normalWS.x );
					float3 tanToWorld1 = float3( ase_tangentWS.y, ase_bitangentWS.y, ase_normalWS.y );
					float3 tanToWorld2 = float3( ase_tangentWS.z, ase_bitangentWS.z, ase_normalWS.z );
					float3 tanNormal2504_g1 = Normal700_g1;
					float3 worldNormal2504_g1 = normalize( float3( dot( tanToWorld0, tanNormal2504_g1 ), dot( tanToWorld1, tanNormal2504_g1 ), dot( tanToWorld2, tanNormal2504_g1 ) ) );
					float3 World_Normal2508_g1 = worldNormal2504_g1;
					float3 tanNormal2_g60007 = World_Normal2508_g1;
					float3 worldNormal2_g60007 = float3( dot( tanToWorld0, tanNormal2_g60007 ), dot( tanToWorld1, tanNormal2_g60007 ), dot( tanToWorld2, tanNormal2_g60007 ) );
					float3 temp_output_3_0_g60007 = ddx( worldNormal2_g60007 );
					float dotResult5_g60007 = dot( temp_output_3_0_g60007 , temp_output_3_0_g60007 );
					float3 temp_output_4_0_g60007 = ddy( worldNormal2_g60007 );
					float dotResult6_g60007 = dot( temp_output_4_0_g60007 , temp_output_4_0_g60007 );
					#ifdef _USEGEOMETRICAA_ON
					float staticSwitch15_g60007 = min( temp_output_19_0_g60007, ( 1.0 - pow( saturate( max( dotResult5_g60007, dotResult6_g60007 ) ) , 0.25 ) ) );
					#else
					float staticSwitch15_g60007 = temp_output_19_0_g60007;
					#endif
					float Smoothness1399_g1 = staticSwitch15_g60007;
					float Smoothness97_g60026 = Smoothness1399_g1;
					float3 ase_positionWS = IN.ase_texcoord4.xyz;
					float3 ase_viewVectorWS = ( ( unity_OrthoParams.w == 0 ) ? _WorldSpaceCameraPos - ase_positionWS : UNITY_MATRIX_V[ 2 ].xyz );
					float3 ase_viewDirWS = normalize( ase_viewVectorWS );
					float3 View_Direction2511_g1 = ase_viewDirWS;
					float3 ViewDir97_g60026 = View_Direction2511_g1;
					float3 World_Position2505_g1 = ase_positionWS;
					float3 WorldPos97_g60026 = World_Position2505_g1;
					float3 WorldNormal97_g60026 = World_Normal2508_g1;
					float3 Vertex_Normal3161_g1 = IN.ase_normal;
					float3 VertexNormal97_g60026 = Vertex_Normal3161_g1;
					float4 texCoord2426_g1 = IN.ase_texcoord;
					texCoord2426_g1.xy = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
					float2 UV_Lightmap2361_g1 = (texCoord2426_g1).zw;
					float2 LightmapUV97_g60026 = UV_Lightmap2361_g1;
					float3 Diffuse97_g60026 = float3( 0,0,0 );
					float3 Specular97_g60026 = float3( 0,0,0 );
					float3 localDirectSpecular97_g60026 = DirectSpecular( Color97_g60026 , Metallic97_g60026 , Smoothness97_g60026 , ViewDir97_g60026 , WorldPos97_g60026 , WorldNormal97_g60026 , VertexNormal97_g60026 , LightmapUV97_g60026 , Diffuse97_g60026 , Specular97_g60026 );
					float3 Diffuse2560_g1 = Diffuse97_g60026;
					float3 Direct_Speculars3240_g1 = Specular97_g60026;
					float Black1185_g1 = 0.0;
					float3 temp_cast_0 = (Black1185_g1).xxx;
					float3 Color1_g60010 = oAlbedo6_g1;
					float Metallic1_g60010 = Metallic1239_g1;
					float Smoothness1_g60010 = Smoothness1399_g1;
					float3 ViewDir1_g60010 = View_Direction2511_g1;
					float3 WorldPos1_g60010 = World_Position2505_g1;
					float3 WorldNormal1_g60010 = World_Normal2508_g1;
					float White38_g1 = 1.0;
					float4 temp_cast_1 = (Black1185_g1).xxxx;
					float localBicubicPrepare2_g59567 = ( 0.0 );
					float2 Input_UV100_g59567 = UV_Lightmap2361_g1;
					float2 UV2_g59567 = Input_UV100_g59567;
					float4 TexelSize2_g59567 = _UdonLightmap_TexelSize;
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
					float4 lerpResult46_g59567 = lerp( tex2D( _UdonLightmap, UV32_g59567 ) , tex2D( _UdonLightmap, UV22_g59567 ) , W02_g59567);
					float4 lerpResult45_g59567 = lerp( tex2D( _UdonLightmap, UV12_g59567 ) , tex2D( _UdonLightmap, UV02_g59567 ) , W02_g59567);
					float4 lerpResult44_g59567 = lerp( lerpResult46_g59567 , lerpResult45_g59567 , W12_g59567);
					float4 Output_2D_Auto131_g59567 = lerpResult44_g59567;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g1 = Output_2D_Auto131_g59567;
					#else
					float4 staticSwitch1092_g1 = float4( tex2D( _UdonLightmap, UV_Lightmap2361_g1 ).rgb , 0.0 );
					#endif
					float4 Lightmap_0925_g1 = staticSwitch1092_g1;
					float localBicubicPrepare2_g59430 = ( 0.0 );
					float2 Input_UV100_g59430 = UV_Lightmap2361_g1;
					float2 UV2_g59430 = Input_UV100_g59430;
					float4 TexelSize2_g59430 = _Lightmap1_TexelSize;
					float2 UV02_g59430 = float2( 0,0 );
					float2 UV12_g59430 = float2( 0,0 );
					float2 UV22_g59430 = float2( 0,0 );
					float2 UV32_g59430 = float2( 0,0 );
					float W02_g59430 = 0;
					float W12_g59430 = 0;
					{
					{
					 UV2_g59430 = UV2_g59430 * TexelSize2_g59430.zw - 0.5;
					    float2 f = frac( UV2_g59430 );
					    UV2_g59430 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g59430.x - 0.5, UV2_g59430.x + 1.5, UV2_g59430.y - 0.5, UV2_g59430.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g59430.xyxy;
					    UV02_g59430 = off.xz;
					    UV12_g59430 = off.yz;
					    UV22_g59430 = off.xw;
					    UV32_g59430 = off.yw;
					    W02_g59430 = s.x / ( s.x + s.y );
					 W12_g59430 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g59430 = lerp( tex2D( _Lightmap1, UV32_g59430 ) , tex2D( _Lightmap1, UV22_g59430 ) , W02_g59430);
					float4 lerpResult45_g59430 = lerp( tex2D( _Lightmap1, UV12_g59430 ) , tex2D( _Lightmap1, UV02_g59430 ) , W02_g59430);
					float4 lerpResult44_g59430 = lerp( lerpResult46_g59430 , lerpResult45_g59430 , W12_g59430);
					float4 Output_2D_Auto131_g59430 = lerpResult44_g59430;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g1 = Output_2D_Auto131_g59430;
					#else
					float4 staticSwitch1088_g1 = tex2D( _Lightmap1, UV_Lightmap2361_g1 );
					#endif
					float4 Lightmap_1956_g1 = staticSwitch1088_g1;
					float Lightmap_Lerp_Value969_g1 = _UdonLightmapLerp;
					float4 lerpResult442_g1 = lerp( Lightmap_0925_g1 , Lightmap_1956_g1 , Lightmap_Lerp_Value969_g1);
					float4 Lightmap_Lerp932_g1 = lerpResult442_g1;
					float3 appendResult139_g59999 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 Normal_Map318_g59999 = Normal700_g1;
					float dotResult121_g59999 = dot( appendResult139_g59999 , Normal_Map318_g59999 );
					float temp_output_2_0_g60001 = saturate( dotResult121_g59999 );
					float4 tex2DNode1068_g1 = tex2D( _UdonRNMX0, UV_Lightmap2361_g1 );
					float localStochasticTiling2_g60020 = ( 0.0 );
					float2 UV2_g60020 = UV_Lightmap2361_g1;
					float4 TexelSize2_g60020 = _UdonRNMX0_TexelSize;
					float4 Offsets2_g60020 = float4( 0,0,0,0 );
					float2 Weights2_g60020 = float2( 0,0 );
					{
					UV2_g60020 = UV2_g60020 * TexelSize2_g60020.zw - 0.5;
					float2 f = frac( UV2_g60020 );
					UV2_g60020 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g60020.x - 0.5, UV2_g60020.x + 1.5, UV2_g60020.y - 0.5, UV2_g60020.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g60020 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60020.xyxy;
					Weights2_g60020 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g60019 = Offsets2_g60020;
					float4 Input_FetchOffsets197_g60021 = temp_output_1_34_g60019;
					float2 temp_output_1_54_g60019 = Weights2_g60020;
					float2 Input_FetchWeights200_g60021 = temp_output_1_54_g60019;
					float2 break187_g60021 = Input_FetchWeights200_g60021;
					float4 lerpResult181_g60021 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60021).yw ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60021).xw ) , break187_g60021.x);
					float4 lerpResult182_g60021 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60021).yz ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60021).xz ) , break187_g60021.x);
					float4 lerpResult176_g60021 = lerp( lerpResult181_g60021 , lerpResult182_g60021 , break187_g60021.y);
					float4 Output_Fetch2D_Auto202_g60021 = lerpResult176_g60021;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g1 = Output_Fetch2D_Auto202_g60021;
					#else
					float4 staticSwitch1061_g1 = tex2DNode1068_g1;
					#endif
					float3 appendResult146_g59999 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59999 = dot( appendResult146_g59999 , Normal_Map318_g59999 );
					float temp_output_2_0_g60000 = saturate( dotResult122_g59999 );
					float4 tex2DNode1069_g1 = tex2D( _UdonRNMY0, UV_Lightmap2361_g1 );
					float4 Input_FetchOffsets197_g60022 = temp_output_1_34_g60019;
					float2 Input_FetchWeights200_g60022 = temp_output_1_54_g60019;
					float2 break187_g60022 = Input_FetchWeights200_g60022;
					float4 lerpResult181_g60022 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60022).yw ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60022).xw ) , break187_g60022.x);
					float4 lerpResult182_g60022 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60022).yz ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60022).xz ) , break187_g60022.x);
					float4 lerpResult176_g60022 = lerp( lerpResult181_g60022 , lerpResult182_g60022 , break187_g60022.y);
					float4 Output_Fetch2D_Auto202_g60022 = lerpResult176_g60022;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g1 = Output_Fetch2D_Auto202_g60022;
					#else
					float4 staticSwitch1062_g1 = tex2DNode1069_g1;
					#endif
					float3 appendResult149_g59999 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59999 = dot( appendResult149_g59999 , Normal_Map318_g59999 );
					float temp_output_2_0_g60002 = saturate( dotResult120_g59999 );
					float4 tex2DNode1071_g1 = tex2D( _UdonRNMZ0, UV_Lightmap2361_g1 );
					float4 Input_FetchOffsets197_g60023 = temp_output_1_34_g60019;
					float2 Input_FetchWeights200_g60023 = temp_output_1_54_g60019;
					float2 break187_g60023 = Input_FetchWeights200_g60023;
					float4 lerpResult181_g60023 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60023).yw ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60023).xw ) , break187_g60023.x);
					float4 lerpResult182_g60023 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60023).yz ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60023).xz ) , break187_g60023.x);
					float4 lerpResult176_g60023 = lerp( lerpResult181_g60023 , lerpResult182_g60023 , break187_g60023.y);
					float4 Output_Fetch2D_Auto202_g60023 = lerpResult176_g60023;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g1 = Output_Fetch2D_Auto202_g60023;
					#else
					float4 staticSwitch1063_g1 = tex2DNode1071_g1;
					#endif
					float4 RNM_0926_g1 = ( ( ( ( ( temp_output_2_0_g60001 * temp_output_2_0_g60001 ) * staticSwitch1061_g1 ) + ( ( temp_output_2_0_g60000 * temp_output_2_0_g60000 ) * staticSwitch1062_g1 ) ) + ( ( temp_output_2_0_g60002 * temp_output_2_0_g60002 ) * staticSwitch1063_g1 ) ) * 1.2 );
					float3 appendResult139_g59963 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 Normal_Map318_g59963 = Normal700_g1;
					float dotResult121_g59963 = dot( appendResult139_g59963 , Normal_Map318_g59963 );
					float temp_output_2_0_g59965 = saturate( dotResult121_g59963 );
					float localStochasticTiling2_g60015 = ( 0.0 );
					float2 UV2_g60015 = UV_Lightmap2361_g1;
					float4 TexelSize2_g60015 = _UdonRNMX1_TexelSize;
					float4 Offsets2_g60015 = float4( 0,0,0,0 );
					float2 Weights2_g60015 = float2( 0,0 );
					{
					UV2_g60015 = UV2_g60015 * TexelSize2_g60015.zw - 0.5;
					float2 f = frac( UV2_g60015 );
					UV2_g60015 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g60015.x - 0.5, UV2_g60015.x + 1.5, UV2_g60015.y - 0.5, UV2_g60015.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g60015 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60015.xyxy;
					Weights2_g60015 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g60014 = Offsets2_g60015;
					float4 Input_FetchOffsets197_g60016 = temp_output_1_34_g60014;
					float2 temp_output_1_54_g60014 = Weights2_g60015;
					float2 Input_FetchWeights200_g60016 = temp_output_1_54_g60014;
					float2 break187_g60016 = Input_FetchWeights200_g60016;
					float4 lerpResult181_g60016 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60016).yw ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60016).xw ) , break187_g60016.x);
					float4 lerpResult182_g60016 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60016).yz ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60016).xz ) , break187_g60016.x);
					float4 lerpResult176_g60016 = lerp( lerpResult181_g60016 , lerpResult182_g60016 , break187_g60016.y);
					float4 Output_Fetch2D_Auto202_g60016 = lerpResult176_g60016;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g1 = Output_Fetch2D_Auto202_g60016;
					#else
					float4 staticSwitch1087_g1 = tex2D( _UdonRNMX1, UV_Lightmap2361_g1 );
					#endif
					float3 appendResult146_g59963 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g59963 = dot( appendResult146_g59963 , Normal_Map318_g59963 );
					float temp_output_2_0_g59964 = saturate( dotResult122_g59963 );
					float4 Input_FetchOffsets197_g60017 = temp_output_1_34_g60014;
					float2 Input_FetchWeights200_g60017 = temp_output_1_54_g60014;
					float2 break187_g60017 = Input_FetchWeights200_g60017;
					float4 lerpResult181_g60017 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60017).yw ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60017).xw ) , break187_g60017.x);
					float4 lerpResult182_g60017 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60017).yz ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60017).xz ) , break187_g60017.x);
					float4 lerpResult176_g60017 = lerp( lerpResult181_g60017 , lerpResult182_g60017 , break187_g60017.y);
					float4 Output_Fetch2D_Auto202_g60017 = lerpResult176_g60017;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g1 = Output_Fetch2D_Auto202_g60017;
					#else
					float4 staticSwitch1083_g1 = tex2D( _UdonRNMY1, UV_Lightmap2361_g1 );
					#endif
					float3 appendResult149_g59963 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g59963 = dot( appendResult149_g59963 , Normal_Map318_g59963 );
					float temp_output_2_0_g59966 = saturate( dotResult120_g59963 );
					float4 Input_FetchOffsets197_g60018 = temp_output_1_34_g60014;
					float2 Input_FetchWeights200_g60018 = temp_output_1_54_g60014;
					float2 break187_g60018 = Input_FetchWeights200_g60018;
					float4 lerpResult181_g60018 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60018).yw ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60018).xw ) , break187_g60018.x);
					float4 lerpResult182_g60018 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60018).yz ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60018).xz ) , break187_g60018.x);
					float4 lerpResult176_g60018 = lerp( lerpResult181_g60018 , lerpResult182_g60018 , break187_g60018.y);
					float4 Output_Fetch2D_Auto202_g60018 = lerpResult176_g60018;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g1 = Output_Fetch2D_Auto202_g60018;
					#else
					float4 staticSwitch1084_g1 = tex2D( _UdonRNMZ1, UV_Lightmap2361_g1 );
					#endif
					float4 RNM_11081_g1 = ( ( ( ( ( temp_output_2_0_g59965 * temp_output_2_0_g59965 ) * staticSwitch1087_g1 ) + ( ( temp_output_2_0_g59964 * temp_output_2_0_g59964 ) * staticSwitch1083_g1 ) ) + ( ( temp_output_2_0_g59966 * temp_output_2_0_g59966 ) * staticSwitch1084_g1 ) ) * 1.2 );
					float4 lerpResult953_g1 = lerp( RNM_0926_g1 , RNM_11081_g1 , Lightmap_Lerp_Value969_g1);
					float4 RNM_Lerp950_g1 = lerpResult953_g1;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g1 = temp_cast_1;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g1 = Lightmap_0925_g1;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g1 = Lightmap_Lerp932_g1;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g1 = RNM_0926_g1;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g1 = RNM_Lerp950_g1;
					#else
					float4 staticSwitch1014_g1 = temp_cast_1;
					#endif
					float3 Lightmap46_g1 = (staticSwitch1014_g1).rgb;
					float dotResult9_g60003 = dot( float3( 0.212673, 0.715152, 0.072175 ) , Lightmap46_g1 );
					float smoothstepResult14_g60003 = smoothstep( 0.0 , 0.1 , dotResult9_g60003);
					float Indirect_Lightmap_Mask3118_g1 = smoothstepResult14_g60003;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float staticSwitch3145_g1 = White38_g1;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float staticSwitch3145_g1 = Indirect_Lightmap_Mask3118_g1;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float staticSwitch3145_g1 = Indirect_Lightmap_Mask3118_g1;
					#elif defined( _LIGHTMAPMODE_RNM )
					float staticSwitch3145_g1 = Indirect_Lightmap_Mask3118_g1;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float staticSwitch3145_g1 = Indirect_Lightmap_Mask3118_g1;
					#else
					float staticSwitch3145_g1 = White38_g1;
					#endif
					float LightmapMask1_g60010 = staticSwitch3145_g1;
					float3 localIndirectSpecular1_g60010 = IndirectSpecular( Color1_g60010 , Metallic1_g60010 , Smoothness1_g60010 , ViewDir1_g60010 , WorldPos1_g60010 , WorldNormal1_g60010 , LightmapMask1_g60010 );
					#ifdef _INDIRECTSPECULARS_ON
					float3 staticSwitch2971_g1 = localIndirectSpecular1_g60010;
					#else
					float3 staticSwitch2971_g1 = temp_cast_0;
					#endif
					float3 Indirect_Speculars1419_g1 = staticSwitch2971_g1;
					float2 temp_output_5_0_g59692 = UV_Diffuse2420_g1;
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
					float2 temp_output_597_0_g59692 = ( UV100_g59693 + Hash22( ifLocalVar87_g59693 ) );
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
					float2 temp_output_597_26_g59692 = ( UV100_g59693 + Hash22( ifLocalVar88_g59693 ) );
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
					float2 temp_output_597_27_g59692 = ( UV100_g59693 + Hash22( ifLocalVar89_g59693 ) );
					float temp_output_67_0_g59693 = ( 1.0 - break55_g59693.x );
					float ifLocalVar61_g59693 = 0;
					if( temp_output_56_0_g59693 <= 0.0 )
					ifLocalVar61_g59693 = temp_output_67_0_g59693;
					else
					ifLocalVar61_g59693 = break55_g59693.x;
					float temp_output_597_29_g59692 = ifLocalVar61_g59693;
					float4 Output_2D293_g59692 = ( ( tex2D( _Sampler82968_g1, temp_output_597_0_g59692, DDX631_g59692, DDY632_g59692 ) * temp_output_597_30_g59692 ) + ( tex2D( _Sampler82968_g1, temp_output_597_26_g59692, DDX631_g59692, DDY632_g59692 ) * temp_output_597_28_g59692 ) + ( tex2D( _Sampler82968_g1, temp_output_597_27_g59692, DDX631_g59692, DDY632_g59692 ) * temp_output_597_29_g59692 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g1 = Output_2D293_g59692;
					#else
					float4 staticSwitch1006_g1 = tex2D( _EmissionMap, UV_Diffuse2420_g1 );
					#endif
					float3 temp_output_2531_0_g1 = (( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g1 * _EmissionIntensity )).rgb;
					float3 Emission86_g1 = temp_output_2531_0_g1;
					float3 temp_output_1463_0_g1 = ( Diffuse2560_g1 + Direct_Speculars3240_g1 + Indirect_Speculars1419_g1 + Emission86_g1 );
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch1181_g1 = Lightmap46_g1;
					#else
					float3 staticSwitch1181_g1 = temp_output_1463_0_g1;
					#endif
					float4 Color357_g60011 = float4( staticSwitch1181_g1 , 0.0 );
					float4 LUT51_g60011 = tex3D( _LUT, ( ( log10( ( ( (Color357_g60011).xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 ) );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch359_g60011 = LUT51_g60011;
					#else
					float4 staticSwitch359_g60011 = Color357_g60011;
					#endif
					

					float3 Color = staticSwitch359_g60011.xyz;
					float Alpha = 1;
					half AlphaClipThreshold = 0.5;
					half AlphaClipThresholdShadow = 0.5;

					#if defined( ASE_WRITE_DEPTH )
						outputDepth = IN.pos.z;
					#endif

					#ifdef _ALPHATEST_ON
						clip( Alpha - AlphaClipThreshold );
					#endif

				#if defined( ASE_SURFACE_TRANSPARENT ) || defined( ASE_OPAQUE_KEEP_ALPHA )
					return half4( Color, Alpha );
				#else
					return half4( Color, 1.0 );
				#endif
				}
			ENDCG
		}

	
	}
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
	
	Fallback Off
}
/*ASEBEGIN
Version=19910
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":6462,"pos":[-64,-1280],"params":["Inherit","False","Meenphie","0","","1","b3ba55a08dd6b49c7be16c6f35cf2033","6,1008,0,2632,0,2635,0,2619,0,2670,0,2636,0","0","3","FLOAT4","624","FLOAT","156","FLOAT","427"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":6275,"pos":[256,-1280],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","7","New Amplify Shader","0770190933193b94aaa3065e307002fa","True","ShadowCaster","0","2","ShadowCaster","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","False","False","False","True","2","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","True","3","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","False","","True","3","False","","False","False","True","1","LightMode=ShadowCaster","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":6274,"pos":[256,-1280],"params":["Float","False","True","-1","3","AmplifyShaderEditor.MaterialInspector","0","7","Meenphie/Standard/Opaque","0770190933193b94aaa3065e307002fa","True","Unlit","0","1","Unlit","8","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","False","False","False","True","2","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","True","3","True","12","all","0","False","True","1","1","False","","0","False","","1","1","False","","0","False","","True","1","False","","1","False","","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","False","True","1","LightMode=ForwardBase","False","False","0","","0","0","Standard","10","Surface","0","0","  Keep Alpha","0","0","  Blend","0","0","Alpha Clipping","0","0","  Use Shadow Threshold","0","0","Cast Shadows","0","639163672731073790","Write Depth","0","0","  Conservative","0","0","Extra Pre Pass","0","0","Vertex Position","1","0","0","3","False","True","False","False","","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":6458,"pos":[256,-1280],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","7","New Amplify Shader","0770190933193b94aaa3065e307002fa","True","ExtraPrePass","0","0","ExtraPrePass","6","False","True","1","1","False","","0","False","","1","1","False","","0","False","","True","1","False","","1","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","False","False","False","True","1","RenderType=Opaque=RenderType","True","3","True","12","all","0","False","True","1","1","False","","0","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","False","True","1","LightMode=ForwardBase","False","False","0","","0","0","Standard","0","False","0"]}
{"wire":[6274,0,6462,624]}
ASEEND*/
//CHKSM=58AC80AD311D3F7290E8DAEA1BFD40A558733B6E