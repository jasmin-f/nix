# Git
(Ist jetzt ein Englisch/Deutsch Mix, neue Kommentare werden auf Englisch geschrieben. Aber Notizen die sowieso nur für mich praktisch sind, lasse ich Deutsch.)

### Commands

```bash
git config --global user.name Jasmin
git config --global user.email jf@ost.ch
git config --global core.editor <>
git config --global alias.graph "log --all --decorate --graph --oneline"
git config --list


# new repo
git init

#
git add [-u] [-p]
git commit [-a] [-v] [-m "commit Message"]


# work tree state at HEAD
git status
git log

git graph

# 
git branch
git switch / checkout
git merge / rebase

# managing remotes and cloning
git remote add
git clone
git fetch / pull / push


# stash (Zwischenspeicher)
# - but first commit important files


# binary search with git bisect, to find error
git bisect start
git bisect bad / good / skip
```

### Configuration
configs in homemanager speichern wenn möglich.  
Windows: <https://gitforwindows.org/>


### Login

#### token from Gitlab

- Log in to your GitHub account.
- Go to Settings > Developer settings > Personal access tokens.
- Click on Generate new token.
- Select the scopes or permissions you need.
- Copy the generated token.

- for git authentication enter token instead of password
- Cache Login

```bash
git config --global credential.helper store 
git config --global credential.helper forget
```

[Source Stackoverflow](https://stackoverflow.com/questions/35942754/how-can-i-save-username-and-password-in-git)

#### SSH

Create SSH Key /root/.ssh/
<https://docs.gitlab.com/user/ssh/>

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa # Name anpassen

# public key kopieren und einfügen bei gitlab
cat ~/.ssh/id_rsa.pub # Name anpassen

# hat nicht funktioniert bei Gitlab von Schule
ssh -T git@gitlab.com
```

#### Github

```shell
gh auth login
```

### Infos

[OST Git Workshop](https://github.com/OST-Stud/Git-Workshop)

origin/main ist online Version
main ist lokale Version

#### Graph

DAG Graph : directed acyclic graph

### Forking and Pull / Merge Requests

Most services provide a way to fetch the pull requests as if they were remote bhanches on your repository. Assuming the remote is named^2 origin for GitHub this can be achieved by running

    git config ——add remote. origin.fetch '    +refs/pull/*/head:refs/remotes/origin/pr/*'
    git fetch origin 
    git switch pr/5 

Then, you can check out any pull request using their ID, here for example #5. The same for GitLab:

    git config ——add remote.origin.fetch '+ref:refs/remotes/origin/mr/*'
    git fetch origin 
    git switch mr/5 

2) If your remote has a different name, replace all occurences of **origin**.

### change from clone to my new fork

- check origin
    `git remote -v`
- create my own repo (fork the original)
- replace remote with my fork
`git remote set-url origin <NEW_GIT_URL_HERE>`

evt. nötig:

- stash
- rebase

### Git tree is dirty

First save all changes (git add/commit/push).

The `git reset` command can be used to restore your working tree to a previous state.

```git
git reset --help
git reset --hard
```

Other possibly useful commands to clean git:

```
# The `-d` flag tells Git to delete directories, and the `-f` flag tells Git to force the removal of files.
git clean -n
git clean -d -f

git prune

# The `git checkout` command can be used to discard changes that have not been committed to your repository.
git checkout
```
