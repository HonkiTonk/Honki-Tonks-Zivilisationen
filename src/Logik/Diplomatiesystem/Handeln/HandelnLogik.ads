with SpeziesDatentypen;

with LeseSpeziesbelegung;

package HandelnLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   
   procedure SichtbarkeitTauschen
     (SpeziesEinsExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      SpeziesZweiExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesEinsExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesZweiExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   

   function Handelsmenü
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KontaktierteSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Integer
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => KontaktierteSpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
private
   
   AuswahlHandeln : Integer;
   Geldmenge : Integer;
   
   procedure KontakteVerkaufen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KontaktierteSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => KontaktierteSpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure KontakteKaufen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KontaktierteSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => KontaktierteSpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure KontakteTauschen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KontaktierteSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => KontaktierteSpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure GeldVerschenken
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KontaktierteSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => KontaktierteSpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure GeldVerlangen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KontaktierteSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => KontaktierteSpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
      
   procedure SichtbarkeitKaufen
     (SpeziesEinsExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      SpeziesZweiExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesEinsExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesZweiExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure SichtbarkeitVerkaufen
     (SpeziesEinsExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      SpeziesZweiExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesEinsExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesZweiExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   
   
   function Handeln
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KontaktierteSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Integer
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => KontaktierteSpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end HandelnLogik;
