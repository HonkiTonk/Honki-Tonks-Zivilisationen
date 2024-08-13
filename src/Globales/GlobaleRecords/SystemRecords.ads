with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with ZahlenDatentypen;
with BetriebssystemDatentypen;

package SystemRecords is
   pragma Preelaborate;

   type NutzerEinstellungenRecord is record
      
      Sprache : Unbounded_Wide_Wide_String;
      Texturen : Unbounded_Wide_Wide_String;
      
      AnzahlAutospeichern : ZahlenDatentypen.EigenesNatural;
      RundenAutospeichern : ZahlenDatentypen.EigenesPositive;
      
      Dezimaltrennzeichen : Wide_Wide_Character;
      
      SicherheitsfragenAnzeigen : Boolean;
      
   end record;
   
   
   
   -- Hier eventuell auch letzte Karten/Spieleinstellugnen speichern? äöü
   -- Oder das dann lieber temporär speichern und nach Spielende wegwerfen? äöü
   type SpielendeEinstellungenRecord is record
      
      AktuellerAutospeichernwert : ZahlenDatentypen.EigenesPositive;
      
   end record;
   
   
   
   type ZahlenEingabeRecord is record
      
      ErfolgreichAbbruch : Boolean;
      EingegebeneZahl : ZahlenDatentypen.EigenerInteger;
      
   end record;
   
   
   
   type TextEingabeRecord is record
      
      ErfolgreichAbbruch : Boolean;
      EingegebenerText : Unbounded_Wide_Wide_String;
      
   end record;
   
   
   
   type ProjekteinstellungenRecord is record
      
      VolleInformation : Boolean;
      FehlerWarnung : Boolean;
      Betriebssystem : BetriebssystemDatentypen.Betriebssystem_Enum;
      Stringkodierung : BetriebssystemDatentypen.Kodierung_Enum;
      Dateiform : String (1 .. 6);
      
   end record;
   
   
   
   -- Das hier vielleicht lieber in ein Array umwandeln? äöü
   type DoppelauswahlRecord is record
      
      Erstauswahl : Integer;
      Zweitauswahl : Integer;
      
   end record;
            
end SystemRecords;
