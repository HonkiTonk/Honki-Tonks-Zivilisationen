with Sf.Graphics.Text;

with GrafikDatentypen;
with Spieltexte;
with TextnummernKonstanten;
with TextaccessVariablen;
with Views;
with ViewKonstanten;
with StadtKonstanten;
with GrafikKonstanten;
with AuswahlKonstanten;
with TextDatentypen;

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
with TexteinstellungenGrafik;
with StandardtexteGrafik;

-- Kann man das so anpassen dass eine teilweise Verschmelzung mit VerkaufsauswahlGrafik möglich wäre? äöü
package body BauauswahlGrafik is

   procedure Bauauswahl
     (BauauswahlExtern : in StadtGrafikRecords.BaumenüGrafikRecord;
      AktuelleAuswahlExtern : in StadtRecords.ErweiterterBauprojektRecord;
      AktuelleAufteilungExtern : in Positive)
   is begin
      
      AllgemeineViewsGrafik.Überschrift (ÜberschriftExtern => To_Wide_Wide_String (Source => Spieltexte.Fragen (TextnummernKonstanten.FrageBauprojekt)),
                                          HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                          SpielenamenExtern => False);
      
      Bauaufteilung (AusgewählteAufteilungExtern => AktuelleAuswahlExtern.BaumenüanzeigeÄndern,
                     AktuelleAufteilungExtern    => AktuelleAufteilungExtern);
      
      case
        AktuelleAufteilungExtern
      is
         when StadtKonstanten.BaumenüGebäude =>
            BaulistenviewEinstellen (AuswahlExtern        => Natural (AktuelleAuswahlExtern.Gebäude),
                                     SpeziesExtern        => BauauswahlExtern.Spezies,
                                     GebäudeEinheitExtern => True);
            
         when StadtKonstanten.BaumenüEinheiten =>
            BaulistenviewEinstellen (AuswahlExtern        => Natural (AktuelleAuswahlExtern.Einheit),
                                     SpeziesExtern        => BauauswahlExtern.Spezies,
                                     GebäudeEinheitExtern => False);
            
         when others =>
            null;
      end case;
      
      Aktuell (BauauswahlExtern => BauauswahlExtern);
      
   end Bauauswahl;
   
   
   
   procedure Bauaufteilung
     (AusgewählteAufteilungExtern : in Natural;
      AktuelleAufteilungExtern : in Positive)
   is begin
      
      ViewflächeAufteilung := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => ViewflächeAufteilung,
                                                                                  VerhältnisExtern => (GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüKategorie).width,
                                                                                                        GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüKategorie).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewKonstanten.BaumenüKategorie),
                                            GrößeExtern          => ViewflächeAufteilung,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüKategorie));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                     AbmessungenExtern => ViewflächeAufteilung);
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      Textposition.x := TextberechnungenBreiteGrafik.Spaltenabstand;
      
      AufteilungSchleife:
      for AufteilungSchleifenwert in InteraktionAuswahl.PositionenBauaufteilung'Range loop
         
         if
           AusgewählteAufteilungExtern = AufteilungSchleifenwert
         then
            Farbe := TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Ausgewählt_Enum);
            
         elsif
           AktuelleAufteilungExtern = AufteilungSchleifenwert
         then
            Farbe := TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Aktiver_Menübereich_Enum);
           
         else
            Farbe := TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Standard_Enum);
         end if;
         
         TextaccessverwaltungssystemEinfachGrafik.PositionFarbeZeichnen (TextaccessExtern => TextaccessVariablen.GebäudeaufteilungAccess (AufteilungSchleifenwert),
                                                                         PositionExtern   => Textposition,
                                                                         FarbeExtern      => Farbe);
         
         InteraktionAuswahl.PositionenBauaufteilung (AufteilungSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.GebäudeaufteilungAccess (AufteilungSchleifenwert));
      
         Textposition.x := Textposition.x + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.GebäudeaufteilungAccess (AufteilungSchleifenwert)).width
           + GrafikKonstanten.Verdoppelung * TextberechnungenBreiteGrafik.Spaltenabstand;
         
      end loop AufteilungSchleife;
      
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstand);
      
      ViewflächeAufteilung := Textposition;
      
   end Bauaufteilung;
   
   
   
   procedure BaulistenviewEinstellen
     (AuswahlExtern : in Natural;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      GebäudeEinheitExtern : in Boolean)
   is begin
      
      ViewflächeBauliste := ViewsEinstellenGrafik.ViewflächeXFestYVariabel (ViewflächeExtern => ViewflächeBauliste,
                                                                              VerhältnisExtern => (GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüBauliste).width,
                                                                                                    GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüBauliste).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewKonstanten.BaumenüBauliste),
                                            GrößeExtern          => ViewflächeBauliste,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüBauliste));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                     AbmessungenExtern => ViewflächeBauliste);
      
      case
        GebäudeEinheitExtern
      is
         when True =>
            ViewflächeBauliste.y := Gebäude (AuswahlExtern        => StadtDatentypen.GebäudeID (AuswahlExtern),
                                             SpeziesExtern        => SpeziesExtern,
                                             BauenVerkaufenExtern => True);
            
         when False =>
            ViewflächeBauliste.y := Einheiten (AuswahlExtern => EinheitenDatentypen.EinheitenID (AuswahlExtern),
                                                SpeziesExtern => SpeziesExtern);
      end case;
      
   end BaulistenviewEinstellen;
   
   
   
   function Gebäude
     (AuswahlExtern : in StadtDatentypen.GebäudeID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      BauenVerkaufenExtern : in Boolean)
      return Float
   is begin
      
      Listenanfang := StadtDatentypen.GebäudeIDVorhanden'First;
      Listenende := StadtDatentypen.GebäudeIDVorhanden'Last;
      AktuelleListenlänge := 0;

      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstand;
      
      -- Vielleicht erst alle Elemente prüfen und bei einem zweiten Durchgang aufteilen? äöü
      GebäudeSchleife:
      for GebäudeSchleifenwert in Listenanfang .. Listenende loop
         
         case
           InteraktionAuswahl.MöglicheGebäude (GebäudeSchleifenwert)
         is
            when True =>
               Textposition.y := TextaccessverwaltungssystemErweitertGrafik.SkalierenFarbeZeichnen (TextpositionExtern       => Textposition,
                                                                                                    MaximaleTextbreiteExtern => ViewflächeBauliste.x,
                                                                                                    TextAccessExtern         => TextaccessVariablen.GebäudetextAccess (SpeziesExtern, GebäudeSchleifenwert),
                                                                                                    FarbeExtern              => TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => Positive (GebäudeSchleifenwert),
                                                                                                                                                                       AuswahlExtern    => Natural (AuswahlExtern)));
               
               InteraktionAuswahl.PositionenGebäudeBauen (GebäudeSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.GebäudetextAccess (SpeziesExtern, GebäudeSchleifenwert));

               AktuelleListenlänge := AktuelleListenlänge + 1;
               
               if
                 AktuelleListenlänge >= 14
               then
                  null;
                  -- Listenanfang := GebäudeSchleifenwert + 1;
                  
               else
                  null;
               end if;

            when False =>
               null;
         end case;
                                                                               
      end loop GebäudeSchleife;
      
      Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      
      BauauswahlGebaeudeGrafik.Informationen (AuswahlExtern        => AuswahlExtern,
                                              SpeziesExtern        => SpeziesExtern,
                                              BauenVerkaufenExtern => BauenVerkaufenExtern);
      
      return Textposition.y;

   end Gebäude;
   
   
   
   function Einheiten
     (AuswahlExtern : in EinheitenDatentypen.EinheitenID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Float
   is begin
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstand;
          
      EinheitenSchleife:
      for EinheitenSchleifenwert in EinheitenDatentypen.EinheitenIDVorhanden'Range loop
         
         case
           InteraktionAuswahl.MöglicheEinheiten (EinheitenSchleifenwert)
         is
            when True =>
               Textposition.y := TextaccessverwaltungssystemErweitertGrafik.SkalierenFarbeZeichnen (TextpositionExtern       => Textposition,
                                                                                                    MaximaleTextbreiteExtern => ViewflächeBauliste.x,
                                                                                                    TextAccessExtern         => TextaccessVariablen.EinheitentextAccess (SpeziesExtern, EinheitenSchleifenwert),
                                                                                                    FarbeExtern              => TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => Positive (EinheitenSchleifenwert),
                                                                                                                                                                       AuswahlExtern    => Natural (AuswahlExtern)));
               
               InteraktionAuswahl.PositionenEinheitenBauen (EinheitenSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.EinheitentextAccess (SpeziesExtern, EinheitenSchleifenwert));

            when False =>
               null;
         end case;
         
      end loop EinheitenSchleife;
      
      Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      
      BauauswahlEinheitenGrafik.Einheiteninformationen (AuswahlExtern => AuswahlExtern,
                                                        SpeziesExtern => SpeziesExtern);
      
      return Textposition.y;
      
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
      
      Text := Text & StandardtexteGrafik.Bauzeit (BauzeitExtern => BauauswahlExtern.Bauzeit);
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
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
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstand);
                  
      ViewflächeAktuell := (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstand);
      
   end Aktuell;

end BauauswahlGrafik;
