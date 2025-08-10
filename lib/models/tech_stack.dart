// Technology Stack Data

class TechStack {
  final String name;
  final String svgPath; // Changed from icon to svgPath

  const TechStack({required this.name, required this.svgPath});
}

final List<TechStack> techStackList = [
  // Only using technologies that have SVG icons in the assets/svg/tech folder
  TechStack(name: 'Dart', svgPath: 'assets/svg/tech/dart.svg'),
  TechStack(name: 'Docker', svgPath: 'assets/svg/tech/docker.svg'),
  TechStack(name: 'Figma', svgPath: 'assets/svg/tech/figma.svg'),
  TechStack(name: 'Firebase', svgPath: 'assets/svg/tech/firebase.svg'),
  TechStack(name: 'Flutter', svgPath: 'assets/svg/tech/flutter.svg'),
  TechStack(name: 'Google Cloud', svgPath: 'assets/svg/tech/gcloud.svg'),
  TechStack(name: 'Git', svgPath: 'assets/svg/tech/git.svg'),
  TechStack(name: 'GitHub', svgPath: 'assets/svg/tech/github.svg'),
  TechStack(name: 'GraphQL', svgPath: 'assets/svg/tech/graphQl.svg'),
  TechStack(name: 'Jira', svgPath: 'assets/svg/tech/jirra.svg'),
  TechStack(name: 'Kotlin', svgPath: 'assets/svg/tech/kotlin.svg'),
  TechStack(name: 'Linux', svgPath: 'assets/svg/tech/linux.svg'),
  TechStack(name: 'MySQL', svgPath: 'assets/svg/tech/mysql.svg'),
  TechStack(name: 'PostgreSQL', svgPath: 'assets/svg/tech/postgress.svg'),
  TechStack(name: 'Postman', svgPath: 'assets/svg/tech/postman.svg'),
  TechStack(name: 'Rust', svgPath: 'assets/svg/tech/rust.svg'),
  TechStack(name: 'Supabase', svgPath: 'assets/svg/tech/supabase.svg'),
  TechStack(name: 'VS Code', svgPath: 'assets/svg/tech/vscode.svg'),
];
