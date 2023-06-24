with KIVariablen;

package body LeseKIVariablen is

   function Kriegszustand
     return Boolean
   is begin
      
      return KIVariablen.Kriegszustand;
      
   end Kriegszustand;
   
   
   
   function Stadtverbindung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      AbschnittExtern : in EinheitenDatentypen.Bewegungsplan)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      return KIVariablen.Stadtverbindung (SpeziesExtern, AbschnittExtern);
      
   end Stadtverbindung;

end LeseKIVariablen;
