// Made with Amplify Shader Editor v1.9.9.14
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Standard/Transparent/Alpha"
{
	Properties
	{
		[Meenphie_DrawerCategory(SURFACE OPTIONS,true,0,0)] _CATEGORY_SURFACEOPTIONS( "CATEGORY_SURFACEOPTIONS", Float ) = 1
		_DiffuseColor( "Diffuse Color", Color ) = ( 0.9058824, 0.9058824, 0.9058824, 1 )
		[NoScaleOffset][SingleLineTexture] _MainTex( "Diffuse Map", 2D ) = "white" {}
		[NoScaleOffset][SingleLineTexture] _BumpMap( "Normal", 2D ) = "bump" {}
		[NoScaleOffset][SingleLineTexture] _MetallicMap( "Metallic", 2D ) = "black" {}
		[NoScaleOffset][SingleLineTexture] _GlossinessMap( "Roughness", 2D ) = "black" {}
		_Metallic( "Metallic", Range( 0, 1 ) ) = 0
		_Glossiness( "Roughness", Range( 0, 1 ) ) = 0.5
		_Anisotropy( "Anisotropy", Range( -1, 1 ) ) = 0
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESURFACEOPTIONS( "CATEGORY SPACE SURFACEOPTIONS", Float ) = 0
		[Meenphie_DrawerCategory(EMISSION,true,0,0)] _CATEGORYEMISSION( "CATEGORY EMISSION", Float ) = 0
		[NoScaleOffset][SingleLineTexture] _EmissionMap( "Emission", 2D ) = "white" {}
		[Gamma] _EmissionColor( "Emission Color", Color ) = ( 1, 1, 1 )
		_EmissionIntensity( "Emission Intensity", Float ) = 0
		[Meenphie_DrawerEmissionFlags] _EmissionFlags( "Global Illumination", Float ) = 2
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACEEMISSION( "CATEGORY SPACE EMISSION", Float ) = 0
		[Meenphie_DrawerCategory(SUBSURFACE SCATTERING,true,0,0)] _CATEGORYSUBSURFACESCATTERING( "CATEGORYSUBSURFACE SCATTERING", Float ) = 0
		_SubsurfaceColor( "Subsurface Color", Color ) = ( 1, 0.4196078, 0.3686275, 0 )
		_Thickness( "Thickness", Range( 0, 1 ) ) = 0
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESUBSURFACESCATTERING( "CATEGORYSPACESUBSURFACE SCATTERING", Float ) = 0
		[Meenphie_DrawerCategory(LIGHTMAPPING,true,0,0)] _CATEGORYLIGHTING( "CATEGORY LIGHTING", Float ) = 0
		[Toggle( _DIFFUSE_ON )] _Diffuse( "Diffuse", Float ) = 1
		[Toggle( _SPECULARS_ON )] _Speculars( "Speculars", Float ) = 1
		[Toggle( _REFLECTIONS_ON )] _Reflections( "Reflections", Float ) = 1
		[HideInInspector] _LightGroupMask( "Light Group Mask", Float ) = 0
		[Toggle] _IsDynamicMesh( "Is Dynamic Mesh", Float ) = 0
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACELIGHTING( "CATEGORY SPACE LIGHTING", Float ) = 0
		[Meenphie_DrawerCategory(COLOR GRADING,true,0,0)] _CATEGORYCOLORGRADING( "CATEGORY COLOR GRADING", Float ) = 0
		[NoScaleOffset][SingleLineTexture] _LUT( "LUT", 3D ) = "white" {}
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACECOLORGRADING( "CATEGORY SPACE COLOR GRADING", Float ) = 0
		[Meenphie_DrawerCategory(SPECIAL EFFECTS,true,0,0)] _CATEGORYSPECIALEFFECTS( "CATEGORY SPECIAL EFFECTS", Float ) = 0
		[Meenphie_DrawerCategorySpace(10)] _CATEGORYSPACESPECIALEFFECTS( "CATEGORY SPACE SPECIAL EFFECTS", Float ) = 0
		_Offset( "Offset", Float ) = 0
		[HideInInspector] GenKey__MetallicMap( "Assign keyword _METALLICMAP", Float ) = 1.0
		[HideInInspector] GenKey__BumpMap( "Assign keyword _BUMPMAP", Float ) = 1.0
		[HideInInspector] GenKey__GlossinessMap( "Assign keyword _GLOSSINESSMAP", Float ) = 1.0

	}
	
	SubShader
	{
		

		

		Tags { "RenderType"="Transparent" "Queue"="Transparent" }

	LOD 0

		ZWrite On
		ZClip True
		Cull Back
		AlphaToMask Off
		ColorMask RGBA
		Blend One Zero, One Zero
		BlendOp Add, Add
		Offset [_Offset] , [_Offset]

		

		Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
		

		CGINCLUDE
			#pragma target 4.5
			#pragma only_renderers d3d11 gles3 metal vulkan // ensure rendering platforms toggle list is visible

			#ifndef GLOBAL_HEADER_INCLUDED
			#define GLOBAL_HEADER_INCLUDED
			float4 ComputeClipSpacePosition( float2 screenPosNorm, float deviceDepth )
			{
				float4 positionCS = float4( screenPosNorm * 2.0 - 1.0, deviceDepth, 1.0 );
			#if UNITY_UV_STARTS_AT_TOP
				positionCS.y = -positionCS.y;
			#endif
				return positionCS;
			}
			#endif
		ENDCG

		
		Pass
		{
			
			Name "Unlit"

			Cull Back
			ZWrite Off
			ZTest LEqual
			Offset [_Offset] , [_Offset]
			ColorMask RGBA
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			

			

			CGPROGRAM
				#define ASE_SURFACE_TRANSPARENT
				#define ASE_VERSION 19914
				#define ASE_USING_SAMPLING_MACROS 1

				#pragma vertex vert
				#pragma fragment frag
				#pragma multi_compile_instancing
				#include "UnityCG.cginc"

				#include "Packages/com.meenphie.lighting/Commons/Shaders/Custom Expressions/LayeredLightmapLighting.cginc"
				#define ASE_NEEDS_TEXTURE_COORDINATES2
				#define ASE_NEEDS_TEXTURE_COORDINATES3
				#define ASE_NEEDS_VERT_TANGENT
				#define ASE_NEEDS_VERT_NORMAL
				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#define ASE_NEEDS_TEXTURE_COORDINATES7
				#pragma shader_feature_local _DIFFUSE_ON
				#pragma shader_feature_local _BUMPMAP
				#pragma shader_feature_local _METALLICMAP
				#pragma shader_feature_local _GLOSSINESSMAP
				#pragma shader_feature_local _SPECULARS_ON
				#pragma shader_feature_local _REFLECTIONS_ON
				#pragma shader_feature_local __ _UDON_MESH_ARRAYS_ON
				#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
				#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
				#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex.SampleBias(samplerTex,coord,bias)
				#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex.SampleGrad(samplerTex,coord,ddx,ddy)
				#define SAMPLE_TEXTURE3D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
				#else//ASE Sampling Macros
				#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
				#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex2Dlod(tex,float4(coord,0,lod))
				#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex2Dbias(tex,float4(coord,0,bias))
				#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex2Dgrad(tex,coord,ddx,ddy)
				#define SAMPLE_TEXTURE3D(tex,samplerTex,coord) tex3D(tex,coord)
				#endif//ASE Sampling Macros
				


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
					float4 ase_texcoord3 : TEXCOORD3;
					float4 ase_texcoord : TEXCOORD0;
					float4 ase_texcoord7 : TEXCOORD7;
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
					float4 ase_texcoord6 : TEXCOORD6;
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
				uniform float _CATEGORYSPECIALEFFECTS;
				uniform float _CATEGORYLIGHTING;
				uniform float _CATEGORYSPACELIGHTING;
				uniform float _CATEGORYSUBSURFACESCATTERING;
				uniform float _CATEGORYSPACESUBSURFACESCATTERING;
				uniform float _CATEGORYSPACESPECIALEFFECTS;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MetallicMap);
				SamplerState sampler_MetallicMap;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_GlossinessMap);
				SamplerState sampler_GlossinessMap;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_BumpMap);
				SamplerState sampler_BumpMap;
				uniform half4 _DiffuseColor;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MainTex);
				SamplerState sampler_MainTex;
				uniform float _Metallic;
				uniform float _Glossiness;
				uniform float _Anisotropy;
				uniform float3 _EmissionColor;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_EmissionMap);
				SamplerState sampler_EmissionMap;
				uniform float _EmissionIntensity;
				uniform float4 _SubsurfaceColor;
				uniform float _Thickness;
				uniform float _LightGroupMask;
				uniform float _IsDynamicMesh;
				UNITY_DECLARE_TEX3D_NOSAMPLER(_LUT);
				SamplerState sampler_LUT;


				
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
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					o.ase_texcoord4.xyz = ase_positionWS;
					
					o.ase_texcoord = v.ase_texcoord2;
					o.ase_texcoord1 = v.ase_texcoord3;
					o.ase_texcoord5 = v.ase_texcoord;
					o.ase_texcoord6.xy = v.ase_texcoord7.xy;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord2.w = 0;
					o.ase_texcoord3.w = 0;
					o.ase_texcoord4.w = 0;
					o.ase_texcoord6.zw = 0;

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
					float localLayeredLightmapLighting3482_g60118 = ( 0.0 );
					float4 Diffuse_Color6_g60118 = _DiffuseColor;
					float4 DiffuseColor3482_g60118 = Diffuse_Color6_g60118;
					float4 texCoord3407_g60118 = IN.ase_texcoord;
					texCoord3407_g60118.xy = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
					float2 UV_Decal2595_g60118 = (texCoord3407_g60118).xy;
					float2 UV3499_g60118 = UV_Decal2595_g60118;
					float4 tex2DNode3476_g60118 = SAMPLE_TEXTURE2D( _MainTex, sampler_MainTex, UV3499_g60118 );
					float4 Diffuse_Map3477_g60118 = tex2DNode3476_g60118;
					float4 DiffuseMap3482_g60118 = Diffuse_Map3477_g60118;
					float4 texCoord3368_g60118 = IN.ase_texcoord1;
					texCoord3368_g60118.xy = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
					float4 break3395_g60118 = round( texCoord3368_g60118 );
					float Diffuse_Index3367_g60118 = break3395_g60118.x;
					float DiffuseIndex3482_g60118 = Diffuse_Index3367_g60118;
					float3 ase_tangentWS = IN.ase_texcoord2.xyz;
					float3 World_Tangent3448_g60118 = ase_tangentWS;
					float3 WorldTangent3482_g60118 = World_Tangent3448_g60118;
					float3 ase_normalWS = IN.ase_texcoord3.xyz;
					float3 Default_Normal3336_g60118 = ase_normalWS;
					float3 DefaultNormal3482_g60118 = Default_Normal3336_g60118;
					float2 staticSwitch980_g60118 = ( float2 )0;
					#ifdef _BUMPMAP
					{
						float3 tex2DNode830_g60118 = UnpackNormal( SAMPLE_TEXTURE2D( _BumpMap, sampler_BumpMap, UV3499_g60118 ) );
						staticSwitch980_g60118 = (tex2DNode830_g60118).xy;
					}
					#else
					{
						staticSwitch980_g60118 = float2( 0,0 );
					}
					#endif
					float2 Normal700_g60118 = staticSwitch980_g60118;
					float2 Normal3482_g60118 = Normal700_g60118;
					float Normal_Index3380_g60118 = break3395_g60118.y;
					float NormalIndex3482_g60118 = Normal_Index3380_g60118;
					float staticSwitch846_g60118 = ( float )0;
					#ifdef _METALLICMAP
					{
						float4 tex2DNode48_g60118 = SAMPLE_TEXTURE2D( _MetallicMap, sampler_MetallicMap, UV3499_g60118 );
						staticSwitch846_g60118 = tex2DNode48_g60118.r;
					}
					#else
					{
						staticSwitch846_g60118 = _Metallic;
					}
					#endif
					float Metallic1239_g60118 = staticSwitch846_g60118;
					float Metallic3482_g60118 = Metallic1239_g60118;
					float Metallic_Index3382_g60118 = break3395_g60118.z;
					float MetallicIndex3482_g60118 = Metallic_Index3382_g60118;
					float staticSwitch845_g60118 = ( float )0;
					#ifdef _GLOSSINESSMAP
					{
						float4 tex2DNode64_g60118 = SAMPLE_TEXTURE2D( _GlossinessMap, sampler_GlossinessMap, UV3499_g60118 );
						staticSwitch845_g60118 = tex2DNode64_g60118.r;
					}
					#else
					{
						staticSwitch845_g60118 = _Glossiness;
					}
					#endif
					float Roughness1399_g60118 = staticSwitch845_g60118;
					float Roughness3482_g60118 = Roughness1399_g60118;
					float Roughness_Index3379_g60118 = break3395_g60118.w;
					float RoughnessIndex3482_g60118 = Roughness_Index3379_g60118;
					float Anisotropy3482_g60118 = _Anisotropy;
					float3 Emission_Color86_g60118 = _EmissionColor;
					float3 EmissionColor3482_g60118 = Emission_Color86_g60118;
					float4 tex2DNode81_g60118 = SAMPLE_TEXTURE2D( _EmissionMap, sampler_EmissionMap, UV3499_g60118 );
					float3 Emission3416_g60118 = tex2DNode81_g60118.rgb;
					float3 Emission3482_g60118 = Emission3416_g60118;
					float Emission_Intensity3417_g60118 = _EmissionIntensity;
					float EmissionIntensity3482_g60118 = Emission_Intensity3417_g60118;
					float Emission_Index3406_g60118 = texCoord3407_g60118.z;
					float EmissionIndex3482_g60118 = Emission_Index3406_g60118;
					float3 Subsurface_Color3358_g60118 = _SubsurfaceColor.rgb;
					float3 SubsurfaceColor3482_g60118 = Subsurface_Color3358_g60118;
					float Thickness3482_g60118 = _Thickness;
					float3 ase_positionWS = IN.ase_texcoord4.xyz;
					float3 ase_viewVectorWS = ( ( unity_OrthoParams.w == 0 ) ? _WorldSpaceCameraPos - ase_positionWS : UNITY_MATRIX_V[ 2 ].xyz );
					float3 ase_viewDirWS = normalize( ase_viewVectorWS );
					float3 View_Direction2511_g60118 = ase_viewDirWS;
					float3 ViewDir3482_g60118 = View_Direction2511_g60118;
					float3 World_Position2505_g60118 = ase_positionWS;
					float3 WorldPos3482_g60118 = World_Position2505_g60118;
					float2 MainUV3482_g60118 = UV3499_g60118;
					float4 texCoord2426_g60118 = IN.ase_texcoord5;
					texCoord2426_g60118.xy = IN.ase_texcoord5.xy * float2( 1,1 ) + float2( 0,0 );
					float2 LightmapUV2361_g60118 = (texCoord2426_g60118).zw;
					float2 LightmapUV3482_g60118 = LightmapUV2361_g60118;
					float LightGroupMask3482_g60118 = _LightGroupMask;
					float IsDynamicMesh3482_g60118 = _IsDynamicMesh;
					float Material_Column3402_g60118 = round( texCoord3407_g60118 ).w;
					float MaterialColumn3482_g60118 = Material_Column3402_g60118;
					float2 texCoord3441_g60118 = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
					float Ref_lectionProbe_Assignment3442_g60118 = texCoord3441_g60118.x;
					float ReflectionProbeAssignment3482_g60118 = Ref_lectionProbe_Assignment3442_g60118;
					float3 Diffuse3482_g60118 = float3( 0,0,0 );
					float3 Specular3482_g60118 = float3( 0,0,0 );
					float3 Reflection3482_g60118 = float3( 0,0,0 );
					float3 EmissionOut3482_g60118 = float3( 0,0,0 );
					float AlphaOut3482_g60118 = 0.0;
					LayeredLightmapLighting( DiffuseColor3482_g60118 , DiffuseMap3482_g60118 , DiffuseIndex3482_g60118 , WorldTangent3482_g60118 , DefaultNormal3482_g60118 , Normal3482_g60118 , NormalIndex3482_g60118 , Metallic3482_g60118 , MetallicIndex3482_g60118 , Roughness3482_g60118 , RoughnessIndex3482_g60118 , Anisotropy3482_g60118 , EmissionColor3482_g60118 , Emission3482_g60118 , EmissionIntensity3482_g60118 , EmissionIndex3482_g60118 , SubsurfaceColor3482_g60118 , Thickness3482_g60118 , ViewDir3482_g60118 , WorldPos3482_g60118 , MainUV3482_g60118 , LightmapUV3482_g60118 , LightGroupMask3482_g60118 , IsDynamicMesh3482_g60118 , MaterialColumn3482_g60118 , ReflectionProbeAssignment3482_g60118 , Diffuse3482_g60118 , Specular3482_g60118 , Reflection3482_g60118 , EmissionOut3482_g60118 , AlphaOut3482_g60118 );
					#ifdef _DIFFUSE_ON
					float3 staticSwitch3319_g60118 = Diffuse3482_g60118;
					#else
					float3 staticSwitch3319_g60118 = _Vector0;
					#endif
					#ifdef _SPECULARS_ON
					float3 staticSwitch3317_g60118 = Specular3482_g60118;
					#else
					float3 staticSwitch3317_g60118 = _Vector0;
					#endif
					#ifdef _REFLECTIONS_ON
					float3 staticSwitch3318_g60118 = Reflection3482_g60118;
					#else
					float3 staticSwitch3318_g60118 = _Vector0;
					#endif
					float3 Color357_g60119 = ( staticSwitch3319_g60118 + staticSwitch3317_g60118 + staticSwitch3318_g60118 + EmissionOut3482_g60118 );
					float3 staticSwitch359_g60119 = ( float3 )0;
					#ifdef SHADER_API_MOBILE
					{
						float3 LUT51_g60119 = SAMPLE_TEXTURE3D( _LUT, sampler_LUT, ( ( log10( ( ( Color357_g60119 * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 ) ).rgb;
						staticSwitch359_g60119 = LUT51_g60119;
					}
					#else
					{
						staticSwitch359_g60119 = Color357_g60119;
					}
					#endif
					

					float3 Color = staticSwitch359_g60119;
					float Alpha = AlphaOut3482_g60118;
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
Version=19914
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":3057,"pos":[256,-1024],"params":["Inherit","False","Property","_Offset","Offset","35","0","Create","True","0","0","0","True","0","False","Object","-1","","0","-1","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":3122,"pos":[192,-1200],"params":["Inherit","False","Meenphie","0","","60118","5cc94f8f8e02d10598af4792603e1e57","2,3498,1,1008,0","0","3","FLOAT3","624","FLOAT","156","FLOAT","427"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":3076,"pos":[512,-1200],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","7","New Amplify Shader","0770190933193b94aaa3065e307002fa","True","ExtraPrePass","0","0","ExtraPrePass","6","False","True","1","1","False","","0","False","","1","1","False","","0","False","","True","1","False","","1","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","False","True","True","0","False","","0","False","","True","1","False","","True","1","RenderType=Opaque=RenderType","True","3","True","12","all","0","True","True","2","5","False","","10","False","","2","5","False","","10","False","","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","True","True","1","False","","True","3","False","","True","True","0","True","_Offset","0","True","_Offset","False","False","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":3078,"pos":[512,-1200],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","7","New Amplify Shader","0770190933193b94aaa3065e307002fa","True","ShadowCaster","0","2","ShadowCaster","0","False","True","1","1","False","","0","False","","1","1","False","","0","False","","True","1","False","","1","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","False","True","True","0","False","","0","False","","True","1","False","","True","1","RenderType=Opaque=RenderType","True","3","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","False","","True","3","False","","False","False","True","1","LightMode=ShadowCaster","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":3077,"pos":[512,-1200],"params":["Float","False","True","-1","3","AmplifyShaderEditor.MaterialInspector","0","7","Meenphie/Standard/Transparent/Alpha","0770190933193b94aaa3065e307002fa","True","Unlit","0","1","Unlit","8","True","True","2","5","False","","10","False","","2","5","False","","10","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","True","True","1","False","","False","True","True","0","True","_Offset","0","True","_Offset","True","1","False","","True","2","RenderType=Transparent=RenderType","Queue=Transparent=Queue=0","True","5","True","4","d3d11","gles3","metal","vulkan","0","True","True","2","5","False","","10","False","","2","5","False","","10","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","True","True","2","False","","True","3","False","","True","True","0","True","_Offset","0","True","_Offset","False","False","False","False","2","Include","","False","","Native","False","0","0","","Pragma","shader_feature_local __ _UDON_MESH_ARRAYS_ON","False","","Custom","False","0","0","","","0","0","Standard","10","Surface","1","639175548287131210","  Keep Alpha","0","0","  Blend","0","639300221337063160","Alpha Clipping","0","0","  Use Shadow Threshold","0","0","Cast Shadows","0","639175548306094770","Write Depth","0","0","  Conservative","0","0","Extra Pre Pass","0","0","Vertex Position","1","0","0","3","False","True","False","False","","True","0"]}
{"wire":[3077,0,3122,624]}
{"wire":[3077,7,3122,156]}
ASEEND*/
//CHKSM=E182E59F37F22626764E725BD2CF5441A934FFC1