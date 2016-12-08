//贴图渐变查看

Shader "Unlit/TextureGradPreview"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_CutValue("CutValue",range(0,1)) = 0

		_Layer("Layer(RGBA 1234)",int) = 1

	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
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
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float _CutValue;
			int _Layer;

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = tex2D(_MainTex, i.uv);
				float value = -1;
				if(_Layer == 1)
				{
					value = col.r;
				}
				if (_Layer == 2)
				{
					value = col.g;
				}
				if (_Layer == 3)
				{
					value = col.b;
				}
				if (_Layer == 4)
				{
					value = col.a;
				}

				if (value == -1)
				{
					return col;
				}

				if (value < _CutValue)
				{
					return 0;
				}

				return 1;
			}
			ENDCG
		}
	}
}
