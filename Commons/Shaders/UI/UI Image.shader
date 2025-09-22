// Made with Amplify Shader Editor v1.9.9.4
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Meenphie/UI Image"
{
    Properties
    {
        [PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
        _Color ("Tint", Color) = (1,1,1,1)

        _StencilComp ("Stencil Comparison", Float) = 8
        _Stencil ("Stencil ID", Float) = 0
        _StencilOp ("Stencil Operation", Float) = 0
        _StencilWriteMask ("Stencil Write Mask", Float) = 255
        _StencilReadMask ("Stencil Read Mask", Float) = 255

        _ColorMask ("Color Mask", Float) = 15

        [Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0

        [HDR] ColorHDR( "Color", Color ) = ( 1, 1, 1, 1 )
        [KeywordEnum( 2D,3D )] _LUTMode( "LUT Mode", Float ) = 1
        _LUTSize( "LUT Size", Float ) = 32
        [NoScaleOffset][SingleLineTexture] _2DLut( "2D Lut", 2D ) = "black" {}
        [NoScaleOffset][SingleLineTexture] _3DLut( "3D Lut", 3D ) = "black" {}
        [HideInInspector] GenKey__2DLut( "Assign keyword _2DLUT", Float ) = 1.0
        [HideInInspector] GenKey__3DLut( "Assign keyword _3DLUT", Float ) = 1.0
        [HideInInspector] _texcoord( "", 2D ) = "white" {}

    }

    SubShader
    {
		LOD 0

        Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" "CanUseSpriteAtlas"="True" }

        Stencil
        {
        	Ref [_Stencil]
        	ReadMask [_StencilReadMask]
        	WriteMask [_StencilWriteMask]
        	Comp [_StencilComp]
        	Pass [_StencilOp]
        }


        Cull Off
        Lighting Off
        ZWrite Off
        ZTest [unity_GUIZTestMode]
        Blend One OneMinusSrcAlpha
        ColorMask [_ColorMask]

        
        Pass
        {
            Name "Default"
        CGPROGRAM
            #define ASE_VERSION 19904

            #pragma vertex vert
            #pragma fragment frag
            #pragma target 3.5

            #include "UnityCG.cginc"
            #include "UnityUI.cginc"

            #pragma multi_compile_local _ UNITY_UI_CLIP_RECT
            #pragma multi_compile_local _ UNITY_UI_ALPHACLIP

            #define ASE_NEEDS_FRAG_COLOR
            #define ASE_NEEDS_TEXTURE_COORDINATES0
            #define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
            #pragma shader_feature_local _LUTMODE_2D _LUTMODE_3D
            #pragma shader_feature_local _2DLUT
            #pragma shader_feature_local _3DLUT


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
                float4 worldPosition : TEXCOORD1;
                float4  mask : TEXCOORD2;
                UNITY_VERTEX_OUTPUT_STEREO
                
            };

            sampler2D _MainTex;
            fixed4 _Color;
            fixed4 _TextureSampleAdd;
            float4 _ClipRect;
            float4 _MainTex_ST;
            float _UIMaskSoftnessX;
            float _UIMaskSoftnessY;

            uniform sampler2D _2DLut;
            uniform float _LUTSize;
            uniform sampler3D _3DLut;
            uniform float4 ColorHDR;


            v2f vert(appdata_t v )
            {
                v2f OUT;
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(OUT);

                

                v.vertex.xyz +=  float3( 0, 0, 0 ) ;

                float4 vPosition = UnityObjectToClipPos(v.vertex);
                OUT.worldPosition = v.vertex;
                OUT.vertex = vPosition;

                float2 pixelSize = vPosition.w;
                pixelSize /= float2(1, 1) * abs(mul((float2x2)UNITY_MATRIX_P, _ScreenParams.xy));

                float4 clampedRect = clamp(_ClipRect, -2e10, 2e10);
                float2 maskUV = (v.vertex.xy - clampedRect.xy) / (clampedRect.zw - clampedRect.xy);
                OUT.texcoord = v.texcoord;
                OUT.mask = float4(v.vertex.xy * 2 - clampedRect.xy - clampedRect.zw, 0.25 / (0.25 * half2(_UIMaskSoftnessX, _UIMaskSoftnessY) + abs(pixelSize.xy)));

                OUT.color = v.color * _Color;
                return OUT;
            }

            fixed4 frag(v2f IN ) : SV_Target
            {
                //Round up the alpha color coming from the interpolator (to 1.0/256.0 steps)
                //The incoming alpha could have numerical instability, which makes it very sensible to
                //HDR color transparency blend, when it blends with the world's texture.
                const half alphaPrecision = half(0xff);
                const half invAlphaPrecision = half(1.0/alphaPrecision);
                IN.color.a = round(IN.color.a * alphaPrecision)*invAlphaPrecision;

                float2 uv_MainTex = IN.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                float4 tex2DNode114 = tex2D( _MainTex, uv_MainTex );
                clip( tex2DNode114.a - 0.5);
                float4 temp_output_35_0_g70 = ( IN.color * tex2DNode114 * ColorHDR );
                float3 temp_output_367_0_g70 = (temp_output_35_0_g70).xyz;
                float3 Color353_g70 = temp_output_367_0_g70;
                #if defined( _LUTMODE_2D )
                float3 staticSwitch273_g70 = saturate( temp_output_367_0_g70 );
                #elif defined( _LUTMODE_3D )
                float3 staticSwitch273_g70 = temp_output_367_0_g70;
                #else
                float3 staticSwitch273_g70 = temp_output_367_0_g70;
                #endif
                float3 Color_Saturate49_g70 = staticSwitch273_g70;
                float Lut_Height213_g70 = _LUTSize;
                float Lut_Width216_g70 = ( _LUTSize * Lut_Height213_g70 );
                float3 appendResult214_g70 = (float3(( 1.0 / Lut_Width216_g70 ) , ( 1.0 / Lut_Height213_g70 ) , ( Lut_Height213_g70 - 1.0 )));
                float3 Scale_Offset208_g70 = appendResult214_g70;
                float2 Scale_Factor292_g70 = ( (Scale_Offset208_g70).xy * (Scale_Offset208_g70).z );
                float2 Offset299_g70 = ( (Scale_Offset208_g70).xy * 0.5 );
                float2 Adjusted_UV305_g70 = ( ( (Color_Saturate49_g70).xy * Scale_Factor292_g70 ) + Offset299_g70 );
                float Scaled_Blue280_g70 = ( (Color_Saturate49_g70).z * (Scale_Offset208_g70).z );
                float Shift288_g70 = floor( Scaled_Blue280_g70 );
                float Final_X313_g70 = ( (Adjusted_UV305_g70).x + ( Shift288_g70 * (Scale_Offset208_g70).y ) );
                float2 appendResult326_g70 = (float2(Final_X313_g70 , (Adjusted_UV305_g70).y));
                float2 Final_UV325_g70 = appendResult326_g70;
                float2 appendResult338_g70 = (float2((Scale_Offset208_g70).y , 0.0));
                float2 Offset_UV336_g70 = ( Final_UV325_g70 + appendResult338_g70 );
                float3 lerpResult333_g70 = lerp( tex2D( _2DLut, Final_UV325_g70 ).rgb , tex2D( _2DLut, Offset_UV336_g70 ).rgb , ( Scaled_Blue280_g70 - Shift288_g70 ));
                #ifdef _2DLUT
                float3 staticSwitch347_g70 = lerpResult333_g70;
                #else
                float3 staticSwitch347_g70 = Color_Saturate49_g70;
                #endif
                float3 TwoD_LUT346_g70 = staticSwitch347_g70;
                float3 RGB16_g71 = ( ( log10( ( ( Color_Saturate49_g70 * 5.555556 ) + 0.047996 ) ) * 0.244161 ) + 0.386036 );
                #ifdef _3DLUT
                float3 staticSwitch194_g70 = tex3D( _3DLut, RGB16_g71 ).rgb;
                #else
                float3 staticSwitch194_g70 = Color_Saturate49_g70;
                #endif
                float3 ThreeD_LUT51_g70 = staticSwitch194_g70;
                #if defined( _LUTMODE_2D )
                float3 staticSwitch42_g70 = TwoD_LUT346_g70;
                #elif defined( _LUTMODE_3D )
                float3 staticSwitch42_g70 = ThreeD_LUT51_g70;
                #else
                float3 staticSwitch42_g70 = ThreeD_LUT51_g70;
                #endif
                #ifdef SHADER_API_MOBILE
                float3 staticSwitch41_g70 = staticSwitch42_g70;
                #else
                float3 staticSwitch41_g70 = Color353_g70;
                #endif
                float Alpha359_g70 = (temp_output_35_0_g70).w;
                float4 appendResult360_g70 = (float4(staticSwitch41_g70 , Alpha359_g70));
                

                half4 color = appendResult360_g70;

                #ifdef UNITY_UI_CLIP_RECT
                half2 m = saturate((_ClipRect.zw - _ClipRect.xy - abs(IN.mask.xy)) * IN.mask.zw);
                color.a *= m.x * m.y;
                #endif

                #ifdef UNITY_UI_ALPHACLIP
                clip (color.a - 0.001);
                #endif

                color.rgb *= color.a;

                return color;
            }
        ENDCG
        }
    }
    CustomEditor "AmplifyShaderEditor.MaterialInspector"
	
	Fallback Off
}
/*ASEBEGIN
Version=19904
Node;AmplifyShaderEditor.TemplateShaderPropertyNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;113;-1440,-96;Inherit;False;0;0;_MainTex;Shader;False;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;114;-1184,-96;Inherit;True;Property;_TextureSample3;Texture Sample 3;6;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;0;False;1;FLOAT2;0,0;False;2;FLOAT;10;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.ClipNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;124;-752,-96;Inherit;False;3;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;2;FLOAT;0.5;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;31;-752,-304;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;78;-784,48;Inherit;False;Property;ColorHDR;Color;0;1;[HDR];Create;False;0;0;0;False;0;False;1,1,1,1;0,0.18374,0.2830189,0.2509804;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;77;-384,-128;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;1,1,1,1;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;157;-160,-128;Inherit;False;LUT;1;;70;0baaa08160114780391fed4ef3e2d57e;0;1;35;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;139;128,-128;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;Meenphie/UI Image;5056123faa0c79b47ab6ad7e8bf059a4;True;Default;0;0;Default;2;False;True;3;1;False;;10;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;True;True;True;True;True;0;True;_ColorMask;False;False;False;False;False;False;False;True;True;0;True;_Stencil;255;True;_StencilReadMask;255;True;_StencilWriteMask;0;True;_StencilComp;0;True;_StencilOp;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;2;False;;True;0;True;unity_GUIZTestMode;False;True;5;Queue=Transparent=Queue=0;IgnoreProjector=True;RenderType=Transparent=RenderType;PreviewType=Plane;CanUseSpriteAtlas=True;False;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;False;0;;0;0;Standard;0;0;1;True;False;;False;0
WireConnection;114;0;113;0
WireConnection;124;0;114;0
WireConnection;124;1;114;4
WireConnection;77;0;31;0
WireConnection;77;1;124;0
WireConnection;77;2;78;0
WireConnection;157;35;77;0
WireConnection;139;0;157;0
ASEEND*/
//CHKSM=72926E2D2217A3EE7C17B752E09DCDFC433E3B8E