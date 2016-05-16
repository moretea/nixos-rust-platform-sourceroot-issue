(cd rust_build_subdir; nix-build 2>&1 ) > rust_subdir.log
(cd rust_build_parent_dir/sub_project; nix-build 2>&1) > rust_parentdir.log
(cd stdenv_build_subdir/sub_project; nix-build 2>&1) > stdenv_subdir.log
