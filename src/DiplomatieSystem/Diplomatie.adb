pragma SPARK_Mode (On);

with GlobaleKonstanten;

with Kampfsystem, Auswahl;

package body Diplomatie is

   procedure DiplomatieAuswählen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      null;
      
   end DiplomatieAuswählen;
   
   
   
   procedure ErstkontaktMenschMensch
     (EigeneRasseExtern, FremdeRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      null;
      
   end ErstkontaktMenschMensch;
   
   
   
   procedure ErstkontaktMenschKI
     (EigeneRasseExtern, FremdeRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      null;
      
   end ErstkontaktMenschKI;



   procedure KriegDurchDirektenAngriff
     (AngreifendeRasseExtern, VerteidigendeRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      GlobaleVariablen.Diplomatie (AngreifendeRasseExtern, VerteidigendeRasseExtern) := GlobaleDatentypen.Krieg;
      GlobaleVariablen.Diplomatie (VerteidigendeRasseExtern, AngreifendeRasseExtern) := GlobaleDatentypen.Krieg;
      
   end KriegDurchDirektenAngriff;



   function DiplomatischenStatusPrüfen
     (EigeneRasseExtern, FremdeRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.Status_Untereinander_Enum
   is begin
      
      return GlobaleVariablen.Diplomatie (EigeneRasseExtern, FremdeRasseExtern);
      
   end DiplomatischenStatusPrüfen;



   procedure GegnerAngreifenOderNicht
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      GegnerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        Diplomatie.DiplomatischenStatusPrüfen (EigeneRasseExtern => EinheitRasseNummerExtern.Rasse,
                                                FremdeRasseExtern => GegnerExtern.Rasse)
      is
         when GlobaleDatentypen.Neutral | GlobaleDatentypen.Offene_Grenzen =>
            if
              Auswahl.AuswahlJaNein (FrageZeileExtern => 11) = GlobaleKonstanten.JaKonstante
            then
               Diplomatie.KriegDurchDirektenAngriff (AngreifendeRasseExtern => EinheitRasseNummerExtern.Rasse,
                                                     VerteidigendeRasseExtern => GegnerExtern.Rasse);
                  
            else
               return;
            end if;
                  
         when GlobaleDatentypen.Krieg =>
            null;

         when others =>
            return;
      end case;
      
      Gewonnen := Kampfsystem.KampfsystemNahkampf (AngreiferRasseNummerExtern   => EinheitRasseNummerExtern,
                                                   VerteidigerRasseNummerExtern => GegnerExtern);
      
   end GegnerAngreifenOderNicht;

end Diplomatie;
