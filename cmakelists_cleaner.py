from sys import argv


def main():
    cmakelist = argv[1]

    with open(cmakelist, 'r+') as f:
        buffer = ""
        line = f.readline()

        while 'add_executable(' not in line:
            buffer += line
            line = f.readline()

        f.seek(0)
        f.write(buffer)
        f.truncate()


if __name__ == '__main__':
    main()
