{
  perSystem = { pkgs, self', ... }: {
    checks.properties =
      pkgs.runCommand "properties"
        {
          buildInputs = with self'.packages; [ mcrl2 ];
          meta.description = "Test all properties in src";
          src = ../src;
        }
        /* SHELL */ ''
          echo "Building lps from src"
          cp --recursive -- "$src"/* "$PWD"
          mcrl22lps src_spec.mcrl2 model.lps

          echo "Testing properties:"
          failures=0

          for property in properties/*.mcf; do
            name="''${property%.mcf}"
            name="''${name#properties/}"
            
            printf ' [????]: "%s"' "$name"
            
            if ! lps2pbes -f "$property" model.lps "$name.pbes"; then
              printf '\r [FAIL] "%s": could not generate PBES\n' "$name"
              failures=$((failures + 1))
              continue
            fi


            result="$(pbes2bool "$name.pbes")"

            if [ "$result" != "true" ]; then
                printf '\r [FAIL] "%s": property is not true\n' "$name"
                failures=$((failures + 1))
                continue
            fi

            printf '\r [PASS] "%s"\n' "$name"
          done

          if [ "$failures" -gt 0 ]; then
            echo "Total of $failures failure(s)!"
            exit 1
          fi

          touch "$out"
        '';
  };
}
