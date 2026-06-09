self: super:
let
  # update with
  # nix-prefetch-git https://github.com/DistRap/network-canopen <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "network-canopen";
    rev = "3b8230535b09ae8aa83eeae8c266336396c2a95e";
    sha256 = "1ixc13s99dim1fl3p9p4rhz9acafra7qacx5q3wm29n0jhs00z27";
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
