pragma SPARK_Mode (On);

with EinheitSuchen, StadtSuchen;

package body BewegungBlockiert is
   
  -- In zwei einzelne Funktionen aufteilen, muss jemals nur eines der beiden geprüft werden?
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

      -- Muss die Rasse hier geprüft werden?
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
