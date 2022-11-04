pragma Warnings (Off, "*array aggregate*");

with StadtDatentypen;
with EinheitenDatentypen;
with RassenDatentypen;

package DatenbankRecords is
   pragma Pure;
   
   type PassierbarkeitArray is array (EinheitenDatentypen.Passierbarkeit_Enum'Range) of Boolean;

   
   
   -- RassenDatenbank
   -- Das entweder erweitern oder durch eine bessere Idee ersetzen. äöü
   -- Entsprechend auch einen eigenen Datentyp für diese Werte anlegen. äöü
   type RassenlisteRecord is record
      
      Aggressivität : StadtDatentypen.MaximaleStädteMitNullWert;
      Expansion : StadtDatentypen.MaximaleStädteMitNullWert;
      Wissenschaft : StadtDatentypen.MaximaleStädteMitNullWert;
      Produktion : StadtDatentypen.MaximaleStädteMitNullWert;
      Wirtschaft : StadtDatentypen.MaximaleStädteMitNullWert;
      Bewirtschaftung : StadtDatentypen.MaximaleStädteMitNullWert;
      
      Staatsformen : RassenDatentypen.StaatsformenArray;
      -- Besondere Eigenschaften hinzufügen, als Enum? oder was Anderes?
      
   end record;
   -- RassenDatenbank
   
end DatenbankRecords;
