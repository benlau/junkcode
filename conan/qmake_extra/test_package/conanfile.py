from conans import ConanFile, CMake, tools
import os

class QuickpromiseTestConan(ConanFile):
    settings = "os", "compiler", "build_type", "arch"
    generators = ["qmake", "qmake_extra"]
    requires = "QmakeExtra/0.1@demo/testing", "QuickPromise/1.0.8@demo/testing"

    def build(self):
        print(self.source_folder)
        self.run("qmake %s/example.pro" % self.source_folder )
        self.run("make")

    def imports(self):
        self.copy("*.dll", dst="bin", src="bin")
        self.copy("*.dylib*", dst="bin", src="lib")
        self.copy('*.so*', dst='bin', src='lib')

    def test(self):
        print(os.getcwd())
        self.run(".%sexample" % os.sep)
