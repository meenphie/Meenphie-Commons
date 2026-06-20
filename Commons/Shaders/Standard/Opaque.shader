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
				sampler2D _Sampler82966_g60213;
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				sampler2D _Sampler82967_g60213;
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				sampler2D _Sampler82964_g60213;
				uniform sampler2D _BumpMap;
				sampler2D _Sampler82965_g60213;
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
				sampler2D _Sampler82968_g60213;
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

					float2 texCoord2357_g60213 = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
					float2 UV_Diffuse2420_g60213 = texCoord2357_g60213;
					float2 temp_output_5_0_g60220 = UV_Diffuse2420_g60213;
					float2 UV633_g60220 = temp_output_5_0_g60220;
					float2 UV100_g60221 = UV633_g60220;
					float2 temp_output_51_0_g60221 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60221 * float2( 3.464,3.464 ) ) );
					float2 break55_g60221 = frac( temp_output_51_0_g60221 );
					float temp_output_56_0_g60221 = ( ( 1.0 - break55_g60221.x ) - break55_g60221.y );
					float2 temp_output_52_0_g60221 = floor( temp_output_51_0_g60221 );
					float2 temp_output_125_0_g60221 = ( temp_output_52_0_g60221 + float2( 1,1 ) );
					float2 ifLocalVar87_g60221 = 0;
					if( temp_output_56_0_g60221 > 0.0 )
					ifLocalVar87_g60221 = temp_output_52_0_g60221;
					else if( temp_output_56_0_g60221 == 0.0 )
					ifLocalVar87_g60221 = temp_output_125_0_g60221;
					else if( temp_output_56_0_g60221 < 0.0 )
					ifLocalVar87_g60221 = temp_output_125_0_g60221;
					float2 temp_output_597_0_g60220 = ( UV100_g60221 + Hash22( ifLocalVar87_g60221 ) );
					float2 DDX631_g60220 = ddx( temp_output_5_0_g60220 );
					float2 DDY632_g60220 = ddy( temp_output_5_0_g60220 );
					float temp_output_65_0_g60221 = ( 0.0 - temp_output_56_0_g60221 );
					float ifLocalVar59_g60221 = 0;
					if( temp_output_56_0_g60221 <= 0.0 )
					ifLocalVar59_g60221 = temp_output_65_0_g60221;
					else
					ifLocalVar59_g60221 = temp_output_56_0_g60221;
					float temp_output_597_30_g60220 = ifLocalVar59_g60221;
					float2 temp_output_90_0_g60221 = ( temp_output_52_0_g60221 + float2( 0,1 ) );
					float2 temp_output_123_0_g60221 = ( temp_output_52_0_g60221 + float2( 1,0 ) );
					float2 ifLocalVar88_g60221 = 0;
					if( temp_output_56_0_g60221 > 0.0 )
					ifLocalVar88_g60221 = temp_output_90_0_g60221;
					else if( temp_output_56_0_g60221 == 0.0 )
					ifLocalVar88_g60221 = temp_output_123_0_g60221;
					else if( temp_output_56_0_g60221 < 0.0 )
					ifLocalVar88_g60221 = temp_output_123_0_g60221;
					float2 temp_output_597_26_g60220 = ( UV100_g60221 + Hash22( ifLocalVar88_g60221 ) );
					float temp_output_66_0_g60221 = ( 1.0 - break55_g60221.y );
					float ifLocalVar60_g60221 = 0;
					if( temp_output_56_0_g60221 <= 0.0 )
					ifLocalVar60_g60221 = temp_output_66_0_g60221;
					else
					ifLocalVar60_g60221 = break55_g60221.y;
					float temp_output_597_28_g60220 = ifLocalVar60_g60221;
					float2 ifLocalVar89_g60221 = 0;
					if( temp_output_56_0_g60221 > 0.0 )
					ifLocalVar89_g60221 = temp_output_123_0_g60221;
					else if( temp_output_56_0_g60221 == 0.0 )
					ifLocalVar89_g60221 = temp_output_90_0_g60221;
					else if( temp_output_56_0_g60221 < 0.0 )
					ifLocalVar89_g60221 = temp_output_90_0_g60221;
					float2 temp_output_597_27_g60220 = ( UV100_g60221 + Hash22( ifLocalVar89_g60221 ) );
					float temp_output_67_0_g60221 = ( 1.0 - break55_g60221.x );
					float ifLocalVar61_g60221 = 0;
					if( temp_output_56_0_g60221 <= 0.0 )
					ifLocalVar61_g60221 = temp_output_67_0_g60221;
					else
					ifLocalVar61_g60221 = break55_g60221.x;
					float temp_output_597_29_g60220 = ifLocalVar61_g60221;
					float4 Output_2D293_g60220 = ( ( tex2D( _Sampler82966_g60213, temp_output_597_0_g60220, DDX631_g60220, DDY632_g60220 ) * temp_output_597_30_g60220 ) + ( tex2D( _Sampler82966_g60213, temp_output_597_26_g60220, DDX631_g60220, DDY632_g60220 ) * temp_output_597_28_g60220 ) + ( tex2D( _Sampler82966_g60213, temp_output_597_27_g60220, DDX631_g60220, DDY632_g60220 ) * temp_output_597_29_g60220 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g60213 = Output_2D293_g60220;
					#else
					float4 staticSwitch1001_g60213 = ( _Color * tex2D( _MainTex, UV_Diffuse2420_g60213 ) );
					#endif
					float3 temp_output_2532_0_g60213 = (staticSwitch1001_g60213).rgb;
					float3 oAlbedo6_g60213 = temp_output_2532_0_g60213;
					float3 Color97_g60253 = oAlbedo6_g60213;
					#ifdef _METALLICMAP
					float staticSwitch846_g60213 = tex2D( _MetallicMap, UV_Diffuse2420_g60213 ).r;
					#else
					float staticSwitch846_g60213 = _Metallic;
					#endif
					float2 temp_output_5_0_g60226 = UV_Diffuse2420_g60213;
					float2 UV633_g60226 = temp_output_5_0_g60226;
					float2 UV100_g60227 = UV633_g60226;
					float2 temp_output_51_0_g60227 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60227 * float2( 3.464,3.464 ) ) );
					float2 break55_g60227 = frac( temp_output_51_0_g60227 );
					float temp_output_56_0_g60227 = ( ( 1.0 - break55_g60227.x ) - break55_g60227.y );
					float2 temp_output_52_0_g60227 = floor( temp_output_51_0_g60227 );
					float2 temp_output_125_0_g60227 = ( temp_output_52_0_g60227 + float2( 1,1 ) );
					float2 ifLocalVar87_g60227 = 0;
					if( temp_output_56_0_g60227 > 0.0 )
					ifLocalVar87_g60227 = temp_output_52_0_g60227;
					else if( temp_output_56_0_g60227 == 0.0 )
					ifLocalVar87_g60227 = temp_output_125_0_g60227;
					else if( temp_output_56_0_g60227 < 0.0 )
					ifLocalVar87_g60227 = temp_output_125_0_g60227;
					float2 temp_output_597_0_g60226 = ( UV100_g60227 + Hash22( ifLocalVar87_g60227 ) );
					float2 DDX631_g60226 = ddx( temp_output_5_0_g60226 );
					float2 DDY632_g60226 = ddy( temp_output_5_0_g60226 );
					float temp_output_65_0_g60227 = ( 0.0 - temp_output_56_0_g60227 );
					float ifLocalVar59_g60227 = 0;
					if( temp_output_56_0_g60227 <= 0.0 )
					ifLocalVar59_g60227 = temp_output_65_0_g60227;
					else
					ifLocalVar59_g60227 = temp_output_56_0_g60227;
					float temp_output_597_30_g60226 = ifLocalVar59_g60227;
					float2 temp_output_90_0_g60227 = ( temp_output_52_0_g60227 + float2( 0,1 ) );
					float2 temp_output_123_0_g60227 = ( temp_output_52_0_g60227 + float2( 1,0 ) );
					float2 ifLocalVar88_g60227 = 0;
					if( temp_output_56_0_g60227 > 0.0 )
					ifLocalVar88_g60227 = temp_output_90_0_g60227;
					else if( temp_output_56_0_g60227 == 0.0 )
					ifLocalVar88_g60227 = temp_output_123_0_g60227;
					else if( temp_output_56_0_g60227 < 0.0 )
					ifLocalVar88_g60227 = temp_output_123_0_g60227;
					float2 temp_output_597_26_g60226 = ( UV100_g60227 + Hash22( ifLocalVar88_g60227 ) );
					float temp_output_66_0_g60227 = ( 1.0 - break55_g60227.y );
					float ifLocalVar60_g60227 = 0;
					if( temp_output_56_0_g60227 <= 0.0 )
					ifLocalVar60_g60227 = temp_output_66_0_g60227;
					else
					ifLocalVar60_g60227 = break55_g60227.y;
					float temp_output_597_28_g60226 = ifLocalVar60_g60227;
					float2 ifLocalVar89_g60227 = 0;
					if( temp_output_56_0_g60227 > 0.0 )
					ifLocalVar89_g60227 = temp_output_123_0_g60227;
					else if( temp_output_56_0_g60227 == 0.0 )
					ifLocalVar89_g60227 = temp_output_90_0_g60227;
					else if( temp_output_56_0_g60227 < 0.0 )
					ifLocalVar89_g60227 = temp_output_90_0_g60227;
					float2 temp_output_597_27_g60226 = ( UV100_g60227 + Hash22( ifLocalVar89_g60227 ) );
					float temp_output_67_0_g60227 = ( 1.0 - break55_g60227.x );
					float ifLocalVar61_g60227 = 0;
					if( temp_output_56_0_g60227 <= 0.0 )
					ifLocalVar61_g60227 = temp_output_67_0_g60227;
					else
					ifLocalVar61_g60227 = break55_g60227.x;
					float temp_output_597_29_g60226 = ifLocalVar61_g60227;
					float4 Output_2D293_g60226 = ( ( tex2D( _Sampler82967_g60213, temp_output_597_0_g60226, DDX631_g60226, DDY632_g60226 ) * temp_output_597_30_g60226 ) + ( tex2D( _Sampler82967_g60213, temp_output_597_26_g60226, DDX631_g60226, DDY632_g60226 ) * temp_output_597_28_g60226 ) + ( tex2D( _Sampler82967_g60213, temp_output_597_27_g60226, DDX631_g60226, DDY632_g60226 ) * temp_output_597_29_g60226 ) );
					float4 break31_g60226 = Output_2D293_g60226;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g60213 = break31_g60226.r;
					#else
					float staticSwitch1005_g60213 = staticSwitch846_g60213;
					#endif
					float Metallic1239_g60213 = staticSwitch1005_g60213;
					float Metallic97_g60253 = Metallic1239_g60213;
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g60213 = tex2D( _GlossinessMap, UV_Diffuse2420_g60213 ).r;
					#else
					float staticSwitch845_g60213 = _Glossiness;
					#endif
					float2 temp_output_5_0_g60222 = UV_Diffuse2420_g60213;
					float2 UV633_g60222 = temp_output_5_0_g60222;
					float2 UV100_g60223 = UV633_g60222;
					float2 temp_output_51_0_g60223 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60223 * float2( 3.464,3.464 ) ) );
					float2 break55_g60223 = frac( temp_output_51_0_g60223 );
					float temp_output_56_0_g60223 = ( ( 1.0 - break55_g60223.x ) - break55_g60223.y );
					float2 temp_output_52_0_g60223 = floor( temp_output_51_0_g60223 );
					float2 temp_output_125_0_g60223 = ( temp_output_52_0_g60223 + float2( 1,1 ) );
					float2 ifLocalVar87_g60223 = 0;
					if( temp_output_56_0_g60223 > 0.0 )
					ifLocalVar87_g60223 = temp_output_52_0_g60223;
					else if( temp_output_56_0_g60223 == 0.0 )
					ifLocalVar87_g60223 = temp_output_125_0_g60223;
					else if( temp_output_56_0_g60223 < 0.0 )
					ifLocalVar87_g60223 = temp_output_125_0_g60223;
					float2 temp_output_597_0_g60222 = ( UV100_g60223 + Hash22( ifLocalVar87_g60223 ) );
					float2 DDX631_g60222 = ddx( temp_output_5_0_g60222 );
					float2 DDY632_g60222 = ddy( temp_output_5_0_g60222 );
					float temp_output_65_0_g60223 = ( 0.0 - temp_output_56_0_g60223 );
					float ifLocalVar59_g60223 = 0;
					if( temp_output_56_0_g60223 <= 0.0 )
					ifLocalVar59_g60223 = temp_output_65_0_g60223;
					else
					ifLocalVar59_g60223 = temp_output_56_0_g60223;
					float temp_output_597_30_g60222 = ifLocalVar59_g60223;
					float2 temp_output_90_0_g60223 = ( temp_output_52_0_g60223 + float2( 0,1 ) );
					float2 temp_output_123_0_g60223 = ( temp_output_52_0_g60223 + float2( 1,0 ) );
					float2 ifLocalVar88_g60223 = 0;
					if( temp_output_56_0_g60223 > 0.0 )
					ifLocalVar88_g60223 = temp_output_90_0_g60223;
					else if( temp_output_56_0_g60223 == 0.0 )
					ifLocalVar88_g60223 = temp_output_123_0_g60223;
					else if( temp_output_56_0_g60223 < 0.0 )
					ifLocalVar88_g60223 = temp_output_123_0_g60223;
					float2 temp_output_597_26_g60222 = ( UV100_g60223 + Hash22( ifLocalVar88_g60223 ) );
					float temp_output_66_0_g60223 = ( 1.0 - break55_g60223.y );
					float ifLocalVar60_g60223 = 0;
					if( temp_output_56_0_g60223 <= 0.0 )
					ifLocalVar60_g60223 = temp_output_66_0_g60223;
					else
					ifLocalVar60_g60223 = break55_g60223.y;
					float temp_output_597_28_g60222 = ifLocalVar60_g60223;
					float2 ifLocalVar89_g60223 = 0;
					if( temp_output_56_0_g60223 > 0.0 )
					ifLocalVar89_g60223 = temp_output_123_0_g60223;
					else if( temp_output_56_0_g60223 == 0.0 )
					ifLocalVar89_g60223 = temp_output_90_0_g60223;
					else if( temp_output_56_0_g60223 < 0.0 )
					ifLocalVar89_g60223 = temp_output_90_0_g60223;
					float2 temp_output_597_27_g60222 = ( UV100_g60223 + Hash22( ifLocalVar89_g60223 ) );
					float temp_output_67_0_g60223 = ( 1.0 - break55_g60223.x );
					float ifLocalVar61_g60223 = 0;
					if( temp_output_56_0_g60223 <= 0.0 )
					ifLocalVar61_g60223 = temp_output_67_0_g60223;
					else
					ifLocalVar61_g60223 = break55_g60223.x;
					float temp_output_597_29_g60222 = ifLocalVar61_g60223;
					float4 Output_2D293_g60222 = ( ( tex2D( _Sampler82964_g60213, temp_output_597_0_g60222, DDX631_g60222, DDY632_g60222 ) * temp_output_597_30_g60222 ) + ( tex2D( _Sampler82964_g60213, temp_output_597_26_g60222, DDX631_g60222, DDY632_g60222 ) * temp_output_597_28_g60222 ) + ( tex2D( _Sampler82964_g60213, temp_output_597_27_g60222, DDX631_g60222, DDY632_g60222 ) * temp_output_597_29_g60222 ) );
					float4 break31_g60222 = Output_2D293_g60222;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g60213 = ( 1.0 - break31_g60222.r );
					#else
					float staticSwitch1004_g60213 = ( 1.0 - staticSwitch845_g60213 );
					#endif
					float temp_output_19_0_g60239 = staticSwitch1004_g60213;
					float2 temp_output_5_0_g60218 = UV_Diffuse2420_g60213;
					float2 UV633_g60218 = temp_output_5_0_g60218;
					float2 UV100_g60219 = UV633_g60218;
					float2 temp_output_51_0_g60219 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60219 * float2( 3.464,3.464 ) ) );
					float2 break55_g60219 = frac( temp_output_51_0_g60219 );
					float temp_output_56_0_g60219 = ( ( 1.0 - break55_g60219.x ) - break55_g60219.y );
					float2 temp_output_52_0_g60219 = floor( temp_output_51_0_g60219 );
					float2 temp_output_125_0_g60219 = ( temp_output_52_0_g60219 + float2( 1,1 ) );
					float2 ifLocalVar87_g60219 = 0;
					if( temp_output_56_0_g60219 > 0.0 )
					ifLocalVar87_g60219 = temp_output_52_0_g60219;
					else if( temp_output_56_0_g60219 == 0.0 )
					ifLocalVar87_g60219 = temp_output_125_0_g60219;
					else if( temp_output_56_0_g60219 < 0.0 )
					ifLocalVar87_g60219 = temp_output_125_0_g60219;
					float2 temp_output_597_0_g60218 = ( UV100_g60219 + Hash22( ifLocalVar87_g60219 ) );
					float2 DDX631_g60218 = ddx( temp_output_5_0_g60218 );
					float2 DDY632_g60218 = ddy( temp_output_5_0_g60218 );
					float Input_Scale617_g60218 = 1.5;
					float temp_output_65_0_g60219 = ( 0.0 - temp_output_56_0_g60219 );
					float ifLocalVar59_g60219 = 0;
					if( temp_output_56_0_g60219 <= 0.0 )
					ifLocalVar59_g60219 = temp_output_65_0_g60219;
					else
					ifLocalVar59_g60219 = temp_output_56_0_g60219;
					float temp_output_597_30_g60218 = ifLocalVar59_g60219;
					float2 temp_output_90_0_g60219 = ( temp_output_52_0_g60219 + float2( 0,1 ) );
					float2 temp_output_123_0_g60219 = ( temp_output_52_0_g60219 + float2( 1,0 ) );
					float2 ifLocalVar88_g60219 = 0;
					if( temp_output_56_0_g60219 > 0.0 )
					ifLocalVar88_g60219 = temp_output_90_0_g60219;
					else if( temp_output_56_0_g60219 == 0.0 )
					ifLocalVar88_g60219 = temp_output_123_0_g60219;
					else if( temp_output_56_0_g60219 < 0.0 )
					ifLocalVar88_g60219 = temp_output_123_0_g60219;
					float2 temp_output_597_26_g60218 = ( UV100_g60219 + Hash22( ifLocalVar88_g60219 ) );
					float temp_output_66_0_g60219 = ( 1.0 - break55_g60219.y );
					float ifLocalVar60_g60219 = 0;
					if( temp_output_56_0_g60219 <= 0.0 )
					ifLocalVar60_g60219 = temp_output_66_0_g60219;
					else
					ifLocalVar60_g60219 = break55_g60219.y;
					float temp_output_597_28_g60218 = ifLocalVar60_g60219;
					float2 ifLocalVar89_g60219 = 0;
					if( temp_output_56_0_g60219 > 0.0 )
					ifLocalVar89_g60219 = temp_output_123_0_g60219;
					else if( temp_output_56_0_g60219 == 0.0 )
					ifLocalVar89_g60219 = temp_output_90_0_g60219;
					else if( temp_output_56_0_g60219 < 0.0 )
					ifLocalVar89_g60219 = temp_output_90_0_g60219;
					float2 temp_output_597_27_g60218 = ( UV100_g60219 + Hash22( ifLocalVar89_g60219 ) );
					float temp_output_67_0_g60219 = ( 1.0 - break55_g60219.x );
					float ifLocalVar61_g60219 = 0;
					if( temp_output_56_0_g60219 <= 0.0 )
					ifLocalVar61_g60219 = temp_output_67_0_g60219;
					else
					ifLocalVar61_g60219 = break55_g60219.x;
					float temp_output_597_29_g60218 = ifLocalVar61_g60219;
					float3 Output_2D_Normal641_g60218 = ( ( UnpackScaleNormal( tex2D( _Sampler82965_g60213, temp_output_597_0_g60218, DDX631_g60218, DDY632_g60218 ), Input_Scale617_g60218 ) * temp_output_597_30_g60218 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g60213, temp_output_597_26_g60218, DDX631_g60218, DDY632_g60218 ), Input_Scale617_g60218 ) * temp_output_597_28_g60218 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g60213, temp_output_597_27_g60218, DDX631_g60218, DDY632_g60218 ), Input_Scale617_g60218 ) * float3( 0,0,0 ) * temp_output_597_29_g60218 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g60213 = Output_2D_Normal641_g60218;
					#else
					float3 staticSwitch1003_g60213 = UnpackScaleNormal( tex2D( _BumpMap, UV_Diffuse2420_g60213 ), 1.5 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g60213 = staticSwitch1003_g60213;
					#else
					float3 staticSwitch980_g60213 = float3( 0, 0, 1 );
					#endif
					float3 normalizeResult2878_g60213 = normalize( staticSwitch980_g60213 );
					float3 Normal700_g60213 = normalizeResult2878_g60213;
					float3 ase_tangentWS = IN.ase_texcoord1.xyz;
					float3 ase_normalWS = IN.ase_texcoord2.xyz;
					float3 ase_bitangentWS = IN.ase_texcoord3.xyz;
					float3 tanToWorld0 = float3( ase_tangentWS.x, ase_bitangentWS.x, ase_normalWS.x );
					float3 tanToWorld1 = float3( ase_tangentWS.y, ase_bitangentWS.y, ase_normalWS.y );
					float3 tanToWorld2 = float3( ase_tangentWS.z, ase_bitangentWS.z, ase_normalWS.z );
					float3 tanNormal2504_g60213 = Normal700_g60213;
					float3 worldNormal2504_g60213 = normalize( float3( dot( tanToWorld0, tanNormal2504_g60213 ), dot( tanToWorld1, tanNormal2504_g60213 ), dot( tanToWorld2, tanNormal2504_g60213 ) ) );
					float3 World_Normal2508_g60213 = worldNormal2504_g60213;
					float3 tanNormal2_g60239 = World_Normal2508_g60213;
					float3 worldNormal2_g60239 = float3( dot( tanToWorld0, tanNormal2_g60239 ), dot( tanToWorld1, tanNormal2_g60239 ), dot( tanToWorld2, tanNormal2_g60239 ) );
					float3 temp_output_3_0_g60239 = ddx( worldNormal2_g60239 );
					float dotResult5_g60239 = dot( temp_output_3_0_g60239 , temp_output_3_0_g60239 );
					float3 temp_output_4_0_g60239 = ddy( worldNormal2_g60239 );
					float dotResult6_g60239 = dot( temp_output_4_0_g60239 , temp_output_4_0_g60239 );
					#ifdef _USEGEOMETRICAA_ON
					float staticSwitch15_g60239 = min( temp_output_19_0_g60239, ( 1.0 - pow( saturate( max( dotResult5_g60239, dotResult6_g60239 ) ) , 0.25 ) ) );
					#else
					float staticSwitch15_g60239 = temp_output_19_0_g60239;
					#endif
					float Smoothness1399_g60213 = staticSwitch15_g60239;
					float Smoothness97_g60253 = Smoothness1399_g60213;
					float3 ase_positionWS = IN.ase_texcoord4.xyz;
					float3 ase_viewVectorWS = ( ( unity_OrthoParams.w == 0 ) ? _WorldSpaceCameraPos - ase_positionWS : UNITY_MATRIX_V[ 2 ].xyz );
					float3 ase_viewDirWS = normalize( ase_viewVectorWS );
					float3 View_Direction2511_g60213 = ase_viewDirWS;
					float3 ViewDir97_g60253 = View_Direction2511_g60213;
					float3 World_Position2505_g60213 = ase_positionWS;
					float3 WorldPos97_g60253 = World_Position2505_g60213;
					float3 WorldNormal97_g60253 = World_Normal2508_g60213;
					float3 Vertex_Normal3161_g60213 = IN.ase_normal;
					float3 VertexNormal97_g60253 = Vertex_Normal3161_g60213;
					float4 texCoord2426_g60213 = IN.ase_texcoord;
					texCoord2426_g60213.xy = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
					float2 UV_Lightmap2361_g60213 = (texCoord2426_g60213).zw;
					float2 LightmapUV97_g60253 = UV_Lightmap2361_g60213;
					float3 Diffuse97_g60253 = float3( 0,0,0 );
					float3 Specular97_g60253 = float3( 0,0,0 );
					float3 localDirectSpecular97_g60253 = DirectSpecular( Color97_g60253 , Metallic97_g60253 , Smoothness97_g60253 , ViewDir97_g60253 , WorldPos97_g60253 , WorldNormal97_g60253 , VertexNormal97_g60253 , LightmapUV97_g60253 , Diffuse97_g60253 , Specular97_g60253 );
					float3 Diffuse2560_g60213 = Diffuse97_g60253;
					float3 Direct_Speculars3240_g60213 = Specular97_g60253;
					float Black1185_g60213 = 0.0;
					float3 temp_cast_0 = (Black1185_g60213).xxx;
					float3 Color1_g60240 = oAlbedo6_g60213;
					float Metallic1_g60240 = Metallic1239_g60213;
					float Smoothness1_g60240 = Smoothness1399_g60213;
					float3 ViewDir1_g60240 = View_Direction2511_g60213;
					float3 WorldPos1_g60240 = World_Position2505_g60213;
					float3 WorldNormal1_g60240 = World_Normal2508_g60213;
					float White38_g60213 = 1.0;
					float4 temp_cast_1 = (Black1185_g60213).xxxx;
					float localBicubicPrepare2_g60217 = ( 0.0 );
					float2 Input_UV100_g60217 = UV_Lightmap2361_g60213;
					float2 UV2_g60217 = Input_UV100_g60217;
					float4 TexelSize2_g60217 = _UdonLightmap_TexelSize;
					float2 UV02_g60217 = float2( 0,0 );
					float2 UV12_g60217 = float2( 0,0 );
					float2 UV22_g60217 = float2( 0,0 );
					float2 UV32_g60217 = float2( 0,0 );
					float W02_g60217 = 0;
					float W12_g60217 = 0;
					{
					{
					 UV2_g60217 = UV2_g60217 * TexelSize2_g60217.zw - 0.5;
					    float2 f = frac( UV2_g60217 );
					    UV2_g60217 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g60217.x - 0.5, UV2_g60217.x + 1.5, UV2_g60217.y - 0.5, UV2_g60217.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60217.xyxy;
					    UV02_g60217 = off.xz;
					    UV12_g60217 = off.yz;
					    UV22_g60217 = off.xw;
					    UV32_g60217 = off.yw;
					    W02_g60217 = s.x / ( s.x + s.y );
					 W12_g60217 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g60217 = lerp( tex2D( _UdonLightmap, UV32_g60217 ) , tex2D( _UdonLightmap, UV22_g60217 ) , W02_g60217);
					float4 lerpResult45_g60217 = lerp( tex2D( _UdonLightmap, UV12_g60217 ) , tex2D( _UdonLightmap, UV02_g60217 ) , W02_g60217);
					float4 lerpResult44_g60217 = lerp( lerpResult46_g60217 , lerpResult45_g60217 , W12_g60217);
					float4 Output_2D_Auto131_g60217 = lerpResult44_g60217;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1092_g60213 = Output_2D_Auto131_g60217;
					#else
					float4 staticSwitch1092_g60213 = float4( tex2D( _UdonLightmap, UV_Lightmap2361_g60213 ).rgb , 0.0 );
					#endif
					float4 Lightmap_0925_g60213 = staticSwitch1092_g60213;
					float localBicubicPrepare2_g60215 = ( 0.0 );
					float2 Input_UV100_g60215 = UV_Lightmap2361_g60213;
					float2 UV2_g60215 = Input_UV100_g60215;
					float4 TexelSize2_g60215 = _Lightmap1_TexelSize;
					float2 UV02_g60215 = float2( 0,0 );
					float2 UV12_g60215 = float2( 0,0 );
					float2 UV22_g60215 = float2( 0,0 );
					float2 UV32_g60215 = float2( 0,0 );
					float W02_g60215 = 0;
					float W12_g60215 = 0;
					{
					{
					 UV2_g60215 = UV2_g60215 * TexelSize2_g60215.zw - 0.5;
					    float2 f = frac( UV2_g60215 );
					    UV2_g60215 -= f;
					    float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					    float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					    float4 xs = xn * xn * xn;
					    float4 ys = yn * yn * yn;
					    float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					    float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					    float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					 float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					    float4 c = float4( UV2_g60215.x - 0.5, UV2_g60215.x + 1.5, UV2_g60215.y - 0.5, UV2_g60215.y + 1.5 );
					    float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					    float4 off = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60215.xyxy;
					    UV02_g60215 = off.xz;
					    UV12_g60215 = off.yz;
					    UV22_g60215 = off.xw;
					    UV32_g60215 = off.yw;
					    W02_g60215 = s.x / ( s.x + s.y );
					 W12_g60215 = s.z / ( s.z + s.w );
					}
					}
					float4 lerpResult46_g60215 = lerp( tex2D( _Lightmap1, UV32_g60215 ) , tex2D( _Lightmap1, UV22_g60215 ) , W02_g60215);
					float4 lerpResult45_g60215 = lerp( tex2D( _Lightmap1, UV12_g60215 ) , tex2D( _Lightmap1, UV02_g60215 ) , W02_g60215);
					float4 lerpResult44_g60215 = lerp( lerpResult46_g60215 , lerpResult45_g60215 , W12_g60215);
					float4 Output_2D_Auto131_g60215 = lerpResult44_g60215;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1088_g60213 = Output_2D_Auto131_g60215;
					#else
					float4 staticSwitch1088_g60213 = tex2D( _Lightmap1, UV_Lightmap2361_g60213 );
					#endif
					float4 Lightmap_1956_g60213 = staticSwitch1088_g60213;
					float Lightmap_Lerp_Value969_g60213 = _UdonLightmapLerp;
					float4 lerpResult442_g60213 = lerp( Lightmap_0925_g60213 , Lightmap_1956_g60213 , Lightmap_Lerp_Value969_g60213);
					float4 Lightmap_Lerp932_g60213 = lerpResult442_g60213;
					float3 appendResult139_g60233 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 Normal_Map318_g60233 = Normal700_g60213;
					float dotResult121_g60233 = dot( appendResult139_g60233 , Normal_Map318_g60233 );
					float temp_output_2_0_g60235 = saturate( dotResult121_g60233 );
					float4 tex2DNode1068_g60213 = tex2D( _UdonRNMX0, UV_Lightmap2361_g60213 );
					float localStochasticTiling2_g60249 = ( 0.0 );
					float2 UV2_g60249 = UV_Lightmap2361_g60213;
					float4 TexelSize2_g60249 = _UdonRNMX0_TexelSize;
					float4 Offsets2_g60249 = float4( 0,0,0,0 );
					float2 Weights2_g60249 = float2( 0,0 );
					{
					UV2_g60249 = UV2_g60249 * TexelSize2_g60249.zw - 0.5;
					float2 f = frac( UV2_g60249 );
					UV2_g60249 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g60249.x - 0.5, UV2_g60249.x + 1.5, UV2_g60249.y - 0.5, UV2_g60249.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g60249 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60249.xyxy;
					Weights2_g60249 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g60248 = Offsets2_g60249;
					float4 Input_FetchOffsets197_g60250 = temp_output_1_34_g60248;
					float2 temp_output_1_54_g60248 = Weights2_g60249;
					float2 Input_FetchWeights200_g60250 = temp_output_1_54_g60248;
					float2 break187_g60250 = Input_FetchWeights200_g60250;
					float4 lerpResult181_g60250 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60250).yw ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60250).xw ) , break187_g60250.x);
					float4 lerpResult182_g60250 = lerp( tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60250).yz ) , tex2D( _UdonRNMX0, (Input_FetchOffsets197_g60250).xz ) , break187_g60250.x);
					float4 lerpResult176_g60250 = lerp( lerpResult181_g60250 , lerpResult182_g60250 , break187_g60250.y);
					float4 Output_Fetch2D_Auto202_g60250 = lerpResult176_g60250;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1061_g60213 = Output_Fetch2D_Auto202_g60250;
					#else
					float4 staticSwitch1061_g60213 = tex2DNode1068_g60213;
					#endif
					float3 appendResult146_g60233 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g60233 = dot( appendResult146_g60233 , Normal_Map318_g60233 );
					float temp_output_2_0_g60234 = saturate( dotResult122_g60233 );
					float4 tex2DNode1069_g60213 = tex2D( _UdonRNMY0, UV_Lightmap2361_g60213 );
					float4 Input_FetchOffsets197_g60251 = temp_output_1_34_g60248;
					float2 Input_FetchWeights200_g60251 = temp_output_1_54_g60248;
					float2 break187_g60251 = Input_FetchWeights200_g60251;
					float4 lerpResult181_g60251 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60251).yw ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60251).xw ) , break187_g60251.x);
					float4 lerpResult182_g60251 = lerp( tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60251).yz ) , tex2D( _UdonRNMY0, (Input_FetchOffsets197_g60251).xz ) , break187_g60251.x);
					float4 lerpResult176_g60251 = lerp( lerpResult181_g60251 , lerpResult182_g60251 , break187_g60251.y);
					float4 Output_Fetch2D_Auto202_g60251 = lerpResult176_g60251;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1062_g60213 = Output_Fetch2D_Auto202_g60251;
					#else
					float4 staticSwitch1062_g60213 = tex2DNode1069_g60213;
					#endif
					float3 appendResult149_g60233 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g60233 = dot( appendResult149_g60233 , Normal_Map318_g60233 );
					float temp_output_2_0_g60236 = saturate( dotResult120_g60233 );
					float4 tex2DNode1071_g60213 = tex2D( _UdonRNMZ0, UV_Lightmap2361_g60213 );
					float4 Input_FetchOffsets197_g60252 = temp_output_1_34_g60248;
					float2 Input_FetchWeights200_g60252 = temp_output_1_54_g60248;
					float2 break187_g60252 = Input_FetchWeights200_g60252;
					float4 lerpResult181_g60252 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60252).yw ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60252).xw ) , break187_g60252.x);
					float4 lerpResult182_g60252 = lerp( tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60252).yz ) , tex2D( _UdonRNMZ0, (Input_FetchOffsets197_g60252).xz ) , break187_g60252.x);
					float4 lerpResult176_g60252 = lerp( lerpResult181_g60252 , lerpResult182_g60252 , break187_g60252.y);
					float4 Output_Fetch2D_Auto202_g60252 = lerpResult176_g60252;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1063_g60213 = Output_Fetch2D_Auto202_g60252;
					#else
					float4 staticSwitch1063_g60213 = tex2DNode1071_g60213;
					#endif
					float4 RNM_0926_g60213 = ( ( ( ( ( temp_output_2_0_g60235 * temp_output_2_0_g60235 ) * staticSwitch1061_g60213 ) + ( ( temp_output_2_0_g60234 * temp_output_2_0_g60234 ) * staticSwitch1062_g60213 ) ) + ( ( temp_output_2_0_g60236 * temp_output_2_0_g60236 ) * staticSwitch1063_g60213 ) ) * 1.2 );
					float3 appendResult139_g60229 = (float3(sqrt( ( 2.0 / 3.0 ) ) , 0.0 , ( 1.0 / sqrt( 3.0 ) )));
					float3 Normal_Map318_g60229 = Normal700_g60213;
					float dotResult121_g60229 = dot( appendResult139_g60229 , Normal_Map318_g60229 );
					float temp_output_2_0_g60231 = saturate( dotResult121_g60229 );
					float localStochasticTiling2_g60244 = ( 0.0 );
					float2 UV2_g60244 = UV_Lightmap2361_g60213;
					float4 TexelSize2_g60244 = _UdonRNMX1_TexelSize;
					float4 Offsets2_g60244 = float4( 0,0,0,0 );
					float2 Weights2_g60244 = float2( 0,0 );
					{
					UV2_g60244 = UV2_g60244 * TexelSize2_g60244.zw - 0.5;
					float2 f = frac( UV2_g60244 );
					UV2_g60244 -= f;
					float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
					float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
					float4 xs = xn * xn * xn;
					float4 ys = yn * yn * yn;
					float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
					float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
					float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
					float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
					float4 c = float4( UV2_g60244.x - 0.5, UV2_g60244.x + 1.5, UV2_g60244.y - 0.5, UV2_g60244.y + 1.5 );
					float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
					float w0 = s.x / ( s.x + s.y );
					float w1 = s.z / ( s.z + s.w );
					Offsets2_g60244 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize2_g60244.xyxy;
					Weights2_g60244 = float2( w0, w1 );
					}
					float4 temp_output_1_34_g60243 = Offsets2_g60244;
					float4 Input_FetchOffsets197_g60245 = temp_output_1_34_g60243;
					float2 temp_output_1_54_g60243 = Weights2_g60244;
					float2 Input_FetchWeights200_g60245 = temp_output_1_54_g60243;
					float2 break187_g60245 = Input_FetchWeights200_g60245;
					float4 lerpResult181_g60245 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60245).yw ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60245).xw ) , break187_g60245.x);
					float4 lerpResult182_g60245 = lerp( tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60245).yz ) , tex2D( _UdonRNMX1, (Input_FetchOffsets197_g60245).xz ) , break187_g60245.x);
					float4 lerpResult176_g60245 = lerp( lerpResult181_g60245 , lerpResult182_g60245 , break187_g60245.y);
					float4 Output_Fetch2D_Auto202_g60245 = lerpResult176_g60245;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1087_g60213 = Output_Fetch2D_Auto202_g60245;
					#else
					float4 staticSwitch1087_g60213 = tex2D( _UdonRNMX1, UV_Lightmap2361_g60213 );
					#endif
					float3 appendResult146_g60229 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( 1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult122_g60229 = dot( appendResult146_g60229 , Normal_Map318_g60229 );
					float temp_output_2_0_g60230 = saturate( dotResult122_g60229 );
					float4 Input_FetchOffsets197_g60246 = temp_output_1_34_g60243;
					float2 Input_FetchWeights200_g60246 = temp_output_1_54_g60243;
					float2 break187_g60246 = Input_FetchWeights200_g60246;
					float4 lerpResult181_g60246 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60246).yw ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60246).xw ) , break187_g60246.x);
					float4 lerpResult182_g60246 = lerp( tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60246).yz ) , tex2D( _UdonRNMY1, (Input_FetchOffsets197_g60246).xz ) , break187_g60246.x);
					float4 lerpResult176_g60246 = lerp( lerpResult181_g60246 , lerpResult182_g60246 , break187_g60246.y);
					float4 Output_Fetch2D_Auto202_g60246 = lerpResult176_g60246;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1083_g60213 = Output_Fetch2D_Auto202_g60246;
					#else
					float4 staticSwitch1083_g60213 = tex2D( _UdonRNMY1, UV_Lightmap2361_g60213 );
					#endif
					float3 appendResult149_g60229 = (float3(( -1.0 / sqrt( 6.0 ) ) , ( -1.0 / sqrt( 2.0 ) ) , ( 1.0 / sqrt( 3.0 ) )));
					float dotResult120_g60229 = dot( appendResult149_g60229 , Normal_Map318_g60229 );
					float temp_output_2_0_g60232 = saturate( dotResult120_g60229 );
					float4 Input_FetchOffsets197_g60247 = temp_output_1_34_g60243;
					float2 Input_FetchWeights200_g60247 = temp_output_1_54_g60243;
					float2 break187_g60247 = Input_FetchWeights200_g60247;
					float4 lerpResult181_g60247 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60247).yw ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60247).xw ) , break187_g60247.x);
					float4 lerpResult182_g60247 = lerp( tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60247).yz ) , tex2D( _UdonRNMZ1, (Input_FetchOffsets197_g60247).xz ) , break187_g60247.x);
					float4 lerpResult176_g60247 = lerp( lerpResult181_g60247 , lerpResult182_g60247 , break187_g60247.y);
					float4 Output_Fetch2D_Auto202_g60247 = lerpResult176_g60247;
					#ifdef _USEBICUBICFILTERING_ON
					float4 staticSwitch1084_g60213 = Output_Fetch2D_Auto202_g60247;
					#else
					float4 staticSwitch1084_g60213 = tex2D( _UdonRNMZ1, UV_Lightmap2361_g60213 );
					#endif
					float4 RNM_11081_g60213 = ( ( ( ( ( temp_output_2_0_g60231 * temp_output_2_0_g60231 ) * staticSwitch1087_g60213 ) + ( ( temp_output_2_0_g60230 * temp_output_2_0_g60230 ) * staticSwitch1083_g60213 ) ) + ( ( temp_output_2_0_g60232 * temp_output_2_0_g60232 ) * staticSwitch1084_g60213 ) ) * 1.2 );
					float4 lerpResult953_g60213 = lerp( RNM_0926_g60213 , RNM_11081_g60213 , Lightmap_Lerp_Value969_g60213);
					float4 RNM_Lerp950_g60213 = lerpResult953_g60213;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float4 staticSwitch1014_g60213 = temp_cast_1;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float4 staticSwitch1014_g60213 = Lightmap_0925_g60213;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float4 staticSwitch1014_g60213 = Lightmap_Lerp932_g60213;
					#elif defined( _LIGHTMAPMODE_RNM )
					float4 staticSwitch1014_g60213 = RNM_0926_g60213;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float4 staticSwitch1014_g60213 = RNM_Lerp950_g60213;
					#else
					float4 staticSwitch1014_g60213 = temp_cast_1;
					#endif
					float3 Lightmap46_g60213 = (staticSwitch1014_g60213).rgb;
					float dotResult9_g60237 = dot( float3( 0.212673, 0.715152, 0.072175 ) , Lightmap46_g60213 );
					float smoothstepResult14_g60237 = smoothstep( 0.0 , 0.1 , dotResult9_g60237);
					float Indirect_Lightmap_Mask3118_g60213 = smoothstepResult14_g60237;
					#if defined( _LIGHTMAPMODE_DISABLED )
					float staticSwitch3145_g60213 = White38_g60213;
					#elif defined( _LIGHTMAPMODE_SIMPLE )
					float staticSwitch3145_g60213 = Indirect_Lightmap_Mask3118_g60213;
					#elif defined( _LIGHTMAPMODE_SIMPLELERP )
					float staticSwitch3145_g60213 = Indirect_Lightmap_Mask3118_g60213;
					#elif defined( _LIGHTMAPMODE_RNM )
					float staticSwitch3145_g60213 = Indirect_Lightmap_Mask3118_g60213;
					#elif defined( _LIGHTMAPMODE_RNMLERP )
					float staticSwitch3145_g60213 = Indirect_Lightmap_Mask3118_g60213;
					#else
					float staticSwitch3145_g60213 = White38_g60213;
					#endif
					float LightmapMask1_g60240 = staticSwitch3145_g60213;
					float3 localIndirectSpecular1_g60240 = IndirectSpecular( Color1_g60240 , Metallic1_g60240 , Smoothness1_g60240 , ViewDir1_g60240 , WorldPos1_g60240 , WorldNormal1_g60240 , LightmapMask1_g60240 );
					#ifdef _INDIRECTSPECULARS_ON
					float3 staticSwitch2971_g60213 = localIndirectSpecular1_g60240;
					#else
					float3 staticSwitch2971_g60213 = temp_cast_0;
					#endif
					float3 Indirect_Speculars1419_g60213 = staticSwitch2971_g60213;
					float2 temp_output_5_0_g60224 = UV_Diffuse2420_g60213;
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
					float2 temp_output_597_0_g60224 = ( UV100_g60225 + Hash22( ifLocalVar87_g60225 ) );
					float2 DDX631_g60224 = ddx( temp_output_5_0_g60224 );
					float2 DDY632_g60224 = ddy( temp_output_5_0_g60224 );
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
					float2 temp_output_597_26_g60224 = ( UV100_g60225 + Hash22( ifLocalVar88_g60225 ) );
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
					float2 temp_output_597_27_g60224 = ( UV100_g60225 + Hash22( ifLocalVar89_g60225 ) );
					float temp_output_67_0_g60225 = ( 1.0 - break55_g60225.x );
					float ifLocalVar61_g60225 = 0;
					if( temp_output_56_0_g60225 <= 0.0 )
					ifLocalVar61_g60225 = temp_output_67_0_g60225;
					else
					ifLocalVar61_g60225 = break55_g60225.x;
					float temp_output_597_29_g60224 = ifLocalVar61_g60225;
					float4 Output_2D293_g60224 = ( ( tex2D( _Sampler82968_g60213, temp_output_597_0_g60224, DDX631_g60224, DDY632_g60224 ) * temp_output_597_30_g60224 ) + ( tex2D( _Sampler82968_g60213, temp_output_597_26_g60224, DDX631_g60224, DDY632_g60224 ) * temp_output_597_28_g60224 ) + ( tex2D( _Sampler82968_g60213, temp_output_597_27_g60224, DDX631_g60224, DDY632_g60224 ) * temp_output_597_29_g60224 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g60213 = Output_2D293_g60224;
					#else
					float4 staticSwitch1006_g60213 = tex2D( _EmissionMap, UV_Diffuse2420_g60213 );
					#endif
					float3 temp_output_2531_0_g60213 = (( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g60213 * _EmissionIntensity )).rgb;
					float3 Emission86_g60213 = temp_output_2531_0_g60213;
					float3 temp_output_1463_0_g60213 = ( Diffuse2560_g60213 + Direct_Speculars3240_g60213 + Indirect_Speculars1419_g60213 + Emission86_g60213 );
					#ifdef _LIGHTMAPDEBUG
					float3 staticSwitch1181_g60213 = Lightmap46_g60213;
					#else
					float3 staticSwitch1181_g60213 = temp_output_1463_0_g60213;
					#endif
					float4 Color357_g60241 = float4( staticSwitch1181_g60213 , 0.0 );
					float4 LUT51_g60241 = tex3D( _LUT, ( ( log10( ( ( (Color357_g60241).xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 ) );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch359_g60241 = LUT51_g60241;
					#else
					float4 staticSwitch359_g60241 = Color357_g60241;
					#endif
					

					float3 Color = staticSwitch359_g60241.xyz;
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
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":6460,"pos":[-64,-1280],"params":["Inherit","False","Meenphie","0","","60213","b3ba55a08dd6b49c7be16c6f35cf2033","6,1008,0,2632,0,2635,0,2619,0,2670,0,2636,0","0","3","FLOAT4","624","FLOAT","156","FLOAT","427"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":6275,"pos":[256,-1280],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","7","New Amplify Shader","0770190933193b94aaa3065e307002fa","True","ShadowCaster","0","2","ShadowCaster","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","False","False","False","True","2","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","True","3","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","False","","True","3","False","","False","False","True","1","LightMode=ShadowCaster","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":6274,"pos":[256,-1280],"params":["Float","False","True","-1","3","AmplifyShaderEditor.MaterialInspector","0","7","Meenphie/Standard/Opaque","0770190933193b94aaa3065e307002fa","True","Unlit","0","1","Unlit","8","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","False","False","False","True","2","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","True","3","True","12","all","0","False","True","1","1","False","","0","False","","1","1","False","","0","False","","True","1","False","","1","False","","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","False","True","1","LightMode=ForwardBase","False","False","0","","0","0","Standard","10","Surface","0","0","  Keep Alpha","0","0","  Blend","0","0","Alpha Clipping","0","0","  Use Shadow Threshold","0","0","Cast Shadows","0","639163672731073790","Write Depth","0","0","  Conservative","0","0","Extra Pre Pass","0","0","Vertex Position","1","0","0","3","False","True","False","False","","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":6458,"pos":[256,-1280],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","1","New Amplify Shader","0770190933193b94aaa3065e307002fa","True","ExtraPrePass","0","0","ExtraPrePass","6","False","True","1","1","False","","0","False","","1","1","False","","0","False","","True","1","False","","1","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","False","False","False","True","1","RenderType=Opaque=RenderType","True","3","True","12","all","0","False","True","1","1","False","","0","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","False","True","1","LightMode=ForwardBase","False","False","0","","0","0","Standard","0","False","0"]}
{"wire":[6274,0,6460,624]}
ASEEND*/
//CHKSM=ABB6A67678DFC11CE3E698ED4D6EFF4A7D0C7F6B