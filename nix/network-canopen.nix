self: super:
let
  # update with
  # nix-prefetch-git https://github.com/DistRap/network-canopen <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "network-canopen";
    rev = "fcdb8de0836383f5dc59fc7f5c774ae7ddd6e59f";
    sha256 = "05smi45r980bsy4nxzgn0hg77h4c3hsdpcs4dk9cfmcylw9iimcm";
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
