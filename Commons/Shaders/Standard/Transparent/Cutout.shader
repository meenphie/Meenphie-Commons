// Made with Amplify Shader Editor v1.9.9.10
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
		_LightGroupMask( "LightGroupMask", Float ) = 0
		_IsDynamicMesh( "Is Dynamic Mesh", Float ) = 0
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACELIGHTMAPPING( "CATEGORY SPACE LIGHTMAPPING", Float ) = 0
		[Meenphie_DrawerCategory(STOCHASTIC,true,0,0)] _CATEGORYSTOCHASTIC( "CATEGORY STOCHASTIC", Float ) = 0
		[Toggle( _STOCHASTICENABLED_ON )] _StochasticEnabled( "Stochastic Enabled", Float ) = 0
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESTOCHASTIC( "CATEGORY SPACE STOCHASTIC", Float ) = 0
		[Meenphie_DrawerCategory(COLOR GRADING,true,0,0)] _CATEGORYCOLORGRADING( "CATEGORY COLOR GRADING", Float ) = 0
		[NoScaleOffset][SingleLineTexture] _LUT( "LUT", 3D ) = "black" {}
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACECOLORGRADING( "CATEGORY SPACE COLOR GRADING", Float ) = 0
		[Meenphie_DrawerCategory(SPECIAL EFFECTS,true,0,0)] _CATEGORYSPECIALEFFECTS( "CATEGORY SPECIAL EFFECTS", Float ) = 0
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESPECIALEFFECTS( "CATEGORY SPACE SPECIAL EFFECTS", Float ) = 0
		_Offset( "Offset", Float ) = 0
		[HideInInspector] GenKey__MainTex( "Assign keyword _MAINTEX", Float ) = 1.0
		[HideInInspector] GenKey__GlossinessMap( "Assign keyword _GLOSSINESSMAP", Float ) = 1.0
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0
		[HideInInspector] GenKey__MetallicMap( "Assign keyword _METALLICMAP", Float ) = 1.0

	}

	SubShader
	{
		

		

		Tags { "RenderType"="Transparent" "Queue"="Transparent" }

	LOD 0

		ZWrite On
		Cull Back
		AlphaToMask Off
		ColorMask RGBA
		Blend One Zero, One Zero
		BlendOp Add, Add

		

		Blend One Zero, One Zero
		BlendOp Add, Add
		

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
			ZWrite Off
			ZTest LEqual
			Offset [_Offset] , [_Offset]
			ColorMask RGBA
			Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
			BlendOp Add, Add

			

			CGPROGRAM
				#define ASE_SURFACE_TRANSPARENT
				#define _ALPHATEST_ON
				#define ASE_VERSION 19910

				#pragma vertex vert
				#pragma fragment frag
				#pragma multi_compile_instancing
				#include "UnityCG.cginc"

				#include "Packages/com.meenphie.commons/Commons/Shaders/Custom Expressions/DirectSpecular.cginc"
				#include "UnityStandardUtils.cginc"
				#include "Packages/com.meenphie.commons/Commons/Shaders/Custom Expressions/IndirectSpecular.cginc"
				#define ASE_NEEDS_TEXTURE_COORDINATES2
				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#define ASE_NEEDS_VERT_TANGENT
				#define ASE_NEEDS_VERT_NORMAL
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
				#pragma shader_feature_local _STOCHASTICENABLED_ON
				#pragma shader_feature_local _METALLICMAP
				#pragma shader_feature_local _UV_UV0 _UV_UV2
				#pragma shader_feature_local _USEGEOMETRICAA_ON
				#pragma shader_feature_local _GLOSSINESSMAP
				#pragma shader_feature_local _BUMPMAP
				#pragma shader_feature_local_fragment _EMISSIONUV_UV0 _EMISSIONUV_UV2


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
					float4 ase_texcoord2 : TEXCOORD2;
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
					float4 ase_texcoord5 : TEXCOORD5;
					UNITY_VERTEX_INPUT_INSTANCE_ID
					UNITY_VERTEX_OUTPUT_STEREO
				};

				uniform float _Offset;
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
				sampler2D _Sampler82966_g1;
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				sampler2D _Sampler82967_g1;
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				sampler2D _Sampler82964_g1;
				uniform sampler2D _BumpMap;
				sampler2D _Sampler82965_g1;
				uniform float _LightGroupMask;
				uniform float _IsDynamicMesh;
				uniform float3 _EmissionColor;
				uniform sampler2D _EmissionMap;
				sampler2D _Sampler82968_g1;
				uniform float _EmissionIntensity;
				uniform float _MaskClipValue;


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
					o.ase_texcoord2.xyz = ase_tangentWS;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					o.ase_texcoord3.xyz = ase_normalWS;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					o.ase_texcoord4.xyz = ase_bitangentWS;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					o.ase_texcoord5.xyz = ase_positionWS;
					
					o.ase_texcoord.xy = v.ase_texcoord2.xy;
					o.ase_texcoord1 = v.ase_texcoord;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord.zw = 0;
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

					float localDirectSpecular97_g60033 = ( 0.0 );
					float2 texCoord2594_g1 = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
					float2 UV_Decal2595_g1 = texCoord2594_g1;
					float2 temp_output_5_0_g59681 = UV_Decal2595_g1;
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
					float4 staticSwitch1001_g1 = ( _Color * tex2D( _MainTex, UV_Decal2595_g1 ) );
					#endif
					float3 temp_output_2532_0_g1 = (staticSwitch1001_g1).rgb;
					float3 oAlbedo6_g1 = temp_output_2532_0_g1;
					float3 Color97_g60033 = oAlbedo6_g1;
					float2 texCoord2357_g1 = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
					float2 UV_Diffuse2420_g1 = texCoord2357_g1;
					#if defined( _UV_UV0 )
					float2 staticSwitch2671_g1 = UV_Diffuse2420_g1;
					#elif defined( _UV_UV2 )
					float2 staticSwitch2671_g1 = UV_Decal2595_g1;
					#else
					float2 staticSwitch2671_g1 = UV_Decal2595_g1;
					#endif
					#ifdef _METALLICMAP
					float staticSwitch846_g1 = tex2D( _MetallicMap, staticSwitch2671_g1 ).r;
					#else
					float staticSwitch846_g1 = _Metallic;
					#endif
					float2 temp_output_5_0_g59755 = staticSwitch2671_g1;
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
					float Metallic97_g60033 = Metallic1239_g1;
					#if defined( _UV_UV0 )
					float2 staticSwitch2644_g1 = UV_Diffuse2420_g1;
					#elif defined( _UV_UV2 )
					float2 staticSwitch2644_g1 = UV_Decal2595_g1;
					#else
					float2 staticSwitch2644_g1 = UV_Decal2595_g1;
					#endif
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g1 = tex2D( _GlossinessMap, staticSwitch2644_g1 ).r;
					#else
					float staticSwitch845_g1 = _Glossiness;
					#endif
					float2 temp_output_5_0_g59686 = staticSwitch2644_g1;
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
					float3 ase_tangentWS = IN.ase_texcoord2.xyz;
					float3 ase_normalWS = IN.ase_texcoord3.xyz;
					float3 ase_bitangentWS = IN.ase_texcoord4.xyz;
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
					float Smoothness97_g60033 = Smoothness1399_g1;
					float3 ase_positionWS = IN.ase_texcoord5.xyz;
					float3 ase_viewVectorWS = ( ( unity_OrthoParams.w == 0 ) ? _WorldSpaceCameraPos - ase_positionWS : UNITY_MATRIX_V[ 2 ].xyz );
					float3 ase_viewDirWS = normalize( ase_viewVectorWS );
					float3 View_Direction2511_g1 = ase_viewDirWS;
					float3 ViewDir97_g60033 = View_Direction2511_g1;
					float3 World_Position2505_g1 = ase_positionWS;
					float3 WorldPos97_g60033 = World_Position2505_g1;
					float3 Normal97_g60033 = Normal700_g1;
					float3 WorldNormal97_g60033 = World_Normal2508_g1;
					float4 texCoord2426_g1 = IN.ase_texcoord1;
					texCoord2426_g1.xy = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
					float2 UV_Lightmap2361_g1 = (texCoord2426_g1).zw;
					float2 LightmapUV97_g60033 = UV_Lightmap2361_g1;
					float LightGroupMask97_g60033 = _LightGroupMask;
					float IsDynamicMesh97_g60033 = _IsDynamicMesh;
					float3 Diffuse97_g60033 = float3( 0,0,0 );
					float3 Specular97_g60033 = float3( 0,0,0 );
					DirectSpecular( Color97_g60033 , Metallic97_g60033 , Smoothness97_g60033 , ViewDir97_g60033 , WorldPos97_g60033 , Normal97_g60033 , WorldNormal97_g60033 , LightmapUV97_g60033 , LightGroupMask97_g60033 , IsDynamicMesh97_g60033 , Diffuse97_g60033 , Specular97_g60033 );
					float3 Diffuse2560_g1 = Diffuse97_g60033;
					float3 Direct_Speculars3240_g1 = Specular97_g60033;
					float3 Color1_g60025 = oAlbedo6_g1;
					float Metallic1_g60025 = Metallic1239_g1;
					float Smoothness1_g60025 = Smoothness1399_g1;
					float3 ViewDir1_g60025 = View_Direction2511_g1;
					float3 WorldPos1_g60025 = World_Position2505_g1;
					float3 WorldNormal1_g60025 = World_Normal2508_g1;
					float LightmapMask1_g60025 = 1.0;
					float3 localIndirectSpecular1_g60025 = IndirectSpecular( Color1_g60025 , Metallic1_g60025 , Smoothness1_g60025 , ViewDir1_g60025 , WorldPos1_g60025 , WorldNormal1_g60025 , LightmapMask1_g60025 );
					float3 temp_output_3084_0_g1 = localIndirectSpecular1_g60025;
					float3 Indirect_Speculars1419_g1 = temp_output_3084_0_g1;
					#if defined( _EMISSIONUV_UV0 )
					float2 staticSwitch2642_g1 = UV_Diffuse2420_g1;
					#elif defined( _EMISSIONUV_UV2 )
					float2 staticSwitch2642_g1 = UV_Decal2595_g1;
					#else
					float2 staticSwitch2642_g1 = UV_Diffuse2420_g1;
					#endif
					float2 temp_output_5_0_g59692 = staticSwitch2642_g1;
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
					float4 staticSwitch1006_g1 = tex2D( _EmissionMap, staticSwitch2642_g1 );
					#endif
					float3 temp_output_2531_0_g1 = (( float4( _EmissionColor , 0.0 ) * staticSwitch1006_g1 * _EmissionIntensity )).rgb;
					float3 Emission86_g1 = temp_output_2531_0_g1;
					float3 temp_output_1463_0_g1 = ( Diffuse2560_g1 + Direct_Speculars3240_g1 + Indirect_Speculars1419_g1 + Emission86_g1 );
					float4 Color357_g60011 = float4( temp_output_1463_0_g1 , 0.0 );
					float4 LUT51_g60011 = tex3D( _LUT, ( ( log10( ( ( (Color357_g60011).xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 ) );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch359_g60011 = LUT51_g60011;
					#else
					float4 staticSwitch359_g60011 = Color357_g60011;
					#endif
					

					float3 Color = staticSwitch359_g60011.xyz;
					float Alpha = staticSwitch1001_g1.a;
					half AlphaClipThreshold = _MaskClipValue;
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
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":3021,"pos":[256,-1024],"params":["Inherit","False","Property","_Offset","Offset","38","0","Create","True","0","0","0","True","0","False","Object","-1","","0","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":3036,"pos":[192,-1200],"params":["Inherit","False","Meenphie","0","","1","b3ba55a08dd6b49c7be16c6f35cf2033","6,1008,1,2632,1,2619,1,2670,1,2636,1,2635,1","0","3","FLOAT4","624","FLOAT","156","FLOAT","427"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":3029,"pos":[512,-1200],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","7","New Amplify Shader","0770190933193b94aaa3065e307002fa","True","ExtraPrePass","0","0","ExtraPrePass","6","False","True","1","1","False","","0","False","","1","1","False","","0","False","","True","1","False","","1","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","False","False","False","True","1","RenderType=Opaque=RenderType","True","3","True","12","all","0","False","True","1","1","False","","0","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","False","True","1","LightMode=ForwardBase","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":3030,"pos":[512,-1200],"params":["Float","False","True","-1","3","AmplifyShaderEditor.MaterialInspector","0","7","Meenphie/Standard/Transparent/Cutout","0770190933193b94aaa3065e307002fa","True","Unlit","0","1","Unlit","8","False","True","1","1","False","","0","False","","1","1","False","","0","False","","True","1","False","","1","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","False","False","False","True","2","RenderType=Transparent=RenderType","Queue=Transparent=Queue=0","True","3","True","12","all","0","False","True","1","5","False","","10","False","","1","1","False","","10","False","","True","1","False","","1","False","","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","True","True","2","False","","True","3","False","","True","True","0","True","_Offset","0","True","_Offset","False","True","1","LightMode=ForwardBase","False","False","0","","0","0","Standard","10","Surface","1","639175543355264160","  Keep Alpha","0","0","  Blend","0","0","Alpha Clipping","1","639175543365250740","  Use Shadow Threshold","0","0","Cast Shadows","0","639175543372870430","Write Depth","0","0","  Conservative","0","0","Extra Pre Pass","0","0","Vertex Position","1","0","0","3","False","True","False","False","","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":3031,"pos":[512,-1200],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","7","New Amplify Shader","0770190933193b94aaa3065e307002fa","True","ShadowCaster","0","2","ShadowCaster","0","False","True","1","1","False","","0","False","","1","1","False","","0","False","","True","1","False","","1","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","False","False","False","True","1","RenderType=Opaque=RenderType","True","3","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","False","","True","3","False","","False","False","True","1","LightMode=ShadowCaster","False","False","0","","0","0","Standard","0","False","0"]}
{"wire":[3030,0,3036,624]}
{"wire":[3030,7,3036,156]}
{"wire":[3030,8,3036,427]}
ASEEND*/
//CHKSM=70A7F6D7FBD8E0B0AE66416A750F91D3A045C43D