pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TextKonstanten;
with RassenDatentypen;
with SpielDatentypen;
with KartenRecords;
with SpielRecords;
with StadtDatentypen;
with EinheitenDatentypen;
with WichtigesKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;
with EinheitenRecords;
with StadtRecords;
with SystemRecords;

package SpielVariablen is
   
   RassenImSpiel : RassenDatentypen.RassenImSpielArray := (others => RassenDatentypen.Leer_Spieler_Enum);
   
   Debug : SystemRecords.DebugRecord := (others => False);
   
   Allgemeines : SpielRecords.AllgemeinesRecord := (
                                                    Gewonnen            => False,
                                                    Weiterspielen       => False,
                                                    RasseAmZugNachLaden => EinheitenKonstanten.LeerRasse,
                                                    Schwierigkeitsgrad  => SpielDatentypen.Schwierigkeitsgrad_Mittel_Enum,
                                                    Rundenanzahl        => Positive'First,
                                                    Rundengrenze        => Natural'First,   
                                                    IronmanName         => TextKonstanten.LeerUnboundedString
                                                   );
      
   type CursorImSpielArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of KartenRecords.CursorRecord;
   CursorImSpiel : CursorImSpielArray := (others => WichtigesKonstanten.LeerCursor);
   
   -- Später über Nutzereingaben neu belegbar machen.
   type GrenzenArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of SpielRecords.GrenzenRecord;
   Grenzen : GrenzenArray := (others => WichtigesKonstanten.LeerGrenzen);

   type EinheitenGebautArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, EinheitenDatentypen.MaximaleEinheiten'Range) of EinheitenRecords.EinheitenGebautRecord;
   EinheitenGebaut : EinheitenGebautArray := (others => (others => EinheitenKonstanten.LeerEinheit));
      
   type StadtGebautArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, StadtDatentypen.MaximaleStädte'Range) of StadtRecords.StadtGebautRecord;
   StadtGebaut : StadtGebautArray := (others => (others => StadtKonstanten.LeerStadt));
      
   type WichtigesArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of SpielRecords.WichtigesRecord;
   Wichtiges : WichtigesArray := (others => WichtigesKonstanten.LeerWichtigesZeug);
   
   type DiplomatieArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, RassenDatentypen.Rassen_Verwendet_Enum'Range) of SpielRecords.DiplomatieRecord;
   Diplomatie : DiplomatieArray := (others => (others => WichtigesKonstanten.LeerDiplomatie));

end SpielVariablen;
