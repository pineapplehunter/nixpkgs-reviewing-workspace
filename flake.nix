{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs =
    { self, nixpkgs }:
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
          default =
            with pkgs;
            mkShellNoCC {
              buildInputs = [
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
              ];
            };
        }
      );
    };
}
