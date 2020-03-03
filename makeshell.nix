{ pkgs, ivorypkgs, shellForPkg }:
pkgs.stdenv.mkDerivation {
  name = "ivory-tower-shell-${shellForPkg.name}";

  buildInputs = [
    shellForPkg.env.nativeBuildInputs

    pkgs.gnumake
    pkgs.gcc-arm-embedded

    ivorypkgs.cabal-install
    ivorypkgs.ghcid
    ivorypkgs.hgdb
  ];

  shellHook = ''
    echo "Ivory Tower shell for ${shellForPkg.name}"
  '';
}
