compiler: [
  (import ./nix/compiler.nix compiler)
  (import ./nix/lib.nix)

  (import ./nix/ivory.nix)
  (import ./nix/ivory-tower-stm32.nix)
  (import ./nix/tower.nix)

  (import ./nix/data-stm32.nix)
  (import ./nix/ivory-tower-stm32-generated.nix)

  (import ./nix/ivory-tower-helloworld.nix)
  (import ./nix/ivory-tower-base.nix)
  (import ./nix/ivory-tower-cayenne.nix)
  (import ./nix/ivory-tower-drivers.nix)

  (import ./nix/hastache.nix)
  # ghc 881 fixes
  (import ./nix/exception-transformers.nix)
  (import ./nix/mainland-pretty.nix)
  (import ./nix/language-c-quote.nix)
]
