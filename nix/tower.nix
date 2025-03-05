self: super:
let
  # update with
  # nix-prefetch-git https://github.com/DistRap/tower <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "tower";
    rev = "774270a1022754c0145d82ef5a8ce0a3eca44300";
    sha256 = "0ik8y63gh7s5l7bk1l96dq5wkp61fz4dbiy679qf6s91fzdq1dwd";
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
