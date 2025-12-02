{
  description = "Environnement de dev pour Quickshell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell?rev=d24e8e9736287d01ee73ef9d573d2bc316a62d5c";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, quickshell }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      qsPackage = quickshell.packages.${system}.default;
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          qt6.qtdeclarative
          qt6.qtlanguageserver
          qt6.qtwayland
          qsPackage
        ];

        # C'est LA ligne magique qui fixe les warnings
        shellHook = ''
          export QML_IMPORT_PATH="${pkgs.qt6.qtdeclarative}/lib/qt6/qml:${pkgs.qt6.qtwayland}/lib/qt6/qml:${qsPackage}/lib/qt6/qml"
          export QML2_IMPORT_PATH="$QML_IMPORT_PATH"

          echo "[General]" > .qmlls.ini
          echo "buildDir=." >> .qmlls.ini
          echo "importPaths=$QML_IMPORT_PATH" >> .qmlls.ini
        '';
      };
    };
}
