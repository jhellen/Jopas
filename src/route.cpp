#include <QDebug>
#include "route.h"

Route::Route()
{
}

void Route::route(const QString &name, const QString &coord)
{
    qDebug() << name << " " << coord;
    emit newRoute(name, coord);
}

void Route::cycling(const QString &name, const QString &coord)
{
    qDebug() << "cycling" << name << " " << coord;
    emit newCycling(name, coord);
}
