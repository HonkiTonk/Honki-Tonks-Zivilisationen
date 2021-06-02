pragma SPARK_Mode (On);

with BewegungssystemEinheiten, BewegungBlockiert, KIBewegungBerechnen;

package body KIBewegungDurchfuehren is
   
   procedure KIBewegungNeu
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      BewegungSchleife:
      loop
         
         if
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition
           = GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten
         then
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten := (0, 0, 0);
            return;
            
         elsif
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBewegungspunkte <= 0.00
         then
            return;
            
         elsif
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (1) = (0, 0, 0)
         then
            NeuerBewegungsplan := KIBewegungBerechnen.BewegungPlanen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            case
              NeuerBewegungsplan
            is
               when True =>
                  null;
                  
               when False =>
                  return;
            end case;
            
         else
            BewegungDurchführen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         end if;
         
      end loop BewegungSchleife;
      
   end KIBewegungNeu;



   procedure BewegungDurchführen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      FeldImmerNochFrei := BewegungBlockiert.BlockiertStadtEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                    NeuePositionExtern       => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (1));
      
      case
        FeldImmerNochFrei
      is
         when GlobaleDatentypen.Normale_Bewegung_Möglich =>      
            BewegungssystemEinheiten.BewegungEinheitenBerechnung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                  NeuePositionExtern       => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (1));
            BewegungPlanVerschiebenSchleife:
            for PositionSchleifenwert in 1 .. GlobaleRecords.KIBewegungPlanArray'Last loop
               
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (PositionSchleifenwert - 1)
                 := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (PositionSchleifenwert);
               
            end loop BewegungPlanVerschiebenSchleife;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (GlobaleRecords.KIBewegungPlanArray'Last) := (0, 0, 0);
            
         when others =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan := (others => (0, 0, 0));
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten := (0, 0, 0);
      end case;
      
   end BewegungDurchführen;

end KIBewegungDurchfuehren;
