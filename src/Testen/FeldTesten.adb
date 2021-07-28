pragma SPARK_Mode (On);

with RassenAllgemein;

package body FeldTesten is

   function BelegterGrundTesten     
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      if
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund
      in
        RassenAllgemein.RassenBelegungAnfang (RasseExtern => RasseExtern) .. RassenAllgemein.RassenBelegungEnde (RasseExtern => RasseExtern)
      then
         return True;
         
      else
         return False;
      end if;
      
   end BelegterGrundTesten;
   
   
   
   function BelegterGrundLeerTesten
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
   
      if
        Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).DurchStadtBelegterGrund = 0
      then
         return True;
         
      else
         return False;
      end if;
   
   end BelegterGrundLeerTesten;

end FeldTesten;
