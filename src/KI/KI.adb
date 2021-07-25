pragma SPARK_Mode (On);

with EinheitenDatenbank;

with KISiedler, KINahkampfBoden, KIStadt, KIForschung, KIDiplomatie;

package body KI is

   procedure KI
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EinheitenDurchgehen (RasseExtern => RasseExtern);
      StädteDurchgehen (RasseExtern => RasseExtern);
      KIForschung.Forschung (RasseExtern => RasseExtern);
      KIDiplomatie.Diplomatie (RasseExtern => RasseExtern);
      
   end KI;
   
   
   
   procedure EinheitenDurchgehen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EinheitenSchleife:
      for EinheitNummerEinsSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
         
         if
           GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerEinsSchleifenwert).ID = 0
           or
             GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerEinsSchleifenwert).Bewegungspunkte <= 0.00
         then
            null;
            
         else
            AKtivitätEinheit (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerEinsSchleifenwert));
         end if;
            
      end loop EinheitenSchleife;
      
   end EinheitenDurchgehen;
   
   
   
   procedure StädteDurchgehen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      StadtSchleife:
      for StadtNummerEinsSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (2) loop
            
         if
           GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummerEinsSchleifenwert).ID /= GlobaleDatentypen.Leer
         then
            KIStadt.KIStadt (StadtRasseNummerExtern => (RasseExtern, StadtNummerEinsSchleifenwert));
            
         else
            null;
         end if;

      end loop StadtSchleife;
      
   end StädteDurchgehen;
   
   

   procedure AKtivitätEinheit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).EinheitTyp
      is
         when GlobaleDatentypen.Unbewaffnet =>
            KISiedler.KISiedler (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when GlobaleDatentypen.Nahkämpfer =>
            KINahkampfBoden.KINahkampfBoden (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when GlobaleDatentypen.Fernkämpfer =>
            null;
            
         when GlobaleDatentypen.Beides =>
            null;
            
         when GlobaleDatentypen.Sonstiges =>
            null;
            
         when GlobaleDatentypen.Leer =>
            null;
      end case;
      
   end AKtivitätEinheit;

end KI;
