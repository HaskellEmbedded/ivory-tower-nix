self: super:
let
  # update with
  # nix-prefetch-git https://github.com/DistRap/ivory-tower-base <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "ivory-tower-base";
    rev = "ce78dff00836f11b81981fbbeba877afcf8cb616";
    sha256 = "1q3sb8x3vzv5flg3jq8lksdafpj9gdh0q7xik0f7x65skc4nbbam";
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
