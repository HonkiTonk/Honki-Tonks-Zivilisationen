with KampfDatentypen;

package KampfRecords is
   pragma Pure;

   type KampfwerteRecord is record
      
      Angriff : KampfDatentypen.KampfwerteGroß;
      Verteidigung : KampfDatentypen.KampfwerteGroß;
      
   end record;

end KampfRecords;
