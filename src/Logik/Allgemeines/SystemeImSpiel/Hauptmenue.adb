pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RueckgabeDatentypen; use RueckgabeDatentypen;
with GrafikDatentypen;
with TonDatentypen;
with MenueDatentypen;

with Optionen;
with Spieleinstellungen;
with AllesAufAnfangSetzen;
with ImSpiel;
with Laden;
with Wuerdigung;
with AuswahlMenues;
with Fehler;
with InteraktionSoundtask;
with InteraktionGrafiktask;
with DatenbankenEditoren;
with InteraktionMusiktask;

package body Hauptmenue is

   procedure Hauptmenü
   is begin
      
      HauptmenüSchleife:
      loop
         
         case
           AuswahlMenues.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Haupt_Menü_Enum)
         is
            when RueckgabeDatentypen.Start_Weiter_Enum =>
               RückgabeKampagne := Spieleinstellungen.Spieleinstellungen (SchnellstartExtern => False);

               if
                 RückgabeKampagne = RueckgabeDatentypen.Hauptmenü_Enum
                 or
                   RückgabeKampagne = RueckgabeDatentypen.Zurück_Enum
               then
                  AllesAufAnfangSetzen.AllesAufAnfangSetzen;

               elsif
                 RückgabeKampagne = RueckgabeDatentypen.Spiel_Beenden_Enum
               then
                  exit HauptmenüSchleife;

               else
                  null;
               end if;
               
            when RueckgabeDatentypen.Schnellstart_Enum =>
               RückgabeKampagne := Spieleinstellungen.Spieleinstellungen (SchnellstartExtern => True);

               if
                 RückgabeKampagne = RueckgabeDatentypen.Hauptmenü_Enum
                 or
                   RückgabeKampagne = RueckgabeDatentypen.Zurück_Enum
               then
                  AllesAufAnfangSetzen.AllesAufAnfangSetzen;

               elsif
                 RückgabeKampagne = RueckgabeDatentypen.Spiel_Beenden_Enum
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
                     when RueckgabeDatentypen.Hauptmenü_Enum =>
                        AllesAufAnfangSetzen.AllesAufAnfangSetzen;

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
               Wuerdigung.Würdigung;
               
            when RueckgabeDatentypen.Spiel_Beenden_Enum =>
               exit HauptmenüSchleife;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "Hauptmenue.Hauptmenü - Keine gültige Menüauswahl");
         end case;
         
      end loop HauptmenüSchleife;
      
      InteraktionGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Ende_Enum;
      InteraktionMusiktask.AktuelleMusik := TonDatentypen.Musik_Ende_Enum;
      InteraktionSoundtask.AktuellerSound := TonDatentypen.Sound_Ende_Enum;
      
   end Hauptmenü;

end Hauptmenue;
