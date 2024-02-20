self: super:
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        mkDerivation = x: (hsuper.mkDerivation x).override(
          {
            # disable library profiling globally
            # - expensive to rebuild every haskell dep
            # enableLibraryProfiling = false;
          });
          # on package level we can use
          # super.haskell.lib.disableLibraryProfiling
          # super.haskell.lib.dontHaddock
      });
  });
}
