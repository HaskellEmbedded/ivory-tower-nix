self: super:
let
  # update with
  # nix-prefetch-git https://github.com/DistRap/data-svd <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "data-svd";
    rev = "ff3d6b8cbe1d4d9bbe0c3a04b18141f692ee64d6";
    sha256 = "002galxgrpgsb4ii9cldgjw8wmfnpznqh9maq3n9d9b3kxhplq2l";
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

