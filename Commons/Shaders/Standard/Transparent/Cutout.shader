// Made with Amplify Shader Editor v1.9.9.12
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
		[Meenphie_DrawerCategory(LIGHTMAPPING,true,0,0)] _CATEGORYLIGHTING( "CATEGORY LIGHTING", Float ) = 0
		[Toggle( _DIFFUSE_ON )] _Diffuse( "Diffuse", Float ) = 1
		[Toggle( _SPECULARS_ON )] _Speculars( "Speculars", Float ) = 1
		[Toggle( _REFLECTIONS_ON )] _Reflections( "Reflections", Float ) = 1
		[HideInInspector] _LightGroupMask( "Light Group Mask", Float ) = 0
		[Toggle] _IsDynamicMesh( "Is Dynamic Mesh", Float ) = 0
		_ProbeIndex( "ProbeIndex", Float ) = 0
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACELIGHTING( "CATEGORY SPACE LIGHTING", Float ) = 0
		[Meenphie_DrawerCategory(COLOR GRADING,true,0,0)] _CATEGORYCOLORGRADING( "CATEGORY COLOR GRADING", Float ) = 0
		[NoScaleOffset][SingleLineTexture] _LUT( "LUT", 3D ) = "black" {}
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACECOLORGRADING( "CATEGORY SPACE COLOR GRADING", Float ) = 0
		[Meenphie_DrawerCategory(SPECIAL EFFECTS,true,0,0)] _CATEGORYSPECIALEFFECTS( "CATEGORY SPECIAL EFFECTS", Float ) = 0
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESPECIALEFFECTS( "CATEGORY SPACE SPECIAL EFFECTS", Float ) = 0
		_Offset( "Offset", Float ) = 0
		[HideInInspector] GenKey__GlossinessMap( "Assign keyword _GLOSSINESSMAP", Float ) = 1.0
		[HideInInspector] GenKey__MetallicMap( "Assign keyword _METALLICMAP", Float ) = 1.0
		[HideInInspector] GenKey__MainTex( "Assign keyword _MAINTEX", Float ) = 1.0
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0

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
			#pragma target 4.5
			#pragma only_renderers d3d11 glcore gles3 metal vulkan // ensure rendering platforms toggle list is visible

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

			Cull Off
			ZWrite On
			ZTest LEqual
			Offset [_Offset] , [_Offset]
			ColorMask RGBA
			Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
			BlendOp Add, Add

			

			CGPROGRAM
				#define ASE_SURFACE_TRANSPARENT
				#define _ALPHATEST_ON
				#define ASE_VERSION 19912

				#pragma vertex vert
				#pragma fragment frag
				#pragma multi_compile_instancing
				#include "UnityCG.cginc"

				#include "Packages/com.meenphie.lighting/Commons/Shaders/Custom Expressions/LayeredLightmapLighting.cginc"
				#include "Packages/com.meenphie.lighting/Commons/Shaders/Custom Expressions/GeometricAA.cginc"
				#include "UnityStandardUtils.cginc"
				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#define ASE_NEEDS_TEXTURE_COORDINATES2
				#define ASE_NEEDS_VERT_TANGENT
				#define ASE_NEEDS_VERT_NORMAL
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
				#pragma shader_feature_local _DIFFUSE_ON
				#pragma shader_feature_local _UV_UV0 _UV_UV2
				#pragma shader_feature_local _METALLICMAP
				#pragma shader_feature_local _USEGEOMETRICAA_ON
				#pragma shader_feature_local _GLOSSINESSMAP
				#pragma shader_feature_local _BUMPMAP
				#pragma shader_feature_local _SPECULARS_ON
				#pragma shader_feature_local _REFLECTIONS_ON
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
					float4 ase_texcoord : TEXCOORD0;
					float4 ase_texcoord2 : TEXCOORD2;
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
				uniform float _EmissionFlags;
				uniform float _CATEGORYEMISSION;
				uniform float _CATEGORYSPACEEMISSION;
				uniform float _CATEGORY_SURFACEOPTIONS;
				uniform float _CATEGORYSPACESURFACEOPTIONS;
				uniform float _CATEGORYSPACECOLORGRADING;
				uniform float _CATEGORYCOLORGRADING;
				uniform float _CATEGORYSPACESPECIALEFFECTS;
				uniform float _CATEGORYSPECIALEFFECTS;
				uniform float _CATEGORYLIGHTING;
				uniform float _CATEGORYSPACELIGHTING;
				uniform sampler3D _LUT;
				uniform half4 _Color;
				uniform sampler2D _MainTex;
				uniform float _Metallic;
				uniform sampler2D _MetallicMap;
				uniform float _Glossiness;
				uniform sampler2D _GlossinessMap;
				uniform sampler2D _BumpMap;
				uniform float _LightGroupMask;
				uniform float _IsDynamicMesh;
				uniform float _ProbeIndex;
				uniform float3 _EmissionColor;
				uniform sampler2D _EmissionMap;
				uniform float _EmissionIntensity;
				uniform float _MaskClipValue;


				
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
					
					o.ase_texcoord = v.ase_texcoord;
					o.ase_texcoord1.xy = v.ase_texcoord2.xy;
					
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

					float3 _Vector0 = float3(0,0,0);
					float localLayeredLightmapLighting97_g60082 = ( 0.0 );
					float2 texCoord2357_g60077 = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
					float2 MainUV2420_g60077 = texCoord2357_g60077;
					float2 texCoord2594_g60077 = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
					float2 UV_Decal2595_g60077 = texCoord2594_g60077;
					#if defined( _UV_UV0 )
					float2 staticSwitch3313_g60077 = MainUV2420_g60077;
					#elif defined( _UV_UV2 )
					float2 staticSwitch3313_g60077 = UV_Decal2595_g60077;
					#else
					float2 staticSwitch3313_g60077 = UV_Decal2595_g60077;
					#endif
					float4 temp_output_3155_0_g60077 = ( _Color * tex2D( _MainTex, staticSwitch3313_g60077 ) );
					float3 oAlbedo6_g60077 = (temp_output_3155_0_g60077).rgb;
					float3 Color97_g60082 = oAlbedo6_g60077;
					#if defined( _UV_UV0 )
					float2 staticSwitch2671_g60077 = MainUV2420_g60077;
					#elif defined( _UV_UV2 )
					float2 staticSwitch2671_g60077 = UV_Decal2595_g60077;
					#else
					float2 staticSwitch2671_g60077 = UV_Decal2595_g60077;
					#endif
					#ifdef _METALLICMAP
					float staticSwitch846_g60077 = tex2D( _MetallicMap, staticSwitch2671_g60077 ).r;
					#else
					float staticSwitch846_g60077 = _Metallic;
					#endif
					float Metallic1239_g60077 = staticSwitch846_g60077;
					float Metallic97_g60082 = Metallic1239_g60077;
					#if defined( _UV_UV0 )
					float2 staticSwitch2644_g60077 = MainUV2420_g60077;
					#elif defined( _UV_UV2 )
					float2 staticSwitch2644_g60077 = UV_Decal2595_g60077;
					#else
					float2 staticSwitch2644_g60077 = UV_Decal2595_g60077;
					#endif
					#ifdef _GLOSSINESSMAP
					float staticSwitch845_g60077 = tex2D( _GlossinessMap, staticSwitch2644_g60077 ).r;
					#else
					float staticSwitch845_g60077 = _Glossiness;
					#endif
					float temp_output_19_0_g60079 = staticSwitch845_g60077;
					float Roughness21_g60079 = temp_output_19_0_g60079;
					float Metallic21_g60079 = Metallic1239_g60077;
					#if defined( _UV_UV0 )
					float2 staticSwitch3312_g60077 = MainUV2420_g60077;
					#elif defined( _UV_UV2 )
					float2 staticSwitch3312_g60077 = UV_Decal2595_g60077;
					#else
					float2 staticSwitch3312_g60077 = UV_Decal2595_g60077;
					#endif
					#ifdef _BUMPMAP
					float3 staticSwitch980_g60077 = UnpackScaleNormal( tex2D( _BumpMap, staticSwitch3312_g60077 ), 1.0 );
					#else
					float3 staticSwitch980_g60077 = float3( 0, 0, 1 );
					#endif
					float3 normalizeResult2878_g60077 = normalize( staticSwitch980_g60077 );
					float3 Normal700_g60077 = normalizeResult2878_g60077;
					float3 ase_tangentWS = IN.ase_texcoord2.xyz;
					float3 ase_normalWS = IN.ase_texcoord3.xyz;
					float3 ase_bitangentWS = IN.ase_texcoord4.xyz;
					float3 tanToWorld0 = float3( ase_tangentWS.x, ase_bitangentWS.x, ase_normalWS.x );
					float3 tanToWorld1 = float3( ase_tangentWS.y, ase_bitangentWS.y, ase_normalWS.y );
					float3 tanToWorld2 = float3( ase_tangentWS.z, ase_bitangentWS.z, ase_normalWS.z );
					float3 tanNormal2504_g60077 = Normal700_g60077;
					float3 worldNormal2504_g60077 = normalize( float3( dot( tanToWorld0, tanNormal2504_g60077 ), dot( tanToWorld1, tanNormal2504_g60077 ), dot( tanToWorld2, tanNormal2504_g60077 ) ) );
					float3 World_Normal2508_g60077 = worldNormal2504_g60077;
					float3 WorldNormal21_g60079 = World_Normal2508_g60077;
					float localGeometricAA21_g60079 = GeometricAA( Roughness21_g60079 , Metallic21_g60079 , WorldNormal21_g60079 );
					#ifdef _USEGEOMETRICAA_ON
					float staticSwitch15_g60079 = localGeometricAA21_g60079;
					#else
					float staticSwitch15_g60079 = temp_output_19_0_g60079;
					#endif
					float Roughness1399_g60077 = staticSwitch15_g60079;
					float Roughness97_g60082 = Roughness1399_g60077;
					float3 ase_positionWS = IN.ase_texcoord5.xyz;
					float3 ase_viewVectorWS = ( ( unity_OrthoParams.w == 0 ) ? _WorldSpaceCameraPos - ase_positionWS : UNITY_MATRIX_V[ 2 ].xyz );
					float3 ase_viewDirWS = normalize( ase_viewVectorWS );
					float3 View_Direction2511_g60077 = ase_viewDirWS;
					float3 ViewDir97_g60082 = View_Direction2511_g60077;
					float3 World_Position2505_g60077 = ase_positionWS;
					float3 WorldPos97_g60082 = World_Position2505_g60077;
					float3 Default_Normal3336_g60077 = ase_normalWS;
					float3 DefaultNormal97_g60082 = Default_Normal3336_g60077;
					float3 WorldNormal97_g60082 = World_Normal2508_g60077;
					float2 MainUV97_g60082 = MainUV2420_g60077;
					float4 texCoord2426_g60077 = IN.ase_texcoord;
					texCoord2426_g60077.xy = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
					float2 LightmapUV2361_g60077 = (texCoord2426_g60077).zw;
					float2 LightmapUV97_g60082 = LightmapUV2361_g60077;
					float LightGroupMask97_g60082 = _LightGroupMask;
					float IsDynamicMesh97_g60082 = _IsDynamicMesh;
					float ProbeIndex97_g60082 = _ProbeIndex;
					float3 Diffuse97_g60082 = float3( 0,0,0 );
					float3 Specular97_g60082 = float3( 0,0,0 );
					float3 Reflection97_g60082 = float3( 0,0,0 );
					LayeredLightmapLighting( Color97_g60082 , Metallic97_g60082 , Roughness97_g60082 , ViewDir97_g60082 , WorldPos97_g60082 , DefaultNormal97_g60082 , WorldNormal97_g60082 , MainUV97_g60082 , LightmapUV97_g60082 , LightGroupMask97_g60082 , IsDynamicMesh97_g60082 , ProbeIndex97_g60082 , Diffuse97_g60082 , Specular97_g60082 , Reflection97_g60082 );
					#ifdef _DIFFUSE_ON
					float3 staticSwitch3319_g60077 = Diffuse97_g60082;
					#else
					float3 staticSwitch3319_g60077 = _Vector0;
					#endif
					float3 Diffuse2560_g60077 = staticSwitch3319_g60077;
					#ifdef _SPECULARS_ON
					float3 staticSwitch3317_g60077 = Specular97_g60082;
					#else
					float3 staticSwitch3317_g60077 = _Vector0;
					#endif
					float3 Speculars3240_g60077 = staticSwitch3317_g60077;
					#ifdef _REFLECTIONS_ON
					float3 staticSwitch3318_g60077 = Reflection97_g60082;
					#else
					float3 staticSwitch3318_g60077 = _Vector0;
					#endif
					float3 Reflections1419_g60077 = staticSwitch3318_g60077;
					#if defined( _EMISSIONUV_UV0 )
					float2 staticSwitch2642_g60077 = MainUV2420_g60077;
					#elif defined( _EMISSIONUV_UV2 )
					float2 staticSwitch2642_g60077 = UV_Decal2595_g60077;
					#else
					float2 staticSwitch2642_g60077 = MainUV2420_g60077;
					#endif
					float3 Emission86_g60077 = ( _EmissionColor * tex2D( _EmissionMap, staticSwitch2642_g60077 ).rgb * _EmissionIntensity );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch1_g60078 = float4( ( Diffuse2560_g60077 + Reflections1419_g60077 + Emission86_g60077 ) , 0.0 );
					#else
					float4 staticSwitch1_g60078 = float4( ( Diffuse2560_g60077 + Speculars3240_g60077 + Reflections1419_g60077 + Emission86_g60077 ) , 0.0 );
					#endif
					float4 Color357_g60080 = staticSwitch1_g60078;
					float4 LUT51_g60080 = tex3D( _LUT, ( ( log10( ( ( (Color357_g60080).xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 ) );
					#ifdef SHADER_API_MOBILE
					float4 staticSwitch359_g60080 = LUT51_g60080;
					#else
					float4 staticSwitch359_g60080 = Color357_g60080;
					#endif
					

					float3 Color = staticSwitch359_g60080.xyz;
					float Alpha = temp_output_3155_0_g60077.a;
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
Version=19912
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":3021,"pos":[256,-1024],"params":["Inherit","False","Property","_Offset","Offset","36","0","Create","True","0","0","0","True","0","False","Object","-1","","0","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":3040,"pos":[192,-1200],"params":["Inherit","False","Meenphie","0","","60077","5cc94f8f8e02d10598af4792603e1e57","6,1008,1,2619,1,3311,1,2632,1,2670,1,2635,1","0","3","FLOAT4","624","FLOAT","156","FLOAT","427"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":3029,"pos":[512,-1200],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","7","New Amplify Shader","0770190933193b94aaa3065e307002fa","True","ExtraPrePass","0","0","ExtraPrePass","6","False","True","1","1","False","","0","False","","1","1","False","","0","False","","True","1","False","","1","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","False","False","False","True","1","RenderType=Opaque=RenderType","True","3","True","12","all","0","False","True","1","1","False","","0","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","False","True","1","LightMode=ForwardBase","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":3030,"pos":[512,-1200],"params":["Float","False","True","-1","3","AmplifyShaderEditor.MaterialInspector","0","7","Meenphie/Standard/Transparent/Cutout","0770190933193b94aaa3065e307002fa","True","Unlit","0","1","Unlit","8","False","True","1","1","False","","0","False","","1","1","False","","0","False","","True","1","False","","1","False","","False","False","False","False","False","False","False","False","False","True","0","False","","True","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","False","False","False","True","2","RenderType=Transparent=RenderType","Queue=Transparent=Queue=0","True","5","True","5","d3d11","glcore","gles3","metal","vulkan","0","False","True","1","5","False","","10","False","","1","1","False","","10","False","","True","1","False","","1","False","","False","False","False","False","False","False","False","False","False","False","True","True","2","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","True","True","0","False","","True","3","False","","True","True","0","True","_Offset","0","True","_Offset","False","True","1","LightMode=ForwardBase","False","False","0","","0","0","Standard","10","Surface","1","639175543355264160","  Keep Alpha","0","0","  Blend","0","0","Alpha Clipping","1","639175543365250740","  Use Shadow Threshold","0","0","Cast Shadows","0","639175543372870430","Write Depth","0","0","  Conservative","0","0","Extra Pre Pass","0","0","Vertex Position","1","0","0","3","False","True","False","False","","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":3031,"pos":[512,-1200],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","7","New Amplify Shader","0770190933193b94aaa3065e307002fa","True","ShadowCaster","0","2","ShadowCaster","0","False","True","1","1","False","","0","False","","1","1","False","","0","False","","True","1","False","","1","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","False","False","False","True","1","RenderType=Opaque=RenderType","True","3","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","False","","True","3","False","","False","False","True","1","LightMode=ShadowCaster","False","False","0","","0","0","Standard","0","False","0"]}
{"wire":[3030,0,3040,624]}
{"wire":[3030,7,3040,156]}
{"wire":[3030,8,3040,427]}
ASEEND*/
//CHKSM=735A11B0BC231C0FC42DEDF1E83BECF8843F8305