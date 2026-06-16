self: super:
let
  # update with
  # nix-prefetch-git https://github.com/DistRap/network-canopen <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "network-canopen";
    rev = "d86e55540e1a45f79bfbb847e57b6f28d9bd9699";
    sha256 = "1zc4lkj19hylmqbq1ivan1r2g04xws3nk4jr28zwr4cx3dhvhv33";
  };

  # swap with src to build from this path
  #srcX = ../../network-canopen;
in
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        network-canopen = hself.callCabal2nix "network-canopen" "${src}" {};
      });
    });
}
