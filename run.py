from sys import argv
from subprocess import run, PIPE


def main():
    executable = argv[1]
    input_file = argv[2]
    output_file = argv[3]
    code_output_file = argv[4]
    parser_breaker = argv[5]
    compare = argv[6]

    inputs = open(input_file, "r")
    code_outputs = open(code_output_file, "r+")
    cases = int(inputs.readline())

    for i in range(cases):
        buffer = ""
        line = inputs.readline()

        while line != f"{parser_breaker}\n":
            buffer += line
            line = inputs.readline()

        output = run([executable], input=buffer.encode("utf-8"), stdout=PIPE, stderr=PIPE)
        code_outputs.write(output.stdout.decode("utf-8").replace("\r", ""))

    if compare == "1":
        code_outputs.seek(0)
        outputs = open(output_file, "r")

        code_output_lines = [line.strip() for line in code_outputs.readlines()]
        output_lines = [line.strip() for line in outputs.readlines()]

        print("\nAC" if code_output_lines == output_lines else "\nWA")

    inputs.close()
    code_outputs.close()


if __name__ == "__main__":
    main()
