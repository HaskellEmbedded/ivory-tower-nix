{ nixpkgs ? import <nixpkgs> {}, compiler ? "ghc882" }:
let
  itnSrc = nixpkgs.fetchFromGitHub {
    owner = "HaskellEmbedded";
    repo = "ivory-tower-nix";
    rev = "ccc4d98569d78c331df26bf9f387a7eb52c0c068";
    sha256 = "1s2havlknh4dpc5q45i5c1cbp8j4kk9zj23d9br2v2qwa49d536g";
  };
  itn = import itnSrc { inherit compiler; };
  src = itn.pkgs.nix-gitignore.gitignoreSource [] ./.;
in
  itn // rec {
    my-firmware =
      itn.ivorypkgs.callCabal2nix "my-firmware" "${src}" {};

    shell = itn.mkShell my-firmware;

  }
