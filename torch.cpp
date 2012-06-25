#include <QCamera>
#include <QCameraFlashControl>
#include "torch.h"

Torch::Torch(QObject *parent) :
    QObject(parent)
{
    c = new QCamera;
    c->setCaptureMode(QCamera::CaptureVideo);
    f = qobject_cast<QCameraFlashControl*>(c->service()->requestControl(QCameraFlashControl_iid));
    if (!f) qCritical() << "Can't request camera flash control";
    c->start();
}

Torch::~Torch()
{
    c->stop();
    c->service()->releaseControl(f);
    delete c;
}

void Torch::start()
{
    if (f && f->flashMode() != QCameraExposure::FlashTorch) {
        qDebug() << "Start torch";
        f->setFlashMode(QCameraExposure::FlashTorch);
    }
}

void Torch::stop()
{
    if (f && f->flashMode() != QCameraExposure::FlashOff) {
        qDebug() << "Stop torch";
        f->setFlashMode(QCameraExposure::FlashOff);
    }
}

bool Torch::automated()
{
    return autoTorch;
}

void Torch::setAutomated(bool value)
{
    autoTorch = value;
    emit automatedChanged();
}

qreal Torch::bound()
{
    return boundTorch;
}

void Torch::setBound(qreal value)
{
    boundTorch = value;
    emit boundChanged();
}
