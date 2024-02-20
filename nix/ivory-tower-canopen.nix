self: super:
let

  # update with
  # nix-prefetch-git https://github.com/DistRap/ivory-tower-canopen <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "ivory-tower-canopen";
    rev = "228610b94350a7489760ce4452be84608e7cb75a";
    sha256 = "0vibf07lybk9sbgg92rhqrkn4bzy7v9kpa2av4dqfc115y1mvhgy";
  };

  # swap with src to build from this path
  srcX = ../../ivory-tower-canopen;
in
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        ivory-tower-canopen = super.haskell.lib.dontHaddock ( hself.callCabal2nix "ivory-tower-canopen" "${src}" {} );
        ivory-tower-canopen-core = super.haskell.lib.dontHaddock ( hself.callCabal2nix "ivory-tower-canopen-core" "${src}/ivory-tower-canopen-core" {} );
        ivory-tower-canopen-src = src;
        ivory-tower-canopen-schema = hself.mkSchema
          "canopen" "${src}/schema" hself.cidl;
        canopen-schema-tower = hself.callCabal2nix "canopen-schema-tower" "${hself.ivory-tower-canopen-schema}/canopen-schema-tower" {};
        canopen-schema-native = hself.callCabal2nix "canopen-schema-native" "${hself.ivory-tower-canopen-schema}/canopen-schema-native" {};
      });
  });
}
