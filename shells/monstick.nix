{ nixpkgs ? import ../nixpkgs.nix {}, compiler ? "default" }:
let
  itn = (import ../default.nix { inherit nixpkgs compiler; });
in itn.mkShell itn.ivorypkgs.monstick
