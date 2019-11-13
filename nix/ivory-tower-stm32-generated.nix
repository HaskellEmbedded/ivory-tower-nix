self: super:
let

  # update with
  # nix-prefetch-git https://github.com/HaskellEmbedded/ivory-tower-stm32-generated <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "HaskellEmbedded";
    repo = "ivory-tower-stm32-generated";
    rev = "2468e4a2f72053772dd3412793a4e42919ce0f35";
    sha256 = "0i08lzcai665kpcrv1a1kk5h8nvdx3775accfqbfh6mk15358avl";
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
