{ compiler ? "default"
, package ? "ivory-tower-helloworld"
, pkgs ? null
, ... }:
let
  itn = (import ./default.nix { inherit compiler pkgs; });
in itn.mkShell itn.ivorypkgs.${package}
