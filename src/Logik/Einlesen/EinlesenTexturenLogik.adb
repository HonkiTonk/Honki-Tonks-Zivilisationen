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
      EinlesenSpezies;
      
   end EinlesenTexturen;
   
   
   
   procedure EinlesenSystem
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.System & VerzeichnisKonstanten.NullDatei)
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenSystem: Es fehlt: "
                                        & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.System & VerzeichnisKonstanten.NullDatei));
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiSystem,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.System & VerzeichnisKonstanten.NullDatei,
                  Form => "WCEM=8");
      end case;
      
      TexturenSchleife:
      for TexturSchleifenwert in EingeleseneTexturenGrafik.SystemAccessArray'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiSystem,
                                                           AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenSystem: Fehlende Zeilen: "
                                           & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.System & VerzeichnisKonstanten.NullDatei) & ", aktuelle Zeile: " & AktuelleZeile'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenSystem: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
               EingeleseneTexturenGrafik.SystemAccess (TexturSchleifenwert) := null;
         end case;
                  
      end loop TexturenSchleife;
      
      case
        EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiSystem,
                                                        AktuelleZeileExtern => AktuelleZeile)
      is
         when True =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenSystem: Fehlende Zeilen: "
                                        & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.System & VerzeichnisKonstanten.NullDatei) & ", aktuelle Zeile: " & AktuelleZeile'Wide_Wide_Image);
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
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenSystem: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
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
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenHintergrund: Es fehlt: "
                                        & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Hintergrund & VerzeichnisKonstanten.NullDatei));
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiHintergrund,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Hintergrund & VerzeichnisKonstanten.NullDatei,
                  Form => "WCEM=8");
      end case;
      
      TexturenSchleife:
      for TexturSchleifenwert in EingeleseneTexturenGrafik.HintergrundAccessArray'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiHintergrund,
                                                           AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenHintergrund: Fehlende Zeilen: "
                                           & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Hintergrund & VerzeichnisKonstanten.NullDatei) & ", aktuelle Zeile: " & AktuelleZeile'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenHintergrund: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
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
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenKartenfelder: Es fehlt: "
                                        & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Basisgrund & VerzeichnisKonstanten.NullDatei));
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiKartenfelder,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Basisgrund & VerzeichnisKonstanten.NullDatei,
                  Form => "WCEM=8");
      end case;
      
      BasisgrundSchleife:
      for BasisgrundSchleifenwert in EingeleseneTexturenGrafik.BasisgrundAccessArray'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiKartenfelder,
                                                           AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenKartenfelder: Fehlende Zeilen: "
                                           & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Basisgrund & VerzeichnisKonstanten.NullDatei) & ", aktuelle Zeile: " & AktuelleZeile'Wide_Wide_Image);
               exit BasisgrundSchleife;
               
            when False =>
               Verzeichnisname := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiKartenfelder));
               AktuelleZeile := AktuelleZeile + 1;
         end case;
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)))
         is
            when True =>
               EingeleseneTexturenGrafik.BasisgrundAccess (BasisgrundSchleifenwert) := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)));
                  
            when False =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenKartenfelder: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
               EingeleseneTexturenGrafik.BasisgrundAccess (BasisgrundSchleifenwert) := null;
         end case;
         
      end loop BasisgrundSchleife;
      
      Close (File => DateiKartenfelder);
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Zusatzgrund & VerzeichnisKonstanten.NullDatei)
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenKartenfelder: Es fehlt: "
                                        & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Basisgrund & VerzeichnisKonstanten.NullDatei));
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiKartenfelder,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Zusatzgrund & VerzeichnisKonstanten.NullDatei,
                  Form => "WCEM=8");
      end case;
      
      ZusatzgrundSchleife:
      for ZusatzgrundSchleifenwert in EingeleseneTexturenGrafik.ZusatzgrundAccessArray'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiKartenfelder,
                                                           AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenKartenfelder: Fehlende Zeilen: "
                                           & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Zusatzgrund & VerzeichnisKonstanten.NullDatei) & ", aktuelle Zeile: " & AktuelleZeile'Wide_Wide_Image);
               exit ZusatzgrundSchleife;
               
            when False =>
               Verzeichnisname := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiKartenfelder));
               AktuelleZeile := AktuelleZeile + 1;
         end case;
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)))
         is
            when True =>
               EingeleseneTexturenGrafik.ZusatzgrundAccess (ZusatzgrundSchleifenwert) := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)));
                  
            when False =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenKartenfelder: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
               EingeleseneTexturenGrafik.ZusatzgrundAccess (ZusatzgrundSchleifenwert) := null;
         end case;
         
      end loop ZusatzgrundSchleife;
      
      Close (File => DateiKartenfelder);
      
      
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Feldeffekte & VerzeichnisKonstanten.NullDatei)
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenKartenfelder: Es fehlt: "
                                        & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Feldeffekte & VerzeichnisKonstanten.NullDatei));
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiKartenfelder,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Feldeffekte & VerzeichnisKonstanten.NullDatei,
                  Form => "WCEM=8");
      end case;
      
      FeldeffekteSchleife:
      for FeldeffekteSchleifenwert in EingeleseneTexturenGrafik.FeldeffekteAccessArray'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiKartenfelder,
                                                           AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenKartenfelder: Fehlende Zeilen: "
                                           & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Feldeffekte & VerzeichnisKonstanten.NullDatei) & ", aktuelle Zeile: " & AktuelleZeile'Wide_Wide_Image);
               exit FeldeffekteSchleife;
               
            when False =>
               Verzeichnisname := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiKartenfelder));
               AktuelleZeile := AktuelleZeile + 1;
         end case;
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)))
         is
            when True =>
               EingeleseneTexturenGrafik.FeldeffekteAccess (FeldeffekteSchleifenwert) := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)));
                  
            when False =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenKartenfelder: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
               EingeleseneTexturenGrafik.FeldeffekteAccess (FeldeffekteSchleifenwert) := null;
         end case;
         
      end loop FeldeffekteSchleife;
      
      Close (File => DateiKartenfelder);
      
   end EinlesenKartenfelder;
   
   
   
   procedure EinlesenKartenflüsse
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenfluss & VerzeichnisKonstanten.NullDatei)
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenKartenflüsse: Es fehlt: "
                                        & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenfluss & VerzeichnisKonstanten.NullDatei));
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiKartenflüsse,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenfluss & VerzeichnisKonstanten.NullDatei,
                  Form => "WCEM=8");
      end case;
      
      TexturenSchleife:
      for TexturSchleifenwert in EingeleseneTexturenGrafik.KartenflussAccessArray'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiKartenflüsse,
                                                           AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenKartenflüsse: Fehlende Zeilen: "
                                           & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenfluss & VerzeichnisKonstanten.NullDatei) & ", aktuelle Zeile: " & AktuelleZeile'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenKartenflüsse: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
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
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenKartenressourcen: Es fehlt: "
                                        & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenressourcen & VerzeichnisKonstanten.NullDatei));
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiKartenressourcen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenressourcen & VerzeichnisKonstanten.NullDatei,
                  Form => "WCEM=8");
      end case;
      
      TexturenSchleife:
      for TexturSchleifenwert in EingeleseneTexturenGrafik.KartenressourcenAccessArray'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiKartenressourcen,
                                                           AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenKartenressourcen: Fehlende Zeilen: "
                                           & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenressourcen & VerzeichnisKonstanten.NullDatei) & ", aktuelle Zeile: " & AktuelleZeile'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenKartenressourcen: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
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
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenVerbesserungen: Es fehlt: "
                                        & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenverbesserungen & VerzeichnisKonstanten.NullDatei));
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiVerbesserungen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenverbesserungen & VerzeichnisKonstanten.NullDatei,
                  Form => "WCEM=8");
      end case;
      
      TexturenSchleife:
      for TexturSchleifenwert in EingeleseneTexturenGrafik.VerbesserungenAccessArray'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiVerbesserungen,
                                                           AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenVerbesserungen: Fehlende Zeilen: "
                                           & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenverbesserungen & VerzeichnisKonstanten.NullDatei) & ", aktuelle Zeile: "
                                           & AktuelleZeile'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenVerbesserungen: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
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
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenWege: Es fehlt: "
                                        & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenwege & VerzeichnisKonstanten.NullDatei));
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiWege,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenwege & VerzeichnisKonstanten.NullDatei,
                  Form => "WCEM=8");
      end case;
      
      TexturenSchleife:
      for TexturSchleifenwert in EingeleseneTexturenGrafik.WegeAccessArray'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiWege,
                                                           AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenWege: Fehlende Zeilen: "
                                           & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenwege & VerzeichnisKonstanten.NullDatei) & ", aktuelle Zeile: " & AktuelleZeile'Wide_Wide_Image);
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
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenWege: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
               EingeleseneTexturenGrafik.WegeAccess (TexturSchleifenwert) := null;
         end case;
         
      end loop TexturenSchleife;
      
      Close (File => DateiWege);
      
   end EinlesenWege;
   
   
   
   procedure EinlesenSpezies
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Spezies & VerzeichnisKonstanten.NullDatei)
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenSpezies: Es fehlt: "
                                        & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Spezies & VerzeichnisKonstanten.NullDatei));
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiSpezies,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Spezies & VerzeichnisKonstanten.NullDatei,
                  Form => "WCEM=8");
      end case;
      
      SpeziesschleifeSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop
         EinzelpfadeEinlesenSchleife:
         for EinzelpfadeEinlesenSchleifenwert in SpeziesverzeichnisseArray'Range loop
         
            case
              EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiSpezies,
                                                              AktuelleZeileExtern => AktuelleZeile)
            is
               when True =>
                  Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenSpezies: Fehlende Zeilen: "
                                              & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Spezies & VerzeichnisKonstanten.NullDatei) & ", aktuelle Zeile: " & AktuelleZeile'Wide_Wide_Image);
                  exit SpeziesschleifeSchleife;
               
               when False =>
                  Speziesverzeichnisse (EinzelpfadeEinlesenSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiSpezies));
                  AktuelleZeile := AktuelleZeile + 1;
            end case;
         
         end loop EinzelpfadeEinlesenSchleife;
         
         EinlesenSpezieshintergrund (DateipfadExtern => To_Wide_Wide_String (Source => Speziesverzeichnisse (1)),
                                     SpeziesExtern   => SpeziesSchleifenwert);
         
         EinlesenEinheiten (DateipfadExtern => To_Wide_Wide_String (Source => Speziesverzeichnisse (2)),
                            SpeziesExtern   => SpeziesSchleifenwert);
         
         EinlesenGebäude (DateipfadExtern => To_Wide_Wide_String (Source => Speziesverzeichnisse (3)),
                           SpeziesExtern   => SpeziesSchleifenwert);
         
      end loop SpeziesschleifeSchleife;
      
      Close (File => DateiSpezies);
      
   end EinlesenSpezies;
   
   
   
   procedure EinlesenSpezieshintergrund
     (DateipfadExtern : in Wide_Wide_String;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      case
        Exists (Name => Encode (Item => DateipfadExtern))
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenSpezieshintergrund: Es fehlt: " & DateipfadExtern);
            return;
            
         when True =>
            ZeileSpezieshintergrund := 1;
            
            Open (File => DateiSpezieshintergründe,
                  Mode => In_File,
                  Name => Encode (Item => DateipfadExtern),
                  Form => "WCEM=8");
      end case;
      
      TexturenSchleife:
      for TexturSchleifenwert in EingeleseneTexturenGrafik.SpezieshintergrundAccessArray'Range (2) loop
            
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiSpezieshintergründe,
                                                           AktuelleZeileExtern => ZeileSpezieshintergrund)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenSpezieshintergrund: Fehlende Zeilen: " & DateipfadExtern & ", aktuelle Zeile: " & ZeileSpezieshintergrund'Wide_Wide_Image);
               exit TexturenSchleife;
               
            when False =>
               Verzeichnisname := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiSpezieshintergründe));
               ZeileSpezieshintergrund := ZeileSpezieshintergrund + 1;
         end case;
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)))
         is
            when True =>
               EingeleseneTexturenGrafik.SpezieshintergrundAccess (SpeziesExtern, TexturSchleifenwert)
                 := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)));
                  
            when False =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenEinheiten: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
               EingeleseneTexturenGrafik.SpezieshintergrundAccess (SpeziesExtern, TexturSchleifenwert) := null;
         end case;
                     
      end loop TexturenSchleife;
      
      Close (File => DateiSpezieshintergründe);
      
   end EinlesenSpezieshintergrund;
   
   
   
   procedure EinlesenEinheiten
     (DateipfadExtern : in Wide_Wide_String;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      case
        Exists (Name => Encode (Item => DateipfadExtern))
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenEinheiten: Es fehlt: " & DateipfadExtern);
            return;
            
         when True =>
            ZeileEinheiten := 1;
            
            Open (File => DateiEinheiten,
                  Mode => In_File,
                  Name => Encode (Item => DateipfadExtern),
                  Form => "WCEM=8");
      end case;
      
      TexturenSchleife:
      for TexturSchleifenwert in EingeleseneTexturenGrafik.EinheitenAccesArray'Range (2) loop
            
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiEinheiten,
                                                           AktuelleZeileExtern => ZeileEinheiten)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenEinheiten: Fehlende Zeilen: " & DateipfadExtern & ", aktuelle Zeile: " & ZeileEinheiten'Wide_Wide_Image);
               exit TexturenSchleife;
               
            when False =>
               Verzeichnisname := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiEinheiten));
               ZeileEinheiten := ZeileEinheiten + 1;
         end case;
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)))
         is
            when True =>
               EingeleseneTexturenGrafik.EinheitenAccess (SpeziesExtern, TexturSchleifenwert)
                 := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)));
                  
            when False =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenEinheiten: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
               EingeleseneTexturenGrafik.EinheitenAccess (SpeziesExtern, TexturSchleifenwert) := null;
         end case;
                     
      end loop TexturenSchleife;
      
      Close (File => DateiEinheiten);
      
   end EinlesenEinheiten;
   
   
   
   procedure EinlesenGebäude
     (DateipfadExtern : in Wide_Wide_String;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      case
        Exists (Name => Encode (Item => DateipfadExtern))
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenGebäude: Es fehlt: " & DateipfadExtern);
            return;
            
         when True =>
            ZeileGebäude := 1;
            
            Open (File => DateiGebäude,
                  Mode => In_File,
                  Name => Encode (Item => DateipfadExtern),
                  Form => "WCEM=8");
      end case;
      
      TexturenSchleife:
      for TexturSchleifenwert in EingeleseneTexturenGrafik.GebäudeAccessArray'Range (2) loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiGebäude,
                                                           AktuelleZeileExtern => ZeileGebäude)
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenGebäude: Fehlende Zeilen: " & DateipfadExtern & ", aktuelle Zeile: " & ZeileGebäude'Wide_Wide_Image);
               exit TexturenSchleife;
               
            when False =>
               Verzeichnisname := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiGebäude));
               ZeileGebäude := ZeileGebäude + 1;
         end case;
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)))
         is
            when True =>
               EingeleseneTexturenGrafik.GebäudeAccess (SpeziesExtern, TexturSchleifenwert)
                 := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)));
                  
            when False =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenGebäude: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
               EingeleseneTexturenGrafik.GebäudeAccess (SpeziesExtern, TexturSchleifenwert) := null;
         end case;
                  
      end loop TexturenSchleife;
      
      Close (File => DateiGebäude);
      
   end EinlesenGebäude;
   
end EinlesenTexturenLogik;
