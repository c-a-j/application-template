# justfile for resume compilation


# Default target - runs when 'just' is called without arguments
all: resume cover
	echo "All documents compiled successfully!"

# Build resume
resume:
	echo "Compiling resume..."
	cd resume && lualatex -interaction=nonstopmode main.tex && mv main.pdf ../resume.pdf
	echo "Resume compilation complete!"

# Build cover
cover:
	echo "Compiling cover..."
	cd cover && lualatex -interaction=nonstopmode main.tex && mv main.pdf ../cover.pdf
	echo "Resume compilation complete!"

# Open resume and cover pdfs
show:
	{ okular resume.pdf & okular cover.pdf & }

# Close resume and cover pdfs
noshow:
	pkill -f 'okular .*resume\.pdf' || true
	pkill -f 'okular .*cover\.pdf' || true

# Clean resume directory
clean-resume:
	echo "Cleaning up generated resume files..."
	for ext in $(grep '^\*\*\.' .gitignore | sed 's/^\*\*\.//'); do \
		if [ "$ext" != "ttf" ]; then \
			echo "Removing *.$$ext files..."; \
			find ./resume -name "*.$$ext" -type f -delete; \
		fi; \
	done
	echo "Cleanup complete!"

# Clean cover directory
clean-cover:
	echo "Cleaning up generated cover files..."
	for ext in $(grep '^\*\*\.' .gitignore | sed 's/^\*\*\.//'); do \
		if [ "$ext" != "ttf" ]; then \
			echo "Removing *.$$ext files..."; \
			find ./cover -name "*.$$ext" -type f -delete; \
		fi; \
	done
	echo "Cleanup complete!"

# Clean up generated files in all directories
clean:
	echo "Cleaning up generated files in all directories..."
	for ext in $(grep '^\*\*\.' .gitignore | sed 's/^\*\*\.//'); do \
		if [ "$ext" != "ttf" ]; then \
			echo "Removing *.$$ext files..."; \
			find . -name "*.$$ext" -type f -delete; \
		fi; \
	done
	echo "Cleanup complete!"

# Create an archive
archive archive_name:
	./archive.sh -c "{{archive_name}}"

# Extract an archive in archives
extract archive_name:
	./archive.sh -x "{{archive_name}}"