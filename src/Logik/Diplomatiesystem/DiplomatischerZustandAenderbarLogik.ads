with RassenDatentypen;
with DiplomatieDatentypen;

with LeseRassenbelegung;

package DiplomatischerZustandAenderbarLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   use type RassenDatentypen.Rassen_Enum;

   procedure StatusÄnderbarkeitPrüfen
     (RasseEinsExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      NeuerStatusExtern : in DiplomatieDatentypen.Status_Untereinander_Bekannt_Enum)
     with
       Pre => (
                 RasseEinsExtern /= RasseZweiExtern
               and
                 LeseRassenbelegung.Belegung (RasseExtern => RasseEinsExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 LeseRassenbelegung.Belegung (RasseExtern => RasseZweiExtern) /= RassenDatentypen.Leer_Spieler_Enum
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
