{ nixpkgs ? import ./nixpkgs.nix {}, compiler ? "default", package ? "ivory-tower-helloworld" }:
let
  itn = (import ./default.nix { inherit nixpkgs compiler; });
in itn.mkShell itn.ivorypkgs.${package}
