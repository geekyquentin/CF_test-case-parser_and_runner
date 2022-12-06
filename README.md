# Codeforces test cases parser and runner

---

## Requirements

### VSCode

[Install VSCode](https://code.visualstudio.com/download)

### CMake

[Install Chocolatey](https://docs.chocolatey.org/en-us/choco/setup)

[Install CMake](https://community.chocolatey.org/packages/cmake)

Add path to Environment Variables

-   Right-click on **This PC**, go to **Properties > Advanced system settings > Environment Variables**
-   Click on the **Path** column in **System variables** and click **Edit**
-   Click **New**, paste `C:\Program Files\CMake\bin`, and click **OK**
-   Finally, close and reopen VSCode

### Compiler: **MinGW**

In VSCode, go to **File > Preferences > Settings**

Search for **C_Cpp › Default: Compiler Path** and set it to `C:/MinGW/bin/g++.exe`

---

## Overview

This repository contains the following files:

-   **[.clang-format](https://github.com/geekyquentin/cf_test-case-parser_and_runner/blob/main/.clang-format)**: C++ code formatter that provides an option that lets the user define their custom code style options
-   **[CMakeLists.txt](https://github.com/geekyquentin/cf_test-case-parser_and_runner/blob/main/CMakeLists.txt)**: directives and instructions describing the project's source files and targets.
-   **[getTestCases.py](https://github.com/geekyquentin/cf_test-case-parser_and_runner/blob/main/getTestCases.py)**: takes **contest number** and **problem letter** as input to access the specific problem with the URL (for example, https://codeforces.com/problemset/problem/1681/A) to parse all the test cases with its inputs and outputs into their respective text files
-   **[runner.py](https://github.com/geekyquentin/cf_test-case-parser_and_runner/blob/main/runner.py)**: executes the code with the input generated by [getTestCases.py](https://github.com/geekyquentin/cf_test-case-parser_and_runner/blob/main/getTestCases.py) for all test cases
-   **[make.bat](https://github.com/geekyquentin/cf_test-case-parser_and_runner/blob/main/make.bat)**: contains lines with commands executing in sequence. Performs multiple tasks as per the user's request, all of which are discussed in the next section

---

## How to use

Clone this repository into a local folder: `git clone https://github.com/geekyquentin/cf_test-case-parser_and_runner`

Open a problem in the [codeforces site](codeforces.com). From its URL, get the **contest number** and the **problem letter** (for example, in https://codeforces.com/problemset/problem/1681/A, **contest_number** is **1681** and **problem_letter** is **A**).

### Get test cases

To get the input and output for every test case, run

`./make.bat contest_number problem_letter gtc`

**Function:** [getTestCases.py](https://github.com/geekyquentin/cf_test-case-parser_and_runner/blob/main/getTestCases.py) accesses the page and parses the test cases. [make.bat](https://github.com/geekyquentin/cf_test-case-parser_and_runner/blob/main/make.bat) creates `problem_letter.cpp` in the directory `contest_number`, adds an executable of this program to [CMakeLists.txt](https://github.com/geekyquentin/cf_test-case-parser_and_runner/blob/main/CMakeLists.txt), and opens it in VSCode.

### Run the program

To run the program on every test case, run

`./make.bat contest_number problem_letter run`

**Function:** [make.bat](https://github.com/geekyquentin/cf_test-case-parser_and_runner/blob/main/make.bat) generates the CMake build directory if it doesn't exist and builds all the executables that are added to the [CMakeLists.txt](https://github.com/geekyquentin/cf_test-case-parser_and_runner/blob/main/CMakeLists.txt). [runner.py](https://github.com/geekyquentin/cf_test-case-parser_and_runner/blob/main/runner.py) runs the executable in CMake build directory for every test case and gives the output.

### Clean files

To perform a clean-up, run

`./make.bat clean`

**Function:** Deletes input and output files generated while parsing test cases and removes the CMake build directory
