with MeldungssystemHTSEB;

with GrafikDatentypen;
with TonDatentypen;
with MenueDatentypen;

with SchreibeMusiktask;
with SchreibeSoundtask;
with SchreibeGrafiktask;

with OptionenLogik;
with SpieleinstellungenLogik;
with SpielLogik;
with LadenLogik;
with AuswahlaufteilungLogik;
with DatenbankeneditorenLogik;

package body HauptmenueLogik is

   procedure Hauptmenü
   is
      use type RueckgabeDatentypen.Rückgabe_Werte_Enum;
   begin
      
      HauptmenüSchleife:
      loop
         
         RückgabeAuswahl := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Haupt_Menü_Enum);
         
         case
           RückgabeAuswahl
         is
            when StartWeiter =>
               if
                 SpieleinstellungenLogik.Spieleinstellungen (SchnellstartExtern => False) = RueckgabeDatentypen.Spiel_Beenden_Enum
               then
                  exit HauptmenüSchleife;

               else
                  null;
               end if;
               
            when Schnellstart =>
               if
                 SpieleinstellungenLogik.Spieleinstellungen (SchnellstartExtern => True) = RueckgabeDatentypen.Spiel_Beenden_Enum
               then
                  exit HauptmenüSchleife;

               else
                  null;
               end if;
               
            when Laden =>
               if
                 LadenLogik.Laden = True
               then
                  case
                    SpielLogik.Spiel
                  is
                     when RueckgabeDatentypen.Spiel_Beenden_Enum =>
                        exit HauptmenüSchleife;

                     when others =>
                        null;
                  end case;

               else
                  null;
               end if;
               
            when Optionen =>
               if
                 OptionenLogik.Optionen = RueckgabeDatentypen.Spiel_Beenden_Enum
               then
                  exit HauptmenüSchleife;

               else
                  null;
               end if;
               
            when Editoren =>
               if
                 DatenbankeneditorenLogik.DatenbankenEditoren = RueckgabeDatentypen.Spiel_Beenden_Enum
               then
                  exit HauptmenüSchleife;

               else
                  null;
               end if;
               
            when Würdigungen =>
               null;
               
            when RueckgabeDatentypen.Spiel_Beenden_Enum =>
               exit HauptmenüSchleife;
               
            when RueckgabeDatentypen.Zurück_Enum =>
               null;
               
            when others =>
               MeldungssystemHTSEB.Logik (MeldungExtern => "HauptmenueLogik.Hauptmenü: Ungültige Menüauswahl: " & RückgabeAuswahl'Wide_Wide_Image);
         end case;
         
      end loop HauptmenüSchleife;
      
      SchreibeGrafiktask.Darstellung (DarstellungExtern => GrafikDatentypen.Ende_Enum);
      SchreibeMusiktask.AktuelleMusikart (MusikExtern => TonDatentypen.Musik_Ende_Enum);
      SchreibeSoundtask.SoundStarten (SoundExtern => TonDatentypen.Sound_Ende_Enum);
      
   end Hauptmenü;

end HauptmenueLogik;
