pragma SPARK_Mode (On);

with GlobaleDatentypen;

with OptionenSteuerung, Auswahl, OptionenSound, OptionenGrafik, OptionenSonstiges;

package body Optionen is

   procedure Optionen is
   begin

      OptionenSchleife:
      loop

         AuswahlWert := Auswahl.Auswahl (FrageDatei  => GlobaleDatentypen.Leer,
                                         TextDatei   => GlobaleDatentypen.Menü_Auswahl,
                                         FrageZeile  => 0,
                                         ErsteZeile  => 14,
                                         LetzteZeile => 18);

         case AuswahlWert is
            when 1 => -- Grafik
               OptionenGrafik.OptionenGrafik;
               
            when 2 => -- Sound
               OptionenSound.OptionenSound;
               
            when 3 => -- Steuerung
               OptionenSteuerung.SteuerungBelegen;
               
            when 4 => -- Sonstiges
               RückgabeWert := OptionenSonstiges.Sonstiges;

               case RückgabeWert is
                  when 0 =>
                     return;
                     
                  when others =>
                     null;
               end case;
               
            when others =>
               return;
         end case;

      end loop OptionenSchleife;
      
   end Optionen;

end Optionen;
