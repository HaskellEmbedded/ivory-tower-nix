self: super:
let
  src = super.fetchFromGitHub {
    owner = "distrap";
    repo = "ivory-tower-helloworld";
    rev = "50d67ae8d44f547cf995ded503af27e82cf15232";
    sha256 = "14srd3q6mq4xgwbmdihdfhlry83paa69dy9wpvbv4x2qml7rxbyk";
  };

  srcX = ../../ivory-tower-helloworld;
in
{
  myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        ivory-tower-helloworld = super.haskell.lib.dontHaddock ( hself.callCabal2nix "ivory-tower-helloworld" "${src}" {} );
      });
    });
}
