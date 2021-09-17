pragma SPARK_Mode (On);

package Optionen is

   function Optionen
     return Integer;

private

   Taste : Wide_Wide_Character;

   AuswahlWert : Integer;
   RückgabeWert : Integer;

end Optionen;
