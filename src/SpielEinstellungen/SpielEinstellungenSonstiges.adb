pragma SPARK_Mode (On);

with GlobaleVariablen;

with ZufallGeneratorenSpieleinstellungen;
with AuswahlMenue;

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

            when SystemDatentypen.Spiel_Beenden | SystemDatentypen.Hauptmenü =>
               return SchwierigkeitAuswahl;
               
            when SystemDatentypen.Leer =>
               null;
               
            when others =>
               raise Program_Error;
         end case;
         
      end loop SchwierigkeitsgradSchleife;
      
   end SchwierigkeitsgradFestlegen;

end SpielEinstellungenSonstiges;
