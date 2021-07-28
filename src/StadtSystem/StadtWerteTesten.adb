pragma SPARK_Mode (On);

with GebaeudeDatenbank;

with EinheitenAllgemein;

package body StadtWerteTesten is
   
   procedure Nahrungsmittel
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin

      if
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel
        + GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsproduktion
        > GlobaleDatentypen.GesamtproduktionStadt'Last
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel := GlobaleDatentypen.GesamtproduktionStadt'Last;
         
      elsif
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel
        + GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsproduktion
        < GlobaleDatentypen.GesamtproduktionStadt'First
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel := GlobaleDatentypen.GesamtproduktionStadt'First;
         
      else
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel
           := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel
           + GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsproduktion;
      end if;
      
   end Nahrungsmittel;
     
     
     
   procedure Produktion
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      if
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Ressourcen
        + GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate
        > GlobaleDatentypen.KostenLager'Last
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Ressourcen := GlobaleDatentypen.KostenLager'Last;
         
      elsif        
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Ressourcen
        + GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate
        < GlobaleDatentypen.KostenLager'First
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Ressourcen := GlobaleDatentypen.KostenLager'First;
              
      else
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Ressourcen
           := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Ressourcen
           + GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate;
      end if;
      
   end Produktion;
   
   
   
   function PermanenteKosten
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      WelcheRessourceExtern : in GlobaleDatentypen.Permanente_Kosten_Verwendet_Enum)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      PermanenteKostenBerechnen := 0;
      
      EinheitenSchleife:
      for EinheitSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
         
         if
           GlobaleVariablen.EinheitenGebaut (StadtRasseNummerExtern.Rasse, EinheitSchleifenwert).ID = 0
         then
            null;
            
         elsif
           GlobaleVariablen.EinheitenGebaut (StadtRasseNummerExtern.Rasse, EinheitSchleifenwert).Heimatstadt /= StadtRasseNummerExtern.Platznummer
           or
             EinheitenAllgemein.PermanenteKosten (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitSchleifenwert),
                                                  WelcheRessourceExtern    => WelcheRessourceExtern) <= 0
         then
            null;
            
         else
            PermanenteKostenBerechnen := PermanenteKostenBerechnen + EinheitenAllgemein.PermanenteKosten (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitSchleifenwert),
                                                                                                          WelcheRessourceExtern    => WelcheRessourceExtern);
         end if;
         
      end loop EinheitenSchleife;
      
      
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in GlobaleRecords.GebäudeVorhandenArray'Range loop
         
         if
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden (GebäudeSchleifenwert) = False
         then
            null;
            
         elsif
           GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse, GebäudeSchleifenwert).PermanenteKosten (WelcheRessourceExtern) <= 0
         then
            null;
           
         else
            PermanenteKostenBerechnen := PermanenteKostenBerechnen + GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse, GebäudeSchleifenwert).PermanenteKosten (WelcheRessourceExtern);
         end if;
         
      end loop GebäudeSchleife;
      
      return PermanenteKostenBerechnen;
      
   end PermanenteKosten;

end StadtWerteTesten;
