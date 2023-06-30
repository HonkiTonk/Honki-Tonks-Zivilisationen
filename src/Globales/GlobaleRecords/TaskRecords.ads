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

-- Eventuell ein paar der Namen noch einmal kürzen. äöü
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
   type SpielstartGrafikRecord is record
      
      ErzeugeFenster : Boolean;
      IntroBeenden : Boolean;
      
   end record;
   
   
   
   type GrafikRecord is record
   
      FensterGeschlossen : Boolean;
      
      AktuelleDarstellung : GrafikDatentypen.AKtuelle_Anzeige_Enum;
   
      AktuellesMenü : MenueDatentypen.Welches_Menü_Enum;
      
      FensterVerändert : GrafikDatentypen.Fenster_Ändern_Enum;
   
      Abspannart : GrafikDatentypen.Spezieshintergrund_Enum;
      
   end record;
   
   
   
   type TexteinstellungenGrafikRecord is record
      
      SchriftartSetzen : Boolean;
      SchriftgrößeSetzen : Boolean;
      SchriftfarbeSetzen : Boolean;
      SchriftstilSetzen : Boolean;
      TextSetzen : Boolean;
      
   end record;
   
   
   
   type AuswahlGrafikRecord is record
      
      SprachenSeitenauswahl : Boolean;
      LöschenAuswahl : Boolean;
      
      Endauswahl : ZahlenDatentypen.EigenesNatural;
      
      -- Die Auswahlrecords hier mal soweit möglich auseinander ziehen. äöü
      AktuelleAuswahl : SystemRecords.MehrfacheAuswahlRecord;
      
      StadtEinheitAuswahl : EinheitenRecords.AuswahlRecord;
      
      Bauauswahl : StadtRecords.BauprojektRecord;
      
   end record;
   
   
   
   type EingabeGrafikRecord is record
      
      TastenEingabe : Boolean;
      TextEingabe : Boolean;
      VorzeichenEingabe : Boolean;
      
      Eingabeart : GrafikDatentypen.Eingabe_Enum;
   
      ZahlenEingabe : ZahlenDatentypen.EigenesNatural;
      
   end record;
   
   
   
   type MeldungenGrafikRecord is record
      
      Spielmeldung : TextnummernKonstanten.Spielmeldungen;
      
      StartzeitSpielmeldung : Time;
      
      AnzeigeFrage : ZahlenDatentypen.EigenesNatural;
      
   end record;
   
   
   
   type AktuellesGrafikRecord is record
      
      Stadtkarte : Boolean;
      
      KIRechnet : SpeziesDatentypen.Spezies_Enum;
      AktuelleSpezies : SpeziesDatentypen.Spezies_Enum;
      KontaktierteSpezies : SpeziesDatentypen.Spezies_Enum;
      
      AktuelleStadt : StadtDatentypen.MaximaleStädteMitNullWert;
   
      AktuelleEinheit : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   
      GeheZu : KartenRecords.AchsenKartenfeldNaturalRecord;
      
   end record;
   
   
   
   type SpielstandGrafikRecord is record
      
      NameSpielstand : Boolean;
      SpeichernLaden : Boolean;
      
   end record;
   
   
   
   type EinheitenbewegungGrafikRecord is record
      
      Einheitenbewegung : Boolean;
      EinheitBewegt : Boolean;
      EinheitBewegungsbereich : Boolean;
      
   end record;
   
   
   
   type EditorGrafikRecord is record
      
      WelcherEditor : GrafikDatentypen.Editor_Enum;
      
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
