with MenueDatentypen;

with OptionenSteuerungLogik;
with OptionenSoundLogik;
with OptionenGrafikLogik;
with OptionenSonstigesLogik;
with AuswahlaufteilungLogik;
with Fehlermeldungssystem;

package body OptionenLogik is

   function Optionen
     return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin

      OptionenSchleife:
      loop
         
         AuswahlWert := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Optionen_Menü_Enum);

         case
           AuswahlWert
         is
            when RueckgabeDatentypen.Auswahl_Eins_Enum =>
               RückgabeWert := OptionenGrafikLogik.OptionenGrafik;
               
            when RueckgabeDatentypen.Auswahl_Zwei_Enum =>
               RückgabeWert := OptionenSoundLogik.OptionenSound;
               
            when RueckgabeDatentypen.Auswahl_Drei_Enum =>
               RückgabeWert := OptionenSteuerungLogik.SteuerungBelegen;
               
            when RueckgabeDatentypen.Auswahl_Vier_Enum =>
               RückgabeWert := OptionenSonstigesLogik.Sonstiges;
               
            when RueckgabeDatentypen.Zurück_Beenden_Enum'Range =>
               return AuswahlWert;
               
            when others =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "OptionenLogik.Optionen: Falsche Auswahl: " & AuswahlWert'Wide_Wide_Image);
         end case;

         case
           RückgabeWert
         is
            when RueckgabeDatentypen.Spiel_Beenden_Enum | RueckgabeDatentypen.Hauptmenü_Enum =>
               return RückgabeWert;
               
            when RueckgabeDatentypen.Zurück_Enum =>
               null;
                     
            when others =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "OptionenLogik.Optionen: Falsche Rückgabe: " & RückgabeWert'Wide_Wide_Image);
         end case;

      end loop OptionenSchleife;
      
   end Optionen;

end OptionenLogik;
