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

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    QFuture<QImage> future = readImage(SOURCE);

    AsyncFuture::observe(future).subscribe([]() {
        // Register a callback without argument
    });

    AsyncFuture::observe(future).subscribe([](const QImage& image) {
        // Register a callback to gain the result of observating future
    });

    AsyncFuture::observe(future).subscribe([](QFuture<QImage> input) {
        // Register a callback to gain the observating future
    });

    AsyncFuture::observe(future).subscribe([](const QImage& image) {
        // Read an image, then upload to somewhere
        // Return another future
        return QtConcurrent::run(upload, image);
    }).subscribe([]() {

        // It is called when upload is finished

    }).future(); // This future represents the result of last callback.

    return a.exec();
}
