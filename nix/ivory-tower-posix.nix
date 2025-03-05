self: super:
let
  # update with
  # nix-prefetch-git https://github.com/DistRap/ivory-tower-posix <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "ivory-tower-posix";
    rev = "4dc3141512ada9bff196eb201128e2b30c808670";
    sha256 = "0lfq9i82nl2agzpa36il570ryxcc7ahn390pxchcxm0bpw70gx25";
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
