pragma SPARK_Mode (On);

package SpielEinstellungen is

   function SpielEinstellungen
     return Integer
     with
       Post =>
         (SpielEinstellungen'Result in -1 .. 0);

private

   RassenVorhanden : Boolean;

   HauptAuswahl : Integer;

end SpielEinstellungen;
