---
name: code-review
description: Performs thorough code reviews for Flutter/Dart pull requests and merge requests. Use when asked to review a PR, MR, branch, or a set of changed files. Follows a structured checklist covering correctness, security, style, testing, and documentation.
---

# Code Review

Structured, objective code review process for Flutter/Dart projects. Adapted from [evanca/flutter-ai-rules — code-review](https://github.com/evanca/flutter-ai-rules/blob/main/skills/code-review/SKILL.md).

---

## 1. Branch and merge target

- Confirm the current branch is a **feature, bugfix, or PR/MR branch** — not `main`, `master`, or `develop`.
- Verify the branch is **up-to-date** with the target branch.
- Identify the **target branch** for the merge.

## 2. Change discovery

- List all **changed, added, and deleted files**.
- For each change, look up the **commit title** and review how connected components are implemented.
- **Never assume** a change or fix is correct without investigating the implementation details.
- If a change remains difficult to understand after several attempts, **note this explicitly** in the report.

## 3. Per-file review

For every changed file, check:

| Area | What to verify |
|------|----------------|
| **Location** | File is in the correct directory |
| **Naming** | File name follows `lowercase_with_underscores` Dart convention |
| **Responsibility** | The file's responsibility is clear; reason for its change is understandable |
| **Readability** | Variable, function, and class names are descriptive and consistent |
| **Logic & correctness** | No logic errors or missing edge cases |
| **Maintainability** | Code is modular; no unnecessary duplication |
| **Error handling** | Errors and exceptions are handled appropriately |
| **Security** | No input validation issues; no secrets committed to code |
| **Performance** | No obvious performance issues or inefficiencies |
| **Documentation** | Public APIs, complex logic, and new modules are documented |
| **Test coverage** | New or changed logic has sufficient tests |
| **Style** | Code matches Effective Dart style and project patterns |

For **generated files** (e.g. `*.g.dart`, `*.freezed.dart`): confirm they are up-to-date and not manually modified.

### Project rules

以下はこのプロジェクト固有のルールであり、違反は 🔴 **Critical** として報告する。

#### No debug print statements

`print()` および `debugPrint()` の呼び出しをコミットに含めてはならない。

- デバッグ用途のログは `dart:developer` の `log()` または `logger` パッケージを使用する。
- 差分に `print(` / `debugPrint(` が含まれている場合は必ず指摘する。

#### No function components

ウィジェットは必ず `StatelessWidget` または `StatefulWidget` のクラスとして定義する。`Widget` を返すトップレベル関数やメソッド抽出で UI を構築してはならない。

- 関数コンポーネントは DevTools のウィジェットツリーに表示されず、デバッグが困難になる。
- `const` コンストラクタによるリビルド最適化が効かない。
- 差分に `Widget buildXxx(...)` や `Widget _buildXxx(...)` のようなウィジェット返却関数がある場合は、クラスウィジェットへの変換を指摘する。

## 4. Overall change set

- Verify the change set is **focused and scoped** to its stated purpose — no unrelated or unnecessary changes.
- Check that the **PR/MR description** accurately reflects the changes made.
- Confirm **new or updated tests** cover new or changed logic.
- Evaluate whether tests could **actually fail**, or only verify a mock implementation.

## 5. CI and tests

- Ensure **all tests pass** (`flutter test`).
- Run `flutter analyze` — no new warnings or errors.
- Fetch **online documentation** when unsure about best practices for a particular package or library.

---

## Feedback standards

- Be **objective and reasonable** — avoid automatic praise or flattery.
- Take a **devil's advocate approach**: give honest, thoughtful feedback.
- Provide **clear, constructive feedback** for any issues found, with suggestions for improvement.
- Include **requests for clarification** for anything that is unclear.

---

## Output format

Provide the review as a chat response covering per-file findings:

1. **Summary** of what changed and why
2. **Issues found** with severity:
   - 🔴 **Critical** — must fix before merge
   - 🟡 **Suggestion** — consider improving
   - 🟢 **Nice to have** — optional enhancement
3. **Specific recommendations or questions** per file
4. **Verdict**: approved, approved with suggestions, or changes requested
