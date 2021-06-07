pragma SPARK_Mode (On);

with KIDatentypen;
use KIDatentypen;

with GebaeudeDatenbank;

with EinheitSuchen, KIStadtLaufendeBauprojekte;

package body KIStadt is

   procedure KIStadt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      if
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).KIAktuelleBeschäftigung /= KIDatentypen.Keine_Aufgabe
      then
         return;
         
      else
         StädteMitGleichemBauprojekt := 0;
         AnzahlStädte := 0;
      end if;      
      
      StadtAnzahlSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (2) loop
            
         if
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).ID = 0
         then
            null;
            
         else
            AnzahlStädte := AnzahlStädte + 1;
         end if;
         
      end loop StadtAnzahlSchleife;
      
      SiedlerVorhanden := EinheitSuchen.MengeEinesEinheitenTypsSuchen (RasseExtern      => StadtRasseNummerExtern.Rasse,
                                                                       EinheitTypExtern => 1);
      
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
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).KIAktuelleBeschäftigung := KIDatentypen.Einheit_Bauen;
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt := 10_001;
         return;
      end if;      
      
      VerteidigerVorhanden := EinheitSuchen.MengeEinesEinheitenTypsSuchen (RasseExtern      => StadtRasseNummerExtern.Rasse,
                                                                           EinheitTypExtern => 3);
      
      if
        VerteidigerVorhanden >= Natural (AnzahlStädte)
      then
         null;
         
      elsif
        VerteidigerVorhanden + KIStadtLaufendeBauprojekte.StadtLaufendeBauprojekte (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                                    BauprojektExtern       => 10_002)
        >= Natural (AnzahlStädte)
      then
         null;
         
      else
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).KIAktuelleBeschäftigung := KIDatentypen.Einheit_Bauen;
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt := 10_002;
         return;
      end if;
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in GlobaleRecords.GebäudeVorhandenArray'Range loop
         
         if
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden (GebäudeSchleifenwert) = False
           and
             GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).Erforscht (GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse, GebäudeSchleifenwert).Anforderungen) = True
         then
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).KIAktuelleBeschäftigung := KIDatentypen.Gebäude_Bauen;
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt := 1_000 + Positive (GebäudeSchleifenwert);
            return;
            
         else
            null;
         end if;
         
      end loop GebäudeSchleife;
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).KIAktuelleBeschäftigung := KIDatentypen.Einheit_Bauen;
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt := 10_002;
      
   end KIStadt;

end KIStadt;
