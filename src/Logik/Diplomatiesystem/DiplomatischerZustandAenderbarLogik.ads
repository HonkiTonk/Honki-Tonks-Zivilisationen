pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with DiplomatieDatentypen;
with SpielVariablen;

package DiplomatischerZustandAenderbarLogik is

   procedure StatusÄnderbarkeitPrüfen
     (RasseEinsExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      NeuerStatusExtern : in DiplomatieDatentypen.Status_Untereinander_Bekannt_Enum)
     with
       Pre => (
                 RasseEinsExtern /= RasseZweiExtern
               and
                 SpielVariablen.Rassenbelegung (RasseEinsExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SpielVariablen.Rassenbelegung (RasseZweiExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
private
   
   ÄnderungMöglich : Boolean;
   
   AktuellerStatus : DiplomatieDatentypen.Status_Untereinander_Bekannt_Enum;
   
   SympathieZweiZuEins : DiplomatieDatentypen.Meinung;
   SympathieÄnderung : DiplomatieDatentypen.Meinung;
   
   ZeitSeitÄnderung : Natural;
   
   
   
   function NeutralMöglich
     (AktuellerStatusExtern : in DiplomatieDatentypen.Status_Untereinander_Bekannt_Enum)
      return Boolean;
   
   function NichtangriffspaktMöglich
     (AktuellerStatusExtern : in DiplomatieDatentypen.Status_Untereinander_Bekannt_Enum)
      return Boolean;
   
   function KriegMöglich
     (AktuellerStatusExtern : in DiplomatieDatentypen.Status_Untereinander_Bekannt_Enum)
      return Boolean;

end DiplomatischerZustandAenderbarLogik;
