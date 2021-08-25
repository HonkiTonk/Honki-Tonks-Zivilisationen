pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KIKonstanten;

with EinheitSuchen, KIStadtLaufendeBauprojekte, BewegungPassierbarkeitPruefen, LeseEinheitenDatenbank;

package body KIEinheitenBauen is

   function EinheitenBauen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return KIRecords.EinheitIDBewertungRecord
   is begin
      
      EinheitBewertet := KIKonstanten.LeerEinheitIDBewertung;
      
      EinheitenSchleife:
      for EinheitenSchleifenwert in GlobaleDatentypen.EinheitenID'Range loop
         PrüfSchleife:
         loop
            
            case
              Siedler (StadtRasseNummerExtern => StadtRasseNummerExtern,
                       EinheitenIDExtern      => EinheitenSchleifenwert)
            is
               when True =>
                  exit PrüfSchleife;
                  
               when False =>
                  null;
            end case;
               
            -- case
            
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
      
            UmgebungPassierbar := BewegungPassierbarkeitPruefen.RichtigeUmgebungVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                                           EinheitenIDExtern      => EinheitenSchleifenwert);
            
            exit PrüfSchleife;
         
         end loop PrüfSchleife;
      end loop EinheitenSchleife;
      
      return EinheitBewertet;
      
   end EinheitenBauen;
   
   
   
   function Siedler
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      EinheitenIDExtern : in GlobaleDatentypen.EinheitenID)
      return Boolean
   is begin
      
      case
        LeseEinheitenDatenbank.EinheitArt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                           IDExtern    => EinheitenIDExtern)
      is
         when GlobaleDatentypen.Arbeiter =>
            null;
            
         when others =>
            return False;
      end case;
      
      SiedlerVorhanden := EinheitSuchen.MengeEinesEinheitenTypsSuchen (RasseExtern         => StadtRasseNummerExtern.Rasse,
                                                                       EinheitTypExtern    => GlobaleDatentypen.Arbeiter,
                                                                       GesuchteMengeExtern => 2);
      
      if
        SiedlerVorhanden >= MinimaleSiedlerMenge
        or
          SiedlerVorhanden + KIStadtLaufendeBauprojekte.StadtLaufendeBauprojekte (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                                  BauprojektExtern       => GlobaleKonstanten.EinheitAufschlag + 1)
        >= MinimaleSiedlerMenge
      then
         null;
         
      else
         null;
      end if;
      
      return True;
      
   end Siedler;

end KIEinheitenBauen;
