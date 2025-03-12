with Sf.Audio.Music;

with MeldungssystemHTSEB;
with DateizugriffssystemHTSEB;
with UmwandlungssystemHTSEB;
with DateisystemtestsHTSEB;

with VerzeichnisKonstanten;
with TextKonstanten;

with LeseOptionen;

with EinlesenAllgemeinesLogik;
with EinstellungenMusik;

-- Unter Windows funktionieren UTF8 Namen bei den Texturdateien nicht, das beim Benennen der Texturen berücksichtigen.
-- Eventuell kann auch einfach die SFML hier kein UTF8.
-- Gilt das auch für Audiodateien? Vermutlich ja, aber trotzdem mal nachprüfen. äöü
-- Könnte man Einlesen Texturen, Musik und später Sound zusammenfassen? Eventuell in dem man den Dateiort mitübergibt und die Festlegung in einzelne Bereiche unterteilt. äöü

-- Von hier aus die Musiklautstärke einstellen, damit beim Wechsel der Musik alles gleich wieder eingestellt wird! äöü
-- Muss auch beim Sound gemacht werden! äöü
package body EinlesenMusikLogik is

   procedure EinlesenMusik
   is begin
      
      case
        -- Bie Linux wird hier Leer Übergeben weil ja nur das Nullverzeichnis "/0" geprüft werden muss und nicht dder ganze Verzeichnisname.
        DateisystemtestsHTSEB.StandardeinleseprüfungNeu (LinuxTextExtern   => TextKonstanten.LeerString,
                                                          WindowsTextExtern => (VerzeichnisKonstanten.Musik & To_Wide_Wide_String (Source => LeseOptionen.Musik) & VerzeichnisKonstanten.NullDateiWideWide))
      is
         when False =>
            return;
            
         when True =>
            EinzulesendeZeile := 1;
            AktuelleZeile := 1;
            
            DateizugriffssystemHTSEB.ÖffnenText (DateiartExtern => DateiMusik,
                                                  NameExtern     => UmwandlungssystemHTSEB.Encode (TextExtern => VerzeichnisKonstanten.Musik & To_Wide_Wide_String (Source => LeseOptionen.Musik)
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
               MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenMusikLogik.EinlesenMusik: Einzulesende Zeile:" & EinzulesendeZeile'Wide_Wide_Image & ", aktuelle Zeile:" & AktuelleZeile'Wide_Wide_Image);
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
                 False = DateisystemtestsHTSEB.StandardeinleseprüfungNeu (LinuxTextExtern   => To_Wide_Wide_String (Source => Dateiname),
                                                                           WindowsTextExtern => To_Wide_Wide_String (Source => GesamterPfad))
               then
                  MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenMusikLogik.EinlesenMusik: Datei oder Pfad existiert nicht");
            
               elsif
                 AktuelleZeile in IntromusikAnfang .. IntromusikEnde
               then
                  EingeleseneMusik.Intromusik (AktuelleZeile) := MusikAccessFestlegen (MusicAccessExtern => EingeleseneMusik.Intromusik (AktuelleZeile),
                                                                                       MusikpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile in SpielmusikAnfang .. SpielmusikEnde
               then
                  EingeleseneMusik.Spielmusik (AktuelleZeile - IntromusikEnde) := MusikAccessFestlegen (MusicAccessExtern => EingeleseneMusik.Spielmusik (AktuelleZeile - IntromusikEnde),
                                                                                                        MusikpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile in ForschungsmusikAnfang .. ForschungsmusikEnde
               then
                  EingeleseneMusik.Forschungsmusik (AktuelleZeile - SpielmusikEnde) := MusikAccessFestlegen (MusicAccessExtern => EingeleseneMusik.Forschungsmusik (AktuelleZeile - SpielmusikEnde),
                                                                                                             MusikpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
               
               else
                  MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenTexturenLogik.EinlesenMusik: Außerhalb des Einlesebereichs");
                  exit MusikSchleife;
               end if;
               
               if
                 AktuelleZeile < ForschungsmusikEnde
               then
                  AktuelleZeile := AktuelleZeile + 1;
                     
               else
                  exit MusikSchleife;
               end if;
         end case;
         
      end loop MusikSchleife;
            
      DateizugriffssystemHTSEB.SchließenText (DateiartExtern => DateiMusik,
                                               NameExtern     => UmwandlungssystemHTSEB.Encode (TextExtern => VerzeichnisKonstanten.Musik & To_Wide_Wide_String (Source => LeseOptionen.Musik)
                                                                                                & VerzeichnisKonstanten.NullDateiWideWide));
      
      EinstellungenMusik.Lautstärke;
      
   end EinlesenMusik;
   
   
   
   function MusikAccessFestlegen
     (MusicAccessExtern : in Sf.Audio.sfMusic_Ptr;
      MusikpfadExtern : in String)
      return Sf.Audio.sfMusic_Ptr
   is begin
      
      Sf.Audio.Music.destroy (music => MusicAccessExtern);
      
      return Sf.Audio.Music.createFromFile (filename => MusikpfadExtern);
      
   end MusikAccessFestlegen;
      
end EinlesenMusikLogik;
