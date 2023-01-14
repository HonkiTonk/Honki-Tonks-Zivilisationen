with EinheitenDatentypen;
with StadtDatentypen;
with Meldungstexte;
with TextnummernKonstanten;
with TextKonstanten;
with Views;
with KartenverbesserungDatentypen;
with GrafikDatentypen;
with ViewKonstanten;

with LeseStadtGebaut;

with KampfwerteStadtErmittelnLogik;
with TextberechnungenHoeheGrafik;
with HintergrundGrafik;
with ViewsEinstellenGrafik;
with GebaeudebeschreibungenGrafik;
with EinheitenbeschreibungenGrafik;
with TextberechnungenBreiteGrafik;
with DebugobjekteLogik;
with TextaccessverwaltungssystemGrafik;

package body StadtseitenleisteGrafik is
   
   procedure Stadtinformationen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      Stadt (SpeziesExtern            => StadtSpeziesNummerExtern.Spezies,
             StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
             AnzeigebereichExtern     => GrafikRecordKonstanten.Stadtbereich (ViewKonstanten.StadtInformationen),
             ViewExtern               => Views.StadtviewAccesse (ViewKonstanten.StadtInformationen));
      
   end Stadtinformationen;
   
   
   
   -- Das Leeren kann nicht mit den anderen SeitenleistenLeeren zusammengelegt werden, da es einmal für die Weltkarte und einmal für die Stadtkarte verwendet wird.
   function Leer
     (AnzeigebereichExtern : in Sf.Graphics.Rect.sfFloatRect;
      ViewExtern : in Sf.Graphics.sfView_Ptr;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Zwischenfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => ViewflächeExtern,
                                                                            VerhältnisExtern => (AnzeigebereichExtern.width, AnzeigebereichExtern.height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => ViewExtern,
                                            GrößeExtern          => Zwischenfläche,
                                            AnzeigebereichExtern => AnzeigebereichExtern);
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Seitenleiste_Hintergrund_Enum,
                                     AbmessungenExtern => Zwischenfläche);
      
      return Zwischenfläche;
      
   end Leer;
   
   

   procedure Stadt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      AnzeigebereichExtern : in Sf.Graphics.Rect.sfFloatRect;
      ViewExtern : in Sf.Graphics.sfView_Ptr)
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
                        
      Viewfläche := Leer (AnzeigebereichExtern => AnzeigebereichExtern,
                          ViewExtern           => ViewExtern,
                          ViewflächeExtern     => Viewfläche);
      
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
      -- Die Anzeige des Stadtnamens mal noch nicht entfernen, eventuell will ich das später wieder einbauen?
      -- Stadtname (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      Textbreite := 0.00;
      
      case
        LeseStadtGebaut.ID (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern)
      is
         when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
            return;
            
         when others =>
            FestzulegenderText (1) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugEinwohner) & LeseStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern  => StadtSpeziesNummerExtern,
                                                                                                                                    EinwohnerArbeiterExtern => True)'Wide_Wide_Image;
      end case;
      
      -- Volle Stadtinformationen, nur sichtbar wenn eigene Stadt oder durch Debug.
      if
        StadtSpeziesNummerExtern.Spezies = SpeziesExtern
        or
          DebugobjekteLogik.Debug.VolleInformation
      then
         FestzulegenderText (2) := Nahrung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
         FestzulegenderText (3) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugRessourcenproduktion) & " "
           & ZahlAlsStringProduktion (ZahlExtern => LeseStadtGebaut.Produktionrate (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern));
         FestzulegenderText (4) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugGeldproduktion) & " " &
           ZahlAlsStringProduktion (ZahlExtern => LeseStadtGebaut.Geldgewinnung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern));
         FestzulegenderText (5) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugWissensproduktion) & LeseStadtGebaut.Forschungsrate (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern)'Wide_Wide_Image;
         FestzulegenderText (6) := Kampfwerte (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
         FestzulegenderText (7) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugKorruption) & LeseStadtGebaut.Korruption (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern)'Wide_Wide_Image;
         FestzulegenderText (8) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugVerfügbareArbeiter) & LeseStadtGebaut.Arbeitslose (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern)'Wide_Wide_Image;
         FestzulegenderText (9) := AktuellesBauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
                                 
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
            TextaccessverwaltungssystemGrafik.TextPositionZeichnen (TextaccessExtern => TextaccessVariablen.StadtInformationenAccess (TextSchleifenwert),
                                                              TextExtern       => To_Wide_Wide_String (Source => FestzulegenderText (TextSchleifenwert)),
                                                              PositionExtern   => Textposition);
      
            Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                            TextAccessExtern => TextaccessVariablen.StadtInformationenAccess (TextSchleifenwert),
                                                                            ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
                     
            Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.StadtInformationenAccess (TextSchleifenwert),
                                                                                TextbreiteExtern => Textbreite);
         end if;
         
      end loop TextSchleife;
      
      Viewfläche := (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
   end Stadt;
   
   
   
   function Nahrung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Unbounded_Wide_Wide_String
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      Nahrungsproduktion := LeseStadtGebaut.Nahrungsproduktion (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
      if
        Nahrungsproduktion = 0
      then
         return Meldungstexte.Zeug (TextnummernKonstanten.ZeugNahrungsmittel) & LeseStadtGebaut.Nahrungsmittel (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern)'Wide_Wide_Image;
         
      elsif
        Nahrungsproduktion > 0
      then
         return Meldungstexte.Zeug (TextnummernKonstanten.ZeugNahrungsmittel) & LeseStadtGebaut.Nahrungsmittel (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern)'Wide_Wide_Image & TextKonstanten.StandardAbstand
         & "+" & ZahlAlsStringProduktion (ZahlExtern => Nahrungsproduktion);
         
      else
         return Meldungstexte.Zeug (TextnummernKonstanten.ZeugNahrungsmittel) & LeseStadtGebaut.Nahrungsmittel (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern)'Wide_Wide_Image & TextKonstanten.StandardAbstand
           & ZahlAlsStringProduktion (ZahlExtern => Nahrungsproduktion);
      end if;
      
   end Nahrung;
   
   
   
   function Kampfwerte
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Unbounded_Wide_Wide_String
   is begin
            
      return Meldungstexte.Zeug (TextnummernKonstanten.ZeugKampfwerte) & KampfwerteStadtErmittelnLogik.AktuellerAngriffStadt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern)'Wide_Wide_Image
        & " " & TextKonstanten.TrennzeichenUnterschiedlich & KampfwerteStadtErmittelnLogik.AktuelleVerteidigungStadt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern)'Wide_Wide_Image;
      
   end Kampfwerte;
   
   
   
   function AktuellesBauprojekt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Unbounded_Wide_Wide_String
   is
      use type StadtDatentypen.GebäudeIDMitNullwert;
      use type EinheitenDatentypen.EinheitenIDMitNullWert;
   begin
            
      Bauprojekt := LeseStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
      if
        Bauprojekt.Gebäude /= 0
      then
         Text := To_Unbounded_Wide_Wide_String (Source => GebaeudebeschreibungenGrafik.Kurzbeschreibung (IDExtern    => Bauprojekt.Gebäude,
                                                                                                         SpeziesExtern => StadtSpeziesNummerExtern.Spezies));
      
      elsif
        Bauprojekt.Einheit /= 0
      then
         Text := To_Unbounded_Wide_Wide_String (Source => EinheitenbeschreibungenGrafik.Kurzbeschreibung (IDExtern    => Bauprojekt.Einheit,
                                                                                                          SpeziesExtern => StadtSpeziesNummerExtern.Spezies));
      
      else
         return TextKonstanten.LeerUnboundedString;
      end if;
      
      Bauzeit := LeseStadtGebaut.Bauzeit (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
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
