# Check if the new Vim has already been built and installed, if it has then the
# stage where we setup the Vim addons can use the new vim instead of the
# currently installed Vim.
# ------------------------------------------------------------------------------
ifeq (vim,$(findstring vim,${VIMDEPS}))
VIMCMD=${HOME}/.dot/local/bin/vim
else ifneq (,$(wildcard ${HOME}/.dot/local/bin/vim))
VIMCMD=${HOME}/.dot/local/bin/vim
else
VIMCMD=vim
endif


# This rule chains all the others together, setting up the directory,
# performing post setup compilation, an anything else.
# ------------------------------------------------------------------------------
.PHONY: setup-vim
.NOTPARALLEL: setup-vim
setup-vim: install-vim setup-base setup-post
	@echo "+ Finished Setup"



# Build and install Vim from the Mercurial repo (already patched up).
# ------------------------------------------------------------------------------
.PHONY: install-vim
.NOTPARALLEL: install-vim
install-vim:
ifeq (vim,$(findstring vim,${VIMDEPS}))
	@echo "  git clone vim"
	@mkdir -p build/
	@git clone "https://github.com/vim/vim.git" build/vim74 > /dev/null 2>&1
	@echo "  configure --prefix=${HOME}/.dot/local/"
	@cd build/vim74/ && ./configure \
		--prefix=${HOME}/.dot/local \
		--with-features=huge \
		--enable-pythoninterp \
		--enable-luainterp \
		--with-compiledby="Reisen <reisen@morphism.org>" > buildlog 2>&1
	@echo "  make -C build/vim74/"
	@make --no-print-directory -C build/vim74/ >> buildlog 2>&1
	@echo "  make -C build/vim74/ install"
	@make --no-print-directory -C build/vim74/ install >> buildlog 2>&1
endif



# Setup the Vim Directory for a Fresh Install. Needed because there needs to be
# a backup folder to place all the files vim dumps. Also Vundle needs to be
# setup in order to get plugins working.
# ------------------------------------------------------------------------------
.PHONY: setup-base
.NOTPARALLEL: setup-base
setup-base:
	@echo "  mkdir -p .vim/..."
	@mkdir -p autoload/
	@mkdir -p backup/{view,swap,undo}
	@echo "  wget plug.vim"
	@wget --quiet "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" -O autoload/plug.vim
	@echo "  vim +PlugInstall +qall"
	@${VIMCMD} +PlugInstall +qall



# Base setup is done at this point, so we have to build things that any of the
# plugins rely on.
# ------------------------------------------------------------------------------
.PHONY: setup-post
.NOTPARALLEL: setup-post
setup-post:
	#@echo "  make -C bundle/vimproc.vim"
	#@make --no-print-directory -C bundle/vimproc.vim &>/dev/null
	#@echo "  git clone the_silver_searcher"
	#@git clone https://github.com/ggreer/the_silver_searcher ${HOME}/.dot/local/ag &>/dev/null
	#@echo "  make the_silver_searcher"
	#@${HOME}/.dot/local/ag/build.sh --prefix=${HOME}/.dot/local/ &>/dev/null
	#@echo "  make install the_silver_searcher"
	#@make --no-print-directory -C ${HOME}/.dot/local/ag/ install &>/dev/null
	#@echo "  YouCompleteMe/install.sh"
	#@cd bundle/YouCompleteMe && ./install.sh &>/dev/null



# Reset to default state, to easily zip up and such.
# ------------------------------------------------------------------------------
.PHONY: clean
.NOTPARALLEL: clean
clean:
	@echo "+ Cleaning Bundles"
	@rm -rf ${HOME}/.vim/bundle/
	@echo "+ Cleaning Backups"
	@rm -r ${HOME}/.vim/backup/
	@echo "+ Cleaning Dependencies"
	@rm -r ${HOME}/.vim/dependencies/



.PHONY: clean-cache
.NOTPARALLEL: clean-cache
clean-cache:
# ------------------------------------------------------------------------------
	@echo "+ Cleaning Caches"
	@rm -rf ${HOME}/.vim/backup/
	@mkdir -p ${HOME}/.vim/backup/{view,swap,undo}
