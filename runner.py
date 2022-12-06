from sys import argv
from subprocess import run, PIPE


def main():
    executable = argv[1]
    input_file = argv[2]
    output_file = argv[3]
    code_output_file = argv[4]
    parser_breaker = argv[5]

    inputs = open(input_file, 'r')
    outputs = open(code_output_file, 'a')
    cases = int(inputs.readline())

    for i in range(cases):
        buffer = ""
        line = inputs.readline()

        while line != f"{parser_breaker}\n":
            buffer += line
            line = inputs.readline()

        output = run([executable], input=buffer.encode('utf-8'), stdout=PIPE, stderr=PIPE)
        outputs.write(output.stdout.decode('utf-8').replace('\r', ''))

    inputs.close()
    outputs.close()


if __name__ == "__main__":
    main()
