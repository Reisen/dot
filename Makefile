
.PHONY: setup-dotfiles
setup-dotiles: link-files setup-vim
	@echo "[*] Done"


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
	@make -C vim.link/
