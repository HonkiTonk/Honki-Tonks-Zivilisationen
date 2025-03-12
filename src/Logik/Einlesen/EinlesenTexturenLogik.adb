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
        -- Bie Linux wird hier Leer Übergeben weil ja nur das Nullverzeichnis "/0" geprüft werden muss und nicht der ganze Verzeichnisname.
        DateisystemtestsHTSEB.StandardeinleseprüfungNeu (LinuxTextExtern   => TextKonstanten.LeerString,
                                                          WindowsTextExtern => (VerzeichnisKonstanten.Grafik & To_Wide_Wide_String (Source => LeseOptionen.Texturen) & VerzeichnisKonstanten.NullDateiWideWide))
      is
         when False =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenTexturenLogik.EinlesenTexturen: Es fehlt: " & VerzeichnisKonstanten.Grafik
                                       & To_Wide_Wide_String (Source => LeseOptionen.Texturen) & VerzeichnisKonstanten.NullDateiWideWide);
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
                  EingeleseneTexturenGrafik.BasisgrundAccess := EinlesenAllgemeinesLogik.TexturFestlegen (TexturenAccessExtern => EingeleseneTexturenGrafik.BasisgrundAccess,
                                                                                                          TexturenpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Zusatzgrund
               then
                  EingeleseneTexturenGrafik.ZusatzgrundAccess := EinlesenAllgemeinesLogik.TexturFestlegen (TexturenAccessExtern => EingeleseneTexturenGrafik.ZusatzgrundAccess,
                                                                                                           TexturenpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Flüsse
               then
                  EingeleseneTexturenGrafik.FlussAccess := EinlesenAllgemeinesLogik.TexturFestlegen (TexturenAccessExtern => EingeleseneTexturenGrafik.FlussAccess,
                                                                                                     TexturenpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Ressourcen
               then
                  EingeleseneTexturenGrafik.RessourcenAccess := EinlesenAllgemeinesLogik.TexturFestlegen (TexturenAccessExtern => EingeleseneTexturenGrafik.RessourcenAccess,
                                                                                                          TexturenpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Verbesserungen
               then
                  EingeleseneTexturenGrafik.VerbesserungenAccess := EinlesenAllgemeinesLogik.TexturFestlegen (TexturenAccessExtern => EingeleseneTexturenGrafik.VerbesserungenAccess,
                                                                                                              TexturenpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Wege
               then
                  EingeleseneTexturenGrafik.WegeAccess := EinlesenAllgemeinesLogik.TexturFestlegen (TexturenAccessExtern => EingeleseneTexturenGrafik.WegeAccess,
                                                                                                    TexturenpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Feldeffekte
               then
                  EingeleseneTexturenGrafik.FeldeffekteAccess := EinlesenAllgemeinesLogik.TexturFestlegen (TexturenAccessExtern => EingeleseneTexturenGrafik.FeldeffekteAccess,
                                                                                                           TexturenpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Einheitenbefehle
               then
                  EingeleseneTexturenGrafik.EinheitenbefehleAccess := EinlesenAllgemeinesLogik.TexturFestlegen (TexturenAccessExtern => EingeleseneTexturenGrafik.EinheitenbefehleAccess,
                                                                                                                TexturenpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Kartenbefehle
               then
                  EingeleseneTexturenGrafik.KartenbefehleAccess := EinlesenAllgemeinesLogik.TexturFestlegen (TexturenAccessExtern => EingeleseneTexturenGrafik.KartenbefehleAccess,
                                                                                                             TexturenpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = RoterKnopf
               then
                  EingeleseneTexturenGrafik.RoterKnopfAccess := EinlesenAllgemeinesLogik.TexturFestlegen (TexturenAccessExtern => EingeleseneTexturenGrafik.RoterKnopfAccess,
                                                                                                          TexturenpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Intro
               then
                  EingeleseneTexturenGrafik.IntroAccess := EinlesenAllgemeinesLogik.TexturFestlegen (TexturenAccessExtern => EingeleseneTexturenGrafik.IntroAccess,
                                                                                                     TexturenpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Kartenformen
               then
                  EingeleseneTexturenGrafik.KartenformenAccess := EinlesenAllgemeinesLogik.TexturFestlegen (TexturenAccessExtern => EingeleseneTexturenGrafik.KartenformenAccess,
                                                                                                            TexturenpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                                    
               elsif
                 AktuelleZeile = Allgemeines
               then
                  EingeleseneTexturenGrafik.AllgemeinesAccess := EinlesenAllgemeinesLogik.TexturFestlegen (TexturenAccessExtern => EingeleseneTexturenGrafik.AllgemeinesAccess,
                                                                                                           TexturenpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = PZBEnde
               then
                  EingeleseneTexturenGrafik.PZBEndeAccess := EinlesenAllgemeinesLogik.TexturFestlegen (TexturenAccessExtern => EingeleseneTexturenGrafik.PZBEndeAccess,
                                                                                                       TexturenpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                                    
               elsif
                 AktuelleZeile in HintergründeAnfang .. HintergründeEnde
               then
                  EingeleseneTexturenGrafik.AllgemeinesSpezienAccess (SpeziesDatentypen.Spezies_Vorhanden_Enum'Val (AktuelleZeile - HintergründeAnfang + 1))
                    := EinlesenAllgemeinesLogik.TexturFestlegen (TexturenAccessExtern => EingeleseneTexturenGrafik.AllgemeinesSpezienAccess
                                                                 (SpeziesDatentypen.Spezies_Vorhanden_Enum'Val (AktuelleZeile - HintergründeAnfang + 1)),
                                                                 TexturenpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile in EinheitenAnfang .. EinheitenEnde
               then
                  EingeleseneTexturenGrafik.EinheitenAccess (SpeziesDatentypen.Spezies_Vorhanden_Enum'Val (AktuelleZeile - EinheitenAnfang + 1))
                    := EinlesenAllgemeinesLogik.TexturFestlegen (TexturenAccessExtern => EingeleseneTexturenGrafik.EinheitenAccess (SpeziesDatentypen.Spezies_Vorhanden_Enum'Val (AktuelleZeile - EinheitenAnfang + 1)),
                                                                 TexturenpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile in GebäudeAnfang .. GebäudeEnde
               then
                  EingeleseneTexturenGrafik.GebäudeAccess (SpeziesDatentypen.Spezies_Vorhanden_Enum'Val (AktuelleZeile - GebäudeAnfang + 1))
                    := EinlesenAllgemeinesLogik.TexturFestlegen (TexturenAccessExtern => EingeleseneTexturenGrafik.GebäudeAccess (SpeziesDatentypen.Spezies_Vorhanden_Enum'Val (AktuelleZeile - GebäudeAnfang + 1)),
                                                                 TexturenpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
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
