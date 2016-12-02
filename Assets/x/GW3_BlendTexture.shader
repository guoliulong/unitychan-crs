Shader "GW3/BlendTexture"
{
	Properties
	{
		_MainTex ("Main Textrue", 2D) = "white" {}
		_BlendTex ("Blend Textrue", 2D) = "white" {}
		_RTex ("R Textrue", 2D) = "white" {}
		_GTex ("G Textrue", 2D) = "white" {}
		_BTex ("B Textrue", 2D) = "white" {}
		_ATex ("A Textrue", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			Tags{"LightMode" = "ForwardBase"}

			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float2 uvR : TEXCOORD1;
				float2 uvG : TEXCOORD2;
				float2 uvB : TEXCOORD3;
				float2 uvA : TEXCOORD4;
				float2 uvBlend : TEXCOORD5;
				UNITY_FOG_COORDS(6)
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			sampler2D _BlendTex;
			sampler2D _RTex;
			sampler2D _GTex;
			sampler2D _BTex;
			sampler2D _ATex;
			float4 _MainTex_ST;
			float4 _BlendTex_ST;
			float4 _RTex_ST;
			float4 _GTex_ST;
			float4 _BTex_ST;
			float4 _ATex_ST;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.uvR = TRANSFORM_TEX(v.uv, _RTex);
				o.uvG = TRANSFORM_TEX(v.uv, _GTex);
				o.uvB = TRANSFORM_TEX(v.uv, _BTex);
				o.uvA = TRANSFORM_TEX(v.uv, _ATex);
				o.uvBlend = TRANSFORM_TEX(v.uv, _BlendTex);

				UNITY_TRANSFER_FOG(o,o.vertex);

				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				half4 colMain = tex2D(_MainTex, i.uv);
				half4 colBlend = tex2D(_BlendTex, i.uvBlend);
				half4 colR = tex2D(_RTex, i.uvR);
				half4 colG = tex2D(_GTex, i.uvG);
				half4 colB = tex2D(_BTex, i.uvB);
				half4 colA = tex2D(_ATex, i.uvA);

				half4 finalColor = colMain;
				finalColor = lerp(finalColor,colR,colBlend.r);
				finalColor = lerp(finalColor,colG,colBlend.g);
				finalColor = lerp(finalColor,colB,colBlend.b);
				finalColor = lerp(finalColor,colA,colBlend.a);

				// apply fog
				UNITY_APPLY_FOG(i.fogCoord, finalColor);
				return colBlend; 
			}
			ENDCG
		}
	}
}
