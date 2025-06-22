// Made with Amplify Shader Editor v1.9.8.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Skybox Cubemap"
{
	Properties
	{
		[Gamma][Header(Cubemap)]_TintColor("Tint Color", Color) = (0.5,0.5,0.5,1)
		_Exposure("Exposure", Range( 0 , 8)) = 1
		[NoScaleOffset]_Tex("Cubemap (HDR)", CUBE) = "black" {}
		[Header(Rotation)][Toggle(_ENABLEROTATION_ON)] _EnableRotation("Enable Rotation", Float) = 0
		[IntRange]_Rotation("Rotation", Range( 0 , 360)) = 0
		_RotationSpeed("Rotation Speed", Float) = 1
		[HideInInspector]_Tex_HDR("DecodeInstructions", Vector) = (0,0,0,0)
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Background"  "Queue" = "Background+0" "IgnoreProjector" = "True" "ForceNoShadowCasting" = "True" "IsEmissive" = "true"  }
		Cull Off
		ZWrite Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 2.0
		#pragma shader_feature_local _ENABLEROTATION_ON
		#define ASE_VERSION 19801
		#pragma surface surf Unlit keepalpha noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		struct Input
		{
			float3 vertexToFrag774;
			float3 worldPos;
		};

		uniform half4 _Tex_HDR;
		uniform samplerCUBE _Tex;
		uniform half _Rotation;
		uniform half _RotationSpeed;
		uniform half4 _TintColor;
		uniform half _Exposure;


		inline half3 DecodeHDR1189( float4 Data )
		{
			return DecodeHDR(Data, _Tex_HDR);
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_positionWS = mul( unity_ObjectToWorld, v.vertex );
			float lerpResult268 = lerp( 1.0 , ( unity_OrthoParams.y / unity_OrthoParams.x ) , unity_OrthoParams.w);
			half CAMERA_MODE300 = lerpResult268;
			float3 appendResult1129 = (float3(ase_positionWS.x , ( ase_positionWS.y * CAMERA_MODE300 ) , ase_positionWS.z));
			float3 normalizeResult1130 = normalize( appendResult1129 );
			float3 appendResult56 = (float3(cos( radians( ( _Rotation + ( _Time.y * _RotationSpeed ) ) ) ) , 0.0 , ( sin( radians( ( _Rotation + ( _Time.y * _RotationSpeed ) ) ) ) * -1.0 )));
			float3 appendResult266 = (float3(0.0 , CAMERA_MODE300 , 0.0));
			float3 appendResult58 = (float3(sin( radians( ( _Rotation + ( _Time.y * _RotationSpeed ) ) ) ) , 0.0 , cos( radians( ( _Rotation + ( _Time.y * _RotationSpeed ) ) ) )));
			float3 normalizeResult247 = normalize( ase_positionWS );
			#ifdef _ENABLEROTATION_ON
				float3 staticSwitch1164 = mul( float3x3(appendResult56, appendResult266, appendResult58), normalizeResult247 );
			#else
				float3 staticSwitch1164 = normalizeResult1130;
			#endif
			o.vertexToFrag774 = staticSwitch1164;
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			half4 Data1189 = texCUBE( _Tex, i.vertexToFrag774 );
			half3 localDecodeHDR1189 = DecodeHDR1189( Data1189 );
			half4 CUBEMAP222 = ( float4( localDecodeHDR1189 , 0.0 ) * unity_ColorSpaceDouble * _TintColor * _Exposure );
			o.Emission = CUBEMAP222.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19801
Node;AmplifyShaderEditor.CommentaryNode;1180;-946,1486;Inherit;False;2411;608;Cubemap Coordinates;26;260;701;255;48;276;47;62;1080;59;1081;365;55;310;61;60;58;56;266;1127;238;1128;1129;54;247;49;1130;CUBEMAP;0,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;260;-896,1792;Half;False;Property;_RotationSpeed;Rotation Speed;6;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;701;-896,1664;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-896,1536;Half;False;Property;_Rotation;Rotation;5;1;[IntRange];Create;True;0;0;0;False;0;False;0;0;0;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;255;-640,1664;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;431;-940.4822,846.6917;Inherit;False;860;219;Switch between Perspective / Orthographic camera;4;268;309;267;1007;CAMERA MODE;1,0,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;276;-512,1536;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OrthoParams;267;-892.4822,894.6918;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RadiansOpNode;47;-384,1536;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1007;-444.4821,894.6918;Half;False;Constant;_Float7;Float 7;47;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;309;-588.4823,894.6918;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;62;-224,1792;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;432;-44.48222,846.6917;Inherit;False;305;165;CAMERA MODE OUTPUT;1;300;;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.LerpOp;268;-252.4821,894.6918;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0.5;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1080;128,1664;Half;False;Constant;_Float26;Float 26;50;0;Create;True;0;0;0;False;0;False;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;59;128,1600;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;300;3.51777,894.6918;Half;False;CAMERA_MODE;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;60;320,1600;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;310;128,1760;Inherit;False;300;CAMERA_MODE;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1081;128,1840;Half;False;Constant;_Float27;Float 27;50;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;365;128,1984;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;61;128,1920;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1127;768,1936;Inherit;False;300;CAMERA_MODE;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;55;128,1536;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;238;768,1760;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;56;512,1536;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1128;1024,1920;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;266;512,1728;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;58;512,1920;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.MatrixFromVectors;54;768,1536;Inherit;False;FLOAT3x3;True;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.NormalizeNode;247;1024,1664;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;1129;1152,1792;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;49;1280,1616;Inherit;False;2;2;0;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;1087;1552,1664;Inherit;False;394;188;Enable Clouds Rotation;1;1164;;0,1,0.4980392,1;0;0
Node;AmplifyShaderEditor.NormalizeNode;1130;1280,1792;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;1183;1998,1678;Inherit;False;265;160;Per Vertex;1;774;;1,0,1,1;0;0
Node;AmplifyShaderEditor.StaticSwitch;1164;1600,1728;Float;False;Property;_EnableRotation;Enable Rotation;4;0;Create;True;0;0;0;False;1;Header(Rotation);False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;1191;2382,1486;Inherit;False;1115;565;Base;7;41;1173;1175;1174;1177;1190;1189;;0,0.4980392,1,1;0;0
Node;AmplifyShaderEditor.VertexToFragmentNode;774;2048,1728;Inherit;False;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;41;2432,1536;Inherit;True;Property;_Tex;Cubemap (HDR);3;1;[NoScaleOffset];Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;black;LockedToCube;False;Object;-1;Auto;Cube;8;0;SAMPLERCUBE;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.ColorSpaceDouble;1175;2816,1616;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CustomExpressionNode;1189;2816,1536;Half;False;DecodeHDR(Data, _Tex_HDR);3;Create;1;True;Data;FLOAT4;0,0,0,0;In;;Float;False;DecodeHDR;True;False;0;;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1177;2816,1968;Half;False;Property;_Exposure;Exposure;2;0;Create;True;0;0;0;False;0;False;1;0.7;0;8;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1173;2816,1792;Half;False;Property;_TintColor;Tint Color;1;1;[Gamma];Create;True;0;0;0;False;1;Header(Cubemap);False;0.5,0.5,0.5,1;0.5,0.5,0.5,1;False;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.CommentaryNode;915;3664,1488;Inherit;False;293;165;CUBEMAP OUTPUT;1;222;;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1174;3328,1536;Inherit;False;4;4;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;222;3712,1536;Half;False;CUBEMAP;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector4Node;1190;2432,1792;Half;False;Property;_Tex_HDR;DecodeInstructions;7;1;[HideInInspector];Create;False;0;0;0;True;0;False;0,0,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;228;-240,112;Inherit;False;222;CUBEMAP;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;26;128,64;Float;False;True;-1;0;AmplifyShaderEditor.MaterialInspector;0;0;Unlit;Meenphie/Skybox Cubemap;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;True;False;False;False;False;False;Off;2;False;;0;False;;False;0;False;;0;False;;False;0;Custom;0;True;False;0;True;Background;;Background;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;255;0;701;0
WireConnection;255;1;260;0
WireConnection;276;0;48;0
WireConnection;276;1;255;0
WireConnection;47;0;276;0
WireConnection;309;0;267;2
WireConnection;309;1;267;1
WireConnection;62;0;47;0
WireConnection;268;0;1007;0
WireConnection;268;1;309;0
WireConnection;268;2;267;4
WireConnection;59;0;62;0
WireConnection;300;0;268;0
WireConnection;60;0;59;0
WireConnection;60;1;1080;0
WireConnection;365;0;62;0
WireConnection;61;0;62;0
WireConnection;55;0;62;0
WireConnection;56;0;55;0
WireConnection;56;1;1081;0
WireConnection;56;2;60;0
WireConnection;1128;0;238;2
WireConnection;1128;1;1127;0
WireConnection;266;0;1081;0
WireConnection;266;1;310;0
WireConnection;266;2;1081;0
WireConnection;58;0;61;0
WireConnection;58;1;1081;0
WireConnection;58;2;365;0
WireConnection;54;0;56;0
WireConnection;54;1;266;0
WireConnection;54;2;58;0
WireConnection;247;0;238;0
WireConnection;1129;0;238;1
WireConnection;1129;1;1128;0
WireConnection;1129;2;238;3
WireConnection;49;0;54;0
WireConnection;49;1;247;0
WireConnection;1130;0;1129;0
WireConnection;1164;1;1130;0
WireConnection;1164;0;49;0
WireConnection;774;0;1164;0
WireConnection;41;1;774;0
WireConnection;1189;0;41;0
WireConnection;1174;0;1189;0
WireConnection;1174;1;1175;0
WireConnection;1174;2;1173;0
WireConnection;1174;3;1177;0
WireConnection;222;0;1174;0
WireConnection;26;2;228;0
ASEEND*/
//CHKSM=20F47DA193D05303289804B28C05FF980EDA739D