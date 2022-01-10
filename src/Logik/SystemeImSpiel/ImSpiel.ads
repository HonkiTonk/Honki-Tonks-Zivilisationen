pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;

package ImSpiel is

   function ImSpiel
     return SystemDatentypen.Rückgabe_Werte_Enum;

private

   AktuellerBefehlSpieler : SystemDatentypen.Rückgabe_Werte_Enum;
   RückgabeOptionen : SystemDatentypen.Rückgabe_Werte_Enum;
   RückgabeRassen : SystemDatentypen.Rückgabe_Werte_Enum;
   RückgabeWert : SystemDatentypen.Rückgabe_Werte_Enum;
   RückgabeSpielmenü : SystemDatentypen.Rückgabe_Werte_Enum;
   RückgabeMenschAmZug : SystemDatentypen.Rückgabe_Werte_Enum;
   AuswahlSpielmenü : SystemDatentypen.Rückgabe_Werte_Enum;

   procedure KISpieler
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemDatentypen.Spieler_KI);



   function RasseImSpiel
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum;

   function RasseDurchgehen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum;

   function MenschlicherSpieler
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemDatentypen.Spieler_Mensch);

   function MenschAmZug
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum;

   function Spielmenü
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum;

   function NochSpielerVorhanden
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Boolean;

   function Befehle
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemDatentypen.Spieler_Mensch);

end ImSpiel;
