// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "GW3/Hair"
{
	Properties
	{
		_BaseTex ("Base Texture", 2D) = "white" {}
		_MiscTex ("Misc Texture", 2D) = "white" {}
		//_CharLightDir("CharacterLightDirection",Vector) = (0,1,0,0)
		_HairBlackCutValue("HairBlackCutValue",range(0.001,1)) = 0
		_HairBackColor("HairBackColor",Color) = (0.5,0.5,0.5,1)
		_HairUnLightColor("HairUnLightColor",Color) = (0.5,0.5,0.5,1)
		_HairLightColor("HairLightColor",Color) = (0.5,0.5,0.5,1)
		_HairLightMutiValue("HairLightMutiValue",range(0,10)) = 1
		_HairLightCutValue("HairLightCutValue",range(-1,1)) = 0

		_HairSpecCutValue("HairSpecCutValue",float) = 0
		_HairSpecColor("HairSpecColor",Color) = (0.5,0.5,0.5,1)
		_HairSmooth("HairSmooth",range(-100,100)) = 1

		_HairOutLineValue("HairOutLineValue",range(0,10)) = 0
		_HairOutLineMutiColorValue("HairOutLineMutiColorValue",Color) = (1,1,1,1)
		_HairOutLineColorScaleValue("HairOutLineColorScaleValue",Float) = 1

		_tmp("tmp",range(0,10)) = 0
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			Tags { "LightMode" = "ForwardBase" }

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
				//LIGHTING_COORDS(2,3)
				float ndotl:TEXCOORD4;
				float ndotvl:TEXCOORD5;
				float3 tmp:TEXCOORD6;
			};

			sampler2D _BaseTex;
			sampler2D _MiscTex;
			float4 _BaseTex_ST;
			//float3 _CharLightDir;

			float _HairSpecCutValue;

			float _HairBlackCutValue;
			float4 _HairBackColor;
			float4 _HairUnLightColor;
			float4 _HairLightColor;
			float4 _HairSpecColor;
			float _HairLightCutValue;
			float _HairLightMutiValue;
			float _HairSmooth;
			float _tmp;


			inline float rmap01(float a,float b,float v)
			{
				return (v-a)/(b-a);
			}

			inline float rmap01_ab(float min,float max,float v)
			{
				return v*(max-min) +min;
			}


			v2f vert (appdata v)
			{
				v2f o;
				//TRANSFER_VERTEX_TO_FRAGMENT(o)

				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _BaseTex);
				UNITY_TRANSFER_FOG(o,o.vertex);

				//custom v stand view
				float3 vNormal = normalize( mul( UNITY_MATRIX_IT_MV,v.normal).xyz);
				float3 vEyeDir = normalize(-mul(UNITY_MATRIX_MV,v.vertex).xyz);
				float3 vLightDir = normalize(mul((float3x3)UNITY_MATRIX_V,_WorldSpaceLightPos0.xyz));
				o.ndotl = max(0, dot(vNormal,vLightDir));
				o.ndotvl = dot(vNormal, normalize(vLightDir+vEyeDir ));
				o.tmp =  vNormal;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				float4 miscTexColor = tex2D(_MiscTex, i.uv);
				float4 col = tex2D(_BaseTex, i.uv);
				//hide unlight
				if(col.a  <= _HairBlackCutValue)
				{
					return float4(col.rgb * _HairBackColor.rgb ,1);
				}

				float3 diffuseColor = float3(1,1,1);

				//light and unlight

				//float specPower = 0;

				if(i.ndotl <= _HairLightCutValue)
				{
					diffuseColor = col.rgb * _HairUnLightColor;
					//specPower = 0.1;
				}
				else
				{
					//specPower = 0.1 + i.ndotl;
					if( 1-i.ndotl > miscTexColor.g)
					{
						diffuseColor = col.rgb * _HairUnLightColor;
					}
					else
					{
						diffuseColor = col.rgb * _HairLightColor * _HairLightMutiValue;
					}
				}

				//diffuseColor *= miscTexColor.g;

				//if( i.ndotvl * miscTexColor.b > _HairSpecCutValue )
				if( pow( max(i.ndotvl,0), _HairSmooth) > _HairSpecCutValue*(1-miscTexColor.b))
				{
					diffuseColor += _HairSpecColor * miscTexColor.r;
				}

				return float4(diffuseColor,1);//i.ndotl;//pow(i.ndotl,10);// miscTexColor.b;// 

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
			sampler2D _MiscTex;
			float _HairOutLineValue;
			float4 _HairOutLineMutiColorValue;
			float _HairOutLineColorScaleValue;
			v2f vert (appdata v)
			{
				v2f o;
				o.uv = TRANSFORM_TEX(v.uv, _BaseTex);
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);  
            	float3 norm   = mul ((float3x3)UNITY_MATRIX_IT_MV, v.normal);  
           	 	float2 offset = TransformViewToProjection(norm.xy);  
            	o.vertex.xy += offset * o.vertex.z * _HairOutLineValue;  

				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
//				fixed4 col = tex2D(_BaseTex, i.uv);
//				half4 miscTexColor = tex2D(_MiscTex, i.uv);
//
//				half4 standardColor = col * miscTexColor.g;
//
//				half4 diffuseMapColor = standardColor;
//
//				half maxChan = max( max( diffuseMapColor.r, diffuseMapColor.g ), diffuseMapColor.b );
//				half4 newMapColor = diffuseMapColor;
//
//				maxChan -= ( 1.0 / 255.0 );
//				half3 lerpVals = saturate( ( newMapColor.rgb - half3( maxChan, maxChan, maxChan ) ) * 255.0 );
//				newMapColor.rgb = lerp( SATURATION_FACTOR * newMapColor.rgb, newMapColor.rgb, lerpVals );
//
//				return float4( BRIGHTNESS_FACTOR * newMapColor.rgb * diffuseMapColor.rgb, diffuseMapColor.a ) * _HairOutLineColorScaleValue * _HairOutLineMutiColorValue;
				return _HairOutLineMutiColorValue;
			}
			ENDCG
		}
	}

	FallBack "VertexLit"
}
