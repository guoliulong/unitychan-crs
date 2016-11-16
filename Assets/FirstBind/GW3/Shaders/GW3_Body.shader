// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "GW3/Body"
{
	Properties
	{
		_BaseTex ("Base Texture", 2D) = "white" {}
		_MiscTex ("Misc Texture", 2D) = "white" {}

		_LightCutValue("LightCutValue",range(0,1)) = 0
		_UnLightMutiColor("UnLightMutiColor",color) = (0,0,0,0)
		_UnLightMutiValue("UnLightMutiValue",float) = 1
		_LightMutiValue("LightMutiValue",float) = 1
		_OutLineValue("OutLineValue",float) = 1
		_OutLineColorScaleValue("OutLineColorScaleValue",float) = 1
		_OutLineMutiColorValue("_OutLineMutiColorValue",color) = (0,0,0,0)

		_tmp("tmp",range(0,10)) = 0
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			Tags { "LightMode" = "ForwardBase" }

			Blend One Zero
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			#pragma multi_compile_fwdbase
			#pragma target 3.0
			
			#include "UnityCG.cginc"
			#include "AutoLight.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				//float ndotl:TEXCOORD2;
				//float ndotvl:TEXCOORD3;
				float3 vNormal:TEXCOORD2;
				float3 vEyeDir:TEXCOORD3;
				float3 vLightDir:TEXCOORD4;
			};

			sampler2D _BaseTex;
			float4 _BaseTex_ST;
			sampler2D _MiscTex;
			float _LightCutValue;
			float4 _UnLightMutiColor;
			float _LightMutiValue;
			float _UnLightMutiValue;
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _BaseTex);
				UNITY_TRANSFER_FOG(o,o.vertex);

				o.vNormal = normalize( mul( UNITY_MATRIX_IT_MV,v.normal).xyz);
				o.vEyeDir = normalize(-mul(UNITY_MATRIX_MV,v.vertex).xyz);
				o.vLightDir = normalize(mul((float3x3)UNITY_MATRIX_V,_WorldSpaceLightPos0.xyz));
				//o.ndotl = max(0, dot(vNormal,vLightDir));
				//o.ndotvl = dot(vNormal, normalize(vLightDir+vEyeDir ));

				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				float ndotl = max(0, dot(i.vNormal,i.vLightDir));
				float4 col = tex2D(_BaseTex, i.uv);
				float4 miscColor = tex2D(_MiscTex, i.uv);

				float3 diffuseColor;

				if( ndotl  < _LightCutValue)
				{
					diffuseColor = col.rgb * _UnLightMutiColor * _UnLightMutiValue;// * miscColor.g;
				}
				else
				{
					if( 1-ndotl > miscColor.g)
					{
						diffuseColor = col.rgb * _UnLightMutiColor*_UnLightMutiValue;
					}
					else
					{
						diffuseColor = col.rgb * _LightMutiValue;
					}
				}


				return float4(diffuseColor,1);
			}

			ENDCG
		}


		Pass
		{
			name "outline"

			Cull Front
			ZWrite Off
			Blend One Zero
			CGPROGRAM
			//outline
			// Outline thickness multiplier
			#define INV_EDGE_THICKNESS_DIVISOR 0.00285
			// Outline color parameters
			#define SATURATION_FACTOR 0.6
			#define BRIGHTNESS_FACTOR 0.8
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			sampler2D _BaseTex;
			float4 _BaseTex_ST;
			//sampler2D _MiscTex;
			float _OutLineValue;
			float4 _OutLineMutiColorValue;
			float _OutLineColorScaleValue;
			v2f vert (appdata v)
			{
				v2f o;
				o.uv = TRANSFORM_TEX(v.uv, _BaseTex);
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);  
            	float3 norm   = mul ((float3x3)UNITY_MATRIX_IT_MV, v.normal);  
           	 	float2 offset = TransformViewToProjection(norm.xy);  
            	o.vertex.xy += offset * o.vertex.z * _OutLineValue;  

				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				//fixed4 col = tex2D(_BaseTex, i.uv);
				//half4 miscTexColor = tex2D(_MiscTex, i.uv);

				//half4 standardColor = col * miscTexColor.g;

				half4 diffuseMapColor = tex2D(_BaseTex, i.uv);

				half maxChan = max( max( diffuseMapColor.r, diffuseMapColor.g ), diffuseMapColor.b );
				half4 newMapColor = diffuseMapColor;

				maxChan -= ( 1.0 / 255.0 );
				half3 lerpVals = saturate( ( newMapColor.rgb - half3( maxChan, maxChan, maxChan ) ) * 255.0 );
				newMapColor.rgb = lerp( SATURATION_FACTOR * newMapColor.rgb, newMapColor.rgb, lerpVals );

				return float4( BRIGHTNESS_FACTOR * newMapColor.rgb * diffuseMapColor.rgb, diffuseMapColor.a ) * _OutLineColorScaleValue * _OutLineMutiColorValue;
			}
			ENDCG
		}
	}

	FallBack "VertexLit"
}
