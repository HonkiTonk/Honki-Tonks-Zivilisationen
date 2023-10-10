with Sf.Graphics.Text;

with GrafikDatentypen;
with Spieltexte;
with TextnummernKonstanten;
with TextaccessVariablen;
with Views;
with EinheitenKonstanten;
with ViewKonstanten;
with StadtKonstanten;
with GrafikKonstanten;
with AuswahlKonstanten;

with TextberechnungenBreiteGrafik;
with InteraktionAuswahl;
with TextberechnungenHoeheGrafik;
with GebaeudebeschreibungenGrafik;
with EinheitenbeschreibungenGrafik;
with HintergrundGrafik;
with ViewsEinstellenGrafik;
with AllgemeineViewsGrafik;
with TextfarbeGrafik;
with BauauswahlEinheitenGrafik;
with BauauswahlGebaeudeGrafik;
with TextaccessverwaltungssystemEinfachGrafik;
with TextaccessverwaltungssystemErweitertGrafik;

-- Kann man das so anpassen dass eine teilweise Verschmelzung mit VerkaufsauswahlGrafik möglich wäre? äöü
package body BauauswahlGrafik is

   procedure Bauauswahl
     (BauauswahlExtern : in StadtGrafikRecords.BaumenüGrafikRecord;
      AktuelleAuswahlExtern : in StadtRecords.BauprojektRecord)
   is begin
      AllgemeineViewsGrafik.Überschrift (ÜberschriftExtern => To_Wide_Wide_String (Source => Spieltexte.Fragen (TextnummernKonstanten.FrageBauprojekt)),
                                          HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                          SpielenamenExtern => False);
      
      case
        AktuelleAuswahlExtern.Gebäude
      is
         when StadtKonstanten.LeerGebäudeID =>
            Einheiten (AuswahlExtern => AktuelleAuswahlExtern.Einheit,
                       SpeziesExtern => BauauswahlExtern.Spezies);
            
         when others =>
            BauauswahlGebaeudeGrafik.Gebäudeinformationen (AuswahlExtern     => AktuelleAuswahlExtern.Gebäude,
                                                            SpeziesExtern     => BauauswahlExtern.Spezies,
                                                            ViewbereichExtern => ViewKonstanten.BaumenüGebäudeinformationen);
      end case;
      
      case
        AktuelleAuswahlExtern.Einheit
      is
         when EinheitenKonstanten.LeerID =>
            Gebäude (AuswahlExtern => AktuelleAuswahlExtern.Gebäude,
                      SpeziesExtern => BauauswahlExtern.Spezies);
            
         when others =>
            BauauswahlEinheitenGrafik.Einheiteninformationen (AuswahlExtern => AktuelleAuswahlExtern.Einheit,
                                                              SpeziesExtern => BauauswahlExtern.Spezies);
      end case;
      
      Aktuell (BauauswahlExtern => BauauswahlExtern);
      
   end Bauauswahl;
   
   
   
   procedure Gebäude
     (AuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      ViewflächeGebäude := ViewsEinstellenGrafik.ViewflächeXFestYVariabel (ViewflächeExtern => ViewflächeGebäude,
                                                                               VerhältnisExtern => (GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüGebäudeliste).width,
                                                                                                     GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüGebäudeliste).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewKonstanten.BaumenüEinheitenliste),
                                            GrößeExtern          => ViewflächeGebäude,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüGebäudeliste));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                     AbmessungenExtern => ViewflächeGebäude);
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstand;
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
         
         case
           InteraktionAuswahl.MöglicheGebäude (GebäudeSchleifenwert)
         is
            when True =>
               TextaccessverwaltungssystemEinfachGrafik.Farbe (TextaccessExtern => TextaccessVariablen.GebäudetextAccess (SpeziesExtern, GebäudeSchleifenwert),
                                                               FarbeExtern      => TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => Positive (GebäudeSchleifenwert),
                                                                                                                          AuswahlExtern    => Natural (AuswahlExtern)));
               
               Textposition.y := TextaccessverwaltungssystemErweitertGrafik.SkalierenMittelnZeichnen (TextpositionExtern       => Textposition,
                                                                                                      MaximaleTextbreiteExtern => ViewflächeGebäude.x,
                                                                                                      TextAccessExtern         => TextaccessVariablen.GebäudetextAccess (SpeziesExtern, GebäudeSchleifenwert));
               
               
               InteraktionAuswahl.PositionenGebäudeBauen (GebäudeSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.GebäudetextAccess (SpeziesExtern, GebäudeSchleifenwert));

            when False =>
               null;
               -- InteraktionAuswahl.PositionenGebäudeBauen (GebäudeSchleifenwert) := GrafikRecordKonstanten.Leerbereich;
         end case;
                                                                               
      end loop GebäudeSchleife;
      
      ViewflächeGebäude.y := Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
   end Gebäude;
   
   
   
   procedure Einheiten
     (AuswahlExtern : in EinheitenDatentypen.EinheitenID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      ViewflächeEinheiten := ViewsEinstellenGrafik.ViewflächeXFestYVariabel (ViewflächeExtern => ViewflächeEinheiten,
                                                                               VerhältnisExtern => (GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüEinheitenliste).width,
                                                                                                     GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüEinheitenliste).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewKonstanten.BaumenüEinheitenliste),
                                            GrößeExtern          => ViewflächeEinheiten,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüEinheitenliste));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                     AbmessungenExtern => ViewflächeEinheiten);
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstand;
          
      EinheitenSchleife:
      for EinheitenSchleifenwert in EinheitenDatentypen.EinheitenIDVorhanden'Range loop
         
         case
           InteraktionAuswahl.MöglicheEinheiten (EinheitenSchleifenwert)
         is
            when True =>
               TextaccessverwaltungssystemEinfachGrafik.Farbe (TextaccessExtern => TextaccessVariablen.EinheitentextAccess (SpeziesExtern, EinheitenSchleifenwert),
                                                               FarbeExtern      => TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => Positive (EinheitenSchleifenwert),
                                                                                                                          AuswahlExtern    => Natural (AuswahlExtern)));
               
               Textposition.y := TextaccessverwaltungssystemErweitertGrafik.SkalierenMittelnZeichnen (TextpositionExtern       => Textposition,
                                                                                                      MaximaleTextbreiteExtern => ViewflächeEinheiten.x,
                                                                                                      TextAccessExtern         => TextaccessVariablen.EinheitentextAccess (SpeziesExtern, EinheitenSchleifenwert));
               
               InteraktionAuswahl.PositionenEinheitenBauen (EinheitenSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.EinheitentextAccess (SpeziesExtern, EinheitenSchleifenwert));

            when False =>
               null;
               -- InteraktionAuswahl.PositionenEinheitenBauen (EinheitenSchleifenwert) := GrafikRecordKonstanten.Leerbereich;
         end case;
         
      end loop EinheitenSchleife;
      
      ViewflächeEinheiten.y := Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
   end Einheiten;
   
   
   
   procedure Aktuell
     (BauauswahlExtern : in StadtGrafikRecords.BaumenüGrafikRecord)
   is begin
      
      ViewflächeAktuell := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => ViewflächeAktuell,
                                                                               VerhältnisExtern => (GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüAktuell).width,
                                                                                                     GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüAktuell).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewKonstanten.BaumenüAktuell),
                                            GrößeExtern          => ViewflächeAktuell,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüAktuell));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                     AbmessungenExtern => ViewflächeAktuell);
      
      if
        BauauswahlExtern.Bauprojekt.Gebäude /= AuswahlKonstanten.LeerGebäudeauswahl
      then
         Text := Spieltexte.Zeug (TextnummernKonstanten.ZeugBauprojekt) & " " & GebaeudebeschreibungenGrafik.Kurzbeschreibung (IDExtern      => BauauswahlExtern.Bauprojekt.Gebäude,
                                                                                                                               SpeziesExtern => BauauswahlExtern.Spezies);
         
      elsif
        BauauswahlExtern.Bauprojekt.Einheit /= AuswahlKonstanten.LeerEinheitenauswahl
      then
         Text := Spieltexte.Zeug (TextnummernKonstanten.ZeugBauprojekt) & " " & EinheitenbeschreibungenGrafik.Kurzbeschreibung (IDExtern      => BauauswahlExtern.Bauprojekt.Einheit,
                                                                                                                                SpeziesExtern => BauauswahlExtern.Spezies);
                     
      else
         return;
      end if;
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      Textbreite := GrafikKonstanten.Nullwert;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.AktuellesBauprojekt,
                                         str  => To_Wide_Wide_String (Source => Text));
      
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.AktuellesBauprojekt,
                                                                              ViewbreiteExtern => ViewflächeAktuell.x);
                     
      TextaccessverwaltungssystemEinfachGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.AktuellesBauprojekt,
                                                                 PositionExtern   => Textposition);
      
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.AktuellesBauprojekt,
                                                                          TextbreiteExtern => Textbreite);
      
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
      Text := Spieltexte.Zeug (TextnummernKonstanten.ZeugVerbleibendeBauzeit) & BauauswahlExtern.Bauzeit'Wide_Wide_Image;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.AktuellesBauprojekt,
                                         str  => To_Wide_Wide_String (Source => Text));
      
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.AktuellesBauprojekt,
                                                                              ViewbreiteExtern => ViewflächeAktuell.x);
      
      TextaccessverwaltungssystemEinfachGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.AktuellesBauprojekt,
                                                                 PositionExtern   => Textposition);
      
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.AktuellesBauprojekt,
                                                                          TextbreiteExtern => Textbreite);
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
            
      ViewflächeAktuell := (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
   end Aktuell;

end BauauswahlGrafik;
