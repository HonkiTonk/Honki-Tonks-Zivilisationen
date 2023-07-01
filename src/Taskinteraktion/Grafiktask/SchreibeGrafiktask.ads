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
package SchreibeGrafiktask is
   pragma Elaborate_Body;

   procedure FensterErzeugen
     (JaNeinExtern : in Boolean);
   
   procedure IntroBeenden
     (JaNeinExtern : in Boolean);
   
   procedure FensterEntfernen
     (JaNeinExtern : in Boolean);
   
   procedure FensterAnpassen
     (AnpassungExtern : in GrafikDatentypen.Fenster_Anpassen_Enum);
   
   procedure Abspann
     (AbspannExtern : in GrafikDatentypen.Spezieshintergrund_Enum);
   
   procedure SchriftartSetzen
     (JaNeinExtern : in Boolean);
   
   procedure SchriftgrößeSetzen
     (JaNeinExtern : in Boolean);
   
   procedure SchriftfarbeSetzen
     (JaNeinExtern : in Boolean);
   
   procedure SchriftstilSetzen
     (JaNeinExtern : in Boolean);
   
   procedure TextSetzen
     (JaNeinExtern : in Boolean);
   
   procedure Darstellung
     (DarstellungExtern : in GrafikDatentypen.Aktuelle_Anzeige_Enum);
   
   procedure Menü
     (MenüExtern : in MenueDatentypen.Welches_Menü_Enum);
   
   procedure KIRechnet
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum);
   
   procedure AktiveSpezies
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum);
   
   procedure KontaktierteSpezies
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum);
   
   procedure Stadtnummer
     (StadtnummerExtern : in StadtDatentypen.MaximaleStädteMitNullWert);
   
   procedure Einheitnummer
     (EinheitnummerExtern : in EinheitenDatentypen.MaximaleEinheitenMitNullWert);
   
   procedure GeheZu
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord);
   
   procedure Seitenauswahl
     (JaNeinExtern : in Boolean);
   
   procedure Löschauswahl
     (JaNeinExtern : in Boolean);
   
   procedure Endauswahl
     (AuswahlExtern : in ZahlenDatentypen.EigenesNatural);
   
   procedure Erstauswahl
     (AuswahlExtern : in ZahlenDatentypen.EigenerInteger);
   
   procedure Zweitauswahl
     (AuswahlExtern : in ZahlenDatentypen.EigenerInteger);
   
   procedure StadtEinheitAuswahl
     (AuswahlExtern : in EinheitenRecords.AuswahlRecord);
   
   procedure Gebäudeauswahl
     (GebäudeExtern : in StadtDatentypen.GebäudeIDMitNullwert);
   
   procedure Einheitenauswahl
     (EinheitExtern : in EinheitenDatentypen.EinheitenIDMitNullWert);
   
   procedure Tasteneingabe
     (JaNeinExtern : in Boolean);
   
   procedure Texteingabe
     (JaNeinExtern : in Boolean);
   
   procedure Vorzeicheneingabe
     (JaNeinExtern : in Boolean);
   
   procedure Eingabeart
     (EingabeartExtern : in GrafikDatentypen.Eingabe_Enum);
   
   procedure Zahleneingabe
     (ZahlExtern : in ZahlenDatentypen.EigenesNatural);
   
   procedure Spielmeldung
     (MeldungExtern : in TextnummernKonstanten.Spielmeldungen);
   
   procedure Spielmeldungszeit
     (ZeitExtern : in Time);
   
   procedure Fragenanzeige
     (FrageExtern : in ZahlenDatentypen.EigenesNatural);
   
   procedure Einheitenbewegung
     (JaNeinExtern : in Boolean);
   
   procedure EinheitBewegt
     (JaNeinExtern : in Boolean);
   
   procedure Einheitenbewegungsbereich
     (JaNeinExtern : in Boolean);
   
   procedure Spielstandname
     (JaNeinExtern : in Boolean);
   
   procedure SpeichernLaden
     (JaNeinExtern : in Boolean);
   
   procedure Editorart
     (EditorartExtern : in GrafikDatentypen.Editor_Enum);

end SchreibeGrafiktask;
