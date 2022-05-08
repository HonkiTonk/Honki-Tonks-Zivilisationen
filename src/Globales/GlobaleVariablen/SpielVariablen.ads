pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with TextKonstanten;
with RassenDatentypen;
with SpielDatentypen;
with KartenRecords;
with WichtigeRecords;
with EinheitStadtDatentypen;
with WichtigesKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;
with EinheitenRecords;
with StadtRecords;

package SpielVariablen is
   
   -- Auch mal in einen Record packen?
   Schwierigkeitsgrad : SpielDatentypen.Schwierigkeitsgrad_Enum := SpielDatentypen.Schwierigkeitsgrad_Mittel_Enum;
   RundenAnzahl : Positive := Positive'First;
   Rundengrenze : Natural := Natural'First;   
   IronmanName : Unbounded_Wide_Wide_String := TextKonstanten.LeerUnboundedString;
      
   type CursorImSpielArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of KartenRecords.CursorRecord;
   CursorImSpiel : CursorImSpielArray := (others => WichtigesKonstanten.LeerCursor);
   
   -- Später über Nutzereingaben neu belegbar machen.
   type GrenzenArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of WichtigeRecords.GrenzenRecord;
   Grenzen : GrenzenArray := (others => WichtigesKonstanten.LeerGrenzen);

   type EinheitenGebautArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, EinheitStadtDatentypen.MaximaleEinheiten'Range) of EinheitenRecords.EinheitenGebautRecord;
   EinheitenGebaut : EinheitenGebautArray := (others => (others => EinheitenKonstanten.LeerEinheit));
      
   type StadtGebautArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, EinheitStadtDatentypen.MaximaleStädte'Range) of StadtRecords.StadtGebautRecord;
   StadtGebaut : StadtGebautArray := (others => (others => StadtKonstanten.LeerStadt));
      
   type WichtigesArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of WichtigeRecords.WichtigesRecord;
   Wichtiges : WichtigesArray := (others => WichtigesKonstanten.LeerWichtigesZeug);
   
   type DiplomatieArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, RassenDatentypen.Rassen_Verwendet_Enum'Range) of WichtigeRecords.DiplomatieRecord;
   Diplomatie : DiplomatieArray := (others => (others => WichtigesKonstanten.LeerDiplomatie));

end SpielVariablen;
