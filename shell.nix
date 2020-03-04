{ nixpkgs ? import ./nixpkgs.nix {}, compiler ? "ghc882" }:
(import ./default.nix { inherit nixpkgs compiler; }).shell
