self: super:
let

  # update with
  # nix-prefetch-git https://github.com/DistRap/cidl <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "cidl";
    rev = "3715d832eb96ca19a5395849b4ded78e0e9f8a5f";
    sha256 = "0p3ps8m9siv2h75fgim8ggdjspirybjbp3bxlyxmn14b4aymmdsr";
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
