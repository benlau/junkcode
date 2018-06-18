from conans import ConanFile, CMake, tools
import os
import platform
import subprocess

class QtHelper:
    @staticmethod
    def package_id(conanFile):
        version_info = subprocess.check_output(['qmake', '--version'])
        conanFile.info.settings.compiler.qmake_version = version_info

    @staticmethod
    def make(conanFile, args=[]):
        if platform.system() == "Windows":
            conanFile.run("nmake %s" % " ".join(args))
        else:
            conanFile.run("make %s" % " ".join(args))

    @staticmethod
    def qmake(conanFile, args=[]):
        cmd = "qmake %s" % (" ".join(args))
        conanFile.run(cmd)

class TestConan(ConanFile):
    settings = "os", "compiler", "build_type", "arch"
    generators = "qmake"

    def build(self):
        QtHelper.qmake(self, ["%s/test_package.pro" % self.source_folder])
        QtHelper.make(self)

    def imports(self):
        self.copy("*.dll", dst="bin", src="bin")
        self.copy("*.dylib*", dst="bin", src="lib")
        self.copy('*.so*', dst='bin', src='lib')

    def test(self):
        print(os.getcwd())
        self.run(".%stest_package" % os.sep)
