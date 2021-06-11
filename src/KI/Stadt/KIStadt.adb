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
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).KIAktuelleBeschäftigung /= KIDatentypen.Keine_Aufgabe
      then
         return;
         
      else
         StädteMitGleichemBauprojekt := 0;
         AnzahlStädte := StadtSuchen.AnzahlStädteErmitteln (RasseExtern => StadtRasseNummerExtern.Rasse);
      end if;
      
      SiedlerVorhanden := EinheitSuchen.MengeEinesEinheitenTypsSuchen (RasseExtern      => StadtRasseNummerExtern.Rasse,
                                                                       EinheitTypExtern => 1,
                                                                       GesuchteMenge    => 2);
      
      if
        SiedlerVorhanden >= 2
      then
         null;
         
      elsif
        SiedlerVorhanden + GlobaleDatentypen.MaximaleStädteMitNullWert (KIStadtLaufendeBauprojekte.StadtLaufendeBauprojekte (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                                                                              BauprojektExtern       => 10_001))
        >= 2
      then
         null;
         
      else         
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).KIAktuelleBeschäftigung := KIDatentypen.Einheit_Bauen;
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt := 10_001;
         return;
      end if;      
      
      VerteidigerVorhanden := EinheitSuchen.MengeEinesEinheitenTypsSuchen (RasseExtern      => StadtRasseNummerExtern.Rasse,
                                                                           EinheitTypExtern => 3,
                                                                           GesuchteMenge    => AnzahlStädte);
      
      if
        VerteidigerVorhanden >= AnzahlStädte
      then
         null;
         
      elsif
        VerteidigerVorhanden + GlobaleDatentypen.MaximaleStädteMitNullWert (KIStadtLaufendeBauprojekte.StadtLaufendeBauprojekte (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                                                                                  BauprojektExtern       => 10_002))
        >= AnzahlStädte
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
             (GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse, GebäudeSchleifenwert).Anforderungen = 0
              or else
              GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).Erforscht (GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse, GebäudeSchleifenwert).Anforderungen) = True)
         then
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).KIAktuelleBeschäftigung := KIDatentypen.Gebäude_Bauen;
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt := 1_000 + Positive (GebäudeSchleifenwert);
            return;
            
         else
            null;
         end if;
         
      end loop GebäudeSchleife;
      
      if
        VerteidigerVorhanden <= 10
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).KIAktuelleBeschäftigung := KIDatentypen.Einheit_Bauen;
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt := 10_002;
         
      else
         null;
      end if;
      
   end KIStadt;

end KIStadt;
