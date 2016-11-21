#ifndef MMDLIT_UNITY_STANDARD_CORE_INCLUDED
#define MMDLIT_UNITY_STANDARD_CORE_INCLUDED

#include "MMD4Mecanim-Standard-MMDLit-Config.cginc"
#include "MMD4Mecanim-Standard-MMDLit-BRDF.cginc"

#include "UnityStandardCore.cginc"

//-------------------------------------------------------------------------------------------------------------------------------------------------------------

VertexOutputForwardBase MMDLit_vertForwardBase (VertexInput v)
{
	return vertForwardBase(v); // Similer to default.
}

half4 MMDLit_fragForwardBaseInternal (VertexOutputForwardBase i)
{
	FRAGMENT_SETUP(s) // clip() into FragmentSetup()
#ifdef _ALPHABLEND_ON
	MMDLIT_CLIP(s.alpha)
#else
	MMDLIT_CLIP_FAST(s.alpha)
#endif

#if UNITY_OPTIMIZE_TEXCUBELOD
	s.reflUVW		= i.reflUVW;
#endif

#if UNITY_VERSION >= 550
	UnityLight mainLight = MainLight();
#else
	UnityLight mainLight = MainLight (s.normalWorld);
#endif
	half shadowAtten = SHADOW_ATTENUATION(i);

	half occlusion = Occlusion(i.tex.xy);
	UnityGI gi = FragmentGI (s, occlusion, i.ambientOrLightmapUV, shadowAtten, mainLight);

	half4 c = MMDLit_UNITY_BRDF_PBS(s.diffColor, s.specColor, s.oneMinusReflectivity,
#if UNITY_VERSION < 550
		s.oneMinusRoughness,
#else
		s.smoothness,
#endif
		s.normalWorld, -s.eyeVec,
#ifdef _TOON
		mainLight,
#else
		gi.light,
#endif
		gi.indirect, shadowAtten);
	c.rgb += UNITY_BRDF_GI (s.diffColor, s.specColor, s.oneMinusReflectivity,
#if UNITY_VERSION < 550
		s.oneMinusRoughness,
#else
		s.smoothness,
#endif
		s.normalWorld, -s.eyeVec, occlusion, gi);

	UNITY_APPLY_FOG(i.fogCoord, c.rgb);
	return OutputForward (c, s.alpha);
}

half4 MMDLit_fragForwardBase (VertexOutputForwardBase i) : SV_Target
{
	return MMDLit_fragForwardBaseInternal(i);
}

//----------------------------------------------------------------------------------------------------------------------------------------------------

VertexOutputForwardAdd MMDLit_vertForwardAdd (VertexInput v)
{
	return vertForwardAdd(v); // Similer to default.
}

half4 MMDLit_fragForwardAddInternal (VertexOutputForwardAdd i)
{
	FRAGMENT_SETUP_FWDADD(s) // clip() into FragmentSetup()
#ifdef _ALPHABLEND_ON
	MMDLIT_CLIP(s.alpha)
#else
	MMDLIT_CLIP_FAST(s.alpha)
#endif

	UnityLight light = AdditiveLight (
#if UNITY_VERSION < 550
		s.normalWorld,
#endif
		IN_LIGHTDIR_FWDADD(i), LIGHT_ATTENUATION(i));

	UnityIndirect noIndirect = ZeroIndirect ();

	half4 c = MMDLit_UNITY_BRDF_PBS(s.diffColor, s.specColor, s.oneMinusReflectivity,
#if UNITY_VERSION < 550
		s.oneMinusRoughness,
#else
		s.smoothness,
#endif
		s.normalWorld, -s.eyeVec, light, noIndirect, 0.0);

	UNITY_APPLY_FOG_COLOR(i.fogCoord, c.rgb, half4(0,0,0,0)); // fog towards black in additive pass
	return OutputForward (c, s.alpha);
}

half4 MMDLit_fragForwardAdd (VertexOutputForwardAdd i) : SV_Target		// backward compatibility (this used to be the fragment entry function)
{
	return MMDLit_fragForwardAddInternal(i);
}

//----------------------------------------------------------------------------------------------------------------------------------------------------

#ifdef TESSELLATION_ON
#ifdef UNITY_CAN_COMPILE_TESSELLATION

// tessellation vertex shader
struct InternalTessInterp_VertexInput
{
	float4 vertex	: INTERNALTESSPOS;
	half3 normal	: NORMAL;
	float2 uv0		: TEXCOORD0;
	float2 uv1		: TEXCOORD1;
#if defined(DYNAMICLIGHTMAP_ON) || defined(UNITY_PASS_META)
	float2 uv2		: TEXCOORD2;
#endif
#ifdef _TANGENT_TO_WORLD
	half4 tangent	: TANGENT;
#endif
};

InternalTessInterp_VertexInput tess_vertVertexInput(VertexInput v)
{
	InternalTessInterp_VertexInput o;
	o.vertex = v.vertex;
	o.normal = v.normal;
	o.uv0 = v.uv0;
	o.uv1 = v.uv1;
#if defined(DYNAMICLIGHTMAP_ON) || defined(UNITY_PASS_META)
	o.uv2 = v.uv2;
#endif
#ifdef _TANGENT_TO_WORLD
	o.tangent = v.tangent;
#endif
	return o;
}

// tessellation hull constant shader
UnityTessellationFactors hsconst_surf(InputPatch<InternalTessInterp_VertexInput, 3> v)
{
	float4 tf = UnityEdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, _TessEdgeLength);
	UnityTessellationFactors o;
	o.edge[0] = tf.x;
	o.edge[1] = tf.y;
	o.edge[2] = tf.z;
	o.inside = tf.w;
	return o;
}

// tessellation hull shader
[UNITY_domain("tri")]
[UNITY_partitioning("fractional_odd")]
[UNITY_outputtopology("triangle_cw")]
[UNITY_patchconstantfunc("hsconst_surf")]
[UNITY_outputcontrolpoints(3)]
InternalTessInterp_VertexInput hsVertexInput(InputPatch<InternalTessInterp_VertexInput, 3> v, uint id : SV_OutputControlPointID)
{
	return v[id];
}

inline VertexInput _dsInternal(UnityTessellationFactors tessFactors, const OutputPatch<InternalTessInterp_VertexInput, 3> vi, float3 bary : SV_DomainLocation)
{
	VertexInput v;
	v.vertex = vi[0].vertex*bary.x + vi[1].vertex*bary.y + vi[2].vertex*bary.z;
	float3 pp[3];
	for (int i = 0; i < 3; ++i)
		pp[i] = v.vertex.xyz - vi[i].normal * (dot(v.vertex.xyz, vi[i].normal) - dot(vi[i].vertex.xyz, vi[i].normal));
	v.vertex.xyz = _TessPhongStrength * (pp[0] * bary.x + pp[1] * bary.y + pp[2] * bary.z) + (1.0f - _TessPhongStrength) * v.vertex.xyz;
	v.normal = vi[0].normal*bary.x + vi[1].normal*bary.y + vi[2].normal*bary.z;
	v.vertex.xyz += v.normal.xyz * _TessExtrusionAmount;
	v.uv0 = vi[0].uv0*bary.x + vi[1].uv0*bary.y + vi[2].uv0*bary.z;
	v.uv1 = vi[0].uv1*bary.x + vi[1].uv1*bary.y + vi[2].uv1*bary.z;
#if defined(DYNAMICLIGHTMAP_ON) || defined(UNITY_PASS_META)
	v.uv2 = vi[0].uv2*bary.x + vi[1].uv2*bary.y + vi[2].uv2*bary.z;
#endif
#ifdef _TANGENT_TO_WORLD
	v.tangent = vi[0].tangent*bary.x + vi[1].tangent*bary.y + vi[2].tangent*bary.z;
#endif
	return v;
}

// tessellation domain shader
[UNITY_domain("tri")]
VertexOutputForwardBase dsBase(UnityTessellationFactors tessFactors, const OutputPatch<InternalTessInterp_VertexInput, 3> vi, float3 bary : SV_DomainLocation)
{
	VertexInput v = _dsInternal(tessFactors, vi, bary);
	VertexOutputForwardBase o = MMDLit_vertForwardBase(v);
	return o;
}

// tessellation domain shader
[UNITY_domain("tri")]
VertexOutputForwardAdd dsAdd(UnityTessellationFactors tessFactors, const OutputPatch<InternalTessInterp_VertexInput, 3> vi, float3 bary : SV_DomainLocation)
{
	VertexInput v = _dsInternal(tessFactors, vi, bary);
	VertexOutputForwardAdd o = MMDLit_vertForwardAdd(v);
	return o;
}

#endif // UNITY_CAN_COMPILE_TESSELLATION
#endif // TESSELLATION_ON

#endif // MMDLIT_UNITY_STANDARD_CORE_INCLUDED
