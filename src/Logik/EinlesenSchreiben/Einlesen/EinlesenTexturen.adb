pragma SPARK_Mode (On);

with Ada.Directories; use Ada.Directories;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with Sf.Graphics.Texture;

with EinlesenAllgemein;
with Warnung;

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
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenHintergrund - Nicht genug Zeilen in der 0-Datei.");
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
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenHintergrund - " & To_Wide_Wide_String (Source => HintergrundEinlesen (TexturenZuweisenSchleifenwert)) & " fehlt.");
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
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenKartenfelder - Nicht genug Zeilen in der 0-Datei.");
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
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenKartenfelder - " & To_Wide_Wide_String (Source => KartenfelderEinlesen (TexturenZuweisenSchleifenwert)) & " fehlt.");
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
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenVerbesserungen - Nicht genug Zeilen in der 0-Datei.");
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
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenVerbesserungen - " & To_Wide_Wide_String (Source => VerbesserungenEinlesen (TexturenZuweisenSchleifenwert)) & " fehlt.");
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
      
      RassenEinsSchleife:
      for RasseSchleifenwert in EinheitenEinlesenArray'Range (1) loop
         DateipfadeEinlesenSchleife:
         for DateipfadeEinlesenSchleifenwert in EinheitenEinlesenArray'Range (2) loop
            
            case
              EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                       AktuelleZeileExtern => AktuelleZeile)
            is
               when True =>
                  Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenEinheiten - Nicht genug Zeilen in der 0-Datei.");
                  Close (File => DateiTextEinlesen);
                  EinheitenEinlesen (RasseSchleifenwert, DateipfadeEinlesenSchleifenwert) := SystemKonstanten.LeerUnboundedString;
                  return;
               
               when False =>
                  EinheitenEinlesen (RasseSchleifenwert, DateipfadeEinlesenSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
            end case;
         
            AktuelleZeile := AktuelleZeile + 1;
            
         end loop DateipfadeEinlesenSchleife;
      end loop RassenEinsSchleife;
      
      Close (File => DateiTextEinlesen);
      
      RassenZweiSchleife:
      for RasseSchleifenwert in EingeleseneTexturenSFML.EinheitenAccesArray'Range (1) loop
         TexturenZuweisenSchleife:
         for TexturenZuweisenSchleifenwert in EingeleseneTexturenSFML.EinheitenAccesArray'Range (2) loop
         
            case
              Exists (Name => Encode (Item => To_Wide_Wide_String (Source => EinheitenEinlesen (RasseSchleifenwert, TexturenZuweisenSchleifenwert))))
            is
               when True =>
                  EingeleseneTexturenSFML.EinheitenAccess (RasseSchleifenwert, TexturenZuweisenSchleifenwert)
                    := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => EinheitenEinlesen (RasseSchleifenwert, TexturenZuweisenSchleifenwert))));
                  
               when False =>
                  Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenEinheiten - " & To_Wide_Wide_String (Source => EinheitenEinlesen (RasseSchleifenwert, TexturenZuweisenSchleifenwert)) & " fehlt.");
                  EingeleseneTexturenSFML.EinheitenAccess (RasseSchleifenwert, TexturenZuweisenSchleifenwert) := null;
            end case;
         
         end loop TexturenZuweisenSchleife;
      end loop RassenZweiSchleife;
      
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
      
      RassenEinsSchleife:
      for RasseSchleifenwert in GebäudeEinlesenArray'Range (1) loop
         DateipfadeEinlesenSchleife:
         for DateipfadeEinlesenSchleifenwert in GebäudeEinlesenArray'Range (2) loop
         
            case
              EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                       AktuelleZeileExtern => AktuelleZeile)
            is
               when True =>
                  Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenGebäude - Nicht genug Zeilen in der 0-Datei.");
                  Close (File => DateiTextEinlesen);
                  GebäudeEinlesen (RasseSchleifenwert, DateipfadeEinlesenSchleifenwert) := SystemKonstanten.LeerUnboundedString;
                  return;
               
               when False =>
                  GebäudeEinlesen (RasseSchleifenwert, DateipfadeEinlesenSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
            end case;
         
            AktuelleZeile := AktuelleZeile + 1;
         
         end loop DateipfadeEinlesenSchleife;
      end loop RassenEinsSchleife;
      
      Close (File => DateiTextEinlesen);
      
      RassenZweiSchleife:
      for RasseSchleifenwert in EingeleseneTexturenSFML.GebäudeAccessArray'Range (1) loop
         TexturenZuweisenSchleife:
         for TexturenZuweisenSchleifenwert in EingeleseneTexturenSFML.GebäudeAccessArray'Range (2) loop
         
            case
              Exists (Name => Encode (Item => To_Wide_Wide_String (Source => GebäudeEinlesen (RasseSchleifenwert, TexturenZuweisenSchleifenwert))))
            is
               when True =>
                  EingeleseneTexturenSFML.GebäudeAccess (RasseSchleifenwert, TexturenZuweisenSchleifenwert)
                    := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => GebäudeEinlesen (RasseSchleifenwert, TexturenZuweisenSchleifenwert))));
                  
               when False =>
                  Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenGebäude - " & To_Wide_Wide_String (Source => GebäudeEinlesen (RasseSchleifenwert, TexturenZuweisenSchleifenwert)) & " fehlt.");
                  EingeleseneTexturenSFML.GebäudeAccess (RasseSchleifenwert, TexturenZuweisenSchleifenwert) := null;
            end case;
         
         end loop TexturenZuweisenSchleife;
      end loop RassenZweiSchleife;
      
   end EinlesenGebäude;
   
end EinlesenTexturen;
