self: super:
let
  # update with
  # nix-prefetch-git https://github.com/DistRap/can4disco <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "can4disco";
    rev = "1582e3823b2591c992b820a6d473c5e135ef435e";
    sha256 = "10mpk33rvhizjd0py67zy70g0wlysx19mkmnjgahym72ddlhdr9c";
  };

  # swap with src to build from this path
  srcX = ../../can4disco;
in
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        can4disco = super.haskell.lib.dontHaddock ( hself.callCabal2nix "can4disco" "${src}" {} );
      });
    });
}
