pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SonstigeVariablen;
with RueckgabeDatentypen;

package DebugmenueSFML is

   procedure Debugmenü
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Spieler_Mensch_Enum);

private

   RückgabeDebugmenü : RueckgabeDatentypen.Rückgabe_Werte_Enum;

   procedure KarteAufdecken
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);

   procedure VolleInformation;

   procedure AlleTechnologien
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);

   procedure MaximalesGeld
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);

end DebugmenueSFML;
