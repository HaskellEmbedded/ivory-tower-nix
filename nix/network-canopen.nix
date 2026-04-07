self: super:
let
  # update with
  # nix-prefetch-git https://github.com/DistRap/network-canopen <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "network-canopen";
    rev = "55f3ad6b448942fcc4628631914e579b43faebe0";
    sha256 = "0pw60hhhdmckk8fb0y3wgmmp02673pd917anvkr6sd705zqglaiw";
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
