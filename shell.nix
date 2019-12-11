{ nixpkgs ? import ./nixpkgs.nix {}, compiler ? "ghc881" }:
let
  default = (import ./default.nix { inherit nixpkgs compiler; });
in
nixpkgs.stdenv.mkDerivation {
  name = "ivory-tower-shell";

  buildInputs = [
    default.env.nativeBuildInputs
    nixpkgs.gnumake
    nixpkgs.gcc-arm-embedded
  ];

  shellHook = ''
    echo "Ivory Tower shell"
  '';
}
