self: super:
let
  # update with
  # nix-prefetch-git https://github.com/HaskellEmbedded/data-stm32 <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "HaskellEmbedded";
    repo = "data-stm32";
    rev = "f65e824e9fd53f845af574b37655afbf4323e1fa";
    sha256 = "15d2vcg6ld46p7i1cb3zb2hkf2mv8a2zvq68pnl5frlzdzgiz7ss";
  };

  # swap with src to build from this path
  srcX = ../../data-stm32;
in
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        data-stm32 =
          super.haskell.lib.dontCheck (
            super.haskell.lib.dontHaddock
              ( hself.callCabal2nix "data-stm32" "${src}" {} )
            );
      });
    });
}
