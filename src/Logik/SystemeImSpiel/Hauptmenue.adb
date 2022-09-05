pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RueckgabeDatentypen; use RueckgabeDatentypen;
with GrafikDatentypen;
with TonDatentypen;
with MenueDatentypen;

with Optionen;
with Spieleinstellungen;
with ImSpiel;
with Laden;
with Auswahlaufteilungen;
with Fehler;
with NachSoundtask;
with NachGrafiktask;
with DatenbankenEditoren;
with NachMusiktask;

package body Hauptmenue is

   procedure Hauptmenü
   is begin
      
      HauptmenüSchleife:
      loop
         
         case
           Auswahlaufteilungen.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Haupt_Menü_Enum)
         is
            when RueckgabeDatentypen.Start_Weiter_Enum =>
               if
                 Spieleinstellungen.Spieleinstellungen (SchnellstartExtern => False) = RueckgabeDatentypen.Spiel_Beenden_Enum
               then
                  exit HauptmenüSchleife;

               else
                  null;
               end if;
               
            when RueckgabeDatentypen.Schnellstart_Enum =>
               if
                 Spieleinstellungen.Spieleinstellungen (SchnellstartExtern => True) = RueckgabeDatentypen.Spiel_Beenden_Enum
               then
                  exit HauptmenüSchleife;

               else
                  null;
               end if;
               
            when RueckgabeDatentypen.Laden_Enum =>
               if
                 Laden.Laden = True
               then
                  case
                    ImSpiel.ImSpiel
                  is
                     when RueckgabeDatentypen.Spiel_Beenden_Enum =>
                        exit HauptmenüSchleife;

                     when others =>
                        null;
                  end case;

               else
                  null;
               end if;
               
            when RueckgabeDatentypen.Optionen_Enum =>
               if
                 Optionen.Optionen = RueckgabeDatentypen.Spiel_Beenden_Enum
               then
                  exit HauptmenüSchleife;

               else
                  null;
               end if;
               
            when RueckgabeDatentypen.Editoren_Enum =>
               if
                 DatenbankenEditoren.DatenbankenEditoren = RueckgabeDatentypen.Spiel_Beenden_Enum
               then
                  exit HauptmenüSchleife;

               else
                  null;
               end if;
               
            when RueckgabeDatentypen.Würdigungen_Enum =>
               null;
               
            when RueckgabeDatentypen.Spiel_Beenden_Enum =>
               exit HauptmenüSchleife;
               
            when RueckgabeDatentypen.Zurück_Enum =>
               null;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "Hauptmenue.Hauptmenü - Ungültige Menüauswahl");
         end case;
         
      end loop HauptmenüSchleife;
      
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Ende_Enum;
      NachMusiktask.AktuelleMusik := TonDatentypen.Musik_Ende_Enum;
      NachSoundtask.AktuellerSound := TonDatentypen.Sound_Ende_Enum;
      
   end Hauptmenü;

end Hauptmenue;
