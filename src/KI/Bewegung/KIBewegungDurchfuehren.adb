pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KIKonstanten;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;

with BewegungBlockiert, KIBewegungBerechnen, KINullwerteSetzen, BewegungBerechnen;

package body KIBewegungDurchfuehren is
   
   procedure KIBewegungNeu
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      BewegungSchleife:
      loop
         
         if
           LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
         then
            KINullwerteSetzen.ZielBewegungNullSetzen (EinheitRasseNummerExtern    => EinheitRasseNummerExtern,
                                                      WelchenWertNullSetzenExtern => 0);
            return;
            
         elsif
           LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = GlobaleKonstanten.LeerEinheit.Bewegungspunkte
         then
            return;
            
         elsif
           LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                               PlanschrittExtern        => 1)
           = KIKonstanten.NullKoordinate
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
                                                 NeuePositionExtern       => LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                 PlanschrittExtern        => 1))
      is
         when False =>      
            BewegungBerechnen.BewegungEinheitenBerechnung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                           NeuePositionExtern       => LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                           PlanschrittExtern        => 1));
            BewegungPlanVerschiebenSchleife:
            for PositionSchleifenwert in GlobaleRecords.KIBewegungPlanArray'First + 1 .. GlobaleRecords.KIBewegungPlanArray'Last loop
               
               SchreibeEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       PositionExtern           => LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                       PlanschrittExtern        => PositionSchleifenwert),
                                                       PlanpositionExtern       => (PositionSchleifenwert - 1));
               
            end loop BewegungPlanVerschiebenSchleife;
            SchreibeEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    PositionExtern           => KIKonstanten.NullKoordinate,
                                                    PlanpositionExtern       => GlobaleRecords.KIBewegungPlanArray'Last);
            
         when True =>
            KINullwerteSetzen.ZielBewegungNullSetzen (EinheitRasseNummerExtern    => EinheitRasseNummerExtern,
                                                      WelchenWertNullSetzenExtern => 1);
      end case;
      
   end BewegungDurchführen;

end KIBewegungDurchfuehren;
