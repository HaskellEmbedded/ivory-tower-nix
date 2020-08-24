let
  mkImage = super: exeName:
    { ivoryFlags ? ["--const-fold"]
    , defaultConf ? null
    } @ args:
    pkg:
      let
        defConf = if isNull defaultConf then "${pkg.src}/default.conf" else defaultConf;
        iFlags = super.stdenv.lib.concatStringsSep " " ivoryFlags;
      in
      super.runCommand "${exeName}-image"
        { buildInputs = with super; [ gnumake gcc-arm-embedded ]; }
        ''
          cp ${defConf} default.conf
          echo "Building with ${iFlags}"
          ${pkg}/bin/${exeName}-gen --src-dir=build ${iFlags}
          make -C build
          mkdir $out
          cp ${defConf} $out/default.conf
          cp build/image $out/
        '';

  mkSchema = super: hself: schName: pkg: generatorPkg:
    let fakeRepo = super.runCommand "fakeRepo" {} ''
        mkdir $out
        ln -s ${hself.ivory-freertos-bindings.src} $out/ivory-freertos-bindings
        ln -s ${hself.tower-freertos-stm32.src}    $out/ivory-freertos-stm32
        ln -s ${hself.ivory-bsp-stm32.src}         $out/ivory-bsp-stm32
      '';
    in
    super.runCommand "${schName}-schema"
      { buildInputs = [ generatorPkg ]; }
      ''
        export IVORY_SRC=${hself.ivory.src}
        export TOWER_SRC=${hself.tower.src}
        export IVORY_TOWER_STM32_SRC=${fakeRepo}
        export IVORY_TOWER_CANOPEN_SRC=${hself.ivory-tower-canopen-src}
        cp ${pkg}/Makefile .
        make

        mkdir $out
        cp -a ${schName}-schema-native $out/ || true # XXX: lambdadrive doesn't have native enabled (yet)
        cp -a ${schName}-schema-tower  $out/
      '';
in
self: super:
{
  myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        mkImage = mkImage super;
        mkSchema = mkSchema super hself;
      });
    });
}
