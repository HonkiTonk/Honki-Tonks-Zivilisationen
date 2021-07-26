pragma SPARK_Mode (On);

with GlobaleKonstanten;

with EinheitenAllgemein;

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
      
      return GlobaleKonstanten.LeerEinheitStadtNummer;
      
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
             EinheitenDatenbank.EinheitenListe (RasseExtern, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerSchleifenwert).ID).KannTransportieren /= GlobaleKonstanten.LeerTransportiertWirdTransportiert
         then
            return EinheitNummerSchleifenwert;
            
         else
            null;
         end if;
         
      end loop EinheitSchleife;
      
      return GlobaleKonstanten.LeerEinheitStadtNummer;
      
   end KoordinatenTransporterMitRasseSuchen;



   -- Zu beachten, wenn die Einheit sich in einem Transporter befindet, dann wird immer die Nummer des Transporters zurückgegeben.
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
               if
                 GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitNummerSchleifenwert).WirdTransportiert = GlobaleKonstanten.LeerTransportiertWirdTransportiert
               then
                  return (RasseSchleifenwert, EinheitNummerSchleifenwert);
                  
               else
                  return (RasseSchleifenwert, GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitNummerSchleifenwert).WirdTransportiert);
               end if;
               
            else
               null;
            end if;
            
         end loop EinheitSchleife;
      end loop RasseSchleife;
      
      return (GlobaleDatentypen.Rassen_Enum'First, GlobaleKonstanten.LeerEinheitStadtNummer);
      
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
      
      return (GlobaleDatentypen.Rassen_Enum'First, GlobaleKonstanten.LeerEinheitStadtNummer);
      
   end KoordinatenEinheitOhneSpezielleRasseSuchen;



   function EinheitAufTransporterSuchen
     (TransporterExtern : in GlobaleRecords.RassePlatznummerRecord;
      LadungExtern : in GlobaleDatentypen.MaximaleEinheiten)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
   is begin

      TransporterSchleife:
      for TransporterPlatzSchleifenwert in GlobaleRecords.TransporterArray'First .. EinheitenAllgemein.MaximaleTransporterKapazität (TransporterExtern => TransporterExtern) loop
         
         if
           GlobaleVariablen.EinheitenGebaut (TransporterExtern.Rasse, TransporterExtern.Platznummer).Transportiert (TransporterPlatzSchleifenwert) = LadungExtern
         then
            return TransporterPlatzSchleifenwert;
            
         else
            null;
         end if;
         
      end loop TransporterSchleife;
      
      return GlobaleKonstanten.LeerEinheitStadtNummer;
      
   end EinheitAufTransporterSuchen;



   function HatTransporterLadung
     (EinheitRassePlatznummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      TransporterSchleife:
      for TransporterPlatzSchleifenwert in GlobaleRecords.TransporterArray'First .. EinheitenAllgemein.MaximaleTransporterKapazität (TransporterExtern => EinheitRassePlatznummerExtern) loop
         
         if
           GlobaleVariablen.EinheitenGebaut (EinheitRassePlatznummerExtern.Rasse, EinheitRassePlatznummerExtern.Platznummer).Transportiert (TransporterPlatzSchleifenwert)
           /= GlobaleKonstanten.LeerTransportiertWirdTransportiert
         then
            return True;
            
         else
            null;
         end if;
         
      end loop TransporterSchleife;
      
      return False;
      
   end HatTransporterLadung;
   
   
   
   function MengeEinesEinheitenTypsSuchen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      EinheitTypExtern : in GlobaleDatentypen.Einheit_Art_Verwendet_Enum;
      GesuchteMengeExtern : in GlobaleDatentypen.MaximaleEinheitenMitNullWert)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      AnzahlEinheitTyp := 0;
      
      EinheitSchleife:
      for EinheitSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
         
         if
           GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitSchleifenwert).ID = GlobaleKonstanten.LeerEinheit.ID
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
           GesuchteMengeExtern > 0
           and
             AnzahlEinheitTyp >= GesuchteMengeExtern
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
      GesuchteMengeExtern : in GlobaleDatentypen.MaximaleEinheitenMitNullWert)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      AnzahlEinheiten := 0;
      
      EinheitenSchleife:
      for EinheitenSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
         
         if
           GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitenSchleifenwert).ID /= GlobaleKonstanten.LeerEinheit.ID
         then
            AnzahlEinheiten := AnzahlEinheiten + 1;
            
         else
            null;
         end if;
         
         if
           GesuchteMengeExtern > 0
           and
             AnzahlEinheiten >= GesuchteMengeExtern
         then
            return AnzahlEinheiten;
            
         else
            null;
         end if;
         
      end loop EinheitenSchleife;
      
      return GlobaleKonstanten.LeerEinheitStadtNummer;
      
   end AnzahlEinheitenSuchen;     

end EinheitSuchen;
