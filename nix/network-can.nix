self: super:
let
  # update with
  # nix-prefetch-git https://github.com/DistRap/network-can <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "network-can";
    rev = "d594157c6a373e3afedfce46fd38d36344ca60bd";
    sha256 = "1zk1gfds6a4lskj997g22z9nqlxyxfrs12bi60pf8nf3frg89l5z";
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
