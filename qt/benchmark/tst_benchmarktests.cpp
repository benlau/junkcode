#include <QString>
#include <QtTest>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

void wait(int msec = 1000)
{

    QEventLoop loop;
    QTimer timer;
    QObject::connect(&timer,SIGNAL(timeout()),
            &loop,SLOT(quit()));
    timer.start(msec);
    loop.exec();
}

class BenchmarkTests : public QObject
{
    Q_OBJECT

public:
    BenchmarkTests();

private Q_SLOTS:
    void initTestCase();
    void cleanupTestCase();
    void pagePushing();
};

BenchmarkTests::BenchmarkTests()
{
}

void BenchmarkTests::initTestCase()
{
}

void BenchmarkTests::cleanupTestCase()
{
}

void BenchmarkTests::pagePushing()
{
    QQmlApplicationEngine engine;
    engine.addImportPath("qrc:///");

    engine.load(QUrl::fromLocalFile(QString(SRCDIR) + "/pageLoading/main.qml"));


    wait(6000);

}

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setAttribute(Qt::AA_Use96Dpi, true);
    BenchmarkTests tc;
    return QTest::qExec(&tc, argc, argv);
}
#include "tst_benchmarktests.moc"
