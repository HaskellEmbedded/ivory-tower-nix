self: super:
let

  # update with
  # nix-prefetch-git https://github.com/DistRap/ivory-tower-canopen <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "ivory-tower-canopen";
    rev = "ee89175839f3537210741c5e7b2a81a403d4cf10";
    sha256 = "17sfmrxfp7r9xmbvdjglrb9fhvv655464283fmjl4ksi540n6121";
  };

  # swap with src to build from this path
  srcX = ../../ivory-tower-canopen;
in
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        ivory-tower-canopen = super.haskell.lib.dontHaddock (
          hself.callCabal2nix "ivory-tower-canopen" "${src}" {}
        );
        ivory-tower-canopen-core = super.haskell.lib.dontHaddock (
          hself.callCabal2nix "ivory-tower-canopen-core" "${src}/ivory-tower-canopen-core" {}
        );
        ivory-tower-canopen-src = src;
        ivory-tower-canopen-schema = hself.mkSchema
          "canopen" "${src}/schema" hself.cidl;
        canopen-schema-tower = super.haskell.lib.dontHaddock (
          hself.callCabal2nix "canopen-schema-tower" "${hself.ivory-tower-canopen-schema}/canopen-schema-tower" {}
        );
        canopen-schema-native =  super.haskell.lib.dontHaddock (
          hself.callCabal2nix "canopen-schema-native" "${hself.ivory-tower-canopen-schema}/canopen-schema-native" {}
        );
      });
  });
}
