self: super:
let
  # update with
  # nix-prefetch-git https://github.com/distrap/tower <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "distrap";
    repo = "tower";
    rev = "7ff133e172eddbf01a0b44333ec2fb80404afd47";
    sha256 = "080q2qf33lwz9bv3pbk8vgiq5rks01bnx0vzim4dd8wskk90zahq";
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
