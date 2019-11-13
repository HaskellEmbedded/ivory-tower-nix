self: super:
let
  # update with
  # nix-prefetch-git https://github.com/sorki/tower <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "sorki";
    repo = "tower";
    rev = "74b7aa731c8aed279e240e35eb13a097fa6e3d38";
    sha256 = "01c345x3giycb5a6m4d3qih3pwzwhd6haqc2wcrga62619ljyy91";
  };

  # swap with src to build from this path
  srcX = ../../tower;

  subs = [
    "tower"
    "tower-aadl"
    "tower-config"
    "tower-hal"
    "tower-mini"
  ];
in
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: super.lib.genAttrs subs (sub: hself.callCabal2nix sub "${src}/${sub}" {}));
    });
}
