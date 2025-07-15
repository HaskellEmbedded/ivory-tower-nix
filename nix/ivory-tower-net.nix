self: super:
let
  # update with
  # nix-prefetch-git https://github.com/DistRap/ivory-tower-net <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "ivory-tower-net";
    rev = "e4a94a5cc82a4451d2696267fa3acb27bb48bd60";
    sha256 = "0y4ik8ifgpa01l5xh7lzsmmn7mfw3a5dbg2c4yn9clq1xb32r4i3";
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
