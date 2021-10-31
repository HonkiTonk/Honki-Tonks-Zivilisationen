pragma SPARK_Mode (On);

with SystemKonstanten;
with SystemDatentypen;

with Optionen;
with SpielEinstellungen;
with AllesAufAnfangSetzen;
with Informationen;
with ImSpiel;
with Laden;
with Wuerdigung;
with AuswahlMenue;

package body Hauptmenue is

   procedure Hauptmenü
   is begin
      
      HauptmenüSchleife:
      loop
         
         case
           AuswahlMenue.AuswahlMenü (WelchesMenüExtern => SystemDatentypen.Hauptmenü)
         is
            when SystemDatentypen.Start_Weiter =>
               RückgabeKampagne := SpielEinstellungen.SpielEinstellungenAuswahl;

               if
                 RückgabeKampagne = SystemKonstanten.HauptmenüKonstante
               then
                  AllesAufAnfangSetzen.AllesAufAnfangSetzen;

               elsif
                 RückgabeKampagne = SystemKonstanten.SpielBeendenKonstante
               then
                  exit HauptmenüSchleife;

               else
                  null;
               end if;
               
            when SystemDatentypen.Laden =>
               if
                 Laden.LadenNeu = True
               then
                  case
                    ImSpiel.ImSpiel
                  is
                     when SystemKonstanten.HauptmenüKonstante =>
                        AllesAufAnfangSetzen.AllesAufAnfangSetzen;

                     when SystemKonstanten.SpielBeendenKonstante =>
                        exit HauptmenüSchleife;

                     when others =>
                        null;
                  end case;

               else
                  null;
               end if;
               
            when SystemDatentypen.Optionen =>
               if
                 Optionen.Optionen = SystemKonstanten.SpielBeendenKonstante
               then
                  exit HauptmenüSchleife;

               else
                  null;
               end if;
               
            when SystemDatentypen.Informationen =>
               Informationen.Informationen;
               
            when SystemDatentypen.Würdigungen =>
               Wuerdigung.Wuerdigung;
               
            when SystemDatentypen.Spiel_Beenden =>
               exit HauptmenüSchleife;
               
            when SystemDatentypen.Leer =>
               null;
               
            when others =>
               raise Program_Error;
         end case;

      end loop HauptmenüSchleife;

   end Hauptmenü;

end Hauptmenue;
