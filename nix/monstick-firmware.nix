self: super:
let
  src = super.fetchFromGitHub {
    owner = "hexamon-tech";
    repo = "monstick-firmware";
    rev = "35d9fe2b67f954b21bf984e270f835a310e2ad8e";
    sha256 = "0ahh6fqkv3dzmqphbg7cxp7v3aizlbf3mcnvzicdkl497n5yj4rv";
  };

  srcX = ../../monstick-firmware;
in
{
  myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        monstick = super.haskell.lib.dontHaddock ( hself.callCabal2nix "monstick" "${src}" {} );
      });
    });
}
