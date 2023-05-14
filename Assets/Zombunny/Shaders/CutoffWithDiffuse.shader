Shader "Custom/CutoffWithDiffuse" {
    Properties {
      _RimColor ("Rim Color", Color) = (0,0.5,0.5,0.0)
      _RimPower ("Rim Power", Range(0.5,8.0)) = 3.0
      _myTex("Diffuse", 2D) = "white" {}
      _mySlider("Width", Range(1, 20)) = 10

    }
    SubShader {
      CGPROGRAM
      #pragma surface surf Lambert
      struct Input {
          float3 viewDir;
          float3 worldPos;
          float2 uv_myTex;
      };

        sampler2D _myTex;
      float4 _RimColor;
      float _RimPower;
      float _mySlider;

      void surf (Input IN, inout SurfaceOutput o) {
        o.Albedo = tex2D(_myTex, IN.uv_myTex).rgb;
        half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
        o.Emission = frac(IN.worldPos.y*_mySlider * 0.5) > 0.4 ? 
                          float3(0,1,0)*rim: float3(1,0,0)*rim*_RimPower;
                          
      }
      ENDCG
    } 
    Fallback "Diffuse"
  }