pragma SPARK_Mode (On);

with GlobaleVariablen;

with ZufallGeneratorenSpieleinstellungen;
with AuswahlMenue;
with Fehler;

package body SpielEinstellungenSonstiges is

   function SchwierigkeitsgradFestlegen
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      SchwierigkeitsgradSchleife:
      loop

         SchwierigkeitAuswahl := AuswahlMenue.AuswahlMenü (WelchesMenüExtern => SystemDatentypen.Schwierigkeitsgrad_Menü);
         
         case
           SchwierigkeitAuswahl
         is
            when SystemDatentypen.Schwierigkeitsgrad_Verwendet_Enum'Range =>
               GlobaleVariablen.Schwierigkeitsgrad := SchwierigkeitAuswahl;
               return SystemDatentypen.Start_Weiter;

            when SystemDatentypen.Zufall =>
               GlobaleVariablen.Schwierigkeitsgrad := ZufallGeneratorenSpieleinstellungen.ZufälligerSchwiewrigkeitsgrad;
               return SystemDatentypen.Start_Weiter;
               
            when SystemDatentypen.Zurück =>
               return SystemDatentypen.Auswahl_Rassen;

            when SystemDatentypen.Hauptmenü_Beenden_Enum'Range =>
               return SchwierigkeitAuswahl;
               
            when others =>
               Fehler.LogikStopp (FehlermeldungExtern => "SpielEinstellungenSonstiges.SchwierigkeitsgradFestlegen - Ungültige Menüasuwahl.");
         end case;
         
      end loop SchwierigkeitsgradSchleife;
      
   end SchwierigkeitsgradFestlegen;

end SpielEinstellungenSonstiges;
