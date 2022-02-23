pragma SPARK_Mode (On);

with Ada.Directories; use Ada.Directories;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with Sf.Graphics.Texture;

with EinlesenAllgemein;
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
      
      case
        Exists (Name => "Grafik/Hintergrund/0")
      is
         when False =>
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiTextEinlesen,
                  Mode => In_File,
                  Name => "Grafik/Hintergrund/0");
      end case;
      
      DateipfadeEinlesenSchleife:
      for DateipfadeEinlesenSchleifenwert in HintergrundEinlesenArray'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Fehler.LogikMeldung (FehlermeldungExtern => "EinlesenTexturen.EinlesenHintergrund - Nicht genug Zeilen in der 0-Datei.");
               Close (File => DateiTextEinlesen);
               HintergrundEinlesen (DateipfadeEinlesenSchleifenwert) := SystemKonstanten.LeerUnboundedString;
               return;
               
            when False =>
               HintergrundEinlesen (DateipfadeEinlesenSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
         AktuelleZeile := AktuelleZeile + 1;
         
      end loop DateipfadeEinlesenSchleife;
      
      Close (File => DateiTextEinlesen);
      
      TexturenZuweisenSchleife:
      for TexturenZuweisenSchleifenwert in EingeleseneTexturenSFML.HintergrundAccessArray'Range loop
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => HintergrundEinlesen (TexturenZuweisenSchleifenwert))))
         is
            when True =>
               EingeleseneTexturenSFML.HintergrundAccess (TexturenZuweisenSchleifenwert)
                 := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => HintergrundEinlesen (TexturenZuweisenSchleifenwert))));
                  
            when False =>
               Fehler.LogikMeldung (FehlermeldungExtern => "EinlesenTexturen.EinlesenHintergrund - " & To_Wide_Wide_String (Source => HintergrundEinlesen (TexturenZuweisenSchleifenwert)) & " fehlt.");
               EingeleseneTexturenSFML.HintergrundAccess (TexturenZuweisenSchleifenwert) := null;
         end case;
         
      end loop TexturenZuweisenSchleife;
      
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
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
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
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
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
      
      case
        Exists (Name => "Grafik/Einheiten/0")
      is
         when False =>
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiTextEinlesen,
                  Mode => In_File,
                  Name => "Grafik/Einheiten/0");
      end case;
      
      DateipfadeEinlesenSchleife:
      for DateipfadeEinlesenSchleifenwert in EinheitenEinlesenArray'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Fehler.LogikMeldung (FehlermeldungExtern => "EinlesenTexturen.EinlesenEinheiten - Nicht genug Zeilen in der 0-Datei.");
               Close (File => DateiTextEinlesen);
               EinheitenEinlesen (DateipfadeEinlesenSchleifenwert) := SystemKonstanten.LeerUnboundedString;
               return;
               
            when False =>
               EinheitenEinlesen (DateipfadeEinlesenSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
         AktuelleZeile := AktuelleZeile + 1;
         
      end loop DateipfadeEinlesenSchleife;
      
      Close (File => DateiTextEinlesen);
      
      TexturenZuweisenSchleife:
      for TexturenZuweisenSchleifenwert in EingeleseneTexturenSFML.EinheitenAccesArray'Range loop
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => EinheitenEinlesen (TexturenZuweisenSchleifenwert))))
         is
            when True =>
               EingeleseneTexturenSFML.EinheitenAccess (TexturenZuweisenSchleifenwert)
                 := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => EinheitenEinlesen (TexturenZuweisenSchleifenwert))));
                  
            when False =>
               Fehler.LogikMeldung (FehlermeldungExtern => "EinlesenTexturen.EinlesenEinheiten - " & To_Wide_Wide_String (Source => EinheitenEinlesen (TexturenZuweisenSchleifenwert)) & " fehlt.");
               EingeleseneTexturenSFML.EinheitenAccess (TexturenZuweisenSchleifenwert) := null;
         end case;
         
      end loop TexturenZuweisenSchleife;
      
   end EinlesenEinheiten;
   
   
   
   procedure EinlesenGebäude
   is begin
      
      case
        Exists (Name => "Grafik/Bauwerke/0")
      is
         when False =>
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiTextEinlesen,
                  Mode => In_File,
                  Name => "Grafik/Bauwerke/0");
      end case;
      
      DateipfadeEinlesenSchleife:
      for DateipfadeEinlesenSchleifenwert in GebäudeEinlesenArray'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Fehler.LogikMeldung (FehlermeldungExtern => "EinlesenTexturen.EinlesenGebäude - Nicht genug Zeilen in der 0-Datei.");
               Close (File => DateiTextEinlesen);
               GebäudeEinlesen (DateipfadeEinlesenSchleifenwert) := SystemKonstanten.LeerUnboundedString;
               return;
               
            when False =>
               GebäudeEinlesen (DateipfadeEinlesenSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
         AktuelleZeile := AktuelleZeile + 1;
         
      end loop DateipfadeEinlesenSchleife;
      
      Close (File => DateiTextEinlesen);
      
      TexturenZuweisenSchleife:
      for TexturenZuweisenSchleifenwert in EingeleseneTexturenSFML.GebäudeAccessArray'Range loop
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => GebäudeEinlesen (TexturenZuweisenSchleifenwert))))
         is
            when True =>
               EingeleseneTexturenSFML.GebäudeAccess (TexturenZuweisenSchleifenwert)
                 := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => GebäudeEinlesen (TexturenZuweisenSchleifenwert))));
                  
            when False =>
               Fehler.LogikMeldung (FehlermeldungExtern => "EinlesenTexturen.EinlesenGebäude - " & To_Wide_Wide_String (Source => GebäudeEinlesen (TexturenZuweisenSchleifenwert)) & " fehlt.");
               EingeleseneTexturenSFML.GebäudeAccess (TexturenZuweisenSchleifenwert) := null;
         end case;
         
      end loop TexturenZuweisenSchleife;
      
   end EinlesenGebäude;
      
end EinlesenTexturen;
