VIM ?= vim

.PHONY: test
test:
	$(VIM) -Nu NONE -n -es -S test/cursor.vim
