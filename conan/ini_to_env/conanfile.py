from conans import ConanFile, CMake, tools
import os
import configparser

def normalize(section, key):
    return "%s_%s" % (section.upper(), key.upper)

def read_ini(file):
    print("ini:" + file)
    config = configparser.ConfigParser()
    config.read(file)
    ini = {}
    for section in config.sections():
        for key in config[section]:
            ini[normalize(section,key)] = config[section][key]
    return ini

class ini_to_env_package(ConanFile):
    name = "ini_to_env"
    version = "0.0.1"
    url = ""
    license = "APACHE-2.0"
    options = {"source": "ANY"}
    default_options = "source=env.ini"

    def package_info(self): 
        for key in dir(self):
            print(getattr(self,key))
        env = read_ini("%s/%s" % (os.getcwd(), self.options.source))
        for key, value in env.items():
            setattr(self.env_info, key, value)
        
        self.cpp_info.includedirs = []
        self.cpp_info.libdirs = []
        self.cpp_info.bindirs = []
