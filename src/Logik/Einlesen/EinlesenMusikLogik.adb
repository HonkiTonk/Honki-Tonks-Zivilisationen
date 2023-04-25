with Ada.Directories; use Ada.Directories;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with Sf.Audio.Music;

with VerzeichnisKonstanten;
with SpeziesKonstanten;

with EingeleseneMusik;
with Fehlermeldungssystem;
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
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenMusikLogik.EinlesenMusik: Es fehlt: " & Decode (Item => VerzeichnisKonstanten.Audio & VerzeichnisKonstanten.Musik & VerzeichnisKonstanten.NullDatei));
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiVerzeichnisse,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Audio & VerzeichnisKonstanten.Musik & VerzeichnisKonstanten.NullDatei,
                  Form => "WCEM=8");
      end case;
      
      VerzeichnisseSchleife:
      for VerzeichnisSchleifenwert in EingeleseneMusik.MusikArray'Range (1) loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiVerzeichnisse,
                                                           AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenMusikLogik.EinlesenMusik: Fehlende Zeilen: "
                                           & Decode (Item => VerzeichnisKonstanten.Audio & VerzeichnisKonstanten.Musik & VerzeichnisKonstanten.NullDatei) & ", aktuelle Zeile: " & AktuelleZeile'Wide_Wide_Image);
               exit VerzeichnisseSchleife;
               
            when False =>
               EinlesenLieder (DateipfadExtern => Get_Line (File => DateiVerzeichnisse),
                               SpeziesExtern   => VerzeichnisSchleifenwert);
               AktuelleZeile := AktuelleZeile + 1;
         end case;
         
      end loop VerzeichnisseSchleife;
      
      Close (File => DateiVerzeichnisse);
      
   end EinlesenMusik;
   
   
   
   procedure EinlesenLieder
     (DateipfadExtern : in Wide_Wide_String;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Enum)
   is begin
      
      case
        SpeziesExtern
      is
         when SpeziesKonstanten.LeerSpezies =>
            null;
            
         when others =>
            null;
      end case;
      
      case
        Exists (Name => Encode (Item => DateipfadExtern))
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenMusikLogik.EinlesenLieder: Es fehlt: " & DateipfadExtern);
            return;
               
         when True =>
            Open (File => DateiMusik,
                  Mode => In_File,
                  Name => Encode (Item => DateipfadExtern),
                  Form => "WCEM=8");
      end case;
               
      MusikSchleife:
      for MusikSchleifenwert in EingeleseneMusik.MusikArray'Range (2) loop
               
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiMusik,
                                                           AktuelleZeileExtern => Positive (MusikSchleifenwert))
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenMusikLogik.EinlesenLieder: Fehlende Zeilen: " & DateipfadExtern & ", aktuelle Zeile: " & MusikSchleifenwert'Wide_Wide_Image);
               exit MusikSchleife;
               
            when False =>
               Lied := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiMusik));
         end case;
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Lied)))
         is
            when False =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenMusikLogik.EinlesenLieder: Es fehlt: " & To_Wide_Wide_String (Source => Lied));
            
            when True =>
               EingeleseneMusik.Musik (SpeziesExtern, MusikSchleifenwert) := Sf.Audio.Music.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => Lied)));
         end case;
            
      end loop MusikSchleife;
      
      Close (File => DateiMusik);
      
   end EinlesenLieder;

end EinlesenMusikLogik;
