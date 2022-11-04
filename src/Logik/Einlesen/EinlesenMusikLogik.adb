pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with Sf.Audio.Music;

with VerzeichnisKonstanten;

with EingeleseneMusik;
with Warnung;
with EinlesenAllgemeinesLogik;

package body EinlesenMusikLogik is

   procedure EinlesenMusik
   is begin
      
      if
        Platzhalter
      then
         return;
         
      else
         null;
      end if;
      
      case
        Exists (Name => VerzeichnisKonstanten.Audio & VerzeichnisKonstanten.Musik & VerzeichnisKonstanten.NullDatei)
      is
         when False =>
            Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenMusik.EinlesenMusik: Es fehlt: " & Decode (Item => VerzeichnisKonstanten.Audio & VerzeichnisKonstanten.Musik & VerzeichnisKonstanten.NullDatei));
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiVerzeichnisse,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Audio & VerzeichnisKonstanten.Musik & VerzeichnisKonstanten.NullDatei);
      end case;
      
      VerzeichnisseSchleife:
      for VerzeichnisSchleifenwert in EingeleseneMusik.MusikArray'Range (1) loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiVerzeichnisse,
                                                           AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenMusik.EinlesenMusik: Fehlende Zeilen: " & Decode (Item => VerzeichnisKonstanten.Audio & VerzeichnisKonstanten.Musik & VerzeichnisKonstanten.NullDatei));
               exit VerzeichnisseSchleife;
               
            when False =>
               EinlesenLieder (DateipfadExtern => Get_Line (File => DateiVerzeichnisse),
                               RasseExtern     => VerzeichnisSchleifenwert);
               AktuelleZeile := AktuelleZeile + 1;
         end case;
         
      end loop VerzeichnisseSchleife;
      
      Close (File => DateiVerzeichnisse);
      
   end EinlesenMusik;
   
   
   
   procedure EinlesenLieder
     (DateipfadExtern : in Wide_Wide_String;
      RasseExtern : in RassenDatentypen.Rassen_Enum)
   is begin
      
      case
        RasseExtern
      is
         when RassenDatentypen.Keine_Rasse_Enum =>
            null;
            
         when others =>
            null;
      end case;
      
      case
        Exists (Name => Encode (Item => DateipfadExtern))
      is
         when False =>
            Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenMusik.EinlesenLieder: Es fehlt: " & DateipfadExtern);
            return;
               
         when True =>
            Open (File => DateiMusik,
                  Mode => In_File,
                  Name => Encode (Item => DateipfadExtern));
      end case;
               
      MusikSchleife:
      for MusikSchleifenwert in EingeleseneMusik.MusikArray'Range (2) loop
               
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiMusik,
                                                           AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenMusik.EinlesenLieder: Fehlende Zeilen: " & DateipfadExtern);
               exit MusikSchleife;
               
            when False =>
               Lied := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiMusik));
         end case;
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Lied)))
         is
            when False =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenMusik.EinlesenLieder: Es fehlt: " & To_Wide_Wide_String (Source => Lied));
            
            when True =>
               EingeleseneMusik.Musik (RasseExtern, MusikSchleifenwert) := Sf.Audio.Music.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => Lied)));
         end case;
            
      end loop MusikSchleife;
      
      Close (File => DateiMusik);
      
   end EinlesenLieder;

end EinlesenMusikLogik;
