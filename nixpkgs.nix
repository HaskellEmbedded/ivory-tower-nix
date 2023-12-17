# Used by ci.nix, update with
# $ nix-prefetch-url --unpack https://github.com/NixOS/nixpkgs/archive/${REVISION}.tar.gz
#
let
  rev="1ea3b8a8910ca6025a9389add0ffeb43d8525cf3";
  hash="1qsrswh5jbp05rhldyz6gygzpmy5c3n27vdbxf084zfwa00v1s11";
in
import (
  fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
    sha256 = hash;
  }
)
