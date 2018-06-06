from conans import ConanFile, tools
import os
import platform
import subprocess

class QtSingleApplicationConan(ConanFile):
    name = "qtsingleapplication"
    version = "0.0.1"
    license = "Apache 2.0"
    url = "https://github.com/benlau/quickpromise"
    description = "Promise for QML/JS"
    settings = "os", "compiler", "build_type", "arch"

    def package_id(self):
        version_info = subprocess.check_output(['qmake', '--version'])
        self.info.settings.compiler.qmake_version = version_info

    def make(self, args=[]):
        if platform.system() == "Windows":
            self.run("nmake %s" % " ".join(args))
        else:
            self.run("make %s" % " ".join(args))

    def qmake(self, args=[]):
        cmd = "qmake %s" % (" ".join(args))
        self.run(cmd)
    
    def source(self):
        self.run("git clone --depth 1 https://github.com/benlau/qt-solutions.git")

    def build(self):
        self.qmake(["%s/qt-solutions/qtsingleapplication/buildlib/buildlib.pro" % self.source_folder])
        self.make()
        
    def package(self):
        self.copy("qt-solutions/qtsingleapplication/src/*.h", dst="include", keep_path=False)
        self.copy("*.a", dst="lib", keep_path=False)
        self.copy("*.dylib", dst="lib", keep_path=False)
        self.copy("*.dll", dst="lib", keep_path=False)

    def package_info(self):
        self.cpp_info.libs = ["QtSolutions_SingleApplication-head"]
        self.cpp_info.libdirs = ["lib"]
