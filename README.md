# Cursor Project Kit

![Cursor Project Kit](https://img.shields.io/badge/Cursor-Project_Kit-blue?style=for-the-badge&logo=cursor&logoColor=white)

Enhance your Cursor AI assistant with specialized modes and configurations that help you build better software faster. The Cursor Project Kit provides a collection of rules that transform Cursor into a powerful, context-aware development partner.

## 🚀 Quick Installation

Install Cursor Project Kit rules to your current project with a single command:

```bash
curl -fsSL https://raw.githubusercontent.com/TheSethRose/Cursor-Project-Kit/main/rules.sh | bash
```

## ✨ Features

- **Developer Assistant Mode**: Get consistent, well-structured responses for all coding tasks
- **Specialized Modes**: Access expert-level assistance for specific tasks like architecture design, debugging, and code review
- **Project-Aware**: Configure rules to understand your project's specific requirements and conventions
- **Easy Installation**: Simple script that handles everything automatically
- **Team-Friendly**: Share the installation script with your team while keeping configurations local

## 📋 Installation Options

### Automatic Installation

The quickest way to install is using the curl command above, which downloads and runs the installation script in one step.

### Manual Installation

If you prefer more control, you can:

1. Download the `rules.sh` script:
   ```bash
   curl -O https://raw.githubusercontent.com/TheSethRose/Cursor-Project-Kit/main/rules.sh
   ```

2. Make it executable:
   ```bash
   chmod +x rules.sh
   ```

3. Run the script:
   ```bash
   ./rules.sh
   ```

### What the Script Does

The `rules.sh` script:

- Creates a `.cursor/rules` directory in your current project
- Downloads the latest rules from the official repository
- Backs up any existing rules before replacing them
- Automatically adds the rules directory to your `.gitignore` file
- Provides clear, emoji-enhanced feedback throughout the process

## 🤝 Sharing with Your Team

The rules directory (`.cursor/rules/`) is automatically added to `.gitignore` to prevent it from being committed to your repository. Instead, share the `rules.sh` script with your team members:

```bash
# Add the script to your repository
git add rules.sh
git commit -m "Add Cursor Project Kit installation script"
```

Each team member can then run the script in their local copy of the project to install the rules.

## 🧠 Using Cursor Rules

### Developer Assistant Mode

The Developer Assistant mode is always active and serves as the foundation for all interactions. Every response from Cursor will begin with "### 💻 Developer Assistant" followed by a concise plan outlining the approach to your request.

### Accessing Specialized Modes

To access specialized modes, explicitly ask Cursor to enter a specific mode:

```
Enter Architect Mode and help me design a system for...
```

Cursor will respond by announcing the mode transition:

```
#### [Entering Architect Mode]
```

### Available Specialized Modes

#### System Design
- **Planner Mode**: Map the full scope of work needed before implementation
- **PRD Analyst Mode**: Translate product requirements into technical specifications
- **Architect Mode**: Design system architecture with explicit component boundaries
- **Database Design Mode**: Design database schemas and optimization strategies
- **API Design Mode**: Design well-structured, secure, and efficient APIs

#### Implementation
- **UI and Frontend Mode**: Implement accessible, responsive user interfaces
- **Refactoring Mode**: Restructure code for improved quality
- **Security Auditor Mode**: Identify and fix security vulnerabilities
- **Performance Optimization Mode**: Resolve performance bottlenecks
- **Debugger Mode**: Systematically diagnose and resolve technical issues

#### Operations and Documentation
- **Code Review Mode**: Analyze code quality with specific recommendations
- **Documentation Mode**: Create comprehensive technical documentation
- **DevOps Mode**: Implement deployment automation and infrastructure management
- **Github Mode**: Manage version control workflows with precise Git commands

## 🛠️ Customization

You can customize these rules to better fit your project's needs:

1. Edit files in the `.cursor/rules` directory
2. Fill out the Project Configuration template with your project details
3. Create new specialized modes for your specific domains

## 💝 Support the Developer

If you find the Cursor Project Kit valuable for your development workflow, please consider supporting the developer:

[![GitHub Sponsors](https://img.shields.io/badge/sponsor-30363D?style=for-the-badge&logo=GitHub-Sponsors&logoColor=#EA4AAA)](https://github.com/sponsors/TheSethRose)

Your support helps maintain and improve these tools for the entire community.

## 📄 License

This project is available under the MIT License. See the LICENSE file for more details.
