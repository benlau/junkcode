from conans import ConanFile, tools


class QuickpromiseConan(ConanFile):
    name = "QuickPromise"
    version = "1.0.8"
    license = "Apache 2.0"
    url = "https://github.com/benlau/quickpromise"
    description = "Promise for QML/JS"
    settings = "os", "compiler", "build_type", "arch"
    options = {"shared": [True, False]}
    default_options = "shared=False"
    generators = "cmake"

    def source(self):
        self.run("git clone https://github.com/benlau/quickpromise.git")
        self.run("cd quickpromise && git checkout -b staticlib origin/staticlib")

    def build(self):
        self.run("qmake %s/quickpromise/quickpromise.pro" % self.source_folder)
        self.run("make")

    def package(self):
        self.copy("*.a", dst="lib", keep_path=False)
        self.copy("*", src="quickpromise/qml/QuickPromise", dst="qml/QuickPromise", keep_path=True)

    def package_info(self):
        self.cpp_info.libs = ["quickpromise"]
