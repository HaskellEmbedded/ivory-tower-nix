# ivory-tower-nix

Nix files and Haskell overlay containing Ivory/Tower stack.

Compatible with GHC 8.10.1

## Development shell for `ivory-tower-helloworld`

Install [Nix](https://nixos.org/nix/) and run

```
nix-shell
```

to enter development shell for [ivory-tower-helloworld](https://github.com/distrap/ivory-tower-helloworld).

## Firmware builds

It's also possible to build firmware images for specific platform using

```
nix-build -A hello.simpleblink-test.f4disco.image
# or
nix-build -A hello.simpleblink-test.f4disco.runner
```

The triple is `firmware-project.appOrTestName.platform` and you can explore available
targets for `ivory-tower-helloworld` via `nix repl`, using `:l ./.` to load `default.nix` into scope and
entering `hello.<TAB>`.

## Other targets

### [hgdb](https://github.com/distrap/hgdb)

```
nix-build -A hgdb
```

### Full embedded image build

Builds `result/image` for default platform.

```
nix-build -A simpleblink
```

### Image for Bluepill

Builds `result/image` for `bluepill` platform (`STM32F103`).

```
nix-build -A simpleblink-bluepill
```

## Binary cache

Follow the instructions at https://ivory-tower-nix.cachix.org/

## Developing

To enter development shell for specific package it is possible to use e.g.

```
nix-shell -A ivorypkgs.ivory.env default.nix
```

to enter shell where `ivory` package can be built with `cabal`.
