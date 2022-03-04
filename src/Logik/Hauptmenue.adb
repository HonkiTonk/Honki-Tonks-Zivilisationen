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
with InteraktionMusiktask;

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
                 RückgabeKampagne = SystemKonstanten.HauptmenüKonstante
                 or
                   RückgabeKampagne = SystemKonstanten.ZurückKonstante
               then
                  AllesAufAnfangSetzen.AllesAufAnfangSetzen;

               elsif
                 RückgabeKampagne = SystemKonstanten.SpielBeendenKonstante
               then
                  exit HauptmenüSchleife;

               else
                  null;
               end if;
               
            when SystemKonstanten.LadenKonstante =>
               if
                 Laden.LadenNeu = True
               then
                  case
                    ImSpiel.ImSpiel
                  is
                     when SystemKonstanten.HauptmenüKonstante =>
                        AllesAufAnfangSetzen.AllesAufAnfangSetzen;

                     when SystemKonstanten.SpielBeendenKonstante =>
                        exit HauptmenüSchleife;

                     when others =>
                        null;
                  end case;

               else
                  null;
               end if;
               
            when SystemKonstanten.OptionenKonstante =>
               if
                 Optionen.Optionen = SystemKonstanten.SpielBeendenKonstante
               then
                  exit HauptmenüSchleife;

               else
                  null;
               end if;
               
            when SystemKonstanten.EditorenKonstante =>
               if
                 DatenbankenEditoren.DatenbankenEditoren = SystemKonstanten.SpielBeendenKonstante
               then
                  exit HauptmenüSchleife;

               else
                  null;
               end if;
               
            when SystemKonstanten.InformationenKonstante =>
               Informationen.Informationen;
               
            when SystemKonstanten.WürdigungenKonstante =>
               Wuerdigung.Würdigung;
               
            when SystemKonstanten.SpielBeendenKonstante =>
               exit HauptmenüSchleife;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "Hauptmenue.Hauptmenü - Keine gültige Menüauswahl");
         end case;
         
      end loop HauptmenüSchleife;
      
      InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Ende);
      InteraktionMusiktask.AktuelleMusik := SystemDatentypen.Musik_Ende;
      InteraktionSoundtask.AktuellenSoundÄndern (SoundExtern => SystemDatentypen.Sound_Ende);
      
   end Hauptmenü;

end Hauptmenue;
