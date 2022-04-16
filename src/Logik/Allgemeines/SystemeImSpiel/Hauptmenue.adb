pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RueckgabeDatentypen; use RueckgabeDatentypen;
with SystemDatentypen;
with GrafikDatentypen;
with TonDatentypen;

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
           AuswahlMenues.AuswahlMenüsAufteilung (WelchesMenüExtern => SystemDatentypen.Haupt_Menü_Enum)
         is
            when RueckgabeDatentypen.Start_Weiter_Enum =>
               RückgabeKampagne := Spieleinstellungen.Spieleinstellungen;

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
                 Laden.LadenNeu = True
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
               
            -- when SystemDatentypen.Informationen_Enum =>
            --   Informationen.Informationen;
               
            when RueckgabeDatentypen.Würdigungen_Enum =>
               Wuerdigung.Würdigung;
               
            when RueckgabeDatentypen.Spiel_Beenden_Enum =>
               exit HauptmenüSchleife;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "Hauptmenue.Hauptmenü - Keine gültige Menüauswahl");
         end case;
         
      end loop HauptmenüSchleife;
      
      InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => GrafikDatentypen.Grafik_Ende_Enum);
      InteraktionMusiktask.AktuelleMusik := TonDatentypen.Musik_Ende_Enum;
      InteraktionSoundtask.AktuellenSoundÄndern (SoundExtern => TonDatentypen.Sound_Ende_Enum);
      
   end Hauptmenü;

end Hauptmenue;
