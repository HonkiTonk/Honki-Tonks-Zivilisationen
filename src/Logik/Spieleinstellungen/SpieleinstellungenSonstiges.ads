pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;

package SpieleinstellungenSonstiges is

   procedure SchwierigkeitsgradFestlegen;
   
private
   
   SchwierigkeitAuswahl : SystemDatentypen.Rückgabe_Werte_Enum;

end SpieleinstellungenSonstiges;
