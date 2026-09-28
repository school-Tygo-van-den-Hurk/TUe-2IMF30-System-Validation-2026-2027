{
  perSystem = { pkgs, self', ... }: rec {
    packages.mcrl2 = pkgs.mcrl2;
    packages.typst = pkgs.typst;

    packages.report = pkgs.stdenv.mkDerivation rec {
      name = "report.pdf";

      src = ../report;

      nativeBuildInputs = with self'.packages; [
        typst
      ];

      buildPhase = /* Shell */ ''
        runHook preBuild
        typst compile main.typ "$name"
        runHook postBuild
      '';

      installPhase = /* Shell */ ''
        runHook preInstall
        cp "$name" "$out"
        runHook postInstall
      '';
    };
  };
}
