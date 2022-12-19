with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;

with Views;
with GrafikRecordKonstanten;
with KartengrundDatentypen;
with ViewKonstanten;

with LeseWeltkarte;
with LeseStadtGebaut;

with SichtweitenGrafik;
with EinstellungenGrafik;
-- with EingeleseneTexturenGrafik;
-- with KartenspritesZeichnenGrafik;
with ViewsEinstellenGrafik;

package body StadtkarteGrafik is

   procedure Stadtkarte
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.StadtviewAccesse (ViewKonstanten.StadtKarte),
                                            GrößeExtern          => EinstellungenGrafik.AktuelleFensterAuflösung,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Stadtbereich (ViewKonstanten.StadtKarte));
      
      Gesamtgrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern));
      GrafischeDarstellung (GrundExtern => Gesamtgrund);
      
      Stadtgröße := KartenDatentypen.KartenfeldPositiv (Float'Ceiling (Sqrt (X => Float (StadtDatentypen.GebäudeID'Last))));
      
      YMultiplikator := 0.00;
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.Stadtfeld'Range loop
         
         XMultiplikator := 0.00;
         
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.Stadtfeld'Range loop
                        
            Grafikposition := (XMultiplikator * SichtweitenGrafik.StadtfelderAbmessung.x, YMultiplikator * SichtweitenGrafik.StadtfelderAbmessung.y);
                                    
            DarstellungGebäude (YAchseExtern           => YAchseSchleifenwert,
                                 XAchseExtern           => XAchseSchleifenwert,
                                -- PositionExtern         => Grafikposition,
                                 StadtRasseNummerExtern => StadtRasseNummerExtern);
            
            XMultiplikator := XMultiplikator + 1.00;
            
         end loop XAchseSchleife;
         
         YMultiplikator := YMultiplikator + 1.00;
         
      end loop YAchseSchleife;
      
   end Stadtkarte;
   
   
   
   procedure GrafischeDarstellung
     (GrundExtern : in KartenRecords.KartengrundRecord)
   is begin
      
     -- KartenspritesZeichnenGrafik.K
      
      case
        GrundExtern.Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            null;
            
         when others =>
            null;
      end case;
            
   end GrafischeDarstellung;
      
   
   
   procedure DarstellungGebäude
     (YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld;
     -- PositionExtern : in Sf.System.Vector2.sfVector2f;
      StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is
      use type KartenDatentypen.Kartenfeld;
      use type StadtDatentypen.GebäudeIDMitNullwert;
   begin
      
      if
        YAchseExtern = 1
        and
          XAchseExtern <= 12
      then
         GebäudeID := StadtDatentypen.GebäudeID (XAchseExtern);
               
      elsif
        YAchseExtern = 2
        and
          XAchseExtern <= 12
      then
         GebäudeID := StadtDatentypen.GebäudeID (XAchseExtern) + 12;
               
      elsif
        YAchseExtern = 3
        and
          XAchseExtern < 3
      then
         GebäudeID := StadtDatentypen.GebäudeID (XAchseExtern) + 24;

      else
         return;
      end if;
      
      if
        False = LeseStadtGebaut.GebäudeVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                   WelchesGebäudeExtern  => GebäudeID)
      then
         null;
         
      else
         null;
        -- KartenspritesZeichnenGrafik.StadtfeldZeichnen (TexturAccessExtern => EingeleseneTexturenGrafik.GebäudeAccess (StadtRasseNummerExtern.Rasse, GebäudeID),
         --                                               PositionExtern     => PositionExtern);
      end if;
      
   end DarstellungGebäude;

end StadtkarteGrafik;
