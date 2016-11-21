Shader "UnityChan/Skin2"
{
	Properties
	{
		_Color ("Main Color", Color) = (1, 1, 1, 1)
		_ShadowColor ("Shadow Color", Color) = (0.8, 0.8, 1, 1)
		_EdgeThickness ("Outline Thickness", Float) = 1
				
		_MainTex ("Diffuse", 2D) = "white" {}
		_FalloffSampler ("Falloff Control", 2D) = "white" {}
		_RimLightSampler ("RimLight Control", 2D) = "white" {}
		_HighLightSampler ("HightLight Control", 2D) = "white" {} 

		_tmp1 ("_tmp1", Range(0,1)) = 0
		_tmp2 ("_tmp2", Range(0,1)) = 0
		_tmp3 ("_tmp3", Range(0.01,1)) = 0

	}

CGINCLUDE
#include "UnityCG.cginc"
#include "AutoLight.cginc"
ENDCG

	SubShader
	{
		Tags
		{
			"RenderType"="Opaque"
			"Queue"="Geometry"
			"LightMode"="ForwardBase"
		}

        LOD 450

		Pass
		{
			Cull Back
			ZTest LEqual
			CGPROGRAM
			#pragma multi_compile_fwdbase
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			//#define ENABLE_CAST_SHADOWS
			#define ENABLE_HIGHLIGHT_MUTI
			//#define ENABLE_RIMLIGHT
			#include "CharaSkin2.cg"
			ENDCG
		}

		Pass
		{
			Cull Front
			ZTest Less
			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#include "CharaOutline.cg"
			ENDCG
		}

	}

//	SubShader
//	{
//		Tags
//		{
//			"RenderType"="Opaque"
//			"Queue"="Geometry"
//			"LightMode"="ForwardBase"
//		}
//
//        LOD 250
//
//		Pass
//		{
//			Cull Back
//			ZTest LEqual
//CGPROGRAM
//#pragma multi_compile_fwdbase
//#pragma target 3.0
//#pragma vertex vert
//#pragma fragment frag
//#define ENABLE_CAST_SHADOWS
////#define ENABLE_RIMLIGHT
//#include "CharaSkin.cg"
//ENDCG
//		}
//
//	}

//	SubShader
//	{
//		Tags
//		{
//			"RenderType"="Opaque"
//			"Queue"="Geometry"
//		}
//
//        LOD 200
//
//		Pass
//		{
//			Cull Back
//			ZTest LEqual
//CGPROGRAM
//#pragma vertex vert
//#pragma fragment frag
//#include "Unlit.cg"
//ENDCG
//		}
//
//	}
//
	FallBack "Diffuse"
}

