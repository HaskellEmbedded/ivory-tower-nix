self: super:
let
  # update with
  # nix-prefetch-git https://github.com/HaskellEmbedded/data-stm32 <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "HaskellEmbedded";
    repo = "data-stm32";
    rev = "84b69ba5b1028bbed7790f4ce7affa6da9f66bfb";
    sha256 = "0xj1nja27j07wkzzj1zcs9rram42kplklns1xggw61bwvidp2zdn";
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
