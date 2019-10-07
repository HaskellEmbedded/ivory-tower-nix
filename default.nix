{ nixpkgs ? import ./nixpkgs.nix, compiler ? "ghc881" }:
let
  overlays = import ./overlay.nix compiler;
  pkgs = import <nixpkgs> { inherit overlays; };
in
#pkgs.myHaskellPackages.ivory-bsp-stm32
pkgs.myHaskellPackages.ivory-tower-helloworld
