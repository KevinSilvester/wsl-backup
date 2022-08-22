## Working with git submodules

> ref: https://stackoverflow.com/a/5828396/14823039

```bash
# Get the submodule initially
git submodule add ssh://bla submodule_dir
git submodule init

# Time passes, submodule upstream is updated
# and you now want to update

# Change to the submodule directory
cd submodule_dir

# Checkout desired branch
git checkout master

# Update
git pull

# Get back to your project root
cd ..

# Now the submodules are in the state you want, so
git commit -am "Pulled down update to submodule_dir"
```
