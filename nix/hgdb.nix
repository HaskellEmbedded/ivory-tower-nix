self: super:
let
  # update with
  # nix-prefetch-git https://github.com/distrap/hgdb <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "distrap";
    repo = "hgdb";
    rev = "d236297bf59bd4ab95df97d970833f45eed13e12";
    sha256 = "0gcdm3fv33qpf0qjcacdfrq5rsnrgdfa4k8pism75wkacvhqm07x";
  };

  # swap with src to build from this path
  srcX = ../../hgdb;
in
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        hgdb = super.haskell.lib.dontCheck ( hself.callCabal2nix "hgdb" "${src}" {} );
      });
    });
}
