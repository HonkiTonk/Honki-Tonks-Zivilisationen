pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with SystemKonstanten;

with Optionen;
with SpielEinstellungen;
with AllesAufAnfangSetzen;
with Informationen;
with ImSpiel;
with Laden;
with Wuerdigung;
with AuswahlMenue;
with Fehler;
with InteraktionSoundtask;
with InteraktionGrafiktask;
with DatenbankenEditoren;

package body Hauptmenue is

   procedure Hauptmenü
   is begin
      
      HauptmenüSchleife:
      loop
         
         case
           AuswahlMenue.AuswahlMenü (WelchesMenüExtern => SystemDatentypen.Haupt_Menü)
         is
            when SystemKonstanten.StartWeiterKonstante =>
               RückgabeKampagne := SpielEinstellungen.SpielEinstellungenAuswahl;

               if
                 RückgabeKampagne = SystemDatentypen.Hauptmenü
                 or
                   RückgabeKampagne = SystemDatentypen.Zurück
               then
                  AllesAufAnfangSetzen.AllesAufAnfangSetzen;

               elsif
                 RückgabeKampagne = SystemDatentypen.Spiel_Beenden
               then
                  exit HauptmenüSchleife;

               else
                  null;
               end if;
               
            when SystemDatentypen.Laden =>
               if
                 Laden.LadenNeu = True
               then
                  case
                    ImSpiel.ImSpiel
                  is
                     when SystemDatentypen.Hauptmenü =>
                        AllesAufAnfangSetzen.AllesAufAnfangSetzen;

                     when SystemDatentypen.Spiel_Beenden =>
                        exit HauptmenüSchleife;

                     when others =>
                        null;
                  end case;

               else
                  null;
               end if;
               
            when SystemDatentypen.Optionen =>
               if
                 Optionen.Optionen = SystemDatentypen.Spiel_Beenden
               then
                  exit HauptmenüSchleife;

               else
                  null;
               end if;
               
            when SystemDatentypen.Editoren =>
               if
                 DatenbankenEditoren.DatenbankenEditoren = SystemDatentypen.Spiel_Beenden
               then
                  exit HauptmenüSchleife;

               else
                  null;
               end if;
               
            when SystemDatentypen.Informationen =>
               Informationen.Informationen;
               
            when SystemDatentypen.Würdigungen =>
               Wuerdigung.Würdigung;
               
            when SystemDatentypen.Spiel_Beenden =>
               exit HauptmenüSchleife;
               
            when others =>
               Fehler.LogikStopp (FehlermeldungExtern => "Hauptmenue.Hauptmenü - Keine gültige Menüauswahl");
         end case;
         
      end loop HauptmenüSchleife;
      
      InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Ende);
      InteraktionSoundtask.AktuelleMusikÄndern (MusikExtern => SystemDatentypen.Musik_Ende);
      
   end Hauptmenü;

end Hauptmenue;
