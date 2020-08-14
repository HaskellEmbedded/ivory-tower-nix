self: super:
let
  # update with
  # nix-prefetch-git https://github.com/distrap/ivory-tower-posix <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "distrap";
    repo = "ivory-tower-posix";
    rev = "6d0b8116b1e8f9cb9e8bea40735642d6bea2817f";
    sha256 = "0cb7fjy6m351r1y77dx51cp015khqmv3lr11hpnkdwfbabhqaani";
  };

  # swap with src to build from this path
  srcX = ../../ivory-tower-posix;
in
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        ivory-tower-posix = super.haskell.lib.dontHaddock ( hself.callCabal2nix "ivory-tower-posix" "${src}" {} );
      });
    });
}
