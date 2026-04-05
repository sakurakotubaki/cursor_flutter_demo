---
name: effective-dart
description: Applies Effective Dart guidelines when writing or reviewing Dart/Flutter code—naming, types, style, imports, structure, usage, documentation, testing, widgets, state management, and performance. Use for Dart or Flutter implementation, refactors, reviews, or when the user mentions style, conventions, or idiomatic Dart.
---

# Effective Dart

Follow [Effective Dart](https://dart.dev/effective-dart) (style, documentation, usage, design). Prefer `dart format` over manual formatting.

## Naming

| Kind | Convention | Example |
|------|------------|---------|
| Classes, enums, typedefs, type parameters, extensions | `UpperCamelCase` | `MyWidget`, `UserState` |
| Packages, directories, source files | `lowercase_with_underscores` | `user_profile.dart` |
| Import prefixes | `lowercase_with_underscores` | `as my_prefix` |
| Variables, parameters, named parameters, functions | `lowerCamelCase` | `userName`, `fetchData()` |

- Capitalize acronyms longer than two letters like words: `HttpRequest`, not `HTTPRequest`.
- Avoid abbreviations unless more common than the full term.
- Put the **most descriptive noun last**; use terms **consistently**.
- Type parameters: `E` (element), `K`/`V` (key/value), `T`/`S`/`U` (generics).
- Prefer **noun phrases** for non-booleans; **non-imperative positive** phrasing for booleans (omit the verb on named boolean params when clear).

## Types and functions

- Use **class modifiers** (`final`, `interface`, `sealed`, etc.) to control extension and implementation.
- **Annotate** variables without initializers; fields and top-level vars when type is not obvious.
- Annotate **return types** and **parameter types** on function declarations.
- Add explicit **type arguments** when inference is insufficient; use `dynamic` only when intentional.
- Use `Future<void>` for async members that return nothing.
- Use **getters** for property-like access; **setters** for property-like mutation.
- Prefer **function declarations** over assigning lambdas when naming a function.
- Ranges: **inclusive start, exclusive end**.

## Style

- Run `dart format .` (or format on save)—do not hand-indent for “style.”
- **Curly braces** on all flow-control bodies.
- Prefer `final` over `var` when not reassigned; use `const` where valid.
- Aim for **~80 character** lines where practical.

## Imports and files

- Do not import another package’s `src/` implementation details.
- Imports must stay within the package’s `lib` surface (no `../` escaping `lib` conventions that break encapsulation).
- **Prefer relative imports** within the same package when consistent with project rules.
- Consider a **library doc comment** (`///`) at the top of library files.

## Structure

- One main responsibility per file; split when readability drops.
- Prefer `final` fields; **`const` constructors** when possible.
- **Prefer private** (`_`) members; expose only what callers need.

## Usage patterns

```dart
// Adjacent strings (not +)
final greeting = 'Hello, '
    'world!';

// Collection literals
final list = [1, 2, 3];
final map = {'key': 'value'};

// Initializing formals
class Point {
  final double x, y;
  Point(this.x, this.y);
}

// Empty constructor body: use `;` not `{}`
class Empty {
  Empty();
}
```

- Use `whereType<T>()` to filter by type.
- Be consistent with `var` vs `final` locally.
- Initialize fields at declaration when possible.
- If overriding `==`, override `hashCode` and preserve equality rules.
- Prefer `on SpecificException catch` over bare `catch`; use `rethrow` when logging and propagating.

## Documentation (`///`)

- First line: **one-sentence summary**; then detail.
- Use `[identifier]` to link symbols; explain parameters, returns, and thrown types in prose.
- Put doc comments **before** annotations.
- Document **why** or **how to use**, not only what.
- Booleans: start with **Whether** …

## Testing

- Unit tests for logic; **widget tests** for UI; aim for meaningful coverage.

## Widgets

- Extract reusable pieces; prefer `StatelessWidget` when stateless.
- Keep `build` cheap: no heavy work; use `const` widgets where possible.

## State management

- Match complexity to the problem; avoid extra `StatefulWidget` layers; keep state **as local as possible**.

## Performance

- `const` constructors and literals in hot paths.
- Avoid expensive work in `build`; paginate large lists.

## References

- [Effective Dart](https://dart.dev/effective-dart)
- Upstream skill idea: [evanca/flutter-ai-rules — effective-dart](https://github.com/evanca/flutter-ai-rules/blob/main/skills/effective-dart/SKILL.md)
