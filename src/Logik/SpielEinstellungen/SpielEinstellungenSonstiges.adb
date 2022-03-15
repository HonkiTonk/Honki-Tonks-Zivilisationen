pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GlobaleVariablen;
with SystemKonstanten;

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
               return SystemKonstanten.StartWeiterKonstante;

            when SystemKonstanten.ZufallKonstante =>
               GlobaleVariablen.Schwierigkeitsgrad := ZufallGeneratorenSpieleinstellungen.ZufälligerSchwiewrigkeitsgrad;
               return SystemKonstanten.StartWeiterKonstante;
               
            when SystemKonstanten.ZurückKonstante =>
               return SystemKonstanten.AuswahlRassenKonstante;

            when SystemDatentypen.Hauptmenü_Beenden_Enum'Range =>
               return SchwierigkeitAuswahl;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenSonstiges.SchwierigkeitsgradFestlegen - Ungültige Menüasuwahl.");
         end case;
         
      end loop SchwierigkeitsgradSchleife;
      
   end SchwierigkeitsgradFestlegen;

end SpielEinstellungenSonstiges;
