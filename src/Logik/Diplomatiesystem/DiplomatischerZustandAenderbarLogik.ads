with SpeziesDatentypen;
with DiplomatieDatentypen;

with LeseSpeziesbelegung;

package DiplomatischerZustandAenderbarLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type SpeziesDatentypen.Spezies_Enum;

   procedure StatusÄnderbarkeitPrüfen
     (SpeziesEinsExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      SpeziesZweiExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      NeuerStatusExtern : in DiplomatieDatentypen.Status_Untereinander_Bekannt_Enum;
      ZeitbegrenzungBerücksichtigenExtern : in Boolean)
     with
       Pre => (
                 SpeziesEinsExtern /= SpeziesZweiExtern
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesEinsExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesZweiExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
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
     (AktuellerStatusExtern : in DiplomatieDatentypen.Status_Untereinander_Bekannt_Enum;
      ZeitbegrenzungBerücksichtigenExtern : in Boolean)
      return Boolean;

end DiplomatischerZustandAenderbarLogik;
