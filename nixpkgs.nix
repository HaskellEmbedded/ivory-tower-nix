# Used by ci.nix, update with
# $ nix-prefetch-url --unpack https://github.com/NixOS/nixpkgs/archive/${REVISION}.tar.gz
#
let
  rev="e8531b8ed409cc892616ca5d4e63259e86b6d668";
  hash="1vvx8gh16gdh5q39qp7v1cm5cnxn0jkdqirh9ihf9snrfc95mbn6";
in
import (
  fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
    sha256 = hash;
  }
)
