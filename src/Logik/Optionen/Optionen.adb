pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with OptionenSteuerung;
with OptionenSound;
with OptionenGrafik;
with OptionenSonstiges;
with AuswahlMenues;
with Fehler;

package body Optionen is

   function Optionen
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin

      OptionenSchleife:
      loop
         
         AuswahlWert := AuswahlMenues.AuswahlMenüsAufteilung (WelchesMenüExtern => SystemDatentypen.Optionen_Menü_Enum);

         case
           AuswahlWert
         is
            when SystemDatentypen.Grafik_Enum =>
               RückgabeWert := OptionenGrafik.OptionenGrafik;
               
            when SystemDatentypen.Sound_Enum =>
               RückgabeWert := OptionenSound.OptionenSound;
               
            when SystemDatentypen.Steuerung_Enum =>
               RückgabeWert := OptionenSteuerung.SteuerungBelegen;
               
            when SystemDatentypen.Sonstiges_Enum =>
               RückgabeWert := OptionenSonstiges.Sonstiges;
               
            when SystemDatentypen.Zurück_Enum | SystemDatentypen.Spiel_Beenden_Enum | SystemDatentypen.Hauptmenü_Enum =>
               return AuswahlWert;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "Optionen.Optionen - Ungültige Menüauswahl.");
         end case;

         case
           RückgabeWert
         is
            when SystemDatentypen.Spiel_Beenden_Enum | SystemDatentypen.Hauptmenü_Enum =>
               return RückgabeWert;
               
            when SystemDatentypen.Zurück_Enum =>
               null;
                     
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "Optionen.Optionen - Ungültiger Rückgabewert.");
         end case;

      end loop OptionenSchleife;
      
   end Optionen;

end Optionen;
