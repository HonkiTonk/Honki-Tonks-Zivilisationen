with Ada.Calendar; use Ada.Calendar;

with Sf.Window.Keyboard;
with Sf.Window.Mouse;

with GrafikDatentypen;
with ZahlenDatentypen;
with EinheitenRecords;
with SystemRecords;
with StadtRecords;
with MenueDatentypen;
with TextnummernKonstanten;
with KartenRecords;
with SpeziesDatentypen;
with StadtDatentypen;
with EinheitenDatentypen;
with TonDatentypen;

-- Eventuell ein paar der Namen noch einmal anpassen. äöü
package TaskRecords is
   pragma Elaborate_Body;
   
   -- Logiktask
   type WartenLogikRecord is record
      
      Sound : Boolean;
      Musik : Boolean;
      Grafik : Boolean;
      Intro : Boolean;
      
   end record;
   
   
   
   type EingabeLogikRecord is record

      Tastaturtaste : Sf.Window.Keyboard.sfKeyCode;

      Maustaste : Sf.Window.Mouse.sfMouseButton;

      Text : SystemRecords.TextEingabeRecord;
      
   end record;
   -- Logiktask
   
   

   -- Grafiktask
   type GrafikRecord is record
   
      FensterErzeugen : Boolean;
      IntroBeenden : Boolean;
      FensterEntfernen : Boolean;
      
      FensterAnpassen : GrafikDatentypen.Fenster_Anpassen_Enum;
   
      Abspann : GrafikDatentypen.Spezieshintergrund_Enum;
      
   end record;
   
   
   
   type TexteinstellungenGrafikRecord is record
      
      SchriftartSetzen : Boolean;
      SchriftgrößeSetzen : Boolean;
      SchriftfarbeSetzen : Boolean;
      SchriftstilSetzen : Boolean;
      SchriftrahmenSetzen : Boolean;
      TextSetzen : Boolean;
      
   end record;
   
   
   
   type AktuellGrafikRecord is record
      
      Darstellung : GrafikDatentypen.Aktuelle_Anzeige_Enum;
   
      Menü : MenueDatentypen.Welches_Menü_Enum;
      
      KIRechnet : SpeziesDatentypen.Spezies_Enum;
      AktiveSpezies : SpeziesDatentypen.Spezies_Enum;
      KontaktierteSpezies : SpeziesDatentypen.Spezies_Enum;
      
      Stadtnummer : StadtDatentypen.Städtebereich;
   
      Einheitnummer : EinheitenDatentypen.Einheitenbereich;
   
      GeheZu : KartenRecords.KartenfeldNaturalRecord;
      
   end record;
   
   
   
   type AuswahlGrafikRecord is record
      
      Seitenauswahl : Boolean;
      Löschauswahl : Boolean;
      
      Endauswahl : ZahlenDatentypen.EigenesNatural;
      
      Gesamtauswahl : SystemRecords.DoppelauswahlRecord;
      
      StadtEinheitAuswahl : EinheitenRecords.AuswahlRecord;
      
      Bauauswahl : StadtRecords.ErweiterterBauprojektRecord;
      
   end record;
   
   
   
   type EingabeGrafikRecord is record
      
      Tasteneingabe : Boolean;
      Texteingabe : Boolean;
      Vorzeicheneingabe : Boolean;
      
      Eingabeart : GrafikDatentypen.Eingabe_Enum;
   
      Zahleneingabe : ZahlenDatentypen.EigenesNatural;
      
   end record;
   
   
   
   type MeldungGrafikRecord is record
      
      Spielmeldung : TextnummernKonstanten.Spielmeldungen;
      
      Spielmeldungszeit : Time;
      
      Fragenanzeige : ZahlenDatentypen.EigenesNatural;
      
   end record;
   
   
   
   type EinheitenbewegungGrafikRecord is record
      
      Bewegung : Boolean;
      Bewegt : Boolean;
      Bewegungsbereich : Boolean;
      
   end record;
   
   
   
   type SpielstandGrafikRecord is record
      
      Spielstandname : Boolean;
      SpeichernLaden : Boolean;
      
   end record;
   
   
   
   type EditorGrafikRecord is record
      
      Editor : GrafikDatentypen.Editor_Enum;
      
   end record;
   -- Grafiktask
   
   
   
   -- Musiktask
   
   -- Musiktask
   
   
   
   -- Soundtask
   type SoundRecord is record
      
      Starten : TonDatentypen.Sound_Aktuelle_Auswahl_Enum;
      Stoppen : TonDatentypen.Sound_Aktuelle_Auswahl_Enum;
      
   end record;
   -- Soundtask

end TaskRecords;
