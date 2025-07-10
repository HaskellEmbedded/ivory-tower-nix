self: super:
let
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "monstick-firmware";
    rev = "f36da317ca42f6e6cbb0fd4ea8d2e54649155bc9";
    sha256 = "1pd60vsc06qy71j5r8qkfhp73ps7jr8dxb9zm6f2qwx5vsa6yi7b";
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
