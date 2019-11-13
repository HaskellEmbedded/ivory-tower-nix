# Used by ci.nix, update with
# $ nix-prefetch-url --unpack https://github.com/NixOS/nixpkgs/archive/${REVISION}.tar.gz
#
let
  rev="86ccc63008204a8ab5a7a52645bfb4ade3857818";
  hash="0fyd9spg0szyh7d445pah8l7jq8s1v6dybqfcfswz99j3iq4kfnl";
in
import (
  fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
    sha256 = hash;
  }
) {
  config = {};
  overlays = [];
}
