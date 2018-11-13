// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Temple/Stone_VTXBlend"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_Albedo("Albedo", 2D) = "white" {}
		_Tint("Tint", Color) = (0.8088235,0.8088235,0.8088235,0)
		_Metallic("Metallic", 2D) = "black" {}
		_Smoothness("Smoothness", Range( 0 , 1)) = 0
		_SeamColor("Seam Color", Color) = (0,0,0,0)
		_WornStone("Worn Stone", 2D) = "white" {}
		_EdgePower("Edge Power", Range( 0 , 10)) = 2
		_SeamAmount("Seam Amount", Range( 0 , 10)) = 5
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

		uniform float4 _Tint;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform sampler2D _WornStone;
		uniform float4 _WornStone_ST;
		uniform float _EdgePower;
		uniform float4 _SeamColor;
		uniform float _SeamAmount;
		uniform sampler2D _Metallic;
		uniform float4 _Metallic_ST;
		uniform float _Smoothness;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			float2 uv_WornStone = i.uv_texcoord * _WornStone_ST.xy + _WornStone_ST.zw;
			float clampResult18 = clamp( pow( i.vertexColor.g , _EdgePower ) , 0.0 , 1.0 );
			float4 lerpResult14 = lerp( ( _Tint * tex2D( _Albedo, uv_Albedo ) ) , tex2D( _WornStone, uv_WornStone ) , clampResult18);
			float clampResult24 = clamp( ( 1.0 - pow( ( 1.0 - i.vertexColor.r ) , _SeamAmount ) ) , 0.0 , 1.0 );
			float4 lerpResult12 = lerp( lerpResult14 , _SeamColor , clampResult24);
			o.Albedo = lerpResult12.rgb;
			float2 uv_Metallic = i.uv_texcoord * _Metallic_ST.xy + _Metallic_ST.zw;
			float4 tex2DNode2 = tex2D( _Metallic, uv_Metallic );
			o.Metallic = tex2DNode2.r;
			o.Smoothness = ( tex2DNode2.a * _Smoothness );
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13201
7;276;1725;797;1077.844;1283.526;1;True;True
Node;AmplifyShaderEditor.VertexColorNode;4;-2023.973,-1120.405;Float;False;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.OneMinusNode;21;-1615.951,-1124.419;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;20;-1657.47,-1273.886;Float;False;Property;_SeamAmount;Seam Amount;7;0;5;0;10;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;16;-2072.832,-787.1864;Float;False;Property;_EdgePower;Edge Power;6;0;2;0;10;0;1;FLOAT
Node;AmplifyShaderEditor.PowerNode;15;-1585.832,-909.1864;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;1;-745.9542,-364.4943;Float;True;Property;_Albedo;Albedo;0;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.PowerNode;22;-1367.876,-1160.748;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.ColorNode;7;-721.0176,-572.5981;Float;False;Property;_Tint;Tint;1;0;0.8088235,0.8088235,0.8088235,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.OneMinusNode;23;-1167.549,-1075.635;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.ClampOpNode;18;-1253.208,-888.0879;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-329.4319,-449.1023;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SamplerNode;13;-399.9406,-1247.813;Float;True;Property;_WornStone;Worn Stone;5;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ColorNode;11;157.1908,-1254.352;Float;False;Property;_SeamColor;Seam Color;4;0;0,0,0,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.LerpOp;14;25.56251,-966.5549;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;9;-304.0596,569.8209;Float;False;Property;_Smoothness;Smoothness;3;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.ClampOpNode;24;-917.3899,-1047.46;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;2;-455.0999,238.6707;Float;True;Property;_Metallic;Metallic;2;0;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;1.940336,443.8209;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;12;420.6125,-966.3422;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;897.1569,128.4223;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Temple/Stone_VTXBlend;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;21;0;4;1
WireConnection;15;0;4;2
WireConnection;15;1;16;0
WireConnection;22;0;21;0
WireConnection;22;1;20;0
WireConnection;23;0;22;0
WireConnection;18;0;15;0
WireConnection;8;0;7;0
WireConnection;8;1;1;0
WireConnection;14;0;8;0
WireConnection;14;1;13;0
WireConnection;14;2;18;0
WireConnection;24;0;23;0
WireConnection;10;0;2;4
WireConnection;10;1;9;0
WireConnection;12;0;14;0
WireConnection;12;1;11;0
WireConnection;12;2;24;0
WireConnection;0;0;12;0
WireConnection;0;3;2;1
WireConnection;0;4;10;0
ASEEND*/
//CHKSM=3EEB0034B25BAD1E5B058761CBE1E3858E31004E