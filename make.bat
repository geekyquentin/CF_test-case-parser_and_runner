@echo off

if %1==clean (goto clean)

set contest_number=%1
set problem_letter=%2

set input_file=input.txt
set output_file=output.txt
set code_output_file=code_output.txt
set template_file=template.cpp
set parser_breaker=PARSER_BREAKER

set problem_path=%contest_number%\%problem_letter%.cpp
set unique_build=%contest_number%%problem_letter%
set build_path=build\%unique_build%.exe

if %3==gtc (goto gtc)
if %3==run (goto run)
echo Usage: ./make.bat contest_number problem_letter ^[gtc^|run^|clean^] ra unga bunga
goto end

:gtc
python getTestCases.py %contest_number% %problem_letter% %input_file% %output_file% %parser_breaker%
if not exist %contest_number% mkdir %contest_number%
if not exist %problem_path% (
    copy %template_file% %problem_path% >NUL
    echo add_executable^(%unique_build% %contest_number%/%problem_letter%.cpp^)>>.\CMakeLists.txt
)
code %problem_path%
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
python runner.py %build_path% %input_file% %output_file% %code_output_file% %parser_breaker%
goto end

:clean
del input.txt *output.txt
rd /s build
goto end

:end