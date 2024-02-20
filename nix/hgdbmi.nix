self: super:
let
  # update with
  # nix-prefetch-git https://github.com/distrap/hgdbmi <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "distrap";
    repo = "hgdbmi";
    rev = "e7dc8878eea4520d1e132ea917f90ee6afb5aacd";
    sha256 = "0ys7iyy4c4rg10y926xyn0d9q1qnlgw8r02fy3pi2jshh0f3s6i5";
  };

  # swap with src to build from this path
  srcX = ../../hgdbmi;
in
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        hgdbmi = super.haskell.lib.dontCheck ( hself.callCabal2nix "hgdbmi" "${src}" {} );
      });
    });
}
