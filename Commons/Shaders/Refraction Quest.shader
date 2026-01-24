// Made with Amplify Shader Editor v1.9.1.6
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Fairplex/Refraction Quest"
{
	Properties
	{
		_Color("Color", Color) = (0,0,0,0)
		[SingleLineTexture]_Normalmap1("Normalmap", 2D) = "bump" {}
		_Distortion("Distortion", Range( 0 , 1)) = 0
		_Glossiness("Smoothness", Range( 0 , 1)) = 0
		_Occlusion("Occlusion", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
		[Header(Forward Rendering Options)]
		[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		[ToggleOff] _GlossyReflections("Reflections", Float) = 1.0
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "ForceNoShadowCasting" = "True" }
		Cull Back
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma shader_feature _SPECULARHIGHLIGHTS_OFF
		#pragma shader_feature _GLOSSYREFLECTIONS_OFF
		#pragma exclude_renderers xboxone xboxseries playstation ps4 switch 
		#pragma surface surf StandardCustomLighting keepalpha noshadow exclude_path:deferred noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float3 worldNormal;
			INTERNAL_DATA
			float2 uv_texcoord;
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
		uniform sampler2D _Normalmap1;
		uniform float4 _Normalmap1_ST;
		uniform float _Distortion;
		uniform float _Glossiness;
		uniform float _Occlusion;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float2 uv_Normalmap1 = i.uv_texcoord * _Normalmap1_ST.xy + _Normalmap1_ST.zw;
			float3 newWorldNormal134 = (WorldNormalVector( i , UnpackScaleNormal( tex2D( _Normalmap1, uv_Normalmap1 ), _Distortion ) ));
			float3 appendResult133 = (float3(0.0 , newWorldNormal134.y , newWorldNormal134.z));
			float3 indirectNormal123 = appendResult133;
			Unity_GlossyEnvironmentData g123 = UnityGlossyEnvironmentSetup( _Glossiness, data.worldViewDir, indirectNormal123, float3(0,0,0));
			float3 indirectSpecular123 = UnityGI_IndirectSpecular( data, 1.0, indirectNormal123, g123 );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_normWorldNormal = normalize( ase_worldNormal );
			Unity_GlossyEnvironmentData g135 = UnityGlossyEnvironmentSetup( _Glossiness, data.worldViewDir, ase_normWorldNormal, float3(0,0,0));
			float3 indirectSpecular135 = UnityGI_IndirectSpecular( data, _Occlusion, ase_normWorldNormal, g135 );
			c.rgb = ( _Color * float4( ( indirectSpecular123 + indirectSpecular135 ) , 0.0 ) ).rgb;
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
			o.Normal = float3(0,0,1);
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=19106
Node;AmplifyShaderEditor.ColorNode;63;-416,-96;Inherit;False;Property;_Color;Color;0;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.7196065,0.8744291,0.9716981,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;Fairplex/Refraction Quest;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;True;False;False;True;True;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;ForwardOnly;7;d3d11;glcore;gles;gles3;metal;vulkan;ps5;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;False;0;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.SimpleAddOpNode;136;-363.7042,287.6096;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;74;-1027.192,644.5486;Inherit;False;Property;_Occlusion;Occlusion;4;0;Create;True;0;0;0;False;0;False;0;0.036;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.IndirectSpecularLight;135;-683.1909,478.1559;Inherit;False;World;3;0;FLOAT3;0,0,1;False;1;FLOAT;1;False;2;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;72;-1016.192,420.5482;Inherit;False;Property;_Glossiness;Smoothness;3;0;Create;False;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.IndirectSpecularLight;123;-679.9414,236.956;Inherit;False;World;3;0;FLOAT3;0,0,1;False;1;FLOAT;1;False;2;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;133;-1295.787,236.5156;Inherit;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldNormalVector;134;-1673.163,219.5127;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;139;-2137.581,215.2211;Inherit;True;Property;_Normalmap1;Normalmap;1;1;[SingleLineTexture];Create;True;0;0;0;False;0;False;-1;af39c24d65f10734ab5848435c639dff;af39c24d65f10734ab5848435c639dff;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;-192.7356,154.5222;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;143;-2816,256;Inherit;False;Property;_Distortion;Distortion;2;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
WireConnection;0;13;64;0
WireConnection;136;0;123;0
WireConnection;136;1;135;0
WireConnection;135;1;72;0
WireConnection;135;2;74;0
WireConnection;123;0;133;0
WireConnection;123;1;72;0
WireConnection;133;1;134;2
WireConnection;133;2;134;3
WireConnection;134;0;139;0
WireConnection;139;5;143;0
WireConnection;64;0;63;0
WireConnection;64;1;136;0
ASEEND*/
//CHKSM=DAFF9905403E88060CCAD5EC4F4AC058434A87AF