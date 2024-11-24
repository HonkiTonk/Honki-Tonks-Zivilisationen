with Sf.Graphics.Texture;

with DateizugriffssystemHTB5;
with UmwandlungssystemHTB3;
with MeldungssystemHTB1;

with VerzeichnisKonstanten;
with TextKonstanten;
with EingeleseneTexturenGrafik;
with TextArrays;

with LeseOptionen;

with EinlesenAllgemeinesLogik;
with VerzeichnisDateinamenTests;
with TexturenfelderBerechnenGrafik;

-- Unter Windows funktionieren UTF8 Namen bei den Texturdateien nicht, das beim Benennen der Texturen berücksichtigen.
-- Eventuell kann auch einfach die SFML hier kein UTF8.
package body EinlesenTexturenLogik is
   
   procedure EinlesenTexturen
   is begin
      
      case
        -- Bie Linux wird hier Leer Übergeben weil ja nur das Nullverzeichnis "/0" geprüft werden muss und nicht dder ganze Verzeichnisname.
        VerzeichnisDateinamenTests.StandardeinleseprüfungNeu (LinuxTextExtern   => TextKonstanten.LeerString,
                                                               WindowsTextExtern => (VerzeichnisKonstanten.Grafik & To_Wide_Wide_String (Source => LeseOptionen.Texturen) & VerzeichnisKonstanten.NullDateiWideWide))
      is
         when False =>
            return;
            
         when True =>
            EinzulesendeZeile := 1;
            AktuelleZeile := 1;
            
            DateizugriffssystemHTB5.ÖffnenText (DateiartExtern => DateiTexturen,
                                                 NameExtern     => UmwandlungssystemHTB3.Encode (TextExtern => VerzeichnisKonstanten.Grafik & To_Wide_Wide_String (Source => LeseOptionen.Texturen)
                                                                                                 & VerzeichnisKonstanten.NullDateiWideWide));
      end case;
      
      TexturenSchleife:
      loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiTexturen,
                                                            AktuelleZeileExtern => EinzulesendeZeile,
                                                            DateinameExtern     => "EinlesenTexturenLogik.EinlesenTexturen")
         is
            when True =>
               MeldungssystemHTB1.Logik (MeldungExtern => "EinlesenTexturenLogik.EinlesenTexturen: Einzulesende Zeile:" & EinzulesendeZeile'Wide_Wide_Image & ", aktuelle Zeile:" & AktuelleZeile'Wide_Wide_Image);
               exit TexturenSchleife;
               
            when False =>
               Dateiname := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiTexturen,
                                                                             AktuelleZeileExtern => EinzulesendeZeile,
                                                                             DateinameExtern     => "EinlesenTexturenLogik.EinlesenTexturen");
               GesamterPfad := VerzeichnisKonstanten.Grafik & LeseOptionen.Texturen & "/" & Dateiname;
               EinzulesendeZeile := EinzulesendeZeile + 1;
         end case;
         
         case
           To_Wide_Wide_String (Source => Dateiname) (1)
         is
            when TextKonstanten.TrennzeichenTextdateien =>
               null;
               
            when others =>
               if
                 False = VerzeichnisDateinamenTests.StandardeinleseprüfungNeu (LinuxTextExtern   => To_Wide_Wide_String (Source => Dateiname),
                                                                                WindowsTextExtern => To_Wide_Wide_String (Source => GesamterPfad))
               then
                  MeldungssystemHTB1.Logik (MeldungExtern => "EinlesenTexturenLogik.EinlesenTexturen: Datei oder Pfad existiert nicht");
               
               elsif
                 AktuelleZeile = Basisgrund
               then
                  Sf.Graphics.Texture.destroy (texture => EingeleseneTexturenGrafik.BasisgrundAccess);
                  EingeleseneTexturenGrafik.BasisgrundAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungssystemHTB3.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Zusatzgrund
               then
                  Sf.Graphics.Texture.destroy (texture => EingeleseneTexturenGrafik.ZusatzgrundAccess);
                  EingeleseneTexturenGrafik.ZusatzgrundAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungssystemHTB3.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Flüsse
               then
                  Sf.Graphics.Texture.destroy (texture => EingeleseneTexturenGrafik.FlussAccess);
                  EingeleseneTexturenGrafik.FlussAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungssystemHTB3.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Ressourcen
               then
                  Sf.Graphics.Texture.destroy (texture => EingeleseneTexturenGrafik.RessourcenAccess);
                  EingeleseneTexturenGrafik.RessourcenAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungssystemHTB3.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Verbesserungen
               then
                  Sf.Graphics.Texture.destroy (texture => EingeleseneTexturenGrafik.VerbesserungenAccess);
                  EingeleseneTexturenGrafik.VerbesserungenAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungssystemHTB3.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Wege
               then
                  Sf.Graphics.Texture.destroy (texture => EingeleseneTexturenGrafik.WegeAccess);
                  EingeleseneTexturenGrafik.WegeAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungssystemHTB3.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Feldeffekte
               then
                  Sf.Graphics.Texture.destroy (texture => EingeleseneTexturenGrafik.FeldeffekteAccess);
                  EingeleseneTexturenGrafik.FeldeffekteAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungssystemHTB3.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Einheitenbefehle
               then
                  Sf.Graphics.Texture.destroy (texture => EingeleseneTexturenGrafik.EinheitenbefehleAccess);
                  EingeleseneTexturenGrafik.EinheitenbefehleAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungssystemHTB3.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Kartenbefehle
               then
                  Sf.Graphics.Texture.destroy (texture => EingeleseneTexturenGrafik.KartenbefehleAccess);
                  EingeleseneTexturenGrafik.KartenbefehleAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungssystemHTB3.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = RoterKnopf
               then
                  Sf.Graphics.Texture.destroy (texture => EingeleseneTexturenGrafik.RoterKnopfAccess);
                  EingeleseneTexturenGrafik.RoterKnopfAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungssystemHTB3.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Intro
               then
                  Sf.Graphics.Texture.destroy (texture => EingeleseneTexturenGrafik.IntroAccess);
                  EingeleseneTexturenGrafik.IntroAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungssystemHTB3.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Kartenformen
               then
                  Sf.Graphics.Texture.destroy (texture => EingeleseneTexturenGrafik.KartenformenAccess);
                  EingeleseneTexturenGrafik.KartenformenAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungssystemHTB3.EncodeUnbounded (TextExtern => GesamterPfad));
                                    
               elsif
                 AktuelleZeile = Allgemeines
               then
                  Sf.Graphics.Texture.destroy (texture => EingeleseneTexturenGrafik.AllgemeinesAccess);
                  EingeleseneTexturenGrafik.AllgemeinesAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungssystemHTB3.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = PZBEnde
               then
                  Sf.Graphics.Texture.destroy (texture => EingeleseneTexturenGrafik.PZBEndeAccess);
                  EingeleseneTexturenGrafik.PZBEndeAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungssystemHTB3.EncodeUnbounded (TextExtern => GesamterPfad));
                                    
               elsif
                 AktuelleZeile in HintergründeAnfang .. HintergründeEnde
               then
                  Sf.Graphics.Texture.destroy (texture => EingeleseneTexturenGrafik.AllgemeinesSpezienAccess (SpeziesDatentypen.Spezies_Vorhanden_Enum'Val (AktuelleZeile - HintergründeAnfang + 1)));
                  EingeleseneTexturenGrafik.AllgemeinesSpezienAccess (SpeziesDatentypen.Spezies_Vorhanden_Enum'Val (AktuelleZeile - HintergründeAnfang + 1))
                    := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungssystemHTB3.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile in EinheitenAnfang .. EinheitenEnde
               then
                  Sf.Graphics.Texture.destroy (texture => EingeleseneTexturenGrafik.EinheitenAccess (SpeziesDatentypen.Spezies_Vorhanden_Enum'Val (AktuelleZeile - EinheitenAnfang + 1)));
                  EingeleseneTexturenGrafik.EinheitenAccess (SpeziesDatentypen.Spezies_Vorhanden_Enum'Val (AktuelleZeile - EinheitenAnfang + 1))
                    := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungssystemHTB3.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile in GebäudeAnfang .. GebäudeEnde
               then
                  Sf.Graphics.Texture.destroy (texture => EingeleseneTexturenGrafik.GebäudeAccess (SpeziesDatentypen.Spezies_Vorhanden_Enum'Val (AktuelleZeile - GebäudeAnfang + 1)));
                  EingeleseneTexturenGrafik.GebäudeAccess (SpeziesDatentypen.Spezies_Vorhanden_Enum'Val (AktuelleZeile - GebäudeAnfang + 1))
                    := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungssystemHTB3.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               else
                  MeldungssystemHTB1.Logik (MeldungExtern => "EinlesenTexturenLogik.EinlesenTexturen: Außerhalb des Einlesebereichs");
                  exit TexturenSchleife;
               end if;
               
               if
                 AktuelleZeile < GebäudeEnde
               then
                  AktuelleZeile := AktuelleZeile + 1;
                     
               else
                  TexturenfelderBerechnenGrafik.TexturenfelderBerechnen;
                  exit TexturenSchleife;
               end if;
         end case;
                  
      end loop TexturenSchleife;
      
      Close (File => DateiTexturen);
      
   end EinlesenTexturen;
   
   
   
   function Texturenauswahl
     return Boolean
   is begin
      
      TextArrays.SprachenTexturenEinlesen := (others => TextKonstanten.LeerUnboundedString);
            
      Start_Search (Search    => Suche,
                    Directory => VerzeichnisKonstanten.GrafikOhneStrich,
                    Pattern   => "",
                    Filter    => (Directory => True,
                                  others    => False));
      
      VerzeichnisAußenSchleife:
      while More_Entries (Search => Suche) = True loop
      
         Get_Next_Entry (Search          => Suche,
                         Directory_Entry => Verzeichnis);
         
         if
           False = VerzeichnisDateinamenTests.GültigeZeichenlänge (LinuxTextExtern   => TextKonstanten.LeerUnboundedString,
                                                                     WindowsTextExtern => UmwandlungssystemHTB3.DecodeUnbounded (TextExtern => VerzeichnisKonstanten.GrafikEinfach
                                                                                                                                 & Simple_Name (Directory_Entry => Verzeichnis)
                                                                                                                                 & VerzeichnisKonstanten.NullDatei))
         then
            null;
            
         elsif
           -- Kann das nicht einfach raus wenn irgendwann einmal Wide_Wide_Directories da ist? äöü
           -- Das ist je nur vorhandene Ordner durchgehen und man kann ja keine Dateien/Ordner anlegen die das Dateisystem nicht unterstützen. äöü
           VerzeichnisDateinamenTests.GültigerNamen (NameExtern => UmwandlungssystemHTB3.Decode (TextExtern => Simple_Name (Directory_Entry => Verzeichnis))) = False
         then
            null;
             
         elsif
           -- Das ausgeklammerte unten drunter funktioniert unter Windwos nicht, wenn man Sonderzeichen verwendet.
           -- EinlesenAllgemeinesLogik.LeeresVerzeichnis (VerzeichnisExtern => VerzeichnisKonstanten.SprachenStrich & Simple_Name (Directory_Entry => Verzeichnis)) = True
           Exists (Name => VerzeichnisKonstanten.GrafikEinfach & Simple_Name (Directory_Entry => Verzeichnis) & VerzeichnisKonstanten.NullDatei) = False
         then
            null;
            
         else
            Verzeichnisname := To_Unbounded_Wide_Wide_String (Source => UmwandlungssystemHTB3.Decode (TextExtern => Simple_Name (Directory_Entry => Verzeichnis)));
            
            VerzeichnisInnenSchleife:
            for TexturenSchleifenwert in TextArrays.SprachenTexturenEinlesen'Range loop
               if
                 TextArrays.SprachenTexturenEinlesen (TexturenSchleifenwert) /= TextKonstanten.LeerUnboundedString
               then
                  null;
            
               else
                  TextArrays.SprachenTexturenEinlesen (TexturenSchleifenwert) := Verzeichnisname;
                  exit VerzeichnisInnenSchleife;
               end if;
         
            end loop VerzeichnisInnenSchleife;
         end if;

      end loop VerzeichnisAußenSchleife;
      
      End_Search (Search => Suche);
      
      if
        TextArrays.SprachenTexturenEinlesen (1) = TextKonstanten.LeerUnboundedString
      then
         return False;
         
      else
         TexturenSortieren;
         return True;
      end if;
      
   end Texturenauswahl;
   
   
   
   procedure TexturenSortieren
   is begin
            
      SortierSchleife:
      for PositionSchleifenwert in TextArrays.SprachenTexturenEinlesen'First + 1 .. TextArrays.SprachenTexturenEinlesen'Last loop
         
         if
           TextArrays.SprachenTexturenEinlesen (PositionSchleifenwert) = TextKonstanten.LeerUnboundedString
         then
            exit SortierSchleife;
            
         else
            SchleifenAbzug := 0;
            PrüfSchleife:
            loop
               
               if
                 PositionSchleifenwert - SchleifenAbzug > TextArrays.SprachenTexturenEinlesen'First
                 and then
                   TextArrays.SprachenTexturenEinlesen (PositionSchleifenwert) < TextArrays.SprachenTexturenEinlesen (PositionSchleifenwert - SchleifenAbzug - 1)
               then
                  SchleifenAbzug := SchleifenAbzug + 1;
                  
               else
                  if
                    PositionSchleifenwert = SchleifenAbzug
                  then
                     SchleifenAbzug := SchleifenAbzug - 1;
                     
                  else
                     null;
                  end if;
                  
                  VerschiebungSchleife:
                  while SchleifenAbzug > 0 loop
                     
                     Zwischenspeicher := TextArrays.SprachenTexturenEinlesen (PositionSchleifenwert);
                     TextArrays.SprachenTexturenEinlesen (PositionSchleifenwert) := TextArrays.SprachenTexturenEinlesen (PositionSchleifenwert - SchleifenAbzug);
                     TextArrays.SprachenTexturenEinlesen (PositionSchleifenwert - SchleifenAbzug) := Zwischenspeicher;
                     SchleifenAbzug := SchleifenAbzug - 1;
                     
                  end loop VerschiebungSchleife;
                  
                  exit PrüfSchleife;
               end if;
               
            end loop PrüfSchleife;
         end if;
         
      end loop SortierSchleife;
      
   end TexturenSortieren;
   
end EinlesenTexturenLogik;
