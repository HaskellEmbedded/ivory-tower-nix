self: super:
let

  # update with
  # nix-prefetch-git https://github.com/DistRap/cidl <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "cidl";
    rev = "32afdce51cc3ab57dc248941f9d4077e06639744";
    sha256 = "0cqd9ncm4437hm5z3df0r1ah1147chv4ky6gad10sjsyzw11ln4x";
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
