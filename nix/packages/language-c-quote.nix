{ mkDerivation, alex, array, base, bytestring, containers
, exception-mtl, exception-transformers, fetchgit, filepath, happy
, haskell-src-meta, HUnit, mainland-pretty, mtl, srcloc, stdenv
, syb, symbol, template-haskell, test-framework
, test-framework-hunit
}:
mkDerivation {
  pname = "language-c-quote";
  version = "0.12.2";
  src = fetchgit {
    url = "https://github.com/sorki/language-c-quote/";
    sha256 = "0283lg2bh2l7j9abv4j9mfhm0av32m74r812dy458nsdjqbsz5hw";
    rev = "a6f14c2797001e9605bb649d02118f0b5be3b2bd";
    fetchSubmodules = true;
  };
  libraryHaskellDepends = [
    array base bytestring containers exception-mtl
    exception-transformers filepath haskell-src-meta mainland-pretty
    mtl srcloc syb symbol template-haskell
  ];
  libraryToolDepends = [ alex happy ];
  testHaskellDepends = [
    base bytestring HUnit mainland-pretty srcloc symbol test-framework
    test-framework-hunit
  ];
  homepage = "https://github.com/mainland/language-c-quote";
  description = "C/CUDA/OpenCL/Objective-C quasiquoting library";
  license = stdenv.lib.licenses.bsd3;
}
