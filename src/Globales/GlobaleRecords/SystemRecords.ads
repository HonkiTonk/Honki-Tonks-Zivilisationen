with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with ZahlenDatentypen;

package SystemRecords is
   pragma Preelaborate;

   type NutzerEinstellungenRecord is record
      
      Sprache : Unbounded_Wide_Wide_String;
      
      AnzahlAutospeichern : ZahlenDatentypen.EigenesNatural;
      RundenAutospeichern : ZahlenDatentypen.EigenesPositive;
      
   end record;
   
   
   
   type ZahlenEingabeRecord is record
      
      ErfolgreichAbbruch : Boolean;
      EingegebeneZahl : ZahlenDatentypen.EigenerInteger;
      
   end record;
   
   
   
   type TextEingabeRecord is record
      
      ErfolgreichAbbruch : Boolean;
      EingegebenerText : Unbounded_Wide_Wide_String;
      
   end record;
   
   
   
   type DebugRecord is record
      
      VolleInformation : Boolean;
      FehlerWarnung : Boolean;
      LinuxWindows : Boolean;
      
   end record;
   
   
   
   -- Das hier vielleicht lieber in ein Array umwandeln? äöü
   type MehrfacheAuswahlRecord is record
      
      AuswahlEins : Integer;
      AuswahlZwei : Integer;
      
   end record;
            
end SystemRecords;
