with EinheitenDatentypen;
with StadtDatentypen;
with Meldungstexte;
with TextnummernKonstanten;
with TextKonstanten;
with Views;
with GrafikDatentypen;
with ViewKonstanten;
with GrafikKonstanten;
with ProduktionKonstanten;

with KampfwerteStadtErmittelnLogik;
with TextberechnungenHoeheGrafik;
with HintergrundGrafik;
with ViewsEinstellenGrafik;
with GebaeudebeschreibungenGrafik;
with EinheitenbeschreibungenGrafik;
with TextberechnungenBreiteGrafik;
with DebugobjekteLogik;
with TextaccessverwaltungssystemGrafik;
with AllgemeineBerechnungen;

package body StadtseitenleisteGrafik is
   
   procedure Stadtinformationen
     (StadtauswahlExtern : in StadtGrafikRecords.StadtGrafikRecord)
   is begin
      
      Stadt (SpeziesExtern        => StadtauswahlExtern.SpeziesNummer.Spezies,
             StadtauswahlExtern   => StadtauswahlExtern,
             AnzeigebereichExtern => GrafikRecordKonstanten.Stadtbereich (ViewKonstanten.StadtInformationen),
             ViewExtern           => Views.StadtviewAccesse (ViewKonstanten.StadtInformationen));
      
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
      StadtauswahlExtern : in StadtGrafikRecords.StadtGrafikRecord;
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
      
      Textbreite := GrafikKonstanten.Nullwert;
      
      FestzulegenderText (1) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugEinwohner) & StadtauswahlExtern.EinwohnerArbeiter (1)'Wide_Wide_Image;
      
      -- Volle Stadtinformationen, nur sichtbar wenn eigene Stadt oder durch Debug.
      if
        StadtauswahlExtern.SpeziesNummer.Spezies = SpeziesExtern
        or
          DebugobjekteLogik.Debug.VolleInformation
      then
         FestzulegenderText (2) := Nahrung (ProduktionExtern => StadtauswahlExtern.Nahrungsproduktion,
                                            VorhandenExtern  => StadtauswahlExtern.Nahrungsmittel);
         FestzulegenderText (3) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugRessourcenproduktion) & " " & ZahlAlsStringProduktion (ZahlExtern => StadtauswahlExtern.Produktionrate);
         FestzulegenderText (4) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugGeldproduktion) & " " & ZahlAlsStringProduktion (ZahlExtern => StadtauswahlExtern.Geldgewinnung);
         FestzulegenderText (5) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugWissensproduktion) & StadtauswahlExtern.Forschungsrate'Wide_Wide_Image;
         FestzulegenderText (6) := Kampfwerte (StadtauswahlExtern => StadtauswahlExtern);
         FestzulegenderText (7) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugKorruption) & StadtauswahlExtern.Korruption'Wide_Wide_Image;
         FestzulegenderText (8) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugVerfügbareArbeiter) & AllgemeineBerechnungen.FreieEinwohner (EinwohnerExtern => StadtauswahlExtern.EinwohnerArbeiter (1),
                                                                                                                                               ArbeiterExtern  => StadtauswahlExtern.EinwohnerArbeiter (2))'Wide_Wide_Image;
         FestzulegenderText (9) := AktuellesBauprojekt (SpeziesExtern    => StadtauswahlExtern.SpeziesNummer.Spezies,
                                                        BauprojektExtern => StadtauswahlExtern.Bauprojekt,
                                                        BauzeitExtern    => StadtauswahlExtern.Bauzeit);
                                 
         VolleInformation := True;

      else
         VolleInformation := False;
      end if;
      
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.StadtInformationenAccess'Range loop
         
         if
           VolleInformation = False
           and
             TextSchleifenwert >= Informationsgrenze
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
     (ProduktionExtern : in ProduktionDatentypen.Stadtproduktion;
      VorhandenExtern : in ProduktionDatentypen.Stadtproduktion)
      return Unbounded_Wide_Wide_String
   is
      use type ProduktionDatentypen.Produktion;
   begin
            
      if
        ProduktionExtern = ProduktionKonstanten.LeerProduktion
      then
         return Meldungstexte.Zeug (TextnummernKonstanten.ZeugNahrungsmittel) & VorhandenExtern'Wide_Wide_Image;
         
      elsif
        ProduktionExtern > ProduktionKonstanten.LeerProduktion
      then
         return Meldungstexte.Zeug (TextnummernKonstanten.ZeugNahrungsmittel) & VorhandenExtern'Wide_Wide_Image & TextKonstanten.StandardAbstand & "+" & ZahlAlsStringProduktion (ZahlExtern => ProduktionExtern);
         
      else
         return Meldungstexte.Zeug (TextnummernKonstanten.ZeugNahrungsmittel) & VorhandenExtern'Wide_Wide_Image & TextKonstanten.StandardAbstand & ZahlAlsStringProduktion (ZahlExtern => ProduktionExtern);
      end if;
      
   end Nahrung;
   
   
   
   function Kampfwerte
     (StadtauswahlExtern : in StadtGrafikRecords.StadtGrafikRecord)
      return Unbounded_Wide_Wide_String
   is begin
               
      return Meldungstexte.Zeug (TextnummernKonstanten.ZeugKampfwerte) & KampfwerteStadtErmittelnLogik.AktuellerAngriffStadt (IDExtern          => StadtauswahlExtern.ID,
                                                                                                                              KoordinatenExtern => StadtauswahlExtern.Koordinaten,
                                                                                                                              SpeziesExtern     => StadtauswahlExtern.SpeziesNummer.Spezies,
                                                                                                                              GebäudeExtern    => StadtauswahlExtern.GebäudeVorhanden)'Wide_Wide_Image
        & " " & TextKonstanten.TrennzeichenUnterschiedlich & KampfwerteStadtErmittelnLogik.AktuelleVerteidigungStadt (IDExtern          => StadtauswahlExtern.ID,
                                                                                                                      KoordinatenExtern => StadtauswahlExtern.Koordinaten,
                                                                                                                      SpeziesExtern     => StadtauswahlExtern.SpeziesNummer.Spezies,
                                                                                                                      GebäudeExtern     => StadtauswahlExtern.GebäudeVorhanden)'Wide_Wide_Image;
      
   end Kampfwerte;
   
   
   
   function AktuellesBauprojekt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      BauprojektExtern : in StadtRecords.BauprojektRecord;
      BauzeitExtern : in ProduktionDatentypen.Produktion)
      return Unbounded_Wide_Wide_String
   is
      use type StadtDatentypen.GebäudeIDMitNullwert;
      use type EinheitenDatentypen.EinheitenIDMitNullWert;
   begin
      
      if
        BauprojektExtern.Gebäude /= StadtKonstanten.LeerBauprojekt.Gebäude
      then
         Text := To_Unbounded_Wide_Wide_String (Source => GebaeudebeschreibungenGrafik.Kurzbeschreibung (IDExtern      => BauprojektExtern.Gebäude,
                                                                                                         SpeziesExtern => SpeziesExtern));
      
      elsif
        BauprojektExtern.Einheit /= StadtKonstanten.LeerBauprojekt.Einheit
      then
         Text := To_Unbounded_Wide_Wide_String (Source => EinheitenbeschreibungenGrafik.Kurzbeschreibung (IDExtern      => BauprojektExtern.Einheit,
                                                                                                          SpeziesExtern => SpeziesExtern));
      
      else
         return TextKonstanten.LeerUnboundedString;
      end if;
      
      case
        BauzeitExtern
      is
         when ProduktionDatentypen.Produktion'Last =>
            return Meldungstexte.Zeug (TextnummernKonstanten.ZeugBauprojekt) & TextKonstanten.UmbruchAbstand & Text & TextKonstanten.UnendlichGeklammert;
            
         when others =>
            return Meldungstexte.Zeug (TextnummernKonstanten.ZeugBauprojekt) & TextKonstanten.UmbruchAbstand & Text & " (" & ZahlAlsStringProduktion (ZahlExtern => BauzeitExtern) & ")";
      end case;
            
   end AktuellesBauprojekt;
   
end StadtseitenleisteGrafik;
