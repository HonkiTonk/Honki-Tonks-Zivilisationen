with Ada.Directories; use Ada.Directories;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with Sf.Graphics.Texture;

with VerzeichnisKonstanten;
with EingeleseneTexturenGrafik;

with EinlesenAllgemeinesLogik;
with Fehlermeldungssystem;

package body EinlesenTexturenLogik is
   
   procedure EinlesenTexturen
   is begin
      
      EinlesenSystem;
      EinlesenHintergrund;
      EinlesenKartenfelder;
      EinlesenKartenflüsse;
      EinlesenKartenressourcen;
      EinlesenVerbesserungen;
      EinlesenWege;
      EinlesenRassen;
      
   end EinlesenTexturen;
   
   
   
   procedure EinlesenSystem
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.System & VerzeichnisKonstanten.NullDatei)
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenSystem: Es fehlt: "
                                        & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.System & VerzeichnisKonstanten.NullDatei));
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiSystem,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.System & VerzeichnisKonstanten.NullDatei);
      end case;
      
      TexturenSchleife:
      for TexturSchleifenwert in EingeleseneTexturenGrafik.SystemAccessArray'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiSystem,
                                                           AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenSystem: Fehlende Zeilen: "
                                           & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.System & VerzeichnisKonstanten.NullDatei));
               exit TexturenSchleife;
               
            when False =>
               Verzeichnisname := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiSystem));
               AktuelleZeile := AktuelleZeile + 1;
         end case;
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)))
         is
            when True =>
               EingeleseneTexturenGrafik.SystemAccess (TexturSchleifenwert)
                 := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)));
                  
            when False =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenSystem: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
               EingeleseneTexturenGrafik.SystemAccess (TexturSchleifenwert) := null;
         end case;
                  
      end loop TexturenSchleife;
      
      case
        EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiSystem,
                                                        AktuelleZeileExtern => AktuelleZeile)
      is
         when True =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenSystem: Fehlende Zeilen: "
                                        & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.System & VerzeichnisKonstanten.NullDatei));
            Close (File => DateiSystem);
            return;
               
         when False =>
            Verzeichnisname := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiSystem));
      end case;
         
      case
        Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)))
      is
         when True =>
            EingeleseneTexturenGrafik.BilderAccess (1) := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)));
                  
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenSystem: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
            EingeleseneTexturenGrafik.BilderAccess (1) := null;
      end case;
      
      Close (File => DateiSystem);
      
   end EinlesenSystem;
   
   
   
   procedure EinlesenHintergrund
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Hintergrund & VerzeichnisKonstanten.NullDatei)
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenHintergrund: Es fehlt: "
                                        & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Hintergrund & VerzeichnisKonstanten.NullDatei));
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiHintergrund,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Hintergrund & VerzeichnisKonstanten.NullDatei);
      end case;
      
      TexturenSchleife:
      for TexturSchleifenwert in EingeleseneTexturenGrafik.HintergrundAccessArray'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiHintergrund,
                                                           AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenHintergrund: Fehlende Zeilen: "
                                           & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Hintergrund & VerzeichnisKonstanten.NullDatei));
               exit TexturenSchleife;
               
            when False =>
               Verzeichnisname := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiHintergrund));
               AktuelleZeile := AktuelleZeile + 1;
         end case;
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)))
         is
            when True =>
               EingeleseneTexturenGrafik.HintergrundAccess (TexturSchleifenwert)
                 := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)));
                  
            when False =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenHintergrund: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
               EingeleseneTexturenGrafik.HintergrundAccess (TexturSchleifenwert) := null;
         end case;
                  
      end loop TexturenSchleife;
      
      Close (File => DateiHintergrund);
      
   end EinlesenHintergrund;
   
   
   
   procedure EinlesenKartenfelder
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Basisgrund & VerzeichnisKonstanten.NullDatei)
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenKartenfelder: Es fehlt: "
                                        & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Basisgrund & VerzeichnisKonstanten.NullDatei));
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiKartenfelder,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Basisgrund & VerzeichnisKonstanten.NullDatei);
      end case;
      
      BasisgrundSchleife:
      for BasisgrundSchleifenwert in EingeleseneTexturenGrafik.BasisgrundAccessArray'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiKartenfelder,
                                                           AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenKartenfelder: Fehlende Zeilen: "
                                           & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Basisgrund & VerzeichnisKonstanten.NullDatei));
               exit BasisgrundSchleife;
               
            when False =>
               Verzeichnisname := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiKartenfelder));
               AktuelleZeile := AktuelleZeile + 1;
         end case;
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)))
         is
            when True =>
               EingeleseneTexturenGrafik.BasisgrundAccess (BasisgrundSchleifenwert)
                 := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)));
                  
            when False =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenKartenfelder: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
               EingeleseneTexturenGrafik.BasisgrundAccess (BasisgrundSchleifenwert) := null;
         end case;
         
      end loop BasisgrundSchleife;
      
      Close (File => DateiKartenfelder);
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Zusatzgrund & VerzeichnisKonstanten.NullDatei)
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenKartenfelder: Es fehlt: "
                                        & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Basisgrund & VerzeichnisKonstanten.NullDatei));
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiKartenfelder,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Zusatzgrund & VerzeichnisKonstanten.NullDatei);
      end case;
      
      ZusatzgrundSchleife:
      for ZusatzgrundSchleifenwert in EingeleseneTexturenGrafik.ZusatzgrundAccessArray'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiKartenfelder,
                                                           AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenKartenfelder: Fehlende Zeilen: "
                                           & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Zusatzgrund & VerzeichnisKonstanten.NullDatei));
               exit ZusatzgrundSchleife;
               
            when False =>
               Verzeichnisname := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiKartenfelder));
               AktuelleZeile := AktuelleZeile + 1;
         end case;
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)))
         is
            when True =>
               EingeleseneTexturenGrafik.ZusatzgrundAccess (ZusatzgrundSchleifenwert)
                 := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)));
                  
            when False =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenKartenfelder: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
               EingeleseneTexturenGrafik.ZusatzgrundAccess (ZusatzgrundSchleifenwert) := null;
         end case;
         
      end loop ZusatzgrundSchleife;
      
      Close (File => DateiKartenfelder);
      
   end EinlesenKartenfelder;
   
   
   
   procedure EinlesenKartenflüsse
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenfluss & VerzeichnisKonstanten.NullDatei)
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenKartenflüsse: Es fehlt: "
                                        & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenfluss & VerzeichnisKonstanten.NullDatei));
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiKartenflüsse,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenfluss & VerzeichnisKonstanten.NullDatei);
      end case;
      
      TexturenSchleife:
      for TexturSchleifenwert in EingeleseneTexturenGrafik.KartenflussAccessArray'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiKartenflüsse,
                                                           AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenKartenflüsse: Fehlende Zeilen: "
                                           & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenfluss & VerzeichnisKonstanten.NullDatei));
               exit TexturenSchleife;
               
            when False =>
               Verzeichnisname := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiKartenflüsse));
               AktuelleZeile := AktuelleZeile + 1;
         end case;
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)))
         is
            when True =>
               EingeleseneTexturenGrafik.KartenflussAccess (TexturSchleifenwert)
                 := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)));
                  
            when False =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenKartenflüsse: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
               EingeleseneTexturenGrafik.KartenflussAccess (TexturSchleifenwert) := null;
         end case;
                  
      end loop TexturenSchleife;
      
      Close (File => DateiKartenflüsse);
      
   end EinlesenKartenflüsse;
   
   
   
   procedure EinlesenKartenressourcen
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenressourcen & VerzeichnisKonstanten.NullDatei)
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenKartenressourcen: Es fehlt: "
                                        & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenressourcen & VerzeichnisKonstanten.NullDatei));
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiKartenressourcen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenressourcen & VerzeichnisKonstanten.NullDatei);
      end case;
      
      TexturenSchleife:
      for TexturSchleifenwert in EingeleseneTexturenGrafik.KartenressourcenAccessArray'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiKartenressourcen,
                                                           AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenKartenressourcen: Fehlende Zeilen: "
                                           & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenressourcen & VerzeichnisKonstanten.NullDatei));
               exit TexturenSchleife;
               
            when False =>
               Verzeichnisname := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiKartenressourcen));
               AktuelleZeile := AktuelleZeile + 1;
         end case;
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)))
         is
            when True =>
               EingeleseneTexturenGrafik.KartenressourceAccess (TexturSchleifenwert)
                 := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)));
                  
            when False =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenKartenressourcen: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
               EingeleseneTexturenGrafik.KartenressourceAccess (TexturSchleifenwert) := null;
         end case;
         
      end loop TexturenSchleife;
      
      Close (File => DateiKartenressourcen);
      
   end EinlesenKartenressourcen;
   
   
   
   procedure EinlesenVerbesserungen
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenverbesserungen & VerzeichnisKonstanten.NullDatei)
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenVerbesserungen: Es fehlt: "
                                        & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenverbesserungen & VerzeichnisKonstanten.NullDatei));
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiVerbesserungen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenverbesserungen & VerzeichnisKonstanten.NullDatei);
      end case;
      
      TexturenSchleife:
      for TexturSchleifenwert in EingeleseneTexturenGrafik.VerbesserungenAccessArray'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiVerbesserungen,
                                                           AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenVerbesserungen: Fehlende Zeilen: "
                                           & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenverbesserungen & VerzeichnisKonstanten.NullDatei));
               exit TexturenSchleife;
               
            when False =>
               Verzeichnisname := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiVerbesserungen));
               AktuelleZeile := AktuelleZeile + 1;
         end case;
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)))
         is
            when True =>
               EingeleseneTexturenGrafik.VerbesserungenAccess (TexturSchleifenwert)
                 := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)));
                  
            when False =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenVerbesserungen: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
               EingeleseneTexturenGrafik.VerbesserungenAccess (TexturSchleifenwert) := null;
         end case;
                  
      end loop TexturenSchleife;
      
      Close (File => DateiVerbesserungen);
      
   end EinlesenVerbesserungen;
   
   
   
   procedure EinlesenWege
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenwege & VerzeichnisKonstanten.NullDatei)
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenWege: Es fehlt: "
                                        & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenwege & VerzeichnisKonstanten.NullDatei));
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiWege,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenwege & VerzeichnisKonstanten.NullDatei);
      end case;
      
      TexturenSchleife:
      for TexturSchleifenwert in EingeleseneTexturenGrafik.WegeAccessArray'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiWege,
                                                           AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenWege: Fehlende Zeilen: "
                                           & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenwege & VerzeichnisKonstanten.NullDatei));
               exit TexturenSchleife;
               
            when False =>
               Verzeichnisname := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiWege));
               AktuelleZeile := AktuelleZeile + 1;
         end case;
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)))
         is
            when True =>
               EingeleseneTexturenGrafik.WegeAccess (TexturSchleifenwert)
                 := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)));
                  
            when False =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenWege: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
               EingeleseneTexturenGrafik.WegeAccess (TexturSchleifenwert) := null;
         end case;
         
      end loop TexturenSchleife;
      
      Close (File => DateiWege);
      
   end EinlesenWege;
   
   
   
   procedure EinlesenRassen
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Rassen & VerzeichnisKonstanten.NullDatei)
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenRassen: Es fehlt: "
                                        & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Rassen & VerzeichnisKonstanten.NullDatei));
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiRassen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Rassen & VerzeichnisKonstanten.NullDatei);
      end case;
      
      RassenschleifeSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         EinzelpfadeEinlesenSchleife:
         for EinzelpfadeEinlesenSchleifenwert in RassenverzeichnisseArray'Range loop
         
            case
              EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiRassen,
                                                              AktuelleZeileExtern => AktuelleZeile)
            is
               when True =>
                  Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenRassen: Fehlende Zeilen: "
                                              & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Rassen & VerzeichnisKonstanten.NullDatei));
                  exit RassenschleifeSchleife;
               
               when False =>
                  Rassenverzeichnisse (EinzelpfadeEinlesenSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiRassen));
                  AktuelleZeile := AktuelleZeile + 1;
            end case;
         
         end loop EinzelpfadeEinlesenSchleife;
         
         EinlesenRassenhintergrund (DateipfadExtern => To_Wide_Wide_String (Source => Rassenverzeichnisse (1)),
                                    RasseExtern     => RasseSchleifenwert);
         
         EinlesenEinheiten (DateipfadExtern => To_Wide_Wide_String (Source => Rassenverzeichnisse (2)),
                            RasseExtern     => RasseSchleifenwert);
         
         EinlesenGebäude (DateipfadExtern => To_Wide_Wide_String (Source => Rassenverzeichnisse (3)),
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
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenRassenhintergrund: Es fehlt: " & DateipfadExtern);
            return;
            
         when True =>
            ZeileRassenhintergrund := 1;
            
            Open (File => DateiRassenhintergründe,
                  Mode => In_File,
                  Name => Encode (Item => DateipfadExtern));
      end case;
      
      TexturenSchleife:
      for TexturSchleifenwert in EingeleseneTexturenGrafik.RassenhintergrundAccessArray'Range (2) loop
            
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiRassenhintergründe,
                                                           AktuelleZeileExtern => ZeileRassenhintergrund)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenRassenhintergrund: Fehlende Zeilen: " & DateipfadExtern);
               exit TexturenSchleife;
               
            when False =>
               Verzeichnisname := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiRassenhintergründe));
               ZeileRassenhintergrund := ZeileRassenhintergrund + 1;
         end case;
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)))
         is
            when True =>
               EingeleseneTexturenGrafik.RassenhintergrundAccess (RasseExtern, TexturSchleifenwert)
                 := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)));
                  
            when False =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenEinheiten: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
               EingeleseneTexturenGrafik.RassenhintergrundAccess (RasseExtern, TexturSchleifenwert) := null;
         end case;
                     
      end loop TexturenSchleife;
      
      Close (File => DateiRassenhintergründe);
      
   end EinlesenRassenhintergrund;
   
   
   
   procedure EinlesenEinheiten
     (DateipfadExtern : in Wide_Wide_String;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        Exists (Name => Encode (Item => DateipfadExtern))
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenEinheiten: Es fehlt: " & DateipfadExtern);
            return;
            
         when True =>
            ZeileEinheiten := 1;
            
            Open (File => DateiEinheiten,
                  Mode => In_File,
                  Name => Encode (Item => DateipfadExtern));
      end case;
      
      TexturenSchleife:
      for TexturSchleifenwert in EingeleseneTexturenGrafik.EinheitenAccesArray'Range (2) loop
            
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiEinheiten,
                                                           AktuelleZeileExtern => ZeileEinheiten)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenEinheiten: Fehlende Zeilen: " & DateipfadExtern);
               exit TexturenSchleife;
               
            when False =>
               Verzeichnisname := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiEinheiten));
               ZeileEinheiten := ZeileEinheiten + 1;
         end case;
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)))
         is
            when True =>
               EingeleseneTexturenGrafik.EinheitenAccess (RasseExtern, TexturSchleifenwert)
                 := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)));
                  
            when False =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenEinheiten: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
               EingeleseneTexturenGrafik.EinheitenAccess (RasseExtern, TexturSchleifenwert) := null;
         end case;
                     
      end loop TexturenSchleife;
      
      Close (File => DateiEinheiten);
      
   end EinlesenEinheiten;
   
   
   
   procedure EinlesenGebäude
     (DateipfadExtern : in Wide_Wide_String;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        Exists (Name => Encode (Item => DateipfadExtern))
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenGebäude: Es fehlt: " & DateipfadExtern);
            return;
            
         when True =>
            ZeileGebäude := 1;
            
            Open (File => DateiGebäude,
                  Mode => In_File,
                  Name => Encode (Item => DateipfadExtern));
      end case;
      
      TexturenSchleife:
      for TexturSchleifenwert in EingeleseneTexturenGrafik.GebäudeAccessArray'Range (2) loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiGebäude,
                                                           AktuelleZeileExtern => ZeileGebäude)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenGebäude: Fehlende Zeilen: " & DateipfadExtern);
               exit TexturenSchleife;
               
            when False =>
               Verzeichnisname := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiGebäude));
               ZeileGebäude := ZeileGebäude + 1;
         end case;
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)))
         is
            when True =>
               EingeleseneTexturenGrafik.GebäudeAccess (RasseExtern, TexturSchleifenwert)
                 := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)));
                  
            when False =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturen.EinlesenGebäude: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
               EingeleseneTexturenGrafik.GebäudeAccess (RasseExtern, TexturSchleifenwert) := null;
         end case;
                  
      end loop TexturenSchleife;
      
      Close (File => DateiGebäude);
      
   end EinlesenGebäude;
   
end EinlesenTexturenLogik;
