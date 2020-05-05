echo "Hello Milad. You're in"

#############################
## Shell options (shopt)
#############################
shopt -s cdspell	# Ignore minor typos when using `cd`


# Load all fragments
for file in ~/.{path*,exports*,aliases*,functions*}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

tput smkx
