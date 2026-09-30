with MenueDatentypen;

with OptionenSteuerungLogik;
with OptionenSoundLogik;
with OptionenGrafikLogik;
with OptionenSonstigesLogik;
with AuswahlaufteilungLogik;
with MeldungssystemHTSEB;

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
            when Grafik =>
               RückgabeWert := OptionenGrafikLogik.OptionenGrafik;
               
            when Sound =>
               RückgabeWert := OptionenSoundLogik.OptionenSound;
               
            when Steuerung =>
               RückgabeWert := OptionenSteuerungLogik.SteuerungBelegen;
               
            when Sonstiges =>
               RückgabeWert := OptionenSonstigesLogik.Sonstiges;
               
            when RueckgabeDatentypen.Zurück_Beenden_Enum'Range =>
               return AuswahlWert;
               
            when others =>
               MeldungssystemHTSEB.Logik (MeldungExtern => "OptionenLogik.Optionen: Falsche Auswahl: " & AuswahlWert'Wide_Wide_Image);
         end case;

         case
           RückgabeWert
         is
            when RueckgabeDatentypen.Spiel_Beenden_Enum | RueckgabeDatentypen.Hauptmenü_Enum =>
               return RückgabeWert;
               
            when RueckgabeDatentypen.Zurück_Enum =>
               null;
                     
            when others =>
               MeldungssystemHTSEB.Logik (MeldungExtern => "OptionenLogik.Optionen: Falsche Rückgabe: " & RückgabeWert'Wide_Wide_Image);
         end case;

      end loop OptionenSchleife;
      
   end Optionen;

end OptionenLogik;
