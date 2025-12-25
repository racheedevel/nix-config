{ config, pkgs, ... }:

{
    # AMD GPU
    hardware.graphics = {
        enable = true;
        extraPackages = with pkgs; [
            rocmPackages.clr.icd
        ];
    };

    boot.initrd.kernelModules = [ "amdgpu" ];

    environment.variables = {
        AMD_VULKAN_ICD = "RADV";
    };
}
