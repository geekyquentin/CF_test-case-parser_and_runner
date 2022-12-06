from sys import argv
from urllib.request import urlopen
from html.parser import HTMLParser
import requests


class problem_parser(HTMLParser):
    def __init__(self):
        HTMLParser.__init__(self)
        self.reading = False
        self.input = []
        self.output = []
        self.buffer = ""
        self.atTests = False
        self.level = 0

    def handle_starttag(self, tag, attrs):
        if tag == "div" and ("class", "sample-tests") in attrs:
            self.atTests = True

        if self.atTests:
            self.level += 1

        if tag == "pre" and self.atTests:
            self.reading = True

    def handle_endtag(self, tag):
        if self.atTests:
            self.level -= 1
            if self.level == 0:
                self.atTests = False

        if tag == "pre" and self.atTests:
            self.reading = False
            if len(self.input) == len(self.output):
                self.input.append(self.buffer)
            else:
                self.output.append(self.buffer)
            self.buffer = ""

    def handle_data(self, data):
        if self.reading:
            self.buffer += data.strip() + "\n"


def main():
    url = f"https://codeforces.com/problemset/problem/{argv[1]}/{argv[2]}"
    input_file = argv[3]
    output_file = argv[4]
    parser_breaker = argv[5]

    text = urlopen(url).read()
    parser = problem_parser()
    parser.feed(text.decode("utf-8"))

    with open(input_file, "w") as inputs:
        inputs.write(f"{len(parser.input)}\n")
        for test_case in parser.input:
            inputs.write(test_case)
            inputs.write(f"{parser_breaker}\n")

    with open(output_file, "w") as outputs:
        for test_case in parser.output:
            outputs.write(test_case)


if __name__ == "__main__":
    main()
