self: super:
let

  # update with
  # nix-prefetch-git https://github.com/sorki/ivory-tower-stm32 <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "sorki";
    repo = "ivory-tower-stm32";
    rev = "a22a14dd978f53e4b59f9520dc9711a6b687272f";
    sha256 = "0vcswzya6qm3myks34w1a3cjhy0inrr9rf5p2lax0hy1pnf6baic";
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
