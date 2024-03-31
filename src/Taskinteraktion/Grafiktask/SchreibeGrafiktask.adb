with Grafiktask;

package body SchreibeGrafiktask is

   procedure FensterErzeugen
     (JaNeinExtern : in Boolean)
   is begin
      
      Grafiktask.Grafik.FensterErzeugen := JaNeinExtern;
      
   end FensterErzeugen;
   
   
   
   procedure IntroBeenden
     (JaNeinExtern : in Boolean)
   is begin
      
      Grafiktask.Grafik.IntroBeenden := JaNeinExtern;
      
   end IntroBeenden;
   
   
   
   procedure FensterEntfernen
     (JaNeinExtern : in Boolean)
   is begin
      
      Grafiktask.Grafik.FensterEntfernen := JaNeinExtern;
      
   end FensterEntfernen;
   
   
   
   procedure FensterAnpassen
     (AnpassungExtern : in GrafikDatentypen.Fenster_Anpassen_Enum)
   is begin
      
      Grafiktask.Grafik.FensterAnpassen := AnpassungExtern;
      
   end FensterAnpassen;
   
   
   
   procedure Abspann
     (AbspannExtern : in GrafikDatentypen.Spezieshintergrund_Enum)
   is begin
      
      Grafiktask.Grafik.Abspann := AbspannExtern;
      
   end Abspann;
   
   
   
   procedure SchriftartSetzen
     (JaNeinExtern : in Boolean)
   is begin
      
      Grafiktask.Texteinstellungen.SchriftartSetzen := JaNeinExtern;
      
   end SchriftartSetzen;
   
   
   
   procedure SchriftgrößeSetzen
     (JaNeinExtern : in Boolean)
   is begin
      
      Grafiktask.Texteinstellungen.SchriftgrößeSetzen := JaNeinExtern;
      
   end SchriftgrößeSetzen;
   
   
   
   procedure SchriftfarbeSetzen
     (JaNeinExtern : in Boolean)
   is begin
      
      Grafiktask.Texteinstellungen.SchriftfarbeSetzen := JaNeinExtern;
      
   end SchriftfarbeSetzen;
   
   
   
   procedure SchriftstilSetzen
     (JaNeinExtern : in Boolean)
   is begin
      
      Grafiktask.Texteinstellungen.SchriftstilSetzen := JaNeinExtern;
      
   end SchriftstilSetzen;
   
   
   
   procedure SchriftrahmenSetzen
     (JaNeinExtern : in Boolean)
   is begin
      
      Grafiktask.Texteinstellungen.SchriftrahmenSetzen := JaNeinExtern;
      
   end SchriftrahmenSetzen;
   
   
   
   procedure TextSetzen
     (JaNeinExtern : in Boolean)
   is begin
      
      Grafiktask.Texteinstellungen.TextSetzen := JaNeinExtern;
      
   end TextSetzen;
   
   
   
   procedure Darstellung
     (DarstellungExtern : in GrafikDatentypen.Aktuelle_Anzeige_Enum)
   is begin
      
      Grafiktask.Aktuell.Darstellung := DarstellungExtern;
      
   end Darstellung;
   
   
   
   procedure Menü
     (MenüExtern : in MenueDatentypen.Welches_Menü_Enum)
   is begin
      
      Grafiktask.Aktuell.Menü := MenüExtern;
      
   end Menü;
   
   
   
   procedure KIRechnet
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum)
   is begin
      
      Grafiktask.Aktuell.KIRechnet := SpeziesExtern;
      
   end KIRechnet;
   
   
   
   procedure AktiveSpezies
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum)
   is begin
      
      Grafiktask.Aktuell.AktiveSpezies := SpeziesExtern;
      
   end AktiveSpezies;
   
   
   
   procedure KontaktierteSpezies
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum)
   is begin
      
      Grafiktask.Aktuell.KontaktierteSpezies := SpeziesExtern;
      
   end KontaktierteSpezies;
   
   
   
   procedure Stadtnummer
     (StadtnummerExtern : in StadtDatentypen.Städtebereich)
   is begin
      
      Grafiktask.Aktuell.Stadtnummer := StadtnummerExtern;
      
   end Stadtnummer;
   
   
   
   procedure Einheitnummer
     (EinheitnummerExtern : in EinheitenDatentypen.Einheitenbereich)
   is begin
      
      Grafiktask.Aktuell.Einheitnummer := EinheitnummerExtern;
      
   end Einheitnummer;
   
   
   
   procedure GeheZu
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      Grafiktask.Aktuell.GeheZu := KoordinatenExtern;
      
   end GeheZu;
   
   
   
   procedure Seitenauswahl
     (JaNeinExtern : in Boolean)
   is begin
      
      Grafiktask.Auswahl.Seitenauswahl := JaNeinExtern;
      
   end Seitenauswahl;
   
   
   
   procedure Löschauswahl
     (JaNeinExtern : in Boolean)
   is begin
      
      Grafiktask.Auswahl.Löschauswahl := JaNeinExtern;
      
   end Löschauswahl;
   
   
   
   procedure Endauswahl
     (AuswahlExtern : in ZahlenDatentypen.EigenesNatural)
   is begin
      
      Grafiktask.Auswahl.Endauswahl := AuswahlExtern;
      
   end Endauswahl;
   
   
   
   procedure Erstauswahl
     (AuswahlExtern : in ZahlenDatentypen.EigenerInteger)
   is begin
      
      Grafiktask.Auswahl.Gesamtauswahl.Erstauswahl := AuswahlExtern;
      
   end Erstauswahl;
   
   
   
   procedure Zweitauswahl
     (AuswahlExtern : in ZahlenDatentypen.EigenerInteger)
   is begin
      
      Grafiktask.Auswahl.Gesamtauswahl.Zweitauswahl := AuswahlExtern;
      
   end Zweitauswahl;
   
   
   
   procedure StadtEinheitAuswahl
     (AuswahlExtern : in EinheitenRecords.AuswahlRecord)
   is begin
      
      Grafiktask.Auswahl.StadtEinheitAuswahl := AuswahlExtern;
      
   end StadtEinheitAuswahl;
   
   
   
   procedure Gebäudeauswahl
     (GebäudeExtern : in StadtDatentypen.GebäudeID)
   is begin
      
      Grafiktask.Auswahl.Bauauswahl.Gebäude := GebäudeExtern;
      
   end Gebäudeauswahl;
   
   
   
   procedure Einheitenauswahl
     (EinheitExtern : in EinheitenDatentypen.EinheitenID)
   is begin
      
      Grafiktask.Auswahl.Bauauswahl.Einheit := EinheitExtern;
      
   end Einheitenauswahl;
   
   
   
   procedure Tasteneingabe
     (JaNeinExtern : in Boolean)
   is begin
      
      Grafiktask.Eingabe.Tasteneingabe := JaNeinExtern;
      
   end Tasteneingabe;
   
   
   
   procedure Texteingabe
     (JaNeinExtern : in Boolean)
   is begin
      
      Grafiktask.Eingabe.Texteingabe := JaNeinExtern;
      
   end Texteingabe;
   
   
   
   procedure Vorzeicheneingabe
     (JaNeinExtern : in Boolean)
   is begin
      
      Grafiktask.Eingabe.Vorzeicheneingabe := JaNeinExtern;
      
   end Vorzeicheneingabe;
   
   
   
   procedure Eingabeart
     (EingabeartExtern : in GrafikDatentypen.Eingabe_Enum)
   is begin
      
      Grafiktask.Eingabe.Eingabeart := EingabeartExtern;
      
   end Eingabeart;
   
   
   
   procedure Zahleneingabe
     (ZahlExtern : in ZahlenDatentypen.EigenesNatural)
   is begin
      
      Grafiktask.Eingabe.Zahleneingabe := ZahlExtern;
      
   end Zahleneingabe;
   
   
   
   procedure Spielmeldung
     (MeldungExtern : in TextnummernKonstanten.Spielmeldungen)
   is begin
      
      Grafiktask.Meldung.Spielmeldung := MeldungExtern;
      
   end Spielmeldung;
   
   
   
   procedure Spielmeldungszeit
     (ZeitExtern : in Time)
   is begin
      
      Grafiktask.Meldung.Spielmeldungszeit := ZeitExtern;
      
   end Spielmeldungszeit;
   
   
   
   procedure Fragenanzeige
     (FrageExtern : in ZahlenDatentypen.EigenesNatural)
   is begin
      
      Grafiktask.Meldung.Fragenanzeige := FrageExtern;
      
   end Fragenanzeige;
   
   
   
   procedure Einheitenbewegung
     (JaNeinExtern : in Boolean)
   is begin
      
      Grafiktask.Einheitenbewegung.Bewegung := JaNeinExtern;
      
   end Einheitenbewegung;
   
   
   
   procedure EinheitBewegt
     (JaNeinExtern : in Boolean)
   is begin
      
      Grafiktask.Einheitenbewegung.Bewegt := JaNeinExtern;
      
   end EinheitBewegt;
   
   
   
   procedure Einheitenbewegungsbereich
     (JaNeinExtern : in Boolean)
   is begin
      
      Grafiktask.Einheitenbewegung.Bewegungsbereich := JaNeinExtern;
      
   end Einheitenbewegungsbereich;
   
   
   
   procedure Spielstandname
     (JaNeinExtern : in Boolean)
   is begin
      
      Grafiktask.Spielstand.Spielstandname := JaNeinExtern;
      
   end Spielstandname;
   
   
   
   procedure SpeichernLaden
     (JaNeinExtern : in Boolean)
   is begin
      
      Grafiktask.Spielstand.SpeichernLaden := JaNeinExtern;
      
   end SpeichernLaden;
   
   
   
   procedure Editorart
     (EditorartExtern : in GrafikDatentypen.Editor_Enum)
   is begin
      
      Grafiktask.Editor.Editor := EditorartExtern;
      
   end Editorart;

end SchreibeGrafiktask;
