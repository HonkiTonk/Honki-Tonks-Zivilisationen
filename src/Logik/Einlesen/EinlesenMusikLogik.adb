with Sf.Audio.Music;

with MeldungssystemHTSEB;
with DateizugriffssystemHTSEB;
with UmwandlungssystemHTSEB;
with DateisystemtestsHTSEB;
with TextKonstantenHTSEB;

with VerzeichnisKonstanten;

with LeseOptionen;

with EinlesenAllgemeinesHTSEB;
with EinstellungenMusik;

-- Unter Windows funktionieren UTF8 Namen bei den Musikdateien nicht und es kommt zu einem Absturz, das beim Benennen der Lieder berücksichtigen.
package body EinlesenMusikLogik is

   procedure EinlesenMusik
   is begin
      
      case
        -- Bie Linux wird hier Leer Übergeben weil ja nur das Nullverzeichnis "/0" geprüft werden muss und nicht dder ganze Verzeichnisname.
        DateisystemtestsHTSEB.StandardeinleseprüfungNeu (LinuxTextExtern   => TextKonstantenHTSEB.LeerString,
                                                          WindowsTextExtern => (VerzeichnisKonstanten.Musik & To_Wide_Wide_String (Source => LeseOptionen.Musik) & VerzeichnisKonstanten.NullDateiWideWide))
      is
         when False =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenMusikLogik.EinlesenMusik: Es fehlt: " & VerzeichnisKonstanten.Grafik
                                       & To_Wide_Wide_String (Source => LeseOptionen.Texturen) & VerzeichnisKonstanten.NullDateiWideWide);
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
               GesamterPfad := VerzeichnisKonstanten.Musik & LeseOptionen.Musik & "/" & Dateiname;
               EinzulesendeZeile := EinzulesendeZeile + 1;
         end case;
         
         if
           Dateiname = TextKonstantenHTSEB.LeerUnboundedString
           or else
             To_Wide_Wide_String (Source => Dateiname) (1) = TextKonstantenHTSEB.TrennzeichenTextdateien
         then
            null;
               
         else
            if
              False = DateisystemtestsHTSEB.StandardeinleseprüfungNeu (LinuxTextExtern   => To_Wide_Wide_String (Source => Dateiname),
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
         end if;
         
      end loop MusikSchleife;
            
      DateizugriffssystemHTSEB.SchließenText (DateiartExtern => DateiMusik,
                                               NameExtern     => UmwandlungssystemHTSEB.Encode (TextExtern => VerzeichnisKonstanten.Musik & To_Wide_Wide_String (Source => LeseOptionen.Musik)
                                                                                                & VerzeichnisKonstanten.NullDateiWideWide));
      
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
