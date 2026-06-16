self: super:
let

  # update with
  # nix-prefetch-git https://github.com/HaskellEmbedded/ivory-tower-stm32-generated <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "HaskellEmbedded";
    repo = "ivory-tower-stm32-generated";
    rev = "9e60aacaeb8eebb6b3fa5dc87485beaf38b29c36";
    sha256 = "1n9dkkpmw82f2qdh3y1z68ys4ishp0kf4gpjrihjw0v8gdssdwfc";
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
