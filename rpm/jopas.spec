Name:       harbour-jopas
Summary:    Journey planner for Helsinki & Tampere area
Version:    0.1
Release:    1
Group:      Applications
License:    GPLv3
URL:        https://github.com/rasjani/Jopas
Source0:    %{name}-%{version}.tar.bz2
BuildRequires:  pkgconfig(Qt5Qml)
BuildRequires:  pkgconfig(Qt5Quick)
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
Journey planner for Helsinki & Tampere area

%prep
%setup -q

%build
%qtc_qmake5

make %{?jobs:-j%jobs}

%install
rm -rf %{buildroot}
mkdir -p %{buildroot}/usr/share/harbour-jopas

%qmake5_install

%files
%defattr(-,root,root,-)
%{_bindir}/harbour-jopas
%{_datadir}/applications/harbour-jopas.desktop
%{_datadir}/icons/hicolor/86x86/apps/*
%{_datadir}/harbour-jopas/*
