#! /usr/bin/env python3

import os.path
import shutil
import subprocess
import unittest

EXPECTED_PROXY_VERSION = "0.4.0-dev"


class CompletionProxyScriptTests(unittest.TestCase):
    def __init__(self, methodName):
        super().__init__(methodName)
        self.maxDiff = None

    def setUp(self):
        self.test_output_root_directory = "/tmp/batect-zsh-completion-tests"

        if os.path.exists(self.test_output_root_directory):
            shutil.rmtree(self.test_output_root_directory)

        os.makedirs(self.test_output_root_directory)

    def test_directory_with_no_wrapper(self):
        result = self.run_completions_for("./bat", self.directory_for_test_case("no-wrapper"))
        self.assertEqual(result, ["./bat-script\tExecutable, 20B"])

    def test_non_existent_wrapper(self):
        result = self.run_completions_for("./batect -", self.directory_for_test_case("no-wrapper"))
        self.assertEqual(result, [])

    def test_directory_with_wrapper(self):
        directory_for_test_case = self.directory_for_test_case("version-1")
        result = self.run_completions_for("./bat", directory_for_test_case)

        file_size = os.path.getsize(os.path.join(directory_for_test_case, "batect"))
        self.assertEqual(result, ["./batect\tExecutable, {}B".format(file_size)])

    def test_complete_arguments(self):
        result = self.run_completions_for("./batect --", self.directory_for_test_case("version-1"))
        self.assertEqual(result, ["--do-thing", "--other-thing", "--third-thing", "--wrapper-script-path"])

        version_script_invocation_details = self.get_version_script_invocation_details()

        self.assertEqual(version_script_invocation_details["proxy_version"], EXPECTED_PROXY_VERSION)
        self.assertEqual(version_script_invocation_details["register_as"], "batect-1.0.0")
        self.assertEqual(version_script_invocation_details["wrapper_quiet_download"], "true")
        self.assertEqual(version_script_invocation_details["arguments"], "--generate-completion-script=fish")

    def test_passing_wrapper_script_path(self):
        result = self.run_completions_for("./batect --wrapper-script-path=", self.directory_for_test_case("version-1"))
        self.assertEqual(result, ["--wrapper-script-path=path-./batect-path"])

    def test_complete_filtering_arguments(self):
        result = self.run_completions_for("./batect --do", self.directory_for_test_case("version-1"))
        self.assertEqual(result, ["--do-thing"])

    def test_complete_subsequent_arguments(self):
        result = self.run_completions_for("./batect --do-thing --third", self.directory_for_test_case("version-1"))
        self.assertEqual(result, ["--third-thing"])

    def test_multiple_invocations_same_version(self):
        result = self.run_two_completions("./batect --", "./batect --", self.directory_for_test_case("version-1"))
        self.assertEqual(result["first"], ["--do-thing", "--other-thing", "--third-thing", "--wrapper-script-path"])
        self.assertEqual(result["second"], ["--do-thing", "--other-thing", "--third-thing", "--wrapper-script-path"])
        self.assert_single_version_script_invocation()

    def test_multiple_invocations_different_version(self):
        result = self.run_two_completions(
            "./batect --",
            "./batect --",
            self.directory_for_test_case("version-1"),
            self.directory_for_test_case("version-2"),
        )

        self.assertEqual(result["first"], ["--do-thing", "--other-thing", "--third-thing", "--wrapper-script-path"])
        self.assertEqual(result["second"], ["--other-second-thing", "--second-thing"])

    def test_not_in_current_directory(self):
        result = self.run_completions_for("../version-2/batect --", self.directory_for_test_case("version-1"))
        self.assertEqual(result, ["--other-second-thing", "--second-thing"])

    def test_incompatible_version(self):
        result = self.run_completions_for("./batect dum", self.directory_for_test_case("incompatible-version"))
        self.assertEqual(result, ["dummy-file"])

    def test_no_version_in_wrapper(self):
        result = self.run_completions_for("./batect --", self.directory_for_test_case("gradle-generated-start-script"))
        self.assertEqual(result, ["--do-thing", "--other-thing", "--third-thing"])

    def run_completions_for(self, input, working_directory):
        stdout = self.run_zsh_command('complete -C"{}"'.format(input), working_directory)

        return sorted(stdout.splitlines())

    def run_two_completions(self, first_input, second_input, first_working_directory, second_working_directory=None):
        if second_working_directory is None:
            second_working_directory = first_working_directory

        divider = "---DIVIDER---"
        command = 'cd "{}" && complete -C"{}" && echo "{}" && cd "{}" && complete -C"{}"'.format(
            first_working_directory,
            first_input,
            divider,
            second_working_directory,
            second_input,
        )

        stdout = self.run_zsh_command(command, first_working_directory).splitlines()

        divider_line = stdout.index(divider)
        first_output = stdout[0:divider_line]
        second_output = stdout[divider_line + 1:]

        return {"first": sorted(first_output), "second": sorted(second_output)}

    def run_zsh_command(self, command, working_directory):
        command_line = ["zsh", "-c", command]

        result = subprocess.run(
            command_line,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            cwd=working_directory,
            text=True,
            encoding='utf-8'
        )

        self.assertEqual(result.stderr, '')
        self.assertEqual(result.returncode, 0)

        return result.stdout

    def directory_for_test_case(self, test_case):
        tests_dir = os.path.dirname(os.path.realpath(__file__))

        return os.path.abspath(os.path.join(tests_dir, "test-cases", test_case))

    def get_version_script_invocation_details(self):
        path = self.assert_single_version_script_invocation()

        with open(path, 'r') as f:
            content = f.readlines()

            return {
                "proxy_version": content[0].split("BATECT_COMPLETION_PROXY_VERSION is ")[1].strip(),
                "register_as": content[1].split("BATECT_COMPLETION_PROXY_REGISTER_AS is ")[1].strip(),
                "wrapper_quiet_download": content[2].split("BATECT_QUIET_DOWNLOAD is ")[1].strip(),
                "arguments": content[3].split("Arguments were: ")[1].strip()
            }

    def assert_single_version_script_invocation(self):
        files = os.listdir(self.test_output_root_directory)
        self.assertEqual(len(files), 1, "Expected exactly one invocation of version-specific script")

        return os.path.join(self.test_output_root_directory, files[0])


if __name__ == '__main__':
    unittest.main()
