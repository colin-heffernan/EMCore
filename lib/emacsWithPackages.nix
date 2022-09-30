{ pkgs, myEmacs, ... }:
let
	inherit myEmacs;
	emacsWithPackages = (pkgs.emacsPackagesFor myEmacs).emacsWithPackages;
in
	emacsWithPackages (epkgs: (with epkgs.melpaPackages; [
		all-the-icons
		centaur-tabs
		dashboard
		doom-modeline
		doom-themes
		evil
		evil-collection
		general
		magit
		neotree
		projectile
		tree-sitter
	]) ++ (with epkgs.elpaPackages; [
		consult
		hydra
		marginalia
		vertico
	]) ++ (with epkgs; [
		tree-sitter-langs
		# (tree-sitter-langs.withPlugins(p: tree-sitter-langs.plugins ++ [
		# 	p.tree-sitter-bash
		# ]))
	]))
