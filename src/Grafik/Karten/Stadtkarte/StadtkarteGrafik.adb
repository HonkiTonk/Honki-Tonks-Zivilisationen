with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Views;
with KartengrundDatentypen;
with ViewKonstanten;
with ZeitKonstanten;
with GrafikDatentypen;
with TextaccessVariablen;
with KartenDatentypen;
with Spieltexte;
with TextnummernKonstanten;
with KampfDatentypen;
with ProduktionDatentypen;
with GrafikKonstanten;
with InteraktionAuswahl;

with LeseWeltkarte;
with LeseGebaeudeDatenbank;
with LeseGrafikVariablen;
with SchreibeGrafikVariablen;

with FensterGrafik;
with EingeleseneTexturenGrafik;
with KartenspritesZeichnenGrafik;
with ViewsEinstellenGrafik;
with Vergleiche;
with ViewbereicheBerechnenGrafik;
with HintergrundGrafik;
with TextberechnungenBreiteGrafik;
with TextberechnungenHoeheGrafik;
with TextaccessverwaltungssystemGrafik;
with GebaeudebeschreibungenGrafik;
with SichtweitenGrafik;

package body StadtkarteGrafik is

   procedure Stadtkarte
     (StadtauswahlExtern : in StadtGrafikRecords.StadtkarteGrafikRecord)
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.StadtviewAccesse (ViewKonstanten.StadtKarte),
                                            GrößeExtern          => FensterGrafik.AktuelleAuflösung,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Stadtbereich (ViewKonstanten.StadtKarte));
      
      Gesamtgrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => StadtauswahlExtern.Koordinaten);
      GrafischeDarstellung (GrundExtern => Gesamtgrund);
      GebäudeZusatzinformationen := StadtKonstanten.LeerGebäudeID;
      
      Grafikgröße := SichtweitenGrafik.Stadtumgebungsfläche;
      
      YAchseSchleife:
      for YAchseSchleifenwert in 1 .. StadtKonstanten.Stadtkartengröße loop
         XAchseSchleife:
         for XAchseSchleifenwert in 1 .. StadtKonstanten.Stadtkartengröße loop
            
            if
              (YAchseSchleifenwert - 1) * StadtKonstanten.Stadtkartengröße + XAchseSchleifenwert > KartenDatentypen.KartenfeldPositiv (StadtDatentypen.GebäudeID'Last)
            then
               exit YAchseSchleife;
               
            else
               GebäudeID := StadtDatentypen.GebäudeID ((YAchseSchleifenwert - 1) * StadtKonstanten.Stadtkartengröße + XAchseSchleifenwert);
            end if;
                     
            case
              StadtauswahlExtern.GebäudeVorhanden (GebäudeID)
            is
               when False =>
                  null;
                  
               when True =>
                  KartenspritesZeichnenGrafik.SpriteZeichnenVariabel (PositionExtern     => (Float (XAchseSchleifenwert - 1) * Grafikgröße.x, Float (YAchseSchleifenwert - 1) * Grafikgröße.y),
                                                                      GrößeExtern        => Grafikgröße,
                                                                      TexturAccessExtern => EingeleseneTexturenGrafik.GebäudeAccess (StadtauswahlExtern.Spezies, GebäudeID));
                  
                  if
                    True = Vergleiche.Auswahlposition (MauspositionExtern => InteraktionAuswahl.LeseGesamteMausposition,
                                                       RechteckExtern     => (Float (XAchseSchleifenwert - 1) * Grafikgröße.x, Float (YAchseSchleifenwert - 1) * Grafikgröße.y, Grafikgröße.x, Grafikgröße.y))
                  then
                     GebäudeZusatzinformationen := GebäudeID;
                     
                  else
                     null;
                  end if;
            end case;
         
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      Zusatzinformationen (GebäudeIDExtern => GebäudeZusatzinformationen,
                           SpeziesExtern   => StadtauswahlExtern.Spezies);
      
   end Stadtkarte;
   
   
   
   procedure GrafischeDarstellung
     (GrundExtern : in KartenRecords.KartengrundRecord)
   is begin
      
      KartenspritesZeichnenGrafik.StadtkarteZeichnen (TexturAccessExtern => EingeleseneTexturenGrafik.BasisgrundAccess (GrundExtern.Basisgrund));
      
      case
        GrundExtern.Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            null;
            
         when others =>
            KartenspritesZeichnenGrafik.StadtkarteZeichnen (TexturAccessExtern => EingeleseneTexturenGrafik.ZusatzgrundAccess (GrundExtern.Zusatzgrund));
      end case;
            
   end GrafischeDarstellung;
   
   
   
   procedure Zusatzinformationen
     (GebäudeIDExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is
      use type StadtDatentypen.GebäudeIDMitNullwert;
   begin
      
      if
        GebäudeIDExtern = StadtKonstanten.LeerGebäudeID
        or
          GebäudeIDExtern /= AlteID
      then
         Anzeigezeit := Clock;
         AlteID := GebäudeIDExtern;
         
      elsif
        Anzeigezeit + ZeitKonstanten.AnzeigeInformationen < Clock
        and
          GebäudeIDExtern = AlteID
      then
         Informationsfeld (GebäudeIDExtern => GebäudeIDExtern,
                           SpeziesExtern   => SpeziesExtern);
         
      else
         null;
      end if;
            
   end Zusatzinformationen;
   
   
   
   -- Später soweit wie möglich mit BauauswahlGebaeudeGrafik.Gebäudeinformationen zusammenführen. äöü
   procedure Informationsfeld
     (GebäudeIDExtern : in StadtDatentypen.GebäudeID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      Rechteck := ViewbereicheBerechnenGrafik.ViewbereichBreiteHöheBerechnen (BereichExtern => LeseGrafikVariablen.InformationsfeldBereiche (WelcherBereichExtern => ViewKonstanten.InformationsfeldStadtkarte));
      
      SchreibeGrafikVariablen.InformationsfeldBereiche (WelcherBereichExtern => ViewKonstanten.InformationsfeldStadtkarte,
                                                        RechteckExtern       => Rechteck);
                                                                        
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (Rechteck.width, Rechteck.height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.InformationsfeldAccesse (ViewKonstanten.InformationsfeldStadtkarte),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => LeseGrafikVariablen.InformationsfeldBereiche (WelcherBereichExtern => ViewKonstanten.InformationsfeldStadtkarte));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);
           
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      Textbreite := GrafikKonstanten.Nullwert;
      
      TextaccessverwaltungssystemGrafik.TextPositionZeichnen (TextaccessExtern => TextaccessVariablen.StadtkarteAccess,
                                                              TextExtern       => GebaeudebeschreibungenGrafik.Kurzbeschreibung (IDExtern      => GebäudeIDExtern,
                                                                                                                                 SpeziesExtern => SpeziesExtern),
                                                              PositionExtern   => Textposition);
      
      Gebäudetexte (1) := Spieltexte.Zeug (TextnummernKonstanten.ZeugBaukosten) & LeseGebaeudeDatenbank.Produktionskosten (SpeziesExtern => SpeziesExtern,
                                                                                                                               IDExtern      => GebäudeIDExtern)'Wide_Wide_Image;
      Gebäudetexte (2) := Spieltexte.Zeug (TextnummernKonstanten.ZeugPermanenteNahrungskosten) & LeseGebaeudeDatenbank.PermanenteKosten (SpeziesExtern      => SpeziesExtern,
                                                                                                                                             IDExtern           => GebäudeIDExtern,
                                                                                                                                             WelcheKostenExtern => ProduktionDatentypen.Nahrung_Enum)'Wide_Wide_Image;
      Gebäudetexte (3) := Spieltexte.Zeug (TextnummernKonstanten.ZeugPermanenteGeldkosten) & LeseGebaeudeDatenbank.PermanenteKosten (SpeziesExtern      => SpeziesExtern,
                                                                                                                                         IDExtern           => GebäudeIDExtern,
                                                                                                                                         WelcheKostenExtern => ProduktionDatentypen.Geld_Enum)'Wide_Wide_Image;
      Gebäudetexte (4) := Spieltexte.Zeug (TextnummernKonstanten.ZeugPermanenteProduktionskosten)
        & LeseGebaeudeDatenbank.PermanenteKosten (SpeziesExtern      => SpeziesExtern,
                                                  IDExtern           => GebäudeIDExtern,
                                                  WelcheKostenExtern => ProduktionDatentypen.Material_Enum)'Wide_Wide_Image;
      Gebäudetexte (5) := Spieltexte.Zeug (TextnummernKonstanten.ZeugPermanenterNahrungsbonus) & LeseGebaeudeDatenbank.Produktionsbonus (SpeziesExtern          => SpeziesExtern,
                                                                                                                                            IDExtern               => GebäudeIDExtern,
                                                                                                                                            ProduktionsbonusExtern => ProduktionDatentypen.Nahrung_Enum)'Wide_Wide_Image;
      Gebäudetexte (6) := Spieltexte.Zeug (TextnummernKonstanten.ZeugPermanenterProduktionsbonus)
        & LeseGebaeudeDatenbank.Produktionsbonus (SpeziesExtern          => SpeziesExtern,
                                                  IDExtern               => GebäudeIDExtern,
                                                  ProduktionsbonusExtern => ProduktionDatentypen.Material_Enum)'Wide_Wide_Image;
      Gebäudetexte (7) := Spieltexte.Zeug (TextnummernKonstanten.ZeugPermanenterGeldbonus) & LeseGebaeudeDatenbank.Produktionsbonus (SpeziesExtern          => SpeziesExtern,
                                                                                                                                        IDExtern               => GebäudeIDExtern,
                                                                                                                                        ProduktionsbonusExtern => ProduktionDatentypen.Geld_Enum)'Wide_Wide_Image;
      Gebäudetexte (8) := Spieltexte.Zeug (TextnummernKonstanten.ZeugPermanenterWissenbonus) & LeseGebaeudeDatenbank.Produktionsbonus (SpeziesExtern          => SpeziesExtern,
                                                                                                                                          IDExtern               => GebäudeIDExtern,
                                                                                                                                          ProduktionsbonusExtern => ProduktionDatentypen.Forschung_Enum)'Wide_Wide_Image;
      Gebäudetexte (9) := Spieltexte.Zeug (TextnummernKonstanten.ZeugPermanenterVerteidigungsbonus) & LeseGebaeudeDatenbank.KampfBonus (SpeziesExtern    => SpeziesExtern,
                                                                                                                                            IDExtern         => GebäudeIDExtern,
                                                                                                                                            KampfBonusExtern => KampfDatentypen.Verteidigung_Enum)'Wide_Wide_Image;
      Gebäudetexte (10) := Spieltexte.Zeug (TextnummernKonstanten.ZeugPermanenterAngriffsbonus) & LeseGebaeudeDatenbank.KampfBonus (SpeziesExtern    => SpeziesExtern,
                                                                                                                                        IDExtern         => GebäudeIDExtern,
                                                                                                                                        KampfBonusExtern => KampfDatentypen.Angriff_Enum)'Wide_Wide_Image;
      
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      TextAccessExtern => TextaccessVariablen.StadtkarteAccess,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.StadtkarteAccess,
                                                                          TextbreiteExtern => Textbreite);
      
      InformationenSchleife:
      for InformationSchleifenwert in Gebäudetexte'Range loop
         
         TextaccessverwaltungssystemGrafik.TextPositionZeichnen (TextaccessExtern => TextaccessVariablen.StadtkarteAccess,
                                                                 TextExtern       => To_Wide_Wide_String (Source => Gebäudetexte (InformationSchleifenwert)),
                                                                 PositionExtern   => Textposition);
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         TextAccessExtern => TextaccessVariablen.StadtkarteAccess,
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
         
         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.StadtkarteAccess,
                                                                             TextbreiteExtern => Textbreite);
         
      end loop InformationenSchleife;
      
      Viewfläche := (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
   end Informationsfeld;

end StadtkarteGrafik;
