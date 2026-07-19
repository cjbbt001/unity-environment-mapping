Shader "cjbbt/Cubemap_1"
{
    Properties
    {
        _CubeMap("Cube Map",Cube) = "white"{}

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
           

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
               
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 pos : SV_POSITION;
                float3 normal_world : TEXCOORD1;
				float3 pos_world : TEXCOORD2;
            };

            samplerCUBE _CubeMap;
            float4 _CubeMap_HDR;

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                o.pos_world = mul(unity_ObjectToWorld, v.vertex).xyz;
                o.normal_world = normalize(mul(float4(v.normal,0),unity_ObjectToWorld).xyz);
              
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                half3 normal_dir = normalize(i.normal_world);
                half3 view_dir = normalize(_WorldSpaceCameraPos - i.pos_world);
                half3 reflect_dir = reflect(-view_dir, normal_dir);

                half4 color_cubemap = texCUBE(_CubeMap,reflect_dir);
                half3 env_color = DecodeHDR(color_cubemap, _CubeMap_HDR);

                half3 final_color = env_color;

                return float4(final_color,1);
            }
            ENDCG
        }
    }
}
