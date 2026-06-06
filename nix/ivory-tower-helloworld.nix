self: super:
let
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "ivory-tower-helloworld";
    rev = "b2d86f2a6ae01a1ecaab27f14301a316bdb48672";
    sha256 = "161fypvbb7kyx9bbqdfxx1aa99w54454587v4zip36xdg01d5ddn";
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
