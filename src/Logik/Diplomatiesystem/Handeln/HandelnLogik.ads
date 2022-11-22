with RassenDatentypen;

with LeseRassenbelegung;

package HandelnLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   
   procedure SichtbarkeitTauschen
     (RasseEinsExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseEinsExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 LeseRassenbelegung.Belegung (RasseExtern => RasseZweiExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   

   function Handelsmenü
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Integer
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 LeseRassenbelegung.Belegung (RasseExtern => KontaktierteRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
private
   
   AuswahlHandeln : Integer;
   Geldmenge : Integer;
   
   procedure KontakteVerkaufen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 LeseRassenbelegung.Belegung (RasseExtern => KontaktierteRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure KontakteKaufen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 LeseRassenbelegung.Belegung (RasseExtern => KontaktierteRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure KontakteTauschen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 LeseRassenbelegung.Belegung (RasseExtern => KontaktierteRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure GeldVerschenken
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 LeseRassenbelegung.Belegung (RasseExtern => KontaktierteRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure GeldVerlangen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 LeseRassenbelegung.Belegung (RasseExtern => KontaktierteRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
      
   procedure SichtbarkeitKaufen
     (RasseEinsExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseEinsExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 LeseRassenbelegung.Belegung (RasseExtern => RasseZweiExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure SichtbarkeitVerkaufen
     (RasseEinsExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseEinsExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 LeseRassenbelegung.Belegung (RasseExtern => RasseZweiExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   
   
   function Handeln
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Integer
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 LeseRassenbelegung.Belegung (RasseExtern => KontaktierteRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

end HandelnLogik;
