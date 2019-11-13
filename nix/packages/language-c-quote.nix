{ mkDerivation, alex, array, base, bytestring, containers
, exception-mtl, exception-transformers, fetchgit, filepath, happy
, haskell-src-meta, HUnit, mainland-pretty, mtl, srcloc, stdenv
, syb, symbol, template-haskell, test-framework
, test-framework-hunit
}:
mkDerivation {
  pname = "language-c-quote";
  version = "2019-11-11";
  src = fetchgit {
    url = "https://github.com/sorki/language-c-quote/";
    sha256 = "1nff6pf46h12d5grmg711w3l221l0hv26lrhgkic6ziprppwb83x";
    rev = "daf5410f16ee5d047381359de85239384f05efe1";
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
