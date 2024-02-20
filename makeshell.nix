{ pkgs, ivorypkgs, shellForPkg }:
pkgs.stdenv.mkDerivation {
  name = "ivory-tower-shell-${shellForPkg.name}";

  buildInputs = [
    shellForPkg.env.nativeBuildInputs

    pkgs.cutecom
    pkgs.gnumake
    pkgs.gcc-arm-embedded
    pkgs.libev

    ivorypkgs.cabal-install
    ivorypkgs.ghcid
    ivorypkgs.emhell
  ];

  shellHook = ''
    echo ""
    echo "Ivory Tower shell for ${shellForPkg.name}"

    export "IVORY_TOWER_PROJECT=${shellForPkg.pname}"
  '';
}
