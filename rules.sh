#!/bin/bash
#==============================================================================
# rules.sh
#
# DESCRIPTION:
#   Updates Cursor Project Kit rules by downloading the latest version from
#   the official GitHub repository. The script handles cross-platform support,
#   creates backups of existing rules, and provides detailed feedback during
#   the update process.
#
# REPOSITORY:
#   https://github.com/TheSethRose/Cursor-Project-Kit
#
# USAGE:
#   ./update-cursor-rules.sh
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

# Print an error message and exit
# Usage: error_exit "message" [exit_code]
error_exit() {
    local message="$1"
    local exit_code="${2:-$EXIT_FAILURE}"
    print_message "$RED" "ERROR: $message"
    exit "$exit_code"
}

# Clean up temporary resources
# Usage: cleanup
cleanup() {
    if [[ -n "$TEMP_DIR" && -d "$TEMP_DIR" ]]; then
        print_message "$YELLOW" "Cleaning up temporary files..."
        rm -rf "$TEMP_DIR"
    fi
}

# Set up trap to ensure cleanup on script exit
trap cleanup EXIT

#------------------------------------------------------------------------------
# MAIN SCRIPT
#------------------------------------------------------------------------------

# Determine operating system and set the base directory accordingly
print_message "$YELLOW" "Detecting operating system..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    BASE_DIR="$HOME"
    print_message "$GREEN" "Detected macOS"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    BASE_DIR="$HOME"
    print_message "$GREEN" "Detected Linux"
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    # Windows with Git Bash or similar
    print_message "$GREEN" "Detected Windows"
    if [[ -d "$HOME" ]]; then
        BASE_DIR="$HOME"
    elif [[ -d "$APPDATA" ]]; then
        BASE_DIR="$APPDATA"
    else
        error_exit "Could not determine home directory on Windows."
    fi
else
    error_exit "Unsupported operating system: $OSTYPE"
fi

# Set the rules directory path
RULES_DIR="$BASE_DIR/.cursor/rules"
print_message "$YELLOW" "Rules directory: $RULES_DIR"

# Create temporary directory for downloading repository
TEMP_DIR=$(mktemp -d)
if [[ ! -d "$TEMP_DIR" ]]; then
    error_exit "Failed to create temporary directory."
fi
print_message "$YELLOW" "Created temporary directory at $TEMP_DIR"

# Clone the repository with minimal depth for faster download
print_message "$YELLOW" "Cloning the Cursor Project Kit repository..."
if ! git clone --depth 1 --branch "$REPO_BRANCH" "$REPO_URL" "$TEMP_DIR/repo"; then
    error_exit "Failed to clone repository. Please check your internet connection and try again."
fi
print_message "$GREEN" "Repository cloned successfully."

# Create rules directory if it doesn't exist
if [[ ! -d "$RULES_DIR" ]]; then
    print_message "$YELLOW" "Creating rules directory at $RULES_DIR"
    if ! mkdir -p "$RULES_DIR"; then
        error_exit "Failed to create rules directory. Check permissions."
    fi
fi

# Backup existing rules if the directory is not empty
BACKUP_DIR=""
if [[ -d "$RULES_DIR" && "$(ls -A "$RULES_DIR" 2>/dev/null)" ]]; then
    BACKUP_DIR="$BASE_DIR/.cursor/rules_backup_$(date +%Y%m%d%H%M%S)"
    print_message "$YELLOW" "Backing up existing rules to $BACKUP_DIR"

    if ! mkdir -p "$BACKUP_DIR"; then
        error_exit "Failed to create backup directory."
    fi

    if ! cp -R "$RULES_DIR/"* "$BACKUP_DIR/" 2>/dev/null; then
        print_message "$YELLOW" "Warning: Some files could not be backed up."
    fi

    # Clean the rules directory to prepare for new files
    print_message "$YELLOW" "Cleaning existing rules directory..."
    rm -rf "$RULES_DIR/"*
fi

# Copy rules from the repository to the rules directory
print_message "$YELLOW" "Copying rules to $RULES_DIR..."
if [[ -d "$TEMP_DIR/repo/.cursor/rules" ]]; then
    if ! cp -R "$TEMP_DIR/repo/.cursor/rules/"* "$RULES_DIR/" 2>/dev/null; then
        # If copy fails, attempt to restore from backup
        print_message "$RED" "Failed to copy rules from repository."

        if [[ -n "$BACKUP_DIR" && -d "$BACKUP_DIR" ]]; then
            print_message "$YELLOW" "Restoring from backup..."
            if ! cp -R "$BACKUP_DIR/"* "$RULES_DIR/" 2>/dev/null; then
                error_exit "Failed to restore from backup."
            fi
            print_message "$GREEN" "Restored from backup."
        fi

        error_exit "Update failed."
    fi

    print_message "$GREEN" "Rules updated successfully!"

    # Remove backup if installation was successful
    if [[ -n "$BACKUP_DIR" && -d "$BACKUP_DIR" ]]; then
        print_message "$YELLOW" "Removing backup directory..."
        rm -rf "$BACKUP_DIR"
    fi
else
    print_message "$RED" "Rules directory not found in the repository."

    # Restore from backup if installation failed
    if [[ -n "$BACKUP_DIR" && -d "$BACKUP_DIR" ]]; then
        print_message "$YELLOW" "Restoring from backup..."
        if ! cp -R "$BACKUP_DIR/"* "$RULES_DIR/" 2>/dev/null; then
            error_exit "Failed to restore from backup."
        fi
        print_message "$GREEN" "Restored from backup."
    fi

    error_exit "Rules directory not found in the repository."
fi

# Display success message and instructions
print_message "$GREEN" "✅ Cursor Project Kit rules have been updated to the latest version."
print_message "$YELLOW" "Rules location: $RULES_DIR"
print_message "$GREEN" "Please restart Cursor to apply the changes."

exit $EXIT_SUCCESS
