#!/bin/bash

# Create a favicon if it doesn't exist
FAVICON="favicon.ico"

if [ ! -f "$FAVICON" ]; then
    echo "Creating favicon.ico..."
    convert -size 32x32 xc:none "$FAVICON" # Requires ImageMagick
    echo "Favicon created."
else
    echo "favicon.ico already exists."
fi

# Update SCSS files to replace deprecated functions
# Change 'scss' to your actual SCSS directory if different
SCSS_DIR="assets"  # Update this if your SCSS files are in a different directory
SCSS_FILES=$(find "$SCSS_DIR" -name "*.scss")

if [ -z "$SCSS_FILES" ]; then
    echo "No SCSS files found in $SCSS_DIR."
else
    for FILE in $SCSS_FILES; do
        echo "Updating deprecated functions in $FILE..."

        # Replace lighten and darken functions
        sed -i.bak -E 's/lighten\(([^,]+), ([0-9]+)%\)/color.scale(\1, \2%)/g; s/darken\(([^,]+), ([0-9]+)%\)/color.scale(\1, -\2%)/g' "$FILE"

        echo "Updated $FILE. Backup created as $FILE.bak"
    done
fi

echo "All updates complete! Run 'bundle exec jekyll serve' to test your site."

