pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package DiplomatischerZustandAenderbar is

   procedure StatusÄnderbarkeitPrüfen
     (RasseEinsExtern, RasseZweiExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      NeuerStatusExtern : in GlobaleDatentypen.Status_Untereinander_Bekannt_Enum)
     with
       Pre =>
         (RasseEinsExtern /= RasseZweiExtern
          and
            GlobaleVariablen.RassenImSpiel (RasseEinsExtern) /= GlobaleDatentypen.Leer
          and
            GlobaleVariablen.RassenImSpiel (RasseZweiExtern) /= GlobaleDatentypen.Leer);
   
private
   
   ÄnderungMöglich : Boolean;
   
   procedure EsHerrschtKrieg;
   
   
   
   function NeutralMöglich
     (RasseEinsExtern, RasseZweiExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
     return Boolean;
   
   function OffeneGrenzenMöglich
     (RasseEinsExtern, RasseZweiExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
     return Boolean;
   
   function NichtangriffspaktMöglich
     (RasseEinsExtern, RasseZweiExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
     return Boolean;
   
   function DefensivbündnisMöglich
     (RasseEinsExtern, RasseZweiExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
     return Boolean;
   
   function OffensivbündnisMöglich
     (RasseEinsExtern, RasseZweiExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
     return Boolean;
   
   function KriegMöglich
     (RasseEinsExtern, RasseZweiExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
     return Boolean;

end DiplomatischerZustandAenderbar;
