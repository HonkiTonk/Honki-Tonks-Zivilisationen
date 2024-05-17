with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with VerzeichnisKonstanten;
with TextKonstanten;
with EingeleseneTexturenGrafik;

with EinlesenAllgemeinesLogik;
with Fehlermeldungssystem;
with VerzeichnisDateinamenTests;
with TexturenfelderBerechnenGrafik;

package body EinlesenTexturenLogik is
   
   procedure EinlesenTexturen
   is begin
      
      case
        VerzeichnisDateinamenTests.StandardeinleseprüfungNeu (LinuxTextExtern   => TextKonstanten.LeerString,
                                                               WindowsTextExtern => Decode (Item => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.NullDatei))
      is
         when False =>
            return;
            
         when True =>
            EinzulesendeZeile := 1;
            AktuelleZeile := 1;
            
            Open (File => DateiTexturen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Grafik & VerzeichnisKonstanten.NullDatei,
                  Form => "WCEM=8");
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
               GesamterPfad := Decode (Item => VerzeichnisKonstanten.Grafik) & "/" & Dateiname;
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
                  EingeleseneTexturenGrafik.BasisgrundAccessGesamt := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => Encode (Item => To_Wide_Wide_String (Source => GesamterPfad)));
                  
               elsif
                 AktuelleZeile = Zusatzgrund
               then
                  EingeleseneTexturenGrafik.ZusatzgrundAccessGesamt := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => Encode (Item => To_Wide_Wide_String (Source => GesamterPfad)));
                  
               elsif
                 AktuelleZeile = Flüsse
               then
                  EingeleseneTexturenGrafik.FeldeffekteAccessGesamt := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => Encode (Item => To_Wide_Wide_String (Source => GesamterPfad)));
                  
               elsif
                 AktuelleZeile = Ressourcen
               then
                  EingeleseneTexturenGrafik.KartenressourcenAccessGesamt := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => Encode (Item => To_Wide_Wide_String (Source => GesamterPfad)));
                  
               elsif
                 AktuelleZeile = Verbesserungen
               then
                  EingeleseneTexturenGrafik.VerbesserungenAccessGesamt := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => Encode (Item => To_Wide_Wide_String (Source => GesamterPfad)));
                  
               elsif
                 AktuelleZeile = Wege
               then
                  EingeleseneTexturenGrafik.WegeAccessGesamt := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => Encode (Item => To_Wide_Wide_String (Source => GesamterPfad)));
                  
               elsif
                 AktuelleZeile = Feldeffekte
               then
                  EingeleseneTexturenGrafik.FeldeffekteAccessGesamt := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => Encode (Item => To_Wide_Wide_String (Source => GesamterPfad)));
                  
               elsif
                 AktuelleZeile = Einheitenbefehle
               then
                  EingeleseneTexturenGrafik.EinheitenbefehleAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => Encode (Item => To_Wide_Wide_String (Source => GesamterPfad)));
                  
               elsif
                 AktuelleZeile = Kartenbefehle
               then
                  EingeleseneTexturenGrafik.KartenbefehleAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => Encode (Item => To_Wide_Wide_String (Source => GesamterPfad)));
                  
               elsif
                 AktuelleZeile = RoterKnopf
               then
                  EingeleseneTexturenGrafik.RoterKnopfAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => Encode (Item => To_Wide_Wide_String (Source => GesamterPfad)));
                  
               elsif
                 AktuelleZeile = Intro
               then
                  EingeleseneTexturenGrafik.IntroAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => Encode (Item => To_Wide_Wide_String (Source => GesamterPfad)));
                  
               elsif
                 AktuelleZeile = Kartenformen
               then
                  EingeleseneTexturenGrafik.KartenformenAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => Encode (Item => To_Wide_Wide_String (Source => GesamterPfad)));
                  
               elsif
                 AktuelleZeile = Seitenleiste
               then
                  EingeleseneTexturenGrafik.SeitenleisteAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => Encode (Item => To_Wide_Wide_String (Source => GesamterPfad)));
                  
               elsif
                 AktuelleZeile = Menüs
               then
                  EingeleseneTexturenGrafik.MenüsAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => Encode (Item => To_Wide_Wide_String (Source => GesamterPfad)));
                  
               elsif
                 AktuelleZeile = PZBEnde
               then
                  EingeleseneTexturenGrafik.PZBEndeAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => Encode (Item => To_Wide_Wide_String (Source => GesamterPfad)));
                  
               elsif
                 AktuelleZeile = Auswahl
               then
                  EingeleseneTexturenGrafik.AuswahlAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => Encode (Item => To_Wide_Wide_String (Source => GesamterPfad)));
                  
               elsif
                 AktuelleZeile = Meldung
               then
                  EingeleseneTexturenGrafik.MeldungAccess := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => Encode (Item => To_Wide_Wide_String (Source => GesamterPfad)));
                  
               elsif
                 AktuelleZeile in HintergründeAnfang .. HintergründeEnde
               then
                  EingeleseneTexturenGrafik.HintergrundAccessGesamt (SpeziesDatentypen.Spezies_Vorhanden_Enum'Val (AktuelleZeile - HintergründeAnfang + 1))
                    := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => Encode (Item => To_Wide_Wide_String (Source => GesamterPfad)));
                  
               elsif
                 AktuelleZeile in EinheitenAnfang .. EinheitenEnde
               then
                  EingeleseneTexturenGrafik.EinheitenAccessGesamt (SpeziesDatentypen.Spezies_Vorhanden_Enum'Val (AktuelleZeile - EinheitenAnfang + 1))
                    := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => Encode (Item => To_Wide_Wide_String (Source => GesamterPfad)));
                  
               elsif
                 AktuelleZeile in GebäudeAnfang .. GebäudeEnde
               then
                  EingeleseneTexturenGrafik.GebäudeAccessGesamt (SpeziesDatentypen.Spezies_Vorhanden_Enum'Val (AktuelleZeile - GebäudeAnfang + 1))
                    := EinlesenAllgemeinesLogik.Texturenlimit (TexturenpfadExtern => Encode (Item => To_Wide_Wide_String (Source => GesamterPfad)));
                  
               else
                  Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTexturenLogik.EinlesenTexturen: Außerhalb des Einlesebereichs");
                  return;
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
