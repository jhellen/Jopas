Name:       harbour-meegopas
Summary:    Journey planner for Helsinki metropolitan area
Version:    1.5.1
Release:    1
Group:      Applications
License:    GPLv3
URL:        https://github.com/foolab/Meegopas
Source0:    %{name}-%{version}.tar.bz2
BuildRequires:  pkgconfig(Qt5Qml)
BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  pkgconfig(Qt5DBus)
BuildRequires:  pkgconfig(qdeclarative5-boostable)
BuildRequires:  desktop-file-utils
Requires:  qt5-plugin-geoservices-nokia
Requires:  sailfishsilica-qt5
Requires:  mapplauncherd-booster-silica-qt5
Requires:  qt5-qtdeclarative-import-xmllistmodel
Requires:  qt5-qtdeclarative-import-positioning

# >> macros
%{!?qtc_qmake5:%define qtc_qmake5 qmake}
%{!?qtc_qmake:%define qtc_qmake5 qmake}
%{!?qtc_make:%define qtc_make make}
%{?qtc_builddir:%define _builddir %qtc_builddir}
# << macros

%description
Journey planner for Helsinki metropolitan area

%prep
%setup -q

%build
%qmake5

make %{?jobs:-j%jobs}

%install
rm -rf %{buildroot}
mkdir -p %{buildroot}/usr/share/harbour-meegopas

%qmake5_install

%files
%defattr(-,root,root,-)
%{_bindir}/harbour-meegopas
%{_datadir}/applications/harbour-meegopas.desktop
%{_datadir}/icons/hicolor/86x86/apps/*
%{_datadir}/dbus-1/services/*
%{_datadir}/harbour-meegopas/*
