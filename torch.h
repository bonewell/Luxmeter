#ifndef TORCH_H
#define TORCH_H

#include <QObject>

class QCamera;
class QCameraFlashControl;

class Torch : public QObject
{
    Q_OBJECT
public:
    explicit Torch(QObject *parent = 0);
    ~Torch();
    
    Q_PROPERTY(bool automated READ automated WRITE setAutomated NOTIFY automatedChanged)
    Q_PROPERTY(qreal bound READ bound WRITE setBound NOTIFY boundChanged)

    Q_INVOKABLE bool automated();
    Q_INVOKABLE qreal bound();

signals:
    void automatedChanged();
    void boundChanged();

public slots:
    void start();
    void stop();
    void setAutomated(bool);
    void setBound(qreal);

private:
    QCamera *c;
    QCameraFlashControl *f;
    bool flagAutomated;
    qreal valueBound;
};

#endif // TORCH_H
