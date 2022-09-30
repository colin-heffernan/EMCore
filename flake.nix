{
	description = "EMCode Flake";

	inputs = {
		##### General Inputs
		# Nixpkgs
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		# Emacs 
		emacs = {
			url = "git+https://git.sv.gnu.org/git/emacs.git";
			flake = false;
		};
	};

	outputs = { self, nixpkgs, emacs, ... } @ inputs:
		let
			system = "x86_64-linux";
			pkgs = import nixpkgs {
				inherit system;
			};
			lib = import ./lib { inherit pkgs emacs inputs; };
			emacsBuilder = lib.emacsBuilder;
		in rec {
			apps.${system} = rec {
				emacs = {
					type = "app";
					program = "${packages.${system}.default}/bin/emacs";
				};
			};

			devShells.${system} = {
				default = pkgs.mkShell {
					buildInputs = [emacsBuilder pkgs.gtk3 pkgs.gsettings-desktop-schemas];
					shellHook = ''
						XDG_DATA_DIRS=$GSETTINGS_SCHEMA_PATH
					'';
				};
			};

			overlays.default = final: prev: rec {
				inherit emacsBuilder;
				emcode = packages.${system}.emcode;
			};

			packages.${system} = rec {
				default = emcode;
				emcode = emacsBuilder;
			};
		};
}
