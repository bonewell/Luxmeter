#ifndef MEMORY_H
#define MEMORY_H

#include <QObject>

class Memory : public QObject
{
    Q_OBJECT
    Q_ENUMS(typeUnits)

public:
    explicit Memory(QObject *parent = 0);

    enum typeUnits { LX, FC };

    Q_PROPERTY(typeUnits type READ type WRITE setType NOTIFY typeChanged)
    Q_PROPERTY(qreal min READ min NOTIFY minChanged)
    Q_PROPERTY(qreal max READ max NOTIFY maxChanged)
    Q_PROPERTY(qreal cur READ cur WRITE setCur NOTIFY curChanged)
    Q_PROPERTY(bool hold READ hold WRITE setHold NOTIFY holdChanged)
    Q_PROPERTY(qreal visible READ visible NOTIFY visibleChanged)

    Q_INVOKABLE typeUnits type();
    Q_INVOKABLE qreal min();
    Q_INVOKABLE qreal max();
    Q_INVOKABLE qreal cur();
    Q_INVOKABLE bool hold();
    Q_INVOKABLE qreal visible();

signals:
    void typeChanged();
    void minChanged();
    void maxChanged();
    void curChanged();
    void holdChanged();
    void visibleChanged();

public slots:
    void setType(typeUnits);
    void setCur(qreal);
    void setHold(bool);
    void reset();

private:
    typeUnits valueType;
    qreal valueMinimum;
    qreal valueMaximum;
    qreal valueCurrent;
    bool flagHold;
    qreal valueVisible;

    inline qreal value(qreal);
    inline void setMin(qreal);
    inline void setMax(qreal);
    inline void setVisible(qreal);
};

#endif // MEMORY_H
