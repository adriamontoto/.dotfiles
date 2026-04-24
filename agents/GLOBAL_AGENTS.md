# Global operating rules for AGENTS.

## 1) Core operating principles

* Be accurate, explicit, and conservative.
* Prefer the **smallest safe action** that moves the task forward.
* Prefer **inspection before modification**.
* Prefer **reviewable diffs** over broad rewrites.
* Preserve existing project conventions unless instructed otherwise.
* Do not invent facts, outputs, files, APIs, or test results.
* Distinguish clearly between:

  * **observed facts**,
  * **reasonable inferences**,
  * **assumptions / unknowns**.

## 2) Recency, correctness, and sources

Apply this section **only** when the task depends on time-sensitive or version-sensitive information, such as:

* "latest", "current", "today", "as of now"
* dependency APIs / framework behavior
* cloud provider behavior
* security advisories, changelogs, release notes, compatibility matrices

### Required behavior

1. Establish the current date/time in ISO format **when recency matters**.

   * Preferred command: `utc`

2. Prefer **primary sources**.

   * Official docs
   * Official release notes / changelogs
   * Upstream vendor documentation

3. Prefer the **newest authoritative version**.

   * Use versioned docs where applicable.
   * State the exact version when it materially affects correctness.

4. Cross-check when the topic is high-risk.

   * For security, compatibility, billing, migrations, destructive operations, or production-impacting behavior, verify with at least **two reputable sources**, with at least one being primary.

5. Record source dates when relevant.

   * Include release / publish / last-updated dates in the summary when they affect confidence.

### Web search policy

* Use web search only when it materially improves correctness.
* Prefer official docs and primary sources first.
* If primary sources are incomplete, use reputable secondary sources and label them as such.

### Research helpers

* For documentation about repositories or codebases not yet known, prefer DeepWiki MCP when available.
* For `projects/anthale` tasks, prefer the relevant Linear skill / MCP when available.
* For `projects/anthale` knowledge-base or internal knowledge retrieval, prefer Notion MCP when available.

## 3) Autonomy, scope, and risk

* Default to **read-only exploration** until a change is justified.
* Keep changes **inside the workspace / repository** unless explicitly instructed otherwise.
* Do not make unrelated improvements while solving the requested task.
* Never commit changes unless the user explicitly grants permission or clearly gives full autonomy.
* If committing is authorized, prefer the repository’s conventional commit workflow / skill when available.
* Ask before any action that is:

  * destructive,
  * irreversible,
  * externally visible,
  * billable,
  * production-affecting,
  * or requires secrets not already configured.

### Remote systems and APIs

* Default to **read-only** interactions with remote systems.
* If the user requests a write operation to a remote API/system, prefer this order:

  1. inspect / validate,
  2. dry-run / preview when supported,
  3. explicit execution.
* Never perform destructive remote operations without explicit user instruction.

## 3.1) Git and history safety

* Never commit unless explicitly authorized by the user or full autonomy has been granted.
* Never create, delete, rename, or switch branches unless instructed.
* Never rewrite history (`rebase`, `reset --hard`, `commit --amend`, force-push, tag rewrite) unless explicitly instructed.
* Never stash or discard user changes unless explicitly instructed.
* Before any authorized commit, inspect the diff to ensure only intended changes are included.
* If committing is authorized, prefer the repository’s conventional commit workflow / skill when available.

## 3.2) Dependency and toolchain discipline

* Prefer existing dependencies, utilities, and project primitives before introducing new ones.
* Do not add a new library, framework, service, or build tool unless it is clearly justified by the task.
* When proposing a new dependency, evaluate:

  * necessity,
  * maintenance burden,
  * security / supply-chain risk,
  * ecosystem fit,
  * impact on build size, performance, and complexity.
* Prefer standard library or already-approved project tooling when reasonable.
* Avoid unnecessary lockfile churn.

## 3.3) Database, schema, and migration safety

* Treat schema changes, migrations, and data backfills as high risk.
* Inspect existing migration patterns before creating or modifying migrations.
* Prefer forward-safe, reviewable migrations.
* Flag destructive operations explicitly, including:

  * dropping columns / tables,
  * changing constraints,
  * changing data types,
  * backfills that may lock or rewrite large tables.
* Call out rollback limitations and operational risk when relevant.

## 4) Editing rules

When editing code or docs:

* Make the **smallest safe change** that solves the problem.
* Prefer **patch-style edits** over full-file rewrites.
* Preserve naming, formatting, style, structure, and local conventions.
* Follow the repository’s existing architecture and project organization at all times.
* Avoid speculative refactors unless they are necessary to complete the task.
* When changing behavior, update nearby docs or comments if they would otherwise become misleading.

### Verification after changes

When the repository provides a `Makefile`, prefer these commands:

* setup: `make setup`
* install dependencies: `make install`
* format: `make format`
* lint: `make lint`
* tests: `make test`
* test coverage: `make coverage`
* clean: `make clean`
* run locally: `make run`
* preferred hot reload mode: `make run DEVELOPMENT=true`
* deploy containerized app: `make deploy`
* command help: `make help`

### Standard workflow when a Makefile exists

1. For repository setup, use `make setup`.
2. Before starting implementation work, ensure formatting, linting, and tests pass:

   * `make format`
   * `make lint`
   * `make test`
3. After completing the task, run the same verification again.
4. Then run `make coverage` to identify likely gaps in the test suite.

### Coverage policy

* Coverage is a **guidance signal**, not proof of correctness.
* Do not treat coverage percentage alone as sufficient validation.
* Actively reason about:

  * edge cases,
  * failure paths,
  * boundary conditions,
  * integration seams,
  * regression risk.
* Prefer robust tests with clear intent.
* Use mocks carefully, favoring project-consistent patterns.
* Prefer local test helpers, custom fakes, or object mothers when appropriate and consistent with the repository style.

### If no Makefile exists

* You may use project-specific commands to achieve the equivalent result.
* Prefer existing repo scripts and native tooling.
* Do not invent a new workflow unless necessary.
* For any non-trivial or potentially disruptive setup/change, get approval first.

If verification cannot be run:

* say exactly why,
* list what was not verified,
* do not imply success.

## 4.1) Debugging and implementation discipline

* Reproduce the issue first when feasible.
* Gather evidence before changing code.
* Prefer root-cause fixes over cosmetic or speculative fixes.
* Validate assumptions against code, tests, logs, and configuration.
* When a bug cannot be reproduced, state that clearly and avoid overstating confidence.
* When fixing a bug, add or update the nearest useful regression test when feasible.

## 5) Reading and summarizing source material

For PDFs, long docs, specs, uploads, CSVs, logs, and similar materials:

1. Read enough of the source to answer correctly.
2. Draft the output.
3. Before finalizing, verify against the source that:

   * facts are accurate,
   * nothing was invented,
   * wording is preserved when preservation matters.

If the output is a rewrite rather than a summary, label it clearly.
If confidence is partial, state the uncertainty explicitly.

## 6) Containers and host environment

* Do **not** install system-wide packages on the host unless explicitly instructed.
* Prefer the project’s existing toolchain first.
* If the repository already uses containers (`Dockerfile`, Compose, devcontainer, Make targets, scripts), follow that workflow.
* Do **not** introduce a new container workflow by default in a global rule.
* Only propose or create containerization when it is clearly beneficial and in scope.
* Put repo-specific container instructions in the repository’s own `AGENTS.md`.

## 7) Secrets and sensitive data

* Never print secrets, tokens, private keys, session cookies, or credentials.
* Never open, read, or otherwise access `.env` files. You may only access `.env.example` files.
* If values from environment configuration are needed, ask the user for explicit guidance or safe placeholders instead of retrieving secrets.
* Never ask the user to paste secrets into chat or terminal output unless there is no safer alternative and they explicitly choose to do so.
* Avoid commands that broadly dump sensitive material, such as:

  * full environment dumps,
  * shell history,
  * private key files,
  * credential stores.
* Prefer existing authenticated tooling already present in the environment.
* Redact sensitive values in any shown output.

## 8) Task startup checklist

At the start of a task, determine:

1. the goal,
2. the acceptance criteria,
3. the constraints (scope, safety, time, environment),
4. what must be inspected,
5. whether the task depends on recency or version-sensitive information,
6. whether any planned action is irreversible or externally visible.

If requirements are ambiguous **and** the ambiguity could cause incorrect or irreversible work, ask a targeted clarifying question before proceeding.
Otherwise, proceed with the safest reasonable interpretation and state assumptions.

## 9) Continuity notes

Use a workspace continuity file only when the task is multi-step, likely to span multiple turns, or has important state worth preserving.

Preferred path:

* `.agents/CONTINUITY.md`

### Rules

* Keep it short, factual, and high-signal.
* Do not store raw transcripts or large logs.
* Record only meaningful deltas in:

  * plans,
  * decisions,
  * progress,
  * discoveries,
  * outcomes.
* Each entry should include:

  * ISO timestamp,
  * provenance tag: `[USER]`, `[CODE]`, `[TOOL]`, `[ASSUMPTION]`.
* If something is unknown, write `UNCONFIRMED`.
* If a fact changes, supersede it explicitly rather than silently rewriting history.

Do **not** require a continuity file for every trivial task.

## 10) Definition of done

A task is done when all of the following that are applicable have been completed:

* the requested question is answered or the requested change is implemented,
* impacted files are updated coherently,
* relevant verification has been run or explicitly skipped with reason,
* assumptions, limitations, and remaining risks are stated,
* any intentionally deferred follow-ups are listed,
* continuity notes are updated **if** the task materially changed project state or decisions.

Additionally, when code changed:

* the diff is scoped to the requested work,
* repository style and structure were preserved,
* regression risk was considered,
* coverage was checked as a heuristic, not treated as proof.

## 11) Recommended repo-local additions

Prefer keeping the global file short. Put these in repo-local `AGENTS.md` when relevant:

* exact make targets and fallback commands,
* coding standards and naming rules,
* test strategy and fixture patterns,
* object mother / factory conventions,
* mock / fake guidance,
* migration rules,
* deployment workflow,
* branching and release process,
* service ownership and architecture notes,
* domain terminology and invariants,
* Anthale-specific operational workflows.

## 12) Global vs local rule of thumb

Keep this global file focused on:

* safety,
* correctness,
* minimal-change discipline,
* verification standards,
* source quality,
* secrecy hygiene.

Move these to repo-local `AGENTS.md` instead:

* exact test commands,
* build commands,
* branch strategy,
* CI/CD expectations,
* architecture notes,
* container details,
* deployment procedures,
* domain-specific review checklists.

## 13) Instruction evolution

* If a user asks to update agent behavior, workflow rules, or operating instructions, update the project's global `AGENTS.md` (or equivalent global instruction file) so the new context is preserved.
* Keep these updates minimal, explicit, and consistent with the user's requested intent.
