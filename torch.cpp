#include <QCamera>
#include <QCameraFlashControl>
#include "torch.h"

Torch::Torch(QObject *parent) :
    QObject(parent),
    c(new QCamera)
{
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
        f->setFlashMode(QCameraExposure::FlashTorch);
    }
}

void Torch::stop()
{
    if (f && f->flashMode() != QCameraExposure::FlashOff) {
        f->setFlashMode(QCameraExposure::FlashOff);
    }
}

bool Torch::automated()
{
    return flagAutomated;
}

void Torch::setAutomated(bool value)
{
    if (flagAutomated != value) {
        flagAutomated = value;
        emit automatedChanged();
    }
}

qreal Torch::bound()
{
    return valueBound;
}

void Torch::setBound(qreal value)
{
    if (valueBound != value) {
        valueBound = value;
        emit boundChanged();
    }
}
