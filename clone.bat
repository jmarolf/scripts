echo off
set repo=%1
pushd C:\source
git clone https://github.com/jmarolf/%repo%.git
cd %repo%
git remote add upstream https://github.com/dotnet/%repo%.git
git fetch --all --prune
popd