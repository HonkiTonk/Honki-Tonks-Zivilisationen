with Ada.Exceptions;

with DateizugriffssystemHTSEB;
with UmwandlungssystemHTSEB;
with MeldungssystemHTSEB;
with DateisystemtestsHTSEB;
with TextKonstantenHTSEB;

with VerzeichnisKonstanten;
with EingeleseneTexturenGrafik;

with LeseOptionen;

with EinlesenAllgemeinesLogik;
with TexturenfelderBerechnenGrafik;

-- Unter Windows funktionieren UTF8 Namen bei den Texturdateien nicht und es kommt zu einem Absturz, das beim Benennen der Texturen berücksichtigen.
package body EinlesenTexturenLogik is
   
   procedure EinlesenTexturen
   is begin
      
      case
        -- Bie Linux wird hier Leer Übergeben weil ja nur das Nullverzeichnis "/0" geprüft werden muss und nicht der ganze Verzeichnisname.
        DateisystemtestsHTSEB.StandardeinleseprüfungNeu (LinuxTextExtern   => TextKonstantenHTSEB.LeerString,
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
               Dateiname := EinlesenAllgemeinesLogik.DateinamenEinlesenUngebunden (DateiExtern         => DateiTexturen,
                                                                                   AktuelleZeileExtern => EinzulesendeZeile,
                                                                                   DateinameExtern     => "EinlesenTexturenLogik.EinlesenTexturen");
               GesamterPfad := VerzeichnisKonstanten.Grafik & LeseOptionen.Texturen & "/" & Dateiname;
               EinzulesendeZeile := EinzulesendeZeile + 1;
         end case;
         
         if
           Dateiname = TextKonstantenHTSEB.LeerUnboundedString
           or else
             To_Wide_Wide_String (Source => Dateiname) (1) = TextKonstantenHTSEB.TrennzeichenTextdateien
         then
            null;
            
         else
            if
              False = DateisystemtestsHTSEB.StandardeinleseprüfungNeu (LinuxTextExtern   => To_Wide_Wide_String (Source => Dateiname),
                                                                        WindowsTextExtern => To_Wide_Wide_String (Source => GesamterPfad))
            then
               MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenTexturenLogik.EinlesenTexturen: Datei oder Pfad existiert nicht");
               
            elsif
              AktuelleZeile = Basisgrund
            then
               EingeleseneTexturenGrafik.BasisgrundAccess := TexturFestlegen (TexturenAccessExtern => EingeleseneTexturenGrafik.BasisgrundAccess,
                                                                              TexturenpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
            elsif
              AktuelleZeile = Zusatzgrund
            then
               EingeleseneTexturenGrafik.ZusatzgrundAccess := TexturFestlegen (TexturenAccessExtern => EingeleseneTexturenGrafik.ZusatzgrundAccess,
                                                                               TexturenpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
            elsif
              AktuelleZeile = Flüsse
            then
               EingeleseneTexturenGrafik.FlussAccess := TexturFestlegen (TexturenAccessExtern => EingeleseneTexturenGrafik.FlussAccess,
                                                                         TexturenpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
            elsif
              AktuelleZeile = Ressourcen
            then
               EingeleseneTexturenGrafik.RessourcenAccess := TexturFestlegen (TexturenAccessExtern => EingeleseneTexturenGrafik.RessourcenAccess,
                                                                              TexturenpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
            elsif
              AktuelleZeile = Verbesserungen
            then
               EingeleseneTexturenGrafik.VerbesserungenAccess := TexturFestlegen (TexturenAccessExtern => EingeleseneTexturenGrafik.VerbesserungenAccess,
                                                                                  TexturenpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
            elsif
              AktuelleZeile = Wege
            then
               EingeleseneTexturenGrafik.WegeAccess := TexturFestlegen (TexturenAccessExtern => EingeleseneTexturenGrafik.WegeAccess,
                                                                        TexturenpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
            elsif
              AktuelleZeile = Feldeffekte
            then
               EingeleseneTexturenGrafik.FeldeffekteAccess := TexturFestlegen (TexturenAccessExtern => EingeleseneTexturenGrafik.FeldeffekteAccess,
                                                                               TexturenpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
            elsif
              AktuelleZeile = Einheitenbefehle
            then
               EingeleseneTexturenGrafik.EinheitenbefehleAccess := TexturFestlegen (TexturenAccessExtern => EingeleseneTexturenGrafik.EinheitenbefehleAccess,
                                                                                    TexturenpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
            elsif
              AktuelleZeile = Kartenbefehle
            then
               EingeleseneTexturenGrafik.KartenbefehleAccess := TexturFestlegen (TexturenAccessExtern => EingeleseneTexturenGrafik.KartenbefehleAccess,
                                                                                 TexturenpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
            elsif
              AktuelleZeile = RoterKnopf
            then
               EingeleseneTexturenGrafik.RoterKnopfAccess := TexturFestlegen (TexturenAccessExtern => EingeleseneTexturenGrafik.RoterKnopfAccess,
                                                                              TexturenpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
            elsif
              AktuelleZeile = Intro
            then
               EingeleseneTexturenGrafik.IntroAccess := TexturFestlegen (TexturenAccessExtern => EingeleseneTexturenGrafik.IntroAccess,
                                                                         TexturenpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
            elsif
              AktuelleZeile = Kartenformen
            then
               EingeleseneTexturenGrafik.KartenformenAccess := TexturFestlegen (TexturenAccessExtern => EingeleseneTexturenGrafik.KartenformenAccess,
                                                                                TexturenpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                                    
            elsif
              AktuelleZeile = Allgemeines
            then
               EingeleseneTexturenGrafik.AllgemeinesAccess := TexturFestlegen (TexturenAccessExtern => EingeleseneTexturenGrafik.AllgemeinesAccess,
                                                                               TexturenpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
            elsif
              AktuelleZeile = PZBEnde
            then
               EingeleseneTexturenGrafik.PZBEndeAccess := TexturFestlegen (TexturenAccessExtern => EingeleseneTexturenGrafik.PZBEndeAccess,
                                                                           TexturenpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                                    
            elsif
              AktuelleZeile in HintergründeAnfang .. HintergründeEnde
            then
               EingeleseneTexturenGrafik.AllgemeinesSpezienAccess (SpeziesDatentypen.Spezies_Vorhanden_Enum'Val (AktuelleZeile - HintergründeAnfang + 1))
                 := TexturFestlegen (TexturenAccessExtern => EingeleseneTexturenGrafik.AllgemeinesSpezienAccess
                                     (SpeziesDatentypen.Spezies_Vorhanden_Enum'Val (AktuelleZeile - HintergründeAnfang + 1)),
                                     TexturenpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
            elsif
              AktuelleZeile in EinheitenAnfang .. EinheitenEnde
            then
               EingeleseneTexturenGrafik.EinheitenAccess (SpeziesDatentypen.Spezies_Vorhanden_Enum'Val (AktuelleZeile - EinheitenAnfang + 1))
                 := TexturFestlegen (TexturenAccessExtern => EingeleseneTexturenGrafik.EinheitenAccess (SpeziesDatentypen.Spezies_Vorhanden_Enum'Val (AktuelleZeile - EinheitenAnfang + 1)),
                                     TexturenpfadExtern   => UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => GesamterPfad));
                  
            elsif
              AktuelleZeile in GebäudeAnfang .. GebäudeEnde
            then
               EingeleseneTexturenGrafik.GebäudeAccess (SpeziesDatentypen.Spezies_Vorhanden_Enum'Val (AktuelleZeile - GebäudeAnfang + 1))
                 := TexturFestlegen (TexturenAccessExtern => EingeleseneTexturenGrafik.GebäudeAccess (SpeziesDatentypen.Spezies_Vorhanden_Enum'Val (AktuelleZeile - GebäudeAnfang + 1)),
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
         end if;
                  
      end loop TexturenSchleife;
            
      DateizugriffssystemHTSEB.SchließenText (DateiartExtern => DateiTexturen,
                                               NameExtern     => UmwandlungssystemHTSEB.Encode (TextExtern => VerzeichnisKonstanten.Grafik & To_Wide_Wide_String (Source => LeseOptionen.Texturen)
                                                                                                & VerzeichnisKonstanten.NullDateiWideWide));
      
   end EinlesenTexturen;
   
   
   
   function TexturFestlegen
     (TexturenAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      TexturenpfadExtern : in String)
      return Sf.Graphics.sfTexture_Ptr
   is
      use Ada.Exceptions;
   begin
      
      Sf.Graphics.Texture.destroy (texture => TexturenAccessExtern);
      
      return Sf.Graphics.Texture.createFromFile (filename => TexturenpfadExtern);
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenTexturenLogik.TexturFestlegen: " & UmwandlungssystemHTSEB.Decode (TextExtern => TexturenpfadExtern)
                                    & " Texturenmaximum:" & MaximaleTexturengröße'Wide_Wide_Image & " " & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return null;
         
   end TexturFestlegen;
   
end EinlesenTexturenLogik;
