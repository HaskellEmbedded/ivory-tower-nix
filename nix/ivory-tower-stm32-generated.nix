self: super:
let

  # update with
  # nix-prefetch-git https://github.com/HaskellEmbedded/ivory-tower-stm32-generated <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "HaskellEmbedded";
    repo = "ivory-tower-stm32-generated";
    rev = "118b63156a06d2ae57b85ad2f37e0587830adc97";
    sha256 = "1sknnr51n8060sq4wbsj5vxpfn26517wp01g1yq9riyqqd83vmcf";
  };

  # swap with src to build from this path
  srcX = ../../ivory-tower-stm32-generated;
in
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        ivory-bsp-stm32 = super.haskell.lib.dontHaddock ( hself.callCabal2nix "ivory-bsp-stm32" "${src}" {});
      });
  });
}
