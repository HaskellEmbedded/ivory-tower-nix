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
          cp build/image $out/
        '';
in
self: super:
{
  myHaskellPackages = super.myHaskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        mkImage = mkImage super;
      });
    });
}
