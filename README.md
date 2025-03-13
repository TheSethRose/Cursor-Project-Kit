# Cursor Rules

This directory contains custom rules for enhancing the Cursor AI assistant's capabilities. These rules define specialized modes and configurations that help the AI better understand your project and provide more targeted assistance.

## What Are Cursor Rules?

Cursor rules are markdown files with a `.mdc` extension that provide instructions to the Cursor AI assistant. They can be:

1. **Always Applied**: Rules that are always active and provide general guidance
2. **Conditionally Applied**: Rules that are only applied when explicitly requested or when working with specific file types

## How to Use These Rules

### Expert Developer Mode

The Expert Developer mode (`1.0-expert-developer.mdc`) is always active and serves as the foundation for all interactions. It provides a consistent approach to code organization, style, and implementation.

To access specialized modes, simply ask the AI to enter a specific mode:

```
Enter Architect Mode and help me design a system for...
```

### Project Configuration

The Project Configuration template (`1.1-project-configuration.mdc`) allows you to provide project-specific details that the AI can reference. To use it:

1. Fill in the empty fields with your project details
2. Save the file
3. The AI will automatically use this information when providing assistance

If left blank, this configuration will be ignored.

## Available Specialized Modes

### System Design
- **2.1 Planner Mode**: For analyzing changes and mapping the full scope of work needed before implementation
- **2.2 PRD Analyst Mode**: For extracting, analyzing, and translating product requirements into technical specifications
- **2.3 Architect Mode**: For designing system architecture with explicit component boundaries, interfaces, and performance characteristics
- **2.4 Database Design Mode**: For designing database schemas, optimization strategies, and data migration paths
- **2.14 API Design Mode**: For designing and implementing APIs with a focus on architecture, security, performance, and documentation

### Implementation
- **2.5 UI and Frontend Mode**: For implementing accessible, responsive, and functionally robust user interfaces
- **2.7 Refactoring Mode**: For restructuring code for improved quality while maintaining functional equivalence
- **2.8 Security Auditor Mode**: For identifying security vulnerabilities and implementing protection measures
- **2.9 Performance Optimization Mode**: For identifying and resolving performance bottlenecks
- **2.10 Debugger Mode**: For systematically diagnosing and resolving technical issues

### Operations and Documentation
- **2.6 Code Review Mode**: For analyzing code quality with specific recommendations and implementation examples
- **2.11 Documentation Mode**: For creating technical documentation with precise API specifications and examples
- **2.12 DevOps Mode**: For implementing deployment automation, infrastructure management, and operational monitoring
- **2.13 Github Mode**: For managing version control workflows with precise Git commands and PR documentation

## Customizing Rules

You can customize these rules to better fit your project's needs:

1. Modify existing rules to align with your team's practices
2. Create new specialized modes for specific domains or technologies
3. Update the Project Configuration with your project's details

## File Structure

- `1.0-expert-developer.mdc`: The primary rule that's always applied
- `1.1-project-configuration.mdc`: Template for project-specific details
- `2.x-*-mode.mdc`: Specialized modes for specific tasks or domains

## Best Practices

1. Keep the Expert Developer rule as the foundation
2. Fill out the Project Configuration with accurate information
3. Use specialized modes for targeted assistance
4. Be explicit when asking the AI to enter a specific mode
5. Transition between modes as needed for complex tasks

## Contributing

Feel free to enhance these rules or create new specialized modes. When contributing:

1. Follow the existing naming convention (`[number]-[name].mdc`)
2. Include clear instructions and examples
3. Define the mode's purpose, process, and return protocol
4. Test the mode with various scenarios

---

These rules are designed to make the Cursor AI assistant more effective at helping you with your development tasks. By providing structured guidance and specialized expertise, they enable more precise and helpful interactions.
