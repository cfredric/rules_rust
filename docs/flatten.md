# Rust rules

* [CrateInfo](#CrateInfo)
* [DepInfo](#DepInfo)
* [StdLibInfo](#StdLibInfo)
* [capture_clippy_output](#capture_clippy_output)
* [cargo_bootstrap_repository](#cargo_bootstrap_repository)
* [cargo_build_script](#cargo_build_script)
* [cargo_env](#cargo_env)
* [error_format](#error_format)
* [extra_rustc_flags](#extra_rustc_flags)
* [fail_when_enabled](#fail_when_enabled)
* [incompatible_flag](#incompatible_flag)
* [rules_rust_dependencies](#rules_rust_dependencies)
* [rust_analyzer](#rust_analyzer)
* [rust_analyzer_aspect](#rust_analyzer_aspect)
* [rust_binary](#rust_binary)
* [rust_bindgen](#rust_bindgen)
* [rust_bindgen_dependencies](#rust_bindgen_dependencies)
* [rust_bindgen_library](#rust_bindgen_library)
* [rust_bindgen_register_toolchains](#rust_bindgen_register_toolchains)
* [rust_bindgen_toolchain](#rust_bindgen_toolchain)
* [rust_clippy](#rust_clippy)
* [rust_clippy_aspect](#rust_clippy_aspect)
* [rust_doc](#rust_doc)
* [rust_doc_test](#rust_doc_test)
* [rust_grpc_library](#rust_grpc_library)
* [rust_library](#rust_library)
* [rust_proc_macro](#rust_proc_macro)
* [rust_proto_library](#rust_proto_library)
* [rust_proto_repositories](#rust_proto_repositories)
* [rust_proto_toolchain](#rust_proto_toolchain)
* [rust_proto_transitive_repositories](#rust_proto_transitive_repositories)
* [rust_register_toolchains](#rust_register_toolchains)
* [rust_repositories](#rust_repositories)
* [rust_repository_set](#rust_repository_set)
* [rust_shared_library](#rust_shared_library)
* [rust_static_library](#rust_static_library)
* [rust_stdlib_filegroup](#rust_stdlib_filegroup)
* [rust_test](#rust_test)
* [rust_test_suite](#rust_test_suite)
* [rust_toolchain](#rust_toolchain)
* [rust_toolchain_repository](#rust_toolchain_repository)
* [rust_toolchain_repository_proxy](#rust_toolchain_repository_proxy)
* [rust_wasm_bindgen](#rust_wasm_bindgen)
* [rust_wasm_bindgen_dependencies](#rust_wasm_bindgen_dependencies)
* [rust_wasm_bindgen_register_toolchains](#rust_wasm_bindgen_register_toolchains)
* [rust_wasm_bindgen_toolchain](#rust_wasm_bindgen_toolchain)
* [rustfmt_aspect](#rustfmt_aspect)
* [rustfmt_test](#rustfmt_test)


<a id="#capture_clippy_output"></a>

## capture_clippy_output

<pre>
capture_clippy_output(<a href="#capture_clippy_output-name">name</a>)
</pre>

Control whether to print clippy output or store it to a file, using the configured error_format.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="capture_clippy_output-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |


<a id="#cargo_bootstrap_repository"></a>

## cargo_bootstrap_repository

<pre>
cargo_bootstrap_repository(<a href="#cargo_bootstrap_repository-name">name</a>, <a href="#cargo_bootstrap_repository-binary">binary</a>, <a href="#cargo_bootstrap_repository-build_mode">build_mode</a>, <a href="#cargo_bootstrap_repository-cargo_lockfile">cargo_lockfile</a>, <a href="#cargo_bootstrap_repository-cargo_toml">cargo_toml</a>, <a href="#cargo_bootstrap_repository-env">env</a>, <a href="#cargo_bootstrap_repository-env_label">env_label</a>,
                           <a href="#cargo_bootstrap_repository-iso_date">iso_date</a>, <a href="#cargo_bootstrap_repository-repo_mapping">repo_mapping</a>, <a href="#cargo_bootstrap_repository-rust_toolchain_cargo_template">rust_toolchain_cargo_template</a>,
                           <a href="#cargo_bootstrap_repository-rust_toolchain_repository_template">rust_toolchain_repository_template</a>, <a href="#cargo_bootstrap_repository-rust_toolchain_rustc_template">rust_toolchain_rustc_template</a>, <a href="#cargo_bootstrap_repository-srcs">srcs</a>,
                           <a href="#cargo_bootstrap_repository-timeout">timeout</a>, <a href="#cargo_bootstrap_repository-version">version</a>)
</pre>

A rule for bootstrapping a Rust binary using [Cargo](https://doc.rust-lang.org/cargo/)

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="cargo_bootstrap_repository-name"></a>name |  A unique name for this repository.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="cargo_bootstrap_repository-binary"></a>binary |  The binary to build (the <code>--bin</code> parameter for Cargo). If left empty, the repository name will be used.   | String | optional | "" |
| <a id="cargo_bootstrap_repository-build_mode"></a>build_mode |  The build mode the binary should be built with   | String | optional | "release" |
| <a id="cargo_bootstrap_repository-cargo_lockfile"></a>cargo_lockfile |  The lockfile of the crate_universe resolver   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |
| <a id="cargo_bootstrap_repository-cargo_toml"></a>cargo_toml |  The path of the crate_universe resolver manifest (<code>Cargo.toml</code> file)   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |
| <a id="cargo_bootstrap_repository-env"></a>env |  A mapping of platform triple to a set of environment variables. See [cargo_env](#cargo_env) for usage details. Additionally, the platform triple <code>*</code> applies to all platforms.   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | optional | {} |
| <a id="cargo_bootstrap_repository-env_label"></a>env_label |  A mapping of platform triple to a set of environment variables. This attribute differs from <code>env</code> in that all variables passed here must be fully qualified labels of files. See [cargo_env](#cargo_env) for usage details. Additionally, the platform triple <code>*</code> applies to all platforms.   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | optional | {} |
| <a id="cargo_bootstrap_repository-iso_date"></a>iso_date |  The iso_date of cargo binary the resolver should use. Note: This can only be set if <code>version</code> is <code>beta</code> or <code>nightly</code>   | String | optional | "" |
| <a id="cargo_bootstrap_repository-repo_mapping"></a>repo_mapping |  A dictionary from local repository name to global repository name. This allows controls over workspace dependency resolution for dependencies of this repository.&lt;p&gt;For example, an entry <code>"@foo": "@bar"</code> declares that, for any time this repository depends on <code>@foo</code> (such as a dependency on <code>@foo//some:target</code>, it should actually resolve that dependency within globally-declared <code>@bar</code> (<code>@bar//some:target</code>).   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | required |  |
| <a id="cargo_bootstrap_repository-rust_toolchain_cargo_template"></a>rust_toolchain_cargo_template |  The template to use for finding the host <code>cargo</code> binary. <code>{version}</code> (eg. '1.53.0'), <code>{triple}</code> (eg. 'x86_64-unknown-linux-gnu'), <code>{arch}</code> (eg. 'aarch64'), <code>{vendor}</code> (eg. 'unknown'), <code>{system}</code> (eg. 'darwin'), and <code>{tool}</code> (eg. 'rustc.exe') will be replaced in the string if present.   | String | optional | "@rust_{system}_{arch}//:bin/{tool}" |
| <a id="cargo_bootstrap_repository-rust_toolchain_repository_template"></a>rust_toolchain_repository_template |  **Deprecated**: Please use <code>rust_toolchain_cargo_template</code> and <code>rust_toolchain_rustc_template</code>   | String | optional | "" |
| <a id="cargo_bootstrap_repository-rust_toolchain_rustc_template"></a>rust_toolchain_rustc_template |  The template to use for finding the host <code>rustc</code> binary. <code>{version}</code> (eg. '1.53.0'), <code>{triple}</code> (eg. 'x86_64-unknown-linux-gnu'), <code>{arch}</code> (eg. 'aarch64'), <code>{vendor}</code> (eg. 'unknown'), <code>{system}</code> (eg. 'darwin'), and <code>{tool}</code> (eg. 'rustc.exe') will be replaced in the string if present.   | String | optional | "@rust_{system}_{arch}//:bin/{tool}" |
| <a id="cargo_bootstrap_repository-srcs"></a>srcs |  Souce files of the crate to build. Passing source files here can be used to trigger rebuilds when changes are made   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="cargo_bootstrap_repository-timeout"></a>timeout |  Maximum duration of the Cargo build command in seconds   | Integer | optional | 600 |
| <a id="cargo_bootstrap_repository-version"></a>version |  The version of cargo the resolver should use   | String | optional | "1.61.0" |


<a id="#error_format"></a>

## error_format

<pre>
error_format(<a href="#error_format-name">name</a>)
</pre>

Change the [--error-format](https://doc.rust-lang.org/rustc/command-line-arguments.html#option-error-format) flag from the command line with `--@rules_rust//:error_format`. See rustc documentation for valid values.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="error_format-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |


<a id="#extra_rustc_flags"></a>

## extra_rustc_flags

<pre>
extra_rustc_flags(<a href="#extra_rustc_flags-name">name</a>)
</pre>

Add additional rustc_flags from the command line with `--@rules_rust//:extra_rustc_flags`. This flag should only be used for flags that need to be applied across the entire build. For options that apply to individual crates, use the rustc_flags attribute on the individual crate's rule instead. NOTE: These flags not applied to the exec configuration (proc-macros, cargo_build_script, etc); use `--@rules_rust//:extra_exec_rustc_flags` to apply flags to the exec configuration.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="extra_rustc_flags-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |


<a id="#incompatible_flag"></a>

## incompatible_flag

<pre>
incompatible_flag(<a href="#incompatible_flag-name">name</a>, <a href="#incompatible_flag-issue">issue</a>)
</pre>

A rule defining an incompatible flag.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="incompatible_flag-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="incompatible_flag-issue"></a>issue |  The link to the github issue associated with this flag   | String | required |  |


<a id="#rust_analyzer"></a>

## rust_analyzer

<pre>
rust_analyzer(<a href="#rust_analyzer-name">name</a>, <a href="#rust_analyzer-targets">targets</a>)
</pre>

Deprecated: gen_rust_project can now create a rust-project.json without a rust_analyzer rule.


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="rust_analyzer-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="rust_analyzer-targets"></a>targets |  List of all targets to be included in the index   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |


<a id="#rust_binary"></a>

## rust_binary

<pre>
rust_binary(<a href="#rust_binary-name">name</a>, <a href="#rust_binary-aliases">aliases</a>, <a href="#rust_binary-compile_data">compile_data</a>, <a href="#rust_binary-crate_features">crate_features</a>, <a href="#rust_binary-crate_name">crate_name</a>, <a href="#rust_binary-crate_root">crate_root</a>, <a href="#rust_binary-crate_type">crate_type</a>, <a href="#rust_binary-data">data</a>,
            <a href="#rust_binary-deps">deps</a>, <a href="#rust_binary-edition">edition</a>, <a href="#rust_binary-linker_script">linker_script</a>, <a href="#rust_binary-out_binary">out_binary</a>, <a href="#rust_binary-proc_macro_deps">proc_macro_deps</a>, <a href="#rust_binary-rustc_env">rustc_env</a>, <a href="#rust_binary-rustc_env_files">rustc_env_files</a>,
            <a href="#rust_binary-rustc_flags">rustc_flags</a>, <a href="#rust_binary-srcs">srcs</a>, <a href="#rust_binary-stamp">stamp</a>, <a href="#rust_binary-version">version</a>)
</pre>

Builds a Rust binary crate.

Example:

Suppose you have the following directory structure for a Rust project with a
library crate, `hello_lib`, and a binary crate, `hello_world` that uses the
`hello_lib` library:

```output
[workspace]/
    WORKSPACE
    hello_lib/
        BUILD
        src/
            lib.rs
    hello_world/
        BUILD
        src/
            main.rs
```

`hello_lib/src/lib.rs`:
```rust
pub struct Greeter {
    greeting: String,
}

impl Greeter {
    pub fn new(greeting: &str) -> Greeter {
        Greeter { greeting: greeting.to_string(), }
    }

    pub fn greet(&self, thing: &str) {
        println!("{} {}", &self.greeting, thing);
    }
}
```

`hello_lib/BUILD`:
```python
package(default_visibility = ["//visibility:public"])

load("@rules_rust//rust:defs.bzl", "rust_library")

rust_library(
    name = "hello_lib",
    srcs = ["src/lib.rs"],
)
```

`hello_world/src/main.rs`:
```rust
extern crate hello_lib;

fn main() {
    let hello = hello_lib::Greeter::new("Hello");
    hello.greet("world");
}
```

`hello_world/BUILD`:
```python
load("@rules_rust//rust:defs.bzl", "rust_binary")

rust_binary(
    name = "hello_world",
    srcs = ["src/main.rs"],
    deps = ["//hello_lib"],
)
```

Build and run `hello_world`:
```
$ bazel run //hello_world
INFO: Found 1 target...
Target //examples/rust/hello_world:hello_world up-to-date:
bazel-bin/examples/rust/hello_world/hello_world
INFO: Elapsed time: 1.308s, Critical Path: 1.22s

INFO: Running command line: bazel-bin/examples/rust/hello_world/hello_world
Hello world
```

On Windows, a PDB file containing debugging information is available under
the key `pdb_file` in `OutputGroupInfo`. Similarly on macOS, a dSYM folder
is available under the key `dsym_folder` in `OutputGroupInfo`.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="rust_binary-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="rust_binary-aliases"></a>aliases |  Remap crates to a new name or moniker for linkage to this target<br><br>These are other <code>rust_library</code> targets and will be presented as the new name given.   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: Label -> String</a> | optional | {} |
| <a id="rust_binary-compile_data"></a>compile_data |  List of files used by this rule at compile time.<br><br>This attribute can be used to specify any data files that are embedded into the library, such as via the [<code>include_str!</code>](https://doc.rust-lang.org/std/macro.include_str!.html) macro.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_binary-crate_features"></a>crate_features |  List of features to enable for this crate.<br><br>Features are defined in the code using the <code>#[cfg(feature = "foo")]</code> configuration option. The features listed here will be passed to <code>rustc</code> with <code>--cfg feature="${feature_name}"</code> flags.   | List of strings | optional | [] |
| <a id="rust_binary-crate_name"></a>crate_name |  Crate name to use for this target.<br><br>This must be a valid Rust identifier, i.e. it may contain only alphanumeric characters and underscores. Defaults to the target name, with any hyphens replaced by underscores.   | String | optional | "" |
| <a id="rust_binary-crate_root"></a>crate_root |  The file that will be passed to <code>rustc</code> to be used for building this crate.<br><br>If <code>crate_root</code> is not set, then this rule will look for a <code>lib.rs</code> file (or <code>main.rs</code> for rust_binary) or the single file in <code>srcs</code> if <code>srcs</code> contains only one file.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="rust_binary-crate_type"></a>crate_type |  Crate type that will be passed to <code>rustc</code> to be used for building this crate.<br><br>This option is a temporary workaround and should be used only when building for WebAssembly targets (//rust/platform:wasi and //rust/platform:wasm).   | String | optional | "bin" |
| <a id="rust_binary-data"></a>data |  List of files used by this rule at compile time and runtime.<br><br>If including data at compile time with include_str!() and similar, prefer <code>compile_data</code> over <code>data</code>, to prevent the data also being included in the runfiles.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_binary-deps"></a>deps |  List of other libraries to be linked to this library target.<br><br>These can be either other <code>rust_library</code> targets or <code>cc_library</code> targets if linking a native library.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_binary-edition"></a>edition |  The rust edition to use for this crate. Defaults to the edition specified in the rust_toolchain.   | String | optional | "" |
| <a id="rust_binary-linker_script"></a>linker_script |  Link script to forward into linker via rustc options.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="rust_binary-out_binary"></a>out_binary |  Force a target, regardless of it's <code>crate_type</code>, to always mark the file as executable. This attribute is only used to support wasm targets but is expected to be removed following a resolution to https://github.com/bazelbuild/rules_rust/issues/771.   | Boolean | optional | False |
| <a id="rust_binary-proc_macro_deps"></a>proc_macro_deps |  List of <code>rust_library</code> targets with kind <code>proc-macro</code> used to help build this library target.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_binary-rustc_env"></a>rustc_env |  Dictionary of additional <code>"key": "value"</code> environment variables to set for rustc.<br><br>rust_test()/rust_binary() rules can use $(rootpath //package:target) to pass in the location of a generated file or external tool. Cargo build scripts that wish to expand locations should use cargo_build_script()'s build_script_env argument instead, as build scripts are run in a different environment - see cargo_build_script()'s documentation for more.   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | optional | {} |
| <a id="rust_binary-rustc_env_files"></a>rustc_env_files |  Files containing additional environment variables to set for rustc.<br><br>These files should  contain a single variable per line, of format <code>NAME=value</code>, and newlines may be included in a value by ending a line with a trailing back-slash (<code>\\</code>).<br><br>The order that these files will be processed is unspecified, so multiple definitions of a particular variable are discouraged.<br><br>Note that the variables here are subject to [workspace status](https://docs.bazel.build/versions/main/user-manual.html#workspace_status) stamping should the <code>stamp</code> attribute be enabled. Stamp variables should be wrapped in brackets in order to be resolved. E.g. <code>NAME={WORKSPACE_STATUS_VARIABLE}</code>.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_binary-rustc_flags"></a>rustc_flags |  List of compiler flags passed to <code>rustc</code>.<br><br>These strings are subject to Make variable expansion for predefined source/output path variables like <code>$location</code>, <code>$execpath</code>, and <code>$rootpath</code>. This expansion is useful if you wish to pass a generated file of arguments to rustc: <code>@$(location //package:target)</code>.   | List of strings | optional | [] |
| <a id="rust_binary-srcs"></a>srcs |  List of Rust <code>.rs</code> source files used to build the library.<br><br>If <code>srcs</code> contains more than one file, then there must be a file either named <code>lib.rs</code>. Otherwise, <code>crate_root</code> must be set to the source file that is the root of the crate to be passed to rustc to build this crate.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_binary-stamp"></a>stamp |  Whether to encode build information into the <code>Rustc</code> action. Possible values:<br><br>- <code>stamp = 1</code>: Always stamp the build information into the <code>Rustc</code> action, even in             [--nostamp](https://docs.bazel.build/versions/main/user-manual.html#flag--stamp) builds.             This setting should be avoided, since it potentially kills remote caching for the target and             any downstream actions that depend on it.<br><br>- <code>stamp = 0</code>: Always replace build information by constant values. This gives good build result caching.<br><br>- <code>stamp = -1</code>: Embedding of build information is controlled by the             [--[no]stamp](https://docs.bazel.build/versions/main/user-manual.html#flag--stamp) flag.<br><br>Stamped targets are not rebuilt unless their dependencies change.<br><br>For example if a <code>rust_library</code> is stamped, and a <code>rust_binary</code> depends on that library, the stamped library won't be rebuilt when we change sources of the <code>rust_binary</code>. This is different from how [<code>cc_library.linkstamps</code>](https://docs.bazel.build/versions/main/be/c-cpp.html#cc_library.linkstamp) behaves.   | Integer | optional | -1 |
| <a id="rust_binary-version"></a>version |  A version to inject in the cargo environment variable.   | String | optional | "0.0.0" |


<a id="#rust_bindgen"></a>

## rust_bindgen

<pre>
rust_bindgen(<a href="#rust_bindgen-name">name</a>, <a href="#rust_bindgen-bindgen_flags">bindgen_flags</a>, <a href="#rust_bindgen-cc_lib">cc_lib</a>, <a href="#rust_bindgen-clang_flags">clang_flags</a>, <a href="#rust_bindgen-header">header</a>, <a href="#rust_bindgen-rustfmt">rustfmt</a>)
</pre>

Generates a rust source file from a cc_library and a header.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="rust_bindgen-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="rust_bindgen-bindgen_flags"></a>bindgen_flags |  Flags to pass directly to the bindgen executable. See https://rust-lang.github.io/rust-bindgen/ for details.   | List of strings | optional | [] |
| <a id="rust_bindgen-cc_lib"></a>cc_lib |  The cc_library that contains the <code>.h</code> file. This is used to find the transitive includes.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="rust_bindgen-clang_flags"></a>clang_flags |  Flags to pass directly to the clang executable.   | List of strings | optional | [] |
| <a id="rust_bindgen-header"></a>header |  The <code>.h</code> file to generate bindings for.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="rust_bindgen-rustfmt"></a>rustfmt |  Enable or disable running rustfmt on the generated file.   | Boolean | optional | True |


<a id="#rust_bindgen_toolchain"></a>

## rust_bindgen_toolchain

<pre>
rust_bindgen_toolchain(<a href="#rust_bindgen_toolchain-name">name</a>, <a href="#rust_bindgen_toolchain-bindgen">bindgen</a>, <a href="#rust_bindgen_toolchain-clang">clang</a>, <a href="#rust_bindgen_toolchain-libclang">libclang</a>, <a href="#rust_bindgen_toolchain-libstdcxx">libstdcxx</a>, <a href="#rust_bindgen_toolchain-rustfmt">rustfmt</a>)
</pre>

The tools required for the `rust_bindgen` rule.

This rule depends on the [`bindgen`](https://crates.io/crates/bindgen) binary crate, and it 
in turn depends on both a clang binary and the clang library. To obtain these dependencies,
`rust_bindgen_dependencies` imports bindgen and its dependencies.

```python
load("@rules_rust//bindgen:bindgen.bzl", "rust_bindgen_toolchain")

rust_bindgen_toolchain(
    name = "bindgen_toolchain_impl",
    bindgen = "//my/rust:bindgen",
    clang = "//my/clang:clang",
    libclang = "//my/clang:libclang.so",
    libstdcxx = "//my/cpp:libstdc++",
)

toolchain(
    name = "bindgen_toolchain",
    toolchain = "bindgen_toolchain_impl",
    toolchain_type = "@rules_rust//bindgen:bindgen_toolchain",
)
```

This toolchain will then need to be registered in the current `WORKSPACE`.
For additional information, see the [Bazel toolchains documentation](https://docs.bazel.build/versions/master/toolchains.html).


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="rust_bindgen_toolchain-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="rust_bindgen_toolchain-bindgen"></a>bindgen |  The label of a <code>bindgen</code> executable.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="rust_bindgen_toolchain-clang"></a>clang |  The label of a <code>clang</code> executable.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="rust_bindgen_toolchain-libclang"></a>libclang |  A cc_library that provides bindgen's runtime dependency on libclang.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="rust_bindgen_toolchain-libstdcxx"></a>libstdcxx |  A cc_library that satisfies libclang's libstdc++ dependency. This is used to make the execution of clang hermetic. If None, system libraries will be used instead.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="rust_bindgen_toolchain-rustfmt"></a>rustfmt |  The label of a <code>rustfmt</code> executable. If this is not provided, falls back to the rust_toolchain rustfmt.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |


<a id="#rust_clippy"></a>

## rust_clippy

<pre>
rust_clippy(<a href="#rust_clippy-name">name</a>, <a href="#rust_clippy-deps">deps</a>)
</pre>

Executes the clippy checker on a specific target.

Similar to `rust_clippy_aspect`, but allows specifying a list of dependencies within the build system.

For example, given the following example targets:

```python
load("@rules_rust//rust:defs.bzl", "rust_library", "rust_test")

rust_library(
    name = "hello_lib",
    srcs = ["src/lib.rs"],
)

rust_test(
    name = "greeting_test",
    srcs = ["tests/greeting.rs"],
    deps = [":hello_lib"],
)
```

Rust clippy can be set as a build target with the following:

```python
load("@rules_rust//rust:defs.bzl", "rust_clippy")

rust_clippy(
    name = "hello_library_clippy",
    testonly = True,
    deps = [
        ":hello_lib",
        ":greeting_test",
    ],
)
```


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="rust_clippy-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="rust_clippy-deps"></a>deps |  Rust targets to run clippy on.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |


<a id="#rust_doc"></a>

## rust_doc

<pre>
rust_doc(<a href="#rust_doc-name">name</a>, <a href="#rust_doc-crate">crate</a>, <a href="#rust_doc-html_after_content">html_after_content</a>, <a href="#rust_doc-html_before_content">html_before_content</a>, <a href="#rust_doc-html_in_header">html_in_header</a>, <a href="#rust_doc-markdown_css">markdown_css</a>)
</pre>

Generates code documentation.

Example:
Suppose you have the following directory structure for a Rust library crate:

```
[workspace]/
    WORKSPACE
    hello_lib/
        BUILD
        src/
            lib.rs
```

To build [`rustdoc`][rustdoc] documentation for the `hello_lib` crate, define     a `rust_doc` rule that depends on the the `hello_lib` `rust_library` target:

[rustdoc]: https://doc.rust-lang.org/book/documentation.html

```python
package(default_visibility = ["//visibility:public"])

load("@rules_rust//rust:defs.bzl", "rust_library", "rust_doc")

rust_library(
    name = "hello_lib",
    srcs = ["src/lib.rs"],
)

rust_doc(
    name = "hello_lib_doc",
    crate = ":hello_lib",
)
```

Running `bazel build //hello_lib:hello_lib_doc` will build a zip file containing     the documentation for the `hello_lib` library crate generated by `rustdoc`.


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="rust_doc-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="rust_doc-crate"></a>crate |  The label of the target to generate code documentation for.<br><br><code>rust_doc</code> can generate HTML code documentation for the source files of <code>rust_library</code> or <code>rust_binary</code> targets.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |
| <a id="rust_doc-html_after_content"></a>html_after_content |  File to add in <code>&lt;body&gt;</code>, after content.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="rust_doc-html_before_content"></a>html_before_content |  File to add in <code>&lt;body&gt;</code>, before content.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="rust_doc-html_in_header"></a>html_in_header |  File to add to <code>&lt;head&gt;</code>.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="rust_doc-markdown_css"></a>markdown_css |  CSS files to include via <code>&lt;link&gt;</code> in a rendered Markdown file.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |


<a id="#rust_doc_test"></a>

## rust_doc_test

<pre>
rust_doc_test(<a href="#rust_doc_test-name">name</a>, <a href="#rust_doc_test-crate">crate</a>, <a href="#rust_doc_test-deps">deps</a>)
</pre>

Runs Rust documentation tests.

Example:

Suppose you have the following directory structure for a Rust library crate:

```output
[workspace]/
WORKSPACE
hello_lib/
    BUILD
    src/
        lib.rs
```

To run [documentation tests][doc-test] for the `hello_lib` crate, define a `rust_doc_test`         target that depends on the `hello_lib` `rust_library` target:

[doc-test]: https://doc.rust-lang.org/book/documentation.html#documentation-as-tests

```python
package(default_visibility = ["//visibility:public"])

load("@rules_rust//rust:defs.bzl", "rust_library", "rust_doc_test")

rust_library(
    name = "hello_lib",
    srcs = ["src/lib.rs"],
)

rust_doc_test(
    name = "hello_lib_doc_test",
    crate = ":hello_lib",
)
```

Running `bazel test //hello_lib:hello_lib_doc_test` will run all documentation tests for the `hello_lib` library crate.


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="rust_doc_test-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="rust_doc_test-crate"></a>crate |  The label of the target to generate code documentation for. <code>rust_doc_test</code> can generate HTML code documentation for the source files of <code>rust_library</code> or <code>rust_binary</code> targets.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |
| <a id="rust_doc_test-deps"></a>deps |  List of other libraries to be linked to this library target.<br><br>These can be either other <code>rust_library</code> targets or <code>cc_library</code> targets if linking a native library.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |


<a id="#rust_grpc_library"></a>

## rust_grpc_library

<pre>
rust_grpc_library(<a href="#rust_grpc_library-name">name</a>, <a href="#rust_grpc_library-deps">deps</a>, <a href="#rust_grpc_library-rust_deps">rust_deps</a>)
</pre>

Builds a Rust library crate from a set of `proto_library`s suitable for gRPC.

Example:

```python
load("//proto:proto.bzl", "rust_grpc_library")

proto_library(
    name = "my_proto",
    srcs = ["my.proto"]
)

rust_grpc_library(
    name = "rust",
    deps = [":my_proto"],
)

rust_binary(
    name = "my_service",
    srcs = ["my_service.rs"],
    deps = [":rust"],
)
```


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="rust_grpc_library-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="rust_grpc_library-deps"></a>deps |  List of proto_library dependencies that will be built. One crate for each proto_library will be created with the corresponding gRPC stubs.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | required |  |
| <a id="rust_grpc_library-rust_deps"></a>rust_deps |  The crates the generated library depends on.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |


<a id="#rust_library"></a>

## rust_library

<pre>
rust_library(<a href="#rust_library-name">name</a>, <a href="#rust_library-aliases">aliases</a>, <a href="#rust_library-compile_data">compile_data</a>, <a href="#rust_library-crate_features">crate_features</a>, <a href="#rust_library-crate_name">crate_name</a>, <a href="#rust_library-crate_root">crate_root</a>, <a href="#rust_library-data">data</a>, <a href="#rust_library-deps">deps</a>,
             <a href="#rust_library-edition">edition</a>, <a href="#rust_library-proc_macro_deps">proc_macro_deps</a>, <a href="#rust_library-rustc_env">rustc_env</a>, <a href="#rust_library-rustc_env_files">rustc_env_files</a>, <a href="#rust_library-rustc_flags">rustc_flags</a>, <a href="#rust_library-srcs">srcs</a>, <a href="#rust_library-stamp">stamp</a>, <a href="#rust_library-version">version</a>)
</pre>

Builds a Rust library crate.

Example:

Suppose you have the following directory structure for a simple Rust library crate:

```output
[workspace]/
    WORKSPACE
    hello_lib/
        BUILD
        src/
            greeter.rs
            lib.rs
```

`hello_lib/src/greeter.rs`:
```rust
pub struct Greeter {
    greeting: String,
}

impl Greeter {
    pub fn new(greeting: &str) -> Greeter {
        Greeter { greeting: greeting.to_string(), }
    }

    pub fn greet(&self, thing: &str) {
        println!("{} {}", &self.greeting, thing);
    }
}
```

`hello_lib/src/lib.rs`:

```rust
pub mod greeter;
```

`hello_lib/BUILD`:
```python
package(default_visibility = ["//visibility:public"])

load("@rules_rust//rust:defs.bzl", "rust_library")

rust_library(
    name = "hello_lib",
    srcs = [
        "src/greeter.rs",
        "src/lib.rs",
    ],
)
```

Build the library:
```output
$ bazel build //hello_lib
INFO: Found 1 target...
Target //examples/rust/hello_lib:hello_lib up-to-date:
bazel-bin/examples/rust/hello_lib/libhello_lib.rlib
INFO: Elapsed time: 1.245s, Critical Path: 1.01s
```


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="rust_library-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="rust_library-aliases"></a>aliases |  Remap crates to a new name or moniker for linkage to this target<br><br>These are other <code>rust_library</code> targets and will be presented as the new name given.   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: Label -> String</a> | optional | {} |
| <a id="rust_library-compile_data"></a>compile_data |  List of files used by this rule at compile time.<br><br>This attribute can be used to specify any data files that are embedded into the library, such as via the [<code>include_str!</code>](https://doc.rust-lang.org/std/macro.include_str!.html) macro.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_library-crate_features"></a>crate_features |  List of features to enable for this crate.<br><br>Features are defined in the code using the <code>#[cfg(feature = "foo")]</code> configuration option. The features listed here will be passed to <code>rustc</code> with <code>--cfg feature="${feature_name}"</code> flags.   | List of strings | optional | [] |
| <a id="rust_library-crate_name"></a>crate_name |  Crate name to use for this target.<br><br>This must be a valid Rust identifier, i.e. it may contain only alphanumeric characters and underscores. Defaults to the target name, with any hyphens replaced by underscores.   | String | optional | "" |
| <a id="rust_library-crate_root"></a>crate_root |  The file that will be passed to <code>rustc</code> to be used for building this crate.<br><br>If <code>crate_root</code> is not set, then this rule will look for a <code>lib.rs</code> file (or <code>main.rs</code> for rust_binary) or the single file in <code>srcs</code> if <code>srcs</code> contains only one file.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="rust_library-data"></a>data |  List of files used by this rule at compile time and runtime.<br><br>If including data at compile time with include_str!() and similar, prefer <code>compile_data</code> over <code>data</code>, to prevent the data also being included in the runfiles.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_library-deps"></a>deps |  List of other libraries to be linked to this library target.<br><br>These can be either other <code>rust_library</code> targets or <code>cc_library</code> targets if linking a native library.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_library-edition"></a>edition |  The rust edition to use for this crate. Defaults to the edition specified in the rust_toolchain.   | String | optional | "" |
| <a id="rust_library-proc_macro_deps"></a>proc_macro_deps |  List of <code>rust_library</code> targets with kind <code>proc-macro</code> used to help build this library target.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_library-rustc_env"></a>rustc_env |  Dictionary of additional <code>"key": "value"</code> environment variables to set for rustc.<br><br>rust_test()/rust_binary() rules can use $(rootpath //package:target) to pass in the location of a generated file or external tool. Cargo build scripts that wish to expand locations should use cargo_build_script()'s build_script_env argument instead, as build scripts are run in a different environment - see cargo_build_script()'s documentation for more.   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | optional | {} |
| <a id="rust_library-rustc_env_files"></a>rustc_env_files |  Files containing additional environment variables to set for rustc.<br><br>These files should  contain a single variable per line, of format <code>NAME=value</code>, and newlines may be included in a value by ending a line with a trailing back-slash (<code>\\</code>).<br><br>The order that these files will be processed is unspecified, so multiple definitions of a particular variable are discouraged.<br><br>Note that the variables here are subject to [workspace status](https://docs.bazel.build/versions/main/user-manual.html#workspace_status) stamping should the <code>stamp</code> attribute be enabled. Stamp variables should be wrapped in brackets in order to be resolved. E.g. <code>NAME={WORKSPACE_STATUS_VARIABLE}</code>.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_library-rustc_flags"></a>rustc_flags |  List of compiler flags passed to <code>rustc</code>.<br><br>These strings are subject to Make variable expansion for predefined source/output path variables like <code>$location</code>, <code>$execpath</code>, and <code>$rootpath</code>. This expansion is useful if you wish to pass a generated file of arguments to rustc: <code>@$(location //package:target)</code>.   | List of strings | optional | [] |
| <a id="rust_library-srcs"></a>srcs |  List of Rust <code>.rs</code> source files used to build the library.<br><br>If <code>srcs</code> contains more than one file, then there must be a file either named <code>lib.rs</code>. Otherwise, <code>crate_root</code> must be set to the source file that is the root of the crate to be passed to rustc to build this crate.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_library-stamp"></a>stamp |  Whether to encode build information into the <code>Rustc</code> action. Possible values:<br><br>- <code>stamp = 1</code>: Always stamp the build information into the <code>Rustc</code> action, even in             [--nostamp](https://docs.bazel.build/versions/main/user-manual.html#flag--stamp) builds.             This setting should be avoided, since it potentially kills remote caching for the target and             any downstream actions that depend on it.<br><br>- <code>stamp = 0</code>: Always replace build information by constant values. This gives good build result caching.<br><br>- <code>stamp = -1</code>: Embedding of build information is controlled by the             [--[no]stamp](https://docs.bazel.build/versions/main/user-manual.html#flag--stamp) flag.<br><br>Stamped targets are not rebuilt unless their dependencies change.<br><br>For example if a <code>rust_library</code> is stamped, and a <code>rust_binary</code> depends on that library, the stamped library won't be rebuilt when we change sources of the <code>rust_binary</code>. This is different from how [<code>cc_library.linkstamps</code>](https://docs.bazel.build/versions/main/be/c-cpp.html#cc_library.linkstamp) behaves.   | Integer | optional | -1 |
| <a id="rust_library-version"></a>version |  A version to inject in the cargo environment variable.   | String | optional | "0.0.0" |


<a id="#rust_proc_macro"></a>

## rust_proc_macro

<pre>
rust_proc_macro(<a href="#rust_proc_macro-name">name</a>, <a href="#rust_proc_macro-aliases">aliases</a>, <a href="#rust_proc_macro-compile_data">compile_data</a>, <a href="#rust_proc_macro-crate_features">crate_features</a>, <a href="#rust_proc_macro-crate_name">crate_name</a>, <a href="#rust_proc_macro-crate_root">crate_root</a>, <a href="#rust_proc_macro-data">data</a>, <a href="#rust_proc_macro-deps">deps</a>,
                <a href="#rust_proc_macro-edition">edition</a>, <a href="#rust_proc_macro-proc_macro_deps">proc_macro_deps</a>, <a href="#rust_proc_macro-rustc_env">rustc_env</a>, <a href="#rust_proc_macro-rustc_env_files">rustc_env_files</a>, <a href="#rust_proc_macro-rustc_flags">rustc_flags</a>, <a href="#rust_proc_macro-srcs">srcs</a>, <a href="#rust_proc_macro-stamp">stamp</a>,
                <a href="#rust_proc_macro-version">version</a>)
</pre>

Builds a Rust proc-macro crate.


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="rust_proc_macro-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="rust_proc_macro-aliases"></a>aliases |  Remap crates to a new name or moniker for linkage to this target<br><br>These are other <code>rust_library</code> targets and will be presented as the new name given.   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: Label -> String</a> | optional | {} |
| <a id="rust_proc_macro-compile_data"></a>compile_data |  List of files used by this rule at compile time.<br><br>This attribute can be used to specify any data files that are embedded into the library, such as via the [<code>include_str!</code>](https://doc.rust-lang.org/std/macro.include_str!.html) macro.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_proc_macro-crate_features"></a>crate_features |  List of features to enable for this crate.<br><br>Features are defined in the code using the <code>#[cfg(feature = "foo")]</code> configuration option. The features listed here will be passed to <code>rustc</code> with <code>--cfg feature="${feature_name}"</code> flags.   | List of strings | optional | [] |
| <a id="rust_proc_macro-crate_name"></a>crate_name |  Crate name to use for this target.<br><br>This must be a valid Rust identifier, i.e. it may contain only alphanumeric characters and underscores. Defaults to the target name, with any hyphens replaced by underscores.   | String | optional | "" |
| <a id="rust_proc_macro-crate_root"></a>crate_root |  The file that will be passed to <code>rustc</code> to be used for building this crate.<br><br>If <code>crate_root</code> is not set, then this rule will look for a <code>lib.rs</code> file (or <code>main.rs</code> for rust_binary) or the single file in <code>srcs</code> if <code>srcs</code> contains only one file.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="rust_proc_macro-data"></a>data |  List of files used by this rule at compile time and runtime.<br><br>If including data at compile time with include_str!() and similar, prefer <code>compile_data</code> over <code>data</code>, to prevent the data also being included in the runfiles.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_proc_macro-deps"></a>deps |  List of other libraries to be linked to this library target.<br><br>These can be either other <code>rust_library</code> targets or <code>cc_library</code> targets if linking a native library.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_proc_macro-edition"></a>edition |  The rust edition to use for this crate. Defaults to the edition specified in the rust_toolchain.   | String | optional | "" |
| <a id="rust_proc_macro-proc_macro_deps"></a>proc_macro_deps |  List of <code>rust_library</code> targets with kind <code>proc-macro</code> used to help build this library target.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_proc_macro-rustc_env"></a>rustc_env |  Dictionary of additional <code>"key": "value"</code> environment variables to set for rustc.<br><br>rust_test()/rust_binary() rules can use $(rootpath //package:target) to pass in the location of a generated file or external tool. Cargo build scripts that wish to expand locations should use cargo_build_script()'s build_script_env argument instead, as build scripts are run in a different environment - see cargo_build_script()'s documentation for more.   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | optional | {} |
| <a id="rust_proc_macro-rustc_env_files"></a>rustc_env_files |  Files containing additional environment variables to set for rustc.<br><br>These files should  contain a single variable per line, of format <code>NAME=value</code>, and newlines may be included in a value by ending a line with a trailing back-slash (<code>\\</code>).<br><br>The order that these files will be processed is unspecified, so multiple definitions of a particular variable are discouraged.<br><br>Note that the variables here are subject to [workspace status](https://docs.bazel.build/versions/main/user-manual.html#workspace_status) stamping should the <code>stamp</code> attribute be enabled. Stamp variables should be wrapped in brackets in order to be resolved. E.g. <code>NAME={WORKSPACE_STATUS_VARIABLE}</code>.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_proc_macro-rustc_flags"></a>rustc_flags |  List of compiler flags passed to <code>rustc</code>.<br><br>These strings are subject to Make variable expansion for predefined source/output path variables like <code>$location</code>, <code>$execpath</code>, and <code>$rootpath</code>. This expansion is useful if you wish to pass a generated file of arguments to rustc: <code>@$(location //package:target)</code>.   | List of strings | optional | [] |
| <a id="rust_proc_macro-srcs"></a>srcs |  List of Rust <code>.rs</code> source files used to build the library.<br><br>If <code>srcs</code> contains more than one file, then there must be a file either named <code>lib.rs</code>. Otherwise, <code>crate_root</code> must be set to the source file that is the root of the crate to be passed to rustc to build this crate.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_proc_macro-stamp"></a>stamp |  Whether to encode build information into the <code>Rustc</code> action. Possible values:<br><br>- <code>stamp = 1</code>: Always stamp the build information into the <code>Rustc</code> action, even in             [--nostamp](https://docs.bazel.build/versions/main/user-manual.html#flag--stamp) builds.             This setting should be avoided, since it potentially kills remote caching for the target and             any downstream actions that depend on it.<br><br>- <code>stamp = 0</code>: Always replace build information by constant values. This gives good build result caching.<br><br>- <code>stamp = -1</code>: Embedding of build information is controlled by the             [--[no]stamp](https://docs.bazel.build/versions/main/user-manual.html#flag--stamp) flag.<br><br>Stamped targets are not rebuilt unless their dependencies change.<br><br>For example if a <code>rust_library</code> is stamped, and a <code>rust_binary</code> depends on that library, the stamped library won't be rebuilt when we change sources of the <code>rust_binary</code>. This is different from how [<code>cc_library.linkstamps</code>](https://docs.bazel.build/versions/main/be/c-cpp.html#cc_library.linkstamp) behaves.   | Integer | optional | -1 |
| <a id="rust_proc_macro-version"></a>version |  A version to inject in the cargo environment variable.   | String | optional | "0.0.0" |


<a id="#rust_proto_library"></a>

## rust_proto_library

<pre>
rust_proto_library(<a href="#rust_proto_library-name">name</a>, <a href="#rust_proto_library-deps">deps</a>, <a href="#rust_proto_library-rust_deps">rust_deps</a>)
</pre>

Builds a Rust library crate from a set of `proto_library`s.

Example:

```python
load("@rules_rust//proto:proto.bzl", "rust_proto_library")

proto_library(
    name = "my_proto",
    srcs = ["my.proto"]
)

rust_proto_library(
    name = "rust",
    deps = [":my_proto"],
)

rust_binary(
    name = "my_proto_binary",
    srcs = ["my_proto_binary.rs"],
    deps = [":rust"],
)
```


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="rust_proto_library-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="rust_proto_library-deps"></a>deps |  List of proto_library dependencies that will be built. One crate for each proto_library will be created with the corresponding stubs.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | required |  |
| <a id="rust_proto_library-rust_deps"></a>rust_deps |  The crates the generated library depends on.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |


<a id="#rust_proto_toolchain"></a>

## rust_proto_toolchain

<pre>
rust_proto_toolchain(<a href="#rust_proto_toolchain-name">name</a>, <a href="#rust_proto_toolchain-edition">edition</a>, <a href="#rust_proto_toolchain-grpc_compile_deps">grpc_compile_deps</a>, <a href="#rust_proto_toolchain-grpc_plugin">grpc_plugin</a>, <a href="#rust_proto_toolchain-proto_compile_deps">proto_compile_deps</a>,
                     <a href="#rust_proto_toolchain-proto_plugin">proto_plugin</a>, <a href="#rust_proto_toolchain-protoc">protoc</a>)
</pre>

Declares a Rust Proto toolchain for use.

This is used to configure proto compilation and can be used to set different protobuf compiler plugin.

Example:

Suppose a new nicer gRPC plugin has came out. The new plugin can be used in Bazel by defining a new toolchain definition and declaration:

```python
load('@rules_rust//proto:toolchain.bzl', 'rust_proto_toolchain')

rust_proto_toolchain(
   name="rust_proto_impl",
   grpc_plugin="@rust_grpc//:grpc_plugin",
   grpc_compile_deps=["@rust_grpc//:grpc_deps"],
)

toolchain(
    name="rust_proto",
    exec_compatible_with = [
        "@platforms//cpu:cpuX",
    ],
    target_compatible_with = [
        "@platforms//cpu:cpuX",
    ],
    toolchain = ":rust_proto_impl",
)
```

Then, either add the label of the toolchain rule to register_toolchains in the WORKSPACE, or pass it to the `--extra_toolchains` flag for Bazel, and it will be used.

See @rules_rust//proto:BUILD for examples of defining the toolchain.


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="rust_proto_toolchain-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="rust_proto_toolchain-edition"></a>edition |  The edition used by the generated rust source.   | String | optional | "" |
| <a id="rust_proto_toolchain-grpc_compile_deps"></a>grpc_compile_deps |  The crates the generated grpc libraries depends on.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [Label("//proto/raze:protobuf"), Label("//proto/raze:grpc"), Label("//proto/raze:tls_api"), Label("//proto/raze:tls_api_stub")] |
| <a id="rust_proto_toolchain-grpc_plugin"></a>grpc_plugin |  The location of the Rust protobuf compiler plugin to generate rust gRPC stubs.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | //proto:protoc_gen_rust_grpc |
| <a id="rust_proto_toolchain-proto_compile_deps"></a>proto_compile_deps |  The crates the generated protobuf libraries depends on.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [Label("//proto/raze:protobuf")] |
| <a id="rust_proto_toolchain-proto_plugin"></a>proto_plugin |  The location of the Rust protobuf compiler plugin used to generate rust sources.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | //proto:protoc_gen_rust |
| <a id="rust_proto_toolchain-protoc"></a>protoc |  The location of the <code>protoc</code> binary. It should be an executable target.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | @com_google_protobuf//:protoc |


<a id="#rust_shared_library"></a>

## rust_shared_library

<pre>
rust_shared_library(<a href="#rust_shared_library-name">name</a>, <a href="#rust_shared_library-aliases">aliases</a>, <a href="#rust_shared_library-compile_data">compile_data</a>, <a href="#rust_shared_library-crate_features">crate_features</a>, <a href="#rust_shared_library-crate_name">crate_name</a>, <a href="#rust_shared_library-crate_root">crate_root</a>, <a href="#rust_shared_library-data">data</a>, <a href="#rust_shared_library-deps">deps</a>,
                    <a href="#rust_shared_library-edition">edition</a>, <a href="#rust_shared_library-proc_macro_deps">proc_macro_deps</a>, <a href="#rust_shared_library-rustc_env">rustc_env</a>, <a href="#rust_shared_library-rustc_env_files">rustc_env_files</a>, <a href="#rust_shared_library-rustc_flags">rustc_flags</a>, <a href="#rust_shared_library-srcs">srcs</a>, <a href="#rust_shared_library-stamp">stamp</a>,
                    <a href="#rust_shared_library-version">version</a>)
</pre>

Builds a Rust shared library.

This shared library will contain all transitively reachable crates and native objects.
It is meant to be used when producing an artifact that is then consumed by some other build system
(for example to produce a shared library that Python program links against).

This rule provides CcInfo, so it can be used everywhere Bazel expects `rules_cc`.

When building the whole binary in Bazel, use `rust_library` instead.


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="rust_shared_library-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="rust_shared_library-aliases"></a>aliases |  Remap crates to a new name or moniker for linkage to this target<br><br>These are other <code>rust_library</code> targets and will be presented as the new name given.   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: Label -> String</a> | optional | {} |
| <a id="rust_shared_library-compile_data"></a>compile_data |  List of files used by this rule at compile time.<br><br>This attribute can be used to specify any data files that are embedded into the library, such as via the [<code>include_str!</code>](https://doc.rust-lang.org/std/macro.include_str!.html) macro.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_shared_library-crate_features"></a>crate_features |  List of features to enable for this crate.<br><br>Features are defined in the code using the <code>#[cfg(feature = "foo")]</code> configuration option. The features listed here will be passed to <code>rustc</code> with <code>--cfg feature="${feature_name}"</code> flags.   | List of strings | optional | [] |
| <a id="rust_shared_library-crate_name"></a>crate_name |  Crate name to use for this target.<br><br>This must be a valid Rust identifier, i.e. it may contain only alphanumeric characters and underscores. Defaults to the target name, with any hyphens replaced by underscores.   | String | optional | "" |
| <a id="rust_shared_library-crate_root"></a>crate_root |  The file that will be passed to <code>rustc</code> to be used for building this crate.<br><br>If <code>crate_root</code> is not set, then this rule will look for a <code>lib.rs</code> file (or <code>main.rs</code> for rust_binary) or the single file in <code>srcs</code> if <code>srcs</code> contains only one file.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="rust_shared_library-data"></a>data |  List of files used by this rule at compile time and runtime.<br><br>If including data at compile time with include_str!() and similar, prefer <code>compile_data</code> over <code>data</code>, to prevent the data also being included in the runfiles.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_shared_library-deps"></a>deps |  List of other libraries to be linked to this library target.<br><br>These can be either other <code>rust_library</code> targets or <code>cc_library</code> targets if linking a native library.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_shared_library-edition"></a>edition |  The rust edition to use for this crate. Defaults to the edition specified in the rust_toolchain.   | String | optional | "" |
| <a id="rust_shared_library-proc_macro_deps"></a>proc_macro_deps |  List of <code>rust_library</code> targets with kind <code>proc-macro</code> used to help build this library target.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_shared_library-rustc_env"></a>rustc_env |  Dictionary of additional <code>"key": "value"</code> environment variables to set for rustc.<br><br>rust_test()/rust_binary() rules can use $(rootpath //package:target) to pass in the location of a generated file or external tool. Cargo build scripts that wish to expand locations should use cargo_build_script()'s build_script_env argument instead, as build scripts are run in a different environment - see cargo_build_script()'s documentation for more.   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | optional | {} |
| <a id="rust_shared_library-rustc_env_files"></a>rustc_env_files |  Files containing additional environment variables to set for rustc.<br><br>These files should  contain a single variable per line, of format <code>NAME=value</code>, and newlines may be included in a value by ending a line with a trailing back-slash (<code>\\</code>).<br><br>The order that these files will be processed is unspecified, so multiple definitions of a particular variable are discouraged.<br><br>Note that the variables here are subject to [workspace status](https://docs.bazel.build/versions/main/user-manual.html#workspace_status) stamping should the <code>stamp</code> attribute be enabled. Stamp variables should be wrapped in brackets in order to be resolved. E.g. <code>NAME={WORKSPACE_STATUS_VARIABLE}</code>.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_shared_library-rustc_flags"></a>rustc_flags |  List of compiler flags passed to <code>rustc</code>.<br><br>These strings are subject to Make variable expansion for predefined source/output path variables like <code>$location</code>, <code>$execpath</code>, and <code>$rootpath</code>. This expansion is useful if you wish to pass a generated file of arguments to rustc: <code>@$(location //package:target)</code>.   | List of strings | optional | [] |
| <a id="rust_shared_library-srcs"></a>srcs |  List of Rust <code>.rs</code> source files used to build the library.<br><br>If <code>srcs</code> contains more than one file, then there must be a file either named <code>lib.rs</code>. Otherwise, <code>crate_root</code> must be set to the source file that is the root of the crate to be passed to rustc to build this crate.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_shared_library-stamp"></a>stamp |  Whether to encode build information into the <code>Rustc</code> action. Possible values:<br><br>- <code>stamp = 1</code>: Always stamp the build information into the <code>Rustc</code> action, even in             [--nostamp](https://docs.bazel.build/versions/main/user-manual.html#flag--stamp) builds.             This setting should be avoided, since it potentially kills remote caching for the target and             any downstream actions that depend on it.<br><br>- <code>stamp = 0</code>: Always replace build information by constant values. This gives good build result caching.<br><br>- <code>stamp = -1</code>: Embedding of build information is controlled by the             [--[no]stamp](https://docs.bazel.build/versions/main/user-manual.html#flag--stamp) flag.<br><br>Stamped targets are not rebuilt unless their dependencies change.<br><br>For example if a <code>rust_library</code> is stamped, and a <code>rust_binary</code> depends on that library, the stamped library won't be rebuilt when we change sources of the <code>rust_binary</code>. This is different from how [<code>cc_library.linkstamps</code>](https://docs.bazel.build/versions/main/be/c-cpp.html#cc_library.linkstamp) behaves.   | Integer | optional | -1 |
| <a id="rust_shared_library-version"></a>version |  A version to inject in the cargo environment variable.   | String | optional | "0.0.0" |


<a id="#rust_static_library"></a>

## rust_static_library

<pre>
rust_static_library(<a href="#rust_static_library-name">name</a>, <a href="#rust_static_library-aliases">aliases</a>, <a href="#rust_static_library-compile_data">compile_data</a>, <a href="#rust_static_library-crate_features">crate_features</a>, <a href="#rust_static_library-crate_name">crate_name</a>, <a href="#rust_static_library-crate_root">crate_root</a>, <a href="#rust_static_library-data">data</a>, <a href="#rust_static_library-deps">deps</a>,
                    <a href="#rust_static_library-edition">edition</a>, <a href="#rust_static_library-proc_macro_deps">proc_macro_deps</a>, <a href="#rust_static_library-rustc_env">rustc_env</a>, <a href="#rust_static_library-rustc_env_files">rustc_env_files</a>, <a href="#rust_static_library-rustc_flags">rustc_flags</a>, <a href="#rust_static_library-srcs">srcs</a>, <a href="#rust_static_library-stamp">stamp</a>,
                    <a href="#rust_static_library-version">version</a>)
</pre>

Builds a Rust static library.

This static library will contain all transitively reachable crates and native objects.
It is meant to be used when producing an artifact that is then consumed by some other build system
(for example to produce an archive that Python program links against).

This rule provides CcInfo, so it can be used everywhere Bazel expects `rules_cc`.

When building the whole binary in Bazel, use `rust_library` instead.


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="rust_static_library-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="rust_static_library-aliases"></a>aliases |  Remap crates to a new name or moniker for linkage to this target<br><br>These are other <code>rust_library</code> targets and will be presented as the new name given.   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: Label -> String</a> | optional | {} |
| <a id="rust_static_library-compile_data"></a>compile_data |  List of files used by this rule at compile time.<br><br>This attribute can be used to specify any data files that are embedded into the library, such as via the [<code>include_str!</code>](https://doc.rust-lang.org/std/macro.include_str!.html) macro.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_static_library-crate_features"></a>crate_features |  List of features to enable for this crate.<br><br>Features are defined in the code using the <code>#[cfg(feature = "foo")]</code> configuration option. The features listed here will be passed to <code>rustc</code> with <code>--cfg feature="${feature_name}"</code> flags.   | List of strings | optional | [] |
| <a id="rust_static_library-crate_name"></a>crate_name |  Crate name to use for this target.<br><br>This must be a valid Rust identifier, i.e. it may contain only alphanumeric characters and underscores. Defaults to the target name, with any hyphens replaced by underscores.   | String | optional | "" |
| <a id="rust_static_library-crate_root"></a>crate_root |  The file that will be passed to <code>rustc</code> to be used for building this crate.<br><br>If <code>crate_root</code> is not set, then this rule will look for a <code>lib.rs</code> file (or <code>main.rs</code> for rust_binary) or the single file in <code>srcs</code> if <code>srcs</code> contains only one file.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="rust_static_library-data"></a>data |  List of files used by this rule at compile time and runtime.<br><br>If including data at compile time with include_str!() and similar, prefer <code>compile_data</code> over <code>data</code>, to prevent the data also being included in the runfiles.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_static_library-deps"></a>deps |  List of other libraries to be linked to this library target.<br><br>These can be either other <code>rust_library</code> targets or <code>cc_library</code> targets if linking a native library.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_static_library-edition"></a>edition |  The rust edition to use for this crate. Defaults to the edition specified in the rust_toolchain.   | String | optional | "" |
| <a id="rust_static_library-proc_macro_deps"></a>proc_macro_deps |  List of <code>rust_library</code> targets with kind <code>proc-macro</code> used to help build this library target.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_static_library-rustc_env"></a>rustc_env |  Dictionary of additional <code>"key": "value"</code> environment variables to set for rustc.<br><br>rust_test()/rust_binary() rules can use $(rootpath //package:target) to pass in the location of a generated file or external tool. Cargo build scripts that wish to expand locations should use cargo_build_script()'s build_script_env argument instead, as build scripts are run in a different environment - see cargo_build_script()'s documentation for more.   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | optional | {} |
| <a id="rust_static_library-rustc_env_files"></a>rustc_env_files |  Files containing additional environment variables to set for rustc.<br><br>These files should  contain a single variable per line, of format <code>NAME=value</code>, and newlines may be included in a value by ending a line with a trailing back-slash (<code>\\</code>).<br><br>The order that these files will be processed is unspecified, so multiple definitions of a particular variable are discouraged.<br><br>Note that the variables here are subject to [workspace status](https://docs.bazel.build/versions/main/user-manual.html#workspace_status) stamping should the <code>stamp</code> attribute be enabled. Stamp variables should be wrapped in brackets in order to be resolved. E.g. <code>NAME={WORKSPACE_STATUS_VARIABLE}</code>.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_static_library-rustc_flags"></a>rustc_flags |  List of compiler flags passed to <code>rustc</code>.<br><br>These strings are subject to Make variable expansion for predefined source/output path variables like <code>$location</code>, <code>$execpath</code>, and <code>$rootpath</code>. This expansion is useful if you wish to pass a generated file of arguments to rustc: <code>@$(location //package:target)</code>.   | List of strings | optional | [] |
| <a id="rust_static_library-srcs"></a>srcs |  List of Rust <code>.rs</code> source files used to build the library.<br><br>If <code>srcs</code> contains more than one file, then there must be a file either named <code>lib.rs</code>. Otherwise, <code>crate_root</code> must be set to the source file that is the root of the crate to be passed to rustc to build this crate.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_static_library-stamp"></a>stamp |  Whether to encode build information into the <code>Rustc</code> action. Possible values:<br><br>- <code>stamp = 1</code>: Always stamp the build information into the <code>Rustc</code> action, even in             [--nostamp](https://docs.bazel.build/versions/main/user-manual.html#flag--stamp) builds.             This setting should be avoided, since it potentially kills remote caching for the target and             any downstream actions that depend on it.<br><br>- <code>stamp = 0</code>: Always replace build information by constant values. This gives good build result caching.<br><br>- <code>stamp = -1</code>: Embedding of build information is controlled by the             [--[no]stamp](https://docs.bazel.build/versions/main/user-manual.html#flag--stamp) flag.<br><br>Stamped targets are not rebuilt unless their dependencies change.<br><br>For example if a <code>rust_library</code> is stamped, and a <code>rust_binary</code> depends on that library, the stamped library won't be rebuilt when we change sources of the <code>rust_binary</code>. This is different from how [<code>cc_library.linkstamps</code>](https://docs.bazel.build/versions/main/be/c-cpp.html#cc_library.linkstamp) behaves.   | Integer | optional | -1 |
| <a id="rust_static_library-version"></a>version |  A version to inject in the cargo environment variable.   | String | optional | "0.0.0" |


<a id="#rust_stdlib_filegroup"></a>

## rust_stdlib_filegroup

<pre>
rust_stdlib_filegroup(<a href="#rust_stdlib_filegroup-name">name</a>, <a href="#rust_stdlib_filegroup-srcs">srcs</a>)
</pre>

A dedicated filegroup-like rule for Rust stdlib artifacts.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="rust_stdlib_filegroup-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="rust_stdlib_filegroup-srcs"></a>srcs |  The list of targets/files that are components of the rust-stdlib file group   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | required |  |


<a id="#rust_test"></a>

## rust_test

<pre>
rust_test(<a href="#rust_test-name">name</a>, <a href="#rust_test-aliases">aliases</a>, <a href="#rust_test-compile_data">compile_data</a>, <a href="#rust_test-crate">crate</a>, <a href="#rust_test-crate_features">crate_features</a>, <a href="#rust_test-crate_name">crate_name</a>, <a href="#rust_test-crate_root">crate_root</a>, <a href="#rust_test-data">data</a>, <a href="#rust_test-deps">deps</a>,
          <a href="#rust_test-edition">edition</a>, <a href="#rust_test-env">env</a>, <a href="#rust_test-proc_macro_deps">proc_macro_deps</a>, <a href="#rust_test-rustc_env">rustc_env</a>, <a href="#rust_test-rustc_env_files">rustc_env_files</a>, <a href="#rust_test-rustc_flags">rustc_flags</a>, <a href="#rust_test-srcs">srcs</a>, <a href="#rust_test-stamp">stamp</a>,
          <a href="#rust_test-use_libtest_harness">use_libtest_harness</a>, <a href="#rust_test-version">version</a>)
</pre>

Builds a Rust test crate.

Examples:

Suppose you have the following directory structure for a Rust library crate         with unit test code in the library sources:

```output
[workspace]/
    WORKSPACE
    hello_lib/
        BUILD
        src/
            lib.rs
```

`hello_lib/src/lib.rs`:
```rust
pub struct Greeter {
    greeting: String,
}

impl Greeter {
    pub fn new(greeting: &str) -> Greeter {
        Greeter { greeting: greeting.to_string(), }
    }

    pub fn greet(&self, thing: &str) -> String {
        format!("{} {}", &self.greeting, thing)
    }
}

#[cfg(test)]
mod test {
    use super::Greeter;

    #[test]
    fn test_greeting() {
        let hello = Greeter::new("Hi");
        assert_eq!("Hi Rust", hello.greet("Rust"));
    }
}
```

To build and run the tests, simply add a `rust_test` rule with no `srcs`
and only depends on the `hello_lib` `rust_library` target via the
`crate` attribute:

`hello_lib/BUILD`:
```python
load("@rules_rust//rust:defs.bzl", "rust_library", "rust_test")

rust_library(
    name = "hello_lib",
    srcs = ["src/lib.rs"],
)

rust_test(
    name = "hello_lib_test",
    crate = ":hello_lib",
    # You may add other deps that are specific to the test configuration
    deps = ["//some/dev/dep"],
```

Run the test with `bazel test //hello_lib:hello_lib_test`. The crate
will be built using the same crate name as the underlying ":hello_lib"
crate.

### Example: `test` directory

Integration tests that live in the [`tests` directory][int-tests], they are         essentially built as separate crates. Suppose you have the following directory         structure where `greeting.rs` is an integration test for the `hello_lib`         library crate:

[int-tests]: http://doc.rust-lang.org/book/testing.html#the-tests-directory

```output
[workspace]/
    WORKSPACE
    hello_lib/
        BUILD
        src/
            lib.rs
        tests/
            greeting.rs
```

`hello_lib/tests/greeting.rs`:
```rust
extern crate hello_lib;

use hello_lib;

#[test]
fn test_greeting() {
    let hello = greeter::Greeter::new("Hello");
    assert_eq!("Hello world", hello.greeting("world"));
}
```

To build the `greeting.rs` integration test, simply add a `rust_test` target
with `greeting.rs` in `srcs` and a dependency on the `hello_lib` target:

`hello_lib/BUILD`:
```python
load("@rules_rust//rust:defs.bzl", "rust_library", "rust_test")

rust_library(
    name = "hello_lib",
    srcs = ["src/lib.rs"],
)

rust_test(
    name = "greeting_test",
    srcs = ["tests/greeting.rs"],
    deps = [":hello_lib"],
)
```

Run the test with `bazel test //hello_lib:greeting_test`.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="rust_test-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="rust_test-aliases"></a>aliases |  Remap crates to a new name or moniker for linkage to this target<br><br>These are other <code>rust_library</code> targets and will be presented as the new name given.   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: Label -> String</a> | optional | {} |
| <a id="rust_test-compile_data"></a>compile_data |  List of files used by this rule at compile time.<br><br>This attribute can be used to specify any data files that are embedded into the library, such as via the [<code>include_str!</code>](https://doc.rust-lang.org/std/macro.include_str!.html) macro.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_test-crate"></a>crate |  Target inline tests declared in the given crate<br><br>These tests are typically those that would be held out under <code>#[cfg(test)]</code> declarations.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="rust_test-crate_features"></a>crate_features |  List of features to enable for this crate.<br><br>Features are defined in the code using the <code>#[cfg(feature = "foo")]</code> configuration option. The features listed here will be passed to <code>rustc</code> with <code>--cfg feature="${feature_name}"</code> flags.   | List of strings | optional | [] |
| <a id="rust_test-crate_name"></a>crate_name |  Crate name to use for this target.<br><br>This must be a valid Rust identifier, i.e. it may contain only alphanumeric characters and underscores. Defaults to the target name, with any hyphens replaced by underscores.   | String | optional | "" |
| <a id="rust_test-crate_root"></a>crate_root |  The file that will be passed to <code>rustc</code> to be used for building this crate.<br><br>If <code>crate_root</code> is not set, then this rule will look for a <code>lib.rs</code> file (or <code>main.rs</code> for rust_binary) or the single file in <code>srcs</code> if <code>srcs</code> contains only one file.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="rust_test-data"></a>data |  List of files used by this rule at compile time and runtime.<br><br>If including data at compile time with include_str!() and similar, prefer <code>compile_data</code> over <code>data</code>, to prevent the data also being included in the runfiles.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_test-deps"></a>deps |  List of other libraries to be linked to this library target.<br><br>These can be either other <code>rust_library</code> targets or <code>cc_library</code> targets if linking a native library.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_test-edition"></a>edition |  The rust edition to use for this crate. Defaults to the edition specified in the rust_toolchain.   | String | optional | "" |
| <a id="rust_test-env"></a>env |  Specifies additional environment variables to set when the test is executed by bazel test. Values are subject to <code>$(rootpath)</code>, <code>$(execpath)</code>, location, and ["Make variable"](https://docs.bazel.build/versions/master/be/make-variables.html) substitution.<br><br>Execpath returns absolute path, and in order to be able to construct the absolute path we need to wrap the test binary in a launcher. Using a launcher comes with complications, such as more complicated debugger attachment.   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | optional | {} |
| <a id="rust_test-proc_macro_deps"></a>proc_macro_deps |  List of <code>rust_library</code> targets with kind <code>proc-macro</code> used to help build this library target.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_test-rustc_env"></a>rustc_env |  Dictionary of additional <code>"key": "value"</code> environment variables to set for rustc.<br><br>rust_test()/rust_binary() rules can use $(rootpath //package:target) to pass in the location of a generated file or external tool. Cargo build scripts that wish to expand locations should use cargo_build_script()'s build_script_env argument instead, as build scripts are run in a different environment - see cargo_build_script()'s documentation for more.   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | optional | {} |
| <a id="rust_test-rustc_env_files"></a>rustc_env_files |  Files containing additional environment variables to set for rustc.<br><br>These files should  contain a single variable per line, of format <code>NAME=value</code>, and newlines may be included in a value by ending a line with a trailing back-slash (<code>\\</code>).<br><br>The order that these files will be processed is unspecified, so multiple definitions of a particular variable are discouraged.<br><br>Note that the variables here are subject to [workspace status](https://docs.bazel.build/versions/main/user-manual.html#workspace_status) stamping should the <code>stamp</code> attribute be enabled. Stamp variables should be wrapped in brackets in order to be resolved. E.g. <code>NAME={WORKSPACE_STATUS_VARIABLE}</code>.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_test-rustc_flags"></a>rustc_flags |  List of compiler flags passed to <code>rustc</code>.<br><br>These strings are subject to Make variable expansion for predefined source/output path variables like <code>$location</code>, <code>$execpath</code>, and <code>$rootpath</code>. This expansion is useful if you wish to pass a generated file of arguments to rustc: <code>@$(location //package:target)</code>.   | List of strings | optional | [] |
| <a id="rust_test-srcs"></a>srcs |  List of Rust <code>.rs</code> source files used to build the library.<br><br>If <code>srcs</code> contains more than one file, then there must be a file either named <code>lib.rs</code>. Otherwise, <code>crate_root</code> must be set to the source file that is the root of the crate to be passed to rustc to build this crate.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="rust_test-stamp"></a>stamp |  Whether to encode build information into the <code>Rustc</code> action. Possible values:<br><br>- <code>stamp = 1</code>: Always stamp the build information into the <code>Rustc</code> action, even in             [--nostamp](https://docs.bazel.build/versions/main/user-manual.html#flag--stamp) builds.             This setting should be avoided, since it potentially kills remote caching for the target and             any downstream actions that depend on it.<br><br>- <code>stamp = 0</code>: Always replace build information by constant values. This gives good build result caching.<br><br>- <code>stamp = -1</code>: Embedding of build information is controlled by the             [--[no]stamp](https://docs.bazel.build/versions/main/user-manual.html#flag--stamp) flag.<br><br>Stamped targets are not rebuilt unless their dependencies change.<br><br>For example if a <code>rust_library</code> is stamped, and a <code>rust_binary</code> depends on that library, the stamped library won't be rebuilt when we change sources of the <code>rust_binary</code>. This is different from how [<code>cc_library.linkstamps</code>](https://docs.bazel.build/versions/main/be/c-cpp.html#cc_library.linkstamp) behaves.   | Integer | optional | -1 |
| <a id="rust_test-use_libtest_harness"></a>use_libtest_harness |  Whether to use <code>libtest</code>. For targets using this flag, individual tests can be run by using the [--test_arg](https://docs.bazel.build/versions/4.0.0/command-line-reference.html#flag--test_arg) flag. E.g. <code>bazel test //src:rust_test --test_arg=foo::test::test_fn</code>.   | Boolean | optional | True |
| <a id="rust_test-version"></a>version |  A version to inject in the cargo environment variable.   | String | optional | "0.0.0" |


<a id="#rust_toolchain"></a>

## rust_toolchain

<pre>
rust_toolchain(<a href="#rust_toolchain-name">name</a>, <a href="#rust_toolchain-allocator_library">allocator_library</a>, <a href="#rust_toolchain-binary_ext">binary_ext</a>, <a href="#rust_toolchain-cargo">cargo</a>, <a href="#rust_toolchain-clippy_driver">clippy_driver</a>, <a href="#rust_toolchain-debug_info">debug_info</a>,
               <a href="#rust_toolchain-default_edition">default_edition</a>, <a href="#rust_toolchain-dylib_ext">dylib_ext</a>, <a href="#rust_toolchain-env">env</a>, <a href="#rust_toolchain-exec_triple">exec_triple</a>, <a href="#rust_toolchain-llvm_tools">llvm_tools</a>, <a href="#rust_toolchain-opt_level">opt_level</a>, <a href="#rust_toolchain-os">os</a>, <a href="#rust_toolchain-rust_doc">rust_doc</a>,
               <a href="#rust_toolchain-rust_lib">rust_lib</a>, <a href="#rust_toolchain-rust_std">rust_std</a>, <a href="#rust_toolchain-rustc">rustc</a>, <a href="#rust_toolchain-rustc_lib">rustc_lib</a>, <a href="#rust_toolchain-rustc_srcs">rustc_srcs</a>, <a href="#rust_toolchain-rustfmt">rustfmt</a>, <a href="#rust_toolchain-staticlib_ext">staticlib_ext</a>,
               <a href="#rust_toolchain-stdlib_linkflags">stdlib_linkflags</a>, <a href="#rust_toolchain-target_json">target_json</a>, <a href="#rust_toolchain-target_triple">target_triple</a>)
</pre>

Declares a Rust toolchain for use.

This is for declaring a custom toolchain, eg. for configuring a particular version of rust or supporting a new platform.

Example:

Suppose the core rust team has ported the compiler to a new target CPU, called `cpuX`. This support can be used in Bazel by defining a new toolchain definition and declaration:

```python
load('@rules_rust//rust:toolchain.bzl', 'rust_toolchain')

rust_toolchain(
    name = "rust_cpuX_impl",
    rustc = "@rust_cpuX//:rustc",
    rustc_lib = "@rust_cpuX//:rustc_lib",
    rust_std = "@rust_cpuX//:rust_std",
    rust_doc = "@rust_cpuX//:rustdoc",
    binary_ext = "",
    staticlib_ext = ".a",
    dylib_ext = ".so",
    stdlib_linkflags = ["-lpthread", "-ldl"],
    os = "linux",
)

toolchain(
    name = "rust_cpuX",
    exec_compatible_with = [
        "@platforms//cpu:cpuX",
    ],
    target_compatible_with = [
        "@platforms//cpu:cpuX",
    ],
    toolchain = ":rust_cpuX_impl",
)
```

Then, either add the label of the toolchain rule to `register_toolchains` in the WORKSPACE, or pass it to the `"--extra_toolchains"` flag for Bazel, and it will be used.

See @rules_rust//rust:repositories.bzl for examples of defining the @rust_cpuX repository with the actual binaries and libraries.


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="rust_toolchain-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="rust_toolchain-allocator_library"></a>allocator_library |  Target that provides allocator functions when rust_library targets are embedded in a cc_binary.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="rust_toolchain-binary_ext"></a>binary_ext |  The extension for binaries created from rustc.   | String | required |  |
| <a id="rust_toolchain-cargo"></a>cargo |  The location of the <code>cargo</code> binary. Can be a direct source or a filegroup containing one item.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="rust_toolchain-clippy_driver"></a>clippy_driver |  The location of the <code>clippy-driver</code> binary. Can be a direct source or a filegroup containing one item.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="rust_toolchain-debug_info"></a>debug_info |  Rustc debug info levels per opt level   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | optional | {"dbg": "2", "fastbuild": "0", "opt": "0"} |
| <a id="rust_toolchain-default_edition"></a>default_edition |  The edition to use for rust_* rules that don't specify an edition. If absent, every rule is required to specify its <code>edition</code> attribute.   | String | optional | "" |
| <a id="rust_toolchain-dylib_ext"></a>dylib_ext |  The extension for dynamic libraries created from rustc.   | String | required |  |
| <a id="rust_toolchain-env"></a>env |  Environment variables to set in actions.   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | optional | {} |
| <a id="rust_toolchain-exec_triple"></a>exec_triple |  The platform triple for the toolchains execution environment. For more details see: https://docs.bazel.build/versions/master/skylark/rules.html#configurations   | String | required |  |
| <a id="rust_toolchain-llvm_tools"></a>llvm_tools |  LLVM tools that are shipped with the Rust toolchain.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="rust_toolchain-opt_level"></a>opt_level |  Rustc optimization levels.   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | optional | {"dbg": "0", "fastbuild": "0", "opt": "3"} |
| <a id="rust_toolchain-os"></a>os |  The operating system for the current toolchain   | String | required |  |
| <a id="rust_toolchain-rust_doc"></a>rust_doc |  The location of the <code>rustdoc</code> binary. Can be a direct source or a filegroup containing one item.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |
| <a id="rust_toolchain-rust_lib"></a>rust_lib |  **Deprecated**: Use <code>rust_std</code>   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="rust_toolchain-rust_std"></a>rust_std |  The Rust standard library.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="rust_toolchain-rustc"></a>rustc |  The location of the <code>rustc</code> binary. Can be a direct source or a filegroup containing one item.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |
| <a id="rust_toolchain-rustc_lib"></a>rustc_lib |  The libraries used by rustc during compilation.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="rust_toolchain-rustc_srcs"></a>rustc_srcs |  The source code of rustc.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="rust_toolchain-rustfmt"></a>rustfmt |  The location of the <code>rustfmt</code> binary. Can be a direct source or a filegroup containing one item.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="rust_toolchain-staticlib_ext"></a>staticlib_ext |  The extension for static libraries created from rustc.   | String | required |  |
| <a id="rust_toolchain-stdlib_linkflags"></a>stdlib_linkflags |  Additional linker flags to use when Rust standard library is linked by a C++ linker (rustc will deal with these automatically). Subject to location expansion with respect to the srcs of the <code>rust_std</code> attribute.   | List of strings | required |  |
| <a id="rust_toolchain-target_json"></a>target_json |  Override the target_triple with a custom target specification. For more details see: https://doc.rust-lang.org/rustc/targets/custom.html   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="rust_toolchain-target_triple"></a>target_triple |  The platform triple for the toolchains target environment. For more details see: https://docs.bazel.build/versions/master/skylark/rules.html#configurations   | String | optional | "" |


<a id="#rust_toolchain_repository"></a>

## rust_toolchain_repository

<pre>
rust_toolchain_repository(<a href="#rust_toolchain_repository-name">name</a>, <a href="#rust_toolchain_repository-auth">auth</a>, <a href="#rust_toolchain_repository-dev_components">dev_components</a>, <a href="#rust_toolchain_repository-edition">edition</a>, <a href="#rust_toolchain_repository-exec_triple">exec_triple</a>, <a href="#rust_toolchain_repository-extra_target_triples">extra_target_triples</a>,
                          <a href="#rust_toolchain_repository-include_rustc_srcs">include_rustc_srcs</a>, <a href="#rust_toolchain_repository-iso_date">iso_date</a>, <a href="#rust_toolchain_repository-repo_mapping">repo_mapping</a>, <a href="#rust_toolchain_repository-rustfmt_version">rustfmt_version</a>, <a href="#rust_toolchain_repository-sha256s">sha256s</a>,
                          <a href="#rust_toolchain_repository-toolchain_name_prefix">toolchain_name_prefix</a>, <a href="#rust_toolchain_repository-urls">urls</a>, <a href="#rust_toolchain_repository-version">version</a>)
</pre>

Composes a single workspace containing the toolchain components for compiling on a given platform to a series of target platforms.

A given instance of this rule should be accompanied by a rust_toolchain_repository_proxy invocation to declare its toolchains to Bazel; the indirection allows separating toolchain selection from toolchain fetching.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="rust_toolchain_repository-name"></a>name |  A unique name for this repository.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="rust_toolchain_repository-auth"></a>auth |  Auth object compatible with repository_ctx.download to use when downloading files. See [repository_ctx.download](https://docs.bazel.build/versions/main/skylark/lib/repository_ctx.html#download) for more details.   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | optional | {} |
| <a id="rust_toolchain_repository-dev_components"></a>dev_components |  Whether to download the rustc-dev components (defaults to False). Requires version to be "nightly".   | Boolean | optional | False |
| <a id="rust_toolchain_repository-edition"></a>edition |  The rust edition to be used by default (2015, 2018, or 2021). If absent, every rule is required to specify its <code>edition</code> attribute.   | String | optional | "" |
| <a id="rust_toolchain_repository-exec_triple"></a>exec_triple |  The Rust-style target that this compiler runs on   | String | required |  |
| <a id="rust_toolchain_repository-extra_target_triples"></a>extra_target_triples |  Additional rust-style targets that this set of toolchains should support.   | List of strings | optional | [] |
| <a id="rust_toolchain_repository-include_rustc_srcs"></a>include_rustc_srcs |  Whether to download and unpack the rustc source files. These are very large, and slow to unpack, but are required to support rust analyzer. An environment variable <code>RULES_RUST_TOOLCHAIN_INCLUDE_RUSTC_SRCS</code> can also be used to control this attribute. This variable will take precedence over the hard coded attribute. Setting it to <code>true</code> to activates this attribute where all other values deactivate it.   | Boolean | optional | False |
| <a id="rust_toolchain_repository-iso_date"></a>iso_date |  The date of the tool (or None, if the version is a specific version).   | String | optional | "" |
| <a id="rust_toolchain_repository-repo_mapping"></a>repo_mapping |  A dictionary from local repository name to global repository name. This allows controls over workspace dependency resolution for dependencies of this repository.&lt;p&gt;For example, an entry <code>"@foo": "@bar"</code> declares that, for any time this repository depends on <code>@foo</code> (such as a dependency on <code>@foo//some:target</code>, it should actually resolve that dependency within globally-declared <code>@bar</code> (<code>@bar//some:target</code>).   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | required |  |
| <a id="rust_toolchain_repository-rustfmt_version"></a>rustfmt_version |  The version of the tool among "nightly", "beta", or an exact version.   | String | optional | "" |
| <a id="rust_toolchain_repository-sha256s"></a>sha256s |  A dict associating tool subdirectories to sha256 hashes. See [rust_repositories](#rust_repositories) for more details.   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | optional | {} |
| <a id="rust_toolchain_repository-toolchain_name_prefix"></a>toolchain_name_prefix |  The per-target prefix expected for the rust_toolchain declarations in the parent workspace.   | String | optional | "" |
| <a id="rust_toolchain_repository-urls"></a>urls |  A list of mirror urls containing the tools from the Rust-lang static file server. These must contain the '{}' used to substitute the tool being fetched (using .format).   | List of strings | optional | ["https://static.rust-lang.org/dist/{}.tar.gz"] |
| <a id="rust_toolchain_repository-version"></a>version |  The version of the tool among "nightly", "beta", or an exact version.   | String | required |  |


<a id="#rust_toolchain_repository_proxy"></a>

## rust_toolchain_repository_proxy

<pre>
rust_toolchain_repository_proxy(<a href="#rust_toolchain_repository_proxy-name">name</a>, <a href="#rust_toolchain_repository_proxy-exec_triple">exec_triple</a>, <a href="#rust_toolchain_repository_proxy-extra_target_triples">extra_target_triples</a>, <a href="#rust_toolchain_repository_proxy-parent_workspace_name">parent_workspace_name</a>,
                                <a href="#rust_toolchain_repository_proxy-repo_mapping">repo_mapping</a>, <a href="#rust_toolchain_repository_proxy-toolchain_name_prefix">toolchain_name_prefix</a>)
</pre>

Generates a toolchain-bearing repository that declares the toolchains from some other rust_toolchain_repository.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="rust_toolchain_repository_proxy-name"></a>name |  A unique name for this repository.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="rust_toolchain_repository_proxy-exec_triple"></a>exec_triple |  The Rust-style target triple for the compilation platform   | String | required |  |
| <a id="rust_toolchain_repository_proxy-extra_target_triples"></a>extra_target_triples |  The Rust-style triples for extra compilation targets   | List of strings | optional | [] |
| <a id="rust_toolchain_repository_proxy-parent_workspace_name"></a>parent_workspace_name |  The name of the other rust_toolchain_repository   | String | required |  |
| <a id="rust_toolchain_repository_proxy-repo_mapping"></a>repo_mapping |  A dictionary from local repository name to global repository name. This allows controls over workspace dependency resolution for dependencies of this repository.&lt;p&gt;For example, an entry <code>"@foo": "@bar"</code> declares that, for any time this repository depends on <code>@foo</code> (such as a dependency on <code>@foo//some:target</code>, it should actually resolve that dependency within globally-declared <code>@bar</code> (<code>@bar//some:target</code>).   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | required |  |
| <a id="rust_toolchain_repository_proxy-toolchain_name_prefix"></a>toolchain_name_prefix |  The per-target prefix expected for the rust_toolchain declarations in the parent workspace.   | String | optional | "" |


<a id="#rust_wasm_bindgen"></a>

## rust_wasm_bindgen

<pre>
rust_wasm_bindgen(<a href="#rust_wasm_bindgen-name">name</a>, <a href="#rust_wasm_bindgen-bindgen_flags">bindgen_flags</a>, <a href="#rust_wasm_bindgen-target">target</a>, <a href="#rust_wasm_bindgen-wasm_file">wasm_file</a>)
</pre>

Generates javascript and typescript bindings for a webassembly module using [wasm-bindgen][ws].

[ws]: https://rustwasm.github.io/docs/wasm-bindgen/

To use the Rust WebAssembly bindgen rules, add the following to your `WORKSPACE` file to add the
external repositories for the Rust bindgen toolchain (in addition to the Rust rules setup):

```python
load("@rules_rust//wasm_bindgen:repositories.bzl", "rust_wasm_bindgen_repositories")

rust_wasm_bindgen_repositories()
```

For more details on `rust_wasm_bindgen_repositories`, see [here](#rust_wasm_bindgen_repositories).

An example of this rule in use can be seen at [@rules_rust//examples/wasm](../examples/wasm)


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="rust_wasm_bindgen-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="rust_wasm_bindgen-bindgen_flags"></a>bindgen_flags |  Flags to pass directly to the bindgen executable. See https://github.com/rustwasm/wasm-bindgen/ for details.   | List of strings | optional | [] |
| <a id="rust_wasm_bindgen-target"></a>target |  The type of output to generate. See https://rustwasm.github.io/wasm-bindgen/reference/deployment.html for details.   | String | optional | "bundler" |
| <a id="rust_wasm_bindgen-wasm_file"></a>wasm_file |  The <code>.wasm</code> file or crate to generate bindings for.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |


<a id="#rust_wasm_bindgen_toolchain"></a>

## rust_wasm_bindgen_toolchain

<pre>
rust_wasm_bindgen_toolchain(<a href="#rust_wasm_bindgen_toolchain-name">name</a>, <a href="#rust_wasm_bindgen_toolchain-bindgen">bindgen</a>)
</pre>

The tools required for the `rust_wasm_bindgen` rule.

In cases where users want to control or change the version of `wasm-bindgen` used by [rust_wasm_bindgen](#rust_wasm_bindgen),
a unique toolchain can be created as in the example below:

```python
load("@rules_rust//bindgen:bindgen.bzl", "rust_bindgen_toolchain")

rust_bindgen_toolchain(
    bindgen = "//my/cargo_raze:cargo_bin_wasm_bindgen",
)

toolchain(
    name = "wasm_bindgen_toolchain",
    toolchain = "wasm_bindgen_toolchain_impl",
    toolchain_type = "@rules_rust//wasm_bindgen:wasm_bindgen_toolchain",
)
```

Now that you have your own toolchain, you need to register it by
inserting the following statement in your `WORKSPACE` file:

```python
register_toolchains("//my/toolchains:wasm_bindgen_toolchain")
```

For additional information, see the [Bazel toolchains documentation][toolchains].

[toolchains]: https://docs.bazel.build/versions/master/toolchains.html


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="rust_wasm_bindgen_toolchain-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="rust_wasm_bindgen_toolchain-bindgen"></a>bindgen |  The label of a <code>wasm-bindgen-cli</code> executable.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |


<a id="#rustfmt_test"></a>

## rustfmt_test

<pre>
rustfmt_test(<a href="#rustfmt_test-name">name</a>, <a href="#rustfmt_test-targets">targets</a>)
</pre>

A test rule for performing `rustfmt --check` on a set of targets

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="rustfmt_test-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="rustfmt_test-targets"></a>targets |  Rust targets to run <code>rustfmt --check</code> on.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |


<a id="#CrateInfo"></a>

## CrateInfo

<pre>
CrateInfo(<a href="#CrateInfo-aliases">aliases</a>, <a href="#CrateInfo-compile_data">compile_data</a>, <a href="#CrateInfo-deps">deps</a>, <a href="#CrateInfo-edition">edition</a>, <a href="#CrateInfo-is_test">is_test</a>, <a href="#CrateInfo-name">name</a>, <a href="#CrateInfo-output">output</a>, <a href="#CrateInfo-owner">owner</a>, <a href="#CrateInfo-proc_macro_deps">proc_macro_deps</a>, <a href="#CrateInfo-root">root</a>,
          <a href="#CrateInfo-rustc_env">rustc_env</a>, <a href="#CrateInfo-srcs">srcs</a>, <a href="#CrateInfo-type">type</a>, <a href="#CrateInfo-wrapped_crate_type">wrapped_crate_type</a>)
</pre>

A provider containing general Crate information.

**FIELDS**


| Name  | Description |
| :------------- | :------------- |
| <a id="CrateInfo-aliases"></a>aliases |  Dict[Label, String]: Renamed and aliased crates    |
| <a id="CrateInfo-compile_data"></a>compile_data |  depset[File]: Compile data required by this crate.    |
| <a id="CrateInfo-deps"></a>deps |  depset[DepVariantInfo]: This crate's (rust or cc) dependencies' providers.    |
| <a id="CrateInfo-edition"></a>edition |  str: The edition of this crate.    |
| <a id="CrateInfo-is_test"></a>is_test |  bool: If the crate is being compiled in a test context    |
| <a id="CrateInfo-name"></a>name |  str: The name of this crate.    |
| <a id="CrateInfo-output"></a>output |  File: The output File that will be produced, depends on crate type.    |
| <a id="CrateInfo-owner"></a>owner |  Label: The label of the target that produced this CrateInfo    |
| <a id="CrateInfo-proc_macro_deps"></a>proc_macro_deps |  depset[DepVariantInfo]: This crate's rust proc_macro dependencies' providers.    |
| <a id="CrateInfo-root"></a>root |  File: The source File entrypoint to this crate, eg. lib.rs    |
| <a id="CrateInfo-rustc_env"></a>rustc_env |  Dict[String, String]: Additional <code>"key": "value"</code> environment variables to set for rustc.    |
| <a id="CrateInfo-srcs"></a>srcs |  depset[File]: All source Files that are part of the crate.    |
| <a id="CrateInfo-type"></a>type |  str: The type of this crate (see [rustc --crate-type](https://doc.rust-lang.org/rustc/command-line-arguments.html#--crate-type-a-list-of-types-of-crates-for-the-compiler-to-emit)).    |
| <a id="CrateInfo-wrapped_crate_type"></a>wrapped_crate_type |  str, optional: The original crate type for targets generated using a previously defined crate (typically tests using the <code>rust_test::crate</code> attribute)    |


<a id="#DepInfo"></a>

## DepInfo

<pre>
DepInfo(<a href="#DepInfo-dep_env">dep_env</a>, <a href="#DepInfo-direct_crates">direct_crates</a>, <a href="#DepInfo-link_search_path_files">link_search_path_files</a>, <a href="#DepInfo-transitive_build_infos">transitive_build_infos</a>,
        <a href="#DepInfo-transitive_crate_outputs">transitive_crate_outputs</a>, <a href="#DepInfo-transitive_crates">transitive_crates</a>, <a href="#DepInfo-transitive_noncrates">transitive_noncrates</a>)
</pre>

A provider containing information about a Crate's dependencies.

**FIELDS**


| Name  | Description |
| :------------- | :------------- |
| <a id="DepInfo-dep_env"></a>dep_env |  File: File with environment variables direct dependencies build scripts rely upon.    |
| <a id="DepInfo-direct_crates"></a>direct_crates |  depset[AliasableDepInfo]    |
| <a id="DepInfo-link_search_path_files"></a>link_search_path_files |  depset[File]: All transitive files containing search paths to pass to the linker    |
| <a id="DepInfo-transitive_build_infos"></a>transitive_build_infos |  depset[BuildInfo]    |
| <a id="DepInfo-transitive_crate_outputs"></a>transitive_crate_outputs |  depset[File]: All transitive crate outputs.    |
| <a id="DepInfo-transitive_crates"></a>transitive_crates |  depset[CrateInfo]    |
| <a id="DepInfo-transitive_noncrates"></a>transitive_noncrates |  depset[LinkerInput]: All transitive dependencies that aren't crates.    |


<a id="#StdLibInfo"></a>

## StdLibInfo

<pre>
StdLibInfo(<a href="#StdLibInfo-alloc_files">alloc_files</a>, <a href="#StdLibInfo-between_alloc_and_core_files">between_alloc_and_core_files</a>, <a href="#StdLibInfo-between_core_and_std_files">between_core_and_std_files</a>, <a href="#StdLibInfo-core_files">core_files</a>,
           <a href="#StdLibInfo-dot_a_files">dot_a_files</a>, <a href="#StdLibInfo-memchr_files">memchr_files</a>, <a href="#StdLibInfo-self_contained_files">self_contained_files</a>, <a href="#StdLibInfo-srcs">srcs</a>, <a href="#StdLibInfo-std_files">std_files</a>, <a href="#StdLibInfo-std_rlibs">std_rlibs</a>)
</pre>

A collection of files either found within the `rust-stdlib` artifact or generated based on existing files.

**FIELDS**


| Name  | Description |
| :------------- | :------------- |
| <a id="StdLibInfo-alloc_files"></a>alloc_files |  List[File]: <code>.a</code> files related to the <code>alloc</code> module.    |
| <a id="StdLibInfo-between_alloc_and_core_files"></a>between_alloc_and_core_files |  List[File]: <code>.a</code> files related to the <code>compiler_builtins</code> module.    |
| <a id="StdLibInfo-between_core_and_std_files"></a>between_core_and_std_files |  List[File]: <code>.a</code> files related to all modules except <code>adler</code>, <code>alloc</code>, <code>compiler_builtins</code>, <code>core</code>, and <code>std</code>.    |
| <a id="StdLibInfo-core_files"></a>core_files |  List[File]: <code>.a</code> files related to the <code>core</code> and <code>adler</code> modules    |
| <a id="StdLibInfo-dot_a_files"></a>dot_a_files |  Depset[File]: Generated <code>.a</code> files    |
| <a id="StdLibInfo-memchr_files"></a>memchr_files |  Depset[File]: <code>.a</code> files associated with the <code>memchr</code> module.    |
| <a id="StdLibInfo-self_contained_files"></a>self_contained_files |  List[File]: All <code>.o</code> files from the <code>self-contained</code> directory.    |
| <a id="StdLibInfo-srcs"></a>srcs |  List[Target]: All targets from the original <code>srcs</code> attribute.    |
| <a id="StdLibInfo-std_files"></a>std_files |  Depset[File]: <code>.a</code> files associated with the <code>std</code> module.    |
| <a id="StdLibInfo-std_rlibs"></a>std_rlibs |  List[File]: All <code>.rlib</code> files    |


<a id="#cargo_build_script"></a>

## cargo_build_script

<pre>
cargo_build_script(<a href="#cargo_build_script-name">name</a>, <a href="#cargo_build_script-crate_features">crate_features</a>, <a href="#cargo_build_script-version">version</a>, <a href="#cargo_build_script-deps">deps</a>, <a href="#cargo_build_script-build_script_env">build_script_env</a>, <a href="#cargo_build_script-data">data</a>, <a href="#cargo_build_script-tools">tools</a>, <a href="#cargo_build_script-links">links</a>,
                   <a href="#cargo_build_script-rustc_env">rustc_env</a>, <a href="#cargo_build_script-rustc_flags">rustc_flags</a>, <a href="#cargo_build_script-visibility">visibility</a>, <a href="#cargo_build_script-tags">tags</a>, <a href="#cargo_build_script-kwargs">kwargs</a>)
</pre>

Compile and execute a rust build script to generate build attributes

This rules take the same arguments as rust_binary.

Example:

Suppose you have a crate with a cargo build script `build.rs`:

```output
[workspace]/
    hello_lib/
        BUILD
        build.rs
        src/
            lib.rs
```

Then you want to use the build script in the following:

`hello_lib/BUILD`:
```python
package(default_visibility = ["//visibility:public"])

load("@rules_rust//rust:defs.bzl", "rust_binary", "rust_library")
load("@rules_rust//cargo:cargo_build_script.bzl", "cargo_build_script")

# This will run the build script from the root of the workspace, and
# collect the outputs.
cargo_build_script(
    name = "build_script",
    srcs = ["build.rs"],
    # Optional environment variables passed during build.rs compilation
    rustc_env = {
       "CARGO_PKG_VERSION": "0.1.2",
    },
    # Optional environment variables passed during build.rs execution.
    # Note that as the build script's working directory is not execroot,
    # execpath/location will return an absolute path, instead of a relative
    # one.
    build_script_env = {
        "SOME_TOOL_OR_FILE": "$(execpath @tool//:binary)"
    }
    # Optional data/tool dependencies
    data = ["@tool//:binary"],
)

rust_library(
    name = "hello_lib",
    srcs = [
        "src/lib.rs",
    ],
    deps = [":build_script"],
)
```

The `hello_lib` target will be build with the flags and the environment variables declared by the     build script in addition to the file generated by it.


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="cargo_build_script-name"></a>name |  The name for the underlying rule. This should be the name of the package being compiled, optionally with a suffix of _build_script.   |  none |
| <a id="cargo_build_script-crate_features"></a>crate_features |  A list of features to enable for the build script.   |  <code>[]</code> |
| <a id="cargo_build_script-version"></a>version |  The semantic version (semver) of the crate.   |  <code>None</code> |
| <a id="cargo_build_script-deps"></a>deps |  The dependencies of the crate.   |  <code>[]</code> |
| <a id="cargo_build_script-build_script_env"></a>build_script_env |  Environment variables for build scripts.   |  <code>{}</code> |
| <a id="cargo_build_script-data"></a>data |  Files needed by the build script.   |  <code>[]</code> |
| <a id="cargo_build_script-tools"></a>tools |  Tools (executables) needed by the build script.   |  <code>[]</code> |
| <a id="cargo_build_script-links"></a>links |  Name of the native library this crate links against.   |  <code>None</code> |
| <a id="cargo_build_script-rustc_env"></a>rustc_env |  Environment variables to set in rustc when compiling the build script.   |  <code>{}</code> |
| <a id="cargo_build_script-rustc_flags"></a>rustc_flags |  List of compiler flags passed to <code>rustc</code>.   |  <code>[]</code> |
| <a id="cargo_build_script-visibility"></a>visibility |  Visibility to apply to the generated build script output.   |  <code>None</code> |
| <a id="cargo_build_script-tags"></a>tags |  (list of str, optional): Tags to apply to the generated build script output.   |  <code>None</code> |
| <a id="cargo_build_script-kwargs"></a>kwargs |  Forwards to the underlying <code>rust_binary</code> rule.   |  none |


<a id="#cargo_env"></a>

## cargo_env

<pre>
cargo_env(<a href="#cargo_env-env">env</a>)
</pre>

A helper for generating platform specific environment variables

```python
load("@rules_rust//rust:defs.bzl", "rust_common")
load("@rules_rust//cargo:defs.bzl", "cargo_bootstrap_repository", "cargo_env")

cargo_bootstrap_repository(
    name = "bootstrapped_bin",
    cargo_lockfile = "//:Cargo.lock",
    cargo_toml = "//:Cargo.toml",
    srcs = ["//:resolver_srcs"],
    version = rust_common.default_version,
    binary = "my-crate-binary",
    env = {
        "x86_64-unknown-linux-gnu": cargo_env({
            "FOO": "BAR",
        }),
    },
    env_label = {
        "aarch64-unknown-linux-musl": cargo_env({
            "DOC": "//:README.md",
        }),
    }
)
```


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="cargo_env-env"></a>env |  A map of environment variables   |  none |

**RETURNS**

str: A json encoded string of the environment variables


<a id="#rules_rust_dependencies"></a>

## rules_rust_dependencies

<pre>
rules_rust_dependencies()
</pre>

Dependencies used in the implementation of `rules_rust`.



<a id="#rust_bindgen_dependencies"></a>

## rust_bindgen_dependencies

<pre>
rust_bindgen_dependencies()
</pre>

Declare dependencies needed for bindgen.



<a id="#rust_bindgen_library"></a>

## rust_bindgen_library

<pre>
rust_bindgen_library(<a href="#rust_bindgen_library-name">name</a>, <a href="#rust_bindgen_library-header">header</a>, <a href="#rust_bindgen_library-cc_lib">cc_lib</a>, <a href="#rust_bindgen_library-bindgen_flags">bindgen_flags</a>, <a href="#rust_bindgen_library-clang_flags">clang_flags</a>, <a href="#rust_bindgen_library-rustfmt">rustfmt</a>, <a href="#rust_bindgen_library-kwargs">kwargs</a>)
</pre>

Generates a rust source file for `header`, and builds a rust_library.

Arguments are the same as `rust_bindgen`, and `kwargs` are passed directly to rust_library.


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="rust_bindgen_library-name"></a>name |  A unique name for this target.   |  none |
| <a id="rust_bindgen_library-header"></a>header |  The label of the .h file to generate bindings for.   |  none |
| <a id="rust_bindgen_library-cc_lib"></a>cc_lib |  The label of the cc_library that contains the .h file. This is used to find the transitive includes.   |  none |
| <a id="rust_bindgen_library-bindgen_flags"></a>bindgen_flags |  Flags to pass directly to the bindgen executable. See https://rust-lang.github.io/rust-bindgen/ for details.   |  <code>None</code> |
| <a id="rust_bindgen_library-clang_flags"></a>clang_flags |  Flags to pass directly to the clang executable.   |  <code>None</code> |
| <a id="rust_bindgen_library-rustfmt"></a>rustfmt |  Enable or disable running rustfmt on the generated file.   |  <code>True</code> |
| <a id="rust_bindgen_library-kwargs"></a>kwargs |  Arguments to forward to the underlying <code>rust_library</code> rule.   |  none |


<a id="#rust_bindgen_register_toolchains"></a>

## rust_bindgen_register_toolchains

<pre>
rust_bindgen_register_toolchains(<a href="#rust_bindgen_register_toolchains-register_toolchains">register_toolchains</a>)
</pre>

Registers the default toolchains for the `rules_rust` [bindgen][bg] rules.

[bg]: https://rust-lang.github.io/rust-bindgen/


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="rust_bindgen_register_toolchains-register_toolchains"></a>register_toolchains |  Whether or not to register toolchains.   |  <code>True</code> |


<a id="#rust_proto_repositories"></a>

## rust_proto_repositories

<pre>
rust_proto_repositories(<a href="#rust_proto_repositories-register_default_toolchain">register_default_toolchain</a>)
</pre>

Declare dependencies needed for proto compilation.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="rust_proto_repositories-register_default_toolchain"></a>register_default_toolchain |  If True, the default [rust_proto_toolchain](#rust_proto_toolchain) (<code>@rules_rust//proto:default-proto-toolchain</code>) is registered. This toolchain requires a set of dependencies that were generated using [cargo raze](https://github.com/google/cargo-raze). These will also be loaded.   |  <code>True</code> |


<a id="#rust_proto_transitive_repositories"></a>

## rust_proto_transitive_repositories

<pre>
rust_proto_transitive_repositories()
</pre>

Load transitive dependencies of the `@rules_rust//proto` rules.

This macro should be called immediately after the `rust_proto_repositories` macro.



<a id="#rust_register_toolchains"></a>

## rust_register_toolchains

<pre>
rust_register_toolchains(<a href="#rust_register_toolchains-dev_components">dev_components</a>, <a href="#rust_register_toolchains-edition">edition</a>, <a href="#rust_register_toolchains-include_rustc_srcs">include_rustc_srcs</a>, <a href="#rust_register_toolchains-iso_date">iso_date</a>, <a href="#rust_register_toolchains-register_toolchains">register_toolchains</a>,
                         <a href="#rust_register_toolchains-rustfmt_version">rustfmt_version</a>, <a href="#rust_register_toolchains-sha256s">sha256s</a>, <a href="#rust_register_toolchains-extra_target_triples">extra_target_triples</a>, <a href="#rust_register_toolchains-urls">urls</a>, <a href="#rust_register_toolchains-version">version</a>)
</pre>

Emits a default set of toolchains for Linux, MacOS, and Freebsd

Skip this macro and call the `rust_repository_set` macros directly if you need a compiler for     other hosts or for additional target triples.

The `sha256` attribute represents a dict associating tool subdirectories to sha256 hashes. As an example:
```python
{
    "rust-1.46.0-x86_64-unknown-linux-gnu": "e3b98bc3440fe92817881933f9564389eccb396f5f431f33d48b979fa2fbdcf5",
    "rustfmt-1.4.12-x86_64-unknown-linux-gnu": "1894e76913303d66bf40885a601462844eec15fca9e76a6d13c390d7000d64b0",
    "rust-std-1.46.0-x86_64-unknown-linux-gnu": "ac04aef80423f612c0079829b504902de27a6997214eb58ab0765d02f7ec1dbc",
}
```
This would match for `exec_triple = "x86_64-unknown-linux-gnu"`.  If not specified, rules_rust pulls from a non-exhaustive     list of known checksums..

See `load_arbitrary_tool` in `@rules_rust//rust:repositories.bzl` for more details.


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="rust_register_toolchains-dev_components"></a>dev_components |  Whether to download the rustc-dev components (defaults to False). Requires version to be "nightly".   |  <code>False</code> |
| <a id="rust_register_toolchains-edition"></a>edition |  The rust edition to be used by default (2015, 2018, or 2021). If absent, every target is required to specify its <code>edition</code> attribute.   |  <code>None</code> |
| <a id="rust_register_toolchains-include_rustc_srcs"></a>include_rustc_srcs |  Whether to download rustc's src code. This is required in order to use rust-analyzer support. See [rust_toolchain_repository.include_rustc_srcs](#rust_toolchain_repository-include_rustc_srcs). for more details   |  <code>False</code> |
| <a id="rust_register_toolchains-iso_date"></a>iso_date |  The date of the nightly or beta release (ignored if the version is a specific version).   |  <code>None</code> |
| <a id="rust_register_toolchains-register_toolchains"></a>register_toolchains |  If true, repositories will be generated to produce and register <code>rust_toolchain</code> targets.   |  <code>True</code> |
| <a id="rust_register_toolchains-rustfmt_version"></a>rustfmt_version |  The version of rustfmt. Either "nightly", "beta", or an exact version. Defaults to <code>version</code> if not specified.   |  <code>None</code> |
| <a id="rust_register_toolchains-sha256s"></a>sha256s |  A dict associating tool subdirectories to sha256 hashes.   |  <code>None</code> |
| <a id="rust_register_toolchains-extra_target_triples"></a>extra_target_triples |  Additional rust-style targets that rust toolchains should support.   |  <code>["wasm32-unknown-unknown", "wasm32-wasi"]</code> |
| <a id="rust_register_toolchains-urls"></a>urls |  A list of mirror urls containing the tools from the Rust-lang static file server. These must contain the '{}' used to substitute the tool being fetched (using .format).   |  <code>["https://static.rust-lang.org/dist/{}.tar.gz"]</code> |
| <a id="rust_register_toolchains-version"></a>version |  The version of Rust. Either "nightly", "beta", or an exact version. Defaults to a modern version.   |  <code>"1.61.0"</code> |


<a id="#rust_repositories"></a>

## rust_repositories

<pre>
rust_repositories(<a href="#rust_repositories-kwargs">kwargs</a>)
</pre>

**Deprecated**: Use [rules_rust_dependencies](#rules_rust_dependencies)     and [rust_register_toolchains](#rust_register_toolchains) directly.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="rust_repositories-kwargs"></a>kwargs |  Keyword arguments for the <code>rust_register_toolchains</code> macro.   |  none |


<a id="#rust_repository_set"></a>

## rust_repository_set

<pre>
rust_repository_set(<a href="#rust_repository_set-name">name</a>, <a href="#rust_repository_set-version">version</a>, <a href="#rust_repository_set-exec_triple">exec_triple</a>, <a href="#rust_repository_set-include_rustc_srcs">include_rustc_srcs</a>, <a href="#rust_repository_set-extra_target_triples">extra_target_triples</a>, <a href="#rust_repository_set-iso_date">iso_date</a>,
                    <a href="#rust_repository_set-rustfmt_version">rustfmt_version</a>, <a href="#rust_repository_set-edition">edition</a>, <a href="#rust_repository_set-dev_components">dev_components</a>, <a href="#rust_repository_set-sha256s">sha256s</a>, <a href="#rust_repository_set-urls">urls</a>, <a href="#rust_repository_set-auth">auth</a>, <a href="#rust_repository_set-register_toolchain">register_toolchain</a>)
</pre>

Assembles a remote repository for the given toolchain params, produces a proxy repository     to contain the toolchain declaration, and registers the toolchains.

N.B. A "proxy repository" is needed to allow for registering the toolchain (with constraints)     without actually downloading the toolchain.


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="rust_repository_set-name"></a>name |  The name of the generated repository   |  none |
| <a id="rust_repository_set-version"></a>version |  The version of the tool among "nightly", "beta', or an exact version.   |  none |
| <a id="rust_repository_set-exec_triple"></a>exec_triple |  The Rust-style target that this compiler runs on   |  none |
| <a id="rust_repository_set-include_rustc_srcs"></a>include_rustc_srcs |  Whether to download rustc's src code. This is required in order to use rust-analyzer support. Defaults to False.   |  <code>False</code> |
| <a id="rust_repository_set-extra_target_triples"></a>extra_target_triples |  Additional rust-style targets that this set of toolchains should support. Defaults to [].   |  <code>[]</code> |
| <a id="rust_repository_set-iso_date"></a>iso_date |  The date of the tool. Defaults to None.   |  <code>None</code> |
| <a id="rust_repository_set-rustfmt_version"></a>rustfmt_version |  The version of rustfmt to be associated with the toolchain. Defaults to None.   |  <code>None</code> |
| <a id="rust_repository_set-edition"></a>edition |  The rust edition to be used by default (2015, 2018, or 2021). If absent, every rule is required to specify its <code>edition</code> attribute.   |  <code>None</code> |
| <a id="rust_repository_set-dev_components"></a>dev_components |  Whether to download the rustc-dev components. Requires version to be "nightly". Defaults to False.   |  <code>False</code> |
| <a id="rust_repository_set-sha256s"></a>sha256s |  A dict associating tool subdirectories to sha256 hashes. See [rust_repositories](#rust_repositories) for more details.   |  <code>None</code> |
| <a id="rust_repository_set-urls"></a>urls |  A list of mirror urls containing the tools from the Rust-lang static file server. These must contain the '{}' used to substitute the tool being fetched (using .format). Defaults to ['https://static.rust-lang.org/dist/{}.tar.gz']   |  <code>["https://static.rust-lang.org/dist/{}.tar.gz"]</code> |
| <a id="rust_repository_set-auth"></a>auth |  Auth object compatible with repository_ctx.download to use when downloading files. See [repository_ctx.download](https://docs.bazel.build/versions/main/skylark/lib/repository_ctx.html#download) for more details.   |  <code>None</code> |
| <a id="rust_repository_set-register_toolchain"></a>register_toolchain |  If True, the generated <code>rust_toolchain</code> target will become a registered toolchain.   |  <code>True</code> |


<a id="#rust_test_suite"></a>

## rust_test_suite

<pre>
rust_test_suite(<a href="#rust_test_suite-name">name</a>, <a href="#rust_test_suite-srcs">srcs</a>, <a href="#rust_test_suite-kwargs">kwargs</a>)
</pre>

A rule for creating a test suite for a set of `rust_test` targets.

This rule can be used for setting up typical rust [integration tests][it]. Given the following
directory structure:

```text
[crate]/
    BUILD.bazel
    src/
        lib.rs
        main.rs
    tests/
        integrated_test_a.rs
        integrated_test_b.rs
        integrated_test_c.rs
        patterns/
            fibonacci_test.rs
```

The rule can be used to generate [rust_test](#rust_test) targets for each source file under `tests`
and a [test_suite][ts] which encapsulates all tests.

```python
load("//rust:defs.bzl", "rust_binary", "rust_library", "rust_test_suite")

rust_library(
    name = "math_lib",
    srcs = ["src/lib.rs"],
)

rust_binary(
    name = "math_bin",
    srcs = ["src/main.rs"],
)

rust_test_suite(
    name = "integrated_tests_suite",
    srcs = glob(["tests/**"]),
    deps = [":math_lib"],
)
```

[it]: https://doc.rust-lang.org/rust-by-example/testing/integration_testing.html
[ts]: https://docs.bazel.build/versions/master/be/general.html#test_suite


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="rust_test_suite-name"></a>name |  The name of the <code>test_suite</code>.   |  none |
| <a id="rust_test_suite-srcs"></a>srcs |  All test sources, typically <code>glob(["tests/**/*.rs"])</code>.   |  none |
| <a id="rust_test_suite-kwargs"></a>kwargs |  Additional keyword arguments for the underyling [rust_test](#rust_test) targets. The <code>tags</code> argument is also passed to the generated <code>test_suite</code> target.   |  none |


<a id="#rust_wasm_bindgen_dependencies"></a>

## rust_wasm_bindgen_dependencies

<pre>
rust_wasm_bindgen_dependencies()
</pre>

Declare dependencies needed for the `rules_rust` [wasm-bindgen][wb] rules.

[wb]: https://github.com/rustwasm/wasm-bindgen



<a id="#rust_wasm_bindgen_register_toolchains"></a>

## rust_wasm_bindgen_register_toolchains

<pre>
rust_wasm_bindgen_register_toolchains(<a href="#rust_wasm_bindgen_register_toolchains-register_toolchains">register_toolchains</a>)
</pre>

Registers the default toolchains for the `rules_rust` [wasm-bindgen][wb] rules.

[wb]: https://github.com/rustwasm/wasm-bindgen


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="rust_wasm_bindgen_register_toolchains-register_toolchains"></a>register_toolchains |  Whether or not to register toolchains.   |  <code>True</code> |


<a id="#rust_analyzer_aspect"></a>

## rust_analyzer_aspect

<pre>
rust_analyzer_aspect(<a href="#rust_analyzer_aspect-name">name</a>)
</pre>

Annotates rust rules with RustAnalyzerInfo later used to build a rust-project.json

**ASPECT ATTRIBUTES**


| Name | Type |
| :------------- | :------------- |
| deps| String |
| proc_macro_deps| String |
| crate| String |
| actual| String |


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="rust_analyzer_aspect-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |   |


<a id="#rust_clippy_aspect"></a>

## rust_clippy_aspect

<pre>
rust_clippy_aspect(<a href="#rust_clippy_aspect-name">name</a>)
</pre>

Executes the clippy checker on specified targets.

This aspect applies to existing rust_library, rust_test, and rust_binary rules.

As an example, if the following is defined in `examples/hello_lib/BUILD.bazel`:

```python
load("@rules_rust//rust:defs.bzl", "rust_library", "rust_test")

rust_library(
    name = "hello_lib",
    srcs = ["src/lib.rs"],
)

rust_test(
    name = "greeting_test",
    srcs = ["tests/greeting.rs"],
    deps = [":hello_lib"],
)
```

Then the targets can be analyzed with clippy using the following command:

```output
$ bazel build --aspects=@rules_rust//rust:defs.bzl%rust_clippy_aspect               --output_groups=clippy_checks //hello_lib:all
```


**ASPECT ATTRIBUTES**



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="rust_clippy_aspect-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |   |


<a id="#rustfmt_aspect"></a>

## rustfmt_aspect

<pre>
rustfmt_aspect(<a href="#rustfmt_aspect-name">name</a>)
</pre>

This aspect is used to gather information about a crate for use in rustfmt and perform rustfmt checks

Output Groups:

- `rustfmt_manifest`: A manifest used by rustfmt binaries to provide crate specific settings.
- `rustfmt_checks`: Executes `rustfmt --check` on the specified target.

The build setting `@rules_rust//:rustfmt.toml` is used to control the Rustfmt [configuration settings][cs]
used at runtime.

[cs]: https://rust-lang.github.io/rustfmt/

This aspect is executed on any target which provides the `CrateInfo` provider. However
users may tag a target with `norustfmt` to have it skipped. Additionally, generated
source files are also ignored by this aspect.


**ASPECT ATTRIBUTES**



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="rustfmt_aspect-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |   |


