self: super:
let
  # update with
  # nix-prefetch-git https://github.com/sorki/tower <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "sorki";
    repo = "tower";
    rev = "7a781ac664f19d4281fc9f2d092b824ff08b2fa4";
    sha256 = "06dp398kwnspv5rg3z4qzk2z1yb7q5yz8i1w1xh98mbp4gxdv5kp";
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
