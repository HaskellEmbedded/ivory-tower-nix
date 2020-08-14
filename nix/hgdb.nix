self: super:
let
  # update with
  # nix-prefetch-git https://github.com/distrap/hgdb <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "distrap";
    repo = "hgdb";
    rev = "18d65b5a6560ddd9f5deecc83d2f309d444ada1c";
    sha256 = "0sv8qyaqj6lw3xyqq0005rydvmi12wpyypn4pzf4ki3i4k3gmcgd";
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
