self: super:
let
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "ivory-tower-helloworld";
    rev = "93663dea4f31845432918d345a2f1d727a2d6a5d";
    sha256 = "1annnvrilyg77qjlgxc6w2a81npjyqjhs6209vd9pq9rgqg4v2l2";
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
