self: super:
let
  # update with
  # nix-prefetch-git https://github.com/distrap/language-c-quote <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "mainland";
    repo = "language-c-quote";
    rev = "a27ebb2fa84aa6a378bcbf244a156c58fe86df5d";
    sha256 = "1gyqf92xpi0848v1z261lnyi1pshd5cy4np7lp547p7wxkxr1s1k";
  };

  # swap with src to build from this path
  srcX = ../../language-c-quote;
in
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        language-c-quote = super.haskell.lib.dontHaddock ( hself.callCabal2nix "language-c-quote" "${src}" {} );
      });
    });
}
