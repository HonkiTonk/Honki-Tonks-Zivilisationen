pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with Sf.Graphics.Texture;

with VerzeichnisKonstanten;

with EinlesenAllgemein;
with Warnung;

-- Das hier mal parallelisieren? Wahrscheinlich unnötig. äöü
package body EinlesenTexturen is
   
   procedure EinlesenTexturen
   is begin
      
      EinlesenHintergrund;
      EinlesenKartenfelder;
      EinlesenKartenflüsse;
      EinlesenKartenressourcen;
      EinlesenVerbesserungen;
      EinlesenWege;
      EinlesenRassen;
      
   end EinlesenTexturen;
   
   
   
   procedure EinlesenHintergrund
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Hintergrund & VerzeichnisKonstanten.NullDatei)
      is
         when False =>
            Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenHintergrund - 0-Datei fehlt.");
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiHintergrund,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Hintergrund & VerzeichnisKonstanten.NullDatei);
      end case;
      
      DateipfadeSchleife:
      for DateipfadSchleifenwert in HintergrundEinlesenArray'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiHintergrund,
                                                    AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenHintergrund - Nicht genug Zeilen in 0-Datei.");
               Close (File => DateiHintergrund);
               return;
               
            when False =>
               HintergrundEinlesen (DateipfadSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiHintergrund));
               AktuelleZeile := AktuelleZeile + 1;
         end case;
                  
      end loop DateipfadeSchleife;
      
      Close (File => DateiHintergrund);
      
      TexturenSchleife:
      for TexturSchleifenwert in HintergrundEinlesenArray'Range loop
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => HintergrundEinlesen (TexturSchleifenwert))))
         is
            when True =>
               EingeleseneTexturenGrafik.HintergrundAccess (TexturSchleifenwert)
                 := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => HintergrundEinlesen (TexturSchleifenwert))));
                  
            when False =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenHintergrund - " & To_Wide_Wide_String (Source => HintergrundEinlesen (TexturSchleifenwert)) & " fehlt.");
               EingeleseneTexturenGrafik.HintergrundAccess (TexturSchleifenwert) := null;
         end case;
         
      end loop TexturenSchleife;
      
   end EinlesenHintergrund;
   
   
   
   procedure EinlesenKartenfelder
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenfelder & VerzeichnisKonstanten.NullDatei)
      is
         when False =>
            Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenKartenfelder - 0-Datei fehlt.");
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiKartenfelder,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenfelder & VerzeichnisKonstanten.NullDatei);
      end case;
      
      DateipfadeSchleife:
      for DateipfadSchleifenwert in KartenfelderEinlesenArray'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiKartenfelder,
                                                    AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenKartenfelder - Nicht genug Zeilen in 0-Datei.");
               Close (File => DateiKartenfelder);
               return;
               
            when False =>
               KartenfelderEinlesen (DateipfadSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiKartenfelder));
               AktuelleZeile := AktuelleZeile + 1;
         end case;
         
      end loop DateipfadeSchleife;
      
      Close (File => DateiKartenfelder);
      
      TexturenSchleife:
      for TexturSchleifenwert in KartenfelderEinlesenArray'Range loop
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => KartenfelderEinlesen (TexturSchleifenwert))))
         is
            when True =>
               EingeleseneTexturenGrafik.KartenfelderAccess (TexturSchleifenwert)
                 := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => KartenfelderEinlesen (TexturSchleifenwert))));
                  
            when False =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenKartenfelder - " & To_Wide_Wide_String (Source => KartenfelderEinlesen (TexturSchleifenwert)) & " fehlt.");
               EingeleseneTexturenGrafik.KartenfelderAccess (TexturSchleifenwert) := null;
         end case;
         
      end loop TexturenSchleife;
      
   end EinlesenKartenfelder;
   
   
   
   procedure EinlesenKartenflüsse
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenfluss & VerzeichnisKonstanten.NullDatei)
      is
         when False =>
            Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenKartenflüsse - 0-Datei fehlt.");
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiKartenflüsse,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenfluss & VerzeichnisKonstanten.NullDatei);
      end case;
      
      DateipfadeSchleife:
      for DateipfadSchleifenwert in KartenflüsseEinlesenArray'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiKartenflüsse,
                                                    AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenKartenflüsse - Nicht genug Zeilen in 0-Datei.");
               Close (File => DateiKartenflüsse);
               return;
               
            when False =>
               KartenflüsseEinlesen (DateipfadSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiKartenflüsse));
               AktuelleZeile := AktuelleZeile + 1;
         end case;
                  
      end loop DateipfadeSchleife;
      
      Close (File => DateiKartenflüsse);
      
      TexturenSchleife:
      for TexturSchleifenwert in KartenflüsseEinlesenArray'Range loop
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => KartenflüsseEinlesen (TexturSchleifenwert))))
         is
            when True =>
               EingeleseneTexturenGrafik.KartenflussAccess (TexturSchleifenwert)
                 := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => KartenflüsseEinlesen (TexturSchleifenwert))));
                  
            when False =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenKartenflüsse - " & To_Wide_Wide_String (Source => KartenflüsseEinlesen (TexturSchleifenwert)) & " fehlt.");
               EingeleseneTexturenGrafik.KartenflussAccess (TexturSchleifenwert) := null;
         end case;
         
      end loop TexturenSchleife;
      
   end EinlesenKartenflüsse;
   
   
   
   procedure EinlesenKartenressourcen
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenressourcen & VerzeichnisKonstanten.NullDatei)
      is
         when False =>
            Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenKartenressourcen - 0-Datei fehlt.");
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiKartenressourcen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenressourcen & VerzeichnisKonstanten.NullDatei);
      end case;
      
      DateipfadeSchleife:
      for DateipfadSchleifenwert in KartenressourcenEinlesenArray'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiKartenressourcen,
                                                    AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenKartenressourcen - Nicht genug Zeilen in 0-Datei.");
               Close (File => DateiKartenressourcen);
               return;
               
            when False =>
               KartenressourcenEinlesen (DateipfadSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiKartenressourcen));
               AktuelleZeile := AktuelleZeile + 1;
         end case;
         
      end loop DateipfadeSchleife;
      
      Close (File => DateiKartenressourcen);
      
      TexturenSchleife:
      for TexturSchleifenwert in KartenressourcenEinlesenArray'Range loop
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => KartenressourcenEinlesen (TexturSchleifenwert))))
         is
            when True =>
               EingeleseneTexturenGrafik.KartenressourceAccess (TexturSchleifenwert)
                 := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => KartenressourcenEinlesen (TexturSchleifenwert))));
                  
            when False =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenKartenressourcen - " & To_Wide_Wide_String (Source => KartenressourcenEinlesen (TexturSchleifenwert)) & " fehlt.");
               EingeleseneTexturenGrafik.KartenressourceAccess (TexturSchleifenwert) := null;
         end case;
         
      end loop TexturenSchleife;
      
   end EinlesenKartenressourcen;
   
   
   
   procedure EinlesenVerbesserungen
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenverbesserungen & VerzeichnisKonstanten.NullDatei)
      is
         when False =>
            Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenVerbesserungen - 0-Datei fehlt.");
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiVerbesserungen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenverbesserungen & VerzeichnisKonstanten.NullDatei);
      end case;
      
      DateipfadeSchleife:
      for DateipfadSchleifenwert in VerbesserungenEinlesenArray'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiVerbesserungen,
                                                    AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenVerbesserungen - Nicht genug Zeilen in 0-Datei.");
               Close (File => DateiVerbesserungen);
               return;
               
            when False =>
               VerbesserungenEinlesen (DateipfadSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiVerbesserungen));
               AktuelleZeile := AktuelleZeile + 1;
         end case;
                  
      end loop DateipfadeSchleife;
      
      Close (File => DateiVerbesserungen);
      
      TexturenSchleife:
      for TexturSchleifenwert in VerbesserungenEinlesenArray'Range loop
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => VerbesserungenEinlesen (TexturSchleifenwert))))
         is
            when True =>
               EingeleseneTexturenGrafik.VerbesserungenAccess (TexturSchleifenwert)
                 := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => VerbesserungenEinlesen (TexturSchleifenwert))));
                  
            when False =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenVerbesserungen - " & To_Wide_Wide_String (Source => VerbesserungenEinlesen (TexturSchleifenwert)) & " fehlt.");
               EingeleseneTexturenGrafik.VerbesserungenAccess (TexturSchleifenwert) := null;
         end case;
         
      end loop TexturenSchleife;
      
   end EinlesenVerbesserungen;
   
   
   
   procedure EinlesenWege
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenwege & VerzeichnisKonstanten.NullDatei)
      is
         when False =>
            Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenWege - 0-Datei fehlt.");
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiWege,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenwege & VerzeichnisKonstanten.NullDatei);
      end case;
      
      DateipfadeSchleife:
      for DateipfadSchleifenwert in WegeEinlesenArray'Range loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiWege,
                                                    AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenWege - Nicht genug Zeilen in 0-Datei.");
               Close (File => DateiWege);
               return;
               
            when False =>
               WegeEinlesen (DateipfadSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiWege));
               AktuelleZeile := AktuelleZeile + 1;
         end case;
         
      end loop DateipfadeSchleife;
      
      Close (File => DateiWege);
      
      TexturenSchleife:
      for TexturSchleifenwert in WegeEinlesenArray'Range loop
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => WegeEinlesen (TexturSchleifenwert))))
         is
            when True =>
               EingeleseneTexturenGrafik.WegeAccess (TexturSchleifenwert)
                 := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => WegeEinlesen (TexturSchleifenwert))));
                  
            when False =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenWege - " & To_Wide_Wide_String (Source => WegeEinlesen (TexturSchleifenwert)) & " fehlt.");
               EingeleseneTexturenGrafik.WegeAccess (TexturSchleifenwert) := null;
         end case;
         
      end loop TexturenSchleife;
      
   end EinlesenWege;
   
   
   
   procedure EinlesenRassen
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Rassen & VerzeichnisKonstanten.NullDatei)
      is
         when False =>
            Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenRassen - 0-Datei fehlt.");
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiRassen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Rassen & VerzeichnisKonstanten.NullDatei);
      end case;
      
      RassenschleifeSchleife:
      for RasseSchleifenwert in RassenEinlesenArray'Range (1) loop
         EinzelpfadeEinlesenSchleife:
         for EinzelpfadeEinlesenSchleifenwert in RassenEinlesenArray'Range (2) loop
         
            case
              EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiRassen,
                                                       AktuelleZeileExtern => AktuelleZeile)
            is
               when True =>
                  Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenRassen - Nicht genug Zeilen in 0-Datei.");
                  Close (File => DateiRassen);
                  return;
               
               when False =>
                  RassenEinlesen (RasseSchleifenwert, EinzelpfadeEinlesenSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiRassen));
                  AktuelleZeile := AktuelleZeile + 1;
            end case;
         
         end loop EinzelpfadeEinlesenSchleife;
         
         EinlesenRassenhintergrund (DateipfadExtern => To_Wide_Wide_String (Source => RassenEinlesen (RasseSchleifenwert, 1)),
                                    RasseExtern     => RasseSchleifenwert);
         
         EinlesenEinheiten (DateipfadExtern => To_Wide_Wide_String (Source => RassenEinlesen (RasseSchleifenwert, 2)),
                            RasseExtern     => RasseSchleifenwert);
         
         EinlesenGebäude (DateipfadExtern => To_Wide_Wide_String (Source => RassenEinlesen (RasseSchleifenwert, 3)),
                           RasseExtern     => RasseSchleifenwert);
         
      end loop RassenschleifeSchleife;
      
      Close (File => DateiRassen);
      
   end EinlesenRassen;
   
   
   
   procedure EinlesenRassenhintergrund
     (DateipfadExtern : in Wide_Wide_String;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        Exists (Name => Encode (Item => DateipfadExtern))
      is
         when False =>
            Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenRassenhintergrund - 0-Datei fehlt.");
            return;
            
         when True =>
            ZeileRassenhintergrund := 1;
            
            Open (File => DateiRassenhintergründe,
                  Mode => In_File,
                  Name => Encode (Item => DateipfadExtern));
      end case;
      
      DateipfadeSchleife:
      for DateipfadSchleifenwert in RassenhintergrundEinlesenArray'Range (2) loop
            
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiRassenhintergründe,
                                                    AktuelleZeileExtern => ZeileRassenhintergrund)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenRassenhintergrund - Nicht genug Zeilen in 0-Datei.");
               Close (File => DateiRassenhintergründe);
               return;
               
            when False =>
               RassenhintergrundEinlesen (RasseExtern, DateipfadSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiRassenhintergründe));
               ZeileRassenhintergrund := ZeileRassenhintergrund + 1;
         end case;
                     
      end loop DateipfadeSchleife;
      
      Close (File => DateiRassenhintergründe);
      
      TexturenSchleife:
      for TexturSchleifenwert in RassenhintergrundEinlesenArray'Range (2) loop
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => RassenhintergrundEinlesen (RasseExtern, TexturSchleifenwert))))
         is
            when True =>
               EingeleseneTexturenGrafik.RassenhintergrundAccess (RasseExtern, TexturSchleifenwert)
                 := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => RassenhintergrundEinlesen (RasseExtern, TexturSchleifenwert))));
                  
            when False =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenEinheiten - " & To_Wide_Wide_String (Source => RassenhintergrundEinlesen (RasseExtern, TexturSchleifenwert)) & " fehlt.");
               EingeleseneTexturenGrafik.RassenhintergrundAccess (RasseExtern, TexturSchleifenwert) := null;
         end case;
         
      end loop TexturenSchleife;
      
   end EinlesenRassenhintergrund;
   
   
   
   procedure EinlesenEinheiten
     (DateipfadExtern : in Wide_Wide_String;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        Exists (Name => Encode (Item => DateipfadExtern))
      is
         when False =>
            Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenEinheiten - 0-Datei fehlt.");
            return;
            
         when True =>
            ZeileEinheiten := 1;
            
            Open (File => DateiEinheiten,
                  Mode => In_File,
                  Name => Encode (Item => DateipfadExtern));
      end case;
      
      DateipfadeSchleife:
      for DateipfadSchleifenwert in EinheitenEinlesenArray'Range (2) loop
            
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiEinheiten,
                                                    AktuelleZeileExtern => ZeileEinheiten)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenEinheiten - Nicht genug Zeilen in 0-Datei.");
               Close (File => DateiEinheiten);
               return;
               
            when False =>
               EinheitenEinlesen (RasseExtern, DateipfadSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiEinheiten));
               ZeileEinheiten := ZeileEinheiten + 1;
         end case;
                     
      end loop DateipfadeSchleife;
      
      Close (File => DateiEinheiten);
      
      TexturenSchleife:
      for TexturSchleifenwert in EinheitenEinlesenArray'Range (2) loop
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => EinheitenEinlesen (RasseExtern, TexturSchleifenwert))))
         is
            when True =>
               EingeleseneTexturenGrafik.EinheitenAccess (RasseExtern, TexturSchleifenwert)
                 := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => EinheitenEinlesen (RasseExtern, TexturSchleifenwert))));
                  
            when False =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenEinheiten - " & To_Wide_Wide_String (Source => EinheitenEinlesen (RasseExtern, TexturSchleifenwert)) & " fehlt.");
               EingeleseneTexturenGrafik.EinheitenAccess (RasseExtern, TexturSchleifenwert) := null;
         end case;
         
      end loop TexturenSchleife;
      
   end EinlesenEinheiten;
   
   
   
   procedure EinlesenGebäude
     (DateipfadExtern : in Wide_Wide_String;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        Exists (Name => Encode (Item => DateipfadExtern))
      is
         when False =>
            Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenGebäude - 0-Datei fehlt.");
            return;
            
         when True =>
            ZeileGebäude := 1;
            
            Open (File => DateiGebäude,
                  Mode => In_File,
                  Name => Encode (Item => DateipfadExtern));
      end case;
      
      DateipfadeSchleife:
      for DateipfadSchleifenwert in GebäudeEinlesenArray'Range (2) loop
         
         case
           EinlesenAllgemein.VorzeitigesZeilenende (AktuelleDateiExtern => DateiGebäude,
                                                    AktuelleZeileExtern => ZeileGebäude)
         is
            when True =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenGebäude - Nicht genug Zeilen in 0-Datei.");
               Close (File => DateiGebäude);
               return;
               
            when False =>
               GebäudeEinlesen (RasseExtern, DateipfadSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiGebäude));
               ZeileGebäude := ZeileGebäude + 1;
         end case;
                  
      end loop DateipfadeSchleife;
      
      Close (File => DateiGebäude);
      
      TexturenSchleife:
      for TexturSchleifenwert in GebäudeEinlesenArray'Range (2) loop
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => GebäudeEinlesen (RasseExtern, TexturSchleifenwert))))
         is
            when True =>
               EingeleseneTexturenGrafik.GebäudeAccess (RasseExtern, TexturSchleifenwert)
                 := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => GebäudeEinlesen (RasseExtern, TexturSchleifenwert))));
                  
            when False =>
               Warnung.LogikWarnung (WarnmeldungExtern => "EinlesenTexturen.EinlesenGebäude - " & To_Wide_Wide_String (Source => GebäudeEinlesen (RasseExtern, TexturSchleifenwert)) & " fehlt.");
               EingeleseneTexturenGrafik.GebäudeAccess (RasseExtern, TexturSchleifenwert) := null;
         end case;
         
      end loop TexturenSchleife;
      
   end EinlesenGebäude;
   
end EinlesenTexturen;
