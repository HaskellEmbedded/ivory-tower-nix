# Used by ci.nix, update with
# $ nix-prefetch-url --unpack https://github.com/NixOS/nixpkgs/archive/${REVISION}.tar.gz
#
let
  rev="b2ac9a1aff916bf323b256405aab121f74555232";
  hash="1lnxrr4xnw29mw8gxwdg9f110682df8rs1kr2360di8y5smsharb";
in
import (
  fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
    sha256 = hash;
  }
)
