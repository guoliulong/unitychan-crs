// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Shader created with Shader Forge v1.28 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.28;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:0,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:True,hqlp:False,rprd:False,enco:False,rmgx:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False;n:type:ShaderForge.SFN_Final,id:4013,x:33522,y:32874,varname:node_4013,prsc:2|diff-3447-OUT;n:type:ShaderForge.SFN_Tex2d,id:1291,x:32475,y:32742,ptovrint:False,ptlb:_BlendTex,ptin:__BlendTex,varname:node_1291,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-9896-UVOUT;n:type:ShaderForge.SFN_Tex2d,id:9051,x:32475,y:33086,ptovrint:False,ptlb:RTex,ptin:_RTex,varname:node_9051,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-9896-UVOUT;n:type:ShaderForge.SFN_Tex2d,id:6495,x:32477,y:33258,ptovrint:False,ptlb:GTex,ptin:_GTex,varname:node_6495,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-9896-UVOUT;n:type:ShaderForge.SFN_Tex2d,id:9088,x:32475,y:32915,ptovrint:False,ptlb:BTex,ptin:_BTex,varname:node_9088,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-9896-UVOUT;n:type:ShaderForge.SFN_Tex2d,id:7196,x:32477,y:33429,ptovrint:False,ptlb:ATex,ptin:_ATex,varname:node_7196,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-9896-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:9896,x:32141,y:32859,varname:node_9896,prsc:2,uv:0;n:type:ShaderForge.SFN_Tex2d,id:4781,x:32475,y:32574,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:node_4781,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-9896-UVOUT;n:type:ShaderForge.SFN_Lerp,id:6558,x:33195,y:32818,varname:node_6558,prsc:2|A-9865-OUT,B-8638-OUT,T-1291-R;n:type:ShaderForge.SFN_Lerp,id:7105,x:33210,y:33015,varname:node_7105,prsc:2|A-6558-OUT,B-8621-OUT,T-1291-G;n:type:ShaderForge.SFN_Lerp,id:7396,x:33210,y:33170,varname:node_7396,prsc:2|A-7105-OUT,B-3773-OUT,T-1291-B;n:type:ShaderForge.SFN_Lerp,id:3447,x:33210,y:33310,varname:node_3447,prsc:2|A-7396-OUT,B-8470-OUT,T-1291-A;n:type:ShaderForge.SFN_Color,id:2550,x:32654,y:33086,ptovrint:False,ptlb:MutiRColor,ptin:_MutiRColor,varname:node_2550,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Color,id:5263,x:32654,y:33276,ptovrint:False,ptlb:MutiGColor,ptin:_MutiGColor,varname:_node_2550_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Color,id:6942,x:32654,y:32915,ptovrint:False,ptlb:MutiBColor,ptin:_MutiBColor,varname:_node_2550_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Color,id:9143,x:32654,y:33457,ptovrint:False,ptlb:MutiAColor,ptin:_MutiAColor,varname:_node_2550_copy_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:8638,x:32893,y:33086,varname:node_8638,prsc:2|A-2550-RGB,B-9051-RGB;n:type:ShaderForge.SFN_Multiply,id:8621,x:32893,y:33264,varname:node_8621,prsc:2|A-5263-RGB,B-6495-RGB;n:type:ShaderForge.SFN_Multiply,id:8470,x:32884,y:33438,varname:node_8470,prsc:2|A-9143-RGB,B-7196-RGB;n:type:ShaderForge.SFN_Multiply,id:3773,x:32893,y:32901,varname:node_3773,prsc:2|A-6942-RGB,B-9088-RGB;n:type:ShaderForge.SFN_Color,id:1532,x:32664,y:32649,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_1532,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:9865,x:32858,y:32606,varname:node_9865,prsc:2|A-4781-RGB,B-1532-RGB;proporder:1532-4781-2550-9051-5263-6495-6942-9088-9143-7196-1291;pass:END;sub:END;*/

Shader "GW3/BlendGround" {
    Properties {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("MainTex", 2D) = "white" {}
        _MutiRColor ("MutiRColor", Color) = (1,1,1,1)
        _RTex ("RTex", 2D) = "white" {}
        _MutiGColor ("MutiGColor", Color) = (1,1,1,1)
        _GTex ("GTex", 2D) = "white" {}
        _MutiBColor ("MutiBColor", Color) = (1,1,1,1)
        _BTex ("BTex", 2D) = "white" {}
        _MutiAColor ("MutiAColor", Color) = (1,1,1,1)
        _ATex ("ATex", 2D) = "white" {}
        __BlendTex ("_BlendTex", 2D) = "white" {}
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform sampler2D __BlendTex; uniform float4 __BlendTex_ST;
            uniform sampler2D _RTex; uniform float4 _RTex_ST;
            uniform sampler2D _GTex; uniform float4 _GTex_ST;
            uniform sampler2D _BTex; uniform float4 _BTex_ST;
            uniform sampler2D _ATex; uniform float4 _ATex_ST;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float4 _MutiRColor;
            uniform float4 _MutiGColor;
            uniform float4 _MutiBColor;
            uniform float4 _MutiAColor;
            uniform float4 _Color;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float3 normalDir : TEXCOORD4;
                float3 tangentDir : TEXCOORD5;
                float3 bitangentDir : TEXCOORD6;
                LIGHTING_COORDS(7,8)
                UNITY_FOG_COORDS(9)
                #if defined(LIGHTMAP_ON) || defined(UNITY_SHOULD_SAMPLE_SH)
                    float4 ambientOrLightmapUV : TEXCOORD10;
                #endif
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                #ifdef LIGHTMAP_ON
                    o.ambientOrLightmapUV.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
                    o.ambientOrLightmapUV.zw = 0;
                #elif UNITY_SHOULD_SAMPLE_SH
                #endif
                #ifdef DYNAMICLIGHTMAP_ON
                    o.ambientOrLightmapUV.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
                #endif
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// GI Data:
                UnityLight light;
                #ifdef LIGHTMAP_OFF
                    light.color = lightColor;
                    light.dir = lightDirection;
                    light.ndotl = LambertTerm (normalDirection, light.dir);
                #else
                    light.color = half3(0.f, 0.f, 0.f);
                    light.ndotl = 0.0f;
                    light.dir = half3(0.f, 0.f, 0.f);
                #endif
                UnityGIInput d;
                d.light = light;
                d.worldPos = i.posWorld.xyz;
                d.worldViewDir = viewDirection;
                d.atten = attenuation;
                #if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
                    d.ambient = 0;
                    d.lightmapUV = i.ambientOrLightmapUV;
                #else
                    d.ambient = i.ambientOrLightmapUV;
                #endif
                Unity_GlossyEnvironmentData ugls_en_data;
                ugls_en_data.roughness = 1.0 - 0;
                ugls_en_data.reflUVW = viewReflectDirection;
                UnityGI gi = UnityGlobalIllumination(d, 1, normalDirection, ugls_en_data );
                lightDirection = gi.light.dir;
                lightColor = gi.light.color;
/////// Diffuse:
                float NdotL = max(0.0,dot( normalDirection, lightDirection ));
                float3 directDiffuse = max( 0.0, NdotL) * attenColor;
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += gi.indirect.diffuse;
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float4 _RTex_var = tex2D(_RTex,TRANSFORM_TEX(i.uv0, _RTex));
                float4 __BlendTex_var = tex2D(__BlendTex,TRANSFORM_TEX(i.uv0, __BlendTex));
                float4 _GTex_var = tex2D(_GTex,TRANSFORM_TEX(i.uv0, _GTex));
                float4 _BTex_var = tex2D(_BTex,TRANSFORM_TEX(i.uv0, _BTex));
                float4 _ATex_var = tex2D(_ATex,TRANSFORM_TEX(i.uv0, _ATex));
                float3 diffuseColor = lerp(lerp(lerp(lerp((_MainTex_var.rgb*_Color.rgb),(_MutiRColor.rgb*_RTex_var.rgb),__BlendTex_var.r),(_MutiGColor.rgb*_GTex_var.rgb),__BlendTex_var.g),(_MutiBColor.rgb*_BTex_var.rgb),__BlendTex_var.b),(_MutiAColor.rgb*_ATex_var.rgb),__BlendTex_var.a);
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "Meta"
            Tags {
                "LightMode"="Meta"
            }
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_META 1
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #include "UnityMetaPass.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform sampler2D __BlendTex; uniform float4 __BlendTex_ST;
            uniform sampler2D _RTex; uniform float4 _RTex_ST;
            uniform sampler2D _GTex; uniform float4 _GTex_ST;
            uniform sampler2D _BTex; uniform float4 _BTex_ST;
            uniform sampler2D _ATex; uniform float4 _ATex_ST;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float4 _MutiRColor;
            uniform float4 _MutiGColor;
            uniform float4 _MutiBColor;
            uniform float4 _MutiAColor;
            uniform float4 _Color;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST );
                return o;
            }
            float4 frag(VertexOutput i) : SV_Target {
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                UnityMetaInput o;
                UNITY_INITIALIZE_OUTPUT( UnityMetaInput, o );
                
                o.Emission = 0;
                
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float4 _RTex_var = tex2D(_RTex,TRANSFORM_TEX(i.uv0, _RTex));
                float4 __BlendTex_var = tex2D(__BlendTex,TRANSFORM_TEX(i.uv0, __BlendTex));
                float4 _GTex_var = tex2D(_GTex,TRANSFORM_TEX(i.uv0, _GTex));
                float4 _BTex_var = tex2D(_BTex,TRANSFORM_TEX(i.uv0, _BTex));
                float4 _ATex_var = tex2D(_ATex,TRANSFORM_TEX(i.uv0, _ATex));
                float3 diffColor = lerp(lerp(lerp(lerp((_MainTex_var.rgb*_Color.rgb),(_MutiRColor.rgb*_RTex_var.rgb),__BlendTex_var.r),(_MutiGColor.rgb*_GTex_var.rgb),__BlendTex_var.g),(_MutiBColor.rgb*_BTex_var.rgb),__BlendTex_var.b),(_MutiAColor.rgb*_ATex_var.rgb),__BlendTex_var.a);
                o.Albedo = diffColor;
                
                return UnityMetaFragment( o );
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
