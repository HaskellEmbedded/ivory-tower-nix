self: super:
let
  # update with
  # nix-prefetch-git https://github.com/DistRap/network-canopen <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "network-canopen";
    rev = "09680c646540ddcdc788485999b43d445e1729b5";
    sha256 = "1m9mvp3kqhmnynfjqm910w5lclnrsxidlc7217v3wc0k069a722v";
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
