with Ada.Directories; use Ada.Directories;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with Sf.Audio.SoundBuffer;

with VerzeichnisKonstanten;

with EingeleseneSounds;
with Fehlermeldungssystem;
with EinlesenAllgemeinesLogik;

package body EinlesenSoundsLogik is

   procedure EinlesenSounds
   is begin
            
      case
        Exists (Name => VerzeichnisKonstanten.Audio & VerzeichnisKonstanten.Sound & VerzeichnisKonstanten.NullDatei)
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenSoundsLogik.EinlesenSounds: Es fehlt: "
                                        & Decode (Item => VerzeichnisKonstanten.Audio & VerzeichnisKonstanten.Sound & VerzeichnisKonstanten.NullDatei));
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiSounds,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Audio & VerzeichnisKonstanten.Sound & VerzeichnisKonstanten.NullDatei,
                  Form => "WCEM=8");
      end case;
      
      SoundsSchleife:
      for SoundSchleifenwert in EingeleseneSounds.SoundArray'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiSounds,
                                                           AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenSoundsLogik.EinlesenSounds: Fehlende Zeilen: "
                                           & Decode (Item => VerzeichnisKonstanten.Audio & VerzeichnisKonstanten.Sound & VerzeichnisKonstanten.NullDatei) & ", aktuelle Zeile: " & AktuelleZeile'Wide_Wide_Image);
               exit SoundsSchleife;
               
            when False =>
               Sound := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiSounds));
         end case;
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Sound)))
         is
            when False =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenSoundsLogik.EinlesenSounds: Es fehlt: " & To_Wide_Wide_String (Source => Sound));
            
            when True =>
               EingeleseneSounds.Sound (SoundSchleifenwert) := Sf.Audio.SoundBuffer.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => Sound)));
         end case;
         
         AktuelleZeile := AktuelleZeile + 1;
         
      end loop SoundsSchleife;
      
      Close (File => DateiSounds);
      
      EingeleseneSounds.SoundsFestlegen;
      
   end EinlesenSounds;

end EinlesenSoundsLogik;
