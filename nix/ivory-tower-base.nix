self: super:
let
  # update with
  # nix-prefetch-git https://github.com/distrap/ivory-tower-base <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "distrap";
    repo = "ivory-tower-base";
    rev = "c173d11ea809f20732a80ec219c979ba2241af97";
    sha256 = "1004raw2300cvykz801b8h8fs655ilpfahkv0756ajlrrfmhrpj5";
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
