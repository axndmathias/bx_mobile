# Architecture & Design Document (ADD) — BXMobile

**Projekt:** BXMobile
**Autor:** Alexandre Evangelista Mathias
**Datum:** August 2026
**Version:** 0.1.1

## 1. Architekturübersicht

**BXMobile** verwendet einen Ansatz auf Basis von **Clean Architecture + MVVM**, organisiert nach dem Muster **Feature-First (Modular Monolith)**.

Die Anwendung fungiert als **Shell App (Container App)**, in der Geschäfts- und Funktionsmodule der BMX-Familie dynamisch geladen und entsprechend den Lizenzberechtigungen des Benutzers bereitgestellt werden.

```text
+-------------------------------------------------------------------+
|                        PRESENTATION LAYER                         |
|             (Views / UI Widgets / ViewModels - State)             |
+-------------------------------------------------------------------+
                                  |
                                  v
+-------------------------------------------------------------------+
|                           DOMAIN LAYER                            |
|             (Entities / Use Cases / Repository Contracts)         |
+-------------------------------------------------------------------+
                                  ^
                                  |
+-------------------------------------------------------------------+
|                            DATA LAYER                             |
|          (Models / Repositories Implementation / DataSources)    |
+-------------------------------------------------------------------+
                                  |
                                  v
+-------------------------------------------------------------------+
|                         CORE & INFRA LAYER                        |
|       (HTTP Client / AES-256 Storage / Native Extensions)         |
+-------------------------------------------------------------------+
```

## 2. Verzeichnisstruktur (`lib/`)

```text
lib/
├── app/                        # Bootstrapping, Routing und globale Konfigurationen
│   ├── app.dart                # MaterialApp und zentrale Routing-Konfiguration
│   └── app_config.dart         # Umgebungsvariablen und grundlegende Konstanten
│
├── core/                       # Geschäftslogik-unabhängige Infrastruktur
│   ├── constants/              # Farben, Schriftarten, Dimensionen und globale Schlüssel
│   ├── errors/                 # Exception Handling und Failures
│   ├── network/                # BxmHttpClient und BxmOAuthClient
│   ├── storage/                # SecureJsonStorageService (AES-256 / File System)
│   └── utils/                  # Formatter, Validatoren und Helper
│
├── features/                   # Funktionale Systemmodule
│   │
│   ├── auth/                   # Authentifizierung (Bexio Demo + QR-Code + Login)
│   │   ├── data/               # Models, DataSources und Repositories
│   │   ├── domain/             # Entities, UseCases und Verträge
│   │   └── presentation/       # ViewModels, Views und lokale Widgets
│   │
│   ├── dashboard/              # Haupt-Shell und dynamische Navigation
│   │   └── ...                 # (data, domain, presentation)
│   │
│   └── bmx_modules/            # Isolierte Funktionsmodule
│       ├── bmx_service/        # Serviceaufträge und Berichte
│       ├── bmx_stock/          # Lagerverwaltung und Artikel
│       ├── bmx_address/        # Kontaktverwaltung und CRM
│       └── bmx_invoice/        # Fakturierung und QR-Rechnung
│
├── shared/                     # Generische, wiederverwendbare Komponenten
│   ├── extensions/             # Erweiterungen für BuildContext, String und DateTime
│   ├── theme/                  # BxmTheme, Farbpalette und Typografie
│   └── widgets/                # Allgemeine UI-Komponenten (Buttons, Inputs)
│
├── app_dependencies.dart       # Manueller Dependency-Injection-Bootstrap-Container
└── main.dart                   # Einstiegspunkt und Dependency Injection

````

## 3. Anwendungsschichten

### 3.1. Domain (`domain/`)

Enthält die reine Geschäftslogik der Anwendung. Diese Schicht besitzt keine Abhängigkeiten vom Flutter-Ökosystem oder von externen Bibliotheken.

- **Entities:** Unveränderliche Domänenobjekte, welche die Geschäftsregeln repräsentieren.
- **Repositories (Interfaces):** Abstrakte Verträge, die definieren, wie Daten abgerufen oder gespeichert werden.
- **UseCases:** Führen isolierte und spezifische Aktionen innerhalb der Domäne aus, z. B. `LoginWithDemoUseCase`.

### 3.2. Data (`data/`)

Verantwortlich für das Abrufen, Konvertieren und Schreiben von Daten.

- **Models:** Erweiterungen der Domain-Entities mit Logik für die JSON-Serialisierung und -Deserialisierung (`fromJson`, `toJson`).
- **DataSources:** Direkte Kommunikation mit der Bexio REST API v2 (`RemoteDataSource`) oder mit dem lokalen Dateisystem (`LocalDataSource`).
- **Repositories (Implementations):** Verbinden die DataSources mit den in der Domain definierten Repository-Verträgen.

### 3.3. Presentation (`presentation/`)

Verantwortlich für die Darstellung und Interaktion mit dem Benutzer unter Verwendung der **MVVM-Architektur**.

- **Views:** Oberflächen, die ausschließlich aus Flutter-Widgets aufgebaut sind und keine Geschäfts- oder Zustandslogik enthalten.
- **ViewModels / Notifiers:** Verwalten den Zustand der Oberfläche mithilfe des nativen **`ChangeNotifier`** und `ListenableBuilder` (Ersetzung früherer Bloc/Cubit-Ansätze). Sie empfangen Eingaben aus den Views und führen die entsprechenden UseCases aus.
- **Widgets:** UI-Komponenten, die ausschließlich für die jeweilige Funktionalität bestimmt sind.

### 3.4. Core (`core/`)

Infrastruktur und allgemeine Hilfsfunktionen, die von der gesamten Anwendung verwendet werden.

- **Network (****`BxmHttpClient`****):** Wrapper für den HTTP-Client mit automatischer Injektion des `Bearer Token`, Error-Interceptors und Token-Erneuerung.
- **Storage (****`SecureJsonStorageService`****):** Speicherung lokaler JSON-Dateien mit AES-256-Verschlüsselung. Die Daten werden über `path_provider` im geschützten Gerätespeicher abgelegt, wodurch auf eine relationale Datenbank verzichtet werden kann.
- **Dependency Injection (****`AppDependencies`****):** Reiner, manueller Bootstrap-Container in `lib/app_dependencies.dart` zur sequenziellen Initialisierung und Bereitstellung aller Schichten ohne externe Service-Locator-Pakete.

## 4. Datenfluss (Data Flow)

Plaintext

```
[ User Action ] ──> ( View )
                      │ (Benachrichtigt)
                      ▼
               ( Notifier ) ──> [ Aktualisiert State ] ──> ( View Rebuild )
                      │
                      │ (Führt aus)
                      ▼
                 ( UseCase )
                      │
                      │ (Verwendet Vertrag)
                      ▼
               ( Repository )
                      │
           ┌──────────┴──────────┐
           ▼                     ▼
 ( LocalDataSource )    ( RemoteDataSource )
   [ AES-256 JSON ]       [ Bexio REST API ]

```

## 5. Richtlinien für das Shell-Container-Modul (`bmx_modules`)

1. **Entkopplung:** Jedes Modul innerhalb von `bmx_modules/` funktioniert als unabhängiges Ökosystem.
2. **Dynamisches Laden:** Das `DashboardViewModel` wertet die Berechtigungen aus, die im verschlüsselten Lizenz-Payload (`app_license.sec.json`) enthalten sind. Dadurch werden nur die Karten und Verknüpfungen angezeigt, die im jeweiligen Kundenplan freigeschaltet sind.
3. **Kommunikation über Core Event Bus / Deep Linking:** Module dürfen keinen direkten Code aus anderen Modulen importieren. Modulübergreifende Aufrufe erfolgen ausschließlich über im Dependency-Injection-Container registrierte Interfaces oder über benannte Routes.

## 6. Architekturprinzipien

Die Architektur von **BXMobile** folgt den folgenden grundlegenden Prinzipien:

- **Separation of Concerns:** Jede Schicht besitzt eine klar definierte Verantwortung.
- **Dependency Rule:** Abhängigkeiten zeigen grundsätzlich nach innen. Die Domain bleibt unabhängig von Frameworks und Infrastruktur.
- **Modularität:** Geschäftsfunktionen werden als eigenständige Module innerhalb von `bmx_modules/` organisiert.
- **Testbarkeit:** Geschäftslogik und UseCases können unabhängig von Flutter und externen Datenquellen getestet werden.
- **Wiederverwendbarkeit:** Gemeinsame Funktionen und UI-Komponenten werden in `core/` und `shared/` zentral bereitgestellt.
- **Lizenzbasierte Aktivierung:** Funktionale Module werden abhängig von den Berechtigungen der jeweiligen Kundenlizenz aktiviert.
- **Offline-Fähigkeit:** Lokale Daten können verschlüsselt gespeichert und für definierte Funktionen auch ohne aktive Netzwerkverbindung verwendet werden.
- **Sicherheit:** Authentifizierungsinformationen und sensible lokale Daten werden geschützt gespeichert und die Kommunikation mit externen APIs erfolgt über authentifizierte Verbindungen.

## 7. Zusammenfassung

BXMobile ist als **modularer Monolith mit Shell-Container-Architektur** konzipiert. Die Kombination aus **Clean Architecture**, **MVVM** und **Feature-First** ermöglicht eine klare Trennung zwischen Benutzeroberfläche, Geschäftslogik, Datenzugriff und Infrastruktur.

Die Architektur ermöglicht es, neue BMX-Funktionsmodule hinzuzufügen, ohne bestehende Module direkt voneinander abhängig zu machen. Gleichzeitig erlaubt das lizenzbasierte dynamische Laden, die Funktionalität der Anwendung flexibel an unterschiedliche Kunden- und Lizenzmodelle anzupassen.

Die zentrale Verantwortung des Containers besteht darin, Authentifizierung, Navigation, Lizenzverwaltung, Dependency Injection (mittels `AppDependencies`) und die Kommunikation zwischen den Modulen bereitzustellen, während die einzelnen BMX-Module ihre jeweilige Geschäftslogik vollständig kapseln.
