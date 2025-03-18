# Used by ci.nix, update with
# $ nix-prefetch-url --unpack https://github.com/NixOS/nixpkgs/archive/${REVISION}.tar.gz
#
let
  rev="2177c7f17b999133719c8de824f0caf31e991044";
  hash="1fd0jgcdzm3rpgn9w1axc8gbvdi13pm7g1sji57ddp8jcj7x9bbq";
in
import (
  fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
    sha256 = hash;
  }
)
