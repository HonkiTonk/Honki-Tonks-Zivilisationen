with MenueDatentypen;

with SchreibeAllgemeines;

with ZufallsgeneratorenSpieleinstellungenLogik;
with AuswahlaufteilungLogik;
with MeldungssystemHTSEB;
with UmwandlungenDatentypen;

package body SchwierigkeitsgradEinstellenLogik is

   procedure Schwierigkeitsgrad
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
               MeldungssystemHTSEB.Logik (MeldungExtern => "SchwierigkeitsgradEinstellenLogik.Schwierigkeitsgrad: Falsche Auswahl: " & SchwierigkeitAuswahl'Wide_Wide_Image);
         end case;
         
      end loop SchwierigkeitsgradSchleife;
      
   end Schwierigkeitsgrad;

end SchwierigkeitsgradEinstellenLogik;
