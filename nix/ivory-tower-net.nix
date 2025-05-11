self: super:
let
  # update with
  # nix-prefetch-git https://github.com/DistRap/ivory-tower-net <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "ivory-tower-net";
    rev = "c3ca4cd2b5965339c7b1b944310809a2ff90c09b";
    sha256 = "1y3bb2qgwlvhmy5hy2r2abja4s7b22mv3a2k2ajwkwky8hn0rg9f";
  };

  # swap with src to build from this path
  srcX = ../../ivory-tower-net;
in
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        ivory-tower-net = super.haskell.lib.dontHaddock ( hself.callCabal2nix "ivory-tower-net" "${src}" {} );
      });
    });
}
