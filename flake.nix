{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    # Don't use this is GitHub Actions
    nixpkgs-review = {
      url = "github:Mic92/nixpkgs-review";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    selfup = {
      url = "github:kachick/selfup/v1.1.7";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-review,
      selfup,
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
                findutils # xargs
                coreutils # mktemp
                nixfmt-rfc-style
                nil
                go-task

                dprint
                typos

                # nixpkgs-review # TODO: Enable since updated to https://github.com/Mic92/nixpkgs-review/commit/055465e55d131ffb1e1617f46d3bade0b87bbe69 or higher
                gh
                git
                tree
                fd
              ])
              ++ [
                nixpkgs-review.packages.${system}.default
                selfup.packages.${system}.default
              ];
          };
        }
      );
    };
}
