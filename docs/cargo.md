<!-- Generated with Stardoc: http://skydoc.bazel.build -->
# Cargo

* [cargo_bootstrap_repository](#cargo_bootstrap_repository)
* [cargo_build_script](#cargo_build_script)
* [cargo_env](#cargo_env)

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


