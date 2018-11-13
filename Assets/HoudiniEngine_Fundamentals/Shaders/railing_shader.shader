// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Temple/Railing"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_Albedo("Albedo", 2D) = "white" {}
		_MettalicSmoothnessA("Mettalic (Smoothness A)", 2D) = "white" {}
		_WornStone("Worn Stone", 2D) = "white" {}
		_WearAmount("Wear Amount", Range( 0 , 1)) = 0.5
		_MossColor("Moss Color", Color) = (0.2662168,0.3161765,0.1255407,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform sampler2D _WornStone;
		uniform float4 _WornStone_ST;
		uniform float _WearAmount;
		uniform float4 _MossColor;
		uniform sampler2D _MettalicSmoothnessA;
		uniform float4 _MettalicSmoothnessA_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			float2 uv_WornStone = i.uv_texcoord * _WornStone_ST.xy + _WornStone_ST.zw;
			float4 lerpResult5 = lerp( ( tex2D( _Albedo, uv_Albedo ) * i.vertexColor.r ) , tex2D( _WornStone, uv_WornStone ) , ( i.vertexColor.b * _WearAmount ));
			float4 lerpResult10 = lerp( lerpResult5 , _MossColor , i.vertexColor.g);
			o.Albedo = lerpResult10.rgb;
			float2 uv_MettalicSmoothnessA = i.uv_texcoord * _MettalicSmoothnessA_ST.xy + _MettalicSmoothnessA_ST.zw;
			float4 tex2DNode8 = tex2D( _MettalicSmoothnessA, uv_MettalicSmoothnessA );
			o.Metallic = tex2DNode8.r;
			o.Smoothness = tex2DNode8.a;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13201
26;212;1725;797;1751.692;673.551;1.425516;True;True
Node;AmplifyShaderEditor.SamplerNode;2;-1367.747,-158.6263;Float;True;Property;_Albedo;Albedo;0;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.VertexColorNode;1;-1364.747,102.3736;Float;False;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;6;-1327.02,354.4391;Float;False;Property;_WearAmount;Wear Amount;3;0;0.5;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-907.0159,-116.9194;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SamplerNode;4;-1338.788,-395.2105;Float;True;Property;_WornStone;Worn Stone;2;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-913.7781,167.9798;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.ColorNode;9;-720.6436,-452.2651;Float;False;Property;_MossColor;Moss Color;4;0;0.2662168,0.3161765,0.1255407,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.LerpOp;5;-596.1779,216.2368;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.LerpOp;10;-283.4111,-217.3853;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SamplerNode;8;-501.236,102.2057;Float;True;Property;_MettalicSmoothnessA;Mettalic (Smoothness A);1;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;55.63707,3.709138;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Temple/Railing;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;2;0
WireConnection;3;1;1;1
WireConnection;7;0;1;3
WireConnection;7;1;6;0
WireConnection;5;0;3;0
WireConnection;5;1;4;0
WireConnection;5;2;7;0
WireConnection;10;0;5;0
WireConnection;10;1;9;0
WireConnection;10;2;1;2
WireConnection;0;0;10;0
WireConnection;0;3;8;1
WireConnection;0;4;8;4
ASEEND*/
//CHKSM=2A34451D8F5DBEF4103DEAA0382C0D1AE4083E71