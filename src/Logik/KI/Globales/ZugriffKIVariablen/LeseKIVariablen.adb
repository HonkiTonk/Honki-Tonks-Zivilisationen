with KIVariablen;

package body LeseKIVariablen is

   function Kriegszustand
     return Boolean
   is begin
      
      return KIVariablen.Kriegszustand;
      
   end Kriegszustand;
   
   
   
   function Stadtverbindung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      AbschnittExtern : in EinheitenDatentypen.Bewegungsplan)
      return KartenRecords.KartenfeldNaturalRecord
   is begin
      
      return KIVariablen.Stadtverbindung (SpeziesExtern, AbschnittExtern);
      
   end Stadtverbindung;

end LeseKIVariablen;
