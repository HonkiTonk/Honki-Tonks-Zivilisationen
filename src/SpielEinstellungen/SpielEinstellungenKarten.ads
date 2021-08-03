pragma SPARK_Mode (On);

package SpielEinstellungenKarten is
   
   function KartengrößeWählen
     return Integer
     with
       Post =>
         (KartengrößeWählen'Result >= -2);

   function KartenartWählen
     return Integer
     with
       Post =>
         (KartenartWählen'Result >= -2);

   function KartenformWählen
     return Integer
     with
       Post =>
         (KartenformWählen'Result >= -2);

   function KartentemperaturWählen
     return Integer
     with
       Post =>
         (KartentemperaturWählen'Result >= -2);
   
   function KartenressourcenWählen
     return Integer
     with
       Post =>
         (KartenressourcenWählen'Result >= -2);
   
private
      
   KartengrößeAuswahl : Integer;
   KartenartAuswahl : Integer;
   KartenformAuswahl : Integer;
   KartentemperaturAuswahl : Integer;
   KartenressourcenAuswahl : Integer;
   
   BenutzerdefinierteGröße : Integer;

end SpielEinstellungenKarten;
