pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleKonstanten;

with Auswahl, Optionen, SpielEinstellungen, AllesAufAnfangSetzen, Informationen, ImSpiel, Laden, Wuerdigung;

package body Hauptmenue is

   procedure Hauptmenü is
   begin
      
      HauptmenüSchleife:
      loop

         Startauswahl := Auswahl.Auswahl (FrageDateiExtern  => GlobaleDatentypen.Start,
                                          TextDateiExtern   => GlobaleDatentypen.Start,
                                          FrageZeileExtern  => 1,
                                          ErsteZeileExtern  => 2,
                                          LetzteZeileExtern => 6);

         case
           Startauswahl
         is
            when GlobaleKonstanten.StartNormalKonstante => -- Start
               RückgabeKampagne := SpielEinstellungen.SpielEinstellungen;

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

            when GlobaleKonstanten.LadenKonstante => -- Laden
               LadenErfolgreich := Laden.LadenNeu;

               case
                 LadenErfolgreich
               is
                  when True =>
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

                  when False =>
                     null;
               end case;

            when GlobaleKonstanten.OptionenKonstante => -- Optionen
               RückgabeOptionen := Optionen.Optionen;
               case
                 RückgabeOptionen
               is
                  when GlobaleKonstanten.SpielBeendenKonstante =>
                     exit HauptmenüSchleife;

                  when others =>
                     null;
               end case;

            when GlobaleKonstanten.InformationenKonstante => -- Informationen
               Informationen.Informationen;

            when 10 => -- Wuerdigung
               Wuerdigung.Wuerdigung;

            when GlobaleKonstanten.SpielBeendenKonstante => -- Beenden
               exit HauptmenüSchleife;

            when others =>
               null;
         end case;

      end loop HauptmenüSchleife;
      
   end Hauptmenü;

end Hauptmenue;
