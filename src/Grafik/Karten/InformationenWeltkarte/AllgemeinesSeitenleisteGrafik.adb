pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.RenderWindow;
with Sf.Graphics;
with Sf.Graphics.Text;

with KartenRecords; use KartenRecords;
with KartengrundDatentypen; use KartengrundDatentypen;
with Views;
with GrafikDatentypen;
with Meldungstexte;
with TextnummernKonstanten;

with LeseWeltkarte;

with EinstellungenGrafik;
with TextberechnungenHoeheGrafik;
with ViewsEinstellenGrafik;
with HintergrundGrafik;
with TextberechnungenBreiteGrafik;
with AufgabenbeschreibungenGrafik;
with KartenbeschreibungenGrafik;

package body AllgemeinesSeitenleisteGrafik is
   
   procedure Leer
     (ViewbereichExtern : in Positive)
   is begin
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (GrafikRecordKonstanten.SeitenleisteWeltkartenbereich (ViewbereichExtern).width,
                                                                                              GrafikRecordKonstanten.SeitenleisteWeltkartenbereich (ViewbereichExtern).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.SeitenleisteWeltkarteAccesse (ViewbereichExtern),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.SeitenleisteWeltkartenbereich (ViewbereichExtern));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Seitenleiste_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);
      
   end Leer;
   
   

   procedure AllgemeineInformationen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
            
      Leer (ViewbereichExtern => 2);
      
      Textbreite := 0.00;
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      RealeYPosition := Textposition.y;
      
      AktuelleKoordinaten := SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell;
      VorhandenerGrund := LeseWeltkarte.VorhandenerGrund (KoordinatenExtern => AktuelleKoordinaten);
      
      TextAnzeigen (1) := True;
      
      if
        VorhandenerGrund.BasisGrund = VorhandenerGrund.AktuellerGrund
      then
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteAllgemeinesAccess (1),
                                            str  => KartenbeschreibungenGrafik.BeschreibungBasisgrund (KartenGrundExtern => VorhandenerGrund.AktuellerGrund));
         
      else
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteAllgemeinesAccess (1),
                                            str  => KartenbeschreibungenGrafik.BeschreibungBasisgrund (KartenGrundExtern => VorhandenerGrund.BasisGrund) & " "
                                            &  To_Wide_Wide_String (Source => Meldungstexte.Zeug (TextnummernKonstanten.ZeugMit)) & " "
                                            & KartenbeschreibungenGrafik.BeschreibungZusatzgrund (KartenGrundExtern => VorhandenerGrund.AktuellerGrund));
      end if;
      
      -- Eventuell auch mehr Wörter zusammenfassen? äöü
      -- Z.B. Ressourcen und Flüsse, Verbesserungen und Straßen. äöü
      KartenRessource := LeseWeltkarte.Ressource (KoordinatenExtern => AktuelleKoordinaten);
      
      case
        KartenRessource
      is
         when KartengrundDatentypen.Leer_Ressource_Enum =>
            TextAnzeigen (2) := False;
            
         when others =>
            TextAnzeigen (2) := True;
            
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteAllgemeinesAccess (2),
                                               str  => KartenbeschreibungenGrafik.BeschreibungRessource (KartenRessourceExtern => KartenRessource));
      end case;
      
      
      
      KartenVerbesserung := LeseWeltkarte.Verbesserung (KoordinatenExtern => AktuelleKoordinaten);
      
      case
        KartenVerbesserung
      is
         when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
            TextAnzeigen (3) := False;
            
         when others =>
            TextAnzeigen (3) := True;
            
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteAllgemeinesAccess (3),
                                               str  => AufgabenbeschreibungenGrafik.BeschreibungVerbesserung (KartenVerbesserungExtern => KartenVerbesserung));
      end case;
      
      
      
      KartenWeg := LeseWeltkarte.Weg (KoordinatenExtern => AktuelleKoordinaten);
      
      case
        KartenWeg
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            TextAnzeigen (4) := False;
            
         when others =>
            TextAnzeigen (4) := True;
            
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteAllgemeinesAccess (4),
                                               str  => AufgabenbeschreibungenGrafik.BeschreibungWeg (KartenWegExtern => KartenWeg));
      end case;
      
      
      
      KartenFluss := LeseWeltkarte.Fluss (KoordinatenExtern => AktuelleKoordinaten);
      
      case
        KartenFluss
      is
         when KartengrundDatentypen.Leer_Fluss_Enum =>
            TextAnzeigen (5) := False;
            
         when others =>
            TextAnzeigen (5) := True;
            
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteAllgemeinesAccess (5),
                                               str  => KartenbeschreibungenGrafik.BeschreibungFluss (KartenFlussExtern => KartenFluss));
      end case;
               
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.KarteAllgemeinesAccess'Range loop
         
         case
           TextAnzeigen (TextSchleifenwert)
         is
            when True =>
               Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteAllgemeinesAccess (TextSchleifenwert),
                                             position => (Textposition.x, RealeYPosition));
               
               Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                                  text         => TextaccessVariablen.KarteAllgemeinesAccess (TextSchleifenwert));
               
               RealeYPosition := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => RealeYPosition,
                                                                               TextAccessExtern => TextaccessVariablen.KarteAllgemeinesAccess (TextSchleifenwert),
                                                                               ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
               
            when False =>
               null;
         end case;
         
         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.KarteAllgemeinesAccess (TextSchleifenwert),
                                                                             TextbreiteExtern => Textbreite);
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         TextAccessExtern => TextaccessVariablen.KarteAllgemeinesAccess (TextSchleifenwert),
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
         
      end loop TextSchleife;
            
      Viewfläche := (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);

   end AllgemeineInformationen;

end AllgemeinesSeitenleisteGrafik;
