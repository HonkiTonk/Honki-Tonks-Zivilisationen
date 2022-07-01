pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SystemDatentypen;
with SpielVariablen;

private with ProduktionDatentypen;

package DiplomatischerZustandAenderbar is

   function StatusÄnderbarkeitPrüfen
     (RasseEinsExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      NeuerStatusExtern : in SystemDatentypen.Status_Untereinander_Bekannt_Enum)
      return Boolean
     with
       Pre => (
                 RasseEinsExtern /= RasseZweiExtern
               and
                 SpielVariablen.RassenImSpiel (RasseEinsExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SpielVariablen.RassenImSpiel (RasseZweiExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
private
   
   ÄnderungMöglich : Boolean;
   
   AktuellerStatus : SystemDatentypen.Status_Untereinander_Bekannt_Enum;
   
   SympathieZweiZuEins : ProduktionDatentypen.Feldproduktion;
   SympathieÄnderung : ProduktionDatentypen.Feldproduktion;
   
   ZeitSeitÄnderung : Natural;
   
   procedure EsHerrschtKrieg;
   
   
   
   function NeutralMöglich
     return Boolean;
   
   function NichtangriffspaktMöglich
     return Boolean;
   
   function KriegMöglich
     return Boolean;

end DiplomatischerZustandAenderbar;
