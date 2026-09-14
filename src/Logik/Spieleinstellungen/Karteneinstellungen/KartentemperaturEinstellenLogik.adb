with MeldungssystemHTSEB;

with UmwandlungenDatentypen;
with MenueDatentypen;

with AuswahlaufteilungLogik;
with KartengeneratorVariablenLogik;
with ZufallsgeneratorenSpieleinstellungenLogik;

package body KartentemperaturEinstellenLogik is

   -- Temperatur durch was anderes ersetzen, was mehr über die Kartenbeschaffenheit aussagt. äöü
   -- Oder drinnen lassen und weitere Einstellmöglichkeiten wie Gebirgigkeit einbauen? äöü
   procedure Kartentemperatur
   is begin
            
      KartentemperaturSchleife:
      loop

         KartentemperaturAuswahl := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Kartentemperatur_Menü_Enum);
                  
         case
           KartentemperaturAuswahl
         is
            when RueckgabeDatentypen.Kartentemperatur_Enum'Range =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartentemperatur := UmwandlungenDatentypen.KartentemperaturrückgabeNachKartentemperatur (RückgabeExtern => KartentemperaturAuswahl);
               
            when RueckgabeDatentypen.Auswahl_Sechs_Enum =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartentemperatur := ZufallsgeneratorenSpieleinstellungenLogik.ZufälligeKartentemperatur;
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return;
               
            when others =>
               MeldungssystemHTSEB.Logik (MeldungExtern => "KartentemperaturEinstellenLogik.Kartentemperatur: Falsche Auswahl: " & KartentemperaturAuswahl'Wide_Wide_Image);
         end case;
         
      end loop KartentemperaturSchleife;
      
   end Kartentemperatur;

end KartentemperaturEinstellenLogik;
