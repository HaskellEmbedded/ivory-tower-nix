self: super:
let

  # update with
  # nix-prefetch-git https://github.com/DistRap/cidl <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "cidl";
    rev = "fe515b9dfdd58ecec5162e91a6a05850d5e68bac";
    sha256 = "14bdpvhi0q0ndyg07rnkwl4arizxs9skiaccb2f5wklxazjkjxkr";
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
