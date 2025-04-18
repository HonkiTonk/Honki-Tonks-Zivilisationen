with Sf.Graphics.Text;

with GrafikDatentypen;
with Spieltexte;
with TextnummernKonstanten;
with TextaccessVariablen;
with Views;
with ViewKonstanten;
with GrafikKonstanten;
with AuswahlKonstanten;
with TextDatentypen;

with TextberechnungenBreiteGrafik;
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
      AktuelleAufteilungExtern : in StadtDatentypen.Bauprojektart_Enum)
   is begin
      
      AllgemeineViewsGrafik.Überschrift (ÜberschriftExtern => To_Wide_Wide_String (Source => Spieltexte.Fragen (TextnummernKonstanten.FrageBauprojekt)),
                                          HintergrundExtern => GrafikDatentypen.Bauen_Enum,
                                          SpielenamenExtern => False);
      
      Bauaufteilung (BauprojektartExtern      => AktuelleAuswahlExtern.Bauprojektart,
                     AktuelleAufteilungExtern => AktuelleAufteilungExtern,
                     SpeziesExtern            => BauauswahlExtern.Spezies);
      
      case
        AktuelleAufteilungExtern
      is
         when StadtDatentypen.Gebäudeart_Enum =>
            BaulistenviewEinstellen (AuswahlExtern        => Natural (AktuelleAuswahlExtern.Gebäude),
                                     SpeziesExtern        => BauauswahlExtern.Spezies,
                                     GebäudeEinheitExtern => True);
            
         when StadtDatentypen.Einheitenart_Enum =>
            BaulistenviewEinstellen (AuswahlExtern        => Natural (AktuelleAuswahlExtern.Einheit),
                                     SpeziesExtern        => BauauswahlExtern.Spezies,
                                     GebäudeEinheitExtern => False);
            
         when others =>
            null;
      end case;
      
      Aktuell (BauauswahlExtern => BauauswahlExtern);
      
   end Bauauswahl;
   
   
   
   procedure Bauaufteilung
     (BauprojektartExtern : in StadtDatentypen.Bauprojektart_Enum;
      AktuelleAufteilungExtern : in StadtDatentypen.Bauprojektart_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is
      use type StadtDatentypen.Bauprojektart_Enum;
   begin
      
      case
        SpeziesExtern
      is
         when others =>
            null;
      end case;
      
      ViewflächeAufteilung := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => ViewflächeAufteilung,
                                                                                  VerhältnisExtern => (GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüKategorie).width,
                                                                                                        GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüKategorie).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewKonstanten.BaumenüKategorie),
                                            GrößeExtern          => ViewflächeAufteilung,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüKategorie));
      
      HintergrundGrafik.Aufteilung (HintergrundExtern => GrafikDatentypen.Bauen_Enum,
                                    AbmessungenExtern => ViewflächeAufteilung);
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      Textposition.x := TextberechnungenBreiteGrafik.Spaltenabstand;
      
      AufteilungSchleife:
      for AufteilungSchleifenwert in InteraktionAuswahl.PositionenBauaufteilung'Range loop
         
         if
           BauprojektartExtern = AufteilungSchleifenwert
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
            
      case
        SpeziesExtern
      is
         when others =>
            null;
      end case;
      
      ViewflächeBauliste := ViewsEinstellenGrafik.ViewflächeWaagerechteFestSenkrechteVariabel (ViewflächeExtern => ViewflächeBauliste,
                                                                              VerhältnisExtern => (GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüBauliste).width,
                                                                                                    GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüBauliste).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewKonstanten.BaumenüBauliste),
                                            GrößeExtern          => ViewflächeBauliste,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüBauliste));
      
      HintergrundGrafik.Aufteilung (HintergrundExtern => GrafikDatentypen.Bauen_Enum,
                                    AbmessungenExtern => ViewflächeBauliste);
      
      case
        GebäudeEinheitExtern
      is
         when True =>
            ViewflächeBauliste.y := Gebäude (AuswahlExtern        => StadtDatentypen.GebäudeID (AuswahlExtern),
                                               SpeziesExtern        => SpeziesExtern,
                                               BauenVerkaufenExtern => True,
                                               BaulisteExtern       => InteraktionAuswahl.MöglicheBauoptionen);
            
         when False =>
            ViewflächeBauliste.y := Einheiten (AuswahlExtern  => EinheitenDatentypen.EinheitenID (AuswahlExtern),
                                                SpeziesExtern  => SpeziesExtern,
                                                BaulisteExtern => InteraktionAuswahl.MöglicheBauoptionen);
      end case;
      
   end BaulistenviewEinstellen;
   
   
   
   function Gebäude
     (AuswahlExtern : in StadtDatentypen.GebäudeID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      BauenVerkaufenExtern : in Boolean;
      BaulisteExtern : in InteraktionAuswahl.MöglicheBauoptionenArray)
      return Float
   is begin
      
      case
        SpeziesExtern
      is
         when others =>
            null;
      end case;

      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstand;

      GebäudeSchleife:
      for GebäudeSchleifenwert in InteraktionAuswahl.BaulisteAnfang .. InteraktionAuswahl.BaulisteEnde loop
         
         case
           BaulisteExtern (GebäudeSchleifenwert)
         is
            when AuswahlKonstanten.LeerAuswahl =>
               Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                               ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstand);
               
               Auswahlposition := GrafikRecordKonstanten.Leerbereich;

            when others =>
               Textposition.y := TextaccessverwaltungssystemErweitertGrafik.SkalierenFarbeZeichnen (TextpositionExtern       => Textposition,
                                                                                                    MaximaleTextbreiteExtern => ViewflächeBauliste.x - TextberechnungenBreiteGrafik.KleinerSpaltenabstand,
                                                                                                    TextAccessExtern         =>
                                                                                                       TextaccessVariablen.GebäudetextAccess (SpeziesExtern,
                                                                                                      StadtDatentypen.GebäudeIDVorhanden (BaulisteExtern (GebäudeSchleifenwert))),
                                                                                                    FarbeExtern              =>
                                                                                                       TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => GebäudeSchleifenwert,
                                                                                                                                              AuswahlExtern    => Natural (AuswahlExtern)));

               Auswahlposition := Sf.Graphics.Text.getGlobalBounds
                 (text => TextaccessVariablen.GebäudetextAccess (SpeziesExtern, StadtDatentypen.GebäudeID (BaulisteExtern (GebäudeSchleifenwert))));
         end case;
         
         InteraktionAuswahl.PositionenBaumöglichkeiten (GebäudeSchleifenwert) := Auswahlposition;

      end loop GebäudeSchleife;
      
      if
        BaulisteExtern (InteraktionAuswahl.BaulisteZurück) = AuswahlKonstanten.ErstAuswahl
        and
          BaulisteExtern (InteraktionAuswahl.BaulisteWeiter) = AuswahlKonstanten.ErstAuswahl
      then
         LeerYTextposition := TextaccessverwaltungssystemErweitertGrafik.SkalierenFarbeZeichnen (TextpositionExtern       => Textposition,
                                                                                                 MaximaleTextbreiteExtern => ViewflächeBauliste.x,
                                                                                                 TextAccessExtern         => TextaccessVariablen.ZeugAccess (TextnummernKonstanten.ZeugZurück),
                                                                                                 FarbeExtern              => TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => InteraktionAuswahl.BaulisteZurück,
                                                                                                                                                                    AuswahlExtern    => Natural (AuswahlExtern)));
         
         InteraktionAuswahl.PositionenBaumöglichkeiten (InteraktionAuswahl.BaulisteZurück) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.ZeugAccess (TextnummernKonstanten.ZeugZurück));
         
         Textposition.y := TextaccessverwaltungssystemErweitertGrafik.SkalierenFarbeZeichnen (TextpositionExtern       => (Textposition.x + ViewflächeBauliste.x / 2.00, Textposition.y),
                                                                                              MaximaleTextbreiteExtern => ViewflächeBauliste.x - TextberechnungenBreiteGrafik.KleinerSpaltenabstand,
                                                                                              TextAccessExtern         => TextaccessVariablen.ZeugAccess (TextnummernKonstanten.ZeugWeiter),
                                                                                              FarbeExtern              => TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => InteraktionAuswahl.BaulisteWeiter,
                                                                                                                                                                 AuswahlExtern    => Natural (AuswahlExtern)));
               
         InteraktionAuswahl.PositionenBaumöglichkeiten (InteraktionAuswahl.BaulisteWeiter) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.ZeugAccess (TextnummernKonstanten.ZeugWeiter));
         
      elsif
        BaulisteExtern (InteraktionAuswahl.BaulisteZurück) = AuswahlKonstanten.ErstAuswahl
      then
         Textposition.y := TextaccessverwaltungssystemErweitertGrafik.SkalierenFarbeZeichnen (TextpositionExtern       => Textposition,
                                                                                              MaximaleTextbreiteExtern => ViewflächeBauliste.x - TextberechnungenBreiteGrafik.KleinerSpaltenabstand,
                                                                                              TextAccessExtern         => TextaccessVariablen.ZeugAccess (TextnummernKonstanten.ZeugZurück),
                                                                                              FarbeExtern              => TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => InteraktionAuswahl.BaulisteZurück,
                                                                                                                                                                 AuswahlExtern    => Natural (AuswahlExtern)));
               
         InteraktionAuswahl.PositionenBaumöglichkeiten (InteraktionAuswahl.BaulisteZurück) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.ZeugAccess (TextnummernKonstanten.ZeugZurück));
         
      elsif
        BaulisteExtern (InteraktionAuswahl.BaulisteWeiter) = AuswahlKonstanten.ErstAuswahl
      then
         Textposition.y := TextaccessverwaltungssystemErweitertGrafik.SkalierenFarbeZeichnen (TextpositionExtern       => Textposition,
                                                                                              MaximaleTextbreiteExtern => ViewflächeBauliste.x - TextberechnungenBreiteGrafik.KleinerSpaltenabstand,
                                                                                              TextAccessExtern         => TextaccessVariablen.ZeugAccess (TextnummernKonstanten.ZeugWeiter),
                                                                                              FarbeExtern              => TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => InteraktionAuswahl.BaulisteWeiter,
                                                                                                                                                                 AuswahlExtern    => Natural (AuswahlExtern)));
               
         InteraktionAuswahl.PositionenBaumöglichkeiten (InteraktionAuswahl.BaulisteWeiter) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.ZeugAccess (TextnummernKonstanten.ZeugWeiter));
         
      else
         null;
      end if;

      Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstand;

      case
        Natural (AuswahlExtern)
      is
         when InteraktionAuswahl.BaulisteZurück .. InteraktionAuswahl.BaulisteWeiter =>
            BauauswahlGebaeudeGrafik.Informationen (AuswahlExtern        => AuswahlKonstanten.LeerGebäudeauswahl,
                                                    SpeziesExtern        => SpeziesExtern,
                                                    BauenVerkaufenExtern => BauenVerkaufenExtern);
            
         when others =>
            BauauswahlGebaeudeGrafik.Informationen (AuswahlExtern        => AuswahlExtern,
                                                    SpeziesExtern        => SpeziesExtern,
                                                    BauenVerkaufenExtern => BauenVerkaufenExtern);
      end case;
      
      return Textposition.y;

   end Gebäude;
   
   
   
   function Einheiten
     (AuswahlExtern : in EinheitenDatentypen.EinheitenID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      BaulisteExtern : in InteraktionAuswahl.MöglicheBauoptionenArray)
      return Float
   is begin
      
      case
        SpeziesExtern
      is
         when others =>
            null;
      end case;
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstand;
          
      EinheitenSchleife:
      for EinheitenSchleifenwert in InteraktionAuswahl.BaulisteAnfang .. InteraktionAuswahl.BaulisteEnde loop
         
         case
           BaulisteExtern (EinheitenSchleifenwert)
         is
            when AuswahlKonstanten.LeerAuswahl =>
               Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                               ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstand);
               
               Auswahlposition := GrafikRecordKonstanten.Leerbereich;

            when others =>
               Textposition.y := TextaccessverwaltungssystemErweitertGrafik.SkalierenFarbeZeichnen (TextpositionExtern       => Textposition,
                                                                                                    MaximaleTextbreiteExtern => ViewflächeBauliste.x - TextberechnungenBreiteGrafik.KleinerSpaltenabstand,
                                                                                                    TextAccessExtern         => TextaccessVariablen.EinheitentextAccess (SpeziesExtern,
                                                                                                      EinheitenDatentypen.EinheitenIDVorhanden (BaulisteExtern (EinheitenSchleifenwert))),
                                                                                                    FarbeExtern              => TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => EinheitenSchleifenwert,
                                                                                                                                                                       AuswahlExtern    => Natural (AuswahlExtern)));
               
               
               -- Sollte auch mit EinheitenIDVorhanden anstelle von EinheitenID funktionieren, tut es aber nicht. Später mal herausfinden warum. äöü
               -- Das Problem existiert auch bei den Gebäuden. äöü
               Auswahlposition := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.EinheitentextAccess (SpeziesExtern, EinheitenDatentypen.EinheitenID (BaulisteExtern (EinheitenSchleifenwert))));
         end case;
         
         InteraktionAuswahl.PositionenBaumöglichkeiten (EinheitenSchleifenwert) := Auswahlposition;
         
      end loop EinheitenSchleife;
      
      if
        BaulisteExtern (InteraktionAuswahl.BaulisteZurück) = AuswahlKonstanten.ErstAuswahl
        and
          BaulisteExtern (InteraktionAuswahl.BaulisteWeiter) = AuswahlKonstanten.ErstAuswahl
      then
         LeerYTextposition := TextaccessverwaltungssystemErweitertGrafik.SkalierenFarbeZeichnen (TextpositionExtern       => Textposition,
                                                                                                 MaximaleTextbreiteExtern => ViewflächeBauliste.x - TextberechnungenBreiteGrafik.KleinerSpaltenabstand,
                                                                                                 TextAccessExtern         => TextaccessVariablen.ZeugAccess (TextnummernKonstanten.ZeugZurück),
                                                                                                 FarbeExtern              => TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => InteraktionAuswahl.BaulisteZurück,
                                                                                                                                                                    AuswahlExtern    => Natural (AuswahlExtern)));
         
         InteraktionAuswahl.PositionenBaumöglichkeiten (InteraktionAuswahl.BaulisteZurück) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.ZeugAccess (TextnummernKonstanten.ZeugZurück));
         
         Textposition.y := TextaccessverwaltungssystemErweitertGrafik.SkalierenFarbeZeichnen (TextpositionExtern       => (Textposition.x + ViewflächeBauliste.x / 2.00, Textposition.y),
                                                                                              MaximaleTextbreiteExtern => ViewflächeBauliste.x - TextberechnungenBreiteGrafik.KleinerSpaltenabstand,
                                                                                              TextAccessExtern         => TextaccessVariablen.ZeugAccess (TextnummernKonstanten.ZeugWeiter),
                                                                                              FarbeExtern              => TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => InteraktionAuswahl.BaulisteWeiter,
                                                                                                                                                                 AuswahlExtern    => Natural (AuswahlExtern)));
               
         InteraktionAuswahl.PositionenBaumöglichkeiten (InteraktionAuswahl.BaulisteWeiter) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.ZeugAccess (TextnummernKonstanten.ZeugWeiter));
         
      elsif
        BaulisteExtern (InteraktionAuswahl.BaulisteZurück) = AuswahlKonstanten.ErstAuswahl
      then
         Textposition.y := TextaccessverwaltungssystemErweitertGrafik.SkalierenFarbeZeichnen (TextpositionExtern       => Textposition,
                                                                                              MaximaleTextbreiteExtern => ViewflächeBauliste.x - TextberechnungenBreiteGrafik.KleinerSpaltenabstand,
                                                                                              TextAccessExtern         => TextaccessVariablen.ZeugAccess (TextnummernKonstanten.ZeugZurück),
                                                                                              FarbeExtern              => TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => InteraktionAuswahl.BaulisteZurück,
                                                                                                                                                                 AuswahlExtern    => Natural (AuswahlExtern)));
               
         InteraktionAuswahl.PositionenBaumöglichkeiten (InteraktionAuswahl.BaulisteZurück) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.ZeugAccess (TextnummernKonstanten.ZeugZurück));
         
      elsif
        BaulisteExtern (InteraktionAuswahl.BaulisteWeiter) = AuswahlKonstanten.ErstAuswahl
      then
         Textposition.y := TextaccessverwaltungssystemErweitertGrafik.SkalierenFarbeZeichnen (TextpositionExtern       => Textposition,
                                                                                              MaximaleTextbreiteExtern => ViewflächeBauliste.x - TextberechnungenBreiteGrafik.KleinerSpaltenabstand,
                                                                                              TextAccessExtern         => TextaccessVariablen.ZeugAccess (TextnummernKonstanten.ZeugWeiter),
                                                                                              FarbeExtern              => TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => InteraktionAuswahl.BaulisteWeiter,
                                                                                                                                                                 AuswahlExtern    => Natural (AuswahlExtern)));
               
         InteraktionAuswahl.PositionenBaumöglichkeiten (InteraktionAuswahl.BaulisteWeiter) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.ZeugAccess (TextnummernKonstanten.ZeugWeiter));
         
      else
         Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      end if;
      
      Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      
      case
        Natural (AuswahlExtern)
      is
         when InteraktionAuswahl.BaulisteZurück .. InteraktionAuswahl.BaulisteWeiter =>
            BauauswahlEinheitenGrafik.Einheiteninformationen (AuswahlExtern => AuswahlKonstanten.LeerEinheitenauswahl,
                                                              SpeziesExtern => SpeziesExtern);
            
         when others =>
            BauauswahlEinheitenGrafik.Einheiteninformationen (AuswahlExtern => AuswahlExtern,
                                                              SpeziesExtern => SpeziesExtern);
      end case;
      
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
      
      HintergrundGrafik.Aufteilung (HintergrundExtern => GrafikDatentypen.Bauen_Enum,
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
