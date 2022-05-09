pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf; use Sf;
with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with SonstigesKonstanten;
with MenueDatentypen;

with GrafikEinstellungenSFML;
with AllgemeineTextBerechnungenSFML;
with InteraktionAuswahl;
with AuswahlMenuesStringsSetzen;
with Karten;
with Fehler;
with AuswahlMenuesEinfach;
with MenueHintergrundSFML;
with AuswahlMenuesZusatztextSFML;

package body AuswahlMenueKartenformSFML is

   -- Für Überarbeitungen siehe auch das gespeicherte Kartenformmerkblatt.
   procedure AuswahlMenüKartenform
   is begin
              
      MenueHintergrundSFML.MenüHintergrund (WelchesMenüExtern  => MenueDatentypen.Kartenform_Menü_Enum,
                                            SpriteAccessExtern => SpriteAccess);
      
      AktuelleAuswahlRückgabewert := Textbearbeitung;
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.KartenformauswahlAccess (Überschrift));
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.KartenformauswahlAccess (TextaccessVariablen.KartenformauswahlAccess'Last));
      
      PositionenSchleife:
      for PositionSchleifenwert in TextaccessVariablen.KartenformauswahlAccessArray'First + Überschrift .. 9 loop
               
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextaccessVariablen.KartenformauswahlAccess (PositionSchleifenwert));
         
         case
           PositionSchleifenwert
         is
            when 2 =>
               Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                  text         => TextaccessVariablen.KartenformauswahlAccess (WelcheFormEins (Karten.Kartenparameter.Kartenform.EAchseOben)));
               
            when 3 =>
               Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                  text         => TextaccessVariablen.KartenformauswahlAccess (WelcheFormZwei (Karten.Kartenparameter.Kartenform.EAchseUnten)));
               
            when 4 =>
               Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                  text         => TextaccessVariablen.KartenformauswahlAccess (WelcheFormEins (Karten.Kartenparameter.Kartenform.YAchseNorden)));
               
            when 5 =>
               Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                  text         => TextaccessVariablen.KartenformauswahlAccess (WelcheFormZwei (Karten.Kartenparameter.Kartenform.YAchseSüden)));
               
            when 6 =>
               Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                  text         => TextaccessVariablen.KartenformauswahlAccess (WelcheFormEins (Karten.Kartenparameter.Kartenform.XAchseWesten)));
               
            when 7 =>
               Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                  text         => TextaccessVariablen.KartenformauswahlAccess (WelcheFormZwei (Karten.Kartenparameter.Kartenform.XAchseOsten)));
               
            when others =>
               null;
         end case;
         
      end loop PositionenSchleife;
      
      case
        AktuelleAuswahlRückgabewert
      is
         when SystemKonstanten.LeerAuswahl =>
            null;
            
         when others =>
            AuswahlMenuesZusatztextSFML.MenüsZusatztextAufteilung (WelchesMenüExtern     => MenueDatentypen.Kartenform_Menü_Enum,
                                                                    AktuelleAuswahlExtern => AktuelleAuswahlRückgabewert);
      end case;
      
   end AuswahlMenüKartenform;
   
   
   
   function Textbearbeitung
     return Natural
   is begin
      
      AktuelleAuswahl := AuswahlMenuesEinfach.AktuelleAuswahl;
      
      if
        AktuelleAuswahl /= LetzteAuswahl
      then
         FarbeAktuelleAuswahlFestlegen (AktuelleAuswahlExtern => AktuelleAuswahl,
                                        LetzteAuswahlExtern   => LetzteAuswahl);
         
         LetzteAuswahl := AktuelleAuswahl;
         
      else
         null;
      end if;
      
      case
        TextEingelesen
      is
         when False =>
            TextEingelesen := TextEinlesen;
            
         when True =>
            null;
      end case;
      
      case
        SchriftpositionFestgelegt
      is
         when False =>
            SchriftpositionFestgelegt := SchriftpositionFestlegen;
            
         when True =>
            null;
      end case;
      
      return AktuelleAuswahl;
      
   end Textbearbeitung;
   
   
   
   procedure FarbeAktuelleAuswahlFestlegen
     (AktuelleAuswahlExtern : in Natural;
      LetzteAuswahlExtern : in Natural)
   is begin
                
      case
        LetzteAuswahlExtern
      is
         when SystemKonstanten.LeerAuswahl =>
            null;
            
         when 1 .. 2 =>
            EbeneSchleife:
            for EbeneSchleifenwert in 0 .. 1 loop
                                                
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KartenformauswahlAccess (Schleifenanpassung (LetzteAuswahlExtern + Überschrift) + EbeneSchleifenwert),
                                          color => GrafikEinstellungenSFML.Schriftfarben.FarbeMenschText);
                  
            end loop EbeneSchleife;
            
         when 3 .. 6 =>
            AchsenSchleife:
            for AchsenSchleifenwert in 0 .. 3 loop
                                 
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KartenformauswahlAccess (Schleifenanpassung (LetzteAuswahlExtern + Überschrift) + AchsenSchleifenwert),
                                          color => GrafikEinstellungenSFML.Schriftfarben.FarbeMenschText);
                  
            end loop AchsenSchleife;

         when others =>
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KartenformauswahlAccess (LetzteAuswahlExtern + Überschrift),
                                       color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
      end case;
      
      case
        AktuelleAuswahlExtern
      is
         when SystemKonstanten.LeerAuswahl =>
            null;
            
         when 1 .. 2 =>
            AEbeneSchleife:
            for EbeneSchleifenwert in 0 .. 1 loop
                                 
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KartenformauswahlAccess (Schleifenanpassung (AktuelleAuswahlExtern + Überschrift) + EbeneSchleifenwert),
                                          color => GrafikEinstellungenSFML.Schriftfarben.FarbeAusgewähltText);
                  
            end loop AEbeneSchleife;
            
         when 3 .. 6 =>
            AAchsenSchleife:
            for AchsenSchleifenwert in 0 .. 3 loop
                                 
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KartenformauswahlAccess (Schleifenanpassung (AktuelleAuswahlExtern + Überschrift) + AchsenSchleifenwert),
                                          color => GrafikEinstellungenSFML.Schriftfarben.FarbeAusgewähltText);
                  
            end loop AAchsenSchleife;
            
         when others =>
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KartenformauswahlAccess (AktuelleAuswahlExtern + Überschrift),
                                       color => GrafikEinstellungenSFML.Schriftfarben.FarbeAusgewähltText);
      end case;
      
   end FarbeAktuelleAuswahlFestlegen;
   
   
   
   function TextEinlesen
     return Boolean
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KartenformauswahlAccess (Überschrift),
                                         str  => AuswahlMenuesStringsSetzen.AuswahlMenüStringSetzen (WelcheZeileExtern => Überschrift,
                                                                                                      WelchesMenüExtern => MenueDatentypen.Kartenform_Menü_Enum));
      
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.KartenformauswahlAccessArray'First + Überschrift .. Schleifenanpassung (2) - 1 loop
                  
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KartenformauswahlAccess (TextSchleifenwert),
                                            str  => AuswahlMenuesStringsSetzen.AuswahlMenüStringSetzen (WelcheZeileExtern => TextSchleifenwert,
                                                                                                         WelchesMenüExtern => MenueDatentypen.Kartenform_Menü_Enum));
         
      end loop TextSchleife;
      
      MehrfachTextSchleife:
      for MehrfachTextSchleifenwert in Schleifenanpassung (2) .. TextaccessVariablen.KartenformauswahlAccessArray'Last - Versionsnummer loop
         
         case
           MehrfachTextSchleifenwert
         is
            when 10 | 12 | 14 | 18 | 22 | 26 =>
               Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KartenformauswahlAccess (MehrfachTextSchleifenwert),
                                                  str  => AuswahlMenuesStringsSetzen.AuswahlMenüStringSetzen (WelcheZeileExtern => 10,
                                                                                                               WelchesMenüExtern => MenueDatentypen.Kartenform_Menü_Enum));
               
            when 11 | 13 | 15 | 19 | 23 | 27 =>
               Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KartenformauswahlAccess (MehrfachTextSchleifenwert),
                                                  str  => AuswahlMenuesStringsSetzen.AuswahlMenüStringSetzen (WelcheZeileExtern => 11,
                                                                                                               WelchesMenüExtern => MenueDatentypen.Kartenform_Menü_Enum));
               
            when 16 | 20 | 24 | 28 =>
               Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KartenformauswahlAccess (MehrfachTextSchleifenwert),
                                                  str  => AuswahlMenuesStringsSetzen.AuswahlMenüStringSetzen (WelcheZeileExtern => 12,
                                                                                                               WelchesMenüExtern => MenueDatentypen.Kartenform_Menü_Enum));
               
            when 17 | 21 | 25 | 29 =>
               Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KartenformauswahlAccess (MehrfachTextSchleifenwert),
                                                  str  => AuswahlMenuesStringsSetzen.AuswahlMenüStringSetzen (WelcheZeileExtern => 13,
                                                                                                               WelchesMenüExtern => MenueDatentypen.Kartenform_Menü_Enum));
               
            when others =>
               Fehler.GrafikFehler (FehlermeldungExtern => "AuswahlMenueKartenformSFML.TextEinlesen - Schleife loopt falsch.");
         end case;
               
               
      end loop MehrfachTextSchleife;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KartenformauswahlAccess (TextaccessVariablen.KartenformauswahlAccessArray'Last),
                                         str  => "Version: " & SonstigesKonstanten.Versionsnummer);
      
      return True;
      
   end TextEinlesen;
   
   
   
   function SchriftpositionFestlegen
     return Boolean
   is begin
      
      ZeilenAbstand := 0.50 * Float (GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
      
      Rechenwert.y := Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y / 100);
      
      if
        Rechenwert.y < 20.00
      then
         Rechenwert.y := 20.00;
         
      else
         null;
      end if;
      
      Rechenwert.x := AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextaccessVariablen.KartenformauswahlAccess (Überschrift));
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KartenformauswahlAccess (Überschrift),
                                    position => Rechenwert);
      
      Rechenwert.y := Rechenwert.y + 3.00 * Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.KartenformauswahlAccess (Überschrift)).height + ZeilenAbstand;
      
      PositionenSchleife:
      for PositionSchleifenwert in TextaccessVariablen.KartenformauswahlAccessArray'First + Überschrift .. 7 loop
         
         case
           PositionSchleifenwert
         is
            when 2 .. 3 =>
               Rechenwert.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern => TextaccessVariablen.KartenformauswahlAccess (PositionSchleifenwert),
                                                                                            LinksRechtsExtern => True);
                           
               Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KartenformauswahlAccess (PositionSchleifenwert),
                                             position => Rechenwert);
               
               Rechenwert.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern => TextaccessVariablen.KartenformauswahlAccess (PositionSchleifenwert),
                                                                                            LinksRechtsExtern => False);
               
               EbeneSchleife:
               for EbeneSchleifenwert in 0 .. 1 loop
                                 
                  Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KartenformauswahlAccess (Schleifenanpassung (PositionSchleifenwert) + EbeneSchleifenwert),
                                                position => Rechenwert);
                  
               end loop EbeneSchleife;
         
               InteraktionAuswahl.PositionenMenüeinträge (MenueDatentypen.Kartenform_Menü_Enum, PositionSchleifenwert - Überschrift)
                 := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.KartenformauswahlAccess (Schleifenanpassung (PositionSchleifenwert)));
               
            when 4 .. 7 =>
               Rechenwert.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern => TextaccessVariablen.KartenformauswahlAccess (PositionSchleifenwert),
                                                                                            LinksRechtsExtern => True);
                           
               Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KartenformauswahlAccess (PositionSchleifenwert),
                                             position => Rechenwert);
               
               Rechenwert.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern => TextaccessVariablen.KartenformauswahlAccess (PositionSchleifenwert),
                                                                                            LinksRechtsExtern => False);
               
               AchsenSchleife:
               for AchsenSchleifenwert in 0 .. 3 loop
                                 
                  Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KartenformauswahlAccess (Schleifenanpassung (PositionSchleifenwert) + AchsenSchleifenwert),
                                                position => Rechenwert);
                  
               end loop AchsenSchleife;
         
               InteraktionAuswahl.PositionenMenüeinträge (MenueDatentypen.Kartenform_Menü_Enum, PositionSchleifenwert - Überschrift)
                 := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.KartenformauswahlAccess (Schleifenanpassung (PositionSchleifenwert)));
               
            when others =>
               Fehler.GrafikFehler (FehlermeldungExtern => "AuswahlMenueKartenformSFML.SchriftpositionFestlegen - Schleife loopt falsch.");
         end case;
         
         Rechenwert.y := Rechenwert.y + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.KartenformauswahlAccess (Überschrift)).height + ZeilenAbstand;
         
      end loop PositionenSchleife;
      
      Rechenwert.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern => TextaccessVariablen.KartenformauswahlAccess (8),
                                                                                   LinksRechtsExtern => True);
                           
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KartenformauswahlAccess (8),
                                    position => Rechenwert);
      
      InteraktionAuswahl.PositionenMenüeinträge (MenueDatentypen.Kartenform_Menü_Enum, 8 - Überschrift) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.KartenformauswahlAccess (8));
               
      Rechenwert.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern => TextaccessVariablen.KartenformauswahlAccess (9),
                                                                                   LinksRechtsExtern => False);
               
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KartenformauswahlAccess (9),
                                    position => Rechenwert);
      
      InteraktionAuswahl.PositionenMenüeinträge (MenueDatentypen.Kartenform_Menü_Enum, 9 - Überschrift) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.KartenformauswahlAccess (9));
            
      --------------------- Scheint noch nicht hoch genug zu sein.
      Rechenwert.y := Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y)
        - Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.KartenformauswahlAccess (TextaccessVariablen.KartenformauswahlAccessArray'Last)).height
        - Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y / 100);
      Rechenwert.x := AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextaccessVariablen.KartenformauswahlAccess (TextaccessVariablen.KartenformauswahlAccessArray'Last));
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KartenformauswahlAccess (TextaccessVariablen.KartenformauswahlAccessArray'Last),
                                    position => Rechenwert);
      
      return True;
      
   end SchriftpositionFestlegen;

end AuswahlMenueKartenformSFML;
