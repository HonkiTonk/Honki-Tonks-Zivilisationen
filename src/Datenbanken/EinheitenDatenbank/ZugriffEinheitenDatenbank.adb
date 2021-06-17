pragma SPARK_Mode (On);

with EinheitenDatenbank;

package body ZugriffEinheitenDatenbank is

   function EinheitenGrafik
     (RasseExtern : GlobaleDatentypen.Rassen;
      IDExtern : GlobaleDatentypen.EinheitenID)
      return Wide_Wide_Character
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).EinheitenGrafik;
      
   end EinheitenGrafik;
   
   
   
   function EinheitTyp
     (RasseExtern : GlobaleDatentypen.Rassen;
      IDExtern : GlobaleDatentypen.EinheitenID)
      return GlobaleDatentypen.EinheitenTyp
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).EinheitTyp;
      
   end EinheitTyp;

end ZugriffEinheitenDatenbank;
