pragma Warnings (Off, "*array aggregate*");

with KampfDatentypen;

package KampfRecords is
   pragma Pure;

   type KampfwerteRecord is record
      
      Angriff : KampfDatentypen.Kampfwerte;
      Verteidigung : KampfDatentypen.Kampfwerte;
      
   end record;

end KampfRecords;
