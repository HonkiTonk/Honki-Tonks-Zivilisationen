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
with SystemRecords;

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
   
   function SchriftrahmenSetzen
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
     return StadtDatentypen.Städtebereich;
   
   function Einheitnummer
     return EinheitenDatentypen.Einheitenbereich;
   
   function GeheZu
     return KartenRecords.KartenfeldNaturalRecord;
   
   function Seitenauswahl
     return Boolean;
   
   function Löschauswahl
     return Boolean;
   
   function Endauswahl
     return ZahlenDatentypen.EigenesNatural;
   
   function Gesamtauswahl
     return SystemRecords.DoppelauswahlRecord;
   
   function Erstauswahl
     return ZahlenDatentypen.EigenerInteger;
   
   function Zweitauswahl
     return ZahlenDatentypen.EigenerInteger;
   
   function StadtEinheitAuswahl
     return EinheitenRecords.AuswahlRecord;
   
   -- Für den BauprojektRecord und seiner Erweiterung mal eine Funktion schreiben. äöü
   function Gebäudeauswahl
     return StadtDatentypen.GebäudeID;
   
   function Einheitenauswahl
     return EinheitenDatentypen.EinheitenID;
   
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
   
   function MaustasteGehalten
     return Boolean;
   
   function TastaturtasteGehalten
     return Boolean;
   
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
