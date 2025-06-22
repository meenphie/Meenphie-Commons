// Made with Amplify Shader Editor v1.9.8.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Fairplex/Water"
{
	Properties
	{
		_Color("Color", Color) = (0.1618085,0.3385532,0.468,0.3176471)
		[NoScaleOffset][Normal]_Normalmap("Normalmap", 2D) = "bump" {}
		_Scale("Scale", Float) = 0
		_Speed("Speed", Range( 0 , 5)) = 0.1
		_NormalStrength("Normal Strength", Range( 0 , 1)) = 0.02
		_Smoothness("Smoothness", Range( 0 , 1)) = 1
		_Metallic("Metallic", Range( 0 , 1)) = 0
		[HideInInspector] __dirty( "", Int ) = 1
		[Header(Forward Rendering Options)]
		[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		[ToggleOff] _GlossyReflections("Reflections", Float) = 1.0
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+1" "IgnoreProjector" = "True" "ForceNoShadowCasting" = "True" }
		Cull Off
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature _SPECULARHIGHLIGHTS_OFF
		#pragma shader_feature _GLOSSYREFLECTIONS_OFF
		#define ASE_VERSION 19801
		#pragma exclude_renderers xboxone xboxseries playstation ps4 switch 
		#pragma surface surf Standard alpha:premul keepalpha noshadow exclude_path:deferred noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd  
		struct Input
		{
			float3 worldPos;
		};

		uniform sampler2D _Normalmap;
		uniform float _Speed;
		uniform float _Scale;
		uniform float _NormalStrength;
		uniform float4 _Color;
		uniform float _Metallic;
		uniform float _Smoothness;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float mulTime134 = _Time.y * 0.1;
			float2 temp_cast_0 = (_Speed).xx;
			float3 ase_positionWS = i.worldPos;
			float2 appendResult520 = (float2(ase_positionWS.x , ase_positionWS.z));
			float2 _worldUV521 = ( appendResult520 / _Scale );
			float2 panner138 = ( mulTime134 * temp_cast_0 + _worldUV521);
			float2 temp_cast_1 = (_Speed).xx;
			float cos132 = cos( (float)radians( 175 ) );
			float sin132 = sin( (float)radians( 175 ) );
			float2 rotator132 = mul( _worldUV521 - float2( 1,1 ) , float2x2( cos132 , -sin132 , sin132 , cos132 )) + float2( 1,1 );
			float2 panner137 = ( mulTime134 * temp_cast_1 + rotator132);
			float3 Normals145 = BlendNormals( UnpackScaleNormal( tex2D( _Normalmap, panner138 ), _NormalStrength ) , UnpackScaleNormal( tex2D( _Normalmap, -panner137 ), _NormalStrength ) );
			o.Normal = Normals145;
			o.Albedo = _Color.rgb;
			o.Metallic = _Metallic;
			o.Smoothness = _Smoothness;
			o.Alpha = _Color.a;
		}

		ENDCG
	}
	Fallback "Fairplex/Water Quest"
}
/*ASEBEGIN
Version=19801
Node;AmplifyShaderEditor.CommentaryNode;517;-3456,-1920;Inherit;False;834;294;;5;522;521;520;519;518;World UV;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldPosInputsNode;518;-3408,-1872;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;520;-3200,-1872;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;522;-3200,-1744;Inherit;False;Property;_Scale;Scale;2;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;128;-3456,-1504;Inherit;False;2155.463;943.6183;;14;145;144;142;141;136;138;137;132;133;134;130;129;523;524;Normals;0,0.289319,1,1;0;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;519;-3024,-1872;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.IntNode;129;-3424,-976;Inherit;False;Constant;_Int0;Int 0;7;0;Create;True;0;0;0;False;0;False;175;175;False;0;1;INT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;521;-2848,-1872;Inherit;False;_worldUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RadiansOpNode;130;-3184,-976;Inherit;False;1;0;INT;0;False;1;INT;0
Node;AmplifyShaderEditor.GetLocalVarNode;523;-3312,-1344;Inherit;False;521;_worldUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;134;-3024,-1232;Inherit;False;1;0;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;133;-3088,-1424;Inherit;False;Property;_Speed;Speed;3;0;Create;True;0;0;0;False;0;False;0.1;0.5;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;132;-3024,-1120;Inherit;False;3;0;FLOAT2;10,0;False;1;FLOAT2;1,1;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;137;-2736,-1136;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;138;-2736,-1344;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;136;-3152,-848;Inherit;False;Property;_NormalStrength;Normal Strength;4;0;Create;True;0;0;0;False;0;False;0.02;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;524;-2528,-1152;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;141;-2384,-1184;Inherit;True;Property;_TextureSample3;Texture Sample 3;1;1;[HideInInspector];Create;True;0;0;0;False;0;False;-1;None;None;True;0;True;bump;Auto;True;Instance;142;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;0.5;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode;142;-2384,-1376;Inherit;True;Property;_Normalmap;Normalmap;1;2;[NoScaleOffset];[Normal];Create;True;0;0;0;False;0;False;-1;None;5cb9eae924c3a9c4a835886067ad65cb;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.BlendNormalsNode;144;-2016,-1264;Inherit;True;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;145;-1648,-1168;Inherit;False;Normals;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;509;-112,-192;Inherit;False;Property;_Color;Color;0;0;Create;False;0;0;0;False;0;False;0.1618085,0.3385532,0.468,0.3176471;1,1,1,1;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.GetLocalVarNode;469;320,-96;Inherit;False;145;Normals;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;500;224,64;Inherit;False;Property;_Smoothness;Smoothness;5;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;525;208,-16;Inherit;False;Property;_Metallic;Metallic;6;0;Create;True;0;0;0;False;0;False;0;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;640,-160;Float;False;True;-1;2;;0;0;Standard;Fairplex/Water;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;True;False;False;True;True;False;Off;2;False;;0;False;;False;0;False;;0;False;;False;7;Premultiply;0.5;True;False;1;False;Transparent;;Transparent;ForwardOnly;7;d3d11;glcore;gles;gles3;metal;vulkan;ps5;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;2;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;False;3;1;False;;10;False;;0;5;False;;10;False;;4;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;Fairplex/Water Quest;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;1;;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;520;0;518;1
WireConnection;520;1;518;3
WireConnection;519;0;520;0
WireConnection;519;1;522;0
WireConnection;521;0;519;0
WireConnection;130;0;129;0
WireConnection;132;0;523;0
WireConnection;132;2;130;0
WireConnection;137;0;132;0
WireConnection;137;2;133;0
WireConnection;137;1;134;0
WireConnection;138;0;523;0
WireConnection;138;2;133;0
WireConnection;138;1;134;0
WireConnection;524;0;137;0
WireConnection;141;1;524;0
WireConnection;141;5;136;0
WireConnection;142;1;138;0
WireConnection;142;5;136;0
WireConnection;144;0;142;0
WireConnection;144;1;141;0
WireConnection;145;0;144;0
WireConnection;0;0;509;5
WireConnection;0;1;469;0
WireConnection;0;3;525;0
WireConnection;0;4;500;0
WireConnection;0;9;509;4
ASEEND*/
//CHKSM=BB3CA951FE77C188B4C09F19A231B90BA1AF67B0