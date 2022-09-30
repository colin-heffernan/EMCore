{ pkgs, emacs, inputs, ... }:
{
	inherit (pkgs.lib);
	# emacsBuilder = let
	# 	myEmacs = pkgs.callPackage ./emacs.nix {
	# 		inherit emacs;
	# 	} {
	# 		inherit pkgs;
	# 		inherit (pkgs) lib;
	# 		libXaw = null;
	# 		libXft = null;
	# 		gconf = null;
	# 		alsa-lib = null;
	# 		acl = null;
	# 		gpm = null;
	# 	};
	# in
	# 	import ./emacsWithPackages.nix { inherit pkgs myEmacs; };
	# emacsBuilder = pkgs.callPackage ./emacs.nix {
	# 	inherit emacs;
	# } {
	# 	inherit pkgs;
	# 	inherit (pkgs) lib;
	# 	libXaw = null;
	# 	libXft = null;
	# 	gconf = null;
	# 	alsa-lib = null;
	# 	acl = null;
	# 	gpm = null;
	# };
	emacsBuilder = let
		inherit pkgs;
		myEmacs = pkgs.callPackage ./emacs.nix {
			inherit emacs;
		} {
			inherit pkgs;
			inherit (pkgs) lib;
			libXaw = null;
			libXft = null;
			gconf = null;
			alsa-lib = null;
			acl = null;
			gpm = null;
		};
	in
		import ./emacsWithPackages.nix { inherit pkgs myEmacs; };
}
