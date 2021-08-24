pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KIKonstanten;

with EinheitSuchen, KIStadtLaufendeBauprojekte;

package body KIEinheitenBauen is

   function EinheitenBauen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return KIRecords.EinheitIDBewertungRecord
   is begin
      
      EinheitBewertet := KIKonstanten.LeerEinheitIDBewertung;
      
      EinheitenSchleife:
      for EinheitenSchleifenwert in GlobaleDatentypen.EinheitenID'Range loop
         
         SiedlerVorhanden := EinheitSuchen.MengeEinesEinheitenTypsSuchen (RasseExtern         => StadtRasseNummerExtern.Rasse,
                                                                          EinheitTypExtern    => GlobaleDatentypen.Arbeiter,
                                                                          GesuchteMengeExtern => 2);
      
         if
           SiedlerVorhanden >= 2
         then
            null;
         
         elsif
           SiedlerVorhanden + KIStadtLaufendeBauprojekte.StadtLaufendeBauprojekte (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                                   BauprojektExtern       => GlobaleKonstanten.EinheitAufschlag + 1)
           >= 2
         then
            null;
         
         else
            null;
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
                                                                                       BauprojektExtern       => GlobaleKonstanten.EinheitAufschlag + 2)
           >= AnzahlStädte * 10
         then
            null;
         
         else
            null;
         end if;
      
      
      
         if
           VerteidigerVorhanden <= 10
         then
            null;
         
         else
            null;
         end if;
         
      end loop EinheitenSchleife;
      
      return EinheitBewertet;
      
   end EinheitenBauen;

end KIEinheitenBauen;
