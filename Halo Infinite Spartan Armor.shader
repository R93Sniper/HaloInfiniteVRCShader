// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "HaloInfinte/ArmorBase"
{
	Properties
	{
		[NoScaleOffset]_ASGMap("ASGMap", 2D) = "white" {}
		[NoScaleOffset]_CC1Mask("CC1 Mask", 2D) = "black" {}
		[NoScaleOffset]_CC2Mask("CC2 Mask", 2D) = "black" {}
		[NoScaleOffset]_BumpMap("NormalMap", 2D) = "bump" {}
		_DetailTexture("DetailTexture", 2D) = "white" {}
		_AODiffuseMixing("AO DiffuseMixing", Range( 0 , 1)) = 1
		[KeywordEnum(NoEmissive,Zone0Emissive,Zone1Emissive,Zone2Emissive,Zone3Emissive,Zone4Emissive,Zone5Emissive,Zone6Emissive)] _EmmisiveZone("EmmisiveZone", Float) = 0
		_EmissiveIntencity("EmissiveIntencity", Range( 0 , 5)) = 0
		_Color0("Color 0", Color) = (1,0,0,0)
		_Zone0TileableIntensity("Zone0 Tileable Intensity ", Range( 0 , 1)) = 0
		_Color1("Color 1", Color) = (0,1,0,0)
		_Zone1TileableIntensity("Zone1 Tileable Intensity ", Range( 0 , 1)) = 0
		_Color2("Color 2", Color) = (0,0,1,0)
		_Zone2TileableIntensity("Zone2 Tileable Intensity ", Range( 0 , 1)) = 0
		_Color3("Color 3", Color) = (0,1,1,0)
		_Zone3TileableIntensity("Zone3 Tileable Intensity ", Range( 0 , 1)) = 0
		_Color4("Color 4", Color) = (1,1,0,0)
		_Zone4TileableIntensity("Zone4 Tileable Intensity ", Range( 0 , 1)) = 0
		_Color5("Color 5", Color) = (1,0,1,0)
		_Zone5TileableIntensity("Zone5 Tileable Intensity ", Range( 0 , 1)) = 0
		_Color6("Color 6", Color) = (0,0,0,0)
		_GrungeAmmount("Grunge Ammount", Range( 0 , 1)) = 1
		_MaxGrungePower("Max Grunge Power", Range( 0 , 30)) = 3
		_Color7("EdgeWearColor", Color) = (0.846,0.825,0.839,0)
		_EdgeWearAmmount("EdgeWearAmmount", Range( 0 , 1)) = 0.9
		_MaxEdgeWearPower("Max EdgeWear Power", Range( 0 , 30)) = 10
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma multi_compile _EMMISIVEZONE_NOEMISSIVE _EMMISIVEZONE_ZONE0EMISSIVE _EMMISIVEZONE_ZONE1EMISSIVE _EMMISIVEZONE_ZONE2EMISSIVE _EMMISIVEZONE_ZONE3EMISSIVE _EMMISIVEZONE_ZONE4EMISSIVE _EMMISIVEZONE_ZONE5EMISSIVE _EMMISIVEZONE_ZONE6EMISSIVE
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _BumpMap;
		uniform float4 _Color0;
		uniform sampler2D _CC2Mask;
		uniform float _GrungeAmmount;
		uniform float _MaxGrungePower;
		uniform sampler2D _CC1Mask;
		uniform sampler2D _ASGMap;
		uniform float _EdgeWearAmmount;
		uniform float _MaxEdgeWearPower;
		uniform sampler2D _DetailTexture;
		uniform float4 _DetailTexture_ST;
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
			float3 NormalMap15 = UnpackNormal( tex2D( _BumpMap, uv_BumpMap6 ) );
			o.Normal = NormalMap15;
			float2 uv_CC2Mask8 = i.uv_texcoord;
			float4 tex2DNode8 = tex2D( _CC2Mask, uv_CC2Mask8 );
			float CC2R16 = tex2DNode8.r;
			float CC2G17 = tex2DNode8.g;
			float CC2B18 = tex2DNode8.b;
			float lerpResult28 = lerp( _MaxGrungePower , 1.0 , _GrungeAmmount);
			float GrungeMask34 = saturate( pow( ( CC2B18 * _GrungeAmmount ) , lerpResult28 ) );
			float2 uv_CC1Mask7 = i.uv_texcoord;
			float4 tex2DNode7 = tex2D( _CC1Mask, uv_CC1Mask7 );
			float CC1R12 = tex2DNode7.r;
			float CC1G13 = tex2DNode7.g;
			float CC1B14 = tex2DNode7.b;
			float Zone0Mask52 = saturate( ( 1.0 - ( CC2R16 + CC2G17 + GrungeMask34 + CC1R12 + CC1G13 + CC1B14 ) ) );
			float2 uv_ASGMap5 = i.uv_texcoord;
			float4 tex2DNode5 = tex2D( _ASGMap, uv_ASGMap5 );
			float Metallic10 = tex2DNode5.g;
			float lerpResult24 = lerp( _MaxEdgeWearPower , 1.0 , _EdgeWearAmmount);
			float EdgeWear27 = saturate( pow( ( Metallic10 * _EdgeWearAmmount ) , lerpResult24 ) );
			float2 uv_DetailTexture = i.uv_texcoord * _DetailTexture_ST.xy + _DetailTexture_ST.zw;
			float3 DetailColor56 = (tex2D( _DetailTexture, uv_DetailTexture )).rgb;
			float3 lerpResult4_g75 = lerp( float3( 1,1,1 ) , ( float3( 0.5,0.5,0.5 ) + DetailColor56 ) , _Zone0TileableIntensity);
			float3 Zone0Color112 = saturate( ( ( _Color0 * saturate( ( Zone0Mask52 - EdgeWear27 ) ) ).rgb * lerpResult4_g75 ) );
			float3 lerpResult4_g76 = lerp( float3( 1,1,1 ) , ( float3( 0.5,0.5,0.5 ) + DetailColor56 ) , _Zone1TileableIntensity);
			float3 Zone1Color113 = saturate( ( ( _Color1 * saturate( ( CC1R12 - EdgeWear27 ) ) ).rgb * lerpResult4_g76 ) );
			float3 lerpResult4_g72 = lerp( float3( 1,1,1 ) , ( float3( 0.5,0.5,0.5 ) + DetailColor56 ) , _Zone2TileableIntensity);
			float3 Zone2Color111 = saturate( ( ( _Color2 * saturate( ( CC1G13 - EdgeWear27 ) ) ).rgb * lerpResult4_g72 ) );
			float3 lerpResult4_g77 = lerp( float3( 1,1,1 ) , ( float3( 0.5,0.5,0.5 ) + DetailColor56 ) , _Zone3TileableIntensity);
			float3 Zone3Color114 = saturate( ( ( _Color3 * saturate( ( CC1B14 - EdgeWear27 ) ) ).rgb * lerpResult4_g77 ) );
			float3 lerpResult4_g74 = lerp( float3( 1,1,1 ) , ( float3( 0.5,0.5,0.5 ) + DetailColor56 ) , _Zone4TileableIntensity);
			float3 Zone4Color110 = saturate( ( ( _Color4 * saturate( ( CC2R16 - EdgeWear27 ) ) ).rgb * lerpResult4_g74 ) );
			float3 lerpResult4_g73 = lerp( float3( 1,1,1 ) , ( float3( 0.5,0.5,0.5 ) + DetailColor56 ) , _Zone5TileableIntensity);
			float3 Zone5Color115 = saturate( ( ( _Color5 * saturate( ( CC2G17 - EdgeWear27 ) ) ).rgb * lerpResult4_g73 ) );
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
			o.Metallic = Metallic10;
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
Version=18301
1913;191;1529;910;2339.084;317.6315;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;19;-3378,-306;Inherit;False;1221;549;Texture Input;14;5;10;9;11;7;13;14;12;8;6;15;16;17;18;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;8;-2688,0;Inherit;True;Property;_CC2Mask;CC2 Mask;2;1;[NoScaleOffset];Create;True;0;0;False;0;False;-1;None;847f48e5ea2489b4f83b417f1334492a;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;176;-2116,-378;Inherit;False;1513;694;Simple Contrast/knee adjustment for wear and grunge;4;35;36;49;50;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;18;-2400,128;Inherit;False;CC2B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;35;-2066,-18;Inherit;False;1413;329;Grunge;7;34;33;32;31;30;29;28;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-2016,192;Inherit;False;Property;_GrungeAmmount;Grunge Ammount;21;0;Create;True;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;31;-1984,32;Inherit;False;18;CC2B;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-1712,128;Inherit;False;Property;_MaxGrungePower;Max Grunge Power;22;0;Create;True;0;0;False;0;False;3;0.1;0;30;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;28;-1440,160;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-1698.55,37.23729;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;30;-1184,32;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;5;-3328,-240;Inherit;True;Property;_ASGMap;ASGMap;0;1;[NoScaleOffset];Create;True;0;0;False;0;False;-1;None;b4222d1c348c65e4282d3d5ad959f08f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;7;-3328,0;Inherit;True;Property;_CC1Mask;CC1 Mask;1;1;[NoScaleOffset];Create;True;0;0;False;0;False;-1;None;1229170e60484504f9c850e610c2d064;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;36;-2065,-328;Inherit;False;1412;335;Wear;8;20;22;21;24;27;26;23;25;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;49;-1056,32;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;10;-3040,-176;Inherit;False;Metallic;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;34;-852,28;Inherit;False;GrungeMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;12;-3040,0;Inherit;False;CC1R;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;16;-2400,0;Inherit;False;CC2R;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;13;-3040,64;Inherit;False;CC1G;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;14;-3040,128;Inherit;False;CC1B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;17;-2400,64;Inherit;False;CC2G;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;174;-591.9655,-372.664;Inherit;False;997.9117;485;BaseColorMask, inverse of all other zones;10;38;42;41;37;40;39;45;51;146;52;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-2015,-214;Inherit;False;Property;_EdgeWearAmmount;EdgeWearAmmount;24;0;Create;True;0;0;False;0;False;0.9;0.868;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;39;-541.9654,-194.6643;Inherit;False;34;GrungeMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;25;-1748.538,-83.11292;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;38;-541.9654,-258.6643;Inherit;False;17;CC2G;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;42;-541.9654,-2.664193;Inherit;False;14;CC1B;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;20;-1919,-278;Inherit;False;10;Metallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;37;-541.9654,-322.664;Inherit;False;16;CC2R;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;41;-541.9654,-66.66418;Inherit;False;13;CC1G;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;40;-541.9654,-130.6642;Inherit;False;12;CC1R;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-1691.538,-171.1129;Inherit;False;Property;_MaxEdgeWearPower;Max EdgeWear Power;25;0;Create;True;0;0;False;0;False;10;7.5;0;30;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;45;-269.9655,-226.6643;Inherit;False;6;6;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-1679,-278;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;24;-1407,-150;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;51;-116.9655,-224.6643;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;22;-1151,-278;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;50;-1024,-272;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;175;-4656.449,335.5491;Inherit;False;4770.954;1117.542;ZoneClorization;8;171;170;169;168;167;166;165;164;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;146;30.39991,-226.6643;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;169;-3365.632,925.0906;Inherit;False;1287.807;528;ColorZone3;10;149;80;148;83;147;77;78;82;114;81;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;164;-4605.476,385.5491;Inherit;False;1228.8;531.4999;ColorZone0;10;47;53;46;163;4;61;62;60;54;112;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;170;-2070.864,926.5673;Inherit;False;1221;510;ColorZone5;10;158;94;157;156;97;95;92;91;96;115;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;161;-4277.786,-59.16451;Inherit;False;812.3411;280;Tileable texture Input and Chacing ;3;58;59;56;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;165;-3371.885,387.1251;Inherit;False;1249.1;473.4995;ColorZone2;10;152;73;151;150;76;74;75;71;70;111;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;168;-4606.449,923.1078;Inherit;False;1234;489;ColorZone1;10;63;143;144;68;145;64;65;69;66;113;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;166;-2119.803,386.3632;Inherit;False;1245.797;485.7687;ColorZone4;10;87;155;154;90;153;88;84;85;89;110;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;52;162.9462,-229.5894;Inherit;False;Zone0Mask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;27;-848,-288;Inherit;False;EdgeWear;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;152;-3246.284,669.0932;Inherit;False;27;EdgeWear;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;53;-4507.612,620.2418;Inherit;False;52;Zone0Mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;58;-4227.786,-9.164495;Inherit;True;Property;_DetailTexture;DetailTexture;4;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;87;-1981.007,596.3628;Inherit;False;16;CC2R;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;143;-4478.492,1200.77;Inherit;False;27;EdgeWear;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;47;-4501.309,696.0551;Inherit;False;27;EdgeWear;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;149;-3219.877,1221.544;Inherit;False;27;EdgeWear;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;73;-3245.785,597.1251;Inherit;False;13;CC1G;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;158;-1956.865,1232.567;Inherit;False;27;EdgeWear;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;80;-3220.632,1154.091;Inherit;False;14;CC1B;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;63;-4479.449,1133.108;Inherit;False;12;CC1R;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;94;-1956.865,1152.567;Inherit;False;17;CC2G;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;155;-1989.007,657.3628;Inherit;False;27;EdgeWear;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;151;-3071.24,617.4312;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;59;-3932.444,-4.724981;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;157;-1780.865,1184.567;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;167;-868.4949,389.5759;Inherit;False;933;325;ColorZone6 Grunge Color;5;101;104;98;109;188;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;171;-839.3092,932.5456;Inherit;False;878;325;EdgeWearColor;5;105;106;107;129;108;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;148;-3044.834,1169.882;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;154;-1813.007,609.3628;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;144;-4303.448,1149.108;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;46;-4301.309,648.0552;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;101;-818.4949,599.5756;Inherit;False;34;GrungeMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;153;-1685.007,625.3628;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;104;-818.4949,439.5759;Inherit;False;Property;_Color6;Color 6;20;0;Create;True;0;0;False;0;False;0,0,0,0;0.0600302,0.645689,0.6698113,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;88;-2069.804,757.1315;Inherit;False;Property;_Zone4TileableIntensity;Zone4 Tileable Intensity ;17;0;Create;True;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;68;-4479.449,973.1078;Inherit;False;Property;_Color1;Color 1;10;0;Create;True;0;0;False;0;False;0,1,0,0;0,1,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;64;-4556.449,1297.108;Inherit;False;Property;_Zone1TileableIntensity;Zone1 Tileable Intensity ;11;0;Create;True;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;90;-1981.007,436.3632;Inherit;False;Property;_Color4;Color 4;16;0;Create;True;0;0;False;0;False;1,1,0,0;1,1,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;95;-2020.865,1321.567;Inherit;False;Property;_Zone5TileableIntensity;Zone5 Tileable Intensity ;19;0;Create;True;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;74;-3321.885,745.6246;Inherit;False;Property;_Zone2TileableIntensity;Zone2 Tileable Intensity ;13;0;Create;True;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;83;-3214.632,975.0906;Inherit;False;Property;_Color3;Color 3;14;0;Create;True;0;0;False;0;False;0,1,1,0;0,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;163;-4179.676,643.5488;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;106;-757.3092,1142.546;Inherit;False;27;EdgeWear;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;76;-3245.785,437.1251;Inherit;False;Property;_Color2;Color 2;12;0;Create;True;0;0;False;0;False;0,0,1,0;0,0,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;4;-4483.676,435.5491;Inherit;False;Property;_Color0;Color 0;8;0;Create;True;0;0;False;0;False;1,0,0,0;1,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;81;-3315.632,1338.091;Inherit;False;Property;_Zone3TileableIntensity;Zone3 Tileable Intensity ;15;0;Create;True;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;105;-789.3092,982.5456;Inherit;False;Property;_Color7;EdgeWearColor;23;0;Create;False;0;0;False;0;False;0.846,0.825,0.839,0;0.846,0.825,0.839,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;156;-1652.865,1200.567;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;150;-2943.24,633.4312;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;56;-3708.444,-4.724981;Inherit;False;DetailColor;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;97;-1956.865,976.5673;Inherit;False;Property;_Color5;Color 5;18;0;Create;True;0;0;False;0;False;1,0,1,0;1,0,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;145;-4175.45,1165.108;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;147;-2916.834,1185.882;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;61;-4555.476,802.0487;Inherit;False;Property;_Zone0TileableIntensity;Zone0 Tileable Intensity ;9;0;Create;True;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;98;-545.4947,442.576;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;92;-1668.865,1104.567;Inherit;False;56;DetailColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;78;-2942.632,1103.091;Inherit;False;56;DetailColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;54;-4035.676,467.549;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;89;-1525.804,773.1315;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;77;-2782.632,991.0906;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;71;-2973.785,565.1251;Inherit;False;56;DetailColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;107;-533.3094,998.5456;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;84;-1533.007,436.3632;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;91;-1508.865,992.5673;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;-4047.45,973.1078;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;85;-1709.007,564.3628;Inherit;False;56;DetailColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;62;-3979.476,802.0487;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;60;-4195.676,563.5488;Inherit;False;56;DetailColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;66;-4127.45,1101.108;Inherit;False;56;DetailColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;96;-1476.865,1337.567;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;69;-4012.45,1313.108;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;75;-2761.885,761.6246;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;82;-2748.632,1340.091;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;70;-2813.785,453.1251;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;195;-1380.865,1024.567;Inherit;False;MF_SimpleDetailDiffuse;-1;;73;e6e4a2444c47f7a42bdb4a4522f8e7eb;0;3;1;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;12;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;172;352.7389,365.8602;Inherit;False;1525;624;Final Color Mixing;17;134;132;136;127;126;122;124;133;123;128;121;125;135;130;131;160;137;;1,1,1,1;0;0
Node;AmplifyShaderEditor.FunctionNode;194;-2669.785,485.125;Inherit;False;MF_SimpleDetailDiffuse;-1;;72;e6e4a2444c47f7a42bdb4a4522f8e7eb;0;3;1;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;12;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;197;-3907.676,483.549;Inherit;False;MF_SimpleDetailDiffuse;-1;;75;e6e4a2444c47f7a42bdb4a4522f8e7eb;0;3;1;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;12;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;196;-1405.007,468.363;Inherit;False;MF_SimpleDetailDiffuse;-1;;74;e6e4a2444c47f7a42bdb4a4522f8e7eb;0;3;1;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;12;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;188;-420.3916,439.7839;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;198;-3903.45,1021.108;Inherit;False;MF_SimpleDetailDiffuse;-1;;76;e6e4a2444c47f7a42bdb4a4522f8e7eb;0;3;1;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;12;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;9;-3040,-240;Inherit;False;AO;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;199;-2638.632,1023.091;Inherit;False;MF_SimpleDetailDiffuse;-1;;77;e6e4a2444c47f7a42bdb4a4522f8e7eb;0;3;1;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;12;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;129;-405.3095,998.5456;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;113;-3615.45,1021.108;Inherit;False;Zone1Color;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;134;674.739,863.8607;Inherit;False;Property;_AODiffuseMixing;AO DiffuseMixing;5;0;Create;True;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;112;-3619.676,483.549;Inherit;False;Zone0Color;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;108;-213.3093,998.5456;Inherit;False;EdgeWearColor;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;111;-2365.786,485.125;Inherit;False;Zone2Color;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;109;-228.4949,439.576;Inherit;False;Zone6Color;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;110;-1117.007,468.363;Inherit;False;Zone4Color;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;115;-1092.865,1024.567;Inherit;False;Zone5Color;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;132;690.7389,751.8601;Inherit;False;9;AO;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;114;-2320.825,1028.262;Inherit;False;Zone3Color;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;124;402.7389,607.8604;Inherit;False;114;Zone3Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;125;402.7389,671.8604;Inherit;False;110;Zone4Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;136;994.7389,879.8607;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;123;402.7389,543.8604;Inherit;False;111;Zone2Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;128;402.7389,863.8607;Inherit;False;108;EdgeWearColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;121;402.7389,415.8601;Inherit;False;112;Zone0Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;126;402.7389,735.8603;Inherit;False;115;Zone5Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;122;402.7389,479.8603;Inherit;False;113;Zone1Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;127;402.7389,799.8605;Inherit;False;109;Zone6Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;133;978.7388,751.8601;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;193;294.2365,992.1797;Inherit;False;1171.705;567.4536;Emissive switch ;12;183;181;184;182;180;185;187;186;179;189;190;191;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;186;344.2365,1124.633;Inherit;False;113;Zone1Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;130;690.7389,527.8604;Inherit;False;8;8;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;185;344.2365,1380.633;Inherit;False;115;Zone5Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;182;344.2365,1188.633;Inherit;False;111;Zone2Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;183;344.2365,1252.633;Inherit;False;114;Zone3Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;184;344.2365,1444.633;Inherit;False;109;Zone6Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;187;344.2365,1316.633;Inherit;False;110;Zone4Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;180;594.1232,1042.18;Inherit;False;Constant;_Const0;Const0;25;0;Create;True;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;135;1154.739,751.8601;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;181;344.2365,1060.633;Inherit;False;112;Zone0Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;131;1362.739,527.8604;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;189;791.2858,1063.958;Inherit;False;Property;_EmissiveIntencity;EmissiveIntencity;7;0;Create;True;0;0;False;0;False;0;3.17;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;179;774.6708,1141.036;Inherit;False;Property;_EmmisiveZone;EmmisiveZone;6;0;Create;True;0;0;False;0;False;1;0;7;True;;KeywordEnum;8;NoEmissive;Zone0Emissive;Zone1Emissive;Zone2Emissive;Zone3Emissive;Zone4Emissive;Zone5Emissive;Zone6Emissive;Create;False;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;160;1499.2,540.3264;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;6;-2688,-256;Inherit;True;Property;_BumpMap;NormalMap;3;1;[NoScaleOffset];Create;False;0;0;False;0;False;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;190;1084.812,1117.788;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;11;-3040,-112;Inherit;False;Smoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;15;-2400,-256;Inherit;False;NormalMap;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;137;1634.739,527.8604;Inherit;False;FinalColor;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;173;1086,-178;Inherit;False;729;505;Output;6;142;140;139;138;0;192;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;191;1222.942,1123.882;Inherit;False;Emissive;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;138;1136,-128;Inherit;False;137;FinalColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;142;1135,224;Inherit;False;9;AO;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;139;1136,-64;Inherit;False;15;NormalMap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;141;1136,160;Inherit;False;11;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;192;1134.751,2.653717;Inherit;False;191;Emissive;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;140;1135,96;Inherit;False;10;Metallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1552,-128;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;HaloInfinte/ArmorBase;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;177;-4667.682,-406.7653;Inherit;False;100;100;Made for assets from Halo Infinite, Protoyped in Unreal Engine by R93_Sniper, ported to Unity in amplify by PointDevice;0;Made for assets from Halo Infinite, Protoyped in Unreal Engine by R93_Sniper, ported to Unity in amplify by PointDevice;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;178;-4672.927,-607.5251;Inherit;False;100;100;Comment;0;Licensed Under AGPL 3.0, You may redistribute, and modify this program, all derivitive works must carry the same license ;1,1,1,1;0;0
WireConnection;18;0;8;3
WireConnection;28;0;33;0
WireConnection;28;2;32;0
WireConnection;29;0;31;0
WireConnection;29;1;32;0
WireConnection;30;0;29;0
WireConnection;30;1;28;0
WireConnection;49;0;30;0
WireConnection;10;0;5;2
WireConnection;34;0;49;0
WireConnection;12;0;7;1
WireConnection;16;0;8;1
WireConnection;13;0;7;2
WireConnection;14;0;7;3
WireConnection;17;0;8;2
WireConnection;25;0;23;0
WireConnection;45;0;37;0
WireConnection;45;1;38;0
WireConnection;45;2;39;0
WireConnection;45;3;40;0
WireConnection;45;4;41;0
WireConnection;45;5;42;0
WireConnection;21;0;20;0
WireConnection;21;1;23;0
WireConnection;24;0;26;0
WireConnection;24;2;25;0
WireConnection;51;0;45;0
WireConnection;22;0;21;0
WireConnection;22;1;24;0
WireConnection;50;0;22;0
WireConnection;146;0;51;0
WireConnection;52;0;146;0
WireConnection;27;0;50;0
WireConnection;151;0;73;0
WireConnection;151;1;152;0
WireConnection;59;0;58;0
WireConnection;157;0;94;0
WireConnection;157;1;158;0
WireConnection;148;0;80;0
WireConnection;148;1;149;0
WireConnection;154;0;87;0
WireConnection;154;1;155;0
WireConnection;144;0;63;0
WireConnection;144;1;143;0
WireConnection;46;0;53;0
WireConnection;46;1;47;0
WireConnection;153;0;154;0
WireConnection;163;0;46;0
WireConnection;156;0;157;0
WireConnection;150;0;151;0
WireConnection;56;0;59;0
WireConnection;145;0;144;0
WireConnection;147;0;148;0
WireConnection;98;0;104;0
WireConnection;98;1;101;0
WireConnection;54;0;4;0
WireConnection;54;1;163;0
WireConnection;89;0;88;0
WireConnection;77;0;83;0
WireConnection;77;1;147;0
WireConnection;107;0;105;0
WireConnection;107;1;106;0
WireConnection;84;0;90;0
WireConnection;84;1;153;0
WireConnection;91;0;97;0
WireConnection;91;1;156;0
WireConnection;65;0;68;0
WireConnection;65;1;145;0
WireConnection;62;0;61;0
WireConnection;96;0;95;0
WireConnection;69;0;64;0
WireConnection;75;0;74;0
WireConnection;82;0;81;0
WireConnection;70;0;76;0
WireConnection;70;1;150;0
WireConnection;195;1;91;0
WireConnection;195;6;92;0
WireConnection;195;12;96;0
WireConnection;194;1;70;0
WireConnection;194;6;71;0
WireConnection;194;12;75;0
WireConnection;197;1;54;0
WireConnection;197;6;60;0
WireConnection;197;12;62;0
WireConnection;196;1;84;0
WireConnection;196;6;85;0
WireConnection;196;12;89;0
WireConnection;188;0;98;0
WireConnection;198;1;65;0
WireConnection;198;6;66;0
WireConnection;198;12;69;0
WireConnection;9;0;5;1
WireConnection;199;1;77;0
WireConnection;199;6;78;0
WireConnection;199;12;82;0
WireConnection;129;0;107;0
WireConnection;113;0;198;0
WireConnection;112;0;197;0
WireConnection;108;0;129;0
WireConnection;111;0;194;0
WireConnection;109;0;188;0
WireConnection;110;0;196;0
WireConnection;115;0;195;0
WireConnection;114;0;199;0
WireConnection;136;0;134;0
WireConnection;133;0;132;0
WireConnection;133;1;134;0
WireConnection;130;0;121;0
WireConnection;130;1;122;0
WireConnection;130;2;123;0
WireConnection;130;3;124;0
WireConnection;130;4;125;0
WireConnection;130;5;126;0
WireConnection;130;6;127;0
WireConnection;130;7;128;0
WireConnection;135;0;133;0
WireConnection;135;1;136;0
WireConnection;131;0;130;0
WireConnection;131;1;135;0
WireConnection;179;1;180;0
WireConnection;179;0;181;0
WireConnection;179;2;186;0
WireConnection;179;3;182;0
WireConnection;179;4;183;0
WireConnection;179;5;187;0
WireConnection;179;6;185;0
WireConnection;179;7;184;0
WireConnection;160;0;131;0
WireConnection;190;0;189;0
WireConnection;190;1;179;0
WireConnection;11;0;5;3
WireConnection;15;0;6;0
WireConnection;137;0;160;0
WireConnection;191;0;190;0
WireConnection;0;0;138;0
WireConnection;0;1;139;0
WireConnection;0;2;192;0
WireConnection;0;3;140;0
WireConnection;0;4;141;0
WireConnection;0;5;142;0
ASEEND*/
//CHKSM=457BD9062510141CC26F12F01DD0498AA55E7AB9