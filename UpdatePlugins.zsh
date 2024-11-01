#!/bin/zsh
chmod +x UpdatePlugins.zsh

# Apple Plugin Git Details
apple_plugin_repo_url="https://github.com/apple/unityplugins.git"
apple_plugin_dir="unityplugins"
apple_plugin_build_dir="${apple_plugin_dir}/Build"
dest="Packages"
build_dir="Build"
# core_plugin_dir="com.apple.unityplugin.core-3.1.5"
# gamekit_plugin_dir="com.apple.unityplugin.gamekit-3.0.0"

# Clone as submodule
echo "Updating remote checkout of ${apple_plugin_repo_url} ..."
rm -rf $apple_plugin_dir
git clone $apple_plugin_repo_url

# Change directory into generated repos
cd $apple_plugin_dir

# Apple's build script command
python3 build.py -p Core GameKit -m macOS iOS

# Change back to base directory and copy generated packages over
cd ../

if [ ! -d $dest ]; then
    mkdir $dest
else
    rm -rf $dest
    mkdir $dest
fi
cp -a "${apple_plugin_build_dir}" $dest

# remove cloned repos, restoring back to clean state
rm -rf $apple_plugin_dir

# Will look into maintenance for using git URL
# Change to generated package files and unzip them
# cd "${dest}/${build_dir}"

# if [ ! -d $core_plugin_dir ]; then
#     mkdir $core_plugin_dir
# fi
# tar --extract --file "${core_plugin_dir}.tgz" -C $core_plugin_dir

# if [ ! -d $gamekit_plugin_dir ]; then
#     mkdir $gamekit_plugin_dir
# fi
# tar --extract --file "${gamekit_plugin_dir}.tgz" -C $gamekit_plugin_dir
