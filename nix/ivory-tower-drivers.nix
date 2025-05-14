self: super:
let

  # update with
  # nix-prefetch-git https://github.com/DistRap/ivory-tower-drivers <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "ivory-tower-drivers";
    rev = "26922cd5c841b90e345f1643a2879de1d60905ec";
    sha256 = "1mbb2wvq9kfjg06r5k84yaxdmi77z516r5vz82an07mflmnzvxvs";
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
