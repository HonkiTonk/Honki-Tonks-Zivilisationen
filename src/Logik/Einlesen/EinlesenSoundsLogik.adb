with Sf.Audio.SoundBuffer;

with DateizugriffssystemHTSEB;

with VerzeichnisKonstanten;

with EingeleseneSounds;
with MeldungssystemHTSEB;
with EinlesenAllgemeinesLogik;
with VerzeichnisDateinamenTests;
with UmwandlungssystemHTSEB;

package body EinlesenSoundsLogik is

   procedure EinlesenSounds
   is begin
            
      case
        VerzeichnisDateinamenTests.Standardeinleseprüfung (VerzeichnisDateinameExtern => UmwandlungssystemHTSEB.Decode (TextExtern => VerzeichnisKonstanten.SoundEinfach & VerzeichnisKonstanten.NullDatei))
      is
         when False =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenSoundsLogik.EinlesenSounds: Es fehlt: "
                                        & UmwandlungssystemHTSEB.Decode (TextExtern => VerzeichnisKonstanten.SoundEinfach & VerzeichnisKonstanten.NullDatei));
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            DateizugriffssystemHTSEB.ÖffnenText (DateiartExtern => DateiSounds,
                                    NameExtern     => VerzeichnisKonstanten.SoundEinfach & VerzeichnisKonstanten.NullDatei);
      end case;
      
      SoundsSchleife:
      for SoundSchleifenwert in EingeleseneSounds.SoundArray'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiSounds,
                                                            AktuelleZeileExtern => AktuelleZeile,
                                                            DateinameExtern     => "EinlesenSoundsLogik.EinlesenSounds")
         is
            when True =>
               MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenSoundsLogik.EinlesenSounds: Fehlende Zeilen: "
                                           & UmwandlungssystemHTSEB.Decode (TextExtern => VerzeichnisKonstanten.SoundEinfach & VerzeichnisKonstanten.NullDatei) & ", aktuelle Zeile: " & AktuelleZeile'Wide_Wide_Image);
               exit SoundsSchleife;
               
            when False =>
               Sound := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiSounds,
                                                                         AktuelleZeileExtern => AktuelleZeile,
                                                                         DateinameExtern     => "EinlesenSoundsLogik.EinlesenSounds");
         end case;
         
         case
           VerzeichnisDateinamenTests.Standardeinleseprüfung (VerzeichnisDateinameExtern => To_Wide_Wide_String (Source => Sound))
         is
            when False =>
               MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenSoundsLogik.EinlesenSounds: Es fehlt: " & To_Wide_Wide_String (Source => Sound));
            
            when True =>
               EingeleseneSounds.Sound (SoundSchleifenwert) := Sf.Audio.SoundBuffer.createFromFile (filename => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => Sound));
         end case;
         
         AktuelleZeile := AktuelleZeile + 1;
         
      end loop SoundsSchleife;
      
      Close (File => DateiSounds);
      
      EingeleseneSounds.SoundsFestlegen;
      
   end EinlesenSounds;

end EinlesenSoundsLogik;
