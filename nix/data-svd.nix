self: super:
let
  # update with
  # nix-prefetch-git https://github.com/distrap/data-svd <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "distrap";
    repo = "data-svd";
    rev = "fec58f6e0afaeef97668eeb6834cc2fe40f2eec9";
    sha256 = "1i1kjjjwn9nqjbb2ad8fnpbsqabjzp39pnmhqgf1bw6vbqniwgzn";
  };

  # swap with src to build from this path
  srcX = ../../data-svd;
in
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        data-svd =
          super.haskell.lib.dontCheck (
            super.haskell.lib.dontHaddock
              ( hself.callCabal2nix "data-svd" "${src}" {} )
            );
      });
    });
}

