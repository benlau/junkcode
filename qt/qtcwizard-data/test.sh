#/bin/sh

rm -rf tmp
(cd project1; node ../../qtcwizard/qtcwizard.js generate ../tmp)
diff -urN wizard-project1 tmp

