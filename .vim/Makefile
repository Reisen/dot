.PHONY: nothing setup-vim install-vim setup-base setup-post clean clean-cache


ifeq (vim,$(findstring vim,${VIMDEPS}))
VIMCMD=${HOME}/.vim/dependencies/bin/vim
else ifneq (,$(wildcard ${HOME}/.vim/dependencies/bin/vim))
VIMCMD=${HOME}/.vim/dependencies/bin/vim
else
VIMCMD=vim
endif


# This rule chains all the others together, setting up the directory,
# performing post setup compilation, an anything else.
setup-vim: install-vim setup-base setup-post
	@echo "+ Finished Setup"



install-vim:
ifeq (vim,$(findstring vim,${VIMDEPS}))
	@mkdir -p ${HOME}/.vim
	@echo "+ Downloading Vim"
	@mkdir -p build/
	@curl -# -o build/vim-7.4.tar.bz2 "ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2"
	@echo "+ Downloading Patches"
	@wget -nd -q -r -np ftp://ftp.vim.org/pub/vim/patches/7.4/ -O build/patches
	@tar -C build/ -jxf build/vim-7.4.tar.bz2
	@echo "+ Applying Patches"
	@patch -p0 -d build/vim74/ < build/patches &> patchlog
	@echo "+ Configuring Vim (output in buildlog)"
	@cd build/vim74/ && ./configure \
		--prefix=${HOME}/.vim/dependencies \
		--with-features=huge \
		--enable-pythoninterp \
		--enable-python3interp \
		--enable-luainterp \
		--enable-rubyinterp \
		--enable-gui=gtk2 \
		--with-compiledby="Reisen <reisen@morphism.org>" &> buildlog
	@echo "+ Building Vim (output in buildlog)"
	@make -C build/vim74/ &>> buildlog
	@echo "+ Installing Vim locally in ~/.vim/ (output in buildlog)"
	@make -C build/vim74/ install &>> buildlog
	@rm -r build/
endif



# Setup the Vim Directory for a Fresh Install. Needed because there needs to be
# a backup folder to place all the files vim dumps. Also Vundle needs to be
# setup in order to get plugins working.
setup-base:
	@echo "+ Setting up Base Directories"
	@mkdir -p ${HOME}/.vim/bundle/
	@mkdir -p ${HOME}/.vim/backup/{view,swap,undo}
	@mkdir -p ${HOME}/.vim/dependencies/
	@cp -r ./ ${HOME}/.vim/
	@echo "+ Installing Vundle"
	@git clone https://github.com/gmarik/vundle.git ${HOME}/.vim/bundle/vundle
	@echo "+ Running Vim to install Vundle Packages"
	@${VIMCMD} +BundleInstall +qall



# Base setup is done at this point, so we have to build things that any of the
# plugins rely on.
setup-post:
	@echo "+ Building Dependencies"
	@make -C ${HOME}/.vim/bundle/vimproc.vim
	@git clone https://github.com/ggreer/the_silver_searcher ${HOME}/.vim/dependencies/ag
	@${HOME}/.vim/dependencies/ag/build.sh --prefix=${HOME}/.vim/dependencies
	@make -C ${HOME}/.vim/dependencies/ag/ install



# Reset to default state, to easily zip up and such.
clean:
	@echo "+ Cleaning Bundles"
	@rm -rf ${HOME}/.vim/bundle/
	@echo "+ Cleaning Backups"
	@rm -r ${HOME}/.vim/backup/
	@echo "+ Cleaning Dependencies"
	@rm -r ${HOME}/.vim/dependencies/



clean-cache:
	@echo "+ Cleaning Caches"
	@rm -rf ${HOME}/.vim/backup/
	@mkdir -p ${HOME}/.vim/backup/{view,swap,undo}
