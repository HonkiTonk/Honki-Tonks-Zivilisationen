pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with EinheitenDatentypen; use EinheitenDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with StadtDatentypen; use StadtDatentypen;
with Meldungstexte;
with TextnummernKonstanten;
with TextKonstanten;
with Views;
with KartenverbesserungDatentypen;
with GrafikDatentypen;

with LeseStadtGebaut;

with KampfwerteStadtErmittelnLogik;
with EinstellungenGrafik;
with TextberechnungenHoeheGrafik;
with HintergrundGrafik;
with ViewsEinstellenGrafik;
with GebaeudebeschreibungenGrafik;
with EinheitenbeschreibungenGrafik;
with TextberechnungenBreiteGrafik;

package body StadtseitenleisteGrafik is
   
   -- Das hier an das neue Viewsystem anpassen oder direkt durch ein besseres System ersetzen? äöü
   procedure Stadtinformationen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      Stadt (RasseExtern            => StadtRasseNummerExtern.Rasse,
             StadtRasseNummerExtern => StadtRasseNummerExtern,
             AnzeigebereichExtern   => GrafikRecordKonstanten.Stadtbereich (4),
             ViewExtern             => Views.StadtviewAccesse (4));
      
   end Stadtinformationen;
   
   
   
   -- Überall die Bereiche von außen hineingeben? Dann wäre mehr wiederverwendbar, wobei natürlich die Frage ist ob mir das was bringt. äöü
   procedure Leer
     (AnzeigebereichExtern : in Sf.Graphics.Rect.sfFloatRect;
      ViewExtern : in Sf.Graphics.sfView_Ptr)
   is begin
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => ViewExtern,
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => AnzeigebereichExtern);
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Seitenleiste_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);
      
   end Leer;
   
   

   procedure Stadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      AnzeigebereichExtern : in Sf.Graphics.Rect.sfFloatRect;
      ViewExtern : in Sf.Graphics.sfView_Ptr)
   is begin
                  
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (0.15, 0.05));
      
      Leer (AnzeigebereichExtern => AnzeigebereichExtern,
            ViewExtern           => ViewExtern);
      
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
      -- Allgemeine Stadtinformationen, nur sichtbar wenn das Kartenfeld aufgedeckt ist und sich dort eine Stadt befindet.
      -- Brauche ich den Stadtnamen überhaupt? Der wird ja auch drüber angezeigt. äöü
      Stadtname (StadtRasseNummerExtern => StadtRasseNummerExtern);
      Textbreite := 0.00;
      
      case
        LeseStadtGebaut.ID (StadtRasseNummerExtern => StadtRasseNummerExtern)
      is
         when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
            return;
            
         when others =>
            null;
      end case;
      
      FestzulegenderText (1) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugEinwohner) & LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                                                              EinwohnerArbeiterExtern => True)'Wide_Wide_Image;
      
      -- Volle Stadtinformationen, nur sichtbar wenn eigene Stadt oder durch Debug.
      if
        StadtRasseNummerExtern.Rasse = RasseExtern
        or
          SpielVariablen.Debug.VolleInformation
      then
         FestzulegenderText (2) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugNahrungsmittel) & LeseStadtGebaut.Nahrungsmittel (StadtRasseNummerExtern => StadtRasseNummerExtern)'Wide_Wide_Image;
         FestzulegenderText (3) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugNahrungsproduktion) & " "
           & ZahlAlsStringGesamtproduktionStadt (ZahlExtern => LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern));
         FestzulegenderText (4) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugRessourcenproduktion) & " "
           & ZahlAlsStringGesamtproduktionStadt (ZahlExtern => LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern));
         FestzulegenderText (5) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugGeldproduktion) & " " &
           ZahlAlsStringGesamtproduktionStadt (ZahlExtern => LeseStadtGebaut.Geldgewinnung (StadtRasseNummerExtern => StadtRasseNummerExtern));
         FestzulegenderText (6) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugWissensproduktion) & LeseStadtGebaut.Forschungsrate (StadtRasseNummerExtern => StadtRasseNummerExtern)'Wide_Wide_Image;
         FestzulegenderText (7) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugVerteidigung) & KampfwerteStadtErmittelnLogik.AktuelleVerteidigungStadt (StadtRasseNummerExtern => StadtRasseNummerExtern)'Wide_Wide_Image;
         FestzulegenderText (8) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugAngriff) & KampfwerteStadtErmittelnLogik.AktuellerAngriffStadt (StadtRasseNummerExtern => StadtRasseNummerExtern)'Wide_Wide_Image;
         FestzulegenderText (9) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugKorruption) & LeseStadtGebaut.Korruption (StadtRasseNummerExtern => StadtRasseNummerExtern)'Wide_Wide_Image;
         FestzulegenderText (10) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugVerfügbareArbeiter) & LeseStadtGebaut.Arbeitslose (StadtRasseNummerExtern => StadtRasseNummerExtern)'Wide_Wide_Image;
         FestzulegenderText (11) := AktuellesBauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern);
         FestzulegenderText (12) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugVerbleibendeBauzeit) & LeseStadtGebaut.Bauzeit (StadtRasseNummerExtern => StadtRasseNummerExtern)'Wide_Wide_Image;
                                 
         VolleInformation := True;

      else
         VolleInformation := False;
      end if;
      
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.StadtInformationenAccess'Range loop
         
         if
           VolleInformation = False
           and
             TextSchleifenwert > 2
         then
            null;
            
         else
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (TextSchleifenwert),
                                               str  => To_Wide_Wide_String (Source => FestzulegenderText (TextSchleifenwert)));
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (TextSchleifenwert),
                                          position => Textposition);
            
            Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                               text         => TextaccessVariablen.StadtInformationenAccess (TextSchleifenwert));
                     
            Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.StadtInformationenAccess (TextSchleifenwert),
                                                                                TextbreiteExtern => Textbreite);
         end if;
      
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         TextAccessExtern => TextaccessVariablen.StadtInformationenAccess (TextSchleifenwert),
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
         
      end loop TextSchleife;
      
      Viewfläche := (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
   end Stadt;
   
   
   
   procedure Stadtname
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
            
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.TextAccess,
                                         str  => To_Wide_Wide_String (Source => LeseStadtGebaut.Name (StadtRasseNummerExtern => StadtRasseNummerExtern)));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.TextAccess,
                                    position => Textposition);
      
      -- Eventuell kann man das überall einbauen und so Text deutlich besser anpassen? äöü
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                          TextbreiteExtern => Textbreite);
      
      Sf.Graphics.Text.scale (text    => TextaccessVariablen.TextAccess,
                              factors => (Viewfläche.x / Textbreite, 1.00));
            
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.TextAccess);
      
      Sf.Graphics.Text.setScale (text  => TextaccessVariablen.TextAccess,
                                 scale => (1.00, 1.00));
      
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
   end Stadtname;
   
   
   
   function AktuellesBauprojekt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Unbounded_Wide_Wide_String
   is begin
      
      Bauprojekt := LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      if
        Bauprojekt.Gebäude /= 0
      then
         Text := To_Unbounded_Wide_Wide_String (Source => GebaeudebeschreibungenGrafik.BeschreibungKurz (IDExtern    => Bauprojekt.Gebäude,
                                                                                                       RasseExtern => StadtRasseNummerExtern.Rasse));
      
      elsif
        Bauprojekt.Einheit /= 0
      then
         Text := To_Unbounded_Wide_Wide_String (Source => EinheitenbeschreibungenGrafik.BeschreibungKurz (IDExtern    => Bauprojekt.Einheit,
                                                                                                        RasseExtern => StadtRasseNummerExtern.Rasse));
      
      else
         Text := Meldungstexte.Zeug (TextnummernKonstanten.ZeugKeines);
      end if;
      
      return Meldungstexte.Zeug (TextnummernKonstanten.ZeugBauprojekt) & TextKonstanten.UmbruchAbstand & Text;
      
   end AktuellesBauprojekt;
   
end StadtseitenleisteGrafik;
