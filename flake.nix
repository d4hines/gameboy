{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      devShell = with pkgs;
        mkShell {
          packages =
            [
              alejandra
              # Rust
              cargo
              rustc
              rust-analyzer
              libiconv
            ]
            ++ (with darwin.apple_sdk.frameworks; [
              Cocoa
              AppKit
              MetalKit
              AVFoundation
            ]);
        };
    });
}
