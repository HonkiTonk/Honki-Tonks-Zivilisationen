with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics;
with Sf.Graphics.Text;

with Meldungstexte;
with TextnummernKonstanten;
with KartengrundDatentypen;
with ViewKonstanten;

with LeseWeltkarte;
with LeseCursor;

with TextaccessverwaltungssystemGrafik;
with TextberechnungenHoeheGrafik;
with TextberechnungenBreiteGrafik;
with AufgabenbeschreibungenGrafik;
with KartenbeschreibungenGrafik;
with SeitenleisteLeerenGrafik;

package body AllgemeinesSeitenleisteGrafik is

   -- Den ganzen Text in ein Array zusammenfassen und in der Schleife abarbeiten? äöü
   -- Alternativ auch bei leerem Text ein Zeichen setzen um einen gleichmäßigeren Abstand zu erhalten? äöü
   procedure AllgemeineInformationen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      Viewfläche := SeitenleisteLeerenGrafik.Leer (AnzeigebereichExtern => ViewKonstanten.WeltAllgemeines,
                                                    ViewflächeExtern     => Viewfläche);
      
      Textbreite := 0.00;
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      RealeYPosition := Textposition.y;
      
      AktuelleKoordinaten := LeseCursor.KoordinatenAktuell (SpeziesExtern => SpeziesExtern);
      Gesamtgrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => AktuelleKoordinaten);
      
      TextAnzeigen (1) := True;
      
      case
        Gesamtgrund.Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteAllgemeinesAccess (1),
                                               str  => KartenbeschreibungenGrafik.KurzbeschreibungBasisgrund (KartenGrundExtern => Gesamtgrund.Basisgrund));
         
         when others =>
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteAllgemeinesAccess (1),
                                               str  => KartenbeschreibungenGrafik.KurzbeschreibungBasisgrund (KartenGrundExtern => Gesamtgrund.Basisgrund) & " "
                                               &  To_Wide_Wide_String (Source => Meldungstexte.Zeug (TextnummernKonstanten.ZeugMit)) & " "
                                               & KartenbeschreibungenGrafik.KurzbeschreibungZusatzgrund (KartenGrundExtern => Gesamtgrund.Zusatzgrund));
      end case;
      
      -- Eventuell auch mehr Wörter zusammenfassen? äöü
      -- Z.B. Ressourcen und Flüsse, Verbesserungen und Straßen. äöü
      KartenRessource := LeseWeltkarte.Ressource (KoordinatenExtern => AktuelleKoordinaten);
      
      case
        KartenRessource
      is
         when KartenextraDatentypen.Leer_Ressource_Enum =>
            TextAnzeigen (2) := False;
            
         when others =>
            TextAnzeigen (2) := True;
            
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteAllgemeinesAccess (2),
                                               str  => KartenbeschreibungenGrafik.KurzbeschreibungRessource (KartenRessourceExtern => KartenRessource));
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
                                               str  => AufgabenbeschreibungenGrafik.KurzbeschreibungVerbesserung (KartenVerbesserungExtern => KartenVerbesserung));
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
                                               str  => AufgabenbeschreibungenGrafik.KurzbeschreibungWeg (KartenWegExtern => KartenWeg));
      end case;
      
      
      
      KartenFluss := LeseWeltkarte.Fluss (KoordinatenExtern => AktuelleKoordinaten);
      
      case
        KartenFluss
      is
         when KartenextraDatentypen.Leer_Fluss_Enum =>
            TextAnzeigen (5) := False;
            
         when others =>
            TextAnzeigen (5) := True;
            
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteAllgemeinesAccess (5),
                                               str  => KartenbeschreibungenGrafik.KurzbeschreibungFluss (KartenFlussExtern => KartenFluss));
      end case;
               
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.KarteAllgemeinesAccess'Range loop
         
         case
           TextAnzeigen (TextSchleifenwert)
         is
            when True =>
               TextaccessverwaltungssystemGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.KarteAllgemeinesAccess (TextSchleifenwert),
                                                                   PositionExtern   => (Textposition.x, RealeYPosition));
               
               RealeYPosition := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => RealeYPosition,
                                                                               TextAccessExtern => TextaccessVariablen.KarteAllgemeinesAccess (TextSchleifenwert),
                                                                               ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
               
               Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.KarteAllgemeinesAccess (TextSchleifenwert),
                                                                                   TextbreiteExtern => Textbreite);
               
            when False =>
               null;
         end case;
                  
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         TextAccessExtern => TextaccessVariablen.KarteAllgemeinesAccess (TextSchleifenwert),
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
         
      end loop TextSchleife;
            
      Viewfläche := (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);

   end AllgemeineInformationen;

end AllgemeinesSeitenleisteGrafik;
