self: super:
let
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "ivory-tower-helloworld";
    rev = "b511eb27ef80493fed1c0f272a2c5a34226371e8";
    sha256 = "1nb91vhqxwp8lcg2l4398sg80hdi6b2paz2ld3wcx9j38x6snwx3";
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
