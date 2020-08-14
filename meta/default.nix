{ nixpkgs ? import <nixpkgs> {}, compiler ? "ghc882" }:
let
  itnSrc = nixpkgs.fetchFromGitHub {
    owner = "HaskellEmbedded";
    repo = "ivory-tower-nix";
    rev = "c9dfbb383138c09bf854b4520bdaceb9032191cd";
    sha256 = "0sk8wmg4y0130a4wdhc9547na3igs6pz0n3rs2x73i0c1p6fdx9w";
  };
  itn = import itnSrc { inherit compiler; };
  src = itn.pkgs.nix-gitignore.gitignoreSource [] ./.;
in
  itn // rec {
    my-firmware =
      itn.ivorypkgs.callCabal2nix "my-firmware" "${src}" {};

    shell = itn.mkShell my-firmware;

  }
