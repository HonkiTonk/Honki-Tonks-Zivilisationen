pragma SPARK_Mode (On);

with GlobaleTexte;
with SystemKonstanten;
with SystemDatentypen;

with Auswahl;
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
               null;
               
            when others =>
               null;
         end case;

         case
           Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Start,
                            TextDateiExtern   => GlobaleTexte.Start,
                            FrageZeileExtern  => 1,
                            ErsteZeileExtern  => 2,
                            LetzteZeileExtern => 7)
         is
            -- Start
            when SystemKonstanten.StartNormalKonstante =>
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

               -- Laden
            when SystemKonstanten.LadenKonstante =>
               if
                 Laden.LadenNeu = True
               then
                  RückgabeKampagne := ImSpiel.ImSpiel;
                  case
                    RückgabeKampagne
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

               -- Optionen
            when SystemKonstanten.OptionenKonstante =>
               RückgabeOptionen := Optionen.Optionen;
               if
                 RückgabeOptionen = SystemKonstanten.SpielBeendenKonstante
               then
                  exit HauptmenüSchleife;

               else
                  null;
               end if;

               -- Informationen
            when SystemKonstanten.InformationenKonstante =>
               Informationen.Informationen;

               -- Wuerdigung
            when SystemKonstanten.WürdigungenKonstante =>
               Wuerdigung.Wuerdigung;

               -- Beenden
            when SystemKonstanten.SpielBeendenKonstante =>
               exit HauptmenüSchleife;

            when others =>
               null;
         end case;

      end loop HauptmenüSchleife;

   end Hauptmenü;

end Hauptmenue;
