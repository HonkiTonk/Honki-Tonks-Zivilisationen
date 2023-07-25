with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with VerzeichnisKonstanten;
with Menuetexte;
with Kartentexte;
with GlobaleTexte;
with Meldungstexte;
with Befehlstexte;
with Spieltexte;
with Projekteinstellungen;
with TextKonstanten;

with LeseOptionen;

with Fehlermeldungssystem;
with EinlesenAllgemeinesLogik;

package body EinlesenTextLogik is

   procedure EinlesenDateien
   is begin
      
      case
        Projekteinstellungen.Debug.NormalerText
      is
         when True =>
            Einlesen (VerzeichnisExtern => (VerzeichnisKonstanten.Sprachenordner & To_Wide_Wide_String (Source => LeseOptionen.Sprache) & "/"));
            
         when False =>
            Start_Search (Search    => Suche,
                          Directory => VerzeichnisKonstanten.Sprachen,
                          Pattern   => "",
                          Filter    => (Directory => True,
                                        others    => False));
      
            SprachenSchleife:
            while More_Entries (Search => Suche) = True loop
      
               Get_Next_Entry (Search          => Suche,
                               Directory_Entry => Verzeichnis);
         
               -- Das hier doch einmal auslagern. äöü
               if
                 Simple_Name (Directory_Entry => Verzeichnis) = "."
                 or
                   Simple_Name (Directory_Entry => Verzeichnis) = ".."
                 or
                   Simple_Name (Directory_Entry => Verzeichnis) = "Fonts"
               then
                  null;
            
               elsif
                 -- Das hier noch durch eine Windows uns eine Linuxversion ersetzen. äöü
                 -- Kann das nicht einfach raus wenn irgendwann einmal Wide_Wide_Directories da ist? äöü
                 -- Das ist je nur vorhandene Ordner durchgehen und man kann ja keine Dateien/Ordner anlegen die das Dateisystem nicht unterstützen. äöü
                 EinlesenAllgemeinesLogik.NamensprüfungWindows (NameExtern => Decode (Item => Simple_Name (Directory_Entry => Verzeichnis))) = False
               then
                  null;
             
               elsif
                 -- Das ausgeklammerte funktioniert unter Windwos nicht, wenn man Sonderzeichen verwendet.
                 -- EinlesenAllgemeinesLogik.LeeresVerzeichnis (VerzeichnisExtern => VerzeichnisKonstanten.SprachenStrich & Simple_Name (Directory_Entry => Verzeichnis)) = True
                 Exists (Name => VerzeichnisKonstanten.SprachenStrich & Simple_Name (Directory_Entry => Verzeichnis) & VerzeichnisKonstanten.NullDatei) = False
                 or
                   Exists (Name => VerzeichnisKonstanten.SprachenStrich & Simple_Name (Directory_Entry => Verzeichnis) & VerzeichnisKonstanten.EinsDatei) = False
               then
                  null;
            
               else
                  Einlesen (VerzeichnisExtern => (VerzeichnisKonstanten.Sprachenordner & Decode (Item => Simple_Name (Directory_Entry => Verzeichnis)) & "/"));
               end if;
               
            end loop SprachenSchleife;
      end case;
      
      Menuetexte.Debugmenü (1) := To_Unbounded_Wide_Wide_String (Source => "Debugmenü");
      Menuetexte.Debugmenü (2) := To_Unbounded_Wide_Wide_String (Source => "Karte aufdecken");
      Menuetexte.Debugmenü (3) := To_Unbounded_Wide_Wide_String (Source => "Alle Technologien");
      Menuetexte.Debugmenü (4) := To_Unbounded_Wide_Wide_String (Source => "Mensch/KI tauschen");
      Menuetexte.Debugmenü (5) := To_Unbounded_Wide_Wide_String (Source => "Diplomatischen Status ändern");
      Menuetexte.Debugmenü (6) := To_Unbounded_Wide_Wide_String (Source => "Volle Forschung");
      Menuetexte.Debugmenü (7) := To_Unbounded_Wide_Wide_String (Source => "Einheit erzeugen");
      Menuetexte.Debugmenü (8) := To_Unbounded_Wide_Wide_String (Source => "Fertig");
      
   end EinlesenDateien;
      
      
      
   procedure Einlesen
     (VerzeichnisExtern : Wide_Wide_String)
   is begin
      
      case
        Exists (Name => Encode (Item => VerzeichnisExtern & "0"))
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Einlesen: Es fehlt: " & VerzeichnisExtern & "0");
            return;
            
         when True =>
            Open (File => DateiVerzeichnisse,
                  Mode => In_File,
                  Name => Encode (Item => VerzeichnisExtern & "0"),
                  Form => "WCEM=8");
      end case;
      
      EinlesenSchleife:
      for WelcheDateienSchleifenwert in 1 .. AnzahlTextdateien loop

         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiVerzeichnisse,
                                                           AktuelleZeileExtern => WelcheDateienSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Einlesen")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Einlesen: Fehlende Zeilen, aktuelle Zeile: " & WelcheDateienSchleifenwert'Wide_Wide_Image);
               exit EinlesenSchleife;
               
            when False =>
               EinlesenAufteilen (WelcheDateiExtern => WelcheDateienSchleifenwert,
                                  VerzeichnisExtern => VerzeichnisExtern & Get_Line (File => DateiVerzeichnisse));
         end case;

      end loop EinlesenSchleife;

      Close (File => DateiVerzeichnisse);
      
   end Einlesen;
   
   
   
   procedure EinlesenAufteilen
     (WelcheDateiExtern : in Positive;
      VerzeichnisExtern : in Wide_Wide_String)
   is begin
      
      case
        Exists (Name => Encode (Item => VerzeichnisExtern))
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.EinlesenAufteilen: Es fehlt: " & VerzeichnisExtern);
            return;
            
         when True =>
            Open (File => DateiText,
                  Mode => In_File,
                  Name => Encode (Item => VerzeichnisExtern),
                  Form => "WCEM=8");
      end case;
      
      case
        WelcheDateiExtern
      is
         when 1 =>
            Hauptmenü (DateiExtern => DateiText);
               
         when 2 =>
            Spielmenü (DateiExtern => DateiText);
               
         when 3 =>
            Optionsmenü (DateiExtern => DateiText);
               
         when 4 =>
            Grafikmenü (DateiExtern => DateiText);
               
         when 5 =>
            Soundmenü (DateiExtern => DateiText);
               
         when 6 =>
            Steuerungmenü (DateiExtern => DateiText);
               
         when 7 =>
            Sonstigesmenü (DateiExtern => DateiText);
               
         when 8 =>
            Kartengröße (DateiExtern => DateiText);
               
         when 9 =>
            Kartenart (DateiExtern => DateiText);
               
         when 10 =>
            Kartentemperatur (DateiExtern => DateiText);
               
         when 11 =>
            Speziesauswahl (DateiExtern => DateiText);
               
         when 12 =>
            Schwierigkeitsgrad (DateiExtern => DateiText);
               
         when 13 =>
            Kartenform (DateiExtern => DateiText);
               
         when 14 =>
            Ressourcenmenge (DateiExtern => DateiText);
               
         when 15 =>
            Basisgrund (DateiExtern => DateiText);
               
         when 16 =>
            Verbesserungen (DateiExtern => DateiText);
               
         when 17 =>
            Beschäftigungen (DateiExtern => DateiText);
               
         when 18 =>
            Würdigung (DateiExtern => DateiText);
               
         when 19 =>
            Diplomatiemenü (DateiExtern => DateiText);
               
         when 20 =>
            DiplomatieKI (DateiExtern => DateiText);
               
         when 21 =>
            Handelsmenü (DateiExtern => DateiText);
               
         when 22 =>
            DiplomatieStatus (DateiExtern => DateiText);
               
         when 23 =>
            Angebot (DateiExtern => DateiText);
               
         when 24 =>
            Fehlermeldung (DateiExtern => DateiText);
               
         when 25 =>
            Ladezeit (DateiExtern => DateiText);
               
         when 26 =>
            Frage (DateiExtern => DateiText);
               
         when 27 =>
            ZeugSachen (DateiExtern => DateiText);
               
         when 28 =>
            Editoren (DateiExtern => DateiText);
               
         when 29 =>
            Wege (DateiExtern => DateiText);
               
         when 30 =>
            Kartenflüsse (DateiExtern => DateiText);
               
         when 31 =>
            Kartenressourcen (DateiExtern => DateiText);
               
         when 32 =>
            Einstellungen (DateiExtern => DateiText);
               
         when 33 =>
            Kartenpole (DateiExtern => DateiText);
            
         when 34 =>
            Stadtbefehle (DateiExtern => DateiText);
            
         when 35 =>
            Spielstandmenü (DateiExtern => DateiText);
            
         when 36 =>
            Intro (DateiExtern => DateiText);
            
         when 37 =>
            Outro (DateiExtern => DateiText);
            
         when 38 =>
            Zusatzgrund (DateiExtern => DateiText);
            
         when 39 =>
            Feldeffekte (DateiExtern => DateiText);
            
         when others =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.EinlesenAufteilen: Mehr eingelesen als möglich, Dateinummer: " & WelcheDateiExtern'Wide_Wide_Image);
      end case;
            
      Close (File => DateiText);
      
   end EinlesenAufteilen;
   
   
   
   procedure Hauptmenü
     (DateiExtern : in File_Type)
   is begin
      
      HauptmenüSchleife:
      for ZeileSchleifenwert in Menuetexte.Hauptmenü'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Hauptmenü")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Hauptmenü: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               Menuetexte.Hauptmenü (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Menuetexte.Hauptmenü (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Menuetexte.Hauptmenü (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Menuetexte.Hauptmenü (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop HauptmenüSchleife;
      
   end Hauptmenü;
   
   
   
   procedure Spielmenü
     (DateiExtern : in File_Type)
   is begin
      
      SpielmenüSchleife:
      for ZeileSchleifenwert in Menuetexte.Spielmenü'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Spielmenü")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Spielmenü: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               Menuetexte.Spielmenü (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Menuetexte.Spielmenü (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Menuetexte.Spielmenü (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Menuetexte.Spielmenü (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop SpielmenüSchleife;
      
   end Spielmenü;
   
   
   
   procedure Optionsmenü
     (DateiExtern : in File_Type)
   is begin
      
      OptionsmenüSchleife:
      for ZeileSchleifenwert in Menuetexte.Optionsmenü'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Optionsmenü")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Optionsmenü: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               Menuetexte.Optionsmenü (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Menuetexte.Optionsmenü (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Menuetexte.Optionsmenü (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Menuetexte.Optionsmenü (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop OptionsmenüSchleife;
      
   end Optionsmenü;
   
   
   
   procedure Grafikmenü
     (DateiExtern : in File_Type)
   is begin
      
      GrafikmenüSchleife:
      for ZeileSchleifenwert in Menuetexte.Grafikmenü'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Grafikmenü")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Grafikmenü: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               Menuetexte.Grafikmenü (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Menuetexte.Grafikmenü (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Menuetexte.Grafikmenü (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Menuetexte.Grafikmenü (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop GrafikmenüSchleife;
      
   end Grafikmenü;
   
   
   
   procedure Soundmenü
     (DateiExtern : in File_Type)
   is begin
      
      SoundmenüSchleife:
      for ZeileSchleifenwert in Menuetexte.Soundmenü'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Soundmenü")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Soundmenü: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               Menuetexte.Soundmenü (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Menuetexte.Soundmenü (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Menuetexte.Soundmenü (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Menuetexte.Soundmenü (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop SoundmenüSchleife;
      
   end Soundmenü;
   
   
   
   procedure Steuerungmenü
     (DateiExtern : in File_Type)
   is begin
      
      SteuerungmenüSchleife:
      for ZeileSchleifenwert in Menuetexte.Steuerungmenü'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Steuerungmenü")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Steuerungmenü: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               Menuetexte.Steuerungmenü (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Menuetexte.Steuerungmenü (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Menuetexte.Steuerungmenü (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Menuetexte.Steuerungmenü (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop SteuerungmenüSchleife;
      
   end Steuerungmenü;
   
   
   
   procedure Sonstigesmenü
     (DateiExtern : in File_Type)
   is begin
      
      SonstigesmenüSchleife:
      for ZeileSchleifenwert in Menuetexte.Sonstigesmenü'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Sonstigesmenü")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Sonstigesmenü: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               Menuetexte.Sonstigesmenü (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Menuetexte.Sonstigesmenü (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Menuetexte.Sonstigesmenü (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Menuetexte.Sonstigesmenü (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop SonstigesmenüSchleife;
      
   end Sonstigesmenü;
   
   
   
   procedure Kartengröße
     (DateiExtern : in File_Type)
   is begin
      
      KartengrößeSchleife:
      for ZeileSchleifenwert in Menuetexte.Kartengröße'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Kartengröße")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Kartengröße: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               Menuetexte.Kartengröße (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Menuetexte.Kartengröße (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Menuetexte.Kartengröße (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Menuetexte.Kartengröße (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop KartengrößeSchleife;
      
   end Kartengröße;
   
   
   
   procedure Kartenart
     (DateiExtern : in File_Type)
   is begin
      
      KartenartSchleife:
      for ZeileSchleifenwert in Menuetexte.Kartenart'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Kartenart")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Kartenart: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               Menuetexte.Kartenart (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Menuetexte.Kartenart (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Menuetexte.Kartenart (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Menuetexte.Kartenart (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop KartenartSchleife;
      
   end Kartenart;
   
   
   
   procedure Kartentemperatur
     (DateiExtern : in File_Type)
   is begin
      
      KartentemperaturSchleife:
      for ZeileSchleifenwert in Menuetexte.Kartentemperatur'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Kartentemperatur")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Kartentemperatur: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               Menuetexte.Kartentemperatur (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Menuetexte.Kartentemperatur (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Menuetexte.Kartentemperatur (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Menuetexte.Kartentemperatur (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop KartentemperaturSchleife;
      
   end Kartentemperatur;
   
   
   
   procedure Speziesauswahl
     (DateiExtern : in File_Type)
   is begin
      
      SpeziesauswahlSchleife:
      for ZeileSchleifenwert in Menuetexte.Speziesauswahl'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Speziesauswahl")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Speziesauswahl: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               Menuetexte.Speziesauswahl (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Menuetexte.Speziesauswahl (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Menuetexte.Speziesauswahl (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Menuetexte.Speziesauswahl (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop SpeziesauswahlSchleife;
      
   end Speziesauswahl;
   
   
   
   procedure Schwierigkeitsgrad
     (DateiExtern : in File_Type)
   is begin
      
      SchwierigkeitsgradSchleife:
      for ZeileSchleifenwert in Menuetexte.Schwierigkeitsgrad'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Schwierigkeitsgrad")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Schwierigkeitsgrad: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               Menuetexte.Schwierigkeitsgrad (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Menuetexte.Schwierigkeitsgrad (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Menuetexte.Schwierigkeitsgrad (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Menuetexte.Schwierigkeitsgrad (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop SchwierigkeitsgradSchleife;
      
   end Schwierigkeitsgrad;
   
   
   
   procedure Kartenform
     (DateiExtern : in File_Type)
   is begin
      
      KartenformSchleife:
      for ZeileSchleifenwert in Menuetexte.Kartenform'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Kartenform")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Kartenform: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               Menuetexte.Kartenform (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Menuetexte.Kartenform (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Menuetexte.Kartenform (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Menuetexte.Kartenform (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop KartenformSchleife;
      
   end Kartenform;
   
   
   
   procedure Ressourcenmenge
     (DateiExtern : in File_Type)
   is begin
      
      RessourcenmengeSchleife:
      for ZeileSchleifenwert in Menuetexte.Ressourcenmenge'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Ressourcenmenge")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Ressourcenmenge: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               Menuetexte.Ressourcenmenge (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Menuetexte.Ressourcenmenge (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Menuetexte.Ressourcenmenge (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Menuetexte.Ressourcenmenge (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop RessourcenmengeSchleife;
      
   end Ressourcenmenge;
   
   
   
   procedure Basisgrund
     (DateiExtern : in File_Type)
   is begin
      
      BasisgrundSchleife:
      for ZeileSchleifenwert in Kartentexte.Basisgrund'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Basisgrund")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Basisgrund: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               Kartentexte.Basisgrund (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Kartentexte.Basisgrund (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Kartentexte.Basisgrund (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Kartentexte.Basisgrund (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
                        
      end loop BasisgrundSchleife;
      
   end Basisgrund;
   
   
   
   procedure Verbesserungen
     (DateiExtern : in File_Type)
   is begin
      
      VerbesserungenSchleife:
      for ZeileSchleifenwert in Kartentexte.Verbesserungen'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Verbesserungen")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Verbesserungen: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               Kartentexte.Verbesserungen (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Kartentexte.Verbesserungen (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Kartentexte.Verbesserungen (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Kartentexte.Verbesserungen (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop VerbesserungenSchleife;
      
   end Verbesserungen;
   
   
   
   procedure Beschäftigungen
     (DateiExtern : in File_Type)
   is begin
      
      BeschäftigungenSchleife:
      for ZeileSchleifenwert in GlobaleTexte.Beschäftigungen'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Beschäftigungen")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Beschäftigungen: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               GlobaleTexte.Beschäftigungen (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 GlobaleTexte.Beschäftigungen (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => GlobaleTexte.Beschäftigungen (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  GlobaleTexte.Beschäftigungen (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop BeschäftigungenSchleife;
      
   end Beschäftigungen;
   
   
   
   procedure Würdigung
     (DateiExtern : in File_Type)
   is begin
      
      WürdigungSchleife:
      for ZeileSchleifenwert in GlobaleTexte.Würdigung'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Würdigung")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Würdigung: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               GlobaleTexte.Würdigung (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 GlobaleTexte.Würdigung (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => GlobaleTexte.Würdigung (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  GlobaleTexte.Würdigung (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop WürdigungSchleife;
      
   end Würdigung;
   
   
   
   procedure Diplomatiemenü
     (DateiExtern : in File_Type)
   is begin
      
      DiplomatiemenüSchleife:
      for ZeileSchleifenwert in Menuetexte.Diplomatiemenü'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Diplomatiemenü")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Diplomatiemenü: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               Menuetexte.Diplomatiemenü (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Menuetexte.Diplomatiemenü (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Menuetexte.Diplomatiemenü (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Menuetexte.Diplomatiemenü (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop DiplomatiemenüSchleife;
      
   end Diplomatiemenü;
   
   
   
   procedure DiplomatieKI
     (DateiExtern : in File_Type)
   is begin
      
      DiplomatieKISchleife:
      for ZeileSchleifenwert in GlobaleTexte.DiplomatieKI'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.DiplomatieKI")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.DiplomatieKI: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               GlobaleTexte.DiplomatieKI (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 GlobaleTexte.DiplomatieKI (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => GlobaleTexte.DiplomatieKI (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  GlobaleTexte.DiplomatieKI (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop DiplomatieKISchleife;
      
   end DiplomatieKI;
   
   
   
   procedure Handelsmenü
     (DateiExtern : in File_Type)
   is begin
      
      HandelsmenüSchleife:
      for ZeileSchleifenwert in GlobaleTexte.Handelsmenü'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Handelsmenü")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Handelsmenü: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               GlobaleTexte.Handelsmenü (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 GlobaleTexte.Handelsmenü (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => GlobaleTexte.Handelsmenü (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  GlobaleTexte.Handelsmenü (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop HandelsmenüSchleife;
      
   end Handelsmenü;
   
   
   
   procedure DiplomatieStatus
     (DateiExtern : in File_Type)
   is begin
      
      DiplomatieStatusSchleife:
      for ZeileSchleifenwert in GlobaleTexte.DiplomatieStatus'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.DiplomatieStatus")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.DiplomatieStatus: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               GlobaleTexte.DiplomatieStatus (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 GlobaleTexte.DiplomatieStatus (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => GlobaleTexte.DiplomatieStatus (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  GlobaleTexte.DiplomatieStatus (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop DiplomatieStatusSchleife;
      
   end DiplomatieStatus;
   
   
   
   procedure Angebot
     (DateiExtern : in File_Type)
   is begin
      
      AngebotSchleife:
      for ZeileSchleifenwert in GlobaleTexte.Angebot'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Spielmenü")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Spielmenü: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               GlobaleTexte.Angebot (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 GlobaleTexte.Angebot (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => GlobaleTexte.Angebot (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  GlobaleTexte.Angebot (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop AngebotSchleife;
      
   end Angebot;
   
   
   
   procedure Fehlermeldung
     (DateiExtern : in File_Type)
   is begin
      
      FehlermeldungSchleife:
      for ZeileSchleifenwert in Meldungstexte.Meldung'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Fehlermeldung")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Fehlermeldung: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               Meldungstexte.Meldung (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Meldungstexte.Meldung (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Meldungstexte.Meldung (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Meldungstexte.Meldung (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop FehlermeldungSchleife;
      
   end Fehlermeldung;
   
   
   
   procedure Ladezeit
     (DateiExtern : in File_Type)
   is begin
      
      LadezeitSchleife:
      for ZeileSchleifenwert in GlobaleTexte.Ladezeit'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Ladezeit")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Ladezeit: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               GlobaleTexte.Ladezeit (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 GlobaleTexte.Ladezeit (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => GlobaleTexte.Ladezeit (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  GlobaleTexte.Ladezeit (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop LadezeitSchleife;
      
   end Ladezeit;
   
   
   
   procedure Frage
     (DateiExtern : in File_Type)
   is begin
      
      FrageSchleife:
      for ZeileSchleifenwert in Meldungstexte.Frage'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Frage")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Frage: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               Meldungstexte.Frage (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Meldungstexte.Frage (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Meldungstexte.Frage (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Meldungstexte.Frage (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop FrageSchleife;
      
   end Frage;
   
   
   
   procedure ZeugSachen
     (DateiExtern : in File_Type)
   is begin
      
      ZeugSachenSchleife:
      for ZeileSchleifenwert in Meldungstexte.Zeug'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.ZeugSachen")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.ZeugSachen: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               Meldungstexte.Zeug (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Meldungstexte.Zeug (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Meldungstexte.Zeug (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Meldungstexte.Zeug (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop ZeugSachenSchleife;
      
   end ZeugSachen;
      
   
   
   procedure Editoren
     (DateiExtern : in File_Type)
   is begin
      
      EditorenSchleife:
      for ZeileSchleifenwert in Menuetexte.Editoren'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Editoren")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Editoren: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               Menuetexte.Editoren (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Menuetexte.Editoren (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Menuetexte.Editoren (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Menuetexte.Editoren (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop EditorenSchleife;
      
   end Editoren;
      
   
   
   procedure Wege
     (DateiExtern : in File_Type)
   is begin
      
      WegeSchleife:
      for ZeileSchleifenwert in Kartentexte.Wege'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Wege")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Wege: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               Kartentexte.Wege (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Kartentexte.Wege (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Kartentexte.Wege (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Kartentexte.Wege (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop WegeSchleife;
      
   end Wege;
      
   
   
   procedure Kartenflüsse
     (DateiExtern : in File_Type)
   is begin
      
      WegeSchleife:
      for ZeileSchleifenwert in Kartentexte.Kartenflüsse'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Kartenflüsse")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Kartenflüsse: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               Kartentexte.Kartenflüsse (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Kartentexte.Kartenflüsse (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Kartentexte.Kartenflüsse (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Kartentexte.Kartenflüsse (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop WegeSchleife;
      
   end Kartenflüsse;
      
   
   
   procedure Kartenressourcen
     (DateiExtern : in File_Type)
   is begin
      
      WegeSchleife:
      for ZeileSchleifenwert in Kartentexte.Kartenressourcen'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Kartenressourcen")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Kartenressourcen: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               Kartentexte.Kartenressourcen (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Kartentexte.Kartenressourcen (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                  To_Wide_Wide_String (Source => Kartentexte.Kartenressourcen (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Kartentexte.Kartenressourcen (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop WegeSchleife;
      
   end Kartenressourcen;
   
   
   
   procedure Einstellungen
     (DateiExtern : in File_Type)
   is begin
      
      EinstellungenSchleife:
      for ZeileSchleifenwert in Menuetexte.Einstellungsmenü'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Einstellungen")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Einstellungen: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               Menuetexte.Einstellungsmenü (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Menuetexte.Einstellungsmenü (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Menuetexte.Einstellungsmenü (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Menuetexte.Einstellungsmenü (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop EinstellungenSchleife;
      
   end Einstellungen;
   
   
   
   procedure Kartenpole
     (DateiExtern : in File_Type)
   is begin
      
      KartenpoleSchleife:
      for ZeileSchleifenwert in Menuetexte.Kartenpole'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Kartenpole")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Kartenpole: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               Menuetexte.Kartenpole (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Menuetexte.Kartenpole (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Menuetexte.Kartenpole (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Menuetexte.Kartenpole (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop KartenpoleSchleife;
      
   end Kartenpole;
   
   
   
   procedure Stadtbefehle
     (DateiExtern : in File_Type)
   is begin
      
      StadtbefehleSchleife:
      for ZeileSchleifenwert in Befehlstexte.Stadtbefehle'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Stadtbefehle")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Stadtbefehle: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               Befehlstexte.Stadtbefehle (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Befehlstexte.Stadtbefehle (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Befehlstexte.Stadtbefehle (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Befehlstexte.Stadtbefehle (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop StadtbefehleSchleife;
      
   end Stadtbefehle;
   
   
   
   procedure Spielstandmenü
     (DateiExtern : in File_Type)
   is begin
      
      SpielstandmenüSchleife:
      for ZeileSchleifenwert in Menuetexte.Spielstandmenü'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Spielstandmenü")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Spielstandmenü: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               Menuetexte.Spielstandmenü (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Menuetexte.Spielstandmenü (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Menuetexte.Spielstandmenü (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Menuetexte.Spielstandmenü (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop SpielstandmenüSchleife;
      
   end Spielstandmenü;
   
   
   
   procedure Intro
     (DateiExtern : in File_Type)
   is begin
      
      IntroSchleife:
      for ZeileSchleifenwert in Spieltexte.Intro'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Intro")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Intro: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               Spieltexte.Intro (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Spieltexte.Intro (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Spieltexte.Intro (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Spieltexte.Intro (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop IntroSchleife;
      
   end Intro;
   
   
   
   procedure Outro
     (DateiExtern : in File_Type)
   is begin
      
      OutroSchleife:
      for ZeileSchleifenwert in Spieltexte.Outro'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Outro")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Outro: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               Spieltexte.Outro (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Spieltexte.Outro (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Spieltexte.Outro (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Spieltexte.Outro (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop OutroSchleife;
      
   end Outro;
   
   
   
   procedure Zusatzgrund
     (DateiExtern : in File_Type)
   is begin
      
      ZusatzgrundSchleife:
      for ZeileSchleifenwert in Kartentexte.Zusatzgrund'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Zusatzgrund")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Zusatzgrund: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               Kartentexte.Zusatzgrund (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Kartentexte.Zusatzgrund (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Kartentexte.Zusatzgrund (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Kartentexte.Zusatzgrund (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop ZusatzgrundSchleife;
      
   end Zusatzgrund;
   
   
   
   procedure Feldeffekte
     (DateiExtern : in File_Type)
   is begin
      
      FeldeffekteSchleife:
      for ZeileSchleifenwert in Kartentexte.Feldeffekte'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiExtern,
                                                           AktuelleZeileExtern => ZeileSchleifenwert,
                                                           DateiExtern         => "EinlesenTextLogik.Feldeffekte")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Feldeffekte: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiExtern));
         end case;
         
         case
           Projekteinstellungen.Debug.NormalerText
         is
            when True =>
               Kartentexte.Feldeffekte (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Kartentexte.Feldeffekte (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Kartentexte.Feldeffekte (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Kartentexte.Feldeffekte (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop FeldeffekteSchleife;
      
   end Feldeffekte;

end EinlesenTextLogik;
