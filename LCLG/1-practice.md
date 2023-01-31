---

author: Andrey
title: LCLG - Practical task for "Bourne Again Shell"
date: Jan 27, 2023
styles:
  style: gruvbox-dark
  link:
    bg: default
    fg: '#c40'

---

# Linux Command Line Practical Task - Bourne Again Shell

On the last lecture we have learned about the Bourne Again Shell (bash) and its basic features. Now it is time to put this knowledge into practice. You are given several tasks to complete - choose at least one you like the most and make a Bash script for it. Do not attempt to use external commands that were not covered in presentations 0 and 1. But try to implement some additional feature not covered in the task you choose

# Task 1 - Calculator

Write a Bash script that will:

1. Read *two numbers* and an *operator* from the command line
1. Perform the operation and print the result
1. Continue from step 1 optionally using the result as the first number
1. Make an algorithm to handle exit conditions (e.g. when the user enters `q` or `quit`)
1. Make sure the script can handle basic errors such as division by zero

## Sample output

```bash
$ ./calculator.sh
> 1 + 2
3
> * 3
9
> / 2
4
> quit
$
```


# Task 2 - File Manager

Implement a simple file manager that will:

1. Print the current directory contents
1. Read file or directory number *N* from the command line
  1. If the entry number *N* is a directory, change the current directory to it and go to step 1
  1. If the entry number *N* is a file, print its contents and go to step 1
1. Make an algorithm to handle exit conditions (e.g. when the user enters `q` or `quit`)
1. Make sure the script can handle basic errors such as entering a non-existent file or directory number

## Sample output

```bash
$ ./file_manager.sh
./ ../ file1 file2
> 3
[content of file2 (or file1 if you start from 0)]
./ ../ file1 file2
> 2
./ ../ test_dir/
> 3
./ ../ file1 file2
> q
$
```


# Task 3 - Number Guessing Game

Write a simple number guessing game. It should work as follows:

1. Generate a random number between 1 and 100
1. Read a number from the command line
  1. If the number is correct, print a congratulation message and exit
  1. If the number is too small, print a message *Less* and go to step 2
  1. If the number is too big, print a message *More* and go to step 2
1. Make an algorithm to handle exit conditions (e.g. when the user enters `q` or `quit`)
1. Make sure the script can handle basic errors such as number outside the range

## Sample output

```bash
$ ./guessing_game.sh
> 50
Less
> 25
More
> 37
Less
> 34
Congrats! The number is 34
$
```

# Solutions

Take a look at them on GitHub. You can download and run this script to see how it works. You can also use it as a reference for your own solution if you get stuck

https://github.com/LinuxHackersClub/presentations/blob/master/LCLG/solutions/1-practice.sh
