// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "HaloInfinte/Halo Infinite Spartan Visor"
{
	Properties
	{
		[NoScaleOffset]_ASGMap("ASGMap", 2D) = "white" {}
		[NoScaleOffset]_BumpMap("NormalMap", 2D) = "bump" {}
		_DetailNormal("DetailNormal", 2D) = "gray" {}
		_DetailNormalIntesity("DetailNormal Intesity", Range( 0 , 1)) = 1
		[KeywordEnum(OpenGL,DirectX)] _NormalMapFormat("NormalMapFormat", Float) = 1
		_DetailAlbedoMap("DetailTexture", 2D) = "white" {}
		_AODiffuseMixing("AO DiffuseMixing", Range( 0 , 1)) = 0.5
		[Header(ColorZone6 grunge)]_GrungeColor("GrungeColor", Color) = (0,0,0,0)
		_GrungeAmmount("Grunge Ammount", Range( 0 , 1)) = 0
		_GrungePower("Grunge Power", Range( 0.22 , 2.2)) = 1
		_NonVisorSmoothness("NonVisorSmoothness", Range( 0 , 1)) = 0.4
		_NonVisorMettalic("NonVisorMettalic", Range( 0 , 1)) = 0
		[Header(Scratches)]_Color7("ScratchColor", Color) = (0.846,0.825,0.839,0)
		_ScratchAmount("ScratchAmount", Range( 0 , 1)) = 0
		[Header(Visor)]_VisorColor1("VisorColor1", Color) = (0,1,0,0)
		_VisorColor2("VisorColor2", Color) = (0,0,1,0)
		_VisorColor3("VisorColor3", Color) = (1,0,0,0)
		_VisorMetallic("VisorMetallic", Range( 0 , 1)) = 1
		_VisorSmoothness("VisorSmoothness", Range( 0 , 1)) = 0.9
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 4.6
		#pragma multi_compile _NORMALMAPFORMAT_OPENGL _NORMALMAPFORMAT_DIRECTX
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _DetailNormal;
		uniform float4 _DetailNormal_ST;
		uniform float _DetailNormalIntesity;
		uniform sampler2D _BumpMap;
		uniform float4 _VisorColor3;
		uniform float4 _VisorColor1;
		uniform sampler2D _DetailAlbedoMap;
		uniform float4 _DetailAlbedoMap_ST;
		uniform float4 _VisorColor2;
		uniform float4 _Color7;
		uniform float _ScratchAmount;
		uniform float4 _GrungeColor;
		uniform sampler2D _ASGMap;
		uniform float _GrungeAmmount;
		uniform float _GrungePower;
		uniform float _AODiffuseMixing;
		uniform float _VisorMetallic;
		uniform float _NonVisorMettalic;
		uniform float _VisorSmoothness;
		uniform float _NonVisorSmoothness;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_DetailNormal = i.uv_texcoord * _DetailNormal_ST.xy + _DetailNormal_ST.zw;
			float2 uv_BumpMap6 = i.uv_texcoord;
			float3 temp_output_378_0 = saturate( ( UnpackScaleNormal( tex2D( _DetailNormal, uv_DetailNormal ), _DetailNormalIntesity ) + UnpackNormal( tex2D( _BumpMap, uv_BumpMap6 ) ) ) );
			float3 break377 = temp_output_378_0;
			float3 appendResult354 = (float3(break377.x , -break377.y , 1.0));
			#if defined(_NORMALMAPFORMAT_OPENGL)
				float3 staticSwitch355 = temp_output_378_0;
			#elif defined(_NORMALMAPFORMAT_DIRECTX)
				float3 staticSwitch355 = appendResult354;
			#else
				float3 staticSwitch355 = appendResult354;
			#endif
			float3 NormalMap15 = staticSwitch355;
			o.Normal = NormalMap15;
			float2 uv_DetailAlbedoMap = i.uv_texcoord * _DetailAlbedoMap_ST.xy + _DetailAlbedoMap_ST.zw;
			float4 tex2DNode58 = tex2D( _DetailAlbedoMap, uv_DetailAlbedoMap );
			float DetailBlue438 = tex2DNode58.b;
			float DetailRed56 = tex2DNode58.r;
			float temp_output_444_0 = ( DetailBlue438 + DetailRed56 );
			float4 lerpResult418 = lerp( _VisorColor3 , _VisorColor1 , ( saturate( ( temp_output_444_0 - 0.5 ) ) * 2.0 ));
			float4 lerpResult430 = lerp( lerpResult418 , _VisorColor2 , ( saturate( ( ( 1.0 - temp_output_444_0 ) - 0.5 ) ) * 2.0 ));
			float4 lerpResult446 = lerp( lerpResult430 , _Color7 , ( _ScratchAmount * saturate( ( DetailBlue438 - DetailRed56 ) ) ));
			float3 Zone6Color109 = (_GrungeColor).rgb;
			float2 uv_ASGMap5 = i.uv_texcoord;
			float4 tex2DNode5 = tex2D( _ASGMap, uv_ASGMap5 );
			float Smoothness11 = tex2DNode5.b;
			float GrungeMask34 = saturate( pow( ( saturate( Smoothness11 ) * _GrungeAmmount ) , _GrungePower ) );
			float4 lerpResult319 = lerp( lerpResult446 , float4( Zone6Color109 , 0.0 ) , GrungeMask34);
			float AO9 = tex2DNode5.r;
			float4 FinalColor137 = saturate( ( lerpResult319 * ( ( AO9 * _AODiffuseMixing ) + ( 1.0 - _AODiffuseMixing ) ) ) );
			o.Albedo = FinalColor137.rgb;
			float lerpResult432 = lerp( _VisorMetallic , _NonVisorMettalic , GrungeMask34);
			o.Metallic = lerpResult432;
			float lerpResult433 = lerp( _VisorSmoothness , _NonVisorSmoothness , GrungeMask34);
			o.Smoothness = lerpResult433;
			o.Occlusion = AO9;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18909
478.6667;72.66667;1460;769;6537.147;1563.341;4.507269;True;False
Node;AmplifyShaderEditor.CommentaryNode;161;-4661.054,-332.9252;Inherit;False;1207.14;657.9625;Tileable texture Input and Chacing ;7;56;58;370;374;376;378;438;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;58;-4613.054,-276.925;Inherit;True;Property;_DetailAlbedoMap;DetailTexture;5;0;Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;19;-3440.7,-272.7654;Inherit;False;1151.316;513.5338;Texture Input;9;10;15;355;354;353;377;9;11;5;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;56;-4311.711,-271.4855;Inherit;False;DetailRed;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;438;-4305.706,-155.9603;Inherit;False;DetailBlue;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;5;-3404.997,-217.8338;Inherit;True;Property;_ASGMap;ASGMap;0;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;455;-2104.864,291.879;Inherit;False;1707.177;980.7518;GradientMap Coloring;23;442;451;443;105;450;446;453;454;422;414;426;419;415;418;430;424;425;428;429;431;439;399;444;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;439;-2053.92,691.7051;Inherit;False;438;DetailBlue;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;399;-2054.864,761.6581;Inherit;False;56;DetailRed;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;11;-3116.997,-89.83382;Inherit;False;Smoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;176;-2121,-463;Inherit;False;1220;735;Simple Contrast/knee adjustment for wear and grunge;2;35;36;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;35;-2099,-69;Inherit;False;1156;323;Grunge;7;34;49;30;33;29;32;387;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;31;-2134.358,36.68813;Inherit;False;11;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;444;-1813.605,708.561;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-2049,141;Inherit;False;Property;_GrungeAmmount;Grunge Ammount;8;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;387;-1933.154,41.4566;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;422;-1654.68,798.624;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;424;-1507.829,703.4288;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;167;-3435.741,252.2235;Inherit;False;894.9314;226.9532;ColorZone6 Grunge Color;3;109;188;104;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WireNode;454;-1720.738,1129.227;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-1745,77;Inherit;False;Property;_GrungePower;Grunge Power;9;0;Create;True;0;0;0;False;0;False;1;1.057985;0.22;2.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;374;-4525.218,-8.782759;Inherit;False;Property;_DetailNormalIntesity;DetailNormal Intesity;3;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;414;-1496.044,801.9138;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;425;-1368.931,700.0646;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;453;-1704.524,1096.799;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-1731.55,-13.76271;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;428;-1428.032,341.8789;Inherit;False;Property;_VisorColor3;VisorColor3;16;0;Create;True;0;0;0;False;0;False;1,0,0,0;0.509434,0.509434,0.509434,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;370;-4250.438,-55.93626;Inherit;True;Property;_DetailNormal;DetailNormal;2;0;Create;True;0;0;0;False;0;False;58;None;None;True;0;False;gray;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;442;-1237.099,1139.631;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;426;-1230.593,691.2792;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;6;-4247.042,125.6864;Inherit;True;Property;_BumpMap;NormalMap;1;1;[NoScaleOffset];Create;False;0;0;0;False;0;False;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;419;-1360.271,795.4238;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;30;-1467,-13;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;429;-1432.138,518.4828;Inherit;False;Property;_VisorColor1;VisorColor1;14;1;[Header];Create;True;1;Visor;0;0;False;0;False;0,1,0,0;0.779,0.1036069,0.3703004,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;104;-3390.478,302.2234;Inherit;False;Property;_GrungeColor;GrungeColor;7;1;[Header];Create;True;1;ColorZone6 grunge;0;0;False;0;False;0,0,0,0;0.6320754,0.3974977,0.002981495,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;443;-1110.097,1153.63;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;418;-1045.216,644.3124;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;451;-1227.968,1068.178;Inherit;False;Property;_ScratchAmount;ScratchAmount;13;0;Create;True;0;0;0;False;0;False;0;0.888;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;431;-1315.776,897.8785;Inherit;False;Property;_VisorColor2;VisorColor2;15;0;Create;True;0;0;0;False;0;False;0,0,1,0;0.2452827,0.2452827,0.2452827,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;376;-3787.617,-51.46151;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;172;-387.553,676.1298;Inherit;False;1452.4;590.8382;Final Color Mixing;11;137;160;131;135;133;136;134;132;319;318;127;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ComponentMaskNode;188;-3135.475,304.2739;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;9;-3116.997,-217.8338;Inherit;False;AO;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;49;-1339,-13;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;415;-1221.933,786.6382;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;109;-2943.475,306.2739;Inherit;False;Zone6Color;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;132;-91.31894,1065.726;Inherit;False;9;AO;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;378;-3648,-48;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;134;-91.31894,1161.726;Inherit;False;Property;_AODiffuseMixing;AO DiffuseMixing;6;0;Create;True;0;0;0;False;0;False;0.5;0.589;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;34;-1131,-13;Inherit;False;GrungeMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;105;-931.8087,946.6758;Inherit;False;Property;_Color7;ScratchColor;12;1;[Header];Create;False;1;Scratches;0;0;False;0;False;0.846,0.825,0.839,0;0.7735849,0.7735849,0.7735849,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;450;-796.1659,1130.177;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;430;-862.3392,735.7894;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;318;-369.9337,1031.486;Inherit;False;34;GrungeMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;377;-3348.136,80.71321;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.OneMinusNode;136;196.679,1161.726;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;446;-581.6867,887.7371;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;1,1,1,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;133;196.679,1065.726;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;127;-369.9337,955.9139;Inherit;False;109;Zone6Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NegateNode;353;-3105.734,125.7727;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;135;372.681,1065.726;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;319;-107.2136,886.074;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;131;568.1129,883.2758;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;354;-2944.734,65.77268;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;160;696.1127,899.2758;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;452;-883.9772,-367.331;Inherit;False;616.9996;483.7373;Metallic and Smoothness;7;408;409;435;436;432;433;434;;1,1,1,1;0;0
Node;AmplifyShaderEditor.StaticSwitch;355;-2768,-48;Inherit;False;Property;_NormalMapFormat;NormalMapFormat;4;0;Create;True;0;0;0;False;0;False;1;1;1;True;;KeywordEnum;2;OpenGL;DirectX;Create;False;True;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;173;-248.6661,-371.3863;Inherit;False;664.5903;520.3188;Output;4;0;142;139;138;v 0.4 OOOH Shiney;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;36;-2100,-414;Inherit;False;1154;337;Wear;7;27;50;22;21;26;23;20;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;434;-829.9772,1.406367;Inherit;False;34;GrungeMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;15;-2528,-48;Inherit;False;NormalMap;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;435;-822.9772,-239.5936;Inherit;False;Property;_NonVisorMettalic;NonVisorMettalic;11;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;408;-832.0804,-317.331;Inherit;False;Property;_VisorMetallic;VisorMetallic;17;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;409;-833.0804,-140.3308;Inherit;False;Property;_VisorSmoothness;VisorSmoothness;18;0;Create;True;0;0;0;False;0;False;0.9;0.9;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;137;840.1127,883.2758;Inherit;False;FinalColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;436;-833.9772,-70.59361;Inherit;False;Property;_NonVisorSmoothness;NonVisorSmoothness;10;0;Create;True;0;0;0;False;0;False;0.4;0.4;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;138;-218.7789,-331.4967;Inherit;False;137;FinalColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;432;-452.2763,-206.6539;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;50;-1313,-356;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;22;-1440,-362;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-2050,-300;Inherit;False;Property;_EdgeWearAmmount;Edge Wear Ammount;19;0;Create;True;0;0;0;False;0;False;1;0.568;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;433;-450.9776,-91.5936;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;142;-208.2,-53.3;Inherit;False;9;AO;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-1714,-364;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;27;-1137,-372;Inherit;False;EdgeWear;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-1726.538,-257.1129;Inherit;False;Property;_EdgeWearPower;Edge Wear Power;20;0;Create;True;0;0;0;False;0;False;1;1.073;0.22;2.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;20;-1954,-364;Inherit;False;10;Metallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;10;-3116.997,-153.8337;Inherit;False;Metallic;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;139;-221.2,-261.3;Inherit;False;15;NormalMap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;131.7999,-305.3;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;HaloInfinte/Halo Infinite Spartan Visor;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;16;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;177;-4664.194,-441.6447;Inherit;False;100;100;Made for assets from Halo Infinite, Prototyped in Unreal Engine by R93_Sniper, ported to Unity in amplify by PointDevice;0;Made for assets from Halo Infinite, Protoyped in Unreal Engine by R93_Sniper, ported to Unity in amplify by PointDevice;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;456;-4753.706,1527.18;Inherit;False;100;100;This is only for use with the inbuilt gradient maps and normals from the game files. i am not liable for any oddness from miss-use;0;This is only for use with the inbuilt gradient maps and normals from the game files. i am not liable for any oddness from miss-use;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;178;-4672.927,-607.5251;Inherit;False;100;100;Comment;0;Licensed Under HPAM 1.0, You may redistribute, and modify this program, all derivitive works must carry the same license ;1,1,1,1;0;0
WireConnection;56;0;58;1
WireConnection;438;0;58;3
WireConnection;11;0;5;3
WireConnection;444;0;439;0
WireConnection;444;1;399;0
WireConnection;387;0;31;0
WireConnection;422;0;444;0
WireConnection;424;0;444;0
WireConnection;454;0;399;0
WireConnection;414;0;422;0
WireConnection;425;0;424;0
WireConnection;453;0;439;0
WireConnection;29;0;387;0
WireConnection;29;1;32;0
WireConnection;370;5;374;0
WireConnection;442;0;453;0
WireConnection;442;1;454;0
WireConnection;426;0;425;0
WireConnection;419;0;414;0
WireConnection;30;0;29;0
WireConnection;30;1;33;0
WireConnection;443;0;442;0
WireConnection;418;0;428;0
WireConnection;418;1;429;0
WireConnection;418;2;426;0
WireConnection;376;0;370;0
WireConnection;376;1;6;0
WireConnection;188;0;104;0
WireConnection;9;0;5;1
WireConnection;49;0;30;0
WireConnection;415;0;419;0
WireConnection;109;0;188;0
WireConnection;378;0;376;0
WireConnection;34;0;49;0
WireConnection;450;0;451;0
WireConnection;450;1;443;0
WireConnection;430;0;418;0
WireConnection;430;1;431;0
WireConnection;430;2;415;0
WireConnection;377;0;378;0
WireConnection;136;0;134;0
WireConnection;446;0;430;0
WireConnection;446;1;105;0
WireConnection;446;2;450;0
WireConnection;133;0;132;0
WireConnection;133;1;134;0
WireConnection;353;0;377;1
WireConnection;135;0;133;0
WireConnection;135;1;136;0
WireConnection;319;0;446;0
WireConnection;319;1;127;0
WireConnection;319;2;318;0
WireConnection;131;0;319;0
WireConnection;131;1;135;0
WireConnection;354;0;377;0
WireConnection;354;1;353;0
WireConnection;160;0;131;0
WireConnection;355;1;378;0
WireConnection;355;0;354;0
WireConnection;15;0;355;0
WireConnection;137;0;160;0
WireConnection;432;0;408;0
WireConnection;432;1;435;0
WireConnection;432;2;434;0
WireConnection;50;0;22;0
WireConnection;22;0;21;0
WireConnection;22;1;26;0
WireConnection;433;0;409;0
WireConnection;433;1;436;0
WireConnection;433;2;434;0
WireConnection;21;0;20;0
WireConnection;21;1;23;0
WireConnection;27;0;50;0
WireConnection;10;0;5;2
WireConnection;0;0;138;0
WireConnection;0;1;139;0
WireConnection;0;3;432;0
WireConnection;0;4;433;0
WireConnection;0;5;142;0
ASEEND*/
//CHKSM=9D0809109C476D46D463764701ABF55BF3102309