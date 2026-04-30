// Made with Amplify Shader Editor v1.9.9.7
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Skybox/Skybox Simple Gradient"
{
	Properties
	{
		_FogColor( "Fog Color", Color ) = ( 0, 0.8235294, 1 )
		[KeywordEnum( 2D,3D )] _LUTMode( "LUT Mode", Float ) = 1
		_LUTSize( "LUT Size", Float ) = 32
		[NoScaleOffset][SingleLineTexture] _2DLut( "2D Lut", 2D ) = "black" {}
		[NoScaleOffset][SingleLineTexture] _3DLut( "3D Lut", 3D ) = "black" {}
		_FogHeight( "Fog Height", Range( 0, 2 ) ) = 2
		_FogSmoothness( "Fog Smoothness", Range( 0.01, 1 ) ) = 0.925
		_FogFill( "Fog Fill", Range( -1, 1 ) ) = 0
		[HideInInspector] GenKey__2DLut( "Assign keyword _2DLUT", Float ) = 1.0
		[HideInInspector] GenKey__3DLut( "Assign keyword _3DLUT", Float ) = 1.0

	}

	SubShader
	{
		

		

		Tags { "RenderType"="Background" "PreviewType"="Skybox" "Queue"="Background" }

	LOD 0

		

		Blend Off
		AlphaToMask Off
		Cull Back
		ColorMask RGBA
		ZWrite Off
		ZClip True
		ZTest LEqual
		

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
				#define ASE_VERSION 19907

				#pragma vertex vert
				#pragma fragment frag
				#pragma multi_compile_instancing
				#include "UnityCG.cginc"

				#include "UnityShaderVariables.cginc"
				#pragma shader_feature_local _LUTMODE_2D _LUTMODE_3D
				#pragma shader_feature_local _2DLUT
				#pragma shader_feature_local _3DLUT


				struct appdata
				{
					float4 vertex : POSITION;
					half3 normal : NORMAL;
					
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct v2f
				{
					float4 pos : SV_POSITION;
					float4 ase_texcoord : TEXCOORD0;
					UNITY_VERTEX_INPUT_INSTANCE_ID
					UNITY_VERTEX_OUTPUT_STEREO
				};

				uniform sampler2D _2DLut;
				uniform float _LUTSize;
				uniform sampler3D _3DLut;
				uniform float3 _FogColor;
				uniform half _FogHeight;
				uniform half _FogSmoothness;
				uniform half _FogFill;


				
				v2f vert( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					o.ase_texcoord.xyz = ase_positionWS;
					
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord.w = 0;

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

					float3 color1198 = IsGammaSpace() ? float3( 0, 0, 0 ) : float3( 0, 0, 0 );
					float3 ase_positionWS = IN.ase_texcoord.xyz;
					float3 normalizeResult319 = normalize( ase_positionWS );
					float lerpResult678 = lerp( saturate( pow(  (0.0 + ( abs( normalizeResult319.y ) - 0.0 ) * ( 1.0 - 0.0 ) / ( _FogHeight - 0.0 ) ) , ( 1.0 - _FogSmoothness ) ) ) , 0.0 , _FogFill);
					half FOG_MASK359 = lerpResult678;
					float4 lerpResult317 = lerp( ( unity_AmbientEquator * float4( _FogColor , 0.0 ) ) , float4( color1198 , 0.0 ) , FOG_MASK359);
					float3 temp_output_35_0_g5 = lerpResult317.rgb;
					float3 Color353_g5 = temp_output_35_0_g5;
					#if defined( _LUTMODE_2D )
					float3 staticSwitch273_g5 = saturate( temp_output_35_0_g5 );
					#elif defined( _LUTMODE_3D )
					float3 staticSwitch273_g5 = temp_output_35_0_g5;
					#else
					float3 staticSwitch273_g5 = temp_output_35_0_g5;
					#endif
					float3 Color_Saturate49_g5 = staticSwitch273_g5;
					float Lut_Height213_g5 = _LUTSize;
					float Lut_Width216_g5 = ( _LUTSize * Lut_Height213_g5 );
					float3 appendResult214_g5 = (float3(( 1.0 / Lut_Width216_g5 ) , ( 1.0 / Lut_Height213_g5 ) , ( Lut_Height213_g5 - 1.0 )));
					float3 Scale_Offset208_g5 = appendResult214_g5;
					float2 Scale_Factor292_g5 = ( (Scale_Offset208_g5).xy * (Scale_Offset208_g5).z );
					float2 Offset299_g5 = ( (Scale_Offset208_g5).xy * 0.5 );
					float2 Adjusted_UV305_g5 = ( ( (Color_Saturate49_g5).xy * Scale_Factor292_g5 ) + Offset299_g5 );
					float Scaled_Blue280_g5 = ( (Color_Saturate49_g5).z * (Scale_Offset208_g5).z );
					float Shift288_g5 = floor( Scaled_Blue280_g5 );
					float Final_X313_g5 = ( (Adjusted_UV305_g5).x + ( Shift288_g5 * (Scale_Offset208_g5).y ) );
					float2 appendResult326_g5 = (float2(Final_X313_g5 , (Adjusted_UV305_g5).y));
					float2 Final_UV325_g5 = appendResult326_g5;
					float2 appendResult338_g5 = (float2((Scale_Offset208_g5).y , 0.0));
					float2 Offset_UV336_g5 = ( Final_UV325_g5 + appendResult338_g5 );
					float3 lerpResult333_g5 = lerp( tex2D( _2DLut, Final_UV325_g5 ).rgb , tex2D( _2DLut, Offset_UV336_g5 ).rgb , ( Scaled_Blue280_g5 - Shift288_g5 ));
					#ifdef _2DLUT
					float3 staticSwitch347_g5 = lerpResult333_g5;
					#else
					float3 staticSwitch347_g5 = Color_Saturate49_g5;
					#endif
					float3 TwoD_LUT346_g5 = staticSwitch347_g5;
					float3 RGB16_g6 = ( ( log10( ( ( Color_Saturate49_g5 * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 );
					#ifdef _3DLUT
					float3 staticSwitch194_g5 = tex3D( _3DLut, RGB16_g6 ).rgb;
					#else
					float3 staticSwitch194_g5 = Color_Saturate49_g5;
					#endif
					float3 ThreeD_LUT51_g5 = staticSwitch194_g5;
					#if defined( _LUTMODE_2D )
					float3 staticSwitch42_g5 = TwoD_LUT346_g5;
					#elif defined( _LUTMODE_3D )
					float3 staticSwitch42_g5 = ThreeD_LUT51_g5;
					#else
					float3 staticSwitch42_g5 = ThreeD_LUT51_g5;
					#endif
					#ifdef SHADER_API_MOBILE
					float3 staticSwitch41_g5 = staticSwitch42_g5;
					#else
					float3 staticSwitch41_g5 = Color353_g5;
					#endif
					

					float4 Color = float4( staticSwitch41_g5 , 0.0 );
					float Alpha = 1;
					half AlphaClipThreshold = 0.5;
					half AlphaClipThresholdShadow = 0.5;

					#if defined( ASE_DEPTH_WRITE_ON )
						outputDepth = IN.pos.z;
					#endif

					#ifdef _ALPHATEST_ON
						clip( Alpha - AlphaClipThreshold );
					#endif

					return Color;
				}
			ENDCG
		}

		
		Pass
		{
			
			Name "ShadowCaster"
			Tags { "LightMode"="ShadowCaster" }
			ZWrite On
			ZTest LEqual
			AlphaToMask Off

			CGPROGRAM
				#define ASE_VERSION 19907

				#pragma vertex vert
				#pragma fragment frag
				#pragma multi_compile_shadowcaster
				#ifndef UNITY_PASS_SHADOWCASTER
					#define UNITY_PASS_SHADOWCASTER
				#endif
				#include "HLSLSupport.cginc"
				#include "UnityShaderVariables.cginc"
				#include "UnityCG.cginc"
				#include "Lighting.cginc"
				#include "UnityPBSLighting.cginc"

				

				struct appdata
				{
					float4 vertex : POSITION;
					half3 normal : NORMAL;
					
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct v2f
				{
					V2F_SHADOW_CASTER;
					
					UNITY_VERTEX_INPUT_INSTANCE_ID
					UNITY_VERTEX_OUTPUT_STEREO
				};

				#ifdef UNITY_STANDARD_USE_DITHER_MASK
					sampler3D _DitherMaskLOD;
				#endif
				#ifdef ASE_TESSELLATION
					float _TessPhongStrength;
					float _TessValue;
					float _TessMin;
					float _TessMax;
					float _TessEdgeLength;
					float _TessMaxDisp;
				#endif

				uniform sampler2D _2DLut;
				uniform float _LUTSize;
				uniform sampler3D _3DLut;


				
				v2f vert( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID( v );
					v2f o;
					UNITY_INITIALIZE_OUTPUT( v2f, o );
					UNITY_TRANSFER_INSTANCE_ID( v, o );
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );

					

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

					TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
					return o;
				}

				half4 frag( v2f IN 
							#if defined( ASE_DEPTH_WRITE_ON )
								, out float outputDepth : SV_Depth
							#endif
							) : SV_Target
				{
					UNITY_SETUP_INSTANCE_ID(IN);

					#ifdef LOD_FADE_CROSSFADE
						UNITY_APPLY_DITHER_CROSSFADE(IN.pos.xy);
					#endif

					

					float Alpha = 1;
					half AlphaClipThreshold = 0.5;
					half AlphaClipThresholdShadow = 0.5;

					#if defined( ASE_DEPTH_WRITE_ON )
						outputDepth = IN.pos.z;
					#endif

					#ifdef _ALPHATEST_SHADOW_ON
						if (unity_LightShadowBias.z != 0.0)
							clip(Alpha - AlphaClipThresholdShadow);
						#ifdef _ALPHATEST_ON
						else
							clip(Alpha - AlphaClipThreshold);
						#endif
					#else
						#ifdef _ALPHATEST_ON
							clip(Alpha - AlphaClipThreshold);
						#endif
					#endif

					#ifdef UNITY_STANDARD_USE_DITHER_MASK
						half alphaRef = tex3D(_DitherMaskLOD, float3(IN.pos.xy*0.25,Alpha*0.9375)).a;
						clip(alphaRef - 0.01);
					#endif

					SHADOW_CASTER_FRAGMENT(IN)
				}
			ENDCG
		}
		
	}
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
	
	Fallback Off
}
/*ASEBEGIN
Version=19907
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;700;-1632,832;Inherit;False;1898;485;Fog Coords on Screen;15;318;319;320;313;325;314;315;329;677;316;678;679;1108;1109;1110;BUILT-IN FOG;0,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1167;-1568,-176;Inherit;False;802.6;557.2;;6;436;1198;1199;1197;312;317;FINAL COLOR;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;699;416,832;Inherit;False;293;165;FOG_MASK OUTPUT;1;359;;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.WorldPosInputsNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;318;-1584,880;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NormalizeNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;319;-1328,880;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;320;-1136,880;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.AbsOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;314;-816,880;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;313;-1584,1072;Half;False;Property;_FogHeight;Fog Height;6;0;Create;True;0;0;0;False;0;False;2;2;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;325;-1584,1200;Half;False;Property;_FogSmoothness;Fog Smoothness;7;0;Create;True;0;0;0;False;0;False;0.925;0.925;0.01;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1109;-816,1104;Half;False;Constant;_Float40;Float 40;55;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1108;-816,1008;Half;False;Constant;_Float39;Float 39;55;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;329;-560,1200;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;315;-624,880;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;677;-368,880;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;316;-176,880;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1110;-176,1072;Half;False;Constant;_Float41;Float 41;55;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;679;-176,1200;Half;False;Property;_FogFill;Fog Fill;8;0;Create;True;0;0;0;False;0;False;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;678;80,880;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FogAndAmbientColorsNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;312;-1520,-160;Inherit;False;unity_AmbientEquator;0;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;359;464,880;Half;False;FOG_MASK;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1197;-1488,-80;Inherit;False;Property;_FogColor;Fog Color;0;0;Create;True;0;0;0;False;0;False;0,0.8235294,1,0;0,0.8223352,1,0;True;False;0;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1199;-1216,-128;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;436;-1232,240;Inherit;False;359;FOG_MASK;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1198;-1488,80;Inherit;False;Constant;_MainColor;Main Color;0;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;False;0;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;317;-992,16;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1201;-624,16;Inherit;False;LUT;1;;5;0baaa08160114780391fed4ef3e2d57e;0;1;35;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1202;-320,16;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;4;Meenphie/Skybox/Skybox Simple Gradient;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;7;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;True;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;2;False;;True;0;False;;True;False;0;False;;0;False;;True;1;False;;True;3;RenderType=Background=RenderType;PreviewType=Skybox;Queue=Background=Queue=0;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;5;Alpha Clipping;0;0;  Use Shadow Threshold;0;0;Cast Shadows;1;0;Write Depth;0;0;Vertex Position;1;0;0;2;True;True;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1203;-320,26;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;0770190933193b94aaa3065e307002fa;True;ShadowCaster;0;1;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;False;;True;1;RenderType=Opaque=RenderType;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
WireConnection;319;0;318;0
WireConnection;320;0;319;0
WireConnection;314;0;320;1
WireConnection;329;0;325;0
WireConnection;315;0;314;0
WireConnection;315;1;1108;0
WireConnection;315;2;313;0
WireConnection;315;3;1108;0
WireConnection;315;4;1109;0
WireConnection;677;0;315;0
WireConnection;677;1;329;0
WireConnection;316;0;677;0
WireConnection;678;0;316;0
WireConnection;678;1;1110;0
WireConnection;678;2;679;0
WireConnection;359;0;678;0
WireConnection;1199;0;312;0
WireConnection;1199;1;1197;0
WireConnection;317;0;1199;0
WireConnection;317;1;1198;0
WireConnection;317;2;436;0
WireConnection;1201;35;317;0
WireConnection;1202;0;1201;0
ASEEND*/
//CHKSM=7A14F9017CADF5ED1452014813AC43DC6F4C8116