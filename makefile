# Makefile for resume compilation

.PHONY: all resume cover clean

# Default target - runs when 'make' is called without arguments
all: resume cover
	@echo "All documents compiled successfully!"

# Build resume
resume:
	@echo "Compiling resume..."
	cd resume && lualatex -interaction=nonstopmode main.tex && mv main.pdf ../resume.pdf
	@echo "Resume compilation complete!"

# Build cover
cover:
	@echo "Compiling cover..."
	cd cover && lualatex -interaction=nonstopmode main.tex && mv main.pdf ../cover.pdf
	@echo "Resume compilation complete!"

show:
	{ okular resume.pdf & okular cover.pdf & }

noshow:
	@pkill -f 'okular .*resume\.pdf' || true
	@pkill -f 'okular .*cover\.pdf' || true

# Clean resume directory
resume-clean:
	@echo "Cleaning up generated resume files..."
	@for ext in $$(grep '^\*\*\.' .gitignore | sed 's/^\*\*\.//'); do \
		if [ "$$ext" != "ttf" ]; then \
			echo "Removing *.$$ext files..."; \
			find ./resume -name "*.$$ext" -type f -delete; \
		fi; \
	done
	@echo "Cleanup complete!"

# Clean resume directory
cover-clean:
	@echo "Cleaning up generated cover files..."
	@for ext in $$(grep '^\*\*\.' .gitignore | sed 's/^\*\*\.//'); do \
		if [ "$$ext" != "ttf" ]; then \
			echo "Removing *.$$ext files..."; \
			find ./cover -name "*.$$ext" -type f -delete; \
		fi; \
	done
	@echo "Cleanup complete!"

# Clean up generated files in all directories
clean:
	@echo "Cleaning up generated files in all directories..."
	@for ext in $$(grep '^\*\*\.' .gitignore | sed 's/^\*\*\.//'); do \
		if [ "$$ext" != "ttf" ]; then \
			echo "Removing *.$$ext files..."; \
			find . -name "*.$$ext" -type f -delete; \
		fi; \
	done
	@echo "Cleanup complete!"
