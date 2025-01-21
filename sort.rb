module Sorter
  Nix = Data.define(:platform, :tier)
  Runner = Data.define(:arch, :os) do
    def asset_name
      "#{arch}-#{os}"
    end
  end

  # List of tiers: https://github.com/NixOS/nixpkgs/blob/nixos-24.11/lib/systems/flake-systems.nix
  NIX_BY_ASSET_NAME = {
    Runner.new(arch: 'X64', os: 'Linux').asset_name => Nix.new(platform: 'x86_64-linux', tier: 1),
    # Runner.new(arch: 'ARM64', os: 'Linux').asset_name => Nix.new(platform: 'aarch64-linux', tier: 2), # TODO: Adjust after GH-43
    Runner.new(arch: 'X64', os: 'macOS').asset_name => Nix.new(platform: 'x86_64-darwin', tier: 2),
    Runner.new(arch: 'ARM64', os: 'macOS').asset_name => Nix.new(platform: 'aarch64-darwin', tier: 3)
  }

  def self.extract_asset_name(path)
    path.split('/').detect { |tree| /\Anixpkgs-review-files-.+\z/.match?(tree) }.slice(Regexp.union(NIX_BY_ASSET_NAME.keys))
  end

  def self.priority(path)
    NIX_BY_ASSET_NAME.fetch(extract_asset_name(path)).tier
  end
end

puts(STDIN.each_line.map(&:chomp).sort_by { |path| Sorter.priority(path) })
