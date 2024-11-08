{ inputs, system, ... }:
{
  environment.systemPackages = [ inputs.nixvim.packages.${pkgs.system}.default ];
}
