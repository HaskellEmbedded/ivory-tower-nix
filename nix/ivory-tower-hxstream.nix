self: super:
let
  # update with
  # nix-prefetch-git https://github.com/distrap/ivory-tower-hxstream <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "distrap";
    repo = "ivory-tower-hxstream";
    rev = "a27c1bfac3aa7616060341e5cdad6e5f6edffac3";
    sha256 = "0nyrfblk7hq5rw03k1gxfqpajs7bl7d33qd5zgphy0jlxgbws4jq";
  };

  # swap with src to build from this path
  srcX = ../../ivory-tower-hxstream;
in
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        ivory-tower-hxstream = super.haskell.lib.dontHaddock ( hself.callCabal2nix "ivory-tower-hxstream" "${src}" {} );
      });
    });
}
