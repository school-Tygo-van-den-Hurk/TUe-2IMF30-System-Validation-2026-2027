{
  perSystem = { pkgs, ... }: rec {
    devShells.default = devShells.development;
    devShells.development = pkgs.mkShell {
      buildInputs = with pkgs; [
        mcrl2
      ];
    };
  };
}
