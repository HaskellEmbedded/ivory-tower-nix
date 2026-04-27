# Used by ci.nix, update with
# $ nix-prefetch-url --unpack https://github.com/NixOS/nixpkgs/archive/${REVISION}.tar.gz
#
let
  rev="6461fd2d51cb216764587d4d3b0224b68091b624";
  hash="0xxgfl36c9j8a3bpwma6aw04f7psqb4mhkxj1rypryvlxzj08qls";
in
import (
  fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
    sha256 = hash;
  }
)
