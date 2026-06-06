self: super:
let

  # update with
  # nix-prefetch-git https://github.com/DistRap/ivory-tower-drivers <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "ivory-tower-drivers";
    rev = "502ae4a18d05a217bffafc9a7888967bc4d2da2b";
    sha256 = "1d1gwf9k0r71xgn90c3ma58p09m70319rsmswv1315m65dwvy7v7";
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
