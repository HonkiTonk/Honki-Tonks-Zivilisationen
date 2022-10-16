pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ProduktionDatentypen;
with ForschungenDatentypen;

package ForschungsdatenbankRecord is

   type ForschungslisteRecord is record

      Kosten : ProduktionDatentypen.Lagermenge;
      Anforderung : ForschungenDatentypen.AnforderungForschungArray;

   end record;
   
   type ForschungslisteArray is array (ForschungenDatentypen.ForschungID'Range) of ForschungslisteRecord;

end ForschungsdatenbankRecord;
