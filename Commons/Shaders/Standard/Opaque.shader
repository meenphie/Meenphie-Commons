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
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACELIGHTMAPPING( "CATEGORY SPACE LIGHTMAPPING", Float ) = 0
		[Meenphie_DrawerCategory(STOCHASTIC,true,0,0)] _CATEGORYSTOCHASTIC( "CATEGORY STOCHASTIC", Float ) = 0
		[Toggle( _STOCHASTICENABLED_ON )] _StochasticEnabled( "Stochastic Enabled", Float ) = 0
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESTOCHASTIC( "CATEGORY SPACE STOCHASTIC", Float ) = 0
		[Meenphie_DrawerCategory(COLOR GRADING,true,0,0)] _CATEGORYCOLORGRADING( "CATEGORY COLOR GRADING", Float ) = 0
		[NoScaleOffset][SingleLineTexture] _LUT( "LUT", 3D ) = "black" {}
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACECOLORGRADING( "CATEGORY SPACE COLOR GRADING", Float ) = 0
		[Meenphie_DrawerCategory(SPECIAL EFFECTS,true,0,0)] _CATEGORYSPECIALEFFECTS( "CATEGORY SPECIAL EFFECTS", Float ) = 0
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESPECIALEFFECTS( "CATEGORY SPACE SPECIAL EFFECTS", Float ) = 0
		[HideInInspector] GenKey__MainTex( "Assign keyword _MAINTEX", Float ) = 1.0
		[HideInInspector] GenKey__MetallicMap( "Assign keyword _METALLICMAP", Float ) = 1.0
		[HideInInspector] GenKey__GlossinessMap( "Assign keyword _GLOSSINESSMAP", Float ) = 1.0
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0

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
				#pragma shader_feature_local _STOCHASTICENABLED_ON
				#pragma shader_feature_local _METALLICMAP
				#pragma shader_feature_local _USEGEOMETRICAA_ON
				#pragma shader_feature_local _GLOSSINESSMAP
				#pragma shader_feature_local _BUMPMAP


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
				uniform float _CATEGORYSTOCHASTIC;
				uniform float _CATEGORYSPACESTOCHASTIC;
				uniform float _CATEGORYSPACECOLORGRADING;
				uniform float _CATEGORYCOLORGRADING;
				uniform float _CATEGORYSPACESPECIALEFFECTS;
				uniform float _CATEGORYSPECIALEFFECTS;
				uniform float _CATEGORYSPACESURFACEOPTIONS;
				uniform sampler3D _LUT;
				uniform float _CATEGORYSPACELIGHTMAPPING;
				uniform float _CATEGORYLIGHTMAPPING;
				uniform half4 _Color;
				uniform sampler2D _MainTex;
				sampler2D _Sampler82966_g60363;
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				sampler2D _Sampler82967_g60363;
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				sampler2D _Sampler82964_g60363;
				uniform sampler2D _BumpMap;
				sampler2D _Sampler82965_g60363;
				uniform float3 _EmissionColor;
				uniform sampler2D _EmissionMap;
				sampler2D _Sampler82968_g60363;
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

					float2 texCoord2357_g60363 = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
					float2 UV_Diffuse2420_g60363 = texCoord2357_g60363;
					float2 temp_output_5_0_g60366 = UV_Diffuse2420_g60363;
					float2 UV633_g60366 = temp_output_5_0_g60366;
					float2 UV100_g60367 = UV633_g60366;
					float2 temp_output_51_0_g60367 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60367 * float2( 3.464,3.464 ) ) );
					float2 break55_g60367 = frac( temp_output_51_0_g60367 );
					float temp_output_56_0_g60367 = ( ( 1.0 - break55_g60367.x ) - break55_g60367.y );
					float2 temp_output_52_0_g60367 = floor( temp_output_51_0_g60367 );
					float2 temp_output_125_0_g60367 = ( temp_output_52_0_g60367 + float2( 1,1 ) );
					float2 ifLocalVar87_g60367 = 0;
					if( temp_output_56_0_g60367 > 0.0 )
					ifLocalVar87_g60367 = temp_output_52_0_g60367;
					else if( temp_output_56_0_g60367 == 0.0 )
					ifLocalVar87_g60367 = temp_output_125_0_g60367;
					else if( temp_output_56_0_g60367 < 0.0 )
					ifLocalVar87_g60367 = temp_output_125_0_g60367;
					float2 temp_output_597_0_g60366 = ( UV100_g60367 + Hash22( ifLocalVar87_g60367 ) );
					float2 DDX631_g60366 = ddx( temp_output_5_0_g60366 );
					float2 DDY632_g60366 = ddy( temp_output_5_0_g60366 );
					float temp_output_65_0_g60367 = ( 0.0 - temp_output_56_0_g60367 );
					float ifLocalVar59_g60367 = 0;
					if( temp_output_56_0_g60367 <= 0.0 )
					ifLocalVar59_g60367 = temp_output_65_0_g60367;
					else
					ifLocalVar59_g60367 = temp_output_56_0_g60367;
					float temp_output_597_30_g60366 = ifLocalVar59_g60367;
					float2 temp_output_90_0_g60367 = ( temp_output_52_0_g60367 + float2( 0,1 ) );
					float2 temp_output_123_0_g60367 = ( temp_output_52_0_g60367 + float2( 1,0 ) );
					float2 ifLocalVar88_g60367 = 0;
					if( temp_output_56_0_g60367 > 0.0 )
					ifLocalVar88_g60367 = temp_output_90_0_g60367;
					else if( temp_output_56_0_g60367 == 0.0 )
					ifLocalVar88_g60367 = temp_output_123_0_g60367;
					else if( temp_output_56_0_g60367 < 0.0 )
					ifLocalVar88_g60367 = temp_output_123_0_g60367;
					float2 temp_output_597_26_g60366 = ( UV100_g60367 + Hash22( ifLocalVar88_g60367 ) );
					float temp_output_66_0_g60367 = ( 1.0 - break55_g60367.y );
					float ifLocalVar60_g60367 = 0;
					if( temp_output_56_0_g60367 <= 0.0 )
					ifLocalVar60_g60367 = temp_output_66_0_g60367;
					else
					ifLocalVar60_g60367 = break55_g60367.y;
					float temp_output_597_28_g60366 = ifLocalVar60_g60367;
					float2 ifLocalVar89_g60367 = 0;
					if( temp_output_56_0_g60367 > 0.0 )
					ifLocalVar89_g60367 = temp_output_123_0_g60367;
					else if( temp_output_56_0_g60367 == 0.0 )
					ifLocalVar89_g60367 = temp_output_90_0_g60367;
					else if( temp_output_56_0_g60367 < 0.0 )
					ifLocalVar89_g60367 = temp_output_90_0_g60367;
					float2 temp_output_597_27_g60366 = ( UV100_g60367 + Hash22( ifLocalVar89_g60367 ) );
					float temp_output_67_0_g60367 = ( 1.0 - break55_g60367.x );
					float ifLocalVar61_g60367 = 0;
					if( temp_output_56_0_g60367 <= 0.0 )
					ifLocalVar61_g60367 = temp_output_67_0_g60367;
					else
					ifLocalVar61_g60367 = break55_g60367.x;
					float temp_output_597_29_g60366 = ifLocalVar61_g60367;
					float4 Output_2D293_g60366 = ( ( tex2D( _Sampler82966_g60363, temp_output_597_0_g60366, DDX631_g60366, DDY632_g60366 ) * temp_output_597_30_g60366 ) + ( tex2D( _Sampler82966_g60363, temp_output_597_26_g60366, DDX631_g60366, DDY632_g60366 ) * temp_output_597_28_g60366 ) + ( tex2D( _Sampler82966_g60363, temp_output_597_27_g60366, DDX631_g60366, DDY632_g60366 ) * temp_output_597_29_g60366 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1001_g60363 = Output_2D293_g60366;
					#else
					float4 staticSwitch1001_g60363 = ( _Color * tex2D( _MainTex, UV_Diffuse2420_g60363 ) );
					#endif
					float3 temp_output_2532_0_g60363 = (staticSwitch1001_g60363).rgb;
					float3 oAlbedo6_g60363 = temp_output_2532_0_g60363;
					float3 Color97_g60380 = oAlbedo6_g60363;
					#ifdef _METALLICMAP
					float staticSwitch846_g60363 = tex2D( _MetallicMap, UV_Diffuse2420_g60363 ).r;
					#else
					float staticSwitch846_g60363 = _Metallic;
					#endif
					float2 temp_output_5_0_g60372 = UV_Diffuse2420_g60363;
					float2 UV633_g60372 = temp_output_5_0_g60372;
					float2 UV100_g60373 = UV633_g60372;
					float2 temp_output_51_0_g60373 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60373 * float2( 3.464,3.464 ) ) );
					float2 break55_g60373 = frac( temp_output_51_0_g60373 );
					float temp_output_56_0_g60373 = ( ( 1.0 - break55_g60373.x ) - break55_g60373.y );
					float2 temp_output_52_0_g60373 = floor( temp_output_51_0_g60373 );
					float2 temp_output_125_0_g60373 = ( temp_output_52_0_g60373 + float2( 1,1 ) );
					float2 ifLocalVar87_g60373 = 0;
					if( temp_output_56_0_g60373 > 0.0 )
					ifLocalVar87_g60373 = temp_output_52_0_g60373;
					else if( temp_output_56_0_g60373 == 0.0 )
					ifLocalVar87_g60373 = temp_output_125_0_g60373;
					else if( temp_output_56_0_g60373 < 0.0 )
					ifLocalVar87_g60373 = temp_output_125_0_g60373;
					float2 temp_output_597_0_g60372 = ( UV100_g60373 + Hash22( ifLocalVar87_g60373 ) );
					float2 DDX631_g60372 = ddx( temp_output_5_0_g60372 );
					float2 DDY632_g60372 = ddy( temp_output_5_0_g60372 );
					float temp_output_65_0_g60373 = ( 0.0 - temp_output_56_0_g60373 );
					float ifLocalVar59_g60373 = 0;
					if( temp_output_56_0_g60373 <= 0.0 )
					ifLocalVar59_g60373 = temp_output_65_0_g60373;
					else
					ifLocalVar59_g60373 = temp_output_56_0_g60373;
					float temp_output_597_30_g60372 = ifLocalVar59_g60373;
					float2 temp_output_90_0_g60373 = ( temp_output_52_0_g60373 + float2( 0,1 ) );
					float2 temp_output_123_0_g60373 = ( temp_output_52_0_g60373 + float2( 1,0 ) );
					float2 ifLocalVar88_g60373 = 0;
					if( temp_output_56_0_g60373 > 0.0 )
					ifLocalVar88_g60373 = temp_output_90_0_g60373;
					else if( temp_output_56_0_g60373 == 0.0 )
					ifLocalVar88_g60373 = temp_output_123_0_g60373;
					else if( temp_output_56_0_g60373 < 0.0 )
					ifLocalVar88_g60373 = temp_output_123_0_g60373;
					float2 temp_output_597_26_g60372 = ( UV100_g60373 + Hash22( ifLocalVar88_g60373 ) );
					float temp_output_66_0_g60373 = ( 1.0 - break55_g60373.y );
					float ifLocalVar60_g60373 = 0;
					if( temp_output_56_0_g60373 <= 0.0 )
					ifLocalVar60_g60373 = temp_output_66_0_g60373;
					else
					ifLocalVar60_g60373 = break55_g60373.y;
					float temp_output_597_28_g60372 = ifLocalVar60_g60373;
					float2 ifLocalVar89_g60373 = 0;
					if( temp_output_56_0_g60373 > 0.0 )
					ifLocalVar89_g60373 = temp_output_123_0_g60373;
					else if( temp_output_56_0_g60373 == 0.0 )
					ifLocalVar89_g60373 = temp_output_90_0_g60373;
					else if( temp_output_56_0_g60373 < 0.0 )
					ifLocalVar89_g60373 = temp_output_90_0_g60373;
					float2 temp_output_597_27_g60372 = ( UV100_g60373 + Hash22( ifLocalVar89_g60373 ) );
					float temp_output_67_0_g60373 = ( 1.0 - break55_g60373.x );
					float ifLocalVar61_g60373 = 0;
					if( temp_output_56_0_g60373 <= 0.0 )
					ifLocalVar61_g60373 = temp_output_67_0_g60373;
					else
					ifLocalVar61_g60373 = break55_g60373.x;
					float temp_output_597_29_g60372 = ifLocalVar61_g60373;
					float4 Output_2D293_g60372 = ( ( tex2D( _Sampler82967_g60363, temp_output_597_0_g60372, DDX631_g60372, DDY632_g60372 ) * temp_output_597_30_g60372 ) + ( tex2D( _Sampler82967_g60363, temp_output_597_26_g60372, DDX631_g60372, DDY632_g60372 ) * temp_output_597_28_g60372 ) + ( tex2D( _Sampler82967_g60363, temp_output_597_27_g60372, DDX631_g60372, DDY632_g60372 ) * temp_output_597_29_g60372 ) );
					float4 break31_g60372 = Output_2D293_g60372;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1005_g60363 = break31_g60372.r;
					#else
					float staticSwitch1005_g60363 = staticSwitch846_g60363;
					#endif
					float Metallic1239_g60363 = staticSwitch1005_g60363;
					float Metallic97_g60380 = Metallic1239_g60363;
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g60363 = tex2D( _GlossinessMap, UV_Diffuse2420_g60363 ).r;
					#else
					float staticSwitch845_g60363 = _Glossiness;
					#endif
					float2 temp_output_5_0_g60368 = UV_Diffuse2420_g60363;
					float2 UV633_g60368 = temp_output_5_0_g60368;
					float2 UV100_g60369 = UV633_g60368;
					float2 temp_output_51_0_g60369 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60369 * float2( 3.464,3.464 ) ) );
					float2 break55_g60369 = frac( temp_output_51_0_g60369 );
					float temp_output_56_0_g60369 = ( ( 1.0 - break55_g60369.x ) - break55_g60369.y );
					float2 temp_output_52_0_g60369 = floor( temp_output_51_0_g60369 );
					float2 temp_output_125_0_g60369 = ( temp_output_52_0_g60369 + float2( 1,1 ) );
					float2 ifLocalVar87_g60369 = 0;
					if( temp_output_56_0_g60369 > 0.0 )
					ifLocalVar87_g60369 = temp_output_52_0_g60369;
					else if( temp_output_56_0_g60369 == 0.0 )
					ifLocalVar87_g60369 = temp_output_125_0_g60369;
					else if( temp_output_56_0_g60369 < 0.0 )
					ifLocalVar87_g60369 = temp_output_125_0_g60369;
					float2 temp_output_597_0_g60368 = ( UV100_g60369 + Hash22( ifLocalVar87_g60369 ) );
					float2 DDX631_g60368 = ddx( temp_output_5_0_g60368 );
					float2 DDY632_g60368 = ddy( temp_output_5_0_g60368 );
					float temp_output_65_0_g60369 = ( 0.0 - temp_output_56_0_g60369 );
					float ifLocalVar59_g60369 = 0;
					if( temp_output_56_0_g60369 <= 0.0 )
					ifLocalVar59_g60369 = temp_output_65_0_g60369;
					else
					ifLocalVar59_g60369 = temp_output_56_0_g60369;
					float temp_output_597_30_g60368 = ifLocalVar59_g60369;
					float2 temp_output_90_0_g60369 = ( temp_output_52_0_g60369 + float2( 0,1 ) );
					float2 temp_output_123_0_g60369 = ( temp_output_52_0_g60369 + float2( 1,0 ) );
					float2 ifLocalVar88_g60369 = 0;
					if( temp_output_56_0_g60369 > 0.0 )
					ifLocalVar88_g60369 = temp_output_90_0_g60369;
					else if( temp_output_56_0_g60369 == 0.0 )
					ifLocalVar88_g60369 = temp_output_123_0_g60369;
					else if( temp_output_56_0_g60369 < 0.0 )
					ifLocalVar88_g60369 = temp_output_123_0_g60369;
					float2 temp_output_597_26_g60368 = ( UV100_g60369 + Hash22( ifLocalVar88_g60369 ) );
					float temp_output_66_0_g60369 = ( 1.0 - break55_g60369.y );
					float ifLocalVar60_g60369 = 0;
					if( temp_output_56_0_g60369 <= 0.0 )
					ifLocalVar60_g60369 = temp_output_66_0_g60369;
					else
					ifLocalVar60_g60369 = break55_g60369.y;
					float temp_output_597_28_g60368 = ifLocalVar60_g60369;
					float2 ifLocalVar89_g60369 = 0;
					if( temp_output_56_0_g60369 > 0.0 )
					ifLocalVar89_g60369 = temp_output_123_0_g60369;
					else if( temp_output_56_0_g60369 == 0.0 )
					ifLocalVar89_g60369 = temp_output_90_0_g60369;
					else if( temp_output_56_0_g60369 < 0.0 )
					ifLocalVar89_g60369 = temp_output_90_0_g60369;
					float2 temp_output_597_27_g60368 = ( UV100_g60369 + Hash22( ifLocalVar89_g60369 ) );
					float temp_output_67_0_g60369 = ( 1.0 - break55_g60369.x );
					float ifLocalVar61_g60369 = 0;
					if( temp_output_56_0_g60369 <= 0.0 )
					ifLocalVar61_g60369 = temp_output_67_0_g60369;
					else
					ifLocalVar61_g60369 = break55_g60369.x;
					float temp_output_597_29_g60368 = ifLocalVar61_g60369;
					float4 Output_2D293_g60368 = ( ( tex2D( _Sampler82964_g60363, temp_output_597_0_g60368, DDX631_g60368, DDY632_g60368 ) * temp_output_597_30_g60368 ) + ( tex2D( _Sampler82964_g60363, temp_output_597_26_g60368, DDX631_g60368, DDY632_g60368 ) * temp_output_597_28_g60368 ) + ( tex2D( _Sampler82964_g60363, temp_output_597_27_g60368, DDX631_g60368, DDY632_g60368 ) * temp_output_597_29_g60368 ) );
					float4 break31_g60368 = Output_2D293_g60368;
					#ifdef _STOCHASTICENABLED_ON
					float staticSwitch1004_g60363 = ( 1.0 - break31_g60368.r );
					#else
					float staticSwitch1004_g60363 = ( 1.0 - staticSwitch845_g60363 );
					#endif
					float temp_output_19_0_g60377 = staticSwitch1004_g60363;
					float2 temp_output_5_0_g60364 = UV_Diffuse2420_g60363;
					float2 UV633_g60364 = temp_output_5_0_g60364;
					float2 UV100_g60365 = UV633_g60364;
					float2 temp_output_51_0_g60365 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60365 * float2( 3.464,3.464 ) ) );
					float2 break55_g60365 = frac( temp_output_51_0_g60365 );
					float temp_output_56_0_g60365 = ( ( 1.0 - break55_g60365.x ) - break55_g60365.y );
					float2 temp_output_52_0_g60365 = floor( temp_output_51_0_g60365 );
					float2 temp_output_125_0_g60365 = ( temp_output_52_0_g60365 + float2( 1,1 ) );
					float2 ifLocalVar87_g60365 = 0;
					if( temp_output_56_0_g60365 > 0.0 )
					ifLocalVar87_g60365 = temp_output_52_0_g60365;
					else if( temp_output_56_0_g60365 == 0.0 )
					ifLocalVar87_g60365 = temp_output_125_0_g60365;
					else if( temp_output_56_0_g60365 < 0.0 )
					ifLocalVar87_g60365 = temp_output_125_0_g60365;
					float2 temp_output_597_0_g60364 = ( UV100_g60365 + Hash22( ifLocalVar87_g60365 ) );
					float2 DDX631_g60364 = ddx( temp_output_5_0_g60364 );
					float2 DDY632_g60364 = ddy( temp_output_5_0_g60364 );
					float Input_Scale617_g60364 = 1.5;
					float temp_output_65_0_g60365 = ( 0.0 - temp_output_56_0_g60365 );
					float ifLocalVar59_g60365 = 0;
					if( temp_output_56_0_g60365 <= 0.0 )
					ifLocalVar59_g60365 = temp_output_65_0_g60365;
					else
					ifLocalVar59_g60365 = temp_output_56_0_g60365;
					float temp_output_597_30_g60364 = ifLocalVar59_g60365;
					float2 temp_output_90_0_g60365 = ( temp_output_52_0_g60365 + float2( 0,1 ) );
					float2 temp_output_123_0_g60365 = ( temp_output_52_0_g60365 + float2( 1,0 ) );
					float2 ifLocalVar88_g60365 = 0;
					if( temp_output_56_0_g60365 > 0.0 )
					ifLocalVar88_g60365 = temp_output_90_0_g60365;
					else if( temp_output_56_0_g60365 == 0.0 )
					ifLocalVar88_g60365 = temp_output_123_0_g60365;
					else if( temp_output_56_0_g60365 < 0.0 )
					ifLocalVar88_g60365 = temp_output_123_0_g60365;
					float2 temp_output_597_26_g60364 = ( UV100_g60365 + Hash22( ifLocalVar88_g60365 ) );
					float temp_output_66_0_g60365 = ( 1.0 - break55_g60365.y );
					float ifLocalVar60_g60365 = 0;
					if( temp_output_56_0_g60365 <= 0.0 )
					ifLocalVar60_g60365 = temp_output_66_0_g60365;
					else
					ifLocalVar60_g60365 = break55_g60365.y;
					float temp_output_597_28_g60364 = ifLocalVar60_g60365;
					float2 ifLocalVar89_g60365 = 0;
					if( temp_output_56_0_g60365 > 0.0 )
					ifLocalVar89_g60365 = temp_output_123_0_g60365;
					else if( temp_output_56_0_g60365 == 0.0 )
					ifLocalVar89_g60365 = temp_output_90_0_g60365;
					else if( temp_output_56_0_g60365 < 0.0 )
					ifLocalVar89_g60365 = temp_output_90_0_g60365;
					float2 temp_output_597_27_g60364 = ( UV100_g60365 + Hash22( ifLocalVar89_g60365 ) );
					float temp_output_67_0_g60365 = ( 1.0 - break55_g60365.x );
					float ifLocalVar61_g60365 = 0;
					if( temp_output_56_0_g60365 <= 0.0 )
					ifLocalVar61_g60365 = temp_output_67_0_g60365;
					else
					ifLocalVar61_g60365 = break55_g60365.x;
					float temp_output_597_29_g60364 = ifLocalVar61_g60365;
					float3 Output_2D_Normal641_g60364 = ( ( UnpackScaleNormal( tex2D( _Sampler82965_g60363, temp_output_597_0_g60364, DDX631_g60364, DDY632_g60364 ), Input_Scale617_g60364 ) * temp_output_597_30_g60364 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g60363, temp_output_597_26_g60364, DDX631_g60364, DDY632_g60364 ), Input_Scale617_g60364 ) * temp_output_597_28_g60364 ) + ( UnpackScaleNormal( tex2D( _Sampler82965_g60363, temp_output_597_27_g60364, DDX631_g60364, DDY632_g60364 ), Input_Scale617_g60364 ) * float3( 0,0,0 ) * temp_output_597_29_g60364 ) );
					#ifdef _STOCHASTICENABLED_ON
					float3 staticSwitch1003_g60363 = Output_2D_Normal641_g60364;
					#else
					float3 staticSwitch1003_g60363 = UnpackScaleNormal( tex2D( _BumpMap, UV_Diffuse2420_g60363 ), 1.5 );
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g60363 = staticSwitch1003_g60363;
					#else
					float3 staticSwitch980_g60363 = float3( 0, 0, 1 );
					#endif
					float3 normalizeResult2878_g60363 = normalize( staticSwitch980_g60363 );
					float3 Normal700_g60363 = normalizeResult2878_g60363;
					float3 ase_tangentWS = IN.ase_texcoord1.xyz;
					float3 ase_normalWS = IN.ase_texcoord2.xyz;
					float3 ase_bitangentWS = IN.ase_texcoord3.xyz;
					float3 tanToWorld0 = float3( ase_tangentWS.x, ase_bitangentWS.x, ase_normalWS.x );
					float3 tanToWorld1 = float3( ase_tangentWS.y, ase_bitangentWS.y, ase_normalWS.y );
					float3 tanToWorld2 = float3( ase_tangentWS.z, ase_bitangentWS.z, ase_normalWS.z );
					float3 tanNormal2504_g60363 = Normal700_g60363;
					float3 worldNormal2504_g60363 = normalize( float3( dot( tanToWorld0, tanNormal2504_g60363 ), dot( tanToWorld1, tanNormal2504_g60363 ), dot( tanToWorld2, tanNormal2504_g60363 ) ) );
					float3 World_Normal2508_g60363 = worldNormal2504_g60363;
					float3 tanNormal2_g60377 = World_Normal2508_g60363;
					float3 worldNormal2_g60377 = float3( dot( tanToWorld0, tanNormal2_g60377 ), dot( tanToWorld1, tanNormal2_g60377 ), dot( tanToWorld2, tanNormal2_g60377 ) );
					float3 temp_output_3_0_g60377 = ddx( worldNormal2_g60377 );
					float dotResult5_g60377 = dot( temp_output_3_0_g60377 , temp_output_3_0_g60377 );
					float3 temp_output_4_0_g60377 = ddy( worldNormal2_g60377 );
					float dotResult6_g60377 = dot( temp_output_4_0_g60377 , temp_output_4_0_g60377 );
					#ifdef _USEGEOMETRICAA_ON
					float staticSwitch15_g60377 = min( temp_output_19_0_g60377, ( 1.0 - pow( saturate( max( dotResult5_g60377, dotResult6_g60377 ) ) , 0.25 ) ) );
					#else
					float staticSwitch15_g60377 = temp_output_19_0_g60377;
					#endif
					float Smoothness1399_g60363 = staticSwitch15_g60377;
					float Smoothness97_g60380 = Smoothness1399_g60363;
					float3 ase_positionWS = IN.ase_texcoord4.xyz;
					float3 ase_viewVectorWS = ( ( unity_OrthoParams.w == 0 ) ? _WorldSpaceCameraPos - ase_positionWS : UNITY_MATRIX_V[ 2 ].xyz );
					float3 ase_viewDirWS = normalize( ase_viewVectorWS );
					float3 View_Direction2511_g60363 = ase_viewDirWS;
					float3 ViewDir97_g60380 = View_Direction2511_g60363;
					float3 World_Position2505_g60363 = ase_positionWS;
					float3 WorldPos97_g60380 = World_Position2505_g60363;
					float3 Normal97_g60380 = Normal700_g60363;
					float3 WorldNormal97_g60380 = World_Normal2508_g60363;
					float3 Vertex_Normal3161_g60363 = IN.ase_normal;
					float3 VertexNormal97_g60380 = Vertex_Normal3161_g60363;
					float4 texCoord2426_g60363 = IN.ase_texcoord;
					texCoord2426_g60363.xy = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
					float2 UV_Lightmap2361_g60363 = (texCoord2426_g60363).zw;
					float2 LightmapUV97_g60380 = UV_Lightmap2361_g60363;
					float3 Diffuse97_g60380 = float3( 0,0,0 );
					float3 Specular97_g60380 = float3( 0,0,0 );
					float3 localDirectSpecular97_g60380 = DirectSpecular( Color97_g60380 , Metallic97_g60380 , Smoothness97_g60380 , ViewDir97_g60380 , WorldPos97_g60380 , Normal97_g60380 , WorldNormal97_g60380 , VertexNormal97_g60380 , LightmapUV97_g60380 , Diffuse97_g60380 , Specular97_g60380 );
					float3 Diffuse2560_g60363 = Diffuse97_g60380;
					float3 Direct_Speculars3240_g60363 = Specular97_g60380;
					float3 Color1_g60381 = oAlbedo6_g60363;
					float Metallic1_g60381 = Metallic1239_g60363;
					float Smoothness1_g60381 = Smoothness1399_g60363;
					float3 ViewDir1_g60381 = View_Direction2511_g60363;
					float3 WorldPos1_g60381 = World_Position2505_g60363;
					float3 WorldNormal1_g60381 = World_Normal2508_g60363;
					float LightmapMask1_g60381 = 1.0;
					float3 localIndirectSpecular1_g60381 = IndirectSpecular( Color1_g60381 , Metallic1_g60381 , Smoothness1_g60381 , ViewDir1_g60381 , WorldPos1_g60381 , WorldNormal1_g60381 , LightmapMask1_g60381 );
					float3 temp_output_3084_0_g60363 = localIndirectSpecular1_g60381;
					float3 Indirect_Speculars1419_g60363 = temp_output_3084_0_g60363;
					float2 temp_output_5_0_g60370 = UV_Diffuse2420_g60363;
					float2 UV633_g60370 = temp_output_5_0_g60370;
					float2 UV100_g60371 = UV633_g60370;
					float2 temp_output_51_0_g60371 = mul( float2x2( 1, 0, -0.5773503, 1.154701 ), ( UV100_g60371 * float2( 3.464,3.464 ) ) );
					float2 break55_g60371 = frac( temp_output_51_0_g60371 );
					float temp_output_56_0_g60371 = ( ( 1.0 - break55_g60371.x ) - break55_g60371.y );
					float2 temp_output_52_0_g60371 = floor( temp_output_51_0_g60371 );
					float2 temp_output_125_0_g60371 = ( temp_output_52_0_g60371 + float2( 1,1 ) );
					float2 ifLocalVar87_g60371 = 0;
					if( temp_output_56_0_g60371 > 0.0 )
					ifLocalVar87_g60371 = temp_output_52_0_g60371;
					else if( temp_output_56_0_g60371 == 0.0 )
					ifLocalVar87_g60371 = temp_output_125_0_g60371;
					else if( temp_output_56_0_g60371 < 0.0 )
					ifLocalVar87_g60371 = temp_output_125_0_g60371;
					float2 temp_output_597_0_g60370 = ( UV100_g60371 + Hash22( ifLocalVar87_g60371 ) );
					float2 DDX631_g60370 = ddx( temp_output_5_0_g60370 );
					float2 DDY632_g60370 = ddy( temp_output_5_0_g60370 );
					float temp_output_65_0_g60371 = ( 0.0 - temp_output_56_0_g60371 );
					float ifLocalVar59_g60371 = 0;
					if( temp_output_56_0_g60371 <= 0.0 )
					ifLocalVar59_g60371 = temp_output_65_0_g60371;
					else
					ifLocalVar59_g60371 = temp_output_56_0_g60371;
					float temp_output_597_30_g60370 = ifLocalVar59_g60371;
					float2 temp_output_90_0_g60371 = ( temp_output_52_0_g60371 + float2( 0,1 ) );
					float2 temp_output_123_0_g60371 = ( temp_output_52_0_g60371 + float2( 1,0 ) );
					float2 ifLocalVar88_g60371 = 0;
					if( temp_output_56_0_g60371 > 0.0 )
					ifLocalVar88_g60371 = temp_output_90_0_g60371;
					else if( temp_output_56_0_g60371 == 0.0 )
					ifLocalVar88_g60371 = temp_output_123_0_g60371;
					else if( temp_output_56_0_g60371 < 0.0 )
					ifLocalVar88_g60371 = temp_output_123_0_g60371;
					float2 temp_output_597_26_g60370 = ( UV100_g60371 + Hash22( ifLocalVar88_g60371 ) );
					float temp_output_66_0_g60371 = ( 1.0 - break55_g60371.y );
					float ifLocalVar60_g60371 = 0;
					if( temp_output_56_0_g60371 <= 0.0 )
					ifLocalVar60_g60371 = temp_output_66_0_g60371;
					else
					ifLocalVar60_g60371 = break55_g60371.y;
					float temp_output_597_28_g60370 = ifLocalVar60_g60371;
					float2 ifLocalVar89_g60371 = 0;
					if( temp_output_56_0_g60371 > 0.0 )
					ifLocalVar89_g60371 = temp_output_123_0_g60371;
					else if( temp_output_56_0_g60371 == 0.0 )
					ifLocalVar89_g60371 = temp_output_90_0_g60371;
					else if( temp_output_56_0_g60371 < 0.0 )
					ifLocalVar89_g60371 = temp_output_90_0_g60371;
					float2 temp_output_597_27_g60370 = ( UV100_g60371 + Hash22( ifLocalVar89_g60371 ) );
					float temp_output_67_0_g60371 = ( 1.0 - break55_g60371.x );
					float ifLocalVar61_g60371 = 0;
					if( temp_output_56_0_g60371 <= 0.0 )
					ifLocalVar61_g60371 = temp_output_67_0_g60371;
					else
					ifLocalVar61_g60371 = break55_g60371.x;
					float temp_output_597_29_g60370 = ifLocalVar61_g60371;
					float4 Output_2D293_g60370 = ( ( tex2D( _Sampler82968_g60363, temp_output_597_0_g60370, DDX631_g60370, DDY632_g60370 ) * temp_output_597_30_g60370 ) + ( tex2D( _Sampler82968_g60363, temp_output_597_26_g60370, DDX631_g60370, DDY632_g60370 ) * temp_output_597_28_g60370 ) + ( tex2D( _Sampler82968_g60363, temp_output_597_27_g60370, DDX631_g60370, DDY632_g60370 ) * temp_output_597_29_g60370 ) );
					#ifdef _STOCHASTICENABLED_ON
					float4 staticSwitch1006_g60363 = Output_2D293_g60370;
					#else
					float4 staticSwitch1006_g60363 = tex2D( _EmissionMap, UV_Diffuse2420_g60363 );
					#endif
					float3 temp_output_2531_0_g60363 = (( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g60363 * _EmissionIntensity )).rgb;
					float3 Emission86_g60363 = temp_output_2531_0_g60363;
					float3 temp_output_1463_0_g60363 = ( Diffuse2560_g60363 + Direct_Speculars3240_g60363 + Indirect_Speculars1419_g60363 + Emission86_g60363 );
					float4 Color357_g60378 = float4( temp_output_1463_0_g60363 , 0.0 );
					float4 LUT51_g60378 = tex3D( _LUT, ( ( log10( ( ( (Color357_g60378).xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 ) );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch359_g60378 = LUT51_g60378;
					#else
					float4 staticSwitch359_g60378 = Color357_g60378;
					#endif
					

					float3 Color = staticSwitch359_g60378.xyz;
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
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":6478,"pos":[-64,-1280],"params":["Inherit","False","Meenphie","0","","60363","b3ba55a08dd6b49c7be16c6f35cf2033","6,1008,0,2632,0,2619,0,2670,0,2636,0,2635,0","0","3","FLOAT4","624","FLOAT","156","FLOAT","427"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":6275,"pos":[256,-1280],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","7","New Amplify Shader","0770190933193b94aaa3065e307002fa","True","ShadowCaster","0","2","ShadowCaster","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","False","False","False","True","2","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","True","3","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","False","","True","3","False","","False","False","True","1","LightMode=ShadowCaster","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":6274,"pos":[256,-1280],"params":["Float","False","True","-1","3","AmplifyShaderEditor.MaterialInspector","0","7","Meenphie/Standard/Opaque","0770190933193b94aaa3065e307002fa","True","Unlit","0","1","Unlit","8","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","False","False","False","True","2","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","True","3","True","12","all","0","False","True","1","1","False","","0","False","","1","1","False","","0","False","","True","1","False","","1","False","","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","False","True","1","LightMode=ForwardBase","False","False","0","","0","0","Standard","10","Surface","0","0","  Keep Alpha","0","0","  Blend","0","0","Alpha Clipping","0","0","  Use Shadow Threshold","0","0","Cast Shadows","0","639163672731073790","Write Depth","0","0","  Conservative","0","0","Extra Pre Pass","0","0","Vertex Position","1","0","0","3","False","True","False","False","","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":6458,"pos":[256,-1280],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","7","New Amplify Shader","0770190933193b94aaa3065e307002fa","True","ExtraPrePass","0","0","ExtraPrePass","6","False","True","1","1","False","","0","False","","1","1","False","","0","False","","True","1","False","","1","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","False","False","False","True","1","RenderType=Opaque=RenderType","True","3","True","12","all","0","False","True","1","1","False","","0","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","False","True","1","LightMode=ForwardBase","False","False","0","","0","0","Standard","0","False","0"]}
{"wire":[6274,0,6478,624]}
ASEEND*/
//CHKSM=9EC3F66AEAB18ACD692F130CADFDBF6113C07FB7