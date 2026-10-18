with Sf.Audio.Music;

with MeldungssystemHTSEB;
with DateizugriffssystemHTSEB;
with UmwandlungssystemHTSEB;
with DateisystemtestsHTSEB;
with TextKonstantenHTSEB;
with EinlesenAllgemeinesHTSEB;
with VerzeichnisKonstantenHTSEB;

with LeseOptionen;

with EinstellungenMusik;

-- Unter Windows funktionieren UTF8 Namen bei den Musikdateien nicht und es kommt zu einem Absturz, das beim Benennen der Lieder berücksichtigen.
package body EinlesenMusikLogik is

   procedure EinlesenMusik
   is begin
      
      case
        -- Bie Linux wird hier Leer Übergeben weil ja nur das Nullverzeichnis "/0" geprüft werden muss und nicht dder ganze Verzeichnisname.
        DateisystemtestsHTSEB.Standardeinleseprüfung (LinuxTextExtern   => TextKonstantenHTSEB.LeerString,
                                                       WindowsTextExtern => (VerzeichnisKonstantenHTSEB.Musikordner & To_Wide_Wide_String (Source => LeseOptionen.Musik) & VerzeichnisKonstantenHTSEB.Nulldatei))
      is
         when False =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenMusikLogik.EinlesenMusik: Es fehlt: " & VerzeichnisKonstantenHTSEB.Grafikordner
                                       & To_Wide_Wide_String (Source => LeseOptionen.Texturen) & VerzeichnisKonstantenHTSEB.Nulldatei);
            return;
            
         when True =>
            EinzulesendeZeile := 1;
            AktuelleZeile := 1;
            
            DateizugriffssystemHTSEB.ÖffnenTextWideWide (DateiartExtern => DateiMusik,
                                                         NameExtern     => VerzeichnisKonstantenHTSEB.Musikordner & To_Wide_Wide_String (Source => LeseOptionen.Musik) & VerzeichnisKonstantenHTSEB.Nulldatei);
      end case;
      
      MusikSchleife:
      loop
         
         case
           EinlesenAllgemeinesHTSEB.VorzeitigesDateienende (AktuelleDateiExtern => DateiMusik,
                                                            AktuelleZeileExtern => EinzulesendeZeile,
                                                            DateinameExtern     => "EinlesenMusikLogik.EinlesenMusik")
         is
            when True =>
               MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenMusikLogik.EinlesenMusik: Einzulesende Zeile:" & EinzulesendeZeile'Wide_Wide_Image & ", aktuelle Zeile:" & AktuelleZeile'Wide_Wide_Image);
               exit MusikSchleife;
               
            when False =>
               Dateiname := EinlesenAllgemeinesHTSEB.DateinamenEinlesenUngebunden (DateiExtern         => DateiMusik,
                                                                                   AktuelleZeileExtern => EinzulesendeZeile,
                                                                                   DateinameExtern     => "EinlesenMusikLogik.EinlesenMusik");
               GesamterPfad := VerzeichnisKonstantenHTSEB.Musikordner & LeseOptionen.Musik & "/" & Dateiname;
               EinzulesendeZeile := EinzulesendeZeile + 1;
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
                  MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenMusikLogik.EinlesenMusik: Datei oder Pfad existiert nicht");
            
               elsif
                 AktuelleZeile in IntromusikAnfang .. IntromusikEnde
               then
                  EingeleseneMusik.Intromusik (AktuelleZeile) := MusikFestlegen (MusicAccessExtern => EingeleseneMusik.Intromusik (AktuelleZeile),
                                                                                 MusikpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile in SpielmusikAnfang .. SpielmusikEnde
               then
                  EingeleseneMusik.Spielmusik (AktuelleZeile - IntromusikEnde) := MusikFestlegen (MusicAccessExtern => EingeleseneMusik.Spielmusik (AktuelleZeile - IntromusikEnde),
                                                                                                  MusikpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile in ForschungsmusikAnfang .. ForschungsmusikEnde
               then
                  EingeleseneMusik.Forschungsmusik (AktuelleZeile - SpielmusikEnde) := MusikFestlegen (MusicAccessExtern => EingeleseneMusik.Forschungsmusik (AktuelleZeile - SpielmusikEnde),
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
            
      DateizugriffssystemHTSEB.SchließenTextWideWide (DateiartExtern => DateiMusik,
                                               NameExtern     => VerzeichnisKonstantenHTSEB.Musikordner & To_Wide_Wide_String (Source => LeseOptionen.Musik) & VerzeichnisKonstantenHTSEB.Nulldatei);
      
      EinstellungenMusik.Lautstärke;
      
   end EinlesenMusik;
   
   
   
   function MusikFestlegen
     (MusicAccessExtern : in Sf.Audio.sfMusic_Ptr;
      MusikpfadExtern : in String)
      return Sf.Audio.sfMusic_Ptr
   is begin
      
      Sf.Audio.Music.destroy (music => MusicAccessExtern);
      
      return Sf.Audio.Music.createFromFile (filename => MusikpfadExtern);
      
   end MusikFestlegen;
      
end EinlesenMusikLogik;
