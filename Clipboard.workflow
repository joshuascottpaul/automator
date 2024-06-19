# Print to Clipbaord
# brew install pdftotext
#
# Print Plugin receives PDF files from the print system
#
# Get the PDF from the print job
pdf_path="$1"

# Check if the PDF path is received
echo "PDF path: $pdf_path" >> /tmp/print_to_clipboard_debug.log

# Ensure the PDF file exists
if [ ! -f "$pdf_path" ]; then
    echo "PDF file not found" >> /tmp/print_to_clipboard_debug.log
    exit 1
fi

# Convert the PDF to text using pdftotext with -layout option
text=$(/opt/homebrew/bin/pdftotext "$pdf_path" -)

# Check if text was extracted
if [ -z "$text" ]; then
    echo "Failed to extract text" >> /tmp/print_to_clipboard_debug.log
    exit 1
fi
echo "Extracted text: $text" >> /tmp/print_to_clipboard_debug.log

# Clean up the text (if needed)
text=$(echo "$text" | sed 's/^1$//')  # Remove the extra '1' if it appears alone

# Copy the text to the clipboard
echo "$text" | pbcopy

# Check if the text was copied to the clipboard
clipboard_content=$(pbpaste)
echo "Clipboard content: $clipboard_content" >> /tmp/print_to_clipboard_debug.log
