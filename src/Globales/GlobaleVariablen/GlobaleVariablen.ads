pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with SystemDatentypen, EinheitStadtRecords, NutzerRecords, KartenRecords, WichtigeRecords, SystemKonstanten, SonstigesKonstanten, EinheitenKonstanten, StadtKonstanten, EinheitStadtDatentypen, SonstigeDatentypen;

package GlobaleVariablen is

   -- Schreiben/Ausgabe
   -- Die einzelnen Textarrays hier rein oder in eine eigene Datei?
   type NutzerEinstellungenArray is array (1 .. 3) of Unbounded_Wide_Wide_String;
   NutzerEinstellungen : NutzerRecords.NutzerEinstellungenRecord := (
                                                                     -- Sprache
                                                                     To_Unbounded_Wide_Wide_String (Source => SystemKonstanten.LeerText),
                                                                     -- Anzahl Autosaves
                                                                     10,
                                                                     -- Rundenanzahl bis Autosave
                                                                     10
                                                                    );
   -- Schreiben/Ausgabe
   
   

   -- Cursor
   type CursorImSpielArray is array (SonstigeDatentypen.Rassen_Verwendet_Enum'Range) of KartenRecords.CursorRecord;
   CursorImSpiel : CursorImSpielArray := (others => SonstigesKonstanten.LeerCursor);
   -- Cursor
   
   

   -- Zeug
   RundenAnzahl : Positive := Positive'First;
   Rundengrenze : Natural := Natural'First;

   -- Nicht belegt, Menschlicher Spieler, KI
   RassenImSpiel : SonstigeDatentypen.RassenImSpielArray := (others => SonstigeDatentypen.Leer);
   RasseAmZugNachLaden : SonstigeDatentypen.Rassen_Enum := SonstigeDatentypen.Leer;

   Schwierigkeitsgrad : SystemDatentypen.Schwierigkeitsgrad_Verwendet_Enum;
   Gewonnen : Boolean := False;
   WeiterSpielen : Boolean := False;
   
   -- Später über Nutzereingaben neu belegbar machen.
   type GrenzenArray is array (SonstigeDatentypen.Rassen_Verwendet_Enum'Range) of WichtigeRecords.GrenzenRecord;
   Grenzen : GrenzenArray := (others => SonstigesKonstanten.LeerGrenzen);
   
   IronmanName : Unbounded_Wide_Wide_String := To_Unbounded_Wide_Wide_String (Source => SystemKonstanten.LeerString);
   -- Zeug
   

   
   -- Einheiten
   type EinheitenGebautArray is array (SonstigeDatentypen.Rassen_Verwendet_Enum'Range, EinheitStadtDatentypen.MaximaleEinheiten'Range) of EinheitStadtRecords.EinheitenGebautRecord;
   EinheitenGebaut : EinheitenGebautArray := (others => (others => EinheitenKonstanten.LeerEinheit));
   -- Einheiten
   
   

   -- Städte
   type StadtGebautArray is array (SonstigeDatentypen.Rassen_Verwendet_Enum'Range, EinheitStadtDatentypen.MaximaleStädte'Range) of EinheitStadtRecords.StadtGebautRecord;
   StadtGebaut : StadtGebautArray := (others => (others => StadtKonstanten.LeerStadt));
   -- Städte
   
   

   -- Wichtiges Zeug
   type WichtigesArray is array (SonstigeDatentypen.Rassen_Verwendet_Enum'Range) of WichtigeRecords.WichtigesRecord;
   Wichtiges : WichtigesArray := (others => SonstigesKonstanten.LeerWichtigesZeug);
   
   type DiplomatieArray is array (SonstigeDatentypen.Rassen_Verwendet_Enum'Range, SonstigeDatentypen.Rassen_Verwendet_Enum'Range) of WichtigeRecords.DiplomatieRecord;
   Diplomatie : DiplomatieArray := (others => (others => SonstigesKonstanten.LeerDiplomatie));
   -- Wichtiges Zeug
                                               
end GlobaleVariablen;
