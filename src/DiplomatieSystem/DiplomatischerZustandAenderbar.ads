pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package DiplomatischerZustandAenderbar is

   function StatusÄnderbarkeitPrüfen
     (RasseEinsExtern, RasseZweiExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      NeuerStatusExtern : in SonstigeDatentypen.Status_Untereinander_Bekannt_Enum)
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
   
   AktuellerStatus : SonstigeDatentypen.Status_Untereinander_Bekannt_Enum;
   
   SympathieZweiZuEins : EinheitStadtDatentypen.ProduktionFeld;
   SympathieÄnderung : EinheitStadtDatentypen.ProduktionFeld;
   
   ZeitSeitÄnderung : Natural;
   
   procedure EsHerrschtKrieg;
   
   
   
   function NeutralMöglich
     return Boolean;
   
   function NichtangriffspaktMöglich
     return Boolean;
   
   function KriegMöglich
     return Boolean;

end DiplomatischerZustandAenderbar;
