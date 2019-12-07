self: super:
let

  # update with
  # nix-prefetch-git https://github.com/distrap/ivory-tower-drivers <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "distrap";
    repo = "ivory-tower-drivers";
    rev = "58250359c826398462006c6c5786003acc2e116a";
    sha256 = "1ry7aryxd243s8lhpwipxa675dsvcy0p8a1y48clh4d1wdzkm9ab";
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
