pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf;
with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with SonstigesKonstanten;
with MenueDatentypen;
with SystemKonstanten;

with GrafikEinstellungenSFML;
with TextberechnungenBreiteSFML;
with InteraktionAuswahl;
with AuswahlMenuesStringsSetzen;
with Fehler;
with AuswahlMenuesZusatztextSFML;
with KartengeneratorVariablen;
with TextberechnungenHoeheSFML;
with TexteinstellungenSFML;
with NachGrafiktask;

package body AuswahlMenueKartenformSFML is

   -- Für Überarbeitungen siehe auch das gespeicherte Kartenformmerkblatt.
   function AuswahlMenüKartenform
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
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
                                                  text         => TextaccessVariablen.KartenformauswahlAccess (WelcheFormEins (KartengeneratorVariablen.Kartenparameter.Kartenform.EAchseOben)));
               
            when 3 =>
               Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                  text         => TextaccessVariablen.KartenformauswahlAccess (WelcheFormZwei (KartengeneratorVariablen.Kartenparameter.Kartenform.EAchseUnten)));
               
            when 4 =>
               Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                  text         => TextaccessVariablen.KartenformauswahlAccess (WelcheFormEins (KartengeneratorVariablen.Kartenparameter.Kartenform.YAchseNorden)));
               
            when 5 =>
               Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                  text         => TextaccessVariablen.KartenformauswahlAccess (WelcheFormZwei (KartengeneratorVariablen.Kartenparameter.Kartenform.YAchseSüden)));
               
            when 6 =>
               Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                  text         => TextaccessVariablen.KartenformauswahlAccess (WelcheFormEins (KartengeneratorVariablen.Kartenparameter.Kartenform.XAchseWesten)));
               
            when 7 =>
               Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                  text         => TextaccessVariablen.KartenformauswahlAccess (WelcheFormZwei (KartengeneratorVariablen.Kartenparameter.Kartenform.XAchseOsten)));
               
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
            Textposition := AuswahlMenuesZusatztextSFML.MenüsZusatztextAufteilung (WelchesMenüExtern     => MenueDatentypen.Kartenform_Menü_Enum,
                                                                                   AktuelleAuswahlExtern => AktuelleAuswahlRückgabewert,
                                                                                   ViewflächeExtern      => (0.00, 0.00),
                                                                                   TextpositionExtern    => (0.00, 0.00));
      end case;
      
      return ViewflächeExtern;
      
   end AuswahlMenüKartenform;
   
   
   
   function Textbearbeitung
     return Natural
   is begin
      
      AktuelleAuswahl := NachGrafiktask.AktuelleAuswahl;
      
      FarbeAktuelleAuswahlFestlegen (AktuelleAuswahlExtern => AktuelleAuswahl);
      
      TextEinlesen;
      SchriftpositionFestlegen;
      
      return AktuelleAuswahl;
      
   end Textbearbeitung;
   
   
   
   procedure FarbeAktuelleAuswahlFestlegen
     (AktuelleAuswahlExtern : in Natural)
   is begin
      
      FarbenSchleife:
      for FarbenSchleifenwert in TextaccessVariablen.KartenformauswahlAccess'Range loop
         
         case
           FarbenSchleifenwert
         is
            when 1 =>
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KartenformauswahlAccess (FarbenSchleifenwert),
                                          color => TexteinstellungenSFML.Schriftfarben.FarbeÜberschrift);
               
            when 2 .. 9 =>
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KartenformauswahlAccess (FarbenSchleifenwert),
                                          color => TexteinstellungenSFML.Schriftfarben.FarbeStandardText);
               
            when 10 .. 29 =>
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KartenformauswahlAccess (FarbenSchleifenwert),
                                          color => TexteinstellungenSFML.Schriftfarben.FarbeMenschText);
               
            when others =>
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KartenformauswahlAccess (FarbenSchleifenwert),
                                          color => TexteinstellungenSFML.Schriftfarben.FarbeSonstigerText);
         end case;
         
      end loop FarbenSchleife;
      
      case
        AktuelleAuswahlExtern
      is
         when SystemKonstanten.LeerAuswahl =>
            null;
            
            -- AktuelleAuswahl direkt die Werte 1/3 draufrechnen? Dann könnten diese Schleifen auch raus. äöü
         when 1 .. 2 =>
            EbeneSchleife:
            for EbeneSchleifenwert in 0 .. 1 loop
                                 
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KartenformauswahlAccess (Schleifenanpassung (AktuelleAuswahlExtern + Überschrift) + EbeneSchleifenwert),
                                          color => TexteinstellungenSFML.Schriftfarben.FarbeAusgewähltText);
                  
            end loop EbeneSchleife;
            
         when 3 .. 6 =>
            AchsenSchleife:
            for AchsenSchleifenwert in 0 .. 3 loop
                                 
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KartenformauswahlAccess (Schleifenanpassung (AktuelleAuswahlExtern + Überschrift) + AchsenSchleifenwert),
                                          color => TexteinstellungenSFML.Schriftfarben.FarbeAusgewähltText);
                  
            end loop AchsenSchleife;
            
         when others =>
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KartenformauswahlAccess (AktuelleAuswahlExtern + Überschrift),
                                       color => TexteinstellungenSFML.Schriftfarben.FarbeAusgewähltText);
      end case;
      
   end FarbeAktuelleAuswahlFestlegen;
   
   
   
   procedure TextEinlesen
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
      
   end TextEinlesen;
   
   
   
   procedure SchriftpositionFestlegen
   is begin
            
      Textposition.y := GrafikEinstellungenSFML.AktuelleFensterAuflösung.y / 100.00;
      
      Textposition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.KartenformauswahlAccess (Überschrift),
                                                                            ViewbreiteExtern => GrafikEinstellungenSFML.AktuelleFensterAuflösung.x);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KartenformauswahlAccess (Überschrift),
                                    position => Textposition);
      
      Textposition.y := Textposition.y + TextberechnungenHoeheSFML.Überschriftabstand;
      
      PositionenSchleife:
      for PositionSchleifenwert in TextaccessVariablen.KartenformauswahlAccessArray'First + Überschrift .. 7 loop
         
         case
           PositionSchleifenwert
         is
            when 2 .. 3 =>
               Textposition.x := TextberechnungenBreiteSFML.ViertelpositionBerechnen (TextAccessExtern => TextaccessVariablen.KartenformauswahlAccess (PositionSchleifenwert),
                                                                                      LinksRechtsExtern => True);
                           
               Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KartenformauswahlAccess (PositionSchleifenwert),
                                             position => Textposition);
               
               Textposition.x := TextberechnungenBreiteSFML.ViertelpositionBerechnen (TextAccessExtern => TextaccessVariablen.KartenformauswahlAccess (PositionSchleifenwert),
                                                                                      LinksRechtsExtern => False);
               
               EbeneSchleife:
               for EbeneSchleifenwert in 0 .. 1 loop
                                 
                  Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KartenformauswahlAccess (Schleifenanpassung (PositionSchleifenwert) + EbeneSchleifenwert),
                                                position => Textposition);
                  
               end loop EbeneSchleife;
         
               InteraktionAuswahl.PositionenMenüeinträge (MenueDatentypen.Kartenform_Menü_Enum, PositionSchleifenwert - Überschrift)
                 := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.KartenformauswahlAccess (Schleifenanpassung (PositionSchleifenwert)));
               
            when 4 .. 7 =>
               Textposition.x := TextberechnungenBreiteSFML.ViertelpositionBerechnen (TextAccessExtern => TextaccessVariablen.KartenformauswahlAccess (PositionSchleifenwert),
                                                                                      LinksRechtsExtern => True);
                           
               Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KartenformauswahlAccess (PositionSchleifenwert),
                                             position => Textposition);
               
               Textposition.x := TextberechnungenBreiteSFML.ViertelpositionBerechnen (TextAccessExtern => TextaccessVariablen.KartenformauswahlAccess (PositionSchleifenwert),
                                                                                      LinksRechtsExtern => False);
               
               AchsenSchleife:
               for AchsenSchleifenwert in 0 .. 3 loop
                                 
                  Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KartenformauswahlAccess (Schleifenanpassung (PositionSchleifenwert) + AchsenSchleifenwert),
                                                position => Textposition);
                  
               end loop AchsenSchleife;
         
               InteraktionAuswahl.PositionenMenüeinträge (MenueDatentypen.Kartenform_Menü_Enum, PositionSchleifenwert - Überschrift)
                 := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.KartenformauswahlAccess (Schleifenanpassung (PositionSchleifenwert)));
               
            when others =>
               Fehler.GrafikFehler (FehlermeldungExtern => "AuswahlMenueKartenformSFML.SchriftpositionFestlegen - Schleife loopt falsch.");
         end case;
         
         Textposition.y := Textposition.y + TextberechnungenHoeheSFML.Zeilenabstand;
         
      end loop PositionenSchleife;
      
      Textposition.x := TextberechnungenBreiteSFML.ViertelpositionBerechnen (TextAccessExtern => TextaccessVariablen.KartenformauswahlAccess (8),
                                                                             LinksRechtsExtern => True);
                           
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KartenformauswahlAccess (8),
                                    position => Textposition);
      
      InteraktionAuswahl.PositionenMenüeinträge (MenueDatentypen.Kartenform_Menü_Enum, 8 - Überschrift) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.KartenformauswahlAccess (8));
               
      Textposition.x := TextberechnungenBreiteSFML.ViertelpositionBerechnen (TextAccessExtern => TextaccessVariablen.KartenformauswahlAccess (9),
                                                                             LinksRechtsExtern => False);
               
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KartenformauswahlAccess (9),
                                    position => Textposition);
      
      InteraktionAuswahl.PositionenMenüeinträge (MenueDatentypen.Kartenform_Menü_Enum, 9 - Überschrift) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.KartenformauswahlAccess (9));
            
      Textposition.y := GrafikEinstellungenSFML.AktuelleFensterAuflösung.y - TextberechnungenHoeheSFML.KleinerZeilenabstand;
      Textposition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.KartenformauswahlAccess (TextaccessVariablen.KartenformauswahlAccessArray'Last),
                                                                            ViewbreiteExtern => GrafikEinstellungenSFML.AktuelleFensterAuflösung.x);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KartenformauswahlAccess (TextaccessVariablen.KartenformauswahlAccessArray'Last),
                                    position => Textposition);
      
   end SchriftpositionFestlegen;

end AuswahlMenueKartenformSFML;
