with Sf.Audio.Music;

with VerzeichnisKonstanten;
with SpeziesKonstanten;

with EingeleseneMusik;
with Fehlermeldungssystem;
with EinlesenAllgemeinesLogik;
with VerzeichnisDateinamenTests;
with UmwandlungenAdaEigenes;
with DateiLogik;

-- Die Prüfungen ob die Zeichenlänge der Musik passt, passen so eventuell nicht richtig. Beim richtigen Einbauen korrigieren. äöü
package body EinlesenMusikLogik is

   procedure EinlesenMusik
   is begin
      
      if
        Platzhalter
      then
         return;
         
      else
         null;
      end if;
      
      case
        VerzeichnisDateinamenTests.Standardeinleseprüfung (VerzeichnisDateinameExtern => UmwandlungenAdaEigenes.EigenesDecode (TextExtern => VerzeichnisKonstanten.Musik & VerzeichnisKonstanten.NullDatei))
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenMusikLogik.EinlesenMusik: Es fehlt: "
                                        & UmwandlungenAdaEigenes.EigenesDecode (TextExtern => VerzeichnisKonstanten.Musik & VerzeichnisKonstanten.NullDatei));
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            DateiLogik.ÖffnenText (DateiartExtern => DateiVerzeichnisse,
                                    NameExtern     => VerzeichnisKonstanten.Musik & VerzeichnisKonstanten.NullDatei);
      end case;
      
      VerzeichnisseSchleife:
      for VerzeichnisSchleifenwert in EingeleseneMusik.MusikArray'Range (1) loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiVerzeichnisse,
                                                            AktuelleZeileExtern => AktuelleZeile,
                                                            DateinameExtern     => "EinlesenMusikLogik.EinlesenMusik")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenMusikLogik.EinlesenMusik: Fehlende Zeilen: "
                                           & UmwandlungenAdaEigenes.EigenesDecode (TextExtern => VerzeichnisKonstanten.Musik & VerzeichnisKonstanten.NullDatei) & ", aktuelle Zeile: " & AktuelleZeile'Wide_Wide_Image);
               exit VerzeichnisseSchleife;
               
            when False =>
               EinlesenLieder (DateipfadExtern => EinlesenAllgemeinesLogik.TextEinlesen (DateiExtern         => DateiVerzeichnisse,
                                                                                         AktuelleZeileExtern => AktuelleZeile,
                                                                                         DateinameExtern     => "EinlesenMusikLogik.EinlesenMusik"),
                               SpeziesExtern   => VerzeichnisSchleifenwert);
               AktuelleZeile := AktuelleZeile + 1;
         end case;
         
      end loop VerzeichnisseSchleife;
      
      Close (File => DateiVerzeichnisse);
      
   end EinlesenMusik;
   
   
   
   procedure EinlesenLieder
     (DateipfadExtern : in Wide_Wide_String;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Enum)
   is begin
      
      case
        SpeziesExtern
      is
         when SpeziesKonstanten.LeerSpezies =>
            null;
            
         when others =>
            null;
      end case;
      
      case
        VerzeichnisDateinamenTests.Standardeinleseprüfung (VerzeichnisDateinameExtern => DateipfadExtern)
      is
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenMusikLogik.EinlesenLieder: Es fehlt: " & DateipfadExtern);
            return;
               
         when True =>
            DateiLogik.ÖffnenText (DateiartExtern => DateiMusik,
                                    NameExtern     => UmwandlungenAdaEigenes.EigenesEncode (TextExtern => DateipfadExtern));
      end case;
               
      MusikSchleife:
      for MusikSchleifenwert in EingeleseneMusik.MusikArray'Range (2) loop
               
         case
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiMusik,
                                                            AktuelleZeileExtern => Positive (MusikSchleifenwert),
                                                            DateinameExtern     => "EinlesenMusikLogik.EinlesenLieder")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenMusikLogik.EinlesenLieder: Fehlende Zeilen: " & DateipfadExtern & ", aktuelle Zeile: " & MusikSchleifenwert'Wide_Wide_Image);
               exit MusikSchleife;
               
            when False =>
               Lied := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiMusik,
                                                                        AktuelleZeileExtern => Positive (MusikSchleifenwert),
                                                                        DateinameExtern     => "EinlesenMusikLogik.EinlesenLieder");
         end case;
         
         case
           VerzeichnisDateinamenTests.Standardeinleseprüfung (VerzeichnisDateinameExtern => To_Wide_Wide_String (Source => Lied))
         is
            when False =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenMusikLogik.EinlesenLieder: Es fehlt: " & To_Wide_Wide_String (Source => Lied));
            
            when True =>
               EingeleseneMusik.Musik (SpeziesExtern, MusikSchleifenwert) := Sf.Audio.Music.createFromFile (filename => UmwandlungenAdaEigenes.EigenesEncodeUnbounded (TextExtern => Lied));
         end case;
            
      end loop MusikSchleife;
      
      Close (File => DateiMusik);
      
   end EinlesenLieder;

end EinlesenMusikLogik;
