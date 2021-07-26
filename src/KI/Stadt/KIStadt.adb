pragma SPARK_Mode (On);

with KIDatentypen;
use KIDatentypen;

with GebaeudeDatenbank;

with EinheitSuchen, KIStadtLaufendeBauprojekte, StadtSuchen;

package body KIStadt is

   procedure KIStadt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      if
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).KIBeschäftigung /= KIDatentypen.Keine_Aufgabe
      then
         case
           GefahrStadt (StadtRasseNummerExtern => StadtRasseNummerExtern)
         is
            when False =>
               return;
               
            when True =>
               null;
         end case;
         
      else
         StädteMitGleichemBauprojekt := 0;
         AnzahlStädte := StadtSuchen.AnzahlStädteErmitteln (RasseExtern => StadtRasseNummerExtern.Rasse);
      end if;
      
      SiedlerVorhanden := EinheitSuchen.MengeEinesEinheitenTypsSuchen (RasseExtern         => StadtRasseNummerExtern.Rasse,
                                                                       EinheitTypExtern    => GlobaleDatentypen.Unbewaffnet,
                                                                       GesuchteMengeExtern => 2);
      
      if
        SiedlerVorhanden >= 2
      then
         null;
         
      elsif
        SiedlerVorhanden + KIStadtLaufendeBauprojekte.StadtLaufendeBauprojekte (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                                BauprojektExtern       => 10_001)
        >= 2
      then
         null;
         
      else         
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).KIBeschäftigung := KIDatentypen.Einheit_Bauen;
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt := 10_001;
         return;
      end if;      
      
      VerteidigerVorhanden := EinheitSuchen.MengeEinesEinheitenTypsSuchen (RasseExtern         => StadtRasseNummerExtern.Rasse,
                                                                           EinheitTypExtern    => GlobaleDatentypen.Nahkämpfer,
                                                                           GesuchteMengeExtern => AnzahlStädte);
      
      if
        VerteidigerVorhanden >= AnzahlStädte * 10
      then
         null;
         
      elsif
        VerteidigerVorhanden + KIStadtLaufendeBauprojekte.StadtLaufendeBauprojekte (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                                    BauprojektExtern       => 10_002)
        >= AnzahlStädte * 10
      then
         null;
         
      else
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).KIBeschäftigung := KIDatentypen.Einheit_Bauen;
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt := 10_002;
         return;
      end if;
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in GlobaleRecords.GebäudeVorhandenArray'Range loop
         
         if
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden (GebäudeSchleifenwert) = False
           and
             (GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse, GebäudeSchleifenwert).Anforderungen = 0
              or else
              GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).Erforscht (GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse, GebäudeSchleifenwert).Anforderungen) = True)
         then
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).KIBeschäftigung := KIDatentypen.Gebäude_Bauen;
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt := 1_000 + Positive (GebäudeSchleifenwert);
            return;
            
         else
            null;
         end if;
         
      end loop GebäudeSchleife;
      
      if
        VerteidigerVorhanden <= 10
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).KIBeschäftigung := KIDatentypen.Einheit_Bauen;
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt := 10_002;
         
      else
         null;
      end if;
      
   end KIStadt;
   
   
   
   function GefahrStadt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      if
        StadtRasseNummerExtern.Platznummer = 0
      then
         null;
         
      else
         null;
      end if;
      
      return False;
        
   end GefahrStadt;

end KIStadt;
