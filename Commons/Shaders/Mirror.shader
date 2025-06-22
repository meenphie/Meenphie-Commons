// Made with Amplify Shader Editor v1.9.8.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Fairplex/Mirror"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,0)
		_Metallic("Metallic", Range( 0 , 1)) = 0
		_Roughness("Roughness", Range( 0 , 1)) = 0
		_Quality("Quality", Range( 0 , 1)) = 0
		[HideInInspector]_ReflectionTex0("_ReflectionTex0", 2D) = "white" {}
		[HideInInspector]_ReflectionTex1("_ReflectionTex1", 2D) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IgnoreProjector" = "True" }
		Cull Back
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityCG.cginc"
		#include "Lighting.cginc"
		#pragma target 3.5
		#define ASE_VERSION 19801
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float3 worldNormal;
			float4 ase_positionOS4f;
			float4 uv2_texcoord2;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform float4 _Color;
		uniform float _Metallic;
		uniform float _Roughness;
		uniform sampler2D _ReflectionTex1;
		uniform sampler2D _ReflectionTex0;
		uniform float _Quality;


		float StereoEyeIndex2(  )
		{
			 return unity_StereoEyeIndex;
		}


		float2 UnStereo( float2 UV )
		{
			#if UNITY_SINGLE_PASS_STEREO
			float4 scaleOffset = unity_StereoScaleOffset[ unity_StereoEyeIndex ];
			UV.xy = (UV.xy - scaleOffset.zw) / scaleOffset.xy;
			#endif
			return UV;
		}


		float4 ProjectionCoordinates11( float4 In )
		{
			 return UNITY_PROJ_COORD(In);
		}


		float4 Tex2DProjection17( sampler2D TD, float4 F4 )
		{
			 return tex2Dproj(TD, F4);
		}


		float4 Tex2DProjection15( sampler2D TD, float4 F4 )
		{
			 return tex2Dproj(TD, F4);
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float4 ase_positionOS4f = v.vertex;
			o.ase_positionOS4f = ase_positionOS4f;
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			SurfaceOutputStandard s97 = (SurfaceOutputStandard ) 0;
			s97.Albedo = _Color.rgb;
			float3 ase_normalWS = i.worldNormal;
			float3 ase_normalWSNorm = normalize( ase_normalWS );
			s97.Normal = ase_normalWSNorm;
			s97.Emission = float3( 0,0,0 );
			s97.Metallic = _Metallic;
			s97.Smoothness = ( 1.0 - _Roughness );
			s97.Occlusion = 1.0;

			data.light = gi.light;

			UnityGI gi97 = gi;
			#ifdef UNITY_PASS_FORWARDBASE
			Unity_GlossyEnvironmentData g97 = UnityGlossyEnvironmentSetup( s97.Smoothness, data.worldViewDir, s97.Normal, float3(0,0,0));
			gi97 = UnityGlobalIllumination( data, s97.Occlusion, s97.Normal, g97 );
			#endif

			float3 surfResult97 = LightingStandard ( s97, viewDir, gi97 ).rgb;
			surfResult97 += s97.Emission;

			#ifdef UNITY_PASS_FORWARDADD//97
			surfResult97 -= s97.Emission;
			#endif//97
			float localStereoEyeIndex2 = StereoEyeIndex2();
			sampler2D TD17 = _ReflectionTex1;
			float4 ase_positionOS4f = i.ase_positionOS4f;
			float4 unityObjectToClipPos13 = UnityObjectToClipPos( ase_positionOS4f.xyz );
			float4 computeScreenPos29 = ComputeScreenPos( unityObjectToClipPos13 );
			computeScreenPos29 = computeScreenPos29 / computeScreenPos29.w;
			computeScreenPos29.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? computeScreenPos29.z : computeScreenPos29.z* 0.5 + 0.5;
			float2 UV22_g1 = computeScreenPos29.xy;
			float2 localUnStereo22_g1 = UnStereo( UV22_g1 );
			float4 appendResult28 = (float4(localUnStereo22_g1 , i.uv2_texcoord2.z , i.uv2_texcoord2.w));
			float4 In11 = appendResult28;
			float4 localProjectionCoordinates11 = ProjectionCoordinates11( In11 );
			float4 F417 = localProjectionCoordinates11;
			float4 localTex2DProjection17 = Tex2DProjection17( TD17 , F417 );
			sampler2D TD15 = _ReflectionTex0;
			float4 F415 = localProjectionCoordinates11;
			float4 localTex2DProjection15 = Tex2DProjection15( TD15 , F415 );
			float4 ifLocalVar3 = 0;
			if( localStereoEyeIndex2 == 0.0 )
				ifLocalVar3 = localTex2DProjection15;
			else
				ifLocalVar3 = localTex2DProjection17;
			float4 Mirror81 = ifLocalVar3;
			float4 lerpResult79 = lerp( float4( surfResult97 , 0.0 ) , Mirror81 , _Quality);
			c.rgb = lerpResult79.xyz;
			c.a = 1;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows exclude_path:deferred noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.5
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float4 customPack1 : TEXCOORD1;
				float4 customPack2 : TEXCOORD2;
				float3 worldPos : TEXCOORD3;
				float3 worldNormal : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.worldNormal = worldNormal;
				o.customPack1.xyzw = customInputData.ase_positionOS4f;
				o.customPack2.xyzw = customInputData.uv2_texcoord2;
				o.customPack2.xyzw = v.texcoord1;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.ase_positionOS4f = IN.customPack1.xyzw;
				surfIN.uv2_texcoord2 = IN.customPack2.xyzw;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldNormal = IN.worldNormal;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19801
Node;AmplifyShaderEditor.CommentaryNode;52;-1008,-640;Inherit;False;2399.681;860.3535;Do not edit this;13;3;17;2;15;11;22;25;28;27;26;29;13;14;Mirror Code;1,1,1,1;0;0
Node;AmplifyShaderEditor.PosVertexDataNode;14;-928,-416;Inherit;True;1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.UnityObjToClipPosHlpNode;13;-640,-336;Inherit;False;1;0;FLOAT3;0,0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComputeScreenPosHlpNode;29;-400,-304;Inherit;False;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;27;-128,-176;Inherit;False;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;26;-128,-256;Inherit;False;Non Stereo Screen Pos;-1;;1;1731ee083b93c104880efc701e11b49b;0;1;23;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;28;192,-192;Inherit;False;FLOAT4;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TexturePropertyNode;22;384,-512;Inherit;True;Property;_ReflectionTex0;_ReflectionTex0;4;1;[HideInInspector];Create;False;0;0;0;False;0;False;None;None;False;white;LockedToTexture2D;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.CustomExpressionNode;11;400,-208;Inherit;False; return UNITY_PROJ_COORD(In)@;4;Create;1;True;In;FLOAT4;0,0,0,0;In;;Inherit;False;Projection Coordinates;True;False;0;;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TexturePropertyNode;25;400,-16;Inherit;True;Property;_ReflectionTex1;_ReflectionTex1;5;1;[HideInInspector];Create;False;0;0;0;False;0;False;None;None;False;white;LockedToTexture2D;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.CustomExpressionNode;15;800,-240;Inherit;False; return tex2Dproj(TD, F4)@;4;Create;2;True;TD;SAMPLER2D;0,0,0,0;In;;Inherit;False;True;F4;FLOAT4;0,0,0,0;In;;Inherit;False;Tex2DProjection;True;False;0;;False;2;0;SAMPLER2D;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CustomExpressionNode;17;800,-128;Inherit;False; return tex2Dproj(TD, F4)@;4;Create;2;True;TD;SAMPLER2D;0,0;In;;Inherit;False;True;F4;FLOAT4;0,0,0,0;In;;Inherit;False;Tex2DProjection;True;False;0;;False;2;0;SAMPLER2D;0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CustomExpressionNode;2;800,-416;Inherit;False; return unity_StereoEyeIndex@;1;Create;0;Stereo Eye Index;True;False;0;;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;3;1136,-336;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;94;1744,-128;Inherit;False;Property;_Roughness;Roughness;2;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;81;1424,-336;Inherit;False;Mirror;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.OneMinusNode;96;2064,-128;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;95;1744,-208;Inherit;False;Property;_Metallic;Metallic;1;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;98;1808,-416;Inherit;False;Property;_Color;Color;0;0;Create;True;0;0;0;False;0;False;1,1,1,0;0.3,0.3,0.3,0;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.GetLocalVarNode;82;2272,-32;Inherit;False;81;Mirror;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CustomStandardSurface;97;2272,-272;Inherit;False;Metallic;Tangent;6;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,1;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;77;2272,64;Inherit;False;Property;_Quality;Quality;3;0;Create;False;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;79;2560,-96;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2832,-320;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;0;CustomLighting;Fairplex/Mirror;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;ForwardOnly;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;2;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;2.11;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;13;0;14;0
WireConnection;29;0;13;0
WireConnection;26;23;29;0
WireConnection;28;0;26;0
WireConnection;28;2;27;3
WireConnection;28;3;27;4
WireConnection;11;0;28;0
WireConnection;15;0;22;0
WireConnection;15;1;11;0
WireConnection;17;0;25;0
WireConnection;17;1;11;0
WireConnection;3;0;2;0
WireConnection;3;2;17;0
WireConnection;3;3;15;0
WireConnection;3;4;17;0
WireConnection;81;0;3;0
WireConnection;96;0;94;0
WireConnection;97;0;98;5
WireConnection;97;3;95;0
WireConnection;97;4;96;0
WireConnection;79;0;97;0
WireConnection;79;1;82;0
WireConnection;79;2;77;0
WireConnection;0;13;79;0
ASEEND*/
//CHKSM=150218DA1CAD52C7C795FEE254418E1FFAE54929