with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Views;
with KartengrundDatentypen;
with ViewKonstanten;
with ZeitKonstanten;
with GrafikDatentypen;
with TextaccessVariablen;
with KartenDatentypen;
with InteraktionAuswahl;
with GrafikKonstanten;

with LeseWeltkarte;
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
with GebaeudebeschreibungenGrafik;
with SichtweitenGrafik;
with TextaccessverwaltungssystemErweitertGrafik;
with TextberechnungenHoeheGrafik;
with BauauswahlGebaeudeGrafik;
with TexturenfelderVariablenGrafik;

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
              (YAchseSchleifenwert - 1) * StadtKonstanten.Stadtkartengröße + XAchseSchleifenwert > KartenDatentypen.KartenfeldPositiv (StadtDatentypen.GebäudeIDVorhanden'Last)
            then
               exit YAchseSchleife;
               
            else
               GebäudeID := StadtDatentypen.GebäudeIDVorhanden ((YAchseSchleifenwert - 1) * StadtKonstanten.Stadtkartengröße + XAchseSchleifenwert);
            end if;
                     
            case
              StadtauswahlExtern.GebäudeVorhanden (GebäudeID)
            is
               when False =>
                  null;
                  
               when True =>
                  KartenspritesZeichnenGrafik.KartenfeldZeichnen (TexturAccessExtern     => EingeleseneTexturenGrafik.GebäudeAccess (StadtauswahlExtern.Spezies),
                                                                  TexturbereichExtern    => TexturenfelderVariablenGrafik.Gebäudebereich (GebäudeExtern => GebäudeID,
                                                                                                                                           SpeziesExtern  => StadtauswahlExtern.Spezies),
                                                                  PositionExtern         => (Float (XAchseSchleifenwert - 1) * Grafikgröße.x, Float (YAchseSchleifenwert - 1) * Grafikgröße.y),
                                                                  DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig);
                 -- KartenspritesZeichnenGrafik.SpriteZeichnenVariabel (PositionExtern     => (Float (XAchseSchleifenwert - 1) * Grafikgröße.x, Float (YAchseSchleifenwert - 1) * Grafikgröße.y),
                 --                                                     GrößeExtern        => Grafikgröße,
                 --                                                     TexturAccessExtern => EingeleseneTexturenGrafik.GebäudeAccess (StadtauswahlExtern.Spezies, GebäudeID));
                  
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
      
      KartenspritesZeichnenGrafik.StadtkarteZeichnen (TexturAccessExtern    => EingeleseneTexturenGrafik.BasisgrundAccess,
                                                      TexturenbereichExtern => TexturenfelderVariablenGrafik.Basisgrundabmessung (BasisgrundExtern => GrundExtern.Basisgrund));
      
      case
        GrundExtern.Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            null;
            
         when others =>
            KartenspritesZeichnenGrafik.StadtkarteZeichnen (TexturAccessExtern    => EingeleseneTexturenGrafik.ZusatzgrundAccess,
                                                            TexturenbereichExtern => TexturenfelderVariablenGrafik.Zusatzgrundabmessung (ZusatzgrundExtern => GrundExtern.Zusatzgrund));
      end case;
            
   end GrafischeDarstellung;
   
   
   
   procedure Zusatzinformationen
     (GebäudeIDExtern : in StadtDatentypen.GebäudeID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is
      use type StadtDatentypen.GebäudeID;
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
     (GebäudeIDExtern : in StadtDatentypen.GebäudeIDVorhanden;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is begin
      
      Rechteck := ViewbereicheBerechnenGrafik.ViewbereichBreiteHöheBerechnen (BereichExtern => LeseGrafikVariablen.InformationsfeldBereiche (WelcherBereichExtern => ViewKonstanten.InformationsfeldStadtkarte));
      
      SchreibeGrafikVariablen.InformationsfeldBereiche (WelcherBereichExtern => ViewKonstanten.InformationsfeldStadtkarte,
                                                        RechteckExtern       => Rechteck);
      
     -- Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
     --                                                                   VerhältnisExtern => (Rechteck.width, Rechteck.height));
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeXFestYVariabel (ViewflächeExtern => Viewfläche,
                                                                      VerhältnisExtern => (Rechteck.width, Rechteck.height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.InformationsfeldAccesse (ViewKonstanten.InformationsfeldStadtkarte),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => LeseGrafikVariablen.InformationsfeldBereiche (WelcherBereichExtern => ViewKonstanten.InformationsfeldStadtkarte));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);
      
      Gebäudetexte (1) := To_Unbounded_Wide_Wide_String (Source => GebaeudebeschreibungenGrafik.Kurzbeschreibung (IDExtern      => GebäudeIDExtern,
                                                                                                                   SpeziesExtern => SpeziesExtern));
      
      Gebäudetexte (2 .. 11) := BauauswahlGebaeudeGrafik.Informationstexte (AuswahlExtern => GebäudeIDExtern,
                                                                             SpeziesExtern => SpeziesExtern);
      
      YTextposition := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      
      InformationenSchleife:
      for InformationSchleifenwert in Gebäudetexte'Range loop
         
         YTextposition := TextaccessverwaltungssystemErweitertGrafik.TextSkalierenZeichnen (TextExtern               => To_Wide_Wide_String (Source => Gebäudetexte (InformationSchleifenwert)),
                                                                                             TextpositionExtern       => (TextberechnungenBreiteGrafik.WinzigerSpaltenabstand, YTextposition),
                                                                                             MaximaleTextbreiteExtern => Viewfläche.x,
                                                                                             TextAccessExtern         => TextaccessVariablen.StadtkarteAccess);
         
      end loop InformationenSchleife;
        
      Viewfläche.y := YTextposition;
      
   end Informationsfeld;

end StadtkarteGrafik;
