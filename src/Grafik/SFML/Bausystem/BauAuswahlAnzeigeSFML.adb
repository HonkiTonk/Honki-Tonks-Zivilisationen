pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with TextKonstanten;
with GrafikDatentypen;
with GlobaleTexte;
with TextnummernKonstanten;
with TextaccessVariablen;

with LeseStadtGebaut;

with GrafikEinstellungenSFML;
with TextberechnungenBreiteSFML;
with InteraktionAuswahl;
with TextberechnungenHoeheSFML;
with GebaeudebeschreibungenSFML;
with EinheitenbeschreibungenSFML;
with HintergrundSFML;
with TexteinstellungenSFML;
with ViewsEinstellenSFML;
with UeberschriftviewSFML;
with BeschreibungenZeilenumbruchSFML;

package body BauAuswahlAnzeigeSFML is

   procedure BauAuswahlAnzeige
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      AktuelleAuswahlExtern : in StadtRecords.BauprojektRecord)
   is begin
      
      UeberschriftviewSFML.Überschrift (ÜberschriftExtern => To_Wide_Wide_String (Source => GlobaleTexte.Frage (TextnummernKonstanten.FrageBauprojekt)),
                                         HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum);
      
      Gebäude (AuswahlExtern    => AktuelleAuswahlExtern.Gebäude,
                ViewnummerExtern => 1);
      Einheiten (AuswahlExtern    => AktuelleAuswahlExtern.Einheit,
                 ViewnummerExtern => 2);
      InformationenGebäude (AuswahlExtern    => AktuelleAuswahlExtern.Gebäude,
                            ViewnummerExtern => 3);
      InformationenEinheiten (AuswahlExtern    => AktuelleAuswahlExtern.Einheit,
                              ViewnummerExtern => 4);
      Aktuell (StadtRasseNummerExtern => StadtRasseNummerExtern,
               ViewnummerExtern       => 5);
      
   end BauAuswahlAnzeige;
   
   
   
   procedure Gebäude
     (AuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      ViewnummerExtern : in Positive)
   is begin
      
      Viewfläche (ViewnummerExtern) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                         VerhältnisExtern => (0.50, 1.00));
      Viewfläche (ViewnummerExtern) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                         VerhältnisExtern => (0.50, 1.00));
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => ViewsSFML.BauviewAccesse (ViewnummerExtern),
                                          GrößeExtern          => Viewfläche (ViewnummerExtern),
                                          AnzeigebereichExtern => Anzeigebereich (ViewnummerExtern));
      
      HintergrundSFML.MenüHintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                        AbmessungenExtern => Viewfläche (ViewnummerExtern));
      
      TextPosition := TextKonstanten.StartpositionText;
      TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
      TextPosition.x := Viewfläche (ViewnummerExtern).x / 2.00 - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.GebäudetextAccess (TextaccessVariablen.GebäudetextAccess'First));

      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.GebäudetextAccess (TextaccessVariablen.GebäudetextAccess'First),
                                    position => TextPosition);
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.GebäudetextAccess (TextaccessVariablen.GebäudetextAccess'First),
                                 color => Farbe);
         
      TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.Zeilenabstand;
               
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.GebäudetextAccess (TextaccessVariablen.GebäudetextAccess'First));
      
      -- Darf nicht auch 0.00 gesetzt werden, da es sonst zu Abstürzen kommt wenn alle technologien erforscht wurden.äöü
      -- Später eine bessere Lösung bauen. äöü
      AktuelleTextbreite := 0.01;
      AktuelleTextbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.GebäudetextAccess (TextaccessVariablen.GebäudetextAccess'First),
                                                                                TextbreiteExtern => AktuelleTextbreite);
      TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
            
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
         
         case
           InteraktionAuswahl.MöglicheGebäude (GebäudeSchleifenwert)
         is
            when True =>
               if
                 AuswahlExtern = GebäudeSchleifenwert
               then
                  Farbe := TexteinstellungenSFML.Schriftfarben.FarbeAusgewähltText;
            
               else
                  Farbe := TexteinstellungenSFML.Schriftfarben.FarbeStandardText;
               end if;
               
               TextPosition.x := Viewfläche (ViewnummerExtern).x / 2.00 - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.GebäudetextAccess (GebäudeSchleifenwert));

               Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.GebäudetextAccess (GebäudeSchleifenwert),
                                             position => TextPosition);
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.GebäudetextAccess (GebäudeSchleifenwert),
                                          color => Farbe);
         
               TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.Zeilenabstand;
               
               AktuelleTextbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.GebäudetextAccess (GebäudeSchleifenwert),
                                                                                         TextbreiteExtern => AktuelleTextbreite);
               
               InteraktionAuswahl.PositionenGebäudeBauen (GebäudeSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.GebäudetextAccess (GebäudeSchleifenwert));
               
               Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                  text         => TextaccessVariablen.GebäudetextAccess (GebäudeSchleifenwert));

            when False =>
               null;
         end case;
               
      end loop GebäudeSchleife;
      
      Viewfläche (ViewnummerExtern) := (AktuelleTextbreite, TextPosition.y);
      
   end Gebäude;
   
   
   
   procedure Einheiten
     (AuswahlExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      ViewnummerExtern : in Positive)
   is begin
      
      Viewfläche (ViewnummerExtern) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                         VerhältnisExtern => (0.50, 1.00));
      Viewfläche (ViewnummerExtern) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                         VerhältnisExtern => (0.50, 1.00));
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => ViewsSFML.BauviewAccesse (ViewnummerExtern),
                                          GrößeExtern          => Viewfläche (ViewnummerExtern),
                                          AnzeigebereichExtern => Anzeigebereich (ViewnummerExtern));
      
      HintergrundSFML.MenüHintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                        AbmessungenExtern => Viewfläche (ViewnummerExtern));
      
      TextPosition := TextKonstanten.StartpositionText;
      TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
      TextPosition.x := Viewfläche (ViewnummerExtern).x / 2.00
        - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.EinheitentextAccess (TextaccessVariablen.EinheitentextAccess'First));

      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.EinheitentextAccess (TextaccessVariablen.EinheitentextAccess'First),
                                    position => TextPosition);
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.EinheitentextAccess (TextaccessVariablen.EinheitentextAccess'First),
                                 color => Farbe);
      
      TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.Zeilenabstand;
               
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.EinheitentextAccess (TextaccessVariablen.EinheitentextAccess'First));
      
      TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
      -- Darf nicht auch 0.00 gesetzt werden, da es sonst zu Abstürzen kommt wenn alle technologien erforscht wurden.äöü
      -- Später eine bessere Lösung bauen. äöü
      AktuelleTextbreite := 0.01;
      AktuelleTextbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.EinheitentextAccess (TextaccessVariablen.EinheitentextAccess'First),
                                                                                TextbreiteExtern => AktuelleTextbreite);
          
      EinheitenSchleife:
      for EinheitenSchleifenwert in EinheitenDatentypen.EinheitenID'Range loop
         
         case
           InteraktionAuswahl.MöglicheEinheiten (EinheitenSchleifenwert)
         is
            when True =>
               if
                 AuswahlExtern = EinheitenSchleifenwert
               then
                  Farbe := TexteinstellungenSFML.Schriftfarben.FarbeAusgewähltText;
            
               else
                  Farbe := TexteinstellungenSFML.Schriftfarben.FarbeStandardText;
               end if;
               
               TextPosition.x := Viewfläche (ViewnummerExtern).x / 2.00 - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.EinheitentextAccess (EinheitenSchleifenwert));

               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.EinheitentextAccess (EinheitenSchleifenwert),
                                          color => Farbe);
               Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.EinheitentextAccess (EinheitenSchleifenwert),
                                             position => TextPosition);
               
               TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.Zeilenabstand;
               
               AktuelleTextbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.EinheitentextAccess (EinheitenSchleifenwert),
                                                                                         TextbreiteExtern => AktuelleTextbreite);
               
               InteraktionAuswahl.PositionenEinheitenBauen (EinheitenSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.EinheitentextAccess (EinheitenSchleifenwert));
               
               Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                  text         => TextaccessVariablen.EinheitentextAccess (EinheitenSchleifenwert));

            when False =>
               null;
         end case;
         
      end loop EinheitenSchleife;
      
      Viewfläche (ViewnummerExtern) := (AktuelleTextbreite, TextPosition.y);
      
   end Einheiten;



   procedure InformationenGebäude
     (AuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      ViewnummerExtern : in Positive)
   is begin
      
      case
        AuswahlExtern
      is
         when 0 =>
            ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => ViewsSFML.BauviewAccesse (ViewnummerExtern),
                                                GrößeExtern          => Viewfläche (ViewnummerExtern),
                                                AnzeigebereichExtern => KeineAnzeige);
            return;
            
         when others =>
            Viewfläche (ViewnummerExtern) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                               VerhältnisExtern => (0.50, 1.00));
            Viewfläche (ViewnummerExtern) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                               VerhältnisExtern => (0.50, 1.00));
      
            ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => ViewsSFML.BauviewAccesse (ViewnummerExtern),
                                                GrößeExtern          => Viewfläche (ViewnummerExtern),
                                                AnzeigebereichExtern => Anzeigebereich (ViewnummerExtern));
      
            HintergrundSFML.MenüHintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                              AbmessungenExtern => Viewfläche (ViewnummerExtern));
      
            TextPosition := TextKonstanten.StartpositionText;
            TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.GebäudezusatztextAccess (AuswahlExtern),
                                          position => TextPosition);
      end case;
            
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.GebäudezusatztextAccess (AuswahlExtern),
                                         str  => BeschreibungenZeilenumbruchSFML.ZeilenumbruchBerechnen (TextExtern => GebaeudebeschreibungenSFML.BeschreibungLang (IDExtern => AuswahlExtern)));
         
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.GebäudezusatztextAccess (AuswahlExtern));
      
      AktuelleTextbreite := 0.01;
      AktuelleTextbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.GebäudezusatztextAccess (AuswahlExtern),
                                                                                TextbreiteExtern => AktuelleTextbreite);
      
      TextPosition.y := TextPosition.y + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.GebäudezusatztextAccess (AuswahlExtern)).height + TextberechnungenHoeheSFML.Zeilenabstand;
      
      Viewfläche (ViewnummerExtern) := (AktuelleTextbreite, TextPosition.y);
            
   end InformationenGebäude;



   procedure InformationenEinheiten
     (AuswahlExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      ViewnummerExtern : in Positive)
   is begin
      
      case
        AuswahlExtern
      is
         when 0 =>
            ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => ViewsSFML.BauviewAccesse (ViewnummerExtern),
                                                GrößeExtern          => Viewfläche (ViewnummerExtern),
                                                AnzeigebereichExtern => KeineAnzeige);
            return;
            
         when others =>
            Viewfläche (ViewnummerExtern) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                               VerhältnisExtern => (0.50, 1.00));
            Viewfläche (ViewnummerExtern) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                               VerhältnisExtern => (0.50, 1.00));
      
            ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => ViewsSFML.BauviewAccesse (ViewnummerExtern),
                                                GrößeExtern          => Viewfläche (ViewnummerExtern),
                                                AnzeigebereichExtern => Anzeigebereich (ViewnummerExtern));
      
            HintergrundSFML.MenüHintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                              AbmessungenExtern => Viewfläche (ViewnummerExtern));
            
            TextPosition := TextKonstanten.StartpositionText;
            TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
            
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.EinheitenzusatztextAccess (AuswahlExtern),
                                          position => TextPosition);
      end case;
            
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitenzusatztextAccess (AuswahlExtern),
                                         str  => BeschreibungenZeilenumbruchSFML.ZeilenumbruchBerechnen (TextExtern => EinheitenbeschreibungenSFML.BeschreibungLang (IDExtern => AuswahlExtern)));
         
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.EinheitenzusatztextAccess (AuswahlExtern));
      
      AktuelleTextbreite := 0.01;
      AktuelleTextbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.EinheitenzusatztextAccess (AuswahlExtern),
                                                                                TextbreiteExtern => AktuelleTextbreite);
      
      TextPosition.y := TextPosition.y + Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.EinheitenzusatztextAccess (AuswahlExtern)).height + TextberechnungenHoeheSFML.Zeilenabstand;
      
      Viewfläche (ViewnummerExtern) := (AktuelleTextbreite, TextPosition.y);
      
   end InformationenEinheiten;
   
   
   
   procedure Aktuell
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      ViewnummerExtern : in Positive)
   is begin
      
      -- Sieht auch ohne Anpassung ganz gut aus.
      -- Viewfläche (ViewnummerExtern) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
      --                                                                     VerhältnisExtern => (0.10, 0.10));
      --  Viewfläche (ViewnummerExtern) := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
      --                                                                      VerhältnisExtern => (0.10, 0.10));
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => ViewsSFML.BauviewAccesse (ViewnummerExtern),
                                          GrößeExtern          => Viewfläche (ViewnummerExtern),
                                          AnzeigebereichExtern => Anzeigebereich (ViewnummerExtern));
      
      HintergrundSFML.MenüHintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                        AbmessungenExtern => Viewfläche (ViewnummerExtern));
      
      TextPosition := TextKonstanten.StartpositionText;
      AktuelleTextbreite := 0.01;
      
      AktuellesBauprojekt := LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      if
        AktuellesBauprojekt.Gebäude /= 0
      then
         Text := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugBauprojekt) & " " & GebaeudebeschreibungenSFML.BeschreibungKurz (IDExtern => AktuellesBauprojekt.Gebäude);
         
      elsif
        AktuellesBauprojekt.Einheit /= 0
      then
         Text := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugBauprojekt) & " " & EinheitenbeschreibungenSFML.BeschreibungKurz (IDExtern => AktuellesBauprojekt.Einheit);
         
            
      else
         Text := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugBauprojekt) & " " & GlobaleTexte.Zeug (TextnummernKonstanten.ZeugKeines);
      end if;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                         str  => To_Wide_Wide_String (Source => Text));
      
      TextPosition.x := Viewfläche (ViewnummerExtern).x / 2.00 - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                    position => TextPosition);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.ForschungsmenüErmöglichtAccess);
      
      AktuelleTextbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                                TextbreiteExtern => AktuelleTextbreite);
      TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
      Text := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugVerbleibendeBauzeit) & LeseStadtGebaut.Bauzeit (StadtRasseNummerExtern => StadtRasseNummerExtern)'Wide_Wide_Image;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                         str  => To_Wide_Wide_String (Source => Text));
      
      TextPosition.x := Viewfläche (ViewnummerExtern).x / 2.00 - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                    position => TextPosition);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.ForschungsmenüErmöglichtAccess);
      
      AktuelleTextbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                                TextbreiteExtern => AktuelleTextbreite);
      TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
            
      Viewfläche (ViewnummerExtern) := (AktuelleTextbreite, TextPosition.y);
      
   end Aktuell;

end BauAuswahlAnzeigeSFML;
