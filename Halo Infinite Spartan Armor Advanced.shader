// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "HaloInfinte/-Advanced- Halo Infinite Spartan Armor"
{
	Properties
	{
		[NoScaleOffset]_ASGMap("ASGMap", 2D) = "white" {}
		[NoScaleOffset]_CC1Mask("CC1 Mask", 2D) = "black" {}
		[NoScaleOffset]_CC2Mask("CC2 Mask", 2D) = "white" {}
		[NoScaleOffset]_BumpMap("NormalMap", 2D) = "bump" {}
		[KeywordEnum(OpenGL,DirectX)] _NormalMapFormat("NormalMapFormat", Float) = 1
		_DetailAlbedoMap("DetailTexture", 2D) = "white" {}
		_AODiffuseMixing("AO DiffuseMixing", Range( 0 , 1)) = 0.5
		_EmissiveIntencity("EmissiveIntencity", Range( 0 , 5)) = 1
		[Header(ColorZone0)]_Color("Color 0", Color) = (1,0,0,0)
		_Zone0TileableIntensity("Zone0 Tileable Intensity ", Range( 0 , 1)) = 0
		_MetallicFloorZone0("Metallic Floor Zone0", Range( 0 , 1)) = 0
		_RoughnessZone0("Roughness Zone0", Range( 0 , 1)) = 0.65
		[Header(ColorZone1)]_Color1("Color 1", Color) = (0,1,0,0)
		_Zone1TileableIntensity("Zone1 Tileable Intensity ", Range( 0 , 1)) = 0
		_MetallicFloorZone1("Metallic Floor Zone1", Range( 0 , 1)) = 0
		_RoughnessZone1("Roughness Zone1", Range( 0 , 1)) = 0.65
		[Header(ColorZone2)]_Color2("Color 2", Color) = (0,0,1,0)
		_Zone2TileableIntensity("Zone2 Tileable Intensity ", Range( 0 , 1)) = 0
		_MetallicFloorZone2("Metallic Floor Zone2", Range( 0 , 1)) = 0
		_RoughnessZone2("Roughness Zone2", Range( 0 , 1)) = 0.65
		[Header(ColorZone3)]_Color3("Color 3", Color) = (0,1,1,0)
		_Zone3TileableIntensity("Zone3 Tileable Intensity ", Range( 0 , 1)) = 0
		_MetallicFloorZone3("Metallic Floor Zone3", Range( 0 , 1)) = 0
		_RoughnessZone3("Roughness Zone3", Range( 0 , 1)) = 0.65
		[Header(ColorZone4)]_Color4("Color 4", Color) = (1,1,0,0)
		_Zone4TileableIntensity("Zone4 Tileable Intensity ", Range( 0 , 1)) = 0
		_MetallicFloorZone4("Metallic Floor Zone4", Range( 0 , 1)) = 0
		_RoughnessZone4("Roughness Zone4", Range( 0 , 1)) = 0.65
		[Header(ColorZone5)]_Color5("Color 5", Color) = (1,0,1,0)
		_Zone5TileableIntensity("Zone5 Tileable Intensity ", Range( 0 , 1)) = 0
		_MetallicFloorZone5("Metallic Floor Zone5", Range( 0 , 1)) = 0
		_RoughnessZone5("Roughness Zone5", Range( 0 , 1)) = 0.65
		[Header(ColorZone6 grunge)]_Color6("Color 6", Color) = (0,0,0,0)
		_GrungeAmmount("Grunge Ammount", Range( 0 , 1)) = 1
		_GrungePower("Grunge Power", Range( 0.22 , 2.2)) = 1
		_RoughnessGrunge("Roughness Grunge", Range( 0 , 1)) = 0.65
		[Header(Dust and Emissives)]_CC2BColor("CC2B Color", Color) = (0.8773585,0.7514915,0.6166341,0)
		[KeywordEnum(CC2BDustNoEmssive,CC2BDustZone5Emissive,CC2BEmissive,NoCC2B)] _CC2Bswitch("CC2B switch ", Float) = 0
		[Header(ColorZone7 MetalWear)]_Color7("EdgeWearColor", Color) = (0.846,0.825,0.839,0)
		_EdgeWearAmmount("Edge Wear Ammount", Range( 0 , 1)) = 1
		_EdgeWearPower("Edge Wear Power", Range( 0.22 , 2.2)) = 1
		_RoughnessEdgeWear("Roughness Edge Wear", Range( 0 , 1)) = 0.65
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
		#pragma multi_compile _CC2BSWITCH_CC2BDUSTNOEMSSIVE _CC2BSWITCH_CC2BDUSTZONE5EMISSIVE _CC2BSWITCH_CC2BEMISSIVE _CC2BSWITCH_NOCC2B
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _BumpMap;
		uniform float4 _Color;
		uniform sampler2D _CC2Mask;
		uniform sampler2D _CC1Mask;
		uniform sampler2D _ASGMap;
		uniform float _EdgeWearAmmount;
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
		uniform float4 _Color7;
		uniform float4 _Color5;
		uniform float _Zone5TileableIntensity;
		uniform float4 _CC2BColor;
		uniform float4 _Color6;
		uniform float _GrungeAmmount;
		uniform float _GrungePower;
		uniform float _AODiffuseMixing;
		uniform float _EmissiveIntencity;
		uniform float _MetallicFloorZone0;
		uniform float _MetallicFloorZone1;
		uniform float _MetallicFloorZone2;
		uniform float _MetallicFloorZone3;
		uniform float _MetallicFloorZone4;
		uniform float _MetallicFloorZone5;
		uniform float _RoughnessZone0;
		uniform float _RoughnessZone1;
		uniform float _RoughnessZone2;
		uniform float _RoughnessZone3;
		uniform float _RoughnessZone4;
		uniform float _RoughnessZone5;
		uniform float _RoughnessEdgeWear;
		uniform float _RoughnessGrunge;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BumpMap6 = i.uv_texcoord;
			float3 tex2DNode6 = UnpackNormal( tex2D( _BumpMap, uv_BumpMap6 ) );
			float3 appendResult354 = (float3(tex2DNode6.r , -tex2DNode6.g , 1.0));
			#if defined(_NORMALMAPFORMAT_OPENGL)
				float3 staticSwitch355 = tex2DNode6;
			#elif defined(_NORMALMAPFORMAT_DIRECTX)
				float3 staticSwitch355 = appendResult354;
			#else
				float3 staticSwitch355 = appendResult354;
			#endif
			float3 NormalMap15 = staticSwitch355;
			o.Normal = NormalMap15;
			float2 uv_CC2Mask8 = i.uv_texcoord;
			float4 tex2DNode8 = tex2D( _CC2Mask, uv_CC2Mask8 );
			float CC2R16 = tex2DNode8.r;
			float CC2G17 = tex2DNode8.g;
			float2 uv_CC1Mask7 = i.uv_texcoord;
			float4 tex2DNode7 = tex2D( _CC1Mask, uv_CC1Mask7 );
			float CC1R12 = saturate( ( ( tex2DNode7.r - CC2R16 ) - CC2G17 ) );
			float CC1G13 = saturate( ( ( tex2DNode7.g - CC2R16 ) - CC2G17 ) );
			float CC1B14 = tex2DNode7.b;
			float Zone0MaskBase52 = ( 1.0 - saturate( ( CC2R16 + CC2G17 + CC1R12 + CC1G13 + CC1B14 ) ) );
			float2 uv_ASGMap5 = i.uv_texcoord;
			float4 tex2DNode5 = tex2D( _ASGMap, uv_ASGMap5 );
			float Metallic10 = tex2DNode5.g;
			float EdgeWear27 = saturate( pow( ( Metallic10 * _EdgeWearAmmount ) , _EdgeWearPower ) );
			float2 uv_DetailAlbedoMap = i.uv_texcoord * _DetailAlbedoMap_ST.xy + _DetailAlbedoMap_ST.zw;
			float3 DetailColor56 = (tex2D( _DetailAlbedoMap, uv_DetailAlbedoMap )).rgb;
			float temp_output_12_0_g127 = _Zone0TileableIntensity;
			float3 Zone0Color112 = saturate( ( ( _Color * saturate( ( Zone0MaskBase52 - EdgeWear27 ) ) ).rgb * ( ( DetailColor56 * temp_output_12_0_g127 ) + ( 1.0 - temp_output_12_0_g127 ) ) ) );
			float temp_output_12_0_g126 = _Zone1TileableIntensity;
			float3 Zone1Color113 = saturate( ( ( _Color1 * saturate( ( CC1R12 - EdgeWear27 ) ) ).rgb * ( ( DetailColor56 * temp_output_12_0_g126 ) + ( 1.0 - temp_output_12_0_g126 ) ) ) );
			float temp_output_12_0_g128 = _Zone2TileableIntensity;
			float3 Zone2Color111 = saturate( ( ( _Color2 * saturate( ( CC1G13 - EdgeWear27 ) ) ).rgb * ( ( DetailColor56 * temp_output_12_0_g128 ) + ( 1.0 - temp_output_12_0_g128 ) ) ) );
			float temp_output_12_0_g130 = _Zone3TileableIntensity;
			float3 Zone3Color114 = saturate( ( ( _Color3 * saturate( ( CC1B14 - EdgeWear27 ) ) ).rgb * ( ( DetailColor56 * temp_output_12_0_g130 ) + ( 1.0 - temp_output_12_0_g130 ) ) ) );
			float temp_output_12_0_g129 = _Zone4TileableIntensity;
			float3 Zone4Color110 = saturate( ( ( _Color4 * saturate( ( CC2R16 - EdgeWear27 ) ) ).rgb * ( ( DetailColor56 * temp_output_12_0_g129 ) + ( 1.0 - temp_output_12_0_g129 ) ) ) );
			float3 EdgeWearColor108 = (( _Color7 * EdgeWear27 )).rgb;
			float temp_output_156_0 = saturate( ( CC2G17 - EdgeWear27 ) );
			float temp_output_12_0_g121 = _Zone5TileableIntensity;
			float3 Zone5ColorMix115 = saturate( ( ( _Color5 * temp_output_156_0 ).rgb * ( ( DetailColor56 * temp_output_12_0_g121 ) + ( 1.0 - temp_output_12_0_g121 ) ) ) );
			float CC2B18 = tex2DNode8.b;
			float3 temp_output_330_0 = ( CC2B18 * (_CC2BColor).rgb );
			float3 temp_cast_6 = (0.0).xxx;
			#if defined(_CC2BSWITCH_CC2BDUSTNOEMSSIVE)
				float3 staticSwitch332 = ( Zone5ColorMix115 + temp_output_330_0 );
			#elif defined(_CC2BSWITCH_CC2BDUSTZONE5EMISSIVE)
				float3 staticSwitch332 = temp_output_330_0;
			#elif defined(_CC2BSWITCH_CC2BEMISSIVE)
				float3 staticSwitch332 = Zone5ColorMix115;
			#elif defined(_CC2BSWITCH_NOCC2B)
				float3 staticSwitch332 = temp_cast_6;
			#else
				float3 staticSwitch332 = ( Zone5ColorMix115 + temp_output_330_0 );
			#endif
			float3 Zone6Color109 = (_Color6).rgb;
			float AO9 = tex2DNode5.r;
			float Smoothness11 = tex2DNode5.b;
			float GrungeMask34 = saturate( pow( ( Smoothness11 * _GrungeAmmount ) , _GrungePower ) );
			float3 lerpResult319 = lerp( ( Zone0Color112 + Zone1Color113 + Zone2Color111 + Zone3Color114 + Zone4Color110 + EdgeWearColor108 + staticSwitch332 ) , Zone6Color109 , ( AO9 * GrungeMask34 ));
			float3 FinalColor137 = saturate( ( lerpResult319 * ( ( AO9 * _AODiffuseMixing ) + ( 1.0 - _AODiffuseMixing ) ) ) );
			o.Albedo = FinalColor137;
			float3 temp_cast_7 = (0.0).xxx;
			float3 temp_cast_8 = (0.0).xxx;
			float3 temp_cast_9 = (0.0).xxx;
			#if defined(_CC2BSWITCH_CC2BDUSTNOEMSSIVE)
				float3 staticSwitch333 = temp_cast_7;
			#elif defined(_CC2BSWITCH_CC2BDUSTZONE5EMISSIVE)
				float3 staticSwitch333 = ( _EmissiveIntencity * Zone5ColorMix115 );
			#elif defined(_CC2BSWITCH_CC2BEMISSIVE)
				float3 staticSwitch333 = temp_output_330_0;
			#elif defined(_CC2BSWITCH_NOCC2B)
				float3 staticSwitch333 = temp_cast_9;
			#else
				float3 staticSwitch333 = temp_cast_7;
			#endif
			float3 Emissive191 = staticSwitch333;
			o.Emission = Emissive191;
			float mettalicResult232 = saturate( ( ( Zone0MaskBase52 * _MetallicFloorZone0 ) + ( CC1R12 * _MetallicFloorZone1 ) + ( CC1G13 * _MetallicFloorZone2 ) + ( CC1B14 * _MetallicFloorZone3 ) + ( CC2R16 * _MetallicFloorZone4 ) + ( CC2G17 * _MetallicFloorZone5 ) + EdgeWear27 ) );
			o.Metallic = mettalicResult232;
			float ColorZone0Mask245 = Zone0MaskBase52;
			float ColorZone1Mask246 = CC1R12;
			float ColorZone2Mask247 = CC1G13;
			float ColorZone3Mask248 = CC1B14;
			float ColorZone4Mask249 = CC2R16;
			float ColorZone5Mask250 = temp_output_156_0;
			float lerpResult349 = lerp( ( ( ColorZone0Mask245 * _RoughnessZone0 ) + ( ColorZone1Mask246 * _RoughnessZone1 ) + ( ColorZone2Mask247 * _RoughnessZone2 ) + ( ColorZone3Mask248 * _RoughnessZone3 ) + ( ColorZone4Mask249 * _RoughnessZone4 ) + ( ColorZone5Mask250 * _RoughnessZone5 ) ) , _RoughnessEdgeWear , EdgeWear27);
			float lerpResult348 = lerp( lerpResult349 , _RoughnessGrunge , GrungeMask34);
			float finalSmooth295 = ( 1.0 - saturate( lerpResult348 ) );
			o.Smoothness = finalSmooth295;
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
340;182;1529;792;485.5675;769.7464;1.146144;True;False
Node;AmplifyShaderEditor.CommentaryNode;19;-4215.966,-425.5382;Inherit;False;2083.316;737.5338;Texture Input;24;15;6;9;18;11;13;12;14;305;306;10;308;307;300;309;302;5;16;17;7;8;353;354;355;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;8;-4169.837,108.2734;Inherit;True;Property;_CC2Mask;CC2 Mask;2;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;879a6729049ad9e45853b8b36c1cff24;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;16;-3881.837,108.2734;Inherit;False;CC2R;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;17;-3881.837,172.2734;Inherit;False;CC2G;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;7;-4169.837,-83.72655;Inherit;True;Property;_CC1Mask;CC1 Mask;1;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;5da0d8937fe183945b63037ed303cba1;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;5;-4180.263,-370.6066;Inherit;True;Property;_ASGMap;ASGMap;0;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;836e99991d9609e4f8765e444848caf3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;176;-2116,-378;Inherit;False;1513;694;Simple Contrast/knee adjustment for wear and grunge;3;35;36;50;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;300;-3612.914,-11.62844;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;302;-3610.984,81.08555;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;10;-3892.263,-306.6066;Inherit;False;Metallic;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;36;-2065,-328;Inherit;False;1412;335;Wear;6;20;22;21;27;26;23;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WireNode;309;-3582.106,207.3414;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;307;-3436.55,143.1882;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;20;-1919,-278;Inherit;False;10;Metallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-2015,-214;Inherit;False;Property;_EdgeWearAmmount;Edge Wear Ammount;39;0;Create;True;0;0;0;False;0;False;1;0.568;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;308;-3430.568,52.46549;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-1691.538,-171.1129;Inherit;False;Property;_EdgeWearPower;Edge Wear Power;40;0;Create;True;0;0;0;False;0;False;1;1.073;0.22;2.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-1679,-278;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;305;-3307.257,52.63706;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;306;-3307.257,148.6371;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;22;-1151,-278;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;12;-3177.246,49.03101;Inherit;False;CC1R;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;14;-3881.837,28.27343;Inherit;False;CC1B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;174;-591.9655,-372.664;Inherit;False;997.9117;485;BaseColorMask, inverse of all other zones;9;38;42;41;37;40;45;51;146;52;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;13;-3179.257,148.6371;Inherit;False;CC1G;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;40;-544,-192;Inherit;False;12;CC1R;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;41;-544,-128;Inherit;False;13;CC1G;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;42;-544,-64;Inherit;False;14;CC1B;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;50;-1024,-272;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;38;-541.9654,-258.6643;Inherit;False;17;CC2G;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;175;-4656.449,335.5491;Inherit;False;4770.954;1117.542;ZoneClorization;8;171;170;169;168;167;166;165;164;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;37;-541.9654,-322.664;Inherit;False;16;CC2R;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;170;-2070.864,926.5673;Inherit;False;1221;510;ColorZone5;11;158;94;157;156;97;95;92;91;96;115;250;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;45;-269.9655,-226.6643;Inherit;False;5;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;161;-5137.636,-155.4267;Inherit;False;831.3411;458;Tileable texture Input and Chacing ;3;56;59;58;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;27;-848,-288;Inherit;False;EdgeWear;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;58;-5087.636,-105.4267;Inherit;True;Property;_DetailAlbedoMap;DetailTexture;5;0;Create;False;0;0;0;False;0;False;-1;None;3ee0c06ad3bf2134fb04893b5d83e42a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;94;-1956.865,1152.567;Inherit;False;17;CC2G;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;158;-1956.865,1232.567;Inherit;False;27;EdgeWear;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;146;-115.2356,-223.2774;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;51;16,-224;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;157;-1780.865,1184.567;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;59;-4792.294,-100.9871;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;52;162.9462,-229.5894;Inherit;False;Zone0MaskBase;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;156;-1652.865,1200.567;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;95;-2032,1296;Inherit;False;Property;_Zone5TileableIntensity;Zone5 Tileable Intensity ;29;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;169;-3365.632,925.0906;Inherit;False;1287.807;528;ColorZone3;11;149;80;148;83;147;77;78;82;114;81;248;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;56;-4568.294,-100.9871;Inherit;False;DetailColor;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;164;-4605.476,385.5491;Inherit;False;1228.8;531.4999;ColorZone0;11;47;53;46;163;4;61;62;60;54;112;245;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;165;-3371.885,387.1251;Inherit;False;1251.154;514.5886;ColorZone2;12;75;111;214;71;70;76;74;150;151;152;73;247;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;166;-2119.803,386.3632;Inherit;False;1248.863;518.4703;ColorZone4;12;88;89;110;215;84;85;90;153;154;87;155;249;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;168;-4606.449,923.1078;Inherit;False;1234;489;ColorZone1;11;63;143;144;68;145;64;65;69;66;113;246;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;97;-1956.865,976.5673;Inherit;False;Property;_Color5;Color 5;28;1;[Header];Create;True;1;ColorZone5;0;0;False;0;False;1,0,1,0;0.1215678,0.4936072,0.5098022,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;143;-4478.492,1200.77;Inherit;False;27;EdgeWear;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;11;-3892.263,-242.6065;Inherit;False;Smoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;96;-1461,1285;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;92;-1668.865,1104.567;Inherit;False;56;DetailColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;87;-1981.007,596.3628;Inherit;False;16;CC2R;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;53;-4507.612,620.2418;Inherit;False;52;Zone0MaskBase;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;63;-4479.449,1133.108;Inherit;False;12;CC1R;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;47;-4501.309,696.0551;Inherit;False;27;EdgeWear;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;155;-1989.007,657.3628;Inherit;False;27;EdgeWear;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;73;-3245.785,597.1251;Inherit;False;13;CC1G;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;80;-3220.632,1154.091;Inherit;False;14;CC1B;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;152;-3246.284,669.0932;Inherit;False;27;EdgeWear;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;344;-1476.141,1473.386;Inherit;False;1647.082;591.7666;This is Just Going To be a Mess untill I find a Better Way to do this;13;324;325;331;336;330;334;332;333;191;340;189;190;345;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;35;-2066,-18;Inherit;False;1413;329;Grunge;7;34;33;32;31;30;29;49;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;91;-1508.865,992.5673;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;149;-3219.877,1221.544;Inherit;False;27;EdgeWear;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;18;-3881.837,236.2734;Inherit;False;CC2B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;154;-1813.007,609.3628;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;212;-1380.865,1024.567;Inherit;False;MF_SimpleDetailDiffuse;-1;;121;e6e4a2444c47f7a42bdb4a4522f8e7eb;0;3;1;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;12;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;171;-839.3092,932.5456;Inherit;False;878;325;EdgeWearColor;5;105;106;107;129;108;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;46;-4301.309,648.0552;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;31;-1984,32;Inherit;False;11;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;148;-3044.834,1169.882;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;151;-3071.24,617.4312;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;324;-1411.954,1711.85;Inherit;False;Property;_CC2BColor;CC2B Color;36;1;[Header];Create;True;1;Dust and Emissives;0;0;False;0;False;0.8773585,0.7514915,0.6166341,0;0.745283,0.5940585,0.4324048,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;144;-4303.448,1149.108;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-2016,192;Inherit;False;Property;_GrungeAmmount;Grunge Ammount;33;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;88;-2064,720;Inherit;False;Property;_Zone4TileableIntensity;Zone4 Tileable Intensity ;25;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;106;-757.3092,1142.546;Inherit;False;27;EdgeWear;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;76;-3245.785,437.1251;Inherit;False;Property;_Color2;Color 2;16;1;[Header];Create;True;1;ColorZone2;0;0;False;0;False;0,0,1,0;0.1132067,0.1132067,0.1132067,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;163;-4179.676,643.5488;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;153;-1685.007,625.3628;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;115;-1092.865,1024.567;Inherit;False;Zone5ColorMix;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;331;-1152.954,1664.85;Inherit;False;18;CC2B;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;325;-1152.954,1728.85;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;83;-3214.632,975.0906;Inherit;False;Property;_Color3;Color 3;20;1;[Header];Create;True;1;ColorZone3;0;0;False;0;False;0,1,1,0;0.3490556,0.3490556,0.3490556,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;64;-4558.449,1270.108;Inherit;False;Property;_Zone1TileableIntensity;Zone1 Tileable Intensity ;13;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-1698.55,37.23729;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;81;-3296,1296;Inherit;False;Property;_Zone3TileableIntensity;Zone3 Tileable Intensity ;21;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;4;-4483.676,435.5491;Inherit;False;Property;_Color;Color 0;8;1;[Header];Create;False;1;ColorZone0;0;0;False;0;False;1,0,0,0;0,0.3568619,0.6431373,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;33;-1712,128;Inherit;False;Property;_GrungePower;Grunge Power;34;0;Create;True;0;0;0;False;0;False;1;1.854;0.22;2.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;147;-2916.834,1185.882;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;61;-4544,832;Inherit;False;Property;_Zone0TileableIntensity;Zone0 Tileable Intensity ;9;0;Create;True;0;0;0;False;0;False;0;0.265;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;68;-4479.449,973.1078;Inherit;False;Property;_Color1;Color 1;12;1;[Header];Create;True;1;ColorZone1;0;0;False;0;False;0,1,0,0;0.1981123,0.1981123,0.1981123,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;74;-3321.885,745.6246;Inherit;False;Property;_Zone2TileableIntensity;Zone2 Tileable Intensity ;17;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;150;-2943.24,633.4312;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;105;-789.3092,982.5456;Inherit;False;Property;_Color7;EdgeWearColor;38;1;[Header];Create;False;1;ColorZone7 MetalWear;0;0;False;0;False;0.846,0.825,0.839,0;0.7735849,0.7735849,0.7735849,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;90;-1981.007,436.3632;Inherit;False;Property;_Color4;Color 4;24;1;[Header];Create;True;1;ColorZone4;0;0;False;0;False;1,1,0,0;0.8584906,0.48347,0.06074162,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;145;-4175.45,1165.108;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;77;-2782.632,991.0906;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;60;-4195.676,563.5488;Inherit;False;56;DetailColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;62;-3979.476,802.0487;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;69;-4005.45,1252.108;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;336;-1092.704,1559.966;Inherit;False;115;Zone5ColorMix;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;71;-2973.785,565.1251;Inherit;False;56;DetailColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;70;-2813.785,453.1251;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;248;-2639.802,1180.403;Inherit;False;ColorZone3Mask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;250;-1363.478,1193.14;Inherit;False;ColorZone5Mask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;330;-944.954,1664.85;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;-4047.45,973.1078;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;167;-863.7588,389.5759;Inherit;False;928.2639;514.446;ColorZone6 Grunge Color;3;109;188;104;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;246;-3881.772,1160.903;Inherit;False;ColorZone1Mask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;245;-3870.308,638.8777;Inherit;False;ColorZone0Mask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;296;-3510.56,1459.038;Inherit;False;2018.557;1128.66;SmoothNessAdjust;27;342;295;341;292;285;279;278;282;281;280;283;268;264;269;272;267;273;274;271;270;265;275;266;347;350;349;351;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WireNode;82;-2736,1280;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;84;-1533.007,436.3632;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;85;-1709.007,564.3628;Inherit;False;56;DetailColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;107;-533.3094,998.5456;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;78;-2942.632,1103.091;Inherit;False;56;DetailColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;66;-4127.45,1101.108;Inherit;False;56;DetailColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;75;-2752,736;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;54;-4035.676,467.549;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;89;-1472,704;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;247;-2642.314,629.6193;Inherit;False;ColorZone2Mask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;249;-1390.337,618.4454;Inherit;False;ColorZone4Mask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;30;-1184,32;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;49;-1056,32;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;340;-637.2459,1745.071;Inherit;False;Constant;_Float0;Float 0;42;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;215;-1405.007,468.363;Inherit;False;MF_SimpleDetailDiffuse;-1;;129;e6e4a2444c47f7a42bdb4a4522f8e7eb;0;3;1;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;12;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;275;-3447.26,1829.038;Inherit;False;Property;_RoughnessZone2;Roughness Zone2;19;0;Create;True;0;0;0;False;0;False;0.65;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;267;-3447.26,1957.038;Inherit;False;Property;_RoughnessZone3;Roughness Zone3;23;0;Create;True;0;0;0;False;0;False;0.65;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;334;-751.7397,1523.386;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;270;-3447.26,2213.038;Inherit;False;Property;_RoughnessZone5;Roughness Zone5;31;0;Create;True;0;0;0;False;0;False;0.65;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;269;-3447.26,2085.038;Inherit;False;Property;_RoughnessZone4;Roughness Zone4;27;0;Create;True;0;0;0;False;0;False;0.65;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;217;-3903.45,1021.108;Inherit;False;MF_SimpleDetailDiffuse;-1;;126;e6e4a2444c47f7a42bdb4a4522f8e7eb;0;3;1;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;12;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;272;-3447.26,2021.038;Inherit;False;249;ColorZone4Mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;271;-3447.26,2149.038;Inherit;False;250;ColorZone5Mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;214;-2669.785,485.125;Inherit;False;MF_SimpleDetailDiffuse;-1;;128;e6e4a2444c47f7a42bdb4a4522f8e7eb;0;3;1;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;12;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;266;-3447.26,1893.038;Inherit;False;248;ColorZone3Mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;274;-3447.26,1701.038;Inherit;False;Property;_RoughnessZone1;Roughness Zone1;15;0;Create;True;0;0;0;False;0;False;0.65;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;265;-3447.26,1765.038;Inherit;False;247;ColorZone2Mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;216;-2638.632,1023.091;Inherit;False;MF_SimpleDetailDiffuse;-1;;130;e6e4a2444c47f7a42bdb4a4522f8e7eb;0;3;1;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;12;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;129;-405.3095,998.5456;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;268;-3447.26,1509.038;Inherit;False;245;ColorZone0Mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;104;-818.4949,439.5759;Inherit;False;Property;_Color6;Color 6;32;1;[Header];Create;True;1;ColorZone6 grunge;0;0;False;0;False;0,0,0,0;0.2075472,0.139941,0.0283909,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;273;-3447.26,1573.038;Inherit;False;Property;_RoughnessZone0;Roughness Zone0;11;0;Create;True;0;0;0;False;0;False;0.65;0.485;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;213;-3907.676,483.549;Inherit;False;MF_SimpleDetailDiffuse;-1;;127;e6e4a2444c47f7a42bdb4a4522f8e7eb;0;3;1;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;12;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;264;-3447.26,1637.038;Inherit;False;246;ColorZone1Mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;283;-3127.26,2181.038;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;9;-3892.263,-370.6066;Inherit;False;AO;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;114;-2320.825,1028.262;Inherit;False;Zone3Color;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;281;-3127.26,1925.038;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;332;-463.9946,1628.551;Inherit;False;Property;_CC2Bswitch;CC2B switch ;37;0;Create;True;0;0;0;False;0;False;1;0;0;True;;KeywordEnum;4;CC2BDustNoEmssive;CC2BDustZone5Emissive;CC2BEmissive;NoCC2B;Create;False;True;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;108;-213.3093,998.5456;Inherit;False;EdgeWearColor;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;34;-852,28;Inherit;False;GrungeMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;172;754.0269,301.7415;Inherit;False;2190.679;594.2961;Final Color Mixing;20;137;160;131;319;321;318;127;320;135;136;133;134;132;130;125;128;122;123;124;121;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;280;-3127.26,1797.038;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;279;-3127.26,1669.038;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;188;-624,432;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;113;-3615.45,1021.108;Inherit;False;Zone1Color;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;112;-3619.676,483.549;Inherit;False;Zone0Color;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;110;-1117.007,468.363;Inherit;False;Zone4Color;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;278;-3130.436,1530.457;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;111;-2365.786,485.125;Inherit;False;Zone2Color;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;282;-3127.26,2053.038;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;125;804.0269,607.7415;Inherit;False;110;Zone4Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;320;1217.288,606.205;Inherit;False;9;AO;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;132;1809.288,558.205;Inherit;False;9;AO;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;124;804.0269,543.7415;Inherit;False;114;Zone3Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;122;804.0269,415.7416;Inherit;False;113;Zone1Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;134;1809.288,654.205;Inherit;False;Property;_AODiffuseMixing;AO DiffuseMixing;6;0;Create;True;0;0;0;False;0;False;0.5;0.88;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;350;-2892.992,2048.341;Inherit;False;Property;_RoughnessEdgeWear;Roughness Edge Wear;41;0;Create;True;0;0;0;False;0;False;0.65;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;361;866.569,1506.704;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;123;804.0269,479.7416;Inherit;False;111;Zone2Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;109;-432,434;Inherit;False;Zone6Color;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;128;800.6077,681.1947;Inherit;False;108;EdgeWearColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;318;1217.288,670.205;Inherit;False;34;GrungeMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;351;-2811.445,2118.769;Inherit;False;27;EdgeWear;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;263;-4651.307,1458.221;Inherit;False;1129.953;961.6295;Metallic Floor Values For Each Channel;22;298;232;242;259;260;261;262;257;244;258;256;222;218;253;225;252;223;255;226;224;254;251;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;285;-2887.26,1861.038;Inherit;False;6;6;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;121;804.0269,351.7414;Inherit;False;112;Zone0Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;251;-4601.308,1508.221;Inherit;False;52;Zone0MaskBase;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;321;1425.288,606.205;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;254;-4601.308,1892.222;Inherit;False;14;CC1B;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;224;-4601.308,1956.222;Inherit;False;Property;_MetallicFloorZone3;Metallic Floor Zone3;22;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;253;-4601.308,1764.222;Inherit;False;13;CC1G;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;222;-4601.308,1700.222;Inherit;False;Property;_MetallicFloorZone1;Metallic Floor Zone1;14;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;133;2097.288,558.205;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;130;1092.027,463.7417;Inherit;False;7;7;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;255;-4601.308,2020.221;Inherit;False;16;CC2R;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;136;2097.288,654.205;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;6;-3312,-384;Inherit;True;Property;_BumpMap;NormalMap;3;1;[NoScaleOffset];Create;False;0;0;0;False;0;False;-1;None;a299de5a3bac6254da2f73648940a057;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;349;-2524.966,1867.058;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;218;-4601.308,1572.221;Inherit;False;Property;_MetallicFloorZone0;Metallic Floor Zone0;10;0;Create;True;0;0;0;False;0;False;0;0.6;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;127;1217.288,542.205;Inherit;False;109;Zone6Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;347;-2520.737,1977.621;Inherit;False;Property;_RoughnessGrunge;Roughness Grunge;35;0;Create;True;0;0;0;False;0;False;0.65;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;252;-4601.308,1636.221;Inherit;False;12;CC1R;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;342;-2448.479,2047.756;Inherit;False;34;GrungeMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;225;-4601.308,2084.221;Inherit;False;Property;_MetallicFloorZone4;Metallic Floor Zone4;26;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;256;-4601.308,2148.221;Inherit;False;17;CC2G;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;223;-4601.308,1828.222;Inherit;False;Property;_MetallicFloorZone2;Metallic Floor Zone2;18;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;226;-4601.308,2212.221;Inherit;False;Property;_MetallicFloorZone5;Metallic Floor Zone5;30;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;257;-4297.307,1540.221;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;261;-4297.307,2052.221;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;319;1665.288,462.2052;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;244;-4345.307,2308.221;Inherit;False;27;EdgeWear;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;258;-4297.307,1668.221;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;135;2273.288,558.205;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;189;-1426.141,1886.153;Inherit;False;Property;_EmissiveIntencity;EmissiveIntencity;7;0;Create;True;0;0;0;False;0;False;1;2.91;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;348;-2195.505,1870.765;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;262;-4297.307,2180.221;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;353;-3008,-288;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;259;-4297.307,1796.222;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;260;-4297.307,1924.222;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;345;-1417.34,1972.946;Inherit;False;115;Zone5ColorMix;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;354;-2880,-320;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;242;-4041.307,1860.222;Inherit;False;7;7;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;190;-886.1409,1902.153;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;131;2401.288,462.2052;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;292;-2016,1872;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;355;-2720,-368;Inherit;False;Property;_NormalMapFormat;NormalMapFormat;4;0;Create;True;0;0;0;False;0;False;1;1;1;True;;KeywordEnum;2;OpenGL;DirectX;Create;False;True;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;160;2529.288,478.2051;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;298;-3920,1856;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;333;-469.7442,1779.667;Inherit;False;Property;_CC2Bswitch;CC2B switch ;37;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;4;CC2BDustNoEmssive;CC2BDustZone5Emissive;CC2BEmissive;NoCC2B;Reference;332;False;True;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;341;-1888,1872;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;137;2673.288,462.2052;Inherit;False;FinalColor;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;15;-2464,-368;Inherit;False;NormalMap;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;232;-3728,1856;Inherit;False;mettalicResult;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;191;-72.05916,1779.519;Inherit;False;Emissive;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;173;419.534,-370.0863;Inherit;False;664.5903;520.3188;Output;7;0;142;141;140;139;192;138;v 0.35 I am the Yang;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;295;-1744,1872;Inherit;False;finalSmooth;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;138;448,-304;Inherit;False;137;FinalColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;141;448,-48;Inherit;False;295;finalSmooth;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;142;448,16;Inherit;False;9;AO;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;192;448,-176;Inherit;False;191;Emissive;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;139;448,-240;Inherit;False;15;NormalMap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;140;448,-112;Inherit;False;232;mettalicResult;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;800,-304;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;HaloInfinte/-Advanced- Halo Infinite Spartan Armor;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;177;-4664.194,-441.6447;Inherit;False;100;100;Made for assets from Halo Infinite, Protoyped in Unreal Engine by R93_Sniper, ported to Unity in amplify by PointDevice;0;Made for assets from Halo Infinite, Protoyped in Unreal Engine by R93_Sniper, ported to Unity in amplify by PointDevice;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;178;-4672.927,-607.5251;Inherit;False;100;100;Comment;0;Licensed Under AGPL 3.0, You may redistribute, and modify this program, all derivitive works must carry the same license ;1,1,1,1;0;0
WireConnection;16;0;8;1
WireConnection;17;0;8;2
WireConnection;300;0;7;1
WireConnection;300;1;16;0
WireConnection;302;0;7;2
WireConnection;302;1;16;0
WireConnection;10;0;5;2
WireConnection;309;0;17;0
WireConnection;307;0;302;0
WireConnection;307;1;309;0
WireConnection;308;0;300;0
WireConnection;308;1;309;0
WireConnection;21;0;20;0
WireConnection;21;1;23;0
WireConnection;305;0;308;0
WireConnection;306;0;307;0
WireConnection;22;0;21;0
WireConnection;22;1;26;0
WireConnection;12;0;305;0
WireConnection;14;0;7;3
WireConnection;13;0;306;0
WireConnection;50;0;22;0
WireConnection;45;0;37;0
WireConnection;45;1;38;0
WireConnection;45;2;40;0
WireConnection;45;3;41;0
WireConnection;45;4;42;0
WireConnection;27;0;50;0
WireConnection;146;0;45;0
WireConnection;51;0;146;0
WireConnection;157;0;94;0
WireConnection;157;1;158;0
WireConnection;59;0;58;0
WireConnection;52;0;51;0
WireConnection;156;0;157;0
WireConnection;56;0;59;0
WireConnection;11;0;5;3
WireConnection;96;0;95;0
WireConnection;91;0;97;0
WireConnection;91;1;156;0
WireConnection;18;0;8;3
WireConnection;154;0;87;0
WireConnection;154;1;155;0
WireConnection;212;1;91;0
WireConnection;212;6;92;0
WireConnection;212;12;96;0
WireConnection;46;0;53;0
WireConnection;46;1;47;0
WireConnection;148;0;80;0
WireConnection;148;1;149;0
WireConnection;151;0;73;0
WireConnection;151;1;152;0
WireConnection;144;0;63;0
WireConnection;144;1;143;0
WireConnection;163;0;46;0
WireConnection;153;0;154;0
WireConnection;115;0;212;0
WireConnection;325;0;324;0
WireConnection;29;0;31;0
WireConnection;29;1;32;0
WireConnection;147;0;148;0
WireConnection;150;0;151;0
WireConnection;145;0;144;0
WireConnection;77;0;83;0
WireConnection;77;1;147;0
WireConnection;62;0;61;0
WireConnection;69;0;64;0
WireConnection;70;0;76;0
WireConnection;70;1;150;0
WireConnection;248;0;80;0
WireConnection;250;0;156;0
WireConnection;330;0;331;0
WireConnection;330;1;325;0
WireConnection;65;0;68;0
WireConnection;65;1;145;0
WireConnection;246;0;63;0
WireConnection;245;0;53;0
WireConnection;82;0;81;0
WireConnection;84;0;90;0
WireConnection;84;1;153;0
WireConnection;107;0;105;0
WireConnection;107;1;106;0
WireConnection;75;0;74;0
WireConnection;54;0;4;0
WireConnection;54;1;163;0
WireConnection;89;0;88;0
WireConnection;247;0;73;0
WireConnection;249;0;87;0
WireConnection;30;0;29;0
WireConnection;30;1;33;0
WireConnection;49;0;30;0
WireConnection;215;1;84;0
WireConnection;215;6;85;0
WireConnection;215;12;89;0
WireConnection;334;0;336;0
WireConnection;334;1;330;0
WireConnection;217;1;65;0
WireConnection;217;6;66;0
WireConnection;217;12;69;0
WireConnection;214;1;70;0
WireConnection;214;6;71;0
WireConnection;214;12;75;0
WireConnection;216;1;77;0
WireConnection;216;6;78;0
WireConnection;216;12;82;0
WireConnection;129;0;107;0
WireConnection;213;1;54;0
WireConnection;213;6;60;0
WireConnection;213;12;62;0
WireConnection;283;0;271;0
WireConnection;283;1;270;0
WireConnection;9;0;5;1
WireConnection;114;0;216;0
WireConnection;281;0;266;0
WireConnection;281;1;267;0
WireConnection;332;1;334;0
WireConnection;332;0;330;0
WireConnection;332;2;336;0
WireConnection;332;3;340;0
WireConnection;108;0;129;0
WireConnection;34;0;49;0
WireConnection;280;0;265;0
WireConnection;280;1;275;0
WireConnection;279;0;264;0
WireConnection;279;1;274;0
WireConnection;188;0;104;0
WireConnection;113;0;217;0
WireConnection;112;0;213;0
WireConnection;110;0;215;0
WireConnection;278;0;268;0
WireConnection;278;1;273;0
WireConnection;111;0;214;0
WireConnection;282;0;272;0
WireConnection;282;1;269;0
WireConnection;361;0;332;0
WireConnection;109;0;188;0
WireConnection;285;0;278;0
WireConnection;285;1;279;0
WireConnection;285;2;280;0
WireConnection;285;3;281;0
WireConnection;285;4;282;0
WireConnection;285;5;283;0
WireConnection;321;0;320;0
WireConnection;321;1;318;0
WireConnection;133;0;132;0
WireConnection;133;1;134;0
WireConnection;130;0;121;0
WireConnection;130;1;122;0
WireConnection;130;2;123;0
WireConnection;130;3;124;0
WireConnection;130;4;125;0
WireConnection;130;5;128;0
WireConnection;130;6;361;0
WireConnection;136;0;134;0
WireConnection;349;0;285;0
WireConnection;349;1;350;0
WireConnection;349;2;351;0
WireConnection;257;0;251;0
WireConnection;257;1;218;0
WireConnection;261;0;255;0
WireConnection;261;1;225;0
WireConnection;319;0;130;0
WireConnection;319;1;127;0
WireConnection;319;2;321;0
WireConnection;258;0;252;0
WireConnection;258;1;222;0
WireConnection;135;0;133;0
WireConnection;135;1;136;0
WireConnection;348;0;349;0
WireConnection;348;1;347;0
WireConnection;348;2;342;0
WireConnection;262;0;256;0
WireConnection;262;1;226;0
WireConnection;353;0;6;2
WireConnection;259;0;253;0
WireConnection;259;1;223;0
WireConnection;260;0;254;0
WireConnection;260;1;224;0
WireConnection;354;0;6;1
WireConnection;354;1;353;0
WireConnection;242;0;257;0
WireConnection;242;1;258;0
WireConnection;242;2;259;0
WireConnection;242;3;260;0
WireConnection;242;4;261;0
WireConnection;242;5;262;0
WireConnection;242;6;244;0
WireConnection;190;0;189;0
WireConnection;190;1;345;0
WireConnection;131;0;319;0
WireConnection;131;1;135;0
WireConnection;292;0;348;0
WireConnection;355;1;6;0
WireConnection;355;0;354;0
WireConnection;160;0;131;0
WireConnection;298;0;242;0
WireConnection;333;1;340;0
WireConnection;333;0;190;0
WireConnection;333;2;330;0
WireConnection;333;3;340;0
WireConnection;341;0;292;0
WireConnection;137;0;160;0
WireConnection;15;0;355;0
WireConnection;232;0;298;0
WireConnection;191;0;333;0
WireConnection;295;0;341;0
WireConnection;0;0;138;0
WireConnection;0;1;139;0
WireConnection;0;2;192;0
WireConnection;0;3;140;0
WireConnection;0;4;141;0
WireConnection;0;5;142;0
ASEEND*/
//CHKSM=7193632DE0969398B30DCFA52523BB220D9B748B