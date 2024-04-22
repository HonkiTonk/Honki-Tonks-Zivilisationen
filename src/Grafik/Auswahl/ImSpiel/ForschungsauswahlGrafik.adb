with Sf.Graphics.Text;

with ForschungKonstanten;
with GrafikDatentypen;
with Spieltexte;
with TextnummernKonstanten;
with EinheitenDatentypen;
with StadtDatentypen;
with TextaccessVariablen;
with Views;
with ViewKonstanten;
with GrafikKonstanten;
with TextKonstanten;

with LeseForschungenDatenbank;
with LeseEinheitenDatenbank;
with LeseGebaeudeDatenbank;
with LeseWichtiges;

with TextberechnungenBreiteGrafik;
with InteraktionAuswahl;
with TextberechnungenHoeheGrafik;
with HintergrundGrafik;
with ViewsEinstellenGrafik;
with ForschungsbeschreibungenGrafik;
with EinheitenbeschreibungenGrafik;
with GebaeudebeschreibungenGrafik;
with AllgemeineViewsGrafik;
with ZeilenumbruchberechnungGrafik;
with TextfarbeGrafik;
with TextaccessverwaltungssystemEinfachGrafik;

package body ForschungsauswahlGrafik is

   procedure ForschungAnzeige
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      AktuelleAuswahlExtern : in Natural)
   is begin
      
      AllgemeineViewsGrafik.Überschrift (ÜberschriftExtern => To_Wide_Wide_String (Source => Spieltexte.Fragen (TextnummernKonstanten.FrageForschungsprojekt)),
                                          HintergrundExtern => GrafikDatentypen.Forschung_Hintergrund_Enum,
                                          SpielenamenExtern => False);
      
      Auswahlmöglichkeiten (AuswahlExtern => AktuelleAuswahlExtern,
                             SpeziesExtern => SpeziesExtern);
            
      AktuelleAuswahl := ForschungenDatentypen.ForschungID (AktuelleAuswahlExtern);
      
      Ermöglicht (ZusatztextExtern => AktuelleAuswahl,
                   SpeziesExtern    => SpeziesExtern);
      Beschreibung (ZusatztextExtern => AktuelleAuswahl,
                    SpeziesExtern    => SpeziesExtern);
      
      Aktuell (SpeziesExtern => SpeziesExtern);
      
   end ForschungAnzeige;
   
   
   
   procedure Auswahlmöglichkeiten
     (AuswahlExtern : in Natural;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is begin
      
      Viewfläche (ViewKonstanten.ForschungsmenüForschungsliste)
        := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewKonstanten.ForschungsmenüForschungsliste),
                                                              VerhältnisExtern => (GrafikRecordKonstanten.Forschungsbereich (ViewKonstanten.ForschungsmenüForschungsliste).width,
                                                                                    GrafikRecordKonstanten.Forschungsbereich (ViewKonstanten.ForschungsmenüForschungsliste).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.ForschungsviewAccesse (ViewKonstanten.ForschungsmenüForschungsliste),
                                            GrößeExtern          => Viewfläche (ViewKonstanten.ForschungsmenüForschungsliste),
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Forschungsbereich (ViewKonstanten.ForschungsmenüForschungsliste));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Forschung_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche (ViewKonstanten.ForschungsmenüForschungsliste));
      
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstand;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      AktuelleTextbreite := GrafikKonstanten.Nullwert;
            
      AnzeigeSchleife:
      for ForschungSchleifenwert in ForschungenDatentypen.ForschungIDVorhanden'Range loop
         
         case
           InteraktionAuswahl.MöglicheForschungen (ForschungSchleifenwert)
         is
            when True =>
               TextaccessverwaltungssystemEinfachGrafik.PositionFarbeZeichnen (TextaccessExtern => TextaccessVariablen.ForschungsmenüAccess (SpeziesExtern, ForschungSchleifenwert),
                                                                               PositionExtern   => Textposition,
                                                                               FarbeExtern      => TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => Positive (ForschungSchleifenwert),
                                                                                                                                          AuswahlExtern    => AuswahlExtern));
               
               AktuelleTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüAccess (SpeziesExtern, ForschungSchleifenwert),
                                                                                           TextbreiteExtern => AktuelleTextbreite);
               
               Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                               ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstand);
               
               InteraktionAuswahl.PositionenForschung (ForschungSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.ForschungsmenüAccess (SpeziesExtern, ForschungSchleifenwert));
               
            when False =>
               null;
         end case;
         
      end loop AnzeigeSchleife;
      
      Viewfläche (ViewKonstanten.ForschungsmenüForschungsliste) := (AktuelleTextbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstand);
      
   end Auswahlmöglichkeiten;
   
   
   
   procedure Ermöglicht
     (ZusatztextExtern : in ForschungenDatentypen.ForschungID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is
      use type ForschungenDatentypen.ForschungIDUnmöglich;
   begin
      
      Viewfläche (ViewKonstanten.ForschungsmenüErmöglicht)
        := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewKonstanten.ForschungsmenüErmöglicht),
                                                              VerhältnisExtern => (GrafikRecordKonstanten.Forschungsbereich (ViewKonstanten.ForschungsmenüErmöglicht).width,
                                                                                    GrafikRecordKonstanten.Forschungsbereich (ViewKonstanten.ForschungsmenüErmöglicht).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.ForschungsviewAccesse (ViewKonstanten.ForschungsmenüErmöglicht),
                                            GrößeExtern          => Viewfläche (ViewKonstanten.ForschungsmenüErmöglicht),
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Forschungsbereich (ViewKonstanten.ForschungsmenüErmöglicht));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Forschung_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche (ViewKonstanten.ForschungsmenüErmöglicht));
      
      case
        ZusatztextExtern
      is
         when ForschungKonstanten.LeerForschung =>
            return;
            
         when others =>
            Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstand;
            Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
            AktuelleTextbreite := GrafikKonstanten.Nullwert;
            
            TextaccessverwaltungssystemEinfachGrafik.TextPositionZeichnen (TextaccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                           TextExtern       => To_Wide_Wide_String (Source => Spieltexte.Zeug (TextnummernKonstanten.ZeugWirdBenötigt)),
                                                                           PositionExtern   => Textposition);
      
            Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                            ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstand);
      
            AktuelleTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                                        TextbreiteExtern => AktuelleTextbreite);
      end case;
      
      ErmöglichtSchleife:
      for NeueForschungSchleifenwert in ForschungenDatentypen.AnforderungForschungArray'Range loop
         TechnologienSchleife:
         for TechnologieSchleifenwert in ForschungenDatentypen.ForschungIDVorhanden'Range loop
            
            Forschungswert := LeseForschungenDatenbank.AnforderungForschung (SpeziesExtern           => SpeziesExtern,
                                                                             IDExtern                => TechnologieSchleifenwert,
                                                                             WelcheAnforderungExtern => NeueForschungSchleifenwert);
            
            if
              Forschungswert = ZusatztextExtern
            then
               TextaccessverwaltungssystemEinfachGrafik.TextPositionZeichnen (TextaccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                              TextExtern       => ForschungsbeschreibungenGrafik.Kurzbeschreibung (IDExtern      => TechnologieSchleifenwert,
                                                                                                                                                   SpeziesExtern => SpeziesExtern),
                                                                              PositionExtern   => Textposition);
         
               Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                               ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstand);
               AktuelleTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                                           TextbreiteExtern => AktuelleTextbreite);
                  
            else
               null;
            end if;
         
         end loop TechnologienSchleife;
      end loop ErmöglichtSchleife;
      
      Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.Zeilenabstand;
         
      EinheitenSchleife:
      for EinheitenSchleifenwert in EinheitenDatentypen.EinheitenIDVorhanden'Range loop
            
         if
           ZusatztextExtern = LeseEinheitenDatenbank.Anforderungen (SpeziesExtern => SpeziesExtern,
                                                                    IDExtern      => EinheitenSchleifenwert)
         then
            TextaccessverwaltungssystemEinfachGrafik.TextPositionZeichnen (TextaccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                           TextExtern       => EinheitenbeschreibungenGrafik.Kurzbeschreibung (IDExtern      => EinheitenSchleifenwert,
                                                                                                                                               SpeziesExtern => SpeziesExtern),
                                                                           PositionExtern   => Textposition);
            
            Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                            ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstand);
            AktuelleTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                                        TextbreiteExtern => AktuelleTextbreite);
            
         else
            null;
         end if;
               
      end loop EinheitenSchleife;
         
      Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.Zeilenabstand;
         
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeIDVorhanden'Range loop
            
         if
           ZusatztextExtern = LeseGebaeudeDatenbank.Anforderungen (SpeziesExtern => SpeziesExtern,
                                                                   IDExtern      => GebäudeSchleifenwert)
         then
            TextaccessverwaltungssystemEinfachGrafik.TextPositionZeichnen (TextaccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                           TextExtern       => GebaeudebeschreibungenGrafik.Kurzbeschreibung (IDExtern      => GebäudeSchleifenwert,
                                                                                                                                              SpeziesExtern => SpeziesExtern),
                                                                           PositionExtern   => Textposition);
         
            Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                            ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstand);
            AktuelleTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                                                                        TextbreiteExtern => AktuelleTextbreite);
               
         else
            null;
         end if;
            
      end loop GebäudeSchleife;
         
      Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      
      Viewfläche (ViewKonstanten.ForschungsmenüErmöglicht) := (AktuelleTextbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstand);
      
   end Ermöglicht;
   
   
   
   procedure Beschreibung
     (ZusatztextExtern : in ForschungenDatentypen.ForschungID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is begin
      
      Viewfläche (ViewKonstanten.ForschungsmenüBeschreibung)
        := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewKonstanten.ForschungsmenüBeschreibung),
                                                              VerhältnisExtern => (GrafikRecordKonstanten.Forschungsbereich (ViewKonstanten.ForschungsmenüBeschreibung).width,
                                                                                    GrafikRecordKonstanten.Forschungsbereich (ViewKonstanten.ForschungsmenüBeschreibung).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.ForschungsviewAccesse (ViewKonstanten.ForschungsmenüBeschreibung),
                                            GrößeExtern          => Viewfläche (ViewKonstanten.ForschungsmenüBeschreibung),
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Forschungsbereich (ViewKonstanten.ForschungsmenüBeschreibung));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Forschung_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche (ViewKonstanten.ForschungsmenüBeschreibung));
      
      case
        ZusatztextExtern
      is
         when ForschungKonstanten.LeerForschung =>
            null;
            
         when others =>
            Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstand;
            Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
            
            TextaccessverwaltungssystemEinfachGrafik.TextPositionZeichnen (TextaccessExtern => TextaccessVariablen.ForschungsmenüZusatztextAccess (SpeziesExtern, ZusatztextExtern),
                                                                           TextExtern       => ZeilenumbruchberechnungGrafik.Zeilenumbruchberechnung
                                                                             (TextExtern           => ForschungsbeschreibungenGrafik.Langbeschreibung (IDExtern      => ZusatztextExtern,
                                                                                                                                                       SpeziesExtern => SpeziesExtern),
                                                                              TextfeldbreiteExtern => Viewfläche (ViewKonstanten.ForschungsmenüBeschreibung).x,
                                                                              BreitenabzugExtern   => Textposition.x),
                                                                           PositionExtern   => Textposition);
      
            Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                            ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstand);
            
            Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.Zeilenabstand;
      
            Viewfläche (ViewKonstanten.ForschungsmenüBeschreibung).y := Textposition.y;
      end case;
              
   end Beschreibung;
   
   
   
   procedure Aktuell
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is begin
      
      Viewfläche (ViewKonstanten.ForschungsmenüAktuell)
        := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewKonstanten.ForschungsmenüAktuell),
                                                              VerhältnisExtern => (GrafikRecordKonstanten.Forschungsbereich (ViewKonstanten.ForschungsmenüAktuell).width,
                                                                                    GrafikRecordKonstanten.Forschungsbereich (ViewKonstanten.ForschungsmenüAktuell).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.ForschungsviewAccesse (ViewKonstanten.ForschungsmenüAktuell),
                                            GrößeExtern          => Viewfläche (ViewKonstanten.ForschungsmenüAktuell),
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Forschungsbereich (ViewKonstanten.ForschungsmenüAktuell));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Forschung_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche (ViewKonstanten.ForschungsmenüAktuell));
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      AktuelleTextbreite := GrafikKonstanten.Nullwert;
      
      AktuellesForschungsprojekt := LeseWichtiges.Forschungsprojekt (SpeziesExtern => SpeziesExtern);
      
      case
        AktuellesForschungsprojekt
      is
         when ForschungKonstanten.LeerForschung =>
            return;
            
         when others =>
            Text := Spieltexte.Zeug (TextnummernKonstanten.ZeugAktuellesForschungsprojekt) & " " & ForschungsbeschreibungenGrafik.Kurzbeschreibung (IDExtern      => AktuellesForschungsprojekt,
                                                                                                                                                    SpeziesExtern => SpeziesExtern);
            
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.AktuellesForschungsprojekt,
                                               str  => To_Wide_Wide_String (Source => Text));
      
            Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.AktuellesForschungsprojekt,
                                                                                    ViewbreiteExtern => Viewfläche (ViewKonstanten.ForschungsmenüAktuell).x);
      
            TextaccessverwaltungssystemEinfachGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.AktuellesForschungsprojekt,
                                                                       PositionExtern   => Textposition);
      
            AktuelleTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.AktuellesForschungsprojekt,
                                                                                        TextbreiteExtern => AktuelleTextbreite);
            Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                            ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstand);
      
            Forschungszeit := LeseWichtiges.VerbleibendeForschungszeit (SpeziesExtern => SpeziesExtern);
            Text := Spieltexte.Zeug (TextnummernKonstanten.ZeugVerbleibendeForschungszeit);
      end case;
      
      case
        Forschungszeit
      is
         when ProduktionDatentypen.Lagermenge'Last =>
            Text := Text & TextKonstanten.Unendlich;
            
         when others =>
            Text := Text & Forschungszeit'Wide_Wide_Image;
      end case;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.AktuellesForschungsprojekt,
                                         str  => To_Wide_Wide_String (Source => Text));
      
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.AktuellesForschungsprojekt,
                                                                              ViewbreiteExtern => Viewfläche (ViewKonstanten.ForschungsmenüAktuell).x);
      
      TextaccessverwaltungssystemEinfachGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.AktuellesForschungsprojekt,
                                                                 PositionExtern   => Textposition);
      
      AktuelleTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.AktuellesForschungsprojekt,
                                                                                  TextbreiteExtern => AktuelleTextbreite);
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstand);
            
      Viewfläche (ViewKonstanten.ForschungsmenüAktuell) := (AktuelleTextbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstand);
      
   end Aktuell;

end ForschungsauswahlGrafik;
