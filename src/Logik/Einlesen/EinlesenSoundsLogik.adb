with Sf.Audio.SoundBuffer;

with DateizugriffssystemHTB5;

with VerzeichnisKonstanten;

with EingeleseneSounds;
with MeldungssystemHTB1;
with EinlesenAllgemeinesLogik;
with VerzeichnisDateinamenTests;
with UmwandlungssystemHTB3;

package body EinlesenSoundsLogik is

   procedure EinlesenSounds
   is begin
            
      case
        VerzeichnisDateinamenTests.Standardeinleseprüfung (VerzeichnisDateinameExtern => UmwandlungssystemHTB3.Decode (TextExtern => VerzeichnisKonstanten.SoundEinfach & VerzeichnisKonstanten.NullDatei))
      is
         when False =>
            MeldungssystemHTB1.Logik (MeldungExtern => "EinlesenSoundsLogik.EinlesenSounds: Es fehlt: "
                                        & UmwandlungssystemHTB3.Decode (TextExtern => VerzeichnisKonstanten.SoundEinfach & VerzeichnisKonstanten.NullDatei));
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            DateizugriffssystemHTB5.ÖffnenText (DateiartExtern => DateiSounds,
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
               MeldungssystemHTB1.Logik (MeldungExtern => "EinlesenSoundsLogik.EinlesenSounds: Fehlende Zeilen: "
                                           & UmwandlungssystemHTB3.Decode (TextExtern => VerzeichnisKonstanten.SoundEinfach & VerzeichnisKonstanten.NullDatei) & ", aktuelle Zeile: " & AktuelleZeile'Wide_Wide_Image);
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
               MeldungssystemHTB1.Logik (MeldungExtern => "EinlesenSoundsLogik.EinlesenSounds: Es fehlt: " & To_Wide_Wide_String (Source => Sound));
            
            when True =>
               EingeleseneSounds.Sound (SoundSchleifenwert) := Sf.Audio.SoundBuffer.createFromFile (filename => UmwandlungssystemHTB3.EncodeUnbounded (TextExtern => Sound));
         end case;
         
         AktuelleZeile := AktuelleZeile + 1;
         
      end loop SoundsSchleife;
      
      Close (File => DateiSounds);
      
      EingeleseneSounds.SoundsFestlegen;
      
   end EinlesenSounds;

end EinlesenSoundsLogik;
