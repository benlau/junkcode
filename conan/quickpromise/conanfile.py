from conans import ConanFile, tools
import os

class QuickpromiseConan(ConanFile):
    name = "quickpromise"
    version = "1.0.8"
    license = "Apache 2.0"
    url = "https://github.com/benlau/quickpromise"
    description = "Promise for QML/JS"
    settings = "os", "compiler", "build_type", "arch"
    options = {"shared": [True, False]}
    default_options = "shared=False"
    generators = "cmake"
    exports = "qconanextra.json"

    def source(self):
        self.run("git clone https://github.com/benlau/quickpromise.git")
        self.run("cd quickpromise")

    def build(self):
        args = []
        if self.options.shared:
            args.append("CONFIG+=no_staticlib");
            
        qmake = "qmake %s/quickpromise/lib/lib.pro %s" % (self.source_folder, " ".join(args));    
        self.run(qmake)
        self.run("make")

    def package(self):
        self.copy("*.a", dst="lib", keep_path=False)
        self.copy("*.dylib", dst="lib", keep_path=False)
        self.copy("*.dll", dst="lib", keep_path=False)
        self.copy("*", src="quickpromise/qml/QuickPromise", dst="qml/QuickPromise", keep_path=True)
        export_path = os.path.dirname(os.path.realpath(__file__))
        self.copy("qconanextra.json", src=export_path)

    def package_info(self):
        self.cpp_info.libs = ["quickpromise"]
