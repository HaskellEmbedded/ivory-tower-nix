self: super:
let
  # update with
  # nix-prefetch-git https://github.com/sorki/ivory <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "sorki";
    repo = "ivory";
    rev = "84400a5dfaa58d1581c77396cf2179dfe209e542";
    sha256 = "14r6b8wmdq431k1gp5sl13m7mgid01rnsis986zmz9nd63y7cfml";
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
