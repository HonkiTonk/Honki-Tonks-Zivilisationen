pragma SPARK_Mode (On);

with EinheitSuchen, StadtSuchen;

package body BewegungBlockiert
is
   
   function BlockiertStadtEinheit
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
         null;
         
      else
         return True;
      end if;        

      EinheitWert := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => NeuePositionExtern);

      if
        EinheitWert.Rasse = EinheitRasseNummerExtern.Rasse
      then
         return True;

      elsif
        EinheitWert.Platznummer = GlobaleKonstanten.LeerEinheitStadtNummer
      then
         return False;
         
      else
         return True;
      end if;
      
   end BlockiertStadtEinheit;

end BewegungBlockiert;
