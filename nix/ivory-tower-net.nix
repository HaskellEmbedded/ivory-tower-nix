self: super:
let
  # update with
  # nix-prefetch-git https://github.com/DistRap/ivory-tower-net <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "ivory-tower-net";
    rev = "e6e5f2df6473a7b6cba36b1a13523cd4c056d24c";
    sha256 = "0sxhr2k7q1w09wdgv5pn1f4wlnjqdrsx667ahwbsm4nbx1cbiqcj";
  };

  # swap with src to build from this path
  srcX = ../../ivory-tower-net;
in
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        ivory-tower-net = super.haskell.lib.dontHaddock ( hself.callCabal2nix "ivory-tower-net" "${src}" {} );
      });
    });
}
