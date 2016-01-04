#include <QtCore>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    engine.addImportPath("qrc:///"); // Add QuickAndroid into the import path
    engine.load(QUrl("qrc:///main.qml"));

    return app.exec();
}
