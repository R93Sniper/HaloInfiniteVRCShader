// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "HaloInfinte/-standard- Halo Infinite Spartan Armor"
{
	Properties
	{
		[NoScaleOffset]_ASGMap("ASGMap", 2D) = "black" {}
		[NoScaleOffset]_CC1Mask("CC1 Mask", 2D) = "black" {}
		[NoScaleOffset]_CC2Mask("CC2 Mask", 2D) = "black" {}
		[NoScaleOffset]_BumpMap("NormalMap", 2D) = "bump" {}
		[KeywordEnum(OpenGL,DirectX)] _NormalMapFormat("NormalMapFormat", Float) = 1
		_DetailAlbedoMap("DetailTexture", 2D) = "white" {}
		_AODiffuseMixing("AO Diffuse Mixing", Range( 0 , 1)) = 0.5
		[KeywordEnum(NoEmissive,Zone0Emissive,Zone1Emissive,Zone2Emissive,Zone3Emissive,Zone4Emissive,Zone5Emissive,Zone6Emissive)] _EmmisiveZone("Emmisive Zone", Float) = 0
		_EmissiveIntencity("Emissive Intencity", Range( 0 , 5)) = 1
		[Header(Zone 0)]_Color("Color 0", Color) = (1,0,0,0)
		_Zone0TileableIntensity("Zone0 Tileable Intensity ", Range( 0 , 1)) = 0
		[Header(Zone 1)]_Color1("Color 1", Color) = (0,1,0,0)
		_Zone1TileableIntensity("Zone1 Tileable Intensity ", Range( 0 , 1)) = 0
		[Header(Zone 2)]_Color2("Color 2", Color) = (0,0,1,0)
		_Zone2TileableIntensity("Zone2 Tileable Intensity ", Range( 0 , 1)) = 0
		[Header(Zone 3)]_Color3("Color 3", Color) = (0,1,1,0)
		_Zone3TileableIntensity("Zone3 Tileable Intensity ", Range( 0 , 1)) = 0
		[Header(Zone 4)]_Color4("Color 4", Color) = (1,1,0,0)
		_Zone4TileableIntensity("Zone4 Tileable Intensity ", Range( 0 , 1)) = 0
		[Header(Zone 5)]_Color5("Color 5", Color) = (1,0,1,0)
		_Zone5TileableIntensity("Zone5 Tileable Intensity ", Range( 0 , 1)) = 0
		[Header(Zone 6 Grunge)]_Color6("Color 6", Color) = (0,0,0,0)
		_GrungeAmount("Grunge Amount", Range( 0 , 1)) = 1
		_GrungePower("Grunge Power", Range( 0.22 , 2.2)) = 1
		[Header(Edge Wear Zone)]_Color7("Edge Wear Color", Color) = (0.846,0.825,0.839,0)
		_EdgeWearAmount("Edge Wear Amount", Range( 0 , 1)) = 1
		_EdgeWearPower("Edge Wear Power", Range( 0.22 , 2.2)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma multi_compile _NORMALMAPFORMAT_OPENGL _NORMALMAPFORMAT_DIRECTX
		#pragma multi_compile _EMMISIVEZONE_NOEMISSIVE _EMMISIVEZONE_ZONE0EMISSIVE _EMMISIVEZONE_ZONE1EMISSIVE _EMMISIVEZONE_ZONE2EMISSIVE _EMMISIVEZONE_ZONE3EMISSIVE _EMMISIVEZONE_ZONE4EMISSIVE _EMMISIVEZONE_ZONE5EMISSIVE _EMMISIVEZONE_ZONE6EMISSIVE
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _BumpMap;
		uniform float4 _Color;
		uniform sampler2D _CC2Mask;
		uniform float _GrungeAmount;
		uniform float _GrungePower;
		uniform sampler2D _CC1Mask;
		uniform sampler2D _ASGMap;
		uniform float _EdgeWearAmount;
		uniform float _EdgeWearPower;
		uniform sampler2D _DetailAlbedoMap;
		uniform float4 _DetailAlbedoMap_ST;
		uniform float _Zone0TileableIntensity;
		uniform float4 _Color1;
		uniform float _Zone1TileableIntensity;
		uniform float4 _Color2;
		uniform float _Zone2TileableIntensity;
		uniform float4 _Color3;
		uniform float _Zone3TileableIntensity;
		uniform float4 _Color4;
		uniform float _Zone4TileableIntensity;
		uniform float4 _Color5;
		uniform float _Zone5TileableIntensity;
		uniform float4 _Color6;
		uniform float4 _Color7;
		uniform float _AODiffuseMixing;
		uniform float _EmissiveIntencity;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BumpMap6 = i.uv_texcoord;
			float3 tex2DNode6 = UnpackNormal( tex2D( _BumpMap, uv_BumpMap6 ) );
			float3 appendResult228 = (float3(tex2DNode6.r , -tex2DNode6.g , 1.0));
			#if defined(_NORMALMAPFORMAT_OPENGL)
				float3 staticSwitch226 = tex2DNode6;
			#elif defined(_NORMALMAPFORMAT_DIRECTX)
				float3 staticSwitch226 = appendResult228;
			#else
				float3 staticSwitch226 = appendResult228;
			#endif
			float3 NormalMap15 = staticSwitch226;
			o.Normal = NormalMap15;
			float2 uv_CC2Mask8 = i.uv_texcoord;
			float4 tex2DNode8 = tex2D( _CC2Mask, uv_CC2Mask8 );
			float CC2R16 = tex2DNode8.r;
			float CC2G17 = tex2DNode8.g;
			float CC2B18 = tex2DNode8.b;
			float GrungeMask34 = saturate( pow( ( CC2B18 * _GrungeAmount ) , _GrungePower ) );
			float2 uv_CC1Mask7 = i.uv_texcoord;
			float4 tex2DNode7 = tex2D( _CC1Mask, uv_CC1Mask7 );
			float CC1R12 = saturate( ( ( tex2DNode7.r - CC2R16 ) - CC2G17 ) );
			float CC1G13 = tex2DNode7.g;
			float CC1B14 = saturate( ( ( tex2DNode7.b - CC2R16 ) - CC2G17 ) );
			float Zone0Mask52 = ( 1.0 - saturate( ( CC2R16 + CC2G17 + GrungeMask34 + CC1R12 + CC1G13 + CC1B14 ) ) );
			float2 uv_ASGMap5 = i.uv_texcoord;
			float4 tex2DNode5 = tex2D( _ASGMap, uv_ASGMap5 );
			float Metallic10 = tex2DNode5.g;
			float EdgeWear27 = saturate( pow( ( Metallic10 * _EdgeWearAmount ) , _EdgeWearPower ) );
			float2 uv_DetailAlbedoMap = i.uv_texcoord * _DetailAlbedoMap_ST.xy + _DetailAlbedoMap_ST.zw;
			float3 DetailColor56 = (tex2D( _DetailAlbedoMap, uv_DetailAlbedoMap )).rgb;
			float temp_output_12_0_g103 = _Zone0TileableIntensity;
			float3 Zone0Color112 = saturate( ( ( _Color * saturate( ( Zone0Mask52 - EdgeWear27 ) ) ).rgb * ( ( DetailColor56 * temp_output_12_0_g103 ) + ( 1.0 - temp_output_12_0_g103 ) ) ) );
			float temp_output_12_0_g101 = _Zone1TileableIntensity;
			float3 Zone1Color113 = saturate( ( ( _Color1 * saturate( ( CC1R12 - EdgeWear27 ) ) ).rgb * ( ( DetailColor56 * temp_output_12_0_g101 ) + ( 1.0 - temp_output_12_0_g101 ) ) ) );
			float temp_output_12_0_g104 = _Zone2TileableIntensity;
			float3 Zone2Color111 = saturate( ( ( _Color2 * saturate( ( CC1G13 - EdgeWear27 ) ) ).rgb * ( ( DetailColor56 * temp_output_12_0_g104 ) + ( 1.0 - temp_output_12_0_g104 ) ) ) );
			float temp_output_12_0_g105 = _Zone3TileableIntensity;
			float3 Zone3Color114 = saturate( ( ( _Color3 * saturate( ( CC1B14 - EdgeWear27 ) ) ).rgb * ( ( DetailColor56 * temp_output_12_0_g105 ) + ( 1.0 - temp_output_12_0_g105 ) ) ) );
			float temp_output_12_0_g102 = _Zone4TileableIntensity;
			float3 Zone4Color110 = saturate( ( ( _Color4 * saturate( ( CC2R16 - EdgeWear27 ) ) ).rgb * ( ( DetailColor56 * temp_output_12_0_g102 ) + ( 1.0 - temp_output_12_0_g102 ) ) ) );
			float temp_output_12_0_g96 = _Zone5TileableIntensity;
			float3 Zone5Color115 = saturate( ( ( _Color5 * saturate( ( CC2G17 - EdgeWear27 ) ) ).rgb * ( ( DetailColor56 * temp_output_12_0_g96 ) + ( 1.0 - temp_output_12_0_g96 ) ) ) );
			float3 Zone6Color109 = (( _Color6 * GrungeMask34 )).rgb;
			float3 EdgeWearColor108 = (( _Color7 * EdgeWear27 )).rgb;
			float AO9 = tex2DNode5.r;
			float3 FinalColor137 = saturate( ( ( Zone0Color112 + Zone1Color113 + Zone2Color111 + Zone3Color114 + Zone4Color110 + Zone5Color115 + Zone6Color109 + EdgeWearColor108 ) * ( ( AO9 * _AODiffuseMixing ) + ( 1.0 - _AODiffuseMixing ) ) ) );
			o.Albedo = FinalColor137;
			float3 temp_cast_6 = (0.0).xxx;
			float3 temp_cast_7 = (0.0).xxx;
			#if defined(_EMMISIVEZONE_NOEMISSIVE)
				float3 staticSwitch179 = temp_cast_6;
			#elif defined(_EMMISIVEZONE_ZONE0EMISSIVE)
				float3 staticSwitch179 = Zone0Color112;
			#elif defined(_EMMISIVEZONE_ZONE1EMISSIVE)
				float3 staticSwitch179 = Zone1Color113;
			#elif defined(_EMMISIVEZONE_ZONE2EMISSIVE)
				float3 staticSwitch179 = Zone2Color111;
			#elif defined(_EMMISIVEZONE_ZONE3EMISSIVE)
				float3 staticSwitch179 = Zone3Color114;
			#elif defined(_EMMISIVEZONE_ZONE4EMISSIVE)
				float3 staticSwitch179 = Zone4Color110;
			#elif defined(_EMMISIVEZONE_ZONE5EMISSIVE)
				float3 staticSwitch179 = Zone5Color115;
			#elif defined(_EMMISIVEZONE_ZONE6EMISSIVE)
				float3 staticSwitch179 = Zone6Color109;
			#else
				float3 staticSwitch179 = temp_cast_6;
			#endif
			float3 Emissive191 = ( _EmissiveIntencity * staticSwitch179 );
			o.Emission = Emissive191;
			o.Metallic = EdgeWear27;
			float Smoothness11 = tex2DNode5.b;
			o.Smoothness = Smoothness11;
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
340;182;1529;792;581.5359;407.9892;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;19;-3993.566,-395.7;Inherit;False;1817.066;705.7537;Texture Input;24;11;9;10;5;225;12;14;224;223;222;221;220;219;17;16;18;8;13;7;15;6;226;228;227;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;176;-2116,-378;Inherit;False;1513;694;Simple Contrast/knee adjustment for wear and grunge;4;35;36;49;50;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;8;-3962.764,107.7533;Inherit;True;Property;_CC2Mask;CC2 Mask;2;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;d7750123d20a80a448fff62be9295f89;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;35;-2066,-18;Inherit;False;1413;329;Grunge;6;34;33;32;31;30;29;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;18;-3674.764,235.7534;Inherit;False;CC2B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;17;-3674.764,171.7534;Inherit;False;CC2G;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;7;-3962.912,-78.99922;Inherit;True;Property;_CC1Mask;CC1 Mask;1;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;bd0b6017b4fc1184e959b2d359d6a401;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;31;-1984,32;Inherit;False;18;CC2B;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;16;-3674.764,107.7533;Inherit;False;CC2R;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-2040,109;Inherit;False;Property;_GrungeAmount;Grunge Amount;22;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;225;-3375.197,191.3522;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-2042,179;Inherit;False;Property;_GrungePower;Grunge Power;23;0;Create;True;0;0;0;False;0;False;1;8.4;0.22;2.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-1698.55,37.23729;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;220;-3439.623,-2.51119;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;219;-3437.692,90.2029;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;222;-3263.259,152.3056;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;30;-1538.02,40.63464;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;221;-3257.277,61.58279;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;223;-3133.966,157.7545;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;224;-3133.966,61.75436;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;5;-3966.276,-341.7149;Inherit;True;Property;_ASGMap;ASGMap;0;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;48b80d9fae464324f8bd70222b7c27f1;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;49;-1410.02,40.63464;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;174;-591.9655,-372.664;Inherit;False;997.9117;485;BaseColorMask, inverse of all other zones;10;38;42;41;37;40;39;45;51;146;52;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;13;-3685.313,-26.69921;Inherit;False;CC1G;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;10;-3678.276,-277.715;Inherit;False;Metallic;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;36;-2065,-328;Inherit;False;1412;335;Wear;6;20;22;21;27;26;23;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;14;-3016.322,152.4733;Inherit;False;CC1B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;12;-3000.322,56.47324;Inherit;False;CC1R;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;34;-1280.278,34.90771;Inherit;False;GrungeMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;41;-541.9654,-66.66418;Inherit;False;13;CC1G;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;20;-1919,-278;Inherit;False;10;Metallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;38;-541.9654,-258.6643;Inherit;False;17;CC2G;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-2015,-214;Inherit;False;Property;_EdgeWearAmount;Edge Wear Amount;25;0;Create;True;0;0;0;False;0;False;1;0.9;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;40;-541.9654,-130.6642;Inherit;False;12;CC1R;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;37;-541.9654,-322.664;Inherit;False;16;CC2R;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;42;-541.9654,-2.664193;Inherit;False;14;CC1B;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;39;-541.9654,-194.6643;Inherit;False;34;GrungeMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-2010.538,-145.1129;Inherit;False;Property;_EdgeWearPower;Edge Wear Power;26;0;Create;True;0;0;0;False;0;False;1;10;0.22;2.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-1679,-278;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;45;-269.9655,-226.6643;Inherit;False;6;6;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;22;-1504,-272;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;146;-160,-224;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;175;-4656.449,335.5491;Inherit;False;4770.954;1117.542;ZoneClorization;8;171;170;169;168;167;166;165;164;;1,1,1,1;0;0
Node;AmplifyShaderEditor.OneMinusNode;51;-32,-224;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;50;-1376,-272;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;168;-4606.449,923.1078;Inherit;False;1234;489;ColorZone1;10;63;143;144;68;145;64;65;69;66;113;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;27;-1232,-272;Inherit;False;EdgeWear;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;165;-3371.885,387.1251;Inherit;False;1249.1;473.4995;ColorZone2;10;152;73;151;150;76;74;75;71;70;111;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;161;-5005.38,-65.35678;Inherit;False;812.3411;280;Tileable texture Input and Chacing ;3;58;59;56;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;52;162.9462,-229.5894;Inherit;False;Zone0Mask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;169;-3365.632,925.0906;Inherit;False;1287.807;528;ColorZone3;10;149;80;148;83;147;77;78;82;114;81;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;170;-2070.864,926.5673;Inherit;False;1221;510;ColorZone5;10;158;94;157;156;97;95;92;91;96;115;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;164;-4605.476,385.5491;Inherit;False;1228.8;531.4999;ColorZone0;10;47;53;46;163;4;61;62;60;54;112;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;166;-2119.803,386.3632;Inherit;False;1245.797;485.7687;ColorZone4;10;87;155;154;90;153;88;84;85;89;110;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;73;-3245.785,597.1251;Inherit;False;13;CC1G;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;158;-1956.865,1232.567;Inherit;False;27;EdgeWear;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;80;-3220.632,1154.091;Inherit;False;14;CC1B;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;152;-3246.284,669.0932;Inherit;False;27;EdgeWear;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;94;-1956.865,1152.567;Inherit;False;17;CC2G;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;58;-4955.38,-15.35677;Inherit;True;Property;_DetailAlbedoMap;DetailTexture;5;0;Create;False;0;0;0;False;0;False;-1;None;3ee0c06ad3bf2134fb04893b5d83e42a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;53;-4507.612,620.2418;Inherit;False;52;Zone0Mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;155;-1989.007,657.3628;Inherit;False;27;EdgeWear;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;63;-4479.449,1133.108;Inherit;False;12;CC1R;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;87;-1981.007,596.3628;Inherit;False;16;CC2R;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;47;-4501.309,696.0551;Inherit;False;27;EdgeWear;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;143;-4478.492,1200.77;Inherit;False;27;EdgeWear;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;149;-3219.877,1221.544;Inherit;False;27;EdgeWear;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;151;-3071.24,617.4312;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;46;-4301.309,648.0552;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;167;-868.4949,389.5759;Inherit;False;933;325;ColorZone6 Grunge Color;5;101;104;98;109;188;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;148;-3044.834,1169.882;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;171;-839.3092,932.5456;Inherit;False;878;325;EdgeWearColor;5;105;106;107;129;108;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ComponentMaskNode;59;-4660.037,-10.91726;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;157;-1780.865,1184.567;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;154;-1813.007,609.3628;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;144;-4303.448,1149.108;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;145;-4175.45,1165.108;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;4;-4483.676,435.5491;Inherit;False;Property;_Color;Color 0;9;1;[Header];Create;False;1;Zone 0;0;0;False;0;False;1,0,0,0;0,0.3570165,0.6431373,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;64;-4556.449,1297.108;Inherit;False;Property;_Zone1TileableIntensity;Zone1 Tileable Intensity ;12;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;61;-4555.476,802.0487;Inherit;False;Property;_Zone0TileableIntensity;Zone0 Tileable Intensity ;10;0;Create;True;0;0;0;False;0;False;0;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;101;-818.4949,599.5756;Inherit;False;34;GrungeMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;104;-818.4949,439.5759;Inherit;False;Property;_Color6;Color 6;21;1;[Header];Create;True;1;Zone 6 Grunge;0;0;False;0;False;0,0,0,0;0.6981132,0.6319392,0.510413,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;147;-2916.834,1185.882;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;95;-2020.865,1321.567;Inherit;False;Property;_Zone5TileableIntensity;Zone5 Tileable Intensity ;20;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;106;-757.3092,1142.546;Inherit;False;27;EdgeWear;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;81;-3315.632,1338.091;Inherit;False;Property;_Zone3TileableIntensity;Zone3 Tileable Intensity ;16;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;56;-4436.038,-10.91726;Inherit;False;DetailColor;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;74;-3321.885,745.6246;Inherit;False;Property;_Zone2TileableIntensity;Zone2 Tileable Intensity ;14;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;97;-1956.865,976.5673;Inherit;False;Property;_Color5;Color 5;19;1;[Header];Create;True;1;Zone 5;0;0;False;0;False;1,0,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;88;-2069.804,757.1315;Inherit;False;Property;_Zone4TileableIntensity;Zone4 Tileable Intensity ;18;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;150;-2943.24,633.4312;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;163;-4179.676,643.5488;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;105;-789.3092,982.5456;Inherit;False;Property;_Color7;Edge Wear Color;24;1;[Header];Create;False;1;Edge Wear Zone;0;0;False;0;False;0.846,0.825,0.839,0;0.8396226,0.8396226,0.8396226,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;156;-1652.865,1200.567;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;83;-3214.632,975.0906;Inherit;False;Property;_Color3;Color 3;15;1;[Header];Create;True;1;Zone 3;0;0;False;0;False;0,1,1,0;0.764151,0.764151,0.764151,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;76;-3245.785,437.1251;Inherit;False;Property;_Color2;Color 2;13;1;[Header];Create;True;1;Zone 2;0;0;False;0;False;0,0,1,0;0.6320754,0.6320754,0.6320754,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;90;-1981.007,436.3632;Inherit;False;Property;_Color4;Color 4;17;1;[Header];Create;True;1;Zone 4;0;0;False;0;False;1,1,0,0;0.3113207,0.3113207,0.3113207,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;153;-1685.007,625.3628;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;68;-4479.449,973.1078;Inherit;False;Property;_Color1;Color 1;11;1;[Header];Create;True;1;Zone 1;0;0;False;0;False;0,1,0,0;0.8584906,0.48347,0.06074216,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;78;-2942.632,1103.091;Inherit;False;56;DetailColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;84;-1533.007,436.3632;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;70;-2813.785,453.1251;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;62;-3979.476,802.0487;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;89;-1525.804,773.1315;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;85;-1709.007,564.3628;Inherit;False;56;DetailColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;66;-4127.45,1101.108;Inherit;False;56;DetailColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;107;-533.3094,998.5456;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;69;-4012.45,1313.108;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;98;-545.4947,442.576;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;91;-1508.865,992.5673;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;75;-2761.885,761.6246;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;-4047.45,973.1078;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;77;-2782.632,991.0906;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;92;-1668.865,1104.567;Inherit;False;56;DetailColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;54;-4035.676,467.549;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;82;-2748.632,1340.091;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;60;-4195.676,563.5488;Inherit;False;56;DetailColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;96;-1476.865,1337.567;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;71;-2973.785,565.1251;Inherit;False;56;DetailColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;216;-2638.632,1023.091;Inherit;False;MF_SimpleDetailDiffuse;-1;;105;e6e4a2444c47f7a42bdb4a4522f8e7eb;0;3;1;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;12;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;213;-3907.676,483.549;Inherit;False;MF_SimpleDetailDiffuse;-1;;103;e6e4a2444c47f7a42bdb4a4522f8e7eb;0;3;1;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;12;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;129;-405.3095,998.5456;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;214;-2669.785,485.125;Inherit;False;MF_SimpleDetailDiffuse;-1;;104;e6e4a2444c47f7a42bdb4a4522f8e7eb;0;3;1;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;12;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;188;-420.3916,439.7839;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;215;-1405.007,468.363;Inherit;False;MF_SimpleDetailDiffuse;-1;;102;e6e4a2444c47f7a42bdb4a4522f8e7eb;0;3;1;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;12;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;172;352.7389,365.8602;Inherit;False;1516.961;589.8345;Final Color Mixing;17;132;135;133;136;134;137;160;131;130;126;123;127;124;122;121;128;125;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;9;-3678.276,-341.7149;Inherit;False;AO;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;212;-1380.865,1024.567;Inherit;False;MF_SimpleDetailDiffuse;-1;;96;e6e4a2444c47f7a42bdb4a4522f8e7eb;0;3;1;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;12;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;217;-3903.45,1021.108;Inherit;False;MF_SimpleDetailDiffuse;-1;;101;e6e4a2444c47f7a42bdb4a4522f8e7eb;0;3;1;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;12;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;108;-213.3093,998.5456;Inherit;False;EdgeWearColor;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;109;-228.4949,439.576;Inherit;False;Zone6Color;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;111;-2365.786,485.125;Inherit;False;Zone2Color;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;134;688,848;Inherit;False;Property;_AODiffuseMixing;AO Diffuse Mixing;6;0;Create;True;0;0;0;False;0;False;0.5;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;113;-3615.45,1021.108;Inherit;False;Zone1Color;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;132;690.7389,751.8601;Inherit;False;9;AO;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;114;-2320.825,1028.262;Inherit;False;Zone3Color;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;112;-3619.676,483.549;Inherit;False;Zone0Color;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;110;-1117.007,468.363;Inherit;False;Zone4Color;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;115;-1092.865,1024.567;Inherit;False;Zone5Color;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;121;402.7389,415.8601;Inherit;False;112;Zone0Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;6;-3432.409,-335.6874;Inherit;True;Property;_BumpMap;NormalMap;3;1;[NoScaleOffset];Create;False;0;0;0;False;0;False;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;125;402.7389,671.8604;Inherit;False;110;Zone4Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;133;976,752;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;136;976,848;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;128;402.7389,863.8607;Inherit;False;108;EdgeWearColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;193;352,960;Inherit;False;1171.705;567.4536;Emissive switch ;12;183;181;184;182;180;185;187;186;179;189;190;191;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;127;402.7389,799.8605;Inherit;False;109;Zone6Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;126;402.7389,735.8603;Inherit;False;115;Zone5Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;124;402.7389,607.8604;Inherit;False;114;Zone3Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;123;402.7389,543.8604;Inherit;False;111;Zone2Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;122;402.7389,479.8603;Inherit;False;113;Zone1Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;182;400,1152;Inherit;False;111;Zone2Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;180;656,1008;Inherit;False;Constant;_Const0;Const0;25;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;130;690.7389,527.8604;Inherit;False;8;8;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NegateNode;227;-3154.477,-234.5404;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;181;400,1024;Inherit;False;112;Zone0Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;187;400,1280;Inherit;False;110;Zone4Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;186;400,1088;Inherit;False;113;Zone1Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;183;400,1216;Inherit;False;114;Zone3Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;184;400,1408;Inherit;False;109;Zone6Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;185;400,1344;Inherit;False;115;Zone5Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;135;1152,752;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;179;832,1104;Inherit;False;Property;_EmmisiveZone;Emmisive Zone;7;0;Create;True;0;0;0;False;0;False;1;0;0;True;;KeywordEnum;8;NoEmissive;Zone0Emissive;Zone1Emissive;Zone2Emissive;Zone3Emissive;Zone4Emissive;Zone5Emissive;Zone6Emissive;Create;False;True;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;131;1362.739,527.8604;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;228;-3021.477,-269.5404;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;189;848,1040;Inherit;False;Property;_EmissiveIntencity;Emissive Intencity;8;0;Create;True;0;0;0;False;0;False;1;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;190;1152,1088;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;160;1499.2,540.3264;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;226;-2844.863,-337.6732;Inherit;False;Property;_NormalMapFormat;NormalMapFormat;4;0;Create;True;0;0;0;False;0;False;1;1;1;True;;KeywordEnum;2;OpenGL;DirectX;Create;False;True;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;173;432,-192;Inherit;False;730.3523;471.1918;Output;7;141;142;192;139;138;0;140;v 0.35 I am the Yin;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;15;-2612.273,-339.3606;Inherit;False;NormalMap;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;191;1280,1088;Inherit;False;Emissive;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;11;-3678.276,-213.7151;Inherit;False;Smoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;137;1634.739,527.8604;Inherit;False;FinalColor;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;140;480,48;Inherit;False;27;EdgeWear;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;139;480,-80;Inherit;False;15;NormalMap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;192;480,-16;Inherit;False;191;Emissive;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;138;480,-144;Inherit;False;137;FinalColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;141;480,112;Inherit;False;11;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;142;480,176;Inherit;False;9;AO;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;896,-144;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;HaloInfinte/-standard- Halo Infinite Spartan Armor;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;178;-4672.927,-607.5251;Inherit;False;100;100;Comment;0;Licensed Under AGPL 3.0, You may redistribute, and modify this program, all derivitive works must carry the same license ;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;177;-4667.682,-406.7653;Inherit;False;100;100;Made for assets from Halo Infinite, Protoyped in Unreal Engine by R93_Sniper, ported to Unity in amplify by PointDevice;0;Made for assets from Halo Infinite, Protoyped in Unreal Engine by R93_Sniper, ported to Unity in amplify by PointDevice;1,1,1,1;0;0
WireConnection;18;0;8;3
WireConnection;17;0;8;2
WireConnection;16;0;8;1
WireConnection;225;0;17;0
WireConnection;29;0;31;0
WireConnection;29;1;32;0
WireConnection;220;0;7;1
WireConnection;220;1;16;0
WireConnection;219;0;7;3
WireConnection;219;1;16;0
WireConnection;222;0;219;0
WireConnection;222;1;225;0
WireConnection;30;0;29;0
WireConnection;30;1;33;0
WireConnection;221;0;220;0
WireConnection;221;1;225;0
WireConnection;223;0;222;0
WireConnection;224;0;221;0
WireConnection;49;0;30;0
WireConnection;13;0;7;2
WireConnection;10;0;5;2
WireConnection;14;0;223;0
WireConnection;12;0;224;0
WireConnection;34;0;49;0
WireConnection;21;0;20;0
WireConnection;21;1;23;0
WireConnection;45;0;37;0
WireConnection;45;1;38;0
WireConnection;45;2;39;0
WireConnection;45;3;40;0
WireConnection;45;4;41;0
WireConnection;45;5;42;0
WireConnection;22;0;21;0
WireConnection;22;1;26;0
WireConnection;146;0;45;0
WireConnection;51;0;146;0
WireConnection;50;0;22;0
WireConnection;27;0;50;0
WireConnection;52;0;51;0
WireConnection;151;0;73;0
WireConnection;151;1;152;0
WireConnection;46;0;53;0
WireConnection;46;1;47;0
WireConnection;148;0;80;0
WireConnection;148;1;149;0
WireConnection;59;0;58;0
WireConnection;157;0;94;0
WireConnection;157;1;158;0
WireConnection;154;0;87;0
WireConnection;154;1;155;0
WireConnection;144;0;63;0
WireConnection;144;1;143;0
WireConnection;145;0;144;0
WireConnection;147;0;148;0
WireConnection;56;0;59;0
WireConnection;150;0;151;0
WireConnection;163;0;46;0
WireConnection;156;0;157;0
WireConnection;153;0;154;0
WireConnection;84;0;90;0
WireConnection;84;1;153;0
WireConnection;70;0;76;0
WireConnection;70;1;150;0
WireConnection;62;0;61;0
WireConnection;89;0;88;0
WireConnection;107;0;105;0
WireConnection;107;1;106;0
WireConnection;69;0;64;0
WireConnection;98;0;104;0
WireConnection;98;1;101;0
WireConnection;91;0;97;0
WireConnection;91;1;156;0
WireConnection;75;0;74;0
WireConnection;65;0;68;0
WireConnection;65;1;145;0
WireConnection;77;0;83;0
WireConnection;77;1;147;0
WireConnection;54;0;4;0
WireConnection;54;1;163;0
WireConnection;82;0;81;0
WireConnection;96;0;95;0
WireConnection;216;1;77;0
WireConnection;216;6;78;0
WireConnection;216;12;82;0
WireConnection;213;1;54;0
WireConnection;213;6;60;0
WireConnection;213;12;62;0
WireConnection;129;0;107;0
WireConnection;214;1;70;0
WireConnection;214;6;71;0
WireConnection;214;12;75;0
WireConnection;188;0;98;0
WireConnection;215;1;84;0
WireConnection;215;6;85;0
WireConnection;215;12;89;0
WireConnection;9;0;5;1
WireConnection;212;1;91;0
WireConnection;212;6;92;0
WireConnection;212;12;96;0
WireConnection;217;1;65;0
WireConnection;217;6;66;0
WireConnection;217;12;69;0
WireConnection;108;0;129;0
WireConnection;109;0;188;0
WireConnection;111;0;214;0
WireConnection;113;0;217;0
WireConnection;114;0;216;0
WireConnection;112;0;213;0
WireConnection;110;0;215;0
WireConnection;115;0;212;0
WireConnection;133;0;132;0
WireConnection;133;1;134;0
WireConnection;136;0;134;0
WireConnection;130;0;121;0
WireConnection;130;1;122;0
WireConnection;130;2;123;0
WireConnection;130;3;124;0
WireConnection;130;4;125;0
WireConnection;130;5;126;0
WireConnection;130;6;127;0
WireConnection;130;7;128;0
WireConnection;227;0;6;2
WireConnection;135;0;133;0
WireConnection;135;1;136;0
WireConnection;179;1;180;0
WireConnection;179;0;181;0
WireConnection;179;2;186;0
WireConnection;179;3;182;0
WireConnection;179;4;183;0
WireConnection;179;5;187;0
WireConnection;179;6;185;0
WireConnection;179;7;184;0
WireConnection;131;0;130;0
WireConnection;131;1;135;0
WireConnection;228;0;6;1
WireConnection;228;1;227;0
WireConnection;190;0;189;0
WireConnection;190;1;179;0
WireConnection;160;0;131;0
WireConnection;226;1;6;0
WireConnection;226;0;228;0
WireConnection;15;0;226;0
WireConnection;191;0;190;0
WireConnection;11;0;5;3
WireConnection;137;0;160;0
WireConnection;0;0;138;0
WireConnection;0;1;139;0
WireConnection;0;2;192;0
WireConnection;0;3;140;0
WireConnection;0;4;141;0
WireConnection;0;5;142;0
ASEEND*/
//CHKSM=010EBF64353180993D8545E6989748D52E955203