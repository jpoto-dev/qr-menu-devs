# Agents guidelines
This application is a Symfony-based server-side rendering (SSR) application for QR menu development. Follow these rules carefully:
1. **Plan before coding**: Create a clear, comprehensive, and concise plan before making any changes.
2. **Use correct diff markers**: Always apply the correct diff format when updating code.
3. **Follow scope strictly**: Do only what you are asked—never modify unrelated files or code, especially when specific files are mentioned.
4. **Security**:
   - Never read or access .env files under any circumstances.
   - Do not expose secrets, tokens, or credentials in logs or output.
5. **Code style**: Write code that is self-explanatory, concise, and precise. Follow Symfony coding standards and PSR-4 autoloading.
6. **Styling**: Use a mobile-first approach with CSS Grid as the primary layout tool. Flexbox may be used for component-level layouts where appropriate. Ensure responsive design for mobile devices, as QR menus are typically accessed via mobile.
7. **Development Environment**: Use Docker Compose for local development, following the setup in README.md.
8. **Framework Specifics**: Follow Symfony best practices, including using MakerBundle for code generation, annotations for Doctrine entities and routes, and Twig for templating.
9. **Testing**: Write unit and functional tests using PHPUnit, ensuring adequate coverage for critical features like QR generation and menu data handling.
10. **Database**: Use Doctrine ORM for data persistence. Create and run migrations for any schema changes.
