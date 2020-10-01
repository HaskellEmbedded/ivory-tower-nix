{ nixpkgs ? import ./nixpkgs.nix {}, compiler ? "default" }:
let
  comp = if compiler == "default" then "ghc8101" else compiler;
  overlays = import ./overlay.nix comp;
  pkgs = import ./nixpkgs.nix { inherit overlays; };
  scope = pkgs.myHaskellPackages;

  mkShell = x: import ./makeshell.nix { inherit pkgs; ivorypkgs = scope; shellForPkg = x; };
in
rec {
  hello = scope.genTargets scope.ivory-tower-helloworld;
  can4disco = scope.genTargets scope.can4disco;
  monstick = scope.genTargets scope.monstick;

  # we want to always build these on nix-build without args
  simpleblink = hello.simpleblink-test.f4disco.image;
  simpleblink-bluepill = hello.simpleblink-test.bluepill.image;
  slcan = can4disco.slcan-test.f4disco.image;
  monstick-lorawan = monstick.lorawan.monstick.image;

  hgdb = scope.hgdb;
  ivorypkgs = scope;

  inherit pkgs;
  inherit mkShell;
}
