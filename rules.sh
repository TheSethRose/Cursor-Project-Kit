#!/bin/bash
#==============================================================================
# rules.sh
#
# DESCRIPTION:
#   Installs or updates Cursor Project Kit rules by downloading the latest
#   version from the official GitHub repository. The script installs rules
#   to the current directory and provides clear feedback during the process.
#
# REPOSITORY:
#   https://github.com/TheSethRose/Cursor-Project-Kit
#
# USAGE:
#   ./rules.sh
#
# AUTHOR:
#   Seth Rose
#==============================================================================

#------------------------------------------------------------------------------
# CONFIGURATION
#------------------------------------------------------------------------------

# Terminal color codes for better readability
GREEN='\033[0;32m'  # Success messages
YELLOW='\033[1;33m' # Information/warning messages
RED='\033[0;31m'    # Error messages
BLUE='\033[0;34m'   # Highlight messages
BOLD='\033[1m'      # Bold text
NC='\033[0m'        # Reset color (No Color)

# GitHub repository information
REPO_URL="https://github.com/TheSethRose/Cursor-Project-Kit.git"
REPO_BRANCH="main"

# Exit codes
EXIT_SUCCESS=0
EXIT_FAILURE=1

#------------------------------------------------------------------------------
# FUNCTIONS
#------------------------------------------------------------------------------

# Print a formatted message with color
# Usage: print_message "color" "message"
print_message() {
    local color="$1"
    local message="$2"
    echo -e "${color}${message}${NC}"
}

# Print a step message with emoji
# Usage: print_step "emoji" "message"
print_step() {
    local emoji="$1"
    local message="$2"
    echo -e "${BLUE}${BOLD}${emoji} ${message}${NC}"
}

# Print an error message and exit
# Usage: error_exit "message" [exit_code]
error_exit() {
    local message="$1"
    local exit_code="${2:-$EXIT_FAILURE}"
    print_message "$RED" "❌ ERROR: $message"
    exit "$exit_code"
}

# Clean up temporary resources
# Usage: cleanup
cleanup() {
    if [[ -n "$TEMP_DIR" && -d "$TEMP_DIR" ]]; then
        print_step "🧹" "Cleaning up temporary files..."
        rm -rf "$TEMP_DIR"
    fi
}

# Set up trap to ensure cleanup on script exit
trap cleanup EXIT

#------------------------------------------------------------------------------
# MAIN SCRIPT
#------------------------------------------------------------------------------

# Set the rules directory to the current directory
RULES_DIR="./.cursor/rules"
print_step "📂" "Installing rules to: $(pwd)${RULES_DIR#.}"

# Create temporary directory for downloading repository
TEMP_DIR=$(mktemp -d)
if [[ ! -d "$TEMP_DIR" ]]; then
    error_exit "Failed to create temporary directory."
fi
print_step "📥" "Created temporary directory"

# Clone the repository with minimal depth for faster download
print_step "🔄" "Downloading Cursor Project Kit..."
if ! git clone --quiet --depth 1 --branch "$REPO_BRANCH" "$REPO_URL" "$TEMP_DIR/repo"; then
    error_exit "Failed to clone repository. Please check your internet connection and try again."
fi
print_message "$GREEN" "✅ Download complete"

# Create rules directory if it doesn't exist
if [[ ! -d "$RULES_DIR" ]]; then
    print_step "🔨" "Creating rules directory"
    if ! mkdir -p "$RULES_DIR"; then
        error_exit "Failed to create rules directory. Check permissions."
    fi
fi

# Backup existing rules if the directory is not empty
BACKUP_DIR=""
if [[ -d "$RULES_DIR" && "$(ls -A "$RULES_DIR" 2>/dev/null)" ]]; then
    BACKUP_DIR="./cursor_rules_backup_$(date +%Y%m%d%H%M%S)"
    print_step "💾" "Backing up existing rules to $BACKUP_DIR"

    if ! mkdir -p "$BACKUP_DIR"; then
        error_exit "Failed to create backup directory."
    fi

    if ! cp -R "$RULES_DIR/"* "$BACKUP_DIR/" 2>/dev/null; then
        print_message "$YELLOW" "⚠️ Warning: Some files could not be backed up."
    fi

    # Clean the rules directory to prepare for new files
    print_step "🧹" "Preparing rules directory..."
    rm -rf "$RULES_DIR/"*
fi

# Copy rules from the repository to the rules directory
print_step "📋" "Installing rules..."
if [[ -d "$TEMP_DIR/repo/.cursor/rules" ]]; then
    if ! cp -R "$TEMP_DIR/repo/.cursor/rules/"* "$RULES_DIR/" 2>/dev/null; then
        # If copy fails, attempt to restore from backup
        print_message "$RED" "❌ Failed to copy rules from repository."

        if [[ -n "$BACKUP_DIR" && -d "$BACKUP_DIR" ]]; then
            print_step "🔄" "Restoring from backup..."
            if ! cp -R "$BACKUP_DIR/"* "$RULES_DIR/" 2>/dev/null; then
                error_exit "Failed to restore from backup."
            fi
            print_message "$GREEN" "✅ Restored from backup."
        fi

        error_exit "Installation failed."
    fi

    print_message "$GREEN" "✅ Rules installed successfully!"

    # Remove backup if installation was successful
    if [[ -n "$BACKUP_DIR" && -d "$BACKUP_DIR" ]]; then
        print_step "🧹" "Cleaning up backup..."
        rm -rf "$BACKUP_DIR"
    fi
else
    print_message "$RED" "❌ Rules directory not found in the repository."

    # Restore from backup if installation failed
    if [[ -n "$BACKUP_DIR" && -d "$BACKUP_DIR" ]]; then
        print_step "🔄" "Restoring from backup..."
        if ! cp -R "$BACKUP_DIR/"* "$RULES_DIR/" 2>/dev/null; then
            error_exit "Failed to restore from backup."
        fi
        print_message "$GREEN" "✅ Restored from backup."
    fi

    error_exit "Rules directory not found in the repository."
fi

# Add rules directory to .gitignore if it exists, or create a new one
print_step "📝" "Updating .gitignore..."
if [[ -f ".gitignore" ]]; then
    # Check if .cursor/rules is already in .gitignore
    if ! grep -q "^\.cursor/rules" ".gitignore"; then
        echo -e "\n# Cursor Project Kit rules\n.cursor/rules/" >> ".gitignore"
        print_message "$GREEN" "✅ Added rules directory to existing .gitignore"
    else
        print_message "$GREEN" "✅ Rules directory already in .gitignore"
    fi
else
    # Create new .gitignore file
    echo -e "# Cursor Project Kit rules\n.cursor/rules/" > ".gitignore"
    print_message "$GREEN" "✅ Created .gitignore with rules directory"
fi

# Display success message and instructions
echo ""
print_message "$GREEN" "🎉 ${BOLD}Cursor Project Kit rules have been successfully installed!${NC}"
print_message "$BLUE" "📍 ${BOLD}Location:${NC} $(pwd)${RULES_DIR#.}"
echo ""
print_message "$YELLOW" "💝 ${BOLD}Support:${NC} If you find this tool valuable, please consider supporting the developer at:"
print_message "$BLUE" "      https://github.com/sponsors/TheSethRose"
echo ""

exit $EXIT_SUCCESS
