self: super:
let

  # update with
  # nix-prefetch-git https://github.com/DistRap/ivory-tower-drivers <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "ivory-tower-drivers";
    rev = "28fb1a35bf237b6286c07fbef6b744d4b640bd0b";
    sha256 = "1zjaabf7kkrlz3m7036r7lkbhasnn2b8m5zya5lrk3xj3vdsp9qm";
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
