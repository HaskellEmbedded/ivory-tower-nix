self: super:
let
  # update with
  # nix-prefetch-git https://github.com/HaskellEmbedded/data-stm32 <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "HaskellEmbedded";
    repo = "data-stm32";
    rev = "fb62bb8908fb97b9450ccd98b802b2e4274c6dc3";
    sha256 = "0m2c8i7s8gawcp7524zfn0lwbyzwwklpci10f9kr6rn4czgyiprs";
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
