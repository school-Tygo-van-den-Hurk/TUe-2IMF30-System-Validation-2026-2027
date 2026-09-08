{
  perSystem = { pkgs, ... }: rec {
    packages.mcrl2 = pkgs.mcrl2;

    packages.document = pkgs.stdenv.mkDerivation rec {
      name = "document.pdf";

      src = ../report;

      nativeBuildInputs = with pkgs; [ typst ];

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
