self: super:
let
  # update with
  # nix-prefetch-git https://github.com/DistRap/ivory-tower-net <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "ivory-tower-net";
    rev = "e369229d801ad63fb69c511c987b6fd7a5ef43a1";
    sha256 = "1yrdagyxgndapf0smid0f5xslzf90yzghqpxfqik3ryn4vi9zgn8";
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
