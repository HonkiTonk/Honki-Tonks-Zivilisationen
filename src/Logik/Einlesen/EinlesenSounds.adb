pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with Sf.Audio.SoundBuffer;

with VerzeichnisKonstanten;

with EingeleseneSounds;
with Warnung;
with EinlesenAllgemein;

package body EinlesenSounds is

   procedure EinlesenSounds
   is begin
      
      if
        Platzhalter
      then
         return;
         
      else
         null;
      end if;
            
      case
        Exists (Name => VerzeichnisKonstanten.Audio & VerzeichnisKonstanten.Sound & VerzeichnisKonstanten.NullDatei)
      is
         when False =>
            Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenSounds.EinlesenSounds: Es fehlt: " & Decode (Item => VerzeichnisKonstanten.Audio & VerzeichnisKonstanten.Sound & VerzeichnisKonstanten.NullDatei));
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiSounds,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Audio & VerzeichnisKonstanten.Sound & VerzeichnisKonstanten.NullDatei);
      end case;
      
      SoundsSchleife:
      for SoundSchleifenwert in EingeleseneSounds.SoundArray'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiSounds,
                                                    AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Warnung.LogikWarnung
                 (WarnmeldungExtern => "EinlesenSounds.EinlesenSounds: Fehlende Zeilen in: " & Decode (Item => VerzeichnisKonstanten.Audio & VerzeichnisKonstanten.Sound & VerzeichnisKonstanten.NullDatei));
               exit SoundsSchleife;
               
            when False =>
               Sound := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiSounds));
         end case;
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Sound)))
         is
            when False =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenSounds.EinlesenSounds: Es fehlt: " & To_Wide_Wide_String (Source => Sound));
            
            when True =>
               EingeleseneSounds.Sound (SoundSchleifenwert) := Sf.Audio.SoundBuffer.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => Sound)));
         end case;
         
      end loop SoundsSchleife;
      
      Close (File => DateiSounds);
      
   end EinlesenSounds;

end EinlesenSounds;
