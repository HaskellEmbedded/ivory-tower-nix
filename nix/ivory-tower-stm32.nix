self: super:
let

  # update with
  # nix-prefetch-git https://github.com/sorki/ivory-tower-stm32 <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "sorki";
    repo = "ivory-tower-stm32";
    rev = "02a1ab4b405c1015f66a7f2ce84649dbce1e58e5";
    sha256 = "1lccf0979frbf1jfqc2cisimnlrjv9pl468krg2q4z63yc4f32n7";
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
