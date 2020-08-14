{ nixpkgs ? import ./nixpkgs.nix {}, compiler ? "default" }:
(import ./default.nix { inherit nixpkgs compiler; }).shell
