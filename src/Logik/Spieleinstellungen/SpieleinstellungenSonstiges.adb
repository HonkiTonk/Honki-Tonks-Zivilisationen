pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SpielVariablen;
with MenueDatentypen;

with ZufallsgeneratorenSpieleinstellungen;
with Auswahlaufteilungen;
with Fehler;
with UmwandlungenVerschiedeneDatentypen;

package body SpieleinstellungenSonstiges is

   procedure SchwierigkeitsgradFestlegen
   is begin
      
      SchwierigkeitsgradSchleife:
      loop

         SchwierigkeitAuswahl := Auswahlaufteilungen.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Schwierigkeitsgrad_Menü_Enum);
         
         case
           SchwierigkeitAuswahl
         is
            when RueckgabeDatentypen.Schwierigkeitsgrad_Enum'Range =>
               SpielVariablen.Allgemeines.Schwierigkeitsgrad := UmwandlungenVerschiedeneDatentypen.RückgabeNachSchwierigkeitsgrad (RückgabeExtern => SchwierigkeitAuswahl);

            when RueckgabeDatentypen.Zufall_Enum =>
               SpielVariablen.Allgemeines.Schwierigkeitsgrad := ZufallsgeneratorenSpieleinstellungen.ZufälligerSchwiewrigkeitsgrad;
               
            when RueckgabeDatentypen.Fertig_Enum =>
               return;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenSonstiges.SchwierigkeitsgradFestlegen - Falsche Menüauswahl.");
         end case;
         
      end loop SchwierigkeitsgradSchleife;
      
   end SchwierigkeitsgradFestlegen;

end SpieleinstellungenSonstiges;
