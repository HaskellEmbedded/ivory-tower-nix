self: super:
let
  # update with
  # nix-prefetch-git https://github.com/hexamon-tech/ivory-tower-cayenne <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "hexamon-tech";
    repo = "ivory-tower-cayenne";
    rev = "1fe7ca5081a2d582547ac9dc5c6566491f4aa6aa";
    sha256 = "1s48j9f8nx40vyh90fmgia05hh0yhikrz2gqgcdwl78w7w37wsw0";
  };

  # swap with src to build from this path
  srcX = ../../ivory-tower-cayenne;
in
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        ivory-tower-cayenne = super.haskell.lib.dontHaddock ( hself.callCabal2nix "ivory-tower-cayenne" "${src}" {} );
      });
    });
}
