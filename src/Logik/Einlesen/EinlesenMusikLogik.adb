with Sf.Audio.Music;

with MeldungssystemHTB1;
with DateizugriffssystemHTB5;
with UmwandlungssystemHTB3;

with VerzeichnisKonstanten;
with TextKonstanten;

with LeseOptionen;

with EingeleseneMusik;
with EinlesenAllgemeinesLogik;
with VerzeichnisDateinamenTests;

-- with DiagnosesystemHTB4;

-- Unter Windows funktionieren UTF8 Namen bei den Texturdateien nicht, das beim Benennen der Texturen berücksichtigen.
-- Eventuell kann auch einfach die SFML hier kein UTF8.
-- Gilt das auch für Audiodateien? Vermutlich ja, aber trotzdem mal nachprüfen. äöü
-- Könnte man Einlesen Texturen, Musik und später Sound zusammenfassen? Eventuell in dem man den Dateiort mitübergibt und die Festlegung in einzelne Bereiche unterteilt. äöü
package body EinlesenMusikLogik is

   procedure EinlesenMusik
   is begin
      
      case
        -- Bie Linux wird hier Leer Übergeben weil ja nur das Nullverzeichnis "/0" geprüft werden muss und nicht dder ganze Verzeichnisname.
        VerzeichnisDateinamenTests.StandardeinleseprüfungNeu (LinuxTextExtern   => TextKonstanten.LeerString,
                                                               WindowsTextExtern => (VerzeichnisKonstanten.Musik & To_Wide_Wide_String (Source => LeseOptionen.Musik) & VerzeichnisKonstanten.NullDateiWideWide))
      is
         when False =>
            return;
            
         when True =>
            EinzulesendeZeile := 1;
            AktuelleZeile := 1;
            
            DateizugriffssystemHTB5.ÖffnenText (DateiartExtern => DateiMusik,
                                                 NameExtern     => UmwandlungssystemHTB3.Encode (TextExtern => VerzeichnisKonstanten.Musik & To_Wide_Wide_String (Source => LeseOptionen.Musik)
                                                                                                 & VerzeichnisKonstanten.NullDateiWideWide));
      end case;
      
      MusikSchleife:
      loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiMusik,
                                                            AktuelleZeileExtern => EinzulesendeZeile,
                                                            DateinameExtern     => "EinlesenMusikLogik.EinlesenMusik")
         is
            when True =>
               MeldungssystemHTB1.Logik (MeldungExtern => "EinlesenMusikLogik.EinlesenMusik: Einzulesende Zeile:" & EinzulesendeZeile'Wide_Wide_Image & ", aktuelle Zeile:" & AktuelleZeile'Wide_Wide_Image);
               exit MusikSchleife;
               
            when False =>
               Dateiname := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiMusik,
                                                                             AktuelleZeileExtern => EinzulesendeZeile,
                                                                             DateinameExtern     => "EinlesenMusikLogik.EinlesenMusik");
               GesamterPfad := VerzeichnisKonstanten.Musik & LeseOptionen.Musik & "/" & Dateiname;
               EinzulesendeZeile := EinzulesendeZeile + 1;
         end case;
         
         case
           To_Wide_Wide_String (Source => Dateiname) (1)
         is
            when TextKonstanten.TrennzeichenTextdateien =>
               null;
               
            when others =>
               if
                 False = VerzeichnisDateinamenTests.StandardeinleseprüfungNeu (LinuxTextExtern   => To_Wide_Wide_String (Source => Dateiname),
                                                                                WindowsTextExtern => To_Wide_Wide_String (Source => GesamterPfad))
               then
                  MeldungssystemHTB1.Logik (MeldungExtern => "EinlesenMusikLogik.EinlesenMusik: Datei oder Pfad existiert nicht");
            
               elsif
                 AktuelleZeile = Intromusik
               then
                  EingeleseneMusik.Intromusik (AktuelleZeile) := Sf.Audio.Music.createFromFile (filename => UmwandlungssystemHTB3.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile in StandardmusikAnfang .. StandardmusikEnde
               then
                  EingeleseneMusik.Standardmusik (AktuelleZeile - 1) := Sf.Audio.Music.createFromFile (filename => UmwandlungssystemHTB3.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Forschungserfolg
               then
                  EingeleseneMusik.Forschungserfolg (Forschungserfolg - StandardmusikEnde) := Sf.Audio.Music.createFromFile (filename => UmwandlungssystemHTB3.EncodeUnbounded (TextExtern => GesamterPfad));
               
               else
                  MeldungssystemHTB1.Logik (MeldungExtern => "EinlesenTexturenLogik.EinlesenMusik: Außerhalb des Einlesebereichs");
                  exit MusikSchleife;
               end if;
               
               if
                 AktuelleZeile < Forschungserfolg
               then
                  AktuelleZeile := AktuelleZeile + 1;
                     
               else
                  -- Hier die Lautstärkeneinstellung aufrufen? äöü
                  -- TexturenfelderBerechnenGrafik.TexturenfelderBerechnen;
                  exit MusikSchleife;
               end if;
         end case;
         
      end loop MusikSchleife;
      
      Close (File => DateiMusik);
      
   end EinlesenMusik;

end EinlesenMusikLogik;
