with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with VerzeichnisKonstanten;
with Kartentexte;
with GlobaleTexte;

with LeseOptionen;

with Fehlermeldungssystem;
with EinlesenAllgemeinesLogik;

package body EinlesenTextLogik is

   procedure EinlesenDateien
     (EinsprachigExtern : in Boolean)
   is begin
      
      case
        EinsprachigExtern
      is
         when True =>
            Einlesen (VerzeichnisExtern => (VerzeichnisKonstanten.Sprachenordner & To_Wide_Wide_String (Source => LeseOptionen.Sprache) & "/"),
                      EinsprachigExtern => EinsprachigExtern);
      
            Menuetexte.Debugmenü (1) := To_Unbounded_Wide_Wide_String (Source => "Debugmenü");
            Menuetexte.Debugmenü (2) := To_Unbounded_Wide_Wide_String (Source => "Karte aufdecken");
            Menuetexte.Debugmenü (3) := To_Unbounded_Wide_Wide_String (Source => "Alle Technologien");
            Menuetexte.Debugmenü (4) := To_Unbounded_Wide_Wide_String (Source => "Mensch/KI tauschen");
            Menuetexte.Debugmenü (5) := To_Unbounded_Wide_Wide_String (Source => "Diplomatischen Status ändern");
            Menuetexte.Debugmenü (6) := To_Unbounded_Wide_Wide_String (Source => "Volle Forschung");
            Menuetexte.Debugmenü (7) := To_Unbounded_Wide_Wide_String (Source => "Einheit erzeugen");
            Menuetexte.Debugmenü (8) := To_Unbounded_Wide_Wide_String (Source => "Einsprachig/Mehrsprachig");
            Menuetexte.Debugmenü (9) := To_Unbounded_Wide_Wide_String (Source => "Fertig");
            
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
         
               -- Das hier doch einmal auslagern? äöü
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
                  Einlesen (VerzeichnisExtern => (VerzeichnisKonstanten.Sprachenordner & Decode (Item => Simple_Name (Directory_Entry => Verzeichnis)) & "/"),
                            EinsprachigExtern => EinsprachigExtern);
               end if;
               
            end loop SprachenSchleife;
      end case;
      
   end EinlesenDateien;
      
      
      
   procedure Einlesen
     (VerzeichnisExtern : in Wide_Wide_String;
      EinsprachigExtern : in Boolean)
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
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiVerzeichnisse,
                                                            AktuelleZeileExtern => WelcheDateienSchleifenwert,
                                                            DateinameExtern     => "EinlesenTextLogik.Einlesen")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Einlesen: Fehlende Zeilen, aktuelle Zeile: " & WelcheDateienSchleifenwert'Wide_Wide_Image);
               exit EinlesenSchleife;
               
            when False =>
               EinlesenAufteilen (WelcheDateiExtern => WelcheDateienSchleifenwert,
                                  VerzeichnisExtern => VerzeichnisExtern & EinlesenAllgemeinesLogik.TextEinlesen (DateiExtern         => DateiVerzeichnisse,
                                                                                                                  AktuelleZeileExtern => WelcheDateienSchleifenwert,
                                                                                                                  DateinameExtern     => "EinlesenTextLogik.Einlesen"),
                                  EinsprachigExtern => EinsprachigExtern);
         end case;

      end loop EinlesenSchleife;

      Close (File => DateiVerzeichnisse);
      
   end Einlesen;
   
   
   
   procedure EinlesenAufteilen
     (WelcheDateiExtern : in Positive;
      VerzeichnisExtern : in Wide_Wide_String;
      EinsprachigExtern : in Boolean)
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
            Ersetzungen (DateiExtern       => DateiText,
                         EinsprachigExtern => EinsprachigExtern);
            
         when 2 =>
            Menüs (DateiExtern       => DateiText,
                    EinsprachigExtern => EinsprachigExtern);
            
         when 3 =>
            AllgemeineTexte (DateiExtern       => DateiText,
                             EinsprachigExtern => EinsprachigExtern);
            
         when 4 =>
            Sequenzen (DateiExtern       => DateiText,
                       EinsprachigExtern => EinsprachigExtern);
               
         when 5 =>
            Basisgrund (DateiExtern => DateiText,
                        EinsprachigExtern => EinsprachigExtern);
            
         when 6 =>
            Verbesserungen (DateiExtern => DateiText,
                            EinsprachigExtern => EinsprachigExtern);
               
         when 7 =>
            Beschäftigungen (DateiExtern => DateiText,
                              EinsprachigExtern => EinsprachigExtern);
               
         when 8 =>
            DiplomatieKI (DateiExtern => DateiText,
                          EinsprachigExtern => EinsprachigExtern);
               
         when 9 =>
            DiplomatieStatus (DateiExtern => DateiText,
                              EinsprachigExtern => EinsprachigExtern);
               
         when 10 =>
            Angebot (DateiExtern => DateiText,
                     EinsprachigExtern => EinsprachigExtern);
               
         when 11 =>
            Wege (DateiExtern => DateiText,
                  EinsprachigExtern => EinsprachigExtern);
               
         when 12 =>
            Kartenflüsse (DateiExtern => DateiText,
                           EinsprachigExtern => EinsprachigExtern);
               
         when 13 =>
            Kartenressourcen (DateiExtern => DateiText,
                              EinsprachigExtern => EinsprachigExtern);
            
         when 14 =>
            Zusatzgrund (DateiExtern => DateiText,
                         EinsprachigExtern => EinsprachigExtern);
            
         when 15 =>
            Feldeffekte (DateiExtern => DateiText,
                         EinsprachigExtern => EinsprachigExtern);
            
         when others =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.EinlesenAufteilen: Mehr eingelesen als möglich, Dateinummer: " & WelcheDateiExtern'Wide_Wide_Image);
      end case;
            
      Close (File => DateiText);
      
   end EinlesenAufteilen;
   
   
   
   procedure Ersetzungen
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      EinzulesendeZeile := 1;
      AktuelleZeile := 1;
      
      ErsetzungenSchleife:
      loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiExtern,
                                                            AktuelleZeileExtern => EinzulesendeZeile,
                                                            DateinameExtern     => "EinlesenTextLogik.Ersetzungen")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Ersetzungen: Einzulesende Zeile:" & EinzulesendeZeile'Wide_Wide_Image & ", aktuelle Zeile:" & AktuelleZeile'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiExtern,
                                                                                    AktuelleZeileExtern => EinzulesendeZeile,
                                                                                    DateinameExtern     => "EinlesenTextLogik.Ersetzungen");
               EinzulesendeZeile := EinzulesendeZeile + 1;
         end case;
         
         case
           To_Wide_Wide_String (Source => Zwischenspeicher) (1)
         is
            when TextKonstanten.TrennzeichenTextdateien =>
               null;
               
            when others =>
               ErsetzungenEingelesen (AktuelleZeile) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                     EingelesenerTextExtern => Zwischenspeicher,
                                                                     VorhandenerTextExtern  => ErsetzungenEingelesen (AktuelleZeile));
               
               if
                 AktuelleZeile < ErsetzungenEingelesenArray'Last
               then
                  AktuelleZeile := AktuelleZeile + 1;
                  
               else
                  return;
               end if;
         end case;
         
      end loop ErsetzungenSchleife;
      
   end Ersetzungen;
   
   
   
   procedure Menüs
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      EinzulesendeZeile := 1;
      AktuelleZeile := 1;
      
      MenüSchleife:
      loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiExtern,
                                                            AktuelleZeileExtern => EinzulesendeZeile,
                                                            DateinameExtern     => "EinlesenTextLogik.Menüs")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Menüs: Einzulesende Zeile:" & EinzulesendeZeile'Wide_Wide_Image & ", aktuelle Zeile:" & AktuelleZeile'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := TextErsetzen (TextExtern => EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiExtern,
                                                                                                                AktuelleZeileExtern => EinzulesendeZeile,
                                                                                                                DateinameExtern     => "EinlesenTextLogik.Menüs"));
               EinzulesendeZeile := EinzulesendeZeile + 1;
         end case;
         
         case
           To_Wide_Wide_String (Source => Zwischenspeicher) (1)
         is
            when TextKonstanten.TrennzeichenTextdateien =>
               null;
               
            when others =>
               if
                 AktuelleZeile <= Hauptmenü
               then
                  Menuetexte.Hauptmenü (AktuelleZeile) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                        EingelesenerTextExtern => Zwischenspeicher,
                                                                        VorhandenerTextExtern  => Menuetexte.Hauptmenü (AktuelleZeile));
                  
               elsif
                 AktuelleZeile in Hauptmenü + 1 .. Spielmenü
               then
                  Menuetexte.Spielmenü (AktuelleZeile - Hauptmenü) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                     EingelesenerTextExtern => Zwischenspeicher,
                                                                                     VorhandenerTextExtern  => Menuetexte.Spielmenü (AktuelleZeile - Hauptmenü));
                  
               elsif
                 AktuelleZeile in Spielmenü + 1 .. Optionsmenü
               then
                  Menuetexte.Optionsmenü (AktuelleZeile - Spielmenü) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                       EingelesenerTextExtern => Zwischenspeicher,
                                                                                       VorhandenerTextExtern  => Menuetexte.Optionsmenü (AktuelleZeile - Spielmenü));
                  
               elsif
                 AktuelleZeile in Optionsmenü + 1 .. Grafikmenü
               then
                  Menuetexte.Grafikmenü (AktuelleZeile - Optionsmenü) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                        EingelesenerTextExtern => Zwischenspeicher,
                                                                                        VorhandenerTextExtern  => Menuetexte.Grafikmenü (AktuelleZeile - Optionsmenü));
                  
               elsif
                 AktuelleZeile in Grafikmenü + 1 .. Soundmenü
               then
                  Menuetexte.Soundmenü (AktuelleZeile - Grafikmenü) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                      EingelesenerTextExtern => Zwischenspeicher,
                                                                                      VorhandenerTextExtern  => Menuetexte.Soundmenü (AktuelleZeile - Grafikmenü));
                  
               elsif
                 AktuelleZeile in Soundmenü + 1 .. Steuerungsmenü
               then
                  Menuetexte.Steuerungsmenü (AktuelleZeile - Soundmenü) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                          EingelesenerTextExtern => Zwischenspeicher,
                                                                                          VorhandenerTextExtern  => Menuetexte.Steuerungsmenü (AktuelleZeile - Soundmenü));
                  
               elsif
                 AktuelleZeile in Steuerungsmenü + 1 .. Sonstigesmenü
               then
                  Menuetexte.Sonstigesmenü (AktuelleZeile - Steuerungsmenü) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                              EingelesenerTextExtern => Zwischenspeicher,
                                                                                              VorhandenerTextExtern  => Menuetexte.Sonstigesmenü (AktuelleZeile - Steuerungsmenü));
                  
               elsif
                 AktuelleZeile in Sonstigesmenü + 1 .. Kartengröße
               then
                  Menuetexte.Kartengröße (AktuelleZeile - Sonstigesmenü) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                            EingelesenerTextExtern => Zwischenspeicher,
                                                                                            VorhandenerTextExtern  => Menuetexte.Kartengröße (AktuelleZeile - Sonstigesmenü));
                  
               elsif
                 AktuelleZeile in Kartengröße + 1 .. Kartenart
               then
                  Menuetexte.Kartenart (AktuelleZeile - Kartengröße) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                       EingelesenerTextExtern => Zwischenspeicher,
                                                                                       VorhandenerTextExtern  => Menuetexte.Kartenart (AktuelleZeile - Kartengröße));
                  
               elsif
                 AktuelleZeile in Kartenart + 1 .. Kartentemperatur
               then
                  Menuetexte.Kartentemperatur (AktuelleZeile - Kartenart) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                          EingelesenerTextExtern => Zwischenspeicher,
                                                                                          VorhandenerTextExtern  => Menuetexte.Kartentemperatur (AktuelleZeile - Kartenart));
                  
               elsif
                 AktuelleZeile in Kartentemperatur + 1 .. Speziesauswahl
               then
                  Menuetexte.Speziesauswahl (AktuelleZeile - Kartentemperatur) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                               EingelesenerTextExtern => Zwischenspeicher,
                                                                                               VorhandenerTextExtern  => Menuetexte.Speziesauswahl (AktuelleZeile - Kartentemperatur));
                  
               elsif
                 AktuelleZeile in Speziesauswahl + 1 .. Schwierigkeitsgrad
               then
                  Menuetexte.Schwierigkeitsgrad (AktuelleZeile - Speziesauswahl) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                 EingelesenerTextExtern => Zwischenspeicher,
                                                                                                 VorhandenerTextExtern  => Menuetexte.Schwierigkeitsgrad (AktuelleZeile - Speziesauswahl));
                  
               elsif
                 AktuelleZeile in Schwierigkeitsgrad + 1 .. Kartenform
               then
                  Menuetexte.Kartenform (AktuelleZeile - Schwierigkeitsgrad) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                             EingelesenerTextExtern => Zwischenspeicher,
                                                                                             VorhandenerTextExtern  => Menuetexte.Kartenform (AktuelleZeile - Schwierigkeitsgrad));
                  
               elsif
                 AktuelleZeile in Kartenform + 1 .. Ressourcenmenge
               then
                  Menuetexte.Ressourcenmenge (AktuelleZeile - Kartenform) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                          EingelesenerTextExtern => Zwischenspeicher,
                                                                                          VorhandenerTextExtern  => Menuetexte.Ressourcenmenge (AktuelleZeile - Kartenform));
                  
               elsif
                 AktuelleZeile in Ressourcenmenge + 1 .. Diplomatiemenü
               then
                  Menuetexte.Diplomatiemenü (AktuelleZeile - Ressourcenmenge) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                               EingelesenerTextExtern => Zwischenspeicher,
                                                                                               VorhandenerTextExtern  => Menuetexte.Diplomatiemenü (AktuelleZeile - Ressourcenmenge));
                  
               elsif
                 AktuelleZeile in Diplomatiemenü + 1 .. Einstellungsmenü
               then
                  Menuetexte.Einstellungsmenü (AktuelleZeile - Diplomatiemenü) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                 EingelesenerTextExtern => Zwischenspeicher,
                                                                                                 VorhandenerTextExtern  => Menuetexte.Einstellungsmenü (AktuelleZeile - Diplomatiemenü));
                  
               elsif
                 AktuelleZeile in Einstellungsmenü + 1 .. Kartenpole
               then
                  Menuetexte.Kartenpole (AktuelleZeile - Einstellungsmenü) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                            EingelesenerTextExtern => Zwischenspeicher,
                                                                                            VorhandenerTextExtern  => Menuetexte.Kartenpole (AktuelleZeile - Einstellungsmenü));
                  
               elsif
                 AktuelleZeile in Kartenpole + 1 .. Spielstandmenü
               then
                  Menuetexte.Spielstandmenü (AktuelleZeile - Kartenpole) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                          EingelesenerTextExtern => Zwischenspeicher,
                                                                                          VorhandenerTextExtern  => Menuetexte.Spielstandmenü (AktuelleZeile - Kartenpole));
                  
               elsif
                 AktuelleZeile in Spielstandmenü + 1 .. Editorenmenü
               then
                  Menuetexte.Editorenmenü (AktuelleZeile - Spielstandmenü) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                             EingelesenerTextExtern => Zwischenspeicher,
                                                                                             VorhandenerTextExtern  => Menuetexte.Editorenmenü (AktuelleZeile - Spielstandmenü));
                  
               elsif
                 AktuelleZeile in Editorenmenü + 1 .. Handelsmenü
               then
                  Menuetexte.Handelsmenü (AktuelleZeile - Editorenmenü) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                          EingelesenerTextExtern => Zwischenspeicher,
                                                                                          VorhandenerTextExtern  => Menuetexte.Editorenmenü (AktuelleZeile - Editorenmenü));
                  
                  -- Das else hier kann für das letzte Menü verwendet werden. äöü
               else
                  return;
               end if;
               
               if
                 AktuelleZeile < Handelsmenü
               then
                  AktuelleZeile := AktuelleZeile + 1;
                     
               else
                  return;
               end if;
         end case;
         
      end loop MenüSchleife;
      
   end Menüs;
   
   
   
   procedure AllgemeineTexte
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      EinzulesendeZeile := 1;
      AktuelleZeile := 1;
      
      MeldungSchleife:
      loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiExtern,
                                                            AktuelleZeileExtern => EinzulesendeZeile,
                                                            DateinameExtern     => "EinlesenTextLogik.AllgemeineTexte")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Meldungen: Einzulesende Zeile:" & EinzulesendeZeile'Wide_Wide_Image & ", aktuelle Zeile:" & AktuelleZeile'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := TextErsetzen (TextExtern => EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiExtern,
                                                                                                                AktuelleZeileExtern => EinzulesendeZeile,
                                                                                                                DateinameExtern     => "EinlesenTextLogik.AllgemeineTexte"));
               EinzulesendeZeile := EinzulesendeZeile + 1;
         end case;
         
         case
           To_Wide_Wide_String (Source => Zwischenspeicher) (1)
         is
            when TextKonstanten.TrennzeichenTextdateien =>
               null;
               
            when others =>
               if
                 AktuelleZeile <= Fragen
               then
                  Spieltexte.Fragen (AktuelleZeile) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                    EingelesenerTextExtern => Zwischenspeicher,
                                                                    VorhandenerTextExtern  => Spieltexte.Fragen (AktuelleZeile));
                  
               elsif
                 AktuelleZeile in Fragen + 1 .. Meldungen
               then
                  Spieltexte.Meldungen (AktuelleZeile - Fragen) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                EingelesenerTextExtern => Zwischenspeicher,
                                                                                VorhandenerTextExtern  => Spieltexte.Meldungen (AktuelleZeile - Fragen));
                  
               elsif
                 AktuelleZeile in Meldungen + 1 .. Würdigungen
               then
                  Spieltexte.Würdigung (AktuelleZeile - Meldungen) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                    EingelesenerTextExtern => Zwischenspeicher,
                                                                                    VorhandenerTextExtern  => Spieltexte.Würdigung (AktuelleZeile - Meldungen));
                  
               elsif
                 AktuelleZeile in Würdigungen + 1 .. Zeug
               then
                  Spieltexte.Zeug (AktuelleZeile - Würdigungen) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                 EingelesenerTextExtern => Zwischenspeicher,
                                                                                 VorhandenerTextExtern  => Spieltexte.Zeug (AktuelleZeile - Würdigungen));
                  
               elsif
                 AktuelleZeile in Zeug + 1 .. Stadtbefehle
               then
                  Spieltexte.Stadtbefehle (AktuelleZeile - Zeug) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                         EingelesenerTextExtern => Zwischenspeicher,
                                                                         VorhandenerTextExtern  => Spieltexte.Zeug (AktuelleZeile - Zeug));
                  
               elsif
                 AktuelleZeile in Stadtbefehle + 1 .. Ladezeiten
               then
                  Spieltexte.Ladezeit (AktuelleZeile - Stadtbefehle) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                     EingelesenerTextExtern => Zwischenspeicher,
                                                                                     VorhandenerTextExtern  => Spieltexte.Zeug (AktuelleZeile - Stadtbefehle));
                  
                  -- Das else hier kann für das letzte Menü verwendet werden. äöü
               else
                  return;
               end if;
               
               if
                 AktuelleZeile < Ladezeiten
               then
                  AktuelleZeile := AktuelleZeile + 1;
                     
               else
                  return;
               end if;
         end case;
         
      end loop MeldungSchleife;
      
   end AllgemeineTexte;
   
   
   
   procedure Sequenzen
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      EinzulesendeZeile := 1;
      AktuelleZeile := 1;
      
      SequenzenSchleife:
      loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiExtern,
                                                            AktuelleZeileExtern => EinzulesendeZeile,
                                                            DateinameExtern     => "EinlesenTextLogik.Sequenzen")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Sequenzen: Einzulesende Zeile:" & EinzulesendeZeile'Wide_Wide_Image & ", aktuelle Zeile:" & AktuelleZeile'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := TextErsetzen (TextExtern => EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiExtern,
                                                                                                                AktuelleZeileExtern => EinzulesendeZeile,
                                                                                                                DateinameExtern     => "EinlesenTextLogik.Sequenzen"));
               EinzulesendeZeile := EinzulesendeZeile + 1;
         end case;
         
         case
           To_Wide_Wide_String (Source => Zwischenspeicher) (1)
         is
            when TextKonstanten.TrennzeichenTextdateien =>
               null;
               
            when others =>
               if
                 AktuelleZeile <= Intro
               then
                  Sequenzentexte.Intro (AktuelleZeile) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                       EingelesenerTextExtern => Zwischenspeicher,
                                                                       VorhandenerTextExtern  => Sequenzentexte.Intro (AktuelleZeile));
                  
               elsif
                 AktuelleZeile in Intro + 1 .. Outro
               then
                  Sequenzentexte.Outro (AktuelleZeile - Intro) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                               EingelesenerTextExtern => Zwischenspeicher,
                                                                               VorhandenerTextExtern  => Sequenzentexte.Outro (AktuelleZeile - Intro));
                  
                  -- Das else hier kann für das letzte Menü verwendet werden. äöü
               else
                  return;
               end if;
               
               if
                 AktuelleZeile < Outro
               then
                  AktuelleZeile := AktuelleZeile + 1;
                     
               else
                  return;
               end if;
         end case;
         
      end loop SequenzenSchleife;
      
   end Sequenzen;
   
   
   
   procedure Basisgrund
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      BasisgrundSchleife:
      for ZeileSchleifenwert in Kartentexte.Basisgrund'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiExtern,
                                                            AktuelleZeileExtern => ZeileSchleifenwert,
                                                            DateinameExtern     => "EinlesenTextLogik.Basisgrund")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Basisgrund: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiExtern,
                                                                                    AktuelleZeileExtern => ZeileSchleifenwert,
                                                                                    DateinameExtern     => "EinlesenTextLogik.Basisgrund");
         end case;
         
         case
           EinsprachigExtern
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
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      VerbesserungenSchleife:
      for ZeileSchleifenwert in Kartentexte.Verbesserungen'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiExtern,
                                                            AktuelleZeileExtern => ZeileSchleifenwert,
                                                            DateinameExtern     => "EinlesenTextLogik.Verbesserungen")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Verbesserungen: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiExtern,
                                                                                    AktuelleZeileExtern => ZeileSchleifenwert,
                                                                                    DateinameExtern     => "EinlesenTextLogik.Verbesserungen");
         end case;
         
         case
           EinsprachigExtern
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
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      BeschäftigungenSchleife:
      for ZeileSchleifenwert in Spieltexte.Beschäftigungen'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiExtern,
                                                            AktuelleZeileExtern => ZeileSchleifenwert,
                                                            DateinameExtern     => "EinlesenTextLogik.Beschäftigungen")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Beschäftigungen: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiExtern,
                                                                                    AktuelleZeileExtern => ZeileSchleifenwert,
                                                                                    DateinameExtern     => "EinlesenTextLogik.Beschäftigungen");
         end case;
         
         case
           EinsprachigExtern
         is
            when True =>
               Spieltexte.Beschäftigungen (ZeileSchleifenwert) := Zwischenspeicher;
               
            when False =>
               if
                 Spieltexte.Beschäftigungen (ZeileSchleifenwert) = TextKonstanten.FehlenderText
                 or
                   To_Wide_Wide_String (Source => Spieltexte.Beschäftigungen (ZeileSchleifenwert))'Length < To_Wide_Wide_String (Source => Zwischenspeicher)'Length
               then
                  Spieltexte.Beschäftigungen (ZeileSchleifenwert) := Zwischenspeicher;
                  
               else
                  null;
               end if;
         end case;
         
      end loop BeschäftigungenSchleife;
      
   end Beschäftigungen;
   
   
   
   procedure DiplomatieKI
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      DiplomatieKISchleife:
      for ZeileSchleifenwert in GlobaleTexte.DiplomatieKI'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiExtern,
                                                            AktuelleZeileExtern => ZeileSchleifenwert,
                                                            DateinameExtern     => "EinlesenTextLogik.DiplomatieKI")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.DiplomatieKI: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiExtern,
                                                                                    AktuelleZeileExtern => ZeileSchleifenwert,
                                                                                    DateinameExtern     => "EinlesenTextLogik.DiplomatieKI");
         end case;
         
         case
           EinsprachigExtern
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
   
   
   
   procedure DiplomatieStatus
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      DiplomatieStatusSchleife:
      for ZeileSchleifenwert in GlobaleTexte.DiplomatieStatus'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiExtern,
                                                            AktuelleZeileExtern => ZeileSchleifenwert,
                                                            DateinameExtern     => "EinlesenTextLogik.DiplomatieStatus")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.DiplomatieStatus: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiExtern,
                                                                                    AktuelleZeileExtern => ZeileSchleifenwert,
                                                                                    DateinameExtern     => "EinlesenTextLogik.DiplomatieStatus");
         end case;
         
         case
           EinsprachigExtern
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
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      AngebotSchleife:
      for ZeileSchleifenwert in GlobaleTexte.Angebot'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiExtern,
                                                            AktuelleZeileExtern => ZeileSchleifenwert,
                                                            DateinameExtern     => "EinlesenTextLogik.Spielmenü")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Spielmenü: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiExtern,
                                                                                    AktuelleZeileExtern => ZeileSchleifenwert,
                                                                                    DateinameExtern     => "EinlesenTextLogik.Spielmenü");
         end case;
         
         case
           EinsprachigExtern
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
      
   
   
   procedure Wege
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      WegeSchleife:
      for ZeileSchleifenwert in Kartentexte.Wege'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiExtern,
                                                            AktuelleZeileExtern => ZeileSchleifenwert,
                                                            DateinameExtern     => "EinlesenTextLogik.Wege")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Wege: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiExtern,
                                                                                    AktuelleZeileExtern => ZeileSchleifenwert,
                                                                                    DateinameExtern     => "EinlesenTextLogik.Wege");
         end case;
         
         case
           EinsprachigExtern
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
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      WegeSchleife:
      for ZeileSchleifenwert in Kartentexte.Kartenflüsse'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiExtern,
                                                            AktuelleZeileExtern => ZeileSchleifenwert,
                                                            DateinameExtern     => "EinlesenTextLogik.Kartenflüsse")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Kartenflüsse: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiExtern,
                                                                                    AktuelleZeileExtern => ZeileSchleifenwert,
                                                                                    DateinameExtern     => "EinlesenTextLogik.Kartenflüsse");
         end case;
         
         case
           EinsprachigExtern
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
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      WegeSchleife:
      for ZeileSchleifenwert in Kartentexte.Kartenressourcen'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiExtern,
                                                            AktuelleZeileExtern => ZeileSchleifenwert,
                                                            DateinameExtern     => "EinlesenTextLogik.Kartenressourcen")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Kartenressourcen: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiExtern,
                                                                                    AktuelleZeileExtern => ZeileSchleifenwert,
                                                                                    DateinameExtern     => "EinlesenTextLogik.Kartenressourcen");
         end case;
         
         case
           EinsprachigExtern
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
   
   
   
   procedure Zusatzgrund
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      ZusatzgrundSchleife:
      for ZeileSchleifenwert in Kartentexte.Zusatzgrund'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiExtern,
                                                            AktuelleZeileExtern => ZeileSchleifenwert,
                                                            DateinameExtern     => "EinlesenTextLogik.Zusatzgrund")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Zusatzgrund: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiExtern,
                                                                                    AktuelleZeileExtern => ZeileSchleifenwert,
                                                                                    DateinameExtern     => "EinlesenTextLogik.Zusatzgrund");
         end case;
         
         case
           EinsprachigExtern
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
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      FeldeffekteSchleife:
      for ZeileSchleifenwert in Kartentexte.Feldeffekte'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiExtern,
                                                            AktuelleZeileExtern => ZeileSchleifenwert,
                                                            DateinameExtern     => "EinlesenTextLogik.Feldeffekte")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.Feldeffekte: Fehlende Zeilen, aktuelle Zeile: " & ZeileSchleifenwert'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiExtern,
                                                                                    AktuelleZeileExtern => ZeileSchleifenwert,
                                                                                    DateinameExtern     => "EinlesenTextLogik.Feldeffekte");
         end case;
         
         case
           EinsprachigExtern
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
   
   
   
   function TextErsetzen
     (TextExtern : in Unbounded_Wide_Wide_String)
      return Unbounded_Wide_Wide_String
   is begin
      
      ErsetzungSchleife:
      for ErsetzungSchleifenwert in ErsetzungenEingelesenArray'Range loop
         
         if
           TextExtern = '~' & ZahlAlsString (ZahlExtern => ErsetzungSchleifenwert) & '~'
         then
            return ErsetzungenEingelesen (ErsetzungSchleifenwert);
            
         else
            null;
         end if;
         
      end loop ErsetzungSchleife;
        
      return TextExtern;
      
   end TextErsetzen;
   
   
   
   -- Das nach EinlesenAllgemeinesLogik verschieben? äöü
   function Einsprachig
     (EinsprachigExtern : in Boolean;
      EingelesenerTextExtern : in Unbounded_Wide_Wide_String;
      VorhandenerTextExtern : in Unbounded_Wide_Wide_String)
      return Unbounded_Wide_Wide_String
   is begin
      
      case
        EinsprachigExtern
      is
         when True =>
            return EingelesenerTextExtern;
               
         when False =>
            if
              VorhandenerTextExtern = TextKonstanten.FehlenderText
              or
                To_Wide_Wide_String (Source => VorhandenerTextExtern)'Length < To_Wide_Wide_String (Source => EingelesenerTextExtern)'Length
            then
               return EingelesenerTextExtern;
                  
            else
               return VorhandenerTextExtern;
            end if;
      end case;
      
   end Einsprachig;

end EinlesenTextLogik;
