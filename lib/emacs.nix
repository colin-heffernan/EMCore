{ emacs }:

let
	src = emacs;
in
	import ./generic.nix {
		version = "git";
		inherit src;
	}
