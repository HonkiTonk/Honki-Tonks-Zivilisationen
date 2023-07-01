with Ada.Calendar; use Ada.Calendar;

with GrafikDatentypen;
with MenueDatentypen;
with SpeziesDatentypen;
with StadtDatentypen;
with EinheitenDatentypen;
with KartenRecords;
with ZahlenDatentypen;
with TextnummernKonstanten;
with EinheitenRecords;

-- Hier noch Contracts einbauen. äöü
package LeseGrafiktask is
   pragma Elaborate_Body;

   function FensterErzeugen
     return Boolean;
   
   function IntroBeenden
     return Boolean;
   
   function FensterEntfernen
     return Boolean;
   
   function FensterAnpassen
     return GrafikDatentypen.Fenster_Anpassen_Enum;
   
   function Abspann
     return GrafikDatentypen.Spezieshintergrund_Enum;
   
   function SchriftartSetzen
     return Boolean;
   
   function SchriftgrößeSetzen
     return Boolean;
   
   function SchriftfarbeSetzen
     return Boolean;
   
   function SchriftstilSetzen
     return Boolean;
   
   function TextSetzen
     return Boolean;
   
   function Darstellung
     return GrafikDatentypen.Aktuelle_Anzeige_Enum;
   
   function Menü
     return MenueDatentypen.Welches_Menü_Enum;
   
   function KIRechnet
     return SpeziesDatentypen.Spezies_Enum;
   
   function AktiveSpezies
     return SpeziesDatentypen.Spezies_Enum;
   
   function KontaktiereSpezies
     return SpeziesDatentypen.Spezies_Enum;
   
   function Stadtnummer
     return StadtDatentypen.MaximaleStädteMitNullWert;
   
   function Einheitnummer
     return EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   
   function GeheZu
     return KartenRecords.AchsenKartenfeldNaturalRecord;
   
   function Seitenauswahl
     return Boolean;
   
   function Löschauswahl
     return Boolean;
   
   function Endauswahl
     return ZahlenDatentypen.EigenesNatural;
   
   function Erstauswahl
     return ZahlenDatentypen.EigenerInteger;
   
   function Zweitauswahl
     return ZahlenDatentypen.EigenerInteger;
   
   function StadtEinheitAuswahl
     return EinheitenRecords.AuswahlRecord;
   
   function Gebäudeauswahl
     return StadtDatentypen.GebäudeIDMitNullwert;
   
   function Einheitenauswahl
     return EinheitenDatentypen.EinheitenIDMitNullWert;
   
   function Tasteneingabe
     return Boolean;
   
   function Texteingabe
     return Boolean;
   
   function Vorzeicheneingabe
     return Boolean;
   
   function Eingabeart
     return GrafikDatentypen.Eingabe_Enum;
   
   function Zahleneingabe
     return ZahlenDatentypen.EigenesNatural;
   
   function Spielmeldung
     return TextnummernKonstanten.Spielmeldungen;
   
   function Spielmeldungszeit
     return Time;
   
   function Fragenanzeige
     return ZahlenDatentypen.EigenesNatural;
   
   function Einheitenbewegung
     return Boolean;
   
   function EinheitBewegt
     return Boolean;
   
   function Einheitenbewegungsbereich
     return Boolean;
   
   function Spielstandname
     return Boolean;
   
   function SpeichernLaden
     return Boolean;
   
   function Editorart
     return GrafikDatentypen.Editor_Enum;

end LeseGrafiktask;
