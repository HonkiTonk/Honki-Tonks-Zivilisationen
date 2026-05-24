with KampfDatentypen;

package KampfRecords is
   pragma Pure;

   type KampfwerteRecord is record
      
      Angriff : KampfDatentypen.KampfwerteBasis;
      Verteidigung : KampfDatentypen.KampfwerteBasis;
      
   end record;

end KampfRecords;
