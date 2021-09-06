pragma SPARK_Mode (On);

with GlobaleKonstanten;

with EinheitSuchen, StadtSuchen;

package body BewegungBlockiert is
   
   function FeldBlockiert
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      case
        StadtBlockiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                        NeuePositionExtern       => NeuePositionExtern)
      is
         when True =>
            return True;
            
         when others =>
            null;
      end case;
      
      return EinheitBlockiert (NeuePositionExtern => NeuePositionExtern);
      
   end FeldBlockiert;
   
   
   
   function StadtBlockiert
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      StadtWert := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => NeuePositionExtern);
      
      if
        StadtWert.Rasse = EinheitRasseNummerExtern.Rasse
        or
          StadtWert.Platznummer = GlobaleKonstanten.LeerEinheitStadtNummer
      then
         return False;
         
      else
         return True;
      end if;        
      
   end StadtBlockiert;
   
   
   
   function EinheitBlockiert
     (NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      EinheitWert := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => NeuePositionExtern);

      if
        EinheitWert.Platznummer = GlobaleKonstanten.LeerEinheitStadtNummer
      then
         return False;
         
      else
         return True;
      end if;
      
   end EinheitBlockiert;

end BewegungBlockiert;
