{
  description = "A devShell example";

  inputs = {
    nixpkgs.url      = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url  = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
      in
      {
        devShells.default = with pkgs; mkShell {
          buildInputs = [
            openssl
            pkg-config
            nushell
            rust-bin.stable.latest.default
            cmake
            clang
            SDL2
            SDL2.dev
            SDL2_ttf
            SDL2_net
            SDL2_net.dev
            SDL2_gfx
            SDL2_gfx.dev
            SDL2_sound
            SDL2_mixer
            SDL2_mixer.dev
            SDL2_image
          ];

        };
      }
    );
}