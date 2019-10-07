# Used by ci.nix, update with
# $ nix-prefetch-url --unpack https://github.com/NixOS/nixpkgs/archive/${REVISION}.tar.gz
#
import (
  fetchTarball {
    url = https://github.com/vpsfreecz/nixpkgs/archive/8044cf3668886a650ac2af1fd644dbe8f7f62436.tar.gz;
    sha256 = "0fyd9spg0szyh7d445pah8l7jq8s1v6dybqfcfswz99j3iq4kfnl";
  }
) {
  config = {};
  overlays = [];
}
