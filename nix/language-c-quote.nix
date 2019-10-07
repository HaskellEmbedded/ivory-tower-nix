self: super:
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        language-c-quote = super.haskell.lib.doJailbreak ( hself.callPackage ./packages/language-c-quote.nix {});
      });
    });
}
