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
            when RueckgabeDatentypen.Speichern_Enum =>
               SchreibeAllgemeines.SpeziesAmzugNachLaden (SpeziesExtern => SpeziesExtern);
               SpeichernLogik.Speichern (AutospeichernExtern    => False,
                                         NotfallspeichernExtern => False);
               
            when RueckgabeDatentypen.Laden_Enum =>
               if
                 LadenLogik.Laden = True
               then
                  return RueckgabeDatentypen.Laden_Enum;

               else
                  null;
               end if;
               
            when RueckgabeDatentypen.Optionen_Enum =>
               RückgabeOptionen := OptionenLogik.Optionen;
               
               if
                 RückgabeOptionen in RueckgabeDatentypen.Hauptmenü_Beenden_Enum'Range
               then
                  return RückgabeOptionen;
                  
               else
                  null;
               end if;
               
            when RueckgabeDatentypen.Hauptmenü_Beenden_Enum'Range | RueckgabeDatentypen.Start_Weiter_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return AuswahlSpielmenü;
                  
            when others =>
               MeldungssystemHTSEB.Logik (MeldungExtern => "SpielmenueLogik.Spielmenü: Falsche Rückgabe: " & AuswahlSpielmenü'Wide_Wide_Image);
         end case;
      
      end loop SpielmenüSchleife;
   
   end Spielmenü;

end SpielmenueLogik;
