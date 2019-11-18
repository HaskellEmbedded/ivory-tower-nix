# Used by ci.nix, update with
# $ nix-prefetch-url --unpack https://github.com/NixOS/nixpkgs/archive/${REVISION}.tar.gz
#
let
  rev="86ccc63008204a8ab5a7a52645bfb4ade3857818";
  hash="133vkglgnrrk0jqms2iky5f1fli7bbk2idaxli2wk66isc66lbnm";
in
import (
  fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
    sha256 = hash;
  }
)
