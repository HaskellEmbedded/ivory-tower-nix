{ nixpkgs ? import <nixpkgs> {}, compiler ? "ghc881" }:
let
  itnSrc = nixpkgs.fetchFromGitHub {
    owner = "HaskellEmbedded";
    repo = "ivory-tower-nix";
    rev = "30bb0a960cd9145322a5542b406d14daf1595d9a";
    sha256 = "1pzz0vy4xzlp5dm4izdl6iijkgqbbm535s6v06jfpc53al3j2m97";
  };
  itn = import itnSrc { inherit compiler; };
  src = itn.pkgs.nix-gitignore.gitignoreSource [] ./.;
in
  itn // rec {
    my-firmware =
      itn.ivorypkgs.callCabal2nix "my-firmware" "${src}" {};

    shell = itn.mkShell my-firmware;

  }
