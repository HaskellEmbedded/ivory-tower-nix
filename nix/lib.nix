let
  mkImage = super: exeName:
    { ivoryFlags ? ["--const-fold"]
    , defaultConf ? null
    , addName ? ""
    } @ args:
    pkg:
      let
        defConf = if isNull defaultConf then "${pkg.src}/default.conf" else defaultConf;
        iFlags = super.stdenv.lib.concatStringsSep " " ivoryFlags;
      in
      super.runCommand "${exeName}${addName}-image"
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

  mkRunner = super: image:
    { target ? "/dev/ttyACM0"
    , connectSRST ? "disable"
    } @ args:
    super.writeScriptBin "runner" ''
      ${super.gcc-arm-embedded}/bin/arm-none-eabi-gdb \
                      --ex "target extended-remote ${target}" \
                      --ex 'monitor connect_srst connectSRST' \
                      --ex 'monitor swdp_scan' \
                      --ex 'set mem inaccessible-by-default off' \
                      --ex 'attach 1' \
                      --ex 'load' \
                      --ex 'run' \
                      ${image}/image
    '';

  evalMakefile = super: src: var:
    let
      helperMakefile = incl: super.writeText "Makefile.print" ''
        include ${incl}
        print:
        	echo "[ $(foreach x,$(${var}),\"$(x)\") ]"
      '';
    in
    super.runCommand "eval-makefile" { buildInputs = [ super.gnumake ]; }
      ''
        mkdir $out
        make -s -f ${helperMakefile "${src}/Makefile" } print > $out/default.nix
        cat $out/default.nix
      '';

  evalPlatforms = super: src:
    super.runCommand "eval-platforms" { }
      ''
        mkdir $out
        echo '[' > $out/default.nix
        cat ${src}/default.conf | grep platform | sed 's/#*platform\s*=\s*/  /' >> $out/default.nix
        echo ']' >> $out/default.nix
        cat $out/default.nix
      '';

  inspect = super: src: {
    apps       = import (evalMakefile super src "APPS");
    tests      = import (evalMakefile super src "TESTS");
    posixTests = import (evalMakefile super src "POSIX_TESTS");
    platforms  = import (evalPlatforms super src);
  };

  genTargets = super: pkg:
    let
      ifd = inspect super pkg.src;
    in
    super.lib.genAttrs (ifd.apps ++ ifd.tests) (testName:
      super.lib.genAttrs (ifd.platforms) (platform:
        rec {
          imageConfig = extraConf: mkImage super testName
            { defaultConf = defaultConfPlatform super platform extraConf;
              addName = "-${platform}";
            } pkg;
          image = imageConfig "";
          runner = mkRunner super image {};
        }
      ));

  defaultConfPlatform = super: plat: extraConf:
    super.writeText "${plat}-platform" ''
      [args]
      platform = "${plat}"
      ${extraConf}
    '';

in
self: super:
{
  myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        mkRunner = mkRunner super;
        genTargets = genTargets super;
        defaultConfPlatform = defaultConfPlatform super;
        mkImage = mkImage super;
        mkSchema = mkSchema super hself;
      });
    });
}
