with MenueDatentypen;

with SchreibeAllgemeines;

with OptionenLogik;
with SpeichernLogik;
with LadenLogik;
with AuswahlaufteilungLogik;
with MeldungssystemHTSEB;

package body SpielmenueLogik is

   function Spielmenü
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      SpielmenüSchleife:
      loop
         
         AuswahlSpielmenü := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Spiel_Menü_Enum);

         case
           AuswahlSpielmenü
         is
            when Speichern =>
               SchreibeAllgemeines.SpezieszugNachLaden (SpeziesExtern => SpeziesExtern);
               SpeichernLogik.Speichern (AutospeichernExtern    => False,
                                         NotfallspeichernExtern => False);
               
            when Laden =>
               if
                 LadenLogik.Laden = True
               then
                  return Laden;

               else
                  null;
               end if;
               
            when Optionen =>
               RückgabeOptionen := OptionenLogik.Optionen;
               
               if
                 RückgabeOptionen in RueckgabeDatentypen.Hauptmenü_Beenden_Enum'Range
               then
                  return RückgabeOptionen;
                  
               else
                  null;
               end if;
               
            when RueckgabeDatentypen.Zurück_Beenden_Enum'Range | Weiter =>
               return AuswahlSpielmenü;
                  
            when others =>
               MeldungssystemHTSEB.Logik (MeldungExtern => "SpielmenueLogik.Spielmenü: Falsche Rückgabe: " & AuswahlSpielmenü'Wide_Wide_Image);
         end case;
      
      end loop SpielmenüSchleife;
   
   end Spielmenü;

end SpielmenueLogik;
