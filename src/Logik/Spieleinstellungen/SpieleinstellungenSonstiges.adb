pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GlobaleVariablen;

with ZufallGeneratorenSpieleinstellungen;
with AuswahlMenues;
with Fehler;

package body SpieleinstellungenSonstiges is

   procedure SchwierigkeitsgradFestlegen
   is begin
      
      SchwierigkeitsgradSchleife:
      loop

         SchwierigkeitAuswahl := AuswahlMenues.AuswahlMenüsAufteilung (WelchesMenüExtern => SystemDatentypen.Schwierigkeitsgrad_Menü_Enum);
         
         case
           SchwierigkeitAuswahl
         is
            when SystemDatentypen.Schwierigkeitsgrad_Verwendet_Enum'Range =>
               GlobaleVariablen.Schwierigkeitsgrad := SchwierigkeitAuswahl;

            when SystemDatentypen.Zufall_Enum =>
               GlobaleVariablen.Schwierigkeitsgrad := ZufallGeneratorenSpieleinstellungen.ZufälligerSchwiewrigkeitsgrad;
               
            when SystemDatentypen.Fertig_Enum =>
               return;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenSonstiges.SchwierigkeitsgradFestlegen - Ungültige Menüasuwahl.");
         end case;
         
      end loop SchwierigkeitsgradSchleife;
      
   end SchwierigkeitsgradFestlegen;

end SpieleinstellungenSonstiges;
