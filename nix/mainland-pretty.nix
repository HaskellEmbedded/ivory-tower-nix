self: super:
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        mainland-pretty = super.haskell.lib.doJailbreak ( hself.callPackage ./packages/mainland-pretty.nix {});
      });
    });
}
