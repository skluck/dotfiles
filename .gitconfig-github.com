[user]
    email = 3161125+skluck@users.noreply.github.com

# Add the following to ~/.ssh/config and use as git remotes:
# git@personal_github:<org>/<repo>.git
# Host personal_github
#   HostName                 github.com
#   IdentityFile             ~/.ssh/personal/id_rsa
#   IdentitiesOnly           yes
#   ForwardAgent             no
