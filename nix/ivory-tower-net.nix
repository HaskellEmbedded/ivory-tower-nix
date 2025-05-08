self: super:
let
  # update with
  # nix-prefetch-git https://github.com/DistRap/ivory-tower-net <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "ivory-tower-net";
    rev = "4fb661e591d921e0ab860b94116f57dbd96ced90";
    sha256 = "1j46jsl1pf7s3qfp0d8mkk0bdjnv7k10y3wxyf625zmmh8i0y9zz";
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
