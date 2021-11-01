pragma SPARK_Mode (On);

with SystemDatentypen;

package SpielEinstellungenSonstiges is

   function SchwierigkeitsgradFestlegen
     return SystemDatentypen.Rückgabe_Werte_Enum;
   
private
   
   SchwierigkeitAuswahl : Integer;

end SpielEinstellungenSonstiges;
