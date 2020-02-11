{ nixpkgs ? import ./nixpkgs.nix {}, compiler ? "ghc881" }:
let
  default = (import ./default.nix { inherit nixpkgs compiler; });
in
nixpkgs.stdenv.mkDerivation {
  name = "ivory-tower-shell";

  buildInputs = with default; [
    hello.env.nativeBuildInputs

    pkgs.gnumake
    pkgs.gcc-arm-embedded

    ivorypkgs.cabal-install
    ivorypkgs.ghcid

    hgdb
  ];

  shellHook = ''
    echo "Ivory Tower shell"
  '';
}
