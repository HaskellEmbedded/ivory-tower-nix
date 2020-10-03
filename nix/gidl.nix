self: super:
let

  # update with
  # nix-prefetch-git https://github.com/distrap/gidl <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "distrap";
    repo = "gidl";
    rev = "0c60f556303eda187148cd615725e198beb5c44b";
    sha256 = "160329fdvmwm00657wqa9zqdrgk4dgxsmamsmsczawl2fv4bi6xn";
  };

  # swap with src to build from this path
  srcX = ../../gidl;
in
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        gidl = super.haskell.lib.dontHaddock ( hself.callCabal2nix "gidl" "${src}" {} );
      });
  });
}
