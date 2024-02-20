# Used by ci.nix, update with
# $ nix-prefetch-url --unpack https://github.com/NixOS/nixpkgs/archive/${REVISION}.tar.gz
#
let
  rev="ec769627e07c2fb8276fc99bcd90e065743db582";
  hash="03n89ig2w8mvdd8z3y5xmi5c0ljf5lhildcv2gzan4g1ng4s79lg";
in
import (
  fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
    sha256 = hash;
  }
)
