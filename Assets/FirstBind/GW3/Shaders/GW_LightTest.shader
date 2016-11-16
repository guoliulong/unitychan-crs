// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Unlit/GW_LightTest"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_CutValue("CutValue",Range(-1,2)) = 0
		_SecondShadowCutValue("SecondShadowCutValue",Range(-1,2)) = 0
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			Tags{"LightMode" = "ForwardBase"}

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				float3 normal:NORMAL;
				float3 color:COLOR;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
				float lum : COLOR;
				float3 vColor:TEXCOORD2;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float _CutValue;
			float _SecondShadowCutValue;
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				UNITY_TRANSFER_FOG(o,o.vertex);

				float3 oLightDir = normalize( mul((float3x3)unity_WorldToObject,_WorldSpaceLightPos0));

				o.lum = dot(oLightDir, normalize(v.normal) );

				o.vColor = v.color.r;


				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = tex2D(_MainTex, i.uv);
				// apply fog
				UNITY_APPLY_FOG(i.fogCoord, col);

				if(i.vColor.r < _SecondShadowCutValue)
				{
					return fixed4(0,0,0.2,1);
				}


				if(_CutValue > i.lum)
				{
					return fixed4(0,0,0.5,1);
				}
				return i.lum;
			}
			ENDCG
		}
	}
}
