
#include <QApplication>
#include <QStringList>
#include <QtQuickTest/quicktest.h>
#include <QtCore>
#include "qtsingleapplication.h"

int main(int argc, char *argv[])
{
    QtSingleApplication a(argc, argv);
    Q_UNUSED(a);
    return 0;
}
