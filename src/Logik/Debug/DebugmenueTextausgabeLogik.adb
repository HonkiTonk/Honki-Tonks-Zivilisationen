with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Menuetexte;
with Spieltexte;
with Sequenzentexte;
with Kartentexte;
with Speziestexte;
with BetriebssystemKonstanten;

-- Das Ausgeben hier nicht aus dem Prozedurennamen entfernen, sonst kollidiert das mit den Dateinamen.
-- Bei Änderungen in der Textreihenfolge sollte das hier immer angepasst werden.
package body DebugmenueTextausgabeLogik is

   procedure TexteAusgeben
   is begin
      
      TextausgabeSchleife:
      loop
         
         Zeile := 1;
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
               
            when BetriebssystemKonstanten.ESC =>
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
   
   
   
   procedure MenütexteAusgeben
   is begin
      
      Put_Line ("Hauptmenü:");
      
      HauptmenüSchleife:
      for HauptmenüSchleifenwert in Menuetexte.Hauptmenü'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & HauptmenüSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Hauptmenü (HauptmenüSchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop HauptmenüSchleife;
      
      Zeile := Pause;
      
      
      
      Put_Line ("Spielmenü:");
      
      SpielmenüSchleife:
      for SpielmenüSchleifenwert in Menuetexte.Spielmenü'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & SpielmenüSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Spielmenü (SpielmenüSchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop SpielmenüSchleife;
      
      Zeile := Pause;
      
      
      
      Put_Line ("Optionsmenü:");
      
      OptionsmenüSchleife:
      for OptionsmenüSchleifenwert in Menuetexte.Optionsmenü'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & OptionsmenüSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Optionsmenü (OptionsmenüSchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop OptionsmenüSchleife;
      
      Zeile := Pause;
      
      
      
      Put_Line ("Grafikmenü:");
      
      GrafikmenüSchleife:
      for GrafikmenüSchleifenwert in Menuetexte.Grafikmenü'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & GrafikmenüSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Grafikmenü (GrafikmenüSchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop GrafikmenüSchleife;
      
      Zeile := Pause;
      
      
      
      Put_Line ("Soundmenü:");
      
      SoundmenüSchleife:
      for SoundmenüSchleifenwert in Menuetexte.Soundmenü'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & SoundmenüSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Soundmenü (SoundmenüSchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop SoundmenüSchleife;
      
      Zeile := Pause;
      
      
      
      Put_Line ("Steuerungsmenü:");
      
      SteuerungsmenüSchleife:
      for SteuerungsmenüSchleifenwert in Menuetexte.Steuerungsmenü'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & SteuerungsmenüSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Steuerungsmenü (SteuerungsmenüSchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop SteuerungsmenüSchleife;
      
      Zeile := Pause;
      
      
      
      Put_Line ("Spieleinstellungsmenü:");
      
      SpieleinstellungsmenüSchleife:
      for SpieleinstellungsmenüSchleifenwert in Menuetexte.Spieleinstellungsmenü'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & SpieleinstellungsmenüSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Spieleinstellungsmenü (SpieleinstellungsmenüSchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop SpieleinstellungsmenüSchleife;
      
      Zeile := Pause;
      
      
      
      Put_Line ("Kartengröße:");
      
      KartengrößeSchleife:
      for KartengrößeSchleifenwert in Menuetexte.Kartengröße'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & KartengrößeSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Kartengröße (KartengrößeSchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop KartengrößeSchleife;
      
      Zeile := Pause;
      
      
      
      Put_Line ("Kartenart:");
      
      KartenartSchleife:
      for KartenartSchleifenwert in Menuetexte.Kartenart'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & KartenartSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Kartenart (KartenartSchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop KartenartSchleife;
      
      Zeile := Pause;
      
      
      
      Put_Line ("Kartentemperatur:");
      
      KartentemperaturSchleife:
      for KartentemperaturSchleifenwert in Menuetexte.Kartentemperatur'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & KartentemperaturSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Kartentemperatur (KartentemperaturSchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop KartentemperaturSchleife;
      
      Zeile := Pause;
      
      
      
      Put_Line ("Speziesauswahl:");
      
      SpeziesauswahlSchleife:
      for SpeziesauswahlSchleifenwert in Menuetexte.Speziesauswahl'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & SpeziesauswahlSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Speziesauswahl (SpeziesauswahlSchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop SpeziesauswahlSchleife;
      
      Zeile := Pause;
      
      
      
      Put_Line ("Schwierigkeitsgrad:");
      
      SchwierigkeitsgradSchleife:
      for SchwierigkeitsgradSchleifenwert in Menuetexte.Schwierigkeitsgrad'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & SchwierigkeitsgradSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Schwierigkeitsgrad (SchwierigkeitsgradSchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop SchwierigkeitsgradSchleife;
      
      Zeile := Pause;
      
      
      
      Put_Line ("Kartenform:");
      
      KartenformSchleife:
      for KartenformSchleifenwert in Menuetexte.Kartenform'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & KartenformSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Kartenform (KartenformSchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop KartenformSchleife;
      
      Zeile := Pause;
      
      
      
      Put_Line ("Ressourcenmenge:");
      
      RessourcenmengeSchleife:
      for RessourcenmengeSchleifenwert in Menuetexte.Ressourcenmenge'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & RessourcenmengeSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Ressourcenmenge (RessourcenmengeSchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop RessourcenmengeSchleife;
      
      Zeile := Pause;
      
      
      
      Put_Line ("Diplomatiemenü:");
      
      DiplomatiemenüSchleife:
      for DiplomatiemenüSchleifenwert in Menuetexte.Diplomatiemenü'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & DiplomatiemenüSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Diplomatiemenü (DiplomatiemenüSchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop DiplomatiemenüSchleife;
      
      Zeile := Pause;
      
      
      
      Put_Line ("Einstellungsmenü:");
      
      EinstellungsmenüSchleife:
      for EinstellungsmenüSchleifenwert in Menuetexte.Einstellungsmenü'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & EinstellungsmenüSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Einstellungsmenü (EinstellungsmenüSchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop EinstellungsmenüSchleife;
      
      Zeile := Pause;
      
      
      
      Put_Line ("Kartenpole:");
      
      KartenpoleSchleife:
      for KartenpoleSchleifenwert in Menuetexte.Kartenpole'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & KartenpoleSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Kartenpole (KartenpoleSchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop KartenpoleSchleife;
      
      Zeile := Pause;
      
      
      
      Put_Line ("Spielstandmenü:");
      
      SpielstandmenüSchleife:
      for SpielstandmenüSchleifenwert in Menuetexte.Spielstandmenü'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & SpielstandmenüSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Spielstandmenü (SpielstandmenüSchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop SpielstandmenüSchleife;
      
      Zeile := Pause;
      
      
      
      Put_Line ("Editorenmenü:");
      
      EditorenmenüSchleife:
      for EditorenmenüSchleifenwert in Menuetexte.Editorenmenü'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & EditorenmenüSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Editorenmenü (EditorenmenüSchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop EditorenmenüSchleife;
      
      Zeile := Pause;
      
      
      
      Put_Line ("Handelsmenü:");
      
      HandelsmenüSchleife:
      for HandelsmenüSchleifenwert in Menuetexte.Handelsmenü'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & HandelsmenüSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Menuetexte.Handelsmenü (HandelsmenüSchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop HandelsmenüSchleife;
      
   end MenütexteAusgeben;
   
   
   
   -- Ausgabe des Debugmenütextes wird hier nicht berücksichtigt, das das Menü keine Textdatei hat.
   procedure SpieltexteAusgeben
   is begin
      
      Put_Line ("Fragen:");
      
      FragenSchleife:
      for FragenSchleifenwert in Spieltexte.Fragen'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & FragenSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Spieltexte.Fragen (FragenSchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop FragenSchleife;
            
      Zeile := Pause;
      
      
      
      Put_Line ("Meldungen:");
      
      MeldungenSchleife:
      for MeldungenSchleifenwert in Spieltexte.Meldungen'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & MeldungenSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Spieltexte.Meldungen (MeldungenSchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop MeldungenSchleife;
      
      Zeile := Pause;
      
      
      
      Put_Line ("Würdigung:");
      
      WürdigungSchleife:
      for WürdigungSchleifenwert in Spieltexte.Würdigung'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & WürdigungSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Spieltexte.Würdigung (WürdigungSchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop WürdigungSchleife;
      
      Zeile := Pause;
            
      
      
      Put_Line ("Zeug:");
      
      ZeugSchleife:
      for ZeugSchleifenwert in Spieltexte.Zeug'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & ZeugSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Spieltexte.Zeug (ZeugSchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop ZeugSchleife;
      
      Zeile := Pause;
      
      
      
      Put_Line ("Stadtbefehle:");
      
      StadtbefehleSchleife:
      for StadtbefehleSchleifenwert in Spieltexte.Stadtbefehle'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & StadtbefehleSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Spieltexte.Stadtbefehle (StadtbefehleSchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop StadtbefehleSchleife;
      
      Zeile := Pause;
      
      
      
      Put_Line ("Ladezeit:");
      
      LadezeitSchleife:
      for LadezeitSchleifenwert in Spieltexte.Ladezeit'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & LadezeitSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Spieltexte.Ladezeit (LadezeitSchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop LadezeitSchleife;
      
      Zeile := Pause;
      
      
      
      Put_Line ("Beschäftigungen:");
      
      BeschäftigungenSchleife:
      for BeschäftigungenSchleifenwert in Spieltexte.Beschäftigungen'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & BeschäftigungenSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Spieltexte.Beschäftigungen (BeschäftigungenSchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop BeschäftigungenSchleife;
      
   end SpieltexteAusgeben;
   
      
   
   procedure SequenztexteAusgeben
   is begin
      
      Put_Line ("Intro:");
      
      IntroSchleife:
      for IntroSchleifenwert in Sequenzentexte.Intro'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & IntroSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Sequenzentexte.Intro (IntroSchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop IntroSchleife;
      
      Zeile := Pause;
      
      
      
      Put_Line ("Outro:");
      
      OutroSchleife:
      for OutroSchleifenwert in Sequenzentexte.Outro'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & OutroSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Sequenzentexte.Outro (OutroSchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop OutroSchleife;
      
   end SequenztexteAusgeben;
   
   
   
   procedure KartentexteAusgeben
   is begin
      
      Put_Line ("Basisgrund:");
      
      BasisgrundSchleife:
      for BasisgrundSchleifenwert in Kartentexte.Basisgrund'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & BasisgrundSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Kartentexte.Basisgrund (BasisgrundSchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop BasisgrundSchleife;
      
      Zeile := Pause;
      
      
      
      Put_Line ("Zusatzgrund:");
      
      ZusatzgrundSchleife:
      for ZusatzgrundSchleifenwert in Kartentexte.Zusatzgrund'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & ZusatzgrundSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Kartentexte.Zusatzgrund (ZusatzgrundSchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop ZusatzgrundSchleife;
      
      Zeile := Pause;
      
      
      
      Put_Line ("Flüsse:");
      
      FlüsseSchleife:
      for FlüsseSchleifenwert in Kartentexte.Flüsse'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & FlüsseSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Kartentexte.Flüsse (FlüsseSchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop FlüsseSchleife;
      
      Zeile := Pause;
      
      
      
      Put_Line ("Ressourcen:");
      
      RessourcenSchleife:
      for Ressourcenchleifenwert in Kartentexte.Ressourcen'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & Ressourcenchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Kartentexte.Ressourcen (Ressourcenchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop RessourcenSchleife;
      
      Zeile := Pause;
      
      
      
      Put_Line ("Feldeffekte:");
      
      FeldeffekteSchleife:
      for FeldeffekteSchleifenwert in Kartentexte.Feldeffekte'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & FeldeffekteSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Kartentexte.Feldeffekte (FeldeffekteSchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop FeldeffekteSchleife;
      
      Zeile := Pause;
      
      
      
      Put_Line ("Verbesserungen:");
      
      VerbesserungenSchleife:
      for VerbesserungenSchleifenwert in Kartentexte.Verbesserungen'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & VerbesserungenSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Kartentexte.Verbesserungen (VerbesserungenSchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop VerbesserungenSchleife;
      
      Zeile := Pause;
      
      
      
      Put_Line ("Wege:");
      
      WegeSchleife:
      for WegeSchleifenwert in Kartentexte.Wege'Range loop
         
         Put_Line (Item => Zeile'Wide_Wide_Image & " /" & WegeSchleifenwert'Wide_Wide_Image & ": " & To_Wide_Wide_String (Source => Kartentexte.Wege (WegeSchleifenwert)));
         
         Zeile := Zeile + 1;
         
      end loop WegeSchleife;
            
   end KartentexteAusgeben;
   
   
   
   procedure SpeziestexteAusgeben
   is begin
      
      Put_Line ("NameBeschreibung:");
      
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
      
      Zeile := Pause;
      
      
      
      Put_Line ("Städtenamen:");
      
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
      
      Zeile := Pause;
      
      
      
      Put_Line ("Forschungen:");
      
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
      
      Zeile := Pause;
      
      
      
      Put_Line ("Einheiten:");
      
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
      
      Zeile := Pause;
      
      
      
      Put_Line ("Gebäude:");
      
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
      
      Zeile := Pause;
      
   end SpeziestexteAusgeben;

end DebugmenueTextausgabeLogik;
