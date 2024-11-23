with Sf.Audio.Music;

with DateizugriffssystemHTB5;
with UmwandlungssystemHTB3;

with VerzeichnisKonstanten;

with EingeleseneMusik;
with MeldungssystemHTB1;
with EinlesenAllgemeinesLogik;
with VerzeichnisDateinamenTests;

-- with DiagnosesystemHTB4;

-- Unter Windows funktionieren UTF8 Namen bei den Texturdateien nicht, das beim Benennen der Texturen berücksichtigen.
-- Eventuell kann auch einfach die SFML hier kein UTF8.
package body EinlesenMusikLogik is

   procedure EinlesenMusik
   is begin
      
      case
        VerzeichnisDateinamenTests.Standardeinleseprüfung (VerzeichnisDateinameExtern => UmwandlungssystemHTB3.Decode (TextExtern => VerzeichnisKonstanten.Musik & VerzeichnisKonstanten.NullDatei))
      is
         when False =>
            MeldungssystemHTB1.Logik (MeldungExtern => "EinlesenMusikLogik.EinlesenMusik: Es fehlt: "
                                      & UmwandlungssystemHTB3.Decode (TextExtern => VerzeichnisKonstanten.Musik & VerzeichnisKonstanten.NullDatei));
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            DateizugriffssystemHTB5.ÖffnenText (DateiartExtern => DateiMusik,
                                                 NameExtern     => VerzeichnisKonstanten.Musik & VerzeichnisKonstanten.NullDatei);
      end case;
      
      VerzeichnisseSchleife:
      for VerzeichnisSchleifenwert in EingeleseneMusik.MusikArray'Range loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiMusik,
                                                            AktuelleZeileExtern => AktuelleZeile,
                                                            DateinameExtern     => "EinlesenMusikLogik.EinlesenMusik")
         is
            when True =>
               MeldungssystemHTB1.Logik (MeldungExtern => "EinlesenMusikLogik.EinlesenMusik: Fehlende Zeilen: "
                                         & UmwandlungssystemHTB3.Decode (TextExtern => VerzeichnisKonstanten.Musik & VerzeichnisKonstanten.NullDatei) & ", aktuelle Zeile: " & AktuelleZeile'Wide_Wide_Image);
               exit VerzeichnisseSchleife;
               
            when False =>
               Lied := UmwandlungssystemHTB3.Decode (TextExtern => VerzeichnisKonstanten.Musik & "/") & EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiMusik,
                                                                                                                                                   AktuelleZeileExtern => Positive (VerzeichnisSchleifenwert),
                                                                                                                                                   DateinameExtern     => "EinlesenMusikLogik.EinlesenLieder");
               
               if
                 VerzeichnisDateinamenTests.Standardeinleseprüfung (VerzeichnisDateinameExtern => To_Wide_Wide_String (Source => Lied)) = False
               then
                  MeldungssystemHTB1.Logik (MeldungExtern => "EinlesenMusikLogik.EinlesenLieder: Es fehlt: " & To_Wide_Wide_String (Source => Lied));
            
               else
                  EingeleseneMusik.Musik (VerzeichnisSchleifenwert) := Sf.Audio.Music.createFromFile (filename => UmwandlungssystemHTB3.EncodeUnbounded (TextExtern => Lied));
               end if;
               
               AktuelleZeile := AktuelleZeile + 1;
         end case;
         
      end loop VerzeichnisseSchleife;
      
      Close (File => DateiMusik);
      
   end EinlesenMusik;

end EinlesenMusikLogik;
