self: super:
let

  # update with
  # nix-prefetch-git https://github.com/DistRap/ivory-tower-stm32 <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "ivory-tower-stm32";
    rev = "47bb4703af41e51a98b964ea0553612800dd0e22";
    sha256 = "1n2y6aqlkcz6rc8gs0cb6d9xvbrjyzkd108lgisr3b4p6ic738j6";
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
