with Sf.Graphics.Texture;

with DateizugriffssystemHTSEB;
with UmwandlungssystemHTSEB;
with MeldungssystemHTSEB;
with DateisystemtestsHTSEB;

with VerzeichnisKonstanten;
with TextKonstanten;
with EingeleseneTexturenGrafik;

with LeseOptionen;

with EinlesenAllgemeinesLogik;
with TexturenfelderBerechnenGrafik;

-- Unter Windows funktionieren UTF8 Namen bei den Texturdateien nicht, das beim Benennen der Texturen berücksichtigen.
-- Eventuell kann auch einfach die SFML hier kein UTF8.
package body EinlesenTexturenLogik is
   
   procedure EinlesenTexturen
   is begin
      
      case
        -- Bie Linux wird hier Leer Übergeben weil ja nur das Nullverzeichnis "/0" geprüft werden muss und nicht dder ganze Verzeichnisname.
        DateisystemtestsHTSEB.StandardeinleseprüfungNeu (LinuxTextExtern   => TextKonstanten.LeerString,
                                                          WindowsTextExtern => (VerzeichnisKonstanten.Grafik & To_Wide_Wide_String (Source => LeseOptionen.Texturen) & VerzeichnisKonstanten.NullDateiWideWide))
      is
         when False =>
            return;
            
         when True =>
            EinzulesendeZeile := 1;
            AktuelleZeile := 1;
            
            DateizugriffssystemHTSEB.ÖffnenText (DateiartExtern => DateiTexturen,
                                                  NameExtern     => UmwandlungssystemHTSEB.Encode (TextExtern => VerzeichnisKonstanten.Grafik & To_Wide_Wide_String (Source => LeseOptionen.Texturen)
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
               MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenTexturenLogik.EinlesenTexturen: Einzulesende Zeile:" & EinzulesendeZeile'Wide_Wide_Image & ", aktuelle Zeile:" & AktuelleZeile'Wide_Wide_Image);
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
                 False = DateisystemtestsHTSEB.StandardeinleseprüfungNeu (LinuxTextExtern   => To_Wide_Wide_String (Source => Dateiname),
                                                                           WindowsTextExtern => To_Wide_Wide_String (Source => GesamterPfad))
               then
                  MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenTexturenLogik.EinlesenTexturen: Datei oder Pfad existiert nicht");
               
               elsif
                 AktuelleZeile = Basisgrund
               then
                  Sf.Graphics.Texture.destroy (texture => EingeleseneTexturenGrafik.BasisgrundAccess);
                  EingeleseneTexturenGrafik.BasisgrundAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Zusatzgrund
               then
                  Sf.Graphics.Texture.destroy (texture => EingeleseneTexturenGrafik.ZusatzgrundAccess);
                  EingeleseneTexturenGrafik.ZusatzgrundAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Flüsse
               then
                  Sf.Graphics.Texture.destroy (texture => EingeleseneTexturenGrafik.FlussAccess);
                  EingeleseneTexturenGrafik.FlussAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Ressourcen
               then
                  Sf.Graphics.Texture.destroy (texture => EingeleseneTexturenGrafik.RessourcenAccess);
                  EingeleseneTexturenGrafik.RessourcenAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Verbesserungen
               then
                  Sf.Graphics.Texture.destroy (texture => EingeleseneTexturenGrafik.VerbesserungenAccess);
                  EingeleseneTexturenGrafik.VerbesserungenAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Wege
               then
                  Sf.Graphics.Texture.destroy (texture => EingeleseneTexturenGrafik.WegeAccess);
                  EingeleseneTexturenGrafik.WegeAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Feldeffekte
               then
                  Sf.Graphics.Texture.destroy (texture => EingeleseneTexturenGrafik.FeldeffekteAccess);
                  EingeleseneTexturenGrafik.FeldeffekteAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Einheitenbefehle
               then
                  Sf.Graphics.Texture.destroy (texture => EingeleseneTexturenGrafik.EinheitenbefehleAccess);
                  EingeleseneTexturenGrafik.EinheitenbefehleAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Kartenbefehle
               then
                  Sf.Graphics.Texture.destroy (texture => EingeleseneTexturenGrafik.KartenbefehleAccess);
                  EingeleseneTexturenGrafik.KartenbefehleAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = RoterKnopf
               then
                  Sf.Graphics.Texture.destroy (texture => EingeleseneTexturenGrafik.RoterKnopfAccess);
                  EingeleseneTexturenGrafik.RoterKnopfAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Intro
               then
                  Sf.Graphics.Texture.destroy (texture => EingeleseneTexturenGrafik.IntroAccess);
                  EingeleseneTexturenGrafik.IntroAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Kartenformen
               then
                  Sf.Graphics.Texture.destroy (texture => EingeleseneTexturenGrafik.KartenformenAccess);
                  EingeleseneTexturenGrafik.KartenformenAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                                    
               elsif
                 AktuelleZeile = Allgemeines
               then
                  Sf.Graphics.Texture.destroy (texture => EingeleseneTexturenGrafik.AllgemeinesAccess);
                  EingeleseneTexturenGrafik.AllgemeinesAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = PZBEnde
               then
                  Sf.Graphics.Texture.destroy (texture => EingeleseneTexturenGrafik.PZBEndeAccess);
                  EingeleseneTexturenGrafik.PZBEndeAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                                    
               elsif
                 AktuelleZeile in HintergründeAnfang .. HintergründeEnde
               then
                  Sf.Graphics.Texture.destroy (texture => EingeleseneTexturenGrafik.AllgemeinesSpezienAccess (SpeziesDatentypen.Spezies_Vorhanden_Enum'Val (AktuelleZeile - HintergründeAnfang + 1)));
                  EingeleseneTexturenGrafik.AllgemeinesSpezienAccess (SpeziesDatentypen.Spezies_Vorhanden_Enum'Val (AktuelleZeile - HintergründeAnfang + 1))
                    := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile in EinheitenAnfang .. EinheitenEnde
               then
                  Sf.Graphics.Texture.destroy (texture => EingeleseneTexturenGrafik.EinheitenAccess (SpeziesDatentypen.Spezies_Vorhanden_Enum'Val (AktuelleZeile - EinheitenAnfang + 1)));
                  EingeleseneTexturenGrafik.EinheitenAccess (SpeziesDatentypen.Spezies_Vorhanden_Enum'Val (AktuelleZeile - EinheitenAnfang + 1))
                    := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile in GebäudeAnfang .. GebäudeEnde
               then
                  Sf.Graphics.Texture.destroy (texture => EingeleseneTexturenGrafik.GebäudeAccess (SpeziesDatentypen.Spezies_Vorhanden_Enum'Val (AktuelleZeile - GebäudeAnfang + 1)));
                  EingeleseneTexturenGrafik.GebäudeAccess (SpeziesDatentypen.Spezies_Vorhanden_Enum'Val (AktuelleZeile - GebäudeAnfang + 1))
                    := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               else
                  MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenTexturenLogik.EinlesenTexturen: Außerhalb des Einlesebereichs");
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
            
      DateizugriffssystemHTSEB.SchließenText (DateiartExtern => DateiTexturen,
                                               NameExtern     => UmwandlungssystemHTSEB.Encode (TextExtern => VerzeichnisKonstanten.Grafik & To_Wide_Wide_String (Source => LeseOptionen.Texturen)
                                                                                                & VerzeichnisKonstanten.NullDateiWideWide));
      
   end EinlesenTexturen;
   
end EinlesenTexturenLogik;
