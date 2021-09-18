pragma SPARK_Mode (On);

package SpielEinstellungen is

   function SpielEinstellungenAuswahl
     return Integer
     with
       Post =>
         (SpielEinstellungenAuswahl'Result in -1 .. 0);

private

   RassenVorhanden : Boolean;

   HauptAuswahl : Integer;

   function AutomatischeEinstellungen
     return Integer
     with
       Post =>
         (AutomatischeEinstellungen'Result in -1 .. 0);

end SpielEinstellungen;
