pragma SPARK_Mode (On);

with KIKonstanten;

package body KINullwerteSetzen is

   procedure ZielBewegungNullSetzen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      WelchenWertNullSetzenExtern : in GlobaleDatentypen.LoopRangeMinusEinsZuEins)
   is begin
      
      case
        WelchenWertNullSetzenExtern
      is
         when -1 =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten := KIKonstanten.NullKoordinate;
            
         when 0 =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten := KIKonstanten.NullKoordinate;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan := (others => KIKonstanten.NullKoordinate);
            
         when 1 =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan := (others => KIKonstanten.NullKoordinate);
      end case;
      
   end ZielBewegungNullSetzen;

end KINullwerteSetzen;
