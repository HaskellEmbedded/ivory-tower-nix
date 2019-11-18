self: super:
let
  # update with
  # nix-prefetch-git https://github.com/sorki/ivory <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "sorki";
    repo = "ivory";
    rev = "4d275b92b36bd1d8ae7e6669c58de3239daeb631";
    sha256 = "0n929ym7plpj2canba0j12slvyw2cjgg8lgh695a3w7rd0yvfl3c";
  };

  # swap with src to build from this path
  srcX = ../../ivory;

  subs = [
    "ivory"
    "ivory-artifact"
    "ivory-backend-c"
    "ivory-eval"
    "ivory-examples"
    "ivory-hw"
    "ivory-model-check"
    "ivory-opts"
    "ivory-quickcheck"
    "ivory-serialize"
    "ivory-stdlib"
  ];
in
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: super.lib.genAttrs subs (sub: hself.callCabal2nix sub "${src}/${sub}" {}));
    });
}
