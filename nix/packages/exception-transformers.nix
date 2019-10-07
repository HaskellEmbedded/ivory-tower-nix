{ mkDerivation, base, fetchgit, HUnit, stdenv, stm, test-framework
, test-framework-hunit, transformers, transformers-compat
}:
mkDerivation {
  pname = "exception-transformers";
  version = "0.4.0.7";
  src = fetchgit {
    url = "https://github.com/deepfire/exception-transformers";
    sha256 = "12wa8icrx623rlrsbfg30dqr61jbp5pm5b88nikxa6czlnzmwr0q";
    rev = "2ae0da65db147a589f47af3b81879611ae5e91c4";
    fetchSubmodules = true;
  };
  libraryHaskellDepends = [
    base stm transformers transformers-compat
  ];
  testHaskellDepends = [
    base HUnit test-framework test-framework-hunit transformers
    transformers-compat
  ];
  description = "Type classes and monads for unchecked extensible exceptions";
  license = stdenv.lib.licenses.bsd3;
}
