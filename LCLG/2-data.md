---

author: Andrey
title: LCLG - Working with Data
date: Jan 27, 2023
styles:
  style: gruvbox-dark
  link:
    bg: default
    fg: '#c40'

---

# Linux Command Line Guide - Working with Data

This presentation will introduce you to some instruments of Linux command line that will help you to work with data. This includes special programs that allow you to search and modify files as well as some Bash tricks that will make your work with files data easier


# Searching in files

One of the most common tasks in Linux is searching for some data in files. The most common program for that is `grep`. It allows you to search for a string in a file or a set of files. It is very useful when you need to find some data in a log file or configs

## Plain text search

The simplest way to search for a string in a file is to use the `grep` command. It will search for a string in a file and print all lines that contain the string. You can also use `-o` flag to print only the matching part of the line - the text that you searched for. Syntax for `grep` is `grep TEXT [FILES...]`. If you don't specify any files, `grep` will search in the standard input. You can also use `-i` flag to make the search case-insensitive.


## Regular expressions

The same `grep` command can be used to search for a regular expression. Regular expressions are a powerful tool that allows you to search for a pattern in a text. You can use them to search for a string that contains a certain word or a string that contain certain characters. Complex regex is hard to write and even harder to read, but they are unbelievably powerful and can be used to search for almost anything. Usage - `grep -E REGEX [FILES...]`. Other rules of plain `grep` apply here

```terminal16
sh
```

# Searching for files

Another common task is searching for files. The most common program for that is `find`. It allows you to search for files in a directory and its subdirectories. It is very useful when you need to find a file that you forgot where you put it. You can also use it to find files that match some criteria, for example, files that were modified in the last 24 hours

## General form

The general form of `find` is `find [PATH] [OPTIONS]`. If you don't specify a path, `find` will search in the current directory. If you don't specify any options, `find` will print all files in the directory and subdirectories

## Options

The `find` utility is extremely powerful and provides a bunch of options that allow you to search for files that match certain criteria. The most common options are:

- `-name` or `-iname` - search for files with a certain name, the latter is case-insensitive
- `-type` - search for files of a certain type, for example, `-type f` will search for files, `-type d` will search for directories
- `-size` - search for files of a certain size, for example, `-size 100M` will search for files that are at least 100 megabytes in size and `-size -2K` will search for files that are less than 2 kilobytes in size
- `-{a,m,c}time` - search for files that were accessed, modified or metadata changed in the last N+1 days, for example, `-mtime -1` will search for files that were modified in the last 48 hours
- `-user` or `-group` - search for files that belong to a certain user or group
- `-perm` - search for files with a certain permission, for example, `-perm 777` will search for files that are readable, writable and executable by everyone (☭)
