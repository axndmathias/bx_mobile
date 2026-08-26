# MVP-Spezifikation (Minimum Viable Product) — BXMobile

**Projekt:** BXMobile
**Aktualisierungsdatum:** August 2026
**Version:** 0.1.0

---

## 1. Ziele des MVP

Validierung des vollständigen Zyklus des **Demo-Modus (Bexio Sandbox)** ohne QR-Code, gefolgt von der Integration des traditionellen QR-Code-Workflows, der lokalen Persistenz in verschlüsseltem JSON ohne Datenbank, der Benutzerauthentifizierung und der dynamischen Menüdarstellung aller Systemmodule (*BMXAdresse, BMXStock/BMXArticle, BMXService, BMXInvoice*).

## 2. Umfang des MVP (In Scope)

1. **Phase 1: Workflow des Demo-Benutzers (Aktuelle Priorität)**
   - Option "Als Demo-Benutzer anmelden / Demo Modus" auf dem Startbildschirm.
   - Laden von Anmeldeinformationen und Tokens aus der Bexio ERP Sandbox API.
   - Generierung und Speicherung der Datei `app_license.sec.json` im Demo-Format.
   - Direkter Zugriff auf das Dashboard mit allen freigeschalteten Modulen im Testmodus.
2. **Phase 2: Traditioneller Workflow (QR-Code & Login)**
   - QR-Code-Scanner (`mobile_scanner`).
   - Auslesen des Produktions-Payloads, Speicherung des verschlüsselten JSONs und täglicher Login-Bildschirm mit Benutzername und Passwort.
3. **App-Core & Dashboard:**
   - Grundlegende Clean Architecture + MVVM Infrastruktur.
   - `LicenseService` für die zentrale Verwaltung des Lizenzstatus (Demo vs. Produktion).
   - Dashboard (Home) mit dynamischer Menüführung.

## 3. Ausserhalb des MVP-Umfangs (Zukünftige Phasen)

- Komplexe bidirektionale Synchronisierung mit ERP-Systemen (Bexio/Proffix).
- Drucken von Dokumenten über Bluetooth/Wi-Fi.
- Erfassung von Barcodes/QR-Codes innerhalb des BMXStock-Moduls.
