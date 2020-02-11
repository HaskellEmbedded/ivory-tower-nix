self: super:
let
  # update with
  # nix-prefetch-git https://github.com/hexamon-tech/ivory-tower-lorawan <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "hexamon-tech";
    repo = "ivory-tower-lorawan";
    rev = "e387d93323355972ba7d3c700a8b55a1e2fa1669";
    sha256 = "0zl0gp9p7v6n4mgyhqnijm1ich3h6j5gmz7ma5g73bvx9dmlslak";
  };

  # swap with src to build from this path
  srcX = ../../ivory-tower-lorawan;
in
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        ivory-tower-lorawan = super.haskell.lib.dontHaddock ( hself.callCabal2nix "ivory-tower-lorawan" "${src}" {} );
      });
    });
}
