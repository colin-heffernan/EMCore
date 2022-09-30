# EMCode

This is just a custom build of GNU Emacs with some plugins. It's meant for NixOS, and I'm not entirely sure if it'll work anywhere else.


# Installation

## NixOS

Installing on NixOS is easy. Add EMCode to your Flake inputs, add the overlay to your Nixpkgs overlays, and install the package.
`flake.nix`
```nix
{
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		emcode = {
			url = "github:colin-heffernan/EMCode";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};
	outputs = { self, nixpkgs, emcode, ... } @ inputs:
		let
			system = "x84_64-linux";
			pkgs = import nixpkgs {
				inherit system;
				overlays = [
					emcode.overlays.default
				];
			};
		in {
			nixosConfigurations = {
				username = lib.nixosSystem {
					inherit system pkgs;
					modules = [
						./configuration.nix
					];
				};
			};
		};
}
```
`configuration.nix`
```nix
{ config, pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		emcode
	];
}
```


# License

EMCode is licensed under the MIT License.
