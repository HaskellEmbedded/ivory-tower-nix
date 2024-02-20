self: super:
let
  # update with
  # nix-prefetch-git https://github.com/DistRap/ivory-tower-lorawan <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "ivory-tower-lorawan";
    rev = "fa1e0fecd90a90c90c057d0c1c97eb2c45587f20";
    sha256 = "1b7nk62c8xf9ygv8k8pzwv466qmr1ycaqgcrhh9hpm2rbp0mm7kg";
  };

  # swap with src to build from this path
  srcX = ../../ivory-tower-lorawan;
in
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        ivory-tower-lorawan = super.haskell.lib.dontHaddock ( hself.callCabal2nix "ivory-tower-lorawan" "${src}" {} );
      });
    });
}
