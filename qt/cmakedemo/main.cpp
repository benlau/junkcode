#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QuickFlux>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    registerQuickFluxQmlTypes();

    QQmlApplicationEngine engine;
    engine.addImportPath("qrc:///");
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
