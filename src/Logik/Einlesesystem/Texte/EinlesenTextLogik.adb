with DateizugriffssystemHTSEB;
with DateisystemtestsHTSEB;
with TextKonstantenHTSEB;
with MeldungssystemHTSEB;
with EinlesenAllgemeinesHTSEB;
with UmwandlungssystemHTSEB;

with VerzeichnisKonstanten;
with SpeziesKonstanten;
with SpeziesDatentypen;

with LeseOptionen;

with EinlesenTextSonstigesLogik;
with EinlesenTextMenuesLogik;
with EinlesenTextAllgemeinesLogik;
with EinlesenTextSequenzenLogik;
with EinlesenTextSpeziesLogik;
with EinlesenTextKarteLogik;
with EinlesenTextRohstoffeLogik;

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
      
            EinlesenTextSonstigesLogik.Debugmenü;
            
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
               
               if
                 DateisystemtestsHTSEB.GültigerNamen (NameExtern => UmwandlungssystemHTSEB.Decode (TextExtern => Simple_Name (Directory_Entry => Verzeichnis))) = False
               then
                  null;
                  
               elsif
                 False = DateisystemtestsHTSEB.GültigeZeichenlänge (LinuxTextExtern   => TextKonstantenHTSEB.LeerUnboundedString,
                                                                      WindowsTextExtern => UmwandlungssystemHTSEB.DecodeUnbounded (TextExtern => VerzeichnisKonstanten.SprachenStrich
                                                                                                                                   & Simple_Name (Directory_Entry => Verzeichnis)
                                                                                                                                   & VerzeichnisKonstanten.NullDatei))
               then
                  null;
             
               elsif
                 Exists (Name => VerzeichnisKonstanten.SprachenStrich & Simple_Name (Directory_Entry => Verzeichnis) & VerzeichnisKonstanten.NullDatei) = False
               then
                  null;
            
               else
                  Einlesen (VerzeichnisExtern => (VerzeichnisKonstanten.Sprachenordner & UmwandlungssystemHTSEB.Decode (TextExtern => Simple_Name (Directory_Entry => Verzeichnis)) & "/"),
                            EinsprachigExtern => EinsprachigExtern);
               end if;
               
            end loop SprachenSchleife;
            
            End_Search (Search => Suche);
      end case;
      
   end EinlesenDateien;
      
      
      
   procedure Einlesen
     (VerzeichnisExtern : in Wide_Wide_String;
      EinsprachigExtern : in Boolean)
   is begin
      
      case
        DateisystemtestsHTSEB.Standardeinleseprüfung (LinuxTextExtern   => TextKonstantenHTSEB.LeerString,
                                                       WindowsTextExtern => VerzeichnisExtern & "0")
      is
         when False =>
            return;
            
         when True =>
            EinzulesendeDateizeile := 1;
            AktuelleDateizeile := 1;
            
            
            DateizugriffssystemHTSEB.ÖffnenText (DateiartExtern => DateiVerzeichnisse,
                                                  NameExtern     => UmwandlungssystemHTSEB.Encode (TextExtern => VerzeichnisExtern & "0"));
      end case;
      
      EinlesenSchleife:
      loop

         case
           EinlesenAllgemeinesHTSEB.VorzeitigesDateienende (AktuelleDateiExtern => DateiVerzeichnisse,
                                                            AktuelleZeileExtern => EinzulesendeDateizeile,
                                                            DateinameExtern     => "EinlesenTextLogik.Einlesen")
         is
            when True =>
               MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenTextLogik.Einlesen: Einzulesende Zeile:" & EinzulesendeZeile'Wide_Wide_Image & ", aktuelle Zeile:" & AktuelleZeile'Wide_Wide_Image);
               exit EinlesenSchleife;
               
            when False =>
               Dateiname := EinlesenAllgemeinesHTSEB.DateinamenEinlesenUngebunden (DateiExtern         => DateiVerzeichnisse,
                                                                                   AktuelleZeileExtern => EinzulesendeDateizeile,
                                                                                   DateinameExtern     => "EinlesenTextLogik.Einlesen");
               GesamterPfad := VerzeichnisExtern & "/" & Dateiname;
               
               
               EinzulesendeDateizeile := EinzulesendeDateizeile + 1;
         end case;
         
         case
           EinlesenAllgemeinesHTSEB.ZeileVerwenden (DateinameExtern => Dateiname)
         is
            when False =>
               null;
               
            when True =>
               if
                 False = DateisystemtestsHTSEB.Standardeinleseprüfung (LinuxTextExtern   => To_Wide_Wide_String (Source => Dateiname),
                                                                        WindowsTextExtern => To_Wide_Wide_String (Source => GesamterPfad))
               then
                  MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenTextLogik.Einlesen: Datei oder Pfad existiert nicht");
               
               elsif
                 AktuelleDateizeile in 1 .. AnzahlTextdateien
               then
                  EinlesenAufteilen (WelcheDateiExtern => AktuelleDateizeile,
                                     DateipfadExtern   => To_Wide_Wide_String (Source => GesamterPfad),
                                     EinsprachigExtern => EinsprachigExtern);
            
               else
                  MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenTextLogik.Einlesen: Außerhalb des Einlesebereichs");
                  exit EinlesenSchleife;
               end if;
            
               if
                 AktuelleDateizeile < AnzahlTextdateien
               then
                  AktuelleDateizeile := AktuelleDateizeile + 1;
                     
               else
                  exit EinlesenSchleife;
               end if;
         end case;

      end loop EinlesenSchleife;
   
      DateizugriffssystemHTSEB.SchließenText (DateiartExtern => DateiVerzeichnisse,
                                               NameExtern     => UmwandlungssystemHTSEB.Encode (TextExtern => VerzeichnisExtern & "0"));
      
   end Einlesen;
   
   
   
   procedure EinlesenAufteilen
     (WelcheDateiExtern : in Positive;
      DateipfadExtern : in Wide_Wide_String;
      EinsprachigExtern : in Boolean)
   is begin
      
      DateizugriffssystemHTSEB.ÖffnenTextWideWide (DateiartExtern => DateiText,
                                                    NameExtern     => DateipfadExtern);
      
      case
        WelcheDateiExtern
      is
         when DateiErsetzungen =>
            EinlesenTextSonstigesLogik.Ersetzungen (DateiExtern       => DateiText,
                                                    EinsprachigExtern => EinsprachigExtern);
            
         when DateiMenüs =>
            EinlesenTextMenuesLogik.Menüs (DateiExtern       => DateiText,
                                            EinsprachigExtern => EinsprachigExtern);
            
         when DateiAllgemeineTexte =>
            EinlesenTextAllgemeinesLogik.AllgemeineTexte (DateiExtern       => DateiText,
                                                          EinsprachigExtern => EinsprachigExtern);
            
         when DateiSequenzen =>
            EinlesenTextSequenzenLogik.Sequenzen (DateiExtern       => DateiText,
                                                  EinsprachigExtern => EinsprachigExtern);
               
         when DateiKarte =>
            EinlesenTextKarteLogik.Karte (DateiExtern       => DateiText,
                                          EinsprachigExtern => EinsprachigExtern);
            
         when DateiRohstoffe =>
            EinlesenTextRohstoffeLogik.Rohstoffe (DateiExtern       => DateiText,
                                                  EinsprachigExtern => EinsprachigExtern);
            
         when DateiSpezies + SpeziesKonstanten.Speziesanfang .. DateiSpezies + SpeziesKonstanten.Speziesende =>
            EinlesenTextSpeziesLogik.Spezies (DateiExtern       => DateiText,
                                              EinsprachigExtern => EinsprachigExtern,
                                              SpeziesExtern     => SpeziesDatentypen.Spezies_Vorhanden_Enum'Val (WelcheDateiExtern - DateiSpezies));
            
         when others =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenTextLogik.EinlesenAufteilen: Mehr eingelesen als möglich, Dateinummer: " & WelcheDateiExtern'Wide_Wide_Image);
      end case;
            
      DateizugriffssystemHTSEB.SchließenTextWideWide (DateiartExtern => DateiText,
                                                       NameExtern     => DateipfadExtern);
      
   end EinlesenAufteilen;

end EinlesenTextLogik;
