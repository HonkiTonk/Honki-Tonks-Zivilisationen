pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

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
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      AktuelleAuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert)
   is begin
      
      AllgemeineViewsGrafik.Überschrift (ÜberschriftExtern => To_Wide_Wide_String (Source => Meldungstexte.Frage (TextnummernKonstanten.FrageGebäudeverkauf)),
                                          HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum);
      
      Gebäude (AuswahlExtern    => AktuelleAuswahlExtern,
                ViewnummerExtern => 1,
                RasseExtern      => RasseExtern);
      
      InformationenGebäude (AuswahlExtern    => AktuelleAuswahlExtern,
                             ViewnummerExtern => 2,
                             RasseExtern      => RasseExtern);
      
   end Verkaufsauswahl;
   
   
   
   procedure Gebäude
     (AuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      ViewnummerExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Viewfläche (ViewnummerExtern) := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                           VerhältnisExtern => (1.00, 1.00));
      
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
                                                      TextaccessExtern => TextaccessVariablen.GebäudetextAccess (RasseExtern, GebäudeSchleifenwert));
               
               Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.GebäudetextAccess (RasseExtern, GebäudeSchleifenwert),
                                                                                       ViewbreiteExtern => Viewfläche (ViewnummerExtern).x);

               Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.GebäudetextAccess (RasseExtern, GebäudeSchleifenwert),
                                             position => Textposition);
                                                                      
               Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                               TextAccessExtern => TextaccessVariablen.GebäudetextAccess (RasseExtern, GebäudeSchleifenwert),
                                                                               ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
               
               AktuelleTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.GebäudetextAccess (RasseExtern, GebäudeSchleifenwert),
                                                                                           TextbreiteExtern => AktuelleTextbreite);
               
               InteraktionAuswahl.PositionenMöglicheGebäude (GebäudeSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.GebäudetextAccess (RasseExtern, GebäudeSchleifenwert));
               
               Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                                  text         => TextaccessVariablen.GebäudetextAccess (RasseExtern, GebäudeSchleifenwert));

            when False =>
               null;
         end case;
                                                                               
      end loop GebäudeSchleife;
      
      Viewfläche (ViewnummerExtern) := (AktuelleTextbreite, Textposition.y);
      
   end Gebäude;



   procedure InformationenGebäude
     (AuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      ViewnummerExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Viewfläche (ViewnummerExtern) := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (ViewnummerExtern),
                                                                                           VerhältnisExtern => (1.00, 1.00));
      
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
      
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.GebäudezusatztextAccess (RasseExtern, AuswahlExtern),
                                          position => Textposition);
            
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.GebäudezusatztextAccess (RasseExtern, AuswahlExtern),
                                               str  => ZeilenumbruchberechnungGrafik.Zeilenumbruchberechnung (TextExtern           => GebaeudebeschreibungenGrafik.BeschreibungLang (IDExtern    => AuswahlExtern,
                                                                                                                                                                                     RasseExtern => RasseExtern),
                                                                                                              TextfeldbreiteExtern => Viewfläche (ViewnummerExtern).x / 2.00 - Textposition.x));
         
            Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                               text         => TextaccessVariablen.GebäudezusatztextAccess (RasseExtern, AuswahlExtern));
            
            Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                            TextAccessExtern => TextaccessVariablen.GebäudezusatztextAccess (RasseExtern, AuswahlExtern),
                                                                            ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
      
            Viewfläche (ViewnummerExtern) := Textposition;
      end case;
            
   end InformationenGebäude;

end VerkaufsauswahlGrafik;
