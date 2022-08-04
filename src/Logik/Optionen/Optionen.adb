pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with MenueDatentypen;

with OptionenSteuerung;
with OptionenSound;
with OptionenGrafik;
with OptionenSonstiges;
with AuswahlMenues;
with Fehler;

package body Optionen is

   function Optionen
     return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin

      OptionenSchleife:
      loop
         
         AuswahlWert := AuswahlMenues.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Optionen_Menü_Enum);

         case
           AuswahlWert
         is
            when RueckgabeDatentypen.Grafik_Enum =>
               RückgabeWert := OptionenGrafik.OptionenGrafik;
               
            when RueckgabeDatentypen.Sound_Enum =>
               RückgabeWert := OptionenSound.OptionenSound;
               
            when RueckgabeDatentypen.Steuerung_Enum =>
               RückgabeWert := OptionenSteuerung.SteuerungBelegen;
               
            when RueckgabeDatentypen.Sonstiges_Enum =>
               RückgabeWert := OptionenSonstiges.Sonstiges;
               
            when RueckgabeDatentypen.Spiel_Beenden_Enum | RueckgabeDatentypen.Hauptmenü_Enum =>
               return AuswahlWert;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "Optionen.Optionen - Falsche Menüauswahl.");
         end case;

         case
           RückgabeWert
         is
            when RueckgabeDatentypen.Spiel_Beenden_Enum | RueckgabeDatentypen.Hauptmenü_Enum =>
               return RückgabeWert;
               
            when RueckgabeDatentypen.Zurück_Enum =>
               null;
                     
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "Optionen.Optionen - Falscher Rückgabewert.");
         end case;

      end loop OptionenSchleife;
      
   end Optionen;

end Optionen;
