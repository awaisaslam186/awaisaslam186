#!/bin/sh

############
# The following script is to help automate deployment of hugo sites on github pages. 
# If you're just getting started, I recommend reading my full notes here: 
# https://www.romandesign.co/setting-up-a-hugo-static-site-on-github/
# 
# To run it, make sure you have made some site updates to deploy and via terminal in your backend and save the code in your hugo backend repo. 
# Then type the following (no $):
#
# 	$ chmod +x deploy.sh  #### This will make your script executable. You only need to type this once to modify permissions.
#    	$ ./deploy.sh "Your optional commit message"   #### This will actually run the code. 
#
############


# If a command fails then the deploy stops
set -e

# Just a tooltip to let you know the script is running.
printf "\033[0;32mDeploying updates to GitHub...\033[0m\n" 

# Build the hugo site to both of your repos
hugo
hugo -d ../yourgithubusername.github.io # This builds the public site into your public repo. !!!!! Make sure to replace with your currect public repo here

# Deploy your public site
cd ../yourgithubusername.github.io # Goes to your public site repo
git init # Initiatilizes git
git add . # Adds changes

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi

git commit -m "$msg" # Makes your commit with the message from your deploy script execution
git push origin master # Pushes the code to GitHub

# Now deploy your backend with all of the 
cd ../hugosite_backend #!!!!! Make sure to replace with your currect backend repo here.
git add . # Adds changes

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi

git commit -m "$msg" # Makes your commit with the message from your deploy script execution
git push origin master # Pushes the code to GitHub