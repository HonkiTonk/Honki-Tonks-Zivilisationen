with MeldungssystemHTSEB;

with UmwandlungenDatentypen;
with MenueDatentypen;

with AuswahlaufteilungLogik;
with KartengeneratorVariablenLogik;
with ZufallsgeneratorenSpieleinstellungenLogik;

package body KartenrohstoffeEinstellenLogik is

   procedure Kartenrohstoffe
   is begin
      
      KartenrohstoffeSchleife:
      loop

         KartenrohstoffeAuswahl := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Kartenrohstoffe_Menü_Enum);
         
         case
           KartenrohstoffeAuswahl
         is
            when RueckgabeDatentypen.Kartenrohstoffe_Enum'Range =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartenrohstoffe := UmwandlungenDatentypen.KartenrohstofferückgabeNachKartenRohstoff (RückgabeExtern => KartenrohstoffeAuswahl);
               
            when RueckgabeDatentypen.Auswahl_Fünf_Enum =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartenrohstoffe := ZufallsgeneratorenSpieleinstellungenLogik.ZufälligeKartenrohstoffe;
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return;
               
            when others =>
               MeldungssystemHTSEB.Logik (MeldungExtern => "KartenrohstoffeEinstellenLogik.Kartenrohstoffe: Falsche Auswahl: " & KartenrohstoffeAuswahl'Wide_Wide_Image);
         end case;
         
      end loop KartenrohstoffeSchleife;
      
   end Kartenrohstoffe;

end KartenrohstoffeEinstellenLogik;
