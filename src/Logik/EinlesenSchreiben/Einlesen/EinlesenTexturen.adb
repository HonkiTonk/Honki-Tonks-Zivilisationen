pragma SPARK_Mode (On);

with Ada.Directories; use Ada.Directories;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with Sf.Graphics.Texture;

with Fehler;

package body EinlesenTexturen is
   
   procedure EinlesenTexturen
   is begin
            
      EinlesenHintergrund;
      EinlesenKartenfelder;
      EinlesenVerbesserungen;
      EinlesenEinheiten;
      EinlesenGebäude;
      
   end EinlesenTexturen;
   
   
   
   procedure EinlesenHintergrund
   is begin
      
      null;
      
   end EinlesenHintergrund;
   
   
   
   procedure EinlesenKartenfelder
   is begin
      
      case
        Exists (Name => "Grafik/Kartenfelder/0")
      is
         when False =>
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiTextEinlesen,
                  Mode => In_File,
                  Name => "Grafik/Kartenfelder/0");
      end case;
      
      DateipfadeEinlesenSchleife:
      for DateipfadeEinlesenSchleifenwert in KartenfelderEinlesenArray'Range loop
         
         case
           VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                  AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Fehler.LogikMeldung (FehlermeldungExtern => "EinlesenTexturen.EinlesenKartenfelder - Nicht genug Zeilen in der 0-Datei.");
               Close (File => DateiTextEinlesen);
               KartenfelderEinlesen (DateipfadeEinlesenSchleifenwert) := SystemKonstanten.LeerUnboundedString;
               return;
               
            when False =>
               KartenfelderEinlesen (DateipfadeEinlesenSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
         AktuelleZeile := AktuelleZeile + 1;
         
      end loop DateipfadeEinlesenSchleife;
      
      Close (File => DateiTextEinlesen);
      
      TexturenZuweisenSchleife:
      for TexturenZuweisenSchleifenwert in EingeleseneTexturenSFML.KartenfelderAccessArray'Range loop
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => KartenfelderEinlesen (TexturenZuweisenSchleifenwert))))
         is
            when True =>
               EingeleseneTexturenSFML.KartenfelderAccess (TexturenZuweisenSchleifenwert)
                 := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => KartenfelderEinlesen (TexturenZuweisenSchleifenwert))));
                  
            when False =>
               Fehler.LogikMeldung (FehlermeldungExtern => "EinlesenTexturen.EinlesenKartenfelder - " & To_Wide_Wide_String (Source => KartenfelderEinlesen (TexturenZuweisenSchleifenwert)) & " fehlt.");
               EingeleseneTexturenSFML.KartenfelderAccess (TexturenZuweisenSchleifenwert) := null;
         end case;
         
      end loop TexturenZuweisenSchleife;
      
   end EinlesenKartenfelder;
   
   
   
   procedure EinlesenVerbesserungen
   is begin
      
      case
        Exists (Name => "Grafik/Verbesserungen/0")
      is
         when False =>
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiTextEinlesen,
                  Mode => In_File,
                  Name => "Grafik/Verbesserungen/0");
      end case;
      
      DateipfadeEinlesenSchleife:
      for DateipfadeEinlesenSchleifenwert in VerbesserungenEinlesenArray'Range loop
         
         case
           VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                  AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Fehler.LogikMeldung (FehlermeldungExtern => "EinlesenTexturen.EinlesenVerbesserungen - Nicht genug Zeilen in der 0-Datei.");
               Close (File => DateiTextEinlesen);
               VerbesserungenEinlesen (DateipfadeEinlesenSchleifenwert) := SystemKonstanten.LeerUnboundedString;
               return;
               
            when False =>
               VerbesserungenEinlesen (DateipfadeEinlesenSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
         AktuelleZeile := AktuelleZeile + 1;
         
      end loop DateipfadeEinlesenSchleife;
      
      Close (File => DateiTextEinlesen);
      
      TexturenZuweisenSchleife:
      for TexturenZuweisenSchleifenwert in EingeleseneTexturenSFML.VerbesserungenAccessArray'Range loop
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => VerbesserungenEinlesen (TexturenZuweisenSchleifenwert))))
         is
            when True =>
               EingeleseneTexturenSFML.VerbesserungenAccess (TexturenZuweisenSchleifenwert)
                 := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => VerbesserungenEinlesen (TexturenZuweisenSchleifenwert))));
                  
            when False =>
               Fehler.LogikMeldung (FehlermeldungExtern => "EinlesenTexturen.EinlesenVerbesserungen - " & To_Wide_Wide_String (Source => VerbesserungenEinlesen (TexturenZuweisenSchleifenwert)) & " fehlt.");
               EingeleseneTexturenSFML.VerbesserungenAccess (TexturenZuweisenSchleifenwert) := null;
         end case;
         
      end loop TexturenZuweisenSchleife;
      
   end EinlesenVerbesserungen;
   
   
   
   procedure EinlesenEinheiten
   is begin
      
      EingeleseneTexturenSFML.EinheitenAccess := (others => Sf.Graphics.Texture.createFromFile (filename => "Grafik/Einheiten/TestEinheit.png"));
      
   end EinlesenEinheiten;
   
   
   
   procedure EinlesenGebäude
   is begin
      
      EingeleseneTexturenSFML.GebäudeAccess := (others => Sf.Graphics.Texture.createFromFile (filename => "Grafik/Bauwerke/TestBauwerk.png"));
      
   end EinlesenGebäude;
   
   
   
   -- Allgemeine Einlesenfunktionen und -prozeduren bauen.
   -- DateiTextEinlesen auch über Extern machen.
   function VorzeitigesZeilenende
     (AktuelleDateiExtern : in File_Type;
      AktuelleZeileExtern : in Positive)
      return Boolean
   is begin
      
      case
        End_Of_File (File => AktuelleDateiExtern)
      is
         when True =>
            return True;
               
         when False =>
            Set_Line (File => AktuelleDateiExtern,
                      To   => Ada.Wide_Wide_Text_IO.Count (AktuelleZeileExtern));
            return False;
      end case;
      
   end VorzeitigesZeilenende;
   
end EinlesenTexturen;
