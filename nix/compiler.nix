compiler: self: super:
{
  myHaskellPackages = super.haskell.packages.${compiler}.override {
    overrides = newHaskellPkgs: oldHaskellPkgs: { };
  };
}
