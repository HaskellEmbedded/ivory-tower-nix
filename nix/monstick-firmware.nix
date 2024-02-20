self: super:
let
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "monstick-firmware";
    rev = "e733664bb795c0eadc90e0d7a3d84d84f0e2bb04";
    sha256 = "1bm1mahspb6cijyfldmnw50q5pv4w8wgrxp19wr0cxcjgf6brkkx";
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
