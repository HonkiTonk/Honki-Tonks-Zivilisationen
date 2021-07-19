pragma SPARK_Mode (On);

with GlobaleKonstanten, Eingabe;

package body StadtSuchen is

   function KoordinatenStadtMitRasseSuchen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.MaximaleStädteMitNullWert
   is begin
      
      StadtSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (2) loop
         
         if
           GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummerSchleifenwert).Position = KoordinatenExtern
         then
            return StadtNummerSchleifenwert;
            
         else
            null;
         end if;
         
      end loop StadtSchleife;
      
      return GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch;
      
   end KoordinatenStadtMitRasseSuchen;



   function KoordinatenStadtOhneRasseSuchen
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleRecords.RassePlatznummerRecord
   is begin

      RasseSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         StadtSchleife:
         for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (2) loop
            
            if
              GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) = GlobaleDatentypen.Leer
            then
               exit StadtSchleife;
            
            elsif
              GlobaleVariablen.StadtGebaut (RasseSchleifenwert, StadtNummerSchleifenwert).Position = KoordinatenExtern
            then
               return (RasseSchleifenwert, StadtNummerSchleifenwert);
               
            else
               null;
            end if;
            
         end loop StadtSchleife;
      end loop RasseSchleife;
      
      return (GlobaleDatentypen.Rassen_Enum'First, GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch);
      
   end KoordinatenStadtOhneRasseSuchen;
   
   
   
   function KoordinatenStadtOhneSpezielleRasseSuchen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleRecords.RassePlatznummerRecord
   is begin

      RasseSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         StadtSchleife:
         for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (2) loop

            if
              RasseExtern = RasseSchleifenwert
              or
                GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) = GlobaleDatentypen.Leer
            then
               exit StadtSchleife;
            
            elsif
              GlobaleVariablen.StadtGebaut (RasseSchleifenwert, StadtNummerSchleifenwert).Position = KoordinatenExtern
            then
               return (RasseSchleifenwert, StadtNummerSchleifenwert);
               
            else
               null;
            end if;
            
         end loop StadtSchleife;
      end loop RasseSchleife;
   
      return (GlobaleDatentypen.Rassen_Enum'First, GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch);
      
   end KoordinatenStadtOhneSpezielleRasseSuchen;
   
   
   
   function AnzahlStädteErmitteln
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.MaximaleStädteMitNullWert
   is begin
      
      AnzahlStädte := 0;
      
      StädteSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (2) loop
         
         if
           GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummerSchleifenwert).ID /= GlobaleDatentypen.Leer
         then
            AnzahlStädte := AnzahlStädte + 1;
            
         else
            null;
         end if;
         
      end loop StädteSchleife;
         
      return AnzahlStädte;
      
   end AnzahlStädteErmitteln;
   
   
   
   function StadtNachNamenSuchen
     return GlobaleRecords.RassePlatznummerRecord
   is begin
      
      StadtName := Eingabe.StadtName;
      
      RasseSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         StadtSchleife:
         for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (2) loop
            
            if
              GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) = GlobaleDatentypen.Leer
            then
               exit StadtSchleife;
               
            elsif
              GlobaleVariablen.StadtGebaut (RasseSchleifenwert, StadtNummerSchleifenwert).Name = StadtName
              and
                GlobaleVariablen.StadtGebaut (RasseSchleifenwert, StadtNummerSchleifenwert).ID /= GlobaleDatentypen.Leer
            then
               return (RasseSchleifenwert, StadtNummerSchleifenwert);
               
            else
               null;
            end if;
            
         end loop StadtSchleife;
      end loop RasseSchleife;
      
      return (GlobaleDatentypen.Rassen_Enum'First, GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch);
      
   end StadtNachNamenSuchen;

end StadtSuchen;
