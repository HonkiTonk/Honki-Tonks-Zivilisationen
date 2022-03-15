pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemKonstanten;

with OptionenSteuerung;
with OptionenSound;
with OptionenGrafik;
with OptionenSonstiges;
with AuswahlMenue;
with Fehler;

package body Optionen is

   function Optionen
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin

      OptionenSchleife:
      loop
         
         AuswahlWert := AuswahlMenue.AuswahlMenü (WelchesMenüExtern => SystemDatentypen.Optionen_Menü);

         case
           AuswahlWert
         is
            when SystemKonstanten.GrafikKonstante =>
               RückgabeWert := OptionenGrafik.OptionenGrafik;
               
            when SystemKonstanten.SoundKonstante =>
               RückgabeWert := OptionenSound.OptionenSound;
               
            when SystemKonstanten.SteuerungKonstante =>
               RückgabeWert := OptionenSteuerung.SteuerungBelegen;
               
            when SystemKonstanten.SonstigesKonstante =>
               RückgabeWert := OptionenSonstiges.Sonstiges;
               
            when SystemKonstanten.ZurückKonstante | SystemKonstanten.SpielBeendenKonstante | SystemKonstanten.HauptmenüKonstante =>
               return AuswahlWert;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "Optionen.Optionen - Ungültige Menüauswahl.");
         end case;

         case
           RückgabeWert
         is
            when SystemKonstanten.SpielBeendenKonstante | SystemKonstanten.HauptmenüKonstante =>
               return RückgabeWert;
               
            when SystemKonstanten.ZurückKonstante =>
               null;
                     
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "Optionen.Optionen - Ungültiger Rückgabewert.");
         end case;

      end loop OptionenSchleife;
      
   end Optionen;

end Optionen;
