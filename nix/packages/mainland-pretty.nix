{ mkDerivation, base, containers, fetchgit, srcloc, stdenv, text
, transformers
}:
mkDerivation {
  pname = "mainland-pretty";
  version = "0.7.0.1";
  src = fetchgit {
    url = "https://github.com/mainland/mainland-pretty/";
    sha256 = "0d0ki294pagnq9gdf3rrzl6hfzjw1r62zig5vx3l3a90gr862xvm";
    rev = "c13ac6c060d9aff76c926feb20a6b5ac61879e0b";
    fetchSubmodules = true;
  };
  libraryHaskellDepends = [
    base containers srcloc text transformers
  ];
  homepage = "https://github.com/mainland/mainland-pretty";
  description = "Pretty printing designed for printing source code";
  license = stdenv.lib.licenses.bsd3;
}
