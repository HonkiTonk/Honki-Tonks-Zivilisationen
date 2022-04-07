pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with GrafikTonDatentypen;

with Optionen;
with SpielEinstellungen;
with AllesAufAnfangSetzen;
with ImSpiel;
with Laden;
with Wuerdigung;
with AuswahlMenue;
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
           AuswahlMenue.AuswahlMenü (WelchesMenüExtern => SystemDatentypen.Haupt_Menü_Enum)
         is
            when SystemDatentypen.Start_Weiter_Enum =>
               RückgabeKampagne := SpielEinstellungen.SpielEinstellungenAuswahl;

               if
                 RückgabeKampagne = SystemDatentypen.Hauptmenü_Enum
                 or
                   RückgabeKampagne = SystemDatentypen.Zurück_Enum
               then
                  AllesAufAnfangSetzen.AllesAufAnfangSetzen;

               elsif
                 RückgabeKampagne = SystemDatentypen.Spiel_Beenden_Enum
               then
                  exit HauptmenüSchleife;

               else
                  null;
               end if;
               
            when SystemDatentypen.Laden_Enum =>
               if
                 Laden.LadenNeu = True
               then
                  case
                    ImSpiel.ImSpiel
                  is
                     when SystemDatentypen.Hauptmenü_Enum =>
                        AllesAufAnfangSetzen.AllesAufAnfangSetzen;

                     when SystemDatentypen.Spiel_Beenden_Enum =>
                        exit HauptmenüSchleife;

                     when others =>
                        null;
                  end case;

               else
                  null;
               end if;
               
            when SystemDatentypen.Optionen_Enum =>
               if
                 Optionen.Optionen = SystemDatentypen.Spiel_Beenden_Enum
               then
                  exit HauptmenüSchleife;

               else
                  null;
               end if;
               
            when SystemDatentypen.Editoren_Enum =>
               if
                 DatenbankenEditoren.DatenbankenEditoren = SystemDatentypen.Spiel_Beenden_Enum
               then
                  exit HauptmenüSchleife;

               else
                  null;
               end if;
               
            -- when SystemDatentypen.Informationen_Enum =>
            --   Informationen.Informationen;
               
            when SystemDatentypen.Würdigungen_Enum =>
               Wuerdigung.Würdigung;
               
            when SystemDatentypen.Spiel_Beenden_Enum =>
               exit HauptmenüSchleife;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "Hauptmenue.Hauptmenü - Keine gültige Menüauswahl");
         end case;
         
      end loop HauptmenüSchleife;
      
      InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => GrafikTonDatentypen.Grafik_Ende_Enum);
      InteraktionMusiktask.AktuelleMusik := GrafikTonDatentypen.Musik_Ende_Enum;
      InteraktionSoundtask.AktuellenSoundÄndern (SoundExtern => GrafikTonDatentypen.Sound_Ende_Enum);
      
   end Hauptmenü;

end Hauptmenue;
