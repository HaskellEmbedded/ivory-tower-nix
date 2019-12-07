self: super:
let
  # update with
  # nix-prefetch-git https://github.com/sorki/ivory <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "sorki";
    repo = "ivory";
    rev = "e0ff0300bec31d80aedfb4f2b99e7c25aacb4a53";
    sha256 = "1i58xnb8py8dnmd0z2161zvi11s2wq6nccmx1h0dqhca39zx39h3";
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
