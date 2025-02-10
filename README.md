<h1 style="text-align: center;">
ASIC Lab 1: Setup and Getting Around the Compute Environment
</h1>
<p align="center">
Prof. Daniel Van Blerkom
</p>
<p align="center">
Department of Electrical and Computer Engineering, Cal Poly Pomona
</p>
<p align="center">
Adapted from UCB EECS150 (Go Bears!)
</p>



## Table of contents
- [Table of contents](#table-of-contents)
- [Overview](#overview)
  - [Submission](#submission)
- [Setup](#setup)
- [Regular Expressions  ](#regular-expressions--)
- [File Permissions ](#file-permissions-)
- [Makefiles ](#makefiles-)
- [Diffing Files ](#diffing-files-)
- [Git ](#git-)
- [Conclusion ](#conclusion-)
  - [Customization](#customization)
- [Lab Deliverables  ](#lab-deliverables--)
  - [Questions](#questions)
    - [Question 1: Setup](#question-1-setup)
    - [Question 2: Common terminal tasks](#question-2-common-terminal-tasks)
    - [Question 3: Fun with Regular Expressions](#question-3-fun-with-regular-expressions)
    - [Question 4: Understanding File Permissions](#question-4-understanding-file-permissions)
    - [Question 5: Makefile Targets](#question-5-makefile-targets)
    - [Question 6: Checking Git Understanding](#question-6-checking-git-understanding)
- [Appendix](#appendix)
  - [Cheatsheets](#cheatsheets)
- [Acknowledgement](#acknowledgement)


<!-- 1. [Overview](#Overview) 
2. [Setup](#paragraph1)
3. [Regular Expressions](#paragraph2)
4. [File Permissions](#paragraph3)
5. [Makefiles](#paragraph4) 
6. [Diffing Files](#paragraph5)
7. [Git](#paragraph6)
8. [Conclusion](#paragraph7)
9. [Lab Deliverables](#paragraph8) -->


## Overview

In course labs you will be introduced to Very-Large Scale Integration (VLSI) design.
The process of VLSI design is different than developing software, designing analog circuits, and even FPGA-based design. Instead of using a single graphical user interface (GUI) or environment (eg. Eclipse, Cadence Virtuoso, or Xilinx Vivado), VLSI design is done using dozens of command line interface tools on a Linux machine.  These tools primarily use text files as their inputs and outputs, and include GUIs mainly for only visualization, rather than design.  Therefore, familiarity with Linux, text manipulation, and scripting is required to successfully complete the labs this semester.

**Objective:** 
The goal of this lab is to introduce some basic techniques needed to use the computer aided design (CAD) tools that are taught in this class. Mastering the topics in this lab will help you save hours of time in later labs and make you a much more efficient chip designer.

- Setup Instructional Account
- Successfully remote into lab machines
- Install XMing
- Building familarity with Git
- Learn Linux Basics

### Submission
1.  Solutions for lab [questions](#paragraph8) will be submitted electronically using **Gradescope**. 

## Setup

The first step for this lab is to setup your environment.  We will be doing this in several steps over the next two labs.

Here's a quick summary of the setup steps:
1) Install PuTTY and Xming on your Windows machine to allow you to connect to the HPC computers.
2) Clone the Github Lab 1 assignment into a directory in your HPC account.
3) Run the Miniconda installation script.

Note, the following assumes you have a Windows machine.  Since Windows is not a serious engineering operating system, we need to 
add some programs to make it usable.  Mac users do not need to install PuTTY or Xming, as equivalent capabilities already exist in the Mac OS.

### PuTTY for Windows

First, you need a way to log in to the HPC computers from your Windows computer.  One program that can be used is called "PuTTY".

PuTTY is a free terminal emulation program for Windows. It supports ssh encryption and X forwarding. You can find the PuTTY download link here: [PuTTY website](https://www.chiark.greenend.org.uk/~sgtatham/putty/)

With an X-window server installed on your PC (see Xming below), you can configure PuTTY so it displays X-windows on your screen. This is called X11 forwarding. This is nice for simple graphics. However, for applications with heavyweight displays, the display can be very slow.  Unfortately, the HPC does not currently support more advanced virtual windowing systems.

Here are the steps for configuring PuTTY with X-windows display:

    When you start PuTTY you should see the session configuration screen.
    In the Host Name box, type hpc.cpp.edu
    Make sure the SSH radio button is selected.
    Type in a name, such as ``hpc'' in the Saved Sessions box
    In the left panel, click the + SSH button to expand the options.
    Then click X11 to display options for X11 forwarding.
    Click the check-box called Enable X11 forwarding. 
        Note that you will need an X-windows server on your PC to make this work. (See XMing below).
    In the left panel, go back to the Sessions screen.
    Click Save to save the session.
    You are then ready to click Open to log in.

Once you have made a successful connection, you must log in with your Bronco name and password. You may open as many PuTTY sessions as you need.

### X server for Windows: Xming

The Xming ``server'' allows external X11 processes to display windows on your Windows PC. More recent Mac's should already have this capability under OS X and Unix (Linux) installations typically have this capability, so they won't need Xming. You need to install it on your Windows PC if you want to use PuTTY to display graphical windows.

Download Xming from SourceForge here: [Xming download](https://sourceforge.net/projects/xming/)

Here are the steps for configuring XMing on your Windows machine

    Start XLaunch.
    Select multiple windows and hit Next.
    Continue hitting Next, keeping the default settings.
    Then hit Finish OR you can save the configuration, so you can 
        restore the session later without going through these steps.
    The Microsoft security software might give you a warning about allowing 
        Xming to accept external connections. You should allow them in this case.
    If you reboot your PC you may need to redo these steps.

Note that if you reboot your computer, you will also need to restart Xming. 

Finally, you can test if your PuTTY and Xming installations work properly by logging into the HPC computer with PuTTY, and run the "display_image" program.  Start this program by typing the following, exactly as shown, on the command line:

    /data02/ECE4203/bin/display_image

You should see a window pop up with four color quadrants.

### More PuTTY and Xming

This website from UCI has a nice walkthrough and a Youtube video for installing PuTTY and Xming.  Just remember to replace the UCI computer name with "hpc.cpp.edu".  Also, the HPC does not have xclock or firefox (or indeed any X11 programs) installed for you to test your installation with; please test with the program described in the section above.
[UCI Putty and Xming instructions](https://laptops.eng.uci.edu/engineering-software/using-linux/how-to-configure-putty-xming-on-your-laptop)


## The "CLI" - Command Line Interface

This class will require you to work with the HPC computer using the command line interface, or CLI.  Here are some resources to come up to speed quickly if you haven't used the command line interface before:

[Linux Journey](https://linuxjourney.com/) - choose the Command Line tutorial.

[Command Line Basics](https://github.com/JulianEducation/CommandLineBasics) - Scroll down and hit the "Open in Google Cloud Shell" button to start.

[The Missing Semester of Your CS Education](https://missing.csail.mit.edu/) - a full set of lectures from MIT on all the stuff you should have been taught but probably weren't.

<!--
### Generate SSH encryption keys for GitHub

Now we need a way to authenticate your HPC account with GitHub, to prove that it is you connecting to GitHub from the HPC computer. GitHub has moved away from using plain-text passwords, and now requires public key cryptography using SSH or GPG (we will use SSH).  First you need to generate the public and private keys, and then copy the public key into your GitHub user settings on the GitHub website.

    Open a PuTTY terminal and log in to your HPC account.
    Run "ssh-keygen -t rsa" and follow the instructions.  You can use an empty passcode.
    You have now created your ssh keys. They live in the directory ~/.ssh.
    Now run "cat .ssh/id_rsa.pub" to display your public key.
    Navigate your web browser to your GitHub account. 
        Click on the little circle in the top right corner to pull out the drop-down menu and select "Settings".
    On the "Settings" page, choose "SSH and GPG keys".  Click the green button "New SSH key".    
    Now copy your public key (that is, select the output from the "cat .ssh/id_rsa.pub" command on the screen, 
       and copy it to the clipboard), and then paste it into the webpage where it says "Key".  
       You can type "HPC" in the "Title" box.
    Confirm by clicking the green "Add SSH key".
-->

### Clone Assignment from Github Classroom

In order to pull the files you will need for this lab from Github into your account on the HPC, you will use the git command 'clone'.  

<!--
(Unfortunately, the HPC computers are blocking direct SSH connections to GitHub, so we have to use SSH over HTTPS.  Nothing is easy.)

When you accepted this GitHub classroom assignment, you were assigned a repository that looked something like:

    https://github.com/dvb-ece-cpp/lab-1-(your github id)

Where "(your github id)" is obviously replaced with your actual GitHub ID name.
To copy, or "clone", all the data from that repository into a directory in your HPC account, type the following at the command prompt, from your home directory, when logged into the HPC:

    git clone ssh://git@ssh.github.com:443/dvb-ece-cpp/lab-1-(your github id).git

Make sure to add the ".git" at the end.  Again, obviously, replace "(your github id)" above with your actual GitHub name.

When git clone finishes, you should have a new directory called "lab-1-(your github id)" which will have the files you need for the rest of this lab.
-->
The lab 1 repository URL is

    https://github.com/dvb-ece-cpp/ece4203_lab1.git

To copy, or "clone", all the data from that repository into a directory in your HPC account, type the following at the command prompt, from your home directory, when logged into the HPC:

    git clone https://github.com/dvb-ece-cpp/ece4203_lab1.git

Make sure to add the ".git" at the end.  

When git clone finishes, you should have a new directory called "ece4203_lab1" which will have the files you need for the rest of this lab.  The files you will work on below will be in the "skel" directory, under "ece4203_lab1".


### Install Miniconda

The last part of the set-up we will do in this lab is to run the shell script inside the directory you just cloned, called "install_miniconda.sh".

Type the following at the command prompt to run this script:

    ~/ece4203_lab1/install_miniconda3.sh
    
This will take a while to finish, and will install the Anaconda software package system so that we can later install the VLSI tools.

## Regular Expressions  <a name="paragraph2"></a>

Regular expressions allow you to perform complex ’Search’ or ’Search and Replace’ operations. 

> **TASK:** Please work through this  [tutorial](http://regexone.com).

Regular expressions can be used from many different programs: Vim, Emacs, `grep`, `sed`, Python, etc. From the command line, use `grep` to search, and `sed` to search and replace. Unfortunately, deciding what characters needs to be escaped can be somewhat confusing. For example, to find all instances of `dcdc_unit_cell_x`, where `x` is a single digit number, using grep:

```shell
grep "unit_cell_[0-9]\{1\}\." force_regs.ucli
```

And you can do the same search in Vim:

```vim
vim force_regs.ucli
/unit_cell_[0-9]\{1\}\.
```

Notice how you need to be careful what characters get escaped (the `[` is not escaped but `{` is). Now
imagine we want to add a leading 0 to all of the single digit numbers. The match string in `sed` could be:

```shell
sed -e 's/\(unit_cell_\)\([0-9]\{1\}\.\)/\10\2/' force_regs.ucli
```

Both `sed`, vim, and `grep` use ”Basic Regular Expressions” by default. For regular expressions heavy with special characters, sometimes it makes more sense to assume most characters except `a-zA-Z0-9` have special meanings (and they get escaped only to match them literally). This is called ”Extended Regular Expressions”, and `?+{}()` no longer need to be escaped. A great resource for learning more is [Wikipedia](http://en.wikipedia.org/wiki/Regular_expression#POSIX_basic_and_extended). 

In Vim, you can do this with `\v`:

```shell
:%s/\v(unit_cell_)([0-9]{1}\.)/\10\2/
```

And in sed, you can use the -r flag:

```shell
sed -r -e 's/(unit_cell_)([0-9]{1}\.)/\10\2/' force_regs.ucli
```

And in grep, you can use the -E flag:

```shell
grep -E "unit_cell_[0-9]{1}\." force_regs.ucli
```

`sed` and grep can be used for many purposes beyond text search and replace. For example, to find all files in the current directory with filenames that contain a specific text string:

```shell
find . | grep ".ucli"
```

Or to delete all lines in a file that contain a string:

```shell
sed -e '/reset/d' force_regs.ucli
```

You may notice that the `sed` commands above do not alter the content of the file and just dumps everything to the terminal.  You can pass `-i` flag to `sed` to edit the file in-place, but this is error-prone because you don't get to check if there were any mistake in your regex before the original content is lost!

So when working with `sed`, using [Bash redirections] to save the output into a separate file is a good idea:

```shell
sed -e 's/\(unit_cell_\)\([0-9]\{1\}\.\)/\10\2/' force_regs.ucli > force_regs.ucli.zeropadded
```

Manpages are helpful resources to learn more about what different flags of the commands do:

```shell
man sed
/-r
```

[Bash redirections]: https://www.gnu.org/software/bash/manual/html_node/Redirections.html

## File Permissions <a name="paragraph3"></a>

A tutorial about file permissions can be found [here](http://www.tutorialspoint.com/unix/unix-file-permission.htm) and answer the [question 4](#Questions).

## Makefiles <a name="paragraph4"></a>

Makefiles are a simple way to string together a bunch of different shell tasks in an intelligent manner. This allows someone to automate tasks and save time when doing repetitive tasks since make targets allow for only files that have changed to need to be updated. The official documentation on make can be found [here](http://www.gnu.org/software/make/manual/make.html).

> **TASK (optional):** Please read through this [tutorial](http://www.cs.colby.edu/maxwell/courses/tutorials/maketutor/) . 

Let’s look at a simple makefile to explain a few things about how they work - this is not meant to be anything more than a very brief overview of what a makefile is and how it works. If you look at the Makefile in the provided folder in your favorite text editor, you can see the following lines:

```shell
output_name = force_regs.random.ucli

$(output_name): force_regs.ucli
    awk 'BEGIN{srand();}{if ($$1 != "") { print $$1,$$2,$$3,int(rand()*2)}}' $< > $@

clean:
    rm -f $(output_name)
```

While this may look like a lot of random characters, let us walk through each part of it to see that it really is not that complicated.

Makefiles are generally composed of rules, which tell Make how to execute a set of commands to build a set of targets from a set of dependencies. A rule typically has this structure:

```shell
targets: dependencies
    commands
```

**It is very important that indentation in Makefiles are tabs, not spaces.**
The two rules in the above Makefile have targets which are clean and output name. Here, output name is the name of a variable within the Makefile, which means that it can be overwritten from the command line. This can be done with the following command:

```shell
make output_name=foo.txt
```

This will result in the output being written to `foo.txt` intstead of `force_regs.random.ucli`.

Generally, a rule will run everytime that its dependencies have been updated more recently than its own targets, so by editing/updating the `force_regs.ucli` file (including via the touch command), you can regenerate the output name target. This is different than a bash script, as you can see in `runalways.sh`, which will always generate `force_regs.random.ucli` regardless of whether `force_regs.ucli` is updated or not.

Inside the output name target, the `awk` command has a bunch of \$ characters. This is because in normal `awk` the variable names are `$1`, `$2`, and then in the makefile you have to escape those variable names to get them to work properly. In Make, the character to do that is `$`.

The other characters after the awk script are also special characters to make. The `$<` is the first dependency of that target, the `>` simply redirects the output of awk, and the `$@` is the name of the target itself. This allows users to create makefiles that can be reusable, since you are operating on a dependency and outputting the result into the name of your own target.

## Diffing Files <a name="paragraph5"></a>

Comparing text files is another useful skill. The tools generally behave as black boxes, so comparing output files to prior output files is an important debugging technique. From the command lines, you can use `diff` to compare files:

```shell
diff force_regs.ucli force_regs.random.ucli
```

You can also compare the contents of directories (the `-q` flag will summarize the results to only show the names of the files that differ, and the `-r` flag will recurse through subdirectories). For Vim users, there is a useful built-in `diff` tool:

```shell
vimdiff force_regs.ucli force_regs.random.ucli
```


## Conclusion <a name="paragraph7"></a>

### Customization

Many of the commands and tools you will use on a daily basis can be customized. This can dramatically improve your productivity. Some tools (e.g. vim and bash) are customized using “dotfiles,” which are hidden files in your home directory (e.g. `.bashrc` and `.vimrc`) that contain a series of commands which set variables, create aliases, or change settings. Try adding the following lines to your `.bashrc` and restart your session or source `~/.bashrc`. Now when you change directories, you no longer need to type `ls` to show the directory contents.

```shell
function cd {
    builtin cd "$@" && ls -F
}
```

The following links are useful for learning how to make some common customizations. You can read these but are not required to turn in anything for this section.
* [Bash aliases and functions](https://www.digitalocean.com/community/tutorials/an-introduction-to-useful-bash-aliases-and-functions)
* [Vim](http://statico.github.io/vim.html)


## Lab Deliverables  <a name="paragraph8"></a>

### Questions

Submit your answers to the lab questions on Gradescope.
#### Question 1: Setup (do this *after* you finish all the Setup tasks)
1. Show the output of `git ls-remote https://github.com/dvb-ece-cpp/ece4203_lab1.git`
2. Show a screen-shot of the display of the program `/data02/ECE4203/bin/display_image`, to show that you have X-windows working.
3. What is your instructional account's disk quota (to the nearest GB)? Do files in your temporary directory count against your quota?
4. What text editor are you using?

#### Question 2: Common terminal tasks

For 1-6 below, submit the command/keystrokes needed to generate the desired result.  For 1-4, try generating only the desired result (no extraneous info). 

1. List the 5 most recently modified items in `/usr/bin`
2. What directory is `git` installed in?
3. Show the hidden files in your lab directory (the `ece4203_lab1` folder in the repo you cloned from GitHub).
4. What version of Vim is installed? Describe how you figured this out.
5. (optional) Make a new directory called `backup` within `/tmp/<your-username>`. Copy all the files in this lab directory to the new `backup` directory. Then delete all the copies in the new directory.
6. Run `ping www.google.com`, suspend it, then kill the process. Then run it in the background, report its PID, then kill the process.
7. Run `top` and report the average CPU load, the highest CPU job, and the amount of memory used (just report the results for this question; you don't need to supply the command/how you got it).

#### Question 3: Fun with Regular Expressions

For each regular expression, provide an answer for **extended** mode (`sed -r`).

You are allowed to use multiple commands to perform each task. Operate on the `force_regs.ucli` file.

1. Change all x surrounding numbers to angle brackets. For example, `regx15xx79x` becomes `reg<15><79>`. Hint: remember to enable global subsitution.
2. *(optional)* Make every number in the file be exactly 3 digits with padded leading zeros (except the last 0 on each line). Eg. line 120/121 should read:

```
force -deposit rocketTestHarness.dut.Raven003Top_withoutPads.TileWrap.
... .io_tilelink_release_data.sync_w002r.rq002_wptr_regx000x.Q 0
force -deposit rocketTestHarness.dut.Raven003Top_withoutPads.TileWrap.
... .io_tilelink_release_data.fifomem.mem_regx015xx098x.Q 0
```
#### Question 4: Understanding File Permissions

For each task below, please provide the commands that result in the correct permissions being set. Make no assumptions about the file's existing permissions. Operate on the `runalways.sh` script.

1. Change the script to be executable by you and no one else.
2. Add permissions for everyone in your group to be able to execute the same script
3. Make the script writable by you ane everyone in your group, but unreadable by others

#### Question 5: Makefile Targets
Look at the Makefile in the "skel" directory.

1. Add a new make rule that will create a file called `foo.txt`.  Make it also run the `output_name` rule.
2. Name at least two ways that you could have the makefile regenerate the `output_name` target after its rule has been run.


## Appendix

### Cheatsheets
That was a lot of commands and a lot of new things to memorize (especially if you have not used them extensively in the past)! As a result, these are some cheatsheets that contains the key commands of some of the productivity tools we went through. *These are all the top results of searching "xx cheatsheet" in google, and are **not** created by the staff.*

* [Linux Commands](https://www.guru99.com/linux-commands-cheat-sheet.html)
* [Vim](https://vim.rtorr.com/)
* [Emacs](https://www.gnu.org/software/emacs/refcards/pdf/refcard.pdf)
* [Regex](https://cheatography.com/davechild/cheat-sheets/regular-expressions/)
* [Make](https://gist.github.com/rueycheng/42e355d1480fd7a33ee81c866c7fdf78)
* [Git](https://education.github.com/git-cheat-sheet-education.pdf)
* [Screen](https://gist.github.com/jctosta/af918e1618682638aa82)
* [Tmux](https://tmuxcheatsheet.com/)

## Acknowledgement
Adapted / re-written for Cal Poly ECE4203 from UCB/EECS150 by Dr. Daniel Van Blerkom.

This lab is the result of the work of many EECS151/251 GSIs over the years including:
Written By:
- Nathan Narevsky (2014, 2017)
- Brian Zimmer (2014)
  
Modified By:
- John Wright (2015,2016)
- Ali Moin (2018)
- Arya Reais-Parsi (2019)
- Cem Yalcin (2019)
- Tan Nguyen (2020)
- Harrison Liew (2020)
- Sean Huang (2021)
- Daniel Grubb, Nayiri Krzysztofowicz, Zhaokai Liu (2021)
- Dima Nikiforov (2022)
- Erik Anderson, Roger Hsiao, Hansung Kim, Richard Yan (2022)
- Chengyi Zhang (2023)
- Rahul Kumar, Rohan Kumar (2023)
- Kevin Anderson, Kevin He (Sp2024)


