self: super:
let
  src = super.fetchFromGitHub {
    owner = "distrap";
    repo = "ivory-tower-helloworld";
    rev = "5a804c272c3bea56a5e12142ceb1c28cbc4bc4ab";
    sha256 = "1xxfn7mqsh37cjm5qrdshvsadp7vivrckn9qqr03396sjjlmy7pw";
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
