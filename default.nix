{ nixpkgs ? import ./nixpkgs.nix {}, compiler ? "ghc881" }:
let
  overlays = import ./overlay.nix compiler;
  pkgs = import ./nixpkgs.nix { inherit overlays; };
  scope = pkgs.myHaskellPackages;
in
rec {
  hello = scope.ivory-tower-helloworld;

  hgdb = scope.hgdb;

  simpleblink = scope.mkImage "simpleblink-test" {} hello;
  simpleblink-bluepill = scope.mkImage "simpleblink-test" {
    defaultConf = pkgs.writeText "bluepill-platform" ''
      [args]
      platform = "bluepill"
      '';
  } hello;

  ivorypkgs = scope;
  inherit pkgs;
}
