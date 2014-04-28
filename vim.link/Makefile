# Check if the new Vim has already been built and installed, if it has then the
# stage where we setup the Vim addons can use the new vim instead of the
# currently installed Vim.
# ------------------------------------------------------------------------------
ifeq (vim,$(findstring vim,${VIMDEPS}))
VIMCMD=${HOME}/.vim/dependencies/bin/vim
else ifneq (,$(wildcard ${HOME}/.vim/dependencies/bin/vim))
VIMCMD=${HOME}/.vim/dependencies/bin/vim
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
	@echo "  hg clone vim74"
	@mkdir -p build/
	@hg clone https://vim.googlecode.com/hg/ build/vim74 &>/dev/null
	@echo "  configure --prefix=${HOME}/.dot/local/scripts"
	@cd build/vim74/ && ./configure \
		--prefix=${HOME}/.dot/local/scripts \
		--with-features=huge \
		--enable-pythoninterp \
		--enable-luainterp \
		--with-compiledby="Reisen <reisen@morphism.org>" &> buildlog
	@echo "  make -C build/vim74/"
	@make -C build/vim74/ &>> buildlog
	@echo "  make -C build/vim74/ install"
	@make -C build/vim74/ install &>> buildlog
	@rm -r build/
endif



# Setup the Vim Directory for a Fresh Install. Needed because there needs to be
# a backup folder to place all the files vim dumps. Also Vundle needs to be
# setup in order to get plugins working.
# ------------------------------------------------------------------------------
.PHONY: setup-base
.NOTPARALLEL: setup-base
setup-base:
	@echo "  mkdir -p .vim/..."
	@mkdir -p vim.link/bundle/
	@mkdir -p vim.link/backup/{view,swap,undo}
	@mkdir -p vim.link/dependencies/
	@echo "  git clone vundle.git"
	@git clone https://github.com/gmarik/vundle.git vim.link/bundle/vundle
	@echo "  vim +VundleInstall +qall"
	@${VIMCMD} +VundleInstall +qall



# Base setup is done at this point, so we have to build things that any of the
# plugins rely on.
# ------------------------------------------------------------------------------
.PHONY: setup-post
.NOTPARALLEL: setup-post
setup-post:
	@echo "+ Building Dependencies"
	@make -C vim.link/bundle/vimproc.vim
	@git clone https://github.com/ggreer/the_silver_searcher vim.link/local/scripts/ag
	@./vim.link/local/scripts/ag/build.sh --prefix=${HOME}/.dot/vim.link/local/scripts
	@make -C vim.link/local/scripts/ag/ install



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
