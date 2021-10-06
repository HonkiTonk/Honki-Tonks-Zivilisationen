pragma SPARK_Mode (On);

with GlobaleTexte;
with SystemKonstanten;

with OptionenSteuerung;
with Auswahl;
with OptionenSound;
with OptionenGrafik;
with OptionenSonstiges;

package body Optionen is

   function Optionen
     return Integer
   is begin
      
      RückgabeWert := 1_000;

      OptionenSchleife:
      loop

         AuswahlWert := Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Leer,
                                         TextDateiExtern   => GlobaleTexte.Menü_Auswahl,
                                         FrageZeileExtern  => 0,
                                         ErsteZeileExtern  => SystemKonstanten.OptionenErsteZeileKonstante,
                                         LetzteZeileExtern => SystemKonstanten.OptionenLetzteZeileKonstante);

         case
           AuswahlWert
         is
            when SystemKonstanten.ZurückKonstante | SystemKonstanten.SpielBeendenKonstante | SystemKonstanten.HauptmenüKonstante =>
               return AuswahlWert;
               
               -- Grafik
            when 1 =>
               RückgabeWert := OptionenGrafik.OptionenGrafik;
               
               -- Sound
            when 2 =>
               RückgabeWert := OptionenSound.OptionenSound;
               
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
            when SystemKonstanten.SpielBeendenKonstante | SystemKonstanten.HauptmenüKonstante =>
               return RückgabeWert;
                     
            when others =>
               null;
         end case;

      end loop OptionenSchleife;
      
   end Optionen;

end Optionen;
