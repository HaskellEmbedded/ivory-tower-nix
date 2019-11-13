self: super:
let
  # update with
  # nix-prefetch-git https://github.com/HaskellEmbedded/data-stm32 <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "HaskellEmbedded";
    repo = "data-stm32";
    rev = "18264a694badee1fdc5b2630f3c26f336f4f7719";
    sha256 = "0q9dl6l0wkg2w42dib2m7k4j6y0q0pkr5zmhr9vfzrhvpradqlsn";
  };

  # swap with src to build from this path
  srcX = ../../data-stm32;
in
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        data-stm32 = super.haskell.lib.dontHaddock ( hself.callCabal2nix "data-stm32" "${src}" {} );
      });
    });
}
