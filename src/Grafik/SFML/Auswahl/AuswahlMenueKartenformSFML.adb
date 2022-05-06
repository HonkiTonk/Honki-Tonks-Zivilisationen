pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf; use Sf;
with Sf.Graphics.RenderWindow;

with SonstigesKonstanten;

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

   -- Für den Fall einer Überarbeitung siehe auch das gespeicherte Kartenformmerkblatt.
   procedure AuswahlMenüKartenform
   is begin
              
      MenueHintergrundSFML.MenüHintergrund (WelchesMenüExtern  => MenueDatentypen.Kartenform_Menü_Enum,
                                            SpriteAccessExtern => SpriteAccess);
      
      AktuelleAuswahlRückgabewert := Textbearbeitung;
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess (Überschrift));
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess (TextAccess'Last));
      
      PositionenSchleife:
      for PositionSchleifenwert in TextAccessArray'First + Überschrift .. 10 loop
               
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextAccess (PositionSchleifenwert));
         
         case
           PositionSchleifenwert
         is
            when 2 =>
               Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                  text         => TextAccess (WelcheFormEins (Karten.Kartenparameter.Kartenform.EAchseOben)));
               
            when 3 =>
               Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                  text         => TextAccess (WelcheFormZwei (Karten.Kartenparameter.Kartenform.EAchseUnten)));
               
            when 4 =>
               Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                  text         => TextAccess (WelcheFormEins (Karten.Kartenparameter.Kartenform.YAchseNorden)));
               
            when 5 =>
               Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                  text         => TextAccess (WelcheFormZwei (Karten.Kartenparameter.Kartenform.YAchseSüden)));
               
            when 6 =>
               Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                  text         => TextAccess (WelcheFormEins (Karten.Kartenparameter.Kartenform.XAchseWesten)));
               
            when 7 =>
               Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                  text         => TextAccess (WelcheFormZwei (Karten.Kartenparameter.Kartenform.XAchseOsten)));
               
            when 8 =>
               if
                 Karten.Kartenparameter.Kartenform.YZuerstBerechnenXZuerstBerechnen = True
               then
                  Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                     text         => TextAccess (31));
                  
               else
                  Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                     text         => TextAccess (32));
               end if;
               
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
      
      case
        SchriftartFestgelegt
      is
         when False =>
            SchriftartFestgelegt := SchriftartFestlegen;
            
         when True =>
            null;
      end case;
      
      case
        SchriftfarbeFestgelegt
      is
         when False =>
            SchriftfarbeFestgelegt := SchriftfarbenFestlegen;
            
         when True =>
            null;
      end case;
      
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
        SchriftgrößeFestgelegt
      is
         when False =>
            SchriftgrößeFestgelegt := SchriftgrößeFestlegen;
            
         when True =>
            null;
      end case;
      
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
   
   
   
   function SchriftartFestlegen
     return Boolean
   is begin
      
      FontSchleife:
      for FontSchleifenwert in TextAccessArray'Range loop
            
         Sf.Graphics.Text.setFont (text => TextAccess (FontSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
            
      end loop FontSchleife;
            
      return True;
      
   end SchriftartFestlegen;



   function SchriftfarbenFestlegen
     return Boolean
   is begin
      
      Sf.Graphics.Text.setColor (text  => TextAccess (Überschrift),
                                 color => GrafikEinstellungenSFML.Schriftfarben.FarbeÜberschrift);
      
      ------------------------ Die Einstellposition blau einfärben.
      SchriftfarbeSchleife:
      for SchriftfarbeSchleifenwert in TextAccessArray'First + Überschrift .. TextAccessArray'Last - Versionsnummer loop
         
         case
           SchriftfarbeSchleifenwert
         is
            when 11 .. 32 =>
               Sf.Graphics.Text.setColor (text  => TextAccess (SchriftfarbeSchleifenwert),
                                          color => GrafikEinstellungenSFML.Schriftfarben.FarbeMenschText);
               
            when others =>
               Sf.Graphics.Text.setColor (text  => TextAccess (SchriftfarbeSchleifenwert),
                                          color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
         end case;
         
      end loop SchriftfarbeSchleife;
      
      Sf.Graphics.Text.setColor (text  => TextAccess (TextAccessArray'Last),
                                 color => GrafikEinstellungenSFML.Schriftfarben.FarbeSonstigerText);
      
      return True;

   end SchriftfarbenFestlegen;
   
   
   
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
                                 
               Sf.Graphics.Text.setColor (text  => TextAccess (Schleifenanpassung (LetzteAuswahlExtern + Überschrift) + EbeneSchleifenwert),
                                          color => GrafikEinstellungenSFML.Schriftfarben.FarbeMenschText);
                  
            end loop EbeneSchleife;
            
         when 3 .. 6 =>
            AchsenSchleife:
            for AchsenSchleifenwert in 0 .. 3 loop
                                 
               Sf.Graphics.Text.setColor (text  => TextAccess (Schleifenanpassung (LetzteAuswahlExtern + Überschrift) + AchsenSchleifenwert),
                                          color => GrafikEinstellungenSFML.Schriftfarben.FarbeMenschText);
                  
            end loop AchsenSchleife;
            
         when 7 =>
            ErsteAchseSchleife:
            for ErsteAchseSchleifenwert in 0 .. 1 loop
                                 
               Sf.Graphics.Text.setColor (text  => TextAccess (Schleifenanpassung (LetzteAuswahlExtern + Überschrift) + ErsteAchseSchleifenwert),
                                          color => GrafikEinstellungenSFML.Schriftfarben.FarbeMenschText);
                  
            end loop ErsteAchseSchleife;

         when others =>
            Sf.Graphics.Text.setColor (text  => TextAccess (LetzteAuswahlExtern + Überschrift),
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
                                 
               Sf.Graphics.Text.setColor (text  => TextAccess (Schleifenanpassung (AktuelleAuswahlExtern + Überschrift) + EbeneSchleifenwert),
                                          color => GrafikEinstellungenSFML.Schriftfarben.FarbeAusgewähltText);
                  
            end loop AEbeneSchleife;
            
         when 3 .. 6 =>
            AAchsenSchleife:
            for AchsenSchleifenwert in 0 .. 3 loop
                                 
               Sf.Graphics.Text.setColor (text  => TextAccess (Schleifenanpassung (AktuelleAuswahlExtern + Überschrift) + AchsenSchleifenwert),
                                          color => GrafikEinstellungenSFML.Schriftfarben.FarbeAusgewähltText);
                  
            end loop AAchsenSchleife;
            
         when 7 =>
            AErsteAchseSchleife:
            for ErsteAchseSchleifenwert in 0 .. 1 loop
                                 
               Sf.Graphics.Text.setColor (text  => TextAccess (Schleifenanpassung (AktuelleAuswahlExtern + Überschrift) + ErsteAchseSchleifenwert),
                                          color => GrafikEinstellungenSFML.Schriftfarben.FarbeAusgewähltText);
                  
            end loop AErsteAchseSchleife;
            
         when others =>
            Sf.Graphics.Text.setColor (text  => TextAccess (AktuelleAuswahlExtern + Überschrift),
                                       color => GrafikEinstellungenSFML.Schriftfarben.FarbeAusgewähltText);
      end case;
      
   end FarbeAktuelleAuswahlFestlegen;
   
   
   
   function SchriftgrößeFestlegen
     return Boolean
   is begin
      
      Sf.Graphics.Text.setCharacterSize (text => TextAccess (Überschrift),
                                         size => Sf.sfUint32 (1.50 * Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße)));
      
      SchriftgrößeSchleife:
      for SchriftgrößeSchleifenwert in TextAccessArray'First + Überschrift .. TextAccessArray'Last - Versionsnummer loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextAccess (SchriftgrößeSchleifenwert),
                                            size => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
         
      end loop SchriftgrößeSchleife;
      
      Sf.Graphics.Text.setCharacterSize (text => TextAccess (TextAccessArray'Last),
                                         size => Sf.sfUint32 (0.50 * Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße)));
      
      return True;
      
   end SchriftgrößeFestlegen;
   
   
   
   function TextEinlesen
     return Boolean
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess (Überschrift),
                                         str  => AuswahlMenuesStringsSetzen.AuswahlMenüStringSetzen (WelcheZeileExtern => Überschrift,
                                                                                                      WelchesMenüExtern => MenueDatentypen.Kartenform_Menü_Enum));
      
      TextSchleife:
      for TextSchleifenwert in TextAccessArray'First + Überschrift .. Schleifenanpassung (2) - 1 loop
                  
         Sf.Graphics.Text.setUnicodeString (text => TextAccess (TextSchleifenwert),
                                            str  => AuswahlMenuesStringsSetzen.AuswahlMenüStringSetzen (WelcheZeileExtern => TextSchleifenwert,
                                                                                                         WelchesMenüExtern => MenueDatentypen.Kartenform_Menü_Enum));
         
      end loop TextSchleife;
      
      MehrfachTextSchleife:
      for MehrfachTextSchleifenwert in Schleifenanpassung (2) .. TextAccessArray'Last - Versionsnummer loop
         
         case
           MehrfachTextSchleifenwert
         is
            when 11 | 13 | 15 | 19 | 23 | 27 =>
               Sf.Graphics.Text.setUnicodeString (text => TextAccess (MehrfachTextSchleifenwert),
                                                  str  => AuswahlMenuesStringsSetzen.AuswahlMenüStringSetzen (WelcheZeileExtern => 11,
                                                                                                               WelchesMenüExtern => MenueDatentypen.Kartenform_Menü_Enum));
               
            when 12 | 14 | 16 | 20 | 24 | 28 =>
               Sf.Graphics.Text.setUnicodeString (text => TextAccess (MehrfachTextSchleifenwert),
                                                  str  => AuswahlMenuesStringsSetzen.AuswahlMenüStringSetzen (WelcheZeileExtern => 12,
                                                                                                               WelchesMenüExtern => MenueDatentypen.Kartenform_Menü_Enum));
               
            when 17 | 21 | 25 | 29 =>
               Sf.Graphics.Text.setUnicodeString (text => TextAccess (MehrfachTextSchleifenwert),
                                                  str  => AuswahlMenuesStringsSetzen.AuswahlMenüStringSetzen (WelcheZeileExtern => 13,
                                                                                                               WelchesMenüExtern => MenueDatentypen.Kartenform_Menü_Enum));
               
            when 18 | 22 | 26 | 30 =>
               Sf.Graphics.Text.setUnicodeString (text => TextAccess (MehrfachTextSchleifenwert),
                                                  str  => AuswahlMenuesStringsSetzen.AuswahlMenüStringSetzen (WelcheZeileExtern => 14,
                                                                                                               WelchesMenüExtern => MenueDatentypen.Kartenform_Menü_Enum));
               
            when 31 =>
               Sf.Graphics.Text.setUnicodeString (text => TextAccess (MehrfachTextSchleifenwert),
                                                  str  => AuswahlMenuesStringsSetzen.AuswahlMenüStringSetzen (WelcheZeileExtern => 15,
                                                                                                               WelchesMenüExtern => MenueDatentypen.Kartenform_Menü_Enum));
               
            when 32 =>
               Sf.Graphics.Text.setUnicodeString (text => TextAccess (MehrfachTextSchleifenwert),
                                                  str  => AuswahlMenuesStringsSetzen.AuswahlMenüStringSetzen (WelcheZeileExtern => 16,
                                                                                                               WelchesMenüExtern => MenueDatentypen.Kartenform_Menü_Enum));
               
            when others =>
               Fehler.GrafikFehler (FehlermeldungExtern => "AuswahlMenuesKomplexSFML.TextEinlesen - Schleife loopt falsch.");
         end case;
               
               
      end loop MehrfachTextSchleife;
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess (TextAccessArray'Last),
                                         str  => "Version: " & SonstigesKonstanten.Versionsnummer);
      
      return True;
      
   end TextEinlesen;
   
   
   
   function SchriftpositionFestlegen
     return Boolean
   is begin
      
      ZeilenAbstand := 0.50 * Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
      
      Rechenwert.y := Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y / 100);
      
      if
        Rechenwert.y < 20.00
      then
         Rechenwert.y := 20.00;
         
      else
         null;
      end if;
      
      Rechenwert.x := AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextAccess (Überschrift));
      
      Sf.Graphics.Text.setPosition (text     => TextAccess (Überschrift),
                                    position => Rechenwert);
      
      Rechenwert.y := Rechenwert.y + 3.00 * Sf.Graphics.Text.getLocalBounds (text => TextAccess (Überschrift)).height + ZeilenAbstand;
      
      PositionenSchleife:
      for PositionSchleifenwert in TextAccessArray'First + Überschrift .. 8 loop
         
         case
           PositionSchleifenwert
         is
            when 2 .. 3 =>
               Rechenwert.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern => TextAccess (PositionSchleifenwert),
                                                                                            LinksRechtsExtern => True);
                           
               Sf.Graphics.Text.setPosition (text     => TextAccess (PositionSchleifenwert),
                                             position => Rechenwert);
               
               Rechenwert.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern => TextAccess (PositionSchleifenwert),
                                                                                            LinksRechtsExtern => False);
               
               EbeneSchleife:
               for EbeneSchleifenwert in 0 .. 1 loop
                                 
                  Sf.Graphics.Text.setPosition (text     => TextAccess (Schleifenanpassung (PositionSchleifenwert) + EbeneSchleifenwert),
                                                position => Rechenwert);
                  
               end loop EbeneSchleife;
         
               InteraktionAuswahl.PositionenMenüeinträge (MenueDatentypen.Kartenform_Menü_Enum, PositionSchleifenwert - Überschrift)
                 := Sf.Graphics.Text.getGlobalBounds (text => TextAccess (Schleifenanpassung (PositionSchleifenwert)));
               
            when 4 .. 7 =>
               Rechenwert.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern => TextAccess (PositionSchleifenwert),
                                                                                            LinksRechtsExtern => True);
                           
               Sf.Graphics.Text.setPosition (text     => TextAccess (PositionSchleifenwert),
                                             position => Rechenwert);
               
               Rechenwert.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern => TextAccess (PositionSchleifenwert),
                                                                                            LinksRechtsExtern => False);
               
               AchsenSchleife:
               for AchsenSchleifenwert in 0 .. 3 loop
                                 
                  Sf.Graphics.Text.setPosition (text     => TextAccess (Schleifenanpassung (PositionSchleifenwert) + AchsenSchleifenwert),
                                                position => Rechenwert);
                  
               end loop AchsenSchleife;
         
               InteraktionAuswahl.PositionenMenüeinträge (MenueDatentypen.Kartenform_Menü_Enum, PositionSchleifenwert - Überschrift)
                 := Sf.Graphics.Text.getGlobalBounds (text => TextAccess (Schleifenanpassung (PositionSchleifenwert)));
               
            when 8 =>
               Rechenwert.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern => TextAccess (PositionSchleifenwert),
                                                                                            LinksRechtsExtern => True);
                           
               Sf.Graphics.Text.setPosition (text     => TextAccess (PositionSchleifenwert),
                                             position => Rechenwert);
               
               Rechenwert.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern => TextAccess (PositionSchleifenwert),
                                                                                            LinksRechtsExtern => False);
               
               ErsteAchseSchleife:
               for ErsteAchseSchleifenwert in 0 .. 1 loop
                                 
                  Sf.Graphics.Text.setPosition (text     => TextAccess (Schleifenanpassung (PositionSchleifenwert) + ErsteAchseSchleifenwert),
                                                position => Rechenwert);
                  
               end loop ErsteAchseSchleife;
         
               InteraktionAuswahl.PositionenMenüeinträge (MenueDatentypen.Kartenform_Menü_Enum, PositionSchleifenwert - Überschrift)
                 := Sf.Graphics.Text.getGlobalBounds (text => TextAccess (Schleifenanpassung (PositionSchleifenwert)));
               
            when others =>
               Fehler.GrafikFehler (FehlermeldungExtern => "AuswahlMenuesKomplexSFML.SchriftpositionFestlegen - Schleife loopt falsch.");
         end case;
         
         Rechenwert.y := Rechenwert.y + Sf.Graphics.Text.getLocalBounds (text => TextAccess (Überschrift)).height + ZeilenAbstand;
         
      end loop PositionenSchleife;
      
      Rechenwert.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern => TextAccess (9),
                                                                                   LinksRechtsExtern => True);
                           
      Sf.Graphics.Text.setPosition (text     => TextAccess (9),
                                    position => Rechenwert);
      
      InteraktionAuswahl.PositionenMenüeinträge (MenueDatentypen.Kartenform_Menü_Enum, 9 - Überschrift) := Sf.Graphics.Text.getGlobalBounds (text => TextAccess (9));
               
      Rechenwert.x := AllgemeineTextBerechnungenSFML.TextViertelPositionErmitteln (TextAccessExtern => TextAccess (10),
                                                                                   LinksRechtsExtern => False);
               
      Sf.Graphics.Text.setPosition (text     => TextAccess (10),
                                    position => Rechenwert);
      
      InteraktionAuswahl.PositionenMenüeinträge (MenueDatentypen.Kartenform_Menü_Enum, 10 - Überschrift) := Sf.Graphics.Text.getGlobalBounds (text => TextAccess (10));
            
      --------------------- Scheint noch nicht hoch genug zu sein.
      Rechenwert.y := Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y) - Sf.Graphics.Text.getLocalBounds (text => TextAccess (TextAccessArray'Last)).height
        - Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y / 100);
      Rechenwert.x := AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextAccess (TextAccessArray'Last));
      
      Sf.Graphics.Text.setPosition (text     => TextAccess (TextAccessArray'Last),
                                    position => Rechenwert);
      
      return True;
      
   end SchriftpositionFestlegen;

end AuswahlMenueKartenformSFML;
