compiler: [
  (import ./nix/compiler.nix compiler)
  (import ./nix/env.nix)
  (import ./nix/lib.nix)

  (import ./nix/ivory.nix)
  (import ./nix/ivory-tower-stm32.nix)
  (import ./nix/tower.nix)

  (import ./nix/data-stm32.nix)
  (import ./nix/data-svd.nix)
  (import ./nix/ivory-tower-stm32-generated.nix)

  (import ./nix/ivory-tower-helloworld.nix)
  (import ./nix/ivory-tower-base.nix)
  (import ./nix/ivory-tower-cayenne.nix)
  (import ./nix/ivory-tower-canopen.nix)
  (import ./nix/ivory-tower-lorawan.nix)
  (import ./nix/ivory-tower-posix.nix)
  (import ./nix/ivory-tower-drivers.nix)
  (import ./nix/ivory-tower-hxstream.nix)

  (import ./nix/emhell.nix)
  (import ./nix/hgdbmi.nix)
  (import ./nix/network-can.nix)
  (import ./nix/network-canopen.nix)

  (import ./nix/cidl.nix)
  (import ./nix/gidl.nix)

  # apps
  (import ./nix/can4disco.nix)
  (import ./nix/monstick-firmware.nix)

  # temporary
  # 2023-12-17: until next release (0.13.0.1+)
  # only due to uni-patterns warning
  (import ./nix/language-c-quote.nix)

]
