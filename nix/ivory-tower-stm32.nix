self: super:
let

  # update with
  # nix-prefetch-git https://github.com/DistRap/ivory-tower-stm32 <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "ivory-tower-stm32";
    rev = "f7c920bc0f6fb57b648af0d5fead56be3364a361";
    sha256 = "1xxdpm7pdpkfd8k0ixgl909bw8s9d7bmp427djf46iwd3wayn7qz";
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
