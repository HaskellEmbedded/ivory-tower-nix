self: super:
let
  src = super.fetchFromGitHub {
    owner = "distrap";
    repo = "ivory-tower-helloworld";
    rev = "b3dbe91aa12c1dbe0b0e867782a359607226c7d9";
    sha256 = "0a2i02m6l6pq84r6ymnp8yk5igd8hrflfpkgq6gqg0r2z5lz4f0w";
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
