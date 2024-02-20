self: super:
let

  # update with
  # nix-prefetch-git https://github.com/DistRap/ivory-tower-stm32 <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "ivory-tower-stm32";
    rev = "eb348f3a9eb01bd98d4c4f53d091aef2ed967cdb";
    sha256 = "1rba46bmw1ph7d0b32alm2k2h4mlxsnykgs2lxprivca6hyp2n1b";
  };

  # swap with src to build from this path
  srcX = ../../ivory-tower-stm32;

  subs = [
    # "ivory-bsp-stm32"
    # "ivory-bsp-tests" # XXX: port this please
    "ivory-freertos-bindings"
    # "tower-echronos-stm32"
    "tower-freertos-stm32"
    # "tower-freertos-stm32-tests"
  ];
in
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: super.lib.genAttrs subs (sub: hself.callCabal2nix sub "${src}/${sub}" {}));
    });
}
