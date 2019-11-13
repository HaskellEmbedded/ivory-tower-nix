self: super:
let

  # update with
  # nix-prefetch-git https://github.com/distrap/ivory-tower-drivers <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "distrap";
    repo = "ivory-tower-drivers";
    rev = "2274fbcfc65db9fda60d0f7b6e3065273ad0d8c8";
    sha256 = "13b33nxbspqnx79gfzxdy9l99lwmvgah2rwwj50xrcfw826sncg2";
  };

  # swap with src to build from this path
  srcX = ../../ivory-tower-drivers;
in
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        ivory-tower-drivers = super.haskell.lib.dontHaddock ( hself.callCabal2nix "ivory-tower-drivers" "${src}" {} );
      });
  });
}
