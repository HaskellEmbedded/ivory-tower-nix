self: super:
let

  # update with
  # nix-prefetch-git https://github.com/HaskellEmbedded/ivory-tower-stm32-generated <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "HaskellEmbedded";
    repo = "ivory-tower-stm32-generated";
    rev = "4d6d9977977a54a4b53911506a60e63b41eccd30";
    sha256 = "0jhpz62rn0f4kiz6lchidgpzl1sb61mhh1b9br0zgd1zsjdq1mzb";
  };

  # swap with src to build from this path
  srcX = ../../ivory-tower-stm32-generated;
in
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        ivory-bsp-stm32 = super.haskell.lib.dontHaddock ( hself.callCabal2nix "ivory-bsp-stm32" "${src}" {});
      });
  });
}
