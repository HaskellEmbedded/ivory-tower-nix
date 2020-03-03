self: super:
let
  # update with
  # nix-prefetch-git https://github.com/distrap/ivory-tower-base <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "distrap";
    repo = "ivory-tower-base";
    rev = "fe1412a0764c38864f9298f666c1a3654bbe6919";
    sha256 = "1fi92ygmgrv5n4xnggx150d4m0r5076sskz2jhm3j768nb9i2j68";
  };

  # swap with src to build from this path
  srcX = ../../ivory-tower-base;
in
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        ivory-tower-base = super.haskell.lib.dontHaddock ( hself.callCabal2nix "ivory-tower-base" "${src}" {} );
      });
    });
}
