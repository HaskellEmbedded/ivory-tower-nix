self: super:
let
  # update with
  # nix-prefetch-git https://github.com/distrap/hgdbmi <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "distrap";
    repo = "hgdbmi";
    rev = "e307c5d635b7af6506ae1719b40261a718103671";
    sha256 = "0c16aap1p68b4ih3hpxnnqcy6jlp60p3qjhaqif3zam1799rjixl";
  };

  # swap with src to build from this path
  srcX = ../../hgdbmi;
in
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        hgdbmi = super.haskell.lib.dontCheck ( hself.callCabal2nix "hgdbmi" "${src}" {} );
      });
    });
}
