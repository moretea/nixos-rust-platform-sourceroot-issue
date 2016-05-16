# Some examples for stdenv build issue

When using `sourceRoot` with the rustPlatform, I have encountered some problems with filesystem permissions.
I reduced it to a case where stdenv also fails.
I think that the stdenv C example I provided could be made to work, but 
a) lots of projects have some form of code generation that requires to update the source
b) the rustplatform actually modifies a source file, `Cargo.lock`, to point to
   a cargo registry that is in the nix store.

Run `build.sh` to run all provided examples, and check the `*.log` files to verify the problem.

## Test output
The output on my machine is:

### For `stdenv_subdir.log`
**NOTE**: I've set `dontMakeSourcesWritable` for this testcase, to show
that even a `stdenv` based build requires some some things to be modifiable
```
these derivations will be built:
  /nix/store/9qqxa0rcxpbmipj7lxp9a7nrdgznmyi8-failure.drv
building path(s) ‘/nix/store/qfm99fxz1da8d6cmhfcqn01a24hxld0p-failure’
unpacking sources
unpacking source archive /nix/store/30l78fwm2r0f7alwvsfwc8bw0k99kc11-stdenv_build_subdir
source root is /nix/store/30l78fwm2r0f7alwvsfwc8bw0k99kc11-stdenv_build_subdir/sub_project
patching sources
configuring
configure flags: --prefix=/nix/store/qfm99fxz1da8d6cmhfcqn01a24hxld0p-failure  
./configure: line 1377: config.log: Permission denied
./configure: line 1387: config.log: Permission denied
builder for ‘/nix/store/9qqxa0rcxpbmipj7lxp9a7nrdgznmyi8-failure.drv’ failed with exit code 1
error: build of ‘/nix/store/9qqxa0rcxpbmipj7lxp9a7nrdgznmyi8-failure.drv’ failed
```

### For `rust_parentdir.log`
```
these derivations will be built:
  /nix/store/6jii9vxm7cnb9gm9h2mvvgrvxpddzzg3-failure-fetch.drv
  /nix/store/x8vlz6i2gn646wgsk72dnnlgcwmawamb-failure.drv
building path(s) ‘/nix/store/0bhckv0if2sz0kly9gwby3d4aj796dr9-failure-fetch’
unpacking sources
unpacking source archive /nix/store/127ngrm9pslsv7lxw9qs7g1gxkn7zn5n-rust_build_parent_dir
source root is /nix/store/127ngrm9pslsv7lxw9qs7g1gxkn7zn5n-rust_build_parent_dir/sub_project
chmod: changing permissions of '/nix/store/127ngrm9pslsv7lxw9qs7g1gxkn7zn5n-rust_build_parent_dir/sub_project': Operation not permitted
chmod: changing permissions of '/nix/store/127ngrm9pslsv7lxw9qs7g1gxkn7zn5n-rust_build_parent_dir/sub_project/Cargo.toml': Operation not permitted
chmod: changing permissions of '/nix/store/127ngrm9pslsv7lxw9qs7g1gxkn7zn5n-rust_build_parent_dir/sub_project/default.nix': Operation not permitted
chmod: changing permissions of '/nix/store/127ngrm9pslsv7lxw9qs7g1gxkn7zn5n-rust_build_parent_dir/sub_project/src': Operation not permitted
chmod: changing permissions of '/nix/store/127ngrm9pslsv7lxw9qs7g1gxkn7zn5n-rust_build_parent_dir/sub_project/src/lib.rs': Operation not permitted
chmod: changing permissions of '/nix/store/127ngrm9pslsv7lxw9qs7g1gxkn7zn5n-rust_build_parent_dir/sub_project/Cargo.lock': Operation not permitted
builder for ‘/nix/store/6jii9vxm7cnb9gm9h2mvvgrvxpddzzg3-failure-fetch.drv’ failed with exit code 1
cannot build derivation ‘/nix/store/x8vlz6i2gn646wgsk72dnnlgcwmawamb-failure.drv’: 1 dependencies couldn't be built
error: build of ‘/nix/store/x8vlz6i2gn646wgsk72dnnlgcwmawamb-failure.drv’ failed
```

### For `rust_subdir.log`
```
these derivations will be built:
  /nix/store/gq2b3vi89dwgwvpb4nlkv6zwsmlgv4mq-failure-fetch.drv
  /nix/store/gg662wyanazppzsnhxw7zjzvrbmq4404-failure.drv
building path(s) ‘/nix/store/0bhckv0if2sz0kly9gwby3d4aj796dr9-failure-fetch’
unpacking sources
unpacking source archive /nix/store/c9mlwrbyrjiksl2lrxljzjaxc9ay54mb-rust_build_subdir
source root is /nix/store/c9mlwrbyrjiksl2lrxljzjaxc9ay54mb-rust_build_subdir/sub_project
chmod: changing permissions of '/nix/store/c9mlwrbyrjiksl2lrxljzjaxc9ay54mb-rust_build_subdir/sub_project': Operation not permitted
chmod: changing permissions of '/nix/store/c9mlwrbyrjiksl2lrxljzjaxc9ay54mb-rust_build_subdir/sub_project/Cargo.lock': Operation not permitted
chmod: changing permissions of '/nix/store/c9mlwrbyrjiksl2lrxljzjaxc9ay54mb-rust_build_subdir/sub_project/src': Operation not permitted
chmod: changing permissions of '/nix/store/c9mlwrbyrjiksl2lrxljzjaxc9ay54mb-rust_build_subdir/sub_project/src/lib.rs': Operation not permitted
chmod: changing permissions of '/nix/store/c9mlwrbyrjiksl2lrxljzjaxc9ay54mb-rust_build_subdir/sub_project/Cargo.toml': Operation not permitted
builder for ‘/nix/store/gq2b3vi89dwgwvpb4nlkv6zwsmlgv4mq-failure-fetch.drv’ failed with exit code 1
cannot build derivation ‘/nix/store/gg662wyanazppzsnhxw7zjzvrbmq4404-failure.drv’: 1 dependencies couldn't be built
error: build of ‘/nix/store/gg662wyanazppzsnhxw7zjzvrbmq4404-failure.drv’ failed
```
