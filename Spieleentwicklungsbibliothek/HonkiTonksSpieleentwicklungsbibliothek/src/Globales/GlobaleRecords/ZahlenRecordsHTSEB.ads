with SystemDatentypenHTSEB;

package ZahlenRecordsHTSEB is
   pragma Pure;

   type WahrscheinlichkeitsbereichRecord is record
      
      Anfangswahrscheinlichkeit : SystemDatentypenHTSEB.NullBisHundert;
      Endwahrscheinlichkeit : SystemDatentypenHTSEB.NullBisHundert;
      
   end record;

end ZahlenRecordsHTSEB;
