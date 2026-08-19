// Made with Amplify Shader Editor v1.9.9.12
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/Sprite/Flipbook Oriented"
{
	Properties
	{
		_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
		_MainTex ("Particle Texture", 2D) = "white" {}
		_InvFade ("Soft Particles Factor", Range(0.01,3.0)) = 1.0
		[NoScaleOffset][SingleLineTexture] _BaseColor( "Base Color", 2D ) = "white" {}
		[NoScaleOffset][SingleLineTexture] _LUT( "LUT", 3D ) = "black" {}

	}


	Category
	{
		SubShader
		{
		LOD 0

			Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" }
			Blend SrcAlpha OneMinusSrcAlpha
			ColorMask RGB
			Cull Off
			Lighting Off
			ZWrite Off
			ZTest LEqual
			
			Pass {

				CGPROGRAM
				#define ASE_VERSION 19912

				#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
				#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
				#endif

				#pragma vertex vert
				#pragma fragment frag
				#pragma target 3.5
				#pragma multi_compile_instancing
				#pragma multi_compile_particles
				#pragma multi_compile_fog
				#include "Packages/com.meenphie.lighting/Commons/Shaders/Custom Expressions/UdonRealtimeDiffuse.cginc"
				#define ASE_NEEDS_VERT_POSITION
				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0


				#include "UnityCG.cginc"

				struct appdata_t
				{
					float4 vertex : POSITION;
					fixed4 color : COLOR;
					float4 texcoord : TEXCOORD0;
					UNITY_VERTEX_INPUT_INSTANCE_ID
					float3 ase_normal : NORMAL;
				};

				struct v2f
				{
					float4 vertex : SV_POSITION;
					fixed4 color : COLOR;
					float4 texcoord : TEXCOORD0;
					UNITY_FOG_COORDS(1)
					#ifdef SOFTPARTICLES_ON
					float4 projPos : TEXCOORD2;
					#endif
					UNITY_VERTEX_INPUT_INSTANCE_ID
					UNITY_VERTEX_OUTPUT_STEREO
					float4 ase_texcoord3 : TEXCOORD3;
					float4 ase_texcoord4 : TEXCOORD4;
				};


				#if UNITY_VERSION >= 560
				UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
				#else
				uniform sampler2D_float _CameraDepthTexture;
				#endif

				//Don't delete this comment
				// uniform sampler2D_float _CameraDepthTexture;

				uniform sampler2D _MainTex;
				uniform fixed4 _TintColor;
				uniform float4 _MainTex_ST;
				uniform float _InvFade;
				uniform sampler3D _LUT;
				uniform sampler2D _BaseColor;
				float3 LocalSprite31( float3 InPos )
				{
					    // 1. Caméra en espace local
					    float3 localCamPos = mul(unity_WorldToObject, float4(_WorldSpaceCameraPos, 1.0)).xyz;
					    // 2. Direction caméra projetée sur le plan XZ local
					    //    Epsilon propre : si la caméra est pile au-dessus (XZ ≈ 0), on garde une direction fixe
					    //    plutôt que de normaliser un vecteur quasi nul (qui sautait dans toutes les directions)
					    float3 toCamXZ = float3(localCamPos.x, 0, localCamPos.z);
					    float len = length(toCamXZ);
					    float3 forward = (len > 0.001) ? toCamXZ / len : float3(0, 0, 1);
					    // 3. Vecteur Right perpendiculaire
					    float3 up = float3(0, 1, 0);
					    float3 right = cross(up, forward);
					    // 4. Rotation pure autour de l'origine (pivot = origine du mesh)
					    return InPos.x * right + InPos.y * up + InPos.z * forward - InPos;
				}
				


				v2f vert ( appdata_t v  )
				{
					v2f o;
					UNITY_SETUP_INSTANCE_ID(v);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
					UNITY_TRANSFER_INSTANCE_ID(v, o);
					float3 InPos31 = v.vertex.xyz;
					float3 localLocalSprite31 = LocalSprite31( InPos31 );
					
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					o.ase_texcoord3.xyz = ase_positionWS;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.ase_normal );
					o.ase_texcoord4.xyz = ase_normalWS;
					
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord3.w = 0;
					o.ase_texcoord4.w = 0;

					v.vertex.xyz += localLocalSprite31;
					o.vertex = UnityObjectToClipPos(v.vertex);
					#ifdef SOFTPARTICLES_ON
						o.projPos = ComputeScreenPos (o.vertex);
						COMPUTE_EYEDEPTH(o.projPos.z);
					#endif
					o.color = v.color;
					o.texcoord = v.texcoord;
					UNITY_TRANSFER_FOG(o,o.vertex);
					return o;
				}

				fixed4 frag ( v2f i  ) : SV_Target
				{
					UNITY_SETUP_INSTANCE_ID( i );
					UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( i );

					#ifdef SOFTPARTICLES_ON
						float sceneZ = LinearEyeDepth (SAMPLE_DEPTH_TEXTURE_PROJ(_CameraDepthTexture, UNITY_PROJ_COORD(i.projPos)));
						float partZ = i.projPos.z;
						float fade = saturate (_InvFade * (sceneZ-partZ));
						i.color.a *= fade;
					#endif

					float3 ase_positionWS = i.ase_texcoord3.xyz;
					float3 WorldPos59 = ase_positionWS;
					float3 ase_normalWS = i.ase_texcoord4.xyz;
					float3 WorldNormal59 = ase_normalWS;
					float3 localUdonRealtimeDiffuse59 = UdonRealtimeDiffuse( WorldPos59 , WorldNormal59 );
					float2 texCoord8 = i.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
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
					float4 tex2DNode1 = tex2D( _BaseColor, fbuv7 );
					

					fixed4 col = ( float4( localUdonRealtimeDiffuse59 , 0.0 ) + ( _TintColor * tex2DNode1.r ) );
					UNITY_APPLY_FOG(i.fogCoord, col);
					return col;
				}
				ENDCG
			}
		}
	}
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
	
	Fallback Off
}
/*ASEBEGIN
Version=19912
{"type":"AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor","id":8,"pos":[-992,0],"params":["Inherit","False","0","-1","2","3","2","SAMPLER2D","","False","0","FLOAT2","1,1","False","1","FLOAT2","0,0","False","5","FLOAT2","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.TFHCFlipBookUVAnimation, AmplifyShaderEditor","id":7,"pos":[-672,0],"params":["Inherit","False","0","0","7","0","FLOAT2","0,0","False","1","FLOAT","16","False","2","FLOAT","21","False","3","FLOAT","30","False","4","FLOAT","0","False","5","FLOAT","0","False","6","FLOAT","330","False","4","FLOAT2","0","FLOAT","1","FLOAT","2","INT","3"]}
{"type":"AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor","id":1,"pos":[-320,0],"params":["Inherit","True","Property","_BaseColor","Base Color","0","2","[NoScaleOffset]","[SingleLineTexture]","Create","False","0","0","0","False","0","False","","-1","None","ca98fe8f84b89108c9fbdd459d36e9a6","True","0","False","white","Auto","False","Object","-1","Auto","Texture2D","False","8","0","SAMPLER2D","","False","1","FLOAT2","0,0","False","2","FLOAT","0","False","3","FLOAT2","0,0","False","4","FLOAT2","0,0","False","5","FLOAT","1","False","6","FLOAT","0","False","7","SAMPLERSTATE","","False","6","COLOR","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4","FLOAT3","5"]}
{"type":"AmplifyShaderEditor.WorldPosInputsNode, AmplifyShaderEditor","id":60,"pos":[720,-352],"params":["Inherit","False","0","4","FLOAT3","0","FLOAT","1","FLOAT","2","FLOAT","3"]}
{"type":"AmplifyShaderEditor.WorldNormalVector, AmplifyShaderEditor","id":61,"pos":[720,-200],"params":["Inherit","False","False","1","0","FLOAT3","0,0,1","False","4","FLOAT3","0","FLOAT","1","FLOAT","2","FLOAT","3"]}
{"type":"AmplifyShaderEditor.TemplateShaderPropertyNode, AmplifyShaderEditor","id":56,"pos":[-256,-208],"params":["Inherit","False","0","0","_TintColor","Shader","False","0","5","COLOR","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":73,"pos":[200.1987,-133.0982],"params":["Inherit","False","2","2","0","COLOR","0,0,0,0","False","1","FLOAT","0","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.PosVertexDataNode, AmplifyShaderEditor","id":34,"pos":[1096,280],"params":["Inherit","False","0","0","5","FLOAT3","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.CustomExpressionNode, AmplifyShaderEditor","id":59,"pos":[960,-312],"params":["Inherit","False"," ","3","File","2","True","WorldPos","FLOAT3","0,0,0","In","","Inherit","False","True","WorldNormal","FLOAT3","0,0,0","In","","Inherit","False","UdonRealtimeDiffuse","False","False","0","54ddc4aed38557dc289bde418c430205","False","2","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":66,"pos":[1318.767,-203.0029],"params":["Inherit","False","2","2","0","FLOAT3","0,0,0","False","1","COLOR","0,0,0,0","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":55,"pos":[256,128],"params":["Inherit","False","LUT","1","","35","4f182fda2cc1d189990007472f6485a5","0","1","35","FLOAT4","0,0,0,0","False","1","FLOAT4","0"]}
{"type":"AmplifyShaderEditor.StaticSwitch, AmplifyShaderEditor","id":40,"pos":[640,184],"params":["Inherit","False","Property","SHADER_API_MOBILE","SHADER_API_MOBILE","1","0","Create","False","0","0","0","False","0","False","","0","0","0","False","SHADER_API_MOBILE","Toggle","2","Key0","Key1","Fetch","False","False","All","9","1","FLOAT4","0,0,0,0","False","0","FLOAT4","0,0,0,0","False","2","FLOAT4","0,0,0,0","False","3","FLOAT4","0,0,0,0","False","4","FLOAT4","0,0,0,0","False","5","FLOAT4","0,0,0,0","False","6","FLOAT4","0,0,0,0","False","7","FLOAT4","0,0,0,0","False","8","FLOAT4","0,0,0,0","False","1","FLOAT4","0"]}
{"type":"AmplifyShaderEditor.CustomExpressionNode, AmplifyShaderEditor","id":31,"pos":[1392,280],"params":["Inherit","False","    // 1. Caméra en espace local\n    float3 localCamPos = mul(unity_WorldToObject, float4(_WorldSpaceCameraPos, 1.0)).xyz;\n\n    // 2. Direction caméra projetée sur le plan XZ local\n    //    Epsilon propre : si la caméra est pile au-dessus (XZ ≈ 0), on garde une direction fixe\n    //    plutôt que de normaliser un vecteur quasi nul (qui sautait dans toutes les directions)\n    float3 toCamXZ = float3(localCamPos.x, 0, localCamPos.z);\n    float len = length(toCamXZ);\n    float3 forward = (len > 0.001) ? toCamXZ / len : float3(0, 0, 1);\n\n    // 3. Vecteur Right perpendiculaire\n    float3 up = float3(0, 1, 0);\n    float3 right = cross(up, forward);\n\n    // 4. Rotation pure autour de l'origine (pivot = origine du mesh)\n    return InPos.x * right + InPos.y * up + InPos.z * forward - InPos;","3","Create","1","True","InPos","FLOAT3","0,0,0","In","","Inherit","False","Local Sprite","True","False","0","","False","1","0","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":72,"pos":[1656,0],"params":["Float","False","True","-1","3","AmplifyShaderEditor.MaterialInspector","0","5","Meenphie/Sprite/Flipbook Oriented","0b6a9f8b4f707c74ca64c0be8e590de0","True","SubShader 0 Pass 0","0","0","SubShader 0 Pass 0","2","True","True","2","5","False","","10","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","True","2","False","","True","True","True","True","True","False","0","False","","False","False","False","False","False","False","False","False","True","True","2","False","","True","3","False","","False","False","True","4","Queue=Transparent=Queue=0","IgnoreProjector=True","RenderType=Transparent=RenderType","PreviewType=Plane","False","False","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","3","False","0","","0","0","Standard","0","0","1","True","False","","False","0"]}
{"wire":[7,0,8,0]}
{"wire":[1,1,7,0]}
{"wire":[73,0,56,0]}
{"wire":[73,1,1,1]}
{"wire":[59,0,60,0]}
{"wire":[59,1,61,0]}
{"wire":[66,0,59,0]}
{"wire":[66,1,73,0]}
{"wire":[55,35,1,1]}
{"wire":[40,1,1,1]}
{"wire":[40,0,55,0]}
{"wire":[31,0,34,0]}
{"wire":[72,0,66,0]}
{"wire":[72,1,31,0]}
ASEEND*/
//CHKSM=E97B04B65FE705A5D4810EA291109610875DE4A9