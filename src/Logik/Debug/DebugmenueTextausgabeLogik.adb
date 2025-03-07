with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with BetriebssystemKonstantenHTSEB;

with Menuetexte;
with Spieltexte;
with Sequenzentexte;
with Kartentexte;
with Speziestexte;

-- Das Ausgeben hier nicht aus dem Prozedurennamen entfernen, sonst kollidiert das mit den Dateinamen.
-- Bei Änderungen in der Textreihenfolge sollte das hier immer angepasst werden.
package body DebugmenueTextausgabeLogik is

   procedure TexteAusgeben
   is begin
      
      TextausgabeSchleife:
      loop
         
         New_Line;
         Put_Line ("0 = Alles");
         Put_Line ("1 = Menütexte");
         Put_Line ("2 = Spieltexte");
         Put_Line ("3 = Sequenztexte");
         Put_Line ("4 = Kartentexte");
         Put_Line ("5 = Speziestexte");
         Put_Line ("ESC = Zurück");
         New_Line;
         
         Get_Immediate (Item => Taste);
         
         case
           Taste
         is
            when '0' =>
               MenütexteAusgeben;
               SpieltexteAusgeben;
               SequenztexteAusgeben;
               KartentexteAusgeben;
               SpeziestexteAusgeben;
               
            when '1' =>
               MenütexteAusgeben;
            
            when '2' =>
               SpieltexteAusgeben;
            
            when '3' =>
               SequenztexteAusgeben;
            
            when '4' =>
               KartentexteAusgeben;
            
            when '5' =>
               SpeziestexteAusgeben;
               
            when BetriebssystemKonstantenHTSEB.ESC =>
               exit TextausgabeSchleife;
            
            when others =>
               null;
         end case;
         
      end loop TextausgabeSchleife;
      
      New_Line;
      
   end TexteAusgeben;
   
   
   
   function Pause
     return Positive
   is begin
      
      New_Line;
      Get_Immediate (Item => Taste);
      
      return 1;
      
   end Pause;
   
   
   
   -- Ist das so sicher? äöü
   procedure Test
     (ArrayExtern : in ArraysHTSEB.AllgemeinesTextArray)
   is begin
      
      AnzeigeSchleife:
      for AnzeigeSchleifenwert in ArrayExtern'Range loop
         
         Put_Line (Item => AnzeigeSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => ArrayExtern (AnzeigeSchleifenwert)));
         
      end loop AnzeigeSchleife;
      
   end Test;
   
   
   
   procedure MenütexteAusgeben
   is begin
      
      MenütexteSchleife:
      loop
         
         Put_Line ("1 = Hauptmenü");
         Put_Line ("2 = Spielmenü");
         Put_Line ("3 = Optionsmenü");
         Put_Line ("4 = Grafikmenü");
         Put_Line ("5 = Soundmenü");
         Put_Line ("6 = Steuerungsmenü");
         Put_Line ("7 = Spieleinstellungsmenü");
         Put_Line ("8 = Kartengröße");
         Put_Line ("9 = Kartenart");
         Put_Line ("a = Kartentemperatur");
         Put_Line ("b = Speziesauswahl");
         Put_Line ("c = Schwierigkeitsgrad");
         Put_Line ("d = Kartenform");
         Put_Line ("e = Ressourcenmenge");
         Put_Line ("f = Diplomatiemenü");
         Put_Line ("g = Einstellungsmenü");
         Put_Line ("h = Kartenpole");
         Put_Line ("i = Spielstandmenü");
         Put_Line ("j = Editorenmenü");
         Put_Line ("k = Handelsmenü");
         Put_Line ("ESC = Zurück");
         New_Line;
         
         Zeile := 1;
         Get_Immediate (Item => Taste);
         
         case
           Taste
         is
            when '1' =>
               HauptmenüSchleife:
               for HauptmenüSchleifenwert in Menuetexte.Hauptmenü'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & HauptmenüSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Hauptmenü (HauptmenüSchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop HauptmenüSchleife;
      
            when '2' =>
               SpielmenüSchleife:
               for SpielmenüSchleifenwert in Menuetexte.Spielmenü'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & SpielmenüSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Spielmenü (SpielmenüSchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop SpielmenüSchleife;
               
            when '3' =>
               OptionsmenüSchleife:
               for OptionsmenüSchleifenwert in Menuetexte.Optionsmenü'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & OptionsmenüSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Optionsmenü (OptionsmenüSchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop OptionsmenüSchleife;
               
            when '4' =>
               GrafikmenüSchleife:
               for GrafikmenüSchleifenwert in Menuetexte.Grafikmenü'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & GrafikmenüSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Grafikmenü (GrafikmenüSchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop GrafikmenüSchleife;
               
            when '5' =>
               SoundmenüSchleife:
               for SoundmenüSchleifenwert in Menuetexte.Soundmenü'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & SoundmenüSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Soundmenü (SoundmenüSchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop SoundmenüSchleife;
               
            when '6' =>
               SteuerungsmenüSchleife:
               for SteuerungsmenüSchleifenwert in Menuetexte.Steuerungsmenü'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & SteuerungsmenüSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Steuerungsmenü (SteuerungsmenüSchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop SteuerungsmenüSchleife;
               
            when '7' =>
               SpieleinstellungsmenüSchleife:
               for SpieleinstellungsmenüSchleifenwert in Menuetexte.Spieleinstellungsmenü'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & SpieleinstellungsmenüSchleifenwert'Wide_Wide_Image & ": "
                            & To_Wide_Wide_String (Source => Menuetexte.Spieleinstellungsmenü (SpieleinstellungsmenüSchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop SpieleinstellungsmenüSchleife;
               
            when '8' =>
               KartengrößeSchleife:
               for KartengrößeSchleifenwert in Menuetexte.Kartengröße'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & KartengrößeSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Kartengröße (KartengrößeSchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop KartengrößeSchleife;
               
            when '9' =>
               KartenartSchleife:
               for KartenartSchleifenwert in Menuetexte.Kartenart'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & KartenartSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Kartenart (KartenartSchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop KartenartSchleife;
               
            when 'a' =>
               KartentemperaturSchleife:
               for KartentemperaturSchleifenwert in Menuetexte.Kartentemperatur'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & KartentemperaturSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Kartentemperatur (KartentemperaturSchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop KartentemperaturSchleife;
               
            when 'b' =>
               SpeziesauswahlSchleife:
               for SpeziesauswahlSchleifenwert in Menuetexte.Speziesauswahl'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & SpeziesauswahlSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Speziesauswahl (SpeziesauswahlSchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop SpeziesauswahlSchleife;
               
            when 'c' =>
               SchwierigkeitsgradSchleife:
               for SchwierigkeitsgradSchleifenwert in Menuetexte.Schwierigkeitsgrad'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & SchwierigkeitsgradSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Schwierigkeitsgrad (SchwierigkeitsgradSchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop SchwierigkeitsgradSchleife;
               
            when 'd' =>
               KartenformSchleife:
               for KartenformSchleifenwert in Menuetexte.Kartenform'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & KartenformSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Kartenform (KartenformSchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop KartenformSchleife;
               
            when 'e' =>
               RessourcenmengeSchleife:
               for RessourcenmengeSchleifenwert in Menuetexte.Ressourcenmenge'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & RessourcenmengeSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Ressourcenmenge (RessourcenmengeSchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop RessourcenmengeSchleife;
               
            when 'f' =>
               DiplomatiemenüSchleife:
               for DiplomatiemenüSchleifenwert in Menuetexte.Diplomatiemenü'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & DiplomatiemenüSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Diplomatiemenü (DiplomatiemenüSchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop DiplomatiemenüSchleife;
               
            when 'g' =>
               EinstellungsmenüSchleife:
               for EinstellungsmenüSchleifenwert in Menuetexte.Einstellungsmenü'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & EinstellungsmenüSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Einstellungsmenü (EinstellungsmenüSchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop EinstellungsmenüSchleife;
               
            when 'h' =>
               KartenpoleSchleife:
               for KartenpoleSchleifenwert in Menuetexte.Kartenpole'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & KartenpoleSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Kartenpole (KartenpoleSchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop KartenpoleSchleife;
               
            when 'i' =>
               SpielstandmenüSchleife:
               for SpielstandmenüSchleifenwert in Menuetexte.Spielstandmenü'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & SpielstandmenüSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Spielstandmenü (SpielstandmenüSchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop SpielstandmenüSchleife;
               
            when 'j' =>
               EditorenmenüSchleife:
               for EditorenmenüSchleifenwert in Menuetexte.Editorenmenü'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & EditorenmenüSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Editorenmenü (EditorenmenüSchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop EditorenmenüSchleife;
               
            when 'k' =>
               HandelsmenüSchleife:
               for HandelsmenüSchleifenwert in Menuetexte.Handelsmenü'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & HandelsmenüSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Handelsmenü (HandelsmenüSchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop HandelsmenüSchleife;
               
            when BetriebssystemKonstantenHTSEB.ESC =>
               return;
               
            when others =>
               null;
         end case;
         
      end loop MenütexteSchleife;
      
   end MenütexteAusgeben;
   
   
   
   -- Ausgabe des Debugmenütextes wird hier nicht berücksichtigt, das das Menü keine Textdatei hat.
   procedure SpieltexteAusgeben
   is begin
      
      SpieltexteSchleife:
      loop
         
         New_Line;
         Put_Line ("1 = Fragen");
         Put_Line ("2 = Meldungen");
         Put_Line ("3 = Würdigung");
         Put_Line ("4 = Zeug");
         Put_Line ("5 = Stadtbefehle");
         Put_Line ("6 = Ladezeit");
         Put_Line ("7 = Beschäftigungen");
         Put_Line ("ESC = Zurück");
         New_Line;
         
         Zeile := 1;
         Get_Immediate (Item => Taste);
         
         case
           Taste
         is
            when '1' =>
               FragenSchleife:
               for FragenSchleifenwert in Spieltexte.Fragen'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & FragenSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Spieltexte.Fragen (FragenSchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop FragenSchleife;
               
            when '2' =>
               MeldungenSchleife:
               for MeldungenSchleifenwert in Spieltexte.Meldungen'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & MeldungenSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Spieltexte.Meldungen (MeldungenSchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop MeldungenSchleife;
               
            when '3' =>
               WürdigungSchleife:
               for WürdigungSchleifenwert in Spieltexte.Würdigungen'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & WürdigungSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Spieltexte.Würdigungen (WürdigungSchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop WürdigungSchleife;
               
            when '4' =>
               ZeugSchleife:
               for ZeugSchleifenwert in Spieltexte.Zeug'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & ZeugSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Spieltexte.Zeug (ZeugSchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop ZeugSchleife;
               
            when '5' =>
               StadtbefehleSchleife:
               for StadtbefehleSchleifenwert in Spieltexte.Stadtbefehle'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & StadtbefehleSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Spieltexte.Stadtbefehle (StadtbefehleSchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop StadtbefehleSchleife;
               
            when '6' =>
               LadezeitSchleife:
               for LadezeitSchleifenwert in Spieltexte.Ladezeiten'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & LadezeitSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Spieltexte.Ladezeiten (LadezeitSchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop LadezeitSchleife;
               
            when '7' =>
               BeschäftigungenSchleife:
               for BeschäftigungenSchleifenwert in Spieltexte.Beschäftigungen'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & BeschäftigungenSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Spieltexte.Beschäftigungen (BeschäftigungenSchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop BeschäftigungenSchleife;
               
            when BetriebssystemKonstantenHTSEB.ESC =>
               return;
               
            when others =>
               null;
         end case;
         
      end loop SpieltexteSchleife;
      
   end SpieltexteAusgeben;
   
      
   
   procedure SequenztexteAusgeben
   is begin
      
      SequenztexteSchleife:
      loop
         
         New_Line;
         Put_Line ("1 = Intro");
         Put_Line ("2 = Outro");
         Put_Line ("ESC = Zurück");
         New_Line;
         
         Zeile := 1;
         Get_Immediate (Item => Taste);
      
         case
           Taste
         is
            when '1' =>
               IntroSchleife:
               for IntroSchleifenwert in Sequenzentexte.Intro'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & IntroSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Sequenzentexte.Intro (IntroSchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop IntroSchleife;
               
            when '2' =>
               OutroSchleife:
               for OutroSchleifenwert in Sequenzentexte.Outro'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & OutroSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Sequenzentexte.Outro (OutroSchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop OutroSchleife;
               
            when BetriebssystemKonstantenHTSEB.ESC =>
               return;
               
            when others =>
               null;
         end case;
         
      end loop SequenztexteSchleife;
      
   end SequenztexteAusgeben;
   
   
   
   procedure KartentexteAusgeben
   is begin
      
      KartentexteSchleife:
      loop
      
         New_Line;
         Put_Line ("1 = Basisgrund");
         Put_Line ("2 = Zusatzgrund");
         Put_Line ("3 = Flüsse");
         Put_Line ("4 = Ressourcen");
         Put_Line ("5 = Feldeffekte");
         Put_Line ("6 = Verbesserungen");
         Put_Line ("7 = Wege");
         Put_Line ("ESC = Zurück");
         New_Line;
         
         Zeile := 1;
         Get_Immediate (Item => Taste);
         
         case
           Taste
         is
            when '1' =>
               BasisgrundSchleife:
               for BasisgrundSchleifenwert in Kartentexte.Basisgrund'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & BasisgrundSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Kartentexte.Basisgrund (BasisgrundSchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop BasisgrundSchleife;
               
            when '2' =>
               ZusatzgrundSchleife:
               for ZusatzgrundSchleifenwert in Kartentexte.Zusatzgrund'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & ZusatzgrundSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Kartentexte.Zusatzgrund (ZusatzgrundSchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop ZusatzgrundSchleife;
               
            when '3' =>
               FlüsseSchleife:
               for FlüsseSchleifenwert in Kartentexte.Flüsse'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & FlüsseSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Kartentexte.Flüsse (FlüsseSchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop FlüsseSchleife;
               
            when '4' =>
               RessourcenSchleife:
               for Ressourcenchleifenwert in Kartentexte.Ressourcen'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & Ressourcenchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Kartentexte.Ressourcen (Ressourcenchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop RessourcenSchleife;
               
            when '5' =>
               FeldeffekteSchleife:
               for FeldeffekteSchleifenwert in Kartentexte.Feldeffekte'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & FeldeffekteSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Kartentexte.Feldeffekte (FeldeffekteSchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop FeldeffekteSchleife;
               
            when '6' =>
               VerbesserungenSchleife:
               for VerbesserungenSchleifenwert in Kartentexte.Verbesserungen'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & VerbesserungenSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Kartentexte.Verbesserungen (VerbesserungenSchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop VerbesserungenSchleife;
               
            when '7' =>
               WegeSchleife:
               for WegeSchleifenwert in Kartentexte.Wege'Range loop
         
                  Put_Line (Item => Zeile'Wide_Wide_Image & " /" & WegeSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Kartentexte.Wege (WegeSchleifenwert)));
         
                  Zeile := Zeile + 1;
         
               end loop WegeSchleife;
               
            when BetriebssystemKonstantenHTSEB.ESC =>
               return;
               
            when others =>
               null;
         end case;
         
      end loop KartentexteSchleife;
            
   end KartentexteAusgeben;
   
   
   
   procedure SpeziestexteAusgeben
   is begin
      
      SpeziestexteSchleife:
      loop
         
         New_Line;
         Put_Line ("1 = NameBeschreibung");
         Put_Line ("2 = Städtenamen");
         Put_Line ("3 = Forschungen");
         Put_Line ("4 = Einheiten");
         Put_Line ("5 = Gebäude");
         Put_Line ("ESC = Zurück");
         New_Line;
         
         Zeile := 1;
         Get_Immediate (Item => Taste);
         
         case
           Taste
         is
            when '1' =>
               SpeziesEinsSchleife:
               for SpeziesEinsSchleifenwert in Speziestexte.NameBeschreibungArray'Range (1) loop
                  NameBeschreibungSchleife:
                  for NameBeschreibungSchleifenwert in Speziestexte.NameBeschreibungArray'Range (2) loop
         
                     Put_Line (Item => Zeile'Wide_Wide_Image & " /" & NameBeschreibungSchleifenwert'Wide_Wide_Image & ": "
                               & To_Wide_Wide_String (Source => Speziestexte.NameBeschreibung (SpeziesEinsSchleifenwert, NameBeschreibungSchleifenwert)));
            
                     Zeile := Zeile + 1;
         
                  end loop NameBeschreibungSchleife;
         
                  Zeile := Pause;
         
               end loop SpeziesEinsSchleife;
               
            when '2' =>
               SpeziesZweiSchleife:
               for SpeziesZweiSchleifenwert in Speziestexte.StädtenamenArray'Range (1) loop
                  StädtenamenSchleife:
                  for StädtenamenSchleifenwert in Speziestexte.StädtenamenArray'Range (2) loop
         
                     Put_Line (Item => Zeile'Wide_Wide_Image & " /" & StädtenamenSchleifenwert'Wide_Wide_Image & ": "
                               & To_Wide_Wide_String (Source => Speziestexte.Städtenamen (SpeziesZweiSchleifenwert, StädtenamenSchleifenwert)));
            
                     Zeile := Zeile + 1;
         
                  end loop StädtenamenSchleife;
         
                  Zeile := Pause;
         
               end loop SpeziesZweiSchleife;
               
            when '3' =>
               SpeziesDreiSchleife:
               for SpeziesDreiSchleifenwert in Speziestexte.ForschungenArray'Range (1) loop
                  ForschungIDSchleife:
                  for ForschungIDSchleifenwert in Speziestexte.ForschungenArray'Range (2) loop
                     TechnologieSchleife:
                     for TechnologieSchleifenwert in Speziestexte.ForschungenArray'Range (3) loop
         
                        Put_Line (Item => Zeile'Wide_Wide_Image & " /" & TechnologieSchleifenwert'Wide_Wide_Image & ": "
                                  & To_Wide_Wide_String (Source => Speziestexte.Forschungen (SpeziesDreiSchleifenwert, ForschungIDSchleifenwert, TechnologieSchleifenwert)));
            
                        Zeile := Zeile + 1;
         
                     end loop TechnologieSchleife;
                  end loop ForschungIDSchleife;
         
                  Zeile := Pause;
         
               end loop SpeziesDreiSchleife;
               
            when '4' =>
               SpeziesVierSchleife:
               for SpeziesVierSchleifenwert in Speziestexte.EinheitenArray'Range (1) loop
                  EinheitenIDSchleife:
                  for EinheitenIDSchleifenwert in Speziestexte.EinheitenArray'Range (2) loop
                     EinheitSchleife:
                     for EinheitSchleifenwert in Speziestexte.EinheitenArray'Range (3) loop
         
                        Put_Line (Item => Zeile'Wide_Wide_Image & " /" & EinheitSchleifenwert'Wide_Wide_Image & ": "
                                  & To_Wide_Wide_String (Source => Speziestexte.Einheiten (SpeziesVierSchleifenwert, EinheitenIDSchleifenwert, EinheitSchleifenwert)));
            
                        Zeile := Zeile + 1;
         
                     end loop EinheitSchleife;
                  end loop EinheitenIDSchleife;
         
                  Zeile := Pause;
         
               end loop SpeziesVierSchleife;
               
            when '5' =>
               SpeziesFünfSchleife:
               for SpeziesFünfSchleifenwert in Speziestexte.GebäudeArray'Range (1) loop
                  GebäudeIDSchleife:
                  for GebäudeIDSchleifenwert in Speziestexte.GebäudeArray'Range (2) loop
                     GebäudeSchleife:
                     for GebäudeSchleifenwert in Speziestexte.GebäudeArray'Range (3) loop
         
                        Put_Line (Item => Zeile'Wide_Wide_Image & " /" & GebäudeSchleifenwert'Wide_Wide_Image & ": "
                                  & To_Wide_Wide_String (Source => Speziestexte.Gebäude (SpeziesFünfSchleifenwert, GebäudeIDSchleifenwert, GebäudeSchleifenwert)));
            
                        Zeile := Zeile + 1;
         
                     end loop GebäudeSchleife;
                  end loop GebäudeIDSchleife;
         
                  Zeile := Pause;
         
               end loop SpeziesFünfSchleife;
               
            when BetriebssystemKonstantenHTSEB.ESC =>
               return;
               
            when others =>
               null;
         end case;
         
      end loop SpeziestexteSchleife;
      
   end SpeziestexteAusgeben;

end DebugmenueTextausgabeLogik;
