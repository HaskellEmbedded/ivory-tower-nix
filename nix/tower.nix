self: super:
let
  # update with
  # nix-prefetch-git https://github.com/sorki/tower <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "sorki";
    repo = "tower";
    rev = "d5b21edea4ca9a7ad887c698fe6a00238573b48c";
    sha256 = "0h4nz2mqbq6crnlir577plp2hwpyc3mhm1xq3caw2sb0pvvc6nql";
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
