#include <QCoreApplication>
#include <QtCore>
#include <QProcess>

static QString run(const QString& program, const QStringList& args = QStringList(), int* code = nullptr) {
    qDebug().noquote() << program << args.join(" ");

    QProcess process;
    process.setProcessChannelMode(QProcess::MergedChannels);
    process.start(program, args, QIODevice::ReadWrite);

    process.waitForFinished(-1);

    QString p_stdout = process.readAllStandardOutput();

    int exitCode = process.exitCode();
    qDebug() << "Exit Code" << exitCode;

    if (code) {
        *code = exitCode;
    }

    return p_stdout;
}

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    run("cp" , QStringList{"/usr/local/bin/qpm", QT_INSTALL_BINS});

    return 0;
}
