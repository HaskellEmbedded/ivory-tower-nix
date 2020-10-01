self: super:
let
  # update with
  # nix-prefetch-git https://github.com/distrap/can4disco <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "distrap";
    repo = "can4disco";
    rev = "afe8b5b5953c788e943f9c1da5a05301d35b5ff9";
    sha256 = "1a6wq6i2zvgjn4dvd1jhfl36nfyac5k2bm1cgcb4va4cm0c8i592";
  };

  # swap with src to build from this path
  srcX = ../../can4disco;
in
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        can4disco = super.haskell.lib.dontHaddock ( hself.callCabal2nix "can4disco" "${src}" {} );
      });
    });
}
