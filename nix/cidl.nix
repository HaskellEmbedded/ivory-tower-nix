self: super:
let

  # update with
  # nix-prefetch-git https://github.com/DistRap/cidl <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "cidl";
    rev = "31f2f277d54407c246e4d4328635eb0b18a6c67b";
    sha256 = "111y4i4hbpyvrg1nfa0mqbm36ly3dq32h6z3x36ws0ps5cnnz422";
  };

  # swap with src to build from this path
  srcX = ../../cidl;
in
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        cidl = super.haskell.lib.dontHaddock ( hself.callCabal2nix "cidl" "${src}" {} );
      });
  });
}
