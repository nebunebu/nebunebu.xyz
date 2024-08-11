{
  description = "personal blog";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
  };

  outputs =
    inputs:
    let
      forAllSystems = inputs.nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];
    in
    {
      checks = { };

      devShells = forAllSystems (
        system:
        let
          pkgs = inputs.nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            name = "devShell";
            packages = builtins.attrValues {
              inherit (pkgs)
                quarto
                prettierd
                stylelint
                # stylelint-lsp
                ;

              # vimPlugins.quarto-nvim
            };
          };
        }
      );
    };
}
