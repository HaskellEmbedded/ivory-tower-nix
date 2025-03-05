self: super:
let
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "ivory-tower-helloworld";
    rev = "abee183871bbcd178994974e57adbb1db9256e22";
    sha256 = "0gnisqyqnfwg36v8d0jvab25dx0pjv5i97mg0cm66kz14fw7z4x8";
  };

  srcX = ../../ivory-tower-helloworld;
in
{
  myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        ivory-tower-helloworld = super.haskell.lib.dontHaddock ( hself.callCabal2nix "ivory-tower-helloworld" "${src}" {} );
      });
    });
}
