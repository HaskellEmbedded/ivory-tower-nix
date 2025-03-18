self: super:
let
  # update with
  # nix-prefetch-git https://github.com/sorki/data-prometheus <OPTIONAL_REV>
  src = super.fetchFromGitHub {
    owner = "sorki";
    repo = "data-prometheus";
    rev = "3e713108e7707c048cea07b0b12ecb5be6a6d78c";
    sha256 = "1c5l68lcmpdsz47xy6xzvbryank4gn3gsxmpdcmzqasdqd0nm6ch";
  };

  # swap with src to build from this path
  #src = ../../data-prometheus;
in
{
 myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        data-prometheus = hself.callCabal2nix "data-prometheus" "${src}" {};
      });
    });
}
