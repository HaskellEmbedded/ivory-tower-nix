self: super:
let
  # update with
  # nix-prefetch-git https://github.com/hexamon-tech/ivory-tower-lorawan <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "hexamon-tech";
    repo = "ivory-tower-lorawan";
    rev = "51852a8f8a549fd13c285404c95c049eb93fee79";
    sha256 = "00gp3zxyzf6nyb0yjibv1mbqwqs6xg3kmny3dsail8dpww6ifkfq";
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
