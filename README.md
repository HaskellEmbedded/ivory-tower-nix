# ivory-tower-nix

Nix files and Haskell overlay containing Ivory/Tower stack.

Compatible with GHC 8.6.5 and 8.8.1

## Usage

Install [Nix](https://nixos.org/nix/) and run

```
nix-shell
```

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

Builds `result/image` for `bluepill` platform (STM32F103).

```
nix-build -A simpleblink-bluepill
```


