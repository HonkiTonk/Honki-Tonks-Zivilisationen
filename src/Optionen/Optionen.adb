pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleKonstanten;

with OptionenSteuerung, Auswahl, OptionenSound, OptionenGrafik, OptionenSonstiges;

package body Optionen is

   function Optionen return Integer is
   begin
      
      RückgabeWert := 1_000;

      OptionenSchleife:
      loop

         AuswahlWert := Auswahl.Auswahl (FrageDateiExtern  => GlobaleDatentypen.Leer,
                                         TextDateiExtern   => GlobaleDatentypen.Menü_Auswahl,
                                         FrageZeileExtern  => 0,
                                         ErsteZeileExtern  => GlobaleKonstanten.OptionenErsteZeileKonstante,
                                         LetzteZeileExtern => GlobaleKonstanten.OptionenLetzteZeileKonstante);

         case
           AuswahlWert
         is
            when GlobaleKonstanten.ZurückKonstante | GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
               return AuswahlWert;
               
                -- Grafik
            when 1 =>
               OptionenGrafik.OptionenGrafik;
               
                -- Sound
            when 2 =>
               OptionenSound.OptionenSound;
               
                -- Steuerung
            when 3 =>
               RückgabeWert := OptionenSteuerung.SteuerungBelegen;
               
                -- Sonstiges
            when 4 =>
               RückgabeWert := OptionenSonstiges.Sonstiges;               
            when others =>
               null;
         end case;

         case
           RückgabeWert
         is
            when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
               return RückgabeWert;
                     
            when others =>
               null;
         end case;

      end loop OptionenSchleife;
      
   end Optionen;

end Optionen;
