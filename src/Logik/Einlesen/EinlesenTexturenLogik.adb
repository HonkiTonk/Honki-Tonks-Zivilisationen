with Ada.Directories; use Ada.Directories;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with VerzeichnisKonstanten;
with TextKonstanten;
with KartengrundDatentypen;
with KartenverbesserungDatentypen;
with KartenextraDatentypen;
with BefehleDatentypen;
with GrafikDatentypen;

with EinlesenAllgemeinesLogik;
with Fehlermeldungssystem;

package body EinlesenTexturenLogik is
   
   procedure EinlesenTexturen
   is begin
      
      Karte;
      
      Spezies;
      
   end EinlesenTexturen;
   
   
   
   procedure Karte
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.NullDatei)
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Karte: Es fehlt: " & Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.NullDatei));
            return;
            
         when True =>
            EinzulesendeZeile := 1;
            AktuelleZeile := 1;
            
            Open (File => DateiKarte,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.NullDatei,
                  Form => "WCEM=8");
      end case;
      
      KarteSchleife:
      loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiKarte,
                                                            AktuelleZeileExtern => EinzulesendeZeile,
                                                            DateinameExtern     => "EinlesenTexturenLogik.Karte")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Karte: Einzulesende Zeile:" & EinzulesendeZeile'Wide_Wide_Image & ", aktuelle Zeile:" & AktuelleZeile'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiKarte,
                                                                                    AktuelleZeileExtern => EinzulesendeZeile,
                                                                                    DateinameExtern     => "EinlesenTexturenLogik.Karte");
               EinzulesendeZeile := EinzulesendeZeile + 1;
         end case;
         
         case
           To_Wide_Wide_String (Source => Zwischenspeicher) (1)
         is
            when TextKonstanten.TrennzeichenTextdateien =>
               null;
               
            when others =>
               if
                 Exists (Name => VerzeichnisKonstanten.Grafik & "/" & Encode (Item => To_Wide_Wide_String (Source => Zwischenspeicher))) = False
               then
                  Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Karte: Datei oder Pfad existiert nicht");
            
               elsif
                 AktuelleZeile <= Basisgrund
               then
                  EingeleseneTexturenGrafik.BasisgrundAccess (KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Val (AktuelleZeile))
                    := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => VerzeichnisKonstanten.Grafik & "/" & Encode (Item => To_Wide_Wide_String (Source => Zwischenspeicher)));
                  
               elsif
                 AktuelleZeile in Basisgrund + 1 .. Zusatzgrund
               then
                  EingeleseneTexturenGrafik.ZusatzgrundAccess (KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Val (AktuelleZeile - Basisgrund))
                    := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => VerzeichnisKonstanten.Grafik & "/" & Encode (Item => To_Wide_Wide_String (Source => Zwischenspeicher)));
                  
               elsif
                 AktuelleZeile in Zusatzgrund + 1 .. Flüsse
               then
                  EingeleseneTexturenGrafik.KartenflussAccess (KartenextraDatentypen.Fluss_Vorhanden_Enum'Val (AktuelleZeile - Zusatzgrund))
                    := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => VerzeichnisKonstanten.Grafik & "/" & Encode (Item => To_Wide_Wide_String (Source => Zwischenspeicher)));
                  
               elsif
                 AktuelleZeile in Flüsse + 1 .. Ressourcen
               then
                  EingeleseneTexturenGrafik.KartenressourceAccess (KartenextraDatentypen.Ressourcen_Vorhanden_Enum'Val (AktuelleZeile - Flüsse))
                    := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => VerzeichnisKonstanten.Grafik & "/" & Encode (Item => To_Wide_Wide_String (Source => Zwischenspeicher)));
                  
               elsif
                 AktuelleZeile in Ressourcen + 1 .. Feldeffekte
               then
                  EingeleseneTexturenGrafik.FeldeffekteAccess (KartenextraDatentypen.Effekt_Vorhanden_Enum'Val (AktuelleZeile - Ressourcen))
                    := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => VerzeichnisKonstanten.Grafik & "/" & Encode (Item => To_Wide_Wide_String (Source => Zwischenspeicher)));
                  
               elsif
                 AktuelleZeile in Feldeffekte + 1 .. Verbesserungen
               then
                  EingeleseneTexturenGrafik.VerbesserungenAccess (KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum'Val (AktuelleZeile - Feldeffekte))
                    := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => VerzeichnisKonstanten.Grafik & "/" & Encode (Item => To_Wide_Wide_String (Source => Zwischenspeicher)));
                  
               elsif
                 AktuelleZeile in Verbesserungen + 1 .. Wege
               then
                  EingeleseneTexturenGrafik.WegeAccess (KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Val (AktuelleZeile - Verbesserungen))
                    := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => VerzeichnisKonstanten.Grafik & "/" & Encode (Item => To_Wide_Wide_String (Source => Zwischenspeicher)));
                  
               elsif
                 AktuelleZeile in Wege + 1 .. System
               then
                  EingeleseneTexturenGrafik.SystemAccess (BefehleDatentypen.Befehlsknöpfe_Enum'Val (AktuelleZeile - Wege - 1))
                    := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => VerzeichnisKonstanten.Grafik & "/" & Encode (Item => To_Wide_Wide_String (Source => Zwischenspeicher)));
                  
               elsif
                 AktuelleZeile in System + 1 .. Hintergrund
               then
                  EingeleseneTexturenGrafik.HintergrundAccess (GrafikDatentypen.Hintergrund_Enum'Val (AktuelleZeile - System - 1))
                    := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => VerzeichnisKonstanten.Grafik & "/" & Encode (Item => To_Wide_Wide_String (Source => Zwischenspeicher)));
                  
               else
                  Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Karte: Außerhalb des Einlesebereichs");
                  return;
               end if;
               
               if
                 AktuelleZeile < Hintergrund
               then
                  AktuelleZeile := AktuelleZeile + 1;
                     
               else
                  return;
               end if;
         end case;
         
      end loop KarteSchleife;
      
   end Karte;
   
   
   
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
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
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
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
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
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
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
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
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
