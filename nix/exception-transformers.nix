self: super:
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        exception-transformers = super.haskell.lib.doJailbreak ( hself.callPackage ./packages/exception-transformers.nix {});
      });
    });
}
