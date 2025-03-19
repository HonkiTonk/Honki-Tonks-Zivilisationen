with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with BetriebssystemDatentypenHTSEB;

with ZahlenDatentypen;

package SystemRecords is
   pragma Preelaborate;

   type NutzerEinstellungenRecord is record
      
      Sprache : Unbounded_Wide_Wide_String;
      Texturen : Unbounded_Wide_Wide_String;
      Musik : Unbounded_Wide_Wide_String;
      Sound : Unbounded_Wide_Wide_String;
      
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
   
   
   
   -- Das auch auslagern und von außen setzen lassen? äöü
   -- Auf jeden Fall die verschiedenen Versionen anpassen! äöü
   type ProjekteinstellungenRecord is record
      
      VolleInformation : Boolean;
      FehlerWarnung : Boolean;
      Betriebssystem : BetriebssystemDatentypenHTSEB.Betriebssystem_Enum;
      Stringkodierung : BetriebssystemDatentypenHTSEB.Kodierung_Enum;
      Dateiform : Character;
      
   end record;
   
   
   
   -- Das hier vielleicht lieber in ein Array umwandeln? äöü
   type DoppelauswahlRecord is record
      
      Erstauswahl : Integer;
      Zweitauswahl : Integer;
      
   end record;
            
end SystemRecords;
