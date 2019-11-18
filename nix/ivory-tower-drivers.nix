self: super:
let

  # update with
  # nix-prefetch-git https://github.com/distrap/ivory-tower-drivers <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "distrap";
    repo = "ivory-tower-drivers";
    rev = "96e2541dfdde8b1966950c30714db47ca4e4971b";
    sha256 = "1rk5amrdavmx12as2hi5p1azwlam2dnwbq5rk9zrknvjycl2liyh";
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
