self: super:
let
  # update with
  # nix-prefetch-git https://github.com/distrap/ivory-tower-base <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "distrap";
    repo = "ivory-tower-base";
    rev = "6b96caed7bbd177b3a748bc0360b3836833bd4cf";
    sha256 = "0xk5p1ksxxwbl71imf6hi87d452whvl888mqpyajr97mfjaw3jri";
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
