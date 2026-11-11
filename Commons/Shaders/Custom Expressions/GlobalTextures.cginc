#ifndef GLOBAL_TEXTURES_INCLUDED
#define GLOBAL_TEXTURES_INCLUDED

// Albedo (sampler = clamp), Metallic (repeat), Roughness/Normal (clamp), Emission (clamp)
UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(_UdonDiffuseArray);
SamplerState sampler_UdonDiffuseArray { Filter=MIN_MAG_MIP_POINT; AddressU=Clamp; AddressV=Clamp; AddressW=Clamp; };

UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(_UdonMetallicArray);
SamplerState sampler_UdonMetallicArray { Filter=MIN_MAG_MIP_POINT; AddressU=Repeat;  AddressV=Repeat;  AddressW=Repeat; };

UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(_UdonRoughnessArray);
SamplerState sampler_UdonRoughnessArray { Filter=MIN_MAG_MIP_POINT; AddressU=Clamp; AddressV=Clamp; AddressW=Clamp; };

UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(_UdonNormalArray);
SamplerState sampler_UdonNormalArray { Filter=MIN_MAG_MIP_POINT; AddressU=Clamp; AddressV=Clamp; AddressW=Clamp; };

UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(_UdonEmissionArray);
SamplerState sampler_UdonEmissionArray { Filter=MIN_MAG_MIP_POINT; AddressU=Clamp; AddressV=Clamp; AddressW=Clamp; };

#endif // GLOBAL_TEXTURES_INCLUDED
