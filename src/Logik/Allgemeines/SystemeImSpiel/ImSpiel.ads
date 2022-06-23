pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with RueckgabeDatentypen;
with SonstigeVariablen;

package ImSpiel is

   function ImSpiel
     return RueckgabeDatentypen.Rückgabe_Werte_Enum;

private

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
                 SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.KI_Spieler_Enum
              );

   function RasseImSpiel
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum;

   function RasseDurchgehen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
     with
       Pre => (
                 SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

   function MenschlicherSpieler
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
     with
       Pre => (
                 SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );

   function MenschAmZug
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
     with
       Pre => (
                 SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );

   function Spielmenü
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
     with
       Pre => (
                 SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );

   function NochSpielerVorhanden
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre => (
                 SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

   function Befehle
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
     with
       Pre => (
                 SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );

end ImSpiel;
