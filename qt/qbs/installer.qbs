import qbs
import qbs.Environment

Project {
    Product {
        Group {
            name: "all"
            files: "**"
            qbs.install: true
            qbs.installRoot: "/tmp/qbs"
        }
    }
}