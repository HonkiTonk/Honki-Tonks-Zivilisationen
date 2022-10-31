pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with RueckgabeDatentypen;

package SpieleinstellungenSonstigesLogik is
   pragma Elaborate_Body;

   procedure SchwierigkeitsgradFestlegen;
   
private
   
   SchwierigkeitAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;

end SpieleinstellungenSonstigesLogik;
