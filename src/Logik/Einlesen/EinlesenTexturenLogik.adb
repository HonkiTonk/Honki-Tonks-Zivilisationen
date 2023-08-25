with Ada.Directories; use Ada.Directories;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with VerzeichnisKonstanten;
with EingeleseneTexturenGrafik;

with EinlesenAllgemeinesLogik;
with Fehlermeldungssystem;

package body EinlesenTexturenLogik is
   
   procedure EinlesenTexturen
   is begin
      
      System;
      Hintergrund;
      Kartenfelder;
      Kartenflüsse;
      Kartenressourcen;
      Verbesserungen;
      Wege;
      Spezies;
      
   end EinlesenTexturen;
   
   
   
   procedure System
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.System & VerzeichnisKonstanten.NullDatei)
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.System: Es fehlt: " & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.System & VerzeichnisKonstanten.NullDatei));
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
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiSystem,
                                                            AktuelleZeileExtern => AktuelleZeile,
                                                            DateinameExtern     => "EinlesenTexturenLogik.System")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.System: Fehlende Zeilen: "
                                           & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.System & VerzeichnisKonstanten.NullDatei) & ", aktuelle Zeile: " & AktuelleZeile'Wide_Wide_Image);
               exit TexturenSchleife;
               
            when False =>
               Verzeichnisname := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiSystem,
                                                                                   AktuelleZeileExtern => AktuelleZeile,
                                                                                   DateinameExtern     => "EinlesenTexturenLogik.System");
               AktuelleZeile := AktuelleZeile + 1;
         end case;
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)))
         is
            when True =>
               EingeleseneTexturenGrafik.SystemAccess (TexturSchleifenwert) := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)));
                  
            when False =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.System: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
               EingeleseneTexturenGrafik.SystemAccess (TexturSchleifenwert) := null;
         end case;
                  
      end loop TexturenSchleife;
      
      -- Warum is das hier ein zweites Mal? äöü
      case
        EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiSystem,
                                                         AktuelleZeileExtern => AktuelleZeile,
                                                         DateinameExtern     => "EinlesenTexturenLogik.System")
      is
         when True =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.System: Fehlende Zeilen: "
                                        & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.System & VerzeichnisKonstanten.NullDatei) & ", aktuelle Zeile: " & AktuelleZeile'Wide_Wide_Image);
            Close (File => DateiSystem);
            return;
               
         when False =>
            Verzeichnisname := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiSystem,
                                                                                AktuelleZeileExtern => AktuelleZeile,
                                                                                DateinameExtern     => "EinlesenTexturenLogik.System");
      end case;
         
      case
        Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)))
      is
         when True =>
            EingeleseneTexturenGrafik.BilderAccess (1) := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)));
            
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.System: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
            EingeleseneTexturenGrafik.BilderAccess (1) := null;
      end case;
      
      Close (File => DateiSystem);
      
   end System;
   
   
   
   procedure Hintergrund
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Hintergrund & VerzeichnisKonstanten.NullDatei)
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Hintergrund: Es fehlt: "
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
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiHintergrund,
                                                            AktuelleZeileExtern => AktuelleZeile,
                                                            DateinameExtern     => "EinlesenTexturenLogik.Hintergrund")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Hintergrund: Fehlende Zeilen: "
                                           & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Hintergrund & VerzeichnisKonstanten.NullDatei) & ", aktuelle Zeile: " & AktuelleZeile'Wide_Wide_Image);
               exit TexturenSchleife;
               
            when False =>
               Verzeichnisname := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiHintergrund,
                                                                                   AktuelleZeileExtern => AktuelleZeile,
                                                                                   DateinameExtern     => "EinlesenTexturenLogik.Hintergrund");
               AktuelleZeile := AktuelleZeile + 1;
         end case;
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)))
         is
            when True =>
               EingeleseneTexturenGrafik.HintergrundAccess (TexturSchleifenwert) := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)));
                  
            when False =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Hintergrund: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
               EingeleseneTexturenGrafik.HintergrundAccess (TexturSchleifenwert) := null;
         end case;
                  
      end loop TexturenSchleife;
      
      Close (File => DateiHintergrund);
      
   end Hintergrund;
   
   
   
   procedure Kartenfelder
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Basisgrund & VerzeichnisKonstanten.NullDatei)
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Kartenfelder: Es fehlt: "
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
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiKartenfelder,
                                                            AktuelleZeileExtern => AktuelleZeile,
                                                            DateinameExtern     => "EinlesenTexturenLogik.Kartenfelder")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Kartenfelder: Fehlende Zeilen: "
                                           & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Basisgrund & VerzeichnisKonstanten.NullDatei) & ", aktuelle Zeile: " & AktuelleZeile'Wide_Wide_Image);
               exit BasisgrundSchleife;
               
            when False =>
               Verzeichnisname := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiKartenfelder,
                                                                                   AktuelleZeileExtern => AktuelleZeile,
                                                                                   DateinameExtern     => "EinlesenTexturenLogik.Kartenfelder");
               AktuelleZeile := AktuelleZeile + 1;
         end case;
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)))
         is
            when True =>
               EingeleseneTexturenGrafik.BasisgrundAccess (BasisgrundSchleifenwert) := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)));
                  
            when False =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Kartenfelder: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
               EingeleseneTexturenGrafik.BasisgrundAccess (BasisgrundSchleifenwert) := null;
         end case;
         
      end loop BasisgrundSchleife;
      
      Close (File => DateiKartenfelder);
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Zusatzgrund & VerzeichnisKonstanten.NullDatei)
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Kartenfelder: Es fehlt: "
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
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiKartenfelder,
                                                            AktuelleZeileExtern => AktuelleZeile,
                                                            DateinameExtern     => "EinlesenTexturenLogik.Kartenfelder")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Kartenfelder: Fehlende Zeilen: "
                                           & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Zusatzgrund & VerzeichnisKonstanten.NullDatei) & ", aktuelle Zeile: " & AktuelleZeile'Wide_Wide_Image);
               exit ZusatzgrundSchleife;
               
            when False =>
               Verzeichnisname := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiKartenfelder,
                                                                                   AktuelleZeileExtern => AktuelleZeile,
                                                                                   DateinameExtern     => "EinlesenTexturenLogik.Kartenfelder");
               AktuelleZeile := AktuelleZeile + 1;
         end case;
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)))
         is
            when True =>
               EingeleseneTexturenGrafik.ZusatzgrundAccess (ZusatzgrundSchleifenwert) := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)));
                  
            when False =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Kartenfelder: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
               EingeleseneTexturenGrafik.ZusatzgrundAccess (ZusatzgrundSchleifenwert) := null;
         end case;
         
      end loop ZusatzgrundSchleife;
      
      Close (File => DateiKartenfelder);
      
      
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Feldeffekte & VerzeichnisKonstanten.NullDatei)
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Kartenfelder: Es fehlt: "
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
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiKartenfelder,
                                                            AktuelleZeileExtern => AktuelleZeile,
                                                            DateinameExtern     => "EinlesenTexturenLogik.Kartenfelder")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Kartenfelder: Fehlende Zeilen: "
                                           & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Feldeffekte & VerzeichnisKonstanten.NullDatei) & ", aktuelle Zeile: " & AktuelleZeile'Wide_Wide_Image);
               exit FeldeffekteSchleife;
               
            when False =>
               Verzeichnisname := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiKartenfelder,
                                                                                   AktuelleZeileExtern => AktuelleZeile,
                                                                                   DateinameExtern     => "EinlesenTexturenLogik.Kartenfelder");
               AktuelleZeile := AktuelleZeile + 1;
         end case;
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)))
         is
            when True =>
               EingeleseneTexturenGrafik.FeldeffekteAccess (FeldeffekteSchleifenwert) := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)));
               
            when False =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Kartenfelder: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
               EingeleseneTexturenGrafik.FeldeffekteAccess (FeldeffekteSchleifenwert) := null;
         end case;
         
      end loop FeldeffekteSchleife;
      
      Close (File => DateiKartenfelder);
      
   end Kartenfelder;
   
   
   
   procedure Kartenflüsse
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenfluss & VerzeichnisKonstanten.NullDatei)
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Kartenflüsse: Es fehlt: "
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
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiKartenflüsse,
                                                            AktuelleZeileExtern => AktuelleZeile,
                                                            DateinameExtern     => "EinlesenTexturenLogik.Kartenflüsse")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Kartenflüsse: Fehlende Zeilen: "
                                           & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenfluss & VerzeichnisKonstanten.NullDatei) & ", aktuelle Zeile: " & AktuelleZeile'Wide_Wide_Image);
               exit TexturenSchleife;
               
            when False =>
               Verzeichnisname := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiKartenflüsse,
                                                                                   AktuelleZeileExtern => AktuelleZeile,
                                                                                   DateinameExtern     => "EinlesenTexturenLogik.Kartenflüsse");
               AktuelleZeile := AktuelleZeile + 1;
         end case;
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)))
         is
            when True =>
               EingeleseneTexturenGrafik.KartenflussAccess (TexturSchleifenwert) := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)));
                  
            when False =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Kartenflüsse: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
               EingeleseneTexturenGrafik.KartenflussAccess (TexturSchleifenwert) := null;
         end case;
                  
      end loop TexturenSchleife;
      
      Close (File => DateiKartenflüsse);
      
   end Kartenflüsse;
   
   
   
   procedure Kartenressourcen
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenressourcen & VerzeichnisKonstanten.NullDatei)
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Kartenressourcen: Es fehlt: "
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
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiKartenressourcen,
                                                            AktuelleZeileExtern => AktuelleZeile,
                                                            DateinameExtern     => "EinlesenTexturenLogik.Kartenressourcen")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Kartenressourcen: Fehlende Zeilen: "
                                           & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenressourcen & VerzeichnisKonstanten.NullDatei) & ", aktuelle Zeile: " & AktuelleZeile'Wide_Wide_Image);
               exit TexturenSchleife;
               
            when False =>
               Verzeichnisname := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiKartenressourcen,
                                                                                   AktuelleZeileExtern => AktuelleZeile,
                                                                                   DateinameExtern     => "EinlesenTexturenLogik.Kartenressourcen");
               AktuelleZeile := AktuelleZeile + 1;
         end case;
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)))
         is
            when True =>
               EingeleseneTexturenGrafik.KartenressourceAccess (TexturSchleifenwert) := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)));
               
            when False =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Kartenressourcen: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
               EingeleseneTexturenGrafik.KartenressourceAccess (TexturSchleifenwert) := null;
         end case;
         
      end loop TexturenSchleife;
      
      Close (File => DateiKartenressourcen);
      
   end Kartenressourcen;
   
   
   
   procedure Verbesserungen
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenverbesserungen & VerzeichnisKonstanten.NullDatei)
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Verbesserungen: Es fehlt: "
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
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiVerbesserungen,
                                                            AktuelleZeileExtern => AktuelleZeile,
                                                            DateinameExtern     => "EinlesenTexturenLogik.Verbesserungen")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Verbesserungen: Fehlende Zeilen: "
                                           & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenverbesserungen & VerzeichnisKonstanten.NullDatei) & ", aktuelle Zeile: "
                                           & AktuelleZeile'Wide_Wide_Image);
               exit TexturenSchleife;
               
            when False =>
               Verzeichnisname := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiVerbesserungen,
                                                                                   AktuelleZeileExtern => AktuelleZeile,
                                                                                   DateinameExtern     => "EinlesenTexturenLogik.Verbesserungen");
               AktuelleZeile := AktuelleZeile + 1;
         end case;
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)))
         is
            when True =>
               EingeleseneTexturenGrafik.VerbesserungenAccess (TexturSchleifenwert) := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)));
                  
            when False =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Verbesserungen: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
               EingeleseneTexturenGrafik.VerbesserungenAccess (TexturSchleifenwert) := null;
         end case;
                  
      end loop TexturenSchleife;
      
      Close (File => DateiVerbesserungen);
      
   end Verbesserungen;
   
   
   
   procedure Wege
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenwege & VerzeichnisKonstanten.NullDatei)
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Wege: Es fehlt: "
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
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiWege,
                                                            AktuelleZeileExtern => AktuelleZeile,
                                                            DateinameExtern     => "EinlesenTexturenLogik.Wege")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Wege: Fehlende Zeilen: "
                                           & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Kartenwege & VerzeichnisKonstanten.NullDatei) & ", aktuelle Zeile: " & AktuelleZeile'Wide_Wide_Image);
               exit TexturenSchleife;
               
            when False =>
               Verzeichnisname := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiWege,
                                                                                   AktuelleZeileExtern => AktuelleZeile,
                                                                                   DateinameExtern     => "EinlesenTexturenLogik.Wege");
               AktuelleZeile := AktuelleZeile + 1;
         end case;
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)))
         is
            when True =>
               EingeleseneTexturenGrafik.WegeAccess (TexturSchleifenwert) := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)));
               
            when False =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Wege: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
               EingeleseneTexturenGrafik.WegeAccess (TexturSchleifenwert) := null;
         end case;
         
      end loop TexturenSchleife;
                                                               
      Close (File => DateiWege);
      
   end Wege;
   
   
   
   procedure Spezies
   is begin
                                                               
      case
        Exists (Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Spezies & VerzeichnisKonstanten.NullDatei)
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Spezies: Es fehlt: "
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
         for EinzelpfadeEinlesenSchleifenwert in Speziesverzeichnisse'Range loop
         
            case
              EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiSpezies,
                                                               AktuelleZeileExtern => AktuelleZeile,
                                                               DateinameExtern     => "EinlesenTexturenLogik.Spezies")
            is
               when True =>
                  Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Spezies: Fehlende Zeilen: "
                                              & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.Spezies & VerzeichnisKonstanten.NullDatei) & ", aktuelle Zeile: " & AktuelleZeile'Wide_Wide_Image);
                  exit SpeziesschleifeSchleife;
               
               when False =>
                  Speziesverzeichnisse (EinzelpfadeEinlesenSchleifenwert) := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiSpezies,
                                                                                                                              AktuelleZeileExtern => AktuelleZeile,
                                                                                                                              DateinameExtern     => "EinlesenTexturenLogik.Spezies");
                  AktuelleZeile := AktuelleZeile + 1;
            end case;
         
         end loop EinzelpfadeEinlesenSchleife;
         
         Spezieshintergrund (DateipfadExtern => To_Wide_Wide_String (Source => Speziesverzeichnisse (1)),
                             SpeziesExtern   => SpeziesSchleifenwert);
         
         Einheiten (DateipfadExtern => To_Wide_Wide_String (Source => Speziesverzeichnisse (2)),
                    SpeziesExtern   => SpeziesSchleifenwert);
         
         Gebäude (DateipfadExtern => To_Wide_Wide_String (Source => Speziesverzeichnisse (3)),
                   SpeziesExtern   => SpeziesSchleifenwert);
         
      end loop SpeziesschleifeSchleife;
      
      Close (File => DateiSpezies);
      
   end Spezies;
   
   
   
   procedure Spezieshintergrund
     (DateipfadExtern : in Wide_Wide_String;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      case
        Exists (Name => Encode (Item => DateipfadExtern))
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Spezieshintergrund: Es fehlt: " & DateipfadExtern);
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
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiSpezieshintergründe,
                                                            AktuelleZeileExtern => ZeileSpezieshintergrund,
                                                            DateinameExtern     => "EinlesenTexturenLogik.Spezieshintergrund")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Spezieshintergrund: Fehlende Zeilen: " & DateipfadExtern & ", aktuelle Zeile: " & ZeileSpezieshintergrund'Wide_Wide_Image);
               exit TexturenSchleife;
               
            when False =>
               Verzeichnisname := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiSpezieshintergründe,
                                                                                   AktuelleZeileExtern => ZeileSpezieshintergrund,
                                                                                   DateinameExtern     => "EinlesenTexturenLogik.Spezieshintergrund");
               ZeileSpezieshintergrund := ZeileSpezieshintergrund + 1;
         end case;
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)))
         is
            when True =>
               EingeleseneTexturenGrafik.SpezieshintergrundAccess (SpeziesExtern, TexturSchleifenwert)
                 := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)));
                  
            when False =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Einheiten: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
               EingeleseneTexturenGrafik.SpezieshintergrundAccess (SpeziesExtern, TexturSchleifenwert) := null;
         end case;
                     
      end loop TexturenSchleife;
      
      Close (File => DateiSpezieshintergründe);
      
   end Spezieshintergrund;
   
   
   
   procedure Einheiten
     (DateipfadExtern : in Wide_Wide_String;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
                                                               
      case
        Exists (Name => Encode (Item => DateipfadExtern))
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Einheiten: Es fehlt: " & DateipfadExtern);
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
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiEinheiten,
                                                            AktuelleZeileExtern => ZeileEinheiten,
                                                            DateinameExtern     => "EinlesenTexturenLogik.Einheiten")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Einheiten: Fehlende Zeilen: " & DateipfadExtern & ", aktuelle Zeile: " & ZeileEinheiten'Wide_Wide_Image);
               exit TexturenSchleife;
               
            when False =>
               Verzeichnisname := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiEinheiten,
                                                                                   AktuelleZeileExtern => ZeileEinheiten,
                                                                                   DateinameExtern     => "EinlesenTexturenLogik.Einheiten");
               ZeileEinheiten := ZeileEinheiten + 1;
         end case;
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)))
         is
            when True =>
               EingeleseneTexturenGrafik.EinheitenAccess (SpeziesExtern, TexturSchleifenwert)
                 := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)));
                
            when False =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Einheiten: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
               EingeleseneTexturenGrafik.EinheitenAccess (SpeziesExtern, TexturSchleifenwert) := null;
         end case;
                     
      end loop TexturenSchleife;
      
      Close (File => DateiEinheiten);
      
   end Einheiten;
   
   
   
   procedure Gebäude
     (DateipfadExtern : in Wide_Wide_String;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      case
        Exists (Name => Encode (Item => DateipfadExtern))
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Gebäude: Es fehlt: " & DateipfadExtern);
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
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiGebäude,
                                                            AktuelleZeileExtern => ZeileGebäude,
                                                            DateinameExtern     => "EinlesenTexturenLogik.Gebäude")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Gebäude: Fehlende Zeilen: " & DateipfadExtern & ", aktuelle Zeile: " & ZeileGebäude'Wide_Wide_Image);
               exit TexturenSchleife;
               
            when False =>
               Verzeichnisname := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiGebäude,
                                                                                   AktuelleZeileExtern => ZeileGebäude,
                                                                                   DateinameExtern     => "EinlesenTexturenLogik.Gebäude");
               ZeileGebäude := ZeileGebäude + 1;
         end case;
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)))
         is
            when True =>
               EingeleseneTexturenGrafik.GebäudeAccess (SpeziesExtern, TexturSchleifenwert)
                 := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => Encode (Item => To_Wide_Wide_String (Source => Verzeichnisname)));
                
            when False =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Gebäude: Es fehlt: " & To_Wide_Wide_String (Source => Verzeichnisname));
               EingeleseneTexturenGrafik.GebäudeAccess (SpeziesExtern, TexturSchleifenwert) := null;
         end case;
                  
      end loop TexturenSchleife;
      
      Close (File => DateiGebäude);
      
   end Gebäude;
   
end EinlesenTexturenLogik;
