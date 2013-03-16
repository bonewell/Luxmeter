#include "memory.h"

Memory::Memory(QObject *parent) :
    QObject(parent)
{
}

Memory::typeUnits Memory::type()
{
    return valueType;
}

qreal Memory::min()
{
    return value(valueMinimum);
}

qreal Memory::max()
{
    return value(valueMaximum);
}

qreal Memory::cur()
{
    return value(valueCurrent);
}

bool Memory::hold()
{
    return flagHold;
}

qreal Memory::visible()
{
    return value(valueVisible);
}

void Memory::setType(Memory::typeUnits value)
{
    if (valueType != value) {
        valueType = value;
        emit typeChanged();
        emit minChanged();
        emit maxChanged();
        emit curChanged();
    }
}

void Memory::setMin(qreal value)
{
    if (valueMinimum > value || valueMinimum < 0) {
        valueMinimum = value;
        emit minChanged();
    }
}

void Memory::setMax(qreal value)
{
    if (valueMaximum < value) {
        valueMaximum = value;
        emit maxChanged();
    }
}

void Memory::setVisible(qreal value)
{
    if (valueVisible != value) {
        valueVisible = value;
        emit visibleChanged();
    }
}

void Memory::setCur(qreal value)
{
    if (valueCurrent != value) {
        valueCurrent = value;
        emit curChanged();
        setMin(valueCurrent);
        setMax(valueCurrent);
    }
}

void Memory::setHold(bool value)
{
    if (flagHold != value) {
        flagHold = value;
        emit holdChanged();
        setVisible(valueCurrent);
        emit curChanged();
    }
}

void Memory::reset()
{
    setType(LX);
    valueMinimum = valueCurrent;
    emit minChanged();
    valueMaximum = valueCurrent;
    emit maxChanged();
    setHold(false);
}

qreal Memory::value(qreal value)
{
    const qreal footcandle = 10.764; //One footcandle ≈ 10.764 lux.
    switch (valueType) {
    case LX: return value;
    case FC: return qRound(value/footcandle);
    default: return value;
    }
}
