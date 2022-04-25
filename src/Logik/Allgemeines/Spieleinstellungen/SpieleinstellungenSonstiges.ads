pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RueckgabeDatentypen;
with SpielDatentypen;

package SpieleinstellungenSonstiges is

   procedure SchwierigkeitsgradFestlegen;
   
private
   
   SchwierigkeitAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
   type RückgabeZuSchwierigkeitsgradArray is array (RueckgabeDatentypen.Schwierigkeitsgrad_Enum'Range) of SpielDatentypen.Schwierigkeitsgrad_Enum;
   RückgabeZuSchwierigkeitsgrad : constant RückgabeZuSchwierigkeitsgradArray := (
                                                                                   RueckgabeDatentypen.Schwierigkeitsgrad_Leicht_Enum => SpielDatentypen.Schwierigkeitsgrad_Leicht_Enum,
                                                                                   RueckgabeDatentypen.Schwierigkeitsgrad_Mittel_Enum => SpielDatentypen.Schwierigkeitsgrad_Mittel_Enum,
                                                                                   RueckgabeDatentypen.Schwierigkeitsgrad_Schwer_Enum => SpielDatentypen.Schwierigkeitsgrad_Schwer_Enum
                                                                                  );

end SpieleinstellungenSonstiges;
