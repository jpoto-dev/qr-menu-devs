# Subtemplates

To simplify development, the `./specs` folder contains Markdown files that define the requirements for each asset. Whenever a spec is updated, the corresponding asset must also be updated to match.

For example, the folder `./specs/templates/documents` contains files whose names correspond directly to files in `./src/templates/documents`. Each Markdown file in `./specs/templates/documents` defines the requirements for a specific template or subtemplate.

When implementing updates based on a spec:
* Only update the affected asset(s).
* Do not modify unrelated files or features.
* Make changes only where required to reflect the updated spec.
