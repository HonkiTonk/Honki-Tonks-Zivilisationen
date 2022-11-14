with RueckgabeDatentypen;

private with RassenDatentypen;
private with SpielVariablen;

package SpielLogik is
   pragma Elaborate_Body;

   function Spiel
     return RueckgabeDatentypen.Rückgabe_Werte_Enum;

private
   use type RassenDatentypen.Spieler_Enum;

   AktuellerBefehlSpieler : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   RückgabeOptionen : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   RückgabeRassen : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   RückgabeWert : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   RückgabeSpielmenü : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   RückgabeMenschAmZug : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   AuswahlSpielmenü : RueckgabeDatentypen.Rückgabe_Werte_Enum;

   procedure KISpieler
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.KI_Spieler_Enum
              );

   function RasseImSpiel
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum;

   function RasseDurchgehen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

   function MenschlicherSpieler
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );

   function MenschAmZug
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );

   function Spielmenü
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );

end SpielLogik;
