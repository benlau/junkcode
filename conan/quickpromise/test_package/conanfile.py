from conans import ConanFile, CMake, tools
import os

class QuickpromiseTestConan(ConanFile):
    settings = "os", "compiler", "build_type", "arch"
    generators = "qmake"

    def build(self):
        print os.getcwd()
        print self.source_folder
        self.run("qmake %s/example.pro" % self.source_folder )
        self.run("make")

    def imports(self):
        self.copy("*.dll", dst="bin", src="bin")
        self.copy("*.dylib*", dst="bin", src="lib")
        self.copy('*.so*', dst='bin', src='lib')

    def test(self):
        print os.getcwd()
        self.run(".%sexample" % os.sep)
