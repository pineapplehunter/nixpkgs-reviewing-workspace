{ pkgs, ... }:
pkgs.writeShellApplication rec {
  name = "review";
  text = builtins.readFile ./${name}.bash;
  runtimeInputs = with pkgs; [
    coreutils # sleep
    gh
    (pkgs.callPackage ../resume/package.nix { })
  ];
  meta = {
    description = "Run nixpkgs-review in GHA";
  };
}
