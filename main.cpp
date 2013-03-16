#include <QtGui/QApplication>
#include <QtDeclarative>
#include "qmlapplicationviewer.h"
#include "torch.h"
#include "memory.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    QmlApplicationViewer viewer;
    qmlRegisterType<Torch>("Torch", 1, 2, "Torch");
    qmlRegisterType<Memory>("Memory", 1, 1, "Memory");
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockPortrait);
    viewer.setMainQmlFile(QLatin1String("qml/luxmeter/main.qml"));
    viewer.showExpanded();

    return app->exec();
}
