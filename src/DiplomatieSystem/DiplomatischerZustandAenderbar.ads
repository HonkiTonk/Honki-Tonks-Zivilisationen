pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package DiplomatischerZustandAenderbar is

   function StatusÄnderbarkeitPrüfen
     (RasseEinsExtern, RasseZweiExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      NeuerStatusExtern : in GlobaleDatentypen.Status_Untereinander_Bekannt_Enum)
      return Boolean
     with
       Pre =>
         (RasseEinsExtern /= RasseZweiExtern
          and
            GlobaleVariablen.RassenImSpiel (RasseEinsExtern) /= GlobaleDatentypen.Leer
          and
            GlobaleVariablen.RassenImSpiel (RasseZweiExtern) /= GlobaleDatentypen.Leer);
   
private
   
   ÄnderungMöglich : Boolean;
   
   AktuellerStatus : GlobaleDatentypen.Status_Untereinander_Bekannt_Enum;
   
   SympathieZweiZuEins : GlobaleDatentypen.ProduktionFeld;
   SympathieÄnderung : GlobaleDatentypen.ProduktionFeld;
   
   ZeitSeitÄnderung : Natural;
   
   procedure EsHerrschtKrieg;
   
   
   
   function NeutralMöglich
     return Boolean;
   
   function NichtangriffspaktMöglich
     return Boolean;
   
   function KriegMöglich
     return Boolean;

end DiplomatischerZustandAenderbar;
