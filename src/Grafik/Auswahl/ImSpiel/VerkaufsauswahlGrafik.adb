with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.Text;
with Sf.Graphics.RenderWindow;

with Meldungstexte;
with TextnummernKonstanten;
with GrafikDatentypen;
with Views;
with TextaccessVariablen;
with InteraktionAuswahl;

with AllgemeineViewsGrafik;
with ViewsEinstellenGrafik;
with HintergrundGrafik;
with TextberechnungenHoeheGrafik;
with EinstellungenGrafik;
with TextberechnungenBreiteGrafik;
with TextfarbeGrafik;
with ZeilenumbruchberechnungGrafik;
with GebaeudebeschreibungenGrafik;

package body VerkaufsauswahlGrafik is

   procedure Verkaufsauswahl
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      AktuelleAuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert)
   is begin
      
      AllgemeineViewsGrafik.Überschrift (ÜberschriftExtern => To_Wide_Wide_String (Source => Meldungstexte.Frage (TextnummernKonstanten.FrageGebäudeverkauf)),
                                          HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                          SpielenamenExtern => False);
      
      Gebäude (AuswahlExtern    => AktuelleAuswahlExtern,
                ViewnummerExtern => 1,
                SpeziesExtern      => SpeziesExtern);
      
      InformationenGebäude (AuswahlExtern    => AktuelleAuswahlExtern,
                             ViewnummerExtern => 2,
                             SpeziesExtern      => SpeziesExtern);
      
   end Verkaufsauswahl;
   
   
   
   procedure Gebäude
     (AuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      ViewnummerExtern : in Positive;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      Viewfläche (ViewnummerExtern) := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                           VerhältnisExtern => (GrafikRecordKonstanten.Verkausmenübereich (ViewnummerExtern).width,
                                                                                                                 GrafikRecordKonstanten.Verkausmenübereich (ViewnummerExtern).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.VerkaufsviewAccesse (ViewnummerExtern),
                                            GrößeExtern          => Viewfläche (ViewnummerExtern),
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Verkausmenübereich (ViewnummerExtern));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche (ViewnummerExtern));
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      AktuelleTextbreite := 0.00;
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
         
         case
           InteraktionAuswahl.MöglicheGebäude (GebäudeSchleifenwert)
         is
            when True =>
               TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => Positive (GebäudeSchleifenwert),
                                                      AuswahlExtern    => Natural (AuswahlExtern),
                                                      TextaccessExtern => TextaccessVariablen.GebäudetextAccess (SpeziesExtern, GebäudeSchleifenwert));
               
               Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.GebäudetextAccess (SpeziesExtern, GebäudeSchleifenwert),
                                                                                       ViewbreiteExtern => Viewfläche (ViewnummerExtern).x);

               Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.GebäudetextAccess (SpeziesExtern, GebäudeSchleifenwert),
                                             position => Textposition);
                                                                      
               Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                               TextAccessExtern => TextaccessVariablen.GebäudetextAccess (SpeziesExtern, GebäudeSchleifenwert),
                                                                               ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
               
               AktuelleTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.GebäudetextAccess (SpeziesExtern, GebäudeSchleifenwert),
                                                                                           TextbreiteExtern => AktuelleTextbreite);
               
               InteraktionAuswahl.PositionenMöglicheGebäude (GebäudeSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.GebäudetextAccess (SpeziesExtern, GebäudeSchleifenwert));
               
               Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                                  text         => TextaccessVariablen.GebäudetextAccess (SpeziesExtern, GebäudeSchleifenwert));

            when False =>
               null;
         end case;
                                                                               
      end loop GebäudeSchleife;
      
      Viewfläche (ViewnummerExtern) := (AktuelleTextbreite, Textposition.y);
      
   end Gebäude;



   procedure InformationenGebäude
     (AuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      ViewnummerExtern : in Positive;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      Viewfläche (ViewnummerExtern) := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                           VerhältnisExtern => (GrafikRecordKonstanten.Verkausmenübereich (ViewnummerExtern).width,
                                                                                                                 GrafikRecordKonstanten.Verkausmenübereich (ViewnummerExtern).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.VerkaufsviewAccesse (ViewnummerExtern),
                                            GrößeExtern          => Viewfläche (ViewnummerExtern),
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Verkausmenübereich (ViewnummerExtern));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche (ViewnummerExtern));
      
      case
        AuswahlExtern
      is
         when 0 =>
            null;
            
         when others =>
            Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
            Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.GebäudezusatztextAccess (SpeziesExtern, AuswahlExtern),
                                          position => Textposition);
            
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.GebäudezusatztextAccess (SpeziesExtern, AuswahlExtern),
                                               str  => ZeilenumbruchberechnungGrafik.Zeilenumbruchberechnung (TextExtern           => GebaeudebeschreibungenGrafik.Langbeschreibung (IDExtern    => AuswahlExtern,
                                                                                                                                                                                     SpeziesExtern => SpeziesExtern),
                                                                                                              TextfeldbreiteExtern => Viewfläche (ViewnummerExtern).x / 2.00 - Textposition.x));
         
            Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                               text         => TextaccessVariablen.GebäudezusatztextAccess (SpeziesExtern, AuswahlExtern));
            
            Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                            TextAccessExtern => TextaccessVariablen.GebäudezusatztextAccess (SpeziesExtern, AuswahlExtern),
                                                                            ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
      
            Viewfläche (ViewnummerExtern) := Textposition;
      end case;
            
   end InformationenGebäude;

end VerkaufsauswahlGrafik;
