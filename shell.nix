{ compiler ? "default"
, package ? "ivory-tower-helloworld"
, pkgs ? null
, ... }:
let
  itn = (import ./default.nix { inherit compiler pkgs; });
in
  itn.ivorypkgs.mkShell itn.ivorypkgs.${package}
