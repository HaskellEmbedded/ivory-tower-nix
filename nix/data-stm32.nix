self: super:
let
  # update with
  # nix-prefetch-git https://github.com/HaskellEmbedded/data-stm32 <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "HaskellEmbedded";
    repo = "data-stm32";
    rev = "2d90abc563a66b32e7a0f5cc5d28a0c2fcce1619";
    sha256 = "0dnm93l6771pa9rmdgws0zvvrin8rr08avrzlwf9m3xd38dl4qqr";
  };

  # swap with src to build from this path
  srcX = ../../data-stm32;
in
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        data-stm32 = super.haskell.lib.dontHaddock ( hself.callCabal2nix "data-stm32" "${src}" {} );
      });
    });
}
