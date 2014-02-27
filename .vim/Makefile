.PHONY: setup-vim setup-base setup-post clean-cache clean

# This rule chains all the others together, setting up the directory, performing
# post setup compilation, an anything else.
setup-vim: setup-base setup-post
	@echo "+ Finished Setup"



# Setup the Vim Directory for a Fresh Install. Needed because there needs to be
# a backup folder to place all the files vim dumps. Also Vundle needs to be
# setup in order to get plugins working.
setup-base:
	@echo "+ Installing Vundle"
	@mkdir bundle/
	@git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
	@echo "+ Setting up Backup Directory"
	@mkdir -p backup/{view,swap,undo}
	@echo "+ Running Vim to install Vundle Packages"
	@vim +BundleInstall +qall



# Base setup is done at this point, so we have to build things that any of the
# plugins rely on.
setup-post:
	@echo "+ Building Dependencies"
	@make -C bundle/vimproc.vim
	@mkdir -p dependencies/
	@git clone https://github.com/ggreer/the_silver_searcher ~/.vim/dependencies/ag
	@./dependencies/ag/build.sh --prefix=${HOME}/.vim/dependencies
	@make -C dependencies/ag/ install



# Reset to default state, to easily zip up and such.
clean:
	@echo "+ Cleaning Bundles"
	@rm -rf bundle/
	@echo "+ Cleaning Backups"
	@rm -rf backup/
	@echo "+ Cleaning Dependencies"
	@rm -rf dependencies/



clean-cache:
	@echo "+ Cleaning Caches"
	@rm -rf backup/
	@mkdir -p backup/{view,swap,undo}
