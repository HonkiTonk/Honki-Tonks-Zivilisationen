pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SpielVariablen;
with MenueDatentypen;

with ZufallsgeneratorenSpieleinstellungenLogik;
with AuswahlaufteilungLogik;
with Fehler;
with UmwandlungenVerschiedeneDatentypen;

package body SpieleinstellungenSonstigesLogik is

   procedure SchwierigkeitsgradFestlegen
   is begin
      
      SchwierigkeitsgradSchleife:
      loop

         SchwierigkeitAuswahl := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Schwierigkeitsgrad_Menü_Enum);
         
         case
           SchwierigkeitAuswahl
         is
            when RueckgabeDatentypen.Schwierigkeitsgrad_Enum'Range =>
               SpielVariablen.Allgemeines.Schwierigkeitsgrad := UmwandlungenVerschiedeneDatentypen.RückgabeNachSchwierigkeitsgrad (RückgabeExtern => SchwierigkeitAuswahl);

            when RueckgabeDatentypen.Auswahl_Vier_Enum =>
               SpielVariablen.Allgemeines.Schwierigkeitsgrad := ZufallsgeneratorenSpieleinstellungenLogik.ZufälligerSchwiewrigkeitsgrad;
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenSonstiges.SchwierigkeitsgradFestlegen: Falsche Auswahl: " & SchwierigkeitAuswahl'Wide_Wide_Image);
         end case;
         
      end loop SchwierigkeitsgradSchleife;
      
   end SchwierigkeitsgradFestlegen;

end SpieleinstellungenSonstigesLogik;
