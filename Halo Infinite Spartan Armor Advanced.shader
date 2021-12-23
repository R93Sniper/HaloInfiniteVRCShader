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
		[Header(ColorZone7 MetalWear)]_Color7("EdgeWearColor", Color) = (0.846,0.825,0.839,0)
		_EdgeWearAmmount("Edge Wear Ammount", Range( 0 , 1)) = 1
		_EdgeWearPower("Edge Wear Power", Range( 0.22 , 2.2)) = 1
		_RoughnessEdgeWear("Roughness Edge Wear", Range( 0 , 1)) = 0.65
		[Header(Dust and Emissives)]_CC2BColor("CC2B Color", Color) = (0.8773585,0.7514915,0.6166341,0)
		_CC2BMetallic("CC2B Metallic", Range( 0 , 1)) = 0
		_CC2BRoughness("CC2BRoughness", Range( 0 , 1)) = 0
		[KeywordEnum(NoEmissive,Zone0Emissive,Zone1Emissive,Zone2Emissive,Zone3Emissive,Zone4Emissive,Zone5Emissive,CC2BEmissive)] _EmmisiveZone("Emmisive Zone", Float) = 0
		_EmissiveIntencity("EmissiveIntencity", Range( 0 , 5)) = 1
		[KeywordEnum(Additive_MKVII,Replace_Chief)] _CC2BMixMode("CC2BMixMode", Float) = 0
		[Header(Grunge And Wear Normal Effects)]_HeightScale("Height Scale", Range( 0 , 0.02)) = 0.01
		_HeightLinearFalloffDistance("Height Linear Falloff Distance", Float) = 10
		[Toggle(_GRUNGEANDWEARNORMAL_ON)] _GrungeAndWearNormal("Grunge And Wear Normal", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 5.0
		#pragma multi_compile __ _GRUNGEANDWEARNORMAL_ON
		#pragma multi_compile _NORMALMAPFORMAT_OPENGL _NORMALMAPFORMAT_DIRECTX
		#pragma multi_compile _CC2BMIXMODE_ADDITIVE_MKVII _CC2BMIXMODE_REPLACE_CHIEF
		#pragma multi_compile _EMMISIVEZONE_NOEMISSIVE _EMMISIVEZONE_ZONE0EMISSIVE _EMMISIVEZONE_ZONE1EMISSIVE _EMMISIVEZONE_ZONE2EMISSIVE _EMMISIVEZONE_ZONE3EMISSIVE _EMMISIVEZONE_ZONE4EMISSIVE _EMMISIVEZONE_ZONE5EMISSIVE _EMMISIVEZONE_CC2BEMISSIVE
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
		};

		uniform sampler2D _BumpMap;
		uniform sampler2D _ASGMap;
		uniform float _EdgeWearAmmount;
		uniform float _EdgeWearPower;
		uniform float _GrungeAmmount;
		uniform float _GrungePower;
		uniform float _HeightLinearFalloffDistance;
		uniform float _HeightScale;
		uniform float4 _Color;
		uniform sampler2D _CC2Mask;
		uniform sampler2D _CC1Mask;
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
		uniform float4 _Color7;
		uniform float4 _CC2BColor;
		uniform float4 _Color6;
		uniform float _AODiffuseMixing;
		uniform float _EmissiveIntencity;
		uniform float _MetallicFloorZone0;
		uniform float _MetallicFloorZone1;
		uniform float _MetallicFloorZone2;
		uniform float _MetallicFloorZone3;
		uniform float _MetallicFloorZone4;
		uniform float _MetallicFloorZone5;
		uniform float _CC2BMetallic;
		uniform float _RoughnessZone0;
		uniform float _RoughnessZone1;
		uniform float _RoughnessZone2;
		uniform float _RoughnessZone3;
		uniform float _RoughnessZone4;
		uniform float _RoughnessZone5;
		uniform float _RoughnessEdgeWear;
		uniform float _RoughnessGrunge;
		uniform float _CC2BRoughness;


		float3 PerturbNormal375( float3 surf_pos, float3 surf_norm, float height, float scale )
		{
			// "Bump Mapping Unparametrized Surfaces on the GPU" by Morten S. Mikkelsen
			float3 vSigmaS = ddx( surf_pos );
			float3 vSigmaT = ddy( surf_pos );
			float3 vN = surf_norm;
			float3 vR1 = cross( vSigmaT , vN );
			float3 vR2 = cross( vN , vSigmaS );
			float fDet = dot( vSigmaS , vR1 );
			float dBs = ddx( height );
			float dBt = ddy( height );
			float3 vSurfGrad = scale * 0.05 * sign( fDet ) * ( dBs * vR1 + dBt * vR2 );
			return normalize ( abs( fDet ) * vN - vSurfGrad );
		}


		inline float3 ASESafeNormalize(float3 inVec)
		{
			float dp3 = max( 0.001f , dot( inVec , inVec ) );
			return inVec* rsqrt( dp3);
		}


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
			float3 ase_worldPos = i.worldPos;
			float3 surf_pos375 = ase_worldPos;
			float3 surf_norm375 = (WorldNormalVector( i , NormalMap15 ));
			float2 uv_ASGMap5 = i.uv_texcoord;
			float4 tex2DNode5 = tex2D( _ASGMap, uv_ASGMap5 );
			float Metallic10 = tex2DNode5.g;
			float EdgeWear27 = saturate( pow( ( Metallic10 * _EdgeWearAmmount ) , _EdgeWearPower ) );
			float Smoothness11 = tex2DNode5.b;
			float GrungeMask34 = saturate( pow( ( Smoothness11 * _GrungeAmmount ) , _GrungePower ) );
			float height375 = ( ( EdgeWear27 * 0.5 ) - GrungeMask34 );
			float scale375 = ( ( 1.0 - saturate( ( distance( ase_worldPos , _WorldSpaceCameraPos ) / _HeightLinearFalloffDistance ) ) ) * -_HeightScale );
			float3 localPerturbNormal375 = PerturbNormal375( surf_pos375 , surf_norm375 , height375 , scale375 );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_worldTangent = WorldNormalVector( i, float3( 1, 0, 0 ) );
			float3 ase_worldBitangent = WorldNormalVector( i, float3( 0, 1, 0 ) );
			float3x3 ase_worldToTangent = float3x3( ase_worldTangent, ase_worldBitangent, ase_worldNormal );
			float3 worldToTangentDir374 = ASESafeNormalize( mul( ase_worldToTangent, localPerturbNormal375) );
			#ifdef _GRUNGEANDWEARNORMAL_ON
				float3 staticSwitch398 = worldToTangentDir374;
			#else
				float3 staticSwitch398 = NormalMap15;
			#endif
			float3 FinalNormal399 = staticSwitch398;
			o.Normal = FinalNormal399;
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
			float2 uv_DetailAlbedoMap = i.uv_texcoord * _DetailAlbedoMap_ST.xy + _DetailAlbedoMap_ST.zw;
			float3 DetailColor56 = (tex2D( _DetailAlbedoMap, uv_DetailAlbedoMap )).rgb;
			float temp_output_12_0_g186 = _Zone0TileableIntensity;
			float3 Zone0Color112 = saturate( ( ( _Color * saturate( ( Zone0MaskBase52 - EdgeWear27 ) ) ).rgb * ( ( DetailColor56 * temp_output_12_0_g186 ) + ( 1.0 - temp_output_12_0_g186 ) ) ) );
			float temp_output_12_0_g185 = _Zone1TileableIntensity;
			float3 Zone1Color113 = saturate( ( ( _Color1 * saturate( ( CC1R12 - EdgeWear27 ) ) ).rgb * ( ( DetailColor56 * temp_output_12_0_g185 ) + ( 1.0 - temp_output_12_0_g185 ) ) ) );
			float temp_output_12_0_g189 = _Zone2TileableIntensity;
			float3 Zone2Color111 = saturate( ( ( _Color2 * saturate( ( CC1G13 - EdgeWear27 ) ) ).rgb * ( ( DetailColor56 * temp_output_12_0_g189 ) + ( 1.0 - temp_output_12_0_g189 ) ) ) );
			float temp_output_12_0_g188 = _Zone3TileableIntensity;
			float3 Zone3Color114 = saturate( ( ( _Color3 * saturate( ( CC1B14 - EdgeWear27 ) ) ).rgb * ( ( DetailColor56 * temp_output_12_0_g188 ) + ( 1.0 - temp_output_12_0_g188 ) ) ) );
			float temp_output_12_0_g187 = _Zone4TileableIntensity;
			float3 Zone4Color110 = saturate( ( ( _Color4 * saturate( ( CC2R16 - EdgeWear27 ) ) ).rgb * ( ( DetailColor56 * temp_output_12_0_g187 ) + ( 1.0 - temp_output_12_0_g187 ) ) ) );
			float temp_output_156_0 = saturate( ( CC2G17 - EdgeWear27 ) );
			float temp_output_12_0_g190 = _Zone5TileableIntensity;
			float3 Zone5ColorMix115 = saturate( ( ( _Color5 * temp_output_156_0 ).rgb * ( ( DetailColor56 * temp_output_12_0_g190 ) + ( 1.0 - temp_output_12_0_g190 ) ) ) );
			float3 EdgeWearColor108 = (( _Color7 * EdgeWear27 )).rgb;
			float CC2B18 = tex2DNode8.b;
			float3 temp_output_409_0 = ( CC2B18 * (_CC2BColor).rgb );
			float3 ColorCC2B411 = temp_output_409_0;
			float3 Zone6Color109 = (_Color6).rgb;
			float AO9 = tex2DNode5.r;
			float3 lerpResult319 = lerp( ( Zone0Color112 + Zone1Color113 + Zone2Color111 + Zone3Color114 + Zone4Color110 + Zone5ColorMix115 + EdgeWearColor108 + ColorCC2B411 ) , Zone6Color109 , ( AO9 * GrungeMask34 ));
			float3 lerpResult363 = lerp( lerpResult319 , ColorCC2B411 , CC2B18);
			#if defined(_CC2BMIXMODE_ADDITIVE_MKVII)
				float3 staticSwitch364 = lerpResult319;
			#elif defined(_CC2BMIXMODE_REPLACE_CHIEF)
				float3 staticSwitch364 = lerpResult363;
			#else
				float3 staticSwitch364 = lerpResult319;
			#endif
			float3 FinalColor137 = saturate( ( staticSwitch364 * ( ( AO9 * _AODiffuseMixing ) + ( 1.0 - _AODiffuseMixing ) ) ) );
			o.Albedo = FinalColor137;
			float3 temp_cast_6 = (0.0).xxx;
			float3 temp_cast_7 = (0.0).xxx;
			#if defined(_EMMISIVEZONE_NOEMISSIVE)
				float3 staticSwitch407 = temp_cast_6;
			#elif defined(_EMMISIVEZONE_ZONE0EMISSIVE)
				float3 staticSwitch407 = Zone0Color112;
			#elif defined(_EMMISIVEZONE_ZONE1EMISSIVE)
				float3 staticSwitch407 = Zone1Color113;
			#elif defined(_EMMISIVEZONE_ZONE2EMISSIVE)
				float3 staticSwitch407 = Zone2Color111;
			#elif defined(_EMMISIVEZONE_ZONE3EMISSIVE)
				float3 staticSwitch407 = Zone3Color114;
			#elif defined(_EMMISIVEZONE_ZONE4EMISSIVE)
				float3 staticSwitch407 = Zone4Color110;
			#elif defined(_EMMISIVEZONE_ZONE5EMISSIVE)
				float3 staticSwitch407 = Zone5ColorMix115;
			#elif defined(_EMMISIVEZONE_CC2BEMISSIVE)
				float3 staticSwitch407 = temp_output_409_0;
			#else
				float3 staticSwitch407 = temp_cast_6;
			#endif
			float3 Emissive191 = ( _EmissiveIntencity * staticSwitch407 );
			o.Emission = Emissive191;
			float lerpResult415 = lerp( saturate( ( ( Zone0MaskBase52 * _MetallicFloorZone0 ) + ( CC1R12 * _MetallicFloorZone1 ) + ( CC1G13 * _MetallicFloorZone2 ) + ( CC1B14 * _MetallicFloorZone3 ) + ( CC2R16 * _MetallicFloorZone4 ) + ( CC2G17 * _MetallicFloorZone5 ) + EdgeWear27 ) ) , _CC2BMetallic , CC2B18);
			float mettalicResult232 = lerpResult415;
			o.Metallic = mettalicResult232;
			float ColorZone0Mask245 = Zone0MaskBase52;
			float ColorZone1Mask246 = CC1R12;
			float ColorZone2Mask247 = CC1G13;
			float ColorZone3Mask248 = CC1B14;
			float ColorZone4Mask249 = CC2R16;
			float ColorZone5Mask250 = temp_output_156_0;
			float lerpResult349 = lerp( ( ( ColorZone0Mask245 * _RoughnessZone0 ) + ( ColorZone1Mask246 * _RoughnessZone1 ) + ( ColorZone2Mask247 * _RoughnessZone2 ) + ( ColorZone3Mask248 * _RoughnessZone3 ) + ( ColorZone4Mask249 * _RoughnessZone4 ) + ( ColorZone5Mask250 * _RoughnessZone5 ) ) , _RoughnessEdgeWear , EdgeWear27);
			float lerpResult348 = lerp( lerpResult349 , _RoughnessGrunge , GrungeMask34);
			float lerpResult414 = lerp( lerpResult348 , _CC2BRoughness , CC2B18);
			float finalSmooth295 = ( 1.0 - saturate( lerpResult414 ) );
			o.Smoothness = finalSmooth295;
			o.Occlusion = AO9;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18909
28;619;1920;1027;954.1621;-282.2177;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;19;-4215.966,-425.5382;Inherit;False;2083.316;737.5338;Texture Input;24;15;6;9;18;11;13;12;14;305;306;10;308;307;300;309;302;5;16;17;7;8;353;354;355;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;8;-4169.837,108.2734;Inherit;True;Property;_CC2Mask;CC2 Mask;2;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;6283700c70f7c6e4abdff5dd33889209;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;16;-3881.837,108.2734;Inherit;False;CC2R;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;17;-3881.837,172.2734;Inherit;False;CC2G;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;7;-4169.837,-83.72655;Inherit;True;Property;_CC1Mask;CC1 Mask;1;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;302;-3610.984,81.08555;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;300;-3612.914,-11.62844;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;309;-3582.106,207.3414;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;307;-3436.55,143.1882;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;308;-3430.568,52.46549;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;305;-3307.257,52.63706;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;5;-4180.263,-370.6066;Inherit;True;Property;_ASGMap;ASGMap;0;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;e0f39a03e3a18f64ca1752db41799387;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;176;-2116,-378;Inherit;False;1513;694;Simple Contrast/knee adjustment for wear and grunge;3;35;36;50;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;306;-3307.257,148.6371;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;36;-2065,-328;Inherit;False;1412;335;Wear;6;20;22;21;27;26;23;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;13;-3179.257,148.6371;Inherit;False;CC1G;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;174;-591.9655,-372.664;Inherit;False;997.9117;485;BaseColorMask, inverse of all other zones;9;38;42;41;37;40;45;51;146;52;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;14;-3881.837,28.27343;Inherit;False;CC1B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;12;-3177.246,49.03101;Inherit;False;CC1R;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;10;-3892.263,-306.6066;Inherit;False;Metallic;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;40;-544,-192;Inherit;False;12;CC1R;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;38;-541.9654,-258.6643;Inherit;False;17;CC2G;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;37;-541.9654,-322.664;Inherit;False;16;CC2R;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;42;-544,-64;Inherit;False;14;CC1B;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;41;-544,-128;Inherit;False;13;CC1G;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;20;-1919,-278;Inherit;False;10;Metallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-2015,-214;Inherit;False;Property;_EdgeWearAmmount;Edge Wear Ammount;36;0;Create;True;0;0;0;False;0;False;1;0.775;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-1679,-278;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;45;-269.9655,-226.6643;Inherit;False;5;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-1691.538,-171.1129;Inherit;False;Property;_EdgeWearPower;Edge Wear Power;37;0;Create;True;0;0;0;False;0;False;1;1.614;0.22;2.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;146;-115.2356,-223.2774;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;22;-1151,-278;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;51;16,-224;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;50;-1024,-272;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;175;-4656.449,335.5491;Inherit;False;4770.954;1117.542;ZoneClorization;8;171;170;169;168;167;166;165;164;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;161;-5137.636,-155.4267;Inherit;False;831.3411;458;Tileable texture Input and Chacing ;3;56;59;58;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;169;-3365.632,925.0906;Inherit;False;1287.807;528;ColorZone3;11;149;80;148;83;147;77;78;82;114;81;248;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;170;-2070.864,926.5673;Inherit;False;1221;510;ColorZone5;11;158;94;157;156;97;95;92;91;96;115;250;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;166;-2119.803,386.3632;Inherit;False;1248.863;518.4703;ColorZone4;12;88;89;110;215;84;85;90;153;154;87;155;249;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;27;-848,-288;Inherit;False;EdgeWear;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;165;-3371.885,387.1251;Inherit;False;1251.154;514.5886;ColorZone2;12;75;111;214;71;70;76;74;150;151;152;73;247;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;168;-4606.449,923.1078;Inherit;False;1234;489;ColorZone1;11;63;143;144;68;145;64;65;69;66;113;246;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;52;162.9462,-229.5894;Inherit;False;Zone0MaskBase;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;164;-4605.476,385.5491;Inherit;False;1228.8;531.4999;ColorZone0;11;47;53;46;163;4;61;62;60;54;112;245;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;47;-4501.309,696.0551;Inherit;False;27;EdgeWear;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;73;-3245.785,597.1251;Inherit;False;13;CC1G;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;94;-1956.865,1152.567;Inherit;False;17;CC2G;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;143;-4478.492,1200.77;Inherit;False;27;EdgeWear;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;58;-5087.636,-105.4267;Inherit;True;Property;_DetailAlbedoMap;DetailTexture;5;0;Create;False;0;0;0;False;0;False;-1;None;3ee0c06ad3bf2134fb04893b5d83e42a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;63;-4479.449,1133.108;Inherit;False;12;CC1R;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;53;-4507.612,620.2418;Inherit;False;52;Zone0MaskBase;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;87;-1981.007,596.3628;Inherit;False;16;CC2R;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;80;-3220.632,1154.091;Inherit;False;14;CC1B;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;158;-1956.865,1232.567;Inherit;False;27;EdgeWear;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;149;-3219.877,1221.544;Inherit;False;27;EdgeWear;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;35;-2066,-18;Inherit;False;1413;329;Grunge;7;34;33;32;31;30;29;49;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;152;-3246.284,669.0932;Inherit;False;27;EdgeWear;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;11;-3892.263,-242.6065;Inherit;False;Smoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;155;-1989.007,657.3628;Inherit;False;27;EdgeWear;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;151;-3071.24,617.4312;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;59;-4792.294,-100.9871;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;144;-4303.448,1149.108;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;418;-657.9304,1473.206;Inherit;False;1415.007;759.0588;Emissives;16;324;331;325;409;411;404;405;408;402;406;401;403;407;189;410;191;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;148;-3044.834,1169.882;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;171;-839.3092,932.5456;Inherit;False;878;325;EdgeWearColor;5;105;106;107;129;108;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-2016,192;Inherit;False;Property;_GrungeAmmount;Grunge Ammount;32;0;Create;True;0;0;0;False;0;False;1;0.547;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;157;-1780.865,1184.567;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;154;-1813.007,609.3628;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;46;-4301.309,648.0552;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;31;-1984,32;Inherit;False;11;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;74;-3321.885,745.6246;Inherit;False;Property;_Zone2TileableIntensity;Zone2 Tileable Intensity ;16;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;18;-3881.837,236.2734;Inherit;False;CC2B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;153;-1685.007,625.3628;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;61;-4544,832;Inherit;False;Property;_Zone0TileableIntensity;Zone0 Tileable Intensity ;8;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;64;-4558.449,1270.108;Inherit;False;Property;_Zone1TileableIntensity;Zone1 Tileable Intensity ;12;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;68;-4479.449,973.1078;Inherit;False;Property;_Color1;Color 1;11;1;[Header];Create;True;1;ColorZone1;0;0;False;0;False;0,1,0,0;0,1,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;33;-1712,128;Inherit;False;Property;_GrungePower;Grunge Power;33;0;Create;True;0;0;0;False;0;False;1;0.805;0.22;2.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;105;-789.3092,982.5456;Inherit;False;Property;_Color7;EdgeWearColor;35;1;[Header];Create;False;1;ColorZone7 MetalWear;0;0;False;0;False;0.846,0.825,0.839,0;0.846,0.825,0.839,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;56;-4568.294,-100.9871;Inherit;False;DetailColor;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;83;-3214.632,975.0906;Inherit;False;Property;_Color3;Color 3;19;1;[Header];Create;True;1;ColorZone3;0;0;False;0;False;0,1,1,0;0,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;81;-3296,1296;Inherit;False;Property;_Zone3TileableIntensity;Zone3 Tileable Intensity ;20;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;145;-4175.45,1165.108;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;163;-4179.676,643.5488;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;4;-4483.676,435.5491;Inherit;False;Property;_Color;Color 0;7;1;[Header];Create;False;1;ColorZone0;0;0;False;0;False;1,0,0,0;0.1686274,0.2313724,0.2862744,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;324;-607.9304,2025.265;Inherit;False;Property;_CC2BColor;CC2B Color;39;1;[Header];Create;True;1;Dust and Emissives;0;0;False;0;False;0.8773585,0.7514915,0.6166341,0;0.622,0.5320251,0.4342263,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-1698.55,37.23729;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;106;-757.3092,1142.546;Inherit;False;27;EdgeWear;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;147;-2916.834,1185.882;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;90;-1981.007,436.3632;Inherit;False;Property;_Color4;Color 4;23;1;[Header];Create;True;1;ColorZone4;0;0;False;0;False;1,1,0,0;0.4509804,0.4509804,0.4509804,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;150;-2943.24,633.4312;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;76;-3245.785,437.1251;Inherit;False;Property;_Color2;Color 2;15;1;[Header];Create;True;1;ColorZone2;0;0;False;0;False;0,0,1,0;0,0,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;156;-1652.865,1200.567;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;97;-1956.865,976.5673;Inherit;False;Property;_Color5;Color 5;27;1;[Header];Create;True;1;ColorZone5;0;0;False;0;False;1,0,1,0;0.4509804,0.4509804,0.4509804,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;95;-2032,1296;Inherit;False;Property;_Zone5TileableIntensity;Zone5 Tileable Intensity ;28;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;88;-2064,720;Inherit;False;Property;_Zone4TileableIntensity;Zone4 Tileable Intensity ;24;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;54;-4035.676,467.549;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;-4047.45,973.1078;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;85;-1709.007,564.3628;Inherit;False;56;DetailColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;66;-4127.45,1101.108;Inherit;False;56;DetailColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;62;-3979.476,802.0487;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;70;-2813.785,453.1251;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;167;-863.7588,389.5759;Inherit;False;928.2639;514.446;ColorZone6 Grunge Color;3;109;188;104;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WireNode;75;-2752,736;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;30;-1184,32;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;82;-2736,1280;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;71;-2973.785,565.1251;Inherit;False;56;DetailColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;78;-2942.632,1103.091;Inherit;False;56;DetailColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;89;-1472,704;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;77;-2782.632,991.0906;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;331;-353.166,1957.683;Inherit;False;18;CC2B;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;107;-533.3094,998.5456;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;91;-1508.865,992.5673;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;92;-1668.865,1104.567;Inherit;False;56;DetailColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;60;-4195.676,563.5488;Inherit;False;56;DetailColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;69;-4005.45,1252.108;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;96;-1461,1285;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;389;147.2158,945.7318;Inherit;False;2551.93;488.0175;DepthFade Bump To Normal;21;399;398;397;392;390;379;391;396;395;378;376;374;375;387;386;385;384;393;383;377;382;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;6;-3312,-384;Inherit;True;Property;_BumpMap;NormalMap;3;1;[NoScaleOffset];Create;False;0;0;0;False;0;False;-1;None;4183d08cea76c094ab4e0a3bf3b6bcb9;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;84;-1533.007,436.3632;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ComponentMaskNode;325;-378.8848,2024.294;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;104;-818.4949,439.5759;Inherit;False;Property;_Color6;Color 6;31;1;[Header];Create;True;1;ColorZone6 grunge;0;0;False;0;False;0,0,0,0;0.3919999,0.2778299,0.1179919,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldPosInputsNode;377;274.5376,1093.759;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;296;-2916.832,1462.662;Inherit;False;2240.857;1132.46;SmoothNessAdjust;31;348;295;341;292;349;342;347;350;285;351;281;279;280;278;283;282;274;265;267;270;269;264;273;275;271;266;272;268;370;369;414;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;49;-1056,32;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;213;-3907.676,483.549;Inherit;False;MF_SimpleDetailDiffuse;-1;;186;e6e4a2444c47f7a42bdb4a4522f8e7eb;0;3;1;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;12;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;382;178.7592,1264.425;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;247;-2642.314,629.6193;Inherit;False;ColorZone2Mask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;245;-3870.308,638.8777;Inherit;False;ColorZone0Mask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;129;-405.3095,998.5456;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;215;-1405.007,468.363;Inherit;False;MF_SimpleDetailDiffuse;-1;;187;e6e4a2444c47f7a42bdb4a4522f8e7eb;0;3;1;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;12;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;409;-115.0709,1961.137;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;217;-3903.45,1021.108;Inherit;False;MF_SimpleDetailDiffuse;-1;;185;e6e4a2444c47f7a42bdb4a4522f8e7eb;0;3;1;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;12;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;250;-1363.478,1193.14;Inherit;False;ColorZone5Mask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;216;-2638.632,1023.091;Inherit;False;MF_SimpleDetailDiffuse;-1;;188;e6e4a2444c47f7a42bdb4a4522f8e7eb;0;3;1;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;12;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;249;-1390.337,618.4454;Inherit;False;ColorZone4Mask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;353;-3008,-288;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;214;-2669.785,485.125;Inherit;False;MF_SimpleDetailDiffuse;-1;;189;e6e4a2444c47f7a42bdb4a4522f8e7eb;0;3;1;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;12;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;212;-1380.865,1024.567;Inherit;False;MF_SimpleDetailDiffuse;-1;;190;e6e4a2444c47f7a42bdb4a4522f8e7eb;0;3;1;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;12;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;248;-2639.802,1180.403;Inherit;False;ColorZone3Mask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;246;-3881.772,1160.903;Inherit;False;ColorZone1Mask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;272;-2853.532,2024.662;Inherit;False;249;ColorZone4Mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;111;-2365.786,485.125;Inherit;False;Zone2Color;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;268;-2853.532,1512.662;Inherit;False;245;ColorZone0Mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;383;504.7595,1227.425;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;110;-1117.007,468.363;Inherit;False;Zone4Color;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;273;-2853.532,1576.662;Inherit;False;Property;_RoughnessZone0;Roughness Zone0;10;0;Create;True;0;0;0;False;0;False;0.65;0.65;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;275;-2853.532,1832.662;Inherit;False;Property;_RoughnessZone2;Roughness Zone2;18;0;Create;True;0;0;0;False;0;False;0.65;0.65;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;271;-2853.532,2152.662;Inherit;False;250;ColorZone5Mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;274;-2853.532,1704.662;Inherit;False;Property;_RoughnessZone1;Roughness Zone1;14;0;Create;True;0;0;0;False;0;False;0.65;0.65;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;264;-2853.532,1640.662;Inherit;False;246;ColorZone1Mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;354;-2880,-320;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;34;-852,28;Inherit;False;GrungeMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;113;-3615.45,1021.108;Inherit;False;Zone1Color;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;9;-3892.263,-370.6066;Inherit;False;AO;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;393;441.8034,1328.369;Inherit;False;Property;_HeightLinearFalloffDistance;Height Linear Falloff Distance;46;0;Create;True;0;0;0;False;0;False;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;112;-3619.676,483.549;Inherit;False;Zone0Color;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;266;-2853.532,1896.662;Inherit;False;248;ColorZone3Mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;270;-2853.532,2216.662;Inherit;False;Property;_RoughnessZone5;Roughness Zone5;30;0;Create;True;0;0;0;False;0;False;0.65;0.65;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;115;-1092.865,1024.567;Inherit;False;Zone5ColorMix;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;269;-2853.532,2088.662;Inherit;False;Property;_RoughnessZone4;Roughness Zone4;26;0;Create;True;0;0;0;False;0;False;0.65;0.65;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;172;140.0589,336.4792;Inherit;False;2190.679;594.2961;Final Color Mixing;26;137;160;131;319;321;318;127;320;135;136;133;134;132;130;125;128;122;123;124;121;413;412;365;363;364;419;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;411;48.02235,2013.683;Inherit;False;ColorCC2B;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;265;-2853.532,1768.662;Inherit;False;247;ColorZone2Mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;267;-2853.532,1960.662;Inherit;False;Property;_RoughnessZone3;Roughness Zone3;22;0;Create;True;0;0;0;False;0;False;0.65;0.65;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;188;-624,432;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;114;-2320.825,1028.262;Inherit;False;Zone3Color;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;108;-213.3093,998.5456;Inherit;False;EdgeWearColor;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;278;-2536.708,1534.082;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;109;-432,434;Inherit;False;Zone6Color;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;413;180.4446,852.9225;Inherit;False;411;ColorCC2B;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;318;596.0247,707.3745;Inherit;False;34;GrungeMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;384;786.8986,1231.435;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;279;-2533.532,1672.662;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;282;-2533.532,2056.662;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;121;182.7634,388.911;Inherit;False;112;Zone0Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;355;-2720,-368;Inherit;False;Property;_NormalMapFormat;NormalMapFormat;4;0;Create;True;0;0;0;False;0;False;1;1;1;True;;KeywordEnum;2;OpenGL;DirectX;Create;False;True;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;128;179.3442,783.3642;Inherit;False;108;EdgeWearColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;283;-2533.532,2184.662;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;320;596.0247,643.3745;Inherit;False;9;AO;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;419;180.8379,715.2177;Inherit;False;115;Zone5ColorMix;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;123;182.7634,516.9112;Inherit;False;111;Zone2Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;281;-2533.532,1928.662;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;125;182.7634,644.911;Inherit;False;110;Zone4Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;122;182.7634,452.9112;Inherit;False;113;Zone1Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;124;182.7634,580.911;Inherit;False;114;Zone3Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;280;-2533.532,1800.662;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;350;-2299.264,2051.965;Inherit;False;Property;_RoughnessEdgeWear;Roughness Edge Wear;38;0;Create;True;0;0;0;False;0;False;0.65;0.35;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;351;-2217.717,2122.393;Inherit;False;27;EdgeWear;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;130;472.0627,504.8083;Inherit;False;8;8;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;321;804.0247,643.3745;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;378;909.8603,1326.278;Inherit;False;Property;_HeightScale;Height Scale;45;1;[Header];Create;True;1;Grunge And Wear Normal Effects;0;0;False;0;False;0.01;-0.01;0;0.02;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;127;596.0247,579.3745;Inherit;False;109;Zone6Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;263;-4651.307,1458.221;Inherit;False;1726.394;973.7399;Metallic Floor Values For Each Channel;25;232;298;242;261;262;258;244;259;257;260;226;252;253;254;251;224;255;225;222;223;218;256;415;416;417;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;379;1085.373,994.7789;Inherit;False;27;EdgeWear;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;15;-2464,-368;Inherit;False;NormalMap;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;285;-2293.532,1864.662;Inherit;False;6;6;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;385;893.9034,1235.142;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;256;-4601.308,2148.221;Inherit;False;17;CC2G;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;254;-4601.308,1892.222;Inherit;False;14;CC1B;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;226;-4601.308,2212.221;Inherit;False;Property;_MetallicFloorZone5;Metallic Floor Zone5;29;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;347;-1927.01,1981.245;Inherit;False;Property;_RoughnessGrunge;Roughness Grunge;34;0;Create;True;0;0;0;False;0;False;0.65;0.65;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;395;1207.64,1341.39;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;390;1086.683,1064.355;Inherit;False;34;GrungeMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;396;1252.325,1196.537;Inherit;False;15;NormalMap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;255;-4601.308,2020.221;Inherit;False;16;CC2R;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;253;-4601.308,1764.222;Inherit;False;13;CC1G;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;252;-4601.308,1636.221;Inherit;False;12;CC1R;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;349;-1931.24,1870.682;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;224;-4601.308,1956.222;Inherit;False;Property;_MetallicFloorZone3;Metallic Floor Zone3;21;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;365;1041.43,682.8591;Inherit;False;18;CC2B;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;223;-4601.308,1828.222;Inherit;False;Property;_MetallicFloorZone2;Metallic Floor Zone2;17;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;386;1023.731,1239.325;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;218;-4601.308,1572.221;Inherit;False;Property;_MetallicFloorZone0;Metallic Floor Zone0;9;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;319;1044.024,499.3748;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;392;1312.647,987.8367;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;134;1185.633,850.846;Inherit;False;Property;_AODiffuseMixing;AO DiffuseMixing;6;0;Create;True;0;0;0;False;0;False;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;412;1041.48,613.5442;Inherit;False;411;ColorCC2B;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;251;-4601.308,1508.221;Inherit;False;52;Zone0MaskBase;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;132;1178.337,757.2778;Inherit;False;9;AO;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;342;-1854.752,2051.38;Inherit;False;34;GrungeMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;222;-4601.308,1700.222;Inherit;False;Property;_MetallicFloorZone1;Metallic Floor Zone1;13;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;225;-4601.308,2084.221;Inherit;False;Property;_MetallicFloorZone4;Metallic Floor Zone4;25;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;391;1518.498,1035.597;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;387;1564.727,1315.325;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;136;1473.634,850.846;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;370;-1622.695,1986.331;Inherit;False;Property;_CC2BRoughness;CC2BRoughness;41;0;Create;True;0;0;0;False;0;False;0;0.55;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;348;-1594.433,1871.941;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;257;-4297.307,1540.221;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;261;-4297.307,2052.221;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;262;-4297.307,2180.221;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;260;-4297.307,1924.222;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;363;1304.477,568.45;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;258;-4297.307,1668.221;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;376;1496.919,1171.417;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;259;-4297.307,1796.222;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;369;-1528.057,2056.618;Inherit;False;18;CC2B;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;244;-4345.307,2308.221;Inherit;False;27;EdgeWear;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;133;1466.338,757.2778;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;135;1642.339,757.2778;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;414;-1336.837,1875.807;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;402;-374.4203,1883.149;Inherit;False;115;Zone5ColorMix;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;364;1474.01,501.0182;Inherit;False;Property;_CC2BMixMode;CC2BMixMode;44;0;Create;True;0;0;0;False;0;False;1;0;0;True;;KeywordEnum;2;Additive_MKVII;Replace_Chief;Create;False;True;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;403;-374.4203,1627.149;Inherit;False;113;Zone1Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CustomExpressionNode;375;1727.161,1135.697;Inherit;False;// "Bump Mapping Unparametrized Surfaces on the GPU" by Morten S. Mikkelsen$float3 vSigmaS = ddx( surf_pos )@$float3 vSigmaT = ddy( surf_pos )@$float3 vN = surf_norm@$float3 vR1 = cross( vSigmaT , vN )@$float3 vR2 = cross( vN , vSigmaS )@$float fDet = dot( vSigmaS , vR1 )@$float dBs = ddx( height )@$float dBt = ddy( height )@$float3 vSurfGrad = scale * 0.05 * sign( fDet ) * ( dBs * vR1 + dBt * vR2 )@$return normalize ( abs( fDet ) * vN - vSurfGrad )@$;3;Create;4;True;surf_pos;FLOAT3;0,0,0;In;;Inherit;False;True;surf_norm;FLOAT3;0,0,0;In;;Inherit;False;True;height;FLOAT;0;In;;Inherit;False;True;scale;FLOAT;0;In;;Inherit;False;PerturbNormal;True;False;0;;False;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;405;-374.4203,1691.149;Inherit;False;111;Zone2Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;408;-156.1667,1523.206;Inherit;False;Constant;_Float0;Float 0;47;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;401;-374.4203,1755.149;Inherit;False;114;Zone3Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;242;-4041.307,1860.222;Inherit;False;7;7;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;404;-374.4203,1563.149;Inherit;False;112;Zone0Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;406;-374.4203,1819.149;Inherit;False;110;Zone4Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;131;1791.095,497.991;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;417;-3849.632,1991.123;Inherit;False;18;CC2B;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;292;-1195.274,1876.625;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;416;-3918.712,1921.224;Inherit;False;Property;_CC2BMetallic;CC2B Metallic;40;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;397;1960.365,1059.649;Inherit;False;15;NormalMap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;298;-3920,1856;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;407;58.17965,1628.949;Inherit;False;Property;_EmmisiveZone;Emmisive Zone;42;0;Create;True;0;0;0;False;0;False;1;0;0;True;;KeywordEnum;8;NoEmissive;Zone0Emissive;Zone1Emissive;Zone2Emissive;Zone3Emissive;Zone4Emissive;Zone5Emissive;CC2BEmissive;Create;False;True;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TransformDirectionNode;374;1929.747,1134.964;Inherit;False;World;Tangent;True;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;189;65.11073,1543.91;Inherit;False;Property;_EmissiveIntencity;EmissiveIntencity;43;0;Create;True;0;0;0;False;0;False;1;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;341;-1067.274,1876.625;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;410;384.1494,1589.553;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;415;-3562.496,1848.357;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;160;1923.328,501.2916;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;398;2208.61,1083.014;Inherit;False;Property;_GrungeAndWearNormal;Grunge And Wear Normal;47;0;Create;True;0;0;0;False;0;False;1;0;0;True;;Toggle;2;Key0;Key1;Create;False;True;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;191;514.0762,1587.493;Inherit;False;Emissive;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;399;2474.64,1087.14;Inherit;False;FinalNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;295;-923.2742,1876.625;Inherit;False;finalSmooth;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;232;-3399,1843;Inherit;False;mettalicResult;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;137;2063.095,497.991;Inherit;False;FinalColor;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;173;410.7229,-373.6451;Inherit;False;654.9984;523.1563;Output;7;0;142;139;141;138;192;140;v 0.41 Bumpy Roads Ahead;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;139;439.1889,-243.5586;Inherit;False;399;FinalNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;140;439.1889,-115.5587;Inherit;False;232;mettalicResult;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;142;462.89,27.26391;Inherit;False;9;AO;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;138;439.1889,-307.5588;Inherit;False;137;FinalColor;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;141;440.4985,-44.25827;Inherit;False;295;finalSmooth;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;192;439.1889,-179.5586;Inherit;False;191;Emissive;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;810.824,-304.7744;Float;False;True;-1;7;ASEMaterialInspector;0;0;Standard;HaloInfinte/-Advanced- Halo Infinite Spartan Armor;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;177;-4664.194,-511.3466;Inherit;False;100;100;Made for assets from Halo Infinite, Prototyped in Unreal Engine by R93_Sniper, ported to Unity in amplify by PointDevice;0;Made for assets from Halo Infinite, Prototyped in Unreal Engine by R93_Sniper, ported to Unity in amplify by PointDevice;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;178;-4672.927,-677.2261;Inherit;False;100;100;Comment;0;Licensed Under AGPL 3.0, You may redistribute, and modify this program, all derivitive works must carry the same license ;1,1,1,1;0;0
WireConnection;16;0;8;1
WireConnection;17;0;8;2
WireConnection;302;0;7;2
WireConnection;302;1;16;0
WireConnection;300;0;7;1
WireConnection;300;1;16;0
WireConnection;309;0;17;0
WireConnection;307;0;302;0
WireConnection;307;1;309;0
WireConnection;308;0;300;0
WireConnection;308;1;309;0
WireConnection;305;0;308;0
WireConnection;306;0;307;0
WireConnection;13;0;306;0
WireConnection;14;0;7;3
WireConnection;12;0;305;0
WireConnection;10;0;5;2
WireConnection;21;0;20;0
WireConnection;21;1;23;0
WireConnection;45;0;37;0
WireConnection;45;1;38;0
WireConnection;45;2;40;0
WireConnection;45;3;41;0
WireConnection;45;4;42;0
WireConnection;146;0;45;0
WireConnection;22;0;21;0
WireConnection;22;1;26;0
WireConnection;51;0;146;0
WireConnection;50;0;22;0
WireConnection;27;0;50;0
WireConnection;52;0;51;0
WireConnection;11;0;5;3
WireConnection;151;0;73;0
WireConnection;151;1;152;0
WireConnection;59;0;58;0
WireConnection;144;0;63;0
WireConnection;144;1;143;0
WireConnection;148;0;80;0
WireConnection;148;1;149;0
WireConnection;157;0;94;0
WireConnection;157;1;158;0
WireConnection;154;0;87;0
WireConnection;154;1;155;0
WireConnection;46;0;53;0
WireConnection;46;1;47;0
WireConnection;18;0;8;3
WireConnection;153;0;154;0
WireConnection;56;0;59;0
WireConnection;145;0;144;0
WireConnection;163;0;46;0
WireConnection;29;0;31;0
WireConnection;29;1;32;0
WireConnection;147;0;148;0
WireConnection;150;0;151;0
WireConnection;156;0;157;0
WireConnection;54;0;4;0
WireConnection;54;1;163;0
WireConnection;65;0;68;0
WireConnection;65;1;145;0
WireConnection;62;0;61;0
WireConnection;70;0;76;0
WireConnection;70;1;150;0
WireConnection;75;0;74;0
WireConnection;30;0;29;0
WireConnection;30;1;33;0
WireConnection;82;0;81;0
WireConnection;89;0;88;0
WireConnection;77;0;83;0
WireConnection;77;1;147;0
WireConnection;107;0;105;0
WireConnection;107;1;106;0
WireConnection;91;0;97;0
WireConnection;91;1;156;0
WireConnection;69;0;64;0
WireConnection;96;0;95;0
WireConnection;84;0;90;0
WireConnection;84;1;153;0
WireConnection;325;0;324;0
WireConnection;49;0;30;0
WireConnection;213;1;54;0
WireConnection;213;6;60;0
WireConnection;213;12;62;0
WireConnection;247;0;73;0
WireConnection;245;0;53;0
WireConnection;129;0;107;0
WireConnection;215;1;84;0
WireConnection;215;6;85;0
WireConnection;215;12;89;0
WireConnection;409;0;331;0
WireConnection;409;1;325;0
WireConnection;217;1;65;0
WireConnection;217;6;66;0
WireConnection;217;12;69;0
WireConnection;250;0;156;0
WireConnection;216;1;77;0
WireConnection;216;6;78;0
WireConnection;216;12;82;0
WireConnection;249;0;87;0
WireConnection;353;0;6;2
WireConnection;214;1;70;0
WireConnection;214;6;71;0
WireConnection;214;12;75;0
WireConnection;212;1;91;0
WireConnection;212;6;92;0
WireConnection;212;12;96;0
WireConnection;248;0;80;0
WireConnection;246;0;63;0
WireConnection;111;0;214;0
WireConnection;383;0;377;0
WireConnection;383;1;382;0
WireConnection;110;0;215;0
WireConnection;354;0;6;1
WireConnection;354;1;353;0
WireConnection;34;0;49;0
WireConnection;113;0;217;0
WireConnection;9;0;5;1
WireConnection;112;0;213;0
WireConnection;115;0;212;0
WireConnection;411;0;409;0
WireConnection;188;0;104;0
WireConnection;114;0;216;0
WireConnection;108;0;129;0
WireConnection;278;0;268;0
WireConnection;278;1;273;0
WireConnection;109;0;188;0
WireConnection;384;0;383;0
WireConnection;384;1;393;0
WireConnection;279;0;264;0
WireConnection;279;1;274;0
WireConnection;282;0;272;0
WireConnection;282;1;269;0
WireConnection;355;1;6;0
WireConnection;355;0;354;0
WireConnection;283;0;271;0
WireConnection;283;1;270;0
WireConnection;281;0;266;0
WireConnection;281;1;267;0
WireConnection;280;0;265;0
WireConnection;280;1;275;0
WireConnection;130;0;121;0
WireConnection;130;1;122;0
WireConnection;130;2;123;0
WireConnection;130;3;124;0
WireConnection;130;4;125;0
WireConnection;130;5;419;0
WireConnection;130;6;128;0
WireConnection;130;7;413;0
WireConnection;321;0;320;0
WireConnection;321;1;318;0
WireConnection;15;0;355;0
WireConnection;285;0;278;0
WireConnection;285;1;279;0
WireConnection;285;2;280;0
WireConnection;285;3;281;0
WireConnection;285;4;282;0
WireConnection;285;5;283;0
WireConnection;385;0;384;0
WireConnection;395;0;378;0
WireConnection;349;0;285;0
WireConnection;349;1;350;0
WireConnection;349;2;351;0
WireConnection;386;0;385;0
WireConnection;319;0;130;0
WireConnection;319;1;127;0
WireConnection;319;2;321;0
WireConnection;392;0;379;0
WireConnection;391;0;392;0
WireConnection;391;1;390;0
WireConnection;387;0;386;0
WireConnection;387;1;395;0
WireConnection;136;0;134;0
WireConnection;348;0;349;0
WireConnection;348;1;347;0
WireConnection;348;2;342;0
WireConnection;257;0;251;0
WireConnection;257;1;218;0
WireConnection;261;0;255;0
WireConnection;261;1;225;0
WireConnection;262;0;256;0
WireConnection;262;1;226;0
WireConnection;260;0;254;0
WireConnection;260;1;224;0
WireConnection;363;0;319;0
WireConnection;363;1;412;0
WireConnection;363;2;365;0
WireConnection;258;0;252;0
WireConnection;258;1;222;0
WireConnection;376;0;396;0
WireConnection;259;0;253;0
WireConnection;259;1;223;0
WireConnection;133;0;132;0
WireConnection;133;1;134;0
WireConnection;135;0;133;0
WireConnection;135;1;136;0
WireConnection;414;0;348;0
WireConnection;414;1;370;0
WireConnection;414;2;369;0
WireConnection;364;1;319;0
WireConnection;364;0;363;0
WireConnection;375;0;377;0
WireConnection;375;1;376;0
WireConnection;375;2;391;0
WireConnection;375;3;387;0
WireConnection;242;0;257;0
WireConnection;242;1;258;0
WireConnection;242;2;259;0
WireConnection;242;3;260;0
WireConnection;242;4;261;0
WireConnection;242;5;262;0
WireConnection;242;6;244;0
WireConnection;131;0;364;0
WireConnection;131;1;135;0
WireConnection;292;0;414;0
WireConnection;298;0;242;0
WireConnection;407;1;408;0
WireConnection;407;0;404;0
WireConnection;407;2;403;0
WireConnection;407;3;405;0
WireConnection;407;4;401;0
WireConnection;407;5;406;0
WireConnection;407;6;402;0
WireConnection;407;7;409;0
WireConnection;374;0;375;0
WireConnection;341;0;292;0
WireConnection;410;0;189;0
WireConnection;410;1;407;0
WireConnection;415;0;298;0
WireConnection;415;1;416;0
WireConnection;415;2;417;0
WireConnection;160;0;131;0
WireConnection;398;1;397;0
WireConnection;398;0;374;0
WireConnection;191;0;410;0
WireConnection;399;0;398;0
WireConnection;295;0;341;0
WireConnection;232;0;415;0
WireConnection;137;0;160;0
WireConnection;0;0;138;0
WireConnection;0;1;139;0
WireConnection;0;2;192;0
WireConnection;0;3;140;0
WireConnection;0;4;141;0
WireConnection;0;5;142;0
ASEEND*/
//CHKSM=42BA4BBA6BBBBF3EA25F0B555C5206852D508D8C