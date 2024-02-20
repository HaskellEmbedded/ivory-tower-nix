self: super:
let

  # update with
  # nix-prefetch-git https://github.com/DistRap/ivory-tower-drivers <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "ivory-tower-drivers";
    rev = "4b927046805e84f818acfb4b71d5f665b4d07824";
    sha256 = "1f9a23jihyrj4hv95wf9fi6w7v8yfwzknwp78i6c24h1jpmz5dqg";
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
