#include <QCoreApplication>
#include <QtConcurrent>
#include <asyncfuture.h>
#include <QImage>

#define SOURCE ""

QFuture<QImage> readImage(const QString &source) {
    return QtConcurrent::run([=]() {
        QImage image;
        image.load(source);
        return image;
    });
}

void upload(const QImage &image) {

}

//void case2() {
//    QFuture<void> future;

//    AsyncFuture::observe(future).subscribe([](int value) {
//    });
//}

//void case3() {

//    auto defer = AsyncFuture::deferred<void>();

//    auto worker = [=]() {
//        defer.complete();
//    };

//}

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    QFuture<QImage> future = readImage(SOURCE);

    AsyncFuture::observe(future).subscribe([](int value) {
        // processing...
    });


    return a.exec();
}
