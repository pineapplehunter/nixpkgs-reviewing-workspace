{
  inputs = {
    # Prefer nixpkgs- rather than nixos- for darwin
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    selfup = {
      url = "github:kachick/selfup/v1.1.8";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      selfup,
      ...
    }:
    let
      inherit (nixpkgs) lib;
      forAllSystems = lib.genAttrs lib.systems.flakeExposed;
    in
    {
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShellNoCC {
            buildInputs =
              (with pkgs; [
                bashInteractive
                coreutils # mktemp
                nixfmt-rfc-style
                nil
                go-task

                dprint
                typos
                shfmt

                nixpkgs-review
                bubblewrap # Require to run nixpkgs-review with sandbox mode. See https://github.com/Mic92/nixpkgs-review/pull/441
                gh
                git
                tree
                fd

                (ruby_3_4.withPackages (ps: with ps; [ rubocop ]))
              ])
              ++ [
                selfup.packages.${system}.default
              ];
          };
        }
      );
    };
}
