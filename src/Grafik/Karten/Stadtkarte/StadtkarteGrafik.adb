pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with StadtDatentypen; use StadtDatentypen;
with Views;
with GrafikRecordKonstanten;
with KartengrundDatentypen;

with LeseWeltkarte;
with LeseStadtGebaut;

with KartenberechnungenGrafik;
with EinstellungenGrafik;
with EingeleseneTexturenGrafik;
with KartenspritesZeichnenGrafik;
with ViewsEinstellenGrafik;

package body StadtkarteGrafik is

   -- Die Darstellung der Informationen und Gebäude auch in eigene Views? äöü
   procedure Stadtkarte
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.StadtviewAccesse (1),
                                            GrößeExtern          => EinstellungenGrafik.AktuelleFensterAuflösung,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Stadtbereich (1));
      
      Gesamtgrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      YMultiplikator := 0.00;
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.Stadtfeld'Range loop
         
         XMultiplikator := 0.00;
         
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.Stadtfeld'Range loop
            
            Grafikposition := (XMultiplikator * KartenberechnungenGrafik.StadtfelderAbmessung.x, YMultiplikator * KartenberechnungenGrafik.StadtfelderAbmessung.y);
            
            GrafischeDarstellung (GrundExtern    => Gesamtgrund,
                                  PositionExtern => Grafikposition);
                        
            DarstellungGebäude (YAchseExtern           => YAchseSchleifenwert,
                                 XAchseExtern           => XAchseSchleifenwert,
                                 PositionExtern         => Grafikposition,
                                 StadtRasseNummerExtern => StadtRasseNummerExtern);
            
            XMultiplikator := XMultiplikator + 1.00;
            
         end loop XAchseSchleife;
         
         YMultiplikator := YMultiplikator + 1.00;
         
      end loop YAchseSchleife;
      
   end Stadtkarte;
   
   
   
   procedure GrafischeDarstellung
     (GrundExtern : in KartenRecords.KartengrundRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      case
        GrundExtern.Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            ZusatzgrundDarstellen := False;
            
         when others =>
            ZusatzgrundDarstellen := not ZusatzgrundDarstellen;
      end case;
      
      case
        ZusatzgrundDarstellen
      is
         when False =>
            KartenspritesZeichnenGrafik.StadtfeldZeichnen (TexturAccessExtern => EingeleseneTexturenGrafik.BasisgrundAccess (GrundExtern.Basisgrund),
                                                           PositionExtern     => PositionExtern);
            
         when True =>
            KartenspritesZeichnenGrafik.StadtfeldZeichnen (TexturAccessExtern => EingeleseneTexturenGrafik.ZusatzgrundAccess (GrundExtern.Zusatzgrund),
                                                           PositionExtern     => PositionExtern);
      end case;
      
   end GrafischeDarstellung;
      
   
   
   procedure DarstellungGebäude
     (YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
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
         KartenspritesZeichnenGrafik.StadtfeldZeichnen (TexturAccessExtern => EingeleseneTexturenGrafik.GebäudeAccess (StadtRasseNummerExtern.Rasse, GebäudeID),
                                                        PositionExtern     => PositionExtern);
      end if;
      
   end DarstellungGebäude;

end StadtkarteGrafik;
