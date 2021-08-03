pragma SPARK_Mode (On);

package SpielEinstellungenSonstiges is

   function SchwierigkeitsgradFestlegen
     return Integer
     with
       Post =>
         (SchwierigkeitsgradFestlegen'Result >= -2);
   
private
   
   SchwierigkeitAuswahl : Integer;

end SpielEinstellungenSonstiges;
