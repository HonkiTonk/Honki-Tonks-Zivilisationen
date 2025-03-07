with Sf.Audio.SoundBuffer;

with DateizugriffssystemHTSEB;
with DateisystemtestsHTSEB;
with UmwandlungssystemHTSEB;

with VerzeichnisKonstanten;
with TextKonstanten;

with LeseOptionen;

with EingeleseneSounds;
with MeldungssystemHTSEB;
with EinlesenAllgemeinesLogik;
with VerzeichnisDateinamenTests;

package body EinlesenSoundsLogik is

   procedure EinlesenSounds
   is begin
            
      case
        -- Bie Linux wird hier Leer Übergeben weil ja nur das Nullverzeichnis "/0" geprüft werden muss und nicht der ganze Verzeichnisname.
        DateisystemtestsHTSEB.StandardeinleseprüfungNeu (LinuxTextExtern   => TextKonstanten.LeerString,
                                                          WindowsTextExtern => VerzeichnisKonstanten.Sound & To_Wide_Wide_String (Source => LeseOptionen.Sound) & VerzeichnisKonstanten.NullDateiWideWide)
      is
         when False =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenSoundsLogik.EinlesenSounds: Es fehlt: " & VerzeichnisKonstanten.Sound & To_Wide_Wide_String (Source => LeseOptionen.Sound)
                                       & VerzeichnisKonstanten.NullDateiWideWide);
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            DateizugriffssystemHTSEB.ÖffnenText (DateiartExtern => DateiSounds,
                                                  NameExtern     => UmwandlungssystemHTSEB.Encode (TextExtern => VerzeichnisKonstanten.Sound & To_Wide_Wide_String (Source => LeseOptionen.Sound)
                                                                                                   & VerzeichnisKonstanten.NullDateiWideWide));
      end case;
      
      -- Noch das hier eionbauen: äöü
      -- case
      --     To_Wide_Wide_String (Source => Dateiname) (1)
      --   is
      --      when TextKonstanten.TrennzeichenTextdateien =>
      --         null;
      -- hier einbauen. äöü
      SoundsSchleife:
      for SoundSchleifenwert in EingeleseneSounds.SoundArray'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiSounds,
                                                            AktuelleZeileExtern => AktuelleZeile,
                                                            DateinameExtern     => "EinlesenSoundsLogik.EinlesenSounds")
         is
            when True =>
               MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenSoundsLogik.EinlesenSounds: Fehlende Zeilen: " & VerzeichnisKonstanten.Sound & To_Wide_Wide_String (Source => LeseOptionen.Sound)
                                          & VerzeichnisKonstanten.NullDateiWideWide & ", aktuelle Zeile: " & AktuelleZeile'Wide_Wide_Image);
               exit SoundsSchleife;
               
            when False =>
               Soundname := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiSounds,
                                                                             AktuelleZeileExtern => AktuelleZeile,
                                                                             DateinameExtern     => "EinlesenSoundsLogik.EinlesenSounds");
               GesamterPfad := VerzeichnisKonstanten.Sound & LeseOptionen.Sound & "/" & Soundname;
         end case;
         
         case
           VerzeichnisDateinamenTests.Standardeinleseprüfung (VerzeichnisDateinameExtern => To_Wide_Wide_String (Source => GesamterPfad))
         is
            when False =>
               MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenSoundsLogik.EinlesenSounds: Es fehlt: " & To_Wide_Wide_String (Source => GesamterPfad));
            
            when True =>
               Sf.Audio.SoundBuffer.destroy (soundBuffer => EingeleseneSounds.Sound (SoundSchleifenwert));
               EingeleseneSounds.Sound (SoundSchleifenwert) := Sf.Audio.SoundBuffer.createFromFile (filename => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
         end case;
         
         AktuelleZeile := AktuelleZeile + 1;
         
      end loop SoundsSchleife;
            
      DateizugriffssystemHTSEB.SchließenText (DateiartExtern => DateiSounds,
                                               NameExtern     => VerzeichnisKonstanten.SoundEinfach & VerzeichnisKonstanten.NullDatei);
      
      EingeleseneSounds.SoundsFestlegen;
      
   end EinlesenSounds;

end EinlesenSoundsLogik;
