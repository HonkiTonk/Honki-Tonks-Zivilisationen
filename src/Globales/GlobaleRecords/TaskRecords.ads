with Ada.Calendar; use Ada.Calendar;

with Sf.Window.Keyboard;
with Sf.Window.Mouse;

with SystemRecordsHTSEB;
with SystemDatentypenHTSEB;

with GrafikDatentypen;
with EinheitenRecords;
with StadtRecords;
with MenueDatentypen;
with TextnummernKonstanten;
with KartenRecords;
with SpeziesDatentypen;
with StadtDatentypen;
with EinheitenDatentypen;
with TonDatentypen;
with SystemRecords;

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
      
      Mausrad : Float;

      Text : SystemRecordsHTSEB.TextEingabeRecord;
      
   end record;
   -- Logiktask
   
   

   -- Grafiktask
   type GrafikRecord is record
   
      FensterErzeugen : Boolean;
      IntroBeenden : Boolean;
      FensterEntfernen : Boolean;
      
      FensterAnpassen : GrafikDatentypen.Fenster_Anpassen_Enum;
   
      Abspann : GrafikDatentypen.Hintergrund_Outro_Enum;
      
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
      
      Stadtnummer : StadtDatentypen.StädtebereichBasis;
   
      Einheitnummer : EinheitenDatentypen.EinheitenbereichBasis;
   
      GeheZu : KartenRecords.KartenfeldNaturalRecord;
      
   end record;
   
   
   
   type AuswahlGrafikRecord is record
      
      Seitenauswahl : Boolean;
      Löschauswahl : Boolean;
      
      Endauswahl : SystemDatentypenHTSEB.EigenesNatural;
      
      Gesamtauswahl : SystemRecords.DoppelauswahlRecord;
      
      StadtEinheitAuswahl : EinheitenRecords.AuswahlRecord;
      
      Bauauswahl : StadtRecords.ErweiterterBauprojektRecord;
      
   end record;
   
   
   
   type EingabeGrafikRecord is record
      
      Tasteneingabe : Boolean;
      Texteingabe : Boolean;
      Vorzeicheneingabe : Boolean;
      
      Eingabeart : GrafikDatentypen.Eingabe_Enum;
   
      Zahleneingabe : SystemDatentypenHTSEB.EigenesNatural;
      
      MaustasteGehalten : Boolean;
      TastaturtasteGehalten : Boolean;
      
   end record;
   
   
   
   type MeldungGrafikRecord is record
      
      Spielmeldung : TextnummernKonstanten.Spielmeldungen;
      
      Spielmeldungszeit : Time;
      
      Fragenanzeige : SystemDatentypenHTSEB.EigenesNatural;
      
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
      
      Starten : TonDatentypen.Sound_Enum;
      Stoppen : TonDatentypen.Sound_Enum;
      
   end record;
   -- Soundtask

end TaskRecords;
