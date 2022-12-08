@echo off

if %1==clean (goto clean)
if %1==setup (goto setup)

set contest_number=%1
set problem_letter=%2

set url=https://codeforces.com/problemset/problem/%contest_number%/%problem_letter%
set input_file=input.txt
set output_file=output.txt
set code_output_file=code_output.txt
set todo_list=todo.txt
set template_file=template.cpp
set parser_breaker=PARSER_BREAKER

set problem_file=%contest_number%\%problem_letter%.cpp
set unique_build=%contest_number%%problem_letter%
set executable=build\%unique_build%.exe

if %3==gtc (goto gtc)
if %3==todo (goto todo)
if %3==debug (
    set /a compare=0
    goto run
)
if %3==run (
    set /a compare=1
    goto run
)
echo Usage: ./make.bat contest_number problem_letter ^[gtc^|run^|debug^|todo^]
goto end

:gtc
break>%code_output_file%
python getTestCases.py %url% %input_file% %output_file% %parser_breaker%
if not exist %contest_number% mkdir %contest_number%
if not exist %problem_file% (
    copy %template_file% %problem_file%
    echo add_executable^(%unique_build% %contest_number%/%problem_letter%.cpp^)>>.\CMakeLists.txt
)
code %problem_file%
goto end

:run
"C:/Program Files/CMake/bin/cmake.exe" ^
--no-warn-unused-cli ^
-DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=TRUE ^
-DCMAKE_BUILD_TYPE:STRING=Debug ^
-DCMAKE_C_COMPILER:FILEPATH=C:\MinGW\bin\gcc.exe ^
-DCMAKE_CXX_COMPILER:FILEPATH=C:\MinGW\bin\g++.exe ^
-S%CD% -B%CD%\build -G "MinGW Makefiles"
cmake --build build
break>%code_output_file%
python runner.py %executable% %input_file% %output_file% %code_output_file% %parser_breaker%
if %compare%==1 (goto compare)
goto end

:compare
fc %output_file% %code_output_file% >nul
if errorlevel 0 (echo AC)
if errorlevel 1 (echo WA)
if errorlevel 2 (echo Cannot ^find atleast one of the files)
goto end

:todo
findstr /c:"%url%" %todo_list% >nul
if errorlevel 1 (
    echo %url%>>%todo_list%
    echo Added to todo list
) else (
    echo Already in todo list
)
goto end

:setup
python cmakelists_cleaner.py CMakeLists.txt
goto end

:clean
del input.txt *output.txt
rd /s build
goto end

:end