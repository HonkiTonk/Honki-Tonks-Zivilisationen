pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KampfDatentypen;

package KampfRecords is

   type KampfwerteRecord is record
      
      Angriff : KampfDatentypen.Kampfwerte;
      Verteidigung : KampfDatentypen.Kampfwerte;
      
   end record;

end KampfRecords;
