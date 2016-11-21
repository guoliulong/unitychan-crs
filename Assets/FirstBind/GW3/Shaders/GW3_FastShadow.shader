// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Unlit/GW3_FastShadow"
{
	Properties
	{
		_ShadowColor("ShadowColor",Color) = (0,0,0,0)
		_GlobalLightDirection("GlobalLightDirection",Vector) = (0,-1,0,0)
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" "Queue" = "Geometry+1" }
		LOD 100

		Pass
		{

			Stencil
			{
				Ref 0
				Comp Equal
				Pass IncrSat
				ZFail Keep
			}

			Blend SrcAlpha OneMinusSrcAlpha

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
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
			};

			float4 _ShadowColor;
			float4 _GlobalLightDirection;


			float3 Vertex2Ground(float3 vpos)
			{
				float3 lightDir = _GlobalLightDirection.xyz;
				float cosSita = dot(lightDir,float3(0,-1,0));
				float sita = acos(cosSita);
				float shadowLength = vpos.y * sin(sita);
				lightDir.y = 0;
				vpos.y = 0;
				return normalize(lightDir) * shadowLength + vpos;
			}

			v2f vert (appdata v)
			{
				v2f o;
				float4 worldPos = mul(unity_ObjectToWorld, v.vertex);
				worldPos = float4(Vertex2Ground( worldPos.xyz),1);
				o.vertex = mul(UNITY_MATRIX_VP,worldPos);
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = _ShadowColor;
				// apply fog
				UNITY_APPLY_FOG(i.fogCoord, col);
				return _ShadowColor;
			}
			ENDCG
		}
	}
}
