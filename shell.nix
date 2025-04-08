{ compiler ? "default", package ? "ivory-tower-helloworld", ... }:
let
  itn = (import ./default.nix { inherit compiler; });
in itn.mkShell itn.ivorypkgs.${package}
