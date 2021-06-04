pragma SPARK_Mode (On);

with KIKonstanten;

with BewegungssystemEinheiten, BewegungBlockiert, KIBewegungBerechnen, KINullwerteSetzen;

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
            KINullwerteSetzen.ZielBewegungNullSetzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                      WelchenWertNullSetzten   => 0);
            return;
            
         elsif
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBewegungspunkte <= 0.00
         then
            return;
            
         elsif
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (1) = KIKonstanten.NullKoordinate
         then
            
            case
              KIBewegungBerechnen.BewegungPlanen (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
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
      
      case
        BewegungBlockiert.BlockiertStadtEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                 NeuePositionExtern       => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (1))
      is
         when GlobaleDatentypen.Normale_Bewegung_Möglich =>      
            BewegungssystemEinheiten.BewegungEinheitenBerechnung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                  NeuePositionExtern       => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (1));
            BewegungPlanVerschiebenSchleife:
            for PositionSchleifenwert in GlobaleRecords.KIBewegungPlanArray'First + 1 .. GlobaleRecords.KIBewegungPlanArray'Last loop
               
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (PositionSchleifenwert - 1)
                 := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (PositionSchleifenwert);
               
            end loop BewegungPlanVerschiebenSchleife;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (GlobaleRecords.KIBewegungPlanArray'Last) := KIKonstanten.NullKoordinate;
            
         when others =>
            KINullwerteSetzen.ZielBewegungNullSetzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                      WelchenWertNullSetzten   => 0);
      end case;
      
   end BewegungDurchführen;

end KIBewegungDurchfuehren;
