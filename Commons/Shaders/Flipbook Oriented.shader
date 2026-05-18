// Made with Amplify Shader Editor v1.9.9.9
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Sprite/Flipbook Oriented"
{
	Properties
	{
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Color ("Tint", Color) = (1,1,1,1)
		[MaterialToggle] PixelSnap ("Pixel snap", Float) = 0
		[PerRendererData] _AlphaTex ("External Alpha", 2D) = "white" {}
		[NoScaleOffset][SingleLineTexture] _BaseColor( "Base Color", 2D ) = "white" {}
		[NoScaleOffset][SingleLineTexture] _LUT( "LUT", 3D ) = "black" {}

	}

	SubShader
	{
		LOD 0

		Tags { "Queue"="Transparent+1" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" "CanUseSpriteAtlas"="True" "DisableBatching"="True" }

		Cull Off
		Lighting Off
		ZWrite Off
		Blend One One

		
		Pass
		{
		CGPROGRAM
			#define ASE_VERSION 19909

			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.5
			#pragma multi_compile _ PIXELSNAP_ON
			#pragma multi_compile _ ETC1_EXTERNAL_ALPHA
			#include "UnityCG.cginc"
			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0


			struct appdata_t
			{
				float4 vertex   : POSITION;
				float4 color    : COLOR;
				float2 texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				
			};

			struct v2f
			{
				float4 vertex   : SV_POSITION;
				fixed4 color    : COLOR;
				float2 texcoord  : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				
			};

			uniform fixed4 _Color;
			uniform float _EnableExternalAlpha;
			uniform sampler2D _MainTex;
			uniform sampler2D _AlphaTex;
			uniform sampler3D _LUT;
			uniform sampler2D _BaseColor;
			float3 LocalSprite31( float3 InPos )
			{
				// 1. Caméra en espace local
				float3 localCamPos = mul(unity_WorldToObject, float4(_WorldSpaceCameraPos, 1.0)).xyz;
				// 2. Axe de rotation (Y local du tuyau)
				float3 up = float3(0, 1, 0);
				// 3. Direction vers la caméra (projetée sur le plan XZ local)
				// On ajoute un epsilon pour éviter le normalize(0) si la caméra est pile au-dessus
				float3 forward = normalize(float3(localCamPos.x, 0, localCamPos.z) + 0.0001);
				// 4. Vecteur Right perpendiculaire
				float3 right = cross(up, forward);
				// 5. Reconstruction du vertex
				// Si ton quad est un "Plane" Unity ou un Quad Blender standard :
				// InPos.x est la largeur, InPos.y la hauteur.
				float3 rotatedPos = InPos.x * right + InPos.y * up + InPos.z * forward;
				return rotatedPos - InPos;
			}
			


			v2f vert( appdata_t IN  )
			{
				v2f OUT;
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(OUT);
				UNITY_TRANSFER_INSTANCE_ID(IN, OUT);
				float3 InPos31 = IN.vertex.xyz;
				float3 localLocalSprite31 = LocalSprite31( InPos31 );
				

				IN.vertex.xyz += localLocalSprite31;
				OUT.vertex = UnityObjectToClipPos(IN.vertex);
				OUT.texcoord = IN.texcoord;
				OUT.color = IN.color * _Color;
				#ifdef PIXELSNAP_ON
				OUT.vertex = UnityPixelSnap (OUT.vertex);
				#endif

				return OUT;
			}

			fixed4 SampleSpriteTexture (float2 uv)
			{
				fixed4 color = tex2D (_MainTex, uv);

#if ETC1_EXTERNAL_ALPHA
				// get the color from an external texture (usecase: Alpha support for ETC1 on android)
				fixed4 alpha = tex2D (_AlphaTex, uv);
				color.a = lerp (color.a, alpha.r, _EnableExternalAlpha);
#endif //ETC1_EXTERNAL_ALPHA

				return color;
			}

			fixed4 frag(v2f IN  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				float2 texCoord8 = IN.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				// *** BEGIN Flipbook UV Animation vars ***
				// Total tiles of Flipbook Texture
				float fbtotaltiles7 = min( 16.0 * 21.0, 330.0 + 1 );
				// Offsets for cols and rows of Flipbook Texture
				float fbcolsoffset7 = 1.0f / 16.0;
				float fbrowsoffset7 = 1.0f / 21.0;
				// Speed of animation
				float fbspeed7 = _Time[ 1 ] * 30.0;
				// UV Tiling (col and row offset)
				float2 fbtiling7 = float2(fbcolsoffset7, fbrowsoffset7);
				// UV Offset - calculate current tile linear index, and convert it to (X * coloffset, Y * rowoffset)
				// Calculate current tile linear index
				float fbcurrenttileindex7 = floor( fmod( fbspeed7 + 0.0, fbtotaltiles7) );
				fbcurrenttileindex7 += ( fbcurrenttileindex7 < 0) ? fbtotaltiles7 : 0;
				// Obtain Offset X coordinate from current tile linear index
				float fblinearindextox7 = round ( fmod ( fbcurrenttileindex7, 16.0 ) );
				// Multiply Offset X by coloffset
				float fboffsetx7 = fblinearindextox7 * fbcolsoffset7;
				// Obtain Offset Y coordinate from current tile linear index
				float fblinearindextoy7 = round( fmod( ( fbcurrenttileindex7 - fblinearindextox7 ) / 16.0, 21.0 ) );
				// Reverse Y to get tiles from Top to Bottom
				fblinearindextoy7 = (int)(21.0-1) - fblinearindextoy7;
				// Multiply Offset Y by rowoffset
				float fboffsety7 = fblinearindextoy7 * fbrowsoffset7;
				// UV Offset
				float2 fboffset7 = float2(fboffsetx7, fboffsety7);
				// Flipbook UV
				float2 fbuv7 = texCoord8 * fbtiling7 + fboffset7;
				// *** END Flipbook UV Animation vars ***
				int flipbookFrame7 = ( ( int )fbcurrenttileindex7);
				float4 temp_output_57_0 = ( _Color * tex2D( _BaseColor, fbuv7 ) );
				float4 Color357_g35 = temp_output_57_0;
				float4 LUT51_g35 = tex3D( _LUT, ( ( log10( ( ( (Color357_g35).xyz * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 ) );
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch359_g35 = LUT51_g35;
				#else
				float4 staticSwitch359_g35 = Color357_g35;
				#endif
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch40 = staticSwitch359_g35;
				#else
				float4 staticSwitch40 = temp_output_57_0;
				#endif
				
				fixed4 c = staticSwitch40;
				c.rgb *= c.a;
				return c;
			}
		ENDCG
		}
	}
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
	
	Fallback Off
}
/*ASEBEGIN
Version=19909
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;8;-992,0;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCFlipBookUVAnimation, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;7;-672,0;Inherit;False;0;0;7;0;FLOAT2;0,0;False;1;FLOAT;16;False;2;FLOAT;21;False;3;FLOAT;30;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;330;False;4;FLOAT2;0;FLOAT;1;FLOAT;2;INT;3
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1;-320,0;Inherit;True;Property;_BaseColor;Base Color;0;2;[NoScaleOffset];[SingleLineTexture];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.TemplateShaderPropertyNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;56;-256,-208;Inherit;False;0;0;_Color;Shader;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PosVertexDataNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;34;480,192;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;55;368,80;Inherit;False;LUT;1;;35;0baaa08160114780391fed4ef3e2d57e;0;1;35;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;57;64,0;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;40;672,0;Inherit;False;Property;SHADER_API_MOBILE;SHADER_API_MOBILE;1;0;Create;False;0;0;0;False;0;False;0;0;0;False;SHADER_API_MOBILE;Toggle;2;Key0;Key1;Fetch;False;False;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CustomExpressionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;31;736,176;Inherit;False;// 1. Caméra en espace local$float3 localCamPos = mul(unity_WorldToObject, float4(_WorldSpaceCameraPos, 1.0)).xyz@$$// 2. Axe de rotation (Y local du tuyau)$float3 up = float3(0, 1, 0)@$$// 3. Direction vers la caméra (projetée sur le plan XZ local)$// On ajoute un epsilon pour éviter le normalize(0) si la caméra est pile au-dessus$float3 forward = normalize(float3(localCamPos.x, 0, localCamPos.z) + 0.0001)@$$// 4. Vecteur Right perpendiculaire$float3 right = cross(up, forward)@$$// 5. Reconstruction du vertex$// Si ton quad est un "Plane" Unity ou un Quad Blender standard :$// InPos.x est la largeur, InPos.y la hauteur.$float3 rotatedPos = InPos.x * right + InPos.y * up + InPos.z * forward@$$return rotatedPos - InPos@;3;Create;1;True;InPos;FLOAT3;0,0,0;In;;Inherit;False;Local Sprite;True;False;0;;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;30;1024,0;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;Meenphie/Sprite/Flipbook Oriented;0f8ba0101102bb14ebf021ddadce9b49;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;2;True;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;True;6;Queue=Transparent=Queue=1;IgnoreProjector=True;RenderType=Transparent=RenderType;PreviewType=Plane;CanUseSpriteAtlas=True;DisableBatching=True=DisableBatching;False;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;False;0;;0;0;Standard;0;0;1;True;False;;False;0
WireConnection;7;0;8;0
WireConnection;1;1;7;0
WireConnection;55;35;57;0
WireConnection;57;0;56;0
WireConnection;57;1;1;0
WireConnection;40;1;57;0
WireConnection;40;0;55;0
WireConnection;31;0;34;0
WireConnection;30;0;40;0
WireConnection;30;1;31;0
ASEEND*/
//CHKSM=03FE8B08FBF9A8BEEAA174FBE9B6FE3C4FB02B7B