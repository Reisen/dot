
.PHONY: setup-dotfiles
setup-dotiles: link-files setup-vim
	@echo


.PHONY: link-files
link-files:
	@echo "[*] Linking Files"
	@tput setaf 4
	@find ${PWD}/ \
		-mindepth 1 \
		-name "*.link" \
		-exec ${PWD}/local/scripts/dotlink {} \;
	@tput sgr0


.PHONY: setup-vim
setup-vim:
	@echo "[*] Setting up Vim"
	@tput setaf 4
	@make --no-print-directory -C vim.link/ VIMDEPS=vim
	@tput sgr0
