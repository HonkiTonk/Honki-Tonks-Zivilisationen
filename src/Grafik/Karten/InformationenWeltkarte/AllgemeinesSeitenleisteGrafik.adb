with Sf.Graphics;
with Sf.Graphics.Text;

with Meldungstexte;
with TextnummernKonstanten;
with KartengrundDatentypen;
with ViewKonstanten;
with TextKonstanten;
with GrafikKonstanten;

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
      
      Textbreite := GrafikKonstanten.Nullwert;
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
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
      
      
      
      TextAnzeigen (6) := False;
      
      Text := TextKonstanten.LeerUnboundedString;
      
      FeldeffekteSchleife:
      for FeldeffektSchleifenwert in KartengrundDatentypen.Effekt_Kartenfeld_Enum'Range loop
      
         case
           LeseWeltkarte.Effekt (KoordinatenExtern   => AktuelleKoordinaten,
                                 WelcherEffektExtern => FeldeffektSchleifenwert)
         is
            when True =>
               TextAnzeigen (6) := True;
               
               if
                 Text = TextKonstanten.LeerUnboundedString
               then
                  Text := To_Unbounded_Wide_Wide_String (Source => KartenbeschreibungenGrafik.KurzbeschreibungFeldeffekte (FeldeffekteExtern => FeldeffektSchleifenwert));
                  
               else
                  Text := Text & TextKonstanten.Trennzeichen & KartenbeschreibungenGrafik.KurzbeschreibungFeldeffekte (FeldeffekteExtern => FeldeffektSchleifenwert);
               end if;
               
            when False =>
               null;
         end case;
         
      end loop FeldeffekteSchleife;
      
      case
        TextAnzeigen (6)
      is
         when True =>
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteAllgemeinesAccess (6),
                                               str  => To_Wide_Wide_String (Source => Text));
            
         when False =>
            null;
      end case;
               
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.KarteAllgemeinesAccess'Range loop
         
         case
           TextAnzeigen (TextSchleifenwert)
         is
            when True =>
               TextaccessverwaltungssystemGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.KarteAllgemeinesAccess (TextSchleifenwert),
                                                                   PositionExtern   => Textposition);
               
               Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.KarteAllgemeinesAccess (TextSchleifenwert),
                                                                                   TextbreiteExtern => Textbreite);
               Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                               TextAccessExtern => TextaccessVariablen.KarteAllgemeinesAccess (TextSchleifenwert),
                                                                               ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
               
            when False =>
               null;
         end case;
         
      end loop TextSchleife;
            
      Viewfläche := (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);

   end AllgemeineInformationen;

end AllgemeinesSeitenleisteGrafik;
