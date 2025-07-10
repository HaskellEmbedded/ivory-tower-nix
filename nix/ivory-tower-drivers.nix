self: super:
let

  # update with
  # nix-prefetch-git https://github.com/DistRap/ivory-tower-drivers <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "ivory-tower-drivers";
    rev = "7ef17adad374fea7298dabc511d97f8f57301ec9";
    sha256 = "1wzk9qx1iwr853wwy58xhydbz1mmjwm5dj4yb30a22gwra02nqqf";
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
