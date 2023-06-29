with GrafikDatentypen;
with ZahlenDatentypen;
with EinheitenRecords;
with SystemRecords;
with StadtRecords;
with MenueDatentypen;

-- Eventuell ein paar der Namen noch einmal kürzen. äöü
package TaskRecords is
   pragma Preelaborate;
   
   -- Logiktask
   
   -- Logiktask
   
   

   -- Grafiktask
   type SpielstartRecord is record
      
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
   
   
   
   type TexteinstellungenRecord is record
      
      SchriftartSetzen : Boolean;
      SchriftgrößeSetzen : Boolean;
      SchriftfarbeSetzen : Boolean;
      SchriftstilSetzen : Boolean;
      TextSetzen : Boolean;
      
   end record;
   
   
   
   type AuswahlRecord is record
      
      SprachenSeitenauswahl : Boolean;
      LöschenAuswahl : Boolean;
      
      Endauswahl : ZahlenDatentypen.EigenesNatural;
      
      -- Die Auswahlrecords hier mal soweit möglich auseinander ziehen. äöü
      AktuelleAuswahl : SystemRecords.MehrfacheAuswahlRecord;
      
      StadtEinheitAuswahl : EinheitenRecords.AuswahlRecord;
      
      Bauauswahl : StadtRecords.BauprojektRecord;
      
   end record;
   
   
   
   type EingabeRecord is record
      
      TastenEingabe : Boolean;
      TextEingabe : Boolean;
      VorzeichenEingabe : Boolean;
      
      Eingabeart : GrafikDatentypen.Eingabe_Enum;
   
      ZahlenEingabe : ZahlenDatentypen.EigenesNatural;
      
   end record;
   
   
   
   type SpielstandRecord is record
      
      NameSpielstand : Boolean;
      SpeichernLaden : Boolean;
      
   end record;
   
   
   
   type EinheitenbewegungRecord is record
      
      Einheitenbewegung : Boolean;
      EinheitBewegt : Boolean;
      EinheitBewegungsbereich : Boolean;
      
   end record;
   
   
   
   type EditorRecord is record
      
      WelcherEditor : GrafikDatentypen.Editor_Enum;
      
   end record;
   -- Grafiktask
   
   
   
   -- Tontask
   
   -- Tontask

end TaskRecords;
