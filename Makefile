
.PHONY: setup-dotfiles
setup-dotiles: link-files
	@echo "[*] Done"


.PHONY: link-files setup-vim
link-files:
	@echo "[*] Linking Files"
	@tput setaf 4
	@find ${PWD}/ \
		-mindepth 1 \
		-name "*.link" \
		-exec ${PWD}/local/scripts/dotlink {} \;
	@tput sgr0


.PHONY: setup-vim
	@echo "[*] Setting up Vim"
	@tput setaf 4
	@make -C vim.link/
	@tput sgr0
