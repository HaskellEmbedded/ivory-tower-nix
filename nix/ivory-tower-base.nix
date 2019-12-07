self: super:
let
  # update with
  # nix-prefetch-git https://github.com/distrap/ivory-tower-base <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "distrap";
    repo = "ivory-tower-base";
    rev = "ab625cfcf0be8091eca94d41d4ea6c7b6d8b0821";
    sha256 = "18w0j1187wkwrjf387xrkfd9jm4xrvwgl935yncgzfcg5gs6fwhb";
  };

  # swap with src to build from this path
  srcX = ../../ivory-tower-base;
in
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        ivory-tower-base = super.haskell.lib.dontHaddock ( hself.callCabal2nix "ivory-tower-base" "${src}" {} );
      });
    });
}
