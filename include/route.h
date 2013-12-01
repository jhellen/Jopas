#include <QObject>
#include <QString>

#ifndef ROUTE_H
#define ROUTE_H

class Route : public QObject
{
    Q_OBJECT
public:
    explicit Route();
    void route(const QString &name, const QString &coord);
    void cycling(const QString &name, const QString &coord);
signals:
    void newRoute(const QString &name, const QString &coord);
    void newCycling(const QString &name, const QString &coord);
};

#endif // ROUTE_H
