pragma SPARK_Mode (On);

with EinheitSuchen, StadtSuchen;

package body BewegungBlockiert
is
   
   function BlockiertStadtEinheit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.Bewegung_Enum
   is begin

      StadtWert := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => NeuePositionExtern);
      
      if
        StadtWert.Rasse = EinheitRasseNummerExtern.Rasse
        or
          StadtWert.Platznummer = GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch
      then
         null;
         
      else
         return GlobaleDatentypen.Gegner_Blockiert;
      end if;        

      EinheitWert := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => NeuePositionExtern);

      if
        EinheitWert.Rasse = EinheitRasseNummerExtern.Rasse
      then
         return GlobaleDatentypen.Keine_Bewegung_Möglich;

      elsif
        EinheitWert.Platznummer = GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch
      then
         return GlobaleDatentypen.Normale_Bewegung_Möglich;
         
      else
         return GlobaleDatentypen.Gegner_Blockiert;
      end if;
      
   end BlockiertStadtEinheit;

end BewegungBlockiert;
