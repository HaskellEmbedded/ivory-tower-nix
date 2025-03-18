self: super:
let
  # update with
  # nix-prefetch-git https://github.com/DistRap/network-can <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "network-can";
    rev = "92fc3444b0cbf5cb040b7e415f333778ea2cbb9b";
    sha256 = "1cpgd6nj6631k9r1v0ihck2pip97qfvlv5dkbs50rxn0abslgv19";
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
