self: super:
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        hastache = hself.callPackage ./packages/hastache.nix {};
      });
    });
}
