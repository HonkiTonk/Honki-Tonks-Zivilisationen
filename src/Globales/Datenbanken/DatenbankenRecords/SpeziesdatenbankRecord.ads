with SpeziesDatentypen;

package SpeziesdatenbankRecord is
   pragma Pure;

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

end SpeziesdatenbankRecord;
