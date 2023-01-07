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

package body StadtkarteGrafik is

   procedure Stadtkarte
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.StadtviewAccesse (ViewKonstanten.StadtKarte),
                                            GrößeExtern          => EinstellungenGrafik.AktuelleFensterAuflösung,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Stadtbereich (ViewKonstanten.StadtKarte));
      
      Gesamtgrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern));
      GrafischeDarstellung (GrundExtern => Gesamtgrund);
      
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
              LeseStadtGebaut.GebäudeVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                 WelchesGebäudeExtern  => GebäudeID)
            is
               when False =>
                  null;
                  
               when True =>
                  KartenspritesZeichnenGrafik.SpriteZeichnenVariabel (PositionExtern     => (Float (XAchseSchleifenwert - 1) * Grafikgröße.x, Float (YAchseSchleifenwert - 1) * Grafikgröße.y),
                                                                      GrößeExtern        => Grafikgröße,
                                                                      TexturAccessExtern => EingeleseneTexturenGrafik.GebäudeAccess (StadtRasseNummerExtern.Rasse, GebäudeID));
            end case;
         
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
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

end StadtkarteGrafik;
