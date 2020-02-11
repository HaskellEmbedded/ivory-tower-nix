self: super:
let
  # update with
  # nix-prefetch-git https://github.com/distrap/hgdbmi <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "distrap";
    repo = "hgdbmi";
    rev = "e0f908e9293aa1f029e98aa7f14a04afe964facf";
    sha256 = "1ypfigwbja288qnhg0n42c0m6h4cr1hwnh3275dc1w2nv6xjgi1b";
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
