pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleKonstanten;

with OptionenSteuerung, Auswahl, OptionenSound, OptionenGrafik, OptionenSonstiges;

package body Optionen is

   function Optionen return Integer is
   begin

      OptionenSchleife:
      loop

         AuswahlWert := Auswahl.Auswahl (FrageDatei  => GlobaleDatentypen.Leer,
                                         TextDatei   => GlobaleDatentypen.Menü_Auswahl,
                                         FrageZeile  => 0,
                                         ErsteZeile  => GlobaleKonstanten.OptionenErsteZeileKonstante,
                                         LetzteZeile => GlobaleKonstanten.OptionenLetzteZeileKonstante);

         case AuswahlWert is
            when GlobaleKonstanten.ZurückKonstante | GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
               return AuswahlWert;
               
            when 1 => -- Grafik
               OptionenGrafik.OptionenGrafik;
               
            when 2 => -- Sound
               OptionenSound.OptionenSound;
               
            when 3 => -- Steuerung
               OptionenSteuerung.SteuerungBelegen;
               
            when 4 => -- Sonstiges
               RückgabeWert := OptionenSonstiges.Sonstiges;

               case RückgabeWert is
                  when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
                     return RückgabeWert;
                     
                  when others =>
                     null;
               end case;
               
            when others =>
               null;
         end case;

      end loop OptionenSchleife;
      
   end Optionen;

end Optionen;
