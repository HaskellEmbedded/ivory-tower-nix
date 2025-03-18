self: super:
let
  # update with
  # nix-prefetch-git https://github.com/DistRap/network-can <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "network-can";
    rev = "508f04e12c09c781607a5b4c96ec620b49b63fd0";
    sha256 = "1fi98v2isn9nvq5w1agqf5q0ibrmcbki774z8fy21x0snh9bzlhj";
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
