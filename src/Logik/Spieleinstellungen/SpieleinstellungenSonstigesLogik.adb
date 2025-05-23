with MenueDatentypen;

with SchreibeAllgemeines;

with ZufallsgeneratorenSpieleinstellungenLogik;
with AuswahlaufteilungLogik;
with MeldungssystemHTSEB;
with UmwandlungenDatentypen;

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
               SchreibeAllgemeines.Schwierigkeitsgrad (SchwierigkeitsgradExtern => UmwandlungenDatentypen.RückgabeNachSchwierigkeitsgrad (RückgabeExtern => SchwierigkeitAuswahl));

            when RueckgabeDatentypen.Auswahl_Vier_Enum =>
               SchreibeAllgemeines.Schwierigkeitsgrad (SchwierigkeitsgradExtern => ZufallsgeneratorenSpieleinstellungenLogik.ZufälligerSchwiewrigkeitsgrad);
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return;
               
            when others =>
               MeldungssystemHTSEB.Logik (MeldungExtern => "SpieleinstellungenSonstigesLogik.SchwierigkeitsgradFestlegen: Falsche Auswahl: " & SchwierigkeitAuswahl'Wide_Wide_Image);
         end case;
         
      end loop SchwierigkeitsgradSchleife;
      
   end SchwierigkeitsgradFestlegen;

end SpieleinstellungenSonstigesLogik;
