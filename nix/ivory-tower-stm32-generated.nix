self: super:
let

  # update with
  # nix-prefetch-git https://github.com/HaskellEmbedded/ivory-tower-stm32-generated <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "HaskellEmbedded";
    repo = "ivory-tower-stm32-generated";
    rev = "ff971cf19cb5c3529a04f8df3ebe72c3fea1c3ba";
    sha256 = "1pns672ajcq9bixfsd3902pgqvna0zkds6a8aigp7gyxiz3kf85h";
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
