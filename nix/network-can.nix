self: super:
let
  # update with
  # nix-prefetch-git https://github.com/DistRap/network-can <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "network-can";
    rev = "dc0ab68a822d6fadff7164e0b110031fb2a9fe94";
    sha256 = "1k70v5llpsk4z0cs7rb9g1ni38n87spvxgzhsfif2drfj3i024ll";
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
