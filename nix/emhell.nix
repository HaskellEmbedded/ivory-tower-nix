self: super:
let
  # update with
  # nix-prefetch-git https://github.com/DistRap/emhell <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "emhell";
    rev = "08416f8d70842d4eb1591bc7a8532b90f24ee8b6";
    sha256 = "0x5x5rk0nyj1fxchn3g0lq2x2di7lrwsflj8qcn463ha54pqgacs";
  };

  # swap with src to build from this path
  srcX = ../../emhell;
in
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        emhell = super.haskell.lib.dontCheck ( hself.callCabal2nix "emhell" "${src}" {} );
      });
    });
}
