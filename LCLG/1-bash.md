---

author: Andrey
title: LCLG - Bourne Again Shell
date: Jan 27, 2023
styles:
  style: gruvbox-dark
  link:
    bg: default
    fg: '#c40'

---

# Linux Command Line Guide - the Bourne Again Shell

This is the secound presentation in LCLG series by Linux Hackers Club and this time we will talk about Bash shell which is the default in most major Linux ditributions. We will discuss its ~~scary~~ syntax, the `if-else` branches, `for` and `while` loops and many different things that will come handy when using terminals

# What is shell

Remember from the first presentation:
> Unix shell is a program that provides a convenient way to interact with system using Command Line Interface, e.g. typing commands and calling executables

There are generally two types of shells: Bourne shell aka POSIX sh ([while these are not absolutely the same, they are mostly identical](POSIX sh is the standard based on Bourne and adds just a few new things)), and C shell. The latter is surprisingly for me still alive, but mostly used in BSD-based systems. In fact, nowadays `tcsh`, the improved `csh`, is actively developed

Linux users typically use POSIX-compliant shells ([that's still not totally true](most shells includeing Bash and Zsh are by default not fully POSIX, but invoking them with special flags or environment variables makes them closer to POSIX sh, on some modern systems /bin/sh is a symlink to /bin/bash)). Debian, Ubuntu, Arch and most other distros use Bash as main shell (though Arch installation ISO comes with neat Zsh), but e.g. Parrot OS defaults to Zsh. Anyway, their syntax is mostly identical so scripts written in Bash are very likely to be executed by Zsh with little-to-no problems

# Basic operations

This slide will intoroduce you to the very basic and common things related to shells

## Calling executables

In the first presentation we discussed commands like `ls`, `cat` etc. which are separate executables located somewhere in filesystem (or FS for short). The exact place where the shell looks for executables is determined by `$PATH` variable with syntax `PATH="/dir1:/path/to/dir2:..."`. Typical setup uses `PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"`. The order here matters: the first directories are checked the first. To execute a program located in your `$PATH`, just type its name in terminal and press Enter aka Return

## Passing arguments

But you can't achieve much by just running these executables as is. To pass arguments to them, type them after a command separated by spaces, for example, `cat file1.txt file2.md` will display content of `file1.txt` and `file2.md` in order they are specified - [what if one has file with spaces in the name, e.g. "my cool file.txt"?](you can use the `\ ` to escape the space, or just use quotes - `"my cool file.txt"` or `'my cool file.txt'`)

## Changing environment

You can use variables not to repeate yourself many times. To set a variable, type `key=value`, where both key and value cannot contain spaces, also it is not allowed to use spaces around equality sign. If you need a space in value, enclose it in quotes. You can also use `declare [FLAGS] key=value` to set some attributes to the variable, e.g. indicate that it is an integer with `-i` or make it readonly with `-r`. To use this variable later, [prefix its name with dollar sign](a common practice is to always use ${key}), e.g. `echo $key`. If a variable is not readonly (default), then you can always redefine it (possibly with other attributes). To unset var, use `unset key`. To append string to it, use `key+=value2` - the same syntax applies to integers incrementing, but only if var is declared with `-i`. To decrement integer, one can just invert a number, e.g. `int+=-7`. For advanced integer operations, one should use `let "OPERATIONS"` - note however that `let` itself does not make a variable an integer

## Arrays

Bash also support arrays - both indexed and associatives, though none of them can be multi-dimensional. To create an array, use `name=( value1 value2 ... )`, or `name=( [key1]=value1 [key2]=value2 ... )` for associative arrays. Their flags in `declare` are `-a` and `-A` respectively. To get an elements of array, use `${name[key]}` syntax, or `$name` to get the first element (index 0), or `${name[@]}` to get all of them - [what if key associative array is @?](use quoted @). 


# Advanced variables operations

Suppose we have variables `ass=( [a]=1 [b]=4 [d]=9 )` `arr=( 1 2 3 5 )` and `str+"abcqwe"`

## Length of string or array

The `${#arr}` will return *4* and `${#str}` will return *6*

## Slicing strings by indices

General form is `${str:[START][:COUNT]}`, for example, `${str:2:3}` is *cqw* because strings also start from index 0, `${str:4}` is *we* and `${str::3}` is *abc*

## Accessing variable indirectly

If we have variable `var=str`, then we can get value of `$str` by using `${!var}` operator. Notice that all other operations such as `${!var:2}` will apply for `var`, not `str`! The same operator appears in arrays, both indexed and associatives, to get keys: `${!ass[@]}` is *a b d* and `${!arr[@]}` is *0 1 2 3*

## Slicing strings by patterns

Let's set variable `myvar="Hello, this beautiful World!"`. How do we get for example parts after *,* or before *W* without external tools? We can use operators `${myvar#*,}` and `${myvar%W*}`. This technique can be used to get the first or the last line/word of string easily


# Other things with variable

Just one more page before we leave variables topic

## Declarations

As it was mentioned before, you can use `declare` keyword to set attributes to variables, both during creation or somewhere later. It supports the following important keys:

- `-g` to make variable global (ignored outside functions) - variables set without `declare` keyword are global by default
- `-I` to copy attributes of global variable with the same name to the local one
- `-a` and `-A` for arrays indexed and associative
- `-i` for integers (no ~~bitches~~ floats?)
- `-n` to make variable a reference to another variable with the name of value of initial variable (in other words, this is what `${!name}` does, e.g. `declare -n var=str` will make `var` a *pointer* to `str`, and later `var="some value"` can be used to set `str` variable)
- `-l` and `-u` to convert strings to UPPER or lowercase when assigning new value - even after declaration - but does not impact whatever is already stored
- `-r` for readonly and `-x` for export - both can be set using their own keyword, e.g. `export MYVAR="Hello, World!"`

## Special variables

Bash gives us some special variables which can be used to obtain some useful info in scripts. Here is a list of the most often used:

- `$$` is current Process ID - changes only when you start a new shell
- `$PPID` is Parent Process ID - points to the process that created the current one
- `$?` is exit (aka return) code of the last command - 0 means Ok, 1 and greater Err
- `$1`, `$2` etc. are positional arguments passed to function/scripts, e.g. when using `cat file1 file2` then `$1` is file1 and `$2` is file2
- `$*` and `$@` both show all arguments together, but the former one is a string [concatenated with spaces](characters used to join arguments can be changed) and the latter is a list
- `$0` is the command running - for example, the filename of script you have launched, `/bin/bash` when you open terminal


# Branching code

It is often necessary to run some code only if some condition is true. For that purpose Bash has `if-then-elif-else-fi` statements. Consider the following example:

```bash
if grep "Some text" file.txt
then
    echo "It is there!"
elif grep "Other text" file.txt
    echo "Some other text appeared"
else
    echo "Nope..."
fi
```

Here Bash will first run the `grep "Some text" file.txt` command and check its exit code (remember `$?`?). If it is zero, then it will run the first echo and continue running code after `fi` keyword. Otherwise, it will run and check exit code of the second `grep` command and decide which `echo` to run

But how do you compare some variables? It seems like you need a command to run there, but which? And this is where the fun begins

If you prefer plain POSIX syntax, the you have `test` command or `[  ]` structure - both are effectively the same. Comparing strings here can be done using `test STRING1 = STRING2` or `[ STRING1 = STRING2 ]` (notice the spaces - there are necessary here!), but with integers you only have flags: `[ 2 -ge 1 ]` is *2 >= 1*. This often looks ugly and not convenient so Bash has another syntax

Faster and easier operator `[[  ]]` comes in hands when you write Bash scripts (who cares about POSIX anyway?). Using it you can compare integers normally: `[[ 1 == 1 ]]` (double equality sign is the same as single one), `[[ 3 < 5 ]]`. For strings everythings stays the same - `[[ -z STRING ]]` checks if STRING is zero-length. In general, you should prefer this syntax over `[  ]` and `test` for it being [more safe and fast](for example, [ $var = abc ] will give you error if $var is empty, so you can often see [ "x$var" = "xval" ])

To inverse the result of the command or comparison running in `if`, use `if ! COMMAND` or `if [[ ! CONDITION ]]` or `if ! [[ CONDITION ]]`

In some cases it is inconvenient to write `if-then-fi` if you run just one-two commands in this branch, so you can use logical operators `&&` *and* and `||` *or*. For example, these two snippets behave the same

```bash
[[ "$var" = "test" ]] && echo "This is test"

if [[ "$var" == "test" ]]; then
    echo "This is test"
fi
```


# Some cool features

## Integer operations

There is another possibility to compare integers and do some operations with them. Check this code with comments:

```bash
# Will print 27
echo $(( 3 * 9 ))

# Compares $i // 7 and 3
# Notice that division is rounded down:
# 27 / 7 is 3 so this will fail
let "i = 27"
if (( i / 7 > 3 ))
then
    echo "$i // 7 is greater than 3"
fi

# Set variable a to 16
(( a = 2 ** 4))
echo "a = $a"
```

## Functions

You can write functions in Bash using `function NAME { CODE; }` or `NAME() { CODE; }`, or combine both. You do not declare variables in parenthesis - you just use `$1` etc. to acces them

```terminal9
sh
```


# Loops

## for loops

General syntax is `for ITEM [in ARRAY]; do COMMANDS; done`, where ARRAY is just a bunch of space-separated words and ITEM is a name for a variable. To iterate through positional arguments, use either `for i in $@` or just `for i`

## c-style for loops

Some people prefer *C-style* loops with syntax `for (( INIT; CONDITION; ACTION )); do COMMANDS; done` that makes it easy to iterate some times. For example, `for (( i = 0; i < 5; i++ )); do echo $i; done` will print numbers from 0 to 4

## while loops

Syntax for *while* loops is `while COMMANDS; do COMMANDS; done`. It runs commands between *do-done* while [final] command between *while-do* returns zero exit status

## infinite loops

To make an infinite loop, the best way is to use `while :; do` syntax. Alternatively you can use `true` instead of semicolon

```terminal15
sh
```


# To sum up

Bash is a very powerful tool for scripting and automation. Its syntax might appear weird to you, but once you master it you can do incredible things with a simple shell script. Although it lacks support for floats and multi-dimensional arrays, using some clever hacks you can overcome this limitations and achieve your goals

```terminal30
sh
```
