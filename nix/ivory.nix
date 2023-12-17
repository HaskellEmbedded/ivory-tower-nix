self: super:
let
  # update with
  # nix-prefetch-git https://github.com/distrap/ivory <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "distrap";
    repo = "ivory";
    rev = "69bae09d064042e2135df2894b613ed5eadd38fa";
    sha256 = "1qqw3hygysjnaprij68vda11vz76zxa72gcbxjkc58f9hsblr5c8";
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
    "ivory-tasty"
  ];
in
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: super.lib.genAttrs subs (sub: hself.callCabal2nix sub "${src}/${sub}" {}));
    });
}
