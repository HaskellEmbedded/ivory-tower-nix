self: super:
let
  # update with
  # nix-prefetch-git https://github.com/DistRap/can4disco <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "can4disco";
    rev = "7374292464e0aee73630c358f5a0f9cd7fa320f6";
    sha256 = "1qjs8dni1w2lila871qpk76bbhzrrl16z4m30vf6rr1ajwi2q521";
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
