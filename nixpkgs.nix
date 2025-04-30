# Used by ci.nix, update with
# $ nix-prefetch-url --unpack https://github.com/NixOS/nixpkgs/archive/${REVISION}.tar.gz
#
let
  rev="a8ab6a03ef15ec274d130af9e2aa061f66e9c473";
  hash="1pqcf2zm6gb790i3kv8d7fmpxzfs3qfsid3rzkjhgf01al7xjinv";
in
import (
  fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
    sha256 = hash;
  }
)
