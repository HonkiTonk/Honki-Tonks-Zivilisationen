pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf; use Sf;
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
with AuswahlMenuesEinfach;
with HintergrundSFML;
with AuswahlMenuesZusatztextSFML;
with KartengeneratorVariablen;
with TextberechnungenHoeheSFML;

package body AuswahlMenueKartenformSFML is

   -- Für Überarbeitungen siehe auch das gespeicherte Kartenformmerkblatt.
   procedure AuswahlMenüKartenform
   is begin
              
      HintergrundSFML.MenüHintergrund (WelchesMenüExtern  => MenueDatentypen.Kartenform_Menü_Enum);
      
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
            AuswahlMenuesZusatztextSFML.MenüsZusatztextAufteilung (WelchesMenüExtern     => MenueDatentypen.Kartenform_Menü_Enum,
                                                                    AktuelleAuswahlExtern => AktuelleAuswahlRückgabewert);
      end case;
      
   end AuswahlMenüKartenform;
   
   
   
   function Textbearbeitung
     return Natural
   is begin
      
      -- Auch mal NachGrafiktask umlagern. äöü
      AktuelleAuswahl := AuswahlMenuesEinfach.AktuelleAuswahl;
      
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
                                          color => GrafikEinstellungenSFML.Schriftfarben.FarbeÜberschrift);
               
            when 2 .. 9 =>
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KartenformauswahlAccess (FarbenSchleifenwert),
                                          color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
               
            when 10 .. 29 =>
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KartenformauswahlAccess (FarbenSchleifenwert),
                                          color => GrafikEinstellungenSFML.Schriftfarben.FarbeMenschText);
               
            when others =>
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KartenformauswahlAccess (FarbenSchleifenwert),
                                          color => GrafikEinstellungenSFML.Schriftfarben.FarbeSonstigerText);
         end case;
         
      end loop FarbenSchleife;
      
      case
        AktuelleAuswahlExtern
      is
         when SystemKonstanten.LeerAuswahl =>
            null;
            
            -- AktuelleAuswahl direkt die Werte 1/3 draufrechnen? Dann könnten diese Schleifen auch raus. äöü
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
            
      Textposition.y := Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y / 100);
      
      if
        Textposition.y < 20.00
      then
         Textposition.y := 20.00;
         
      else
         null;
      end if;
      
      Textposition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.KartenformauswahlAccess (Überschrift));
      
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
            
      Textposition.y := Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y) - TextberechnungenHoeheSFML.KleinerZeilenabstand;
      Textposition.x := TextberechnungenBreiteSFML.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.KartenformauswahlAccess (TextaccessVariablen.KartenformauswahlAccessArray'Last));
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KartenformauswahlAccess (TextaccessVariablen.KartenformauswahlAccessArray'Last),
                                    position => Textposition);
      
   end SchriftpositionFestlegen;

end AuswahlMenueKartenformSFML;
