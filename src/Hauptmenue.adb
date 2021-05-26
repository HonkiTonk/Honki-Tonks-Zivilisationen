pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleKonstanten;

with Auswahl, Optionen, SpielEinstellungen, AllesAufAnfangSetzen, Informationen, ImSpiel, Laden, Wuerdigung;

package body Hauptmenue with
Refined_State => (HauptmenüAbstraktion => (RückgabeKampagne, RückgabeOptionen))
is

   procedure Hauptmenü
   is begin
      
      HauptmenüSchleife:
      loop

         case
           Auswahl.Auswahl (FrageDateiExtern  => GlobaleDatentypen.Start,
                            TextDateiExtern   => GlobaleDatentypen.Start,
                            FrageZeileExtern  => 1,
                            ErsteZeileExtern  => 2,
                            LetzteZeileExtern => 6)
         is
            when GlobaleKonstanten.StartNormalKonstante => -- Start
               RückgabeKampagne := SpielEinstellungen.SpielEinstellungen;

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

            when GlobaleKonstanten.LadenKonstante => -- Laden
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

            when GlobaleKonstanten.OptionenKonstante => -- Optionen
               RückgabeOptionen := Optionen.Optionen;
               if
                 RückgabeOptionen = GlobaleKonstanten.SpielBeendenKonstante
               then
                  exit HauptmenüSchleife;

               else
                  null;
               end if;

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
