with EinheitenDatentypen;
with SpeziesDatentypen;

package DatenbankRecords is
   pragma Pure;
   
   type PassierbarkeitArray is array (EinheitenDatentypen.Passierbarkeit_Enum'Range) of Boolean;

   
   
   -- SpeziesDatenbank
   -- Das entweder erweitern oder durch eine bessere Idee ersetzen. äöü
   -- Entsprechend auch einen eigenen Datentyp für diese Werte anlegen. äöü
   type SpezieslisteRecord is record
      
      Aggressivität : SpeziesDatentypen.Speziesverhalten;
      Expansion : SpeziesDatentypen.Speziesverhalten;
      Wissenschaft : SpeziesDatentypen.Speziesverhalten;
      Produktion : SpeziesDatentypen.Speziesverhalten;
      Wirtschaft : SpeziesDatentypen.Speziesverhalten;
      Bewirtschaftung : SpeziesDatentypen.Speziesverhalten;
      
      Staatsformen : SpeziesDatentypen.StaatsformenArray;
      -- Besondere Eigenschaften hinzufügen, als Enum? oder was Anderes?
      
   end record;
   -- SpeziesDatenbank
   
end DatenbankRecords;
