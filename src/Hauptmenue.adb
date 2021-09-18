pragma SPARK_Mode (On);

with GlobaleKonstanten, GlobaleTexte;

with Auswahl, Optionen, SpielEinstellungen, AllesAufAnfangSetzen, Informationen, ImSpiel, Laden, Wuerdigung;

package body Hauptmenue is

   procedure Hauptmenü
   is begin
      
      HauptmenüSchleife:
      loop

         case
           Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Start,
                            TextDateiExtern   => GlobaleTexte.Start,
                            FrageZeileExtern  => 1,
                            ErsteZeileExtern  => 2,
                            LetzteZeileExtern => 7)
         is
            -- Start
            when GlobaleKonstanten.StartNormalKonstante =>
               RückgabeKampagne := SpielEinstellungen.SpielEinstellungenAuswahl;

               if
                 RückgabeKampagne = GlobaleKonstanten.HauptmenüKonstante
               then
                  AllesAufAnfangSetzen.AllesAufAnfangSetzen;

               elsif
                 RückgabeKampagne = GlobaleKonstanten.SpielBeendenKonstante
               then
                  exit HauptmenüSchleife;

               else
                  null;
               end if;

               -- Laden
            when GlobaleKonstanten.LadenKonstante =>
               if
                 Laden.LadenNeu = True
               then
                  RückgabeKampagne := ImSpiel.ImSpiel;
                  case
                    RückgabeKampagne
                  is
                     when GlobaleKonstanten.HauptmenüKonstante =>
                        AllesAufAnfangSetzen.AllesAufAnfangSetzen;

                     when GlobaleKonstanten.SpielBeendenKonstante =>
                        exit HauptmenüSchleife;

                     when others =>
                        null;
                  end case;

               else
                  null;
               end if;

               -- Optionen
            when GlobaleKonstanten.OptionenKonstante =>
               RückgabeOptionen := Optionen.Optionen;
               if
                 RückgabeOptionen = GlobaleKonstanten.SpielBeendenKonstante
               then
                  exit HauptmenüSchleife;

               else
                  null;
               end if;

               -- Informationen
            when GlobaleKonstanten.InformationenKonstante =>
               Informationen.Informationen;

               -- Wuerdigung
            when GlobaleKonstanten.WürdigungenKonstante =>
               Wuerdigung.Wuerdigung;

               -- Beenden
            when GlobaleKonstanten.SpielBeendenKonstante =>
               exit HauptmenüSchleife;

            when others =>
               null;
         end case;

      end loop HauptmenüSchleife;

   end Hauptmenü;

end Hauptmenue;
