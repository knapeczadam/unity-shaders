#ifndef ADDITIONALLIGHT
#define ADDITIONALLIGHT

float3 DiffuseLambert(float3 normalVal, float3 lightDir, float3 lightColor, float diffuseFactor, float attenuation)
{
    return lightColor * diffuseFactor * attenuation * saturate(dot(normalVal, lightDir));
}
            
float SpecularBlinnPhong(float3 normalDir, float3 lightDir, float3 worldSpaceViewDir, float3 specularColor, float specularFactor, float attenuation, float specularPower)
{
    float3 halfwayDir = normalize(lightDir + worldSpaceViewDir);
    return specularColor * specularFactor * attenuation * pow(saturate(dot(normalDir, halfwayDir)), specularPower);
}

#endif