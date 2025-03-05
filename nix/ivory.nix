self: super:
let
  # update with
  # nix-prefetch-git https://github.com/DistRap/ivory <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "DistRap";
    repo = "ivory";
    rev = "5117a95efa786998fc24b5c5688844043555c47b";
    sha256 = "1s264r7hbxy0vdzsra4pzg1j1sl8q41v8klfm5dl9g07fmpl7f65";
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
