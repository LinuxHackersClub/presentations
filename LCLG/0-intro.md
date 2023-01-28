---

author: Andrey
title: LCLG - Introduction
date: Jan 27, 2023
styles:
  style: gruvbox-dark
  link:
    bg: default
    fg: '#c40'

---

# Linux Command Line Guide - Introduction

This guide will introduce you to the basics of Command Line Interface and some basic commmands

This is the first presentation in `Linux CLI Guides` series that will hopefully have many other slides


# GUI, TUI and CLI as different methods of communication with user

> GUI is what you probably use most of the time - regular graphical apps with neat menus, buttons, pop-ups etc., this is what a normie usually refers to as *an app*. To create a GUI app one should use some `graphical toolkit` such as Qt or GTK not to reinvent the wheel

[//]: #
> TUI is basically the same but in terminal. These apps also can have buttons and text areas and sometimes even menus, but are made using only text characters (not always ASCII). The easiest tool for creating such applications is `dialog`, but there are other libraries depending on the programming language you wish to use. There are numerous greate TUI projects: *btop*, *spotify-tui* and *clifm*, to name a few

[//]: #
> CLI is much more simple to implement, and thus is often used in small tools such as `cat` and `ls`, but also is common among programs that might be used in scripting such as `ffmpeg` and `imagemagick`

So, what exactly is a Command Line? Basically, it is a text interface using which you can interact with you operating system (Linux, MacOS and sometimes w\*ndows). Unlike GUI and TUI apps, you type every command - and call *executables* - yourself. A *shell* such as Bash (Bourne Again Shell) or Zsh is used to make our lives easier, it is the program that asks user user for command (through CLI), executes it and shows the result - [think about why do we need a special program for that](because it not only asks user for command, but also parses its arguments, sets environment variables, substitutes variables and commands, redirects output etc.)

Several applications have been written that use interfaces becase of their adventages in some fields. To give you some ideas on what can be achieved using only CLI or TUI, I suggest you [searching for awesome-{cli,tui} on GitHub](https://github.com/agarrharr/awesome-cli-apps)


# Linux starter pack - basic tools

Most Linux distros come with GNU coreutils preinstalled (some use Busybox instead, [try to find them](Alpine and Tinycore to name a few, heck, even Linux initrd, aka initramfs, aka initial ram disk uses them) - but every system does have some) which is just a bunch of different utilites that users or other apps often use. By the way, this is the reason some people prefer `GNU/Linux` naming instead of just `Linux`. Here are some comon Linux commands

## ls

List directory contents. With no arguments shows files and folders (we call them *directories*) of the current dir (or `.`). Common arguments include `-a`/`-A`, `-h` and `-l`. First two force displaying *hidden files* - those starting with dot. Second directs to display size in human-readable format and `-l` makes it display in long format - with permissions, owner, size etc. Other options such as `-C` (display output in columns) and `--color` are usually aliased

## cd

Change directory. With no arguments returns you to `$HOME` (the *HOME* environment variable, often seen as `~` for short, most likely is `/home/$USER` - e.g. /home/andrey). Its single argument is the directory to go to. If it is `-` then it will go to `$OLDPWD` dir - the one you were before the last `cd`

## pwd

Print working directory. That's it. If the `-L` option is given, it will use `$PWD` environment variable and will not resolve symlinks


# Linux starter pack - basic tools

Now check out tools that allow you to manipulate files and directories

## mkdir

Make directories. You will often see it with `-p`/`--parent` argument which is used to create all the necessary parent directories

## touch

Updates access and modification times of a file, creates one if it does not exist

## rm

Remove files or directories. To remove empty dir use `rmdir` or `rm -d`, to remove directory recursively (with all the files in it!) run `rm -r`

## cp

Leave ur dirty things with you, it's just **C**o**P**y. Usage - `cp <src> <dst>`, or `cp -r`/`cp -R` to copy directories recursively

## ln

Link files. Creates symlinks or hard links. To create the first type, use `ln -s <src> <dst>`. You don't need hard links if you don't know them


# Linux starter pack - basic tools

Some more things for you

## mktemp

Make temporary file or directory. Used mostly in scripts to ensure that file will always be created and not overwritten. For usage see [mktemp(1)](man 1 mktemp, or just man mktemp)

## man

Manual pages is the place to learn how each command works, which arguments it can take etc. To read a *manpage*, type `man <topic>`, or `man <section> <topic>`. For example, type `man man` ~~no homo~~ to [get information about each section](1. Executables, 2. System calls, 3. Library calls, 4. Special files, 5. File formats, 6. Games, 7. Misc, 8. Sysadmin tools, 9. Kernel routines)

## echo

Print text to standard output (e.g. console), used mostly in scripts. Syntax - `echo Hello World` or `echo "Hello, World!"`, it concatenates multiple arguments with spaces

## read

Reads a line from standard input (e.g. console) and stores it in a variable. Syntax - `read <var>`, for example `read -p "Enter your name: " name` will ask you to enter your name and store it in `$name` variable. Without a variable name it will store in `$REPLY`. You can also use `-s` to hide input (e.g. for passwords), `-n <num>` to read only `<num>` characters, `-r` to disable backslash interpretation (e.g. `\n` will be printed as is) and other options, but they often vary from shell to shell

## cat

Display files content, or read from stdin. Examples: `cat script.py` to see content inside `script.py` file, `cat > myfile` to save whatever you will type until EOF (Ctrl+D) to `myfile`


# To sum up

Of course this was not a full list of coreutils - there are much more available for you! But using this list as reference you can start using your terminal and learn other tools step-by-step. My main goal was to give you an idea what can be achieved and how things work and most importantly to encourage you learning Linux

```terminal24
sh
```
