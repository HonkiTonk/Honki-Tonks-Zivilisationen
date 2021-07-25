pragma SPARK_Mode (On);

with GlobaleKonstanten;

package body EinheitSuchen is

   function KoordinatenEinheitMitRasseSuchen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      EinheitSchleife:
      for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
         
         if
           GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerSchleifenwert).Position = KoordinatenExtern
         then
            return EinheitNummerSchleifenwert;
            
         else
            null;
         end if;
         
      end loop EinheitSchleife;
      
      return GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch;
      
   end KoordinatenEinheitMitRasseSuchen;



   function KoordinatenTransporterMitRasseSuchen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      EinheitSchleife:
      for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
         
         if
           GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerSchleifenwert).Position = KoordinatenExtern
           and then
             EinheitenDatenbank.EinheitenListe (RasseExtern, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerSchleifenwert).ID).KannTransportieren /= 0
         then
            return EinheitNummerSchleifenwert;
            
         else
            null;
         end if;
         
      end loop EinheitSchleife;
      
      return GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch;
      
   end KoordinatenTransporterMitRasseSuchen;



   function KoordinatenEinheitOhneRasseSuchen
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleRecords.RassePlatznummerRecord
   is begin

      RasseSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         EinheitSchleife:
         for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
            
            if
              GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) = GlobaleDatentypen.Leer
            then
               exit EinheitSchleife;
               
            elsif
              GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitNummerSchleifenwert).Position = KoordinatenExtern
            then
               return (RasseSchleifenwert, EinheitNummerSchleifenwert);
               
            else
               null;
            end if;
            
         end loop EinheitSchleife;
      end loop RasseSchleife;
      
      return (GlobaleDatentypen.Rassen_Enum'First, GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch);
      
   end KoordinatenEinheitOhneRasseSuchen;



   function KoordinatenEinheitOhneSpezielleRasseSuchen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleRecords.RassePlatznummerRecord
   is begin

      RasseSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         EinheitSchleife:
         for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (2) loop

            if
              RasseExtern = RasseSchleifenwert
              or
                GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) = GlobaleDatentypen.Leer
            then
               exit EinheitSchleife;
               
            elsif
              GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitNummerSchleifenwert).Position = KoordinatenExtern
            then
               return (RasseSchleifenwert, EinheitNummerSchleifenwert);
               
            else
               null;
            end if;
            
         end loop EinheitSchleife;
      end loop RasseSchleife;
      
      return (GlobaleDatentypen.Rassen_Enum'First, GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch);
      
   end KoordinatenEinheitOhneSpezielleRasseSuchen;



   function EinheitAufTransporterSuchen
     (EinheitRassePlatznummer : in GlobaleRecords.RassePlatznummerRecord;
      EinheitNummer : in GlobaleDatentypen.MaximaleEinheiten)
      return Natural
   is begin

      TransporterSchleife:
      for TransporterPlatzSchleifenwert in GlobaleRecords.TransporterArray'Range loop
         
         if
           GlobaleVariablen.EinheitenGebaut (EinheitRassePlatznummer.Rasse, EinheitRassePlatznummer.Platznummer).Transportiert (TransporterPlatzSchleifenwert) = EinheitNummer
         then
            return TransporterPlatzSchleifenwert;
            
         else
            null;
         end if;
         
      end loop TransporterSchleife;
      
      return Natural (GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch);
      
   end EinheitAufTransporterSuchen;



   function IstEinheitAufTransporter
     (EinheitRassePlatznummer : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      TransporterSchleife:
      for TransporterPlatzSchleifenwert in GlobaleRecords.TransporterArray'Range loop
         
         if
           GlobaleVariablen.EinheitenGebaut (EinheitRassePlatznummer.Rasse, EinheitRassePlatznummer.Platznummer).Transportiert (TransporterPlatzSchleifenwert) /= 0
         then
            return True;
            
         else
            null;
         end if;
         
      end loop TransporterSchleife;
      
      return False;
      
   end IstEinheitAufTransporter;
   
   
   
   function MengeEinesEinheitenTypsSuchen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      EinheitTypExtern : in GlobaleDatentypen.Einheit_Art_Verwendet_Enum;
      GesuchteMenge : in GlobaleDatentypen.MaximaleEinheitenMitNullWert)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      AnzahlEinheitTyp := 0;
      
      EinheitSchleife:
      for EinheitSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
         
         if
           GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitSchleifenwert).ID = 0
         then
            null;
         
         elsif
           EinheitenDatenbank.EinheitenListe (RasseExtern, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitSchleifenwert).ID).EinheitTyp = EinheitTypExtern
         then
            AnzahlEinheitTyp := AnzahlEinheitTyp + 1;
            
         else
            null;
         end if;
         
         if
           GesuchteMenge > 0
           and
             AnzahlEinheitTyp >= GesuchteMenge
         then
            return AnzahlEinheitTyp;
            
         else
            null;
         end if;
         
      end loop EinheitSchleife;
      
      return AnzahlEinheitTyp;
      
   end MengeEinesEinheitenTypsSuchen;
   
   
   
   function AnzahlEinheitenSuchen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      GesuchteMenge : in GlobaleDatentypen.MaximaleEinheitenMitNullWert)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      AnzahlEinheiten := 0;
      
      EinheitenSchleife:
      for EinheitenSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
         
         if
           GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitenSchleifenwert).ID /= 0
         then
            AnzahlEinheiten := AnzahlEinheiten + 1;
            
         else
            null;
         end if;
         
         if
           GesuchteMenge > 0
           and
             AnzahlEinheiten >= GesuchteMenge
         then
            return AnzahlEinheiten;
            
         else
            null;
         end if;
         
      end loop EinheitenSchleife;
      
      return GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch;
      
   end AnzahlEinheitenSuchen;     

end EinheitSuchen;
