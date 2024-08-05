with VerzeichnisKonstanten;
with TextKonstanten;
with EingeleseneTexturenGrafik;

with EinlesenAllgemeinesLogik;
with Fehlermeldungssystem;
with VerzeichnisDateinamenTests;
with TexturenfelderBerechnenGrafik;
with UmwandlungenAdaEigenes;
with DateiLogik;

package body EinlesenTexturenLogik is
   
   procedure EinlesenTexturen
   is begin
      
      case
        VerzeichnisDateinamenTests.StandardeinleseprüfungNeu (LinuxTextExtern   => TextKonstanten.LeerString,
                                                               WindowsTextExtern => UmwandlungenAdaEigenes.EigenesDecode (TextExtern => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.NullDatei))
      is
         when False =>
            return;
            
         when True =>
            EinzulesendeZeile := 1;
            AktuelleZeile := 1;
            
            DateiLogik.ÖffnenText (DateiartExtern => DateiTexturen,
                                    NameExtern     => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.NullDatei);
      end case;
      
      TexturenSchleife:
      loop
         
         case
           EinlesenAllgemeinesLogik.VorzeitigesDateienende (AktuelleDateiExtern => DateiTexturen,
                                                            AktuelleZeileExtern => EinzulesendeZeile,
                                                            DateinameExtern     => "EinlesenTexturenLogik.EinlesenTexturen")
         is
            when True =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenTexturen: Einzulesende Zeile:" & EinzulesendeZeile'Wide_Wide_Image & ", aktuelle Zeile:" & AktuelleZeile'Wide_Wide_Image);
               exit TexturenSchleife;
               
            when False =>
               Dateiname := EinlesenAllgemeinesLogik.TextEinlesenUngebunden (DateiExtern         => DateiTexturen,
                                                                             AktuelleZeileExtern => EinzulesendeZeile,
                                                                             DateinameExtern     => "EinlesenTexturenLogik.EinlesenTexturen");
               GesamterPfad := UmwandlungenAdaEigenes.EigenesDecode (TextExtern => VerzeichnisKonstanten.Grafik) & "/" & Dateiname;
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
                  Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.Karte: Datei oder Pfad existiert nicht");
               
               elsif
                 AktuelleZeile = Basisgrund
               then
                  EingeleseneTexturenGrafik.BasisgrundAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungenAdaEigenes.EigenesEncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Zusatzgrund
               then
                  EingeleseneTexturenGrafik.ZusatzgrundAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungenAdaEigenes.EigenesEncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Flüsse
               then
                  EingeleseneTexturenGrafik.FlussAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungenAdaEigenes.EigenesEncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Ressourcen
               then
                  EingeleseneTexturenGrafik.RessourcenAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungenAdaEigenes.EigenesEncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Verbesserungen
               then
                  EingeleseneTexturenGrafik.VerbesserungenAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungenAdaEigenes.EigenesEncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Wege
               then
                  EingeleseneTexturenGrafik.WegeAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungenAdaEigenes.EigenesEncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Feldeffekte
               then
                  EingeleseneTexturenGrafik.FeldeffekteAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungenAdaEigenes.EigenesEncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Einheitenbefehle
               then
                  EingeleseneTexturenGrafik.EinheitenbefehleAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungenAdaEigenes.EigenesEncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Kartenbefehle
               then
                  EingeleseneTexturenGrafik.KartenbefehleAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungenAdaEigenes.EigenesEncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = RoterKnopf
               then
                  EingeleseneTexturenGrafik.RoterKnopfAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungenAdaEigenes.EigenesEncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Intro
               then
                  EingeleseneTexturenGrafik.IntroAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungenAdaEigenes.EigenesEncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Kartenformen
               then
                  EingeleseneTexturenGrafik.KartenformenAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungenAdaEigenes.EigenesEncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Seitenleiste
               then
                  EingeleseneTexturenGrafik.SeitenleisteAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungenAdaEigenes.EigenesEncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Allgemeines
               then
                  EingeleseneTexturenGrafik.AllgemeinesAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungenAdaEigenes.EigenesEncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = PZBEnde
               then
                  EingeleseneTexturenGrafik.PZBEndeAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungenAdaEigenes.EigenesEncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Auswahl
               then
                  EingeleseneTexturenGrafik.AuswahlAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungenAdaEigenes.EigenesEncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile = Meldung
               then
                  EingeleseneTexturenGrafik.MeldungAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungenAdaEigenes.EigenesEncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile in HintergründeAnfang .. HintergründeEnde
               then
                  EingeleseneTexturenGrafik.HintergrundAccessGesamt (SpeziesDatentypen.Spezies_Vorhanden_Enum'Val (AktuelleZeile - HintergründeAnfang + 1))
                    := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungenAdaEigenes.EigenesEncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile in EinheitenAnfang .. EinheitenEnde
               then
                  EingeleseneTexturenGrafik.EinheitenAccess (SpeziesDatentypen.Spezies_Vorhanden_Enum'Val (AktuelleZeile - EinheitenAnfang + 1))
                    := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungenAdaEigenes.EigenesEncodeUnbounded (TextExtern => GesamterPfad));
                  
               elsif
                 AktuelleZeile in GebäudeAnfang .. GebäudeEnde
               then
                  EingeleseneTexturenGrafik.GebäudeAccess (SpeziesDatentypen.Spezies_Vorhanden_Enum'Val (AktuelleZeile - GebäudeAnfang + 1))
                    := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => UmwandlungenAdaEigenes.EigenesEncodeUnbounded (TextExtern => GesamterPfad));
                  
               else
                  Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenTexturen: Außerhalb des Einlesebereichs");
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
   
end EinlesenTexturenLogik;
