self: super:
let
  # update with
  # nix-prefetch-git https://github.com/sorki/tower <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "sorki";
    repo = "tower";
    rev = "23a54043bc383b804880e802310cf52ce2d1c196";
    sha256 = "1vva44aq2wy1dnlpwpz71mz9q6pm9zskxrap2c4iirsfa9qvbqpd";
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
