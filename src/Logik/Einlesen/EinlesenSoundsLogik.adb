with Sf.Audio.SoundBuffer;

with DateizugriffssystemHTSEB;
with DateisystemtestsHTSEB;
with UmwandlungssystemHTSEB;
with TextKonstantenHTSEB;
with MeldungssystemHTSEB;

with VerzeichnisKonstanten;
with TonDatentypen;

with LeseOptionen;

with EingeleseneSounds;
with EinlesenAllgemeinesLogik;
with EinstellungenSound;

-- Unter Windows funktionieren UTF8 Namen bei den Sounddateien nicht, aber es kommt nicht zu einem Absturz, das beim Benennen der Sounds berücksichtigen.
package body EinlesenSoundsLogik is

   procedure EinlesenSounds
   is begin
            
      case
        -- Bie Linux wird hier Leer Übergeben weil ja nur das Nullverzeichnis "/0" geprüft werden muss und nicht der ganze Verzeichnisname.
        DateisystemtestsHTSEB.StandardeinleseprüfungNeu (LinuxTextExtern   => TextKonstantenHTSEB.LeerString,
                                                          WindowsTextExtern => VerzeichnisKonstanten.Sound & To_Wide_Wide_String (Source => LeseOptionen.Sound) & VerzeichnisKonstanten.NullDateiWideWide)
      is
         when False =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenSoundsLogik.EinlesenSounds: Es fehlt: " & VerzeichnisKonstanten.Sound & To_Wide_Wide_String (Source => LeseOptionen.Sound)
                                       & VerzeichnisKonstanten.NullDateiWideWide);
            return;
            
         when True =>
            EinzulesendeZeile := 1;
            AktuelleZeile := 1;
            
            DateizugriffssystemHTSEB.ÖffnenText (DateiartExtern => DateiSounds,
                                                  NameExtern     => UmwandlungssystemHTSEB.Encode (TextExtern => VerzeichnisKonstanten.Sound & To_Wide_Wide_String (Source => LeseOptionen.Sound)
                                                                                                   & VerzeichnisKonstanten.NullDateiWideWide));
      end case;
      
      SoundsSchleife:
      loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiSounds,
                                                            AktuelleZeileExtern => EinzulesendeZeile,
                                                            DateinameExtern     => "EinlesenSoundsLogik.EinlesenSounds")
         is
            when True =>
               MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenSoundsLogik.EinlesenSounds: Fehlende Zeilen: " & VerzeichnisKonstanten.Sound & To_Wide_Wide_String (Source => LeseOptionen.Sound)
                                          & VerzeichnisKonstanten.NullDateiWideWide & ", aktuelle Zeile: " & AktuelleZeile'Wide_Wide_Image);
               exit SoundsSchleife;
               
            when False =>
               Dateiname := EinlesenAllgemeinesLogik.DateinamenEinlesenUngebunden (DateiExtern         => DateiSounds,
                                                                                   AktuelleZeileExtern => EinzulesendeZeile,
                                                                                   DateinameExtern     => "EinlesenSoundsLogik.EinlesenSounds");
               GesamterPfad := VerzeichnisKonstanten.Sound & LeseOptionen.Sound & "/" & Dateiname;
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
               MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenSoundsLogik.EinlesenSounds: Datei oder Pfad existiert nicht");
                  
            else
               EingeleseneSounds.SoundbufferAccesse (TonDatentypen.Sound_Vorhanden_Enum'Val (AktuelleZeile))
                 := SoundAccessFestlegen (SoundAccessExtern => EingeleseneSounds.SoundbufferAccesse (TonDatentypen.Sound_Vorhanden_Enum'Val (AktuelleZeile)),
                                          SoundpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
            end if;
               
            if
              AktuelleZeile < TonDatentypen.Sound_Vorhanden_Enum'Pos (EingeleseneSounds.SoundbufferAccesse'Last)
            then
               AktuelleZeile := AktuelleZeile + 1;
                     
            else
               exit SoundsSchleife;
            end if;
         end if;
         
      end loop SoundsSchleife;
            
      DateizugriffssystemHTSEB.SchließenText (DateiartExtern => DateiSounds,
                                               NameExtern     => VerzeichnisKonstanten.SoundEinfach & VerzeichnisKonstanten.NullDatei);
      
      EingeleseneSounds.SoundsFestlegen;
      EinstellungenSound.Lautstärke;
      
   end EinlesenSounds;
   
   
   
   function SoundAccessFestlegen
     (SoundAccessExtern : in Sf.Audio.sfSoundBuffer_Ptr;
      SoundpfadExtern : in String)
      return Sf.Audio.sfSoundBuffer_Ptr
   is begin
      
      Sf.Audio.SoundBuffer.destroy (soundBuffer => SoundAccessExtern);
      
      return Sf.Audio.SoundBuffer.createFromFile (filename => SoundpfadExtern);
      
   end SoundAccessFestlegen;

end EinlesenSoundsLogik;
