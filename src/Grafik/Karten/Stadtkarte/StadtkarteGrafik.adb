with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;

with Views;
with GrafikRecordKonstanten;
with KartengrundDatentypen;
with ViewKonstanten;

with LeseWeltkarte;
with LeseStadtGebaut;

with EinstellungenGrafik;
with EingeleseneTexturenGrafik;
with KartenspritesZeichnenGrafik;
with ViewsEinstellenGrafik;
with Vergleiche;
with NachLogiktask;

with Diagnoseinformationen;

package body StadtkarteGrafik is

   procedure Stadtkarte
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.StadtviewAccesse (ViewKonstanten.StadtKarte),
                                            GrößeExtern          => EinstellungenGrafik.AktuelleFensterAuflösung,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Stadtbereich (ViewKonstanten.StadtKarte));
      
      Gesamtgrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern));
      GrafischeDarstellung (GrundExtern => Gesamtgrund);
      GebäudeZusatzinformationen := StadtKonstanten.LeerGebäudeID;
      
      Stadtgröße := KartenDatentypen.KartenfeldPositiv (Float'Ceiling (Sqrt (X => Float (StadtDatentypen.GebäudeID'Last))));
      Grafikgröße := (EinstellungenGrafik.AktuelleFensterAuflösung.x / Float (Stadtgröße), EinstellungenGrafik.AktuelleFensterAuflösung.y / Float (Stadtgröße));
      
      YAchseSchleife:
      for YAchseSchleifenwert in 1 .. Stadtgröße loop
         XAchseSchleife:
         for XAchseSchleifenwert in 1 .. Stadtgröße loop
            
            if
              (YAchseSchleifenwert - 1) * Stadtgröße + XAchseSchleifenwert > KartenDatentypen.KartenfeldPositiv (StadtDatentypen.GebäudeID'Last)
            then
               exit YAchseSchleife;
               
            else
               GebäudeID := StadtDatentypen.GebäudeID ((YAchseSchleifenwert - 1) * Stadtgröße + XAchseSchleifenwert);
            end if;
                     
            case
              LeseStadtGebaut.GebäudeVorhanden (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                 WelchesGebäudeExtern     => GebäudeID)
            is
               when False =>
                  null;
                  
               when True =>
                  KartenspritesZeichnenGrafik.SpriteZeichnenVariabel (PositionExtern     => (Float (XAchseSchleifenwert - 1) * Grafikgröße.x, Float (YAchseSchleifenwert - 1) * Grafikgröße.y),
                                                                      GrößeExtern        => Grafikgröße,
                                                                      TexturAccessExtern => EingeleseneTexturenGrafik.GebäudeAccess (StadtSpeziesNummerExtern.Spezies, GebäudeID));
                  
                  if
                    True = Vergleiche.Auswahlposition (MauspositionExtern => NachLogiktask.Mausposition,
                                                       TextboxExtern      => (Float (XAchseSchleifenwert - 1) * Grafikgröße.x, Float (YAchseSchleifenwert - 1) * Grafikgröße.y, Grafikgröße.x, Grafikgröße.y))
                  then
                     GebäudeZusatzinformationen := GebäudeID;
                     
                  else
                     null;
                  end if;
            end case;
         
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      case
        GebäudeZusatzinformationen
      is
         when StadtKonstanten.LeerGebäudeID =>
            null;
         
         when others =>
            Zusatzinformationen (GebäudeIDExtern => GebäudeZusatzinformationen);
      end case;
      
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
     (GebäudeIDExtern : in StadtDatentypen.GebäudeID)
   is begin
      
      Diagnoseinformationen.Zahl (ZahlExtern => Positive (GebäudeIDExtern));
      
   end Zusatzinformationen;

end StadtkarteGrafik;
