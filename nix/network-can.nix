self: super:
let
  # update with
  # nix-prefetch-git https://github.com/DistRap/network-can <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "network-can";
    rev = "5cb59266d752d7324955444146f2c3d4c4637e7d";
    sha256 = "0n25ycyngyx8s888ll189n5ws5v0nh58d2fnskv9lssh8xj1kfvm";
  };

  # swap with src to build from this path
  #srcX = ../../network-can;
in
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        network-can = hself.callCabal2nix "network-can" "${src}" {};
      });
    });
}
