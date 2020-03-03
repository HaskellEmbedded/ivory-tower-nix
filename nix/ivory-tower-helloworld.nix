self: super:
let
  src = super.fetchFromGitHub {
    owner = "distrap";
    repo = "ivory-tower-helloworld";
    rev = "865c8a23c501f055f4a01b7e477b27f3206c659b";
    sha256 = "09v63c23jgr8zvzm1jmz4bk32dkkmx7m332i90zshralbr6w8a6j";
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
