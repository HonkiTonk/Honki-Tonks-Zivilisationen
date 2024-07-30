with Sf.Audio.SoundBuffer;

with VerzeichnisKonstanten;

with EingeleseneSounds;
with Fehlermeldungssystem;
with EinlesenAllgemeinesLogik;
with VerzeichnisDateinamenTests;
with UmwandlungenAdaEigenes;

package body EinlesenSoundsLogik is

   procedure EinlesenSounds
   is begin
            
      case
        VerzeichnisDateinamenTests.Standardeinleseprüfung (VerzeichnisDateinameExtern => UmwandlungenAdaEigenes.EigenesDecode (TextExtern => VerzeichnisKonstanten.Sound & VerzeichnisKonstanten.NullDatei))
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenSoundsLogik.EinlesenSounds: Es fehlt: "
                                        & UmwandlungenAdaEigenes.EigenesDecode (TextExtern => VerzeichnisKonstanten.Sound & VerzeichnisKonstanten.NullDatei));
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiSounds,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Sound & VerzeichnisKonstanten.NullDatei,
                  Form => "WCEM=8");
      end case;
      
      SoundsSchleife:
      for SoundSchleifenwert in EingeleseneSounds.SoundArray'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiSounds,
                                                            AktuelleZeileExtern => AktuelleZeile,
                                                            DateinameExtern     => "EinlesenSoundsLogik.EinlesenSounds")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenSoundsLogik.EinlesenSounds: Fehlende Zeilen: "
                                           & UmwandlungenAdaEigenes.EigenesDecode (TextExtern => VerzeichnisKonstanten.Sound & VerzeichnisKonstanten.NullDatei) & ", aktuelle Zeile: " & AktuelleZeile'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenSoundsLogik.EinlesenSounds: Es fehlt: " & To_Wide_Wide_String (Source => Sound));
            
            when True =>
               EingeleseneSounds.Sound (SoundSchleifenwert) := Sf.Audio.SoundBuffer.createFromFile (filename => UmwandlungenAdaEigenes.EigenesEncodeUnbounded (TextExtern => Sound));
         end case;
         
         AktuelleZeile := AktuelleZeile + 1;
         
      end loop SoundsSchleife;
      
      Close (File => DateiSounds);
      
      EingeleseneSounds.SoundsFestlegen;
      
   end EinlesenSounds;

end EinlesenSoundsLogik;
