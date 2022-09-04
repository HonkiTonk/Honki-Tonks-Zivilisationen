pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

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
      EinlesenKartenflüsse;
      EinlesenKartenressourcen;
      EinlesenVerbesserungen;
      EinlesenWege;
      EinlesenEinheiten;
      EinlesenGebäude;
      
   end EinlesenTexturen;
   
   
   
   procedure EinlesenHintergrund
   is begin
      
      case
        Exists (Name => TextKonstanten.Grafik & TextKonstanten.Hintergrund & TextKonstanten.NullDatei)
      is
         when False =>
            Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenHintergrund - 0-Datei fehlt.");
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiTextEinlesen,
                  Mode => In_File,
                  Name => TextKonstanten.Grafik & TextKonstanten.Hintergrund & TextKonstanten.NullDatei);
      end case;
      
      DateipfadeEinlesenSchleife:
      for DateipfadeEinlesenSchleifenwert in HintergrundEinlesenArray'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenHintergrund - Nicht genug Zeilen in 0-Datei.");
               Close (File => DateiTextEinlesen);
               HintergrundEinlesen (DateipfadeEinlesenSchleifenwert) := TextKonstanten.LeerUnboundedString;
               return;
               
            when False =>
               HintergrundEinlesen (DateipfadeEinlesenSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
               AktuelleZeile := AktuelleZeile + 1;
         end case;
                  
      end loop DateipfadeEinlesenSchleife;
      
      Close (File => DateiTextEinlesen);
      
      TexturenZuweisenSchleife:
      for TexturenZuweisenSchleifenwert in HintergrundEinlesenArray'Range loop
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => HintergrundEinlesen (TexturenZuweisenSchleifenwert))))
         is
            when True =>
               EingeleseneTexturenGrafik.HintergrundAccess (TexturenZuweisenSchleifenwert)
                 := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => HintergrundEinlesen (TexturenZuweisenSchleifenwert))));
                  
            when False =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenHintergrund - " & To_Wide_Wide_String (Source => HintergrundEinlesen (TexturenZuweisenSchleifenwert)) & " fehlt.");
               EingeleseneTexturenGrafik.HintergrundAccess (TexturenZuweisenSchleifenwert) := null;
         end case;
         
      end loop TexturenZuweisenSchleife;
      
   end EinlesenHintergrund;
   
   
   
   procedure EinlesenKartenfelder
   is begin
      
      case
        Exists (Name => TextKonstanten.Grafik & TextKonstanten.Kartenfelder & TextKonstanten.NullDatei)
      is
         when False =>
            Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenKartenfelder - 0-Datei fehlt.");
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiTextEinlesen,
                  Mode => In_File,
                  Name => TextKonstanten.Grafik & TextKonstanten.Kartenfelder & TextKonstanten.NullDatei);
      end case;
      
      DateipfadeEinlesenSchleife:
      for DateipfadeEinlesenSchleifenwert in KartenfelderEinlesenArray'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenKartenfelder - Nicht genug Zeilen in 0-Datei.");
               Close (File => DateiTextEinlesen);
               KartenfelderEinlesen (DateipfadeEinlesenSchleifenwert) := TextKonstanten.LeerUnboundedString;
               return;
               
            when False =>
               KartenfelderEinlesen (DateipfadeEinlesenSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
               AktuelleZeile := AktuelleZeile + 1;
         end case;
         
      end loop DateipfadeEinlesenSchleife;
      
      Close (File => DateiTextEinlesen);
      
      TexturenZuweisenSchleife:
      for TexturenZuweisenSchleifenwert in KartenfelderEinlesenArray'Range loop
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => KartenfelderEinlesen (TexturenZuweisenSchleifenwert))))
         is
            when True =>
               EingeleseneTexturenGrafik.KartenfelderAccess (TexturenZuweisenSchleifenwert)
                 := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => KartenfelderEinlesen (TexturenZuweisenSchleifenwert))));
                  
            when False =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenKartenfelder - " & To_Wide_Wide_String (Source => KartenfelderEinlesen (TexturenZuweisenSchleifenwert)) & " fehlt.");
               EingeleseneTexturenGrafik.KartenfelderAccess (TexturenZuweisenSchleifenwert) := null;
         end case;
         
      end loop TexturenZuweisenSchleife;
      
   end EinlesenKartenfelder;
   
   
   
   procedure EinlesenKartenflüsse
   is begin
      
      case
        Exists (Name => TextKonstanten.Grafik & TextKonstanten.Kartenfluss & TextKonstanten.NullDatei)
      is
         when False =>
            Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenKartenflüsse - 0-Datei fehlt.");
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiTextEinlesen,
                  Mode => In_File,
                  Name => TextKonstanten.Grafik & TextKonstanten.Kartenfluss & TextKonstanten.NullDatei);
      end case;
      
      DateipfadeEinlesenSchleife:
      for DateipfadeEinlesenSchleifenwert in KartenflüsseEinlesenArray'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenKartenflüsse - Nicht genug Zeilen in 0-Datei.");
               Close (File => DateiTextEinlesen);
               KartenflüsseEinlesen (DateipfadeEinlesenSchleifenwert) := TextKonstanten.LeerUnboundedString;
               return;
               
            when False =>
               KartenflüsseEinlesen (DateipfadeEinlesenSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
               AktuelleZeile := AktuelleZeile + 1;
         end case;
                  
      end loop DateipfadeEinlesenSchleife;
      
      Close (File => DateiTextEinlesen);
      
      TexturenZuweisenSchleife:
      for TexturenZuweisenSchleifenwert in KartenflüsseEinlesenArray'Range loop
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => KartenflüsseEinlesen (TexturenZuweisenSchleifenwert))))
         is
            when True =>
               EingeleseneTexturenGrafik.KartenflussAccess (TexturenZuweisenSchleifenwert)
                 := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => KartenflüsseEinlesen (TexturenZuweisenSchleifenwert))));
                  
            when False =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenKartenflüsse - " & To_Wide_Wide_String (Source => KartenflüsseEinlesen (TexturenZuweisenSchleifenwert)) & " fehlt.");
               EingeleseneTexturenGrafik.KartenflussAccess (TexturenZuweisenSchleifenwert) := null;
         end case;
         
      end loop TexturenZuweisenSchleife;
      
   end EinlesenKartenflüsse;
   
   
   
   procedure EinlesenKartenressourcen
   is begin
      
      case
        Exists (Name => TextKonstanten.Grafik & TextKonstanten.Kartenressourcen & TextKonstanten.NullDatei)
      is
         when False =>
            Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenKartenressourcen - 0-Datei fehlt.");
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiTextEinlesen,
                  Mode => In_File,
                  Name => TextKonstanten.Grafik & TextKonstanten.Kartenressourcen & TextKonstanten.NullDatei);
      end case;
      
      DateipfadeEinlesenSchleife:
      for DateipfadeEinlesenSchleifenwert in KartenressourcenEinlesenArray'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenKartenressourcen - Nicht genug Zeilen in 0-Datei.");
               Close (File => DateiTextEinlesen);
               KartenressourcenEinlesen (DateipfadeEinlesenSchleifenwert) := TextKonstanten.LeerUnboundedString;
               return;
               
            when False =>
               KartenressourcenEinlesen (DateipfadeEinlesenSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
               AktuelleZeile := AktuelleZeile + 1;
         end case;
         
      end loop DateipfadeEinlesenSchleife;
      
      Close (File => DateiTextEinlesen);
      
      TexturenZuweisenSchleife:
      for TexturenZuweisenSchleifenwert in KartenressourcenEinlesenArray'Range loop
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => KartenressourcenEinlesen (TexturenZuweisenSchleifenwert))))
         is
            when True =>
               EingeleseneTexturenGrafik.KartenressourceAccess (TexturenZuweisenSchleifenwert)
                 := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => KartenressourcenEinlesen (TexturenZuweisenSchleifenwert))));
                  
            when False =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenKartenressourcen - " & To_Wide_Wide_String (Source => KartenressourcenEinlesen (TexturenZuweisenSchleifenwert)) & " fehlt.");
               EingeleseneTexturenGrafik.KartenressourceAccess (TexturenZuweisenSchleifenwert) := null;
         end case;
         
      end loop TexturenZuweisenSchleife;
      
   end EinlesenKartenressourcen;
   
   
   
   procedure EinlesenVerbesserungen
   is begin
      
      case
        Exists (Name => TextKonstanten.Grafik & TextKonstanten.Kartenverbesserungen & TextKonstanten.NullDatei)
      is
         when False =>
            Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenVerbesserungen - 0-Datei fehlt.");
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiTextEinlesen,
                  Mode => In_File,
                  Name => TextKonstanten.Grafik & TextKonstanten.Kartenverbesserungen & TextKonstanten.NullDatei);
      end case;
      
      DateipfadeEinlesenSchleife:
      for DateipfadeEinlesenSchleifenwert in VerbesserungenEinlesenArray'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenVerbesserungen - Nicht genug Zeilen in 0-Datei.");
               Close (File => DateiTextEinlesen);
               VerbesserungenEinlesen (DateipfadeEinlesenSchleifenwert) := TextKonstanten.LeerUnboundedString;
               return;
               
            when False =>
               VerbesserungenEinlesen (DateipfadeEinlesenSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
               AktuelleZeile := AktuelleZeile + 1;
         end case;
                  
      end loop DateipfadeEinlesenSchleife;
      
      Close (File => DateiTextEinlesen);
      
      TexturenZuweisenSchleife:
      for TexturenZuweisenSchleifenwert in VerbesserungenEinlesenArray'Range loop
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => VerbesserungenEinlesen (TexturenZuweisenSchleifenwert))))
         is
            when True =>
               EingeleseneTexturenGrafik.VerbesserungenAccess (TexturenZuweisenSchleifenwert)
                 := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => VerbesserungenEinlesen (TexturenZuweisenSchleifenwert))));
                  
            when False =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenVerbesserungen - " & To_Wide_Wide_String (Source => VerbesserungenEinlesen (TexturenZuweisenSchleifenwert)) & " fehlt.");
               EingeleseneTexturenGrafik.VerbesserungenAccess (TexturenZuweisenSchleifenwert) := null;
         end case;
         
      end loop TexturenZuweisenSchleife;
      
   end EinlesenVerbesserungen;
   
   
   
   procedure EinlesenWege
   is begin
      
      case
        Exists (Name => TextKonstanten.Grafik & TextKonstanten.Kartenwege & TextKonstanten.NullDatei)
      is
         when False =>
            Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenWege - 0-Datei fehlt.");
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiTextEinlesen,
                  Mode => In_File,
                  Name => TextKonstanten.Grafik & TextKonstanten.Kartenwege & TextKonstanten.NullDatei);
      end case;
      
      DateipfadeEinlesenSchleife:
      for DateipfadeEinlesenSchleifenwert in WegeEinlesenArray'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiTextEinlesen,
                                                    AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenWege - Nicht genug Zeilen in 0-Datei.");
               Close (File => DateiTextEinlesen);
               WegeEinlesen (DateipfadeEinlesenSchleifenwert) := TextKonstanten.LeerUnboundedString;
               return;
               
            when False =>
               WegeEinlesen (DateipfadeEinlesenSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
               AktuelleZeile := AktuelleZeile + 1;
         end case;
         
      end loop DateipfadeEinlesenSchleife;
      
      Close (File => DateiTextEinlesen);
      
      TexturenZuweisenSchleife:
      for TexturenZuweisenSchleifenwert in WegeEinlesenArray'Range loop
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => WegeEinlesen (TexturenZuweisenSchleifenwert))))
         is
            when True =>
               EingeleseneTexturenGrafik.WegeAccess (TexturenZuweisenSchleifenwert)
                 := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => WegeEinlesen (TexturenZuweisenSchleifenwert))));
                  
            when False =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenWege - " & To_Wide_Wide_String (Source => WegeEinlesen (TexturenZuweisenSchleifenwert)) & " fehlt.");
               EingeleseneTexturenGrafik.WegeAccess (TexturenZuweisenSchleifenwert) := null;
         end case;
         
      end loop TexturenZuweisenSchleife;
      
   end EinlesenWege;
   
   
   
   procedure EinlesenEinheiten
   is begin
      
      case
        Exists (Name => TextKonstanten.Grafik & TextKonstanten.Einheiten & TextKonstanten.NullDatei)
      is
         when False =>
            Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenEinheiten - 0-Datei fehlt.");
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiTextEinlesen,
                  Mode => In_File,
                  Name => TextKonstanten.Grafik & TextKonstanten.Einheiten & TextKonstanten.NullDatei);
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
                  Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenEinheiten - Nicht genug Zeilen in 0-Datei.");
                  Close (File => DateiTextEinlesen);
                  EinheitenEinlesen (RasseSchleifenwert, DateipfadeEinlesenSchleifenwert) := TextKonstanten.LeerUnboundedString;
                  return;
               
               when False =>
                  EinheitenEinlesen (RasseSchleifenwert, DateipfadeEinlesenSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
                  AktuelleZeile := AktuelleZeile + 1;
            end case;
                     
         end loop DateipfadeEinlesenSchleife;
      end loop RassenEinsSchleife;
      
      Close (File => DateiTextEinlesen);
      
      RassenZweiSchleife:
      for RasseSchleifenwert in EinheitenEinlesenArray'Range (1) loop
         TexturenZuweisenSchleife:
         for TexturenZuweisenSchleifenwert in EinheitenEinlesenArray'Range (2) loop
         
            case
              Exists (Name => Encode (Item => To_Wide_Wide_String (Source => EinheitenEinlesen (RasseSchleifenwert, TexturenZuweisenSchleifenwert))))
            is
               when True =>
                  EingeleseneTexturenGrafik.EinheitenAccess (RasseSchleifenwert, TexturenZuweisenSchleifenwert)
                    := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => EinheitenEinlesen (RasseSchleifenwert, TexturenZuweisenSchleifenwert))));
                  
               when False =>
                  Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenEinheiten - " & To_Wide_Wide_String (Source => EinheitenEinlesen (RasseSchleifenwert, TexturenZuweisenSchleifenwert)) & " fehlt.");
                  EingeleseneTexturenGrafik.EinheitenAccess (RasseSchleifenwert, TexturenZuweisenSchleifenwert) := null;
            end case;
         
         end loop TexturenZuweisenSchleife;
      end loop RassenZweiSchleife;
      
   end EinlesenEinheiten;
   
   
   
   procedure EinlesenGebäude
   is begin
      
      case
        Exists (Name => TextKonstanten.Grafik & TextKonstanten.Bauwerke & TextKonstanten.NullDatei)
      is
         when False =>
            Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenGebäude - 0-Datei fehlt.");
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiTextEinlesen,
                  Mode => In_File,
                  Name => TextKonstanten.Grafik & TextKonstanten.Bauwerke & TextKonstanten.NullDatei);
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
                  Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenGebäude - Nicht genug Zeilen in 0-Datei.");
                  Close (File => DateiTextEinlesen);
                  GebäudeEinlesen (RasseSchleifenwert, DateipfadeEinlesenSchleifenwert) := TextKonstanten.LeerUnboundedString;
                  return;
               
               when False =>
                  GebäudeEinlesen (RasseSchleifenwert, DateipfadeEinlesenSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
                  AktuelleZeile := AktuelleZeile + 1;
            end case;
                  
         end loop DateipfadeEinlesenSchleife;
      end loop RassenEinsSchleife;
      
      Close (File => DateiTextEinlesen);
      
      RassenZweiSchleife:
      for RasseSchleifenwert in GebäudeEinlesenArray'Range (1) loop
         TexturenZuweisenSchleife:
         for TexturenZuweisenSchleifenwert in GebäudeEinlesenArray'Range (2) loop
         
            case
              Exists (Name => Encode (Item => To_Wide_Wide_String (Source => GebäudeEinlesen (RasseSchleifenwert, TexturenZuweisenSchleifenwert))))
            is
               when True =>
                  EingeleseneTexturenGrafik.GebäudeAccess (RasseSchleifenwert, TexturenZuweisenSchleifenwert)
                    := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => GebäudeEinlesen (RasseSchleifenwert, TexturenZuweisenSchleifenwert))));
                  
               when False =>
                  Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenGebäude - " & To_Wide_Wide_String (Source => GebäudeEinlesen (RasseSchleifenwert, TexturenZuweisenSchleifenwert)) & " fehlt.");
                  EingeleseneTexturenGrafik.GebäudeAccess (RasseSchleifenwert, TexturenZuweisenSchleifenwert) := null;
            end case;
         
         end loop TexturenZuweisenSchleife;
      end loop RassenZweiSchleife;
      
   end EinlesenGebäude;
   
end EinlesenTexturen;
