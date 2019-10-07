{ nixpkgs ? import ./nixpkgs.nix, compiler ? "ghc881" }:
(import ./default.nix { inherit nixpkgs compiler; }).env
