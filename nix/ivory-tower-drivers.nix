self: super:
let

  # update with
  # nix-prefetch-git https://github.com/distrap/ivory-tower-drivers <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "distrap";
    repo = "ivory-tower-drivers";
    rev = "22b0771c419d4876eab15320f0e523054a82f01f";
    sha256 = "06qdbc5k1wpnd7hkhsy4pf8jkm1qgw2np30py9lwa1cia5mr9h5z";
  };

  # swap with src to build from this path
  srcX = ../../ivory-tower-drivers;
in
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        ivory-tower-drivers = super.haskell.lib.dontHaddock ( hself.callCabal2nix "ivory-tower-drivers" "${src}" {} );
      });
  });
}
