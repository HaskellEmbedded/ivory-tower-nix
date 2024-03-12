self: super:
let

  # update with
  # nix-prefetch-git https://github.com/DistRap/ivory-tower-canopen <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "ivory-tower-canopen";
    rev = "833a81c3d4c26cf93b79458b3df44850b7a3f3a1";
    sha256 = "13qrf9hrmf2kizkzqliqz2ivylxkmzbddbybnfkkw75hdl2prw0r";
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
