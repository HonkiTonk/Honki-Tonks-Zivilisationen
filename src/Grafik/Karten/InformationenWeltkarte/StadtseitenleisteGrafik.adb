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
   
   procedure Stadtinformationen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      Stadt (RasseExtern            => StadtRasseNummerExtern.Rasse,
             StadtRasseNummerExtern => StadtRasseNummerExtern,
             AnzeigebereichExtern   => GrafikRecordKonstanten.Stadtbereich (4),
             ViewExtern             => Views.StadtviewAccesse (4));
      
   end Stadtinformationen;
   
   
   
   procedure Leer
     (AnzeigebereichExtern : in Sf.Graphics.Rect.sfFloatRect;
      ViewExtern : in Sf.Graphics.sfView_Ptr)
   is begin
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (AnzeigebereichExtern.width, AnzeigebereichExtern.height));
      
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
                        
      Leer (AnzeigebereichExtern => AnzeigebereichExtern,
            ViewExtern           => ViewExtern);
      
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
      -- Die Anzeige des Stadtnamens mal noch nicht entfernen, eventuell will ich das später wieder einbauen?
      -- Stadtname (StadtRasseNummerExtern => StadtRasseNummerExtern);
      Textbreite := 0.00;
      
      case
        LeseStadtGebaut.ID (StadtRasseNummerExtern => StadtRasseNummerExtern)
      is
         when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
            return;
            
         when others =>
            FestzulegenderText (1) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugEinwohner) & LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                                                                    EinwohnerArbeiterExtern => True)'Wide_Wide_Image;
      end case;
      
      -- Volle Stadtinformationen, nur sichtbar wenn eigene Stadt oder durch Debug.
      if
        StadtRasseNummerExtern.Rasse = RasseExtern
        or
          SpielVariablen.Debug.VolleInformation
      then
         FestzulegenderText (2) := Nahrung (StadtRasseNummerExtern => StadtRasseNummerExtern);
         FestzulegenderText (3) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugRessourcenproduktion) & " "
           & ZahlAlsStringProduktion (ZahlExtern => LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern));
         FestzulegenderText (4) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugGeldproduktion) & " " &
           ZahlAlsStringProduktion (ZahlExtern => LeseStadtGebaut.Geldgewinnung (StadtRasseNummerExtern => StadtRasseNummerExtern));
         FestzulegenderText (5) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugWissensproduktion) & LeseStadtGebaut.Forschungsrate (StadtRasseNummerExtern => StadtRasseNummerExtern)'Wide_Wide_Image;
         FestzulegenderText (6) := Kampfwerte (StadtRasseNummerExtern => StadtRasseNummerExtern);
           FestzulegenderText (7) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugKorruption) & LeseStadtGebaut.Korruption (StadtRasseNummerExtern => StadtRasseNummerExtern)'Wide_Wide_Image;
         FestzulegenderText (8) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugVerfügbareArbeiter) & LeseStadtGebaut.Arbeitslose (StadtRasseNummerExtern => StadtRasseNummerExtern)'Wide_Wide_Image;
         FestzulegenderText (9) := AktuellesBauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern);
                                 
         VolleInformation := True;

      else
         VolleInformation := False;
      end if;
      
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.StadtInformationenAccess'Range loop
         
         if
           VolleInformation = False
           and
             TextSchleifenwert >= 2
         then
            null;
            
         else
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (TextSchleifenwert),
                                               str  => To_Wide_Wide_String (Source => FestzulegenderText (TextSchleifenwert)));
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (TextSchleifenwert),
                                          position => Textposition);
            
            Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                               text         => TextaccessVariablen.StadtInformationenAccess (TextSchleifenwert));
         end if;
                     
         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.StadtInformationenAccess (TextSchleifenwert),
                                                                             TextbreiteExtern => Textbreite);
      
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         TextAccessExtern => TextaccessVariablen.StadtInformationenAccess (TextSchleifenwert),
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
         
      end loop TextSchleife;
      
      Viewfläche := (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
   end Stadt;
   
   
   
   -- Die Anzeige des Stadtnamens mal noch nicht entfernen, eventuell will ich das später wieder einbauen?
   procedure Stadtname
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
            
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.TextAccess,
                                         str  => To_Wide_Wide_String (Source => LeseStadtGebaut.Name (StadtRasseNummerExtern => StadtRasseNummerExtern)));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.TextAccess,
                                    position => Textposition);
      
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
   
   
   
   function Nahrung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Unbounded_Wide_Wide_String
   is begin
      
      Nahrungsproduktion := LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      if
        Nahrungsproduktion = 0
      then
         return Meldungstexte.Zeug (TextnummernKonstanten.ZeugNahrungsmittel) & LeseStadtGebaut.Nahrungsmittel (StadtRasseNummerExtern => StadtRasseNummerExtern)'Wide_Wide_Image;
         
      elsif
        Nahrungsproduktion > 0
      then
         return Meldungstexte.Zeug (TextnummernKonstanten.ZeugNahrungsmittel) & LeseStadtGebaut.Nahrungsmittel (StadtRasseNummerExtern => StadtRasseNummerExtern)'Wide_Wide_Image & TextKonstanten.StandardAbstand
         & "+" & ZahlAlsStringProduktion (ZahlExtern => Nahrungsproduktion);
         
      else
         return Meldungstexte.Zeug (TextnummernKonstanten.ZeugNahrungsmittel) & LeseStadtGebaut.Nahrungsmittel (StadtRasseNummerExtern => StadtRasseNummerExtern)'Wide_Wide_Image & TextKonstanten.StandardAbstand
           & ZahlAlsStringProduktion (ZahlExtern => Nahrungsproduktion);
      end if;
      
   end Nahrung;
   
   
   
   function Kampfwerte
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Unbounded_Wide_Wide_String
   is begin
            
      return Meldungstexte.Zeug (TextnummernKonstanten.ZeugKampfwerte) & KampfwerteStadtErmittelnLogik.AktuellerAngriffStadt (StadtRasseNummerExtern => StadtRasseNummerExtern)'Wide_Wide_Image
        & " " & TextKonstanten.TrennzeichenUnterschiedlich & KampfwerteStadtErmittelnLogik.AktuelleVerteidigungStadt (StadtRasseNummerExtern => StadtRasseNummerExtern)'Wide_Wide_Image;
      
   end Kampfwerte;
   
   
   
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
         return Meldungstexte.Zeug (TextnummernKonstanten.ZeugBauprojekt);
      end if;
      
      Bauzeit := LeseStadtGebaut.Bauzeit (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      case
        Bauzeit
      is
         when ProduktionDatentypen.Produktion'Last =>
            return Meldungstexte.Zeug (TextnummernKonstanten.ZeugBauprojekt) & TextKonstanten.UmbruchAbstand & Text & " (∞)";
            
         when others =>
            return Meldungstexte.Zeug (TextnummernKonstanten.ZeugBauprojekt) & TextKonstanten.UmbruchAbstand & Text & " (" & ZahlAlsStringProduktion (ZahlExtern => Bauzeit) & ")";
      end case;
            
   end AktuellesBauprojekt;
   
end StadtseitenleisteGrafik;
