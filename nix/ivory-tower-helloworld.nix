self: super:
let
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "ivory-tower-helloworld";
    rev = "b93d39413c8f693b8fe1ad1fc0738df19e291cb7";
    sha256 = "15msc0s1v1d6cxs5r7lcchslxalvwsqng3xdl5g2frk0i8ii7h2x";
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
