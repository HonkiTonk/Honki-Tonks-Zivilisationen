with Ada.Strings.Wide_Wide_Unbounded;

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
      use type KartenDatentypen.Senkrechte;
   begin
      
            ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.StadtviewAccesse (ViewKonstanten.StadtKarte),
                                            GrößeExtern          => FensterGrafik.AktuelleAuflösung,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Stadtbereich (ViewKonstanten.StadtKarte));
      
      Gesamtgrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => StadtauswahlExtern.Koordinaten);
      -- Der Fehler scheint in dieser Prozedur zu liegen! äöü
      GrafischeDarstellung (GrundExtern => Gesamtgrund);
      GebäudeZusatzinformationen := StadtKonstanten.LeerGebäudeID;
      
      Grafikgröße := SichtweitenGrafik.Stadtumgebungsfläche;
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in 1 .. StadtKonstanten.Stadtkartengröße loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in 1 .. StadtKonstanten.Stadtkartengröße loop
            
            if
              (SenkrechteSchleifenwert - 1) * StadtKonstanten.Stadtkartengröße + WaagerechteSchleifenwert > KartenDatentypen.SenkrechtePositiv (StadtDatentypen.GebäudeIDVorhanden'Last)
            then
               exit SenkrechteSchleife;
               
            else
               GebäudeID := StadtDatentypen.GebäudeIDVorhanden ((SenkrechteSchleifenwert - 1) * StadtKonstanten.Stadtkartengröße + WaagerechteSchleifenwert);
            end if;
                     
            case
              StadtauswahlExtern.GebäudeVorhanden (GebäudeID)
            is
               when False =>
                  null;
                  
               when True =>
                  KartenspritesZeichnenGrafik.KartenfeldZeichnen (TexturAccessExtern     => EingeleseneTexturenGrafik.GebäudeAccess (StadtauswahlExtern.Spezies),
                                                                  TexturbereichExtern    => TexturenfelderVariablenGrafik.GebäudeRechteck (GebäudeExtern => GebäudeID,
                                                                                                                                           SpeziesExtern  => StadtauswahlExtern.Spezies),
                                                                  PositionExtern         => (Float (WaagerechteSchleifenwert - 1) * Grafikgröße.x, Float (SenkrechteSchleifenwert - 1) * Grafikgröße.y),
                                                                  DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig);
                 -- KartenspritesZeichnenGrafik.SpriteZeichnenVariabel (PositionExtern     => (Float (WaagerechteSchleifenwert - 1) * Grafikgröße.x, Float (SenkrechteSchleifenwert - 1) * Grafikgröße.y),
                 --                                                     GrößeExtern        => Grafikgröße,
                 --                                                     TexturAccessExtern => EingeleseneTexturenGrafik.GebäudeAccess (StadtauswahlExtern.Spezies, GebäudeID));
                  
                  if
                    True = Vergleiche.Auswahlposition (MauspositionExtern => InteraktionAuswahl.LeseGesamteMausposition,
                                                       RechteckExtern     => (Float (WaagerechteSchleifenwert - 1) * Grafikgröße.x, Float (SenkrechteSchleifenwert - 1) * Grafikgröße.y, Grafikgröße.x, Grafikgröße.y))
                  then
                     GebäudeZusatzinformationen := GebäudeID;
                     
                  else
                     null;
                  end if;
            end case;
         
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
      Zusatzinformationen (GebäudeIDExtern => GebäudeZusatzinformationen,
                           SpeziesExtern   => StadtauswahlExtern.Spezies);
      
   end Stadtkarte;
   
   
   
   procedure GrafischeDarstellung
     (GrundExtern : in KartenRecords.KartengrundRecord)
   is begin
      
      KartenspritesZeichnenGrafik.StadtkarteZeichnen (TexturAccessExtern    => EingeleseneTexturenGrafik.BasisgrundAccess,
                                                      TexturenbereichExtern => TexturenfelderVariablenGrafik.BasisgrundVektor (BasisgrundExtern => GrundExtern.Basisgrund));
      
      case
        GrundExtern.Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            null;
            
         when others =>
            KartenspritesZeichnenGrafik.StadtkarteZeichnen (TexturAccessExtern    => EingeleseneTexturenGrafik.ZusatzgrundAccess,
                                                            TexturenbereichExtern => TexturenfelderVariablenGrafik.ZusatzgrundVektor (ZusatzgrundExtern => GrundExtern.Zusatzgrund));
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
   is
      use Ada.Strings.Wide_Wide_Unbounded;
   begin
      
      Rechteck := ViewbereicheBerechnenGrafik.ViewbereichBreiteHöheBerechnen (BereichExtern => LeseGrafikVariablen.InformationsfeldBereiche (WelcherBereichExtern => ViewKonstanten.InformationsfeldStadtkarte));
      
      SchreibeGrafikVariablen.InformationsfeldBereiche (WelcherBereichExtern => ViewKonstanten.InformationsfeldStadtkarte,
                                                        RechteckExtern       => Rechteck);
      
     -- Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
     --                                                                   VerhältnisExtern => (Rechteck.width, Rechteck.height));
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeWaagerechteFestSenkrechteVariabel (ViewflächeExtern => Viewfläche,
                                                                      VerhältnisExtern => (Rechteck.width, Rechteck.height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.InformationsfeldAccesse (ViewKonstanten.InformationsfeldStadtkarte),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => LeseGrafikVariablen.InformationsfeldBereiche (WelcherBereichExtern => ViewKonstanten.InformationsfeldStadtkarte));
      
      HintergrundGrafik.Aufteilung (HintergrundExtern => GrafikDatentypen.Bauen_Enum,
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
