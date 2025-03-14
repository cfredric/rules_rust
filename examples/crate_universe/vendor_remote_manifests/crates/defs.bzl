###############################################################################
# @generated
# This file is auto-generated by the cargo-bazel tool.
#
# DO NOT MODIFY: Local changes may be replaced in future executions.
###############################################################################
"""
# `crates_repository` API

- [aliases](#aliases)
- [crate_deps](#crate_deps)
- [all_crate_deps](#all_crate_deps)
- [crate_repositories](#crate_repositories)

"""

load("@bazel_skylib//lib:selects.bzl", "selects")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

###############################################################################
# MACROS API
###############################################################################

# An identifier that represent common dependencies (unconditional).
_COMMON_CONDITION = ""

def _flatten_dependency_maps(all_dependency_maps):
    """Flatten a list of dependency maps into one dictionary.

    Dependency maps have the following structure:

    ```python
    DEPENDENCIES_MAP = {
        # The first key in the map is a Bazel package
        # name of the workspace this file is defined in.
        "workspace_member_package": {

            # Not all dependnecies are supported for all platforms.
            # the condition key is the condition required to be true
            # on the host platform.
            "condition": {

                # An alias to a crate target.     # The label of the crate target the
                # Aliases are only crate names.   # package name refers to.
                "package_name":                   "@full//:label",
            }
        }
    }
    ```

    Args:
        all_dependency_maps (list): A list of dicts as described above

    Returns:
        dict: A dictionary as described above
    """
    dependencies = {}

    for workspace_deps_map in all_dependency_maps:
        for pkg_name, conditional_deps_map in workspace_deps_map.items():
            if pkg_name not in dependencies:
                non_frozen_map = dict()
                for key, values in conditional_deps_map.items():
                    non_frozen_map.update({key: dict(values.items())})
                dependencies.setdefault(pkg_name, non_frozen_map)
                continue

            for condition, deps_map in conditional_deps_map.items():
                # If the condition has not been recorded, do so and continue
                if condition not in dependencies[pkg_name]:
                    dependencies[pkg_name].setdefault(condition, dict(deps_map.items()))
                    continue

                # Alert on any miss-matched dependencies
                inconsistent_entries = []
                for crate_name, crate_label in deps_map.items():
                    existing = dependencies[pkg_name][condition].get(crate_name)
                    if existing and existing != crate_label:
                        inconsistent_entries.append((crate_name, existing, crate_label))
                    dependencies[pkg_name][condition].update({crate_name: crate_label})

    return dependencies

def crate_deps(deps, package_name = None):
    """Finds the fully qualified label of the requested crates for the package where this macro is called.

    Args:
        deps (list): The desired list of crate targets.
        package_name (str, optional): The package name of the set of dependencies to look up.
            Defaults to `native.package_name()`.

    Returns:
        list: A list of labels to generated rust targets (str)
    """

    if not deps:
        return []

    if package_name == None:
        package_name = native.package_name()

    # Join both sets of dependencies
    dependencies = _flatten_dependency_maps([
        _NORMAL_DEPENDENCIES,
        _NORMAL_DEV_DEPENDENCIES,
        _PROC_MACRO_DEPENDENCIES,
        _PROC_MACRO_DEV_DEPENDENCIES,
        _BUILD_DEPENDENCIES,
        _BUILD_PROC_MACRO_DEPENDENCIES,
    ]).pop(package_name, {})

    # Combine all conditional packages so we can easily index over a flat list
    # TODO: Perhaps this should actually return select statements and maintain
    # the conditionals of the dependencies
    flat_deps = {}
    for deps_set in dependencies.values():
        for crate_name, crate_label in deps_set.items():
            flat_deps.update({crate_name: crate_label})

    missing_crates = []
    crate_targets = []
    for crate_target in deps:
        if crate_target not in flat_deps:
            missing_crates.append(crate_target)
        else:
            crate_targets.append(flat_deps[crate_target])

    if missing_crates:
        fail("Could not find crates `{}` among dependencies of `{}`. Available dependencies were `{}`".format(
            missing_crates,
            package_name,
            dependencies,
        ))

    return crate_targets

def all_crate_deps(
        normal = False,
        normal_dev = False,
        proc_macro = False,
        proc_macro_dev = False,
        build = False,
        build_proc_macro = False,
        package_name = None):
    """Finds the fully qualified label of all requested direct crate dependencies \
    for the package where this macro is called.

    If no parameters are set, all normal dependencies are returned. Setting any one flag will
    otherwise impact the contents of the returned list.

    Args:
        normal (bool, optional): If True, normal dependencies are included in the
            output list.
        normal_dev (bool, optional): If True, normla dev dependencies will be
            included in the output list..
        proc_macro (bool, optional): If True, proc_macro dependencies are included
            in the output list.
        proc_macro_dev (bool, optional): If True, dev proc_macro dependencies are
            included in the output list.
        build (bool, optional): If True, build dependencies are included
            in the output list.
        build_proc_macro (bool, optional): If True, build proc_macro dependencies are
            included in the output list.
        package_name (str, optional): The package name of the set of dependencies to look up.
            Defaults to `native.package_name()` when unset.

    Returns:
        list: A list of labels to generated rust targets (str)
    """

    if package_name == None:
        package_name = native.package_name()

    # Determine the relevant maps to use
    all_dependency_maps = []
    if normal:
        all_dependency_maps.append(_NORMAL_DEPENDENCIES)
    if normal_dev:
        all_dependency_maps.append(_NORMAL_DEV_DEPENDENCIES)
    if proc_macro:
        all_dependency_maps.append(_PROC_MACRO_DEPENDENCIES)
    if proc_macro_dev:
        all_dependency_maps.append(_PROC_MACRO_DEV_DEPENDENCIES)
    if build:
        all_dependency_maps.append(_BUILD_DEPENDENCIES)
    if build_proc_macro:
        all_dependency_maps.append(_BUILD_PROC_MACRO_DEPENDENCIES)

    # Default to always using normal dependencies
    if not all_dependency_maps:
        all_dependency_maps.append(_NORMAL_DEPENDENCIES)

    dependencies = _flatten_dependency_maps(all_dependency_maps).pop(package_name, None)

    if not dependencies:
        if dependencies == None:
            fail("Tried to get all_crate_deps for package " + package_name + " but that package had no Cargo.toml file")
        else:
            return []

    crate_deps = list(dependencies.pop(_COMMON_CONDITION, {}).values())
    for condition, deps in dependencies.items():
        crate_deps += selects.with_or({_CONDITIONS[condition]: deps.values()})

    return crate_deps

def aliases(
        normal = False,
        normal_dev = False,
        proc_macro = False,
        proc_macro_dev = False,
        build = False,
        build_proc_macro = False,
        package_name = None):
    """Produces a map of Crate alias names to their original label

    If no dependency kinds are specified, `normal` and `proc_macro` are used by default.
    Setting any one flag will otherwise determine the contents of the returned dict.

    Args:
        normal (bool, optional): If True, normal dependencies are included in the
            output list.
        normal_dev (bool, optional): If True, normla dev dependencies will be
            included in the output list..
        proc_macro (bool, optional): If True, proc_macro dependencies are included
            in the output list.
        proc_macro_dev (bool, optional): If True, dev proc_macro dependencies are
            included in the output list.
        build (bool, optional): If True, build dependencies are included
            in the output list.
        build_proc_macro (bool, optional): If True, build proc_macro dependencies are
            included in the output list.
        package_name (str, optional): The package name of the set of dependencies to look up.
            Defaults to `native.package_name()` when unset.

    Returns:
        dict: The aliases of all associated packages
    """
    if package_name == None:
        package_name = native.package_name()

    # Determine the relevant maps to use
    all_aliases_maps = []
    if normal:
        all_aliases_maps.append(_NORMAL_ALIASES)
    if normal_dev:
        all_aliases_maps.append(_NORMAL_DEV_ALIASES)
    if proc_macro:
        all_aliases_maps.append(_PROC_MACRO_ALIASES)
    if proc_macro_dev:
        all_aliases_maps.append(_PROC_MACRO_DEV_ALIASES)
    if build:
        all_aliases_maps.append(_BUILD_ALIASES)
    if build_proc_macro:
        all_aliases_maps.append(_BUILD_PROC_MACRO_ALIASES)

    # Default to always using normal aliases
    if not all_aliases_maps:
        all_aliases_maps.append(_NORMAL_ALIASES)
        all_aliases_maps.append(_PROC_MACRO_ALIASES)

    aliases = _flatten_dependency_maps(all_aliases_maps).pop(package_name, None)

    if not aliases:
        return dict()

    common_items = aliases.pop(_COMMON_CONDITION, {}).items()

    # If there are only common items in the dictionary, immediately return them
    if not len(aliases.keys()) == 1:
        return dict(common_items)

    # Build a single select statement where each conditional has accounted for the
    # common set of aliases.
    crate_aliases = {"//conditions:default": common_items}
    for condition, deps in aliases.items():
        condition_triples = _CONDITIONS[condition]
        if condition_triples in crate_aliases:
            crate_aliases[condition_triples].update(deps)
        else:
            crate_aliases.update({_CONDITIONS[condition]: dict(deps.items() + common_items)})

    return selects.with_or(crate_aliases)

###############################################################################
# WORKSPACE MEMBER DEPS AND ALIASES
###############################################################################

_NORMAL_DEPENDENCIES = {
    "vendor_remote_manifests": {
        _COMMON_CONDITION: {
            "tokio": "@crates_vendor_manifests__tokio-1.18.2//:tokio",
        },
    },
}

_NORMAL_ALIASES = {
    "vendor_remote_manifests": {
        _COMMON_CONDITION: {
        },
    },
}

_NORMAL_DEV_DEPENDENCIES = {
    "vendor_remote_manifests": {
        _COMMON_CONDITION: {
            "tempfile": "@crates_vendor_manifests__tempfile-3.3.0//:tempfile",
            "tokio-test": "@crates_vendor_manifests__tokio-test-0.4.2//:tokio_test",
        },
    },
}

_NORMAL_DEV_ALIASES = {
    "vendor_remote_manifests": {
        _COMMON_CONDITION: {
        },
    },
}

_PROC_MACRO_DEPENDENCIES = {
    "vendor_remote_manifests": {
    },
}

_PROC_MACRO_ALIASES = {
    "vendor_remote_manifests": {
    },
}

_PROC_MACRO_DEV_DEPENDENCIES = {
    "vendor_remote_manifests": {
    },
}

_PROC_MACRO_DEV_ALIASES = {
    "vendor_remote_manifests": {
        _COMMON_CONDITION: {
        },
    },
}

_BUILD_DEPENDENCIES = {
    "vendor_remote_manifests": {
    },
}

_BUILD_ALIASES = {
    "vendor_remote_manifests": {
    },
}

_BUILD_PROC_MACRO_DEPENDENCIES = {
    "vendor_remote_manifests": {
    },
}

_BUILD_PROC_MACRO_ALIASES = {
    "vendor_remote_manifests": {
    },
}

_CONDITIONS = {
    "aarch64-pc-windows-msvc": [],
    "aarch64-uwp-windows-msvc": [],
    "cfg(all(any(target_arch = \"x86_64\", target_arch = \"aarch64\"), target_os = \"hermit\"))": [],
    "cfg(any(unix, target_os = \"wasi\"))": ["aarch64-apple-darwin", "aarch64-apple-ios", "aarch64-apple-ios-sim", "aarch64-linux-android", "aarch64-unknown-linux-gnu", "arm-unknown-linux-gnueabi", "armv7-unknown-linux-gnueabi", "i686-apple-darwin", "i686-linux-android", "i686-unknown-freebsd", "i686-unknown-linux-gnu", "powerpc-unknown-linux-gnu", "s390x-unknown-linux-gnu", "wasm32-wasi", "x86_64-apple-darwin", "x86_64-apple-ios", "x86_64-linux-android", "x86_64-unknown-freebsd", "x86_64-unknown-linux-gnu"],
    "cfg(not(windows))": ["aarch64-apple-darwin", "aarch64-apple-ios", "aarch64-apple-ios-sim", "aarch64-linux-android", "aarch64-unknown-linux-gnu", "arm-unknown-linux-gnueabi", "armv7-unknown-linux-gnueabi", "i686-apple-darwin", "i686-linux-android", "i686-unknown-freebsd", "i686-unknown-linux-gnu", "powerpc-unknown-linux-gnu", "riscv32imc-unknown-none-elf", "s390x-unknown-linux-gnu", "wasm32-unknown-unknown", "wasm32-wasi", "x86_64-apple-darwin", "x86_64-apple-ios", "x86_64-linux-android", "x86_64-unknown-freebsd", "x86_64-unknown-linux-gnu"],
    "cfg(target_arch = \"wasm32\")": ["wasm32-unknown-unknown", "wasm32-wasi"],
    "cfg(target_os = \"redox\")": [],
    "cfg(target_os = \"wasi\")": ["wasm32-wasi"],
    "cfg(unix)": ["aarch64-apple-darwin", "aarch64-apple-ios", "aarch64-apple-ios-sim", "aarch64-linux-android", "aarch64-unknown-linux-gnu", "arm-unknown-linux-gnueabi", "armv7-unknown-linux-gnueabi", "i686-apple-darwin", "i686-linux-android", "i686-unknown-freebsd", "i686-unknown-linux-gnu", "powerpc-unknown-linux-gnu", "s390x-unknown-linux-gnu", "x86_64-apple-darwin", "x86_64-apple-ios", "x86_64-linux-android", "x86_64-unknown-freebsd", "x86_64-unknown-linux-gnu"],
    "cfg(windows)": ["i686-pc-windows-msvc", "x86_64-pc-windows-msvc"],
    "i686-pc-windows-gnu": [],
    "i686-pc-windows-msvc": ["i686-pc-windows-msvc"],
    "i686-uwp-windows-gnu": [],
    "i686-uwp-windows-msvc": [],
    "x86_64-pc-windows-gnu": [],
    "x86_64-pc-windows-msvc": ["x86_64-pc-windows-msvc"],
    "x86_64-uwp-windows-gnu": [],
    "x86_64-uwp-windows-msvc": [],
}

###############################################################################

def crate_repositories():
    """A macro for defining repositories for all generated crates"""
    maybe(
        http_archive,
        name = "crates_vendor_manifests__async-stream-0.3.3",
        sha256 = "dad5c83079eae9969be7fadefe640a1c566901f05ff91ab221de4b6f68d9507e",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/async-stream/0.3.3/download"],
        strip_prefix = "async-stream-0.3.3",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.async-stream-0.3.3.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__async-stream-impl-0.3.3",
        sha256 = "10f203db73a71dfa2fb6dd22763990fa26f3d2625a6da2da900d23b87d26be27",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/async-stream-impl/0.3.3/download"],
        strip_prefix = "async-stream-impl-0.3.3",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.async-stream-impl-0.3.3.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__autocfg-1.1.0",
        sha256 = "d468802bab17cbc0cc575e9b053f41e72aa36bfa6b7f55e3529ffa43161b97fa",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/autocfg/1.1.0/download"],
        strip_prefix = "autocfg-1.1.0",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.autocfg-1.1.0.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__bitflags-1.3.2",
        sha256 = "bef38d45163c2f1dde094a7dfd33ccf595c92905c8f8f4fdc18d06fb1037718a",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/bitflags/1.3.2/download"],
        strip_prefix = "bitflags-1.3.2",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.bitflags-1.3.2.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__bytes-1.1.0",
        sha256 = "c4872d67bab6358e59559027aa3b9157c53d9358c51423c17554809a8858e0f8",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/bytes/1.1.0/download"],
        strip_prefix = "bytes-1.1.0",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.bytes-1.1.0.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__cfg-if-1.0.0",
        sha256 = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/cfg-if/1.0.0/download"],
        strip_prefix = "cfg-if-1.0.0",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.cfg-if-1.0.0.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__fastrand-1.7.0",
        sha256 = "c3fcf0cee53519c866c09b5de1f6c56ff9d647101f81c1964fa632e148896cdf",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/fastrand/1.7.0/download"],
        strip_prefix = "fastrand-1.7.0",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.fastrand-1.7.0.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__futures-core-0.3.21",
        sha256 = "0c09fd04b7e4073ac7156a9539b57a484a8ea920f79c7c675d05d289ab6110d3",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/futures-core/0.3.21/download"],
        strip_prefix = "futures-core-0.3.21",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.futures-core-0.3.21.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__hermit-abi-0.1.19",
        sha256 = "62b467343b94ba476dcb2500d242dadbb39557df889310ac77c5d99100aaac33",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/hermit-abi/0.1.19/download"],
        strip_prefix = "hermit-abi-0.1.19",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.hermit-abi-0.1.19.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__instant-0.1.12",
        sha256 = "7a5bbe824c507c5da5956355e86a746d82e0e1464f65d862cc5e71da70e94b2c",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/instant/0.1.12/download"],
        strip_prefix = "instant-0.1.12",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.instant-0.1.12.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__libc-0.2.126",
        sha256 = "349d5a591cd28b49e1d1037471617a32ddcda5731b99419008085f72d5a53836",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/libc/0.2.126/download"],
        strip_prefix = "libc-0.2.126",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.libc-0.2.126.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__lock_api-0.4.7",
        sha256 = "327fa5b6a6940e4699ec49a9beae1ea4845c6bab9314e4f84ac68742139d8c53",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/lock_api/0.4.7/download"],
        strip_prefix = "lock_api-0.4.7",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.lock_api-0.4.7.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__log-0.4.17",
        sha256 = "abb12e687cfb44aa40f41fc3978ef76448f9b6038cad6aef4259d3c095a2382e",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/log/0.4.17/download"],
        strip_prefix = "log-0.4.17",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.log-0.4.17.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__memchr-2.5.0",
        sha256 = "2dffe52ecf27772e601905b7522cb4ef790d2cc203488bbd0e2fe85fcb74566d",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/memchr/2.5.0/download"],
        strip_prefix = "memchr-2.5.0",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.memchr-2.5.0.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__mio-0.8.3",
        sha256 = "713d550d9b44d89174e066b7a6217ae06234c10cb47819a88290d2b353c31799",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/mio/0.8.3/download"],
        strip_prefix = "mio-0.8.3",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.mio-0.8.3.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__num_cpus-1.13.1",
        sha256 = "19e64526ebdee182341572e50e9ad03965aa510cd94427a4549448f285e957a1",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/num_cpus/1.13.1/download"],
        strip_prefix = "num_cpus-1.13.1",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.num_cpus-1.13.1.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__once_cell-1.12.0",
        sha256 = "7709cef83f0c1f58f666e746a08b21e0085f7440fa6a29cc194d68aac97a4225",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/once_cell/1.12.0/download"],
        strip_prefix = "once_cell-1.12.0",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.once_cell-1.12.0.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__parking_lot-0.12.0",
        sha256 = "87f5ec2493a61ac0506c0f4199f99070cbe83857b0337006a30f3e6719b8ef58",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/parking_lot/0.12.0/download"],
        strip_prefix = "parking_lot-0.12.0",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.parking_lot-0.12.0.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__parking_lot_core-0.9.3",
        sha256 = "09a279cbf25cb0757810394fbc1e359949b59e348145c643a939a525692e6929",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/parking_lot_core/0.9.3/download"],
        strip_prefix = "parking_lot_core-0.9.3",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.parking_lot_core-0.9.3.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__pin-project-lite-0.2.9",
        sha256 = "e0a7ae3ac2f1173085d398531c705756c94a4c56843785df85a60c1a0afac116",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/pin-project-lite/0.2.9/download"],
        strip_prefix = "pin-project-lite-0.2.9",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.pin-project-lite-0.2.9.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__proc-macro2-1.0.39",
        sha256 = "c54b25569025b7fc9651de43004ae593a75ad88543b17178aa5e1b9c4f15f56f",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/proc-macro2/1.0.39/download"],
        strip_prefix = "proc-macro2-1.0.39",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.proc-macro2-1.0.39.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__quote-1.0.18",
        sha256 = "a1feb54ed693b93a84e14094943b84b7c4eae204c512b7ccb95ab0c66d278ad1",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/quote/1.0.18/download"],
        strip_prefix = "quote-1.0.18",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.quote-1.0.18.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__redox_syscall-0.2.13",
        sha256 = "62f25bc4c7e55e0b0b7a1d43fb893f4fa1361d0abe38b9ce4f323c2adfe6ef42",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/redox_syscall/0.2.13/download"],
        strip_prefix = "redox_syscall-0.2.13",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.redox_syscall-0.2.13.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__remove_dir_all-0.5.3",
        sha256 = "3acd125665422973a33ac9d3dd2df85edad0f4ae9b00dafb1a05e43a9f5ef8e7",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/remove_dir_all/0.5.3/download"],
        strip_prefix = "remove_dir_all-0.5.3",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.remove_dir_all-0.5.3.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__scopeguard-1.1.0",
        sha256 = "d29ab0c6d3fc0ee92fe66e2d99f700eab17a8d57d1c1d3b748380fb20baa78cd",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/scopeguard/1.1.0/download"],
        strip_prefix = "scopeguard-1.1.0",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.scopeguard-1.1.0.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__signal-hook-registry-1.4.0",
        sha256 = "e51e73328dc4ac0c7ccbda3a494dfa03df1de2f46018127f60c693f2648455b0",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/signal-hook-registry/1.4.0/download"],
        strip_prefix = "signal-hook-registry-1.4.0",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.signal-hook-registry-1.4.0.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__smallvec-1.8.0",
        sha256 = "f2dd574626839106c320a323308629dcb1acfc96e32a8cba364ddc61ac23ee83",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/smallvec/1.8.0/download"],
        strip_prefix = "smallvec-1.8.0",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.smallvec-1.8.0.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__socket2-0.4.4",
        sha256 = "66d72b759436ae32898a2af0a14218dbf55efde3feeb170eb623637db85ee1e0",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/socket2/0.4.4/download"],
        strip_prefix = "socket2-0.4.4",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.socket2-0.4.4.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__syn-1.0.95",
        sha256 = "fbaf6116ab8924f39d52792136fb74fd60a80194cf1b1c6ffa6453eef1c3f942",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/syn/1.0.95/download"],
        strip_prefix = "syn-1.0.95",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.syn-1.0.95.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__tempfile-3.3.0",
        sha256 = "5cdb1ef4eaeeaddc8fbd371e5017057064af0911902ef36b39801f67cc6d79e4",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/tempfile/3.3.0/download"],
        strip_prefix = "tempfile-3.3.0",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.tempfile-3.3.0.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__tokio-1.18.2",
        sha256 = "4903bf0427cf68dddd5aa6a93220756f8be0c34fcfa9f5e6191e103e15a31395",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/tokio/1.18.2/download"],
        strip_prefix = "tokio-1.18.2",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.tokio-1.18.2.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__tokio-macros-1.7.0",
        sha256 = "b557f72f448c511a979e2564e55d74e6c4432fc96ff4f6241bc6bded342643b7",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/tokio-macros/1.7.0/download"],
        strip_prefix = "tokio-macros-1.7.0",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.tokio-macros-1.7.0.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__tokio-stream-0.1.8",
        sha256 = "50145484efff8818b5ccd256697f36863f587da82cf8b409c53adf1e840798e3",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/tokio-stream/0.1.8/download"],
        strip_prefix = "tokio-stream-0.1.8",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.tokio-stream-0.1.8.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__tokio-test-0.4.2",
        sha256 = "53474327ae5e166530d17f2d956afcb4f8a004de581b3cae10f12006bc8163e3",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/tokio-test/0.4.2/download"],
        strip_prefix = "tokio-test-0.4.2",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.tokio-test-0.4.2.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__unicode-ident-1.0.0",
        sha256 = "d22af068fba1eb5edcb4aea19d382b2a3deb4c8f9d475c589b6ada9e0fd493ee",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/unicode-ident/1.0.0/download"],
        strip_prefix = "unicode-ident-1.0.0",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.unicode-ident-1.0.0.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__wasi-0.11.0-wasi-snapshot-preview1",
        sha256 = "9c8d87e72b64a3b4db28d11ce29237c246188f4f51057d65a7eab63b7987e423",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/wasi/0.11.0+wasi-snapshot-preview1/download"],
        strip_prefix = "wasi-0.11.0+wasi-snapshot-preview1",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.wasi-0.11.0+wasi-snapshot-preview1.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__winapi-0.3.9",
        sha256 = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/winapi/0.3.9/download"],
        strip_prefix = "winapi-0.3.9",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.winapi-0.3.9.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__winapi-i686-pc-windows-gnu-0.4.0",
        sha256 = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/winapi-i686-pc-windows-gnu/0.4.0/download"],
        strip_prefix = "winapi-i686-pc-windows-gnu-0.4.0",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.winapi-i686-pc-windows-gnu-0.4.0.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__winapi-x86_64-pc-windows-gnu-0.4.0",
        sha256 = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/winapi-x86_64-pc-windows-gnu/0.4.0/download"],
        strip_prefix = "winapi-x86_64-pc-windows-gnu-0.4.0",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.winapi-x86_64-pc-windows-gnu-0.4.0.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__windows-sys-0.36.1",
        sha256 = "ea04155a16a59f9eab786fe12a4a450e75cdb175f9e0d80da1e17db09f55b8d2",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/windows-sys/0.36.1/download"],
        strip_prefix = "windows-sys-0.36.1",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.windows-sys-0.36.1.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__windows_aarch64_msvc-0.36.1",
        sha256 = "9bb8c3fd39ade2d67e9874ac4f3db21f0d710bee00fe7cab16949ec184eeaa47",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/windows_aarch64_msvc/0.36.1/download"],
        strip_prefix = "windows_aarch64_msvc-0.36.1",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.windows_aarch64_msvc-0.36.1.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__windows_i686_gnu-0.36.1",
        sha256 = "180e6ccf01daf4c426b846dfc66db1fc518f074baa793aa7d9b9aaeffad6a3b6",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/windows_i686_gnu/0.36.1/download"],
        strip_prefix = "windows_i686_gnu-0.36.1",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.windows_i686_gnu-0.36.1.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__windows_i686_msvc-0.36.1",
        sha256 = "e2e7917148b2812d1eeafaeb22a97e4813dfa60a3f8f78ebe204bcc88f12f024",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/windows_i686_msvc/0.36.1/download"],
        strip_prefix = "windows_i686_msvc-0.36.1",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.windows_i686_msvc-0.36.1.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__windows_x86_64_gnu-0.36.1",
        sha256 = "4dcd171b8776c41b97521e5da127a2d86ad280114807d0b2ab1e462bc764d9e1",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/windows_x86_64_gnu/0.36.1/download"],
        strip_prefix = "windows_x86_64_gnu-0.36.1",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.windows_x86_64_gnu-0.36.1.bazel"),
    )

    maybe(
        http_archive,
        name = "crates_vendor_manifests__windows_x86_64_msvc-0.36.1",
        sha256 = "c811ca4a8c853ef420abd8592ba53ddbbac90410fab6903b3e79972a631f7680",
        type = "tar.gz",
        urls = ["https://crates.io/api/v1/crates/windows_x86_64_msvc/0.36.1/download"],
        strip_prefix = "windows_x86_64_msvc-0.36.1",
        build_file = Label("@examples//vendor_remote_manifests/crates:BUILD.windows_x86_64_msvc-0.36.1.bazel"),
    )
