pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with EinheitStadtDatentypen;

package DiplomatischerZustandAenderbar is

   function StatusÄnderbarkeitPrüfen
     (RasseEinsExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      NeuerStatusExtern : in SystemDatentypen.Status_Untereinander_Bekannt_Enum)
      return Boolean
     with
       Pre =>
         (RasseEinsExtern /= RasseZweiExtern
          and
            GlobaleVariablen.RassenImSpiel (RasseEinsExtern) /= SystemDatentypen.Leer_Spieler_Enum
          and
            GlobaleVariablen.RassenImSpiel (RasseZweiExtern) /= SystemDatentypen.Leer_Spieler_Enum);
   
private
   
   ÄnderungMöglich : Boolean;
   
   AktuellerStatus : SystemDatentypen.Status_Untereinander_Bekannt_Enum;
   
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
