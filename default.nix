{ compiler ? "default"
, pkgs ? null
, system ? builtins.currentSystem
, ... }:
let
  comp = if compiler == "default" then "ghc9103" else compiler;
  overlays = import ./overlay.nix comp;
  overlayedPkgs =
    if pkgs == null
    then import ./nixpkgs.nix { inherit overlays system; }
    else import pkgs.path { inherit overlays system; };

  scope = overlayedPkgs.myHaskellPackages;

  mkShell = x: import ./makeshell.nix { pkgs = overlayedPkgs; ivorypkgs = scope; shellForPkg = x; };
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

  inherit (scope)
    ivory-tower-base
    ivory-tower-cayenne
    ivory-tower-canopen
    ivory-tower-drivers
    ivory-tower-helloworld
    ivory-tower-hxstream
    ivory-tower-lorawan
    ivory-tower-posix
    ivory-tower-net
    cidl
    data-prometheus
    gidl
    hgdbmi
    emhell
    network-can
    network-canopen
    ;

  ivorypkgs = scope;

  inherit mkShell;

  # combined overlay
  overlay = overlayedPkgs.lib.composeManyExtensions overlays;
  # or as list of overlays
  inherit overlays;

  pkgs = overlayedPkgs;
}
