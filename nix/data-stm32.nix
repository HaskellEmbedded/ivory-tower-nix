self: super:
let
  # update with
  # nix-prefetch-git https://github.com/HaskellEmbedded/data-stm32 <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "HaskellEmbedded";
    repo = "data-stm32";
    rev = "2cc9c217133b0472635d20bbfc0c54746a745e0f";
    sha256 = "0glf390y7njl3vd36zz7nnx0k5d9awawdncd1xh5r4lgdcvm1gvd";
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
