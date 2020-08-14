{ nixpkgs ? import ./nixpkgs.nix {}, compiler ? "default" }:
let
  comp = if compiler == "default" then "ghc8101" else compiler;
  overlays = import ./overlay.nix comp;
  pkgs = import ./nixpkgs.nix { inherit overlays; };
  scope = pkgs.myHaskellPackages;

  mkShell = x: import ./makeshell.nix { inherit pkgs; ivorypkgs = scope; shellForPkg = x; };
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
  inherit mkShell;
}
