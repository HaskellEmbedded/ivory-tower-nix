self: super:
let
  # update with
  # nix-prefetch-git https://github.com/HaskellEmbedded/data-stm32 <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "HaskellEmbedded";
    repo = "data-stm32";
    rev = "ef2b29b7a2fa5bad2a8d79fed9692211216803ad";
    sha256 = "10sb5ayd58i2w3s81mzha54l3mql5bpcbh8asgazg08d94dnhx93";
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
