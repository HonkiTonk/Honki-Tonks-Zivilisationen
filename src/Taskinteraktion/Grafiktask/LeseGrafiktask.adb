with Grafiktask;

package body LeseGrafiktask is

   function FensterErzeugen
     return Boolean
   is begin
      
      return Grafiktask.Grafik.FensterErzeugen;
      
   end FensterErzeugen;
   
   
   
   function IntroBeenden
     return Boolean
   is begin
      
      return Grafiktask.Grafik.IntroBeenden;
      
   end IntroBeenden;
   
   
   
   function FensterEntfernen
     return Boolean
   is begin
      
      return Grafiktask.Grafik.FensterEntfernen;
      
   end FensterEntfernen;
   
   
   
   function FensterAnpassen
     return GrafikDatentypen.Fenster_Anpassen_Enum
   is begin
      
      return Grafiktask.Grafik.FensterAnpassen;
      
   end FensterAnpassen;
   
   
   
   function Abspann
     return GrafikDatentypen.Spezieshintergrund_Enum
   is begin
      
      return Grafiktask.Grafik.Abspann;
      
   end Abspann;
   
   
   
   function SchriftartSetzen
     return Boolean
   is begin
      
      return Grafiktask.Texteinstellungen.SchriftartSetzen;
      
   end SchriftartSetzen;
   
   
   
   function SchriftgrößeSetzen
     return Boolean
   is begin
      
      return Grafiktask.Texteinstellungen.SchriftgrößeSetzen;
      
   end SchriftgrößeSetzen;
   
   
   
   function SchriftfarbeSetzen
     return Boolean
   is begin
      
      return Grafiktask.Texteinstellungen.SchriftfarbeSetzen;
      
   end SchriftfarbeSetzen;
   
   
   
   function SchriftstilSetzen
     return Boolean
   is begin
      
      return Grafiktask.Texteinstellungen.SchriftstilSetzen;
      
   end SchriftstilSetzen;
   
   
   
   function TextSetzen
     return Boolean
   is begin
      
      return Grafiktask.Texteinstellungen.TextSetzen;
      
   end TextSetzen;
   
   
   
   function Darstellung
     return GrafikDatentypen.Aktuelle_Anzeige_Enum
   is begin
      
      return Grafiktask.Aktuell.Darstellung;
      
   end Darstellung;
   
   
   
   function Menü
     return MenueDatentypen.Welches_Menü_Enum
   is begin
      
      return Grafiktask.Aktuell.Menü;
      
   end Menü;
   
   
   
   function KIRechnet
     return SpeziesDatentypen.Spezies_Enum
   is begin
      
      return Grafiktask.Aktuell.KIRechnet;
      
   end KIRechnet;
   
   
   
   function AktiveSpezies
     return SpeziesDatentypen.Spezies_Enum
   is begin
      
      return Grafiktask.Aktuell.AktiveSpezies;
      
   end AktiveSpezies;
   
   
   
   function KontaktiereSpezies
     return SpeziesDatentypen.Spezies_Enum
   is begin
      
      return Grafiktask.Aktuell.KontaktierteSpezies;
      
   end KontaktiereSpezies;
   
   
   
   function Stadtnummer
     return StadtDatentypen.Städtebereich
   is begin
      
      return Grafiktask.Aktuell.Stadtnummer;
      
   end Stadtnummer;
   
   
   
   function Einheitnummer
     return EinheitenDatentypen.Einheitenbereich
   is begin
      
      return Grafiktask.Aktuell.Einheitnummer;
      
   end Einheitnummer;
   
   
   
   function GeheZu
     return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      return Grafiktask.Aktuell.GeheZu;
      
   end GeheZu;
   
   
   
   function Seitenauswahl
     return Boolean
   is begin
      
      return Grafiktask.Auswahl.Seitenauswahl;
        
   end Seitenauswahl;
   
   
   
   function Löschauswahl
     return Boolean
   is begin
      
      return Grafiktask.Auswahl.Löschauswahl;
      
   end Löschauswahl;
   
   
   
   function Endauswahl
     return ZahlenDatentypen.EigenesNatural
   is begin
      
      return Grafiktask.Auswahl.Endauswahl;
      
   end Endauswahl;
   
   
   
   function Erstauswahl
     return ZahlenDatentypen.EigenerInteger
   is begin
      
      return Grafiktask.Auswahl.Gesamtauswahl.Erstauswahl;
      
   end Erstauswahl;
   
   
   
   function Zweitauswahl
     return ZahlenDatentypen.EigenerInteger
   is begin
      
      return Grafiktask.Auswahl.Gesamtauswahl.Zweitauswahl;
      
   end Zweitauswahl;
   
   
   
   function StadtEinheitAuswahl
     return EinheitenRecords.AuswahlRecord
   is begin
      
      return Grafiktask.Auswahl.StadtEinheitAuswahl;
      
   end StadtEinheitAuswahl;
   
   
   
   function Gebäudeauswahl
     return StadtDatentypen.GebäudeIDMitNullwert
   is begin
      
      return Grafiktask.Auswahl.Bauauswahl.Gebäude;
      
   end Gebäudeauswahl;
   
   
   
   function Einheitenauswahl
     return EinheitenDatentypen.EinheitenID
   is begin
      
      return Grafiktask.Auswahl.Bauauswahl.Einheit;
      
   end Einheitenauswahl;
   
   
   
   function Tasteneingabe
     return Boolean
   is begin
      
      return Grafiktask.Eingabe.Tasteneingabe;
      
   end Tasteneingabe;
   
   
   
   function Texteingabe
     return Boolean
   is begin
      
      return Grafiktask.Eingabe.Texteingabe;
      
   end Texteingabe;
   
   
   
   function Vorzeicheneingabe
     return Boolean
   is begin
      
      return Grafiktask.Eingabe.Vorzeicheneingabe;
      
   end Vorzeicheneingabe;
   
   
   
   function Eingabeart
     return GrafikDatentypen.Eingabe_Enum
   is begin
      
      return Grafiktask.Eingabe.Eingabeart;
      
   end Eingabeart;
   
   
   
   function Zahleneingabe
     return ZahlenDatentypen.EigenesNatural
   is begin
      
      return Grafiktask.Eingabe.Zahleneingabe;
      
   end Zahleneingabe;
   
   
   
   function Spielmeldung
     return TextnummernKonstanten.Spielmeldungen
   is begin
      
      return Grafiktask.Meldung.Spielmeldung;
      
   end Spielmeldung;
   
   
   
   function Spielmeldungszeit
     return Time
   is begin
      
      return Grafiktask.Meldung.Spielmeldungszeit;
      
   end Spielmeldungszeit;
   
   
   
   function Fragenanzeige
     return ZahlenDatentypen.EigenesNatural
   is begin
      
      return Grafiktask.Meldung.Fragenanzeige;
      
   end Fragenanzeige;
   
   
   
   function Einheitenbewegung
     return Boolean
   is begin
      
      return Grafiktask.Einheitenbewegung.Bewegung;
        
   end Einheitenbewegung;
      
   
   
   function EinheitBewegt
     return Boolean
   is begin
      
      return Grafiktask.Einheitenbewegung.Bewegt;
      
   end EinheitBewegt;
   
   
   
   function Einheitenbewegungsbereich
     return Boolean
   is begin
      
      return Grafiktask.Einheitenbewegung.Bewegungsbereich;
      
   end Einheitenbewegungsbereich;
   
   
   
   function Spielstandname
     return Boolean
   is begin
      
      return Grafiktask.Spielstand.Spielstandname;
      
   end Spielstandname;
   
   
   
   function SpeichernLaden
     return Boolean
   is begin
      
      return Grafiktask.Spielstand.SpeichernLaden;
      
   end SpeichernLaden;
   
   
   
   function Editorart
     return GrafikDatentypen.Editor_Enum
   is begin
      
      return Grafiktask.Editor.Editor;
      
   end Editorart;

end LeseGrafiktask;
