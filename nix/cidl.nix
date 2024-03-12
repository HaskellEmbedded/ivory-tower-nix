self: super:
let

  # update with
  # nix-prefetch-git https://github.com/DistRap/cidl <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "cidl";
    rev = "63af660ab0cef9239fcae6d13a3c99cc4768978a";
    sha256 = "0dlzxfzxklafz7z7fs0bz9i2inyqzd7v9iq65dgf8j24r2993d5x";
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
